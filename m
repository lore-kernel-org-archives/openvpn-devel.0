From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:45 +0300
Message-Id: <1336850389-23719-13-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 12/16] cleanup: syshead: move socket compat
	into basic.h
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

Probably not the best place, however, better than syshead.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/basic.h   |   17 +++++++++++++++++
 src/openvpn/syshead.h |   17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index 9746315..ac325e1 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -58,4 +58,21 @@
 # endif
 #endif
 
+/*
+ * Our socket descriptor type.
+ */
+#ifdef WIN32
+#define SOCKET_UNDEFINED (INVALID_SOCKET)
+typedef SOCKET socket_descriptor_t;
+#else
+#define SOCKET_UNDEFINED (-1)
+typedef int socket_descriptor_t;
+#endif
+
+static inline int
+socket_defined (const socket_descriptor_t sd)
+{
+  return sd != SOCKET_UNDEFINED;
+}
+
 #endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 3fd955d..657c884 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -392,23 +392,6 @@
 #endif
 
 /*
- * Our socket descriptor type.
- */
-#ifdef WIN32
-#define SOCKET_UNDEFINED (INVALID_SOCKET)
-typedef SOCKET socket_descriptor_t;
-#else
-#define SOCKET_UNDEFINED (-1)
-typedef int socket_descriptor_t;
-#endif
-
-static inline int
-socket_defined (const socket_descriptor_t sd)
-{
-  return sd != SOCKET_UNDEFINED;
-}
-
-/*
  * Should we enable the use of execve() for calling subprocesses,
  * instead of system()?
  */
-- 
1.7.3.4


