From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Dec 2021 19:07:21 +0100
Message-Id: <20211201180727.2496903-3-arne@...1227...>
In-Reply-To: <20211201180727.2496903-1-arne@...1227...>
References: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/9] Remove cipher_ctx_get_cipher_kt and
 replace with direct context calls
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

We currently have a number of calls that fetch the cipher_kt from a
cipher_ctx to then do a query on the cipher_kt. Directly fetching the
desired property from the context is cleaner and helps for using the
proper APIs with OpenSSL 3.0 and mbed TLS 3.0

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c         | 36 ++++++++---------------
 src/openvpn/crypto_backend.h | 29 ++++++++++++++----
 src/openvpn/crypto_mbedtls.c | 21 +++++++++++--
 src/openvpn/crypto_openssl.c | 57 ++++++++++++++++++++++++++++++++++--
 src/openvpn/openssl_compat.h |  1 +
 src/openvpn/ssl.c            |  8 ++---
 src/openvpn/ssl_ncp.c        | 18 +++++-------
 7 files changed, 119 insertions(+), 51 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 270d83c56..27ed1402c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -68,12 +68,10 @@ openvpn_encrypt_aead(struct buffer *buf, struct buffer work,
     int outlen = 0;
     const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
     uint8_t *mac_out = NULL;
-    const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
     const int mac_len = OPENVPN_AEAD_TAG_LENGTH;
 
     /* IV, packet-ID and implicit IV required for this mode. */
     ASSERT(ctx->cipher);
-    ASSERT(cipher_kt_mode_aead(cipher_kt));
     ASSERT(packet_id_initialized(&opt->packet_id));
 
     gc_init(&gc);
@@ -171,7 +169,6 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
         {
             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] = {0};
             const int iv_size = cipher_ctx_iv_length(ctx->cipher);
-            const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
             int outlen;
 
             /* Reserve space for HMAC */
@@ -182,7 +179,7 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
                 hmac_start = BEND(&work);
             }
 
-            if (cipher_kt_mode_cbc(cipher_kt))
+            if (cipher_ctx_mode_cbc(ctx->cipher))
             {
                 /* generate pseudo-random IV */
                 prng_bytes(iv_buf, iv_size);
@@ -197,7 +194,7 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
                     goto err;
                 }
             }
