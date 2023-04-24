#!/bin/sh


# Get the bingcc path: feel free to replace this with a hardcoded path.
MYFILENAME=`readlink -f "$0"`
MYPATH=`dirname "$MYFILENAME"`
BINGCCPATH=`readlink -f "$MYPATH/.."`

git clone --depth 1 https://github.com/libsdl-org/SDL.git

#wget -O fix-fullscreen.patch "http://bugzilla-attachments.libsdl.org/attachment.cgi?id=1059"

BASEPATH=`readlink -f .`
mkdir -p libs-32
mkdir -p libs

cd SDL
# Cross-compile a 32-bit version

mkdir -p build-32

cd build-32

CMAKE_LIBRARY_PATH="/usr/lib/i386-linux-gnu" CC=$BINGCCPATH/bingcc32 CXX=$BINGCCPATH/bing++32 cmake .. -DCMAKE_INSTALL_PREFIX="$BASEPATH/libs-32" -DSDL_VIDEO_DRIVER_X11_SUPPORTS_GENERIC_EVENTS=1
make -j`nproc` install

cd ..

# Compile a 64-bit version

mkdir -p build

cd build

CC=$BINGCCPATH/bingcc CXX=$BINGCCPATH/bing++ cmake .. -DCMAKE_INSTALL_PREFIX="$BASEPATH/libs" -DRPATH=0
make -j`nproc` install

