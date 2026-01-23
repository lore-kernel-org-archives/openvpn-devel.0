From: Gert Doering <gert@...1296...>
Date: Fri, 23 Jan 2026 17:47:39 +0100
Message-ID: <20260123164746.7333-1-gert@...1296...>
In-Reply-To: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
References: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] Add support for Mbed TLS 4
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
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1441
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/README.mbedtls b/README.mbedtls
index fb30db1..b768687 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -7,8 +7,8 @@
 	make
 	make install
 
-This version requires mbed TLS version >= 3.2.1. Versions >= 4.0.0 are not
-yet supported. Support for TLS 1.3 requires an Mbed TLS version >= 3.6.4.
+This version requires mbed TLS version >= 3.2.1. Support for TLS 1.3 requires
+an Mbed TLS version >= 3.6.4.
 
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
+ * Data Channel Cryptography backend interface using the TF-PSA-Crypto library
+ * part of Mbed TLS 4.
  */
 
 #ifdef HAVE_CONFIG_H
@@ -33,6 +34,9 @@
 #include "syshead.h"
 
 #if defined(ENABLE_CRYPTO_MBEDTLS)
+#include <mbedtls/version.h>
+
+#if MBEDTLS_VERSION_NUMBER >= 0x04000000
 
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
+/* The library doesn't support looking up algorithms by string anymore, so here
+ * is a lookup table. */
+static const cipher_info_t cipher_info_table[] = {
+/* TODO: Complete the table. */
 
-void
-crypto_init_lib(void)
-{
-}
+/* AES */
+#if PSA_WANT_KEY_TYPE_AES
+#if PSA_WANT_ALG_GCM
+    { "AES-128-GCM", PSA_KEY_TYPE_AES, PSA_ALG_GCM, 128 / 8, 96 / 8, 128 / 8 },
+    { "AES-192-GCM", PSA_KEY_TYPE_AES, PSA_ALG_GCM, 192 / 8, 96 / 8, 128 / 8 },
+    { "AES-256-GCM", PSA_KEY_TYPE_AES, PSA_ALG_GCM, 256 / 8, 96 / 8, 128 / 8 },
+#endif /* PSA_WANT_ALG_GCM */
+#if PSA_WANT_ALG_CBC_PKCS7
+    { "AES-128-CBC", PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 128 / 8, 128 / 8, 128 / 8 },
+    { "AES-192-CBC", PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 192 / 8, 128 / 8, 128 / 8 },
+    { "AES-256-CBC", PSA_KEY_TYPE_AES, PSA_ALG_CBC_PKCS7, 256 / 8, 128 / 8, 128 / 8 },
+#endif /* PSA_WANT_ALG_CBC_PKCS7 */
+#if PSA_WANT_ALG_CTR
+    { "AES-128-CTR", PSA_KEY_TYPE_AES, PSA_ALG_CTR, 128 / 8, 128 / 8, 128 / 8 },
+    { "AES-192-CTR", PSA_KEY_TYPE_AES, PSA_ALG_CTR, 192 / 8, 128 / 8, 128 / 8 },
+    { "AES-256-CTR", PSA_KEY_TYPE_AES, PSA_ALG_CTR, 256 / 8, 128 / 8, 128 / 8 },
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
-    if (0 != errval)
-    {
-        char errstr[256];
-        mbedtls_strerror(errval, errstr, sizeof(errstr));
-
-        if (NULL == prefix)
-        {
-            prefix = "mbed TLS error";
-        }
-        msg(flags, "%s: %s", prefix, errstr);
-    }
-
-    return 0 == errval;
-}
-
-bool
-mbed_log_func_line(unsigned int flags, int errval, const char *func, int line)
-{
-    char prefix[256];
-
-    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >= sizeof(prefix))
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
-const cipher_name_pair cipher_name_translation_table[] = {
-    { "BF-CBC", "BLOWFISH-CBC" },
-    { "BF-CFB", "BLOWFISH-CFB64" },
-    { "CAMELLIA-128-CFB", "CAMELLIA-128-CFB128" },
-    { "CAMELLIA-192-CFB", "CAMELLIA-192-CFB128" },
-    { "CAMELLIA-256-CFB", "CAMELLIA-256-CFB128" }
+/* Chacha-Poly */
+#if PSA_WANT_KEY_TYPE_CHACHA20 && PSA_WANT_ALG_CHACHA20_POLY1305
+    { "CHACHA20-POLY1305", PSA_KEY_TYPE_CHACHA20, PSA_ALG_CHACHA20_POLY1305, 256 / 8, 96 / 8, 1 },
+#endif
 };
+static const size_t cipher_info_table_entries = sizeof(cipher_info_table) / sizeof(cipher_info_t);
+
+static const cipher_info_t *
+cipher_get(const char *ciphername)
+{
+    for (size_t i = 0; i < cipher_info_table_entries; i++)
+    {
+        if (strcmp(ciphername, cipher_info_table[i].name) == 0)
+        {
+            return &cipher_info_table[i];
+        }
+    }
+    return NULL;
+}
+
+/* Because Mbed TLS 4 doesn't support looking up algorithms by string, there's
+ * nothing to translate. */
+const cipher_name_pair cipher_name_translation_table[] = {};
 const size_t cipher_name_translation_table_count =
