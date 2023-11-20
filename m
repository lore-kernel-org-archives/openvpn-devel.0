From: "MaxF (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 15:35:05 +0000
References: <gerrit.1700494503000.Icb4ae73741dc84ef0ff7ef72721cc12b999f4d03@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <23e0425453aae49e79eb5754cba15ab588dd1f72-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/Bc+ltTYsjI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[release/2.6]: Backport mbed
 TLS 3 support to OpenVPN 2.6
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

--/Bc+ltTYsjI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/404?usp=3Demail

to review the following change.


Change subject: Backport mbed TLS 3 support to OpenVPN 2.6
......................................................................

Backport mbed TLS 3 support to OpenVPN 2.6

Based on commits
- ace7a4f1c271550bb8ad276663e045ab97a46f16
- f53f06316dbb804128fc5cbee1d8edb274ce81df
- efad93d049c318a3bd9ea5956c6ac8237b8d6d70
- b5faf1b2e90fd44c5137a2b8f3da98c7ae482fc1

Change-Id: Icb4ae73741dc84ef0ff7ef72721cc12b999f4d03
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
M README.mbedtls
M config.h.cmake.in
M configure.ac
M src/openvpn/Makefile.am
M src/openvpn/crypto_mbedtls.c
A src/openvpn/mbedtls_compat.h
M src/openvpn/options.c
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_verify_mbedtls.c
9 files changed, 422 insertions(+), 115 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/404/1

diff --git a/README.mbedtls b/README.mbedtls
index d3466fa..ed9d369 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -1,13 +1,13 @@
-This version of OpenVPN has mbed TLS support. To enable follow the followi=
ng
-instructions:
+This version of OpenVPN has mbed TLS support. To enable, follow the
+instructions below:

-To Build and Install,
+To build and install,

 	./configure --with-crypto-library=3Dmbedtls
 	make
 	make install

-This version depends on mbed TLS 2.0 (and requires at least 2.0.0).
+This version requires mbed TLS version >=3D 2.0.0 or >=3D 3.2.1.

 *************************************************************************

@@ -16,7 +16,8 @@
 As of mbed TLS 2.17, it can be licensed *only* under the Apache v2.0 licen=
se.
 That license is incompatible with OpenVPN's GPLv2.

-If you wish to distribute OpenVPN linked with mbed TLS, there are two opti=
ons:
+We are currently in the process of resolving this problem, but for now, if=
 you
+wish to distribute OpenVPN linked with mbed TLS, there are two options:

  * Ensure that your case falls under the system library exception in GPLv2=
, or

@@ -24,9 +25,6 @@
    that may be licensed under GPLv2. Unfortunately, this version is
    unsupported and won't receive any more updates.

-If nothing changes about the license situation, mbed TLS support may be
-deprecated in a future release of OpenVPN.
-
 *************************************************************************

 Due to limitations in the mbed TLS library, the following features are mis=
sing
@@ -42,3 +40,8 @@
  * X.509 subject line has a different format than the OpenSSL subject line
  * X.509 certificate export does not work
  * X.509 certificate tracking
+
+*************************************************************************
+
+Mbed TLS 3 has implemented (parts of) the TLS 1.3 protocol, but we have di=
sabled
+support in OpenVPN because the TLS-Exporter function is not yet implemente=
d.
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 29006ce..e88cb77 100644
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
index 052fe3f..749c857 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1019,13 +1019,19 @@
 #include <mbedtls/version.h>
 			]],
 			[[
-#if MBEDTLS_VERSION_NUMBER < 0x02000000 || MBEDTLS_VERSION_NUMBER >=3D 0x0=
3000000
+#if MBEDTLS_VERSION_NUMBER < 0x02000000 || (MBEDTLS_VERSION_NUMBER >=3D 0x=
03000000 && MBEDTLS_VERSION_NUMBER < 0x03020100)
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([mbed TLS 2.y.z required])]
+		[AC_MSG_ERROR([mbed TLS version >=3D 2.0.0 or >=3D 3.2.1 required])]
+	)
+
+	AC_CHECK_HEADER(
+		psa/crypto.h,
+		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [1], [yes])],
+		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [0], [no])]
 	)

 	AC_CHECK_FUNCS(
@@ -1037,16 +1043,32 @@
 		[AC_MSG_ERROR([mbed TLS check for AEAD support failed])]
 	)

+	AC_CHECK_FUNC(
+		[mbedtls_ssl_tls_prf],
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [1], [yes])],
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]
+	)
+
 	have_export_keying_material=3D"yes"
 	AC_CHECK_FUNC(
 		[mbedtls_ssl_conf_export_keys_ext_cb],
-		,
-		[have_export_keying_material=3D"no"]
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [0], [no])]
 	)
+	if test "x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb" !=3D xyes; then
+		AC_CHECK_FUNC(
+			[mbedtls_ssl_set_export_keys_cb],
+			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [1], [yes])],
+			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
+		)
+		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" !=3D xyes; then
+			have_export_keying_material=3D"no"
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
index 98cac60..ad3439c 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -41,6 +41,7 @@
 #include "integer.h"
 #include "crypto_backend.h"
 #include "otime.h"
+#include "mbedtls_compat.h"
 #include "misc.h"

 #include <mbedtls/base64.h>
@@ -170,10 +171,11 @@
     while (*ciphers !=3D 0)
     {
         const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_typ=
e(*ciphers);
-        if (info && !cipher_kt_insecure(info->name)
-            && (cipher_kt_mode_aead(info->name) || cipher_kt_mode_cbc(info=
->name)))
+        const char *name =3D mbedtls_cipher_info_get_name(info);
+        if (info && name && !cipher_kt_insecure(name)
+            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
         {
-            print_cipher(info->name);
+            print_cipher(name);
         }
         ciphers++;
     }
@@ -184,10 +186,11 @@
     while (*ciphers !=3D 0)
     {
         const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_typ=
e(*ciphers);
-        if (info && cipher_kt_insecure(info->name)
-            && (cipher_kt_mode_aead(info->name) || cipher_kt_mode_cbc(info=
->name)))
+        const char *name =3D mbedtls_cipher_info_get_name(info);
+        if (info && name && cipher_kt_insecure(name)
+            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
         {
-            print_cipher(info->name);
+            print_cipher(name);
         }
         ciphers++;
     }
@@ -295,7 +298,9 @@
     mbedtls_pem_context ctx =3D { 0 };
     bool ret =3D mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPT=
R(&input),
                                                NULL, 0, &use_len));
-    if (ret && !buf_write(dst, ctx.buf, ctx.buflen))
+    size_t buf_size =3D 0;
+    const unsigned char *buf =3D mbedtls_pem_get_buffer(&ctx, &buf_size);
+    if (ret && !buf_write(dst, buf, buf_size))
     {
         ret =3D false;
         msg(M_WARN, "PEM decode error: destination buffer too small");
@@ -416,11 +421,12 @@
         return false;
     }

-    if (cipher->key_bitlen/8 > MAX_CIPHER_KEY_LENGTH)
+    const size_t key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(cipher=
)/8;
+    if (key_bytelen > MAX_CIPHER_KEY_LENGTH)
     {
-        msg(D_LOW, "Cipher algorithm '%s' uses a default key size (%d byte=
s) "
+        msg(D_LOW, "Cipher algorithm '%s' uses a default key size (%zu byt=
es) "
             "which is larger than " PACKAGE_NAME "'s current maximum key s=
ize "
-            "(%d bytes)", ciphername, cipher->key_bitlen/8, MAX_CIPHER_KEY=
_LENGTH);
+            "(%d bytes)", ciphername, key_bytelen, MAX_CIPHER_KEY_LENGTH);
         *reason =3D "disabled due to key size too large";
         return false;
     }
@@ -438,7 +444,7 @@
         return "[null-cipher]";
     }

-    return translate_cipher_name_to_openvpn(cipher_kt->name);
+    return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(c=
ipher_kt));
 }

 int
@@ -451,7 +457,7 @@
         return 0;
     }

-    return cipher_kt->key_bitlen/8;
+    return (int)mbedtls_cipher_info_get_key_bitlen(cipher_kt)/8;
 }

 int
@@ -463,7 +469,7 @@
     {
         return 0;
     }
-    return cipher_kt->iv_size;
+    return (int)mbedtls_cipher_info_get_iv_size(cipher_kt);
 }

 int
@@ -474,7 +480,7 @@
     {
         return 0;
     }
-    return cipher_kt->block_size;
+    return (int)mbedtls_cipher_info_get_block_size(cipher_kt);
 }

 int
@@ -498,16 +504,16 @@

     return !(cipher_kt_block_size(ciphername) >=3D 128 / 8
 #ifdef MBEDTLS_CHACHAPOLY_C
-             || cipher_kt->type =3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305
+             || mbedtls_cipher_info_get_type(cipher_kt) =3D=3D MBEDTLS_CIP=
HER_CHACHA20_POLY1305
 #endif
              );
 }

-static int
+static mbedtls_cipher_mode_t
 cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
 {
     ASSERT(NULL !=3D cipher_kt);
-    return cipher_kt->mode;
+    return mbedtls_cipher_info_get_mode(cipher_kt);
 }

 bool
@@ -566,22 +572,29 @@
     CLEAR(*ctx);

     const mbedtls_cipher_info_t *kt =3D cipher_get(ciphername);
-    int key_len =3D kt->key_bitlen/8;
-
     ASSERT(kt);
+    size_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(kt);

     if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
     {
         msg(M_FATAL, "mbed TLS cipher context init #1");
     }

-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, key_len*8, operation)))
+    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, operatio=
n)))
     {
         msg(M_FATAL, "mbed TLS cipher set key");
     }

+    if (mbedtls_cipher_info_get_mode(kt) =3D=3D MBEDTLS_MODE_CBC)
+    {
+        if (!mbed_ok(mbedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_=
PKCS7)))
+        {
+            msg(M_FATAL, "mbed TLS cipher set padding mode");
+        }
+    }
+
     /* make sure we used a big enough key */
