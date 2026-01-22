From: "MaxF (Code Review)" <gerrit@...515...>
Date: Thu, 22 Jan 2026 17:31:51 +0000
In-Reply-To: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
References: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...
Message-ID: <494591495974b4b220ba1e4dbe9a74dcb0c06563-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a/cArQapq28="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add support for
 Mbed TLS 4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: syzzer <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--a/cArQapq28=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, syzzer.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail

to look at the new patch set (#7).


Change subject: Add support for Mbed TLS 4
......................................................................

Add support for Mbed TLS 4

This commit adds support for Mbed TLS 4. This version comes with some
drastic changes. The crypto library has been completely redesigned, so
the contents of crypto_mbedtls.c are moved to crypto_mbedtls_legacy.c
and crypto_mbedtls.c handles the crypto for version 4.

Mbed TLS 4 also removed the feature for looking up a crypto algorithm by
name, so we need to translate algorithm names to Mbed TLS numbers in
OpenVPN. The tables are not yet complete. For symmetric algorithms, I
have added AES and Chacha-Poly which should be enough for most use
cases.

Change-Id: Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
---
M README.mbedtls
M src/openvpn/Makefile.am
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls.h
A src/openvpn/crypto_mbedtls_legacy.c
A src/openvpn/crypto_mbedtls_legacy.h
M src/openvpn/mbedtls_compat.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/syshead.h
M tests/Makefile.am
M tests/t_server_null_default.rc
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_common.h
16 files changed, 2,446 insertions(+), 708 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1441/7

diff --git a/README.mbedtls b/README.mbedtls
index fb30db1..b768687 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -7,8 +7,8 @@
 	make
 	make install

-This version requires mbed TLS version >=3D 3.2.1. Versions >=3D 4.0.0 are=
 not
-yet supported. Support for TLS 1.3 requires an Mbed TLS version >=3D 3.6.4.
+This version requires mbed TLS version >=3D 3.2.1. Support for TLS 1.3 req=
uires
+an Mbed TLS version >=3D 3.6.4.

 *************************************************************************

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index c879585..3c567aa 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -54,6 +54,7 @@
 	comp-lz4.c comp-lz4.h \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
+	crypto_mbedtls_legacy.c crypto_mbedtls_legacy.h \
 	crypto_mbedtls.c crypto_mbedtls.h \
 	crypto_epoch.c crypto_epoch.h \
 	dco.c dco.h dco_internal.h \
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index e9fc2f3..5248614 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -32,9 +32,16 @@
 #ifdef ENABLE_CRYPTO_OPENSSL
 #include "crypto_openssl.h"
 #endif
+
 #ifdef ENABLE_CRYPTO_MBEDTLS
+#include <mbedtls/version.h>
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
+#include "crypto_mbedtls_legacy.h"
+#else
 #include "crypto_mbedtls.h"
 #endif
+#endif
+
 #include "basic.h"
 #include "buffer.h"

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index e1a5cad..f8c1f11 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2025 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -23,7 +23,8 @@

 /**
  * @file
- * Data Channel Cryptography mbed TLS-specific backend interface
+ * Data Channel Cryptography backend interface using the TF-PSA-Crypto lib=
rary
+ * part of Mbed TLS 4.
  */

 #ifdef HAVE_CONFIG_H
@@ -33,6 +34,9 @@
 #include "syshead.h"

 #if defined(ENABLE_CRYPTO_MBEDTLS)
+#include <mbedtls/version.h>
+
+#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000

 #include "errlevel.h"
 #include "basic.h"
@@ -40,20 +44,16 @@
 #include "crypto.h"
 #include "integer.h"
 #include "crypto_backend.h"
+#include "crypto_mbedtls.h"
 #include "otime.h"
 #include "misc.h"

-#include <mbedtls/base64.h>
-#include <mbedtls/des.h>
+#include <psa/crypto.h>
+#include <psa/crypto_config.h>
+#include <mbedtls/constant_time.h>
 #include <mbedtls/error.h>
-#include <mbedtls/md5.h>
-#include <mbedtls/cipher.h>
 #include <mbedtls/pem.h>

-#include <mbedtls/entropy.h>
-#include <mbedtls/ssl.h>
-
-
 /*
  *
  * Hardware engine support. Allows loading/unloading of engines.
@@ -82,331 +82,65 @@
 {
 }

-/*
- *
- * Functions related to the core crypto library
- *
- */
+/* The library doesn't support looking up algorithms by string anymore, so=
 here
+ * is a lookup table. */
+static const cipher_info_t cipher_info_table[] =3D {
+/* TODO: Complete the table. */

-void
-crypto_init_lib(void)
-{
-}
+/* AES */
+#if PSA_WANT_KEY_TYPE_AES
+#if PSA_WANT_ALG_GCM
+    { "AES-128-GCM", PSA_KEY_TYPE_AES, PSA_ALG_GCM, 128 / 8, 96 / 8, 128 /=
 8 },
+    { "AES-192-GCM", PSA_KEY_TYPE_AES, PSA_ALG_GCM, 192 / 8, 96 / 8, 128 /=
 8 },
+    { "AES-256-GCM", PSA_KEY_TYPE_AES, PSA_ALG_GCM, 256 / 8, 96 / 8, 128 /=
 8 },
+#endif /* PSA_WANT_ALG_GCM */
+#if PSA_WANT_ALG_CBC_PKCS7
+    { "AES-128-CBC", PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 128 / 8, 128 / 8=
, 128 / 8 },
+    { "AES-192-CBC", PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 192 / 8, 128 / 8=
, 128 / 8 },
+    { "AES-256-CBC", PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 256 / 8, 128 / 8=
, 128 / 8 },
+#endif /* PSA_WANT_ALG_CBC_PKCS7 */
+#if PSA_WANT_ALG_CTR
+    { "AES-128-CTR", PSA_KEY_TYPE_AES, PSA_ALG_CTR, 128 / 8, 128 / 8, 128 =
/ 8 },
+    { "AES-192-CTR", PSA_KEY_TYPE_AES, PSA_ALG_CTR, 192 / 8, 128 / 8, 128 =
/ 8 },
+    { "AES-256-CTR", PSA_KEY_TYPE_AES, PSA_ALG_CTR, 256 / 8, 128 / 8, 128 =
/ 8 },
+#endif /* PSA_WANT_ALG_CTR */
+#endif /* PSA_WANT_KEY_TYPE_AES */
=20
-void
-crypto_uninit_lib(void)
-{
-}
-
-void
-crypto_clear_error(void)
-{
-}
-
-bool
-mbed_log_err(unsigned int flags, int errval, const char *prefix)
-{
-    if (0 !=3D errval)
-    {
-        char errstr[256];
-        mbedtls_strerror(errval, errstr, sizeof(errstr));
-
-        if (NULL =3D=3D prefix)
-        {
-            prefix =3D "mbed TLS error";
-        }
-        msg(flags, "%s: %s", prefix, errstr);
-    }
-
-    return 0 =3D=3D errval;
-}
-
-bool
-mbed_log_func_line(unsigned int flags, int errval, const char *func, int l=
ine)
-{
-    char prefix[256];
-
-    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >=3D sizeof(=
prefix))
-    {
-        return mbed_log_err(flags, errval, func);
-    }
-
-    return mbed_log_err(flags, errval, prefix);
-}
-
-
-#ifdef DMALLOC
-void
-crypto_init_dmalloc(void)
-{
-    msg(M_ERR, "Error: dmalloc support is not available for mbed TLS.");
-}
-#endif /* DMALLOC */
-
-const cipher_name_pair cipher_name_translation_table[] =3D {
-    { "BF-CBC", "BLOWFISH-CBC" },
-    { "BF-CFB", "BLOWFISH-CFB64" },
-    { "CAMELLIA-128-CFB", "CAMELLIA-128-CFB128" },
-    { "CAMELLIA-192-CFB", "CAMELLIA-192-CFB128" },
-    { "CAMELLIA-256-CFB", "CAMELLIA-256-CFB128" }
+/* Chacha-Poly */
+#if PSA_WANT_KEY_TYPE_CHACHA20 && PSA_WANT_ALG_CHACHA20_POLY1305
+    { "CHACHA20-POLY1305", PSA_KEY_TYPE_CHACHA20, PSA_ALG_CHACHA20_POLY130=
5, 256 / 8, 96 / 8, 1 },
+#endif
 };
+static const size_t cipher_info_table_entries =3D sizeof(cipher_info_table=
) / sizeof(cipher_info_t);
+
+static const cipher_info_t *
+cipher_get(const char *ciphername)
+{
+    for (size_t i =3D 0; i < cipher_info_table_entries; i++)
+    {
+        if (strcmp(ciphername, cipher_info_table[i].name) =3D=3D 0)
+        {
+            return &cipher_info_table[i];
+        }
+    }
+    return NULL;
+}
+
+/* Because Mbed TLS 4 doesn't support looking up algorithms by string, the=
re's
+ * nothing to translate. */
+const cipher_name_pair cipher_name_translation_table[] =3D {};
 const size_t cipher_name_translation_table_count =3D
-    sizeof(cipher_name_translation_table) / sizeof(*cipher_name_translatio=
n_table);
-
-void
-show_available_ciphers(void)
-{
-    const int *ciphers =3D mbedtls_cipher_list();
-
-#ifndef ENABLE_SMALL
-    printf("The following ciphers and cipher modes are available for use\n"
-           "with " PACKAGE_NAME ".  Each cipher shown below may be used as=
 a\n"
-           "parameter to the --data-ciphers (or --cipher) option.  Using a=
\n"
-           "GCM or CBC mode is recommended.  In static key mode only CBC\n"
-           "mode is allowed.\n\n");
-#endif
-
-    while (*ciphers !=3D 0)
-    {
-        const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_typ=
e(*ciphers);
-        const char *name =3D mbedtls_cipher_info_get_name(info);
-        if (info && name && !cipher_kt_insecure(name)
-            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
-        {
-            print_cipher(name);
-        }
-        ciphers++;
-    }
-
-    printf("\nThe following ciphers have a block size of less than 128 bit=
s, \n"
-           "and are therefore deprecated.  Do not use unless you have to.\=
n\n");
-    ciphers =3D mbedtls_cipher_list();
-    while (*ciphers !=3D 0)
-    {
-        const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_typ=
e(*ciphers);
-        const char *name =3D mbedtls_cipher_info_get_name(info);
-        if (info && name && cipher_kt_insecure(name)
-            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
-        {
-            print_cipher(name);
-        }
-        ciphers++;
-    }
-    printf("\n");
-}
-
-void
-show_available_digests(void)
-{
-    const int *digests =3D mbedtls_md_list();
-
-#ifndef ENABLE_SMALL
-    printf("The following message digests are available for use with\n" PA=
CKAGE_NAME
-           ".  A message digest is used in conjunction with\n"
-           "the HMAC function, to authenticate received packets.\n"
-           "You can specify a message digest as parameter to\n"
-           "the --auth option.\n\n");
-#endif
-
-    while (*digests !=3D 0)
-    {
-        const mbedtls_md_info_t *info =3D mbedtls_md_info_from_type(*diges=
ts);
-
-        if (info)
-        {
-            printf("%s %d bit default key\n", mbedtls_md_get_name(info),
-                   mbedtls_md_get_size(info) * 8);
-        }
-        digests++;
-    }
-    printf("\n");
-}
-
-void
-show_available_engines(void)
-{
-    printf("Sorry, mbed TLS hardware crypto engine functionality is not "
-           "available\n");
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-bool
-crypto_pem_encode(const char *name, struct buffer *dst, const struct buffe=
r *src,
-                  struct gc_arena *gc)
-{
-    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
-    char header[1000 + 1] =3D { 0 };
-    char footer[1000 + 1] =3D { 0 };
-
-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >=
=3D sizeof(header))
-    {
-        return false;
-    }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >=3D =
sizeof(footer))
-    {
-        return false;
-    }
-
-    size_t out_len =3D 0;
-    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
-        !=3D mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src)=
, NULL, 0, &out_len))
-    {
-        return false;
-    }
-
-    /* We set the size buf to out_len-1 to NOT include the 0 byte that
-     * mbedtls_pem_write_buffer in its length calculation */
-    *dst =3D alloc_buf_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(=
src), BPTR(dst),
-                                          BCAP(dst), &out_len))
-        || !buf_inc_len(dst, out_len - 1))
-    {
-        CLEAR(*dst);
-        return false;
-    }
-
-    return true;
-}
-
-bool
-crypto_pem_decode(const char *name, struct buffer *dst, const struct buffe=
r *src)
-{
-    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
-    char header[1000 + 1] =3D { 0 };
-    char footer[1000 + 1] =3D { 0 };
-
-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >=3D =
sizeof(header))
-    {
-        return false;
-    }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >=3D si=
zeof(footer))
-    {
-        return false;
-    }
-
-    /* mbed TLS requires the src to be null-terminated */
-    /* allocate a new buffer to avoid modifying the src buffer */
-    struct gc_arena gc =3D gc_new();
-    struct buffer input =3D alloc_buf_gc(BLEN(src) + 1, &gc);
-    buf_copy(&input, src);
-    buf_null_terminate(&input);
-
-    size_t use_len =3D 0;
-    mbedtls_pem_context ctx =3D { 0 };
-    bool ret =3D
-        mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(&input)=
, NULL, 0, &use_len));
-    size_t buf_size =3D 0;
-    const unsigned char *buf =3D mbedtls_pem_get_buffer(&ctx, &buf_size);
-    if (ret && !buf_write(dst, buf, buf_size))
-    {
-        ret =3D false;
-        msg(M_WARN, "PEM decode error: destination buffer too small");
-    }
-
-    mbedtls_pem_free(&ctx);
-    gc_free(&gc);
-    return ret;
-}
-
-/*
- *
- * Random number functions, used in cases where we want
- * reasonably strong cryptographic random number generation
- * without depleting our entropy pool.  Used for random
- * IV values and a number of other miscellaneous tasks.
- *
- */
-
-/*
- * Initialise the given ctr_drbg context, using a personalisation string a=
nd an
- * entropy gathering function.
- */
-mbedtls_ctr_drbg_context *
-rand_ctx_get(void)
-{
-    static mbedtls_entropy_context ec =3D { 0 };
-    static mbedtls_ctr_drbg_context cd_ctx =3D { 0 };
-    static bool rand_initialised =3D false;
-
-    if (!rand_initialised)
-    {
-        struct gc_arena gc =3D gc_new();
-        struct buffer pers_string =3D alloc_buf_gc(100, &gc);
-
-        /*
-         * Personalisation string, should be as unique as possible (see NI=
ST
-         * 800-90 section 8.7.1). We have very little information at this =
stage.
-         * Include Program Name, memory address of the context and PID.
-         */
-        buf_printf(&pers_string, "OpenVPN %0u %p %s", platform_getpid(), &=
cd_ctx,
-                   time_string(0, 0, 0, &gc));
-
-        /* Initialise mbed TLS RNG, and built-in entropy sources */
-        mbedtls_entropy_init(&ec);
-
-        mbedtls_ctr_drbg_init(&cd_ctx);
-        if (!mbed_ok(mbedtls_ctr_drbg_seed(&cd_ctx, mbedtls_entropy_func, =
&ec, BPTR(&pers_string),
-                                           BLEN(&pers_string))))
-        {
-            msg(M_FATAL, "Failed to initialize random generator");
-        }
-
-        gc_free(&gc);
-        rand_initialised =3D true;
-    }
-
-    return &cd_ctx;
-}
-
-#ifdef ENABLE_PREDICTION_RESISTANCE
-void
-rand_ctx_enable_prediction_resistance(void)
-{
-    mbedtls_ctr_drbg_context *cd_ctx =3D rand_ctx_get();
-
-    mbedtls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);
-}
-#endif /* ENABLE_PREDICTION_RESISTANCE */
+    sizeof(cipher_name_translation_table) / sizeof(cipher_name_pair);

 int
 rand_bytes(uint8_t *output, int len)
 {
-    mbedtls_ctr_drbg_context *rng_ctx =3D rand_ctx_get();
-
-    while (len > 0)
+    if (len < 0)
     {
-        const size_t blen =3D min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
-        if (0 !=3D mbedtls_ctr_drbg_random(rng_ctx, output, blen))
-        {
-            return 0;
-        }
-
-        output +=3D blen;
-        len -=3D blen;
+        return 0;
     }
-
-    return 1;
-}
-
-/*
- *
- * Generic cipher key type functions
- *
- */
-static const mbedtls_cipher_info_t *
-cipher_get(const char *ciphername)
-{
-    ASSERT(ciphername);
-
-    const mbedtls_cipher_info_t *cipher =3D NULL;
-
-    ciphername =3D translate_cipher_name_from_openvpn(ciphername);
-    cipher =3D mbedtls_cipher_info_from_string(ciphername);
-    return cipher;
+    psa_status_t result =3D psa_generate_random(output, (size_t)len);
+    return result =3D=3D PSA_SUCCESS;
 }

 bool
@@ -414,23 +148,22 @@
 {
     ASSERT(reason);

-    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);
+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);

-    if (NULL =3D=3D cipher)
+    if (cipher_info =3D=3D NULL)
     {
         msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
         *reason =3D "disabled because unknown";
         return false;
     }

-    const size_t key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(cipher=
) / 8;
-    if (key_bytelen > MAX_CIPHER_KEY_LENGTH)
+    if (cipher_info->key_bytes > MAX_CIPHER_KEY_LENGTH)
     {
         msg(D_LOW,
-            "Cipher algorithm '%s' uses a default key size (%zu bytes) "
+            "Cipher algorithm '%s' uses a default key size (%d bytes) "
             "which is larger than " PACKAGE_NAME "'s current maximum key s=
ize "
             "(%d bytes)",
-            ciphername, key_bytelen, MAX_CIPHER_KEY_LENGTH);
+            ciphername, cipher_info->key_bytes, MAX_CIPHER_KEY_LENGTH);
         *reason =3D "disabled due to key size too large";
         return false;
     }
@@ -442,49 +175,46 @@
 const char *
 cipher_kt_name(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
-    if (NULL =3D=3D cipher_kt)
+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);
+    if (cipher_info =3D=3D NULL)
     {
         return "[null-cipher]";
     }
-
-    return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(c=
ipher_kt));
+    return cipher_info->name;
 }

 int
 cipher_kt_key_size(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
-
-    if (NULL =3D=3D cipher_kt)
+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);
+    if (cipher_info =3D=3D NULL)
     {
         return 0;
     }
-
-    return (int)mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;
+    return cipher_info->key_bytes;
 }

 int
 cipher_kt_iv_size(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);

-    if (NULL =3D=3D cipher_kt)
+    if (cipher_info =3D=3D NULL)
     {
         return 0;
     }
-    return (int)mbedtls_cipher_info_get_iv_size(cipher_kt);
+    return cipher_info->iv_bytes;
 }

 int
 cipher_kt_block_size(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
-    if (NULL =3D=3D cipher_kt)
+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);
+    if (cipher_info =3D=3D NULL)
     {
         return 0;
     }
-    return (int)mbedtls_cipher_info_get_block_size(cipher_kt);
+    return cipher_info->block_size;
 }

 int
@@ -500,498 +230,596 @@
 bool
 cipher_kt_insecure(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
-    if (!cipher_kt)
+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);
+    if (cipher_info =3D=3D NULL)
     {
         return true;
     }

-    return !(cipher_kt_block_size(ciphername) >=3D 128 / 8
-#ifdef MBEDTLS_CHACHAPOLY_C
-             || mbedtls_cipher_info_get_type(cipher_kt) =3D=3D MBEDTLS_CIP=
HER_CHACHA20_POLY1305
-#endif
-    );
-}
-
-static mbedtls_cipher_mode_t
-cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
-{
-    ASSERT(NULL !=3D cipher_kt);
-    return mbedtls_cipher_info_get_mode(cipher_kt);
+    return !(cipher_info->block_size >=3D 128 / 8
+             || cipher_info->psa_alg =3D=3D PSA_ALG_CHACHA20_POLY1305);
 }

 bool
 cipher_kt_mode_cbc(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);
-    return cipher && cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_CBC;
+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);
+    if (cipher_info =3D=3D NULL)
+    {
+        return false;
+    }
+    return cipher_info->psa_alg =3D=3D PSA_ALG_CBC_PKCS7;
 }

 bool
 cipher_kt_mode_ofb_cfb(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);
-    return cipher
-           && (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_OFB
-               || cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_CFB);
+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);
+    if (cipher_info =3D=3D NULL)
+    {
+        return false;
+    }
+    return cipher_info->psa_alg =3D=3D PSA_ALG_OFB || cipher_info->psa_alg=
 =3D=3D PSA_ALG_CFB;
 }

 bool
 cipher_kt_mode_aead(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);
-    return cipher
-           && (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_GCM
-#ifdef MBEDTLS_CHACHAPOLY_C
-               || cipher_kt_mode(cipher) =3D=3D MBEDTLS_MODE_CHACHAPOLY
-#endif
-           );
+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);
+    if (cipher_info =3D=3D NULL)
+    {
+        return false;
+    }
+    return cipher_info->psa_alg =3D=3D PSA_ALG_GCM || cipher_info->psa_alg=
 =3D=3D PSA_ALG_CHACHA20_POLY1305;
 }

-
-/*
- *
- * Generic cipher context functions
- *
- */
-
-mbedtls_cipher_context_t *
+cipher_ctx_t *
 cipher_ctx_new(void)
 {
-    mbedtls_cipher_context_t *ctx;
-    ALLOC_OBJ(ctx, mbedtls_cipher_context_t);
+    cipher_ctx_t *ctx;
+    /* Initializing the object with zeros ensures that it is always safe t=
o call
+     * cipher_ctx_free. */
+    ALLOC_OBJ_CLEAR(ctx, cipher_ctx_t);
     return ctx;
 }

 void
-cipher_ctx_free(mbedtls_cipher_context_t *ctx)
+cipher_ctx_free(cipher_ctx_t *ctx)
 {
-    mbedtls_cipher_free(ctx);
+    if (cipher_ctx_mode_aead(ctx))
+    {
+        ASSERT(psa_aead_abort(&ctx->operation.aead) =3D=3D PSA_SUCCESS);
+    }
+    else
+    {
+        ASSERT(psa_cipher_abort(&ctx->operation.cipher) =3D=3D PSA_SUCCESS=
);
+    }
+    ASSERT(psa_destroy_key(ctx->key) =3D=3D PSA_SUCCESS);
     free(ctx);
 }

 void
-cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, const c=
har *ciphername,
+cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, const char *ciphern=
ame,
                 crypto_operation_t enc)
 {
-    ASSERT(NULL !=3D ciphername && NULL !=3D ctx);
+    ASSERT(ciphername !=3D NULL && ctx !=3D NULL);
     CLEAR(*ctx);

-    const mbedtls_cipher_info_t *kt =3D cipher_get(ciphername);
-    ASSERT(kt);
-    size_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(kt);
+    ctx->cipher_info =3D cipher_get(ciphername);
+    ASSERT(ctx->cipher_info !=3D NULL);

-    if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
-    {
-        msg(M_FATAL, "mbed TLS cipher context init #1");
-    }
+    psa_set_key_type(&ctx->key_attributes, ctx->cipher_info->psa_key_type);
+    psa_set_key_algorithm(&ctx->key_attributes, ctx->cipher_info->psa_alg);
+    psa_set_key_bits(&ctx->key_attributes, (size_t)ctx->cipher_info->key_b=
ytes * 8);
+    psa_set_key_usage_flags(&ctx->key_attributes,
+                            enc =3D=3D OPENVPN_OP_ENCRYPT ? PSA_KEY_USAGE_=
ENCRYPT : PSA_KEY_USAGE_DECRYPT);

-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, enc)))
+    if (psa_import_key(&ctx->key_attributes, key, (size_t)ctx->cipher_info=
->key_bytes, &ctx->key) !=3D PSA_SUCCESS)
     {
-        msg(M_FATAL, "mbed TLS cipher set key");
-    }
-
-    if (mbedtls_cipher_info_get_mode(kt) =3D=3D MBEDTLS_MODE_CBC)
-    {
-        if (!mbed_ok(mbedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_=
PKCS7)))
-        {
-            msg(M_FATAL, "mbed TLS cipher set padding mode");
-        }
+        msg(M_FATAL, "psa_import_key failed");
     }

     /* make sure we used a big enough key */
-    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) <=3D key_bitlen);
+    ASSERT(psa_get_key_bits(&ctx->key_attributes) =3D=3D (size_t)(8 * ctx-=
>cipher_info->key_bytes));
 }

 int
-cipher_ctx_iv_length(const mbedtls_cipher_context_t *ctx)
+cipher_ctx_iv_length(const cipher_ctx_t *ctx)
 {
-    return mbedtls_cipher_get_iv_size(ctx);
+    return ctx->cipher_info->iv_bytes;
 }

 int
 cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_len)
 {
-    if (tag_len > SIZE_MAX)
+    if (!ctx->aead_finished || tag_len < OPENVPN_AEAD_TAG_LENGTH)
     {
         return 0;
     }

-    if (!mbed_ok(mbedtls_cipher_write_tag(ctx, (unsigned char *)tag, tag_l=
en)))
-    {
-        return 0;
-    }
-
+    memcpy(tag, ctx->tag, OPENVPN_AEAD_TAG_LENGTH);
     return 1;
 }

 int
-cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)
+cipher_ctx_block_size(const cipher_ctx_t *ctx)
 {
-    return (int)mbedtls_cipher_get_block_size(ctx);
+    return ctx->cipher_info->block_size;
 }

 int
-cipher_ctx_mode(const mbedtls_cipher_context_t *ctx)
+cipher_ctx_mode(const cipher_ctx_t *ctx)
 {
-    ASSERT(NULL !=3D ctx);
-
-    return mbedtls_cipher_get_cipher_mode(ctx);
+    ASSERT(ctx !=3D NULL);
+    return (int)psa_get_key_algorithm(&ctx->key_attributes);
 }

 bool
 cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
 {
-    return ctx && cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CBC;
+    return ctx !=3D NULL && cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CBC;
 }

-
 bool
 cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
 {
-    return ctx
-           && (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_OFB
-               || cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CFB);
+    if (ctx =3D=3D NULL)
+    {
+        return false;
+    }
+    int mode =3D cipher_ctx_mode(ctx);
+    return mode =3D=3D OPENVPN_MODE_OFB || mode =3D=3D OPENVPN_MODE_CFB;
 }

 bool
 cipher_ctx_mode_aead(const cipher_ctx_t *ctx)
 {
-    return ctx
-           && (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_GCM
-#ifdef MBEDTLS_CHACHAPOLY_C
-               || cipher_ctx_mode(ctx) =3D=3D MBEDTLS_MODE_CHACHAPOLY
-#endif
-           );
+    if (ctx =3D=3D NULL)
+    {
+        return false;
+    }
+    int mode =3D cipher_ctx_mode(ctx);
+    return mode =3D=3D (int)PSA_ALG_GCM || mode =3D=3D (int)PSA_ALG_CHACHA=
20_POLY1305;
+}
+
+static int
+cipher_ctx_direction(const cipher_ctx_t *ctx)
+{
+    psa_key_usage_t key_usage =3D psa_get_key_usage_flags(&ctx->key_attrib=
utes);
+    if (key_usage & PSA_KEY_USAGE_ENCRYPT)
+    {
+        return OPENVPN_OP_ENCRYPT;
+    }
+    else if (key_usage & PSA_KEY_USAGE_DECRYPT)
+    {
+        return OPENVPN_OP_DECRYPT;
+    }
+    else
+    {
+        return -1;
+    }
 }

 int
-cipher_ctx_reset(mbedtls_cipher_context_t *ctx, const uint8_t *iv_buf)
+cipher_ctx_reset(cipher_ctx_t *ctx, const uint8_t *iv_buf)
 {
-    if (!mbed_ok(mbedtls_cipher_reset(ctx)))
-    {
-        return 0;
-    }
+    psa_status_t status =3D 0;

-    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher=
_get_iv_size(ctx))))
+    if (cipher_ctx_mode_aead(ctx))
     {
-        return 0;
+        if (psa_aead_abort(&ctx->operation.aead) !=3D PSA_SUCCESS)
+        {
+            return 0;
+        }
+
+        if (cipher_ctx_direction(ctx) =3D=3D OPENVPN_OP_ENCRYPT)
+        {
+            status =3D psa_aead_encrypt_setup(&ctx->operation.aead, ctx->k=
ey, ctx->cipher_info->psa_alg);
+        }
+        else if (cipher_ctx_direction(ctx) =3D=3D OPENVPN_OP_DECRYPT)
+        {
+            status =3D psa_aead_decrypt_setup(&ctx->operation.aead, ctx->k=
ey, ctx->cipher_info->psa_alg);
+        }
+        else
+        {
+            return 0;
+        }
+
+        if (status !=3D PSA_SUCCESS)
+        {
+            return 0;
+        }
+
+        status =3D psa_aead_set_nonce(&ctx->operation.aead, iv_buf, ctx->c=
ipher_info->iv_bytes);
+        if (status !=3D PSA_SUCCESS)
+        {
+            return 0;
+        }
+    }
+    else
+    {
+        if (psa_cipher_abort(&ctx->operation.cipher) !=3D PSA_SUCCESS)
+        {
+            return 0;
+        }
+
+        if (cipher_ctx_direction(ctx) =3D=3D OPENVPN_OP_ENCRYPT)
+        {
+            status =3D psa_cipher_encrypt_setup(&ctx->operation.cipher, ct=
x->key, ctx->cipher_info->psa_alg);
+        }
+        else if (cipher_ctx_direction(ctx) =3D=3D OPENVPN_OP_DECRYPT)
+        {
+            status =3D psa_cipher_decrypt_setup(&ctx->operation.cipher, ct=
x->key, ctx->cipher_info->psa_alg);
+        }
+        else
+        {
+            return 0;
+        }
+
+        if (status !=3D PSA_SUCCESS)
+        {
+            return 0;
+        }
+
+        status =3D psa_cipher_set_iv(&ctx->operation.cipher, iv_buf, ctx->=
cipher_info->iv_bytes);
+        if (status !=3D PSA_SUCCESS)
+        {
+            return 0;
+        }
     }

     return 1;
 }

