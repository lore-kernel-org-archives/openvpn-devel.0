From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 25 Oct 2023 14:18:30 +0200
Message-Id: <20231025121830.1030959-1-frank@...2641...>
In-Reply-To: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
References: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] Add support for mbedtls 3.X.Y
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
Cc: Max Fillinger <max@...2606...>

From: Max Fillinger <max@...2606...>

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
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/370
This mail reflects revision 7 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/configure.ac b/configure.ac
index 128ab86..7e5763d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1016,15 +1016,21 @@
 #include <mbedtls/version.h>
 			]],
 			[[
-#if MBEDTLS_VERSION_NUMBER < 0x02000000 || MBEDTLS_VERSION_NUMBER >= 0x03000000
+#if MBEDTLS_VERSION_NUMBER < 0x02000000 || (MBEDTLS_VERSION_NUMBER >= 0x03000000 && MBEDTLS_VERSION_NUMBER < 0x03020100)
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([mbed TLS 2.y.z required])]
+		[AC_MSG_ERROR([mbed TLS version >= 2.0.0 or >= 3.2.1 required])]
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
index 98cac60..aaf6ef7 100644
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
     while (*ciphers != 0)
     {
         const mbedtls_cipher_info_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        if (info && !cipher_kt_insecure(info->name)
-            && (cipher_kt_mode_aead(info->name) || cipher_kt_mode_cbc(info->name)))
+        const char *name = mbedtls_cipher_info_get_name(info);
+        if (info && name && !cipher_kt_insecure(name)
+            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
         {
-            print_cipher(info->name);
+            print_cipher(name);
         }
         ciphers++;
     }
@@ -184,10 +186,11 @@
     while (*ciphers != 0)
     {
         const mbedtls_cipher_info_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        if (info && cipher_kt_insecure(info->name)
-            && (cipher_kt_mode_aead(info->name) || cipher_kt_mode_cbc(info->name)))
+        const char *name = mbedtls_cipher_info_get_name(info);
+        if (info && name && cipher_kt_insecure(name)
+            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
         {
-            print_cipher(info->name);
+            print_cipher(name);
         }
         ciphers++;
     }
@@ -295,7 +298,9 @@
     mbedtls_pem_context ctx = { 0 };
     bool ret = mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(&input),
                                                NULL, 0, &use_len));
-    if (ret && !buf_write(dst, ctx.buf, ctx.buflen))
+    size_t buf_size = 0;
+    const unsigned char *buf = mbedtls_pem_get_buffer(&ctx, &buf_size);
+    if (ret && !buf_write(dst, buf, buf_size))
     {
         ret = false;
         msg(M_WARN, "PEM decode error: destination buffer too small");
@@ -416,11 +421,12 @@
         return false;
     }
 
-    if (cipher->key_bitlen/8 > MAX_CIPHER_KEY_LENGTH)
+    const size_t key_bytelen = mbedtls_cipher_info_get_key_bitlen(cipher)/8;
+    if (key_bytelen > MAX_CIPHER_KEY_LENGTH)
     {
-        msg(D_LOW, "Cipher algorithm '%s' uses a default key size (%d bytes) "
+        msg(D_LOW, "Cipher algorithm '%s' uses a default key size (%zu bytes) "
             "which is larger than " PACKAGE_NAME "'s current maximum key size "
-            "(%d bytes)", ciphername, cipher->key_bitlen/8, MAX_CIPHER_KEY_LENGTH);
+            "(%d bytes)", ciphername, key_bytelen, MAX_CIPHER_KEY_LENGTH);
         *reason = "disabled due to key size too large";
         return false;
     }
@@ -438,7 +444,7 @@
         return "[null-cipher]";
     }
 
-    return translate_cipher_name_to_openvpn(cipher_kt->name);
+    return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(cipher_kt));
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
 
     return !(cipher_kt_block_size(ciphername) >= 128 / 8
 #ifdef MBEDTLS_CHACHAPOLY_C
-             || cipher_kt->type == MBEDTLS_CIPHER_CHACHA20_POLY1305
+             || mbedtls_cipher_info_get_type(cipher_kt) == MBEDTLS_CIPHER_CHACHA20_POLY1305
 #endif
              );
 }
 
-static int
+static mbedtls_cipher_mode_t
 cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
 {
     ASSERT(NULL != cipher_kt);
-    return cipher_kt->mode;
+    return mbedtls_cipher_info_get_mode(cipher_kt);
 }
 
 bool
@@ -566,22 +572,29 @@
     CLEAR(*ctx);
 
     const mbedtls_cipher_info_t *kt = cipher_get(ciphername);
