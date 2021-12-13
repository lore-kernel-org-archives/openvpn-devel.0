From: Arne Schwabe <arne@...1227...>
Date: Mon, 13 Dec 2021 16:06:54 +0100
Message-Id: <20211213150654.3993358-2-arne@...1227...>
In-Reply-To: <20211213150654.3993358-1-arne@...1227...>
References: <20211201180727.2496903-1-arne@...1227...>
 <20211213150654.3993358-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 8/9] Remove md_kt_t and change cyrpto API
 to use const char*
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

As with the removal of cipher_kt_t, this is allows better support of
OpenSSL 3.0 and mbed TLS 3.0

Patch v2: rebase

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/auth_token.c               |  2 +-
 src/openvpn/crypto.c                   | 15 ++++--
 src/openvpn/crypto.h                   |  2 +-
 src/openvpn/crypto_backend.h           | 46 +++++++++++-------
 src/openvpn/crypto_mbedtls.c           | 39 ++++++++++------
 src/openvpn/crypto_openssl.c           | 65 +++++++++++++++++---------
 src/openvpn/crypto_openssl.h           |  5 +-
 src/openvpn/httpdigest.c               | 10 ++--
 src/openvpn/init.c                     |  9 ++--
 src/openvpn/ntlm.c                     |  6 +--
 src/openvpn/openssl_compat.h           |  7 +++
 src/openvpn/push.c                     |  2 +-
 src/openvpn/ssl_mbedtls.c              |  3 +-
 src/openvpn/tls_crypt.c                |  4 +-
 tests/unit_tests/openvpn/test_crypto.c |  5 +-
 15 files changed, 132 insertions(+), 88 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 5c947004e..e88754640 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -36,7 +36,7 @@ auth_token_kt(void)
     struct key_type kt = { 0 };
     /* We do not encrypt our session tokens */
     kt.cipher = "none";
-    kt.digest = md_kt_get("SHA256");
+    kt.digest = "SHA256";
 
     if (!kt.digest)
     {
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 0b47dec44..36f880433 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -693,7 +693,10 @@ crypto_adjust_frame_parameters(struct frame *frame,
         crypto_overhead += cipher_kt_block_size(kt->cipher);
     }
 
-    crypto_overhead += md_kt_size(kt->digest);
+    if (md_defined(kt->digest))
+    {
+        crypto_overhead += md_kt_size(kt->digest);
+    }
 
     frame_add_to_extra_frame(frame, crypto_overhead);
 
@@ -775,11 +778,15 @@ init_key_type(struct key_type *kt, const char *ciphername,
                 "PLEASE DO RECONSIDER THIS SETTING!");
         }
     }
+    kt->digest = authname;
     if (strcmp(authname, "none") != 0)
     {
-        if (!aead_cipher) /* Ignore auth for AEAD ciphers */
+        if (aead_cipher) /* Ignore auth for AEAD ciphers */
+        {
+            kt->digest = "none";
+        }
+        else
         {
-            kt->digest = md_kt_get(authname);
             int hmac_length = md_kt_size(kt->digest);
 
             if (OPENVPN_MAX_HMAC_SIZE < hmac_length)
@@ -826,7 +833,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
              cipher_kt_iv_size(kt->cipher));
         warn_insecure_key_type(ciphername);
     }
