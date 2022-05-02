From: Arne Schwabe <arne@...1227...>
Date: Mon,  2 May 2022 17:43:10 +0200
Message-Id: <20220502154310.836947-1-arne@...1227...>
In-Reply-To: <20220422142953.3805364-9-arne@...1227...>
References: <20220422142953.3805364-9-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Implement stateless,
 HMAC basedsesssion id three way handshake
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

OpenVPN currently has a bit of a weakness in its early three way handshake

A single client reset packet (first packet of the handshake) will
  - trigger creating a session on the server side leading to potential
    ressource exhaustion
  - make the server respond with 3 answers trying to get an ACK for its
    P_CONTROL_HARD_RESET_SERVER_V2 answer making it an amplification

Instead of allocating a connection for each client on the initial packet
OpenVPN will now calculate a session id based on a HMAC that serves as
verifiable cookie that can be checked for authenticity when the client
responds with it. This eliminates the amplification attack and resource
exhaustion attacks. For tls-crypt-v2 clients the HMAC based handshake
is not used yet.

Patch v2: rebase on master
patch v3: fix unit tests, improve comment/style of code

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/doxygen/doc_protocol_overview.h |   2 +
 src/openvpn/init.c                  |   4 +
 src/openvpn/mudp.c                  | 105 ++++++++++++--
 src/openvpn/multi.h                 |   3 +
 src/openvpn/openvpn.h               |   6 +
 src/openvpn/ssl.c                   |  41 +++++-
 src/openvpn/ssl.h                   |   8 ++
 src/openvpn/ssl_pkt.c               | 104 +++++++++++++-
 src/openvpn/ssl_pkt.h               |  54 ++++++-
 tests/unit_tests/openvpn/test_pkt.c | 210 ++++++++++++++++++++++++++--
 10 files changed, 509 insertions(+), 28 deletions(-)

diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
index f26ce3a36..37de1cb0e 100644
--- a/doc/doxygen/doc_protocol_overview.h
+++ b/doc/doxygen/doc_protocol_overview.h
@@ -118,6 +118,8 @@
  * parts:
  *
  *  - local \c session_id (random 64 bit value to identify TLS session).
+ *      (the tls-server side uses a HMAC of the client to create a pseudo
+ *       random number for a SYN Cookie like approach)
  *  - HMAC signature of entire encapsulation header for HMAC firewall
  *    [only if \c --tls-auth is specified] (usually 16 or 20 bytes).
  *  - packet-id for replay protection (4 or 8 bytes, includes sequence
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e41bb9d4b..7e7041a8e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -54,6 +54,7 @@
 #include "forward.h"
 #include "auth_token.h"
 #include "mss.h"
+#include "mudp.h"
 
 #include "memdbg.h"
 
@@ -2973,7 +2974,9 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     if (flags & CF_INIT_TLS_AUTH_STANDALONE)
     {
         c->c2.tls_auth_standalone = tls_auth_standalone_init(&to, &c->c2.gc);
+        c->c2.session_id_hmac = session_id_hmac_init();
     }
+
 }
 
 static void
@@ -2992,6 +2995,7 @@ do_init_frame_tls(struct context *c)
         tls_init_control_channel_frame_parameters(&c->c2.frame, &c->c2.tls_auth_standalone->frame);
         frame_print(&c->c2.tls_auth_standalone->frame, D_MTU_INFO,
                     "TLS-Auth MTU parms");
+        c->c2.tls_auth_standalone->tls_wrap.work = alloc_buf_gc(BUF_SIZE(&c->c2.frame), &c->c2.gc);
     }
 }
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index e5cc36b45..ead61e827 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -40,24 +40,81 @@
 #include <sys/inotify.h>
 #endif
 
+/* Return if this packet should create a new session */
 static bool
-do_pre_decrypt_check(struct multi_context *m)
+do_pre_decrypt_check(struct multi_context *m,
+                     struct tls_pre_decrypt_state *state,
+                     struct mroute_addr addr)
 {
     ASSERT(m->top.c2.tls_auth_standalone);
 
     enum first_packet_verdict verdict;
-    struct tls_pre_decrypt_state state = {0};
 
-    verdict = tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &state,
-                                   &m->top.c2.from, &m->top.c2.buf);
+    struct tls_auth_standalone *tas = m->top.c2.tls_auth_standalone;
 
