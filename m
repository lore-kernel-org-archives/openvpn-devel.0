From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 28 Oct 2016 17:54:47 +0200
Message-ID: <1477670087-30063-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Refactor CRL handling
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
Cc: Ivo Manca <ivo.manca@...1435...>

This patch refactors the CRL handling to rely more on the implementation
of the crypto library.  It will insert the CRL at the correct time to keep
it up to date, but all additional verification logic is removed from
ssl_verify_<backend>.c.  "Less code of our own, less bugs of our own."

In practice, this means extra checks will be performed on the CRL, such as
checking it validBefore and validAfter fields.

This patch was originally written by Ivo Manca, and then molded by Steffan
before sending to the list.  All bugs are Steffan's fault.

Thanks also go to Antonio Quartulli for useful feedback.  He'll send
follow-up patches to improve CRL handling performance.

Signed-off-by: Ivo Manca <ivo.manca@...1435...>
Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 Changes.rst                      |  6 +++
 src/openvpn/ssl.c                | 15 +++++++
 src/openvpn/ssl_backend.h        | 11 +++++
 src/openvpn/ssl_mbedtls.c        | 43 +++++++++++++++++-
 src/openvpn/ssl_mbedtls.h        |  1 +
 src/openvpn/ssl_openssl.c        | 58 ++++++++++++++++++++++++
 src/openvpn/ssl_verify.c         | 19 ++++----
 src/openvpn/ssl_verify_backend.h | 19 +++-----
 src/openvpn/ssl_verify_mbedtls.c | 56 +++--------------------
 src/openvpn/ssl_verify_openssl.c | 96 ++++++++++++++++------------------------
 10 files changed, 193 insertions(+), 131 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 0118e78..3df35a7 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -173,6 +173,12 @@ User-visible Changes
   capable. The ``--tun-ipv6`` option is ignored (behaves like it is always
   on).
 
+- CRLs are now handled by the crypto library (OpenSSL or mbed TLS), instead of
+  inside OpenVPN itself.  The crypto library implementations are more strict
+  than the OpenVPN implementation was.  This might reject peer certificates
+  that would previously be accepted.  If this occurs, OpenVPN will log the
+  crypto library's error description.
+
 
 Maintainer-visible changes
 --------------------------
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7f370b7..1307569 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -608,6 +608,12 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
   /* Check certificate notBefore and notAfter */
   tls_ctx_check_cert_time(new_ctx);
 
+  /* Read CRL */
+  if (options->crl_file && !(options->ssl_flags & SSLF_CRL_VERIFY_DIR))
+    {
+      tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_inline);
+    }
+
   /* Once keys and cert are loaded, load ECDH parameters */
   if (options->tls_server)
     tls_ctx_load_ecdh_params(new_ctx, options->ecdh_curve);
@@ -2496,6 +2502,15 @@ tls_process (struct tls_multi *multi,
 	{
 	  ks->state = S_START;
 	  state_change = true;
+
+	  /* Reload the CRL before TLS negotiation */
+	  if (session->opt->crl_file &&
+	      !(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))
+	    {
+	      tls_ctx_reload_crl(&session->opt->ssl_ctx,
+		  session->opt->crl_file, session->opt->crl_file_inline);
+	    }
+
 	  dmsg (D_TLS_DEBUG_MED, "STATE S_START");
 	}
 
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 542c373..a393a0c 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -344,6 +344,17 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
 void key_state_ssl_free(struct key_state_ssl *ks_ssl);
 
 /**
+ * Reload the Certificate Revocation List for the SSL channel
+ *
+ * @param ssl_ctx       The TLS context to use when reloading the CRL
+ * @param crl_file      The file name to load the CRL from, or
+ *                      "[[INLINE]]" in the case of inline files.
+ * @param crl_inline    A string containing the CRL
+ */
+void tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
+    const char *crl_file, const char *crl_inline);
+
+/**
  * Keying Material Exporters [RFC 5705] allows additional keying material to be
  * derived from existing TLS channel. This exported keying material can then be
  * used for a variety of purposes.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 8a761a4..aa14d4a 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -120,6 +120,12 @@ tls_ctx_free(struct tls_root_ctx *ctx)
       if (ctx->dhm_ctx)
 	free(ctx->dhm_ctx);
 
+      mbedtls_x509_crl_free(ctx->crl);
+      if (ctx->crl)
+	{
+	  free(ctx->crl);
+	}
+
 #if defined(ENABLE_PKCS11)
       if (ctx->priv_key_pkcs11 != NULL) {
 	  mbedtls_pkcs11_priv_key_free(ctx->priv_key_pkcs11);
@@ -766,6 +772,41 @@ static void tls_version_to_major_minor(int tls_ver, int *major, int *minor) {
   }
 }
 
+void
+tls_ctx_reload_crl(struct tls_root_ctx *ctx, const char *crl_file,
+    const char *crl_inline)
+{
+  ASSERT (crl_file);
+
+  if (ctx->crl == NULL)
+    {
+      ALLOC_OBJ_CLEAR(ctx->crl, mbedtls_x509_crl);
+    }
+  mbedtls_x509_crl_free(ctx->crl);
+
+  if (!strcmp (crl_file, INLINE_FILE_TAG) && crl_inline)
+    {
+      if (!mbed_ok(mbedtls_x509_crl_parse(ctx->crl,
+	(const unsigned char *)crl_inline, strlen(crl_inline)+1)))
+	{
+	  msg (M_WARN, "CRL: cannot parse inline CRL");
+	  goto err;
+	}
+    }
+  else
+    {
+      if (!mbed_ok(mbedtls_x509_crl_parse_file(ctx->crl, crl_file)))
+	{
+	  msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
+	  goto err;
+	}
+    }
+  return;
+
+err:
+  mbedtls_x509_crl_free(ctx->crl);
+}
+
 void key_state_ssl_init(struct key_state_ssl *ks_ssl,
     const struct tls_root_ctx *ssl_ctx, bool is_server, struct tls_session *session)
 {
@@ -818,7 +859,7 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
   mbedtls_ssl_conf_verify (&ks_ssl->ssl_config, verify_callback, session);
 
   /* TODO: mbed TLS does not currently support sending the CA chain to the client */
