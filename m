From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 15:40:35 +0200
Message-Id: <20220422134038.3801239-7-arne@...1227...>
In-Reply-To: <20220422134038.3801239-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 06/28] Move ssl function related to control
 channel wrap/unwrap to ssl_pkt.c/h
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

This allows these functions to be relatively easily included into the
unit test without pulling ssl.c and all the dependencies of ssl.c into
a unit test.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/Makefile.am             |   1 +
 src/openvpn/mudp.c                  |   1 +
 src/openvpn/openvpn.vcxproj         |   2 +
 src/openvpn/openvpn.vcxproj.filters |   3 +
 src/openvpn/ssl.c                   | 392 ----------------------------
 src/openvpn/ssl.h                   | 103 +-------
 src/openvpn/ssl_mbedtls.c           |   5 -
 src/openvpn/ssl_mbedtls.h           |   4 +
 src/openvpn/ssl_openssl.c           |   6 -
 src/openvpn/ssl_openssl.h           |   7 +
 src/openvpn/ssl_pkt.c               | 382 +++++++++++++++++++++++++++
 src/openvpn/ssl_pkt.h               | 199 ++++++++++++++
 12 files changed, 600 insertions(+), 505 deletions(-)
 create mode 100644 src/openvpn/ssl_pkt.c
 create mode 100644 src/openvpn/ssl_pkt.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index fc22feb9c..8fcba672e 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -119,6 +119,7 @@ openvpn_SOURCES = \
 	ssl_openssl.c ssl_openssl.h \
 	ssl_mbedtls.c ssl_mbedtls.h \
 	ssl_ncp.c ssl_ncp.h \
+    ssl_pkt.c ssl_pkt.h \
 	ssl_util.c ssl_util.h \
 	ssl_common.h \
 	ssl_verify.c ssl_verify.h ssl_verify_backend.h \
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 6dd026701..584701875 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -34,6 +34,7 @@
 #include "forward.h"
 
 #include "memdbg.h"
+#include "ssl_pkt.h"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify.h>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index a43cbd814..5e7d94d9d 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -322,6 +322,7 @@
     <ClCompile Include="ssl.c" />
     <ClCompile Include="ssl_openssl.c" />
     <ClCompile Include="ssl_ncp.c" />
+    <ClCompile Include="ssl_pkt.c" />
     <ClCompile Include="ssl_util.c" />
     <ClCompile Include="ssl_verify.c" />
     <ClCompile Include="ssl_verify_openssl.c" />
@@ -414,6 +415,7 @@
     <ClInclude Include="ssl_common.h" />
     <ClInclude Include="ssl_ncp.h" />
     <ClInclude Include="ssl_openssl.h" />
+    <ClInclude Include="ssl_pkt.h" />
     <ClInclude Include="ssl_util.h" />
     <ClInclude Include="ssl_verify.h" />
     <ClInclude Include="ssl_verify_backend.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index abc45225d..f76e59235 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -246,6 +246,9 @@
     <ClCompile Include="ssl_ncp.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="ssl_pkt.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
     <ClCompile Include="ssl_util.c">
       <Filter>Source Files</Filter>
     </ClCompile>
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 452433ebb..91f0e214d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -820,46 +820,6 @@ ks_auth_name(enum ks_auth_state auth)
     }
 }
 
-static const char *
-packet_opcode_name(int op)
-{
-    switch (op)
-    {
-        case P_CONTROL_HARD_RESET_CLIENT_V1:
-            return "P_CONTROL_HARD_RESET_CLIENT_V1";
-
-        case P_CONTROL_HARD_RESET_SERVER_V1:
-            return "P_CONTROL_HARD_RESET_SERVER_V1";
-
-        case P_CONTROL_HARD_RESET_CLIENT_V2:
-            return "P_CONTROL_HARD_RESET_CLIENT_V2";
-
-        case P_CONTROL_HARD_RESET_SERVER_V2:
-            return "P_CONTROL_HARD_RESET_SERVER_V2";
-
-        case P_CONTROL_HARD_RESET_CLIENT_V3:
-            return "P_CONTROL_HARD_RESET_CLIENT_V3";
-
-        case P_CONTROL_SOFT_RESET_V1:
-            return "P_CONTROL_SOFT_RESET_V1";
-
-        case P_CONTROL_V1:
-            return "P_CONTROL_V1";
-
-        case P_ACK_V1:
-            return "P_ACK_V1";
-
-        case P_DATA_V1:
-            return "P_DATA_V1";
-
-        case P_DATA_V2:
-            return "P_DATA_V2";
-
-        default:
-            return "P_???";
-    }
-}
-
 static const char *
 session_index_name(int index)
 {
@@ -1365,231 +1325,6 @@ tls_multi_free(struct tls_multi *multi, bool clear)
     free(multi);
 }
 
