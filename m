From: David Sommerseth <davids@...515...>
Date: Fri, 12 Aug 2016 20:54:47 +0200
Message-Id: <1471028087-4781-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Fix warning appearing in newer
	autoconf/libtool version
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

The warning which appears with autoconf-2.69 with libtool-2.4.2 is:

   libtoolize: Remember to add 'LT_INIT' to configure.ac.

Signed-off-by: David Sommerseth <davids@...515...>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 4f14ebd..69fdd99 100644
--- a/configure.ac
+++ b/configure.ac
@@ -58,6 +58,7 @@ m4_define([serial_tests], [
 AM_INIT_AUTOMAKE(foreign serial_tests) dnl NB: Do not [quote] this parameter.
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
+LT_INIT
 
 AC_ARG_ENABLE(
 	[lzo],
-- 
1.8.3.1


