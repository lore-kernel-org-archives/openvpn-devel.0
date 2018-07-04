From: Steffan Karger <steffan@...1856...>
Date: Wed,  4 Jul 2018 19:53:58 +0200
Message-Id: <20180704175404.22371-3-steffan@...1856...>
In-Reply-To: <20180704175404.22371-1-steffan@...1856...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v2 3/9] Add crypto_pem_{encode,decode}()
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

From: Steffan Karger <steffan.karger@...1435...>

Needed for tls-crypt-v2, but isolated enough to be reviewed as a separate
patch.

The encode API allocates memory, because it fits our typical gc-oriented
code pattern and the caller does not have to do multiple calls or
calculations to determine the required destination buffer size.

The decode API does not allocate memory, because the required destination
buffer is always smaller than the input buffer (so is easy to manage by
the caller) and does not force the caller to use the heap.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto_backend.h           | 29 +++++++++
 src/openvpn/crypto_mbedtls.c           | 75 ++++++++++++++++++++++
 src/openvpn/crypto_openssl.c           | 82 ++++++++++++++++++++++++
 tests/unit_tests/openvpn/Makefile.am   | 16 ++++-
 tests/unit_tests/openvpn/test_crypto.c | 88 ++++++++++++++++++++++++++
 5 files changed, 289 insertions(+), 1 deletion(-)
 create mode 100644 tests/unit_tests/openvpn/test_crypto.c

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index bb53b8c9..f917c8d7 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -36,6 +36,7 @@
 #include "crypto_mbedtls.h"
 #endif
 #include "basic.h"
+#include "buffer.h"
 
 /* TLS uses a tag of 128 bytes, let's do the same for OpenVPN */
 #define OPENVPN_AEAD_TAG_LENGTH 16
@@ -105,6 +106,34 @@ void show_available_digests(void);
 
 void show_available_engines(void);
 