-
-
-/*
- * Dependent on hmac size, opcode size, and session_id size.
- * Will assert if too small.
- */
-#define SWAP_BUF_SIZE 256
-
-/**
- * Move a packet authentication HMAC + related fields to or from the front
- * of the buffer so it can be processed by encrypt/decrypt.
- *
- * Turning the on wire format that starts with the opcode to a format
- * that starts with the hmac
- *
- *    "onwire" [opcode, peer session id] [hmac, packet id] [remainder of packed]
- *
- *  "internal" [hmac, packet id] [opcode, peer session id] [remainder of packet]
- *
- *  @param buf      the buffer the swap operation is executed on
- *  @param incoming determines the direction of the swap
- *  @param co       crypto options, determines the hmac to use in the swap
- *
- *  @return         if the swap was successful (buf was large enough)
- */
-static bool
-swap_hmac(struct buffer *buf, const struct crypto_options *co, bool incoming)
-{
-    ASSERT(co);
-
-    const struct key_ctx *ctx = (incoming ? &co->key_ctx_bi.decrypt :
-                                 &co->key_ctx_bi.encrypt);
-    ASSERT(ctx->hmac);
-
-    {
-        /* hmac + packet_id (8 bytes) */
-        const int hmac_size = hmac_ctx_size(ctx->hmac) + packet_id_size(true);
-
-        /* opcode (1 byte) + session_id (8 bytes) */
-        const int osid_size = 1 + SID_SIZE;
-
-        int e1, e2;
-        uint8_t *b = BPTR(buf);
-        uint8_t buf1[SWAP_BUF_SIZE];
-        uint8_t buf2[SWAP_BUF_SIZE];
-
-        if (incoming)
-        {
-            e1 = osid_size;
-            e2 = hmac_size;
-        }
-        else
-        {
-            e1 = hmac_size;
-            e2 = osid_size;
-        }
-
-        ASSERT(e1 <= SWAP_BUF_SIZE && e2 <= SWAP_BUF_SIZE);
-
-        if (buf->len >= e1 + e2)
-        {
-            memcpy(buf1, b, e1);
-            memcpy(buf2, b + e1, e2);
-            memcpy(b, buf2, e2);
-            memcpy(b + e2, buf1, e1);
-            return true;
-        }
-        else
-        {
-            return false;
-        }
-    }
-}
-
-#undef SWAP_BUF_SIZE
-
-/*
- * Write a control channel authentication record.
- */
-static void
-write_control_auth(struct tls_session *session,
-                   struct key_state *ks,
-                   struct buffer *buf,
-                   struct link_socket_actual **to_link_addr,
-                   int opcode,
-                   int max_ack,
-                   bool prepend_ack)
-{
-    uint8_t header = ks->key_id | (opcode << P_OPCODE_SHIFT);
-    struct buffer null = clear_buf();
-
-    ASSERT(link_socket_actual_defined(&ks->remote_addr));
-    ASSERT(reliable_ack_write
-               (ks->rec_ack, buf, &ks->session_id_remote, max_ack, prepend_ack));
-
-    msg(D_TLS_DEBUG, "%s(): %s", __func__, packet_opcode_name(opcode));
-
-    if (session->tls_wrap.mode == TLS_WRAP_AUTH
-        || session->tls_wrap.mode == TLS_WRAP_NONE)
-    {
-        ASSERT(session_id_write_prepend(&session->session_id, buf));
-        ASSERT(buf_write_prepend(buf, &header, sizeof(header)));
-    }
-    if (session->tls_wrap.mode == TLS_WRAP_AUTH)
-    {
-        /* no encryption, only write hmac */
-        openvpn_encrypt(buf, null, &session->tls_wrap.opt);
-        ASSERT(swap_hmac(buf, &session->tls_wrap.opt, false));
-    }
-    else if (session->tls_wrap.mode == TLS_WRAP_CRYPT)
-    {
-        ASSERT(buf_init(&session->tls_wrap.work, buf->offset));
-        ASSERT(buf_write(&session->tls_wrap.work, &header, sizeof(header)));
-        ASSERT(session_id_write(&session->session_id, &session->tls_wrap.work));
-        if (!tls_crypt_wrap(buf, &session->tls_wrap.work, &session->tls_wrap.opt))
-        {
-            buf->len = 0;
-            return;
-        }
-
-        if (opcode == P_CONTROL_HARD_RESET_CLIENT_V3)
-        {
-            if (!buf_copy(&session->tls_wrap.work,
-                          session->tls_wrap.tls_crypt_v2_wkc))
-            {
-                msg(D_TLS_ERRORS, "Could not append tls-crypt-v2 client key");
-                buf->len = 0;
-                return;
-            }
-        }
-
-        /* Don't change the original data in buf, it's used by the reliability
-         * layer to resend on failure. */
-        *buf = session->tls_wrap.work;
-    }
-    *to_link_addr = &ks->remote_addr;
-}
-
-/*
- * Read a control channel authentication record.
- */
-static bool
-read_control_auth(struct buffer *buf,
-                  struct tls_wrap_ctx *ctx,
-                  const struct link_socket_actual *from,
-                  const struct tls_options *opt)
-{
-    struct gc_arena gc = gc_new();
-    bool ret = false;
-
-    const uint8_t opcode = *(BPTR(buf)) >> P_OPCODE_SHIFT;
-    if (opcode == P_CONTROL_HARD_RESET_CLIENT_V3
-        && !tls_crypt_v2_extract_client_key(buf, ctx, opt))
-    {
-        msg(D_TLS_ERRORS,
-            "TLS Error: can not extract tls-crypt-v2 client key from %s",
-            print_link_socket_actual(from, &gc));
-        goto cleanup;
-    }
-
-    if (ctx->mode == TLS_WRAP_AUTH)
-    {
-        struct buffer null = clear_buf();
-
-        /* move the hmac record to the front of the packet */
-        if (!swap_hmac(buf, &ctx->opt, true))
-        {
-            msg(D_TLS_ERRORS,
-                "TLS Error: cannot locate HMAC in incoming packet from %s",
-                print_link_socket_actual(from, &gc));
-            gc_free(&gc);
-            return false;
-        }
-
-        /* authenticate only (no decrypt) and remove the hmac record
-         * from the head of the buffer */
-        openvpn_decrypt(buf, null, &ctx->opt, NULL, BPTR(buf));
-        if (!buf->len)
-        {
-            msg(D_TLS_ERRORS,
-                "TLS Error: incoming packet authentication failed from %s",
-                print_link_socket_actual(from, &gc));
-            goto cleanup;
-        }
-
-    }
-    else if (ctx->mode == TLS_WRAP_CRYPT)
-    {
-        struct buffer tmp = alloc_buf_gc(buf_forward_capacity_total(buf), &gc);
-        if (!tls_crypt_unwrap(buf, &tmp, &ctx->opt))
-        {
-            msg(D_TLS_ERRORS, "TLS Error: tls-crypt unwrapping failed from %s",
-                print_link_socket_actual(from, &gc));
-            goto cleanup;
-        }
-        ASSERT(buf_init(buf, buf->offset));
-        ASSERT(buf_copy(buf, &tmp));
-        buf_clear(&tmp);
-    }
-    else if (ctx->tls_crypt_v2_server_key.cipher)
-    {
-        /* If tls-crypt-v2 is enabled, require *some* wrapping */
-        msg(D_TLS_ERRORS, "TLS Error: could not determine wrapping from %s",
-            print_link_socket_actual(from, &gc));
-        /* TODO Do we want to support using tls-crypt-v2 and no control channel
-         * wrapping at all simultaneously?  That would allow server admins to
-         * upgrade clients one-by-one without running a second instance, but we
-         * should not enable it by default because it breaks DoS-protection.
-         * So, add something like --tls-crypt-v2-allow-insecure-fallback ? */
-        goto cleanup;
-    }
-
-    if (ctx->mode == TLS_WRAP_NONE || ctx->mode == TLS_WRAP_AUTH)
-    {
-        /* advance buffer pointer past opcode & session_id since our caller
-         * already read it */
-        buf_advance(buf, SID_SIZE + 1);
-    }
-
-    ret = true;
-cleanup:
-    gc_free(&gc);
-    return ret;
-}
-
 /*
  * For debugging, print contents of key_source2 structure.
  */
