From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:37:00 +0200
Message-Id: <20200810143707.5834-11-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 10/17] Eliminate
 check_incoming_control_channel wrapper function
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

Move the check that calls this function into the calling function.
Also eliminate the if (len) check in the
check_incoming_control_channel_dowork function as it is only called
if len is > 0 anyway and replace it with a ASSERT.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 117 +++++++++++++++++++-----------------------
 src/openvpn/forward.h |   2 +-
 2 files changed, 55 insertions(+), 64 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 866dd138..0e05b08b 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -121,21 +121,6 @@ check_tls_errors(struct context *c)
     }
 }
 
-/*
- * Check for possible incoming configuration
- * messages on the control channel.
- */
-static inline void
-check_incoming_control_channel(struct context *c)
-{
-#if P2MP
-    if (tls_test_payload_len(c->c2.tls_multi) > 0)
-    {
-        check_incoming_control_channel_dowork(c);
-    }
-#endif
-}
-
 /*
  * Set our wakeup to 0 seconds, so we will be rescheduled
  * immediately.
@@ -222,61 +207,61 @@ check_tls_errors_nco(struct context *c)
  * messages on the control channel.
  */
 void
-check_incoming_control_channel_dowork(struct context *c)
+check_incoming_control_channel(struct context *c)
 {
-    const int len = tls_test_payload_len(c->c2.tls_multi);
-    if (len)
+    int len = tls_test_payload_len(c->c2.tls_multi);
+    /* We should only be called with len >0 */
+    ASSERT(len > 0);
+
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(len, &gc);
+    if (tls_rec_payload(c->c2.tls_multi, &buf))
     {
-        struct gc_arena gc = gc_new();
-        struct buffer buf = alloc_buf_gc(len, &gc);
-        if (tls_rec_payload(c->c2.tls_multi, &buf))
-        {
-            /* force null termination of message */
-            buf_null_terminate(&buf);
+        /* force null termination of message */
+        buf_null_terminate(&buf);
 
-            /* enforce character class restrictions */
-            string_mod(BSTR(&buf), CC_PRINT, CC_CRLF, 0);
+        /* enforce character class restrictions */
+        string_mod(BSTR(&buf), CC_PRINT, CC_CRLF, 0);
 
-            if (buf_string_match_head_str(&buf, "AUTH_FAILED"))
-            {
-                receive_auth_failed(c, &buf);
-            }
-            else if (buf_string_match_head_str(&buf, "PUSH_"))
-            {
-                incoming_push_message(c, &buf);
-            }
-            else if (buf_string_match_head_str(&buf, "RESTART"))
-            {
-                server_pushed_signal(c, &buf, true, 7);
-            }
-            else if (buf_string_match_head_str(&buf, "HALT"))
-            {
-                server_pushed_signal(c, &buf, false, 4);
-            }
-            else if (buf_string_match_head_str(&buf, "INFO_PRE"))
-            {
-                server_pushed_info(c, &buf, 8);
-            }
-            else if (buf_string_match_head_str(&buf, "INFO"))
-            {
-                server_pushed_info(c, &buf, 4);
-            }
-            else if (buf_string_match_head_str(&buf, "CR_RESPONSE"))
-            {
-                receive_cr_response(c, &buf);
-            }
-            else
-            {
-                msg(D_PUSH_ERRORS, "WARNING: Received unknown control message: %s", BSTR(&buf));
-            }
+        if (buf_string_match_head_str(&buf, "AUTH_FAILED"))
+        {
+            receive_auth_failed(c, &buf);
+        }
+        else if (buf_string_match_head_str(&buf, "PUSH_"))
+        {
+            incoming_push_message(c, &buf);
+        }
+        else if (buf_string_match_head_str(&buf, "RESTART"))
+        {
+            server_pushed_signal(c, &buf, true, 7);
+        }
+        else if (buf_string_match_head_str(&buf, "HALT"))
+        {
+            server_pushed_signal(c, &buf, false, 4);
+        }
+        else if (buf_string_match_head_str(&buf, "INFO_PRE"))
+        {
+            server_pushed_info(c, &buf, 8);
+        }
+        else if (buf_string_match_head_str(&buf, "INFO"))
+        {
+            server_pushed_info(c, &buf, 4);
+        }
+        else if (buf_string_match_head_str(&buf, "CR_RESPONSE"))
+        {
+            receive_cr_response(c, &buf);
         }
         else
         {
-            msg(D_PUSH_ERRORS, "WARNING: Receive control message failed");
+            msg(D_PUSH_ERRORS, "WARNING: Received unknown control message: %s", BSTR(&buf));
         }
-
-        gc_free(&gc);
     }
+    else
+    {
+        msg(D_PUSH_ERRORS, "WARNING: Receive control message failed");
+    }
+
+    gc_free(&gc);
 }
 
 /*
@@ -1877,8 +1862,14 @@ pre_select(struct context *c)
         return;
     }
 
-    /* check for incoming configuration info on the control channel */
-    check_incoming_control_channel(c);
+#if P2MP
+    /* check for incoming control messages on the control channel like
+     * push request/reply, or authentication failure and 2FA messages */
+    if (tls_test_payload_len(c->c2.tls_multi) > 0)
+    {
+        check_incoming_control_channel(c);
+    }
+#endif
 
     /* Should we send an OCC message? */
     check_send_occ_msg(c);
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index e8b8900a..27e7fde7 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -75,7 +75,7 @@ void check_tls_errors_co(struct context *c);
 void check_tls_errors_nco(struct context *c);
 
 #if P2MP
-void check_incoming_control_channel_dowork(struct context *c);
+void check_incoming_control_channel(struct context *c);
 
 void check_scheduled_exit(struct context *c);
 
-- 
2.26.2