-  mbedtls_ssl_conf_ca_chain (&ks_ssl->ssl_config, ssl_ctx->ca_chain, NULL );
+  mbedtls_ssl_conf_ca_chain (&ks_ssl->ssl_config, ssl_ctx->ca_chain, ssl_ctx->crl);
 
   /* Initialize minimum TLS version */
   {
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 6f778ef..3edeedc 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -73,6 +73,7 @@ struct tls_root_ctx {
     mbedtls_x509_crt *crt_chain;	/**< Local Certificate chain */
     mbedtls_x509_crt *ca_chain;		/**< CA chain for remote verification */
     mbedtls_pk_context *priv_key;	/**< Local private key */
+    mbedtls_x509_crl *crl;              /**< Certificate Revocation List */
 #if defined(ENABLE_PKCS11)
     mbedtls_pkcs11_context *priv_key_pkcs11;	/**< PKCS11 private key */
 #endif
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8909ca3..fc114e7 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -773,6 +773,64 @@ end:
   return ret;
 }
 
+void
+tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
+        const char *crl_inline)
+{
+  X509_CRL *crl = NULL;
+  BIO *in = NULL;
+
+  X509_STORE *store = SSL_CTX_get_cert_store(ssl_ctx->ctx);
+  if (!store)
+    crypto_msg (M_FATAL, "Cannot get certificate store");
+
+  /* Always start with a cleared CRL list, for that we
+   * we need to manually find the CRL object from the stack
+   * and remove it */
+  for (int i = 0; i < sk_X509_OBJECT_num(store->objs); i++)
+    {
+      X509_OBJECT* obj = sk_X509_OBJECT_value(store->objs, i);
+      ASSERT(obj);
+      if (obj->type == X509_LU_CRL)
+	{
+	  sk_X509_OBJECT_delete(store->objs, i);
+	  X509_OBJECT_free_contents(obj);
+	  OPENSSL_free(obj);
+	}
+    }
+
+  X509_STORE_set_flags (store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHECK_ALL);
+
+  if (!strcmp (crl_file, INLINE_FILE_TAG) && crl_inline)
+    in = BIO_new_mem_buf ((char *)crl_inline, -1);
+  else
+    in = BIO_new_file (crl_file, "r");
+
+  if (in == NULL)
+    {
+      msg (M_WARN, "CRL: cannot read: %s", crl_file);
+      goto end;
+    }
+
+  crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
+  if (crl == NULL)
+    {
+      msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
+      goto end;
+    }
+
+  if (!X509_STORE_add_crl(store, crl))
+    {
+      msg (M_WARN, "CRL: cannot add %s to store", crl_file);
+      goto end;
+    }
+
+end:
+  X509_CRL_free(crl);
+  BIO_free(in);
+}
+
+
 #ifdef MANAGMENT_EXTERNAL_KEY
 
 /* encrypt */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index d0c22b8..745b125 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -669,15 +669,18 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
   if (opt->crl_file)
     {
       if (opt->ssl_flags & SSLF_CRL_VERIFY_DIR)
-      {
-	if (SUCCESS != verify_check_crl_dir(opt->crl_file, cert))
-	  goto cleanup;
-      }
+	{
+	  if (SUCCESS != verify_check_crl_dir(opt->crl_file, cert))
+	    goto cleanup;
+	}
       else
-      {
-	if (SUCCESS != x509_verify_crl(opt->crl_file, opt->crl_file_inline, cert, subject))
-	  goto cleanup;
-      }
+	{
+	  if (tls_verify_crl_missing (opt))
+	    {
+	      msg (D_TLS_ERRORS, "VERIFY ERROR: CRL not loaded");
+	      goto cleanup;
+	    }
+	}
     }
 
   msg (D_HANDSHAKE, "VERIFY OK: depth=%d, %s", cert_depth, subject);
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 91e6ec9..de304b9 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -252,19 +252,12 @@ result_t x509_verify_cert_eku (openvpn_x509_cert_t *x509, const char * const exp
  */
 result_t x509_write_pem(FILE *peercert_file, openvpn_x509_cert_t *peercert);
 
-/*
- * Check the certificate against a CRL file.
- *
- * @param crl_file	File name of the CRL file
- * @param cert		Certificate to verify
- * @param crl_inline	Contents of the crl file if it is inlined
- * @param subject	Subject of the given certificate
- *
- * @return 		\c SUCCESS if the CRL was not signed by the issuer of the
- * 			certificate or does not contain an entry for it.
- * 			\c FAILURE otherwise.
+/**
+ * Return true iff a CRL is configured, but is not loaded.  This can be caused
+ * by e.g. a CRL parsing error, a missing CRL file or CRL file permission
+ * errors.  (These conditions are checked upon startup, but the CRL might be
+ * updated and reloaded during runtime.)
  */
-result_t x509_verify_crl(const char *crl_file, const char *crl_inline,
-                         openvpn_x509_cert_t *cert, const char *subject);
+bool tls_verify_crl_missing(const struct tls_options *opt);
 
 #endif /* SSL_VERIFY_BACKEND_H_ */
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 92b0804..332f04b 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -497,59 +497,15 @@ x509_write_pem(FILE *peercert_file, mbedtls_x509_crt *peercert)
     return FAILURE;
 }
 
