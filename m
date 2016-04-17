From: Steffan Karger <steffan@...1856...>
Date: Sun, 17 Apr 2016 20:35:42 +0200
Message-Id: <1460918143-408-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] Migrate to mbed TLS 2.x
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

PolarSSL / mbed TLS 1.3 is going end-of-life by 2016-12-31, so let's move
the master branch on to the 2.x series.

This patch purges all references to polarssl, except for file names and
some comments referring to 1.2 and earlier, which were never released as
'mbed TLS'.  A separate patch for the file names follows, so the real
changes are easier to spot without git-fu.

This patch intends to not change any behaviour.

The vast majority of this patch is just renaming functions and structs.
There are some small changes in the implementation:
 * In ssl_polarssl.c: the debug callback prototype changed, so our
   implementation changed a bit too.
 * in ssl_polarssl.c: the old polarssl ssl_context is now split into a
   mbedtls_ssl_config and mbedtls_ssl_context.  The intention is that
   mbedtls_ssl_config is shared among connections, and mbedtls_ssl_context
   contains the per-connection state.  That doesn't work for us, because
   we use per-connection verify callback data, while the verify callback
   is registered on mbed_tls_config.  Therefore we still need to init a
   mbed_tls_config struct for each connection.
 * in ssl_polarssl.c: the mbed bio handling changed, so our
   implementation changed a bit too.
 * in ssl_polarssl.c and ssl_verify_polarssl.c: the mbedtls x509 parse
   functions now fail if we don't provide a NUL-terminated string, so use
   strlen()+1 as the length argument to include the terminating NUL.

I tested this patch to work with:
 * 'make check' (with 2.0.0 and 2.2.1, other tests just with 2.2.1)
 * static key mode
 * TLS mode with PEM key file
 * TLS mode with password protected PEM key file
 * TLS mode with management-external-key
 * TLS mode with PKCS#11
 * TLS mode with inline ca/key/cert/dh

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac                      |  72 +++----
 include/openvpn-plugin.h.in       |  10 +-
 src/openvpn/crypto_backend.h      |   4 +-
 src/openvpn/crypto_polarssl.c     | 263 ++++++++++++-----------
 src/openvpn/crypto_polarssl.h     |  76 +++----
 src/openvpn/options.c             |  44 ++--
 src/openvpn/options.h             |   4 +-
 src/openvpn/pkcs11_polarssl.c     |  53 ++---
 src/openvpn/plugin.h              |   2 +-
 src/openvpn/ssl.c                 |   2 +-
 src/openvpn/ssl_backend.h         |   8 +-
 src/openvpn/ssl_polarssl.c        | 433 ++++++++++++++++++++------------------
 src/openvpn/ssl_polarssl.h        |  35 +--
 src/openvpn/ssl_verify.h          |   2 +-
 src/openvpn/ssl_verify_polarssl.c | 124 +++++------
 src/openvpn/ssl_verify_polarssl.h |  20 +-
 src/openvpn/syshead.h             |   6 +-
 17 files changed, 594 insertions(+), 564 deletions(-)

diff --git a/configure.ac b/configure.ac
index b75d51f..3b8bf96 100644
--- a/configure.ac
+++ b/configure.ac
@@ -291,10 +291,10 @@ AC_ARG_WITH(
 
 AC_ARG_WITH(
 	[crypto-library],
-	[AS_HELP_STRING([--with-crypto-library=library], [build with the given crypto library, TYPE=openssl|polarssl @<:@default=openssl@:>@])],
+	[AS_HELP_STRING([--with-crypto-library=library], [build with the given crypto library, TYPE=openssl|mbedtls @<:@default=openssl@:>@])],
 	[
 		case "${withval}" in 
-			openssl|polarssl) ;;
+			openssl|mbedtls) ;;
 			*) AC_MSG_ERROR([bad value ${withval} for --with-crypto-library]) ;;
 		esac
 	],
@@ -835,81 +835,77 @@ if test "${with_crypto_library}" = "openssl"; then
 	AC_DEFINE([ENABLE_CRYPTO_OPENSSL], [1], [Use OpenSSL library])
 	CRYPTO_CFLAGS="${OPENSSL_CFLAGS}"
 	CRYPTO_LIBS="${OPENSSL_LIBS}"
-elif test "${with_crypto_library}" = "polarssl"; then
-	AC_ARG_VAR([POLARSSL_CFLAGS], [C compiler flags for polarssl])
-	AC_ARG_VAR([POLARSSL_LIBS], [linker flags for polarssl])
+elif test "${with_crypto_library}" = "mbedtls"; then
+	AC_ARG_VAR([MBEDTLS_CFLAGS], [C compiler flags for mbedtls])
+	AC_ARG_VAR([MBEDTLS_LIBS], [linker flags for mbedtls])
 
 	saved_CFLAGS="${CFLAGS}"
 	saved_LIBS="${LIBS}"
 
