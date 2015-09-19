OpenSSL for iOS
=================
Build openssl for iOS development  
This script will generate static library for armv7 armv7s arm64 i386 and x86_64.  
New Xcode7 bitcode feature supported.

Script only, please download openssl from here: http://www.openssl.org/source/  
Tested iOS SDK 9.0 and MacOSX 10.11  
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


Binary
=================
You can find a prebuild binary here: https://sinofool.net/dl/openssl-ios-dist.tar.bz2

Double check the binary file before use:
```
SHA1:
2722f13aac674e213708951fc5f87a16e1b2444e  openssl-ios-dist.tar.bz2

GnuPG: (My Key ID: 9BE18853)
https://sinofool.net/dl/openssl-ios-dist.tar.bz2.sig
```
