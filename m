From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Dec 2021 19:07:23 +0100
Message-Id: <20211201180727.2496903-5-arne@...1227...>
In-Reply-To: <20211201180727.2496903-1-arne@...1227...>
References: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/9] Remove key_type->cipher_length field
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

This field is only set once to cipher_kt_key_size(kt.cipher) at the same
time that kt.cipher is set and therefore completely redundant.

This field was useful in the past when we supported cipher with variable
key length as this field would then store the key length that we would use.
Now that we do not support this anymore, we can simplify the code.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c         | 35 +++++++++++++++--------------------
 src/openvpn/crypto.h         |  1 -
 src/openvpn/crypto_backend.h |  3 +--
 src/openvpn/crypto_mbedtls.c |  3 ++-
 src/openvpn/crypto_openssl.c |  4 ++--
 src/openvpn/options.c        |  2 +-
 src/openvpn/tls_crypt.c      |  1 -
 7 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 0d577624e..c85a75319 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -744,8 +744,6 @@ init_key_type(struct key_type *kt, const char *ciphername,
             msg(M_FATAL, "Cipher %s not supported", ciphername);
         }
 
-        kt->cipher_length = cipher_kt_key_size(kt->cipher);
-
         /* check legal cipher mode */
         aead_cipher = cipher_kt_mode_aead(kt->cipher);
         if (!(cipher_kt_mode_cbc(kt->cipher)
@@ -811,21 +809,20 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
 {
     struct gc_arena gc = gc_new();
     CLEAR(*ctx);
-    if (kt->cipher && kt->cipher_length > 0)
+    if (kt->cipher)
     {
 
         ctx->cipher = cipher_ctx_new();
-        cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher_length,
-                        kt->cipher, enc);
+        cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher, enc);
 
         const char *ciphername = cipher_kt_name(kt->cipher);
         msg(D_HANDSHAKE, "%s: Cipher '%s' initialized with %d bit key",
             prefix,
             ciphername,
-            kt->cipher_length *8);
+            cipher_kt_key_size(kt->cipher));
 
         dmsg(D_SHOW_KEYS, "%s: CIPHER KEY: %s", prefix,
-             format_hex(key->cipher, kt->cipher_length, 0, &gc));
+             format_hex(key->cipher, cipher_kt_key_size(kt->cipher), 0, &gc));
         dmsg(D_CRYPTO_DEBUG, "%s: CIPHER block_size=%d iv_size=%d",
              prefix, cipher_kt_block_size(kt->cipher),
              cipher_kt_iv_size(kt->cipher));
