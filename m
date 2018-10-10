From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 10 Oct 2018 09:55:09 +0200
Message-ID: <1539158110-9503-5-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6 6/7] tls-crypt-v2: implement tls-crypt-v2
 handshake
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

This makes clients send-and-use, and servers receive-unwrap-and-use
tls-crypt-v2 client keys, which completes the on-the-wire work.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v3: include length in WKc, rebase on curent master / v3 patch set
v4: resolve merge conflict (fixes memory leak)
v5: rebase on v5 patch set
v6: rebase on v6 patch set

 src/openvpn/init.c                        | 39 ++++++++++++++-
 src/openvpn/openvpn.h                     |  2 +
 src/openvpn/ssl.c                         | 79 ++++++++++++++++++++++++-------
 src/openvpn/ssl_common.h                  |  6 +++
 src/openvpn/tls_crypt.c                   | 57 ++++++++++++++++++++++
 src/openvpn/tls_crypt.h                   | 14 ++++++
 tests/unit_tests/openvpn/test_tls_crypt.c |  6 +++
 7 files changed, 186 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ade1035..c2e33ee 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2463,6 +2463,7 @@ key_schedule_free(struct key_schedule *ks, bool free_ssl_ctx)
     if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
     {
         tls_ctx_free(&ks->ssl_ctx);
+        free_key_ctx(&ks->tls_crypt_v2_server_key);
     }
     CLEAR(*ks);
 }
@@ -2646,6 +2647,24 @@ do_init_crypto_tls_c1(struct context *c)
         /* initialize tls-auth/crypt key */
         do_init_tls_wrap_key(c);
 
+        /* tls-crypt with client-specific keys (--tls-crypt-v2) */
+        if (options->tls_crypt_v2_file)
+        {
+            if (options->tls_server)
+            {
+                tls_crypt_v2_init_server_key(&c->c1.ks.tls_crypt_v2_server_key,
+                                             true, options->tls_crypt_v2_file,
+                                             options->tls_crypt_v2_inline);
+            }
+            else
+            {
+                tls_crypt_v2_init_client_key(&c->c1.ks.tls_wrap_key,
+                                             &c->c1.ks.tls_crypt_v2_wkc,
+                                             options->tls_crypt_v2_file,
+                                             options->tls_crypt_v2_inline);
+            }
+        }
+
 #if 0 /* was: #if ENABLE_INLINE_FILES --  Note that enabling this code will break restarts */
         if (options->priv_key_file_inline)
         {
@@ -2862,13 +2881,28 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     }
 
     /* TLS handshake encryption (--tls-crypt) */
-    if (options->ce.tls_crypt_file)
+    if (options->ce.tls_crypt_file
+        || (options->ce.tls_crypt_v2_file && options->tls_client))
     {
         to.tls_wrap.mode = TLS_WRAP_CRYPT;
         to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
         to.tls_wrap.opt.pid_persist = &c->c1.pid_persist;
         to.tls_wrap.opt.flags |= CO_PACKET_ID_LONG_FORM;
         tls_crypt_adjust_frame_parameters(&to.frame);
+
+        if (options->tls_crypt_v2_file)
+        {
+            to.tls_wrap.tls_crypt_v2_wkc = &c->c1.ks.tls_crypt_v2_wkc;
+        }
+    }
+
+    if (options->tls_crypt_v2_file)
+    {
+        to.tls_crypt_v2 = true;
+        if (options->tls_server)
+        {
+            to.tls_wrap.tls_crypt_v2_server_key = c->c1.ks.tls_crypt_v2_server_key;
+        }
     }
 
     /* If we are running over TCP, allow for
@@ -3472,6 +3506,8 @@ do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
      */
     free_key_ctx_bi(&c->c1.ks.tls_wrap_key);
     CLEAR(c->c1.ks.tls_wrap_key);
