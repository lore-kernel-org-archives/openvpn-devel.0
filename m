From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 10 Mar 2026 13:21:27 +0000
In-Reply-To: <gerrit.1770053869000.I1bc576c4c7ffacbb9300608d98b06b22f2475fd9@...2715...>
References: <gerrit.1770053869000.I1bc576c4c7ffacbb9300608d98b06b22f2475fd9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <204e06290da22b1b16caaed34909da8bb250ec89-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7LjPo9g+FcU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto: Change
 cipher_kt_*_size to return unsigned instead of int
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7LjPo9g+FcU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail

to look at the new patch set (#7).

The following approvals got outdated and were removed:
Code-Review-1 by plaisthos


Change subject: crypto: Change cipher_kt_*_size to return unsigned instead =
of int
......................................................................

crypto: Change cipher_kt_*_size to return unsigned instead of int

OpenSSL uses int but never returns negative values.
mbedTLS < 4 uses size_t and mbedTLS >=3D 4 doesn't have
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
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_epoch.c
M src/openvpn/crypto_epoch.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls.h
M src/openvpn/crypto_mbedtls_legacy.c
M src/openvpn/crypto_openssl.c
M src/openvpn/dco_linux.c
M src/openvpn/options.c
11 files changed, 87 insertions(+), 110 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1508/7

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
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };
-        const int iv_len =3D cipher_ctx_iv_length(ctx->cipher);
+        const unsigned int iv_len =3D cipher_ctx_iv_length(ctx->cipher);

         ASSERT(iv_len >=3D OPENVPN_AEAD_MIN_IV_LEN && iv_len <=3D OPENVPN_=
MAX_IV_LENGTH);

@@ -128,7 +123,7 @@

         /* This generates the IV by XORing the implicit part of the IV
          * with the packet id already written to the iv buffer */
-        for (int i =3D 0; i < iv_len; i++)
+        for (unsigned int i =3D 0; i < iv_len; i++)
         {
             iv[i] =3D iv[i] ^ ctx->implicit_iv[i];
         }
@@ -214,8 +209,7 @@
         if (ctx->cipher)
         {
             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] =3D { 0 };
-            const int iv_size =3D cipher_ctx_iv_length(ctx->cipher);
-            int outlen;
+            const unsigned int iv_size =3D cipher_ctx_iv_length(ctx->ciphe=
r);

             /* Reserve space for HMAC */
             if (ctx->hmac)
@@ -274,6 +268,7 @@
             }

             /* Encrypt packet ID, payload */
+            int outlen;
             ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BP=
TR(buf), BLEN(buf)));
             ASSERT(buf_inc_len(&work, outlen));