+/* We rely on the caller to ensure that the destination buffer has enough =
room,
+ * but Mbed TLS always wants a size for the destination buffer. This funct=
ion
+ * calculates the minimum necessary size for a given cipher and input leng=
th.
+ *
+ * This funcion assumes that src_len has been checked to be >=3D 0. */
+static size_t
+needed_dst_size(const cipher_ctx_t *ctx, int src_len)
+{
+    int mode =3D cipher_ctx_mode(ctx);
+    if (mode =3D=3D PSA_ALG_CTR || mode =3D=3D PSA_ALG_GCM || mode =3D=3D =
PSA_ALG_CHACHA20_POLY1305)
+    {
+        /* These algorithms are based on a keystream, so the input and out=
put
+         * length are always equal. */
+        return (size_t)src_len;
+    }
+    else
+    {
+        /* These algorithms are block-based. The number of output blocks t=
hat are
+         * produced is at most 1 + src_len / block_size. */
+        size_t block_size =3D (size_t)cipher_ctx_block_size(ctx);
+        size_t max_blocks =3D 1 + (size_t)src_len / block_size;
+        return max_blocks * block_size;
+    }
+}
+
 int
 cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)
 {
-    if (src_len > SIZE_MAX)
+    if (src_len < 0 || !cipher_ctx_mode_aead(ctx))
     {
         return 0;
     }

-    if (!mbed_ok(mbedtls_cipher_update_ad(ctx, src, src_len)))
+    if (psa_aead_update_ad(&ctx->operation.aead, src, (size_t)src_len) !=
=3D PSA_SUCCESS)
     {
         return 0;
     }
+    return 1;
+}
+
+int
+cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *=
src, int src_len)
+{
+    if (src_len < 0)
+    {
+        return 0;
+    }
+
+    size_t dst_size =3D needed_dst_size(ctx, src_len);
+    size_t psa_output_len =3D 0;
+    psa_status_t status =3D 0;
+
+    if (cipher_ctx_mode_aead(ctx))
+    {
+        status =3D psa_aead_update(&ctx->operation.aead, src, (size_t)src_=
len, dst, dst_size, &psa_output_len);
+    }
+    else
+    {
+        status =3D psa_cipher_update(&ctx->operation.cipher, src, (size_t)=
src_len, dst, dst_size, &psa_output_len);
+    }
+
+    if (status !=3D PSA_SUCCESS)
+    {
+        return 0;
+    }
+
+    if (psa_output_len > INT_MAX)
+    {
+        return 0;
+    }
+    *dst_len =3D (int)psa_output_len;

     return 1;
 }

 int
-cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_le=
n, uint8_t *src,
-                  int src_len)
+cipher_ctx_final(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len)
 {
-    size_t s_dst_len =3D *dst_len;
+    size_t dst_size =3D needed_dst_size(ctx, 0);
+    size_t psa_output_len =3D 0;
+    psa_status_t status =3D 0;

-    if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t)src_len, dst, &s_=
dst_len)))
+    if (cipher_ctx_mode_aead(ctx))
     {
-        return 0;
+        size_t actual_tag_size =3D 0;
+        status =3D psa_aead_finish(&ctx->operation.aead,
+                                 dst,
+                                 dst_size,
+                                 &psa_output_len,
+                                 ctx->tag,
+                                 (size_t)OPENVPN_AEAD_TAG_LENGTH,
+                                 &actual_tag_size);
+        if (status !=3D PSA_SUCCESS || psa_output_len > (size_t)INT_MAX ||=
 actual_tag_size !=3D (size_t)OPENVPN_AEAD_TAG_LENGTH)
+        {
+            return 0;
+        }
+        ctx->aead_finished =3D true;
+    }
+    else
+    {
+        status =3D psa_cipher_finish(&ctx->operation.cipher, dst, dst_size=
, &psa_output_len);
+        if (status !=3D PSA_SUCCESS || psa_output_len > (size_t)INT_MAX)
+        {
+            return 0;
+        }
     }

-    *dst_len =3D s_dst_len;
+    *dst_len =3D (int)psa_output_len;

     return 1;
 }

 int
-cipher_ctx_final(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len)
+cipher_ctx_final_check_tag(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, =
uint8_t *tag, size_t tag_len)
 {
-    size_t s_dst_len =3D *dst_len;
-
-    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &s_dst_len)))
+    if (cipher_ctx_direction(ctx) !=3D OPENVPN_OP_DECRYPT || !cipher_ctx_m=
ode_aead(ctx))
     {
         return 0;
     }

-    *dst_len =3D s_dst_len;
+    size_t psa_output_len =3D 0;
+    psa_status_t status =3D 0;
+
+    status =3D psa_aead_verify(&ctx->operation.aead, dst, 0, &psa_output_l=
en, tag, tag_len);
+    if (status !=3D PSA_SUCCESS || psa_output_len > (size_t)INT_MAX)
+    {
+        return 0;
+    }
+    *dst_len =3D (int)psa_output_len;

     return 1;
 }

-int
-cipher_ctx_final_check_tag(mbedtls_cipher_context_t *ctx, uint8_t *dst, in=
t *dst_len, uint8_t *tag,
-                           size_t tag_len)
+static const md_info_t md_info_table[] =3D {
+    /* TODO: Fill out table. */
+    { "MD5", PSA_ALG_MD5 },
+    { "SHA1", PSA_ALG_SHA_1 },
+    { "SHA256", PSA_ALG_SHA_256 },
+};
+const size_t md_info_table_entries =3D sizeof(md_info_table) / sizeof(md_i=
nfo_t);
+
+static const md_info_t *
+md_get(const char *digest_name)
 {
-    size_t olen =3D 0;
-
-    if (MBEDTLS_DECRYPT !=3D mbedtls_cipher_get_operation(ctx))
+    for (size_t i =3D 0; i < md_info_table_entries; i++)
     {
-        return 0;
+        if (strcmp(digest_name, md_info_table[i].name) =3D=3D 0)
+        {
+            return &md_info_table[i];
+        }
     }
-
-    if (tag_len > SIZE_MAX)
-    {
-        return 0;
-    }
-
-    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &olen)))
-    {
-        msg(D_CRYPT_ERRORS, "%s: cipher_ctx_final() failed", __func__);
-        return 0;
-    }
-
-    if (olen > INT_MAX)
-    {
-        return 0;
-    }
-    *dst_len =3D olen;
-
-    if (!mbed_ok(mbedtls_cipher_check_tag(ctx, (const unsigned char *)tag,=
 tag_len)))
-    {
-        return 0;
-    }
-
-    return 1;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
-/*
- *
- * Generic message digest information functions
- *
- */
-
-
-static const mbedtls_md_info_t *
-md_get(const char *digest)
-{
-    const mbedtls_md_info_t *md =3D NULL;
-    ASSERT(digest);
-
-    md =3D mbedtls_md_info_from_string(digest);
-    if (!md)
-    {
-        msg(M_FATAL, "Message hash algorithm '%s' not found", digest);
-    }
-    if (mbedtls_md_get_size(md) > MAX_HMAC_KEY_LENGTH)
-    {
-        msg(M_FATAL,
-            "Message hash algorithm '%s' uses a default hash size (%d byte=
s) which is larger than " PACKAGE_NAME
-            "'s current maximum hash size (%d bytes)",
-            digest, mbedtls_md_get_size(md), MAX_HMAC_KEY_LENGTH);
-    }
-    return md;
+    return NULL;
 }

 bool
 md_valid(const char *digest)
 {
-    const mbedtls_md_info_t *md =3D mbedtls_md_info_from_string(digest);
+    const md_info_t *md =3D md_get(digest);
     return md !=3D NULL;
 }

 const char *
 md_kt_name(const char *mdname)
 {
-    if (!strcmp("none", mdname))
+    if (strcmp("none", mdname) =3D=3D 0)
     {
         return "[null-digest]";
     }
-    const mbedtls_md_info_t *kt =3D md_get(mdname);
-    return mbedtls_md_get_name(kt);
+    const md_info_t *md =3D md_get(mdname);
+    if (md =3D=3D NULL)
+    {
+        return NULL;
+    }
+    return md->name;
 }
=20
 unsigned char
 md_kt_size(const char *mdname)
 {
-    if (!strcmp("none", mdname))
+    if (strcmp("none", mdname) =3D=3D 0)
     {
         return 0;
     }
-    const mbedtls_md_info_t *kt =3D md_get(mdname);
-    return mbedtls_md_get_size(kt);
+    const md_info_t *md_info =3D md_get(mdname);
+    if (md_info =3D=3D NULL)
+    {
+        return 0;
+    }
+    return (unsigned char)PSA_HASH_LENGTH(md_info->psa_alg);
 }

-/*
- *
- * Generic message digest functions
- *
- */
+md_ctx_t *
+md_ctx_new(void)
+{
+    md_ctx_t *ctx;
+    ALLOC_OBJ_CLEAR(ctx, md_ctx_t);
+    return ctx;
+}

 int
 md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst)
 {
-    const mbedtls_md_info_t *kt =3D md_get(mdname);
-    return 0 =3D=3D mbedtls_md(kt, src, src_len, dst);
-}
+    const md_info_t *md =3D md_get(mdname);
+    if (md =3D=3D NULL || src_len < 0)
+    {
+        return 0;
+    }

-mbedtls_md_context_t *
-md_ctx_new(void)
-{
-    mbedtls_md_context_t *ctx;
-    ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);
-    return ctx;
+    /* We depend on the caller to ensure that dst has enough room for the =
hash,
+     * so we just tell PSA that it can hold the appropriate amount of byte=
s. */
+    size_t dst_size =3D PSA_HASH_LENGTH(md->psa_alg);
+    size_t hash_length =3D 0;
+
+    psa_status_t status =3D psa_hash_compute(md->psa_alg, src, (size_t)src=
_len, dst, dst_size, &hash_length);
+    if (status !=3D PSA_SUCCESS || hash_length !=3D dst_size)
+    {
+        return 0;
+    }
+    return 1;
 }

 void
-md_ctx_free(mbedtls_md_context_t *ctx)
+md_ctx_free(md_ctx_t *ctx)
 {
     free(ctx);
 }

 void
-md_ctx_init(mbedtls_md_context_t *ctx, const char *mdname)
+md_ctx_init(md_ctx_t *ctx, const char *mdname)
 {
-    const mbedtls_md_info_t *kt =3D md_get(mdname);
-    ASSERT(NULL !=3D ctx && NULL !=3D kt);
+    const md_info_t *md_info =3D md_get(mdname);
+    ASSERT(ctx !=3D NULL && md_info !=3D NULL);

-    mbedtls_md_init(ctx);
-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 0));
-    ASSERT(0 =3D=3D mbedtls_md_starts(ctx));
+    ctx->md_info =3D md_info;
+    ASSERT(psa_hash_setup(&ctx->operation, md_info->psa_alg) =3D=3D PSA_SU=
CCESS);
 }

 void
-md_ctx_cleanup(mbedtls_md_context_t *ctx)
+md_ctx_cleanup(md_ctx_t *ctx)
 {
-    mbedtls_md_free(ctx);
+    ASSERT(psa_hash_abort(&ctx->operation) =3D=3D PSA_SUCCESS);
 }

 int
-md_ctx_size(const mbedtls_md_context_t *ctx)
+md_ctx_size(const md_ctx_t *ctx)
 {
-    if (NULL =3D=3D ctx)
+    if (ctx =3D=3D NULL)
     {
         return 0;
     }
-    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
+    return (int)PSA_HASH_LENGTH(ctx->md_info->psa_alg);
 }

 void
-md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_le=
n)
+md_ctx_update(md_ctx_t *ctx, const uint8_t *src, size_t src_len)
 {
-    ASSERT(0 =3D=3D mbedtls_md_update(ctx, src, src_len));
+    ASSERT(psa_hash_update(&ctx->operation, src, src_len) =3D=3D PSA_SUCCE=
SS);
 }

 void
-md_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
+md_ctx_final(md_ctx_t *ctx, uint8_t *dst)
 {
-    ASSERT(0 =3D=3D mbedtls_md_finish(ctx, dst));
-    mbedtls_md_free(ctx);
+    /* We depend on the caller to ensure that dst has enough room for the =
hash,
+     * so we just tell PSA that it can hold the appropriate amount of byte=
s. */
+    size_t dst_size =3D PSA_HASH_LENGTH(ctx->md_info->psa_alg);
+    size_t hash_length =3D 0;
+
+    ASSERT(psa_hash_finish(&ctx->operation, dst, dst_size, &hash_length) =
=3D=3D PSA_SUCCESS);
+    ASSERT(hash_length =3D=3D dst_size);
 }

-
-/*
- *
- * Generic HMAC functions
- *
- */
-
-
-/*
- * TODO: re-enable dmsg for crypto debug
- */
-
-mbedtls_md_context_t *
+hmac_ctx_t *
 hmac_ctx_new(void)
 {
-    mbedtls_md_context_t *ctx;
-    ALLOC_OBJ(ctx, mbedtls_md_context_t);
+    hmac_ctx_t *ctx;
+    ALLOC_OBJ_CLEAR(ctx, hmac_ctx_t);
     return ctx;
 }

 void
-hmac_ctx_free(mbedtls_md_context_t *ctx)
+hmac_ctx_free(hmac_ctx_t *ctx)
 {
     free(ctx);
 }

-void
-hmac_ctx_init(mbedtls_md_context_t *ctx, const uint8_t *key, const char *m=
dname)
+static void
+hmac_ctx_init_with_arbitrary_key_length(hmac_ctx_t *ctx, const uint8_t *ke=
y, size_t key_len, const md_info_t *md_info)
 {
-    const mbedtls_md_info_t *kt =3D md_get(mdname);
-    ASSERT(NULL !=3D kt && NULL !=3D ctx);
+    ctx->md_info =3D md_info;
+    psa_set_key_type(&ctx->key_attributes, PSA_KEY_TYPE_HMAC);
+    psa_set_key_algorithm(&ctx->key_attributes, PSA_ALG_HMAC(md_info->psa_=
alg));
+    psa_set_key_usage_flags(&ctx->key_attributes, PSA_KEY_USAGE_SIGN_MESSA=
GE);

-    mbedtls_md_init(ctx);
-    int key_len =3D mbedtls_md_get_size(kt);
-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 1));
-    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, key, key_len));
+    if (psa_import_key(&ctx->key_attributes, key, key_len, &ctx->key) !=3D=
 PSA_SUCCESS)
+    {
+        msg(M_FATAL, "psa_import_key failed");
+    }

-    /* make sure we used a big enough key */
-    ASSERT(mbedtls_md_get_size(kt) <=3D key_len);
+    ASSERT(psa_mac_sign_setup(&ctx->operation, ctx->key, PSA_ALG_HMAC(md_i=
nfo->psa_alg)) =3D=3D PSA_SUCCESS);
 }

 void
-hmac_ctx_cleanup(mbedtls_md_context_t *ctx)
+hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, const char *mdname)
 {
-    mbedtls_md_free(ctx);
+    const md_info_t *md_info =3D md_get(mdname);
+    ASSERT(ctx !=3D NULL && key !=3D NULL && md_info !=3D NULL);
+
+    hmac_ctx_init_with_arbitrary_key_length(ctx, key, PSA_HASH_LENGTH(md_i=
nfo->psa_alg), md_info);
+}
+
+void
+hmac_ctx_cleanup(hmac_ctx_t *ctx)
+{
+    ASSERT(psa_mac_abort(&ctx->operation) =3D=3D PSA_SUCCESS);
+    ASSERT(psa_destroy_key(ctx->key) =3D=3D PSA_SUCCESS);
 }

 int
-hmac_ctx_size(mbedtls_md_context_t *ctx)
+hmac_ctx_size(hmac_ctx_t *ctx)
 {
-    if (NULL =3D=3D ctx)
-    {
-        return 0;
-    }
-    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
+    return (int)PSA_HASH_LENGTH(ctx->md_info->psa_alg);
 }

 void
-hmac_ctx_reset(mbedtls_md_context_t *ctx)
+hmac_ctx_reset(hmac_ctx_t *ctx)
 {
-    ASSERT(0 =3D=3D mbedtls_md_hmac_reset(ctx));
+    ASSERT(psa_mac_abort(&ctx->operation) =3D=3D PSA_SUCCESS);
+    ASSERT(psa_mac_sign_setup(&ctx->operation, ctx->key, PSA_ALG_HMAC(ctx-=
>md_info->psa_alg)) =3D=3D PSA_SUCCESS);
 }

 void
-hmac_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
+hmac_ctx_update(hmac_ctx_t *ctx, const uint8_t *src, int src_len)
 {
-    ASSERT(0 =3D=3D mbedtls_md_hmac_update(ctx, src, src_len));
+    ASSERT(src_len >=3D 0);
+    ASSERT(psa_mac_update(&ctx->operation, src, (size_t)src_len) =3D=3D PS=
A_SUCCESS);
 }

 void
-hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
+hmac_ctx_final(hmac_ctx_t *ctx, uint8_t *dst)
 {
-    ASSERT(0 =3D=3D mbedtls_md_hmac_finish(ctx, dst));
+    /* We depend on the caller to ensure that dst has enough room for the =
hash,
+     * so we just tell PSA that it can hold the appropriate amount of byte=
s. */
+    size_t dst_size =3D PSA_HASH_LENGTH(ctx->md_info->psa_alg);
+    size_t hmac_length =3D 0;
+
+    ASSERT(psa_mac_sign_finish(&ctx->operation, dst, dst_size, &hmac_lengt=
h) =3D=3D PSA_SUCCESS);
+    ASSERT(hmac_length =3D=3D dst_size);
 }

-int
-memcmp_constant_time(const void *a, const void *b, size_t size)
-{
-    /* mbed TLS has a no const time memcmp function that it exposes
-     * via its APIs like OpenSSL does with CRYPTO_memcmp
-     * Adapt the function that mbedtls itself uses in
-     * mbedtls_safer_memcmp as it considers that to be safe */
-    volatile const unsigned char *A =3D (volatile const unsigned char *)a;
-    volatile const unsigned char *B =3D (volatile const unsigned char *)b;
-    volatile unsigned char diff =3D 0;
-
-    for (size_t i =3D 0; i < size; i++)
-    {
-        unsigned char x =3D A[i], y =3D B[i];
-        diff |=3D x ^ y;
-    }
-
-    return diff;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Generate the hash required by for the \c tls1_PRF function.
  *
@@ -1004,8 +832,8 @@
  * @param olen          Length of the output buffer
  */
 static void
-tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, size_t sec=
_len, const uint8_t *seed,
-            size_t seed_len, uint8_t *out, size_t olen)
+tls1_P_hash(const md_info_t *md_info, const uint8_t *sec, size_t sec_len, =
const uint8_t *seed,
+            int seed_len, uint8_t *out, size_t olen)
 {
     struct gc_arena gc =3D gc_new();
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
@@ -1023,18 +851,13 @@
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len=
, 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_=
len, 0, &gc));

-    unsigned int chunk =3D mbedtls_md_get_size(md_kt);
-    unsigned int A1_len =3D mbedtls_md_get_size(md_kt);
+    unsigned int chunk =3D (unsigned int)PSA_HASH_LENGTH(md_info->psa_alg);
+    unsigned int A1_len =3D (unsigned int)PSA_HASH_LENGTH(md_info->psa_alg=
);

     /* This is the only place where we init an HMAC with a key that is not
      * equal to its size, therefore we init the hmac ctx manually here */
-    mbedtls_md_init(ctx);
-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, md_kt, 1));
-    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, sec, sec_len));
-
-    mbedtls_md_init(ctx_tmp);
-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx_tmp, md_kt, 1));
-    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx_tmp, sec, sec_len));
+    hmac_ctx_init_with_arbitrary_key_length(ctx, sec, sec_len, md_info);
+    hmac_ctx_init_with_arbitrary_key_length(ctx_tmp, sec, sec_len, md_info=
);

     hmac_ctx_update(ctx, seed, seed_len);
     hmac_ctx_final(ctx, A1);
@@ -1045,7 +868,7 @@
         hmac_ctx_reset(ctx_tmp);
         hmac_ctx_update(ctx, A1, A1_len);
         hmac_ctx_update(ctx_tmp, A1, A1_len);
-        hmac_ctx_update(ctx, seed, seed_len);
+        hmac_ctx_update(ctx, seed, (int)seed_len);

         if (olen > chunk)
         {
@@ -1094,9 +917,15 @@
 ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, s=
ize_t slen, uint8_t *out1,
              size_t olen)
 {
+    const md_info_t *md5 =3D md_get("MD5");
+    const md_info_t *sha1 =3D md_get("SHA1");
+
+    if (label_len > (size_t)INT_MAX)
+    {
+        return false;
+    }
+
     struct gc_arena gc =3D gc_new();
-    const md_kt_t *md5 =3D md_get("MD5");
-    const md_kt_t *sha1 =3D md_get("SHA1");

     uint8_t *out2 =3D (uint8_t *)gc_malloc(olen, false, &gc);

@@ -1105,8 +934,8 @@
     const uint8_t *S2 =3D &(sec[len]);
     len +=3D (slen & 1); /* add for odd, make longer */

-    tls1_P_hash(md5, S1, len, label, label_len, out1, olen);
-    tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);
+    tls1_P_hash(md5, S1, len, label, (int)label_len, out1, olen);
+    tls1_P_hash(sha1, S2, len, label, (int)label_len, out2, olen);

     for (size_t i =3D 0; i < olen; i++)
     {
@@ -1121,8 +950,204 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
+void
+crypto_init_lib(void)
+{
+}
+
+void
+crypto_uninit_lib(void)
+{
+}
+
+void
+crypto_clear_error(void)
+{
+}
+
+bool
+mbed_log_err(unsigned int flags, int errval, const char *prefix)
+{
+    if (0 !=3D errval)
+    {
+        char errstr[256];
+        mbedtls_strerror(errval, errstr, sizeof(errstr));
+
+        if (NULL =3D=3D prefix)
+        {
+            prefix =3D "mbed TLS error";
+        }
+        msg(flags, "%s: %s", prefix, errstr);
+    }
+
+    return 0 =3D=3D errval;
+}
+
+bool
+mbed_log_func_line(unsigned int flags, int errval, const char *func, int l=
ine)
+{
+    char prefix[256];
+
+    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >=3D sizeof(=
prefix))
+    {
+        return mbed_log_err(flags, errval, func);
+    }
+
+    return mbed_log_err(flags, errval, prefix);
+}
+
+int
+memcmp_constant_time(const void *a, const void *b, size_t size)
+{
+    return mbedtls_ct_memcmp(a, b, size);
+}
+
+void
+show_available_ciphers(void)
+{
+    /* Mbed TLS 4 does not currently have a mechanism to discover available
+     * ciphers. We instead print out the ciphers from cipher_info_table. */
+
+#ifndef ENABLE_SMALL
+    printf("The following ciphers and cipher modes are available for use\n"
+           "with " PACKAGE_NAME ".  Each cipher shown below may be used as=
 a\n"
+           "parameter to the --data-ciphers (or --cipher) option.  Using a=
\n"
+           "GCM or CBC mode is recommended.  In static key mode only CBC\n"
+           "mode is allowed.\n\n");
 #endif

-#endif /* ENABLE_CRYPTO_MBEDTLS */
+    for (size_t i =3D 0; i < cipher_info_table_entries; i++)
+    {
+        const cipher_info_t *info =3D &cipher_info_table[i];
+        const char *name =3D info->name;
+        if (!cipher_kt_insecure(name) && (cipher_kt_mode_aead(name) || cip=
her_kt_mode_cbc(name)))
+        {
+            print_cipher(name);
+        }
+    }
+
+    printf("\nThe following ciphers have a block size of less than 128 bit=
s, \n"
+           "and are therefore deprecated.  Do not use unless you have to.\=
n\n");
+    for (size_t i =3D 0; i < cipher_info_table_entries; i++)
+    {
+        const cipher_info_t *info =3D &cipher_info_table[i];
+        const char *name =3D info->name;
+        if (cipher_kt_insecure(name) && (cipher_kt_mode_aead(name) || ciph=
er_kt_mode_cbc(name)))
+        {
+            print_cipher(name);
+        }
+    }
+    printf("\n");
+}
+
+void
+show_available_digests(void)
+{
+    /* Mbed TLS 4 does not currently have a mechanism to discover available
+     * message digests. We instead print out the digests from md_info_tabl=
e. */
+
+#ifndef ENABLE_SMALL
+    printf("The following message digests are available for use with\n" PA=
CKAGE_NAME
+           ".  A message digest is used in conjunction with\n"
+           "the HMAC function, to authenticate received packets.\n"
+           "You can specify a message digest as parameter to\n"
+           "the --auth option.\n\n");
+#endif
+
+    for (size_t i =3D 0; i < md_info_table_entries; i++)
+    {
+        const md_info_t *info =3D &md_info_table[i];
+        printf("%s %d bit default key\n", info->name,
+               (unsigned char)PSA_HASH_LENGTH(info->psa_alg) * 8);
+    }
+    printf("\n");
+}
+
+void
+show_available_engines(void)
+{
+    printf("Sorry, mbed TLS hardware crypto engine functionality is not "
+           "available\n");
+}
+
+bool
+crypto_pem_encode(const char *name, struct buffer *dst, const struct buffe=
r *src,
+                  struct gc_arena *gc)
+{
+    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
+    char header[1000 + 1] =3D { 0 };
+    char footer[1000 + 1] =3D { 0 };
+
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >=
=3D sizeof(header))
+    {
+        return false;
+    }
+    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >=3D =
sizeof(footer))
+    {
+        return false;
+    }
+
+    size_t out_len =3D 0;
+    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
+        !=3D mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src)=
, NULL, 0, &out_len))
+    {
+        return false;
+    }
+
+    /* We set the size buf to out_len-1 to NOT include the 0 byte that
+     * mbedtls_pem_write_buffer in its length calculation */
+    *dst =3D alloc_buf_gc(out_len, gc);
+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(=
src), BPTR(dst),
+                                          BCAP(dst), &out_len))
+        || !(out_len < INT_MAX && out_len > 1)
+        || !buf_inc_len(dst, (int)out_len - 1))
+    {
+        CLEAR(*dst);
+        return false;
+    }
+
+    return true;
+}
+
+bool
+crypto_pem_decode(const char *name, struct buffer *dst, const struct buffe=
r *src)
+{
+    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
+    char header[1000 + 1] =3D { 0 };
+    char footer[1000 + 1] =3D { 0 };
+
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >=3D =
sizeof(header))
+    {
+        return false;
+    }
+    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >=3D si=
zeof(footer))
+    {
+        return false;
+    }
+
+    /* mbed TLS requires the src to be null-terminated */
+    /* allocate a new buffer to avoid modifying the src buffer */
+    struct gc_arena gc =3D gc_new();
+    struct buffer input =3D alloc_buf_gc(BLEN(src) + 1, &gc);
+    buf_copy(&input, src);
+    buf_null_terminate(&input);
+
+    size_t use_len =3D 0;
+    mbedtls_pem_context ctx =3D { 0 };
+    bool ret =3D
+        mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(&input)=
, NULL, 0, &use_len));
+    size_t buf_size =3D 0;
+    const unsigned char *buf =3D mbedtls_pem_get_buffer(&ctx, &buf_size);
+    if (ret && !buf_write(dst, buf, buf_size))
+    {
+        ret =3D false;
+        msg(M_WARN, "PEM decode error: destination buffer too small");
+    }
+
+    mbedtls_pem_free(&ctx);
+    gc_free(&gc);
+    return ret;
+}
+
+#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
+#endif /* defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index af71037..dd491f3 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -1,3 +1,4 @@
+
 /*
  *  OpenVPN -- An application to securely tunnel IP networks
  *             over a single TCP/UDP port, with support for SSL/TLS-based
@@ -5,8 +6,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2025 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -23,85 +24,98 @@

 /**
  * @file
- * Data Channel Cryptography mbed TLS-specific backend interface
+ * Data Channel Cryptography backend interface using the TF-PSA-Crypto lib=
rary
+ * part of Mbed TLS 4.
  */

-#ifndef CRYPTO_MBEDTLS_H_
-#define CRYPTO_MBEDTLS_H_
+#ifndef CRYPTO_MBEDTLS4_H_
+#define CRYPTO_MBEDTLS4_H_

-#include <stdbool.h>
-#include <mbedtls/cipher.h>
-#include <mbedtls/md.h>
-#include <mbedtls/ctr_drbg.h>
+#include <psa/crypto.h>

-/** Generic message digest key type %context. */
-typedef mbedtls_md_info_t md_kt_t;
-
-/** Generic cipher %context. */
-typedef mbedtls_cipher_context_t cipher_ctx_t;
-
-/** Generic message digest %context. */
-typedef mbedtls_md_context_t md_ctx_t;
-
-/** Generic HMAC %context. */
-typedef mbedtls_md_context_t hmac_ctx_t;
-
-/* Use a dummy type for the provider */
-typedef void provider_t;
+#include "integer.h"

 /** Maximum length of an IV */
-#define OPENVPN_MAX_IV_LENGTH MBEDTLS_MAX_IV_LENGTH
+#define OPENVPN_MAX_IV_LENGTH 16

 /** Cipher is in CBC mode */
-#define OPENVPN_MODE_CBC MBEDTLS_MODE_CBC
+#define OPENVPN_MODE_CBC PSA_ALG_CBC_PKCS7

 /** Cipher is in OFB mode */
-#define OPENVPN_MODE_OFB MBEDTLS_MODE_OFB
+#define OPENVPN_MODE_OFB PSA_ALG_OFB

 /** Cipher is in CFB mode */
-#define OPENVPN_MODE_CFB MBEDTLS_MODE_CFB
+#define OPENVPN_MODE_CFB PSA_ALG_CFB

 /** Cipher is in GCM mode */
-#define OPENVPN_MODE_GCM MBEDTLS_MODE_GCM
+#define OPENVPN_MODE_GCM PSA_ALG_GCM

-typedef mbedtls_operation_t crypto_operation_t;
+typedef int crypto_operation_t;

 /** Cipher should encrypt */
-#define OPENVPN_OP_ENCRYPT MBEDTLS_ENCRYPT
+#define OPENVPN_OP_ENCRYPT 0

 /** Cipher should decrypt */
-#define OPENVPN_OP_DECRYPT MBEDTLS_DECRYPT
+#define OPENVPN_OP_DECRYPT 1

 #define MD4_DIGEST_LENGTH    16
 #define MD5_DIGEST_LENGTH    16
 #define SHA_DIGEST_LENGTH    20
 #define SHA256_DIGEST_LENGTH 32

-/**
- * Returns a singleton instance of the mbed TLS random number generator.
- *
- * For PolarSSL/mbed TLS 1.1+, this is the CTR_DRBG random number generato=
r. If it
- * hasn't been initialised yet, the RNG will be initialised using the defa=
ult
- * entropy sources. Aside from the default platform entropy sources, an
- * additional entropy source, the HAVEGE random number generator will also=
 be
- * added. During initialisation, a personalisation string will be added ba=
sed
- * on the time, the PID, and a pointer to the random context.
- */
-mbedtls_ctr_drbg_context *rand_ctx_get(void);
+typedef void provider_t;

-#ifdef ENABLE_PREDICTION_RESISTANCE
-/**
- * Enable prediction resistance on the random number generator.
- */
-void rand_ctx_enable_prediction_resistance(void);
+typedef struct cipher_info
+{
+    const char *name;
+    psa_key_type_t psa_key_type;
+    psa_algorithm_t psa_alg;
+    int key_bytes;
+    int iv_bytes;
+    int block_size;
+} cipher_info_t;

