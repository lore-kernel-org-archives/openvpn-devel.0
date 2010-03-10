From: David Sommerseth <openvpn.list@...1114...>
Date: Wed, 10 Mar 2010 11:49:42 +0100
Message-Id: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if not
	defined
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
Cc: David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

This is to include peercred support on hosts where _GNU_SOURCE is not
defined by default.  This issue has been found on Gentoo with glibc-2.8.

The solution was discussed on the IRC meeting March 4, 2010
in #openvpn-discussions.
<http://thread.gmane.org/gmane.network.openvpn.devel/3242>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 syshead.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/syshead.h b/syshead.h
index 6e81103..fe6ae4b 100644
--- a/syshead.h
+++ b/syshead.h
@@ -85,6 +85,10 @@
 #endif
 
 #ifdef HAVE_SYS_SOCKET_H
+# if defined(TARGET_LINUX) && !defined(_GNU_SOURCE)
+   /* needed for peercred support on glibc-2.8 */
+#  define _GNU_SOURCE
+# endif
 #include <sys/socket.h>
 #endif
 
-- 
1.6.6.1


