From: Gert Doering <gert@...1296...>
Date: Fri, 13 Mar 2026 18:52:04 +0100
Message-ID: <20260313175209.12024-1-gert@...1296...>
In-Reply-To: <gerrit.1770053869000.I1bc576c4c7ffacbb9300608d98b06b22f2475fd9@...2715...>
References: <gerrit.1770053869000.I1bc576c4c7ffacbb9300608d98b06b22f2475fd9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] crypto: Change cipher_kt_*_size to
 return unsigned instead of int
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

From: Frank Lichtenheld <frank@...2641...>

OpenSSL uses int but never returns negative values.
mbedTLS < 4 uses size_t and mbedTLS >= 4 doesn't have
its own implementation, so we can choose.

We chose unsigned int since size_t seems a bit silly for
values that are never even close to UINT_MAX.
Making it unsigned makes it easier in most cases to write
code that doesn't have sign-compare issues.

Also change cipher_ctx_iv_length and cipher_ctx_block_size
to return an unsigned value for similar reasons.

v7:
 - switch to unsigned int instead of size_t

Change-Id: I1bc576c4c7ffacbb9300608d98b06b22f2475fd9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1508
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1508
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 748b5b5..7954e8a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -39,11 +39,6 @@
 
 #include "memdbg.h"
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Encryption and Compression Routines.
  *
@@ -93,7 +88,7 @@
     {
         struct buffer iv_buffer;
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] = { 0 };
-        const int iv_len = cipher_ctx_iv_length(ctx->cipher);
+        const unsigned int iv_len = cipher_ctx_iv_length(ctx->cipher);
 
         ASSERT(iv_len >= OPENVPN_AEAD_MIN_IV_LEN && iv_len <= OPENVPN_MAX_IV_LENGTH);
 
@@ -128,7 +123,7 @@
 
         /* This generates the IV by XORing the implicit part of the IV
          * with the packet id already written to the iv buffer */
-        for (int i = 0; i < iv_len; i++)
+        for (unsigned int i = 0; i < iv_len; i++)
         {
             iv[i] = iv[i] ^ ctx->implicit_iv[i];
         }
@@ -214,8 +209,7 @@
         if (ctx->cipher)
         {
             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] = { 0 };
-            const int iv_size = cipher_ctx_iv_length(ctx->cipher);
-            int outlen;
+            const unsigned int iv_size = cipher_ctx_iv_length(ctx->cipher);
 
             /* Reserve space for HMAC */
             if (ctx->hmac)
@@ -274,6 +268,7 @@
             }
 
             /* Encrypt packet ID, payload */
+            int outlen;
             ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf), BLEN(buf)));
             ASSERT(buf_inc_len(&work, outlen));
 
@@ -282,7 +277,7 @@
             ASSERT(buf_inc_len(&work, outlen));
 
             /* For all CBC mode ciphers, check the last block is complete */
-            ASSERT(cipher_ctx_mode(ctx->cipher) != OPENVPN_MODE_CBC || outlen == iv_size);
+            ASSERT(cipher_ctx_mode(ctx->cipher) != OPENVPN_MODE_CBC || outlen == (int)iv_size);
         }
         else /* No Encryption */
         {
@@ -486,7 +481,7 @@
     /* Combine IV from explicit part from packet and implicit part from context */
     {
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] = { 0 };
-        const int iv_len = cipher_ctx_iv_length(ctx->cipher);
+        const unsigned int iv_len = cipher_ctx_iv_length(ctx->cipher);
 
         /* Read packet id. For epoch data format also lookup the epoch key
          * to be able to use the implicit IV of the correct decryption key */
@@ -526,7 +521,7 @@
 
         /* This generates the IV by XORing the implicit part of the IV
          * with the packet id already written to the iv buffer */
-        for (int i = 0; i < iv_len; i++)
+        for (unsigned int i = 0; i < iv_len; i++)
         {
             iv[i] = iv[i] ^ ctx->implicit_iv[i];
         }
@@ -666,7 +661,7 @@
 
         if (ctx->cipher)
         {
-            const int iv_size = cipher_ctx_iv_length(ctx->cipher);
+            const unsigned int iv_size = cipher_ctx_iv_length(ctx->cipher);
             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] = { 0 };
             int outlen;
 
@@ -674,7 +669,7 @@
             ASSERT(buf_init(&work, frame->buf.headroom));
 
             /* read the IV from the packet */
-            if (buf->len < iv_size)
+            if (buf->len < (int)iv_size)
             {
                 CRYPT_ERROR("missing IV info");
             }
@@ -804,10 +799,10 @@
     return ret;
 }
 