-    sizeof(cipher_name_translation_table) / sizeof(*cipher_name_translation_table);
-
-void
-show_available_ciphers(void)
-{
-    const int *ciphers = mbedtls_cipher_list();
-
-#ifndef ENABLE_SMALL
-    printf("The following ciphers and cipher modes are available for use\n"
-           "with " PACKAGE_NAME ".  Each cipher shown below may be used as a\n"
-           "parameter to the --data-ciphers (or --cipher) option.  Using a\n"
-           "GCM or CBC mode is recommended.  In static key mode only CBC\n"
-           "mode is allowed.\n\n");
-#endif
-
-    while (*ciphers != 0)
-    {
-        const mbedtls_cipher_info_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        const char *name = mbedtls_cipher_info_get_name(info);
-        if (info && name && !cipher_kt_insecure(name)
-            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
-        {
-            print_cipher(name);
-        }
-        ciphers++;
-    }
-
-    printf("\nThe following ciphers have a block size of less than 128 bits, \n"
-           "and are therefore deprecated.  Do not use unless you have to.\n\n");
-    ciphers = mbedtls_cipher_list();
-    while (*ciphers != 0)
-    {
-        const mbedtls_cipher_info_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        const char *name = mbedtls_cipher_info_get_name(info);
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
-    const int *digests = mbedtls_md_list();
-
-#ifndef ENABLE_SMALL
-    printf("The following message digests are available for use with\n" PACKAGE_NAME
-           ".  A message digest is used in conjunction with\n"
-           "the HMAC function, to authenticate received packets.\n"
-           "You can specify a message digest as parameter to\n"
-           "the --auth option.\n\n");
-#endif
-
-    while (*digests != 0)
-    {
-        const mbedtls_md_info_t *info = mbedtls_md_info_from_type(*digests);
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
-crypto_pem_encode(const char *name, struct buffer *dst, const struct buffer *src,
-                  struct gc_arena *gc)
-{
-    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
-    char header[1000 + 1] = { 0 };
-    char footer[1000 + 1] = { 0 };
-
-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >= sizeof(header))
-    {
-        return false;
-    }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >= sizeof(footer))
-    {
-        return false;
-    }
-
-    size_t out_len = 0;
-    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
-        != mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), NULL, 0, &out_len))
-    {
-        return false;
-    }
-
-    /* We set the size buf to out_len-1 to NOT include the 0 byte that
-     * mbedtls_pem_write_buffer in its length calculation */
-    *dst = alloc_buf_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), BPTR(dst),
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
-crypto_pem_decode(const char *name, struct buffer *dst, const struct buffer *src)
-{
-    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
-    char header[1000 + 1] = { 0 };
-    char footer[1000 + 1] = { 0 };
-
-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >= sizeof(header))
-    {
-        return false;
-    }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >= sizeof(footer))
-    {
-        return false;
-    }
-
-    /* mbed TLS requires the src to be null-terminated */
-    /* allocate a new buffer to avoid modifying the src buffer */
-    struct gc_arena gc = gc_new();
-    struct buffer input = alloc_buf_gc(BLEN(src) + 1, &gc);
-    buf_copy(&input, src);
-    buf_null_terminate(&input);
-
-    size_t use_len = 0;
-    mbedtls_pem_context ctx = { 0 };
-    bool ret =
-        mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(&input), NULL, 0, &use_len));
-    size_t buf_size = 0;
-    const unsigned char *buf = mbedtls_pem_get_buffer(&ctx, &buf_size);
-    if (ret && !buf_write(dst, buf, buf_size))
-    {
-        ret = false;
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
- * Initialise the given ctr_drbg context, using a personalisation string and an
- * entropy gathering function.
- */
-mbedtls_ctr_drbg_context *
-rand_ctx_get(void)
-{
-    static mbedtls_entropy_context ec = { 0 };
-    static mbedtls_ctr_drbg_context cd_ctx = { 0 };
-    static bool rand_initialised = false;
-
-    if (!rand_initialised)
-    {
-        struct gc_arena gc = gc_new();
-        struct buffer pers_string = alloc_buf_gc(100, &gc);
-
-        /*
-         * Personalisation string, should be as unique as possible (see NIST
-         * 800-90 section 8.7.1). We have very little information at this stage.
-         * Include Program Name, memory address of the context and PID.
-         */
-        buf_printf(&pers_string, "OpenVPN %0u %p %s", platform_getpid(), &cd_ctx,
-                   time_string(0, 0, 0, &gc));
-
-        /* Initialise mbed TLS RNG, and built-in entropy sources */
-        mbedtls_entropy_init(&ec);
-
-        mbedtls_ctr_drbg_init(&cd_ctx);
-        if (!mbed_ok(mbedtls_ctr_drbg_seed(&cd_ctx, mbedtls_entropy_func, &ec, BPTR(&pers_string),
-                                           BLEN(&pers_string))))
-        {
-            msg(M_FATAL, "Failed to initialize random generator");
-        }
-
-        gc_free(&gc);
-        rand_initialised = true;
-    }
-
-    return &cd_ctx;
-}
-
-#ifdef ENABLE_PREDICTION_RESISTANCE
-void
-rand_ctx_enable_prediction_resistance(void)
-{
-    mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
-
-    mbedtls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);
-}
-#endif /* ENABLE_PREDICTION_RESISTANCE */
+    sizeof(cipher_name_translation_table) / sizeof(cipher_name_pair);
 
 int
 rand_bytes(uint8_t *output, int len)
 {
-    mbedtls_ctr_drbg_context *rng_ctx = rand_ctx_get();
-
-    while (len > 0)
+    if (len < 0)
     {
-        const size_t blen = min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
-        if (0 != mbedtls_ctr_drbg_random(rng_ctx, output, blen))
-        {
-            return 0;
-        }
-
-        output += blen;
-        len -= blen;
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
-    const mbedtls_cipher_info_t *cipher = NULL;
-
-    ciphername = translate_cipher_name_from_openvpn(ciphername);
-    cipher = mbedtls_cipher_info_from_string(ciphername);
-    return cipher;
+    psa_status_t result = psa_generate_random(output, (size_t)len);
+    return result == PSA_SUCCESS;
 }
 
 bool
@@ -414,23 +148,22 @@
 {
     ASSERT(reason);
 
-    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
+    const cipher_info_t *cipher_info = cipher_get(ciphername);
 
-    if (NULL == cipher)
+    if (cipher_info == NULL)
     {
         msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
         *reason = "disabled because unknown";
         return false;
     }
 
-    const size_t key_bytelen = mbedtls_cipher_info_get_key_bitlen(cipher) / 8;
-    if (key_bytelen > MAX_CIPHER_KEY_LENGTH)
+    if (cipher_info->key_bytes > MAX_CIPHER_KEY_LENGTH)
     {
         msg(D_LOW,
-            "Cipher algorithm '%s' uses a default key size (%zu bytes) "
+            "Cipher algorithm '%s' uses a default key size (%d bytes) "
             "which is larger than " PACKAGE_NAME "'s current maximum key size "
             "(%d bytes)",
-            ciphername, key_bytelen, MAX_CIPHER_KEY_LENGTH);
+            ciphername, cipher_info->key_bytes, MAX_CIPHER_KEY_LENGTH);
         *reason = "disabled due to key size too large";
         return false;
     }
@@ -442,49 +175,46 @@
 const char *
 cipher_kt_name(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
-    if (NULL == cipher_kt)
+    const cipher_info_t *cipher_info = cipher_get(ciphername);
+    if (cipher_info == NULL)
     {
         return "[null-cipher]";
     }
-
-    return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(cipher_kt));
+    return cipher_info->name;
 }
 
 int
 cipher_kt_key_size(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
-
-    if (NULL == cipher_kt)
+    const cipher_info_t *cipher_info = cipher_get(ciphername);
+    if (cipher_info == NULL)
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
-    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
+    const cipher_info_t *cipher_info = cipher_get(ciphername);
 
-    if (NULL == cipher_kt)
+    if (cipher_info == NULL)
     {
         return 0;
     }
-    return (int)mbedtls_cipher_info_get_iv_size(cipher_kt);
+    return cipher_info->iv_bytes;
 }
 
 int
 cipher_kt_block_size(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
-    if (NULL == cipher_kt)
+    const cipher_info_t *cipher_info = cipher_get(ciphername);
+    if (cipher_info == NULL)
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
-    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
-    if (!cipher_kt)
+    const cipher_info_t *cipher_info = cipher_get(ciphername);
+    if (cipher_info == NULL)
     {
         return true;
     }
 
-    return !(cipher_kt_block_size(ciphername) >= 128 / 8
-#ifdef MBEDTLS_CHACHAPOLY_C
-             || mbedtls_cipher_info_get_type(cipher_kt) == MBEDTLS_CIPHER_CHACHA20_POLY1305
-#endif
-    );
-}
-
-static mbedtls_cipher_mode_t
-cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
-{
-    ASSERT(NULL != cipher_kt);
-    return mbedtls_cipher_info_get_mode(cipher_kt);
+    return !(cipher_info->block_size >= 128 / 8
+             || cipher_info->psa_alg == PSA_ALG_CHACHA20_POLY1305);
 }
 
 bool
 cipher_kt_mode_cbc(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
-    return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC;
+    const cipher_info_t *cipher_info = cipher_get(ciphername);
+    if (cipher_info == NULL)
+    {
+        return false;
+    }
+    return cipher_info->psa_alg == PSA_ALG_CBC_PKCS7;
 }
 
 bool
 cipher_kt_mode_ofb_cfb(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
-    return cipher
-           && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB
-               || cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
+    const cipher_info_t *cipher_info = cipher_get(ciphername);
+    if (cipher_info == NULL)
+    {
+        return false;
+    }
+    return cipher_info->psa_alg == PSA_ALG_OFB || cipher_info->psa_alg == PSA_ALG_CFB;
 }
 
 bool
 cipher_kt_mode_aead(const char *ciphername)
 {
-    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
-    return cipher
-           && (cipher_kt_mode(cipher) == OPENVPN_MODE_GCM
-#ifdef MBEDTLS_CHACHAPOLY_C
-               || cipher_kt_mode(cipher) == MBEDTLS_MODE_CHACHAPOLY
-#endif
-           );
+    const cipher_info_t *cipher_info = cipher_get(ciphername);
+    if (cipher_info == NULL)
+    {
+        return false;
+    }
+    return cipher_info->psa_alg == PSA_ALG_GCM || cipher_info->psa_alg == PSA_ALG_CHACHA20_POLY1305;
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
+    /* Initializing the object with zeros ensures that it is always safe to call
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
+        ASSERT(psa_aead_abort(&ctx->operation.aead) == PSA_SUCCESS);
+    }
+    else
+    {
+        ASSERT(psa_cipher_abort(&ctx->operation.cipher) == PSA_SUCCESS);
+    }
+    ASSERT(psa_destroy_key(ctx->key) == PSA_SUCCESS);
     free(ctx);
 }
 
 void
-cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, const char *ciphername,
+cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, const char *ciphername,
                 crypto_operation_t enc)
 {
-    ASSERT(NULL != ciphername && NULL != ctx);
+    ASSERT(ciphername != NULL && ctx != NULL);
     CLEAR(*ctx);
 
-    const mbedtls_cipher_info_t *kt = cipher_get(ciphername);
-    ASSERT(kt);
-    size_t key_bitlen = mbedtls_cipher_info_get_key_bitlen(kt);
+    ctx->cipher_info = cipher_get(ciphername);
+    ASSERT(ctx->cipher_info != NULL);
 
-    if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
-    {
-        msg(M_FATAL, "mbed TLS cipher context init #1");
-    }
+    psa_set_key_type(&ctx->key_attributes, ctx->cipher_info->psa_key_type);
+    psa_set_key_algorithm(&ctx->key_attributes, ctx->cipher_info->psa_alg);
+    psa_set_key_bits(&ctx->key_attributes, (size_t)ctx->cipher_info->key_bytes * 8);
+    psa_set_key_usage_flags(&ctx->key_attributes,
+                            enc == OPENVPN_OP_ENCRYPT ? PSA_KEY_USAGE_ENCRYPT : PSA_KEY_USAGE_DECRYPT);
 
-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, enc)))
+    if (psa_import_key(&ctx->key_attributes, key, (size_t)ctx->cipher_info->key_bytes, &ctx->key) != PSA_SUCCESS)
     {
-        msg(M_FATAL, "mbed TLS cipher set key");
-    }
-
-    if (mbedtls_cipher_info_get_mode(kt) == MBEDTLS_MODE_CBC)
-    {
-        if (!mbed_ok(mbedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_PKCS7)))
-        {
-            msg(M_FATAL, "mbed TLS cipher set padding mode");
-        }
+        msg(M_FATAL, "psa_import_key failed");
     }
 
     /* make sure we used a big enough key */
-    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) <= key_bitlen);
+    ASSERT(psa_get_key_bits(&ctx->key_attributes) == (size_t)(8 * ctx->cipher_info->key_bytes));
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
 
-    if (!mbed_ok(mbedtls_cipher_write_tag(ctx, (unsigned char *)tag, tag_len)))
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
-    ASSERT(NULL != ctx);
-
-    return mbedtls_cipher_get_cipher_mode(ctx);
+    ASSERT(ctx != NULL);
+    return (int)psa_get_key_algorithm(&ctx->key_attributes);
 }
 
 bool
 cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
 {
-    return ctx && cipher_ctx_mode(ctx) == OPENVPN_MODE_CBC;
+    return ctx != NULL && cipher_ctx_mode(ctx) == OPENVPN_MODE_CBC;
 }
 