@@ -3754,133 +3489,6 @@ error:
     goto done;
 }
 
-void
-free_tls_pre_decrypt_state(struct tls_pre_decrypt_state *state)
-{
-    free_buf(&state->newbuf);
-    free_buf(&state->tls_wrap_tmp.tls_crypt_v2_metadata);
-    if (state->tls_wrap_tmp.cleanup_key_ctx)
-    {
-        free_key_ctx_bi(&state->tls_wrap_tmp.opt.key_ctx_bi);
-    }
-}
-
-/*
- * This function is similar to tls_pre_decrypt, except it is called
- * when we are in server mode and receive an initial incoming
- * packet.  Note that we don't modify
- * any state in our parameter objects.  The purpose is solely to
- * determine whether we should generate a client instance
- * object, in which case true is returned.
- *
- * This function is essentially the first-line HMAC firewall
- * on the UDP port listener in --mode server mode.
- */
-enum first_packet_verdict
-tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
-                     struct tls_pre_decrypt_state *state,
-                     const struct link_socket_actual *from,
-                     const struct buffer *buf)
-{
-    struct gc_arena gc = gc_new();
-    /* A packet needs to have at least an opcode and session id */
-    if (buf->len < (1 + SID_SIZE))
-    {
-        dmsg(D_TLS_STATE_ERRORS,
-             "TLS State Error: Too short packet (length  %d) received from %s",
-             buf->len, print_link_socket_actual(from, &gc));
-        goto error;
-    }
-
-    /* get opcode and key ID */
-    uint8_t pkt_firstbyte = *BPTR(buf);
-    int op = pkt_firstbyte >> P_OPCODE_SHIFT;
-    int key_id = pkt_firstbyte & P_KEY_ID_MASK;
-
-    /* this packet is from an as-yet untrusted source, so
-     * scrutinize carefully */
-
-    /* Allow only the reset packet or the first packet of the actual handshake. */
-    if (op != P_CONTROL_HARD_RESET_CLIENT_V2
-        && op != P_CONTROL_HARD_RESET_CLIENT_V3
-        && op != P_CONTROL_V1)
-    {
-        /*
-         * This can occur due to bogus data or DoS packets.
-         */
-        dmsg(D_TLS_STATE_ERRORS,
-             "TLS State Error: No TLS state for client %s, opcode=%d",
-             print_link_socket_actual(from, &gc),
-             op);
-        goto error;
-    }
-
-    if (key_id != 0)
-    {
-        dmsg(D_TLS_STATE_ERRORS,
-             "TLS State Error: Unknown key ID (%d) received from %s -- 0 was expected",
-             key_id,
-             print_link_socket_actual(from, &gc));
-        goto error;
-    }
-
-    /* read peer session id, we do this at this point since
-     * read_control_auth will skip over it */
-    struct buffer tmp = *buf;
-    buf_advance(&tmp, 1);
-    if (!session_id_read(&state->peer_session_id, &tmp)
-        || !session_id_defined(&state->peer_session_id))
-    {
-        msg(D_TLS_ERRORS,
-            "TLS Error: session-id not found in packet from %s",
-            print_link_socket_actual(from, &gc));
-        goto error;
-    }
-
-    state->newbuf = clone_buf(buf);
-    state->tls_wrap_tmp = tas->tls_wrap;
-
-    /* HMAC test and unwrapping the encrypted part of the control message
-     * into newbuf or just setting newbuf to point to the start of control
-     * message */
-    bool status = read_control_auth(&state->newbuf, &state->tls_wrap_tmp,
-                                    from, NULL);
-
-    if (!status)
-    {
-        goto error;
-    }
-
-    /*
-     * At this point, if --tls-auth is being used, we know that
-     * the packet has passed the HMAC test, but we don't know if
-     * it is a replay yet.  We will attempt to defeat replays
-     * by not advancing to the S_START state until we
-     * receive an ACK from our first reply to the client
-     * that includes an HMAC of our randomly generated 64 bit
-     * session ID.
-     *
-     * On the other hand if --tls-auth is not being used, we
-     * will proceed to begin the TLS authentication
-     * handshake with only cursory integrity checks having
-     * been performed, since we will be leaving the task
-     * of authentication solely up to TLS.
-     */
-    gc_free(&gc);
-    if (op == P_CONTROL_V1)
-    {
-        return VERDICT_VALID_CONTROL_V1;
-    }
-    else
-    {
-        return VERDICT_VALID_RESET;
-    }
-
-error:
-    tls_clear_error();
-    gc_free(&gc);
-    return VERDICT_INVALID;
-}
 
 struct key_state *
 tls_select_encryption_key(struct tls_multi *multi)
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index d72bf3c50..d718aa27b 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -42,36 +42,11 @@
 
 #include "ssl_common.h"
 #include "ssl_backend.h"
