From: Arne Schwabe <arne@...1227...>
Date: Sat, 19 Nov 2016 16:42:44 +0100
Message-Id: <1479570164-23522-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix various compiler warnings
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

- move p2mp only push_option_fmt to p2mp only section to avoid warning that struct push_list being defined in the argument list
- incoming_push_message not declared on client without server by putting it into the right define block
---
 src/openvpn/push.c | 49 ++++++++++++++++++++++++-------------------------
 src/openvpn/push.h |  3 +--
 2 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index f86bdd3..b7539e6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -42,31 +42,6 @@
 
 static char push_reply_cmd[] = "PUSH_REPLY";
 
-/**
- * Add an option to the given push list by providing a format string.
- *
- * The string added to the push options is allocated in o->gc, so the caller
- * does not have to preserve anything.
- *
- * @param gc        GC arena where options are allocated
- * @param push_list Push list containing options
- * @param msglevel  The message level to use when printing errors
- * @param fmt       Format string for the option
- * @param ...       Format string arguments
- *
- * @return true on success, false on failure.
- */
-static bool push_option_fmt(struct gc_arena *gc, struct push_list *push_list,
-			    int msglevel, const char *fmt, ...)
-#ifdef __GNUC__
-#if __USE_MINGW_ANSI_STDIO
-    __attribute__ ((format (gnu_printf, 4, 5)))
-#else
-    __attribute__ ((format (__printf__, 4, 5)))
-#endif
-#endif
-    ;
-
 /*
  * Auth username/password
  *
@@ -177,6 +152,30 @@ server_pushed_signal (struct context *c, const struct buffer *buffer, const bool
 }
 
 #if P2MP_SERVER
+/**
+ * Add an option to the given push list by providing a format string.
+ *
+ * The string added to the push options is allocated in o->gc, so the caller
+ * does not have to preserve anything.
+ *
+ * @param gc        GC arena where options are allocated
+ * @param push_list Push list containing options
+ * @param msglevel  The message level to use when printing errors
+ * @param fmt       Format string for the option
+ * @param ...       Format string arguments
+ *
+ * @return true on success, false on failure.
+ */
+static bool push_option_fmt(struct gc_arena *gc, struct push_list *push_list,
+			    int msglevel, const char *fmt, ...)
+#ifdef __GNUC__
+#if __USE_MINGW_ANSI_STDIO
+    __attribute__ ((format (gnu_printf, 4, 5)))
+#else
+    __attribute__ ((format (__printf__, 4, 5)))
+#endif
+#endif
+    ;
 
 /*
  * Send auth failed message from server to client.
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index d6cb4b1..1dfd80e 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -51,10 +51,9 @@ void receive_auth_failed (struct context *c, const struct buffer *buffer);
 
 void server_pushed_signal (struct context *c, const struct buffer *buffer, const bool restart, const int adv);
 
-#if P2MP_SERVER
-
 void incoming_push_message (struct context *c, const struct buffer *buffer);
 
+#if P2MP_SERVER
 void clone_push_list (struct options *o);
 
 void push_option (struct options *o, const char *opt, int msglevel);
-- 
2.9.3 (Apple Git-75)