-    ASSERT(ctx->key_bitlen <=3D key_len*8);
+    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) <=3D key_bitlen);
 }

 int
@@ -609,7 +622,7 @@
 int
 cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)
 {
-    return mbedtls_cipher_get_block_size(ctx);
+    return (int)mbedtls_cipher_get_block_size(ctx);
 }

 int
@@ -617,7 +630,7 @@
 {
     ASSERT(NULL !=3D ctx);

-    return cipher_kt_mode(ctx->cipher_info);
+    return mbedtls_cipher_get_cipher_mode(ctx);
 }

 bool
@@ -652,7 +665,7 @@
         return 0;
     }

-    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, ctx->cipher_info->iv_s=
ize)))
+    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher=
_get_iv_size(ctx))))
     {
         return 0;
     }
@@ -714,7 +727,7 @@
 {
     size_t olen =3D 0;

-    if (MBEDTLS_DECRYPT !=3D ctx->operation)
+    if (MBEDTLS_DECRYPT !=3D mbedtls_cipher_get_operation(ctx))
     {
         return 0;
     }
@@ -866,7 +879,7 @@
     {
         return 0;
     }
-    return mbedtls_md_get_size(ctx->md_info);
+    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
 }

 void
@@ -936,7 +949,7 @@
     {
         return 0;
     }
-    return mbedtls_md_get_size(ctx->md_info);
+    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
 }

 void
@@ -976,8 +989,9 @@

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
@@ -986,7 +1000,7 @@
                                        secret_len, "", seed, seed_len, out=
put,
                                        output_len));
 }
-#else  /* ifdef HAVE_MBEDTLS_SSL_TLS_PRF */
+#else /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
 /*
  * Generate the hash required by for the \c tls1_PRF function.
  *
@@ -1115,5 +1129,5 @@
     gc_free(&gc);
     return true;
 }
-#endif /* ifdef HAVE_MBEDTLS_SSL_TLS_PRF */
+#endif /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
 #endif /* ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
new file mode 100644
index 0000000..610215b
--- /dev/null
+++ b/src/openvpn/mbedtls_compat.h
@@ -0,0 +1,189 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2023 Fox Crypto B.V. <openvpn@...2507...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/**
+ * @file mbedtls compatibility stub
+ *
+ * This file provide compatibility stubs for the mbedtls libraries
+ * prior to version 3. This version made most fields in structs private
+ * and requires accessor functions to be used. For earlier versions, we
+ * implement the accessor functions here.
+ */
+
+#ifndef MBEDTLS_COMPAT_H_
+#define MBEDTLS_COMPAT_H_
+
+#include "syshead.h"
+
+#include "errlevel.h"
+
+#include <mbedtls/cipher.h>
+#include <mbedtls/ctr_drbg.h>
+#include <mbedtls/dhm.h>
+#include <mbedtls/md.h>
+#include <mbedtls/pem.h>
+#include <mbedtls/pk.h>
+#include <mbedtls/ssl.h>
+#include <mbedtls/version.h>
+#include <mbedtls/x509_crt.h>
+
+#if HAVE_MBEDTLS_PSA_CRYPTO_H
+    #include <psa/crypto.h>
+#endif
+
+static inline void
+mbedtls_compat_psa_crypto_init(void)
+{
+#if HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C)
+    if (psa_crypto_init() !=3D PSA_SUCCESS)
+    {
+        msg(M_FATAL, "mbedtls: psa_crypto_init() failed");
+    }
+#else
+    return;
+#endif /* HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
+}
+
+/*
+ * In older versions of mbedtls, mbedtls_ctr_drbg_update() did not return =
an
+ * error code, and it was deprecated in favor of mbedtls_ctr_drbg_update_r=
et()
+ * which does.
+ *
+ * In mbedtls 3, this function was removed and mbedtls_ctr_drbg_update() r=
eturns
+ * an error code.
+ */
+static inline int
+mbedtls_compat_ctr_drbg_update(mbedtls_ctr_drbg_context *ctx,
+                               const unsigned char *additional,
+                               size_t add_len)
+{
+#if HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
+    return mbedtls_ctr_drbg_update_ret(ctx, additional, add_len);
+#elif MBEDTLS_VERSION_NUMBER < 0x03020100
+    mbedtls_ctr_drbg_update(ctx, additional, add_len);
+    return 0;
+#else
+    return mbedtls_ctr_drbg_update(ctx, additional, add_len);
+#endif /* HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET */
+}
+
+static inline int
+mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_=
pk_context *prv,
+                             int (*f_rng)(void *, unsigned char *, size_t)=
, void *p_rng)
+{
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+    return mbedtls_pk_check_pair(pub, prv);
+#else
+    return mbedtls_pk_check_pair(pub, prv, f_rng, p_rng);
+#endif /* MBEDTLS_VERSION_NUMBER < 0x03020100 */
+}
+
+static inline int
+mbedtls_compat_pk_parse_key(mbedtls_pk_context *ctx,
+                            const unsigned char *key, size_t keylen,
+                            const unsigned char *pwd, size_t pwdlen,
+                            int (*f_rng)(void *, unsigned char *, size_t),=
 void *p_rng)
+{
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen);
+#else
+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen, f_rng, p_rn=
g);
+#endif
+}
+
+static inline int
+mbedtls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx,
+                                const char *path, const char *password,
+                                int (*f_rng)(void *, unsigned char *, size=
_t), void *p_rng)
+{
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+    return mbedtls_pk_parse_keyfile(ctx, path, password);
+#else
+    return mbedtls_pk_parse_keyfile(ctx, path, password, f_rng, p_rng);
+#endif
+}
+
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+static inline size_t
+mbedtls_cipher_info_get_block_size(const mbedtls_cipher_info_t *cipher)
+{
+    return (size_t)cipher->block_size;
+}
+
+static inline size_t
+mbedtls_cipher_info_get_iv_size(const mbedtls_cipher_info_t *cipher)
+{
+    return (size_t)cipher->iv_size;
+}
+
+static inline size_t
+mbedtls_cipher_info_get_key_bitlen(const mbedtls_cipher_info_t *cipher)
+{
+    return (size_t)cipher->key_bitlen;
+}
+
+static inline mbedtls_cipher_mode_t
+mbedtls_cipher_info_get_mode(const mbedtls_cipher_info_t *cipher)
+{
+    return cipher->mode;
+}
+
+static inline const char *
+mbedtls_cipher_info_get_name(const mbedtls_cipher_info_t *cipher)
+{
+    return cipher->name;
+}
+
+static inline mbedtls_cipher_type_t
+mbedtls_cipher_info_get_type(const mbedtls_cipher_info_t *cipher)
+{
+    return cipher->type;
+}
+
+static inline size_t
+mbedtls_dhm_get_bitlen(const mbedtls_dhm_context *ctx)
+{
+    return 8 * ctx->len;
+}
+
+static inline const mbedtls_md_info_t *
+mbedtls_md_info_from_ctx(const mbedtls_md_context_t *ctx)
+{
+    return ctx->md_info;
+}
+
+static inline const unsigned char *
+mbedtls_pem_get_buffer(const mbedtls_pem_context *ctx, size_t *buf_size)
+{
+    *buf_size =3D ctx->buflen;
+    return ctx->buf;
+}
+
+static inline int
+mbedtls_x509_crt_has_ext_type(const mbedtls_x509_crt *ctx, int ext_type)
+{
+    return ctx->ext_types & ext_type;
+}
+#endif /* MBEDTLS_VERSION_NUMBER < 0x03020100 */
+
+#endif /* MBEDTLS_COMPAT_H_ */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7ca77a8..ea09d06 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -653,8 +653,10 @@
     "--verify-x509-name name: Accept connections only from a host with X50=
9 subject\n"
     "                  DN name. The remote host must also pass all other t=
ests\n"
     "                  of verification.\n"
+#ifndef ENABLE_CRYPTO_MBEDTLS
     "--ns-cert-type t: (DEPRECATED) Require that peer certificate was sign=
ed with \n"
     "                  an explicit nsCertType designation t =3D 'client' |=
 'server'.\n"
+#endif
     "--x509-track x  : Save peer X509 attribute x in environment for use b=
y\n"
     "                  plugins and management interface.\n"
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
@@ -9051,6 +9053,10 @@
     }
     else if (streq(p[0], "ns-cert-type") && p[1] && !p[2])
     {
+#ifdef ENABLE_CRYPTO_MBEDTLS
+        msg(msglevel, "--ns-cert-type is not available with mbedtls.");
+        goto err;
+#else
         VERIFY_PERMISSION(OPT_P_GENERAL);
         if (streq(p[1], "server"))
         {
@@ -9065,6 +9071,7 @@
             msg(msglevel, "--ns-cert-type must be 'client' or 'server'");
             goto err;
         }
+#endif /* ENABLE_CRYPTO_MBEDTLS */
     }
     else if (streq(p[0], "remote-cert-ku"))
     {
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 81dd906..9c9167d 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -41,6 +41,7 @@
 #include "buffer.h"
 #include "misc.h"
 #include "manage.h"
+#include "mbedtls_compat.h"
 #include "pkcs11_backend.h"
 #include "ssl_common.h"

@@ -58,25 +59,6 @@
 #include <mbedtls/oid.h>
 #include <mbedtls/pem.h>
=20
-/**
- * Compatibility: mbedtls_ctr_drbg_update was deprecated in mbedtls 2.16 a=
nd
- * replaced with mbedtls_ctr_drbg_update_ret, which returns an error code.
- * For older versions, we call mbedtls_ctr_drbg_update and return 0 (succe=
ss).
- *
- * Note: this change was backported to other mbedTLS branches, therefore we
- * rely on function detection at configure time.
- */
-#ifndef HAVE_CTR_DRBG_UPDATE_RET
-static int
-mbedtls_ctr_drbg_update_ret(mbedtls_ctr_drbg_context *ctx,
-                            const unsigned char *additional,
-                            size_t add_len)
-{
-    mbedtls_ctr_drbg_update(ctx, additional, add_len);
-    return 0;
-}
-#endif
-
 static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =3D
 {
     /* Hashes from SHA-1 and above */
@@ -108,6 +90,7 @@
 void
 tls_init_lib(void)
 {
+    mbedtls_compat_psa_crypto_init();
 }

 void
@@ -190,6 +173,16 @@
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
@@ -210,8 +203,55 @@
     memcpy(cache->master_secret, ms, sizeof(cache->master_secret));
     cache->tls_prf_type =3D tls_prf_type;

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
+    /* Since we can't get the TLS 1.3 exporter master secret, we ignore al=
l key
+     * types except MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET. */
+    if (type !=3D MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET)
+    {
+        return;
+    }
+
+    struct tls_session *session =3D p_expkey;
+    struct key_state_ssl *ks_ssl =3D &session->key[KS_PRIMARY].ks_ssl;
+    struct tls_key_cache *cache =3D &ks_ssl->tls_key_cache;
+
+    /* The TLS 1.2 master secret has a fixed size, so if secret_len has
+     * a different value, something is wrong with mbed TLS. */
+    if (secret_len !=3D sizeof(cache->master_secret))
+    {
+        msg(M_FATAL,
+            "ERROR: Incorrect TLS 1.2 master secret length: Got %zu, expec=
ted %zu",
+            secret_len, sizeof(cache->master_secret));
+    }
+
+    memcpy(cache->client_server_random, client_random, 32);
+    memcpy(cache->client_server_random + 32, server_random, 32);
+    memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
+    cache->tls_prf_type =3D tls_prf_type;
+}
+#endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */

 bool
 key_state_export_keying_material(struct tls_session *session,
@@ -430,7 +470,7 @@
     }

     msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with " counter_format=
 " bit key",
-        (counter_type) 8 * mbedtls_mpi_size(&ctx->dhm_ctx->P));
+        (counter_type) mbedtls_dhm_get_bitlen(ctx->dhm_ctx));
 }

 void