-    if (kt->digest)
+    if (md_defined(kt->digest))
     {
         ctx->hmac = hmac_ctx_new();
         hmac_ctx_init(ctx->hmac, key->hmac, kt->digest);
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index af94b0eb5..ad3543c1c 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -139,7 +139,7 @@ struct sha256_digest {
 struct key_type
 {
     const char *cipher;         /**< const name of the cipher */
-    const md_kt_t *digest;      /**< Message digest static parameters */
+    const char *digest;         /**< Message digest static parameters */
 };
 
 /**
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index e3da5c957..cf2cd1562 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -485,36 +485,45 @@ int cipher_ctx_final_check_tag(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len,
 #define MAX_HMAC_KEY_LENGTH 64
 
 /**
- * Return message digest parameters, based on the given digest name. The
- * contents of these parameters are library-specific, and can be used to
- * initialise HMAC or message digest operations.
+ * Checks if the cipher is defined and is not the null (none) cipher
  *
- * @param digest        Name of the digest to retrieve parameters for (e.g.
- *                      \c MD5).
+ * @param mdname    Name of the digest
+ * @return
+ */
+static inline bool md_defined(const char* mdname)
+{
+    return strcmp(mdname, "none") != 0;
+}
+
+
+/**
+ * Return if a message digest parameters is valid given the name of the digest.
+ *
+ * @param digest        Name of the digest to verify, e.g. \c MD5).
  *
  * @return              A statically allocated structure containing parameters
  *                      for the given message digest.
  */
-const md_kt_t *md_kt_get(const char *digest);
+bool md_valid(const char *digest);
 
 /**
  * Retrieve a string describing the digest digest (e.g. \c SHA1).
  *
- * @param kt            Static message digest parameters
+ * @param mdname        Message digest name
  *
  * @return              Statically allocated string describing the message
  *                      digest.
  */
-const char *md_kt_name(const md_kt_t *kt);
+const char *md_kt_name(const char *mdname);
 
 /**
  * Returns the size of the message digest, in bytes.
  *
- * @param kt            Static message digest parameters
+ * @param mdname        Message digest name
  *
  * @return              Message digest size, in bytes, or 0 if ctx was NULL.
  */
-unsigned char md_kt_size(const md_kt_t *kt);
+unsigned char md_kt_size(const char *mdname);
 
 
 /*
@@ -523,17 +532,17 @@ unsigned char md_kt_size(const md_kt_t *kt);
  *
  */
 
-/*
+/**
  * Calculates the message digest for the given buffer.
  *
- * @param kt            Static message digest parameters
+ * @param mdname        message digest name
  * @param src           Buffer to digest. May not be NULL.
  * @param src_len       The length of the incoming buffer.
  * @param dst           Buffer to write the message digest to. May not be NULL.
  *
  * @return              \c 1 on success, \c 0 on failure
  */
-int md_full(const md_kt_t *kt, const uint8_t *src, int src_len, uint8_t *dst);
+int md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst);
 
 /*
  * Allocate a new message digest context
@@ -549,13 +558,13 @@ md_ctx_t *md_ctx_new(void);
  */
 void md_ctx_free(md_ctx_t *ctx);
 
-/*
+/**
  * Initialises the given message digest context.
  *
  * @param ctx           Message digest context
- * @param kt            Static message digest parameters
+ * @param mdname        Message digest name
  */
-void md_ctx_init(md_ctx_t *ctx, const md_kt_t *kt);
+void md_ctx_init(md_ctx_t *ctx, const char *mdname);
 
 /*
  * Free the given message digest context.
@@ -617,10 +626,11 @@ void hmac_ctx_free(hmac_ctx_t *ctx);
  *
  * @param ctx           HMAC context to initialise
  * @param key           The key to use for the HMAC
- * @param kt            Static message digest parameters
+ * @param mdname        message digest name
  *
  */
-void hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, const md_kt_t *kt);
+void hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, const char *mdname);
+
 
 /*
  * Free the given HMAC context.
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index c3e18a1bc..dc654086d 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -757,8 +757,8 @@ cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
  */
 
 
-const mbedtls_md_info_t *
-md_kt_get(const char *digest)
+static const mbedtls_md_info_t *
+md_get(const char *digest)
 {
     const mbedtls_md_info_t *md = NULL;
     ASSERT(digest);
@@ -778,19 +778,28 @@ md_kt_get(const char *digest)
     return md;
 }
 
+bool
+md_valid(const char *digest)
+{
+    const mbedtls_md_info_t *md  = mbedtls_md_info_from_string(digest);
+    return md != NULL;
+}
+
 const char *
-md_kt_name(const mbedtls_md_info_t *kt)
+md_kt_name(const char *mdname)
 {
-    if (NULL == kt)
+    if (!strcmp("none", mdname))
     {
         return "[null-digest]";
     }
+    const mbedtls_md_info_t *kt = md_get(mdname);
     return mbedtls_md_get_name(kt);
 }
 
 unsigned char
