From: Steffan Karger <steffan@...1856...>
Date: Sat, 25 Oct 2014 22:35:23 +0200
Message-Id: <1414269324-14102-6-git-send-email-steffan@...1856...>
In-Reply-To: <1414269324-14102-1-git-send-email-steffan@...1856...>
References: <1414269324-14102-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 5/6] openssl: use crypto_msg(),
	get rid of openssl-specific code in error.c
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

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_openssl.c |  30 +++++++-----
 src/openvpn/error.c          |  29 ------------
 src/openvpn/error.h          |   5 --
 src/openvpn/ssl_openssl.c    | 107 +++++++++++++++++++++++--------------------
 4 files changed, 75 insertions(+), 96 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 25d8cf9..114a856 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -100,13 +100,14 @@ setup_engine (const char *engine)
       if ((e = ENGINE_by_id (engine)) == NULL
 	 && (e = try_load_engine (engine)) == NULL)
 	{
-	  msg (M_FATAL, "OpenSSL error: cannot load engine '%s'", engine);
+	  crypto_msg (M_FATAL, "OpenSSL error: cannot load engine '%s'",
+	      engine);
 	}
 
       if (!ENGINE_set_default (e, ENGINE_METHOD_ALL))
 	{
-	  msg (M_FATAL, "OpenSSL error: ENGINE_set_default failed on engine '%s'",
-	       engine);
+	  crypto_msg (M_FATAL, "OpenSSL error: ENGINE_set_default failed on "
+	      "engine '%s'", engine);
 	}
 
       msg (M_INFO, "Initializing OpenSSL support for engine '%s'",
@@ -395,17 +396,20 @@ key_des_check (uint8_t *key, int key_len, int ndc)
       DES_cblock *dc = (DES_cblock*) buf_read_alloc (&b, sizeof (DES_cblock));
       if (!dc)
 	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key material");
+	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key "
+	      "material");
 	  goto err;
 	}
       if (DES_is_weak_key(dc))
 	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key detected");
+	  crypto_msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key "
+	      "detected");
 	  goto err;
 	}
       if (!DES_check_key_parity (dc))
 	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: bad parity detected");
+	  crypto_msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: bad parity "
+	      "detected");
 	  goto err;
 	}
     }
@@ -454,7 +458,7 @@ cipher_kt_get (const char *ciphername)
   cipher = EVP_get_cipherbyname (ciphername);
 
   if (NULL == cipher)