-
 bool
 cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
 {
-    return ctx
-           && (cipher_ctx_mode(ctx) == OPENVPN_MODE_OFB
-               || cipher_ctx_mode(ctx) == OPENVPN_MODE_CFB);
+    if (ctx == NULL)
+    {
+        return false;
+    }
+    int mode = cipher_ctx_mode(ctx);
+    return mode == OPENVPN_MODE_OFB || mode == OPENVPN_MODE_CFB;
 }
 
 bool
 cipher_ctx_mode_aead(const cipher_ctx_t *ctx)
 {
-    return ctx
-           && (cipher_ctx_mode(ctx) == OPENVPN_MODE_GCM
-#ifdef MBEDTLS_CHACHAPOLY_C
-               || cipher_ctx_mode(ctx) == MBEDTLS_MODE_CHACHAPOLY
-#endif
-           );
+    if (ctx == NULL)
+    {
+        return false;
+    }
+    int mode = cipher_ctx_mode(ctx);
+    return mode == (int)PSA_ALG_GCM || mode == (int)PSA_ALG_CHACHA20_POLY1305;
+}
+
+static int
+cipher_ctx_direction(const cipher_ctx_t *ctx)
+{
+    psa_key_usage_t key_usage = psa_get_key_usage_flags(&ctx->key_attributes);
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
+    psa_status_t status = 0;
 
-    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx))))
+    if (cipher_ctx_mode_aead(ctx))
     {
-        return 0;
+        if (psa_aead_abort(&ctx->operation.aead) != PSA_SUCCESS)
+        {
+            return 0;
+        }
+
+        if (cipher_ctx_direction(ctx) == OPENVPN_OP_ENCRYPT)
+        {
+            status = psa_aead_encrypt_setup(&ctx->operation.aead, ctx->key, ctx->cipher_info->psa_alg);
+        }
+        else if (cipher_ctx_direction(ctx) == OPENVPN_OP_DECRYPT)
+        {
+            status = psa_aead_decrypt_setup(&ctx->operation.aead, ctx->key, ctx->cipher_info->psa_alg);
+        }
+        else
+        {
+            return 0;
+        }
+
+        if (status != PSA_SUCCESS)
+        {
+            return 0;
+        }
+
+        status = psa_aead_set_nonce(&ctx->operation.aead, iv_buf, ctx->cipher_info->iv_bytes);
+        if (status != PSA_SUCCESS)
+        {
+            return 0;
+        }
+    }
+    else
+    {
+        if (psa_cipher_abort(&ctx->operation.cipher) != PSA_SUCCESS)
+        {
+            return 0;
+        }
+
+        if (cipher_ctx_direction(ctx) == OPENVPN_OP_ENCRYPT)
+        {
+            status = psa_cipher_encrypt_setup(&ctx->operation.cipher, ctx->key, ctx->cipher_info->psa_alg);
+        }
+        else if (cipher_ctx_direction(ctx) == OPENVPN_OP_DECRYPT)
+        {
+            status = psa_cipher_decrypt_setup(&ctx->operation.cipher, ctx->key, ctx->cipher_info->psa_alg);
+        }
+        else
+        {
+            return 0;
+        }
+
+        if (status != PSA_SUCCESS)
+        {
+            return 0;
+        }
+
+        status = psa_cipher_set_iv(&ctx->operation.cipher, iv_buf, ctx->cipher_info->iv_bytes);
+        if (status != PSA_SUCCESS)
+        {
+            return 0;
+        }
     }
 
     return 1;
 }
 
+/* We rely on the caller to ensure that the destination buffer has enough room,
+ * but Mbed TLS always wants a size for the destination buffer. This function
+ * calculates the minimum necessary size for a given cipher and input length.
+ *
+ * This funcion assumes that src_len has been checked to be >= 0. */
+static size_t
+needed_dst_size(const cipher_ctx_t *ctx, int src_len)
+{
+    int mode = cipher_ctx_mode(ctx);
+    if (mode == PSA_ALG_CTR || mode == PSA_ALG_GCM || mode == PSA_ALG_CHACHA20_POLY1305)
+    {
+        /* These algorithms are based on a keystream, so the input and output
+         * length are always equal. */
+        return (size_t)src_len;
+    }
+    else
+    {
+        /* These algorithms are block-based. The number of output blocks that are
+         * produced is at most 1 + src_len / block_size. */
+        size_t block_size = (size_t)cipher_ctx_block_size(ctx);
+        size_t max_blocks = 1 + (size_t)src_len / block_size;
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
+    if (psa_aead_update_ad(&ctx->operation.aead, src, (size_t)src_len) != PSA_SUCCESS)
     {
         return 0;
     }
+    return 1;
+}
+
+int
+cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len)
+{
+    if (src_len < 0)
+    {
+        return 0;
+    }
+
+    size_t dst_size = needed_dst_size(ctx, src_len);
+    size_t psa_output_len = 0;
+    psa_status_t status = 0;
+
+    if (cipher_ctx_mode_aead(ctx))
+    {
+        status = psa_aead_update(&ctx->operation.aead, src, (size_t)src_len, dst, dst_size, &psa_output_len);
+    }
+    else
+    {
+        status = psa_cipher_update(&ctx->operation.cipher, src, (size_t)src_len, dst, dst_size, &psa_output_len);
+    }
+
+    if (status != PSA_SUCCESS)
+    {
+        return 0;
+    }
+
+    if (psa_output_len > INT_MAX)
+    {
+        return 0;
+    }
+    *dst_len = (int)psa_output_len;
 
     return 1;
 }
 
 int
-cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src,
-                  int src_len)
+cipher_ctx_final(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len)
 {
-    size_t s_dst_len = *dst_len;
+    size_t dst_size = needed_dst_size(ctx, 0);
+    size_t psa_output_len = 0;
+    psa_status_t status = 0;
 
-    if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t)src_len, dst, &s_dst_len)))
+    if (cipher_ctx_mode_aead(ctx))
     {
-        return 0;
+        size_t actual_tag_size = 0;
+        status = psa_aead_finish(&ctx->operation.aead,
+                                 dst,
+                                 dst_size,
+                                 &psa_output_len,
+                                 ctx->tag,
+                                 (size_t)OPENVPN_AEAD_TAG_LENGTH,
+                                 &actual_tag_size);
+        if (status != PSA_SUCCESS || psa_output_len > (size_t)INT_MAX || actual_tag_size != (size_t)OPENVPN_AEAD_TAG_LENGTH)
+        {
+            return 0;
+        }
+        ctx->aead_finished = true;
+    }
+    else
+    {
+        status = psa_cipher_finish(&ctx->operation.cipher, dst, dst_size, &psa_output_len);
+        if (status != PSA_SUCCESS || psa_output_len > (size_t)INT_MAX)
+        {
+            return 0;
+        }
     }
 
-    *dst_len = s_dst_len;
+    *dst_len = (int)psa_output_len;
 
     return 1;
 }
 
 int
-cipher_ctx_final(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len)
+cipher_ctx_final_check_tag(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *tag, size_t tag_len)
 {
-    size_t s_dst_len = *dst_len;
-
-    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &s_dst_len)))
+    if (cipher_ctx_direction(ctx) != OPENVPN_OP_DECRYPT || !cipher_ctx_mode_aead(ctx))
     {
         return 0;
     }
 
-    *dst_len = s_dst_len;
+    size_t psa_output_len = 0;
+    psa_status_t status = 0;
+
+    status = psa_aead_verify(&ctx->operation.aead, dst, 0, &psa_output_len, tag, tag_len);
+    if (status != PSA_SUCCESS || psa_output_len > (size_t)INT_MAX)
+    {
+        return 0;
+    }
+    *dst_len = (int)psa_output_len;
 
     return 1;
 }
 
-int
-cipher_ctx_final_check_tag(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, uint8_t *tag,
-                           size_t tag_len)
+static const md_info_t md_info_table[] = {
+    /* TODO: Fill out table. */
+    { "MD5", PSA_ALG_MD5 },
+    { "SHA1", PSA_ALG_SHA_1 },
+    { "SHA256", PSA_ALG_SHA_256 },
+};
+const size_t md_info_table_entries = sizeof(md_info_table) / sizeof(md_info_t);
+
+static const md_info_t *
+md_get(const char *digest_name)
 {
-    size_t olen = 0;
-
-    if (MBEDTLS_DECRYPT != mbedtls_cipher_get_operation(ctx))
+    for (size_t i = 0; i < md_info_table_entries; i++)
     {
-        return 0;
+        if (strcmp(digest_name, md_info_table[i].name) == 0)
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
-    *dst_len = olen;
-
-    if (!mbed_ok(mbedtls_cipher_check_tag(ctx, (const unsigned char *)tag, tag_len)))
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
-    const mbedtls_md_info_t *md = NULL;
-    ASSERT(digest);
-
-    md = mbedtls_md_info_from_string(digest);
-    if (!md)
-    {
-        msg(M_FATAL, "Message hash algorithm '%s' not found", digest);
-    }
-    if (mbedtls_md_get_size(md) > MAX_HMAC_KEY_LENGTH)
-    {
-        msg(M_FATAL,
-            "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME
-            "'s current maximum hash size (%d bytes)",
-            digest, mbedtls_md_get_size(md), MAX_HMAC_KEY_LENGTH);
-    }
-    return md;
+    return NULL;
 }
 
 bool
 md_valid(const char *digest)
 {
-    const mbedtls_md_info_t *md = mbedtls_md_info_from_string(digest);
+    const md_info_t *md = md_get(digest);
     return md != NULL;
 }
 
 const char *
 md_kt_name(const char *mdname)
 {
-    if (!strcmp("none", mdname))
+    if (strcmp("none", mdname) == 0)
     {
         return "[null-digest]";
     }
-    const mbedtls_md_info_t *kt = md_get(mdname);
-    return mbedtls_md_get_name(kt);
+    const md_info_t *md = md_get(mdname);
+    if (md == NULL)
+    {
+        return NULL;
+    }
+    return md->name;
 }
 
 unsigned char
 md_kt_size(const char *mdname)
 {
-    if (!strcmp("none", mdname))
+    if (strcmp("none", mdname) == 0)
     {
         return 0;
     }
-    const mbedtls_md_info_t *kt = md_get(mdname);
-    return mbedtls_md_get_size(kt);
+    const md_info_t *md_info = md_get(mdname);
+    if (md_info == NULL)
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
-    const mbedtls_md_info_t *kt = md_get(mdname);
-    return 0 == mbedtls_md(kt, src, src_len, dst);
-}
+    const md_info_t *md = md_get(mdname);
+    if (md == NULL || src_len < 0)
+    {
+        return 0;
+    }
 
-mbedtls_md_context_t *
-md_ctx_new(void)
-{
-    mbedtls_md_context_t *ctx;
-    ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);
-    return ctx;
+    /* We depend on the caller to ensure that dst has enough room for the hash,
+     * so we just tell PSA that it can hold the appropriate amount of bytes. */
+    size_t dst_size = PSA_HASH_LENGTH(md->psa_alg);
+    size_t hash_length = 0;
+
+    psa_status_t status = psa_hash_compute(md->psa_alg, src, (size_t)src_len, dst, dst_size, &hash_length);
+    if (status != PSA_SUCCESS || hash_length != dst_size)
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
-    const mbedtls_md_info_t *kt = md_get(mdname);
-    ASSERT(NULL != ctx && NULL != kt);
+    const md_info_t *md_info = md_get(mdname);
+    ASSERT(ctx != NULL && md_info != NULL);
 
-    mbedtls_md_init(ctx);
-    ASSERT(0 == mbedtls_md_setup(ctx, kt, 0));
-    ASSERT(0 == mbedtls_md_starts(ctx));
+    ctx->md_info = md_info;
+    ASSERT(psa_hash_setup(&ctx->operation, md_info->psa_alg) == PSA_SUCCESS);
 }
 
 void
