From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 15:40:34 +0200
Message-Id: <20220422134038.3801239-6-arne@...1227...>
In-Reply-To: <20220422134038.3801239-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 05/28] Extend tls_pre_decrypt_lite to return
 type of packet and keep state
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

This allows us to keep the temporary data for a little bit longer
so we can use this to make further checks and ultimatively use the
state to craft the HMAC based RESET reply.

For now we do not use the extra information and keep behaviour
identical.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mudp.c | 11 ++++++-
 src/openvpn/ssl.c  | 76 +++++++++++++++++++++++++++++++++-------------
 src/openvpn/ssl.h  | 37 ++++++++++++++++++++--
 3 files changed, 99 insertions(+), 25 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 910268333..6dd026701 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -46,7 +46,16 @@ do_pre_decrypt_check(struct multi_context *m)
     {
         return false;
     }
-    if (!tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf))
+
+    enum first_packet_verdict verdict;
+    struct tls_pre_decrypt_state state = {0};
+
+    verdict = tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &state,
+                                   &m->top.c2.from, &m->top.c2.buf);
+
+    free_tls_pre_decrypt_state(&state);
+
+    if (verdict == VERDICT_INVALID || verdict == VERDICT_VALID_CONTROL_V1)
     {
         return false;
     }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index f58f3b727..452433ebb 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1367,7 +1367,6 @@ tls_multi_free(struct tls_multi *multi, bool clear)
 
 
 
-
 /*
  * Dependent on hmac size, opcode size, and session_id size.
  * Will assert if too small.
@@ -1380,10 +1379,10 @@ tls_multi_free(struct tls_multi *multi, bool clear)
  *
  * Turning the on wire format that starts with the opcode to a format
  * that starts with the hmac
- * e.g. "onwire" [opcode + packet id] [hmac] [remainder of packed]
  *
+ *    "onwire" [opcode, peer session id] [hmac, packet id] [remainder of packed]
  *
- *    "internal" [hmac] [opcode + packet id] [remainer of packet]
+ *  "internal" [hmac, packet id] [opcode, peer session id] [remainder of packet]
  *
  *  @param buf      the buffer the swap operation is executed on
  *  @param incoming determines the direction of the swap
@@ -1404,7 +1403,7 @@ swap_hmac(struct buffer *buf, const struct crypto_options *co, bool incoming)
         /* hmac + packet_id (8 bytes) */
         const int hmac_size = hmac_ctx_size(ctx->hmac) + packet_id_size(true);
 
-        /* opcode + session_id */
+        /* opcode (1 byte) + session_id (8 bytes) */
         const int osid_size = 1 + SID_SIZE;
 
         int e1, e2;
@@ -3755,6 +3754,17 @@ error:
     goto done;
 }
 
+void
+free_tls_pre_decrypt_state(struct tls_pre_decrypt_state *state)
+{
+    free_buf(&state->newbuf);
+    free_buf(&state->tls_wrap_tmp.tls_crypt_v2_metadata);
+    if (state->tls_wrap_tmp.cleanup_key_ctx)
+    {
+        free_key_ctx_bi(&state->tls_wrap_tmp.opt.key_ctx_bi);
+    }
+}
+
 /*
  * This function is similar to tls_pre_decrypt, except it is called
  * when we are in server mode and receive an initial incoming
@@ -3766,17 +3776,21 @@ error:
  * This function is essentially the first-line HMAC firewall
  * on the UDP port listener in --mode server mode.
  */
-bool
+enum first_packet_verdict
 tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
+                     struct tls_pre_decrypt_state *state,
                      const struct link_socket_actual *from,
                      const struct buffer *buf)
