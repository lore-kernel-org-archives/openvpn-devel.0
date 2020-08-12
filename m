From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 Aug 2020 10:55:39 +0200
Message-Id: <20200812085539.19620-3-arne@...1227...>
In-Reply-To: <20200812085539.19620-1-arne@...1227...>
References: <20200812085539.19620-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/3] Implement generating data channel keys
 via EKM/RFC 5705
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

OpenVPN currently uses its own (based on TLS 1.0) key derivation
mechansim to generate the 256 bytes key data in key2 struct that
are then used used to generate encryption/hmac/iv vectors. While
this mechanism is still secure, it is not state of the art.

Instead of modernisating our own approach, this commit implements
key derivation using the Keying Material Exporters API introduced
by RFC 5705.

We also use an opportunistic approach of negotiating the use of
EKM (exported key material) through an IV_PROTO flag and prefer
EKM to our own PRF if both client and server support it. The
use of EKM is pushed to the client as part of NCP as
key-derivation tls-ekm.

We still exchange the random data (112 bytes from client to server
and 64 byte from server to client) that for the OpenVPN PRF but
do not use it. Removing that exchange would break the handshake
and make a key-method 3 or similar necessary.

Side note: this commit breaks the (not yet merged) WolfSSL support as it
claims to support EKM in the OpenSSL compat API but always returns an error
if you try to use it.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/doxygen/doc_key_generation.h | 15 +++++++--
 src/openvpn/crypto.h             |  4 +++
 src/openvpn/init.c               |  1 +
 src/openvpn/multi.c              |  4 +++
 src/openvpn/options.c            | 14 +++++++++
 src/openvpn/options.h            |  3 ++
 src/openvpn/push.c               |  5 ++-
 src/openvpn/ssl.c                | 49 ++++++++++++++++++++++++++++--
 src/openvpn/ssl.h                |  2 ++
 src/openvpn/ssl_backend.h        |  8 +++--
 src/openvpn/ssl_mbedtls.c        | 52 ++++++++++++++++++++++----------
 src/openvpn/ssl_mbedtls.h        |  3 +-
 src/openvpn/ssl_openssl.c        |  6 ++++
 13 files changed, 141 insertions(+), 25 deletions(-)

diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
index 4bb9c708..bbd6c0c5 100644
--- a/doc/doxygen/doc_key_generation.h
+++ b/doc/doxygen/doc_key_generation.h
@@ -58,6 +58,12 @@
  *
  * @subsection key_generation_method_2 Key method 2
  *
+ * There are two methods for generating key data when using key method 2
+ * the first is OpenVPN's traditional approach that exchanges random
+ * data and uses a PRF and the other is using the RFC5705 keying material
+ * exporter to generate the key material. For both methods the random
+ * data is exchange but only used in the traditional method.
+ *
  * -# The client generates random material in the following amounts:
  *    - Pre-master secret: 48 bytes
  *    - Client's PRF seed for master secret: 32 bytes
@@ -73,8 +79,13 @@
  *    server's random material.
  *
  * %Key method 2 %key expansion is performed by the \c
- * generate_key_expansion() function.  Please refer to its source code for
- * details of the %key expansion process.
+ * generate_key_expansion_oepnvpn_prf() function.  Please refer to its source
+ * code for details of the %key expansion process.
+ *
+ * When the client sends the IV_PROTO_TLS_KEY_EXPORT and the server replies
+ * with `key-derivation tls-ekm` RFC5705 key material exporter with the label
+ * EXPORTER-OpenVPN-datakeys is used for the key data.
+ *
  *
  * @subsection key_generation_random Source of random material
  *
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 999f643e..ec935ca5 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -254,6 +254,10 @@ struct crypto_options
 #define CO_MUTE_REPLAY_WARNINGS (1<<2)
     /**< Bit-flag indicating not to display
      *   replay warnings. */
+#define CO_USE_TLS_KEY_MATERIAL_EXPORT  (1<<3)
+    /**< Bit-flag indicating that key derivation
+     * is done using TLS keying material export [RFC5705]
+     */
     unsigned int flags;         /**< Bit-flags determining behavior of
                                  *   security operation functions. */
 };
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index dfa045b0..34a7313e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -676,6 +676,7 @@ restore_ncp_options(struct context *c)
     c->options.ciphername = c->c1.ciphername;
     c->options.authname = c->c1.authname;
     c->options.keysize = c->c1.keysize;
+    c->options.data_channel_use_ekm = false;
 }
 
 void
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 13738180..a5862020 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1817,6 +1817,10 @@ multi_client_set_protocol_options(struct context *c)
         c->c2.push_request_received = true;
     }
 
