From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 2 Feb 2026 17:37:53 +0000
References: <gerrit.1770053869000.I1bc576c4c7ffacbb9300608d98b06b22f2475fd9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c19bee07effafd03faa5de14e6a2c8051f54bc7e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a6FOwGWUI4U="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto: Change
 cipher_kt_*_size to return size_t instead of int
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

--a6FOwGWUI4U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail

to review the following change.


Change subject: crypto: Change cipher_kt_*_size to return size_t instead of=
 int
......................................................................

crypto: Change cipher_kt_*_size to return size_t instead of int

OpenSSL uses int but never returns negative values.
mbedTLS < 4 uses size_t and mbedTLS >=3D 4 doesn't have
its own implementation, so we can choose.

So choose size_t as a type that can take all these values.
Making this unsigned makes it easier in most cases to write
code that doesn't have sign-compare issues.

Also change cipher_ctx_iv_length and cipher_ctx_block_size
to return an unsigned value for similar reasons. In that
case I did go for unsigned int since no implementation
acutally requires size_t.

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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1508/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 49f2b91..6ba2aa0 100644
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
+            " bit (%zu bit).  This allows attacks like SWEET32.  Mitigate =
by "
             "using a --cipher with a larger block size (e.g. AES-256-CBC).=
 "
             "Support for these insecure ciphers will be removed in "
             "OpenVPN 2.7.",
@@ -1010,12 +1005,12 @@
         cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher, enc);

         const char *ciphername =3D cipher_kt_name(kt->cipher);
-        msg(D_CIPHER_INIT, "%s: Cipher '%s' initialized with %d bit key", =
prefix, ciphername,
+        msg(D_CIPHER_INIT, "%s: Cipher '%s' initialized with %zu bit key",=
 prefix, ciphername,
             cipher_kt_key_size(kt->cipher) * 8);

         dmsg(D_SHOW_KEYS, "%s: CIPHER KEY: %s", prefix,
              format_hex(key->cipher, cipher_kt_key_size(kt->cipher), 0, &g=
c));
-        dmsg(D_CRYPTO_DEBUG, "%s: CIPHER block_size=3D%d iv_size=3D%d", pr=
efix,
+        dmsg(D_CRYPTO_DEBUG, "%s: CIPHER block_size=3D%zu iv_size=3D%zu", =
prefix,
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
+    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher, %s, %zu bits): %s", prefix, ciphe=
r_kt_name(kt->cipher),
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
+    printf("%s  (%zu bit key, ", cipher_kt_name(ciphername), cipher_kt_key=
_size(ciphername) * 8);

     if (cipher_kt_block_size(ciphername) =3D=3D 1)
     {
@@ -1764,7 +1755,7 @@
     }
     else
     {
-        printf("%d bit block", cipher_kt_block_size(ciphername) * 8);
+        printf("%zu bit block", cipher_kt_block_size(ciphername) * 8);
     }

     if (!cipher_kt_mode_cbc(ciphername))
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 1744653..cb7450f 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -165,13 +165,13 @@
     uint8_t cipher[MAX_CIPHER_KEY_LENGTH];

     /** Number of bytes set in the cipher key material */
-    int cipher_size;
+    size_t cipher_size;

     /** %Key material for HMAC operations. */
     uint8_t hmac[MAX_HMAC_KEY_LENGTH];

     /** Number of bytes set in the HMac key material */
-    int hmac_size;
+    size_t hmac_size;

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
index 5248614..81ff9e7 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -251,7 +251,7 @@
  *
  * @return              (Default) size of keys used by the cipher, in byte=
s.
  */
-int cipher_kt_key_size(const char *ciphername);
+size_t cipher_kt_key_size(const char *ciphername);

 /**
  * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV =
is
@@ -262,7 +262,7 @@
  * @return              Size of the IV, in bytes, or 0 if the cipher does =
not
  *                      use an IV.
  */
-int cipher_kt_iv_size(const char *ciphername);
+size_t cipher_kt_iv_size(const char *ciphername);

 /**
  * Returns the block size of the cipher, in bytes.
@@ -271,7 +271,7 @@
  *
  * @return              Block size, in bytes.
  */
-int cipher_kt_block_size(const char *ciphername);
+size_t cipher_kt_block_size(const char *ciphername);

 /**
  * Returns the MAC tag size of the cipher, in bytes.
@@ -281,7 +281,7 @@
  * @return              Tag size in bytes, or 0 if the tag size could not =
be
  *                      determined.
  */
-int cipher_kt_tag_size(const char *ciphername);
+size_t cipher_kt_tag_size(const char *ciphername);

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
index 5418df9..a81b190 100644
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
+size_t
 cipher_kt_key_size(const char *ciphername)
 {
     const cipher_info_t *cipher_info =3D cipher_get(ciphername);
@@ -194,7 +194,7 @@
     return cipher_info->key_bytes;
 }

-int
+size_t
 cipher_kt_iv_size(const char *ciphername)
 {
     const cipher_info_t *cipher_info =3D cipher_get(ciphername);
@@ -206,7 +206,7 @@
     return cipher_info->iv_bytes;
 }

-int
+size_t
 cipher_kt_block_size(const char *ciphername)
 {
     const cipher_info_t *cipher_info =3D cipher_get(ciphername);
@@ -217,7 +217,7 @@
     return cipher_info->block_size;
 }

-int
+size_t
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
index f9b7ae6..e099fa4 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -236,7 +236,6 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
-#pragma GCC diagnostic ignored "-Wsign-compare"
 #endif

 bool
@@ -456,7 +455,7 @@
     return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(c=
ipher_kt));
 }