-unsigned int
+size_t
 calculate_crypto_overhead(const struct key_type *kt, unsigned int pkt_id_size, bool occ)
 {
-    unsigned int crypto_overhead = 0;
+    size_t crypto_overhead = 0;
 
     if (!cipher_kt_mode_cbc(kt->cipher))
     {
@@ -865,7 +860,7 @@
     {
         msg(M_WARN,
             "WARNING: INSECURE cipher (%s) with block size less than 128"
-            " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
+            " bit (%u bit).  This allows attacks like SWEET32.  Mitigate by "
             "using a --cipher with a larger block size (e.g. AES-256-CBC). "
             "Support for these insecure ciphers will be removed in "
             "OpenVPN 2.8.",
@@ -1010,12 +1005,12 @@
         cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher, enc);
 
         const char *ciphername = cipher_kt_name(kt->cipher);
-        msg(D_CIPHER_INIT, "%s: Cipher '%s' initialized with %d bit key", prefix, ciphername,
+        msg(D_CIPHER_INIT, "%s: Cipher '%s' initialized with %u bit key", prefix, ciphername,
             cipher_kt_key_size(kt->cipher) * 8);
 
         dmsg(D_SHOW_KEYS, "%s: CIPHER KEY: %s", prefix,
              format_hex(key->cipher, cipher_kt_key_size(kt->cipher), 0, &gc));
-        dmsg(D_CRYPTO_DEBUG, "%s: CIPHER block_size=%d iv_size=%d", prefix,
+        dmsg(D_CRYPTO_DEBUG, "%s: CIPHER block_size=%u iv_size=%u", prefix,
              cipher_kt_block_size(kt->cipher), cipher_kt_iv_size(kt->cipher));
         warn_insecure_key_type(ciphername);
     }
@@ -1112,8 +1107,8 @@
 static bool
 key_is_zero(struct key *key, const struct key_type *kt)
 {
-    int cipher_length = cipher_kt_key_size(kt->cipher);
-    for (int i = 0; i < cipher_length; ++i)
+    size_t cipher_length = cipher_kt_key_size(kt->cipher);
+    for (size_t i = 0; i < cipher_length; ++i)
     {
         if (key->cipher[i])
         {
@@ -1171,7 +1166,7 @@
 key_print(const struct key *key, const struct key_type *kt, const char *prefix)
 {
     struct gc_arena gc = gc_new();
-    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher, %s, %d bits): %s", prefix, cipher_kt_name(kt->cipher),
+    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher, %s, %u bits): %s", prefix, cipher_kt_name(kt->cipher),
          cipher_kt_key_size(kt->cipher) * 8,
          format_hex(key->cipher, cipher_kt_key_size(kt->cipher), 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "%s (hmac, %s, %d bits): %s", prefix, md_kt_name(kt->digest),
@@ -1280,10 +1275,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 const char *
 print_key_filename(const char *str, bool is_inline)
 {
@@ -1756,7 +1747,7 @@
 void
 print_cipher(const char *ciphername)
 {
-    printf("%s  (%d bit key, ", cipher_kt_name(ciphername), cipher_kt_key_size(ciphername) * 8);
+    printf("%s  (%u bit key, ", cipher_kt_name(ciphername), cipher_kt_key_size(ciphername) * 8);
 
     if (cipher_kt_block_size(ciphername) == 1)
     {
@@ -1764,7 +1755,7 @@
     }
     else
     {
-        printf("%d bit block", cipher_kt_block_size(ciphername) * 8);
+        printf("%u bit block", cipher_kt_block_size(ciphername) * 8);
     }
 
     if (!cipher_kt_mode_cbc(ciphername))
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 1744653..fbca2a0 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -165,13 +165,13 @@
     uint8_t cipher[MAX_CIPHER_KEY_LENGTH];
 
     /** Number of bytes set in the cipher key material */
-    int cipher_size;
+    unsigned int cipher_size;
 
     /** %Key material for HMAC operations. */
     uint8_t hmac[MAX_HMAC_KEY_LENGTH];
 
     /** Number of bytes set in the HMac key material */
-    int hmac_size;
+    unsigned int hmac_size;
 
     /** the epoch of the key. Only defined/non zero if key parameters
      * represent a data channel epoch key parameters.
@@ -549,8 +549,8 @@
  *                      incorrect way as all previous OpenVPN versions did, to
  *                      end up with identical numbers for OCC compatibility
  */
-unsigned int calculate_crypto_overhead(const struct key_type *kt, unsigned int pkt_id_size,
-                                       bool occ);
+size_t calculate_crypto_overhead(const struct key_type *kt, unsigned int pkt_id_size,
+                                 bool occ);
 
 /** Return the worst-case OpenVPN crypto overhead (in bytes) */
 unsigned int crypto_max_overhead(void);
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 7f5507a..0bfa8b4 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -251,7 +251,7 @@
  *
  * @return              (Default) size of keys used by the cipher, in bytes.
  */
-int cipher_kt_key_size(const char *ciphername);
+unsigned int cipher_kt_key_size(const char *ciphername);
 
 /**
  * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV is
@@ -262,7 +262,7 @@
  * @return              Size of the IV, in bytes, or 0 if the cipher does not
  *                      use an IV.
  */
-int cipher_kt_iv_size(const char *ciphername);
+unsigned int cipher_kt_iv_size(const char *ciphername);
 
 /**
  * Returns the block size of the cipher, in bytes.
@@ -271,7 +271,7 @@
  *
  * @return              Block size, in bytes.
  */
-int cipher_kt_block_size(const char *ciphername);
+unsigned int cipher_kt_block_size(const char *ciphername);
 
 /**
  * Returns the MAC tag size of the cipher, in bytes.
@@ -281,7 +281,7 @@
  * @return              Tag size in bytes, or 0 if the tag size could not be
  *                      determined.
  */
-int cipher_kt_tag_size(const char *ciphername);
+unsigned int cipher_kt_tag_size(const char *ciphername);
 
 /**
  * Returns true if we consider this cipher to be insecure.
@@ -358,7 +358,7 @@
  * @return              Size of the IV, in bytes, or \c 0 if the cipher does not
  *                      use an IV.
  */
-int cipher_ctx_iv_length(const cipher_ctx_t *ctx);
+unsigned int cipher_ctx_iv_length(const cipher_ctx_t *ctx);
 
 /**
  * Gets the computed message authenticated code (MAC) tag for this cipher.
@@ -376,7 +376,7 @@
  *
  * @return              Block size, in bytes, or 0 if ctx was NULL.
  */
-int cipher_ctx_block_size(const cipher_ctx_t *ctx);
+unsigned int cipher_ctx_block_size(const cipher_ctx_t *ctx);
 
 /**
  * Returns the mode that the cipher runs in.
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index f04ba4b4..54225bf 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -39,17 +39,18 @@
 #include "integer.h"
 
 void
-ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, int info_len, uint8_t *out,
-                 int out_len)
+ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, size_t info_len,
+                 uint8_t *out, size_t out_len)
 {
     hmac_ctx_t *hmac_ctx = hmac_ctx_new();
     hmac_ctx_init(hmac_ctx, secret, "SHA256");
 
-    const int digest_size = SHA256_DIGEST_LENGTH;
+    ASSERT(info_len <= INT_MAX);
+    const unsigned int digest_size = SHA256_DIGEST_LENGTH;
 
     /* T(0) = empty string */
     uint8_t t_prev[SHA256_DIGEST_LENGTH];
-    int t_prev_len = 0;
+    unsigned int t_prev_len = 0;
 
     for (uint8_t block = 1; (block - 1) * digest_size < out_len; block++)
     {
@@ -57,14 +58,14 @@
 
         /* calculate T(block) */
         hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);
-        hmac_ctx_update(hmac_ctx, info, info_len);
+        hmac_ctx_update(hmac_ctx, info, (int)info_len);
         hmac_ctx_update(hmac_ctx, &block, 1);
         hmac_ctx_final(hmac_ctx, t_prev);
         t_prev_len = digest_size;
 
         /* Copy a full hmac output or remaining bytes */
-        int out_offset = (block - 1) * digest_size;
-        int copylen = min_int(digest_size, out_len - out_offset);
+        size_t out_offset = (block - 1) * digest_size;
+        size_t copylen = min_size(digest_size, out_len - out_offset);
 
         memcpy(out + out_offset, t_prev, copylen);
     }
@@ -72,14 +73,9 @@
     hmac_ctx_free(hmac_ctx);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 bool
 ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t *label, size_t label_len,
-                  const uint8_t *context, size_t context_len, uint8_t *out, int out_len)
+                  const uint8_t *context, size_t context_len, uint8_t *out, size_t out_len)
 {
     if (secret_len != 32 || label_len > 250 || context_len > 255 || label_len < 1)
     {
@@ -89,7 +85,7 @@
          * need need to be in range */
         return false;
     }
-    ASSERT(out_len >= 0 && out_len <= UINT16_MAX);
+    ASSERT(out_len <= UINT16_MAX);
 
     struct gc_arena gc = gc_new();
     /* 2 byte for the outlen encoded as uint16, 5 bytes for "ovpn ",
@@ -111,18 +107,14 @@
         buf_write(&hkdf_label, context, context_len);
     }
 
-    ASSERT(buf_len(&hkdf_label) == hkdf_label_len);
+    ASSERT(buf_len(&hkdf_label) == (int)hkdf_label_len);
 
-    ovpn_hkdf_expand(secret, buf_bptr(&hkdf_label), buf_len(&hkdf_label), out, out_len);
+    ovpn_hkdf_expand(secret, buf_bptr(&hkdf_label), hkdf_label_len, out, out_len);
 
     gc_free(&gc);
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * Iterates the epoch key to make it E_n+1, ie increase the epoch by one
  * and derive the new key material accordingly
diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h
index 2b3d345..0fb76d5 100644
--- a/src/openvpn/crypto_epoch.h
+++ b/src/openvpn/crypto_epoch.h
@@ -38,8 +38,8 @@
  *  @param out      output keying material
  *  @param out_len  length of output keying material
  */
-void ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, int info_len, uint8_t *out,
-                      int out_len);
+void ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, size_t info_len,
+                      uint8_t *out, size_t out_len);
 
 /**
  * Variant of the RFC 8446 TLS 1.3  HKDF-Expand-Label function with the
@@ -59,8 +59,8 @@
  * @return
  */
 bool ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t *label,
-                       size_t label_len, const uint8_t *context, size_t context_len, uint8_t *out,
-                       int out_len);
+                       size_t label_len, const uint8_t *context, size_t context_len,
+                       uint8_t *out, size_t out_len);
 
 /**
  * Generate a data channel key pair from the epoch key
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 7aaea3d..c41daef 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -160,7 +160,7 @@
     if (cipher_info->key_bytes > MAX_CIPHER_KEY_LENGTH)
     {
         msg(D_LOW,
-            "Cipher algorithm '%s' uses a default key size (%d bytes) "
+            "Cipher algorithm '%s' uses a default key size (%u bytes) "
             "which is larger than " PACKAGE_NAME "'s current maximum key size "
             "(%d bytes)",
             ciphername, cipher_info->key_bytes, MAX_CIPHER_KEY_LENGTH);
@@ -183,7 +183,7 @@
     return cipher_info->name;
 }
 
-int
+unsigned int
 cipher_kt_key_size(const char *ciphername)
 {
     const cipher_info_t *cipher_info = cipher_get(ciphername);
@@ -194,7 +194,7 @@
     return cipher_info->key_bytes;
 }
 
-int
+unsigned int
 cipher_kt_iv_size(const char *ciphername)
 {
     const cipher_info_t *cipher_info = cipher_get(ciphername);
@@ -206,7 +206,7 @@
     return cipher_info->iv_bytes;
 }
 
-int
+unsigned int
 cipher_kt_block_size(const char *ciphername)
 {
     const cipher_info_t *cipher_info = cipher_get(ciphername);
@@ -217,7 +217,7 @@
     return cipher_info->block_size;
 }
 
-int
+unsigned int
 cipher_kt_tag_size(const char *ciphername)
 {
     if (cipher_kt_mode_aead(ciphername))
@@ -310,20 +310,20 @@
 
     psa_set_key_type(&ctx->key_attributes, ctx->cipher_info->psa_key_type);
     psa_set_key_algorithm(&ctx->key_attributes, ctx->cipher_info->psa_alg);
-    psa_set_key_bits(&ctx->key_attributes, (size_t)ctx->cipher_info->key_bytes * 8);
+    psa_set_key_bits(&ctx->key_attributes, ctx->cipher_info->key_bytes * 8);
     psa_set_key_usage_flags(&ctx->key_attributes,
                             enc == OPENVPN_OP_ENCRYPT ? PSA_KEY_USAGE_ENCRYPT : PSA_KEY_USAGE_DECRYPT);
 
-    if (psa_import_key(&ctx->key_attributes, key, (size_t)ctx->cipher_info->key_bytes, &ctx->key) != PSA_SUCCESS)
+    if (psa_import_key(&ctx->key_attributes, key, ctx->cipher_info->key_bytes, &ctx->key) != PSA_SUCCESS)
     {
         msg(M_FATAL, "psa_import_key failed");
     }
 
     /* make sure we used a big enough key */
-    ASSERT(psa_get_key_bits(&ctx->key_attributes) == (size_t)(8 * ctx->cipher_info->key_bytes));
+    ASSERT(psa_get_key_bits(&ctx->key_attributes) == (8 * ctx->cipher_info->key_bytes));
 }
 
-int
+unsigned int
 cipher_ctx_iv_length(const cipher_ctx_t *ctx)
 {
     return ctx->cipher_info->iv_bytes;
@@ -341,7 +341,7 @@
     return 1;
 }
 
-int
+unsigned int
 cipher_ctx_block_size(const cipher_ctx_t *ctx)
 {
     return ctx->cipher_info->block_size;
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 16d41e4..04346a9 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -70,9 +70,9 @@
     const char *name;
     psa_key_type_t psa_key_type;
     psa_algorithm_t psa_alg;
-    int key_bytes;
-    int iv_bytes;
-    int block_size;
+    unsigned int key_bytes;
+    unsigned int iv_bytes;
+    unsigned int block_size;
 } cipher_info_t;
 
 typedef union psa_cipher_or_aead_operation
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c
index b234632..087d94c 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -236,7 +236,6 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
-#pragma GCC diagnostic ignored "-Wsign-compare"
 #endif
 
 bool
@@ -446,7 +445,7 @@
     return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(cipher_kt));
 }
 