+#ifdef HAVE_EXPORT_KEYING_MATERIAL
+    o->data_channel_use_ekm = (proto & IV_PROTO_TLS_KEY_EXPORT);
+#endif
+
     /* Select cipher if client supports Negotiable Crypto Parameters */
     if (!o->ncp_enabled)
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8bf82c57..90e78a7b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7947,6 +7947,20 @@ add_option(struct options *options,
         }
         options->ncp_ciphers = p[1];
     }
+    else if (streq(p[0], "key-derivation") && p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_NCP)
+#ifdef HAVE_EXPORT_KEYING_MATERIAL
+        if (streq(p[1], "tls-ekm"))
+        {
+            options->data_channel_use_ekm = true;
+        }
+        else
+#endif
+        {
+            msg(msglevel, "Unknown key-derivation method %s", p[1]);
+        }
+    }
     else if (streq(p[0], "ncp-disable") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 877e9396..c730c6a7 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -648,6 +648,9 @@ struct options
     /* Useful when packets sent by openvpn itself are not subject
      * to the routing tables that would move packets into the tunnel. */
     bool allow_recursive_routing;
+
+    /* Use RFC 5705 key export */
+    bool data_channel_use_ekm;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e0d2eeaf..17bba948 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -479,7 +479,10 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
     {
         push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
     }
-
+    if (o->data_channel_use_ekm)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "key-derivation tls-ekm");
+    }
     return true;
 }
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e44017c6..b78362f1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1784,6 +1784,28 @@ init_key_contexts(struct key_ctx_bi *key,
 }
 
 
