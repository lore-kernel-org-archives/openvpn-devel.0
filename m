From: "MaxF (Code Review)" <gerrit@...515...>
Date: Thu, 19 Oct 2023 17:28:06 +0000
In-Reply-To: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
References: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <bf77cff5656ddd2fd96259b77a7d1ec49ff7666e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pbZwwqE2S7w="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for
 mbedtls 3.X.Y
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

--pbZwwqE2S7w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail

to look at the new patch set (#6).


Change subject: Add support for mbedtls 3.X.Y
......................................................................

Add support for mbedtls 3.X.Y

Most struct fields in mbedtls 3 are private and now need accessor
functions. Most of it was straightforward to adapt, but for two things
there were no accessor functions yet:

 * Netscape certificate type
 * key usage (you can check key usage, but not get the raw bytes)

I decided to remove Netscape certificate type checks when using OpenVPN
with mbedtls. The key usage bytes were printed in an error message, and
I removed that part from it.

Adding the random number functions to the load private key function may
look weird, but the purpose is to make side channels for elliptic curve
operations harder to exploit.

Change-Id: I445a93e84dc54b865b757038d22318ac427fce96
Signed-off-by: Max Fillinger <max@...2606...>
---
M configure.ac
M src/openvpn/crypto_mbedtls.c
A src/openvpn/mbedtls_compat.h
M src/openvpn/options.c
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_verify_mbedtls.c
6 files changed, 323 insertions(+), 100 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/370/6

diff --git a/configure.ac b/configure.ac
index 128ab86..7e5763d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1016,15 +1016,21 @@
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
 	)

+    AC_CHECK_HEADER(
+        psa/crypto.h,
+        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [1], [yes])],
+        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [0], [no])]
+    )
+
 	AC_CHECK_FUNCS(
 		[ \
 			mbedtls_cipher_write_tag \
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 98cac60..bb71561 100644
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
+    size_t key_len =3D mbedtls_cipher_info_get_key_bitlen(kt)/8;

     if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
     {
         msg(M_FATAL, "mbed TLS cipher context init #1");
     }

-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, key_len*8, operation)))
+    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_len*8, operation=
)))
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
+    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) <=3D key_len*8);
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
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
new file mode 100644
index 0000000..fe7c3f9
--- /dev/null
+++ b/src/openvpn/mbedtls_compat.h
@@ -0,0 +1,186 @@
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
+#include "errlevel.h"
+
+#include <mbedtls/cipher.h>
+#include <mbedtls/ctr_drbg.h>
+#include <mbedtls/dhm.h>
+#include <mbedtls/md.h>
+#include <mbedtls/pem.h>
+#include <mbedtls/pk.h>
+#include <mbedtls/version.h>
+#include <mbedtls/x509_crt.h>
+
+#if MBEDTLS_HAVE_PSA_CRYPTO_H
+    #include <psa/crypto.h>
+#endif
+
+static inline void
+mbedtls_compat_psa_crypto_init(void)
+{
+#if MBEDTLS_HAVE_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C)
+    if (psa_crypto_init() !=3D PSA_SUCCESS)
+    {
+        msg(M_FATAL, "mbedtls: psa_crypto_init() failed");
+    }
+#else
+    return;
+#endif /* MBEDTLS_HAVE_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
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
+#if HAVE_CTR_DRBG_UPDATE_RET
+    return mbedtls_ctr_drbg_update_ret(ctx, additional, add_len);
+#elif MBEDTLS_VERSION_NUMBER < 0x03020100
+    mbedtls_ctr_drbg_update(ctx, additional, add_len);
+    return 0;
+#else
+    return mbedtls_ctr_drbg_update(ctx, additional, add_len);
+#endif /* HAVE_CTR_DRBG_UPDATE_RET */
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
index 2b68bac..d238269 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -644,8 +644,10 @@
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
index 81dd906..4e79c82 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -41,6 +41,7 @@
 #include "buffer.h"
 #include "misc.h"
 #include "manage.h"
+#include "mbedtls_compat.h"
 #include "pkcs11_backend.h"
 #include "ssl_common.h"

@@ -49,34 +50,11 @@
 #include <mbedtls/error.h>
 #include <mbedtls/version.h>

-#if MBEDTLS_VERSION_NUMBER >=3D 0x02040000
-    #include <mbedtls/net_sockets.h>
-#else
-    #include <mbedtls/net.h>
-#endif
+#include <mbedtls/net_sockets.h>

 #include <mbedtls/oid.h>
 #include <mbedtls/pem.h>

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
@@ -108,6 +86,7 @@
 void
 tls_init_lib(void)
 {
+    mbedtls_compat_psa_crypto_init();
 }

 void
@@ -430,7 +409,7 @@
     }

     msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with " counter_format=
 " bit key",
-        (counter_type) 8 * mbedtls_mpi_size(&ctx->dhm_ctx->P));
+        (counter_type) mbedtls_dhm_get_bitlen(ctx->dhm_ctx));
 }

 void
@@ -504,29 +483,40 @@

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
@@ -542,7 +532,10 @@
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
@@ -558,7 +551,6 @@
  * @param ctx_voidptr   Management external key context.
  * @param f_rng         (Unused)
  * @param p_rng         (Unused)
- * @param mode          RSA mode (should be RSA_PRIVATE).
  * @param md_alg        Message digest ('hash') algorithm type.
  * @param hashlen       Length of hash (overridden by length specified by =
md_alg
  *                      if md_alg !=3D MBEDTLS_MD_NONE).
