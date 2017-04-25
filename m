From: Ilya Shipitsin <chipitsine@...277...>
Date: Tue, 25 Apr 2017 12:50:41 +0500
Message-Id: <1493106641-16173-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] travis-ci: add 2 mingw "build only"
	configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Inspired by https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13032.html
build options are taken from regular windows installer builds

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
v2: moved download/build dependencies into functions, changed cross build
detection from shell expansion ${CHOST+x} to more recognised -z "${CHOST}",
which required changing 'set -eux' to 'set -ex'. Added comments to make
code readable without looking into commit message.

 .travis.yml           |  35 +++++++++++++----
 .travis/build-deps.sh | 101 +++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 123 insertions(+), 13 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 3c0aa7d..2f9fe4c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -12,6 +12,9 @@ env:
   global:
     - JOBS=3
     - PREFIX="${HOME}/opt"
+    - TAP_WINDOWS_VERSION=9.21.2
+    - LZO_VERSION=2.10
+    - PKCS11_HELPER_VERSION=1.11
     - MBEDTLS_VERSION="2.4.0"
     - MBEDTLS_CFLAGS="-I${PREFIX}/include"
     - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
@@ -50,6 +53,12 @@ matrix:
       os: osx
       osx_image: xcode7.3
       compiler: clang
+    - env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32
+      os: linux
+      compiler: ": Win64 build only"
+    - env: SSLLIB="openssl" CHOST=i686-w64-mingw32
+      os: linux
+      compiler: ": Win32 build only"
   exclude:
     - compiler: gcc
 
@@ -60,6 +69,7 @@ addons:
       - libpam0g-dev
       - liblz4-dev
       - linux-libc-dev
+      - man2html
 
 cache:
   ccache: true
@@ -72,16 +82,27 @@ before_install:
   - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo; fi
 
 install:
+  - if [ ! -z "${CHOST}" ]; then unset CC; fi
   - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log && exit 1)
 
 script:
   - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"; fi
   - if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then export DYLD_LIBRARY_PATH="${PREFIX}/lib:${DYLD_LIBRARY_PATH}"; fi
   - autoreconf -vi
-  - ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} || (cat config.log && exit 1)
-  - make -j$JOBS
-  - src/openvpn/openvpn --version || true
-  - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn; fi
-  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then otool -L src/openvpn/openvpn; fi
-  - make check
-  - $EXTRA_SCRIPT
+  - if [ -z "${CHOST}" ]; then
+      ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} || (cat config.log && exit 1);
+      make -j$JOBS;
+      src/openvpn/openvpn --version || true;
+      if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn; fi;
+      if [ "${TRAVIS_OS_NAME}" = "osx" ]; then otool -L src/openvpn/openvpn; fi;
+      make check;
+      $EXTRA_SCRIPT;
+    else
+      export TAP_CFLAGS="-I${PWD}/tap-windows-${TAP_WINDOWS_VERSION}/include";
+      export LZO_CFLAGS="-I${PREFIX}/include";
+      export LZO_LIBS="-L${PREFIX}/lib -llzo2";
+      export PKCS11_HELPER_LIBS="-L${PREFIX}/lib -lpkcs11-helper";
+      export PKCS11_HELPER_CFLAGS="-I${PREFIX}/include";
+      ./configure --with-crypto-library="${SSLLIB}" --host=${CHOST} --build=x86_64-pc-linux-gnu --enable-pkcs11 --disable-plugins || (cat config.log && exit 1);
+      make -j$JOBS;
+    fi
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index 3ffba0b..2229bb7 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -1,9 +1,58 @@
 #!/bin/sh
-set -eux
+set -ex
 
 # Set defaults
 PREFIX="${PREFIX:-${HOME}/opt}"
 