-#endif
+typedef union psa_cipher_or_aead_operation
+{
+    psa_cipher_operation_t cipher;
+    psa_aead_operation_t aead;
+} cipher_operation_t;
+
+typedef struct cipher_ctx
+{
+    mbedtls_svc_key_id_t key;
+    psa_key_attributes_t key_attributes;
+    const cipher_info_t *cipher_info;
+    bool aead_finished;
+    cipher_operation_t operation;
+    uint8_t tag[16];
+} cipher_ctx_t;
+
+typedef struct md_info
+{
+    const char *name;
+    psa_algorithm_t psa_alg;
+} md_info_t;
+
+typedef struct md_ctx
+{
+    const md_info_t *md_info;
+    psa_hash_operation_t operation;
+} md_ctx_t;
+
+typedef struct hmac_ctx
+{
+    mbedtls_svc_key_id_t key;
+    psa_key_attributes_t key_attributes;
+    const md_info_t *md_info;
+    psa_mac_operation_t operation;
+} hmac_ctx_t;

 /**
  * Log the supplied mbed TLS error, prefixed by supplied prefix.
  *
  * @param flags         Flags to indicate error type and priority.
- * @param errval        mbed TLS error code to convert to error message.
+ * @param errval        mbed TLS error code.
  * @param prefix        Prefix to mbed TLS error message.
  *
  * @returns true if no errors are detected, false otherwise.
@@ -112,7 +126,7 @@
  * Log the supplied mbed TLS error, prefixed by function name and line num=
ber.
  *
  * @param flags         Flags to indicate error type and priority.
- * @param errval        mbed TLS error code to convert to error message.
+ * @param errval        mbed TLS error code.
  * @param func          Function name where error was reported.
  * @param line          Line number where error was reported.
  *
@@ -142,7 +156,8 @@
  * @param errval        mbed TLS error code to convert to error message.
  *
  * @returns true if no errors are detected, false otherwise.
+ * TODO: The log function has been removed, do something about it?
  */
 #define mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __=
func__, __LINE__)

-#endif /* CRYPTO_MBEDTLS_H_ */
+#endif /* CRYPTO_MBEDTLS4_H_ */
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedt=
ls_legacy.c
new file mode 100644
index 0000000..a991349
--- /dev/null
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -0,0 +1,1133 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
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
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+/**
+ * @file
+ * Data Channel Cryptography mbed TLS-specific backend interface,
+ * for mbed TLS 3.X versions.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#if defined(ENABLE_CRYPTO_MBEDTLS)
+#include <mbedtls/version.h>
+
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
+
+#include "errlevel.h"
+#include "basic.h"
+#include "buffer.h"
+#include "crypto.h"
+#include "integer.h"
+#include "crypto_backend.h"
+#include "otime.h"
+#include "misc.h"
+
+#include <mbedtls/base64.h>
+#include <mbedtls/des.h>
+#include <mbedtls/error.h>
+#include <mbedtls/md5.h>
+#include <mbedtls/cipher.h>
+#include <mbedtls/pem.h>
+
+#include <mbedtls/entropy.h>
+#include <mbedtls/ssl.h>
+
+
+/*
+ *
+ * Hardware engine support. Allows loading/unloading of engines.
+ *
+ */
+
+void
+crypto_init_lib_engine(const char *engine_name)
+{
+    msg(M_WARN, "Note: mbed TLS hardware crypto engine functionality is no=
t "
+                "available");
+}
+
+provider_t *
+crypto_load_provider(const char *provider)
+{
+    if (provider)
+    {
+        msg(M_WARN, "Note: mbed TLS provider functionality is not availabl=
e");
+    }
+    return NULL;
+}
+
+void
+crypto_unload_provider(const char *provname, provider_t *provider)
+{
+}
+
+/*
+ *
+ * Functions related to the core crypto library
+ *
+ */
+
+void
+crypto_init_lib(void)
+{
+}
+
+void
+crypto_uninit_lib(void)
+{
+}
+
+void
+crypto_clear_error(void)
+{
+}
+
+bool
+mbed_log_err(unsigned int flags, int errval, const char *prefix)
+{
+    if (0 !=3D errval)
+    {
+        char errstr[256];
+        mbedtls_strerror(errval, errstr, sizeof(errstr));
+
+        if (NULL =3D=3D prefix)
+        {
+            prefix =3D "mbed TLS error";
+        }
+        msg(flags, "%s: %s", prefix, errstr);
+    }
+
+    return 0 =3D=3D errval;
+}
+
+bool
+mbed_log_func_line(unsigned int flags, int errval, const char *func, int l=
ine)
+{
+    char prefix[256];
+
+    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >=3D sizeof(=
prefix))
+    {
+        return mbed_log_err(flags, errval, func);
+    }
+
+    return mbed_log_err(flags, errval, prefix);
+}
+
+
+#ifdef DMALLOC
+void
+crypto_init_dmalloc(void)
+{
+    msg(M_ERR, "Error: dmalloc support is not available for mbed TLS.");
+}
+#endif /* DMALLOC */
+
+const cipher_name_pair cipher_name_translation_table[] =3D {
+    { "BF-CBC", "BLOWFISH-CBC" },
+    { "BF-CFB", "BLOWFISH-CFB64" },
+    { "CAMELLIA-128-CFB", "CAMELLIA-128-CFB128" },
+    { "CAMELLIA-192-CFB", "CAMELLIA-192-CFB128" },
+    { "CAMELLIA-256-CFB", "CAMELLIA-256-CFB128" }
+};
+const size_t cipher_name_translation_table_count =3D
+    sizeof(cipher_name_translation_table) / sizeof(*cipher_name_translatio=
n_table);
+
+void
+show_available_ciphers(void)
+{
+    const int *ciphers =3D mbedtls_cipher_list();
+
+#ifndef ENABLE_SMALL
+    printf("The following ciphers and cipher modes are available for use\n"
+           "with " PACKAGE_NAME ".  Each cipher shown below may be used as=
 a\n"
+           "parameter to the --data-ciphers (or --cipher) option.  Using a=
\n"
+           "GCM or CBC mode is recommended.  In static key mode only CBC\n"
+           "mode is allowed.\n\n");
+#endif
+
+    while (*ciphers !=3D 0)
+    {
+        const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_typ=
e(*ciphers);
+        const char *name =3D mbedtls_cipher_info_get_name(info);
+        if (info && name && !cipher_kt_insecure(name)
+            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
+        {
+            print_cipher(name);
+        }
+        ciphers++;
+    }
+
+    printf("\nThe following ciphers have a block size of less than 128 bit=
s, \n"
+           "and are therefore deprecated.  Do not use unless you have to.\=
n\n");
+    ciphers =3D mbedtls_cipher_list();
+    while (*ciphers !=3D 0)
+    {
+        const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_typ=
e(*ciphers);
+        const char *name =3D mbedtls_cipher_info_get_name(info);
+        if (info && name && cipher_kt_insecure(name)
+            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
+        {
+            print_cipher(name);
+        }
+        ciphers++;
+    }
+    printf("\n");
+}
+
+void
+show_available_digests(void)
+{
+    const int *digests =3D mbedtls_md_list();
+
+#ifndef ENABLE_SMALL
+    printf("The following message digests are available for use with\n" PA=
CKAGE_NAME
+           ".  A message digest is used in conjunction with\n"
+           "the HMAC function, to authenticate received packets.\n"
+           "You can specify a message digest as parameter to\n"
+           "the --auth option.\n\n");
+#endif
+
+    while (*digests !=3D 0)
+    {
+        const mbedtls_md_info_t *info =3D mbedtls_md_info_from_type(*diges=
ts);
+
+        if (info)
+        {
+            printf("%s %d bit default key\n", mbedtls_md_get_name(info),
+                   mbedtls_md_get_size(info) * 8);
+        }
+        digests++;
+    }
+    printf("\n");
+}
+
+void
+show_available_engines(void)
+{
+    printf("Sorry, mbed TLS hardware crypto engine functionality is not "
+           "available\n");
+}
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
+bool
+crypto_pem_encode(const char *name, struct buffer *dst, const struct buffe=
r *src,
+                  struct gc_arena *gc)
+{
+    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
+    char header[1000 + 1] =3D { 0 };
+    char footer[1000 + 1] =3D { 0 };
+
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >=
=3D sizeof(header))
+    {
+        return false;
+    }
+    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >=3D =
sizeof(footer))
+    {
+        return false;
+    }
+
+    size_t out_len =3D 0;
+    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
+        !=3D mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src)=
, NULL, 0, &out_len))
+    {
+        return false;
+    }
+
+    /* We set the size buf to out_len-1 to NOT include the 0 byte that
+     * mbedtls_pem_write_buffer in its length calculation */
+    *dst =3D alloc_buf_gc(out_len, gc);
+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(=
src), BPTR(dst),
+                                          BCAP(dst), &out_len))
+        || !buf_inc_len(dst, out_len - 1))
+    {
+        CLEAR(*dst);
+        return false;
+    }
+
+    return true;
+}
+
+bool
+crypto_pem_decode(const char *name, struct buffer *dst, const struct buffe=
r *src)
+{
+    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
+    char header[1000 + 1] =3D { 0 };
+    char footer[1000 + 1] =3D { 0 };
+
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >=3D =
sizeof(header))
+    {
+        return false;
+    }
+    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >=3D si=
zeof(footer))
+    {
+        return false;
+    }
+
+    /* mbed TLS requires the src to be null-terminated */
+    /* allocate a new buffer to avoid modifying the src buffer */
+    struct gc_arena gc =3D gc_new();
+    struct buffer input =3D alloc_buf_gc(BLEN(src) + 1, &gc);
+    buf_copy(&input, src);
+    buf_null_terminate(&input);
+
+    size_t use_len =3D 0;
+    mbedtls_pem_context ctx =3D { 0 };
+    bool ret =3D
+        mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(&input)=
, NULL, 0, &use_len));
+    size_t buf_size =3D 0;
+    const unsigned char *buf =3D mbedtls_pem_get_buffer(&ctx, &buf_size);
+    if (ret && !buf_write(dst, buf, buf_size))
+    {
+        ret =3D false;
+        msg(M_WARN, "PEM decode error: destination buffer too small");
+    }
+
+    mbedtls_pem_free(&ctx);
+    gc_free(&gc);
+    return ret;
+}
+
+/*
+ *
+ * Random number functions, used in cases where we want
+ * reasonably strong cryptographic random number generation
+ * without depleting our entropy pool.  Used for random
+ * IV values and a number of other miscellaneous tasks.
+ *
+ */
+
+/*
+ * Initialise the given ctr_drbg context, using a personalisation string a=
nd an
+ * entropy gathering function.
+ */
+mbedtls_ctr_drbg_context *
+rand_ctx_get(void)
+{
+    static mbedtls_entropy_context ec =3D { 0 };
+    static mbedtls_ctr_drbg_context cd_ctx =3D { 0 };
+    static bool rand_initialised =3D false;
+
+    if (!rand_initialised)
+    {
+        struct gc_arena gc =3D gc_new();
+        struct buffer pers_string =3D alloc_buf_gc(100, &gc);
+
+        /*
+         * Personalisation string, should be as unique as possible (see NI=
ST
+         * 800-90 section 8.7.1). We have very little information at this =
stage.
+         * Include Program Name, memory address of the context and PID.
+         */
+        buf_printf(&pers_string, "OpenVPN %0u %p %s", platform_getpid(), &=
cd_ctx,
+                   time_string(0, 0, 0, &gc));
+
+        /* Initialise mbed TLS RNG, and built-in entropy sources */
+        mbedtls_entropy_init(&ec);
+
+        mbedtls_ctr_drbg_init(&cd_ctx);
+        if (!mbed_ok(mbedtls_ctr_drbg_seed(&cd_ctx, mbedtls_entropy_func, =
&ec, BPTR(&pers_string),
+                                           BLEN(&pers_string))))
+        {
+            msg(M_FATAL, "Failed to initialize random generator");
+        }
+
+        gc_free(&gc);
+        rand_initialised =3D true;
+    }
+
+    return &cd_ctx;
+}
+
+#ifdef ENABLE_PREDICTION_RESISTANCE
+void
+rand_ctx_enable_prediction_resistance(void)
+{
+    mbedtls_ctr_drbg_context *cd_ctx =3D rand_ctx_get();
+
+    mbedtls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);
+}
+#endif /* ENABLE_PREDICTION_RESISTANCE */
+
+int
+rand_bytes(uint8_t *output, int len)
+{
+    mbedtls_ctr_drbg_context *rng_ctx =3D rand_ctx_get();
+
+    while (len > 0)
+    {
+        const size_t blen =3D min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
+        if (0 !=3D mbedtls_ctr_drbg_random(rng_ctx, output, blen))
+        {
+            return 0;
+        }
+
+        output +=3D blen;
+        len -=3D blen;
+    }
+
+    return 1;
+}
+
+/*
+ *
+ * Generic cipher key type functions
+ *
+ */
+static const mbedtls_cipher_info_t *
+cipher_get(const char *ciphername)
+{
+    ASSERT(ciphername);
+
+    const mbedtls_cipher_info_t *cipher =3D NULL;
+
+    ciphername =3D translate_cipher_name_from_openvpn(ciphername);
+    cipher =3D mbedtls_cipher_info_from_string(ciphername);
+    return cipher;
+}
+
+bool
+cipher_valid_reason(const char *ciphername, const char **reason)
+{
+    ASSERT(reason);
+
+    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);
+
+    if (NULL =3D=3D cipher)
+    {
+        msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
+        *reason =3D "disabled because unknown";
+        return false;
+    }
+
+    const size_t key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(cipher=
) / 8;
+    if (key_bytelen > MAX_CIPHER_KEY_LENGTH)
+    {
+        msg(D_LOW,
+            "Cipher algorithm '%s' uses a default key size (%zu bytes) "
+            "which is larger than " PACKAGE_NAME "'s current maximum key s=
ize "
+            "(%d bytes)",
+            ciphername, key_bytelen, MAX_CIPHER_KEY_LENGTH);
+        *reason =3D "disabled due to key size too large";
+        return false;
+    }
+
+    *reason =3D NULL;
+    return true;
+}
+
+const char *
+cipher_kt_name(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
+    if (NULL =3D=3D cipher_kt)
+    {
+        return "[null-cipher]";
+    }
+
+    return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(c=
ipher_kt));
+}
+
+int
+cipher_kt_key_size(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
+
+    if (NULL =3D=3D cipher_kt)
+    {
+        return 0;
+    }
+
+    return (int)mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;
+}
+
+int
+cipher_kt_iv_size(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
+
+    if (NULL =3D=3D cipher_kt)
+    {
+        return 0;
+    }
+    return (int)mbedtls_cipher_info_get_iv_size(cipher_kt);
+}
+
+int
+cipher_kt_block_size(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
+    if (NULL =3D=3D cipher_kt)
+    {
+        return 0;
+    }
+    return (int)mbedtls_cipher_info_get_block_size(cipher_kt);
+}
+
+int
+cipher_kt_tag_size(const char *ciphername)
+{
+    if (cipher_kt_mode_aead(ciphername))
+    {
+        return OPENVPN_AEAD_TAG_LENGTH;
+    }
+    return 0;
+}
+
+bool
+cipher_kt_insecure(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
+    if (!cipher_kt)
+    {
+        return true;
+    }
+
+    return !(cipher_kt_block_size(ciphername) >=3D 128 / 8
+#ifdef MBEDTLS_CHACHAPOLY_C
+             || mbedtls_cipher_info_get_type(cipher_kt) =3D=3D MBEDTLS_CIP=
HER_CHACHA20_POLY1305
+#endif
+    );
+}
+
+static mbedtls_cipher_mode_t
+cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
+{
+    ASSERT(NULL !=3D cipher_kt);
+    return mbedtls_cipher_info_get_mode(cipher_kt);
+}
+
+bool
+cipher_kt_mode_cbc(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);
+    return cipher && cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_CBC;
+}
+
+bool
+cipher_kt_mode_ofb_cfb(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);
+    return cipher
+           && (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_OFB
+               || cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_CFB);
+}
+
+bool
+cipher_kt_mode_aead(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);
+    return cipher
+           && (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_GCM
+#ifdef MBEDTLS_CHACHAPOLY_C
+               || cipher_kt_mode(cipher) =3D=3D MBEDTLS_MODE_CHACHAPOLY
+#endif
+           );
+}
+
+
+/*
+ *
+ * Generic cipher context functions
+ *
+ */
+
+mbedtls_cipher_context_t *
+cipher_ctx_new(void)
+{
+    mbedtls_cipher_context_t *ctx;
+    ALLOC_OBJ(ctx, mbedtls_cipher_context_t);
+    return ctx;
+}
+
+void
+cipher_ctx_free(mbedtls_cipher_context_t *ctx)
+{
+    mbedtls_cipher_free(ctx);
+    free(ctx);
+}
+
+void
+cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, const c=
har *ciphername,
+                crypto_operation_t enc)
+{
+    ASSERT(NULL !=3D ciphername && NULL !=3D ctx);
+    CLEAR(*ctx);
+
+    const mbedtls_cipher_info_t *kt =3D cipher_get(ciphername);
+    ASSERT(kt);
+    size_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(kt);
+
+    if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
+    {
+        msg(M_FATAL, "mbed TLS cipher context init #1");
+    }
+
+    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, enc)))
+    {
+        msg(M_FATAL, "mbed TLS cipher set key");
+    }
+
+    if (mbedtls_cipher_info_get_mode(kt) =3D=3D MBEDTLS_MODE_CBC)
+    {
+        if (!mbed_ok(mbedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_=
PKCS7)))
+        {
+            msg(M_FATAL, "mbed TLS cipher set padding mode");
+        }
+    }
+
+    /* make sure we used a big enough key */
+    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) <=3D key_bitlen);
+}
+
+int
+cipher_ctx_iv_length(const mbedtls_cipher_context_t *ctx)
+{
+    return mbedtls_cipher_get_iv_size(ctx);
+}
+
+int
+cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_len)
+{
+    if (tag_len > SIZE_MAX)
+    {
+        return 0;
+    }
+
+    if (!mbed_ok(mbedtls_cipher_write_tag(ctx, (unsigned char *)tag, tag_l=
en)))
+    {
+        return 0;
+    }
+
+    return 1;
+}
+
+int
+cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)
+{
+    return (int)mbedtls_cipher_get_block_size(ctx);
+}
+
+int
+cipher_ctx_mode(const mbedtls_cipher_context_t *ctx)
+{
+    ASSERT(NULL !=3D ctx);
+
+    return mbedtls_cipher_get_cipher_mode(ctx);
+}
+
+bool
+cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
+{
+    return ctx && cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CBC;
+}
+
+
+bool
+cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
+{
+    return ctx
+           && (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_OFB
+               || cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CFB);
+}
+
+bool
+cipher_ctx_mode_aead(const cipher_ctx_t *ctx)
+{
+    return ctx
+           && (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_GCM
+#ifdef MBEDTLS_CHACHAPOLY_C
+               || cipher_ctx_mode(ctx) =3D=3D MBEDTLS_MODE_CHACHAPOLY
+#endif
+           );
+}
+
+int
+cipher_ctx_reset(mbedtls_cipher_context_t *ctx, const uint8_t *iv_buf)
+{
+    if (!mbed_ok(mbedtls_cipher_reset(ctx)))
+    {
+        return 0;
+    }
+
+    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher=
_get_iv_size(ctx))))
+    {
+        return 0;
+    }
+
+    return 1;
+}
+
+int
+cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)
+{
+    if (src_len > SIZE_MAX)
+    {
+        return 0;
+    }
+
+    if (!mbed_ok(mbedtls_cipher_update_ad(ctx, src, src_len)))
+    {
+        return 0;
+    }
+
+    return 1;
+}
+
+int
+cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_le=
n, uint8_t *src,
+                  int src_len)
+{
+    size_t s_dst_len =3D *dst_len;
+
+    if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t)src_len, dst, &s_=
dst_len)))
+    {
+        return 0;
+    }
+
+    *dst_len =3D s_dst_len;
+
+    return 1;
+}
+
+int
+cipher_ctx_final(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len)
+{
+    size_t s_dst_len =3D *dst_len;
+
+    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &s_dst_len)))
+    {
+        return 0;
+    }
+
+    *dst_len =3D s_dst_len;
+
+    return 1;
+}
+
+int
+cipher_ctx_final_check_tag(mbedtls_cipher_context_t *ctx, uint8_t *dst, in=
t *dst_len, uint8_t *tag,
+                           size_t tag_len)
+{
+    size_t olen =3D 0;
+
+    if (MBEDTLS_DECRYPT !=3D mbedtls_cipher_get_operation(ctx))
+    {
+        return 0;
+    }
+
+    if (tag_len > SIZE_MAX)
+    {
+        return 0;
+    }
+
+    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &olen)))
+    {
+        msg(D_CRYPT_ERRORS, "%s: cipher_ctx_final() failed", __func__);
+        return 0;
+    }
+
+    if (olen > INT_MAX)
+    {
+        return 0;
+    }
+    *dst_len =3D olen;
+
+    if (!mbed_ok(mbedtls_cipher_check_tag(ctx, (const unsigned char *)tag,=
 tag_len)))
+    {
+        return 0;
+    }
+
+    return 1;
+}
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
+/*
+ *
+ * Generic message digest information functions
+ *
+ */
+
+
+static const mbedtls_md_info_t *
+md_get(const char *digest)
+{
+    const mbedtls_md_info_t *md =3D NULL;
+    ASSERT(digest);
+
+    md =3D mbedtls_md_info_from_string(digest);
+    if (!md)
+    {
+        msg(M_FATAL, "Message hash algorithm '%s' not found", digest);
+    }
+    if (mbedtls_md_get_size(md) > MAX_HMAC_KEY_LENGTH)
+    {
+        msg(M_FATAL,
+            "Message hash algorithm '%s' uses a default hash size (%d byte=
s) which is larger than " PACKAGE_NAME
+            "'s current maximum hash size (%d bytes)",
+            digest, mbedtls_md_get_size(md), MAX_HMAC_KEY_LENGTH);
+    }
+    return md;
+}
+
+bool
+md_valid(const char *digest)
+{
+    const mbedtls_md_info_t *md =3D mbedtls_md_info_from_string(digest);
+    return md !=3D NULL;
+}
+
+const char *
+md_kt_name(const char *mdname)
+{
+    if (!strcmp("none", mdname))
+    {
+        return "[null-digest]";
+    }
+    const mbedtls_md_info_t *kt =3D md_get(mdname);
+    return mbedtls_md_get_name(kt);
+}
+
+unsigned char
+md_kt_size(const char *mdname)
+{
+    if (!strcmp("none", mdname))
+    {
+        return 0;
+    }
+    const mbedtls_md_info_t *kt =3D md_get(mdname);
+    return mbedtls_md_get_size(kt);
+}
+
+/*
+ *
+ * Generic message digest functions
+ *
+ */
+
+int
+md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst)
+{
+    const mbedtls_md_info_t *kt =3D md_get(mdname);
+    return 0 =3D=3D mbedtls_md(kt, src, src_len, dst);
+}
+
+mbedtls_md_context_t *
+md_ctx_new(void)
+{
+    mbedtls_md_context_t *ctx;
+    ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);
+    return ctx;
+}
+
+void
+md_ctx_free(mbedtls_md_context_t *ctx)
+{
+    free(ctx);
+}
+
+void
+md_ctx_init(mbedtls_md_context_t *ctx, const char *mdname)
+{
+    const mbedtls_md_info_t *kt =3D md_get(mdname);
+    ASSERT(NULL !=3D ctx && NULL !=3D kt);
+
+    mbedtls_md_init(ctx);
+    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 0));
+    ASSERT(0 =3D=3D mbedtls_md_starts(ctx));
+}
+
+void
+md_ctx_cleanup(mbedtls_md_context_t *ctx)
+{
+    mbedtls_md_free(ctx);
+}
+
+int
+md_ctx_size(const mbedtls_md_context_t *ctx)
+{
+    if (NULL =3D=3D ctx)
+    {
+        return 0;
+    }
+    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
+}
+
+void
+md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_le=
n)
+{
+    ASSERT(0 =3D=3D mbedtls_md_update(ctx, src, src_len));
+}
+
+void
+md_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
+{
+    ASSERT(0 =3D=3D mbedtls_md_finish(ctx, dst));
+    mbedtls_md_free(ctx);
+}
+
+
+/*
+ *
+ * Generic HMAC functions
+ *
+ */
+
+
+/*
+ * TODO: re-enable dmsg for crypto debug
+ */
+
+mbedtls_md_context_t *
+hmac_ctx_new(void)
+{
+    mbedtls_md_context_t *ctx;
+    ALLOC_OBJ(ctx, mbedtls_md_context_t);
+    return ctx;
+}
+
+void
+hmac_ctx_free(mbedtls_md_context_t *ctx)
+{
+    free(ctx);
+}
+
+void
+hmac_ctx_init(mbedtls_md_context_t *ctx, const uint8_t *key, const char *m=
dname)
+{
+    const mbedtls_md_info_t *kt =3D md_get(mdname);
+    ASSERT(NULL !=3D kt && NULL !=3D ctx);
+
+    mbedtls_md_init(ctx);
+    int key_len =3D mbedtls_md_get_size(kt);
+    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 1));
+    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, key, key_len));
+
+    /* make sure we used a big enough key */
+    ASSERT(mbedtls_md_get_size(kt) <=3D key_len);
+}
+
+void
+hmac_ctx_cleanup(mbedtls_md_context_t *ctx)
+{
+    mbedtls_md_free(ctx);
+}
+
+int
+hmac_ctx_size(mbedtls_md_context_t *ctx)
+{
+    if (NULL =3D=3D ctx)
+    {
+        return 0;
+    }
+    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
+}
+
+void
+hmac_ctx_reset(mbedtls_md_context_t *ctx)
+{
+    ASSERT(0 =3D=3D mbedtls_md_hmac_reset(ctx));
+}
+
+void
+hmac_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
+{
+    ASSERT(0 =3D=3D mbedtls_md_hmac_update(ctx, src, src_len));
+}
+
+void
+hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
+{
+    ASSERT(0 =3D=3D mbedtls_md_hmac_finish(ctx, dst));
+}
+
+int
+memcmp_constant_time(const void *a, const void *b, size_t size)
+{
+    /* mbed TLS has a no const time memcmp function that it exposes
+     * via its APIs like OpenSSL does with CRYPTO_memcmp
+     * Adapt the function that mbedtls itself uses in
+     * mbedtls_safer_memcmp as it considers that to be safe */
+    volatile const unsigned char *A =3D (volatile const unsigned char *)a;
+    volatile const unsigned char *B =3D (volatile const unsigned char *)b;
+    volatile unsigned char diff =3D 0;
+
+    for (size_t i =3D 0; i < size; i++)
+    {
+        unsigned char x =3D A[i], y =3D B[i];
+        diff |=3D x ^ y;
+    }
+
+    return diff;
+}
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
+/*
+ * Generate the hash required by for the \c tls1_PRF function.
+ *
+ * @param md_kt         Message digest to use
+ * @param sec           Secret to base the hash on
+ * @param sec_len       Length of the secret
+ * @param seed          Seed to hash
+ * @param seed_len      Length of the seed
+ * @param out           Output buffer
+ * @param olen          Length of the output buffer
+ */
+static void
+tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, size_t sec=
_len, const uint8_t *seed,
+            size_t seed_len, uint8_t *out, size_t olen)
+{
+    struct gc_arena gc =3D gc_new();
+    uint8_t A1[MAX_HMAC_KEY_LENGTH];
+
+#ifdef ENABLE_DEBUG
+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid u=
nused
+     * variables warnings if compiled with --enable-small */
+    const size_t olen_orig =3D olen;
+    const uint8_t *out_orig =3D out;
+#endif
+
+    hmac_ctx_t *ctx =3D hmac_ctx_new();
+    hmac_ctx_t *ctx_tmp =3D hmac_ctx_new();
+
+    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len=
, 0, &gc));
+    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_=
len, 0, &gc));
+
+    unsigned int chunk =3D mbedtls_md_get_size(md_kt);
+    unsigned int A1_len =3D mbedtls_md_get_size(md_kt);
+
+    /* This is the only place where we init an HMAC with a key that is not
+     * equal to its size, therefore we init the hmac ctx manually here */
+    mbedtls_md_init(ctx);
+    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, md_kt, 1));
+    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, sec, sec_len));
+
+    mbedtls_md_init(ctx_tmp);
+    ASSERT(0 =3D=3D mbedtls_md_setup(ctx_tmp, md_kt, 1));
+    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx_tmp, sec, sec_len));
+
+    hmac_ctx_update(ctx, seed, seed_len);
+    hmac_ctx_final(ctx, A1);
+
+    for (;;)
+    {
+        hmac_ctx_reset(ctx);
+        hmac_ctx_reset(ctx_tmp);
+        hmac_ctx_update(ctx, A1, A1_len);
+        hmac_ctx_update(ctx_tmp, A1, A1_len);
+        hmac_ctx_update(ctx, seed, seed_len);
+
+        if (olen > chunk)
+        {
+            hmac_ctx_final(ctx, out);
+            out +=3D chunk;
+            olen -=3D chunk;
+            hmac_ctx_final(ctx_tmp, A1); /* calc the next A1 value */
+        }
+        else                             /* last one */
+        {
+            hmac_ctx_final(ctx, A1);
+            memcpy(out, A1, olen);
+            break;
+        }
+    }
+    hmac_ctx_cleanup(ctx);
+    hmac_ctx_free(ctx);
+    hmac_ctx_cleanup(ctx_tmp);
+    hmac_ctx_free(ctx_tmp);
+    secure_memzero(A1, sizeof(A1));
+
+    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash out: %s", format_hex(out_orig, ol=
en_orig, 0, &gc));
+    gc_free(&gc);
+}
+
+/*
+ * Use the TLS PRF function for generating data channel keys.
+ * This code is based on the OpenSSL library.
+ *
+ * TLS generates keys as such:
+ *
+ * master_secret[48] =3D PRF(pre_master_secret[48], "master secret",
+ *                         ClientHello.random[32] + ServerHello.random[32])
+ *
+ * key_block[] =3D PRF(SecurityParameters.master_secret[48],
+ *                 "key expansion",
+ *                 SecurityParameters.server_random[32] +
+ *                 SecurityParameters.client_random[32]);
+ *
+ * Notes:
+ *
+ * (1) key_block contains a full set of 4 keys.
+ * (2) The pre-master secret is generated by the client.
+ */
+bool
+ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, s=
ize_t slen, uint8_t *out1,
+             size_t olen)
+{
+    struct gc_arena gc =3D gc_new();
+    const md_kt_t *md5 =3D md_get("MD5");
+    const md_kt_t *sha1 =3D md_get("SHA1");
+
+    uint8_t *out2 =3D (uint8_t *)gc_malloc(olen, false, &gc);
+
+    size_t len =3D slen / 2;
+    const uint8_t *S1 =3D sec;
+    const uint8_t *S2 =3D &(sec[len]);
+    len +=3D (slen & 1); /* add for odd, make longer */
+
+    tls1_P_hash(md5, S1, len, label, label_len, out1, olen);
+    tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);
+
+    for (size_t i =3D 0; i < olen; i++)
+    {
+        out1[i] ^=3D out2[i];
+    }
+
+    secure_memzero(out2, olen);
+
+    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%zu]: %s", olen, format_hex(out1=
, olen, 0, &gc));
+
+    gc_free(&gc);
+    return true;
+}
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
+#endif /* MBEDTLS_VERSION_NUMBER < 0x040000 */
+#endif /* ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/crypto_mbedtls_legacy.h b/src/openvpn/crypto_mbedt=
ls_legacy.h
new file mode 100644
index 0000000..af71037
--- /dev/null
+++ b/src/openvpn/crypto_mbedtls_legacy.h
@@ -0,0 +1,148 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
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
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+/**
+ * @file
+ * Data Channel Cryptography mbed TLS-specific backend interface
+ */
+
+#ifndef CRYPTO_MBEDTLS_H_
+#define CRYPTO_MBEDTLS_H_
+
+#include <stdbool.h>
+#include <mbedtls/cipher.h>
+#include <mbedtls/md.h>
+#include <mbedtls/ctr_drbg.h>
+
+/** Generic message digest key type %context. */
+typedef mbedtls_md_info_t md_kt_t;
+
+/** Generic cipher %context. */
+typedef mbedtls_cipher_context_t cipher_ctx_t;
+
+/** Generic message digest %context. */
+typedef mbedtls_md_context_t md_ctx_t;
+
+/** Generic HMAC %context. */
+typedef mbedtls_md_context_t hmac_ctx_t;
+
+/* Use a dummy type for the provider */
+typedef void provider_t;
+
+/** Maximum length of an IV */
+#define OPENVPN_MAX_IV_LENGTH MBEDTLS_MAX_IV_LENGTH
+
+/** Cipher is in CBC mode */
+#define OPENVPN_MODE_CBC MBEDTLS_MODE_CBC
+
+/** Cipher is in OFB mode */
+#define OPENVPN_MODE_OFB MBEDTLS_MODE_OFB
+
+/** Cipher is in CFB mode */
+#define OPENVPN_MODE_CFB MBEDTLS_MODE_CFB
+
+/** Cipher is in GCM mode */
+#define OPENVPN_MODE_GCM MBEDTLS_MODE_GCM
+
+typedef mbedtls_operation_t crypto_operation_t;
+
+/** Cipher should encrypt */
+#define OPENVPN_OP_ENCRYPT MBEDTLS_ENCRYPT
+
+/** Cipher should decrypt */
+#define OPENVPN_OP_DECRYPT MBEDTLS_DECRYPT
+
+#define MD4_DIGEST_LENGTH    16
+#define MD5_DIGEST_LENGTH    16
+#define SHA_DIGEST_LENGTH    20
+#define SHA256_DIGEST_LENGTH 32
+
+/**
+ * Returns a singleton instance of the mbed TLS random number generator.
+ *
+ * For PolarSSL/mbed TLS 1.1+, this is the CTR_DRBG random number generato=
r. If it
+ * hasn't been initialised yet, the RNG will be initialised using the defa=
ult
+ * entropy sources. Aside from the default platform entropy sources, an
+ * additional entropy source, the HAVEGE random number generator will also=
 be
+ * added. During initialisation, a personalisation string will be added ba=
sed
+ * on the time, the PID, and a pointer to the random context.
+ */
+mbedtls_ctr_drbg_context *rand_ctx_get(void);
+
+#ifdef ENABLE_PREDICTION_RESISTANCE
+/**
+ * Enable prediction resistance on the random number generator.
+ */
+void rand_ctx_enable_prediction_resistance(void);
+
+#endif
+
+/**
+ * Log the supplied mbed TLS error, prefixed by supplied prefix.
+ *
+ * @param flags         Flags to indicate error type and priority.
+ * @param errval        mbed TLS error code to convert to error message.
+ * @param prefix        Prefix to mbed TLS error message.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+bool mbed_log_err(unsigned int flags, int errval, const char *prefix);
+
+/**
+ * Log the supplied mbed TLS error, prefixed by function name and line num=
ber.
+ *
+ * @param flags         Flags to indicate error type and priority.
+ * @param errval        mbed TLS error code to convert to error message.
+ * @param func          Function name where error was reported.
+ * @param line          Line number where error was reported.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+bool mbed_log_func_line(unsigned int flags, int errval, const char *func, =
int line);
+
+/** Wraps mbed_log_func_line() to prevent function calls for non-errors */
+static inline bool
+mbed_log_func_line_lite(unsigned int flags, int errval, const char *func, =
int line)
+{
+    if (errval)
+    {
+        return mbed_log_func_line(flags, errval, func, line);
+    }
+    return true;
+}
+
+/**
+ * Check errval and log on error.
+ *
+ * Convenience wrapper to put around mbed TLS library calls, e.g.
+ *   if (!mbed_ok (mbedtls_ssl_func())) return 0;
+ * or
+ *   ASSERT (mbed_ok (mbedtls_ssl_func()));
+ *
+ * @param errval        mbed TLS error code to convert to error message.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+#define mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __=
func__, __LINE__)
+
+#endif /* CRYPTO_MBEDTLS_H_ */
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index d457b5e..667529e 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -34,6 +34,16 @@

 #include "errlevel.h"

