From: Steffan Karger <steffan@...1856...>
Date: Wed,  6 Jan 2016 21:51:04 +0100
Message-Id: <1452113464-28062-2-git-send-email-steffan@...1856...>
In-Reply-To: <1452113464-28062-1-git-send-email-steffan@...1856...>
References: <1452113464-28062-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] openssl: improve logging
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

This improves OpenSSL logging and removes OpenSSL-specific error
printing code from error.c. The crypto_msg() functions provide
convenience wrappers, specific to OpenSSL. Instead of passing the
magical 'M_SSLERR' flag to msg(), a developer now just calls
crypto_msg() to get OpenSSL errors dumped to log.

This is commit is a combined cherry-pick of commits e795d6ba and
98ea2ec5 from the master branch, adjusted to the release/2.3 branch.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_openssl.c |  51 +++++++++++++-------
 src/openvpn/crypto_openssl.h |  25 ++++++++++
 src/openvpn/error.c          |  29 -----------
 src/openvpn/error.h          |  11 +++--
 src/openvpn/ssl_openssl.c    | 111 ++++++++++++++++++++++++-------------------
 5 files changed, 126 insertions(+), 101 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 4e195ce..c147245 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -135,13 +135,15 @@ setup_engine (const char *engine)
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
+	  crypto_msg (M_FATAL,
+	      "OpenSSL error: ENGINE_set_default failed on engine '%s'",
+	      engine);
 	}
 
       msg (M_INFO, "Initializing OpenSSL support for engine '%s'",
@@ -230,6 +232,14 @@ crypto_clear_error (void)
   ERR_clear_error ();
 }
 
+void
+crypto_print_openssl_errors(const unsigned int flags) {
+  size_t err = 0;
+
+  while ((err = ERR_get_error ()))
+    msg (flags, "OpenSSL: %s", ERR_error_string (err, NULL));
+}
+
 /*
  *
  * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
@@ -380,7 +390,7 @@ int rand_bytes(uint8_t *output, int len)
 {
   if (unlikely(1 != RAND_bytes (output, len)))
     {
-      msg(D_CRYPT_ERRORS, "RAND_bytes() failed");
+      crypto_msg(D_CRYPT_ERRORS, "RAND_bytes() failed");
       return 0;
     }
   return 1;
@@ -426,17 +436,20 @@ key_des_check (uint8_t *key, int key_len, int ndc)
       DES_cblock *dc = (DES_cblock*) buf_read_alloc (&b, sizeof (DES_cblock));
       if (!dc)
 	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key material");
+	  crypto_msg (D_CRYPT_ERRORS,
+	      "CRYPTO INFO: check_key_DES: insufficient key material");
 	  goto err;
 	}
       if (DES_is_weak_key(dc))
 	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key detected");
+	  crypto_msg (D_CRYPT_ERRORS,
+	      "CRYPTO INFO: check_key_DES: weak key detected");
 	  goto err;
 	}
       if (!DES_check_key_parity (dc))
 	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: bad parity detected");
+	  crypto_msg (D_CRYPT_ERRORS,
+	      "CRYPTO INFO: check_key_DES: bad parity detected");
 	  goto err;
 	}
     }
@@ -485,7 +498,7 @@ cipher_kt_get (const char *ciphername)
   cipher = EVP_get_cipherbyname (ciphername);
 
   if (NULL == cipher)
-    msg (M_SSLERR, "Cipher algorithm '%s' not found", ciphername);
+    crypto_msg (M_FATAL, "Cipher algorithm '%s' not found", ciphername);
 
   if (EVP_CIPHER_key_length (cipher) > MAX_CIPHER_KEY_LENGTH)
     msg (M_FATAL, "Cipher algorithm '%s' uses a default key size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum key size (%d bytes)",
@@ -569,13 +582,13 @@ cipher_ctx_init (EVP_CIPHER_CTX *ctx, uint8_t *key, int key_len,
 
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
@@ -622,7 +635,9 @@ int
 cipher_ctx_update (EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len,
     uint8_t *src, int src_len)
 {
-  return EVP_CipherUpdate (ctx, dst, dst_len, src, src_len);
+  if (!EVP_CipherUpdate (ctx, dst, dst_len, src, src_len))
+    crypto_msg(M_FATAL, "%s: EVP_CipherUpdate() failed", __func__);
+  return 1;
 }
 
 int
@@ -657,12 +672,14 @@ md_kt_get (const char *digest)
   ASSERT (digest);
   md = EVP_get_digestbyname (digest);
   if (!md)
-    msg (M_SSLERR, "Message hash algorithm '%s' not found", digest);
+    crypto_msg (M_FATAL, "Message hash algorithm '%s' not found", digest);
   if (EVP_MD_size (md) > MAX_HMAC_KEY_LENGTH)
-    msg (M_FATAL, "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum hash size (%d bytes)",
-	 digest,
-	 EVP_MD_size (md),
-	 MAX_HMAC_KEY_LENGTH);
+    {
+      crypto_msg (M_FATAL, "Message hash algorithm '%s' uses a default hash "
+	  "size (%d bytes) which is larger than " PACKAGE_NAME "'s current "
+	  "maximum hash size (%d bytes)",
+	  digest, EVP_MD_size (md), MAX_HMAC_KEY_LENGTH);
+    }
   return md;
 }
 
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index f883c2a..42c7e9a 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -70,4 +70,29 @@ typedef HMAC_CTX hmac_ctx_t;
 #define DES_KEY_LENGTH 8
 #define MD4_DIGEST_LENGTH 	16
 
+/**
+ * Retrieve any occurred OpenSSL errors and print those errors.
+ *
+ * Note that this function uses the not thread-safe OpenSSL error API.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ */
+void crypto_print_openssl_errors(const unsigned int flags);
+
+/**
+ * Retrieve any OpenSSL errors, then print the supplied error message.
+ *
+ * This is just a convenience wrapper for often occurring situations.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ * @param format	Format string to print.
+ * @param format args	(optional) arguments for the format string.
+ */
+# define crypto_msg(flags, ...) \
+do { \
+  crypto_print_openssl_errors(nonfatal(flags)); \
+  msg((flags), __VA_ARGS__); \
+} while (false)
+
+
 #endif /* CRYPTO_OPENSSL_H_ */
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index f503cf4..b47a9e5 100644
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
@@ -254,28 +247,6 @@ void x_msg_va (const unsigned int flags, const char *format, va_list arglist)
       SWAP;
     }
 
