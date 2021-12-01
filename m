From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Dec 2021 19:07:24 +0100
Message-Id: <20211201180727.2496903-6-arne@...1227...>
In-Reply-To: <20211201180727.2496903-1-arne@...1227...>
References: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/9] Remove key_type->hmac_length
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

This field is only set once with md_kt_size and then only read. Remove this
field and replace the read accesses with md_kt_size.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/auth_token.c               |  2 --
 src/openvpn/crypto.c                   | 35 +++++++++++++++-----------
 src/openvpn/crypto.h                   |  1 -
 src/openvpn/crypto_backend.h           |  4 +--
 src/openvpn/crypto_mbedtls.c           | 14 ++++++++---
 src/openvpn/crypto_openssl.c           |  8 +++---
 src/openvpn/init.c                     |  2 --
 src/openvpn/ntlm.c                     |  8 +++---
 src/openvpn/openvpn.h                  |  2 +-
 src/openvpn/tls_crypt.c                |  2 --
 tests/unit_tests/openvpn/test_crypto.c |  2 +-
 11 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index c6c37ea86..5d5cea7f6 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -44,8 +44,6 @@ auth_token_kt(void)
         return (struct key_type) { 0 };
     }
 
-    kt.hmac_length = md_kt_size(kt.digest);
-
     return kt;
 }
 
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c85a75319..fd730668f 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -693,7 +693,7 @@ crypto_adjust_frame_parameters(struct frame *frame,
         crypto_overhead += cipher_kt_block_size(kt->cipher);
     }
 
-    crypto_overhead += kt->hmac_length;
+    crypto_overhead += md_kt_size(kt->digest);
 
     frame_add_to_extra_frame(frame, crypto_overhead);
 
@@ -780,9 +780,9 @@ init_key_type(struct key_type *kt, const char *ciphername,
         if (!aead_cipher) /* Ignore auth for AEAD ciphers */
         {
             kt->digest = md_kt_get(authname);
-            kt->hmac_length = md_kt_size(kt->digest);
+            int hmac_length = md_kt_size(kt->digest);
 
-            if (OPENVPN_MAX_HMAC_SIZE < kt->hmac_length)
+            if (OPENVPN_MAX_HMAC_SIZE < hmac_length)
             {
                 msg(M_FATAL, "HMAC '%s' not allowed: digest size too big.", authname);
             }
@@ -828,17 +828,17 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
              cipher_kt_iv_size(kt->cipher));
         warn_insecure_key_type(ciphername, kt->cipher);
     }
