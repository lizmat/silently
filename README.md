[![Actions Status](https://github.com/lizmat/silently/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/silently/actions) [![Actions Status](https://github.com/lizmat/silently/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/silently/actions) [![Actions Status](https://github.com/lizmat/silently/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/silently/actions)

NAME
====

silently - prevent any output from a block

SYNOPSIS
========

```raku
use silently;
```

DESCRIPTION
===========

silently is module that exports a single sub called `silently` that takes a block to execute. Inside that block, all textual output to `$*OUT` and `$*ERR` is prevented from actually being sent to STDOUT and STDERR.

Note that if you're only interested in surpressing output from warnings, you should use the `quietly` statement prefix.

SUBROUTINES
===========

silently
--------

```raku
silently { say "hello world" }  # no output

my $captured = silently { note "tis wrong" }
if $captured.err -> $error {
  say "something went wrong: $error";
}
```

The `silently` subroutine takes a block as a parameter, and runs that block catching all output to `$*OUT` and `$*ERR`.

If the output is actually needed for inspection: the subroutine returns an object that provides two methods: `out` and `err`, giving the captured output to `$*OUT` and `$*ERR` respectively.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/silently . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2020, 2021, 2022, 2025 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

