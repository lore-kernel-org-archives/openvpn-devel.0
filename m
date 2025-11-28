From: "MaxF (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 11:05:32 +0000
In-Reply-To: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
References: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e48763bdbb1f08ad258a52e8dc344d95d2776b81-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gdlTUqcMGYk="; charset=UTF-8
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

--gdlTUqcMGYk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail

to look at the new patch set (#2).


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
M README.mbedtls
M configure.ac
M src/openvpn/crypto_mbedtls.c
M src/openvpn/mbedtls_compat.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
M src/openvpn/ssl_verify_mbedtls.c
7 files changed, 21 insertions(+), 231 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1412/2

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
diff --git a/configure.ac b/configure.ac
index 44c7b65..ad86031 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1020,13 +1020,13 @@
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
@@ -1043,12 +1043,6 @@
 		fi
 	fi

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
index 89f0ab9..63c665f 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -41,7 +41,6 @@
 #include "integer.h"
 #include "crypto_backend.h"
 #include "otime.h"
-#include "mbedtls_compat.h"
 #include "misc.h"

 #include <mbedtls/base64.h>
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
index 488f9b9..3e000ef 100644
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
@@ -397,7 +392,7 @@

     /* Get number of groups and allocate an array in ctx */
     int groups_count =3D get_num_elements(groups, ':');
-    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_compat_group_id, groups_count +=
 1)
+    ALLOC_ARRAY_CLEAR(ctx->groups, uint16_t, groups_count + 1)

     /* Parse allowed ciphers, getting IDs */
     int i =3D 0;
@@ -413,7 +408,7 @@
         }
         else
         {
-            ctx->groups[i] =3D mbedtls_compat_get_group_id(ci);
+            ctx->groups[i] =3D ci->tls_id;
             i++;
         }
     }
@@ -537,29 +532,29 @@

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
@@ -575,8 +570,8 @@
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
@@ -610,9 +605,6 @@
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
@@ -627,13 +619,6 @@
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
@@ -1000,7 +985,7 @@

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
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: MaxF <max@...2606...>

--gdlTUqcMGYk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos. </p>
<p>MaxF <strong>uploaded patch set #2</strong> to this change.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail">View Change</a=
></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">Drop Mbed TLS 2.X compatibility<br><br>Mbed TLS 2.28 is =
out of support since March and adding support for<br>Mbed TLS 4 will get ug=
ly enough without the old compatibility code lying<br>around too.<br><br>Mb=
ed TLS 2.28 still ships on some supported distributions<br>(e.g.  Ubuntu 24=
.04) but nobody is maintaining openvpn-mbedtls packages<br>there. This comm=
it will probably break on some test machines.<br><br>Change-Id: Ia4afabcb60=
06dc9304a4c09f824d9c7c2d4d64ad<br>Signed-off-by: Max Fillinger &lt;maximili=
an.fillinger@...2918...&gt;<br>---<br>M README.mbedtls<br>M configure.ac<br=
>M src/openvpn/crypto_mbedtls.c<br>M src/openvpn/mbedtls_compat.h<br>M src/=
openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_mbedtls.h<br>M src/openvpn/ssl_v=
erify_mbedtls.c<br>7 files changed, 21 insertions(+), 231 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/12/1412/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/README.mbedtls b/README.mbedtls</sp=
an><br><span>index a1012e9..fb30db1 100644</span><br><span>--- a/README.mbe=
dtls</span><br><span>+++ b/README.mbedtls</span><br><span>@@ -7,7 +7,8 @@</=
span><br><span> 	make</span><br><span> 	make install</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-This version requires mbed=
 TLS version &gt;=3D 2.0.0 or &gt;=3D 3.2.1.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+This version requires mbed TLS version &gt;=3D 3.2=
.1. Versions &gt;=3D 4.0.0 are not</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+yet supported. Support for TLS 1.3 requires an Mbed TLS vers=
ion &gt;=3D 3.6.4.</span><br><span> </span><br><span> *********************=
****************************************************</span><br><span> </spa=
n><br><span>@@ -23,12 +24,3 @@</span><br><span> </span><br><span>  * X.509 =
subject line has a different format than the OpenSSL subject line</span><br=
><span>  * X.509 certificate tracking</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-*****=
********************************************************************</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-Mbed TLS 3 has implemented TLS 1.3, but support i=
n OpenVPN requires the</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-function mbedtls_ssl_export_keying_material() which is currently not in</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-any released version. It=
 is available when building mbed TLS from source</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-(mbedtls-3.6 or development branch).</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-Without this function, only TLS 1.2 is available.</spa=
