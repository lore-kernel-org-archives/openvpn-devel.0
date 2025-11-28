From: Gert Doering <gert@...1296...>
Date: Fri, 28 Nov 2025 19:12:51 +0100
Message-ID: <20251128181257.15535-1-gert@...1296...>
In-Reply-To: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
References: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Drop Mbed TLS 2.X compatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Max Fillinger <maximilian.fillinger@...2918...>

Mbed TLS 2.28 is out of support since March and adding support for
Mbed TLS 4 will get ugly enough without the old compatibility code lying
around too.

Mbed TLS 2.28 still ships on some supported distributions
(e.g.  Ubuntu 24.04) but nobody is maintaining openvpn-mbedtls packages
there. This commit will probably break on some test machines.

Change-Id: Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1412
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1412
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index e812145..8a8054f 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -305,10 +305,6 @@
         set(CMAKE_REQUIRED_LINK_OPTIONS "-L${MBED_LIBRARY_PATH}")
     endif ()
     set(CMAKE_REQUIRED_LIBRARIES "mbedtls;mbedx509;mbedcrypto")
-    check_symbol_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)
-    check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)
-    check_symbol_exists(mbedtls_ssl_set_export_keys_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB)
-    check_symbol_exists(mbedtls_ssl_tls_prf mbedtls/ssl.h HAVE_MBEDTLS_SSL_TLS_PRF)
     check_include_files(psa/crypto.h HAVE_PSA_CRYPTO_H)
 endfunction()
 
diff --git a/README.mbedtls b/README.mbedtls
index a1012e9..fb30db1 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -7,7 +7,8 @@
 	make
 	make install
 
-This version requires mbed TLS version >= 2.0.0 or >= 3.2.1.
+This version requires mbed TLS version >= 3.2.1. Versions >= 4.0.0 are not
+yet supported. Support for TLS 1.3 requires an Mbed TLS version >= 3.6.4.
 
 *************************************************************************
 
@@ -23,12 +24,3 @@
 
  * X.509 subject line has a different format than the OpenSSL subject line
  * X.509 certificate tracking
-
-*************************************************************************
-
-Mbed TLS 3 has implemented TLS 1.3, but support in OpenVPN requires the
-function mbedtls_ssl_export_keying_material() which is currently not in
-any released version. It is available when building mbed TLS from source
-(mbedtls-3.6 or development branch).
-
-Without this function, only TLS 1.2 is available.
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 1c443ab..c90d124 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -371,10 +371,6 @@
 
 /* Availability of different mbed TLS features and APIs */
 #cmakedefine HAVE_PSA_CRYPTO_H
-#cmakedefine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
-#cmakedefine HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
-#cmakedefine HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
-#cmakedefine HAVE_MBEDTLS_SSL_TLS_PRF
 
 /* Path to ifconfig tool */
 #define IFCONFIG_PATH "@IFCONFIG_PATH@"
diff --git a/configure.ac b/configure.ac
index 44c7b65..a6f79ae 100644
--- a/configure.ac
+++ b/configure.ac
@@ -995,7 +995,7 @@
 	if test -z "${MBEDTLS_CFLAGS}" -a -z "${MBEDTLS_LIBS}"; then
 		# if the user did not explicitly specify flags, try to autodetect
 		PKG_CHECK_MODULES([MBEDTLS],
-			[mbedtls >= 2.0.0 mbedx509 >= 2.0.0 mbedcrypto >= 2.0.0],
+			[mbedtls >= 3.2.1 mbedx509 >= 3.2.1 mbedcrypto >= 3.2.1],
 			[have_mbedtls="yes"],
 			[LIBS="${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto"]
 		)
@@ -1020,35 +1020,17 @@
 #include <mbedtls/version.h>
 			]],
 			[[
-#if MBEDTLS_VERSION_NUMBER < 0x02000000 || (MBEDTLS_VERSION_NUMBER >= 0x03000000 && MBEDTLS_VERSION_NUMBER < 0x03020100)
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([mbed TLS version >= 2.0.0 or >= 3.2.1 required])]
+		[AC_MSG_ERROR([mbed TLS version >= 3.2.1 required])]
 	)
 
 	AC_CHECK_HEADERS(psa/crypto.h)
 
