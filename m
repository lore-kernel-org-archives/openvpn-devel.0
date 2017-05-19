Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Fri, 19 May 2017 12:38:15 +0200
Message-Id: <20170519103816.19851-6-logout@...260...>
In-Reply-To: <20170519103816.19851-1-logout@...260...>
References: <CAKh=nwFot6GZiv1cs2-X8kL0UNS6r8BGsNQ2RtC+0eyiJRMZtA@...278...>
	<20170519103816.19851-1-logout@...260...>
Subject: [Openvpn-devel] [PATCH 6/7] OpenSSL: don't use direct access to the
	internal of EVP_CIPHER_CTX
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
index 9c7074d1..8a9a3ff3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -920,6 +920,8 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 
 	AC_CHECK_FUNCS(
 		[ \
+			EVP_CIPHER_CTX_new \
+			EVP_CIPHER_CTX_free \
 			EVP_MD_CTX_new \
 			EVP_MD_CTX_free \
 			EVP_MD_CTX_reset \
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 50e6a734..893879cf 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -830,7 +830,7 @@ init_key_ctx(struct key_ctx *ctx, struct key *key,
     if (kt->cipher && kt->cipher_length > 0)
     {
 
-        ALLOC_OBJ(ctx->cipher, cipher_ctx_t);
+        ctx->cipher = cipher_ctx_new();
         cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher_length,
                         kt->cipher, enc);
 
@@ -879,7 +879,7 @@ free_key_ctx(struct key_ctx *ctx)
     if (ctx->cipher)
     {
         cipher_ctx_cleanup(ctx->cipher);
-        free(ctx->cipher);
+        cipher_ctx_free(ctx->cipher);
         ctx->cipher = NULL;
     }
     if (ctx->hmac)
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 8f03e2ba..3a911a47 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -301,6 +301,20 @@ bool cipher_kt_mode_aead(const cipher_kt_t *cipher);
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
index d6741523..4d38aadc 100644
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
index fd599f40..0644f1c3 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -651,6 +651,19 @@ cipher_kt_mode_aead(const cipher_kt_t *cipher)
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
@@ -658,8 +671,6 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, uint8_t *key, int key_len,
 {
     ASSERT(NULL != kt && NULL != ctx);
 
-    CLEAR(*ctx);
-
     EVP_CIPHER_CTX_init(ctx);
     if (!EVP_CipherInit(ctx, kt, NULL, NULL, enc))
     {
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 8305ec5b..d1be9d78 100644
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
2.11.0