@@ -282,7 +277,7 @@
             ASSERT(buf_inc_len(&work, outlen));

             /* For all CBC mode ciphers, check the last block is complete =
*/
-            ASSERT(cipher_ctx_mode(ctx->cipher) !=3D OPENVPN_MODE_CBC || o=
utlen =3D=3D iv_size);
+            ASSERT(cipher_ctx_mode(ctx->cipher) !=3D OPENVPN_MODE_CBC || o=
utlen =3D=3D (int)iv_size);
         }
         else /* No Encryption */
         {
@@ -486,7 +481,7 @@
     /* Combine IV from explicit part from packet and implicit part from co=
ntext */
     {
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };
-        const int iv_len =3D cipher_ctx_iv_length(ctx->cipher);
+        const unsigned int iv_len =3D cipher_ctx_iv_length(ctx->cipher);

         /* Read packet id. For epoch data format also lookup the epoch key
          * to be able to use the implicit IV of the correct decryption key=
 */
@@ -526,7 +521,7 @@

         /* This generates the IV by XORing the implicit part of the IV
          * with the packet id already written to the iv buffer */
-        for (int i =3D 0; i < iv_len; i++)
+        for (unsigned int i =3D 0; i < iv_len; i++)
         {
             iv[i] =3D iv[i] ^ ctx->implicit_iv[i];
         }
@@ -666,7 +661,7 @@

         if (ctx->cipher)
         {
-            const int iv_size =3D cipher_ctx_iv_length(ctx->cipher);
+            const unsigned int iv_size =3D cipher_ctx_iv_length(ctx->ciphe=
r);
             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] =3D { 0 };
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
 calculate_crypto_overhead(const struct key_type *kt, unsigned int pkt_id_s=
ize, bool occ)
 {
-    unsigned int crypto_overhead =3D 0;
+    size_t crypto_overhead =3D 0;

     if (!cipher_kt_mode_cbc(kt->cipher))
     {
@@ -865,7 +860,7 @@
     {
         msg(M_WARN,
             "WARNING: INSECURE cipher (%s) with block size less than 128"
-            " bit (%d bit).  This allows attacks like SWEET32.  Mitigate b=
y "
+            " bit (%u bit).  This allows attacks like SWEET32.  Mitigate b=
y "
             "using a --cipher with a larger block size (e.g. AES-256-CBC).=
 "
             "Support for these insecure ciphers will be removed in "
             "OpenVPN 2.8.",
@@ -1010,12 +1005,12 @@
         cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher, enc);

         const char *ciphername =3D cipher_kt_name(kt->cipher);
-        msg(D_CIPHER_INIT, "%s: Cipher '%s' initialized with %d bit key", =
prefix, ciphername,
+        msg(D_CIPHER_INIT, "%s: Cipher '%s' initialized with %u bit key", =
prefix, ciphername,
             cipher_kt_key_size(kt->cipher) * 8);

         dmsg(D_SHOW_KEYS, "%s: CIPHER KEY: %s", prefix,
              format_hex(key->cipher, cipher_kt_key_size(kt->cipher), 0, &g=
c));
-        dmsg(D_CRYPTO_DEBUG, "%s: CIPHER block_size=3D%d iv_size=3D%d", pr=
efix,
+        dmsg(D_CRYPTO_DEBUG, "%s: CIPHER block_size=3D%u iv_size=3D%u", pr=
efix,
              cipher_kt_block_size(kt->cipher), cipher_kt_iv_size(kt->ciphe=
r));
         warn_insecure_key_type(ciphername);
     }
@@ -1112,8 +1107,8 @@
 static bool
 key_is_zero(struct key *key, const struct key_type *kt)
 {
-    int cipher_length =3D cipher_kt_key_size(kt->cipher);
-    for (int i =3D 0; i < cipher_length; ++i)
+    size_t cipher_length =3D cipher_kt_key_size(kt->cipher);
+    for (size_t i =3D 0; i < cipher_length; ++i)
     {
         if (key->cipher[i])
         {
@@ -1171,7 +1166,7 @@
 key_print(const struct key *key, const struct key_type *kt, const char *pr=
efix)
 {
     struct gc_arena gc =3D gc_new();
-    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher, %s, %d bits): %s", prefix, cipher=
_kt_name(kt->cipher),
+    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher, %s, %u bits): %s", prefix, cipher=
_kt_name(kt->cipher),
          cipher_kt_key_size(kt->cipher) * 8,
          format_hex(key->cipher, cipher_kt_key_size(kt->cipher), 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "%s (hmac, %s, %d bits): %s", prefix, md_kt_na=
me(kt->digest),
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
-    printf("%s  (%d bit key, ", cipher_kt_name(ciphername), cipher_kt_key_=
size(ciphername) * 8);
+    printf("%s  (%u bit key, ", cipher_kt_name(ciphername), cipher_kt_key_=
size(ciphername) * 8);

     if (cipher_kt_block_size(ciphername) =3D=3D 1)
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
  *                      incorrect way as all previous OpenVPN versions did=
, to
  *                      end up with identical numbers for OCC compatibility
  */
-unsigned int calculate_crypto_overhead(const struct key_type *kt, unsigned=
 int pkt_id_size,
-                                       bool occ);
+size_t calculate_crypto_overhead(const struct key_type *kt, unsigned int p=
kt_id_size,
+                                 bool occ);

 /** Return the worst-case OpenVPN crypto overhead (in bytes) */
 unsigned int crypto_max_overhead(void);
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 7f5507a..0bfa8b4 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -251,7 +251,7 @@
  *
  * @return              (Default) size of keys used by the cipher, in byte=
s.
  */
-int cipher_kt_key_size(const char *ciphername);
+unsigned int cipher_kt_key_size(const char *ciphername);

 /**
  * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV =
is
@@ -262,7 +262,7 @@
  * @return              Size of the IV, in bytes, or 0 if the cipher does =
not
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
  * @return              Tag size in bytes, or 0 if the tag size could not =
be
  *                      determined.
  */
-int cipher_kt_tag_size(const char *ciphername);
+unsigned int cipher_kt_tag_size(const char *ciphername);

 /**
  * Returns true if we consider this cipher to be insecure.
@@ -358,7 +358,7 @@
  * @return              Size of the IV, in bytes, or \c 0 if the cipher do=
es not
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
-ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, int info_len,=
 uint8_t *out,
-                 int out_len)
+ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, size_t info_l=
en,
+                 uint8_t *out, size_t out_len)
 {
     hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();
     hmac_ctx_init(hmac_ctx, secret, "SHA256");

-    const int digest_size =3D SHA256_DIGEST_LENGTH;
+    ASSERT(info_len <=3D INT_MAX);
+    const unsigned int digest_size =3D SHA256_DIGEST_LENGTH;

     /* T(0) =3D empty string */
     uint8_t t_prev[SHA256_DIGEST_LENGTH];
-    int t_prev_len =3D 0;
+    unsigned int t_prev_len =3D 0;

     for (uint8_t block =3D 1; (block - 1) * digest_size < out_len; block++)
     {
@@ -57,14 +58,14 @@

         /* calculate T(block) */
         hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);
-        hmac_ctx_update(hmac_ctx, info, info_len);
+        hmac_ctx_update(hmac_ctx, info, (int)info_len);
         hmac_ctx_update(hmac_ctx, &block, 1);
         hmac_ctx_final(hmac_ctx, t_prev);
         t_prev_len =3D digest_size;

         /* Copy a full hmac output or remaining bytes */
-        int out_offset =3D (block - 1) * digest_size;
-        int copylen =3D min_int(digest_size, out_len - out_offset);
+        size_t out_offset =3D (block - 1) * digest_size;
+        size_t copylen =3D min_size(digest_size, out_len - out_offset);

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
 ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t =
*label, size_t label_len,
-                  const uint8_t *context, size_t context_len, uint8_t *out=
, int out_len)
+                  const uint8_t *context, size_t context_len, uint8_t *out=
, size_t out_len)
 {
     if (secret_len !=3D 32 || label_len > 250 || context_len > 255 || labe=
l_len < 1)
     {
@@ -89,7 +85,7 @@
          * need need to be in range */
         return false;
     }
-    ASSERT(out_len >=3D 0 && out_len <=3D UINT16_MAX);
+    ASSERT(out_len <=3D UINT16_MAX);

     struct gc_arena gc =3D gc_new();
     /* 2 byte for the outlen encoded as uint16, 5 bytes for "ovpn ",
@@ -111,18 +107,14 @@
         buf_write(&hkdf_label, context, context_len);
     }

-    ASSERT(buf_len(&hkdf_label) =3D=3D hkdf_label_len);
+    ASSERT(buf_len(&hkdf_label) =3D=3D (int)hkdf_label_len);

-    ovpn_hkdf_expand(secret, buf_bptr(&hkdf_label), buf_len(&hkdf_label), =
out, out_len);
+    ovpn_hkdf_expand(secret, buf_bptr(&hkdf_label), hkdf_label_len, out, o=
ut_len);

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
-void ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, int info=
_len, uint8_t *out,
-                      int out_len);
+void ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, size_t i=
nfo_len,
+                      uint8_t *out, size_t out_len);

 /**
  * Variant of the RFC 8446 TLS 1.3  HKDF-Expand-Label function with the
@@ -59,8 +59,8 @@
  * @return
  */
 bool ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uin=
t8_t *label,
-                       size_t label_len, const uint8_t *context, size_t co=
ntext_len, uint8_t *out,
-                       int out_len);
+                       size_t label_len, const uint8_t *context, size_t co=
ntext_len,
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
             "which is larger than " PACKAGE_NAME "'s current maximum key s=
ize "
             "(%d bytes)",
             ciphername, cipher_info->key_bytes, MAX_CIPHER_KEY_LENGTH);
@@ -183,7 +183,7 @@
     return cipher_info->name;
 }

-int
+unsigned int
 cipher_kt_key_size(const char *ciphername)
 {
     const cipher_info_t *cipher_info =3D cipher_get(ciphername);
@@ -194,7 +194,7 @@
     return cipher_info->key_bytes;
 }

-int
+unsigned int
 cipher_kt_iv_size(const char *ciphername)
 {
     const cipher_info_t *cipher_info =3D cipher_get(ciphername);
@@ -206,7 +206,7 @@
     return cipher_info->iv_bytes;
 }

-int
+unsigned int
 cipher_kt_block_size(const char *ciphername)
 {
     const cipher_info_t *cipher_info =3D cipher_get(ciphername);
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
-    psa_set_key_bits(&ctx->key_attributes, (size_t)ctx->cipher_info->key_b=
ytes * 8);
+    psa_set_key_bits(&ctx->key_attributes, ctx->cipher_info->key_bytes * 8=
);
     psa_set_key_usage_flags(&ctx->key_attributes,
                             enc =3D=3D OPENVPN_OP_ENCRYPT ? PSA_KEY_USAGE_=
ENCRYPT : PSA_KEY_USAGE_DECRYPT);

-    if (psa_import_key(&ctx->key_attributes, key, (size_t)ctx->cipher_info=
->key_bytes, &ctx->key) !=3D PSA_SUCCESS)
+    if (psa_import_key(&ctx->key_attributes, key, ctx->cipher_info->key_by=
tes, &ctx->key) !=3D PSA_SUCCESS)
     {
         msg(M_FATAL, "psa_import_key failed");
     }

     /* make sure we used a big enough key */
-    ASSERT(psa_get_key_bits(&ctx->key_attributes) =3D=3D (size_t)(8 * ctx-=
>cipher_info->key_bytes));
+    ASSERT(psa_get_key_bits(&ctx->key_attributes) =3D=3D (8 * ctx->cipher_=
info->key_bytes));
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
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedt=
ls_legacy.c
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
     return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(c=
ipher_kt));
 }

-int
+unsigned int
 cipher_kt_key_size(const char *ciphername)
 {
     const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
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
     const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
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
     const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
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
-    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) <=3D key_bitlen);
+    ASSERT((size_t)mbedtls_cipher_get_key_bitlen(ctx) <=3D key_bitlen);
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
     evp_cipher_type *cipher =3D cipher_get(ciphername);
     int size =3D EVP_CIPHER_key_length(cipher);
+    ASSERT(size >=3D 0);
     EVP_CIPHER_free(cipher);
     return size;
 }

-int
+unsigned int
 cipher_kt_iv_size(const char *ciphername)
 {
     evp_cipher_type *cipher =3D cipher_get(ciphername);
     int ivsize =3D EVP_CIPHER_iv_length(cipher);
+    ASSERT(ivsize >=3D 0);
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
+    ASSERT(block_size >=3D 0);
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
     return EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_GET_TAG, tag_size, tag_b=
uf);
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
-    ASSERT(HMAC_size(ctx) <=3D key_len);
+    ASSERT((ssize_t)HMAC_size(ctx) <=3D key_len);
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
     msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, epoch=
 %d", __func__, slot, keyid, peerid,
         ciphername, epoch);

