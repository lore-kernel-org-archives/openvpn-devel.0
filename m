From: Gert Doering <gert@...1296...>
Date: Fri, 27 Dec 2024 12:11:33 +0100
Message-ID: <20241227111133.5893-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.I4a981c5a70717e2276d89bf83a06c7fdbe6712d7@...2715...>
References: <gerrit.1731290343000.I4a981c5a70717e2276d89bf83a06c7fdbe6712d7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] Change API of init_key_ctx to use struct
 key_parameters
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

This introduces a new structure key_parameters. The reason is that the
current struct serves both as an internal struct as well as an
on-wire/in-file format. Separate these two different usages to allow
extending the struct.

Change-Id: I4a981c5a70717e2276d89bf83a06c7fdbe6712d7
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/801
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 192c7c2..3cf55e8 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -152,7 +152,10 @@
     {
         msg(M_FATAL, "ERROR: not enough data in auth-token secret");
     }
-    init_key_ctx(key_ctx, &key, &kt, false, "auth-token secret");
+
+    struct key_parameters key_params;
+    key_parameters_from_key(&key_params, &key);
+    init_key_ctx(key_ctx, &key_params, &kt, false, "auth-token secret");
 
     free_buf(&server_secret_key);
 }
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index da503b3..df38cdd 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -892,17 +892,18 @@
 }
 
 /**
- * Update the implicit IV for a key_ctx_bi based on TLS session ids and cipher
+ * Update the implicit IV for a key_ctx based on TLS session ids and cipher
  * used.
  *
- * Note that the implicit IV is based on the HMAC key, but only in AEAD modes
- * where the HMAC key is not used for an actual HMAC.
+ * Note that the implicit IV is based on the HMAC key of the \c key parameter,
+ * but only in AEAD modes where the HMAC key is not used for an actual HMAC.
  *
  * @param ctx                   Encrypt/decrypt key context
- * @param key                   key, hmac part used to calculate implicit IV
+ * @param key                   key parameters holding the key and hmac/
+ *                              implicit iv used to calculate implicit IV
  */
 static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, const struct key *key)
+key_ctx_update_implicit_iv(struct key_ctx *ctx, const struct key_parameters *key)
 {
     /* Only use implicit IV in AEAD cipher mode, where HMAC key is not used */
     if (cipher_ctx_mode_aead(ctx->cipher))
@@ -912,6 +913,7 @@
         impl_iv_len = cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_id_type);
         ASSERT(impl_iv_len + sizeof(packet_id_type) <= OPENVPN_MAX_IV_LENGTH);
         ASSERT(impl_iv_len <= MAX_HMAC_KEY_LENGTH);
+        ASSERT(impl_iv_len <= key->hmac_size);
         CLEAR(ctx->implicit_iv);
         /* The first bytes of the IV are filled with the packet id */
         memcpy(ctx->implicit_iv + sizeof(packet_id_type), key->hmac, impl_iv_len);
@@ -920,7 +922,7 @@
 
 /* given a key and key_type, build a key_ctx */
 void
-init_key_ctx(struct key_ctx *ctx, const struct key *key,
+init_key_ctx(struct key_ctx *ctx, const struct key_parameters *key,
              const struct key_type *kt, int enc,
              const char *prefix)
 {
@@ -928,7 +930,7 @@
     CLEAR(*ctx);
     if (cipher_defined(kt->cipher))
     {
-
+        ASSERT(key->cipher_size >= cipher_kt_key_size(kt->cipher));
         ctx->cipher = cipher_ctx_new();
         cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher, enc);
 
@@ -943,8 +945,10 @@
              cipher_kt_iv_size(kt->cipher));
         warn_insecure_key_type(ciphername);
     }
+
     if (md_defined(kt->digest))
     {
+        ASSERT(key->hmac_size >= md_kt_size(kt->digest));
         ctx->hmac = hmac_ctx_new();
         hmac_ctx_init(ctx->hmac, key->hmac, kt->digest);
 
@@ -965,41 +969,43 @@
 }
 
 void