@@ -572,7 +564,10 @@
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
@@ -587,10 +582,12 @@
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
@@ -967,7 +964,7 @@

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
@@ -979,12 +976,16 @@
 int
 tls_version_max(void)
 {
-#if defined(MBEDTLS_SSL_MAJOR_VERSION_3) && defined(MBEDTLS_SSL_MINOR_VERS=
ION_3)
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
+    return TLS_VER_1_3;
+#elif defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
-#elif defined(MBEDTLS_SSL_MAJOR_VERSION_3) && defined(MBEDTLS_SSL_MINOR_VE=
RSION_2)
+#elif defined(MBEDTLS_SSL_PROTO_TLS1_1)
     return TLS_VER_1_1;
-#else
+#elif defined(MBEDTLS_SSL_PROTO_TLS1)
     return TLS_VER_1_0;
+#else /* if defined(MBEDTLS_SSL_PROTO_TLS1_3) */
+    #error "mbedtls is compiled without support for any version of TLS."
 #endif
 }

@@ -1006,23 +1007,36 @@

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
+
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
+        case TLS_VER_1_3:
+            *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
+            *minor =3D MBEDTLS_SSL_MINOR_VERSION_4;
+            break;
+#endif

         default:
-            msg(M_FATAL, "%s: invalid TLS version %d", __func__, tls_ver);
+            msg(M_FATAL, "%s: invalid or unsupported TLS version %d", __fu=
nc__, tls_ver);
             break;
     }
 }
@@ -1149,17 +1163,17 @@

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
@@ -1167,16 +1181,24 @@

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

 #ifdef HAVE_EXPORT_KEYING_MATERIAL
@@ -1188,7 +1210,7 @@
     /* Initialise SSL context */
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
-    mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config);
+    mbed_ok(mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config));

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