-    free_tls_pre_decrypt_state(&state);
+    verdict = tls_pre_decrypt_lite(tas, state, &m->top.c2.from, &m->top.c2.buf);
 
-    if (verdict == VERDICT_INVALID || verdict == VERDICT_VALID_CONTROL_V1)
+    hmac_ctx_t *hmac = m->top.c2.session_id_hmac;
+    struct openvpn_sockaddr *from = &m->top.c2.from.dest;
+    int handwindow = m->top.options.handshake_window;
+
+
+    if (verdict == VERDICT_VALID_RESET_V3)
+    {
+        /* For tls-crypt-v2 we need to keep the state of the first packet to
+         * store the unwrapped key */
+        return true;
+    }
+    else if (verdict == VERDICT_VALID_RESET_V2)
     {
+        /* Calculate the session ID HMAC for our reply and create reset packet */
+        struct session_id sid = calculate_session_id_hmac(state->peer_session_id,
+                                                          from, hmac, handwindow, 0);
+        reset_packet_id_send(&tas->tls_wrap.opt.packet_id.send);
+        tas->tls_wrap.opt.packet_id.rec.initialized = true;
+        uint8_t header = 0 | (P_CONTROL_HARD_RESET_SERVER_V2 << P_OPCODE_SHIFT);
+        struct buffer buf = tls_reset_standalone(tas, &sid,
+                                                 &state->peer_session_id, header);
+
+
+        struct context *c = &m->top;
+
+        buf_reset_len(&c->c2.buffers->aux_buf);
+        buf_copy(&c->c2.buffers->aux_buf, &buf);
+        m->hmac_reply = c->c2.buffers->aux_buf;
+        m->hmac_reply_dest = &m->top.c2.from;
+        msg(D_MULTI_DEBUG, "Reset packet from client, sending HMAC based reset challenge");
+        /* We have a reply do not create a new session */
         return false;
+
+    }
+    else if (verdict == VERDICT_VALID_CONTROL_V1 || verdict == VERDICT_VALID_ACK_V1)
+    {
+        /* ACK_V1 contains the peer id (our id) while CONTROL_V1 can but does not
+         * need to contain the peer id */
+        struct gc_arena gc = gc_new();
+
+        bool ret = check_session_id_hmac(state, from, hmac, handwindow);
+
+        const char *peer = print_link_socket_actual(&m->top.c2.from, &gc);
+        if (!ret)
+        {
+
+            msg(D_MULTI_MEDIUM, "Packet with invalid or missing SID from %s", peer);
+
+        }
+        else
+        {
+            msg(D_MULTI_DEBUG, "Valid packet with HMAC challenge from peer (%s), "
+                               "accepting new connection.", peer);
+        }
+        gc_free(&gc);
+
+        return ret;
     }
-    return true;
+
+    /* VERDICT_INVALID */
+    return false;
 }
 
 /*
@@ -114,10 +171,18 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
                 mi = (struct multi_instance *) he->value;
             }
         }
+
+        /* we not have no existing multi instance for this connection */
         if (!mi)
         {
-            if (do_pre_decrypt_check(m))
+            struct tls_pre_decrypt_state state = {0};
+
+            if (do_pre_decrypt_check(m, &state, real))
             {
+                /* This is an unknown session but with valid tls-auth/tls-crypt (or no auth at all),
+                 * if this is the initial packet of a session, we just send a reply with a HMAC session id and do not
+                 * generate a session slot */
+
                 if (frequency_limit_event_allowed(m->new_connection_limiter))
                 {
                     mi = multi_create_instance(m, &real);
@@ -127,6 +192,14 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
                         mi->did_real_hash = true;
                         multi_assign_peer_id(m, mi);
                     }
+                    /* If we have a session ids already, ensure that the state is using the same */
+                    if (session_id_defined(&state.server_session_id)
+                        && session_id_defined((&state.peer_session_id)))
+                    {
+                        mi->context.c2.tls_multi->n_sessions++;
+                        struct tls_session *session = &mi->context.c2.tls_multi->session[TM_ACTIVE];
+                        session_skip_to_pre_start(session, &state, &m->top.c2.from);
+                    }
                 }
                 else
                 {
@@ -135,6 +208,7 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
                         mroute_addr_print(&real, &gc));
                 }
             }
