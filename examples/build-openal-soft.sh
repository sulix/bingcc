#!/bin/sh

OPENALVER=1.21.1

# Get the bingcc path: feel free to replace this with a hardcoded path.
MYFILENAME=`readlink -f "$0"`
MYPATH=`dirname "$MYFILENAME"`
BINGCCPATH=`readlink -f "$MYPATH/.."`

wget -c https://openal-soft.org/openal-releases/openal-soft-$OPENALVER.tar.bz2
tar xf openal-soft-$OPENALVER.tar.bz2

BASEPATH=`readlink -f .`
mkdir -p libs-32
mkdir -p libs

cd openal-soft-$OPENALVER
# Cross-compile a 32-bit version

mkdir -p build-32

cd build-32

cmake .. -DCMAKE_INSTALL_PREFIX=$BASEPATH/libs-32 -DCMAKE_C_COMPILER=$BINGCCPATH/bingcc32 -DCMAKE_CXX_COMPILER=$BINGCCPATH/bing++32 -DALSOFT_DLOPEN=ON -DALSOFT_BACKEND_PULSEAUDIO=ON -DALSOFT_EXAMPLES=OFF -DALSOFT_BACKEND_ALSA=ON -DALSOFT_BACKEND_OSS=ON
make install


cd ..

# Compile a 64-bit version

mkdir -p build

cd build

cmake .. -DCMAKE_INSTALL_PREFIX=$BASEPATH/libs -DCMAKE_C_COMPILER=$BINGCCPATH/bingcc -DCMAKE_CXX_COMPILER=$BINGCCPATH/bing++ -DALSOFT_DLOPEN=ON -DALSOFT_BACKEND_PULSEAUDIO=ON -DALSOFT_EXAMPLES=OFF -DALSOFT_BACKEND_ALSA=ON -DALSOFT_BACKEND_OSS=ON
make install

