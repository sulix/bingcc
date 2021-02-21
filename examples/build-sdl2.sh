#!/bin/sh


# Get the bingcc path: feel free to replace this with a hardcoded path.
MYFILENAME=`readlink -f "$0"`
MYPATH=`dirname "$MYFILENAME"`
BINGCCPATH=`readlink -f "$MYPATH/.."`

git clone https://github.com/libsdl-org/SDL.git

#wget -O fix-fullscreen.patch "http://bugzilla-attachments.libsdl.org/attachment.cgi?id=1059"

BASEPATH=`readlink -f .`
mkdir -p libs-32
mkdir -p libs

cd SDL
# Cross-compile a 32-bit version

mkdir -p build-32

cd build-32

#CC=$BINGCCPATH/bingcc32 cmake .. -DCMAKE_INSTALL_PREFIX="$BASEPATH/libs-32" -DRPATH=0 -DPULSEAUDIO=1 -DPULSEAUDIO_SHARED=1 -DALSA=1 -DALSA_SHARED=1 -DESD=0 -DARTS=0 -DSDL_DLOPEN=1 -DX11_SHARED=1 -DVIDEO_OPENGL=1 -DVIDEO_OPENGLES=0
CC=$BINGCCPATH/bingcc32 ../configure --prefix="$BASEPATH/libs-32" --disable-esd --disable-arts --disable-video-directfb --disable-rpath --enable-alsa --enable-alsa-shared --enable-pulseaudio --enable-pulseaudio-shared --enable-x11-shared --enable-sdl-dlopen --disable-input-tslib
make -j9 install

cd ..

# Compile a 64-bit version

mkdir -p build

cd build

#CC=$BINGCCPATH/bingcc cmake .. -DCMAKE_INSTALL_PREFIX="$BASEPATH/libs" -DRPATH=0 -DPULSEAUDIO=1 -DPULSEAUDIO_SHARED=1 -DALSA=1 -DALSA_SHARED=1 -DESD=0 -DARTS=0 -DSDL_DLOPEN=1 -DX11_SHARED=1 -DVIDEO_OPENGL=1 -DVIDEO_OPENGLES=0
CC=$BINGCCPATH/bingcc ../configure --prefix="$BASEPATH/libs" --disable-esd --disable-arts --disable-video-directfb --disable-rpath --enable-alsa --enable-alsa-shared --enable-pulseaudio --enable-pulseaudio-shared --enable-x11-shared --enable-sdl-dlopen --disable-input-tslib
make -j9 install