-#ifdef ENABLE_CRYPTO
-#ifdef ENABLE_CRYPTO_OPENSSL
-  if (flags & M_SSL)
-    {
-      int nerrs = 0;
-      int err;
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
index 42308e8..52ef0bd 100644
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
 
@@ -360,6 +355,12 @@ ignore_sys_error (const int err)
   return false;
 }
 
+/** Convert fatal errors to nonfatal, don't touch other errors */
+static inline unsigned int
+nonfatal(const unsigned int err) {
+  return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
+}
+
 #include "errlevel.h"
 
 #endif
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index e595e1b..36c8efe 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -111,7 +111,7 @@ tmp_rsa_cb (SSL * s, int is_export, int keylength)
 
       if(!bn || !BN_set_word(bn, RSA_F4) ||
 	  !RSA_generate_key_ex(rsa_tmp, keylength, bn, NULL))
-	msg(M_SSLERR, "Failed to generate temp RSA key");
+	crypto_msg(M_FATAL, "Failed to generate temp RSA key");
 
       if (bn) BN_free( bn );
     }
@@ -132,7 +132,7 @@ tls_ctx_server_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
     ctx->ctx = SSL_CTX_new (SSLv23_server_method ());
 
   if (ctx->ctx == NULL)
-    msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
+    crypto_msg (M_FATAL, "SSL_CTX_new SSLv23_server_method");
 
   SSL_CTX_set_tmp_rsa_callback (ctx->ctx, tmp_rsa_cb);
 }
@@ -151,7 +151,7 @@ tls_ctx_client_new(struct tls_root_ctx *ctx, unsigned int ssl_flags)
     ctx->ctx = SSL_CTX_new (SSLv23_client_method ());
 
   if (ctx->ctx == NULL)
-    msg (M_SSLERR, "SSL_CTX_new SSLv23_client_method");
+    crypto_msg (M_FATAL, "SSL_CTX_new SSLv23_client_method");
 }
 
 void
@@ -313,9 +313,12 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 	}
 
       // Make sure new cipher name fits in cipher string