+            free_tls_pre_decrypt_state(&state);
         }
 
 #ifdef ENABLE_DEBUG
@@ -155,7 +229,7 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
 }
 
 /*
- * Send a packet to TCP/UDP socket.
+ * Send a packet to UDP socket.
  */
 static inline void
 multi_process_outgoing_link(struct multi_context *m, const unsigned int mpp_flags)
@@ -165,6 +239,14 @@ multi_process_outgoing_link(struct multi_context *m, const unsigned int mpp_flag
     {
         multi_process_outgoing_link_dowork(m, mi, mpp_flags);
     }
+    if (m->hmac_reply_dest && m->hmac_reply.len > 0)
+    {
+        msg_set_prefix("Connection Attempt");
+        m->top.c2.to_link = m->hmac_reply;
+        m->top.c2.to_link_addr = m->hmac_reply_dest;
+        process_outgoing_link(&m->top);
+        m->hmac_reply_dest = NULL;
+    }
 }
 
 /*
@@ -272,6 +354,10 @@ p2mp_iow_flags(const struct multi_context *m)
     {
         flags |= IOW_MBUF;
     }
+    else if (m->hmac_reply_dest)
+    {
+        flags |= IOW_TO_LINK;
+    }
     else
     {
         flags |= IOW_READ;
@@ -364,4 +450,3 @@ tunnel_server_udp(struct context *top)
     multi_top_free(&multi);
     close_instance(top);
 }
-
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index f89c7dbd2..f1e9ab91f 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -191,6 +191,9 @@ struct multi_context {
     struct context top;         /**< Storage structure for process-wide
                                  *   configuration. */
 
+    struct buffer hmac_reply;
+    struct link_socket_actual *hmac_reply_dest;
+
     /*
      * Timer object for stale route check
      */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 77263dfbe..00cd652fa 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -330,6 +330,12 @@ struct context_2
      *   received from a new client.  See the
      *   \c --tls-auth commandline option. */
 
+
+    hmac_ctx_t *session_id_hmac;
+    /**< the HMAC we use to generate and verify our syn cookie like
+     * session ids from the server.
+     */
+
     /* used to optimize calls to tls_multi_process */
     struct interval tmp_int;
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cb3382d6f..80440c411 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1285,6 +1285,10 @@ tls_auth_standalone_init(struct tls_options *tls_options,
     /* get initial frame parms, still need to finalize */
     tas->frame = tls_options->frame;
 
+    packet_id_init(&tas->tls_wrap.opt.packet_id,
+                   tls_options->replay_window, tls_options->replay_time, "TAS",
+                   0);
+
     return tas;
 }
 
