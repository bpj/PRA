#!/usr/bin/env perl

use 5.014;
# use utf8;
use utf8::all;
use strict;
use warnings;
use warnings FATAL => 'utf8';
use autodie;

# use open qw[ :utf8 :std ];

use lib::relative './lib';

use Lingua::PRA::Utils qw[$YPP clone clone_bools -data];

use XXX;

my $pra = $YPP->load_file('pra.yaml');

my $ipa_chars = $YPP->load_file('ipachars.yaml');

for my $letters ( $pra->{letters} ) {
  for my $letter ( values %$letters ) {
    next unless exists $letter->{value} and defined $letter->{value};
    VALS:
    for my $vals ( $letter->{value} ) {
      my $old_vals = to_aref $vals;
      VAL:
      for my $val ( @$old_vals ) {
        if ( defined $val->{descr} ) {
          $val->{descr} = to_aref $val->{descr};
          next VAL;
        }
        my $ipas = to_aref $val->{ipa};
        my @descrs;
        IPA:
        for my $ipa ( grep {defined} @$ipas ) {
          next if ref $ipa;
          my $ic = $ipa_chars->{$ipa} // next IPA;
          next if 'ARRAY' eq ref $ic;
          my $descr = $ic->{descr} // next IPA;
          if ( 'ARRAY' eq ref $descr ) {
            $descr = $descr->[-1];
              # if 1 == @$descr;
          }
          push @descrs, $descr;
        }
        $val->{descr} = \@descrs
      }
      $vals = (@$old_vals > 1) ? $old_vals : $old_vals->[0];
    }
  }
}

$YPP->dump_file('pra.yaml', clone_bools $pra);


      