-
 {
-    if (buf->len <= 0)
+    struct gc_arena gc = gc_new();
+    /* A packet needs to have at least an opcode and session id */
+    if (buf->len < (1 + SID_SIZE))
     {
-        return false;
+        dmsg(D_TLS_STATE_ERRORS,
+             "TLS State Error: Too short packet (length  %d) received from %s",
+             buf->len, print_link_socket_actual(from, &gc));
+        goto error;
     }
-    struct gc_arena gc = gc_new();
 
     /* get opcode and key ID */
     uint8_t pkt_firstbyte = *BPTR(buf);
@@ -3786,8 +3800,10 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
     /* this packet is from an as-yet untrusted source, so
      * scrutinize carefully */
 
+    /* Allow only the reset packet or the first packet of the actual handshake. */
     if (op != P_CONTROL_HARD_RESET_CLIENT_V2
-        && op != P_CONTROL_HARD_RESET_CLIENT_V3)
+        && op != P_CONTROL_HARD_RESET_CLIENT_V3
+        && op != P_CONTROL_V1)
     {
         /*
          * This can occur due to bogus data or DoS packets.
@@ -3808,17 +3824,28 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
         goto error;
     }
 
-    struct buffer newbuf = clone_buf(buf);
-    struct tls_wrap_ctx tls_wrap_tmp = tas->tls_wrap;
-
-    /* HMAC test, if --tls-auth was specified */
-    bool status = read_control_auth(&newbuf, &tls_wrap_tmp, from, NULL);
-    free_buf(&newbuf);
-    free_buf(&tls_wrap_tmp.tls_crypt_v2_metadata);
-    if (tls_wrap_tmp.cleanup_key_ctx)
+    /* read peer session id, we do this at this point since
+     * read_control_auth will skip over it */
+    struct buffer tmp = *buf;
+    buf_advance(&tmp, 1);
+    if (!session_id_read(&state->peer_session_id, &tmp)
+        || !session_id_defined(&state->peer_session_id))
     {
-        free_key_ctx_bi(&tls_wrap_tmp.opt.key_ctx_bi);
+        msg(D_TLS_ERRORS,
+            "TLS Error: session-id not found in packet from %s",
+            print_link_socket_actual(from, &gc));
+        goto error;
     }
+
+    state->newbuf = clone_buf(buf);
+    state->tls_wrap_tmp = tas->tls_wrap;
+
+    /* HMAC test and unwrapping the encrypted part of the control message
+     * into newbuf or just setting newbuf to point to the start of control
+     * message */
+    bool status = read_control_auth(&state->newbuf, &state->tls_wrap_tmp,
+                                    from, NULL);
+
     if (!status)
     {
         goto error;
@@ -3840,12 +3867,19 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
      * of authentication solely up to TLS.
      */
     gc_free(&gc);
-    return true;
+    if (op == P_CONTROL_V1)
+    {
+        return VERDICT_VALID_CONTROL_V1;
+    }
+    else
+    {
+        return VERDICT_VALID_RESET;
+    }
 
 error:
     tls_clear_error();
     gc_free(&gc);
-    return false;
+    return VERDICT_INVALID;
 }
 
 struct key_state *
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 5b9232006..d72bf3c50 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -323,6 +323,33 @@ bool tls_pre_decrypt(struct tls_multi *multi,
 /** @name Functions for managing security parameter state for data channel packets
  *  @{ */
 
+
+enum first_packet_verdict {
+    /** This packet is a valid reset packet from the peer */
+    VERDICT_VALID_RESET,
+    /** This packet is a valid control packet from the peer,
+     * i.e. it has a valid session id hmac in it */
+    VERDICT_VALID_CONTROL_V1,
+    /** the packet failed on of the various checks */
+    VERDICT_INVALID
+};
+
+/**
+ * struct that stores the temporary data for the tls lite decrypt
+ * functions
+ */
+struct tls_pre_decrypt_state {
+    struct tls_wrap_ctx tls_wrap_tmp;
+    struct buffer newbuf;
+    struct session_id peer_session_id;
+};
+
+/**
+ *
+ * @param state
+ */
+void free_tls_pre_decrypt_state(struct tls_pre_decrypt_state *state);
+
 /**
  * Inspect an incoming packet for which no VPN tunnel is active, and
  * determine whether a new VPN tunnel should be created.
@@ -343,6 +370,8 @@ bool tls_pre_decrypt(struct tls_multi *multi,
  * whether a new VPN tunnel should be created.  If so, that new VPN tunnel
  * instance will handle processing of the packet.
  *
+ * This function is only used in the UDP p2mp server code path
+ *
  * @param tas - The standalone TLS authentication setting structure for
  *     this process.
  * @param from - The source address of the packet.
@@ -354,9 +383,11 @@ bool tls_pre_decrypt(struct tls_multi *multi,
  * @li False if the packet is not valid, did not pass the HMAC firewall
  *     test, or some other error occurred.
  */
-bool tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
-                          const struct link_socket_actual *from,
-                          const struct buffer *buf);
+enum first_packet_verdict
+tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
+                     struct tls_pre_decrypt_state *state,
+                     const struct link_socket_actual *from,
+                     const struct buffer *buf);
 
 
 /**
-- 
2.32.0 (Apple Git-132)


