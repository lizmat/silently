class Captured:auth<cpan:ELIZABETH>:ver<0.0.2> {
    has $!out;
    has $!err;

    use nqp;  # intended to be part of Rakudo core

    my class Capturer {
        has $!text;

        method new() {
            nqp::p6bindattrinvres(nqp::create(self),self,'$!text',nqp::list_s)
        }

        method print(*@_ --> True) {
            nqp::push_s($!text,@_.join)
        }
        method say(*@_ --> True) {              # older versions of Raku
            nqp::push_s($!text,nqp::concat(@_.join,"\n"))
        }
        method printf($format, *@_ --> True) {  # older versions of Raku
            nqp::push_s($!text,sprintf($format,@_))
        }

        method text(--> str) {
            nqp::join('',$!text)
        }
    }

    method SET-SELF(\out, \err) {
        out = $!out := Capturer.new;
        err = $!err := Capturer.new;
        self
    }
    method new(\out, \err) { nqp::create(self).SET-SELF(out, err) }

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
a block to execute.  Inside that block, all textual output to $*OUT and $*ERR
is prevented from actually being sent to STDOUT and STDERR.

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

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/silently . Comments and
Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