@@ -899,8 +896,8 @@ free_key_ctx_bi(struct key_ctx_bi *ctx)
 static bool
 key_is_zero(struct key *key, const struct key_type *kt)
 {
-    int i;
-    for (i = 0; i < kt->cipher_length; ++i)
+    int cipher_length = cipher_kt_key_size(kt->cipher);
+    for (int i = 0; i < cipher_length; ++i)
     {
         if (key->cipher[i])
         {
@@ -959,10 +956,7 @@ generate_key_random(struct key *key, const struct key_type *kt)
         CLEAR(*key);
         if (kt)
         {
-            if (kt->cipher && kt->cipher_length > 0 && kt->cipher_length <= cipher_len)
-            {
-                cipher_len = kt->cipher_length;
-            }
+            cipher_len = cipher_kt_key_size(kt->cipher);
 
             if (kt->digest && kt->hmac_length > 0 && kt->hmac_length <= hmac_len)
             {
@@ -996,13 +990,13 @@ key2_print(const struct key2 *k,
     ASSERT(k->n == 2);
     dmsg(D_SHOW_KEY_SOURCE, "%s (cipher): %s",
          prefix0,
-         format_hex(k->keys[0].cipher, kt->cipher_length, 0, &gc));
+         format_hex(k->keys[0].cipher, cipher_kt_key_size(kt->cipher), 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "%s (hmac): %s",
          prefix0,
          format_hex(k->keys[0].hmac, kt->hmac_length, 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "%s (cipher): %s",
          prefix1,
-         format_hex(k->keys[1].cipher, kt->cipher_length, 0, &gc));
+         format_hex(k->keys[1].cipher, cipher_kt_key_size(kt->cipher), 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "%s (hmac): %s",
          prefix1,
          format_hex(k->keys[1].hmac, kt->hmac_length, 0, &gc));
@@ -1532,10 +1526,11 @@ bool
 write_key(const struct key *key, const struct key_type *kt,
           struct buffer *buf)
 {
-    ASSERT(kt->cipher_length <= MAX_CIPHER_KEY_LENGTH
+    ASSERT(cipher_kt_key_size(kt->cipher) <= MAX_CIPHER_KEY_LENGTH
            && kt->hmac_length <= MAX_HMAC_KEY_LENGTH);
 
-    if (!buf_write(buf, &kt->cipher_length, 1))
+    const uint8_t cipher_length = cipher_kt_key_size(kt->cipher);
+    if (!buf_write(buf, &cipher_length, 1))
     {
         return false;
     }
@@ -1543,7 +1538,7 @@ write_key(const struct key *key, const struct key_type *kt,
     {
         return false;
     }
-    if (!buf_write(buf, key->cipher, kt->cipher_length))
+    if (!buf_write(buf, key->cipher, cipher_kt_key_size(kt->cipher)))
     {
         return false;
     }
@@ -1577,7 +1572,7 @@ read_key(struct key *key, const struct key_type *kt, struct buffer *buf)
         goto read_err;
     }
 
-    if (cipher_length != kt->cipher_length || hmac_length != kt->hmac_length)
+    if (cipher_length != cipher_kt_key_size(kt->cipher) || hmac_length != kt->hmac_length)
     {
         goto key_len_err;
     }
@@ -1600,7 +1595,7 @@ read_err:
 key_len_err:
     msg(D_TLS_ERRORS,
         "TLS Error: key length mismatch, local cipher/hmac %d/%d, remote cipher/hmac %d/%d",
-        kt->cipher_length, kt->hmac_length, cipher_length, hmac_length);
+        cipher_kt_key_size(kt->cipher), kt->hmac_length, cipher_length, hmac_length);
     return 0;
 }
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index f1af8df84..8998a74f9 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -138,7 +138,6 @@ struct sha256_digest {
  */
 struct key_type
 {
-    uint8_t cipher_length;      /**< Cipher length, in bytes */
     uint8_t hmac_length;        /**< HMAC length, in bytes */
     const cipher_kt_t *cipher;  /**< Cipher static parameters */
     const md_kt_t *digest;      /**< Message digest static parameters */
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 925d1db37..d4dd93c3a 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -323,12 +323,11 @@ void cipher_ctx_free(cipher_ctx_t *ctx);
  *
  * @param ctx           Cipher context. May not be NULL
  * @param key           Buffer containing the key to use
- * @param key_len       Length of the key, in bytes
  * @param kt            Static cipher parameters to use
  * @param enc           Whether to encrypt or decrypt (either
  *                      \c MBEDTLS_OP_ENCRYPT or \c MBEDTLS_OP_DECRYPT).
  */
-void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, int key_len,
+void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key,
                      const cipher_kt_t *kt, int enc);
 
 /**
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 566baadde..feb97bc94 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -534,10 +534,11 @@ cipher_ctx_free(mbedtls_cipher_context_t *ctx)
 }
 
 void
-cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, int key_len,
+cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key,
                 const mbedtls_cipher_info_t *kt, const mbedtls_operation_t operation)
 {
     ASSERT(NULL != kt && NULL != ctx);
+    int key_len = cipher_kt_key_size(kt);
 
     CLEAR(*ctx);
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 9d6c7c807..8b53b2ce8 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -754,7 +754,7 @@ cipher_ctx_free(EVP_CIPHER_CTX *ctx)
 }
 
 void
-cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key, int key_len,
+cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key,
                 const EVP_CIPHER *kt, int enc)
 {
     ASSERT(NULL != kt && NULL != ctx);
@@ -770,7 +770,7 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key, int key_len,
     }
 
     /* make sure we used a big enough key */
-    ASSERT(EVP_CIPHER_CTX_key_length(ctx) <= key_len);
+    ASSERT(EVP_CIPHER_CTX_key_length(ctx) <= EVP_CIPHER_key_length(kt));
 }
 
 int
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cc3d9fa07..928f7e8a3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3988,7 +3988,7 @@ options_string(const struct options *o,
         {
             init_key_type(&kt, o->ciphername, o->authname, true, false);
             ciphername = cipher_kt_name(kt.cipher);
-            keysize = kt.cipher_length * 8;
+            keysize = cipher_kt_key_size(kt.cipher) * 8;
         }
         /* Only announce the cipher to our peer if we are willing to
          * support it */
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 663f5e169..8403363e2 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -65,7 +65,6 @@ tls_crypt_kt(void)
         return (struct key_type) { 0 };
     }
 
-    kt.cipher_length = cipher_kt_key_size(kt.cipher);
     kt.hmac_length = md_kt_size(kt.digest);
 
     return kt;
-- 
2.33.0


