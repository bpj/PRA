#!/usr/bin/env perl

use 5.016;
# use utf8;
use utf8::all;
use strict;
use warnings;
use warnings FATAL => 'utf8';
use autodie;

# use open qw[ :utf8 :std ];

use lib 'lib';
use Lingua::PRA::Constants;
use Lingua::PRA::Utils -charnames;
use charnames qw[ :full :short :loose];
use Hash::Merge::Simple qw[ clone_merge ];
use Time::Moment;

use Unicode::Normalize qw[NFC NFD];

sub characterize {
  my $str = NFD( shift // "" );
  my($char) = $str =~ m{\A(.)}s;
  return $char;
}

sub get_case {
  my($char) = @_;
  my $lc = lc $char;
  my $uc = uc $char;
  my $tc = ucfirst $lc;
  my %case;
  if ( $uc eq $char ) {
    if ( $lc eq $uc ) {
      $case{nc} = $char;
    }
    else {
      %case = (
        uc => $uc,
        lc => $lc,
      );
    }
    if ( $tc ne $uc ) {
      $case{tc} = $tc;
    }
  }
  return \%case if keys %case;
  return;
}
  
my $today = Time::Moment->now_utc->strftime('%F');

my $common = +{
  changes => [
    +{
        date => $today,
        by => 'bpj',
        summary => 'Entered',
    },
  ],
};


my @ranges = (
  +{
    type => 'letter',
    from => ord('A'),
    to => ord('Z'),
    pre => +{
      ( map {;
          $_ => +{
            status => +{
              alt_only => $True, 
              in_use => $False,
            },
          },
        }
        qw[ c j q x ]
      )
    },
    default => +{ status => +{ in_use => $True }, },
  },
  +{
    type => 'letter',
    chars => [qw(Æ Œ Ə Ɛ Ɔ Ʌ Ŋ Ʒ Ł)],
    default => +{
      status => +{
        in_use => $True,
        alt_only => $True,
      },
    },
  },
  +{
    type => 'modifier',
    from => 0x2b0,
    to => 0x2ff,
    default => +{ status => +{ in_use => $False }, },
  },
  +{
    type => 'mark',
    from => 0x300,
    to => 0x36f,
    default => +{
      status => +{ in_use => $False },
    },
  },
);

my %map;

for my $range ( @ranges ) {
  my $chars = $range->{chars} //
    [ map {; chr $_ } $range->{from} .. $range->{to} ]; 
    CHAR:
  for my $char (@$chars) {
    my $case = get_case($char) // next CHAR;
    CASE:
    for my $c ( values %$case ) {
      my $z = characterize($c);
      next CHAR  unless $z eq $c;
      my $o = ord $c;
      my $p = sprintf 'U+%04X', $o;
      my $n = name($o);
      my $x = ($c =~ s{\A(?=\pM)}{x}) ? $True : $False;
      $c = +{      
        char => $c,
        x => $x,
        name => $n,
        point => $p,
      };
    }
    my $id = delete($case->{lc}) // delete($case->{nc});
    $id->{case} = $case if keys %$case;
    $id->{type} = $range->{type};
    my $entry = clone_merge(
      $range->{default} // +{}, $id, $common, $range->{pre}{$id->{char}} // +{},
    );
    if ( 'mark' eq $range->{type} ) {
      for my $cv ( qw[ cons vowel]) {
        $entry->{$cv} = +{
          type => "$cv-$range->{type}",
          value => [
            +{
              descr => undef,
              ipa => undef,
              class => 'feat',
              prec => [undef],
            },
          ]
        };
      }
    }
    else {
      $entry->{value} = [
        +{
          descr => undef,
          ipa => undef,
          prec => [undef],
        },
      ];
      if ( 'letter' eq $range->{type} ) {
        my $cv = ($entry->{char} =~ /[aeiouæœəɛɔʌ]/) ? 'vowel' : 'cons';
        $entry->{value}[0]{class} = $cv;
        $entry->{value}[0]{ipa} = $entry->{char};
        $entry->{value}[0]{prec}[0] = 'common';
      }
    }
    $map{$range->{type}}{$entry->{char}} = $entry;
  }
}

$YPP->dump_file('pra.yaml', \%map);
