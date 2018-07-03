From: Arne Schwabe <arne@...1227...>
Date: Tue,  3 Jul 2018 16:47:55 +0200
Message-Id: <20180703144755.6794-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Implement parsing and sending INFO and
 INFO_PRE control messages
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

OpenVPN 3 implements these messages to send information during the
authentication to the UI, implement these message also in OpenVPN 2.x
---
 src/openvpn/forward.c |  8 ++++++++
 src/openvpn/push.c    | 29 +++++++++++++++++++++++++++++
 src/openvpn/push.h    |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 9905b5a0..d3e6eede 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -169,6 +169,14 @@ check_incoming_control_channel_dowork(struct context *c)
             {
                 server_pushed_signal(c, &buf, false, 4);
             }
+            else if (buf_string_match_head_str(&buf, "INFO_PRE"))
+            {
+                server_pushed_info(c, &buf, 8);
+            }
+            else if (buf_string_match_head_str(&buf, "INFO"))
+            {
+                server_pushed_info(c, &buf, 4);
+            }
             else
             {
                 msg(D_PUSH_ERRORS, "WARNING: Received unknown control message: %s", BSTR(&buf));
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d1ca84d1..069a32c4 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -175,6 +175,34 @@ server_pushed_signal(struct context *c, const struct buffer *buffer, const bool
     }
 }
 
+void server_pushed_info(struct context *c, const struct buffer *buffer, const int adv)
+{
+  struct gc_arena gc;
+  const char *m = "";
+  struct buffer buf = *buffer;
+
+  if (buf_advance(&buf, adv) && buf_read_u8(&buf) == ',' && BLEN(&buf))
+    {
+      m = BSTR(&buf);
+    }
+
+    #ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        gc = gc_new();
+
+        /* We use >INFOMSG here instead of plain >INFO since INFO is used to */
+        /* for management greeting and we don't want to confuse the client */
+        struct buffer out = alloc_buf_gc(256, &gc);
+        buf_printf(&out, ">%s:%s", "INFOMSG", m);
+        management_notify_generic(management, BSTR(&out));
+
+        gc_free(&gc);
+    }
+    #endif
+    msg(D_PUSH, "Info command was pushed by server ('%s')", m);
+}
+
 #if P2MP_SERVER
 /**
  * Add an option to the given push list by providing a format string.
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 5f6181e7..acc94003 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -50,6 +50,8 @@ void receive_auth_failed(struct context *c, const struct buffer *buffer);
 
 void server_pushed_signal(struct context *c, const struct buffer *buffer, const bool restart, const int adv);
 
+void server_pushed_info(struct context *c, const struct buffer *buffer, const int adv);
+
 void incoming_push_message(struct context *c, const struct buffer *buffer);
 
 #if P2MP_SERVER
-- 
2.17.1


