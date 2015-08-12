build-openssl-ios
=================

Build openssl for iOS development
Includes armv7 armv7s arm64 i386 and x86_64 support.

Script only, please download openssl from here: http://www.openssl.org/source/
Tested iOS SDK 8.3 and MacOSX 10.10
Tested openssl 1.0.2d

Usage
=================
Copy the following lines to your Terminal.app
```
curl -O http://www.openssl.org/source/openssl-1.0.2d.tar.gz
tar xf openssl-1.0.2d.tar.gz
cd openssl-1.0.2d
curl https://raw.githubusercontent.com/sinofool/build-openssl-ios/master/build_openssl_dist.sh |bash
```
Find the result folder openssl-ios-dist on your desktop.