-md_ctx_cleanup(mbedtls_md_context_t *ctx)
+md_ctx_cleanup(md_ctx_t *ctx)
 {
-    mbedtls_md_free(ctx);
+    ASSERT(psa_hash_abort(&ctx->operation) == PSA_SUCCESS);
 }
 
 int
-md_ctx_size(const mbedtls_md_context_t *ctx)
+md_ctx_size(const md_ctx_t *ctx)
 {
-    if (NULL == ctx)
+    if (ctx == NULL)
     {
         return 0;
     }
-    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
+    return (int)PSA_HASH_LENGTH(ctx->md_info->psa_alg);
 }
 
 void
-md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_len)
+md_ctx_update(md_ctx_t *ctx, const uint8_t *src, size_t src_len)
 {
-    ASSERT(0 == mbedtls_md_update(ctx, src, src_len));
+    ASSERT(psa_hash_update(&ctx->operation, src, src_len) == PSA_SUCCESS);
 }
 
 void
-md_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
+md_ctx_final(md_ctx_t *ctx, uint8_t *dst)
 {
-    ASSERT(0 == mbedtls_md_finish(ctx, dst));
-    mbedtls_md_free(ctx);
+    /* We depend on the caller to ensure that dst has enough room for the hash,
+     * so we just tell PSA that it can hold the appropriate amount of bytes. */
+    size_t dst_size = PSA_HASH_LENGTH(ctx->md_info->psa_alg);
+    size_t hash_length = 0;
+
+    ASSERT(psa_hash_finish(&ctx->operation, dst, dst_size, &hash_length) == PSA_SUCCESS);
+    ASSERT(hash_length == dst_size);
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
-hmac_ctx_init(mbedtls_md_context_t *ctx, const uint8_t *key, const char *mdname)
+static void
+hmac_ctx_init_with_arbitrary_key_length(hmac_ctx_t *ctx, const uint8_t *key, size_t key_len, const md_info_t *md_info)
 {
-    const mbedtls_md_info_t *kt = md_get(mdname);
-    ASSERT(NULL != kt && NULL != ctx);
+    ctx->md_info = md_info;
+    psa_set_key_type(&ctx->key_attributes, PSA_KEY_TYPE_HMAC);
+    psa_set_key_algorithm(&ctx->key_attributes, PSA_ALG_HMAC(md_info->psa_alg));
+    psa_set_key_usage_flags(&ctx->key_attributes, PSA_KEY_USAGE_SIGN_MESSAGE);
 
-    mbedtls_md_init(ctx);
-    int key_len = mbedtls_md_get_size(kt);
-    ASSERT(0 == mbedtls_md_setup(ctx, kt, 1));
-    ASSERT(0 == mbedtls_md_hmac_starts(ctx, key, key_len));
+    if (psa_import_key(&ctx->key_attributes, key, key_len, &ctx->key) != PSA_SUCCESS)
+    {
+        msg(M_FATAL, "psa_import_key failed");
+    }
 
-    /* make sure we used a big enough key */
-    ASSERT(mbedtls_md_get_size(kt) <= key_len);
+    ASSERT(psa_mac_sign_setup(&ctx->operation, ctx->key, PSA_ALG_HMAC(md_info->psa_alg)) == PSA_SUCCESS);
 }
 
 void
-hmac_ctx_cleanup(mbedtls_md_context_t *ctx)
+hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, const char *mdname)
 {
-    mbedtls_md_free(ctx);
+    const md_info_t *md_info = md_get(mdname);
+    ASSERT(ctx != NULL && key != NULL && md_info != NULL);
+
+    hmac_ctx_init_with_arbitrary_key_length(ctx, key, PSA_HASH_LENGTH(md_info->psa_alg), md_info);
+}
+
+void
+hmac_ctx_cleanup(hmac_ctx_t *ctx)
+{
+    ASSERT(psa_mac_abort(&ctx->operation) == PSA_SUCCESS);
+    ASSERT(psa_destroy_key(ctx->key) == PSA_SUCCESS);
 }
 
 int
-hmac_ctx_size(mbedtls_md_context_t *ctx)
+hmac_ctx_size(hmac_ctx_t *ctx)
 {
-    if (NULL == ctx)
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
-    ASSERT(0 == mbedtls_md_hmac_reset(ctx));
+    ASSERT(psa_mac_abort(&ctx->operation) == PSA_SUCCESS);
+    ASSERT(psa_mac_sign_setup(&ctx->operation, ctx->key, PSA_ALG_HMAC(ctx->md_info->psa_alg)) == PSA_SUCCESS);
 }
 
 void
-hmac_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
+hmac_ctx_update(hmac_ctx_t *ctx, const uint8_t *src, int src_len)
 {
-    ASSERT(0 == mbedtls_md_hmac_update(ctx, src, src_len));
+    ASSERT(src_len >= 0);
+    ASSERT(psa_mac_update(&ctx->operation, src, (size_t)src_len) == PSA_SUCCESS);
 }
 
 void
-hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
+hmac_ctx_final(hmac_ctx_t *ctx, uint8_t *dst)
 {
-    ASSERT(0 == mbedtls_md_hmac_finish(ctx, dst));
+    /* We depend on the caller to ensure that dst has enough room for the hash,
+     * so we just tell PSA that it can hold the appropriate amount of bytes. */
+    size_t dst_size = PSA_HASH_LENGTH(ctx->md_info->psa_alg);
+    size_t hmac_length = 0;
+
+    ASSERT(psa_mac_sign_finish(&ctx->operation, dst, dst_size, &hmac_length) == PSA_SUCCESS);
+    ASSERT(hmac_length == dst_size);
 }
 
-int
-memcmp_constant_time(const void *a, const void *b, size_t size)
-{
-    /* mbed TLS has a no const time memcmp function that it exposes
-     * via its APIs like OpenSSL does with CRYPTO_memcmp
-     * Adapt the function that mbedtls itself uses in
-     * mbedtls_safer_memcmp as it considers that to be safe */
-    volatile const unsigned char *A = (volatile const unsigned char *)a;
-    volatile const unsigned char *B = (volatile const unsigned char *)b;
-    volatile unsigned char diff = 0;
-
-    for (size_t i = 0; i < size; i++)
-    {
-        unsigned char x = A[i], y = B[i];
-        diff |= x ^ y;
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
-tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, size_t sec_len, const uint8_t *seed,
-            size_t seed_len, uint8_t *out, size_t olen)
+tls1_P_hash(const md_info_t *md_info, const uint8_t *sec, size_t sec_len, const uint8_t *seed,
+            int seed_len, uint8_t *out, size_t olen)
 {
     struct gc_arena gc = gc_new();
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
@@ -1023,18 +851,13 @@
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len, 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_len, 0, &gc));
 
-    unsigned int chunk = mbedtls_md_get_size(md_kt);
-    unsigned int A1_len = mbedtls_md_get_size(md_kt);
+    unsigned int chunk = (unsigned int)PSA_HASH_LENGTH(md_info->psa_alg);
+    unsigned int A1_len = (unsigned int)PSA_HASH_LENGTH(md_info->psa_alg);
 
     /* This is the only place where we init an HMAC with a key that is not
      * equal to its size, therefore we init the hmac ctx manually here */
-    mbedtls_md_init(ctx);
-    ASSERT(0 == mbedtls_md_setup(ctx, md_kt, 1));
-    ASSERT(0 == mbedtls_md_hmac_starts(ctx, sec, sec_len));
-
-    mbedtls_md_init(ctx_tmp);
-    ASSERT(0 == mbedtls_md_setup(ctx_tmp, md_kt, 1));
-    ASSERT(0 == mbedtls_md_hmac_starts(ctx_tmp, sec, sec_len));
+    hmac_ctx_init_with_arbitrary_key_length(ctx, sec, sec_len, md_info);
+    hmac_ctx_init_with_arbitrary_key_length(ctx_tmp, sec, sec_len, md_info);
 
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
 ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, size_t slen, uint8_t *out1,
              size_t olen)
 {
+    const md_info_t *md5 = md_get("MD5");
+    const md_info_t *sha1 = md_get("SHA1");
+
+    if (label_len > (size_t)INT_MAX)
+    {
+        return false;
+    }
+
     struct gc_arena gc = gc_new();
-    const md_kt_t *md5 = md_get("MD5");
-    const md_kt_t *sha1 = md_get("SHA1");
 
     uint8_t *out2 = (uint8_t *)gc_malloc(olen, false, &gc);
 
@@ -1105,8 +934,8 @@
     const uint8_t *S2 = &(sec[len]);
     len += (slen & 1); /* add for odd, make longer */
 
-    tls1_P_hash(md5, S1, len, label, label_len, out1, olen);
-    tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);
+    tls1_P_hash(md5, S1, len, label, (int)label_len, out1, olen);
+    tls1_P_hash(sha1, S2, len, label, (int)label_len, out2, olen);
 
     for (size_t i = 0; i < olen; i++)
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
+    if (0 != errval)
+    {
+        char errstr[256];
+        mbedtls_strerror(errval, errstr, sizeof(errstr));
+
+        if (NULL == prefix)
+        {
+            prefix = "mbed TLS error";
+        }
+        msg(flags, "%s: %s", prefix, errstr);
+    }
+
+    return 0 == errval;
+}
+
+bool
+mbed_log_func_line(unsigned int flags, int errval, const char *func, int line)
+{
+    char prefix[256];
+
+    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >= sizeof(prefix))
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
+           "with " PACKAGE_NAME ".  Each cipher shown below may be used as a\n"
+           "parameter to the --data-ciphers (or --cipher) option.  Using a\n"
+           "GCM or CBC mode is recommended.  In static key mode only CBC\n"
+           "mode is allowed.\n\n");
 #endif
 