-md_kt_size(const mbedtls_md_info_t *kt)
+md_kt_size(const char *mdname)
 {
+    const mbedtls_md_info_t *kt = md_get(mdname);
     if (NULL == kt)
     {
         return 0;
@@ -805,8 +814,9 @@ md_kt_size(const mbedtls_md_info_t *kt)
  */
 
 int
-md_full(const md_kt_t *kt, const uint8_t *src, int src_len, uint8_t *dst)
+md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst)
 {
+    const mbedtls_md_info_t *kt = md_get(mdname);
     return 0 == mbedtls_md(kt, src, src_len, dst);
 }
 
@@ -825,8 +835,9 @@ md_ctx_free(mbedtls_md_context_t *ctx)
 }
 
 void
-md_ctx_init(mbedtls_md_context_t *ctx, const mbedtls_md_info_t *kt)
+md_ctx_init(mbedtls_md_context_t *ctx, const char *mdname)
 {
+    const mbedtls_md_info_t *kt = md_get(mdname);
     ASSERT(NULL != ctx && NULL != kt);
 
     mbedtls_md_init(ctx);
@@ -890,9 +901,9 @@ hmac_ctx_free(mbedtls_md_context_t *ctx)
 }
 
 void
-hmac_ctx_init(mbedtls_md_context_t *ctx, const uint8_t *key,
-              const mbedtls_md_info_t *kt)
+hmac_ctx_init(mbedtls_md_context_t *ctx, const uint8_t *key, const char *mdname)
 {
+    const mbedtls_md_info_t *kt = md_get(mdname);
     ASSERT(NULL != kt && NULL != ctx);
 
     mbedtls_md_init(ctx);
@@ -980,7 +991,7 @@ ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
  * @param olen          Length of the output buffer
  */
 static void
-tls1_P_hash(const md_kt_t *md_kt, const uint8_t *sec, int sec_len,
+tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, int sec_len,
             const uint8_t *seed, int seed_len, uint8_t *out, int olen)
 {
     struct gc_arena gc = gc_new();
@@ -999,8 +1010,8 @@ tls1_P_hash(const md_kt_t *md_kt, const uint8_t *sec, int sec_len,
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len, 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_len, 0, &gc));
 
-    int chunk = md_kt_size(md_kt);
-    unsigned int A1_len = md_kt_size(md_kt);
+    int chunk = mbedtls_md_get_size(md_kt);
+    unsigned int A1_len = mbedtls_md_get_size(md_kt);
 
     /* This is the only place where we init an HMAC with a key that is not
      * equal to its size, therefore we init the hmac ctx manually here */
@@ -1071,8 +1082,8 @@ ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec,
              int slen, uint8_t *out1, int olen)
 {
     struct gc_arena gc = gc_new();
-    const md_kt_t *md5 = md_kt_get("MD5");
-    const md_kt_t *sha1 = md_kt_get("SHA1");
+    const md_kt_t *md5 = md_get("MD5");
+    const md_kt_t *sha1 = md_get("SHA1");
 
     uint8_t *out2 = (uint8_t *)gc_malloc(olen, false, &gc);
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 01893e2f9..35fb00524 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1027,10 +1027,10 @@ cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
  */
 
 
-const EVP_MD *
-md_kt_get(const char *digest)
+static evp_md_type *
+md_get(const char *digest)
 {
-    const EVP_MD *md = NULL;
+    evp_md_type *md = NULL;
     ASSERT(digest);
     md = EVP_MD_fetch(NULL, digest, NULL);
     if (!md)
@@ -1047,20 +1047,36 @@ md_kt_get(const char *digest)
     return md;
 }
 
+
+bool
+md_valid(const char *digest)
+{
+    evp_md_type *md = EVP_MD_fetch(NULL, digest, NULL);
+    bool valid = (md != NULL);
+    EVP_MD_free(md);
+    return valid;
+}
+
 const char *
-md_kt_name(const EVP_MD *kt)
+md_kt_name(const char *mdname)
 {
-    if (NULL == kt)
+    if (!strcmp("none", mdname))
     {
         return "[null-digest]";
     }
-    return EVP_MD_get0_name(kt);
+    evp_md_type *kt = md_get(mdname);
+    const char *name = EVP_MD_get0_name(kt);
+    EVP_MD_free(kt);
+    return name;
 }
 
 unsigned char
-md_kt_size(const EVP_MD *kt)
+md_kt_size(const char *mdname)
 {
-    return (unsigned char)EVP_MD_size(kt);
+    evp_md_type *kt = md_get(mdname);
+    unsigned char size =  (unsigned char)EVP_MD_size(kt);
+    EVP_MD_free(kt);
+    return size;
 }
 
 
@@ -1071,11 +1087,14 @@ md_kt_size(const EVP_MD *kt)
  */
 
 int
-md_full(const EVP_MD *kt, const uint8_t *src, int src_len, uint8_t *dst)
+md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst)
 {
     unsigned int in_md_len = 0;
+    evp_md_type *kt = md_get(mdname);
 
-    return EVP_Digest(src, src_len, dst, &in_md_len, kt, NULL);
+    int ret = EVP_Digest(src, src_len, dst, &in_md_len, kt, NULL);
+    EVP_MD_free(kt);
+    return ret;
 }
 
 EVP_MD_CTX *
