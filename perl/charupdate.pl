#!/usr/bin/env perl

use 5.014;
# use utf8;
use utf8::all;
use strict;
use warnings;
use warnings FATAL => 'utf8';
use autodie;

# use open qw[ :utf8 :std ];

use YAML::PP;

my $ypp = YAML::PP->new(
  schema => ['JSON'],
  boolean => 'JSON::PP',
);

my @fields = qw[char name code];

my $data = $ypp->load_file('pra.yaml');

TYPE:
for my $type ( values %$data ) {
  ITEM:
  for my $item ( values %$type ) {
    if ( grep { exists $item->{$_} } @fields ) {
      my %char = (
        map {; $_ => delete $item->{$_} } @fields
      );
      $item->{char} = \%char;
      next ITEM;
    }
  }
}

$ypp->dump_file('pra.yaml', $data);



