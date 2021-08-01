#!/bin/sh

ZLIBVER=1.2.11

# Get the bingcc path: feel free to replace this with a hardcoded path.
MYFILENAME=`readlink -f "$0"`
MYPATH=`dirname "$MYFILENAME"`
BINGCCPATH=`readlink -f "$MYPATH/.."`

wget -c http://zlib.net/zlib-$ZLIBVER.tar.gz 

BASEPATH=`readlink -f .`
mkdir -p libs-32
mkdir -p libs

tar xf zlib-$ZLIBVER.tar.gz
cd zlib-$ZLIBVER
# Cross-compile a 32-bit version

CC=$BINGCCPATH/bingcc32 ./configure --prefix=$BASEPATH/libs-32 
make install

cd ..

# Damn: zlib can't do out-of-tree builds.
rm -rf zlib-$ZLIBVER

tar xf zlib-$ZLIBVER.tar.gz
cd zlib-$ZLIBVER
# Compile a 64-bit version


CC=$BINGCCPATH/bingcc ./configure --prefix=$BASEPATH/libs 
make install