-            else if (cipher_kt_mode_ofb_cfb(cipher_kt))
+            else if (cipher_ctx_mode_ofb_cfb(ctx->cipher))
             {
                 struct buffer b;
 
@@ -245,7 +242,7 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
             ASSERT(buf_inc_len(&work, outlen));
 
             /* For all CBC mode ciphers, check the last block is complete */
-            ASSERT(cipher_kt_mode(cipher_kt) != OPENVPN_MODE_CBC
+            ASSERT(cipher_ctx_mode(ctx->cipher) != OPENVPN_MODE_CBC
                    || outlen == iv_size);
         }
         else                            /* No Encryption */
@@ -301,10 +298,7 @@ openvpn_encrypt(struct buffer *buf, struct buffer work,
 {
     if (buf->len > 0 && opt)
     {
-        const cipher_kt_t *cipher_kt =
-            cipher_ctx_get_cipher_kt(opt->key_ctx_bi.encrypt.cipher);
-
-        if (cipher_kt_mode_aead(cipher_kt))
+        if (cipher_ctx_mode_aead(opt->key_ctx_bi.encrypt.cipher))
         {
             openvpn_encrypt_aead(buf, work, opt);
         }
@@ -360,7 +354,6 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
     static const char error_prefix[] = "AEAD Decrypt error";
     struct packet_id_net pin = { 0 };
     const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
-    const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
     uint8_t *tag_ptr = NULL;
     int outlen;
     struct gc_arena gc;
@@ -371,7 +364,6 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
     ASSERT(frame);
     ASSERT(buf->len > 0);
     ASSERT(ctx->cipher);
-    ASSERT(cipher_kt_mode_aead(cipher_kt));
 
     dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s",
          format_hex(BPTR(buf), BLEN(buf), 80, &gc));
@@ -537,7 +529,6 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
         if (ctx->cipher)
         {
             const int iv_size = cipher_ctx_iv_length(ctx->cipher);
-            const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] = { 0 };
             int outlen;
 
@@ -589,7 +580,7 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
 
             /* Get packet ID from plaintext buffer or IV, depending on cipher mode */
             {
-                if (cipher_kt_mode_cbc(cipher_kt))
+                if (cipher_ctx_mode_cbc(ctx->cipher))
                 {
                     if (packet_id_initialized(&opt->packet_id))
                     {
@@ -600,7 +591,7 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
                         have_pin = true;
                     }
                 }
-                else if (cipher_kt_mode_ofb_cfb(cipher_kt))
+                else if (cipher_ctx_mode_ofb_cfb(ctx->cipher))
                 {
                     struct buffer b;
 
@@ -660,8 +651,7 @@ openvpn_decrypt(struct buffer *buf, struct buffer work,
 
     if (buf->len > 0 && opt)
     {
-        const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
-        if (cipher_kt_mode_aead(cipher_ctx_get_cipher_kt(ctx->cipher)))
+        if (cipher_ctx_mode_aead(opt->key_ctx_bi.decrypt.cipher))
         {
             ret = openvpn_decrypt_aead(buf, work, opt, frame, ad_start);
         }
@@ -1036,14 +1026,12 @@ test_crypto(struct crypto_options *co, struct frame *frame)
 
     /* init implicit IV */
     {
-        const cipher_kt_t *cipher =
-            cipher_ctx_get_cipher_kt(co->key_ctx_bi.encrypt.cipher);
-
-        if (cipher_kt_mode_aead(cipher))
+        cipher_ctx_t *cipher = co->key_ctx_bi.encrypt.cipher;
+        if (cipher_ctx_mode_aead(cipher))
         {
-            size_t impl_iv_len = cipher_kt_iv_size(cipher) - sizeof(packet_id_type);
-            ASSERT(cipher_kt_iv_size(cipher) <= OPENVPN_MAX_IV_LENGTH);
-            ASSERT(cipher_kt_iv_size(cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
+            size_t impl_iv_len = cipher_ctx_iv_length(cipher) - sizeof(packet_id_type);
+            ASSERT(cipher_ctx_iv_length(cipher) <= OPENVPN_MAX_IV_LENGTH);
+            ASSERT(cipher_ctx_iv_length(cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
 
             /* Generate dummy implicit IV */
             ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 7c1f123e4..925d1db37 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -338,7 +338,7 @@ void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, int key_len,
  * @param ctx           The cipher's context
  *
  * @return              Size of the IV, in bytes, or \c 0 if the cipher does not
- *                      use an IV or ctx was NULL.
+ *                      use an IV.
  */
 int cipher_ctx_iv_length(const cipher_ctx_t *ctx);
 
@@ -371,14 +371,31 @@ int cipher_ctx_block_size(const cipher_ctx_t *ctx);
 int cipher_ctx_mode(const cipher_ctx_t *ctx);
 
 /**
- * Returns the static cipher parameters for this context.
+ * Check if the supplied cipher is a supported CBC mode cipher.
+ *
+ * @param ctx           Cipher's context. May not be NULL.
+ *
+ * @return              true iff the cipher is a CBC mode cipher.
+ */
+bool cipher_ctx_mode_cbc(const cipher_ctx_t *ctx);
+
+/**
+ * Check if the supplied cipher is a supported OFB or CFB mode cipher.
+ *
+ * @param ctx           Cipher's context. May not be NULL.
+ *
+ * @return              true iff the cipher is a OFB or CFB mode cipher.
+ */
+bool cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx);
+
+/**
+ * Check if the supplied cipher is a supported AEAD mode cipher.
  *
- * @param ctx           Cipher's context.
+ * @param ctx           Cipher's context. May not be NULL.
  *
- * @return              Static cipher parameters for the supplied context, or
- *                      NULL if unable to determine cipher parameters.
+ * @return              true iff the cipher is a AEAD mode cipher.
  */
-const cipher_kt_t *cipher_ctx_get_cipher_kt(const cipher_ctx_t *ctx);
+bool cipher_ctx_mode_aead(const cipher_ctx_t *ctx);
 
 /**
  * Resets the given cipher context, setting the IV to the specified value.
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 893a4ab02..566baadde 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -591,10 +591,25 @@ cipher_ctx_mode(const mbedtls_cipher_context_t *ctx)
     return cipher_kt_mode(ctx->cipher_info);
 }
 
-const cipher_kt_t *
-cipher_ctx_get_cipher_kt(const cipher_ctx_t *ctx)
+bool cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
 {
-    return ctx ? ctx->cipher_info : NULL;
+    return ctx && cipher_ctx_mode(ctx) == OPENVPN_MODE_CBC;
+}
+
+
+bool cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
+{
+    return ctx && (cipher_ctx_mode(ctx) == OPENVPN_MODE_OFB
+        || cipher_ctx_mode(ctx) == OPENVPN_MODE_CFB);
+}
+
+bool cipher_ctx_mode_aead(const cipher_ctx_t *ctx)
+{
+    return ctx && (cipher_ctx_mode(ctx) == OPENVPN_MODE_GCM
+#ifdef MBEDTLS_CHACHAPOLY_C
+        || cipher_ctx_mode(ctx) == MBEDTLS_MODE_CHACHAPOLY
+#endif
+    );
 }
 
 int
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 3044ea944..9d6c7c807 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -797,10 +797,61 @@ cipher_ctx_mode(const EVP_CIPHER_CTX *ctx)
     return EVP_CIPHER_CTX_mode(ctx);
 }
 
-const cipher_kt_t *
-cipher_ctx_get_cipher_kt(const cipher_ctx_t *ctx)
+
+bool
+cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
+{
+    if (!ctx)
+    {
+        return false;
+    }
+
+    int flags = EVP_CIPHER_CTX_flags(ctx);
+    int mode = EVP_CIPHER_CTX_mode(ctx);
+
+    return mode == EVP_CIPH_CBC_MODE
+        /* Exclude AEAD cipher modes, they require a different API */
+#ifdef EVP_CIPH_FLAG_CTS
+        && !(flags & EVP_CIPH_FLAG_CTS)
+#endif
+        && !(flags & EVP_CIPH_FLAG_AEAD_CIPHER);
+}
+
+bool
+cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
+{
+    if (!ctx)
+    {
+        return false;
+    }
+
+    int mode = EVP_CIPHER_CTX_get_mode(ctx);
+
+    return (mode == EVP_CIPH_OFB_MODE || mode == EVP_CIPH_CFB_MODE)
+        /* Exclude AEAD cipher modes, they require a different API */
+        && !(EVP_CIPHER_CTX_flags(ctx) & EVP_CIPH_FLAG_AEAD_CIPHER);
+}
+
+bool
+cipher_ctx_mode_aead(const cipher_ctx_t *ctx)
 {
-    return ctx ? EVP_CIPHER_CTX_cipher(ctx) : NULL;
+    if (ctx)
+    {
+        int flags = EVP_CIPHER_CTX_flags(ctx);
+        if (flags & EVP_CIPH_FLAG_AEAD_CIPHER)
+        {
+            return true;
+        }
+
+#if defined(NID_chacha20_poly1305) && OPENSSL_VERSION_NUMBER < 0x30000000L
+        if (EVP_CIPHER_CTX_nid(ctx) == NID_chacha20_poly1305)
+        {
+            return true;
+        }
+#endif
+    }
+
+    return false;
 }
 
 
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index cbd7fd1d2..54fd5d60f 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -757,6 +757,7 @@ int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
 
 #if OPENSSL_VERSION_NUMBER < 0x30000000L
 #define EVP_MD_get0_name EVP_MD_name
+#define EVP_CIPHER_CTX_get_mode EVP_CIPHER_CTX_mode
 
 /* Mimics the functions but only when the default context without
  * options is chosen */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ad3e08274..3de229e39 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1803,14 +1803,12 @@ exit:
 static void
 key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)
 {
-    const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
-
     /* Only use implicit IV in AEAD cipher mode, where HMAC key is not used */
-    if (cipher_kt_mode_aead(cipher_kt))
+    if (cipher_ctx_mode_aead(ctx->cipher))
     {
         size_t impl_iv_len = 0;
-        ASSERT(cipher_kt_iv_size(cipher_kt) >= OPENVPN_AEAD_MIN_IV_LEN);
-        impl_iv_len = cipher_kt_iv_size(cipher_kt) - sizeof(packet_id_type);
+        ASSERT(cipher_ctx_iv_length(ctx->cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
+        impl_iv_len = cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_id_type);
         ASSERT(impl_iv_len <= OPENVPN_MAX_IV_LENGTH);
         ASSERT(impl_iv_len <= key_len);
         memcpy(ctx->implicit_iv, key, impl_iv_len);
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index b0b248aae..e5cfbd180 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -466,19 +466,17 @@ p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
     if (!common_cipher)
     {
         struct buffer out = alloc_buf_gc(128, &gc);
-        struct key_state *ks = get_key_scan(multi, KS_PRIMARY);
+        const cipher_kt_t *cipher = session->opt->key_type.cipher;
 
-        const cipher_ctx_t *ctx = ks->crypto_options.key_ctx_bi.encrypt.cipher;
-        const cipher_kt_t *cipher = cipher_ctx_get_cipher_kt(ctx);
-        const char *fallback_name = cipher_kt_name(cipher);
+        /* at this point we do not really know if our fallback is
+         * not enabled or if we use 'none' cipher as fallback, so
+         * keep this ambiguity here and print fallback-cipher: none
+         */
 
-        if (!cipher)
+        const char *fallback_name = "none";
+        if (cipher)
         {
-            /* at this point we do not really know if our fallback is
-             * not enabled or if we use 'none' cipher as fallback, so
-             * keep this ambiguity here and print fallback-cipher: none
-             */
-            fallback_name = "none";
+            fallback_name = cipher_kt_name(cipher);
         }
 
         buf_printf(&out, "(not negotiated, fallback-cipher: %s)", fallback_name);
-- 
2.33.0


