From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:36:51 +0200
Message-Id: <20200810143707.5834-2-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 01/17] Refactor/Reformat tls_pre_decrypt
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

- Extract data packet handling to its own function
- Replace two instances of
          if (x) { code }
  with
          if (!x) return; code

- Remove extra curly braces that were used for pre C99 code style
  to be able to declare variables in the middle of a block

This patch is easier to review with "ignore white space" as the
diff is then a lot smaller in that case and the changes more obvious.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 791 ++++++++++++++++++++++++----------------------
 1 file changed, 410 insertions(+), 381 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 06dc9f8f..6d146a63 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3166,6 +3166,102 @@ nohard:
  * to implement a multiplexed TLS channel over the TCP/UDP port.
  */
 
+static inline void
+handle_data_channel_paket(struct tls_multi *multi,
+                          const struct link_socket_actual *from,
+                          struct buffer *buf,
+                          struct crypto_options **opt,
+                          bool floated,
+                          const uint8_t **ad_start)
+{
+    struct gc_arena gc = gc_new();
+
+    uint8_t c = *BPTR(buf);
+    int op = c >> P_OPCODE_SHIFT;
+    int key_id = c & P_KEY_ID_MASK;
+
+    /* data channel packet */
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = multi->key_scan[i];
+
+        /*
+         * This is the basic test of TLS state compatibility between a local OpenVPN
+         * instance and its remote peer.
+         *
+         * If the test fails, it tells us that we are getting a packet from a source
+         * which claims reference to a prior negotiated TLS session, but the local
+         * OpenVPN instance has no memory of such a negotiation.
+         *
+         * It almost always occurs on UDP sessions when the passive side of the
+         * connection is restarted without the active side restarting as well (the
+         * passive side is the server which only listens for the connections, the
+         * active side is the client which initiates connections).
+         */
+        if (DECRYPT_KEY_ENABLED(multi, ks)
+            && key_id == ks->key_id
+            && (ks->authenticated == KS_AUTH_TRUE)
+            && (floated || link_socket_actual_match(from, &ks->remote_addr)))
+        {
+            if (!ks->crypto_options.key_ctx_bi.initialized)
+            {
+                msg(D_MULTI_DROPPED,
+                    "Key %s [%d] not initialized (yet), dropping packet.",
+                    print_link_socket_actual(from, &gc), key_id);
+                goto error_lite;
+            }
+
+            /* return appropriate data channel decrypt key in opt */
+            *opt = &ks->crypto_options;
+            if (op == P_DATA_V2)
+            {
+                *ad_start = BPTR(buf);
+            }
+            ASSERT(buf_advance(buf, 1));
+            if (op == P_DATA_V1)
+            {
+                *ad_start = BPTR(buf);
+            }
+            else if (op == P_DATA_V2)
+            {
+                if (buf->len < 4)
+                {
+                    msg(D_TLS_ERRORS, "Protocol error: received P_DATA_V2 from %s but length is < 4",
+                        print_link_socket_actual(from, &gc));
+                    goto error;
+                }
+                ASSERT(buf_advance(buf, 3));
+            }
+
+            ++ks->n_packets;
+            ks->n_bytes += buf->len;
+            dmsg(D_TLS_KEYSELECT,
+                 "TLS: tls_pre_decrypt, key_id=%d, IP=%s",
+                 key_id, print_link_socket_actual(from, &gc));
+            gc_free(&gc);
+            return;
+        }
+    }
+
+    msg(D_TLS_ERRORS,
+        "TLS Error: local/remote TLS keys are out of sync: %s [%d]",
+        print_link_socket_actual(from, &gc), key_id);
+    goto error_lite;
+
+
+done:
+    buf->len = 0;
+    *opt = NULL;
+    gc_free(&gc);
+    return;
+
+error:
+    ++multi->n_soft_errors;
+error_lite:
+    tls_clear_error();
+    goto done;
+}
+
 /*
  *
  * When we are in TLS mode, this is the first routine which sees
@@ -3199,440 +3295,374 @@ tls_pre_decrypt(struct tls_multi *multi,
                 bool floated,
                 const uint8_t **ad_start)
 {
+
+    if (buf->len <= 0)
+    {
+        buf->len = 0;
+        *opt = NULL;
+        return false;
+    }
+
     struct gc_arena gc = gc_new();
     bool ret = false;
 
-    if (buf->len > 0)
+    /* get opcode  */
+    uint8_t pkt_firstbyte = *BPTR(buf);
+    int op = pkt_firstbyte >> P_OPCODE_SHIFT;
+
+    if ((op == P_DATA_V1) || (op == P_DATA_V2))
     {
-        int i;
-        int op;
-        int key_id;
+        handle_data_channel_paket(multi, from, buf, opt, floated, ad_start);
+        return false;
+    }
 