@@ -2398,13 +2402,13 @@ auth_deferred_expire_window(const struct tls_options *o)
 
 /**
  * Move the session from S_INITIAL to S_PRE_START. This will also generate
- * the intial message based on ks->initial_opcode
+ * the initial message based on ks->initial_opcode
  *
  * @return if the state change was succesful
  */
 static bool
 session_move_pre_start(const struct tls_session *session,
-                       struct key_state *ks)
+                       struct key_state *ks, bool skip_initial_send)
 {
     struct buffer *buf = reliable_get_buf_output_sequenced(ks->send_reliable);
     if (!buf)
@@ -2418,6 +2422,13 @@ session_move_pre_start(const struct tls_session *session,
 
     /* null buffer */
     reliable_mark_active_outgoing(ks->send_reliable, buf, ks->initial_opcode);
+
+    /* If we want to skip sending the initial handshake packet we still generate
+     * it to increase internal counters etc. but immediately mark it as done */
+    if (skip_initial_send)
+    {
+        reliable_mark_deleted(ks->send_reliable, buf);
+    }
     INCR_GENERATED;
 
     ks->state = S_PRE_START;
@@ -2491,6 +2502,30 @@ session_move_active(struct tls_multi *multi, struct tls_session *session,
 #endif
 }
 
+bool
+session_skip_to_pre_start(struct tls_session *session,
+                          struct tls_pre_decrypt_state *state,
+                          struct link_socket_actual *from)
+{
+    struct key_state *ks = &session->key[KS_PRIMARY];
+    ks->session_id_remote = state->peer_session_id;
+    ks->remote_addr = *from;
+    session->session_id = state->server_session_id;
+    session->untrusted_addr = *from;
+    session->burst = true;
+
+    /* The OpenVPN protocol implicitly mandates that packet id always start
+     * from 0 in the RESET packets as OpenVPN 2.x will not allow gaps in the
+     * ids and starts always from 0. Since we skip/ignore one (RESET) packet
+     * in each direction, we need to set the ids to 1 */
+    ks->rec_reliable->packet_id = 1;
+    /* for ks->send_reliable->packet_id, session_move_pre_start moves the
+     * counter to 1 */
+    session->tls_wrap.opt.packet_id.send.id = 1;
+    return session_move_pre_start(session, ks, true);
+}
+
+
 
 static bool
 tls_process_state(struct tls_multi *multi,
@@ -2506,7 +2541,7 @@ tls_process_state(struct tls_multi *multi,
     /* Initial handshake */
     if (ks->state == S_INITIAL)
     {
-        state_change = session_move_pre_start(session, ks);
+        state_change = session_move_pre_start(session, ks, false);
     }
 
     /* Are we timed out on receive? */
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index e925a16ea..0ba86d3e6 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -556,4 +556,12 @@ tls_session_generate_data_channel_keys(struct tls_session *session);
 void
 load_xkey_provider(void);
 
+/* Special method to skip the three way handshake RESET stages. This is
+ * used by the HMAC code when seeing a packet that matches the previous
+ * HMAC based stateless server state */
+bool
+session_skip_to_pre_start(struct tls_session *session,
+                          struct tls_pre_decrypt_state *state,
+                          struct link_socket_actual *from);
+
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 7d9172703..9c8154b12 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -320,7 +320,8 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
     /* Allow only the reset packet or the first packet of the actual handshake. */
     if (op != P_CONTROL_HARD_RESET_CLIENT_V2
         && op != P_CONTROL_HARD_RESET_CLIENT_V3
-        && op != P_CONTROL_V1)
+        && op != P_CONTROL_V1
+        && op != P_ACK_V1)
     {
         /*
          * This can occur due to bogus data or DoS packets.
@@ -388,9 +389,17 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
     {
         return VERDICT_VALID_CONTROL_V1;
     }
+    else if (op == P_ACK_V1)
+    {
+        return VERDICT_VALID_ACK_V1;
+    }
+    else if (op == P_CONTROL_HARD_RESET_CLIENT_V3)
+    {
+        return VERDICT_VALID_RESET_V3;
+    }
     else
     {
-        return VERDICT_VALID_RESET;
+        return VERDICT_VALID_RESET_V2;
     }
 
 error:
@@ -399,6 +408,7 @@ error:
     return VERDICT_INVALID;
 }
 
+
 struct buffer
 tls_reset_standalone(struct tls_auth_standalone *tas,
                      struct session_id *own_sid,
@@ -429,3 +439,93 @@ tls_reset_standalone(struct tls_auth_standalone *tas,
 
     return buf;
 }
+
+hmac_ctx_t *
+session_id_hmac_init(void)
+{
+    /* We assume that SHA256 is always available */
+    ASSERT(md_valid("SHA256"));
+    hmac_ctx_t *hmac_ctx = hmac_ctx_new();
+
+    uint8_t key[SHA256_DIGEST_LENGTH];
+    ASSERT(rand_bytes(key, sizeof(key)));
+
+    hmac_ctx_init(hmac_ctx, key, "SHA256");
+    return hmac_ctx;
+}
+
+struct session_id
+calculate_session_id_hmac(struct session_id client_sid,
+                          const struct openvpn_sockaddr *from,
+                          hmac_ctx_t *hmac,
+                          int handwindow, int offset)
+{
+    union {
+        uint8_t hmac_result[SHA256_DIGEST_LENGTH];
+        struct session_id sid;
+    } result;
+
+    /* Get the valid time quantisation for our hmac,
+     * we divide time by handwindow/2 and allow the previous
+     * and future session time if specified by offset */
+    uint32_t session_id_time = now/((handwindow+1)/2) + offset;
+
+    hmac_ctx_reset(hmac);
+    /* We do not care about endian here since it does not need to be
+     * portable */
+    hmac_ctx_update(hmac, (const uint8_t *) &session_id_time,
+                    sizeof(session_id_time));
+
+    /* add client IP and port */
+    switch (af_addr_size(from->addr.sa.sa_family))
+    {
+        case AF_INET:
+            hmac_ctx_update(hmac, (const uint8_t *) &from->addr.in4, sizeof(struct sockaddr_in));
+            break;
+
+        case AF_INET6:
+            hmac_ctx_update(hmac, (const uint8_t *) &from->addr.in6, sizeof(struct sockaddr_in6));
+            break;
+    }
+
+    /* add session id of client */
+    hmac_ctx_update(hmac, client_sid.id, SID_SIZE);
+
+    hmac_ctx_final(hmac, result.hmac_result);
+
+    return result.sid;
+}
+
+bool
+check_session_id_hmac(struct tls_pre_decrypt_state *state,
+                      const struct openvpn_sockaddr *from,
+                      hmac_ctx_t *hmac,
+                      int handwindow)
+{
+    if (!from)
+    {
+        return false;
+    }
+
+    struct buffer buf = state->newbuf;
+    struct reliable_ack ack;
+
+    if (!reliable_ack_parse(&buf, &ack, &state->server_session_id))
+    {
+        return false;
+    }
+
+    /* check adjacent timestamps too */
+    for (int offset = -2; offset <= 1; offset++)
+    {
+        struct session_id expected_id =
+            calculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, offset);
+
+        if (memcmp_constant_time(&expected_id, &state->server_session_id, SID_SIZE))
+        {
+            return true;
+        }
+    }
+    return false;
+}
+
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 769dc1f44..ae92f6b33 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -77,11 +77,15 @@ struct tls_auth_standalone
 };
 
 enum first_packet_verdict {
-    /** This packet is a valid reset packet from the peer */
-    VERDICT_VALID_RESET,
-    /** This packet is a valid control packet from the peer,
-     * i.e. it has a valid session id hmac in it */
+    /** This packet is a valid reset packet from the peer (all but tls-crypt-v2) */
+    VERDICT_VALID_RESET_V2,
+    /** This is a valid v3 reset (tls-crypt-v2) */
+    VERDICT_VALID_RESET_V3,
+    /** This packet is a valid control packet from the peer */
     VERDICT_VALID_CONTROL_V1,
+    /** This packet is a valid ACK control packet from the peer,
+     * i.e. it has a valid session id hmac in it */
+    VERDICT_VALID_ACK_V1,
     /** the packet failed on of the various checks */
     VERDICT_INVALID
 };
@@ -94,6 +98,7 @@ struct tls_pre_decrypt_state {
     struct tls_wrap_ctx tls_wrap_tmp;
     struct buffer newbuf;
     struct session_id peer_session_id;
+    struct session_id server_session_id;
 };
 
 /**
@@ -141,6 +146,47 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
                      const struct link_socket_actual *from,
                      const struct buffer *buf);
 
+/* Creates an SHA256 HMAC context with a random key that is used for the
+ * session id.
+ *
+ * We do not support loading this from a config file since continuing session
+ * between restarts of OpenVPN has never been supported and that includes
+ * early session setup
+ */
+hmac_ctx_t *session_id_hmac_init(void);
+
+/**
+ * Calculates the a HMAC based server session id based on a client session id
+ * and socket addr.
+ *
+ * @param client_sid    session id of the client
+ * @param from          link_socket from the client
+ * @param hmac          the hmac context to use for the calculation
+ * @param handwindow    the quantisation of the current time
+ * @param offset        offset to 'now' to use
+ * @return              the expected server session id
+ */
+struct session_id
+calculate_session_id_hmac(struct session_id client_sid,
+                          const struct openvpn_sockaddr *from,
+                          hmac_ctx_t *hmac,
+                          int handwindow, int offset);
+
+/**
+ * Checks if a control packet has a correct HMAC server session id
+ *
+ * @param client_sid    session id of the client
+ * @param from          link_socket from the client
+ * @param hmac          the hmac context to use for the calculation
+ * @param handwindow    the quantisation of the current time
+ * @return              the expected server session id
+ */
+bool
+check_session_id_hmac(struct tls_pre_decrypt_state *state,
+                      const struct openvpn_sockaddr *from,
+                      hmac_ctx_t *hmac,
+                      int handwindow);
+
 /*
  * Write a control channel authentication record.
  */
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 77338cd3a..36812628e 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -44,6 +44,7 @@
 
 #include "mock_msg.h"
 #include "mss.h"
+#include "reliable.h"
 
 int
 parse_line(const char *line, char **p, const int n, const char *file,
@@ -151,6 +152,21 @@ const uint8_t client_ack_tls_auth_randomid[] = {
     0x56, 0x33, 0x6b
 };
 
+/* This is a truncated packet as we do not care for the TLS payload in the
+ * unit test */
+const uint8_t client_control_with_ack[] = {
+    0x20, 0x78, 0x19, 0xbf, 0x2e, 0xbc, 0xd1, 0x9a,
+    0x45, 0x01, 0x00, 0x00, 0x00, 0x00, 0xea,
+    0xfe,0xbf, 0xa4, 0x41, 0x8a, 0xe3, 0x1b,
+    0x00, 0x00, 0x00, 0x01, 0x16, 0x03, 0x01
+};
+
+const uint8_t client_ack_none_random_id[] = {
+    0x28, 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79,
+    0xc8, 0x01, 0x00, 0x00, 0x00, 0x00, 0xdd,
+    0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e
+};
+
 struct tls_auth_standalone
 init_tas_auth(int key_direction)
 {
@@ -168,6 +184,7 @@ init_tas_auth(int key_direction)
     crypto_read_openvpn_key(&tls_crypt_kt, &tas.tls_wrap.opt.key_ctx_bi,
                             static_key, true, key_direction,
                             "Control Channel Authentication", "tls-auth");
+
     return tas;
 }
 
@@ -210,7 +227,7 @@ test_tls_decrypt_lite_crypt(void **ut_state)
     buf_reset_len(&buf);
     buf_write(&buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_tls_crypt));
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
-    assert_int_equal(verdict, VERDICT_VALID_RESET);
+    assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
     free_tls_pre_decrypt_state(&state);
 
     /* flip a byte in various places */
@@ -251,17 +268,19 @@ test_tls_decrypt_lite_auth(void **ut_state)
     buf_reset_len(&buf);
     buf_write(&buf, client_reset_v2_tls_auth, sizeof(client_reset_v2_tls_auth));
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
-    assert_int_equal(verdict, VERDICT_VALID_RESET);
+    assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
+    free_tls_pre_decrypt_state(&state);
 
     free_tls_pre_decrypt_state(&state);
     /* The pre decrypt function should not modify the buffer, so calling it
      * again should have the same result */
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
-    assert_int_equal(verdict, VERDICT_VALID_RESET);
+    assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
     free_tls_pre_decrypt_state(&state);
 
     /* and buf memory should be equal */
     assert_memory_equal(BPTR(&buf), client_reset_v2_tls_auth, sizeof(client_reset_v2_tls_auth));
+    free_tls_pre_decrypt_state(&state);
 
     buf_reset_len(&buf);
     buf_write(&buf, client_ack_tls_auth_randomid, sizeof(client_ack_tls_auth_randomid));
@@ -273,6 +292,7 @@ test_tls_decrypt_lite_auth(void **ut_state)
     BPTR(&buf)[20] = 0x23;
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_INVALID);
+    free_tls_pre_decrypt_state(&state);
 
     free_tls_pre_decrypt_state(&state);
     /* Wrong key direction gives a wrong hmac key and should not validate */
