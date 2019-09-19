#!/usr/bin/env bash

curl -O https://www.openssl.org/source/openssl-1.1.1b.tar.gz
tar xf openssl-1.1.1b.tar.gz
cd openssl-1.1.1b
../build_openssl_dist.sh
