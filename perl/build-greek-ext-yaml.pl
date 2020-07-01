#!/usr/bin/env perl

use 5.014;
# use utf8;
use utf8::all;
use strict;
use warnings;
use warnings FATAL => 'utf8';
use autodie;

# use open qw[ :utf8 :std ];

use Tie::Hash::Code qw[code_hash];
use Text::Unidecode qw[ unidecode];
use charnames qw[ :full :short ];
use Unicode::Normalize qw[ NFD ];

code_hash my %d => sub {
  unidecode( shift );
};

code_hash my %c => sub {
  chr shift
};

code_hash my %c2n => sub {
  charnames::viacode(ord shift);
};

code_hash my %c2u => sub {
  my $ord = ord shift;
  my $fmt = ($ord > 0xffff)
  ? '"\U%08X"' : '"\u%04X"';
  return sprintf $fmt, $ord;
};

code_hash my %n => \&charnames::viacode;

# Map chars to a hash so as to get one entry per char
my %chars = map {; $_ => 1 } 
# Decompose to get marks as separate characters
# and "extract" the chars
map {; NFD(chr $_) =~ m{.}g }
# Filter out codepoints without a name
grep { $n{$_} }
# For codepoints in the Greek Extended block
0x1f00 .. 0x1fff;

say "$c2u{$_}: '$d{$_}' # $c2n{$_}"
for sort keys %chars;

__END__

$n{$_} and say "'$d{chr $_}': '$n{$_}'" for
0x391 .. 0x3a9, 0x3b1 .. 0x3c9, 0x1f00 .. 0x1fff;
# 0x410 .. 0x42f, 0x430 .. 0x44f;

say '---';

# say sprintf q{'%s': 'U+%04X'}, unidecode(chr $_), $_ for 0x410 .. 0x42f, 0x430 .. 0x44f;


