package Lingua::PRA::Utils;

use 5.014;
use utf8;
use strict;
use warnings;

our $VERSION = 0.001;

use YAML::PP;
use Clone::PP qw[clone];
use CloneBool qw[clone_bools];
use JSON::PP;
use Const::Fast;
use charnames qw[:full :short];

BEGIN {
  no warnings 'once';
  sub ord2name;
  sub name2char;
  sub true;
  sub false;
  sub is_bool;
  *ord2name = \&charnames::viacode;
  *name2char = \&charnames::string_vianame;
  *true = *JSON::PP::true;
  *false = *JSON::PP::false;
  *is_bool = *JSON::PP::is_bool;

  sub dotted_circle ($) {
    my($c) = @_;
    $c =~ s{\A(?=\pM)}{◌};
    return $c;
  }
  sub no_dotted_circle ($) {
    my($c) = @_;
    $c =~ s{◌(?=\pM)}{}g;
    return $c;
  }
  sub no_modif_circle ($) {
    my($c) = @_;
    $c =~ s{◌(?=\p{Lm})}{}g;
    return $c;
  }
  sub ord2code ($) { sprintf 'U+%04X', $_[0] }
  sub char2name ($) { ord2name ord shift }
  sub char2code ($) { ord2code ord shift }
}

const our $YPP => YAML::PP->new(
  schema => ['JSON'],
  boolean => 'JSON::PP',
);

use Exporter::Shiny qw[
  $YPP
  char2code
  char2name
  clone
  clone_bools
  codes2chars
  dotted_circle
  expand_char
  false
  is_bool
  name2char
  no_dotted_circle
  no_modif_circle
  ord2code
  ord2name
  str2codes
  str2names
  to_aref
  to_href
  true
];

our %EXPORT_TAGS = (
  bools => [
    qw(
      clone
      clone_bools
      false
      is_bool
      true
    )
  ],
  chars => [
    qw(
      char2code
      char2name
      codes2chars
      expand_char
      name2char
      ord2code
      ord2name
      str2codes
      str2names
    )
  ],
  circle => [
    qw(
      dotted_circle
      no_dotted_circle
      no_modif_circle
    )
  ],
  data => [
    qw(
      to_aref
      to_href
    )
  ],
);



sub expand_char ($);

sub to_aref ($;%) {
  my($val, %opt) = @_;
  $opt{clone} //= 1;
  $val //= {};
  $val = [$val] unless 'ARRAY' eq ref $val;
  $val = clone($val) if $opt{clone};
  return $val;
}

sub to_href ($$;%) {
  my($val, $default, %opt) = @_;
  $opt{clone} //= 1;
  $opt{key} //= 0;
  $val //= +{};
  unless ( 'HASH' eq ref $val ) {
    $val = $opt{key}
    ? +{ $val => $default }
    : +{ $default => $val }
  }
  $val = clone($val) if $opt{clone};
  return $val;
}

sub str2codes {
  my $str = no_dotted_circle shift // return undef;
  return [map {; char2code $_} $str =~ m{ \S }gx];

}

sub str2names {
  my $str = no_dotted_circle shift // return undef;
  return [map {; char2name $_} $str =~ m{ \S }gx];
}

sub expand_char ($) {
  my $data = shift // return undef;
  $data = to_href $data, 'char';
  my $char = no_dotted_circle $data->{char} // return undef;
  $data->{char} = dotted_circle $char;
  $data->{code} = char2code $char;
  $data->{name} = char2name $char;
  return $data;
}

sub codes2chars {
  my $chars = to_aref shift;
  for my $char ( @$chars ) {
    $char // next;
    $char = expand_char name2char $char;
  }
  return $chars;
}


1;
