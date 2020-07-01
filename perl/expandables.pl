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
use Data::Rmap qw[rmap_hash];
use Clone::PP qw[clone];

use Getopt::Long;

my($input, $output) = @_;

$output //= "expanded-$input";

my %expandable = (
  arrayOr => \&arrayOr,
);

sub arrayOr {
  my($def) = @_;
  my $array_def = +{ 
    type => 'array',
    items => $def,
  };
  if ( my $obj = delete $def->{_object}) {
    my %obj_def;
    $obj_def{type} = 'object';
    my $props = $obj_def{properties} = $obj->{properties};
    my $prop = $obj->{_property} // croak 'expected _object/_property in arrayOr';
    $props->{$prop} = $array_def;
    $array_def = \%obj_def;
  }
  return +{ oneOf => [ $def, $array_def ] };
}

my $ypp = YAML::PP->new(
  schema => ['JSON'],
  booleans => 'JSON::PP',
);

my $data = $ypp->load_file($input);

rmap_hash {
  while ( my($key, $sub) = each %expandable ) {
    exists $_->{$key} or next;
    $_ = $sub->(clone $_->{$key});
    return;
  }
} $data;

$ypp->dump_file( $output, $data );
