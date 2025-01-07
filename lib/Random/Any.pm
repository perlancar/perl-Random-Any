package Random::Any;

use strict 'subs', 'vars';
#use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

my $warn;
my $sub;

sub rand(;$) {
    $sub->(@_);
}

sub import {
    my $pkg = shift;

    my $caller = caller();

    while (@_) {
        my $arg = shift;
        if ($arg eq '-warn') {
            $warn = shift;
        } elsif ($arg eq 'rand') {
            *{"$caller\::rand"} = \&rand;
        } else {
            die "'$_' is not exported by " . __PACKAGE__;
        }
    }

    $warn = $ENV{PERL_RANDOM_ANY_WARN} unless defined $warn;
    $warn = 1 unless defined $warn;

    unless ($sub) {
        if (eval { require Data::Entropy::Algorithms; 1 }) {
            $sub = \&Data::Entropy::Algorithms::rand;
        } else {
            warn __PACKAGE__ . ": Data::Entropy::Algorithms is not available: $@, falling back on builtin rand()" if $warn;
            $sub = \&CORE::rand;
        }
    }
}

1;
# ABSTRACT: Try to use Data::Entropy::Algorithms::rand(), fallback on builtin rand()

=head1 SYNOPSIS

 use Random::Any qw(rand);

 say rand();


=head1 DESCRIPTION

This module provides a single export C<rand()> that tries to use
L<Data::Entropy::Algorithms>'s C<rand()> first and, if that module is not
available, warns to STDERR and falls back on the builtin C<rand()>.

Note that whenever you can you are encouraged to use C<rand_int()> or
C<random_int()>, or C<rand_flt()> or C<random_float()> function instead. From
C<Data::Entropy::Algorithm>'s documentation:

"This function should not be used in any new code, because the kind of output
supplied by C<rand> is hardly ever the right thing to use. The C<int(rand($n))>
idiom to generate a random integer has non-uniform probabilities of generating
each possible value, except when C<$n> is a power of two. For floating point
numbers, C<rand> can't generate most representable numbers in its output range,
and the output is biased towards zero. In new code use C<rand_int> to generate
integers and "rand_flt" to generate floating point numbers."

Also, take a look at L<Random::Simple> instead of this module.


=head1 EXPORTS

=head2 -warn => bool

If true (the default) then emit a warning if Data::Entropy::Algorithms is not
available. To disable this warning, set to false.


=head1 FUNCTIONS

=head2 rand


=head1 ENVIRONMENT

=head2 PERL_RANDOM_ANY_WARN

Bool. Can be set to provide default value for C<-warn>.


=head1 SEE ALSO

L<Data::Entropy::Algorithms>

L<Random::Simple>