-    msg (M_SSLERR, "Cipher algorithm '%s' not found", ciphername);
+    crypto_msg (M_FATAL, "Cipher algorithm '%s' not found", ciphername);
 
   if (EVP_CIPHER_key_length (cipher) > MAX_CIPHER_KEY_LENGTH)
     msg (M_FATAL, "Cipher algorithm '%s' uses a default key size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum key size (%d bytes)",
@@ -538,13 +542,13 @@ cipher_ctx_init (EVP_CIPHER_CTX *ctx, uint8_t *key, int key_len,
 
   EVP_CIPHER_CTX_init (ctx);
   if (!EVP_CipherInit (ctx, kt, NULL, NULL, enc))
-    msg (M_SSLERR, "EVP cipher init #1");
+    crypto_msg (M_FATAL, "EVP cipher init #1");
 #ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
   if (!EVP_CIPHER_CTX_set_key_length (ctx, key_len))
-    msg (M_SSLERR, "EVP set key size");
+    crypto_msg (M_FATAL, "EVP set key size");
 #endif
   if (!EVP_CipherInit (ctx, NULL, key, NULL, enc))
-    msg (M_SSLERR, "EVP cipher init #2");
+    crypto_msg (M_FATAL, "EVP cipher init #2");
 
   /* make sure we used a big enough key */
   ASSERT (EVP_CIPHER_CTX_key_length (ctx) <= key_len);
@@ -626,9 +630,11 @@ md_kt_get (const char *digest)
   ASSERT (digest);
   md = EVP_get_digestbyname (digest);
   if (!md)
-    msg (M_SSLERR, "Message hash algorithm '%s' not found", digest);
+    crypto_msg (M_FATAL, "Message hash algorithm '%s' not found", digest);
   if (EVP_MD_size (md) > MAX_HMAC_KEY_LENGTH)
-    msg (M_FATAL, "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum hash size (%d bytes)",
+    crypto_msg (M_FATAL, "Message hash algorithm '%s' uses a default hash size "
+	 "(%d bytes) which is larger than " PACKAGE_NAME "'s current maximum "
+	 "hash size (%d bytes)",
 	 digest,
 	 EVP_MD_size (md),
 	 MAX_HMAC_KEY_LENGTH);
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index fd9f19d..9d52962 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -43,13 +43,6 @@
 #include "ps.h"
 #include "mstats.h"
 
-#ifdef ENABLE_CRYPTO
-#ifdef ENABLE_CRYPTO_OPENSSL
-#include <openssl/err.h>
-#endif
-#endif
-
-#include "memdbg.h"
 
 #if SYSLOG_CAPABILITY
 #ifndef LOG_OPENVPN
@@ -265,28 +258,6 @@ void x_msg_va (const unsigned int flags, const char *format, va_list arglist)
       SWAP;
     }
 
-#ifdef ENABLE_CRYPTO
-#ifdef ENABLE_CRYPTO_OPENSSL
-  if (flags & M_SSL)
-    {
-      int nerrs = 0;
-      size_t err;
-      while ((err = ERR_get_error ()))
-	{
-	  openvpn_snprintf (m2, ERR_BUF_SIZE, "%s: %s",
-			    m1, ERR_error_string (err, NULL));
-	  SWAP;
-	  ++nerrs;
-	}
-      if (!nerrs)
-	{
-	  openvpn_snprintf (m2, ERR_BUF_SIZE, "%s (OpenSSL)", m1);
-	  SWAP;
-	}
-    }
-#endif
-#endif
-
   if (flags & M_OPTERR)
     {
       openvpn_snprintf (m2, ERR_BUF_SIZE, "Options error: %s", m1);
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index a977f51..d5204f3 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -93,10 +93,6 @@ extern int x_msg_line_num;
 
 #define M_ERRNO           (1<<8)	 /* show errno description */
 
-#ifdef ENABLE_CRYPTO_OPENSSL
-#  define M_SSL             (1<<10)	 /* show SSL error */
-#endif
-
 #define M_NOMUTE          (1<<11)        /* don't do mute processing */
 #define M_NOPREFIX        (1<<12)        /* don't show date/time prefix */
 #define M_USAGE_SMALL     (1<<13)        /* fatal options error, call usage_small */
@@ -107,7 +103,6 @@ extern int x_msg_line_num;
 
 /* flag combinations which are frequently used */
 #define M_ERR     (M_FATAL | M_ERRNO)
-#define M_SSLERR  (M_FATAL | M_SSL)
 #define M_USAGE   (M_USAGE_SMALL | M_NOPREFIX | M_OPTERR)
 #define M_CLIENT  (M_MSG_VIRT_OUT | M_NOMUTE | M_NOIPREFIX)
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index adf3ae6..57e9800 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -104,7 +104,7 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
   ctx->ctx = SSL_CTX_new (SSLv23_server_method ());
 
   if (ctx->ctx == NULL)
-    msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
+    crypto_msg (M_FATAL, "SSL_CTX_new SSLv23_server_method");
 }
 
 void
@@ -115,7 +115,7 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
   ctx->ctx = SSL_CTX_new (SSLv23_client_method ());
 
   if (ctx->ctx == NULL)
-    msg (M_SSLERR, "SSL_CTX_new SSLv23_client_method");
+    crypto_msg (M_FATAL, "SSL_CTX_new SSLv23_client_method");
 }
 
 void
@@ -152,7 +152,7 @@ info_callback (INFO_CALLBACK_SSL_CONST SSL * s, int where, int ret)
     }
   else if (where & SSL_CB_ALERT)
     {
-      dmsg (D_HANDSHAKE_VERBOSE, "SSL alert (%s): %s: %s",
+      dmsg(D_HANDSHAKE_VERBOSE, "SSL alert (%s): %s: %s",
 	   where & SSL_CB_READ ? "read" : "write",
 	   SSL_alert_type_string_long (ret),
 	   SSL_alert_desc_string_long (ret));
@@ -227,7 +227,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
     {
       /* Use sane default (disable export, and unsupported cipher modes) */
       if(!SSL_CTX_set_cipher_list(ctx->ctx, "DEFAULT:!EXP:!PSK:!SRP"))
-        msg(M_SSLERR, "Failed to set default TLS cipher list.");
+	crypto_msg (M_FATAL, "Failed to set default TLS cipher list.");
       return;
     }
 
@@ -280,7 +280,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
       // Make sure new cipher name fits in cipher string
       if (((sizeof(openssl_ciphers)-1) - openssl_ciphers_len) < current_cipher_len) {
-	msg(M_SSLERR, "Failed to set restricted TLS cipher list, too long (>%d).", (int)sizeof(openssl_ciphers)-1);
+	  crypto_msg (M_FATAL, "Failed to set restricted TLS cipher list, too "
+	      "long (>%d).", (int)sizeof(openssl_ciphers)-1);
       }
 
       // Concatenate cipher name to OpenSSL cipher string
@@ -297,7 +298,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
   // Set OpenSSL cipher list
   if(!SSL_CTX_set_cipher_list(ctx->ctx, openssl_ciphers))
-    msg(M_SSLERR, "Failed to set restricted TLS cipher list: %s", openssl_ciphers);
+    crypto_msg (M_FATAL, "Failed to set restricted TLS cipher list: %s",
+	openssl_ciphers);
 }
 
 void
@@ -313,22 +315,22 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
   if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_file_inline)
     {
       if (!(bio = BIO_new_mem_buf ((char *)dh_file_inline, -1)))
-	msg (M_SSLERR, "Cannot open memory BIO for inline DH parameters");
+	crypto_msg (M_FATAL, "Cannot open memory BIO for inline DH parameters");
     }
   else
     {
       /* Get Diffie Hellman Parameters */
       if (!(bio = BIO_new_file (dh_file, "r")))
-	msg (M_SSLERR, "Cannot open %s for DH parameters", dh_file);
+	crypto_msg (M_FATAL, "Cannot open %s for DH parameters", dh_file);
     }
 
   dh = PEM_read_bio_DHparams (bio, NULL, NULL, NULL);
   BIO_free (bio);
 
   if (!dh)
