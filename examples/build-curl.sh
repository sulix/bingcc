#!/bin/sh

CURLVER=7.30.0

# Get the bingcc path: feel free to replace this with a hardcoded path.
MYFILENAME=`readlink -f "$0"`
MYPATH=`dirname "$MYFILENAME"`
BINGCCPATH=`readlink -f "$MYPATH/.."`

wget -c http://curl.haxx.se/download/curl-$CURLVER.tar.bz2
tar xf curl-$CURLVER.tar.bz2

BASEPATH=`readlink -f .`
mkdir -p libs-32
mkdir -p libs

cd curl-$CURLVER
# Cross-compile a 32-bit version

mkdir -p build-32

cd build-32

CC=$BINGCCPATH/bingcc32 ../configure --prefix=$BASEPATH/libs-32 --enable-http --enable-https --enable-file --disable-ldap --disable-ldaps --disable-rtsp --enable-proxy --disable-dict --disable-telnet --disable-tftp --disable-pop3 --disable-imap --disable-smtp --disable-gopher --disable-manual --enable-ipv6 --disable-ntlm-wb --without-nss --without-polarssl --without-cyassl --without-axtls --without-libssh2 --without-librtmp --without-libidn
make install

cd ..

# Compile a 64-bit version

mkdir -p build

cd build

CC=$BINGCCPATH/bingcc ../configure --prefix=$BASEPATH/libs --enable-http --enable-https --enable-file --disable-ldap --disable-ldaps --disable-rtsp --enable-proxy --disable-dict --disable-telnet --disable-tftp --disable-pop3 --disable-imap --disable-smtp --disable-gopher --disable-manual --enable-ipv6 --disable-ntlm-wb --without-nss --without-polarssl --without-cyassl --without-axtls --without-libssh2 --without-librtmp --without-libidn
make install

