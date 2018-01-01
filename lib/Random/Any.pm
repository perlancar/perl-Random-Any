package Random::Any;

# DATE
# VERSION

use strict;
#use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(rand);

my $sub;

sub rand(;$) {
    unless ($sub) {
        if (eval { require Math::Random::Secure; 1 }) {
            $sub = \&Math::Random::Secure::rand;
        } else {
            $sub = \&CORE::rand;
        }
    }
    $sub->(@_);
}

1;
# ABSTRACT: Try to use Math::Random::Secure::rand(), fallback on builtin rand()

=head1 SYNOPSIS

 use Random::Any qw(rand);

 say rand();


=head1 DESCRIPTION

This module provides a single export C<rand()> that tries to use
L<Math::Random::Secure>'s C<rand()> first and, if that module is not available,
falls back on the builtin rand().


=head1 FUNCTIONS

=head2 rand


=head1 SEE ALSO

L<Math::Random::Secure>