+#include <mbedtls/asn1.h>
+#include <mbedtls/pk.h>
+
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
+#include <mbedtls/ctr_drbg.h>
+#include "crypto_mbedtls_legacy.h"
+#else
+#include <mbedtls/oid.h>
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
+
 #ifdef HAVE_PSA_CRYPTO_H
 #include <psa/crypto.h>
 #endif
@@ -51,4 +61,176 @@
 #endif
 }

+#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+typedef struct
+{
+    const char *name;
+    uint16_t tls_id;
+} mbedtls_ecp_curve_info;
+
+static inline int
+mbedtls_oid_get_attr_short_name(const mbedtls_asn1_buf *oid, const char **=
desc)
+{
+    /* The relevant OIDs all have equal length. */
+    if (oid->tag !=3D MBEDTLS_ASN1_OID || oid->len !=3D strlen(MBEDTLS_OID=
_AT_CN))
+    {
+        *desc =3D NULL;
+        return -1;
+    }
+
+    if (memcmp(oid->p, MBEDTLS_OID_AT_CN, oid->len) =3D=3D 0)
+    {
+        *desc =3D "CN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_SUR_NAME, oid->len) =3D=3D 0)
+    {
+        *desc =3D "SN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid->len) =3D=3D=
 0)
+    {
+        *desc =3D "serialNumber";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_COUNTRY, oid->len) =3D=3D 0)
+    {
+        *desc =3D "C";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_LOCALITY, oid->len) =3D=3D 0)
+    {
+        *desc =3D "L";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_STATE, oid->len) =3D=3D 0)
+    {
+        *desc =3D "ST";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORGANIZATION, oid->len) =3D=3D =
0)
+    {
+        *desc =3D "O";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORG_UNIT, oid->len) =3D=3D 0)
+    {
+        *desc =3D "OU";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_TITLE, oid->len) =3D=3D 0)
+    {
+        *desc =3D "title";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_ADDRESS, oid->len) =3D=
=3D 0)
+    {
+        *desc =3D "postalAddress";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_CODE, oid->len) =3D=3D 0)
+    {
+        *desc =3D "postalCode";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_GIVEN_NAME, oid->len) =3D=3D 0)
+    {
+        *desc =3D "GN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_INITIALS, oid->len) =3D=3D 0)
+    {
+        *desc =3D "initials";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_GENERATION_QUALIFIER, oid->len)=
 =3D=3D 0)
+    {
+        *desc =3D "generationQualifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIER, oid->len) =
=3D=3D 0)
+    {
+        *desc =3D "uniqueIdentifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_DN_QUALIFIER, oid->len) =3D=3D =
0)
+    {
+        *desc =3D "dnQualifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_PSEUDONYM, oid->len) =3D=3D 0)
+    {
+        *desc =3D "pseudonym";
+    }
+    else
+    {
+        *desc =3D NULL;
+        return -1;
+    }
+    return 0;
+}
+
+static inline int
+mbedtls_oid_get_extended_key_usage(const mbedtls_asn1_buf *oid, const char=
 **desc)
+{
+    /* The relevant OIDs all have equal length. */
+    if (oid->tag !=3D MBEDTLS_ASN1_OID || oid->len !=3D strlen(MBEDTLS_OID=
_SERVER_AUTH))
+    {
+        *desc =3D NULL;
+        return -1;
+    }
+
+    if (memcmp(oid->p, MBEDTLS_OID_SERVER_AUTH, oid->len) =3D=3D 0)
+    {
+        *desc =3D "TLS Web Server Authentication";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_CLIENT_AUTH, oid->len) =3D=3D 0)
+    {
+        *desc =3D "TLS Web Client Authentication";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_CODE_SIGNING, oid->len) =3D=3D 0)
+    {
+        *desc =3D "Code Signing";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_EMAIL_PROTECTION, oid->len) =3D=3D=
 0)
+    {
+        *desc =3D "E-mail Protection";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_TIME_STAMPING, oid->len) =3D=3D 0)
+    {
+        *desc =3D "Time Stamping";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_OCSP_SIGNING, oid->len) =3D=3D 0)
+    {
+        *desc =3D "OCSP Signing";
+    }
+    else
+    {
+        *desc =3D NULL;
+        return -1;
+    }
+
+    return 0;
+}
+#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
+
+/* Some functions that operate on private keys use randomness to protect a=
gainst
+ * side channels. In Mbed TLS 4, they automatically use the RNG in the PSA
+ * library, but in Mbed TLS 3, they require them as explicit arguments. */
+static inline int
+mbedtls_compat_pk_parse_key(mbedtls_pk_context *ctx,
+                            const unsigned char *key, size_t keylen,
+                            const unsigned char *pwd, size_t pwdlen)
+{
+#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen);
+#else
+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen, mbedtls_ctr=
_drbg_random, rand_ctx_get());
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
+}
+
+static inline int
+mbedtls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx, const char *path,=
 const char *password)
+{
+#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+    return mbedtls_pk_parse_keyfile(ctx, path, password);
+#else
+    return mbedtls_pk_parse_keyfile(ctx, path, password, mbedtls_ctr_drbg_=
random, rand_ctx_get());
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
+}
+
+static inline int
+mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_=
pk_context *prv)
+{
+#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+    return mbedtls_pk_check_pair(pub, prv);
+#else
+    return mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_random, rand_c=
tx_get());
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
+}
+
 #endif /* MBEDTLS_COMPAT_H_ */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index f902e17..3e1698f 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -93,7 +93,9 @@
     ASSERT(NULL !=3D ctx);
     CLEAR(*ctx);

+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
+#endif

     ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);

@@ -107,7 +109,9 @@
     ASSERT(NULL !=3D ctx);
     CLEAR(*ctx);

+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
+#endif
     ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);

     ctx->endpoint =3D MBEDTLS_SSL_IS_CLIENT;
@@ -128,8 +132,10 @@
         mbedtls_x509_crt_free(ctx->crt_chain);
         free(ctx->crt_chain);

+#if MBEDTLS_VERSION_NUMBER < 0x04000000
         mbedtls_dhm_free(ctx->dhm_ctx);
         free(ctx->dhm_ctx);
+#endif

         mbedtls_x509_crl_free(ctx->crl);
         free(ctx->crl);
@@ -348,6 +354,34 @@
     }
 }

+#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+static const mbedtls_ecp_curve_info ecp_curve_info_table[] =3D {
+    /* TODO: Fill out the table. */
+    { "secp256r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP256R1 },
+    { "secp384r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP384R1 },
+    { "X25519", MBEDTLS_SSL_IANA_TLS_GROUP_X25519 },
+    { "ffdhe2048", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE2048 },
+    { "ffdhe3072", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE3072 },
+    { "ffdhe4096", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE4096 },
+    { "ffdhe6144", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE6144 },
+    { "ffdhe8192", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE8192 },
+};
+static const size_t ecp_curve_info_table_items =3D sizeof(ecp_curve_info_t=
able) / sizeof(mbedtls_ecp_curve_info);
+
+static const mbedtls_ecp_curve_info *
+mbedtls_ecp_curve_info_from_name(const char *name)
+{
+    for (size_t i =3D 0; i < ecp_curve_info_table_items; i++)
+    {
+        if (strcmp(name, ecp_curve_info_table[i].name) =3D=3D 0)
+        {
+            return &ecp_curve_info_table[i];
+        }
+    }
+    return NULL;
+}
+#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
+
 void
 tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
 {
@@ -409,6 +443,7 @@
 void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file, bool=
 dh_inline)
 {
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     if (dh_inline)
     {
         if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx->dhm_ctx, (const unsigned c=
har *)dh_file,
@@ -427,6 +462,12 @@

     msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with " counter_format=
 " bit key",
         (counter_type)mbedtls_dhm_get_bitlen(ctx->dhm_ctx));
+#else
+    if (strcmp(dh_file, "none") !=3D 0)
+    {
+        msg(M_FATAL, "Mbed TLS 4 only supports pre-defined Diffie-Hellman =
groups.");
+    }
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }

 void
@@ -500,29 +541,26 @@

     if (priv_key_inline)
     {
-        status =3D mbedtls_pk_parse_key(ctx->priv_key, (const unsigned cha=
r *)priv_key_file,
-                                      strlen(priv_key_file) + 1, NULL, 0,
-                                      mbedtls_ctr_drbg_random, rand_ctx_ge=
t());
+        status =3D mbedtls_compat_pk_parse_key(ctx->priv_key, (const unsig=
ned char *)priv_key_file,
+                                             strlen(priv_key_file) + 1, NU=
LL, 0);

         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
             char passbuf[512] =3D { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
-            status =3D mbedtls_pk_parse_key(
+            status =3D mbedtls_compat_pk_parse_key(
                 ctx->priv_key, (const unsigned char *)priv_key_file, strle=
n(priv_key_file) + 1,
-                (unsigned char *)passbuf, strlen(passbuf), mbedtls_ctr_drb=
g_random, rand_ctx_get());
+                (unsigned char *)passbuf, strlen(passbuf));
         }
     }
     else
     {
-        status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, =
NULL,
-                                          mbedtls_ctr_drbg_random, rand_ct=
x_get());
+        status =3D mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv_key=
_file, NULL);
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
             char passbuf[512] =3D { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
-            status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_fi=
le, passbuf,
-                                              mbedtls_ctr_drbg_random, ran=
d_ctx_get());
+            status =3D mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv=
_key_file, passbuf);
         }
     }
     if (!mbed_ok(status))
@@ -538,8 +576,7 @@
         return 1;
     }

-    if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key,
-                                       mbedtls_ctr_drbg_random, rand_ctx_g=
et())))
+    if (!mbed_ok(mbedtls_compat_pk_check_pair(&ctx->crt_chain->pk, ctx->pr=
iv_key)))
     {
         msg(M_WARN, "Private key does not match the certificate");
         return 1;
@@ -553,6 +590,7 @@
 #pragma GCC diagnostic ignored "-Wconversion"
 #endif

+#if MBEDTLS_VERSION_NUMBER < 0x04000000
 /**
  * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that =
uses
  * the management interface to request an RSA signature for the supplied h=
ash.
@@ -669,11 +707,16 @@

     return ctx->signature_length;
 }
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */

 int
 tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx, external_sign_=
func sign_func,
                                   void *sign_ctx)
 {
+#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+    msg(M_WARN, "tls_ctx_use_external_signing_func is not implemented for =
Mbed TLS 4.");
+    return 1;
+#else
     ASSERT(NULL !=3D ctx);

     if (ctx->crt_chain =3D=3D NULL)
@@ -701,6 +744,7 @@
     }

     return 0;
+#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
 }

 #ifdef ENABLE_MANAGEMENT
@@ -938,6 +982,7 @@
 void
 tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 {
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     static char old_sha256_hash[32] =3D { 0 };
     unsigned char sha256_hash[32] =3D { 0 };
     mbedtls_ctr_drbg_context *cd_ctx =3D rand_ctx_get();
@@ -960,6 +1005,7 @@
             memcpy(old_sha256_hash, sha256_hash, sizeof(old_sha256_hash));
         }
     }
+#endif /* MBEDTLS_VERSION_NUMBER < 0x040000 */
 }

 #if defined(__GNUC__) || defined(__clang__)
@@ -1069,7 +1115,9 @@
     }
 #endif
     mbedtls_ssl_conf_dbg(ks_ssl->ssl_config, my_debug, NULL);
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     mbedtls_ssl_conf_rng(ks_ssl->ssl_config, mbedtls_ctr_drbg_random, rand=
_ctx_get());
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */

     mbedtls_ssl_conf_cert_profile(ks_ssl->ssl_config, &ssl_ctx->cert_profi=
le);
=20
@@ -1100,12 +1148,14 @@
 #endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */

     /* Initialise authentication information */
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     if (is_server)
     {
         mbed_ok(mbedtls_ssl_conf_dh_param_ctx(ks_ssl->ssl_config, ssl_ctx-=
>dhm_ctx));
     }
+#endif

-    mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl->ssl_config, ssl_ctx->crt_cha=
in, ssl_ctx->priv_key));
+    (void)mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl->ssl_config, ssl_ctx->c=
rt_chain, ssl_ctx->priv_key));

     /* Initialise SSL verification */
     if (session->opt->ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
@@ -1160,7 +1210,7 @@
     /* Initialise SSL context */
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
-    mbed_ok(mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config));
+    (void)mbed_ok(mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config));
     /* We do verification in our own callback depending on the
      * exact configuration. We do not rely on the default hostname
      * verification. */
@@ -1376,7 +1426,8 @@
     /* Error during read, check for retry error */
     if (retval < 0)
     {
-        if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval || MBEDTLS_ERR_SSL_WA=
NT_READ =3D=3D retval)
+        if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval || MBEDTLS_ERR_SSL_WA=
NT_READ =3D=3D retval
+            || MBEDTLS_ERR_SSL_RECEIVED_NEW_SESSION_TICKET =3D=3D retval)
         {
             return 0;
         }
@@ -1456,6 +1507,7 @@
 void
 show_available_curves(void)
 {
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     const mbedtls_ecp_curve_info *pcurve =3D mbedtls_ecp_curve_list();

     if (NULL =3D=3D pcurve)
@@ -1470,6 +1522,9 @@
         printf("%s\n", pcurve->name);
         pcurve++;
     }
+#else
+    msg(M_FATAL, "Mbed TLS 4 has no mechanism to list supported curves.");
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }

 const char *
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index f744945..6b678b2 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -112,11 +112,13 @@
  */
 struct tls_root_ctx
 {
-    bool initialised;                      /**< True if the context has be=
en initialised */
+    bool initialised; /**< True if the context has been initialised */

-    int endpoint;                          /**< Whether or not this is a s=
erver or a client */
+    int endpoint;     /**< Whether or not this is a server or a client */

+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     mbedtls_dhm_context *dhm_ctx;          /**< Diffie-Helmann-Merkle cont=
ext */
+#endif
     mbedtls_x509_crt *crt_chain;           /**< Local Certificate chain */
     mbedtls_x509_crt *ca_chain;            /**< CA chain for remote verifi=
cation */
     mbedtls_pk_context *priv_key;          /**< Local private key */
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 9d89a1d..32f3ecb 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -34,13 +34,22 @@

 #if defined(ENABLE_CRYPTO_MBEDTLS)

+#include <mbedtls/version.h>
+
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
+#include "crypto_mbedtls_legacy.h"
+#include <mbedtls/bignum.h>
+#include <mbedtls/sha1.h>
+#else
 #include "crypto_mbedtls.h"
+#endif
+
+#include "mbedtls_compat.h"
+
 #include "ssl_verify.h"
 #include <mbedtls/asn1.h>
 #include <mbedtls/error.h>
-#include <mbedtls/bignum.h>
 #include <mbedtls/oid.h>
-#include <mbedtls/sha1.h>

 #define MAX_SUBJECT_LENGTH 256

@@ -171,11 +180,139 @@
     return SUCCESS;
 }

+#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+/* Mbed TLS 4 has no function to print the certificate serial number and d=
oes
+ * not expose the bignum functions anymore. So in order to write the serial
+ * number as a decimal string, we implement bignum % 10 and bignum / 10. */
+static char
+bignum_mod_10(const uint8_t *bignum, size_t bignum_length)
+{
+    int result =3D 0;
+    for (size_t i =3D 0; i < bignum_length; i++)
+    {
+        result =3D (result * 256) % 10;
+        result =3D (result + bignum[i]) % 10;
+    }
+    return (char)result;
+}
+
+/* Divide bignum by 10 rounded down, in place. */
+static void
+bignum_div_10(uint8_t *bignum, size_t *bignum_length)
+{
+    /*
+     * Some intuition for the algorithm below:
+     *
+     * We want to calculate
+     *
+     *     (bignum[0] * 256^n + bignum[1] * 256^(n-1) + ... + bignum[n]) /=
 10.
+     *
+     * Let remainder =3D bignum[0] % 10 and carry =3D remainder * 256.
+     * Then we can write the above as
+     *
+     *     (bignum[0] / 10) * 256^n
+     *       + ((carry + bignum[1]) * 256^(n-1) + ... + bignum[n]) / 10.
+     *
+     * So now we have the first byte of our result. The second byte will be
+     * (carry + bignum[1]) / 10. Note that this fits into one byte because
+     * 0 <=3D remainder < 10. We calculate the next remainder and carry as
+     * remainder =3D (carry + bignum[1]) % 10 and carry =3D remainder * 25=
6 and
+     * move on to the next byte until we are done.
+     */
+    size_t new_length =3D 0;
+    int carry =3D 0;
+    for (size_t i =3D 0; i < *bignum_length; i++)
+    {
+        uint8_t next_byte =3D (uint8_t)((bignum[i] + carry) / 10);
+        int remainder =3D (bignum[i] + carry) % 10;
+        carry =3D remainder * 256;
+
+        /* Write the byte unless it's a leading zero. */
+        if (new_length !=3D 0 || next_byte !=3D 0)
+        {
+            bignum[new_length++] =3D next_byte;
+        }
+    }
+    *bignum_length =3D new_length;
+}
+
+/* Write the decimal representation of bignum to out, if enough space is a=
vailable.
+ * Returns the number of bytes needed in out, or 0 on error. To calculate =
the
+ * necessary buffer size, the function can be called with out =3D NULL. */
+static size_t
+write_bignum(char *out, size_t out_size, const uint8_t *bignum, size_t big=
num_length)
+{
+    if (bignum_length =3D=3D 0)
+    {
+        /* We want out to be "0". */
+        if (out !=3D NULL)
+        {
+            if (out_size >=3D 2)
+            {
+                out[0] =3D '0';
+                out[1] =3D '\0';
+            }
+            else if (out_size > 0)
+            {
+                out[0] =3D '\0';
+            }
+        }
+        return 2;
+    }
+
+    uint8_t *bignum_copy =3D malloc(bignum_length);
+    if (bignum_copy =3D=3D NULL)
+    {
+        return 0;
+    }
+    memcpy(bignum_copy, bignum, bignum_length);
+
+    size_t bytes_needed =3D 0;
+    size_t bytes_written =3D 0;
+    while (bignum_length > 0)
+    {
+        /* We're writing the digits in reverse order. We put them in the r=
ight order later. */
+        char digit =3D bignum_mod_10(bignum_copy, bignum_length);
+        if (out !=3D NULL && bytes_written < out_size - 1)
+        {
+            out[bytes_written++] =3D '0' + (char)digit;
+        }
+        bytes_needed +=3D 1;
+        bignum_div_10(bignum_copy, &bignum_length);
+    }
+
+    if (out !=3D NULL)
+    {
+        if (bytes_written =3D=3D bytes_needed)
+        {
+            /* We had space for all digits. Now reverse them. */
+            for (size_t i =3D 0; i < bytes_written / 2; i++)
+            {
+                char tmp =3D out[i];
+                out[i] =3D out[bytes_written - 1 - i];
+                out[bytes_written - 1 - i] =3D tmp;
+            }
+            out[bytes_written] =3D '\0';
+        }
+        else if (out_size > 0)
+        {
+            out[0] =3D '\0';
+        }
+    }
+    bytes_needed +=3D 1;
+
+    free(bignum_copy);
+    return bytes_needed;
+}
+#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
+
 char *
 backend_x509_get_serial(mbedtls_x509_crt *cert, struct gc_arena *gc)
 {
     char *buf =3D NULL;
     size_t buflen =3D 0;
+
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     mbedtls_mpi serial_mpi =3D { 0 };

     /* Transform asn1 integer serial into mbed TLS MPI */
@@ -201,6 +338,21 @@
 end:
     mbedtls_mpi_free(&serial_mpi);
     return buf;
+#else
+    buflen =3D write_bignum(NULL, 0, cert->serial.p, cert->serial.len);
+    if (buflen =3D=3D 0)
+    {
+        msg(M_WARN, "Failed to write serial to string.");
+        return NULL;
+    }
+    buf =3D gc_malloc(buflen, true, gc);
+    if (write_bignum(buf, buflen, cert->serial.p, cert->serial.len) !=3D b=
uflen)
+    {
+        msg(M_WARN, "Failed to write serial to string.");
+        return NULL;
+    }
+    return buf;
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }

 char *
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 2e22204..582e130 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -475,7 +475,10 @@
 #endif

 #ifdef ENABLE_CRYPTO_MBEDTLS
+#include <mbedtls/version.h>
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
 #define ENABLE_PREDICTION_RESISTANCE
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 #endif /* ENABLE_CRYPTO_MBEDTLS */

 /*
diff --git a/tests/Makefile.am b/tests/Makefile.am
index bf8f960..cb30fe5 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -55,6 +55,7 @@
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/packet_id.c \
 	$(top_srcdir)/src/openvpn/platform.c
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 798cfd0..bba77aa 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -57,7 +57,7 @@
 SERVER_SERVER_2=3D"--server 10.29.42.0 255.255.255.0"
 SERVER_MGMT_PORT_2=3D"11195"
 SERVER_EXEC_2=3D"${SERVER_EXEC}"
-SERVER_CONF_2=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --pro=
to tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2} --dh ${DH}"
+SERVER_CONF_2=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --pro=
to tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2} --dh none"

 SERVER_NAME_3=3D"t_server_null_server-1196_udp"
 SERVER_SERVER_3=3D"--server 10.29.43.0 255.255.255.0"
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 7aeea47..1128eb4 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -76,6 +76,7 @@
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -110,6 +111,7 @@
 	$(top_srcdir)/src/openvpn/cryptoapi.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
 	$(top_srcdir)/src/openvpn/mss.c \
@@ -158,6 +160,7 @@
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -188,6 +191,7 @@
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -208,6 +212,7 @@
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/fdmisc.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -294,6 +299,7 @@
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/packet_id.c \
@@ -332,6 +338,7 @@
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/packet_id.c \
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/open=
vpn/test_common.h
index f898e89..1aa92e6 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -24,6 +24,10 @@
 #include <setjmp.h>
 #include <cmocka.h>

+#if defined(ENABLE_CRYPTO_MBEDTLS)
+#include "mbedtls_compat.h"
+#endif
+
 /* Do we use cmocka < 2.0.0? */
 #ifndef HAVE_CMOCKA_VERSION_H
 #define HAVE_OLD_CMOCKA_API 1
@@ -57,6 +61,9 @@
 {
     assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);
     assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);
+#if defined(ENABLE_CRYPTO_MBEDTLS)
+    mbedtls_compat_psa_crypto_init();
+#endif
 }

 /**

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae
Gerrit-Change-Number: 1441
Gerrit-PatchSet: 7
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: syzzer <steffan@...1856...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: syzzer <steffan@...1856...>

--a/cArQapq28=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, syzzer. </p>
<p>MaxF <strong>uploaded patch set #7</strong> to this change.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">View Change</a=
></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">Add support for Mbed TLS 4<br><br>This commit adds suppo=
rt for Mbed TLS 4. This version comes with some<br>drastic changes. The cry=
pto library has been completely redesigned, so<br>the contents of crypto_mb=
edtls.c are moved to crypto_mbedtls_legacy.c<br>and crypto_mbedtls.c handle=
s the crypto for version 4.<br><br>Mbed TLS 4 also removed the feature for =
looking up a crypto algorithm by<br>name, so we need to translate algorithm=
 names to Mbed TLS numbers in<br>OpenVPN. The tables are not yet complete. =
For symmetric algorithms, I<br>have added AES and Chacha-Poly which should =
be enough for most use<br>cases.<br><br>Change-Id: Ib251d546d993b96ed3bd8cb=
9111bcc627cdb0fae<br>Signed-off-by: Max Fillinger &lt;maximilian.fillinger@=
...2918...&gt;<br>---<br>M README.mbedtls<br>M src/openvpn/Makefile.am<br>M=
 src/openvpn/crypto_backend.h<br>M src/openvpn/crypto_mbedtls.c<br>M src/op=
envpn/crypto_mbedtls.h<br>A src/openvpn/crypto_mbedtls_legacy.c<br>A src/op=
envpn/crypto_mbedtls_legacy.h<br>M src/openvpn/mbedtls_compat.h<br>M src/op=
envpn/ssl_mbedtls.c<br>M src/openvpn/ssl_mbedtls.h<br>M src/openvpn/ssl_ver=
ify_mbedtls.c<br>M src/openvpn/syshead.h<br>M tests/Makefile.am<br>M tests/=
t_server_null_default.rc<br>M tests/unit_tests/openvpn/Makefile.am<br>M tes=
ts/unit_tests/openvpn/test_common.h<br>16 files changed, 2,446 insertions(+=
), 708 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/41/1441/7</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/README.mbed=
tls b/README.mbedtls</span><br><span>index fb30db1..b768687 100644</span><b=
r><span>--- a/README.mbedtls</span><br><span>+++ b/README.mbedtls</span><br=
><span>@@ -7,8 +7,8 @@</span><br><span> 	make</span><br><span> 	make instal=
l</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-Th=
is version requires mbed TLS version &gt;=3D 3.2.1. Versions &gt;=3D 4.0.0 =
are not</span><br><span style=3D"color: hsl(0, 100%, 40%);">-yet supported.=
 Support for TLS 1.3 requires an Mbed TLS version &gt;=3D 3.6.4.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+This version requires mbed TLS=
 version &gt;=3D 3.2.1. Support for TLS 1.3 requires</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+an Mbed TLS version &gt;=3D 3.6.4.</span>=
<br><span> </span><br><span> **********************************************=
***************************</span><br><span> </span><br><span>diff --git a/=
src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index c87=
9585..3c567aa 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><b=
r><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -54,6 +54,7 @@</sp=
an><br><span> 	comp-lz4.c comp-lz4.h \</span><br><span> 	crypto.c crypto.h =
crypto_backend.h \</span><br><span> 	crypto_openssl.c crypto_openssl.h \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	crypto_mbedtls_legacy=
.c crypto_mbedtls_legacy.h \</span><br><span> 	crypto_mbedtls.c crypto_mbed=
tls.h \</span><br><span> 	crypto_epoch.c crypto_epoch.h \</span><br><span> =
	dco.c dco.h dco_internal.h \</span><br><span>diff --git a/src/openvpn/cryp=
to_backend.h b/src/openvpn/crypto_backend.h</span><br><span>index e9fc2f3..=
5248614 100644</span><br><span>--- a/src/openvpn/crypto_backend.h</span><br=
><span>+++ b/src/openvpn/crypto_backend.h</span><br><span>@@ -32,9 +32,16 @=
@</span><br><span> #ifdef ENABLE_CRYPTO_OPENSSL</span><br><span> #include &=
quot;crypto_openssl.h&quot;</span><br><span> #endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_CRYPTO_MB=
EDTLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;m=
bedtls/version.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;crypto_mbedtls_legacy.h&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span> #in=
clude &quot;crypto_mbedtls.h&quot;</span><br><span> #endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> #include &quot;basic.h&quot;</s=
pan><br><span> #include &quot;buffer.h&quot;</span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.=
c</span><br><span>index e1a5cad..f8c1f11 100644</span><br><span>--- a/src/o=
penvpn/crypto_mbedtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c<=
/span><br><span>@@ -5,8 +5,8 @@</span><br><span>  *             packet encr=
yption, packet authentication, and</span><br><span>  *             packet c=
ompression.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@...515...&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-=
2026 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales=
@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  C=
opyright (C) 2010-2025 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><=
span>  *</span><br><span>  *  This program is free software; you can redist=
ribute it and/or modify</span><br><span>  *  it under the terms of the GNU =
General Public License version 2</span><br><span>@@ -23,7 +23,8 @@</span><b=
r><span> </span><br><span> /**</span><br><span>  * @file</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Data Channel Cryptography mbed TLS-sp=
ecific backend interface</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Data Channel Cryptography backend interface using the TF-PSA-Crypto=
 library</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * part of =
Mbed TLS 4.</span><br><span>  */</span><br><span> </span><br><span> #ifdef =
HAVE_CONFIG_H</span><br><span>@@ -33,6 +34,9 @@</span><br><span> #include &=
quot;syshead.h&quot;</span><br><span> </span><br><span> #if defined(ENABLE_=
CRYPTO_MBEDTLS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;mbedtls/version.h&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBED=
TLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span> </span><br><span> #i=
nclude &quot;errlevel.h&quot;</span><br><span> #include &quot;basic.h&quot;=
</span><br><span>@@ -40,20 +44,16 @@</span><br><span> #include &quot;crypto=
.h&quot;</span><br><span> #include &quot;integer.h&quot;</span><br><span> #=
include &quot;crypto_backend.h&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;crypto_mbedtls.h&quot;</span><br><span> #in=
clude &quot;otime.h&quot;</span><br><span> #include &quot;misc.h&quot;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include=
 &lt;mbedtls/base64.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#include &lt;mbedtls/des.h&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;psa/crypto.h&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;psa/crypto_config.h&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/constant_tim=
