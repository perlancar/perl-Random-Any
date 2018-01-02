package Random::Any;

# DATE
# VERSION

use strict 'subs', 'vars';
#use warnings;

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

    unless ($sub) {
        if (eval { require Math::Random::Secure; 1 }) {
            $sub = \&Math::Random::Secure::rand;
        } else {
            warn __PACKAGE__ . ": Math::Random::Secure is not available: $@, falling back on builtin rand()" if $warn;
            $sub = \&CORE::rand;
        }
    }
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


=head1 EXPORTS

=head2 -warn => bool

Can be set to true to emit a warning if Math::Random::Secure is not available.


=head1 FUNCTIONS

=head2 rand


=head1 SEE ALSO

L<Math::Random::Secure>
