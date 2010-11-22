package Text::Socialize::Machine::Twitter;
BEGIN {
  $Text::Socialize::Machine::Twitter::VERSION = '0.001';
}
# ABSTRACT: Machine for generating a tweet out of a result and an URL

use Moo;

has maxlen => (
	is => 'ro',
	default => sub { 140 },
);

sub socialize {
	my ( $self, %params ) = @_;
	my $url = $params{url};
	my $text = $params{text};
	my @keywords = @{$params{keywords}};

	my $part = $text;
	$part .= ' '.$url if $url;
	my $count = length($part);
	my @parts = ( $part );
	if ($params{hashtags_at_end}) {
		for my $keyword (@keywords) {
			$keyword = lc($keyword);
			$keyword =~ s/[^\w]//ig;
			$keyword = '#'.$keyword;
			if ($count + 1 + length($keyword) < $self->maxlen) {
				$count += 1 + length($keyword);
				push @parts, $keyword;
			}
		}
	} else {
	}
	
	return join(" ",@parts);
}

1;

__END__
=pod

=head1 NAME

Text::Socialize::Machine::Twitter - Machine for generating a tweet out of a result and an URL

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudssus.de> L<http://www.raudssus.de/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by L<Raudssus Social Software|http://www.raudssus.de/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