-        /* get opcode and key ID */
+    /* get key_id */
+    int key_id = pkt_firstbyte & P_KEY_ID_MASK;
+
+    /* control channel packet */
+    bool do_burst = false;
+    bool new_link = false;
+    struct session_id sid;         /* remote session ID */
+
+    /* verify legal opcode */
+    if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
+    {
+        if (op == P_CONTROL_HARD_RESET_CLIENT_V1
+            || op == P_CONTROL_HARD_RESET_SERVER_V1)
         {
-            uint8_t c = *BPTR(buf);
-            op = c >> P_OPCODE_SHIFT;
-            key_id = c & P_KEY_ID_MASK;
+            msg(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
         }
+        msg(D_TLS_ERRORS,
+            "TLS Error: unknown opcode received from %s op=%d",
+            print_link_socket_actual(from, &gc), op);
+        goto error;
+    }
 
-        if ((op == P_DATA_V1) || (op == P_DATA_V2))
+    /* hard reset ? */
+    if (is_hard_reset_method2(op))
+    {
+        /* verify client -> server or server -> client connection */
+        if (((op == P_CONTROL_HARD_RESET_CLIENT_V2
+              || op == P_CONTROL_HARD_RESET_CLIENT_V3) && !multi->opt.server)
+            || ((op == P_CONTROL_HARD_RESET_SERVER_V2) && multi->opt.server))
         {
-            /* data channel packet */
-            for (i = 0; i < KEY_SCAN_SIZE; ++i)
-            {
-                struct key_state *ks = multi->key_scan[i];
-
-                /*
-                 * This is the basic test of TLS state compatibility between a local OpenVPN
-                 * instance and its remote peer.
-                 *
-                 * If the test fails, it tells us that we are getting a packet from a source
-                 * which claims reference to a prior negotiated TLS session, but the local
-                 * OpenVPN instance has no memory of such a negotiation.
-                 *
-                 * It almost always occurs on UDP sessions when the passive side of the
-                 * connection is restarted without the active side restarting as well (the
-                 * passive side is the server which only listens for the connections, the
-                 * active side is the client which initiates connections).
-                 */
-                if (DECRYPT_KEY_ENABLED(multi, ks)
-                    && key_id == ks->key_id
-                    && (ks->authenticated == KS_AUTH_TRUE)
-                    && (floated || link_socket_actual_match(from, &ks->remote_addr)))
-                {
-                    if (!ks->crypto_options.key_ctx_bi.initialized)
-                    {
-                        msg(D_MULTI_DROPPED,
-                            "Key %s [%d] not initialized (yet), dropping packet.",
-                            print_link_socket_actual(from, &gc), key_id);
-                        goto error_lite;
-                    }
-
-                    /* return appropriate data channel decrypt key in opt */
-                    *opt = &ks->crypto_options;
-                    if (op == P_DATA_V2)
-                    {
-                        *ad_start = BPTR(buf);
-                    }
-                    ASSERT(buf_advance(buf, 1));
-                    if (op == P_DATA_V1)
-                    {
-                        *ad_start = BPTR(buf);
-                    }
-                    else if (op == P_DATA_V2)
-                    {
-                        if (buf->len < 4)
-                        {
-                            msg(D_TLS_ERRORS, "Protocol error: received P_DATA_V2 from %s but length is < 4",
-                                print_link_socket_actual(from, &gc));
-                            goto error;
-                        }
-                        ASSERT(buf_advance(buf, 3));
-                    }
+            msg(D_TLS_ERRORS,
+                "TLS Error: client->client or server->server connection attempted from %s",
+                print_link_socket_actual(from, &gc));
+            goto error;
+        }
+    }
 
-                    ++ks->n_packets;
-                    ks->n_bytes += buf->len;
-                    dmsg(D_TLS_KEYSELECT,
-                         "TLS: tls_pre_decrypt, key_id=%d, IP=%s",
-                         key_id, print_link_socket_actual(from, &gc));
-                    gc_free(&gc);
-                    return ret;
-                }
-            }
+    /*
+     * Authenticate Packet
+     */
+    dmsg(D_TLS_DEBUG, "TLS: control channel, op=%s, IP=%s",
+         packet_opcode_name(op), print_link_socket_actual(from, &gc));
 
+    /* get remote session-id */
+    {
+        struct buffer tmp = *buf;
+        buf_advance(&tmp, 1);
+        if (!session_id_read(&sid, &tmp) || !session_id_defined(&sid))
+        {
             msg(D_TLS_ERRORS,
-                "TLS Error: local/remote TLS keys are out of sync: %s [%d]",
-                print_link_socket_actual(from, &gc), key_id);
-            goto error_lite;
+                "TLS Error: session-id not found in packet from %s",
+                print_link_socket_actual(from, &gc));
+            goto error;
         }
-        else                      /* control channel packet */
-        {
-            bool do_burst = false;
-            bool new_link = false;
-            struct session_id sid; /* remote session ID */
+    }
+
+    int i;
+    /* use session ID to match up packet with appropriate tls_session object */
+    for (i = 0; i < TM_SIZE; ++i)
+    {
+        struct tls_session *session = &multi->session[i];
+        struct key_state *ks = &session->key[KS_PRIMARY];
+
+        dmsg(D_TLS_DEBUG,
+             "TLS: initial packet test, i=%d state=%s, mysid=%s, rec-sid=%s, rec-ip=%s, stored-sid=%s, stored-ip=%s",
+             i,
+             state_name(ks->state),
+             session_id_print(&session->session_id, &gc),
+             session_id_print(&sid, &gc),
+             print_link_socket_actual(from, &gc),
+             session_id_print(&ks->session_id_remote, &gc),
+             print_link_socket_actual(&ks->remote_addr, &gc));
 
-            /* verify legal opcode */
-            if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
+        if (session_id_equal(&ks->session_id_remote, &sid))
+        /* found a match */
+        {
+            if (i == TM_LAME_DUCK)
             {
-                if (op == P_CONTROL_HARD_RESET_CLIENT_V1
-                    || op == P_CONTROL_HARD_RESET_SERVER_V1)
-                {
-                    msg(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
-                }
                 msg(D_TLS_ERRORS,
-                    "TLS Error: unknown opcode received from %s op=%d",
-                    print_link_socket_actual(from, &gc), op);
+                    "TLS ERROR: received control packet with stale session-id=%s",
+                    session_id_print(&sid, &gc));
                 goto error;
             }
+            dmsg(D_TLS_DEBUG,
+                 "TLS: found match, session[%d], sid=%s",
+                 i, session_id_print(&sid, &gc));
+            break;
+        }
+    }
 
-            /* hard reset ? */
-            if (is_hard_reset_method2(op))
-            {
-                /* verify client -> server or server -> client connection */
-                if (((op == P_CONTROL_HARD_RESET_CLIENT_V2
-                      || op == P_CONTROL_HARD_RESET_CLIENT_V3) && !multi->opt.server)
-                    || ((op == P_CONTROL_HARD_RESET_SERVER_V2) && multi->opt.server))
-                {
-                    msg(D_TLS_ERRORS,
-                        "TLS Error: client->client or server->server connection attempted from %s",
-                        print_link_socket_actual(from, &gc));
-                    goto error;
-                }
-            }
-
-            /*
-             * Authenticate Packet
-             */
-            dmsg(D_TLS_DEBUG, "TLS: control channel, op=%s, IP=%s",
-                 packet_opcode_name(op), print_link_socket_actual(from, &gc));
+    /*
+     * Hard reset and session id does not match any session in
+     * multi->session: Possible initial packet
+     */
+    if (i == TM_SIZE && is_hard_reset_method2(op))
+    {
+        struct tls_session *session = &multi->session[TM_ACTIVE];
+        struct key_state *ks = &session->key[KS_PRIMARY];
 
-            /* get remote session-id */
+        /*
+         * If we have no session currently in progress, the initial packet will
+         * open a new session in TM_ACTIVE rather than TM_UNTRUSTED.
+         */
+        if (!session_id_defined(&ks->session_id_remote))
+        {
+            if (multi->opt.single_session && multi->n_sessions)
             {
-                struct buffer tmp = *buf;
-                buf_advance(&tmp, 1);
-                if (!session_id_read(&sid, &tmp) || !session_id_defined(&sid))
-                {
-                    msg(D_TLS_ERRORS,
-                        "TLS Error: session-id not found in packet from %s",
-                        print_link_socket_actual(from, &gc));
-                    goto error;
-                }
+                msg(D_TLS_ERRORS,
+                    "TLS Error: Cannot accept new session request from %s due to session context expire or --single-session [1]",
+                    print_link_socket_actual(from, &gc));
+                goto error;
             }
 
-            /* use session ID to match up packet with appropriate tls_session object */
-            for (i = 0; i < TM_SIZE; ++i)
+#ifdef ENABLE_MANAGEMENT
+            if (management)
             {
-                struct tls_session *session = &multi->session[i];
-                struct key_state *ks = &session->key[KS_PRIMARY];
-
-                dmsg(D_TLS_DEBUG,
-                     "TLS: initial packet test, i=%d state=%s, mysid=%s, rec-sid=%s, rec-ip=%s, stored-sid=%s, stored-ip=%s",
-                     i,
-                     state_name(ks->state),
-                     session_id_print(&session->session_id, &gc),
-                     session_id_print(&sid, &gc),
-                     print_link_socket_actual(from, &gc),
-                     session_id_print(&ks->session_id_remote, &gc),
-                     print_link_socket_actual(&ks->remote_addr, &gc));
-
-                if (session_id_equal(&ks->session_id_remote, &sid))
-                /* found a match */
-                {
-                    if (i == TM_LAME_DUCK)
-                    {
-                        msg(D_TLS_ERRORS,
-                            "TLS ERROR: received control packet with stale session-id=%s",
-                            session_id_print(&sid, &gc));
-                        goto error;
-                    }
-                    dmsg(D_TLS_DEBUG,
-                         "TLS: found match, session[%d], sid=%s",
-                         i, session_id_print(&sid, &gc));
-                    break;
-                }
+                management_set_state(management,
+                                     OPENVPN_STATE_AUTH,
+                                     NULL,
+                                     NULL,
+                                     NULL,
+                                     NULL,
+                                     NULL);
             }
+#endif
 
-            /*
-             * Hard reset and session id does not match any session in
-             * multi->session: Possible initial packet
-             */
-            if (i == TM_SIZE && is_hard_reset_method2(op))
-            {
-                struct tls_session *session = &multi->session[TM_ACTIVE];
-                struct key_state *ks = &session->key[KS_PRIMARY];
-
-                /*
-                 * If we have no session currently in progress, the initial packet will
-                 * open a new session in TM_ACTIVE rather than TM_UNTRUSTED.
-                 */
-                if (!session_id_defined(&ks->session_id_remote))
-                {
-                    if (multi->opt.single_session && multi->n_sessions)
-                    {
-                        msg(D_TLS_ERRORS,
-                            "TLS Error: Cannot accept new session request from %s due to session context expire or --single-session [1]",
-                            print_link_socket_actual(from, &gc));
-                        goto error;
-                    }
+            msg(D_TLS_DEBUG_LOW,
+                "TLS: Initial packet from %s, sid=%s",
+                print_link_socket_actual(from, &gc),
+                session_id_print(&sid, &gc));
 
-#ifdef ENABLE_MANAGEMENT
-                    if (management)
-                    {
-                        management_set_state(management,
-                                             OPENVPN_STATE_AUTH,
-                                             NULL,
-                                             NULL,
-                                             NULL,
-                                             NULL,
-                                             NULL);
-                    }
-#endif
+            do_burst = true;
+            new_link = true;
+            i = TM_ACTIVE;
+            session->untrusted_addr = *from;
+        }
+    }
 
-                    msg(D_TLS_DEBUG_LOW,
-                        "TLS: Initial packet from %s, sid=%s",
-                        print_link_socket_actual(from, &gc),
-                        session_id_print(&sid, &gc));
+    /*
+     * If we detected new session in the last if block, i has
+     * changed to TM_ACTIVE, so check the condition again.
+     */
+    if (i == TM_SIZE && is_hard_reset_method2(op))
+    {
+        /*
+         * No match with existing sessions,
+         * probably a new session.
+         */
+        struct tls_session *session = &multi->session[TM_UNTRUSTED];
 
-                    do_burst = true;
-                    new_link = true;
-                    i = TM_ACTIVE;
-                    session->untrusted_addr = *from;
-                }
-            }
+        /*
+         * If --single-session, don't allow any hard-reset connection request
+         * unless it the the first packet of the session.
+         */
+        if (multi->opt.single_session)
+        {
+            msg(D_TLS_ERRORS,
+                "TLS Error: Cannot accept new session request from %s due to session context expire or --single-session [2]",
+                print_link_socket_actual(from, &gc));
+            goto error;
+        }
 
-            /*
-             * If we detected new session in the last if block, i has
-             * changed to TM_ACTIVE, so check the condition again.
-             */
-            if (i == TM_SIZE && is_hard_reset_method2(op))
-            {
-                /*
-                 * No match with existing sessions,
-                 * probably a new session.
-                 */
-                struct tls_session *session = &multi->session[TM_UNTRUSTED];
-
-                /*
-                 * If --single-session, don't allow any hard-reset connection request
-                 * unless it the the first packet of the session.
-                 */
-                if (multi->opt.single_session)
-                {
-                    msg(D_TLS_ERRORS,
-                        "TLS Error: Cannot accept new session request from %s due to session context expire or --single-session [2]",
-                        print_link_socket_actual(from, &gc));
-                    goto error;
-                }
+        if (!read_control_auth(buf, &session->tls_wrap, from,
+                               session->opt))
+        {
+            goto error;
+        }
 
-                if (!read_control_auth(buf, &session->tls_wrap, from,
-                                       session->opt))
-                {
-                    goto error;
-                }
+        /*
+         * New session-initiating control packet is authenticated at this point,
+         * assuming that the --tls-auth command line option was used.
+         *
+         * Without --tls-auth, we leave authentication entirely up to TLS.
+         */
+        msg(D_TLS_DEBUG_LOW,
+            "TLS: new session incoming connection from %s",
+            print_link_socket_actual(from, &gc));
 
-                /*
-                 * New session-initiating control packet is authenticated at this point,
-                 * assuming that the --tls-auth command line option was used.
-                 *
-                 * Without --tls-auth, we leave authentication entirely up to TLS.
-                 */
-                msg(D_TLS_DEBUG_LOW,
-                    "TLS: new session incoming connection from %s",
-                    print_link_socket_actual(from, &gc));
+        new_link = true;
+        i = TM_UNTRUSTED;
+        session->untrusted_addr = *from;
+    }
+    else
+    {
+        struct tls_session *session = &multi->session[i];
+        struct key_state *ks = &session->key[KS_PRIMARY];
 
-                new_link = true;
-                i = TM_UNTRUSTED;
-                session->untrusted_addr = *from;
-            }
-            else
+        /*
+         * Packet must belong to an existing session.
+         */
+        if (i != TM_ACTIVE && i != TM_UNTRUSTED)
+        {
+            msg(D_TLS_ERRORS,
+                "TLS Error: Unroutable control packet received from %s (si=%d op=%s)",
+                print_link_socket_actual(from, &gc),
+                i,
+                packet_opcode_name(op));
+            goto error;
+        }
+
+        /*
+         * Verify remote IP address
+         */
+        if (!new_link && !link_socket_actual_match(&ks->remote_addr, from))
+        {
+            msg(D_TLS_ERRORS, "TLS Error: Received control packet from unexpected IP addr: %s",
+                print_link_socket_actual(from, &gc));
+            goto error;
+        }
+
+        /*
+         * Remote is requesting a key renegotiation
+         */
+        if (op == P_CONTROL_SOFT_RESET_V1
+            && DECRYPT_KEY_ENABLED(multi, ks))
+        {
+            if (!read_control_auth(buf, &session->tls_wrap, from,
+                                   session->opt))
             {
-                struct tls_session *session = &multi->session[i];
-                struct key_state *ks = &session->key[KS_PRIMARY];
+                goto error;
+            }
 
-                /*
-                 * Packet must belong to an existing session.
-                 */
-                if (i != TM_ACTIVE && i != TM_UNTRUSTED)
-                {
-                    msg(D_TLS_ERRORS,
-                        "TLS Error: Unroutable control packet received from %s (si=%d op=%s)",
-                        print_link_socket_actual(from, &gc),
-                        i,
-                        packet_opcode_name(op));
-                    goto error;
-                }
+            key_state_soft_reset(session);
 
-                /*
-                 * Verify remote IP address
-                 */
-                if (!new_link && !link_socket_actual_match(&ks->remote_addr, from))
-                {
-                    msg(D_TLS_ERRORS, "TLS Error: Received control packet from unexpected IP addr: %s",
-                        print_link_socket_actual(from, &gc));
-                    goto error;
-                }
+            dmsg(D_TLS_DEBUG,
+                 "TLS: received P_CONTROL_SOFT_RESET_V1 s=%d sid=%s",
+                 i, session_id_print(&sid, &gc));
+        }
+        else
+        {
+            /*
+             * Remote responding to our key renegotiation request?
+             */
+            if (op == P_CONTROL_SOFT_RESET_V1)
+            {
+                do_burst = true;
+            }
 
-                /*
-                 * Remote is requesting a key renegotiation
-                 */
-                if (op == P_CONTROL_SOFT_RESET_V1
-                    && DECRYPT_KEY_ENABLED(multi, ks))
-                {
-                    if (!read_control_auth(buf, &session->tls_wrap, from,
-                                           session->opt))
-                    {
-                        goto error;
-                    }
+            if (!read_control_auth(buf, &session->tls_wrap, from,
+                                   session->opt))
+            {
+                goto error;
+            }
 
-                    key_state_soft_reset(session);
+            dmsg(D_TLS_DEBUG,
+                 "TLS: received control channel packet s#=%d sid=%s",
+                 i, session_id_print(&sid, &gc));
+        }
+    }
 
-                    dmsg(D_TLS_DEBUG,
-                         "TLS: received P_CONTROL_SOFT_RESET_V1 s=%d sid=%s",
-                         i, session_id_print(&sid, &gc));
-                }
-                else
-                {
-                    /*
-                     * Remote responding to our key renegotiation request?
-                     */
-                    if (op == P_CONTROL_SOFT_RESET_V1)
-                    {
-                        do_burst = true;
-                    }
+    /*
+     * We have an authenticated control channel packet (if --tls-auth was set).
+     * Now pass to our reliability layer which deals with
+     * packet acknowledgements, retransmits, sequencing, etc.
+     */
+    struct tls_session *session = &multi->session[i];
+    struct key_state *ks = &session->key[KS_PRIMARY];
 
-                    if (!read_control_auth(buf, &session->tls_wrap, from,
-                                           session->opt))
-                    {
-                        goto error;
-                    }
+    /* Make sure we were initialized and that we're not in an error state */
+    ASSERT(ks->state != S_UNDEF);
+    ASSERT(ks->state != S_ERROR);
+    ASSERT(session_id_defined(&session->session_id));
 
-                    dmsg(D_TLS_DEBUG,
-                         "TLS: received control channel packet s#=%d sid=%s",
-                         i, session_id_print(&sid, &gc));
-                }
-            }
+    /* Let our caller know we processed a control channel packet */
+    ret = true;
 
