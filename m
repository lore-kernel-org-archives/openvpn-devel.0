From: Gert Doering <gert@...1296...>
Date: Sat, 21 Dec 2024 23:24:04 +0100
Message-ID: <20241221222404.10266-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
References: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] Implement HKDF expand function based on
 RFC 8446
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

From: Arne Schwabe <arne@...1227...>

Use crypto_epoch.c/h for the new functions since they are
linked to the epoch key usage in OpenVPN.

Change-Id: I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/798
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index ca58cd7..61f0cc5 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -387,6 +387,8 @@
     src/openvpn/crypto.c
     src/openvpn/crypto.h
     src/openvpn/crypto_backend.h
+    src/openvpn/crypto_epoch.c
+    src/openvpn/crypto_epoch.h
     src/openvpn/crypto_openssl.c
     src/openvpn/crypto_openssl.h
     src/openvpn/crypto_mbedtls.c
@@ -715,6 +717,7 @@
     target_sources(test_crypto PRIVATE
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
+        src/openvpn/crypto_epoch.c
         src/openvpn/crypto.c
         src/openvpn/otime.c
         src/openvpn/packet_id.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index ecb2bcf..d6d6592 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -53,6 +53,7 @@
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_mbedtls.c crypto_mbedtls.h \
+	crypto_epoch.c crypto_epoch.h \
 	dco.c dco.h dco_internal.h \
 	dco_freebsd.c dco_freebsd.h \
 	dco_linux.c dco_linux.h \
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
new file mode 100644
index 0000000..667e12a6
--- /dev/null
+++ b/src/openvpn/crypto_epoch.c
@@ -0,0 +1,114 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2024 Arne Schwabe <arne@...1227...>
+ *
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
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include <inttypes.h>
+#include "crypto_backend.h"
+#include "buffer.h"
+#include "integer.h"
+
+void
+ovpn_hkdf_expand(const uint8_t *secret,
+                 const uint8_t *info, int info_len,
+                 uint8_t *out, int out_len)
+{
+    hmac_ctx_t *hmac_ctx = hmac_ctx_new();
+    hmac_ctx_init(hmac_ctx, secret, "SHA256");
+
+    const int digest_size = SHA256_DIGEST_LENGTH;
+
+    /* T(0) = empty string */
+    uint8_t t_prev[SHA256_DIGEST_LENGTH];
+    int t_prev_len = 0;
+
+    for (uint8_t block = 1; (block - 1) * digest_size < out_len; block++)
+    {
+        hmac_ctx_reset(hmac_ctx);
+
+        /* calculate T(block) */
+        hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);
+        hmac_ctx_update(hmac_ctx, info, info_len);
+        hmac_ctx_update(hmac_ctx, &block, 1);
+        hmac_ctx_final(hmac_ctx, t_prev);
+        t_prev_len = digest_size;
+
+        /* Copy a full hmac output or remaining bytes */
+        int out_offset = (block - 1) * digest_size;
+        int copylen = min_int(digest_size, out_len - out_offset);
+
+        memcpy(out + out_offset, t_prev, copylen);
+    }
+    hmac_ctx_cleanup(hmac_ctx);
+    hmac_ctx_free(hmac_ctx);
+}
+
+bool
+ovpn_expand_label(const uint8_t *secret, size_t secret_len,
+                  const uint8_t *label, size_t label_len,
+                  const uint8_t *context, size_t context_len,
+                  uint8_t *out, uint16_t out_len)
+{
+    if (secret_len != 32 || label_len > 250 || context_len > 255
+        || label_len < 1)
+    {
+        /* Our current implementation is not a general purpose one
+         * and assumes that the secret size matches the size of the
+         * hash (SHA256) key. Also label length and context length
+         * need need to be in range */
+        return false;
+    }
+
+    struct gc_arena gc = gc_new();
+    /* 2 byte for the outlen encoded as uint16, 5 bytes for "ovpn ",
+     * 1 byte for context len byte and 1 byte for label len byte */
+    const uint8_t *label_prefix = (const uint8_t *) ("ovpn ");
+    int prefix_len = 5;
+
+    int hkdf_label_len = 2 + prefix_len + 1 + label_len + 1 + context_len;
+    struct buffer hkdf_label = alloc_buf_gc(hkdf_label_len, &gc);
+
+    buf_write_u16(&hkdf_label, out_len);
+    buf_write_u8(&hkdf_label, prefix_len + label_len);
+    buf_write(&hkdf_label, label_prefix, prefix_len);
+    buf_write(&hkdf_label, label, label_len);
+
+    buf_write_u8(&hkdf_label, context_len);
+    if (context_len > 0)
+    {
+        buf_write(&hkdf_label, context, context_len);
+    }
+
+    ASSERT(buf_len(&hkdf_label) == hkdf_label_len);
+
+    ovpn_hkdf_expand(secret, buf_bptr(&hkdf_label),
+                     buf_len(&hkdf_label), out, out_len);
+
+    gc_free(&gc);
+    return true;
+}
diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h
new file mode 100644
index 0000000..e5d0e5d
--- /dev/null
+++ b/src/openvpn/crypto_epoch.h
@@ -0,0 +1,70 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2024 Arne Schwabe <arne@...1227...>
+ *
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
+#ifndef CRYPTO_EPOCH_H
+#define CRYPTO_EPOCH_H
+
+/**
+ * Implementation of the RFC5869 HKDF-Expand function with the following
+ * restrictions
+ *
+ *  - secret is assumed to be always 32 bytes
+ *  - HASH is always SHA256
+ *
+ *  @param secret   the input keying material (HMAC key)
+ *  @param info     context and application specific information
+ *  @param info_len length of the info string
+ *  @param out      output keying material
+ *  @param out_len  length of output keying material
+ */
+void
+ovpn_hkdf_expand(const uint8_t *secret,
+                 const uint8_t *info, int info_len,
+                 uint8_t *out, int out_len);
+
+/**
+ * Variant of the RFC 8446 TLS 1.3  HKDF-Expand-Label function with the
+ * following differences/restrictions:
+ *  - secret must 32 bytes in length
+ *  - label prefix is "ovpn " instead of "tls13 "
+ *  - HASH is always SHA256
+ *
+ * @param secret        Input secret
+ * @param secret_len    length of the input secret
+ * @param label         Label for the exported key material
+ * @param label_len     length of the label
+ * @param context       optional context
+ * @param context_len   length of the context
+ * @param out      output keying material
+ * @param out_len  length of output keying material
+ * @return
+ */
+bool
+ovpn_expand_label(const uint8_t *secret, size_t secret_len,
+                  const uint8_t *label, size_t label_len,
+                  const uint8_t *context, size_t context_len,
+                  uint8_t *out, uint16_t out_len);
+
+#endif
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index a966a7a..fe51359 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -29,6 +29,7 @@
 #ifndef CRYPTO_MBEDTLS_H_
 #define CRYPTO_MBEDTLS_H_
 
