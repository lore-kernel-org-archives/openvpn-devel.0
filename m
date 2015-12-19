From: Steffan Karger <steffan@...1856...>
Date: Sat, 19 Dec 2015 12:39:28 +0100
Message-Id: <1450525169-12961-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] Upgrade OpenVPN 2.3 to PolarSSL 1.3
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

PolarSSL 1.2 is going end-of-support by 31-12-2015, so we have to move
on.  Newer versions of polarssl/mbedtls are already released (2.0-2.2),
but as previously agreed upon, we will just move release/2.3 to polar
1.3, where master has been for a while now.

This commit removes support for PolarSSL 1.2.  The mimimum required
version of PolarSSL is now 1.3.8.

This commit is a combination of a number of commits related to upgrading
or fixing polarssl 1.3 support from the master branch, adjusted to apply
to the release/2.3 branch:
03df3a99 Upgrade to PolarSSL 1.3
cc1cee74 Update openvpn-plugin.h for PolarSSL 1.3.
4b9eaa1e Fix regression with password protected private keys (polarssl)
d0f26fb5 polarssl: disable 1/n-1 record splitting
444a93ea polarssl: fix --client-cert-not-required
9571010a polarssl: also allocate PKCS#11 certificate object on demand
67a67e39 polarssl: don't use deprecated functions anymore
9d3b7cec polarssl: require >= 1.3.8

This commit was tested using:
 * Regular private key file
 * Password-protected private key file
 * PKCS#11
 * --management-external-key
 * CRL file (with and w/o revoked cert)
 * With and w/o tls-auth
 * RSA and ECDSA key/certs

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 README.polarssl                   |   2 +-
 configure.ac                      |   4 +-
 include/openvpn-plugin.h          |   4 +-
 src/openvpn/crypto_polarssl.c     |  13 +-
 src/openvpn/pkcs11_polarssl.c     |  26 ++--
 src/openvpn/ssl_polarssl.c        | 299 ++++++++++++++++++++------------------
 src/openvpn/ssl_polarssl.h        |   7 +-
 src/openvpn/ssl_verify.c          |   2 +-
 src/openvpn/ssl_verify_backend.h  |   2 +-
 src/openvpn/ssl_verify_openssl.c  |   2 +-
 src/openvpn/ssl_verify_polarssl.c | 116 +++++----------
 src/openvpn/ssl_verify_polarssl.h |   6 +-
 12 files changed, 234 insertions(+), 249 deletions(-)

diff --git a/README.polarssl b/README.polarssl
index 06f30bf..d34d44a 100644
--- a/README.polarssl
+++ b/README.polarssl
@@ -7,7 +7,7 @@ To Build and Install,
 	make
 	make install
 
-This version depends on PolarSSL 1.2 (and requires at least 1.2.10).
+This version depends on PolarSSL 1.3 (and requires at least 1.3.8).
 
 *************************************************************************
 
diff --git a/configure.ac b/configure.ac
index a2f458d..7644c55 100644
--- a/configure.ac
+++ b/configure.ac
@@ -835,13 +835,13 @@ if test "${with_crypto_library}" = "polarssl" ; then
 #include <polarssl/version.h>
 			]],
 			[[
-#if POLARSSL_VERSION_NUMBER < 0x01020A00 || POLARSSL_VERSION_NUMBER >= 0x01030000
+#if POLARSSL_VERSION_NUMBER < 0x01030800 || POLARSSL_VERSION_NUMBER >= 0x01040000
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([PolarSSL 1.2.x required and must be 1.2.10 or later])]
+		[AC_MSG_ERROR([PolarSSL 1.3.x required and must be 1.3.8 or later])]
 	)
 
 	polarssl_with_pkcs11="no"
diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
index 03da92a..5f2d407 100644
--- a/include/openvpn-plugin.h
+++ b/include/openvpn-plugin.h
@@ -29,10 +29,10 @@
 
 #ifdef ENABLE_SSL
 #ifdef ENABLE_CRYPTO_POLARSSL
-#include <polarssl/x509.h>
+#include <polarssl/x509_crt.h>
 #ifndef __OPENVPN_X509_CERT_T_DECLARED
 #define __OPENVPN_X509_CERT_T_DECLARED
