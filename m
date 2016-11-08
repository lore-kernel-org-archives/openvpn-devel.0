From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 8 Nov 2016 21:18:22 +0100
Message-ID: <1478636302-9678-6-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/5] Add --tls-crypt unit tests
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

These help verify the tls-crypt functionality - they already caught a
bug during development.  We should however probably also add some
t_client tests once this feature is in.

To test --tls-crypt with as few dependencies as possible, this adds a
mock implementation of msg() (or actually x_msg()).  For debugging
purposes, the mock implementation can be made to really log by calling
mock_set_debug_level(), but defaults to (almost) no logging.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 tests/unit_tests/openvpn/Makefile.am      |  22 ++-
 tests/unit_tests/openvpn/mock_msg.c       |  92 ++++++++++++
 tests/unit_tests/openvpn/mock_msg.h       |  35 +++++
 tests/unit_tests/openvpn/test_argv.c      |  10 --
 tests/unit_tests/openvpn/test_tls_crypt.c | 242 ++++++++++++++++++++++++++++++
 5 files changed, 390 insertions(+), 11 deletions(-)
 create mode 100644 tests/unit_tests/openvpn/mock_msg.c
 create mode 100644 tests/unit_tests/openvpn/mock_msg.h
 create mode 100644 tests/unit_tests/openvpn/test_tls_crypt.c

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index b706fae..632ff58 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -2,8 +2,13 @@ AUTOMAKE_OPTIONS = foreign
 
 check_PROGRAMS = argv_testdriver
 
+if ENABLE_CRYPTO
+check_PROGRAMS += tls_crypt_testdriver
+endif
+
 TESTS = $(check_PROGRAMS)
 
+openvpn_includedir = $(top_srcdir)/include
 openvpn_srcdir = $(top_srcdir)/src/openvpn
 compat_srcdir = $(top_srcdir)/src/compat
 
@@ -11,7 +16,22 @@ argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line \
 	$(OPTIONAL_CRYPTO_LIBS)