-    if (!(cert->ext_types & MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))
+    if (!mbedtls_x509_crt_has_ext_type(cert, MBEDTLS_X509_EXT_EXTENDED_KEY=
_USAGE))
     {
         msg(D_HANDSHAKE, "Certificate does not have extended key usage ext=
ension");
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I445a93e84dc54b865b757038d22318ac427fce96
Gerrit-Change-Number: 370
Gerrit-PatchSet: 6
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--pbZwwqE2S7w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF <strong>uploaded patch set #6</strong> to this change.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail">View Change</a>=
</p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>Add support for mbedtls 3.X.Y<br><br>Most struct fields in mbedtls 3 are p=
rivate and now need accessor<br>functions. Most of it was straightforward t=
o adapt, but for two things<br>there were no accessor functions yet:<br><br=
> * Netscape certificate type<br> * key usage (you can check key usage, but=
 not get the raw bytes)<br><br>I decided to remove Netscape certificate typ=
e checks when using OpenVPN<br>with mbedtls. The key usage bytes were print=
ed in an error message, and<br>I removed that part from it.<br><br>Adding t=
he random number functions to the load private key function may<br>look wei=
rd, but the purpose is to make side channels for elliptic curve<br>operatio=
ns harder to exploit.<br><br>Change-Id: I445a93e84dc54b865b757038d22318ac42=
7fce96<br>Signed-off-by: Max Fillinger &lt;max@...2606...&gt;<br>---<br>M c=
onfigure.ac<br>M src/openvpn/crypto_mbedtls.c<br>A src/openvpn/mbedtls_comp=
at.h<br>M src/openvpn/options.c<br>M src/openvpn/ssl_mbedtls.c<br>M src/ope=
nvpn/ssl_verify_mbedtls.c<br>6 files changed, 323 insertions(+), 100 deleti=
ons(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/70/370/6</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</span><br><spa=
n>index 128ab86..7e5763d 100644</span><br><span>--- a/configure.ac</span><b=
r><span>+++ b/configure.ac</span><br><span>@@ -1016,15 +1016,21 @@</span><b=
r><span> #include &lt;mbedtls/version.h&gt;</span><br><span> 			]],</span><=
br><span> 			[[</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MB=
EDTLS_VERSION_NUMBER &lt; 0x02000000 || MBEDTLS_VERSION_NUMBER &gt;=3D 0x03=
000000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_V=
ERSION_NUMBER &lt; 0x02000000 || (MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000=
 &amp;&amp; MBEDTLS_VERSION_NUMBER &lt; 0x03020100)</span><br><span> #error=
 invalid version</span><br><span> #endif</span><br><span> 			]]</span><br><=
span> 		)],</span><br><span> 		[AC_MSG_RESULT([ok])],</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-		[AC_MSG_ERROR([mbed TLS 2.y.z required])]=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_MSG_ERROR([mb=
ed TLS version &gt;=3D 2.0.0 or &gt;=3D 3.2.1 required])]</span><br><span> =
	)</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    AC_CHECK_HEADER(</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        psa/crypto.h,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [1], [yes])],</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        [AC_DEFINE([MBEDTLS_H=
AVE_PSA_CRYPTO_H], [0], [no])]</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> 	AC_CHECK_FUNCS(</span><br><span> 		[ \</span><br><span> 			=
mbedtls_cipher_write_tag \</span><br><span>diff --git a/src/openvpn/crypto_=
mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index 98cac60..bb7=
1561 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><s=
pan>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -41,6 +41,7 @@</s=
pan><br><span> #include &quot;integer.h&quot;</span><br><span> #include &qu=
ot;crypto_backend.h&quot;</span><br><span> #include &quot;otime.h&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mbedtls_=
compat.h&quot;</span><br><span> #include &quot;misc.h&quot;</span><br><span=
> </span><br><span> #include &lt;mbedtls/base64.h&gt;</span><br><span>@@ -1=
70,10 +171,11 @@</span><br><span>     while (*ciphers !=3D 0)</span><br><sp=
an>     {</span><br><span>         const mbedtls_cipher_info_t *info =3D mb=
edtls_cipher_info_from_type(*ciphers);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (info &amp;&amp; !cipher_kt_insecure(info-&gt;n=
ame)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;=
&amp; (cipher_kt_mode_aead(info-&gt;name) || cipher_kt_mode_cbc(info-&gt;na=
me)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
char *name =3D mbedtls_cipher_info_get_name(info);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (info &amp;&amp; name &amp;&amp; =
!cipher_kt_insecure(name)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &amp;&amp; (cipher_kt_mode_aead(name) || cipher_kt_mode_c=
bc(name)))</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            print_cipher(info-&gt;name);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            print_cipher(name);</span>=
<br><span>         }</span><br><span>         ciphers++;</span><br><span>  =
   }</span><br><span>@@ -184,10 +186,11 @@</span><br><span>     while (*cip=
hers !=3D 0)</span><br><span>     {</span><br><span>         const mbedtls_=
cipher_info_t *info =3D mbedtls_cipher_info_from_type(*ciphers);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (info &amp;&amp; ciph=
er_kt_insecure(info-&gt;name)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            &amp;&amp; (cipher_kt_mode_aead(info-&gt;name) || ciphe=
r_kt_mode_cbc(info-&gt;name)))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const char *name =3D mbedtls_cipher_info_get_name(info);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (info &a=
mp;&amp; name &amp;&amp; cipher_kt_insecure(name)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &amp;&amp; (cipher_kt_mode_aead(n=
ame) || cipher_kt_mode_cbc(name)))</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            print_cipher(info-&gt;n=
ame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pr=
int_cipher(name);</span><br><span>         }</span><br><span>         ciphe=
rs++;</span><br><span>     }</span><br><span>@@ -295,7 +298,9 @@</span><br>=
<span>     mbedtls_pem_context ctx =3D { 0 };</span><br><span>     bool ret=
 =3D mbed_ok(mbedtls_pem_read_buffer(&amp;ctx, header, footer, BPTR(&amp;in=
put),</span><br><span>                                                NULL,=
 0, &amp;use_len));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (ret &amp;&amp; !buf_write(dst, ctx.buf, ctx.buflen))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    size_t buf_size =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned char *buf =
=3D mbedtls_pem_get_buffer(&amp;ctx, &amp;buf_size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ret &amp;&amp; !buf_write(dst, bu=
f, buf_size))</span><br><span>     {</span><br><span>         ret =3D false=
;</span><br><span>         msg(M_WARN, &quot;PEM decode error: destination =
buffer too small&quot;);</span><br><span>@@ -416,11 +421,12 @@</span><br><s=
pan>         return false;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (cipher-&gt;key_bitlen=
/8 &gt; MAX_CIPHER_KEY_LENGTH)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const size_t key_bytelen =3D mbedtls_cipher_info_get_key_bit=
len(cipher)/8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (key_bytelen &gt; MAX_CIPHER_KEY_LENGTH)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;Cipher=
 algorithm &#39;%s&#39; uses a default key size (%d bytes) &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;Ciph=
er algorithm &#39;%s&#39; uses a default key size (%zu bytes) &quot;</span>=
<br><span>             &quot;which is larger than &quot; PACKAGE_NAME &quot=
;&#39;s current maximum key size &quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            &quot;(%d bytes)&quot;, ciphername, cipher-&g=
t;key_bitlen/8, MAX_CIPHER_KEY_LENGTH);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            &quot;(%d bytes)&quot;, ciphername, key_byt=
elen, MAX_CIPHER_KEY_LENGTH);</span><br><span>         *reason =3D &quot;di=
sabled due to key size too large&quot;;</span><br><span>         return fal=
se;</span><br><span>     }</span><br><span>@@ -438,7 +444,7 @@</span><br><s=
pan>         return &quot;[null-cipher]&quot;;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n translate_cipher_name_to_openvpn(cipher_kt-&gt;name);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return translate_cipher_name_to_ope=
nvpn(mbedtls_cipher_info_get_name(cipher_kt));</span><br><span> }</span><br=
><span> </span><br><span> int</span><br><span>@@ -451,7 +457,7 @@</span><br=
><span>         return 0;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt-&gt;key_b=
itlen/8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
(int)mbedtls_cipher_info_get_key_bitlen(cipher_kt)/8;</span><br><span> }</s=
pan><br><span> </span><br><span> int</span><br><span>@@ -463,7 +469,7 @@</s=
pan><br><span>     {</span><br><span>         return 0;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher_=
kt-&gt;iv_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return (int)mbedtls_cipher_info_get_iv_size(cipher_kt);</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br><span>@@ -474,7 +480,7 @@<=
/span><br><span>     {</span><br><span>         return 0;</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ciphe=
r_kt-&gt;block_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return (int)mbedtls_cipher_info_get_block_size(cipher_kt);</span><br><=
span> }</span><br><span> </span><br><span> int</span><br><span>@@ -498,16 +=
504,16 @@</span><br><span> </span><br><span>     return !(cipher_kt_block_s=
ize(ciphername) &gt;=3D 128 / 8</span><br><span> #ifdef MBEDTLS_CHACHAPOLY_=
C</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             || ciph=
er_kt-&gt;type =3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+             || mbedtls_cipher_info_get_=
type(cipher_kt) =3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305</span><br><span> #e=
ndif</span><br><span>              );</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static mbedtls_cipher_mode_t</s=
pan><br><span> cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)</span=
><br><span> {</span><br><span>     ASSERT(NULL !=3D cipher_kt);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt-&gt;mode;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_cip=
her_info_get_mode(cipher_kt);</span><br><span> }</span><br><span> </span><b=
r><span> bool</span><br><span>@@ -566,22 +572,29 @@</span><br><span>     CL=
EAR(*ctx);</span><br><span> </span><br><span>     const mbedtls_cipher_info=
_t *kt =3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int key_len =3D kt-&gt;key_bitlen/8;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(kt);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    size_t key_len =3D mbedtl=
s_cipher_info_get_key_bitlen(kt)/8;</span><br><span> </span><br><span>     =
if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))</span><br><span>     {</span><=
br><span>         msg(M_FATAL, &quot;mbed TLS cipher context init #1&quot;)=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, key_l=
en*8, operation)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_len*8, operation))=
)</span><br><span>     {</span><br><span>         msg(M_FATAL, &quot;mbed T=
LS cipher set key&quot;);</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (mbedtls_cipher_info_=
get_mode(kt) =3D=3D MBEDTLS_MODE_CBC)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (!mbed_ok(mbedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDI=
NG_PKCS7)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_=
FATAL, &quot;mbed TLS cipher set padding mode&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     /* make sure we used a big enough key */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(ctx-&gt;key_b=
itlen &lt;=3D key_len*8);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) &lt;=3D key_len*8);</sp=
an><br><span> }</span><br><span> </span><br><span> int</span><br><span>@@ -=
609,7 +622,7 @@</span><br><span> int</span><br><span> cipher_ctx_block_size=
(const mbedtls_cipher_context_t *ctx)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_get_block_size=
(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (i=
nt)mbedtls_cipher_get_block_size(ctx);</span><br><span> }</span><br><span> =
</span><br><span> int</span><br><span>@@ -617,7 +630,7 @@</span><br><span> =
{</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt_mode(ctx-&gt=
;cipher_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn mbedtls_cipher_get_cipher_mode(ctx);</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span>@@ -652,7 +665,7 @@</span><br><s=
pan>         return 0;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_s=
et_iv(ctx, iv_buf, ctx-&gt;cipher_info-&gt;iv_size)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_set_iv(ct=
x, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx))))</span><br><span>     =
{</span><br><span>         return 0;</span><br><span>     }</span><br><span=
>@@ -714,7 +727,7 @@</span><br><span> {</span><br><span>     size_t olen =
=3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (MBEDTLS_DECRYPT !=3D ctx-&gt;operation)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (MBEDTLS_DECRYPT !=3D mbedtls_cipher_=
get_operation(ctx))</span><br><span>     {</span><br><span>         return =
0;</span><br><span>     }</span><br><span>@@ -866,7 +879,7 @@</span><br><sp=
an>     {</span><br><span>         return 0;</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_md_get_siz=
e(ctx-&gt;md_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));</span><=
br><span> }</span><br><span> </span><br><span> void</span><br><span>@@ -936=
,7 +949,7 @@</span><br><span>     {</span><br><span>         return 0;</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return mbedtls_md_get_size(ctx-&gt;md_info);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return mbedtls_md_get_size(mbedtls_md_info_fr=
om_ctx(ctx));</span><br><span> }</span><br><span> </span><br><span> void</s=
pan><br><span>diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedt=
ls_compat.h</span><br><span>new file mode 100644</span><br><span>index 0000=
000..fe7c3f9</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvp=
n/mbedtls_compat.h</span><br><span>@@ -0,0 +1,186 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single TCP/UDP port, with support for SSL/TLS-based</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             packet encryption, packet authentication, and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023 Fox Crypto B.V.=
 &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This =