-typedef x509_cert openvpn_x509_cert_t;
+typedef x509_crt openvpn_x509_cert_t;
 #endif
 #else
 #include <openssl/x509.h>
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index af79029..24712ed 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -457,7 +457,7 @@ cipher_ctx_init (cipher_context_t *ctx, uint8_t *key, int key_len,
 
 void cipher_ctx_cleanup (cipher_context_t *ctx)
 {
-  cipher_free_ctx(ctx);
+  cipher_free(ctx);
 }
 
 int cipher_ctx_iv_length (const cipher_context_t *ctx)
@@ -487,7 +487,12 @@ cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
 
 int cipher_ctx_reset (cipher_context_t *ctx, uint8_t *iv_buf)
 {
-  return 0 == cipher_reset(ctx, iv_buf);
+  int retval = cipher_reset(ctx);
+
+  if (0 == retval)
+    retval = cipher_set_iv(ctx, iv_buf, ctx->cipher_info->iv_size);
+
+  return 0 == retval;
 }
 
 int cipher_ctx_update (cipher_context_t *ctx, uint8_t *dst, int *dst_len,
@@ -614,7 +619,7 @@ void
 md_ctx_final (md_context_t *ctx, uint8_t *dst)
 {
   ASSERT(0 == md_finish(ctx, dst));
-  ASSERT(0 == md_free_ctx(ctx));
+  md_free(ctx);
 }
 
 
@@ -645,7 +650,7 @@ hmac_ctx_init (md_context_t *ctx, const uint8_t *key, int key_len, const md_info
 void
 hmac_ctx_cleanup(md_context_t *ctx)
 {
-  ASSERT(0 == md_free_ctx(ctx));
+  md_free(ctx);
 }
 
 int
diff --git a/src/openvpn/pkcs11_polarssl.c b/src/openvpn/pkcs11_polarssl.c
index 03b2bab..a58beef 100644
--- a/src/openvpn/pkcs11_polarssl.c
+++ b/src/openvpn/pkcs11_polarssl.c
@@ -40,6 +40,7 @@
 #include "errlevel.h"
 #include "pkcs11_backend.h"
 #include <polarssl/pkcs11.h>
+#include <polarssl/x509.h>
 
 int
 pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
@@ -49,20 +50,21 @@ pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
 
   ASSERT (NULL != ssl_ctx);
 
+  ALLOC_OBJ_CLEAR (ssl_ctx->crt_chain, x509_crt);
   if (pkcs11_x509_cert_init(ssl_ctx->crt_chain, certificate)) {
       msg (M_FATAL, "PKCS#11: Cannot retrieve PolarSSL certificate object");
       goto cleanup;
   }
 
-  ssl_ctx->priv_key_pkcs11 = malloc(sizeof(pkcs11_context));
-
-  if (ssl_ctx->priv_key_pkcs11 == NULL) {
-      msg (M_FATAL, "PKCS#11: Cannot allocate PolarSSL private key object");
+  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key_pkcs11, pkcs11_context);
+  if (pkcs11_priv_key_init(ssl_ctx->priv_key_pkcs11, certificate)) {
+      msg (M_FATAL, "PKCS#11: Cannot initialize PolarSSL private key object");
       goto cleanup;
   }
 
-  if (pkcs11_priv_key_init(ssl_ctx->priv_key_pkcs11, certificate)) {
-      msg (M_FATAL, "PKCS#11: Cannot initialize PolarSSL private key object");
+  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key, pk_context);
+  if (0 != pk_init_ctx_rsa_alt(ssl_ctx->priv_key, ssl_ctx->priv_key_pkcs11,
+	ssl_pkcs11_decrypt, ssl_pkcs11_sign, ssl_pkcs11_key_len)) {
       goto cleanup;
   }
 
@@ -78,14 +80,14 @@ pkcs11_certificate_dn (pkcs11h_certificate_t cert, struct gc_arena *gc)
   char *ret = NULL;
   char dn[1024] = {0};
 
-  x509_cert polar_cert = {0};
+  x509_crt polar_cert = {0};
 
   if (pkcs11_x509_cert_init(&polar_cert, cert)) {
       msg (M_FATAL, "PKCS#11: Cannot retrieve PolarSSL certificate object");
       goto cleanup;
   }
 
-  if (-1 == x509parse_dn_gets (dn, sizeof(dn), &polar_cert.subject)) {
+  if (-1 == x509_dn_gets (dn, sizeof(dn), &polar_cert.subject)) {
       msg (M_FATAL, "PKCS#11: PolarSSL cannot parse subject");
       goto cleanup;
   }
@@ -93,7 +95,7 @@ pkcs11_certificate_dn (pkcs11h_certificate_t cert, struct gc_arena *gc)
   ret = string_alloc(dn, gc);
 
 cleanup:
-  x509_free(&polar_cert);
+  x509_crt_free(&polar_cert);
 
   return ret;
 }
@@ -104,14 +106,14 @@ pkcs11_certificate_serial (pkcs11h_certificate_t cert, char *serial,
 {
   int ret = 1;
 
-  x509_cert polar_cert = {0};
+  x509_crt polar_cert = {0};
 
   if (pkcs11_x509_cert_init(&polar_cert, cert)) {
       msg (M_FATAL, "PKCS#11: Cannot retrieve PolarSSL certificate object");
       goto cleanup;
   }
 
-  if (-1 == x509parse_serial_gets (serial, serial_len, &polar_cert.serial)) {
+  if (-1 == x509_serial_gets (serial, serial_len, &polar_cert.serial)) {
       msg (M_FATAL, "PKCS#11: PolarSSL cannot parse serial");
       goto cleanup;
   }
@@ -119,7 +121,7 @@ pkcs11_certificate_serial (pkcs11h_certificate_t cert, char *serial,
   ret = 0;
 
 cleanup:
-  x509_free(&polar_cert);
+  x509_crt_free(&polar_cert);
 
   return ret;
 }
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 32566e4..8d9d219 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -46,12 +46,13 @@
 #include "manage.h"
 #include "ssl_common.h"
 
-#include <polarssl/sha2.h>
 #include <polarssl/havege.h>
 
 #include "ssl_verify_polarssl.h"
 #include <polarssl/error.h>
+#include <polarssl/oid.h>
 #include <polarssl/pem.h>
+#include <polarssl/sha256.h>
 #include <polarssl/version.h>
 
 void
@@ -76,11 +77,8 @@ tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
   CLEAR(*ctx);
 
   ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
-  ALLOC_OBJ_CLEAR(ctx->priv_key, rsa_context);
-
-  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_cert);
-  ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_cert);
 
+  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_crt);
 
   ctx->endpoint = SSL_IS_SERVER;
   ctx->initialised = true;
@@ -93,10 +91,7 @@ tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
   CLEAR(*ctx);
 
   ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
-  ALLOC_OBJ_CLEAR(ctx->priv_key, rsa_context);
-
-  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_cert);
-  ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_cert);
+  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_crt);
 
   ctx->endpoint = SSL_IS_CLIENT;
   ctx->initialised = true;