-      if (((sizeof(openssl_ciphers)-1) - openssl_ciphers_len) < current_cipher_len) {
-	msg(M_SSLERR, "Failed to set restricted TLS cipher list, too long (>%d).", (int)sizeof(openssl_ciphers)-1);
-      }
+      if (((sizeof(openssl_ciphers)-1) - openssl_ciphers_len) < current_cipher_len)
+	{
+	  msg (M_FATAL,
+	      "Failed to set restricted TLS cipher list, too long (>%d).",
+	      (int)sizeof(openssl_ciphers)-1);
+	}
 
       // Concatenate cipher name to OpenSSL cipher string
       memcpy(&openssl_ciphers[openssl_ciphers_len], current_cipher, current_cipher_len);
@@ -331,7 +334,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
   // Set OpenSSL cipher list
   if(!SSL_CTX_set_cipher_list(ctx->ctx, openssl_ciphers))
-    msg(M_SSLERR, "Failed to set restricted TLS cipher list: %s", openssl_ciphers);
+    crypto_msg (M_FATAL, "Failed to set restricted TLS cipher list: %s", openssl_ciphers);
 }
 
 void
@@ -396,22 +399,22 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
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
@@ -444,7 +447,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
       BIO_push(b64, bio);
       p12 = d2i_PKCS12_bio(b64, NULL);
       if (!p12)
-	msg(M_SSLERR, "Error reading inline PKCS#12 file");
+	crypto_msg (M_FATAL, "Error reading inline PKCS#12 file");
       BIO_free(b64);
       BIO_free(bio);
     }
@@ -452,11 +455,11 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
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
@@ -479,16 +482,16 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 
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
@@ -502,9 +505,9 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 	for (i = 0; i < sk_X509_num(ca); i++)
 	  {
 	    if (!X509_STORE_add_cert(ctx->ctx->cert_store,sk_X509_value(ca, i)))
-	      msg (M_SSLERR, "Cannot add certificate to certificate chain (X509_STORE_add_cert)");
+	      crypto_msg (M_FATAL,"Cannot add certificate to certificate chain (X509_STORE_add_cert)");
 	    if (!SSL_CTX_add_client_CA(ctx->ctx, sk_X509_value(ca, i)))
-	      msg (M_SSLERR, "Cannot add certificate to client CA list (SSL_CTX_add_client_CA)");
+	      crypto_msg (M_FATAL,"Cannot add certificate to client CA list (SSL_CTX_add_client_CA)");
 	  }
       }
    } else {
@@ -518,7 +521,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 	for (i = 0; i < sk_X509_num(ca); i++)
 	  {
 	    if (!SSL_CTX_add_extra_chain_cert(ctx->ctx,sk_X509_value(ca, i)))
-	      msg (M_SSLERR, "Cannot add extra certificate to chain (SSL_CTX_add_extra_chain_cert)");
+	      crypto_msg (M_FATAL, "Cannot add extra certificate to chain (SSL_CTX_add_extra_chain_cert)");
 	  }
       }
    }
@@ -533,8 +536,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 
   /* Load Certificate and Private Key */
   if (!SSL_CTX_use_CryptoAPI_certificate (ctx->ctx, cryptoapi_cert))
-    msg (M_SSLERR, "Cannot load certificate \"%s\" from Microsoft Certificate Store",
-	   cryptoapi_cert);
+    crypto_msg (M_FATAL, "Cannot load certificate \"%s\" from Microsoft Certificate Store", cryptoapi_cert);
 }
 #endif /* WIN32 */
 
@@ -548,9 +550,9 @@ tls_ctx_add_extra_certs (struct tls_root_ctx *ctx, BIO *bio)
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
 
@@ -598,9 +600,9 @@ end:
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
@@ -659,14 +661,14 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
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
@@ -816,7 +818,7 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
       if (rsa_meth)
 	free(rsa_meth);
     }
-  msg (M_SSLERR, "Cannot enable SSL external private key capability");
+  crypto_msg (M_FATAL, "Cannot enable SSL external private key capability");
   return 0;
 }
 
@@ -846,7 +848,7 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 
   store = SSL_CTX_get_cert_store(ctx->ctx);
   if (!store)
-    msg(M_SSLERR, "Cannot get certificate store (SSL_CTX_get_cert_store)");
+    crypto_msg (M_FATAL, "Cannot get certificate store");
 
   /* Try to add certificates and CRLs from ca_file */
   if (ca_file)
@@ -869,7 +871,7 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 
               if (tls_server && !info->x509)
                 {
-                  msg (M_SSLERR, "X509 name was missing in TLS mode");
+                  crypto_msg (M_FATAL, "X509 name was missing in TLS mode");
                 }
 
               if (info->x509)
