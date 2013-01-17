From: <steffan.karger@...1435...>
Date: Thu, 17 Jan 2013 09:23:29 +0100
Message-ID: <1358411009-2350-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
References: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] PolarSSL-1.2 support
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

Add support for PolarSSL-1.2, which has changed the API in several places. This
is a minimal port: PolarSSL-1.2 works as well as PolarSSL-1.1, but the new
features have not been enabled.

Blacklist PolarSSL-1.[0-2] for bugs when verifying certificate chains

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 configure.ac                      |    2 ++
 src/openvpn/crypto_polarssl.h     |    4 +++
 src/openvpn/options.c             |    4 +++
 src/openvpn/ssl_polarssl.c        |   29 ++++++++++++++++++++--
 src/openvpn/ssl_polarssl.h        |    4 +++
 src/openvpn/ssl_verify_polarssl.c |   49 ++++++++++++++++++++++++++++---------
 src/openvpn/ssl_verify_polarssl.h |   45 ++++++++++++++++++++++++++++------
 7 files changed, 115 insertions(+), 22 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2f780b7..97e5d09 100644
--- a/configure.ac
+++ b/configure.ac
@@ -807,6 +807,8 @@ if test "${with_crypto_library}" = "polarssl" ; then
 			[[
 #if POLARSSL_VERSION_NUMBER < 0x01010000
 #error invalid version
+#elif POLARSSL_VERSION_NUMBER >= 0x01020000 && POLARSSL_VERSION_NUMBER < 0x01020300
+#error PolarSSL-1.2.x before 1.2.3 is incompatible with OpenVPN
 #endif
 			]]
 		)],
diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index bfabb91..e3dee5c 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -60,7 +60,11 @@ typedef md_context_t hmac_ctx_t;
 #define OPENVPN_MODE_OFB 	POLARSSL_MODE_OFB
 
 /** Cipher is in CFB mode */
+#if POLARSSL_VERSION_NUMBER < 0x01020000
 #define OPENVPN_MODE_CFB 	POLARSSL_MODE_CFB128
+#else
+#define OPENVPN_MODE_CFB 	POLARSSL_MODE_CFB
+#endif
 
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
index 210bbab..9e99675 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -44,6 +44,7 @@
 #include "manage.h"
 #include "ssl_common.h"
 
+#include <polarssl/version.h>
 #include <polarssl/sha2.h>
 #include <polarssl/havege.h>
 
@@ -65,6 +66,8 @@ tls_clear_error()
 {
 }
 
+#if POLARSSL_VERSION_NUMBER < 0x01020000
+/* The default list of ciphers is already initialized in PolarSSL-1.2.0+ */
 static int default_ciphersuites[] =
 {
     SSL_EDH_RSA_AES_256_SHA,
@@ -81,6 +84,7 @@ static int default_ciphersuites[] =
     SSL_RSA_RC4_128_MD5,
     0
 };
+#endif
 
 void
 tls_ctx_server_new(struct tls_root_ctx *ctx)
@@ -514,27 +518,43 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
 
       ssl_set_rng (ks_ssl->ctx, ctr_drbg_random, rand_ctx_get());
 
+#if POLARSSL_VERSION_NUMBER < 0x01020000
+      /* Handled implicitly in PolarSSL-1.2.0+ */
       ALLOC_OBJ_CLEAR (ks_ssl->ssn, ssl_session);
       ssl_set_session (ks_ssl->ctx, 0, 0, ks_ssl->ssn );
+#endif
       if (ssl_ctx->allowed_ciphers)
 	ssl_set_ciphersuites (ks_ssl->ctx, ssl_ctx->allowed_ciphers);
+#if POLARSSL_VERSION_NUMBER < 0x01020000
       else
+        /* Handled implicitly in PolarSSL-1.2.0+ */
 	ssl_set_ciphersuites (ks_ssl->ctx, default_ciphersuites);
+#endif
 
       /* Initialise authentication information */
       if (is_server)
 	ssl_set_dh_param_ctx (ks_ssl->ctx, ssl_ctx->dhm_ctx );
 #if defined(ENABLE_PKCS11)
       if (ssl_ctx->priv_key_pkcs11 != NULL)
+#if POLARSSL_VERSION_NUMBER < 0x01020000
 	ssl_set_own_cert_pkcs11( ks_ssl->ctx, ssl_ctx->crt_chain,
 	    ssl_ctx->priv_key_pkcs11 );
