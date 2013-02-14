#!/bin/sh

# This builds a version of libSDL 1.2 which is pretty impressively compatible.
# You'll need to have all of the development libraries installed: Xlib, Pulse,
# ALSA, etc. You'll also need the 32-bit versions.
# This builds both 32 and 64 bit versions of SDL (on my ubuntu 12.10 amd64
# system). They'll be installed in ./SDL-1.2.15/libs(-32). Note that it'll
# break pretty impressively on non-x86_64 systems at the moment.
# Have fun,
# -- David


SDLVER=1.2.15

# Get the bingcc path: feel free to replace this with a hardcoded path.
MYFILENAME=`readlink -f "$0"`
MYPATH=`dirname "$MYFILENAME"`
BINGCCPATH=`readlink -f "$MYPATH/.."`

wget -c http://www.libsdl.org/release/SDL-$SDLVER.tar.gz
tar xf SDL-$SDLVER.tar.gz

BASEPATH=`readlink -f .`
mkdir -p libs-32
mkdir -p libs

cd SDL-$SDLVER
# Cross-compile a 32-bit version

mkdir -p build-32

cd build-32

CC=$BINGCCPATH/bingcc32 ../configure --prefix=$BASEPATH/libs-32 --enable-x11-shared --enable-sdl-dlopen --disable-video-directfb --disable-rpath
make install

cd ..

# Compile a 64-bit version

mkdir -p build

cd build

CC=$BINGCCPATH/bingcc ../configure --prefix=$BASEPATH/libs --enable-x11-shared --enable-sdl-dlopen --disable-video-directfb --disable-rpath
make install

