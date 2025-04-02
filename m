From: Gert Doering <gert@...1296...>
Date: Wed,  2 Apr 2025 16:23:38 +0200
Message-ID: <20250402142338.60879-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Allow tls-crypt-v2 to be setup only on
 initial packet of a session
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

This fixes an internal server error condition that can be triggered by a
malicous authenticated client, a very unlucky corruption of packets in
transit or by an attacker that is able to inject a specially created
packet at the right time and is able to observe the traffic to construct
the packet.

The error condition results in an ASSERT statement being triggered,

NOTE: due to the security sensitive nature, this patch was prepared
under embargo on the security@...515... mailing list, and thus has
no publically available "mailing list discussion before merge" URL.

CVE: 2025-2704
Change-Id: I07c1352204d308e5bde5f0b85e561a5dd0bc63c8
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <385d88f0-d7c9-4330-82ff-9f5931183afd@...1227...>
Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/ssl.c                         | 26 +++++++++++++++++++----
 src/openvpn/ssl_common.h                  | 15 +++++++------
 src/openvpn/ssl_pkt.c                     |  7 +++---
 src/openvpn/ssl_pkt.h                     | 12 +++++++++--
 src/openvpn/tls_crypt.c                   | 24 ++++++++++++++++++++-
 src/openvpn/tls_crypt.h                   |  7 +++++-
 tests/unit_tests/openvpn/test_tls_crypt.c |  2 +-
 7 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 99b5c077..23f64232 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -697,6 +697,9 @@ state_name(int state)
         case S_INITIAL:
             return "S_INITIAL";
 
+        case S_PRE_START_SKIP:
+            return "S_PRE_START_SKIP";
+
         case S_PRE_START:
             return "S_PRE_START";
 
@@ -2506,7 +2509,7 @@ session_move_pre_start(const struct tls_session *session,
     }
     INCR_GENERATED;
 
-    ks->state = S_PRE_START;
+    ks->state = skip_initial_send ? S_PRE_START_SKIP : S_PRE_START;
 
     struct gc_arena gc = gc_new();
     dmsg(D_TLS_DEBUG, "TLS: Initial Handshake, sid=%s",
@@ -3825,7 +3828,7 @@ tls_pre_decrypt(struct tls_multi *multi,
         }
 
         if (!read_control_auth(buf, tls_session_get_tls_wrap(session, key_id), from,
-                               session->opt))
+                               session->opt, true))
         {
             goto error;
         }
@@ -3895,7 +3898,7 @@ tls_pre_decrypt(struct tls_multi *multi,
         if (op == P_CONTROL_SOFT_RESET_V1 && ks->state >= S_GENERATED_KEYS)
         {
             if (!read_control_auth(buf, tls_session_get_tls_wrap(session, key_id),
-                                   from, session->opt))
+                                   from, session->opt, false))
             {
                 goto error;
             }
@@ -3908,6 +3911,15 @@ tls_pre_decrypt(struct tls_multi *multi,
         }
         else
         {
+            bool initial_packet = false;
+            if (ks->state == S_PRE_START_SKIP)
+            {
+                /* When we are coming from the session_skip_to_pre_start
+                 * method, we allow this initial packet to setup the
+                 * tls-crypt-v2 peer specific key */
+                initial_packet = true;
+                ks->state = S_PRE_START;
+            }
             /*
              * Remote responding to our key renegotiation request?
              */
@@ -3917,8 +3929,14 @@ tls_pre_decrypt(struct tls_multi *multi,
             }
 
             if (!read_control_auth(buf, tls_session_get_tls_wrap(session, key_id),
-                                   from, session->opt))
+                                   from, session->opt, initial_packet))
             {
+                /* if an initial packet in read_control_auth, we rather
+                 * error out than anything else */
+                if (initial_packet)
+                {
+                    multi->n_hard_errors++;
+                }
                 goto error;
             }
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 68a6ce63..90e16f9e 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -84,22 +84,25 @@
 #define S_INITIAL         1     /**< Initial \c key_state state after
                                  *   initialization by \c key_state_init()
                                  *   before start of three-way handshake. */
-#define S_PRE_START       2     /**< Waiting for the remote OpenVPN peer
+#define S_PRE_START_SKIP  2     /**< Waiting for the remote OpenVPN peer
                                  *   to acknowledge during the initial
                                  *   three-way handshake. */
-#define S_START           3     /**< Three-way handshake is complete,
+#define S_PRE_START       3     /**< Waiting for the remote OpenVPN peer
+                                 *   to acknowledge during the initial
+                                 *   three-way handshake. */
+#define S_START           4     /**< Three-way handshake is complete,
                                  *   start of key exchange. */
-#define S_SENT_KEY        4     /**< Local OpenVPN process has sent its
+#define S_SENT_KEY        5     /**< Local OpenVPN process has sent its
                                  *   part of the key material. */
-#define S_GOT_KEY         5     /**< Local OpenVPN process has received
+#define S_GOT_KEY         6     /**< Local OpenVPN process has received
                                  *   the remote's part of the key
                                  *   material. */
-#define S_ACTIVE          6     /**< Operational \c key_state state
+#define S_ACTIVE          7     /**< Operational \c key_state state
                                  *   immediately after negotiation has
                                  *   completed while still within the
                                  *   handshake window.  Deferred auth and
                                  *   client connect can still be pending. */
