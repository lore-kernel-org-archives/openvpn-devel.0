From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:39 +0200
Message-Id: <20220422142953.3805364-5-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 14/28] Move tls_process_state into its own
 function
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

This function does most of the state transitions in the TLS state
machine. Moving it into its own function removes an intention area and
makes tls_process function easier to understand as the loop is more
obvious.

This is largely just a code move with small expection. bool active is
no longer directly set but inferred from to_link->len
---
 src/openvpn/ssl.c | 444 ++++++++++++++++++++++++----------------------
 1 file changed, 228 insertions(+), 216 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4ca093243..15af58949 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2433,7 +2433,7 @@ session_move_pre_start(const struct tls_session *session,
 
 /**
  * Moves the key to state to S_ACTIVE and also advances the multi_state state
- * machine if this is the initial connection. 
+ * machine if this is the initial connection.
  */
 static void
 session_move_active(struct tls_multi *multi, struct tls_session *session,
@@ -2478,6 +2478,217 @@ session_move_active(struct tls_multi *multi, struct tls_session *session,
     show_tls_performance_stats();
 #endif
 }
+
+
+static bool
+tls_process_state(struct tls_multi *multi,
+                  struct tls_session *session,
+                  struct buffer *to_link,
+                  struct link_socket_actual **to_link_addr,
+                  struct link_socket_info *to_link_socket_info,
+                  interval_t *wakeup)
+{
+    bool state_change = false;
+    struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
+
+    /* Initial handshake */
+    if (ks->state == S_INITIAL)
+    {
+        state_change = session_move_pre_start(session, ks);
+    }
+
+    /* Are we timed out on receive? */
+    if (now >= ks->must_negotiate && ks->state < S_ACTIVE)
+    {
+        msg(D_TLS_ERRORS,
+            "TLS Error: TLS key negotiation failed to occur within %d seconds (check your network connectivity)",
+            session->opt->handshake_window);
+        goto error;
+    }
+
+    /* Wait for Initial Handshake ACK */
+    if (ks->state == S_PRE_START && no_pending_reliable_packets(ks))
+    {
+        ks->state = S_START;
+        state_change = true;
+
+        /*
+         * Attempt CRL reload before TLS negotiation. Won't be performed if
+         * the file was not modified since the last reload
+         */
+        if (session->opt->crl_file
+            && !(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))
+        {
+            tls_ctx_reload_crl(&session->opt->ssl_ctx,
+                               session->opt->crl_file, session->opt->crl_file_inline);
+        }
+
+        /* New connection, remove any old X509 env variables */
+        tls_x509_clear_env(session->opt->es);
+
+        dmsg(D_TLS_DEBUG_MED, "STATE S_START");
+    }
+
+    /* Wait for ACK */
+    if (((ks->state == S_GOT_KEY && !session->opt->server)
+        || (ks->state == S_SENT_KEY && session->opt->server))
+        && no_pending_reliable_packets(ks))
+    {
+        session_move_active(multi, session, to_link_socket_info, ks);
+        state_change = true;
+    }
+
+    /* Reliable buffer to outgoing TCP/UDP (send up to CONTROL_SEND_ACK_MAX ACKs
+     * for previously received packets) */
+    if (!to_link->len && reliable_can_send(ks->send_reliable))
+    {
+        int opcode;
+
+        struct buffer *buf = reliable_send(ks->send_reliable, &opcode);
+        ASSERT(buf);
+        struct buffer b = *buf;
+        INCR_SENT;
+
+        write_control_auth(session, ks, &b, to_link_addr, opcode,
+                           CONTROL_SEND_ACK_MAX, true);
+        *to_link = b;
+        dmsg(D_TLS_DEBUG, "Reliable -> TCP/UDP");
+        return true;
+    }
+
+    /* Write incoming ciphertext to TLS object */
+    struct buffer *buf = reliable_get_buf_sequenced(ks->rec_reliable);
+    if (buf)
+    {
+        int status = 0;
+        if (buf->len)
+        {
+            status = key_state_write_ciphertext(&ks->ks_ssl, buf);
+            if (status == -1)
+            {
+                msg(D_TLS_ERRORS,
+                    "TLS Error: Incoming Ciphertext -> TLS object write error");
+                goto error;
+            }
+        }
+        else
+        {
+            status = 1;
+        }
+        if (status == 1)
+        {
+            reliable_mark_deleted(ks->rec_reliable, buf);
+            state_change = true;
+            dmsg(D_TLS_DEBUG, "Incoming Ciphertext -> TLS");
+        }
+    }
+
+    /* Read incoming plaintext from TLS object */
+    buf = &ks->plaintext_read_buf;
+    if (!buf->len)
+    {
+        int status;
+
+        ASSERT(buf_init(buf, 0));
+        status = key_state_read_plaintext(&ks->ks_ssl, buf, TLS_CHANNEL_BUF_SIZE);
+        update_time();
+        if (status == -1)
+        {
+            msg(D_TLS_ERRORS, "TLS Error: TLS object -> incoming plaintext read error");
+            goto error;
+        }
+        if (status == 1)
+        {
+            state_change = true;
+            dmsg(D_TLS_DEBUG, "TLS -> Incoming Plaintext");
+
+            /* More data may be available, wake up again asap to check. */
+            *wakeup = 0;
+        }
+    }
+
+    /* Send Key */
+    buf = &ks->plaintext_write_buf;
+    if (!buf->len && ((ks->state == S_START && !session->opt->server)
+        || (ks->state == S_GOT_KEY && session->opt->server)))
+    {
+        if (!key_method_2_write(buf, multi, session))
+        {
+            goto error;
+        }
+
+        state_change = true;
+        dmsg(D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
+        ks->state = S_SENT_KEY;
+    }
+
+    /* Receive Key */
+    buf = &ks->plaintext_read_buf;
+    if (buf->len
+        && ((ks->state == S_SENT_KEY && !session->opt->server)
+            || (ks->state == S_START && session->opt->server)))
+    {
+        if (!key_method_2_read(buf, multi, session))
+        {
+            goto error;
+        }
+
+        state_change = true;
+        dmsg(D_TLS_DEBUG_MED, "STATE S_GOT_KEY");
+        ks->state = S_GOT_KEY;
+    }
+
+    /* Write outgoing plaintext to TLS object */
+    buf = &ks->plaintext_write_buf;
+    if (buf->len)
+    {
+        int status = key_state_write_plaintext(&ks->ks_ssl, buf);
+        if (status == -1)
+        {
+            msg(D_TLS_ERRORS,
+                "TLS ERROR: Outgoing Plaintext -> TLS object write error");
+            goto error;
+        }
+        if (status == 1)
+        {
+            state_change = true;
+            dmsg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
+        }
+    }
+
+    /* Outgoing Ciphertext to reliable buffer */
+    if (ks->state >= S_START)
+    {
+        buf = reliable_get_buf_output_sequenced(ks->send_reliable);
+        if (buf)
+        {
+            int status = key_state_read_ciphertext(&ks->ks_ssl, buf, multi->opt.frame.tun_mtu);
+
+            if (status == -1)
+            {
+                msg(D_TLS_ERRORS,
+                    "TLS Error: Ciphertext -> reliable TCP/UDP transport read error");
+                goto error;
+            }
+            if (status == 1)
+            {
+                reliable_mark_active_outgoing(ks->send_reliable, buf, P_CONTROL_V1);
+                INCR_GENERATED;
+                state_change = true;
+                dmsg(D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
+            }
+        }
+    }
+
+    return state_change;
+error:
+    tls_clear_error();
+    ks->state = S_ERROR;
+    msg(D_TLS_ERRORS, "TLS Error: TLS handshake failed");
+    INCR_ERROR;
+    return false;
+
+}
 /*
  * This is the primary routine for processing TLS stuff inside the
  * the main event loop.  When this routine exits
@@ -2495,9 +2706,6 @@ tls_process(struct tls_multi *multi,
             struct link_socket_info *to_link_socket_info,
             interval_t *wakeup)
 {
-    struct gc_arena gc = gc_new();
-    bool state_change = false;
-    bool active = false;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
     struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
 
@@ -2531,7 +2739,8 @@ tls_process(struct tls_multi *multi,
         msg(D_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
     }
 
-    do
+    bool state_change = true;
+    while(state_change)
     {
         update_time();
 
@@ -2541,209 +2750,15 @@ tls_process(struct tls_multi *multi,
              state_name(ks_lame->state),
              to_link->len,
              *wakeup);
+        state_change = tls_process_state(multi, session, to_link, to_link_addr,
+                                         to_link_socket_info, wakeup);
 
-        state_change = false;
-
-        /*
-         * TLS activity is finished once we get to S_ACTIVE,
-         * though we will still process acknowledgements.
-         *
-         * CHANGED with 2.0 -> now we may send tunnel configuration
-         * info over the control channel.
-         */
-
-        /* Initial handshake */
-        if (ks->state == S_INITIAL)
-        {
-            state_change = session_move_pre_start(session, ks);
-        }
-
-        /* Are we timed out on receive? */
-        if (now >= ks->must_negotiate && ks->state < S_ACTIVE)
-        {
-            msg(D_TLS_ERRORS,
-                "TLS Error: TLS key negotiation failed to occur within %d seconds (check your network connectivity)",
-                session->opt->handshake_window);
-            goto error;
-        }
-
-        /* Wait for Initial Handshake ACK */
-        if (ks->state == S_PRE_START && no_pending_reliable_packets(ks))
-        {
-            ks->state = S_START;
-            state_change = true;
-
-            /*
-             * Attempt CRL reload before TLS negotiation. Won't be performed if
-             * the file was not modified since the last reload
-             */
-            if (session->opt->crl_file
-                && !(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))
-            {
-                tls_ctx_reload_crl(&session->opt->ssl_ctx,
-                                   session->opt->crl_file, session->opt->crl_file_inline);
-            }
-
-            /* New connection, remove any old X509 env variables */
-            tls_x509_clear_env(session->opt->es);
-
-            dmsg(D_TLS_DEBUG_MED, "STATE S_START");
-        }
-
-        /* Wait for ACK */
-        if (((ks->state == S_GOT_KEY && !session->opt->server)
-             || (ks->state == S_SENT_KEY && session->opt->server))
-             && no_pending_reliable_packets(ks))
+        if (ks->state == S_ERROR)
         {
-            session_move_active(multi, session, to_link_socket_info, ks);
-            state_change = true;
-        }
-
-        /* Reliable buffer to outgoing TCP/UDP (send up to CONTROL_SEND_ACK_MAX ACKs
-         * for previously received packets) */
-        if (!to_link->len && reliable_can_send(ks->send_reliable))
-        {
-            int opcode;
-
-            struct buffer *buf = reliable_send(ks->send_reliable, &opcode);
-            ASSERT(buf);
-            struct buffer b = *buf;
-            INCR_SENT;
-
-            write_control_auth(session, ks, &b, to_link_addr, opcode,
-                               CONTROL_SEND_ACK_MAX, true);
-            *to_link = b;
-            active = true;
-            state_change = true;
-            dmsg(D_TLS_DEBUG, "Reliable -> TCP/UDP");
-            break;
-        }
-
-        /* Write incoming ciphertext to TLS object */
-        struct buffer *buf = reliable_get_buf_sequenced(ks->rec_reliable);
-        if (buf)
-        {
-            int status = 0;
-            if (buf->len)
-            {
-                status = key_state_write_ciphertext(&ks->ks_ssl, buf);
-                if (status == -1)
-                {
-                    msg(D_TLS_ERRORS,
-                        "TLS Error: Incoming Ciphertext -> TLS object write error");
-                    goto error;
-                }
-            }
-            else
-            {
-                status = 1;
-            }
-            if (status == 1)
-            {
-                reliable_mark_deleted(ks->rec_reliable, buf);
-                state_change = true;
-                dmsg(D_TLS_DEBUG, "Incoming Ciphertext -> TLS");
-            }
-        }
-
-        /* Read incoming plaintext from TLS object */
-        buf = &ks->plaintext_read_buf;
-        if (!buf->len)
-        {
-            int status;
-
-            ASSERT(buf_init(buf, 0));
-            status = key_state_read_plaintext(&ks->ks_ssl, buf, TLS_CHANNEL_BUF_SIZE);
-            update_time();
-            if (status == -1)
-            {
-                msg(D_TLS_ERRORS, "TLS Error: TLS object -> incoming plaintext read error");
-                goto error;
-            }
-            if (status == 1)
-            {
-                state_change = true;
-                dmsg(D_TLS_DEBUG, "TLS -> Incoming Plaintext");
-
-                /* More data may be available, wake up again asap to check. */
-                *wakeup = 0;
-            }
-        }
-
-        /* Send Key */
-        buf = &ks->plaintext_write_buf;
-        if (!buf->len && ((ks->state == S_START && !session->opt->server)
-                          || (ks->state == S_GOT_KEY && session->opt->server)))
-        {
-            if (!key_method_2_write(buf, multi, session))
-            {
-                goto error;
-            }
-
-            state_change = true;
-            dmsg(D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
-            ks->state = S_SENT_KEY;
-        }
-
-        /* Receive Key */
-        buf = &ks->plaintext_read_buf;
-        if (buf->len
-            && ((ks->state == S_SENT_KEY && !session->opt->server)
-                || (ks->state == S_START && session->opt->server)))
-        {
-            if (!key_method_2_read(buf, multi, session))
-            {
-                goto error;
-            }
-
-            state_change = true;
-            dmsg(D_TLS_DEBUG_MED, "STATE S_GOT_KEY");
-            ks->state = S_GOT_KEY;
-        }
-
-        /* Write outgoing plaintext to TLS object */
-        buf = &ks->plaintext_write_buf;
-        if (buf->len)
-        {
-            int status = key_state_write_plaintext(&ks->ks_ssl, buf);
-            if (status == -1)
-            {
-                msg(D_TLS_ERRORS,
-                    "TLS ERROR: Outgoing Plaintext -> TLS object write error");
-                goto error;
-            }
-            if (status == 1)
-            {
-                state_change = true;
-                dmsg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
-            }
+            return false;
         }
 
-        /* Outgoing Ciphertext to reliable buffer */
-        if (ks->state >= S_START)
-        {
-            buf = reliable_get_buf_output_sequenced(ks->send_reliable);
-            if (buf)
-            {
-                int status = key_state_read_ciphertext(&ks->ks_ssl, buf, multi->opt.frame.tun_mtu);
-
-                if (status == -1)
-                {
-                    msg(D_TLS_ERRORS,
-                        "TLS Error: Ciphertext -> reliable TCP/UDP transport read error");
-                    goto error;
-                }
-                if (status == 1)
-                {
-                    reliable_mark_active_outgoing(ks->send_reliable, buf, P_CONTROL_V1);
-                    INCR_GENERATED;
-                    state_change = true;
-                    dmsg(D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
-                }
-            }
-        }
     }
-    while (state_change);
 
     update_time();
 
@@ -2755,7 +2770,6 @@ tls_process(struct tls_multi *multi,
         write_control_auth(session, ks, &buf, to_link_addr, P_ACK_V1,
                            RELIABLE_ACK_SIZE, false);
         *to_link = buf;
-        active = true;
         dmsg(D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
     }
 
@@ -2778,6 +2792,8 @@ tls_process(struct tls_multi *multi,
                                     ks->established + session->opt->renegotiate_seconds - now);
         }
 
+        dmsg(D_TLS_DEBUG, "TLS: tls_process: timeout set to %d", *wakeup);
+
         /* prevent event-loop spinning by setting minimum wakeup of 1 second */
         if (*wakeup <= 0)
         {
@@ -2785,22 +2801,18 @@ tls_process(struct tls_multi *multi,
 
             /* if we had something to send to remote, but to_link was busy,
              * let caller know we need to be called again soon */
-            active = true;
+            return true;
         }
 
-        dmsg(D_TLS_DEBUG, "TLS: tls_process: timeout set to %d", *wakeup);
+        /* If any of the state changes resulted in the to_link buffer being
+         * set, we are also active */
+        if (to_link->len)
+        {
+            return true;
+        }
 
-        gc_free(&gc);
-        return active;
+        return false;
     }
-
-error:
-    tls_clear_error();
-    ks->state = S_ERROR;
-    msg(D_TLS_ERRORS, "TLS Error: TLS handshake failed");
-    INCR_ERROR;
-    gc_free(&gc);
-    return false;
 }
 
 /*
-- 
2.32.0 (Apple Git-132)


