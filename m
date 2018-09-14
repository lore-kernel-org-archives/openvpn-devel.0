From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 14 Sep 2018 11:14:17 +0200
Message-ID: <1536916459-25900-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
References: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/3] Do not load certificate from
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
v2: rebase onto current master

 src/openvpn/ssl.c         | 48 ++++++++++++++++-------------------
 src/openvpn/ssl_backend.h | 15 +++--------
 src/openvpn/ssl_mbedtls.c |  6 ++---
 src/openvpn/ssl_openssl.c | 64 +++++++++++++++++++++++------------------------
 4 files changed, 59 insertions(+), 74 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index dcb5445..4257c33 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -657,41 +657,37 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
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
+        if (tls_ctx_use_management_external_key(new_ctx))
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
index 202fe3f..5023c02 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -270,8 +270,7 @@ void tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
  *                              successful.
  */
 int tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                           const char *priv_key_file_inline
-                           );
+                           const char *priv_key_file_inline);
 
 #ifdef MANAGMENT_EXTERNAL_KEY
 
@@ -280,18 +279,12 @@ int tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
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
index ef83e65..3c6d872 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -621,15 +621,13 @@ external_key_len(void *vctx)
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
         return 1;
     }
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 012668a..bf00a38 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -795,11 +795,9 @@ tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio)
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
@@ -807,10 +805,6 @@ tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx,
     bool inline_file = false;
 
     ASSERT(NULL != ctx);
-    if (NULL != x509)
-    {
-        ASSERT(NULL == *x509);
-    }
 
     inline_file = (strcmp(cert_file, INLINE_FILE_TAG) == 0);
 
@@ -861,23 +855,12 @@ end:
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
@@ -1039,7 +1022,7 @@ rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
 static int
 openvpn_extkey_rsa_finish(RSA *rsa)
 {
-    /* meth was allocated in tls_ctx_use_external_private_key() ; since
+    /* meth was allocated in tls_ctx_use_management_external_key() ; since
      * this function is called when the parent RSA object is destroyed,
      * it is no longer used after this point so kill it. */
     const RSA_METHOD *meth = RSA_get_method(rsa);
@@ -1288,14 +1271,20 @@ err:
 #endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev */
 
 int
-tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
-                                 const char *cert_file, const char *cert_file_inline)
+tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
 {
-    X509 *cert = NULL;
+    int ret = 1;
 
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
 
@@ -1308,7 +1297,7 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     {
         if (!tls_ctx_use_external_rsa_key(ctx, pkey))
         {
-            goto err;
+            goto cleanup;
         }
     }
 #if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC) && !defined(LIBRESSL_VERSION_NUMBER)
@@ -1316,26 +1305,35 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     {
         if (!tls_ctx_use_external_ec_key(ctx, pkey))
         {
-            goto err;
+            goto cleanup;
         }
     }
     else
     {
         crypto_msg(M_WARN, "management-external-key requires an RSA or EC certificate");
-        goto err;
+        goto cleanup;
     }
 #else
     else
     {
         crypto_msg(M_WARN, "management-external-key requires an RSA certificate");
-        goto err;
+        goto cleanup;
     }
 #endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev */
-    return 0;
 
-err:
-    crypto_msg(M_FATAL, "Cannot enable SSL external private key capability");
-    return 1;
+    ret = 0;
+cleanup:
+#if OPENSSL_VERSION_NUMBER < 0x10002000L || defined(LIBRESSL_VERSION_NUMBER)
+    if (ssl)
+    {
+        SSL_free(ssl);
+    }
+#endif
+    if (ret)
+    {
+            crypto_msg(M_FATAL, "Cannot enable SSL external private key capability");
+    }
+    return ret;
 }
 
 #endif /* ifdef MANAGMENT_EXTERNAL_KEY */
-- 
2.7.4


