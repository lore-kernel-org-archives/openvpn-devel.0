From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 19:06:45 +0100
Message-Id: <20211207180645.3281514-1-arne@...1227...>
In-Reply-To: <20211201180727.2496903-1-arne@...1227...>
References: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 7/9] Remove cipher_kt_t and change type
 to const char* in API
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

Make the external crypto consumer oblivious to the internal cipher
type that both mbed TLS and OpenSSL use. This change is mainly done
so the cipher type that is used can be stay a const type but instead
of an SSL library type, we now use a simple string to identify a
cipher. This has the disadvantages that we do a cipher lookup every
time a function is called that needs to query properties of a cipher.
But none of these queries are in a critical path.

This patch also fixes the memory leaks introduced by the
EVP_fetch_cipher commit by always freeing the EVP_CIPHER.

This also changes kt->cipher to be always defined with the name of
the cipher. This only affects the "none" cipher cipher which was
previously represented by kt->cipher to be NULL.

Patch v2: rebase on master

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/auth_token.c               |   2 +-
 src/openvpn/crypto.c                   |  32 +++---
 src/openvpn/crypto.h                   |   4 +-
 src/openvpn/crypto_backend.h           |  65 ++++++-----
 src/openvpn/crypto_mbedtls.c           |  83 +++++++++-----
 src/openvpn/crypto_mbedtls.h           |   3 -
 src/openvpn/crypto_openssl.c           | 152 ++++++++++++++++++-------
 src/openvpn/crypto_openssl.h           |  13 ++-
 src/openvpn/init.c                     |  13 ++-
 src/openvpn/openssl_compat.h           |   7 ++
 src/openvpn/openvpn.h                  |   2 -
 src/openvpn/options.c                  |   9 +-
 src/openvpn/ssl.c                      |   4 +-
 src/openvpn/ssl_ncp.c                  |  24 ++--
 src/openvpn/tls_crypt.c                |   4 +-
 tests/unit_tests/openvpn/test_crypto.c |   4 +-
 tests/unit_tests/openvpn/test_ncp.c    |   6 +-
 17 files changed, 267 insertions(+), 160 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 5d5cea7f6..5c947004e 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -35,7 +35,7 @@ auth_token_kt(void)
 {
     struct key_type kt = { 0 };
     /* We do not encrypt our session tokens */
-    kt.cipher = NULL;
+    kt.cipher = "none";
     kt.digest = md_kt_get("SHA256");
 
     if (!kt.digest)
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index a63a26195..0b47dec44 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -680,7 +680,7 @@ crypto_adjust_frame_parameters(struct frame *frame,
         crypto_overhead += packet_id_size(packet_id_long_form);
     }
 
-    if (kt->cipher)
+    if (cipher_defined(kt->cipher))
     {
         crypto_overhead += cipher_kt_iv_size(kt->cipher);
 
@@ -710,16 +710,16 @@ crypto_max_overhead(void)
 }
 
 static void
-warn_insecure_key_type(const char *ciphername, const cipher_kt_t *cipher)
+warn_insecure_key_type(const char *ciphername)
 {
-    if (cipher_kt_insecure(cipher))
+    if (cipher_kt_insecure(ciphername))
     {
         msg(M_WARN, "WARNING: INSECURE cipher (%s) with block size less than 128"
             " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
             "using a --cipher with a larger block size (e.g. AES-256-CBC). "
             "Support for these insecure ciphers will be removed in "
             "OpenVPN 2.6.",
-            ciphername, cipher_kt_block_size(cipher)*8);
+            ciphername, cipher_kt_block_size(ciphername)*8);
     }
 }
 
