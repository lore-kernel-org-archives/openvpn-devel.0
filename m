From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 11 Nov 2015 15:00:49 +0200
Message-Id: <1447246849-11602-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fix "implicit declaration" compiler warning
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

Add missing "include" directive.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/mtcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b27c5eb..9926d47 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -37,6 +37,10 @@
 
 #include "memdbg.h"
 
+#ifdef HAVE_SYS_INOTIFY_H
+#include <sys/inotify.h>
+#endif
+
 /*
  * TCP States
  */
-- 
1.9.1