-argv_testdriver_SOURCES = test_argv.c \
+argv_testdriver_SOURCES = test_argv.c mock_msg.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/argv.c
+
+tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	$(OPTIONAL_CRYPTO_CFLAGS)
+tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
+	$(OPTIONAL_CRYPTO_LIBS)
+tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c \
+	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/crypto.c \
+	$(openvpn_srcdir)/crypto_mbedtls.c \
+	$(openvpn_srcdir)/crypto_openssl.c \
+	$(openvpn_srcdir)/otime.c \
+	$(openvpn_srcdir)/packet_id.c \
+	$(openvpn_srcdir)/platform.c \
+	$(openvpn_srcdir)/tls_crypt.c
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
new file mode 100644
index 0000000..54b6017
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -0,0 +1,92 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
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
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "errlevel.h"
+#include "error.h"
+
+unsigned int x_debug_level = 0; /* Default to (almost) no debugging output */
+bool fatal_error_triggered = false;
+
+void mock_set_debug_level(int level)
+{
+  x_debug_level = level;
+}
+
+void x_msg_va (const unsigned int flags, const char *format,
+    va_list arglist)
+{
+  if (flags & M_FATAL)
+    {
+      fatal_error_triggered = true;
+      printf("FATAL ERROR:");
+    }
+  vprintf(format, arglist);
+  printf("\n");
+}
+
+void x_msg (const unsigned int flags, const char *format, ...)
+{
+  va_list arglist;
+  va_start (arglist, format);
+  x_msg_va (flags, format, arglist);
+  va_end (arglist);
+}
+
+void
+assert_failed (const char *filename, int line, const char *condition)
+{
+  if (condition)
+    printf ("Assertion failed at %s:%d (%s)", filename, line, condition);
+  else
+    printf ("Assertion failed at %s:%d", filename, line);
+  exit (1);
+}
+
+/*
+ * Fail memory allocation.  Don't use msg() because it tries
+ * to allocate memory as part of its operation.
+ */
+void
+out_of_memory (void)
+{
+  fprintf (stderr, "Out of Memory\n");
+  exit (1);
+}
+
+bool
+dont_mute (unsigned int flags)
+{
+  return true;
+}
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
new file mode 100644
index 0000000..5d93a1a
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
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
+#ifndef MOCK_MSG_H
+#define MOCK_MSG_H
+
+/**
+ * Mock debug level defaults to 0, which gives clean(-ish) test reports.  Call
+ * this function from your test driver to increase debug output when you
+ * need debug output.
+ */
+void mock_set_debug_level(int level);
+
+#endif /* MOCK_MSG */
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index f07a5fb..34125d6 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -14,16 +14,6 @@
 #include "buffer.h"
 
 /*
- * Dummy symbols that need to be defined due to them being
- * referenced in #include'd header files and their includes
- */
-unsigned int x_debug_level;
-bool dont_mute (unsigned int flags) { return true; }
-void assert_failed (const char *filename, int line, const char *condition) { exit(0); }
-void out_of_memory (void) { }
-void x_msg (const unsigned int flags, const char *format, ...) { }
-
-/*
  * This is defined here to prevent #include'ing misc.h
  * which makes things difficult beyond any recognition
  */
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
new file mode 100644
index 0000000..473a232
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -0,0 +1,242 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
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
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#ifdef ENABLE_CRYPTO
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
+#include "tls_crypt.h"
+
+#include "mock_msg.h"
+
+#define TESTBUF_SIZE 		128
+
+const char plaintext_short[1];
+
+struct test_context {
+  struct crypto_options co;
+  struct key_type kt;
+  struct buffer source;
+  struct buffer ciphertext;
+  struct buffer unwrapped;
+};
+
+static int setup(void **state) {
+    struct test_context *ctx  = calloc(1, sizeof(*ctx));
+
+    ctx->kt.cipher = cipher_kt_get ("AES-256-CTR");
+    ctx->kt.cipher_length = cipher_kt_key_size (ctx->kt.cipher);
+    ctx->kt.digest = md_kt_get ("SHA256");
+    ctx->kt.hmac_length = md_kt_size (ctx->kt.digest);
+
+    struct key key = { 0 };
+
+    init_key_ctx (&ctx->co.key_ctx_bi.encrypt, &key, &ctx->kt, true, "TEST");
+    init_key_ctx (&ctx->co.key_ctx_bi.decrypt, &key, &ctx->kt, false, "TEST");
+
+    packet_id_init (&ctx->co.packet_id, 0, 0, "test", 0);
+
+    ctx->source = alloc_buf(TESTBUF_SIZE);
+    ctx->ciphertext = alloc_buf(TESTBUF_SIZE);
+    ctx->unwrapped = alloc_buf(TESTBUF_SIZE);
+
+    /* Write test plaintext */
+    buf_write(&ctx->source, plaintext_short, sizeof(plaintext_short));
+
+    /* Write dummy opcode and session id */
+    buf_write(&ctx->ciphertext, "012345678", 1 + 8);
+
+    *state = ctx;
+
+    return 0;
+}
+
+static int teardown(void **state) {
+    struct test_context *ctx = (struct test_context *) *state;
+
+    free_buf (&ctx->source);
+    free_buf (&ctx->ciphertext);
+    free_buf (&ctx->unwrapped);
+
+    free_key_ctx_bi (&ctx->co.key_ctx_bi);
+
+    free(ctx);
+
+    return 0;
+}
+
+/**
+ * Check that short messages are successfully wrapped-and-unwrapped.
+ */
+static void tls_crypt_loopback(void **state) {
+  struct test_context *ctx = (struct test_context *) *state;
+
+  assert_true (tls_crypt_wrap (&ctx->source, &ctx->ciphertext, &ctx->co));
+  assert_true (BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
+  assert_true (tls_crypt_unwrap (&ctx->ciphertext, &ctx->unwrapped, &ctx->co));
+  assert_int_equal(BLEN(&ctx->source), BLEN(&ctx->unwrapped));
+  assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped),
+      BLEN(&ctx->source));
+}
+
+/**
+ * Check that zero-byte messages are successfully wrapped-and-unwrapped.
+ */
+static void tls_crypt_loopback_zero_len(void **state) {
+  struct test_context *ctx = (struct test_context *) *state;
+
+  buf_clear(&ctx->source);
+
+  assert_true (tls_crypt_wrap (&ctx->source, &ctx->ciphertext, &ctx->co));
+  assert_true (BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
+  assert_true (tls_crypt_unwrap (&ctx->ciphertext, &ctx->unwrapped, &ctx->co));
+  assert_int_equal(BLEN(&ctx->source), BLEN(&ctx->unwrapped));
+  assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped),
+      BLEN(&ctx->source));
+}
+
+/**
+ * Check that max-length messages are successfully wrapped-and-unwrapped.
+ */
+static void tls_crypt_loopback_max_len(void **state) {
+  struct test_context *ctx = (struct test_context *) *state;
+
+  buf_clear(&ctx->source);
+  assert_non_null (buf_write_alloc (&ctx->source,
+      TESTBUF_SIZE - BLEN (&ctx->ciphertext) - tls_crypt_buf_overhead()));
+
+  assert_true (tls_crypt_wrap (&ctx->source, &ctx->ciphertext, &ctx->co));
+  assert_true (BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
+  assert_true (tls_crypt_unwrap (&ctx->ciphertext, &ctx->unwrapped, &ctx->co));
+  assert_int_equal(BLEN(&ctx->source), BLEN(&ctx->unwrapped));
+  assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped),
+      BLEN(&ctx->source));
+}
+
+/**
+ * Check that too-long messages are gracefully rejected.
+ */
+static void tls_crypt_fail_msg_too_long(void **state) {
+  struct test_context *ctx = (struct test_context *) *state;
+
+  buf_clear(&ctx->source);
+  assert_non_null (buf_write_alloc (&ctx->source,
+      TESTBUF_SIZE - BLEN (&ctx->ciphertext) - tls_crypt_buf_overhead() + 1));
+  assert_false (tls_crypt_wrap (&ctx->source, &ctx->ciphertext, &ctx->co));
+}
+
+/**
+ * Check that packets that were wrapped (or unwrapped) with a different key
+ * are not accepted.
+ */
+static void tls_crypt_fail_invalid_key(void **state) {
+  struct test_context *ctx = (struct test_context *) *state;
+
+  /* Change decrypt key */
+  struct key key = { { 1 } };
+  free_key_ctx (&ctx->co.key_ctx_bi.decrypt);
+  init_key_ctx (&ctx->co.key_ctx_bi.decrypt, &key, &ctx->kt, false, "TEST");
+
+  assert_true (tls_crypt_wrap (&ctx->source, &ctx->ciphertext, &ctx->co));
+  assert_true (BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
+  assert_false (tls_crypt_unwrap (&ctx->ciphertext, &ctx->unwrapped, &ctx->co));
+}
+
+/**
+ * Check that replayed packets are not accepted.
+ */
+static void tls_crypt_fail_replay(void **state) {
+  struct test_context *ctx = (struct test_context *) *state;
+
+  assert_true (tls_crypt_wrap (&ctx->source, &ctx->ciphertext, &ctx->co));
+  assert_true (BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
+  struct buffer tmp = ctx->ciphertext;
+  assert_true (tls_crypt_unwrap (&tmp, &ctx->unwrapped, &ctx->co));
+  buf_clear (&ctx->unwrapped);
+  assert_false (tls_crypt_unwrap (&ctx->ciphertext, &ctx->unwrapped, &ctx->co));
+}
+
+/**
+ * Check that packet replays are accepted when CO_IGNORE_PACKET_ID is set. This
+ * is used for the first control channel packet that arrives, because we don't
+ * know the packet ID yet.
+ */
+static void tls_crypt_ignore_replay(void **state) {
+  struct test_context *ctx = (struct test_context *) *state;
+
+  ctx->co.flags |= CO_IGNORE_PACKET_ID;
+
+  assert_true (tls_crypt_wrap (&ctx->source, &ctx->ciphertext, &ctx->co));
+  assert_true (BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
+  struct buffer tmp = ctx->ciphertext;
+  assert_true (tls_crypt_unwrap (&tmp, &ctx->unwrapped, &ctx->co));
+  buf_clear (&ctx->unwrapped);
+  assert_true (tls_crypt_unwrap (&ctx->ciphertext, &ctx->unwrapped, &ctx->co));
+}
+
+int main(void) {
+    const struct CMUnitTest tests[] = {
+	cmocka_unit_test_setup_teardown(tls_crypt_loopback, setup, teardown),
+	cmocka_unit_test_setup_teardown(tls_crypt_loopback_zero_len,
+					setup, teardown),
+	cmocka_unit_test_setup_teardown(tls_crypt_loopback_max_len,
+					setup, teardown),
+	cmocka_unit_test_setup_teardown(tls_crypt_fail_msg_too_long,
+					setup, teardown),
+	cmocka_unit_test_setup_teardown(tls_crypt_fail_invalid_key,
+					setup, teardown),
+	cmocka_unit_test_setup_teardown(tls_crypt_fail_replay,
+					setup, teardown),
+	cmocka_unit_test_setup_teardown(tls_crypt_ignore_replay,
+					setup, teardown),
+    };
+
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    OpenSSL_add_all_algorithms();
+#endif
+
+    int ret = cmocka_run_group_tests_name("tls-crypt tests", tests, NULL, NULL);
+
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    EVP_cleanup();
+#endif
+
+    return ret;
+}
+
+#endif /* ENABLE_CRYPTO */
-- 
2.7.4


