package Text::Socialize::KeywordContainer;
BEGIN {
  $Text::Socialize::KeywordContainer::VERSION = '0.001';
}
# ABSTRACT: Abstraction for a container of KeywordLists

use Moo;

has keywordlists => (
	is => 'ro',
	required => 1,
);

has shuffle => (
	is => 'ro',
	default => sub { 1 },
);

has use_content => (
	is => 'ro',
	default => sub { 1 },
);

sub keywords_on_information {
	my ( $self, $information ) = @_;
	my $text = $information->text;
	$text .= '      '.$information->content if $information->has_content and $self->use_content;
	my @keywords;
	my @keywordlists;
	my $klpos = 0;
	for (@{$self->keywordlists}) {
		push @keywordlists, [ $_, $_->count ];
	}
	while(@keywordlists) {
		my $klcount = scalar @keywordlists;
		my $idx = $klpos % $klcount;
		my $kl = $keywordlists[$idx];
		$klpos++;
		for (@{$kl->[0]->keywords}[$kl->[0]->count - $kl->[1],$kl->[0]->count - 1]) {
			$kl->[1]--;
			splice(@keywordlists, $idx, 1) if (!$kl->[1]);
			if ($text =~ m/(^|[^\w]|[^\#])($_)/i) {
				push @keywords, $2;
				last if $self->shuffle;
			}
		}
	}
	return @keywords;
}

1;
__END__
=pod

=head1 NAME

Text::Socialize::KeywordContainer - Abstraction for a container of KeywordLists

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudssus.de> L<http://www.raudssus.de/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by L<Raudssus Social Software|http://www.raudssus.de/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