program is free software; you can redistribute it and/or modify</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the G=
NU General Public License version 2</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  as published by the Free Software Foundation.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope th=
at it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  GNU General Public License for more details.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, write to the Free Software Fo=
undation, Inc.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file mb=
edtls compatibility stub</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This file=
 provide compatibility stubs for the mbedtls libraries</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * prior to version 3. This version made=
 most fields in structs private</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * and requires accessor functions to be used. For earlier vers=
ions, we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * implemen=
t the accessor functions here.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef MBEDTLS_COMPAT_H=
_</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MBEDTLS_CO=
MPAT_H_</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;errlevel.h&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/cipher.h&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/ctr=
_drbg.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;mbedtls/dhm.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;mbedtls/md.h&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;mbedtls/pem.h&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &lt;mbedtls/pk.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/version.h&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/x509_=
crt.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_HAVE_PSA_CRYPTO_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #include &lt;ps=
a/crypto.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+mbedtls_compat_psa_crypto_init(void)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_HAVE_PSA_CRYPTO_H &amp;&amp=
; defined(MBEDTLS_PSA_CRYPTO_C)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (psa_crypto_init() !=3D PSA_SUCCESS)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(M_FATAL, &quot;mbedtls: psa_crypto_init()=
 failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_HAVE_PSA_CRYPTO_H &amp=
;&amp; defined(MBEDTLS_PSA_CRYPTO_C) */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * In older versions of mbedtls, m=
bedtls_ctr_drbg_update() did not return an</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * error code, and it was deprecated in favor of mbe=
dtls_ctr_drbg_update_ret()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * which does.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In mbedtls 3=
, this function was removed and mbedtls_ctr_drbg_update() returns</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * an error code.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static inline int</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+mbedtls_compat_ctr_drbg_update(mbedtls_ctr_drbg_c=
ontext *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                        const unsigned char *additional,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                               size_t =
add_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_CTR_DRBG_UPDATE_RET<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_c=
tr_drbg_update_ret(ctx, additional, add_len);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#elif MBEDTLS_VERSION_NUMBER &lt; 0x03020100</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_ctr_drbg_upd=
ate(ctx, additional, add_len);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n mbedtls_ctr_drbg_update(ctx, additional, add_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* HAVE_CTR_DRBG_UPDATE_RET */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, co=
nst mbedtls_pk_context *prv,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                             int (*f_rng)(void *, unsigned char *,=
 size_t), void *p_rng)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VER=
SION_NUMBER &lt; 0x03020100</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return mbedtls_pk_check_pair(pub, prv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return mbedtls_pk_check_pair(pub, prv, f_rng, p_rng=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS=
_VERSION_NUMBER &lt; 0x03020100 */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline int</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_compat_pk_parse_=
key(mbedtls_pk_context *ctx,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                            const unsigned char *key, size_t keyle=
n,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
           const unsigned char *pwd, size_t pwdlen,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            int (*f_rng)(=
void *, unsigned char *, size_t), void *p_rng)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_pk_parse_key(ctx, key,=
 keylen, pwd, pwdlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen, f_rng, p_rng);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedt=
ls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                const cha=
r *path, const char *password,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                int (*f_rng)(void *, unsigned ch=
ar *, size_t), void *p_rng)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTL=
S_VERSION_NUMBER &lt; 0x03020100</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return mbedtls_pk_parse_keyfile(ctx, path, password);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_pk_parse_keyfile(ct=
x, path, password, f_rng, p_rng);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x03=
020100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline=
 size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_ciph=
er_info_get_block_size(const mbedtls_cipher_info_t *cipher)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return (size_t)cipher-&gt;block_size;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static inline size_t</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+mbedtls_cipher_info_get_iv_size(const mbedtls_cipher_info_t *cipher=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return (size_t)cipher-&gt;iv_siz=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static inline size_t</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+mbedtls_cipher_info_get_key_bitlen(const mbedtls_ciph=
er_info_t *cipher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (size_t)=
cipher-&gt;key_bitlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static inline mbedtls_cipher_mode_=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_cipher_inf=
o_get_mode(const mbedtls_cipher_info_t *cipher)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return cipher-&gt;mode;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline const=
 char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_ciph=
er_info_get_name(const mbedtls_cipher_info_t *cipher)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return cipher-&gt;name;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline=
 mbedtls_cipher_type_t</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+mbedtls_cipher_info_get_type(const mbedtls_cipher_info_t *cipher)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return cipher-&gt;type;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static inline size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+mbedtls_dhm_get_bitlen(const mbedtls_dhm_context *ctx)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return 8 * ctx-&gt;len;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in=
line const mbedtls_md_info_t *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+mbedtls_md_info_from_ctx(const mbedtls_md_context_t *ctx)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return ctx-&gt;md_info;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static inline const unsigned char *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+mbedtls_pem_get_buffer(const mbedtls_pem_context *ctx, si=
ze_t *buf_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    *buf_size =3D ctx-=
&gt;buflen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn ctx-&gt;buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+mbedtls_x509_crt_has_ext_type(const mbedt=
ls_x509_crt *ctx, int ext_type)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn ctx-&gt;ext_types &amp; ext_type;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x03020100 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif /* MBEDTLS_COMPAT_H_ */</span><br><span>diff --git a/=
src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 2b68bac=
..d238269 100644</span><br><span>--- a/src/openvpn/options.c</span><br><spa=
n>+++ b/src/openvpn/options.c</span><br><span>@@ -644,8 +644,10 @@</span><b=
r><span>     &quot;--verify-x509-name name: Accept connections only from a =
host with X509 subject\n&quot;</span><br><span>     &quot;                 =
 DN name. The remote host must also pass all other tests\n&quot;</span><br>=
<span>     &quot;                  of verification.\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_CRYPTO_MBEDTLS</span=
><br><span>     &quot;--ns-cert-type t: (DEPRECATED) Require that peer cert=
ificate was signed with \n&quot;</span><br><span>     &quot;               =
   an explicit nsCertType designation t =3D &#39;client&#39; | &#39;server&=
#39;.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span>     &quot;--x509-track x  : Save peer X509 attribute x in=
 environment for use by\n&quot;</span><br><span>     &quot;                =
  plugins and management interface.\n&quot;</span><br><span> #ifdef HAVE_EX=
PORT_KEYING_MATERIAL</span><br><span>@@ -9051,6 +9053,10 @@</span><br><span=
>     }</span><br><span>     else if (streq(p[0], &quot;ns-cert-type&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTO_MBEDTLS</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;=
--ns-cert-type is not available with mbedtls.&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span>         VERIFY_PER=
MISSION(OPT_P_GENERAL);</span><br><span>         if (streq(p[1], &quot;serv=
er&quot;))</span><br><span>         {</span><br><span>@@ -9065,6 +9071,7 @@=
</span><br><span>             msg(msglevel, &quot;--ns-cert-type must be &#=
39;client&#39; or &#39;server&#39;&quot;);</span><br><span>             got=
o err;</span><br><span>         }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span>     }</sp=
an><br><span>     else if (streq(p[0], &quot;remote-cert-ku&quot;))</span><=
br><span>     {</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/sr=
c/openvpn/ssl_mbedtls.c</span><br><span>index 81dd906..4e79c82 100644</span=
><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvp=
n/ssl_mbedtls.c</span><br><span>@@ -41,6 +41,7 @@</span><br><span> #include=
 &quot;buffer.h&quot;</span><br><span> #include &quot;misc.h&quot;</span><b=
r><span> #include &quot;manage.h&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;mbedtls_compat.h&quot;</span><br><span> #=
include &quot;pkcs11_backend.h&quot;</span><br><span> #include &quot;ssl_co=
mmon.h&quot;</span><br><span> </span><br><span>@@ -49,34 +50,11 @@</span><b=
r><span> #include &lt;mbedtls/error.h&gt;</span><br><span> #include &lt;mbe=
dtls/version.h&gt;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x02040000</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    #include &lt;mbedtls/net_sockets=
.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    #include &lt;mbedtls/net.h&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/net_socket=
s.h&gt;</span><br><span> </span><br><span> #include &lt;mbedtls/oid.h&gt;</=
span><br><span> #include &lt;mbedtls/pem.h&gt;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Compatibility: mbedtls_ctr_drbg_update was depr=
ecated in mbedtls 2.16 and</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * replaced with mbedtls_ctr_drbg_update_ret, which returns an error c=
ode.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * For older vers=
ions, we call mbedtls_ctr_drbg_update and return 0 (success).</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * Note: this change was backported to other mbedTLS b=
ranches, therefore we</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * rely on function detection at configure time.</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifndef HAVE_CTR_DRBG_UPDATE_RET</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-mbedtls_ctr_drbg_update_ret(mbedtls_ctr_drbg_context *ctx,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                            c=
onst unsigned char *additional,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                            size_t add_len)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    mbedtls_ctr_drbg_update(ctx, additional, add_len);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> static const mbedtls_x509_crt_profile openvpn_x509_crt_=
profile_legacy =3D</span><br><span> {</span><br><span>     /* Hashes from S=
HA-1 and above */</span><br><span>@@ -108,6 +86,7 @@</span><br><span> void<=
/span><br><span> tls_init_lib(void)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    mbedtls_compat_psa_crypto_init();</s=
pan><br><span> }</span><br><span> </span><br><span> void</span><br><span>@@=
 -430,7 +409,7 @@</span><br><span>     }</span><br><span> </span><br><span>=
     msg(D_TLS_DEBUG_LOW, &quot;Diffie-Hellman initialized with &quot; coun=
ter_format &quot; bit key&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        (counter_type) 8 * mbedtls_mpi_size(&amp;ctx-&gt;dhm_ctx=
-&gt;P));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        (c=
ounter_type) mbedtls_dhm_get_bitlen(ctx-&gt;dhm_ctx));</span><br><span> }</=
span><br><span> </span><br><span> void</span><br><span>@@ -504,29 +483,40 @=
@</span><br><span> </span><br><span>     if (priv_key_inline)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        stat=
us =3D mbedtls_pk_parse_key(ctx-&gt;priv_key,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                      (const unsign=
ed char *) priv_key_file,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                      strlen(priv_key_file) + 1, NULL, =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status =
=3D mbedtls_compat_pk_parse_key(ctx-&gt;priv_key,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                             =
(const unsigned char *) priv_key_file,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                             strlen(priv=
_key_file) + 1, NULL, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                             mbedtls_ctr_drbg_random,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                         rand_ctx_get());</span><br><span> </span><br><span=
>         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)</span><br><sp=
an>         {</span><br><span>             char passbuf[512] =3D {0};</span=
><br><span>             pem_password_callback(passbuf, 512, 0, NULL);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            status =3D mbed=
tls_pk_parse_key(ctx-&gt;priv_key,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                          (const unsigned char=
 *) priv_key_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                                       strlen(priv_key_file) + 1,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
           (unsigned char *) passbuf,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                          strlen(passbuf));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            status =
=3D mbedtls_compat_pk_parse_key(ctx-&gt;priv_key,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                             =
    (const unsigned char *) priv_key_file,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                                 str=
len(priv_key_file) + 1,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                                 (unsigned char *) pass=
buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                                  strlen(passbuf),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                            =
     mbedtls_ctr_drbg_random,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                                 rand_ctx_get());=
</span><br><span>         }</span><br><span>     }</span><br><span>     els=
e</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_f=
ile, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
status =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;priv_key,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
               priv_key_file,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                                 NULL,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
                   mbedtls_ctr_drbg_random,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                                 ra=
nd_ctx_get());</span><br><span>         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRE=
D =3D=3D status)</span><br><span>         {</span><br><span>             ch=
ar passbuf[512] =3D {0};</span><br><span>             pem_password_callback=
(passbuf, 512, 0, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key, priv_k=
ey_file, passbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           status =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;priv_key,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                              priv_key_file, passbuf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
            mbedtls_ctr_drbg_random,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                                     rand_=
ctx_get());</span><br><span>         }</span><br><span>     }</span><br><sp=
an>     if (!mbed_ok(status))</span><br><span>@@ -542,7 +532,10 @@</span><b=
r><span>         return 1;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_pk_c=
heck_pair(&amp;ctx-&gt;crt_chain-&gt;pk, ctx-&gt;priv_key)))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_compat_pk=
_check_pair(&amp;ctx-&gt;crt_chain-&gt;pk,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                              ctx-&g=
t;priv_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                      mbedtls_ctr_drbg_random,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
              rand_ctx_get())))</span><br><span>     {</span><br><span>    =
     msg(M_WARN, &quot;Private key does not match the certificate&quot;);</=
span><br><span>         return 1;</span><br><span>@@ -558,7 +551,6 @@</span=
><br><span>  * @param ctx_voidptr   Management external key context.</span>=
<br><span>  * @param f_rng         (Unused)</span><br><span>  * @param p_rn=
g         (Unused)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
@param mode          RSA mode (should be RSA_PRIVATE).</span><br><span>  * =
@param md_alg        Message digest (&#39;hash&#39;) algorithm type.</span>=
<br><span>  * @param hashlen       Length of hash (overridden by length spe=
cified by md_alg</span><br><span>  *                      if md_alg !=3D MB=
EDTLS_MD_NONE).</span><br><span>@@ -572,7 +564,10 @@</span><br><span>  */</=
span><br><span> static inline int</span><br><span> external_pkcs1_sign( voi=
d *ctx_voidptr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
               int (*f_rng)(void *, unsigned char *, size_t), void *p_rng, =
int mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
           int (*f_rng)(void *, unsigned char *, size_t), void *p_rng,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMB=
ER &lt; 0x03020100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    int mode,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span>                      mbedtls_md_type_t md=
_alg, unsigned int hashlen, const unsigned char *hash,</span><br><span>    =
                  unsigned char *sig )</span><br><span> {</span><br><span>@=
@ -587,10 +582,12 @@</span><br><span>         return MBEDTLS_ERR_RSA_BAD_IN=
PUT_DATA;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</=
span><br><span>     if (MBEDTLS_RSA_PRIVATE !=3D mode)</span><br><span>    =
 {</span><br><span>         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span> </span><br><span>     /*</span><br><span>      * Support=
 a wide range of hashes. TLSv1.1 and before only need SIG_RSA_RAW,</span><b=
r><span>@@ -967,7 +964,7 @@</span><br><span> </span><br><span>         if (=
0 !=3D memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (!mbed_ok(mbedtls_ctr_drbg_update_ret(cd_ctx, sha256_hash, 32)))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!mb=
ed_ok(mbedtls_compat_ctr_drbg_update(cd_ctx, sha256_hash, 32)))</span><br><=
span>             {</span><br><span>                 msg(M_WARN, &quot;WARN=
ING: failed to personalise random, could not update CTR_DRBG&quot;);</span>=
<br><span>             }</span><br><span>@@ -979,12 +976,16 @@</span><br><s=
pan> int</span><br><span> tls_version_max(void)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(MBEDTLS_SSL_MAJOR_=
VERSION_3) &amp;&amp; defined(MBEDTLS_SSL_MINOR_VERSION_3)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS1_3=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return TLS_VER=
_1_3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(=
MBEDTLS_SSL_PROTO_TLS1_2)</span><br><span>     return TLS_VER_1_2;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(MBEDTLS_SSL_MAJO=
R_VERSION_3) &amp;&amp; defined(MBEDTLS_SSL_MINOR_VERSION_2)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#elif defined(MBEDTLS_SSL_PROTO_TL=
S1_1)</span><br><span>     return TLS_VER_1_1;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#elif defined(MBEDTLS_SSL_PROTO_TLS1)</span><br><span>     retur=
n TLS_VER_1_0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else=
 /* if defined(MBEDTLS_SSL_PROTO_TLS1_3) */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    #error &quot;mbedtls is compiled without suppor=
t for any version of TLS.&quot;</span><br><span> #endif</span><br><span> }<=
/span><br><span> </span><br><span>@@ -1006,23 +1007,36 @@</span><br><span> =
</span><br><span>     switch (tls_ver)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS=
1)</span><br><span>         case TLS_VER_1_0:</span><br><span>             =
*major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span>             *minor=
 =3D MBEDTLS_SSL_MINOR_VERSION_1;</span><br><span>             break;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_=
SSL_PROTO_TLS1_1)</span><br><span>         case TLS_VER_1_1:</span><br><spa=
n>             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span>    =
         *minor =3D MBEDTLS_SSL_MINOR_VERSION_2;</span><br><span>          =
   break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(MBEDTLS_SSL_PROTO_TLS1_2)</span><br><span>         case TLS_VER_1_2:=
</span><br><span>             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span=
><br><span>             *minor =3D MBEDTLS_SSL_MINOR_VERSION_3;</span><br><=
span>             break;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PRO=
TO_TLS1_3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
ase TLS_VER_1_3:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            *minor =3D MBEDTLS_SSL_MINOR_VERSI=
ON_4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            br=
eak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span> </span><br><span>         default:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;%s: invalid TLS versio=
n %d&quot;, __func__, tls_ver);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(M_FATAL, &quot;%s: invalid or unsupported TLS v=
ersion %d&quot;, __func__, tls_ver);</span><br><span>             break;</s=
pan><br><span>     }</span><br><span> }</span><br><span>@@ -1149,17 +1163,1=
7 @@</span><br><span> </span><br><span>     /* Initialize minimum TLS versi=
on */</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        const int tls_version_min =3D</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const int configured_tls_version_min =3D</=
span><br><span>             (session-&gt;opt-&gt;ssl_flags &gt;&gt; SSLF_TL=
S_VERSION_MIN_SHIFT)</span><br><span>             &amp;SSLF_TLS_VERSION_MIN=
_MASK;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        /* default to TLS 1.0 */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* default to TLS 1.2 */</span><br><span>         i=
nt major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        int minor =3D MBEDTLS_SSL_MINOR_VERSION_1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int minor =3D MB=
EDTLS_SSL_MINOR_VERSION_3;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (tls_version_min &gt; TLS_VER_UNSPEC)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (configured_=
tls_version_min &gt; TLS_VER_UNSPEC)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            tls_version_to_major_=
minor(tls_version_min, &amp;major, &amp;minor);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            tls_version_to_major_minor(configur=
ed_tls_version_min, &amp;major, &amp;minor);</span><br><span>         }</sp=
an><br><span> </span><br><span>         mbedtls_ssl_conf_min_version(ks_ssl=
-&gt;ssl_config, major, minor);</span><br><span>@@ -1167,16 +1181,24 @@</sp=
an><br><span> </span><br><span>     /* Initialize maximum TLS version */</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       const int tls_version_max =3D</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        const int configured_tls_version_max =3D</span><br=
><span>             (session-&gt;opt-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSIO=
N_MAX_SHIFT)</span><br><span>             &amp;SSLF_TLS_VERSION_MAX_MASK;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (tls_version_max &gt; TLS_VER_UNSPEC)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        int major =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        int minor =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (configured_tls_version_max &gt; TLS_VER_UNSPEC)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            int major, minor;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            tls_version_to_major_minor(tls_version_max, &amp;m=
ajor, &amp;minor);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         mbedtls_ssl_conf_max_version(ks_ssl-&gt;ssl_config, major, minor);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tls_ver=
sion_to_major_minor(configured_tls_version_max, &amp;major, &amp;minor);</s=
pan><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
/* Default to tls_version_max(). */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            tls_version_to_major_minor(tls_version_max(), &=
amp;major, &amp;minor);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbedtls_ssl_conf_=
max_version(ks_ssl-&gt;ssl_config, major, minor);</span><br><span>     }</s=
pan><br><span> </span><br><span> #ifdef HAVE_EXPORT_KEYING_MATERIAL</span><=
br><span>@@ -1188,7 +1210,7 @@</span><br><span>     /* Initialise SSL conte=
xt */</span><br><span>     ALLOC_OBJ_CLEAR(ks_ssl-&gt;ctx, mbedtls_ssl_cont=
ext);</span><br><span>     mbedtls_ssl_init(ks_ssl-&gt;ctx);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ssl_setup(ks_ssl-&gt;ctx=
, ks_ssl-&gt;ssl_config);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    mbed_ok(mbedtls_ssl_setup(ks_ssl-&gt;ctx, ks_ssl-&gt;ssl_config))=
;</span><br><span> </span><br><span>     /* Initialise BIOs */</span><br><s=
pan>     ALLOC_OBJ_CLEAR(ks_ssl-&gt;bio_ctx, bio_ctx);</span><br><span>diff=
 --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.=
