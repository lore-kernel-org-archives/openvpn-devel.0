From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 24 Jan 2026 18:17:51 +0000
In-Reply-To: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
References: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...,
 max@...2606...
Message-ID: <3189caee629bddd5c91079554df1380867378ee6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DhYhKX5zBO8="; charset=UTF-8
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
To: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: syzzer <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DhYhKX5zBO8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 MaxF. ( http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1441
Message-Id: <20260123164746.7333-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
401.html
Signed-off-by: Gert Doering <gert@...1296...>
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
16 files changed, 2,442 insertions(+), 704 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1441/8

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
index e1a5cad..5418df9 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
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
index af71037..16d41e4 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -1,3 +1,4 @@
+
 /*
  *  OpenVPN -- An application to securely tunnel IP networks
  *             over a single TCP/UDP port, with support for SSL/TLS-based
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
index 156e5a9..fb070aa 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -25,6 +25,10 @@
 #include <stdlib.h>
 #include <cmocka.h>

+#if defined(ENABLE_CRYPTO_MBEDTLS)
+#include "mbedtls_compat.h"
+#endif
+
 /* Do we use cmocka < 2.0.0? */
 #ifndef HAVE_CMOCKA_VERSION_H
 #define HAVE_OLD_CMOCKA_API 1
@@ -58,6 +62,9 @@
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
Gerrit-PatchSet: 8
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: syzzer <steffan@...1856...>

--DhYhKX5zBO8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by MaxF.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Add support for Mbed TLS 4<br><=
br>This commit adds support for Mbed TLS 4. This version comes with some<br=
>drastic changes. The crypto library has been completely redesigned, so<br>=
the contents of crypto_mbedtls.c are moved to crypto_mbedtls_legacy.c<br>an=
d crypto_mbedtls.c handles the crypto for version 4.<br><br>Mbed TLS 4 also=
 removed the feature for looking up a crypto algorithm by<br>name, so we ne=
ed to translate algorithm names to Mbed TLS numbers in<br>OpenVPN. The tabl=
es are not yet complete. For symmetric algorithms, I<br>have added AES and =
Chacha-Poly which should be enough for most use<br>cases.<br><br>Change-Id:=
 Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae<br>Signed-off-by: Max Fillinger =
&lt;maximilian.fillinger@...2918...&gt;<br>Acked-by: Arne Schwabe &lt;arne-=
openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/=
+/1441<br>Message-Id: &lt;20260123164746.7333-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35401.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M REA=
DME.mbedtls<br>M src/openvpn/Makefile.am<br>M src/openvpn/crypto_backend.h<=
br>M src/openvpn/crypto_mbedtls.c<br>M src/openvpn/crypto_mbedtls.h<br>A sr=
c/openvpn/crypto_mbedtls_legacy.c<br>A src/openvpn/crypto_mbedtls_legacy.h<=
br>M src/openvpn/mbedtls_compat.h<br>M src/openvpn/ssl_mbedtls.c<br>M src/o=
penvpn/ssl_mbedtls.h<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn=
/syshead.h<br>M tests/Makefile.am<br>M tests/t_server_null_default.rc<br>M =
tests/unit_tests/openvpn/Makefile.am<br>M tests/unit_tests/openvpn/test_com=
mon.h<br>16 files changed, 2,442 insertions(+), 704 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/41/1441/8</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/README.mbedtls b/README.mbedtls</span><br=
><span>index fb30db1..b768687 100644</span><br><span>--- a/README.mbedtls</=
span><br><span>+++ b/README.mbedtls</span><br><span>@@ -7,8 +7,8 @@</span><=
br><span> 	make</span><br><span> 	make install</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-This version requires mbed TLS v=
ersion &gt;=3D 3.2.1. Versions &gt;=3D 4.0.0 are not</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-yet supported. Support for TLS 1.3 requires=
 an Mbed TLS version &gt;=3D 3.6.4.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+This version requires mbed TLS version &gt;=3D 3.2.1. Suppo=
rt for TLS 1.3 requires</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+an Mbed TLS version &gt;=3D 3.6.4.</span><br><span> </span><br><span> *=
************************************************************************</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/Makefile.am b/src/=
openvpn/Makefile.am</span><br><span>index c879585..3c567aa 100644</span><br=
><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Make=
file.am</span><br><span>@@ -54,6 +54,7 @@</span><br><span> 	comp-lz4.c comp=
-lz4.h \</span><br><span> 	crypto.c crypto.h crypto_backend.h \</span><br><=
span> 	crypto_openssl.c crypto_openssl.h \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	crypto_mbedtls_legacy.c crypto_mbedtls_legacy.h \</=
span><br><span> 	crypto_mbedtls.c crypto_mbedtls.h \</span><br><span> 	cryp=
to_epoch.c crypto_epoch.h \</span><br><span> 	dco.c dco.h dco_internal.h \<=
/span><br><span>diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/cry=
pto_backend.h</span><br><span>index e9fc2f3..5248614 100644</span><br><span=
>--- a/src/openvpn/crypto_backend.h</span><br><span>+++ b/src/openvpn/crypt=
o_backend.h</span><br><span>@@ -32,9 +32,16 @@</span><br><span> #ifdef ENAB=
LE_CRYPTO_OPENSSL</span><br><span> #include &quot;crypto_openssl.h&quot;</s=
pan><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> #ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;mbedtls/version.h&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt;=
 0x04000000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;crypto_mbedtls_legacy.h&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#else</span><br><span> #include &quot;crypto_mbedtls.h&quo=
t;</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> #include &quot;basic.h&quot;</span><br><span> #include &quot;bu=
ffer.h&quot;</span><br><span> </span><br><span>diff --git a/src/openvpn/cry=
pto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index e1a5cad.=
.5418df9 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><b=
r><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -23,7 +23,8 @=
@</span><br><span> </span><br><span> /**</span><br><span>  * @file</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * Data Channel Cryptography m=
bed TLS-specific backend interface</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Data Channel Cryptography backend interface using the TF-=
PSA-Crypto library</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* part of Mbed TLS 4.</span><br><span>  */</span><br><span> </span><br><spa=
n> #ifdef HAVE_CONFIG_H</span><br><span>@@ -33,6 +34,9 @@</span><br><span> =
#include &quot;syshead.h&quot;</span><br><span> </span><br><span> #if defin=
ed(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;mbedtls/version.h&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span> </span><br=
><span> #include &quot;errlevel.h&quot;</span><br><span> #include &quot;bas=
ic.h&quot;</span><br><span>@@ -40,20 +44,16 @@</span><br><span> #include &q=
uot;crypto.h&quot;</span><br><span> #include &quot;integer.h&quot;</span><b=
r><span> #include &quot;crypto_backend.h&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;crypto_mbedtls.h&quot;</span><br>=
<span> #include &quot;otime.h&quot;</span><br><span> #include &quot;misc.h&=
quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#include &lt;mbedtls/base64.h&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#include &lt;mbedtls/des.h&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;psa/crypto.h&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;psa/crypto_config.h&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/co=
nstant_time.h&gt;</span><br><span> #include &lt;mbedtls/error.h&gt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/md5.h&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls=
/cipher.h&gt;</span><br><span> #include &lt;mbedtls/pem.h&gt;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbed=
tls/entropy.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inc=
lude &lt;mbedtls/ssl.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> /*</span><br><span>  *</span><br><span>  * Hardware engine support. Allow=
s loading/unloading of engines.</span><br><span>@@ -82,331 +82,65 @@</span>=
<br><span> {</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Functio=
ns related to the core crypto library</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The library does=
n&#39;t support looking up algorithms by string anymore, so here</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * is a lookup table. */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static const cipher_info_=
t cipher_info_table[] =3D {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* TODO: Complete the table. */</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-crypto_init_lib(void)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* AES */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if PSA_WANT_KEY_TYPE_AES</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if PSA_WANT_ALG_GCM</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-128-GC=
M&quot;, PSA_KEY_TYPE_AES, PSA_ALG_GCM, 128 / 8, 96 / 8, 128 / 8 },</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-192-GCM&quo=
t;, PSA_KEY_TYPE_AES, PSA_ALG_GCM, 192 / 8, 96 / 8, 128 / 8 },</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-256-GCM&quot;, P=
SA_KEY_TYPE_AES, PSA_ALG_GCM, 256 / 8, 96 / 8, 128 / 8 },</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif /* PSA_WANT_ALG_GCM */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if PSA_WANT_ALG_CBC_PKCS7<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-128-=
CBC&quot;, PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 128 / 8, 128 / 8, 128 / 8 }=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-19=
2-CBC&quot;, PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 192 / 8, 128 / 8, 128 / 8=
 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;AES-=
256-CBC&quot;, PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 256 / 8, 128 / 8, 128 /=
 8 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* PSA_=
