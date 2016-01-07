From: <steffan.karger@...1435...>
Date: Thu, 7 Jan 2016 14:01:30 +0100
Message-ID: <1452171690-26822-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1452113464-28062-1-git-send-email-steffan@...1856...>
References: <1452113464-28062-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] polarssl: improve logging
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

From: Steffan Karger <steffan.karger@...1435...>

Add the functions polar_log_err(), polar_log_func_line() and a macro
polar_ok(), to easily log human-readable PolarSSL errors from
polarssl-specific code.

This does not provide the full logging interface as msg(), because I
would have to add a lot more of macro-magic to achieve that on the
various supported compilers and platforms, and this suffices too (for
now at least).

Use the new polar_log_err() and polar_ok() functions to provide more
log/debug output for polarssl errors.

This is commit is a combined cherry-pick of commits 6ef5df14, d17d362d,
aa416be9, and 3a39bf7d from the master branch, adjusted to the
release/2.3 branch.

v2 - use static inline instead of macro for optimization, and include
     'enable polarssl debug logging'.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto_polarssl.c     | 60 ++++++++++++++++++++++++--------
 src/openvpn/crypto_polarssl.h     | 49 ++++++++++++++++++++++++++
 src/openvpn/ssl_polarssl.c        | 72 +++++++++++++++++++--------------------
 src/openvpn/ssl_verify_polarssl.c | 26 ++++----------
 4 files changed, 136 insertions(+), 71 deletions(-)

diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 24712ed..92fdb78 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -46,6 +46,7 @@
 #include "misc.h"
 
 #include <polarssl/des.h>
+#include <polarssl/error.h>
 #include <polarssl/md5.h>
 #include <polarssl/cipher.h>
 #include <polarssl/havege.h>
@@ -86,6 +87,32 @@ crypto_clear_error (void)
 {
 }
 
+bool polar_log_err(unsigned int flags, int errval, const char *prefix)
+{
+  if (0 != errval)
+    {
+      char errstr[256];
+      polarssl_strerror(errval, errstr, sizeof(errstr));
+
+      if (NULL == prefix) prefix = "PolarSSL error";
+      msg (flags, "%s: %s", prefix, errstr);
+    }
+
+  return 0 == errval;
+}
+
+bool polar_log_func_line(unsigned int flags, int errval, const char *func,
+    int line)
+{
+  char prefix[256];
+
+  if (!openvpn_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
+    return polar_log_err(flags, errval, func);
+
+  return polar_log_err(flags, errval, prefix);
+}
+
+
 #ifdef DMALLOC
 void
 crypto_init_dmalloc (void)
@@ -234,7 +261,8 @@ ctr_drbg_context * rand_ctx_get()
       /* Initialise PolarSSL RNG, and built-in entropy sources */
       entropy_init(&ec);
 
-      if (0 != ctr_drbg_init(&cd_ctx, entropy_func, &ec, BPTR(&pers_string), BLEN(&pers_string)))
+      if (!polar_ok(ctr_drbg_init(&cd_ctx, entropy_func, &ec,
+		    BPTR(&pers_string), BLEN(&pers_string))))
         msg (M_FATAL, "Failed to initialize random generator");
 
       gc_free(&gc);
@@ -445,10 +473,10 @@ cipher_ctx_init (cipher_context_t *ctx, uint8_t *key, int key_len,
 
   CLEAR (*ctx);
 
-  if (0 != cipher_init_ctx(ctx, kt))
+  if (!polar_ok(cipher_init_ctx(ctx, kt)))
     msg (M_FATAL, "PolarSSL cipher context init #1");
 
-  if (0 != cipher_setkey(ctx, key, key_len*8, enc))
+  if (!polar_ok(cipher_setkey(ctx, key, key_len*8, enc)))
     msg (M_FATAL, "PolarSSL cipher set key");
 
   /* make sure we used a big enough key */
@@ -487,36 +515,38 @@ cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
 
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
@@ -526,8 +556,8 @@ cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
 {
     des_context ctx;
 
-    des_setkey_enc(&ctx, key);
-    des_crypt_ecb(&ctx, src, dst);
+    ASSERT (polar_ok(des_setkey_enc(&ctx, key)));
+    ASSERT (polar_ok(des_crypt_ecb(&ctx, src, dst)));
 }
 
 
diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index b6da436..12b5146 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -91,4 +91,53 @@ ctr_drbg_context * rand_ctx_get();
 void rand_ctx_enable_prediction_resistance();
 #endif
 
+/**
+ * Log the supplied PolarSSL error, prefixed by supplied prefix.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ * @param errval	PolarSSL error code to convert to error message.
+ * @param prefix	Prefix to PolarSSL error message.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+bool polar_log_err(unsigned int flags, int errval, const char *prefix);
+
+/**
+ * Log the supplied PolarSSL error, prefixed by function name and line number.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ * @param errval	PolarSSL error code to convert to error message.
+ * @param func		Function name where error was reported.
+ * @param line		Line number where error was reported.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+bool polar_log_func_line(unsigned int flags, int errval, const char *func,
+    int line);
+
+/** Wraps polar_log_func_line() to prevent function calls for non-errors */
+static inline bool polar_log_func_line_lite(unsigned int flags, int errval,
+    const char *func, int line) {
+  if (errval) {
+    return polar_log_func_line (flags, errval, func, line);
+  }
+  return true;
+}
+
+/**
+ * Check errval and log on error.
+ *
+ * Convenience wrapper to put around polarssl library calls, e.g.
+ *   if (!polar_ok(polarssl_func())) return 0;
+ * or
+ *   ASSERT (polar_ok(polarssl_func()));
+ *
+ * @param errval	PolarSSL error code to convert to error message.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+#define polar_ok(errval) \
+  polar_log_func_line_lite (D_CRYPT_ERRORS, errval, __func__, __LINE__)
+
+
 #endif /* CRYPTO_POLARSSL_H_ */
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index cd8ee1a..1f58369 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -49,6 +49,7 @@
 #include <polarssl/havege.h>
 
 #include "ssl_verify_polarssl.h"
+#include <polarssl/debug.h>
 #include <polarssl/error.h>
 #include <polarssl/oid.h>
 #include <polarssl/pem.h>
@@ -231,13 +232,13 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
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
 
@@ -277,14 +278,16 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
 
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
-      if (0 != x509_crt_parse_file(ctx->crt_chain, cert_file))
-	msg (M_FATAL, "Cannot load certificate file %s", cert_file);
+      if (!polar_ok(x509_crt_parse_file(ctx->crt_chain, cert_file)))
+	{
+	  msg (M_FATAL, "Cannot load certificate file %s", cert_file);
+	}
     }
 }
 
