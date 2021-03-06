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

silently is module that exports a single sub called `silently` that takes a block to execute. Inside that block, all textual output to $*OUT and $*ERR is prevented from actually being sent to STDOUT and STDERR.

Note that if you're only interested in surpressing output from warnings, you should use the `quietly` statement prefix.

SUBROUTINES
===========

silently
--------

    silently { say "hello world" }  # no output

    my $captured = silently { note "tis wrong" }
    if $captured.err -> $error {
        say "something went wrong: $error";
    }

The "silently" subroutine takes a block as a parameter, and runs that block catching all output to `$*OUT` and `$*ERR`.

If the output is actually needed for inspection: the subroutine returns an object that provides two methods: `out` and `err`, giving the captured output to `$*OUT` and `$*ERR` respectively.

AUTHOR
======

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/silently . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

