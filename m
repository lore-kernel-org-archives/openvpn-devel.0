From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sun,  8 Apr 2012 22:22:09 +0300
Message-Id: <1333912929-7967-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] build: properly detect netinet/ip.h structs
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index d40f7dc..773fa4b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -396,6 +396,9 @@ SOCKET_INCLUDES="
 #ifdef HAVE_NETINET_IN_SYSTM_H
 #include <netinet/in_systm.h>
 #endif
+#ifdef HAVE_NETINET_IP_H
+#include <netinet/ip.h>
+#endif
 "
 
 AC_CHECK_HEADERS(
-- 
1.7.3.4


