OpenSSL for iOS
=================
Build openssl for iOS development  
This script will generate static library for armv7s arm64 and x86_64.  
New Xcode7 bitcode feature supported.

Script only, please download openssl from here: http://www.openssl.org/source/  
Tested Xcode 10 and macOS 10.13
Tested openssl 1.1.1
For 1.0.x version, please check branch 1.0.x


Usage
=================
Clone this repo and run the `build.sh` script
Find the result folder openssl-ios-dist on your desktop.

Binary (old 1.0.2c)
=================
You can find a prebuild binary here: https://sinofool.net/dl/openssl-ios-dist.tar.bz2

Double check the binary file before use:
```
SHA1:
2722f13aac674e213708951fc5f87a16e1b2444e  openssl-ios-dist.tar.bz2

GnuPG: (My Key ID: 9BE18853)
https://sinofool.net/dl/openssl-ios-dist.tar.bz2.sig
```
