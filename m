From: Steffan Karger <steffan@...1856...>
Date: Sat, 21 Nov 2015 12:41:00 +0100
Message-Id: <1448106060-19469-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] polarssl: don't use deprecated functions
	anymore
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

A number of functions were deprecated in polarssl 1.3.11.  Stop using
these, and use their alternatives instead.

This enables (and also almost forces) us to move the pkcs11 and external
key logic from the per-connection setup (key_state_ssl_init()) to the
per-instance setup (tls_ctx_use_{pkcs11,external_private_key}()).

Note that tls_ctx_use_external_private_key() is now placed right below
external_pkcs1_sign() and external_key_len(), instead of right above,
because it now needs to be aware of those static functions.

Tested with:
 * PEM key files
 * pkcs11
 * management-external-key

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_polarssl.c     |  6 ++--
 src/openvpn/pkcs11_polarssl.c     |  6 ++++
 src/openvpn/ssl_polarssl.c        | 59 +++++++++++++++++----------------------
 src/openvpn/ssl_verify_polarssl.c |  5 ++--
 4 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index af6e873..dec6d9a 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -485,7 +485,7 @@ cipher_ctx_init (cipher_context_t *ctx, uint8_t *key, int key_len,
 
 void cipher_ctx_cleanup (cipher_context_t *ctx)
 {
-  ASSERT (polar_ok(cipher_free_ctx(ctx)));
+  cipher_free(ctx);
 }
 
 int cipher_ctx_iv_length (const cipher_context_t *ctx)
@@ -649,7 +649,7 @@ void
 md_ctx_final (md_context_t *ctx, uint8_t *dst)
 {
   ASSERT(0 == md_finish(ctx, dst));
-  ASSERT(0 == md_free_ctx(ctx));
+  md_free(ctx);
 }
 
 
@@ -680,7 +680,7 @@ hmac_ctx_init (md_context_t *ctx, const uint8_t *key, int key_len, const md_info
 void
 hmac_ctx_cleanup(md_context_t *ctx)
 {
-  ASSERT(0 == md_free_ctx(ctx));
+  md_free(ctx);
 }
 
 int
diff --git a/src/openvpn/pkcs11_polarssl.c b/src/openvpn/pkcs11_polarssl.c
index 4018b22..ccb6f8c 100644
--- a/src/openvpn/pkcs11_polarssl.c
+++ b/src/openvpn/pkcs11_polarssl.c
@@ -62,6 +62,12 @@ pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
       goto cleanup;
   }
 
+  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key, pk_context);
+  if (!polar_ok(pk_init_ctx_rsa_alt(ssl_ctx->priv_key, ssl_ctx->priv_key_pkcs11,
+	ssl_pkcs11_decrypt, ssl_pkcs11_sign, ssl_pkcs11_key_len))) {
+      goto cleanup;
+  }
+
   ret = 0;
 
 cleanup:
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 5653f6c..bb58746 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -356,24 +356,6 @@ struct external_context {
   size_t signature_length;
 };
 
-int
-tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
-    const char *cert_file, const char *cert_file_inline)
-{
-  ASSERT(NULL != ctx);
-
-  tls_ctx_load_cert_file(ctx, cert_file, cert_file_inline);
-
-  if (ctx->crt_chain == NULL)
-    return 0;
-
-  /* Most of the initialization happens in key_state_ssl_init() */
-  ALLOC_OBJ_CLEAR (ctx->external_key, struct external_context);
-  ctx->external_key->signature_length = pk_get_len(&ctx->crt_chain->pk);
-
-  return 1;
-}
-
 /**
  * external_pkcs1_sign implements a PolarSSL rsa_sign_func callback, that uses
  * the management interface to request an RSA signature for the supplied hash.
@@ -506,6 +488,28 @@ static inline size_t external_key_len(void *vctx)
 
   return ctx->signature_length;
 }
+
+int
+tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
+    const char *cert_file, const char *cert_file_inline)
+{
+  ASSERT(NULL != ctx);
+
+  tls_ctx_load_cert_file(ctx, cert_file, cert_file_inline);
+
+  if (ctx->crt_chain == NULL)
+    return 0;
+
+  ALLOC_OBJ_CLEAR (ctx->external_key, struct external_context);
+  ctx->external_key->signature_length = pk_get_len(&ctx->crt_chain->pk);
+
+  ALLOC_OBJ_CLEAR (ctx->priv_key, pk_context);
+  if (!polar_ok(pk_init_ctx_rsa_alt(ctx->priv_key, ctx->external_key,
+	    NULL, external_pkcs1_sign, external_key_len)))
+    return 0;
+
+  return 1;
+}
 #endif
 
 void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
@@ -759,22 +763,9 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
       /* Initialise authentication information */
       if (is_server)
 	polar_ok(ssl_set_dh_param_ctx(ks_ssl->ctx, ssl_ctx->dhm_ctx));
-#if defined(ENABLE_PKCS11)
-      if (ssl_ctx->priv_key_pkcs11 != NULL)
-	polar_ok(ssl_set_own_cert_alt(ks_ssl->ctx, ssl_ctx->crt_chain,
-	    ssl_ctx->priv_key_pkcs11, ssl_pkcs11_decrypt, ssl_pkcs11_sign,
-	    ssl_pkcs11_key_len));
-      else
-#endif
-#if defined(MANAGMENT_EXTERNAL_KEY)
-      if (ssl_ctx->external_key != NULL)
-	polar_ok(ssl_set_own_cert_alt(ks_ssl->ctx, ssl_ctx->crt_chain,
-	   ssl_ctx->external_key, NULL, external_pkcs1_sign,
-	   external_key_len));
-      else
-#endif
-	polar_ok(ssl_set_own_cert(ks_ssl->ctx, ssl_ctx->crt_chain,
-	    ssl_ctx->priv_key));
+
+      polar_ok(ssl_set_own_cert(ks_ssl->ctx, ssl_ctx->crt_chain,
+	  ssl_ctx->priv_key));
 
       /* Initialise SSL verification */
 #if P2MP_SERVER
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index fa313ac..62818ad 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -319,8 +319,7 @@ x509_verify_cert_eku (x509_crt *cert, const char * const expected_oid)
 	  char oid_num_str[1024];
 	  const char *oid_str;
 
-	  oid_str = x509_oid_get_description(oid);
-	  if (oid_str != NULL)
+	  if (0 == oid_get_extended_key_usage( oid, &oid_str ))
 	    {
 	      msg (D_HANDSHAKE, "++ Certificate has EKU (str) %s, expects %s",
 		  oid_str, expected_oid);
@@ -331,7 +330,7 @@ x509_verify_cert_eku (x509_crt *cert, const char * const expected_oid)
 		}
 	    }
 
-	  if (0 < x509_oid_get_numeric_string( oid_num_str,
+	  if (0 < oid_get_numeric_string( oid_num_str,
 	      sizeof (oid_num_str), oid))
 	    {
 	      msg (D_HANDSHAKE, "++ Certificate has EKU (oid) %s, expects %s",
-- 
2.5.0


