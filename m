From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 11 Sep 2017 23:52:00 +0200
Message-ID: <1505166722-5409-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
References: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Do not load certificate from
 tls_ctx_use_external_private_key()
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

The cert and key loading logic surrounding management-external-key and
management-external cert was somewhat intertwined.  Untangle these to
prepare for making the external key code more reusable.

The best part is that this even reduces the number of lines of code.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl.c         | 48 +++++++++++++++------------------
 src/openvpn/ssl_backend.h | 15 +++--------
 src/openvpn/ssl_mbedtls.c |  6 ++---
 src/openvpn/ssl_openssl.c | 68 +++++++++++++++++++++--------------------------
 4 files changed, 58 insertions(+), 79 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cb94229..4582454 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -649,41 +649,37 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
     }
 #endif
 #ifdef MANAGMENT_EXTERNAL_KEY
-    else if ((options->management_flags & MF_EXTERNAL_KEY)
-             && (options->cert_file || options->management_flags & MF_EXTERNAL_CERT))
+    else if (options->management_flags & MF_EXTERNAL_CERT)
     {
-        if (options->cert_file)
-        {
-            tls_ctx_use_external_private_key(new_ctx, options->cert_file,
-                                             options->cert_file_inline);
-        }
-        else
-        {
-            char *external_certificate = management_query_cert(management,
-                                                               options->management_certificate);
-            tls_ctx_use_external_private_key(new_ctx, INLINE_FILE_TAG,
-                                             external_certificate);
-            free(external_certificate);
-        }
+        char *cert = management_query_cert(management,
+                                           options->management_certificate);
+        tls_ctx_load_cert_file(new_ctx, INLINE_FILE_TAG, cert);
+        free(cert);
     }
 #endif
-    else
+    else if (options->cert_file)
+    {
+        tls_ctx_load_cert_file(new_ctx, options->cert_file, options->cert_file_inline);
+    }
+
+    if (options->priv_key_file)
     {
-        /* Load Certificate */
-        if (options->cert_file)
+        if (0 != tls_ctx_load_priv_file(new_ctx, options->priv_key_file,
+                                        options->priv_key_file_inline))
         {
-            tls_ctx_load_cert_file(new_ctx, options->cert_file, options->cert_file_inline);
+            goto err;
         }
-
-        /* Load Private Key */
-        if (options->priv_key_file)
+    }
+#ifdef MANAGMENT_EXTERNAL_KEY
+    else if (options->management_flags & MF_EXTERNAL_KEY)
+    {
+        if (!tls_ctx_use_management_external_key(new_ctx))
         {
-            if (0 != tls_ctx_load_priv_file(new_ctx, options->priv_key_file, options->priv_key_file_inline))
-            {
-                goto err;
-            }
+            msg (M_WARN, "Cannot initialize mamagement-external-key");
+            goto err;
         }
     }
+#endif
 
     if (options->ca_file || options->ca_path)
     {
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index aba5a4d..6fa885d 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -259,8 +259,7 @@ void tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
  *                              successful.
  */
 int tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                           const char *priv_key_file_inline
-                           );
+                           const char *priv_key_file_inline);
 
 #ifdef MANAGMENT_EXTERNAL_KEY
 
@@ -269,18 +268,12 @@ int tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
  * private key matching the given certificate.
  *
  * @param ctx                   TLS context to use
- * @param cert_file             The file name to load the certificate from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param cert_file_inline      A string containing the certificate
  *
- * @return                      1 if an error occurred, 0 if parsing was
- *                              successful.
+ * @return                      1 if an error occurred, 0 if successful.
  */
-int tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
-                                     const char *cert_file, const char *cert_file_inline);
-
-#endif
+int tls_ctx_use_management_external_key(struct tls_root_ctx *ctx);
 