+#else
+	ssl_set_own_cert_alt( ks_ssl->ctx, ssl_ctx->crt_chain,
+	    ssl_ctx->priv_key_pkcs11, ssl_pkcs11_decrypt, ssl_pkcs11_sign,
+	    ssl_pkcs11_key_len );
+#endif
       else
 #endif
 	ssl_set_own_cert( ks_ssl->ctx, ssl_ctx->crt_chain, ssl_ctx->priv_key );
 
       /* Initialise SSL verification */
       ssl_set_authmode (ks_ssl->ctx, SSL_VERIFY_REQUIRED);
+#if POLARSSL_VERSION_NUMBER < 0x01020000
+      ssl_set_verify (ks_ssl->ctx, verify_callback_1_1, session);
+#else
       ssl_set_verify (ks_ssl->ctx, verify_callback, session);
+#endif
       /* TODO: PolarSSL does not currently support sending the CA chain to the client */
       ssl_set_ca_chain (ks_ssl->ctx, ssl_ctx->ca_chain, NULL, NULL );
 
@@ -543,7 +563,6 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
       ALLOC_OBJ_CLEAR (ks_ssl->ct_out, endless_buffer);
       ssl_set_bio (ks_ssl->ctx, endless_buf_read, ks_ssl->ct_in,
 	  endless_buf_write, ks_ssl->ct_out);
-
     }
 }
 
@@ -556,8 +575,10 @@ key_state_ssl_free(struct key_state_ssl *ks_ssl)
 	  ssl_free(ks_ssl->ctx);
 	  free(ks_ssl->ctx);
 	}
+#if POLARSSL_VERSION_NUMBER < 0x01020000
       if (ks_ssl->ssn)
 	free(ks_ssl->ssn);