e.h&gt;</span><br><span> #include &lt;mbedtls/error.h&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/md5.h&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/cipher.h&=
gt;</span><br><span> #include &lt;mbedtls/pem.h&gt;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/entrop=
y.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;m=
bedtls/ssl.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span=
><br><span>  *</span><br><span>  * Hardware engine support. Allows loading/=
unloading of engines.</span><br><span>@@ -82,331 +82,65 @@</span><br><span>=
 {</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Functions related=
 to the core crypto library</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* The library doesn&#39;t su=
pport looking up algorithms by string anymore, so here</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * is a lookup table. */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static const cipher_info_t cipher_i=
nfo_table[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 TODO: Complete the table. */</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-crypto_init_lib(void)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* AES */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if PSA_WANT_KEY_TYPE_AES</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if PSA_WANT_ALG_GCM</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-128-GCM&quot;, P=
SA_KEY_TYPE_AES, PSA_ALG_GCM, 128 / 8, 96 / 8, 128 / 8 },</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-192-GCM&quot;, PSA_KE=
Y_TYPE_AES, PSA_ALG_GCM, 192 / 8, 96 / 8, 128 / 8 },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-256-GCM&quot;, PSA_KEY_TY=
PE_AES, PSA_ALG_GCM, 256 / 8, 96 / 8, 128 / 8 },</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif /* PSA_WANT_ALG_GCM */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if PSA_WANT_ALG_CBC_PKCS7</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-128-CBC&quot;=
, PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 128 / 8, 128 / 8, 128 / 8 },</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-192-CBC&quo=
t;, PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 192 / 8, 128 / 8, 128 / 8 },</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-256-CBC&q=
uot;, PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 256 / 8, 128 / 8, 128 / 8 },</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* PSA_WANT_ALG_=
CBC_PKCS7 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if PSA=
_WANT_ALG_CTR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { =
&quot;AES-128-CTR&quot;, PSA_KEY_TYPE_AES, PSA_ALG_CTR, 128 / 8, 128 / 8, 1=
28 / 8 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quo=
t;AES-192-CTR&quot;, PSA_KEY_TYPE_AES, PSA_ALG_CTR, 192 / 8, 128 / 8, 128 /=
 8 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;AE=
S-256-CTR&quot;, PSA_KEY_TYPE_AES, PSA_ALG_CTR, 256 / 8, 128 / 8, 128 / 8 }=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* PSA_WANT=
_ALG_CTR */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /=
* PSA_WANT_KEY_TYPE_AES */</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-crypto_uninit_lib(void)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-crypto_clear_error(void)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-mbed_log_err(unsigned int flags, int errval, const char *prefix)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (0 !=3D errval)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        char errstr[256];</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        mbedtls_strerror(errval, errstr, sizeof(errstr));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (NULL =3D=3D prefix)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            prefix =3D &quot;mbed TLS error=
&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(flags, &quot;%=
s: %s&quot;, prefix, errstr);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0 =3D=3D errval;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbed_l=
og_func_line(unsigned int flags, int errval, const char *func, int line)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    char prefix[256];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (snprintf(prefix, sizeof(prefix), &quot;%s:%d&quot;, func=
, line) &gt;=3D sizeof(prefix))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return mbed_log_err(flags, errval, func);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbed=
_log_err(flags, errval, prefix);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
crypto_init_dmalloc(void)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_ERR, &=
quot;Error: dmalloc support is not available for mbed TLS.&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif /* DMALLOC */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-const cipher_name_pair cipher_name_translation_table[] =3D {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;BF-CBC&quot;, &quot;B=
LOWFISH-CBC&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   { &quot;BF-CFB&quot;, &quot;BLOWFISH-CFB64&quot; },</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    { &quot;CAMELLIA-128-CFB&quot;, &quot;=
CAMELLIA-128-CFB128&quot; },</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    { &quot;CAMELLIA-192-CFB&quot;, &quot;CAMELLIA-192-CFB128&quot; =
},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;CAMELLI=
A-256-CFB&quot;, &quot;CAMELLIA-256-CFB128&quot; }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Chacha-Poly */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if PSA_WANT_KEY_TYPE_CHACHA20 &amp;&amp; PSA_=
WANT_ALG_CHACHA20_POLY1305</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    { &quot;CHACHA20-POLY1305&quot;, PSA_KEY_TYPE_CHACHA20, PSA_ALG_=
CHACHA20_POLY1305, 256 / 8, 96 / 8, 1 },</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static const size_t cipher_info_table_entries =
=3D sizeof(cipher_info_table) / sizeof(cipher_info_t);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static const cipher_info_t *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+cipher_get(const char *ciphername)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; cipher_info_table_ent=
ries; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strcmp(ciph=
ername, cipher_info_table[i].name) =3D=3D 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return &amp;cipher_info_table[i];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Because Mbed TLS 4 d=
oesn&#39;t support looking up algorithms by string, there&#39;s</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * nothing to translate. */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+const cipher_name_pair =
cipher_name_translation_table[] =3D {};</span><br><span> const size_t ciphe=
r_name_translation_table_count =3D</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    sizeof(cipher_name_translation_table) / sizeof(*cipher_nam=
e_translation_table);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-show_available_ciphers(void)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const int *ciphers =3D mbedtls_cipher_list();</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;The following ciphers and =
cipher modes are available for use\n&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-           &quot;with &quot; PACKAGE_NAME &quot;.  Eac=
h cipher shown below may be used as a\n&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-           &quot;parameter to the --data-ciphers (o=
r --cipher) option.  Using a\n&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-           &quot;GCM or CBC mode is recommended.  In static =
key mode only CBC\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-           &quot;mode is allowed.\n\n&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    whil=
e (*ciphers !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const mbed=
tls_cipher_info_t *info =3D mbedtls_cipher_info_from_type(*ciphers);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *name =3D=
 mbedtls_cipher_info_get_name(info);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (info &amp;&amp; name &amp;&amp; !cipher_kt_insec=
ure(name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
&amp;&amp; (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            print_cipher(name);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ciphers++;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    prin=
tf(&quot;\nThe following ciphers have a block size of less than 128 bits, \=
n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &qu=
ot;and are therefore deprecated.  Do not use unless you have to.\n\n&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ciphers =3D mbed=
tls_cipher_list();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 while (*ciphers !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const=
 mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_type(*ciphers);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *nam=
e =3D mbedtls_cipher_info_get_name(info);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (info &amp;&amp; name &amp;&amp; cipher_kt_i=
nsecure(name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    &amp;&amp; (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            print_cipher(name);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        ciphers++;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    printf(&quot;\n&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-show_available_digests(void)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const int *digests =3D mbedtls_md_list();</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;The following message dige=
sts are available for use with\n&quot; PACKAGE_NAME</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-           &quot;.  A message digest is use=
d in conjunction with\n&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-           &quot;the HMAC function, to authenticate received packet=
s.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
&quot;You can specify a message digest as parameter to\n&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-           &quot;the --auth option=
.\n\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    while (*digests !=3D 0)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        const mbedtls_md_info_t *info =3D mbedtls_md_=
info_from_type(*digests);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (info)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            printf(&quot;%s %d bi=
t default key\n&quot;, mbedtls_md_get_name(info),</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                   mbedtls_md_get_size(info) * =
8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        digests++;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    printf(&quot;\n&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-show_available_engines(voi=
d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;Sorry, mbed TLS hardwa=
re crypto engine functionality is not &quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-           &quot;available\n&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-crypto_pem_encode(const char *name, struct buffer *dst, const struct =
buffer *src,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
         struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* 1000 =
chars is the PEM line length limit (+1 for tailing NUL) */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    char header[1000 + 1] =3D { 0 };</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char footer[1000 + =
1] =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (snprintf(header, size=
of(header), &quot;-----BEGIN %s-----\n&quot;, name) &gt;=3D sizeof(header))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (snprintf(footer, sizeof(footer), &quot;-----E=
ND %s-----\n&quot;, name) &gt;=3D sizeof(footer))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        return false;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t out_len =3D 0;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (MBEDTLS_ERR_B=
ASE64_BUFFER_TOO_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        !=3D mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src)=
, NULL, 0, &amp;out_len))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* We set the size buf to out_len-1 to NOT in=
clude the 0 byte that</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     * mbedtls_pem_write_buffer in its length calculation */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    *dst =3D alloc_buf_gc(out_len, g=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(m=
bedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), BPTR(dst),</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
                  BCAP(dst), &amp;out_len))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        || !buf_inc_len(dst, out_len - 1))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        CLEAR(*dst);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-crypto_pem_decode(const char *name, struct buffer *dst, const struct buffe=
r *src)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* 1000 chars is the PEM line =
length limit (+1 for tailing NUL) */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    char header[1000 + 1] =3D { 0 };</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    char footer[1000 + 1] =3D { 0 };</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (snprintf(header, sizeof(header), &quot;--=
---BEGIN %s-----&quot;, name) &gt;=3D sizeof(header))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (snprintf(footer, sizeof(footer), &quot;-----END %s-----&quot;, name=
) &gt;=3D sizeof(footer))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* mbed TLS requires the src to be null-termi=
nated */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* alloca=
te a new buffer to avoid modifying the src buffer */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer input =3D =
alloc_buf_gc(BLEN(src) + 1, &amp;gc);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    buf_copy(&amp;input, src);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    buf_null_terminate(&amp;input);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    size_t use_len =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    mbedtls_pem_context ctx =3D { 0 };</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        mbed_ok(mbedtls_pem_read_buffer(&=
amp;ctx, header, footer, BPTR(&amp;input), NULL, 0, &amp;use_len));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t buf_size =3D 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned char =
*buf =3D mbedtls_pem_get_buffer(&amp;ctx, &amp;buf_size);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (ret &amp;&amp; !buf_write(dst, =
buf, buf_size))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D false;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &=
quot;PEM decode error: destination buffer too small&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    mbedtls_pem_free(&amp;ctx);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * Random number functions, used in cases where we want</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * reasonably strong cryptographic rando=
m number generation</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 without depleting our entropy pool.  Used for random</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * IV values and a number of other miscella=
neous tasks.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Initiali=
se the given ctr_drbg context, using a personalisation string and an</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * entropy gathering functio=
n.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-mbedtls_ctr_drbg_context *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-rand_ctx_get(void)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    static mbedtls_entropy_context ec =3D { 0 };</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    static mbedtls_ctr_drbg_=
context cd_ctx =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    static bool rand_initialised =3D false;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!rand_initialised)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        struct buffer pers_string =3D alloc_buf_gc(100, &amp;g=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         * Personalisation string, should be as un=
ique as possible (see NIST</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-         * 800-90 section 8.7.1). We have very little information at t=
his stage.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * =
Include Program Name, memory address of the context and PID.</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;pers_string, &quot;Ope=
nVPN %0u %p %s&quot;, platform_getpid(), &amp;cd_ctx,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                   time_string(0, 0, 0, &am=
p;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* Initialise mbed TLS RNG,=
 and built-in entropy sources */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        mbedtls_entropy_init(&amp;ec);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        mbedtls_ctr_drbg_init(&amp;cd_ctx);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (!mbed_ok(mbedtls_ctr_drbg_seed(&am=
p;cd_ctx, mbedtls_entropy_func, &amp;ec, BPTR(&amp;pers_string),</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
           BLEN(&amp;pers_string))))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(M_FATAL, &quot;Failed to initialize random generator&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        rand_initialised =3D true;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return &amp;cd_ctx;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICTION_RESISTANC=
E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-rand_ctx_enable_prediction_resistance=
(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_context *cd_ct=
x =3D rand_ctx_get();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_=
set_prediction_resistance(cd_ctx, 1);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* ENABLE_PREDICTION_RESISTANCE */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    sizeof(cipher_name_translation_table) / sizeof(cipher=
_name_pair);</span><br><span> </span><br><span> int</span><br><span> rand_b=
ytes(uint8_t *output, int len)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_context *rng_ctx =3D rand_=
ctx_get();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    while (len &gt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
const size_t blen =3D min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (0 !=3D mbedtls_ctr_=
drbg_random(rng_ctx, output, blen))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        output +=3D blen;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        len -=3D blen;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * Generic cipher key type functions</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static const mbedtls_cipher_info_t *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-cipher_get(const char *ciphername)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ASSERT(ciphername);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    const mbedtls_cipher_info_t *cipher =3D NULL;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ciphername =3D translate_cipher_name_from_openvpn(cipherna=
me);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cipher =3D mb=
edtls_cipher_info_from_string(ciphername);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return cipher;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    psa_status_t result =3D psa_generate_random(output,=
 (size_t)len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn result =3D=3D PSA_SUCCESS;</span><br><span> }</span><br><span> </span=
><br><span> bool</span><br><span>@@ -414,23 +148,22 @@</span><br><span> {</=
span><br><span>     ASSERT(reason);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher =3D=
 cipher_get(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (N=
ULL =3D=3D cipher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (cipher_info =3D=3D NULL)</span><br><span>     {</span><br><span>    =
     msg(D_LOW, &quot;Cipher algorithm &#39;%s&#39; not found&quot;, cipher=
name);</span><br><span>         *reason =3D &quot;disabled because unknown&=
quot;;</span><br><span>         return false;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
size_t key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(cipher) / 8;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (key_bytelen &gt; M=
AX_CIPHER_KEY_LENGTH)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (cipher_info-&gt;key_bytes &gt; MAX_CIPHER_KEY_LENGTH)</span><br><=
span>     {</span><br><span>         msg(D_LOW,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            &quot;Cipher algorithm &#39;%s&#39; u=
ses a default key size (%zu bytes) &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;Cipher algorithm &#39;%s&#39; uses =
a default key size (%d bytes) &quot;</span><br><span>             &quot;whi=
ch is larger than &quot; PACKAGE_NAME &quot;&#39;s current maximum key size=
 &quot;</span><br><span>             &quot;(%d bytes)&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            ciphername, key_bytelen,=
 MAX_CIPHER_KEY_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ciphername, cipher_info-&gt;key_bytes, MAX_CIPHER_KEY_LENG=
TH);</span><br><span>         *reason =3D &quot;disabled due to key size to=
o large&quot;;</span><br><span>         return false;</span><br><span>     =
}</span><br><span>@@ -442,49 +175,46 @@</span><br><span> const char *</span=
><br><span> cipher_kt_name(const char *ciphername)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_in=
fo_t *cipher_kt =3D cipher_get(ciphername);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (NULL =3D=3D cipher_kt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const cipher_info_t *cipher_info =3D =
cipher_get(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (cipher_info =3D=3D NULL)</span><br><span>     {</span><br><span=
>         return &quot;[null-cipher]&quot;;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return translate_cipher_name_to_openvpn(mbedtls=
_cipher_info_get_name(cipher_kt));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return cipher_info-&gt;name;</span><br><span> }</span><b=
r><span> </span><br><span> int</span><br><span> cipher_kt_key_size(const ch=
ar *ciphername)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciph=
ername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D cipher_kt)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cipher_info_t=
 *cipher_info =3D cipher_get(ciphername);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (cipher_info =3D=3D NULL)</span><br><span>    =
 {</span><br><span>         return 0;</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return (int)mbedtls_cipher_info_get_key_bitlen(cipher=
_kt) / 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 cipher_info-&gt;key_bytes;</span><br><span> }</span><br><span> </span><br>=
<span> int</span><br><span> cipher_kt_iv_size(const char *ciphername)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const cipher_info_t *cipher_=
info =3D cipher_get(ciphername);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D cipher_kt)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_info =3D=3D NULL)</s=
pan><br><span>     {</span><br><span>         return 0;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)mb=
edtls_cipher_info_get_iv_size(cipher_kt);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return cipher_info-&gt;iv_bytes;</span><br><span>=
 }</span><br><span> </span><br><span> int</span><br><span> cipher_kt_block_=
size(const char *ciphername)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher_kt =3D ci=
pher_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (NULL =3D=3D cipher_kt)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_info=
 =3D=3D NULL)</span><br><span>     {</span><br><span>         return 0;</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return (int)mbedtls_cipher_info_get_block_size(cipher_kt);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return cipher_info-&gt;block_s=
ize;</span><br><span> }</span><br><span> </span><br><span> int</span><br><s=
pan>@@ -500,498 +230,596 @@</span><br><span> bool</span><br><span> cipher_k=
t_insecure(const char *ciphername)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher_kt =
=3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (!cipher_kt)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_info =3D=
=3D NULL)</span><br><span>     {</span><br><span>         return true;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return !(cipher_kt_block_size(ciphername) &gt;=3D 128 / =
8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef MBEDTLS_CHACH=
APOLY_C</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             |=
| mbedtls_cipher_info_get_type(cipher_kt) =3D=3D MBEDTLS_CIPHER_CHACHA20_PO=
LY1305</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    );</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static mb=
edtls_cipher_mode_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ci=
pher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ASSERT(NULL !=3D cipher_kt);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return mbedtls_cipher_info_get_mode(cipher_kt);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return !(cipher_=
info-&gt;block_size &gt;=3D 128 / 8</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             || cipher_info-&gt;psa_alg =3D=3D PSA_ALG_CHAC=
HA20_POLY1305);</span><br><span> }</span><br><span> </span><br><span> bool<=
/span><br><span> cipher_kt_mode_cbc(const char *ciphername)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_=
cipher_info_t *cipher =3D cipher_get(ciphername);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return cipher &amp;&amp; cipher_kt_mode(cip=
her) =3D=3D OPENVPN_MODE_CBC;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const cipher_info_t *cipher_info =3D cipher_get(ciphername);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_info =
=3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return cipher_info-&gt;psa_al=
g =3D=3D PSA_ALG_CBC_PKCS7;</span><br><span> }</span><br><span> </span><br>=
<span> bool</span><br><span> cipher_kt_mode_ofb_cfb(const char *ciphername)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; (cipher_kt_mo=
de(cipher) =3D=3D OPENVPN_MODE_OFB</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-               || cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_C=
FB);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ciphe=
r_info_t *cipher_info =3D cipher_get(ciphername);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (cipher_info =3D=3D NULL)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return cipher_info-&gt;psa_alg =3D=3D PSA_ALG_OFB || c=
ipher_info-&gt;psa_alg =3D=3D PSA_ALG_CFB;</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span> cipher_kt_mode_aead(const char =
*ciphername)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; (=
cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_GCM</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-               || cipher_kt_mode(cipher) =
=3D=3D MBEDTLS_MODE_CHACHAPOLY</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
     );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ci=
pher_info_t *cipher_info =3D cipher_get(ciphername);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (cipher_info =3D=3D NULL)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return cipher_info-&gt;psa_alg =3D=3D PSA_ALG_GCM=
 || cipher_info-&gt;psa_alg =3D=3D PSA_ALG_CHACHA20_POLY1305;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * Generic cipher context functions</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_cipher_context_t *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_t *</spa=
n><br><span> cipher_ctx_new(void)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mbedtls_cipher_context_t *ctx;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ(ctx, mbedtls_cip=
her_context_t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
cipher_ctx_t *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* Initializing the object with zeros ensures that it is always safe to =
call</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * cipher_c=
tx_free. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLO=
C_OBJ_CLEAR(ctx, cipher_ctx_t);</span><br><span>     return ctx;</span><br>=
<span> }</span><br><span> </span><br><span> void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-cipher_ctx_free(mbedtls_cipher_context_t *ctx)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_free(ciphe=
r_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    mbedtls_cipher_free(ctx);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (cipher_ctx_mode_aead(ctx))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        ASSERT(psa_aead_abort(&amp;ctx-&gt;operation.=
aead) =3D=3D PSA_SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(psa_cipher_abort(=
&amp;ctx-&gt;operation.cipher) =3D=3D PSA_SUCCESS);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASSERT(psa_destroy_key(ctx-&gt;key) =3D=3D PSA_SUCC=
ESS);</span><br><span>     free(ctx);</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, const ch=
ar *ciphername,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ciph=
er_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, const char *ciphername,<=
/span><br><span>                 crypto_operation_t enc)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D =
ciphername &amp;&amp; NULL !=3D ctx);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ASSERT(ciphername !=3D NULL &amp;&amp; ctx !=3D NULL)=
;</span><br><span>     CLEAR(*ctx);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *kt =3D cip=
her_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ASSERT(kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    siz=
e_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(kt);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;cipher_info =3D cipher_g=
et(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ASSERT(ctx-&gt;cipher_info !=3D NULL);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_setup(ct=
x, kt)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;mb=
ed TLS cipher context init #1&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    psa_set_key_type(&amp;ctx-&gt;key_attributes, ctx-&gt;cipher_info-&gt=
;psa_key_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
psa_set_key_algorithm(&amp;ctx-&gt;key_attributes, ctx-&gt;cipher_info-&gt;=
psa_alg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_se=
t_key_bits(&amp;ctx-&gt;key_attributes, (size_t)ctx-&gt;cipher_info-&gt;key=
_bytes * 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa=
_set_key_usage_flags(&amp;ctx-&gt;key_attributes,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            enc =3D=3D OPENVP=
N_OP_ENCRYPT ? PSA_KEY_USAGE_ENCRYPT : PSA_KEY_USAGE_DECRYPT);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok=
(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, enc)))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (psa_import_key(&amp;ctx-&gt;ke=
y_attributes, key, (size_t)ctx-&gt;cipher_info-&gt;key_bytes, &amp;ctx-&gt;=
key) !=3D PSA_SUCCESS)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;mbed TLS cipher set key&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (mbedtls_cipher_info_get_mode(kt) =3D=3D MBE=
DTLS_MODE_CBC)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!mbed_ok(mb=
edtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_PKCS7)))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;mbed TLS cipher se=
t padding mode&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(M_FATAL, &quot;psa_import_key failed&quot;);</span><br><span>     }</spa=
n><br><span> </span><br><span>     /* make sure we used a big enough key */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mbedtls_ci=
pher_get_key_bitlen(ctx) &lt;=3D key_bitlen);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(psa_get_key_bits(&amp;ctx-&gt;key_attr=
ibutes) =3D=3D (size_t)(8 * ctx-&gt;cipher_info-&gt;key_bytes));</span><br>=
<span> }</span><br><span> </span><br><span> int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-cipher_ctx_iv_length(const mbedtls_cipher_context=
_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_=
iv_length(const cipher_ctx_t *ctx)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_get_iv_size(ctx);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctx-&gt;=
cipher_info-&gt;iv_bytes;</span><br><span> }</span><br><span> </span><br><s=
pan> int</span><br><span> cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *ta=
g, int tag_len)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (tag_len &gt; SIZE_MAX)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!ctx-&gt;aead_finished || tag_len &lt; OPEN=
VPN_AEAD_TAG_LENGTH)</span><br><span>     {</span><br><span>         return=
 0;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_write_tag(ctx, (unsi=
gned char *)tag, tag_len)))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    memcpy(tag, ctx-&gt;tag, OPENVPN_AEAD_TAG_LEN=
GTH);</span><br><span>     return 1;</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ci=
pher_ctx_block_size(const mbedtls_cipher_context_t *ctx)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_block_size(const cipher_ctx=
_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return (int)mbedtls_cipher_get_block_size(ctx);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return ctx-&gt;cipher_info-&gt;bl=
ock_size;</span><br><span> }</span><br><span> </span><br><span> int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_mode(const mbedtls=
_cipher_context_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+cipher_ctx_mode(const cipher_ctx_t *ctx)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ctx);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return mbedtls_cipher_get_cipher_mode(ctx);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ctx !=3D N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (in=
t)psa_get_key_algorithm(&amp;ctx-&gt;key_attributes);</span><br><span> }</s=
pan><br><span> </span><br><span> bool</span><br><span> cipher_ctx_mode_cbc(=
const cipher_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return ctx &amp;&amp; cipher_ctx_mode(ctx) =3D=3D=
 OPENVPN_MODE_CBC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return ctx !=3D NULL &amp;&amp; cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE=
_CBC;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> cipher_ctx_mod=
e_ofb_cfb(const cipher_ctx_t *ctx)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return ctx</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-           &amp;&amp; (cipher_ctx_mode(ctx) =3D=3D=
 OPENVPN_MODE_OFB</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
           || cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CFB);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (ctx =3D=3D NULL)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int mode =3D cipher_ctx_mode(ctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return mode =3D=3D OPENVPN_MOD=
E_OFB || mode =3D=3D OPENVPN_MODE_CFB;</span><br><span> }</span><br><span> =
</span><br><span> bool</span><br><span> cipher_ctx_mode_aead(const cipher_c=
tx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return ctx</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-           &amp;&amp; (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_GCM</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef MBEDTLS_CHACHAPOLY_C<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-               || ciph=
er_ctx_mode(ctx) =3D=3D MBEDTLS_MODE_CHACHAPOLY</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-           );</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (ctx =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int mode =3D=
 cipher_ctx_mode(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return mode =3D=3D (int)PSA_ALG_GCM || mode =3D=3D (int)PSA_ALG_CHAC=
HA20_POLY1305;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+cipher_ctx_direction(const cipher_ctx_t *ctx)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    psa_key_usage_t key_usage =3D psa_get=
_key_usage_flags(&amp;ctx-&gt;key_attributes);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (key_usage &amp; PSA_KEY_USAGE_ENCRYPT)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return OPENVPN_OP_ENCRYPT;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else if (key_usage &amp; PSA_K=
EY_USAGE_DECRYPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return O=
PENVPN_OP_DECRYPT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span>=
 </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-cipher_ctx_reset(mbedtls_cipher_context_t *ctx, const uint8_t *iv_buf)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_reset(cipher=
_ctx_t *ctx, const uint8_t *iv_buf)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_reset(ctx)=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    psa_status_t status =3D 0;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_c=
ipher_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx))))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_ctx_mode_ae=
ad(ctx))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (psa_aead_abort(&amp;ctx-&gt;operation.aead) !=3D PSA_SU=
CCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (cipher_ctx_direction(ctx) =3D=3D OPENV=
PN_OP_ENCRYPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sta=
tus =3D psa_aead_encrypt_setup(&amp;ctx-&gt;operation.aead, ctx-&gt;key, ct=
x-&gt;cipher_info-&gt;psa_alg);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        else if (cipher_ctx_direction(ctx) =3D=3D OPENVPN_OP_DECRYPT)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            status =3D psa_aead_d=
ecrypt_setup(&amp;ctx-&gt;operation.aead, ctx-&gt;key, ctx-&gt;cipher_info-=
&gt;psa_alg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (status !=3D PSA_SUCCESS)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     status =3D psa_aead_set_nonce(&amp;ctx-&gt;operation.aead, iv_buf, ctx=
-&gt;cipher_info-&gt;iv_bytes);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (status !=3D PSA_SUCCESS)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (psa_cipher_abort=
(&amp;ctx-&gt;operation.cipher) !=3D PSA_SUCCESS)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (cipher_ctx_direction(ctx) =3D=3D OPENVPN_OP_ENCRYPT)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            status =3D psa_cipher_encrypt_setup=
(&amp;ctx-&gt;operation.cipher, ctx-&gt;key, ctx-&gt;cipher_info-&gt;psa_al=
g);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (cipher_ct=
x_direction(ctx) =3D=3D OPENVPN_OP_DECRYPT)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            status =3D psa_cipher_decrypt_setup(&amp;ctx-&gt;=
operation.cipher, ctx-&gt;key, ctx-&gt;cipher_info-&gt;psa_alg);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (status !=3D PSA_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D psa_cipher=
_set_iv(&amp;ctx-&gt;operation.cipher, iv_buf, ctx-&gt;cipher_info-&gt;iv_b=
ytes);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (s=
tatus !=3D PSA_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span>     }</span><br><span> </span><br><span>     return =
1;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* We rely on the caller to ensure that the destination=
 buffer has enough room,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * but Mbed TLS always wants a size for the destination buffer. This f=
unction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * calculate=
s the minimum necessary size for a given cipher and input length.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * This funcion assumes that src_len has been =
checked to be &gt;=3D 0. */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+needed_dst_size(const cipher_ctx_t *ctx, int src_len)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int mode =3D cipher_ctx_mode(ctx);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (mode =3D=3D PSA_ALG_CTR || mod=
e =3D=3D PSA_ALG_GCM || mode =3D=3D PSA_ALG_CHACHA20_POLY1305)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* These algorithms are based on a key=
stream, so the input and output</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * length are always equal. */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return (size_t)src_len;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* These algorithms are block-based. The number of output block=
s that are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* produced is at most 1 + src_len / block_size. */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        size_t block_size =3D (size_t)cipher=
_ctx_block_size(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        size_t max_blocks =3D 1 + (size_t)src_len / block_size;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return max_blocks * b=
lock_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> ci=
pher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(src_len &gt; SIZE_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (src_len &lt; 0 || !cipher_ctx_mode_aead(ctx))</span><br><span> =
    {</span><br><span>         return 0;</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_o=
k(mbedtls_cipher_update_ad(ctx, src, src_len)))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (psa_aead_update_ad(&amp;ctx-&gt;operati=
on.aead, src, (size_t)src_len) !=3D PSA_SUCCESS)</span><br><span>     {</sp=
an><br><span>         return 0;</span><br><span>     }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return 1;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_update(cipher=
_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (src_len &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t dst_=
size =3D needed_dst_size(ctx, src_len);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    size_t psa_output_len =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    psa_status_t status =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (cipher_ctx_mode_aead(ctx))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        status =3D psa_aead_update(&amp;ctx-&gt;=
operation.aead, src, (size_t)src_len, dst, dst_size, &amp;psa_output_len);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        status =3D psa_cipher_update(&amp;ctx-&gt;operation=
.cipher, src, (size_t)src_len, dst, dst_size, &amp;psa_output_len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (status !=3D PSA_SUCCESS)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (psa_output_le=
n &gt; INT_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    *dst_len =3D (int)psa_output_l=
en;</span><br><span> </span><br><span>     return 1;</span><br><span> }</sp=
an><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst=
, int *dst_len, uint8_t *src,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                  int src_len)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+cipher_ctx_final(cipher_ctx_t *ctx, uint8_t *dst, int *d=
st_len)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    size_t s_dst_len =3D *dst_len;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    size_t dst_size =3D needed_dst_size(ctx, 0);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t psa_output_len =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_statu=
s_t status =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t)src_=
len, dst, &amp;s_dst_len)))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (cipher_ctx_mode_aead(ctx))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        size_t actual_tag_size =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        statu=
s =3D psa_aead_finish(&amp;ctx-&gt;operation.aead,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                 dst,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
       dst_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                              &amp;psa_output_len,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                 ctx-&gt;tag=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
               (size_t)OPENVPN_AEAD_TAG_LENGTH,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                 &amp;actual_ta=
g_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(status !=3D PSA_SUCCESS || psa_output_len &gt; (size_t)INT_MAX || actual_t=
ag_size !=3D (size_t)OPENVPN_AEAD_TAG_LENGTH)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        ctx-&gt;aead_finished =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sta=
tus =3D psa_cipher_finish(&amp;ctx-&gt;operation.cipher, dst, dst_size, &am=
p;psa_output_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (status !=3D PSA_SUCCESS || psa_output_len &gt; (size_t)INT_MAX)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    *dst_len =3D s_dst_len;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    *dst_len =3D (int)psa_output_len;</span><br><span> </span><br>=
<span>     return 1;</span><br><span> }</span><br><span> </span><br><span> =
int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_final(m=
bedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_final_check_tag(cipher_ctx=
_t *ctx, uint8_t *dst, int *dst_len, uint8_t *tag, size_t tag_len)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t =
s_dst_len =3D *dst_len;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mb=
edtls_cipher_finish(ctx, dst, &amp;s_dst_len)))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (cipher_ctx_direction(ctx) !=3D OPENVPN_=
OP_DECRYPT || !cipher_ctx_mode_aead(ctx))</span><br><span>     {</span><br>=
<span>         return 0;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    *dst_len =3D s_dst_len;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t psa_output_l=
en =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_st=
atus_t status =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D psa=
_aead_verify(&amp;ctx-&gt;operation.aead, dst, 0, &amp;psa_output_len, tag,=
 tag_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (s=
tatus !=3D PSA_SUCCESS || psa_output_len &gt; (size_t)INT_MAX)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    *dst_len =3D (int)psa_output_len;</span><br><span> </span>=
<br><span>     return 1;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-cipher_ctx_final_check_tag(mbedtls_cipher_context_t *=
ctx, uint8_t *dst, int *dst_len, uint8_t *tag,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                           size_t tag_len)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static const md_info_t md_i=
nfo_table[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* TODO: Fill out table. */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    { &quot;MD5&quot;, PSA_ALG_MD5 },</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    { &quot;SHA1&quot;, PSA_ALG_SHA_1 },</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;SHA256&quot;, =
PSA_ALG_SHA_256 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const size_t md_in=
fo_table_entries =3D sizeof(md_info_table) / sizeof(md_info_t);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static const md_info_t *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+md_get(const char *digest_name)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t olen =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (MBEDTLS_DECRYPT !=3D mbedtls=
_cipher_get_operation(ctx))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (size_t i =3D 0; i &lt; md_info_table_entries; i++)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (strcmp(digest_name, md_info_table[i].name) =3D=3D 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return &amp;md_info_table[i];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>=
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (tag_len &gt; SIZE_MAX)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
mbed_ok(mbedtls_cipher_finish(ctx, dst, &amp;olen)))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(D_CRYPT_ERRORS, &quot;%s: cipher_ctx_final() fa=
iled&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (olen &gt; INT_MAX)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    *dst_len =3D olen;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok=
(mbedtls_cipher_check_tag(ctx, (const unsigned char *)tag, tag_len)))</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * Generic message digest info=
rmation functions</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static c=
onst mbedtls_md_info_t *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-md_get(const char *digest)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mb=
edtls_md_info_t *md =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ASSERT(digest);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    md =3D mbed=
tls_md_info_from_string(digest);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!md)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_=
FATAL, &quot;Message hash algorithm &#39;%s&#39; not found&quot;, digest);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (mbedtls_md_get_size(md) &gt; M=
AX_HMAC_KEY_LENGTH)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATA=
L,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;M=
essage hash algorithm &#39;%s&#39; uses a default hash size (%d bytes) whic=
h is larger than &quot; PACKAGE_NAME</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            &quot;&#39;s current maximum hash size (%d bytes=
)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            d=
igest, mbedtls_md_get_size(md), MAX_HMAC_KEY_LENGTH);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return md;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return NULL;</span><br><span> }</span><br><span> </span><br>=
<span> bool</span><br><span> md_valid(const char *digest)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_md=
_info_t *md =3D mbedtls_md_info_from_string(digest);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const md_info_t *md =3D md_get(digest=
);</span><br><span>     return md !=3D NULL;</span><br><span> }</span><br><=
span> </span><br><span> const char *</span><br><span> md_kt_name(const char=
 *mdname)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (!strcmp(&quot;none&quot;, mdname))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (strcmp(&quot;none&quot;, mdname) =3D=
=3D 0)</span><br><span>     {</span><br><span>         return &quot;[null-d=
igest]&quot;;</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const mbedtls_md_info_t *kt =3D md_get(mdname);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_md_get_name=
(kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const md_i=
nfo_t *md =3D md_get(mdname);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (md =3D=3D NULL)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return md=
-&gt;name;</span><br><span> }</span><br><span> </span><br><span> unsigned c=
har</span><br><span> md_kt_size(const char *mdname)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!strcmp(&quot;none=
&quot;, mdname))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (strcmp(&quot;none&quot;, mdname) =3D=3D 0)</span><br><span>     {</spa=
n><br><span>         return 0;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_md_info_t *kt =3D md_get(=
mdname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mb=
edtls_md_get_size(kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const md_info_t *md_info =3D md_get(mdname);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (md_info =3D=3D NULL)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return (unsigned char)PSA_HASH_LENGTH(md_info-&gt;psa_alg)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Generic message di=
gest functions</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+md_ctx_t *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+md_ctx_new(void)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    md_ctx_t *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ALLOC_OBJ_CLEAR(ctx, md_ctx_t);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return ctx;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span> </span><br><span> int</span><br><span> md=
_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
onst mbedtls_md_info_t *kt =3D md_get(mdname);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    return 0 =3D=3D mbedtls_md(kt, src, src_len, d=
st);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const md_info_t *md =3D md_get(=
mdname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (md =
=3D=3D NULL || src_len &lt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbe=
dtls_md_context_t *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md=
_ctx_new(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_context_t *c=
tx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ_CLEA=
R(ctx, mbedtls_md_context_t);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* We depend on the caller to ensure that dst has enough room for t=
he hash,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * so w=
e just tell PSA that it can hold the appropriate amount of bytes. */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t dst_size =3D PS=
A_HASH_LENGTH(md-&gt;psa_alg);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    size_t hash_length =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    psa_status_t status =3D psa_hash_compute(md-&gt;psa_alg, src, (size_t=
)src_len, dst, dst_size, &amp;hash_length);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (status !=3D PSA_SUCCESS || hash_length !=3D=
 dst_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return 1;</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-md_ctx_free(mbedtls_md_context_t *ctx)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+md_ctx_free(md_ctx_t *ctx)</span><br><span> =
{</span><br><span>     free(ctx);</span><br><span> }</span><br><span> </spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_c=
tx_init(mbedtls_md_context_t *ctx, const char *mdname)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+md_ctx_init(md_ctx_t *ctx, const char *m=
dname)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    const mbedtls_md_info_t *kt =3D md_get(mdname);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ctx &amp;&amp; NULL =
!=3D kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
md_info_t *md_info =3D md_get(mdname);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ASSERT(ctx !=3D NULL &amp;&amp; md_info !=3D NULL);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
mbedtls_md_init(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 0));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_starts(ctx));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;md_info =
=3D md_info;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(psa_hash_setup(&amp;ctx-&gt;operation, md_info-&gt;psa_alg) =3D=3D PSA_=
SUCCESS);</span><br><span> }</span><br><span> </span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_cleanup(mbedtls_md_co=
ntext_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx=
_cleanup(md_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    mbedtls_md_free(ctx);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ASSERT(psa_hash_abort(&amp;ctx-&gt;operation=
) =3D=3D PSA_SUCCESS);</span><br><span> }</span><br><span> </span><br><span=
> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_size(cons=
t mbedtls_md_context_t *ctx)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+md_ctx_size(const md_ctx_t *ctx)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D ctx)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (ctx =3D=3D NULL)</span>=
<br><span>     {</span><br><span>         return 0;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)mbedtl=
s_md_get_size(mbedtls_md_info_from_ctx(ctx));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return (int)PSA_HASH_LENGTH(ctx-&gt;md_info-&=
gt;psa_alg);</span><br><span> }</span><br><span> </span><br><span> void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_update(mbedtls_md_=
context_t *ctx, const uint8_t *src, size_t src_len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+md_ctx_update(md_ctx_t *ctx, const uint8_=
t *src, size_t src_len)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_update(ctx, src, src_le=
n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(psa_=
hash_update(&amp;ctx-&gt;operation, src, src_len) =3D=3D PSA_SUCCESS);</spa=
n><br><span> }</span><br><span> </span><br><span> void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-md_ctx_final(mbedtls_md_context_t *ctx, ui=
nt8_t *dst)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_f=
inal(md_ctx_t *ctx, uint8_t *dst)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_finish(ctx, =
dst));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_=
free(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We=
 depend on the caller to ensure that dst has enough room for the hash,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * so we just tell P=
SA that it can hold the appropriate amount of bytes. */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    size_t dst_size =3D PSA_HASH_LENGTH=
(ctx-&gt;md_info-&gt;psa_alg);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    size_t hash_length =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ASSERT(psa_hash_finish(&amp;ctx-&gt;operation, dst, dst_size, &amp;ha=
sh_length) =3D=3D PSA_SUCCESS);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ASSERT(hash_length =3D=3D dst_size);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Generic HMAC functions</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * TODO:=
 re-enable dmsg for crypto debug</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_md_context_t *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_t *</span><br><s=
pan> hmac_ctx_new(void)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    mbedtls_md_context_t *ctx;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ(ctx, mbedtls_md_context_t);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_t *ctx;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(=
ctx, hmac_ctx_t);</span><br><span>     return ctx;</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-hmac_ctx_free(mbedtls_md_context_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_free(hmac_ctx_t *ctx)</span><br>=
<span> {</span><br><span>     free(ctx);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_init(mbedtls_md_context_t *=
ctx, const uint8_t *key, const char *mdname)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+hmac_ctx_init_with_arbitrary_key_length(hmac_ctx_t *ctx, c=
onst uint8_t *key, size_t key_len, const md_info_t *md_info)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls=
_md_info_t *kt =3D md_get(mdname);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ASSERT(NULL !=3D kt &amp;&amp; NULL !=3D ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;md_info =3D md_info=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_set_key_ty=
pe(&amp;ctx-&gt;key_attributes, PSA_KEY_TYPE_HMAC);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    psa_set_key_algorithm(&amp;ctx-&gt;ke=
y_attributes, PSA_ALG_HMAC(md_info-&gt;psa_alg));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    psa_set_key_usage_flags(&amp;ctx-&gt;key_=
attributes, PSA_KEY_USAGE_SIGN_MESSAGE);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_init(ctx);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    int key_len =3D mbedtls_md_get=
_size(kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(=
0 =3D=3D mbedtls_md_setup(ctx, kt, 1));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, key, key_=
len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (psa_i=
mport_key(&amp;ctx-&gt;key_attributes, key, key_len, &amp;ctx-&gt;key) !=3D=
 PSA_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,=
 &quot;psa_import_key failed&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /* make sure we used a big enough key */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mbedtls_md_get_size(kt=
) &lt;=3D key_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(psa_mac_sign_setup(&amp;ctx-&gt;operation, ctx-&gt;key, PSA_ALG_=
HMAC(md_info-&gt;psa_alg)) =3D=3D PSA_SUCCESS);</span><br><span> }</span><b=
r><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-hmac_ctx_cleanup(mbedtls_md_context_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_init(hmac_ctx_t *ctx, const uint=
8_t *key, const char *mdname)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    mbedtls_md_free(ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const md_info_t *md_info =3D md_get(m=
dname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(c=
tx !=3D NULL &amp;&amp; key !=3D NULL &amp;&amp; md_info !=3D NULL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    hmac_ctx_init_with_arbitrary_key_length(c=
tx, key, PSA_HASH_LENGTH(md_info-&gt;psa_alg), md_info);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_cleanu=
p(hmac_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(psa_mac_=
abort(&amp;ctx-&gt;operation) =3D=3D PSA_SUCCESS);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ASSERT(psa_destroy_key(ctx-&gt;key) =3D=
=3D PSA_SUCCESS);</span><br><span> }</span><br><span> </span><br><span> int=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_size(mbedtls=
_md_context_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
hmac_ctx_size(hmac_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D ctx)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return (int)PSA_HASH_LENGTH(ctx-=
&gt;md_info-&gt;psa_alg);</span><br><span> }</span><br><span> </span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_res=
et(mbedtls_md_context_t *ctx)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+hmac_ctx_reset(hmac_ctx_t *ctx)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_=
reset(ctx));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(psa_mac_abort(&amp;ctx-&gt;operation) =3D=3D PSA_SUCCESS);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(psa_mac_sign_setup(&a=
mp;ctx-&gt;operation, ctx-&gt;key, PSA_ALG_HMAC(ctx-&gt;md_info-&gt;psa_alg=
)) =3D=3D PSA_SUCCESS);</span><br><span> }</span><br><span> </span><br><spa=
n> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_updat=
e(mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_update(hmac_ctx_t *ctx, =
const uint8_t *src, int src_len)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_update(=
ctx, src, src_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(src_len &gt;=3D 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ASSERT(psa_mac_update(&amp;ctx-&gt;operation, src, (size_t)=
src_len) =3D=3D PSA_SUCCESS);</span><br><span> }</span><br><span> </span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx=
_final(mbedtls_md_context_t *ctx, uint8_t *dst)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+hmac_ctx_final(hmac_ctx_t *ctx, uint8_t *dst)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ASSERT(0 =3D=3D mbedtls_md_hmac_finish(ctx, dst));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* We depend on the caller to ensure tha=
t dst has enough room for the hash,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * so we just tell PSA that it can hold the appropriate=
 amount of bytes. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    size_t dst_size =3D PSA_HASH_LENGTH(ctx-&gt;md_info-&gt;psa_alg);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t hmac_length =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(psa_mac_sign_finish(&=
amp;ctx-&gt;operation, dst, dst_size, &amp;hmac_length) =3D=3D PSA_SUCCESS)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hmac_le=
ngth =3D=3D dst_size);</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-memcmp_constant_time(const void *a, const void *b, size=
_t size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* mbed TLS has a no const ti=
me memcmp function that it exposes</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     * via its APIs like OpenSSL does with CRYPTO_memcmp</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Adapt the function t=
hat mbedtls itself uses in</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     * mbedtls_safer_memcmp as it considers that to be safe */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    volatile const unsigned c=
har *A =3D (volatile const unsigned char *)a;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    volatile const unsigned char *B =3D (volatile c=
onst unsigned char *)b;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    volatile unsigned char diff =3D 0;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  for (size_t i =3D 0; i &lt; size; i++)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        unsigned char x =3D A[i], y =3D B[i];</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        diff |=3D x ^ y;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn diff;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic =
ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> /*</span><br><span>  * Generate the hash required by for the =
\c tls1_PRF function.</span><br><span>  *</span><br><span>@@ -1004,8 +832,8=
 @@</span><br><span>  * @param olen          Length of the output buffer</s=
pan><br><span>  */</span><br><span> static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-tls1_P_hash(const mbedtls_md_info_t *md_kt, const=
 uint8_t *sec, size_t sec_len, const uint8_t *seed,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            size_t seed_len, uint8_t *out, =
size_t olen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls1_P_=
hash(const md_info_t *md_info, const uint8_t *sec, size_t sec_len, const ui=
nt8_t *seed,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     int seed_len, uint8_t *out, size_t olen)</span><br><span> {</span><br>=
<span>     struct gc_arena gc =3D gc_new();</span><br><span>     uint8_t A1=
[MAX_HMAC_KEY_LENGTH];</span><br><span>@@ -1023,18 +851,13 @@</span><br><sp=
an>     dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_P_hash sec: %s&quot;, format_hex=
(sec, sec_len, 0, &amp;gc));</span><br><span>     dmsg(D_SHOW_KEY_SOURCE, &=
quot;tls1_P_hash seed: %s&quot;, format_hex(seed, seed_len, 0, &amp;gc));</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    u=
nsigned int chunk =3D mbedtls_md_get_size(md_kt);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    unsigned int A1_len =3D mbedtls_md_get_size=
(md_kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigne=
d int chunk =3D (unsigned int)PSA_HASH_LENGTH(md_info-&gt;psa_alg);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int A1_len =3D=
 (unsigned int)PSA_HASH_LENGTH(md_info-&gt;psa_alg);</span><br><span> </spa=
n><br><span>     /* This is the only place where we init an HMAC with a key=
 that is not</span><br><span>      * equal to its size, therefore we init t=
he hmac ctx manually here */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    mbedtls_md_init(ctx);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, md_kt, 1));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_h=
mac_starts(ctx, sec, sec_len));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls=
_md_init(ctx_tmp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 ASSERT(0 =3D=3D mbedtls_md_setup(ctx_tmp, md_kt, 1));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_starts=
(ctx_tmp, sec, sec_len));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    hmac_ctx_init_with_arbitrary_key_length(ctx, sec, sec_len, md_inf=
o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_ini=
t_with_arbitrary_key_length(ctx_tmp, sec, sec_len, md_info);</span><br><spa=
n> </span><br><span>     hmac_ctx_update(ctx, seed, seed_len);</span><br><s=
pan>     hmac_ctx_final(ctx, A1);</span><br><span>@@ -1045,7 +868,7 @@</spa=
n><br><span>         hmac_ctx_reset(ctx_tmp);</span><br><span>         hmac=
_ctx_update(ctx, A1, A1_len);</span><br><span>         hmac_ctx_update(ctx_=
tmp, A1, A1_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    hmac_ctx_update(ctx, seed, seed_len);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        hmac_ctx_update(ctx, seed, (int)seed_len);</s=
pan><br><span> </span><br><span>         if (olen &gt; chunk)</span><br><sp=
an>         {</span><br><span>@@ -1094,9 +917,15 @@</span><br><span> ssl_tl=
s1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, size_t s=
len, uint8_t *out1,</span><br><span>              size_t olen)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const md_=
info_t *md5 =3D md_get(&quot;MD5&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const md_info_t *sha1 =3D md_get(&quot;SHA1&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (label_len &gt; (size_t)INT_MA=
X)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t md_kt_t *md5 =3D md_get(&quot;MD5&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const md_kt_t *sha1 =3D md_get(&quot;SHA1&quot;);=
</span><br><span> </span><br><span>     uint8_t *out2 =3D (uint8_t *)gc_mal=
loc(olen, false, &amp;gc);</span><br><span> </span><br><span>@@ -1105,8 +93=
4,8 @@</span><br><span>     const uint8_t *S2 =3D &amp;(sec[len]);</span><b=
r><span>     len +=3D (slen &amp; 1); /* add for odd, make longer */</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls1_P=
_hash(md5, S1, len, label, label_len, out1, olen);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    tls1_P_hash(sha1, S2, len, label, label_le=
n, out2, olen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
tls1_P_hash(md5, S1, len, label, (int)label_len, out1, olen);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    tls1_P_hash(sha1, S2, len, la=
bel, (int)label_len, out2, olen);</span><br><span> </span><br><span>     fo=
r (size_t i =3D 0; i &lt; olen; i++)</span><br><span>     {</span><br><span=
>@@ -1121,8 +950,204 @@</span><br><span>     return true;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+crypto_init_lib(void)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+crypto_uninit_lib(void)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+crypto_clear_error(void)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+mbed_log_err(unsigned int flags, int=
 errval, const char *prefix)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (0=
 !=3D errval)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char errstr[=
256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbedtl=
s_strerror(errval, errstr, sizeof(errstr));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (NULL =3D=3D prefix)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            prefix =3D &quot;mbed TLS error&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(flags, &quot;%s: %s&quot;, prefix, =
errstr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return 0 =3D=3D errval;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbed_log_func=
_line(unsigned int flags, int errval, const char *func, int line)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    char prefix[256];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (snprintf(prefix, sizeof(prefix), &quot;%s:%d&quot;, func=
, line) &gt;=3D sizeof(prefix))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return mbed_log_err(flags, errval, func);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn mbed_log_err(flags, errval, prefix);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+memcmp_constant_time(const voi=
d *a, const void *b, size_t size)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return mbedtls_ct_memcmp(a, b, size);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+show_available_ciphers(void)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Mbed TLS 4 does not currently have=
 a mechanism to discover available</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * ciphers. We instead print out the ciphers from cipher=
_info_table. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;The f=
ollowing ciphers and cipher modes are available for use\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+           &quot;with &quot; PA=
CKAGE_NAME &quot;.  Each cipher shown below may be used as a\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           &quot;parameter=
 to the --data-ciphers (or --cipher) option.  Using a\n&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+           &quot;GCM or CBC mode =
is recommended.  In static key mode only CBC\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &quot;mode is allowed.\n\n&quo=
t;);</span><br><span> #endif</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; cip=
her_info_table_entries; i++)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const cipher_info_t *info =3D &amp;cipher_info_table[i];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const char *name =3D info-&=
gt;name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!cipher_kt_insecure(name) &amp;&amp; (cipher_kt_mode_aead(name) || cipher_=
kt_mode_cbc(name)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  print_cipher(name);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;\nThe following ciphers =
have a block size of less than 128 bits, \n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+           &quot;and are therefore deprecated=
.  Do not use unless you have to.\n\n&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; cipher_info_table=
_entries; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const ciphe=
r_info_t *info =3D &amp;cipher_info_table[i];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const char *name =3D info-&gt;name;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (cipher_kt_ins=
ecure(name) &amp;&amp; (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(nam=
e)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            print_cipher(=
name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;\n&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_a=
vailable_digests(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Mbed TLS=
 4 does not currently have a mechanism to discover available</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * message digests. We instead=
 print out the digests from md_info_table. */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    printf(&quot;The following message digests are available for us=
e with\n&quot; PACKAGE_NAME</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+           &quot;.  A message digest is used in conjunction with\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &qu=
ot;the HMAC function, to authenticate received packets.\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+           &quot;You can specif=
y a message digest as parameter to\n&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+           &quot;the --auth option.\n\n&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; md_info_table_entries; i=
++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const md_info_t *info =
=3D &amp;md_info_table[i];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        printf(&quot;%s %d bit default key\n&quot;, info-&gt;name,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+               (unsig=
ned char)PSA_HASH_LENGTH(info-&gt;psa_alg) * 8);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    printf(&quot;\n&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+show_available_engines(void)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;Sorry, mbed TLS hardw=
are crypto engine functionality is not &quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+           &quot;available\n&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_pe=
m_encode(const char *name, struct buffer *dst, const struct buffer *src,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                  stru=
ct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 1000 chars is =
the PEM line length limit (+1 for tailing NUL) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char header[1000 + 1] =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char footer[1000 + 1] =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(header, siz=
eof(header), &quot;-----BEGIN %s-----\n&quot;, name) &gt;=3D sizeof(header)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (snprintf(footer, sizeof(footer), &qu=
ot;-----END %s-----\n&quot;, name) &gt;=3D sizeof(footer))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    si=
ze_t out_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        !=3D mbedtls_pem_write_buffer(header, foote=
r, BPTR(src), BLEN(src), NULL, 0, &amp;out_len))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We set th=
e size buf to out_len-1 to NOT include the 0 byte that</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * mbedtls_pem_write_buffer in its l=
ength calculation */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    *dst =3D alloc_buf_gc(out_len, gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_pem_write_buffer(header, foot=
er, BPTR(src), BLEN(src), BPTR(dst),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                          BCAP(dst), &amp;=
out_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ||=
 !(out_len &lt; INT_MAX &amp;&amp; out_len &gt; 1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        || !buf_inc_len(dst, (int)out_len - =
1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(*dst);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+crypto_pem_decode(const char *name, stru=
ct buffer *dst, const struct buffer *src)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char header[1000=
 + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char footer[1000 + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (snprintf(header, sizeof(header), &quot;-----BEGIN %s-----&quot;, name) &=
gt;=3D sizeof(header))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(footer=
, sizeof(footer), &quot;-----END %s-----&quot;, name) &gt;=3D sizeof(footer=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* mbed TLS requires the src to be null-terminated */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* allocate a new =
buffer to avoid modifying the src buffer */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer input =3D alloc_=
buf_gc(BLEN(src) + 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    buf_copy(&amp;input, src);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_null_terminate(&amp;input);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    size_t use_len =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    mbedtls_pem_context ctx =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        mbed_ok(mbedtls_pem_read_=
buffer(&amp;ctx, header, footer, BPTR(&amp;input), NULL, 0, &amp;use_len));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t buf_size=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const un=
signed char *buf =3D mbedtls_pem_get_buffer(&amp;ctx, &amp;buf_size);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &amp;&amp; !b=
uf_write(dst, buf, buf_size))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ret =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(M_WARN, &quot;PEM decode error: destination buffer too small&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    mbedtls_pem_free(&amp;ctx);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif /* MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000 */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(ENABLE_CRYPTO_MBEDTLS)=
 */</span><br><span>diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn=
/crypto_mbedtls.h</span><br><span>index af71037..dd491f3 100644</span><br><=
span>--- a/src/openvpn/crypto_mbedtls.h</span><br><span>+++ b/src/openvpn/c=
rypto_mbedtls.h</span><br><span>@@ -1,3 +1,4 @@</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  *  OpenV=
PN -- An application to securely tunnel IP networks</span><br><span>  *    =
         over a single TCP/UDP port, with support for SSL/TLS-based</span><=
br><span>@@ -5,8 +6,8 @@</span><br><span>  *             packet encryption,=
 packet authentication, and</span><br><span>  *             packet compress=
ion.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@...515...&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2026 Se=
ntyron B.V. &lt;openvpn@...2918...&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...2146...=
...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrigh=
t (C) 2010-2025 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  =
*</span><br><span>  *  This program is free software; you can redistribute =
it and/or modify</span><br><span>  *  it under the terms of the GNU General=
 Public License version 2</span><br><span>@@ -23,85 +24,98 @@</span><br><sp=
an> </span><br><span> /**</span><br><span>  * @file</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Data Channel Cryptography mbed TLS-speci=
fic backend interface</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Data Channel Cryptography backend interface using the TF-PSA-Crypto li=
brary</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * part of Mbe=
d TLS 4.</span><br><span>  */</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifndef CRYPTO_MBEDTLS_H_</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CRYPTO_MBEDTLS_H_</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifndef CRYPTO_MBEDTLS4_H_</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define CRYPTO_MBEDTLS4_H_</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#includ=
e &lt;stdbool.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
nclude &lt;mbedtls/cipher.h&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#include &lt;mbedtls/md.h&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &lt;mbedtls/ctr_drbg.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;psa/crypto.h&gt;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Generic mes=
sage digest key type %context. */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-typedef mbedtls_md_info_t md_kt_t;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-/** Generic cipher %context. */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-typedef mbedtls_cipher_context_t cipher_ctx_t;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/** Generic message digest %context. */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-typedef mbedtls_md_context_t md_ctx_t;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/** Generic HMAC %context. */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-typedef mbedtls_md_context_t hmac_c=
tx_t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/* Use a dummy type for the provider =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef void provid=
er_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;integer.h&quot;</span><br><span> </span><br><span> /** Maximum length of a=
n IV */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPENVP=
N_MAX_IV_LENGTH MBEDTLS_MAX_IV_LENGTH</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define OPENVPN_MAX_IV_LENGTH 16</span><br><span> </span>=
<br><span> /** Cipher is in CBC mode */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define OPENVPN_MODE_CBC MBEDTLS_MODE_CBC</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_MODE_CBC PSA_ALG_CB=
C_PKCS7</span><br><span> </span><br><span> /** Cipher is in OFB mode */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_MODE_OFB =
MBEDTLS_MODE_OFB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine OPENVPN_MODE_OFB PSA_ALG_OFB</span><br><span> </span><br><span> /** Ci=
pher is in CFB mode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define OPENVPN_MODE_CFB MBEDTLS_MODE_CFB</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define OPENVPN_MODE_CFB PSA_ALG_CFB</span><br><span=
> </span><br><span> /** Cipher is in GCM mode */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define OPENVPN_MODE_GCM MBEDTLS_MODE_GCM</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_MODE_GCM P=
SA_ALG_GCM</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-typedef mbedtls_operation_t crypto_operation_t;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+typedef int crypto_operation_t;</span><b=
r><span> </span><br><span> /** Cipher should encrypt */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_OP_ENCRYPT MBEDTLS_ENCRYP=
T</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_OP=
_ENCRYPT 0</span><br><span> </span><br><span> /** Cipher should decrypt */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_OP_DEC=
RYPT MBEDTLS_DECRYPT</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define OPENVPN_OP_DECRYPT 1</span><br><span> </span><br><span> #define MD=
4_DIGEST_LENGTH    16</span><br><span> #define MD5_DIGEST_LENGTH    16</spa=
n><br><span> #define SHA_DIGEST_LENGTH    20</span><br><span> #define SHA25=
6_DIGEST_LENGTH 32</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
Returns a singleton instance of the mbed TLS random number generator.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * For PolarSSL/mbed TLS 1.1+, this is the CTR=
_DRBG random number generator. If it</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * hasn&#39;t been initialised yet, the RNG will be initiali=
sed using the default</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * entropy sources. Aside from the default platform entropy sources, an</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * additional entropy sou=
rce, the HAVEGE random number generator will also be</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * added. During initialisation, a personal=
isation string will be added based</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * on the time, the PID, and a pointer to the random context.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-mbedtls_ctr_drbg_context *rand_ctx_get(v=
oid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef void p=
rovider_t;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef ENABLE_PREDICTION_RESISTANCE</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * Enable prediction resistance on the random number generator.</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void rand_ctx_enable_prediction_resistance(void)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct cip=
her_info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *name;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_key_type_t psa_key_=
type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_algori=
thm_t psa_alg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt key_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t iv_bytes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
block_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} cipher=
_info_t;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef =
union psa_cipher_or_aead_operation</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 psa_cipher_operation_t cipher;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    psa_aead_operation_t aead;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+} cipher_operation_t;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+typedef struct cipher_ctx</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mb=
edtls_svc_key_id_t key;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    psa_key_attributes_t key_attributes;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const cipher_info_t *cipher_info;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    bool aead_finished;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    cipher_operation_t opera=
tion;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t ta=
g[16];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} cipher_ctx_=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+typedef struct md_info</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *name;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    psa_algorithm_t psa_alg;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+} md_info_t;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+typedef struct md_ctx</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st md_info_t *md_info;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    psa_hash_operation_t operation;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+} md_ctx_t;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef =
struct hmac_ctx</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_svc_key_id=
_t key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_key_=
attributes_t key_attributes;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const md_info_t *md_info;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    psa_mac_operation_t operation;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+} hmac_ctx_t;</span><br><span> </span><br=
><span> /**</span><br><span>  * Log the supplied mbed TLS error, prefixed b=
y supplied prefix.</span><br><span>  *</span><br><span>  * @param flags    =
     Flags to indicate error type and priority.</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * @param errval        mbed TLS error code to co=
nvert to error message.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param errval        mbed TLS error code.</span><br><span>  * @param=
 prefix        Prefix to mbed TLS error message.</span><br><span>  *</span>=
<br><span>  * @returns true if no errors are detected, false otherwise.</sp=
an><br><span>@@ -112,7 +126,7 @@</span><br><span>  * Log the supplied mbed =
TLS error, prefixed by function name and line number.</span><br><span>  *</=
span><br><span>  * @param flags         Flags to indicate error type and pr=
iority.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param errv=
al        mbed TLS error code to convert to error message.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param errval        mbed TLS err=
or code.</span><br><span>  * @param func          Function name where error=
 was reported.</span><br><span>  * @param line          Line number where e=
rror was reported.</span><br><span>  *</span><br><span>@@ -142,7 +156,8 @@<=
/span><br><span>  * @param errval        mbed TLS error code to convert to =
error message.</span><br><span>  *</span><br><span>  * @returns true if no =
errors are detected, false otherwise.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * TODO: The log function has been removed, do something =
about it?</span><br><span>  */</span><br><span> #define mbed_ok(errval) mbe=
d_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* CRYP=
TO_MBEDTLS_H_ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif /* CRYPTO_MBEDTLS4_H_ */</span><br><span>diff --git a/src/openvpn/crypt=
o_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000..a991349</span><br><span>-=
-- /dev/null</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy.c</spa=
n><br><span>@@ -0,0 +1,1133 @@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Op=
enVPN -- An application to securely tunnel IP networks</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP por=
t, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             session authentication and key exchange,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet compression.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@...515...&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2010-2026 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is =
distributed in the hope that it will be useful,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the =
implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Licens=
e for more details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should ha=
ve received a copy of the GNU General Public License along</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &=
lt;https://www.gnu.org/licenses/&gt;.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Data Channel Cryptography mbed TLS-specif=
ic backend interface,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * for mbed TLS 3.X versions.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/version.h&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x0400000=
0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;errlevel.h&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;basic.h&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;b=
uffer.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;crypto.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;integer.h&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;crypto_backend.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;otime.h&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;misc.h&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/base64.h&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/des.h&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbe=
dtls/error.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;mbedtls/md5.h&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &lt;mbedtls/cipher.h&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &lt;mbedtls/pem.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;mbedtls/entropy.h&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/ssl.h&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Hardware engine support. All=
ows loading/unloading of engines.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+crypto_init_lib_engine(const char *engine_name)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(M_WARN, &quot;Note: mbed TLS hard=
ware crypto engine functionality is not &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                &quot;available&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+provider_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+crypto_load_provider(const char *provider)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (provider)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(M_WARN, &quot;Note: mbed TLS provider functionality is not available&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_u=
nload_provider(const char *provname, provider_t *provider)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Functions related to the core crypto library</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_init_li=
b(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_=
uninit_lib(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+crypto_clear_error(void)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+mbed_log_err(unsigned int flags, int errval, const char *prefix=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (0 !=3D errval)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        char errstr[256];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        mbedtls_strerror(errval, errstr, =
sizeof(errstr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (NULL =3D=
=3D prefix)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            prefix=
 =3D &quot;mbed TLS error&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(flags, &quot;%s: %s&quot;, prefix, errstr);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return 0 =3D=3D errval;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+mbed_log_func_line(unsigned int flags,=
 int errval, const char *func, int line)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char prefix[256];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (snprin=
tf(prefix, sizeof(prefix), &quot;%s:%d&quot;, func, line) &gt;=3D sizeof(pr=
efix))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return mbed_log_err=
(flags, errval, func);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return mbed_log_err(flags,=
 errval, prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef DMALLOC</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cry=
pto_init_dmalloc(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_ERR, =
&quot;Error: dmalloc support is not available for mbed TLS.&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif /* DMALLOC */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+const cipher_name_pair cipher_name_translation_table[] =3D {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;BF-CBC&quo=
t;, &quot;BLOWFISH-CBC&quot; },</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    { &quot;BF-CFB&quot;, &quot;BLOWFISH-CFB64&quot; },</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;CAMELLIA-128-CF=
B&quot;, &quot;CAMELLIA-128-CFB128&quot; },</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    { &quot;CAMELLIA-192-CFB&quot;, &quot;CAMELLIA-=
192-CFB128&quot; },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    { &quot;CAMELLIA-256-CFB&quot;, &quot;CAMELLIA-256-CFB128&quot; }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+const size_t cipher_name_translation_tabl=
e_count =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size=
of(cipher_name_translation_table) / sizeof(*cipher_name_translation_table);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+show_available_ciphers(void)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const int *ciphers =3D mbedtls_cipher_list();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    printf(&quot;The following ciphers and cipher =
modes are available for use\n&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+           &quot;with &quot; PACKAGE_NAME &quot;.  Each cip=
her shown below may be used as a\n&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+           &quot;parameter to the --data-ciphers (or -=
-cipher) option.  Using a\n&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+           &quot;GCM or CBC mode is recommended.  In static k=
ey mode only CBC\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+           &quot;mode is allowed.\n\n&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   while (*ciphers !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_type(*ciphe=
rs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const c=
har *name =3D mbedtls_cipher_info_get_name(info);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (info &amp;&amp; name &amp;&amp; !=
cipher_kt_insecure(name)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &amp;&amp; (cipher_kt_mode_aead(name) || cipher_kt_mode_cb=
c(name)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            print_ci=
pher(name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ciphers++;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    printf(&quot;\nThe following ciphers have a bloc=
k size of less than 128 bits, \n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+           &quot;and are therefore deprecated.  Do not u=
se unless you have to.\n\n&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ciphers =3D mbedtls_cipher_list();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (*ciphers !=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const mbedtls_cipher_info_t *info =3D m=
bedtls_cipher_info_from_type(*ciphers);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        const char *name =3D mbedtls_cipher_info_get_na=
me(info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (info &amp;&amp; name &amp;&amp; cipher_kt_insecure(name)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (cipher_kt_mo=
de_aead(name) || cipher_kt_mode_cbc(name)))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            print_cipher(name);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ciphers++;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    printf(&quot;\n&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+show_available_digests(void)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const int *digests =3D mbedtls_md_list();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;The following message d=
igests are available for use with\n&quot; PACKAGE_NAME</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+           &quot;.  A message digest is =
used in conjunction with\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+           &quot;the HMAC function, to authenticate received p=
ackets.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
       &quot;You can specify a message digest as parameter to\n&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+           &quot;the --au=
th option.\n\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    while (*digests !=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const mbedtls_md_info_t *in=
fo =3D mbedtls_md_info_from_type(*digests);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (info)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     printf(&quot;%s %d bit default key\n&quot;, mbedtls_md_get_name(info),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
mbedtls_md_get_size(info) * 8);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        digests++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    printf(&q=
uot;\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+show_available_engines(void)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    printf(&quot;Sorry, mbed TLS hardware crypto engine functiona=
lity is not &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
          &quot;available\n&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
crypto_pem_encode(const char *name, struct buffer *dst, const struct buffer=
 *src,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
     struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 1000 =
chars is the PEM line length limit (+1 for tailing NUL) */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char header[1000 + 1] =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char footer[100=
0 + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(head=
er, sizeof(header), &quot;-----BEGIN %s-----\n&quot;, name) &gt;=3D sizeof(=
header))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(footer, sizeof(foote=
r), &quot;-----END %s-----\n&quot;, name) &gt;=3D sizeof(footer))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    size_t out_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        !=3D mbedtls_pem_write_buffer(hea=
der, footer, BPTR(src), BLEN(src), NULL, 0, &amp;out_len))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 We set the size buf to out_len-1 to NOT include the 0 byte that</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * mbedtls_pem_write_buffe=
r in its length calculation */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    *dst =3D alloc_buf_gc(out_len, gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_pem_write_buffer(he=
ader, footer, BPTR(src), BLEN(src), BPTR(dst),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                          BCAP(d=
st), &amp;out_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        || !buf_inc_len(dst, out_len - 1))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        CLEAR(*dst);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
crypto_pem_decode(const char *name, struct buffer *dst, const struct buffer=
 *src)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* 1000 chars is the PEM li=
ne length limit (+1 for tailing NUL) */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    char header[1000 + 1] =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char footer[1000 + 1] =3D { 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(header, sizeof(header),=
 &quot;-----BEGIN %s-----&quot;, name) &gt;=3D sizeof(header))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (snprintf(footer, sizeof(footer), &quot;-----END %s=
-----&quot;, name) &gt;=3D sizeof(footer))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* mbed TLS requir=
es the src to be null-terminated */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* allocate a new buffer to avoid modifying the src buf=
fer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer input =3D alloc_buf_gc(BLEN(src) + 1, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_copy(&amp;input, =
src);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_null_t=
erminate(&amp;input);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t use_le=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls=
_pem_context ctx =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool ret =3D</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        mbed_ok(mbedtls_pem_read_buffer(&amp;ctx, header, footer, BPTR=
(&amp;input), NULL, 0, &amp;use_len));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    size_t buf_size =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const unsigned char *buf =3D mbedtls_pem_get_=
buffer(&amp;ctx, &amp;buf_size);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (ret &amp;&amp; !buf_write(dst, buf, buf_size))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ret =3D false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;PEM decode e=
rror: destination buffer too small&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtl=
s_pem_free(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Random number functions, used in cases where we want</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * reasonably strong cryptographic =
random number generation</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * without depleting our entropy pool.  Used for random</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * IV values and a number of other=
 miscellaneous tasks.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Initialise the given ctr_drbg context, using a personalisation s=
tring and an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * entr=
opy gathering function.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_ctr_=
drbg_context *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rand_=
ctx_get(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    static mbedtls_entro=
py_context ec =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    static mbedtls_ctr_drbg_context cd_ctx =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    static bool rand_initialised =3D=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!rand_initialised)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct bu=
ffer pers_string =3D alloc_buf_gc(100, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+         * Personalisation string, should be as unique as possible (see NI=
ST</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * 800-90=
 section 8.7.1). We have very little information at this stage.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * Include Program Name=
, memory address of the context and PID.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        buf_printf(&amp;pers_string, &quot;OpenVPN %0u %p %s&q=
uot;, platform_getpid(), &amp;cd_ctx,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                   time_string(0, 0, 0, &amp;gc));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* Initialise mbed TLS RNG, and built=
-in entropy sources */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        mbedtls_entropy_init(&amp;ec);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        mbedtls_ctr_drbg_init(&amp;cd_ctx);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (!mbed_ok(mbedtls_ctr_drbg_seed(&amp;=
cd_ctx, mbedtls_entropy_func, &amp;ec, BPTR(&amp;pers_string),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
           BLEN(&amp;pers_string))))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(M_FATAL, &quot;Failed to initialize random generator=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        rand_initialised =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return &amp;cd_ctx;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENA=
BLE_PREDICTION_RESISTANCE</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rand_ctx_=
enable_prediction_resistance(void)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 mbedtls_ctr_drbg_context *cd_ctx =3D rand_ctx_get();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    mbedtls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_PREDICTION_RESISTANCE =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+rand_bytes(uint8_t *output, int len)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    mbedtls_ctr_drbg_context *rng_ctx =3D rand_ctx_ge=
t();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    while (len &gt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        const size_t blen =3D min_int(len, MB=
EDTLS_CTR_DRBG_MAX_REQUEST);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (0 !=3D mbedtls_ctr_drbg_random(rng_ctx, output, blen))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        output +=3D blen;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        len -=3D blen;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Gene=
ric cipher key type functions</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static const mbedtls_ci=
pher_info_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher=
_get(const char *ciphername)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSER=
T(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_cipher=
_info_t *cipher =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ciphernam=
e =3D translate_cipher_name_from_openvpn(ciphername);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cipher =3D mbedtls_cipher_info_from_s=
tring(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return cipher;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+cipher_valid_reason(const char *ciphername, const char=
 **reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(reason);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const mbedtls_cipher_info_t *cipher =3D ci=
pher_get(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (NULL =3D=
=3D cipher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &qu=
ot;Cipher algorithm &#39;%s&#39; not found&quot;, ciphername);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        *reason =3D &quot;disabl=
ed because unknown&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t key_byte=
len =3D mbedtls_cipher_info_get_key_bitlen(cipher) / 8;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (key_bytelen &gt; MAX_CIPHER_KEY=
_LENGTH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;Cipher a=
lgorithm &#39;%s&#39; uses a default key size (%zu bytes) &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;which is lar=
ger than &quot; PACKAGE_NAME &quot;&#39;s current maximum key size &quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;(%d=
 bytes)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ciphername, key_bytelen, MAX_CIPHER_KEY_LENGTH);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        *reason =3D &quot;disabled due =
to key size too large&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    *reason =3D NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+cipher_kt_name(const char *ciphername)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(cipherna=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (NULL =
=3D=3D cipher_kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &=
quot;[null-cipher]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return translate_cipher=
_name_to_openvpn(mbedtls_cipher_info_get_name(cipher_kt));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_key_=
size(const char *ciphername)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (NULL =3D=3D cipher_kt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int=
)mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_iv_size(c=
onst char *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const mbedt=
ls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (NULL =3D=3D cipher_kt)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return (int)mbedtls_cipher_info_get_iv_size(cipher_kt);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_block=
_size(const char *ciphername)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (NULL =3D=3D cipher_kt)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return (int)mbedtls_cipher_info_get_block_size(=
cipher_kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+cipher_kt_tag_size(const char *ciphername)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (cipher_kt_mode_aead(ciphername))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return OPENVPN_AEAD_TAG_LENGTH;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_insecure(const=
 char *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_c=
ipher_info_t *cipher_kt =3D cipher_get(ciphername);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!cipher_kt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return !=
(cipher_kt_block_size(ciphername) &gt;=3D 128 / 8</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+             || mbedtls_cipher_info_g=
et_type(cipher_kt) =3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    );</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static mbedtls_cipher_mo=
de_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_mode(=
const mbedtls_cipher_info_t *cipher_kt)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ASSERT(NULL !=3D cipher_kt);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return mbedtls_cipher_info_get_mode(cipher_kt);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ciphe=
r_kt_mode_cbc(const char *ciphername)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return cipher &amp;&amp=
; cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_CBC;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_mode_ofb_cfb=
(const char *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const mbe=
dtls_cipher_info_t *cipher =3D cipher_get(ciphername);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return cipher</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; (cipher_kt_mode(cip=
her) =3D=3D OPENVPN_MODE_OFB</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+               || cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_CFB);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+cipher_kt_mode_aead(const char *ciphername)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cipher=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&am=
p; (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_GCM</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+               || cipher_kt_mode(cip=
her) =3D=3D MBEDTLS_MODE_CHACHAPOLY</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+           );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Generic cipher =
context functions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+mbedtls_cipher_context_t *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+cipher_ctx_new(void)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    mbedtls_cipher_context_t *ctx;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ALLOC_OBJ(ctx, mbedtls_cipher_context_t);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctx;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ciph=
er_ctx_free(mbedtls_cipher_context_t *ctx)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    mbedtls_cipher_free(ctx);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free(ctx);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_init(mbedtls_cipher_context_t =
*ctx, const uint8_t *key, const char *ciphername,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                crypto_operation_t enc)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(NULL !=3D ciphername &amp;&amp=
; NULL !=3D ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  CLEAR(*ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_cipher=
_info_t *kt =3D cipher_get(ciphername);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASSERT(kt);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    size_t key_bitlen =3D mbedtls_cipher_info_get_key_bitle=
n(kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_=
setup(ctx, kt)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FAT=
AL, &quot;mbed TLS cipher context init #1&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, enc)))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;mbed TLS cip=
her set key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (mbedtls_cipher_info_get_m=
ode(kt) =3D=3D MBEDTLS_MODE_CBC)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (!mbed_ok(mbedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_PK=
CS7)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL=
, &quot;mbed TLS cipher set padding mode&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* make su=
re we used a big enough key */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) &lt;=3D key_bitlen=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+cipher_ctx_iv_length(const mbedtls_cipher_context_t *ctx)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return mbedtls_cipher_get_iv_size(ctx);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ciph=
er_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_len)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (tag_len &gt; SIZE_MAX)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_o=
k(mbedtls_cipher_write_tag(ctx, (unsigned char *)tag, tag_len)))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return (int)mbedtls_cipher_get_block_=
size(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+cipher_ctx_mode(const mbedtls_cipher_context_t *ctx)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ASSERT(NULL !=3D ctx);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return mbedtls_cipher_get_cipher_mode(ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_c=
tx_mode_cbc(const cipher_ctx_t *ctx)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return ctx &amp;&amp; cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CBC;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_mode_ofb=
_cfb(const cipher_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn ctx</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &a=
mp;&amp; (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_OFB</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+               || cipher_ctx_mode(ctx) =
=3D=3D OPENVPN_MODE_CFB);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+cipher_ctx_mode_aead(const cipher_ctx_t *ctx)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return ctx</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; (cipher_ctx_mode(ct=
x) =3D=3D OPENVPN_MODE_GCM</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+               || cipher_ctx_mode(ctx) =3D=3D MBEDTLS_MODE_C=
HACHAPOLY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+           );</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_=
ctx_reset(mbedtls_cipher_context_t *ctx, const uint8_t *iv_buf)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_reset(ctx)))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, (size_t)mbedtls_ciphe=
r_get_iv_size(ctx))))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_update_ad(cipher_ctx=
_t *ctx, const uint8_t *src, int src_len)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (src_len &gt; SIZE_MAX)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_up=
date_ad(ctx, src, src_len)))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return 1;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_update(mbedtl=
s_cipher_context_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                  int src_le=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    size_t s_dst_len =3D *dst_len;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_update(=
ctx, src, (size_t)src_len, dst, &amp;s_dst_len)))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *dst_len =3D s_=
dst_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return 1;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_fin=
al(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    size_t s_dst_len =3D *dst_len;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &amp;s=
_dst_len)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    *dst_len =3D s_dst_len;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+cipher_ctx_final_check_tag(mbedtls_cipher_context_t =
*ctx, uint8_t *dst, int *dst_len, uint8_t *tag,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                           size_t tag_len)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t olen =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (MBEDTLS_DECRYPT !=3D mbedtls_cipher_get_operation=
(ctx))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (tag_len &gt; SIZE_MAX)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtl=
s_cipher_finish(ctx, dst, &amp;olen)))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(D_CRYPT_ERRORS, &quot;%s: cipher_ctx_final() failed&quot;,=
 __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (olen &gt; INT_MAX)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    *dst_len =3D olen;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!mbed_ok(mbedtls_cipher_check_tag(ctx, (const unsigned char *)tag, tag_l=
en)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Generic message digest information functions</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static const mbedtls_md_info_t *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_get(const char *di=
gest)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_md_info_t *md =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(digest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    md =3D mbedtls_md_info_fr=
om_string(digest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!md)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &=
quot;Message hash algorithm &#39;%s&#39; not found&quot;, digest);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (mbedtls_md_get_size(md) &gt; MAX_=
HMAC_KEY_LENGTH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FAT=
AL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;Message hash algorithm &#39;%s&#39; uses a default hash size (%d bytes) w=
hich is larger than &quot; PACKAGE_NAME</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            &quot;&#39;s current maximum hash size (%d =
bytes)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      digest, mbedtls_md_get_size(md), MAX_HMAC_KEY_LENGTH);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return md;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+md_valid(const char *digest)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_md_info_t *md =3D mbe=
dtls_md_info_from_string(digest);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return md !=3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+md_kt_name(const char *md=
name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!strcmp(&quot;none&quot;=
, mdname))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;[n=
ull-digest]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const mbedt=
ls_md_info_t *kt =3D md_get(mdname);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return mbedtls_md_get_name(kt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uns=
igned char</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_kt_siz=
e(const char *mdname)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!strcmp(=
&quot;none&quot;, mdname))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_md_in=
fo_t *kt =3D md_get(mdname);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return mbedtls_md_get_size(kt);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Generic message digest functions</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+md_full(const char *mdn=
ame, const uint8_t *src, int src_len, uint8_t *dst)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const mbedtls_md_info_t *kt =3D md_get(mdname);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0 =3D=3D mbedtls=
_md(kt, src, src_len, dst);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_md_context_t *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_new(void)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    mbedtls_md_context_t *ctx;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(ctx, mbedtls_md_=
context_t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+md_ctx_free(mbedtls_md_context_t *ctx)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    free(ctx);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+md_ctx_init(mbedtls_md_context_t *ctx, const =
char *mdname)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_md_inf=
o_t *kt =3D md_get(mdname);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(NULL !=3D ctx &amp;&amp; NULL !=3D kt);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    mbedtls_md_init(ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 0))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=
=3D mbedtls_md_starts(ctx));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+md_ctx_cleanup(mbedtls_md_context_t *ctx)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    mbedtls_md_free(ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_si=
ze(const mbedtls_md_context_t *ctx)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (NULL =3D=3D ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int)mbedtls_md_=
get_size(mbedtls_md_info_from_ctx(ctx));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_update(mbedtls_md_contex=
t_t *ctx, const uint8_t *src, size_t src_len)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(0 =3D=3D mbedtls_md_update(ctx, src, src_len));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ct=
x_final(mbedtls_md_context_t *ctx, uint8_t *dst)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_finish(ctx, dst));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_md_free(ctx);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Generic HMAC functions</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * TODO: re-enable dmsg for crypto debug</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+mbedtls_md_context_t *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+hmac_ctx_new(void)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   mbedtls_md_context_t *ctx;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ALLOC_OBJ(ctx, mbedtls_md_context_t);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ctx;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_free(mbedtls_=
md_context_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(ctx);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
hmac_ctx_init(mbedtls_md_context_t *ctx, const uint8_t *key, const char *md=
name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_md_info_t *kt =
=3D md_get(mdname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(NULL !=3D kt &amp;&amp; NULL !=3D ctx);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    mbedtls_md_init(ctx);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int key_len =3D mbedtls_md_get_size(kt);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_s=
etup(ctx, kt, 1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, key, key_len));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* make sure we used a big enough key */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mbedtls_md_get_=
size(kt) &lt;=3D key_len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+hmac_ctx_cleanup(mbedtls_md_context_t *ctx)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    mbedtls_md_free(ctx);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_si=
ze(mbedtls_md_context_t *ctx)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
NULL =3D=3D ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_md_get_size(mb=
edtls_md_info_from_ctx(ctx));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_reset(mbedtls_md_context_t *ctx)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_hmac_r=
eset(ctx));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+hmac_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *sr=
c, int src_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=3D mb=
edtls_md_hmac_update(ctx, src, src_len));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_final(mbedtls_md_cont=
ext_t *ctx, uint8_t *dst)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0=
 =3D=3D mbedtls_md_hmac_finish(ctx, dst));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+memcmp_constant_time(const voi=
d *a, const void *b, size_t size)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* mbed TLS has a no const time memcmp function that it exposes</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * via its APIs like OpenSS=
L does with CRYPTO_memcmp</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * Adapt the function that mbedtls itself uses in</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * mbedtls_safer_memcmp as it c=
onsiders that to be safe */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    volatile const unsigned char *A =3D (volatile const unsigned ch=
ar *)a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    volatile=
 const unsigned char *B =3D (volatile const unsigned char *)b;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    volatile unsigned char diff =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; =
size; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned char x=
 =3D A[i], y =3D B[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        diff |=3D x ^ y;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return diff;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Generate the hash required by for the \c tl=
s1_PRF function.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param md_kt     =
    Message digest to use</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param sec           Secret to base the hash on</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param sec_len       Length of the =
secret</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param see=
d          Seed to hash</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param seed_len      Length of the seed</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param out           Output buffer</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param olen          Length=
 of the output buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+tls1_P_hash(const mbed=
tls_md_info_t *md_kt, const uint8_t *sec, size_t sec_len, const uint8_t *se=
ed,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            size=
_t seed_len, uint8_t *out, size_t olen)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_=
DEBUG to avoid unused</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * variables warnings if compiled with --enable-small */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const size_t olen_orig =3D o=
len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8=
_t *out_orig =3D out;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_t *ctx =3D hmac_c=
tx_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac_c=
tx_t *ctx_tmp =3D hmac_ctx_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    d=
msg(D_SHOW_KEY_SOURCE, &quot;tls1_P_hash sec: %s&quot;, format_hex(sec, sec=
_len, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_P_hash seed: %s&quot;, format_hex(se=
ed, seed_len, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigne=
d int chunk =3D mbedtls_md_get_size(md_kt);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    unsigned int A1_len =3D mbedtls_md_get_size(md_=
kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* This is the only place wher=
e we init an HMAC with a key that is not</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * equal to its size, therefore we init the hmac c=
tx manually here */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    mbedtls_md_init(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, md_kt, 1));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_hmac=
_starts(ctx, sec, sec_len));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtl=
s_md_init(ctx_tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(0 =3D=3D mbedtls_md_setup(ctx_tmp, md_kt, 1));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_hmac_s=
tarts(ctx_tmp, sec, sec_len));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac=
_ctx_update(ctx, seed, seed_len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    hmac_ctx_final(ctx, A1);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (;;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_=
reset(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
hmac_ctx_reset(ctx_tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        hmac_ctx_update(ctx, A1, A1_len);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        hmac_ctx_update(ctx_tmp, A1, A1_len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_updat=
e(ctx, seed, seed_len);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ole=
n &gt; chunk)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            hmac=
_ctx_final(ctx, out);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            out +=3D chunk;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            olen -=3D chunk;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            hmac_ctx_final(ctx_tmp, A1); /* calc the nex=
t A1 value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else    =
                         /* last one */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            hmac_ctx_final(ctx, A1);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            memcpy(out, A1, olen);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    hmac_ctx_cleanup(ctx);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    hmac_ctx_free(ctx);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    hmac_ctx_cleanup(ctx_tmp);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_free(ctx_tmp);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(A1, sizeo=
f(A1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_SHOW_KEY_SOURCE, &qu=
ot;tls1_P_hash out: %s&quot;, format_hex(out_orig, olen_orig, 0, &amp;gc));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Use the TLS PRF function for generating data channel keys.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * This code is based on the =
OpenSSL library.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLS generates key=
s as such:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * master_secret[48] =3D P=
RF(pre_master_secret[48], &quot;master secret&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                         ClientHello.ra=
ndom[32] + ServerHello.random[32])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 key_block[] =3D PRF(SecurityParameters.master_secret[48],</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *                 &quot;key expansi=
on&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
         SecurityParameters.server_random[32] +</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *                 SecurityParameters.client_ra=
ndom[32]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Notes:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * (1) key_block contains a full set of 4 keys.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (2) The pre-master sec=
ret is generated by the client.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_tls1_PRF(const =
uint8_t *label, size_t label_len, const uint8_t *sec, size_t slen, uint8_t =
*out1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
size_t olen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst md_kt_t *md5 =3D md_get(&quot;MD5&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const md_kt_t *sha1 =3D md_get(&quot;SHA1&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *out2 =3D (uint8_t *)g=
c_malloc(olen, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siz=
e_t len =3D slen / 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const uint8_t *S1 =3D sec;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const uint8_t *S2 =3D &amp;(sec[len]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    len +=3D (slen &amp; 1); /* add for=
 odd, make longer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls1_P_hash(md=
5, S1, len, label, label_len, out1, olen);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    tls1_P_hash(sha1, S2, len, label, label_len, out=
2, olen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &l=
t; olen; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        out1[i] ^=3D=
 out2[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(out2, olen);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_PRF out[%=
zu]: %s&quot;, olen, format_hex(out1, olen, 0, &amp;gc));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VE=
RSION_NUMBER &lt; 0x040000 */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span>diff --git a/s=
rc/openvpn/crypto_mbedtls_legacy.h b/src/openvpn/crypto_mbedtls_legacy.h</s=
pan><br><span>new file mode 100644</span><br><span>index 0000000..af71037</=
span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/crypto_mbedt=
ls_legacy.h</span><br><span>@@ -0,0 +1,148 @@</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sin=
gle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             session authentication and key =
exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet encryption, packet authentication, and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet compression.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sa=
les@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Copyright (C) 2010-2026 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  This program is free software; you can re=
distribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  it under the terms of the GNU General Public License version 2<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by =
the Free Software Foundation.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Thi=
s program is distributed in the hope that it will be useful,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General =
Public License for more details.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
You should have received a copy of the GNU General Public License along</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; =
if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Data Channel Cryptography mb=
ed TLS-specific backend interface</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef CRYPTO_MBEDTL=
S_H_</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CRYPTO_=
MBEDTLS_H_</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool.h&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/=
cipher.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &lt;mbedtls/md.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;mbedtls/ctr_drbg.h&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/** Generic message digest key type %context. */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+typedef mbedtls_md_info_t md_kt_t;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/** Generic cipher %context. */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+typedef mbedtls_cipher_context_t ciphe=
r_ctx_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/** Generic message digest %co=
ntext. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef mb=
edtls_md_context_t md_ctx_t;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Generi=
c HMAC %context. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
typedef mbedtls_md_context_t hmac_ctx_t;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Use a dummy type for the provider */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+typedef void provider_t;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/** Maximum length of an IV */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define OPENVPN_MAX_IV_LENGTH MBEDTLS_MAX_IV_LENGTH</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/** Cipher is in CBC mode */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_MODE_CBC MBEDTLS=
_MODE_CBC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/** Cipher is in OFB mode */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_MODE=
_OFB MBEDTLS_MODE_OFB</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Cipher is in =
CFB mode */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
OPENVPN_MODE_CFB MBEDTLS_MODE_CFB</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** C=
ipher is in GCM mode */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OPENVPN_MODE_GCM MBEDTLS_MODE_GCM</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+typedef mbedtls_operation_t crypto_operation_t;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/** Cipher should encrypt */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define OPENVPN_OP_ENCRYPT MBEDTLS_ENCRYPT</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/** Cipher should decrypt */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_OP_DECRYPT MBEDTLS_DE=
CRYPT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define MD4_DIGEST_LENGTH    16</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MD5_DIGEST_LE=
NGTH    16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define S=
HA_DIGEST_LENGTH    20</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define SHA256_DIGEST_LENGTH 32</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Returns a singlet=
on instance of the mbed TLS random number generator.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * For PolarSSL/mbed TLS 1.1+, this is the CTR_DRBG random=
 number generator. If it</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * hasn&#39;t been initialised yet, the RNG will be initialised using =
the default</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * entro=
py sources. Aside from the default platform entropy sources, an</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * additional entropy source, t=
he HAVEGE random number generator will also be</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * added. During initialisation, a personalisati=
on string will be added based</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * on the time, the PID, and a pointer to the random context.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+mbedtls_ctr_drbg_context *rand_ctx_get(=
void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PREDICTION_RESISTA=
NCE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Enable prediction resistance =
on the random number generator.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 rand_ctx_enable_prediction_resistance(void);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Log the supplied mbed TLS error, prefi=
xed by supplied prefix.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param fla=
gs         Flags to indicate error type and priority.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param errval        mbed TLS error co=
de to convert to error message.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param prefix        Prefix to mbed TLS error message.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @returns true if no errors are detecte=
d, false otherwise.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool mbed_log_er=
r(unsigned int flags, int errval, const char *prefix);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Log the supplied mbed TLS error, prefixed by function name and line numb=
er.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param flags         Flags to =
indicate error type and priority.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param errval        mbed TLS error code to convert to err=
or message.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m func          Function name where error was reported.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param line          Line number whe=
re error was reported.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @returns tr=
ue if no errors are detected, false otherwise.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool mbed_log_func_line(unsigned int flags, int errval, const ch=
ar *func, int line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Wraps mbed_log=
_func_line() to prevent function calls for non-errors */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+mbed_log_func_line_lite(unsigned int fl=
ags, int errval, const char *func, int line)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (errval)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn mbed_log_func_line(flags, errval, func, line);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Check errval and log on error.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Convenience wrapper to put around mbed=
 TLS library calls, e.g.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *   if (!mbed_ok (mbedtls_ssl_func())) return 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * or</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *   ASSERT (mbed_ok (mbedtls_ssl_func()));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param errval        mbed TLS error code to =
convert to error message.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @returns=
 true if no errors are detected, false otherwise.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERROR=
S, errval, __func__, __LINE__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /=
* CRYPTO_MBEDTLS_H_ */</span><br><span>diff --git a/src/openvpn/mbedtls_com=
pat.h b/src/openvpn/mbedtls_compat.h</span><br><span>index d457b5e..667529e=
 100644</span><br><span>--- a/src/openvpn/mbedtls_compat.h</span><br><span>=
+++ b/src/openvpn/mbedtls_compat.h</span><br><span>@@ -34,6 +34,16 @@</span=
><br><span> </span><br><span> #include &quot;errlevel.h&quot;</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mb=
edtls/asn1.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;mbedtls/pk.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_=
VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &lt;mbedtls/ctr_drbg.h&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;crypto_mbedtls_legacy.h&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/oid.h&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_=
NUMBER &lt; 0x04000000 */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> #ifdef HAVE_PSA_CRYPTO_H</span><br><span> #include =
&lt;psa/crypto.h&gt;</span><br><span> #endif</span><br><span>@@ -51,4 +61,1=
76 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &=
gt;=3D 0x04000000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ty=
pedef struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *name;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t tls_id;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+} mbedtls_ecp_curve_in=
fo;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+mbedtls_oid_get_attr_short_name(const=
 mbedtls_asn1_buf *oid, const char **desc)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* The relevant OIDs all have equal length. */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (oid-&gt;tag !=3D MBEDTLS_ASN1_O=
ID || oid-&gt;len !=3D strlen(MBEDTLS_OID_AT_CN))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        *desc =3D NULL;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (memcmp=
(oid-&gt;p, MBEDTLS_OID_AT_CN, oid-&gt;len) =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *desc =3D &quot;CN&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_SUR_NAME,=
 oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *d=
esc =3D &quot;SN&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else i=
f (memcmp(oid-&gt;p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid-&gt;len) =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;serialNumbe=
r&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&=
gt;p, MBEDTLS_OID_AT_COUNTRY, oid-&gt;len) =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *desc =3D &quot;C&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_LOCALITY,=
 oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *d=
esc =3D &quot;L&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if=
 (memcmp(oid-&gt;p, MBEDTLS_OID_AT_STATE, oid-&gt;len) =3D=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;ST&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_A=
T_ORGANIZATION, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        *desc =3D &quot;O&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_ORG_UNIT, oid-&gt;len) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;=
OU&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-=
&gt;p, MBEDTLS_OID_AT_TITLE, oid-&gt;len) =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *desc =3D &quot;title&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_POSTAL=
_ADDRESS, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       *desc =3D &quot;postalAddress&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_POSTAL_CODE, oid-&g=
t;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D=
 &quot;postalCode&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_GIVEN_NAME, oid-&gt;len) =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;GN&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTL=
S_OID_AT_INITIALS, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        *desc =3D &quot;initials&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_GENERATION_QUAL=
IFIER, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    *desc =3D &quot;generationQualifier&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIE=
R, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
*desc =3D &quot;uniqueIdentifier&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_DN_QUALIFIER, oid-&gt;l=
en) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &q=
uot;dnQualifier&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if=
 (memcmp(oid-&gt;p, MBEDTLS_OID_AT_PSEUDONYM, oid-&gt;len) =3D=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;pseudonym&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        *desc =3D NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static inline int</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+mbedtls_oid_get_extended_key_usage(cons=
t mbedtls_asn1_buf *oid, const char **desc)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* The relevant OIDs all have equal length. */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (oid-&gt;tag !=3D MBEDTLS_ASN1_=
OID || oid-&gt;len !=3D strlen(MBEDTLS_OID_SERVER_AUTH))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        *desc =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(memcmp(oid-&gt;p, MBEDTLS_OID_SERVER_AUTH, oid-&gt;len) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;TLS Web Server Au=
thentication&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (m=
emcmp(oid-&gt;p, MBEDTLS_OID_CLIENT_AUTH, oid-&gt;len) =3D=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;TLS Web Client Authe=
ntication&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memc=
mp(oid-&gt;p, MBEDTLS_OID_CODE_SIGNING, oid-&gt;len) =3D=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        *desc =3D &quot;Code Signing&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDT=
LS_OID_EMAIL_PROTECTION, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        *desc =3D &quot;E-mail Protection&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_TIM=
E_STAMPING, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        *desc =3D &quot;Time Stamping&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_OCSP_SIGNING, oid-&g=
t;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D=
 &quot;OCSP Signing&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /*=
 MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000 */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Some functions that operate on private keys use randomness to pro=
tect against</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * side=
 channels. In Mbed TLS 4, they automatically use the RNG in the PSA</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * library, but in Mbed TLS=
 3, they require them as explicit arguments. */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static inline int</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+mbedtls_compat_pk_parse_key(mbedtls_pk_context *c=
tx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
            const unsigned char *key, size_t keylen,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            const unsigne=
d char *pwd, size_t pwdlen)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTL=
S_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdl=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_pk_parse_k=
ey(ctx, key, keylen, pwd, pwdlen, mbedtls_ctr_drbg_random, rand_ctx_get());=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_V=
ERSION_NUMBER &lt; 0x04000000 */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_compat_pk_parse_ke=
yfile(mbedtls_pk_context *ctx, const char *path, const char *password)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x0400=
0000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return mbed=
tls_pk_parse_keyfile(ctx, path, password);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return mbedtls_pk_parse_keyfile(ctx, path, password, mbedtls_c=
tr_drbg_random, rand_ctx_get());</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static inline int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbe=
dtls_pk_context *prv)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERS=
ION_NUMBER &gt;=3D 0x04000000</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return mbedtls_pk_check_pair(pub, prv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_=
drbg_random, rand_ctx_get());</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> #endif /* MBEDTLS_COMPAT_H_ */</s=
pan><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbed=
tls.c</span><br><span>index f902e17..3e1698f 100644</span><br><span>--- a/s=
rc/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</s=
pan><br><span>@@ -93,7 +93,9 @@</span><br><span>     ASSERT(NULL !=3D ctx);=
</span><br><span>     CLEAR(*ctx);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x0400000=
0</span><br><span>     ALLOC_OBJ_CLEAR(ctx-&gt;dhm_ctx, mbedtls_dhm_context=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span> </span><br><span>     ALLOC_OBJ_CLEAR(ctx-&gt;ca_chain, mbedtls_x509=
_crt);</span><br><span> </span><br><span>@@ -107,7 +109,9 @@</span><br><spa=
n>     ASSERT(NULL !=3D ctx);</span><br><span>     CLEAR(*ctx);</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_V=
ERSION_NUMBER &lt; 0x04000000</span><br><span>     ALLOC_OBJ_CLEAR(ctx-&gt;=
dhm_ctx, mbedtls_dhm_context);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span>     ALLOC_OBJ_CLEAR(ctx-&gt;ca_chain, mb=
edtls_x509_crt);</span><br><span> </span><br><span>     ctx-&gt;endpoint =
=3D MBEDTLS_SSL_IS_CLIENT;</span><br><span>@@ -128,8 +132,10 @@</span><br><=
span>         mbedtls_x509_crt_free(ctx-&gt;crt_chain);</span><br><span>   =
      free(ctx-&gt;crt_chain);</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</sp=
an><br><span>         mbedtls_dhm_free(ctx-&gt;dhm_ctx);</span><br><span>  =
       free(ctx-&gt;dhm_ctx);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span> </span><br><span>         mbedtls_x509_cr=
l_free(ctx-&gt;crl);</span><br><span>         free(ctx-&gt;crl);</span><br>=
<span>@@ -348,6 +354,34 @@</span><br><span>     }</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBED=
TLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static const mbedtls_ecp_curve_info ecp_curve_info_table[=
] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TODO:=
 Fill out the table. */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    { &quot;secp256r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP256R1 },</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;secp384r1&=
quot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP384R1 },</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    { &quot;X25519&quot;, MBEDTLS_SSL_IANA_TLS_G=
ROUP_X25519 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
 &quot;ffdhe2048&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE2048 },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;ffdhe3072&quot;, MB=
EDTLS_SSL_IANA_TLS_GROUP_FFDHE3072 },</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    { &quot;ffdhe4096&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_F=
FDHE4096 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &q=
uot;ffdhe6144&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE6144 },</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    { &quot;ffdhe8192&quot;, MBEDT=
LS_SSL_IANA_TLS_GROUP_FFDHE8192 },</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic const size_t ecp_curve_info_table_items =3D sizeof(ecp_curve_info_tabl=
e) / sizeof(mbedtls_ecp_curve_info);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic const mbedtls_ecp_curve_info *</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+mbedtls_ecp_curve_info_from_name(const char *name)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; ecp_curve_info=
_table_items; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (str=
cmp(name, ecp_curve_info_table[i].name) =3D=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return &amp;ecp_curve_info_table[i];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif /* MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000 */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><sp=
an> tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)</s=
pan><br><span> {</span><br><span>@@ -409,6 +443,7 @@</span><br><span> void<=
/span><br><span> tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const cha=
r *dh_file, bool dh_inline)</span><br><span> {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span=
><br><span>     if (dh_inline)</span><br><span>     {</span><br><span>     =
    if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx-&gt;dhm_ctx, (const unsigned cha=
r *)dh_file,</span><br><span>@@ -427,6 +462,12 @@</span><br><span> </span><=
br><span>     msg(D_TLS_DEBUG_LOW, &quot;Diffie-Hellman initialized with &q=
uot; counter_format &quot; bit key&quot;,</span><br><span>         (counter=
_type)mbedtls_dhm_get_bitlen(ctx-&gt;dhm_ctx));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (strcmp(dh_file, &quot;none&quot;) !=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;Mbed TLS 4 only su=
pports pre-defined Diffie-Hellman groups.&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><=
br><span> }</span><br><span> </span><br><span> void</span><br><span>@@ -500=
,29 +541,26 @@</span><br><span> </span><br><span>     if (priv_key_inline)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        status =3D mbedtls_pk_parse_key(ctx-&gt;priv_key, (const unsigned =
char *)priv_key_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                      strlen(priv_key_file) + 1, NULL, 0,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
               mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        status =3D mbedtls_compat_pk_p=
arse_key(ctx-&gt;priv_key, (const unsigned char *)priv_key_file,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
               strlen(priv_key_file) + 1, NULL, 0);</span><br><span> </span=
><br><span>         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)</sp=
an><br><span>         {</span><br><span>             char passbuf[512] =3D =
{ 0 };</span><br><span>             pem_password_callback(passbuf, 512, 0, =
NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            sta=
tus =3D mbedtls_pk_parse_key(</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            status =3D mbedtls_compat_pk_parse_key(</span><br><sp=
an>                 ctx-&gt;priv_key, (const unsigned char *)priv_key_file,=
 strlen(priv_key_file) + 1,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                (unsigned char *)passbuf, strlen(passbuf), mbedtls_ct=
r_drbg_random, rand_ctx_get());</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                (unsigned char *)passbuf, strlen(passbuf));</sp=
an><br><span>         }</span><br><span>     }</span><br><span>     else</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file,=
 NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                           mbedtls_ctr_drbg_random, rand_ctx_get());</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D mbedtls=
_compat_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file, NULL);</span><br>=
<span>         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)</span><b=
r><span>         {</span><br><span>             char passbuf[512] =3D { 0 }=
;</span><br><span>             pem_password_callback(passbuf, 512, 0, NULL)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            status =
=3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file, passbuf,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
                    mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            status =3D mbedtls_co=
mpat_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file, passbuf);</span><br>=
<span>         }</span><br><span>     }</span><br><span>     if (!mbed_ok(s=
tatus))</span><br><span>@@ -538,8 +576,7 @@</span><br><span>         return=
 1;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_pk_check_pair(&amp;ctx-&gt;=
crt_chain-&gt;pk, ctx-&gt;priv_key,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                                       mbedtls_ctr_drbg_rando=
m, rand_ctx_get())))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!mbed_ok(mbedtls_compat_pk_check_pair(&amp;ctx-&gt;crt_chain-&gt;p=
k, ctx-&gt;priv_key)))</span><br><span>     {</span><br><span>         msg(=
M_WARN, &quot;Private key does not match the certificate&quot;);</span><br>=
<span>         return 1;</span><br><span>@@ -553,6 +590,7 @@</span><br><spa=
n> #pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span>=
 #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span> /**</span=
><br><span>  * external_pkcs1_sign implements a mbed TLS rsa_sign_func call=
back, that uses</span><br><span>  * the management interface to request an =
RSA signature for the supplied hash.</span><br><span>@@ -669,11 +707,16 @@<=
/span><br><span> </span><br><span>     return ctx-&gt;signature_length;</sp=
an><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><br><span> </span><br=
><span> int</span><br><span> tls_ctx_use_external_signing_func(struct tls_r=
oot_ctx *ctx, external_sign_func sign_func,</span><br><span>               =
                    void *sign_ctx)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x040=
00000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_WARN=
, &quot;tls_ctx_use_external_signing_func is not implemented for Mbed TLS 4=
.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br>=
<span>     ASSERT(NULL !=3D ctx);</span><br><span> </span><br><span>     if=
 (ctx-&gt;crt_chain =3D=3D NULL)</span><br><span>@@ -701,6 +744,7 @@</span>=
<br><span>     }</span><br><span> </span><br><span>     return 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUM=
BER &gt;=3D 0x04000000 */</span><br><span> }</span><br><span> </span><br><s=
pan> #ifdef ENABLE_MANAGEMENT</span><br><span>@@ -938,6 +982,7 @@</span><br=
><span> void</span><br><span> tls_ctx_personalise_random(struct tls_root_ct=
x *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span>     stat=
ic char old_sha256_hash[32] =3D { 0 };</span><br><span>     unsigned char s=
ha256_hash[32] =3D { 0 };</span><br><span>     mbedtls_ctr_drbg_context *cd=
_ctx =3D rand_ctx_get();</span><br><span>@@ -960,6 +1005,7 @@</span><br><sp=
an>             memcpy(old_sha256_hash, sha256_hash, sizeof(old_sha256_hash=
));</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x0=
40000 */</span><br><span> }</span><br><span> </span><br><span> #if defined(=
__GNUC__) || defined(__clang__)</span><br><span>@@ -1069,7 +1115,9 @@</span=
><br><span>     }</span><br><span> #endif</span><br><span>     mbedtls_ssl_=
conf_dbg(ks_ssl-&gt;ssl_config, my_debug, NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</sp=
an><br><span>     mbedtls_ssl_conf_rng(ks_ssl-&gt;ssl_config, mbedtls_ctr_d=
rbg_random, rand_ctx_get());</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><br><spa=
n> </span><br><span>     mbedtls_ssl_conf_cert_profile(ks_ssl-&gt;ssl_confi=
g, &amp;ssl_ctx-&gt;cert_profile);</span><br><span> </span><br><span>@@ -11=
00,12 +1148,14 @@</span><br><span> #endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTI=
NG */</span><br><span> </span><br><span>     /* Initialise authentication i=
nformation */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MB=
EDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span>     if (is_server)</s=
pan><br><span>     {</span><br><span>         mbed_ok(mbedtls_ssl_conf_dh_p=
aram_ctx(ks_ssl-&gt;ssl_config, ssl_ctx-&gt;dhm_ctx));</span><br><span>    =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbed_ok(mb=
edtls_ssl_conf_own_cert(ks_ssl-&gt;ssl_config, ssl_ctx-&gt;crt_chain, ssl_c=
tx-&gt;priv_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   (void)mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl-&gt;ssl_config, ssl_ctx-&=
gt;crt_chain, ssl_ctx-&gt;priv_key));</span><br><span> </span><br><span>   =
  /* Initialise SSL verification */</span><br><span>     if (session-&gt;op=
t-&gt;ssl_flags &amp; SSLF_CLIENT_CERT_OPTIONAL)</span><br><span>@@ -1160,7=
 +1210,7 @@</span><br><span>     /* Initialise SSL context */</span><br><sp=
an>     ALLOC_OBJ_CLEAR(ks_ssl-&gt;ctx, mbedtls_ssl_context);</span><br><sp=
an>     mbedtls_ssl_init(ks_ssl-&gt;ctx);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    mbed_ok(mbedtls_ssl_setup(ks_ssl-&gt;ctx, ks_ssl-&g=
t;ssl_config));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
(void)mbed_ok(mbedtls_ssl_setup(ks_ssl-&gt;ctx, ks_ssl-&gt;ssl_config));</s=
pan><br><span>     /* We do verification in our own callback depending on t=
he</span><br><span>      * exact configuration. We do not rely on the defau=
lt hostname</span><br><span>      * verification. */</span><br><span>@@ -13=
76,7 +1426,8 @@</span><br><span>     /* Error during read, check for retry =
error */</span><br><span>     if (retval &lt; 0)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (MBEDTLS_ERR_S=
SL_WANT_WRITE =3D=3D retval || MBEDTLS_ERR_SSL_WANT_READ =3D=3D retval)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (MBEDTLS_ERR=
_SSL_WANT_WRITE =3D=3D retval || MBEDTLS_ERR_SSL_WANT_READ =3D=3D retval</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            || MBEDTLS=
_ERR_SSL_RECEIVED_NEW_SESSION_TICKET =3D=3D retval)</span><br><span>       =
  {</span><br><span>             return 0;</span><br><span>         }</span=
><br><span>@@ -1456,6 +1507,7 @@</span><br><span> void</span><br><span> sho=
w_available_curves(void)</span><br><span> {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><b=
r><span>     const mbedtls_ecp_curve_info *pcurve =3D mbedtls_ecp_curve_lis=
t();</span><br><span> </span><br><span>     if (NULL =3D=3D pcurve)</span><=
br><span>@@ -1470,6 +1522,9 @@</span><br><span>         printf(&quot;%s\n&q=
uot;, pcurve-&gt;name);</span><br><span>         pcurve++;</span><br><span>=
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot;Mbed=
 TLS 4 has no mechanism to list supported curves.&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt;=
 0x04000000 */</span><br><span> }</span><br><span> </span><br><span> const =
char *</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn=
/ssl_mbedtls.h</span><br><span>index f744945..6b678b2 100644</span><br><spa=
n>--- a/src/openvpn/ssl_mbedtls.h</span><br><span>+++ b/src/openvpn/ssl_mbe=
dtls.h</span><br><span>@@ -112,11 +112,13 @@</span><br><span>  */</span><br=
><span> struct tls_root_ctx</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    bool initialised;                      /**&lt;=
 True if the context has been initialised */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool initialised; /**&lt; True if the context =
has been initialised */</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int endpoint;                          /**&lt; Whet=
her or not this is a server or a client */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int endpoint;     /**&lt; Whether or not this is=
 a server or a client */</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br=
><span>     mbedtls_dhm_context *dhm_ctx;          /**&lt; Diffie-Helmann-M=
erkle context */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span>     mbedtls_x509_crt *crt_chain;           /**&lt; Loc=
al Certificate chain */</span><br><span>     mbedtls_x509_crt *ca_chain;   =
         /**&lt; CA chain for remote verification */</span><br><span>     m=
bedtls_pk_context *priv_key;          /**&lt; Local private key */</span><b=
r><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_ver=
ify_mbedtls.c</span><br><span>index 9d89a1d..32f3ecb 100644</span><br><span=
>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/s=
sl_verify_mbedtls.c</span><br><span>@@ -34,13 +34,22 @@</span><br><span> </=
span><br><span> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/versi=
on.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt=
; 0x04000000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;crypto_mbedtls_legacy.h&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;mbedtls/bignum.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/sha1.h&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span> #inclu=
de &quot;crypto_mbedtls.h&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mbedt=
ls_compat.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> #include &quot;ssl_verify.h&quot;</span><br><span> #include=
 &lt;mbedtls/asn1.h&gt;</span><br><span> #include &lt;mbedtls/error.h&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/bi=
gnum.h&gt;</span><br><span> #include &lt;mbedtls/oid.h&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/sha1.h&gt;</span>=
<br><span> </span><br><span> #define MAX_SUBJECT_LENGTH 256</span><br><span=
> </span><br><span>@@ -171,11 +180,139 @@</span><br><span>     return SUCCE=
SS;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Mbed TLS 4 has no functio=
n to print the certificate serial number and does</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * not expose the bignum functions anymore. S=
o in order to write the serial</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * number as a decimal string, we implement bignum % 10 and bign=
um / 10. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static c=
har</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bignum_mod_10(co=
nst uint8_t *bignum, size_t bignum_length)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int result =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (size_t i =3D 0; i &lt; bignum_length; i++)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        result =3D (result * 256) % 10;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        result =3D (result + b=
ignum[i]) % 10;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (char)r=
esult;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Divide bignum by 10 rounded down, in place. */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bignum_div_10(uint8_t *bignu=
m, size_t *bignum_length)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Some intuition for=
 the algorithm below:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * We w=
ant to calculate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *     (bign=
um[0] * 256^n + bignum[1] * 256^(n-1) + ... + bignum[n]) / 10.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * Let remainder =3D bignum[0] % 10 and c=
arry =3D remainder * 256.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * Then we can write the above as</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     *     (bignum[0] / 10) * 256^n</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     *       + ((carry + bignum[1]) * 256^(n-1) =
+ ... + bignum[n]) / 10.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * S=
o now we have the first byte of our result. The second byte will be</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * (carry + bignum[1]) =
/ 10. Note that this fits into one byte because</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * 0 &lt;=3D remainder &lt; 10. We calculat=
e the next remainder and carry as</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * remainder =3D (carry + bignum[1]) % 10 and carry =3D r=
emainder * 256 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * move on to the next byte until we are done.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    size_t new_length =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int carry =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; *bignum_length;=
 i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t next_byte =
=3D (uint8_t)((bignum[i] + carry) / 10);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        int remainder =3D (bignum[i] + carry) % 10;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        carry =3D rema=
inder * 256;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Write the byte =
unless it&#39;s a leading zero. */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (new_length !=3D 0 || next_byte !=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            bignum[new_length++] =3D ne=
xt_byte;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    *bignum_length =3D new_length;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Write the decimal representation of bignum to out, if =
enough space is available.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Returns the number of bytes needed in out, or 0 on error. To calc=
ulate the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * necessa=
ry buffer size, the function can be called with out =3D NULL. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static size_t</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+write_bignum(char *out, size_t out_s=
ize, const uint8_t *bignum, size_t bignum_length)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (bignum_length =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* We want out to be &quot;0&quot;. */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (out !=3D NULL)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (out_size &gt;=3D 2)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                out[0] =3D &#39=
;0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     out[1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            else if (out_size &gt; 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                out[0] =3D &#39;\0&#39;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return 2;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *b=
ignum_copy =3D malloc(bignum_length);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (bignum_copy =3D=3D NULL)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    memcpy(bignum_copy, bignum, bignum_length);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    size_t bytes_needed =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    size_t bytes_written =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (bignum_length &gt; 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* We&#39;re writing the digits i=
n reverse order. We put them in the right order later. */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        char digit =3D bignum_mod_10(=
bignum_copy, bignum_length);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (out !=3D NULL &amp;&amp; bytes_written &lt; out_size -=
 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            out[bytes_writ=
ten++] =3D &#39;0&#39; + (char)digit;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        bytes_needed +=3D 1;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        bignum_div_10(bignum_copy, &amp;bignum_length);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (out !=3D NULL)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (bytes_written =3D=3D bytes_needed)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /* We had space for all digits. Now r=
everse them. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        for (size_t i =3D 0; i &lt; bytes_written / 2; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                char tmp =3D out[i];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                out[i] =
=3D out[bytes_written - 1 - i];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                out[bytes_written - 1 - i] =3D tmp;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            out[bytes_written] =3D &#=
39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (o=
ut_size &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ou=
t[0] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bytes_needed +=3D=
 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    free(bignum_copy);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return bytes_needed;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &gt;=3D 0x04=
000000 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> char *</span><br><span> backend_x509_get_serial(mbedtls_x509_crt *c=
ert, struct gc_arena *gc)</span><br><span> {</span><br><span>     char *buf=
 =3D NULL;</span><br><span>     size_t buflen =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span> =
    mbedtls_mpi serial_mpi =3D { 0 };</span><br><span> </span><br><span>   =
  /* Transform asn1 integer serial into mbed TLS MPI */</span><br><span>@@ =
-201,6 +338,21 @@</span><br><span> end:</span><br><span>     mbedtls_mpi_fr=
ee(&amp;serial_mpi);</span><br><span>     return buf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    buflen =3D write_bignum(NULL, 0, cert-&gt;serial.p,=
 cert-&gt;serial.len);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (buflen =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_WARN, &quot;Failed to write serial to string.&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    buf =3D gc_malloc(buflen, true, gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (write_bignum(buf,=
 buflen, cert-&gt;serial.p, cert-&gt;serial.len) !=3D buflen)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Failed to write seria=
l to string.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return b=
uf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTL=
S_VERSION_NUMBER &lt; 0x04000000 */</span><br><span> }</span><br><span> </s=
pan><br><span> char *</span><br><span>diff --git a/src/openvpn/syshead.h b/=
src/openvpn/syshead.h</span><br><span>index 2e22204..582e130 100644</span><=
br><span>--- a/src/openvpn/syshead.h</span><br><span>+++ b/src/openvpn/sysh=
ead.h</span><br><span>@@ -475,7 +475,10 @@</span><br><span> #endif</span><b=
r><span> </span><br><span> #ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/version.h&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMB=
ER &lt; 0x04000000</span><br><span> #define ENABLE_PREDICTION_RESISTANCE</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERS=
ION_NUMBER &lt; 0x04000000 */</span><br><span> #endif /* ENABLE_CRYPTO_MBED=
TLS */</span><br><span> </span><br><span> /*</span><br><span>diff --git a/t=
ests/Makefile.am b/tests/Makefile.am</span><br><span>index bf8f960..cb30fe5=
 100644</span><br><span>--- a/tests/Makefile.am</span><br><span>+++ b/tests=
/Makefile.am</span><br><span>@@ -55,6 +55,7 @@</span><br><span> 	$(top_srcd=
ir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_srcdir)/src/openvp=
n/crypto_openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbe=
dtls.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcd=
ir)/src/openvpn/crypto_mbedtls_legacy.c \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/otime.c \</span><br><span> 	$(top_srcdir)/src/openvpn/packet_id.=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/platform.c</span><br><span>=
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.r=
c</span><br><span>index 798cfd0..bba77aa 100755</span><br><span>--- a/tests=
/t_server_null_default.rc</span><br><span>+++ b/tests/t_server_null_default=
.rc</span><br><span>@@ -57,7 +57,7 @@</span><br><span> SERVER_SERVER_2=3D&q=
uot;--server 10.29.42.0 255.255.255.0&quot;</span><br><span> SERVER_MGMT_PO=
RT_2=3D&quot;11195&quot;</span><br><span> SERVER_EXEC_2=3D&quot;${SERVER_EX=
EC}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SERVER_CONF_=
2=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --proto tcp -=
-management 127.0.0.1 ${SERVER_MGMT_PORT_2} --dh ${DH}&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+SERVER_CONF_2=3D&quot;${SERVER_CON=
F_BASE} ${SERVER_SERVER_2} --lport 1195 --proto tcp --management 127.0.0.1 =
${SERVER_MGMT_PORT_2} --dh none&quot;</span><br><span> </span><br><span> SE=
RVER_NAME_3=3D&quot;t_server_null_server-1196_udp&quot;</span><br><span> SE=
RVER_SERVER_3=3D&quot;--server 10.29.43.0 255.255.255.0&quot;</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/ope=
nvpn/Makefile.am</span><br><span>index 7aeea47..1128eb4 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/=
unit_tests/openvpn/Makefile.am</span><br><span>@@ -76,6 +76,7 @@</span><br>=
<span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir=
)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=
_mbedtls.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_=
srcdir)/src/openvpn/crypto_mbedtls_legacy.c \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/crypto_openssl.c \</span><br><span> 	$(top_srcdir)/src/openv=
pn/crypto_epoch.c \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</=
span><br><span>@@ -110,6 +111,7 @@</span><br><span> 	$(top_srcdir)/src/open=
vpn/cryptoapi.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch.=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/c=
rypto_mbedtls_legacy.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=
_openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/env_set.c \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/mss.c \</span><br><span>@@ -158,6 +16=
0,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_src=
dir)/src/openvpn/crypto_mbedtls.c \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><span> 	=
$(top_srcdir)/src/openvpn/env_set.c \</span><br><span> 	$(top_srcdir)/src/o=
penvpn/otime.c \</span><br><span>@@ -188,6 +191,7 @@</span><br><span> 	$(to=
p_srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/openvp=
n/crypto_epoch.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedt=
ls.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/crypto_mbedtls_legacy.c \</span><br><span> 	$(top_srcdir)/src=
/openvpn/crypto_openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/env=
_set.c \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</span><br><s=
pan>@@ -208,6 +212,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_mbedtls=
_legacy.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl.c \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/fdmisc.c \</span><br><span> 	$(=
top_srcdir)/src/openvpn/otime.c \</span><br><span>@@ -294,6 +299,7 @@</span=
><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/crypto_mbedtls.c \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \</span><br><span> 	=
$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><span> 	$(top_srcdir=
)/src/openvpn/otime.c \</span><br><span> 	$(top_srcdir)/src/openvpn/packet_=
id.c \</span><br><span>@@ -332,6 +338,7 @@</span><br><span> 	$(top_srcdir)/=
src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_e=
poch.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/open=
vpn/crypto_mbedtls_legacy.c \</span><br><span> 	$(top_srcdir)/src/openvpn/c=
rypto_openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/packet_id.c \</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/=
test_common.h</span><br><span>index f898e89..1aa92e6 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/test_common.h</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_common.h</span><br><span>@@ -24,6 +24,10 @@</span><b=
r><span> #include &lt;setjmp.h&gt;</span><br><span> #include &lt;cmocka.h&g=
t;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;mbedtls_compat.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /* Do we use cmocka &lt; 2.0.0? */</=
span><br><span> #ifndef HAVE_CMOCKA_VERSION_H</span><br><span> #define HAVE=
_OLD_CMOCKA_API 1</span><br><span>@@ -57,6 +61,9 @@</span><br><span> {</spa=
n><br><span>     assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0)=
;</span><br><span>     assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSI=
Z), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    mbedtls_compat_psa_crypto_init();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </span><br>=
<span> /**</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">change 1441</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111=
bcc627cdb0fae </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1441 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: syzzer &lt;steffan@...1856...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>

</body></html>=

--a/cArQapq28=--

