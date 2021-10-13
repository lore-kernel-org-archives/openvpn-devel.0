From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 14 Oct 2021 02:02:27 +0300
Message-Id: <20211013230227.199-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 1/3] msvc: fix product version display
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

PRODUCT_VERSION_PATCH, defined in version.m4, already includes dot (like ".4"),
so no need to include it here.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 config-msvc-version.h.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config-msvc-version.h.in b/config-msvc-version.h.in
index 7977cb84..59ca654a 100644
--- a/config-msvc-version.h.in
+++ b/config-msvc-version.h.in
@@ -5,8 +5,8 @@
 #define PRODUCT_VERSION_MAJOR "@PRODUCT_VERSION_MAJOR@"
 #define PRODUCT_VERSION_MINOR "@PRODUCT_VERSION_MINOR@"
 #define PRODUCT_VERSION_PATCH "@PRODUCT_VERSION_PATCH@"
-#define PACKAGE_VERSION "@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@...220...@PRODUCT_VERSION_PATCH@"
-#define PRODUCT_VERSION "@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@...220...@PRODUCT_VERSION_PATCH@"
+#define PACKAGE_VERSION "@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@@PRODUCT_VERSION_PATCH@"
+#define PRODUCT_VERSION "@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@@PRODUCT_VERSION_PATCH@"
 #define PRODUCT_BUGREPORT "@PRODUCT_BUGREPORT@"
 #define OPENVPN_VERSION_RESOURCE @PRODUCT_VERSION_RESOURCE@
 #define TAP_WIN_COMPONENT_ID "@PRODUCT_TAP_WIN_COMPONENT_ID@"
-- 
2.23.0.windows.1