-    const int key_len =3D cipher_kt_key_size(ciphername);
+    const size_t key_len =3D cipher_kt_key_size(ciphername);
+    ASSERT(key_len <=3D INT_MAX);
     const int nonce_tail_len =3D 8;

     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_NEW);
@@ -634,7 +635,7 @@
     struct nlattr *key_enc =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF_ENCRY=
PT_DIR);
     if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)
     {
-        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, key_len, encrypt_key);
+        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, (int)key_len, encrypt_ke=
y);
         NLA_PUT(nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, nonce_tail_len, encrypt_=
iv);
     }
     nla_nest_end(nl_msg, key_enc);
@@ -642,7 +643,7 @@
     struct nlattr *key_dec =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF_DECRY=
PT_DIR);
     if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)
     {
-        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, key_len, decrypt_key);
+        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, (int)key_len, decrypt_ke=
y);
         NLA_PUT(nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, nonce_tail_len, decrypt_=
iv);
     }
     nla_nest_end(nl_msg, key_dec);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e065e63..1db781d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4430,7 +4430,7 @@
         /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
          * to work here in the default configuration */
         const char *ciphername =3D o->ciphername;
-        int keysize =3D 0;
+        size_t keysize =3D 0;

         if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1bc576c4c7ffacbb9300608d98b06b22f2475fd9
Gerrit-Change-Number: 1508
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--7LjPo9g+FcU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #7</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">crypto: Change cipher_kt_*_size=
 to return unsigned instead of int<br><br>OpenSSL uses int but never return=
s negative values.<br>mbedTLS &lt; 4 uses size_t and mbedTLS &gt;=3D 4 does=
n&#39;t have<br>its own implementation, so we can choose.<br><br>We chose u=
nsigned int since size_t seems a bit silly for<br>values that are never eve=
n close to UINT_MAX.<br>Making it unsigned makes it easier in most cases to=
 write<br>code that doesn&#39;t have sign-compare issues.<br><br>Also chang=