-#endif /* ENABLE_CRYPTO_MBEDTLS */
+    for (size_t i = 0; i < cipher_info_table_entries; i++)
+    {
+        const cipher_info_t *info = &cipher_info_table[i];
+        const char *name = info->name;
+        if (!cipher_kt_insecure(name) && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
+        {
+            print_cipher(name);
+        }
+    }
+
+    printf("\nThe following ciphers have a block size of less than 128 bits, \n"
+           "and are therefore deprecated.  Do not use unless you have to.\n\n");
+    for (size_t i = 0; i < cipher_info_table_entries; i++)
+    {
+        const cipher_info_t *info = &cipher_info_table[i];
+        const char *name = info->name;
+        if (cipher_kt_insecure(name) && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
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
+     * message digests. We instead print out the digests from md_info_table. */
+
+#ifndef ENABLE_SMALL
+    printf("The following message digests are available for use with\n" PACKAGE_NAME
+           ".  A message digest is used in conjunction with\n"
+           "the HMAC function, to authenticate received packets.\n"
+           "You can specify a message digest as parameter to\n"
+           "the --auth option.\n\n");
+#endif
+
+    for (size_t i = 0; i < md_info_table_entries; i++)
+    {
+        const md_info_t *info = &md_info_table[i];
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
+crypto_pem_encode(const char *name, struct buffer *dst, const struct buffer *src,
+                  struct gc_arena *gc)
+{
+    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
+    char header[1000 + 1] = { 0 };
+    char footer[1000 + 1] = { 0 };
+
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >= sizeof(header))
+    {
+        return false;
+    }
+    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >= sizeof(footer))
+    {
+        return false;
+    }
+
+    size_t out_len = 0;
+    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
+        != mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), NULL, 0, &out_len))
+    {
+        return false;
+    }
+
+    /* We set the size buf to out_len-1 to NOT include the 0 byte that
+     * mbedtls_pem_write_buffer in its length calculation */
+    *dst = alloc_buf_gc(out_len, gc);
+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), BPTR(dst),
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
+crypto_pem_decode(const char *name, struct buffer *dst, const struct buffer *src)
+{
+    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
+    char header[1000 + 1] = { 0 };
+    char footer[1000 + 1] = { 0 };
+
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >= sizeof(header))
+    {
+        return false;
+    }
+    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >= sizeof(footer))
+    {
+        return false;
+    }
+
+    /* mbed TLS requires the src to be null-terminated */
+    /* allocate a new buffer to avoid modifying the src buffer */
+    struct gc_arena gc = gc_new();
+    struct buffer input = alloc_buf_gc(BLEN(src) + 1, &gc);
+    buf_copy(&input, src);
+    buf_null_terminate(&input);
+
+    size_t use_len = 0;
+    mbedtls_pem_context ctx = { 0 };
+    bool ret =
+        mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(&input), NULL, 0, &use_len));
+    size_t buf_size = 0;
+    const unsigned char *buf = mbedtls_pem_get_buffer(&ctx, &buf_size);
+    if (ret && !buf_write(dst, buf, buf_size))
+    {
+        ret = false;
+        msg(M_WARN, "PEM decode error: destination buffer too small");
+    }
+
+    mbedtls_pem_free(&ctx);
+    gc_free(&gc);
+    return ret;
+}
+
+#endif /* MBEDTLS_VERSION_NUMBER >= 0x04000000 */
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
+ * Data Channel Cryptography backend interface using the TF-PSA-Crypto library
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
- * For PolarSSL/mbed TLS 1.1+, this is the CTR_DRBG random number generator. If it
- * hasn't been initialised yet, the RNG will be initialised using the default
- * entropy sources. Aside from the default platform entropy sources, an
- * additional entropy source, the HAVEGE random number generator will also be
- * added. During initialisation, a personalisation string will be added based
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
  * Log the supplied mbed TLS error, prefixed by function name and line number.
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
 #define mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
 