+/**
+ * Encode binary data as PEM.
+ *
+ * @param name      The name to use in the PEM header/footer.
+ * @param dst       Destination buffer for PEM-encoded data.  Must be a valid
+ *                  pointer to an uninitialized buffer structure.  Iff this
+ *                  function returns true, the buffer will contain memory
+ *                  allocated through the supplied gc.
+ * @param src       Source buffer.
+ * @param gc        The garbage collector to use when allocating memory for dst.
+ *
+ * @return true iff PEM encode succeeded.
+ */
+bool crypto_pem_encode(const char *name, struct buffer *dst,
+                       const struct buffer *src, struct gc_arena *gc);
+
+/**
+ * Decode a PEM buffer to binary data.
+ *
+ * @param name      The name expected in the PEM header/footer.
+ * @param dst       Destination buffer for decoded data.
+ * @param src       Source buffer (PEM data).
+ *
+ * @return true iff PEM decode succeeded.
+ */
+bool crypto_pem_decode(const char *name, struct buffer *dst,
+                       const struct buffer *src);
+
 /*
  *
  * Random number functions, used in cases where we want
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 8ff6704d..82f4e574 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -44,11 +44,13 @@
 #include "otime.h"
 #include "misc.h"
 
+#include <mbedtls/base64.h>
 #include <mbedtls/des.h>
 #include <mbedtls/error.h>
 #include <mbedtls/md5.h>
 #include <mbedtls/cipher.h>
 #include <mbedtls/havege.h>
+#include <mbedtls/pem.h>
 
 #include <mbedtls/entropy.h>
 
@@ -229,6 +231,79 @@ show_available_engines(void)
            "available\n");
 }
 
+bool
+crypto_pem_encode(const char *name, struct buffer *dst,
+                  const struct buffer *src, struct gc_arena *gc)
+{
+    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
+    char header[1000+1] = { 0 };
+    char footer[1000+1] = { 0 };
+
+    if (!openvpn_snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name))
+    {
+        return false;
+    }
+    if (!openvpn_snprintf(footer, sizeof(footer), "-----END %s-----\n", name))
+    {
+        return false;
+    }
+
+    size_t out_len = 0;
+    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL !=
+            mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src),
+                                     NULL, 0, &out_len))
+    {
+        return false;
+    }
+
+    *dst = alloc_buf_gc(out_len, gc);
+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src),
+                                          BPTR(dst), BCAP(dst), &out_len))
+        || !buf_inc_len(dst, out_len))
+    {
+        CLEAR(*dst);
+        return false;
+    }
+
+    return true;
+}
+
+bool
+crypto_pem_decode(const char *name, struct buffer *dst,
+                  const struct buffer *src)
+{
+    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
+    char header[1000+1] = { 0 };
+    char footer[1000+1] = { 0 };
+
+    if (*(BLAST(src)) != '\0')
+    {
+        msg(M_WARN, "PEM decode error: source buffer not null-terminated");
+        return false;
+    }
+    if (!openvpn_snprintf(header, sizeof(header), "-----BEGIN %s-----", name))
+    {
+        return false;
+    }
+    if (!openvpn_snprintf(footer, sizeof(footer), "-----END %s-----", name))
+    {
+        return false;
+    }
+
+    size_t use_len = 0;
+    mbedtls_pem_context ctx = { 0 };
+    bool ret = mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(src),
+                                               NULL, 0, &use_len));
+    if (ret && !buf_write(dst, ctx.buf, ctx.buflen))
+    {
+        ret = false;
+        msg(M_WARN, "PEM decode error: destination buffer too small");
+    }
+
+    mbedtls_pem_free(&ctx);
+    return ret;
+}
+
 /*
  *
  * Random number functions, used in cases where we want
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 4fb2f6d6..32b8b695 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -387,6 +387,88 @@ show_available_engines(void)
 #endif
 }
 
+
+bool
+crypto_pem_encode(const char *name, struct buffer *dst,
+                  const struct buffer *src, struct gc_arena *gc)
+{
+    bool ret = false;
+    BIO *bio = BIO_new(BIO_s_mem());
+    if (!bio || !PEM_write_bio(bio, name, "", BPTR(src), BLEN(src)))
+    {
+        ret = false;
+        goto cleanup;
+    }
+
+    BUF_MEM *bptr;
+    BIO_get_mem_ptr(bio, &bptr);
+
+    *dst = alloc_buf_gc(bptr->length, gc);
+    ASSERT(buf_write(dst, bptr->data, bptr->length));
+
+    ret = true;
+cleanup:
+    if (!BIO_free(bio))
+    {
+        ret = false;;
+    }
+
+    return ret;
+}
+
+bool
+crypto_pem_decode(const char *name, struct buffer *dst,
+                  const struct buffer *src)
+{
+    bool ret = false;
+    BIO *bio;
+
+    if (!(bio = BIO_new_mem_buf((char *)BPTR(src), BLEN(src))))
+    {
+        crypto_msg(M_FATAL, "Cannot open memory BIO for PEM decode");
+    }
+
+    char *name_read = NULL;
+    char *header_read = NULL;
+    uint8_t *data_read = NULL;
+    long data_read_len = 0;
+    if (!PEM_read_bio(bio, &name_read, &header_read, &data_read,
+                      &data_read_len))
+    {
+        dmsg(D_CRYPT_ERRORS, "%s: PEM decode failed", __func__);
+        goto cleanup;
+    }
+
+    if (strcmp(name, name_read))
+    {
+        dmsg(D_CRYPT_ERRORS,
+             "%s: unexpected PEM name (got '%s', expected '%s')",
+             __func__, name_read, name);
+        goto cleanup;
+    }
+
+    uint8_t *dst_data = buf_write_alloc(dst, data_read_len);
+    if (!dst_data)
+    {
+        dmsg(D_CRYPT_ERRORS, "%s: dst too small (%i, needs %li)", __func__,
+             BCAP(dst), data_read_len);
+        goto cleanup;
+    }
+    memcpy(dst_data, data_read, data_read_len);
+
+    ret = true;
+cleanup:
+    OPENSSL_free(name_read);
+    OPENSSL_free(header_read);
+    OPENSSL_free(data_read);
+    if (!BIO_free(bio))
+    {
+        ret = false;;
+    }
+
+    return ret;
+}
+
 /*
  *
  * Random number functions, used in cases where we want
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index db4d46e1..1ff62615 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -6,7 +6,7 @@ if HAVE_LD_WRAP_SUPPORT
 check_PROGRAMS += argv_testdriver buffer_testdriver
 endif
 
-check_PROGRAMS += packet_id_testdriver tls_crypt_testdriver
+check_PROGRAMS += crypto_testdriver packet_id_testdriver tls_crypt_testdriver
 
 TESTS = $(check_PROGRAMS)
 
@@ -31,6 +31,20 @@ buffer_testdriver_SOURCES = test_buffer.c mock_msg.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/platform.c
 
+crypto_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	$(OPTIONAL_CRYPTO_CFLAGS)
+crypto_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
+	$(OPTIONAL_CRYPTO_LIBS)
+crypto_testdriver_SOURCES = test_crypto.c mock_msg.c \
+	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/crypto.c \
+	$(openvpn_srcdir)/crypto_mbedtls.c \
+	$(openvpn_srcdir)/crypto_openssl.c \
+	$(openvpn_srcdir)/otime.c \
+	$(openvpn_srcdir)/packet_id.c \
+	$(openvpn_srcdir)/platform.c
+
 packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
new file mode 100644
index 00000000..7027d3da
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -0,0 +1,88 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016-2018 Fox Crypto B.V. <openvpn@...1435...>
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
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "crypto.h"
+
+#include "mock_msg.h"
+
+static const char testtext[] = "Dummy text to test PEM encoding";
+
+static void
+crypto_pem_encode_decode_loopback(void **state) {
+    struct gc_arena gc = gc_new();
+    struct buffer src_buf;
+    buf_set_read(&src_buf, (void *)testtext, sizeof(testtext));
+
+    uint8_t dec[sizeof(testtext)];
+    struct buffer dec_buf;
+    buf_set_write(&dec_buf, dec, sizeof(dec));
+
+    struct buffer pem_buf;
+
+    assert_true(crypto_pem_encode("TESTKEYNAME", &pem_buf, &src_buf, &gc));
+    assert_true(BLEN(&src_buf) < BLEN(&pem_buf));
+
+    /* Wrong key name */
+    assert_false(crypto_pem_decode("WRONGNAME", &dec_buf, &pem_buf));
+
+    assert_true(crypto_pem_decode("TESTKEYNAME", &dec_buf, &pem_buf));
+    assert_int_equal(BLEN(&src_buf), BLEN(&dec_buf));
+    assert_memory_equal(BPTR(&src_buf), BPTR(&dec_buf), BLEN(&src_buf));
+
+    gc_free(&gc);
+}
+
+int
+main(void) {
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(crypto_pem_encode_decode_loopback),
+    };
+
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    OpenSSL_add_all_algorithms();
+#endif
+
+    int ret = cmocka_run_group_tests_name("crypto tests", tests, NULL, NULL);
+
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    EVP_cleanup();
+#endif
+
+    return ret;
+}
-- 
2.17.1