@@ -904,9 +906,12 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
 
               if (tls_server) {
                 int cnum = sk_X509_NAME_num (cert_names);
-                if (cnum != (prev + 1)) {
-                  msg (M_WARN, "Cannot load CA certificate file %s (entry %d did not validate)", np(ca_file), added);
-                }
+                if (cnum != (prev + 1))
+                  {
+		    crypto_msg (M_WARN,
+			"Cannot load CA certificate file %s (entry %d did not validate)",
+			np(ca_file), added);
+                  }
                 prev = cnum;
               }
 
@@ -918,12 +923,20 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
         SSL_CTX_set_client_CA_list (ctx->ctx, cert_names);
 
       if (!added)
-        msg (M_SSLERR, "Cannot load CA certificate file %s (no entries were read)", np(ca_file));
+	{
+	  crypto_msg (M_FATAL,
+	      "Cannot load CA certificate file %s (no entries were read)",
+	      np(ca_file));
+	}
 
       if (tls_server) {
         int cnum = sk_X509_NAME_num (cert_names);
         if (cnum != added)
-          msg (M_SSLERR, "Cannot load CA certificate file %s (only %d of %d entries were valid X509 names)", np(ca_file), cnum, added);
+          {
+            crypto_msg (M_FATAL, "Cannot load CA certificate file %s (only %d "
+		"of %d entries were valid X509 names)",
+		np(ca_file), cnum, added);
+          }
       }
 
       if (in)
@@ -937,7 +950,7 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
       if (lookup && X509_LOOKUP_add_dir (lookup, ca_path, X509_FILETYPE_PEM))
         msg(M_WARN, "WARNING: experimental option --capath %s", ca_path);
       else
-        msg(M_SSLERR, "Cannot add lookup at --capath %s", ca_path);
+	crypto_msg (M_FATAL, "Cannot add lookup at --capath %s", ca_path);
 #if OPENSSL_VERSION_NUMBER >= 0x00907000L
       X509_STORE_set_flags (store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHECK_ALL);
 #else
@@ -958,7 +971,7 @@ tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
     in = BIO_new_file (extra_certs_file, "r");
 
   if (in == NULL)
-    msg (M_SSLERR, "Cannot load extra-certs file: %s", extra_certs_file);
+    crypto_msg (M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
   else
     tls_ctx_add_extra_certs (ctx, in);
 
@@ -1050,7 +1063,7 @@ getbio (BIO_METHOD * type, const char *desc)
   BIO *ret;
   ret = BIO_new (type);
   if (!ret)
-    msg (M_SSLERR, "Error creating %s BIO", desc);
+    crypto_msg (M_FATAL, "Error creating %s BIO", desc);
   return ret;
 }
 
@@ -1084,16 +1097,15 @@ bio_write (BIO *bio, const uint8_t *data, int size, const char *desc)
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
@@ -1159,8 +1171,7 @@ bio_read (BIO *bio, struct buffer *buf, int maxlen, const char *desc)
 	    }
 	  else
 	    {
-	      msg (D_TLS_ERRORS | M_SSL, "TLS_ERROR: BIO read %s error",
-		   desc);
+	      crypto_msg (D_TLS_ERRORS, "TLS_ERROR: BIO read %s error", desc);
 	      buf->len = 0;
 	      ret = -1;
 	      ERR_clear_error ();
@@ -1190,7 +1201,7 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl, const struct tls_root_ctx *ssl_
 
   ks_ssl->ssl = SSL_new (ssl_ctx->ctx);
   if (!ks_ssl->ssl)
-    msg (M_SSLERR, "SSL_new failed");
+    crypto_msg (M_FATAL, "SSL_new failed");
 
   /* put session * in ssl object so we can access it
      from verify callback*/
@@ -1366,11 +1377,11 @@ show_available_tls_ciphers (const char *cipher_list)
 
   tls_ctx.ctx = SSL_CTX_new (SSLv23_method ());
   if (!tls_ctx.ctx)
-    msg (M_SSLERR, "Cannot create SSL_CTX object");
+    crypto_msg (M_FATAL, "Cannot create SSL_CTX object");
 
   ssl = SSL_new (tls_ctx.ctx);
   if (!ssl)
-    msg (M_SSLERR, "Cannot create SSL object");
+    crypto_msg (M_FATAL, "Cannot create SSL object");
 
   if (cipher_list)
     tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
@@ -1404,10 +1415,10 @@ get_highest_preference_tls_cipher (char *buf, int size)
 
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
2.5.0