@@ -1093,8 +1112,9 @@ md_ctx_free(EVP_MD_CTX *ctx)
 }
 
 void
-md_ctx_init(EVP_MD_CTX *ctx, const EVP_MD *kt)
+md_ctx_init(EVP_MD_CTX *ctx, const char *mdname)
 {
+    evp_md_type *kt = md_get(mdname);
     ASSERT(NULL != ctx && NULL != kt);
 
     EVP_MD_CTX_init(ctx);
@@ -1102,6 +1122,7 @@ md_ctx_init(EVP_MD_CTX *ctx, const EVP_MD *kt)
     {
         crypto_msg(M_FATAL, "EVP_DigestInit failed");
     }
+    EVP_MD_free(kt);
 }
 
 void
@@ -1152,8 +1173,9 @@ hmac_ctx_free(HMAC_CTX *ctx)
 }
 
 void
-hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, const EVP_MD *kt)
+hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, const char *mdname)
 {
+    evp_md_type *kt = md_get(mdname);
     ASSERT(NULL != kt && NULL != ctx);
 
     int key_len = EVP_MD_size(kt);
@@ -1225,15 +1247,14 @@ hmac_ctx_free(hmac_ctx_t *ctx)
 }
 
 void
-hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, const EVP_MD *kt)
+hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, const char *mdname)
 {
+    evp_md_type *kt = md_get(mdname);
     ASSERT(NULL != kt && NULL != ctx && ctx->ctx != NULL);
-    int key_len = EVP_MD_size(kt);
-    ASSERT(key_len <= EVP_MAX_KEY_LENGTH);
 
     /* We need to make a copy of the key since the OSSL parameters
      * only reference it */
-    memcpy(ctx->key, key, key_len);
+    memcpy(ctx->key, key, EVP_MD_size(kt));
 
     /* Lookup/setting of parameters in OpenSSL 3.0 are string based
      *
@@ -1244,7 +1265,7 @@ hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, const EVP_MD *kt)
     ctx->params[0] = OSSL_PARAM_construct_utf8_string("digest",
                                                       (char *) EVP_MD_get0_name(kt), 0);
     ctx->params[1] = OSSL_PARAM_construct_octet_string("key",
-                                                       ctx->key, key_len);
+                                                       ctx->key, EVP_MD_size(kt));
     ctx->params[2] = OSSL_PARAM_construct_end();
 
     if (!EVP_MAC_init(ctx->ctx, NULL, 0, ctx->params))
@@ -1252,8 +1273,7 @@ hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, const EVP_MD *kt)
         crypto_msg(M_FATAL, "EVP_MAC_init failed");
     }
 
-    /* make sure we used a big enough key */
-    ASSERT(EVP_MAC_CTX_get_mac_size(ctx->ctx) <= key_len);
+    EVP_MD_free(kt);
 }
 
 void
@@ -1528,7 +1548,6 @@ err:
     return ret;
 }
 
