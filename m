From: Gert Doering <gert@...1296...>
Date: Tue, 15 Jul 2025 14:29:49 +0200
Message-ID: <20250715122957.22311-1-gert@...1296...>
In-Reply-To: <gerrit.1752062243000.I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd@...2715...>
References: <gerrit.1752062243000.I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] Cleanup/simplify mbed TLS related define
 from autoconf
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

From: Arne Schwabe <arne@...1227...>

Instead of a custom logic using 0/1 to be defined when the functions
are present or not, use the standard check and adjust the source code
accordingly.

Also not compile mbed key helper with MBEDTLS_SSL_KEYING_MATERIAL_EXPORT

The helper methods are only used when we don't have
MBEDTLS_SSL_KEYING_MATERIAL_EXPORT and mbedtls_ssl_export_keying_material.

Remove AEAD check that tests for presence of mbedtls_cipher_write_tag
and mbedtls_cipher_check_tag. Having an mbed TLS version that does not
support that is highly unlikely. It might have been a good check in
PolarSSL's time but is not today anymore.

This also adds some missing support for mbed 2.x related defines to
cmake based build.

Change-Id: I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1081
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 40bffd4..efb2d2d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -302,7 +302,8 @@
     check_symbol_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)
     check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)
     check_symbol_exists(mbedtls_ssl_set_export_keys_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB)
-    check_include_files(psa/crypto.h HAVE_MBEDTLS_PSA_CRYPTO_H)
+    check_symbol_exists(mbedtls_ssl_tls_prf mbedtls/ssl.h HAVE_MBEDTLS_SSL_TLS_PRF)
+    check_include_files(psa/crypto.h HAVE_PSA_CRYPTO_H)
 endfunction()
 
 if (${MBED})
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 5df0ac8..1c443ab 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -370,10 +370,11 @@
 #undef HAVE_VFORK_H
 
 /* Availability of different mbed TLS features and APIs */
-#cmakedefine01 HAVE_MBEDTLS_PSA_CRYPTO_H
-#define HAVE_MBEDTLS_SSL_TLS_PRF 1
-#cmakedefine01 HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
-#cmakedefine01 HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
+#cmakedefine HAVE_PSA_CRYPTO_H
+#cmakedefine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+#cmakedefine HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+#cmakedefine HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
+#cmakedefine HAVE_MBEDTLS_SSL_TLS_PRF
 
 /* Path to ifconfig tool */
 #define IFCONFIG_PATH "@IFCONFIG_PATH@"
diff --git a/configure.ac b/configure.ac
index 02b45f8..8fc48ba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1038,38 +1038,12 @@
 		[AC_MSG_ERROR([mbed TLS version >= 2.0.0 or >= 3.2.1 required])]
 	)
 
-	AC_CHECK_HEADER(
-		psa/crypto.h,
-		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [1], [yes])],
-		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [0], [no])]
-	)
+	AC_CHECK_HEADERS(psa/crypto.h)
 
-	AC_CHECK_FUNCS(
-		[ \
-			mbedtls_cipher_write_tag \
-			mbedtls_cipher_check_tag \
-		],
-		,
-		[AC_MSG_ERROR([mbed TLS check for AEAD support failed])]
-	)
+	AC_CHECK_FUNCS([mbedtls_ssl_tls_prf mbedtls_ssl_conf_export_keys_ext_cb])
 
-	AC_CHECK_FUNC(
-		[mbedtls_ssl_tls_prf],
-		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [1], [yes])],
-		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]
-	)
-
-	AC_CHECK_FUNC(
-		[mbedtls_ssl_conf_export_keys_ext_cb],
-		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],
-		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [0], [no])]
-	)
 	if test "x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb" != xyes; then