@@ -504,29 +544,40 @@

     if (priv_key_inline)
     {
-        status =3D mbedtls_pk_parse_key(ctx->priv_key,
-                                      (const unsigned char *) priv_key_fil=
e,
-                                      strlen(priv_key_file) + 1, NULL, 0);
+        status =3D mbedtls_compat_pk_parse_key(ctx->priv_key,
+                                             (const unsigned char *) priv_=
key_file,
+                                             strlen(priv_key_file) + 1, NU=
LL, 0,
+                                             mbedtls_ctr_drbg_random,
+                                             rand_ctx_get());

         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
             char passbuf[512] =3D {0};
             pem_password_callback(passbuf, 512, 0, NULL);
-            status =3D mbedtls_pk_parse_key(ctx->priv_key,
-                                          (const unsigned char *) priv_key=
_file,
-                                          strlen(priv_key_file) + 1,
-                                          (unsigned char *) passbuf,
-                                          strlen(passbuf));
+            status =3D mbedtls_compat_pk_parse_key(ctx->priv_key,
+                                                 (const unsigned char *) p=
riv_key_file,
+                                                 strlen(priv_key_file) + 1,
+                                                 (unsigned char *) passbuf,
+                                                 strlen(passbuf),
+                                                 mbedtls_ctr_drbg_random,
+                                                 rand_ctx_get());
         }
     }
     else
     {
-        status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, =
NULL);
+        status =3D mbedtls_compat_pk_parse_keyfile(ctx->priv_key,
+                                                 priv_key_file,
+                                                 NULL,
+                                                 mbedtls_ctr_drbg_random,
+                                                 rand_ctx_get());
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
             char passbuf[512] =3D {0};
             pem_password_callback(passbuf, 512, 0, NULL);
-            status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_fi=
le, passbuf);
+            status =3D mbedtls_compat_pk_parse_keyfile(ctx->priv_key,
+                                                     priv_key_file, passbu=
f,
+                                                     mbedtls_ctr_drbg_rand=
om,
+                                                     rand_ctx_get());
         }
     }
     if (!mbed_ok(status))
@@ -542,7 +593,10 @@
         return 1;
     }

-    if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key)=
))
+    if (!mbed_ok(mbedtls_compat_pk_check_pair(&ctx->crt_chain->pk,
+                                              ctx->priv_key,
+                                              mbedtls_ctr_drbg_random,
+                                              rand_ctx_get())))
     {
         msg(M_WARN, "Private key does not match the certificate");
         return 1;
@@ -558,7 +612,6 @@
  * @param ctx_voidptr   Management external key context.
  * @param f_rng         (Unused)
  * @param p_rng         (Unused)
- * @param mode          RSA mode (should be RSA_PRIVATE).
  * @param md_alg        Message digest ('hash') algorithm type.
  * @param hashlen       Length of hash (overridden by length specified by =
md_alg
  *                      if md_alg !=3D MBEDTLS_MD_NONE).
@@ -572,7 +625,10 @@
  */
 static inline int
 external_pkcs1_sign( void *ctx_voidptr,
-                     int (*f_rng)(void *, unsigned char *, size_t), void *=
p_rng, int mode,
+                     int (*f_rng)(void *, unsigned char *, size_t), void *=
p_rng,
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+                     int mode,
+#endif
                      mbedtls_md_type_t md_alg, unsigned int hashlen, const=
 unsigned char *hash,
                      unsigned char *sig )
 {
@@ -587,10 +643,12 @@
         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
     }

+#if MBEDTLS_VERSION_NUMBER < 0x03020100
     if (MBEDTLS_RSA_PRIVATE !=3D mode)
     {
         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
     }
+#endif

     /*
      * Support a wide range of hashes. TLSv1.1 and before only need SIG_RS=
A_RAW,
@@ -967,7 +1025,7 @@

         if (0 !=3D memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash=
)))
         {
-            if (!mbed_ok(mbedtls_ctr_drbg_update_ret(cd_ctx, sha256_hash, =
32)))
+            if (!mbed_ok(mbedtls_compat_ctr_drbg_update(cd_ctx, sha256_has=
h, 32)))
             {
                 msg(M_WARN, "WARNING: failed to personalise random, could =
not update CTR_DRBG");
             }
@@ -979,13 +1037,15 @@
 int
 tls_version_max(void)
 {
-#if defined(MBEDTLS_SSL_MAJOR_VERSION_3) && defined(MBEDTLS_SSL_MINOR_VERS=
ION_3)
+#if defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
-#elif defined(MBEDTLS_SSL_MAJOR_VERSION_3) && defined(MBEDTLS_SSL_MINOR_VE=
RSION_2)
+#elif defined(MBEDTLS_SSL_PROTO_TLS1_1)
     return TLS_VER_1_1;
-#else
+#elif defined(MBEDTLS_SSL_PROTO_TLS1)
     return TLS_VER_1_0;
-#endif
+#else /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
+    #error "mbedtls is compiled without support for TLS 1.0, 1.1 and 1.2."
+#endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
 }

 /**
@@ -1006,23 +1066,29 @@

     switch (tls_ver)
     {
+#if defined(MBEDTLS_SSL_PROTO_TLS1)
         case TLS_VER_1_0:
             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
             *minor =3D MBEDTLS_SSL_MINOR_VERSION_1;
             break;
+#endif

+#if defined(MBEDTLS_SSL_PROTO_TLS1_1)
         case TLS_VER_1_1:
             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
             *minor =3D MBEDTLS_SSL_MINOR_VERSION_2;
             break;
+#endif

+#if defined(MBEDTLS_SSL_PROTO_TLS1_2)
         case TLS_VER_1_2:
             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
             *minor =3D MBEDTLS_SSL_MINOR_VERSION_3;
             break;
+#endif

         default:
-            msg(M_FATAL, "%s: invalid TLS version %d", __func__, tls_ver);
+            msg(M_FATAL, "%s: invalid or unsupported TLS version %d", __fu=
nc__, tls_ver);
             break;
     }
 }
@@ -1149,17 +1215,17 @@

     /* Initialize minimum TLS version */
     {
-        const int tls_version_min =3D
+        const int configured_tls_version_min =3D
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT)
             &SSLF_TLS_VERSION_MIN_MASK;

-        /* default to TLS 1.0 */
+        /* default to TLS 1.2 */
         int major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
-        int minor =3D MBEDTLS_SSL_MINOR_VERSION_1;
+        int minor =3D MBEDTLS_SSL_MINOR_VERSION_3;

-        if (tls_version_min > TLS_VER_UNSPEC)
+        if (configured_tls_version_min > TLS_VER_UNSPEC)
         {
-            tls_version_to_major_minor(tls_version_min, &major, &minor);
+            tls_version_to_major_minor(configured_tls_version_min, &major,=
 &minor);
         }

         mbedtls_ssl_conf_min_version(ks_ssl->ssl_config, major, minor);
@@ -1167,20 +1233,28 @@

     /* Initialize maximum TLS version */
     {
-        const int tls_version_max =3D
+        const int configured_tls_version_max =3D
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
             &SSLF_TLS_VERSION_MAX_MASK;

-        if (tls_version_max > TLS_VER_UNSPEC)
+        int major =3D 0;
+        int minor =3D 0;
+
+        if (configured_tls_version_max > TLS_VER_UNSPEC)
         {
-            int major, minor;
-            tls_version_to_major_minor(tls_version_max, &major, &minor);
-            mbedtls_ssl_conf_max_version(ks_ssl->ssl_config, major, minor);
+            tls_version_to_major_minor(configured_tls_version_max, &major,=
 &minor);
         }
+        else
+        {
+            /* Default to tls_version_max(). */
+            tls_version_to_major_minor(tls_version_max(), &major, &minor);
+        }
+
+        mbedtls_ssl_conf_max_version(ks_ssl->ssl_config, major, minor);
     }

-#ifdef HAVE_EXPORT_KEYING_MATERIAL
-    /* Initialize keying material exporter */
+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+    /* Initialize keying material exporter, old style. */
     mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
                                         mbedtls_ssl_export_keys_cb, sessio=
n);
 #endif
