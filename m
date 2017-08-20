From: Steffan Karger <steffan@...1856...>
Date: Sun, 20 Aug 2017 11:19:04 +0200
Message-Id: <1503220744-5569-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] travis: reorder matrix to speed up build
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

The OSX and mingw builds are much slower than the other jobs.  Our free
travis account can only use 4 build executors in parallel. Run the slow
builds earlier, so that when one or more of these finish, the free build
executors will start building the configure variants in parallel with the
slow ones.  (Instead of doing the slow ones last, which results in using
only 1-2 executors during the end stage.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 .travis.yml | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 79aa8c9..366e659 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -45,15 +45,6 @@ matrix:
     - env: SSLLIB="mbedtls"
       os: linux
       compiler: clang
-    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-crypto" EXTRA_SCRIPT="make distcheck"
-      os: linux
-      compiler: clang
-    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-lzo"
-      os: linux
-      compiler: clang
-    - env: SSLLIB="openssl" EXTRA_CONFIG="--enable-small"
-      os: linux
-      compiler: clang
     - env: SSLLIB="openssl"
       os: osx
       osx_image: xcode7.3
@@ -68,6 +59,15 @@ matrix:
     - env: SSLLIB="openssl" CHOST=i686-w64-mingw32
       os: linux
       compiler: ": Win32 build only"
+    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-crypto" EXTRA_SCRIPT="make distcheck"
+      os: linux
+      compiler: clang
+    - env: SSLLIB="openssl" EXTRA_CONFIG="--disable-lzo"
+      os: linux
+      compiler: clang
+    - env: SSLLIB="openssl" EXTRA_CONFIG="--enable-small"
+      os: linux
+      compiler: clang
   exclude:
     - compiler: gcc
 
-- 
2.7.4


