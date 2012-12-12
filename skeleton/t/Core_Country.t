#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use Test::More;

use lib "$FindBin::Bin/../lib/";

use Web::Core::Country;

my $countries = Web::Core::Country::CountryNames('fr');
foreach my $c (@{$countries})
{
	printf "%s\n", $c->{name};
}

done_testing(1);