-    int key_len = kt->key_bitlen/8;
-
     ASSERT(kt);
+    size_t key_bitlen = mbedtls_cipher_info_get_key_bitlen(kt);
 
     if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
     {
         msg(M_FATAL, "mbed TLS cipher context init #1");
     }
 
-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, key_len*8, operation)))
+    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, operation)))
     {
         msg(M_FATAL, "mbed TLS cipher set key");
     }
 
+    if (mbedtls_cipher_info_get_mode(kt) == MBEDTLS_MODE_CBC)
+    {
+        if (!mbed_ok(mbedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_PKCS7)))
+        {
+            msg(M_FATAL, "mbed TLS cipher set padding mode");
+        }
+    }
+
     /* make sure we used a big enough key */
-    ASSERT(ctx->key_bitlen <= key_len*8);
+    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) <= key_bitlen);
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
     ASSERT(NULL != ctx);
 
-    return cipher_kt_mode(ctx->cipher_info);
+    return mbedtls_cipher_get_cipher_mode(ctx);
 }
 
 bool
@@ -652,7 +665,7 @@
         return 0;
     }
 
-    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, ctx->cipher_info->iv_size)))
+    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx))))
     {
         return 0;
     }
@@ -714,7 +727,7 @@
 {
     size_t olen = 0;
 
-    if (MBEDTLS_DECRYPT != ctx->operation)
+    if (MBEDTLS_DECRYPT != mbedtls_cipher_get_operation(ctx))
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
+    if (psa_crypto_init() != PSA_SUCCESS)
+    {
+        msg(M_FATAL, "mbedtls: psa_crypto_init() failed");
+    }
+#else
+    return;
+#endif /* MBEDTLS_HAVE_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
+}
+
+/*
+ * In older versions of mbedtls, mbedtls_ctr_drbg_update() did not return an
+ * error code, and it was deprecated in favor of mbedtls_ctr_drbg_update_ret()
+ * which does.
+ *
+ * In mbedtls 3, this function was removed and mbedtls_ctr_drbg_update() returns
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
+mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_pk_context *prv,
+                             int (*f_rng)(void *, unsigned char *, size_t), void *p_rng)
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
+                            int (*f_rng)(void *, unsigned char *, size_t), void *p_rng)
+{
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen);
+#else
+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen, f_rng, p_rng);
+#endif
+}
+
+static inline int
+mbedtls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx,
+                                const char *path, const char *password,
+                                int (*f_rng)(void *, unsigned char *, size_t), void *p_rng)
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
+    *buf_size = ctx->buflen;
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
     "--verify-x509-name name: Accept connections only from a host with X509 subject\n"
     "                  DN name. The remote host must also pass all other tests\n"
     "                  of verification.\n"
+#ifndef ENABLE_CRYPTO_MBEDTLS
     "--ns-cert-type t: (DEPRECATED) Require that peer certificate was signed with \n"
     "                  an explicit nsCertType designation t = 'client' | 'server'.\n"
+#endif
     "--x509-track x  : Save peer X509 attribute x in environment for use by\n"
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
index 81dd906..4ece37e 100644
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
 
-/**
- * Compatibility: mbedtls_ctr_drbg_update was deprecated in mbedtls 2.16 and
- * replaced with mbedtls_ctr_drbg_update_ret, which returns an error code.
- * For older versions, we call mbedtls_ctr_drbg_update and return 0 (success).
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
 static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =
 {
     /* Hashes from SHA-1 and above */
@@ -108,6 +90,7 @@
 void
 tls_init_lib(void)
 {
+    mbedtls_compat_psa_crypto_init();
 }
 
 void
@@ -430,7 +413,7 @@
     }
 
     msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with " counter_format " bit key",
-        (counter_type) 8 * mbedtls_mpi_size(&ctx->dhm_ctx->P));
+        (counter_type) mbedtls_dhm_get_bitlen(ctx->dhm_ctx));
 }
 
 void