-/*
- * check peer cert against CRL
- */
-result_t
-x509_verify_crl(const char *crl_file, const char *crl_inline,
-                mbedtls_x509_crt *cert, const char *subject)
+bool
+tls_verify_crl_missing(const struct tls_options *opt)
 {
-  result_t retval = FAILURE;
-  mbedtls_x509_crl crl = {0};
-  struct gc_arena gc = gc_new();
-  char *serial;
-
-  if (!strcmp (crl_file, INLINE_FILE_TAG) && crl_inline)
-    {
-      if (!mbed_ok(mbedtls_x509_crl_parse(&crl,
-	  (const unsigned char *)crl_inline, strlen(crl_inline)+1)))
-        {
-           msg (M_WARN, "CRL: cannot parse inline CRL");
-           goto end;
-        }
-    }
-  else
-    {
-      if (!mbed_ok(mbedtls_x509_crl_parse_file(&crl, crl_file)))
-      {
-          msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
-          goto end;
-      }
-  }
-
-  if(cert->issuer_raw.len != crl.issuer_raw.len ||
-      memcmp(crl.issuer_raw.p, cert->issuer_raw.p, crl.issuer_raw.len) != 0)
-    {
-      msg (M_WARN, "CRL: CRL %s is from a different issuer than the issuer of "
-	  "certificate %s", crl_file, subject);
-      retval = SUCCESS;
-      goto end;
-    }
-
-  if (!mbed_ok(mbedtls_x509_crt_is_revoked(cert, &crl)))
+  if (opt->crl_file && !(opt->ssl_flags & SSLF_CRL_VERIFY_DIR)
+      && (opt->ssl_ctx.crl == NULL || opt->ssl_ctx.crl->version == 0))
     {
-      serial = backend_x509_get_serial_hex(cert, &gc);
-      msg (D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", subject, (serial ? serial : "NOT AVAILABLE"));
-      goto end;
+      return true;
     }
-
-  retval = SUCCESS;
-  msg (D_HANDSHAKE, "CRL CHECK OK: %s",subject);
-
-end:
-  gc_free(&gc);
-  mbedtls_x509_crl_free(&crl);
-  return retval;
+  return false;
 }
 
 #endif /* #if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index a4b9432..3d1c85e 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -70,15 +70,28 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
       /* get the X509 name */
       char *subject = x509_get_subject(ctx->current_cert, &gc);
 
-      if (subject)
+      if (!subject)
 	{
-	  /* Remote site specified a certificate, but it's not correct */
-	  msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, error=%s: %s",
-	      ctx->error_depth,
-	      X509_verify_cert_error_string (ctx->error),
-	      subject);
+	  subject = "(Failed to retrieve certificate subject)";
 	}
 
