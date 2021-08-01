#!/bin/sh

OGGVER=1.3.5
VORBISVER=1.3.7

# Get the bingcc path: feel free to replace this with a hardcoded path.
MYFILENAME=`readlink -f "$0"`
MYPATH=`dirname "$MYFILENAME"`
BINGCCPATH=`readlink -f "$MYPATH/.."`

wget -c http://downloads.xiph.org/releases/ogg/libogg-$OGGVER.tar.gz
wget -c http://downloads.xiph.org/releases/vorbis/libvorbis-$VORBISVER.tar.gz

tar xf libogg-$OGGVER.tar.gz
tar xf libvorbis-$VORBISVER.tar.gz

#Build libogg

BASEPATH=`readlink -f .`

mkdir -p libs-32
mkdir -p libs

# Because bingcc's flags are overwritten by -ffast-math :(
export CFLAGS=-fno-finite-math-only

#No, seriously, you need this for --with-ogg to work.
export PKG_CONFIG=false

cd libogg-$OGGVER

# Cross-compile a 32-bit version
mkdir -p build-32
cd build-32

CC=$BINGCCPATH/bingcc32 ../configure --prefix=$BASEPATH/libs-32
make install

cd ..

# Compile a 64-bit version

mkdir -p build
cd build

CC=$BINGCCPATH/bingcc ../configure --prefix=$BASEPATH/libs
make install

# Return to the original directory to build libvorbis
cd ../..

cd libvorbis-$VORBISVER


# Cross-compile a 32-bit version

mkdir -p build-32

cd build-32

CC=$BINGCCPATH/bingcc32 ../configure --prefix=$BASEPATH/libs-32 --disable-oggtest --with-ogg="$BASEPATH/libs-32"

# Get rid of rpath generation in libtool
sed 's|^hardcode_libdir_flag_spec=.*|hardcode_libdir_flag_spec=" "|' -i libtool

make install

cd ..

# Compile a 64-bit version

mkdir -p build

cd build

CC=$BINGCCPATH/bingcc ../configure --prefix=$BASEPATH/libs --disable-oggtest --with-ogg="$BASEPATH/libs"

# Get rid of rpath generation in libtool
sed 's|^hardcode_libdir_flag_spec=.*|hardcode_libdir_flag_spec=" "|' -i libtool

make install



