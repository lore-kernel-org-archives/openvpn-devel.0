From: Steffan Karger <steffan@...1856...>
Date: Sun, 23 Mar 2014 14:53:01 +0100
Message-Id: <1395582781-27966-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Bump minimum OpenSSL version to 0.9.8
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

OpenSSL 0.9.7 and older are considered obsolete (see
http://www.openssl.org/news/news.html). This patch updates configure.ac to
require OpenSSL 0.9.8 or newer, and removes a number of #ifdefs that are
now no longer needed.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac                     |  4 ++--
 src/openvpn/crypto_openssl.c     | 27 ---------------------------
 src/openvpn/options.c            |  9 ---------
 src/openvpn/ssl_openssl.c        |  4 ----
 src/openvpn/ssl_verify.c         |  4 ----
 src/openvpn/ssl_verify_backend.h |  4 ----
 src/openvpn/ssl_verify_openssl.c |  4 ----
 7 files changed, 2 insertions(+), 54 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2da6521..7e94280 100644
--- a/configure.ac
+++ b/configure.ac
@@ -744,7 +744,7 @@ PKG_CHECK_MODULES(
 
 PKG_CHECK_MODULES(
 	[OPENSSL_CRYPTO],
-	[libcrypto >= 0.9.6],
+	[libcrypto >= 0.9.8],
 	[have_openssl_crypto="yes"],
 	[AC_CHECK_LIB(
 		[crypto],
@@ -758,7 +758,7 @@ PKG_CHECK_MODULES(
 
 PKG_CHECK_MODULES(
 	[OPENSSL_SSL],
-	[libssl >= 0.9.6],
+	[libssl >= 0.9.8],
 	[have_openssl_ssl="yes"],
 	[AC_CHECK_LIB(
 		[ssl],
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 1501bc8..6199e61 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -57,33 +57,6 @@
 #warning Some OpenSSL HMAC message digests now support key lengths greater than MAX_HMAC_KEY_LENGTH -- consider increasing MAX_HMAC_KEY_LENGTH
 #endif
 
-/*
- *
- * Workarounds for incompatibilites between OpenSSL libraries.
- * Right now we accept OpenSSL libraries from 0.9.5 to 0.9.7.
- *
- */
-
-#if SSLEAY_VERSION_NUMBER < 0x00907000L
-
-/* Workaround: EVP_CIPHER_mode is defined wrong in OpenSSL 0.9.6 but is fixed in 0.9.7 */
-#undef EVP_CIPHER_mode
-#define EVP_CIPHER_mode(e)                (((e)->flags) & EVP_CIPH_MODE)
-
-#define DES_cblock                        des_cblock
-#define DES_is_weak_key                   des_is_weak_key
-#define DES_check_key_parity              des_check_key_parity
-#define DES_set_odd_parity                des_set_odd_parity
-
-#define HMAC_CTX_init(ctx)                CLEAR (*ctx)
-#define HMAC_Init_ex(ctx,sec,len,md,impl) HMAC_Init(ctx, sec, len, md)
-#define HMAC_CTX_cleanup(ctx)             HMAC_cleanup(ctx)
-#define EVP_MD_CTX_cleanup(md)            CLEAR (*md)
-
-#define INFO_CALLBACK_SSL_CONST
-
-#endif
-
 static inline int
 EVP_CipherInit_ov (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, uint8_t *key, uint8_t *iv, int enc)
 {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e7259f7..aea6076 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -567,12 +567,7 @@ static const char usage_message[] =
   "                  root certificate.\n"
 #ifndef ENABLE_CRYPTO_POLARSSL
   "--capath dir    : A directory of trusted certificates (CAs"
-#if OPENSSL_VERSION_NUMBER >= 0x00907000L
   " and CRLs).\n"
-#else /* OPENSSL_VERSION_NUMBER >= 0x00907000L */
-  ").\n"
-  "                  WARNING: no support of CRL available with this version.\n"
-#endif /* OPENSSL_VERSION_NUMBER >= 0x00907000L */
 #endif /* ENABLE_CRYPTO_POLARSSL */
   "--dh file       : File containing Diffie Hellman parameters\n"
   "                  in .pem format (for --tls-server only).\n"
@@ -635,7 +630,6 @@ static const char usage_message[] =
   "--x509-track x  : Save peer X509 attribute x in environment for use by\n"
   "                  plugins and management interface.\n"
 #endif
-#if OPENSSL_VERSION_NUMBER >= 0x00907000L || ENABLE_CRYPTO_POLARSSL
   "--remote-cert-ku v ... : Require that the peer certificate was signed with\n"
   "                  explicit key usage, you can specify more than one value.\n"
   "                  value should be given in hex format.\n"
@@ -645,7 +639,6 @@ static const char usage_message[] =
   "--remote-cert-tls t: Require that peer certificate was signed with explicit\n"
   "                  key usage and extended key usage based on RFC3280 TLS rules.\n"
   "                  t = 'client' | 'server'.\n"
-#endif				/* OPENSSL_VERSION_NUMBER || ENABLE_CRYPTO_POLARSSL */
 #endif				/* ENABLE_SSL */
 #ifdef ENABLE_PKCS11
   "\n"
@@ -6765,7 +6758,6 @@ add_option (struct options *options,
 	  goto err;
 	}
     }
-#if OPENSSL_VERSION_NUMBER >= 0x00907000L || ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "remote-cert-ku"))
     {
       int j;
@@ -6803,7 +6795,6 @@ add_option (struct options *options,
 	  goto err;
 	}
     }
-#endif	/* OPENSSL_VERSION_NUMBER */
   else if (streq (p[0], "tls-timeout") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_TLS_PARMS);
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 68a1d59..2da7eba 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -848,11 +848,7 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
         msg(M_WARN, "WARNING: experimental option --capath %s", ca_path);
       else
         msg(M_SSLERR, "Cannot add lookup at --capath %s", ca_path);
-#if OPENSSL_VERSION_NUMBER >= 0x00907000L
       X509_STORE_set_flags (store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHECK_ALL);
-#else
-      msg(M_WARN, "WARNING: this version of OpenSSL cannot handle CRL files in capath");
-#endif
     }
 }
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 4dd3aa2..765b886 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -337,8 +337,6 @@ verify_peer_cert(const struct tls_options *opt, openvpn_x509_cert_t *peer_cert,
 	}
     }
 
-#if OPENSSL_VERSION_NUMBER >= 0x00907000L || ENABLE_CRYPTO_POLARSSL
-
   /* verify certificate ku */
   if (opt->remote_cert_ku[0] != 0)
     {
@@ -367,8 +365,6 @@ verify_peer_cert(const struct tls_options *opt, openvpn_x509_cert_t *peer_cert,
 	}
     }
 
-#endif /* OPENSSL_VERSION_NUMBER */
-
   /* verify X509 name or username against --verify-x509-[user]name */
   if (opt->verify_x509_type != VERIFY_X509_NONE)
     {
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 1658cc0..7d2aae6 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -189,8 +189,6 @@ void x509_setenv_track (const struct x509_track *xt, struct env_set *es,
  */
 result_t x509_verify_ns_cert_type(const openvpn_x509_cert_t *cert, const int usage);
 
-#if OPENSSL_VERSION_NUMBER >= 0x00907000L || ENABLE_CRYPTO_POLARSSL
-
 /*
  * Verify X.509 key usage extension field.
  *
@@ -219,8 +217,6 @@ result_t x509_verify_cert_ku (openvpn_x509_cert_t *x509, const unsigned * const
  */
 result_t x509_verify_cert_eku (openvpn_x509_cert_t *x509, const char * const expected_oid);
 
-#endif
-
 /*
  * Store the given certificate in pem format in a temporary file in tmp_dir
  *
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 658f5f3..cd2006f 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -459,8 +459,6 @@ x509_verify_ns_cert_type(const openvpn_x509_cert_t *peer_cert, const int usage)
   return FAILURE;
 }
 
-#if OPENSSL_VERSION_NUMBER >= 0x00907000L
-
 result_t
 x509_verify_cert_ku (X509 *x509, const unsigned * const expected_ku,
     int expected_len)
@@ -566,8 +564,6 @@ x509_write_pem(FILE *peercert_file, X509 *peercert)
   return SUCCESS;
 }
 
-#endif /* OPENSSL_VERSION_NUMBER */
-
 /*
  * check peer cert against CRL
  */
-- 
1.8.3.2