WANT_ALG_CBC_PKCS7 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if PSA_WANT_ALG_CTR</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    { &quot;AES-128-CTR&quot;, PSA_KEY_TYPE_AES, PSA_ALG_CTR, 128 / 8, 1=
28 / 8, 128 / 8 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   { &quot;AES-192-CTR&quot;, PSA_KEY_TYPE_AES, PSA_ALG_CTR, 192 / 8, 128 /=
 8, 128 / 8 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
 &quot;AES-256-CTR&quot;, PSA_KEY_TYPE_AES, PSA_ALG_CTR, 256 / 8, 128 / 8, =
128 / 8 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /*=
 PSA_WANT_ALG_CTR */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* PSA_WANT_KEY_TYPE_AES */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-crypto_uninit_lib(void)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-crypto_clear_error(void)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-mbed_log_err(unsigned int flags, int errval, const char *pre=
fix)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (0 !=3D errval)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        char errstr[256];</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        mbedtls_strerror(errval, errstr, sizeof(=
errstr));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (NULL =3D=3D prefix)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            prefix =3D &quot;mbed T=
LS error&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(flags,=
 &quot;%s: %s&quot;, prefix, errstr);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0 =3D=3D e=
rrval;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-mbed_log_func_line(unsigned int flags, int errval, const char *func, int =
line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    char prefix[256];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (snprintf(prefix, sizeof(prefix), &quot;%s:%d&quot=
;, func, line) &gt;=3D sizeof(prefix))</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return mbed_log_err(flags, errval, func);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn mbed_log_err(flags, errval, prefix);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef DMALLOC</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-crypto_init_dmalloc(void)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(=
M_ERR, &quot;Error: dmalloc support is not available for mbed TLS.&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif /* DMALLOC */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-const cipher_name_pair cipher_name_translation_table[] =3D {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;BF-CBC&quot;,=
 &quot;BLOWFISH-CBC&quot; },</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    { &quot;BF-CFB&quot;, &quot;BLOWFISH-CFB64&quot; },</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    { &quot;CAMELLIA-128-CFB&quot;=
, &quot;CAMELLIA-128-CFB128&quot; },</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    { &quot;CAMELLIA-192-CFB&quot;, &quot;CAMELLIA-192-CFB12=
8&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot=
;CAMELLIA-256-CFB&quot;, &quot;CAMELLIA-256-CFB128&quot; }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Chacha-Poly */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if PSA_WANT_KEY_TYPE_CHACHA20 &amp;&a=
mp; PSA_WANT_ALG_CHACHA20_POLY1305</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    { &quot;CHACHA20-POLY1305&quot;, PSA_KEY_TYPE_CHACHA20, =
PSA_ALG_CHACHA20_POLY1305, 256 / 8, 96 / 8, 1 },</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span> };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static const size_t cipher_info_table_e=
ntries =3D sizeof(cipher_info_table) / sizeof(cipher_info_t);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static const cipher_info_t *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+cipher_get(const char *ciphername)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; cipher_info_=
table_entries; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (st=
rcmp(ciphername, cipher_info_table[i].name) =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return &amp;cipher_info_table[i];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Because Mbe=
d TLS 4 doesn&#39;t support looking up algorithms by string, there&#39;s</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * nothing to translat=
e. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const cipher_n=
ame_pair cipher_name_translation_table[] =3D {};</span><br><span> const siz=
e_t cipher_name_translation_table_count =3D</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    sizeof(cipher_name_translation_table) / sizeof(*c=
ipher_name_translation_table);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-show_available_ciphers(void)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const int *ciphers =3D mbedtls_cipher_=
list();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;The following ciphe=
rs and cipher modes are available for use\n&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-           &quot;with &quot; PACKAGE_NAME &quot=
;.  Each cipher shown below may be used as a\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-           &quot;parameter to the --data-ci=
phers (or --cipher) option.  Using a\n&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-           &quot;GCM or CBC mode is recommended.  In=
 static key mode only CBC\n&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-           &quot;mode is allowed.\n\n&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    while (*ciphers !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        co=
nst mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_type(*ciphers)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *=
name =3D mbedtls_cipher_info_get_name(info);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (info &amp;&amp; name &amp;&amp; !cipher_=
kt_insecure(name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        &amp;&amp; (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            print_cipher(name);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        ciphers++;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    printf(&quot;\nThe following ciphers have a block size of less than 128=
 bits, \n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
     &quot;and are therefore deprecated.  Do not use unless you have to.\n\=
n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ciphers =
=3D mbedtls_cipher_list();</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    while (*ciphers !=3D 0)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_type(*cip=
hers);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const c=
har *name =3D mbedtls_cipher_info_get_name(info);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (info &amp;&amp; name &amp;&amp; cip=
her_kt_insecure(name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            &amp;&amp; (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(nam=
e)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            print_cipher(name=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        ciphers++;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    printf(&quot;\n&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-show_available_digests(voi=
d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const int *digests =3D mbedtls_md_l=
ist();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;The following messag=
e digests are available for use with\n&quot; PACKAGE_NAME</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-           &quot;.  A message digest is=
 used in conjunction with\n&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-           &quot;the HMAC function, to authenticate received pa=
ckets.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
    &quot;You can specify a message digest as parameter to\n&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-           &quot;the --auth op=
tion.\n\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    while (*digests !=3D 0)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        const mbedtls_md_info_t *info =3D mbedtls_=
md_info_from_type(*digests);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (in=
fo)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            printf(&quot;%s %d=
 bit default key\n&quot;, mbedtls_md_get_name(info),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                   mbedtls_md_get_size(info=
) * 8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        digests++;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;\n&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_available_engin=
es(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;Sorry, mbed TLS =
hardware crypto engine functionality is not &quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-           &quot;available\n&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconv=
ersion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-crypto_pem_encode(const char *name, struct buffer *dst, cons=
t struct buffer *src,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                  struct gc_arena *gc)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    char header[1000 + 1] =3D=
 { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char foote=
r[1000 + 1] =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (snprintf(hea=
der, sizeof(header), &quot;-----BEGIN %s-----\n&quot;, name) &gt;=3D sizeof=
(header))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (snprintf(footer, sizeof(footer), &q=
uot;-----END %s-----\n&quot;, name) &gt;=3D sizeof(footer))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t out_=
len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (MBE=
DTLS_ERR_BASE64_BUFFER_TOO_SMALL</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        !=3D mbedtls_pem_write_buffer(header, footer, BPTR(src),=
 BLEN(src), NULL, 0, &amp;out_len))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* We set the size buf to out_len-1=
 to NOT include the 0 byte that</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-     * mbedtls_pem_write_buffer in its length calculation */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    *dst =3D alloc_buf_gc(=
out_len, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), BPT=
R(dst),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                            BCAP(dst), &amp;out_len))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        || !buf_inc_len(dst, out_len - 1))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(*dst);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-crypto_pem_decode(const char *name, struct buffer *dst, const st=
ruct buffer *src)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* 1000 chars is the=
 PEM line length limit (+1 for tailing NUL) */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    char header[1000 + 1] =3D { 0 };</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    char footer[1000 + 1] =3D { 0 }=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (snprintf(header, sizeof(header), =
&quot;-----BEGIN %s-----&quot;, name) &gt;=3D sizeof(header))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (snprintf(footer, sizeof(footer), &quot;-----END %s-----&quo=
t;, name) &gt;=3D sizeof(footer))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* mbed TLS requires the src to be nu=
ll-terminated */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* allocate a new buffer to avoid modifying the src buffer */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer inp=
ut =3D alloc_buf_gc(BLEN(src) + 1, &amp;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    buf_copy(&amp;input, src);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf_null_terminate(&amp;input);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    size_t use_len =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    mbedtls_pem_context ctx =3D { 0 };</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        mbed_ok(mbedtls_pem_read_b=
uffer(&amp;ctx, header, footer, BPTR(&amp;input), NULL, 0, &amp;use_len));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t buf_size =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsig=
ned char *buf =3D mbedtls_pem_get_buffer(&amp;ctx, &amp;buf_size);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (ret &amp;&amp; !buf_wr=
ite(dst, buf, buf_size))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =
=3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(M_WARN, &quot;PEM decode error: destination buffer too small&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    mbedtls_pem_free(&amp;ctx);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Random number functions, used in cases where we want</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * reasonably strong cryptog=
raphic random number generation</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * without depleting our entropy pool.  Used for random</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * IV values and a number of ot=
her miscellaneous tasks.</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * Initialise the given ctr_drbg context, using a personalisation string a=
nd an</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * entropy gathe=
ring function.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_ctr_drbg_context =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rand_ctx_get(void)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    static mbedtls_entropy_context ec =3D {=
 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static mbedt=
ls_ctr_drbg_context cd_ctx =3D { 0 };</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    static bool rand_initialised =3D false;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (!rand_initialised)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        struct gc_arena gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        struct buffer pers_string =3D alloc_buf_gc=
(100, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-         * Personalisation string, sho=
uld be as unique as possible (see NIST</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-         * 800-90 section 8.7.1). We have very little info=
rmation at this stage.</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-         * Include Program Name, memory address of the context and PID.</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;pers_strin=
g, &quot;OpenVPN %0u %p %s&quot;, platform_getpid(), &amp;cd_ctx,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                   time_string(=
0, 0, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Initialise m=
bed TLS RNG, and built-in entropy sources */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        mbedtls_entropy_init(&amp;ec);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        mbedtls_ctr_drbg_init(&amp;cd_ctx);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (!mbed_ok(mbedtls_ctr_d=
rbg_seed(&amp;cd_ctx, mbedtls_entropy_func, &amp;ec, BPTR(&amp;pers_string)=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
                       BLEN(&amp;pers_string))))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            msg(M_FATAL, &quot;Failed to initialize random g=
enerator&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        rand_initialised =3D true;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return &amp;cd_ctx;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICTI=
ON_RESISTANCE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-rand_ctx_enable_predictio=
n_resistance(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_co=
ntext *cd_ctx =3D rand_ctx_get();</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedt=
ls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif /* ENABLE_PREDICTION_RESISTANCE */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    sizeof(cipher_name_translation_table) / s=
izeof(cipher_name_pair);</span><br><span> </span><br><span> int</span><br><=
span> rand_bytes(uint8_t *output, int len)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_context *rng_c=
tx =3D rand_ctx_get();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (len &gt; =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; =
0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        const size_t blen =3D min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (0 !=3D =
mbedtls_ctr_drbg_random(rng_ctx, output, blen))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            return 0;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        output +=3D=
 blen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        len -=
=3D blen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn 0;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 1=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Generic cipher key ty=
pe functions</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static const mbedtls_cipher_info_t *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-cipher_get(const char *cipherna=
me)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(ciphername);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher =3D NULL;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ciphername =3D translate_cipher_name_from_open=
vpn(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
ipher =3D mbedtls_cipher_info_from_string(ciphername);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return cipher;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    psa_status_t result =3D psa_generate_=
random(output, (size_t)len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return result =3D=3D PSA_SUCCESS;</span><br><span> }</span><br=
><span> </span><br><span> bool</span><br><span>@@ -414,23 +148,22 @@</span>=
<br><span> {</span><br><span>     ASSERT(reason);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info=
_t *cipher =3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const cipher_info_t *cipher_info =3D cipher_get(ciph=
ername);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (NULL =3D=3D cipher)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (cipher_info =3D=3D NULL)</span><br><span>     {</span>=
<br><span>         msg(D_LOW, &quot;Cipher algorithm &#39;%s&#39; not found=
&quot;, ciphername);</span><br><span>         *reason =3D &quot;disabled be=
cause unknown&quot;;</span><br><span>         return false;</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    const size_t key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(cip=
her) / 8;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (key_=
bytelen &gt; MAX_CIPHER_KEY_LENGTH)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (cipher_info-&gt;key_bytes &gt; MAX_CIPHER_KEY_LENGT=
H)</span><br><span>     {</span><br><span>         msg(D_LOW,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            &quot;Cipher algorithm =
&#39;%s&#39; uses a default key size (%zu bytes) &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            &quot;Cipher algorithm &#39=
;%s&#39; uses a default key size (%d bytes) &quot;</span><br><span>        =
     &quot;which is larger than &quot; PACKAGE_NAME &quot;&#39;s current ma=
ximum key size &quot;</span><br><span>             &quot;(%d bytes)&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ciphername=
, key_bytelen, MAX_CIPHER_KEY_LENGTH);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            ciphername, cipher_info-&gt;key_bytes, MAX_C=
IPHER_KEY_LENGTH);</span><br><span>         *reason =3D &quot;disabled due =
to key size too large&quot;;</span><br><span>         return false;</span><=
br><span>     }</span><br><span>@@ -442,49 +175,46 @@</span><br><span> cons=
t char *</span><br><span> cipher_kt_name(const char *ciphername)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbe=
dtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D cipher_kt)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const cipher_info_t *cip=
her_info =3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (cipher_info =3D=3D NULL)</span><br><span>     {</s=
pan><br><span>         return &quot;[null-cipher]&quot;;</span><br><span>  =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return translate_cipher_name_to_op=
envpn(mbedtls_cipher_info_get_name(cipher_kt));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return cipher_info-&gt;name;</span><br><spa=
n> }</span><br><span> </span><br><span> int</span><br><span> cipher_kt_key_=
size(const char *ciphername)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher_kt =3D ci=
pher_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D c=
ipher_kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
cipher_info_t *cipher_info =3D cipher_get(ciphername);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (cipher_info =3D=3D NULL)</span><=
br><span>     {</span><br><span>         return 0;</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return (int)mbedtls_cipher_info_get_key=
_bitlen(cipher_kt) / 8;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return cipher_info-&gt;key_bytes;</span><br><span> }</span><br><spa=
n> </span><br><span> int</span><br><span> cipher_kt_iv_size(const char *cip=
hername)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cipher_i=
nfo_t *cipher_info =3D cipher_get(ciphername);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D cipher_kt)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_info =
=3D=3D NULL)</span><br><span>     {</span><br><span>         return 0;</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return (int)mbedtls_cipher_info_get_iv_size(cipher_kt);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return cipher_info-&gt;iv_bytes;</=
span><br><span> }</span><br><span> </span><br><span> int</span><br><span> c=
ipher_kt_block_size(const char *ciphername)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *c=
ipher_kt =3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (NULL =3D=3D cipher_kt)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const cipher_info_t *cipher_info =3D cipher_g=
et(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (cipher_info =3D=3D NULL)</span><br><span>     {</span><br><span>       =
  return 0;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return (int)mbedtls_cipher_info_get_block_size(cipher_kt);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cipher_i=
nfo-&gt;block_size;</span><br><span> }</span><br><span> </span><br><span> i=
nt</span><br><span>@@ -500,498 +230,596 @@</span><br><span> bool</span><br>=
<span> cipher_kt_insecure(const char *ciphername)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_inf=
o_t *cipher_kt =3D cipher_get(ciphername);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (!cipher_kt)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const cipher_info_t *cipher_info =3D cipher_get(ci=
phername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
ipher_info =3D=3D NULL)</span><br><span>     {</span><br><span>         ret=
urn true;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return !(cipher_kt_block_size(ciphername) =
&gt;=3D 128 / 8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 MBEDTLS_CHACHAPOLY_C</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
             || mbedtls_cipher_info_get_type(cipher_kt) =3D=3D MBEDTLS_CIPH=
ER_CHACHA20_POLY1305</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    );</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static mbedtls_cipher_mode_t</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D cipher_kt);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_info_get_mode(c=
ipher_kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n !(cipher_info-&gt;block_size &gt;=3D 128 / 8</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+             || cipher_info-&gt;psa_alg =3D=3D P=
SA_ALG_CHACHA20_POLY1305);</span><br><span> }</span><br><span> </span><br><=
span> bool</span><br><span> cipher_kt_mode_cbc(const char *ciphername)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return cipher &amp;&amp; cipher_=
kt_mode(cipher) =3D=3D OPENVPN_MODE_CBC;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const cipher_info_t *cipher_info =3D cipher_get(ci=
phername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
ipher_info =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cipher_info=
-&gt;psa_alg =3D=3D PSA_ALG_CBC_PKCS7;</span><br><span> }</span><br><span> =
</span><br><span> bool</span><br><span> cipher_kt_mode_ofb_cfb(const char *=
ciphername)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; (c=
ipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_OFB</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-               || cipher_kt_mode(cipher) =3D=3D OPE=
NVPN_MODE_CFB);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const cipher_info_t *cipher_info =3D cipher_get(ciphername);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_info =3D=3D NULL)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return cipher_info-&gt;psa_alg =3D=3D PSA_A=
LG_OFB || cipher_info-&gt;psa_alg =3D=3D PSA_ALG_CFB;</span><br><span> }</s=
pan><br><span> </span><br><span> bool</span><br><span> cipher_kt_mode_aead(=
const char *ciphername)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher =3D cipher_get=
(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn cipher</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &=
amp;&amp; (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_GCM</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#ifdef MBEDTLS_CHACHAPOLY_C</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-               || cipher_kt_mode(=
cipher) =3D=3D MBEDTLS_MODE_CHACHAPOLY</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-           );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const cipher_info_t *cipher_info =3D cipher_get(ciphername);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_info =3D=3D NULL)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return cipher_info-&gt;psa_alg =3D=3D PSA_A=
LG_GCM || cipher_info-&gt;psa_alg =3D=3D PSA_ALG_CHACHA20_POLY1305;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Generic cipher context functions</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_cipher_conte=
xt_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_t =
*</span><br><span> cipher_ctx_new(void)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_cipher_context_t *ctx;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ(ctx, mbedtl=
s_cipher_context_t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    cipher_ctx_t *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Initializing the object with zeros ensures that it is always saf=
e to call</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * cip=
her_ctx_free. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ALLOC_OBJ_CLEAR(ctx, cipher_ctx_t);</span><br><span>     return ctx;</span=
><br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_free(mbedtls_cipher_context_t *c=
tx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_free(=
cipher_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    mbedtls_cipher_free(ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (cipher_ctx_mode_aead(ctx))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        ASSERT(psa_aead_abort(&amp;ctx-&gt;opera=
tion.aead) =3D=3D PSA_SUCCESS);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(psa_cipher_a=
bort(&amp;ctx-&gt;operation.cipher) =3D=3D PSA_SUCCESS);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ASSERT(psa_destroy_key(ctx-&gt;key) =3D=3D PSA_S=
UCCESS);</span><br><span>     free(ctx);</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, const=
 char *ciphername,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
ipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, const char *ciphernam=
e,</span><br><span>                 crypto_operation_t enc)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=
=3D ciphername &amp;&amp; NULL !=3D ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(ciphername !=3D NULL &amp;&amp; ctx !=3D N=
ULL);</span><br><span>     CLEAR(*ctx);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *kt =3D=
 cipher_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    ASSERT(kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 size_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(kt);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;cipher_info =3D ciph=
er_get(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(ctx-&gt;cipher_info !=3D NULL);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_setu=
p(ctx, kt)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quo=
t;mbed TLS cipher context init #1&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    psa_set_key_type(&amp;ctx-&gt;key_attributes, ctx-&gt;cipher_info=
-&gt;psa_key_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    psa_set_key_algorithm(&amp;ctx-&gt;key_attributes, ctx-&gt;cipher_info-=
&gt;psa_alg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ps=
a_set_key_bits(&amp;ctx-&gt;key_attributes, (size_t)ctx-&gt;cipher_info-&gt=
;key_bytes * 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 psa_set_key_usage_flags(&amp;ctx-&gt;key_attributes,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            enc =3D=3D OP=
ENVPN_OP_ENCRYPT ? PSA_KEY_USAGE_ENCRYPT : PSA_KEY_USAGE_DECRYPT);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbe=
d_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, enc)))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (psa_import_key(&amp;ctx-&g=
t;key_attributes, key, (size_t)ctx-&gt;cipher_info-&gt;key_bytes, &amp;ctx-=
&gt;key) !=3D PSA_SUCCESS)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;mbed TLS cipher set =
key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (mbedtls_cipher_info_get_mode(kt) =3D=3D=
 MBEDTLS_MODE_CBC)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!mbed_o=
k(mbedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_PKCS7)))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;mbed TLS cip=
her set padding mode&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_FATAL, &quot;psa_import_key failed&quot;);</span><br><span>     =
}</span><br><span> </span><br><span>     /* make sure we used a big enough =
key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mbed=
tls_cipher_get_key_bitlen(ctx) &lt;=3D key_bitlen);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(psa_get_key_bits(&amp;ctx-&gt;=
key_attributes) =3D=3D (size_t)(8 * ctx-&gt;cipher_info-&gt;key_bytes));</s=
pan><br><span> }</span><br><span> </span><br><span> int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_iv_length(const mbedtls_cipher=
_context_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cip=
her_ctx_iv_length(const cipher_ctx_t *ctx)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_get_iv_si=
ze(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
ctx-&gt;cipher_info-&gt;iv_bytes;</span><br><span> }</span><br><span> </spa=
n><br><span> int</span><br><span> cipher_ctx_get_tag(cipher_ctx_t *ctx, uin=
t8_t *tag, int tag_len)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (tag_len &gt; SIZE_MAX)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!ctx-&gt;aead_finished || tag_len=
 &lt; OPENVPN_AEAD_TAG_LENGTH)</span><br><span>     {</span><br><span>     =
    return 0;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_write_tag(=
ctx, (unsigned char *)tag, tag_len)))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    memcpy(tag, ctx-&gt;tag, OPENVPN_AE=
AD_TAG_LENGTH);</span><br><span>     return 1;</span><br><span> }</span><br=
><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_block_size(const =
cipher_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return (int)mbedtls_cipher_get_block_size(ctx);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctx-&gt;cipher_i=
nfo-&gt;block_size;</span><br><span> }</span><br><span> </span><br><span> i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_mode(con=
st mbedtls_cipher_context_t *ctx)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+cipher_ctx_mode(const cipher_ctx_t *ctx)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ct=
x);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_get_cipher_mo=
de(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
ctx !=3D NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return (int)psa_get_key_algorithm(&amp;ctx-&gt;key_attributes);</span><br><=
span> }</span><br><span> </span><br><span> bool</span><br><span> cipher_ctx=
_mode_cbc(const cipher_ctx_t *ctx)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return ctx &amp;&amp; cipher_ctx_mode(c=
tx) =3D=3D OPENVPN_MODE_CBC;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return ctx !=3D NULL &amp;&amp; cipher_ctx_mode(ctx) =3D=3D OP=
ENVPN_MODE_CBC;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> cip=
her_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return ctx</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; (cipher_ctx_mode(=
ctx) =3D=3D OPENVPN_MODE_OFB</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-               || cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CFB);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ctx =3D=3D NULL=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int mode =3D cipher_ctx_mode(ctx);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return mode =3D=3D OP=
ENVPN_MODE_OFB || mode =3D=3D OPENVPN_MODE_CFB;</span><br><span> }</span><b=
r><span> </span><br><span> bool</span><br><span> cipher_ctx_mode_aead(const=
 cipher_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return ctx</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-           &amp;&amp; (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_G=
CM</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef MBEDTLS_CHAC=
HAPOLY_C</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
  || cipher_ctx_mode(ctx) =3D=3D MBEDTLS_MODE_CHACHAPOLY</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-           );</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (ctx =3D=3D NULL)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 mode =3D cipher_ctx_mode(ctx);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return mode =3D=3D (int)PSA_ALG_GCM || mode =3D=3D (int)PSA=
_ALG_CHACHA20_POLY1305;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_direction(const cipher_ctx_t *=
ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    psa_key_usage_t key_usage =3D=
 psa_get_key_usage_flags(&amp;ctx-&gt;key_attributes);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (key_usage &amp; PSA_KEY_USAGE_EN=
CRYPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return OPENVPN_OP_E=
NCRYPT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (key_usage &am=
p; PSA_KEY_USAGE_DECRYPT)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return OPENVPN_OP_DECRYPT;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><b=
r><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-cipher_ctx_reset(mbedtls_cipher_context_t *ctx, const uint8_t *iv_=
buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_rese=
t(cipher_ctx_t *ctx, const uint8_t *iv_buf)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_re=
set(ctx)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    psa_status_t status =3D 0;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(m=
bedtls_cipher_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx)))=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_ctx=
_mode_aead(ctx))</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (psa_aead_abort(&amp;ctx-&gt;operation.aead) !=
=3D PSA_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (cipher_ctx_direction(ctx) =
=3D=3D OPENVPN_OP_ENCRYPT)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         status =3D psa_aead_encrypt_setup(&amp;ctx-&gt;operation.aead, ctx=
-&gt;key, ctx-&gt;cipher_info-&gt;psa_alg);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        else if (cipher_ctx_direction(ctx) =3D=3D OPENVPN_OP_=
DECRYPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            status =
=3D psa_aead_decrypt_setup(&amp;ctx-&gt;operation.aead, ctx-&gt;key, ctx-&g=
t;cipher_info-&gt;psa_alg);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (status !=3D PSA_SUCCESS)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            return 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        status =3D psa_aead_set_nonce(&amp;ctx-&gt;operation.aead,=
 iv_buf, ctx-&gt;cipher_info-&gt;iv_bytes);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (status !=3D PSA_SUCCESS)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (psa=
_cipher_abort(&amp;ctx-&gt;operation.cipher) !=3D PSA_SUCCESS)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (cipher_ctx_direction(ctx) =3D=3D OPENVPN_OP_ENCRYPT)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            status =3D psa_cipher=
_encrypt_setup(&amp;ctx-&gt;operation.cipher, ctx-&gt;key, ctx-&gt;cipher_i=
nfo-&gt;psa_alg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
 if (cipher_ctx_direction(ctx) =3D=3D OPENVPN_OP_DECRYPT)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            status =3D psa_cipher_decrypt_setup=
(&amp;ctx-&gt;operation.cipher, ctx-&gt;key, ctx-&gt;cipher_info-&gt;psa_al=
g);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (status !=3D PSA_SUCCESS)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        statu=
s =3D psa_cipher_set_iv(&amp;ctx-&gt;operation.cipher, iv_buf, ctx-&gt;ciph=
er_info-&gt;iv_bytes);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (status !=3D PSA_SUCCESS)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span>     }</span><br><span> </span><br><s=
pan>     return 1;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* We rely on the caller to ensure that=
 the destination buffer has enough room,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * but Mbed TLS always wants a size for the destinatio=
n buffer. This function</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * calculates the minimum necessary size for a given cipher and input l=
ength.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * This funcion assumes that s=
rc_len has been checked to be &gt;=3D 0. */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static size_t</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+needed_dst_size(const cipher_ctx_t *ctx, int src_len)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int mode =3D cipher_ctx_mode(ctx);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mode =3D=3D PS=
A_ALG_CTR || mode =3D=3D PSA_ALG_GCM || mode =3D=3D PSA_ALG_CHACHA20_POLY13=
05)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* These algorithms ar=
e based on a keystream, so the input and output</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * length are always equal. */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return (size_t)src_l=
en;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* These algorithms are block-based. The number=
 of output blocks that are</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * produced is at most 1 + src_len / block_size. */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        size_t block_size =
=3D (size_t)cipher_ctx_block_size(ctx);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        size_t max_blocks =3D 1 + (size_t)src_len / blo=
ck_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn max_blocks * block_size;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</=
span><br><span> cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src,=
 int src_len)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (src_len &gt; SIZE_MAX)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (src_len &lt; 0 || !cipher_ctx_mode_aead(ctx))=
</span><br><span>     {</span><br><span>         return 0;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!mbed_ok(mbedtls_cipher_update_ad(ctx, src, src_len)))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (psa_aead_update_ad(&a=
mp;ctx-&gt;operation.aead, src, (size_t)src_len) !=3D PSA_SUCCESS)</span><b=
r><span>     {</span><br><span>         return 0;</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher=
_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src, in=
t src_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (src_len &lt; 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    size_t dst_size =3D needed_dst_size(ctx, src_len);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    size_t psa_output_len =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_status_t status =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_ctx_mode_aead(ctx=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        status =3D psa_aead_upd=
ate(&amp;ctx-&gt;operation.aead, src, (size_t)src_len, dst, dst_size, &amp;=
psa_output_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        status =3D psa_cipher_update(&amp=
;ctx-&gt;operation.cipher, src, (size_t)src_len, dst, dst_size, &amp;psa_ou=
tput_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (status !=3D PSA_SUCCESS)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (psa_output_len &gt; INT_MAX)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *dst_len=
 =3D (int)psa_output_len;</span><br><span> </span><br><span>     return 1;<=
/span><br><span> }</span><br><span> </span><br><span> int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_update(mbedtls_cipher_contex=
t_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                  int src_len)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_final(cipher_ctx_t *c=
tx, uint8_t *dst, int *dst_len)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    size_t s_dst_len =3D *dst_len;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    size_t dst_size =3D needed_=
dst_size(ctx, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  size_t psa_output_len =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    psa_status_t status =3D 0;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_updat=
e(ctx, src, (size_t)src_len, dst, &amp;s_dst_len)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (cipher_ctx_mode_aead(ctx))</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 size_t actual_tag_size =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        status =3D psa_aead_finish(&amp;ctx-&gt;operation.aead,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
             dst,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                               dst_size,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                 &amp;psa_output_len,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
             ctx-&gt;tag,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                 (size_t)OPENVPN_AEAD_TAG_LENGTH,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
          &amp;actual_tag_size);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (status !=3D PSA_SUCCESS || psa_output_len &gt; (si=
ze_t)INT_MAX || actual_tag_size !=3D (size_t)OPENVPN_AEAD_TAG_LENGTH)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ctx-&gt;aead_finished =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        status =3D psa_cipher_finish(&amp;ctx-&gt;operation.=
cipher, dst, dst_size, &amp;psa_output_len);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (status !=3D PSA_SUCCESS || psa_output_=
len &gt; (size_t)INT_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    *dst_len =3D s_dst_len;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    *dst_len =3D (int)psa_output_len;</s=
pan><br><span> </span><br><span>     return 1;</span><br><span> }</span><br=
><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-cipher_ctx_final(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *=
dst_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_=
final_check_tag(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *tag=
, size_t tag_len)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    size_t s_dst_len =3D *dst_len;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &amp;s_dst_len)))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_ctx_di=
rection(ctx) !=3D OPENVPN_OP_DECRYPT || !cipher_ctx_mode_aead(ctx))</span><=
br><span>     {</span><br><span>         return 0;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *=
dst_len =3D s_dst_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    size_t psa_output_len =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    psa_status_t status =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    status =3D psa_aead_verify(&amp;ctx-&gt;operation.aead, dst, 0,=
 &amp;psa_output_len, tag, tag_len);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (status !=3D PSA_SUCCESS || psa_output_len &gt; (si=
ze_t)INT_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    *dst_len =3D (int)psa_output_len=
;</span><br><span> </span><br><span>     return 1;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_final_check_tag(=
mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, uint8_t *tag,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
   size_t tag_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic const md_info_t md_info_table[] =3D {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* TODO: Fill out table. */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    { &quot;MD5&quot;, PSA_ALG_MD5 },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;SHA1&quot=
;, PSA_ALG_SHA_1 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    { &quot;SHA256&quot;, PSA_ALG_SHA_256 },</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+const size_t md_info_table_entries =3D sizeof(md_info_table) / size=
of(md_info_t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static const md_info_t *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_get(const char *=
digest_name)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    size_t olen =3D 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (MB=
EDTLS_DECRYPT !=3D mbedtls_cipher_get_operation(ctx))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; md_info_t=
able_entries; i++)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (strcmp(digest_name, md_info_table[i].name) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return &=
amp;md_info_table[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
tag_len &gt; SIZE_MAX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return =
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &amp;ol=
en)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_CRYPT_ERRORS, &quo=
t;%s: cipher_ctx_final() failed&quot;, __func__);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (olen =
&gt; INT_MAX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    *dst_len =3D olen;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!mbed_ok(mbedtls_cipher_check_tag(ctx, (const unsigned =
char *)tag, tag_len)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return =
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return 1;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Generic message digest information functions</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static const mbedtls_md_info_t *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-md_get(const char *digest)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const mbedtls_md_info_t *md =3D NULL;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(digest);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    md =3D mbedtls_md_info_from_string(digest);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!md)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_FATAL, &quot;Message hash algorithm &#39;%s&#=
39; not found&quot;, digest);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
mbedtls_md_get_size(md) &gt; MAX_HMAC_KEY_LENGTH)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            &quot;Message hash algorithm &#39;%s&#39; uses a def=
ault hash size (%d bytes) which is larger than &quot; PACKAGE_NAME</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;&#39;s curre=
nt maximum hash size (%d bytes)&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            digest, mbedtls_md_get_size(md), MAX_HMAC_KEY_=
LENGTH);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return md;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span> =
}</span><br><span> </span><br><span> bool</span><br><span> md_valid(const c=
har *digest)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    const mbedtls_md_info_t *md =3D mbedtls_md_info_from_string(d=
igest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const md=
_info_t *md =3D md_get(digest);</span><br><span>     return md !=3D NULL;</=
span><br><span> }</span><br><span> </span><br><span> const char *</span><br=
><span> md_kt_name(const char *mdname)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!strcmp(&quot;none&quot;, mdnam=
e))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(&=
quot;none&quot;, mdname) =3D=3D 0)</span><br><span>     {</span><br><span> =
        return &quot;[null-digest]&quot;;</span><br><span>     }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_md_info_t *kt =
=3D md_get(mdname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return mbedtls_md_get_name(kt);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const md_info_t *md =3D md_get(mdname);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (md =3D=3D NULL)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return md-&gt;name;</span><br><span> }</span><br><span> =
</span><br><span> unsigned char</span><br><span> md_kt_size(const char *mdn=
ame)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (!strcmp(&quot;none&quot;, mdname))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (strcmp(&quot;none&quot;, mdname) =3D=3D 0)=
</span><br><span>     {</span><br><span>         return 0;</span><br><span>=
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedt=
ls_md_info_t *kt =3D md_get(mdname);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return mbedtls_md_get_size(kt);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const md_info_t *md_info =3D md_get(mdna=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (md_info=
 =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return (unsigned char)PSA_HASH_L=
ENGTH(md_info-&gt;psa_alg);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Generic message digest functions</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_t *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_new(void)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    md_ctx_t *ctx;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(ctx, md_ctx_t);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return ctx;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span=
> int</span><br><span> md_full(const char *mdname, const uint8_t *src, int =
src_len, uint8_t *dst)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const mbedtls_md_info_t *kt =3D md_get(mdname);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0 =3D=3D mbedt=
ls_md(kt, src, src_len, dst);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
md_info_t *md =3D md_get(mdname);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (md =3D=3D NULL || src_len &lt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-mbedtls_md_context_t *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-md_ctx_new(void)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  mbedtls_md_context_t *ctx;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return ctx;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* We depend on the caller to ensure that =
dst has enough room for the hash,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * so we just tell PSA that it can hold the appropriate a=
mount of bytes. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   size_t dst_size =3D PSA_HASH_LENGTH(md-&gt;psa_alg);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    size_t hash_length =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    psa_status_t status =3D psa_hash_compute(md-=
&gt;psa_alg, src, (size_t)src_len, dst, dst_size, &amp;hash_length);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (status !=3D PSA_SU=
CCESS || hash_length !=3D dst_size)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 1;<=
/span><br><span> }</span><br><span> </span><br><span> void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-md_ctx_free(mbedtls_md_context_t *ctx)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_free(md_ctx_=
t *ctx)</span><br><span> {</span><br><span>     free(ctx);</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-md_ctx_init(mbedtls_md_context_t *ctx, const char *mdn=
ame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_init(md_=
ctx_t *ctx, const char *mdname)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const mbedtls_md_info_t *kt =3D md_get(mdn=
ame);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL =
!=3D ctx &amp;&amp; NULL !=3D kt);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const md_info_t *md_info =3D md_get(mdname);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ctx !=3D NULL &amp;&=
amp; md_info !=3D NULL);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    mbedtls_md_init(ctx);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 0));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D m=
bedtls_md_starts(ctx));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ctx-&gt;md_info =3D md_info;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ASSERT(psa_hash_setup(&amp;ctx-&gt;operation, md_info-=
&gt;psa_alg) =3D=3D PSA_SUCCESS);</span><br><span> }</span><br><span> </spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_c=
tx_cleanup(mbedtls_md_context_t *ctx)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+md_ctx_cleanup(md_ctx_t *ctx)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_free(ctx);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(psa_hash_abor=
t(&amp;ctx-&gt;operation) =3D=3D PSA_SUCCESS);</span><br><span> }</span><br=
><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-md_ctx_size(const mbedtls_md_context_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+md_ctx_size(const md_ctx_t *ctx)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (NUL=
L =3D=3D ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (ctx =3D=3D NULL)</span><br><span>     {</span><br><span>         return 0=
;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int)PSA_HASH=
_LENGTH(ctx-&gt;md_info-&gt;psa_alg);</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_len=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_update(md_c=
tx_t *ctx, const uint8_t *src, size_t src_len)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_=
update(ctx, src, src_len));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(psa_hash_update(&amp;ctx-&gt;operation, src, src_len) =
=3D=3D PSA_SUCCESS);</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_final(mbed=
tls_md_context_t *ctx, uint8_t *dst)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+md_ctx_final(md_ctx_t *ctx, uint8_t *dst)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D=
 mbedtls_md_finish(ctx, dst));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    mbedtls_md_free(ctx);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* We depend on the caller to ensure that dst has enough=
 room for the hash,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * so we just tell PSA that it can hold the appropriate amount of bytes=
. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t dst_=
size =3D PSA_HASH_LENGTH(ctx-&gt;md_info-&gt;psa_alg);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    size_t hash_length =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(psa_hash_finish(&amp;ctx-&gt;operation=
, dst, dst_size, &amp;hash_length) =3D=3D PSA_SUCCESS);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_length =3D=3D dst_size)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * Generic HMAC functions</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * TODO: re-enable dmsg for crypto debug</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtl=
s_md_context_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hma=
c_ctx_t *</span><br><span> hmac_ctx_new(void)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_context_t *ctx;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ(ctx, mbed=
tls_md_context_t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   hmac_ctx_t *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ALLOC_OBJ_CLEAR(ctx, hmac_ctx_t);</span><br><span>     return ctx;</spa=
n><br><span> }</span><br><span> </span><br><span> void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_free(mbedtls_md_context_t *ctx)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_free(hmac_ct=
x_t *ctx)</span><br><span> {</span><br><span>     free(ctx);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_init(mb=
edtls_md_context_t *ctx, const uint8_t *key, const char *mdname)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_init_with_arbitrary_key_lengt=
h(hmac_ctx_t *ctx, const uint8_t *key, size_t key_len, const md_info_t *md_=
info)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const mbedtls_md_info_t *kt =3D md_get(mdname);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D kt &amp;&amp; NULL !=
=3D ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&g=
t;md_info =3D md_info;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    psa_set_key_type(&amp;ctx-&gt;key_attributes, PSA_KEY_TYPE_HMAC);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_set_key_algori=
thm(&amp;ctx-&gt;key_attributes, PSA_ALG_HMAC(md_info-&gt;psa_alg));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_set_key_usage_flag=
s(&amp;ctx-&gt;key_attributes, PSA_KEY_USAGE_SIGN_MESSAGE);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_init=
(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int key_len=
 =3D mbedtls_md_get_size(kt);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 1));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_st=
arts(ctx, key, key_len));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (psa_import_key(&amp;ctx-&gt;key_attributes, key, key_len, &am=
p;ctx-&gt;key) !=3D PSA_SUCCESS)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(M_FATAL, &quot;psa_import_key failed&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* make sure we used a big enough=
 key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mbe=
dtls_md_get_size(kt) &lt;=3D key_len);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ASSERT(psa_mac_sign_setup(&amp;ctx-&gt;operation, ct=
x-&gt;key, PSA_ALG_HMAC(md_info-&gt;psa_alg)) =3D=3D PSA_SUCCESS);</span><b=
r><span> }</span><br><span> </span><br><span> void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-hmac_ctx_cleanup(mbedtls_md_context_t *ctx)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_init(hmac_ctx=
_t *ctx, const uint8_t *key, const char *mdname)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_free(ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const md_info_t *md=
_info =3D md_get(mdname);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(ctx !=3D NULL &amp;&amp; key !=3D NULL &amp;&amp; md_info =
!=3D NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_init_with_arbi=
trary_key_length(ctx, key, PSA_HASH_LENGTH(md_info-&gt;psa_alg), md_info);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+hmac_ctx_cleanup(hmac_ctx_t *ctx)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(psa_mac_abort(&amp;ctx-&gt;operation) =3D=3D PSA_SUCCESS);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(psa_destroy_key=
(ctx-&gt;key) =3D=3D PSA_SUCCESS);</span><br><span> }</span><br><span> </sp=
an><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac=
_ctx_size(mbedtls_md_context_t *ctx)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+hmac_ctx_size(hmac_ctx_t *ctx)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D ctx)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int)PSA_=
HASH_LENGTH(ctx-&gt;md_info-&gt;psa_alg);</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-hmac_ctx_reset(mbedtls_md_context_t *ctx)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+hmac_ctx_reset(hmac_ctx_t *ctx)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D =
mbedtls_md_hmac_reset(ctx));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ASSERT(psa_mac_abort(&amp;ctx-&gt;operation) =3D=3D PSA_SUCCES=
S);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(psa_m=
ac_sign_setup(&amp;ctx-&gt;operation, ctx-&gt;key, PSA_ALG_HMAC(ctx-&gt;md_=
info-&gt;psa_alg)) =3D=3D PSA_SUCCESS);</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-hmac_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, int src_le=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_update(h=
mac_ctx_t *ctx, const uint8_t *src, int src_len)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_m=
d_hmac_update(ctx, src, src_len));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ASSERT(src_len &gt;=3D 0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(psa_mac_update(&amp;ctx-&gt;operation,=
 src, (size_t)src_len) =3D=3D PSA_SUCCESS);</span><br><span> }</span><br><s=
pan> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_final(hmac_ctx_t *ctx, u=
int8_t *dst)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_finish(ctx, dst));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* We depend on the caller=
 to ensure that dst has enough room for the hash,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * so we just tell PSA that it can hold t=
he appropriate amount of bytes. */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    size_t dst_size =3D PSA_HASH_LENGTH(ctx-&gt;md_info-&gt;=
psa_alg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t=
 hmac_length =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(psa_mac_=
sign_finish(&amp;ctx-&gt;operation, dst, dst_size, &amp;hmac_length) =3D=3D=
 PSA_SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    A=
SSERT(hmac_length =3D=3D dst_size);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-memcmp_constant_time(const void *a, const =
void *b, size_t size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* mbed TLS has =
a no const time memcmp function that it exposes</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     * via its APIs like OpenSSL does with CRYPTO=
_memcmp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Adapt t=
he function that mbedtls itself uses in</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * mbedtls_safer_memcmp as it considers that to be sa=
fe */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    volatile con=
st unsigned char *A =3D (volatile const unsigned char *)a;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    volatile const unsigned char *B =
=3D (volatile const unsigned char *)b;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    volatile unsigned char diff =3D 0;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    for (size_t i =3D 0; i &lt; size; i++)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        unsigned char x =3D A[i], y =3D B[i];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        diff |=3D x ^ y;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return diff;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> /*</span><br><span>  * Generate the hash require=
d by for the \c tls1_PRF function.</span><br><span>  *</span><br><span>@@ -=
1004,8 +832,8 @@</span><br><span>  * @param olen          Length of the out=
put buffer</span><br><span>  */</span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-tls1_P_hash(const mbedtls_md_info_t =
*md_kt, const uint8_t *sec, size_t sec_len, const uint8_t *seed,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            size_t seed_len, uin=
t8_t *out, size_t olen)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+tls1_P_hash(const md_info_t *md_info, const uint8_t *sec, size_t sec_le=
n, const uint8_t *seed,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            int seed_len, uint8_t *out, size_t olen)</span><br><span> {=
</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>    =
 uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span>@@ -1023,18 +851,13 @@</s=
pan><br><span>     dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_P_hash sec: %s&quot;,=
 format_hex(sec, sec_len, 0, &amp;gc));</span><br><span>     dmsg(D_SHOW_KE=
Y_SOURCE, &quot;tls1_P_hash seed: %s&quot;, format_hex(seed, seed_len, 0, &=
amp;gc));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    unsigned int chunk =3D mbedtls_md_get_size(md_kt);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    unsigned int A1_len =3D mbedtls_=
md_get_size(md_kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    unsigned int chunk =3D (unsigned int)PSA_HASH_LENGTH(md_info-&gt;psa_al=
g);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int=
 A1_len =3D (unsigned int)PSA_HASH_LENGTH(md_info-&gt;psa_alg);</span><br><=
span> </span><br><span>     /* This is the only place where we init an HMAC=
 with a key that is not</span><br><span>      * equal to its size, therefor=
e we init the hmac ctx manually here */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    mbedtls_md_init(ctx);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, md_kt, 1));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D m=
bedtls_md_hmac_starts(ctx, sec, sec_len));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    mbedtls_md_init(ctx_tmp);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx_tmp, md_kt, 1));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_=
hmac_starts(ctx_tmp, sec, sec_len));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    hmac_ctx_init_with_arbitrary_key_length(ctx, sec, sec_=
len, md_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    h=
mac_ctx_init_with_arbitrary_key_length(ctx_tmp, sec, sec_len, md_info);</sp=
an><br><span> </span><br><span>     hmac_ctx_update(ctx, seed, seed_len);</=
span><br><span>     hmac_ctx_final(ctx, A1);</span><br><span>@@ -1045,7 +86=
8,7 @@</span><br><span>         hmac_ctx_reset(ctx_tmp);</span><br><span>  =
       hmac_ctx_update(ctx, A1, A1_len);</span><br><span>         hmac_ctx_=
update(ctx_tmp, A1, A1_len);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        hmac_ctx_update(ctx, seed, seed_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_update(ctx, seed, (int)s=
eed_len);</span><br><span> </span><br><span>         if (olen &gt; chunk)</=
span><br><span>         {</span><br><span>@@ -1094,9 +917,15 @@</span><br><=
span> ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *s=
ec, size_t slen, uint8_t *out1,</span><br><span>              size_t olen)<=
/span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const md_info_t *md5 =3D md_get(&quot;MD5&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const md_info_t *sha1 =3D md_get(&quo=
t;SHA1&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (label_len &gt; (=
size_t)INT_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const md_kt_t *md5 =3D md_get(&quot;MD5&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const md_kt_t *sha1 =3D md_get(&quot;S=
HA1&quot;);</span><br><span> </span><br><span>     uint8_t *out2 =3D (uint8=
_t *)gc_malloc(olen, false, &amp;gc);</span><br><span> </span><br><span>@@ =
-1105,8 +934,8 @@</span><br><span>     const uint8_t *S2 =3D &amp;(sec[len]=
);</span><br><span>     len +=3D (slen &amp; 1); /* add for odd, make longe=
r */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    tls1_P_hash(md5, S1, len, label, label_len, out1, olen);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    tls1_P_hash(sha1, S2, len, labe=
l, label_len, out2, olen);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    tls1_P_hash(md5, S1, len, label, (int)label_len, out1, olen);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls1_P_hash(sha1, =
S2, len, label, (int)label_len, out2, olen);</span><br><span> </span><br><s=
pan>     for (size_t i =3D 0; i &lt; olen; i++)</span><br><span>     {</spa=
n><br><span>@@ -1121,8 +950,204 @@</span><br><span>     return true;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+crypto_init_lib(void)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+crypto_uninit_lib(void)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+crypto_clear_error(void)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+mbed_log_err(unsigned int=
 flags, int errval, const char *prefix)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (0 !=3D errval)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
har errstr[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     mbedtls_strerror(errval, errstr, sizeof(errstr));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (NULL =3D=3D prefix)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            prefix =3D &quot;mbed TLS error&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(flags, &quot;%s: %s&quot=
;, prefix, errstr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return 0 =3D=3D errval;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
mbed_log_func_line(unsigned int flags, int errval, const char *func, int li=
ne)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    char prefix[256];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (snprintf(prefix, sizeof(prefix), &quot;%s:%=
d&quot;, func, line) &gt;=3D sizeof(prefix))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return mbed_log_err(flags, errval, func);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return mbed_log_err(flags, errval, prefix);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+memcmp_constant_t=
ime(const void *a, const void *b, size_t size)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return mbedtls_ct_memcmp(a, b, size);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_available_cipher=
s(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* Mbed TLS 4 does not cur=
rently have a mechanism to discover available</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * ciphers. We instead print out the ciphers =
from cipher_info_table. */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENAB=
LE_SMALL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    printf(=
&quot;The following ciphers and cipher modes are available for use\n&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &quot;wit=
h &quot; PACKAGE_NAME &quot;.  Each cipher shown below may be used as a\n&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &quo=
t;parameter to the --data-ciphers (or --cipher) option.  Using a\n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+           &quot;GCM o=
r CBC mode is recommended.  In static key mode only CBC\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+           &quot;mode is allowe=
d.\n\n&quot;);</span><br><span> #endif</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_CRYPTO_MBEDTLS */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; =
i &lt; cipher_info_table_entries; i++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        const cipher_info_t *info =3D &amp;cipher_info_table[i];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *name =
=3D info-&gt;name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (!cipher_kt_insecure(name) &amp;&amp; (cipher_kt_mode_aead(name) =
|| cipher_kt_mode_cbc(name)))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            print_cipher(name);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;\nThe followin=
g ciphers have a block size of less than 128 bits, \n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+           &quot;and are therefore =
deprecated.  Do not use unless you have to.\n\n&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; cipher_=
info_table_entries; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst cipher_info_t *info =3D &amp;cipher_info_table[i];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const char *name =3D info-&gt;n=
ame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (cip=
her_kt_insecure(name) &amp;&amp; (cipher_kt_mode_aead(name) || cipher_kt_mo=
de_cbc(name)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pri=
nt_cipher(name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;\n&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+show_available_digests(void)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Mbed TLS 4 does not currently have a mechanism to discover available</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * message digests. =
We instead print out the digests from md_info_table. */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    printf(&quot;The following message digests are availa=
ble for use with\n&quot; PACKAGE_NAME</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+           &quot;.  A message digest is used in conjuncti=
on with\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
       &quot;the HMAC function, to authenticate received packets.\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &quot;You =
can specify a message digest as parameter to\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &quot;the --auth option.\n\n&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; md_info_table=
_entries; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const md_in=
fo_t *info =3D &amp;md_info_table[i];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        printf(&quot;%s %d bit default key\n&quot;, info-=
&gt;name,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
     (unsigned char)PSA_HASH_LENGTH(info-&gt;psa_alg) * 8);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    printf(&quot;\n&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_available_eng=
ines(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;Sorry, mbe=
d TLS hardware crypto engine functionality is not &quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+           &quot;available\n&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+crypto_pem_encode(const char *name, struct buffer *dst, const struct buff=
er *src,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
       struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 100=
0 chars is the PEM line length limit (+1 for tailing NUL) */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    char header[1000 + 1] =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char footer[1=
000 + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(he=
ader, sizeof(header), &quot;-----BEGIN %s-----\n&quot;, name) &gt;=3D sizeo=
f(header))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(footer, sizeof(foo=
ter), &quot;-----END %s-----\n&quot;, name) &gt;=3D sizeof(footer))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
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
        || !(out_len &lt; INT_MAX &amp;&amp; out_len &gt; 1)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        || !buf_inc_len(dst, (int)=
out_len - 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(*dst);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+crypto_pem_decode(const char *=
name, struct buffer *dst, const struct buffer *src)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* 1000 chars is the PEM line length limit (+1 for tail=
ing NUL) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char=
 header[1000 + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    char footer[1000 + 1] =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (snprintf(header, sizeof(header), &quot;-----BEGIN %s-----&qu=
ot;, name) &gt;=3D sizeof(header))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (snp=
rintf(footer, sizeof(footer), &quot;-----END %s-----&quot;, name) &gt;=3D s=
izeof(footer))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* mbed TLS requires the src to be null-termin=
ated */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* alloc=
ate a new buffer to avoid modifying the src buffer */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer input =
=3D alloc_buf_gc(BLEN(src) + 1, &amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    buf_copy(&amp;input, src);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_null_terminate(&amp;input);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    size_t use_len =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    mbedtls_pem_context ctx =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbed_ok(mbedtl=
s_pem_read_buffer(&amp;ctx, header, footer, BPTR(&amp;input), NULL, 0, &amp=
;use_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size=
_t buf_size =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const unsigned char *buf =3D mbedtls_pem_get_buffer(&amp;ctx, &amp;buf_s=
ize);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &a=
mp;&amp; !buf_write(dst, buf, buf_size))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ret =3D false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(M_WARN, &quot;PEM decode error: destination buffer to=
o small&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    mbedtls_pem_free(&amp;ctx);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(ENABLE_CRYP=
TO_MBEDTLS) */</span><br><span>diff --git a/src/openvpn/crypto_mbedtls.h b/=
src/openvpn/crypto_mbedtls.h</span><br><span>index af71037..16d41e4 100644<=
/span><br><span>--- a/src/openvpn/crypto_mbedtls.h</span><br><span>+++ b/sr=
c/openvpn/crypto_mbedtls.h</span><br><span>@@ -1,3 +1,4 @@</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span=
>  *  OpenVPN -- An application to securely tunnel IP networks</span><br><s=
pan>  *             over a single TCP/UDP port, with support for SSL/TLS-ba=
sed</span><br><span>@@ -23,85 +24,98 @@</span><br><span> </span><br><span> =
/**</span><br><span>  * @file</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Data Channel Cryptography mbed TLS-specific backend interface</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Data Channel Crypto=
graphy backend interface using the TF-PSA-Crypto library</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * part of Mbed TLS 4.</span><br><span=
>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#ifndef CRYPTO_MBEDTLS_H_</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define CRYPTO_MBEDTLS_H_</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef CRYPTO_MBEDTLS4_H_</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define CRYPTO_MBEDTLS4_H_</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;stdbool.h&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/cipher.=
h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbe=
dtls/md.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include=
 &lt;mbedtls/ctr_drbg.h&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &lt;psa/crypto.h&gt;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/** Generic message digest key type %cont=
ext. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef mbedtl=
s_md_info_t md_kt_t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Generic cipher %co=
ntext. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef mbed=
tls_cipher_context_t cipher_ctx_t;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Gene=
ric message digest %context. */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-typedef mbedtls_md_context_t md_ctx_t;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/** Generic HMAC %context. */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-typedef mbedtls_md_context_t hmac_ctx_t;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/* Use a dummy type for the provider */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-typedef void provider_t;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;integer.h&quot;</span><=
br><span> </span><br><span> /** Maximum length of an IV */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_MAX_IV_LENGTH MBEDTLS_=
MAX_IV_LENGTH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e OPENVPN_MAX_IV_LENGTH 16</span><br><span> </span><br><span> /** Cipher is=
 in CBC mode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e OPENVPN_MODE_CBC MBEDTLS_MODE_CBC</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define OPENVPN_MODE_CBC PSA_ALG_CBC_PKCS7</span><br><span>=
 </span><br><span> /** Cipher is in OFB mode */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define OPENVPN_MODE_OFB MBEDTLS_MODE_OFB</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_MODE_OFB PS=
A_ALG_OFB</span><br><span> </span><br><span> /** Cipher is in CFB mode */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_MODE_CF=
B MBEDTLS_MODE_CFB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OPENVPN_MODE_CFB PSA_ALG_CFB</span><br><span> </span><br><span> /** =
Cipher is in GCM mode */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define OPENVPN_MODE_GCM MBEDTLS_MODE_GCM</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define OPENVPN_MODE_GCM PSA_ALG_GCM</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef mbedtls_o=
peration_t crypto_operation_t;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+typedef int crypto_operation_t;</span><br><span> </span><br><spa=
n> /** Cipher should encrypt */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define OPENVPN_OP_ENCRYPT MBEDTLS_ENCRYPT</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_OP_ENCRYPT 0</span><br><s=
pan> </span><br><span> /** Cipher should decrypt */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_OP_DECRYPT MBEDTLS_DECRYPT<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_OP_D=
ECRYPT 1</span><br><span> </span><br><span> #define MD4_DIGEST_LENGTH    16=
</span><br><span> #define MD5_DIGEST_LENGTH    16</span><br><span> #define =
SHA_DIGEST_LENGTH    20</span><br><span> #define SHA256_DIGEST_LENGTH 32</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Returns a singleton i=
nstance of the mbed TLS random number generator.</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * For PolarSSL/mbed TLS 1.1+, this is the CTR_DRBG random number g=
enerator. If it</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * has=
n&#39;t been initialised yet, the RNG will be initialised using the default=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * entropy sources. A=
side from the default platform entropy sources, an</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * additional entropy source, the HAVEGE rando=
m number generator will also be</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * added. During initialisation, a personalisation string will be=
 added based</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * on the=
 time, the PID, and a pointer to the random context.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-mbedtls_ctr_drbg_context *rand_ctx_get(void);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+typedef void provider_t;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
PREDICTION_RESISTANCE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Enable predicti=
on resistance on the random number generator.</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void rand_ctx_enable_prediction_resistance(void);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+typedef struct cipher_info</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const char *name;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    psa_key_type_t psa_key_type;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    psa_algorithm_t psa_alg;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int key_bytes;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int iv_bytes;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int block_size;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+} cipher_info_t;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+typedef union psa_cipher_or_a=
ead_operation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_cipher_operation=
_t cipher;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_a=
ead_operation_t aead;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+} cipher_operation_t;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct =
cipher_ctx</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_svc_key_id_t ke=
y;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_key_attri=
butes_t key_attributes;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const cipher_info_t *cipher_info;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    bool aead_finished;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    cipher_operation_t operation;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint8_t tag[16];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+} cipher_ctx_t;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+typedef struct md_info</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *name;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    psa_algorithm_t psa_alg;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+} md_info_t;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef stru=
ct md_ctx</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const md_info_t *md_info=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    psa_hash_opera=
tion_t operation;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} =
md_ctx_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct hmac_ctx</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mbedtls_svc_key_id_t key;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    psa_key_attributes_t key_at=
tributes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
md_info_t *md_info;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    psa_mac_operation_t operation;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+} hmac_ctx_t;</span><br><span> </span><br><span> /**</span><=
br><span>  * Log the supplied mbed TLS error, prefixed by supplied prefix.<=
/span><br><span>  *</span><br><span>  * @param flags         Flags to indic=
ate error type and priority.</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * @param errval        mbed TLS error code to convert to error mess=
age.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param errva=
l        mbed TLS error code.</span><br><span>  * @param prefix        Pref=
ix to mbed TLS error message.</span><br><span>  *</span><br><span>  * @retu=
rns true if no errors are detected, false otherwise.</span><br><span>@@ -11=
2,7 +126,7 @@</span><br><span>  * Log the supplied mbed TLS error, prefixed=
 by function name and line number.</span><br><span>  *</span><br><span>  * =
@param flags         Flags to indicate error type and priority.</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @param errval        mbed TLS =
error code to convert to error message.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param errval        mbed TLS error code.</span><br>=
<span>  * @param func          Function name where error was reported.</spa=
n><br><span>  * @param line          Line number where error was reported.<=
/span><br><span>  *</span><br><span>@@ -142,7 +156,8 @@</span><br><span>  *=
 @param errval        mbed TLS error code to convert to error message.</spa=
n><br><span>  *</span><br><span>  * @returns true if no errors are detected=
, false otherwise.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* TODO: The log function has been removed, do something about it?</span><br=
><span>  */</span><br><span> #define mbed_ok(errval) mbed_log_func_line_lit=
e(D_CRYPT_ERRORS, errval, __func__, __LINE__)</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif /* CRYPTO_MBEDTLS_H_ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* CRYPTO_MBEDT=
LS4_H_ */</span><br><span>diff --git a/src/openvpn/crypto_mbedtls_legacy.c =
b/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>new file mode 100644<=
/span><br><span>index 0000000..a991349</span><br><span>--- /dev/null</span>=
<br><span>+++ b/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>@@ -0,0=
 +1,1133 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applica=
tion to securely tunnel IP networks</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             over a single TCP/UDP port, with support for=
 SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          session authentication and key exchange,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet aut=
hentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            packet compression.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  C=
opyright (C) 2002-2026 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2026 Sentyron=
 B.V. &lt;openvpn@...2918...&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
This program is free software; you can redistribute it and/or modify</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of =
the GNU General Public License version 2</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  as published by the Free Software Foundation.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  with this program; if not, see &lt;https://www.gnu.or=
g/licenses/&gt;.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Data Channel Cryptography mbed TLS-specific backend interface,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for mbed TLS 3.X=
 versions.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;syshead.h&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &lt;mbedtls/version.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;errlevel.h&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;basic.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer.h&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto.h&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
integer.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;crypto_backend.h&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;otime.h&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;misc.h&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &lt;mbedtls/base64.h&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;mbedtls/des.h&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/error.h&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/md5.=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;m=
bedtls/cipher.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;mbedtls/pem.h&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;mbedtls/entropy.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;mbedtls/ssl.h&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Hardware engine support. Allows loading/unloading o=
f engines.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
crypto_init_lib_engine(const char *engine_name)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    msg(M_WARN, &quot;Note: mbed TLS hardware crypto engine funct=
ionality is not &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                &quot;available&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+provider_t *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_load_provider(=
const char *provider)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (provider=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Note: =
mbed TLS provider functionality is not available&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+crypto_unload_provider(const cha=
r *provname, provider_t *provider)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Functions related to the core crypto library</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+crypto_init_lib(void)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+crypto_uninit_lib(void)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_clear_error(voi=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbed_log_err=
(unsigned int flags, int errval, const char *prefix)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (0 !=3D errval)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        char errstr[256];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        mbedtls_strerror(errval, errstr, sizeof(errstr));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (NULL =3D=3D prefix)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            prefix =3D &quot;mbed TLS err=
or&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(flags, &=
quot;%s: %s&quot;, prefix, errstr);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0 =3D=
=3D errval;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+mbed_log_func_line(unsigned int flags, int errval, const cha=
r *func, int line)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char prefix[256=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(prefix, sizeof(pref=
ix), &quot;%s:%d&quot;, func, line) &gt;=3D sizeof(prefix))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return mbed_log_err(flags, errval, func);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return mbed_log_err(flags, errval, prefix);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifd=
ef DMALLOC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_init_dmalloc(void=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg(M_ERR, &quot;Error: dmalloc =
support is not available for mbed TLS.&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif /* DMALLOC */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const cip=
her_name_pair cipher_name_translation_table[] =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    { &quot;BF-CBC&quot;, &quot;BLOWFISH-=
CBC&quot; },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &=
quot;BF-CFB&quot;, &quot;BLOWFISH-CFB64&quot; },</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    { &quot;CAMELLIA-128-CFB&quot;, &quot;CAME=
LLIA-128-CFB128&quot; },</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    { &quot;CAMELLIA-192-CFB&quot;, &quot;CAMELLIA-192-CFB128&quot; },=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;CAMELLI=
A-256-CFB&quot;, &quot;CAMELLIA-256-CFB128&quot; }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+const size_t cipher_name_translation_table_count =3D</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    sizeof(cipher_name_trans=
lation_table) / sizeof(*cipher_name_translation_table);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+show_available_ciphers(void)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st int *ciphers =3D mbedtls_cipher_list();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    printf(&quot;The following ciphers and cipher modes are available =
for use\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
       &quot;with &quot; PACKAGE_NAME &quot;.  Each cipher shown below may =
be used as a\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+           &quot;parameter to the --data-ciphers (or --cipher) option.  Us=
ing a\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
     &quot;GCM or CBC mode is recommended.  In static key mode only CBC\n&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &quo=
t;mode is allowed.\n\n&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (*ciphers !=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const mbedtls_ciphe=
r_info_t *info =3D mbedtls_cipher_info_from_type(*ciphers);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const char *name =3D mbedtl=
s_cipher_info_get_name(info);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (info &amp;&amp; name &amp;&amp; !cipher_kt_insecure(n=
ame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &am=
p;&amp; (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            print_cipher(name);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        ciphers++;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    printf(&quot;\nThe following ciphers have a block size of less than =
128 bits, \n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
          &quot;and are therefore deprecated.  Do not use unless you have t=
o.\n\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
iphers =3D mbedtls_cipher_list();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    while (*ciphers !=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_f=
rom_type(*ciphers);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        const char *name =3D mbedtls_cipher_info_get_name(info);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (info &amp;&amp; na=
me &amp;&amp; cipher_kt_insecure(name)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            &amp;&amp; (cipher_kt_mode_aead(name) || cip=
her_kt_mode_cbc(name)))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      print_cipher(name);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ciphers++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;\n=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+show_available_digests(void)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const int *digests =3D mbedtls_md_list();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    printf(&quot;The following message digests are available for=
 use with\n&quot; PACKAGE_NAME</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+           &quot;.  A message digest is used in conjunction with=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
&quot;the HMAC function, to authenticate received packets.\n&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+           &quot;You can spe=
cify a message digest as parameter to\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+           &quot;the --auth option.\n\n&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    while (*digests !=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        const mbedtls_md_info_t *info =3D mbedtls_md_info_f=
rom_type(*digests);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (info)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            printf(&quot;%s %d =
bit default key\n&quot;, mbedtls_md_get_name(info),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   mbedtls_md_get_size(in=
fo) * 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        digests++;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;\n&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show=
_available_engines(void)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    printf(&q=
uot;Sorry, mbed TLS hardware crypto engine functionality is not &quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+           &quot;availab=
le\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_pem_encode(const=
 char *name, struct buffer *dst, const struct buffer *src,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                  struct gc_arena *g=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* 1000 chars is the PEM line l=
ength limit (+1 for tailing NUL) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    char header[1000 + 1] =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char footer[1000 + 1] =3D { 0 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (snprintf(header, sizeof(header), =
&quot;-----BEGIN %s-----\n&quot;, name) &gt;=3D sizeof(header))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (snprintf(footer, sizeof(footer), &quot;-----END=
 %s-----\n&quot;, name) &gt;=3D sizeof(footer))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t out_le=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (MBE=
DTLS_ERR_BASE64_BUFFER_TOO_SMALL</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        !=3D mbedtls_pem_write_buffer(header, footer, BPTR(src=
), BLEN(src), NULL, 0, &amp;out_len))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We set the size buf =
to out_len-1 to NOT include the 0 byte that</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * mbedtls_pem_write_buffer in its length calcu=
lation */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *dst =
=3D alloc_buf_gc(out_len, gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(s=
rc), BLEN(src), BPTR(dst),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                          BCAP(dst), &amp;out_len))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || !buf_inc_=
len(dst, out_len - 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLE=
AR(*dst);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_pem_decode(con=
st char *name, struct buffer *dst, const struct buffer *src)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* 1000 chars is the PEM line length limit (+1 f=
or tailing NUL) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   char header[1000 + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    char footer[1000 + 1] =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (snprintf(header, sizeof(header), &quot;-----BEGIN %s=
-----&quot;, name) &gt;=3D sizeof(header))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (snprintf(footer, sizeof(footer), &quot;-----END %s-----&quot;, name) &=
gt;=3D sizeof(footer))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* mbed TLS requires the src to be nu=
ll-terminated */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* allocate a new buffer to avoid modifying the src buffer */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er input =3D alloc_buf_gc(BLEN(src) + 1, &amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    buf_copy(&amp;input, src);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buf_null_terminate(&amp;input=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    size_t use_len =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_pem_context ctx =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
ret =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbed=
_ok(mbedtls_pem_read_buffer(&amp;ctx, header, footer, BPTR(&amp;input), NUL=
L, 0, &amp;use_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size_t buf_size =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const unsigned char *buf =3D mbedtls_pem_get_buffer(&amp;ctx, =
&amp;buf_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (ret &amp;&amp; !buf_write(dst, buf, buf_size))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        ret =3D false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN, &quot;PEM decode error: destination=
 buffer too small&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_pem_free(&amp;c=
tx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return re=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Random num=
ber functions, used in cases where we want</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * reasonably strong cryptographic random number gen=
eration</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * without d=
epleting our entropy pool.  Used for random</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * IV values and a number of other miscellaneous ta=
sks.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Initia=
lise the given ctr_drbg context, using a personalisation string and an</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * entropy gathering fun=
ction.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_ctr_drbg_context *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+rand_ctx_get(void)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static mbedtls_entropy_context ec =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static m=
bedtls_ctr_drbg_context cd_ctx =3D { 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    static bool rand_initialised =3D false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!rand_initialised)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        struct buffer pers_string =
=3D alloc_buf_gc(100, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * Perso=
nalisation string, should be as unique as possible (see NIST</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * 800-90 section 8.7.1). =
We have very little information at this stage.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * Include Program Name, memory address =
of the context and PID.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    buf_printf(&amp;pers_string, &quot;OpenVPN %0u %p %s&quot;, platform_ge=
tpid(), &amp;cd_ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                   time_string(0, 0, 0, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* Initialise mbed TLS RNG, and built-in entropy sou=
rces */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbed=
tls_entropy_init(&amp;ec);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbed=
tls_ctr_drbg_init(&amp;cd_ctx);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!mbed_ok(mbedtls_ctr_drbg_seed(&amp;cd_ctx, mbedtls=
_entropy_func, &amp;ec, BPTR(&amp;pers_string),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                           BLEN=
(&amp;pers_string))))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_FATAL, &quot;Failed to initialize random generator&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        rand_initialised =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return &amp;cd_ctx;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PREDICTION_=
RESISTANCE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+rand_ctx_enable_predicti=
on_resistance(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_ctr_dr=
bg_context *cd_ctx =3D rand_ctx_get();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    mbedtls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif /* ENABLE_PREDICTION_RESISTANCE */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+rand_bytes(uint8_t *output, int len)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    mbedtls_ctr_drbg_context *rng_ctx =3D rand_ctx_get();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    while (len &gt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const size_t blen =3D min_int(len, MBEDTLS_CTR_DRBG_=
MAX_REQUEST);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (0 !=3D mbedtls_ctr_drbg_random(rng_ctx, output, blen))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        output +=3D blen;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        len -=3D blen;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Generic cipher k=
ey type functions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static const mbedtls_cipher_info_t =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_get(const c=
har *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ciphername=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_cipher_info_t *cip=
her =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ciphername =3D transl=
ate_cipher_name_from_openvpn(ciphername);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    cipher =3D mbedtls_cipher_info_from_string(cipher=
name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ci=
pher;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+cipher_valid_reason(const char *ciphername, const char **reason)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(reason);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const mbedtls_cipher_info_t *cipher =3D cipher_get(cip=
hername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (NULL =3D=3D cipher)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;Cipher alg=
orithm &#39;%s&#39; not found&quot;, ciphername);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        *reason =3D &quot;disabled because un=
known&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const size_t key_bytelen =3D mbedt=
ls_cipher_info_get_key_bitlen(cipher) / 8;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (key_bytelen &gt; MAX_CIPHER_KEY_LENGTH)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            &quot;Cipher algorithm &#39=
;%s&#39; uses a default key size (%zu bytes) &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;which is larger than &q=
uot; PACKAGE_NAME &quot;&#39;s current maximum key size &quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;(%d bytes)&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ciph=
ername, key_bytelen, MAX_CIPHER_KEY_LENGTH);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        *reason =3D &quot;disabled due to key size=
 too large&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    *reason =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cip=
her_kt_name(const char *ciphername)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (NULL =3D=3D cipher=
_kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;[null-ci=
pher]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return translate_cipher_name_to_open=
vpn(mbedtls_cipher_info_get_name(cipher_kt));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_key_size(const ch=
ar *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_ciph=
er_info_t *cipher_kt =3D cipher_get(ciphername);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (NULL =3D=3D cipher_kt)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return (int)mbedtls_ciph=
er_info_get_key_bitlen(cipher_kt) / 8;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_iv_size(const char *ciph=
ername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_cipher_info_=
t *cipher_kt =3D cipher_get(ciphername);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (NULL =3D=3D cipher_kt)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int)m=
bedtls_cipher_info_get_iv_size(cipher_kt);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_block_size(const cha=
r *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_ciphe=
r_info_t *cipher_kt =3D cipher_get(ciphername);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (NULL =3D=3D cipher_kt)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return (int)mbedtls_cipher_info_get_block_size(cipher_kt);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
ipher_kt_tag_size(const char *ciphername)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (cipher_kt_mode_aead(ciphername))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return OPENVPN_AEAD_TAG_LENGTH;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+cipher_kt_insecure(const char *ciphername=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_cipher_info_t *cip=
her_kt =3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!cipher_kt)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return !(cipher_kt_block_si=
ze(ciphername) &gt;=3D 128 / 8</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             || mbedtls_cipher_info_get_type(cipher_kt) =
=3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static mbedtls_cipher_mode_t</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_mode(const mbedtls_cip=
her_info_t *cipher_kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(NULL=
 !=3D cipher_kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return mbedtls_cipher_info_get_mode(cipher_kt);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_mode_cbc(con=
st char *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls=
_cipher_info_t *cipher =3D cipher_get(ciphername);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return cipher &amp;&amp; cipher_kt_mode(=
cipher) =3D=3D OPENVPN_MODE_CBC;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+cipher_kt_mode_ofb_cfb(const char *ciph=
ername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_cipher_info_=
t *cipher =3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return cipher</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+           &amp;&amp; (cipher_kt_mode(cipher) =3D=3D OPENVP=
N_MODE_OFB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
      || cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_CFB);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_mode=
_aead(const char *ciphername)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return cipher</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; (cipher_kt_mode=
(cipher) =3D=3D OPENVPN_MODE_GCM</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+               || cipher_kt_mode(cipher) =3D=3D MBEDTL=
S_MODE_CHACHAPOLY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           );</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Generic cipher context functions<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+mbedtls_cipher_context_t *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+cipher_ctx_new(void)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbe=
dtls_cipher_context_t *ctx;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ALLOC_OBJ(ctx, mbedtls_cipher_context_t);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ctx;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_free(mbedtl=
s_cipher_context_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_c=
ipher_free(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 free(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t=
 *key, const char *ciphername,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                crypto_operation_t enc)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ASSERT(NULL !=3D ciphername &amp;&amp; NULL !=3D ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*ctx);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const mbedtls_cipher_info_t *kt =3D ciphe=
r_get(ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
ize_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(kt);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;mbed TLS ci=
pher context init #1&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls=
_cipher_setkey(ctx, key, (int)key_bitlen, enc)))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(M_FATAL, &quot;mbed TLS cipher set key&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (mbedtls_cipher_info_get_mode(kt) =3D=3D MBEDTL=
S_MODE_CBC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!mbed_ok(m=
bedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_PKCS7)))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;mbed TLS ciph=
er set padding mode&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* make sure we used a big enou=
gh key */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(mbedtls_cipher_get_key_bitlen(ctx) &lt;=3D key_bitlen);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_iv_le=
ngth(const mbedtls_cipher_context_t *ctx)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return mbedtls_cipher_get_iv_size(ctx);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_get_tag(cipher=
_ctx_t *ctx, uint8_t *tag, int tag_len)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (tag_len &gt; SIZE_MAX)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_writ=
e_tag(ctx, (unsigned char *)tag, tag_len)))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ct=
x_block_size(const mbedtls_cipher_context_t *ctx)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return (int)mbedtls_cipher_get_block_size(ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ct=
x_mode(const mbedtls_cipher_context_t *ctx)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(NULL !=3D ctx);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn mbedtls_cipher_get_cipher_mode(ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_mode_cbc(const ciph=
er_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctx &amp;&am=
p; cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CBC;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_mode_ofb_cfb(const cipher_ctx_=
t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return ctx</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; (cipher_ctx_m=
ode(ctx) =3D=3D OPENVPN_MODE_OFB</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+               || cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CFB=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+cipher_ctx_mode_aead(const cipher_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return ctx</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+           &amp;&amp; (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_=
GCM</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef MBEDTLS_C=
HACHAPOLY_C</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
       || cipher_ctx_mode(ctx) =3D=3D MBEDTLS_MODE_CHACHAPOLY</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+           );</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_reset(mbedtls_ciphe=
r_context_t *ctx, const uint8_t *iv_buf)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!mbed_ok(mbedtls_cipher_reset(ctx)))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbed=
tls_cipher_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx))))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t =
*src, int src_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (src_len &gt=
; SIZE_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_update_ad(ctx, src, src_l=
en)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+cipher_ctx_update(mbedtls_cipher_context_t *ctx=
, uint8_t *dst, int *dst_len, uint8_t *src,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                  int src_len)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    size_t s_dst_len =3D *dst_len;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t)src=
_len, dst, &amp;s_dst_len)))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    *dst_len =3D s_dst_len;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return 1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_final(mbedtls_cipher_con=
text_t *ctx, uint8_t *dst, int *dst_len)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    size_t s_dst_len =3D *dst_len;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &amp;s_dst_len)))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    *dst_len =3D s_dst_len;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+cipher_ctx_final_check_tag(mbedtls_cipher_context_t *ctx, uint8_t *ds=
t, int *dst_len, uint8_t *tag,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                           size_t tag_len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    size_t olen =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (MBEDTLS_DECRYPT !=3D mbedtls_cipher_get_operation(ctx))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (tag_len &gt; SIZE_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_finish(ct=
x, dst, &amp;olen)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D=
_CRYPT_ERRORS, &quot;%s: cipher_ctx_final() failed&quot;, __func__);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (olen &gt; INT_MAX)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *dst=
_len =3D olen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls=
_cipher_check_tag(ctx, (const unsigned char *)tag, tag_len)))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Generic=
 message digest information functions</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static const mbedtls_md_info_t *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+md_get(const char *digest)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const mbedtls_md_info_t *md =3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(digest);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    md =3D mbedtls_md_info_from_string(digest);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!md)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;Message hash a=
lgorithm &#39;%s&#39; not found&quot;, digest);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (mbedtls_md_get_size(md) &gt; MAX_HMAC_KEY_LENGTH)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;Message hash algor=
ithm &#39;%s&#39; uses a default hash size (%d bytes) which is larger than =
&quot; PACKAGE_NAME</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot;&#39;s current maximum hash size (%d bytes)&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            digest, mbedtl=
s_md_get_size(md), MAX_HMAC_KEY_LENGTH);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return md;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+md_valid(const char *digest)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const mbedtls_md_info_t *md =3D mbedtls_md_info_from_st=
ring(digest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn md !=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+const char *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+md_kt_name(const char *mdname)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!strcmp(&quot;none&quot;, mdname))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return &quot;[null-digest]&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_md_info_t *kt =
=3D md_get(mdname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return mbedtls_md_get_name(kt);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned char</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+md_kt_size(const char *mdna=
me)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!strcmp(&quot;none&quot;, =
mdname))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_md_info_t *kt =3D md_ge=
t(mdname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n mbedtls_md_get_size(kt);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Generic message digest functions</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+md_full(const char *mdname, const uint8_t=
 *src, int src_len, uint8_t *dst)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const mbedtls_md_info_t *kt =3D md_get(mdname);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return 0 =3D=3D mbedtls_md(kt, src, src_len=
, dst);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+mbedtls_md_context_t *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+md_ctx_new(void)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    mbedtls_md_context_t *ctx;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return ctx;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_fr=
ee(mbedtls_md_context_t *ctx)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free=
(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+md_ctx_init(mbedtls_md_context_t *ctx, const char *mdname)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const mbedtls_md_info_t *kt =3D md_get(m=
dname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(N=
ULL !=3D ctx &amp;&amp; NULL !=3D kt);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    mbedtls_md_init(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 0));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_starts(=
ctx));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+md_ctx_cleanup(mbedtls_md_context_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    mbedtls_md_free(ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_size(const mbedtls_md_co=
ntext_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (NULL =3D=3D ctx)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return (int)mbedtls_md_get_size(mbedtls_md_in=
fo_from_ctx(ctx));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+md_ctx_update(mbedtls_md_context_t *ctx, const uint8_=
t *src, size_t src_len)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =
=3D=3D mbedtls_md_update(ctx, src, src_len));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+md_ctx_final(mbedtls_md_co=
ntext_t *ctx, uint8_t *dst)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(0 =3D=3D mbedtls_md_finish(ctx, dst));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    mbedtls_md_free(ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Generic HMAC functions</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * TODO: re-enable dmsg for crypto debug</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_md=
_context_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hmac_ct=
x_new(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_md_context_t *=
ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ(c=
tx, mbedtls_md_context_t);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+hmac_ctx_free(mbedtls_md_context_t *ctx)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    free(ctx);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_init(mbedtls_md_con=
text_t *ctx, const uint8_t *key, const char *mdname)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const mbedtls_md_info_t *kt =3D md_get(mdname);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(NULL !=3D kt &am=
p;&amp; NULL !=3D ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_md_=
init(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int k=
ey_len =3D mbedtls_md_get_size(kt);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 1));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_=
md_hmac_starts(ctx, key, key_len));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* make sure we used a big enough key */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(mbedtls_md_get_size(kt) &lt;=3D key_len);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+hmac_ctx_cleanup(mbedtls_md_context_t *ctx)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    mbedtls_md_free(ctx);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_size(mbedtls_md_context_t *ct=
x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (NULL =3D=3D ctx)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+hmac_ctx_reset(mbedtls_md_context_t *ctx)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_hmac_reset(ctx));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hmac_ctx_upda=
te(mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_hmac_update(ctx, sr=
c, src_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_hmac_fi=
nish(ctx, dst));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+memcmp_constant_time(const void *a, const void *b, size_=
t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* mbed TLS has a no const=
 time memcmp function that it exposes</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * via its APIs like OpenSSL does with CRYPTO_memcmp<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Adapt the fun=
ction that mbedtls itself uses in</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * mbedtls_safer_memcmp as it considers that to be safe *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    volatile const=
 unsigned char *A =3D (volatile const unsigned char *)a;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    volatile const unsigned char *B =
=3D (volatile const unsigned char *)b;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    volatile unsigned char diff =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; size; i++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        unsigned char x =3D A[i], y =3D B[i];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        diff |=3D x ^=
 y;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return diff;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Generate the hash required by for the \c tls1_PRF function.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param md_kt         Message digest to us=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sec     =
      Secret to base the hash on</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param sec_len       Length of the secret</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param seed          Seed to hash<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param seed_len  =
    Length of the seed</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param out           Output buffer</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param olen          Length of the output buffer</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+tls1_P_hash(const mbedtls_md_info_t *md_kt, co=
nst uint8_t *sec, size_t sec_len, const uint8_t *seed,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            size_t seed_len, uint8_t *ou=
t, size_t olen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * variables warni=
ngs if compiled with --enable-small */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const size_t olen_orig =3D olen;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *out_orig =3D out;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    hmac_ctx_t *ctx =3D hmac_ctx_new();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_t *ctx_tmp =3D hmac_c=
tx_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_SHOW_KEY_SOURCE, &=
quot;tls1_P_hash sec: %s&quot;, format_hex(sec, sec_len, 0, &amp;gc));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_SHOW_KEY_SOUR=
CE, &quot;tls1_P_hash seed: %s&quot;, format_hex(seed, seed_len, 0, &amp;gc=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    unsigned int chunk =3D mbedtls_=
md_get_size(md_kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    unsigned int A1_len =3D mbedtls_md_get_size(md_kt);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* This is the only place where we init an HMAC with a=
 key that is not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * equal to its size, therefore we init the hmac ctx manually here */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_md_init(ctx)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=
=3D mbedtls_md_setup(ctx, md_kt, 1));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, sec, sec_=
len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_md_init(ctx_tmp);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 =3D=3D mb=
edtls_md_setup(ctx_tmp, md_kt, 1));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx_tmp, sec, se=
c_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_update(ctx, seed,=
 seed_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac=
_ctx_final(ctx, A1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (;;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_reset(ctx);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_reset(ctx_tmp=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_=
update(ctx, A1, A1_len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        hmac_ctx_update(ctx_tmp, A1, A1_len);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        hmac_ctx_update(ctx, seed, seed_len)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (olen &gt; chunk)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            hmac_ctx_final(ctx, out);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            out +=3D=
 chunk;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
olen -=3D chunk;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         hmac_ctx_final(ctx_tmp, A1); /* calc the next A1 value */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        else                          =
   /* last one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
hmac_ctx_final(ctx, A1);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            memcpy(out, A1, olen);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    h=
mac_ctx_cleanup(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    hmac_ctx_free(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    hmac_ctx_cleanup(ctx_tmp);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    hmac_ctx_free(ctx_tmp);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    secure_memzero(A1, sizeof(A1));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_P_hash out: %s=
&quot;, format_hex(out_orig, olen_orig, 0, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Use the TLS PRF=
 function for generating data channel keys.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * This code is based on the OpenSSL library.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * TLS generates keys as such:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * master_secret[48] =3D PRF(pre_master_secret[=
48], &quot;master secret&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *                         ClientHello.random[32] + ServerHello=
.random[32])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * key_block[] =3D PRF(S=
ecurityParameters.master_secret[48],</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *                 &quot;key expansion&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *                 SecurityParam=
eters.server_random[32] +</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *                 SecurityParameters.client_random[32]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Notes:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * (1) key_block contains a full set of 4 keys.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * (2) The pre-master secret is generated by th=
e client.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ssl_tls1_PRF(const uint8_t *label, size_t=
 label_len, const uint8_t *sec, size_t slen, uint8_t *out1,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             size_t olen)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const md_kt_t *md5 =3D md_=
get(&quot;MD5&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const md_kt_t *sha1 =3D md_get(&quot;SHA1&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint8_t *out2 =3D (uint8_t *)gc_malloc(olen, false, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D slen / 2;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *S1 =
=3D sec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
int8_t *S2 =3D &amp;(sec[len]);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    len +=3D (slen &amp; 1); /* add for odd, make longer */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tls1_P_hash(md5, S1, len, label, labe=
l_len, out1, olen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; olen; i++)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        out1[i] ^=3D out2[i];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    secure_memzero(out2, olen);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_PRF out[%zu]: %s&quot;, olen, fo=
rmat_hex(out1, olen, 0, &amp;gc));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x0=
40000 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* E=
NABLE_CRYPTO_MBEDTLS */</span><br><span>diff --git a/src/openvpn/crypto_mbe=
dtls_legacy.h b/src/openvpn/crypto_mbedtls_legacy.h</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000..af71037</span><br><span>--- /d=
ev/null</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy.h</span><br=
><span>@@ -0,0 +1,148 @@</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN =
-- An application to securely tunnel IP networks</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, wit=
h support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             session authentication and key exchange,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryptio=
n, packet authentication, and</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             packet compression.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@...515...&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-=
2026 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  This program is free software; you can redistribute it and/or =
modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under =
the terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distribu=
ted in the hope that it will be useful,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied =
warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mo=
re details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https=
://www.gnu.org/licenses/&gt;.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Data Channel Cryptography mbed TLS-specific backe=
nd interface</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef CRYPTO_MBEDTLS_H_</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define CRYPTO_MBEDTLS_H_</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;stdbool.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/cipher.h&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/md.h&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbed=
tls/ctr_drbg.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Generic message =
digest key type %context. */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+typedef mbedtls_md_info_t md_kt_t;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/** Generic cipher %context. */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+typedef mbedtls_cipher_context_t cipher_ctx_t;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/** Generic message digest %context. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+typedef mbedtls_md_context_t m=
d_ctx_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/** Generic HMAC %context. */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef mbedtls_md_c=
ontext_t hmac_ctx_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Use a dummy typ=
e for the provider */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+typedef void provider_t;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Maximum =
length of an IV */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OPENVPN_MAX_IV_LENGTH MBEDTLS_MAX_IV_LENGTH</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/** Cipher is in CBC mode */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define OPENVPN_MODE_CBC MBEDTLS_MODE_CBC</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/** Cipher is in OFB mode */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_MODE_OFB MBEDTLS_MODE_OFB=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/** Cipher is in CFB mode */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_MODE_CFB MBED=
TLS_MODE_CFB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/** Cipher is in GCM mode =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_M=
ODE_GCM MBEDTLS_MODE_GCM</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef mbedtl=
s_operation_t crypto_operation_t;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** C=
ipher should encrypt */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OPENVPN_OP_ENCRYPT MBEDTLS_ENCRYPT</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/** Cipher should decrypt */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define OPENVPN_OP_DECRYPT MBEDTLS_DECRYPT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define MD4_DIGEST_LENGTH    16</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define MD5_DIGEST_LENGTH    16</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define SHA_DIGEST_LENGTH    =
20</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SHA256_DI=
GEST_LENGTH 32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Returns a singleton instance of the m=
bed TLS random number generator.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * F=
or PolarSSL/mbed TLS 1.1+, this is the CTR_DRBG random number generator. If=
 it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hasn&#39;t be=
en initialised yet, the RNG will be initialised using the default</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * entropy sources. Aside fro=
m the default platform entropy sources, an</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * additional entropy source, the HAVEGE random numb=
er generator will also be</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * added. During initialisation, a personalisation string will be add=
ed based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * on the t=
ime, the PID, and a pointer to the random context.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+mbedtls_ctr_drbg_context *rand_ctx_get(void);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifdef ENABLE_PREDICTION_RESISTANCE</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Enable prediction resistance on the random number =
generator.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void rand_ctx_enable_pred=
iction_resistance(void);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Log the supplied mbed TLS error, prefixed by supplied prefi=
x.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param flags         Flags to i=
ndicate error type and priority.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param errval        mbed TLS error code to convert to erro=
r message.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 prefix        Prefix to mbed TLS error message.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @returns true if no errors are detected, false otherwise.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool mbed_log_err(unsigned int flags, =
int errval, const char *prefix);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Log the supplied mb=
ed TLS error, prefixed by function name and line number.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param flags         Flags to indicate error type an=
d priority.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m errval        mbed TLS error code to convert to error message.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param func          Functi=
on name where error was reported.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param line          Line number where error was reported.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @returns true if no errors are de=
tected, false otherwise.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool mbed_l=
og_func_line(unsigned int flags, int errval, const char *func, int line);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/** Wraps mbed_log_func_line() to preven=
t function calls for non-errors */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+mbed_log_func_line_lite(unsigned int flags, int errval, const=
 char *func, int line)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (errval)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return mbed_log_func_line=
(flags, errval, func, line);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Check errval and log on error.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Convenience wrapper to put around mbed TLS library calls, e.g=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   if (!mbed_ok =
(mbedtls_ssl_func())) return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
   ASSERT (mbed_ok (mbedtls_ssl_func()));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param errval        mbed TLS error code to convert to error messag=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @returns true if no errors are =
detected, false otherwise.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define m=
bed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __=
LINE__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif /* CRYPTO_MBEDTLS_H_ */<=
/span><br><span>diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbe=
dtls_compat.h</span><br><span>index d457b5e..667529e 100644</span><br><span=
>--- a/src/openvpn/mbedtls_compat.h</span><br><span>+++ b/src/openvpn/mbedt=
ls_compat.h</span><br><span>@@ -34,6 +34,16 @@</span><br><span> </span><br>=
<span> #include &quot;errlevel.h&quot;</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/asn1.h&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/pk.h&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x0=
4000000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt=
;mbedtls/ctr_drbg.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;crypto_mbedtls_legacy.h&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;mbedtls/oid.h&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 #ifdef HAVE_PSA_CRYPTO_H</span><br><span> #include &lt;psa/crypto.h&gt;</s=
pan><br><span> #endif</span><br><span>@@ -51,4 +61,176 @@</span><br><span> =
#endif</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *name;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint16_t tls_id;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+} mbedtls_ecp_curve_info;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static inline int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+mbedtls_oid_get_attr_short_name(const mbedtls_asn1_buf *oid,=
 const char **desc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The relevan=
t OIDs all have equal length. */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (oid-&gt;tag !=3D MBEDTLS_ASN1_OID || oid-&gt;len !=3D =
strlen(MBEDTLS_OID_AT_CN))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 *desc =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (memcmp(oid-&gt;p, MBEDTLS_OID=
_AT_CN, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     *desc =3D &quot;CN&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_SUR_NAME, oid-&gt;len) =3D=3D 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;SN&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MB=
EDTLS_OID_AT_SERIAL_NUMBER, oid-&gt;len) =3D=3D 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        *desc =3D &quot;serialNumber&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_CO=
UNTRY, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    *desc =3D &quot;C&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_LOCALITY, oid-&gt;len) =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;L&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDT=
LS_OID_AT_STATE, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        *desc =3D &quot;ST&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_ORGANIZATION, oid-&gt;l=
en) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &q=
uot;O&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(o=
id-&gt;p, MBEDTLS_OID_AT_ORG_UNIT, oid-&gt;len) =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        *desc =3D &quot;OU&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_TITLE=
, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *=
desc =3D &quot;title&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_POSTAL_ADDRESS, oid-&gt;len) =3D=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;postal=
Address&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp=
(oid-&gt;p, MBEDTLS_OID_AT_POSTAL_CODE, oid-&gt;len) =3D=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        *desc =3D &quot;postalCode&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS=
_OID_AT_GIVEN_NAME, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        *desc =3D &quot;GN&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_INITIALS, oid-&gt;le=
n) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &qu=
ot;initials&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (me=
mcmp(oid-&gt;p, MBEDTLS_OID_AT_GENERATION_QUALIFIER, oid-&gt;len) =3D=3D 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;generatio=
nQualifier&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (mem=
cmp(oid-&gt;p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIER, oid-&gt;len) =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;uniqueIdentif=
ier&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid=
-&gt;p, MBEDTLS_OID_AT_DN_QUALIFIER, oid-&gt;len) =3D=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        *desc =3D &quot;dnQualifier&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_O=
ID_AT_PSEUDONYM, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        *desc =3D &quot;pseudonym&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *des=
c =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static inline int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+mbedtls_oid_get_extended_key_usage(const mbedtls_asn1_buf *oid, cons=
t char **desc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The relevant OID=
s all have equal length. */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (oid-&gt;tag !=3D MBEDTLS_ASN1_OID || oid-&gt;len !=3D strle=
n(MBEDTLS_OID_SERVER_AUTH))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  *desc =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (memcmp(oid-&gt;p, MBEDTLS_OI=
D_SERVER_AUTH, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        *desc =3D &quot;TLS Web Server Authentication&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_C=
LIENT_AUTH, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        *desc =3D &quot;TLS Web Client Authentication&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_CODE=
_SIGNING, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       *desc =3D &quot;Code Signing&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_EMAIL_PROTECTION, oid-&=
gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =
=3D &quot;E-mail Protection&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_TIME_STAMPING, oid-&gt;len) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;Tim=
e Stamping&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (mem=
cmp(oid-&gt;p, MBEDTLS_OID_OCSP_SIGNING, oid-&gt;len) =3D=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        *desc =3D &quot;OCSP Signing&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        *desc =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &gt;=
=3D 0x04000000 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Some functions tha=
t operate on private keys use randomness to protect against</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * side channels. In Mbed TLS 4, th=
ey automatically use the RNG in the PSA</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * library, but in Mbed TLS 3, they require them as exp=
licit arguments. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mb=
edtls_compat_pk_parse_key(mbedtls_pk_context *ctx,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                            const unsigned c=
har *key, size_t keylen,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                            const unsigned char *pwd, size_t pwdlen)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04=
000000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return mb=
edtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwd=
len, mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static inline int</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+mbedtls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx=
, const char *path, const char *password)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return mbedtls_pk_parse_keyfile(ctx, path=
, password);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_pk=
_parse_keyfile(ctx, path, password, mbedtls_ctr_drbg_random, rand_ctx_get()=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS=
_VERSION_NUMBER &lt; 0x04000000 */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline int</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_compat_pk_check_=
pair(const mbedtls_pk_context *pub, const mbedtls_pk_context *prv)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_p=
k_check_pair(pub, prv);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_random, rand_ctx_get());<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VE=
RSION_NUMBER &lt; 0x04000000 */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> #endif /* MBEDTLS_COMPAT_H_ */</span><br><span>diff --git a/src=
/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index f9=
02e17..3e1698f 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span=
><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -93,7 +93,9 @=
@</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span>     CLEAR(*c=
tx);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span>     ALLOC_OB=
J_CLEAR(ctx-&gt;dhm_ctx, mbedtls_dhm_context);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>     AL=
LOC_OBJ_CLEAR(ctx-&gt;ca_chain, mbedtls_x509_crt);</span><br><span> </span>=
<br><span>@@ -107,7 +109,9 @@</span><br><span>     ASSERT(NULL !=3D ctx);</=
span><br><span>     CLEAR(*ctx);</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</=
span><br><span>     ALLOC_OBJ_CLEAR(ctx-&gt;dhm_ctx, mbedtls_dhm_context);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an>     ALLOC_OBJ_CLEAR(ctx-&gt;ca_chain, mbedtls_x509_crt);</span><br><spa=
n> </span><br><span>     ctx-&gt;endpoint =3D MBEDTLS_SSL_IS_CLIENT;</span>=
<br><span>@@ -128,8 +132,10 @@</span><br><span>         mbedtls_x509_crt_fr=
ee(ctx-&gt;crt_chain);</span><br><span>         free(ctx-&gt;crt_chain);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span>         mbedtls_dhm=
_free(ctx-&gt;dhm_ctx);</span><br><span>         free(ctx-&gt;dhm_ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>=
 </span><br><span>         mbedtls_x509_crl_free(ctx-&gt;crl);</span><br><s=
pan>         free(ctx-&gt;crl);</span><br><span>@@ -348,6 +354,34 @@</span>=
<br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x0400=
0000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const mb=
edtls_ecp_curve_info ecp_curve_info_table[] =3D {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* TODO: Fill out the table. */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;secp256r1&quot;, =
MBEDTLS_SSL_IANA_TLS_GROUP_SECP256R1 },</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    { &quot;secp384r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP=
_SECP384R1 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { =
&quot;X25519&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_X25519 },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    { &quot;ffdhe2048&quot;, MBEDTLS_S=
SL_IANA_TLS_GROUP_FFDHE2048 },</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    { &quot;ffdhe3072&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE307=
2 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;ffd=
he4096&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE4096 },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    { &quot;ffdhe6144&quot;, MBEDTLS_SSL_=
IANA_TLS_GROUP_FFDHE6144 },</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    { &quot;ffdhe8192&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE8192 }=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static const size_t ecp_curve_info_=
table_items =3D sizeof(ecp_curve_info_table) / sizeof(mbedtls_ecp_curve_inf=
o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static const mbedtls_ecp_curve_info=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_ecp_curve=
_info_from_name(const char *name)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (size_t i =3D 0; i &lt; ecp_curve_info_table_items; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (strcmp(name, ecp_curve_info_table[i]=
.name) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn &amp;ecp_curve_info_table[i];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUM=
BER &gt;=3D 0x04000000 */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> void</span><br><span> tls_ctx_set_tls_groups(struct=
 tls_root_ctx *ctx, const char *groups)</span><br><span> {</span><br><span>=
@@ -409,6 +443,7 @@</span><br><span> void</span><br><span> tls_ctx_load_dh_=
params(struct tls_root_ctx *ctx, const char *dh_file, bool dh_inline)</span=
><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MB=
EDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span>     if (dh_inline)</s=
pan><br><span>     {</span><br><span>         if (!mbed_ok(mbedtls_dhm_pars=
e_dhm(ctx-&gt;dhm_ctx, (const unsigned char *)dh_file,</span><br><span>@@ -=
427,6 +462,12 @@</span><br><span> </span><br><span>     msg(D_TLS_DEBUG_LOW=
, &quot;Diffie-Hellman initialized with &quot; counter_format &quot; bit ke=
y&quot;,</span><br><span>         (counter_type)mbedtls_dhm_get_bitlen(ctx-=
&gt;dhm_ctx));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(dh_f=
ile, &quot;none&quot;) !=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_FATAL, &quot;Mbed TLS 4 only supports pre-defined Diffie-Hellman=
 groups.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS=
_VERSION_NUMBER &lt; 0x04000000 */</span><br><span> }</span><br><span> </sp=
an><br><span> void</span><br><span>@@ -500,29 +541,26 @@</span><br><span> <=
/span><br><span>     if (priv_key_inline)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        status =3D mbedtls_pk_pa=
rse_key(ctx-&gt;priv_key, (const unsigned char *)priv_key_file,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
     strlen(priv_key_file) + 1, NULL, 0,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                      mbedtls_ctr_drbg_r=
andom, rand_ctx_get());</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        status =3D mbedtls_compat_pk_parse_key(ctx-&gt;priv_key, (const=
 unsigned char *)priv_key_file,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                             strlen(priv_key_fi=
le) + 1, NULL, 0);</span><br><span> </span><br><span>         if (MBEDTLS_E=
RR_PK_PASSWORD_REQUIRED =3D=3D status)</span><br><span>         {</span><br=
><span>             char passbuf[512] =3D { 0 };</span><br><span>          =
   pem_password_callback(passbuf, 512, 0, NULL);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            status =3D mbedtls_pk_parse_key(</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            status =3D =
mbedtls_compat_pk_parse_key(</span><br><span>                 ctx-&gt;priv_=
key, (const unsigned char *)priv_key_file, strlen(priv_key_file) + 1,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                (unsigned c=
har *)passbuf, strlen(passbuf), mbedtls_ctr_drbg_random, rand_ctx_get());</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                (unsi=
gned char *)passbuf, strlen(passbuf));</span><br><span>         }</span><br=
><span>     }</span><br><span>     else</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        status =3D mbedtls_pk_pars=
e_keyfile(ctx-&gt;priv_key, priv_key_file, NULL,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                          mbedtl=
s_ctr_drbg_random, rand_ctx_get());</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        status =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;=
priv_key, priv_key_file, NULL);</span><br><span>         if (MBEDTLS_ERR_PK=
_PASSWORD_REQUIRED =3D=3D status)</span><br><span>         {</span><br><spa=
n>             char passbuf[512] =3D { 0 };</span><br><span>             pe=
m_password_callback(passbuf, 512, 0, NULL);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            status =3D mbedtls_pk_parse_keyfile(ctx-&=
gt;priv_key, priv_key_file, passbuf,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                              mbedtls_ctr_dr=
bg_random, rand_ctx_get());</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            status =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;priv=
_key, priv_key_file, passbuf);</span><br><span>         }</span><br><span> =
    }</span><br><span>     if (!mbed_ok(status))</span><br><span>@@ -538,8 =
+576,7 @@</span><br><span>         return 1;</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mb=
ed_ok(mbedtls_pk_check_pair(&amp;ctx-&gt;crt_chain-&gt;pk, ctx-&gt;priv_key=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
                   mbedtls_ctr_drbg_random, rand_ctx_get())))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_compat_p=
k_check_pair(&amp;ctx-&gt;crt_chain-&gt;pk, ctx-&gt;priv_key)))</span><br><=
span>     {</span><br><span>         msg(M_WARN, &quot;Private key does not=
 match the certificate&quot;);</span><br><span>         return 1;</span><br=
><span>@@ -553,6 +590,7 @@</span><br><span> #pragma GCC diagnostic ignored =
&quot;-Wconversion&quot;</span><br><span> #endif</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &=
lt; 0x04000000</span><br><span> /**</span><br><span>  * external_pkcs1_sign=
 implements a mbed TLS rsa_sign_func callback, that uses</span><br><span>  =
* the management interface to request an RSA signature for the supplied has=
h.</span><br><span>@@ -669,11 +707,16 @@</span><br><span> </span><br><span>=
     return ctx-&gt;signature_length;</span><br><span> }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt; =
0x04000000 */</span><br><span> </span><br><span> int</span><br><span> tls_c=
tx_use_external_signing_func(struct tls_root_ctx *ctx, external_sign_func s=
ign_func,</span><br><span>                                   void *sign_ctx=
)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    msg(M_WARN, &quot;tls_ctx_use_external_signi=
ng_func is not implemented for Mbed TLS 4.&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return 1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#else</span><br><span>     ASSERT(NULL !=3D ctx);<=
/span><br><span> </span><br><span>     if (ctx-&gt;crt_chain =3D=3D NULL)</=
span><br><span>@@ -701,6 +744,7 @@</span><br><span>     }</span><br><span> =
</span><br><span>     return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000 */</span><b=
r><span> }</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</spa=
n><br><span>@@ -938,6 +982,7 @@</span><br><span> void</span><br><span> tls_=
ctx_personalise_random(struct tls_root_ctx *ctx)</span><br><span> {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER =
&lt; 0x04000000</span><br><span>     static char old_sha256_hash[32] =3D { =
0 };</span><br><span>     unsigned char sha256_hash[32] =3D { 0 };</span><b=
r><span>     mbedtls_ctr_drbg_context *cd_ctx =3D rand_ctx_get();</span><br=
><span>@@ -960,6 +1005,7 @@</span><br><span>             memcpy(old_sha256_=
hash, sha256_hash, sizeof(old_sha256_hash));</span><br><span>         }</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x040000 */</span><br><span> }</span>=
<br><span> </span><br><span> #if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span>@@ -1069,7 +1115,9 @@</span><br><span>     }</span><br><span>=
 #endif</span><br><span>     mbedtls_ssl_conf_dbg(ks_ssl-&gt;ssl_config, my=
_debug, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if M=
BEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span>     mbedtls_ssl_conf=
_rng(ks_ssl-&gt;ssl_config, mbedtls_ctr_drbg_random, rand_ctx_get());</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION=
_NUMBER &lt; 0x04000000 */</span><br><span> </span><br><span>     mbedtls_s=
sl_conf_cert_profile(ks_ssl-&gt;ssl_config, &amp;ssl_ctx-&gt;cert_profile);=
</span><br><span> </span><br><span>@@ -1100,12 +1148,14 @@</span><br><span>=
 #endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */</span><br><span> </span><br>=
<span>     /* Initialise authentication information */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x040000=
00</span><br><span>     if (is_server)</span><br><span>     {</span><br><sp=
an>         mbed_ok(mbedtls_ssl_conf_dh_param_ctx(ks_ssl-&gt;ssl_config, ss=
l_ctx-&gt;dhm_ctx));</span><br><span>     }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl-&gt=
;ssl_config, ssl_ctx-&gt;crt_chain, ssl_ctx-&gt;priv_key));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    (void)mbed_ok(mbedtls_ssl_conf_=
own_cert(ks_ssl-&gt;ssl_config, ssl_ctx-&gt;crt_chain, ssl_ctx-&gt;priv_key=
));</span><br><span> </span><br><span>     /* Initialise SSL verification *=
/</span><br><span>     if (session-&gt;opt-&gt;ssl_flags &amp; SSLF_CLIENT_=
CERT_OPTIONAL)</span><br><span>@@ -1160,7 +1210,7 @@</span><br><span>     /=
* Initialise SSL context */</span><br><span>     ALLOC_OBJ_CLEAR(ks_ssl-&gt=
;ctx, mbedtls_ssl_context);</span><br><span>     mbedtls_ssl_init(ks_ssl-&g=
t;ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbed_ok(mb=
edtls_ssl_setup(ks_ssl-&gt;ctx, ks_ssl-&gt;ssl_config));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    (void)mbed_ok(mbedtls_ssl_setup(ks=
_ssl-&gt;ctx, ks_ssl-&gt;ssl_config));</span><br><span>     /* We do verifi=
cation in our own callback depending on the</span><br><span>      * exact c=
onfiguration. We do not rely on the default hostname</span><br><span>      =
* verification. */</span><br><span>@@ -1376,7 +1426,8 @@</span><br><span>  =
   /* Error during read, check for retry error */</span><br><span>     if (=
retval &lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval || MBE=
DTLS_ERR_SSL_WANT_READ =3D=3D retval)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval || M=
BEDTLS_ERR_SSL_WANT_READ =3D=3D retval</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            || MBEDTLS_ERR_SSL_RECEIVED_NEW_SESSION_TICK=
ET =3D=3D retval)</span><br><span>         {</span><br><span>             r=
eturn 0;</span><br><span>         }</span><br><span>@@ -1456,6 +1507,7 @@</=
span><br><span> void</span><br><span> show_available_curves(void)</span><br=
><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTL=
S_VERSION_NUMBER &lt; 0x04000000</span><br><span>     const mbedtls_ecp_cur=
ve_info *pcurve =3D mbedtls_ecp_curve_list();</span><br><span> </span><br><=
span>     if (NULL =3D=3D pcurve)</span><br><span>@@ -1470,6 +1522,9 @@</sp=
an><br><span>         printf(&quot;%s\n&quot;, pcurve-&gt;name);</span><br>=
<span>         pcurve++;</span><br><span>     }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    msg(M_FATAL, &quot;Mbed TLS 4 has no mechanism to list su=
pported curves.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><br><span> }<=
/span><br><span> </span><br><span> const char *</span><br><span>diff --git =
a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h</span><br><span>ind=
ex f744945..6b678b2 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.h<=
/span><br><span>+++ b/src/openvpn/ssl_mbedtls.h</span><br><span>@@ -112,11 =
+112,13 @@</span><br><span>  */</span><br><span> struct tls_root_ctx</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool =
initialised;                      /**&lt; True if the context has been init=
ialised */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
initialised; /**&lt; True if the context has been initialised */</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int endpoi=
nt;                          /**&lt; Whether or not this is a server or a c=
lient */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int end=
point;     /**&lt; Whether or not this is a server or a client */</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS=
_VERSION_NUMBER &lt; 0x04000000</span><br><span>     mbedtls_dhm_context *d=
hm_ctx;          /**&lt; Diffie-Helmann-Merkle context */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     mbedtls_x=
509_crt *crt_chain;           /**&lt; Local Certificate chain */</span><br>=
<span>     mbedtls_x509_crt *ca_chain;            /**&lt; CA chain for remo=
te verification */</span><br><span>     mbedtls_pk_context *priv_key;      =
    /**&lt; Local private key */</span><br><span>diff --git a/src/openvpn/s=
sl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>inde=
x 9d89a1d..32f3ecb 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbed=
tls.c</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.c</span><br><spa=
n>@@ -34,13 +34,22 @@</span><br><span> </span><br><span> #if defined(ENABLE=
_CRYPTO_MBEDTLS)</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;mbedtls/version.h&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_mbedtls_legacy.h&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbe=
dtls/bignum.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;mbedtls/sha1.h&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#else</span><br><span> #include &quot;crypto_mbedtls.h&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;mbedtls_compat.h&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &quot;ssl_v=
erify.h&quot;</span><br><span> #include &lt;mbedtls/asn1.h&gt;</span><br><s=
pan> #include &lt;mbedtls/error.h&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#include &lt;mbedtls/bignum.h&gt;</span><br><span> #include=
 &lt;mbedtls/oid.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#include &lt;mbedtls/sha1.h&gt;</span><br><span> </span><br><span> #define=
 MAX_SUBJECT_LENGTH 256</span><br><span> </span><br><span>@@ -171,11 +180,1=
39 @@</span><br><span>     return SUCCESS;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VER=
SION_NUMBER &gt;=3D 0x04000000</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Mbed TLS 4 has no function to print the certificate serial nu=
mber and does</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * not=
 expose the bignum functions anymore. So in order to write the serial</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * number as a decimal st=
ring, we implement bignum % 10 and bignum / 10. */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static char</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bignum_mod_10(const uint8_t *bignum, size_t bignum_l=
ength)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int result =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &l=
t; bignum_length; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        res=
ult =3D (result * 256) % 10;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        result =3D (result + bignum[i]) % 10;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return (char)result;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Divide b=
ignum by 10 rounded down, in place. */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bignum_div_10(uint8_t *bignum, size_t *bignum_length)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * Some intuition for the algorithm below:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * We want to calculate</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     *     (bignum[0] * 256^n + bignum[1] * 256^(n-1=
) + ... + bignum[n]) / 10.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 Let remainder =3D bignum[0] % 10 and carry =3D remainder * 256.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * Then we can write the a=
bove as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     *     (bignum[0] / 1=
0) * 256^n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *   =
    + ((carry + bignum[1]) * 256^(n-1) + ... + bignum[n]) / 10.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * So now we have the first byte of our =
result. The second byte will be</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * (carry + bignum[1]) / 10. Note that this fits into one b=
yte because</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 0=
 &lt;=3D remainder &lt; 10. We calculate the next remainder and carry as</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * remainder =3D (=
carry + bignum[1]) % 10 and carry =3D remainder * 256 and</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * move on to the next byte until=
 we are done.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t new_len=
gth =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int c=
arry =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for =
(size_t i =3D 0; i &lt; *bignum_length; i++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uint8_t next_byte =3D (uint8_t)((bignum[i] + carry) / 10=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int remai=
nder =3D (bignum[i] + carry) % 10;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        carry =3D remainder * 256;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* Write the byte unless it&#39;s a leading zero. */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (new_length =
!=3D 0 || next_byte !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          bignum[new_length++] =3D next_byte;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    *bignum_length =3D new_length;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write the decimal=
 representation of bignum to out, if enough space is available.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Returns the number of bytes =
needed in out, or 0 on error. To calculate the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * necessary buffer size, the function can be ca=
lled with out =3D NULL. */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+write_bignum(char *out, size_t out_size, const uint8_t *bignum, size_t big=
num_length)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bignum_length =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* We want out to b=
e &quot;0&quot;. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (out !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (out_size &gt;=3D 2)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                out[0] =3D &#39;0&#39;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                out[1] =3D &#39;\0&#39;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            else if (out_size &gt=
; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                out[0=
] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 2=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    uint8_t *bignum_copy =3D malloc(bignum_length);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bignum_copy=
 =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    memcpy(bignum_copy, bignum, bign=
um_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t bytes_needed =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t bytes=
_written =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
while (bignum_length &gt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* We&#39;re writing the digits in reverse order. We put them in the rig=
ht order later. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       char digit =3D bignum_mod_10(bignum_copy, bignum_length);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (out !=3D NULL &amp=
;&amp; bytes_written &lt; out_size - 1)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            out[bytes_written++] =3D &#39;0&#39; + (char)digit;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        bytes_needed +=3D 1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        bignum_div_10(=
bignum_copy, &amp;bignum_length);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (out !=3D NU=
LL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (bytes_written =3D=
=3D bytes_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
/* We had space for all digits. Now reverse them. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            for (size_t i =3D 0; i &lt; b=
ytes_written / 2; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             char tmp =3D out[i];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                out[i] =3D out[bytes_written - 1 - i];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                out[bytes_=
written - 1 - i] =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            out[bytes_written] =3D &#39;\0&#39;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else if (out_size &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            out[0] =3D &#39;\0&#39;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bytes_needed +=3D 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    free(bignum_copy);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return bytes_needed;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif =
/* MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000 */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> char *</span><br><span> backe=
nd_x509_get_serial(mbedtls_x509_crt *cert, struct gc_arena *gc)</span><br><=
span> {</span><br><span>     char *buf =3D NULL;</span><br><span>     size_=
t buflen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUM=
BER &lt; 0x04000000</span><br><span>     mbedtls_mpi serial_mpi =3D { 0 };<=
/span><br><span> </span><br><span>     /* Transform asn1 integer serial int=
o mbed TLS MPI */</span><br><span>@@ -201,6 +338,21 @@</span><br><span> end=
:</span><br><span>     mbedtls_mpi_free(&amp;serial_mpi);</span><br><span> =
    return buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buflen =3D wri=
te_bignum(NULL, 0, cert-&gt;serial.p, cert-&gt;serial.len);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (buflen =3D=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Failed to write se=
rial to string.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =
=3D gc_malloc(buflen, true, gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (write_bignum(buf, buflen, cert-&gt;serial.p, cert-&gt;=
serial.len) !=3D buflen)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(M_WARN, &quot;Failed to write serial to string.&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return buf;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</=
span><br><span> }</span><br><span> </span><br><span> char *</span><br><span=
>diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h</span><br><span=
>index 2e22204..582e130 100644</span><br><span>--- a/src/openvpn/syshead.h<=
/span><br><span>+++ b/src/openvpn/syshead.h</span><br><span>@@ -475,7 +475,=
10 @@</span><br><span> #endif</span><br><span> </span><br><span> #ifdef ENA=
BLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;mbedtls/version.h&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span> #=
define ENABLE_PREDICTION_RESISTANCE</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><=
br><span> #endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span> </span><br><s=
pan> /*</span><br><span>diff --git a/tests/Makefile.am b/tests/Makefile.am<=
/span><br><span>index bf8f960..cb30fe5 100644</span><br><span>--- a/tests/M=
akefile.am</span><br><span>+++ b/tests/Makefile.am</span><br><span>@@ -55,6=
 +55,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch.c \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><span>=
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=
.c \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</span><br><span>=
 	$(top_srcdir)/src/openvpn/packet_id.c \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/platform.c</span><br><span>diff --git a/tests/t_server_null_defa=
ult.rc b/tests/t_server_null_default.rc</span><br><span>index 798cfd0..bba7=
7aa 100755</span><br><span>--- a/tests/t_server_null_default.rc</span><br><=
span>+++ b/tests/t_server_null_default.rc</span><br><span>@@ -57,7 +57,7 @@=
</span><br><span> SERVER_SERVER_2=3D&quot;--server 10.29.42.0 255.255.255.0=
&quot;</span><br><span> SERVER_MGMT_PORT_2=3D&quot;11195&quot;</span><br><s=
pan> SERVER_EXEC_2=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-SERVER_CONF_2=3D&quot;${SERVER_CONF_BASE} ${SERVE=
R_SERVER_2} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_P=
ORT_2} --dh ${DH}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+SERVER_CONF_2=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 11=
95 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2} --dh none&quot;=
</span><br><span> </span><br><span> SERVER_NAME_3=3D&quot;t_server_null_ser=
ver-1196_udp&quot;</span><br><span> SERVER_SERVER_3=3D&quot;--server 10.29.=
43.0 255.255.255.0&quot;</span><br><span>diff --git a/tests/unit_tests/open=
vpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>inde=
x 7aeea47..1128eb4 100644</span><br><span>--- a/tests/unit_tests/openvpn/Ma=
kefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span>=
<br><span>@@ -76,6 +76,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/buf=
fer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><s=
pan> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_mbedtls_le=
gacy.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl.c \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> =
	$(top_srcdir)/src/openvpn/otime.c \</span><br><span>@@ -110,6 +111,7 @@</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/cryptoapi.c \</span><br><span> 	$=
(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/crypto_mbedtls.c \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \</span><br><s=
pan> 	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><span> 	$(top_=
srcdir)/src/openvpn/env_set.c \</span><br><span> 	$(top_srcdir)/src/openvpn=
/mss.c \</span><br><span>@@ -158,6 +160,7 @@</span><br><span> 	$(top_srcdir=
)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=
_epoch.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/op=
envpn/crypto_mbedtls_legacy.c \</span><br><span> 	$(top_srcdir)/src/openvpn=
/crypto_openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/env_set.c \=
</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</span><br><span>@@ -=
188,6 +191,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	=
$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br=
><span> 	$(top_srcdir)/src/openvpn/env_set.c \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/otime.c \</span><br><span>@@ -208,6 +212,7 @@</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/crypto_epoch.c \</span><br><span> 	$(top_srcdir)/src/openvpn/cry=
pto_mbedtls.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(t=
op_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/crypto_openssl.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/fdmisc.c \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</spa=
n><br><span>@@ -294,6 +299,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn=
/crypto.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch.c \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_=
mbedtls_legacy.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_opens=
sl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/packet_id.c \</span><br><span>@@ -332,6 +338,=
7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span=
> 	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/crypto_mbedtls.c \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><br><span> 	$(=
top_srcdir)/src/openvpn/otime.c \</span><br><span> 	$(top_srcdir)/src/openv=
pn/packet_id.c \</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_common.h b/tests/unit_tests/openvpn/test_common.h</span><br><span>index 15=
6e5a9..fb070aa 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_c=
ommon.h</span><br><span>+++ b/tests/unit_tests/openvpn/test_common.h</span>=
<br><span>@@ -25,6 +25,10 @@</span><br><span> #include &lt;stdlib.h&gt;</sp=
an><br><span> #include &lt;cmocka.h&gt;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_MBEDTLS)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mbedtls=
_compat.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /* Do we use cmocka &lt; 2.0.0? */</span><br><span> #ifndef HAVE_CMOCKA_VE=
RSION_H</span><br><span> #define HAVE_OLD_CMOCKA_API 1</span><br><span>@@ -=
58,6 +62,9 @@</span><br><span> {</span><br><span>     assert_int_equal(setv=
buf(stdout, NULL, _IONBF, BUFSIZ), 0);</span><br><span>     assert_int_equa=
l(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_compat_psa_crypto_init(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span> }</span><br><span> </span><br><span> /**</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/14=
41?usp=3Demail">change 1441</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111=
bcc627cdb0fae </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1441 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
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

</body></html>=

--DhYhKX5zBO8=--