-	AC_CHECK_FUNCS([mbedtls_ssl_tls_prf mbedtls_ssl_conf_export_keys_ext_cb])
-
-	if test "x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb" != xyes; then
-		AC_CHECK_FUNCS([mbedtls_ssl_set_export_keys_cb])
-		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" != xyes; then
-			AC_CHECK_FUNC([mbedtls_ssl_export_keying_material])
-			if test "x$ac_cv_func_mbedtls_ssl_export_keying_material" != xyes; then
-				AC_MSG_ERROR(This version of mbed TLS has no support for exporting key material.)
-			fi
-		fi
-	fi
-
-	AC_CHECK_FUNC(
-		[mbedtls_ctr_drbg_update_ret],
-		AC_DEFINE([HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET], [1],
-			  [Use mbedtls_ctr_drbg_update_ret from mbed TLS]),
-	)
-
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
 	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 89f0ab9..6688d48 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -41,7 +41,6 @@
 #include "integer.h"
 #include "crypto_backend.h"
 #include "otime.h"
-#include "mbedtls_compat.h"
 #include "misc.h"
 
 #include <mbedtls/base64.h>
@@ -987,17 +986,7 @@
 
     return diff;
 }
-/* mbedtls-2.18.0 or newer implements tls_prf, but prf_tls1 is removed
- * from recent versions, so we use our own implementation if necessary. */
-#if defined(HAVE_MBEDTLS_SSL_TLS_PRF) && defined(MBEDTLS_SSL_TLS_PRF_TLS1)
-bool
-ssl_tls1_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *secret, size_t secret_len,
-             uint8_t *output, size_t output_len)
-{
-    return mbed_ok(mbedtls_ssl_tls_prf(MBEDTLS_SSL_TLS_PRF_TLS1, secret, secret_len, "", seed,
-                                       seed_len, output, output_len));
-}
-#else /* defined(HAVE_MBEDTLS_SSL_TLS_PRF) && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
+
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
@@ -1135,6 +1124,5 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic pop
 #endif
-#endif /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
 
 #endif /* ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 68096c4..540f370 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -23,10 +23,8 @@
 /**
  * @file
  * mbedtls compatibility stub.
- * This file provide compatibility stubs for the mbedtls libraries
- * prior to version 3. This version made most fields in structs private
- * and requires accessor functions to be used. For earlier versions, we
- * implement the accessor functions here.
+ * This file provides compatibility stubs to handle API differences between
+ * different versions of Mbed TLS.
  */
 
 #ifndef MBEDTLS_COMPAT_H_
@@ -36,27 +34,10 @@
 
 #include "errlevel.h"
 
-#include <mbedtls/cipher.h>
-#include <mbedtls/ctr_drbg.h>
-#include <mbedtls/dhm.h>
-#include <mbedtls/ecp.h>
-#include <mbedtls/md.h>
-#include <mbedtls/pem.h>
-#include <mbedtls/pk.h>
-#include <mbedtls/ssl.h>
-#include <mbedtls/version.h>
-#include <mbedtls/x509_crt.h>
-
 #ifdef HAVE_PSA_CRYPTO_H
 #include <psa/crypto.h>
 #endif
 
-#if MBEDTLS_VERSION_NUMBER >= 0x03000000
-typedef uint16_t mbedtls_compat_group_id;
-#else
-typedef mbedtls_ecp_group_id mbedtls_compat_group_id;
-#endif
-
 static inline void
 mbedtls_compat_psa_crypto_init(void)
 {
@@ -70,162 +51,4 @@
 #endif
 }
 