@@ -1188,7 +1262,12 @@
     /* Initialise SSL context */
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
-    mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config);
+    mbed_ok(mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config));
+
+#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+    /* Initialize keying material exporter, new style. */
+    mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_export_keys_cb=
, session);
+#endif

     /* Initialise BIOs */
     ALLOC_OBJ_CLEAR(ks_ssl->bio_ctx, bio_ctx);
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index a1ddf8d..ce21324 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -35,6 +35,7 @@
 #if defined(ENABLE_CRYPTO_MBEDTLS)

 #include "crypto_mbedtls.h"
+#include "mbedtls_compat.h"
 #include "ssl_verify.h"
 #include <mbedtls/asn1.h>
 #include <mbedtls/error.h>
@@ -432,6 +433,8 @@
     }
 }

+/* Dummy function because Netscape certificate types are not supported in =
OpenVPN with mbedtls.
+ * Returns SUCCESS if usage is NS_CERT_CHECK_NONE, FAILURE otherwise. */
 result_t
 x509_verify_ns_cert_type(mbedtls_x509_crt *cert, const int usage)
 {
@@ -439,18 +442,6 @@
     {
         return SUCCESS;
     }
-    if (usage =3D=3D NS_CERT_CHECK_CLIENT)
-    {
-        return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
-                && (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_CLI=
ENT)) ?
-               SUCCESS : FAILURE;
-    }
-    if (usage =3D=3D NS_CERT_CHECK_SERVER)
-    {
-        return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
-                && (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_SER=
VER)) ?
-               SUCCESS : FAILURE;
-    }

     return FAILURE;
 }
@@ -461,7 +452,7 @@
 {
     msg(D_HANDSHAKE, "Validating certificate key usage");

-    if (!(cert->ext_types & MBEDTLS_X509_EXT_KEY_USAGE))
+    if (!mbedtls_x509_crt_has_ext_type(cert, MBEDTLS_X509_EXT_KEY_USAGE))
     {
         msg(D_TLS_ERRORS,
             "ERROR: Certificate does not have key usage extension");
@@ -486,9 +477,7 @@

     if (fFound !=3D SUCCESS)
     {
-        msg(D_TLS_ERRORS,
-            "ERROR: Certificate has key usage %04x, expected one of:",
-            cert->key_usage);
+        msg(D_TLS_ERRORS, "ERROR: Certificate has invalid key usage, expec=
ted one of:");
         for (size_t i =3D 0; i < expected_len && expected_ku[i]; i++)
         {
             msg(D_TLS_ERRORS, " * %04x", expected_ku[i]);
@@ -503,7 +492,7 @@
 {
     result_t fFound =3D FAILURE;
=20
-    if (!(cert->ext_types & MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))
+    if (!mbedtls_x509_crt_has_ext_type(cert, MBEDTLS_X509_EXT_EXTENDED_KEY=
_USAGE))
     {
         msg(D_HANDSHAKE, "Certificate does not have extended key usage ext=
ension");
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/404?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Icb4ae73741dc84ef0ff7ef72721cc12b999f4d03
Gerrit-Change-Number: 404
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--/Bc+ltTYsjI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/404?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Backport mbed TLS 3 support to OpenVPN 2.6<br><br>Based on co=
mmits<br>- ace7a4f1c271550bb8ad276663e045ab97a46f16<br>- f53f06316dbb804128=
fc5cbee1d8edb274ce81df<br>- efad93d049c318a3bd9ea5956c6ac8237b8d6d70<br>- b=
5faf1b2e90fd44c5137a2b8f3da98c7ae482fc1<br><br>Change-Id: Icb4ae73741dc84ef=
0ff7ef72721cc12b999f4d03<br>Signed-off-by: Max Fillinger &lt;maximilian.fil=
linger@...2507...&gt;<br>---<br>M README.mbedtls<br>M config.h.cmake.in<br>=
M configure.ac<br>M src/openvpn/Makefile.am<br>M src/openvpn/crypto_mbedtls=
.c<br>A src/openvpn/mbedtls_compat.h<br>M src/openvpn/options.c<br>M src/op=
envpn/ssl_mbedtls.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>9 files change=
d, 422 insertions(+), 115 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/04/404/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/README.mbe=
dtls b/README.mbedtls</span><br><span>index d3466fa..ed9d369 100644</span><=
br><span>--- a/README.mbedtls</span><br><span>+++ b/README.mbedtls</span><b=
r><span>@@ -1,13 +1,13 @@</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-This version of OpenVPN has mbed TLS support. To enable follow the foll=
owing</span><br><span style=3D"color: hsl(0, 100%, 40%);">-instructions:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+This version of OpenVP=
N has mbed TLS support. To enable, follow the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+instructions below:</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-To Build and Install,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+To build and install,</span><br=
><span> </span><br><span> 	./configure --with-crypto-library=3Dmbedtls</spa=
n><br><span> 	make</span><br><span> 	make install</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-This version depends on mbed =
TLS 2.0 (and requires at least 2.0.0).</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+This version requires mbed TLS version &gt;=3D 2.0.0 or =
&gt;=3D 3.2.1.</span><br><span> </span><br><span> *************************=
************************************************</span><br><span> </span><b=
r><span>@@ -16,7 +16,8 @@</span><br><span> As of mbed TLS 2.17, it can be l=
icensed *only* under the Apache v2.0 license.</span><br><span> That license=
 is incompatible with OpenVPN&#39;s GPLv2.</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-If you wish to distribute OpenVPN li=
nked with mbed TLS, there are two options:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+We are currently in the process of resolving this pr=
oblem, but for now, if you</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+wish to distribute OpenVPN linked with mbed TLS, there are two optio=
ns:</span><br><span> </span><br><span>  * Ensure that your case falls under=
 the system library exception in GPLv2, or</span><br><span> </span><br><spa=
n>@@ -24,9 +25,6 @@</span><br><span>    that may be licensed under GPLv2. U=
nfortunately, this version is</span><br><span>    unsupported and won&#39;t=
 receive any more updates.</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-If nothing changes about the license situation, mbed=
 TLS support may be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-de=
precated in a future release of OpenVPN.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> **************************************=
***********************************</span><br><span> </span><br><span> Due =
to limitations in the mbed TLS library, the following features are missing<=
/span><br><span>@@ -42,3 +40,8 @@</span><br><span>  * X.509 subject line ha=
s a different format than the OpenSSL subject line</span><br><span>  * X.50=
9 certificate export does not work</span><br><span>  * X.509 certificate tr=
acking</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+********************************=
*****************************************</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+Mbed TLS 3 has implemented (parts of) the TLS 1.3 protocol, but we have =
disabled</span><br><span style=3D"color: hsl(120, 100%, 40%);">+support in =
OpenVPN because the TLS-Exporter function is not yet implemented.</span><br=
><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><span>i=
ndex 29006ce..e88cb77 100644</span><br><span>--- a/config.h.cmake.in</span>=
<br><span>+++ b/config.h.cmake.in</span><br><span>@@ -387,7 +387,10 @@</spa=
n><br><span> #undef HAVE_VSNPRINTF</span><br><span> </span><br><span> /* we=
 always assume a recent mbed TLS version */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define HAVE_CTR_DRBG_UPDATE_RET 1</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define HAVE_MBEDTLS_PSA_CRYPTO_H 1</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_MBEDTLS_S=
SL_TLS_PRF 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB 1</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET 1</span><br><sp=
an> </span><br><span> /* Path to ifconfig tool */</span><br><span> #define =
IFCONFIG_PATH &quot;@IFCONFIG_PATH@&quot;</span><br><span>diff --git a/conf=
igure.ac b/configure.ac</span><br><span>index 052fe3f..749c857 100644</span=
><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br>=
<span>@@ -1019,13 +1019,19 @@</span><br><span> #include &lt;mbedtls/version=
.h&gt;</span><br><span> 			]],</span><br><span> 			[[</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x02000000 =
|| MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x02000000 || (MBE=
DTLS_VERSION_NUMBER &gt;=3D 0x03000000 &amp;&amp; MBEDTLS_VERSION_NUMBER &l=
t; 0x03020100)</span><br><span> #error invalid version</span><br><span> #en=
dif</span><br><span> 			]]</span><br><span> 		)],</span><br><span> 		[AC_MS=
G_RESULT([ok])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[AC=
_MSG_ERROR([mbed TLS 2.y.z required])]</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+		[AC_MSG_ERROR([mbed TLS version &gt;=3D 2.0.0 or &gt;=
=3D 3.2.1 required])]</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	AC_CHECK_HEADER(</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+		psa/crypto.h,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H]=
, [1], [yes])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[A=
C_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [0], [no])]</span><br><span> 	)</span=
><br><span> </span><br><span> 	AC_CHECK_FUNCS(</span><br><span>@@ -1037,16 =
+1043,32 @@</span><br><span> 		[AC_MSG_ERROR([mbed TLS check for AEAD suppo=
rt failed])]</span><br><span> 	)</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	AC_CHECK_FUNC(</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+		[mbedtls_ssl_tls_prf],</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], =
[1], [yes])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_=
DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> 	have_export_keying_material=3D&quot;yes&quot;<=
/span><br><span> 	AC_CHECK_FUNC(</span><br><span> 		[mbedtls_ssl_conf_expor=
t_keys_ext_cb],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-		[have_export_keying_ma=
terial=3D&quot;no&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_DEFINE([HAVE_=
MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [0], [no])]</span><br><span> 	)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	if test &quot;x$ac_cv_fu=
nc_mbedtls_ssl_conf_export_keys_ext_cb&quot; !=3D xyes; then</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+		AC_CHECK_FUNC(</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+			[mbedtls_ssl_set_export_keys_cb],<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[AC_DEFINE([HAVE_=
MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [1], [yes])],</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_=
CB], [0], [no])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		if test &quot;x$a=
c_cv_func_mbedtls_ssl_set_export_keys_cb&quot; !=3D xyes; then</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+			have_export_keying_material=
=3D&quot;no&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		=
fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	fi</span><br><sp=
an> </span><br><span> 	AC_CHECK_FUNC(</span><br><span> 		[mbedtls_ctr_drbg_=
update_ret],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		AC_DEFI=
NE([HAVE_CTR_DRBG_UPDATE_RET], [1],</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+		AC_DEFINE([HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET], [1],</span>=
<br><span> 			  [Use mbedtls_ctr_drbg_update_ret from mbed TLS]),</span><br=
><span> 	)</span><br><span> </span><br><span>diff --git a/src/openvpn/Makef=
ile.am b/src/openvpn/Makefile.am</span><br><span>index 52deef8..b953961 100=
644</span><br><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src=
/openvpn/Makefile.am</span><br><span>@@ -82,6 +82,7 @@</span><br><span> 	ov=
pn_dco_win.h \</span><br><span> 	platform.c platform.h \</span><br><span> 	=
console.c console.h console_builtin.c console_systemd.c \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	mbedtls_compat.h \</span><br><span> =
	mroute.c mroute.h \</span><br><span> 	mss.c mss.h \</span><br><span> 	msta=
ts.c mstats.h \</span><br><span>diff --git a/src/openvpn/crypto_mbedtls.c b=
/src/openvpn/crypto_mbedtls.c</span><br><span>index 98cac60..ad3439c 100644=
</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><span>+++ b/s=
rc/openvpn/crypto_mbedtls.c</span><br><span>@@ -41,6 +41,7 @@</span><br><sp=
an> #include &quot;integer.h&quot;</span><br><span> #include &quot;crypto_b=
ackend.h&quot;</span><br><span> #include &quot;otime.h&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mbedtls_compat.h&qu=
ot;</span><br><span> #include &quot;misc.h&quot;</span><br><span> </span><b=
r><span> #include &lt;mbedtls/base64.h&gt;</span><br><span>@@ -170,10 +171,=
11 @@</span><br><span>     while (*ciphers !=3D 0)</span><br><span>     {</=
span><br><span>         const mbedtls_cipher_info_t *info =3D mbedtls_ciphe=
r_info_from_type(*ciphers);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (info &amp;&amp; !cipher_kt_insecure(info-&gt;name)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; (ciph=
er_kt_mode_aead(info-&gt;name) || cipher_kt_mode_cbc(info-&gt;name)))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *name =
=3D mbedtls_cipher_info_get_name(info);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (info &amp;&amp; name &amp;&amp; !cipher_kt_=
insecure(name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       &amp;&amp; (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            print_cipher(info-&gt;name);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            print_cipher(name);</span><br><span> =
        }</span><br><span>         ciphers++;</span><br><span>     }</span>=
<br><span>@@ -184,10 +186,11 @@</span><br><span>     while (*ciphers !=3D 0=
)</span><br><span>     {</span><br><span>         const mbedtls_cipher_info=
_t *info =3D mbedtls_cipher_info_from_type(*ciphers);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (info &amp;&amp; cipher_kt_insec=
ure(info-&gt;name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         &amp;&amp; (cipher_kt_mode_aead(info-&gt;name) || cipher_kt_mode_c=
bc(info-&gt;name)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        const char *name =3D mbedtls_cipher_info_get_name(info);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (info &amp;&amp; na=
me &amp;&amp; cipher_kt_insecure(name)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            &amp;&amp; (cipher_kt_mode_aead(name) || cip=
her_kt_mode_cbc(name)))</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            print_cipher(info-&gt;name);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            print_cipher(=
name);</span><br><span>         }</span><br><span>         ciphers++;</span=
><br><span>     }</span><br><span>@@ -295,7 +298,9 @@</span><br><span>     =
mbedtls_pem_context ctx =3D { 0 };</span><br><span>     bool ret =3D mbed_o=
k(mbedtls_pem_read_buffer(&amp;ctx, header, footer, BPTR(&amp;input),</span=
><br><span>                                                NULL, 0, &amp;us=
e_len));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ret &=
amp;&amp; !buf_write(dst, ctx.buf, ctx.buflen))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    size_t buf_size =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const unsigned char *buf =3D mbedtls=
_pem_get_buffer(&amp;ctx, &amp;buf_size);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (ret &amp;&amp; !buf_write(dst, buf, buf_size)=
)</span><br><span>     {</span><br><span>         ret =3D false;</span><br>=
<span>         msg(M_WARN, &quot;PEM decode error: destination buffer too s=
mall&quot;);</span><br><span>@@ -416,11 +421,12 @@</span><br><span>        =
 return false;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (cipher-&gt;key_bitlen/8 &gt; MAX_=
CIPHER_KEY_LENGTH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const size_t key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(cipher)/=
8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (key_bytel=
en &gt; MAX_CIPHER_KEY_LENGTH)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;Cipher algorithm &=
#39;%s&#39; uses a default key size (%d bytes) &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;Cipher algorithm=
 &#39;%s&#39; uses a default key size (%zu bytes) &quot;</span><br><span>  =
           &quot;which is larger than &quot; PACKAGE_NAME &quot;&#39;s curr=
ent maximum key size &quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            &quot;(%d bytes)&quot;, ciphername, cipher-&gt;key_bitlen=
/8, MAX_CIPHER_KEY_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            &quot;(%d bytes)&quot;, ciphername, key_bytelen, MAX_CI=
PHER_KEY_LENGTH);</span><br><span>         *reason =3D &quot;disabled due t=
o key size too large&quot;;</span><br><span>         return false;</span><b=
r><span>     }</span><br><span>@@ -438,7 +444,7 @@</span><br><span>        =
 return &quot;[null-cipher]&quot;;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return translate_=
cipher_name_to_openvpn(cipher_kt-&gt;name);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return translate_cipher_name_to_openvpn(mbedtls=
_cipher_info_get_name(cipher_kt));</span><br><span> }</span><br><span> </sp=
an><br><span> int</span><br><span>@@ -451,7 +457,7 @@</span><br><span>     =
    return 0;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt-&gt;key_bitlen/8;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int)mbedtls=
_cipher_info_get_key_bitlen(cipher_kt)/8;</span><br><span> }</span><br><spa=
n> </span><br><span> int</span><br><span>@@ -463,7 +469,7 @@</span><br><spa=
n>     {</span><br><span>         return 0;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt-&gt;iv_si=
ze;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int)=
mbedtls_cipher_info_get_iv_size(cipher_kt);</span><br><span> }</span><br><s=
pan> </span><br><span> int</span><br><span>@@ -474,7 +480,7 @@</span><br><s=
pan>     {</span><br><span>         return 0;</span><br><span>     }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt-&gt;blo=
ck_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
(int)mbedtls_cipher_info_get_block_size(cipher_kt);</span><br><span> }</spa=
n><br><span> </span><br><span> int</span><br><span>@@ -498,16 +504,16 @@</s=
pan><br><span> </span><br><span>     return !(cipher_kt_block_size(cipherna=
me) &gt;=3D 128 / 8</span><br><span> #ifdef MBEDTLS_CHACHAPOLY_C</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-             || cipher_kt-&gt;ty=
pe =3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+             || mbedtls_cipher_info_get_type(cipher_=
kt) =3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305</span><br><span> #endif</span><=
br><span>              );</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static mbedtls_cipher_mode_t</span><br><s=
pan> cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)</span><br><span=
> {</span><br><span>     ASSERT(NULL !=3D cipher_kt);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt-&gt;mode;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_cipher_info_g=
et_mode(cipher_kt);</span><br><span> }</span><br><span> </span><br><span> b=
ool</span><br><span>@@ -566,22 +572,29 @@</span><br><span>     CLEAR(*ctx);=
</span><br><span> </span><br><span>     const mbedtls_cipher_info_t *kt =3D=
 cipher_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int key_len =3D kt-&gt;key_bitlen/8;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(kt);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    size_t key_bitlen =3D mbedtls_ciphe=