@@ -736,10 +736,10 @@ init_key_type(struct key_type *kt, const char *ciphername,
     ASSERT(authname);
 
     CLEAR(*kt);
+    kt->cipher = ciphername;
     if (strcmp(ciphername, "none") != 0)
     {
-        kt->cipher = cipher_kt_get(ciphername);
-        if (!kt->cipher)
+        if (!cipher_valid(ciphername))
         {
             msg(M_FATAL, "Cipher %s not supported", ciphername);
         }
@@ -762,7 +762,7 @@ init_key_type(struct key_type *kt, const char *ciphername,
         }
         if (warn)
         {
-            warn_insecure_key_type(ciphername, kt->cipher);
+            warn_insecure_key_type(ciphername);
         }
     }
     else
@@ -809,7 +809,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
 {
     struct gc_arena gc = gc_new();
     CLEAR(*ctx);
-    if (kt->cipher)
+    if (cipher_defined(kt->cipher))
     {
 
         ctx->cipher = cipher_ctx_new();
@@ -824,7 +824,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
         dmsg(D_CRYPTO_DEBUG, "%s: CIPHER block_size=%d iv_size=%d",
              prefix, cipher_kt_block_size(kt->cipher),
              cipher_kt_iv_size(kt->cipher));
-        warn_insecure_key_type(ciphername, kt->cipher);
+        warn_insecure_key_type(ciphername);
     }
     if (kt->digest)
     {
@@ -912,7 +912,7 @@ key_is_zero(struct key *key, const struct key_type *kt)
 bool
 check_key(struct key *key, const struct key_type *kt)
 {
-    if (kt->cipher)
+    if (cipher_defined(kt->cipher))
     {
         /*
          * Check for zero key
@@ -1622,22 +1622,22 @@ get_random(void)
 }
 
 void
-print_cipher(const cipher_kt_t *cipher)
+print_cipher(const char *ciphername)
 {
     printf("%s  (%d bit key, ",
-           cipher_kt_name(cipher),
-           cipher_kt_key_size(cipher) * 8);
+           cipher_kt_name(ciphername),
+           cipher_kt_key_size(ciphername) * 8);
 
-    if (cipher_kt_block_size(cipher) == 1)
+    if (cipher_kt_block_size(ciphername) == 1)
     {
         printf("stream cipher");
     }
     else
     {
-        printf("%d bit block", cipher_kt_block_size(cipher) * 8);
+        printf("%d bit block", cipher_kt_block_size(ciphername) * 8);
     }
 
-    if (!cipher_kt_mode_cbc(cipher))
+    if (!cipher_kt_mode_cbc(ciphername))
     {
         printf(", TLS client/server mode only");
     }
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 1e2ca3cb0..af94b0eb5 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -138,7 +138,7 @@ struct sha256_digest {
  */
 struct key_type
 {
-    const cipher_kt_t *cipher;  /**< Cipher static parameters */
+    const char *cipher;         /**< const name of the cipher */
     const md_kt_t *digest;      /**< Message digest static parameters */
 };
 
@@ -473,7 +473,7 @@ void prng_bytes(uint8_t *output, int len);
 long int get_random(void);
 
 /** Print a cipher list entry */
-void print_cipher(const cipher_kt_t *cipher);
+void print_cipher(const char *cipher);
 
 void test_crypto(struct crypto_options *co, struct frame *f);
 
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index cc3e40400..881164f43 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -200,102 +200,105 @@ void cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
  *                      for the given cipher, or NULL if no matching parameters
  *                      were found.
  */
-const cipher_kt_t *cipher_kt_get(const char *ciphername);
+bool cipher_valid(const char *ciphername);
 
 /**
- * Retrieve a string describing the cipher (e.g. \c AES-128-CBC).
+ * Checks if the cipher is defined and is not the null (none) cipher
+ *
+ * @param ciphername
+ * @return
+ */
+static inline bool cipher_defined(const char* ciphername)
+{
+    return strcmp(ciphername, "none") != 0;
+}
+
+/**
+ * Retrieve a normalised string describing the cipher (e.g. \c AES-128-CBC).
  * The returned name is normalised to the OpenVPN config name in case the
  * name differs from the name used by the crypto library.
  *
- * Returns [null-cipher] in case the cipher_kt is NULL.
+ * Returns [null-cipher] in case the ciphername is none. NULL if the cipher
+ * is not valid.
  *
- * @param cipher_kt     Static cipher parameters
+ * @param cipher_kt     Name of the cipher
  *
  * @return a statically allocated string describing the cipher.
  */
-const char *cipher_kt_name(const cipher_kt_t *cipher_kt);
+const char *cipher_kt_name(const char *ciphername);
 
 /**
  * Returns the size of keys used by the cipher, in bytes. If the cipher has a
  * variable key size, return the default key size.
  *
- * @param cipher_kt     Static cipher parameters
+ * @param ciphername    Cipher name to lookup
  *
  * @return              (Default) size of keys used by the cipher, in bytes.
  */
-int cipher_kt_key_size(const cipher_kt_t *cipher_kt);
+int cipher_kt_key_size(const char *ciphername);
 
 /**
  * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV is
  * used.
  *
- * @param cipher_kt     Static cipher parameters
+ * @param ciphername    cipher name to lookup
  *
  * @return              Size of the IV, in bytes, or 0 if the cipher does not
  *                      use an IV.
  */
-int cipher_kt_iv_size(const cipher_kt_t *cipher_kt);
+int cipher_kt_iv_size(const char *ciphername);
 
 /**
  * Returns the block size of the cipher, in bytes.
  *
- * @param cipher_kt     Static cipher parameters
+ * @param ciphername    cipher name
  *
  * @return              Block size, in bytes.
  */
-int cipher_kt_block_size(const cipher_kt_t *cipher_kt);
+int cipher_kt_block_size(const char *ciphername);
 
 /**
  * Returns the MAC tag size of the cipher, in bytes.
  *
- * @param ctx           Static cipher parameters.
+ * @param ciphername    Name of the cipher
  *
  * @return              Tag size in bytes, or 0 if the tag size could not be
  *                      determined.
  */
-int cipher_kt_tag_size(const cipher_kt_t *cipher_kt);
+int cipher_kt_tag_size(const char *ciphername);
 
 /**
  * Returns true if we consider this cipher to be insecure.
  */
-bool cipher_kt_insecure(const cipher_kt_t *cipher);
+bool cipher_kt_insecure(const char *ciphername);
 
-/**
- * Returns the mode that the cipher runs in.
- *
- * @param cipher_kt     Static cipher parameters. May not be NULL.
- *
- * @return              Cipher mode, either \c OPENVPN_MODE_CBC, \c
- *                      OPENVPN_MODE_OFB or \c OPENVPN_MODE_CFB
- */
-int cipher_kt_mode(const cipher_kt_t *cipher_kt);
 
 /**
  * Check if the supplied cipher is a supported CBC mode cipher.
  *
- * @param cipher        Static cipher parameters.
+ * @param ciphername    cipher name
  *
  * @return              true iff the cipher is a CBC mode cipher.
  */
-bool cipher_kt_mode_cbc(const cipher_kt_t *cipher);
+bool cipher_kt_mode_cbc(const char *ciphername);
 
 /**
  * Check if the supplied cipher is a supported OFB or CFB mode cipher.
  *
- * @param cipher        Static cipher parameters.
+ * @param ciphername    cipher name
  *
  * @return              true iff the cipher is a OFB or CFB mode cipher.
  */
-bool cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher);
+bool cipher_kt_mode_ofb_cfb(const char *ciphername);
 
 /**
  * Check if the supplied cipher is a supported AEAD mode cipher.
  *
- * @param cipher        Static cipher parameters.
+ * @param cipher        name of the cipher
  *
  * @return              true iff the cipher is a AEAD mode cipher.
  */
-bool cipher_kt_mode_aead(const cipher_kt_t *cipher);
+bool cipher_kt_mode_aead(const char *ciphername);
 
 
 /**
@@ -323,12 +326,12 @@ void cipher_ctx_free(cipher_ctx_t *ctx);
  *
  * @param ctx           Cipher context. May not be NULL
  * @param key           Buffer containing the key to use
- * @param kt            Static cipher parameters to use
+ * @param ciphername    Ciphername of the cipher to use
  * @param enc           Whether to encrypt or decrypt (either
  *                      \c MBEDTLS_OP_ENCRYPT or \c MBEDTLS_OP_DECRYPT).
  */
 void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key,
-                     const cipher_kt_t *kt, int enc);
+                     const char *cipername, int enc);
 
 /**
  * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV is
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 8acf0e184..445d82bc9 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -169,11 +169,11 @@ show_available_ciphers(void)
 
     while (*ciphers != 0)
     {
-        const cipher_kt_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        if (info && !cipher_kt_insecure(info)
-            && (cipher_kt_mode_aead(info) || cipher_kt_mode_cbc(info)))
+        const mbedtls_cipher_info_t *info = mbedtls_cipher_info_from_type(*ciphers);
+        if (info && !cipher_kt_insecure(info->name)
+            && (cipher_kt_mode_aead(info->name) || cipher_kt_mode_cbc(info->name)))
         {
-            print_cipher(info);
+            print_cipher(info->name);
         }
         ciphers++;
     }
@@ -183,11 +183,11 @@ show_available_ciphers(void)
     ciphers = mbedtls_cipher_list();
     while (*ciphers != 0)
     {
-        const cipher_kt_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        if (info && cipher_kt_insecure(info)
-            && (cipher_kt_mode_aead(info) || cipher_kt_mode_cbc(info)))
+        const mbedtls_cipher_info_t *info = mbedtls_cipher_info_from_type(*ciphers);
+        if (info && cipher_kt_insecure(info->name)
+            && (cipher_kt_mode_aead(info->name) || cipher_kt_mode_cbc(info->name)))
         {
-            print_cipher(info);
+            print_cipher(info->name);
         }
         ciphers++;
     }
@@ -390,17 +390,22 @@ rand_bytes(uint8_t *output, int len)
  * Generic cipher key type functions
  *
  */
-
-
-const mbedtls_cipher_info_t *
-cipher_kt_get(const char *ciphername)
+static const mbedtls_cipher_info_t *
+cipher_get(const char* ciphername)
 {
-    const mbedtls_cipher_info_t *cipher = NULL;
-
     ASSERT(ciphername);
 
+    const mbedtls_cipher_info_t *cipher = NULL;
+
     ciphername = translate_cipher_name_from_openvpn(ciphername);
     cipher = mbedtls_cipher_info_from_string(ciphername);
+    return cipher;
+}
+
+bool
+cipher_valid(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
 
     if (NULL == cipher)
     {
@@ -416,12 +421,13 @@ cipher_kt_get(const char *ciphername)
         return NULL;
     }
 
-    return cipher;
+    return cipher != NULL;
 }
 
 const char *
-cipher_kt_name(const mbedtls_cipher_info_t *cipher_kt)
+cipher_kt_name(const char *ciphername)
 {
+    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
     if (NULL == cipher_kt)
     {
         return "[null-cipher]";
@@ -431,8 +437,10 @@ cipher_kt_name(const mbedtls_cipher_info_t *cipher_kt)
 }
 
 int
-cipher_kt_key_size(const mbedtls_cipher_info_t *cipher_kt)
+cipher_kt_key_size(const char *ciphername)
 {
+    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
+
     if (NULL == cipher_kt)
     {
         return 0;
@@ -442,8 +450,10 @@ cipher_kt_key_size(const mbedtls_cipher_info_t *cipher_kt)
 }
 
 int
-cipher_kt_iv_size(const mbedtls_cipher_info_t *cipher_kt)
+cipher_kt_iv_size(const char *ciphername)
 {
+    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
+
     if (NULL == cipher_kt)
     {
         return 0;
@@ -452,8 +462,9 @@ cipher_kt_iv_size(const mbedtls_cipher_info_t *cipher_kt)
 }
 
 int
-cipher_kt_block_size(const mbedtls_cipher_info_t *cipher_kt)
+cipher_kt_block_size(const char *ciphername)
 {
+    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
     if (NULL == cipher_kt)
     {
         return 0;
@@ -462,9 +473,9 @@ cipher_kt_block_size(const mbedtls_cipher_info_t *cipher_kt)
 }
 
 int
-cipher_kt_tag_size(const mbedtls_cipher_info_t *cipher_kt)
+cipher_kt_tag_size(const char *ciphername)
 {
-    if (cipher_kt && cipher_kt_mode_aead(cipher_kt))
+    if (cipher_kt_mode_aead(ciphername))
     {
         return OPENVPN_AEAD_TAG_LENGTH;
     }
@@ -472,16 +483,22 @@ cipher_kt_tag_size(const mbedtls_cipher_info_t *cipher_kt)
 }
 
 bool
-cipher_kt_insecure(const mbedtls_cipher_info_t *cipher_kt)
+cipher_kt_insecure(const char *ciphername)
 {
-    return !(cipher_kt_block_size(cipher_kt) >= 128 / 8
+    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
+    if (!cipher_kt)
+    {
+        return true;
+    }
+
+    return !(cipher_kt_block_size(ciphername) >= 128 / 8
 #ifdef MBEDTLS_CHACHAPOLY_C
              || cipher_kt->type == MBEDTLS_CIPHER_CHACHA20_POLY1305
 #endif
              );
 }
 
-int
+static int
 cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
 {
     ASSERT(NULL != cipher_kt);
@@ -489,21 +506,24 @@ cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
 }
 
 bool
-cipher_kt_mode_cbc(const cipher_kt_t *cipher)
+cipher_kt_mode_cbc(const char *ciphername)
 {
+    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
     return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC;
 }
 
 bool
-cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
+cipher_kt_mode_ofb_cfb(const char *ciphername)
 {
+    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
     return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB
                       || cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
 }
 
 bool
-cipher_kt_mode_aead(const cipher_kt_t *cipher)
+cipher_kt_mode_aead(const char *ciphername)
 {
+    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
     return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_GCM
 #ifdef MBEDTLS_CHACHAPOLY_C
                       || cipher_kt_mode(cipher) == MBEDTLS_MODE_CHACHAPOLY
@@ -535,12 +555,15 @@ cipher_ctx_free(mbedtls_cipher_context_t *ctx)
 
 void
 cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key,
-                const mbedtls_cipher_info_t *kt, const mbedtls_operation_t operation)
+                const char *ciphername, const mbedtls_operation_t operation)
 {
-    ASSERT(NULL != kt && NULL != ctx);
+    ASSERT(NULL != ciphername && NULL != ctx);
+    CLEAR(*ctx);
+
+    const mbedtls_cipher_info_t *kt = cipher_get(ciphername);
     int key_len = cipher_kt_key_size(kt);
 
-    CLEAR(*ctx);
+    ASSERT(kt);
 
     if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
     {
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index b2e9eceab..b9d03f2f9 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -33,9 +33,6 @@
 #include <mbedtls/md.h>
 #include <mbedtls/ctr_drbg.h>
 
-/** Generic cipher key type %context. */
-typedef mbedtls_cipher_info_t cipher_kt_t;
-
 /** Generic message digest key type %context. */
 typedef mbedtls_md_info_t md_kt_t;
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index e28e2f43a..d1b94dc01 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -311,7 +311,7 @@ cipher_name_cmp(const void *a, const void *b)
     const EVP_CIPHER *const *cipher_a = a;
     const EVP_CIPHER *const *cipher_b = b;
 
-    return strcmp(cipher_kt_name(*cipher_a), cipher_kt_name(*cipher_b));
+    return strcmp(EVP_CIPHER_get0_name(*cipher_a), EVP_CIPHER_get0_name(*cipher_b));
 }
 
 struct collect_ciphers {
@@ -329,11 +329,13 @@ static void collect_ciphers(EVP_CIPHER *cipher, void *list)
         return;
     }
 
-    if (cipher && (cipher_kt_mode_cbc(cipher)
+    const char *ciphername = EVP_CIPHER_get0_name(cipher);
+
+    if (cipher && ciphername && (cipher_kt_mode_cbc(ciphername)
 #ifdef ENABLE_OFB_CFB_MODE
-        || cipher_kt_mode_ofb_cfb(cipher)
+        || cipher_kt_mode_ofb_cfb(ciphername)
 #endif
-        || cipher_kt_mode_aead(cipher)
+        || cipher_kt_mode_aead(ciphername)
     ))
     {
         cipher_list->list[cipher_list->num++] = cipher;
@@ -370,9 +372,9 @@ show_available_ciphers(void)
 
     for (size_t i = 0; i < cipher_list.num; i++)
     {
-        if (!cipher_kt_insecure(cipher_list.list[i]))
+        if (!cipher_kt_insecure(EVP_CIPHER_get0_name(cipher_list.list[i])))
         {
-            print_cipher(cipher_list.list[i]);
+            print_cipher(EVP_CIPHER_get0_name(cipher_list.list[i]));
         }
     }
 
@@ -380,9 +382,9 @@ show_available_ciphers(void)
            "and are therefore deprecated.  Do not use unless you have to.\n\n");
     for (int i = 0; i < cipher_list.num; i++)
     {
-        if (cipher_kt_insecure(cipher_list.list[i]))
+        if (cipher_kt_insecure(EVP_CIPHER_get0_name(cipher_list.list[i])))
         {
-            print_cipher(cipher_list.list[i]);
+            print_cipher(EVP_CIPHER_get0_name(cipher_list.list[i]));
         }
     }
     printf("\n");
@@ -556,11 +558,10 @@ rand_bytes(uint8_t *output, int len)
  *
  */
 
-
-const EVP_CIPHER *
-cipher_kt_get(const char *ciphername)
+static evp_cipher_type *
+cipher_get(const char *ciphername)
 {
-    const EVP_CIPHER *cipher = NULL;
+    evp_cipher_type *cipher = NULL;
 
     ASSERT(ciphername);
 
@@ -569,7 +570,6 @@ cipher_kt_get(const char *ciphername)
 
     if (NULL == cipher)
     {
-        crypto_msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
         return NULL;
     }
 
@@ -590,38 +590,72 @@ cipher_kt_get(const char *ciphername)
             "which is larger than " PACKAGE_NAME "'s current maximum key size "
             "(%d bytes)", ciphername, EVP_CIPHER_key_length(cipher),
             MAX_CIPHER_KEY_LENGTH);
-        return NULL;
+        return false;
     }
 
     return cipher;
 }
 
+bool cipher_valid(const char *ciphername)
+{
+    evp_cipher_type *cipher = cipher_get(ciphername);
+    bool valid = (cipher != NULL);
+    if (!valid)
+    {
+        crypto_msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
+    }
+    EVP_CIPHER_free(cipher);
+    return valid;
+}
+
+bool cipher_var_key_size(const char *ciphername)
+{
+    evp_cipher_type *cipher = cipher_get(ciphername);
+    bool ret = EVP_CIPHER_flags(cipher) & EVP_CIPH_VARIABLE_LENGTH;
+    EVP_CIPHER_free(cipher);
+    return ret;
+}
+
+
 const char *
-cipher_kt_name(const EVP_CIPHER *cipher_kt)
+cipher_kt_name(const char *ciphername)
 {
-    if (NULL == cipher_kt)
+    if (strcmp("none", ciphername) == 0)
     {
         return "[null-cipher]";
     }
 
+    evp_cipher_type *cipher_kt = cipher_get(ciphername);
+    if (!cipher_kt)
+    {
+        return NULL;
+    }
+
     const char *name = EVP_CIPHER_name(cipher_kt);
+    EVP_CIPHER_free(cipher_kt);
     return translate_cipher_name_to_openvpn(name);
 }
 
 int
-cipher_kt_key_size(const EVP_CIPHER *cipher_kt)
+cipher_kt_key_size(const char *ciphername)
 {
-    return EVP_CIPHER_key_length(cipher_kt);
+    evp_cipher_type *cipher = cipher_get(ciphername);
+    int size = EVP_CIPHER_key_length(cipher);
+    EVP_CIPHER_free(cipher);
+    return size;
 }
 
 int
-cipher_kt_iv_size(const EVP_CIPHER *cipher_kt)
+cipher_kt_iv_size(const char *ciphername)
 {
-    return EVP_CIPHER_iv_length(cipher_kt);
+    evp_cipher_type *cipher = cipher_get(ciphername);
+    int ivsize = EVP_CIPHER_iv_length(cipher);
+    EVP_CIPHER_free(cipher);
+    return ivsize;
 }
 
 int
-cipher_kt_block_size(const EVP_CIPHER *cipher)
+cipher_kt_block_size(const char *ciphername)
 {
     /*
      * OpenSSL reports OFB/CFB/GCM cipher block sizes as '1 byte'.  To work
@@ -632,7 +666,12 @@ cipher_kt_block_size(const EVP_CIPHER *cipher)
     char *name = NULL;
     char *mode_str = NULL;
     const char *orig_name = NULL;
-    const EVP_CIPHER *cbc_cipher = NULL;
+    evp_cipher_type *cbc_cipher = NULL;
+    evp_cipher_type *cipher = cipher_get(ciphername);
+    if (!cipher)
+    {
+        return 0;
+    }
 
     int block_size = EVP_CIPHER_block_size(cipher);
 
@@ -651,21 +690,23 @@ cipher_kt_block_size(const EVP_CIPHER *cipher)
 
     strcpy(mode_str, "-CBC");
 
-    cbc_cipher = EVP_CIPHER_fetch(NULL,translate_cipher_name_from_openvpn(name), NULL);
+    cbc_cipher = EVP_CIPHER_fetch(NULL, translate_cipher_name_from_openvpn(name), NULL);
     if (cbc_cipher)
     {
         block_size = EVP_CIPHER_block_size(cbc_cipher);
     }
 
 cleanup:
+    EVP_CIPHER_free(cbc_cipher);
+    EVP_CIPHER_free(cipher);
     free(name);
     return block_size;
 }
 
 int
-cipher_kt_tag_size(const EVP_CIPHER *cipher_kt)
+cipher_kt_tag_size(const char *ciphername)
 {
-    if (cipher_kt_mode_aead(cipher_kt))
+    if (cipher_kt_mode_aead(ciphername))
     {
         return OPENVPN_AEAD_TAG_LENGTH;
     }
@@ -676,13 +717,26 @@ cipher_kt_tag_size(const EVP_CIPHER *cipher_kt)
 }
 
 bool
-cipher_kt_insecure(const EVP_CIPHER *cipher)
+cipher_kt_insecure(const char *ciphername)
 {
-    return !(cipher_kt_block_size(cipher) >= 128 / 8
+
+    if (cipher_kt_block_size(ciphername) >= 128 / 8)
+    {
+        return false;
+    }
 #ifdef NID_chacha20_poly1305
-             || EVP_CIPHER_nid(cipher) == NID_chacha20_poly1305
+    evp_cipher_type *cipher = cipher_get(ciphername);
+    if (cipher)
+    {
+        bool ischachapoly = (EVP_CIPHER_nid(cipher) == NID_chacha20_poly1305);
+        EVP_CIPHER_free(cipher);
+        if (ischachapoly)
+        {
+            return false;
+        }
+    }
 #endif
-             );
+    return true;
 }
 
 int
@@ -693,44 +747,56 @@ cipher_kt_mode(const EVP_CIPHER *cipher_kt)
 }
 
 bool
-cipher_kt_mode_cbc(const cipher_kt_t *cipher)
+cipher_kt_mode_cbc(const char *ciphername)
 {
-    return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC
+    evp_cipher_type *cipher = cipher_get(ciphername);
+
+    bool ret = cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_CBC
            /* Exclude AEAD cipher modes, they require a different API */
 #ifdef EVP_CIPH_FLAG_CTS
            && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_CTS)
 #endif
-           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER);
+           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER));
+    EVP_CIPHER_free(cipher);
+    return ret;
 }
 
 bool
-cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
+cipher_kt_mode_ofb_cfb(const char *ciphername)
 {
-    return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB
+    evp_cipher_type *cipher = cipher_get(ciphername);
+    bool ofb_cfb = cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB
                       || cipher_kt_mode(cipher) == OPENVPN_MODE_CFB)
-           /* Exclude AEAD cipher modes, they require a different API */
-           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER);
+                      /* Exclude AEAD cipher modes, they require a different API */
+                      && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER);
+    EVP_CIPHER_free(cipher);
+    return ofb_cfb;
 }
 
 bool