c</span><br><span>index a1ddf8d..ce21324 100644</span><br><span>--- a/src/o=
penvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_verify_mb=
edtls.c</span><br><span>@@ -35,6 +35,7 @@</span><br><span> #if defined(ENAB=
LE_CRYPTO_MBEDTLS)</span><br><span> </span><br><span> #include &quot;crypto=
_mbedtls.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;mbedtls_compat.h&quot;</span><br><span> #include &quot;ssl_veri=
fy.h&quot;</span><br><span> #include &lt;mbedtls/asn1.h&gt;</span><br><span=
> #include &lt;mbedtls/error.h&gt;</span><br><span>@@ -432,6 +433,8 @@</spa=
n><br><span>     }</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Dummy function because Netscape cert=
ificate types are not supported in OpenVPN with mbedtls.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Returns SUCCESS if usage is NS_CERT=
_CHECK_NONE, FAILURE otherwise. */</span><br><span> result_t</span><br><spa=
n> x509_verify_ns_cert_type(mbedtls_x509_crt *cert, const int usage)</span>=
<br><span> {</span><br><span>@@ -439,18 +442,6 @@</span><br><span>     {</s=
pan><br><span>         return SUCCESS;</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (usage =3D=3D NS_CERT_CHECK_=
CLIENT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return ((cert-&gt;ext_=
types &amp; MBEDTLS_X509_EXT_NS_CERT_TYPE)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                &amp;&amp; (cert-&gt;ns_cert_type &amp=
; MBEDTLS_X509_NS_CERT_TYPE_SSL_CLIENT)) ?</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-               SUCCESS : FAILURE;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (usage =3D=3D NS_CERT_CHECK_SERVER)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return ((cert-&gt;ext_types &amp; MBEDTLS_X50=
9_EXT_NS_CERT_TYPE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              &amp;&amp; (cert-&gt;ns_cert_type &amp; MBEDTLS_X509_NS_CERT_=
TYPE_SSL_SERVER)) ?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
             SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span> </span><br><span>     return FAILURE;</spa=
n><br><span> }</span><br><span>@@ -461,7 +452,7 @@</span><br><span> {</span=
><br><span>     msg(D_HANDSHAKE, &quot;Validating certificate key usage&quo=
t;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (!(cert-&gt;ext_types &amp; MBEDTLS_X509_EXT_KEY_USAGE))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!mbedtls_x509_crt_has_=
ext_type(cert, MBEDTLS_X509_EXT_KEY_USAGE))</span><br><span>     {</span><b=
r><span>         msg(D_TLS_ERRORS,</span><br><span>             &quot;ERROR=
: Certificate does not have key usage extension&quot;);</span><br><span>@@ =
-486,9 +477,7 @@</span><br><span> </span><br><span>     if (fFound !=3D SUC=
CESS)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            &quot;ERROR: Certificate has key usage %04x, expecte=
d one of:&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       cert-&gt;key_usage);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(D_TLS_ERRORS, &quot;ERROR: Certificate has invalid key =
usage, expected one of:&quot;);</span><br><span>         for (size_t i =3D =
0; i &lt; expected_len &amp;&amp; expected_ku[i]; i++)</span><br><span>    =
     {</span><br><span>             msg(D_TLS_ERRORS, &quot; * %04x&quot;, =
expected_ku[i]);</span><br><span>@@ -503,7 +492,7 @@</span><br><span> {</sp=
an><br><span>     result_t fFound =3D FAILURE;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!(cert-&gt;ext_types &am=
p; MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!mbedtls_x509_crt_has_ext_type(cert, MBEDTLS_X=
509_EXT_EXTENDED_KEY_USAGE))</span><br><span>     {</span><br><span>       =
  msg(D_HANDSHAKE, &quot;Certificate does not have extended key usage exten=
sion&quot;);</span><br><span>     }</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demai=
l">change 370</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I445a93e84dc54b865b757038d22=
318ac427fce96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 370 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--pbZwwqE2S7w=--