+      /* Log and ignore missing CRL errors */
+      if (ctx->error == X509_V_ERR_UNABLE_TO_GET_CRL)
+	{
+	  msg (D_TLS_DEBUG_LOW, "VERIFY WARNING: depth=%d, %s: %s",
+	       ctx->error_depth,
+	       X509_verify_cert_error_string (ctx->error),
+	       subject);
+	  ret = 1;
+	  goto cleanup;
+	}
+
+      /* Remote site specified a certificate, but it's not correct */
+      msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, error=%s: %s",
+	   ctx->error_depth,
+	   X509_verify_cert_error_string (ctx->error),
+	   subject);
+
       ERR_clear_error();
 
       session->verified = false;
@@ -625,63 +638,28 @@ x509_write_pem(FILE *peercert_file, X509 *peercert)
   return SUCCESS;
 }
 
-/*
- * check peer cert against CRL
- */
-result_t
-x509_verify_crl(const char *crl_file, const char* crl_inline,
-                X509 *peer_cert, const char *subject)
+bool
+tls_verify_crl_missing(const struct tls_options *opt)
 {
-  X509_CRL *crl=NULL;
-  X509_REVOKED *revoked;
-  BIO *in=NULL;
-  int n,i;
-  result_t retval = FAILURE;
-  struct gc_arena gc = gc_new();
-  char *serial;
-
-  if (!strcmp (crl_file, INLINE_FILE_TAG) && crl_inline)
-    in = BIO_new_mem_buf ((char *)crl_inline, -1);
-  else
-    in = BIO_new_file (crl_file, "r");
-
-  if (in == NULL) {
-    msg (M_WARN, "CRL: cannot read: %s", crl_file);
-    goto end;
-  }
-  crl=PEM_read_bio_X509_CRL(in,NULL,NULL,NULL);
-  if (crl == NULL) {
-    msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
-    goto end;
-  }
-
-  if (X509_NAME_cmp(X509_CRL_get_issuer(crl), X509_get_issuer_name(peer_cert)) != 0) {
-    msg (M_WARN, "CRL: CRL %s is from a different issuer than the issuer of "
-	"certificate %s", crl_file, subject);
-    retval = SUCCESS;
-    goto end;
-  }
-
-  n = sk_X509_REVOKED_num(X509_CRL_get_REVOKED(crl));
-  for (i = 0; i < n; i++) {
-    revoked = (X509_REVOKED *)sk_X509_REVOKED_value(X509_CRL_get_REVOKED(crl), i);
-    if (ASN1_INTEGER_cmp(revoked->serialNumber, X509_get_serialNumber(peer_cert)) == 0) {
-      serial = backend_x509_get_serial_hex(peer_cert, &gc);
-      msg (D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", subject, (serial ? serial : "NOT AVAILABLE"));
-      goto end;
+  if (!opt->crl_file || (opt->ssl_flags & SSLF_CRL_VERIFY_DIR))
+    {
+      return false;
     }
-  }
-
-  retval = SUCCESS;
-  msg (D_HANDSHAKE, "CRL CHECK OK: %s",subject);
 
-end:
-  gc_free(&gc);
-  BIO_free(in);
-  if (crl)
-    X509_CRL_free (crl);
+  X509_STORE *store = SSL_CTX_get_cert_store(opt->ssl_ctx.ctx);
+  if (!store)
+    crypto_msg (M_FATAL, "Cannot get certificate store");
 
-  return retval;
+  for (int i = 0; i < sk_X509_OBJECT_num(store->objs); i++)
+    {
+      X509_OBJECT* obj = sk_X509_OBJECT_value(store->objs, i);
+      ASSERT(obj);
+      if (obj->type == X509_LU_CRL)
+	{
+	  return false;
+	}
+    }
+  return true;
 }
 
 #endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL) */
-- 
2.7.4


