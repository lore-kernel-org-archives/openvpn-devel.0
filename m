From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  7 Jul 2023 16:46:28 +0200
Message-Id: <20230707144628.378541-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove old Travis CI related files
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

They are not used or mainained anymore. So just remove them.

Change-Id: I704f7c9a9fe9a2b988410c4586183302392e690d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .travis.yml            | 126 ------------------------------
 .travis/build-check.sh |  32 --------
 .travis/build-deps.sh  | 170 -----------------------------------------
 .travis/coverity.sh    |  17 -----
 4 files changed, 345 deletions(-)
 delete mode 100644 .travis.yml
 delete mode 100755 .travis/build-check.sh
 delete mode 100755 .travis/build-deps.sh
 delete mode 100755 .travis/coverity.sh

diff --git a/.travis.yml b/.travis.yml
deleted file mode 100644
index 2d379c70..00000000
--- a/.travis.yml
+++ /dev/null
@@ -1,126 +0,0 @@
-dist: bionic
-
-os: linux
-
-language: c
-
-env:
-  global:
-    - JOBS=3
-    - RUN_SUDO="false"
-    - PREFIX="${HOME}/opt"
-    - TAP_WINDOWS_VERSION=9.23.3
-    - LZO_VERSION=2.10
-    - PKCS11_HELPER_VERSION=1.26
-    - MBEDTLS_VERSION=2.16.4
-    - MBEDTLS_CFLAGS="-I${PREFIX}/include"
-    - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
-    - OPENSSL_VERSION=1.0.2u
-    - OPENSSL_CFLAGS="-I${PREFIX}/include"
-    - OPENSSL_LIBS="-L${PREFIX}/lib -lssl -lcrypto"
-    # The next declaration is the encrypted COVERITY_SCAN_TOKEN, created
-    #   via the "travis encrypt" command using the project repo's public key
-    - secure: "l9mSnEW4LJqjxftH5i1NdDaYfGmQB1mPXnSB3DXnsjzkCWZ+yJLfBemfQ0tx/wS7chBYxqUaUIMT0hw4zJVp/LANFJo2vfh//ymTS6h0uApRY1ofg9Pp1BFcV1laG6/u8pwSZ2EBy/GhCd3DS436oE8sYBRaFM9FU62L/oeQBfJ7r4ID/0eB1b8bqlbD4paty9MHui2P8EZJwR+KAD84prtfpZOcrSMxPh9OUhJxzxUvvVoP4s4+lZ5Kgg1bBQ3yzKGDqe8VOgK2BWCEuezqhMMc8oeKmAe7CUkoz5gsGYH++k3I9XzP9Z4xeJKoQnC/82qi4xkJmlaOxdionej9bHIcjfRt7D8j1J0U+wOj4p8VrDy7yHaxuN2fi0K5MGa/CaXQSrkna8dePniCng+xQ2MY/zxuRX2gA6xPNLUyQLU9LqIug7wj4z84Hk9iWib4L20MoPjeEo+vAUNq8FtjOPxMuHNpv4iGGx6kgJm7RXl5vC5hxfK6MprrnYe2U5Mcd8jpzagKBaKHL3zV2FxX9k0jRO9Mccz7M2WnaV0MQ6zcngzTN4+s0kCjhfGKd2F2ANT2Gkhj3Me36eNHfuE0dBbvYCMh4b3Mgd7b/OuXwQWdJ8PjJ1WHXjSOw5sHw1suaV6cEO2Meyz5j1tOkyOi0M9QF+LFenQ9vLH4sBCww8U="
-
-jobs:
-  include:
-    - name: cl
-      env:
-      - SSLLIB="openssl"
-      - OPENSSL_VERSION="1.1.1d"
-      - P7Z="c:\Program Files\7-Zip\7z.exe"
-      - CC="cl"
-      os: windows
-      compiler: cl
-    - name: Coverity scan
-      env: SSLLIB="openssl" RUN_COVERITY="1"
-      os: linux
-      compiler: gcc
-    - name: gcc | openssl-1.1.1d
-      env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1d"
-      os: linux
-      arch: amd64
-      compiler: gcc
-    - name: gcc | openssl-1.1.1d
-      env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1d"
-      os: linux
-      arch: ppc64le
-      compiler: gcc
-    - name: gcc | openssl-1.1.1d
-      env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1d"
-      os: linux
-      arch: arm64
-      compiler: gcc
-    - name: gcc | openssl-1.1.1d
-      env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1d"
-      os: linux
-      arch: s390x
-      compiler: gcc
-    - name: gcc | openssl-1.0.2u | iproute2
-      env: SSLLIB="openssl" EXTRA_CONFIG="--enable-iproute2"
-      os: linux
-      compiler: gcc
-    - name: clang+asan | openssl-1.0.2u
-      env: SSLLIB="openssl" CFLAGS="-fsanitize=address" CC=clang-9
-      os: linux
-      compiler: clang
-    - name: clang | openssl-1.1.1d
-      env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1d" CC=clang-9
-      os: linux
-      compiler: clang
-    - name: gcc | mbedtls
-      env: SSLLIB="mbedtls"
-      os: linux
-      compiler: gcc
-    - name: clang+asan | mbedtls
-      env: SSLLIB="mbedtls" CFLAGS="-fsanitize=address" CC=clang-9
-      os: linux
-      compiler: clang
-    - name: clang | openssl-1.0.2u
-      env: SSLLIB="openssl"
-      os: osx
-      compiler: clang
-    - name: clang | mbedtls
-      env: SSLLIB="mbedtls"
-      os: osx
-      compiler: clang
-    - name: mingw64 | openssl-1.1.1d
-      env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32 OPENSSL_VERSION="1.1.1d"
-      os: linux
-      compiler: ": Win64 build only"
-    - name: mingw32 | openssl-1.0.2u
-      env: SSLLIB="openssl" CHOST=i686-w64-mingw32
-      os: linux
-      compiler: ": Win32 build only"
-    - name: clang | openssl-1.0.2u | disable-lzo | distcheck
-      env: SSLLIB="openssl" EXTRA_CONFIG="--disable-lzo" EXTRA_SCRIPT="make distcheck" CC=clang-9
-      os: linux
-      compiler: clang
-    - name: clang | openssl-1.0.2u | enable-small
-      env: SSLLIB="openssl" EXTRA_CONFIG="--enable-small" CC=clang-9
-      os: linux
-      compiler: clang
-
-addons:
-  apt:
-    update: true
-    packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev, man2html, mingw-w64, clang-9, libcmocka-dev, python3-docutils ]
-  homebrew:
-    update: true
-    packages: [ lzo, lz4, cmocka ]
-
-cache:
-  directories:
-  - download-cache
-  - ${HOME}/opt
-  - ${HOME}/Library/Caches/Homebrew
-
-install:
-  - if [ ! -z "${CHOST}" ]; then unset CC; fi
-  - travis_wait 30 bash -c '.travis/build-deps.sh > build-deps.log 2>&1' || (cat build-deps.log && exit 1)
-
-before_script:
-  - .travis/coverity.sh
-
-script:
-  - .travis/build-check.sh
diff --git a/.travis/build-check.sh b/.travis/build-check.sh
deleted file mode 100755
index 4e1b7243..00000000
--- a/.travis/build-check.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-set -eux
-
-if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
-	PATH="/c/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/MSBuild/Current/Bin/":$PATH
-	MSBuild.exe openvpn.sln //p:Platform=x64 && exit 0
-fi
-
-autoreconf -vi
-
-if [ -z ${CHOST+x} ]; then
-	if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
-		export EXTRA_CONFIG="${EXTRA_CONFIG:-} --enable-werror"
-	fi
-	./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG:-} || (cat config.log && exit 1)
-	make LDFLAGS="-Wl,-rpath,${PREFIX}/lib" -j$JOBS
-	src/openvpn/openvpn --version || true
-	if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
-		ldd src/openvpn/openvpn;
-	fi
-	if [ "${TRAVIS_OS_NAME}" = "osx" ]; then otool -L src/openvpn/openvpn; fi
-	make check
-	${EXTRA_SCRIPT:-}
-else
-	export TAP_CFLAGS="-I${PWD}/tap-windows-${TAP_WINDOWS_VERSION}/include"
-	export LZO_CFLAGS="-I${PREFIX}/include"
-	export LZO_LIBS="-L${PREFIX}/lib -llzo2"
-	export PKCS11_HELPER_LIBS="-L${PREFIX}/lib -lpkcs11-helper"
-	export PKCS11_HELPER_CFLAGS="-I${PREFIX}/include"
-	./configure --with-crypto-library="${SSLLIB}" --host=${CHOST} --build=x86_64-pc-linux-gnu --enable-pkcs11 --disable-plugins || (cat config.log && exit 1)
-	make -j${JOBS}
-fi
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
deleted file mode 100755
index 61673441..00000000
--- a/.travis/build-deps.sh
+++ /dev/null
@@ -1,170 +0,0 @@
-#!/bin/sh
-set -eux
-
-if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
-    choco install strawberryperl nasm
-    choco install visualstudio2019buildtools --package-parameters "--includeRecommended --includeOptional"
-    choco install visualstudio2019-workload-vctools
-    cd ..
-    git clone https://github.com/openvpn/openvpn-build.git
-    cd openvpn-build
-    PATH="/c/Strawberry/perl/bin:":$PATH MODE=DEPS msvc/build.bat
-    exit 0
-fi
-
-# Set defaults
-PREFIX="${PREFIX:-${HOME}/opt}"
-
-download_tap_windows () {
-    if [ ! -f "download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip" ]; then
-       wget -P download-cache/ \
-           "https://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip"
-    fi
-}
-
-download_lzo () {
-    if [ ! -f "download-cache/lzo-${LZO_VERSION}.tar.gz" ]; then
-        wget -P download-cache/ \
-            "https://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz"
-    fi
-}
-
-build_lzo () {
-    if [ "$(cat ${PREFIX}/.lzo-version)" != "${LZO_VERSION}" ]; then
-        tar zxf download-cache/lzo-${LZO_VERSION}.tar.gz
-        (
-            cd "lzo-${LZO_VERSION}"
-
-            ./configure --host=${CHOST} --program-prefix='' \
-                --libdir=${PREFIX}/lib --prefix=${PREFIX} --build=x86_64-pc-linux-gnu
-            make all install
-        )
-        echo "${LZO_VERSION}" > "${PREFIX}/.lzo-version"
-    fi
-}
-
-download_pkcs11_helper () {
-    if [ ! -f "pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz" ]; then
-        wget -P download-cache/ \
-            "https://github.com/OpenSC/pkcs11-helper/archive/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz"
-    fi
-}
-
-build_pkcs11_helper () {
-    if [ "$(cat ${PREFIX}/.pkcs11_helper-version)" != "${PKCS11_HELPER_VERSION}" ]; then
-        tar xf download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz
-        (
-            cd "pkcs11-helper-pkcs11-helper-${PKCS11_HELPER_VERSION}"
-
-            autoreconf -iv
-
-            ./configure --host=${CHOST} --program-prefix='' --libdir=${PREFIX}/lib \
-                 --prefix=${PREFIX} --build=x86_64-pc-linux-gnu \
-                 --disable-crypto-engine-gnutls \
-                 --disable-crypto-engine-nss \
-                 --disable-crypto-engine-polarssl \
-                 --disable-crypto-engine-mbedtls
-            make all install
-         )
-         echo "${PKCS11_HELPER_VERSION}" > "${PREFIX}/.pkcs11_helper-version"
-    fi
-}
-
-download_mbedtls () {
-    if [ ! -f "download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz" ]; then
-        wget -P download-cache/ \
-            "https://tls.mbed.org/download/mbedtls-${MBEDTLS_VERSION}-apache.tgz"
-    fi
-}
-
-build_mbedtls () {
-    if [ "$(cat ${PREFIX}/.mbedtls-version)" != "${MBEDTLS_VERSION}" ]; then
-        tar zxf download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz
-        (
-            cd "mbedtls-${MBEDTLS_VERSION}"
-            make
-            make install DESTDIR="${PREFIX}"
-        )
-        echo "${MBEDTLS_VERSION}" > "${PREFIX}/.mbedtls-version"
-    fi
-}
-
-download_openssl () {
-    if [ ! -f "download-cache/openssl-${OPENSSL_VERSION}.tar.gz" ]; then
-        MAJOR=`echo $OPENSSL_VERSION | sed -e 's/\([0-9.]*\).*/\1/'`
-        wget -P download-cache/ \
-             "https://www.openssl.org/source/old/${MAJOR}/openssl-${OPENSSL_VERSION}.tar.gz"
-    fi
-}
-
-build_openssl_linux () {
-    (
-        cd "openssl-${OPENSSL_VERSION}/"
-        ./config shared --prefix="${PREFIX}" --openssldir="${PREFIX}" -DPURIFY
-        make all install_sw
-    )
-}
-
-build_openssl_osx () {
-    (
-        cd "openssl-${OPENSSL_VERSION}/"
-        ./Configure darwin64-x86_64-cc shared \
-            --prefix="${PREFIX}" --openssldir="${PREFIX}" -DPURIFY
-        make depend all install_sw
-    )
-}
-
-build_openssl_mingw () {
-    (
-        cd "openssl-${OPENSSL_VERSION}/"
-
-        if [ "${CHOST}" = "i686-w64-mingw32" ]; then
-            export TARGET=mingw
-        elif [ "${CHOST}" = "x86_64-w64-mingw32" ]; then
-            export TARGET=mingw64
-        fi
-
-        ./Configure --cross-compile-prefix=${CHOST}- shared \
-           ${TARGET} no-capieng --prefix="${PREFIX}" --openssldir="${PREFIX}" -static-libgcc
-        make install
-    )
-}
-
-build_openssl () {
-    if [ "$(cat ${PREFIX}/.openssl-version)" != "${OPENSSL_VERSION}" ]; then
-        tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
-        if [ ! -z ${CHOST+x} ]; then
-            build_openssl_mingw
-        elif [ "${TRAVIS_OS_NAME}" = "osx" ]; then
-            build_openssl_osx
-        elif [ "${TRAVIS_OS_NAME}" = "linux" ]; then
-            build_openssl_linux
-        fi
-        echo "${OPENSSL_VERSION}" > "${PREFIX}/.openssl-version"
-    fi
-}
-
-# Download and build crypto lib
-if [ "${SSLLIB}" = "openssl" ]; then
-    download_openssl
-    build_openssl
-elif [ "${SSLLIB}" = "mbedtls" ]; then
-    download_mbedtls
-    build_mbedtls
-else
-    echo "Invalid crypto lib: ${SSLLIB}"
-    exit 1
-fi
-
-# Download and build dependencies for mingw cross build
-# dependencies are the same as in regular windows installer build
-if [ ! -z ${CHOST+x} ]; then
-      download_tap_windows
-      unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
-
-      download_lzo
-      build_lzo
-
-      download_pkcs11_helper
-      build_pkcs11_helper
-fi
diff --git a/.travis/coverity.sh b/.travis/coverity.sh
deleted file mode 100755
index 8bb40f48..00000000
--- a/.travis/coverity.sh
+++ /dev/null
@@ -1,17 +0,0 @@
-#!/bin/sh
-set -eu
-
-RUN_COVERITY="${RUN_COVERITY:-0}"
-
-export COVERITY_SCAN_PROJECT_NAME="OpenVPN/openvpn"
-export COVERITY_SCAN_BRANCH_PATTERN="release\/2.4"
-export COVERITY_SCAN_NOTIFICATION_EMAIL="scan-reports@...515..."
-export COVERITY_SCAN_BUILD_COMMAND_PREPEND="autoreconf -vi && ./configure --enable-iproute2 && make clean"
-export COVERITY_SCAN_BUILD_COMMAND="make"
-
-if [ "${RUN_COVERITY}" = "1" ]; then
-    # Ignore exit code, script exits with 1 if we're not on the right branch
-    curl -s "https://scan.coverity.com/scripts/travisci_build_coverity_scan.sh" | bash || true
-else
-    echo "Skipping coverity scan because \$RUN_COVERITY != \"1\""
-fi
-- 
2.34.1


