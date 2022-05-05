From: Arne Schwabe <arne@...1227...>
Date: Thu,  5 May 2022 15:03:48 +0200
Message-Id: <20220505130348.1183195-1-arne@...1227...>
In-Reply-To: <20220422142953.3805364-13-arne@...1227...>
References: <20220422142953.3805364-13-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Implement HMAC based session id for
 tls-crypt v2
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

Tls-crypt v2 is more complicated to implement a proper stateless
handshake. To allow state handshake this commit does

 - introduce a new packet CONTROL_WKC_V1 that repeats the wrapped
   client key.
 - introduce a way to negotiate the support for this packet in the
   three way handshake

Details about the protocol changes are in tls-crypt-v2.txt. Optional
arguments to the tls-crypt-v2 option have been added to explicitly
allow or disallow client that do not support the stateless handshake.

Signed-off-by: Arne Schwabe <arne@...1227...>

Patch v3: improve grammar, style, comments, fix unit tests
Patch v4: remove explicit flag for ability to resend WKc,
          clean up comments, improve code style in some instances
---
 Changes.rst                         |  10 +++
 doc/man-sections/tls-options.rst    |  14 ++++
 doc/tls-crypt-v2.txt                |  44 ++++++++++
 src/openvpn/crypto.h                |   8 ++
 src/openvpn/init.c                  |   4 +
 src/openvpn/mudp.c                  |  88 ++++++++++++++++----
 src/openvpn/options.c               |  13 +++
 src/openvpn/options.h               |   3 +
 src/openvpn/reliable.h              |   2 -
 src/openvpn/ssl.c                   | 125 +++++++++++++++++++++++++---
 src/openvpn/ssl_pkt.c               |  28 +++++--
 src/openvpn/ssl_pkt.h               |  33 +++++++-
 tests/unit_tests/openvpn/test_pkt.c |  10 +--
 13 files changed, 338 insertions(+), 44 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index ceb0b2680..67a23c792 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -69,6 +69,16 @@ Improved ``--mssfix`` and ``--fragment`` calculation
     account and the resulting size is specified as the total size of the VPN packets
     including IP and UDP headers.
 
+Cookie based handshake for UDP server
+    Instead of allocating a connection for each client on the initial packet
+    OpenVPN server will now use an HMAC based cookie as its session id. This
+    way the server can verify it on completing the handshake without keeping
+    state. This eliminates the amplification and resource exhaustion attacks.
+    For tls-crypt-v2 clients, this requires OpenVPN 2.6 clients or later
+    because the client needs to resend its client key on completing the hand
+    shake. The tls-crypt-v2 option allows controlling if older clients are
+    accepted.
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index ac5756034..c06ee3354 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -486,6 +486,13 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   8000 years'.
 
 --tls-crypt-v2 keyfile
+
+  Valid syntax:
+  ::
+     tls-crypt-v2 keyfile
+     tls-crypt-v2 keyfile force-cookie
+     tls-crypt-v2 keyfile allow-noncookie
+
   Use client-specific tls-crypt keys.
 
   For clients, ``keyfile`` is a client-specific tls-crypt key. Such a key
@@ -501,6 +508,13 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   client is using client-specific keys, and automatically select the right
   mode.
 
+  The optional parameters :code:`force-cookie` allows only tls-crypt-v2
+  clients that support a cookie based stateless three way handshake that
+  avoids replay attacks and state exhaustion on the server side (OpenVPN
+  2.6 and later). The option :code:`allow-noncookie` explicitly allows
+  older tls-crypt-v2 clients. The default is (currently)
+  :code:`allow-noncookie`.
+
 --tls-crypt-v2-verify cmd
   Run command ``cmd`` to verify the metadata of the client-specific
   tls-crypt-v2 key of a connecting client. This allows server
diff --git a/doc/tls-crypt-v2.txt b/doc/tls-crypt-v2.txt
index f6a6a1395..7dcd0415f 100644
--- a/doc/tls-crypt-v2.txt
+++ b/doc/tls-crypt-v2.txt
@@ -157,6 +157,50 @@ When setting up the openvpn connection:
    messages.
 
 