n><br><span>diff --git a/configure.ac b/configure.ac</span><br><span>index =
44c7b65..ad86031 100644</span><br><span>--- a/configure.ac</span><br><span>=
+++ b/configure.ac</span><br><span>@@ -1020,13 +1020,13 @@</span><br><span>=
 #include &lt;mbedtls/version.h&gt;</span><br><span> 			]],</span><br><span=
> 			[[</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VE=
RSION_NUMBER &lt; 0x02000000 || (MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000 =
&amp;&amp; MBEDTLS_VERSION_NUMBER &lt; 0x03020100)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</=
span><br><span> #error invalid version</span><br><span> #endif</span><br><s=
pan> 			]]</span><br><span> 		)],</span><br><span> 		[AC_MSG_RESULT([ok])],=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[AC_MSG_ERROR([mbed=
 TLS version &gt;=3D 2.0.0 or &gt;=3D 3.2.1 required])]</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+		[AC_MSG_ERROR([mbed TLS version &gt;=
=3D 3.2.1 required])]</span><br><span> 	)</span><br><span> </span><br><span=
> 	AC_CHECK_HEADERS(psa/crypto.h)</span><br><span>@@ -1043,12 +1043,6 @@</s=
pan><br><span> 		fi</span><br><span> 	fi</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_FUNC(</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-		[mbedtls_ctr_drbg_update_ret],</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-		AC_DEFINE([HAVE_MBEDTLS_CTR_DR=
BG_UPDATE_RET], [1],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
		  [Use mbedtls_ctr_drbg_update_ret from mbed TLS]),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> 	CFLAGS=3D&quot;${saved_CFLAGS}&quot;</span>=
<br><span> 	LIBS=3D&quot;${saved_LIBS}&quot;</span><br><span> 	AC_DEFINE([E=
NABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])</span><br><span>diff --=
git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br=
><span>index 89f0ab9..63c665f 100644</span><br><span>--- a/src/openvpn/cryp=
to_mbedtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><=
span>@@ -41,7 +41,6 @@</span><br><span> #include &quot;integer.h&quot;</spa=
n><br><span> #include &quot;crypto_backend.h&quot;</span><br><span> #includ=
e &quot;otime.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#include &quot;mbedtls_compat.h&quot;</span><br><span> #include &quot;misc.=
h&quot;</span><br><span> </span><br><span> #include &lt;mbedtls/base64.h&gt=
;</span><br><span>diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/m=
bedtls_compat.h</span><br><span>index 68096c4..540f370 100644</span><br><sp=
an>--- a/src/openvpn/mbedtls_compat.h</span><br><span>+++ b/src/openvpn/mbe=
dtls_compat.h</span><br><span>@@ -23,10 +23,8 @@</span><br><span> /**</span=
><br><span>  * @file</span><br><span>  * mbedtls compatibility stub.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * This file provide compati=
bility stubs for the mbedtls libraries</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * prior to version 3. This version made most fields in st=
ructs private</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * and r=
equires accessor functions to be used. For earlier versions, we</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * implement the accessor functio=
ns here.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This fil=
e provides compatibility stubs to handle API differences between</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * different versions of Mbed =
TLS.</span><br><span>  */</span><br><span> </span><br><span> #ifndef MBEDTL=
S_COMPAT_H_</span><br><span>@@ -36,27 +34,10 @@</span><br><span> </span><br=
><span> #include &quot;errlevel.h&quot;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/cipher.h&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/ctr_dr=
bg.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;=
mbedtls/dhm.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inc=
lude &lt;mbedtls/ecp.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#include &lt;mbedtls/md.h&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &lt;mbedtls/pem.h&gt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#include &lt;mbedtls/pk.h&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/ssl.h&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/version.h&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/=
x509_crt.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> #ifdef HAVE_PSA_CRYPTO_H</span><br><span> #include &lt;psa/crypt=
o.h&gt;</span><br><span> #endif</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef uint16_t mbedtl=
s_compat_group_id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef mbedtls_ecp=
_group_id mbedtls_compat_group_id;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> static inline void</span><br><span> mbedtls_compat_psa_cryp=
to_init(void)</span><br><span> {</span><br><span>@@ -70,162 +51,4 @@</span>=
<br><span> #endif</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static inline mbedtls_compat_group_id</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_compat_get_group_i=
d(const mbedtls_ecp_curve_info *curve_info)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return curve_info-&gt;tls_id;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return curve_info-&gt;grp_id;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * In older versions of mbedtls, mbedtls_=
ctr_drbg_update() did not return an</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * error code, and it was deprecated in favor of mbedtls_ctr_=
drbg_update_ret()</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * w=
hich does.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * In mbedtls 3, this function=
 was removed and mbedtls_ctr_drbg_update() returns</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * an error code.</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-mbedtls_compat_ctr_drbg_update(mbedtls_ctr_drbg_context *ctx, const unsi=
gned char *additional,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                               size_t add_len)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if MBEDTLS_VERSION_NUMBER &gt; 0x03000000</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return mbedtls_ctr_drbg_update(ctx, addition=
al, add_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif de=
fined(HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return mbedtls_ctr_drbg_update_ret(ctx, additional, a=
dd_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_update(c=
tx, additional, add_len);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_compat_pk_check_p=
air(const mbedtls_pk_context *pub, const mbedtls_pk_context *prv,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                             in=
t (*f_rng)(void *, unsigned char *, size_t), void *p_rng)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_check_pair(pub, =
prv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_check_pair=
(pub, prv, f_rng, p_rng);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x03020100 */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_com=
pat_pk_parse_key(mbedtls_pk_context *ctx, const unsigned char *key, size_t =
keylen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
              const unsigned char *pwd, size_t pwdlen,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                            int (*f_rng)(v=
oid *, unsigned char *, size_t), void *p_rng)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    return mbedtls_pk_parse_key(ctx, key, keylen, =
pwd, pwdlen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_pa=
rse_key(ctx, key, keylen, pwd, pwdlen, f_rng, p_rng);</span><br><span style=
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
c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 488f9b9..3e000ef 100644=
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
t;mbedtls/pem.h&gt;</span><br><span>@@ -397,7 +392,7 @@</span><br><span> </=
span><br><span>     /* Get number of groups and allocate an array in ctx */=
</span><br><span>     int groups_count =3D get_num_elements(groups, &#39;:&=
#39;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY=
_CLEAR(ctx-&gt;groups, mbedtls_compat_group_id, groups_count + 1)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY_CLEAR(ctx-&gt=
;groups, uint16_t, groups_count + 1)</span><br><span> </span><br><span>    =
 /* Parse allowed ciphers, getting IDs */</span><br><span>     int i =3D 0;=
</span><br><span>@@ -413,7 +408,7 @@</span><br><span>         }</span><br><=
span>         else</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            ctx-&gt;groups[i] =3D mbedtls_compat_ge=
t_group_id(ci);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        ctx-&gt;groups[i] =3D ci-&gt;tls_id;</span><br><span>             i=
++;</span><br><span>         }</span><br><span>     }</span><br><span>@@ -5=
37,29 +532,29 @@</span><br><span> </span><br><span>     if (priv_key_inline=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        status =3D mbedtls_compat_pk_parse_key(ctx-&gt;priv_key, (const =
unsigned char *)priv_key_file,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                             strlen(priv_key_file)=
 + 1, NULL, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                                      mbedtls_ctr_drbg_random, rand_ctx_get=
());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status =
=3D mbedtls_pk_parse_key(ctx-&gt;priv_key, (const unsigned char *)priv_key_=
file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                        strlen(priv_key_file) + 1, NULL, 0,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
   mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><span> </span><br><s=
pan>         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)</span><br>=
<span>         {</span><br><span>             char passbuf[512] =3D { 0 };<=
/span><br><span>             pem_password_callback(passbuf, 512, 0, NULL);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            status =3D=
 mbedtls_compat_pk_parse_key(</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            status =3D mbedtls_pk_parse_key(</span><br><span>    =
             ctx-&gt;priv_key, (const unsigned char *)priv_key_file, strlen=
(priv_key_file) + 1,</span><br><span>                 (unsigned char *)pass=
buf, strlen(passbuf), mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><=
span>         }</span><br><span>     }</span><br><span>     else</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
tatus =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file, =
NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                                 mbedtls_ctr_drbg_random, rand_ctx_get());<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D m=
bedtls_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file, NULL,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
          mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><span>       =
  if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)</span><br><span>     =
    {</span><br><span>             char passbuf[512] =3D { 0 };</span><br><=
span>             pem_password_callback(passbuf, 512, 0, NULL);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            status =3D mbedtls_co=
mpat_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file, passbuf,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
                    mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            status =3D mbedtls_pk=
_parse_keyfile(ctx-&gt;priv_key, priv_key_file, passbuf,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
        mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><span>         =
}</span><br><span>     }</span><br><span>     if (!mbed_ok(status))</span><=
br><span>@@ -575,8 +570,8 @@</span><br><span>         return 1;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (!mbed_ok(mbedtls_compat_pk_check_pair(&amp;ctx-&gt;crt_chai=
n-&gt;pk, ctx-&gt;priv_key,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                              mbedtls_ctr_drbg_random=
, rand_ctx_get())))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!mbed_ok(mbedtls_pk_check_pair(&amp;ctx-&gt;crt_chain-&gt;pk, ctx-&=
gt;priv_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                                mbedtls_ctr_drbg_random, rand_ctx_get())))<=
/span><br><span>     {</span><br><span>         msg(M_WARN, &quot;Private k=
ey does not match the certificate&quot;);</span><br><span>         return 1=
;</span><br><span>@@ -610,9 +605,6 @@</span><br><span>  */</span><br><span>=
 static inline int</span><br><span> external_pkcs1_sign(void *ctx_voidptr, =
int (*f_rng)(void *, unsigned char *, size_t), void *p_rng,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x030=
20100</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    int mode,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span>                     mbedtls_md_type_t md_alg, unsigned int =
hashlen, const unsigned char *hash,</span><br><span>                     un=
signed char *sig)</span><br><span> {</span><br><span>@@ -627,13 +619,6 @@</=
span><br><span>         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (MBEDTLS_RSA_PRIVATE !=3D mode)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>     /*</span><br><span>      * Sup=
port a wide range of hashes. TLSv1.1 and before only need SIG_RSA_RAW,</spa=
n><br><span>      * but TLSv1.2 needs the full suite of hashes.</span><br><=
span>@@ -1000,7 +985,7 @@</span><br><span> </span><br><span>         if (0 =
!=3D memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (!mbed_ok(mbedtls_compat_ctr_drbg_update(cd_ctx, sha256_hash, 32))=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!m=
bed_ok(mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32)))</span><br><span> =
            {</span><br><span>                 msg(M_WARN, &quot;WARNING: f=
ailed to personalise random, could not update CTR_DRBG&quot;);</span><br><s=
pan>             }</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.h b=
/src/openvpn/ssl_mbedtls.h</span><br><span>index 0f85d96..8380a116 100644</=
span><br><span>--- a/src/openvpn/ssl_mbedtls.h</span><br><span>+++ b/src/op=
envpn/ssl_mbedtls.h</span><br><span>@@ -39,8 +39,6 @@</span><br><span> #inc=
lude &lt;pkcs11-helper-1.0/pkcs11h-certificate.h&gt;</span><br><span> #endi=
f</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
nclude &quot;mbedtls_compat.h&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> typedef struct _buffer_entry buffer_entry;<=
/span><br><span> </span><br><span> struct _buffer_entry</span><br><span>@@ =
-130,7 +128,7 @@</span><br><span> #endif</span><br><span>     struct extern=
al_context external_key;  /**&lt; External key context */</span><br><span> =
    int *allowed_ciphers;                  /**&lt; List of allowed ciphers =
for this connection */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    mbedtls_compat_group_id *groups;       /**&lt; List of allowed groups =
for this connection */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint16_t *groups;                      /**&lt; List of allowed group=
s for this connection */</span><br><span>     mbedtls_x509_crt_profile cert=
_profile; /**&lt; Allowed certificate types */</span><br><span> };</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/s=
rc/openvpn/ssl_verify_mbedtls.c</span><br><span>index 80ef837..250c806 1006=
44</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+=
++ b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -35,7 +35,6 @@</sp=
an><br><span> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span> </span><b=
r><span> #include &quot;crypto_mbedtls.h&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#include &quot;mbedtls_compat.h&quot;</span><br><s=
pan> #include &quot;ssl_verify.h&quot;</span><br><span> #include &lt;mbedtl=
s/asn1.h&gt;</span><br><span> #include &lt;mbedtls/error.h&gt;</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1412?usp=3Demail">change 1412</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1412?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4afabcb6006dc9304a4c09f824=
d9c7c2d4d64ad </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1412 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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

--gdlTUqcMGYk=--