r_info_get_key_bitlen(kt);</span><br><span> </span><br><span>     if (!mbed=
_ok(mbedtls_cipher_setup(ctx, kt)))</span><br><span>     {</span><br><span>=
         msg(M_FATAL, &quot;mbed TLS cipher context init #1&quot;);</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, key_len*8, ope=
ration)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!m=
bed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, operation)))</span>=
<br><span>     {</span><br><span>         msg(M_FATAL, &quot;mbed TLS ciphe=
r set key&quot;);</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (mbedtls_cipher_info_get_mode=
(kt) =3D=3D MBEDTLS_MODE_CBC)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (!mbed_ok(mbedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_PKCS7=
)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &=
quot;mbed TLS cipher set padding mode&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     /* make sure we used a big enough key */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(ctx-&gt;key_bitlen &l=
t;=3D key_len*8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ASSERT(mbedtls_cipher_get_key_bitlen(ctx) &lt;=3D key_bitlen);</span><br>=
<span> }</span><br><span> </span><br><span> int</span><br><span>@@ -609,7 +=
622,7 @@</span><br><span> int</span><br><span> cipher_ctx_block_size(const =
mbedtls_cipher_context_t *ctx)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_get_block_size(ctx);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int)mbed=
tls_cipher_get_block_size(ctx);</span><br><span> }</span><br><span> </span>=
<br><span> int</span><br><span>@@ -617,7 +630,7 @@</span><br><span> {</span=
><br><span>     ASSERT(NULL !=3D ctx);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt_mode(ctx-&gt;cipher=
_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return m=
bedtls_cipher_get_cipher_mode(ctx);</span><br><span> }</span><br><span> </s=
pan><br><span> bool</span><br><span>@@ -652,7 +665,7 @@</span><br><span>   =
      return 0;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_set_iv(c=
tx, iv_buf, ctx-&gt;cipher_info-&gt;iv_size)))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_b=
uf, (size_t)mbedtls_cipher_get_iv_size(ctx))))</span><br><span>     {</span=
><br><span>         return 0;</span><br><span>     }</span><br><span>@@ -71=
4,7 +727,7 @@</span><br><span> {</span><br><span>     size_t olen =3D 0;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (MBEDTLS_DECRYPT !=3D ctx-&gt;operation)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (MBEDTLS_DECRYPT !=3D mbedtls_cipher_get_opera=
tion(ctx))</span><br><span>     {</span><br><span>         return 0;</span>=
<br><span>     }</span><br><span>@@ -866,7 +879,7 @@</span><br><span>     {=
</span><br><span>         return 0;</span><br><span>     }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_md_get_size(ctx-&gt=
;md_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span>@@ -936,7 +949,7=
 @@</span><br><span>     {</span><br><span>         return 0;</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return m=
bedtls_md_get_size(ctx-&gt;md_info);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ct=
x));</span><br><span> }</span><br><span> </span><br><span> void</span><br><=
span>@@ -976,8 +989,9 @@</span><br><span> </span><br><span>     return diff=
;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
* mbedtls-2.18.0 or newer */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef HAVE_MBEDTLS_SSL_TLS_PRF</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* mbedtls-2.18.0 or newer implements tls_prf, but prf_t=
ls1 is removed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fr=
om recent versions, so we use our own implementation if necessary. */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_TLS_=
PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1)</span><br><span> bool</spa=
n><br><span> ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t =
*secret,</span><br><span>              int secret_len, uint8_t *output, int=
 output_len)</span><br><span>@@ -986,7 +1000,7 @@</span><br><span>         =
                               secret_len, &quot;&quot;, seed, seed_len, ou=
