package Text::Socialize::Result;
BEGIN {
  $Text::Socialize::Result::VERSION = '0.001';
}
# ABSTRACT: Class for the result of an information analyze

use Moo;

has information => (
	is => 'ro',
	required => 1,
);

has keywords => (
	is => 'ro',
	default => sub {[]},
);

has machine => (
	is => 'ro',
	predicate => 'has_machine',
);

1;
__END__
=pod

=head1 NAME

Text::Socialize::Result - Class for the result of an information analyze

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudssus.de> L<http://www.raudssus.de/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by L<Raudssus Social Software|http://www.raudssus.de/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

