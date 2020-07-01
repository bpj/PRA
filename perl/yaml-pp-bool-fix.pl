#! /usr/bin/env perl

use 5.014;
use utf8::all;
use strict;
use warnings;

my $documentation = <<'----';
yaml-pp-bool-fix.pl - convert references to explicit
booleans in YAML::PP output

See: https://git.io/JfFkB

CUSTOMARY WARNING: always backup/commit before doing
this!

WARNING: This isn't safe for
lines in block scalars which look like `KEY:
*NUMBER` or `- *NUMBER`. We deem that our data don't
contain any such lines but consider this!

Description:

When your data contains JSON::PP or boolean.pm boolean
objects YAML::PP represents most of them as YAML
references because all those objects are references to a
single instance for each of `true` and `false`. This
script tries to fix that as safely as can be reasonably
done with a text filter.

Usage:

    perl yaml-pp-bool-fix.pl -t INT -f INT input.yaml >output.yaml

Options:

*   -t [INT], --true[=INT]

    The INT (a number)  which occurs in `&INT true`
    somewhere in your YAML file.

*   -f [INT], --false[=INT]

    The INT (a number)  which occurs in `&INT false`
    somewhere in your YAML file.

*   -h, --help

    Print this text and exit.

Defaults: --true=1 and --false=2
because those are the most typical values in
our data.

If either kind of booleans are missing in your data
pass the option without any argument or with 0 (zero) as
argument, in which case that kind of boolean reference will
be ignored.  This should be safe as YAML::PP apparently
starts its reference numbers at 1.

NOTE: Don't delete your `&2 false` or whatever
anchors, since there may be leftovers which this fix
doesn't catch, however unlikely.
----

use Carp;
use Getopt::Long;

my %opt = (
    true  => 1,
    false => 2,
);

GetOptions(
    \%opt,
    'true|t:i',
    'false|f:i',
    'help|h',
) or croak "Bad options!\n\n$documentation";

if ( $opt{help} ) {
    print $documentation;
    exit;
}

for my $key ( keys %opt ) {
    delete $opt{$key} unless $opt{$key};
}

my %bool = reverse %opt;

my $ref_re = qr{
    ^ \h* (?: [\pL\pN\pM_]+ \: | \- \h+ )
        \K \h*
        (?<ref> \* (?<num> \d+ ) )
    \h* $
}mx;

while (<>) {
    chomp;
    s{$ref_re}{ $bool{$+{num}} or $+{ref} }e;
    say $_;
}