-
 /*
  * Use the TLS PRF function for generating data channel keys.
  * This code is based on the OpenSSL library.
@@ -1554,9 +1573,9 @@ ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec,
 {
     bool ret = true;
     struct gc_arena gc = gc_new();
-    /* For some reason our md_kt_get("MD5") fails otherwise in the unit test */
-    const md_kt_t *md5 = EVP_md5();
-    const md_kt_t *sha1 = EVP_sha1();
+    /* For some reason our md_get("MD5") fails otherwise in the unit test */
+    const EVP_MD *md5 = EVP_md5();
+    const EVP_MD *sha1 = EVP_sha1();
 
     uint8_t *out2 = (uint8_t *)gc_malloc(olen, false, &gc);
 
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 3371d07e7..a47831110 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -37,9 +37,6 @@
 #include <openssl/provider.h>
 #endif
 
-/** Generic message digest key type %context. */
-typedef EVP_MD md_kt_t;
-
 /** Generic cipher %context. */
 typedef EVP_CIPHER_CTX cipher_ctx_t;
 
@@ -67,8 +64,10 @@ typedef OSSL_PROVIDER provider_t;
  * and lower returns a const type, needing a const type */
 #if OPENSSL_VERSION_NUMBER < 0x30000000L
 typedef const EVP_CIPHER evp_cipher_type;
+typedef const EVP_MD evp_md_type;
 #else
 typedef EVP_CIPHER evp_cipher_type;
