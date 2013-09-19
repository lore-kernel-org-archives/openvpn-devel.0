From: <steffan.karger@...1435...>
Date: Thu, 19 Sep 2013 12:47:27 +0200
Message-ID: <1379587649-25506-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1379587649-25506-1-git-send-email-steffan.karger@...1435...>
References: <1379587649-25506-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Refactor
	tls_ctx_use_external_private_key()
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

OpenSSL's tls_ctx_load_cert_file() had a parameter in which a copy of the
context's certificate chain was stored on return, used by
tls_ctx_use_external_private_key() only and free()d immediately thereafter.

PolarSSL also supported this output parameter, but returned a pointer to the
context's certificate chain (rather than to a copy of the certificate, as
OpenSSL does) - which meant that we would have to #ifdef the free().

PolarSSL cannot make a copy of a certificate chain, and OpenSSL cannot store a
pointer to (instead of a copy of) the cert.

So remove the output parameter from tls_ctx_load_cert_file() and incorporate
the needed functionality directly into tls_ctx_use_external_private_key()
(which is straightforward for both OpenSSL and PolarSSL, as long as you don't
try to support both at once.)

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 src/openvpn/ssl.c          |   10 +++-------
 src/openvpn/ssl_backend.h  |   26 +++++++-------------------
 src/openvpn/ssl_openssl.c  |   23 +++++++++++++++++++----
 src/openvpn/ssl_polarssl.c |   20 ++++----------------
 4 files changed, 33 insertions(+), 46 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e4b802f..760104d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -513,12 +513,8 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
 #ifdef MANAGMENT_EXTERNAL_KEY
   else if ((options->management_flags & MF_EXTERNAL_KEY) && options->cert_file)
     {
-      openvpn_x509_cert_t *my_cert = NULL;
-      tls_ctx_load_cert_file(new_ctx, options->cert_file, options->cert_file_inline,
-	  &my_cert);
-      tls_ctx_use_external_private_key(new_ctx, my_cert);
-
-      tls_ctx_free_cert_file(my_cert);
+      tls_ctx_use_external_private_key(new_ctx, options->cert_file,
+	  options->cert_file_inline);
     }
 #endif
   else
@@ -526,7 +522,7 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
       /* Load Certificate */
       if (options->cert_file)
 	{
-          tls_ctx_load_cert_file(new_ctx, options->cert_file, options->cert_file_inline, NULL);
+          tls_ctx_load_cert_file(new_ctx, options->cert_file, options->cert_file_inline);
 	}
 
       /* Load Private Key */
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 4d2958c..07cb9ab 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -215,27 +215,13 @@ void tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert
  * Load certificate file into the given TLS context. If the given certificate
  * file contains a certificate chain, load the whole chain.
  *
- * If the x509 parameter is not NULL, the certificate will be returned in it.
- *
  * @param ctx			TLS context to use
  * @param cert_file		The file name to load the certificate from, or
  * 				"[[INLINE]]" in the case of inline files.
  * @param cert_file_inline	A string containing the certificate
- * @param x509			An optional certificate, if x509 is NULL,
- * 				do nothing, if x509 is not NULL, *x509 will be
- * 				allocated and filled with the loaded certificate.
- * 				*x509 must be NULL.
  */
 void tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
-    const char *cert_file_inline, openvpn_x509_cert_t **x509
-    );
-
-/**
- * Free the given certificate
- *
- * @param x509			certificate to free
- */
-void tls_ctx_free_cert_file (openvpn_x509_cert_t *x509);
+    const char *cert_file_inline);
 
 /**
  * Load private key file into the given TLS context.
@@ -255,17 +241,19 @@ int tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
 #ifdef MANAGMENT_EXTERNAL_KEY
 
 /**
- * Tell the management interface to load the external private key matching
- * the given certificate.
+ * Tell the management interface to load the given certificate and the external
+ * private key matching the given certificate.
  *
  * @param ctx			TLS context to use
- * @param cert			The certificate file to load the private key for
+ * @param cert_file		The file name to load the certificate from, or
  * 				"[[INLINE]]" in the case of inline files.
+ * @param cert_file_inline	A string containing the certificate
  *
  * @return 			1 if an error occurred, 0 if parsing was
  * 				successful.
  */
-int tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, openvpn_x509_cert_t *cert);
+int tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
+    const char *cert_file, const char *cert_file_inline);
 #endif
 
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 12c725d..f0f7fba 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -456,9 +456,10 @@ tls_ctx_add_extra_certs (struct tls_root_ctx *ctx, BIO *bio)
     }
 }
 
-void
-tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
-    const char *cert_file_inline, X509 **x509
+/* Like tls_ctx_load_cert, but returns a copy of the certificate in **X509 */
+static void
+tls_ctx_load_cert_file_and_copy (struct tls_root_ctx *ctx,
+    const char *cert_file, const char *cert_file_inline, X509 **x509
     )
 {
   BIO *in = NULL;
@@ -513,6 +514,13 @@ end:
 }
 
 void
+tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
+    const char *cert_file_inline)
+{
+  tls_ctx_load_cert_file_ext(ctx, cert_file, cert_file_inline, NULL);
+}
+
+void
 tls_ctx_free_cert_file (X509 *x509)
 {
   X509_free(x509);
@@ -648,15 +656,19 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
 }
 
 int
-tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, X509 *cert)
+tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
+    const char *cert_file, const char *cert_file_inline)
 {
   RSA *rsa = NULL;
   RSA *pub_rsa;
   RSA_METHOD *rsa_meth;
+  X509 *cert = NULL;
 
   ASSERT (NULL != ctx);
   ASSERT (NULL != cert);
 
+  tls_ctx_load_cert_file_ext(ctx, cert_file, cert_file_inline, &cert);
+
   /* allocate custom RSA method object */
   ALLOC_OBJ_CLEAR (rsa_meth, RSA_METHOD);
   rsa_meth->name = "OpenVPN external private key RSA Method";
@@ -691,10 +703,13 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, X509 *cert)
   if (!SSL_CTX_use_RSAPrivateKey(ctx->ctx, rsa))
     goto err;
 
+  X509_free(cert);
   RSA_free(rsa); /* doesn't necessarily free, just decrements refcount */
   return 1;
 
  err:
+  if (cert)
+    X509_free(cert);
   if (rsa)
     RSA_free(rsa);
   else
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index fb73225..1e2c4d5 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -237,13 +237,10 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 
 void
 tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
-    const char *cert_file_inline,
-    openvpn_x509_cert_t **x509
+    const char *cert_file_inline
     )
 {
   ASSERT(NULL != ctx);
-  if (NULL != x509)
-    ASSERT(NULL == *x509);
 
   if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_file_inline)
     {
@@ -256,16 +253,6 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
       if (0 != x509parse_crtfile(ctx->crt_chain, cert_file))
 	msg (M_FATAL, "Cannot load certificate file %s", cert_file);
     }
-  if (x509)
-    {
-      *x509 = ctx->crt_chain;
-    }
-}
-
-void
-tls_ctx_free_cert_file (openvpn_x509_cert_t *x509)
-{
-  x509_free(x509);
 }
 
 int
@@ -322,8 +309,9 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
 
 #ifdef MANAGMENT_EXTERNAL_KEY
 
-int
-tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, openvpn_x509_cert_t *cert)
+tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
+    const char *cert_file, const char *cert_file_inline
+    )
 {
   msg(M_FATAL, "Use of management external keys not yet supported for PolarSSL.");
   return false;
-- 
1.7.9.5