-	if test -z "${POLARSSL_CFLAGS}" -a -z "${POLARSSL_LIBS}"; then
-        # if the user did not explicitly specify flags, try to autodetect
-		AC_SEARCH_LIBS(
-			[ssl_init],
-			[mbedtls polarssl],
-			[
-				if test "${ac_cv_search_ssl_init}" != "none required"; then
-					POLARSSL_LIBS=${ac_cv_search_ssl_init}
-				fi
-			],
-			[AC_MSG_ERROR([Could not find PolarSSL/mbed TLS.])],
+	if test -z "${MBEDTLS_CFLAGS}" -a -z "${MBEDTLS_LIBS}"; then
+	# if the user did not explicitly specify flags, try to autodetect
+		AC_CHECK_LIB(
+			[mbedtls],
+			[mbedtls_ssl_init],
+			[MBEDTLS_LIBS="-lmbedtls -lmbedcrypto -lmbedx509"],
+			[AC_MSG_ERROR([Could not find mbed TLS.])],
 			[${PKCS11_HELPER_LIBS}]
 		)
 	fi
 
-	CFLAGS="${POLARSSL_CFLAGS} ${PKCS11_HELPER_CFLAGS} ${CFLAGS}"
-	LIBS="${POLARSSL_LIBS} ${PKCS11_HELPER_LIBS} ${LIBS}"
+	CFLAGS="${MBEDTLS_CFLAGS} ${PKCS11_HELPER_CFLAGS} ${CFLAGS}"
+	LIBS="${MBEDTLS_LIBS} ${PKCS11_HELPER_LIBS} ${LIBS}"
 
-	AC_MSG_CHECKING([polarssl version])
+	AC_MSG_CHECKING([mbedtls version])
 	AC_COMPILE_IFELSE(
 		[AC_LANG_PROGRAM(
 			[[
-#include <polarssl/version.h>
+#include <mbedtls/version.h>
 			]],
 			[[
-#if POLARSSL_VERSION_NUMBER < 0x01030800 || POLARSSL_VERSION_NUMBER >= 0x01040000
+#if MBEDTLS_VERSION_NUMBER < 0x02000000 || MBEDTLS_VERSION_NUMBER >= 0x03000000
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([PolarSSL 1.3.x required and must be 1.3.8 or later])]
+		[AC_MSG_ERROR([mbed TLS 2.y.z required])]
 	)
 
-	polarssl_with_pkcs11="no"
+	mbedtls_with_pkcs11="no"
 	AC_COMPILE_IFELSE(
 		[AC_LANG_PROGRAM(
 			[[
-#include <polarssl/config.h>
+#include <mbedtls/config.h>
 			]],
 			[[
-#ifndef POLARSSL_PKCS11_C
+#ifndef MBEDTLS_PKCS11_C
 #error pkcs11 wrapper missing
 #endif
 			]]
 		)],
-		polarssl_with_pkcs11="yes")
+		mbedtls_with_pkcs11="yes")
 
-	AC_MSG_CHECKING([polarssl pkcs11 support])
+	AC_MSG_CHECKING([mbedtls pkcs11 support])
 	if test "${enable_pkcs11}" = "yes"; then
-		if test "${polarssl_with_pkcs11}" = "yes"; then
+		if test "${mbedtls_with_pkcs11}" = "yes"; then
 			AC_MSG_RESULT([ok])
 		else
-			AC_MSG_ERROR([polarssl has no pkcs11 wrapper compiled in])
+			AC_MSG_ERROR([mbedtls has no pkcs11 wrapper compiled in])
 		fi
 	else
-		if test "${polarssl_with_pkcs11}" != "yes"; then
+		if test "${mbedtls_with_pkcs11}" != "yes"; then
 			AC_MSG_RESULT([ok])
 		else
-			AC_MSG_ERROR([PolarSSL compiled with PKCS11, while OpenVPN is not])
+			AC_MSG_ERROR([mbed TLS compiled with PKCS11, while OpenVPN is not])
 		fi
 	fi
 
 	have_crypto_aead_modes="yes"
 	AC_CHECK_FUNCS(
 		[ \
-			cipher_write_tag \
-			cipher_check_tag \
+			mbedtls_cipher_write_tag \
+			mbedtls_cipher_check_tag \
 		],
 		,
 		[have_crypto_aead_modes="no"; break]
@@ -918,9 +914,9 @@ elif test "${with_crypto_library}" = "polarssl"; then
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
 	have_crypto="yes"
-	AC_DEFINE([ENABLE_CRYPTO_POLARSSL], [1], [Use PolarSSL library])
-	CRYPTO_CFLAGS="${POLARSSL_CFLAGS}"
-	CRYPTO_LIBS="${POLARSSL_LIBS}"
+	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
+	CRYPTO_CFLAGS="${MBEDTLS_CFLAGS}"
+	CRYPTO_LIBS="${MBEDTLS_LIBS}"
 else
 	AC_MSG_ERROR([Invalid crypto library: ${with_crypto_library}])
 fi
@@ -1048,8 +1044,8 @@ fi
 
 dnl enable --x509-username-field feature if requested
 if test "${enable_x509_alt_username}" = "yes"; then
-	if test "${with_crypto_library}" = "polarssl" ; then
-		AC_MSG_ERROR([PolarSSL does not support the --x509-username-field feature])
+	if test "${with_crypto_library}" = "mbedtls" ; then
+		AC_MSG_ERROR([mbed TLS does not support the --x509-username-field feature])
 	fi
 
 	AC_DEFINE([ENABLE_X509ALTUSERNAME], [1], [Enable --x509-username-field feature])
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index d4bf622..b03a9df 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -28,11 +28,11 @@
 #define OPENVPN_PLUGIN_VERSION 3
 
 #ifdef ENABLE_CRYPTO
-#ifdef ENABLE_CRYPTO_POLARSSL
-#include <polarssl/x509_crt.h>
+#ifdef ENABLE_CRYPTO_MBEDTLS
+#include <mbedtls/x509_crt.h>
 #ifndef __OPENVPN_X509_CERT_T_DECLARED
 #define __OPENVPN_X509_CERT_T_DECLARED
-typedef x509_crt openvpn_x509_cert_t;
+typedef mbedtls_x509_crt openvpn_x509_cert_t;
 #endif
 #else
 #include <openssl/x509.h>
@@ -277,13 +277,13 @@ struct openvpn_plugin_callbacks
 /**
  * Used by the openvpn_plugin_open_v3() function to indicate to the
  * plug-in what kind of SSL implementation OpenVPN uses.  This is
- * to avoid SEGV issues when OpenVPN is complied against PolarSSL
+ * to avoid SEGV issues when OpenVPN is complied against mbed TLS
  * and the plug-in against OpenSSL.
  */
 typedef enum {
   SSLAPI_NONE,
   SSLAPI_OPENSSL,
-  SSLAPI_POLARSSL
+  SSLAPI_MBEDTLS
 } ovpnSSLAPI;
 
 /**
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index fb7c351..c4986f5 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -33,7 +33,7 @@
 #ifdef ENABLE_CRYPTO_OPENSSL
 #include "crypto_openssl.h"
 #endif
-#ifdef ENABLE_CRYPTO_POLARSSL
+#ifdef ENABLE_CRYPTO_MBEDTLS
 #include "crypto_polarssl.h"
 #endif
 #include "basic.h"
@@ -294,7 +294,7 @@ bool cipher_kt_mode_aead(const cipher_kt_t *cipher);
  * @param key_len 	Length of the key, in bytes
  * @param kt		Static cipher parameters to use
  * @param enc		Whether to encrypt or decrypt (either
- * 			\c POLARSSL_OP_ENCRYPT or \c POLARSSL_OP_DECRYPT).
+ * 			\c MBEDTLS_OP_ENCRYPT or \c MBEDTLS_OP_DECRYPT).
  */
 void cipher_ctx_init (cipher_ctx_t *ctx, uint8_t *key, int key_len,
     const cipher_kt_t *kt, int enc);
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index fc6f6c3..da1b417 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -24,7 +24,7 @@
  */
 
 /**
- * @file Data Channel Cryptography PolarSSL-specific backend interface
+ * @file Data Channel Cryptography mbed TLS-specific backend interface
  */
 
 #ifdef HAVE_CONFIG_H
@@ -35,7 +35,7 @@
 
 #include "syshead.h"
 
-#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_POLARSSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
 
 #include "errlevel.h"
 #include "basic.h"
@@ -45,13 +45,14 @@
 #include "otime.h"
 #include "misc.h"
 
-#include <polarssl/des.h>
-#include <polarssl/error.h>
-#include <polarssl/md5.h>
-#include <polarssl/cipher.h>
-#include <polarssl/havege.h>
+#include <mbedtls/des.h>
+#include <mbedtls/error.h>
+#include <mbedtls/md5.h>
+#include <mbedtls/cipher.h>
+#include <mbedtls/havege.h>
+
+#include <mbedtls/entropy.h>
 
-#include <polarssl/entropy.h>
 
 /*
  *
@@ -62,7 +63,7 @@
 void
 crypto_init_lib_engine (const char *engine_name)
 {
-  msg (M_WARN, "Note: PolarSSL hardware crypto engine functionality is not "
+  msg (M_WARN, "Note: mbed TLS hardware crypto engine functionality is not "
       "available");
 }
 
@@ -87,29 +88,29 @@ crypto_clear_error (void)
 {
 }
 
-bool polar_log_err(unsigned int flags, int errval, const char *prefix)
+bool mbed_log_err(unsigned int flags, int errval, const char *prefix)
 {
   if (0 != errval)
     {
       char errstr[256];
-      polarssl_strerror(errval, errstr, sizeof(errstr));
+      mbedtls_strerror(errval, errstr, sizeof(errstr));
 
-      if (NULL == prefix) prefix = "PolarSSL error";
+      if (NULL == prefix) prefix = "mbed TLS error";
       msg (flags, "%s: %s", prefix, errstr);
     }
 
   return 0 == errval;
 }
 
-bool polar_log_func_line(unsigned int flags, int errval, const char *func,
+bool mbed_log_func_line(unsigned int flags, int errval, const char *func,
     int line)
 {
   char prefix[256];
 
   if (!openvpn_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
-    return polar_log_err(flags, errval, func);
+    return mbed_log_err(flags, errval, func);
 
-  return polar_log_err(flags, errval, prefix);
+  return mbed_log_err(flags, errval, prefix);
 }
 
 
@@ -117,7 +118,7 @@ bool polar_log_func_line(unsigned int flags, int errval, const char *func,
 void
 crypto_init_dmalloc (void)
 {
-  msg (M_ERR, "Error: dmalloc support is not available for PolarSSL.");
+  msg (M_ERR, "Error: dmalloc support is not available for mbed TLS.");
 }
 #endif /* DMALLOC */
 
@@ -134,7 +135,7 @@ const size_t cipher_name_translation_table_count =
 void
 show_available_ciphers ()
 {
-  const int *ciphers = cipher_list();
+  const int *ciphers = mbedtls_cipher_list();
 
 #ifndef ENABLE_SMALL
   printf ("The following ciphers and cipher modes are available for use\n"
@@ -145,7 +146,7 @@ show_available_ciphers ()
 
   while (*ciphers != 0)
     {
-      const cipher_kt_t *info = cipher_info_from_type(*ciphers);
+      const cipher_kt_t *info = mbedtls_cipher_info_from_type(*ciphers);
 
       if (info && (cipher_kt_mode_cbc(info)
 #ifdef HAVE_AEAD_CIPHER_MODES
@@ -168,7 +169,7 @@ show_available_ciphers ()
 void
 show_available_digests ()
 {
-  const int *digests = md_list();
+  const int *digests = mbedtls_md_list();
 
 #ifndef ENABLE_SMALL
   printf ("The following message digests are available for use with\n"
@@ -180,11 +181,11 @@ show_available_digests ()
 
   while (*digests != 0)
     {
-      const md_info_t *info = md_info_from_type(*digests);
+      const mbedtls_md_info_t *info = mbedtls_md_info_from_type(*digests);
 
       if (info)
-	printf ("%s %d bit default key\n",
-		md_get_name(info), md_get_size(info) * 8);
+	printf ("%s %d bit default key\n", mbedtls_md_get_name(info),
+	    mbedtls_md_get_size(info) * 8);
       digests++;
     }
   printf ("\n");
@@ -193,7 +194,7 @@ show_available_digests ()
 void
 show_available_engines ()
 {
-  printf ("Sorry, PolarSSL hardware crypto engine functionality is not "
+  printf ("Sorry, mbed TLS hardware crypto engine functionality is not "
       "available\n");
 }
 
@@ -210,10 +211,10 @@ show_available_engines ()
  * Initialise the given ctr_drbg context, using a personalisation string and an
  * entropy gathering function.
  */
-ctr_drbg_context * rand_ctx_get()
+mbedtls_ctr_drbg_context * rand_ctx_get()
 {
-  static entropy_context ec = {0};
-  static ctr_drbg_context cd_ctx = {0};
+  static mbedtls_entropy_context ec = {0};
+  static mbedtls_ctr_drbg_context cd_ctx = {0};
   static bool rand_initialised = false;
 
   if (!rand_initialised)
@@ -228,10 +229,11 @@ ctr_drbg_context * rand_ctx_get()
        */
       buf_printf(&pers_string, "OpenVPN %0u %p %s", platform_getpid(), &cd_ctx, time_string(0, 0, 0, &gc));
 
-      /* Initialise PolarSSL RNG, and built-in entropy sources */
-      entropy_init(&ec);
+      /* Initialise mbed TLS RNG, and built-in entropy sources */
+      mbedtls_entropy_init(&ec);
 
-      if (!polar_ok(ctr_drbg_init(&cd_ctx, entropy_func, &ec,
+      mbedtls_ctr_drbg_init(&cd_ctx);
+      if (!mbed_ok(mbedtls_ctr_drbg_seed(&cd_ctx, mbedtls_entropy_func, &ec,
 		    BPTR(&pers_string), BLEN(&pers_string))))
         msg (M_FATAL, "Failed to initialize random generator");
 
@@ -245,21 +247,21 @@ ctr_drbg_context * rand_ctx_get()
 #ifdef ENABLE_PREDICTION_RESISTANCE
 void rand_ctx_enable_prediction_resistance()
 {
-  ctr_drbg_context *cd_ctx = rand_ctx_get();
+  mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
 
-  ctr_drbg_set_prediction_resistance(cd_ctx, 1);
+  mbedtls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);
 }
 #endif /* ENABLE_PREDICTION_RESISTANCE */
 
 int
 rand_bytes (uint8_t *output, int len)
 {
-  ctr_drbg_context *rng_ctx = rand_ctx_get();
+  mbedtls_ctr_drbg_context *rng_ctx = rand_ctx_get();
 
   while (len > 0)
     {
-      const size_t blen = min_int (len, CTR_DRBG_MAX_REQUEST);
-      if (0 != ctr_drbg_random(rng_ctx, output, blen))
+      const size_t blen = min_int (len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
+      if (0 != mbedtls_ctr_drbg_random(rng_ctx, output, blen))
 	return 0;
 
       output += blen;
@@ -277,14 +279,14 @@ rand_bytes (uint8_t *output, int len)
 
 
 int
-key_des_num_cblocks (const cipher_info_t *kt)
+key_des_num_cblocks (const mbedtls_cipher_info_t *kt)
 {
   int ret = 0;
-  if (kt->type == POLARSSL_CIPHER_DES_CBC)
+  if (kt->type == MBEDTLS_CIPHER_DES_CBC)
     ret = 1;
-  if (kt->type == POLARSSL_CIPHER_DES_EDE_CBC)
+  if (kt->type == MBEDTLS_CIPHER_DES_EDE_CBC)
     ret = 2;
-  if (kt->type == POLARSSL_CIPHER_DES_EDE3_CBC)
+  if (kt->type == MBEDTLS_CIPHER_DES_EDE3_CBC)
     ret = 3;
 
   dmsg (D_CRYPTO_DEBUG, "CRYPTO INFO: n_DES_cblocks=%d", ret);
@@ -301,18 +303,18 @@ key_des_check (uint8_t *key, int key_len, int ndc)
 
   for (i = 0; i < ndc; ++i)
     {
-      unsigned char *key = buf_read_alloc(&b, DES_KEY_SIZE);
+      unsigned char *key = buf_read_alloc(&b, MBEDTLS_DES_KEY_SIZE);
       if (!key)
 	{
 	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key material");
 	  goto err;
 	}
-      if (0 != des_key_check_weak(key))
+      if (0 != mbedtls_des_key_check_weak(key))
 	{
 	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key detected");
 	  goto err;
 	}
-      if (0 != des_key_check_key_parity(key))
+      if (0 != mbedtls_des_key_check_key_parity(key))
 	{
 	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: bad parity detected");
 	  goto err;
@@ -333,13 +335,13 @@ key_des_fixup (uint8_t *key, int key_len, int ndc)
   buf_set_read (&b, key, key_len);
   for (i = 0; i < ndc; ++i)
     {
-      unsigned char *key = buf_read_alloc(&b, DES_KEY_SIZE);
+      unsigned char *key = buf_read_alloc(&b, MBEDTLS_DES_KEY_SIZE);
       if (!key)
 	{
 	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: fixup_key_DES: insufficient key material");
 	  return;
 	}
-      des_key_set_parity(key);
+      mbedtls_des_key_set_parity(key);
     }
 }
 
@@ -350,29 +352,29 @@ key_des_fixup (uint8_t *key, int key_len, int ndc)
  */
 
 
-const cipher_info_t *
+const mbedtls_cipher_info_t *
 cipher_kt_get (const char *ciphername)
 {
-  const cipher_info_t *cipher = NULL;
+  const mbedtls_cipher_info_t *cipher = NULL;
 
   ASSERT (ciphername);
 
-  cipher = cipher_info_from_string(ciphername);
+  cipher = mbedtls_cipher_info_from_string(ciphername);
 
   if (NULL == cipher)
     msg (M_FATAL, "Cipher algorithm '%s' not found", ciphername);
 
-  if (cipher->key_length/8 > MAX_CIPHER_KEY_LENGTH)
+  if (cipher->key_bitlen/8 > MAX_CIPHER_KEY_LENGTH)
     msg (M_FATAL, "Cipher algorithm '%s' uses a default key size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum key size (%d bytes)",
 	 ciphername,
-	 cipher->key_length/8,
+	 cipher->key_bitlen/8,
 	 MAX_CIPHER_KEY_LENGTH);
 
   return cipher;
 }
 
 const char *
-cipher_kt_name (const cipher_info_t *cipher_kt)
+cipher_kt_name (const mbedtls_cipher_info_t *cipher_kt)
 {
   if (NULL == cipher_kt)
     return "[null-cipher]";
@@ -381,16 +383,16 @@ cipher_kt_name (const cipher_info_t *cipher_kt)
 }
 
 int
-cipher_kt_key_size (const cipher_info_t *cipher_kt)
+cipher_kt_key_size (const mbedtls_cipher_info_t *cipher_kt)
 {
   if (NULL == cipher_kt)
     return 0;
 
-  return cipher_kt->key_length/8;
+  return cipher_kt->key_bitlen/8;
 }
 
 int
-cipher_kt_iv_size (const cipher_info_t *cipher_kt)
+cipher_kt_iv_size (const mbedtls_cipher_info_t *cipher_kt)
 {
   if (NULL == cipher_kt)
     return 0;
@@ -398,7 +400,7 @@ cipher_kt_iv_size (const cipher_info_t *cipher_kt)
 }
 
 int
-cipher_kt_block_size (const cipher_info_t *cipher_kt)
+cipher_kt_block_size (const mbedtls_cipher_info_t *cipher_kt)
 {
   if (NULL == cipher_kt)
     return 0;
@@ -406,7 +408,7 @@ cipher_kt_block_size (const cipher_info_t *cipher_kt)
 }
 
 int
-cipher_kt_tag_size (const cipher_info_t *cipher_kt)
+cipher_kt_tag_size (const mbedtls_cipher_info_t *cipher_kt)
 {
 #ifdef HAVE_AEAD_CIPHER_MODES
   if (cipher_kt && cipher_kt_mode_aead(cipher_kt))
@@ -416,7 +418,7 @@ cipher_kt_tag_size (const cipher_info_t *cipher_kt)
 }
 
 int
-cipher_kt_mode (const cipher_info_t *cipher_kt)
+cipher_kt_mode (const mbedtls_cipher_info_t *cipher_kt)
 {
   ASSERT(NULL != cipher_kt);
   return cipher_kt->mode;
@@ -432,7 +434,7 @@ bool
 cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
 {
   return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB ||
-	  cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
+      cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
 }
 
 bool
@@ -450,31 +452,31 @@ cipher_kt_mode_aead(const cipher_kt_t *cipher)
 
 
 void
-cipher_ctx_init (cipher_context_t *ctx, uint8_t *key, int key_len,
-    const cipher_info_t *kt, int enc)
+cipher_ctx_init (mbedtls_cipher_context_t *ctx, uint8_t *key, int key_len,
+    const mbedtls_cipher_info_t *kt, const mbedtls_operation_t operation)
 {
   ASSERT(NULL != kt && NULL != ctx);
 
   CLEAR (*ctx);
 
-  if (!polar_ok(cipher_init_ctx(ctx, kt)))
-    msg (M_FATAL, "PolarSSL cipher context init #1");
+  if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
+    msg (M_FATAL, "mbed TLS cipher context init #1");
 
-  if (!polar_ok(cipher_setkey(ctx, key, key_len*8, enc)))
-    msg (M_FATAL, "PolarSSL cipher set key");
+  if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, key_len*8, operation)))
+    msg (M_FATAL, "mbed TLS cipher set key");
 
   /* make sure we used a big enough key */
-  ASSERT (ctx->key_length <= key_len*8);
+  ASSERT (ctx->key_bitlen <= key_len*8);
 }
 
-void cipher_ctx_cleanup (cipher_context_t *ctx)
+void cipher_ctx_cleanup (mbedtls_cipher_context_t *ctx)
 {
-  cipher_free(ctx);
+  mbedtls_cipher_free(ctx);
 }
 
-int cipher_ctx_iv_length (const cipher_context_t *ctx)
+int cipher_ctx_iv_length (const mbedtls_cipher_context_t *ctx)
 {
-  return cipher_get_iv_size(ctx);
+  return mbedtls_cipher_get_iv_size(ctx);
 }
 
 int cipher_ctx_get_tag (cipher_ctx_t *ctx, uint8_t* tag, int tag_len)
@@ -483,7 +485,7 @@ int cipher_ctx_get_tag (cipher_ctx_t *ctx, uint8_t* tag, int tag_len)
   if (tag_len > SIZE_MAX)
     return 0;
 
-  if (!polar_ok (cipher_write_tag (ctx, (unsigned char *) tag, tag_len)))
+  if (!mbed_ok (mbedtls_cipher_write_tag (ctx, (unsigned char *) tag, tag_len)))
     return 0;
 
   return 1;
@@ -492,12 +494,12 @@ int cipher_ctx_get_tag (cipher_ctx_t *ctx, uint8_t* tag, int tag_len)
 #endif /* HAVE_AEAD_CIPHER_MODES */
 }
 
-int cipher_ctx_block_size(const cipher_context_t *ctx)
+int cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)
 {
-  return cipher_get_block_size(ctx);
+  return mbedtls_cipher_get_block_size(ctx);
 }
 
-int cipher_ctx_mode (const cipher_context_t *ctx)
+int cipher_ctx_mode (const mbedtls_cipher_context_t *ctx)
 {
   ASSERT(NULL != ctx);
 
@@ -510,12 +512,12 @@ cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
   return ctx ? ctx->cipher_info : NULL;
 }
 
-int cipher_ctx_reset (cipher_context_t *ctx, uint8_t *iv_buf)
+int cipher_ctx_reset (mbedtls_cipher_context_t *ctx, uint8_t *iv_buf)
 {
-  if (!polar_ok(cipher_reset(ctx)))
+  if (!mbed_ok(mbedtls_cipher_reset(ctx)))
     return 0;
 
-  if (!polar_ok(cipher_set_iv(ctx, iv_buf, ctx->cipher_info->iv_size)))
+  if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, ctx->cipher_info->iv_size)))
     return 0;
 
   return 1;
@@ -527,7 +529,7 @@ int cipher_ctx_update_ad (cipher_ctx_t *ctx, const uint8_t *src, int src_len)
   if (src_len > SIZE_MAX)
     return 0;
 
-  if (!polar_ok (cipher_update_ad (ctx, src, src_len)))
+  if (!mbed_ok (mbedtls_cipher_update_ad (ctx, src, src_len)))
     return 0;
 
   return 1;
@@ -536,12 +538,13 @@ int cipher_ctx_update_ad (cipher_ctx_t *ctx, const uint8_t *src, int src_len)
 #endif /* HAVE_AEAD_CIPHER_MODES */
 }
 
-int cipher_ctx_update (cipher_context_t *ctx, uint8_t *dst, int *dst_len,
-    uint8_t *src, int src_len)
+int cipher_ctx_update (mbedtls_cipher_context_t *ctx, uint8_t *dst,
+    int *dst_len, uint8_t *src, int src_len)
 {
   size_t s_dst_len = *dst_len;
 
-  if (!polar_ok(cipher_update(ctx, src, (size_t)src_len, dst, &s_dst_len)))
+  if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t) src_len, dst,
+      &s_dst_len)))
     return 0;
 
   *dst_len = s_dst_len;
@@ -549,11 +552,11 @@ int cipher_ctx_update (cipher_context_t *ctx, uint8_t *dst, int *dst_len,
   return 1;
 }
 
-int cipher_ctx_final (cipher_context_t *ctx, uint8_t *dst, int *dst_len)
+int cipher_ctx_final (mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len)
 {
   size_t s_dst_len = *dst_len;
 
-  if (!polar_ok(cipher_finish(ctx, dst, &s_dst_len)))
+  if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &s_dst_len)))
     return 0;
 
   *dst_len = s_dst_len;
@@ -561,23 +564,30 @@ int cipher_ctx_final (cipher_context_t *ctx, uint8_t *dst, int *dst_len)
   return 1;
 }
 
-int cipher_ctx_final_check_tag (cipher_context_t *ctx, uint8_t *dst,
+int cipher_ctx_final_check_tag (mbedtls_cipher_context_t *ctx, uint8_t *dst,
     int *dst_len, uint8_t *tag, size_t tag_len)
 {
 #ifdef HAVE_AEAD_CIPHER_MODES
-  if (POLARSSL_DECRYPT != ctx->operation)
+  size_t olen = 0;
+
+  if (MBEDTLS_DECRYPT != ctx->operation)
     return 0;
 
   if (tag_len > SIZE_MAX)
     return 0;
 
-  if (!cipher_ctx_final (ctx, dst, dst_len))
+  if (!mbed_ok (mbedtls_cipher_finish (ctx, dst, &olen)))
     {
       msg (D_CRYPT_ERRORS, "%s: cipher_ctx_final() failed", __func__);
       return 0;
     }
 
-  if (!polar_ok (cipher_check_tag (ctx, (const unsigned char *) tag, tag_len)))
+  if (olen > INT_MAX)
+    return 0;
+  *dst_len = olen;
+
+  if (!mbed_ok (mbedtls_cipher_check_tag (ctx, (const unsigned char *) tag,
+      tag_len)))
     return 0;
 
   return 1;
@@ -591,10 +601,10 @@ cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
     unsigned char *src,
     unsigned char *dst)
 {
-    des_context ctx;
+  mbedtls_des_context ctx;
 
-    ASSERT (polar_ok(des_setkey_enc(&ctx, key)));
-    ASSERT (polar_ok(des_crypt_ecb(&ctx, src, dst)));
+  ASSERT (mbed_ok(mbedtls_des_setkey_enc(&ctx, key)));
+  ASSERT (mbed_ok(mbedtls_des_crypt_ecb(&ctx, src, dst)));
 }
 
 
@@ -606,37 +616,37 @@ cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
  */
 
 
-const md_info_t *
+const mbedtls_md_info_t *
 md_kt_get (const char *digest)
 {
-  const md_info_t *md = NULL;
+  const mbedtls_md_info_t *md = NULL;
   ASSERT (digest);
 
-  md = md_info_from_string(digest);
+  md = mbedtls_md_info_from_string(digest);
   if (!md)
     msg (M_FATAL, "Message hash algorithm '%s' not found", digest);
-  if (md_get_size(md) > MAX_HMAC_KEY_LENGTH)
+  if (mbedtls_md_get_size(md) > MAX_HMAC_KEY_LENGTH)
     msg (M_FATAL, "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum hash size (%d bytes)",
 	 digest,
-	 md_get_size(md),
+	 mbedtls_md_get_size(md),
 	 MAX_HMAC_KEY_LENGTH);
   return md;
 }
 
 const char *
-md_kt_name (const md_info_t *kt)
+md_kt_name (const mbedtls_md_info_t *kt)
 {
   if (NULL == kt)
     return "[null-digest]";
-  return md_get_name (kt);
+  return mbedtls_md_get_name (kt);
 }
 
 int
-md_kt_size (const md_info_t *kt)
+md_kt_size (const mbedtls_md_info_t *kt)
 {
   if (NULL == kt)
     return 0;
-  return md_get_size(kt);
+  return mbedtls_md_get_size(kt);
 }
 
 /*
@@ -648,45 +658,44 @@ md_kt_size (const md_info_t *kt)
 int
 md_full (const md_kt_t *kt, const uint8_t *src, int src_len, uint8_t *dst)
 {
-  return 0 == md(kt, src, src_len, dst);
+  return 0 == mbedtls_md(kt, src, src_len, dst);
 }
 
 
 void
-md_ctx_init (md_context_t *ctx, const md_info_t *kt)
+md_ctx_init (mbedtls_md_context_t *ctx, const mbedtls_md_info_t *kt)
 {
   ASSERT(NULL != ctx && NULL != kt);
 
-  CLEAR(*ctx);
-
-  ASSERT(0 == md_init_ctx(ctx, kt));
-  ASSERT(0 == md_starts(ctx));
+  mbedtls_md_init(ctx);
+  ASSERT(0 == mbedtls_md_setup(ctx, kt, 0));
+  ASSERT(0 == mbedtls_md_starts(ctx));
 }
 
 void
-md_ctx_cleanup(md_context_t *ctx)
+md_ctx_cleanup(mbedtls_md_context_t *ctx)
 {
 }
 
 int
-md_ctx_size (const md_context_t *ctx)
+md_ctx_size (const mbedtls_md_context_t *ctx)
 {
   if (NULL == ctx)
     return 0;
-  return md_get_size(ctx->md_info);
+  return mbedtls_md_get_size(ctx->md_info);
 }
 
 void
-md_ctx_update (md_context_t *ctx, const uint8_t *src, int src_len)
+md_ctx_update (mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
 {
-  ASSERT(0 == md_update(ctx, src, src_len));
+  ASSERT(0 == mbedtls_md_update(ctx, src, src_len));
 }
 
 void
-md_ctx_final (md_context_t *ctx, uint8_t *dst)
+md_ctx_final (mbedtls_md_context_t *ctx, uint8_t *dst)
 {
-  ASSERT(0 == md_finish(ctx, dst));
-  md_free(ctx);
+  ASSERT(0 == mbedtls_md_finish(ctx, dst));
+  mbedtls_md_free(ctx);
 }
 
 
@@ -701,49 +710,49 @@ md_ctx_final (md_context_t *ctx, uint8_t *dst)
  * TODO: re-enable dmsg for crypto debug
  */
 void
-hmac_ctx_init (md_context_t *ctx, const uint8_t *key, int key_len, const md_info_t *kt)
+hmac_ctx_init (mbedtls_md_context_t *ctx, const uint8_t *key, int key_len,
+    const mbedtls_md_info_t *kt)
 {
   ASSERT(NULL != kt && NULL != ctx);
 
-  CLEAR(*ctx);
-
-  ASSERT(0 == md_init_ctx(ctx, kt));
-  ASSERT(0 == md_hmac_starts(ctx, key, key_len));
+  mbedtls_md_init(ctx);
+  ASSERT(0 == mbedtls_md_setup(ctx, kt, 1));
+  ASSERT(0 == mbedtls_md_hmac_starts(ctx, key, key_len));
 
   /* make sure we used a big enough key */
-  ASSERT (md_get_size(kt) <= key_len);
+  ASSERT (mbedtls_md_get_size(kt) <= key_len);
 }
 
 void
-hmac_ctx_cleanup(md_context_t *ctx)
+hmac_ctx_cleanup(mbedtls_md_context_t *ctx)
 {
-  md_free(ctx);
+  mbedtls_md_free(ctx);
 }
 
 int
-hmac_ctx_size (const md_context_t *ctx)
+hmac_ctx_size (const mbedtls_md_context_t *ctx)
 {
   if (NULL == ctx)
     return 0;
-  return md_get_size(ctx->md_info);
+  return mbedtls_md_get_size(ctx->md_info);
 }
 
 void
-hmac_ctx_reset (md_context_t *ctx)
+hmac_ctx_reset (mbedtls_md_context_t *ctx)
 {
-  ASSERT(0 == md_hmac_reset(ctx));
+  ASSERT(0 == mbedtls_md_hmac_reset(ctx));
 }
 
 void
-hmac_ctx_update (md_context_t *ctx, const uint8_t *src, int src_len)
+hmac_ctx_update (mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
 {
-  ASSERT(0 == md_hmac_update(ctx, src, src_len));
+  ASSERT(0 == mbedtls_md_hmac_update(ctx, src, src_len));
 }
 
 void
-hmac_ctx_final (md_context_t *ctx, uint8_t *dst)
+hmac_ctx_final (mbedtls_md_context_t *ctx, uint8_t *dst)
 {
-  ASSERT(0 == md_hmac_finish(ctx, dst));
+  ASSERT(0 == mbedtls_md_hmac_finish(ctx, dst));
 }
 
-#endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_POLARSSL */
+#endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index 7be0862..574a63f 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -24,51 +24,51 @@
  */
 
 /**
- * @file Data Channel Cryptography PolarSSL-specific backend interface
+ * @file Data Channel Cryptography mbed TLS-specific backend interface
  */
 
-#ifndef CRYPTO_POLARSSL_H_
-#define CRYPTO_POLARSSL_H_
+#ifndef CRYPTO_MBEDTLS_H_
+#define CRYPTO_MBEDTLS_H_
 
-#include <polarssl/cipher.h>
-#include <polarssl/md.h>
-#include <polarssl/ctr_drbg.h>
+#include <mbedtls/cipher.h>
+#include <mbedtls/md.h>
+#include <mbedtls/ctr_drbg.h>
 
 /** Generic cipher key type %context. */
-typedef cipher_info_t cipher_kt_t;
+typedef mbedtls_cipher_info_t cipher_kt_t;
 
 /** Generic message digest key type %context. */
-typedef md_info_t md_kt_t;
+typedef mbedtls_md_info_t md_kt_t;
 
 /** Generic cipher %context. */
-typedef cipher_context_t cipher_ctx_t;
+typedef mbedtls_cipher_context_t cipher_ctx_t;
 
 /** Generic message digest %context. */
-typedef md_context_t md_ctx_t;
+typedef mbedtls_md_context_t md_ctx_t;
 
 /** Generic HMAC %context. */
-typedef md_context_t hmac_ctx_t;
+typedef mbedtls_md_context_t hmac_ctx_t;
 
 /** Maximum length of an IV */
-#define OPENVPN_MAX_IV_LENGTH 	POLARSSL_MAX_IV_LENGTH
+#define OPENVPN_MAX_IV_LENGTH 	MBEDTLS_MAX_IV_LENGTH
 
 /** Cipher is in CBC mode */
-#define OPENVPN_MODE_CBC 	POLARSSL_MODE_CBC
+#define OPENVPN_MODE_CBC 	MBEDTLS_MODE_CBC
 
 /** Cipher is in OFB mode */
-#define OPENVPN_MODE_OFB 	POLARSSL_MODE_OFB
+#define OPENVPN_MODE_OFB 	MBEDTLS_MODE_OFB
 
 /** Cipher is in CFB mode */
-#define OPENVPN_MODE_CFB 	POLARSSL_MODE_CFB
+#define OPENVPN_MODE_CFB 	MBEDTLS_MODE_CFB
 
 /** Cipher is in GCM mode */
-#define OPENVPN_MODE_GCM	POLARSSL_MODE_GCM
+#define OPENVPN_MODE_GCM	MBEDTLS_MODE_GCM
 
 /** Cipher should encrypt */
-#define OPENVPN_OP_ENCRYPT 	POLARSSL_ENCRYPT
+#define OPENVPN_OP_ENCRYPT 	MBEDTLS_ENCRYPT
 
 /** Cipher should decrypt */
-#define OPENVPN_OP_DECRYPT 	POLARSSL_DECRYPT
+#define OPENVPN_OP_DECRYPT 	MBEDTLS_DECRYPT
 
 #define MD4_DIGEST_LENGTH 	16
 #define MD5_DIGEST_LENGTH 	16
@@ -76,16 +76,16 @@ typedef md_context_t hmac_ctx_t;
 #define DES_KEY_LENGTH 8
 
 /**
- * Returns a singleton instance of the PolarSSL random number generator.
+ * Returns a singleton instance of the mbed TLS random number generator.
  *
- * For PolarSSL 1.1+, this is the CTR_DRBG random number generator. If it
+ * For PolarSSL/mbed TLS 1.1+, this is the CTR_DRBG random number generator. If it
  * hasn't been initialised yet, the RNG will be initialised using the default
  * entropy sources. Aside from the default platform entropy sources, an
  * additional entropy source, the HAVEGE random number generator will also be
  * added. During initialisation, a personalisation string will be added based
  * on the time, the PID, and a pointer to the random context.
  */
-ctr_drbg_context * rand_ctx_get();
+mbedtls_ctr_drbg_context *rand_ctx_get();
 
 #ifdef ENABLE_PREDICTION_RESISTANCE
 /**
@@ -95,34 +95,34 @@ void rand_ctx_enable_prediction_resistance();
 #endif
 
 /**
- * Log the supplied PolarSSL error, prefixed by supplied prefix.
+ * Log the supplied mbed TLS error, prefixed by supplied prefix.
  *
  * @param flags		Flags to indicate error type and priority.
- * @param errval	PolarSSL error code to convert to error message.
- * @param prefix	Prefix to PolarSSL error message.
+ * @param errval	mbed TLS error code to convert to error message.
+ * @param prefix	Prefix to mbed TLS error message.
  *
  * @returns true if no errors are detected, false otherwise.
  */
-bool polar_log_err(unsigned int flags, int errval, const char *prefix);
+bool mbed_log_err(unsigned int flags, int errval, const char *prefix);
 
 /**
- * Log the supplied PolarSSL error, prefixed by function name and line number.
+ * Log the supplied mbed TLS error, prefixed by function name and line number.
  *
  * @param flags		Flags to indicate error type and priority.
- * @param errval	PolarSSL error code to convert to error message.
+ * @param errval	mbed TLS error code to convert to error message.
  * @param func		Function name where error was reported.
  * @param line		Line number where error was reported.
  *
  * @returns true if no errors are detected, false otherwise.
  */
-bool polar_log_func_line(unsigned int flags, int errval, const char *func,
+bool mbed_log_func_line(unsigned int flags, int errval, const char *func,
     int line);
 
-/** Wraps polar_log_func_line() to prevent function calls for non-errors */
-static inline bool polar_log_func_line_lite(unsigned int flags, int errval,
+/** Wraps mbed_log_func_line() to prevent function calls for non-errors */
+static inline bool mbed_log_func_line_lite(unsigned int flags, int errval,
     const char *func, int line) {
   if (errval) {
-    return polar_log_func_line (flags, errval, func, line);
+    return mbed_log_func_line (flags, errval, func, line);
   }
   return true;
 }
@@ -130,17 +130,17 @@ static inline bool polar_log_func_line_lite(unsigned int flags, int errval,
 /**
  * Check errval and log on error.
  *
- * Convenience wrapper to put around polarssl library calls, e.g.
- *   if (!polar_ok(polarssl_func())) return 0;
+ * Convenience wrapper to put around mbed TLS library calls, e.g.
+ *   if (!mbed_ok (mbedtls_ssl_func())) return 0;
  * or
- *   ASSERT (polar_ok(polarssl_func()));
+ *   ASSERT (mbed_ok (mbedtls_ssl_func()));
  *
- * @param errval	PolarSSL error code to convert to error message.
+ * @param errval	mbed TLS error code to convert to error message.
  *
  * @returns true if no errors are detected, false otherwise.
  */
-#define polar_ok(errval) \
-  polar_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
+#define mbed_ok(errval) \
+  mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
 
 
-#endif /* CRYPTO_POLARSSL_H_ */
+#endif /* CRYPTO_MBEDTLS_H_ */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cd5c31b..9634dac 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -68,13 +68,13 @@ const char title_string[] =
 #endif
   " " TARGET_ALIAS
 #ifdef ENABLE_CRYPTO
-#if defined(ENABLE_CRYPTO_POLARSSL)
-  " [SSL (PolarSSL)]"
+#if defined(ENABLE_CRYPTO_MBEDTLS)
+  " [SSL (mbed TLS)]"
 #elif defined(ENABLE_CRYPTO_OPENSSL)
   " [SSL (OpenSSL)]"
 #else
   " [SSL]"
-#endif /* defined(ENABLE_CRYPTO_POLARSSL) */
+#endif /* defined(ENABLE_CRYPTO_MBEDTLS) */
 #endif /* ENABLE_CRYPTO */
 #ifdef USE_COMP
 #ifdef ENABLE_LZO
@@ -524,7 +524,7 @@ static const char usage_message[] =
   "--keysize n     : Size of cipher key in bits (optional).\n"
   "                  If unspecified, defaults to cipher-specific default.\n"
 #endif
-#ifndef ENABLE_CRYPTO_POLARSSL
+#ifndef ENABLE_CRYPTO_MBEDTLS
   "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
 #endif
   "--no-replay     : Disable replay protection.\n"
@@ -550,10 +550,10 @@ static const char usage_message[] =
   "                  number, such as 1 (default), 2, etc.\n"
   "--ca file       : Certificate authority file in .pem format containing\n"
   "                  root certificate.\n"
-#ifndef ENABLE_CRYPTO_POLARSSL
+#ifndef ENABLE_CRYPTO_MBEDTLS
   "--capath dir    : A directory of trusted certificates (CAs"
   " and CRLs).\n"
-#endif /* ENABLE_CRYPTO_POLARSSL */
+#endif /* ENABLE_CRYPTO_MBEDTLS */
   "--dh file       : File containing Diffie Hellman parameters\n"
   "                  in .pem format (for --tls-server only).\n"
   "                  Use \"openssl dhparam -out dh1024.pem 1024\" to generate.\n"
@@ -565,7 +565,7 @@ static const char usage_message[] =
   "    will accept from the peer.  If version is unrecognized and 'or-highest'\n"
   "    is specified, require max TLS version supported by SSL implementation.\n"
   "--tls-version-max <version> : sets the maximum TLS version we will use.\n"
-#ifndef ENABLE_CRYPTO_POLARSSL
+#ifndef ENABLE_CRYPTO_MBEDTLS
   "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
   "                  and optionally the root CA certificate.\n"
 #endif
@@ -1569,9 +1569,9 @@ show_settings (const struct options *o)
   SHOW_STR (prng_hash);
   SHOW_INT (prng_nonce_secret_len);
   SHOW_INT (keysize);
-#ifndef ENABLE_CRYPTO_POLARSSL
+#ifndef ENABLE_CRYPTO_MBEDTLS
   SHOW_BOOL (engine);
-#endif /* ENABLE_CRYPTO_POLARSSL */
+#endif /* ENABLE_CRYPTO_MBEDTLS */
   SHOW_BOOL (replay);
   SHOW_BOOL (mute_replay_warnings);
   SHOW_INT (replay_window);
@@ -1603,7 +1603,7 @@ show_settings (const struct options *o)
   else
 #endif
   SHOW_STR (priv_key_file);
-#ifndef ENABLE_CRYPTO_POLARSSL
+#ifndef ENABLE_CRYPTO_MBEDTLS
   SHOW_STR (pkcs12_file);
 #endif
 #ifdef ENABLE_CRYPTOAPI
@@ -2216,8 +2216,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 #endif
       if (options->pkcs12_file)
         {
-#ifdef ENABLE_CRYPTO_POLARSSL
-	  msg(M_USAGE, "Parameter --pkcs12 cannot be used with the PolarSSL version version of OpenVPN.");
+#ifdef ENABLE_CRYPTO_MBEDTLS
+	  msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed TLS version version of OpenVPN.");
 #else
           if (options->ca_path)
 	    msg(M_USAGE, "Parameter --capath cannot be used when --pkcs12 is also specified.");
@@ -2235,11 +2235,11 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
         }
       else
         {
-#ifdef ENABLE_CRYPTO_POLARSSL
+#ifdef ENABLE_CRYPTO_MBEDTLS
 	  if (!(options->ca_file))
 	    msg(M_USAGE, "You must define CA file (--ca)");
           if (options->ca_path)
-            msg(M_USAGE, "Parameter --capath cannot be used with the PolarSSL version version of OpenVPN.");
+            msg(M_USAGE, "Parameter --capath cannot be used with the mbed TLS version version of OpenVPN.");
 #else
 	  if ((!(options->ca_file)) && (!(options->ca_path)))
 	    msg(M_USAGE, "You must define CA file (--ca) or CA path (--capath)");
@@ -2298,7 +2298,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       MUST_BE_UNDEF (dh_file);
       MUST_BE_UNDEF (cert_file);
       MUST_BE_UNDEF (priv_key_file);
-#ifndef ENABLE_CRYPTO_POLARSSL
+#ifndef ENABLE_CRYPTO_MBEDTLS
       MUST_BE_UNDEF (pkcs12_file);
 #endif
       MUST_BE_UNDEF (cipher_list);
@@ -6555,7 +6555,7 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->test_crypto = true;
     }
-#ifndef ENABLE_CRYPTO_POLARSSL
+#ifndef ENABLE_CRYPTO_MBEDTLS
   else if (streq (p[0], "engine") && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6566,7 +6566,7 @@ add_option (struct options *options,
       else
 	options->engine = "auto";
     }  
-#endif /* ENABLE_CRYPTO_POLARSSL */
+#endif /* ENABLE_CRYPTO_MBEDTLS */
 #ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
   else if (streq (p[0], "keysize") && p[1] && !p[2])
     {
@@ -6623,13 +6623,13 @@ add_option (struct options *options,
 	  options->ca_file_inline = p[2];
 	}
     }
-#ifndef ENABLE_CRYPTO_POLARSSL
+#ifndef ENABLE_CRYPTO_MBEDTLS
   else if (streq (p[0], "capath") && p[1] && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->ca_path = p[1];
     }
-#endif /* ENABLE_CRYPTO_POLARSSL */
+#endif /* ENABLE_CRYPTO_MBEDTLS */
   else if (streq (p[0], "dh") && p[1] && ((streq (p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6706,7 +6706,7 @@ add_option (struct options *options,
 	  ~(SSLF_TLS_VERSION_MAX_MASK << SSLF_TLS_VERSION_MAX_SHIFT);
       options->ssl_flags |= (ver << SSLF_TLS_VERSION_MAX_SHIFT);
     }
-#ifndef ENABLE_CRYPTO_POLARSSL
+#ifndef ENABLE_CRYPTO_MBEDTLS
   else if (streq (p[0], "pkcs12") && p[1] && ((streq (p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6716,7 +6716,7 @@ add_option (struct options *options,
 	  options->pkcs12_file_inline = p[2];
 	}
     }
-#endif /* ENABLE_CRYPTO_POLARSSL */
+#endif /* ENABLE_CRYPTO_MBEDTLS */
   else if (streq (p[0], "askpass") && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6784,7 +6784,7 @@ add_option (struct options *options,
 		       string_substitute (p[1], ',', ' ', &options->gc),
 		       "tls-verify", true);
     }
-#ifndef ENABLE_CRYPTO_POLARSSL
+#ifndef ENABLE_CRYPTO_MBEDTLS
   else if (streq (p[0], "tls-export-cert") && p[1] && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index ffbe5e1..18d8376 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -78,8 +78,8 @@ struct options_pre_pull
 };
 
 #endif
-#if defined(ENABLE_CRYPTO) && !defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_POLARSSL)
-# error "At least one of OpenSSL or PolarSSL needs to be defined."
+#if defined(ENABLE_CRYPTO) && !defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_MBEDTLS)
+# error "At least one of OpenSSL or mbed TLS needs to be defined."
 #endif
 
 struct connection_entry
diff --git a/src/openvpn/pkcs11_polarssl.c b/src/openvpn/pkcs11_polarssl.c
index ccb6f8c..e208b61 100644
--- a/src/openvpn/pkcs11_polarssl.c
+++ b/src/openvpn/pkcs11_polarssl.c
@@ -24,7 +24,7 @@
  */
 
 /**
- * @file PKCS #11 PolarSSL backend
+ * @file PKCS #11 mbed TLS backend
  */
 
 #ifdef HAVE_CONFIG_H
@@ -35,12 +35,12 @@
 
 #include "syshead.h"
 
-#if defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_POLARSSL)
+#if defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_MBEDTLS)
 
 #include "errlevel.h"
 #include "pkcs11_backend.h"
-#include <polarssl/pkcs11.h>
-#include <polarssl/x509.h>
+#include <mbedtls/pkcs11.h>
+#include <mbedtls/x509.h>
 
 int
 pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
@@ -50,21 +50,22 @@ pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
 
   ASSERT (NULL != ssl_ctx);
 
-  ALLOC_OBJ_CLEAR (ssl_ctx->crt_chain, x509_crt);
-  if (pkcs11_x509_cert_init(ssl_ctx->crt_chain, certificate)) {
-      msg (M_FATAL, "PKCS#11: Cannot retrieve PolarSSL certificate object");
+  ALLOC_OBJ_CLEAR (ssl_ctx->crt_chain, mbedtls_x509_crt);
+  if (mbedtls_pkcs11_x509_cert_bind(ssl_ctx->crt_chain, certificate)) {
+      msg (M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
       goto cleanup;
   }
 
-  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key_pkcs11, pkcs11_context);
-  if (pkcs11_priv_key_init(ssl_ctx->priv_key_pkcs11, certificate)) {
-      msg (M_FATAL, "PKCS#11: Cannot initialize PolarSSL private key object");
+  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key_pkcs11, mbedtls_pkcs11_context);
+  if (mbedtls_pkcs11_priv_key_bind(ssl_ctx->priv_key_pkcs11, certificate)) {
+      msg (M_FATAL, "PKCS#11: Cannot initialize mbed TLS private key object");
       goto cleanup;
   }
 
-  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key, pk_context);
-  if (!polar_ok(pk_init_ctx_rsa_alt(ssl_ctx->priv_key, ssl_ctx->priv_key_pkcs11,
-	ssl_pkcs11_decrypt, ssl_pkcs11_sign, ssl_pkcs11_key_len))) {
+  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key, mbedtls_pk_context);
+  if (!mbed_ok(mbedtls_pk_setup_rsa_alt(ssl_ctx->priv_key,
+      ssl_ctx->priv_key_pkcs11, mbedtls_ssl_pkcs11_decrypt,
+      mbedtls_ssl_pkcs11_sign, mbedtls_ssl_pkcs11_key_len))) {
       goto cleanup;
   }
 
@@ -80,22 +81,22 @@ pkcs11_certificate_dn (pkcs11h_certificate_t cert, struct gc_arena *gc)
   char *ret = NULL;
   char dn[1024] = {0};
 
-  x509_crt polar_cert = {0};
+  mbedtls_x509_crt mbed_crt = {0};
 
-  if (pkcs11_x509_cert_init(&polar_cert, cert)) {
-      msg (M_FATAL, "PKCS#11: Cannot retrieve PolarSSL certificate object");
+  if (mbedtls_pkcs11_x509_cert_bind(&mbed_crt, cert)) {
+      msg (M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
       goto cleanup;
   }
 
-  if (-1 == x509_dn_gets (dn, sizeof(dn), &polar_cert.subject)) {
-      msg (M_FATAL, "PKCS#11: PolarSSL cannot parse subject");
+  if (-1 == mbedtls_x509_dn_gets (dn, sizeof(dn), &mbed_crt.subject)) {
+      msg (M_FATAL, "PKCS#11: mbed TLS cannot parse subject");
       goto cleanup;
   }
 
   ret = string_alloc(dn, gc);
 
 cleanup:
-  x509_crt_free(&polar_cert);
+  mbedtls_x509_crt_free(&mbed_crt);
 
   return ret;
 }
@@ -106,23 +107,23 @@ pkcs11_certificate_serial (pkcs11h_certificate_t cert, char *serial,
 {
   int ret = 1;
 
-  x509_crt polar_cert = {0};
+  mbedtls_x509_crt mbed_crt = {0};
 
-  if (pkcs11_x509_cert_init(&polar_cert, cert)) {
-      msg (M_FATAL, "PKCS#11: Cannot retrieve PolarSSL certificate object");
+  if (mbedtls_pkcs11_x509_cert_bind(&mbed_crt, cert)) {
+      msg (M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
       goto cleanup;
   }
 
-  if (-1 == x509_serial_gets (serial, serial_len, &polar_cert.serial)) {
-      msg (M_FATAL, "PKCS#11: PolarSSL cannot parse serial");
+  if (-1 == mbedtls_x509_serial_gets (serial, serial_len, &mbed_crt.serial)) {
+      msg (M_FATAL, "PKCS#11: mbed TLS cannot parse serial");
       goto cleanup;
   }
 
   ret = 0;
 
 cleanup:
-  x509_crt_free(&polar_cert);
+  mbedtls_x509_crt_free(&mbed_crt);
 
   return ret;
 }
-#endif /* defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_POLARSSL) */
+#endif /* defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 77b6e81..74ac8b1 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -32,7 +32,7 @@
 #ifdef ENABLE_CRYPTO_OPENSSL
 #include "ssl_verify_openssl.h"
 #endif
-#ifdef ENABLE_CRYPTO_POLARSSL
+#ifdef ENABLE_CRYPTO_MBEDTLS
 #include "ssl_verify_polarssl.h"
 #endif
 #include "openvpn-plugin.h"
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d1a6fa8..ddd0c9b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -591,7 +591,7 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
   /* Allowable ciphers */
   tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
 
-#ifdef ENABLE_CRYPTO_POLARSSL
+#ifdef ENABLE_CRYPTO_MBEDTLS
   /* Personalise the random by mixing in the certificate */
   tls_ctx_personalise_random (new_ctx);
 #endif
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index ac28f5f..dfccb44 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -38,10 +38,10 @@
 #include "ssl_verify_openssl.h"
 #define SSLAPI SSLAPI_OPENSSL
 #endif
-#ifdef ENABLE_CRYPTO_POLARSSL
+#ifdef ENABLE_CRYPTO_MBEDTLS
 #include "ssl_polarssl.h"
 #include "ssl_verify_polarssl.h"
-#define SSLAPI SSLAPI_POLARSSL
+#define SSLAPI SSLAPI_MBEDTLS
 #endif
 
 /* Ensure that SSLAPI got a sane value if SSL is disabled or unknown */
@@ -308,9 +308,9 @@ void tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs
     const char *extra_certs_file_inline
     );
 
-#ifdef ENABLE_CRYPTO_POLARSSL
+#ifdef ENABLE_CRYPTO_MBEDTLS
 /**
- * Add a personalisation string to the PolarSSL RNG, based on the certificate
+ * Add a personalisation string to the mbed TLS RNG, based on the certificate
  * loaded into the given context.
  *
  * @param ctx			TLS context to use
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 58b2116..483ec1c 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -25,7 +25,7 @@
  */
 
 /**
- * @file Control Channel PolarSSL Backend
+ * @file Control Channel mbed TLS Backend
  */
 
 #ifdef HAVE_CONFIG_H
@@ -36,7 +36,7 @@
 
 #include "syshead.h"
 
-#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_POLARSSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
 
 #include "errlevel.h"
 #include "ssl_backend.h"
@@ -46,15 +46,16 @@
 #include "manage.h"
 #include "ssl_common.h"
 
-#include <polarssl/havege.h>
+#include <mbedtls/havege.h>
 
 #include "ssl_verify_polarssl.h"
-#include <polarssl/debug.h>
-#include <polarssl/error.h>
-#include <polarssl/oid.h>
-#include <polarssl/pem.h>
-#include <polarssl/sha256.h>
-#include <polarssl/version.h>
+#include <mbedtls/debug.h>
+#include <mbedtls/error.h>
+#include <mbedtls/net.h>
+#include <mbedtls/oid.h>
+#include <mbedtls/pem.h>
+#include <mbedtls/sha256.h>
+#include <mbedtls/version.h>
 
 void
 tls_init_lib()
@@ -77,11 +78,11 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
   ASSERT(NULL != ctx);
   CLEAR(*ctx);
 
-  ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
+  ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
 
-  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_crt);
+  ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 
-  ctx->endpoint = SSL_IS_SERVER;
+  ctx->endpoint = MBEDTLS_SSL_IS_SERVER;
   ctx->initialised = true;
 }
 
@@ -91,10 +92,10 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
   ASSERT(NULL != ctx);
   CLEAR(*ctx);
 
-  ALLOC_OBJ_CLEAR(ctx->dhm_ctx, dhm_context);
-  ALLOC_OBJ_CLEAR(ctx->ca_chain, x509_crt);
+  ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
+  ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 
-  ctx->endpoint = SSL_IS_CLIENT;
+  ctx->endpoint = MBEDTLS_SSL_IS_CLIENT;
   ctx->initialised = true;
 }
 
@@ -103,25 +104,25 @@ tls_ctx_free(struct tls_root_ctx *ctx)
 {
   if (ctx)
     {
-      pk_free(ctx->priv_key);
+      mbedtls_pk_free(ctx->priv_key);
       if (ctx->priv_key)
 	free(ctx->priv_key);
 
-      x509_crt_free(ctx->ca_chain);
+      mbedtls_x509_crt_free(ctx->ca_chain);
       if (ctx->ca_chain)
 	free(ctx->ca_chain);
 
-      x509_crt_free(ctx->crt_chain);
+      mbedtls_x509_crt_free(ctx->crt_chain);
       if (ctx->crt_chain)
 	free(ctx->crt_chain);
 
-      dhm_free(ctx->dhm_ctx);
+      mbedtls_dhm_free(ctx->dhm_ctx);
       if (ctx->dhm_ctx)
 	free(ctx->dhm_ctx);
 
 #if defined(ENABLE_PKCS11)
       if (ctx->priv_key_pkcs11 != NULL) {
-	  pkcs11_priv_key_free(ctx->priv_key_pkcs11);
+	  mbedtls_pkcs11_priv_key_free(ctx->priv_key_pkcs11);
 	  free(ctx->priv_key_pkcs11);
       }
 #endif
@@ -207,7 +208,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
   token = strtok (tmp_ciphers, ":");
   while(token)
     {
-      ctx->allowed_ciphers[i] = ssl_get_ciphersuite_id (
+      ctx->allowed_ciphers[i] = mbedtls_ssl_get_ciphersuite_id (
 	  tls_translate_cipher_name (token));
       if (0 != ctx->allowed_ciphers[i])
 	i++;
@@ -225,12 +226,12 @@ tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
       return; /* Nothing to check if there is no certificate */
     }
 
-  if (x509_time_future (&ctx->crt_chain->valid_from))
+  if (mbedtls_x509_time_is_future (&ctx->crt_chain->valid_from))
     {
       msg (M_WARN, "WARNING: Your certificate is not yet valid!");
     }
 
-  if (x509_time_expired (&ctx->crt_chain->valid_to))
+  if (mbedtls_x509_time_is_past (&ctx->crt_chain->valid_to))
     {
       msg (M_WARN, "WARNING: Your certificate has expired!");
     }
@@ -243,18 +244,18 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
 {
   if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_inline)
     {
-      if (!polar_ok(dhm_parse_dhm(ctx->dhm_ctx,
-	  (const unsigned char *) dh_inline, strlen(dh_inline))))
+      if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx->dhm_ctx,
+	  (const unsigned char *) dh_inline, strlen(dh_inline)+1)))
 	msg (M_FATAL, "Cannot read inline DH parameters");
   }
 else
   {
-    if (!polar_ok(dhm_parse_dhmfile(ctx->dhm_ctx, dh_file)))
+    if (!mbed_ok(mbedtls_dhm_parse_dhmfile(ctx->dhm_ctx, dh_file)))
       msg (M_FATAL, "Cannot read DH parameters from file %s", dh_file);
   }
 
   msg (D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with " counter_format " bit key",
-      (counter_type) 8 * mpi_size(&ctx->dhm_ctx->P));
+      (counter_type) 8 * mbedtls_mpi_size(&ctx->dhm_ctx->P));
 }
 
 void
@@ -262,7 +263,7 @@ tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char *curve_name
     )
 {
     if (NULL != curve_name)
-      msg(M_WARN, "WARNING: PolarSSL builds do not support specifying an ECDH "
+      msg(M_WARN, "WARNING: mbed TLS builds do not support specifying an ECDH "
                   "curve, using default curves.");
 }
 
@@ -272,7 +273,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
     bool load_ca_file
     )
 {
-  msg(M_FATAL, "PKCS #12 files not yet supported for PolarSSL.");
+  msg(M_FATAL, "PKCS #12 files not yet supported for mbed TLS.");
   return 0;
 }
 
@@ -280,7 +281,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 void
 tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 {
-  msg(M_FATAL, "Windows CryptoAPI not yet supported for PolarSSL.");
+  msg(M_FATAL, "Windows CryptoAPI not yet supported for mbed TLS.");
 }
 #endif /* WIN32 */
 
@@ -293,18 +294,18 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
 
   if (!ctx->crt_chain)
     {
-      ALLOC_OBJ_CLEAR(ctx->crt_chain, x509_crt);
+      ALLOC_OBJ_CLEAR(ctx->crt_chain, mbedtls_x509_crt);
     }
 
   if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_inline)
     {
-      if (!polar_ok(x509_crt_parse(ctx->crt_chain,
-	  (const unsigned char *) cert_inline, strlen(cert_inline))))
+      if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain,
+	  (const unsigned char *) cert_inline, strlen(cert_inline)+1)))
         msg (M_FATAL, "Cannot load inline certificate file");
     }
   else
     {
-      if (!polar_ok(x509_crt_parse_file(ctx->crt_chain, cert_file)))
+      if (!mbed_ok(mbedtls_x509_crt_parse_file(ctx->crt_chain, cert_file)))
 	{
 	  msg (M_FATAL, "Cannot load certificate file %s", cert_file);
 	}
@@ -321,38 +322,39 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
 
   if (!ctx->priv_key)
     {
-      ALLOC_OBJ_CLEAR(ctx->priv_key, pk_context);
+      ALLOC_OBJ_CLEAR(ctx->priv_key, mbedtls_pk_context);
     }
 
   if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_inline)
     {
-      status = pk_parse_key(ctx->priv_key,
-	  (const unsigned char *) priv_key_inline, strlen(priv_key_inline),
+      status = mbedtls_pk_parse_key(ctx->priv_key,
+	  (const unsigned char *) priv_key_inline, strlen(priv_key_inline)+1,
 	  NULL, 0);
 
-      if (POLARSSL_ERR_PK_PASSWORD_REQUIRED == status)
+      if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
 	{
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
-	  status = pk_parse_key(ctx->priv_key,
-	      (const unsigned char *) priv_key_inline, strlen(priv_key_inline),
-	      (unsigned char *) passbuf, strlen(passbuf));
+	  status = mbedtls_pk_parse_key(ctx->priv_key,
+	      (const unsigned char *) priv_key_inline,
+	      strlen(priv_key_inline)+1, (unsigned char *) passbuf,
+	      strlen(passbuf));
 	}
     }
   else
     {
-      status = pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);
-      if (POLARSSL_ERR_PK_PASSWORD_REQUIRED == status)
+      status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);
+      if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
 	{
 	  char passbuf[512] = {0};
 	  pem_password_callback(passbuf, 512, 0, NULL);
-	  status = pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
+	  status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
 	}
     }
-  if (!polar_ok(status))
+  if (!mbed_ok(status))
     {
 #ifdef ENABLE_MANAGEMENT
-      if (management && (POLARSSL_ERR_PK_PASSWORD_MISMATCH == status))
+      if (management && (MBEDTLS_ERR_PK_PASSWORD_MISMATCH == status))
 	  management_auth_failure (management, UP_TYPE_PRIVATE_KEY, NULL);
 #endif
       msg (M_WARN, "Cannot load private key file %s", priv_key_file);
@@ -377,7 +379,7 @@ struct external_context {
 };
 
 /**
- * external_pkcs1_sign implements a PolarSSL rsa_sign_func callback, that uses
+ * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that uses
  * the management interface to request an RSA signature for the supplied hash.
  *
  * @param ctx_voidptr   Management external key context.
@@ -386,18 +388,18 @@ struct external_context {
  * @param mode          RSA mode (should be RSA_PRIVATE).
  * @param md_alg        Message digest ('hash') algorithm type.
  * @param hashlen       Length of hash (overridden by length specified by md_alg
- *                      if md_alg != POLARSSL_MD_NONE).
+ *                      if md_alg != MBEDTLS_MD_NONE).
  * @param hash          The digest ('hash') to sign. Should have a size
- *                      matching the length of md_alg (if != POLARSSL_MD_NONE),
+ *                      matching the length of md_alg (if != MBEDTLS_MD_NONE),
  *                      or hashlen otherwise.
  * @param sig           Buffer that returns the signature. Should be at least of
  *                      size ctx->signature_length.
  *
- * @return 0 on success, non-zero polarssl error code on failure.
+ * @return 0 on success, non-zero mbed TLS error code on failure.
  */
 static inline int external_pkcs1_sign( void *ctx_voidptr,
     int (*f_rng)(void *, unsigned char *, size_t), void *p_rng, int mode,
-    md_type_t md_alg, unsigned int hashlen, const unsigned char *hash,
+    mbedtls_md_type_t md_alg, unsigned int hashlen, const unsigned char *hash,
     unsigned char *sig )
 {
   struct external_context * const ctx = ctx_voidptr;
@@ -409,35 +411,35 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
   const char *oid = NULL;
 
   if( NULL == ctx )
-    return POLARSSL_ERR_RSA_BAD_INPUT_DATA;
+    return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
 
-  if( RSA_PRIVATE != mode )
-    return POLARSSL_ERR_RSA_BAD_INPUT_DATA;
+  if( MBEDTLS_RSA_PRIVATE != mode )
+    return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
 
   /*
    * Support a wide range of hashes. TLSv1.1 and before only need SIG_RSA_RAW,
    * but TLSv1.2 needs the full suite of hashes.
    *
-   * This code has been taken from PolarSSL pkcs11_sign(), under the GPLv2.0+.
+   * This code has been taken from mbed TLS pkcs11_sign(), under the GPLv2.0+.
    */
-  if( md_alg != POLARSSL_MD_NONE )
+  if( md_alg != MBEDTLS_MD_NONE )
     {
-      const md_info_t *md_info = md_info_from_type( md_alg );
+      const mbedtls_md_info_t *md_info = mbedtls_md_info_from_type( md_alg );
       if( md_info == NULL )
-        return( POLARSSL_ERR_RSA_BAD_INPUT_DATA );
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
 
-      if (!polar_ok(oid_get_oid_by_md( md_alg, &oid, &oid_size )))
-        return( POLARSSL_ERR_RSA_BAD_INPUT_DATA );
+      if (!mbed_ok(mbedtls_oid_get_oid_by_md( md_alg, &oid, &oid_size )))
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
 
-      hashlen = md_get_size( md_info );
+      hashlen = mbedtls_md_get_size( md_info );
       asn_len = 10 + oid_size;
     }
 
   sig_len = ctx->signature_length;
   if ( (SIZE_MAX - hashlen) < asn_len || (hashlen + asn_len) > sig_len )
-    return POLARSSL_ERR_RSA_BAD_INPUT_DATA;
+    return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
 
-  if( md_alg != POLARSSL_MD_NONE )
+  if( md_alg != MBEDTLS_MD_NONE )
     {
       /*
        * DigestInfo ::= SEQUENCE {
@@ -448,17 +450,17 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
        *
        * Digest ::= OCTET STRING
        */
-      *p++ = ASN1_SEQUENCE | ASN1_CONSTRUCTED;
+      *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
       *p++ = (unsigned char) ( 0x08 + oid_size + hashlen );
-      *p++ = ASN1_SEQUENCE | ASN1_CONSTRUCTED;
+      *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
       *p++ = (unsigned char) ( 0x04 + oid_size );
-      *p++ = ASN1_OID;
+      *p++ = MBEDTLS_ASN1_OID;
       *p++ = oid_size & 0xFF;
       memcpy( p, oid, oid_size );
       p += oid_size;
-      *p++ = ASN1_NULL;
+      *p++ = MBEDTLS_ASN1_NULL;
       *p++ = 0x00;
-      *p++ = ASN1_OCTET_STRING;
+      *p++ = MBEDTLS_ASN1_OCTET_STRING;
       *p++ = hashlen;
 
       /* Determine added ASN length */
@@ -471,7 +473,7 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
   /* convert 'from' to base64 */
   if (openvpn_base64_encode (sig, asn_len + hashlen, &in_b64) <= 0)
     {
-      rv = POLARSSL_ERR_RSA_BAD_INPUT_DATA;
+      rv = MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
       goto done;
     }
 
@@ -480,7 +482,7 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
     out_b64 = management_query_rsa_sig (management, in_b64);
   if (!out_b64)
     {
-      rv = POLARSSL_ERR_RSA_PRIVATE_FAILED;
+      rv = MBEDTLS_ERR_RSA_PRIVATE_FAILED;
       goto done;
     }
 
@@ -488,7 +490,7 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
   if ( openvpn_base64_decode (out_b64, sig, ctx->signature_length) !=
        ctx->signature_length )
     {
-      rv = POLARSSL_ERR_RSA_PRIVATE_FAILED;
+      rv = MBEDTLS_ERR_RSA_PRIVATE_FAILED;
       goto done;
     }
 
@@ -521,10 +523,10 @@ tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
     return 0;
 
   ALLOC_OBJ_CLEAR (ctx->external_key, struct external_context);
-  ctx->external_key->signature_length = pk_get_len(&ctx->crt_chain->pk);
+  ctx->external_key->signature_length = mbedtls_pk_get_len (&ctx->crt_chain->pk);
 
-  ALLOC_OBJ_CLEAR (ctx->priv_key, pk_context);
-  if (!polar_ok(pk_init_ctx_rsa_alt(ctx->priv_key, ctx->external_key,
+  ALLOC_OBJ_CLEAR (ctx->priv_key, mbedtls_pk_context);
+  if (!mbed_ok (mbedtls_pk_setup_rsa_alt (ctx->priv_key, ctx->external_key,
 	    NULL, external_pkcs1_sign, external_key_len)))
     return 0;
 
@@ -537,18 +539,18 @@ void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
     )
 {
   if (ca_path)
-      msg(M_FATAL, "ERROR: PolarSSL cannot handle the capath directive");
+      msg(M_FATAL, "ERROR: mbed TLS cannot handle the capath directive");
 
   if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_inline)
     {
-      if (!polar_ok(x509_crt_parse(ctx->ca_chain,
-	  (const unsigned char *) ca_inline, strlen(ca_inline))))
+      if (!mbed_ok (mbedtls_x509_crt_parse (ctx->ca_chain,
+	  (const unsigned char *) ca_inline, strlen(ca_inline)+1)))
 	msg (M_FATAL, "Cannot load inline CA certificates");
     }
   else
     {
       /* Load CA file for verifying peer supplied certificate */
-      if (!polar_ok(x509_crt_parse_file(ctx->ca_chain, ca_file)))
+      if (!mbed_ok (mbedtls_x509_crt_parse_file (ctx->ca_chain, ca_file)))
 	msg (M_FATAL, "Cannot load CA certificate file %s", ca_file);
     }
 }
@@ -562,19 +564,19 @@ tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file
 
   if (!ctx->crt_chain)
     {
-      ALLOC_OBJ_CLEAR (ctx->crt_chain, x509_crt);
+      ALLOC_OBJ_CLEAR (ctx->crt_chain, mbedtls_x509_crt);
     }
 
   if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_inline)
     {
-      if (!polar_ok(x509_crt_parse(ctx->crt_chain,
+      if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain,
           (const unsigned char *) extra_certs_inline,
-	  strlen(extra_certs_inline))))
+	  strlen(extra_certs_inline)+1)))
         msg (M_FATAL, "Cannot load inline extra-certs file");
     }
   else
     {
-      if (!polar_ok(x509_crt_parse_file(ctx->crt_chain, extra_certs_file)))
+      if (!mbed_ok(mbedtls_x509_crt_parse_file(ctx->crt_chain, extra_certs_file)))
 	msg (M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
     }
 }
@@ -609,13 +611,12 @@ static void buf_free_entries(endless_buffer *buf)
   buf->last_block = NULL;
 }
 
-static int endless_buf_read( void * ctx, unsigned char * out, size_t out_len )
+static int endless_buf_read( endless_buffer *in, unsigned char * out, size_t out_len )
 {
-  endless_buffer *in = (endless_buffer *) ctx;
   size_t read_len = 0;
 
   if (in->first_block == NULL)
-    return POLARSSL_ERR_NET_WANT_READ;
+    return MBEDTLS_ERR_SSL_WANT_READ;
 
   while (in->first_block != NULL && read_len < out_len)
     {
@@ -648,18 +649,17 @@ static int endless_buf_read( void * ctx, unsigned char * out, size_t out_len )
   return read_len;
 }
 
-static int endless_buf_write( void *ctx, const unsigned char *in, size_t len )
+static int endless_buf_write( endless_buffer *out, const unsigned char *in, size_t len )
 {
-  endless_buffer *out = (endless_buffer *) ctx;
   buffer_entry *new_block = malloc(sizeof(buffer_entry));
   if (NULL == new_block)
-    return POLARSSL_ERR_NET_SEND_FAILED;
+    return MBEDTLS_ERR_NET_SEND_FAILED;
 
   new_block->data = malloc(len);
   if (NULL == new_block->data)
     {
       free(new_block);
-      return POLARSSL_ERR_NET_SEND_FAILED;
+      return MBEDTLS_ERR_NET_SEND_FAILED;
     }
 
   new_block->length = len;
@@ -678,10 +678,23 @@ static int endless_buf_write( void *ctx, const unsigned char *in, size_t len )
   return len;
 }
 
-static void my_debug( void *ctx, int level, const char *str )
+static int ssl_bio_read( void *ctx, unsigned char *out, size_t out_len)
+{
+  bio_ctx *my_ctx = (bio_ctx *) ctx;
+  return endless_buf_read (&my_ctx->in, out, out_len);
+}
+
+static int ssl_bio_write( void *ctx, const unsigned char *in, size_t in_len)
+{
+  bio_ctx *my_ctx = (bio_ctx *) ctx;
+  return endless_buf_write (&my_ctx->out, in, in_len);
+}
+
+static void my_debug( void *ctx, int level, const char *file, int line,
+    const char *str )
 {
   int my_loglevel = (level < 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;
-  msg (my_loglevel, "PolarSSL msg: %s", str);
+  msg (my_loglevel, "mbed TLS msg (%s:%d): %s", file, line, str);
 }
 
 /*
@@ -691,16 +704,16 @@ void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 {
   static char old_sha256_hash[32] = {0};
   unsigned char sha256_hash[32] = {0};
-  ctr_drbg_context *cd_ctx = rand_ctx_get();
+  mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
 
   if (NULL != ctx->crt_chain)
     {
-      x509_crt *cert = ctx->crt_chain;
+      mbedtls_x509_crt *cert = ctx->crt_chain;
 
-      sha256(cert->tbs.p, cert->tbs.len, sha256_hash, false);
+      mbedtls_sha256(cert->tbs.p, cert->tbs.len, sha256_hash, false);
       if ( 0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
 	{
-	  ctr_drbg_update(cd_ctx, sha256_hash, 32);
+	  mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32);
 	  memcpy(old_sha256_hash, sha256_hash, sizeof(old_sha256_hash));
 	}
     }
@@ -719,13 +732,13 @@ tls_version_max(void)
 }
 
 /**
- * Convert an OpenVPN tls-version variable to PolarSSl format (i.e. a major and
+ * Convert an OpenVPN tls-version variable to mbed TLS format (i.e. a major and
  * minor ssl version number).
  *
  * @param tls_ver	The tls-version variable to convert.
- * @param major		Returns the TLS major version in polarssl format.
+ * @param major		Returns the TLS major version in mbed TLS format.
  * 			Must be a valid pointer.
- * @param minor		Returns the TLS minor version in polarssl format.
+ * @param minor		Returns the TLS minor version in mbed TLS format.
  * 			Must be a valid pointer.
  */
 static void tls_version_to_major_minor(int tls_ver, int *major, int *minor) {
@@ -735,16 +748,16 @@ static void tls_version_to_major_minor(int tls_ver, int *major, int *minor) {
   switch (tls_ver)
   {
     case TLS_VER_1_0:
-      *major = SSL_MAJOR_VERSION_3;
-      *minor = SSL_MINOR_VERSION_1;
+      *major = MBEDTLS_SSL_MAJOR_VERSION_3;
+      *minor = MBEDTLS_SSL_MINOR_VERSION_1;
       break;
     case TLS_VER_1_1:
-      *major = SSL_MAJOR_VERSION_3;
-      *minor = SSL_MINOR_VERSION_2;
+      *major = MBEDTLS_SSL_MAJOR_VERSION_3;
+      *minor = MBEDTLS_SSL_MINOR_VERSION_2;
       break;
     case TLS_VER_1_2:
-      *major = SSL_MAJOR_VERSION_3;
-      *minor = SSL_MINOR_VERSION_3;
+      *major = MBEDTLS_SSL_MAJOR_VERSION_3;
+      *minor = MBEDTLS_SSL_MINOR_VERSION_3;
       break;
     default:
       msg(M_FATAL, "%s: invalid TLS version %d", __func__, tls_ver);
@@ -759,86 +772,90 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
   ASSERT(ks_ssl);
   CLEAR(*ks_ssl);
 
-  ALLOC_OBJ_CLEAR(ks_ssl->ctx, ssl_context);
-  if (polar_ok(ssl_init(ks_ssl->ctx)))
+  /* Initialise SSL config */
+  mbedtls_ssl_config_init(&ks_ssl->ssl_config);
+  mbedtls_ssl_config_defaults(&ks_ssl->ssl_config, ssl_ctx->endpoint,
+      MBEDTLS_SSL_TRANSPORT_STREAM, MBEDTLS_SSL_PRESET_DEFAULT);
+  mbedtls_debug_set_threshold(3);
+  mbedtls_ssl_conf_dbg (&ks_ssl->ssl_config, my_debug, NULL);
+  mbedtls_ssl_conf_rng (&ks_ssl->ssl_config, mbedtls_ctr_drbg_random,
+      rand_ctx_get());
+
+  if (ssl_ctx->allowed_ciphers)
+    mbedtls_ssl_conf_ciphersuites (&ks_ssl->ssl_config, ssl_ctx->allowed_ciphers);
+
+  /* Disable record splitting (for now).  OpenVPN assumes records are sent
+   * unfragmented, and changing that will require thorough review and
+   * testing.  Since OpenVPN is not susceptible to BEAST, we can just
+   * disable record splitting as a quick fix. */
+#if defined(MBEDTLS_SSL_CBC_RECORD_SPLITTING)
+  mbedtls_ssl_conf_cbc_record_splitting (&ks_ssl->ssl_config,
+      MBEDTLS_SSL_CBC_RECORD_SPLITTING_DISABLED);
+#endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */
+
+  /* Initialise authentication information */
+  if (is_server)
+    mbed_ok (mbedtls_ssl_conf_dh_param_ctx(&ks_ssl->ssl_config,
+	ssl_ctx->dhm_ctx));
+
+  mbed_ok (mbedtls_ssl_conf_own_cert(&ks_ssl->ssl_config, ssl_ctx->crt_chain,
+      ssl_ctx->priv_key));
+
+  /* Initialise SSL verification */
+#if P2MP_SERVER
+  if (session->opt->ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
     {
-      /* Initialise SSL context */
-      debug_set_threshold(3);
-      ssl_set_dbg (ks_ssl->ctx, my_debug, NULL);
-      ssl_set_endpoint (ks_ssl->ctx, ssl_ctx->endpoint);
-
-      ssl_set_rng (ks_ssl->ctx, ctr_drbg_random, rand_ctx_get());
+      mbedtls_ssl_conf_authmode(&ks_ssl->ssl_config, MBEDTLS_SSL_VERIFY_OPTIONAL);
+    }
+  else if (!(session->opt->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED))
+#endif
+  {
+    mbedtls_ssl_conf_authmode (&ks_ssl->ssl_config, MBEDTLS_SSL_VERIFY_REQUIRED);
+  }
+  mbedtls_ssl_conf_verify (&ks_ssl->ssl_config, verify_callback, session);
 
-      if (ssl_ctx->allowed_ciphers)
-	ssl_set_ciphersuites (ks_ssl->ctx, ssl_ctx->allowed_ciphers);
+  /* TODO: mbed TLS does not currently support sending the CA chain to the client */
+  mbedtls_ssl_conf_ca_chain (&ks_ssl->ssl_config, ssl_ctx->ca_chain, NULL );
 
-      /* Disable record splitting (for now).  OpenVPN assumes records are sent
-       * unfragmented, and changing that will require thorough review and
-       * testing.  Since OpenVPN is not susceptible to BEAST, we can just
-       * disable record splitting as a quick fix. */
-#if defined(POLARSSL_SSL_CBC_RECORD_SPLITTING)
-      ssl_set_cbc_record_splitting (ks_ssl->ctx, SSL_CBC_RECORD_SPLITTING_DISABLED);
-#endif /* POLARSSL_SSL_CBC_RECORD_SPLITTING */
+  /* Initialize minimum TLS version */
+  {
+    const int tls_version_min =
+	(session->opt->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) &
+	SSLF_TLS_VERSION_MIN_MASK;
 
-      /* Initialise authentication information */
-      if (is_server)
-	polar_ok(ssl_set_dh_param_ctx(ks_ssl->ctx, ssl_ctx->dhm_ctx));
+    /* default to TLS 1.0 */
+    int major = MBEDTLS_SSL_MAJOR_VERSION_3;
+    int minor = MBEDTLS_SSL_MINOR_VERSION_1;
 
-      polar_ok(ssl_set_own_cert(ks_ssl->ctx, ssl_ctx->crt_chain,
-	  ssl_ctx->priv_key));
+    if (tls_version_min > TLS_VER_UNSPEC)
+      tls_version_to_major_minor(tls_version_min, &major, &minor);
 
-      /* Initialise SSL verification */
-#if P2MP_SERVER
-      if (session->opt->ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
-	{
-	  ssl_set_authmode(ks_ssl->ctx, SSL_VERIFY_OPTIONAL);
-	}
-      else if (!(session->opt->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED))
-#endif
-      {
-	ssl_set_authmode (ks_ssl->ctx, SSL_VERIFY_REQUIRED);
-      }
-      ssl_set_verify (ks_ssl->ctx, verify_callback, session);
+    mbedtls_ssl_conf_min_version(&ks_ssl->ssl_config, major, minor);
+  }
 
-      /* TODO: PolarSSL does not currently support sending the CA chain to the client */
-      ssl_set_ca_chain (ks_ssl->ctx, ssl_ctx->ca_chain, NULL, NULL );
+  /* Initialize maximum TLS version */
+  {
+    const int tls_version_max =
+	(session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
+	SSLF_TLS_VERSION_MAX_MASK;
 
-      /* Initialize minimum TLS version */
+    if (tls_version_max > TLS_VER_UNSPEC)
       {
-	const int tls_version_min =
-	    (session->opt->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) &
-	    SSLF_TLS_VERSION_MIN_MASK;
-
-	/* default to TLS 1.0 */
-	int major = SSL_MAJOR_VERSION_3;
-	int minor = SSL_MINOR_VERSION_1;
-
-	if (tls_version_min > TLS_VER_UNSPEC)
-	  tls_version_to_major_minor(tls_version_min, &major, &minor);
-
-	ssl_set_min_version(ks_ssl->ctx, major, minor);
+	int major, minor;
+	tls_version_to_major_minor(tls_version_max, &major, &minor);
+	mbedtls_ssl_conf_max_version(&ks_ssl->ssl_config, major, minor);
       }
+  }
 
-      /* Initialize maximum TLS version */
-      {
-	const int tls_version_max =
-	    (session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
-	    SSLF_TLS_VERSION_MAX_MASK;
-
-	if (tls_version_max > TLS_VER_UNSPEC)
-	  {
-	    int major, minor;
-	    tls_version_to_major_minor(tls_version_max, &major, &minor);
-	    ssl_set_max_version(ks_ssl->ctx, major, minor);
-	  }
-      }
+  /* Initialise SSL context */
+  ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
+  mbedtls_ssl_init(ks_ssl->ctx);
+  mbedtls_ssl_setup(ks_ssl->ctx, &ks_ssl->ssl_config);
 
-      /* Initialise BIOs */
-      ALLOC_OBJ_CLEAR (ks_ssl->ct_in, endless_buffer);
-      ALLOC_OBJ_CLEAR (ks_ssl->ct_out, endless_buffer);
-      ssl_set_bio (ks_ssl->ctx, endless_buf_read, ks_ssl->ct_in,
-	  endless_buf_write, ks_ssl->ct_out);
-    }
+  /* Initialise BIOs */
+  CLEAR (ks_ssl->bio_ctx);
+  mbedtls_ssl_set_bio (ks_ssl->ctx, &ks_ssl->bio_ctx, ssl_bio_write,
+      ssl_bio_read, NULL);
 }
 
 void
@@ -847,17 +864,12 @@ key_state_ssl_free(struct key_state_ssl *ks_ssl)
   if (ks_ssl) {
       if (ks_ssl->ctx)
 	{
-	  ssl_free(ks_ssl->ctx);
+	  mbedtls_ssl_free(ks_ssl->ctx);
 	  free(ks_ssl->ctx);
 	}
-      if (ks_ssl->ct_in) {
-	buf_free_entries(ks_ssl->ct_in);
-	free(ks_ssl->ct_in);
-      }
-      if (ks_ssl->ct_out) {
-	buf_free_entries(ks_ssl->ct_out);
-	free(ks_ssl->ct_out);
-      }
+      mbedtls_ssl_config_free(&ks_ssl->ssl_config);
+      buf_free_entries(&ks_ssl->bio_ctx.in);
+      buf_free_entries(&ks_ssl->bio_ctx.out);
       CLEAR(*ks_ssl);
   }
 }
@@ -897,14 +909,14 @@ key_state_write_plaintext_const (struct key_state_ssl *ks, const uint8_t *data,
 
   ASSERT (data);
 
-  retval = ssl_write(ks->ctx, data, len);
+  retval = mbedtls_ssl_write(ks->ctx, data, len);
 
   if (retval < 0)
     {
       perf_pop ();
-      if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
+      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
 	return 0;
-      polar_log_err (D_TLS_ERRORS, retval,
+      mbed_log_err (D_TLS_ERRORS, retval,
 	  "TLS ERROR: write tls_write_plaintext_const error");
       return -1;
     }
@@ -948,15 +960,15 @@ key_state_read_ciphertext (struct key_state_ssl *ks, struct buffer *buf,
   if (maxlen < len)
     len = maxlen;
 
-  retval = endless_buf_read(ks->ct_out, BPTR(buf), len);
+  retval = endless_buf_read(&ks->bio_ctx.out, BPTR(buf), len);
 
   /* Error during read, check for retry error */
   if (retval < 0)
     {
       perf_pop ();
-      if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
+      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
 	return 0;
-      polar_log_err (D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_ciphertext error");
+      mbed_log_err (D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_ciphertext error");
       buf->len = 0;
       return -1;
     }
@@ -991,15 +1003,15 @@ key_state_write_ciphertext (struct key_state_ssl *ks, struct buffer *buf)
       return 0;
     }
 
-  retval = endless_buf_write(ks->ct_in, BPTR(buf), buf->len);
+  retval = endless_buf_write(&ks->bio_ctx.in, BPTR(buf), buf->len);
 
   if (retval < 0)
     {
       perf_pop ();
 
-      if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
+      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
 	return 0;
-      polar_log_err (D_TLS_ERRORS, retval,
+      mbed_log_err (D_TLS_ERRORS, retval,
 	  "TLS ERROR: write tls_write_ciphertext error");
       return -1;
     }
@@ -1045,14 +1057,14 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
   if (maxlen < len)
     len = maxlen;
 
-  retval = ssl_read(ks->ctx, BPTR(buf), len);
+  retval = mbedtls_ssl_read(ks->ctx, BPTR(buf), len);
 
   /* Error during read, check for retry error */
   if (retval < 0)
     {
-      if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
+      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
 	return 0;
-      polar_log_err (D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_plaintext error");
+      mbed_log_err (D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_plaintext error");
       buf->len = 0;
       perf_pop ();
       return -1;
@@ -1083,20 +1095,21 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
 void
 print_details (struct key_state_ssl * ks_ssl, const char *prefix)
 {
-  const x509_crt *cert;
+  const mbedtls_x509_crt *cert;
   char s1[256];
   char s2[256];
 
   s1[0] = s2[0] = 0;
   openvpn_snprintf (s1, sizeof (s1), "%s %s, cipher %s",
 		    prefix,
-		    ssl_get_version (ks_ssl->ctx),
-		    ssl_get_ciphersuite(ks_ssl->ctx));
+		    mbedtls_ssl_get_version (ks_ssl->ctx),
+		    mbedtls_ssl_get_ciphersuite (ks_ssl->ctx));
 
-  cert = ssl_get_peer_cert(ks_ssl->ctx);
+  cert = mbedtls_ssl_get_peer_cert (ks_ssl->ctx);
   if (cert != NULL)
     {
-      openvpn_snprintf (s2, sizeof (s2), ", %zu bit key", pk_get_size(&cert->pk));
+      openvpn_snprintf (s2, sizeof (s2), ", %zu bit key",
+	  mbedtls_pk_get_bitlen (&cert->pk));
     }
 
   msg (D_HANDSHAKE, "%s%s", s1, s2);
@@ -1106,7 +1119,7 @@ void
 show_available_tls_ciphers (const char *cipher_list)
 {
   struct tls_root_ctx tls_ctx;
-  const int *ciphers = ssl_list_ciphersuites();
+  const int *ciphers = mbedtls_ssl_list_ciphersuites ();
 
   tls_ctx_server_new(&tls_ctx);
   tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
@@ -1121,7 +1134,7 @@ show_available_tls_ciphers (const char *cipher_list)
 
   while (*ciphers != 0)
     {
-      printf ("%s\n", ssl_get_ciphersuite_name(*ciphers));
+      printf ("%s\n", mbedtls_ssl_get_ciphersuite_name (*ciphers));
       ciphers++;
     }
   printf ("\n" SHOW_TLS_CIPHER_LIST_WARNING);
@@ -1132,14 +1145,14 @@ show_available_tls_ciphers (const char *cipher_list)
 void
 show_available_curves (void)
 {
-  const ecp_curve_info *pcurve = ecp_curve_list();
+  const mbedtls_ecp_curve_info *pcurve = mbedtls_ecp_curve_list ();
 
   if (NULL == pcurve)
-    msg (M_FATAL, "Cannot retrieve curve list from PolarSSL");
+    msg (M_FATAL, "Cannot retrieve curve list from mbed TLS");
 
   /* Print curve list */
   printf ("Available Elliptic curves, listed in order of preference:\n\n");
-  while (POLARSSL_ECP_DP_NONE != pcurve->grp_id)
+  while (MBEDTLS_ECP_DP_NONE != pcurve->grp_id)
     {
       printf("%s\n", pcurve->name);
       pcurve++;
@@ -1150,22 +1163,22 @@ void
 get_highest_preference_tls_cipher (char *buf, int size)
 {
   const char *cipher_name;
-  const int *ciphers = ssl_list_ciphersuites();
+  const int *ciphers = mbedtls_ssl_list_ciphersuites();
   if (*ciphers == 0)
     msg (M_FATAL, "Cannot retrieve list of supported SSL ciphers.");
 
-  cipher_name = ssl_get_ciphersuite_name(*ciphers);
+  cipher_name = mbedtls_ssl_get_ciphersuite_name(*ciphers);
   strncpynt (buf, cipher_name, size);
 }
 
 const char *
 get_ssl_library_version(void)
 {
-    static char polar_version[30];
-    unsigned int pv = version_get_number();
-    sprintf( polar_version, "PolarSSL %d.%d.%d",
+    static char mbedtls_version[30];
+    unsigned int pv = mbedtls_version_get_number();
+    sprintf( mbedtls_version, "mbed TLS %d.%d.%d",
 		(pv>>24)&0xff, (pv>>16)&0xff, (pv>>8)&0xff );
-    return polar_version;
+    return mbedtls_version;
 }
 
-#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_POLARSSL) */
+#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/ssl_polarssl.h b/src/openvpn/ssl_polarssl.h
index b80a509..6f778ef 100644
--- a/src/openvpn/ssl_polarssl.h
+++ b/src/openvpn/ssl_polarssl.h
@@ -24,19 +24,19 @@
  */
 
 /**
- * @file Control Channel PolarSSL Backend
+ * @file Control Channel mbed TLS Backend
  */
 
-#ifndef SSL_POLARSSL_H_
-#define SSL_POLARSSL_H_
+#ifndef SSL_MBEDTLS_H_
+#define SSL_MBEDTLS_H_
 
 #include "syshead.h"
 
-#include <polarssl/ssl.h>
-#include <polarssl/x509_crt.h>
+#include <mbedtls/ssl.h>
+#include <mbedtls/x509_crt.h>
 
 #if defined(ENABLE_PKCS11)
-#include <polarssl/pkcs11.h>
+#include <mbedtls/pkcs11.h>
 #endif
 
 typedef struct _buffer_entry buffer_entry;
@@ -53,6 +53,11 @@ typedef struct {
     buffer_entry *last_block;
 } endless_buffer;
 
+typedef struct {
+    endless_buffer in;
+    endless_buffer out;
+} bio_ctx;
+
 /**
  * Structure that wraps the TLS context. Contents differ depending on the
  * SSL library used.
@@ -64,12 +69,12 @@ struct tls_root_ctx {
 
     int endpoint; 		/**< Whether or not this is a server or a client */
 
-    dhm_context *dhm_ctx;	/**< Diffie-Helmann-Merkle context */
-    x509_crt *crt_chain;	/**< Local Certificate chain */
-    x509_crt *ca_chain;		/**< CA chain for remote verification */
-    pk_context *priv_key;	/**< Local private key */
+    mbedtls_dhm_context *dhm_ctx;	/**< Diffie-Helmann-Merkle context */
+    mbedtls_x509_crt *crt_chain;	/**< Local Certificate chain */
+    mbedtls_x509_crt *ca_chain;		/**< CA chain for remote verification */
+    mbedtls_pk_context *priv_key;	/**< Local private key */
 #if defined(ENABLE_PKCS11)
-    pkcs11_context *priv_key_pkcs11;	/**< PKCS11 private key */
+    mbedtls_pkcs11_context *priv_key_pkcs11;	/**< PKCS11 private key */
 #endif
 #ifdef MANAGMENT_EXTERNAL_KEY
     struct external_context *external_key; /**< Management external key */
@@ -78,10 +83,10 @@ struct tls_root_ctx {
 };
 
 struct key_state_ssl {
-        ssl_context *ctx;
-        endless_buffer *ct_in;
-        endless_buffer *ct_out;
+    mbedtls_ssl_config ssl_config;	/**< mbedTLS global ssl config */
+    mbedtls_ssl_context *ctx;		/**< mbedTLS connection context */
+    bio_ctx bio_ctx;
 };
 
 
-#endif /* SSL_POLARSSL_H_ */
+#endif /* SSL_MBEDTLS_H_ */
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 8527415..5eb1843 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -40,7 +40,7 @@
 #ifdef ENABLE_CRYPTO_OPENSSL
 #include "ssl_verify_openssl.h"
 #endif
-#ifdef ENABLE_CRYPTO_POLARSSL
+#ifdef ENABLE_CRYPTO_MBEDTLS
 #include "ssl_verify_polarssl.h"
 #endif
 
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index d527133..ff76d3d 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -24,7 +24,7 @@
  */
 
 /**
- * @file Control Channel Verification Module PolarSSL backend
+ * @file Control Channel Verification Module mbed TLS backend
  */
 
 #ifdef HAVE_CONFIG_H
@@ -35,21 +35,21 @@
 
 #include "syshead.h"
 
-#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_POLARSSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
 
 #include "crypto_polarssl.h"
 #include "ssl_verify.h"
-#include <polarssl/asn1.h>
-#include <polarssl/error.h>
-#include <polarssl/bignum.h>
-#include <polarssl/oid.h>
-#include <polarssl/sha1.h>
+#include <mbedtls/asn1.h>
+#include <mbedtls/error.h>
+#include <mbedtls/bignum.h>
+#include <mbedtls/oid.h>
+#include <mbedtls/sha1.h>
 
 #define MAX_SUBJECT_LENGTH 256
 
 int
-verify_callback (void *session_obj, x509_crt *cert, int cert_depth,
-    int *flags)
+verify_callback (void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
+    uint32_t *flags)
 {
   struct tls_session *session = (struct tls_session *) session_obj;
   struct gc_arena gc = gc_new();
@@ -77,26 +77,26 @@ verify_callback (void *session_obj, x509_crt *cert, int cert_depth,
     }
   else if (SUCCESS != verify_cert(session, cert, cert_depth))
     {
-      *flags |= BADCERT_OTHER;
+      *flags |= MBEDTLS_X509_BADCERT_OTHER;
     }
 
   gc_free(&gc);
 
   /*
-   * PolarSSL-1.2.0+ expects 0 on anything except fatal errors.
+   * PolarSSL/mbed TLS-1.2.0+ expects 0 on anything except fatal errors.
    */
   return 0;
 }
 
 #ifdef ENABLE_X509ALTUSERNAME
-# warning "X509 alt user name not yet supported for PolarSSL"
+# warning "X509 alt user name not yet supported for mbed TLS"
 #endif
 
 result_t
 backend_x509_get_username (char *cn, int cn_len,
-    char *x509_username_field, x509_crt *cert)
+    char *x509_username_field, mbedtls_x509_crt *cert)
 {
-  x509_name *name;
+  mbedtls_x509_name *name;
 
   ASSERT( cn != NULL );
 
@@ -105,7 +105,8 @@ backend_x509_get_username (char *cn, int cn_len,
   /* Find common name */
   while( name != NULL )
   {
-      if( memcmp( name->oid.p, OID_AT_CN, OID_SIZE(OID_AT_CN) ) == 0)
+      if (0 == memcmp (name->oid.p, MBEDTLS_OID_AT_CN,
+	  MBEDTLS_OID_SIZE (MBEDTLS_OID_AT_CN)))
 	break;
 
       name = name->next;
@@ -131,26 +132,27 @@ backend_x509_get_username (char *cn, int cn_len,
 }
 
 char *
-backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
+backend_x509_get_serial (mbedtls_x509_crt *cert, struct gc_arena *gc)
 {
   char *buf = NULL;
   size_t buflen = 0;
-  mpi serial_mpi = { 0 };
+  mbedtls_mpi serial_mpi = { 0 };
 
-  /* Transform asn1 integer serial into PolarSSL MPI */
-  mpi_init(&serial_mpi);
-  if (!polar_ok(mpi_read_binary(&serial_mpi, cert->serial.p, cert->serial.len)))
+  /* Transform asn1 integer serial into mbed TLS MPI */
+  mbedtls_mpi_init(&serial_mpi);
+  if (!mbed_ok(mbedtls_mpi_read_binary(&serial_mpi, cert->serial.p,
+      cert->serial.len)))
     {
       msg(M_WARN, "Failed to retrieve serial from certificate.");
       return NULL;
     }
 
   /* Determine decimal representation length, allocate buffer */
-  mpi_write_string(&serial_mpi, 10, buf, &buflen);
+  mbedtls_mpi_write_string(&serial_mpi, 10, NULL, 0, &buflen);
   buf = gc_malloc(buflen, true, gc);
 
   /* Write MPI serial as decimal string into buffer */
-  if (!polar_ok(mpi_write_string(&serial_mpi, 10, buf, &buflen)))
+  if (!mbed_ok(mbedtls_mpi_write_string(&serial_mpi, 10, buf, buflen, &buflen)))
     {
       msg(M_WARN, "Failed to write serial to string.");
       return NULL;
@@ -160,36 +162,36 @@ backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 }
 
 char *
-backend_x509_get_serial_hex (openvpn_x509_cert_t *cert, struct gc_arena *gc)
+backend_x509_get_serial_hex (mbedtls_x509_crt *cert, struct gc_arena *gc)
 {
   char *buf = NULL;
   size_t len = cert->serial.len * 3 + 1;
 
   buf = gc_malloc(len, true, gc);
 
-  if(x509_serial_gets(buf, len-1, &cert->serial) < 0)
+  if(mbedtls_x509_serial_gets(buf, len-1, &cert->serial) < 0)
     buf = NULL;
 
   return buf;
 }
 
 unsigned char *
-x509_get_sha1_hash (x509_crt *cert, struct gc_arena *gc)
+x509_get_sha1_hash (mbedtls_x509_crt *cert, struct gc_arena *gc)
 {
   unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
-  sha1(cert->raw.p, cert->raw.len, sha1_hash);
+  mbedtls_sha1(cert->raw.p, cert->tbs.len, sha1_hash);
   return sha1_hash;
 }
 
 char *
-x509_get_subject(x509_crt *cert, struct gc_arena *gc)
+x509_get_subject(mbedtls_x509_crt *cert, struct gc_arena *gc)
 {
   char tmp_subject[MAX_SUBJECT_LENGTH] = {0};
   char *subject = NULL;
 
   int ret = 0;
 
-  ret = x509_dn_gets( tmp_subject, MAX_SUBJECT_LENGTH-1, &cert->subject );
+  ret = mbedtls_x509_dn_gets( tmp_subject, MAX_SUBJECT_LENGTH-1, &cert->subject );
   if (ret > 0)
     {
       /* Allocate the required space for the subject */
@@ -216,7 +218,7 @@ do_setenv_x509 (struct env_set *es, const char *name, char *value, int depth)
 }
 
 static char *
-asn1_buf_to_c_string(const asn1_buf *orig, struct gc_arena *gc)
+asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)
 {
   size_t i;
   char *val;
@@ -232,13 +234,13 @@ asn1_buf_to_c_string(const asn1_buf *orig, struct gc_arena *gc)
 
 static void
 do_setenv_name(struct env_set *es, const struct x509_track *xt,
-	       const x509_crt *cert, int depth, struct gc_arena *gc)
+	       const mbedtls_x509_crt *cert, int depth, struct gc_arena *gc)
 {
-  const x509_name *xn;
+  const mbedtls_x509_name *xn;
   for (xn = &cert->subject; xn != NULL; xn = xn->next)
     {
       const char *xn_short_name = NULL;
-      if (0 == oid_get_attr_short_name (&xn->oid, &xn_short_name) &&
+      if (0 == mbedtls_oid_get_attr_short_name (&xn->oid, &xn_short_name) &&
 	  0 == strcmp (xt->name, xn_short_name))
 	{
 	  char *val_str = asn1_buf_to_c_string (&xn->val, gc);
@@ -263,7 +265,8 @@ x509_track_add (const struct x509_track **ll_head, const char *name, int msgleve
 }
 
 void
-x509_setenv_track (const struct x509_track *xt, struct env_set *es, const int depth, x509_crt *cert)
+x509_setenv_track (const struct x509_track *xt, struct env_set *es,
+    const int depth, mbedtls_x509_crt *cert)
 {
   struct gc_arena gc = gc_new();
   while (xt)
@@ -293,11 +296,11 @@ x509_setenv_track (const struct x509_track *xt, struct env_set *es, const int de
  * X509_{cert_depth}_{name}={value}
  */
 void
-x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert)
+x509_setenv (struct env_set *es, int cert_depth, mbedtls_x509_crt *cert)
 {
   int i;
   unsigned char c;
-  const x509_name *name;
+  const mbedtls_x509_name *name;
   char s[128];
 
   name = &cert->subject;
@@ -309,7 +312,7 @@ x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert)
       char name_expand[64+8];
       const char *shortname;
 
-      if( 0 == oid_get_attr_short_name(&name->oid, &shortname) )
+      if( 0 == mbedtls_oid_get_attr_short_name(&name->oid, &shortname) )
 	{
 	  openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_%s",
 	      cert_depth, shortname);
@@ -342,27 +345,29 @@ x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert)
 }
 
 result_t
-x509_verify_ns_cert_type(const x509_crt *cert, const int usage)
+x509_verify_ns_cert_type(const mbedtls_x509_crt *cert, const int usage)
 {
   if (usage == NS_CERT_CHECK_NONE)
     return SUCCESS;
   if (usage == NS_CERT_CHECK_CLIENT)
-    return ((cert->ext_types & EXT_NS_CERT_TYPE)
-	&& (cert->ns_cert_type & NS_CERT_TYPE_SSL_CLIENT)) ? SUCCESS : FAILURE;
+    return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
+	&& (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_CLIENT)) ?
+	    SUCCESS : FAILURE;
   if (usage == NS_CERT_CHECK_SERVER)
-    return ((cert->ext_types & EXT_NS_CERT_TYPE)
-	&& (cert->ns_cert_type & NS_CERT_TYPE_SSL_SERVER)) ? SUCCESS : FAILURE;
+    return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
+	&& (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_SERVER)) ?
+	    SUCCESS : FAILURE;
 
   return FAILURE;
 }
 
 result_t
-x509_verify_cert_ku (x509_crt *cert, const unsigned * const expected_ku,
+x509_verify_cert_ku (mbedtls_x509_crt *cert, const unsigned * const expected_ku,
     int expected_len)
 {
   result_t fFound = FAILURE;
 
-  if(!(cert->ext_types & EXT_KEY_USAGE))
+  if(!(cert->ext_types & MBEDTLS_X509_EXT_KEY_USAGE))
     {
       msg (D_HANDSHAKE, "Certificate does not have key usage extension");
     }
@@ -390,26 +395,26 @@ x509_verify_cert_ku (x509_crt *cert, const unsigned * const expected_ku,
 }
 
 result_t
-x509_verify_cert_eku (x509_crt *cert, const char * const expected_oid)
+x509_verify_cert_eku (mbedtls_x509_crt *cert, const char * const expected_oid)
 {
   result_t fFound = FAILURE;
 
-  if (!(cert->ext_types & EXT_EXTENDED_KEY_USAGE))
+  if (!(cert->ext_types & MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))
     {
       msg (D_HANDSHAKE, "Certificate does not have extended key usage extension");
     }
   else
     {
-      x509_sequence *oid_seq = &(cert->ext_key_usage);
+      mbedtls_x509_sequence *oid_seq = &(cert->ext_key_usage);
 
       msg (D_HANDSHAKE, "Validating certificate extended key usage");
       while (oid_seq != NULL)
 	{
-	  x509_buf *oid = &oid_seq->buf;
+	  mbedtls_x509_buf *oid = &oid_seq->buf;
 	  char oid_num_str[1024];
 	  const char *oid_str;
 
-	  if (0 == oid_get_extended_key_usage( oid, &oid_str ))
+	  if (0 == mbedtls_oid_get_extended_key_usage( oid, &oid_str ))
 	    {
 	      msg (D_HANDSHAKE, "++ Certificate has EKU (str) %s, expects %s",
 		  oid_str, expected_oid);
@@ -420,7 +425,7 @@ x509_verify_cert_eku (x509_crt *cert, const char * const expected_oid)
 		}
 	    }
 
-	  if (0 < oid_get_numeric_string( oid_num_str,
+	  if (0 < mbedtls_oid_get_numeric_string( oid_num_str,
 	      sizeof (oid_num_str), oid))
 	    {
 	      msg (D_HANDSHAKE, "++ Certificate has EKU (oid) %s, expects %s",
@@ -439,9 +444,9 @@ x509_verify_cert_eku (x509_crt *cert, const char * const expected_oid)
 }
 
 result_t
-x509_write_pem(FILE *peercert_file, x509_crt *peercert)
+x509_write_pem(FILE *peercert_file, mbedtls_x509_crt *peercert)
 {
-    msg (M_WARN, "PolarSSL does not support writing peer certificate in PEM format");
+    msg (M_WARN, "mbed TLS does not support writing peer certificate in PEM format");
     return FAILURE;
 }
 
@@ -449,17 +454,18 @@ x509_write_pem(FILE *peercert_file, x509_crt *peercert)
  * check peer cert against CRL
  */
 result_t
-x509_verify_crl(const char *crl_file, const char* crl_inline,
-                x509_crt *cert, const char *subject)
+x509_verify_crl(const char *crl_file, const char *crl_inline,
+                mbedtls_x509_crt *cert, const char *subject)
 {
   result_t retval = FAILURE;
-  x509_crl crl = {0};
+  mbedtls_x509_crl crl = {0};
   struct gc_arena gc = gc_new();
   char *serial;
 
   if (!strcmp (crl_file, INLINE_FILE_TAG) && crl_inline)
     {
-      if (!polar_ok(x509_crl_parse(&crl, crl_inline, strlen(crl_inline))))
+      if (!mbed_ok(mbedtls_x509_crl_parse(&crl,
+	  (const unsigned char *)crl_inline, strlen(crl_inline)+1)))
         {
            msg (M_WARN, "CRL: cannot parse inline CRL");
            goto end;
@@ -467,7 +473,7 @@ x509_verify_crl(const char *crl_file, const char* crl_inline,
     }
   else
     {
-      if (!polar_ok(x509_crl_parse_file(&crl, crl_file)))
+      if (!mbed_ok(mbedtls_x509_crl_parse_file(&crl, crl_file)))
       {
           msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
           goto end;
@@ -483,7 +489,7 @@ x509_verify_crl(const char *crl_file, const char* crl_inline,
       goto end;
     }
 
-  if (!polar_ok(x509_crt_revoked(cert, &crl)))
+  if (!mbed_ok(mbedtls_x509_crt_is_revoked(cert, &crl)))
     {
       serial = backend_x509_get_serial_hex(cert, &gc);
       msg (D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", subject, (serial ? serial : "NOT AVAILABLE"));
@@ -495,8 +501,8 @@ x509_verify_crl(const char *crl_file, const char* crl_inline,
 
 end:
   gc_free(&gc);
-  x509_crl_free(&crl);
+  mbedtls_x509_crl_free(&crl);
   return retval;
 }
 
-#endif /* #if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_POLARSSL) */
+#endif /* #if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/ssl_verify_polarssl.h b/src/openvpn/ssl_verify_polarssl.h
index 2076f2e..e26d08f 100644
--- a/src/openvpn/ssl_verify_polarssl.h
+++ b/src/openvpn/ssl_verify_polarssl.h
@@ -24,18 +24,18 @@
  */
 
 /**
- * @file Control Channel Verification Module PolarSSL backend
+ * @file Control Channel Verification Module mbed TLS backend
  */
 
-#ifndef SSL_VERIFY_POLARSSL_H_
-#define SSL_VERIFY_POLARSSL_H_
+#ifndef SSL_VERIFY_MBEDTLS_H_
+#define SSL_VERIFY_MBEDTLS_H_
 
 #include "syshead.h"
-#include <polarssl/x509_crt.h>
+#include <mbedtls/x509_crt.h>
 
 #ifndef __OPENVPN_X509_CERT_T_DECLARED
 #define __OPENVPN_X509_CERT_T_DECLARED
-typedef x509_crt openvpn_x509_cert_t;
+typedef mbedtls_x509_crt openvpn_x509_cert_t;
 #endif
 
 /** @name Function for authenticating a new connection from a remote OpenVPN peer
@@ -50,7 +50,7 @@ typedef x509_crt openvpn_x509_cert_t;
  * determine whether the remote OpenVPN peer's certificate is allowed to
  * connect. It is called for once for every certificate in the chain. The
  * callback functionality is configured in the \c init_ssl() function, which
- * calls the PolarSSL library's \c ssl_set_verify_callback() function with \c
+ * calls the mbed TLS library's \c ssl_set_verify_callback() function with \c
  * verify_callback() as its callback argument.
  *
  * It checks *flags and registers the certificate hash. If these steps succeed,
@@ -59,7 +59,7 @@ typedef x509_crt openvpn_x509_cert_t;
  *
  * @param session_obj  - The OpenVPN \c tls_session associated with this object,
  *                       as set during SSL session setup.
- * @param cert         - The certificate used by PolarSSL.
+ * @param cert         - The certificate used by mbed TLS.
  * @param cert_depth   - The depth of the current certificate in the chain, with
  *                       0 being the actual certificate.
  * @param flags        - Whether the remote OpenVPN peer's certificate
@@ -70,9 +70,9 @@ typedef x509_crt openvpn_x509_cert_t;
  *
  * @return The return value is 0 unless a fatal error occurred.
  */
-int verify_callback (void *session_obj, x509_crt *cert, int cert_depth,
-    int *flags);
+int verify_callback (void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
+    uint32_t *flags);
 
 /** @} name Function for authenticating a new connection from a remote OpenVPN peer */
 
-#endif /* SSL_VERIFY_POLARSSL_H_ */
+#endif /* SSL_VERIFY_MBEDTLS_H_ */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 1c9248f..c8391ca 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -564,10 +564,10 @@ socket_defined (const socket_descriptor_t sd)
 #define MANAGMENT_EXTERNAL_KEY
 #endif
 
-/* Enable PolarSSL RNG prediction resistance support */
-#ifdef ENABLE_CRYPTO_POLARSSL
+/* Enable mbed TLS RNG prediction resistance support */
+#ifdef ENABLE_CRYPTO_MBEDTLS
 #define ENABLE_PREDICTION_RESISTANCE
-#endif /* ENABLE_CRYPTO_POLARSSL */
+#endif /* ENABLE_CRYPTO_MBEDTLS */
 
 /*
  * MANAGEMENT_IN_EXTRA allows the management interface to
-- 
2.5.0