@@ -304,19 +324,21 @@ test_tls_decrypt_lite_none(void **ut_state)
     /* the method will not do additional test, so the tls-auth and tls-crypt
      * reset will be accepted */
     enum first_packet_verdict verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
-    assert_int_equal(verdict, VERDICT_VALID_RESET);
+    assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
     free_tls_pre_decrypt_state(&state);
 
     buf_reset_len(&buf);
     buf_write(&buf, client_reset_v2_none, sizeof(client_reset_v2_none));
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
-    assert_int_equal(verdict, VERDICT_VALID_RESET);
+    assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
+    free_tls_pre_decrypt_state(&state);
 
     free_tls_pre_decrypt_state(&state);
     buf_reset_len(&buf);
     buf_write(&buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_none));
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
-    assert_int_equal(verdict, VERDICT_VALID_RESET);
+    assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
+    free_tls_pre_decrypt_state(&state);
 
     free_tls_pre_decrypt_state(&state);
 
@@ -325,10 +347,177 @@ test_tls_decrypt_lite_none(void **ut_state)
     buf_write(&buf, client_ack_tls_auth_randomid, sizeof(client_ack_tls_auth_randomid));
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
+
     free_tls_pre_decrypt_state(&state);
     free_buf(&buf);
 }
 