@@ -504,29 +487,40 @@
 
     if (priv_key_inline)
     {
-        status = mbedtls_pk_parse_key(ctx->priv_key,
-                                      (const unsigned char *) priv_key_file,
-                                      strlen(priv_key_file) + 1, NULL, 0);
+        status = mbedtls_compat_pk_parse_key(ctx->priv_key,
+                                             (const unsigned char *) priv_key_file,
+                                             strlen(priv_key_file) + 1, NULL, 0,
+                                             mbedtls_ctr_drbg_random,
+                                             rand_ctx_get());
 
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
         {
             char passbuf[512] = {0};
             pem_password_callback(passbuf, 512, 0, NULL);
-            status = mbedtls_pk_parse_key(ctx->priv_key,
-                                          (const unsigned char *) priv_key_file,
-                                          strlen(priv_key_file) + 1,
-                                          (unsigned char *) passbuf,
-                                          strlen(passbuf));
+            status = mbedtls_compat_pk_parse_key(ctx->priv_key,
+                                                 (const unsigned char *) priv_key_file,
+                                                 strlen(priv_key_file) + 1,
+                                                 (unsigned char *) passbuf,
+                                                 strlen(passbuf),
+                                                 mbedtls_ctr_drbg_random,
+                                                 rand_ctx_get());
         }
     }
     else
     {
-        status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);
+        status = mbedtls_compat_pk_parse_keyfile(ctx->priv_key,
+                                                 priv_key_file,
+                                                 NULL,
+                                                 mbedtls_ctr_drbg_random,
+                                                 rand_ctx_get());
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
         {
             char passbuf[512] = {0};
             pem_password_callback(passbuf, 512, 0, NULL);
-            status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
+            status = mbedtls_compat_pk_parse_keyfile(ctx->priv_key,
+                                                     priv_key_file, passbuf,
+                                                     mbedtls_ctr_drbg_random,
+                                                     rand_ctx_get());
         }
     }
     if (!mbed_ok(status))
@@ -542,7 +536,10 @@
         return 1;
     }
 
-    if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key)))
+    if (!mbed_ok(mbedtls_compat_pk_check_pair(&ctx->crt_chain->pk,
+                                              ctx->priv_key,
+                                              mbedtls_ctr_drbg_random,
+                                              rand_ctx_get())))
     {
         msg(M_WARN, "Private key does not match the certificate");
         return 1;
@@ -558,7 +555,6 @@
  * @param ctx_voidptr   Management external key context.
  * @param f_rng         (Unused)
  * @param p_rng         (Unused)
- * @param mode          RSA mode (should be RSA_PRIVATE).
  * @param md_alg        Message digest ('hash') algorithm type.
  * @param hashlen       Length of hash (overridden by length specified by md_alg
  *                      if md_alg != MBEDTLS_MD_NONE).
@@ -572,7 +568,10 @@
  */
 static inline int
 external_pkcs1_sign( void *ctx_voidptr,
-                     int (*f_rng)(void *, unsigned char *, size_t), void *p_rng, int mode,
+                     int (*f_rng)(void *, unsigned char *, size_t), void *p_rng,
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+                     int mode,
+#endif
                      mbedtls_md_type_t md_alg, unsigned int hashlen, const unsigned char *hash,
                      unsigned char *sig )
 {
@@ -587,10 +586,12 @@
         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
     }
 
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
     if (MBEDTLS_RSA_PRIVATE != mode)
     {
         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
     }
+#endif
 
     /*
      * Support a wide range of hashes. TLSv1.1 and before only need SIG_RSA_RAW,
@@ -967,7 +968,7 @@
 
         if (0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
         {
-            if (!mbed_ok(mbedtls_ctr_drbg_update_ret(cd_ctx, sha256_hash, 32)))
+            if (!mbed_ok(mbedtls_compat_ctr_drbg_update(cd_ctx, sha256_hash, 32)))
             {
                 msg(M_WARN, "WARNING: failed to personalise random, could not update CTR_DRBG");
             }
@@ -979,12 +980,16 @@
 int
 tls_version_max(void)
 {
-#if defined(MBEDTLS_SSL_MAJOR_VERSION_3) && defined(MBEDTLS_SSL_MINOR_VERSION_3)
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
+    return TLS_VER_1_3;
+#elif defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
-#elif defined(MBEDTLS_SSL_MAJOR_VERSION_3) && defined(MBEDTLS_SSL_MINOR_VERSION_2)
+#elif defined(MBEDTLS_SSL_PROTO_TLS1_1)
     return TLS_VER_1_1;
-#else
+#elif defined(MBEDTLS_SSL_PROTO_TLS1)
     return TLS_VER_1_0;
+#else /* if defined(MBEDTLS_SSL_PROTO_TLS1_3) */
+    #error "mbedtls is compiled without support for any version of TLS."
 #endif
 }
 