+static bool
+generate_key_expansion_tls_export(struct tls_session *session, struct key2 *key2)
+{
+    struct key_state *ks = &session->key[KS_PRIMARY];
+    struct gc_arena gc = gc_new();
+    unsigned char *key2data;
+
+    key2data = key_state_export_keying_material(&ks->ks_ssl, session,
+                                                EXPORT_KEY_DATA,
+                                                &gc);
+    if (!key2data)
+    {
+        return false;
+    }
+    memcpy(key2->keys, key2data, sizeof(key2->keys));
+    secure_memzero(key2data, sizeof(key2->keys));
+    key2->n = 2;
+
+    gc_free(&gc);
+    return true;
+}
+
 static struct key2
 generate_key_expansion_oepnvpn_prf(const struct tls_session *session)
 {
@@ -1846,7 +1868,7 @@ generate_key_expansion_oepnvpn_prf(const struct tls_session *session)
  */
 static bool
 generate_key_expansion(struct key_ctx_bi *key,
-                       const struct tls_session *session)
+                       struct tls_session *session)
 {
     bool ret = false;
 
@@ -1859,7 +1881,20 @@ generate_key_expansion(struct key_ctx_bi *key,
 
     bool server = session->opt->server;
 
-    struct key2 key2 = generate_key_expansion_oepnvpn_prf(session);
+    struct key2 key2;
+
+    if (session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT)
+    {
+        if(!generate_key_expansion_tls_export(session, &key2))
+        {
+            msg(D_TLS_ERRORS, "TLS Error: Keying material export failed");
+            goto exit;
+        }
+    }
+    else
+    {
+        key2 = generate_key_expansion_oepnvpn_prf(session);
+    }
 
     key2_print(&key2, &session->opt->key_type,
                "Master Encrypt", "Master Decrypt");
@@ -1988,6 +2023,11 @@ tls_session_update_crypto_params(struct tls_session *session,
         session->opt->crypto_flags |= CO_PACKET_ID_LONG_FORM;
     }
 
+    if (options->data_channel_use_ekm)
+    {
+        session->opt->crypto_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
+    }
+
     /* Update frame parameters: undo worst-case overhead, add actual overhead */
     frame_remove_from_extra_frame(frame, crypto_max_overhead());
     crypto_adjust_frame_parameters(frame, &session->opt->key_type,
@@ -2244,10 +2284,13 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
          * push request, also signal that the client wants
          * to get push-reply messages without without requiring a round
          * trip for a push request message*/
-        if(session->opt->pull)
+        if (session->opt->pull)
         {
             iv_proto |= IV_PROTO_REQUEST_PUSH;
         }
+#ifdef HAVE_EXPORT_KEYING_MATERIAL
+        iv_proto |= IV_PROTO_TLS_KEY_EXPORT;
+#endif
 
         buf_printf(&out, "IV_PROTO=%d\n", iv_proto);
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 005628f6..f00f8abd 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -116,6 +116,8 @@
  * to wait for a push-request to send a push-reply */
 #define IV_PROTO_REQUEST_PUSH   (1<<2)
 
+/** Supports key derivation via TLS key material exporter [RFC5705] */
+#define IV_PROTO_TLS_KEY_EXPORT (1<<3)
 
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 8faaefd5..e08f6e1e 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -390,11 +390,15 @@ void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
                                 const char *crl_file, bool crl_inline);
 
 
-/* defines the different RFC5705 that are used in OpenVPN */
+/* defines the different RFC5705 keys that are used in OpenVPN */
 enum export_key_identifier {
-    EXPORT_KEY_USER
+    EXPORT_KEY_USER,
+    EXPORT_KEY_DATA
 };
 
+#define EXPORT_KEY_DATA_LABEL       "EXPORTER-OpenVPN-datakeys"
+#define EXPORT_KEY_DATA_EKM_SIZE    (2 * (MAX_CIPHER_KEY_LENGTH + MAX_HMAC_KEY_LENGTH))
+
 /**
  * Keying Material Exporters [RFC 5705] allows additional keying material to be
  * derived from existing TLS channel. This exported keying material can then be
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 8ae6ec7b..3721163f 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -208,22 +208,41 @@ mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
     struct key_state_ssl *ks_ssl = &session->key[KS_PRIMARY].ks_ssl;
     unsigned char client_server_random[64];
 
-    ks_ssl->exported_key_material = gc_malloc(session->opt->ekm_size,
-                                              true, NULL);
-
     memcpy(client_server_random, client_random, 32);
     memcpy(client_server_random + 32, server_random, 32);
 
     const size_t ms_len = sizeof(ks_ssl->ctx->session->master);
-    int ret = mbedtls_ssl_tls_prf(tls_prf_type, ms, ms_len,
+
+    int ret;
+    /* Generate user exported key if requested */
+    if (session->opt->ekm_size)
+    {
+
+        ks_ssl->exported_key_material_user = gc_malloc(session->opt->ekm_size,
+                                                       true, NULL);
+        ret = mbedtls_ssl_tls_prf(tls_prf_type, ms, ms_len,
                                   session->opt->ekm_label, client_server_random,
-                                  sizeof(client_server_random), ks_ssl->exported_key_material,
+                                  sizeof(client_server_random),
+                                  ks_ssl->exported_key_material_user,
                                   session->opt->ekm_size);
 
-    if (!mbed_ok(ret))
-    {
-        secure_memzero(ks_ssl->exported_key_material, session->opt->ekm_size);
+        if (!mbed_ok(ret))
+        {
+            secure_memzero(ks_ssl->exported_key_material_user,
+                           session->opt->ekm_size);
+            ks_ssl->exported_key_material_user = NULL;
+        }
     }
+    /* We always generate the data channel key here even if we are not using
+     * it */
+
+    ks_ssl->exported_key_material_data = gc_malloc(EXPORT_KEY_DATA_EKM_SIZE,
+                                                   true, NULL);
+    ret = mbedtls_ssl_tls_prf(tls_prf_type, ms, ms_len,
+                              EXPORT_KEY_DATA_LABEL, client_server_random,
+                              sizeof(client_server_random),
+                              ks_ssl->exported_key_material_data,
+                              EXPORT_KEY_DATA_EKM_SIZE);
 
     secure_memzero(client_server_random, sizeof(client_server_random));
 
@@ -239,9 +258,12 @@ key_state_export_keying_material(struct key_state_ssl *ssl,
 {
     if (key_id == EXPORT_KEY_USER)
     {
-        return ssl->exported_key_material;
+        return ssl->exported_key_material_user;
+    }
+    else if (key_id == EXPORT_KEY_DATA)
+    {
+        return ssl->exported_key_material_data;
     }
-
     return  NULL;
 }
 
@@ -1149,11 +1171,8 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
 
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
     /* Initialize keying material exporter */
-    if (session->opt->ekm_size)
-    {
-        mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
-                                            mbedtls_ssl_export_keys_cb, session);
-    }
+    mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
+                                        mbedtls_ssl_export_keys_cb, session);
 #endif
 
     /* Initialise SSL context */
@@ -1172,7 +1191,8 @@ key_state_ssl_free(struct key_state_ssl *ks_ssl)
 {
     if (ks_ssl)
     {
-        free(ks_ssl->exported_key_material);
+        free(ks_ssl->exported_key_material_user);
+        free(ks_ssl->exported_key_material_data);
 
         if (ks_ssl->ctx)
         {
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 0525134f..d5652350 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -115,7 +115,8 @@ struct key_state_ssl {
     bio_ctx *bio_ctx;
 
     /** Keying material exporter cache (RFC 5705). */
-    uint8_t *exported_key_material;
+    uint8_t *exported_key_material_user;
+    uint8_t *exported_key_material_data;
 
 };
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 1aad4f89..e807f581 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -174,6 +174,12 @@ key_state_export_keying_material(struct key_state_ssl *ssl,
         label_size = session->opt->ekm_label_size;
         ekm_size = session->opt->ekm_size;
     }
+    else if (key_id == EXPORT_KEY_DATA)
+    {
+        label = EXPORT_KEY_DATA_LABEL;
+        label_size = strlen(EXPORT_KEY_DATA_LABEL);
+        ekm_size = EXPORT_KEY_DATA_EKM_SIZE;
+    }
     else
     {
         ASSERT(0);
-- 
2.26.2


