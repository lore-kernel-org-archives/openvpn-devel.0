Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Fri, 17 Feb 2017 23:00:50 +0100
Message-Id: <486b787a457fa098e5e9e9eeb2b728ffd8f7f622.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [RFC PATCH v1 11/15] OpenSSL: don't use direct
	access to the internal of EVP_CIPHER_CTX
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Emmanuel Deloget <logout@...260...>

OpenSSL 1.1 does not allow us to directly access the internal of
any data type, including EVP_CIPHER_CTX. We have to use the defined
functions to do so.

Compatibility with OpenSSL 1.0 is kept by defining the corresponding
functions when they are not found in the library.

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 configure.ac                 |  2 ++
 src/openvpn/crypto.c         |  4 ++--
 src/openvpn/crypto_backend.h | 14 ++++++++++++++
 src/openvpn/crypto_mbedtls.c | 13 +++++++++++++
 src/openvpn/crypto_openssl.c | 15 +++++++++++++--
 src/openvpn/openssl_compat.h | 28 ++++++++++++++++++++++++++++
 6 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index c7e9df5e3ef3f3740f2db79fef6d5c1587c47800..ff9b00447fce07d9f1c408a00ea2fafe8c786cb7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -900,6 +900,8 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 
 	AC_CHECK_FUNCS(
 		[ \
+			EVP_CIPHER_CTX_new \
+			EVP_CIPHER_CTX_free \
 			EVP_MD_CTX_new \
 			EVP_MD_CTX_free \
 			EVP_MD_CTX_reset \
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 909f725300fce7fb8986f4afb706a97e968ff195..4ba344d1f6185afcc2205a7ce501607a2b5fff87 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -820,7 +820,7 @@ init_key_ctx(struct key_ctx *ctx, struct key *key,
     if (kt->cipher && kt->cipher_length > 0)
     {
 
-        ALLOC_OBJ(ctx->cipher, cipher_ctx_t);
+        ctx->cipher = cipher_ctx_new();
         cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher_length,
                         kt->cipher, enc);
 
@@ -869,7 +869,7 @@ free_key_ctx(struct key_ctx *ctx)
     if (ctx->cipher)
     {
         cipher_ctx_cleanup(ctx->cipher);
-        free(ctx->cipher);
+        cipher_ctx_free(ctx->cipher);
         ctx->cipher = NULL;
     }
     if (ctx->hmac)
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 9b35cdaaf5a5f6c9f2b6af766fbb1b439db4c58f..04876bffe9c9de0afd40ff58bcba5dce3eab18ca 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -295,6 +295,20 @@ bool cipher_kt_mode_aead(const cipher_kt_t *cipher);
  */
 
 /**
+ * Allocate a new cipher context
+ *
+ * @return              a new cipher context
+ */
+cipher_ctx_t *cipher_ctx_new(void);
+
+/**
+ * Free a cipher context
+ *
+ * @param ctx           Cipher context.
+ */
+void cipher_ctx_free(cipher_ctx_t *ctx);
+
+/**
  * Initialise a cipher context, based on the given key and key type.
  *
  * @param ctx           Cipher context. May not be NULL
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index d67415233cd4f7d7b75a43ac30ad864458b75b47..4d38aadcdbd3a3158cd8a1da5f335e80e0c3a27d 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -509,6 +509,19 @@ cipher_kt_mode_aead(const cipher_kt_t *cipher)
  *
  */
 
+mbedtls_cipher_context_t *
+cipher_ctx_new(void)
+{
+    mbedtls_cipher_context_t *ctx;
+    ALLOC_OBJ(ctx, mbedtls_cipher_context_t);
+    return ctx;
+}
+
+void
+cipher_ctx_free(mbedtls_cipher_context_t *ctx)
+{
+    free(ctx);
+}
 
 void
 cipher_ctx_init(mbedtls_cipher_context_t *ctx, uint8_t *key, int key_len,
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index da3abfb7ef30fe23d7b47cd398c5cbdf61a9718b..82da531f353a2430dbc2c4396aff459844af0cc2 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -653,6 +653,19 @@ cipher_kt_mode_aead(const cipher_kt_t *cipher)
  *
  */
 
+cipher_ctx_t *
+cipher_ctx_new(void)
+{
+    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
+    check_malloc_return(ctx);
+    return ctx;
+}
+
+void
+cipher_ctx_free(EVP_CIPHER_CTX *ctx)
+{
+    EVP_CIPHER_CTX_free(ctx);
+}
 
 void
 cipher_ctx_init(EVP_CIPHER_CTX *ctx, uint8_t *key, int key_len,
@@ -660,8 +673,6 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, uint8_t *key, int key_len,
 {
     ASSERT(NULL != kt && NULL != ctx);
 
-    CLEAR(*ctx);
-
     EVP_CIPHER_CTX_init(ctx);
     if (!EVP_CipherInit(ctx, kt, NULL, NULL, enc))
     {
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 3be0f4a5abe913e5b67115b86f840a4d107f9c56..9e3969c65bfdcf2a2453ba2196bb70a0102112bd 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -96,6 +96,34 @@ EVP_MD_CTX_new(void)
 }
 #endif
 
+#if !defined(HAVE_EVP_CIPHER_CTX_FREE)
+/**
+ * Free an existing cipher context
+ *
+ * @param ctx                 The cipher context
+ */
+static inline void
+EVP_CIPHER_CTX_free(EVP_CIPHER_CTX *c)
+{
+	free(c);
+}
+#endif
+
+#if !defined(HAVE_EVP_CIPHER_CTX_NEW)
+/**
+ * Allocate a new cipher context object
+ *
+ * @return                    A zero'ed cipher context object
+ */
+static inline EVP_CIPHER_CTX *
+EVP_CIPHER_CTX_new(void)
+{
+    EVP_CIPHER_CTX *ctx = NULL;
+    ALLOC_OBJ_CLEAR(ctx, EVP_CIPHER_CTX);
+    return ctx;
+}
+#endif
+
 #if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA)
 /**
  * Fetch the default password callback user data from the SSL context
-- 
2.7.4


