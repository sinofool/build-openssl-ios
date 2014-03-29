build-openssl-ios
=================

Build openssl for iOS development

Script only, please download openssl from here: http://www.openssl.org/source/
Tested iOS SDK 7.1 and MacOSX 10.9
Tested openssl 1.0.1f

Usage
=================
curl -O http://www.openssl.org/source/openssl-1.0.1f.tar.gz
tar xf openssl-1.0.1f.tar.gz
cd openssl-1.0.1f
curl https://raw.githubusercontent.com/sinofool/build-openssl-ios/master/build_openssl_dist.sh |bash
......

Result
=================
Find the result openssl-ios-dist on your desktop.
