From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 15 Nov 2024 15:12:22 +0000
In-Reply-To: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
References: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1e85c57feea520b4219d9642665cc3cf7eeccc75-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Luf+oOr9ZPg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Luf+oOr9ZPg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail

to look at the new patch set (#4).


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
7 files changed, 303 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/798/4

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5db207d..cbc93cd 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -389,6 +389,8 @@
     src/openvpn/crypto.c
     src/openvpn/crypto.h
     src/openvpn/crypto_backend.h
+    src/openvpn/crypto_epoch.c
+    src/openvpn/crypto_epoch.h
     src/openvpn/crypto_openssl.c
     src/openvpn/crypto_openssl.h
     src/openvpn/crypto_mbedtls.c
@@ -717,6 +719,7 @@
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
index 0000000..f9111f1
--- /dev/null
+++ b/src/openvpn/crypto_epoch.c
@@ -0,0 +1,106 @@
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
+ovpn_hdkf_expand(const uint8_t *secret,
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
+    if (secret_len !=3D 32)
+    {
+        /* Our current implementation is not a general purpose one
+         * and assume that the secret size matches the size of the
+         * hash (SHA256) key */
+        return false;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    /* 2 byte for the outlen encoded as uint16, 5 bytes for "ovpn " */
+    int hkdf_label_len =3D 2 + 5 + label_len + context_len;
+    struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len, &gc);
+
+
+    buf_write_u16(&hkdf_label, out_len);
+    buf_write(&hkdf_label, "ovpn ", 5);
+    buf_write(&hkdf_label, label, label_len);
+    if (context_len > 0)
+    {
+        buf_write(&hkdf_label, context, context_len);
+    }
+
+    ASSERT(buf_len(&hkdf_label) =3D=3D hkdf_label_len);
+
+    ovpn_hdkf_expand(secret, buf_bptr(&hkdf_label),
+                     buf_len(&hkdf_label), out, out_len);
+
+    gc_free(&gc);
+    return true;
+}
diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h
new file mode 100644
index 0000000..dad2473
--- /dev/null
+++ b/src/openvpn/crypto_epoch.h
@@ -0,0 +1,69 @@
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
+ *  - salt is always assumed to be zero length (ie not supported)
+ *  - IKM (secret) is assumed to be always 32 bytes
+ *  - HASH is always SHA256
+ *
+ *  @param secret   the input keying material (HMAC key)
+ *  @param info     context and application specific information
+ *  @param out      output keying material
+ *  @param out_len  length of output keying material
+ */
+void
+ovpn_hdkf_expand(const uint8_t *secret,
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
index e573a8b..c8d2a10 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -35,6 +35,7 @@
 #include <cmocka.h>

 #include "crypto.h"
+#include "crypto_epoch.h"
 #include "options.h"
 #include "ssl_backend.h"

@@ -469,6 +470,122 @@
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
+    ovpn_hdkf_expand(prk, info, sizeof(info), out, sizeof(out));
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
+    ovpn_hdkf_expand(prk, info, sizeof(info), out, L);
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
+    ovpn_hdkf_expand(prk, info, sizeof(info), out, L);
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
+    {0x6, 0x8C, 0x11, 0xA6, 0x48, 0xFE, 0xBC, 0xA0,
+     0x9D, 0x1A, 0xF0, 0xD6, 0xD5, 0xF7, 0xBE, 0xC6};
+
+    assert_memory_equal(out, out_expected, 16);
+}
+
 int
 main(void)
 {
@@ -480,7 +597,11 @@
         cmocka_unit_test(crypto_test_hmac),
         cmocka_unit_test(test_occ_mtu_calculation),
         cmocka_unit_test(test_mssfix_mtu_calculation),
-        cmocka_unit_test(crypto_test_aead_limits)
+        cmocka_unit_test(crypto_test_aead_limits),
+        cmocka_unit_test(crypto_test_hkdf_expand_testa1),
+        cmocka_unit_test(crypto_test_hkdf_expand_testa2),
+        cmocka_unit_test(crypto_test_hkdf_expand_testa3),
+        cmocka_unit_test(crypto_test_ovpn_label_expand),
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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--Luf+oOr9ZPg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Implement HKDF expand function based on RFC 8446<br><br>Use crypto_ep=
och.c/h for the new functions since they are<br>linked to the epoch key usa=
ge in OpenVPN.<br><br>Change-Id: I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc<=
br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M CMakeLis=
ts.txt<br>M src/openvpn/Makefile.am<br>A src/openvpn/crypto_epoch.c<br>A sr=
c/openvpn/crypto_epoch.h<br>M src/openvpn/crypto_mbedtls.h<br>M tests/unit_=
tests/openvpn/Makefile.am<br>M tests/unit_tests/openvpn/test_crypto.c<br>7 =
files changed, 303 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/98/798/4</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/C=
MakeLists.txt b/CMakeLists.txt</span><br><span>index 5db207d..cbc93cd 10064=
4</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt=
</span><br><span>@@ -389,6 +389,8 @@</span><br><span>     src/openvpn/crypt=
o.c</span><br><span>     src/openvpn/crypto.h</span><br><span>     src/open=
vpn/crypto_backend.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    src/openvpn/crypto_epoch.c</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    src/openvpn/crypto_epoch.h</span><br><span>     src/openvpn=
/crypto_openssl.c</span><br><span>     src/openvpn/crypto_openssl.h</span><=
br><span>     src/openvpn/crypto_mbedtls.c</span><br><span>@@ -717,6 +719,7=
 @@</span><br><span>     target_sources(test_crypto PRIVATE</span><br><span=
>         src/openvpn/crypto_mbedtls.c</span><br><span>         src/openvpn=
/crypto_openssl.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      src/openvpn/crypto_epoch.c</span><br><span>         src/openvpn/crypt=
o.c</span><br><span>         src/openvpn/otime.c</span><br><span>         s=
rc/openvpn/packet_id.c</span><br><span>diff --git a/src/openvpn/Makefile.am=
 b/src/openvpn/Makefile.am</span><br><span>index ecb2bcf..d6d6592 100644</s=
pan><br><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openv=
pn/Makefile.am</span><br><span>@@ -53,6 +53,7 @@</span><br><span> 	crypto.c=
 crypto.h crypto_backend.h \</span><br><span> 	crypto_openssl.c crypto_open=
ssl.h \</span><br><span> 	crypto_mbedtls.c crypto_mbedtls.h \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	crypto_epoch.c crypto_epoch.h \<=
/span><br><span> 	dco.c dco.h dco_internal.h \</span><br><span> 	dco_freebs=
d.c dco_freebsd.h \</span><br><span> 	dco_linux.c dco_linux.h \</span><br><=
span>diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c</=
span><br><span>new file mode 100644</span><br><span>index 0000000..f9111f1<=
/span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/crypto_epoc=
h.c</span><br><span>@@ -0,0 +1,106 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/=
UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             session authentication and key exchange=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket encryption, packet authentication, and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             packet compression.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  Copyright (C) 2024 OpenVPN Inc &lt;sales@...515...=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (=
C) 2024 Arne Schwabe &lt;arne@...1227...&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
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
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CO=
NFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;config.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &lt;inttypes.h&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_backe=
nd.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;buffer.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;integer.h&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_hdkf_expand(const=
 uint8_t *secret,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
               const uint8_t *info, int info_len,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                 uint8_t *out, int out_len)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_t *hmac_ctx =3D hmac_ctx_n=
ew();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_i=
nit(hmac_ctx, secret, &quot;SHA256&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const int digest_size =3D SHA256_DIGEST_LENGTH;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* T(0) =3D empty string */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint8_t t_prev[SHA256_DIGEST_LENGTH];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int t_prev_len =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (uint8_t block =3D 1; (block =
- 1) * digest_size &lt; out_len; block++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        hmac_ctx_reset(hmac_ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* calculate T(block) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_update(=
hmac_ctx, info, info_len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        hmac_ctx_update(hmac_ctx, &amp;block, 1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_final(hmac_ctx, t_pre=
v);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t_prev_l=
en =3D digest_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Copy a f=
ull hmac output or remaining bytes */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        int out_offset =3D (block - 1) * digest_size;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        int copylen =3D=
 min_int(digest_size, out_len - out_offset);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        memcpy(out + out_offset, t_prev, copylen);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    hmac_ctx_cleanup(hmac_ctx);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_free(hmac_ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_exp=
and_label(const uint8_t *secret, size_t secret_len,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  const uint8_t *label, s=
ize_t label_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
               const uint8_t *context, size_t context_len,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                  uint8_t *out, uint=
16_t out_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (secret_len !=3D =
32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* Our current impleme=
ntation is not a general purpose one</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * and assume that the secret size matches the siz=
e of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
hash (SHA256) key */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 2 byte=
 for the outlen encoded as uint16, 5 bytes for &quot;ovpn &quot; */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int hkdf_label_len =3D =
2 + 5 + label_len + context_len;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buf_write_u16(&amp;hkdf_label, out_len);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;hkdf=
_label, &quot;ovpn &quot;, 5);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf_write(&amp;hkdf_label, label, label_len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (context_len &gt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        buf_write(&amp;hkdf_label, conte=
xt, context_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_len(&amp;hkdf_label)=
 =3D=3D hkdf_label_len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ovpn_hdkf_=
expand(secret, buf_bptr(&amp;hkdf_label),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                     buf_len(&amp;hkdf_label), out, o=
ut_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/=
src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h</span><br><span>new=
 file mode 100644</span><br><span>index 0000000..dad2473</span><br><span>--=
- /dev/null</span><br><span>+++ b/src/openvpn/crypto_epoch.h</span><br><spa=
n>@@ -0,0 +1,69 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An =
application to securely tunnel IP networks</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             session authentication and key exchange,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pac=
ket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet compression.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  Copyright (C) 2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2024 Arne Schwab=
e &lt;arne@...1227...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free sof=
tware; you can redistribute it and/or modify</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public L=
icense version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 as published by the Free Software Foundation.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  This program is distributed in the hope that it will be usefu=
l,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT A=
NY WARRANTY; without even the implied warranty of</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  GNU General Public License for more details.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  You should have received a copy of the GNU General Public =
License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wi=
th this program; if not, write to the Free Software Foundation, Inc.,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, F=
ifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef CRYPTO_E=
POCH_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CRYPT=
O_EPOCH_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Implementation of the RFC5869 HKDF-Expand =
function with the following</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * restrictions</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  - salt is always assumed to be zero length (ie not supported)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - IKM (secret) is ass=
umed to be always 32 bytes</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  - HASH is always SHA256</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  @param secret   the input keying material (HMAC key)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  @param info     context and applicat=
ion specific information</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  @param out      output keying material</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  @param out_len  length of output keying mat=
erial</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ovpn_hdkf_expand(const uint8_t *secret,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const ui=
nt8_t *info, int info_len,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                 uint8_t *out, int out_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Variant of the RFC 8446 TLS 1.3  HKDF-Expand-Label function with the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * following differences=
/restrictions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  -=
 secret must 32 bytes in length</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  - label prefix is &quot;ovpn &quot; instead of &quot;tls13 =
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - HASH is=
 always SHA256</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param secret      =
  Input secret</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram secret_len    length of the input secret</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param label         Label for the exported ke=
y material</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 label_len     length of the label</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param context       optional context</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param context_len   length of the c=
ontext</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param out=
      output keying material</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param out_len  length of output keying material</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @return</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ovpn_expand_label(const uint8_t *secret, size_t secret_len,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                  const uint8_t =
*label, size_t label_len,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                  const uint8_t *context, size_t context_len,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  uint8_t *=
out, uint16_t out_len);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span>diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbed=
tls.h</span><br><span>index a966a7a..fe51359 100644</span><br><span>--- a/s=
rc/openvpn/crypto_mbedtls.h</span><br><span>+++ b/src/openvpn/crypto_mbedtl=
s.h</span><br><span>@@ -29,6 +29,7 @@</span><br><span> #ifndef CRYPTO_MBEDT=
LS_H_</span><br><span> #define CRYPTO_MBEDTLS_H_</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool.h&gt;</=
span><br><span> #include &lt;mbedtls/cipher.h&gt;</span><br><span> #include=
 &lt;mbedtls/md.h&gt;</span><br><span> #include &lt;mbedtls/ctr_drbg.h&gt;<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/u=
nit_tests/openvpn/Makefile.am</span><br><span>index a4e6235..307f9ed 100644=
</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span=
>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span>@@ -66,6 +66,7 =
@@</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span> =
	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/crypto_openssl.c \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span> =
	$(top_srcdir)/src/openvpn/otime.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/packet_id.c \</span><br><span> 	$(top_srcdir)/src/openvpn/platform.c =
\</span><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tes=
ts/unit_tests/openvpn/test_crypto.c</span><br><span>index e573a8b..c8d2a10 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -3=
5,6 +35,7 @@</span><br><span> #include &lt;cmocka.h&gt;</span><br><span> </=
span><br><span> #include &quot;crypto.h&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;crypto_epoch.h&quot;</span><br><sp=
an> #include &quot;options.h&quot;</span><br><span> #include &quot;ssl_back=
end.h&quot;</span><br><span> </span><br><span>@@ -469,6 +470,122 @@</span><=
br><span>     assert_int_equal(aeslimit / L, 122059461);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_test_hkdf=
_expand_testa1(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* RF=
C 5889 A.1 Test Case 1 */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint8_t prk[32] =3D</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     0x0d, 0xdc, 0x3f, 0x0d, 0xc=
4, 0x7b, 0xba, 0x63,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, =
0xb3, 0xe5};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t info[10] =3D {=
0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        0xf6, 0xf7, 0xf8, 0xf9};</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint8_t okm[42] =3D</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5=
, 0x7a,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x90, 0=
x43, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x5d, 0xb0, 0x2d=
, 0x56, 0xec, 0xc4, 0xc5, 0xbf,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     0x58, 0x65};</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    uint8_t out[42];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ovpn_hdkf_expand(prk, info, sizeof(info), out,=
 sizeof(out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(=
out, okm, sizeof(out));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+crypto_test_hkdf_expand_testa2(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* RFC 5889 A.2 Test Case 2 */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t prk[32] =3D</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {0x06, 0xa6, 0xb8,=
 0x8c, 0x58, 0x53, 0x36, 0x1a,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     0x06, 0x10, 0x4c, 0x9c, 0xeb, 0x35, 0xb4, 0x5c,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     0xef, 0x76, 0x00, 0x14, 0x=
90, 0x46, 0x71, 0x01,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44};</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint8_t info[80] =3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0xb8, 0xb9, 0xb=
a, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     0xc8, 0xc9, 0xca, 0xcb, =
0xcc, 0xcd, 0xce, 0xcf,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xd=
d, 0xde, 0xdf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, =
0xef,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     0xf0, 0xf=
1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff};</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
 {0xaa};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ovpn_hd=
kf_expand(prk, info, sizeof(info), out, L);</span><br><span style=3D"color:=
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
sl(120, 100%, 40%);">+    ovpn_hdkf_expand(prk, info, sizeof(info), out, L)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(out, okm, L);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+crypto_test_ovpn_label_expand(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint8_t secret[32] =3D</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x0d, 0xdc, 0x3f, 0x=
0d, 0xc4, 0x7b, 0xba, 0x63,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f, 0x9c, 0x31,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     0x22, 0xec, 0x84, 0x4a, 0xd7,=
 0xc2, 0xb3, 0xe5};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *=
label =3D (const uint8_t *)(&quot;unit test&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t out[16];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ovpn_expand_label(secret, sizeof(sec=
ret), label, 9, NULL, 0, out, sizeof(out));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uint8_t out_expected[16] =3D</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {0x6, 0x8C, 0x11, 0xA6, 0x48, 0xFE, 0xBC, 0xA0,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     0x9D, 0x1A, 0xF0, 0x=
D6, 0xD5, 0xF7, 0xBE, 0xC6};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_memory_equal(out, out_expected, 16);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> int</span><br><span> main(void)</span><br><span> {</span>=
<br><span>@@ -480,7 +597,11 @@</span><br><span>         cmocka_unit_test(cr=
ypto_test_hmac),</span><br><span>         cmocka_unit_test(test_occ_mtu_cal=
culation),</span><br><span>         cmocka_unit_test(test_mssfix_mtu_calcul=
ation),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka=
_unit_test(crypto_test_aead_limits)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(crypto_test_aead_limits),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(cry=
pto_test_hkdf_expand_testa1),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(crypto_test_hkdf_expand_testa2),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(cr=
ypto_test_hkdf_expand_testa3),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(crypto_test_ovpn_label_expand),</span><=
br><span>     };</span><br><span> </span><br><span> #if defined(ENABLE_CRYP=
TO_OPENSSL)</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail">change 798</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/798?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3a1c6561f4d9a69e2a441d49dff=
620b4258a1bcc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 798 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Luf+oOr9ZPg=--