-int
+unsigned int
 cipher_kt_key_size(const char *ciphername)
 {
     const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
@@ -456,10 +455,10 @@
         return 0;
     }
 
-    return (int)mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;
+    return mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;
 }
 
-int
+unsigned int
 cipher_kt_iv_size(const char *ciphername)
 {
     const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
@@ -468,10 +467,10 @@
     {
         return 0;
     }
-    return (int)mbedtls_cipher_info_get_iv_size(cipher_kt);
+    return mbedtls_cipher_info_get_iv_size(cipher_kt);
 }
 
-int
+unsigned int
 cipher_kt_block_size(const char *ciphername)
 {
     const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
@@ -479,10 +478,10 @@
     {
         return 0;
     }
-    return (int)mbedtls_cipher_info_get_block_size(cipher_kt);
+    return mbedtls_cipher_info_get_block_size(cipher_kt);
 }
 
-int
+unsigned int
 cipher_kt_tag_size(const char *ciphername)
 {
     if (cipher_kt_mode_aead(ciphername))
@@ -595,10 +594,10 @@
     }
 
     /* make sure we used a big enough key */
-    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) <= key_bitlen);
+    ASSERT((size_t)mbedtls_cipher_get_key_bitlen(ctx) <= key_bitlen);
 }
 
-int
+unsigned int
 cipher_ctx_iv_length(const mbedtls_cipher_context_t *ctx)
 {
     return mbedtls_cipher_get_iv_size(ctx);
@@ -607,7 +606,7 @@
 int
 cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_len)
 {
-    if (tag_len > SIZE_MAX)
+    if (tag_len < 0)
     {
         return 0;
     }
@@ -620,10 +619,10 @@
     return 1;
 }
 