+typedef EVP_MD evp_md_type;
 #endif
 
 /** Maximum length of an IV */
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 26b0ed1a7..9b886f6a7 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -81,9 +81,8 @@ DigestCalcHA1(
 {
     HASH HA1;
     md_ctx_t *md5_ctx = md_ctx_new();
-    const md_kt_t *md5_kt = md_kt_get("MD5");
 
-    md_ctx_init(md5_ctx, md5_kt);
+    md_ctx_init(md5_ctx, "MD5");
     md_ctx_update(md5_ctx, (const uint8_t *) pszUserName, strlen(pszUserName));
     md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
     md_ctx_update(md5_ctx, (const uint8_t *) pszRealm, strlen(pszRealm));
@@ -92,7 +91,7 @@ DigestCalcHA1(
     md_ctx_final(md5_ctx, HA1);
     if (pszAlg && strcasecmp(pszAlg, "md5-sess") == 0)
     {
-        md_ctx_init(md5_ctx, md5_kt);
+        md_ctx_init(md5_ctx, "MD5");
         md_ctx_update(md5_ctx, HA1, HASHLEN);
         md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
         md_ctx_update(md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
@@ -124,10 +123,9 @@ DigestCalcResponse(
     HASHHEX HA2Hex;
 
     md_ctx_t *md5_ctx = md_ctx_new();
-    const md_kt_t *md5_kt = md_kt_get("MD5");
 
     /* calculate H(A2) */
-    md_ctx_init(md5_ctx, md5_kt);
+    md_ctx_init(md5_ctx, "MD5");
     md_ctx_update(md5_ctx, (const uint8_t *) pszMethod, strlen(pszMethod));
     md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
     md_ctx_update(md5_ctx, (const uint8_t *) pszDigestUri, strlen(pszDigestUri));
@@ -140,7 +138,7 @@ DigestCalcResponse(
     CvtHex(HA2, HA2Hex);
 
     /* calculate response */
-    md_ctx_init(md5_ctx, md5_kt);
+    md_ctx_init(md5_ctx, "MD5");
     md_ctx_update(md5_ctx, HA1, HASHHEXLEN);
     md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
     md_ctx_update(md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index bb9dce778..624b70878 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2658,12 +2658,9 @@ do_init_tls_wrap_key(struct context *c)
     {
         /* Initialize key_type for tls-auth with auth only */
         CLEAR(c->c1.ks.tls_auth_key_type);
-        if (!streq(options->authname, "none"))
-        {
-            c->c1.ks.tls_auth_key_type.cipher = "none";
-            c->c1.ks.tls_auth_key_type.digest = md_kt_get(options->authname);
-        }
-        else
+        c->c1.ks.tls_auth_key_type.cipher = "none";
+        c->c1.ks.tls_auth_key_type.digest = options->authname;
+        if (!md_valid(options->authname))
         {
             msg(M_FATAL, "ERROR: tls-auth enabled, but no valid --auth "
                 "algorithm specified ('%s')", options->authname);
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 8fc9fbd6a..72c13130a 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -73,10 +73,9 @@ static void
 gen_md4_hash(const uint8_t *data, int data_len, uint8_t *result)
 {
     /* result is 16 byte md4 hash */
-    const md_kt_t *md4_kt = md_kt_get("MD4");
     uint8_t md[MD4_DIGEST_LENGTH];
 
-    md_full(md4_kt, data, data_len, md);
+    md_full("MD4", data, data_len, md);
     memcpy(result, md, MD4_DIGEST_LENGTH);
 }
 
@@ -84,10 +83,9 @@ static void
 gen_hmac_md5(const uint8_t *data, int data_len, const uint8_t *key,
              uint8_t *result)
 {
-    const md_kt_t *md5_kt = md_kt_get("MD5");
     hmac_ctx_t *hmac_ctx = hmac_ctx_new();
 
-    hmac_ctx_init(hmac_ctx, key, md5_kt);
+    hmac_ctx_init(hmac_ctx, key, "MD5");
     hmac_ctx_update(hmac_ctx, data, data_len);
     hmac_ctx_final(hmac_ctx, result);
     hmac_ctx_cleanup(hmac_ctx);
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index dcc210c79..7a323be52 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -783,6 +783,13 @@ EVP_CIPHER_free(const EVP_CIPHER *cipher)
 {
     /* OpenSSL 1.1.1 and lower use only const EVP_CIPHER, nothing to free */
 }
+
+static inline void
+EVP_MD_free(const EVP_MD *md)
+{
+    /* OpenSSL 1.1.1 and lower use only const EVP_MD, nothing to free */
+}
+
 #endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
 
 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 53cb7ca6f..f9343b42e 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -926,7 +926,7 @@ process_incoming_push_reply(struct context *c,
         if (!c->c2.pulled_options_digest_init_done)
         {
             c->c2.pulled_options_state = md_ctx_new();
-            md_ctx_init(c->c2.pulled_options_state, md_kt_get("SHA256"));
+            md_ctx_init(c->c2.pulled_options_state, "SHA256");
             c->c2.pulled_options_digest_init_done = true;
         }
         if (apply_push_options(&c->options,
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 946058017..5624c5142 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -958,10 +958,9 @@ tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 
     if (NULL != ctx->crt_chain)
     {
-        const md_kt_t *sha256_kt = md_kt_get("SHA256");
         mbedtls_x509_crt *cert = ctx->crt_chain;
 
-        if (!md_full(sha256_kt, cert->tbs.p, cert->tbs.len, sha256_hash))
+        if (!md_full("SHA256", cert->tbs.p, cert->tbs.len, sha256_hash))
         {
             msg(M_WARN, "WARNING: failed to personalise random");
         }
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 841261329..d940ec303 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -52,14 +52,14 @@ tls_crypt_kt(void)
 {
     struct key_type kt;
     kt.cipher = "AES-256-CTR";
-    kt.digest = md_kt_get("SHA256");
+    kt.digest = "SHA256";
 
     if (!cipher_valid(kt.cipher))
     {
         msg(M_WARN, "ERROR: --tls-crypt requires AES-256-CTR support.");
         return (struct key_type) { 0 };
     }
-    if (!kt.digest)
+    if (cipher_valid(kt.digest))
     {
         msg(M_WARN, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");
         return (struct key_type) { 0 };
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 344817eef..51672f9b2 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -174,14 +174,13 @@ static void
 crypto_test_hmac(void **state)
 {
     hmac_ctx_t *hmac = hmac_ctx_new();
-    const md_kt_t *sha1 = md_kt_get("SHA1");
 
-    assert_int_equal(md_kt_size(sha1), 20);
+    assert_int_equal(md_kt_size("SHA1"), 20);
 
     uint8_t key[20];
     memcpy(key, testkey, sizeof(key));
 
-    hmac_ctx_init(hmac, key, sha1);
+    hmac_ctx_init(hmac, key, "SHA1");
     hmac_ctx_update(hmac, (const uint8_t *)ipsumlorem, (int) strlen(ipsumlorem));
     hmac_ctx_update(hmac, (const uint8_t *)ipsumlorem, (int) strlen(ipsumlorem));
 
-- 
2.33.0