-#endif /* CRYPTO_MBEDTLS_H_ */
+#endif /* CRYPTO_MBEDTLS4_H_ */
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c
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
+    msg(M_WARN, "Note: mbed TLS hardware crypto engine functionality is not "
+                "available");
+}
+
+provider_t *
+crypto_load_provider(const char *provider)
+{
+    if (provider)
+    {
+        msg(M_WARN, "Note: mbed TLS provider functionality is not available");
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
+    if (0 != errval)
+    {
+        char errstr[256];
+        mbedtls_strerror(errval, errstr, sizeof(errstr));
+
+        if (NULL == prefix)
+        {
+            prefix = "mbed TLS error";
+        }
+        msg(flags, "%s: %s", prefix, errstr);
+    }
+
+    return 0 == errval;
+}
+
+bool
+mbed_log_func_line(unsigned int flags, int errval, const char *func, int line)
+{
+    char prefix[256];
+
+    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >= sizeof(prefix))
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
+const cipher_name_pair cipher_name_translation_table[] = {
+    { "BF-CBC", "BLOWFISH-CBC" },
+    { "BF-CFB", "BLOWFISH-CFB64" },
+    { "CAMELLIA-128-CFB", "CAMELLIA-128-CFB128" },
+    { "CAMELLIA-192-CFB", "CAMELLIA-192-CFB128" },
+    { "CAMELLIA-256-CFB", "CAMELLIA-256-CFB128" }
+};
+const size_t cipher_name_translation_table_count =
+    sizeof(cipher_name_translation_table) / sizeof(*cipher_name_translation_table);
+
+void
+show_available_ciphers(void)
+{
+    const int *ciphers = mbedtls_cipher_list();
+
+#ifndef ENABLE_SMALL
+    printf("The following ciphers and cipher modes are available for use\n"
+           "with " PACKAGE_NAME ".  Each cipher shown below may be used as a\n"
+           "parameter to the --data-ciphers (or --cipher) option.  Using a\n"
+           "GCM or CBC mode is recommended.  In static key mode only CBC\n"
+           "mode is allowed.\n\n");
+#endif
+
+    while (*ciphers != 0)
+    {
+        const mbedtls_cipher_info_t *info = mbedtls_cipher_info_from_type(*ciphers);
+        const char *name = mbedtls_cipher_info_get_name(info);
+        if (info && name && !cipher_kt_insecure(name)
+            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
+        {
+            print_cipher(name);
+        }
+        ciphers++;
+    }
+
+    printf("\nThe following ciphers have a block size of less than 128 bits, \n"
+           "and are therefore deprecated.  Do not use unless you have to.\n\n");
+    ciphers = mbedtls_cipher_list();
+    while (*ciphers != 0)
+    {
+        const mbedtls_cipher_info_t *info = mbedtls_cipher_info_from_type(*ciphers);
+        const char *name = mbedtls_cipher_info_get_name(info);
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
+    const int *digests = mbedtls_md_list();
+
+#ifndef ENABLE_SMALL
+    printf("The following message digests are available for use with\n" PACKAGE_NAME
+           ".  A message digest is used in conjunction with\n"
+           "the HMAC function, to authenticate received packets.\n"
+           "You can specify a message digest as parameter to\n"
+           "the --auth option.\n\n");
+#endif
+
+    while (*digests != 0)
+    {
+        const mbedtls_md_info_t *info = mbedtls_md_info_from_type(*digests);
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
+crypto_pem_encode(const char *name, struct buffer *dst, const struct buffer *src,
+                  struct gc_arena *gc)
+{
+    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
+    char header[1000 + 1] = { 0 };
+    char footer[1000 + 1] = { 0 };
+
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >= sizeof(header))
+    {
+        return false;
+    }
+    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >= sizeof(footer))
+    {
+        return false;
+    }
+
+    size_t out_len = 0;
+    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
+        != mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), NULL, 0, &out_len))
+    {
+        return false;
+    }
+
+    /* We set the size buf to out_len-1 to NOT include the 0 byte that
+     * mbedtls_pem_write_buffer in its length calculation */
+    *dst = alloc_buf_gc(out_len, gc);
+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), BPTR(dst),
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
+crypto_pem_decode(const char *name, struct buffer *dst, const struct buffer *src)
+{
+    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
+    char header[1000 + 1] = { 0 };
+    char footer[1000 + 1] = { 0 };
+
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >= sizeof(header))
+    {
+        return false;
+    }
+    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >= sizeof(footer))
+    {
+        return false;
+    }
+
+    /* mbed TLS requires the src to be null-terminated */
+    /* allocate a new buffer to avoid modifying the src buffer */
+    struct gc_arena gc = gc_new();
+    struct buffer input = alloc_buf_gc(BLEN(src) + 1, &gc);
+    buf_copy(&input, src);
+    buf_null_terminate(&input);
+
+    size_t use_len = 0;
+    mbedtls_pem_context ctx = { 0 };
+    bool ret =
+        mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(&input), NULL, 0, &use_len));
+    size_t buf_size = 0;
+    const unsigned char *buf = mbedtls_pem_get_buffer(&ctx, &buf_size);
+    if (ret && !buf_write(dst, buf, buf_size))
+    {
+        ret = false;
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
+ * Initialise the given ctr_drbg context, using a personalisation string and an
+ * entropy gathering function.
+ */
+mbedtls_ctr_drbg_context *
+rand_ctx_get(void)
+{
+    static mbedtls_entropy_context ec = { 0 };
+    static mbedtls_ctr_drbg_context cd_ctx = { 0 };
+    static bool rand_initialised = false;
+
+    if (!rand_initialised)
+    {
+        struct gc_arena gc = gc_new();
+        struct buffer pers_string = alloc_buf_gc(100, &gc);
+
+        /*
+         * Personalisation string, should be as unique as possible (see NIST
+         * 800-90 section 8.7.1). We have very little information at this stage.
+         * Include Program Name, memory address of the context and PID.
+         */
+        buf_printf(&pers_string, "OpenVPN %0u %p %s", platform_getpid(), &cd_ctx,
+                   time_string(0, 0, 0, &gc));
+
+        /* Initialise mbed TLS RNG, and built-in entropy sources */
+        mbedtls_entropy_init(&ec);
+
+        mbedtls_ctr_drbg_init(&cd_ctx);
+        if (!mbed_ok(mbedtls_ctr_drbg_seed(&cd_ctx, mbedtls_entropy_func, &ec, BPTR(&pers_string),
+                                           BLEN(&pers_string))))
+        {
+            msg(M_FATAL, "Failed to initialize random generator");
+        }
+
+        gc_free(&gc);
+        rand_initialised = true;
+    }
+
+    return &cd_ctx;
+}
+
+#ifdef ENABLE_PREDICTION_RESISTANCE
+void
+rand_ctx_enable_prediction_resistance(void)
+{
+    mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
+
+    mbedtls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);
+}
+#endif /* ENABLE_PREDICTION_RESISTANCE */
+
+int
+rand_bytes(uint8_t *output, int len)
+{
+    mbedtls_ctr_drbg_context *rng_ctx = rand_ctx_get();
+
+    while (len > 0)
+    {
+        const size_t blen = min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
+        if (0 != mbedtls_ctr_drbg_random(rng_ctx, output, blen))
+        {
+            return 0;
+        }
+
+        output += blen;
+        len -= blen;
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
+    const mbedtls_cipher_info_t *cipher = NULL;
+
+    ciphername = translate_cipher_name_from_openvpn(ciphername);
+    cipher = mbedtls_cipher_info_from_string(ciphername);
+    return cipher;
+}
+
+bool
+cipher_valid_reason(const char *ciphername, const char **reason)
+{
+    ASSERT(reason);
+
+    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
+
+    if (NULL == cipher)
+    {
+        msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
+        *reason = "disabled because unknown";
+        return false;
+    }
+
+    const size_t key_bytelen = mbedtls_cipher_info_get_key_bitlen(cipher) / 8;
+    if (key_bytelen > MAX_CIPHER_KEY_LENGTH)
+    {
+        msg(D_LOW,
+            "Cipher algorithm '%s' uses a default key size (%zu bytes) "
+            "which is larger than " PACKAGE_NAME "'s current maximum key size "
+            "(%d bytes)",
+            ciphername, key_bytelen, MAX_CIPHER_KEY_LENGTH);
+        *reason = "disabled due to key size too large";
+        return false;
+    }
+
+    *reason = NULL;
+    return true;
+}
+
+const char *
+cipher_kt_name(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
+    if (NULL == cipher_kt)
+    {
+        return "[null-cipher]";
+    }
+
+    return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(cipher_kt));
+}
+
+int
+cipher_kt_key_size(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
+
+    if (NULL == cipher_kt)
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
+    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
+
+    if (NULL == cipher_kt)
+    {
+        return 0;
+    }
+    return (int)mbedtls_cipher_info_get_iv_size(cipher_kt);
+}
+
+int
+cipher_kt_block_size(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
+    if (NULL == cipher_kt)
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
+    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
+    if (!cipher_kt)
+    {
+        return true;
+    }
+
+    return !(cipher_kt_block_size(ciphername) >= 128 / 8
+#ifdef MBEDTLS_CHACHAPOLY_C
+             || mbedtls_cipher_info_get_type(cipher_kt) == MBEDTLS_CIPHER_CHACHA20_POLY1305
+#endif
+    );
+}
+
+static mbedtls_cipher_mode_t
+cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
+{
+    ASSERT(NULL != cipher_kt);
+    return mbedtls_cipher_info_get_mode(cipher_kt);
+}
+
+bool
+cipher_kt_mode_cbc(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
+    return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC;
+}
+
+bool
+cipher_kt_mode_ofb_cfb(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
+    return cipher
+           && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB
+               || cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
+}
+
+bool
+cipher_kt_mode_aead(const char *ciphername)
+{
+    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
+    return cipher
+           && (cipher_kt_mode(cipher) == OPENVPN_MODE_GCM
+#ifdef MBEDTLS_CHACHAPOLY_C
+               || cipher_kt_mode(cipher) == MBEDTLS_MODE_CHACHAPOLY
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
+cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, const char *ciphername,
+                crypto_operation_t enc)
+{
+    ASSERT(NULL != ciphername && NULL != ctx);
+    CLEAR(*ctx);
+
+    const mbedtls_cipher_info_t *kt = cipher_get(ciphername);
+    ASSERT(kt);
+    size_t key_bitlen = mbedtls_cipher_info_get_key_bitlen(kt);
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
+    if (mbedtls_cipher_info_get_mode(kt) == MBEDTLS_MODE_CBC)
+    {
+        if (!mbed_ok(mbedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_PKCS7)))
+        {
+            msg(M_FATAL, "mbed TLS cipher set padding mode");
+        }
+    }
+
+    /* make sure we used a big enough key */
+    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) <= key_bitlen);
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
+    if (!mbed_ok(mbedtls_cipher_write_tag(ctx, (unsigned char *)tag, tag_len)))
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
+    ASSERT(NULL != ctx);
+
+    return mbedtls_cipher_get_cipher_mode(ctx);
+}
+
+bool
+cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
+{
+    return ctx && cipher_ctx_mode(ctx) == OPENVPN_MODE_CBC;
+}
+
+
+bool
+cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
+{
+    return ctx
+           && (cipher_ctx_mode(ctx) == OPENVPN_MODE_OFB
+               || cipher_ctx_mode(ctx) == OPENVPN_MODE_CFB);
+}
+
+bool
+cipher_ctx_mode_aead(const cipher_ctx_t *ctx)
+{
+    return ctx
+           && (cipher_ctx_mode(ctx) == OPENVPN_MODE_GCM
+#ifdef MBEDTLS_CHACHAPOLY_C
+               || cipher_ctx_mode(ctx) == MBEDTLS_MODE_CHACHAPOLY
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
+    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx))))
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
+cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src,
+                  int src_len)
+{
+    size_t s_dst_len = *dst_len;
+
+    if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t)src_len, dst, &s_dst_len)))
+    {
+        return 0;
+    }
+
+    *dst_len = s_dst_len;
+
+    return 1;
+}
+
+int
+cipher_ctx_final(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len)
+{
+    size_t s_dst_len = *dst_len;
+
+    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &s_dst_len)))
+    {
+        return 0;
+    }
+
+    *dst_len = s_dst_len;
+
+    return 1;
+}
+
+int
+cipher_ctx_final_check_tag(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, uint8_t *tag,
+                           size_t tag_len)
+{
+    size_t olen = 0;
+
+    if (MBEDTLS_DECRYPT != mbedtls_cipher_get_operation(ctx))
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
+    *dst_len = olen;
+
+    if (!mbed_ok(mbedtls_cipher_check_tag(ctx, (const unsigned char *)tag, tag_len)))
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
+    const mbedtls_md_info_t *md = NULL;
+    ASSERT(digest);
+
+    md = mbedtls_md_info_from_string(digest);
+    if (!md)
+    {
+        msg(M_FATAL, "Message hash algorithm '%s' not found", digest);
+    }
+    if (mbedtls_md_get_size(md) > MAX_HMAC_KEY_LENGTH)
+    {
+        msg(M_FATAL,
+            "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME
+            "'s current maximum hash size (%d bytes)",
+            digest, mbedtls_md_get_size(md), MAX_HMAC_KEY_LENGTH);
+    }
+    return md;
+}
+
+bool
+md_valid(const char *digest)
+{
+    const mbedtls_md_info_t *md = mbedtls_md_info_from_string(digest);
+    return md != NULL;
+}
+
+const char *
+md_kt_name(const char *mdname)
+{
+    if (!strcmp("none", mdname))
+    {
+        return "[null-digest]";
+    }
+    const mbedtls_md_info_t *kt = md_get(mdname);
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
+    const mbedtls_md_info_t *kt = md_get(mdname);
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
+    const mbedtls_md_info_t *kt = md_get(mdname);
+    return 0 == mbedtls_md(kt, src, src_len, dst);
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
+    const mbedtls_md_info_t *kt = md_get(mdname);
+    ASSERT(NULL != ctx && NULL != kt);
+
+    mbedtls_md_init(ctx);
+    ASSERT(0 == mbedtls_md_setup(ctx, kt, 0));
+    ASSERT(0 == mbedtls_md_starts(ctx));
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
+    if (NULL == ctx)
+    {
+        return 0;
+    }
+    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
+}
+
+void
+md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_len)
+{
+    ASSERT(0 == mbedtls_md_update(ctx, src, src_len));
+}
+
+void
+md_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
+{
+    ASSERT(0 == mbedtls_md_finish(ctx, dst));
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
+hmac_ctx_init(mbedtls_md_context_t *ctx, const uint8_t *key, const char *mdname)
+{
+    const mbedtls_md_info_t *kt = md_get(mdname);
+    ASSERT(NULL != kt && NULL != ctx);
+
+    mbedtls_md_init(ctx);
+    int key_len = mbedtls_md_get_size(kt);
+    ASSERT(0 == mbedtls_md_setup(ctx, kt, 1));
+    ASSERT(0 == mbedtls_md_hmac_starts(ctx, key, key_len));
+
+    /* make sure we used a big enough key */
+    ASSERT(mbedtls_md_get_size(kt) <= key_len);
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
+    if (NULL == ctx)
+    {
+        return 0;
+    }
+    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
+}
+
+void
+hmac_ctx_reset(mbedtls_md_context_t *ctx)
+{
+    ASSERT(0 == mbedtls_md_hmac_reset(ctx));
+}
+
+void
+hmac_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
+{
+    ASSERT(0 == mbedtls_md_hmac_update(ctx, src, src_len));
+}
+
+void
+hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
+{
+    ASSERT(0 == mbedtls_md_hmac_finish(ctx, dst));
+}
+
+int
+memcmp_constant_time(const void *a, const void *b, size_t size)
+{
+    /* mbed TLS has a no const time memcmp function that it exposes
+     * via its APIs like OpenSSL does with CRYPTO_memcmp
+     * Adapt the function that mbedtls itself uses in
+     * mbedtls_safer_memcmp as it considers that to be safe */
+    volatile const unsigned char *A = (volatile const unsigned char *)a;
+    volatile const unsigned char *B = (volatile const unsigned char *)b;
+    volatile unsigned char diff = 0;
+
+    for (size_t i = 0; i < size; i++)
+    {
+        unsigned char x = A[i], y = B[i];
+        diff |= x ^ y;
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
+tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, size_t sec_len, const uint8_t *seed,
+            size_t seed_len, uint8_t *out, size_t olen)
+{
+    struct gc_arena gc = gc_new();
+    uint8_t A1[MAX_HMAC_KEY_LENGTH];
+
+#ifdef ENABLE_DEBUG
+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused
+     * variables warnings if compiled with --enable-small */
+    const size_t olen_orig = olen;
+    const uint8_t *out_orig = out;
+#endif
+
+    hmac_ctx_t *ctx = hmac_ctx_new();
+    hmac_ctx_t *ctx_tmp = hmac_ctx_new();
+
+    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len, 0, &gc));
+    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_len, 0, &gc));
+
+    unsigned int chunk = mbedtls_md_get_size(md_kt);
+    unsigned int A1_len = mbedtls_md_get_size(md_kt);
+
+    /* This is the only place where we init an HMAC with a key that is not
+     * equal to its size, therefore we init the hmac ctx manually here */
+    mbedtls_md_init(ctx);
+    ASSERT(0 == mbedtls_md_setup(ctx, md_kt, 1));
+    ASSERT(0 == mbedtls_md_hmac_starts(ctx, sec, sec_len));
+
+    mbedtls_md_init(ctx_tmp);
+    ASSERT(0 == mbedtls_md_setup(ctx_tmp, md_kt, 1));
+    ASSERT(0 == mbedtls_md_hmac_starts(ctx_tmp, sec, sec_len));
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
+            out += chunk;
+            olen -= chunk;
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
+    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash out: %s", format_hex(out_orig, olen_orig, 0, &gc));
+    gc_free(&gc);
+}
+
+/*
+ * Use the TLS PRF function for generating data channel keys.
+ * This code is based on the OpenSSL library.
+ *
+ * TLS generates keys as such:
+ *
+ * master_secret[48] = PRF(pre_master_secret[48], "master secret",
+ *                         ClientHello.random[32] + ServerHello.random[32])
+ *
+ * key_block[] = PRF(SecurityParameters.master_secret[48],
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
+ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, size_t slen, uint8_t *out1,
+             size_t olen)
+{
+    struct gc_arena gc = gc_new();
+    const md_kt_t *md5 = md_get("MD5");
+    const md_kt_t *sha1 = md_get("SHA1");
+
+    uint8_t *out2 = (uint8_t *)gc_malloc(olen, false, &gc);
+
+    size_t len = slen / 2;
+    const uint8_t *S1 = sec;
+    const uint8_t *S2 = &(sec[len]);
+    len += (slen & 1); /* add for odd, make longer */
+
+    tls1_P_hash(md5, S1, len, label, label_len, out1, olen);
+    tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);
+
+    for (size_t i = 0; i < olen; i++)
+    {
+        out1[i] ^= out2[i];
+    }
+
+    secure_memzero(out2, olen);
+
+    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%zu]: %s", olen, format_hex(out1, olen, 0, &gc));
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
diff --git a/src/openvpn/crypto_mbedtls_legacy.h b/src/openvpn/crypto_mbedtls_legacy.h
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
+ * For PolarSSL/mbed TLS 1.1+, this is the CTR_DRBG random number generator. If it
+ * hasn't been initialised yet, the RNG will be initialised using the default
+ * entropy sources. Aside from the default platform entropy sources, an
+ * additional entropy source, the HAVEGE random number generator will also be
+ * added. During initialisation, a personalisation string will be added based
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
+ * Log the supplied mbed TLS error, prefixed by function name and line number.
+ *
+ * @param flags         Flags to indicate error type and priority.
+ * @param errval        mbed TLS error code to convert to error message.
+ * @param func          Function name where error was reported.
+ * @param line          Line number where error was reported.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+bool mbed_log_func_line(unsigned int flags, int errval, const char *func, int line);
+
+/** Wraps mbed_log_func_line() to prevent function calls for non-errors */
+static inline bool
+mbed_log_func_line_lite(unsigned int flags, int errval, const char *func, int line)
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
+#define mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
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
 