-static inline mbedtls_compat_group_id
-mbedtls_compat_get_group_id(const mbedtls_ecp_curve_info *curve_info)
-{
-#if MBEDTLS_VERSION_NUMBER >= 0x03000000
-    return curve_info->tls_id;
-#else
-    return curve_info->grp_id;
-#endif
-}
-
-/*
- * In older versions of mbedtls, mbedtls_ctr_drbg_update() did not return an
- * error code, and it was deprecated in favor of mbedtls_ctr_drbg_update_ret()
- * which does.
- *
- * In mbedtls 3, this function was removed and mbedtls_ctr_drbg_update() returns
- * an error code.
- */
-static inline int
-mbedtls_compat_ctr_drbg_update(mbedtls_ctr_drbg_context *ctx, const unsigned char *additional,
-                               size_t add_len)
-{
-#if MBEDTLS_VERSION_NUMBER > 0x03000000
-    return mbedtls_ctr_drbg_update(ctx, additional, add_len);
-#elif defined(HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)
-    return mbedtls_ctr_drbg_update_ret(ctx, additional, add_len);
-#else
-    mbedtls_ctr_drbg_update(ctx, additional, add_len);
-    return 0;
-#endif /* HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET */
-}
-
-static inline int
-mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_pk_context *prv,
-                             int (*f_rng)(void *, unsigned char *, size_t), void *p_rng)
-{
-#if MBEDTLS_VERSION_NUMBER < 0x03020100
-    return mbedtls_pk_check_pair(pub, prv);
-#else
-    return mbedtls_pk_check_pair(pub, prv, f_rng, p_rng);
-#endif /* MBEDTLS_VERSION_NUMBER < 0x03020100 */
-}
-
-static inline int
-mbedtls_compat_pk_parse_key(mbedtls_pk_context *ctx, const unsigned char *key, size_t keylen,
-                            const unsigned char *pwd, size_t pwdlen,
-                            int (*f_rng)(void *, unsigned char *, size_t), void *p_rng)
-{
-#if MBEDTLS_VERSION_NUMBER < 0x03020100
-    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen);
-#else
-    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen, f_rng, p_rng);
-#endif
-}
-
-static inline int
-mbedtls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx, const char *path, const char *password,
-                                int (*f_rng)(void *, unsigned char *, size_t), void *p_rng)
-{
-#if MBEDTLS_VERSION_NUMBER < 0x03020100
-    return mbedtls_pk_parse_keyfile(ctx, path, password);
-#else
-    return mbedtls_pk_parse_keyfile(ctx, path, password, f_rng, p_rng);
-#endif
-}
-
-#if MBEDTLS_VERSION_NUMBER < 0x03020100
-typedef enum
-{
-    MBEDTLS_SSL_VERSION_UNKNOWN,         /*!< Context not in use or version not yet negotiated. */
-    MBEDTLS_SSL_VERSION_TLS1_2 = 0x0303, /*!< (D)TLS 1.2 */
-    MBEDTLS_SSL_VERSION_TLS1_3 = 0x0304, /*!< (D)TLS 1.3 */
-} mbedtls_ssl_protocol_version;
-
-static inline void
-mbedtls_ssl_conf_min_tls_version(mbedtls_ssl_config *conf, mbedtls_ssl_protocol_version tls_version)
-{
-    int major = (tls_version >> 8) & 0xff;
-    int minor = tls_version & 0xff;
-    mbedtls_ssl_conf_min_version(conf, major, minor);
-}
-
-static inline void
-mbedtls_ssl_conf_max_tls_version(mbedtls_ssl_config *conf, mbedtls_ssl_protocol_version tls_version)
-{
-    int major = (tls_version >> 8) & 0xff;
-    int minor = tls_version & 0xff;
-    mbedtls_ssl_conf_max_version(conf, major, minor);
-}
-
-static inline void
-mbedtls_ssl_conf_groups(mbedtls_ssl_config *conf, mbedtls_compat_group_id *groups)
-{
-    mbedtls_ssl_conf_curves(conf, groups);
-}
-
-static inline size_t
-mbedtls_cipher_info_get_block_size(const mbedtls_cipher_info_t *cipher)
-{
-    return (size_t)cipher->block_size;
-}
-
-static inline size_t
-mbedtls_cipher_info_get_iv_size(const mbedtls_cipher_info_t *cipher)
-{
-    return (size_t)cipher->iv_size;
-}
-
-static inline size_t
-mbedtls_cipher_info_get_key_bitlen(const mbedtls_cipher_info_t *cipher)
-{
-    return (size_t)cipher->key_bitlen;
-}
-
-static inline mbedtls_cipher_mode_t
-mbedtls_cipher_info_get_mode(const mbedtls_cipher_info_t *cipher)
-{
-    return cipher->mode;
-}
-
-static inline const char *
-mbedtls_cipher_info_get_name(const mbedtls_cipher_info_t *cipher)
-{
-    return cipher->name;
-}
-
-static inline mbedtls_cipher_type_t
-mbedtls_cipher_info_get_type(const mbedtls_cipher_info_t *cipher)
-{
-    return cipher->type;
-}
-
-static inline size_t
-mbedtls_dhm_get_bitlen(const mbedtls_dhm_context *ctx)
-{
-    return 8 * ctx->len;
-}
-
-static inline const mbedtls_md_info_t *
-mbedtls_md_info_from_ctx(const mbedtls_md_context_t *ctx)
-{
-    return ctx->md_info;
-}
-
-static inline const unsigned char *
-mbedtls_pem_get_buffer(const mbedtls_pem_context *ctx, size_t *buf_size)
-{
-    *buf_size = ctx->buflen;
-    return ctx->buf;
-}
-
-static inline int
-mbedtls_x509_crt_has_ext_type(const mbedtls_x509_crt *ctx, int ext_type)
-{
-    return ctx->ext_types & ext_type;
-}
-#endif /* MBEDTLS_VERSION_NUMBER < 0x03020100 */
-
 #endif /* MBEDTLS_COMPAT_H_ */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 488f9b9..83fca78 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -49,13 +49,8 @@
 #include "ssl_verify_mbedtls.h"
 #include <mbedtls/debug.h>
 #include <mbedtls/error.h>