tput,</span><br><span>                                        output_len));=
</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
lse  /* ifdef HAVE_MBEDTLS_SSL_TLS_PRF */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#else /* HAVE_MBEDTLS_SSL_TLS_PRF &amp;&amp; defined(=
MBEDTLS_SSL_TLS_PRF_TLS1) */</span><br><span> /*</span><br><span>  * Genera=
te the hash required by for the \c tls1_PRF function.</span><br><span>  *</=
span><br><span>@@ -1115,5 +1129,5 @@</span><br><span>     gc_free(&amp;gc);=
</span><br><span>     return true;</span><br><span> }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef HAVE_MBEDTLS_SSL_TLS_PRF */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* HAVE_MBED=
TLS_SSL_TLS_PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1) */</span><br><=
span> #endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span>diff --git a/src/o=
penvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h</span><br><span>new =
file mode 100644</span><br><span>index 0000000..610215b</span><br><span>---=
 /dev/null</span><br><span>+++ b/src/openvpn/mbedtls_compat.h</span><br><sp=
an>@@ -0,0 +1,189 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- A=
n application to securely tunnel IP networks</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with su=
pport for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             session authentication and key exchange,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, p=
acket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             packet compression.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2023 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 This program is distributed in the hope that it will be useful,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; =
without even the implied warranty of</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  =
See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gene=
ral Public License for more details.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  You should have received a copy of the GNU General Public License along=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progr=
am; if not, write to the Free Software Foundation, Inc.,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, B=
oston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @file mbedtls compatibility stub</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * This file provide compatibility stubs for t=
he mbedtls libraries</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * prior to version 3. This version made most fields in structs private</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and requires access=
or functions to be used. For earlier versions, we</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * implement the accessor functions here.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef MBEDTLS_COMPAT_H_</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define MBEDTLS_COMPAT_H_</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;syshead.h&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;errlevel.h&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &lt;mbedtls/cipher.h&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;mbedtls/ctr_drbg.h&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;mbedtls/dhm.h&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/md.h&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/pem.h&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedt=
ls/pk.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;mbedtls/ssl.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;mbedtls/version.h&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;mbedtls/x509_crt.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if HAVE_MBEDTLS_PSA_CRYPTO_H</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    #include &lt;psa/crypto.h&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static inline void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+mbedtls_compat_psa_crypto_init(void)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if HAVE_MBEDTLS_PSA_CRYPTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (psa_crypto_=
init() !=3D PSA_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(M_FATAL, &quot;mbedtls: psa_crypto_init() failed&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif /* HAVE_MBEDTLS_PSA_CRYPTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYP=
TO_C) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * In older versions of mbedtls, mbedtls_ctr_drbg_update() did no=
t return an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * error=
 code, and it was deprecated in favor of mbedtls_ctr_drbg_update_ret()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * which does.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * In mbedtls 3, this function was removed and=
 mbedtls_ctr_drbg_update() returns</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * an error code.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedt=
ls_compat_ctr_drbg_update(mbedtls_ctr_drbg_context *ctx,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                               const u=
nsigned char *additional,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                               size_t add_len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_ctr_drbg_update_ret(ct=
x, additional, add_len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#elif MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    mbedtls_ctr_drbg_update(ctx, additional, =
add_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_ctr_drbg_up=
date(ctx, additional, add_len);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
bedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_pk=
_context *prv,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                        int (*f_rng)(void *, unsigned char *, size_t), void=
 *p_rng)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &l=
t; 0x03020100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn mbedtls_pk_check_pair(pub, prv);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return mbedtls_pk_check_pair(pub, prv, f_rng, p_rng);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER =
&lt; 0x03020100 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static inline int</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+mbedtls_compat_pk_parse_key(mbedtls_pk_c=
ontext *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                     const unsigned char *key, size_t keylen,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                            const=
 unsigned char *pwd, size_t pwdlen,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                            int (*f_rng)(void *, unsigned c=
har *, size_t), void *p_rng)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDT=
LS_VERSION_NUMBER &lt; 0x03020100</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_pk_parse_key=
(ctx, key, keylen, pwd, pwdlen, f_rng, p_rng);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline int</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_compat_pk_parse_k=
eyfile(mbedtls_pk_context *ctx,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                const char *path, const char *p=
assword,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                     int (*f_rng)(void *, unsigned char *, size_t), void *p=
_rng)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; =
0x03020100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n mbedtls_pk_parse_keyfile(ctx, path, password);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return mbedtls_pk_parse_keyfile(ctx, path, password, f_r=
ng, p_rng);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline size_t</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+mbedtls_cipher_info_get_block_size=
(const mbedtls_cipher_info_t *cipher)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return (size_t)cipher-&gt;block_size;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline s=
ize_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_cipher=
_info_get_iv_size(const mbedtls_cipher_info_t *cipher)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return (size_t)cipher-&gt;iv_size;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic inline size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
mbedtls_cipher_info_get_key_bitlen(const mbedtls_cipher_info_t *cipher)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return (size_t)cipher-&gt;key_bitlen;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static inline mbedtls_cipher_mode_t</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+mbedtls_cipher_info_get_mode(const mbedt=
ls_cipher_info_t *cipher)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return c=
ipher-&gt;mode;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline const char *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+mbedtls_cipher_info_get_name(const=
 mbedtls_cipher_info_t *cipher)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn cipher-&gt;name;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline mbedtls_cipher_type_t=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_cipher_info=
_get_type(const mbedtls_cipher_info_t *cipher)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return cipher-&gt;type;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline size_t=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_dhm_get_bit=
len(const mbedtls_dhm_context *ctx)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return 8 * ctx-&gt;len;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static inline const mbedtls_md_=
info_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_md_=
info_from_ctx(const mbedtls_md_context_t *ctx)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return ctx-&gt;md_info;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline const =
unsigned char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbed=
tls_pem_get_buffer(const mbedtls_pem_context *ctx, size_t *buf_size)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    *buf_size =3D ctx-&gt;buflen;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return ctx-&gt;buf;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static inline int</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+mbedtls_x509_crt_has_ext_type(const mbedtls_x509_crt *ctx, int ex=
t_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return ctx-&gt;ext_types &=
amp; ext_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSI=
ON_NUMBER &lt; 0x03020100 */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* =
MBEDTLS_COMPAT_H_ */</span><br><span>diff --git a/src/openvpn/options.c b/s=
rc/openvpn/options.c</span><br><span>index 7ca77a8..ea09d06 100644</span><b=
r><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/optio=
ns.c</span><br><span>@@ -653,8 +653,10 @@</span><br><span>     &quot;--veri=
fy-x509-name name: Accept connections only from a host with X509 subject\n&=
quot;</span><br><span>     &quot;                  DN name. The remote host=
 must also pass all other tests\n&quot;</span><br><span>     &quot;        =
          of verification.\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span>     &quot;--n=
s-cert-type t: (DEPRECATED) Require that peer certificate was signed with \=
n&quot;</span><br><span>     &quot;                  an explicit nsCertType=
 designation t =3D &#39;client&#39; | &#39;server&#39;.\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     &qu=
ot;--x509-track x  : Save peer X509 attribute x in environment for use by\n=
&quot;</span><br><span>     &quot;                  plugins and management =
interface.\n&quot;</span><br><span> #ifdef HAVE_EXPORT_KEYING_MATERIAL</spa=
n><br><span>@@ -9051,6 +9053,10 @@</span><br><span>     }</span><br><span> =
    else if (streq(p[0], &quot;ns-cert-type&quot;) &amp;&amp; p[1] &amp;&am=
p; !p[2])</span><br><span>     {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(msglevel, &quot;--ns-cert-type is not ava=
ilable with mbedtls.&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#else</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</sp=
an><br><span>         if (streq(p[1], &quot;server&quot;))</span><br><span>=
         {</span><br><span>@@ -9065,6 +9071,7 @@</span><br><span>          =
   msg(msglevel, &quot;--ns-cert-type must be &#39;client&#39; or &#39;serv=
er&#39;&quot;);</span><br><span>             goto err;</span><br><span>    =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENA=
BLE_CRYPTO_MBEDTLS */</span><br><span>     }</span><br><span>     else if (=
streq(p[0], &quot;remote-cert-ku&quot;))</span><br><span>     {</span><br><=
span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</sp=
an><br><span>index 81dd906..9c9167d 100644</span><br><span>--- a/src/openvp=
n/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><=
span>@@ -41,6 +41,7 @@</span><br><span> #include &quot;buffer.h&quot;</span=
><br><span> #include &quot;misc.h&quot;</span><br><span> #include &quot;man=
age.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;mbedtls_compat.h&quot;</span><br><span> #include &quot;pkcs11_backen=
d.h&quot;</span><br><span> #include &quot;ssl_common.h&quot;</span><br><spa=
n> </span><br><span>@@ -58,25 +59,6 @@</span><br><span> #include &lt;mbedtl=
s/oid.h&gt;</span><br><span> #include &lt;mbedtls/pem.h&gt;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Compatibility: mbedtls_ctr_drbg_up=
date was deprecated in mbedtls 2.16 and</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * replaced with mbedtls_ctr_drbg_update_ret, which retur=
ns an error code.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * F=
or older versions, we call mbedtls_ctr_drbg_update and return 0 (success).<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Note: this change was backported to ot=
her mbedTLS branches, therefore we</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * rely on function detection at configure time.</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifndef HAVE_CTR_DRBG_UPDATE_RET</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-mbedtls_ctr_drbg_update_ret(mbedtls_ctr_drbg_context =
*ctx,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
            const unsigned char *additional,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                            size_t add_len)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_update(ctx, additional, add_l=
en);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static const mbedtls_x509_crt_profile op=
envpn_x509_crt_profile_legacy =3D</span><br><span> {</span><br><span>     /=
* Hashes from SHA-1 and above */</span><br><span>@@ -108,6 +90,7 @@</span><=
br><span> void</span><br><span> tls_init_lib(void)</span><br><span> {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_compat_psa_cr=
ypto_init();</span><br><span> }</span><br><span> </span><br><span> void</sp=
an><br><span>@@ -190,6 +173,16 @@</span><br><span> }</span><br><span> </spa=
n><br><span> #ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Key export callback for older versions of mbed TLS, to =
be used with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * mbed=
tls_ssl_conf_export_keys_ext_cb(). It is called with the master</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * secret, client random and se=
rver random, and the type of PRF function</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * to use.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * M=
bed TLS stores this callback in the mbedtls_ssl_config struct and it</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * is used in the mbedtls_=
ssl_contexts set up from that config. */</span><br><span> int</span><br><sp=
an> mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,</sp=
an><br><span>                            const unsigned char *kb, size_t ma=
clen,</span><br><span>@@ -210,8 +203,55 @@</span><br><span>     memcpy(cach=
e-&gt;master_secret, ms, sizeof(cache-&gt;master_secret));</span><br><span>=
     cache-&gt;tls_prf_type =3D tls_prf_type;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span> }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif HAVE_MBEDTLS_SSL_=
SET_EXPORT_KEYS_CB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Key export call=
back for newer versions of mbed TLS, to be used with</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * mbedtls_ssl_set_export_keys_cb(). When=
 used with TLS 1.2, the callback</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * is called with the TLS 1.2 master secret, client random, se=
rver random</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and t=
he type of PRF to use. With TLS 1.3, it is called with several</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * different keys (indicated by =
type), but unfortunately not the exporter</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * master secret.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Unlike in older versions, the callback is not stored in the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * mbedtls_ssl_config. It is =
placed in the mbedtls_ssl_context after it</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * has been set up. */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+mbedtls_ssl_export_keys_cb(void *p_expkey,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           mbedtls_ssl_ke=
y_export_type type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                           const unsigned char *secret,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                           size_t secre=
t_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
              const unsigned char client_random[32],</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           const unsigned=
 char server_random[32],</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                           mbedtls_tls_prf_types tls_prf_type)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Since we can&#39;t get the TLS 1.3 exp=
orter master secret, we ignore all key</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * types except MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_=
SECRET. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (t=
ype !=3D MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_se=
ssion *session =3D p_expkey;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct key_state_ssl *ks_ssl =3D &amp;session-&gt;key[KS_PRIMA=
RY].ks_ssl;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct tls_key_cache *cache =3D &amp;ks_ssl-&gt;tls_key_cache;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* The TLS 1.2 master secret has a fixed size, so i=
f secret_len has</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * a different value, something is wrong with mbed TLS. */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (secret_len !=3D sizeof(cach=
e-&gt;master_secret))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_FATAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 &quot;ERROR: Incorrect TLS 1.2 master secret length: Got %zu, expected %zu=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
secret_len, sizeof(cache-&gt;master_secret));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mem=
cpy(cache-&gt;client_server_random, client_random, 32);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    memcpy(cache-&gt;client_server_rand=
om + 32, server_random, 32);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    memcpy(cache-&gt;master_secret, secret, sizeof(cache-&gt;maste=
r_secret));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cach=
e-&gt;tls_prf_type =3D tls_prf_type;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><span> </spa=
n><br><span> bool</span><br><span> key_state_export_keying_material(struct =
tls_session *session,</span><br><span>@@ -430,7 +470,7 @@</span><br><span> =
    }</span><br><span> </span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;Dif=
fie-Hellman initialized with &quot; counter_format &quot; bit key&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        (counter_type) 8=
 * mbedtls_mpi_size(&amp;ctx-&gt;dhm_ctx-&gt;P));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        (counter_type) mbedtls_dhm_get_bitlen=
(ctx-&gt;dhm_ctx));</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span>@@ -504,29 +544,40 @@</span><br><span> </span><br><span=
>     if (priv_key_inline)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        status =3D mbedtls_pk_parse_key(ctx-&gt=
;priv_key,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                           (const unsigned char *) priv_key_file,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
       strlen(priv_key_file) + 1, NULL, 0);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        status =3D mbedtls_compat_pk_parse_key(ctx-=
&gt;priv_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                       (const unsigned char *) priv_key_fil=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                            strlen(priv_key_file) + 1, NULL, 0,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
              mbedtls_ctr_drbg_random,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                             rand_ctx_ge=
t());</span><br><span> </span><br><span>         if (MBEDTLS_ERR_PK_PASSWOR=
D_REQUIRED =3D=3D status)</span><br><span>         {</span><br><span>      =
       char passbuf[512] =3D {0};</span><br><span>             pem_password=
_callback(passbuf, 512, 0, NULL);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            status =3D mbedtls_pk_parse_key(ctx-&gt;priv_key,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
                   (const unsigned char *) priv_key_file,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                       =
   strlen(priv_key_file) + 1,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                          (unsigned char *) passbuf=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
                      strlen(passbuf));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            status =3D mbedtls_compat_pk_parse_key(ctx-=
&gt;priv_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                           (const unsigned char *) priv_key=
_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                    strlen(priv_key_file) + 1,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
                 (unsigned char *) passbuf,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                                 st=
rlen(passbuf),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                            mbedtls_ctr_drbg_random,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                       rand_ctx_get());</span><br><span>         }</span><b=
r><span>     }</span><br><span>     else</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        status =3D mbedtls_pk_par=
se_keyfile(ctx-&gt;priv_key, priv_key_file, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        status =3D mbedtls_compat_pk_parse_k=
eyfile(ctx-&gt;priv_key,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                                 priv_key_file,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                       NULL,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                                 mbedtls_ctr_drbg_=
random,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                                     rand_ctx_get());</span><br><span>     =
    if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)</span><br><span>   =
      {</span><br><span>             char passbuf[512] =3D {0};</span><br><=
span>             pem_password_callback(passbuf, 512, 0, NULL);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            status =3D mbedtls_pk=
_parse_keyfile(ctx-&gt;priv_key, priv_key_file, passbuf);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            status =3D mbedtls_compat=
_pk_parse_keyfile(ctx-&gt;priv_key,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                                     priv_k=
ey_file, passbuf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                                   mbedtls_ctr_drbg_random,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                                  rand_ctx_get());</span><br><span>        =
 }</span><br><span>     }</span><br><span>     if (!mbed_ok(status))</span>=
