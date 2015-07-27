From: Steffan Karger <steffan@...1856...>
Date: Mon, 27 Jul 2015 21:59:58 +0200
Message-Id: <1438027198-23305-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix out-of-tree builds;
	openvpn-plugin.h should be in AC_CONFIG_HEADERS
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

Was broken in commit 9de35d4.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7bcbb7c..51ef93b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -38,7 +38,7 @@ AC_DEFINE([OPENVPN_VERSION_MINOR], [PRODUCT_VERSION_MINOR], [OpenVPN minor versi
 AC_DEFINE([OPENVPN_VERSION_PATCH], ["PRODUCT_VERSION_PATCH"], [OpenVPN patch level - may be a string or integer])
 
 AC_CONFIG_AUX_DIR([.])
-AC_CONFIG_HEADERS([config.h])
+AC_CONFIG_HEADERS([config.h include/openvpn-plugin.h])
 AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
 AC_CONFIG_MACRO_DIR([m4])
 
@@ -1229,7 +1229,6 @@ AC_CONFIG_FILES([
 	distro/rpm/Makefile
 	distro/rpm/openvpn.spec
 	include/Makefile
-	include/openvpn-plugin.h
 	src/Makefile
 	src/compat/Makefile
 	src/openvpn/Makefile
-- 
2.1.4


