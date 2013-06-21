#!/bin/sh

PNGVER=1.2.50

# Get the bingcc path: feel free to replace this with a hardcoded path.
MYFILENAME=`readlink -f "$0"`
MYPATH=`dirname "$MYFILENAME"`
BINGCCPATH=`readlink -f "$MYPATH/.."`

wget -c http://downloads.sourceforge.net/project/libpng/libpng12/$PNGVER/libpng-$PNGVER.tar.bz2
tar xf libpng-$PNGVER.tar.bz2

BASEPATH=`readlink -f .`
mkdir -p libs-32
mkdir -p libs

cd libpng-$PNGVER
# Cross-compile a 32-bit version

mkdir -p build-32

cd build-32

CC=$BINGCCPATH/bingcc32 ../configure --prefix=$BASEPATH/libs-32 LDFLAGS="-L$BASEPATH/libs-32/lib" CPPFLAGS="-I$BASEPATH/libs-32/include"
make install

cd ..

# Compile a 64-bit version

mkdir -p build

cd build

CC=$BINGCCPATH/bingcc ../configure --prefix=$BASEPATH/libs LDFLAGS="-L$BASEPATH/libs/lib" CPPFLAGS="-I$BASEPATH/libs/include"
make install

