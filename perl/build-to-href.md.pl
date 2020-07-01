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

my $data = $YPP->load_file('to-href.yaml');

for my $h ( @$data ) {
  my $about = delete $h->{about};
  next if 'text' eq $about;
  my $yaml = $YPP->dump_string(clone $h);
  $yaml =~ s{\bnull\b}{undef}g;
  $yaml =~ s/^---.*\n//; 
  $yaml = "``````yaml\n$yaml``````";
  $yaml =~ s{^}{    }mg;
  print "-   $about\n\n$yaml\n\n";
}