-cipher_kt_mode_aead(const cipher_kt_t *cipher)
+cipher_kt_mode_aead(const char *ciphername)
 {
+    bool isaead = false;
+
+    evp_cipher_type *cipher = cipher_get(ciphername);
     if (cipher)
     {
         if (EVP_CIPHER_mode(cipher) == OPENVPN_MODE_GCM)
         {
-            return true;
+            isaead = true;
         }
 
 #ifdef NID_chacha20_poly1305
         if (EVP_CIPHER_nid(cipher) == NID_chacha20_poly1305)
         {
-            return true;
+            isaead =  true;
         }
 #endif
     }
 
-    return false;
+    EVP_CIPHER_free(cipher);
+
+    return isaead;
 }
 
 /*
@@ -755,9 +821,10 @@ cipher_ctx_free(EVP_CIPHER_CTX *ctx)
 
 void
 cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key,
-                const EVP_CIPHER *kt, int enc)
+                const char *ciphername, int enc)
 {
-    ASSERT(NULL != kt && NULL != ctx);
+    ASSERT(NULL != ciphername && NULL != ctx);
+    evp_cipher_type *kt = cipher_get(ciphername);
 
     EVP_CIPHER_CTX_reset(ctx);
     if (!EVP_CipherInit(ctx, kt, NULL, NULL, enc))
@@ -769,6 +836,7 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key,
         crypto_msg(M_FATAL, "EVP cipher init #2");
     }
 
+    EVP_CIPHER_free(kt);
     /* make sure we used a big enough key */
     ASSERT(EVP_CIPHER_CTX_key_length(ctx) <= EVP_CIPHER_key_length(kt));
 }
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 6eb16a906..3371d07e7 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -37,10 +37,6 @@
 #include <openssl/provider.h>
 #endif
 