+#endif
       if (ks_ssl->ct_in) {
 	buf_free_entries(ks_ssl->ct_in);
 	free(ks_ssl->ct_in);
@@ -834,7 +855,7 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
 void
 print_details (struct key_state_ssl * ks_ssl, const char *prefix)
 {
-  x509_cert *cert;
+  const x509_cert *cert;
   char s1[256];
   char s2[256];
 
@@ -844,7 +865,11 @@ print_details (struct key_state_ssl * ks_ssl, const char *prefix)
 		    ssl_get_version (ks_ssl->ctx),
 		    ssl_get_ciphersuite(ks_ssl->ctx));
 
+#if POLARSSL_VERSION_NUMBER < 0x01020000
   cert = ks_ssl->ctx->peer_cert;
+#else
+  cert = ssl_get_peer_cert(ks_ssl->ctx);
+#endif
   if (cert != NULL)
     {
       openvpn_snprintf (s2, sizeof (s2), ", " counter_format " bit RSA", (counter_type) cert->rsa.len * 8);
diff --git a/src/openvpn/ssl_polarssl.h b/src/openvpn/ssl_polarssl.h
index 456573f..11edf3e 100644
--- a/src/openvpn/ssl_polarssl.h
+++ b/src/openvpn/ssl_polarssl.h
@@ -30,6 +30,7 @@
 #ifndef SSL_POLARSSL_H_
 #define SSL_POLARSSL_H_
 
+#include <polarssl/version.h>
 #include <polarssl/ssl.h>
 
 #if defined(ENABLE_PKCS11)
@@ -73,7 +74,10 @@ struct tls_root_ctx {
 
 struct key_state_ssl {
         ssl_context *ctx;
+#if POLARSSL_VERSION_NUMBER < 0x01020000
+        /* Implicit in PolarSSL-1.2.0+ */
         ssl_session *ssn;
+#endif
         endless_buffer *ct_in;
         endless_buffer *ct_out;
 };
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 79255cb..86c58d6 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -38,17 +38,17 @@
 #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL)
 
 #include "ssl_verify.h"
+#include <polarssl/version.h>
 #include <polarssl/sha1.h>
 
 #define MAX_SUBJECT_LENGTH 256
 
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
@@ -59,7 +59,7 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
   cert_hash_remember (session, cert_depth, x509_get_sha1_hash(cert, &gc));
 
   /* did peer present cert which was signed by our root cert? */
-  if (!preverify_ok)
+  if (*flags != 0)
     {
       char *subject = x509_get_subject(cert, &gc);
 
@@ -69,22 +69,47 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
 	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, flags=%0x, could not extract X509 "
 	      "subject string from certificate", *flags, cert_depth);
 
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
+}
+
+#if POLARSSL_VERSION_NUMBER < 0x01020000
+int 
+verify_callback_1_1 (void *session_obj, x509_cert *cert, int cert_depth,
+    int preverify_ok)
+{
+    int flags;
+
+    if (preverify_ok)
+	    flags = 0;
+    else
+	    flags = 0x100 /* BADCERT_OTHER in 1.2 */;
+
+    if (verify_callback(session_obj, cert, cert_depth, &flags) != 0)
+        return 1;
+
+    /*
+     * In PolarSSL-1.2.0+, we should set *flags to nonzero to indicate
+     * verification failure; older PolarSSL expect us to return 1 to indicate
+     * verification failure.
+     */
+    if (flags != 0)
+        return 1;
+
+    return 0;
 }
+#endif
 
 #ifdef ENABLE_X509ALTUSERNAME
 # warning "X509 alt user name not yet supported for PolarSSL"
diff --git a/src/openvpn/ssl_verify_polarssl.h b/src/openvpn/ssl_verify_polarssl.h
index fceee66..21bd6e9 100644
--- a/src/openvpn/ssl_verify_polarssl.h
+++ b/src/openvpn/ssl_verify_polarssl.h
@@ -33,6 +33,7 @@
 #include "syshead.h"
 #include "misc.h"
 #include "manage.h"
+#include <polarssl/version.h>
 #include <polarssl/x509.h>
 
 #ifndef __OPENVPN_X509_CERT_T_DECLARED
@@ -40,6 +41,10 @@
 typedef x509_cert openvpn_x509_cert_t;
 #endif
 
+#if POLARSSL_VERSION_NUMBER < 0x01020000
+#define BADCERT_OTHER 0x100
+#endif
+
 /** @name Function for authenticating a new connection from a remote OpenVPN peer
  *  @{ */
 
@@ -55,9 +60,33 @@ typedef x509_cert openvpn_x509_cert_t;
  * calls the PolarSSL library's \c ssl_set_verify_callback() function with \c
  * verify_callback() as its callback argument.
  *
- * It checks preverify_ok, and registers the certificate hash. If these steps
- * succeed, it calls the \c verify_cert() function, which performs
- * OpenVPN-specific verification.
+ * It checks *flags and registers the certificate hash. If these steps succeed,
+ * it calls the \c verify_cert() function, which performs OpenVPN-specific
+ * verification.
+ *
+ * @param session_obj  - The OpenVPN \c tls_session associated with this object,
+ *                       as set during SSL session setup.
+ * @param cert         - The certificate used by PolarSSL.
+ * @param cert_depth   - The depth of the current certificate in the chain, with
+ *                       0 being the actual certificate.
+ * @param flags        - Whether the remote OpenVPN peer's certificate
+ *                       passed verification.  A value of 0 means it
+ *                       verified successfully, any other value means it
+ *                       failed. \c verify_callback() is considered to have
+ *                       ok'ed this certificate if flags is 0 when it returns.
+ *
+ * @return The return value is 0 unless a fatal error occurred.
+ */
+int verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
+    int *flags);
+
+/** @} name Function for authenticating a new connection from a remote OpenVPN peer */
+
+/**
+ * Compatibility shim: verify_callback() for PolarSSL before 1.2.0.
+ * @ingroup control_tls
+ *
+ * As \c verify_callback(), but for use with older versions of PolarSSL.
  *
  * @param session_obj  - The OpenVPN \c tls_session associated with this object,
  *                       as set during SSL session setup.
@@ -65,8 +94,8 @@ typedef x509_cert openvpn_x509_cert_t;
  * @param cert_depth   - The depth of the current certificate in the chain, with
  *                       0 being the actual certificate.
  * @param preverify_ok - Whether the remote OpenVPN peer's certificate
- *                       past verification.  A value of 1 means it
- *                       verified successfully, 0 means it failed.
+ *                       passed verification.  A value of 1 means it verified
+ *                       successfully, 0 means it failed.
  *
  * @return The return value indicates whether the supplied certificate is
  *     allowed to set up a VPN tunnel.  The following values can be
@@ -74,9 +103,9 @@ typedef x509_cert openvpn_x509_cert_t;
  *      - \c 0: failure, this certificate is not allowed to connect.
  *      - \c 1: success, this certificate is allowed to connect.
  */
-int verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
+#if POLARSSL_VERSION_NUMBER < 0x01020000
+int verify_callback_1_1 (void *session_obj, x509_cert *cert, int cert_depth,
     int preverify_ok);
-
-/** @} name Function for authenticating a new connection from a remote OpenVPN peer */
+#endif
 
 #endif /* SSL_VERIFY_POLARSSL_H_ */
-- 
1.7.9.5