+#if MBEDTLS_VERSION_NUMBER >= 0x04000000
+typedef struct
+{
+    const char *name;
+    uint16_t tls_id;
+} mbedtls_ecp_curve_info;
+
+static inline int
+mbedtls_oid_get_attr_short_name(const mbedtls_asn1_buf *oid, const char **desc)
+{
+    /* The relevant OIDs all have equal length. */
+    if (oid->tag != MBEDTLS_ASN1_OID || oid->len != strlen(MBEDTLS_OID_AT_CN))
+    {
+        *desc = NULL;
+        return -1;
+    }
+
+    if (memcmp(oid->p, MBEDTLS_OID_AT_CN, oid->len) == 0)
+    {
+        *desc = "CN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_SUR_NAME, oid->len) == 0)
+    {
+        *desc = "SN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid->len) == 0)
+    {
+        *desc = "serialNumber";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_COUNTRY, oid->len) == 0)
+    {
+        *desc = "C";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_LOCALITY, oid->len) == 0)
+    {
+        *desc = "L";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_STATE, oid->len) == 0)
+    {
+        *desc = "ST";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORGANIZATION, oid->len) == 0)
+    {
+        *desc = "O";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORG_UNIT, oid->len) == 0)
+    {
+        *desc = "OU";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_TITLE, oid->len) == 0)
+    {
+        *desc = "title";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_ADDRESS, oid->len) == 0)
+    {
+        *desc = "postalAddress";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_CODE, oid->len) == 0)
+    {
+        *desc = "postalCode";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_GIVEN_NAME, oid->len) == 0)
+    {
+        *desc = "GN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_INITIALS, oid->len) == 0)
+    {
+        *desc = "initials";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_GENERATION_QUALIFIER, oid->len) == 0)
+    {
+        *desc = "generationQualifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIER, oid->len) == 0)
+    {
+        *desc = "uniqueIdentifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_DN_QUALIFIER, oid->len) == 0)
+    {
+        *desc = "dnQualifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_PSEUDONYM, oid->len) == 0)
+    {
+        *desc = "pseudonym";
+    }
+    else
+    {
+        *desc = NULL;
+        return -1;
+    }
+    return 0;
+}
+
+static inline int
+mbedtls_oid_get_extended_key_usage(const mbedtls_asn1_buf *oid, const char **desc)
+{
+    /* The relevant OIDs all have equal length. */
+    if (oid->tag != MBEDTLS_ASN1_OID || oid->len != strlen(MBEDTLS_OID_SERVER_AUTH))
+    {
+        *desc = NULL;
+        return -1;
+    }
+
+    if (memcmp(oid->p, MBEDTLS_OID_SERVER_AUTH, oid->len) == 0)
+    {
+        *desc = "TLS Web Server Authentication";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_CLIENT_AUTH, oid->len) == 0)
+    {
+        *desc = "TLS Web Client Authentication";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_CODE_SIGNING, oid->len) == 0)
+    {
+        *desc = "Code Signing";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_EMAIL_PROTECTION, oid->len) == 0)
+    {
+        *desc = "E-mail Protection";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_TIME_STAMPING, oid->len) == 0)
+    {
+        *desc = "Time Stamping";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_OCSP_SIGNING, oid->len) == 0)
+    {
+        *desc = "OCSP Signing";
+    }
+    else
+    {
+        *desc = NULL;
+        return -1;
+    }
+
+    return 0;
+}
+#endif /* MBEDTLS_VERSION_NUMBER >= 0x04000000 */
+
+/* Some functions that operate on private keys use randomness to protect against
+ * side channels. In Mbed TLS 4, they automatically use the RNG in the PSA
+ * library, but in Mbed TLS 3, they require them as explicit arguments. */
+static inline int
+mbedtls_compat_pk_parse_key(mbedtls_pk_context *ctx,
+                            const unsigned char *key, size_t keylen,
+                            const unsigned char *pwd, size_t pwdlen)
+{
+#if MBEDTLS_VERSION_NUMBER >= 0x04000000
+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen);
+#else
+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen, mbedtls_ctr_drbg_random, rand_ctx_get());
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
+}
+
+static inline int
+mbedtls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx, const char *path, const char *password)
+{
+#if MBEDTLS_VERSION_NUMBER >= 0x04000000
+    return mbedtls_pk_parse_keyfile(ctx, path, password);
+#else
+    return mbedtls_pk_parse_keyfile(ctx, path, password, mbedtls_ctr_drbg_random, rand_ctx_get());
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
+}
+
+static inline int
+mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_pk_context *prv)
+{
+#if MBEDTLS_VERSION_NUMBER >= 0x04000000
+    return mbedtls_pk_check_pair(pub, prv);
+#else
+    return mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_random, rand_ctx_get());
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
+}
+
 #endif /* MBEDTLS_COMPAT_H_ */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index f902e17..3e1698f 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -93,7 +93,9 @@
     ASSERT(NULL != ctx);
     CLEAR(*ctx);
 
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
+#endif
 
     ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 
@@ -107,7 +109,9 @@
     ASSERT(NULL != ctx);
     CLEAR(*ctx);
 
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
+#endif
     ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 
     ctx->endpoint = MBEDTLS_SSL_IS_CLIENT;
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
 