+static void
+test_parse_ack(void **ut_state)
+{
+    struct buffer buf = alloc_buf(1024);
+    buf_write(&buf, client_control_with_ack, sizeof(client_control_with_ack));
+
+    /* skip over op code and peer session id */
+    buf_advance(&buf, 9);
+
+    struct reliable_ack ack;
+    struct session_id sid;
+    bool ret;
+
+    ret = reliable_ack_parse(&buf, &ack, &sid);
+    assert_true(ret);
+
+    assert_int_equal(ack.len, 1);
+    assert_int_equal(ack.packet_id[0], 0);
+
+    struct session_id expected_id = { .id = {0xea, 0xfe, 0xbf, 0xa4, 0x41, 0x8a, 0xe3, 0x1b }};
+    assert_memory_equal(&sid, &expected_id, SID_SIZE);
+
+    buf_reset_len(&buf);
+    buf_write(&buf, client_ack_none_random_id, sizeof(client_ack_none_random_id));
+
+    /* skip over op code and peer session id */
+    buf_advance(&buf, 9);
+    ret = reliable_ack_parse(&buf, &ack, &sid);
+    assert_true(ret);
+
+    assert_int_equal(ack.len, 1);
+    assert_int_equal(ack.packet_id[0], 0);
+
+    struct session_id expected_id2 = { .id = {0xdd, 0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e }};
+    assert_memory_equal(&sid, &expected_id2, SID_SIZE);
+
+    buf_reset_len(&buf);
+    buf_write(&buf, client_reset_v2_none, sizeof(client_reset_v2_none));
+
+    /* skip over op code and peer session id */
+    buf_advance(&buf, 9);
+    ret = reliable_ack_parse(&buf, &ack, &sid);
+
+    free_buf(&buf);
+}
+
+static void
+test_verify_hmac_tls_auth(void **ut_state)
+{
+    hmac_ctx_t *hmac = session_id_hmac_init();
+
+    struct link_socket_actual from = { 0 };
+    struct tls_auth_standalone tas = { 0 };
+    struct tls_pre_decrypt_state state = { 0 };
+
+    struct buffer buf = alloc_buf(1024);
+    enum first_packet_verdict verdict;
+
+    tas = init_tas_auth(KEY_DIRECTION_NORMAL);
+
+    buf_reset_len(&buf);
+    buf_write(&buf, client_ack_tls_auth_randomid, sizeof(client_ack_tls_auth_randomid));
+    verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
+
+    /* This is a valid packet but containing a random id instead of an HMAC id*/
+    bool valid = check_session_id_hmac(&state, &from.dest, hmac, 30);
+    assert_false(valid);
+
+    free_key_ctx_bi(&tas.tls_wrap.opt.key_ctx_bi);
+    free_key_ctx(&tas.tls_wrap.tls_crypt_v2_server_key);
+    free_tls_pre_decrypt_state(&state);
+    free_buf(&buf);
+    hmac_ctx_cleanup(hmac);
+    hmac_ctx_free(hmac);
+}
+
+static void
+test_verify_hmac_none(void **ut_state)
+{
+    hmac_ctx_t *hmac = session_id_hmac_init();
+
+    struct link_socket_actual from = { 0 };
+    struct tls_auth_standalone tas = { 0 };
+    struct tls_pre_decrypt_state state = { 0 };
+
+    struct buffer buf = alloc_buf(1024);
+    enum first_packet_verdict verdict;
+
+    tas.tls_wrap.mode = TLS_WRAP_NONE;
+
+    buf_reset_len(&buf);
+    buf_write(&buf, client_ack_none_random_id, sizeof(client_ack_none_random_id));
+    verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
+
+    bool valid = check_session_id_hmac(&state, &from.dest, hmac, 30);
+    assert_true(valid);
+
+    free_tls_pre_decrypt_state(&state);
+    free_buf(&buf);
+    hmac_ctx_cleanup(hmac);
+    hmac_ctx_free(hmac);
+}
+
+static hmac_ctx_t *
+init_static_hmac(void)
+{
+    ASSERT(md_valid("SHA256"));
+    hmac_ctx_t *hmac_ctx = hmac_ctx_new();
+
+    uint8_t key[SHA256_DIGEST_LENGTH] = {1, 2, 3};
+
+    hmac_ctx_init(hmac_ctx, key, "SHA256");
+    return hmac_ctx;
+}
+
+static void
+test_calc_session_id_hmac_static(void **ut_state)
+{
+    hmac_ctx_t *hmac = init_static_hmac();
+    static const int handwindow = 100;
+
+    struct openvpn_sockaddr addr = {0 };
+
+    /* we do not use htons functions here since the hmac calculate function
+     * also does not care about the endianness of the data but just assumes
+     * the endianness doesn't change between calls */
+    addr.addr.in4.sin_family = AF_INET;
+    addr.addr.in4.sin_addr.s_addr = 0xff000ff;
+    addr.addr.in4.sin_port = 1194;
+
+
+    struct session_id client_id = { {0, 1, 2, 3, 4, 5, 6, 7}};
+
+    now = 1005;
+    struct session_id server_id = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);
+
+    struct session_id expected_server_id = { {0xba,  0x83, 0xa9, 0x00, 0x72, 0xbd,0x93, 0xba }};
+    assert_memory_equal(expected_server_id.id, server_id.id, SID_SIZE);
+
+    struct session_id server_id_m1 = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -1);
+    struct session_id server_id_p1 = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 1);
+    struct session_id server_id_p2 = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 2);
+
+    assert_memory_not_equal(expected_server_id.id, server_id_m1.id, SID_SIZE);
+    assert_memory_not_equal(expected_server_id.id, server_id_p1.id, SID_SIZE);
+
+    /* changing the time puts us into the next hmac time window (handwindow/2=50)
+     * and shifts the ids by one */
+    now = 1062;
+
+    struct session_id server_id2_m2 = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -2);
+    struct session_id server_id2_m1 = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -1);
+    struct session_id server_id2 = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);
+    struct session_id server_id2_p1 = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 1);
+
+    assert_memory_equal(server_id2_m2.id, server_id_m1.id, SID_SIZE);
+    assert_memory_equal(server_id2_m1.id, expected_server_id.id, SID_SIZE);
+    assert_memory_equal(server_id2.id, server_id_p1.id, SID_SIZE);
+    assert_memory_equal(server_id2_p1.id, server_id_p2.id, SID_SIZE);
+
+    hmac_ctx_cleanup(hmac);
+    hmac_ctx_free(hmac);
+}
+
 static void
 test_generate_reset_packet_plain(void **ut_state)
 {
@@ -351,7 +540,7 @@ test_generate_reset_packet_plain(void **ut_state)
 
 
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
-    assert_int_equal(verdict, VERDICT_VALID_RESET);
+    assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
 
     /* Assure repeated generation of reset is deterministic/stateless*/
     assert_memory_equal(state.peer_session_id.id, client_id.id, SID_SIZE);
@@ -385,7 +574,7 @@ test_generate_reset_packet_tls_auth(void **ut_state)
     struct buffer buf = tls_reset_standalone(&tas_client, &client_id, &server_id, header);
 
     enum first_packet_verdict verdict = tls_pre_decrypt_lite(&tas_server, &state, &from, &buf);
-    assert_int_equal(verdict, VERDICT_VALID_RESET);
+    assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
 
     assert_memory_equal(state.peer_session_id.id, client_id.id, SID_SIZE);
 
@@ -396,7 +585,6 @@ test_generate_reset_packet_tls_auth(void **ut_state)
     assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
     free_buf(&buf2);
 
-
     free_tls_pre_decrypt_state(&state);
 
     packet_id_free(&tas_client.tls_wrap.opt.packet_id);
@@ -414,6 +602,10 @@ main(void)
         cmocka_unit_test(test_tls_decrypt_lite_none),
         cmocka_unit_test(test_tls_decrypt_lite_auth),
         cmocka_unit_test(test_tls_decrypt_lite_crypt),
+        cmocka_unit_test(test_parse_ack),
+        cmocka_unit_test(test_calc_session_id_hmac_static),
+        cmocka_unit_test(test_verify_hmac_none),
+        cmocka_unit_test(test_verify_hmac_tls_auth),
         cmocka_unit_test(test_generate_reset_packet_plain),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
     };
-- 
2.32.0 (Apple Git-132)


