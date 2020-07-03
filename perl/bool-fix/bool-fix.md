Meanwhile I came up with a less error prone  fix which actually clones the booleans in the Perl data so that they aren't all references to the same object anymore.

``````perl
package CloneBool;

use 5.014;
use utf8;
use strict;
use warnings;

our $VERSION = 0.001;

use Data::Rmap qw[rmap_to :types];
use Scalar::Util qw[blessed];

use Exporter::Shiny qw[ clone_bools ];

sub _clone_bool {
  my($v) = @_;
  my $class = blessed($v) || return $v;
  $class->isa('JSON::PP::Boolean') || return $v;
  my $copy = $$v;
  return bless \$copy => $class;
}

sub clone_bools {
  my($data) = @_;
  rmap_to {
    my $c = $_;
    my $ref = ref $c;
    if ( 'HASH' eq $ref ) {
      $c = +{ map {; $_ => _clone_bool $c->{$_} } keys %$c };
    }
    elsif ( 'ARRAY' eq $ref ) {
      $c = [ map {; _clone_bool $_ } @$_ ];
    }
    $_ = $c;
  } HASH|ARRAY, $data;
  return $data;
}

1;
``````

Usage:

``````perl
#!/usr/bin/env perl

use 5.014;
use utf8;
use strict;
use warnings;

use YAML::PP;
use CloneBool qw[clone_bools];

my $ypp = YAML::PP->new(
  schema => ['JSON'],
  boolean => 'JSON::PP',
);

my $data = $ypp->load_file('data.yaml');

$data = clone_bools $data;

$ypp->dump_file('data1.yaml', $data);
``````