+#if MBEDTLS_VERSION_NUMBER >= 0x04000000
+static const mbedtls_ecp_curve_info ecp_curve_info_table[] = {
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
+static const size_t ecp_curve_info_table_items = sizeof(ecp_curve_info_table) / sizeof(mbedtls_ecp_curve_info);
+
+static const mbedtls_ecp_curve_info *
+mbedtls_ecp_curve_info_from_name(const char *name)
+{
+    for (size_t i = 0; i < ecp_curve_info_table_items; i++)
+    {
+        if (strcmp(name, ecp_curve_info_table[i].name) == 0)
+        {
+            return &ecp_curve_info_table[i];
+        }
+    }
+    return NULL;
+}
+#endif /* MBEDTLS_VERSION_NUMBER >= 0x04000000 */
+
 void
 tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
 {
@@ -409,6 +443,7 @@
 void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file, bool dh_inline)
 {
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     if (dh_inline)
     {
         if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx->dhm_ctx, (const unsigned char *)dh_file,
@@ -427,6 +462,12 @@
 
     msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with " counter_format " bit key",
         (counter_type)mbedtls_dhm_get_bitlen(ctx->dhm_ctx));
+#else
+    if (strcmp(dh_file, "none") != 0)
+    {
+        msg(M_FATAL, "Mbed TLS 4 only supports pre-defined Diffie-Hellman groups.");
+    }
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }
 
 void
@@ -500,29 +541,26 @@
 
     if (priv_key_inline)
     {
-        status = mbedtls_pk_parse_key(ctx->priv_key, (const unsigned char *)priv_key_file,
-                                      strlen(priv_key_file) + 1, NULL, 0,
-                                      mbedtls_ctr_drbg_random, rand_ctx_get());
+        status = mbedtls_compat_pk_parse_key(ctx->priv_key, (const unsigned char *)priv_key_file,
+                                             strlen(priv_key_file) + 1, NULL, 0);
 
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
         {
             char passbuf[512] = { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
-            status = mbedtls_pk_parse_key(
+            status = mbedtls_compat_pk_parse_key(
                 ctx->priv_key, (const unsigned char *)priv_key_file, strlen(priv_key_file) + 1,
-                (unsigned char *)passbuf, strlen(passbuf), mbedtls_ctr_drbg_random, rand_ctx_get());
+                (unsigned char *)passbuf, strlen(passbuf));
         }
     }
     else
     {
-        status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL,
-                                          mbedtls_ctr_drbg_random, rand_ctx_get());
+        status = mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
         {
             char passbuf[512] = { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
-            status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf,
-                                              mbedtls_ctr_drbg_random, rand_ctx_get());
+            status = mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
         }
     }
     if (!mbed_ok(status))
@@ -538,8 +576,7 @@
         return 1;
     }
 
-    if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key,
-                                       mbedtls_ctr_drbg_random, rand_ctx_get())))
+    if (!mbed_ok(mbedtls_compat_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key)))
     {
         msg(M_WARN, "Private key does not match the certificate");
         return 1;
@@ -553,6 +590,7 @@
 #pragma GCC diagnostic ignored "-Wconversion"
 #endif
 
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
 /**
  * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that uses
  * the management interface to request an RSA signature for the supplied hash.
@@ -669,11 +707,16 @@
 
     return ctx->signature_length;
 }
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 
 int
 tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx, external_sign_func sign_func,
                                   void *sign_ctx)
 {
+#if MBEDTLS_VERSION_NUMBER >= 0x04000000
+    msg(M_WARN, "tls_ctx_use_external_signing_func is not implemented for Mbed TLS 4.");
+    return 1;
+#else
     ASSERT(NULL != ctx);
 
     if (ctx->crt_chain == NULL)
@@ -701,6 +744,7 @@
     }
 
     return 0;
+#endif /* MBEDTLS_VERSION_NUMBER >= 0x04000000 */
 }
 
 #ifdef ENABLE_MANAGEMENT
@@ -938,6 +982,7 @@
 void
 tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 {
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     static char old_sha256_hash[32] = { 0 };
     unsigned char sha256_hash[32] = { 0 };
     mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
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
     mbedtls_ssl_conf_rng(ks_ssl->ssl_config, mbedtls_ctr_drbg_random, rand_ctx_get());
+#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 
     mbedtls_ssl_conf_cert_profile(ks_ssl->ssl_config, &ssl_ctx->cert_profile);
 
@@ -1100,12 +1148,14 @@
 #endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */
 
     /* Initialise authentication information */
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     if (is_server)
     {
         mbed_ok(mbedtls_ssl_conf_dh_param_ctx(ks_ssl->ssl_config, ssl_ctx->dhm_ctx));
     }
+#endif
 
-    mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl->ssl_config, ssl_ctx->crt_chain, ssl_ctx->priv_key));
+    (void)mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl->ssl_config, ssl_ctx->crt_chain, ssl_ctx->priv_key));
 
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
-        if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
+        if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval
+            || MBEDTLS_ERR_SSL_RECEIVED_NEW_SESSION_TICKET == retval)
         {
             return 0;
         }
@@ -1456,6 +1507,7 @@
 void
 show_available_curves(void)
 {
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     const mbedtls_ecp_curve_info *pcurve = mbedtls_ecp_curve_list();
 
     if (NULL == pcurve)
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
-    bool initialised;                      /**< True if the context has been initialised */
+    bool initialised; /**< True if the context has been initialised */
 
-    int endpoint;                          /**< Whether or not this is a server or a client */
+    int endpoint;     /**< Whether or not this is a server or a client */
 
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     mbedtls_dhm_context *dhm_ctx;          /**< Diffie-Helmann-Merkle context */
+#endif
     mbedtls_x509_crt *crt_chain;           /**< Local Certificate chain */
     mbedtls_x509_crt *ca_chain;            /**< CA chain for remote verification */
     mbedtls_pk_context *priv_key;          /**< Local private key */
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
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
 
+#if MBEDTLS_VERSION_NUMBER >= 0x04000000
+/* Mbed TLS 4 has no function to print the certificate serial number and does
+ * not expose the bignum functions anymore. So in order to write the serial
+ * number as a decimal string, we implement bignum % 10 and bignum / 10. */
+static char
+bignum_mod_10(const uint8_t *bignum, size_t bignum_length)
+{
+    int result = 0;
+    for (size_t i = 0; i < bignum_length; i++)
+    {
+        result = (result * 256) % 10;
+        result = (result + bignum[i]) % 10;
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
+     *     (bignum[0] * 256^n + bignum[1] * 256^(n-1) + ... + bignum[n]) / 10.
+     *
+     * Let remainder = bignum[0] % 10 and carry = remainder * 256.
+     * Then we can write the above as
+     *
+     *     (bignum[0] / 10) * 256^n
+     *       + ((carry + bignum[1]) * 256^(n-1) + ... + bignum[n]) / 10.
+     *
+     * So now we have the first byte of our result. The second byte will be
+     * (carry + bignum[1]) / 10. Note that this fits into one byte because
+     * 0 <= remainder < 10. We calculate the next remainder and carry as
+     * remainder = (carry + bignum[1]) % 10 and carry = remainder * 256 and
+     * move on to the next byte until we are done.
+     */
+    size_t new_length = 0;
+    int carry = 0;
+    for (size_t i = 0; i < *bignum_length; i++)
+    {
+        uint8_t next_byte = (uint8_t)((bignum[i] + carry) / 10);
+        int remainder = (bignum[i] + carry) % 10;
+        carry = remainder * 256;
+
+        /* Write the byte unless it's a leading zero. */
+        if (new_length != 0 || next_byte != 0)
+        {
+            bignum[new_length++] = next_byte;
+        }
+    }
+    *bignum_length = new_length;
+}
+
+/* Write the decimal representation of bignum to out, if enough space is available.
+ * Returns the number of bytes needed in out, or 0 on error. To calculate the
+ * necessary buffer size, the function can be called with out = NULL. */
+static size_t
+write_bignum(char *out, size_t out_size, const uint8_t *bignum, size_t bignum_length)
+{
+    if (bignum_length == 0)
+    {
+        /* We want out to be "0". */
+        if (out != NULL)
+        {
+            if (out_size >= 2)
+            {
+                out[0] = '0';
+                out[1] = '\0';
+            }
+            else if (out_size > 0)
+            {
+                out[0] = '\0';
+            }
+        }
+        return 2;
+    }
+
+    uint8_t *bignum_copy = malloc(bignum_length);
+    if (bignum_copy == NULL)
+    {
+        return 0;
+    }
+    memcpy(bignum_copy, bignum, bignum_length);
+
+    size_t bytes_needed = 0;
+    size_t bytes_written = 0;
+    while (bignum_length > 0)
+    {
+        /* We're writing the digits in reverse order. We put them in the right order later. */
+        char digit = bignum_mod_10(bignum_copy, bignum_length);
+        if (out != NULL && bytes_written < out_size - 1)
+        {
+            out[bytes_written++] = '0' + (char)digit;
+        }
+        bytes_needed += 1;
+        bignum_div_10(bignum_copy, &bignum_length);
+    }
+
+    if (out != NULL)
+    {
+        if (bytes_written == bytes_needed)
+        {
+            /* We had space for all digits. Now reverse them. */
+            for (size_t i = 0; i < bytes_written / 2; i++)
+            {
+                char tmp = out[i];
+                out[i] = out[bytes_written - 1 - i];
+                out[bytes_written - 1 - i] = tmp;
+            }
+            out[bytes_written] = '\0';
+        }
+        else if (out_size > 0)
+        {
+            out[0] = '\0';
+        }
+    }
+    bytes_needed += 1;
+
+    free(bignum_copy);
+    return bytes_needed;
+}
+#endif /* MBEDTLS_VERSION_NUMBER >= 0x04000000 */
+
 char *
 backend_x509_get_serial(mbedtls_x509_crt *cert, struct gc_arena *gc)
 {
     char *buf = NULL;
     size_t buflen = 0;
+
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
     mbedtls_mpi serial_mpi = { 0 };
 
     /* Transform asn1 integer serial into mbed TLS MPI */
@@ -201,6 +338,21 @@
 end:
     mbedtls_mpi_free(&serial_mpi);
     return buf;
+#else
+    buflen = write_bignum(NULL, 0, cert->serial.p, cert->serial.len);
+    if (buflen == 0)
+    {
+        msg(M_WARN, "Failed to write serial to string.");
+        return NULL;
+    }
+    buf = gc_malloc(buflen, true, gc);
+    if (write_bignum(buf, buflen, cert->serial.p, cert->serial.len) != buflen)
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
 SERVER_SERVER_2="--server 10.29.42.0 255.255.255.0"
 SERVER_MGMT_PORT_2="11195"
 SERVER_EXEC_2="${SERVER_EXEC}"
-SERVER_CONF_2="${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2} --dh ${DH}"
+SERVER_CONF_2="${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2} --dh none"
 
 SERVER_NAME_3="t_server_null_server-1196_udp"
 SERVER_SERVER_3="--server 10.29.43.0 255.255.255.0"
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
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
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h
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

