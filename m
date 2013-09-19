From: <steffan.karger@...1435...>
Date: Thu, 19 Sep 2013 12:47:28 +0200
Message-ID: <1379587649-25506-3-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1379587649-25506-1-git-send-email-steffan.karger@...1435...>
References: <1379587649-25506-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] --management-external-key for PolarSSL
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

From: Joachim Schipper <joachim.schipper@...1435...>

Add --management-external-key support, compatible with the OpenSSL
implementation. Needs the flexibility of ssl_set_own_cert_alt(), which is new
in PolarSSL-1.2.

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl_polarssl.c |  100 ++++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/ssl_polarssl.h |    5 +++
 src/openvpn/syshead.h      |    2 +-
 3 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 1e2c4d5..418a2f9 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -121,6 +121,10 @@ tls_ctx_free(struct tls_root_ctx *ctx)
 	  free(ctx->priv_key_pkcs11);
       }
 #endif
+#if defined(MANAGMENT_EXTERNAL_KEY)
+      if (ctx->external_key != NULL)
+          free(ctx->external_key);
+#endif
 
       if (ctx->allowed_ciphers)
 	free(ctx->allowed_ciphers);
@@ -309,14 +313,95 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
 
 #ifdef MANAGMENT_EXTERNAL_KEY
 
+
+struct external_context {
+  size_t signature_length;
+};
+
+int
 tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
-    const char *cert_file, const char *cert_file_inline
-    )
+    const char *cert_file, const char *cert_file_inline)
 {
-  msg(M_FATAL, "Use of management external keys not yet supported for PolarSSL.");
-  return false;
+  ASSERT(NULL != ctx);
+
+  tls_ctx_load_cert_file(ctx, cert_file, cert_file_inline);
+
+  if (ctx->crt_chain == NULL)
+    return 0;
+
+  /* Most of the initialization happens in key_state_ssl_init() */
+  ALLOC_OBJ_CLEAR (ctx->external_key, struct external_context);
+  ctx->external_key->signature_length = ctx->crt_chain->rsa.len;
+
+  return 1;
 }
 
+static inline int external_pkcs1_sign( void *ctx_voidptr,
+    int (*f_rng)(void *, unsigned char *, size_t), void *p_rng, int mode,
+    int hash_id, unsigned int hashlen, const unsigned char *hash,
+    unsigned char *sig )
+{
+  struct external_context * const ctx = ctx_voidptr;
+  char *in_b64 = NULL;
+  char *out_b64 = NULL;
+  int rv;
+
+  ASSERT(NULL != ctx);
+
+  if (RSA_PRIVATE != mode)
+    {
+      rv = POLARSSL_ERR_RSA_BAD_INPUT_DATA;
+      goto done;
+    }
+
+  /*
+   * Normally (i.e. rsa_pkcs1_sign()), the padding is set in the context, and
+   * we have padding-specific code to handle various hash_id's here. Since the
+   * management client will RSA-sign the bytes we present without further
+   * processing, we only support SIG_RSA_RAW (PolarSSL's equivalent of
+   * OpenSSL's NID_md5_sha1).
+   */
+  ASSERT(hash_id == SIG_RSA_RAW);
+  /* convert 'from' to base64 */
+  if (openvpn_base64_encode (hash, hashlen, &in_b64) <= 0)
+    {
+      rv = POLARSSL_ERR_RSA_BAD_INPUT_DATA;
+      goto done;
+    }
+
+  /* call MI for signature */
+  if (management)
+    out_b64 = management_query_rsa_sig (management, in_b64);
+  if (!out_b64)
+    {
+      rv = POLARSSL_ERR_RSA_PRIVATE_FAILED;
+      goto done;
+    }
+
+  /* decode base64 signature to binary and verify length */
+  if ( openvpn_base64_decode (out_b64, sig, ctx->signature_length) !=
+       ctx->signature_length )
+    {
+      rv = POLARSSL_ERR_RSA_PRIVATE_FAILED;
+      goto done;
+    }
+
+  rv = 0;
+
+ done:
+  if (in_b64)
+    free (in_b64);
+  if (out_b64)
+    free (out_b64);
+  return rv;
+}
+
+static inline size_t external_key_len(void *vctx)
+{
+  struct external_context * const ctx = vctx;
+
+  return ctx->signature_length;
+}
 #endif
 
 void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
@@ -530,6 +615,13 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
 	    ssl_pkcs11_key_len );
       else
 #endif
+#if defined(MANAGMENT_EXTERNAL_KEY)
+      if (ssl_ctx->external_key != NULL)
+        ssl_set_own_cert_alt( ks_ssl->ctx, ssl_ctx->crt_chain,
+	   ssl_ctx->external_key, NULL, external_pkcs1_sign,
+	   external_key_len );
+      else
+#endif
 	ssl_set_own_cert( ks_ssl->ctx, ssl_ctx->crt_chain, ssl_ctx->priv_key );
 
       /* Initialise SSL verification */
diff --git a/src/openvpn/ssl_polarssl.h b/src/openvpn/ssl_polarssl.h
index da93699..fc9aa78 100644
--- a/src/openvpn/ssl_polarssl.h
+++ b/src/openvpn/ssl_polarssl.h
@@ -30,6 +30,8 @@
 #ifndef SSL_POLARSSL_H_
 #define SSL_POLARSSL_H_
 
+#include "syshead.h"
+
 #include <polarssl/ssl.h>
 
 #if defined(ENABLE_PKCS11)
@@ -68,6 +70,9 @@ struct tls_root_ctx {
 #if defined(ENABLE_PKCS11)
     pkcs11_context *priv_key_pkcs11;	/**< PKCS11 private key */
 #endif
+#ifdef MANAGMENT_EXTERNAL_KEY
+    struct external_context *external_key; /**< Management external key */
+#endif
     int * allowed_ciphers;	/**< List of allowed ciphers for this connection */
 };
 
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index df6927d..51b2402 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -539,7 +539,7 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Enable external private key
  */
-#if defined(ENABLE_MANAGEMENT) && defined(ENABLE_SSL) && !defined(ENABLE_CRYPTO_POLARSSL)
+#if defined(ENABLE_MANAGEMENT) && defined(ENABLE_SSL)
 #define MANAGMENT_EXTERNAL_KEY
 #endif
 
-- 
1.7.9.5


