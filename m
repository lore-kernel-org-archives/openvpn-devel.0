From: Ilya Shipitsin <chipitsine@...277...>
Date: Thu, 15 Sep 2016 16:13:48 +0500
Message-Id: <1473938028-1636-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] initial travis-ci support
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

---
 .travis.yml                    | 85 ++++++++++++++++++++++++++++++++++++++++++
 .travis/build-mbedtls-linux.sh | 10 +++++
 .travis/build-mbedtls-osx.sh   |  9 +++++
 .travis/build-openssl-linux.sh | 12 ++++++
 .travis/build-openssl-osx.sh   | 11 ++++++
 5 files changed, 127 insertions(+)
 create mode 100644 .travis.yml
 create mode 100755 .travis/build-mbedtls-linux.sh
 create mode 100755 .travis/build-mbedtls-osx.sh
 create mode 100755 .travis/build-openssl-linux.sh
 create mode 100755 .travis/build-openssl-osx.sh

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 0000000..6f719a1
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,85 @@
+sudo: required
+dist: trusty
+
+os: linux
+
+language: c
+
+compiler:
+  - gcc
+
+env:
+  global:
+    - JOBS=3
+    - MBEDTLS_VERSION=2.2.1
+    - MBEDTLS_PREFIX=~/opt/mbedtls
+    - MBEDTLS_LIBS="-L$MBEDTLS_PREFIX/lib -lmbedtls -lmbedx509 -lmbedcrypto"
+    - MBEDTLS_CFLAGS="-I$MBEDTLS_PREFIX/include"
+    - OPENSSL_VERSION=1.0.1t
+    - OPENSSL_PREFIX=~/opt/openssl
+    - OPENSSL_LIB=$OPENSSL_PREFIX/lib
+    - OPENSSL_INC=$OPENSSL_PREFIX/include
+    - OPENSSL_CFLAGS="-I$OPENSSL_PREFIX/include"
+    - OPENSSL_LIBS="-L$OPENSSL_PREFIX/lib -lssl -lcrypto"
+
+matrix:
+  include:
+    - env: CONFIG="--with-crypto-library=openssl"
+      compiler: gcc
+    - env: CONFIG="--with-crypto-library=openssl"
+      compiler: clang
+    - env: CONFIG="--with-crypto-library=mbedtls"
+      compiler: gcc
+    - env: CONFIG="--with-crypto-library=mbedtls"
+      compiler: clang
+    - env: CONFIG="--with-crypto-library=openssl --disable-crypto"
+      compiler: clang
+    - env: CONFIG="--with-crypto-library=openssl --disable-lzo"
+      compiler: clang
+    - env: CONFIG="--with-crypto-library=openssl --enable-small"
+      compiler: clang
+    - env: CONFIG="--with-crypto-library=openssl"
+      os: osx
+      osx_image: xcode7.3
+      compiler: clang
+    - env: CONFIG="--with-crypto-library=mbedtls"
+      os: osx
+      osx_image: xcode7.3
+      compiler: clang
+  allow_failures:
+    - env: CONFIG="--with-crypto-library=openssl --disable-crypto"
+      compiler: clang
+  exclude:
+    - compiler: gcc
+
+addons:
+  apt:
+    packages:
+      - liblzo2-dev
+      - libpam0g-dev
+      - liblz4-dev
+      - linux-libc-dev
+
+cache:
+  apt: true
+  ccache: true
+  directories:
+  - download-cache
+
+before_install:
+  - if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then brew update     ; fi
+  - if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then brew install lzo; fi
+
+install:
+  - mkdir ~/bin && ln -s $(which ccache) ~/bin/$CC && export PATH=$HOME/bin:$PATH
+  - if [ ! -d download-cache ]; then mkdir download-cache; fi
+  - if [[ $CONFIG == *"--with-crypto-library=openssl"* ]]; then .travis/build-openssl-${TRAVIS_OS_NAME}.sh; fi
+  - if [[ $CONFIG == *"--with-crypto-library=mbedtls"* ]]; then .travis/build-mbedtls-${TRAVIS_OS_NAME}.sh; fi
+
+script:
+  - autoreconf -vi
+  - ./configure $CONFIG || (cat config.log && exit 1)
+  - make -j$JOBS
+  - if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then ldd src/openvpn/openvpn; fi
+  - if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then otool -L src/openvpn/openvpn; fi
+  - make check
diff --git a/.travis/build-mbedtls-linux.sh b/.travis/build-mbedtls-linux.sh
new file mode 100755
index 0000000..c21f4e6
--- /dev/null
+++ b/.travis/build-mbedtls-linux.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+if [ ! -f download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz ]; then 
+	wget -O download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz https://tls.mbed.org/download/mbedtls-${MBEDTLS_VERSION}-apache.tgz; 
+fi
+
+tar zxf download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz
+cd mbedtls-${MBEDTLS_VERSION} && make > build.log 2>&1 || (cat build.log && exit 1)
+make install DESTDIR=$MBEDTLS_PREFIX && cd ..
+
diff --git a/.travis/build-mbedtls-osx.sh b/.travis/build-mbedtls-osx.sh
new file mode 100755
index 0000000..e7f07ea
--- /dev/null
+++ b/.travis/build-mbedtls-osx.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+if [ ! -f download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz ]; then 
+	wget -O download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz https://tls.mbed.org/download/mbedtls-${MBEDTLS_VERSION}-apache.tgz; 
+fi
+
+tar zxf download-cache/mbedtls-${MBEDTLS_VERSION}-apache.tgz
+cd mbedtls-${MBEDTLS_VERSION} && make > build.log 2>&1 || (cat build.log && exit 1)
+make install DESTDIR=$MBEDTLS_PREFIX && cd ..
diff --git a/.travis/build-openssl-linux.sh b/.travis/build-openssl-linux.sh
new file mode 100755
index 0000000..931e2c9
--- /dev/null
+++ b/.travis/build-openssl-linux.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+if [ ! -f download-cache/openssl-${OPENSSL_VERSION}.tar.gz ]; then 
+	wget -O download-cache/openssl-${OPENSSL_VERSION}.tar.gz https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz; 
+fi
+
+tar zxf download-cache/openssl-${OPENSSL_VERSION}.tar.gz
+cd openssl-${OPENSSL_VERSION}/
+./config shared --prefix=$OPENSSL_PREFIX -DPURIFY > build.log 2>&1 || (cat build.log && exit 1)
+make > build.log 2>&1 || (cat build.log && exit 1)
+make install_sw > build.log 2>&1 || (cat build.log && exit 1)
+cd ..
diff --git a/.travis/build-openssl-osx.sh b/.travis/build-openssl-osx.sh
new file mode 100755
index 0000000..dee207e
--- /dev/null
+++ b/.travis/build-openssl-osx.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+if [ ! -f download-cache/openssl-${OPENSSL_VERSION}.tar.gz ]; then 
+        wget -O download-cache/openssl-${OPENSSL_VERSION}.tar.gz https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz; 
+fi
+
+tar zxf download-cache/openssl-${OPENSSL_VERSION}.tar.gz
+cd openssl-${OPENSSL_VERSION}/
+./Configure darwin64-x86_64-cc shared --prefix=$OPENSSL_PREFIX -DPURIFY > build.log 2>&1 || (cat build.log && exit 1)
+make depend install > build.log 2>&1 || (cat build.log && exit 1)
+cd ..
-- 
2.5.5


