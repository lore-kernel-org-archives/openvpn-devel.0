From: <steffan.karger@...1435...>
Date: Mon, 21 Jan 2013 14:13:26 +0100
Message-ID: <1358774007-4881-3-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1358774007-4881-1-git-send-email-steffan.karger@...1435...>
References: <1358774007-4881-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] PolarSSL-1.2 support
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

Add support for PolarSSL-1.2, which has changed the API in several places.
This is a minimal port: PolarSSL-1.2 works, but the new features have not
been enabled. Everything before 1.2 is no longer supported.

PolarSSL-1.2.[0-2] are blacklisted for bugs when verifying certificate
chains

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 configure.ac                      |    4 ++--
 src/openvpn/crypto_polarssl.h     |    3 +--
 src/openvpn/options.c             |    4 ++++
 src/openvpn/ssl_polarssl.c        |   33 +++++----------------------------
 src/openvpn/ssl_polarssl.h        |    1 -
 src/openvpn/ssl_verify_polarssl.c |   21 +++++++++------------
 src/openvpn/ssl_verify_polarssl.h |   22 ++++++++++------------
 7 files changed, 31 insertions(+), 57 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2f780b7..dae57bc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -805,8 +805,8 @@ if test "${with_crypto_library}" = "polarssl" ; then
 #include <polarssl/version.h>
 			]],
 			[[
-#if POLARSSL_VERSION_NUMBER < 0x01010000
-#error invalid version
+#if POLARSSL_VERSION_NUMBER < 0x01020300
+#error PolarSSL before 1.2.3 is incompatible with this version of OpenVPN
 #endif
 			]]
 		)],
diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index bfabb91..b6da436 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -30,7 +30,6 @@
 #ifndef CRYPTO_POLARSSL_H_
 #define CRYPTO_POLARSSL_H_
 
-#include <polarssl/version.h>
 #include <polarssl/cipher.h>
 #include <polarssl/md.h>
 #include <polarssl/ctr_drbg.h>
@@ -60,7 +59,7 @@ typedef md_context_t hmac_ctx_t;
 #define OPENVPN_MODE_OFB 	POLARSSL_MODE_OFB
 
 /** Cipher is in CFB mode */
-#define OPENVPN_MODE_CFB 	POLARSSL_MODE_CFB128
+#define OPENVPN_MODE_CFB 	POLARSSL_MODE_CFB
 
 /** Cipher should encrypt */
 #define OPENVPN_OP_ENCRYPT 	POLARSSL_ENCRYPT
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8ca41a3..429f864 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -827,7 +827,11 @@ init_options (struct options *o, const bool init_gc)
   o->server_poll_timeout = 0;
 #endif
 #ifdef ENABLE_CRYPTO
+#ifdef ENABLE_CRYPTO_POLARSSL
+  o->ciphername = "BLOWFISH-CBC";
+#else
   o->ciphername = "BF-CBC";
+#endif
   o->ciphername_defined = true;
   o->authname = "SHA1";
   o->authname_defined = true;
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 210bbab..b83ee6a 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -65,23 +65,6 @@ tls_clear_error()
 {
 }
 
-static int default_ciphersuites[] =
-{
-    SSL_EDH_RSA_AES_256_SHA,
-    SSL_EDH_RSA_CAMELLIA_256_SHA,
-    SSL_EDH_RSA_AES_128_SHA,
-    SSL_EDH_RSA_CAMELLIA_128_SHA,
-    SSL_EDH_RSA_DES_168_SHA,
-    SSL_RSA_AES_256_SHA,
-    SSL_RSA_CAMELLIA_256_SHA,
-    SSL_RSA_AES_128_SHA,
-    SSL_RSA_CAMELLIA_128_SHA,
-    SSL_RSA_DES_168_SHA,
-    SSL_RSA_RC4_128_SHA,
-    SSL_RSA_RC4_128_MD5,
-    0
-};
-
 void
 tls_ctx_server_new(struct tls_root_ctx *ctx)
 {
@@ -514,20 +497,17 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
 
       ssl_set_rng (ks_ssl->ctx, ctr_drbg_random, rand_ctx_get());
 
-      ALLOC_OBJ_CLEAR (ks_ssl->ssn, ssl_session);
-      ssl_set_session (ks_ssl->ctx, 0, 0, ks_ssl->ssn );
       if (ssl_ctx->allowed_ciphers)
 	ssl_set_ciphersuites (ks_ssl->ctx, ssl_ctx->allowed_ciphers);
-      else
-	ssl_set_ciphersuites (ks_ssl->ctx, default_ciphersuites);
 
       /* Initialise authentication information */
       if (is_server)
 	ssl_set_dh_param_ctx (ks_ssl->ctx, ssl_ctx->dhm_ctx );
 #if defined(ENABLE_PKCS11)
       if (ssl_ctx->priv_key_pkcs11 != NULL)
-	ssl_set_own_cert_pkcs11( ks_ssl->ctx, ssl_ctx->crt_chain,
-	    ssl_ctx->priv_key_pkcs11 );
+	ssl_set_own_cert_alt( ks_ssl->ctx, ssl_ctx->crt_chain,
+	    ssl_ctx->priv_key_pkcs11, ssl_pkcs11_decrypt, ssl_pkcs11_sign,
+	    ssl_pkcs11_key_len );
       else
 #endif
 	ssl_set_own_cert( ks_ssl->ctx, ssl_ctx->crt_chain, ssl_ctx->priv_key );
@@ -543,7 +523,6 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
       ALLOC_OBJ_CLEAR (ks_ssl->ct_out, endless_buffer);
       ssl_set_bio (ks_ssl->ctx, endless_buf_read, ks_ssl->ct_in,
 	  endless_buf_write, ks_ssl->ct_out);
-
     }
 }
 