@@ -107,17 +102,21 @@ tls_ctx_free(struct tls_root_ctx *ctx)
 {
   if (ctx)
     {
-      rsa_free(ctx->priv_key);
-      free(ctx->priv_key);
+      pk_free(ctx->priv_key);
+      if (ctx->priv_key)
+	free(ctx->priv_key);
 
-      x509_free(ctx->ca_chain);
-      free(ctx->ca_chain);
+      x509_crt_free(ctx->ca_chain);
+      if (ctx->ca_chain)
+	free(ctx->ca_chain);
 
-      x509_free(ctx->crt_chain);
-      free(ctx->crt_chain);
+      x509_crt_free(ctx->crt_chain);
+      if (ctx->crt_chain)
+	free(ctx->crt_chain);
 
       dhm_free(ctx->dhm_ctx);
-      free(ctx->dhm_ctx);
+      if (ctx->dhm_ctx)
+	free(ctx->dhm_ctx);
 
 #if defined(ENABLE_PKCS11)
       if (ctx->priv_key_pkcs11 != NULL) {
@@ -212,13 +211,13 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
 {
   if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_inline)
     {
-      if (0 != x509parse_dhm(ctx->dhm_ctx, (const unsigned char *) dh_inline,
+      if (0 != dhm_parse_dhm(ctx->dhm_ctx, (const unsigned char *) dh_inline,
 	  strlen(dh_inline)))
 	msg (M_FATAL, "Cannot read inline DH parameters");
   }
 else
   {
-    if (0 != x509parse_dhmfile(ctx->dhm_ctx, dh_file))
+    if (0 != dhm_parse_dhmfile(ctx->dhm_ctx, dh_file))
       msg (M_FATAL, "Cannot read DH parameters from file %s", dh_file);
   }
 
@@ -251,15 +250,20 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
 {
   ASSERT(NULL != ctx);
 
+  if (!ctx->crt_chain)
+    {
+      ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_crt);
+    }
+
   if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_inline)
     {
-      if (0 != x509parse_crt(ctx->crt_chain,
+      if (0 != x509_crt_parse(ctx->crt_chain,
 	  (const unsigned char *) cert_inline, strlen(cert_inline)))
         msg (M_FATAL, "Cannot load inline certificate file");
     }
   else
     {
-      if (0 != x509parse_crtfile(ctx->crt_chain, cert_file))
+      if (0 != x509_crt_parse_file(ctx->crt_chain, cert_file))
 	msg (M_FATAL, "Cannot load certificate file %s", cert_file);
     }
 }
@@ -272,34 +276,40 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
   int status;
   ASSERT(NULL != ctx);
 
+  if (!ctx->priv_key)
+    {
+      ALLOC_OBJ_CLEAR(ctx->priv_key, pk_context);
+    }
+
   if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_inline)
     {
-      status = x509parse_key(ctx->priv_key,
+      status = pk_parse_key(ctx->priv_key,
 	  (const unsigned char *) priv_key_inline, strlen(priv_key_inline),
 	  NULL, 0);
-      if (POLARSSL_ERR_X509_PASSWORD_REQUIRED == status)
+
+      if (POLARSSL_ERR_PK_PASSWORD_REQUIRED == status)
 	{
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
-	  status = x509parse_key(ctx->priv_key,
+	  status = pk_parse_key(ctx->priv_key,
 	      (const unsigned char *) priv_key_inline, strlen(priv_key_inline),
-	      (const unsigned char *) passbuf, strlen(passbuf));
+	      (unsigned char *) passbuf, strlen(passbuf));
 	}
     }
   else
     {
-      status = x509parse_keyfile(ctx->priv_key, priv_key_file, NULL);
-      if (POLARSSL_ERR_X509_PASSWORD_REQUIRED == status)
+      status = pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);
+      if (POLARSSL_ERR_PK_PASSWORD_REQUIRED == status)
 	{
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
-	  status = x509parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
+	  status = pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
 	}
     }
   if (0 != status)
     {
 #ifdef ENABLE_MANAGEMENT
-      if (management && (POLARSSL_ERR_X509_PASSWORD_MISMATCH == status))
+      if (management && (POLARSSL_ERR_PK_PASSWORD_MISMATCH == status))
 	  management_auth_failure (management, UP_TYPE_PRIVATE_KEY, NULL);
 #endif
       msg (M_WARN, "Cannot load private key file %s", priv_key_file);
@@ -323,43 +333,43 @@ struct external_context {
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
-  ctx->external_key->signature_length = ctx->crt_chain->rsa.len;
-
-  return 1;
-}
-
+/**
+ * external_pkcs1_sign implements a PolarSSL rsa_sign_func callback, that uses
+ * the management interface to request an RSA signature for the supplied hash.
+ *
+ * @param ctx_voidptr   Management external key context.
+ * @param f_rng         (Unused)
+ * @param p_rng         (Unused)
+ * @param mode          RSA mode (should be RSA_PRIVATE).
+ * @param md_alg        Message digest ('hash') algorithm type.
+ * @param hashlen       Length of hash (overridden by length specified by md_alg
+ *                      if md_alg != POLARSSL_MD_NONE).
+ * @param hash          The digest ('hash') to sign. Should have a size
+ *                      matching the length of md_alg (if != POLARSSL_MD_NONE),
+ *                      or hashlen otherwise.
+ * @param sig           Buffer that returns the signature. Should be at least of
+ *                      size ctx->signature_length.
+ *
+ * @return 0 on success, non-zero polarssl error code on failure.
+ */
 static inline int external_pkcs1_sign( void *ctx_voidptr,
     int (*f_rng)(void *, unsigned char *, size_t), void *p_rng, int mode,
-    int hash_id, unsigned int hashlen, const unsigned char *hash,
+    md_type_t md_alg, unsigned int hashlen, const unsigned char *hash,
     unsigned char *sig )
 {
   struct external_context * const ctx = ctx_voidptr;
   char *in_b64 = NULL;
   char *out_b64 = NULL;
   int rv;
-  unsigned char * const p = sig;
-  size_t asn_len;
+  unsigned char *p = sig;
+  size_t asn_len = 0, oid_size = 0, sig_len = 0;
+  const char *oid = NULL;
 
-  ASSERT(NULL != ctx);
+  if( NULL == ctx )
+    return POLARSSL_ERR_RSA_BAD_INPUT_DATA;
 
-  if (RSA_PRIVATE != mode)
-    {
-      rv = POLARSSL_ERR_RSA_BAD_INPUT_DATA;
-      goto done;
-    }
+  if( RSA_PRIVATE != mode )
+    return POLARSSL_ERR_RSA_BAD_INPUT_DATA;
 
   /*
    * Support a wide range of hashes. TLSv1.1 and before only need SIG_RSA_RAW,
@@ -367,67 +377,54 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
    *
    * This code has been taken from PolarSSL pkcs11_sign(), under the GPLv2.0+.
    */
-  switch( hash_id )
-  {
-      case SIG_RSA_RAW:
-          asn_len = 0;
-          memcpy( p, hash, hashlen );
-          break;
-
-      case SIG_RSA_MD2:
-          asn_len = OID_SIZE(ASN1_HASH_MDX);
-          memcpy( p, ASN1_HASH_MDX, asn_len );
-          memcpy( p + asn_len, hash, hashlen );
-          p[13] = 2; break;
-
-      case SIG_RSA_MD4:
-          asn_len = OID_SIZE(ASN1_HASH_MDX);
-          memcpy( p, ASN1_HASH_MDX, asn_len );
-          memcpy( p + asn_len, hash, hashlen );
-          p[13] = 4; break;
-
-      case SIG_RSA_MD5:
-          asn_len = OID_SIZE(ASN1_HASH_MDX);
-          memcpy( p, ASN1_HASH_MDX, asn_len );
-          memcpy( p + asn_len, hash, hashlen );
-          p[13] = 5; break;
-
-      case SIG_RSA_SHA1:
-          asn_len = OID_SIZE(ASN1_HASH_SHA1);
-          memcpy( p, ASN1_HASH_SHA1, asn_len );
-          memcpy( p + 15, hash, hashlen );
-          break;
-
-      case SIG_RSA_SHA224:
-          asn_len = OID_SIZE(ASN1_HASH_SHA2X);
-          memcpy( p, ASN1_HASH_SHA2X, asn_len );
-          memcpy( p + asn_len, hash, hashlen );
-          p[1] += hashlen; p[14] = 4; p[18] += hashlen; break;
-
-      case SIG_RSA_SHA256:
-          asn_len = OID_SIZE(ASN1_HASH_SHA2X);
-          memcpy( p, ASN1_HASH_SHA2X, asn_len );
-          memcpy( p + asn_len, hash, hashlen );
-          p[1] += hashlen; p[14] = 1; p[18] += hashlen; break;
-
-      case SIG_RSA_SHA384:
-          asn_len = OID_SIZE(ASN1_HASH_SHA2X);
-          memcpy( p, ASN1_HASH_SHA2X, asn_len );
-          memcpy( p + asn_len, hash, hashlen );
-          p[1] += hashlen; p[14] = 2; p[18] += hashlen; break;
-
-      case SIG_RSA_SHA512:
-          asn_len = OID_SIZE(ASN1_HASH_SHA2X);
-          memcpy( p, ASN1_HASH_SHA2X, asn_len );
-          memcpy( p + asn_len, hash, hashlen );
-          p[1] += hashlen; p[14] = 3; p[18] += hashlen; break;
-
-  /* End of copy */
-      default:
-          rv = POLARSSL_ERR_RSA_BAD_INPUT_DATA;
-	  goto done;
+  if( md_alg != POLARSSL_MD_NONE )
+    {
+      const md_info_t *md_info = md_info_from_type( md_alg );
+      if( md_info == NULL )
+        return( POLARSSL_ERR_RSA_BAD_INPUT_DATA );
+
+      if( oid_get_oid_by_md( md_alg, &oid, &oid_size ) != 0 )
+        return( POLARSSL_ERR_RSA_BAD_INPUT_DATA );
+
+      hashlen = md_get_size( md_info );
+      asn_len = 10 + oid_size;
+    }
+
+  sig_len = ctx->signature_length;
+  if ( (SIZE_MAX - hashlen) < asn_len || (hashlen + asn_len) > sig_len )
+    return POLARSSL_ERR_RSA_BAD_INPUT_DATA;
+
+  if( md_alg != POLARSSL_MD_NONE )
+    {
+      /*
+       * DigestInfo ::= SEQUENCE {
+       *   digestAlgorithm DigestAlgorithmIdentifier,
+       *   digest Digest }
+       *
+       * DigestAlgorithmIdentifier ::= AlgorithmIdentifier
+       *
+       * Digest ::= OCTET STRING
+       */
+      *p++ = ASN1_SEQUENCE | ASN1_CONSTRUCTED;
+      *p++ = (unsigned char) ( 0x08 + oid_size + hashlen );
+      *p++ = ASN1_SEQUENCE | ASN1_CONSTRUCTED;
+      *p++ = (unsigned char) ( 0x04 + oid_size );
+      *p++ = ASN1_OID;
+      *p++ = oid_size & 0xFF;
+      memcpy( p, oid, oid_size );
+      p += oid_size;
+      *p++ = ASN1_NULL;
+      *p++ = 0x00;
+      *p++ = ASN1_OCTET_STRING;
+      *p++ = hashlen;
+
+      /* Determine added ASN length */
+      asn_len = p - sig;
   }
 
+  /* Copy the hash to be signed */
+  memcpy( p, hash, hashlen );
+
   /* convert 'from' to base64 */
   if (openvpn_base64_encode (sig, asn_len + hashlen, &in_b64) <= 0)
     {
@@ -454,7 +451,7 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
 
   rv = 0;
 
- done:
+done:
   if (in_b64)
     free (in_b64);
   if (out_b64)
@@ -468,6 +465,28 @@ static inline size_t external_key_len(void *vctx)
 
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
+  if (0 != pk_init_ctx_rsa_alt(ctx->priv_key, ctx->external_key,
+	    NULL, external_pkcs1_sign, external_key_len))
+    return 0;
+
+  return 1;
+}
 #endif
 
 void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
@@ -480,14 +499,14 @@ void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 
   if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_inline)
     {
-      if (0 != x509parse_crt(ctx->ca_chain, (const unsigned char *) ca_inline,
+      if (0 != x509_crt_parse(ctx->ca_chain, (unsigned char *) ca_inline,
 	  strlen(ca_inline)))
 	msg (M_FATAL, "Cannot load inline CA certificates");
     }
   else
     {
       /* Load CA file for verifying peer supplied certificate */
-      if (0 != x509parse_crtfile(ctx->ca_chain, ca_file))
+      if (0 != x509_crt_parse_file(ctx->ca_chain, ca_file))
 	msg (M_FATAL, "Cannot load CA certificate file %s", ca_file);
     }
 }
@@ -499,16 +518,21 @@ tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
 {
   ASSERT(NULL != ctx);
 
+  if (!ctx->crt_chain)
+    {
+      ALLOC_OBJ_CLEAR (ctx->crt_chain, x509_crt);
+    }
+
   if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_inline)
     {
-      if (0 != x509parse_crt(ctx->crt_chain,
-	  (const unsigned char *) extra_certs_inline,
+      if (0 != x509_crt_parse(ctx->crt_chain,
+          (const unsigned char *) extra_certs_inline,
 	  strlen(extra_certs_inline)))
         msg (M_FATAL, "Cannot load inline extra-certs file");
     }
   else
     {
-      if (0 != x509parse_crtfile(ctx->crt_chain, extra_certs_file))
+      if (0 != x509_crt_parse_file(ctx->crt_chain, extra_certs_file))
 	msg (M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
     }
 }
@@ -631,9 +655,9 @@ void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 
   if (NULL != ctx->crt_chain)
     {
-      x509_cert *cert = ctx->crt_chain;
+      x509_crt *cert = ctx->crt_chain;
 
-      sha2(cert->tbs.p, cert->tbs.len, sha256_hash, false);
+      sha256(cert->tbs.p, cert->tbs.len, sha256_hash, false);
       if ( 0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
 	{
 	  ctr_drbg_update(cd_ctx, sha256_hash, 32);
@@ -707,24 +731,19 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
       if (ssl_ctx->allowed_ciphers)
 	ssl_set_ciphersuites (ks_ssl->ctx, ssl_ctx->allowed_ciphers);
 
+      /* Disable record splitting (for now).  OpenVPN assumes records are sent
+       * unfragmented, and changing that will require thorough review and
+       * testing.  Since OpenVPN is not susceptible to BEAST, we can just
+       * disable record splitting as a quick fix. */
+#if defined(POLARSSL_SSL_CBC_RECORD_SPLITTING)
+      ssl_set_cbc_record_splitting (ks_ssl->ctx, SSL_CBC_RECORD_SPLITTING_DISABLED);
+#endif /* POLARSSL_SSL_CBC_RECORD_SPLITTING */
+
       /* Initialise authentication information */
       if (is_server)
-	ssl_set_dh_param_ctx (ks_ssl->ctx, ssl_ctx->dhm_ctx );
-#if defined(ENABLE_PKCS11)
-      if (ssl_ctx->priv_key_pkcs11 != NULL)
-	ssl_set_own_cert_alt( ks_ssl->ctx, ssl_ctx->crt_chain,
-	    ssl_ctx->priv_key_pkcs11, ssl_pkcs11_decrypt, ssl_pkcs11_sign,
-	    ssl_pkcs11_key_len );
-      else
-#endif
-#if defined(MANAGMENT_EXTERNAL_KEY)
-      if (ssl_ctx->external_key != NULL)
-        ssl_set_own_cert_alt( ks_ssl->ctx, ssl_ctx->crt_chain,
-	   ssl_ctx->external_key, NULL, external_pkcs1_sign,
-	   external_key_len );
-      else
-#endif
-	ssl_set_own_cert( ks_ssl->ctx, ssl_ctx->crt_chain, ssl_ctx->priv_key );
+	ssl_set_dh_param_ctx (ks_ssl->ctx, ssl_ctx->dhm_ctx);
+
+      ssl_set_own_cert (ks_ssl->ctx, ssl_ctx->crt_chain, ssl_ctx->priv_key);
 
       /* Initialise SSL verification */
 #if P2MP_SERVER
@@ -1055,7 +1074,7 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
 void
 print_details (struct key_state_ssl * ks_ssl, const char *prefix)
 {
-  const x509_cert *cert;
+  const x509_crt *cert;
   char s1[256];
   char s2[256];
 
@@ -1068,7 +1087,7 @@ print_details (struct key_state_ssl * ks_ssl, const char *prefix)
   cert = ssl_get_peer_cert(ks_ssl->ctx);
   if (cert != NULL)
     {
-      openvpn_snprintf (s2, sizeof (s2), ", " counter_format " bit RSA", (counter_type) cert->rsa.len * 8);
+      openvpn_snprintf (s2, sizeof (s2), ", %zu bit key", pk_get_size(&cert->pk));
     }
 
   msg (D_HANDSHAKE, "%s%s", s1, s2);
diff --git a/src/openvpn/ssl_polarssl.h b/src/openvpn/ssl_polarssl.h
index fc9aa78..b80a509 100644
--- a/src/openvpn/ssl_polarssl.h
+++ b/src/openvpn/ssl_polarssl.h
@@ -33,6 +33,7 @@
 #include "syshead.h"
 
 #include <polarssl/ssl.h>
+#include <polarssl/x509_crt.h>
 
 #if defined(ENABLE_PKCS11)
 #include <polarssl/pkcs11.h>
@@ -64,9 +65,9 @@ struct tls_root_ctx {
     int endpoint; 		/**< Whether or not this is a server or a client */
 
     dhm_context *dhm_ctx;	/**< Diffie-Helmann-Merkle context */
-    x509_cert *crt_chain;	/**< Local Certificate chain */
-    x509_cert *ca_chain;	/**< CA chain for remote verification */
-    rsa_context *priv_key;	/**< Local private key */
+    x509_crt *crt_chain;	/**< Local Certificate chain */
+    x509_crt *ca_chain;		/**< CA chain for remote verification */
+    pk_context *priv_key;	/**< Local private key */
 #if defined(ENABLE_PKCS11)
     pkcs11_context *priv_key_pkcs11;	/**< PKCS11 private key */
 #endif
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 9693b81..ca69b41 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -619,7 +619,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
   string_replace_leading (subject, '-', '_');
 
   /* extract the username (default is CN) */
-  if (SUCCESS != x509_get_username (common_name, sizeof(common_name),
+  if (SUCCESS != backend_x509_get_username (common_name, sizeof(common_name),
       opt->x509_username_field, cert))
     {
       if (!cert_depth)
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 6f118c9..01e453e 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -109,7 +109,7 @@ unsigned char *x509_get_sha1_hash (openvpn_x509_cert_t *cert, struct gc_arena *g
  *
  * @return 		\c FAILURE, \c or SUCCESS
  */
-result_t x509_get_username (char *common_name, int cn_len,
+result_t backend_x509_get_username (char *common_name, int cn_len,
     char * x509_username_field, openvpn_x509_cert_t *peer_cert);
 
 /*
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 309e832..4750f02 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -200,7 +200,7 @@ extract_x509_field_ssl (X509_NAME *x509, const char *field_name, char *out,
 }
 
 result_t
-x509_get_username (char *common_name, int cn_len,
+backend_x509_get_username (char *common_name, int cn_len,
     char * x509_username_field, X509 *peer_cert)
 {
 #ifdef ENABLE_X509ALTUSERNAME
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index c39fc7c..ac252a3 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -38,14 +38,15 @@
 #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL)
 
 #include "ssl_verify.h"
-#include <polarssl/error.h>
 #include <polarssl/bignum.h>
+#include <polarssl/error.h>
+#include <polarssl/oid.h>
 #include <polarssl/sha1.h>
 
 #define MAX_SUBJECT_LENGTH 256
 
 int
-verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
+verify_callback (void *session_obj, x509_crt *cert, int cert_depth,
     int *flags)
 {
   struct tls_session *session = (struct tls_session *) session_obj;
@@ -90,8 +91,8 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
 #endif
 
 result_t
-x509_get_username (char *cn, int cn_len,
-    char *x509_username_field, x509_cert *cert)
+backend_x509_get_username (char *cn, int cn_len,
+    char *x509_username_field, x509_crt *cert)
 {
   x509_name *name;
 
@@ -102,7 +103,7 @@ x509_get_username (char *cn, int cn_len,
   /* Find common name */
   while( name != NULL )
   {
-      if( memcmp( name->oid.p, OID_CN, OID_SIZE(OID_CN) ) == 0)
+      if( memcmp( name->oid.p, OID_AT_CN, OID_SIZE(OID_AT_CN) ) == 0)
 	break;
 
       name = name->next;
@@ -170,14 +171,14 @@ backend_x509_get_serial_hex (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 
   buf = gc_malloc(len, true, gc);
 
-  if(x509parse_serial_gets(buf, len-1, &cert->serial) < 0)
+  if(x509_serial_gets(buf, len-1, &cert->serial) < 0)
     buf = NULL;
 
   return buf;
 }
 
 unsigned char *
-x509_get_sha1_hash (x509_cert *cert, struct gc_arena *gc)
+x509_get_sha1_hash (x509_crt *cert, struct gc_arena *gc)
 {
   unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
   sha1(cert->tbs.p, cert->tbs.len, sha1_hash);
@@ -185,14 +186,14 @@ x509_get_sha1_hash (x509_cert *cert, struct gc_arena *gc)
 }
 
 char *
-x509_get_subject(x509_cert *cert, struct gc_arena *gc)
+x509_get_subject(x509_crt *cert, struct gc_arena *gc)
 {
   char tmp_subject[MAX_SUBJECT_LENGTH] = {0};
   char *subject = NULL;
 
   int ret = 0;
 
-  ret = x509parse_dn_gets( tmp_subject, MAX_SUBJECT_LENGTH-1, &cert->subject );
+  ret = x509_dn_gets( tmp_subject, MAX_SUBJECT_LENGTH-1, &cert->subject );
   if (ret > 0)
     {
       /* Allocate the required space for the subject */
@@ -222,70 +223,28 @@ x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert)
   while( name != NULL )
     {
       char name_expand[64+8];
+      const char *shortname;
 
-      if( name->oid.len == 2 && memcmp( name->oid.p, OID_X520, 2 ) == 0 )
+      if( 0 == oid_get_attr_short_name(&name->oid, &shortname) )
 	{
-	  switch( name->oid.p[2] )
-	    {
-	    case X520_COMMON_NAME:
-		openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_CN",
-		    cert_depth); break;
-
-	    case X520_COUNTRY:
-		openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_C",
-		    cert_depth); break;
-
-	    case X520_LOCALITY:
-		openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_L",
-		    cert_depth); break;
-
-	    case X520_STATE:
-		openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_ST",
-		    cert_depth); break;
-
-	    case X520_ORGANIZATION:
-		openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_O",
-		    cert_depth); break;
-
-	    case X520_ORG_UNIT:
-		openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_OU",
-		    cert_depth); break;
-
-	    default:
-		openvpn_snprintf (name_expand, sizeof(name_expand),
-		    "X509_%d_0x%02X", cert_depth, name->oid.p[2]);
-		break;
-	    }
+	  openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_%s",
+	      cert_depth, shortname);
 	}
-	else if( name->oid.len == 8 && memcmp( name->oid.p, OID_PKCS9, 8 ) == 0 )
-	  {
-	    switch( name->oid.p[8] )
-	      {
-		case PKCS9_EMAIL:
-		  openvpn_snprintf (name_expand, sizeof(name_expand),
-		      "X509_%d_emailAddress", cert_depth); break;
-
-		default:
-		  openvpn_snprintf (name_expand, sizeof(name_expand),
-		      "X509_%d_0x%02X", cert_depth, name->oid.p[8]);
-		  break;
-	      }
-	  }
-	else
-	  {
-	    openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_\?\?",
-		cert_depth);
-	  }
-
-	for( i = 0; i < name->val.len; i++ )
+      else
+	{
+	  openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_\?\?",
+	      cert_depth);
+	}
+
+      for( i = 0; i < name->val.len; i++ )
 	{
-	    if( i >= (int) sizeof( s ) - 1 )
-		break;
+	  if( i >= (int) sizeof( s ) - 1 )
+	      break;
 
-	    c = name->val.p[i];
-	    if( c < 32 || c == 127 || ( c > 128 && c < 160 ) )
-		 s[i] = '?';
-	    else s[i] = c;
+	  c = name->val.p[i];
+	  if( c < 32 || c == 127 || ( c > 128 && c < 160 ) )
+	       s[i] = '?';
+	  else s[i] = c;
 	}
 	s[i] = '\0';
 
@@ -299,7 +258,7 @@ x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert)
 }
 
 result_t
-x509_verify_ns_cert_type(const x509_cert *cert, const int usage)
+x509_verify_ns_cert_type(const x509_crt *cert, const int usage)
 {
   if (usage == NS_CERT_CHECK_NONE)
     return SUCCESS;
@@ -314,7 +273,7 @@ x509_verify_ns_cert_type(const x509_cert *cert, const int usage)
 }
 
 result_t
-x509_verify_cert_ku (x509_cert *cert, const unsigned * const expected_ku,
+x509_verify_cert_ku (x509_crt *cert, const unsigned * const expected_ku,
     int expected_len)
 {
   result_t fFound = FAILURE;
@@ -347,7 +306,7 @@ x509_verify_cert_ku (x509_cert *cert, const unsigned * const expected_ku,
 }
 
 result_t
-x509_verify_cert_eku (x509_cert *cert, const char * const expected_oid)
+x509_verify_cert_eku (x509_crt *cert, const char * const expected_oid)
 {
   result_t fFound = FAILURE;
 
@@ -366,8 +325,7 @@ x509_verify_cert_eku (x509_cert *cert, const char * const expected_oid)
 	  char oid_num_str[1024];
 	  const char *oid_str;
 
-	  oid_str = x509_oid_get_description(oid);
-	  if (oid_str != NULL)
+	  if (0 == oid_get_extended_key_usage( oid, &oid_str ))
 	    {
 	      msg (D_HANDSHAKE, "++ Certificate has EKU (str) %s, expects %s",
 		  oid_str, expected_oid);
@@ -378,7 +336,7 @@ x509_verify_cert_eku (x509_cert *cert, const char * const expected_oid)
 		}
 	    }
 
-	  if (0 < x509_oid_get_numeric_string( oid_num_str,
+	  if (0 < oid_get_numeric_string( oid_num_str,
 	      sizeof (oid_num_str), oid))
 	    {
 	      msg (D_HANDSHAKE, "++ Certificate has EKU (oid) %s, expects %s",
@@ -397,7 +355,7 @@ x509_verify_cert_eku (x509_cert *cert, const char * const expected_oid)
 }
 
 result_t
-x509_write_pem(FILE *peercert_file, x509_cert *peercert)
+x509_write_pem(FILE *peercert_file, x509_crt *peercert)
 {
     msg (M_WARN, "PolarSSL does not support writing peer certificate in PEM format");
     return FAILURE;
@@ -407,18 +365,18 @@ x509_write_pem(FILE *peercert_file, x509_cert *peercert)
  * check peer cert against CRL
  */
 result_t
-x509_verify_crl(const char *crl_file, x509_cert *cert, const char *subject)
+x509_verify_crl(const char *crl_file, x509_crt *cert, const char *subject)
 {
   result_t retval = FAILURE;
   x509_crl crl = {0};
   struct gc_arena gc = gc_new();
   char *serial;
 
-  int polar_retval = x509parse_crlfile(&crl, crl_file);
+  int polar_retval = x509_crl_parse_file(&crl, crl_file);
   if (polar_retval != 0)
     {
       char errstr[128];
-      error_strerror(polar_retval, errstr, sizeof(errstr));
+      polarssl_strerror(polar_retval, errstr, sizeof(errstr));
       msg (M_WARN, "CRL: cannot read CRL from file %s (%s)", crl_file, errstr);
       goto end;
     }
@@ -432,7 +390,7 @@ x509_verify_crl(const char *crl_file, x509_cert *cert, const char *subject)
       goto end;
     }
 
-  if (0 != x509parse_revoked(cert, &crl))
+  if (0 != x509_crt_revoked(cert, &crl))
     {
       serial = backend_x509_get_serial_hex(cert, &gc);
       msg (D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", subject, (serial ? serial : "NOT AVAILABLE"));
diff --git a/src/openvpn/ssl_verify_polarssl.h b/src/openvpn/ssl_verify_polarssl.h
index b259081..b5157ed 100644
--- a/src/openvpn/ssl_verify_polarssl.h
+++ b/src/openvpn/ssl_verify_polarssl.h
@@ -33,11 +33,11 @@
 #include "syshead.h"
 #include "misc.h"
 #include "manage.h"
-#include <polarssl/x509.h>
+#include <polarssl/x509_crt.h>
 
 #ifndef __OPENVPN_X509_CERT_T_DECLARED
 #define __OPENVPN_X509_CERT_T_DECLARED
-typedef x509_cert openvpn_x509_cert_t;
+typedef x509_crt openvpn_x509_cert_t;
 #endif
 
 /** @name Function for authenticating a new connection from a remote OpenVPN peer
@@ -72,7 +72,7 @@ typedef x509_cert openvpn_x509_cert_t;
  *
  * @return The return value is 0 unless a fatal error occurred.
  */
-int verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
+int verify_callback (void *session_obj, x509_crt *cert, int cert_depth,
     int *flags);
 
 /** @} name Function for authenticating a new connection from a remote OpenVPN peer */
-- 
2.5.0


