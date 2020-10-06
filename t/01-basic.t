use Test;
use silently;

plan 5;

my $out-pos = $*OUT.tell;
silently {
    say "foo";
    print "foo more";
    printf "foo: %d", 42;
}
is $*OUT.tell, $out-pos, 'did nothing get output on STDOUT';

my $err-pos = $*ERR.tell;
silently {
    note "bar";
    warn "knock knock";
}
is $*ERR.tell, $err-pos, 'did nothing get output on STDERR';

my $captured = silently {
    say "hello world";
    note "shitty";
    warn "bleh";
    printf "zippodak: %d", 666;
}

is $captured.out.lines.join(chr(10)),
  "hello world\nzippodak: 666",
  'OUT captured ok';
ok $captured.err.contains('shitty'), 'ERR captured ok (1)';
ok $captured.err.contains('bleh'),   'ERR captured ok (2)';

# vim: expandtab shiftwidth=4
