From: Steffan Karger <steffan@...1856...>
Date: Sun, 17 Apr 2016 20:35:43 +0200
Message-Id: <1460918143-408-2-git-send-email-steffan@...1856...>
In-Reply-To: <1460918143-408-1-git-send-email-steffan@...1856...>
References: <1460918143-408-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] Rename files with 'polarssl' in the
	name to 'mbedtls'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The patch looks huge, but it's just file renames, and required changes in
includes / Makefiles.  Use 'git diff -C' or a tool like gitk to easily
review this patch.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/Makefile.am           |    8 +-
 src/openvpn/crypto_backend.h      |    2 +-
 src/openvpn/crypto_mbedtls.c      |  758 ++++++++++++++++++++++++
 src/openvpn/crypto_mbedtls.h      |  146 +++++
 src/openvpn/crypto_polarssl.c     |  758 ------------------------
 src/openvpn/crypto_polarssl.h     |  146 -----
 src/openvpn/pkcs11_mbedtls.c      |  129 ++++
 src/openvpn/pkcs11_polarssl.c     |  129 ----
 src/openvpn/plugin.h              |    2 +-
 src/openvpn/ssl_backend.h         |    4 +-
 src/openvpn/ssl_mbedtls.c         | 1184 +++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_mbedtls.h         |   92 +++
 src/openvpn/ssl_polarssl.c        | 1184 -------------------------------------
 src/openvpn/ssl_polarssl.h        |   92 ---
 src/openvpn/ssl_verify.h          |    2 +-
 src/openvpn/ssl_verify_mbedtls.c  |  508 ++++++++++++++++
 src/openvpn/ssl_verify_mbedtls.h  |   78 +++
 src/openvpn/ssl_verify_polarssl.c |  508 ----------------
 src/openvpn/ssl_verify_polarssl.h |   78 ---
 19 files changed, 2904 insertions(+), 2904 deletions(-)
 create mode 100644 src/openvpn/crypto_mbedtls.c
 create mode 100644 src/openvpn/crypto_mbedtls.h
 delete mode 100644 src/openvpn/crypto_polarssl.c
 delete mode 100644 src/openvpn/crypto_polarssl.h
 create mode 100644 src/openvpn/pkcs11_mbedtls.c
 delete mode 100644 src/openvpn/pkcs11_polarssl.c
 create mode 100644 src/openvpn/ssl_mbedtls.c
 create mode 100644 src/openvpn/ssl_mbedtls.h
 delete mode 100644 src/openvpn/ssl_polarssl.c
 delete mode 100644 src/openvpn/ssl_polarssl.h
 create mode 100644 src/openvpn/ssl_verify_mbedtls.c
 create mode 100644 src/openvpn/ssl_verify_mbedtls.h
 delete mode 100644 src/openvpn/ssl_verify_polarssl.c
 delete mode 100644 src/openvpn/ssl_verify_polarssl.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index bf1d749..9d4bf61 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -46,7 +46,7 @@ openvpn_SOURCES = \
 	comp-lz4.c comp-lz4.h \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
-	crypto_polarssl.c crypto_polarssl.h \
+	crypto_mbedtls.c crypto_mbedtls.h \
 	dhcp.c dhcp.h \
 	errlevel.h \
 	error.c error.h \
@@ -80,7 +80,7 @@ openvpn_SOURCES = \
 	occ.c occ.h occ-inline.h \
 	pkcs11.c pkcs11.h pkcs11_backend.h \
 	pkcs11_openssl.c \
-	pkcs11_polarssl.c \
+	pkcs11_mbedtls.c \
 	openvpn.c openvpn.h \
 	options.c options.h \
 	otime.c otime.h \
@@ -105,11 +105,11 @@ openvpn_SOURCES = \
 	socks.c socks.h \
 	ssl.c ssl.h  ssl_backend.h \
 	ssl_openssl.c ssl_openssl.h \
-	ssl_polarssl.c ssl_polarssl.h \
+	ssl_mbedtls.c ssl_mbedtls.h \
 	ssl_common.h \
 	ssl_verify.c ssl_verify.h ssl_verify_backend.h \
 	ssl_verify_openssl.c ssl_verify_openssl.h \
-	ssl_verify_polarssl.c ssl_verify_polarssl.h \
+	ssl_verify_mbedtls.c ssl_verify_mbedtls.h \
 	status.c status.h \
 	syshead.h \
 	tun.c tun.h \
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index c4986f5..3893f14 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -34,7 +34,7 @@
 #include "crypto_openssl.h"
 #endif
 #ifdef ENABLE_CRYPTO_MBEDTLS