-            /*
-             * We have an authenticated control channel packet (if --tls-auth was set).
-             * Now pass to our reliability layer which deals with
-             * packet acknowledgements, retransmits, sequencing, etc.
-             */
-            {
-                struct tls_session *session = &multi->session[i];
-                struct key_state *ks = &session->key[KS_PRIMARY];
+    /*
+     * Set our remote address and remote session_id
+     */
+    if (new_link)
+    {
+        ks->session_id_remote = sid;
+        ks->remote_addr = *from;
+        ++multi->n_sessions;
+    }
+    else if (!link_socket_actual_match(&ks->remote_addr, from))
+    {
+        msg(D_TLS_ERRORS,
+            "TLS Error: Existing session control channel packet from unknown IP address: %s",
+            print_link_socket_actual(from, &gc));
+        goto error;
+    }
 
-                /* Make sure we were initialized and that we're not in an error state */
-                ASSERT(ks->state != S_UNDEF);
-                ASSERT(ks->state != S_ERROR);
-                ASSERT(session_id_defined(&session->session_id));
+    /*
+     * Should we do a retransmit of all unacknowledged packets in
+     * the send buffer?  This improves the start-up efficiency of the
+     * initial key negotiation after the 2nd peer comes online.
+     */
+    if (do_burst && !session->burst)
+    {
+        reliable_schedule_now(ks->send_reliable);
+        session->burst = true;
+    }
 
-                /* Let our caller know we processed a control channel packet */
-                ret = true;
+    /* Check key_id */
+    if (ks->key_id != key_id)
+    {
+        msg(D_TLS_ERRORS,
+            "TLS ERROR: local/remote key IDs out of sync (%d/%d) ID: %s",
+            ks->key_id, key_id, print_key_id(multi, &gc));
+        goto error;
+    }
 
-                /*
-                 * Set our remote address and remote session_id
-                 */
-                if (new_link)
-                {
-                    ks->session_id_remote = sid;
-                    ks->remote_addr = *from;
-                    ++multi->n_sessions;
-                }
-                else if (!link_socket_actual_match(&ks->remote_addr, from))
-                {
-                    msg(D_TLS_ERRORS,
-                        "TLS Error: Existing session control channel packet from unknown IP address: %s",
-                        print_link_socket_actual(from, &gc));
-                    goto error;
-                }
+    /*
+     * Process incoming ACKs for packets we can now
+     * delete from reliable send buffer
+     */
+    {
+        /* buffers all packet IDs to delete from send_reliable */
+        struct reliable_ack send_ack;
 
-                /*
-                 * Should we do a retransmit of all unacknowledged packets in
-                 * the send buffer?  This improves the start-up efficiency of the
-                 * initial key negotiation after the 2nd peer comes online.
-                 */
-                if (do_burst && !session->burst)
-                {
-                    reliable_schedule_now(ks->send_reliable);
-                    session->burst = true;
-                }
+        send_ack.len = 0;
+        if (!reliable_ack_read(&send_ack, buf, &session->session_id))
+        {
+            msg(D_TLS_ERRORS,
+                "TLS Error: reading acknowledgement record from packet");
+            goto error;
+        }
+        reliable_send_purge(ks->send_reliable, &send_ack);
+    }
 
-                /* Check key_id */
-                if (ks->key_id != key_id)
-                {
-                    msg(D_TLS_ERRORS,
-                        "TLS ERROR: local/remote key IDs out of sync (%d/%d) ID: %s",
-                        ks->key_id, key_id, print_key_id(multi, &gc));
-                    goto error;
-                }
+    if (op != P_ACK_V1 && reliable_can_get(ks->rec_reliable))
+    {
+        packet_id_type id;
 
-                /*
-                 * Process incoming ACKs for packets we can now
-                 * delete from reliable send buffer
-                 */
+        /* Extract the packet ID from the packet */
+        if (reliable_ack_read_packet_id(buf, &id))
+        {
+            /* Avoid deadlock by rejecting packet that would de-sequentialize receive buffer */
+            if (reliable_wont_break_sequentiality(ks->rec_reliable, id))
+            {
+                if (reliable_not_replay(ks->rec_reliable, id))
                 {
-                    /* buffers all packet IDs to delete from send_reliable */
-                    struct reliable_ack send_ack;
-
-                    send_ack.len = 0;
-                    if (!reliable_ack_read(&send_ack, buf, &session->session_id))
+                    /* Save incoming ciphertext packet to reliable buffer */
+                    struct buffer *in = reliable_get_buf(ks->rec_reliable);
+                    ASSERT(in);
+                    if (!buf_copy(in, buf))
                     {
-                        msg(D_TLS_ERRORS,
-                            "TLS Error: reading acknowledgement record from packet");
+                        msg(D_MULTI_DROPPED,
+                            "Incoming control channel packet too big, dropping.");
                         goto error;
                     }
-                    reliable_send_purge(ks->send_reliable, &send_ack);
+                    reliable_mark_active_incoming(ks->rec_reliable, in, id, op);
                 }
 
-                if (op != P_ACK_V1 && reliable_can_get(ks->rec_reliable))
-                {
-                    packet_id_type id;
-
-                    /* Extract the packet ID from the packet */
-                    if (reliable_ack_read_packet_id(buf, &id))
-                    {
-                        /* Avoid deadlock by rejecting packet that would de-sequentialize receive buffer */
-                        if (reliable_wont_break_sequentiality(ks->rec_reliable, id))
-                        {
-                            if (reliable_not_replay(ks->rec_reliable, id))
-                            {
-                                /* Save incoming ciphertext packet to reliable buffer */
-                                struct buffer *in = reliable_get_buf(ks->rec_reliable);
-                                ASSERT(in);
-                                if (!buf_copy(in, buf))
-                                {
-                                    msg(D_MULTI_DROPPED,
-                                        "Incoming control channel packet too big, dropping.");
-                                    goto error;
-                                }
-                                reliable_mark_active_incoming(ks->rec_reliable, in, id, op);
-                            }
-
-                            /* Process outgoing acknowledgment for packet just received, even if it's a replay */
-                            reliable_ack_acknowledge_packet_id(ks->rec_ack, id);
-                        }
-                    }
-                }
+                /* Process outgoing acknowledgment for packet just received, even if it's a replay */
+                reliable_ack_acknowledge_packet_id(ks->rec_ack, id);
             }
         }
     }
@@ -3645,7 +3675,6 @@ done:
 
 error:
     ++multi->n_soft_errors;
-error_lite:
     tls_clear_error();
     goto done;
 }
-- 
2.26.2


