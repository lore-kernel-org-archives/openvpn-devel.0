From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 30 Nov 2024 13:38:17 +0000
In-Reply-To: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
References: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <d1c9643a08e3447ba2ce835729e027c9d5663bdd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qGDAtR7fdGs="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement HKDF
 expand function based on RFC 8446
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qGDAtR7fdGs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, plaisthos.

Hello MaxF, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail

to look at the new patch set (#7).

The following approvals got outdated and were removed:
Code-Review+2 by MaxF, Code-Review-1 by flichtenheld


Change subject: Implement HKDF expand function based on RFC 8446
......................................................................

Implement HKDF expand function based on RFC 8446

Use crypto_epoch.c/h for the new functions since they are
linked to the epoch key usage in OpenVPN.

Change-Id: I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
A src/openvpn/crypto_epoch.c
A src/openvpn/crypto_epoch.h
M src/openvpn/crypto_mbedtls.h
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_crypto.c
7 files changed, 433 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/798/7

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
index 0000000..667e12a
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
+    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();
+    hmac_ctx_init(hmac_ctx, secret, "SHA256");
+
+    const int digest_size =3D SHA256_DIGEST_LENGTH;
+
+    /* T(0) =3D empty string */
+    uint8_t t_prev[SHA256_DIGEST_LENGTH];
+    int t_prev_len =3D 0;
+
+    for (uint8_t block =3D 1; (block - 1) * digest_size < out_len; block++)
+    {
+        hmac_ctx_reset(hmac_ctx);
+
+        /* calculate T(block) */
+        hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);
+        hmac_ctx_update(hmac_ctx, info, info_len);
+        hmac_ctx_update(hmac_ctx, &block, 1);
+        hmac_ctx_final(hmac_ctx, t_prev);
+        t_prev_len =3D digest_size;
+
+        /* Copy a full hmac output or remaining bytes */
+        int out_offset =3D (block - 1) * digest_size;
+        int copylen =3D min_int(digest_size, out_len - out_offset);
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
+    if (secret_len !=3D 32 || label_len > 250 || context_len > 255
+        || label_len < 1)
+    {
+        /* Our current implementation is not a general purpose one
+         * and assumes that the secret size matches the size of the
+         * hash (SHA256) key. Also label length and context length
+         * need need to be in range */
+        return false;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    /* 2 byte for the outlen encoded as uint16, 5 bytes for "ovpn ",
+     * 1 byte for context len byte and 1 byte for label len byte */
+    const uint8_t *label_prefix =3D (const uint8_t *) ("ovpn ");
+    int prefix_len =3D 5;
+
+    int hkdf_label_len =3D 2 + prefix_len + 1 + label_len + 1 + context_le=
n;
+    struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len, &gc);
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
+    ASSERT(buf_len(&hkdf_label) =3D=3D hkdf_label_len);
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
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
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
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index ec8e661..5deb8eb 100644
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
+#if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >=3D 0x30000=
000L
+#include <openssl/core_names.h>
+#include <openssl/kdf.h>
+#endif
+
 static const char testtext[] =3D "Dummy text to test PEM encoding";

 static void
@@ -471,6 +478,235 @@
     assert_int_equal(aeslimit / L, 122059461);
 }

