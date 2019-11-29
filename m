From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 29 Nov 2019 12:43:35 +0200
Message-Id: <20191129104335.4518-1-lstipakov@...277...>
In-Reply-To: <20191128194320.GM40538@...1296...>
References: <20191128194320.GM40538@...1296...>
Subject: [Openvpn-devel] [PATCH] travis: bump clang version
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

This should fix "suggest braces around initialization of subobject" warning.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .travis.yml | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 61be17cd..40296d87 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,16 +46,16 @@ matrix:
     - env: SSLLIB="openssl" EXTRA_CONFIG="--enable-iproute2"
       os: linux
       compiler: gcc
-    - env: SSLLIB="openssl" CFLAGS="-fsanitize=address"
+    - env: SSLLIB="openssl" CFLAGS="-fsanitize=address" CC=clang-9
       os: linux
       compiler: clang
-    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1c"
+    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1c" CC=clang-9
       os: linux
       compiler: clang
     - env: SSLLIB="mbedtls"
       os: linux
       compiler: gcc
-    - env: SSLLIB="mbedtls" CFLAGS="-fsanitize=address"
+    - env: SSLLIB="mbedtls" CFLAGS="-fsanitize=address" CC=clang-9
       os: linux
       compiler: clang
     - env: SSLLIB="openssl"
@@ -73,17 +73,21 @@ matrix:
     - env: SSLLIB="openssl" CHOST=i686-w64-mingw32
       os: linux
       compiler: ": Win32 build only"
-    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-lzo" EXTRA_SCRIPT="make distcheck"
+    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-lzo" EXTRA_SCRIPT="make distcheck" CC=clang-9
       os: linux
       compiler: clang
-    - env: SSLLIB="openssl" EXTRA_CONFIG="--enable-small"
+    - env: SSLLIB="openssl" EXTRA_CONFIG="--enable-small" CC=clang-9
       os: linux
       compiler: clang
 
 addons:
   apt:
+    sources:
+      - ubuntu-toolchain-r-test
+      - sourceline: 'deb https://apt.llvm.org/xenial/ llvm-toolchain-xenial-9 main'
+        key_url: 'https://apt.llvm.org/llvm-snapshot.gpg.key'
     update: true
-    packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev, man2html, mingw-w64]
+    packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev, man2html, mingw-w64 ]
   homebrew:
     update: true
     packages: [ lzo ]
@@ -95,6 +99,7 @@ cache:
   - ${HOME}/Library/Caches/Homebrew
 
 install:
+  - if [ "$TRAVIS_OS_NAME" = "linux" ] && [ "$TRAVIS_CPU_ARCH" != "ppc64le" ]; then sudo apt-get install clang-9; fi
   - if [ ! -z "${CHOST}" ]; then unset CC; fi
   - .travis/run-build-deps.sh
 
-- 
2.17.1


