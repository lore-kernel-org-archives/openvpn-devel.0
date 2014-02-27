From: <steffan.karger@...1435...>
Date: Thu, 27 Feb 2014 20:40:06 +0100
Message-ID: <1393530007-6225-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1393530007-6225-1-git-send-email-steffan.karger@...1435...>
References: <1393530007-6225-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Upgrade to PolarSSL 1.3
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

This removes support for PolarSSL 1.2. The mimimum version of PolarSSL required
is now 1.3.3. The upgrade brings OpenVPN-with-PolarSSL:
* Support for EC-crypto in TLS (but not yet for external pkcs11/management keys)
* Support for AES-NI (if PolarSSL is compiled with AES-NI support)

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 configure.ac                      |   4 +-
 src/openvpn/crypto_polarssl.c     |   7 +-
 src/openvpn/pkcs11_polarssl.c     |  13 +--
 src/openvpn/ssl_polarssl.c        | 182 ++++++++++++++++++--------------------
 src/openvpn/ssl_polarssl.h        |   7 +-
 src/openvpn/ssl_verify.c          |   6 +-
 src/openvpn/ssl_verify_backend.h  |   4 +-
 src/openvpn/ssl_verify_openssl.c  |   4 +-
 src/openvpn/ssl_verify_polarssl.c | 109 +++++++----------------
 src/openvpn/ssl_verify_polarssl.h |   6 +-
 10 files changed, 147 insertions(+), 195 deletions(-)

diff --git a/configure.ac b/configure.ac
index 380dcdb..e3c7072 100644
--- a/configure.ac
+++ b/configure.ac
@@ -826,13 +826,13 @@ if test "${with_crypto_library}" = "polarssl" ; then
 #include <polarssl/version.h>
 			]],
 			[[
-#if POLARSSL_VERSION_NUMBER < 0x01020A00 || POLARSSL_VERSION_NUMBER >= 0x01030000
+#if POLARSSL_VERSION_NUMBER < 0x01030300 || POLARSSL_VERSION_NUMBER >= 0x01040000
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([PolarSSL 1.2.x required and must be 1.2.10 or later])]
+		[AC_MSG_ERROR([PolarSSL 1.3.x required and must be 1.3.3 or later])]
 	)
 
 	polarssl_with_pkcs11="no"
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 1f27d6c..7dc8aa5 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -466,7 +466,12 @@ int cipher_ctx_mode (const cipher_context_t *ctx)
 
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
diff --git a/src/openvpn/pkcs11_polarssl.c b/src/openvpn/pkcs11_polarssl.c
index 03b2bab..be4e973 100644
--- a/src/openvpn/pkcs11_polarssl.c
+++ b/src/openvpn/pkcs11_polarssl.c
@@ -40,6 +40,7 @@
 #include "errlevel.h"
 #include "pkcs11_backend.h"
 #include <polarssl/pkcs11.h>
+#include <polarssl/x509.h>
 
 int
 pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
@@ -78,14 +79,14 @@ pkcs11_certificate_dn (pkcs11h_certificate_t cert, struct gc_arena *gc)
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
@@ -93,7 +94,7 @@ pkcs11_certificate_dn (pkcs11h_certificate_t cert, struct gc_arena *gc)
   ret = string_alloc(dn, gc);
 
 cleanup:
-  x509_free(&polar_cert);
+  x509_crt_free(&polar_cert);
 
   return ret;
 }
@@ -104,14 +105,14 @@ pkcs11_certificate_serial (pkcs11h_certificate_t cert, char *serial,
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
@@ -119,7 +120,7 @@ pkcs11_certificate_serial (pkcs11h_certificate_t cert, char *serial,
   ret = 0;
 
 cleanup:
-  x509_free(&polar_cert);
+  x509_crt_free(&polar_cert);
 
   return ret;
 }
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 9dc4e87..3a0d8a0 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -45,12 +45,12 @@
 #include "manage.h"
 #include "ssl_common.h"
 
-#include <polarssl/sha2.h>
 #include <polarssl/havege.h>
 
 #include "ssl_verify_polarssl.h"
 #include <polarssl/error.h>
 #include <polarssl/pem.h>
+#include <polarssl/sha256.h>
 
 void
 tls_init_lib()
@@ -74,10 +74,10 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
   CLEAR(*ctx);
 
   ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
-  ALLOC_OBJ_CLEAR(ctx->priv_key, rsa_context);
+  ALLOC_OBJ_CLEAR(ctx->priv_key, pk_context);
 
-  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_cert);
-  ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_cert);
+  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_crt);
+  ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_crt);
 
 
   ctx->endpoint = SSL_IS_SERVER;