-    msg (M_SSLERR, "Cannot load DH parameters from %s", dh_file);
+    crypto_msg (M_FATAL, "Cannot load DH parameters from %s", dh_file);
   if (!SSL_CTX_set_tmp_dh (ctx->ctx, dh))
-    msg (M_SSLERR, "SSL_CTX_set_tmp_dh");
+    crypto_msg (M_FATAL, "SSL_CTX_set_tmp_dh");
 
   msg (D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with %d bit key",
        8 * DH_size (dh));
@@ -397,7 +399,7 @@ tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char *curve_name
     }
 
   if (!SSL_CTX_set_tmp_ecdh(ctx->ctx, ecdh))
-    msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh: cannot add curve");
+    crypto_msg (M_FATAL, "SSL_CTX_set_tmp_ecdh: cannot add curve");
 
   msg (D_TLS_DEBUG_LOW, "ECDH curve %s added", sname);
 
@@ -433,7 +435,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
       BIO_push(b64, bio);
       p12 = d2i_PKCS12_bio(b64, NULL);
       if (!p12)
-	msg(M_SSLERR, "Error reading inline PKCS#12 file");
+	crypto_msg (M_FATAL, "Error reading inline PKCS#12 file");
       BIO_free(b64);
       BIO_free(bio);
     }
@@ -441,11 +443,11 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
     {
       /* Load the PKCS #12 file */
       if (!(fp = platform_fopen(pkcs12_file, "rb")))
-	msg(M_SSLERR, "Error opening file %s", pkcs12_file);
+	crypto_msg (M_FATAL, "Error opening file %s", pkcs12_file);
       p12 = d2i_PKCS12_fp(fp, NULL);
       fclose(fp);
       if (!p12)
-	msg(M_SSLERR, "Error reading PKCS#12 file %s", pkcs12_file);
+	crypto_msg (M_FATAL, "Error reading PKCS#12 file %s", pkcs12_file);
     }
 
   /* Parse the PKCS #12 file */
