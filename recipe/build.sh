#!/bin/bash

set -e

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

autoreconf --install  # autotools based install officially recommended for now it seems...
CFLAGS="-O2 -g $CFLAGS" ./configure --prefix="$PREFIX" --enable-shared
make -j${CPU_COUNT}
make check || ( set -x; cat testsuite/test-suite.log; exit 1 )
make install
