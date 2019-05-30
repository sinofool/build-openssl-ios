#! /usr/bin/env bash

set -eux
cd "$(dirname "$0")"

rm -rf release
mkdir -p release/include
RELEASE_DIR=$(pwd)/release

cd build_openssl

lipo -create armv7s/lib/libssl.a arm64/lib/libssl.a x86_64/lib/libssl.a -o $RELEASE_DIR/libssl.framework
lipo -create armv7s/lib/libcrypto.a arm64/lib/libcrypto.a x86_64/lib/libcrypto.a -o $RELEASE_DIR/libcrypto.framework

cp -r include/* $RELEASE_DIR/include/
cd ../

tar cvzf $RELEASE_DIR/../release.tgz -C $RELEASE_DIR .