@@ -468,16 +470,16 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 
   /* Load Certificate */
   if (!SSL_CTX_use_certificate (ctx->ctx, cert))
-   msg (M_SSLERR, "Cannot use certificate");
+    crypto_msg (M_FATAL, "Cannot use certificate");
 
   /* Load Private Key */
   if (!SSL_CTX_use_PrivateKey (ctx->ctx, pkey))
-   msg (M_SSLERR, "Cannot use private key");
+    crypto_msg (M_FATAL, "Cannot use private key");
   warn_if_group_others_accessible (pkcs12_file);
 
   /* Check Private Key */
   if (!SSL_CTX_check_private_key (ctx->ctx))
-   msg (M_SSLERR, "Private key does not match the certificate");
+    crypto_msg (M_FATAL, "Private key does not match the certificate");
 
   /* Set Certificate Verification chain */
   if (load_ca_file)
@@ -491,9 +493,11 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 	for (i = 0; i < sk_X509_num(ca); i++)
 	  {
 	    if (!X509_STORE_add_cert(ctx->ctx->cert_store,sk_X509_value(ca, i)))
-	      msg (M_SSLERR, "Cannot add certificate to certificate chain (X509_STORE_add_cert)");
+	      crypto_msg (M_FATAL, "Cannot add certificate to certificate chain"
+		  " (X509_STORE_add_cert)");
 	    if (!SSL_CTX_add_client_CA(ctx->ctx, sk_X509_value(ca, i)))
-	      msg (M_SSLERR, "Cannot add certificate to client CA list (SSL_CTX_add_client_CA)");
+	      crypto_msg (M_FATAL, "Cannot add certificate to client CA list "
+		  "(SSL_CTX_add_client_CA)");
 	  }
       }
    } else {
@@ -507,7 +511,8 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 	for (i = 0; i < sk_X509_num(ca); i++)
 	  {
 	    if (!SSL_CTX_add_extra_chain_cert(ctx->ctx,sk_X509_value(ca, i)))
-	      msg (M_SSLERR, "Cannot add extra certificate to chain (SSL_CTX_add_extra_chain_cert)");
+	      crypto_msg (M_FATAL, "Cannot add extra certificate to chain "
+		  "(SSL_CTX_add_extra_chain_cert)");
 	  }
       }
    }
@@ -522,8 +527,8 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 
   /* Load Certificate and Private Key */
   if (!SSL_CTX_use_CryptoAPI_certificate (ctx->ctx, cryptoapi_cert))
-    msg (M_SSLERR, "Cannot load certificate \"%s\" from Microsoft Certificate Store",
-	   cryptoapi_cert);
+    crypto_msg (M_SSLERR, "Cannot load certificate \"%s\" from Microsoft "
+	"Certificate Store", cryptoapi_cert);
 }
 #endif /* WIN32 */
 
@@ -537,9 +542,9 @@ tls_ctx_add_extra_certs (struct tls_root_ctx *ctx, BIO *bio)
       if (!PEM_read_bio_X509 (bio, &cert, 0, NULL)) /* takes ownership of cert */
         break;
       if (!cert)
-        msg (M_SSLERR, "Error reading extra certificate");
+	crypto_msg (M_FATAL, "Error reading extra certificate");
       if (SSL_CTX_add_extra_chain_cert(ctx->ctx, cert) != 1)
-        msg (M_SSLERR, "Error adding extra certificate");
+	crypto_msg (M_FATAL, "Error adding extra certificate");
     }
 }
 
@@ -587,9 +592,9 @@ end:
   if (!ret)
     {
       if (inline_file)
-        msg (M_SSLERR, "Cannot load inline certificate file");
+	crypto_msg (M_FATAL, "Cannot load inline certificate file");
       else
-        msg (M_SSLERR, "Cannot load certificate file %s", cert_file);
+	crypto_msg (M_FATAL, "Cannot load certificate file %s", cert_file);
     }
 
   if (in != NULL)