-#include <mbedtls/version.h>
-
-#if MBEDTLS_VERSION_NUMBER >= 0x02040000
 #include <mbedtls/net_sockets.h>
-#else
-#include <mbedtls/net.h>
-#endif
+#include <mbedtls/version.h>
 
 #include <mbedtls/oid.h>
 #include <mbedtls/pem.h>
@@ -165,50 +160,14 @@
     ASSERT(NULL != ctx);
     return ctx->initialised;
 }
-#ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT
-/* mbedtls_ssl_export_keying_material does not need helper/callback methods */
-#elif defined(HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)
+#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
 /*
- * Key export callback for older versions of mbed TLS, to be used with
- * mbedtls_ssl_conf_export_keys_ext_cb(). It is called with the master
- * secret, client random and server random, and the type of PRF function
- * to use.
- *
- * Mbed TLS stores this callback in the mbedtls_ssl_config struct and it
- * is used in the mbedtls_ssl_contexts set up from that config. */
-int
-mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms, const unsigned char *kb,
-                           size_t maclen, size_t keylen, size_t ivlen,
-                           const unsigned char client_random[32],
-                           const unsigned char server_random[32],
-                           mbedtls_tls_prf_types tls_prf_type)
-{
-    struct tls_session *session = p_expkey;
-    struct key_state_ssl *ks_ssl = &session->key[KS_PRIMARY].ks_ssl;
-    struct tls_key_cache *cache = &ks_ssl->tls_key_cache;
-
-    static_assert(sizeof(ks_ssl->ctx->session->master) == sizeof(cache->master_secret),
-                  "master size mismatch");
-
-    memcpy(cache->client_server_random, client_random, 32);
-    memcpy(cache->client_server_random + 32, server_random, 32);
-    memcpy(cache->master_secret, ms, sizeof(cache->master_secret));
-    cache->tls_prf_type = tls_prf_type;
-
-    return 0;
-}
-#elif defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB)
-/*
- * Key export callback for newer versions of mbed TLS, to be used with
- * mbedtls_ssl_set_export_keys_cb(). When used with TLS 1.2, the callback
- * is called with the TLS 1.2 master secret, client random, server random
- * and the type of PRF to use. With TLS 1.3, it is called with several
- * different keys (indicated by type), but unfortunately not the exporter
- * master secret.
- *
- * Unlike in older versions, the callback is not stored in the
- * mbedtls_ssl_config. It is placed in the mbedtls_ssl_context after it
- * has been set up. */
+ * If we don't have mbedtls_ssl_export_keying_material(), we use
+ * mbedtls_ssl_set_export_keys_cb() to obtain a copy of the TLS 1.2
+ * master secret and compute the TLS-Exporter function ourselves.
+ * Unfortunately, with TLS 1.3, there is no alternative to
+ * mbedtls_ssl_export_keying_material().
+ */
 void
 mbedtls_ssl_export_keys_cb(void *p_expkey, mbedtls_ssl_key_export_type type,
                            const unsigned char *secret, size_t secret_len,
@@ -240,9 +199,7 @@
     memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
     cache->tls_prf_type = tls_prf_type;
 }
-#else  /* ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT */
-#error mbedtls_ssl_conf_export_keys_ext_cb, mbedtls_ssl_set_export_keys_cb or mbedtls_ssl_export_keying_material must be available in mbed TLS
-#endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
+#endif /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
 
 
 bool
@@ -397,7 +354,7 @@
 
     /* Get number of groups and allocate an array in ctx */
     int groups_count = get_num_elements(groups, ':');
-    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_compat_group_id, groups_count + 1)
+    ALLOC_ARRAY_CLEAR(ctx->groups, uint16_t, groups_count + 1)
 
     /* Parse allowed ciphers, getting IDs */
     int i = 0;
@@ -413,7 +370,7 @@
         }
         else
         {
-            ctx->groups[i] = mbedtls_compat_get_group_id(ci);
+            ctx->groups[i] = ci->tls_id;
             i++;
         }
     }
