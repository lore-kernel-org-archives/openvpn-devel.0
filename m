From: "MaxF (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 12:56:10 +0000
In-Reply-To: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
References: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c6234d7d1af6ecbfd01e9bd461a27dc49e585c7a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a4i/6HCykT4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Drop Mbed TLS 2.X
 compatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--a4i/6HCykT4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail

to look at the new patch set (#3).


Change subject: Drop Mbed TLS 2.X compatibility
......................................................................

Drop Mbed TLS 2.X compatibility

Mbed TLS 2.28 is out of support since March and adding support for
Mbed TLS 4 will get ugly enough without the old compatibility code lying
around too.

Mbed TLS 2.28 still ships on some supported distributions
(e.g.  Ubuntu 24.04) but nobody is maintaining openvpn-mbedtls packages
there. This commit will probably break on some test machines.

Change-Id: Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
---
M CMakeLists.txt
M README.mbedtls
M config.h.cmake.in
M configure.ac
M src/openvpn/crypto_mbedtls.c
M src/openvpn/mbedtls_compat.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
M src/openvpn/ssl_verify_mbedtls.c
9 files changed, 33 insertions(+), 318 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1412/3

diff --git a/CMakeLists.txt b/CMakeLists.txt
index e812145..8a8054f 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -305,10 +305,6 @@
         set(CMAKE_REQUIRED_LINK_OPTIONS "-L${MBED_LIBRARY_PATH}")
     endif ()
     set(CMAKE_REQUIRED_LIBRARIES "mbedtls;mbedx509;mbedcrypto")
-    check_symbol_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAV=
E_MBEDTLS_CTR_DRBG_UPDATE_RET)
-    check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls/ssl.h =
HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)
-    check_symbol_exists(mbedtls_ssl_set_export_keys_cb mbedtls/ssl.h HAVE_=
MBEDTLS_SSL_SET_EXPORT_KEYS_CB)
-    check_symbol_exists(mbedtls_ssl_tls_prf mbedtls/ssl.h HAVE_MBEDTLS_SSL=
_TLS_PRF)
     check_include_files(psa/crypto.h HAVE_PSA_CRYPTO_H)
 endfunction()

diff --git a/README.mbedtls b/README.mbedtls
index a1012e9..fb30db1 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -7,7 +7,8 @@
 	make
 	make install

-This version requires mbed TLS version >=3D 2.0.0 or >=3D 3.2.1.
+This version requires mbed TLS version >=3D 3.2.1. Versions >=3D 4.0.0 are=
 not
+yet supported. Support for TLS 1.3 requires an Mbed TLS version >=3D 3.6.4.

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
-			[mbedtls >=3D 2.0.0 mbedx509 >=3D 2.0.0 mbedcrypto >=3D 2.0.0],
+			[mbedtls >=3D 3.2.1 mbedx509 >=3D 3.2.1 mbedcrypto >=3D 3.2.1],
 			[have_mbedtls=3D"yes"],
 			[LIBS=3D"${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto"]
 		)
@@ -1020,35 +1020,17 @@
 #include <mbedtls/version.h>
 			]],
 			[[
-#if MBEDTLS_VERSION_NUMBER < 0x02000000 || (MBEDTLS_VERSION_NUMBER >=3D 0x=
03000000 && MBEDTLS_VERSION_NUMBER < 0x03020100)
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([mbed TLS version >=3D 2.0.0 or >=3D 3.2.1 required])]
+		[AC_MSG_ERROR([mbed TLS version >=3D 3.2.1 required])]
 	)

 	AC_CHECK_HEADERS(psa/crypto.h)

-	AC_CHECK_FUNCS([mbedtls_ssl_tls_prf mbedtls_ssl_conf_export_keys_ext_cb])
-
-	if test "x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb" !=3D xyes; then
-		AC_CHECK_FUNCS([mbedtls_ssl_set_export_keys_cb])
-		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" !=3D xyes; then
-			AC_CHECK_FUNC([mbedtls_ssl_export_keying_material])
-			if test "x$ac_cv_func_mbedtls_ssl_export_keying_material" !=3D xyes; th=
en
-				AC_MSG_ERROR(This version of mbed TLS has no support for exporting key=
 material.)
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
 	CFLAGS=3D"${saved_CFLAGS}"
 	LIBS=3D"${saved_LIBS}"
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
-ssl_tls1_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *secret, =
size_t secret_len,
-             uint8_t *output, size_t output_len)
-{
-    return mbed_ok(mbedtls_ssl_tls_prf(MBEDTLS_SSL_TLS_PRF_TLS1, secret, s=
ecret_len, "", seed,
-                                       seed_len, output, output_len));
-}
-#else /* defined(HAVE_MBEDTLS_SSL_TLS_PRF) && defined(MBEDTLS_SSL_TLS_PRF_=
TLS1) */
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

-#if MBEDTLS_VERSION_NUMBER >=3D 0x03000000
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
-#if MBEDTLS_VERSION_NUMBER >=3D 0x03000000
-    return curve_info->tls_id;
-#else
-    return curve_info->grp_id;
-#endif
-}
-
-/*
- * In older versions of mbedtls, mbedtls_ctr_drbg_update() did not return =
an
- * error code, and it was deprecated in favor of mbedtls_ctr_drbg_update_r=
et()
- * which does.
- *
- * In mbedtls 3, this function was removed and mbedtls_ctr_drbg_update() r=
eturns
- * an error code.
- */
-static inline int
-mbedtls_compat_ctr_drbg_update(mbedtls_ctr_drbg_context *ctx, const unsign=
ed char *additional,
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
-mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_=
pk_context *prv,
-                             int (*f_rng)(void *, unsigned char *, size_t)=
, void *p_rng)
-{
-#if MBEDTLS_VERSION_NUMBER < 0x03020100
-    return mbedtls_pk_check_pair(pub, prv);
-#else
-    return mbedtls_pk_check_pair(pub, prv, f_rng, p_rng);
-#endif /* MBEDTLS_VERSION_NUMBER < 0x03020100 */
-}
-
-static inline int
-mbedtls_compat_pk_parse_key(mbedtls_pk_context *ctx, const unsigned char *=
key, size_t keylen,
-                            const unsigned char *pwd, size_t pwdlen,
-                            int (*f_rng)(void *, unsigned char *, size_t),=
 void *p_rng)
