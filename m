From: Ilya Shipitsin <chipitsine@...277...>
Date: Wed,  9 Aug 2017 13:12:19 +0500
Message-Id: <20170809081219.10367-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] v2 travis-ci: update pkcs11-helper to 1.22
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

use pkcs11-helper from https://github.com/OpenSC/pkcs11-helper/
to match build process used in windows installer build

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
v2: break lines up into 80-char, thanks Steffan Karger

 .travis.yml           | 2 +-
 .travis/build-deps.sh | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index db90e03a..fc98a4d0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -14,7 +14,7 @@ env:
     - PREFIX="${HOME}/opt"
     - TAP_WINDOWS_VERSION=9.21.2
     - LZO_VERSION=2.10
-    - PKCS11_HELPER_VERSION=1.11
+    - PKCS11_HELPER_VERSION=1.22
     - MBEDTLS_VERSION="2.4.0"
     - MBEDTLS_CFLAGS="-I${PREFIX}/include"
     - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index 9cc18584..e787abab 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -35,7 +35,7 @@ build_lzo () {
 download_pkcs11_helper () {
     if [ ! -f "pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2" ]; then
         wget -P download-cache/ \
-            "http://downloads.sourceforge.net/project/opensc/pkcs11-helper/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
+            "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
     fi
 }
 
@@ -46,7 +46,11 @@ build_pkcs11_helper () {
             cd "pkcs11-helper-${PKCS11_HELPER_VERSION}"
 
             ./configure --host=${CHOST} --program-prefix='' --libdir=${PREFIX}/lib \
-                 --prefix=${PREFIX} --build=x86_64-pc-linux-gnu --disable-crypto-engine-gnutls --disable-crypto-engine-nss
+                 --prefix=${PREFIX} --build=x86_64-pc-linux-gnu \
+                 --disable-crypto-engine-gnutls \
+                 --disable-crypto-engine-nss \
+                 --disable-crypto-engine-polarssl \
+                 --disable-crypto-engine-mbedtls
             make all install
          )
          echo "${PKCS11_HELPER_VERSION}" > "${PREFIX}/.pkcs11_helper-version"
-- 
2.13.3