@@ -556,8 +535,6 @@ key_state_ssl_free(struct key_state_ssl *ks_ssl)
 	  ssl_free(ks_ssl->ctx);
 	  free(ks_ssl->ctx);
 	}
-      if (ks_ssl->ssn)
-	free(ks_ssl->ssn);
       if (ks_ssl->ct_in) {
 	buf_free_entries(ks_ssl->ct_in);
 	free(ks_ssl->ct_in);
@@ -834,7 +811,7 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
 void
 print_details (struct key_state_ssl * ks_ssl, const char *prefix)
 {
-  x509_cert *cert;
+  const x509_cert *cert;
   char s1[256];
   char s2[256];
 
@@ -844,7 +821,7 @@ print_details (struct key_state_ssl * ks_ssl, const char *prefix)
 		    ssl_get_version (ks_ssl->ctx),
 		    ssl_get_ciphersuite(ks_ssl->ctx));
 
-  cert = ks_ssl->ctx->peer_cert;
+  cert = ssl_get_peer_cert(ks_ssl->ctx);
   if (cert != NULL)
     {
       openvpn_snprintf (s2, sizeof (s2), ", " counter_format " bit RSA", (counter_type) cert->rsa.len * 8);
diff --git a/src/openvpn/ssl_polarssl.h b/src/openvpn/ssl_polarssl.h
index 456573f..da93699 100644
--- a/src/openvpn/ssl_polarssl.h
+++ b/src/openvpn/ssl_polarssl.h
@@ -73,7 +73,6 @@ struct tls_root_ctx {
 
 struct key_state_ssl {
         ssl_context *ctx;
-        ssl_session *ssn;
         endless_buffer *ct_in;
         endless_buffer *ct_out;
 };
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index a32db8d..653248f 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -44,11 +44,10 @@
 
 int
 verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
-    int preverify_ok)
+    int *flags)
 {
   struct tls_session *session = (struct tls_session *) session_obj;
   struct gc_arena gc = gc_new();
-  int ret = 1;
 
   ASSERT (cert);
   ASSERT (session);
@@ -59,7 +58,7 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
   cert_hash_remember (session, cert_depth, x509_get_sha1_hash(cert, &gc));
 
   /* did peer present cert which was signed by our root cert? */
-  if (!preverify_ok)
+  if (*flags != 0)
     {
       char *subject = x509_get_subject(cert, &gc);
 
@@ -69,21 +68,19 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
 	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, could not extract X509 "
 	      "subject string from certificate", cert_depth);
 
-      goto cleanup;
+      /* Leave flags set to non-zero to indicate that the cert is not ok */
+    }
+  else if (SUCCESS != verify_cert(session, cert, cert_depth))
+    {
+      *flags |= BADCERT_OTHER;
     }
 
-  if (SUCCESS != verify_cert(session, cert, cert_depth))
-    goto cleanup;
-
-  ret = 0;
-
-cleanup:
   gc_free(&gc);
 
   /*
-   * PolarSSL expects 1 on failure, 0 on success
+   * PolarSSL-1.2.0+ expects 0 on anything except fatal errors.
    */
-  return ret;
+  return 0;
 }
 
 #ifdef ENABLE_X509ALTUSERNAME
diff --git a/src/openvpn/ssl_verify_polarssl.h b/src/openvpn/ssl_verify_polarssl.h
index fceee66..b259081 100644
--- a/src/openvpn/ssl_verify_polarssl.h
+++ b/src/openvpn/ssl_verify_polarssl.h
@@ -55,27 +55,25 @@ typedef x509_cert openvpn_x509_cert_t;
  * calls the PolarSSL library's \c ssl_set_verify_callback() function with \c
  * verify_callback() as its callback argument.
  *
- * It checks preverify_ok, and registers the certificate hash. If these steps
- * succeed, it calls the \c verify_cert() function, which performs
- * OpenVPN-specific verification.
+ * It checks *flags and registers the certificate hash. If these steps succeed,
+ * it calls the \c verify_cert() function, which performs OpenVPN-specific
+ * verification.
  *
  * @param session_obj  - The OpenVPN \c tls_session associated with this object,
  *                       as set during SSL session setup.
  * @param cert         - The certificate used by PolarSSL.
  * @param cert_depth   - The depth of the current certificate in the chain, with
  *                       0 being the actual certificate.
- * @param preverify_ok - Whether the remote OpenVPN peer's certificate
- *                       past verification.  A value of 1 means it
- *                       verified successfully, 0 means it failed.
+ * @param flags        - Whether the remote OpenVPN peer's certificate
+ *                       passed verification.  A value of 0 means it
+ *                       verified successfully, any other value means it
+ *                       failed. \c verify_callback() is considered to have
+ *                       ok'ed this certificate if flags is 0 when it returns.
  *
- * @return The return value indicates whether the supplied certificate is
- *     allowed to set up a VPN tunnel.  The following values can be
- *     returned:
- *      - \c 0: failure, this certificate is not allowed to connect.
- *      - \c 1: success, this certificate is allowed to connect.
+ * @return The return value is 0 unless a fatal error occurred.
  */
 int verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
-    int preverify_ok);
+    int *flags);
 
 /** @} name Function for authenticating a new connection from a remote OpenVPN peer */
 
-- 
1.7.9.5