@@ -647,14 +652,14 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
       if (management && (ERR_GET_REASON (ERR_peek_error()) == EVP_R_BAD_DECRYPT))
           management_auth_failure (management, UP_TYPE_PRIVATE_KEY, NULL);
 #endif
-      msg (M_WARN|M_SSL, "Cannot load private key file %s", priv_key_file);
+      crypto_msg (M_WARN, "Cannot load private key file %s", priv_key_file);
       goto end;
     }
   warn_if_group_others_accessible (priv_key_file);
 
   /* Check Private Key */
   if (!SSL_CTX_check_private_key (ssl_ctx))
-    msg (M_SSLERR, "Private key does not match the certificate");
+    crypto_msg (M_FATAL, "Private key does not match the certificate");
   ret = 0;
 
 end:
@@ -805,7 +810,7 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
       if (rsa_meth)
 	free(rsa_meth);
     }
-  msg (M_SSLERR, "Cannot enable SSL external private key capability");
+  crypto_msg (M_FATAL, "Cannot enable SSL external private key capability");
   return 0;
 }
 
@@ -835,7 +840,8 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 
   store = SSL_CTX_get_cert_store(ctx->ctx);
   if (!store)
-    msg(M_SSLERR, "Cannot get certificate store (SSL_CTX_get_cert_store)");
+    crypto_msg (M_FATAL, "Cannot get certificate store "
+	"(SSL_CTX_get_cert_store)");
 
   /* Try to add certificates and CRLs from ca_file */
   if (ca_file)
@@ -858,7 +864,7 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 
               if (tls_server && !info->x509)
                 {
-                  msg (M_SSLERR, "X509 name was missing in TLS mode");
+                  crypto_msg (M_FATAL, "X509 name was missing in TLS mode");
                 }
 
               if (info->x509)
@@ -894,7 +900,8 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
               if (tls_server) {
                 int cnum = sk_X509_NAME_num (cert_names);
                 if (cnum != (prev + 1)) {
-                  msg (M_WARN, "Cannot load CA certificate file %s (entry %d did not validate)", np(ca_file), added);
+                  crypto_msg (M_WARN, "Cannot load CA certificate file %s "
+                      "(entry %d did not validate)", np(ca_file), added);
                 }
                 prev = cnum;
               }
@@ -907,12 +914,14 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
         SSL_CTX_set_client_CA_list (ctx->ctx, cert_names);
 
       if (!added)
-        msg (M_SSLERR, "Cannot load CA certificate file %s (no entries were read)", np(ca_file));
+	crypto_msg (M_FATAL, "Cannot load CA certificate file %s "
+	    "(no entries were read)", np(ca_file));
 
       if (tls_server) {
         int cnum = sk_X509_NAME_num (cert_names);
         if (cnum != added)
-          msg (M_SSLERR, "Cannot load CA certificate file %s (only %d of %d entries were valid X509 names)", np(ca_file), cnum, added);
+          crypto_msg (M_FATAL, "Cannot load CA certificate file %s (only %d of "
+              "%d entries were valid X509 names)", np(ca_file), cnum, added);
       }
 
       if (in)
@@ -926,7 +935,7 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
       if (lookup && X509_LOOKUP_add_dir (lookup, ca_path, X509_FILETYPE_PEM))
         msg(M_WARN, "WARNING: experimental option --capath %s", ca_path);
       else
-        msg(M_SSLERR, "Cannot add lookup at --capath %s", ca_path);
+	crypto_msg (M_FATAL, "Cannot add lookup at --capath %s", ca_path);
       X509_STORE_set_flags (store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHECK_ALL);
     }
 }
@@ -943,7 +952,7 @@ tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
     in = BIO_new_file (extra_certs_file, "r");
 
   if (in == NULL)