@@ -91,10 +91,10 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
   CLEAR(*ctx);
 
   ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
-  ALLOC_OBJ_CLEAR(ctx->priv_key, rsa_context);
+  ALLOC_OBJ_CLEAR(ctx->priv_key, pk_context);
 
-  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_cert);
-  ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_cert);
+  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_crt);
+  ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_crt);
 
   ctx->endpoint = SSL_IS_CLIENT;
   ctx->initialised = true;
@@ -105,13 +105,13 @@ tls_ctx_free(struct tls_root_ctx *ctx)
 {
   if (ctx)
     {
-      rsa_free(ctx->priv_key);
+      pk_free(ctx->priv_key);
       free(ctx->priv_key);
 
-      x509_free(ctx->ca_chain);
+      x509_crt_free(ctx->ca_chain);
       free(ctx->ca_chain);
 
-      x509_free(ctx->crt_chain);
+      x509_crt_free(ctx->crt_chain);
       free(ctx->crt_chain);
 
       dhm_free(ctx->dhm_ctx);
@@ -215,12 +215,12 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
 {
   if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_file_inline)
     {
-      if (0 != x509parse_dhm(ctx->dhm_ctx, dh_file_inline, strlen(dh_file_inline)))
+      if (0 != dhm_parse_dhm(ctx->dhm_ctx, dh_file_inline, strlen(dh_file_inline)))
 	msg (M_FATAL, "Cannot read inline DH parameters");
   }
 else
   {
-    if (0 != x509parse_dhmfile(ctx->dhm_ctx, dh_file))
+    if (0 != dhm_parse_dhmfile(ctx->dhm_ctx, dh_file))
       msg (M_FATAL, "Cannot read DH parameters from file %s", dh_file);
   }
 
@@ -255,13 +255,13 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
 
   if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_file_inline)
     {
-      if (0 != x509parse_crt(ctx->crt_chain, cert_file_inline,
+      if (0 != x509_crt_parse(ctx->crt_chain, cert_file_inline,
 	  strlen(cert_file_inline)))
         msg (M_FATAL, "Cannot load inline certificate file");
     }
   else
     {
-      if (0 != x509parse_crtfile(ctx->crt_chain, cert_file))
+      if (0 != x509_crt_parse_file(ctx->crt_chain, cert_file))
 	msg (M_FATAL, "Cannot load certificate file %s", cert_file);
     }
 }
@@ -276,26 +276,27 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
 
   if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_file_inline)
     {
-      status = x509parse_key(ctx->priv_key,
+      status = pk_parse_key(ctx->priv_key,
 	  priv_key_file_inline, strlen(priv_key_file_inline),
 	  NULL, 0);
+
       if (POLARSSL_ERR_PEM_PASSWORD_REQUIRED == status)
 	{
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
-	  status = x509parse_key(ctx->priv_key,
+	  status = pk_parse_key(ctx->priv_key,
 	      priv_key_file_inline, strlen(priv_key_file_inline),
 	      (unsigned char *) passbuf, strlen(passbuf));
 	}
     }
   else
     {
-      status = x509parse_keyfile(ctx->priv_key, priv_key_file, NULL);
+      status = pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);
       if (POLARSSL_ERR_PEM_PASSWORD_REQUIRED == status)
 	{
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
-	  status = x509parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
+	  status = pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
 	}
     }
   if (0 != status)
@@ -338,30 +339,29 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
 
   /* Most of the initialization happens in key_state_ssl_init() */
   ALLOC_OBJ_CLEAR (ctx->external_key, struct external_context);
-  ctx->external_key->signature_length = ctx->crt_chain->rsa.len;
+  ctx->external_key->signature_length = pk_get_len(&ctx->crt_chain->pk);
 
   return 1;
 }
 
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
@@ -369,65 +369,51 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
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
+  if ( (SIZE_MAX - hashlen) > asn_len || (hashlen + asn_len) > sig_len )
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
+
+      memcpy( p, hash, hashlen );
   }
 
   /* convert 'from' to base64 */
