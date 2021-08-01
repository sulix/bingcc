#!/bin/sh

GLEWVER=2.2.0

# Get the bingcc path: feel free to replace this with a hardcoded path.
MYFILENAME=`readlink -f "$0"`
MYPATH=`dirname "$MYFILENAME"`
BINGCCPATH=`readlink -f "$MYPATH/.."`

wget -c http://downloads.sourceforge.net/project/glew/glew/$GLEWVER/glew-$GLEWVER.tgz
tar xf glew-$GLEWVER.tgz

BASEPATH=`readlink -f .`
mkdir -p libs-32
mkdir -p libs

cd glew-$GLEWVER
# Cross-compile a 32-bit version

CC=$BINGCCPATH/bingcc32 make GLEW_DEST="$BASEPATH/libs-32" install

cd ..

# Damn: zlib can't do out-of-tree builds.
rm -rf glew-$GLEWVER

tar xf glew-$GLEWVER.tgz
cd glew-$GLEWVER
# Compile a 64-bit version
CC=$BINGCCPATH/bingcc make GLEW_DEST="$BASEPATH/libs" install
