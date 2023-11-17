From: Gert Doering <gert@...1296...>
Date: Fri, 17 Nov 2023 10:14:01 +0100
Message-ID: <20231117091401.25793-1-gert@...1296...>
In-Reply-To: <gerrit.1699630545000.I8e90530726b7f7ba3cee0438f2d81a1ac42e821b@...2715...>
References: <gerrit.1699630545000.I8e90530726b7f7ba3cee0438f2d81a1ac42e821b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Enable key export with mbed TLS 3.x.y
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

From: Max Fillinger <maximilian.fillinger@...2507...>

Change-Id: I8e90530726b7f7ba3cee0438f2d81a1ac42e821b
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/402
This mail reflects revision 5 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 1c0dd6f..19b79bc 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -387,7 +387,10 @@
 #undef HAVE_VSNPRINTF
 
 /* we always assume a recent mbed TLS version */
-#define HAVE_CTR_DRBG_UPDATE_RET 1
+#define HAVE_MBEDTLS_PSA_CRYPTO_H 1
+#define HAVE_MBEDTLS_SSL_TLS_PRF 1
+#define HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB 1
+#define HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET 1
 
 /* Path to ifconfig tool */
 #define IFCONFIG_PATH "@IFCONFIG_PATH@"
diff --git a/configure.ac b/configure.ac
index 7e5763d..84eaad6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1025,11 +1025,11 @@
 		[AC_MSG_ERROR([mbed TLS version >= 2.0.0 or >= 3.2.1 required])]
 	)
 
-    AC_CHECK_HEADER(
-        psa/crypto.h,
-        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [1], [yes])],
-        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [0], [no])]
-    )
+	AC_CHECK_HEADER(
+		psa/crypto.h,
+		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [1], [yes])],
+		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [0], [no])]
+	)
 
 	AC_CHECK_FUNCS(
 		[ \
@@ -1040,16 +1040,32 @@
 		[AC_MSG_ERROR([mbed TLS check for AEAD support failed])]
 	)
 
+	AC_CHECK_FUNC(
+		[mbedtls_ssl_tls_prf],
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [1], [yes])],
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]
+	)
+
 	have_export_keying_material="yes"
 	AC_CHECK_FUNC(
 		[mbedtls_ssl_conf_export_keys_ext_cb],
-		,
-		[have_export_keying_material="no"]
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [0], [no])]
 	)
+	if test "x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb" != xyes; then
+		AC_CHECK_FUNC(
+			[mbedtls_ssl_set_export_keys_cb],
+			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [1], [yes])],
+			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
+		)
+		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" != xyes; then
+			have_export_keying_material="no"
+		fi
+	fi
 
 	AC_CHECK_FUNC(
 		[mbedtls_ctr_drbg_update_ret],
-		AC_DEFINE([HAVE_CTR_DRBG_UPDATE_RET], [1],
+		AC_DEFINE([HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET], [1],
 			  [Use mbedtls_ctr_drbg_update_ret from mbed TLS]),
 	)
 
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 52deef8..b953961 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -82,6 +82,7 @@
 	ovpn_dco_win.h \
 	platform.c platform.h \
 	console.c console.h console_builtin.c console_systemd.c \
+	mbedtls_compat.h \
 	mroute.c mroute.h \
 	mss.c mss.h \
 	mstats.c mstats.h \
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index aaf6ef7..ad3439c 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -989,8 +989,9 @@
 
     return diff;
 }
-/* mbedtls-2.18.0 or newer */
-#ifdef HAVE_MBEDTLS_SSL_TLS_PRF
+/* mbedtls-2.18.0 or newer implements tls_prf, but prf_tls1 is removed
+ * from recent versions, so we use our own implementation if necessary. */
+#if HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)
@@ -999,7 +1000,7 @@
                                        secret_len, "", seed, seed_len, output,
                                        output_len));
 }
-#else  /* ifdef HAVE_MBEDTLS_SSL_TLS_PRF */
+#else /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
 /*
  * Generate the hash required by for the \c tls1_PRF function.
  *
@@ -1128,5 +1129,5 @@
     gc_free(&gc);
     return true;
 }
-#endif /* ifdef HAVE_MBEDTLS_SSL_TLS_PRF */
+#endif /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
 #endif /* ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index fe7c3f9..610215b 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -33,6 +33,8 @@
 #ifndef MBEDTLS_COMPAT_H_
 #define MBEDTLS_COMPAT_H_
 
+#include "syshead.h"
+
 #include "errlevel.h"
 
 #include <mbedtls/cipher.h>
@@ -41,24 +43,25 @@
 #include <mbedtls/md.h>
 #include <mbedtls/pem.h>
 #include <mbedtls/pk.h>
+#include <mbedtls/ssl.h>
 #include <mbedtls/version.h>
 #include <mbedtls/x509_crt.h>
 
