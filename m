From: Ilya Shipitsin <chipitsine@...277...>
Date: Thu, 15 Sep 2016 16:26:58 +0500
Message-Id: <1473938818-3375-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] travis-ci refactor by Steffan Karger
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

From: Steffan Karger <steffan@...1856...>

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 .travis.yml           | 63 ++++++++++++++++++++------------------
 .travis/build-deps.sh | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 29 deletions(-)
 create mode 100755 .travis/build-deps.sh

diff --git a/.travis.yml b/.travis.yml
index 6f719a1..452c48e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -11,43 +11,49 @@ compiler:
 env:
   global:
     - JOBS=3
-    - MBEDTLS_VERSION=2.2.1
-    - MBEDTLS_PREFIX=~/opt/mbedtls
-    - MBEDTLS_LIBS="-L$MBEDTLS_PREFIX/lib -lmbedtls -lmbedx509 -lmbedcrypto"
-    - MBEDTLS_CFLAGS="-I$MBEDTLS_PREFIX/include"
-    - OPENSSL_VERSION=1.0.1t
-    - OPENSSL_PREFIX=~/opt/openssl
-    - OPENSSL_LIB=$OPENSSL_PREFIX/lib
-    - OPENSSL_INC=$OPENSSL_PREFIX/include
-    - OPENSSL_CFLAGS="-I$OPENSSL_PREFIX/include"
-    - OPENSSL_LIBS="-L$OPENSSL_PREFIX/lib -lssl -lcrypto"
+    - PREFIX="${HOME}/opt"
+    - MBEDTLS_VERSION="2.2.1"
+    - MBEDTLS_CFLAGS="-I${PREFIX}/include"
+    - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
+    - OPENSSL_VERSION="1.0.1t"
+    - OPENSSL_CFLAGS="-I${PREFIX}/include"
+    - OPENSSL_LIBS="-L${PREFIX}/lib -lssl -lcrypto"
+    - LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"
 
 matrix:
   include:
-    - env: CONFIG="--with-crypto-library=openssl"
+    - env: SSLLIB="openssl"
+      os: linux
       compiler: gcc
-    - env: CONFIG="--with-crypto-library=openssl"
+    - env: SSLLIB="openssl"
+      os: linux
       compiler: clang
-    - env: CONFIG="--with-crypto-library=mbedtls"
+    - env: SSLLIB="mbedtls"
+      os: linux
       compiler: gcc
-    - env: CONFIG="--with-crypto-library=mbedtls"
+    - env: SSLLIB="mbedtls"
+      os: linux
       compiler: clang
-    - env: CONFIG="--with-crypto-library=openssl --disable-crypto"
+    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-crypto"
+      os: linux
       compiler: clang
-    - env: CONFIG="--with-crypto-library=openssl --disable-lzo"
+    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-lzo"
+      os: linux
       compiler: clang
-    - env: CONFIG="--with-crypto-library=openssl --enable-small"
+    - env: SSLLIB="openssl" EXTRA_CONFIG="--enable-small"
+      os: linux
       compiler: clang
-    - env: CONFIG="--with-crypto-library=openssl"
+    - env: SSLLIB="openssl"
       os: osx
       osx_image: xcode7.3
       compiler: clang
-    - env: CONFIG="--with-crypto-library=mbedtls"
+    - env: SSLLIB="mbedtls"
       os: osx
       osx_image: xcode7.3
       compiler: clang
   allow_failures:
-    - env: CONFIG="--with-crypto-library=openssl --disable-crypto"
+    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-crypto"
+      os: linux
       compiler: clang
   exclude:
     - compiler: gcc
@@ -65,21 +71,20 @@ cache:
   ccache: true
   directories:
   - download-cache
+  - ${HOME}/opt
 
 before_install:
-  - if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then brew update     ; fi
-  - if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then brew install lzo; fi
+  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew update     ; fi
+  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo; fi
 
 install:
-  - mkdir ~/bin && ln -s $(which ccache) ~/bin/$CC && export PATH=$HOME/bin:$PATH
-  - if [ ! -d download-cache ]; then mkdir download-cache; fi
-  - if [[ $CONFIG == *"--with-crypto-library=openssl"* ]]; then .travis/build-openssl-${TRAVIS_OS_NAME}.sh; fi
-  - if [[ $CONFIG == *"--with-crypto-library=mbedtls"* ]]; then .travis/build-mbedtls-${TRAVIS_OS_NAME}.sh; fi
+  - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log && exit 1)
 
 script:
   - autoreconf -vi
-  - ./configure $CONFIG || (cat config.log && exit 1)
+  - ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} || (cat config.log && exit 1)
   - make -j$JOBS
-  - if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then ldd src/openvpn/openvpn; fi
-  - if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then otool -L src/openvpn/openvpn; fi
+  - src/openvpn/openvpn --version || true
+  - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn; fi
+  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then otool -L src/openvpn/openvpn; fi
   - make check
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
new file mode 100755
index 0000000..bda54ee
--- /dev/null
+++ b/.travis/build-deps.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+set -eux
+
+# Set defaults
+MBEDTLS_VERSION="${MBEDTLS_VERSION:-2.2.1}"
+OPENSSL_VERSION="${OPENSSL_VERION:-1.0.2h}"
+PREFIX="${PREFIX:-${HOME}/opt}"
+
+download_mbedtls () {
+    if [ ! -f "download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz" ]; then
+        wget -P download-cache/ \
+            "https://tls.mbed.org/download/mbedtls-${MBEDTLS_VERSION}-apache.tgz"
+    fi
+}
+
+build_mbedtls () {
+    if [ "$(cat ${PREFIX}/.mbedtls-version)" != "${MBEDTLS_VERSION}" ]; then
+        tar zxf download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz
+        (
+            cd "mbedtls-${MBEDTLS_VERSION}"
+            make
+            make install DESTDIR="${PREFIX}"
+        )
+        echo "${MBEDTLS_VERSION}" > "${PREFIX}/.mbedtls-version"
+    fi
+}
+
+download_openssl () {
+    if [ ! -f "download-cache/openssl-${OPENSSL_VERSION}.tar.gz" ]; then
+        wget -P download-cache/ \
+            "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
+    fi
+}
+
+build_openssl_linux () {
+    tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
+    (
+        cd "openssl-${OPENSSL_VERSION}/"
+        ./config shared --openssldir="${PREFIX}" -DPURIFY
+        make all install_sw
+    )
+}
+
+build_openssl_osx () {
+    tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
+    (
+        cd "openssl-${OPENSSL_VERSION}/"
+        ./Configure darwin64-x86_64-cc shared \
+            --openssldir="${PREFIX}" -DPURIFY
+        make depend all install_sw
+    )
+}
+
+build_openssl () {
+    if [ "$(cat ${PREFIX}/.openssl-version)" != "${OPENSSL_VERSION}" ]; then
+        if [ "${TRAVIS_OS_NAME}" = "osx" ]; then
+            build_openssl_osx
+        elif [ "${TRAVIS_OS_NAME}" = "linux" ]; then
+            build_openssl_linux
+        fi
+        echo "${OPENSSL_VERSION}" > "${PREFIX}/.openssl-version"
+    fi
+}
+
+# Enable ccache
+if [ "${TRAVIS_OS_NAME}" != "osx" ]; then
+    # ccache not available on osx, see:
+    # https://github.com/travis-ci/travis-ci/issues/5567
+    mkdir -p "${HOME}/bin"
+    ln -s "$(which ccache)" "${HOME}/bin/${CC}"
+    PATH="${HOME}/bin:${PATH}"
+fi
+
+# Download and build crypto lib
+mkdir -p download-cache
+if [ "${SSLLIB}" = "openssl" ]; then
+    download_openssl
+    build_openssl
+elif [ "${SSLLIB}" = "mbedtls" ]; then
+    download_mbedtls
+    build_mbedtls
+else
+    echo "Invalid crypto lib: ${SSLLIB}"
+    exit 1
+fi
-- 
2.5.5