@@ -326,7 +329,7 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
 	  status = pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
 	}
     }
-  if (0 != status)
+  if (!polar_ok(status))
     {
 #ifdef ENABLE_MANAGEMENT
       if (management && (POLARSSL_ERR_PK_PASSWORD_MISMATCH == status))
@@ -403,7 +406,7 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
       if( md_info == NULL )
         return( POLARSSL_ERR_RSA_BAD_INPUT_DATA );
 
-      if( oid_get_oid_by_md( md_alg, &oid, &oid_size ) != 0 )
+      if (!polar_ok(oid_get_oid_by_md( md_alg, &oid, &oid_size )))
         return( POLARSSL_ERR_RSA_BAD_INPUT_DATA );
 
       hashlen = md_get_size( md_info );
@@ -501,8 +504,8 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
   ctx->external_key->signature_length = pk_get_len(&ctx->crt_chain->pk);
 
   ALLOC_OBJ_CLEAR (ctx->priv_key, pk_context);
-  if (0 != pk_init_ctx_rsa_alt(ctx->priv_key, ctx->external_key,
-	    NULL, external_pkcs1_sign, external_key_len))
+  if (!polar_ok (pk_init_ctx_rsa_alt(ctx->priv_key, ctx->external_key,
+	    NULL, external_pkcs1_sign, external_key_len)))
     return 0;
 
   return 1;
@@ -510,23 +513,21 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
 #endif
 
 void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
-    const char *ca_inline,
-    const char *ca_path, bool tls_server
-    )
+    const char *ca_inline, const char *ca_path, bool tls_server)
 {
   if (ca_path)
       msg(M_FATAL, "ERROR: PolarSSL cannot handle the capath directive");
 
   if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_inline)
     {
-      if (0 != x509_crt_parse(ctx->ca_chain, (unsigned char *) ca_inline,
-	  strlen(ca_inline)))
+      if (!polar_ok(x509_crt_parse(ctx->ca_chain,
+	  (const unsigned char *) ca_inline, strlen(ca_inline))))
 	msg (M_FATAL, "Cannot load inline CA certificates");
     }
   else
     {
       /* Load CA file for verifying peer supplied certificate */
-      if (0 != x509_crt_parse_file(ctx->ca_chain, ca_file))
+      if (!polar_ok(x509_crt_parse_file(ctx->ca_chain, ca_file)))
 	msg (M_FATAL, "Cannot load CA certificate file %s", ca_file);
     }
 }
