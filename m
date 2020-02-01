From: chipitsine@...277...
Date: Sat,  1 Feb 2020 18:36:30 +0500
Message-Id: <20200201133630.17331-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] travis-ci: add arm64, s390x builds.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Ilya Shipitsin <chipitsine@...277...>

as described on https://docs.travis-ci.com/user/multi-cpu-architectures travis-ci
now supports amd64, ppcle, arm64, s390 architectures. Add arm64 and s390x.

"sudo" is deprecated, let us remove it, also "matrix" is deprecated in favour of "jobs".

LD_LIBRARY_PATH was replaced by using "rpath" in LDFLAGS, which is more elegant way of linking.

also, dependencies were upgraded to the latest versions.

travis_wait was added for long openssl builds.

https://docs.travis-ci.com/user/multi-cpu-architectures
---
 .travis.yml               | 24 ++++++++++--------------
 .travis/build-check.sh    | 10 +---------
 .travis/build-deps.sh     | 10 ++++++----
 .travis/run-build-deps.sh | 10 ----------
 4 files changed, 17 insertions(+), 37 deletions(-)
 delete mode 100755 .travis/run-build-deps.sh

diff --git a/.travis.yml b/.travis.yml
index 057fbb91..9f9db954 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,5 +1,4 @@
-sudo: required
-dist: xenial
+dist: bionic
 
 os: linux
 
@@ -10,9 +9,9 @@ env:
     - JOBS=3
     - PREFIX="${HOME}/opt"
     - TAP_WINDOWS_VERSION=9.23.3
-    - LZO_VERSION=2.11
-    - PKCS11_HELPER_VERSION=1.25.1
-    - MBEDTLS_VERSION=2.16.1
+    - LZO_VERSION=2.10
+    - PKCS11_HELPER_VERSION=1.26
+    - MBEDTLS_VERSION=2.16.4
     - MBEDTLS_CFLAGS="-I${PREFIX}/include"
     - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
     - OPENSSL_VERSION=1.0.2u
@@ -22,7 +21,7 @@ env:
     #   via the "travis encrypt" command using the project repo's public key
     - secure: "l9mSnEW4LJqjxftH5i1NdDaYfGmQB1mPXnSB3DXnsjzkCWZ+yJLfBemfQ0tx/wS7chBYxqUaUIMT0hw4zJVp/LANFJo2vfh//ymTS6h0uApRY1ofg9Pp1BFcV1laG6/u8pwSZ2EBy/GhCd3DS436oE8sYBRaFM9FU62L/oeQBfJ7r4ID/0eB1b8bqlbD4paty9MHui2P8EZJwR+KAD84prtfpZOcrSMxPh9OUhJxzxUvvVoP4s4+lZ5Kgg1bBQ3yzKGDqe8VOgK2BWCEuezqhMMc8oeKmAe7CUkoz5gsGYH++k3I9XzP9Z4xeJKoQnC/82qi4xkJmlaOxdionej9bHIcjfRt7D8j1J0U+wOj4p8VrDy7yHaxuN2fi0K5MGa/CaXQSrkna8dePniCng+xQ2MY/zxuRX2gA6xPNLUyQLU9LqIug7wj4z84Hk9iWib4L20MoPjeEo+vAUNq8FtjOPxMuHNpv4iGGx6kgJm7RXl5vC5hxfK6MprrnYe2U5Mcd8jpzagKBaKHL3zV2FxX9k0jRO9Mccz7M2WnaV0MQ6zcngzTN4+s0kCjhfGKd2F2ANT2Gkhj3Me36eNHfuE0dBbvYCMh4b3Mgd7b/OuXwQWdJ8PjJ1WHXjSOw5sHw1suaV6cEO2Meyz5j1tOkyOi0M9QF+LFenQ9vLH4sBCww8U="
 
-matrix:
+jobs:
   include:
     - env:
       - SSLLIB="openssl"
@@ -39,12 +38,13 @@ matrix:
       compiler: gcc
     - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1d"
       os: linux
+      arch: amd64
       compiler: gcc
     - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1d"
       os: linux
       arch: ppc64le
       compiler: gcc
-    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1d" 
+    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1d"
       os: linux
       arch: arm64
       compiler: gcc
@@ -91,15 +91,11 @@ matrix:
 
 addons:
   apt:
-    sources:
-      - ubuntu-toolchain-r-test
-      - sourceline: 'deb https://apt.llvm.org/xenial/ llvm-toolchain-xenial-9 main'
-        key_url: 'https://apt.llvm.org/llvm-snapshot.gpg.key'
     update: true
-    packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev, man2html, mingw-w64, clang-9 ]
+    packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev, man2html, mingw-w64, clang-9, libcmocka-dev ]
   homebrew:
     update: true
-    packages: [ lzo ]
+    packages: [ lzo, lz4, cmocka ]
 
 cache:
   directories:
@@ -109,7 +105,7 @@ cache:
 
 install:
   - if [ ! -z "${CHOST}" ]; then unset CC; fi
-  - .travis/run-build-deps.sh
+  - travis_wait 30 .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log && exit 1)
 
 before_script:
   - .travis/coverity.sh
diff --git a/.travis/build-check.sh b/.travis/build-check.sh
index f794704c..4e1b7243 100755
--- a/.travis/build-check.sh
+++ b/.travis/build-check.sh
@@ -6,14 +6,6 @@ if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
 	MSBuild.exe openvpn.sln //p:Platform=x64 && exit 0
 fi
 
-if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
-	export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH:-}"
-fi
-
-if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then
-	export DYLD_LIBRARY_PATH="${PREFIX}/lib:${DYLD_LIBRARY_PATH:-}"
-fi
-
 autoreconf -vi
 
 if [ -z ${CHOST+x} ]; then
@@ -21,7 +13,7 @@ if [ -z ${CHOST+x} ]; then
 		export EXTRA_CONFIG="${EXTRA_CONFIG:-} --enable-werror"
 	fi
 	./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG:-} || (cat config.log && exit 1)
-	make -j$JOBS
+	make LDFLAGS="-Wl,-rpath,${PREFIX}/lib" -j$JOBS
 	src/openvpn/openvpn --version || true
 	if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
 		ldd src/openvpn/openvpn;
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index 4c5cb05e..0c8d69b8 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -44,17 +44,19 @@ build_lzo () {
 }
 
 download_pkcs11_helper () {
-    if [ ! -f "pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2" ]; then
+    if [ ! -f "pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz" ]; then
         wget -P download-cache/ \
-            "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
+            "https://github.com/OpenSC/pkcs11-helper/archive/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz"
     fi
 }
 
 build_pkcs11_helper () {
     if [ "$(cat ${PREFIX}/.pkcs11_helper-version)" != "${PKCS11_HELPER_VERSION}" ]; then
-        tar jxf download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2
+        tar xf download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz
         (
-            cd "pkcs11-helper-${PKCS11_HELPER_VERSION}"
+            cd "pkcs11-helper-pkcs11-helper-${PKCS11_HELPER_VERSION}"
+
+            autoreconf -iv
 
             ./configure --host=${CHOST} --program-prefix='' --libdir=${PREFIX}/lib \
                  --prefix=${PREFIX} --build=x86_64-pc-linux-gnu \
diff --git a/.travis/run-build-deps.sh b/.travis/run-build-deps.sh
deleted file mode 100755
index b8eb41c5..00000000
--- a/.travis/run-build-deps.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-set -eux
-
-if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
-    # for windows we need to print output since openssl build
-    # might take more than 10 minutes, which causes build abort
-    .travis/build-deps.sh
-else
-    .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log && exit 1)
-fi
-- 
2.24.1


