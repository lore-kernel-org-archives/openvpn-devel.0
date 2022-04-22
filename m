From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:43 +0200
Message-Id: <20220422142953.3805364-9-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 18/28] Implement stateless,
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
  - trigger creating session on the server side leading to poential
    ressource exhaustian
  - make the server respond with 3 answers trying to get an ACK for its
    answer making it a amplification

Instead of allocating a connection for each client on the initial packet
OpenVPN will now send back a response that contains an HMAC based cookie
that the client will need to respond to. This eliminates the amplification
attack and resource exhaustion attacks. For tls-crypt-v2 client HMAC based
handshake is not used yet

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/doxygen/doc_protocol_overview.h |   2 +
 src/openvpn/init.c                  |  11 +-
 src/openvpn/mudp.c                  | 106 ++++++++++--
 src/openvpn/multi.h                 |   3 +
 src/openvpn/openvpn.h               |   6 +
 src/openvpn/reliable.c              |   2 +-
 src/openvpn/ssl.c                   |  50 +++++-
 src/openvpn/ssl.h                   |   8 +
 src/openvpn/ssl_pkt.c               | 104 +++++++++++-
 src/openvpn/ssl_pkt.h               |  57 ++++++-
 tests/unit_tests/openvpn/test_pkt.c | 247 +++++++++++++++++++++++++---
 11 files changed, 542 insertions(+), 54 deletions(-)

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
index e41bb9d4b..97a5fd01b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -54,6 +54,7 @@
 #include "forward.h"
 #include "auth_token.h"
 #include "mss.h"
+#include "mudp.h"
 
 #include "memdbg.h"
 
@@ -67,6 +68,7 @@ static const char *saved_pid_file_name; /* GLOBAL */
 #define CF_LOAD_PERSISTED_PACKET_ID (1<<0)
 #define CF_INIT_TLS_MULTI           (1<<1)
 #define CF_INIT_TLS_AUTH_STANDALONE (1<<2)
+#define CF_INIT_SESIONID_HMAC       (1<<2)
 
 static void do_init_first_time(struct context *c);
 static bool do_deferred_p2p_ncp(struct context *c);
@@ -2974,6 +2976,12 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     {
         c->c2.tls_auth_standalone = tls_auth_standalone_init(&to, &c->c2.gc);
     }
+
+    if (flags & CF_INIT_SESIONID_HMAC)
+    {
+        c->c2.session_id_hmac = session_id_hmac_init();
+    }
+
 }
 
 static void
@@ -2992,6 +3000,7 @@ do_init_frame_tls(struct context *c)
         tls_init_control_channel_frame_parameters(&c->c2.frame, &c->c2.tls_auth_standalone->frame);
         frame_print(&c->c2.tls_auth_standalone->frame, D_MTU_INFO,
                     "TLS-Auth MTU parms");
+        c->c2.tls_auth_standalone->tls_wrap.work = alloc_buf_gc(BUF_SIZE(&c->c2.frame), &c->c2.gc);
     }
 }
 
@@ -4077,7 +4086,7 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
         unsigned int crypto_flags = 0;
         if (c->mode == CM_TOP)
         {
-            crypto_flags = CF_INIT_TLS_AUTH_STANDALONE;
+            crypto_flags = CF_INIT_TLS_AUTH_STANDALONE | CF_INIT_SESIONID_HMAC;
         }
         else if (c->mode == CM_P2P)
         {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 584701875..75619bd54 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -40,27 +40,85 @@
 #include <sys/inotify.h>
 #endif
 
+/* Return if this packet should create a new session */
 static bool
-do_pre_decrypt_check(struct multi_context *m)
+do_pre_decrypt_check(struct multi_context *m,
+                     struct tls_pre_decrypt_state *state,
+                     struct mroute_addr addr)
 {
+    /* udp server should always have the this */
     if (!m->top.c2.tls_auth_standalone)
     {
         return false;
     }
 
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
+            msg(D_MULTI_DEBUG, "Reset packet from client (%s), "
+                "sending HMAC based reset challenge", peer);
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
@@ -117,10 +175,18 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
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
@@ -130,6 +196,14 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
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
@@ -138,6 +212,7 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
                         mroute_addr_print(&real, &gc));
                 }
             }
+            free_tls_pre_decrypt_state(&state);
         }
 
 #ifdef ENABLE_DEBUG
@@ -158,7 +233,7 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
 }
 
 /*
- * Send a packet to TCP/UDP socket.
+ * Send a packet to UDP socket.
  */
 static inline void
 multi_process_outgoing_link(struct multi_context *m, const unsigned int mpp_flags)
