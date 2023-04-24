#!/bin/bash
bingcc_veropts="-Wl,--wrap=fcntl64 "
bingcc_veropts+="-Wl,$bingcc_incpath/glibc_wrapper.o"
