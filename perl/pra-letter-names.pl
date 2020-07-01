#!/usr/bin/env perl

use 5.014;
# use utf8;
use utf8::all;
use strict;
use warnings;
use warnings FATAL => 'utf8';
use autodie;

# use open qw[ :utf8 :std ];

use Carp;
use YAML::PP;
use Time::Moment;
use Path::Tiny qw[path cwd];

my $letter_re = qr{^(?!\p{Lm})\pL$};
my $vowel_re = qr{^[aeiou]$};
my $eff_re = qr{^[flmnrs]$}i;
my $skip_re = qr{\P{ASCII}};

my $ypp = YAML::PP->new(
  schema => ['JSON'],
  boolean => 'JSON::PP',
);

my $now = Time::Moment->now->strftime('%F-%T') =~ s{\W+}{-}gr;

say $now;

my $file = cwd->child('pra.yaml');

$file->is_file or croak "Not found or not a file: $file";

my $bak = cwd->child("backup/$now/$file");
$bak->parent->mkpath;
$file->copy($bak);

my $data = $ypp->load_file("$file");

my $letters = $data->{letters}
  or croak '$pra_data->{letters} not found';

while ( my($id, $letter) = each %$letters ) {
  next if exists $letter->{pra_name};
  my $char = $letter->{char} // croak "{'$id'}->{char} not found";
  my $c = $char->{char} // do {
    my $code = $char->{code} //= croak "{'$id'}->{char}->{code} not found";
    charnames::string_vianame($code) // croak "Unknown char code for '$id': $code";
  };
  $c =~ $letter_re or croak "{'$id'}->{char}->{char} not a letter";
  $letter->{pra_name}
    = ($c =~ $skip_re)  ? undef
    : ($c =~ $vowel_re) ? "$c$c"
    : ($c =~ $eff_re)
    ? ["${c}a", "${c}e", "e$c"]
    : ["${c}a", "${c}e"];
}

$ypp->dump_file("$file", $data);