-#include "crypto_polarssl.h"
+#include "crypto_mbedtls.h"
 #endif
 #include "basic.h"
 
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
new file mode 100644
index 0000000..da1b417
--- /dev/null
+++ b/src/openvpn/crypto_mbedtls.c
@@ -0,0 +1,758 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file Data Channel Cryptography mbed TLS-specific backend interface
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
+
+#include "errlevel.h"
+#include "basic.h"
+#include "buffer.h"
+#include "integer.h"
+#include "crypto_backend.h"
+#include "otime.h"
+#include "misc.h"
+
+#include <mbedtls/des.h>
+#include <mbedtls/error.h>
+#include <mbedtls/md5.h>
+#include <mbedtls/cipher.h>
+#include <mbedtls/havege.h>
+
+#include <mbedtls/entropy.h>
+
+
+/*
+ *
+ * Hardware engine support. Allows loading/unloading of engines.
+ *
+ */
+
+void
+crypto_init_lib_engine (const char *engine_name)
+{
+  msg (M_WARN, "Note: mbed TLS hardware crypto engine functionality is not "
+      "available");
+}
+
+/*
+ *
+ * Functions related to the core crypto library
+ *
+ */
+
+void
+crypto_init_lib (void)
+{
+}
+
+void
+crypto_uninit_lib (void)
+{
+}
+
+void
+crypto_clear_error (void)
+{
+}
+
+bool mbed_log_err(unsigned int flags, int errval, const char *prefix)
+{
+  if (0 != errval)
+    {
+      char errstr[256];
+      mbedtls_strerror(errval, errstr, sizeof(errstr));
+
+      if (NULL == prefix) prefix = "mbed TLS error";
+      msg (flags, "%s: %s", prefix, errstr);
+    }
+
+  return 0 == errval;
+}
+
+bool mbed_log_func_line(unsigned int flags, int errval, const char *func,
+    int line)
+{
+  char prefix[256];
+
+  if (!openvpn_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
+    return mbed_log_err(flags, errval, func);
+
+  return mbed_log_err(flags, errval, prefix);
+}
+
+
+#ifdef DMALLOC
+void
+crypto_init_dmalloc (void)
+{
+  msg (M_ERR, "Error: dmalloc support is not available for mbed TLS.");
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
+    sizeof (cipher_name_translation_table) / sizeof (*cipher_name_translation_table);
+
+void
+show_available_ciphers ()
+{
+  const int *ciphers = mbedtls_cipher_list();
+
+#ifndef ENABLE_SMALL
+  printf ("The following ciphers and cipher modes are available for use\n"
+	  "with " PACKAGE_NAME ".  Each cipher shown below may be used as a\n"
+	  "parameter to the --cipher option.  Using a CBC or GCM mode is\n"
+	  "recommended.  In static key mode only CBC mode is allowed.\n\n");
+#endif
+
+  while (*ciphers != 0)
+    {
+      const cipher_kt_t *info = mbedtls_cipher_info_from_type(*ciphers);
+
+      if (info && (cipher_kt_mode_cbc(info)
+#ifdef HAVE_AEAD_CIPHER_MODES
+          || cipher_kt_mode_aead(info)
+#endif
+          ))
+	{
+	  const char *ssl_only = cipher_kt_mode_cbc(info) ?
+	      "" : " (TLS client/server mode)";
+
+	  printf ("%s %d bit default key%s\n",
+	      cipher_kt_name(info), cipher_kt_key_size(info) * 8, ssl_only);
+	}
+
+      ciphers++;
+    }
+  printf ("\n");
+}
+
+void
+show_available_digests ()
+{
+  const int *digests = mbedtls_md_list();
+
+#ifndef ENABLE_SMALL
+  printf ("The following message digests are available for use with\n"
+	  PACKAGE_NAME ".  A message digest is used in conjunction with\n"
+	  "the HMAC function, to authenticate received packets.\n"
+	  "You can specify a message digest as parameter to\n"
+	  "the --auth option.\n\n");
+#endif
+
+  while (*digests != 0)
+    {
+      const mbedtls_md_info_t *info = mbedtls_md_info_from_type(*digests);
+
+      if (info)
+	printf ("%s %d bit default key\n", mbedtls_md_get_name(info),
+	    mbedtls_md_get_size(info) * 8);
+      digests++;
+    }
+  printf ("\n");
+}
+
+void
+show_available_engines ()
+{
+  printf ("Sorry, mbed TLS hardware crypto engine functionality is not "
+      "available\n");
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
+mbedtls_ctr_drbg_context * rand_ctx_get()
+{
+  static mbedtls_entropy_context ec = {0};
+  static mbedtls_ctr_drbg_context cd_ctx = {0};
+  static bool rand_initialised = false;
+
+  if (!rand_initialised)
+    {
+      struct gc_arena gc = gc_new();
+      struct buffer pers_string = alloc_buf_gc(100, &gc);
+
+      /*
+       * Personalisation string, should be as unique as possible (see NIST
+       * 800-90 section 8.7.1). We have very little information at this stage.
+       * Include Program Name, memory address of the context and PID.
+       */
+      buf_printf(&pers_string, "OpenVPN %0u %p %s", platform_getpid(), &cd_ctx, time_string(0, 0, 0, &gc));
+
+      /* Initialise mbed TLS RNG, and built-in entropy sources */
+      mbedtls_entropy_init(&ec);
+
+      mbedtls_ctr_drbg_init(&cd_ctx);
+      if (!mbed_ok(mbedtls_ctr_drbg_seed(&cd_ctx, mbedtls_entropy_func, &ec,
+		    BPTR(&pers_string), BLEN(&pers_string))))
+        msg (M_FATAL, "Failed to initialize random generator");
+
+      gc_free(&gc);
+      rand_initialised = true;
+  }
+
+  return &cd_ctx;
+}
+
+#ifdef ENABLE_PREDICTION_RESISTANCE
+void rand_ctx_enable_prediction_resistance()
+{
+  mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
+
+  mbedtls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);
+}
+#endif /* ENABLE_PREDICTION_RESISTANCE */
+
+int
+rand_bytes (uint8_t *output, int len)
+{
+  mbedtls_ctr_drbg_context *rng_ctx = rand_ctx_get();
+
+  while (len > 0)
+    {
+      const size_t blen = min_int (len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
+      if (0 != mbedtls_ctr_drbg_random(rng_ctx, output, blen))
+	return 0;
+
+      output += blen;
+      len -= blen;
+    }
+
+  return 1;
+}
+
+/*
+ *
+ * Key functions, allow manipulation of keys.
+ *
+ */
+
+
+int
+key_des_num_cblocks (const mbedtls_cipher_info_t *kt)
+{
+  int ret = 0;
+  if (kt->type == MBEDTLS_CIPHER_DES_CBC)
+    ret = 1;
+  if (kt->type == MBEDTLS_CIPHER_DES_EDE_CBC)
+    ret = 2;
+  if (kt->type == MBEDTLS_CIPHER_DES_EDE3_CBC)
+    ret = 3;
+
+  dmsg (D_CRYPTO_DEBUG, "CRYPTO INFO: n_DES_cblocks=%d", ret);
+  return ret;
+}
+
+bool
+key_des_check (uint8_t *key, int key_len, int ndc)
+{
+  int i;
+  struct buffer b;
+
+  buf_set_read (&b, key, key_len);
+
+  for (i = 0; i < ndc; ++i)
+    {
+      unsigned char *key = buf_read_alloc(&b, MBEDTLS_DES_KEY_SIZE);
+      if (!key)
+	{
+	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key material");
+	  goto err;
+	}
+      if (0 != mbedtls_des_key_check_weak(key))
+	{
+	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key detected");
+	  goto err;
+	}
+      if (0 != mbedtls_des_key_check_key_parity(key))
+	{
+	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: bad parity detected");
+	  goto err;
+	}
+    }
+  return true;
+
+ err:
+  return false;
+}
+
+void
+key_des_fixup (uint8_t *key, int key_len, int ndc)
+{
+  int i;
+  struct buffer b;
+
+  buf_set_read (&b, key, key_len);
+  for (i = 0; i < ndc; ++i)
+    {
+      unsigned char *key = buf_read_alloc(&b, MBEDTLS_DES_KEY_SIZE);
+      if (!key)
+	{
+	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: fixup_key_DES: insufficient key material");
+	  return;
+	}
+      mbedtls_des_key_set_parity(key);
+    }
+}
+
+/*
+ *
+ * Generic cipher key type functions
+ *
+ */
+
+
+const mbedtls_cipher_info_t *
+cipher_kt_get (const char *ciphername)
+{
+  const mbedtls_cipher_info_t *cipher = NULL;
+
+  ASSERT (ciphername);
+
+  cipher = mbedtls_cipher_info_from_string(ciphername);
+
+  if (NULL == cipher)
+    msg (M_FATAL, "Cipher algorithm '%s' not found", ciphername);
+
+  if (cipher->key_bitlen/8 > MAX_CIPHER_KEY_LENGTH)
+    msg (M_FATAL, "Cipher algorithm '%s' uses a default key size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum key size (%d bytes)",
+	 ciphername,
+	 cipher->key_bitlen/8,
+	 MAX_CIPHER_KEY_LENGTH);
+
+  return cipher;
+}
+
+const char *
+cipher_kt_name (const mbedtls_cipher_info_t *cipher_kt)
+{
+  if (NULL == cipher_kt)
+    return "[null-cipher]";
+
+  return translate_cipher_name_to_openvpn(cipher_kt->name);
+}
+
+int
+cipher_kt_key_size (const mbedtls_cipher_info_t *cipher_kt)
+{
+  if (NULL == cipher_kt)
+    return 0;
+
+  return cipher_kt->key_bitlen/8;
+}
+
+int
+cipher_kt_iv_size (const mbedtls_cipher_info_t *cipher_kt)
+{
+  if (NULL == cipher_kt)
+    return 0;
+  return cipher_kt->iv_size;
+}
+
+int
+cipher_kt_block_size (const mbedtls_cipher_info_t *cipher_kt)
+{
+  if (NULL == cipher_kt)
+    return 0;
+  return cipher_kt->block_size;
+}
+
+int
+cipher_kt_tag_size (const mbedtls_cipher_info_t *cipher_kt)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  if (cipher_kt && cipher_kt_mode_aead(cipher_kt))
+    return OPENVPN_AEAD_TAG_LENGTH;
+#endif
+  return 0;
+}
+
+int
+cipher_kt_mode (const mbedtls_cipher_info_t *cipher_kt)
+{
+  ASSERT(NULL != cipher_kt);
+  return cipher_kt->mode;
+}
+
+bool
+cipher_kt_mode_cbc(const cipher_kt_t *cipher)
+{
+  return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC;
+}
+
+bool
+cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
+{
+  return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB ||
+      cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
+}
+
+bool
+cipher_kt_mode_aead(const cipher_kt_t *cipher)
+{
+  return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_GCM;
+}
+
+
+/*
+ *
+ * Generic cipher context functions
+ *
+ */
+
+
+void
+cipher_ctx_init (mbedtls_cipher_context_t *ctx, uint8_t *key, int key_len,
+    const mbedtls_cipher_info_t *kt, const mbedtls_operation_t operation)
+{
+  ASSERT(NULL != kt && NULL != ctx);
+
+  CLEAR (*ctx);
+
+  if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
+    msg (M_FATAL, "mbed TLS cipher context init #1");
+
+  if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, key_len*8, operation)))
+    msg (M_FATAL, "mbed TLS cipher set key");
+
+  /* make sure we used a big enough key */
+  ASSERT (ctx->key_bitlen <= key_len*8);
+}
+
+void cipher_ctx_cleanup (mbedtls_cipher_context_t *ctx)
+{
+  mbedtls_cipher_free(ctx);
+}
+
+int cipher_ctx_iv_length (const mbedtls_cipher_context_t *ctx)
+{
+  return mbedtls_cipher_get_iv_size(ctx);
+}
+
+int cipher_ctx_get_tag (cipher_ctx_t *ctx, uint8_t* tag, int tag_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  if (tag_len > SIZE_MAX)
+    return 0;
+
+  if (!mbed_ok (mbedtls_cipher_write_tag (ctx, (unsigned char *) tag, tag_len)))
+    return 0;
+
+  return 1;
+#else
+  ASSERT(0);
+#endif /* HAVE_AEAD_CIPHER_MODES */
+}
+
+int cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)
+{
+  return mbedtls_cipher_get_block_size(ctx);
+}
+
+int cipher_ctx_mode (const mbedtls_cipher_context_t *ctx)
+{
+  ASSERT(NULL != ctx);
+
+  return cipher_kt_mode(ctx->cipher_info);
+}
+
+const cipher_kt_t *
+cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
+{
+  return ctx ? ctx->cipher_info : NULL;
+}
+
+int cipher_ctx_reset (mbedtls_cipher_context_t *ctx, uint8_t *iv_buf)
+{
+  if (!mbed_ok(mbedtls_cipher_reset(ctx)))
+    return 0;
+
+  if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, ctx->cipher_info->iv_size)))
+    return 0;
+
+  return 1;
+}
+
+int cipher_ctx_update_ad (cipher_ctx_t *ctx, const uint8_t *src, int src_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  if (src_len > SIZE_MAX)
+    return 0;
+
+  if (!mbed_ok (mbedtls_cipher_update_ad (ctx, src, src_len)))
+    return 0;
+
+  return 1;
+#else
+  ASSERT(0);
+#endif /* HAVE_AEAD_CIPHER_MODES */
+}
+
+int cipher_ctx_update (mbedtls_cipher_context_t *ctx, uint8_t *dst,
+    int *dst_len, uint8_t *src, int src_len)
+{
+  size_t s_dst_len = *dst_len;
+
+  if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t) src_len, dst,
+      &s_dst_len)))
+    return 0;
+
+  *dst_len = s_dst_len;
+
+  return 1;
+}
+
+int cipher_ctx_final (mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len)
+{
+  size_t s_dst_len = *dst_len;
+
+  if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &s_dst_len)))
+    return 0;
+
+  *dst_len = s_dst_len;
+
+  return 1;
+}
+
+int cipher_ctx_final_check_tag (mbedtls_cipher_context_t *ctx, uint8_t *dst,
+    int *dst_len, uint8_t *tag, size_t tag_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  size_t olen = 0;
+
+  if (MBEDTLS_DECRYPT != ctx->operation)
+    return 0;
+
+  if (tag_len > SIZE_MAX)
+    return 0;
+
+  if (!mbed_ok (mbedtls_cipher_finish (ctx, dst, &olen)))
+    {
+      msg (D_CRYPT_ERRORS, "%s: cipher_ctx_final() failed", __func__);
+      return 0;
+    }
+
+  if (olen > INT_MAX)
+    return 0;
+  *dst_len = olen;
+
+  if (!mbed_ok (mbedtls_cipher_check_tag (ctx, (const unsigned char *) tag,
+      tag_len)))
+    return 0;
+
+  return 1;
+#else
+  ASSERT(0);
+#endif /* HAVE_AEAD_CIPHER_MODES */
+}
+
+void
+cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
+    unsigned char *src,
+    unsigned char *dst)
+{
+  mbedtls_des_context ctx;
+
+  ASSERT (mbed_ok(mbedtls_des_setkey_enc(&ctx, key)));
+  ASSERT (mbed_ok(mbedtls_des_crypt_ecb(&ctx, src, dst)));
+}
+
+
+
+/*
+ *
+ * Generic message digest information functions
+ *
+ */
+
+
+const mbedtls_md_info_t *
+md_kt_get (const char *digest)
+{
+  const mbedtls_md_info_t *md = NULL;
+  ASSERT (digest);
+
+  md = mbedtls_md_info_from_string(digest);
+  if (!md)
+    msg (M_FATAL, "Message hash algorithm '%s' not found", digest);
+  if (mbedtls_md_get_size(md) > MAX_HMAC_KEY_LENGTH)
+    msg (M_FATAL, "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum hash size (%d bytes)",
+	 digest,
+	 mbedtls_md_get_size(md),
+	 MAX_HMAC_KEY_LENGTH);
+  return md;
+}
+
+const char *
+md_kt_name (const mbedtls_md_info_t *kt)
+{
+  if (NULL == kt)
+    return "[null-digest]";
+  return mbedtls_md_get_name (kt);
+}
+
+int
+md_kt_size (const mbedtls_md_info_t *kt)
+{
+  if (NULL == kt)
+    return 0;
+  return mbedtls_md_get_size(kt);
+}
+
+/*
+ *
+ * Generic message digest functions
+ *
+ */
+
+int
+md_full (const md_kt_t *kt, const uint8_t *src, int src_len, uint8_t *dst)
+{
+  return 0 == mbedtls_md(kt, src, src_len, dst);
+}
+
+
+void
+md_ctx_init (mbedtls_md_context_t *ctx, const mbedtls_md_info_t *kt)
+{
+  ASSERT(NULL != ctx && NULL != kt);
+
+  mbedtls_md_init(ctx);
+  ASSERT(0 == mbedtls_md_setup(ctx, kt, 0));
+  ASSERT(0 == mbedtls_md_starts(ctx));
+}
+
+void
+md_ctx_cleanup(mbedtls_md_context_t *ctx)
+{
+}
+
+int
+md_ctx_size (const mbedtls_md_context_t *ctx)
+{
+  if (NULL == ctx)
+    return 0;
+  return mbedtls_md_get_size(ctx->md_info);
+}
+
+void
+md_ctx_update (mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
+{
+  ASSERT(0 == mbedtls_md_update(ctx, src, src_len));
+}
+
+void
+md_ctx_final (mbedtls_md_context_t *ctx, uint8_t *dst)
+{
+  ASSERT(0 == mbedtls_md_finish(ctx, dst));
+  mbedtls_md_free(ctx);
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
+void
+hmac_ctx_init (mbedtls_md_context_t *ctx, const uint8_t *key, int key_len,
+    const mbedtls_md_info_t *kt)
+{
+  ASSERT(NULL != kt && NULL != ctx);
+
+  mbedtls_md_init(ctx);
+  ASSERT(0 == mbedtls_md_setup(ctx, kt, 1));
+  ASSERT(0 == mbedtls_md_hmac_starts(ctx, key, key_len));
+
+  /* make sure we used a big enough key */
+  ASSERT (mbedtls_md_get_size(kt) <= key_len);
+}
+
+void
+hmac_ctx_cleanup(mbedtls_md_context_t *ctx)
+{
+  mbedtls_md_free(ctx);
+}
+
+int
+hmac_ctx_size (const mbedtls_md_context_t *ctx)
+{
+  if (NULL == ctx)
+    return 0;
+  return mbedtls_md_get_size(ctx->md_info);
+}
+
+void
+hmac_ctx_reset (mbedtls_md_context_t *ctx)
+{
+  ASSERT(0 == mbedtls_md_hmac_reset(ctx));
+}
+
+void
+hmac_ctx_update (mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
+{
+  ASSERT(0 == mbedtls_md_hmac_update(ctx, src, src_len));
+}
+
+void
+hmac_ctx_final (mbedtls_md_context_t *ctx, uint8_t *dst)
+{
+  ASSERT(0 == mbedtls_md_hmac_finish(ctx, dst));
+}
+
+#endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
new file mode 100644
index 0000000..574a63f
--- /dev/null
+++ b/src/openvpn/crypto_mbedtls.h
@@ -0,0 +1,146 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file Data Channel Cryptography mbed TLS-specific backend interface
+ */
+
+#ifndef CRYPTO_MBEDTLS_H_
+#define CRYPTO_MBEDTLS_H_
+
+#include <mbedtls/cipher.h>
+#include <mbedtls/md.h>
+#include <mbedtls/ctr_drbg.h>
+
+/** Generic cipher key type %context. */
+typedef mbedtls_cipher_info_t cipher_kt_t;
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
+/** Maximum length of an IV */
+#define OPENVPN_MAX_IV_LENGTH 	MBEDTLS_MAX_IV_LENGTH
+
+/** Cipher is in CBC mode */
+#define OPENVPN_MODE_CBC 	MBEDTLS_MODE_CBC
+
+/** Cipher is in OFB mode */
+#define OPENVPN_MODE_OFB 	MBEDTLS_MODE_OFB
+
+/** Cipher is in CFB mode */
+#define OPENVPN_MODE_CFB 	MBEDTLS_MODE_CFB
+
+/** Cipher is in GCM mode */
+#define OPENVPN_MODE_GCM	MBEDTLS_MODE_GCM
+
+/** Cipher should encrypt */
+#define OPENVPN_OP_ENCRYPT 	MBEDTLS_ENCRYPT
+
+/** Cipher should decrypt */
+#define OPENVPN_OP_DECRYPT 	MBEDTLS_DECRYPT
+
+#define MD4_DIGEST_LENGTH 	16
+#define MD5_DIGEST_LENGTH 	16
+#define SHA_DIGEST_LENGTH 	20
+#define DES_KEY_LENGTH 8
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
+mbedtls_ctr_drbg_context *rand_ctx_get();
+
+#ifdef ENABLE_PREDICTION_RESISTANCE
+/**
+ * Enable prediction resistance on the random number generator.
+ */
+void rand_ctx_enable_prediction_resistance();
+#endif
+
+/**
+ * Log the supplied mbed TLS error, prefixed by supplied prefix.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ * @param errval	mbed TLS error code to convert to error message.
+ * @param prefix	Prefix to mbed TLS error message.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+bool mbed_log_err(unsigned int flags, int errval, const char *prefix);
+
+/**
+ * Log the supplied mbed TLS error, prefixed by function name and line number.
+ *
+ * @param flags		Flags to indicate error type and priority.
+ * @param errval	mbed TLS error code to convert to error message.
+ * @param func		Function name where error was reported.
+ * @param line		Line number where error was reported.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+bool mbed_log_func_line(unsigned int flags, int errval, const char *func,
+    int line);
+
+/** Wraps mbed_log_func_line() to prevent function calls for non-errors */
+static inline bool mbed_log_func_line_lite(unsigned int flags, int errval,
+    const char *func, int line) {
+  if (errval) {
+    return mbed_log_func_line (flags, errval, func, line);
+  }
+  return true;
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
+ * @param errval	mbed TLS error code to convert to error message.
+ *
+ * @returns true if no errors are detected, false otherwise.
+ */
+#define mbed_ok(errval) \
+  mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
+
+
+#endif /* CRYPTO_MBEDTLS_H_ */
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
deleted file mode 100644
index da1b417..0000000
--- a/src/openvpn/crypto_polarssl.c
+++ /dev/null
@@ -1,758 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/**
- * @file Data Channel Cryptography mbed TLS-specific backend interface
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-
-#include "syshead.h"
-
-#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
-
-#include "errlevel.h"
-#include "basic.h"
-#include "buffer.h"
-#include "integer.h"
-#include "crypto_backend.h"
-#include "otime.h"
-#include "misc.h"
-
-#include <mbedtls/des.h>
-#include <mbedtls/error.h>
-#include <mbedtls/md5.h>
-#include <mbedtls/cipher.h>
-#include <mbedtls/havege.h>
-
-#include <mbedtls/entropy.h>
-
-
-/*
- *
- * Hardware engine support. Allows loading/unloading of engines.
- *
- */
-
-void
-crypto_init_lib_engine (const char *engine_name)
-{
-  msg (M_WARN, "Note: mbed TLS hardware crypto engine functionality is not "
-      "available");
-}
-
-/*
- *
- * Functions related to the core crypto library
- *
- */
-
-void
-crypto_init_lib (void)
-{
-}
-
-void
-crypto_uninit_lib (void)
-{
-}
-
-void
-crypto_clear_error (void)
-{
-}
-
-bool mbed_log_err(unsigned int flags, int errval, const char *prefix)
-{
-  if (0 != errval)
-    {
-      char errstr[256];
-      mbedtls_strerror(errval, errstr, sizeof(errstr));
-
-      if (NULL == prefix) prefix = "mbed TLS error";
-      msg (flags, "%s: %s", prefix, errstr);
-    }
-
-  return 0 == errval;
-}
-
-bool mbed_log_func_line(unsigned int flags, int errval, const char *func,
-    int line)
-{
-  char prefix[256];
-
-  if (!openvpn_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
-    return mbed_log_err(flags, errval, func);
-
-  return mbed_log_err(flags, errval, prefix);
-}
-
-
-#ifdef DMALLOC
-void
-crypto_init_dmalloc (void)
-{
-  msg (M_ERR, "Error: dmalloc support is not available for mbed TLS.");
-}
-#endif /* DMALLOC */
-
-const cipher_name_pair cipher_name_translation_table[] = {
-    { "BF-CBC", "BLOWFISH-CBC" },
-    { "BF-CFB", "BLOWFISH-CFB64" },
-    { "CAMELLIA-128-CFB", "CAMELLIA-128-CFB128" },
-    { "CAMELLIA-192-CFB", "CAMELLIA-192-CFB128" },
-    { "CAMELLIA-256-CFB", "CAMELLIA-256-CFB128" }
-};
-const size_t cipher_name_translation_table_count =
-    sizeof (cipher_name_translation_table) / sizeof (*cipher_name_translation_table);
-
-void
-show_available_ciphers ()
-{
-  const int *ciphers = mbedtls_cipher_list();
-
-#ifndef ENABLE_SMALL
-  printf ("The following ciphers and cipher modes are available for use\n"
-	  "with " PACKAGE_NAME ".  Each cipher shown below may be used as a\n"
-	  "parameter to the --cipher option.  Using a CBC or GCM mode is\n"
-	  "recommended.  In static key mode only CBC mode is allowed.\n\n");
-#endif
-
-  while (*ciphers != 0)
-    {
-      const cipher_kt_t *info = mbedtls_cipher_info_from_type(*ciphers);
-
-      if (info && (cipher_kt_mode_cbc(info)
-#ifdef HAVE_AEAD_CIPHER_MODES
-          || cipher_kt_mode_aead(info)
-#endif
-          ))
-	{
-	  const char *ssl_only = cipher_kt_mode_cbc(info) ?
-	      "" : " (TLS client/server mode)";
-
-	  printf ("%s %d bit default key%s\n",
-	      cipher_kt_name(info), cipher_kt_key_size(info) * 8, ssl_only);
-	}
-
-      ciphers++;
-    }
-  printf ("\n");
-}
-
-void
-show_available_digests ()
-{
-  const int *digests = mbedtls_md_list();
-
-#ifndef ENABLE_SMALL
-  printf ("The following message digests are available for use with\n"
-	  PACKAGE_NAME ".  A message digest is used in conjunction with\n"
-	  "the HMAC function, to authenticate received packets.\n"
-	  "You can specify a message digest as parameter to\n"
-	  "the --auth option.\n\n");
-#endif
-
-  while (*digests != 0)
-    {
-      const mbedtls_md_info_t *info = mbedtls_md_info_from_type(*digests);
-
-      if (info)
-	printf ("%s %d bit default key\n", mbedtls_md_get_name(info),
-	    mbedtls_md_get_size(info) * 8);
-      digests++;
-    }
-  printf ("\n");
-}
-
-void
-show_available_engines ()
-{
-  printf ("Sorry, mbed TLS hardware crypto engine functionality is not "
-      "available\n");
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
-mbedtls_ctr_drbg_context * rand_ctx_get()
-{
-  static mbedtls_entropy_context ec = {0};
-  static mbedtls_ctr_drbg_context cd_ctx = {0};
-  static bool rand_initialised = false;
-
-  if (!rand_initialised)
-    {
-      struct gc_arena gc = gc_new();
-      struct buffer pers_string = alloc_buf_gc(100, &gc);
-
-      /*
-       * Personalisation string, should be as unique as possible (see NIST
-       * 800-90 section 8.7.1). We have very little information at this stage.
-       * Include Program Name, memory address of the context and PID.
-       */
-      buf_printf(&pers_string, "OpenVPN %0u %p %s", platform_getpid(), &cd_ctx, time_string(0, 0, 0, &gc));
-
-      /* Initialise mbed TLS RNG, and built-in entropy sources */
-      mbedtls_entropy_init(&ec);
-
-      mbedtls_ctr_drbg_init(&cd_ctx);
-      if (!mbed_ok(mbedtls_ctr_drbg_seed(&cd_ctx, mbedtls_entropy_func, &ec,
-		    BPTR(&pers_string), BLEN(&pers_string))))
-        msg (M_FATAL, "Failed to initialize random generator");
-
-      gc_free(&gc);
-      rand_initialised = true;
-  }
-
-  return &cd_ctx;
-}
-
-#ifdef ENABLE_PREDICTION_RESISTANCE
-void rand_ctx_enable_prediction_resistance()
-{
-  mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
-
-  mbedtls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);
-}
-#endif /* ENABLE_PREDICTION_RESISTANCE */
-
-int
-rand_bytes (uint8_t *output, int len)
-{
-  mbedtls_ctr_drbg_context *rng_ctx = rand_ctx_get();
-
-  while (len > 0)
-    {
-      const size_t blen = min_int (len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
-      if (0 != mbedtls_ctr_drbg_random(rng_ctx, output, blen))
-	return 0;
-
-      output += blen;
-      len -= blen;
-    }
-
-  return 1;
-}
-
-/*
- *
- * Key functions, allow manipulation of keys.
- *
- */
-
-
-int
-key_des_num_cblocks (const mbedtls_cipher_info_t *kt)
-{
-  int ret = 0;
-  if (kt->type == MBEDTLS_CIPHER_DES_CBC)
-    ret = 1;
-  if (kt->type == MBEDTLS_CIPHER_DES_EDE_CBC)
-    ret = 2;
-  if (kt->type == MBEDTLS_CIPHER_DES_EDE3_CBC)
-    ret = 3;
-
-  dmsg (D_CRYPTO_DEBUG, "CRYPTO INFO: n_DES_cblocks=%d", ret);
-  return ret;
-}
-
-bool
-key_des_check (uint8_t *key, int key_len, int ndc)
-{
-  int i;
-  struct buffer b;
-
-  buf_set_read (&b, key, key_len);
-
-  for (i = 0; i < ndc; ++i)
-    {
-      unsigned char *key = buf_read_alloc(&b, MBEDTLS_DES_KEY_SIZE);
-      if (!key)
-	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key material");
-	  goto err;
-	}
-      if (0 != mbedtls_des_key_check_weak(key))
-	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key detected");
-	  goto err;
-	}
-      if (0 != mbedtls_des_key_check_key_parity(key))
-	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: bad parity detected");
-	  goto err;
-	}
-    }
-  return true;
-
- err:
-  return false;
-}
-
-void
-key_des_fixup (uint8_t *key, int key_len, int ndc)
-{
-  int i;
-  struct buffer b;
-
-  buf_set_read (&b, key, key_len);
-  for (i = 0; i < ndc; ++i)
-    {
-      unsigned char *key = buf_read_alloc(&b, MBEDTLS_DES_KEY_SIZE);
-      if (!key)
-	{
-	  msg (D_CRYPT_ERRORS, "CRYPTO INFO: fixup_key_DES: insufficient key material");
-	  return;
-	}
-      mbedtls_des_key_set_parity(key);
-    }
-}
-
-/*
- *
- * Generic cipher key type functions
- *
- */
-
-
-const mbedtls_cipher_info_t *
-cipher_kt_get (const char *ciphername)
-{
-  const mbedtls_cipher_info_t *cipher = NULL;
-
-  ASSERT (ciphername);
-
-  cipher = mbedtls_cipher_info_from_string(ciphername);
-
-  if (NULL == cipher)
-    msg (M_FATAL, "Cipher algorithm '%s' not found", ciphername);
-
-  if (cipher->key_bitlen/8 > MAX_CIPHER_KEY_LENGTH)
-    msg (M_FATAL, "Cipher algorithm '%s' uses a default key size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum key size (%d bytes)",
-	 ciphername,
-	 cipher->key_bitlen/8,
-	 MAX_CIPHER_KEY_LENGTH);
-
-  return cipher;
-}
-
-const char *
-cipher_kt_name (const mbedtls_cipher_info_t *cipher_kt)
-{
-  if (NULL == cipher_kt)
-    return "[null-cipher]";
-
-  return translate_cipher_name_to_openvpn(cipher_kt->name);
-}
-
-int
-cipher_kt_key_size (const mbedtls_cipher_info_t *cipher_kt)
-{
-  if (NULL == cipher_kt)
-    return 0;
-
-  return cipher_kt->key_bitlen/8;
-}
-
-int
-cipher_kt_iv_size (const mbedtls_cipher_info_t *cipher_kt)
-{
-  if (NULL == cipher_kt)
-    return 0;
-  return cipher_kt->iv_size;
-}
-
-int
-cipher_kt_block_size (const mbedtls_cipher_info_t *cipher_kt)
-{
-  if (NULL == cipher_kt)
-    return 0;
-  return cipher_kt->block_size;
-}
-
-int
-cipher_kt_tag_size (const mbedtls_cipher_info_t *cipher_kt)
-{
-#ifdef HAVE_AEAD_CIPHER_MODES
-  if (cipher_kt && cipher_kt_mode_aead(cipher_kt))
-    return OPENVPN_AEAD_TAG_LENGTH;
-#endif
-  return 0;
-}
-
-int
-cipher_kt_mode (const mbedtls_cipher_info_t *cipher_kt)
-{
-  ASSERT(NULL != cipher_kt);
-  return cipher_kt->mode;
-}
-
-bool
-cipher_kt_mode_cbc(const cipher_kt_t *cipher)
-{
-  return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC;
-}
-
-bool
-cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
-{
-  return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB ||
-      cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
-}
-
-bool
-cipher_kt_mode_aead(const cipher_kt_t *cipher)
-{
-  return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_GCM;
-}
-
-
-/*
- *
- * Generic cipher context functions
- *
- */
-
-
-void
-cipher_ctx_init (mbedtls_cipher_context_t *ctx, uint8_t *key, int key_len,
-    const mbedtls_cipher_info_t *kt, const mbedtls_operation_t operation)
-{
-  ASSERT(NULL != kt && NULL != ctx);
-
-  CLEAR (*ctx);
-
-  if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
-    msg (M_FATAL, "mbed TLS cipher context init #1");
-
-  if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, key_len*8, operation)))
-    msg (M_FATAL, "mbed TLS cipher set key");
-
-  /* make sure we used a big enough key */
-  ASSERT (ctx->key_bitlen <= key_len*8);
-}
-
-void cipher_ctx_cleanup (mbedtls_cipher_context_t *ctx)
-{
-  mbedtls_cipher_free(ctx);
-}
-
-int cipher_ctx_iv_length (const mbedtls_cipher_context_t *ctx)
-{
-  return mbedtls_cipher_get_iv_size(ctx);
-}
-
-int cipher_ctx_get_tag (cipher_ctx_t *ctx, uint8_t* tag, int tag_len)
-{
-#ifdef HAVE_AEAD_CIPHER_MODES
-  if (tag_len > SIZE_MAX)
-    return 0;
-
-  if (!mbed_ok (mbedtls_cipher_write_tag (ctx, (unsigned char *) tag, tag_len)))
-    return 0;
-
-  return 1;
-#else
-  ASSERT(0);
-#endif /* HAVE_AEAD_CIPHER_MODES */
-}
-
-int cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)
-{
-  return mbedtls_cipher_get_block_size(ctx);
-}
-
-int cipher_ctx_mode (const mbedtls_cipher_context_t *ctx)
-{
-  ASSERT(NULL != ctx);
-
-  return cipher_kt_mode(ctx->cipher_info);
-}
-
-const cipher_kt_t *
-cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx)
-{
-  return ctx ? ctx->cipher_info : NULL;
-}
-
-int cipher_ctx_reset (mbedtls_cipher_context_t *ctx, uint8_t *iv_buf)
-{
-  if (!mbed_ok(mbedtls_cipher_reset(ctx)))
-    return 0;
-
-  if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, ctx->cipher_info->iv_size)))
-    return 0;
-
-  return 1;
-}
-
-int cipher_ctx_update_ad (cipher_ctx_t *ctx, const uint8_t *src, int src_len)
-{
-#ifdef HAVE_AEAD_CIPHER_MODES
-  if (src_len > SIZE_MAX)
-    return 0;
-
-  if (!mbed_ok (mbedtls_cipher_update_ad (ctx, src, src_len)))
-    return 0;
-
-  return 1;
-#else
-  ASSERT(0);
-#endif /* HAVE_AEAD_CIPHER_MODES */
-}
-
-int cipher_ctx_update (mbedtls_cipher_context_t *ctx, uint8_t *dst,
-    int *dst_len, uint8_t *src, int src_len)
-{
-  size_t s_dst_len = *dst_len;
-
-  if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t) src_len, dst,
-      &s_dst_len)))
-    return 0;
-
-  *dst_len = s_dst_len;
-
-  return 1;
-}
-
-int cipher_ctx_final (mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len)
-{
-  size_t s_dst_len = *dst_len;
-
-  if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &s_dst_len)))
-    return 0;
-
-  *dst_len = s_dst_len;
-
-  return 1;
-}
-
-int cipher_ctx_final_check_tag (mbedtls_cipher_context_t *ctx, uint8_t *dst,
-    int *dst_len, uint8_t *tag, size_t tag_len)
-{
-#ifdef HAVE_AEAD_CIPHER_MODES
-  size_t olen = 0;
-
-  if (MBEDTLS_DECRYPT != ctx->operation)
-    return 0;
-
-  if (tag_len > SIZE_MAX)
-    return 0;
-
-  if (!mbed_ok (mbedtls_cipher_finish (ctx, dst, &olen)))
-    {
-      msg (D_CRYPT_ERRORS, "%s: cipher_ctx_final() failed", __func__);
-      return 0;
-    }
-
-  if (olen > INT_MAX)
-    return 0;
-  *dst_len = olen;
-
-  if (!mbed_ok (mbedtls_cipher_check_tag (ctx, (const unsigned char *) tag,
-      tag_len)))
-    return 0;
-
-  return 1;
-#else
-  ASSERT(0);
-#endif /* HAVE_AEAD_CIPHER_MODES */
-}
-
-void
-cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
-    unsigned char *src,
-    unsigned char *dst)
-{
-  mbedtls_des_context ctx;
-
-  ASSERT (mbed_ok(mbedtls_des_setkey_enc(&ctx, key)));
-  ASSERT (mbed_ok(mbedtls_des_crypt_ecb(&ctx, src, dst)));
-}
-
-
-
-/*
- *
- * Generic message digest information functions
- *
- */
-
-
-const mbedtls_md_info_t *
-md_kt_get (const char *digest)
-{
-  const mbedtls_md_info_t *md = NULL;
-  ASSERT (digest);
-
-  md = mbedtls_md_info_from_string(digest);
-  if (!md)
-    msg (M_FATAL, "Message hash algorithm '%s' not found", digest);
-  if (mbedtls_md_get_size(md) > MAX_HMAC_KEY_LENGTH)
-    msg (M_FATAL, "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum hash size (%d bytes)",
-	 digest,
-	 mbedtls_md_get_size(md),
-	 MAX_HMAC_KEY_LENGTH);
-  return md;
-}
-
-const char *
-md_kt_name (const mbedtls_md_info_t *kt)
-{
-  if (NULL == kt)
-    return "[null-digest]";
-  return mbedtls_md_get_name (kt);
-}
-
-int
-md_kt_size (const mbedtls_md_info_t *kt)
-{
-  if (NULL == kt)
-    return 0;
-  return mbedtls_md_get_size(kt);
-}
-
-/*
- *
- * Generic message digest functions
- *
- */
-
-int
-md_full (const md_kt_t *kt, const uint8_t *src, int src_len, uint8_t *dst)
-{
-  return 0 == mbedtls_md(kt, src, src_len, dst);
-}
-
-
-void
-md_ctx_init (mbedtls_md_context_t *ctx, const mbedtls_md_info_t *kt)
-{
-  ASSERT(NULL != ctx && NULL != kt);
-
-  mbedtls_md_init(ctx);
-  ASSERT(0 == mbedtls_md_setup(ctx, kt, 0));
-  ASSERT(0 == mbedtls_md_starts(ctx));
-}
-
-void
-md_ctx_cleanup(mbedtls_md_context_t *ctx)
-{
-}
-
-int
-md_ctx_size (const mbedtls_md_context_t *ctx)
-{
-  if (NULL == ctx)
-    return 0;
-  return mbedtls_md_get_size(ctx->md_info);
-}
-
-void
-md_ctx_update (mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
-{
-  ASSERT(0 == mbedtls_md_update(ctx, src, src_len));
-}
-
-void
-md_ctx_final (mbedtls_md_context_t *ctx, uint8_t *dst)
-{
-  ASSERT(0 == mbedtls_md_finish(ctx, dst));
-  mbedtls_md_free(ctx);
-}
-
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
-void
-hmac_ctx_init (mbedtls_md_context_t *ctx, const uint8_t *key, int key_len,
-    const mbedtls_md_info_t *kt)
-{
-  ASSERT(NULL != kt && NULL != ctx);
-
-  mbedtls_md_init(ctx);
-  ASSERT(0 == mbedtls_md_setup(ctx, kt, 1));
-  ASSERT(0 == mbedtls_md_hmac_starts(ctx, key, key_len));
-
-  /* make sure we used a big enough key */
-  ASSERT (mbedtls_md_get_size(kt) <= key_len);
-}
-
-void
-hmac_ctx_cleanup(mbedtls_md_context_t *ctx)
-{
-  mbedtls_md_free(ctx);
-}
-
-int
-hmac_ctx_size (const mbedtls_md_context_t *ctx)
-{
-  if (NULL == ctx)
-    return 0;
-  return mbedtls_md_get_size(ctx->md_info);
-}
-
-void
-hmac_ctx_reset (mbedtls_md_context_t *ctx)
-{
-  ASSERT(0 == mbedtls_md_hmac_reset(ctx));
-}
-
-void
-hmac_ctx_update (mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
-{
-  ASSERT(0 == mbedtls_md_hmac_update(ctx, src, src_len));
-}
-
-void
-hmac_ctx_final (mbedtls_md_context_t *ctx, uint8_t *dst)
-{
-  ASSERT(0 == mbedtls_md_hmac_finish(ctx, dst));
-}
-
-#endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
deleted file mode 100644
index 574a63f..0000000
--- a/src/openvpn/crypto_polarssl.h
+++ /dev/null
@@ -1,146 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/**
- * @file Data Channel Cryptography mbed TLS-specific backend interface
- */
-
-#ifndef CRYPTO_MBEDTLS_H_
-#define CRYPTO_MBEDTLS_H_
-
-#include <mbedtls/cipher.h>
-#include <mbedtls/md.h>
-#include <mbedtls/ctr_drbg.h>
-
-/** Generic cipher key type %context. */
-typedef mbedtls_cipher_info_t cipher_kt_t;
-
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
-/** Maximum length of an IV */
-#define OPENVPN_MAX_IV_LENGTH 	MBEDTLS_MAX_IV_LENGTH
-
-/** Cipher is in CBC mode */
-#define OPENVPN_MODE_CBC 	MBEDTLS_MODE_CBC
-
-/** Cipher is in OFB mode */
-#define OPENVPN_MODE_OFB 	MBEDTLS_MODE_OFB
-
-/** Cipher is in CFB mode */
-#define OPENVPN_MODE_CFB 	MBEDTLS_MODE_CFB
-
-/** Cipher is in GCM mode */
-#define OPENVPN_MODE_GCM	MBEDTLS_MODE_GCM
-
-/** Cipher should encrypt */
-#define OPENVPN_OP_ENCRYPT 	MBEDTLS_ENCRYPT
-
-/** Cipher should decrypt */
-#define OPENVPN_OP_DECRYPT 	MBEDTLS_DECRYPT
-
-#define MD4_DIGEST_LENGTH 	16
-#define MD5_DIGEST_LENGTH 	16
-#define SHA_DIGEST_LENGTH 	20
-#define DES_KEY_LENGTH 8
-
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
-mbedtls_ctr_drbg_context *rand_ctx_get();
-
-#ifdef ENABLE_PREDICTION_RESISTANCE
-/**
- * Enable prediction resistance on the random number generator.
- */
-void rand_ctx_enable_prediction_resistance();
-#endif
-
-/**
- * Log the supplied mbed TLS error, prefixed by supplied prefix.
- *
- * @param flags		Flags to indicate error type and priority.
- * @param errval	mbed TLS error code to convert to error message.
- * @param prefix	Prefix to mbed TLS error message.
- *
- * @returns true if no errors are detected, false otherwise.
- */
-bool mbed_log_err(unsigned int flags, int errval, const char *prefix);
-
-/**
- * Log the supplied mbed TLS error, prefixed by function name and line number.
- *
- * @param flags		Flags to indicate error type and priority.
- * @param errval	mbed TLS error code to convert to error message.
- * @param func		Function name where error was reported.
- * @param line		Line number where error was reported.
- *
- * @returns true if no errors are detected, false otherwise.
- */
-bool mbed_log_func_line(unsigned int flags, int errval, const char *func,
-    int line);
-
-/** Wraps mbed_log_func_line() to prevent function calls for non-errors */
-static inline bool mbed_log_func_line_lite(unsigned int flags, int errval,
-    const char *func, int line) {
-  if (errval) {
-    return mbed_log_func_line (flags, errval, func, line);
-  }
-  return true;
-}
-
-/**
- * Check errval and log on error.
- *
- * Convenience wrapper to put around mbed TLS library calls, e.g.
- *   if (!mbed_ok (mbedtls_ssl_func())) return 0;
- * or
- *   ASSERT (mbed_ok (mbedtls_ssl_func()));
- *
- * @param errval	mbed TLS error code to convert to error message.
- *
- * @returns true if no errors are detected, false otherwise.
- */
-#define mbed_ok(errval) \
-  mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
-
-
-#endif /* CRYPTO_MBEDTLS_H_ */
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
new file mode 100644
index 0000000..e208b61
--- /dev/null
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -0,0 +1,129 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file PKCS #11 mbed TLS backend
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#if defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_MBEDTLS)
+
+#include "errlevel.h"
+#include "pkcs11_backend.h"
+#include <mbedtls/pkcs11.h>
+#include <mbedtls/x509.h>
+
+int
+pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
+    struct tls_root_ctx * const ssl_ctx)
+{
+  int ret = 1;
+
+  ASSERT (NULL != ssl_ctx);
+
+  ALLOC_OBJ_CLEAR (ssl_ctx->crt_chain, mbedtls_x509_crt);
+  if (mbedtls_pkcs11_x509_cert_bind(ssl_ctx->crt_chain, certificate)) {
+      msg (M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
+      goto cleanup;
+  }
+
+  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key_pkcs11, mbedtls_pkcs11_context);
+  if (mbedtls_pkcs11_priv_key_bind(ssl_ctx->priv_key_pkcs11, certificate)) {
+      msg (M_FATAL, "PKCS#11: Cannot initialize mbed TLS private key object");
+      goto cleanup;
+  }
+
+  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key, mbedtls_pk_context);
+  if (!mbed_ok(mbedtls_pk_setup_rsa_alt(ssl_ctx->priv_key,
+      ssl_ctx->priv_key_pkcs11, mbedtls_ssl_pkcs11_decrypt,
+      mbedtls_ssl_pkcs11_sign, mbedtls_ssl_pkcs11_key_len))) {
+      goto cleanup;
+  }
+
+  ret = 0;
+
+cleanup:
+  return ret;
+}
+
+char *
+pkcs11_certificate_dn (pkcs11h_certificate_t cert, struct gc_arena *gc)
+{
+  char *ret = NULL;
+  char dn[1024] = {0};
+
+  mbedtls_x509_crt mbed_crt = {0};
+
+  if (mbedtls_pkcs11_x509_cert_bind(&mbed_crt, cert)) {
+      msg (M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
+      goto cleanup;
+  }
+
+  if (-1 == mbedtls_x509_dn_gets (dn, sizeof(dn), &mbed_crt.subject)) {
+      msg (M_FATAL, "PKCS#11: mbed TLS cannot parse subject");
+      goto cleanup;
+  }
+
+  ret = string_alloc(dn, gc);
+
+cleanup:
+  mbedtls_x509_crt_free(&mbed_crt);
+
+  return ret;
+}
+
+int
+pkcs11_certificate_serial (pkcs11h_certificate_t cert, char *serial,
+    size_t serial_len)
+{
+  int ret = 1;
+
+  mbedtls_x509_crt mbed_crt = {0};
+
+  if (mbedtls_pkcs11_x509_cert_bind(&mbed_crt, cert)) {
+      msg (M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
+      goto cleanup;
+  }
+
+  if (-1 == mbedtls_x509_serial_gets (serial, serial_len, &mbed_crt.serial)) {
+      msg (M_FATAL, "PKCS#11: mbed TLS cannot parse serial");
+      goto cleanup;
+  }
+
+  ret = 0;
+
+cleanup:
+  mbedtls_x509_crt_free(&mbed_crt);
+
+  return ret;
+}
+#endif /* defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/pkcs11_polarssl.c b/src/openvpn/pkcs11_polarssl.c
deleted file mode 100644
index e208b61..0000000
--- a/src/openvpn/pkcs11_polarssl.c
+++ /dev/null
@@ -1,129 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/**
- * @file PKCS #11 mbed TLS backend
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-
-#include "syshead.h"
-
-#if defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_MBEDTLS)
-
-#include "errlevel.h"
-#include "pkcs11_backend.h"
-#include <mbedtls/pkcs11.h>
-#include <mbedtls/x509.h>
-
-int
-pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
-    struct tls_root_ctx * const ssl_ctx)
-{
-  int ret = 1;
-
-  ASSERT (NULL != ssl_ctx);
-
-  ALLOC_OBJ_CLEAR (ssl_ctx->crt_chain, mbedtls_x509_crt);
-  if (mbedtls_pkcs11_x509_cert_bind(ssl_ctx->crt_chain, certificate)) {
-      msg (M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
-      goto cleanup;
-  }
-
-  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key_pkcs11, mbedtls_pkcs11_context);
-  if (mbedtls_pkcs11_priv_key_bind(ssl_ctx->priv_key_pkcs11, certificate)) {
-      msg (M_FATAL, "PKCS#11: Cannot initialize mbed TLS private key object");
-      goto cleanup;
-  }
-
-  ALLOC_OBJ_CLEAR (ssl_ctx->priv_key, mbedtls_pk_context);
-  if (!mbed_ok(mbedtls_pk_setup_rsa_alt(ssl_ctx->priv_key,
-      ssl_ctx->priv_key_pkcs11, mbedtls_ssl_pkcs11_decrypt,
-      mbedtls_ssl_pkcs11_sign, mbedtls_ssl_pkcs11_key_len))) {
-      goto cleanup;
-  }
-
-  ret = 0;
-
-cleanup:
-  return ret;
-}
-
-char *
-pkcs11_certificate_dn (pkcs11h_certificate_t cert, struct gc_arena *gc)
-{
-  char *ret = NULL;
-  char dn[1024] = {0};
-
-  mbedtls_x509_crt mbed_crt = {0};
-
-  if (mbedtls_pkcs11_x509_cert_bind(&mbed_crt, cert)) {
-      msg (M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
-      goto cleanup;
-  }
-
-  if (-1 == mbedtls_x509_dn_gets (dn, sizeof(dn), &mbed_crt.subject)) {
-      msg (M_FATAL, "PKCS#11: mbed TLS cannot parse subject");
-      goto cleanup;
-  }
-
-  ret = string_alloc(dn, gc);
-
-cleanup:
-  mbedtls_x509_crt_free(&mbed_crt);
-
-  return ret;
-}
-
-int
-pkcs11_certificate_serial (pkcs11h_certificate_t cert, char *serial,
-    size_t serial_len)
-{
-  int ret = 1;
-
-  mbedtls_x509_crt mbed_crt = {0};
-
-  if (mbedtls_pkcs11_x509_cert_bind(&mbed_crt, cert)) {
-      msg (M_FATAL, "PKCS#11: Cannot retrieve mbed TLS certificate object");
-      goto cleanup;
-  }
-
-  if (-1 == mbedtls_x509_serial_gets (serial, serial_len, &mbed_crt.serial)) {
-      msg (M_FATAL, "PKCS#11: mbed TLS cannot parse serial");
-      goto cleanup;
-  }
-
-  ret = 0;
-
-cleanup:
-  mbedtls_x509_crt_free(&mbed_crt);
-
-  return ret;
-}
-#endif /* defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 74ac8b1..3c01047 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -33,7 +33,7 @@
 #include "ssl_verify_openssl.h"
 #endif
 #ifdef ENABLE_CRYPTO_MBEDTLS
-#include "ssl_verify_polarssl.h"
+#include "ssl_verify_mbedtls.h"
 #endif
 #include "openvpn-plugin.h"
 
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index dfccb44..542c373 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -39,8 +39,8 @@
 #define SSLAPI SSLAPI_OPENSSL
 #endif
 #ifdef ENABLE_CRYPTO_MBEDTLS
-#include "ssl_polarssl.h"
-#include "ssl_verify_polarssl.h"
+#include "ssl_mbedtls.h"
+#include "ssl_verify_mbedtls.h"
 #define SSLAPI SSLAPI_MBEDTLS
 #endif
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
new file mode 100644
index 0000000..9da33ad
--- /dev/null
+++ b/src/openvpn/ssl_mbedtls.c
@@ -0,0 +1,1184 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2006-2010, Brainspark B.V.
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file Control Channel mbed TLS Backend
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
+
+#include "errlevel.h"
+#include "ssl_backend.h"
+#include "base64.h"
+#include "buffer.h"
+#include "misc.h"
+#include "manage.h"
+#include "ssl_common.h"
+
+#include <mbedtls/havege.h>
+
+#include "ssl_verify_mbedtls.h"
+#include <mbedtls/debug.h>
+#include <mbedtls/error.h>
+#include <mbedtls/net.h>
+#include <mbedtls/oid.h>
+#include <mbedtls/pem.h>
+#include <mbedtls/sha256.h>
+#include <mbedtls/version.h>
+
+void
+tls_init_lib()
+{
+}
+
+void
+tls_free_lib()
+{
+}
+
+void
+tls_clear_error()
+{
+}
+
+void
+tls_ctx_server_new(struct tls_root_ctx *ctx)
+{
+  ASSERT(NULL != ctx);
+  CLEAR(*ctx);
+
+  ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
+
+  ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
+
+  ctx->endpoint = MBEDTLS_SSL_IS_SERVER;
+  ctx->initialised = true;
+}
+
+void
+tls_ctx_client_new(struct tls_root_ctx *ctx)
+{
+  ASSERT(NULL != ctx);
+  CLEAR(*ctx);
+
+  ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
+  ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
+
+  ctx->endpoint = MBEDTLS_SSL_IS_CLIENT;
+  ctx->initialised = true;
+}
+
+void
+tls_ctx_free(struct tls_root_ctx *ctx)
+{
+  if (ctx)
+    {
+      mbedtls_pk_free(ctx->priv_key);
+      if (ctx->priv_key)
+	free(ctx->priv_key);
+
+      mbedtls_x509_crt_free(ctx->ca_chain);
+      if (ctx->ca_chain)
+	free(ctx->ca_chain);
+
+      mbedtls_x509_crt_free(ctx->crt_chain);
+      if (ctx->crt_chain)
+	free(ctx->crt_chain);
+
+      mbedtls_dhm_free(ctx->dhm_ctx);
+      if (ctx->dhm_ctx)
+	free(ctx->dhm_ctx);
+
+#if defined(ENABLE_PKCS11)
+      if (ctx->priv_key_pkcs11 != NULL) {
+	  mbedtls_pkcs11_priv_key_free(ctx->priv_key_pkcs11);
+	  free(ctx->priv_key_pkcs11);
+      }
+#endif
+#if defined(MANAGMENT_EXTERNAL_KEY)
+      if (ctx->external_key != NULL)
+          free(ctx->external_key);
+#endif
+
+      if (ctx->allowed_ciphers)
+	free(ctx->allowed_ciphers);
+
+      CLEAR(*ctx);
+
+      ctx->initialised = false;
+
+    }
+}
+
+bool
+tls_ctx_initialised(struct tls_root_ctx *ctx)
+{
+  ASSERT(NULL != ctx);
+  return ctx->initialised;
+}
+
+void
+key_state_export_keying_material(struct key_state_ssl *ssl,
+                                 struct tls_session *session)
+{
+}
+
+void
+tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
+{
+}
+
+static const char *
+tls_translate_cipher_name (const char * cipher_name) {
+  const tls_cipher_name_pair * pair = tls_get_cipher_name_pair(cipher_name, strlen(cipher_name));
+
+  if (NULL == pair)
+    {
+      // No translation found, return original
+      return cipher_name;
+    }
+
+  if (0 != strcmp(cipher_name, pair->iana_name))
+    {
+      // Deprecated name found, notify user
+      msg(M_WARN, "Deprecated cipher suite name '%s', please use IANA name '%s'", pair->openssl_name, pair->iana_name);
+    }
+
+  return pair->iana_name;
+}
+
+void
+tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
+{
+  char *tmp_ciphers, *tmp_ciphers_orig, *token;
+  int i, cipher_count;
+  int ciphers_len;
+
+  if (NULL == ciphers)
+    return; /* Nothing to do */
+
+  ciphers_len = strlen (ciphers);
+
+  ASSERT (NULL != ctx);
+  ASSERT (0 != ciphers_len);
+
+  /* Get number of ciphers */
+  for (i = 0, cipher_count = 1; i < ciphers_len; i++)
+    if (ciphers[i] == ':')
+      cipher_count++;
+
+  /* Allocate an array for them */
+  ALLOC_ARRAY_CLEAR(ctx->allowed_ciphers, int, cipher_count+1)
+
+  /* Parse allowed ciphers, getting IDs */
+  i = 0;
+  tmp_ciphers_orig = tmp_ciphers = string_alloc (ciphers, NULL);
+
+  token = strtok (tmp_ciphers, ":");
+  while(token)
+    {
+      ctx->allowed_ciphers[i] = mbedtls_ssl_get_ciphersuite_id (
+	  tls_translate_cipher_name (token));
+      if (0 != ctx->allowed_ciphers[i])
+	i++;
+      token = strtok (NULL, ":");
+    }
+  free(tmp_ciphers_orig);
+}
+
+void
+tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
+{
+  ASSERT (ctx);
+  if (ctx->crt_chain == NULL)
+    {
+      return; /* Nothing to check if there is no certificate */
+    }
+
+  if (mbedtls_x509_time_is_future (&ctx->crt_chain->valid_from))
+    {
+      msg (M_WARN, "WARNING: Your certificate is not yet valid!");
+    }
+
+  if (mbedtls_x509_time_is_past (&ctx->crt_chain->valid_to))
+    {
+      msg (M_WARN, "WARNING: Your certificate has expired!");
+    }
+}
+
+void
+tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
+    const char *dh_inline
+    )
+{
+  if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_inline)
+    {
+      if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx->dhm_ctx,
+	  (const unsigned char *) dh_inline, strlen(dh_inline)+1)))
+	msg (M_FATAL, "Cannot read inline DH parameters");
+  }
+else
+  {
+    if (!mbed_ok(mbedtls_dhm_parse_dhmfile(ctx->dhm_ctx, dh_file)))
+      msg (M_FATAL, "Cannot read DH parameters from file %s", dh_file);
+  }
+
+  msg (D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with " counter_format " bit key",
+      (counter_type) 8 * mbedtls_mpi_size(&ctx->dhm_ctx->P));
+}
+
+void
+tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char *curve_name
+    )
+{
+    if (NULL != curve_name)
+      msg(M_WARN, "WARNING: mbed TLS builds do not support specifying an ECDH "
+                  "curve, using default curves.");
+}
+
+int
+tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
+    const char *pkcs12_file_inline,
+    bool load_ca_file
+    )
+{
+  msg(M_FATAL, "PKCS #12 files not yet supported for mbed TLS.");
+  return 0;
+}
+
+#ifdef ENABLE_CRYPTOAPI
+void
+tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
+{
+  msg(M_FATAL, "Windows CryptoAPI not yet supported for mbed TLS.");
+}
+#endif /* WIN32 */
+
+void
+tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
+    const char *cert_inline
+    )
+{
+  ASSERT(NULL != ctx);
+
+  if (!ctx->crt_chain)
+    {
+      ALLOC_OBJ_CLEAR(ctx->crt_chain, mbedtls_x509_crt);
+    }
+
+  if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_inline)
+    {
+      if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain,
+	  (const unsigned char *) cert_inline, strlen(cert_inline)+1)))
+        msg (M_FATAL, "Cannot load inline certificate file");
+    }
+  else
+    {
+      if (!mbed_ok(mbedtls_x509_crt_parse_file(ctx->crt_chain, cert_file)))
+	{
+	  msg (M_FATAL, "Cannot load certificate file %s", cert_file);
+	}
+    }
+}
+
+int
+tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
+    const char *priv_key_inline
+    )
+{
+  int status;
+  ASSERT(NULL != ctx);
+
+  if (!ctx->priv_key)
+    {
+      ALLOC_OBJ_CLEAR(ctx->priv_key, mbedtls_pk_context);
+    }
+
+  if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_inline)
+    {
+      status = mbedtls_pk_parse_key(ctx->priv_key,
+	  (const unsigned char *) priv_key_inline, strlen(priv_key_inline)+1,
+	  NULL, 0);
+
+      if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
+	{
+	  char passbuf[512] = {0};
+	  pem_password_callback(passbuf, 512, 0, NULL);
+	  status = mbedtls_pk_parse_key(ctx->priv_key,
+	      (const unsigned char *) priv_key_inline,
+	      strlen(priv_key_inline)+1, (unsigned char *) passbuf,
+	      strlen(passbuf));
+	}
+    }
+  else
+    {
+      status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);
+      if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
+	{
+	  char passbuf[512] = {0};
+	  pem_password_callback(passbuf, 512, 0, NULL);
+	  status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
+	}
+    }
+  if (!mbed_ok(status))
+    {
+#ifdef ENABLE_MANAGEMENT
+      if (management && (MBEDTLS_ERR_PK_PASSWORD_MISMATCH == status))
+	  management_auth_failure (management, UP_TYPE_PRIVATE_KEY, NULL);
+#endif
+      msg (M_WARN, "Cannot load private key file %s", priv_key_file);
+      return 1;
+    }
+
+  warn_if_group_others_accessible (priv_key_file);
+
+  /* TODO: Check Private Key */
+#if 0
+  if (!SSL_CTX_check_private_key (ctx))
+    msg (M_SSLERR, "Private key does not match the certificate");
+#endif
+  return 0;
+}
+
+#ifdef MANAGMENT_EXTERNAL_KEY
+
+
+struct external_context {
+  size_t signature_length;
+};
+
+/**
+ * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that uses
+ * the management interface to request an RSA signature for the supplied hash.
+ *
+ * @param ctx_voidptr   Management external key context.
+ * @param f_rng         (Unused)
+ * @param p_rng         (Unused)
+ * @param mode          RSA mode (should be RSA_PRIVATE).
+ * @param md_alg        Message digest ('hash') algorithm type.
+ * @param hashlen       Length of hash (overridden by length specified by md_alg
+ *                      if md_alg != MBEDTLS_MD_NONE).
+ * @param hash          The digest ('hash') to sign. Should have a size
+ *                      matching the length of md_alg (if != MBEDTLS_MD_NONE),
+ *                      or hashlen otherwise.
+ * @param sig           Buffer that returns the signature. Should be at least of
+ *                      size ctx->signature_length.
+ *
+ * @return 0 on success, non-zero mbed TLS error code on failure.
+ */
+static inline int external_pkcs1_sign( void *ctx_voidptr,
+    int (*f_rng)(void *, unsigned char *, size_t), void *p_rng, int mode,
+    mbedtls_md_type_t md_alg, unsigned int hashlen, const unsigned char *hash,
+    unsigned char *sig )
+{
+  struct external_context * const ctx = ctx_voidptr;
+  char *in_b64 = NULL;
+  char *out_b64 = NULL;
+  int rv;
+  unsigned char *p = sig;
+  size_t asn_len = 0, oid_size = 0, sig_len = 0;
+  const char *oid = NULL;
+
+  if( NULL == ctx )
+    return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
+
+  if( MBEDTLS_RSA_PRIVATE != mode )
+    return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
+
+  /*
+   * Support a wide range of hashes. TLSv1.1 and before only need SIG_RSA_RAW,
+   * but TLSv1.2 needs the full suite of hashes.
+   *
+   * This code has been taken from mbed TLS pkcs11_sign(), under the GPLv2.0+.
+   */
+  if( md_alg != MBEDTLS_MD_NONE )
+    {
+      const mbedtls_md_info_t *md_info = mbedtls_md_info_from_type( md_alg );
+      if( md_info == NULL )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+      if (!mbed_ok(mbedtls_oid_get_oid_by_md( md_alg, &oid, &oid_size )))
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+      hashlen = mbedtls_md_get_size( md_info );
+      asn_len = 10 + oid_size;
+    }
+
+  sig_len = ctx->signature_length;
+  if ( (SIZE_MAX - hashlen) < asn_len || (hashlen + asn_len) > sig_len )
+    return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
+
+  if( md_alg != MBEDTLS_MD_NONE )
+    {
+      /*
+       * DigestInfo ::= SEQUENCE {
+       *   digestAlgorithm DigestAlgorithmIdentifier,
+       *   digest Digest }
+       *
+       * DigestAlgorithmIdentifier ::= AlgorithmIdentifier
+       *
+       * Digest ::= OCTET STRING
+       */
+      *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
+      *p++ = (unsigned char) ( 0x08 + oid_size + hashlen );
+      *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
+      *p++ = (unsigned char) ( 0x04 + oid_size );
+      *p++ = MBEDTLS_ASN1_OID;
+      *p++ = oid_size & 0xFF;
+      memcpy( p, oid, oid_size );
+      p += oid_size;
+      *p++ = MBEDTLS_ASN1_NULL;
+      *p++ = 0x00;
+      *p++ = MBEDTLS_ASN1_OCTET_STRING;
+      *p++ = hashlen;
+
+      /* Determine added ASN length */
+      asn_len = p - sig;
+  }
+
+  /* Copy the hash to be signed */
+  memcpy( p, hash, hashlen );
+
+  /* convert 'from' to base64 */
+  if (openvpn_base64_encode (sig, asn_len + hashlen, &in_b64) <= 0)
+    {
+      rv = MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
+      goto done;
+    }
+
+  /* call MI for signature */
+  if (management)
+    out_b64 = management_query_rsa_sig (management, in_b64);
+  if (!out_b64)
+    {
+      rv = MBEDTLS_ERR_RSA_PRIVATE_FAILED;
+      goto done;
+    }
+
+  /* decode base64 signature to binary and verify length */
+  if ( openvpn_base64_decode (out_b64, sig, ctx->signature_length) !=
+       ctx->signature_length )
+    {
+      rv = MBEDTLS_ERR_RSA_PRIVATE_FAILED;
+      goto done;
+    }
+
+  rv = 0;
+
+done:
+  if (in_b64)
+    free (in_b64);
+  if (out_b64)
+    free (out_b64);
+  return rv;
+}
+
+static inline size_t external_key_len(void *vctx)
+{
+  struct external_context * const ctx = vctx;
+
+  return ctx->signature_length;
+}
+
+int
+tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
+    const char *cert_file, const char *cert_file_inline)
+{
+  ASSERT(NULL != ctx);
+
+  tls_ctx_load_cert_file(ctx, cert_file, cert_file_inline);
+
+  if (ctx->crt_chain == NULL)
+    return 0;
+
+  ALLOC_OBJ_CLEAR (ctx->external_key, struct external_context);
+  ctx->external_key->signature_length = mbedtls_pk_get_len (&ctx->crt_chain->pk);
+
+  ALLOC_OBJ_CLEAR (ctx->priv_key, mbedtls_pk_context);
+  if (!mbed_ok (mbedtls_pk_setup_rsa_alt (ctx->priv_key, ctx->external_key,
+	    NULL, external_pkcs1_sign, external_key_len)))
+    return 0;
+
+  return 1;
+}
+#endif
+
+void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
+    const char *ca_inline, const char *ca_path, bool tls_server
+    )
+{
+  if (ca_path)
+      msg(M_FATAL, "ERROR: mbed TLS cannot handle the capath directive");
+
+  if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_inline)
+    {
+      if (!mbed_ok (mbedtls_x509_crt_parse (ctx->ca_chain,
+	  (const unsigned char *) ca_inline, strlen(ca_inline)+1)))
+	msg (M_FATAL, "Cannot load inline CA certificates");
+    }
+  else
+    {
+      /* Load CA file for verifying peer supplied certificate */
+      if (!mbed_ok (mbedtls_x509_crt_parse_file (ctx->ca_chain, ca_file)))
+	msg (M_FATAL, "Cannot load CA certificate file %s", ca_file);
+    }
+}
+
+void
+tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file,
+    const char *extra_certs_inline
+    )
+{
+  ASSERT(NULL != ctx);
+
+  if (!ctx->crt_chain)
+    {
+      ALLOC_OBJ_CLEAR (ctx->crt_chain, mbedtls_x509_crt);
+    }
+
+  if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_inline)
+    {
+      if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain,
+          (const unsigned char *) extra_certs_inline,
+	  strlen(extra_certs_inline)+1)))
+        msg (M_FATAL, "Cannot load inline extra-certs file");
+    }
+  else
+    {
+      if (!mbed_ok(mbedtls_x509_crt_parse_file(ctx->crt_chain, extra_certs_file)))
+	msg (M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
+    }
+}
+
+/* **************************************
+ *
+ * Key-state specific functions
+ *
+ ***************************************/
+
+/*
+ * "Endless buffer"
+ */
+
+static inline void buf_free_entry(buffer_entry *entry)
+{
+  if (NULL != entry)
+    {
+      free(entry->data);
+      free(entry);
+    }
+}
+
+static void buf_free_entries(endless_buffer *buf)
+{
+  while(buf->first_block)
+    {
+      buffer_entry *cur_block = buf->first_block;
+      buf->first_block = cur_block->next_block;
+      buf_free_entry(cur_block);
+    }
+  buf->last_block = NULL;
+}
+
+static int endless_buf_read( endless_buffer *in, unsigned char * out, size_t out_len )
+{
+  size_t read_len = 0;
+
+  if (in->first_block == NULL)
+    return MBEDTLS_ERR_SSL_WANT_READ;
+
+  while (in->first_block != NULL && read_len < out_len)
+    {
+      int block_len = in->first_block->length - in->data_start;
+      if (block_len <= out_len - read_len)
+	{
+	  buffer_entry *cur_entry = in->first_block;
+	  memcpy(out + read_len, cur_entry->data + in->data_start,
+	      block_len);
+
+	  read_len += block_len;
+
+	  in->first_block = cur_entry->next_block;
+	  in->data_start = 0;
+
+	  if (in->first_block == NULL)
+	    in->last_block = NULL;
+
+	  buf_free_entry(cur_entry);
+	}
+      else
+	{
+	  memcpy(out + read_len, in->first_block->data + in->data_start,
+	      out_len - read_len);
+	  in->data_start += out_len - read_len;
+	  read_len = out_len;
+	}
+    }
+
+  return read_len;
+}
+
+static int endless_buf_write( endless_buffer *out, const unsigned char *in, size_t len )
+{
+  buffer_entry *new_block = malloc(sizeof(buffer_entry));
+  if (NULL == new_block)
+    return MBEDTLS_ERR_NET_SEND_FAILED;
+
+  new_block->data = malloc(len);
+  if (NULL == new_block->data)
+    {
+      free(new_block);
+      return MBEDTLS_ERR_NET_SEND_FAILED;
+    }
+
+  new_block->length = len;
+  new_block->next_block = NULL;
+
+  memcpy(new_block->data, in, len);
+
+  if (NULL == out->first_block)
+    out->first_block = new_block;
+
+  if (NULL != out->last_block)
+    out->last_block->next_block = new_block;
+
+  out->last_block = new_block;
+
+  return len;
+}
+
+static int ssl_bio_read( void *ctx, unsigned char *out, size_t out_len)
+{
+  bio_ctx *my_ctx = (bio_ctx *) ctx;
+  return endless_buf_read (&my_ctx->in, out, out_len);
+}
+
+static int ssl_bio_write( void *ctx, const unsigned char *in, size_t in_len)
+{
+  bio_ctx *my_ctx = (bio_ctx *) ctx;
+  return endless_buf_write (&my_ctx->out, in, in_len);
+}
+
+static void my_debug( void *ctx, int level, const char *file, int line,
+    const char *str )
+{
+  int my_loglevel = (level < 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;
+  msg (my_loglevel, "mbed TLS msg (%s:%d): %s", file, line, str);
+}
+
+/*
+ * Further personalise the RNG using a hash of the public key
+ */
+void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
+{
+  static char old_sha256_hash[32] = {0};
+  unsigned char sha256_hash[32] = {0};
+  mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
+
+  if (NULL != ctx->crt_chain)
+    {
+      mbedtls_x509_crt *cert = ctx->crt_chain;
+
+      mbedtls_sha256(cert->tbs.p, cert->tbs.len, sha256_hash, false);
+      if ( 0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
+	{
+	  mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32);
+	  memcpy(old_sha256_hash, sha256_hash, sizeof(old_sha256_hash));
+	}
+    }
+}
+
+int
+tls_version_max(void)
+{
+#if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_3)
+  return TLS_VER_1_2;
+#elif defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_2)
+  return TLS_VER_1_1;
+#else
+  return TLS_VER_1_0;
+#endif
+}
+
+/**
+ * Convert an OpenVPN tls-version variable to mbed TLS format (i.e. a major and
+ * minor ssl version number).
+ *
+ * @param tls_ver	The tls-version variable to convert.
+ * @param major		Returns the TLS major version in mbed TLS format.
+ * 			Must be a valid pointer.
+ * @param minor		Returns the TLS minor version in mbed TLS format.
+ * 			Must be a valid pointer.
+ */
+static void tls_version_to_major_minor(int tls_ver, int *major, int *minor) {
+  ASSERT(major);
+  ASSERT(minor);
+
+  switch (tls_ver)
+  {
+    case TLS_VER_1_0:
+      *major = MBEDTLS_SSL_MAJOR_VERSION_3;
+      *minor = MBEDTLS_SSL_MINOR_VERSION_1;
+      break;
+    case TLS_VER_1_1:
+      *major = MBEDTLS_SSL_MAJOR_VERSION_3;
+      *minor = MBEDTLS_SSL_MINOR_VERSION_2;
+      break;
+    case TLS_VER_1_2:
+      *major = MBEDTLS_SSL_MAJOR_VERSION_3;
+      *minor = MBEDTLS_SSL_MINOR_VERSION_3;
+      break;
+    default:
+      msg(M_FATAL, "%s: invalid TLS version %d", __func__, tls_ver);
+      break;
+  }
+}
+
+void key_state_ssl_init(struct key_state_ssl *ks_ssl,
+    const struct tls_root_ctx *ssl_ctx, bool is_server, struct tls_session *session)
+{
+  ASSERT(NULL != ssl_ctx);
+  ASSERT(ks_ssl);
+  CLEAR(*ks_ssl);
+
+  /* Initialise SSL config */
+  mbedtls_ssl_config_init(&ks_ssl->ssl_config);
+  mbedtls_ssl_config_defaults(&ks_ssl->ssl_config, ssl_ctx->endpoint,
+      MBEDTLS_SSL_TRANSPORT_STREAM, MBEDTLS_SSL_PRESET_DEFAULT);
+  mbedtls_debug_set_threshold(3);
+  mbedtls_ssl_conf_dbg (&ks_ssl->ssl_config, my_debug, NULL);
+  mbedtls_ssl_conf_rng (&ks_ssl->ssl_config, mbedtls_ctr_drbg_random,
+      rand_ctx_get());
+
+  if (ssl_ctx->allowed_ciphers)
+    mbedtls_ssl_conf_ciphersuites (&ks_ssl->ssl_config, ssl_ctx->allowed_ciphers);
+
+  /* Disable record splitting (for now).  OpenVPN assumes records are sent
+   * unfragmented, and changing that will require thorough review and
+   * testing.  Since OpenVPN is not susceptible to BEAST, we can just
+   * disable record splitting as a quick fix. */
+#if defined(MBEDTLS_SSL_CBC_RECORD_SPLITTING)
+  mbedtls_ssl_conf_cbc_record_splitting (&ks_ssl->ssl_config,
+      MBEDTLS_SSL_CBC_RECORD_SPLITTING_DISABLED);
+#endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */
+
+  /* Initialise authentication information */
+  if (is_server)
+    mbed_ok (mbedtls_ssl_conf_dh_param_ctx(&ks_ssl->ssl_config,
+	ssl_ctx->dhm_ctx));
+
+  mbed_ok (mbedtls_ssl_conf_own_cert(&ks_ssl->ssl_config, ssl_ctx->crt_chain,
+      ssl_ctx->priv_key));
+
+  /* Initialise SSL verification */
+#if P2MP_SERVER
+  if (session->opt->ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
+    {
+      mbedtls_ssl_conf_authmode(&ks_ssl->ssl_config, MBEDTLS_SSL_VERIFY_OPTIONAL);
+    }
+  else if (!(session->opt->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED))
+#endif
+  {
+    mbedtls_ssl_conf_authmode (&ks_ssl->ssl_config, MBEDTLS_SSL_VERIFY_REQUIRED);
+  }
+  mbedtls_ssl_conf_verify (&ks_ssl->ssl_config, verify_callback, session);
+
+  /* TODO: mbed TLS does not currently support sending the CA chain to the client */
+  mbedtls_ssl_conf_ca_chain (&ks_ssl->ssl_config, ssl_ctx->ca_chain, NULL );
+
+  /* Initialize minimum TLS version */
+  {
+    const int tls_version_min =
+	(session->opt->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) &
+	SSLF_TLS_VERSION_MIN_MASK;
+
+    /* default to TLS 1.0 */
+    int major = MBEDTLS_SSL_MAJOR_VERSION_3;
+    int minor = MBEDTLS_SSL_MINOR_VERSION_1;
+
+    if (tls_version_min > TLS_VER_UNSPEC)
+      tls_version_to_major_minor(tls_version_min, &major, &minor);
+
+    mbedtls_ssl_conf_min_version(&ks_ssl->ssl_config, major, minor);
+  }
+
+  /* Initialize maximum TLS version */
+  {
+    const int tls_version_max =
+	(session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
+	SSLF_TLS_VERSION_MAX_MASK;
+
+    if (tls_version_max > TLS_VER_UNSPEC)
+      {
+	int major, minor;
+	tls_version_to_major_minor(tls_version_max, &major, &minor);
+	mbedtls_ssl_conf_max_version(&ks_ssl->ssl_config, major, minor);
+      }
+  }
+
+  /* Initialise SSL context */
+  ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
+  mbedtls_ssl_init(ks_ssl->ctx);
+  mbedtls_ssl_setup(ks_ssl->ctx, &ks_ssl->ssl_config);
+
+  /* Initialise BIOs */
+  CLEAR (ks_ssl->bio_ctx);
+  mbedtls_ssl_set_bio (ks_ssl->ctx, &ks_ssl->bio_ctx, ssl_bio_write,
+      ssl_bio_read, NULL);
+}
+
+void
+key_state_ssl_free(struct key_state_ssl *ks_ssl)
+{
+  if (ks_ssl) {
+      if (ks_ssl->ctx)
+	{
+	  mbedtls_ssl_free(ks_ssl->ctx);
+	  free(ks_ssl->ctx);
+	}
+      mbedtls_ssl_config_free(&ks_ssl->ssl_config);
+      buf_free_entries(&ks_ssl->bio_ctx.in);
+      buf_free_entries(&ks_ssl->bio_ctx.out);
+      CLEAR(*ks_ssl);
+  }
+}
+
+int
+key_state_write_plaintext (struct key_state_ssl *ks, struct buffer *buf)
+{
+  int retval = 0;
+
+  ASSERT (buf);
+
+  retval = key_state_write_plaintext_const(ks, BPTR(buf), BLEN(buf));
+
+  if (1 == retval)
+    {
+      memset (BPTR (buf), 0, BLEN (buf)); /* erase data just written */
+      buf->len = 0;
+    }
+
+  return retval;
+}
+
+int
+key_state_write_plaintext_const (struct key_state_ssl *ks, const uint8_t *data, int len)
+{
+  int retval = 0;
+  perf_push (PERF_BIO_WRITE_PLAINTEXT);
+
+  ASSERT (NULL != ks);
+  ASSERT (len >= 0);
+
+  if (0 == len)
+    {
+      perf_pop ();
+      return 0;
+    }
+
+  ASSERT (data);
+
+  retval = mbedtls_ssl_write(ks->ctx, data, len);
+
+  if (retval < 0)
+    {
+      perf_pop ();
+      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
+	return 0;
+      mbed_log_err (D_TLS_ERRORS, retval,
+	  "TLS ERROR: write tls_write_plaintext_const error");
+      return -1;
+    }
+
+  if (retval != len)
+    {
+      msg (D_TLS_ERRORS,
+	  "TLS ERROR: write tls_write_plaintext_const incomplete %d/%d",
+	  retval, len);
+      perf_pop ();
+      return -1;
+    }
+
+  /* successful write */
+  dmsg (D_HANDSHAKE_VERBOSE, "write tls_write_plaintext_const %d bytes", retval);
+
+  perf_pop ();
+  return 1;
+}
+
+int
+key_state_read_ciphertext (struct key_state_ssl *ks, struct buffer *buf,
+    int maxlen)
+{
+  int retval = 0;
+  int len = 0;
+
+  perf_push (PERF_BIO_READ_CIPHERTEXT);
+
+  ASSERT (NULL != ks);
+  ASSERT (buf);
+  ASSERT (buf->len >= 0);
+
+  if (buf->len)
+    {
+      perf_pop ();
+      return 0;
+    }
+
+  len = buf_forward_capacity (buf);
+  if (maxlen < len)
+    len = maxlen;
+
+  retval = endless_buf_read(&ks->bio_ctx.out, BPTR(buf), len);
+
+  /* Error during read, check for retry error */
+  if (retval < 0)
+    {
+      perf_pop ();
+      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
+	return 0;
+      mbed_log_err (D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_ciphertext error");
+      buf->len = 0;
+      return -1;
+    }
+  /* Nothing read, try again */
+  if (0 == retval)
+    {
+      buf->len = 0;
+      perf_pop ();
+      return 0;
+    }
+
+  /* successful read */
+  dmsg (D_HANDSHAKE_VERBOSE, "read tls_read_ciphertext %d bytes", retval);
+  buf->len = retval;
+  perf_pop ();
+  return 1;
+}
+
+int
+key_state_write_ciphertext (struct key_state_ssl *ks, struct buffer *buf)
+{
+  int retval = 0;
+  perf_push (PERF_BIO_WRITE_CIPHERTEXT);
+
+  ASSERT (NULL != ks);
+  ASSERT (buf);
+  ASSERT (buf->len >= 0);
+
+  if (0 == buf->len)
+    {
+      perf_pop ();
+      return 0;
+    }
+
+  retval = endless_buf_write(&ks->bio_ctx.in, BPTR(buf), buf->len);
+
+  if (retval < 0)
+    {
+      perf_pop ();
+
+      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
+	return 0;
+      mbed_log_err (D_TLS_ERRORS, retval,
+	  "TLS ERROR: write tls_write_ciphertext error");
+      return -1;
+    }
+
+  if (retval != buf->len)
+    {
+      msg (D_TLS_ERRORS, "TLS ERROR: write tls_write_ciphertext incomplete %d/%d",
+	  retval, buf->len);
+      perf_pop ();
+      return -1;
+    }
+
+  /* successful write */
+  dmsg (D_HANDSHAKE_VERBOSE, "write tls_write_ciphertext %d bytes", retval);
+
+  memset (BPTR (buf), 0, BLEN (buf)); /* erase data just written */
+  buf->len = 0;
+
+  perf_pop ();
+  return 1;
+}
+
+int
+key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
+    int maxlen)
+{
+  int retval = 0;
+  int len = 0;
+
+  perf_push (PERF_BIO_READ_PLAINTEXT);
+
+  ASSERT (NULL != ks);
+  ASSERT (buf);
+  ASSERT (buf->len >= 0);
+
+  if (buf->len)
+    {
+      perf_pop ();
+      return 0;
+    }
+
+  len = buf_forward_capacity (buf);
+  if (maxlen < len)
+    len = maxlen;
+
+  retval = mbedtls_ssl_read(ks->ctx, BPTR(buf), len);
+
+  /* Error during read, check for retry error */
+  if (retval < 0)
+    {
+      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
+	return 0;
+      mbed_log_err (D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_plaintext error");
+      buf->len = 0;
+      perf_pop ();
+      return -1;
+    }
+  /* Nothing read, try again */
+  if (0 == retval)
+    {
+      buf->len = 0;
+      perf_pop ();
+      return 0;
+    }
+
+  /* successful read */
+  dmsg (D_HANDSHAKE_VERBOSE, "read tls_read_plaintext %d bytes", retval);
+  buf->len = retval;
+
+  perf_pop ();
+  return 1;
+}
+
+/* **************************************
+ *
+ * Information functions
+ *
+ * Print information for the end user.
+ *
+ ***************************************/
+void
+print_details (struct key_state_ssl * ks_ssl, const char *prefix)
+{
+  const mbedtls_x509_crt *cert;
+  char s1[256];
+  char s2[256];
+
+  s1[0] = s2[0] = 0;
+  openvpn_snprintf (s1, sizeof (s1), "%s %s, cipher %s",
+		    prefix,
+		    mbedtls_ssl_get_version (ks_ssl->ctx),
+		    mbedtls_ssl_get_ciphersuite (ks_ssl->ctx));
+
+  cert = mbedtls_ssl_get_peer_cert (ks_ssl->ctx);
+  if (cert != NULL)
+    {
+      openvpn_snprintf (s2, sizeof (s2), ", %zu bit key",
+	  mbedtls_pk_get_bitlen (&cert->pk));
+    }
+
+  msg (D_HANDSHAKE, "%s%s", s1, s2);
+}
+
+void
+show_available_tls_ciphers (const char *cipher_list)
+{
+  struct tls_root_ctx tls_ctx;
+  const int *ciphers = mbedtls_ssl_list_ciphersuites ();
+
+  tls_ctx_server_new(&tls_ctx);
+  tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
+
+  if (tls_ctx.allowed_ciphers)
+    ciphers = tls_ctx.allowed_ciphers;
+
+#ifndef ENABLE_SMALL
+  printf ("Available TLS Ciphers,\n");
+  printf ("listed in order of preference:\n\n");
+#endif
+
+  while (*ciphers != 0)
+    {
+      printf ("%s\n", mbedtls_ssl_get_ciphersuite_name (*ciphers));
+      ciphers++;
+    }
+  printf ("\n" SHOW_TLS_CIPHER_LIST_WARNING);
+
+  tls_ctx_free(&tls_ctx);
+}
+
+void
+show_available_curves (void)
+{
+  const mbedtls_ecp_curve_info *pcurve = mbedtls_ecp_curve_list ();
+
+  if (NULL == pcurve)
+    msg (M_FATAL, "Cannot retrieve curve list from mbed TLS");
+
+  /* Print curve list */
+  printf ("Available Elliptic curves, listed in order of preference:\n\n");
+  while (MBEDTLS_ECP_DP_NONE != pcurve->grp_id)
+    {
+      printf("%s\n", pcurve->name);
+      pcurve++;
+    }
+}
+
+void
+get_highest_preference_tls_cipher (char *buf, int size)
+{
+  const char *cipher_name;
+  const int *ciphers = mbedtls_ssl_list_ciphersuites();
+  if (*ciphers == 0)
+    msg (M_FATAL, "Cannot retrieve list of supported SSL ciphers.");
+
+  cipher_name = mbedtls_ssl_get_ciphersuite_name(*ciphers);
+  strncpynt (buf, cipher_name, size);
+}
+
+const char *
+get_ssl_library_version(void)
+{
+    static char mbedtls_version[30];
+    unsigned int pv = mbedtls_version_get_number();
+    sprintf( mbedtls_version, "mbed TLS %d.%d.%d",
+		(pv>>24)&0xff, (pv>>16)&0xff, (pv>>8)&0xff );
+    return mbedtls_version;
+}
+
+#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
new file mode 100644
index 0000000..6f778ef
--- /dev/null
+++ b/src/openvpn/ssl_mbedtls.h
@@ -0,0 +1,92 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file Control Channel mbed TLS Backend
+ */
+
+#ifndef SSL_MBEDTLS_H_
+#define SSL_MBEDTLS_H_
+
+#include "syshead.h"
+
+#include <mbedtls/ssl.h>
+#include <mbedtls/x509_crt.h>
+
+#if defined(ENABLE_PKCS11)
+#include <mbedtls/pkcs11.h>
+#endif
+
+typedef struct _buffer_entry buffer_entry;
+
+struct _buffer_entry {
+    size_t length;
+    uint8_t *data;
+    buffer_entry *next_block;
+};
+
+typedef struct {
+    size_t data_start;
+    buffer_entry *first_block;
+    buffer_entry *last_block;
+} endless_buffer;
+
+typedef struct {
+    endless_buffer in;
+    endless_buffer out;
+} bio_ctx;
+
+/**
+ * Structure that wraps the TLS context. Contents differ depending on the
+ * SSL library used.
+ *
+ * Either \c priv_key_pkcs11 or \c priv_key must be filled in.
+ */
+struct tls_root_ctx {
+    bool initialised; 		/**< True if the context has been initialised */
+
+    int endpoint; 		/**< Whether or not this is a server or a client */
+
+    mbedtls_dhm_context *dhm_ctx;	/**< Diffie-Helmann-Merkle context */
+    mbedtls_x509_crt *crt_chain;	/**< Local Certificate chain */
+    mbedtls_x509_crt *ca_chain;		/**< CA chain for remote verification */
+    mbedtls_pk_context *priv_key;	/**< Local private key */
+#if defined(ENABLE_PKCS11)
+    mbedtls_pkcs11_context *priv_key_pkcs11;	/**< PKCS11 private key */
+#endif
+#ifdef MANAGMENT_EXTERNAL_KEY
+    struct external_context *external_key; /**< Management external key */
+#endif
+    int * allowed_ciphers;	/**< List of allowed ciphers for this connection */
+};
+
+struct key_state_ssl {
+    mbedtls_ssl_config ssl_config;	/**< mbedTLS global ssl config */
+    mbedtls_ssl_context *ctx;		/**< mbedTLS connection context */
+    bio_ctx bio_ctx;
+};
+
+
+#endif /* SSL_MBEDTLS_H_ */
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
deleted file mode 100644
index 483ec1c..0000000
--- a/src/openvpn/ssl_polarssl.c
+++ /dev/null
@@ -1,1184 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *  Copyright (C) 2006-2010, Brainspark B.V.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/**
- * @file Control Channel mbed TLS Backend
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-
-#include "syshead.h"
-
-#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
-
-#include "errlevel.h"
-#include "ssl_backend.h"
-#include "base64.h"
-#include "buffer.h"
-#include "misc.h"
-#include "manage.h"
-#include "ssl_common.h"
-
-#include <mbedtls/havege.h>
-
-#include "ssl_verify_polarssl.h"
-#include <mbedtls/debug.h>
-#include <mbedtls/error.h>
-#include <mbedtls/net.h>
-#include <mbedtls/oid.h>
-#include <mbedtls/pem.h>
-#include <mbedtls/sha256.h>
-#include <mbedtls/version.h>
-
-void
-tls_init_lib()
-{
-}
-
-void
-tls_free_lib()
-{
-}
-
-void
-tls_clear_error()
-{
-}
-
-void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
-{
-  ASSERT(NULL != ctx);
-  CLEAR(*ctx);
-
-  ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
-
-  ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
-
-  ctx->endpoint = MBEDTLS_SSL_IS_SERVER;
-  ctx->initialised = true;
-}
-
-void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
-{
-  ASSERT(NULL != ctx);
-  CLEAR(*ctx);
-
-  ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
-  ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
-
-  ctx->endpoint = MBEDTLS_SSL_IS_CLIENT;
-  ctx->initialised = true;
-}
-
-void
-tls_ctx_free(struct tls_root_ctx *ctx)
-{
-  if (ctx)
-    {
-      mbedtls_pk_free(ctx->priv_key);
-      if (ctx->priv_key)
-	free(ctx->priv_key);
-
-      mbedtls_x509_crt_free(ctx->ca_chain);
-      if (ctx->ca_chain)
-	free(ctx->ca_chain);
-
-      mbedtls_x509_crt_free(ctx->crt_chain);
-      if (ctx->crt_chain)
-	free(ctx->crt_chain);
-
-      mbedtls_dhm_free(ctx->dhm_ctx);
-      if (ctx->dhm_ctx)
-	free(ctx->dhm_ctx);
-
-#if defined(ENABLE_PKCS11)
-      if (ctx->priv_key_pkcs11 != NULL) {
-	  mbedtls_pkcs11_priv_key_free(ctx->priv_key_pkcs11);
-	  free(ctx->priv_key_pkcs11);
-      }
-#endif
-#if defined(MANAGMENT_EXTERNAL_KEY)
-      if (ctx->external_key != NULL)
-          free(ctx->external_key);
-#endif
-
-      if (ctx->allowed_ciphers)
-	free(ctx->allowed_ciphers);
-
-      CLEAR(*ctx);
-
-      ctx->initialised = false;
-
-    }
-}
-
-bool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
-{
-  ASSERT(NULL != ctx);
-  return ctx->initialised;
-}
-
-void
-key_state_export_keying_material(struct key_state_ssl *ssl,
-                                 struct tls_session *session)
-{
-}
-
-void
-tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
-{
-}
-
-static const char *
-tls_translate_cipher_name (const char * cipher_name) {
-  const tls_cipher_name_pair * pair = tls_get_cipher_name_pair(cipher_name, strlen(cipher_name));
-
-  if (NULL == pair)
-    {
-      // No translation found, return original
-      return cipher_name;
-    }
-
-  if (0 != strcmp(cipher_name, pair->iana_name))
-    {
-      // Deprecated name found, notify user
-      msg(M_WARN, "Deprecated cipher suite name '%s', please use IANA name '%s'", pair->openssl_name, pair->iana_name);
-    }
-
-  return pair->iana_name;
-}
-
-void
-tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
-{
-  char *tmp_ciphers, *tmp_ciphers_orig, *token;
-  int i, cipher_count;
-  int ciphers_len;
-
-  if (NULL == ciphers)
-    return; /* Nothing to do */
-
-  ciphers_len = strlen (ciphers);
-
-  ASSERT (NULL != ctx);
-  ASSERT (0 != ciphers_len);
-
-  /* Get number of ciphers */
-  for (i = 0, cipher_count = 1; i < ciphers_len; i++)
-    if (ciphers[i] == ':')
-      cipher_count++;
-
-  /* Allocate an array for them */
-  ALLOC_ARRAY_CLEAR(ctx->allowed_ciphers, int, cipher_count+1)
-
-  /* Parse allowed ciphers, getting IDs */
-  i = 0;
-  tmp_ciphers_orig = tmp_ciphers = string_alloc (ciphers, NULL);
-
-  token = strtok (tmp_ciphers, ":");
-  while(token)
-    {
-      ctx->allowed_ciphers[i] = mbedtls_ssl_get_ciphersuite_id (
-	  tls_translate_cipher_name (token));
-      if (0 != ctx->allowed_ciphers[i])
-	i++;
-      token = strtok (NULL, ":");
-    }
-  free(tmp_ciphers_orig);
-}
-
-void
-tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
-{
-  ASSERT (ctx);
-  if (ctx->crt_chain == NULL)
-    {
-      return; /* Nothing to check if there is no certificate */
-    }
-
-  if (mbedtls_x509_time_is_future (&ctx->crt_chain->valid_from))
-    {
-      msg (M_WARN, "WARNING: Your certificate is not yet valid!");
-    }
-
-  if (mbedtls_x509_time_is_past (&ctx->crt_chain->valid_to))
-    {
-      msg (M_WARN, "WARNING: Your certificate has expired!");
-    }
-}
-
-void
-tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
-    const char *dh_inline
-    )
-{
-  if (!strcmp (dh_file, INLINE_FILE_TAG) && dh_inline)
-    {
-      if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx->dhm_ctx,
-	  (const unsigned char *) dh_inline, strlen(dh_inline)+1)))
-	msg (M_FATAL, "Cannot read inline DH parameters");
-  }
-else
-  {
-    if (!mbed_ok(mbedtls_dhm_parse_dhmfile(ctx->dhm_ctx, dh_file)))
-      msg (M_FATAL, "Cannot read DH parameters from file %s", dh_file);
-  }
-
-  msg (D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with " counter_format " bit key",
-      (counter_type) 8 * mbedtls_mpi_size(&ctx->dhm_ctx->P));
-}
-
-void
-tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char *curve_name
-    )
-{
-    if (NULL != curve_name)
-      msg(M_WARN, "WARNING: mbed TLS builds do not support specifying an ECDH "
-                  "curve, using default curves.");
-}
-
-int
-tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-    const char *pkcs12_file_inline,
-    bool load_ca_file
-    )
-{
-  msg(M_FATAL, "PKCS #12 files not yet supported for mbed TLS.");
-  return 0;
-}
-
-#ifdef ENABLE_CRYPTOAPI
-void
-tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
-{
-  msg(M_FATAL, "Windows CryptoAPI not yet supported for mbed TLS.");
-}
-#endif /* WIN32 */
-
-void
-tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
-    const char *cert_inline
-    )
-{
-  ASSERT(NULL != ctx);
-
-  if (!ctx->crt_chain)
-    {
-      ALLOC_OBJ_CLEAR(ctx->crt_chain, mbedtls_x509_crt);
-    }
-
-  if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_inline)
-    {
-      if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain,
-	  (const unsigned char *) cert_inline, strlen(cert_inline)+1)))
-        msg (M_FATAL, "Cannot load inline certificate file");
-    }
-  else
-    {
-      if (!mbed_ok(mbedtls_x509_crt_parse_file(ctx->crt_chain, cert_file)))
-	{
-	  msg (M_FATAL, "Cannot load certificate file %s", cert_file);
-	}
-    }
-}
-
-int
-tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
-    const char *priv_key_inline
-    )
-{
-  int status;
-  ASSERT(NULL != ctx);
-
-  if (!ctx->priv_key)
-    {
-      ALLOC_OBJ_CLEAR(ctx->priv_key, mbedtls_pk_context);
-    }
-
-  if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_inline)
-    {
-      status = mbedtls_pk_parse_key(ctx->priv_key,
-	  (const unsigned char *) priv_key_inline, strlen(priv_key_inline)+1,
-	  NULL, 0);
-
-      if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
-	{
-	  char passbuf[512] = {0};
-	  pem_password_callback(passbuf, 512, 0, NULL);
-	  status = mbedtls_pk_parse_key(ctx->priv_key,
-	      (const unsigned char *) priv_key_inline,
-	      strlen(priv_key_inline)+1, (unsigned char *) passbuf,
-	      strlen(passbuf));
-	}
-    }
-  else
-    {
-      status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);
-      if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
-	{
-	  char passbuf[512] = {0};
-	  pem_password_callback(passbuf, 512, 0, NULL);
-	  status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
-	}
-    }
-  if (!mbed_ok(status))
-    {
-#ifdef ENABLE_MANAGEMENT
-      if (management && (MBEDTLS_ERR_PK_PASSWORD_MISMATCH == status))
-	  management_auth_failure (management, UP_TYPE_PRIVATE_KEY, NULL);
-#endif
-      msg (M_WARN, "Cannot load private key file %s", priv_key_file);
-      return 1;
-    }
-
-  warn_if_group_others_accessible (priv_key_file);
-
-  /* TODO: Check Private Key */
-#if 0
-  if (!SSL_CTX_check_private_key (ctx))
-    msg (M_SSLERR, "Private key does not match the certificate");
-#endif
-  return 0;
-}
-
-#ifdef MANAGMENT_EXTERNAL_KEY
-
-
-struct external_context {
-  size_t signature_length;
-};
-
-/**
- * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that uses
- * the management interface to request an RSA signature for the supplied hash.
- *
- * @param ctx_voidptr   Management external key context.
- * @param f_rng         (Unused)
- * @param p_rng         (Unused)
- * @param mode          RSA mode (should be RSA_PRIVATE).
- * @param md_alg        Message digest ('hash') algorithm type.
- * @param hashlen       Length of hash (overridden by length specified by md_alg
- *                      if md_alg != MBEDTLS_MD_NONE).
- * @param hash          The digest ('hash') to sign. Should have a size
- *                      matching the length of md_alg (if != MBEDTLS_MD_NONE),
- *                      or hashlen otherwise.
- * @param sig           Buffer that returns the signature. Should be at least of
- *                      size ctx->signature_length.
- *
- * @return 0 on success, non-zero mbed TLS error code on failure.
- */
-static inline int external_pkcs1_sign( void *ctx_voidptr,
-    int (*f_rng)(void *, unsigned char *, size_t), void *p_rng, int mode,
-    mbedtls_md_type_t md_alg, unsigned int hashlen, const unsigned char *hash,
-    unsigned char *sig )
-{
-  struct external_context * const ctx = ctx_voidptr;
-  char *in_b64 = NULL;
-  char *out_b64 = NULL;
-  int rv;
-  unsigned char *p = sig;
-  size_t asn_len = 0, oid_size = 0, sig_len = 0;
-  const char *oid = NULL;
-
-  if( NULL == ctx )
-    return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-
-  if( MBEDTLS_RSA_PRIVATE != mode )
-    return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-
-  /*
-   * Support a wide range of hashes. TLSv1.1 and before only need SIG_RSA_RAW,
-   * but TLSv1.2 needs the full suite of hashes.
-   *
-   * This code has been taken from mbed TLS pkcs11_sign(), under the GPLv2.0+.
-   */
-  if( md_alg != MBEDTLS_MD_NONE )
-    {
-      const mbedtls_md_info_t *md_info = mbedtls_md_info_from_type( md_alg );
-      if( md_info == NULL )
-        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
-
-      if (!mbed_ok(mbedtls_oid_get_oid_by_md( md_alg, &oid, &oid_size )))
-        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
-
-      hashlen = mbedtls_md_get_size( md_info );
-      asn_len = 10 + oid_size;
-    }
-
-  sig_len = ctx->signature_length;
-  if ( (SIZE_MAX - hashlen) < asn_len || (hashlen + asn_len) > sig_len )
-    return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-
-  if( md_alg != MBEDTLS_MD_NONE )
-    {
-      /*
-       * DigestInfo ::= SEQUENCE {
-       *   digestAlgorithm DigestAlgorithmIdentifier,
-       *   digest Digest }
-       *
-       * DigestAlgorithmIdentifier ::= AlgorithmIdentifier
-       *
-       * Digest ::= OCTET STRING
-       */
-      *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
-      *p++ = (unsigned char) ( 0x08 + oid_size + hashlen );
-      *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
-      *p++ = (unsigned char) ( 0x04 + oid_size );
-      *p++ = MBEDTLS_ASN1_OID;
-      *p++ = oid_size & 0xFF;
-      memcpy( p, oid, oid_size );
-      p += oid_size;
-      *p++ = MBEDTLS_ASN1_NULL;
-      *p++ = 0x00;
-      *p++ = MBEDTLS_ASN1_OCTET_STRING;
-      *p++ = hashlen;
-
-      /* Determine added ASN length */
-      asn_len = p - sig;
-  }
-
-  /* Copy the hash to be signed */
-  memcpy( p, hash, hashlen );
-
-  /* convert 'from' to base64 */
-  if (openvpn_base64_encode (sig, asn_len + hashlen, &in_b64) <= 0)
-    {
-      rv = MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-      goto done;
-    }
-
-  /* call MI for signature */
-  if (management)
-    out_b64 = management_query_rsa_sig (management, in_b64);
-  if (!out_b64)
-    {
-      rv = MBEDTLS_ERR_RSA_PRIVATE_FAILED;
-      goto done;
-    }
-
-  /* decode base64 signature to binary and verify length */
-  if ( openvpn_base64_decode (out_b64, sig, ctx->signature_length) !=
-       ctx->signature_length )
-    {
-      rv = MBEDTLS_ERR_RSA_PRIVATE_FAILED;
-      goto done;
-    }
-
-  rv = 0;
-
-done:
-  if (in_b64)
-    free (in_b64);
-  if (out_b64)
-    free (out_b64);
-  return rv;
-}
-
-static inline size_t external_key_len(void *vctx)
-{
-  struct external_context * const ctx = vctx;
-
-  return ctx->signature_length;
-}
-
-int
-tls_ctx_use_external_private_key (struct tls_root_ctx *ctx,
-    const char *cert_file, const char *cert_file_inline)
-{
-  ASSERT(NULL != ctx);
-
-  tls_ctx_load_cert_file(ctx, cert_file, cert_file_inline);
-
-  if (ctx->crt_chain == NULL)
-    return 0;
-
-  ALLOC_OBJ_CLEAR (ctx->external_key, struct external_context);
-  ctx->external_key->signature_length = mbedtls_pk_get_len (&ctx->crt_chain->pk);
-
-  ALLOC_OBJ_CLEAR (ctx->priv_key, mbedtls_pk_context);
-  if (!mbed_ok (mbedtls_pk_setup_rsa_alt (ctx->priv_key, ctx->external_key,
-	    NULL, external_pkcs1_sign, external_key_len)))
-    return 0;
-
-  return 1;
-}
-#endif
-
-void tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
-    const char *ca_inline, const char *ca_path, bool tls_server
-    )
-{
-  if (ca_path)
-      msg(M_FATAL, "ERROR: mbed TLS cannot handle the capath directive");
-
-  if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_inline)
-    {
-      if (!mbed_ok (mbedtls_x509_crt_parse (ctx->ca_chain,
-	  (const unsigned char *) ca_inline, strlen(ca_inline)+1)))
-	msg (M_FATAL, "Cannot load inline CA certificates");
-    }
-  else
-    {
-      /* Load CA file for verifying peer supplied certificate */
-      if (!mbed_ok (mbedtls_x509_crt_parse_file (ctx->ca_chain, ca_file)))
-	msg (M_FATAL, "Cannot load CA certificate file %s", ca_file);
-    }
-}
-
-void
-tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_certs_file,
-    const char *extra_certs_inline
-    )
-{
-  ASSERT(NULL != ctx);
-
-  if (!ctx->crt_chain)
-    {
-      ALLOC_OBJ_CLEAR (ctx->crt_chain, mbedtls_x509_crt);
-    }
-
-  if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_inline)
-    {
-      if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain,
-          (const unsigned char *) extra_certs_inline,
-	  strlen(extra_certs_inline)+1)))
-        msg (M_FATAL, "Cannot load inline extra-certs file");
-    }
-  else
-    {
-      if (!mbed_ok(mbedtls_x509_crt_parse_file(ctx->crt_chain, extra_certs_file)))
-	msg (M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
-    }
-}
-
-/* **************************************
- *
- * Key-state specific functions
- *
- ***************************************/
-
-/*
- * "Endless buffer"
- */
-
-static inline void buf_free_entry(buffer_entry *entry)
-{
-  if (NULL != entry)
-    {
-      free(entry->data);
-      free(entry);
-    }
-}
-
-static void buf_free_entries(endless_buffer *buf)
-{
-  while(buf->first_block)
-    {
-      buffer_entry *cur_block = buf->first_block;
-      buf->first_block = cur_block->next_block;
-      buf_free_entry(cur_block);
-    }
-  buf->last_block = NULL;
-}
-
-static int endless_buf_read( endless_buffer *in, unsigned char * out, size_t out_len )
-{
-  size_t read_len = 0;
-
-  if (in->first_block == NULL)
-    return MBEDTLS_ERR_SSL_WANT_READ;
-
-  while (in->first_block != NULL && read_len < out_len)
-    {
-      int block_len = in->first_block->length - in->data_start;
-      if (block_len <= out_len - read_len)
-	{
-	  buffer_entry *cur_entry = in->first_block;
-	  memcpy(out + read_len, cur_entry->data + in->data_start,
-	      block_len);
-
-	  read_len += block_len;
-
-	  in->first_block = cur_entry->next_block;
-	  in->data_start = 0;
-
-	  if (in->first_block == NULL)
-	    in->last_block = NULL;
-
-	  buf_free_entry(cur_entry);
-	}
-      else
-	{
-	  memcpy(out + read_len, in->first_block->data + in->data_start,
-	      out_len - read_len);
-	  in->data_start += out_len - read_len;
-	  read_len = out_len;
-	}
-    }
-
-  return read_len;
-}
-
-static int endless_buf_write( endless_buffer *out, const unsigned char *in, size_t len )
-{
-  buffer_entry *new_block = malloc(sizeof(buffer_entry));
-  if (NULL == new_block)
-    return MBEDTLS_ERR_NET_SEND_FAILED;
-
-  new_block->data = malloc(len);
-  if (NULL == new_block->data)
-    {
-      free(new_block);
-      return MBEDTLS_ERR_NET_SEND_FAILED;
-    }
-
-  new_block->length = len;
-  new_block->next_block = NULL;
-
-  memcpy(new_block->data, in, len);
-
-  if (NULL == out->first_block)
-    out->first_block = new_block;
-
-  if (NULL != out->last_block)
-    out->last_block->next_block = new_block;
-
-  out->last_block = new_block;
-
-  return len;
-}
-
-static int ssl_bio_read( void *ctx, unsigned char *out, size_t out_len)
-{
-  bio_ctx *my_ctx = (bio_ctx *) ctx;
-  return endless_buf_read (&my_ctx->in, out, out_len);
-}
-
-static int ssl_bio_write( void *ctx, const unsigned char *in, size_t in_len)
-{
-  bio_ctx *my_ctx = (bio_ctx *) ctx;
-  return endless_buf_write (&my_ctx->out, in, in_len);
-}
-
-static void my_debug( void *ctx, int level, const char *file, int line,
-    const char *str )
-{
-  int my_loglevel = (level < 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;
-  msg (my_loglevel, "mbed TLS msg (%s:%d): %s", file, line, str);
-}
-
-/*
- * Further personalise the RNG using a hash of the public key
- */
-void tls_ctx_personalise_random(struct tls_root_ctx *ctx)
-{
-  static char old_sha256_hash[32] = {0};
-  unsigned char sha256_hash[32] = {0};
-  mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
-
-  if (NULL != ctx->crt_chain)
-    {
-      mbedtls_x509_crt *cert = ctx->crt_chain;
-
-      mbedtls_sha256(cert->tbs.p, cert->tbs.len, sha256_hash, false);
-      if ( 0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
-	{
-	  mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32);
-	  memcpy(old_sha256_hash, sha256_hash, sizeof(old_sha256_hash));
-	}
-    }
-}
-
-int
-tls_version_max(void)
-{
-#if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_3)
-  return TLS_VER_1_2;
-#elif defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_2)
-  return TLS_VER_1_1;
-#else
-  return TLS_VER_1_0;
-#endif
-}
-
-/**
- * Convert an OpenVPN tls-version variable to mbed TLS format (i.e. a major and
- * minor ssl version number).
- *
- * @param tls_ver	The tls-version variable to convert.
- * @param major		Returns the TLS major version in mbed TLS format.
- * 			Must be a valid pointer.
- * @param minor		Returns the TLS minor version in mbed TLS format.
- * 			Must be a valid pointer.
- */
-static void tls_version_to_major_minor(int tls_ver, int *major, int *minor) {
-  ASSERT(major);
-  ASSERT(minor);
-
-  switch (tls_ver)
-  {
-    case TLS_VER_1_0:
-      *major = MBEDTLS_SSL_MAJOR_VERSION_3;
-      *minor = MBEDTLS_SSL_MINOR_VERSION_1;
-      break;
-    case TLS_VER_1_1:
-      *major = MBEDTLS_SSL_MAJOR_VERSION_3;
-      *minor = MBEDTLS_SSL_MINOR_VERSION_2;
-      break;
-    case TLS_VER_1_2:
-      *major = MBEDTLS_SSL_MAJOR_VERSION_3;
-      *minor = MBEDTLS_SSL_MINOR_VERSION_3;
-      break;
-    default:
-      msg(M_FATAL, "%s: invalid TLS version %d", __func__, tls_ver);
-      break;
-  }
-}
-
-void key_state_ssl_init(struct key_state_ssl *ks_ssl,
-    const struct tls_root_ctx *ssl_ctx, bool is_server, struct tls_session *session)
-{
-  ASSERT(NULL != ssl_ctx);
-  ASSERT(ks_ssl);
-  CLEAR(*ks_ssl);
-
-  /* Initialise SSL config */
-  mbedtls_ssl_config_init(&ks_ssl->ssl_config);
-  mbedtls_ssl_config_defaults(&ks_ssl->ssl_config, ssl_ctx->endpoint,
-      MBEDTLS_SSL_TRANSPORT_STREAM, MBEDTLS_SSL_PRESET_DEFAULT);
-  mbedtls_debug_set_threshold(3);
-  mbedtls_ssl_conf_dbg (&ks_ssl->ssl_config, my_debug, NULL);
-  mbedtls_ssl_conf_rng (&ks_ssl->ssl_config, mbedtls_ctr_drbg_random,
-      rand_ctx_get());
-
-  if (ssl_ctx->allowed_ciphers)
-    mbedtls_ssl_conf_ciphersuites (&ks_ssl->ssl_config, ssl_ctx->allowed_ciphers);
-
-  /* Disable record splitting (for now).  OpenVPN assumes records are sent
-   * unfragmented, and changing that will require thorough review and
-   * testing.  Since OpenVPN is not susceptible to BEAST, we can just
-   * disable record splitting as a quick fix. */
-#if defined(MBEDTLS_SSL_CBC_RECORD_SPLITTING)
-  mbedtls_ssl_conf_cbc_record_splitting (&ks_ssl->ssl_config,
-      MBEDTLS_SSL_CBC_RECORD_SPLITTING_DISABLED);
-#endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */
-
-  /* Initialise authentication information */
-  if (is_server)
-    mbed_ok (mbedtls_ssl_conf_dh_param_ctx(&ks_ssl->ssl_config,
-	ssl_ctx->dhm_ctx));
-
-  mbed_ok (mbedtls_ssl_conf_own_cert(&ks_ssl->ssl_config, ssl_ctx->crt_chain,
-      ssl_ctx->priv_key));
-
-  /* Initialise SSL verification */
-#if P2MP_SERVER
-  if (session->opt->ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
-    {
-      mbedtls_ssl_conf_authmode(&ks_ssl->ssl_config, MBEDTLS_SSL_VERIFY_OPTIONAL);
-    }
-  else if (!(session->opt->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED))
-#endif
-  {
-    mbedtls_ssl_conf_authmode (&ks_ssl->ssl_config, MBEDTLS_SSL_VERIFY_REQUIRED);
-  }
-  mbedtls_ssl_conf_verify (&ks_ssl->ssl_config, verify_callback, session);
-
-  /* TODO: mbed TLS does not currently support sending the CA chain to the client */
-  mbedtls_ssl_conf_ca_chain (&ks_ssl->ssl_config, ssl_ctx->ca_chain, NULL );
-
-  /* Initialize minimum TLS version */
-  {
-    const int tls_version_min =
-	(session->opt->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) &
-	SSLF_TLS_VERSION_MIN_MASK;
-
-    /* default to TLS 1.0 */
-    int major = MBEDTLS_SSL_MAJOR_VERSION_3;
-    int minor = MBEDTLS_SSL_MINOR_VERSION_1;
-
-    if (tls_version_min > TLS_VER_UNSPEC)
-      tls_version_to_major_minor(tls_version_min, &major, &minor);
-
-    mbedtls_ssl_conf_min_version(&ks_ssl->ssl_config, major, minor);
-  }
-
-  /* Initialize maximum TLS version */
-  {
-    const int tls_version_max =
-	(session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
-	SSLF_TLS_VERSION_MAX_MASK;
-
-    if (tls_version_max > TLS_VER_UNSPEC)
-      {
-	int major, minor;
-	tls_version_to_major_minor(tls_version_max, &major, &minor);
-	mbedtls_ssl_conf_max_version(&ks_ssl->ssl_config, major, minor);
-      }
-  }
-
-  /* Initialise SSL context */
-  ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
-  mbedtls_ssl_init(ks_ssl->ctx);
-  mbedtls_ssl_setup(ks_ssl->ctx, &ks_ssl->ssl_config);
-
-  /* Initialise BIOs */
-  CLEAR (ks_ssl->bio_ctx);
-  mbedtls_ssl_set_bio (ks_ssl->ctx, &ks_ssl->bio_ctx, ssl_bio_write,
-      ssl_bio_read, NULL);
-}
-
-void
-key_state_ssl_free(struct key_state_ssl *ks_ssl)
-{
-  if (ks_ssl) {
-      if (ks_ssl->ctx)
-	{
-	  mbedtls_ssl_free(ks_ssl->ctx);
-	  free(ks_ssl->ctx);
-	}
-      mbedtls_ssl_config_free(&ks_ssl->ssl_config);
-      buf_free_entries(&ks_ssl->bio_ctx.in);
-      buf_free_entries(&ks_ssl->bio_ctx.out);
-      CLEAR(*ks_ssl);
-  }
-}
-
-int
-key_state_write_plaintext (struct key_state_ssl *ks, struct buffer *buf)
-{
-  int retval = 0;
-
-  ASSERT (buf);
-
-  retval = key_state_write_plaintext_const(ks, BPTR(buf), BLEN(buf));
-
-  if (1 == retval)
-    {
-      memset (BPTR (buf), 0, BLEN (buf)); /* erase data just written */
-      buf->len = 0;
-    }
-
-  return retval;
-}
-
-int
-key_state_write_plaintext_const (struct key_state_ssl *ks, const uint8_t *data, int len)
-{
-  int retval = 0;
-  perf_push (PERF_BIO_WRITE_PLAINTEXT);
-
-  ASSERT (NULL != ks);
-  ASSERT (len >= 0);
-
-  if (0 == len)
-    {
-      perf_pop ();
-      return 0;
-    }
-
-  ASSERT (data);
-
-  retval = mbedtls_ssl_write(ks->ctx, data, len);
-
-  if (retval < 0)
-    {
-      perf_pop ();
-      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
-	return 0;
-      mbed_log_err (D_TLS_ERRORS, retval,
-	  "TLS ERROR: write tls_write_plaintext_const error");
-      return -1;
-    }
-
-  if (retval != len)
-    {
-      msg (D_TLS_ERRORS,
-	  "TLS ERROR: write tls_write_plaintext_const incomplete %d/%d",
-	  retval, len);
-      perf_pop ();
-      return -1;
-    }
-
-  /* successful write */
-  dmsg (D_HANDSHAKE_VERBOSE, "write tls_write_plaintext_const %d bytes", retval);
-
-  perf_pop ();
-  return 1;
-}
-
-int
-key_state_read_ciphertext (struct key_state_ssl *ks, struct buffer *buf,
-    int maxlen)
-{
-  int retval = 0;
-  int len = 0;
-
-  perf_push (PERF_BIO_READ_CIPHERTEXT);
-
-  ASSERT (NULL != ks);
-  ASSERT (buf);
-  ASSERT (buf->len >= 0);
-
-  if (buf->len)
-    {
-      perf_pop ();
-      return 0;
-    }
-
-  len = buf_forward_capacity (buf);
-  if (maxlen < len)
-    len = maxlen;
-
-  retval = endless_buf_read(&ks->bio_ctx.out, BPTR(buf), len);
-
-  /* Error during read, check for retry error */
-  if (retval < 0)
-    {
-      perf_pop ();
-      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
-	return 0;
-      mbed_log_err (D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_ciphertext error");
-      buf->len = 0;
-      return -1;
-    }
-  /* Nothing read, try again */
-  if (0 == retval)
-    {
-      buf->len = 0;
-      perf_pop ();
-      return 0;
-    }
-
-  /* successful read */
-  dmsg (D_HANDSHAKE_VERBOSE, "read tls_read_ciphertext %d bytes", retval);
-  buf->len = retval;
-  perf_pop ();
-  return 1;
-}
-
-int
-key_state_write_ciphertext (struct key_state_ssl *ks, struct buffer *buf)
-{
-  int retval = 0;
-  perf_push (PERF_BIO_WRITE_CIPHERTEXT);
-
-  ASSERT (NULL != ks);
-  ASSERT (buf);
-  ASSERT (buf->len >= 0);
-
-  if (0 == buf->len)
-    {
-      perf_pop ();
-      return 0;
-    }
-
-  retval = endless_buf_write(&ks->bio_ctx.in, BPTR(buf), buf->len);
-
-  if (retval < 0)
-    {
-      perf_pop ();
-
-      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
-	return 0;
-      mbed_log_err (D_TLS_ERRORS, retval,
-	  "TLS ERROR: write tls_write_ciphertext error");
-      return -1;
-    }
-
-  if (retval != buf->len)
-    {
-      msg (D_TLS_ERRORS, "TLS ERROR: write tls_write_ciphertext incomplete %d/%d",
-	  retval, buf->len);
-      perf_pop ();
-      return -1;
-    }
-
-  /* successful write */
-  dmsg (D_HANDSHAKE_VERBOSE, "write tls_write_ciphertext %d bytes", retval);
-
-  memset (BPTR (buf), 0, BLEN (buf)); /* erase data just written */
-  buf->len = 0;
-
-  perf_pop ();
-  return 1;
-}
-
-int
-key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
-    int maxlen)
-{
-  int retval = 0;
-  int len = 0;
-
-  perf_push (PERF_BIO_READ_PLAINTEXT);
-
-  ASSERT (NULL != ks);
-  ASSERT (buf);
-  ASSERT (buf->len >= 0);
-
-  if (buf->len)
-    {
-      perf_pop ();
-      return 0;
-    }
-
-  len = buf_forward_capacity (buf);
-  if (maxlen < len)
-    len = maxlen;
-
-  retval = mbedtls_ssl_read(ks->ctx, BPTR(buf), len);
-
-  /* Error during read, check for retry error */
-  if (retval < 0)
-    {
-      if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
-	return 0;
-      mbed_log_err (D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_plaintext error");
-      buf->len = 0;
-      perf_pop ();
-      return -1;
-    }
-  /* Nothing read, try again */
-  if (0 == retval)
-    {
-      buf->len = 0;
-      perf_pop ();
-      return 0;
-    }
-
-  /* successful read */
-  dmsg (D_HANDSHAKE_VERBOSE, "read tls_read_plaintext %d bytes", retval);
-  buf->len = retval;
-
-  perf_pop ();
-  return 1;
-}
-
-/* **************************************
- *
- * Information functions
- *
- * Print information for the end user.
- *
- ***************************************/
-void
-print_details (struct key_state_ssl * ks_ssl, const char *prefix)
-{
-  const mbedtls_x509_crt *cert;
-  char s1[256];
-  char s2[256];
-
-  s1[0] = s2[0] = 0;
-  openvpn_snprintf (s1, sizeof (s1), "%s %s, cipher %s",
-		    prefix,
-		    mbedtls_ssl_get_version (ks_ssl->ctx),
-		    mbedtls_ssl_get_ciphersuite (ks_ssl->ctx));
-
-  cert = mbedtls_ssl_get_peer_cert (ks_ssl->ctx);
-  if (cert != NULL)
-    {
-      openvpn_snprintf (s2, sizeof (s2), ", %zu bit key",
-	  mbedtls_pk_get_bitlen (&cert->pk));
-    }
-
-  msg (D_HANDSHAKE, "%s%s", s1, s2);
-}
-
-void
-show_available_tls_ciphers (const char *cipher_list)
-{
-  struct tls_root_ctx tls_ctx;
-  const int *ciphers = mbedtls_ssl_list_ciphersuites ();
-
-  tls_ctx_server_new(&tls_ctx);
-  tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
-
-  if (tls_ctx.allowed_ciphers)
-    ciphers = tls_ctx.allowed_ciphers;
-
-#ifndef ENABLE_SMALL
-  printf ("Available TLS Ciphers,\n");
-  printf ("listed in order of preference:\n\n");
-#endif
-
-  while (*ciphers != 0)
-    {
-      printf ("%s\n", mbedtls_ssl_get_ciphersuite_name (*ciphers));
-      ciphers++;
-    }
-  printf ("\n" SHOW_TLS_CIPHER_LIST_WARNING);
-
-  tls_ctx_free(&tls_ctx);
-}
-
-void
-show_available_curves (void)
-{
-  const mbedtls_ecp_curve_info *pcurve = mbedtls_ecp_curve_list ();
-
-  if (NULL == pcurve)
-    msg (M_FATAL, "Cannot retrieve curve list from mbed TLS");
-
-  /* Print curve list */
-  printf ("Available Elliptic curves, listed in order of preference:\n\n");
-  while (MBEDTLS_ECP_DP_NONE != pcurve->grp_id)
-    {
-      printf("%s\n", pcurve->name);
-      pcurve++;
-    }
-}
-
-void
-get_highest_preference_tls_cipher (char *buf, int size)
-{
-  const char *cipher_name;
-  const int *ciphers = mbedtls_ssl_list_ciphersuites();
-  if (*ciphers == 0)
-    msg (M_FATAL, "Cannot retrieve list of supported SSL ciphers.");
-
-  cipher_name = mbedtls_ssl_get_ciphersuite_name(*ciphers);
-  strncpynt (buf, cipher_name, size);
-}
-
-const char *
-get_ssl_library_version(void)
-{
-    static char mbedtls_version[30];
-    unsigned int pv = mbedtls_version_get_number();
-    sprintf( mbedtls_version, "mbed TLS %d.%d.%d",
-		(pv>>24)&0xff, (pv>>16)&0xff, (pv>>8)&0xff );
-    return mbedtls_version;
-}
-
-#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/ssl_polarssl.h b/src/openvpn/ssl_polarssl.h
deleted file mode 100644
index 6f778ef..0000000
--- a/src/openvpn/ssl_polarssl.h
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/**
- * @file Control Channel mbed TLS Backend
- */
-
-#ifndef SSL_MBEDTLS_H_
-#define SSL_MBEDTLS_H_
-
-#include "syshead.h"
-
-#include <mbedtls/ssl.h>
-#include <mbedtls/x509_crt.h>
-
-#if defined(ENABLE_PKCS11)
-#include <mbedtls/pkcs11.h>
-#endif
-
-typedef struct _buffer_entry buffer_entry;
-
-struct _buffer_entry {
-    size_t length;
-    uint8_t *data;
-    buffer_entry *next_block;
-};
-
-typedef struct {
-    size_t data_start;
-    buffer_entry *first_block;
-    buffer_entry *last_block;
-} endless_buffer;
-
-typedef struct {
-    endless_buffer in;
-    endless_buffer out;
-} bio_ctx;
-
-/**
- * Structure that wraps the TLS context. Contents differ depending on the
- * SSL library used.
- *
- * Either \c priv_key_pkcs11 or \c priv_key must be filled in.
- */
-struct tls_root_ctx {
-    bool initialised; 		/**< True if the context has been initialised */
-
-    int endpoint; 		/**< Whether or not this is a server or a client */
-
-    mbedtls_dhm_context *dhm_ctx;	/**< Diffie-Helmann-Merkle context */
-    mbedtls_x509_crt *crt_chain;	/**< Local Certificate chain */
-    mbedtls_x509_crt *ca_chain;		/**< CA chain for remote verification */
-    mbedtls_pk_context *priv_key;	/**< Local private key */
-#if defined(ENABLE_PKCS11)
-    mbedtls_pkcs11_context *priv_key_pkcs11;	/**< PKCS11 private key */
-#endif
-#ifdef MANAGMENT_EXTERNAL_KEY
-    struct external_context *external_key; /**< Management external key */
-#endif
-    int * allowed_ciphers;	/**< List of allowed ciphers for this connection */
-};
-
-struct key_state_ssl {
-    mbedtls_ssl_config ssl_config;	/**< mbedTLS global ssl config */
-    mbedtls_ssl_context *ctx;		/**< mbedTLS connection context */
-    bio_ctx bio_ctx;
-};
-
-
-#endif /* SSL_MBEDTLS_H_ */
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 5eb1843..f693b2a 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -41,7 +41,7 @@
 #include "ssl_verify_openssl.h"
 #endif
 #ifdef ENABLE_CRYPTO_MBEDTLS
-#include "ssl_verify_polarssl.h"
+#include "ssl_verify_mbedtls.h"
 #endif
 
 #include "ssl_verify_backend.h"
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
new file mode 100644
index 0000000..ffe196e
--- /dev/null
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -0,0 +1,508 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file Control Channel Verification Module mbed TLS backend
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
+
+#include "crypto_mbedtls.h"
+#include "ssl_verify.h"
+#include <mbedtls/asn1.h>
+#include <mbedtls/error.h>
+#include <mbedtls/bignum.h>
+#include <mbedtls/oid.h>
+#include <mbedtls/sha1.h>
+
+#define MAX_SUBJECT_LENGTH 256
+
+int
+verify_callback (void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
+    uint32_t *flags)
+{
+  struct tls_session *session = (struct tls_session *) session_obj;
+  struct gc_arena gc = gc_new();
+
+  ASSERT (cert);
+  ASSERT (session);
+
+  session->verified = false;
+
+  /* Remember certificate hash */
+  cert_hash_remember (session, cert_depth, x509_get_sha1_hash(cert, &gc));
+
+  /* did peer present cert which was signed by our root cert? */
+  if (*flags != 0)
+    {
+      char *subject = x509_get_subject(cert, &gc);
+
+      if (subject)
+	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, flags=%x, %s", cert_depth, *flags, subject);
+      else
+	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, flags=%x, could not extract X509 "
+	      "subject string from certificate", *flags, cert_depth);
+
+      /* Leave flags set to non-zero to indicate that the cert is not ok */
+    }
+  else if (SUCCESS != verify_cert(session, cert, cert_depth))
+    {
+      *flags |= MBEDTLS_X509_BADCERT_OTHER;
+    }
+
+  gc_free(&gc);
+
+  /*
+   * PolarSSL/mbed TLS-1.2.0+ expects 0 on anything except fatal errors.
+   */
+  return 0;
+}
+
+#ifdef ENABLE_X509ALTUSERNAME
+# warning "X509 alt user name not yet supported for mbed TLS"
+#endif
+
+result_t
+backend_x509_get_username (char *cn, int cn_len,
+    char *x509_username_field, mbedtls_x509_crt *cert)
+{
+  mbedtls_x509_name *name;
+
+  ASSERT( cn != NULL );
+
+  name = &cert->subject;
+
+  /* Find common name */
+  while( name != NULL )
+  {
+      if (0 == memcmp (name->oid.p, MBEDTLS_OID_AT_CN,
+	  MBEDTLS_OID_SIZE (MBEDTLS_OID_AT_CN)))
+	break;
+
+      name = name->next;
+  }
+
+  /* Not found, return an error if this is the peer's certificate */
+  if( name == NULL )
+      return FAILURE;
+
+  /* Found, extract CN */
+  if (cn_len > name->val.len)
+    {
+      memcpy( cn, name->val.p, name->val.len );
+      cn[name->val.len] = '\0';
+    }
+  else
+    {
+      memcpy( cn, name->val.p, cn_len);
+      cn[cn_len-1] = '\0';
+    }
+
+  return SUCCESS;
+}
+
+char *
+backend_x509_get_serial (mbedtls_x509_crt *cert, struct gc_arena *gc)
+{
+  char *buf = NULL;
+  size_t buflen = 0;
+  mbedtls_mpi serial_mpi = { 0 };
+
+  /* Transform asn1 integer serial into mbed TLS MPI */
+  mbedtls_mpi_init(&serial_mpi);
+  if (!mbed_ok(mbedtls_mpi_read_binary(&serial_mpi, cert->serial.p,
+      cert->serial.len)))
+    {
+      msg(M_WARN, "Failed to retrieve serial from certificate.");
+      return NULL;
+    }
+
+  /* Determine decimal representation length, allocate buffer */
+  mbedtls_mpi_write_string(&serial_mpi, 10, NULL, 0, &buflen);
+  buf = gc_malloc(buflen, true, gc);
+
+  /* Write MPI serial as decimal string into buffer */
+  if (!mbed_ok(mbedtls_mpi_write_string(&serial_mpi, 10, buf, buflen, &buflen)))
+    {
+      msg(M_WARN, "Failed to write serial to string.");
+      return NULL;
+    }
+
+  return buf;
+}
+
+char *
+backend_x509_get_serial_hex (mbedtls_x509_crt *cert, struct gc_arena *gc)
+{
+  char *buf = NULL;
+  size_t len = cert->serial.len * 3 + 1;
+
+  buf = gc_malloc(len, true, gc);
+
+  if(mbedtls_x509_serial_gets(buf, len-1, &cert->serial) < 0)
+    buf = NULL;
+
+  return buf;
+}
+
+unsigned char *
+x509_get_sha1_hash (mbedtls_x509_crt *cert, struct gc_arena *gc)
+{
+  unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
+  mbedtls_sha1(cert->raw.p, cert->tbs.len, sha1_hash);
+  return sha1_hash;
+}
+
+char *
+x509_get_subject(mbedtls_x509_crt *cert, struct gc_arena *gc)
+{
+  char tmp_subject[MAX_SUBJECT_LENGTH] = {0};
+  char *subject = NULL;
+
+  int ret = 0;
+
+  ret = mbedtls_x509_dn_gets( tmp_subject, MAX_SUBJECT_LENGTH-1, &cert->subject );
+  if (ret > 0)
+    {
+      /* Allocate the required space for the subject */
+      subject = string_alloc(tmp_subject, gc);
+    }
+
+  return subject;
+}
+
+static void
+do_setenv_x509 (struct env_set *es, const char *name, char *value, int depth)
+{
+  char *name_expand;
+  size_t name_expand_size;
+
+  string_mod (value, CC_ANY, CC_CRLF, '?');
+  msg (D_X509_ATTR, "X509 ATTRIBUTE name='%s' value='%s' depth=%d", name, value, depth);
+  name_expand_size = 64 + strlen (name);
+  name_expand = (char *) malloc (name_expand_size);
+  check_malloc_return (name_expand);
+  openvpn_snprintf (name_expand, name_expand_size, "X509_%d_%s", depth, name);
+  setenv_str (es, name_expand, value);
+  free (name_expand);
+}
+
+static char *
+asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)
+{
+  size_t i;
+  char *val;
+
+  for (i = 0; i < orig->len; ++i)
+    if (orig->p[i] == '\0')
+      return "ERROR: embedded null value";
+  val = gc_malloc(orig->len+1, false, gc);
+  memcpy(val, orig->p, orig->len);
+  val[orig->len] = '\0';
+  return val;
+}
+
+static void
+do_setenv_name(struct env_set *es, const struct x509_track *xt,
+	       const mbedtls_x509_crt *cert, int depth, struct gc_arena *gc)
+{
+  const mbedtls_x509_name *xn;
+  for (xn = &cert->subject; xn != NULL; xn = xn->next)
+    {
+      const char *xn_short_name = NULL;
+      if (0 == mbedtls_oid_get_attr_short_name (&xn->oid, &xn_short_name) &&
+	  0 == strcmp (xt->name, xn_short_name))
+	{
+	  char *val_str = asn1_buf_to_c_string (&xn->val, gc);
+	  do_setenv_x509 (es, xt->name, val_str, depth);
+	}
+    }
+}
+
+void
+x509_track_add (const struct x509_track **ll_head, const char *name, int msglevel, struct gc_arena *gc)
+{
+  struct x509_track *xt;
+  ALLOC_OBJ_CLEAR_GC (xt, struct x509_track, gc);
+  if (*name == '+')
+    {
+      xt->flags |= XT_FULL_CHAIN;
+      ++name;
+    }
+  xt->name = name;
+  xt->next = *ll_head;
+  *ll_head = xt;
+}
+
+void
+x509_setenv_track (const struct x509_track *xt, struct env_set *es,
+    const int depth, mbedtls_x509_crt *cert)
+{
+  struct gc_arena gc = gc_new();
+  while (xt)
+    {
+      if (depth == 0 || (xt->flags & XT_FULL_CHAIN))
+	{
+	  if (0 == strcmp(xt->name, "SHA1"))
+	    {
+	      /* SHA1 fingerprint is not part of X509 structure */
+	      unsigned char *sha1_hash = x509_get_sha1_hash(cert, &gc);
+	      char *sha1_fingerprint = format_hex_ex(sha1_hash, SHA_DIGEST_LENGTH, 0, 1 | FHE_CAPS, ":", &gc);
+	      do_setenv_x509(es, xt->name, sha1_fingerprint, depth);
+	    }
+	  else
+	    {
+	      do_setenv_name(es, xt, cert, depth, &gc);
+	    }
+	}
+      xt = xt->next;
+    }
+  gc_free(&gc);
+}
+
+/*
+ * Save X509 fields to environment, using the naming convention:
+ *
+ * X509_{cert_depth}_{name}={value}
+ */
+void
+x509_setenv (struct env_set *es, int cert_depth, mbedtls_x509_crt *cert)
+{
+  int i;
+  unsigned char c;
+  const mbedtls_x509_name *name;
+  char s[128];
+
+  name = &cert->subject;
+
+  memset( s, 0, sizeof( s ) );
+
+  while( name != NULL )
+    {
+      char name_expand[64+8];
+      const char *shortname;
+
+      if( 0 == mbedtls_oid_get_attr_short_name(&name->oid, &shortname) )
+	{
+	  openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_%s",
+	      cert_depth, shortname);
+	}
+      else
+	{
+	  openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_\?\?",
+	      cert_depth);
+	}
+
+      for( i = 0; i < name->val.len; i++ )
+	{
+	  if( i >= (int) sizeof( s ) - 1 )
+	      break;
+
+	  c = name->val.p[i];
+	  if( c < 32 || c == 127 || ( c > 128 && c < 160 ) )
+	       s[i] = '?';
+	  else s[i] = c;
+	}
+	s[i] = '\0';
+
+	/* Check both strings, set environment variable */
+	string_mod (name_expand, CC_PRINT, CC_CRLF, '_');
+	string_mod ((char*)s, CC_PRINT, CC_CRLF, '_');
+	setenv_str_incr (es, name_expand, (char*)s);
+
+	name = name->next;
+    }
+}
+
+result_t
+x509_verify_ns_cert_type(const mbedtls_x509_crt *cert, const int usage)
+{
+  if (usage == NS_CERT_CHECK_NONE)
+    return SUCCESS;
+  if (usage == NS_CERT_CHECK_CLIENT)
+    return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
+	&& (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_CLIENT)) ?
+	    SUCCESS : FAILURE;
+  if (usage == NS_CERT_CHECK_SERVER)
+    return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
+	&& (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_SERVER)) ?
+	    SUCCESS : FAILURE;
+
+  return FAILURE;
+}
+
+result_t
+x509_verify_cert_ku (mbedtls_x509_crt *cert, const unsigned * const expected_ku,
+    int expected_len)
+{
+  result_t fFound = FAILURE;
+
+  if(!(cert->ext_types & MBEDTLS_X509_EXT_KEY_USAGE))
+    {
+      msg (D_HANDSHAKE, "Certificate does not have key usage extension");
+    }
+  else
+    {
+      int i;
+      unsigned nku = cert->key_usage;
+
+      msg (D_HANDSHAKE, "Validating certificate key usage");
+      for (i=0; SUCCESS != fFound && i<expected_len; i++)
+	{
+	  if (expected_ku[i] != 0)
+	    {
+	      msg (D_HANDSHAKE, "++ Certificate has key usage  %04x, expects "
+		  "%04x", nku, expected_ku[i]);
+
+	      if (nku == expected_ku[i])
+		{
+		  fFound = SUCCESS;
+		}
+	    }
+	}
+    }
+  return fFound;
+}
+
+result_t
+x509_verify_cert_eku (mbedtls_x509_crt *cert, const char * const expected_oid)
+{
+  result_t fFound = FAILURE;
+
+  if (!(cert->ext_types & MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))
+    {
+      msg (D_HANDSHAKE, "Certificate does not have extended key usage extension");
+    }
+  else
+    {
+      mbedtls_x509_sequence *oid_seq = &(cert->ext_key_usage);
+
+      msg (D_HANDSHAKE, "Validating certificate extended key usage");
+      while (oid_seq != NULL)
+	{
+	  mbedtls_x509_buf *oid = &oid_seq->buf;
+	  char oid_num_str[1024];
+	  const char *oid_str;
+
+	  if (0 == mbedtls_oid_get_extended_key_usage( oid, &oid_str ))
+	    {
+	      msg (D_HANDSHAKE, "++ Certificate has EKU (str) %s, expects %s",
+		  oid_str, expected_oid);
+	      if (!strcmp (expected_oid, oid_str))
+		{
+		  fFound = SUCCESS;
+		  break;
+		}
+	    }
+
+	  if (0 < mbedtls_oid_get_numeric_string( oid_num_str,
+	      sizeof (oid_num_str), oid))
+	    {
+	      msg (D_HANDSHAKE, "++ Certificate has EKU (oid) %s, expects %s",
+		  oid_num_str, expected_oid);
+	      if (!strcmp (expected_oid, oid_num_str))
+		{
+		  fFound = SUCCESS;
+		  break;
+		}
+	    }
+	  oid_seq = oid_seq->next;
+	}
+    }
+
+    return fFound;
+}
+
+result_t
+x509_write_pem(FILE *peercert_file, mbedtls_x509_crt *peercert)
+{
+    msg (M_WARN, "mbed TLS does not support writing peer certificate in PEM format");
+    return FAILURE;
+}
+
+/*
+ * check peer cert against CRL
+ */
+result_t
+x509_verify_crl(const char *crl_file, const char *crl_inline,
+                mbedtls_x509_crt *cert, const char *subject)
+{
+  result_t retval = FAILURE;
+  mbedtls_x509_crl crl = {0};
+  struct gc_arena gc = gc_new();
+  char *serial;
+
+  if (!strcmp (crl_file, INLINE_FILE_TAG) && crl_inline)
+    {
+      if (!mbed_ok(mbedtls_x509_crl_parse(&crl,
+	  (const unsigned char *)crl_inline, strlen(crl_inline)+1)))
+        {
+           msg (M_WARN, "CRL: cannot parse inline CRL");
+           goto end;
+        }
+    }
+  else
+    {
+      if (!mbed_ok(mbedtls_x509_crl_parse_file(&crl, crl_file)))
+      {
+          msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
+          goto end;
+      }
+  }
+
+  if(cert->issuer_raw.len != crl.issuer_raw.len ||
+      memcmp(crl.issuer_raw.p, cert->issuer_raw.p, crl.issuer_raw.len) != 0)
+    {
+      msg (M_WARN, "CRL: CRL %s is from a different issuer than the issuer of "
+	  "certificate %s", crl_file, subject);
+      retval = SUCCESS;
+      goto end;
+    }
+
+  if (!mbed_ok(mbedtls_x509_crt_is_revoked(cert, &crl)))
+    {
+      serial = backend_x509_get_serial_hex(cert, &gc);
+      msg (D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", subject, (serial ? serial : "NOT AVAILABLE"));
+      goto end;
+    }
+
+  retval = SUCCESS;
+  msg (D_HANDSHAKE, "CRL CHECK OK: %s",subject);
+
+end:
+  gc_free(&gc);
+  mbedtls_x509_crl_free(&crl);
+  return retval;
+}
+
+#endif /* #if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
new file mode 100644
index 0000000..e26d08f
--- /dev/null
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -0,0 +1,78 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file Control Channel Verification Module mbed TLS backend
+ */
+
+#ifndef SSL_VERIFY_MBEDTLS_H_
+#define SSL_VERIFY_MBEDTLS_H_
+
+#include "syshead.h"
+#include <mbedtls/x509_crt.h>
+
+#ifndef __OPENVPN_X509_CERT_T_DECLARED
+#define __OPENVPN_X509_CERT_T_DECLARED
+typedef mbedtls_x509_crt openvpn_x509_cert_t;
+#endif
+
+/** @name Function for authenticating a new connection from a remote OpenVPN peer
+ *  @{ */
+
+/**
+ * Verify that the remote OpenVPN peer's certificate allows setting up a
+ * VPN tunnel.
+ * @ingroup control_tls
+ *
+ * This callback function is called when a new TLS session is being setup to
+ * determine whether the remote OpenVPN peer's certificate is allowed to
+ * connect. It is called for once for every certificate in the chain. The
+ * callback functionality is configured in the \c init_ssl() function, which
+ * calls the mbed TLS library's \c ssl_set_verify_callback() function with \c
+ * verify_callback() as its callback argument.
+ *
+ * It checks *flags and registers the certificate hash. If these steps succeed,
+ * it calls the \c verify_cert() function, which performs OpenVPN-specific
+ * verification.
+ *
+ * @param session_obj  - The OpenVPN \c tls_session associated with this object,
+ *                       as set during SSL session setup.
+ * @param cert         - The certificate used by mbed TLS.
+ * @param cert_depth   - The depth of the current certificate in the chain, with
+ *                       0 being the actual certificate.
+ * @param flags        - Whether the remote OpenVPN peer's certificate
+ *                       passed verification.  A value of 0 means it
+ *                       verified successfully, any other value means it
+ *                       failed. \c verify_callback() is considered to have
+ *                       ok'ed this certificate if flags is 0 when it returns.
+ *
+ * @return The return value is 0 unless a fatal error occurred.
+ */
+int verify_callback (void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
+    uint32_t *flags);
+
+/** @} name Function for authenticating a new connection from a remote OpenVPN peer */
+
+#endif /* SSL_VERIFY_MBEDTLS_H_ */
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
deleted file mode 100644
index ff76d3d..0000000
--- a/src/openvpn/ssl_verify_polarssl.c
+++ /dev/null
@@ -1,508 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/**
- * @file Control Channel Verification Module mbed TLS backend
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-
-#include "syshead.h"
-
-#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
-
-#include "crypto_polarssl.h"
-#include "ssl_verify.h"
-#include <mbedtls/asn1.h>
-#include <mbedtls/error.h>
-#include <mbedtls/bignum.h>
-#include <mbedtls/oid.h>
-#include <mbedtls/sha1.h>
-
-#define MAX_SUBJECT_LENGTH 256
-
-int
-verify_callback (void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
-    uint32_t *flags)
-{
-  struct tls_session *session = (struct tls_session *) session_obj;
-  struct gc_arena gc = gc_new();
-
-  ASSERT (cert);
-  ASSERT (session);
-
-  session->verified = false;
-
-  /* Remember certificate hash */
-  cert_hash_remember (session, cert_depth, x509_get_sha1_hash(cert, &gc));
-
-  /* did peer present cert which was signed by our root cert? */
-  if (*flags != 0)
-    {
-      char *subject = x509_get_subject(cert, &gc);
-
-      if (subject)
-	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, flags=%x, %s", cert_depth, *flags, subject);
-      else
-	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, flags=%x, could not extract X509 "
-	      "subject string from certificate", *flags, cert_depth);
-
-      /* Leave flags set to non-zero to indicate that the cert is not ok */
-    }
-  else if (SUCCESS != verify_cert(session, cert, cert_depth))
-    {
-      *flags |= MBEDTLS_X509_BADCERT_OTHER;
-    }
-
-  gc_free(&gc);
-
-  /*
-   * PolarSSL/mbed TLS-1.2.0+ expects 0 on anything except fatal errors.
-   */
-  return 0;
-}
-
-#ifdef ENABLE_X509ALTUSERNAME
-# warning "X509 alt user name not yet supported for mbed TLS"
-#endif
-
-result_t
-backend_x509_get_username (char *cn, int cn_len,
-    char *x509_username_field, mbedtls_x509_crt *cert)
-{
-  mbedtls_x509_name *name;
-
-  ASSERT( cn != NULL );
-
-  name = &cert->subject;
-
-  /* Find common name */
-  while( name != NULL )
-  {
-      if (0 == memcmp (name->oid.p, MBEDTLS_OID_AT_CN,
-	  MBEDTLS_OID_SIZE (MBEDTLS_OID_AT_CN)))
-	break;
-
-      name = name->next;
-  }
-
-  /* Not found, return an error if this is the peer's certificate */
-  if( name == NULL )
-      return FAILURE;
-
-  /* Found, extract CN */
-  if (cn_len > name->val.len)
-    {
-      memcpy( cn, name->val.p, name->val.len );
-      cn[name->val.len] = '\0';
-    }
-  else
-    {
-      memcpy( cn, name->val.p, cn_len);
-      cn[cn_len-1] = '\0';
-    }
-
-  return SUCCESS;
-}
-
-char *
-backend_x509_get_serial (mbedtls_x509_crt *cert, struct gc_arena *gc)
-{
-  char *buf = NULL;
-  size_t buflen = 0;
-  mbedtls_mpi serial_mpi = { 0 };
-
-  /* Transform asn1 integer serial into mbed TLS MPI */
-  mbedtls_mpi_init(&serial_mpi);
-  if (!mbed_ok(mbedtls_mpi_read_binary(&serial_mpi, cert->serial.p,
-      cert->serial.len)))
-    {
-      msg(M_WARN, "Failed to retrieve serial from certificate.");
-      return NULL;
-    }
-
-  /* Determine decimal representation length, allocate buffer */
-  mbedtls_mpi_write_string(&serial_mpi, 10, NULL, 0, &buflen);
-  buf = gc_malloc(buflen, true, gc);
-
-  /* Write MPI serial as decimal string into buffer */
-  if (!mbed_ok(mbedtls_mpi_write_string(&serial_mpi, 10, buf, buflen, &buflen)))
-    {
-      msg(M_WARN, "Failed to write serial to string.");
-      return NULL;
-    }
-
-  return buf;
-}
-
-char *
-backend_x509_get_serial_hex (mbedtls_x509_crt *cert, struct gc_arena *gc)
-{
-  char *buf = NULL;
-  size_t len = cert->serial.len * 3 + 1;
-
-  buf = gc_malloc(len, true, gc);
-
-  if(mbedtls_x509_serial_gets(buf, len-1, &cert->serial) < 0)
-    buf = NULL;
-
-  return buf;
-}
-
-unsigned char *
-x509_get_sha1_hash (mbedtls_x509_crt *cert, struct gc_arena *gc)
-{
-  unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
-  mbedtls_sha1(cert->raw.p, cert->tbs.len, sha1_hash);
-  return sha1_hash;
-}
-
-char *
-x509_get_subject(mbedtls_x509_crt *cert, struct gc_arena *gc)
-{
-  char tmp_subject[MAX_SUBJECT_LENGTH] = {0};
-  char *subject = NULL;
-
-  int ret = 0;
-
-  ret = mbedtls_x509_dn_gets( tmp_subject, MAX_SUBJECT_LENGTH-1, &cert->subject );
-  if (ret > 0)
-    {
-      /* Allocate the required space for the subject */
-      subject = string_alloc(tmp_subject, gc);
-    }
-
-  return subject;
-}
-
-static void
-do_setenv_x509 (struct env_set *es, const char *name, char *value, int depth)
-{
-  char *name_expand;
-  size_t name_expand_size;
-
-  string_mod (value, CC_ANY, CC_CRLF, '?');
-  msg (D_X509_ATTR, "X509 ATTRIBUTE name='%s' value='%s' depth=%d", name, value, depth);
-  name_expand_size = 64 + strlen (name);
-  name_expand = (char *) malloc (name_expand_size);
-  check_malloc_return (name_expand);
-  openvpn_snprintf (name_expand, name_expand_size, "X509_%d_%s", depth, name);
-  setenv_str (es, name_expand, value);
-  free (name_expand);
-}
-
-static char *
-asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)
-{
-  size_t i;
-  char *val;
-
-  for (i = 0; i < orig->len; ++i)
-    if (orig->p[i] == '\0')
-      return "ERROR: embedded null value";
-  val = gc_malloc(orig->len+1, false, gc);
-  memcpy(val, orig->p, orig->len);
-  val[orig->len] = '\0';
-  return val;
-}
-
-static void
-do_setenv_name(struct env_set *es, const struct x509_track *xt,
-	       const mbedtls_x509_crt *cert, int depth, struct gc_arena *gc)
-{
-  const mbedtls_x509_name *xn;
-  for (xn = &cert->subject; xn != NULL; xn = xn->next)
-    {
-      const char *xn_short_name = NULL;
-      if (0 == mbedtls_oid_get_attr_short_name (&xn->oid, &xn_short_name) &&
-	  0 == strcmp (xt->name, xn_short_name))
-	{
-	  char *val_str = asn1_buf_to_c_string (&xn->val, gc);
-	  do_setenv_x509 (es, xt->name, val_str, depth);
-	}
-    }
-}
-
-void
-x509_track_add (const struct x509_track **ll_head, const char *name, int msglevel, struct gc_arena *gc)
-{
-  struct x509_track *xt;
-  ALLOC_OBJ_CLEAR_GC (xt, struct x509_track, gc);
-  if (*name == '+')
-    {
-      xt->flags |= XT_FULL_CHAIN;
-      ++name;
-    }
-  xt->name = name;
-  xt->next = *ll_head;
-  *ll_head = xt;
-}
-
-void
-x509_setenv_track (const struct x509_track *xt, struct env_set *es,
-    const int depth, mbedtls_x509_crt *cert)
-{
-  struct gc_arena gc = gc_new();
-  while (xt)
-    {
-      if (depth == 0 || (xt->flags & XT_FULL_CHAIN))
-	{
-	  if (0 == strcmp(xt->name, "SHA1"))
-	    {
-	      /* SHA1 fingerprint is not part of X509 structure */
-	      unsigned char *sha1_hash = x509_get_sha1_hash(cert, &gc);
-	      char *sha1_fingerprint = format_hex_ex(sha1_hash, SHA_DIGEST_LENGTH, 0, 1 | FHE_CAPS, ":", &gc);
-	      do_setenv_x509(es, xt->name, sha1_fingerprint, depth);
-	    }
-	  else
-	    {
-	      do_setenv_name(es, xt, cert, depth, &gc);
-	    }
-	}
-      xt = xt->next;
-    }
-  gc_free(&gc);
-}
-
-/*
- * Save X509 fields to environment, using the naming convention:
- *
- * X509_{cert_depth}_{name}={value}
- */
-void
-x509_setenv (struct env_set *es, int cert_depth, mbedtls_x509_crt *cert)
-{
-  int i;
-  unsigned char c;
-  const mbedtls_x509_name *name;
-  char s[128];
-
-  name = &cert->subject;
-
-  memset( s, 0, sizeof( s ) );
-
-  while( name != NULL )
-    {
-      char name_expand[64+8];
-      const char *shortname;
-
-      if( 0 == mbedtls_oid_get_attr_short_name(&name->oid, &shortname) )
-	{
-	  openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_%s",
-	      cert_depth, shortname);
-	}
-      else
-	{
-	  openvpn_snprintf (name_expand, sizeof(name_expand), "X509_%d_\?\?",
-	      cert_depth);
-	}
-
-      for( i = 0; i < name->val.len; i++ )
-	{
-	  if( i >= (int) sizeof( s ) - 1 )
-	      break;
-
-	  c = name->val.p[i];
-	  if( c < 32 || c == 127 || ( c > 128 && c < 160 ) )
-	       s[i] = '?';
-	  else s[i] = c;
-	}
-	s[i] = '\0';
-
-	/* Check both strings, set environment variable */
-	string_mod (name_expand, CC_PRINT, CC_CRLF, '_');
-	string_mod ((char*)s, CC_PRINT, CC_CRLF, '_');
-	setenv_str_incr (es, name_expand, (char*)s);
-
-	name = name->next;
-    }
-}
-
-result_t
-x509_verify_ns_cert_type(const mbedtls_x509_crt *cert, const int usage)
-{
-  if (usage == NS_CERT_CHECK_NONE)
-    return SUCCESS;
-  if (usage == NS_CERT_CHECK_CLIENT)
-    return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
-	&& (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_CLIENT)) ?
-	    SUCCESS : FAILURE;
-  if (usage == NS_CERT_CHECK_SERVER)
-    return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
-	&& (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_SERVER)) ?
-	    SUCCESS : FAILURE;
-
-  return FAILURE;
-}
-
-result_t
-x509_verify_cert_ku (mbedtls_x509_crt *cert, const unsigned * const expected_ku,
-    int expected_len)
-{
-  result_t fFound = FAILURE;
-
-  if(!(cert->ext_types & MBEDTLS_X509_EXT_KEY_USAGE))
-    {
-      msg (D_HANDSHAKE, "Certificate does not have key usage extension");
-    }
-  else
-    {
-      int i;
-      unsigned nku = cert->key_usage;
-
-      msg (D_HANDSHAKE, "Validating certificate key usage");
-      for (i=0; SUCCESS != fFound && i<expected_len; i++)
-	{
-	  if (expected_ku[i] != 0)
-	    {
-	      msg (D_HANDSHAKE, "++ Certificate has key usage  %04x, expects "
-		  "%04x", nku, expected_ku[i]);
-
-	      if (nku == expected_ku[i])
-		{
-		  fFound = SUCCESS;
-		}
-	    }
-	}
-    }
-  return fFound;
-}
-
-result_t
-x509_verify_cert_eku (mbedtls_x509_crt *cert, const char * const expected_oid)
-{
-  result_t fFound = FAILURE;
-
-  if (!(cert->ext_types & MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))
-    {
-      msg (D_HANDSHAKE, "Certificate does not have extended key usage extension");
-    }
-  else
-    {
-      mbedtls_x509_sequence *oid_seq = &(cert->ext_key_usage);
-
-      msg (D_HANDSHAKE, "Validating certificate extended key usage");
-      while (oid_seq != NULL)
-	{
-	  mbedtls_x509_buf *oid = &oid_seq->buf;
-	  char oid_num_str[1024];
-	  const char *oid_str;
-
-	  if (0 == mbedtls_oid_get_extended_key_usage( oid, &oid_str ))
-	    {
-	      msg (D_HANDSHAKE, "++ Certificate has EKU (str) %s, expects %s",
-		  oid_str, expected_oid);
-	      if (!strcmp (expected_oid, oid_str))
-		{
-		  fFound = SUCCESS;
-		  break;
-		}
-	    }
-
-	  if (0 < mbedtls_oid_get_numeric_string( oid_num_str,
-	      sizeof (oid_num_str), oid))
-	    {
-	      msg (D_HANDSHAKE, "++ Certificate has EKU (oid) %s, expects %s",
-		  oid_num_str, expected_oid);
-	      if (!strcmp (expected_oid, oid_num_str))
-		{
-		  fFound = SUCCESS;
-		  break;
-		}
-	    }
-	  oid_seq = oid_seq->next;
-	}
-    }
-
-    return fFound;
-}
-
-result_t
-x509_write_pem(FILE *peercert_file, mbedtls_x509_crt *peercert)
-{
-    msg (M_WARN, "mbed TLS does not support writing peer certificate in PEM format");
-    return FAILURE;
-}
-
-/*
- * check peer cert against CRL
- */
-result_t
-x509_verify_crl(const char *crl_file, const char *crl_inline,
-                mbedtls_x509_crt *cert, const char *subject)
-{
-  result_t retval = FAILURE;
-  mbedtls_x509_crl crl = {0};
-  struct gc_arena gc = gc_new();
-  char *serial;
-
-  if (!strcmp (crl_file, INLINE_FILE_TAG) && crl_inline)
-    {
-      if (!mbed_ok(mbedtls_x509_crl_parse(&crl,
-	  (const unsigned char *)crl_inline, strlen(crl_inline)+1)))
-        {
-           msg (M_WARN, "CRL: cannot parse inline CRL");
-           goto end;
-        }
-    }
-  else
-    {
-      if (!mbed_ok(mbedtls_x509_crl_parse_file(&crl, crl_file)))
-      {
-          msg (M_WARN, "CRL: cannot read CRL from file %s", crl_file);
-          goto end;
-      }
-  }
-
-  if(cert->issuer_raw.len != crl.issuer_raw.len ||
-      memcmp(crl.issuer_raw.p, cert->issuer_raw.p, crl.issuer_raw.len) != 0)
-    {
-      msg (M_WARN, "CRL: CRL %s is from a different issuer than the issuer of "
-	  "certificate %s", crl_file, subject);
-      retval = SUCCESS;
-      goto end;
-    }
-
-  if (!mbed_ok(mbedtls_x509_crt_is_revoked(cert, &crl)))
-    {
-      serial = backend_x509_get_serial_hex(cert, &gc);
-      msg (D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", subject, (serial ? serial : "NOT AVAILABLE"));
-      goto end;
-    }
-
-  retval = SUCCESS;
-  msg (D_HANDSHAKE, "CRL CHECK OK: %s",subject);
-
-end:
-  gc_free(&gc);
-  mbedtls_x509_crl_free(&crl);
-  return retval;
-}
-
-#endif /* #if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/ssl_verify_polarssl.h b/src/openvpn/ssl_verify_polarssl.h
deleted file mode 100644
index e26d08f..0000000
--- a/src/openvpn/ssl_verify_polarssl.h
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/**
- * @file Control Channel Verification Module mbed TLS backend
- */
-
-#ifndef SSL_VERIFY_MBEDTLS_H_
-#define SSL_VERIFY_MBEDTLS_H_
-
-#include "syshead.h"
-#include <mbedtls/x509_crt.h>
-
-#ifndef __OPENVPN_X509_CERT_T_DECLARED
-#define __OPENVPN_X509_CERT_T_DECLARED
-typedef mbedtls_x509_crt openvpn_x509_cert_t;
-#endif
-
-/** @name Function for authenticating a new connection from a remote OpenVPN peer
- *  @{ */
-
-/**
- * Verify that the remote OpenVPN peer's certificate allows setting up a
- * VPN tunnel.
- * @ingroup control_tls
- *
- * This callback function is called when a new TLS session is being setup to
- * determine whether the remote OpenVPN peer's certificate is allowed to
- * connect. It is called for once for every certificate in the chain. The
- * callback functionality is configured in the \c init_ssl() function, which
- * calls the mbed TLS library's \c ssl_set_verify_callback() function with \c
- * verify_callback() as its callback argument.
- *
- * It checks *flags and registers the certificate hash. If these steps succeed,
- * it calls the \c verify_cert() function, which performs OpenVPN-specific
- * verification.
- *
- * @param session_obj  - The OpenVPN \c tls_session associated with this object,
- *                       as set during SSL session setup.
- * @param cert         - The certificate used by mbed TLS.
- * @param cert_depth   - The depth of the current certificate in the chain, with
- *                       0 being the actual certificate.
- * @param flags        - Whether the remote OpenVPN peer's certificate
- *                       passed verification.  A value of 0 means it
- *                       verified successfully, any other value means it
- *                       failed. \c verify_callback() is considered to have
- *                       ok'ed this certificate if flags is 0 when it returns.
- *
- * @return The return value is 0 unless a fatal error occurred.
- */
-int verify_callback (void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
-    uint32_t *flags);
-
-/** @} name Function for authenticating a new connection from a remote OpenVPN peer */
-
-#endif /* SSL_VERIFY_MBEDTLS_H_ */
-- 
2.5.0