e cipher_ctx_iv_length and cipher_ctx_block_size<br>to return an unsigned v=
alue for similar reasons.<br><br>v7:<br> - switch to unsigned int instead o=
f size_t<br><br>Change-Id: I1bc576c4c7ffacbb9300608d98b06b22f2475fd9<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/open=
vpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/crypto_backend.h<br=
>M src/openvpn/crypto_epoch.c<br>M src/openvpn/crypto_epoch.h<br>M src/open=
vpn/crypto_mbedtls.c<br>M src/openvpn/crypto_mbedtls.h<br>M src/openvpn/cry=
pto_mbedtls_legacy.c<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/dco=
_linux.c<br>M src/openvpn/options.c<br>11 files changed, 87 insertions(+), =
110 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/08/1508/7</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/cr=
ypto.c b/src/openvpn/crypto.c</span><br><span>index 748b5b5..7954e8a 100644=
</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openv=
pn/crypto.c</span><br><span>@@ -39,11 +39,6 @@</span><br><span> </span><br>=
<span> #include &quot;memdbg.h&quot;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC di=
agnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> /*</span><br><span>  * Encryption and Compression =
Routines.</span><br><span>  *</span><br><span>@@ -93,7 +88,7 @@</span><br><=
span>     {</span><br><span>         struct buffer iv_buffer;</span><br><sp=
an>         uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        const int iv_len =3D cipher_ctx_=
iv_length(ctx-&gt;cipher);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        const unsigned int iv_len =3D cipher_ctx_iv_length(ctx-&gt;c=
ipher);</span><br><span> </span><br><span>         ASSERT(iv_len &gt;=3D OP=
ENVPN_AEAD_MIN_IV_LEN &amp;&amp; iv_len &lt;=3D OPENVPN_MAX_IV_LENGTH);</sp=
an><br><span> </span><br><span>@@ -128,7 +123,7 @@</span><br><span> </span>=
<br><span>         /* This generates the IV by XORing the implicit part of =
the IV</span><br><span>          * with the packet id already written to th=
e iv buffer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 for (int i =3D 0; i &lt; iv_len; i++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        for (unsigned int i =3D 0; i &lt; iv_len; i++)</=
span><br><span>         {</span><br><span>             iv[i] =3D iv[i] ^ ct=
x-&gt;implicit_iv[i];</span><br><span>         }</span><br><span>@@ -214,8 =
+209,7 @@</span><br><span>         if (ctx-&gt;cipher)</span><br><span>    =
     {</span><br><span>             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] =
=3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 const int iv_size =3D cipher_ctx_iv_length(ctx-&gt;cipher);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            int outlen;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            const unsigned int i=
v_size =3D cipher_ctx_iv_length(ctx-&gt;cipher);</span><br><span> </span><b=
r><span>             /* Reserve space for HMAC */</span><br><span>         =
    if (ctx-&gt;hmac)</span><br><span>@@ -274,6 +268,7 @@</span><br><span> =
            }</span><br><span> </span><br><span>             /* Encrypt pac=
ket ID, payload */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           int outlen;</span><br><span>             ASSERT(cipher_ctx_updat=
e(ctx-&gt;cipher, BEND(&amp;work), &amp;outlen, BPTR(buf), BLEN(buf)));</sp=
an><br><span>             ASSERT(buf_inc_len(&amp;work, outlen));</span><br=
><span> </span><br><span>@@ -282,7 +277,7 @@</span><br><span>             A=
SSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><br><span>  =
           /* For all CBC mode ciphers, check the last block is complete */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(ci=
pher_ctx_mode(ctx-&gt;cipher) !=3D OPENVPN_MODE_CBC || outlen =3D=3D iv_siz=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSE=
RT(cipher_ctx_mode(ctx-&gt;cipher) !=3D OPENVPN_MODE_CBC || outlen =3D=3D (=
int)iv_size);</span><br><span>         }</span><br><span>         else /* N=
o Encryption */</span><br><span>         {</span><br><span>@@ -486,7 +481,7=
 @@</span><br><span>     /* Combine IV from explicit part from packet and i=
mplicit part from context */</span><br><span>     {</span><br><span>       =
  uint8_t iv[OPENVPN_MAX_IV_LENGTH] =3D { 0 };</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        const int iv_len =3D cipher_ctx_iv_length(=
ctx-&gt;cipher);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     const unsigned int iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher);</s=
pan><br><span> </span><br><span>         /* Read packet id. For epoch data =
format also lookup the epoch key</span><br><span>          * to be able to =
use the implicit IV of the correct decryption key */</span><br><span>@@ -52=
6,7 +521,7 @@</span><br><span> </span><br><span>         /* This generates =
the IV by XORing the implicit part of the IV</span><br><span>          * wi=
th the packet id already written to the iv buffer */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 0; i &lt; iv_len; i+=
+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (unsi=
gned int i =3D 0; i &lt; iv_len; i++)</span><br><span>         {</span><br>=
<span>             iv[i] =3D iv[i] ^ ctx-&gt;implicit_iv[i];</span><br><spa=
n>         }</span><br><span>@@ -666,7 +661,7 @@</span><br><span> </span><b=
r><span>         if (ctx-&gt;cipher)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            const int iv_size =3D=
 cipher_ctx_iv_length(ctx-&gt;cipher);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            const unsigned int iv_size =3D cipher_ctx_iv=
_length(ctx-&gt;cipher);</span><br><span>             uint8_t iv_buf[OPENVP=
N_MAX_IV_LENGTH] =3D { 0 };</span><br><span>             int outlen;</span>=
<br><span> </span><br><span>@@ -674,7 +669,7 @@</span><br><span>           =
  ASSERT(buf_init(&amp;work, frame-&gt;buf.headroom));</span><br><span> </s=
pan><br><span>             /* read the IV from the packet */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (buf-&gt;len &lt; iv_=
size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (buf-&gt;len &lt; (int)iv_size)</span><br><span>             {</span><br><=
span>                 CRYPT_ERROR(&quot;missing IV info&quot;);</span><br><=
span>             }</span><br><span>@@ -804,10 +799,10 @@</span><br><span> =
    return ret;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+size_t</span><br><span> calculate_crypto_overhead(=
const struct key_type *kt, unsigned int pkt_id_size, bool occ)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned in=
t crypto_overhead =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    size_t crypto_overhead =3D 0;</span><br><span> </span><br><span>  =
   if (!cipher_kt_mode_cbc(kt-&gt;cipher))</span><br><span>     {</span><br=
><span>@@ -865,7 +860,7 @@</span><br><span>     {</span><br><span>         =
msg(M_WARN,</span><br><span>             &quot;WARNING: INSECURE cipher (%s=
) with block size less than 128&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            &quot; bit (%d bit).  This allows attacks like =
SWEET32.  Mitigate by &quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &quot; bit (%u bit).  This allows attacks like SWEET32=
.  Mitigate by &quot;</span><br><span>             &quot;using a --cipher w=
ith a larger block size (e.g. AES-256-CBC). &quot;</span><br><span>        =
     &quot;Support for these insecure ciphers will be removed in &quot;</sp=
an><br><span>             &quot;OpenVPN 2.8.&quot;,</span><br><span>@@ -101=
0,12 +1005,12 @@</span><br><span>         cipher_ctx_init(ctx-&gt;cipher, k=
ey-&gt;cipher, kt-&gt;cipher, enc);</span><br><span> </span><br><span>     =
    const char *ciphername =3D cipher_kt_name(kt-&gt;cipher);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        msg(D_CIPHER_INIT, &quot;%s=
: Cipher &#39;%s&#39; initialized with %d bit key&quot;, prefix, ciphername=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_CIPH=
ER_INIT, &quot;%s: Cipher &#39;%s&#39; initialized with %u bit key&quot;, p=
refix, ciphername,</span><br><span>             cipher_kt_key_size(kt-&gt;c=
ipher) * 8);</span><br><span> </span><br><span>         dmsg(D_SHOW_KEYS, &=
quot;%s: CIPHER KEY: %s&quot;, prefix,</span><br><span>              format=
_hex(key-&gt;cipher, cipher_kt_key_size(kt-&gt;cipher), 0, &amp;gc));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_CRYPTO_DEBUG=
, &quot;%s: CIPHER block_size=3D%d iv_size=3D%d&quot;, prefix,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_CRYPTO_DEBUG, &qu=
ot;%s: CIPHER block_size=3D%u iv_size=3D%u&quot;, prefix,</span><br><span> =
             cipher_kt_block_size(kt-&gt;cipher), cipher_kt_iv_size(kt-&gt;=
cipher));</span><br><span>         warn_insecure_key_type(ciphername);</spa=
n><br><span>     }</span><br><span>@@ -1112,8 +1107,8 @@</span><br><span> s=
tatic bool</span><br><span> key_is_zero(struct key *key, const struct key_t=
ype *kt)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int cipher_length =3D cipher_kt_key_size(kt-&gt;cipher);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; c=
ipher_length; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   size_t cipher_length =3D cipher_kt_key_size(kt-&gt;cipher);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; =
cipher_length; ++i)</span><br><span>     {</span><br><span>         if (key=
-&gt;cipher[i])</span><br><span>         {</span><br><span>@@ -1171,7 +1166=
,7 @@</span><br><span> key_print(const struct key *key, const struct key_ty=
pe *kt, const char *prefix)</span><br><span> {</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    dmsg(D_SHOW_KEY_SOURCE, &quot;%s (cipher, %s, %d bits): %s&quot;, p=
refix, cipher_kt_name(kt-&gt;cipher),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    dmsg(D_SHOW_KEY_SOURCE, &quot;%s (cipher, %s, %u bits=
): %s&quot;, prefix, cipher_kt_name(kt-&gt;cipher),</span><br><span>       =
   cipher_kt_key_size(kt-&gt;cipher) * 8,</span><br><span>          format_=
hex(key-&gt;cipher, cipher_kt_key_size(kt-&gt;cipher), 0, &amp;gc));</span>=
<br><span>     dmsg(D_SHOW_KEY_SOURCE, &quot;%s (hmac, %s, %d bits): %s&quo=
t;, prefix, md_kt_name(kt-&gt;digest),</span><br><span>@@ -1280,10 +1275,6 =
@@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> const char *</span><br><span> print_key_filename(const char *st=
r, bool is_inline)</span><br><span> {</span><br><span>@@ -1756,7 +1747,7 @@=
</span><br><span> void</span><br><span> print_cipher(const char *ciphername=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   printf(&quot;%s  (%d bit key, &quot;, cipher_kt_name(ciphername), cipher=
_kt_key_size(ciphername) * 8);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    printf(&quot;%s  (%u bit key, &quot;, cipher_kt_name(ciphern=
ame), cipher_kt_key_size(ciphername) * 8);</span><br><span> </span><br><spa=
n>     if (cipher_kt_block_size(ciphername) =3D=3D 1)</span><br><span>     =
{</span><br><span>@@ -1764,7 +1755,7 @@</span><br><span>     }</span><br><s=
pan>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        printf(&quot;%d bit block&quot;, cipher_kt_block_siz=
e(ciphername) * 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        printf(&quot;%u bit block&quot;, cipher_kt_block_size(ciphername) *=
 8);</span><br><span>     }</span><br><span> </span><br><span>     if (!cip=
her_kt_mode_cbc(ciphername))</span><br><span>diff --git a/src/openvpn/crypt=
o.h b/src/openvpn/crypto.h</span><br><span>index 1744653..fbca2a0 100644</s=
pan><br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/=
crypto.h</span><br><span>@@ -165,13 +165,13 @@</span><br><span>     uint8_t=
 cipher[MAX_CIPHER_KEY_LENGTH];</span><br><span> </span><br><span>     /** =
Number of bytes set in the cipher key material */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    int cipher_size;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    unsigned int cipher_size;</span><br><span>=
 </span><br><span>     /** %Key material for HMAC operations. */</span><br>=
<span>     uint8_t hmac[MAX_HMAC_KEY_LENGTH];</span><br><span> </span><br><=
span>     /** Number of bytes set in the HMac key material */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int hmac_size;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    unsigned int hmac_size;</span><b=
r><span> </span><br><span>     /** the epoch of the key. Only defined/non z=
ero if key parameters</span><br><span>      * represent a data channel epoc=
h key parameters.</span><br><span>@@ -549,8 +549,8 @@</span><br><span>  *  =
                    incorrect way as all previous OpenVPN versions did, to<=
/span><br><span>  *                      end up with identical numbers for =
OCC compatibility</span><br><span>  */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-unsigned int calculate_crypto_overhead(const struct key_ty=
pe *kt, unsigned int pkt_id_size,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                       bool occ);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+size_t calculate_crypto_overhead(=
const struct key_type *kt, unsigned int pkt_id_size,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                 bool occ=
);</span><br><span> </span><br><span> /** Return the worst-case OpenVPN cry=
pto overhead (in bytes) */</span><br><span> unsigned int crypto_max_overhea=
d(void);</span><br><span>diff --git a/src/openvpn/crypto_backend.h b/src/op=
envpn/crypto_backend.h</span><br><span>index 7f5507a..0bfa8b4 100644</span>=
<br><span>--- a/src/openvpn/crypto_backend.h</span><br><span>+++ b/src/open=
vpn/crypto_backend.h</span><br><span>@@ -251,7 +251,7 @@</span><br><span>  =
*</span><br><span>  * @return              (Default) size of keys used by t=
he cipher, in bytes.</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-int cipher_kt_key_size(const char *ciphername);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int cipher_kt_key_=
size(const char *ciphername);</span><br><span> </span><br><span> /**</span>=
<br><span>  * Returns the size of the IV used by the cipher, in bytes, or 0=
 if no IV is</span><br><span>@@ -262,7 +262,7 @@</span><br><span>  * @retur=
n              Size of the IV, in bytes, or 0 if the cipher does not</span>=
<br><span>  *                      use an IV.</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-int cipher_kt_iv_size(const ch=
ar *ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uns=
igned int cipher_kt_iv_size(const char *ciphername);</span><br><span> </spa=
n><br><span> /**</span><br><span>  * Returns the block size of the cipher, =
in bytes.</span><br><span>@@ -271,7 +271,7 @@</span><br><span>  *</span><br=
><span>  * @return              Block size, in bytes.</span><br><span>  */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-int cipher_kt_block_si=
ze(const char *ciphername);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+unsigned int cipher_kt_block_size(const char *ciphername);</span><b=
r><span> </span><br><span> /**</span><br><span>  * Returns the MAC tag size=
 of the cipher, in bytes.</span><br><span>@@ -281,7 +281,7 @@</span><br><sp=
an>  * @return              Tag size in bytes, or 0 if the tag size could n=
ot be</span><br><span>  *                      determined.</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int cipher_kt_tag=
_size(const char *ciphername);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+unsigned int cipher_kt_tag_size(const char *ciphername);</span><=
br><span> </span><br><span> /**</span><br><span>  * Returns true if we cons=
ider this cipher to be insecure.</span><br><span>@@ -358,7 +358,7 @@</span>=
<br><span>  * @return              Size of the IV, in bytes, or \c 0 if the=
 cipher does not</span><br><span>  *                      use an IV.</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int cip=
her_ctx_iv_length(const cipher_ctx_t *ctx);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+unsigned int cipher_ctx_iv_length(const cipher_ctx_=
t *ctx);</span><br><span> </span><br><span> /**</span><br><span>  * Gets th=
e computed message authenticated code (MAC) tag for this cipher.</span><br>=
<span>@@ -376,7 +376,7 @@</span><br><span>  *</span><br><span>  * @return  =
            Block size, in bytes, or 0 if ctx was NULL.</span><br><span>  *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int cipher_ctx_block=
_size(const cipher_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+unsigned int cipher_ctx_block_size(const cipher_ctx_t *ctx);</s=
pan><br><span> </span><br><span> /**</span><br><span>  * Returns the mode t=
hat the cipher runs in.</span><br><span>diff --git a/src/openvpn/crypto_epo=
ch.c b/src/openvpn/crypto_epoch.c</span><br><span>index f04ba4b4..54225bf 1=
00644</span><br><span>--- a/src/openvpn/crypto_epoch.c</span><br><span>+++ =
b/src/openvpn/crypto_epoch.c</span><br><span>@@ -39,17 +39,18 @@</span><br>=
<span> #include &quot;integer.h&quot;</span><br><span> </span><br><span> vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_hkdf_expand(co=
nst uint8_t *secret, const uint8_t *info, int info_len, uint8_t *out,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                 int out_le=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_hkdf_expand(=
const uint8_t *secret, const uint8_t *info, size_t info_len,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 uint8_t *out, siz=
e_t out_len)</span><br><span> {</span><br><span>     hmac_ctx_t *hmac_ctx =
=3D hmac_ctx_new();</span><br><span>     hmac_ctx_init(hmac_ctx, secret, &q=
uot;SHA256&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const int digest_size =3D SHA256_DIGEST_LENGTH;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(info_len &lt;=3D =
INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
unsigned int digest_size =3D SHA256_DIGEST_LENGTH;</span><br><span> </span>=
<br><span>     /* T(0) =3D empty string */</span><br><span>     uint8_t t_p=
rev[SHA256_DIGEST_LENGTH];</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int t_prev_len =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    unsigned int t_prev_len =3D 0;</span><br><span> </span><br><=
span>     for (uint8_t block =3D 1; (block - 1) * digest_size &lt; out_len;=
 block++)</span><br><span>     {</span><br><span>@@ -57,14 +58,14 @@</span>=
<br><span> </span><br><span>         /* calculate T(block) */</span><br><sp=
an>         hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_update(hmac_ctx, info=
, info_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 hmac_ctx_update(hmac_ctx, info, (int)info_len);</span><br><span>         h=
mac_ctx_update(hmac_ctx, &amp;block, 1);</span><br><span>         hmac_ctx_=
final(hmac_ctx, t_prev);</span><br><span>         t_prev_len =3D digest_siz=
e;</span><br><span> </span><br><span>         /* Copy a full hmac output or=
 remaining bytes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      int out_offset =3D (block - 1) * digest_size;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        int copylen =3D min_int(digest_size=
, out_len - out_offset);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        size_t out_offset =3D (block - 1) * digest_size;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        size_t copylen =3D min_si=
ze(digest_size, out_len - out_offset);</span><br><span> </span><br><span>  =
       memcpy(out + out_offset, t_prev, copylen);</span><br><span>     }</s=
pan><br><span>@@ -72,14 +73,9 @@</span><br><span>     hmac_ctx_free(hmac_ct=
x);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignor=
ed &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> bool</span><br><span> ovpn_expand_label(const uint8_t *secret, s=
ize_t secret_len, const uint8_t *label, size_t label_len,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                  const uint8_t *contex=
t, size_t context_len, uint8_t *out, int out_len)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                  const uint8_t *context, siz=
e_t context_len, uint8_t *out, size_t out_len)</span><br><span> {</span><br=
><span>     if (secret_len !=3D 32 || label_len &gt; 250 || context_len &gt=
; 255 || label_len &lt; 1)</span><br><span>     {</span><br><span>@@ -89,7 =
+85,7 @@</span><br><span>          * need need to be in range */</span><br>=
<span>         return false;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(out_len &gt;=3D 0 &amp;&amp; out=
_len &lt;=3D UINT16_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(out_len &lt;=3D UINT16_MAX);</span><br><span> </span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span>     /* 2 byte f=
or the outlen encoded as uint16, 5 bytes for &quot;ovpn &quot;,</span><br><=
span>@@ -111,18 +107,14 @@</span><br><span>         buf_write(&amp;hkdf_lab=
el, context, context_len);</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_len(&amp;hkdf_=
label) =3D=3D hkdf_label_len);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASSERT(buf_len(&amp;hkdf_label) =3D=3D (int)hkdf_label_len);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 ovpn_hkdf_expand(secret, buf_bptr(&amp;hkdf_label), buf_len(&amp;hkdf_labe=
l), out, out_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ovpn_hkdf_expand(secret, buf_bptr(&amp;hkdf_label), hkdf_label_len, out,=
 out_len);</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><=
br><span>     return true;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**=
</span><br><span>  * Iterates the epoch key to make it E_n+1, ie increase t=
he epoch by one</span><br><span>  * and derive the new key material accordi=
ngly</span><br><span>diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/=
crypto_epoch.h</span><br><span>index 2b3d345..0fb76d5 100644</span><br><spa=
n>--- a/src/openvpn/crypto_epoch.h</span><br><span>+++ b/src/openvpn/crypto=
_epoch.h</span><br><span>@@ -38,8 +38,8 @@</span><br><span>  *  @param out =
     output keying material</span><br><span>  *  @param out_len  length of =
output keying material</span><br><span>  */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void ovpn_hkdf_expand(const uint8_t *secret, const ui=
nt8_t *info, int info_len, uint8_t *out,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                      int out_len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void ovpn_hkdf_expand(const uint8_t *sec=
ret, const uint8_t *info, size_t info_len,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                      uint8_t *out, size_t out_len);=
</span><br><span> </span><br><span> /**</span><br><span>  * Variant of the =
RFC 8446 TLS 1.3  HKDF-Expand-Label function with the</span><br><span>@@ -5=
9,8 +59,8 @@</span><br><span>  * @return</span><br><span>  */</span><br><sp=
an> bool ovpn_expand_label(const uint8_t *secret, size_t secret_len, const =
uint8_t *label,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                 size_t label_len, const uint8_t *context, size_t context_l=
en, uint8_t *out,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                   int out_len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                       size_t label_len, const uint8_t *contex=
t, size_t context_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                       uint8_t *out, size_t out_len);</span><br><span> <=
/span><br><span> /**</span><br><span>  * Generate a data channel key pair f=
rom the epoch key</span><br><span>diff --git a/src/openvpn/crypto_mbedtls.c=
 b/src/openvpn/crypto_mbedtls.c</span><br><span>index 7aaea3d..c41daef 1006=
44</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><span>+++ b=
/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -160,7 +160,7 @@</span><br=
><span>     if (cipher_info-&gt;key_bytes &gt; MAX_CIPHER_KEY_LENGTH)</span=
><br><span>     {</span><br><span>         msg(D_LOW,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &quot;Cipher algorithm &#39;%s&=
#39; uses a default key size (%d bytes) &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &quot;Cipher algorithm &#39;%s&#39; =
uses a default key size (%u bytes) &quot;</span><br><span>             &quo=
t;which is larger than &quot; PACKAGE_NAME &quot;&#39;s current maximum key=
 size &quot;</span><br><span>             &quot;(%d bytes)&quot;,</span><br=
><span>             ciphername, cipher_info-&gt;key_bytes, MAX_CIPHER_KEY_L=
ENGTH);</span><br><span>@@ -183,7 +183,7 @@</span><br><span>     return cip=
her_info-&gt;name;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+unsigned int</span><br><span> cipher_kt_key_size(const ch=
ar *ciphername)</span><br><span> {</span><br><span>     const cipher_info_t=
 *cipher_info =3D cipher_get(ciphername);</span><br><span>@@ -194,7 +194,7 =
@@</span><br><span>     return cipher_info-&gt;key_bytes;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span=
><br><span> cipher_kt_iv_size(const char *ciphername)</span><br><span> {</s=
pan><br><span>     const cipher_info_t *cipher_info =3D cipher_get(cipherna=
me);</span><br><span>@@ -206,7 +206,7 @@</span><br><span>     return cipher=
_info-&gt;iv_bytes;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+unsigned int</span><br><span> cipher_kt_block_size(const=
 char *ciphername)</span><br><span> {</span><br><span>     const cipher_inf=
o_t *cipher_info =3D cipher_get(ciphername);</span><br><span>@@ -217,7 +217=
,7 @@</span><br><span>     return cipher_info-&gt;block_size;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</=
span><br><span> cipher_kt_tag_size(const char *ciphername)</span><br><span>=
 {</span><br><span>     if (cipher_kt_mode_aead(ciphername))</span><br><spa=
n>@@ -310,20 +310,20 @@</span><br><span> </span><br><span>     psa_set_key_=
type(&amp;ctx-&gt;key_attributes, ctx-&gt;cipher_info-&gt;psa_key_type);</s=
pan><br><span>     psa_set_key_algorithm(&amp;ctx-&gt;key_attributes, ctx-&=
gt;cipher_info-&gt;psa_alg);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    psa_set_key_bits(&amp;ctx-&gt;key_attributes, (size_t)ctx-&gt;ci=
pher_info-&gt;key_bytes * 8);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    psa_set_key_bits(&amp;ctx-&gt;key_attributes, ctx-&gt;cipher_=
info-&gt;key_bytes * 8);</span><br><span>     psa_set_key_usage_flags(&amp;=
ctx-&gt;key_attributes,</span><br><span>                             enc =
=3D=3D OPENVPN_OP_ENCRYPT ? PSA_KEY_USAGE_ENCRYPT : PSA_KEY_USAGE_DECRYPT);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (psa_import_key(&amp;ctx-&gt;key_attributes, key, (size_t)ctx-&gt;ciphe=
r_info-&gt;key_bytes, &amp;ctx-&gt;key) !=3D PSA_SUCCESS)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (psa_import_key(&amp;ctx-&gt;k=
ey_attributes, key, ctx-&gt;cipher_info-&gt;key_bytes, &amp;ctx-&gt;key) !=
=3D PSA_SUCCESS)</span><br><span>     {</span><br><span>         msg(M_FATA=
L, &quot;psa_import_key failed&quot;);</span><br><span>     }</span><br><sp=
an> </span><br><span>     /* make sure we used a big enough key */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(psa_get_key_bits(&a=
mp;ctx-&gt;key_attributes) =3D=3D (size_t)(8 * ctx-&gt;cipher_info-&gt;key_=
bytes));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
psa_get_key_bits(&amp;ctx-&gt;key_attributes) =3D=3D (8 * ctx-&gt;cipher_in=
fo-&gt;key_bytes));</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+unsigned int</span><br><span> cipher_ctx_iv_length(const=
 cipher_ctx_t *ctx)</span><br><span> {</span><br><span>     return ctx-&gt;=
cipher_info-&gt;iv_bytes;</span><br><span>@@ -341,7 +341,7 @@</span><br><sp=
an>     return 1;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+unsigned int</span><br><span> cipher_ctx_block_size(const =
cipher_ctx_t *ctx)</span><br><span> {</span><br><span>     return ctx-&gt;c=
ipher_info-&gt;block_size;</span><br><span>diff --git a/src/openvpn/crypto_=
mbedtls.h b/src/openvpn/crypto_mbedtls.h</span><br><span>index 16d41e4..043=
46a9 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.h</span><br><s=
pan>+++ b/src/openvpn/crypto_mbedtls.h</span><br><span>@@ -70,9 +70,9 @@</s=
pan><br><span>     const char *name;</span><br><span>     psa_key_type_t ps=
a_key_type;</span><br><span>     psa_algorithm_t psa_alg;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int key_bytes;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int iv_bytes;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    int block_size;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    unsigned int key_bytes;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    unsigned int iv_bytes;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int block_size;</s=
pan><br><span> } cipher_info_t;</span><br><span> </span><br><span> typedef =
union psa_cipher_or_aead_operation</span><br><span>diff --git a/src/openvpn=
/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c</span><br><s=
pan>index b234632..087d94c 100644</span><br><span>--- a/src/openvpn/crypto_=
mbedtls_legacy.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy.c<=
/span><br><span>@@ -236,7 +236,6 @@</span><br><span> #if defined(__GNUC__) =
|| defined(__clang__)</span><br><span> #pragma GCC diagnostic push</span><b=
r><span> #pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &=
quot;-Wsign-compare&quot;</span><br><span> #endif</span><br><span> </span><=
br><span> bool</span><br><span>@@ -446,7 +445,7 @@</span><br><span>     ret=
urn translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(cipher_kt=
));</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+unsigned int</span><br><span> cipher_kt_key_size(const char *ciphername)=
</span><br><span> {</span><br><span>     const mbedtls_cipher_info_t *ciphe=
r_kt =3D cipher_get(ciphername);</span><br><span>@@ -456,10 +455,10 @@</spa=
n><br><span>         return 0;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)mbedtls_c=
ipher_info_get_key_bitlen(cipher_kt) / 8;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return mbedtls_cipher_info_get_key_bitlen(cipher_=
kt) / 8;</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+unsigned int</span><br><span> cipher_kt_iv_size(const char *ciphern=
ame)</span><br><span> {</span><br><span>     const mbedtls_cipher_info_t *c=
ipher_kt =3D cipher_get(ciphername);</span><br><span>@@ -468,10 +467,10 @@<=
/span><br><span>     {</span><br><span>         return 0;</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)=
mbedtls_cipher_info_get_iv_size(cipher_kt);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return mbedtls_cipher_info_get_iv_size(cipher_k=
t);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+unsigned int</span><br><span> cipher_kt_block_size(const char *ciphernam=
e)</span><br><span> {</span><br><span>     const mbedtls_cipher_info_t *cip=
her_kt =3D cipher_get(ciphername);</span><br><span>@@ -479,10 +478,10 @@</s=
pan><br><span>     {</span><br><span>         return 0;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)mb=
edtls_cipher_info_get_block_size(cipher_kt);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return mbedtls_cipher_info_get_block_size(ciph=
er_kt);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+unsigned int</span><br><span> cipher_kt_tag_size(const char *ciphern=
ame)</span><br><span> {</span><br><span>     if (cipher_kt_mode_aead(cipher=
name))</span><br><span>@@ -595,10 +594,10 @@</span><br><span>     }</span><=
br><span> </span><br><span>     /* make sure we used a big enough key */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mbedtls_ciphe=
r_get_key_bitlen(ctx) &lt;=3D key_bitlen);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ASSERT((size_t)mbedtls_cipher_get_key_bitlen(ctx=
) &lt;=3D key_bitlen);</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+unsigned int</span><br><span> cipher_ctx_iv_length(co=
nst mbedtls_cipher_context_t *ctx)</span><br><span> {</span><br><span>     =
return mbedtls_cipher_get_iv_size(ctx);</span><br><span>@@ -607,7 +606,7 @@=
</span><br><span> int</span><br><span> cipher_ctx_get_tag(cipher_ctx_t *ctx=
, uint8_t *tag, int tag_len)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (tag_len &gt; SIZE_MAX)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (tag_len &lt; 0)</span><br><spa=
n>     {</span><br><span>         return 0;</span><br><span>     }</span><b=
r><span>@@ -620,10 +619,10 @@</span><br><span>     return 1;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</s=
pan><br><span> cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return (int)mbedtls_cipher_get_block_size(ctx);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return mbedtls_cipher_get_block_size(ctx);<=
/span><br><span> }</span><br><span> </span><br><span> int</span><br><span>@=
@ -679,7 +678,7 @@</span><br><span> int</span><br><span> cipher_ctx_update_=
ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (src_len &gt; SI=
ZE_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (src_=
len &lt; 0)</span><br><span>     {</span><br><span>         return 0;</span=
><br><span>     }</span><br><span>diff --git a/src/openvpn/crypto_openssl.c=
 b/src/openvpn/crypto_openssl.c</span><br><span>index de3878d..1e14253 1006=
44</span><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b=
/src/openvpn/crypto_openssl.c</span><br><span>@@ -669,25 +669,27 @@</span><=
br><span>     return translate_cipher_name_to_openvpn(name);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</s=
pan><br><span> cipher_kt_key_size(const char *ciphername)</span><br><span> =
{</span><br><span>     evp_cipher_type *cipher =3D cipher_get(ciphername);<=
/span><br><span>     int size =3D EVP_CIPHER_key_length(cipher);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(size &gt;=3D 0);</s=
pan><br><span>     EVP_CIPHER_free(cipher);</span><br><span>     return siz=
e;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+unsigned int</span><br><span> cipher_kt_iv_size(const char *ciphername)</=
span><br><span> {</span><br><span>     evp_cipher_type *cipher =3D cipher_g=
et(ciphername);</span><br><span>     int ivsize =3D EVP_CIPHER_iv_length(ci=
pher);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(iv=
size &gt;=3D 0);</span><br><span>     EVP_CIPHER_free(cipher);</span><br><s=
pan>     return ivsize;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+unsigned int</span><br><span> cipher_kt_block_size(c=
onst char *ciphername)</span><br><span> {</span><br><span>     /*</span><br=
><span>@@ -733,10 +735,11 @@</span><br><span>     EVP_CIPHER_free(cbc_ciphe=
r);</span><br><span>     EVP_CIPHER_free(cipher);</span><br><span>     free=
(name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(b=
lock_size &gt;=3D 0);</span><br><span>     return block_size;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</=
span><br><span> cipher_kt_tag_size(const char *ciphername)</span><br><span>=
 {</span><br><span>     if (cipher_kt_mode_aead(ciphername))</span><br><spa=
n>@@ -872,7 +875,7 @@</span><br><span>     EVP_CIPHER_free(kt);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int=
</span><br><span> cipher_ctx_iv_length(const EVP_CIPHER_CTX *ctx)</span><br=
><span> {</span><br><span>     return EVP_CIPHER_CTX_iv_length(ctx);</span>=
<br><span>@@ -884,7 +887,7 @@</span><br><span>     return EVP_CIPHER_CTX_ct=
rl(ctx, EVP_CTRL_AEAD_GET_TAG, tag_size, tag_buf);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><s=
pan> cipher_ctx_block_size(const EVP_CIPHER_CTX *ctx)</span><br><span> {</s=
pan><br><span>     return EVP_CIPHER_CTX_block_size(ctx);</span><br><span>@=
@ -1190,11 +1193,6 @@</span><br><span>     HMAC_CTX_free(ctx);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign=
-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void=
</span><br><span> hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, const ch=
ar *mdname)</span><br><span> {</span><br><span>@@ -1209,13 +1207,9 @@</span=
><br><span>     }</span><br><span> </span><br><span>     /* make sure we us=
ed a big enough key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ASSERT(HMAC_size(ctx) &lt;=3D key_len);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT((ssize_t)HMAC_size(ctx) &lt;=3D key_len=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> hma=
c_ctx_cleanup(HMAC_CTX *ctx)</span><br><span> {</span><br><span>diff --git =
a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index b=
92fa43..b878428 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span>=
<br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -612,7 +612,8 @@=
</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-i=
d %d, cipher %s, epoch %d&quot;, __func__, slot, keyid, peerid,</span><br><=
span>         ciphername, epoch);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const int key_len =3D cipher_kt_key_siz=
e(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst size_t key_len =3D cipher_kt_key_size(ciphername);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(key_len &lt;=3D INT_MAX);</s=
pan><br><span>     const int nonce_tail_len =3D 8;</span><br><span> </span>=
<br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CM=
D_KEY_NEW);</span><br><span>@@ -634,7 +635,7 @@</span><br><span>     struct=
 nlattr *key_enc =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF_ENCRYPT_DIR);</s=
pan><br><span>     if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        NLA_P=
UT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, key_len, encrypt_key);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        NLA_PUT(nl_msg, OVPN_A_KEYD=
IR_CIPHER_KEY, (int)key_len, encrypt_key);</span><br><span>         NLA_PUT=
(nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, nonce_tail_len, encrypt_iv);</span><br><=
span>     }</span><br><span>     nla_nest_end(nl_msg, key_enc);</span><br><=
span>@@ -642,7 +643,7 @@</span><br><span>     struct nlattr *key_dec =3D nl=
a_nest_start(nl_msg, OVPN_A_KEYCONF_DECRYPT_DIR);</span><br><span>     if (=
dco_cipher !=3D OVPN_CIPHER_ALG_NONE)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        NLA_PUT(nl_msg, OVPN_A_KEYDI=
R_CIPHER_KEY, key_len, decrypt_key);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, (int)key=
_len, decrypt_key);</span><br><span>         NLA_PUT(nl_msg, OVPN_A_KEYDIR_=
NONCE_TAIL, nonce_tail_len, decrypt_iv);</span><br><span>     }</span><br><=
span>     nla_nest_end(nl_msg, key_dec);</span><br><span>diff --git a/src/o=
penvpn/options.c b/src/openvpn/options.c</span><br><span>index e065e63..1db=
781d 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++=
 b/src/openvpn/options.c</span><br><span>@@ -4430,7 +4430,7 @@</span><br><s=
pan>         /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC=
</span><br><span>          * to work here in the default configuration */</=
span><br><span>         const char *ciphername =3D o-&gt;ciphername;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        int keysize =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t keysiz=
e =3D 0;</span><br><span> </span><br><span>         if (strcmp(o-&gt;cipher=
name, &quot;BF-CBC&quot;) =3D=3D 0)</span><br><span>         {</span><br><s=
pan>@@ -4453,7 +4453,7 @@</span><br><span>             buf_printf(&amp;out,=
 &quot;,cipher %s&quot;, ciphername);</span><br><span>         }</span><br>=
<span>         buf_printf(&amp;out, &quot;,auth %s&quot;, md_kt_name(kt.dig=
est));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_pri=
ntf(&amp;out, &quot;,keysize %d&quot;, keysize);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,keysize %z=
u&quot;, keysize);</span><br><span>         if (o-&gt;shared_secret_file)</=
span><br><span>         {</span><br><span>             buf_printf(&amp;out,=
 &quot;,secret&quot;);</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail">change 15=
08</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1bc576c4c7ffacbb9300608d98b=
06b22f2475fd9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1508 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--7LjPo9g+FcU=--