@@ -168,6 +243,14 @@ multi_process_outgoing_link(struct multi_context *m, const unsigned int mpp_flag
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
@@ -275,6 +358,10 @@ p2mp_iow_flags(const struct multi_context *m)
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
@@ -367,4 +454,3 @@ tunnel_server_udp(struct context *top)
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
 
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index d8711f7dc..5c897b225 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -166,7 +166,7 @@ reliable_ack_read(struct reliable_ack *ack,
     }
 
     if (ack->len >= 1 && (!session_id_defined(&session_id_remote)
-        || !session_id_equal(&session_id_remote, sid)))
+                          || !session_id_equal(&session_id_remote, sid)))
     {
         struct gc_arena gc = gc_new();
         dmsg(D_REL_LOW,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d7fec0276..dca62a875 100644
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
 
@@ -1785,7 +1789,8 @@ flush_payload_buffer(struct key_state *ks)
 }
 
 /* true if no in/out acknowledgements pending */
-static bool no_pending_reliable_packets(struct key_state *ks)
+static bool
+no_pending_reliable_packets(struct key_state *ks)
 {
     return (reliable_empty(ks->send_reliable) && reliable_ack_empty(ks->rec_ack));
 }
@@ -2397,13 +2402,13 @@ auth_deferred_expire_window(const struct tls_options *o)
 
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
@@ -2417,6 +2422,13 @@ session_move_pre_start(const struct tls_session *session,
 
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
@@ -2490,6 +2502,30 @@ session_move_active(struct tls_multi *multi, struct tls_session *session,
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
@@ -2505,7 +2541,7 @@ tls_process_state(struct tls_multi *multi,
     /* Initial handshake */
     if (ks->state == S_INITIAL)
     {
-        state_change = session_move_pre_start(session, ks);
+        state_change = session_move_pre_start(session, ks, false);
     }
 
     /* Are we timed out on receive? */
@@ -2530,7 +2566,7 @@ tls_process_state(struct tls_multi *multi,
 
     /* Wait for ACK */
     if (((ks->state == S_GOT_KEY && !session->opt->server)
-        || (ks->state == S_SENT_KEY && session->opt->server))
+         || (ks->state == S_SENT_KEY && session->opt->server))
         && no_pending_reliable_packets(ks))
     {
         session_move_active(multi, session, to_link_socket_info, ks);
@@ -2609,7 +2645,7 @@ tls_process_state(struct tls_multi *multi,
     /* Send Key */
     buf = &ks->plaintext_write_buf;
     if (!buf->len && ((ks->state == S_START && !session->opt->server)
-        || (ks->state == S_GOT_KEY && session->opt->server)))
+                      || (ks->state == S_GOT_KEY && session->opt->server)))
     {
         if (!key_method_2_write(buf, multi, session))
         {
@@ -2739,7 +2775,7 @@ tls_process(struct tls_multi *multi,
     }
 
     bool state_change = true;
-    while(state_change)
+    while (state_change)
     {
         update_time();
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 3a65bad6a..fbc781c70 100644
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
index 927ee35aa..56baa2895 100644
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
@@ -423,10 +433,98 @@ tls_reset_standalone(struct tls_auth_standalone *tas,
     packet_id_type net_pid = htonpid(0);
 
     ASSERT(buf_write(&buf, &net_pid, sizeof(net_pid)));
-    
+
     /* Add tls-auth/tls-crypt wrapping, this might replace buf */
     tls_wrap_control(&tas->tls_wrap, header, &buf, own_sid);
 
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
+     * we divide time by handwindow/2 and allow the current
+     * and the previous timestamp */
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
+    for (int i = -1; i<=1; i++)
+    {
+        struct session_id expected_id =
+            calculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, i);
+
+        if (memcmp_constant_time(&expected_id, &state->server_session_id, SID_SIZE))
+        {
+            return true;
+        }
+    }
+    return false;
+}
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 1a327eba6..75cdc1c58 100644
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
@@ -141,6 +146,48 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
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
+ * @param offset        offset to 'now' to use
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
@@ -174,7 +221,7 @@ struct buffer
 tls_reset_standalone(struct tls_auth_standalone *tas,
                      struct session_id *own_sid,
                      struct session_id *remote_sid,
-                         uint8_t header);
+                     uint8_t header);
 
 static inline const char *
 packet_opcode_name(int op)
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 95ff13b5a..c4e23521d 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -44,6 +44,7 @@
 
 #include "mock_msg.h"
 #include "mss.h"
+#include "reliable.h"
 
 int
 parse_line(const char *line, char **p, const int n, const char *file,
@@ -87,25 +88,25 @@ const char static_key[] = "<tls-auth>\n"
                           "</tls-auth>\n";
 
 const uint8_t client_reset_v2_none[] =
-    { 0x38, 0x68, 0x91, 0x92,  0x3f, 0xa3, 0x10, 0x34,
-      0x37, 0x00, 0x00, 0x00, 0x00, 0x00 };
+{ 0x38, 0x68, 0x91, 0x92,  0x3f, 0xa3, 0x10, 0x34,
+  0x37, 0x00, 0x00, 0x00, 0x00, 0x00 };
 
 const uint8_t client_reset_v2_tls_auth[] =
-    { 0x38, 0xde, 0x69, 0x4c, 0x5c, 0x7b, 0xfb, 0xa2,
-      0x74, 0x93, 0x53, 0x7c, 0x1d, 0xed, 0x4e, 0x78,
-     0x15, 0x29, 0xae, 0x7c, 0xfe, 0x4b, 0x8c, 0x6d,
-     0x6b, 0x2b, 0x51, 0xf0, 0x5a, 0x00, 0x00, 0x00,
-     0x01, 0x61, 0xd3, 0xbf, 0x6c, 0x00, 0x00, 0x00,
-     0x00, 0x00};
+{ 0x38, 0xde, 0x69, 0x4c, 0x5c, 0x7b, 0xfb, 0xa2,
+  0x74, 0x93, 0x53, 0x7c, 0x1d, 0xed, 0x4e, 0x78,
+  0x15, 0x29, 0xae, 0x7c, 0xfe, 0x4b, 0x8c, 0x6d,
+  0x6b, 0x2b, 0x51, 0xf0, 0x5a, 0x00, 0x00, 0x00,
+  0x01, 0x61, 0xd3, 0xbf, 0x6c, 0x00, 0x00, 0x00,
+  0x00, 0x00};
 
 const uint8_t client_reset_v2_tls_crypt[] =
-    {0x38, 0xf4, 0x19, 0xcb, 0x12, 0xd1, 0xf9, 0xe4,
-     0x8f, 0x00, 0x00, 0x00, 0x01, 0x61, 0xd3, 0xf8,
-     0xe1, 0x33, 0x02, 0x06, 0xf5, 0x68, 0x02, 0xbe,
-     0x44, 0xfb, 0xed, 0x90, 0x50, 0x64, 0xe3, 0xdb,
-     0x43, 0x41, 0x6b, 0xec, 0x5e, 0x52, 0x67, 0x19,
-     0x46, 0x2b, 0x7e, 0xb9, 0x0c, 0x96, 0xde, 0xfc,
-     0x9b, 0x05, 0xc4, 0x48, 0x79, 0xf7};
+{0x38, 0xf4, 0x19, 0xcb, 0x12, 0xd1, 0xf9, 0xe4,
+ 0x8f, 0x00, 0x00, 0x00, 0x01, 0x61, 0xd3, 0xf8,
+ 0xe1, 0x33, 0x02, 0x06, 0xf5, 0x68, 0x02, 0xbe,
+ 0x44, 0xfb, 0xed, 0x90, 0x50, 0x64, 0xe3, 0xdb,
+ 0x43, 0x41, 0x6b, 0xec, 0x5e, 0x52, 0x67, 0x19,
+ 0x46, 0x2b, 0x7e, 0xb9, 0x0c, 0x96, 0xde, 0xfc,
+ 0x9b, 0x05, 0xc4, 0x48, 0x79, 0xf7};
 
 /* Valid tls-auth client CONTROL_V1 packet with random server id */
 const uint8_t client_ack_tls_auth_randomid[] = {
@@ -148,11 +149,30 @@ const uint8_t client_ack_tls_auth_randomid[] = {
     0xdb, 0x56, 0xf6, 0x40, 0xd1, 0xed, 0xdb, 0x91,
     0x81, 0xd6, 0xef, 0x83, 0x86, 0x8a, 0xb2, 0x3d,
     0x88, 0x92, 0x3f, 0xd8, 0x51, 0x9c, 0xd6, 0x26,
-    0x56, 0x33, 0x6b};
+    0x56, 0x33, 0x6b
+};
+
+/* This is a truncated packet as we do not care for the TLS payload in the
+ * unit test */
+const uint8_t client_control_with_ack[] = {
+    0x20, 0x78, 0x19, 0xbf, 0x2e, 0xbc, 0xd1, 0x9a,
+    0x45, 0x01, 0x00, 0x00, 0x00, 0x00, 0xea,
+    0xfe,0xbf, 0xa4, 0x41, 0x8a, 0xe3, 0x1b,
+    0x00, 0x00, 0x00, 0x01, 0x16, 0x03, 0x01
+};
 
-struct tls_auth_standalone init_tas_auth(int key_direction)
+const uint8_t client_ack_none_random_id[] = {
+    0x28, 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79,
+    0xc8, 0x01, 0x00, 0x00, 0x00, 0x00, 0xdd,
+    0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e
+};
+
+struct tls_auth_standalone
+init_tas_auth(int key_direction)
 {
     struct tls_auth_standalone tas = { 0 };
+    struct frame frame = { {.headroom = 200, .payload_size = 1400}, 0};
+    tas.frame = frame;
 
     tas.tls_wrap.mode = TLS_WRAP_AUTH;
     /* we ignore packet ids on for the first packet check */
@@ -164,10 +184,12 @@ struct tls_auth_standalone init_tas_auth(int key_direction)
     crypto_read_openvpn_key(&tls_crypt_kt, &tas.tls_wrap.opt.key_ctx_bi,
                             static_key, true, key_direction,
                             "Control Channel Authentication", "tls-auth");
+
     return tas;
 }
 
-struct tls_auth_standalone init_tas_crypt(bool server)
+struct tls_auth_standalone
+init_tas_crypt(bool server)
 {
     struct tls_auth_standalone tas = { 0 };
     tas.tls_wrap.mode = TLS_WRAP_CRYPT;
@@ -205,11 +227,11 @@ test_tls_decrypt_lite_crypt(void **ut_state)
     buf_reset_len(&buf);
     buf_write(&buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_tls_crypt));
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
-    assert_int_equal(verdict, VERDICT_VALID_RESET);
+    assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
     free_tls_pre_decrypt_state(&state);
 
     /* flip a byte in various places */
-    for (int i=0;i<sizeof(client_reset_v2_tls_crypt);i++)
+    for (int i = 0; i<sizeof(client_reset_v2_tls_crypt); i++)
     {
         buf_reset_len(&buf);
         buf_write(&buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_tls_crypt));
@@ -246,17 +268,19 @@ test_tls_decrypt_lite_auth(void **ut_state)
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
@@ -268,6 +292,7 @@ test_tls_decrypt_lite_auth(void **ut_state)
     BPTR(&buf)[20] = 0x23;
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_INVALID);
+    free_tls_pre_decrypt_state(&state);
 
     free_tls_pre_decrypt_state(&state);
     /* Wrong key direction gives a wrong hmac key and should not validate */
@@ -299,19 +324,21 @@ test_tls_decrypt_lite_none(void **ut_state)
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
 
@@ -320,10 +347,172 @@ test_tls_decrypt_lite_none(void **ut_state)
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
+    check_session_id_hmac(&state, &from.dest, hmac, 30);
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
+    check_session_id_hmac(&state, &from.dest, hmac, 30);
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
+    struct session_id server_id = calculate_session_id_hmac(client_id, &addr, hmac, 100, 0);
+
+    struct session_id expected_server_id = { {0xba,  0x83, 0xa9, 0x00, 0x72, 0xbd,0x93, 0xba }};
+    assert_memory_equal(expected_server_id.id, server_id.id, SID_SIZE);
+
+    struct session_id server_id_m1 = calculate_session_id_hmac(client_id, &addr, hmac, 100, -1);
+    struct session_id server_id_p1 = calculate_session_id_hmac(client_id, &addr, hmac, 100, 1);
+    struct session_id server_id_p2 = calculate_session_id_hmac(client_id, &addr, hmac, 100, 2);
+
+    assert_memory_not_equal(expected_server_id.id, server_id_m1.id, SID_SIZE);
+    assert_memory_not_equal(expected_server_id.id, server_id_p1.id, SID_SIZE);
+
+    /* moving now should also move the calculated ids */
+    now = 1062;
+
+    struct session_id server_id2_m2 = calculate_session_id_hmac(client_id, &addr, hmac, 100, -2);
+    struct session_id server_id2_m1 = calculate_session_id_hmac(client_id, &addr, hmac, 100, -1);
+    struct session_id server_id2 = calculate_session_id_hmac(client_id, &addr, hmac, 100, 0);
+    struct session_id server_id2_p1 = calculate_session_id_hmac(client_id, &addr, hmac, 100, 1);
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
@@ -346,7 +535,7 @@ test_generate_reset_packet_plain(void **ut_state)
 
 
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
-    assert_int_equal(verdict, VERDICT_VALID_RESET);
+    assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
 
     /* Assure repeated generation of reset is deterministic/stateless*/
     assert_memory_equal(state.peer_session_id.id, client_id.id, SID_SIZE);
@@ -380,7 +569,7 @@ test_generate_reset_packet_tls_auth(void **ut_state)
     struct buffer buf = tls_reset_standalone(&tas_client, &client_id, &server_id, header);
 
     enum first_packet_verdict verdict = tls_pre_decrypt_lite(&tas_server, &state, &from, &buf);
-    assert_int_equal(verdict, VERDICT_VALID_RESET);
+    assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
 
     assert_memory_equal(state.peer_session_id.id, client_id.id, SID_SIZE);
 
@@ -409,6 +598,10 @@ main(void)
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


