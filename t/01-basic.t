#!perl

use strict;
use warnings;
use Test::More 0.98;

use Random::Any qw(rand);

ok(rand() < 1);

done_testing;