+HMAC Cookie support
+-------------------
+To avoid exhaustion attack and keeping state for connections that fail to
+complete the three-way handshake, the OpenVPN server will use its own session
+id as challenge that the client must repeat in the third packet of the
+handshake. This introduces a problem. If the server does not keep the wrapped
+client key from the initial packet, the server cannot decode the third packet.
+Therefore, tls-crypt-v2 in 2.6 allows resending the wrapped key in the third
+packet of the handshake with the P_CONTROL_WKC_V1 message. The modified
+handshake is as follows (the rest of the handshake is unmodified):
+
+1. The client creates the P_CONTROL_HARD_RESET_CLIENT_V3 message as before
+   but indicates that it supports resending the wrapped key. This is done
+   by setting the packet id of the replay id to 0x0f000000. The first byte
+   indicates the early negotiation support and the next byte the flags.
+   All tls-crypt-v2 implementations that support early negotiation, must
+   also support resending the wrapped key. The flags byte is therefore
+   empty.
+
+2. The server responds with a P_CONTROL_HARD_RESET_V2 message. Instead of having
+   an empty payload like normally, the payload consists of TLV (type (uint16),
+   length (uint16), value) packets. TLV was chosen
+   to allow extensibility in the future. Currently only the following TLV is
+   defined:
+
+   flags - type 0x01, length 2.
+
+   Bit 1 indicates that the client needs to resend the WKc in the third packet.
+
+3. Instead of normal P_ACK_V1 or P_CONTROL_V1 packet, the client will send a
+   P_CONTROL_WKC_V1 packet. The P_CONTROL_WKC_V1 is identical to a normal
+   P_CONTROL_V1 packet but with the WKc appended.
+
+   Normally the first message of the client is either P_ACK_V1, directly
+   followed by a P_CONTROL_V1 message that contains the TLS Client Hello or
+   just a P_CONTROL_V1 message. Instead of a P_ACK_V1 message the client should
+   send a P_CONTROL_WKC_V1 message with an empty payload. This message must
+   also include an ACK for the P_CONTROL_HARD_RESET_V2 message.
+
+   When directly sending the TLS Client Hello message in the P_CONTROL_WKC_V1
+   message, the client must ensure that the resulting P_CONTROL_WKC_V1 message
+   with the appended WKc does not extend the control message length.
+
+
 Considerations
 --------------
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 806632edf..98e2c7664 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -256,6 +256,14 @@ struct crypto_options
     /**< Bit-flag indicating that data channel key derivation
      * is done using TLS keying material export [RFC5705]
      */
+#define CO_RESEND_WKC (1<<4)
+    /**< Bit-flag indicating that the client is expected to
+     * resend the wrapped client key with the 2nd packet (packet-id 1)
+     * like with the HARD_RESET_CLIENT_V3 packet */
+#define CO_FORCE_TLSCRYPTV2_COOKIE  (1<<5)
+    /**< Bit-flag indicating that we do not allow clients that do
+     * not support resending the wrapped client key (WKc) with the
+     * third packet of the three-way handshake */
     unsigned int flags;         /**< Bit-flags determining behavior of
                                  *   security operation functions. */
 };
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 092643619..21dcd69ff 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2960,6 +2960,10 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         {
             to.tls_wrap.tls_crypt_v2_server_key = c->c1.ks.tls_crypt_v2_server_key;
             to.tls_crypt_v2_verify_script = c->options.tls_crypt_v2_verify_script;
+            if (options->ce.tls_crypt_v2_force_cookie)
+            {
+                to.tls_wrap.opt.flags |= CO_FORCE_TLSCRYPTV2_COOKIE;
+            }
         }
     }
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 81f36a459..ccf9ff164 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -40,7 +40,31 @@
 #include <sys/inotify.h>
 #endif
 