+#endif /* MANAGMENT_EXTERNAL_KEY */
 
 /**
  * Load certificate authority certificates from the given file or path.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 861d936..6d023af 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -572,15 +572,13 @@ external_key_len(void *vctx)
 }
 
 int
-tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
-                                 const char *cert_file, const char *cert_file_inline)
+tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
 {
     ASSERT(NULL != ctx);
 
-    tls_ctx_load_cert_file(ctx, cert_file, cert_file_inline);
-
     if (ctx->crt_chain == NULL)
     {
+        msg (M_WARN, "ERROR: external key requires a certificate.");
         return 0;
     }
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 92a662b..1b93153 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -723,11 +723,9 @@ tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio)
     }
 }
 
-/* Like tls_ctx_load_cert, but returns a copy of the certificate in **X509 */
-static void
-tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx,
-                                const char *cert_file, const char *cert_file_inline, X509 **x509
-                                )
+void
+tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
+                       const char *cert_file_inline)
 {
     BIO *in = NULL;
     X509 *x = NULL;
@@ -735,10 +733,6 @@ tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx,
     bool inline_file = false;
 
     ASSERT(NULL != ctx);
-    if (NULL != x509)
-    {
-        ASSERT(NULL == *x509);
-    }
 
     inline_file = (strcmp(cert_file, INLINE_FILE_TAG) == 0);
 
@@ -789,23 +783,12 @@ end:
     {
         BIO_free(in);
     }
-    if (x509)
-    {
-        *x509 = x;
-    }
     else if (x)
     {
         X509_free(x);
     }
 }
 
-void
-tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
-                       const char *cert_file_inline)
-{
-    tls_ctx_load_cert_file_and_copy(ctx, cert_file, cert_file_inline, NULL);
-}
-
 int
 tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
                        const char *priv_key_file_inline
@@ -967,7 +950,7 @@ rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
 static int
 openvpn_extkey_rsa_finish(RSA *rsa)
 {
-    /* meth was allocated in tls_ctx_use_external_private_key() ; since
+    /* meth was allocated in tls_ctx_use_management_external_key() ; since
      * this function is called when the parent RSA object is destroyed,
      * it is no longer used after this point so kill it. */
     const RSA_METHOD *meth = RSA_get_method(rsa);
@@ -1029,18 +1012,25 @@ done:
     return ret;
 }
 
+
 int
-tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
-                                 const char *cert_file, const char *cert_file_inline)
+tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
 {
+    int ret = 0;
     RSA *rsa = NULL;
     RSA *pub_rsa;
     RSA_METHOD *rsa_meth;
-    X509 *cert = NULL;
 
     ASSERT(NULL != ctx);
 
-    tls_ctx_load_cert_file_and_copy(ctx, cert_file, cert_file_inline, &cert);
+#if OPENSSL_VERSION_NUMBER >= 0x10002000L && !defined(LIBRESSL_VERSION_NUMBER)
+    /* OpenSSL 1.0.2 and up */
+    X509 *cert = SSL_CTX_get0_certificate(ctx->ctx);
+#else
+    /* OpenSSL 1.0.1 and earlier need an SSL object to get at the certificate */
+    SSL *ssl = SSL_new(ctx->ctx);
+    X509 *cert = SSL_get_certificate(ssl);
+#endif
 
     ASSERT(NULL != cert);
 
@@ -1061,7 +1051,7 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     if (rsa == NULL)
     {
         SSLerr(SSL_F_SSL_USE_PRIVATEKEY, ERR_R_MALLOC_FAILURE);
-        goto err;
+        goto cleanup;
     }
 
     /* get the public key */
@@ -1073,7 +1063,7 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     if (!pub_rsa)
     {
         crypto_msg(M_WARN, "management-external-key requires a RSA certificate");
-        goto err;
+        goto cleanup;
     }
 
     /* initialize RSA object */
@@ -1084,24 +1074,23 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     RSA_set_flags(rsa, RSA_flags(rsa) | RSA_FLAG_EXT_PKEY);
     if (!RSA_set_method(rsa, rsa_meth))
     {
-        goto err;
+        goto cleanup;
     }
 
     /* bind our custom RSA object to ssl_ctx */
     if (!SSL_CTX_use_RSAPrivateKey(ctx->ctx, rsa))
     {
-        goto err;
+        goto cleanup;
     }
 
-    X509_free(cert);
-    RSA_free(rsa); /* doesn't necessarily free, just decrements refcount */
-    return 1;
-
-err:
-    if (cert)
+    ret = 1;
+cleanup:
+#if OPENSSL_VERSION_NUMBER < 0x10002000L || defined(LIBRESSL_VERSION_NUMBER)
+    if (ssl)
     {
-        X509_free(cert);
+        SSL_free(ssl);
     }
+#endif
     if (rsa)
     {
         RSA_free(rsa);
@@ -1113,8 +1102,11 @@ err:
             free(rsa_meth);
         }
     }
-    crypto_msg(M_FATAL, "Cannot enable SSL external private key capability");
-    return 0;
+    if (!ret)
+    {
+        crypto_msg(M_FATAL, "Cannot enable SSL external private key capability");
+    }
+    return ret;
 }
 
 #endif /* ifdef MANAGMENT_EXTERNAL_KEY */
-- 
2.7.4