-
-/** Generic cipher key type %context. */
-typedef EVP_CIPHER cipher_kt_t;
-
 /** Generic message digest key type %context. */
 typedef EVP_MD md_kt_t;
 
@@ -66,6 +62,15 @@ typedef struct {
 typedef OSSL_PROVIDER provider_t;
 #endif
 
+/* In OpenSSL 3.0 the method that returns EVP_CIPHER, the cipher needs to be
+ * freed afterwards, thus needing a non-const type. In constrast OpenSSL 1.1.1
+ * and lower returns a const type, needing a const type */
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
+typedef const EVP_CIPHER evp_cipher_type;
+#else
+typedef EVP_CIPHER evp_cipher_type;
+#endif
+
 /** Maximum length of an IV */
 #define OPENVPN_MAX_IV_LENGTH   EVP_MAX_IV_LENGTH
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4fee7f49f..6c55b9116 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2529,7 +2529,7 @@ frame_finalize_options(struct context *c, const struct options *o)
      * Set adjustment factor for buffer alignment when no
      * cipher is used.
      */
-    if (!CIPHER_ENABLED(c))
+    if (!cipher_defined(c->c1.ks.key_type.cipher))
     {
         frame_align_to_extra_frame(&c->c2.frame);
         frame_or_align_flags(&c->c2.frame,
@@ -2762,16 +2762,19 @@ do_init_crypto_tls_c1(struct context *c)
         * Note that BF-CBC will still be part of the OCC string to retain
         * backwards compatibility with older clients.
         */
+        const char* ciphername = options->ciphername;
         if (!streq(options->ciphername, "BF-CBC")
             || tls_item_in_cipher_list("BF-CBC", options->ncp_ciphers)
             || options->enable_ncp_fallback)
         {
-            /* Do not warn if the if the cipher is used only in OCC */
-            bool warn = options->enable_ncp_fallback;
-            init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
-                          true, warn);
+            ciphername = "none";
         }
 
+        /* Do not warn if the cipher is used only in OCC */
+        bool warn = options->enable_ncp_fallback;
+        init_key_type(&c->c1.ks.key_type, ciphername, options->authname,
+                      true, warn);
+
         /* initialize tls-auth/crypt/crypt-v2 key */
         do_init_tls_wrap_key(c);
 
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 54fd5d60f..dcc210c79 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -757,6 +757,7 @@ int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
 
 #if OPENSSL_VERSION_NUMBER < 0x30000000L
 #define EVP_MD_get0_name EVP_MD_name
+#define EVP_CIPHER_get0_name EVP_CIPHER_name
 #define EVP_CIPHER_CTX_get_mode EVP_CIPHER_CTX_mode
 
 /* Mimics the functions but only when the default context without
@@ -776,6 +777,12 @@ EVP_MD_fetch(void *ctx, const char *algorithm, const char *properties)
     ASSERT(!properties);
     return EVP_get_digestbyname(algorithm);
 }
+
+static inline void
+EVP_CIPHER_free(const EVP_CIPHER *cipher)
+{
+    /* OpenSSL 1.1.1 and lower use only const EVP_CIPHER, nothing to free */
+}
 #endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
 
 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 84477837e..aff63aef1 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -529,8 +529,6 @@ struct context
                                           |(c->options.tls_auth_file ? md_kt_size(c->c1.ks.key_type.digest) : 0), \
                                           gc)
 