@@ -545,14 +546,14 @@ tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
 
   if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_inline)
     {
-      if (0 != x509_crt_parse(ctx->crt_chain,
+      if (!polar_ok(x509_crt_parse(ctx->crt_chain,
           (const unsigned char *) extra_certs_inline,
-	  strlen(extra_certs_inline)))
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
@@ -658,10 +659,8 @@ static int endless_buf_write( void *ctx, const unsigned char *in, size_t len )
 
 static void my_debug( void *ctx, int level, const char *str )
 {
-  if (level == 1)
-    {
-      dmsg (D_HANDSHAKE_VERBOSE, "PolarSSL alert: %s", str);
-    }
+  int my_loglevel = (level < 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;
+  msg (my_loglevel, "PolarSSL msg: %s", str);
 }
 
 /*
@@ -740,9 +739,10 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
   CLEAR(*ks_ssl);
 
   ALLOC_OBJ_CLEAR(ks_ssl->ctx, ssl_context);
-  if (0 == ssl_init(ks_ssl->ctx))
+  if (polar_ok(ssl_init(ks_ssl->ctx)))
     {
       /* Initialise SSL context */
+      debug_set_threshold(3);
       ssl_set_dbg (ks_ssl->ctx, my_debug, NULL);
       ssl_set_endpoint (ks_ssl->ctx, ssl_ctx->endpoint);
 
@@ -761,9 +761,10 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
 
       /* Initialise authentication information */
       if (is_server)
-	ssl_set_dh_param_ctx (ks_ssl->ctx, ssl_ctx->dhm_ctx);
+	polar_ok (ssl_set_dh_param_ctx (ks_ssl->ctx, ssl_ctx->dhm_ctx));
 
-      ssl_set_own_cert (ks_ssl->ctx, ssl_ctx->crt_chain, ssl_ctx->priv_key);
+      polar_ok (ssl_set_own_cert (ks_ssl->ctx, ssl_ctx->crt_chain,
+	  ssl_ctx->priv_key));
 
       /* Initialise SSL verification */
 #if P2MP_SERVER
@@ -912,7 +913,8 @@ key_state_write_plaintext_const (struct key_state_ssl *ks, const uint8_t *data,
       perf_pop ();
       if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
 	return 0;
-      msg (D_TLS_ERRORS, "TLS ERROR: write tls_write_plaintext_const error");
+      polar_log_err (D_TLS_ERRORS, retval,
+	  "TLS ERROR: write tls_write_plaintext_const error");
       return -1;
     }
 
@@ -938,7 +940,6 @@ key_state_read_ciphertext (struct key_state_ssl *ks, struct buffer *buf,
 {
   int retval = 0;
   int len = 0;
-  char error_message[1024];
 
   perf_push (PERF_BIO_READ_CIPHERTEXT);
 
@@ -964,8 +965,7 @@ key_state_read_ciphertext (struct key_state_ssl *ks, struct buffer *buf,
       perf_pop ();
       if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
 	return 0;
-      error_strerror(retval, error_message, sizeof(error_message));
-      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_ciphertext error: %d %s", retval, error_message);
+      polar_log_err (D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_ciphertext error");
       buf->len = 0;
       return -1;
     }
@@ -1008,14 +1008,14 @@ key_state_write_ciphertext (struct key_state_ssl *ks, struct buffer *buf)
 
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
@@ -1037,7 +1037,6 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
 {
   int retval = 0;
   int len = 0;
-  char error_message[1024];
 
   perf_push (PERF_BIO_READ_PLAINTEXT);
 
@@ -1062,8 +1061,7 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
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
index ac252a3..7ed87d6 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -131,17 +131,12 @@ backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
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
-      error_strerror(retval, errbuf, sizeof(errbuf));
-
-      msg(M_WARN, "Failed to retrieve serial from certificate: %s.", errbuf);
+      msg(M_WARN, "Failed to retrieve serial from certificate.");
       return NULL;
     }
 
@@ -150,13 +145,9 @@ backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
   buf = gc_malloc(buflen, true, gc);
 
   /* Write MPI serial as decimal string into buffer */
-  retval = mpi_write_string(&serial_mpi, 10, buf, &buflen);
-  if (retval < 0)
+  if (!polar_ok(mpi_write_string(&serial_mpi, 10, buf, &buflen)))
     {
-      char errbuf[128];
-      error_strerror(retval, errbuf, sizeof(errbuf));
-
-      msg(M_WARN, "Failed to write serial to string: %s.", errbuf);
+      msg(M_WARN, "Failed to write serial to string.");
       return NULL;
     }
 
@@ -372,12 +363,9 @@ x509_verify_crl(const char *crl_file, x509_crt *cert, const char *subject)
   struct gc_arena gc = gc_new();
   char *serial;
 
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
 
@@ -390,7 +378,7 @@ x509_verify_crl(const char *crl_file, x509_crt *cert, const char *subject)
       goto end;
     }
 
-  if (0 != x509_crt_revoked(cert, &crl))
+  if (!polar_ok(x509_crt_revoked(cert, &crl)))
     {
       serial = backend_x509_get_serial_hex(cert, &gc);
       msg (D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", subject, (serial ? serial : "NOT AVAILABLE"));
-- 
2.5.0