-{
-#if MBEDTLS_VERSION_NUMBER < 0x03020100
-    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen);
-#else
-    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen, f_rng, p_rn=
g);
-#endif
-}
-
-static inline int
-mbedtls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx, const char *path,=
 const char *password,
-                                int (*f_rng)(void *, unsigned char *, size=
_t), void *p_rng)
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
-    MBEDTLS_SSL_VERSION_UNKNOWN,         /*!< Context not in use or versio=
n not yet negotiated. */
-    MBEDTLS_SSL_VERSION_TLS1_2 =3D 0x0303, /*!< (D)TLS 1.2 */
-    MBEDTLS_SSL_VERSION_TLS1_3 =3D 0x0304, /*!< (D)TLS 1.3 */
-} mbedtls_ssl_protocol_version;
-
-static inline void
-mbedtls_ssl_conf_min_tls_version(mbedtls_ssl_config *conf, mbedtls_ssl_pro=
tocol_version tls_version)
-{
-    int major =3D (tls_version >> 8) & 0xff;
-    int minor =3D tls_version & 0xff;
-    mbedtls_ssl_conf_min_version(conf, major, minor);
-}
-
-static inline void
-mbedtls_ssl_conf_max_tls_version(mbedtls_ssl_config *conf, mbedtls_ssl_pro=
tocol_version tls_version)
-{
-    int major =3D (tls_version >> 8) & 0xff;
-    int minor =3D tls_version & 0xff;
-    mbedtls_ssl_conf_max_version(conf, major, minor);
-}
-
-static inline void
-mbedtls_ssl_conf_groups(mbedtls_ssl_config *conf, mbedtls_compat_group_id =
*groups)
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
-    *buf_size =3D ctx->buflen;
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
-#if MBEDTLS_VERSION_NUMBER >=3D 0x02040000
 #include <mbedtls/net_sockets.h>
-#else
-#include <mbedtls/net.h>
-#endif
+#include <mbedtls/version.h>

 #include <mbedtls/oid.h>
 #include <mbedtls/pem.h>
@@ -165,50 +160,14 @@
     ASSERT(NULL !=3D ctx);
     return ctx->initialised;
 }
-#ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT
-/* mbedtls_ssl_export_keying_material does not need helper/callback method=
s */
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
-mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms, const =
unsigned char *kb,
-                           size_t maclen, size_t keylen, size_t ivlen,
-                           const unsigned char client_random[32],
-                           const unsigned char server_random[32],
-                           mbedtls_tls_prf_types tls_prf_type)
-{
-    struct tls_session *session =3D p_expkey;
-    struct key_state_ssl *ks_ssl =3D &session->key[KS_PRIMARY].ks_ssl;
-    struct tls_key_cache *cache =3D &ks_ssl->tls_key_cache;
-
-    static_assert(sizeof(ks_ssl->ctx->session->master) =3D=3D sizeof(cache=
->master_secret),
-                  "master size mismatch");
-
-    memcpy(cache->client_server_random, client_random, 32);
-    memcpy(cache->client_server_random + 32, server_random, 32);
-    memcpy(cache->master_secret, ms, sizeof(cache->master_secret));
-    cache->tls_prf_type =3D tls_prf_type;
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
 mbedtls_ssl_export_keys_cb(void *p_expkey, mbedtls_ssl_key_export_type typ=
e,
                            const unsigned char *secret, size_t secret_len,
@@ -240,9 +199,7 @@
     memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
     cache->tls_prf_type =3D tls_prf_type;
 }
-#else  /* ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT */
-#error mbedtls_ssl_conf_export_keys_ext_cb, mbedtls_ssl_set_export_keys_cb=
 or mbedtls_ssl_export_keying_material must be available in mbed TLS
-#endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
+#endif /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */


 bool
@@ -397,7 +354,7 @@

     /* Get number of groups and allocate an array in ctx */
     int groups_count =3D get_num_elements(groups, ':');
-    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_compat_group_id, groups_count +=
 1)
+    ALLOC_ARRAY_CLEAR(ctx->groups, uint16_t, groups_count + 1)

     /* Parse allowed ciphers, getting IDs */
     int i =3D 0;
@@ -413,7 +370,7 @@
         }
         else
         {
-            ctx->groups[i] =3D mbedtls_compat_get_group_id(ci);
+            ctx->groups[i] =3D ci->tls_id;
             i++;
         }
     }
