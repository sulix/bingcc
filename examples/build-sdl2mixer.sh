#!/bin/sh


# Get the bingcc path: feel free to replace this with a hardcoded path.
MYFILENAME=`readlink -f "$0"`
MYPATH=`dirname "$MYFILENAME"`
BINGCCPATH=`readlink -f "$MYPATH/.."`

hg clone http://hg.libsdl.org/SDL_mixer

BASEPATH=`readlink -f .`
mkdir -p libs-32
mkdir -p libs

cd SDL_mixer
# Cross-compile a 32-bit version


mkdir -p build-32

cd build-32

CC=$BINGCCPATH/bingcc32 ../configure --prefix="$BASEPATH/libs-32" --with-sdl-prefix="$BASEPATH/libs-32" --disable-music-cmd --disable-music-midi --enable-music-mod-shared --enable-music-ogg --enable-music-ogg-shared --enable-music-flac --enable-music-flac-shared --enable-music-mp3  --enable-music-mp3-shared
make install

cd ..

# Compile a 64-bit version

mkdir -p build

cd build

CC=$BINGCCPATH/bingcc ../configure --prefix="$BASEPATH/libs" --with-sdl-prefix="$BASEPATH/libs" --disable-music-cmd --disable-music-midi --enable-music-mod-shared --enable-music-ogg --enable-music-ogg-shared --enable-music-flac --enable-music-flac-shared --enable-music-mp3 --enable-music-mp3-shared 
make install

