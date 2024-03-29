use Trap:auth<zef:lizmat>:ver<0.0.1>;

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

=begin pod

=head1 NAME

silently - prevent any output from a block

=head1 SYNOPSIS

=begin code :lang<raku>

use silently;

=end code

=head1 DESCRIPTION

silently is module that exports a single sub called C<silently> that takes
a block to execute.  Inside that block, all textual output to C<$*OUT> and
C<$*ERR> is prevented from actually being sent to STDOUT and STDERR.

Note that if you're only interested in surpressing output from warnings,
you should use the C<quietly> statement prefix.

=head1 SUBROUTINES

=head2 silently

  silently { say "hello world" }  # no output

  my $captured = silently { note "tis wrong" }
  if $captured.err -> $error {
      say "something went wrong: $error";
  }

The "silently" subroutine takes a block as a parameter, and runs that block
catching all output to C<$*OUT> and C<$*ERR>.

If the output is actually needed for inspection: the subroutine returns an
object that provides two methods: C<out> and C<err>, giving the captured
output to C<$*OUT> and C<$*ERR> respectively.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/silently . Comments and
Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2020, 2021, 2022 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
