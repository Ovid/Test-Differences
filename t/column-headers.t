#!perl

use strict;
use warnings;

use Test::More;
use Capture::Tiny qw(capture);

END { done_testing(); }

my($stdout, $stderr) = capture { system (
    $^X, (map { "-I$_" } (@INC)),
    't/script/default-headers'
) };
$stderr =~ s/^\s+//; # see https://github.com/Ovid/Test-Differences/issues/15
is(
    $stderr,
"#   Failed test 'both the same'
#   at t/script/default-headers line 8.
# +----+----------------+----------------+
# | Elt|Got             |Expected        |
# +----+----------------+----------------+
# |   0|{               |{               |
# *   1|  foo => 'bar'  |  foo => 'baz'  *
# |   2|}               |}               |
# +----+----------------+----------------+
# Looks like you failed 1 test of 1.
",
    "got expected error output"
);

($stdout, $stderr) = capture { system (
    $^X, (map { "-I$_" } (@INC)),
    't/script/custom-headers'
) };
$stderr =~ s/^\s+//;
is(
    $stderr,
"#   Failed test 'both the same'
#   at t/script/custom-headers line 8.
# +----+----------------+----------------+
# | Elt|Lard            |Chips           |
# +----+----------------+----------------+
# |   0|{               |{               |
# *   1|  foo => 'bar'  |  foo => 'baz'  *
# |   2|}               |}               |
# +----+----------------+----------------+
# Looks like you failed 1 test of 1.
",
    "got expected error output"
);