-int
+unsigned int
 cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)
 {
-    return (int)mbedtls_cipher_get_block_size(ctx);
+    return mbedtls_cipher_get_block_size(ctx);
 }
 
 int
@@ -679,7 +678,7 @@
 int
 cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)
 {
-    if (src_len > SIZE_MAX)
+    if (src_len < 0)
     {
         return 0;
     }
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index de3878d..1e14253 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -669,25 +669,27 @@
     return translate_cipher_name_to_openvpn(name);
 }
 
-int
+unsigned int
 cipher_kt_key_size(const char *ciphername)
 {
     evp_cipher_type *cipher = cipher_get(ciphername);
     int size = EVP_CIPHER_key_length(cipher);
+    ASSERT(size >= 0);
     EVP_CIPHER_free(cipher);
     return size;
 }
 
-int
+unsigned int
 cipher_kt_iv_size(const char *ciphername)
 {
     evp_cipher_type *cipher = cipher_get(ciphername);
     int ivsize = EVP_CIPHER_iv_length(cipher);
+    ASSERT(ivsize >= 0);
     EVP_CIPHER_free(cipher);
     return ivsize;
 }
 
-int
+unsigned int
 cipher_kt_block_size(const char *ciphername)
 {
     /*
@@ -733,10 +735,11 @@
     EVP_CIPHER_free(cbc_cipher);
     EVP_CIPHER_free(cipher);
     free(name);
+    ASSERT(block_size >= 0);
     return block_size;
 }
 
-int
+unsigned int
 cipher_kt_tag_size(const char *ciphername)
 {
     if (cipher_kt_mode_aead(ciphername))
@@ -872,7 +875,7 @@
     EVP_CIPHER_free(kt);
 }
 
-int
+unsigned int
 cipher_ctx_iv_length(const EVP_CIPHER_CTX *ctx)
 {
     return EVP_CIPHER_CTX_iv_length(ctx);
@@ -884,7 +887,7 @@
     return EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_GET_TAG, tag_size, tag_buf);
 }
 
-int
+unsigned int
 cipher_ctx_block_size(const EVP_CIPHER_CTX *ctx)
 {
     return EVP_CIPHER_CTX_block_size(ctx);
@@ -1190,11 +1193,6 @@
     HMAC_CTX_free(ctx);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 void
 hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, const char *mdname)
 {
@@ -1209,13 +1207,9 @@
     }
 
     /* make sure we used a big enough key */
-    ASSERT(HMAC_size(ctx) <= key_len);
+    ASSERT((ssize_t)HMAC_size(ctx) <= key_len);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 hmac_ctx_cleanup(HMAC_CTX *ctx)
 {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b92fa43..b878428 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -612,7 +612,8 @@
     msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, epoch %d", __func__, slot, keyid, peerid,
         ciphername, epoch);
 
-    const int key_len = cipher_kt_key_size(ciphername);
+    const size_t key_len = cipher_kt_key_size(ciphername);
+    ASSERT(key_len <= INT_MAX);
     const int nonce_tail_len = 8;
 
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_NEW);
@@ -634,7 +635,7 @@
     struct nlattr *key_enc = nla_nest_start(nl_msg, OVPN_A_KEYCONF_ENCRYPT_DIR);
     if (dco_cipher != OVPN_CIPHER_ALG_NONE)
     {
-        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, key_len, encrypt_key);
+        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, (int)key_len, encrypt_key);
         NLA_PUT(nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, nonce_tail_len, encrypt_iv);
     }
     nla_nest_end(nl_msg, key_enc);
@@ -642,7 +643,7 @@
     struct nlattr *key_dec = nla_nest_start(nl_msg, OVPN_A_KEYCONF_DECRYPT_DIR);
     if (dco_cipher != OVPN_CIPHER_ALG_NONE)
     {
-        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, key_len, decrypt_key);
+        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, (int)key_len, decrypt_key);
         NLA_PUT(nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, nonce_tail_len, decrypt_iv);
     }
     nla_nest_end(nl_msg, key_dec);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e065e63..1db781d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4430,7 +4430,7 @@
         /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
          * to work here in the default configuration */
         const char *ciphername = o->ciphername;
-        int keysize = 0;
+        size_t keysize = 0;
 
         if (strcmp(o->ciphername, "BF-CBC") == 0)
         {
@@ -4453,7 +4453,7 @@
             buf_printf(&out, ",cipher %s", ciphername);
         }
         buf_printf(&out, ",auth %s", md_kt_name(kt.digest));
-        buf_printf(&out, ",keysize %d", keysize);
+        buf_printf(&out, ",keysize %zu", keysize);
         if (o->shared_secret_file)
         {
             buf_printf(&out, ",secret");

