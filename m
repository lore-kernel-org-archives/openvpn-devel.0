From: Ilya Shipitsin <chipitsine@...277...>
Date: Mon, 14 Aug 2017 01:52:17 +0500
Message-Id: <20170813205217.16736-2-chipitsine@...277...>
In-Reply-To: <20170813205217.16736-1-chipitsine@...277...>
References: <20170813205217.16736-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH 1/1] travis-ci: add libressl build for osx
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

---
 .travis.yml            |  5 +++++
 .travis/build-check.sh |  4 ++++
 .travis/build-deps.sh  | 31 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 0b531529..4f5661d6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -21,6 +21,7 @@ env:
     - OPENSSL_VERSION="1.0.2l"
     - OPENSSL_CFLAGS="-I${PREFIX}/include"
     - OPENSSL_LIBS="-L${PREFIX}/lib -lssl -lcrypto"
+    - LIBRESSL_VERSION="2.5.5"
 
 matrix:
   include:
@@ -55,6 +56,10 @@ matrix:
       os: osx
       osx_image: xcode7.3
       compiler: clang
+    - env: SSLLIB="libressl"
+      os: osx
+      osx_image: xcode7.3
+      compiler: clang
     - env: SSLLIB="mbedtls"
       os: osx
       osx_image: xcode7.3
diff --git a/.travis/build-check.sh b/.travis/build-check.sh
index 74f3ae10..790af83e 100755
--- a/.travis/build-check.sh
+++ b/.travis/build-check.sh
@@ -9,6 +9,10 @@ if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then
 	export DYLD_LIBRARY_PATH="${PREFIX}/lib:${DYLD_LIBRARY_PATH:-}"
 fi
 
+if [ "${SSLLIB}" = "libressl"   ]; then
+        export SSLLIB="openssl"
+fi
+
 autoreconf -vi
 
 if [ -z ${CHOST+x} ]; then
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index e787abab..07c846d2 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -76,6 +76,34 @@ build_mbedtls () {
     fi
 }
 
+download_libressl () {
+    if [ ! -f "download-cache/libressl-${LIBRESSL_VERSION}.tar.gz" ]; then
+        wget -P download-cache/ \
+            "https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${LIBRESSL_VERSION}.tar.gz"
+    fi
+}
+
+build_libressl_osx () {
+    (
+        cd "libressl-${LIBRESSL_VERSION}/"
+        ./configure --prefix="${PREFIX}" --with-openssldir="${PREFIX}"
+        make all install
+    )
+}
+
+build_libressl () {
+    if [ "$(cat ${PREFIX}/.libressl-version)" != "${LIBRESSL_VERSION}" ]; then
+        tar zxf "download-cache/libressl-${LIBRESSL_VERSION}.tar.gz"
+        if [ "${TRAVIS_OS_NAME}" = "osx" ]; then
+            build_openssl_osx
+        else
+            echo "Not supported configuration"
+            exit 1
+        fi
+        echo "${LIBRESSL_VERSION}" > "${PREFIX}/.libressl-version"
+    fi
+}
+
 download_openssl () {
     if [ ! -f "download-cache/openssl-${OPENSSL_VERSION}.tar.gz" ]; then
         wget -P download-cache/ \
@@ -153,6 +181,9 @@ fi
 if [ "${SSLLIB}" = "openssl" ]; then
     download_openssl
     build_openssl
+elif [ "${SSLLIB}" = "libressl" ]; then
+    download_libressl
+    build_libressl
 elif [ "${SSLLIB}" = "mbedtls" ]; then
     download_mbedtls
     build_mbedtls
-- 
2.13.3