-init_key_bi_ctx_send(struct key_ctx *ctx, const struct key2 *key2,
-                     int key_direction, const struct key_type *kt, const char *name)
+init_key_bi_ctx_send(struct key_ctx *ctx, const struct key_parameters *key_params,
+                     const struct key_type *kt, const char *name)
 {
     char log_prefix[128] = { 0 };
-    struct key_direction_state kds;
-
-    key_direction_state_init(&kds, key_direction);
 
     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
-    init_key_ctx(ctx, &key2->keys[kds.out_key], kt,
-                 OPENVPN_OP_ENCRYPT, log_prefix);
-    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.out_key]);
+    init_key_ctx(ctx, key_params, kt, OPENVPN_OP_ENCRYPT, log_prefix);
+    key_ctx_update_implicit_iv(ctx, key_params);
 }
 
 void
-init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key2 *key2,
-                     int key_direction, const struct key_type *kt, const char *name)
+init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key_parameters *key_params,
+                     const struct key_type *kt, const char *name)
 {
     char log_prefix[128] = { 0 };
-    struct key_direction_state kds;
-
-    key_direction_state_init(&kds, key_direction);
 
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
-    init_key_ctx(ctx, &key2->keys[kds.in_key], kt,
-                 OPENVPN_OP_DECRYPT, log_prefix);
-    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.in_key]);
+    init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, log_prefix);
+    key_ctx_update_implicit_iv(ctx, key_params);
 }
 
 void
 init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,
                 int key_direction, const struct key_type *kt, const char *name)
 {
-    init_key_bi_ctx_send(&ctx->encrypt, key2, key_direction, kt, name);
-    init_key_bi_ctx_recv(&ctx->decrypt, key2, key_direction, kt, name);
+    struct key_direction_state kds;
+
+    key_direction_state_init(&kds, key_direction);
+
+    struct key_parameters send_key;
+    struct key_parameters recv_key;
+
+    key_parameters_from_key(&send_key, &key2->keys[kds.out_key]);
+    key_parameters_from_key(&recv_key, &key2->keys[kds.in_key]);
+
+    init_key_bi_ctx_send(&ctx->encrypt, &send_key, kt, name);
+    init_key_bi_ctx_recv(&ctx->decrypt, &recv_key, kt, name);
     ctx->initialized = true;
 }
 
@@ -1116,6 +1122,16 @@
 }
 
 void
+key_parameters_from_key(struct key_parameters *key_params, const struct key *key)
+{
+    CLEAR(*key_params);
+    memcpy(key_params->cipher, key->cipher, MAX_CIPHER_KEY_LENGTH);
+    key_params->cipher_size = MAX_CIPHER_KEY_LENGTH;
+    memcpy(key_params->hmac, key->hmac, MAX_HMAC_KEY_LENGTH);
+    key_params->hmac_size = MAX_HMAC_KEY_LENGTH;
+}
+
+void
 test_crypto(struct crypto_options *co, struct frame *frame)
 {
     int i, j;
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index b3612fb..d765737 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -144,7 +144,8 @@
 
 /**
  * Container for unidirectional cipher and HMAC %key material.
- * @ingroup control_processor
+ * @ingroup control_processor. This is used as a wire format/file format
+ * key, so it cannot be changed to add fields or change the length of fields
  */
 struct key
 {
@@ -154,6 +155,32 @@
     /**< %Key material for HMAC operations. */
 };
 
+/** internal structure similar to struct key that holds key information
+ * but is not represented on wire and can be changed/extended
+ */
+struct key_parameters {
+    /** %Key material for cipher operations. */
+    uint8_t cipher[MAX_CIPHER_KEY_LENGTH];
+
+    /** Number of bytes set in the cipher key material */
+    int cipher_size;
+
+    /** %Key material for HMAC operations. */
+    uint8_t hmac[MAX_HMAC_KEY_LENGTH];
+
+    /** Number of bytes set in the HMac key material */
+    int hmac_size;
+};
+
+/**
+ * Converts a struct key representation into a struct key_parameters
+ * representation.
+ *
+ * @param key_params    destination for the converted struct
+ * @param key           source of the conversion
+ */
+void
+key_parameters_from_key(struct key_parameters *key_params, const struct key *key);
 
 /**
  * Container for one set of cipher and/or HMAC contexts.
@@ -347,19 +374,17 @@
  * Key context functions
  */
 
-void init_key_ctx(struct key_ctx *ctx, const struct key *key,
+void init_key_ctx(struct key_ctx *ctx, const struct key_parameters *key,
                   const struct key_type *kt, int enc,
                   const char *prefix);
 
 void
-init_key_bi_ctx_send(struct key_ctx *ctx, const struct key2 *key2,
-                     int key_direction, const struct key_type *kt,
-                     const char *name);
+init_key_bi_ctx_send(struct key_ctx *ctx, const struct key_parameters *key,
+                     const struct key_type *kt, const char *name);
 
 void
-init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key2 *key2,
-                     int key_direction, const struct key_type *kt,
-                     const char *name);
+init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key_parameters *key,
+                     const struct key_type *kt, const char *name);
 
 void free_key_ctx(struct key_ctx *ctx);
 
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index b8894db..76f06bc 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -377,7 +377,11 @@
     {
         msg(M_FATAL, "ERROR: --tls-crypt-v2 not supported");
     }