-int
+size_t
 cipher_kt_key_size(const char *ciphername)
 {
     const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
@@ -466,10 +465,10 @@
         return 0;
     }

-    return (int)mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;
+    return mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;
 }

-int
+size_t
 cipher_kt_iv_size(const char *ciphername)
 {
     const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
@@ -478,10 +477,10 @@
     {
         return 0;
     }
-    return (int)mbedtls_cipher_info_get_iv_size(cipher_kt);
+    return mbedtls_cipher_info_get_iv_size(cipher_kt);
 }

-int
+size_t
 cipher_kt_block_size(const char *ciphername)
 {
     const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
@@ -489,10 +488,10 @@
     {
         return 0;
     }
-    return (int)mbedtls_cipher_info_get_block_size(cipher_kt);
+    return mbedtls_cipher_info_get_block_size(cipher_kt);
 }

-int
+size_t
 cipher_kt_tag_size(const char *ciphername)
 {
     if (cipher_kt_mode_aead(ciphername))
@@ -605,10 +604,10 @@
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
@@ -617,7 +616,7 @@
 int
 cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_len)
 {
-    if (tag_len > SIZE_MAX)
+    if (tag_len < 0)
     {
         return 0;
     }
@@ -630,10 +629,10 @@
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
@@ -689,7 +688,7 @@
 int
 cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)
 {
-    if (src_len > SIZE_MAX)
+    if (src_len < 0)
     {
         return 0;
     }
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 9576cb2..abb6cbf 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -669,25 +669,27 @@
     return translate_cipher_name_to_openvpn(name);
 }

-int
+size_t
 cipher_kt_key_size(const char *ciphername)
 {
     evp_cipher_type *cipher =3D cipher_get(ciphername);
     int size =3D EVP_CIPHER_key_length(cipher);
+    ASSERT(size >=3D 0);
     EVP_CIPHER_free(cipher);
     return size;
 }

-int
+size_t
 cipher_kt_iv_size(const char *ciphername)
 {
     evp_cipher_type *cipher =3D cipher_get(ciphername);
     int ivsize =3D EVP_CIPHER_iv_length(cipher);
+    ASSERT(ivsize >=3D 0);
     EVP_CIPHER_free(cipher);
     return ivsize;
 }

-int
+size_t
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
+size_t
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
index 334ea64..278ca2f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4448,7 +4448,7 @@
         /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
          * to work here in the default configuration */
         const char *ciphername =3D o->ciphername;
-        int keysize =3D 0;
+        size_t keysize =3D 0;

         if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
         {
@@ -4471,7 +4471,7 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1bc576c4c7ffacbb9300608d98b06b22f2475fd9
Gerrit-Change-Number: 1508
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--a6FOwGWUI4U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">crypto: Change cipher_kt_*_size to return s=
ize_t instead of int<br><br>OpenSSL uses int but never returns negative val=
ues.<br>mbedTLS &lt; 4 uses size_t and mbedTLS &gt;=3D 4 doesn&#39;t have<b=
r>its own implementation, so we can choose.<br><br>So choose size_t as a ty=
pe that can take all these values.<br>Making this unsigned makes it easier =
in most cases to write<br>code that doesn&#39;t have sign-compare issues.<b=
r><br>Also change cipher_ctx_iv_length and cipher_ctx_block_size<br>to retu=
rn an unsigned value for similar reasons. In that<br>case I did go for unsi=
gned int since no implementation<br>acutally requires size_t.<br><br>Change=
-Id: I1bc576c4c7ffacbb9300608d98b06b22f2475fd9<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/=
openvpn/crypto.h<br>M src/openvpn/crypto_backend.h<br>M src/openvpn/crypto_=
epoch.c<br>M src/openvpn/crypto_epoch.h<br>M src/openvpn/crypto_mbedtls.c<b=
r>M src/openvpn/crypto_mbedtls.h<br>M src/openvpn/crypto_mbedtls_legacy.c<b=
r>M src/openvpn/crypto_openssl.c<br>M src/openvpn/dco_linux.c<br>M src/open=
vpn/options.c<br>11 files changed, 87 insertions(+), 110 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/08/1508/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/c=
rypto.c</span><br><span>index 49f2b91..6ba2aa0 100644</span><br><span>--- a=
/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br>=
<span>@@ -39,11 +39,6 @@</span><br><span> </span><br><span> #include &quot;=
memdbg.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot=
;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> /*</span><br><span>  * Encryption and Compression Routines.</span><br><s=
pan>  *</span><br><span>@@ -93,7 +88,7 @@</span><br><span>     {</span><br>=
<span>         struct buffer iv_buffer;</span><br><span>         uint8_t iv=
[OPENVPN_MAX_IV_LENGTH] =3D { 0 };</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        const int iv_len =3D cipher_ctx_iv_length(ctx-&gt;ciph=
er);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const u=
nsigned int iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher);</span><br><spa=
n> </span><br><span>         ASSERT(iv_len &gt;=3D OPENVPN_AEAD_MIN_IV_LEN =
&amp;&amp; iv_len &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span> </span><=
br><span>@@ -128,7 +123,7 @@</span><br><span> </span><br><span>         /* =
This generates the IV by XORing the implicit part of the IV</span><br><span=
>          * with the packet id already written to the iv buffer */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 0; i &=
lt; iv_len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     for (unsigned int i =3D 0; i &lt; iv_len; i++)</span><br><span>       =
  {</span><br><span>             iv[i] =3D iv[i] ^ ctx-&gt;implicit_iv[i];<=
/span><br><span>         }</span><br><span>@@ -214,8 +209,7 @@</span><br><s=
pan>         if (ctx-&gt;cipher)</span><br><span>         {</span><br><span=
>             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] =3D { 0 };</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            const int iv_size =3D =
cipher_ctx_iv_length(ctx-&gt;cipher);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            int outlen;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            const unsigned int iv_size =3D cipher_ctx_i=
v_length(ctx-&gt;cipher);</span><br><span> </span><br><span>             /*=
 Reserve space for HMAC */</span><br><span>             if (ctx-&gt;hmac)</=
span><br><span>@@ -274,6 +268,7 @@</span><br><span>             }</span><br=
><span> </span><br><span>             /* Encrypt packet ID, payload */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            int outlen;<=
/span><br><span>             ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(=
&amp;work), &amp;outlen, BPTR(buf), BLEN(buf)));</span><br><span>          =
   ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><br><spa=