-#define S_GENERATED_KEYS  7     /**< The data channel keys have been generated
+#define S_GENERATED_KEYS  8     /**< The data channel keys have been generated
                                  *  The TLS session is fully authenticated
                                  *  when reaching this state. */
 
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 689cd7f9..41299f46 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -200,7 +200,8 @@ bool
 read_control_auth(struct buffer *buf,
                   struct tls_wrap_ctx *ctx,
                   const struct link_socket_actual *from,
-                  const struct tls_options *opt)
+                  const struct tls_options *opt,
+                  bool initial_packet)
 {
     struct gc_arena gc = gc_new();
     bool ret = false;
@@ -208,7 +209,7 @@ read_control_auth(struct buffer *buf,
     const uint8_t opcode = *(BPTR(buf)) >> P_OPCODE_SHIFT;
     if ((opcode == P_CONTROL_HARD_RESET_CLIENT_V3
          || opcode == P_CONTROL_WKC_V1)
-        && !tls_crypt_v2_extract_client_key(buf, ctx, opt))
+        && !tls_crypt_v2_extract_client_key(buf, ctx, opt, initial_packet))
     {
         msg(D_TLS_ERRORS,
             "TLS Error: can not extract tls-crypt-v2 client key from %s",
@@ -373,7 +374,7 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
      * into newbuf or just setting newbuf to point to the start of control
      * message */
     bool status = read_control_auth(&state->newbuf, &state->tls_wrap_tmp,
-                                    from, NULL);
+                                    from, NULL, true);
 
     if (!status)
     {
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index b2c4b372..e7823916 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -208,14 +208,22 @@ write_control_auth(struct tls_session *session,
                    bool prepend_ack);
 
 
-/*
+
+/**
  * Read a control channel authentication record.
+ * @param buf               buffer that holds the incoming packet
+ * @param ctx               control channel security context
+ * @param from              incoming link socket address
+ * @param opt               tls options struct for the session
+ * @param initial_packet    whether this is the initial packet for the connection
+ * @return                  if the packet was successfully processed
  */
 bool
 read_control_auth(struct buffer *buf,
                   struct tls_wrap_ctx *ctx,
                   const struct link_socket_actual *from,
-                  const struct tls_options *opt);
+                  const struct tls_options *opt,
+                  bool initial_packet);
 
 
 /**
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 9e9807d3..67e19382 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -614,7 +614,8 @@ cleanup:
 bool
 tls_crypt_v2_extract_client_key(struct buffer *buf,
                                 struct tls_wrap_ctx *ctx,
-                                const struct tls_options *opt)
+                                const struct tls_options *opt,
+                                bool initial_packet)
 {
     if (!ctx->tls_crypt_v2_server_key.cipher)
     {
@@ -643,6 +644,27 @@ tls_crypt_v2_extract_client_key(struct buffer *buf,
         return false;
     }
 
+    if (!initial_packet)
+    {
+        /* This might be a harmless resend of the packet but it is better to
+         * just ignore the WKC part than trying to setup tls-crypt keys again.
+         *
+         * A CONTROL_WKC_V1 packets has a normal packet part and an appended
+         * wrapped control key. These are authenticated individually. We already
+         * set up tls-crypt with the wrapped key, so we are ignoring this part
+         * of the message but we return the normal packet part as the normal
+         * part of the message might have been corrupted earlier and discarded
+         * and this is resend. So return the normal part of the packet,
+         * basically transforming the CONTROL_WKC_V1 into a normal CONTROL_V1
+         * packet*/
+        msg(D_TLS_ERRORS, "control channel security already setup ignoring "
+            "wrapped key part of packet.");
+
+        /* Remove client key from buffer so tls-crypt code can unwrap message */
+        ASSERT(buf_inc_len(buf, -(BLEN(&wrapped_client_key))));
+        return true;
+    }
+
     ctx->tls_crypt_v2_metadata = alloc_buf(TLS_CRYPT_V2_MAX_METADATA_LEN);
     if (!tls_crypt_v2_unwrap_client_key(&ctx->original_wrap_keydata,
                                         &ctx->tls_crypt_v2_metadata,
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index e98aae78..1a604ce8 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -205,11 +205,16 @@ void tls_crypt_v2_init_client_key(struct key_ctx_bi *key,
  *              message.
  * @param ctx   tls-wrap context to be initialized with the client key.
  *
+ * @param initial_packet    whether this is the initial packet of the
+ *                          connection. Only in these scenarios unwrapping
+ *                          of a tls-crypt-v2 key is allowed
+ *
  * @returns true if a key was successfully extracted.
  */
 bool tls_crypt_v2_extract_client_key(struct buffer *buf,
                                      struct tls_wrap_ctx *ctx,
-                                     const struct tls_options *opt);
+                                     const struct tls_options *opt,
+                                     bool initial_packet);
 
 /**
  * Generate a tls-crypt-v2 server key, and write to file.
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index ee252f43..cc415c89 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -535,7 +535,7 @@ tls_crypt_v2_wrap_unwrap_max_metadata(void **state)
         .mode = TLS_WRAP_CRYPT,
         .tls_crypt_v2_server_key = ctx->server_keys.encrypt,
     };
-    assert_true(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx, NULL));
+    assert_true(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx, NULL, true));
     tls_wrap_free(&wrap_ctx);
 }
 
-- 
2.47.0


