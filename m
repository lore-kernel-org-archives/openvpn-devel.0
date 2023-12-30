From: Gert Doering <gert@...1296...>
Date: Sat, 30 Dec 2023 15:28:32 +0100
Message-ID: <20231230142832.31823-1-gert@...1296...>
In-Reply-To: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
References: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Add test_ssl unit test and test export
 of PEM to file
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

This introduces a number of mock function to be able to compile
ssl_verify_*.c and ssl_mbedtls.c/ssl_openssl.c into a unit and adds
quite a number of files to that unit. But it allows similar unit tests
(in term of dependencies) to be added in the future.

Change-Id: Ie248d35d063bb6878f3dd42840c77ba0d6fa3381
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/471
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 4393f5c..bdb30c8 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -85,7 +85,7 @@
       fail-fast: false
       matrix:
         arch: [x86, x64]
-        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, provider, tls_crypt]
+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, provider, ssl, tls_crypt]
 
     runs-on: windows-latest
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6cbee56..6ac453c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -588,6 +588,7 @@
         "test_packet_id"
         "test_pkt"
         "test_provider"
+        "test_ssl"
         )
 
     if (WIN32)
@@ -697,6 +698,34 @@
         src/openvpn/mss.c
         )
 
+    target_sources(test_ssl PRIVATE
+            tests/unit_tests/openvpn/mock_management.c
+            tests/unit_tests/openvpn/mock_ssl_dependencies.c
+            tests/unit_tests/openvpn/mock_win32_execve.c
+            src/openvpn/argv.c
+            src/openvpn/base64.c
+            src/openvpn/block_dns.c
+            src/openvpn/crypto.c
+            src/openvpn/crypto_mbedtls.c
+            src/openvpn/crypto_openssl.c
+            src/openvpn/cryptoapi.c
+            src/openvpn/env_set.c
+            src/openvpn/env_set.c
+            src/openvpn/mss.c
+            src/openvpn/mtu.c
+            src/openvpn/options_util.c
+            src/openvpn/otime.c
+            src/openvpn/packet_id.c
+            src/openvpn/run_command.c
+            src/openvpn/ssl_mbedtls.c
+            src/openvpn/ssl_openssl.c
+            src/openvpn/ssl_util.c
+            src/openvpn/ssl_verify_mbedtls.c
+            src/openvpn/ssl_verify_openssl.c
+            src/openvpn/xkey_helper.c
+            src/openvpn/xkey_provider.c
+    )
+
     target_sources(test_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
         src/openvpn/options_util.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index ef45b11..eb8ccc8 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -7,7 +7,8 @@
 endif
 
 test_binaries += crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_testdriver misc_testdriver \
-	pkt_testdriver
+	pkt_testdriver ssl_testdriver
+
 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
 test_binaries += tls_crypt_testdriver
@@ -67,6 +68,28 @@
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/mss.c
 
+ssl_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
+ssl_testdriver_LDFLAGS = @TEST_LDFLAGS@
+ssl_testdriver_SOURCES = test_crypto.c mock_msg.c mock_msg.h \
+	mock_management.c mock_ssl_dependencies.c mock_win32_execve.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/mtu.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/mss.c \
+	$(top_srcdir)/src/openvpn/xkey_provider.c \
+	$(top_srcdir)/src/openvpn/xkey_helper.c \
+	$(top_srcdir)/src/openvpn/ssl_util.c \
+	$(top_srcdir)/src/openvpn/base64.c \
+	$(top_srcdir)/src/openvpn/cryptoapi.c
+
+
 packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
 packet_id_testdriver_LDFLAGS = @TEST_LDFLAGS@
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/openvpn/mock_management.c
new file mode 100644
index 0000000..8936c3a
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -0,0 +1,51 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
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
+/* Minimal set of mocked management function/globals to get unit tests to
+ * compile */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "manage.h"
+
+#ifdef ENABLE_MANAGEMENT
+
+struct management *management; /* GLOBAL */
+
+void
+management_auth_failure(struct management *man, const char *type, const char *reason)
+{
+    ASSERT(false);
+}
+
+char *
+management_query_pk_sig(struct management *man, const char *b64_data,
+                        const char *algorithm)
+{
+    return NULL;
+}
+#endif
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
new file mode 100644
index 0000000..9231d65
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
@@ -0,0 +1,67 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
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
+/* Minimal set of mocked function/globals to get unit tests to
+ * compile that use the ssl_* files */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include <setjmp.h>
+#include <cmocka.h>
+
+
+#include "ssl.h"
+#include "ssl_verify.h"
+
+int
+parse_line(const char *line, char **p, const int n, const char *file,
+           const int line_num, int msglevel, struct gc_arena *gc)
+{
+    /* Dummy function to get the linker happy, should never be called */
+    assert_true(false);
+    return 0;
+}
+
+
+int
+pem_password_callback(char *buf, int size, int rwflag, void *u)
+{
+    return 0;
+}
+
+void
+cert_hash_remember(struct tls_session *session, const int cert_depth,
+                   const struct buffer *cert_hash)
+{
+    assert_false(true);
+}
+
+result_t
+verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_depth)
+{
+    return FAILURE;
+}
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
new file mode 100644
index 0000000..acaaad5
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -0,0 +1,139 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ * Copyright (C) 2023 OpenVPN Inc <sales@...515...>
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
+#endif
+
+#include "syshead.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "crypto.h"
+#include "options.h"
+#include "ssl_backend.h"
+#include "options_util.h"
+
+#include "mock_msg.h"
+#include "mss.h"
+#include "ssl_verify_backend.h"
+#include "win32.h"
+
+/* Mock function to be allowed to include win32.c which is required for
+ * getting the temp directory */
+#ifdef _WIN32
+struct signal_info siginfo_static; /* GLOBAL */
+
+const char *
+strerror_win32(DWORD errnum, struct gc_arena *gc)
+{
+    ASSERT(false);
+}
+
+void
+throw_signal(const int signum)
+{
+    ASSERT(false);
+}
+#endif
+
+
+const char *unittest_cert = "-----BEGIN CERTIFICATE-----\n"
+                            "MIIBuTCCAUCgAwIBAgIUTLtjSBzx53qZRvZ6Ur7D9kgoOHkwCgYIKoZIzj0EAwIw\n"
+                            "EzERMA8GA1UEAwwIdW5pdHRlc3QwIBcNMjMxMTIxMDk1NDQ3WhgPMjA3ODA4MjQw\n"
+                            "OTU0NDdaMBMxETAPBgNVBAMMCHVuaXR0ZXN0MHYwEAYHKoZIzj0CAQYFK4EEACID\n"
+                            "YgAEHYB2hn2xx3f4lClXDtdi36P19pMZA+kI1Dkv/Vn10vBZ/j9oa+P99T8duz/e\n"
+                            "QlPeHpesNJO4fX8iEDj6+vMeWejOT7jAQ4MmG5EZjpcBKxCfwFooEvzu8bVujUcu\n"
+                            "wTQEo1MwUTAdBgNVHQ4EFgQUPcgBEVXjF5vYfDsInoE3dF6UfQswHwYDVR0jBBgw\n"
+                            "FoAUPcgBEVXjF5vYfDsInoE3dF6UfQswDwYDVR0TAQH/BAUwAwEB/zAKBggqhkjO\n"
+                            "PQQDAgNnADBkAjBLPAGrQAyinigqiu0RomoV8TVaknVLFSq6H6A8jgvzfsFCUK1O\n"
+                            "dvNZhFPM6idKB+oCME2JLOBANCSV8o7aJzq7SYHKwPyb1J4JFlwKe/0Jpv7oh9b1\n"
+                            "IJbuaM9Z/VSKbrIXGg==\n"
+                            "-----END CERTIFICATE-----\n";
+
+static const char *
+get_tmp_dir()
+{
+    const char *ret;
+#ifdef _WIN32
+    ret = win_get_tempdir();
+#else
+    ret = "/tmp";
+#endif
+    assert_non_null(ret);
+    return ret;
+}
+
+static void
+crypto_pem_encode_certificate(void **state)
+{
+    struct gc_arena gc = gc_new();
+
+    struct tls_root_ctx ctx = { 0 };
+    tls_ctx_client_new(&ctx);
+    tls_ctx_load_cert_file(&ctx, unittest_cert, true);
+
+    openvpn_x509_cert_t *cert = NULL;
+
+    /* we do not have methods to fetch certificates from ssl contexts, use
+     * internal TLS library methods for the unit test */
+#ifdef ENABLE_CRYPTO_OPENSSL
+    cert = SSL_CTX_get0_certificate(ctx.ctx);
+#elif defined(ENABLE_CRYPTO_MBEDTLS)
+    cert = ctx.crt_chain;
+#endif
+
+    const char *tmpfile = platform_create_temp_file(get_tmp_dir(), "ut_pem", &gc);
+    backend_x509_write_pem(cert, tmpfile);
+
+    struct buffer exported_pem = buffer_read_from_file(tmpfile, &gc);
+    assert_string_equal(BSTR(&exported_pem), unittest_cert);
+
+    unlink(tmpfile);
+    gc_free(&gc);
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(crypto_pem_encode_certificate)
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