n>@@ -282,7 +277,7 @@</span><br><span>             ASSERT(buf_inc_len(&amp;=
work, outlen));</span><br><span> </span><br><span>             /* For all C=
BC mode ciphers, check the last block is complete */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ASSERT(cipher_ctx_mode(ctx-&gt;=
cipher) !=3D OPENVPN_MODE_CBC || outlen =3D=3D iv_size);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            ASSERT(cipher_ctx_mode(ctx=
-&gt;cipher) !=3D OPENVPN_MODE_CBC || outlen =3D=3D (int)iv_size);</span><b=
r><span>         }</span><br><span>         else /* No Encryption */</span>=
<br><span>         {</span><br><span>@@ -486,7 +481,7 @@</span><br><span>  =
   /* Combine IV from explicit part from packet and implicit part from cont=
ext */</span><br><span>     {</span><br><span>         uint8_t iv[OPENVPN_M=
AX_IV_LENGTH] =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        const int iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        const unsigned in=
t iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher);</span><br><span> </span>=
<br><span>         /* Read packet id. For epoch data format also lookup the=
 epoch key</span><br><span>          * to be able to use the implicit IV of=
 the correct decryption key */</span><br><span>@@ -526,7 +521,7 @@</span><b=
r><span> </span><br><span>         /* This generates the IV by XORing the i=
mplicit part of the IV</span><br><span>          * with the packet id alrea=
dy written to the iv buffer */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        for (int i =3D 0; i &lt; iv_len; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for (unsigned int i =3D 0; i &lt=
; iv_len; i++)</span><br><span>         {</span><br><span>             iv[i=
] =3D iv[i] ^ ctx-&gt;implicit_iv[i];</span><br><span>         }</span><br>=
<span>@@ -666,7 +661,7 @@</span><br><span> </span><br><span>         if (ct=
x-&gt;cipher)</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            const int iv_size =3D cipher_ctx_iv_length(c=
tx-&gt;cipher);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        const unsigned int iv_size =3D cipher_ctx_iv_length(ctx-&gt;cipher)=
;</span><br><span>             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] =3D { =
0 };</span><br><span>             int outlen;</span><br><span> </span><br><=
span>@@ -674,7 +669,7 @@</span><br><span>             ASSERT(buf_init(&amp;=
work, frame-&gt;buf.headroom));</span><br><span> </span><br><span>         =
    /* read the IV from the packet */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (buf-&gt;len &lt; iv_size)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (buf-&gt;len &lt; (int=
)iv_size)</span><br><span>             {</span><br><span>                 C=
RYPT_ERROR(&quot;missing IV info&quot;);</span><br><span>             }</sp=
an><br><span>@@ -804,10 +799,10 @@</span><br><span>     return ret;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+size_t</span><br><span> calculate_crypto_overhead(const struct key_type *k=
t, unsigned int pkt_id_size, bool occ)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    unsigned int crypto_overhead =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t crypto_o=
verhead =3D 0;</span><br><span> </span><br><span>     if (!cipher_kt_mode_c=
bc(kt-&gt;cipher))</span><br><span>     {</span><br><span>@@ -865,7 +860,7 =
@@</span><br><span>     {</span><br><span>         msg(M_WARN,</span><br><s=
pan>             &quot;WARNING: INSECURE cipher (%s) with block size less t=
han 128&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    &quot; bit (%d bit).  This allows attacks like SWEET32.  Mitigate by &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot; bit (%zu bit).  This allows attacks like SWEET32.  Mitigate by &quot;</=
span><br><span>             &quot;using a --cipher with a larger block size=
 (e.g. AES-256-CBC). &quot;</span><br><span>             &quot;Support for =
these insecure ciphers will be removed in &quot;</span><br><span>          =
   &quot;OpenVPN 2.7.&quot;,</span><br><span>@@ -1010,12 +1005,12 @@</span>=
<br><span>         cipher_ctx_init(ctx-&gt;cipher, key-&gt;cipher, kt-&gt;c=
ipher, enc);</span><br><span> </span><br><span>         const char *ciphern=
ame =3D cipher_kt_name(kt-&gt;cipher);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(D_CIPHER_INIT, &quot;%s: Cipher &#39;%s&#39; i=
nitialized with %d bit key&quot;, prefix, ciphername,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_CIPHER_INIT, &quot;%s: Ciph=
er &#39;%s&#39; initialized with %zu bit key&quot;, prefix, ciphername,</sp=
an><br><span>             cipher_kt_key_size(kt-&gt;cipher) * 8);</span><br=
><span> </span><br><span>         dmsg(D_SHOW_KEYS, &quot;%s: CIPHER KEY: %=
s&quot;, prefix,</span><br><span>              format_hex(key-&gt;cipher, c=
ipher_kt_key_size(kt-&gt;cipher), 0, &amp;gc));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        dmsg(D_CRYPTO_DEBUG, &quot;%s: CIPHER blo=
ck_size=3D%d iv_size=3D%d&quot;, prefix,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        dmsg(D_CRYPTO_DEBUG, &quot;%s: CIPHER block_si=
ze=3D%zu iv_size=3D%zu&quot;, prefix,</span><br><span>              cipher_=
kt_block_size(kt-&gt;cipher), cipher_kt_iv_size(kt-&gt;cipher));</span><br>=
<span>         warn_insecure_key_type(ciphername);</span><br><span>     }</=
span><br><span>@@ -1112,8 +1107,8 @@</span><br><span> static bool</span><br=
><span> key_is_zero(struct key *key, const struct key_type *kt)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int cipher=
_length =3D cipher_kt_key_size(kt-&gt;cipher);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; cipher_length; ++i)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t cipher_len=
gth =3D cipher_kt_key_size(kt-&gt;cipher);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; cipher_length; ++i)<=
/span><br><span>     {</span><br><span>         if (key-&gt;cipher[i])</spa=
n><br><span>         {</span><br><span>@@ -1171,7 +1166,7 @@</span><br><spa=
n> key_print(const struct key *key, const struct key_type *kt, const char *=
prefix)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_SHOW_=
KEY_SOURCE, &quot;%s (cipher, %s, %d bits): %s&quot;, prefix, cipher_kt_nam=
e(kt-&gt;cipher),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  dmsg(D_SHOW_KEY_SOURCE, &quot;%s (cipher, %s, %zu bits): %s&quot;, prefix=
, cipher_kt_name(kt-&gt;cipher),</span><br><span>          cipher_kt_key_si=
ze(kt-&gt;cipher) * 8,</span><br><span>          format_hex(key-&gt;cipher,=
 cipher_kt_key_size(kt-&gt;cipher), 0, &amp;gc));</span><br><span>     dmsg=
(D_SHOW_KEY_SOURCE, &quot;%s (hmac, %s, %d bits): %s&quot;, prefix, md_kt_n=
ame(kt-&gt;digest),</span><br><span>@@ -1280,10 +1275,6 @@</span><br><span>=
     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> const c=
har *</span><br><span> print_key_filename(const char *str, bool is_inline)<=
/span><br><span> {</span><br><span>@@ -1756,7 +1747,7 @@</span><br><span> v=
oid</span><br><span> print_cipher(const char *ciphername)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;%s =
 (%d bit key, &quot;, cipher_kt_name(ciphername), cipher_kt_key_size(cipher=
name) * 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prin=
tf(&quot;%s  (%zu bit key, &quot;, cipher_kt_name(ciphername), cipher_kt_ke=
y_size(ciphername) * 8);</span><br><span> </span><br><span>     if (cipher_=
kt_block_size(ciphername) =3D=3D 1)</span><br><span>     {</span><br><span>=
@@ -1764,7 +1755,7 @@</span><br><span>     }</span><br><span>     else</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     printf(&quot;%d bit block&quot;, cipher_kt_block_size(ciphername) * 8)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        printf(&qu=
ot;%zu bit block&quot;, cipher_kt_block_size(ciphername) * 8);</span><br><s=
pan>     }</span><br><span> </span><br><span>     if (!cipher_kt_mode_cbc(c=
iphername))</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn=
/crypto.h</span><br><span>index 1744653..cb7450f 100644</span><br><span>---=
 a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><b=
r><span>@@ -165,13 +165,13 @@</span><br><span>     uint8_t cipher[MAX_CIPHE=
R_KEY_LENGTH];</span><br><span> </span><br><span>     /** Number of bytes s=
et in the cipher key material */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int cipher_size;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    size_t cipher_size;</span><br><span> </span><br><span>     =
/** %Key material for HMAC operations. */</span><br><span>     uint8_t hmac=
[MAX_HMAC_KEY_LENGTH];</span><br><span> </span><br><span>     /** Number of=
 bytes set in the HMac key material */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int hmac_size;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    size_t hmac_size;</span><br><span> </span><br><span>   =
  /** the epoch of the key. Only defined/non zero if key parameters</span><=
br><span>      * represent a data channel epoch key parameters.</span><br><=
span>@@ -549,8 +549,8 @@</span><br><span>  *                      incorrect=
 way as all previous OpenVPN versions did, to</span><br><span>  *          =
            end up with identical numbers for OCC compatibility</span><br><=
span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int=
 calculate_crypto_overhead(const struct key_type *kt, unsigned int pkt_id_s=
ize,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                      bool occ);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+size_t calculate_crypto_overhead(const struct key_type *kt, un=
signed int pkt_id_size,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                 bool occ);</span><br><span> </span><br=
><span> /** Return the worst-case OpenVPN crypto overhead (in bytes) */</sp=
an><br><span> unsigned int crypto_max_overhead(void);</span><br><span>diff =
--git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h</span><=
br><span>index 5248614..81ff9e7 100644</span><br><span>--- a/src/openvpn/cr=
ypto_backend.h</span><br><span>+++ b/src/openvpn/crypto_backend.h</span><br=
><span>@@ -251,7 +251,7 @@</span><br><span>  *</span><br><span>  * @return =
             (Default) size of keys used by the cipher, in bytes.</span><br=
><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int cipher=
_kt_key_size(const char *ciphername);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+size_t cipher_kt_key_size(const char *ciphername);</span>=
<br><span> </span><br><span> /**</span><br><span>  * Returns the size of th=
e IV used by the cipher, in bytes, or 0 if no IV is</span><br><span>@@ -262=
,7 +262,7 @@</span><br><span>  * @return              Size of the IV, in by=
tes, or 0 if the cipher does not</span><br><span>  *                      u=
se an IV.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-int cipher_kt_iv_size(const char *ciphername);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+size_t cipher_kt_iv_size(const char *ci=
phername);</span><br><span> </span><br><span> /**</span><br><span>  * Retur=
ns the block size of the cipher, in bytes.</span><br><span>@@ -271,7 +271,7=
 @@</span><br><span>  *</span><br><span>  * @return              Block size=
, in bytes.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-int cipher_kt_block_size(const char *ciphername);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+size_t cipher_kt_block_size(const =
char *ciphername);</span><br><span> </span><br><span> /**</span><br><span> =
 * Returns the MAC tag size of the cipher, in bytes.</span><br><span>@@ -28=
1,7 +281,7 @@</span><br><span>  * @return              Tag size in bytes, o=
r 0 if the tag size could not be</span><br><span>  *                      d=
etermined.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-int cipher_kt_tag_size(const char *ciphername);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+size_t cipher_kt_tag_size(const char =
*ciphername);</span><br><span> </span><br><span> /**</span><br><span>  * Re=
turns true if we consider this cipher to be insecure.</span><br><span>@@ -3=
58,7 +358,7 @@</span><br><span>  * @return              Size of the IV, in =
bytes, or \c 0 if the cipher does not</span><br><span>  *                  =
    use an IV.</span><br><span>  */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-int cipher_ctx_iv_length(const cipher_ctx_t *ctx);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+unsigned int cipher_ctx_iv_len=
gth(const cipher_ctx_t *ctx);</span><br><span> </span><br><span> /**</span>=
<br><span>  * Gets the computed message authenticated code (MAC) tag for th=
is cipher.</span><br><span>@@ -376,7 +376,7 @@</span><br><span>  *</span><b=
r><span>  * @return              Block size, in bytes, or 0 if ctx was NULL=
.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-int cipher_ctx_block_size(const cipher_ctx_t *ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+unsigned int cipher_ctx_block_size(const =
cipher_ctx_t *ctx);</span><br><span> </span><br><span> /**</span><br><span>=
  * Returns the mode that the cipher runs in.</span><br><span>diff --git a/=
src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c</span><br><span>ind=
ex f04ba4b4..54225bf 100644</span><br><span>--- a/src/openvpn/crypto_epoch.=
c</span><br><span>+++ b/src/openvpn/crypto_epoch.c</span><br><span>@@ -39,1=
7 +39,18 @@</span><br><span> #include &quot;integer.h&quot;</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, int info_le=
n, uint8_t *out,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
            int out_len)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, size_t in=
fo_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
     uint8_t *out, size_t out_len)</span><br><span> {</span><br><span>     =
hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();</span><br><span>     hmac_ctx_init=
(hmac_ctx, secret, &quot;SHA256&quot;);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const int digest_size =3D SHA256_DI=
GEST_LENGTH;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(info_len &lt;=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const unsigned int digest_size =3D SHA256_DIGEST_LENGTH;</sp=
an><br><span> </span><br><span>     /* T(0) =3D empty string */</span><br><=
span>     uint8_t t_prev[SHA256_DIGEST_LENGTH];</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int t_prev_len =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int t_prev_len =3D 0;</span>=
<br><span> </span><br><span>     for (uint8_t block =3D 1; (block - 1) * di=
gest_size &lt; out_len; block++)</span><br><span>     {</span><br><span>@@ =
-57,14 +58,14 @@</span><br><span> </span><br><span>         /* calculate T(=
block) */</span><br><span>         hmac_ctx_update(hmac_ctx, t_prev, t_prev=
_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hmac_ct=
x_update(hmac_ctx, info, info_len);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        hmac_ctx_update(hmac_ctx, info, (int)info_len);</sp=
an><br><span>         hmac_ctx_update(hmac_ctx, &amp;block, 1);</span><br><=
span>         hmac_ctx_final(hmac_ctx, t_prev);</span><br><span>         t_=
prev_len =3D digest_size;</span><br><span> </span><br><span>         /* Cop=
y a full hmac output or remaining bytes */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        int out_offset =3D (block - 1) * digest_size;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int copylen =
=3D min_int(digest_size, out_len - out_offset);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        size_t out_offset =3D (block - 1) * dig=
est_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        si=
ze_t copylen =3D min_size(digest_size, out_len - out_offset);</span><br><sp=
an> </span><br><span>         memcpy(out + out_offset, t_prev, copylen);</s=
pan><br><span>     }</span><br><span>@@ -72,14 +73,9 @@</span><br><span>   =
  hmac_ctx_free(hmac_ctx);</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> bool</span><br><span> ovpn_expand_label(=
const uint8_t *secret, size_t secret_len, const uint8_t *label, size_t labe=
l_len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
   const uint8_t *context, size_t context_len, uint8_t *out, int out_len)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  con=
st uint8_t *context, size_t context_len, uint8_t *out, size_t out_len)</spa=
n><br><span> {</span><br><span>     if (secret_len !=3D 32 || label_len &gt=
; 250 || context_len &gt; 255 || label_len &lt; 1)</span><br><span>     {</=
span><br><span>@@ -89,7 +85,7 @@</span><br><span>          * need need to b=
e in range */</span><br><span>         return false;</span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(out_len &g=
t;=3D 0 &amp;&amp; out_len &lt;=3D UINT16_MAX);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ASSERT(out_len &lt;=3D UINT16_MAX);</span><=
br><span> </span><br><span>     struct gc_arena gc =3D gc_new();</span><br>=
<span>     /* 2 byte for the outlen encoded as uint16, 5 bytes for &quot;ov=
pn &quot;,</span><br><span>@@ -111,18 +107,14 @@</span><br><span>         b=
uf_write(&amp;hkdf_label, context, context_len);</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASS=
ERT(buf_len(&amp;hkdf_label) =3D=3D hkdf_label_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_len(&amp;hkdf_label) =3D=
=3D (int)hkdf_label_len);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ovpn_hkdf_expand(secret, buf_bptr(&amp;hkdf_label=
), buf_len(&amp;hkdf_label), out, out_len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ovpn_hkdf_expand(secret, buf_bptr(&amp;hkdf_lab=
el), hkdf_label_len, out, out_len);</span><br><span> </span><br><span>     =
gc_free(&amp;gc);</span><br><span>     return true;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> /**</span><br><span>  * Iterates the epoch key to mak=
e it E_n+1, ie increase the epoch by one</span><br><span>  * and derive the=
 new key material accordingly</span><br><span>diff --git a/src/openvpn/cryp=
to_epoch.h b/src/openvpn/crypto_epoch.h</span><br><span>index 2b3d345..0fb7=
6d5 100644</span><br><span>--- a/src/openvpn/crypto_epoch.h</span><br><span=
>+++ b/src/openvpn/crypto_epoch.h</span><br><span>@@ -38,8 +38,8 @@</span><=
br><span>  *  @param out      output keying material</span><br><span>  *  @=
param out_len  length of output keying material</span><br><span>  */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void ovpn_hkdf_expand(const =
uint8_t *secret, const uint8_t *info, int info_len, uint8_t *out,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                      int out_l=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void ovpn_hkdf_=
expand(const uint8_t *secret, const uint8_t *info, size_t info_len,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                      uint8=
_t *out, size_t out_len);</span><br><span> </span><br><span> /**</span><br>=
<span>  * Variant of the RFC 8446 TLS 1.3  HKDF-Expand-Label function with =
the</span><br><span>@@ -59,8 +59,8 @@</span><br><span>  * @return</span><br=
><span>  */</span><br><span> bool ovpn_expand_label(const uint8_t *secret, =
size_t secret_len, const uint8_t *label,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                       size_t label_len, const uint8_t *=
context, size_t context_len, uint8_t *out,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                       int out_len);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                       size_t label_l=
en, const uint8_t *context, size_t context_len,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                       uint8_t *out, size_t out=
_len);</span><br><span> </span><br><span> /**</span><br><span>  * Generate =
a data channel key pair from the epoch key</span><br><span>diff --git a/src=
/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>in=
dex 5418df9..a81b190 100644</span><br><span>--- a/src/openvpn/crypto_mbedtl=
s.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -=
160,7 +160,7 @@</span><br><span>     if (cipher_info-&gt;key_bytes &gt; MAX=
_CIPHER_KEY_LENGTH)</span><br><span>     {</span><br><span>         msg(D_L=
OW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;=
Cipher algorithm &#39;%s&#39; uses a default key size (%d bytes) &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;Ciphe=
r algorithm &#39;%s&#39; uses a default key size (%u bytes) &quot;</span><b=
r><span>             &quot;which is larger than &quot; PACKAGE_NAME &quot;&=
#39;s current maximum key size &quot;</span><br><span>             &quot;(%=
d bytes)&quot;,</span><br><span>             ciphername, cipher_info-&gt;ke=
y_bytes, MAX_CIPHER_KEY_LENGTH);</span><br><span>@@ -183,7 +183,7 @@</span>=
<br><span>     return cipher_info-&gt;name;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span> cipher_k=
t_key_size(const char *ciphername)</span><br><span> {</span><br><span>     =
const cipher_info_t *cipher_info =3D cipher_get(ciphername);</span><br><spa=
n>@@ -194,7 +194,7 @@</span><br><span>     return cipher_info-&gt;key_bytes=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+size_t</span><br><span> cipher_kt_iv_size(const char *ciphername)</span><b=
r><span> {</span><br><span>     const cipher_info_t *cipher_info =3D cipher=
_get(ciphername);</span><br><span>@@ -206,7 +206,7 @@</span><br><span>     =
return cipher_info-&gt;iv_bytes;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span> cipher_kt_block_s=
ize(const char *ciphername)</span><br><span> {</span><br><span>     const c=
ipher_info_t *cipher_info =3D cipher_get(ciphername);</span><br><span>@@ -2=
17,7 +217,7 @@</span><br><span>     return cipher_info-&gt;block_size;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_=
t</span><br><span> cipher_kt_tag_size(const char *ciphername)</span><br><sp=
an> {</span><br><span>     if (cipher_kt_mode_aead(ciphername))</span><br><=
span>@@ -310,20 +310,20 @@</span><br><span> </span><br><span>     psa_set_k=
ey_type(&amp;ctx-&gt;key_attributes, ctx-&gt;cipher_info-&gt;psa_key_type);=
</span><br><span>     psa_set_key_algorithm(&amp;ctx-&gt;key_attributes, ct=
x-&gt;cipher_info-&gt;psa_alg);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    psa_set_key_bits(&amp;ctx-&gt;key_attributes, (size_t)ctx-&gt=
;cipher_info-&gt;key_bytes * 8);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    psa_set_key_bits(&amp;ctx-&gt;key_attributes, ctx-&gt;ciph=
er_info-&gt;key_bytes * 8);</span><br><span>     psa_set_key_usage_flags(&a=
mp;ctx-&gt;key_attributes,</span><br><span>                             enc=
 =3D=3D OPENVPN_OP_ENCRYPT ? PSA_KEY_USAGE_ENCRYPT : PSA_KEY_USAGE_DECRYPT)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (psa_import_key(&amp;ctx-&gt;key_attributes, key, (size_t)ctx-&gt;ciph=
er_info-&gt;key_bytes, &amp;ctx-&gt;key) !=3D PSA_SUCCESS)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (psa_import_key(&amp;ctx-&gt;=
key_attributes, key, ctx-&gt;cipher_info-&gt;key_bytes, &amp;ctx-&gt;key) !=
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
pan>index f9b7ae6..e099fa4 100644</span><br><span>--- a/src/openvpn/crypto_=
mbedtls_legacy.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy.c<=
/span><br><span>@@ -236,7 +236,6 @@</span><br><span> #if defined(__GNUC__) =
|| defined(__clang__)</span><br><span> #pragma GCC diagnostic push</span><b=
r><span> #pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &=
quot;-Wsign-compare&quot;</span><br><span> #endif</span><br><span> </span><=
br><span> bool</span><br><span>@@ -456,7 +455,7 @@</span><br><span>     ret=
urn translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(cipher_kt=
));</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+size_t</span><br><span> cipher_kt_key_size(const char *ciphername)</span=
><br><span> {</span><br><span>     const mbedtls_cipher_info_t *cipher_kt =
=3D cipher_get(ciphername);</span><br><span>@@ -466,10 +465,10 @@</span><br=
><span>         return 0;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)mbedtls_cipher=
_info_get_key_bitlen(cipher_kt) / 8;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return mbedtls_cipher_info_get_key_bitlen(cipher_kt) /=
 8;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+size_t</span><br><span> cipher_kt_iv_size(const char *ciphername)</span>=
<br><span> {</span><br><span>     const mbedtls_cipher_info_t *cipher_kt =
=3D cipher_get(ciphername);</span><br><span>@@ -478,10 +477,10 @@</span><br=
><span>     {</span><br><span>         return 0;</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)mbedtls_c=
ipher_info_get_iv_size(cipher_kt);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return mbedtls_cipher_info_get_iv_size(cipher_kt);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t=
</span><br><span> cipher_kt_block_size(const char *ciphername)</span><br><s=
pan> {</span><br><span>     const mbedtls_cipher_info_t *cipher_kt =3D ciph=
er_get(ciphername);</span><br><span>@@ -489,10 +488,10 @@</span><br><span> =
    {</span><br><span>         return 0;</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return (int)mbedtls_cipher_in=
fo_get_block_size(cipher_kt);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return mbedtls_cipher_info_get_block_size(cipher_kt);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t</=
span><br><span> cipher_kt_tag_size(const char *ciphername)</span><br><span>=
 {</span><br><span>     if (cipher_kt_mode_aead(ciphername))</span><br><spa=
n>@@ -605,10 +604,10 @@</span><br><span>     }</span><br><span> </span><br>=
<span>     /* make sure we used a big enough key */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mbedtls_cipher_get_key_bitlen(ct=
x) &lt;=3D key_bitlen);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ASSERT((size_t)mbedtls_cipher_get_key_bitlen(ctx) &lt;=3D key_bitle=
n);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+unsigned int</span><br><span> cipher_ctx_iv_length(const mbedtls_cipher_=
context_t *ctx)</span><br><span> {</span><br><span>     return mbedtls_ciph=
er_get_iv_size(ctx);</span><br><span>@@ -617,7 +616,7 @@</span><br><span> i=
nt</span><br><span> cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int=
 tag_len)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (tag_len &gt; SIZE_MAX)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (tag_len &lt; 0)</span><br><span>     {</span><br>=
<span>         return 0;</span><br><span>     }</span><br><span>@@ -630,10 =
+629,10 @@</span><br><span>     return 1;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span> ciph=
er_ctx_block_size(const mbedtls_cipher_context_t *ctx)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)mbedtls=
_cipher_get_block_size(ctx);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return mbedtls_cipher_get_block_size(ctx);</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br><span>@@ -689,7 +688,7 @@<=
/span><br><span> int</span><br><span> cipher_ctx_update_ad(cipher_ctx_t *ct=
x, const uint8_t *src, int src_len)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (src_len &gt; SIZE_MAX)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (src_len &lt; 0)</span><=
br><span>     {</span><br><span>         return 0;</span><br><span>     }</=
span><br><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/cryp=
to_openssl.c</span><br><span>index 9576cb2..abb6cbf 100644</span><br><span>=
--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto=
_openssl.c</span><br><span>@@ -669,25 +669,27 @@</span><br><span>     retur=
n translate_cipher_name_to_openvpn(name);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span> cipher_kt_=
key_size(const char *ciphername)</span><br><span> {</span><br><span>     ev=
p_cipher_type *cipher =3D cipher_get(ciphername);</span><br><span>     int =
size =3D EVP_CIPHER_key_length(cipher);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASSERT(size &gt;=3D 0);</span><br><span>     EVP_CI=
PHER_free(cipher);</span><br><span>     return size;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span>=
 cipher_kt_iv_size(const char *ciphername)</span><br><span> {</span><br><sp=
an>     evp_cipher_type *cipher =3D cipher_get(ciphername);</span><br><span=
>     int ivsize =3D EVP_CIPHER_iv_length(cipher);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ASSERT(ivsize &gt;=3D 0);</span><br><spa=
n>     EVP_CIPHER_free(cipher);</span><br><span>     return ivsize;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t</=
span><br><span> cipher_kt_block_size(const char *ciphername)</span><br><spa=
n> {</span><br><span>     /*</span><br><span>@@ -733,10 +735,11 @@</span><b=
r><span>     EVP_CIPHER_free(cbc_cipher);</span><br><span>     EVP_CIPHER_f=
ree(cipher);</span><br><span>     free(name);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(block_size &gt;=3D 0);</span><br><span=
>     return block_size;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+size_t</span><br><span> cipher_kt_tag_size(const ch=
ar *ciphername)</span><br><span> {</span><br><span>     if (cipher_kt_mode_=
aead(ciphername))</span><br><span>@@ -872,7 +875,7 @@</span><br><span>     =
EVP_CIPHER_free(kt);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+unsigned int</span><br><span> cipher_ctx_iv_length(cons=
t EVP_CIPHER_CTX *ctx)</span><br><span> {</span><br><span>     return EVP_C=
IPHER_CTX_iv_length(ctx);</span><br><span>@@ -884,7 +887,7 @@</span><br><sp=
an>     return EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_GET_TAG, tag_size, ta=
g_buf);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+unsigned int</span><br><span> cipher_ctx_block_size(const EVP_CIPHER=
_CTX *ctx)</span><br><span> {</span><br><span>     return EVP_CIPHER_CTX_bl=
ock_size(ctx);</span><br><span>@@ -1190,11 +1193,6 @@</span><br><span>     =
HMAC_CTX_free(ctx);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> void</span><br><span> hmac_ctx_init(HMAC_CTX *ct=
x, const uint8_t *key, const char *mdname)</span><br><span> {</span><br><sp=
an>@@ -1209,13 +1207,9 @@</span><br><span>     }</span><br><span> </span><b=
r><span>     /* make sure we used a big enough key */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(HMAC_size(ctx) &lt;=3D key_len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT((ssize_t=
)HMAC_size(ctx) &lt;=3D key_len);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> void</span><br><span> hmac_ctx_cleanup(HMAC_CTX *ctx)</span><br><span> =
{</span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_li=
nux.c</span><br><span>index b92fa43..b878428 100644</span><br><span>--- a/s=
rc/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span>=
<br><span>@@ -612,7 +612,8 @@</span><br><span>     msg(D_DCO_DEBUG, &quot;%=
s: slot %d, key-id %d, peer-id %d, cipher %s, epoch %d&quot;, __func__, slo=
t, keyid, peerid,</span><br><span>         ciphername, epoch);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int ke=
y_len =3D cipher_kt_key_size(ciphername);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const size_t key_len =3D cipher_kt_key_size(ciphe=
rname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(k=
ey_len &lt;=3D INT_MAX);</span><br><span>     const int nonce_tail_len =3D =
8;</span><br><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dc=
o_nlmsg_create(dco, OVPN_CMD_KEY_NEW);</span><br><span>@@ -634,7 +635,7 @@<=
/span><br><span>     struct nlattr *key_enc =3D nla_nest_start(nl_msg, OVPN=
_A_KEYCONF_ENCRYPT_DIR);</span><br><span>     if (dco_cipher !=3D OVPN_CIPH=
ER_ALG_NONE)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, key_len, en=
crypt_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, (int)key_len, encrypt_key);</span=
><br><span>         NLA_PUT(nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, nonce_tail_le=
n, encrypt_iv);</span><br><span>     }</span><br><span>     nla_nest_end(nl=
_msg, key_enc);</span><br><span>@@ -642,7 +643,7 @@</span><br><span>     st=
ruct nlattr *key_dec =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF_DECRYPT_DIR)=
;</span><br><span>     if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        N=
LA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, key_len, decrypt_key);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        NLA_PUT(nl_msg, OVPN_A_=
KEYDIR_CIPHER_KEY, (int)key_len, decrypt_key);</span><br><span>         NLA=
_PUT(nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, nonce_tail_len, decrypt_iv);</span><=
br><span>     }</span><br><span>     nla_nest_end(nl_msg, key_dec);</span><=
br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><=
br><span>index 334ea64..278ca2f 100644</span><br><span>--- a/src/openvpn/op=
tions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -444=
8,7 +4448,7 @@</span><br><span>         /* Skip resolving BF-CBC to allow S=
SL libraries without BF-CBC</span><br><span>          * to work here in the=
 default configuration */</span><br><span>         const char *ciphername =
=3D o-&gt;ciphername;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        int keysize =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        size_t keysize =3D 0;</span><br><span> </span><br><span>    =
     if (strcmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</span><br><=
span>         {</span><br><span>@@ -4471,7 +4471,7 @@</span><br><span>     =
        buf_printf(&amp;out, &quot;,cipher %s&quot;, ciphername);</span><br=
><span>         }</span><br><span>         buf_printf(&amp;out, &quot;,auth=
 %s&quot;, md_kt_name(kt.digest));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        buf_printf(&amp;out, &quot;,keysize %d&quot;, keysize)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf=
(&amp;out, &quot;,keysize %zu&quot;, keysize);</span><br><span>         if =
(o-&gt;shared_secret_file)</span><br><span>         {</span><br><span>     =
        buf_printf(&amp;out, &quot;,secret&quot;);</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1508?usp=3Demail">change 1508</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/15=
08?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1bc576c4c7ffacbb9300608d98b=
06b22f2475fd9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1508 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--a6FOwGWUI4U=--

