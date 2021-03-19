From: Arne Schwabe <arne@...1227...>
Date: Fri, 19 Mar 2021 16:31:28 +0100
Message-Id: <20210319153129.8734-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/2] Move extract_iv_proto to ssl_util.c/h
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

This function is used by both NCP and push, so move it to a more proper
place.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c    |  1 +
 src/openvpn/push.c     | 18 +-----------------
 src/openvpn/push.h     | 10 ----------
 src/openvpn/ssl_util.c | 16 ++++++++++++++++
 src/openvpn/ssl_util.h |  8 ++++++++
 5 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d10f188c..f7e0f680 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -51,6 +51,7 @@
 
 
 #include "crypto_backend.h"
+#include "ssl_util.h"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 320ad737..a6519557 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -37,6 +37,7 @@
 #include "manage.h"
 
 #include "memdbg.h"
+#include "ssl_util.h"
 
 #if P2MP
 
@@ -1057,21 +1058,4 @@ remove_iroutes_from_push_route_list(struct options *o)
         gc_free(&gc);
     }
 }
-
-unsigned int
-extract_iv_proto(const char *peer_info)
-{
-    const char *optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
-    if (optstr)
-    {
-        int proto = 0;
-        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
-        if (r == 1 && proto > 0)
-        {
-            return proto;
-        }
-    }
-    return 0;
-}
-
 #endif /* if P2MP */
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 377f94a6..bb787a62 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -91,16 +91,6 @@ void send_restart(struct context *c, const char *kill_msg);
  */
 void send_push_reply_auth_token(struct tls_multi *multi);
 
-
-/**
- * Extracts the IV_PROTO variable and returns its value or 0
- * if it cannot be extracted.
- *
- * @param peer_info     peer info string to search for IV_PROTO
- */
-unsigned int
-extract_iv_proto(const char *peer_info);
-
 /**
  * Parses an AUTH_PENDING message and if in pull mode extends the timeout
  *
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index a74e3b72..f6e66be4 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -59,3 +59,19 @@ extract_var_peer_info(const char *peer_info, const char *var,
     var_value[var_end - var_start] = '\0';
     return var_value;
 }
+
+unsigned int
+extract_iv_proto(const char *peer_info)
+{
+    const char *optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
+    if (optstr)
+    {
+        int proto = 0;
+        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
+        if (r == 1 && proto > 0)
+        {
+            return proto;
+        }
+    }
+    return 0;
+}
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index bc2ae30d..741a7782 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -46,4 +46,12 @@ extract_var_peer_info(const char *peer_info,
                       const char *var,
                       struct gc_arena *gc);
 
+/**
+ * Extracts the IV_PROTO variable and returns its value or 0
+ * if it cannot be extracted.
+ *
+ * @param peer_info     peer info string to search for IV_PROTO
+ */
+unsigned int
+extract_iv_proto(const char *peer_info);
 #endif
-- 
2.30.1


