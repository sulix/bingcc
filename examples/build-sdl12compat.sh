#!/bin/sh

# Get the bingcc path: feel free to replace this with a hardcoded path.
MYFILENAME=`readlink -f "$0"`
MYPATH=`dirname "$MYFILENAME"`
BINGCCPATH=`readlink -f "$MYPATH/.."`

git clone https://github.com/libsdl-org/sdl12-compat.git

BASEPATH=`readlink -f .`
mkdir -p libs-32
mkdir -p libs

cd sdl12-compat
# Cross-compile a 32-bit version


mkdir -p build-32

cd build-32

CMAKE_LIBRARY_PATH="/usr/lib/i386-linux-gnu" CC=$BINGCCPATH/bingcc32 cmake .. -DCMAKE_INSTALL_PREFIX="$BASEPATH/libs-32"
make install

cd ..

# Compile a 64-bit version

mkdir -p build

cd build

CC=$BINGCCPATH/bingcc cmake .. -DCMAKE_INSTALL_PREFIX="$BASEPATH/libs" -DRPATH=0
make install

