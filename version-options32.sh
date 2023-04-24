#!/bin/bash
bingcc_veropts="-Wl,--wrap=fcntl64 "
bingcc_veropts+="-m32 -Wl,$bingcc_incpath/glibc_wrapper32.o"
