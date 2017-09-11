From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 11 Sep 2017 23:52:01 +0200
Message-ID: <1505166722-5409-3-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
References: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] mbedtls: make external signing code
 generic
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

This prepares for reusing this code from the mbedtls pkcs11 implementation.
The change itself should not have any functional impact.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_mbedtls.c | 115 ++++++++++++++++++++++++----------------------
 src/openvpn/ssl_mbedtls.h |  41 +++++++++++++++--
 2 files changed, 98 insertions(+), 58 deletions(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 6d023af..0cf89a8 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -146,12 +146,6 @@ tls_ctx_free(struct tls_root_ctx *ctx)
             free(ctx->priv_key_pkcs11);
         }
 #endif
-#if defined(MANAGMENT_EXTERNAL_KEY)
-        if (ctx->external_key != NULL)
-        {
-            free(ctx->external_key);
-        }
-#endif
 
         if (ctx->allowed_ciphers)
         {
@@ -413,13 +407,6 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
     return 0;
 }
 
-#ifdef MANAGMENT_EXTERNAL_KEY
-
-
-struct external_context {
-    size_t signature_length;
-};
-
 /**
  * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that uses
  * the management interface to request an RSA signature for the supplied hash.
@@ -446,11 +433,9 @@ external_pkcs1_sign( void *ctx_voidptr,
                      unsigned char *sig )
 {
     struct external_context *const ctx = ctx_voidptr;
-    char *in_b64 = NULL;
-    char *out_b64 = NULL;
     int rv;
-    unsigned char *p = sig;
-    size_t asn_len = 0, oid_size = 0, sig_len = 0;
+    uint8_t *to_sign = NULL;
+    size_t asn_len = 0, oid_size = 0;
     const char *oid = NULL;
 
     if (NULL == ctx)
@@ -486,12 +471,14 @@ external_pkcs1_sign( void *ctx_voidptr,
         asn_len = 10 + oid_size;
     }
 
-    sig_len = ctx->signature_length;
-    if ( (SIZE_MAX - hashlen) < asn_len || (hashlen + asn_len) > sig_len)
+    if ((SIZE_MAX - hashlen) < asn_len
+        || ctx->signature_length < (asn_len + hashlen))
     {
         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
     }
 
+    ALLOC_ARRAY_CLEAR(to_sign, uint8_t, asn_len + hashlen);
+    uint8_t *p = to_sign;
     if (md_alg != MBEDTLS_MD_NONE)
     {
         /*
@@ -516,34 +503,16 @@ external_pkcs1_sign( void *ctx_voidptr,
         *p++ = MBEDTLS_ASN1_OCTET_STRING;
         *p++ = hashlen;
 
-        /* Determine added ASN length */
-        asn_len = p - sig;
+        /* Double-check ASN length */
+        ASSERT(asn_len == p - to_sign);
     }
 
     /* Copy the hash to be signed */
-    memcpy( p, hash, hashlen );
-
-    /* convert 'from' to base64 */
-    if (openvpn_base64_encode(sig, asn_len + hashlen, &in_b64) <= 0)
-    {
-        rv = MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-        goto done;
-    }
+    memcpy(p, hash, hashlen);
 
-    /* call MI for signature */
-    if (management)
-    {
-        out_b64 = management_query_rsa_sig(management, in_b64);
-    }
-    if (!out_b64)
-    {
-        rv = MBEDTLS_ERR_RSA_PRIVATE_FAILED;
-        goto done;
-    }
-
-    /* decode base64 signature to binary and verify length */
-    if (openvpn_base64_decode(out_b64, sig, ctx->signature_length) !=
-        ctx->signature_length)
+    /* Call external signature function */
+    if (!ctx->sign(ctx->sign_ctx, to_sign, asn_len + hashlen, sig,
+                   ctx->signature_length))
     {
         rv = MBEDTLS_ERR_RSA_PRIVATE_FAILED;
         goto done;
@@ -552,14 +521,7 @@ external_pkcs1_sign( void *ctx_voidptr,
     rv = 0;
 
 done:
-    if (in_b64)
-    {
-        free(in_b64);
-    }
-    if (out_b64)
-    {
-        free(out_b64);
-    }
+    free(to_sign);
     return rv;
 }
 
@@ -572,7 +534,8 @@ external_key_len(void *vctx)
 }
 
 int
-tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
+tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx,
+                                  external_sign_func sign_func, void *sign_ctx)
 {
     ASSERT(NULL != ctx);
 
@@ -582,11 +545,12 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
         return 0;
     }
 
-    ALLOC_OBJ_CLEAR(ctx->external_key, struct external_context);
-    ctx->external_key->signature_length = mbedtls_pk_get_len(&ctx->crt_chain->pk);
+    ctx->external_key.signature_length = mbedtls_pk_get_len(&ctx->crt_chain->pk);
+    ctx->external_key.sign = sign_func;
+    ctx->external_key.sign_ctx = sign_ctx;
 
     ALLOC_OBJ_CLEAR(ctx->priv_key, mbedtls_pk_context);
-    if (!mbed_ok(mbedtls_pk_setup_rsa_alt(ctx->priv_key, ctx->external_key,
+    if (!mbed_ok(mbedtls_pk_setup_rsa_alt(ctx->priv_key, &ctx->external_key,
                                           NULL, external_pkcs1_sign, external_key_len)))
     {
         return 0;
@@ -594,6 +558,47 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
 
     return 1;
 }
+
+#ifdef MANAGMENT_EXTERNAL_KEY
+
+/** Query the management interface for a signature, see external_sign_func. */
+static bool
+management_sign_func(void *sign_ctx, const void *src, size_t src_len,
+                     void *dst, size_t dst_len)
+{
+    bool ret = false;
+    char *src_b64 = NULL;
+    char *dst_b64 = NULL;
+
+    if (!management || (openvpn_base64_encode(src, src_len, &src_b64) <= 0))
+    {
+        goto cleanup;
+    }
+
+    if (!(dst_b64 = management_query_rsa_sig(management, src_b64)))
+    {
+        goto cleanup;
+    }
+
+    if (openvpn_base64_decode(dst_b64, dst, dst_len) != dst_len)
+    {
+        goto cleanup;
+    }
+
+    ret = true;
+cleanup:
+    free (src_b64);
+    free (dst_b64);
+
+    return ret;
+}
+
+int
+tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
+{
+    return tls_ctx_use_external_signing_func(ctx, management_sign_func, NULL);
+}
+
 #endif /* ifdef MANAGMENT_EXTERNAL_KEY */
 
 void
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index f69b610..2b76cc6 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -58,6 +58,30 @@ typedef struct {
 } bio_ctx;
 
 /**
+ * External signing function prototype.  A function pointer to a function
+ * implementing this prototype is provided to
+ * tls_ctx_use_external_signing_func().
+ *
+ * @param sign_ctx  The context for the signing function.
+ * @param src       The data to be signed,
+ * @param src_len   The length of src, in bytes.
+ * @param dst       The destination buffer for the signature.
+ * @param dst_len   The length of the destination buffer.
+ *
+ * @return true if signing succeeded, false otherwise.
+ */
+typedef bool (*external_sign_func)(
+        void *sign_ctx, const void *src, size_t src_size,
+        void *dst, size_t dst_size);
+
+/** Context used by external_pkcs1_sign() */
+struct external_context {
+    size_t signature_length;
+    external_sign_func sign;
+    void *sign_ctx;
+};
+
+/**
  * Structure that wraps the TLS context. Contents differ depending on the
  * SSL library used.
  *
@@ -78,9 +102,7 @@ struct tls_root_ctx {
 #if defined(ENABLE_PKCS11)
     mbedtls_pkcs11_context *priv_key_pkcs11;    /**< PKCS11 private key */
 #endif
-#ifdef MANAGMENT_EXTERNAL_KEY
-    struct external_context *external_key; /**< Management external key */
-#endif
+    struct external_context external_key; /**< External key context */
     int *allowed_ciphers;       /**< List of allowed ciphers for this connection */
 };
 
@@ -90,5 +112,18 @@ struct key_state_ssl {
     bio_ctx bio_ctx;
 };
 
+/**
+ * Call the supplied signing function to create a TLS signature during the
+ * TLS handshake.
+ *
+ * @param ctx                   TLS context to use.
+ * @param sign_func             Signing function to call.
+ * @param sign_ctx              Context for the sign function.
+ *
+ * @return                      0 if successful, 1 if an error occurred.
+ */
+int tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx,
+                                      external_sign_func sign_func,
+                                      void *sign_ctx);
 
 #endif /* SSL_MBEDTLS_H_ */
-- 
2.7.4


