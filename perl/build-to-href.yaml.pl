#!/usr/bin/env perl

use 5.014;
# use utf8;
use utf8::all;
use strict;
use warnings;
use warnings FATAL => 'utf8';
use autodie;

# use open qw[ :utf8 :std ];

use lib 'Lingua-PRA/lib';
use Lingua::PRA::Constants;
use Clone::PP qw[clone];
use List::AllUtils qw[ partition_by ];

my @res;

for my $d ( '$defined_default', undef ) {
  for my $v ( {key => '$value'}, '$defined_non_href', undef) {
    for my $k ( 0, 1 ) {
      my $def_v = defined $v;
      my @us = $def_v ? (0) : (0, 1);
      for my $u ( @us ) {
        my %h = my %args = (
          '$thing' => $v,
          '$default' => $d,
          as_key => $k,
          keep_undef => $u,
        );
        my %r = ( args => \%args, result => \%h );
        $h{as_key} = defined($d) ? $k : 1;
        $h{keep_undef} = !$h{as_key} && $u;
        $h{'$thing'} //= {} unless $h{keep_undef};
        # $h{'$thing'} //= 'undef';
        unless ( 'HASH' eq ref $h{'$thing'} ) {
          $h{'$thing'} = $h{as_key}
          ? +{ $h{'$thing'} => $d }
          : +{ $d => $h{'$thing'} }
          ;
        }
        for my $r ( values %r ) {
          $r = clone $r;
          delete $r->{keep_undef} if $def_v;
        }
        push @res, clone \%r;
      }
    }
  }
}
          
my %by_res = partition_by { $YPP->dump_string($_->{result}) } @res;


my %by_thing = partition_by { $YPP->dump_string($_->[0]{result}{'$thing'}) } values %by_res;


my @groups = map {;
  my $l = $_;
  +{
    about => 'text',
    result => $l->[0]{result},
    args => [ map {; $_->{args} } @$l ],
  };
}
map {; @$_ } @by_thing{ sort keys %by_thing };

$YPP->dump_file('to-href.yaml', \@groups);
