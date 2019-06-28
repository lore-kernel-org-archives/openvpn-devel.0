From: chipitsine@...277...
Date: Sat, 29 Jun 2019 00:46:37 +0500
Message-Id: <20190628194637.5038-3-chipitsine@...277...>
In-Reply-To: <20190628194637.5038-1-chipitsine@...277...>
References: <20190628194637.5038-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] travis-ci: update components versions
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

tap windows, pkcs11 helper, mbedtls, openssl were updated to the most recent versions

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
 .travis.yml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 7a074d34..2d07cdc3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -9,13 +9,13 @@ env:
   global:
     - JOBS=3
     - PREFIX="${HOME}/opt"
-    - TAP_WINDOWS_VERSION=9.21.2
+    - TAP_WINDOWS_VERSION=9.23.3
     - LZO_VERSION=2.10
-    - PKCS11_HELPER_VERSION=1.22
-    - MBEDTLS_VERSION="2.8.0"
+    - PKCS11_HELPER_VERSION=1.25.1
+    - MBEDTLS_VERSION=2.16.1
     - MBEDTLS_CFLAGS="-I${PREFIX}/include"
     - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
-    - OPENSSL_VERSION="1.0.2o"
+    - OPENSSL_VERSION=1.0.2s
     - OPENSSL_CFLAGS="-I${PREFIX}/include"
     - OPENSSL_LIBS="-L${PREFIX}/lib -lssl -lcrypto"
     # The next declaration is the encrypted COVERITY_SCAN_TOKEN, created
@@ -30,10 +30,10 @@ matrix:
     - env: SSLLIB="openssl" OPENSSL_VERSION="1.0.1u"
       os: linux
       compiler: gcc
-    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h"
+    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1c"
       os: linux
       compiler: gcc
-    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h" LABEL="linux-ppc64le"
+    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1c" LABEL="linux-ppc64le"
       os: linux-ppc64le
       compiler: gcc
     - env: SSLLIB="openssl" EXTRA_CONFIG="--enable-iproute2"
@@ -42,7 +42,7 @@ matrix:
     - env: SSLLIB="openssl" CFLAGS="-fsanitize=address"
       os: linux
       compiler: clang
-    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h"
+    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.1c"
       os: linux
       compiler: clang
     - env: SSLLIB="mbedtls"
@@ -60,7 +60,7 @@ matrix:
     - env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32 OPENSSL_VERSION="1.0.1u"
       os: linux
       compiler: ": Win64 build only"
-    - env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32 OPENSSL_VERSION="1.1.0h"
+    - env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32 OPENSSL_VERSION="1.1.1c"
       os: linux
       compiler: ": Win64 build only"
     - env: SSLLIB="openssl" CHOST=i686-w64-mingw32
-- 
2.20.1


