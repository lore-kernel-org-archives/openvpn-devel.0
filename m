From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:38 +0200
Message-Id: <20220422142953.3805364-4-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 13/28] Change FULL_SYNC macro to
 no_pending_reliable_packets function
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

This changes this macro to a better named inline function. This
introduces a slight whitespace problem but the next refactoring will
move the incorrectly intended block to its own function anyway.
---
 src/openvpn/ssl.c | 100 ++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 43 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index bad59f2a1..4ca093243 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1774,8 +1774,10 @@ flush_payload_buffer(struct key_state *ks)
 }
 
 /* true if no in/out acknowledgements pending */
-#define FULL_SYNC \
-    (reliable_empty(ks->send_reliable) && reliable_ack_empty(ks->rec_ack))
+static bool no_pending_reliable_packets(struct key_state *ks)
+{
+    return (reliable_empty(ks->send_reliable) && reliable_ack_empty(ks->rec_ack));
+}
 
 /*
  * Move the active key to the lame duck key and reinitialize the
@@ -2428,6 +2430,54 @@ session_move_pre_start(const struct tls_session *session,
     return true;
 
 }
+
+/**
+ * Moves the key to state to S_ACTIVE and also advances the multi_state state
+ * machine if this is the initial connection. 
+ */
+static void
+session_move_active(struct tls_multi *multi, struct tls_session *session,
+                    struct link_socket_info *to_link_socket_info,
+                    struct key_state *ks)
+{
+    dmsg(D_TLS_DEBUG_MED, "STATE S_ACTIVE");
+
+    ks->established = now;
+    if (check_debug_level(D_HANDSHAKE))
+    {
+        print_details(&ks->ks_ssl, "Control Channel:");
+    }
+    ks->state = S_ACTIVE;
+    /* Cancel negotiation timeout */
+    ks->must_negotiate = 0;
+    INCR_SUCCESS;
+
+    /* Set outgoing address for data channel packets */
+    link_socket_set_outgoing_addr(to_link_socket_info, &ks->remote_addr,
+                                  session->common_name, session->opt->es);
+
+    /* Check if we need to advance the tls_multi state machine */
+    if (multi->multi_state == CAS_NOT_CONNECTED)
+    {
+        if (session->opt->mode == MODE_SERVER)
+        {
+            /* On a server we continue with running connect scripts next */
+            multi->multi_state = CAS_WAITING_AUTH;
+        }
+        else
+        {
+            /* Skip the connect script related states */
+            multi->multi_state = CAS_WAITING_OPTIONS_IMPORT;
+        }
+    }
+
+    /* Flush any payload packets that were buffered before our state transitioned to S_ACTIVE */
+    flush_payload_buffer(ks);
+
+#ifdef MEASURE_TLS_HANDSHAKE_STATS
+    show_tls_performance_stats();
+#endif
+}
 /*
  * This is the primary routine for processing TLS stuff inside the
  * the main event loop.  When this routine exits
@@ -2518,7 +2568,7 @@ tls_process(struct tls_multi *multi,
         }
 
         /* Wait for Initial Handshake ACK */
-        if (ks->state == S_PRE_START && FULL_SYNC)
+        if (ks->state == S_PRE_START && no_pending_reliable_packets(ks))
         {
             ks->state = S_START;
             state_change = true;
@@ -2542,47 +2592,11 @@ tls_process(struct tls_multi *multi,
 
         /* Wait for ACK */
         if (((ks->state == S_GOT_KEY && !session->opt->server)
-             || (ks->state == S_SENT_KEY && session->opt->server)))
+             || (ks->state == S_SENT_KEY && session->opt->server))
+             && no_pending_reliable_packets(ks))
         {
-            if (FULL_SYNC)
-            {
-                ks->established = now;
-                dmsg(D_TLS_DEBUG_MED, "STATE S_ACTIVE");
-                if (check_debug_level(D_HANDSHAKE))
-                {
-                    print_details(&ks->ks_ssl, "Control Channel:");
-                }
-                state_change = true;
-                ks->state = S_ACTIVE;
-                /* Cancel negotiation timeout */
-                ks->must_negotiate = 0;
-                INCR_SUCCESS;
-
-                /* Set outgoing address for data channel packets */
-                link_socket_set_outgoing_addr(to_link_socket_info, &ks->remote_addr, session->common_name, session->opt->es);
-
-                /* Check if we need to advance the tls_multi state machine */
-                if (multi->multi_state == CAS_NOT_CONNECTED)
-                {
-                    if (session->opt->mode == MODE_SERVER)
-                    {
-                        /* On a server we continue with running connect scripts next */
-                        multi->multi_state = CAS_WAITING_AUTH;
-                    }
-                    else
-                    {
-                        /* Skip the connect script related states */
-                        multi->multi_state = CAS_WAITING_OPTIONS_IMPORT;
-                    }
-                }
-
-                /* Flush any payload packets that were buffered before our state transitioned to S_ACTIVE */
-                flush_payload_buffer(ks);
-
-#ifdef MEASURE_TLS_HANDSHAKE_STATS
-                show_tls_performance_stats();
-#endif
-            }
+            session_move_active(multi, session, to_link_socket_info, ks);
+            state_change = true;
         }
 
         /* Reliable buffer to outgoing TCP/UDP (send up to CONTROL_SEND_ACK_MAX ACKs
-- 
2.32.0 (Apple Git-132)


