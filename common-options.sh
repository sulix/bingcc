#!/bin/bash

# -m32: We want a 32-bit build
# -fno-stack-protector: Requires a new gcc for _chk functions
# -D_FORTIFY_SOURCE=0: Disable some security hardening which depends on new glibc
# -U_FORTIFY_SOURCE: Fix a problem with gcc 4.6+, which doesn't like me.
# -D_GNU_SOURCE=1: Disable ISO C99 scanf (requires glibc 2.7+)

bingcc_options="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0 -D_GNU_SOURCE=1 -fno-stack-protector -fno-finite-math-only"