+    buf_clear(&c->c1.ks.tls_crypt_v2_wkc);
+    free_buf(&c->c1.ks.tls_crypt_v2_wkc);
 
     if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_key))
     {
@@ -4407,6 +4443,7 @@ inherit_context_child(struct context *dest,
     dest->c1.ks.ssl_ctx = src->c1.ks.ssl_ctx;
     dest->c1.ks.tls_wrap_key = src->c1.ks.tls_wrap_key;
     dest->c1.ks.tls_auth_key_type = src->c1.ks.tls_auth_key_type;
+    dest->c1.ks.tls_crypt_v2_server_key = src->c1.ks.tls_crypt_v2_server_key;
     /* inherit pre-NCP ciphers */
     dest->c1.ciphername = src->c1.ciphername;
     dest->c1.authname = src->c1.authname;
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index bc972f2..d11f61d 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -66,6 +66,8 @@ struct key_schedule
     /* optional TLS control channel wrapping */
     struct key_type tls_auth_key_type;
     struct key_ctx_bi tls_wrap_key;
+    struct key_ctx tls_crypt_v2_server_key;
+    struct buffer tls_crypt_v2_wkc;             /**< Wrapped client key */
 };
 
 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 344447d..3d991e1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1047,6 +1047,23 @@ tls_session_user_pass_enabled(struct tls_session *session)
 /** @addtogroup control_processor
  *  @{ */
 
+/** Free the elements of a tls_wrap_ctx structure */
+static void tls_wrap_free(struct tls_wrap_ctx *tls_wrap)
+{
+    if (packet_id_initialized(&tls_wrap->opt.packet_id))
+    {
+        packet_id_free(&tls_wrap->opt.packet_id);
+    }
+
+    if (tls_wrap->cleanup_key_ctx)
+    {
+        free_key_ctx_bi(&tls_wrap->opt.key_ctx_bi);
+    }
+
+    free_buf(&tls_wrap->tls_crypt_v2_metadata);
+    free_buf(&tls_wrap->work);
+}
+
 /** @name Functions for initialization and cleanup of tls_session structures
  *  @{ */
 
@@ -1139,16 +1156,9 @@ tls_session_init(struct tls_multi *multi, struct tls_session *session)
 static void
 tls_session_free(struct tls_session *session, bool clear)
 {
-    int i;
-
-    if (packet_id_initialized(&session->tls_wrap.opt.packet_id))
-    {
-        packet_id_free(&session->tls_wrap.opt.packet_id);
-    }
+    tls_wrap_free(&session->tls_wrap);
 
-    free_buf(&session->tls_wrap.work);
-
-    for (i = 0; i < KS_SIZE; ++i)
+    for (size_t i = 0; i < KS_SIZE; ++i)
     {
         key_state_free(&session->key[i], false);
     }
@@ -1474,6 +1484,8 @@ write_control_auth(struct tls_session *session,
     ASSERT(reliable_ack_write
                (ks->rec_ack, buf, &ks->session_id_remote, max_ack, prepend_ack));
 
+    msg(D_TLS_DEBUG, "%s(): %s", __func__, packet_opcode_name(opcode));
+
     if (session->tls_wrap.mode == TLS_WRAP_AUTH
         || session->tls_wrap.mode == TLS_WRAP_NONE)
     {
@@ -1491,17 +1503,26 @@ write_control_auth(struct tls_session *session,
         ASSERT(buf_init(&session->tls_wrap.work, buf->offset));
         ASSERT(buf_write(&session->tls_wrap.work, &header, sizeof(header)));
         ASSERT(session_id_write(&session->session_id, &session->tls_wrap.work));
-        if (tls_crypt_wrap(buf, &session->tls_wrap.work, &session->tls_wrap.opt))
-        {
-            /* Don't change the original data in buf, it's used by the reliability
-             * layer to resend on failure. */
-            *buf = session->tls_wrap.work;
-        }
-        else
+        if (!tls_crypt_wrap(buf, &session->tls_wrap.work, &session->tls_wrap.opt))
         {
             buf->len = 0;
             return;
         }
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
     }
     *to_link_addr = &ks->remote_addr;
 }
@@ -1517,6 +1538,16 @@ read_control_auth(struct buffer *buf,
     struct gc_arena gc = gc_new();
     bool ret = false;
 
+    const uint8_t opcode = *(BPTR(buf)) >> P_OPCODE_SHIFT;
+    if (opcode == P_CONTROL_HARD_RESET_CLIENT_V3
+        && !tls_crypt_v2_extract_client_key(buf, ctx))
+    {
+        msg (D_TLS_ERRORS,
+             "TLS Error: can not extract tls-crypt-v2 client key from %s",
+             print_link_socket_actual(from, &gc));
+        goto cleanup;
+    }
+
     if (ctx->mode == TLS_WRAP_AUTH)
     {
         struct buffer null = clear_buf();
@@ -1556,6 +1587,18 @@ read_control_auth(struct buffer *buf,
         ASSERT(buf_copy(buf, &tmp));
         buf_clear(&tmp);
     }
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
 
     if (ctx->mode == TLS_WRAP_NONE || ctx->mode == TLS_WRAP_AUTH)
     {
@@ -3856,6 +3899,10 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
             /* HMAC test, if --tls-auth was specified */
             status = read_control_auth(&newbuf, &tls_wrap_tmp, from);
             free_buf(&newbuf);
+            if (tls_wrap_tmp.cleanup_key_ctx)
+            {
+                free_key_ctx_bi(&tls_wrap_tmp.opt.key_ctx_bi);
+            }
             if (!status)
             {
                 goto error;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e3c852a..d744881 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -213,6 +213,12 @@ struct tls_wrap_ctx
     } mode;                     /**< Control channel wrapping mode */
     struct crypto_options opt;  /**< Crypto state */
     struct buffer work;         /**< Work buffer (only for --tls-crypt) */
+    struct key_ctx tls_crypt_v2_server_key;  /**< Decrypts client keys */
+    const struct buffer *tls_crypt_v2_wkc;   /**< Wrapped client key,
+                                                  sent to server */
+    struct buffer tls_crypt_v2_metadata;     /**< Received from client */
+    bool cleanup_key_ctx;                    /**< opt.key_ctx_bi is owned by
+                                                  this context */
 };
 
 /*
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index b61c4ce..26b6d2b 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -33,6 +33,7 @@
 #include "crypto.h"
 #include "platform.h"
 #include "session_id.h"
+#include "ssl.h"
 
 #include "tls_crypt.h"
 
@@ -543,6 +544,62 @@ error_exit:
     return ret;
 }
 
+bool
+tls_crypt_v2_extract_client_key(struct buffer *buf,
+                                struct tls_wrap_ctx *ctx)
+{
+    if (!ctx->tls_crypt_v2_server_key.cipher)
+    {
+        msg(D_TLS_ERRORS,
+             "Client wants tls-crypt-v2, but no server key present.");
+        return false;
+    }
+
+    msg(D_HANDSHAKE, "Control Channel: using tls-crypt-v2 key");
+
+    struct buffer wrapped_client_key = *buf;
+    uint16_t net_len = 0;
+
+    if (BLEN(&wrapped_client_key) < sizeof(net_len))
+    {
+        msg(D_TLS_ERRORS, "failed to read length");
+    }
+    memcpy(&net_len, BEND(&wrapped_client_key) - sizeof(net_len),
+           sizeof(net_len));
+
+    size_t wkc_len = ntohs(net_len);
+    if (!buf_advance(&wrapped_client_key, BLEN(&wrapped_client_key) - wkc_len))
+    {
+        msg(D_TLS_ERRORS, "Can not locate tls-crypt-v2 client key");
+        return false;
+    }
+
+    struct key2 client_key = { 0 };
+    ctx->tls_crypt_v2_metadata = alloc_buf(TLS_CRYPT_V2_MAX_METADATA_LEN);
+    if (!tls_crypt_v2_unwrap_client_key(&client_key,
+                                        &ctx->tls_crypt_v2_metadata,
+                                        wrapped_client_key,
+                                        &ctx->tls_crypt_v2_server_key))
+    {
+        msg(D_TLS_ERRORS, "Can not unwrap tls-crypt-v2 client key");
+        secure_memzero(&client_key, sizeof(client_key));
+        return false;
+    }
+
+    /* Load the decrypted key */
+    ctx->mode = TLS_WRAP_CRYPT;
+    ctx->cleanup_key_ctx = true;
+    ctx->opt.flags |= CO_PACKET_ID_LONG_FORM;
+    memset(&ctx->opt.key_ctx_bi, 0, sizeof(ctx->opt.key_ctx_bi));
+    tls_crypt_v2_load_client_key(&ctx->opt.key_ctx_bi, &client_key, true);
+    secure_memzero(&client_key, sizeof(client_key));
+
+    /* Remove client key from buffer so tls-crypt code can unwrap message */
+    ASSERT(buf_inc_len(buf, -(BLEN(&wrapped_client_key))));
+
+    return true;
+}
+
 void
 tls_crypt_v2_write_server_key_file(const char *filename)
 {
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index f888c79..edf297a 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -84,6 +84,7 @@
 #include "buffer.h"
 #include "crypto.h"
 #include "session_id.h"
+#include "ssl_common.h"
 
 #define TLS_CRYPT_TAG_SIZE (256/8)
 #define TLS_CRYPT_PID_SIZE (sizeof(packet_id_type) + sizeof(net_time_t))
@@ -184,6 +185,19 @@ void tls_crypt_v2_init_client_key(struct key_ctx_bi *key,
                                   const char *key_inline);
 
 /**
+ * Extract a tls-crypt-v2 client key from a P_CONTROL_HARD_RESET_CLIENT_V3
+ * message, and load the key into the supplied tls wrap context.
+ *
+ * @param buf   Buffer containing a received P_CONTROL_HARD_RESET_CLIENT_V3
+ *              message.
+ * @param ctx   tls-wrap context to be initialized with the client key.
+ *
+ * @returns true if a key was successfully extracted.
+ */
+bool tls_crypt_v2_extract_client_key(struct buffer *buf,
+                                     struct tls_wrap_ctx *ctx);
+
+/**
  * Generate a tls-crypt-v2 server key, and write to file.
  *
  * @param filename          Filename of the server key file to create.
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index d499c4e..6cdf4ed 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -346,6 +346,12 @@ tls_crypt_v2_wrap_unwrap_max_metadata(void **state) {
     assert_true(0 == memcmp(ctx->client_key2.keys, unwrapped_client_key2.keys,
                             sizeof(ctx->client_key2.keys)));
     assert_true(buf_equal(&ctx->metadata, &unwrap_metadata));
+
+    struct tls_wrap_ctx wrap_ctx = {
+            .mode = TLS_WRAP_CRYPT,
+            .tls_crypt_v2_server_key = ctx->server_keys.encrypt,
+    };
+    assert_true(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx));
 }
 
 /**
-- 
2.7.4


