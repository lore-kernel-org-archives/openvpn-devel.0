From: Steffan Karger <steffan@...1856...>
Date: Sun,  8 Mar 2015 11:20:05 +0100
Message-Id: <1425810005-11893-2-git-send-email-steffan@...1856...>
In-Reply-To: <1425810005-11893-1-git-send-email-steffan@...1856...>
References: <1425810005-11893-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] polarssl: Improve PolarSSL logging
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

Use the new polar_log_err() and polar_ok() functions introduced in the
previous commit to provide more log/debug output for polarssl errors.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_polarssl.c     | 35 ++++++++-------
 src/openvpn/ssl_polarssl.c        | 92 +++++++++++++++++----------------------
 src/openvpn/ssl_verify_polarssl.c | 26 +++--------
 3 files changed, 66 insertions(+), 87 deletions(-)

diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 263b4dc..c038f8e 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -261,7 +261,8 @@ ctr_drbg_context * rand_ctx_get()
       /* Initialise PolarSSL RNG, and built-in entropy sources */
       entropy_init(&ec);
 
-      if (0 != ctr_drbg_init(&cd_ctx, entropy_func, &ec, BPTR(&pers_string), BLEN(&pers_string)))
+      if (!polar_ok(ctr_drbg_init(&cd_ctx, entropy_func, &ec,
+		    BPTR(&pers_string), BLEN(&pers_string))))
         msg (M_FATAL, "Failed to initialize random generator");
 
       gc_free(&gc);
@@ -472,10 +473,10 @@ cipher_ctx_init (cipher_context_t *ctx, uint8_t *key, int key_len,
 
   CLEAR (*ctx);
 
-  if (0 != cipher_init_ctx(ctx, kt))
+  if (!polar_ok(cipher_init_ctx(ctx, kt)))
     msg (M_FATAL, "PolarSSL cipher context init #1");
 
-  if (0 != cipher_setkey(ctx, key, key_len*8, enc))
+  if (!polar_ok(cipher_setkey(ctx, key, key_len*8, enc)))
     msg (M_FATAL, "PolarSSL cipher set key");
 
   /* make sure we used a big enough key */
@@ -484,7 +485,7 @@ cipher_ctx_init (cipher_context_t *ctx, uint8_t *key, int key_len,
 
 void cipher_ctx_cleanup (cipher_context_t *ctx)
 {
-  cipher_free_ctx(ctx);
+  polar_ok(cipher_free_ctx(ctx));
 }
 
 int cipher_ctx_iv_length (const cipher_context_t *ctx)
@@ -514,36 +515,38 @@ cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
 
 int cipher_ctx_reset (cipher_context_t *ctx, uint8_t *iv_buf)
 {
-  int retval = cipher_reset(ctx);
+  if (!polar_ok(cipher_reset(ctx)))
+    return 0;
 
-  if (0 == retval)
-    retval = cipher_set_iv(ctx, iv_buf, ctx->cipher_info->iv_size);
+  if (!polar_ok(cipher_set_iv(ctx, iv_buf, ctx->cipher_info->iv_size)))
+    return 0;
 
-  return 0 == retval;
+  return 1;
 }
 
 int cipher_ctx_update (cipher_context_t *ctx, uint8_t *dst, int *dst_len,
     uint8_t *src, int src_len)
 {
-  int retval = 0;
   size_t s_dst_len = *dst_len;
 
-  retval = cipher_update(ctx, src, (size_t)src_len, dst, &s_dst_len);
+  if (!polar_ok(cipher_update(ctx, src, (size_t)src_len, dst, &s_dst_len)))
+    return 0;
 
   *dst_len = s_dst_len;
 
-  return 0 == retval;
+  return 1;
 }
 
 int cipher_ctx_final (cipher_context_t *ctx, uint8_t *dst, int *dst_len)
 {
-  int retval = 0;
   size_t s_dst_len = *dst_len;
 
-  retval = cipher_finish(ctx, dst, &s_dst_len);
+  if (!polar_ok(cipher_finish(ctx, dst, &s_dst_len)))
+    return 0;
+
   *dst_len = s_dst_len;
 
-  return 0 == retval;
+  return 1;
 }
 
 void
@@ -553,8 +556,8 @@ cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
 {
     des_context ctx;
 
-    des_setkey_enc(&ctx, key);
-    des_crypt_ecb(&ctx, src, dst);
+    ASSERT (polar_ok(des_setkey_enc(&ctx, key)));
+    ASSERT (polar_ok(des_crypt_ecb(&ctx, src, dst)));
 }
 
 
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 8cb328e..d024e13 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -218,13 +218,13 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
 {
   if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_inline)
     {
-      if (0 != dhm_parse_dhm(ctx->dhm_ctx, (const unsigned char *) dh_inline,
-	  strlen(dh_inline)))
+      if (!polar_ok(dhm_parse_dhm(ctx->dhm_ctx,
+	  (const unsigned char *) dh_inline, strlen(dh_inline))))
 	msg (M_FATAL, "Cannot read inline DH parameters");
   }
 else
   {
-    if (0 != dhm_parse_dhmfile(ctx->dhm_ctx, dh_file))
+    if (!polar_ok(dhm_parse_dhmfile(ctx->dhm_ctx, dh_file)))
       msg (M_FATAL, "Cannot read DH parameters from file %s", dh_file);
   }
 
@@ -268,18 +268,15 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
 
   if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_inline)
     {
-      if (0 != x509_crt_parse(ctx->crt_chain,
-	  (const unsigned char *) cert_inline, strlen(cert_inline)))
+      if (!polar_ok(x509_crt_parse(ctx->crt_chain,
+	  (const unsigned char *) cert_inline, strlen(cert_inline))))
         msg (M_FATAL, "Cannot load inline certificate file");
     }
   else
     {
-      int retval = x509_crt_parse_file(ctx->crt_chain, cert_file);
-      if (0 != retval)
+      if (!polar_ok(x509_crt_parse_file(ctx->crt_chain, cert_file)))
 	{
-	  char errstr[128];
-	  polarssl_strerror(retval, errstr, sizeof(errstr));
-	  msg (M_FATAL, "Cannot load certificate file %s (%s)", cert_file, errstr);
+	  msg (M_FATAL, "Cannot load certificate file %s", cert_file);
 	}
     }
 }
