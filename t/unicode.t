#!perl

use strict;
use warnings;

use Capture::Tiny qw(capture);

use Test::More;
use Test::Differences;

plan tests => 2;

eq_or_diff(
    ["\N{U+2603}", "\N{U+1F4A9}"],
    ["\N{U+2603}", "\N{U+1F4A9}"]
);

my($stdout, $stderr) = capture { system (
    $^X, (map { "-I$_" } (@INC)),
    qw(-Mstrict -Mwarnings -MTest::More -MTest::Differences),
    '-e', '
        END { done_testing(); }
        eq_or_diff(
            [        "\\N{U+2603}", "\\N{U+1F4A9}"],
            [reverse "\\N{U+2603}", "\\N{U+1F4A9}"]
        )
    '
) };

is(
    $stderr,
'
#   Failed test at -e line 3.
# +----+---------------+----------------+
# | Elt|Got            |Expected        |
# +----+---------------+----------------+
# |   0|[              |[               |
# *   1|  "\x{2603}",  |  "\x{1f4a9}",  *
# *   2|  "\x{1f4a9}"  |  "\x{2603}"    *
# |   3|]              |]               |
# +----+---------------+----------------+
# Looks like you failed 1 test of 1.
',
    "got expected error output"
);


