From: Ilya Shipitsin <chipitsine@...277...>
Date: Sat, 25 Feb 2017 23:00:04 +0500
Message-Id: <1488045604-25460-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] travis-ci: add "make distcheck" to test
	scenario, V2
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

in rare cases openvpn is built from tarball, it happens during "installer build"
process. "make distcheck" helps to prevent problems during such builds.

V2: limit "make distcheck" to one build configuration
Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index a68374a..3c0aa7d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -33,7 +33,7 @@ matrix:
     - env: SSLLIB="mbedtls"
       os: linux
       compiler: clang
-    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-crypto"
+    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-crypto" EXTRA_SCRIPT="make distcheck"
       os: linux
       compiler: clang
     - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-lzo"
@@ -84,3 +84,4 @@ script:
   - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn; fi
   - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then otool -L src/openvpn/openvpn; fi
   - make check
+  - $EXTRA_SCRIPT
-- 
2.5.5