-    init_key_ctx(key_ctx, &srv_key, &kt, encrypt, "tls-crypt-v2 server key");
+    struct key_parameters srv_key_params;
+
+    key_parameters_from_key(&srv_key_params, &srv_key);
+
+    init_key_ctx(key_ctx, &srv_key_params, &kt, encrypt, "tls-crypt-v2 server key");
     secure_memzero(&srv_key, sizeof(srv_key));
 }
 
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 8a0c16a..be3b2b7 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -87,7 +87,8 @@
     struct test_context *ctx = calloc(1, sizeof(*ctx));
     *state = ctx;
 
-    struct key key = { 0 };
+    struct key_parameters key = { 0 };
+    key.hmac_size = MAX_HMAC_KEY_LENGTH;     /* 64 byte of 0 */
 
     ctx->kt = auth_token_kt();
     if (!ctx->kt.digest)
@@ -148,15 +149,17 @@
                      AUTH_TOKEN_HMAC_OK);
 
     /* Change auth-token key */
-    struct key key;
-    memset(&key, '1', sizeof(key));
+    struct key_parameters key;
+    memset(key.hmac, '1', sizeof(key.hmac));
+    key.hmac_size = MAX_HMAC_KEY_LENGTH;
+
     free_key_ctx(&ctx->multi.opt.auth_token_key);
     init_key_ctx(&ctx->multi.opt.auth_token_key, &key, &ctx->kt, false, "TEST");
 
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session), 0);
 
     /* Load original test key again */
-    memset(&key, 0, sizeof(key));
+    memset(&key.hmac, 0, sizeof(key.hmac));
     free_key_ctx(&ctx->multi.opt.auth_token_key);
     init_key_ctx(&ctx->multi.opt.auth_token_key, &key, &ctx->kt, false, "TEST");
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 4f12f88..94cd0ee 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -157,7 +157,8 @@
     struct test_tls_crypt_context *ctx = calloc(1, sizeof(*ctx));
     *state = ctx;
 
-    struct key key = { 0 };
+    struct key_parameters key = { .cipher = { 0 }, .hmac = { 0 },
+                                  .hmac_size = MAX_HMAC_KEY_LENGTH, .cipher_size = MAX_CIPHER_KEY_LENGTH };
 
     ctx->kt = tls_crypt_kt();
     if (!ctx->kt.cipher || !ctx->kt.digest)
@@ -367,7 +368,8 @@
     skip_if_tls_crypt_not_supported(ctx);
 
     /* Change decrypt key */
-    struct key key = { { 1 } };
+    struct key_parameters key = { .cipher = { 1 }, .hmac = { 1 },
+                                  .cipher_size = MAX_CIPHER_KEY_LENGTH, .hmac_size = MAX_HMAC_KEY_LENGTH };
     free_key_ctx(&ctx->co.key_ctx_bi.decrypt);
     init_key_ctx(&ctx->co.key_ctx_bi.decrypt, &key, &ctx->kt, false, "TEST");
 

