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

my $ipa_chars = $YPP->load_file('ipachars.yaml');

my $map = +{};

for my $char ( sort keys %$ipa_chars ) {
  my $ipas = to_aref $ipa_chars->{$char};
  for my $ipa ( @$ipas ) {
    my $descrs = $ipa->{descr};
    for my $descr ( @$descrs ) {
      for my $entry ( $map->{$descr}) {
        if ( defined $entry ) {
          my $chars = $entry->{ipa} = to_aref $entry->{ipa};
          push @$chars, $char;
        }
        else {
          $entry = +{
            descr => $descr,
            ipa => $char,
          };
        }
      }
    }
  }
}

$YPP->dump_file('ipa-descr2char.yaml', clone_bools $map);


      