+void
+crypto_test_hkdf_expand_testa1(void **state)
+{
+    /* RFC 5889 A.1 Test Case 1 */
+    uint8_t prk[32] =3D
+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,
+     0x0d, 0xdc, 0x3f, 0x0d, 0xc4, 0x7b, 0xba, 0x63,
+     0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,
+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};
+
+    uint8_t info[10] =3D {0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5,
+                        0xf6, 0xf7, 0xf8, 0xf9};
+
+    uint8_t okm[42] =3D
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
+    uint8_t prk[32] =3D
+    {0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a,
+     0x06, 0x10, 0x4c, 0x9c, 0xeb, 0x35, 0xb4, 0x5c,
+     0xef, 0x76, 0x00, 0x14, 0x90, 0x46, 0x71, 0x01,
+     0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44};
+
+    uint8_t info[80] =3D
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
+    const int L =3D 82;
+    uint8_t okm[82] =3D
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
+    uint8_t out[82] =3D {0xaa};
+    ovpn_hkdf_expand(prk, info, sizeof(info), out, L);
+
+    assert_memory_equal(out, okm, L);
+}
+
+void
+crypto_test_hkdf_expand_testa3(void **state)
+{
+    /* RFC 5889 A.3 Test Case 3 */
+    uint8_t prk[32] =3D
+    {0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16,
+     0x7f, 0x33, 0xa9, 0x1d, 0x6f, 0x64, 0x8b, 0xdf,
+     0x96, 0x59, 0x67, 0x76, 0xaf, 0xdb, 0x63, 0x77,
+     0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x04};
+
+    uint8_t info[0] =3D {};
+
+    int L =3D 42;
+    uint8_t okm[42] =3D
+    {0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f,
+     0x71, 0x5f, 0x80, 0x2a, 0x06, 0x3c, 0x5a, 0x31,
+     0xb8, 0xa1, 0x1f, 0x5c, 0x5e, 0xe1, 0x87, 0x9e,
+     0xc3, 0x45, 0x4e, 0x5f, 0x3c, 0x73, 0x8d, 0x2d,
+     0x9d, 0x20, 0x13, 0x95, 0xfa, 0xa4, 0xb6, 0x1a,
+     0x96, 0xc8};
+
+    uint8_t out[42];
+    ovpn_hkdf_expand(prk, info, sizeof(info), out, L);
+
+    assert_memory_equal(out, okm, L);
+}
+
+void
+crypto_test_hkdf_expand_test_ovpn(void **state)
+{
+    /* tests the HDKF with a label/okm that OpenVPN itself uses in OpenSSL=
 3
+     * HDKF unit test*/
+
+    uint8_t prk[32] =3D
+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,
+     0x0d, 0xdc, 0x3f, 0x0d, 0xc4, 0x7b, 0xba, 0x63,
+     0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,
+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};
+
+    uint8_t info[18] =3D
+    {0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20,
+     0x75, 0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73,
+     0x74, 0x00};
+
+    int L =3D 27;
+    uint8_t okm[27] =3D
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
+    uint8_t secret[32] =3D
+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,
+     0x0d, 0xdc, 0x3f, 0x0d, 0xc4, 0x7b, 0xba, 0x63,
+     0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,
+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};
+
+    const uint8_t *label =3D (const uint8_t *)("unit test");
+    uint8_t out[16];
+    ovpn_expand_label(secret, sizeof(secret), label, 9, NULL, 0, out, size=
of(out));
+
+    uint8_t out_expected[16] =3D
+    {0x18, 0x5e, 0xaa, 0x1c, 0x7f, 0x22, 0x8a, 0xb8,
+     0xeb, 0x29, 0x77, 0x32, 0x14, 0xd9, 0x20, 0x46};
+
+    assert_memory_equal(out, out_expected, 16);
+}
+
+#if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >=3D 0x30000=
000L
+/* We have OpenSSL 3.0+, we test if their implementation matches our
+ * implementation. We currently do not use this code from the crypto libra=
ry
+ * in the main code yet as we don't want to repeat the mess that the curre=
nt
+ * openvpn_PRF ifdef maze */
+
+bool
+ossl_expand_label(const uint8_t *secret, size_t secret_len,
+                  const uint8_t *label, size_t label_len,
+                  const uint8_t *context, size_t context_len,
+                  uint8_t *out, uint16_t out_len)
+{
+    OSSL_LIB_CTX *libctx =3D NULL;
+    const char *properties =3D NULL;
+
+    const uint8_t *label_prefix =3D (const uint8_t *) ("ovpn ");
+    const size_t label_prefix_len =3D 5;
+
+    EVP_KDF *kdf =3D EVP_KDF_fetch(libctx, OSSL_KDF_NAME_TLS1_3_KDF, prope=
rties);
+    assert_non_null(kdf);
+
+    const char *mdname =3D "SHA-256";
+
+    size_t hashlen =3D SHA256_DIGEST_LENGTH;
+
+    EVP_KDF_CTX *kctx =3D EVP_KDF_CTX_new(kdf);
+    assert_non_null(kctx);
+
+    OSSL_PARAM params[7];
+    OSSL_PARAM *p =3D params;
+
+    int mode =3D EVP_PKEY_HKDEF_MODE_EXPAND_ONLY;
+
+    *p++ =3D OSSL_PARAM_construct_int(OSSL_KDF_PARAM_MODE, &mode);
+    *p++ =3D OSSL_PARAM_construct_utf8_string(OSSL_KDF_PARAM_DIGEST,
+                                            (char *) mdname, 0);
+    *p++ =3D OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_KEY,
+                                             (unsigned char *) secret, has=
hlen);
+    *p++ =3D OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_PREFIX,
+                                             (unsigned char *) label_prefi=
x,
+                                             label_prefix_len);
+    *p++ =3D OSSL_PARAM_construct_octet_string(OSSL_KDF_PARAM_LABEL,
+                                             (unsigned char *) label, labe=
l_len);
+
+    *p++ =3D OSSL_PARAM_construct_end();
+
+    int ret =3D EVP_KDF_derive(kctx, out, out_len, params);
+    EVP_KDF_CTX_free(kctx);
+
+    assert_int_equal(ret, 1);
+    return true;
+}
+
+void
+crypto_test_ovpn_expand_openssl3(void **state)
+{
+    uint8_t secret[32] =3D
+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,
+     0x0d, 0xdc, 0x3f, 0x0d, 0xc4, 0x7b, 0xba, 0x63,
+     0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,
+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};
+
+    const uint8_t *label =3D (const uint8_t *) ("unit test");
+    const size_t labellen =3D 9;
+    uint8_t out[27];
+
+    ossl_expand_label(secret, sizeof(secret), label, labellen, NULL, 0, ou=
t, sizeof(out));
+
+    /* Do the same derivation with our own function */
+    uint8_t out_ovpn[27];
+
+    ovpn_expand_label(secret, sizeof(secret), label, 9, NULL, 0, out_ovpn,=
 sizeof(out_ovpn));
