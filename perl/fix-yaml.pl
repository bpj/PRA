#!/usr/bin/env perl

use 5.014;
# use utf8;
use utf8::all;
use strict;
use warnings;
use warnings FATAL => 'utf8';
use autodie;

# use open qw[ :utf8 :std ];

my @fixes = (
  sub {
    delete $_->{x} unless $_->{x};
  },
);

rmap_hash {
  for my $fix ( @fixes ) {
    $fix->();
  }
} $data;

