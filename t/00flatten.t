use Test::More;

use Test::Differences;

sub flatten($) {
    my $out = join "|",
      @{
        Test::Differences::_flatten( Test::Differences::_grok_type( $_[0] ),
            $_[0] )
      };
    $out =~ s/ +//g;
    $out;
}
## Complex data structures are not flattened, they're dumped, so don't
## test that here.
my @cases = (
    "a"         => "'a'",
    "a\nb\n"    => "'a\n|b\n|'",
    [qw( a b )] => "'a'|'b'",
    [ [qw( a b )], [qw(c d)] ] => "'a','b'|'c','d'",
    [ { a => 0, b => 1 }, { a => 2, c => 3 } ] =>
      "'a','b','c'|0,1,undef|2,undef,3",
    [ 1, undef, "undef" ] => "1|undef|'undef'",
);

plan tests => @cases / 2;
while ( my ( $data, $result ) = splice @cases, 0, 2 ) {
    is flatten $data, $result, $result;
}