@@ -317,7 +314,7 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
 	  status = pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
 	}
     }
-  if (0 != status)
+  if (!polar_ok(status))
     {
 #ifdef ENABLE_MANAGEMENT
       if (management && (POLARSSL_ERR_PK_PASSWORD_MISMATCH == status))
@@ -412,7 +409,7 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
       if( md_info == NULL )
         return( POLARSSL_ERR_RSA_BAD_INPUT_DATA );
 
-      if( oid_get_oid_by_md( md_alg, &oid, &oid_size ) != 0 )
+      if (!polar_ok(oid_get_oid_by_md( md_alg, &oid, &oid_size )))
         return( POLARSSL_ERR_RSA_BAD_INPUT_DATA );
 
       hashlen = md_get_size( md_info );
@@ -497,49 +494,43 @@ static inline size_t external_key_len(void *vctx)
 #endif
 
 void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
-    const char *ca_file_inline,
-    const char *ca_path, bool tls_server
+    const char *ca_inline, const char *ca_path, bool tls_server
     )
 {
   if (ca_path)
       msg(M_FATAL, "ERROR: PolarSSL cannot handle the capath directive");
 
-  if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_file_inline)
+  if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_inline)
     {
-      if (0 != x509_crt_parse(ctx->ca_chain, (unsigned char *) ca_file_inline,
-	  strlen(ca_file_inline)))
+      if (!polar_ok(x509_crt_parse(ctx->ca_chain,
+	  (const unsigned char *) ca_inline, strlen(ca_inline))))
 	msg (M_FATAL, "Cannot load inline CA certificates");
     }
   else
     {
       /* Load CA file for verifying peer supplied certificate */
-      int retval = x509_crt_parse_file(ctx->ca_chain, ca_file);
-      if (0 != retval)
-	{
-	  char errstr[128];
-	  polarssl_strerror(retval, errstr, sizeof(errstr));
-	  msg (M_FATAL, "Cannot load CA certificate file %s (%s)", ca_file, errstr);
-	}
+      if (!polar_ok(x509_crt_parse_file(ctx->ca_chain, ca_file)))
+	msg (M_FATAL, "Cannot load CA certificate file %s", ca_file);
     }
 }
 
 void
 tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file,
