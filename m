From: Steffan Karger <steffan@...1856...>
Date: Fri,  5 Oct 2018 14:39:38 +0200
Message-Id: <20181005123938.25649-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] travis: add OpenSSL 1.1 Windows build
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

So we catch both compilation errors against OpenSSL 1.0 and 1.1 on Windows.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 .travis.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 216f0a04..ede2aaa6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -53,7 +53,10 @@ matrix:
       os: osx
       osx_image: xcode7.3
       compiler: clang
-    - env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32
+    - env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32 OPENSSL_VERSION="1.0.1u"
+      os: linux
+      compiler: ": Win64 build only"
+    - env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32 OPENSSL_VERSION="1.1.0h"
       os: linux
       compiler: ": Win64 build only"
     - env: SSLLIB="openssl" CHOST=i686-w64-mingw32
-- 
2.17.1