@@ -537,29 +494,29 @@

     if (priv_key_inline)
     {
-        status =3D mbedtls_compat_pk_parse_key(ctx->priv_key, (const unsig=
ned char *)priv_key_file,
-                                             strlen(priv_key_file) + 1, NU=
LL, 0,
-                                             mbedtls_ctr_drbg_random, rand=
_ctx_get());
+        status =3D mbedtls_pk_parse_key(ctx->priv_key, (const unsigned cha=
r *)priv_key_file,
+                                      strlen(priv_key_file) + 1, NULL, 0,
+                                      mbedtls_ctr_drbg_random, rand_ctx_ge=
t());

         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
             char passbuf[512] =3D { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
-            status =3D mbedtls_compat_pk_parse_key(
+            status =3D mbedtls_pk_parse_key(
                 ctx->priv_key, (const unsigned char *)priv_key_file, strle=
n(priv_key_file) + 1,
                 (unsigned char *)passbuf, strlen(passbuf), mbedtls_ctr_drb=
g_random, rand_ctx_get());
         }
     }
     else
     {
-        status =3D mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv_key=
_file, NULL,
-                                                 mbedtls_ctr_drbg_random, =
rand_ctx_get());
+        status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, =
NULL,
+                                          mbedtls_ctr_drbg_random, rand_ct=
x_get());
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
             char passbuf[512] =3D { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
-            status =3D mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv=
_key_file, passbuf,
-                                                     mbedtls_ctr_drbg_rand=
om, rand_ctx_get());
+            status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_fi=
le, passbuf,
+                                              mbedtls_ctr_drbg_random, ran=
d_ctx_get());
         }
     }
     if (!mbed_ok(status))
@@ -575,8 +532,8 @@
         return 1;
     }

-    if (!mbed_ok(mbedtls_compat_pk_check_pair(&ctx->crt_chain->pk, ctx->pr=
iv_key,
-                                              mbedtls_ctr_drbg_random, ran=
d_ctx_get())))
+    if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key,
+                                       mbedtls_ctr_drbg_random, rand_ctx_g=
et())))
     {
         msg(M_WARN, "Private key does not match the certificate");
         return 1;
@@ -610,9 +567,6 @@
  */
 static inline int
 external_pkcs1_sign(void *ctx_voidptr, int (*f_rng)(void *, unsigned char =
*, size_t), void *p_rng,
-#if MBEDTLS_VERSION_NUMBER < 0x03020100
-                    int mode,
-#endif
                     mbedtls_md_type_t md_alg, unsigned int hashlen, const =
unsigned char *hash,
                     unsigned char *sig)
 {
@@ -627,13 +581,6 @@
         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
     }

-#if MBEDTLS_VERSION_NUMBER < 0x03020100
-    if (MBEDTLS_RSA_PRIVATE !=3D mode)
-    {
-        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-    }
-#endif
-
     /*
      * Support a wide range of hashes. TLSv1.1 and before only need SIG_RS=
A_RAW,
      * but TLSv1.2 needs the full suite of hashes.
@@ -1000,7 +947,7 @@

         if (0 !=3D memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash=
)))
         {
-            if (!mbed_ok(mbedtls_compat_ctr_drbg_update(cd_ctx, sha256_has=
h, 32)))
+            if (!mbed_ok(mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32)))
             {
                 msg(M_WARN, "WARNING: failed to personalise random, could =
not update CTR_DRBG");
             }
@@ -1204,12 +1151,6 @@
         mbedtls_ssl_conf_max_tls_version(ks_ssl->ssl_config, version);
     }

-#if defined(HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB) \
-    && !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-    /* Initialize keying material exporter, old style. */
-    mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config, mbedtls_ssl_ex=
port_keys_cb, session);
-#endif
-
     /* Initialise SSL context */
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
@@ -1219,8 +1160,8 @@
      * verification. */
     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));

-#if defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB) && !defined(MBEDTLS_SSL_K=
EYING_MATERIAL_EXPORT)
-    /* Initialize keying material exporter, new style. */
+#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+    /* Initialize the keying material exporter callback. */
     mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_export_keys_cb=
, session);
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
     int *allowed_ciphers;                  /**< List of allowed ciphers fo=
r this connection */
-    mbedtls_compat_group_id *groups;       /**< List of allowed groups for=
 this connection */
+    uint16_t *groups;                      /**< List of allowed groups for=
 this connection */
     mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate types =
*/
 };

diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad
Gerrit-Change-Number: 1412
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: MaxF <max@...2606...>

