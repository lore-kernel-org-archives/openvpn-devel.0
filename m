From: Ilya Shipitsin <chipitsine@...277...>
Date: Sun, 26 Mar 2017 16:21:19 +0500
Message-Id: <1490527279-31426-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] travis-ci: add 2 mingw "build only
	configurations"
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
 .travis.yml           | 30 +++++++++++++++++++++-------
 .travis/build-deps.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 3c0aa7d..9ab30a2 100644
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
@@ -72,16 +82,22 @@ before_install:
   - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo; fi
 
 install:
+  - if [ ! -z "${CHOST+xxx}" ]; then unset CC; unset CXX; fi
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
+  - if [ -z "${CHOST+xxx}" ]; then
+      ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} || (cat config.log && exit 1);
+      make -j$JOBS;
+      src/openvpn/openvpn --version || true;
+      if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn; fi;
+      if [ "${TRAVIS_OS_NAME}" = "osx" ]; then otool -L src/openvpn/openvpn; fi;
+      make check;
+      $EXTRA_SCRIPT;
+    else
+      TAP_CFLAGS="-I${PWD}/tap-windows-${TAP_WINDOWS_VERSION}/include" LZO_CFLAGS="-I${PREFIX}/include" LZO_LIBS="-L${PREFIX}/lib -llzo2" PKCS11_HELPER_LIBS="-L${PREFIX}/lib -lpkcs11-helper" PKCS11_HELPER_CFLAGS="-I${PREFIX}/include" ./configure --host=${CHOST} --build=x86_64-pc-linux-gnu --enable-pkcs11 --disable-plugins || (cat config.log && exit 1);
+      make -j$JOBS;
+    fi
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index 3ffba0b..18f40ec 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -31,7 +31,6 @@ download_openssl () {
 }
 
 build_openssl_linux () {
-    tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
     (
         cd "openssl-${OPENSSL_VERSION}/"
         ./config shared --openssldir="${PREFIX}" -DPURIFY
@@ -40,7 +39,6 @@ build_openssl_linux () {
 }
 
 build_openssl_osx () {
-    tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
     (
         cd "openssl-${OPENSSL_VERSION}/"
         ./Configure darwin64-x86_64-cc shared \
@@ -49,9 +47,25 @@ build_openssl_osx () {
     )
 }
 
+build_openssl_mingw () {
+    (
+        cd "openssl-${OPENSSL_VERSION}/"
+
+        if [ "${CHOST}" = "i686-w64-mingw32" ]; then export target=mingw; fi
+        if [ "${CHOST}" = "x86_64-w64-mingw32" ]; then export target=mingw64; fi
+
+        ./Configure --cross-compile-prefix=${CHOST}- shared \
+           $target no-multilib no-capieng --openssldir="${PREFIX}" -static-libgcc
+        make install  
+    )
+}
+
 build_openssl () {
     if [ "$(cat ${PREFIX}/.openssl-version)" != "${OPENSSL_VERSION}" ]; then
-        if [ "${TRAVIS_OS_NAME}" = "osx" ]; then
+        tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
+        if [ ! -z ${CHOST+xxx} ]; then
+            build_openssl_mingw
+        elif [ "${TRAVIS_OS_NAME}" = "osx" ]; then
             build_openssl_osx
         elif [ "${TRAVIS_OS_NAME}" = "linux" ]; then
             build_openssl_linux
@@ -61,7 +75,7 @@ build_openssl () {
 }
 
 # Enable ccache
-if [ "${TRAVIS_OS_NAME}" != "osx" ]; then
+if [ "${TRAVIS_OS_NAME}" != "osx" ] && [ -z "${CHOST+xxx}" ]; then
     # ccache not available on osx, see:
     # https://github.com/travis-ci/travis-ci/issues/5567
     mkdir -p "${HOME}/bin"
@@ -70,7 +84,6 @@ if [ "${TRAVIS_OS_NAME}" != "osx" ]; then
 fi
 
 # Download and build crypto lib
-mkdir -p download-cache
 if [ "${SSLLIB}" = "openssl" ]; then
     download_openssl
     build_openssl
@@ -81,3 +94,35 @@ else
     echo "Invalid crypto lib: ${SSLLIB}"
     exit 1
 fi
+
+if [ ! -z ${CHOST+xxx} ]; then
+      echo "deb http://archive.ubuntu.com/ubuntu xenial main universe" | sudo tee -a /etc/apt/sources.list.d/xenial.list
+      echo "deb http://archive.ubuntu.com/ubuntu xenial main" | sudo tee -a /etc/apt/sources.list.d/xenial.list
+      sudo apt-get update
+      sudo apt-get -y install dpkg mingw-w64
+      if [ ! -f "download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip" ]; then
+         wget -P download-cache/ http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip
+      fi
+      unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
+
+      (
+      wget -P download-cache/ http://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz
+      tar zxf download-cache/lzo-${LZO_VERSION}.tar.gz
+      cd lzo-${LZO_VERSION}
+
+      ./configure --host=${CHOST} --program-prefix='' --enable-shared --libdir=${PREFIX}/lib --prefix=${PREFIX} --build=x86_64-pc-linux-gnu
+      make
+      make install
+      )
+
+      (
+      wget -P download-cache/ http://downloads.sourceforge.net/project/opensc/pkcs11-helper/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2
+      tar jxf download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2
+      cd pkcs11-helper-${PKCS11_HELPER_VERSION}
+
+      ./configure --host=${CHOST} --program-prefix='' --enable-shared --libdir=${PREFIX}/lib --prefix=${PREFIX} --build=x86_64-pc-linux-gnu --disable-crypto-engine-gnutls --disable-crypto-engine-nss
+      make
+      make install
+      )
+
+fi
-- 
2.5.5