+#include "ssl_pkt.h"
 
 /* Used in the TLS PRF function */
 #define KEY_EXPANSION_ID "OpenVPN"
 
-/* packet opcode (high 5 bits) and key-id (low 3 bits) are combined in one byte */
-#define P_KEY_ID_MASK                  0x07
-#define P_OPCODE_SHIFT                 3
-
-/* packet opcodes -- the V1 is intended to allow protocol changes in the future */
-#define P_CONTROL_HARD_RESET_CLIENT_V1 1     /* initial key from client, forget previous state */
-#define P_CONTROL_HARD_RESET_SERVER_V1 2     /* initial key from server, forget previous state */
-#define P_CONTROL_SOFT_RESET_V1        3     /* new key, graceful transition from old to new key */
-#define P_CONTROL_V1                   4     /* control channel packet (usually TLS ciphertext) */
-#define P_ACK_V1                       5     /* acknowledgement for packets received */
-#define P_DATA_V1                      6     /* data channel packet */
-#define P_DATA_V2                      9     /* data channel packet with peer-id */
-
-/* indicates key_method >= 2 */
-#define P_CONTROL_HARD_RESET_CLIENT_V2 7     /* initial key from client, forget previous state */
-#define P_CONTROL_HARD_RESET_SERVER_V2 8     /* initial key from server, forget previous state */
-
-/* indicates key_method >= 2 and client-specific tls-crypt key */
-#define P_CONTROL_HARD_RESET_CLIENT_V3 10    /* initial key from client, forget previous state */
-
-/* define the range of legal opcodes
- * Since we do no longer support key-method 1 we consider
- * the v1 op codes invalid */
-#define P_FIRST_OPCODE                 3
-#define P_LAST_OPCODE                  10
-
 /*
  * Set the max number of acknowledgments that can "hitch a ride" on an outgoing
  * non-P_ACK_V1 control packet.
@@ -137,16 +112,6 @@
  */
 /* #define MEASURE_TLS_HANDSHAKE_STATS */
 
-/*
- * Used in --mode server mode to check tls-auth signature on initial
- * packets received from new clients.
- */
-struct tls_auth_standalone
-{
-    struct tls_wrap_ctx tls_wrap;
-    struct frame frame;
-};
-
 /*
  * Prepare the SSL library for use
  */
