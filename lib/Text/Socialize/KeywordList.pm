package Text::Socialize::KeywordList;
BEGIN {
  $Text::Socialize::KeywordList::VERSION = '0.001';
}
# ABSTRACT: Primitive KeywordList class

use Moo;

has keywords => (
	is => 'ro',
	default => sub {[]},
);

sub count {
	scalar @{shift->keywords};
}

1;
__END__
=pod

=head1 NAME

Text::Socialize::KeywordList - Primitive KeywordList class

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudssus.de> L<http://www.raudssus.de/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by L<Raudssus Social Software|http://www.raudssus.de/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