+    assert_memory_equal(out_ovpn, out, sizeof(out_ovpn));
+}
+
+#else  /* if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >=
=3D 0x30000000L */
+void
+crypto_test_ovpn_expand_openssl3(void **state)
+{
+    skip();
+}
+#endif /* if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >=
=3D 0x30000000L */
+
 int
 main(void)
 {
@@ -482,7 +718,13 @@
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc
Gerrit-Change-Number: 798
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-MessageType: newpatchset

--qGDAtR7fdGs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld, plaisthos. </=
p>
<p>plaisthos <strong>uploaded patch set #7</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by MaxF, Code-Review-1 by flichtenheld</p><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">Implement HKDF expand =
function based on RFC 8446<br><br>Use crypto_epoch.c/h for the new function=
s since they are<br>linked to the epoch key usage in OpenVPN.<br><br>Change=
-Id: I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc<br>Signed-off-by: Arne Schwa=
be &lt;arne@...1227...&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/Make=
file.am<br>A src/openvpn/crypto_epoch.c<br>A src/openvpn/crypto_epoch.h<br>=
M src/openvpn/crypto_mbedtls.h<br>M tests/unit_tests/openvpn/Makefile.am<br=
>M tests/unit_tests/openvpn/test_crypto.c<br>7 files changed, 433 insertion=
s(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/98/798/7</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.t=
xt</span><br><span>index ca58cd7..61f0cc5 100644</span><br><span>--- a/CMak=
eLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -387,6 +=
387,8 @@</span><br><span>     src/openvpn/crypto.c</span><br><span>     src=
/openvpn/crypto.h</span><br><span>     src/openvpn/crypto_backend.h</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/crypto_epoc=
h.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/=
crypto_epoch.h</span><br><span>     src/openvpn/crypto_openssl.c</span><br>=
<span>     src/openvpn/crypto_openssl.h</span><br><span>     src/openvpn/cr=
ypto_mbedtls.c</span><br><span>@@ -715,6 +717,7 @@</span><br><span>     tar=
get_sources(test_crypto PRIVATE</span><br><span>         src/openvpn/crypto=
_mbedtls.c</span><br><span>         src/openvpn/crypto_openssl.c</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/crypto_epo=
ch.c</span><br><span>         src/openvpn/crypto.c</span><br><span>        =
 src/openvpn/otime.c</span><br><span>         src/openvpn/packet_id.c</span=
><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</=
span><br><span>index ecb2bcf..d6d6592 100644</span><br><span>--- a/src/open=
vpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><sp=
an>@@ -53,6 +53,7 @@</span><br><span> 	crypto.c crypto.h crypto_backend.h \=
</span><br><span> 	crypto_openssl.c crypto_openssl.h \</span><br><span> 	cr=
ypto_mbedtls.c crypto_mbedtls.h \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	crypto_epoch.c crypto_epoch.h \</span><br><span> 	dco.c dco.=
h dco_internal.h \</span><br><span> 	dco_freebsd.c dco_freebsd.h \</span><b=
r><span> 	dco_linux.c dco_linux.h \</span><br><span>diff --git a/src/openvp=
n/crypto_epoch.c b/src/openvpn/crypto_epoch.c</span><br><span>new file mode=
 100644</span><br><span>index 0000000..667e12a</span><br><span>--- /dev/nul=
l</span><br><span>+++ b/src/openvpn/crypto_epoch.c</span><br><span>@@ -0,0 =
+1,114 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             over a single TCP/UDP port, with support for S=
SL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        session authentication and key exchange,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             packet encryption, packet authe=
ntication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet compression.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Cop=
yright (C) 2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2024 Arne Schwabe &lt;a=
rne@...1227...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; =
you can redistribute it and/or modify</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  it under the terms of the GNU General Public License =
version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pub=
lished by the Free Software Foundation.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GN=
U General Public License for more details.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  You should have received a copy of the GNU General Public License=
 along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this=
 program; if not, write to the Free Software Foundation, Inc.,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Fl=
oor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;inttypes.h&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;crypto_backend.h&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer.h&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;integer.h=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ovpn_hkdf_expand(const uint8_t *secret,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                 const uint=
8_t *info, int info_len,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                 uint8_t *out, int out_len)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_init(hmac_ctx, secret, &qu=
ot;SHA256&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int digest_=
size =3D SHA256_DIGEST_LENGTH;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* T=
(0) =3D empty string */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint8_t t_prev[SHA256_DIGEST_LENGTH];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int t_prev_len =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (uint8_t block =3D 1; (block - 1) * digest_size &lt;=
 out_len; block++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hmac_ct=
x_reset(hmac_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* calculate=
 T(block) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        hmac_ctx_update(hmac_ctx, info, info_le=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx=
_update(hmac_ctx, &amp;block, 1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        hmac_ctx_final(hmac_ctx, t_prev);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        t_prev_len =3D digest_size;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Copy a full hmac output or rem=
aining bytes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    int out_offset =3D (block - 1) * digest_size;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        int copylen =3D min_int(digest_size, =
out_len - out_offset);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(o=
ut + out_offset, t_prev, copylen);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    hmac_ctx_cleanup(hmac_ctx);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    hmac_ctx_free(hmac_ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ovpn_expand_label(const uint8_=
t *secret, size_t secret_len,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                  const uint8_t *label, size_t label_len,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  const uin=
t8_t *context, size_t context_len,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                  uint8_t *out, uint16_t out_len)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (secret_len !=3D 32 || label_len &gt; 250=
 || context_len &gt; 255</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        || label_len &lt; 1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* Our current implementation is not a general purpose one</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * and assumes that =
the secret size matches the size of the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * hash (SHA256) key. Also label length and con=
text length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * need need to be in range */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* 2 byte for the outlen encoded as uint16, 5 bytes for &quot;ovpn &quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 1 byte for c=
ontext len byte and 1 byte for label len byte */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const uint8_t *label_prefix =3D (const uin=
t8_t *) (&quot;ovpn &quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int prefix_len =3D 5;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int hkdf_label_len =3D 2 + prefix_len + 1 + label_len + 1 + context_len;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer hkdf=
_label =3D alloc_buf_gc(hkdf_label_len, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf_write_u16(&amp;hkdf_label, out_len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(&amp;hkdf_label, prefi=
x_len + label_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    buf_write(&amp;hkdf_label, label_prefix, prefix_len);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;hkdf_label, label,=
 label_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(&amp;hkdf=
_label, context_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (context_len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    buf_write(&amp;hkdf_label, context, context_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(buf_len(&amp;hkdf_label) =3D=3D hkdf_label_len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ovpn_hkdf_expand(secret, buf_bptr(&amp;hkdf_label=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
    buf_len(&amp;hkdf_label), out, out_len);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span>diff --git a/src/openvpn/crypto_epoch.h b/src/openvp=
n/crypto_epoch.h</span><br><span>new file mode 100644</span><br><span>index=
 0000000..e5d0e5d</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/crypto_epoch.h</span><br><span>@@ -0,0 +1,70 @@</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP netwo=
rks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             o=
ver a single TCP/UDP port, with support for SSL/TLS-based</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication=
 and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*             packet encryption, packet authentication, and</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2024 OpenVPN Inc &l=
t;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  Copyright (C) 2024 Arne Schwabe &lt;arne@...1227...&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is free software; you can redistribute it and/or m=
odify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under t=
he terms of the GNU General Public License version 2</span><br><span style=
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
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to the =
Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef CRYPTO_EPOCH_H</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define CRYPTO_EPOCH_H</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Imple=
mentation of the RFC5869 HKDF-Expand function with the following</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * restrictions</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  - secret is assumed to be always 32 bytes</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - HASH is always SHA2=
56</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  @param secret   the input keyi=
ng material (HMAC key)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  @param info     context and application specific information</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param info_len length =
of the info string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  @param out      output keying material</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  @param out_len  length of output keying material<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ovpn_hkdf_expand(const uint8_t *secret,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                 const uint8_t =
*info, int info_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 uint8_t *out, int out_len);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Varian=
t of the RFC 8446 TLS 1.3  HKDF-Expand-Label function with the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * following differences/restric=
tions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - secret =
must 32 bytes in length</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  - label prefix is &quot;ovpn &quot; instead of &quot;tls13 &quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - HASH is always =
SHA256</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param secret        Input =
secret</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sec=
ret_len    length of the input secret</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param label         Label for the exported key materi=
al</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param label_l=
en     length of the label</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param context       optional context</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param context_len   length of the context</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param out      ou=
tput keying material</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param out_len  length of output keying material</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_e=
xpand_label(const uint8_t *secret, size_t secret_len,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  const uint8_t *label, s=
ize_t label_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
               const uint8_t *context, size_t context_len,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                  uint8_t *out, uint=
16_t out_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>d=
iff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h</sp=
an><br><span>index a966a7a..fe51359 100644</span><br><span>--- a/src/openvp=
n/crypto_mbedtls.h</span><br><span>+++ b/src/openvpn/crypto_mbedtls.h</span=
><br><span>@@ -29,6 +29,7 @@</span><br><span> #ifndef CRYPTO_MBEDTLS_H_</sp=
an><br><span> #define CRYPTO_MBEDTLS_H_</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool.h&gt;</span><br>=
<span> #include &lt;mbedtls/cipher.h&gt;</span><br><span> #include &lt;mbed=
tls/md.h&gt;</span><br><span> #include &lt;mbedtls/ctr_drbg.h&gt;</span><br=
><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests=
/openvpn/Makefile.am</span><br><span>index a4e6235..307f9ed 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/te=
sts/unit_tests/openvpn/Makefile.am</span><br><span>@@ -66,6 +66,7 @@</span>=
<br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/crypto_mbedtls.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/crypto_openssl.c \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/otime.c \</span><br><span> 	$(top_srcdir)/src/openvpn/pac=
ket_id.c \</span><br><span> 	$(top_srcdir)/src/openvpn/platform.c \</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_t=
ests/openvpn/test_crypto.c</span><br><span>index ec8e661..5deb8eb 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -35,12 +35,=
19 @@</span><br><span> #include &lt;cmocka.h&gt;</span><br><span> </span><b=
r><span> #include &quot;crypto.h&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;crypto_epoch.h&quot;</span><br><span> #in=
clude &quot;options.h&quot;</span><br><span> #include &quot;ssl_backend.h&q=
uot;</span><br><span> </span><br><span> #include &quot;mss.h&quot;</span><b=
r><span> #include &quot;test_common.h&quot;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(OPENSSL_VERSION_NUMBER) &amp;&amp; OPENS=
SL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;openssl/core_names.h&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/kdf.h&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static const char testt=
ext[] =3D &quot;Dummy text to test PEM encoding&quot;;</span><br><span> </s=
pan><br><span> static void</span><br><span>@@ -471,6 +478,235 @@</span><br>=
<span>     assert_int_equal(aeslimit / L, 122059461);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_test_hkdf_ex=
pand_testa1(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* RFC 5=
889 A.1 Test Case 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint8_t prk[32] =3D</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     0x0d, 0xdc, 0x3f, 0x0d, 0xc4, =
0x7b, 0xba, 0x63,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb=
3, 0xe5};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t info[10] =3D {0xf=
0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        0xf6, 0xf7, 0xf8, 0xf9};</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint8_t okm[42] =3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5, 0=
x7a,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x90, 0x43=
, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x5d, 0xb0, 0x2d, 0=
x56, 0xec, 0xc4, 0xc5, 0xbf,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     0x58, 0x65};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint8_t out[42];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ovpn_hkdf_expand(prk, info, sizeof(info), out, si=
zeof(out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(out=
, okm, sizeof(out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+crypto_test_hkdf_expand_testa2(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* RFC 5889 A.2 Test Case 2 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t prk[32] =3D</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {0x06, 0xa6, 0xb8, 0x=
8c, 0x58, 0x53, 0x36, 0x1a,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     0x06, 0x10, 0x4c, 0x9c, 0xeb, 0x35, 0xb4, 0x5c,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     0xef, 0x76, 0x00, 0x14, 0x90,=
 0x46, 0x71, 0x01,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint8_t info[80] =3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     0xb8, 0xb9, 0xba,=
 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     0xc8, 0xc9, 0xca, 0xcb, 0x=
cc, 0xcd, 0xce, 0xcf,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd,=
 0xde, 0xdf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x=
e0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0x=
ef,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0xf0, 0xf1,=
 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff};</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const int L =3D 82;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint8_t okm[82] =3D</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {0xb1, 0x1e, 0x39, 0x8d, 0xc8=
, 0x03, 0x27, 0xa1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     0xc8, 0xe7, 0xf7, 0x8c, 0x59, 0x6a, 0x49, 0x34,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, =
0xfa, 0xd8,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0xa=
0, 0x50, 0xcc, 0x4c, 0x19, 0xaf, 0xa9, 0x7c,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     0x59, 0x04, 0x5a, 0x99, 0xca, 0xc7, 0x82, 0x7=
2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x71, 0xcb, =
0x41, 0xc6, 0x5e, 0x59, 0x0e, 0x09,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     0xda, 0x32, 0x75, 0x60, 0x0c, 0x2f, 0x09, 0xb8,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     0x36, 0x77, 0x93, 0xa=
9, 0xac, 0xa3, 0xdb, 0x71,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     0xcc, 0x30, 0xc5, 0x81, 0x79, 0xec, 0x3e, 0x87,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     0xc1, 0x4c, 0x01, 0xd5, 0xc1, =
0xf3, 0x43, 0x4f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   0x1d, 0x87};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t out[82] =3D=
 {0xaa};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ovpn_hk=
df_expand(prk, info, sizeof(info), out, L);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_memory_equal(out, okm, L);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+crypto_test_hkdf_expand_testa=
3(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* RFC 5889 A.3 Te=
st Case 3 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t8_t prk[32] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     0x7f, 0x33, 0xa9, 0x1d, 0x6f, 0x64, 0x8b=
, 0xdf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x96, 0=
x59, 0x67, 0x76, 0xaf, 0xdb, 0x63, 0x77,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x04};<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    uint8_t info[0] =3D {};</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int L =3D 42;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint8_t okm[42] =3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0=
x8f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x71, 0x5f=
, 0x80, 0x2a, 0x06, 0x3c, 0x5a, 0x31,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     0xb8, 0xa1, 0x1f, 0x5c, 0x5e, 0xe1, 0x87, 0x9e,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     0xc3, 0x45, 0x4e, 0=
x5f, 0x3c, 0x73, 0x8d, 0x2d,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     0x9d, 0x20, 0x13, 0x95, 0xfa, 0xa4, 0xb6, 0x1a,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     0x96, 0xc8};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint8_t out[42];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ovpn_hkdf_expand(prk, info, sizeof(info), out, L)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(out, okm, L);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+crypto_test_hkdf_expand_test_ovpn(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* tests the HDKF with a label/okm that OpenVPN itself =
uses in OpenSSL 3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * HDKF unit test*/</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t prk[3=
2] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {0x07, 0x=
77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     0x0d, 0xdc, 0x3f, 0x0d, 0xc4, 0x7b, 0xba, 0x63,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x90, 0xb6, 0xc7,=
 0x3b, 0xb5, 0x0f, 0x9c, 0x31,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5};</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint8_t info[18] =3D</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6=
e, 0x20,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x75, =
0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     0x74, 0x00};</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int L =3D 27;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint8_t okm[27] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {0x87, 0x5a, 0x8e, 0xec, 0x18, 0x55, 0x63, 0x80,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     0xb8, 0xd9, 0x33, 0xed, 0x32, 0x3c=
, 0x2d, 0xf8,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0=
xe8, 0xec, 0xcf, 0x49, 0x72, 0xe6, 0x83, 0xf0,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     0x6a, 0x83, 0xac };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint8_t out[27];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ovpn_hkdf_expand(prk, info, sizeof(info), out, L);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(out, okm, L);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
crypto_test_ovpn_label_expand(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint8_t secret[32] =3D</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     0x0d, 0xdc, 0x3f, 0x0d, =
0xc4, 0x7b, 0xba, 0x63,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc=
2, 0xb3, 0xe5};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *labe=
l =3D (const uint8_t *)(&quot;unit test&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    uint8_t out[16];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ovpn_expand_label(secret, sizeof(secret), =
label, 9, NULL, 0, out, sizeof(out));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint8_t out_expected[16] =3D</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {0x18, 0x5e, 0xaa, 0x1c, 0x7f, 0x22, 0x8a, 0xb8,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     0xeb, 0x29, 0x77, 0x32, 0=
x14, 0xd9, 0x20, 0x46};</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memo=
ry_equal(out, out_expected, 16);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(OPENSSL_VERS=
ION_NUMBER) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* We have OpenSSL 3.0+, we t=
est if their implementation matches our</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * implementation. We currently do not use this code fr=
om the crypto library</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * in the main code yet as we don&#39;t want to repeat the mess that the =
current</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * openvpn_P=
RF ifdef maze */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ossl_expand_label(const uint8_t *secr=
et, size_t secret_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                  const uint8_t *label, size_t label_len,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                  const uint8_t *c=
ontext, size_t context_len,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                  uint8_t *out, uint16_t out_len)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    OSSL_LIB_CTX *libctx =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *properties =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *label_prefix =3D (cons=
t uint8_t *) (&quot;ovpn &quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const size_t label_prefix_len =3D 5;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    EVP_KDF *kdf =3D EVP_KDF_fetch(libctx, OSSL_KDF_NAME_TL=
S1_3_KDF, properties);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_non_null(kdf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *mdname =3D &quot;SHA-256&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   size_t hashlen =3D SHA256_DIGEST_LENGTH;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    EVP_KDF_CTX *kctx =3D EVP_KDF_CTX_new(kdf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(kctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OSSL_PARAM params[7];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OSSL_PARAM *p =3D params;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int mode =3D EVP_PKEY_HKDEF_MODE_EXPAND_ONLY;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    *p++ =3D OSSL_PARAM_construct_int(OSSL_KD=
F_PARAM_MODE, &amp;mode);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    *p++ =3D OSSL_PARAM_construct_utf8_string(OSSL_KDF_PARAM_DIGEST,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                        (char *) mdname, 0);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    *p++ =3D OSSL_PARAM_construct_octet_string(OSS=
L_KDF_PARAM_KEY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                          (unsigned char *) secret, hashlen=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *p++ =3D OSSL=
_PARAM_construct_octet_string(OSSL_KDF_PARAM_PREFIX,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
    (unsigned char *) label_prefix,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                             label_prefix_l=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *p++ =3D OS=
SL_PARAM_construct_octet_string(OSSL_KDF_PARAM_LABEL,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
    (unsigned char *) label, label_len);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    *p++ =3D OSSL_PARAM_construct_end();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int ret =3D EVP_KDF_derive(kctx, out, out_len, params);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    EVP_KDF_CTX_free(kctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ret, 1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_test=
_ovpn_expand_openssl3(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  uint8_t secret[32] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     0x0d, 0xdc, 0x3f, 0x0d, 0xc4, 0x=
7b, 0xba, 0x63,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3,=
 0xe5};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *label =3D (c=
onst uint8_t *) (&quot;unit test&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const size_t labellen =3D 9;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t out[27];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ossl_expand_label(secret, sizeof(secret), label, labell=
en, NULL, 0, out, sizeof(out));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Do the same derivation with our own function */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    uint8_t out_ovpn[27];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ovpn_expand_label(secret, sizeof(secret), label, 9, NULL=
, 0, out_ovpn, sizeof(out_ovpn));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_memory_equal(out_ovpn, out, sizeof(out_ovpn));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#else  /* if defined(OPENSSL_VERSION_NUMBER) &amp;&amp; OPEN=
SSL_VERSION_NUMBER &gt;=3D 0x30000000L */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+crypto_test_ovpn_expand_openssl3(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    skip();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* =
if defined(OPENSSL_VERSION_NUMBER) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=
=3D 0x30000000L */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> int</span><br><span> main(void)</span><br><span> {</span><=
br><span>@@ -482,7 +718,13 @@</span><br><span>         cmocka_unit_test(cry=
pto_test_hmac),</span><br><span>         cmocka_unit_test(test_occ_mtu_calc=
ulation),</span><br><span>         cmocka_unit_test(test_mssfix_mtu_calcula=
tion),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_=
unit_test(crypto_test_aead_limits)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(crypto_test_aead_limits),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(cryp=
to_test_hkdf_expand_testa1),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(crypto_test_hkdf_expand_testa2),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(cry=
pto_test_hkdf_expand_testa3),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(crypto_test_hkdf_expand_test_ovpn),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(crypto_test_ovpn_label_expand),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cmocka_unit_test(crypto_test_ovpn_expand_openssl3)</sp=
an><br><span>     };</span><br><span> </span><br><span> #if defined(ENABLE_=
CRYPTO_OPENSSL)</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail">change 798</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/798?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3a1c6561f4d9a69e2a441d49dff=
620b4258a1bcc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 798 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--qGDAtR7fdGs=--