-    msg (M_SSLERR, "Cannot load extra-certs file: %s", extra_certs_file);
+    crypto_msg (M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
   else
     tls_ctx_add_extra_certs (ctx, in);
 
@@ -1035,7 +1044,7 @@ getbio (BIO_METHOD * type, const char *desc)
   BIO *ret;
   ret = BIO_new (type);
   if (!ret)
-    msg (M_SSLERR, "Error creating %s BIO", desc);
+    crypto_msg (M_FATAL, "Error creating %s BIO", desc);
   return ret;
 }
 
@@ -1069,16 +1078,15 @@ bio_write (BIO *bio, const uint8_t *data, int size, const char *desc)
 	    }
 	  else
 	    {
-	      msg (D_TLS_ERRORS | M_SSL, "TLS ERROR: BIO write %s error",
-		   desc);
+	      crypto_msg (D_TLS_ERRORS, "TLS ERROR: BIO write %s error", desc);
 	      ret = -1;
 	      ERR_clear_error ();
 	    }
 	}
       else if (i != size)
 	{
-	  msg (D_TLS_ERRORS | M_SSL,
-	       "TLS ERROR: BIO write %s incomplete %d/%d", desc, i, size);
+	  crypto_msg (D_TLS_ERRORS, "TLS ERROR: BIO write %s incomplete %d/%d",
+	      desc, i, size);
 	  ret = -1;
 	  ERR_clear_error ();
 	}
@@ -1144,8 +1152,7 @@ bio_read (BIO *bio, struct buffer *buf, int maxlen, const char *desc)
 	    }
 	  else
 	    {
-	      msg (D_TLS_ERRORS | M_SSL, "TLS_ERROR: BIO read %s error",
-		   desc);
+	      crypto_msg (D_TLS_ERRORS, "TLS_ERROR: BIO read %s error", desc);
 	      buf->len = 0;
 	      ret = -1;
 	      ERR_clear_error ();
@@ -1175,7 +1182,7 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl, const struct tls_root_ctx *ssl_
 
   ks_ssl->ssl = SSL_new (ssl_ctx->ctx);
   if (!ks_ssl->ssl)
-    msg (M_SSLERR, "SSL_new failed");
+    crypto_msg (M_FATAL, "SSL_new failed");
 
   /* put session * in ssl object so we can access it
      from verify callback*/
@@ -1350,11 +1357,11 @@ show_available_tls_ciphers (const char *cipher_list)
 
   tls_ctx.ctx = SSL_CTX_new (SSLv23_method ());
   if (!tls_ctx.ctx)
-    msg (M_SSLERR, "Cannot create SSL_CTX object");
+    crypto_msg (M_FATAL, "Cannot create SSL_CTX object");
 
   ssl = SSL_new (tls_ctx.ctx);
   if (!ssl)
-    msg (M_SSLERR, "Cannot create SSL object");
+    crypto_msg (M_FATAL, "Cannot create SSL object");
 
   tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
 
@@ -1395,7 +1402,7 @@ show_available_curves()
   curves = OPENSSL_malloc((int)(sizeof(EC_builtin_curve) * crv_len));
 
   if (curves == NULL)
-    msg (M_SSLERR, "Cannot create EC_builtin_curve object");
+    crypto_msg (M_FATAL, "Cannot create EC_builtin_curve object");
   else
   {
     if (EC_get_builtin_curves(curves, crv_len))
@@ -1412,7 +1419,7 @@ show_available_curves()
     }
     else
     {
-      msg (M_SSLERR, "Cannot get list of builtin curves");
+      crypto_msg (M_FATAL, "Cannot get list of builtin curves");
     }
     OPENSSL_free(curves);
   }
@@ -1431,10 +1438,10 @@ get_highest_preference_tls_cipher (char *buf, int size)
 
   ctx = SSL_CTX_new (SSLv23_method ());
   if (!ctx)
-    msg (M_SSLERR, "Cannot create SSL_CTX object");
+    crypto_msg (M_FATAL, "Cannot create SSL_CTX object");
   ssl = SSL_new (ctx);
   if (!ssl)
-    msg (M_SSLERR, "Cannot create SSL object");
+    crypto_msg (M_FATAL, "Cannot create SSL object");
 
   cipher_name = SSL_get_cipher_list (ssl, 0);
   strncpynt (buf, cipher_name, size);
-- 
1.9.1