--a4i/6HCykT4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos. </p>
<p>MaxF <strong>uploaded patch set #3</strong> to this change.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail">View Change</a=
></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">Drop Mbed TLS 2.X compatibility<br><br>Mbed TLS 2.28 is =
out of support since March and adding support for<br>Mbed TLS 4 will get ug=
ly enough without the old compatibility code lying<br>around too.<br><br>Mb=
ed TLS 2.28 still ships on some supported distributions<br>(e.g.  Ubuntu 24=
.04) but nobody is maintaining openvpn-mbedtls packages<br>there. This comm=
it will probably break on some test machines.<br><br>Change-Id: Ia4afabcb60=
06dc9304a4c09f824d9c7c2d4d64ad<br>Signed-off-by: Max Fillinger &lt;maximili=
an.fillinger@...2918...&gt;<br>---<br>M CMakeLists.txt<br>M README.mbedtls<=
br>M config.h.cmake.in<br>M configure.ac<br>M src/openvpn/crypto_mbedtls.c<=
br>M src/openvpn/mbedtls_compat.h<br>M src/openvpn/ssl_mbedtls.c<br>M src/o=
penvpn/ssl_mbedtls.h<br>M src/openvpn/ssl_verify_mbedtls.c<br>9 files chang=
ed, 33 insertions(+), 318 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1412/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index e812145..8a80=
54f 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMake=
Lists.txt</span><br><span>@@ -305,10 +305,6 @@</span><br><span>         set=
(CMAKE_REQUIRED_LINK_OPTIONS &quot;-L${MBED_LIBRARY_PATH}&quot;)</span><br>=
<span>     endif ()</span><br><span>     set(CMAKE_REQUIRED_LIBRARIES &quot=
;mbedtls;mbedx509;mbedcrypto&quot;)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    check_symbol_exists(mbedtls_ctr_drbg_update_ret mbedtls/c=
tr_drbg.h HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    check_symbol_exists(mbedtls_ssl_conf_export_keys_=
ext_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    check_symbol_exists(mbedtls_ss=
l_set_export_keys_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    check_symbol_exists(m=
bedtls_ssl_tls_prf mbedtls/ssl.h HAVE_MBEDTLS_SSL_TLS_PRF)</span><br><span>=
     check_include_files(psa/crypto.h HAVE_PSA_CRYPTO_H)</span><br><span> e=
ndfunction()</span><br><span> </span><br><span>diff --git a/README.mbedtls =
b/README.mbedtls</span><br><span>index a1012e9..fb30db1 100644</span><br><s=
pan>--- a/README.mbedtls</span><br><span>+++ b/README.mbedtls</span><br><sp=
an>@@ -7,7 +7,8 @@</span><br><span> 	make</span><br><span> 	make install</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-This v=
ersion requires mbed TLS version &gt;=3D 2.0.0 or &gt;=3D 3.2.1.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+This version requires mbed TLS=
 version &gt;=3D 3.2.1. Versions &gt;=3D 4.0.0 are not</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+yet supported. Support for TLS 1.3 requi=
res an Mbed TLS version &gt;=3D 3.6.4.</span><br><span> </span><br><span> *=
************************************************************************</s=
pan><br><span> </span><br><span>@@ -23,12 +24,3 @@</span><br><span> </span>=
<br><span>  * X.509 subject line has a different format than the OpenSSL su=
bject line</span><br><span>  * X.509 certificate tracking</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-************************************************************=
*************</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-Mbed TLS 3 has implemented TL=
S 1.3, but support in OpenVPN requires the</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-function mbedtls_ssl_export_keying_material() which is=
 currently not in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-any =
released version. It is available when building mbed TLS from source</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-(mbedtls-3.6 or development =
branch).</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-Without this function, only TLS 1.=
2 is available.</span><br><span>diff --git a/config.h.cmake.in b/config.h.c=
make.in</span><br><span>index 1c443ab..c90d124 100644</span><br><span>--- a=
/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><span>=
@@ -371,10 +371,6 @@</span><br><span> </span><br><span> /* Availability of =
different mbed TLS features and APIs */</span><br><span> #cmakedefine HAVE_=
PSA_CRYPTO_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#cmakedef=
ine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#cmakedefine HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#cmakedefine HAVE_MBEDTLS=
_CTR_DRBG_UPDATE_RET</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
cmakedefine HAVE_MBEDTLS_SSL_TLS_PRF</span><br><span> </span><br><span> /* =
Path to ifconfig tool */</span><br><span> #define IFCONFIG_PATH &quot;@IFCO=
NFIG_PATH@&quot;</span><br><span>diff --git a/configure.ac b/configure.ac</=
span><br><span>index 44c7b65..a6f79ae 100644</span><br><span>--- a/configur=
e.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -995,7 +995,7 @@=
</span><br><span> 	if test -z &quot;${MBEDTLS_CFLAGS}&quot; -a -z &quot;${M=
BEDTLS_LIBS}&quot;; then</span><br><span> 		# if the user did not explicitl=
y specify flags, try to autodetect</span><br><span> 		PKG_CHECK_MODULES([MB=
EDTLS],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[mbedtls &g=
t;=3D 2.0.0 mbedx509 &gt;=3D 2.0.0 mbedcrypto &gt;=3D 2.0.0],</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+			[mbedtls &gt;=3D 3.2.1 mbedx50=
9 &gt;=3D 3.2.1 mbedcrypto &gt;=3D 3.2.1],</span><br><span> 			[have_mbedtl=
s=3D&quot;yes&quot;],</span><br><span> 			[LIBS=3D&quot;${LIBS} -lmbedtls -=
lmbedx509 -lmbedcrypto&quot;]</span><br><span> 		)</span><br><span>@@ -1020=
,35 +1020,17 @@</span><br><span> #include &lt;mbedtls/version.h&gt;</span><=
br><span> 			]],</span><br><span> 			[[</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x02000000 || (MBEDTLS_VE=
RSION_NUMBER &gt;=3D 0x03000000 &amp;&amp; MBEDTLS_VERSION_NUMBER &lt; 0x03=
020100)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_=
VERSION_NUMBER &lt; 0x03020100</span><br><span> #error invalid version</spa=
n><br><span> #endif</span><br><span> 			]]</span><br><span> 		)],</span><br=
><span> 		[AC_MSG_RESULT([ok])],</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-		[AC_MSG_ERROR([mbed TLS version &gt;=3D 2.0.0 or &gt;=3D 3.2.1=
 required])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_M=
SG_ERROR([mbed TLS version &gt;=3D 3.2.1 required])]</span><br><span> 	)</s=
pan><br><span> </span><br><span> 	AC_CHECK_HEADERS(psa/crypto.h)</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_FUNC=
S([mbedtls_ssl_tls_prf mbedtls_ssl_conf_export_keys_ext_cb])</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	if test &quot;x$ac_cv_func_mbedtls_ssl_conf_export_keys_=
ext_cb&quot; !=3D xyes; then</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-		AC_CHECK_FUNCS([mbedtls_ssl_set_export_keys_cb])</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-		if test &quot;x$ac_cv_func_mbedtls_ss=
l_set_export_keys_cb&quot; !=3D xyes; then</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-			AC_CHECK_FUNC([mbedtls_ssl_export_keying_material])=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			if test &quot;x$ac=
_cv_func_mbedtls_ssl_export_keying_material&quot; !=3D xyes; then</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-				AC_MSG_ERROR(This version o=
f mbed TLS has no support for exporting key material.)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-			fi</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-		fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_FUNC(</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-		[mbedtls_ctr_drbg_update_ret],</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-		AC_DEFINE([HAVE_MBEDTLS_CTR_DR=
BG_UPDATE_RET], [1],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
		  [Use mbedtls_ctr_drbg_update_ret from mbed TLS]),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> 	CFLAGS=3D&quot;${saved_CFLAGS}&quot;</span>=
<br><span> 	LIBS=3D&quot;${saved_LIBS}&quot;</span><br><span> 	AC_DEFINE([E=
NABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])</span><br><span>diff --=
git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br=
><span>index 89f0ab9..6688d48 100644</span><br><span>--- a/src/openvpn/cryp=
to_mbedtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><=
span>@@ -41,7 +41,6 @@</span><br><span> #include &quot;integer.h&quot;</spa=
n><br><span> #include &quot;crypto_backend.h&quot;</span><br><span> #includ=
e &quot;otime.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#include &quot;mbedtls_compat.h&quot;</span><br><span> #include &quot;misc.=
h&quot;</span><br><span> </span><br><span> #include &lt;mbedtls/base64.h&gt=
;</span><br><span>@@ -987,17 +986,7 @@</span><br><span> </span><br><span>  =
   return diff;</span><br><span> }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-/* mbedtls-2.18.0 or newer implements tls_prf, but prf_tls1 is=
 removed</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * from recen=
t versions, so we use our own implementation if necessary. */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_MBEDTLS_SSL_TLS_PR=
F) &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-ssl_tls1_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *=
secret, size_t secret_len,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-             uint8_t *output, size_t output_len)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return mbed_ok(mbedtls_ssl_tls_prf(MBEDTLS_SSL_TLS_PRF_TLS1=
, secret, secret_len, &quot;&quot;, seed,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                       seed_len, output=
, output_len));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* defined(HAVE_MBED=
TLS_SSL_TLS_PRF) &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1) */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(=
__GNUC__) || defined(__clang__)</span><br><span> #pragma GCC diagnostic pus=
h</span><br><span> #pragma GCC diagnostic ignored &quot;-Wconversion&quot;<=
/span><br><span>@@ -1135,6 +1124,5 @@</span><br><span> #if defined(__GNUC__=
) || defined(__clang__)</span><br><span> #pragma GCC diagnostic pop</span><=
br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f /* HAVE_MBEDTLS_SSL_TLS_PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1) =
*/</span><br><span> </span><br><span> #endif /* ENABLE_CRYPTO_MBEDTLS */</s=
pan><br><span>diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedt=
ls_compat.h</span><br><span>index 68096c4..540f370 100644</span><br><span>-=
-- a/src/openvpn/mbedtls_compat.h</span><br><span>+++ b/src/openvpn/mbedtls=
_compat.h</span><br><span>@@ -23,10 +23,8 @@</span><br><span> /**</span><br=
><span>  * @file</span><br><span>  * mbedtls compatibility stub.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * This file provide compatibili=
ty stubs for the mbedtls libraries</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * prior to version 3. This version made most fields in struct=
s private</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * and requi=
res accessor functions to be used. For earlier versions, we</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * implement the accessor functions h=
ere.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This file pr=
ovides compatibility stubs to handle API differences between</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * different versions of Mbed TLS.=
</span><br><span>  */</span><br><span> </span><br><span> #ifndef MBEDTLS_CO=
MPAT_H_</span><br><span>@@ -36,27 +34,10 @@</span><br><span> </span><br><sp=
an> #include &quot;errlevel.h&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/cipher.h&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/ctr_drbg.h=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbed=
tls/dhm.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include=
 &lt;mbedtls/ecp.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#include &lt;mbedtls/md.h&gt;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#include &lt;mbedtls/pem.h&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &lt;mbedtls/pk.h&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#include &lt;mbedtls/ssl.h&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/version.h&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/x509_c=