-#if MBEDTLS_HAVE_PSA_CRYPTO_H
+#if HAVE_MBEDTLS_PSA_CRYPTO_H
     #include <psa/crypto.h>
 #endif
 
 static inline void
 mbedtls_compat_psa_crypto_init(void)
 {
-#if MBEDTLS_HAVE_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C)
+#if HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C)
     if (psa_crypto_init() != PSA_SUCCESS)
     {
         msg(M_FATAL, "mbedtls: psa_crypto_init() failed");
     }
 #else
     return;
-#endif /* MBEDTLS_HAVE_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
+#endif /* HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
 }
 
 /*
@@ -74,14 +77,14 @@
                                const unsigned char *additional,
                                size_t add_len)
 {
-#if HAVE_CTR_DRBG_UPDATE_RET
+#if HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
     return mbedtls_ctr_drbg_update_ret(ctx, additional, add_len);
 #elif MBEDTLS_VERSION_NUMBER < 0x03020100
     mbedtls_ctr_drbg_update(ctx, additional, add_len);
     return 0;
 #else
     return mbedtls_ctr_drbg_update(ctx, additional, add_len);
-#endif /* HAVE_CTR_DRBG_UPDATE_RET */
+#endif /* HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET */
 }
 
 static inline int
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 4ece37e..5168484 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -173,6 +173,16 @@
 }
 
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
+
+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+/*
+ * Key export callback for older versions of mbed TLS, to be used with
+ * mbedtls_ssl_conf_export_keys_ext_cb(). It is called with the master
+ * secret, client random and server random, and the type of PRF function
+ * to use.
+ *
+ * Mbed TLS stores this callback in the mbedtls_ssl_config struct and it
+ * is used in the mbedtls_ssl_contexts set up from that config. */
 int
 mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
                            const unsigned char *kb, size_t maclen,
@@ -193,8 +203,55 @@
     memcpy(cache->master_secret, ms, sizeof(cache->master_secret));
     cache->tls_prf_type = tls_prf_type;
 
-    return true;
+    return 0;
 }
+#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+/*
+ * Key export callback for newer versions of mbed TLS, to be used with
+ * mbedtls_ssl_set_export_keys_cb(). When used with TLS 1.2, the callback
+ * is called with the TLS 1.2 master secret, client random, server random
+ * and the type of PRF to use. With TLS 1.3, it is called with several
+ * different keys (indicated by type), but unfortunately not the exporter
+ * master secret.
+ *
+ * Unlike in older versions, the callback is not stored in the
+ * mbedtls_ssl_config. It is placed in the mbedtls_ssl_context after it
+ * has been set up. */
+void
+mbedtls_ssl_export_keys_cb(void *p_expkey,
+                           mbedtls_ssl_key_export_type type,
+                           const unsigned char *secret,
+                           size_t secret_len,
+                           const unsigned char client_random[32],
+                           const unsigned char server_random[32],
+                           mbedtls_tls_prf_types tls_prf_type)
+{
+    /* Since we can't get the TLS 1.3 exporter master secret, we ignore all key
+     * types except MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET. */
+    if (type != MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET)
+    {
+        return;
+    }
+
+    struct tls_session *session = p_expkey;
+    struct key_state_ssl *ks_ssl = &session->key[KS_PRIMARY].ks_ssl;
+    struct tls_key_cache *cache = &ks_ssl->tls_key_cache;
+
+    /* The TLS 1.2 master secret has a fixed size, so if secret_len has
+     * a different value, something is wrong with mbed TLS. */
+    if (secret_len != sizeof(cache->master_secret))
+    {
+        msg(M_FATAL,
+            "ERROR: Incorrect TLS 1.2 master secret length: Got %zu, expected %zu",
+            secret_len, sizeof(cache->master_secret));
+    }
+
+    memcpy(cache->client_server_random, client_random, 32);
+    memcpy(cache->client_server_random + 32, server_random, 32);
+    memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
+    cache->tls_prf_type = tls_prf_type;
+}
+#endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
 
 bool
 key_state_export_keying_material(struct tls_session *session,
@@ -1205,8 +1262,8 @@
         mbedtls_ssl_conf_max_version(ks_ssl->ssl_config, major, minor);
     }
 
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
-    /* Initialize keying material exporter */
+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+    /* Initialize keying material exporter, old style. */
     mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
                                         mbedtls_ssl_export_keys_cb, session);
 #endif
@@ -1216,6 +1273,11 @@
     mbedtls_ssl_init(ks_ssl->ctx);
     mbed_ok(mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config));
 
+#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+    /* Initialize keying material exporter, new style. */
+    mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_export_keys_cb, session);
+#endif
+
     /* Initialise BIOs */
     ALLOC_OBJ_CLEAR(ks_ssl->bio_ctx, bio_ctx);
     mbedtls_ssl_set_bio(ks_ssl->ctx, ks_ssl->bio_ctx, ssl_bio_write,

