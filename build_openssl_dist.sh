#!/bin/bash

TMP_DIR=/tmp/build_openssl_$$
CROSS_TOP_SIM="`xcode-select --print-path`/Platforms/iPhoneSimulator.platform/Developer"
CROSS_SDK_SIM="iPhoneSimulator.sdk"

CROSS_TOP_IOS="`xcode-select --print-path`/Platforms/iPhoneOS.platform/Developer"
CROSS_SDK_IOS="iPhoneOS.sdk"

export CROSS_COMPILE=`xcode-select --print-path`/Toolchains/XcodeDefault.xctoolchain/usr/bin/

function build_for ()
{
  PLATFORM=$1
  ARCH=$2
  CROSS_TOP_ENV=CROSS_TOP_$3
  CROSS_SDK_ENV=CROSS_SDK_$3

  make clean

  export CROSS_TOP="${!CROSS_TOP_ENV}"
  export CROSS_SDK="${!CROSS_SDK_ENV}"
  ./Configure $PLATFORM --prefix=${TMP_DIR}/${ARCH} || exit 1
  # problem of concurrent build; make -j8
  make && make install_sw || exit 2
  unset CROSS_TOP
  unset CROSS_SDK
}

function pack_for ()
{
  LIBNAME=$1
  mkdir -p ${TMP_DIR}/lib/
  ${DEVROOT}/usr/bin/lipo \
	-arch x86_64 ${TMP_DIR}/x86_64/lib/lib${LIBNAME}.a \
	-arch armv7s ${TMP_DIR}/armv7s/lib/lib${LIBNAME}.a \
	-arch arm64 ${TMP_DIR}/arm64/lib/lib${LIBNAME}.a \
	-output ${TMP_DIR}/lib/lib${LIBNAME}.a -create
}

curl -O https://raw.githubusercontent.com/sinofool/build-openssl-ios/master/patch-conf.patch
#cp ../build-openssl-ios/patch-conf.patch .
patch Configurations/10-main.conf < patch-conf.patch

build_for ios64sim-cross x86_64 SIM || exit 2
build_for ios-cross armv7s IOS || exit 4
build_for ios64-cross arm64 IOS || exit 5

pack_for ssl || exit 6
pack_for crypto || exit 7

cp -r ${TMP_DIR}/armv7s/include ${TMP_DIR}/
curl -O https://raw.githubusercontent.com/sinofool/build-openssl-ios/master/patch-include.patch
#cp ../build-openssl-ios/patch-include.patch .
patch -p3 ${TMP_DIR}/include/openssl/opensslconf.h < patch-include.patch

DFT_DIST_DIR=${HOME}/Desktop/openssl-ios-dist/
DIST_DIR=${DIST_DIR:-DFT_DIST_DIR}
mkdir -p ${DIST_DIR}
cp -r ${TMP_DIR}/include ${TMP_DIR}/lib ${DIST_DIR}