@@ -1006,23 +1011,36 @@
 
     switch (tls_ver)
     {
+#if defined(MBEDTLS_SSL_PROTO_TLS1)
         case TLS_VER_1_0:
             *major = MBEDTLS_SSL_MAJOR_VERSION_3;
             *minor = MBEDTLS_SSL_MINOR_VERSION_1;
             break;
+#endif
 
+#if defined(MBEDTLS_SSL_PROTO_TLS1_1)
         case TLS_VER_1_1:
             *major = MBEDTLS_SSL_MAJOR_VERSION_3;
             *minor = MBEDTLS_SSL_MINOR_VERSION_2;
             break;
+#endif
 
+#if defined(MBEDTLS_SSL_PROTO_TLS1_2)
         case TLS_VER_1_2:
             *major = MBEDTLS_SSL_MAJOR_VERSION_3;
             *minor = MBEDTLS_SSL_MINOR_VERSION_3;
             break;
+#endif
+
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
+        case TLS_VER_1_3:
+            *major = MBEDTLS_SSL_MAJOR_VERSION_3;
+            *minor = MBEDTLS_SSL_MINOR_VERSION_4;
+            break;
+#endif
 
         default:
-            msg(M_FATAL, "%s: invalid TLS version %d", __func__, tls_ver);
+            msg(M_FATAL, "%s: invalid or unsupported TLS version %d", __func__, tls_ver);
             break;
     }
 }
@@ -1149,17 +1167,17 @@
 
     /* Initialize minimum TLS version */
     {
-        const int tls_version_min =
+        const int configured_tls_version_min =
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT)
             &SSLF_TLS_VERSION_MIN_MASK;
 
-        /* default to TLS 1.0 */
+        /* default to TLS 1.2 */
         int major = MBEDTLS_SSL_MAJOR_VERSION_3;
-        int minor = MBEDTLS_SSL_MINOR_VERSION_1;
+        int minor = MBEDTLS_SSL_MINOR_VERSION_3;
 
-        if (tls_version_min > TLS_VER_UNSPEC)
+        if (configured_tls_version_min > TLS_VER_UNSPEC)
         {
-            tls_version_to_major_minor(tls_version_min, &major, &minor);
+            tls_version_to_major_minor(configured_tls_version_min, &major, &minor);
         }
 
         mbedtls_ssl_conf_min_version(ks_ssl->ssl_config, major, minor);
@@ -1167,16 +1185,24 @@
 
     /* Initialize maximum TLS version */
     {
-        const int tls_version_max =
+        const int configured_tls_version_max =
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
             &SSLF_TLS_VERSION_MAX_MASK;
 
-        if (tls_version_max > TLS_VER_UNSPEC)
+        int major = 0;
+        int minor = 0;
+
+        if (configured_tls_version_max > TLS_VER_UNSPEC)
         {
-            int major, minor;
-            tls_version_to_major_minor(tls_version_max, &major, &minor);
-            mbedtls_ssl_conf_max_version(ks_ssl->ssl_config, major, minor);
+            tls_version_to_major_minor(configured_tls_version_max, &major, &minor);
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
@@ -1188,7 +1214,7 @@
     /* Initialise SSL context */
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
-    mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config);
+    mbed_ok(mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config));
 
     /* Initialise BIOs */
     ALLOC_OBJ_CLEAR(ks_ssl->bio_ctx, bio_ctx);
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
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
 
+/* Dummy function because Netscape certificate types are not supported in OpenVPN with mbedtls.
+ * Returns SUCCESS if usage is NS_CERT_CHECK_NONE, FAILURE otherwise. */
 result_t
 x509_verify_ns_cert_type(mbedtls_x509_crt *cert, const int usage)
 {
@@ -439,18 +442,6 @@
     {
         return SUCCESS;
     }
-    if (usage == NS_CERT_CHECK_CLIENT)
-    {
-        return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
-                && (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_CLIENT)) ?
-               SUCCESS : FAILURE;
-    }
-    if (usage == NS_CERT_CHECK_SERVER)
-    {
-        return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
-                && (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_SERVER)) ?
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
 
     if (fFound != SUCCESS)
     {
-        msg(D_TLS_ERRORS,
-            "ERROR: Certificate has key usage %04x, expected one of:",
-            cert->key_usage);
+        msg(D_TLS_ERRORS, "ERROR: Certificate has invalid key usage, expected one of:");
         for (size_t i = 0; i < expected_len && expected_ku[i]; i++)
         {
             msg(D_TLS_ERRORS, " * %04x", expected_ku[i]);
@@ -503,7 +492,7 @@
 {
     result_t fFound = FAILURE;
 
-    if (!(cert->ext_types & MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))
+    if (!mbedtls_x509_crt_has_ext_type(cert, MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))
     {
         msg(D_HANDSHAKE, "Certificate does not have extended key usage extension");
     }

