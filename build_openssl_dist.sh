#!/bin/bash

TMP_DIR=/tmp/build_openssl_$$
CROSS_TOP_SIM="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer"
CROSS_SDK_SIM="iPhoneSimulator7.1.sdk"

CROSS_TOP_IOS="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer"
CROSS_SDK_IOS="iPhoneOS7.1.sdk"

TOOLCHAIN_ROOT="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain"

function build_for ()
{
  PLATFORM=$1
  ARCH=$2
  CROSS_TOP_ENV=CROSS_TOP_$3
  CROSS_SDK_ENV=CROSS_SDK_$3

  make clean

  export CROSS_TOP="${!CROSS_TOP_ENV}"
  export CROSS_SDK="${!CROSS_SDK_ENV}"
  ./Configure $PLATFORM no-asm --prefix=${TMP_DIR}/${ARCH} || exit 1
  # problem of concurrent build; make -j8
  export PATH=${TOOLCHAIN_ROOT}/usr/bin:$PATH
  make && make install || exit 2
  unset CROSS_TOP
  unset CROSS_SDK
}

function pack_for ()
{
  LIBNAME=$1
  ${DEVROOT}/usr/bin/lipo \
	-arch i386 ${TMP_DIR}/i386/lib/lib${LIBNAME}.a \
	-arch x86_64 ${TMP_DIR}/x86_64/lib/lib${LIBNAME}.a \
	-arch armv7 ${TMP_DIR}/armv7/lib/lib${LIBNAME}.a \
	-arch armv7s ${TMP_DIR}/armv7s/lib/lib${LIBNAME}.a \
	-arch arm64 ${TMP_DIR}/arm64/lib/lib${LIBNAME}.a \
	-output ${TMP_DIR}/lib${LIBNAME}.a -create
}

curl -O https://raw.githubusercontent.com/sinofool/build-openssl-ios/master/patch-conf.patch
patch Configure < patch-conf.patch

build_for iphoneos-cross-sim32 i386 SIM
build_for iphoneos-cross-sim64 x86_64 SIM
build_for iphoneos-cross-armv7 armv7 IOS
build_for iphoneos-cross-armv7s armv7s IOS
build_for iphoneos-cross-arm64 arm64 IOS

pack_for ssl
pack_for crypto

cp -r ${TMP_DIR}/armv7s/include ${TMP_DIR}/
sed -i.old -e "90,96d" ${TMP_DIR}/include/openssl/opensslconf.h
rm -f ${TMP_DIR}/include/openssl/opensslconf.h.old
curl -O https://raw.githubusercontent.com/sinofool/build-openssl-ios/master/patch-include.patch
patch ${TMP_DIR}/include/openssl/opensslconf.h < patch-include.patch

DIST_DIR=${HOME}/Desktop/openssl-ios-dist/
rm -rf ${DIST_DIR}
mkdir ${DIST_DIR}
cp -r ${TMP_DIR}/include ${TMP_DIR}/libssl.a ${TMP_DIR}/libcrypto.a ${DIST_DIR}