-/* Return true if this packet should create a new session */
+static void
+send_hmac_reset_packet(struct multi_context *m,
+                       struct tls_pre_decrypt_state *state,
+                       struct tls_auth_standalone *tas,
+                       struct session_id *sid,
+                       bool request_resend_wkc)
+{
+    reset_packet_id_send(&state->tls_wrap_tmp.opt.packet_id.send);
+    state->tls_wrap_tmp.opt.packet_id.rec.initialized = true;
+    uint8_t header = 0 | (P_CONTROL_HARD_RESET_SERVER_V2 << P_OPCODE_SHIFT);
+    struct buffer buf = tls_reset_standalone(&state->tls_wrap_tmp, tas, sid,
+                                             &state->peer_session_id, header,
+                                             request_resend_wkc);
+
+    struct context *c = &m->top;
+
+    buf_reset_len(&c->c2.buffers->aux_buf);
+    buf_copy(&c->c2.buffers->aux_buf, &buf);
+    m->hmac_reply = c->c2.buffers->aux_buf;
+    m->hmac_reply_dest = &m->top.c2.from;
+    msg(D_MULTI_DEBUG, "Reset packet from client, sending HMAC based reset challenge");
+}
+
+
+/* Returns true if this packet should create a new session */
 static bool
 do_pre_decrypt_check(struct multi_context *m,
                      struct tls_pre_decrypt_state *state,
@@ -58,37 +82,65 @@ do_pre_decrypt_check(struct multi_context *m,
     struct openvpn_sockaddr *from = &m->top.c2.from.dest;
     int handwindow = m->top.options.handshake_window;
 
-
     if (verdict == VERDICT_VALID_RESET_V3)
     {
-        /* For tls-crypt-v2 we need to keep the state of the first packet to
-         * store the unwrapped key */
-        return true;
+        /* Extract the packet id to check if it has the special format that
+         * indicates early negotiation support */
+        struct packet_id_net pin;
+        struct buffer tmp = m->top.c2.buf;
+        ASSERT(buf_advance(&tmp, 1 + SID_SIZE));
+        ASSERT(packet_id_read(&pin, &tmp, true));
+
+        /* The most significant byte is 0x0f if early negotiation is supported */
+        bool early_neg_support = (pin.id & EARLY_NEG_MASK) == EARLY_NEG_START;
+
+        /* All clients that support early negotiation and tls-crypt are assumed
+         * to also support resending the WKc in the 2nd packet */
+        if (early_neg_support)
+        {
+            /* Calculate the session ID HMAC for our reply and create reset packet */
+            struct session_id sid = calculate_session_id_hmac(state->peer_session_id,
+                                                              from, hmac, handwindow, 0);
+            send_hmac_reset_packet(m, state, tas, &sid, true);
+
+            return false;
+        }
+        else
+        {
+            /* For tls-crypt-v2 we need to keep the state of the first packet
+             * to store the unwrapped key if the client doesn't support resending
+             * the wrapped key. Unless the user specifically disallowed
+             * compatibility with such clients to avoid state exhaustion */
+            if (tas->tls_wrap.opt.flags & CO_FORCE_TLSCRYPTV2_COOKIE)
+            {
+                struct gc_arena gc = gc_new();
+                const char *peer = print_link_socket_actual(&m->top.c2.from, &gc);
+                msg(D_MULTI_DEBUG, "tls-crypt-v2 force-cookie is enabled,"
+                    "ignoring connection attempt from old client"
+                    " (%s)", peer);
+                gc_free(&gc);
+                return false;
+            }
+            else
+            {
+                return true;
+            }
+        }
     }
     else if (verdict == VERDICT_VALID_RESET_V2)
     {
         /* Calculate the session ID HMAC for our reply and create reset packet */
         struct session_id sid = calculate_session_id_hmac(state->peer_session_id,
                                                           from, hmac, handwindow, 0);
-        reset_packet_id_send(&tas->tls_wrap.opt.packet_id.send);
-        tas->tls_wrap.opt.packet_id.rec.initialized = true;
-        uint8_t header = 0 | (P_CONTROL_HARD_RESET_SERVER_V2 << P_OPCODE_SHIFT);
-        struct buffer buf = tls_reset_standalone(tas, &sid,
-                                                 &state->peer_session_id, header);
-
 
-        struct context *c = &m->top;
+        send_hmac_reset_packet(m, state, tas, &sid, false);
 
-        buf_reset_len(&c->c2.buffers->aux_buf);
-        buf_copy(&c->c2.buffers->aux_buf, &buf);
-        m->hmac_reply = c->c2.buffers->aux_buf;
-        m->hmac_reply_dest = &m->top.c2.from;
-        msg(D_MULTI_DEBUG, "Reset packet from client, sending HMAC based reset challenge");
         /* We have a reply do not create a new session */
         return false;
 
     }
-    else if (verdict == VERDICT_VALID_CONTROL_V1 || verdict == VERDICT_VALID_ACK_V1)
+    else if (verdict == VERDICT_VALID_CONTROL_V1 || verdict == VERDICT_VALID_ACK_V1
+             || verdict == VERDICT_VALID_WKC_V1)
     {
         /* ACK_V1 contains the peer id (our id) while CONTROL_V1 can but does not
          * need to contain the peer id */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7f5c903d1..9ff384d09 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8896,6 +8896,19 @@ add_option(struct options *options,
             options->ce.tls_crypt_v2_file = p[1];
             options->ce.tls_crypt_v2_file_inline = is_inline;
         }
+
+        if (p[2] && streq(p[2], "force-cookie"))
+        {
+            options->ce.tls_crypt_v2_force_cookie = true;
+        }
+        else if (p[2] && streq(p[2], "allow-noncookie"))
+        {
+            options->ce.tls_crypt_v2_force_cookie = false;
+        }
+        else if (p[2])
+        {
+            msg(msglevel, "Unsupported tls-crypt-v2 argument: %s", p[2]);
+        }
     }
     else if (streq(p[0], "tls-crypt-v2-verify") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 055789b3b..c2937dc37 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -162,6 +162,9 @@ struct connection_entry
      * authenticated encryption v2 */
     const char *tls_crypt_v2_file;
     bool tls_crypt_v2_file_inline;
+
+    /* Allow only client that support resending the wrapped client key */
+    bool tls_crypt_v2_force_cookie;
 };
 
 struct remote_entry
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 8da2c0729..b9863efe3 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -361,8 +361,6 @@ struct reliable_entry *reliable_get_entry_sequenced(struct reliable *rel);
  *
  * @param rel The reliable structure associated with the given buffer.
  * @param buf The buffer of the reliable entry which is to be removed.
- * @param inc_pid If true, the reliable structure's packet ID counter
- *     will be incremented.
  */
 void reliable_mark_deleted(struct reliable *rel, struct buffer *buf);
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e54977f5a..ed5720072 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1099,6 +1099,14 @@ tls_session_init(struct tls_multi *multi, struct tls_session *session)
                    session->opt->replay_time,
                    "TLS_WRAP", session->key_id);
 
+    /* If we are using tls-crypt-v2 we manipulate the packet id to be (ab)used
+     * to indicate early protocol negotiation */
+    if (session->opt->tls_crypt_v2)
+    {
+        session->tls_wrap.opt.packet_id.send.time = now;
+        session->tls_wrap.opt.packet_id.send.id = EARLY_NEG_START;
+    }
+
     /* load most recent packet-id to replay protect on --tls-auth */
     packet_id_persist_load_obj(session->tls_wrap.opt.pid_persist,
                                &session->tls_wrap.opt.packet_id);
@@ -2524,6 +2532,54 @@ session_skip_to_pre_start(struct tls_session *session,
     return session_move_pre_start(session, ks, true);
 }
 
+/**
+ * Parses the TLVs (type, length, value) in the early negotiation
+ */
+static bool
+parse_early_negotiation_tlvs(struct buffer *buf, struct key_state *ks)
+{
+    while (buf->len > 0)
+    {
+        if (buf_len(buf) < 4)
+        {
+            goto error;
+        }
+        /* read type */
+        uint16_t type = buf_read_u16(buf);
+        uint16_t len = buf_read_u16(buf);
+        if (buf_len(buf) < len)
+        {
+            goto error;
+        }
+
+        switch (type)
+        {
+            case TLV_TYPE_EARLY_NEG_FLAGS:
+                if (len != sizeof(uint16_t))
+                {
+                    goto error;
+                }
+                uint16_t flags = buf_read_u16(buf);
+
+                if (flags & EARLY_NEG_FLAG_RESEND_WKC)
+                {
+                    ks->crypto_options.flags |= CO_RESEND_WKC;
+                }
+                break;
+
+            default:
+                /* Skip types we do not parse */
+                buf_advance(buf, len);
+        }
+    }
+    reliable_mark_deleted(ks->rec_reliable, buf);
+
+    return true;
+error:
+    msg(D_TLS_ERRORS, "TLS Error: Early negotiation malformed packet");
+    return false;
+}
+
 /**
  * Read incoming ciphertext and passes it to the buffer of the SSL library.
  * Returns false if an error is encountered that should abort the session.
@@ -2556,6 +2612,13 @@ read_incoming_tls_ciphertext(struct buffer *buf, struct key_state *ks,
     return true;
 }
 
+static bool
+control_packet_needs_wkc(const struct key_state *ks)
+{
+    return (ks->crypto_options.flags & CO_RESEND_WKC)
+           && (ks->send_reliable->packet_id == 1);
+}
+
 
 static bool
 tls_process_state(struct tls_multi *multi,
@@ -2625,9 +2688,21 @@ tls_process_state(struct tls_multi *multi,
     struct reliable_entry *entry = reliable_get_entry_sequenced(ks->rec_reliable);
     if (entry)
     {
-        if (!read_incoming_tls_ciphertext(&entry->buf, ks, &state_change))
+        /* The first packet from the peer (the reset packet) is special and
+         * contains early protocol negotiation */
+        if (entry->packet_id == 0 && is_hard_reset_method2(entry->opcode))
         {
-            goto error;
+            if (!parse_early_negotiation_tlvs(&entry->buf, ks))
+            {
+                goto error;
+            }
+        }
+        else
+        {
+            if (!read_incoming_tls_ciphertext(&entry->buf, ks, &state_change))
+            {
+                goto error;
+            }
         }
     }
 