@@ -456,7 +442,7 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
 
   rv = 0;
 
- done:
+done:
   if (in_b64)
     free (in_b64);
   if (out_b64)
@@ -482,14 +468,14 @@ void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 
   if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_file_inline)
     {
-      if (0 != x509parse_crt(ctx->ca_chain, (unsigned char *) ca_file_inline,
-          strlen(ca_file_inline)))
+      if (0 != x509_crt_parse(ctx->ca_chain, (unsigned char *) ca_file_inline,
+	  strlen(ca_file_inline)))
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
@@ -503,14 +489,14 @@ tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
 
   if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_file_inline)
     {
-      if (0 != x509parse_crt(ctx->crt_chain,
+      if (0 != x509_crt_parse(ctx->crt_chain,
           (unsigned char *) extra_certs_file_inline,
-          strlen(extra_certs_file_inline)))
+	  strlen(extra_certs_file_inline)))
         msg (M_FATAL, "Cannot load inline extra-certs file");
     }
   else
     {
-      if (0 != x509parse_crtfile(ctx->crt_chain, extra_certs_file))
+      if (0 != x509_crt_parse_file(ctx->crt_chain, extra_certs_file))
 	msg (M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
     }
 }
@@ -633,9 +619,9 @@ void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 
   if (NULL != ctx->crt_chain)
     {
-      x509_cert *cert = ctx->crt_chain;
+      x509_crt *cert = ctx->crt_chain;
 
-      sha2(cert->tbs.p, cert->tbs.len, sha256_hash, false);
+      sha256(cert->tbs.p, cert->tbs.len, sha256_hash, false);
       if ( 0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
 	{
 	  ctr_drbg_update(cd_ctx, sha256_hash, 32);
@@ -1021,7 +1007,7 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
 void
 print_details (struct key_state_ssl * ks_ssl, const char *prefix)
 {
-  const x509_cert *cert;
+  const x509_crt *cert;
   char s1[256];
   char s2[256];
 
@@ -1034,7 +1020,7 @@ print_details (struct key_state_ssl * ks_ssl, const char *prefix)
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
index 4dd3aa2..1aaacc7 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -435,7 +435,7 @@ verify_cert_set_env(struct env_set *es, openvpn_x509_cert_t *peer_cert, int cert
   }
 
   /* export serial number as environmental variable */
-  serial = x509_get_serial(peer_cert, &gc);
+  serial = backend_x509_get_serial(peer_cert, &gc);
   openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", cert_depth);
   setenv_str (es, envname, serial);
 
@@ -562,7 +562,7 @@ verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert)
   int fd = -1;
   struct gc_arena gc = gc_new();
 
-  char *serial = x509_get_serial(cert, &gc);
+  char *serial = backend_x509_get_serial(cert, &gc);
 
   if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, OS_SPECIFIC_DIRSEP, serial))
     {
@@ -614,7 +614,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
   string_replace_leading (subject, '-', '_');
 
   /* extract the username (default is CN) */
-  if (SUCCESS != x509_get_username (common_name, TLS_USERNAME_LEN,
+  if (SUCCESS != backend_x509_get_username (common_name, TLS_USERNAME_LEN,
       opt->x509_username_field, cert))
     {
       if (!cert_depth)
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 1658cc0..1803299 100644
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
@@ -122,7 +122,7 @@ result_t x509_get_username (char *common_name, int cn_len,
  *
  * @return 		The certificate's serial number.
  */
-char *x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc);
+char *backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc);
 
 /*
  * Save X509 fields to environment, using the naming convention:
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 658f5f3..40aaf57 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -202,7 +202,7 @@ extract_x509_field_ssl (X509_NAME *x509, const char *field_name, char *out,
 }
 
 result_t
-x509_get_username (char *common_name, int cn_len,
+backend_x509_get_username (char *common_name, int cn_len,
     char * x509_username_field, X509 *peer_cert)
 {
 #ifdef ENABLE_X509ALTUSERNAME
@@ -220,7 +220,7 @@ x509_get_username (char *common_name, int cn_len,
 }
 
 char *
-x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
+backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
   ASN1_INTEGER *asn1_i;
   BIGNUM *bignum;
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index e5ccd90..1b2990c 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -38,12 +38,13 @@
 #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL)
 
 #include "ssl_verify.h"
+#include <polarssl/oid.h>
 #include <polarssl/sha1.h>
 
 #define MAX_SUBJECT_LENGTH 256
 
 int
-verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
+verify_callback (void *session_obj, x509_crt *cert, int cert_depth,
     int *flags)
 {
   struct tls_session *session = (struct tls_session *) session_obj;
@@ -88,8 +89,8 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
 #endif
 
 result_t
-x509_get_username (char *cn, int cn_len,
-    char *x509_username_field, x509_cert *cert)
+backend_x509_get_username (char *cn, int cn_len,
+    char *x509_username_field, x509_crt *cert)
 {
   x509_name *name;
 
@@ -100,7 +101,7 @@ x509_get_username (char *cn, int cn_len,
   /* Find common name */
   while( name != NULL )
   {
-      if( memcmp( name->oid.p, OID_CN, OID_SIZE(OID_CN) ) == 0)
+      if( memcmp( name->oid.p, OID_AT_CN, OID_SIZE(OID_AT_CN) ) == 0)
 	break;
 
       name = name->next;
@@ -123,21 +124,21 @@ x509_get_username (char *cn, int cn_len,
 }
 
 char *
-x509_get_serial (x509_cert *cert, struct gc_arena *gc)
+backend_x509_get_serial (x509_crt *cert, struct gc_arena *gc)
 {
   char *buf = NULL;
   size_t len = cert->serial.len * 3 + 1;
 
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
@@ -145,14 +146,14 @@ x509_get_sha1_hash (x509_cert *cert, struct gc_arena *gc)
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
@@ -182,70 +183,28 @@ x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert)
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
 
@@ -259,7 +218,7 @@ x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert)
 }
 
 result_t
-x509_verify_ns_cert_type(const x509_cert *cert, const int usage)
+x509_verify_ns_cert_type(const x509_crt *cert, const int usage)
 {
   if (usage == NS_CERT_CHECK_NONE)
     return SUCCESS;
@@ -274,7 +233,7 @@ x509_verify_ns_cert_type(const x509_cert *cert, const int usage)
 }
 
 result_t
-x509_verify_cert_ku (x509_cert *cert, const unsigned * const expected_ku,
+x509_verify_cert_ku (x509_crt *cert, const unsigned * const expected_ku,
     int expected_len)
 {
   result_t fFound = FAILURE;
@@ -307,7 +266,7 @@ x509_verify_cert_ku (x509_cert *cert, const unsigned * const expected_ku,
 }
 
 result_t
-x509_verify_cert_eku (x509_cert *cert, const char * const expected_oid)
+x509_verify_cert_eku (x509_crt *cert, const char * const expected_oid)
 {
   result_t fFound = FAILURE;
 
@@ -357,7 +316,7 @@ x509_verify_cert_eku (x509_cert *cert, const char * const expected_oid)
 }
 
 result_t
-x509_write_pem(FILE *peercert_file, x509_cert *peercert)
+x509_write_pem(FILE *peercert_file, x509_crt *peercert)
 {
     msg (M_WARN, "PolarSSL does not support writing peer certificate in PEM format");
     return FAILURE;
@@ -367,12 +326,12 @@ x509_write_pem(FILE *peercert_file, x509_cert *peercert)
  * check peer cert against CRL
  */
 result_t
-x509_verify_crl(const char *crl_file, x509_cert *cert, const char *subject)
+x509_verify_crl(const char *crl_file, x509_crt *cert, const char *subject)
 {
   result_t retval = FAILURE;
   x509_crl crl = {0};
 
-  if (x509parse_crlfile(&crl, crl_file) != 0)
+  if (x509_crl_parse_file(&crl, crl_file) != 0)
     {
       msg (M_ERR, "CRL: cannot read CRL from file %s", crl_file);
       goto end;
@@ -387,7 +346,7 @@ x509_verify_crl(const char *crl_file, x509_cert *cert, const char *subject)
       goto end;
     }
 
-  if (0 != x509parse_revoked(cert, &crl))
+  if (0 != x509_crt_revoked(cert, &crl))
     {
       msg (D_HANDSHAKE, "CRL CHECK FAILED: %s is REVOKED", subject);
       goto end;
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
1.8.3.2