-    const char *extra_certs_file_inline
+    const char *extra_certs_inline
     )
 {
   ASSERT(NULL != ctx);
 
-  if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_file_inline)
+  if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_inline)
     {
-      if (0 != x509_crt_parse(ctx->crt_chain,
-          (unsigned char *) extra_certs_file_inline,
-	  strlen(extra_certs_file_inline)))
+      if (!polar_ok(x509_crt_parse(ctx->crt_chain,
+          (const unsigned char *) extra_certs_inline,
+	  strlen(extra_certs_inline))))
         msg (M_FATAL, "Cannot load inline extra-certs file");
     }
   else
     {
-      if (0 != x509_crt_parse_file(ctx->crt_chain, extra_certs_file))
+      if (!polar_ok(x509_crt_parse_file(ctx->crt_chain, extra_certs_file)))
 	msg (M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
     }
 }
@@ -645,10 +636,8 @@ static int endless_buf_write( void *ctx, const unsigned char *in, size_t len )
 
 static void my_debug( void *ctx, int level, const char *str )
 {
-  if (level == 1)
-    {
-      dmsg (D_HANDSHAKE_VERBOSE, "PolarSSL alert: %s", str);
-    }
+  int my_loglevel = (level < 2) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;
+  msg (my_loglevel, "PolarSSL alert: %s", str);
 }
 
 /*
@@ -727,7 +716,7 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
   CLEAR(*ks_ssl);
 
   ALLOC_OBJ_CLEAR(ks_ssl->ctx, ssl_context);
-  if (0 == ssl_init(ks_ssl->ctx))
+  if (polar_ok(ssl_init(ks_ssl->ctx)))
     {
       /* Initialise SSL context */
       ssl_set_dbg (ks_ssl->ctx, my_debug, NULL);
@@ -740,22 +729,23 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
 
       /* Initialise authentication information */
       if (is_server)
-	ssl_set_dh_param_ctx (ks_ssl->ctx, ssl_ctx->dhm_ctx );
+	polar_ok(ssl_set_dh_param_ctx(ks_ssl->ctx, ssl_ctx->dhm_ctx));
 #if defined(ENABLE_PKCS11)
       if (ssl_ctx->priv_key_pkcs11 != NULL)
-	ssl_set_own_cert_alt( ks_ssl->ctx, ssl_ctx->crt_chain,
+	polar_ok(ssl_set_own_cert_alt(ks_ssl->ctx, ssl_ctx->crt_chain,
 	    ssl_ctx->priv_key_pkcs11, ssl_pkcs11_decrypt, ssl_pkcs11_sign,
-	    ssl_pkcs11_key_len );
+	    ssl_pkcs11_key_len));
       else
 #endif
 #if defined(MANAGMENT_EXTERNAL_KEY)
       if (ssl_ctx->external_key != NULL)
-        ssl_set_own_cert_alt( ks_ssl->ctx, ssl_ctx->crt_chain,
+	polar_ok(ssl_set_own_cert_alt(ks_ssl->ctx, ssl_ctx->crt_chain,
 	   ssl_ctx->external_key, NULL, external_pkcs1_sign,
-	   external_key_len );
+	   external_key_len));
       else
 #endif
-	ssl_set_own_cert( ks_ssl->ctx, ssl_ctx->crt_chain, ssl_ctx->priv_key );
+	polar_ok(ssl_set_own_cert(ks_ssl->ctx, ssl_ctx->crt_chain,
+	    ssl_ctx->priv_key));
 
       /* Initialise SSL verification */
 #if P2MP_SERVER
@@ -857,7 +847,8 @@ key_state_write_plaintext (struct key_state_ssl *ks, struct buffer *buf)
       perf_pop ();
       if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
 	return 0;
-      msg (D_TLS_ERRORS, "TLS ERROR: write tls_write_plaintext error");
+      polar_log_err (D_TLS_ERRORS, retval,
+	  "TLS ERROR: write tls_write_plaintext error");
       return -1;
     }
 
@@ -904,7 +895,8 @@ key_state_write_plaintext_const (struct key_state_ssl *ks, const uint8_t *data,
       perf_pop ();
       if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
 	return 0;
-      msg (D_TLS_ERRORS, "TLS ERROR: write tls_write_plaintext_const error");
+      polar_log_err (D_TLS_ERRORS, retval,
+	  "TLS ERROR: write tls_write_plaintext_const error");
       return -1;
     }
 
