From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:23:06 +0200
Message-Id: <20211019182332.613155-2-arne@...1227...>
In-Reply-To: <20211019182332.613155-1-arne@...1227...>
References: <20211019182332.613155-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 01/20] [OSSL 3.0] Use new EVP_MAC API for
 HMAC implementation
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

The old API is deprecated in OpenSSL 3.0 and the new API does not yet
exist in OpenSSL 1.1. Emulating the new API would be more complex than
just having two implementations. So this switches to a new hmac
implementation for OpenSSL 3.0.

Unfortunately the new API does not have an easy to reset an HMAC, so we need
to keep the key around to emulate a reset functionality.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_backend.h |  2 +-
 src/openvpn/crypto_mbedtls.c |  2 +-
 src/openvpn/crypto_openssl.c | 96 +++++++++++++++++++++++++++++++++++-
 src/openvpn/crypto_openssl.h |  8 +++
 4 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index e9447f82f..e0bfdf585 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -643,7 +643,7 @@ void hmac_ctx_cleanup(hmac_ctx_t *ctx);
  *
  * @return              Size of the HMAC, or \0 if ctx is NULL.
  */
-int hmac_ctx_size(const hmac_ctx_t *ctx);
+int hmac_ctx_size(hmac_ctx_t *ctx);
 
 /*
  * Resets the given HMAC context, preserving the associated key information
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index c632849db..e2f5f4012 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -939,7 +939,7 @@ hmac_ctx_cleanup(mbedtls_md_context_t *ctx)
 }
 
 int
-hmac_ctx_size(const mbedtls_md_context_t *ctx)
+hmac_ctx_size(mbedtls_md_context_t *ctx)
 {
     if (NULL == ctx)
     {
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 419265a51..1c800df7f 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1001,7 +1001,7 @@ md_ctx_final(EVP_MD_CTX *ctx, uint8_t *dst)
  * Generic HMAC functions
  *
  */
-
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
 HMAC_CTX *
 hmac_ctx_new(void)
 {
@@ -1039,7 +1039,7 @@ hmac_ctx_cleanup(HMAC_CTX *ctx)
 }
 
 int
-hmac_ctx_size(const HMAC_CTX *ctx)
+hmac_ctx_size(HMAC_CTX *ctx)
 {
     return HMAC_size(ctx);
 }
@@ -1066,6 +1066,98 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)
 
     HMAC_Final(ctx, dst, &in_hmac_len);
 }
+#else
+hmac_ctx_t *
+hmac_ctx_new(void)
+{
+    hmac_ctx_t *ctx;
+    ALLOC_OBJ_CLEAR(ctx, hmac_ctx_t);
+    EVP_MAC *hmac = EVP_MAC_fetch(NULL, "HMAC", NULL);
+    ctx->ctx = EVP_MAC_CTX_new(hmac);
+    check_malloc_return(ctx->ctx);
+    return ctx;
+}
+
+void
+hmac_ctx_free(hmac_ctx_t *ctx)
+{
+    EVP_MAC_CTX_free(ctx->ctx);
+    secure_memzero(ctx, sizeof(hmac_ctx_t));
+    free(ctx);
+}
+
+void
+hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, int key_len,
+              const EVP_MD *kt)
+{
+    ASSERT(NULL != kt && NULL != ctx && ctx->ctx != NULL);
+    ASSERT(key_len <= EVP_MAX_KEY_LENGTH);
+
+    /* We need to make a copy of the key since the OSSL parameters
+     * only reference it */
+    memcpy(ctx->key, key, key_len);
+
+    /* Lookup/setting of parameters in OpenSSL 3.0 are string based
+     *
+     * The OSSL_PARAM_construct_utf8_string needs a non const str but this
+     * only used for lookup so we cast (as OpenSSL also does internally)
+     * the constness away here.
+     */
+    ctx->params[0] = OSSL_PARAM_construct_utf8_string("digest",
+                                                      (char *) EVP_MD_get0_name(kt), 0);
+    ctx->params[1] = OSSL_PARAM_construct_octet_string("key",
+                                                       ctx->key, key_len);
+    ctx->params[2] = OSSL_PARAM_construct_end();
+
+    if (!EVP_MAC_init(ctx->ctx, NULL, 0, ctx->params))
+    {
+        crypto_msg(M_FATAL, "EVP_MAC_init failed");
+    }
+
+    /* make sure we used a big enough key */
+    ASSERT(EVP_MAC_CTX_get_mac_size(ctx->ctx) <= key_len);
+}
+
+void
+hmac_ctx_cleanup(hmac_ctx_t *ctx)
+{
+    EVP_MAC_init(ctx->ctx, NULL, 0, NULL);
+}
+
+int
+hmac_ctx_size(hmac_ctx_t *ctx)
+{
+    return (int)EVP_MAC_CTX_get_mac_size(ctx->ctx);
+}
+
+void
+hmac_ctx_reset(hmac_ctx_t *ctx)
+{
+    /* The OpenSSL MAC API lacks a reset method and passing NULL as params
+     * does not reset it either, so use the params array to reinitialise it the
+     * same way as before */
+    if (!EVP_MAC_init(ctx->ctx, NULL, 0, ctx->params))
+    {
+        crypto_msg(M_FATAL, "EVP_MAC_init failed");
+    }
+}
+
+void
+hmac_ctx_update(hmac_ctx_t *ctx, const uint8_t *src, int src_len)
+{
+    EVP_MAC_update(ctx->ctx, src, src_len);
+}
+
+void
+hmac_ctx_final(hmac_ctx_t *ctx, uint8_t *dst)
+{
+    /* The calling code always gives us a buffer that has the size of our
+     * algorithm */
+    size_t in_hmac_len = EVP_MAC_CTX_get_mac_size(ctx->ctx);
+
+    EVP_MAC_final(ctx->ctx, dst, &in_hmac_len, in_hmac_len);
+}
+#endif
 
 int
 memcmp_constant_time(const void *a, const void *b, size_t size)
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 59a31aacf..e540a76b9 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -47,7 +47,15 @@ typedef EVP_CIPHER_CTX cipher_ctx_t;
 typedef EVP_MD_CTX md_ctx_t;
 
 /** Generic HMAC %context. */
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
 typedef HMAC_CTX hmac_ctx_t;
+#else
+typedef struct {
+    OSSL_PARAM params[3];
+    uint8_t key[EVP_MAX_KEY_LENGTH];
+    EVP_MAC_CTX *ctx;
+} hmac_ctx_t;
+#endif
 
 /** Maximum length of an IV */
 #define OPENVPN_MAX_IV_LENGTH   EVP_MAX_IV_LENGTH
-- 
2.33.0


