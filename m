From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 28 Nov 2023 11:37:04 +0100
Message-Id: <20231128103704.61046-1-frank@...2641...>
In-Reply-To: <gerrit.1700485351000.Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585@...2715...>
References: <gerrit.1700485351000.Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Rename state_change to
 continue_tls_process
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

From: Arne Schwabe <arne@...1227...>

The name state_change is more confusing than helpful as it not really
indicates if there was a state change but rather if processing should
be continued. There even some states that are definitively state changes
(setting to_link buffer) that require continue_tls_process to be set
to false.

Change-Id: Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585
Acked-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/452
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 400230c..20f4956 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2694,7 +2694,7 @@
  */
 static bool
 read_incoming_tls_ciphertext(struct buffer *buf, struct key_state *ks,
-                             bool *state_change)
+                             bool *continue_tls_process)
 {
     int status = 0;
     if (buf->len)
@@ -2714,7 +2714,7 @@
     if (status == 1)
     {
         reliable_mark_deleted(ks->rec_reliable, buf);
-        *state_change = true;
+        *continue_tls_process = true;
         dmsg(D_TLS_DEBUG, "Incoming Ciphertext -> TLS");
     }
     return true;
@@ -2730,7 +2730,7 @@
 
 static bool
 read_incoming_tls_plaintext(struct key_state *ks, struct buffer *buf,
-                            interval_t *wakeup, bool *state_change)
+                            interval_t *wakeup, bool *continue_tls_process)
 {
     ASSERT(buf_init(buf, 0));
 
@@ -2744,7 +2744,7 @@
     }
     if (status == 1)
     {
-        *state_change = true;
+        *continue_tls_process = true;
         dmsg(D_TLS_DEBUG, "TLS -> Incoming Plaintext");
 
         /* More data may be available, wake up again asap to check. */
@@ -2754,7 +2754,7 @@
 }
 
 static bool
-write_outgoing_tls_ciphertext(struct tls_session *session, bool *state_change)
+write_outgoing_tls_ciphertext(struct tls_session *session, bool *continue_tls_process)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];
 
@@ -2830,7 +2830,7 @@
 
             reliable_mark_active_outgoing(ks->send_reliable, buf, opcode);
             INCR_GENERATED;
-            *state_change = true;
+            *continue_tls_process = true;
         }
         dmsg(D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
     }
@@ -2839,7 +2839,6 @@
     return true;
 }
 
-
 static bool
 tls_process_state(struct tls_multi *multi,
                   struct tls_session *session,
@@ -2848,13 +2847,19 @@
                   struct link_socket_info *to_link_socket_info,
                   interval_t *wakeup)
 {
-    bool state_change = false;
+    /* This variable indicates if we should call this method
+     * again to process more incoming/outgoing TLS state/data
+     * We want to repeat this until we either determined that there
+     * is nothing more to process or that further processing
+     * should only be done after the outer loop (sending packets etc.)
+     * has run once more */
+    bool continue_tls_process = false;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
     /* Initial handshake */
     if (ks->state == S_INITIAL)
     {
-        state_change = session_move_pre_start(session, ks, false);
+        continue_tls_process = session_move_pre_start(session, ks, false);
     }
 
     /* Are we timed out on receive? */
@@ -2872,7 +2877,7 @@
     if (ks->state == S_PRE_START && reliable_empty(ks->send_reliable))
     {
         ks->state = S_START;
-        state_change = true;
+        continue_tls_process = true;
 
         /* New connection, remove any old X509 env variables */
         tls_x509_clear_env(session->opt->es);
@@ -2885,7 +2890,7 @@
         && reliable_empty(ks->send_reliable))
     {
         session_move_active(multi, session, to_link_socket_info, ks);
-        state_change = true;
+        continue_tls_process = true;
     }
 
     /* Reliable buffer to outgoing TCP/UDP (send up to CONTROL_SEND_ACK_MAX ACKs
@@ -2927,7 +2932,7 @@
         }
         else
         {
-            if (!read_incoming_tls_ciphertext(&entry->buf, ks, &state_change))
+            if (!read_incoming_tls_ciphertext(&entry->buf, ks, &continue_tls_process))
             {
                 goto error;
             }
@@ -2938,7 +2943,7 @@
     struct buffer *buf = &ks->plaintext_read_buf;
     if (!buf->len)
     {
-        if (!read_incoming_tls_plaintext(ks, buf, wakeup, &state_change))
+        if (!read_incoming_tls_plaintext(ks, buf, wakeup, &continue_tls_process))
         {
             goto error;
         }
@@ -2954,7 +2959,7 @@
             goto error;
         }
 
-        state_change = true;
+        continue_tls_process = true;
         dmsg(D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
         ks->state = S_SENT_KEY;
     }
@@ -2970,7 +2975,7 @@
             goto error;
         }
 
-        state_change = true;
+        continue_tls_process = true;
         dmsg(D_TLS_DEBUG_MED, "STATE S_GOT_KEY");
         ks->state = S_GOT_KEY;
     }
@@ -2988,7 +2993,7 @@
         }
         if (status == 1)
         {
-            state_change = true;
+            continue_tls_process = true;
             dmsg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
         }
     }
@@ -2999,14 +3004,14 @@
         buf = reliable_get_buf_output_sequenced(ks->send_reliable);
         if (buf)
         {
-            if (!write_outgoing_tls_ciphertext(session, &state_change))
+            if (!write_outgoing_tls_ciphertext(session, &continue_tls_process))
             {
                 goto error;
             }
         }
     }
 
-    return state_change;
+    return continue_tls_process;
 error:
     tls_clear_error();
     ks->state = S_ERROR;
@@ -3065,19 +3070,19 @@
         msg(D_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
     }
 
-    bool state_change = true;
-    while (state_change)
+    bool continue_tls_process = true;
+    while (continue_tls_process)
     {
         update_time();
 
         dmsg(D_TLS_DEBUG, "TLS: tls_process: chg=%d ks=%s lame=%s to_link->len=%d wakeup=%d",
-             state_change,
+             continue_tls_process,
              state_name(ks->state),
              state_name(ks_lame->state),
              to_link->len,
              *wakeup);
-        state_change = tls_process_state(multi, session, to_link, to_link_addr,
-                                         to_link_socket_info, wakeup);
+        continue_tls_process = tls_process_state(multi, session, to_link, to_link_addr,
+                                                 to_link_socket_info, wakeup);
 
         if (ks->state == S_ERROR)
         {