rt.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> #ifdef HAVE_PSA_CRYPTO_H</span><br><span> #include &lt;psa/crypto.h&gt=
;</span><br><span> #endif</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-typedef uint16_t mbedtls_comp=
at_group_id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef mbedtls_ecp_group=
_id mbedtls_compat_group_id;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> static inline void</span><br><span> mbedtls_compat_psa_crypto_ini=
t(void)</span><br><span> {</span><br><span>@@ -70,162 +51,4 @@</span><br><s=
pan> #endif</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static inline mbedtls_compat_group_id</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_compat_get_group_id(cons=
t mbedtls_ecp_curve_info *curve_info)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return curve_info-&gt;tls_id;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return curve_info-&gt;grp_id;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * In older versions of mbedtls, mbedtls_ctr_dr=
bg_update() did not return an</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * error code, and it was deprecated in favor of mbedtls_ctr_drbg_u=
pdate_ret()</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * which d=
oes.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * In mbedtls 3, this function was r=
emoved and mbedtls_ctr_drbg_update() returns</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * an error code.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbe=
dtls_compat_ctr_drbg_update(mbedtls_ctr_drbg_context *ctx, const unsigned c=
har *additional,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                          size_t add_len)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if MBEDTLS_VERSION_NUMBER &gt; 0x03000000</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return mbedtls_ctr_drbg_update(ctx, additional, ad=
d_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(=
HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return mbedtls_ctr_drbg_update_ret(ctx, additional, add_len=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_update(ctx, ad=
ditional, add_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* =
HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_compat_pk_check_pair(co=
nst mbedtls_pk_context *pub, const mbedtls_pk_context *prv,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                             int (*f_=
rng)(void *, unsigned char *, size_t), void *p_rng)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_check_pair(pub, prv)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_check_pair(pub=
, prv, f_rng, p_rng);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x03020100 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static in=
line int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_compa=
t_pk_parse_key(mbedtls_pk_context *ctx, const unsigned char *key, size_t ke=
ylen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
            const unsigned char *pwd, size_t pwdlen,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                            int (*f_rng)(vo=
id *, unsigned char *, size_t), void *p_rng)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return mbedtls_pk_parse_key(ctx, key, keylen, p=
wd, pwdlen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_par=
se_key(ctx, key, keylen, pwd, pwdlen, f_rng, p_rng);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_compat_pk_parse_keyf=
ile(mbedtls_pk_context *ctx, const char *path, const char *password,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
    int (*f_rng)(void *, unsigned char *, size_t), void *p_rng)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_parse_keyf=
ile(ctx, path, password);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return m=
bedtls_pk_parse_keyfile(ctx, path, password, f_rng, p_rng);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSIO=
N_NUMBER &lt; 0x03020100</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-typedef enum</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    MBEDTLS_SSL_VERSION_UN=
KNOWN,         /*!&lt; Context not in use or version not yet negotiated. */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    MBEDTLS_SSL_VERSI=
ON_TLS1_2 =3D 0x0303, /*!&lt; (D)TLS 1.2 */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    MBEDTLS_SSL_VERSION_TLS1_3 =3D 0x0304, /*!&lt; (D=
)TLS 1.3 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-} mbedtls_=
ssl_protocol_version;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_ssl_conf_min_tls=
_version(mbedtls_ssl_config *conf, mbedtls_ssl_protocol_version tls_version=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int major =3D (tls_version &gt;&gt; =
8) &amp; 0xff;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int=
 minor =3D tls_version &amp; 0xff;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    mbedtls_ssl_conf_min_version(conf, major, minor);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-mbedtls_ssl_conf_max_tls_version(mbedtls_ssl_config *conf, mbedtls_ssl_pro=
tocol_version tls_version)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int major =
=3D (tls_version &gt;&gt; 8) &amp; 0xff;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int minor =3D tls_version &amp; 0xff;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ssl_conf_max_version(con=
f, major, minor);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-mbedtls_ssl_conf_groups(mbedtls_ssl_config *co=
nf, mbedtls_compat_group_id *groups)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
bedtls_ssl_conf_curves(conf, groups);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline size_t</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_cipher_info_get_bl=
ock_size(const mbedtls_cipher_info_t *cipher)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return (size_t)cipher-&gt;block_size;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline siz=
e_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_cipher_inf=
o_get_iv_size(const mbedtls_cipher_info_t *cipher)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return (size_t)cipher-&gt;iv_size;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline s=
ize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_cipher_i=
nfo_get_key_bitlen(const mbedtls_cipher_info_t *cipher)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return (size_t)cipher-&gt;key_bitlen;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
inline mbedtls_cipher_mode_t</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-mbedtls_cipher_info_get_mode(const mbedtls_cipher_info_t *cipher)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return cipher-&gt;mode;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic inline const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-mbedtls_cipher_info_get_name(const mbedtls_cipher_info_t *cipher)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return cipher-&gt;name;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static in=
line mbedtls_cipher_type_t</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-mbedtls_cipher_info_get_type(const mbedtls_cipher_info_t *cipher)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return cipher-&gt;type;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 inline size_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls=
_dhm_get_bitlen(const mbedtls_dhm_context *ctx)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return 8 * ctx-&gt;len;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static inline const mbedtls_m=
d_info_t *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_md_=
info_from_ctx(const mbedtls_md_context_t *ctx)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return ctx-&gt;md_info;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static inline const unsigned c=
har *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_pem_get_=
buffer(const mbedtls_pem_context *ctx, size_t *buf_size)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    *buf_size =3D ctx-&gt;buflen;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return ctx-&gt;buf;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inlin=
e int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_x509_crt=
_has_ext_type(const mbedtls_x509_crt *ctx, int ext_type)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return ctx-&gt;ext_types &amp; ext_type;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x03020100 */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /*=
 MBEDTLS_COMPAT_H_ */</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.=
c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 488f9b9..83fca78 100644=
</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/=
openvpn/ssl_mbedtls.c</span><br><span>@@ -49,13 +49,8 @@</span><br><span> #=
include &quot;ssl_verify_mbedtls.h&quot;</span><br><span> #include &lt;mbed=
tls/debug.h&gt;</span><br><span> #include &lt;mbedtls/error.h&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/version.h&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x02=
040000</span><br><span> #include &lt;mbedtls/net_sockets.h&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#include &lt;mbedtls/net.h&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;mbedtls/version.h&gt;</span><br><span> </=
span><br><span> #include &lt;mbedtls/oid.h&gt;</span><br><span> #include &l=
t;mbedtls/pem.h&gt;</span><br><span>@@ -165,50 +160,14 @@</span><br><span> =
    ASSERT(NULL !=3D ctx);</span><br><span>     return ctx-&gt;initialised;=
</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/* mbedtls_ssl_export_keying_material does not need helpe=
r/callback methods */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#elif defined(HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if !defined(MBEDTLS_SSL_KEYING_MATERIA=
L_EXPORT)</span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Key export callback for older versions of mbed TLS, to be used w=
ith</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mbedtls_ssl_con=
f_export_keys_ext_cb(). It is called with the master</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * secret, client random and server random,=
 and the type of PRF function</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * to use.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Mbed TLS stores thi=
s callback in the mbedtls_ssl_config struct and it</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * is used in the mbedtls_ssl_contexts set up =
from that config. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_ssl_export_=
keys_cb(void *p_expkey, const unsigned char *ms, const unsigned char *kb,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
    size_t maclen, size_t keylen, size_t ivlen,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                           const unsigned char cl=
ient_random[32],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                      const unsigned char server_random[32],</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                           mbedtls_t=
ls_prf_types tls_prf_type)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_=
session *session =3D p_expkey;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct key_state_ssl *ks_ssl =3D &amp;session-&gt;key[KS_PRIMA=
RY].ks_ssl;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 tls_key_cache *cache =3D &amp;ks_ssl-&gt;tls_key_cache;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    static_assert(sizeof(ks_ssl-&gt;ctx-&gt;session-&gt;maste=
r) =3D=3D sizeof(cache-&gt;master_secret),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                  &quot;master size mismatch&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    memcpy(cache-&gt;client_server_random, =
client_random, 32);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  memcpy(cache-&gt;client_server_random + 32, server_random, 32);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    memcpy(cache-&gt;master_sec=
ret, ms, sizeof(cache-&gt;master_secret));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    cache-&gt;tls_prf_type =3D tls_prf_type;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif=
 defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Key export callback for newer versions of mbed TLS, to be used with=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mbedtls_ssl_set_ex=
port_keys_cb(). When used with TLS 1.2, the callback</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * is called with the TLS 1.2 master secret=
, client random, server random</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * and the type of PRF to use. With TLS 1.3, it is called with sev=
eral</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * different keys=
 (indicated by type), but unfortunately not the exporter</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * master secret.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Unlike in older versions, the callback is not stored in the=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mbedtls_ssl_config=
. It is placed in the mbedtls_ssl_context after it</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * has been set up. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * If we don&#39;t have mbedtls_ssl_expor=
t_keying_material(), we use</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * mbedtls_ssl_set_export_keys_cb() to obtain a copy of the TLS 1.2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * master secret an=
d compute the TLS-Exporter function ourselves.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Unfortunately, with TLS 1.3, there is no alte=
rnative to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * mbedtl=
s_ssl_export_keying_material().</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span> void</span><br><span> mbedtls_ssl_export_k=
eys_cb(void *p_expkey, mbedtls_ssl_key_export_type type,</span><br><span>  =
                          const unsigned char *secret, size_t secret_len,</=
span><br><span>@@ -240,9 +199,7 @@</span><br><span>     memcpy(cache-&gt;ma=
ster_secret, secret, sizeof(cache-&gt;master_secret));</span><br><span>    =
 cache-&gt;tls_prf_type =3D tls_prf_type;</span><br><span> }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef MBEDTLS_SSL_KEYING_M=
ATERIAL_EXPORT */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#err=
or mbedtls_ssl_conf_export_keys_ext_cb, mbedtls_ssl_set_export_keys_cb or m=
bedtls_ssl_export_keying_material must be available in mbed TLS</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_MBEDTLS_SSL_CONF_E=
XPORT_KEYS_EXT_CB */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */</span><br><span>=
 </span><br><span> </span><br><span> bool</span><br><span>@@ -397,7 +354,7 =
@@</span><br><span> </span><br><span>     /* Get number of groups and alloc=
ate an array in ctx */</span><br><span>     int groups_count =3D get_num_el=
ements(groups, &#39;:&#39;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    ALLOC_ARRAY_CLEAR(ctx-&gt;groups, mbedtls_compat_group_id, group=
s_count + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALL=
OC_ARRAY_CLEAR(ctx-&gt;groups, uint16_t, groups_count + 1)</span><br><span>=
 </span><br><span>     /* Parse allowed ciphers, getting IDs */</span><br><=
span>     int i =3D 0;</span><br><span>@@ -413,7 +370,7 @@</span><br><span>=
         }</span><br><span>         else</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            ctx-&gt;groups[i]=
 =3D mbedtls_compat_get_group_id(ci);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            ctx-&gt;groups[i] =3D ci-&gt;tls_id;</span><b=
r><span>             i++;</span><br><span>         }</span><br><span>     }=
</span><br><span>@@ -537,29 +494,29 @@</span><br><span> </span><br><span>  =
   if (priv_key_inline)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        status =3D mbedtls_compat_pk_parse_key(ctx=
-&gt;priv_key, (const unsigned char *)priv_key_file,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                           =
  strlen(priv_key_file) + 1, NULL, 0,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                             mbedtls_ctr_dr=
bg_random, rand_ctx_get());</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        status =3D mbedtls_pk_parse_key(ctx-&gt;priv_key, (const un=
signed char *)priv_key_file,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                      strlen(priv_key_file) + 1, N=
ULL, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                          mbedtls_ctr_drbg_random, rand_ctx_get());</span><=
br><span> </span><br><span>         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =
=3D=3D status)</span><br><span>         {</span><br><span>             char=
 passbuf[512] =3D { 0 };</span><br><span>             pem_password_callback=
(passbuf, 512, 0, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            status =3D mbedtls_compat_pk_parse_key(</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            status =3D mbedtls_pk_parse_=
key(</span><br><span>                 ctx-&gt;priv_key, (const unsigned cha=
r *)priv_key_file, strlen(priv_key_file) + 1,</span><br><span>             =
    (unsigned char *)passbuf, strlen(passbuf), mbedtls_ctr_drbg_random, ran=
d_ctx_get());</span><br><span>         }</span><br><span>     }</span><br><=
span>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        status =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;=
priv_key, priv_key_file, NULL,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                                 mbedtls_ctr_drbg_=
random, rand_ctx_get());</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key, priv_key=
_file, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                                   mbedtls_ctr_drbg_random, rand_ctx_get())=
;</span><br><span>         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D stat=
us)</span><br><span>         {</span><br><span>             char passbuf[51=
2] =3D { 0 };</span><br><span>             pem_password_callback(passbuf, 5=
12, 0, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    status =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_f=
ile, passbuf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                                             mbedtls_ctr_drbg_random, rand_=
ctx_get());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file, pa=
ssbuf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                 mbedtls_ctr_drbg_random, rand_ctx_get());<=
/span><br><span>         }</span><br><span>     }</span><br><span>     if (=
!mbed_ok(status))</span><br><span>@@ -575,8 +532,8 @@</span><br><span>     =
    return 1;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_compat_pk_check_p=