@@ -537,29 +494,29 @@
 
     if (priv_key_inline)
     {
-        status = mbedtls_compat_pk_parse_key(ctx->priv_key, (const unsigned char *)priv_key_file,
-                                             strlen(priv_key_file) + 1, NULL, 0,
-                                             mbedtls_ctr_drbg_random, rand_ctx_get());
+        status = mbedtls_pk_parse_key(ctx->priv_key, (const unsigned char *)priv_key_file,
+                                      strlen(priv_key_file) + 1, NULL, 0,
+                                      mbedtls_ctr_drbg_random, rand_ctx_get());
 
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
         {
             char passbuf[512] = { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
-            status = mbedtls_compat_pk_parse_key(
+            status = mbedtls_pk_parse_key(
                 ctx->priv_key, (const unsigned char *)priv_key_file, strlen(priv_key_file) + 1,
                 (unsigned char *)passbuf, strlen(passbuf), mbedtls_ctr_drbg_random, rand_ctx_get());
         }
     }
     else
     {
-        status = mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL,
-                                                 mbedtls_ctr_drbg_random, rand_ctx_get());
+        status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL,
+                                          mbedtls_ctr_drbg_random, rand_ctx_get());
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
         {
             char passbuf[512] = { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
-            status = mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf,
-                                                     mbedtls_ctr_drbg_random, rand_ctx_get());
+            status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf,
+                                              mbedtls_ctr_drbg_random, rand_ctx_get());
         }
     }
     if (!mbed_ok(status))
@@ -575,8 +532,8 @@
         return 1;
     }
 
-    if (!mbed_ok(mbedtls_compat_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key,
-                                              mbedtls_ctr_drbg_random, rand_ctx_get())))
+    if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key,
+                                       mbedtls_ctr_drbg_random, rand_ctx_get())))
     {
         msg(M_WARN, "Private key does not match the certificate");
         return 1;
@@ -610,9 +567,6 @@
  */
 static inline int
 external_pkcs1_sign(void *ctx_voidptr, int (*f_rng)(void *, unsigned char *, size_t), void *p_rng,
-#if MBEDTLS_VERSION_NUMBER < 0x03020100
-                    int mode,
-#endif
                     mbedtls_md_type_t md_alg, unsigned int hashlen, const unsigned char *hash,
                     unsigned char *sig)
 {
@@ -627,13 +581,6 @@
         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
     }
 
-#if MBEDTLS_VERSION_NUMBER < 0x03020100
-    if (MBEDTLS_RSA_PRIVATE != mode)
-    {
-        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-    }
-#endif
-
     /*
      * Support a wide range of hashes. TLSv1.1 and before only need SIG_RSA_RAW,
      * but TLSv1.2 needs the full suite of hashes.
@@ -1000,7 +947,7 @@
 
         if (0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
         {
-            if (!mbed_ok(mbedtls_compat_ctr_drbg_update(cd_ctx, sha256_hash, 32)))
+            if (!mbed_ok(mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32)))
             {
                 msg(M_WARN, "WARNING: failed to personalise random, could not update CTR_DRBG");
             }
@@ -1204,12 +1151,6 @@
         mbedtls_ssl_conf_max_tls_version(ks_ssl->ssl_config, version);
     }
 
-#if defined(HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB) \
-    && !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-    /* Initialize keying material exporter, old style. */
-    mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config, mbedtls_ssl_export_keys_cb, session);
-#endif
-
     /* Initialise SSL context */
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
@@ -1219,8 +1160,8 @@
      * verification. */
     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));
 
-#if defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB) && !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-    /* Initialize keying material exporter, new style. */
+#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+    /* Initialize the keying material exporter callback. */
     mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_export_keys_cb, session);
 #endif
 
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 0f85d96..8380a116 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -39,8 +39,6 @@
 #include <pkcs11-helper-1.0/pkcs11h-certificate.h>
 #endif
 
-#include "mbedtls_compat.h"
-
 typedef struct _buffer_entry buffer_entry;
 
 struct _buffer_entry
@@ -130,7 +128,7 @@
 #endif
     struct external_context external_key;  /**< External key context */
     int *allowed_ciphers;                  /**< List of allowed ciphers for this connection */
-    mbedtls_compat_group_id *groups;       /**< List of allowed groups for this connection */
+    uint16_t *groups;                      /**< List of allowed groups for this connection */
     mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate types */
 };
 
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 80ef837..250c806 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -35,7 +35,6 @@
 #if defined(ENABLE_CRYPTO_MBEDTLS)
 
 #include "crypto_mbedtls.h"
-#include "mbedtls_compat.h"
 #include "ssl_verify.h"
 #include <mbedtls/asn1.h>
 #include <mbedtls/error.h>

