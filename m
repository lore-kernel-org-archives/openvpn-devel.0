From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:37 +0200
Message-Id: <20220422142953.3805364-3-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 12/28] Extract session_move_pre_start as own
 function, use local buffer variable
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

This changes the C90 struct buffer declaration to a C99 style one. Also
move the state transition from S_INITIAL to S_PE_START into its own
function.
---
 src/openvpn/ssl.c | 84 ++++++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 6669c4719..bad59f2a1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2382,6 +2382,52 @@ auth_deferred_expire_window(const struct tls_options *o)
     return ret;
 }
 
+/**
+ * Move the session from S_INITIAL to S_PRE_START. This will also generate
+ * the intial message based on ks->initial_opcode
+ *
+ * @return if the state change was succesful
+ */
+static bool
+session_move_pre_start(const struct tls_session *session,
+                       struct key_state *ks)
+{
+    struct buffer *buf = reliable_get_buf_output_sequenced(ks->send_reliable);
+    if (!buf)
+    {
+        return false;
+    }
+
+    ks->initial = now;
+    ks->must_negotiate = now + session->opt->handshake_window;
+    ks->auth_deferred_expire = now + auth_deferred_expire_window(session->opt);
+
+    /* null buffer */
+    reliable_mark_active_outgoing(ks->send_reliable, buf, ks->initial_opcode);
+    INCR_GENERATED;
+
+    ks->state = S_PRE_START;
+
+    struct gc_arena gc = gc_new();
+    dmsg(D_TLS_DEBUG, "TLS: Initial Handshake, sid=%s",
+         session_id_print(&session->session_id, &gc));
+    gc_free(&gc);
+
+#ifdef ENABLE_MANAGEMENT
+    if (management && ks->initial_opcode != P_CONTROL_SOFT_RESET_V1)
+    {
+        management_set_state(management,
+                             OPENVPN_STATE_WAIT,
+                             NULL,
+                             NULL,
+                             NULL,
+                             NULL,
+                             NULL);
+    }
+#endif
+    return true;
+
+}
 /*
  * This is the primary routine for processing TLS stuff inside the
  * the main event loop.  When this routine exits
@@ -2400,7 +2446,6 @@ tls_process(struct tls_multi *multi,
             interval_t *wakeup)
 {
     struct gc_arena gc = gc_new();
-    struct buffer *buf;
     bool state_change = false;
     bool active = false;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
@@ -2460,35 +2505,7 @@ tls_process(struct tls_multi *multi,
         /* Initial handshake */
         if (ks->state == S_INITIAL)
         {
-            buf = reliable_get_buf_output_sequenced(ks->send_reliable);
-            if (buf)
-            {
-                ks->initial = now;
-                ks->must_negotiate = now + session->opt->handshake_window;
-                ks->auth_deferred_expire = now + auth_deferred_expire_window(session->opt);
-
-                /* null buffer */
-                reliable_mark_active_outgoing(ks->send_reliable, buf, ks->initial_opcode);
-                INCR_GENERATED;
-
-                ks->state = S_PRE_START;
-                state_change = true;
-                dmsg(D_TLS_DEBUG, "TLS: Initial Handshake, sid=%s",
-                     session_id_print(&session->session_id, &gc));
-
-#ifdef ENABLE_MANAGEMENT
-                if (management && ks->initial_opcode != P_CONTROL_SOFT_RESET_V1)
-                {
-                    management_set_state(management,
-                                         OPENVPN_STATE_WAIT,
-                                         NULL,
-                                         NULL,
-                                         NULL,
-                                         NULL,
-                                         NULL);
-                }
-#endif
-            }
+            state_change = session_move_pre_start(session, ks);
         }
 
         /* Are we timed out on receive? */
@@ -2573,11 +2590,10 @@ tls_process(struct tls_multi *multi,
         if (!to_link->len && reliable_can_send(ks->send_reliable))
         {
             int opcode;
-            struct buffer b;
 
-            buf = reliable_send(ks->send_reliable, &opcode);
+            struct buffer *buf = reliable_send(ks->send_reliable, &opcode);
             ASSERT(buf);
-            b = *buf;
+            struct buffer b = *buf;
             INCR_SENT;
 
             write_control_auth(session, ks, &b, to_link_addr, opcode,
@@ -2590,7 +2606,7 @@ tls_process(struct tls_multi *multi,
         }
 
         /* Write incoming ciphertext to TLS object */
-        buf = reliable_get_buf_sequenced(ks->rec_reliable);
+        struct buffer *buf = reliable_get_buf_sequenced(ks->rec_reliable);
         if (buf)
         {
             int status = 0;
-- 
2.32.0 (Apple Git-132)