+#include <stdbool.h>
 #include <mbedtls/cipher.h>
 #include <mbedtls/md.h>
 #include <mbedtls/ctr_drbg.h>
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index a4e6235..307f9ed 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -66,6 +66,7 @@
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/packet_id.c \
 	$(top_srcdir)/src/openvpn/platform.c \
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index ec8e661..e16296b 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -35,12 +35,19 @@
 #include <cmocka.h>
 
 #include "crypto.h"
+#include "crypto_epoch.h"
 #include "options.h"
 #include "ssl_backend.h"
 
 #include "mss.h"
 #include "test_common.h"
 
+
+#if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >= 0x30000000L
+#include <openssl/core_names.h>
+#include <openssl/kdf.h>
+#endif
+
 static const char testtext[] = "Dummy text to test PEM encoding";
 
 static void
@@ -471,6 +478,236 @@
     assert_int_equal(aeslimit / L, 122059461);
 }
 
+void
+crypto_test_hkdf_expand_testa1(void **state)
+{
+    /* RFC 5889 A.1 Test Case 1 */
+    uint8_t prk[32] =
+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,
+     0x0d, 0xdc, 0x3f, 0x0d, 0xc4, 0x7b, 0xba, 0x63,
+     0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,
+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};
+
+    uint8_t info[10] = {0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5,
+                        0xf6, 0xf7, 0xf8, 0xf9};
+
+    uint8_t okm[42] =
+    {0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5, 0x7a,
+     0x90, 0x43, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,
+     0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,
+     0x5d, 0xb0, 0x2d, 0x56, 0xec, 0xc4, 0xc5, 0xbf,
+     0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,
+     0x58, 0x65};
+
+    uint8_t out[42];
+    ovpn_hkdf_expand(prk, info, sizeof(info), out, sizeof(out));
+
+    assert_memory_equal(out, okm, sizeof(out));
+}
+
+void
+crypto_test_hkdf_expand_testa2(void **state)
+{
+    /* RFC 5889 A.2 Test Case 2 */
+    uint8_t prk[32] =
+    {0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a,
+     0x06, 0x10, 0x4c, 0x9c, 0xeb, 0x35, 0xb4, 0x5c,
+     0xef, 0x76, 0x00, 0x14, 0x90, 0x46, 0x71, 0x01,
+     0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44};
+
+    uint8_t info[80] =
+    {0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
+     0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
+     0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
+     0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
+     0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
+     0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
+     0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
+     0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
+     0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
+     0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff};
+
+    const int L = 82;
+    uint8_t okm[82] =
+    {0xb1, 0x1e, 0x39, 0x8d, 0xc8, 0x03, 0x27, 0xa1,
+     0xc8, 0xe7, 0xf7, 0x8c, 0x59, 0x6a, 0x49, 0x34,
+     0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, 0xfa, 0xd8,
+     0xa0, 0x50, 0xcc, 0x4c, 0x19, 0xaf, 0xa9, 0x7c,
+     0x59, 0x04, 0x5a, 0x99, 0xca, 0xc7, 0x82, 0x72,
+     0x71, 0xcb, 0x41, 0xc6, 0x5e, 0x59, 0x0e, 0x09,
+     0xda, 0x32, 0x75, 0x60, 0x0c, 0x2f, 0x09, 0xb8,
+     0x36, 0x77, 0x93, 0xa9, 0xac, 0xa3, 0xdb, 0x71,
+     0xcc, 0x30, 0xc5, 0x81, 0x79, 0xec, 0x3e, 0x87,
+     0xc1, 0x4c, 0x01, 0xd5, 0xc1, 0xf3, 0x43, 0x4f,
+     0x1d, 0x87};
+
+    uint8_t out[82] = {0xaa};
+    ovpn_hkdf_expand(prk, info, sizeof(info), out, L);
+
+    assert_memory_equal(out, okm, L);
+}
+
+void
+crypto_test_hkdf_expand_testa3(void **state)
+{
+    /* RFC 5889 A.3 Test Case 3 */
+    uint8_t prk[32] =
+    {0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16,
+     0x7f, 0x33, 0xa9, 0x1d, 0x6f, 0x64, 0x8b, 0xdf,
+     0x96, 0x59, 0x67, 0x76, 0xaf, 0xdb, 0x63, 0x77,
+     0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x04};
+
+    uint8_t info[] = {};
+
+    int L = 42;
+    uint8_t okm[42] =
+    {0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f,
+     0x71, 0x5f, 0x80, 0x2a, 0x06, 0x3c, 0x5a, 0x31,
+     0xb8, 0xa1, 0x1f, 0x5c, 0x5e, 0xe1, 0x87, 0x9e,
+     0xc3, 0x45, 0x4e, 0x5f, 0x3c, 0x73, 0x8d, 0x2d,
+     0x9d, 0x20, 0x13, 0x95, 0xfa, 0xa4, 0xb6, 0x1a,
+     0x96, 0xc8};
+
+    uint8_t out[42];
+    ovpn_hkdf_expand(prk, info, 0, out, L);
+
+    assert_memory_equal(out, okm, L);
+}
+
+void
+crypto_test_hkdf_expand_test_ovpn(void **state)
+{
+    /* tests the HDKF with a label/okm that OpenVPN itself uses in OpenSSL 3
+     * HDKF unit test*/
+
+    uint8_t prk[32] =
+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,
+     0x0d, 0xdc, 0x3f, 0x0d, 0xc4, 0x7b, 0xba, 0x63,
+     0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,
+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};
+
+    uint8_t info[18] =
+    {0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20,
+     0x75, 0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73,
+     0x74, 0x00};
+
+    int L = 27;
+    uint8_t okm[27] =
+    {0x87, 0x5a, 0x8e, 0xec, 0x18, 0x55, 0x63, 0x80,
+     0xb8, 0xd9, 0x33, 0xed, 0x32, 0x3c, 0x2d, 0xf8,
+     0xe8, 0xec, 0xcf, 0x49, 0x72, 0xe6, 0x83, 0xf0,
+     0x6a, 0x83, 0xac };
+
+    uint8_t out[27];
+    ovpn_hkdf_expand(prk, info, sizeof(info), out, L);
+
+    assert_memory_equal(out, okm, L);
+}
+
+void
+crypto_test_ovpn_label_expand(void **state)
+{
+    uint8_t secret[32] =
+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,
+     0x0d, 0xdc, 0x3f, 0x0d, 0xc4, 0x7b, 0xba, 0x63,
+     0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,
+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};
+
+    const uint8_t *label = (const uint8_t *)("unit test");
+    uint8_t out[16];
+    ovpn_expand_label(secret, sizeof(secret), label, 9, NULL, 0, out, sizeof(out));
+
+    uint8_t out_expected[16] =
+    {0x18, 0x5e, 0xaa, 0x1c, 0x7f, 0x22, 0x8a, 0xb8,
+     0xeb, 0x29, 0x77, 0x32, 0x14, 0xd9, 0x20, 0x46};
+
+    assert_memory_equal(out, out_expected, 16);
+}
+
+#if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >= 0x30000000L
+/* We have OpenSSL 3.0+, we test if their implementation matches our
+ * implementation. We currently do not use this code from the crypto library
+ * in the main code yet as we don't want to repeat the mess that the current
+ * openvpn_PRF ifdef maze */
+
+bool
+ossl_expand_label(const uint8_t *secret, size_t secret_len,
+                  const uint8_t *label, size_t label_len,
+                  const uint8_t *context, size_t context_len,
+                  uint8_t *out, uint16_t out_len)
+{
+    OSSL_LIB_CTX *libctx = NULL;
+    const char *properties = NULL;
+
+    const uint8_t *label_prefix = (const uint8_t *) ("ovpn ");
+    const size_t label_prefix_len = 5;
+
+    EVP_KDF *kdf = EVP_KDF_fetch(libctx, OSSL_KDF_NAME_TLS1_3_KDF, properties);
+    assert_non_null(kdf);
+
+    const char *mdname = "SHA-256";
+
+    size_t hashlen = SHA256_DIGEST_LENGTH;
+
+    EVP_KDF_CTX *kctx = EVP_KDF_CTX_new(kdf);
+    assert_non_null(kctx);
+
+    OSSL_PARAM params[7];
+    OSSL_PARAM *p = params;
+
+    int mode = EVP_PKEY_HKDEF_MODE_EXPAND_ONLY;
+
+    *p++ = OSSL_PARAM_construct_int(OSSL_KDF_PARAM_MODE, &mode);
+    *p++ = OSSL_PARAM_construct_utf8_string(OSSL_KDF_PARAM_DIGEST,
+                                            (char *) mdname, 0);
+    *p++ = OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_KEY,
+                                             (unsigned char *) secret, hashlen);
+    *p++ = OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_PREFIX,
+                                             (unsigned char *) label_prefix,
+                                             label_prefix_len);
+    *p++ = OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_LABEL,
+                                             (unsigned char *) label, label_len);
+
+    *p++ = OSSL_PARAM_construct_end();
+
+    int ret = EVP_KDF_derive(kctx, out, out_len, params);
+    EVP_KDF_CTX_free(kctx);
+    EVP_KDF_free(kdf);
+
+    assert_int_equal(ret, 1);
+    return true;
+}
+
+void
+crypto_test_ovpn_expand_openssl3(void **state)
+{
+    uint8_t secret[32] =
+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,
+     0x0d, 0xdc, 0x3f, 0x0d, 0xc4, 0x7b, 0xba, 0x63,
+     0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,
+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};
+
+    const uint8_t *label = (const uint8_t *) ("unit test");
+    const size_t labellen = 9;
+    uint8_t out[27];
+
+    ossl_expand_label(secret, sizeof(secret), label, labellen, NULL, 0, out, sizeof(out));
+
+    /* Do the same derivation with our own function */
+    uint8_t out_ovpn[27];
+
+    ovpn_expand_label(secret, sizeof(secret), label, 9, NULL, 0, out_ovpn, sizeof(out_ovpn));
+    assert_memory_equal(out_ovpn, out, sizeof(out_ovpn));
+}
+
+#else  /* if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >= 0x30000000L */
+void
+crypto_test_ovpn_expand_openssl3(void **state)
+{
+    skip();
+}
+#endif /* if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >= 0x30000000L */
+
 int
 main(void)
 {
@@ -482,7 +719,13 @@
         cmocka_unit_test(crypto_test_hmac),
         cmocka_unit_test(test_occ_mtu_calculation),
         cmocka_unit_test(test_mssfix_mtu_calculation),
-        cmocka_unit_test(crypto_test_aead_limits)
+        cmocka_unit_test(crypto_test_aead_limits),
+        cmocka_unit_test(crypto_test_hkdf_expand_testa1),
+        cmocka_unit_test(crypto_test_hkdf_expand_testa2),
+        cmocka_unit_test(crypto_test_hkdf_expand_testa3),
+        cmocka_unit_test(crypto_test_hkdf_expand_test_ovpn),
+        cmocka_unit_test(crypto_test_ovpn_label_expand),
+        cmocka_unit_test(crypto_test_ovpn_expand_openssl3)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

