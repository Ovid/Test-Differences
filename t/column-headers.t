use strict;
use warnings;

use Test::More;
use Config;
use Capture::Tiny qw(capture);

END { done_testing(); }

my($stdout, $stderr) = capture { system (
    $Config{perlpath}, (map { "-I$_" } (@INC)),
    't/script/default-headers'
) };

is(
    $stderr,
"
#   Failed test 'both the same'
#   at t/script/default-headers line 8.
# +----+-------+----------+
# | Elt|Got    |Expected  |
# +----+-------+----------+
# |   0|'foo'  |'foo'     |
# *   1|'bar'  |'baz'     *
# +----+-------+----------+
# Looks like you failed 1 test of 1.
",
    "got expected error output"
);

($stdout, $stderr) = capture { system (
    $Config{perlpath}, (map { "-I$_" } (@INC)),
    't/script/custom-headers'
) };

is(
    $stderr,
"
#   Failed test 'both the same'
#   at t/script/custom-headers line 8.
# +----+-------+-------+
# | Elt|Lard   |Chips  |
# +----+-------+-------+
# |   0|'foo'  |'foo'  |
# *   1|'bar'  |'baz'  *
# +----+-------+-------+
# Looks like you failed 1 test of 1.
",
    "got expected error output"
);

