use Trap:auth<zef:lizmat>:ver<0.0.1+>;

my class Captured {
    has $!out;
    has $!err;

    method SET-SELF(\out, \err) {
        out = $!out := Trap.new;
        err = $!err := Trap.new;
        self
    }
    method new(\out, \err) { self.CREATE.SET-SELF(out, err) }

    method out(--> str) { $!out.text }
    method err(--> str) { $!err.text }
}

sub silently(&code) is export {
    my $captured := Captured.new(my $*OUT, my $*ERR);
    &code();
    $captured
}

# vim: expandtab shiftwidth=4
