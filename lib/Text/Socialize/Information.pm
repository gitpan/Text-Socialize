package Text::Socialize::Information;
BEGIN {
  $Text::Socialize::Information::VERSION = '0.001';
}
# ABSTRACT: Clss for a new information which needs to be transformed

use Moo;

has text => (
	is => 'ro',
	required => 1,
);

has content => (
	is => 'ro',
	predicate => 'has_content',
);

1;

__END__
=pod

=head1 NAME

Text::Socialize::Information - Clss for a new information which needs to be transformed

=head1 VERSION

version 0.001

=head1 AUTHOR

Torsten Raudssus <torsten@raudssus.de> L<http://www.raudssus.de/>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by L<Raudssus Social Software|http://www.raudssus.de/>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