@@ -930,7 +922,6 @@ key_state_read_ciphertext (struct key_state_ssl *ks, struct buffer *buf,
 {
   int retval = 0;
   int len = 0;
-  char error_message[1024];
 
   perf_push (PERF_BIO_READ_CIPHERTEXT);
 
@@ -956,8 +947,7 @@ key_state_read_ciphertext (struct key_state_ssl *ks, struct buffer *buf,
       perf_pop ();
       if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
 	return 0;
-      error_strerror(retval, error_message, sizeof(error_message));
-      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_ciphertext error: %d %s", retval, error_message);
+      polar_log_err (D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_ciphertext error");
       buf->len = 0;
       return -1;
     }
@@ -1000,14 +990,14 @@ key_state_write_ciphertext (struct key_state_ssl *ks, struct buffer *buf)
 
       if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
 	return 0;
-      msg (D_TLS_ERRORS, "TLS ERROR: write tls_write_ciphertext error");
+      polar_log_err (D_TLS_ERRORS, retval,
+	  "TLS ERROR: write tls_write_ciphertext error");
       return -1;
     }
 
   if (retval != buf->len)
     {
-      msg (D_TLS_ERRORS,
-	  "TLS ERROR: write tls_write_ciphertext incomplete %d/%d",
+      msg (D_TLS_ERRORS, "TLS ERROR: write tls_write_ciphertext incomplete %d/%d",
 	  retval, buf->len);
       perf_pop ();
       return -1;
@@ -1029,7 +1019,6 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
 {
   int retval = 0;
   int len = 0;
-  char error_message[1024];
 
   perf_push (PERF_BIO_READ_PLAINTEXT);
 
@@ -1054,8 +1043,7 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
     {
       if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
 	return 0;
-      error_strerror(retval, error_message, sizeof(error_message));
-      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_plaintext error: %d %s", retval, error_message);
+      polar_log_err (D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_plaintext error");
       buf->len = 0;
       perf_pop ();
       return -1;
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 2edf21d..976df50 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -134,17 +134,12 @@ backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
   char *buf = NULL;
   size_t buflen = 0;
   mpi serial_mpi = { 0 };
-  int retval = 0;
 
   /* Transform asn1 integer serial into PolarSSL MPI */
   mpi_init(&serial_mpi);
-  retval = mpi_read_binary(&serial_mpi, cert->serial.p, cert->serial.len);
-  if (retval < 0)
+  if (!polar_ok(mpi_read_binary(&serial_mpi, cert->serial.p, cert->serial.len)))
     {
-      char errbuf[128];
-      polarssl_strerror(retval, errbuf, sizeof(errbuf));
-
-      msg(M_WARN, "Failed to retrieve serial from certificate: %s.", errbuf);
+      msg(M_WARN, "Failed to retrieve serial from certificate.");
       return NULL;
     }
 
@@ -153,13 +148,9 @@ backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
   buf = gc_malloc(buflen, true, gc);
 
   /* Write MPI serial as decimal string into buffer */
-  retval = mpi_write_string(&serial_mpi, 10, buf, &buflen);
-  if (retval < 0)
+  if (!polar_ok(mpi_write_string(&serial_mpi, 10, buf, &buflen)))
     {
-      char errbuf[128];
-      polarssl_strerror(retval, errbuf, sizeof(errbuf));
-
-      msg(M_WARN, "Failed to write serial to string: %s.", errbuf);
+      msg(M_WARN, "Failed to write serial to string.");
       return NULL;
     }
 
@@ -374,12 +365,9 @@ x509_verify_crl(const char *crl_file, x509_crt *cert, const char *subject)
   result_t retval = FAILURE;
   x509_crl crl = {0};
 
-  int polar_retval = x509_crl_parse_file(&crl, crl_file);
-  if (polar_retval != 0)
+  if (!polar_ok(x509_crl_parse_file(&crl, crl_file)))
     {
-      char errstr[128];
-      polarssl_strerror(polar_retval, errstr, sizeof(errstr));
-      msg (M_WARN, "CRL: cannot read CRL from file %s (%s)", crl_file, errstr);
+      msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
       goto end;
     }
 
@@ -392,7 +380,7 @@ x509_verify_crl(const char *crl_file, x509_crt *cert, const char *subject)
       goto end;
     }
 
-  if (0 != x509_crt_revoked(cert, &crl))
+  if (!polar_ok(x509_crt_revoked(cert, &crl)))
     {
       msg (D_HANDSHAKE, "CRL CHECK FAILED: %s is REVOKED", subject);
       goto end;
-- 
2.1.0


