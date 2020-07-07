#!/usr/bin/env perl
#===============================================================================
#
#         FILE: simple-translit.pl
#
#        USAGE: ./simple-translit.pl
#
#  DESCRIPTION: Simple "transliteration" using longest-leftmost matching
#               and substitution, e.g. to replace (sequences of) punctuation
#               characters with combining diacritical marks, using simple
#               YAML or JSON files as configuration.
#
#               Some (unenforced) conventions exist:
#
#               -   The (unescaped) ASCII characters `
#
#                       ! " # $ & * - @ [ ] ^ _ `
#
#                   are reserved as "metacharacters" to be used only for
#                   "markup" and in combination with other characters.
#
#               -   Use mappings which replace sequences of the ASCII double
#                   quote character `"` U+0022 followed by another (ASCII)
#                   character with that other character, so that if for
#                   example `/` is mapped to the combining acute accent
#                   one can type `"/` to get an actual `/`, and one can
#                   (usually must) type `""` to get an actual ASCII double
#                   quote. There are option to generate such "escapes" for
#                   all single character mappings and/or all printable
#                   ASCII characters.
#
#               -   Use the `&` ampersand character followed by two other
#                   characters for "digraphs", e.g. `&th` to be replaced
#                   by þ or θ. "Digraphs" of more than two characters are
#                   by convention *both* pfreceded by an & and enclosed
#                   in square bracketş e.g. `&[k-/]` for ꝅ̇.
#
#                   Mapping files may contain a top-level field `digraphs`
#                   listing digraphs without their `& [ ]` "appendages",
#                   which will be automatically added as needed.
#
#               -   Use `$` or `` ` `` before another character as
#                   "short digraphs", generally for characters for which
#                   actual digraphs make little sense, e.g. `` $e `e `o `f ``
#                   for ə ɛ ɔ ꝼ. By convention `` `- `` is used for the
#                   en dash while `&--` is used for the em dash.
#
#               -   Use `^ - _` before another punctuation character so
#                   create notations for "variants", generally so that
#                   `^` denotes adiacritic "above", `-` denotes a
#                   "strikethrough" or "attached" diacritic and
#                   `_` denotes a Ndiacritic "below".  For example if
#                   `,` is used for the cedilla `_,` may be used for
#                   the comma below and `^,` for the comma above,
#                   and when `/` is used for the acute `-/` may be used
#                   for the strike-through slash. The combinations `$^`
#                   and `$_` are conventionally used as "prefixes" for
#                   superscript and subscript letters, e.g. `$^j` and `$_j`.
#
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Benct Philip Jonsson (bpj), bpjonsson@gmail.com
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 2020-07-01 16:48
#     REVISION: ---
#===============================================================================

# use utf8;      # so literals and identifiers can be in UTF-8
use utf8::all;
use autodie 2.26;
use 5.014;
use strict;
use warnings;
use warnings  qw(FATAL utf8);    # fatalize encoding glitches
# use open      qw(:std :utf8);    # undeclared streams in UTF-8
# use charnames qw(:full :short);  # unneeded in v5.16

use Getopt::Long::Descriptive;
use YAML::PP;

my $brackets_re = qr/^([\pP\pS]+)\s+([\pP\pS]+)$/;

my($opt,$usage) = describe_options(
    '%c %o <input>',
    [   'escape-ascii|a!',
        'Create escapes for single, non-blank ASCII characters.',
        +{ default => 1 },
    ],
    [   'escape-single|e!',
        'Create escapes for single, "source-side" characters.',
        +{ default => 1 },
    ],
    [   'escape-char|E=s',
        'The character to use for single-character escapes.',
        +{ default => '"', regex => qr/^[\pP\pS]$/ },
    ],
    [   'digraph-char|d=s',
        'Prefix character for digraphs',
        +{ default => '&', regex => qr/^[\pP\pS]$/ },
    ],
    [   'digraph-brackets|D=s',
        'Bracket characters for digraphs (a punctuation character pair).',
        +{ default => '[]', regex => qr/^[\pP\pS]{2}$/ },
    ],
    [   'create-case|c!',
        'Automatically create upper/lower/title case variants.',
    ],
    [   'brackets|b=s',
        'Bracket characters for tagged runs (two sequences of punctuation characters separated by whitespace).',
        +{ default => '{{ }}', regex => $brackets_re },
    ],
    [
        'tag-sep|t=s',
        'Punctuation character(s) which separate(s) tags from the following text.',
        +{ default => '@', regex => qr/^[\pP\pS]+$/ },
    ],
    [   'map|m=s',
        'Name of a single mapping file to use for the whole input.',
    ],
    [   'map-tag|M=s%',
        'Define a TAG=MAP-FILE pair for use with tagged runs.',
    ],
