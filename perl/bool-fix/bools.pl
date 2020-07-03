#!/usr/bin/env perl

use 5.014;
# use utf8;
use utf8::all;
use strict;
use warnings;
use warnings FATAL => 'utf8';
use autodie;

# use open qw[ :utf8 :std ];

use lib '.';
use YAML::PP;
use CloneBool qw[clone_bools];

my $ypp = YAML::PP->new(
  schema => ['JSON'],
  boolean => 'JSON::PP',
);

my $data = $ypp->load_file('bools.yaml');

$data = clone_bools $data;

$ypp->dump_file('bools1.yaml', $data);



