package Text::Socialize::Machine;
BEGIN {
  $Text::Socialize::Machine::VERSION = '0.001';
}
# ABSTRACT: The machine which does the work for you...

use Moo;

use Text::Socialize::Result;

has keywordcontainers => (
	is => 'rw',
	default => sub {[]},
);

has socializer => (
	is => 'rw',
	default => sub {{}},
);

sub analyze_information {
	my ( $self, $info ) = @_;
	
	my @keywords;

	for (@{$self->keywordcontainers}) {
		push @keywords, $_->keywords_on_information($info);
	}
	
	@keywords = $self->modify_keywords(@keywords);

	return Text::Socialize::Result->new({
		information => $info,
		keywords => \@keywords,
		machine => $self,
	});
}

sub socialize_result {
	my ( $self, $submachine, $result, $params ) = @_;
	if (!$self->socializer->{$submachine}) {
		eval {
			eval "require Text::Socialize::Machine::$submachine;";
			eval "Text::Socialize::Machine::$submachine->import;";
		};
		die "Error on loading Text::Socialize::Machine::".$submachine.": ".$@ if ($@);
		$self->socializer->{$submachine} = eval "Text::Socialize::Machine::$submachine->new();";
	}
	$params->{text} = $result->information->text;
	$params->{keywords} = $result->keywords;
	return $self->socializer->{$submachine}->socialize(%{$params});
}

sub modify_keywords {
	my ( $self, @keywords ) = @_;
	return @keywords;
}

1;
__END__
=pod

=head1 NAME

Text::Socialize::Machine - The machine which does the work for you...

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudssus.de> L<http://www.raudssus.de/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by L<Raudssus Social Software|http://www.raudssus.de/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