air(&amp;ctx-&gt;crt_chain-&gt;pk, ctx-&gt;priv_key,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                           =
   mbedtls_ctr_drbg_random, rand_ctx_get())))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_pk_check_pair(&amp;ctx-&=
gt;crt_chain-&gt;pk, ctx-&gt;priv_key,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                       mbedtls_ctr_drbg_=
random, rand_ctx_get())))</span><br><span>     {</span><br><span>         m=
sg(M_WARN, &quot;Private key does not match the certificate&quot;);</span><=
br><span>         return 1;</span><br><span>@@ -610,9 +567,6 @@</span><br><=
span>  */</span><br><span> static inline int</span><br><span> external_pkcs=
1_sign(void *ctx_voidptr, int (*f_rng)(void *, unsigned char *, size_t), vo=
id *p_rng,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS=
_VERSION_NUMBER &lt; 0x03020100</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    int mode,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span>                     mbedtls_md_ty=
pe_t md_alg, unsigned int hashlen, const unsigned char *hash,</span><br><sp=
an>                     unsigned char *sig)</span><br><span> {</span><br><s=
pan>@@ -627,13 +581,6 @@</span><br><span>         return MBEDTLS_ERR_RSA_BA=
D_INPUT_DATA;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (MBEDTLS_RSA_P=
RIVATE !=3D mode)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return MBEDT=
LS_ERR_RSA_BAD_INPUT_DATA;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*</=
span><br><span>      * Support a wide range of hashes. TLSv1.1 and before o=
nly need SIG_RSA_RAW,</span><br><span>      * but TLSv1.2 needs the full su=
ite of hashes.</span><br><span>@@ -1000,7 +947,7 @@</span><br><span> </span=
><br><span>         if (0 !=3D memcmp(old_sha256_hash, sha256_hash, sizeof(=
sha256_hash)))</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (!mbed_ok(mbedtls_compat_ctr_drbg_update=
(cd_ctx, sha256_hash, 32)))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (!mbed_ok(mbedtls_ctr_drbg_update(cd_ctx, sha256_has=
h, 32)))</span><br><span>             {</span><br><span>                 ms=
g(M_WARN, &quot;WARNING: failed to personalise random, could not update CTR=
_DRBG&quot;);</span><br><span>             }</span><br><span>@@ -1204,12 +1=
151,6 @@</span><br><span>         mbedtls_ssl_conf_max_tls_version(ks_ssl-&=
gt;ssl_config, version);</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_MBEDTLS_SSL_CO=
NF_EXPORT_KEYS_EXT_CB) \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &amp;&amp; !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* Initialize keying material =
exporter, old style. */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl-&gt;ssl_config, mbedtls_ss=
l_export_keys_cb, session);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span>     /* Initialise SSL context */</span><br><span>     ALLOC_OBJ_CL=
EAR(ks_ssl-&gt;ctx, mbedtls_ssl_context);</span><br><span>     mbedtls_ssl_=
init(ks_ssl-&gt;ctx);</span><br><span>@@ -1219,8 +1160,8 @@</span><br><span=
>      * verification. */</span><br><span>     ASSERT(mbed_ok(mbedtls_ssl_s=
et_hostname(ks_ssl-&gt;ctx, NULL)));</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KE=
YS_CB) &amp;&amp; !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* Initialize keying material =
exporter, new style. */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Initialize the keying material exp=
orter callback. */</span><br><span>     mbedtls_ssl_set_export_keys_cb(ks_s=
sl-&gt;ctx, mbedtls_ssl_export_keys_cb, session);</span><br><span> #endif</=
span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_mbedtls.h b/s=
rc/openvpn/ssl_mbedtls.h</span><br><span>index 0f85d96..8380a116 100644</sp=
an><br><span>--- a/src/openvpn/ssl_mbedtls.h</span><br><span>+++ b/src/open=
vpn/ssl_mbedtls.h</span><br><span>@@ -39,8 +39,6 @@</span><br><span> #inclu=
de &lt;pkcs11-helper-1.0/pkcs11h-certificate.h&gt;</span><br><span> #endif<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inc=
lude &quot;mbedtls_compat.h&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> typedef struct _buffer_entry buffer_entry;</s=
pan><br><span> </span><br><span> struct _buffer_entry</span><br><span>@@ -1=
30,7 +128,7 @@</span><br><span> #endif</span><br><span>     struct external=
_context external_key;  /**&lt; External key context */</span><br><span>   =
  int *allowed_ciphers;                  /**&lt; List of allowed ciphers fo=
r this connection */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   mbedtls_compat_group_id *groups;       /**&lt; List of allowed groups fo=
r this connection */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint16_t *groups;                      /**&lt; List of allowed groups =
for this connection */</span><br><span>     mbedtls_x509_crt_profile cert_p=
rofile; /**&lt; Allowed certificate types */</span><br><span> };</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src=
/openvpn/ssl_verify_mbedtls.c</span><br><span>index 80ef837..250c806 100644=
</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++=
 b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -35,7 +35,6 @@</span=
><br><span> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span> </span><br>=
<span> #include &quot;crypto_mbedtls.h&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#include &quot;mbedtls_compat.h&quot;</span><br><spa=
n> #include &quot;ssl_verify.h&quot;</span><br><span> #include &lt;mbedtls/=
asn1.h&gt;</span><br><span> #include &lt;mbedtls/error.h&gt;</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1412?usp=3Demail">change 1412</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1412?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4afabcb6006dc9304a4c09f824=
d9c7c2d4d64ad </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1412 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>

</body></html>=

--a4i/6HCykT4=--