@@ -324,72 +289,6 @@ bool tls_pre_decrypt(struct tls_multi *multi,
  *  @{ */
 
 
-enum first_packet_verdict {
-    /** This packet is a valid reset packet from the peer */
-    VERDICT_VALID_RESET,
-    /** This packet is a valid control packet from the peer,
-     * i.e. it has a valid session id hmac in it */
-    VERDICT_VALID_CONTROL_V1,
-    /** the packet failed on of the various checks */
-    VERDICT_INVALID
-};
-
-/**
- * struct that stores the temporary data for the tls lite decrypt
- * functions
- */
-struct tls_pre_decrypt_state {
-    struct tls_wrap_ctx tls_wrap_tmp;
-    struct buffer newbuf;
-    struct session_id peer_session_id;
-};
-
-/**
- *
- * @param state
- */
-void free_tls_pre_decrypt_state(struct tls_pre_decrypt_state *state);
-
-/**
- * Inspect an incoming packet for which no VPN tunnel is active, and
- * determine whether a new VPN tunnel should be created.
- * @ingroup data_crypto
- *
- * This function receives the initial incoming packet from a client that
- * wishes to establish a new VPN tunnel, and determines the packet is a
- * valid initial packet.  It is only used when OpenVPN is running in
- * server mode.
- *
- * The tests performed by this function are whether the packet's opcode is
- * correct for establishing a new VPN tunnel, whether its key ID is 0, and
- * whether its size is not too large.  This function also performs the
- * initial HMAC firewall test, if configured to do so.
- *
- * The incoming packet and the local VPN tunnel state are not modified by
- * this function.  Its sole purpose is to inspect the packet and determine
- * whether a new VPN tunnel should be created.  If so, that new VPN tunnel
- * instance will handle processing of the packet.
- *
- * This function is only used in the UDP p2mp server code path
- *
- * @param tas - The standalone TLS authentication setting structure for
- *     this process.
- * @param from - The source address of the packet.
- * @param buf - A buffer structure containing the incoming packet.
- *
- * @return
- * @li True if the packet is valid and a new VPN tunnel should be created
- *     for this client.
- * @li False if the packet is not valid, did not pass the HMAC firewall
- *     test, or some other error occurred.
- */
-enum first_packet_verdict
-tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
-                     struct tls_pre_decrypt_state *state,
-                     const struct link_socket_actual *from,
-                     const struct buffer *buf);
-
-
 /**
  * Choose the appropriate security parameters with which to process an
  * outgoing packet.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index e86c95b69..b0785bae9 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -117,11 +117,6 @@ tls_free_lib(void)
 {
 }
 
-void
-tls_clear_error(void)
-{
-}
-
 void
 tls_ctx_server_new(struct tls_root_ctx *ctx)
 {
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 175e6bd90..8ca26791d 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -144,4 +144,8 @@ int tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx,
                                       external_sign_func sign_func,
                                       void *sign_ctx);
 
+static inline void
+tls_clear_error(void)
+{
+}
 #endif /* SSL_MBEDTLS_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 1ae144ab1..c9ea10d49 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -107,12 +107,6 @@ tls_free_lib(void)
 #endif
 }
 
-void
-tls_clear_error(void)
-{
-    ERR_clear_error();
-}
-
 void
 tls_ctx_server_new(struct tls_root_ctx *ctx)
 {
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 5f4d4992d..752b69ce2 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -30,6 +30,7 @@
 #define SSL_OPENSSL_H_
 
 #include <openssl/ssl.h>
+#include <openssl/err.h>
 
 /**
  * Structure that wraps the TLS context. Contents differ depending on the
@@ -54,4 +55,10 @@ struct key_state_ssl {
  */
 extern int mydata_index; /* GLOBAL */
 
+static inline void
+tls_clear_error(void)
+{
+    ERR_clear_error();
+}
+
 #endif /* SSL_OPENSSL_H_ */
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
new file mode 100644
index 000000000..e8cc7dee9
--- /dev/null
+++ b/src/openvpn/ssl_pkt.c
@@ -0,0 +1,382 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#include "ssl_util.h"
+#include "ssl_pkt.h"
+#include "ssl_common.h"
+#include "crypto.h"
+#include "session_id.h"
+#include "reliable.h"
+#include "tls_crypt.h"
+
+/*
+ * Dependent on hmac size, opcode size, and session_id size.
+ * Will assert if too small.
+ */
+#define SWAP_BUF_SIZE 256
+
+/**
+ * Move a packet authentication HMAC + related fields to or from the front
+ * of the buffer so it can be processed by encrypt/decrypt.
+ *
+ * Turning the on wire format that starts with the opcode to a format
+ * that starts with the hmac
+ * e.g. "onwire" [opcode, peer session id] [hmac, packet id] [remainder of packed]
+ *
+ *
+ *    "internal" [hmac, packet id] [opcode, peer session id] [remainder of packet]
+ *
+ *  @param buf      the buffer the swap operation is executed on
+ *  @param incoming determines the direction of the swap
+ *  @param co       crypto options, determines the hmac to use in the swap
+ *
+ *  @return         if the swap was successful (buf was large enough)
+ */
+static bool
+swap_hmac(struct buffer *buf, const struct crypto_options *co, bool incoming)
+{
+    ASSERT(co);
+
+    const struct key_ctx *ctx = (incoming ? &co->key_ctx_bi.decrypt :
+                                 &co->key_ctx_bi.encrypt);
+    ASSERT(ctx->hmac);
+
+    {
+        /* hmac + packet_id (8 bytes) */
+        const int hmac_size = hmac_ctx_size(ctx->hmac) + packet_id_size(true);
+
+        /* opcode (1 byte) + session_id (8 bytes) */
+        const int osid_size = 1 + SID_SIZE;
+
+        int e1, e2;
+        uint8_t *b = BPTR(buf);
+        uint8_t buf1[SWAP_BUF_SIZE];
+        uint8_t buf2[SWAP_BUF_SIZE];
+
+        if (incoming)
+        {
+            e1 = osid_size;
+            e2 = hmac_size;
+        }
+        else
+        {
+            e1 = hmac_size;
+            e2 = osid_size;
+        }
+
+        ASSERT(e1 <= SWAP_BUF_SIZE && e2 <= SWAP_BUF_SIZE);
+
+        if (buf->len >= e1 + e2)
+        {
+            memcpy(buf1, b, e1);
+            memcpy(buf2, b + e1, e2);
+            memcpy(b, buf2, e2);
+            memcpy(b + e2, buf1, e1);
+            return true;
+        }
+        else
+        {
+            return false;
+        }
+    }
+}
+
+#undef SWAP_BUF_SIZE
+
+void
+write_control_auth(struct tls_session *session,
+                   struct key_state *ks,
+                   struct buffer *buf,
+                   struct link_socket_actual **to_link_addr,
+                   int opcode,
+                   int max_ack,
+                   bool prepend_ack)
+{
+    uint8_t header = ks->key_id | (opcode << P_OPCODE_SHIFT);
+    struct buffer null = clear_buf();
+
+    ASSERT(link_socket_actual_defined(&ks->remote_addr));
+    ASSERT(reliable_ack_write
+               (ks->rec_ack, buf, &ks->session_id_remote, max_ack, prepend_ack));
+
+    msg(D_TLS_DEBUG, "%s(): %s", __func__, packet_opcode_name(opcode));
+
+    if (session->tls_wrap.mode == TLS_WRAP_AUTH
+        || session->tls_wrap.mode == TLS_WRAP_NONE)
+    {
+        ASSERT(session_id_write_prepend(&session->session_id, buf));
+        ASSERT(buf_write_prepend(buf, &header, sizeof(header)));
+    }
+    if (session->tls_wrap.mode == TLS_WRAP_AUTH)
+    {
+        /* no encryption, only write hmac */
+        openvpn_encrypt(buf, null, &session->tls_wrap.opt);
+        ASSERT(swap_hmac(buf, &session->tls_wrap.opt, false));
+    }
+    else if (session->tls_wrap.mode == TLS_WRAP_CRYPT)
+    {
+        ASSERT(buf_init(&session->tls_wrap.work, buf->offset));
+        ASSERT(buf_write(&session->tls_wrap.work, &header, sizeof(header)));
+        ASSERT(session_id_write(&session->session_id, &session->tls_wrap.work));
+        if (!tls_crypt_wrap(buf, &session->tls_wrap.work, &session->tls_wrap.opt))
+        {
+            buf->len = 0;
+            return;
+        }
+
+        if (opcode == P_CONTROL_HARD_RESET_CLIENT_V3)
+        {
+            if (!buf_copy(&session->tls_wrap.work,
+                          session->tls_wrap.tls_crypt_v2_wkc))
+            {
+                msg(D_TLS_ERRORS, "Could not append tls-crypt-v2 client key");
+                buf->len = 0;
+                return;
+            }
+        }
+
+        /* Don't change the original data in buf, it's used by the reliability
+         * layer to resend on failure. */
+        *buf = session->tls_wrap.work;
+    }
+    *to_link_addr = &ks->remote_addr;
+}
+
+bool
+read_control_auth(struct buffer *buf,
+                  struct tls_wrap_ctx *ctx,
+                  const struct link_socket_actual *from,
+                  const struct tls_options *opt)
+{
+    struct gc_arena gc = gc_new();
+    bool ret = false;
+
+    const uint8_t opcode = *(BPTR(buf)) >> P_OPCODE_SHIFT;
+    if (opcode == P_CONTROL_HARD_RESET_CLIENT_V3
+        && !tls_crypt_v2_extract_client_key(buf, ctx, opt))
+    {
+        msg(D_TLS_ERRORS,
+            "TLS Error: can not extract tls-crypt-v2 client key from %s",
+            print_link_socket_actual(from, &gc));
+        goto cleanup;
+    }
+
+    if (ctx->mode == TLS_WRAP_AUTH)
+    {
+        struct buffer null = clear_buf();
+
+        /* move the hmac record to the front of the packet */
+        if (!swap_hmac(buf, &ctx->opt, true))
+        {
+            msg(D_TLS_ERRORS,
+                "TLS Error: cannot locate HMAC in incoming packet from %s",
+                print_link_socket_actual(from, &gc));
+            gc_free(&gc);
+            return false;
+        }
+
+        /* authenticate only (no decrypt) and remove the hmac record
+         * from the head of the buffer */
+        openvpn_decrypt(buf, null, &ctx->opt, NULL, BPTR(buf));
+        if (!buf->len)
+        {
+            msg(D_TLS_ERRORS,
+                "TLS Error: incoming packet authentication failed from %s",
+                print_link_socket_actual(from, &gc));
+            goto cleanup;
+        }
+
+    }
+    else if (ctx->mode == TLS_WRAP_CRYPT)
+    {
+        struct buffer tmp = alloc_buf_gc(buf_forward_capacity_total(buf), &gc);
+        if (!tls_crypt_unwrap(buf, &tmp, &ctx->opt))
+        {
+            msg(D_TLS_ERRORS, "TLS Error: tls-crypt unwrapping failed from %s",
+                print_link_socket_actual(from, &gc));
+            goto cleanup;
+        }
+        ASSERT(buf_init(buf, buf->offset));
+        ASSERT(buf_copy(buf, &tmp));
+        buf_clear(&tmp);
+    }
+    else if (ctx->tls_crypt_v2_server_key.cipher)
+    {
+        /* If tls-crypt-v2 is enabled, require *some* wrapping */
+        msg(D_TLS_ERRORS, "TLS Error: could not determine wrapping from %s",
+            print_link_socket_actual(from, &gc));
+        /* TODO Do we want to support using tls-crypt-v2 and no control channel
+         * wrapping at all simultaneously?  That would allow server admins to
+         * upgrade clients one-by-one without running a second instance, but we
+         * should not enable it by default because it breaks DoS-protection.
+         * So, add something like --tls-crypt-v2-allow-insecure-fallback ? */
+        goto cleanup;
+    }
+
+    if (ctx->mode == TLS_WRAP_NONE || ctx->mode == TLS_WRAP_AUTH)
+    {
+        /* advance buffer pointer past opcode & session_id since our caller
+         * already read it */
+        buf_advance(buf, SID_SIZE + 1);
+    }
+
+    ret = true;
+cleanup:
+    gc_free(&gc);
+    return ret;
+}
+
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
+/*
+ * This function is similar to tls_pre_decrypt, except it is called
+ * when we are in server mode and receive an initial incoming
+ * packet.  Note that we don't modify
+ * any state in our parameter objects.  The purpose is solely to
+ * determine whether we should generate a client instance
+ * object, in which case true is returned.
+ *
+ * This function is essentially the first-line HMAC firewall
+ * on the UDP port listener in --mode server mode.
+ */
+enum first_packet_verdict
+tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
+                     struct tls_pre_decrypt_state *state,
+                     const struct link_socket_actual *from,
+                     const struct buffer *buf)
+{
+    struct gc_arena gc = gc_new();
+    /* A packet needs to have at least an opcode and session id */
+    if (buf->len < (1 + SID_SIZE))
+    {
+        dmsg(D_TLS_STATE_ERRORS,
+             "TLS State Error: Too short packet (length  %d) received from %s",
+             buf->len, print_link_socket_actual(from, &gc));
+        goto error;
+    }
+
+    /* get opcode and key ID */
+    uint8_t pkt_firstbyte = *BPTR(buf);
+    int op = pkt_firstbyte >> P_OPCODE_SHIFT;
+    int key_id = pkt_firstbyte & P_KEY_ID_MASK;
+
+    /* this packet is from an as-yet untrusted source, so
+     * scrutinize carefully */
+
+    /* Allow only the reset packet or the first packet of the actual handshake. */
+    if (op != P_CONTROL_HARD_RESET_CLIENT_V2
+        && op != P_CONTROL_HARD_RESET_CLIENT_V3
+        && op != P_CONTROL_V1)
+    {
+        /*
+         * This can occur due to bogus data or DoS packets.
+         */
+        dmsg(D_TLS_STATE_ERRORS,
+             "TLS State Error: No TLS state for client %s, opcode=%d",
+             print_link_socket_actual(from, &gc),
+             op);
+        goto error;
+    }
+
+    if (key_id != 0)
+    {
+        dmsg(D_TLS_STATE_ERRORS,
+             "TLS State Error: Unknown key ID (%d) received from %s -- 0 was expected",
+             key_id,
+             print_link_socket_actual(from, &gc));
+        goto error;
+    }
+
+    /* read peer session id, we do this at this point since
+     * read_control_auth will skip over it */
+    struct buffer tmp = *buf;
+    buf_advance(&tmp, 1);
+    if (!session_id_read(&state->peer_session_id, &tmp)
+        || !session_id_defined(&state->peer_session_id))
+    {
+        msg(D_TLS_ERRORS,
+            "TLS Error: session-id not found in packet from %s",
+            print_link_socket_actual(from, &gc));
+        goto error;
+    }
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
+    if (!status)
+    {
+        goto error;
+    }
+
+    /*
+     * At this point, if --tls-auth is being used, we know that
+     * the packet has passed the HMAC test, but we don't know if
+     * it is a replay yet.  We will attempt to defeat replays
+     * by not advancing to the S_START state until we
+     * receive an ACK from our first reply to the client
+     * that includes an HMAC of our randomly generated 64 bit
+     * session ID.
+     *
+     * On the other hand if --tls-auth is not being used, we
+     * will proceed to begin the TLS authentication
+     * handshake with only cursory integrity checks having
+     * been performed, since we will be leaving the task
+     * of authentication solely up to TLS.
+     */
+    gc_free(&gc);
+    if (op == P_CONTROL_V1)
+    {
+        return VERDICT_VALID_CONTROL_V1;
+    }
+    else
+    {
+        return VERDICT_VALID_RESET;
+    }
+
+error:
+    tls_clear_error();
+    gc_free(&gc);
+    return VERDICT_INVALID;
+}
\ No newline at end of file
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
new file mode 100644
index 000000000..b7a8d9c35
--- /dev/null
+++ b/src/openvpn/ssl_pkt.h
@@ -0,0 +1,199 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/**
+ * @file SSL control channel wrap/unwrap and decode functions. This file
+ *        (and its .c file) is designed to to be included in units/etc without
+ *        pulling in a lot of dependencies
+ */
+
+#ifndef SSL_PKT_H
+#define SSL_PKT_H
+
+#include "buffer.h"
+#include "ssl_backend.h"
+#include "ssl_common.h"
+
+/* packet opcode (high 5 bits) and key-id (low 3 bits) are combined in one byte */
+#define P_KEY_ID_MASK                  0x07
+#define P_OPCODE_SHIFT                 3
+
+/* packet opcodes -- the V1 is intended to allow protocol changes in the future */
+#define P_CONTROL_HARD_RESET_CLIENT_V1 1     /* initial key from client, forget previous state */
+#define P_CONTROL_HARD_RESET_SERVER_V1 2     /* initial key from server, forget previous state */
+#define P_CONTROL_SOFT_RESET_V1        3     /* new key, graceful transition from old to new key */
+#define P_CONTROL_V1                   4     /* control channel packet (usually TLS ciphertext) */
+#define P_ACK_V1                       5     /* acknowledgement for packets received */
+#define P_DATA_V1                      6     /* data channel packet */
+#define P_DATA_V2                      9     /* data channel packet with peer-id */
+
+/* indicates key_method >= 2 */
+#define P_CONTROL_HARD_RESET_CLIENT_V2 7     /* initial key from client, forget previous state */
+#define P_CONTROL_HARD_RESET_SERVER_V2 8     /* initial key from server, forget previous state */
+
+/* indicates key_method >= 2 and client-specific tls-crypt key */
+#define P_CONTROL_HARD_RESET_CLIENT_V3 10    /* initial key from client, forget previous state */
+
+/* define the range of legal opcodes
+ * Since we do no longer support key-method 1 we consider
+ * the v1 op codes invalid */
+#define P_FIRST_OPCODE                 3
+#define P_LAST_OPCODE                  10
+
+/*
+ * Used in --mode server mode to check tls-auth signature on initial
+ * packets received from new clients.
+ */
+struct tls_auth_standalone
+{
+    struct tls_wrap_ctx tls_wrap;
+    struct frame frame;
+};
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
+/**
+ * Inspect an incoming packet for which no VPN tunnel is active, and
+ * determine whether a new VPN tunnel should be created.
+ * @ingroup data_crypto
+ *
+ * This function receives the initial incoming packet from a client that
+ * wishes to establish a new VPN tunnel, and determines the packet is a
+ * valid initial packet.  It is only used when OpenVPN is running in
+ * server mode.
+ *
+ * The tests performed by this function are whether the packet's opcode is
+ * correct for establishing a new VPN tunnel, whether its key ID is 0, and
+ * whether its size is not too large.  This function also performs the
+ * initial HMAC firewall test, if configured to do so.
+ *
+ * The incoming packet and the local VPN tunnel state are not modified by
+ * this function.  Its sole purpose is to inspect the packet and determine
+ * whether a new VPN tunnel should be created.  If so, that new VPN tunnel
+ * instance will handle processing of the packet.
+ *
+ * This function is only used in the UDP p2mp server code path
+ *
+ * @param tas - The standalone TLS authentication setting structure for
+ *     this process.
+ * @param from - The source address of the packet.
+ * @param buf - A buffer structure containing the incoming packet.
+ *
+ * @return
+ * @li True if the packet is valid and a new VPN tunnel should be created
+ *     for this client.
+ * @li False if the packet is not valid, did not pass the HMAC firewall
+ *     test, or some other error occurred.
+ */
+enum first_packet_verdict
+tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
+                     struct tls_pre_decrypt_state *state,
+                     const struct link_socket_actual *from,
+                     const struct buffer *buf);
+
+/*
+ * Write a control channel authentication record.
+ */
+void
+write_control_auth(struct tls_session *session,
+                   struct key_state *ks,
+                   struct buffer *buf,
+                   struct link_socket_actual **to_link_addr,
+                   int opcode,
+                   int max_ack,
+                   bool prepend_ack);
+
+
+/*
+ * Read a control channel authentication record.
+ */
+bool
+read_control_auth(struct buffer *buf,
+                  struct tls_wrap_ctx *ctx,
+                  const struct link_socket_actual *from,
+                  const struct tls_options *opt);
+
+static inline const char *
+packet_opcode_name(int op)
+{
+    switch (op)
+    {
+        case P_CONTROL_HARD_RESET_CLIENT_V1:
+            return "P_CONTROL_HARD_RESET_CLIENT_V1";
+
+        case P_CONTROL_HARD_RESET_SERVER_V1:
+            return "P_CONTROL_HARD_RESET_SERVER_V1";
+
+        case P_CONTROL_HARD_RESET_CLIENT_V2:
+            return "P_CONTROL_HARD_RESET_CLIENT_V2";
+
+        case P_CONTROL_HARD_RESET_SERVER_V2:
+            return "P_CONTROL_HARD_RESET_SERVER_V2";
+
+        case P_CONTROL_HARD_RESET_CLIENT_V3:
+            return "P_CONTROL_HARD_RESET_CLIENT_V3";
+
+        case P_CONTROL_SOFT_RESET_V1:
+            return "P_CONTROL_SOFT_RESET_V1";
+
+        case P_CONTROL_V1:
+            return "P_CONTROL_V1";
+
+        case P_ACK_V1:
+            return "P_ACK_V1";
+
+        case P_DATA_V1:
+            return "P_DATA_V1";
+
+        case P_DATA_V2:
+            return "P_DATA_V2";
+
+        default:
+            return "P_???";
+    }
+}
+#endif /* ifndef SSL_PKT_H */
-- 
2.32.0 (Apple Git-132)