<br><span>@@ -542,7 +593,10 @@</span><br><span>         return 1;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (!mbed_ok(mbedtls_pk_check_pair(&amp;ctx-&gt;crt_chain-&gt=
;pk, ctx-&gt;priv_key)))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!mbed_ok(mbedtls_compat_pk_check_pair(&amp;ctx-&gt;crt_chain-&=
gt;pk,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                 ctx-&gt;priv_key,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                            =
  mbedtls_ctr_drbg_random,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                              rand_ctx_get())))</spa=
n><br><span>     {</span><br><span>         msg(M_WARN, &quot;Private key d=
oes not match the certificate&quot;);</span><br><span>         return 1;</s=
pan><br><span>@@ -558,7 +612,6 @@</span><br><span>  * @param ctx_voidptr   =
Management external key context.</span><br><span>  * @param f_rng         (=
Unused)</span><br><span>  * @param p_rng         (Unused)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * @param mode          RSA mode (shoul=
d be RSA_PRIVATE).</span><br><span>  * @param md_alg        Message digest =
(&#39;hash&#39;) algorithm type.</span><br><span>  * @param hashlen       L=
ength of hash (overridden by length specified by md_alg</span><br><span>  *=
                      if md_alg !=3D MBEDTLS_MD_NONE).</span><br><span>@@ -=
572,7 +625,10 @@</span><br><span>  */</span><br><span> static inline int</s=
pan><br><span> external_pkcs1_sign( void *ctx_voidptr,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                     int (*f_rng)(void *, =
unsigned char *, size_t), void *p_rng, int mode,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                     int (*f_rng)(void *, unsi=
gned char *, size_t), void *p_rng,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     int mode,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>   =
                   mbedtls_md_type_t md_alg, unsigned int hashlen, const un=
signed char *hash,</span><br><span>                      unsigned char *sig=
 )</span><br><span> {</span><br><span>@@ -587,10 +643,12 @@</span><br><span=
>         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if M=
BEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span>     if (MBEDTLS_RSA_=
PRIVATE !=3D mode)</span><br><span>     {</span><br><span>         return M=
BEDTLS_ERR_RSA_BAD_INPUT_DATA;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>=
     /*</span><br><span>      * Support a wide range of hashes. TLSv1.1 and=
 before only need SIG_RSA_RAW,</span><br><span>@@ -967,7 +1025,7 @@</span><=
br><span> </span><br><span>         if (0 !=3D memcmp(old_sha256_hash, sha2=
56_hash, sizeof(sha256_hash)))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (!mbed_ok(mbedtls_ctr_dr=
bg_update_ret(cd_ctx, sha256_hash, 32)))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (!mbed_ok(mbedtls_compat_ctr_drbg_updat=
e(cd_ctx, sha256_hash, 32)))</span><br><span>             {</span><br><span=
>                 msg(M_WARN, &quot;WARNING: failed to personalise random, =
could not update CTR_DRBG&quot;);</span><br><span>             }</span><br>=
<span>@@ -979,13 +1037,15 @@</span><br><span> int</span><br><span> tls_vers=
ion_max(void)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(MBEDTLS_SSL_MAJOR_VERSION_3) &amp;&amp; defined(MBED=
TLS_SSL_MINOR_VERSION_3)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(MBEDTLS_SSL_PROTO_TLS1_2)</span><br><span>     return TLS_=
VER_1_2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined=
(MBEDTLS_SSL_MAJOR_VERSION_3) &amp;&amp; defined(MBEDTLS_SSL_MINOR_VERSION_=
2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(MBE=
DTLS_SSL_PROTO_TLS1_1)</span><br><span>     return TLS_VER_1_1;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#elif defined(MBEDTLS_SSL_PROTO_TLS1)</span><br=
><span>     return TLS_VER_1_0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#el=
se /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    #error &quot;mbedtls is compiled without support=
 for TLS 1.0, 1.1 and 1.2.&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */</span><br><span=
> }</span><br><span> </span><br><span> /**</span><br><span>@@ -1006,23 +106=
6,29 @@</span><br><span> </span><br><span>     switch (tls_ver)</span><br><=
span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(MBEDTLS_SSL_PROTO_TLS1)</span><br><span>         case TLS_VER_1_0:</spa=
n><br><span>             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br>=
<span>             *minor =3D MBEDTLS_SSL_MINOR_VERSION_1;</span><br><span>=
             break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(MBEDTLS_SSL_PROTO_TLS1_1)</span><br><span>         case TL=
S_VER_1_1:</span><br><span>             *major =3D MBEDTLS_SSL_MAJOR_VERSIO=
N_3;</span><br><span>             *minor =3D MBEDTLS_SSL_MINOR_VERSION_2;</=
span><br><span>             break;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS1_2)</span><br><span> =
        case TLS_VER_1_2:</span><br><span>             *major =3D MBEDTLS_S=
SL_MAJOR_VERSION_3;</span><br><span>             *minor =3D MBEDTLS_SSL_MIN=
OR_VERSION_3;</span><br><span>             break;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>    =
     default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(M_FATAL, &quot;%s: invalid TLS version %d&quot;, __func__, tls_ver)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_=
FATAL, &quot;%s: invalid or unsupported TLS version %d&quot;, __func__, tls=
_ver);</span><br><span>             break;</span><br><span>     }</span><br=
><span> }</span><br><span>@@ -1149,17 +1215,17 @@</span><br><span> </span><=
br><span>     /* Initialize minimum TLS version */</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int tls_v=
ersion_min =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const int configured_tls_version_min =3D</span><br><span>             (s=
ession-&gt;opt-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MIN_SHIFT)</span><br=
><span>             &amp;SSLF_TLS_VERSION_MIN_MASK;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* default to TLS 1=
.0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* def=
ault to TLS 1.2 */</span><br><span>         int major =3D MBEDTLS_SSL_MAJOR=
_VERSION_3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
t minor =3D MBEDTLS_SSL_MINOR_VERSION_1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        int minor =3D MBEDTLS_SSL_MINOR_VERSION_3;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (tls_version_min &gt; TLS_VER_UNSPEC)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (configured_tls_version_min &gt; TLS_VER_U=
NSPEC)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            tls_version_to_major_minor(tls_version_min, &amp;ma=
jor, &amp;minor);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          tls_version_to_major_minor(configured_tls_version_min, &amp;major=
, &amp;minor);</span><br><span>         }</span><br><span> </span><br><span=
>         mbedtls_ssl_conf_min_version(ks_ssl-&gt;ssl_config, major, minor)=
;</span><br><span>@@ -1167,20 +1233,28 @@</span><br><span> </span><br><span=
>     /* Initialize maximum TLS version */</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        const int tls_version_m=
ax =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 int configured_tls_version_max =3D</span><br><span>             (session-&=
gt;opt-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT)</span><br><span> =
            &amp;SSLF_TLS_VERSION_MAX_MASK;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (tls_version_max &gt; TL=
S_VER_UNSPEC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  int major =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       int minor =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (con=
figured_tls_version_max &gt; TLS_VER_UNSPEC)</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            int major, mi=
nor;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tls_v=
ersion_to_major_minor(tls_version_max, &amp;major, &amp;minor);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            mbedtls_ssl_conf_max_=
version(ks_ssl-&gt;ssl_config, major, minor);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            tls_version_to_major_minor(configured=
_tls_version_max, &amp;major, &amp;minor);</span><br><span>         }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* Default to tls_version_max=
(). */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            t=
ls_version_to_major_minor(tls_version_max(), &amp;major, &amp;minor);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        mbedtls_ssl_conf_max_version(ks_ssl-&gt;ssl_co=
nfig, major, minor);</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Initialize keyi=
ng material exporter */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* Initialize keying material exporter, ol=
d style. */</span><br><span>     mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl=
-&gt;ssl_config,</span><br><span>                                         m=
bedtls_ssl_export_keys_cb, session);</span><br><span> #endif</span><br><spa=
n>@@ -1188,7 +1262,12 @@</span><br><span>     /* Initialise SSL context */<=
/span><br><span>     ALLOC_OBJ_CLEAR(ks_ssl-&gt;ctx, mbedtls_ssl_context);<=
/span><br><span>     mbedtls_ssl_init(ks_ssl-&gt;ctx);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ssl_setup(ks_ssl-&gt;ctx, ks_s=
sl-&gt;ssl_config);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    mbed_ok(mbedtls_ssl_setup(ks_ssl-&gt;ctx, ks_ssl-&gt;ssl_config));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Initialize key=
ing material exporter, new style. */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    mbedtls_ssl_set_export_keys_cb(ks_ssl-&gt;ctx, mbedtls=
_ssl_export_keys_cb, session);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span> </span><br><span>     /* Initialise BIOs=
 */</span><br><span>     ALLOC_OBJ_CLEAR(ks_ssl-&gt;bio_ctx, bio_ctx);</spa=
n><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl=
_verify_mbedtls.c</span><br><span>index a1ddf8d..ce21324 100644</span><br><=
span>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openv=
pn/ssl_verify_mbedtls.c</span><br><span>@@ -35,6 +35,7 @@</span><br><span> =
#if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span> </span><br><span> #incl=
ude &quot;crypto_mbedtls.h&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;mbedtls_compat.h&quot;</span><br><span> #includ=
e &quot;ssl_verify.h&quot;</span><br><span> #include &lt;mbedtls/asn1.h&gt;=
</span><br><span> #include &lt;mbedtls/error.h&gt;</span><br><span>@@ -432,=
6 +433,8 @@</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Dummy function becau=
se Netscape certificate types are not supported in OpenVPN with mbedtls.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Returns SUCCESS if =
usage is NS_CERT_CHECK_NONE, FAILURE otherwise. */</span><br><span> result_=
t</span><br><span> x509_verify_ns_cert_type(mbedtls_x509_crt *cert, const i=
nt usage)</span><br><span> {</span><br><span>@@ -439,18 +442,6 @@</span><br=
><span>     {</span><br><span>         return SUCCESS;</span><br><span>    =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (usage =3D=
=3D NS_CERT_CHECK_CLIENT)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn ((cert-&gt;ext_types &amp; MBEDTLS_X509_EXT_NS_CERT_TYPE)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                &amp;&amp; (cert-&gt=
;ns_cert_type &amp; MBEDTLS_X509_NS_CERT_TYPE_SSL_CLIENT)) ?</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-               SUCCESS : FAILURE;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (usage =3D=3D NS_CERT_CHECK_SERVE=
R)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return ((cert-&gt;ext_types=
 &amp; MBEDTLS_X509_EXT_NS_CERT_TYPE)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                &amp;&amp; (cert-&gt;ns_cert_type &amp; MBE=
DTLS_X509_NS_CERT_TYPE_SSL_SERVER)) ?</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-               SUCCESS : FAILURE;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><br><span>     re=
turn FAILURE;</span><br><span> }</span><br><span>@@ -461,7 +452,7 @@</span>=
<br><span> {</span><br><span>     msg(D_HANDSHAKE, &quot;Validating certifi=
cate key usage&quot;);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!(cert-&gt;ext_types &amp; MBEDTLS_X509_EXT_KEY_=
USAGE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mbe=
dtls_x509_crt_has_ext_type(cert, MBEDTLS_X509_EXT_KEY_USAGE))</span><br><sp=
an>     {</span><br><span>         msg(D_TLS_ERRORS,</span><br><span>      =
       &quot;ERROR: Certificate does not have key usage extension&quot;);</=
span><br><span>@@ -486,9 +477,7 @@</span><br><span> </span><br><span>     i=
f (fFound !=3D SUCCESS)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msg(D_TLS_ERRORS,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            &quot;ERROR: Certificate has key u=
sage %04x, expected one of:&quot;,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            cert-&gt;key_usage);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(D_TLS_ERRORS, &quot;ERROR: Certificat=
e has invalid key usage, expected one of:&quot;);</span><br><span>         =
for (size_t i =3D 0; i &lt; expected_len &amp;&amp; expected_ku[i]; i++)</s=
pan><br><span>         {</span><br><span>             msg(D_TLS_ERRORS, &qu=
ot; * %04x&quot;, expected_ku[i]);</span><br><span>@@ -503,7 +492,7 @@</spa=
n><br><span> {</span><br><span>     result_t fFound =3D FAILURE;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(cert=
-&gt;ext_types &amp; MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!mbedtls_x509_crt_has_ext_ty=
pe(cert, MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))</span><br><span>     {</span=
><br><span>         msg(D_HANDSHAKE, &quot;Certificate does not have extend=
ed key usage extension&quot;);</span><br><span>     }</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/404?usp=3Demail">change 404</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/404?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icb4ae73741dc84ef0ff7ef72721=
cc12b999f4d03 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 404 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--/Bc+ltTYsjI=--

