From: Ilya Shipitsin <chipitsine@...277...>
Date: Sat, 17 Sep 2016 15:54:39 +0500
Message-Id: <1474109679-4982-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] enable "--disable-crypto" build
	configuration
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
 .travis.yml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 452c48e..369db97 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -51,10 +51,6 @@ matrix:
       os: osx
       osx_image: xcode7.3
       compiler: clang
-  allow_failures:
-    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-crypto"
-      os: linux
-      compiler: clang
   exclude:
     - compiler: gcc
 
-- 
2.5.5