@@ -2720,7 +2795,12 @@ tls_process_state(struct tls_multi *multi,
             }
             if (status == 1)
             {
-                reliable_mark_active_outgoing(ks->send_reliable, buf, P_CONTROL_V1);
+                int opcode = P_CONTROL_V1;
+                if (control_packet_needs_wkc(ks))
+                {
+                    opcode = P_CONTROL_WKC_V1;
+                }
+                reliable_mark_active_outgoing(ks->send_reliable, buf, opcode);
                 INCR_GENERATED;
                 state_change = true;
                 dmsg(D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
@@ -2810,15 +2890,37 @@ tls_process(struct tls_multi *multi,
 
     update_time();
 
+    /* We often send acks back to back to a following control packet. This
+     * normally does not create a problem (apart from an extra packet. However,
+     * with the P_CONTROL_WKC_V1 we need to ensure that the packet gets resend
+     * if not received by remote, so instead we use an empty control packet in
+     * this special case */
+
     /* Send 1 or more ACKs (each received control packet gets one ACK) */
     if (!to_link->len && !reliable_ack_empty(ks->rec_ack))
     {
-        struct buffer buf = ks->ack_write_buf;
-        ASSERT(buf_init(&buf, multi->opt.frame.buf.headroom));
-        write_control_auth(session, ks, &buf, to_link_addr, P_ACK_V1,
-                           RELIABLE_ACK_SIZE, false);
-        *to_link = buf;
-        dmsg(D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
+        if (control_packet_needs_wkc(ks))
+        {
+            struct buffer *buf = reliable_get_buf_output_sequenced(ks->send_reliable);
+            if (!buf)
+            {
+                return false;
+            }
+
+            /* We do not write anything to the buffer, this way this will be
+             * an empty control packet that gets the ack piggybacked and
+             * also appended the wrapped client key since it has a WCK opcode */
+            reliable_mark_active_outgoing(ks->send_reliable, buf, P_CONTROL_WKC_V1);
+        }
+        else
+        {
+            struct buffer buf = ks->ack_write_buf;
+            ASSERT(buf_init(&buf, multi->opt.frame.buf.headroom));
+            write_control_auth(session, ks, &buf, to_link_addr, P_ACK_V1,
+                               RELIABLE_ACK_SIZE, false);
+            *to_link = buf;
+            dmsg(D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
+        }
     }
 
     /* When should we wake up again? */
@@ -3463,7 +3565,8 @@ tls_pre_decrypt(struct tls_multi *multi,
     }
 
     /*
-     * We have an authenticated control channel packet (if --tls-auth was set).
+     * We have an authenticated control channel packet (if --tls-auth/tls-crypt
+     * or tls-crypt-v2 was set).
      * Now pass to our reliability layer which deals with
      * packet acknowledgements, retransmits, sequencing, etc.
      */
@@ -3892,7 +3995,7 @@ protocol_dump(struct buffer *buffer, unsigned int flags, struct gc_arena *gc)
 
     if (op == P_ACK_V1)
     {
-        goto done;
+        goto print_data;
     }
 
     /*
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 810b189e9..dad65e26a 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -148,7 +148,8 @@ tls_wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, struct buffer *buf,
             return;
         }
 
-        if ((header >> P_OPCODE_SHIFT) == P_CONTROL_HARD_RESET_CLIENT_V3)
+        if ((header >> P_OPCODE_SHIFT) == P_CONTROL_HARD_RESET_CLIENT_V3
+            || (header >> P_OPCODE_SHIFT) == P_CONTROL_WKC_V1)
         {
             if (!buf_copy(&ctx->work,
                           ctx->tls_crypt_v2_wkc))
@@ -197,7 +198,8 @@ read_control_auth(struct buffer *buf,
     bool ret = false;
 
     const uint8_t opcode = *(BPTR(buf)) >> P_OPCODE_SHIFT;
-    if (opcode == P_CONTROL_HARD_RESET_CLIENT_V3
+    if ((opcode == P_CONTROL_HARD_RESET_CLIENT_V3
+         || opcode == P_CONTROL_WKC_V1)
         && !tls_crypt_v2_extract_client_key(buf, ctx, opt))
     {
         msg(D_TLS_ERRORS,
@@ -321,6 +323,7 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
     if (op != P_CONTROL_HARD_RESET_CLIENT_V2
         && op != P_CONTROL_HARD_RESET_CLIENT_V3
         && op != P_CONTROL_V1
+        && op != P_CONTROL_WKC_V1
         && op != P_ACK_V1)
     {
         /*
@@ -397,6 +400,10 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
     {
         return VERDICT_VALID_RESET_V3;
     }
+    else if (op == P_CONTROL_WKC_V1)
+    {
+        return VERDICT_VALID_WKC_V1;
+    }
     else
     {
         return VERDICT_VALID_RESET_V2;
@@ -410,10 +417,12 @@ error:
 
 
 struct buffer
-tls_reset_standalone(struct tls_auth_standalone *tas,
+tls_reset_standalone(struct tls_wrap_ctx *ctx,
+                     struct tls_auth_standalone *tas,
                      struct session_id *own_sid,
                      struct session_id *remote_sid,
-                     uint8_t header)
+                     uint8_t header,
+                     bool request_resend_wkc)
 {
     struct buffer buf = alloc_buf(tas->frame.buf.payload_size);
     ASSERT(buf_init(&buf, tas->frame.buf.headroom));
@@ -434,8 +443,17 @@ tls_reset_standalone(struct tls_auth_standalone *tas,
 
     ASSERT(buf_write(&buf, &net_pid, sizeof(net_pid)));
 
+    /* Add indication for tls-crypt-v2 to resend the packet with the with
+     * reply */
+    if (request_resend_wkc)
+    {
+        buf_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */
+        buf_write_u16(&buf, sizeof(uint16_t));
+        buf_write_u16(&buf, EARLY_NEG_FLAG_RESEND_WKC);
+    }
+
     /* Add tls-auth/tls-crypt wrapping, this might replace buf */
-    tls_wrap_control(&tas->tls_wrap, header, &buf, own_sid);
+    tls_wrap_control(ctx, header, &buf, own_sid);
 
     return buf;
 }
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 193480737..45e0a81f5 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -54,11 +54,15 @@
 /* indicates key_method >= 2 and client-specific tls-crypt key */
 #define P_CONTROL_HARD_RESET_CLIENT_V3 10    /* initial key from client, forget previous state */
 
+/* Variant of P_CONTROL_V1 but with appended wrapped key
+ * like P_CONTROL_HARD_RESET_CLIENT_V3 */
+#define P_CONTROL_WKC_V1               11
+
 /* define the range of legal opcodes
  * Since we do no longer support key-method 1 we consider
  * the v1 op codes invalid */
 #define P_FIRST_OPCODE                 3
-#define P_LAST_OPCODE                  10
+#define P_LAST_OPCODE                  11
 
 /*
  * Define number of buffers for send and receive in the reliability layer.
@@ -86,6 +90,8 @@ enum first_packet_verdict {
     /** This packet is a valid ACK control packet from the peer,
      * i.e. it has a valid session id hmac in it */
     VERDICT_VALID_ACK_V1,
+    /** The packet is a valid control packet with appended wrapped client key */
+    VERDICT_VALID_WKC_V1,
     /** the packet failed on of the various checks */
     VERDICT_INVALID
 };
@@ -217,10 +223,12 @@ read_control_auth(struct buffer *buf,
  * The returned buf needs to be free with \c free_buf
  */
 struct buffer
-tls_reset_standalone(struct tls_auth_standalone *tas,
+tls_reset_standalone(struct tls_wrap_ctx *ctx,
+                     struct tls_auth_standalone *tas,
                      struct session_id *own_sid,
                      struct session_id *remote_sid,
-                     uint8_t header);
+                     uint8_t header,
+                     bool request_resend_wkc);
 
 static inline const char *
 packet_opcode_name(int op)
@@ -248,6 +256,9 @@ packet_opcode_name(int op)
         case P_CONTROL_V1:
             return "P_CONTROL_V1";
 
+        case P_CONTROL_WKC_V1:
+            return "P_CONTROL_WKC_V1";
+
         case P_ACK_V1:
             return "P_ACK_V1";
 
@@ -261,4 +272,20 @@ packet_opcode_name(int op)
             return "P_???";
     }
 }
+
+/* initial packet id (instead of 0) that indicates that the peer supports
+ * early protocol negotiation. This will make the packet id turn a bit faster
+ * but the network time part of the packet id takes care of that. And
+ * this is also a rather theoretical scenario as it still needs more than
+ * 2^31 control channel packets to happen */
+#define EARLY_NEG_MASK          0xff000000
+#define EARLY_NEG_START         0x0f000000
+
+
+/* Early negotiation that part of the server response in the RESET_V2 packet.
+ * Since clients that announce early negotiation support will treat the payload
+ * of reset packets special and parse it as TLV messages.
+ * as TLV (type, length, value) */
+#define TLV_TYPE_EARLY_NEG_FLAGS        0x0001
+#define EARLY_NEG_FLAG_RESEND_WKC       0x0001
 #endif /* ifndef SSL_PKT_H */
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 36812628e..9d038b774 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -536,7 +536,7 @@ test_generate_reset_packet_plain(void **ut_state)
 
     uint8_t header = 0 | (P_CONTROL_HARD_RESET_CLIENT_V2 << P_OPCODE_SHIFT);
 
-    struct buffer buf = tls_reset_standalone(&tas, &client_id, &server_id, header);
+    struct buffer buf = tls_reset_standalone(&tas.tls_wrap, &tas, &client_id, &server_id, header, false);
 
 
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
@@ -544,7 +544,7 @@ test_generate_reset_packet_plain(void **ut_state)
 
     /* Assure repeated generation of reset is deterministic/stateless*/
     assert_memory_equal(state.peer_session_id.id, client_id.id, SID_SIZE);
-    struct buffer buf2 = tls_reset_standalone(&tas, &client_id, &server_id, header);
+    struct buffer buf2 = tls_reset_standalone(&tas.tls_wrap, &tas, &client_id, &server_id, header, false);
     assert_int_equal(BLEN(&buf), BLEN(&buf2));
     assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
     free_buf(&buf2);
@@ -571,7 +571,7 @@ test_generate_reset_packet_tls_auth(void **ut_state)
 
     now = 0x22446688;
     reset_packet_id_send(&tas_client.tls_wrap.opt.packet_id.send);
-    struct buffer buf = tls_reset_standalone(&tas_client, &client_id, &server_id, header);
+    struct buffer buf = tls_reset_standalone(&tas_client.tls_wrap, &tas_client, &client_id, &server_id, header, false);
 
     enum first_packet_verdict verdict = tls_pre_decrypt_lite(&tas_server, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
@@ -580,11 +580,11 @@ test_generate_reset_packet_tls_auth(void **ut_state)
 
     /* Assure repeated generation of reset is deterministic/stateless*/
     reset_packet_id_send(&tas_client.tls_wrap.opt.packet_id.send);
-    struct buffer buf2 = tls_reset_standalone(&tas_client, &client_id, &server_id, header);
+    struct buffer buf2 = tls_reset_standalone(&tas_client.tls_wrap, &tas_client, &client_id, &server_id, header,false);
     assert_int_equal(BLEN(&buf), BLEN(&buf2));
     assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
-    free_buf(&buf2);
 
+    free_buf(&buf2);
     free_tls_pre_decrypt_state(&state);
 
     packet_id_free(&tas_client.tls_wrap.opt.packet_id);
-- 
2.32.0 (Apple Git-132)