-    if (kt->digest && kt->hmac_length > 0)
+    if (kt->digest)
     {
         ctx->hmac = hmac_ctx_new();
-        hmac_ctx_init(ctx->hmac, key->hmac, kt->hmac_length, kt->digest);
+        hmac_ctx_init(ctx->hmac, key->hmac, kt->digest);
 
         msg(D_HANDSHAKE,
             "%s: Using %d bit message hash '%s' for HMAC authentication",
             prefix, md_kt_size(kt->digest) * 8, md_kt_name(kt->digest));
 
         dmsg(D_SHOW_KEYS, "%s: HMAC KEY: %s", prefix,
-             format_hex(key->hmac, kt->hmac_length, 0, &gc));
+             format_hex(key->hmac, md_kt_size(kt->digest), 0, &gc));
 
         dmsg(D_CRYPTO_DEBUG, "%s: HMAC size=%d block_size=%d",
              prefix,
@@ -958,9 +958,11 @@ generate_key_random(struct key *key, const struct key_type *kt)
         {
             cipher_len = cipher_kt_key_size(kt->cipher);
 
-            if (kt->digest && kt->hmac_length > 0 && kt->hmac_length <= hmac_len)
+            int kt_hmac_length = md_kt_size(kt->digest);
+
+            if (kt->digest && kt_hmac_length > 0 && kt_hmac_length <= hmac_len)
             {
-                hmac_len = kt->hmac_length;
+                hmac_len = kt_hmac_length;
             }
         }
         if (!rand_bytes(key->cipher, cipher_len)
@@ -993,13 +995,13 @@ key2_print(const struct key2 *k,
          format_hex(k->keys[0].cipher, cipher_kt_key_size(kt->cipher), 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "%s (hmac): %s",
          prefix0,
-         format_hex(k->keys[0].hmac, kt->hmac_length, 0, &gc));
+         format_hex(k->keys[0].hmac, md_kt_size(kt->digest), 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "%s (cipher): %s",
          prefix1,
          format_hex(k->keys[1].cipher, cipher_kt_key_size(kt->cipher), 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "%s (hmac): %s",
          prefix1,
-         format_hex(k->keys[1].hmac, kt->hmac_length, 0, &gc));
+         format_hex(k->keys[1].hmac, md_kt_size(kt->digest), 0, &gc));
     gc_free(&gc);
 }
 
@@ -1527,14 +1529,17 @@ write_key(const struct key *key, const struct key_type *kt,
           struct buffer *buf)
 {
     ASSERT(cipher_kt_key_size(kt->cipher) <= MAX_CIPHER_KEY_LENGTH
-           && kt->hmac_length <= MAX_HMAC_KEY_LENGTH);
+           && md_kt_size(kt->digest) <= MAX_HMAC_KEY_LENGTH);
 
     const uint8_t cipher_length = cipher_kt_key_size(kt->cipher);
     if (!buf_write(buf, &cipher_length, 1))
     {
         return false;
     }
-    if (!buf_write(buf, &kt->hmac_length, 1))
+
+    uint8_t hmac_length = md_kt_size(kt->digest);
+
+    if (!buf_write(buf, &hmac_length, 1))
     {
         return false;
     }
@@ -1542,7 +1547,7 @@ write_key(const struct key *key, const struct key_type *kt,
     {
         return false;
     }
-    if (!buf_write(buf, key->hmac, kt->hmac_length))
+    if (!buf_write(buf, key->hmac, hmac_length))
     {
         return false;
     }
@@ -1572,7 +1577,7 @@ read_key(struct key *key, const struct key_type *kt, struct buffer *buf)
         goto read_err;
     }
 
-    if (cipher_length != cipher_kt_key_size(kt->cipher) || hmac_length != kt->hmac_length)
+    if (cipher_length != cipher_kt_key_size(kt->cipher) || hmac_length != md_kt_size(kt->digest))
     {
         goto key_len_err;
     }
@@ -1595,7 +1600,7 @@ read_err:
 key_len_err:
     msg(D_TLS_ERRORS,
         "TLS Error: key length mismatch, local cipher/hmac %d/%d, remote cipher/hmac %d/%d",
-        cipher_kt_key_size(kt->cipher), kt->hmac_length, cipher_length, hmac_length);
+        cipher_kt_key_size(kt->cipher), md_kt_size(kt->digest), cipher_length, hmac_length);
     return 0;
 }
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 8998a74f9..1e2ca3cb0 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -138,7 +138,6 @@ struct sha256_digest {
  */
 struct key_type
 {
-    uint8_t hmac_length;        /**< HMAC length, in bytes */
     const cipher_kt_t *cipher;  /**< Cipher static parameters */
     const md_kt_t *digest;      /**< Message digest static parameters */
 };
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index d4dd93c3a..cc3e40400 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -616,12 +616,10 @@ void hmac_ctx_free(hmac_ctx_t *ctx);
  *
  * @param ctx           HMAC context to initialise
  * @param key           The key to use for the HMAC
- * @param key_len       The key length to use
  * @param kt            Static message digest parameters
  *
  */
-void hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, int key_length,
-                   const md_kt_t *kt);
+void hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, const md_kt_t *kt);
 
 /*
  * Free the given HMAC context.
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index feb97bc94..8acf0e184 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -867,12 +867,13 @@ hmac_ctx_free(mbedtls_md_context_t *ctx)
 }
 
 void
-hmac_ctx_init(mbedtls_md_context_t *ctx, const uint8_t *key, int key_len,
+hmac_ctx_init(mbedtls_md_context_t *ctx, const uint8_t *key,
               const mbedtls_md_info_t *kt)
 {
     ASSERT(NULL != kt && NULL != ctx);
 
     mbedtls_md_init(ctx);
+    int key_len = mbedtls_md_get_size(kt);
     ASSERT(0 == mbedtls_md_setup(ctx, kt, 1));
     ASSERT(0 == mbedtls_md_hmac_starts(ctx, key, key_len));
 
@@ -978,8 +979,15 @@ tls1_P_hash(const md_kt_t *md_kt, const uint8_t *sec, int sec_len,
     int chunk = md_kt_size(md_kt);
     unsigned int A1_len = md_kt_size(md_kt);
 
-    hmac_ctx_init(ctx, sec, sec_len, md_kt);
-    hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt);
+    /* This is the only place where we init an HMAC with a key that is not
+     * equal to its size, therefore we init the hmac ctx manually here */
+    mbedtls_md_init(ctx);
+    ASSERT(0 == mbedtls_md_setup(ctx, md_kt, 1));
+    ASSERT(0 == mbedtls_md_hmac_starts(ctx, sec, sec_len));
+
+    mbedtls_md_init(ctx_tmp);
+    ASSERT(0 == mbedtls_md_setup(ctx_tmp, md_kt, 1));
+    ASSERT(0 == mbedtls_md_hmac_starts(ctx_tmp, sec, sec_len));
 
     hmac_ctx_update(ctx,seed,seed_len);
     hmac_ctx_final(ctx, A1);
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 8b53b2ce8..e28e2f43a 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1079,11 +1079,11 @@ hmac_ctx_free(HMAC_CTX *ctx)
 }
 
 void
-hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, int key_len,
-              const EVP_MD *kt)
+hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, const EVP_MD *kt)
 {
     ASSERT(NULL != kt && NULL != ctx);
 
+    int key_len = EVP_MD_size(kt);
     HMAC_CTX_reset(ctx);
     if (!HMAC_Init_ex(ctx, key, key_len, kt, NULL))
     {
@@ -1152,10 +1152,10 @@ hmac_ctx_free(hmac_ctx_t *ctx)
 }
 
 void
-hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, int key_len,
-              const EVP_MD *kt)
+hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, const EVP_MD *kt)
 {
     ASSERT(NULL != kt && NULL != ctx && ctx->ctx != NULL);
+    int key_len = EVP_MD_size(kt);
     ASSERT(key_len <= EVP_MAX_KEY_LENGTH);
 
     /* We need to make a copy of the key since the OSSL parameters
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0645a08df..4fee7f49f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2661,8 +2661,6 @@ do_init_tls_wrap_key(struct context *c)
         if (!streq(options->authname, "none"))
         {
             c->c1.ks.tls_auth_key_type.digest = md_kt_get(options->authname);
-            c->c1.ks.tls_auth_key_type.hmac_length =
-                md_kt_size(c->c1.ks.tls_auth_key_type.digest);
         }
         else
         {
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 28e68ded5..8fc9fbd6a 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -81,13 +81,13 @@ gen_md4_hash(const uint8_t *data, int data_len, uint8_t *result)
 }
 
 static void
-gen_hmac_md5(const uint8_t *data, int data_len, const uint8_t *key, int key_len,
+gen_hmac_md5(const uint8_t *data, int data_len, const uint8_t *key,
              uint8_t *result)
 {
     const md_kt_t *md5_kt = md_kt_get("MD5");
     hmac_ctx_t *hmac_ctx = hmac_ctx_new();
 
-    hmac_ctx_init(hmac_ctx, key, key_len, md5_kt);
+    hmac_ctx_init(hmac_ctx, key, md5_kt);
     hmac_ctx_update(hmac_ctx, data, data_len);
     hmac_ctx_final(hmac_ctx, result);
     hmac_ctx_cleanup(hmac_ctx);
@@ -287,7 +287,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
         }
         unicodize(userdomain_u, userdomain);
         gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain), md4_hash,
-                     MD5_DIGEST_LENGTH, ntlmv2_hash);
+                     ntlmv2_hash);
 
         /* NTLMv2 Blob */
         memset(ntlmv2_blob, 0, 128);                        /* Clear blob buffer */
@@ -352,7 +352,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
 
         /* hmac-md5 */
         gen_hmac_md5(&ntlmv2_response[8], ntlmv2_blob_size + 8, ntlmv2_hash,
-                     MD5_DIGEST_LENGTH, ntlmv2_hmacmd5);
+                     ntlmv2_hmacmd5);
 
         /* Add hmac-md5 result to the blob.
          * Note: This overwrites challenge previously written at
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index df6bc9df2..84477837e 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -526,7 +526,7 @@ struct context
 #define PROTO_DUMP(buf, gc) protocol_dump((buf), \
                                           PROTO_DUMP_FLAGS   \
                                           |(c->c2.tls_multi ? PD_TLS : 0)   \
-                                          |(c->options.tls_auth_file ? c->c1.ks.key_type.hmac_length : 0), \
+                                          |(c->options.tls_auth_file ? md_kt_size(c->c1.ks.key_type.digest) : 0), \
                                           gc)
 
 #define CIPHER_ENABLED(c) (c->c1.ks.key_type.cipher != NULL)
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 8403363e2..80ed9684e 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -65,8 +65,6 @@ tls_crypt_kt(void)
         return (struct key_type) { 0 };
     }
 
-    kt.hmac_length = md_kt_size(kt.digest);
-
     return kt;
 }
 
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index d3ce2d6f5..42632c72b 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -181,7 +181,7 @@ crypto_test_hmac(void **state)
     uint8_t key[20];
     memcpy(key, testkey, sizeof(key));
 
-    hmac_ctx_init(hmac, key, 20, sha1);
+    hmac_ctx_init(hmac, key, sha1);
     hmac_ctx_update(hmac, (const uint8_t *)ipsumlorem, (int) strlen(ipsumlorem));
     hmac_ctx_update(hmac, (const uint8_t *)ipsumlorem, (int) strlen(ipsumlorem));
 
-- 
2.33.0