-		AC_CHECK_FUNC(
-			[mbedtls_ssl_set_export_keys_cb],
-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [1], [yes])],
-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
-		)
+		AC_CHECK_FUNCS([mbedtls_ssl_set_export_keys_cb])
 		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" != xyes; then
 			AC_CHECK_FUNC([mbedtls_ssl_export_keying_material])
 			if test "x$ac_cv_func_mbedtls_ssl_export_keying_material" != xyes; then
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index c05902d..1f3dcba 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -981,7 +981,7 @@
 }
 /* mbedtls-2.18.0 or newer implements tls_prf, but prf_tls1 is removed
  * from recent versions, so we use our own implementation if necessary. */
-#if HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1)
+#if defined(HAVE_MBEDTLS_SSL_TLS_PRF) && defined(MBEDTLS_SSL_TLS_PRF_TLS1)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)
@@ -990,7 +990,7 @@
                                        secret_len, "", seed, seed_len, output,
                                        output_len));
 }
-#else /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
+#else /* defined(HAVE_MBEDTLS_SSL_TLS_PRF) && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
 /*
  * Generate the hash required by for the \c tls1_PRF function.
  *
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 145a7ae..aeb0c5f 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -48,7 +48,7 @@
 #include <mbedtls/version.h>
 #include <mbedtls/x509_crt.h>
 
-#if HAVE_MBEDTLS_PSA_CRYPTO_H
+#ifdef HAVE_PSA_CRYPTO_H
     #include <psa/crypto.h>
 #endif
 
@@ -61,14 +61,14 @@
 static inline void
 mbedtls_compat_psa_crypto_init(void)
 {
-#if HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C)
+#if defined(HAVE_PSA_CRYPTO_H) && defined(MBEDTLS_PSA_CRYPTO_C)
     if (psa_crypto_init() != PSA_SUCCESS)
     {
         msg(M_FATAL, "mbedtls: psa_crypto_init() failed");
     }
 #else
     return;
-#endif /* HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
+#endif
 }
 
 static inline mbedtls_compat_group_id
@@ -96,7 +96,7 @@
 {
 #if MBEDTLS_VERSION_NUMBER > 0x03000000
     return mbedtls_ctr_drbg_update(ctx, additional, add_len);
-#elif HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
+#elif defined(HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)
     return mbedtls_ctr_drbg_update_ret(ctx, additional, add_len);
 #else
     mbedtls_ctr_drbg_update(ctx, additional, add_len);
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ecccc26..a4bb772 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -173,8 +173,9 @@
     ASSERT(NULL != ctx);
     return ctx->initialised;
 }
-
-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+#ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT
+/* mbedtls_ssl_export_keying_material does not need helper/callback methods */
+#elif defined(HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)
 /*
  * Key export callback for older versions of mbed TLS, to be used with
  * mbedtls_ssl_conf_export_keys_ext_cb(). It is called with the master
@@ -205,7 +206,7 @@
 
     return 0;
 }
-#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+#elif defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB)
 /*
  * Key export callback for newer versions of mbed TLS, to be used with
  * mbedtls_ssl_set_export_keys_cb(). When used with TLS 1.2, the callback
@@ -251,10 +252,11 @@
     memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
     cache->tls_prf_type = tls_prf_type;
 }
-#elif !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+#else  /* ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT */
 #error mbedtls_ssl_conf_export_keys_ext_cb, mbedtls_ssl_set_export_keys_cb or mbedtls_ssl_export_keying_material must be available in mbed TLS
 #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
 
+
 bool
 key_state_export_keying_material(struct tls_session *session,
                                  const char *label, size_t label_size,
@@ -1244,7 +1246,7 @@
         mbedtls_ssl_conf_max_tls_version(ks_ssl->ssl_config, version);
     }
 
-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB && !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+#if defined(HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB) && !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
     /* Initialize keying material exporter, old style. */
     mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
                                         mbedtls_ssl_export_keys_cb, session);
@@ -1259,7 +1261,7 @@
      * verification. */
     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));
 
-#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB && !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+#if defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB) && !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
     /* Initialize keying material exporter, new style. */
     mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_export_keys_cb, session);
 #endif

