use Test;
use silently;

plan 4;

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
is $captured.err.lines.join(chr(10)),
  "shitty\nbleh\n  in block  at t/01-basic.t line 24",
  'ERR captured ok';

# vim: expandtab shiftwidth=4