-#define CIPHER_ENABLED(c) (c->c1.ks.key_type.cipher != NULL)
-
 /* this represents "disabled peer-id" */
 #define MAX_PEER_ID 0xFFFFFF
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ac13412a4..b840b767b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3084,7 +3084,7 @@ options_postprocess_setdefault_ncpciphers(struct options *o)
         /* custom --data-ciphers set, keep list */
         return;
     }
-    else if (cipher_kt_get("CHACHA20-POLY1305"))
+    else if (cipher_valid("CHACHA20-POLY1305"))
     {
         o->ncp_ciphers = "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
     }
@@ -3979,7 +3979,7 @@ options_string(const struct options *o,
         /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
          * to work here in the default configuration */
         const char *ciphername = o->ciphername;
-        int keysize;
+        int keysize = 0;
 
         if (strcmp(o->ciphername, "BF-CBC") == 0)
         {
@@ -3990,7 +3990,10 @@ options_string(const struct options *o,
         {
             init_key_type(&kt, o->ciphername, o->authname, true, false);
             ciphername = cipher_kt_name(kt.cipher);
-            keysize = cipher_kt_key_size(kt.cipher) * 8;
+            if (cipher_defined(o->ciphername))
+            {
+                keysize = cipher_kt_key_size(kt.cipher) * 8;
+            }
         }
         /* Only announce the cipher to our peer if we are willing to
          * support it */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3de229e39..0d811f24e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -281,9 +281,9 @@ tls_get_cipher_name_pair(const char *cipher_name, size_t len)
  *                      May *not* be NULL.
  */
 static void
-tls_limit_reneg_bytes(const cipher_kt_t *cipher, int *reneg_bytes)
+tls_limit_reneg_bytes(const char *ciphername, int *reneg_bytes)
 {
-    if (cipher && cipher_kt_insecure(cipher))
+    if (cipher_kt_insecure(ciphername))
     {
         if (*reneg_bytes == -1) /* Not user-specified */
         {
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 4b95406e9..ce82e8951 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -105,8 +105,7 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
     while (token)
     {
         /*
-         * Going through a roundtrip by using cipher_kt_get/cipher_kt_name
-         * (and translate_cipher_name_from_openvpn/
+         * Going cipher_kt_name (and translate_cipher_name_from_openvpn/
          * translate_cipher_name_to_openvpn) also normalises the cipher name,
          * e.g. replacing AeS-128-gCm with AES-128-GCM
          *
@@ -114,15 +113,16 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
          * OpenVPN will only warn if they are not found (and remove them from
          * the list)
          */
-
         bool optional = false;
         if (token[0] == '?')
         {
             token++;
             optional = true;
         }
-        const cipher_kt_t *ktc = cipher_kt_get(token);
-        if (strcmp(token, "none") == 0)
+
+        const bool nonecipher = (strcmp(token, "none") == 0);
+
+        if (nonecipher)
         {
             msg(M_WARN, "WARNING: cipher 'none' specified for --data-ciphers. "
                         "This allows negotiation of NO encryption and "
@@ -130,7 +130,7 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
                         "over the network! "
                         "PLEASE DO RECONSIDER THIS SETTING!");
         }
-        if (!ktc && strcmp(token, "none") != 0)
+        if (!nonecipher && !cipher_valid(token))
         {
             const char* optstr = optional ? "optional ": "";
             msg(M_WARN, "Unsupported %scipher in --data-ciphers: %s", optstr, token);
@@ -138,8 +138,8 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
         }
         else
         {
-            const char *ovpn_cipher_name = cipher_kt_name(ktc);
-            if (ktc == NULL)
+            const char *ovpn_cipher_name = cipher_kt_name(token);
+            if (nonecipher)
             {
                 /* NULL resolves to [null-cipher] but we need none for
                  * data-ciphers */
@@ -466,17 +466,17 @@ p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
     if (!common_cipher)
     {
         struct buffer out = alloc_buf_gc(128, &gc);
-        const cipher_kt_t *cipher = session->opt->key_type.cipher;
-
         /* at this point we do not really know if our fallback is
          * not enabled or if we use 'none' cipher as fallback, so
          * keep this ambiguity here and print fallback-cipher: none
          */
 
         const char *fallback_name = "none";
-        if (cipher)
+        const char *ciphername = session->opt->key_type.cipher;
+
+        if (cipher_defined(ciphername))
         {
-            fallback_name = cipher_kt_name(cipher);
+            fallback_name = cipher_kt_name(ciphername);
         }
 
         buf_printf(&out, "(not negotiated, fallback-cipher: %s)", fallback_name);
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 80ed9684e..887943d74 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -51,10 +51,10 @@ static struct key_type
 tls_crypt_kt(void)
 {
     struct key_type kt;
-    kt.cipher = cipher_kt_get("AES-256-CTR");
+    kt.cipher = "AES-256-CTR";
     kt.digest = md_kt_get("SHA256");
 
-    if (!kt.cipher)
+    if (cipher_valid(kt.cipher))
     {
         msg(M_WARN, "ERROR: --tls-crypt requires AES-256-CTR support.");
         return (struct key_type) { 0 };
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 42632c72b..344817eef 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -72,7 +72,7 @@ crypto_pem_encode_decode_loopback(void **state)
 static void
 test_translate_cipher(const char *ciphername, const char *openvpn_name)
 {
-    const cipher_kt_t *cipher = cipher_kt_get(ciphername);
+    bool cipher = cipher_valid(ciphername);
 
     /* Empty cipher is fine */
     if (!cipher)
@@ -80,7 +80,7 @@ test_translate_cipher(const char *ciphername, const char *openvpn_name)
         return;
     }
 
-    const char *kt_name = cipher_kt_name(cipher);
+    const char *kt_name = cipher_kt_name(ciphername);
 
     assert_string_equal(kt_name, openvpn_name);
 }
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 6702133ad..92e7ce936 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -59,8 +59,8 @@ static void
 test_check_ncp_ciphers_list(void **state)
 {
     struct gc_arena gc = gc_new();
-    bool have_chacha = cipher_kt_get("CHACHA20-POLY1305");
-    bool have_blowfish = cipher_kt_get("BF-CBC");
+    bool have_chacha = cipher_valid("CHACHA20-POLY1305");
+    bool have_blowfish = cipher_valid("BF-CBC");
 
     assert_string_equal(mutate_ncp_cipher_list("none", &gc), "none");
     assert_string_equal(mutate_ncp_cipher_list("AES-256-GCM:none", &gc),
@@ -100,7 +100,7 @@ test_check_ncp_ciphers_list(void **state)
 
     /* For testing that with OpenSSL 1.1.0+ that also accepts ciphers in
      * a different spelling the normalised cipher output is the same */
-    bool have_chacha_mixed_case = cipher_kt_get("ChaCha20-Poly1305");
+    bool have_chacha_mixed_case = cipher_valid("ChaCha20-Poly1305");
     if (have_chacha_mixed_case)
     {
         assert_string_equal(mutate_ncp_cipher_list("AES-128-CBC:ChaCha20-Poly1305", &gc),
-- 
2.33.0