+download_tap_windows () {
+    if [ ! -f "download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip" ]; then
+       wget -P download-cache/ \
+           "http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip"
+    fi
+}
+
+download_lzo () {
+    if [ ! -f "download-cache/lzo-${LZO_VERSION}.tar.gz" ]; then
+        wget -P download-cache/ \
+            "http://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz"
+    fi
+}
+
+build_lzo () {
+    if [ "$(cat ${PREFIX}/.lzo-version)" != "${LZO_VERSION}" ]; then
+        tar zxf download-cache/lzo-${LZO_VERSION}.tar.gz
+        (
+            cd "lzo-${LZO_VERSION}"
+
+            ./configure --host=${CHOST} --program-prefix='' \
+                --libdir=${PREFIX}/lib --prefix=${PREFIX} --build=x86_64-pc-linux-gnu
+            make all install
+        )
+        echo "${LZO_VERSION}" > "${PREFIX}/.lzo-version"
+    fi
+}
+
+download_pkcs11_helper () {
+    if [ ! -f "pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2" ]; then
+        wget -P download-cache/ \
+            "http://downloads.sourceforge.net/project/opensc/pkcs11-helper/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
+    fi
+}
+
+build_pkcs11_helper () {
+    if [ "$(cat ${PREFIX}/.pkcs11_helper-version)" != "${PKCS11_HELPER_VERSION}" ]; then
+        tar jxf download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2
+        (
+            cd "pkcs11-helper-${PKCS11_HELPER_VERSION}"
+
+            ./configure --host=${CHOST} --program-prefix='' --libdir=${PREFIX}/lib \
+                 --prefix=${PREFIX} --build=x86_64-pc-linux-gnu --disable-crypto-engine-gnutls --disable-crypto-engine-nss
+            make all install
+         )
+         echo "${PKCS11_HELPER_VERSION}" > "${PREFIX}/.pkcs11_helper-version"
+    fi
+}
+
 download_mbedtls () {
     if [ ! -f "download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz" ]; then
         wget -P download-cache/ \
@@ -31,7 +80,6 @@ download_openssl () {
 }
 
 build_openssl_linux () {
-    tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
     (
         cd "openssl-${OPENSSL_VERSION}/"
         ./config shared --openssldir="${PREFIX}" -DPURIFY
@@ -40,7 +88,6 @@ build_openssl_linux () {
 }
 
 build_openssl_osx () {
-    tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
     (
         cd "openssl-${OPENSSL_VERSION}/"
         ./Configure darwin64-x86_64-cc shared \
@@ -49,9 +96,28 @@ build_openssl_osx () {
     )
 }
 
+build_openssl_mingw () {
+    (
+        cd "openssl-${OPENSSL_VERSION}/"
+
+        if [ "${CHOST}" = "i686-w64-mingw32" ]; then 
+            export TARGET=mingw
+        elif [ "${CHOST}" = "x86_64-w64-mingw32" ]; then
+            export TARGET=mingw64
+        fi
+
+        ./Configure --cross-compile-prefix=${CHOST}- shared \
+           ${TARGET} no-multilib no-capieng --openssldir="${PREFIX}" -static-libgcc
+        make install  
+    )
+}
+
 build_openssl () {
     if [ "$(cat ${PREFIX}/.openssl-version)" != "${OPENSSL_VERSION}" ]; then
-        if [ "${TRAVIS_OS_NAME}" = "osx" ]; then
+        tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
+        if [ ! -z "${CHOST}" ]; then
+            build_openssl_mingw
+        elif [ "${TRAVIS_OS_NAME}" = "osx" ]; then
             build_openssl_osx
         elif [ "${TRAVIS_OS_NAME}" = "linux" ]; then
             build_openssl_linux
@@ -61,16 +127,26 @@ build_openssl () {
 }
 
 # Enable ccache
-if [ "${TRAVIS_OS_NAME}" != "osx" ]; then
+if [ "${TRAVIS_OS_NAME}" != "osx" ] && [ -z "${CHOST}" ]; then
     # ccache not available on osx, see:
     # https://github.com/travis-ci/travis-ci/issues/5567
+    # also ccache not enabled for cross builds
     mkdir -p "${HOME}/bin"
     ln -s "$(which ccache)" "${HOME}/bin/${CC}"
     PATH="${HOME}/bin:${PATH}"
 fi
 
+if [ ! -z "${CHOST}" ]; then
+      #
+      # openvpn requires at least mingw-gcc-4.9, which is available at xenial repo
+      #
+      echo "deb http://archive.ubuntu.com/ubuntu xenial main universe" | sudo tee -a /etc/apt/sources.list.d/xenial.list
+      echo "deb http://archive.ubuntu.com/ubuntu xenial main" | sudo tee -a /etc/apt/sources.list.d/xenial.list
+      sudo apt-get update
+      sudo apt-get -y install dpkg mingw-w64
+fi
+
 # Download and build crypto lib
-mkdir -p download-cache
 if [ "${SSLLIB}" = "openssl" ]; then
     download_openssl
     build_openssl
@@ -81,3 +157,16 @@ else
     echo "Invalid crypto lib: ${SSLLIB}"
     exit 1
 fi
+
+# Download and build dependencies for mingw cross build
+# dependencies are the same as in regular windows installer build
+if [ ! -z "${CHOST}" ]; then
+      download_tap_windows
+      unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
+
+      download_lzo
+      build_lzo
+
+      download_pkcs11_helper
+      build_pkcs11_helper
+fi
-- 
2.5.5


