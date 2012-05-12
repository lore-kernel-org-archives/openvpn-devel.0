From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:40 +0300
Message-Id: <1336850389-23719-8-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 07/16] cleanup: syshead: move likely,
	unlikely to basic.h
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/basic.h   |    9 +++++++++
 src/openvpn/syshead.h |    9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index 298cf10..f2d5041 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -35,4 +35,13 @@
 
 #define IPV4_NETMASK_HOST 0xffffffffU
 
+/* branch prediction hints */
+#if defined(__GNUC__)
+# define likely(x)       __builtin_expect((x),1)
+# define unlikely(x)     __builtin_expect((x),0)
+#else
+# define likely(x)      (x)
+# define unlikely(x)    (x)
+#endif
+
 #endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 3e64936..98d6023 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -28,15 +28,6 @@
 #include "compat.h"
 #include "compat-stdbool.h"
 
-/* branch prediction hints */
-#if defined(__GNUC__)
-# define likely(x)       __builtin_expect((x),1)
-# define unlikely(x)     __builtin_expect((x),0)
-#else
-# define likely(x)      (x)
-# define unlikely(x)    (x)
-#endif
-
 #ifdef WIN32
 #include <windows.h>
 #include <winsock2.h>
-- 
1.7.3.4


