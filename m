From: Ilya Shipitsin <chipitsine@...277...>
Date: Mon,  9 Apr 2018 14:10:38 +0500
Message-Id: <20180409091038.12348-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] travis-ci: cleanup and upgrade ssl libraries
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

both "compiler" and "exclude" are redundant, so remove them

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
 .travis.yml | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 51645924..1cbd96bc 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -5,9 +5,6 @@ os: linux
 
 language: c
 
-compiler:
-  - gcc
-
 env:
   global:
     - JOBS=3
@@ -15,10 +12,10 @@ env:
     - TAP_WINDOWS_VERSION=9.21.2
     - LZO_VERSION=2.10
     - PKCS11_HELPER_VERSION=1.22
-    - MBEDTLS_VERSION="2.5.1"
+    - MBEDTLS_VERSION="2.8.0"
     - MBEDTLS_CFLAGS="-I${PREFIX}/include"
     - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
-    - OPENSSL_VERSION="1.0.2l"
+    - OPENSSL_VERSION="1.0.2o"
     - OPENSSL_CFLAGS="-I${PREFIX}/include"
     - OPENSSL_LIBS="-L${PREFIX}/lib -lssl -lcrypto"
     # The next declaration is the encrypted COVERITY_SCAN_TOKEN, created
@@ -30,13 +27,13 @@ matrix:
     - env: SSLLIB="openssl" RUN_COVERITY="1"
       os: linux
       compiler: gcc
-    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
+    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h"
       os: linux
       compiler: gcc
     - env: SSLLIB="openssl" CFLAGS="-fsanitize=address"
       os: linux
       compiler: clang
-    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
+    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h"
       os: linux
       compiler: clang
     - env: SSLLIB="mbedtls"
@@ -65,8 +62,6 @@ matrix:
     - env: SSLLIB="openssl" EXTRA_CONFIG="--enable-small"
       os: linux
       compiler: clang
-  exclude:
-    - compiler: gcc
 
 addons:
   apt:
-- 
2.14.3


