From: selva.nair@...277...
Date: Tue, 14 Feb 2023 13:39:28 -0500
Message-Id: <20230214183928.572371-1-selva.nair@...277...>
In-Reply-To: <20230204064010.257925-2-selva.nair@...277...>
References: <20230204064010.257925-2-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 3/3] Add a unit test for functions in
 cryptoapi.c
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

From: Selva Nair <selva.nair@...277...>

- Though named cryptoapi_testdriver, right now this only tests
  parsing of thumbprint specified as a selector for --cryptioapicert
  option. More tests coming..

v2: a line that belongs here was mistakenly included in the previous
commit. Corrected.
v3: add to list of tests run in github actions

Signed-off-by: Selva Nair <selva.nair@...277...>

fixup
---
 .github/workflows/build.yaml              |   3 +
 tests/unit_tests/openvpn/Makefile.am      |  16 +++
 tests/unit_tests/openvpn/test_cryptoapi.c | 126 ++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 tests/unit_tests/openvpn/test_cryptoapi.c

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 699964fd..5bd6da89 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -243,6 +243,9 @@ jobs:
       - name: Run bufferunit test
         run: ./unittests/buffer_testdriver.exe
 
+      - name: Run cryptoapi unit test
+        run: ./unittests/cryptoapi_testdriver.exe
+
       - name: Run cryptounit test
         run: ./unittests/crypto_testdriver.exe
 
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 8d2386e0..ee0a3d8a 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -17,6 +17,7 @@ endif
 test_binaries += provider_testdriver
 
 if WIN32
+test_binaries += cryptoapi_testdriver
 LDADD = -lws2_32
 endif
 
@@ -152,6 +153,21 @@ provider_testdriver_SOURCES = test_provider.c mock_msg.c \
 	$(openvpn_srcdir)/win32-util.c \
 	$(openvpn_srcdir)/platform.c
 
+if WIN32
+cryptoapi_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	$(OPTIONAL_CRYPTO_CFLAGS)
+cryptoapi_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
+	$(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt
+cryptoapi_testdriver_SOURCES = test_cryptoapi.c mock_msg.c \
+	$(openvpn_srcdir)/xkey_helper.c \
+	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/base64.c \
+	$(openvpn_srcdir)/platform.c \
+	mock_get_random.c \
+	$(openvpn_srcdir)/win32-util.c
+endif
+
 auth_token_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
new file mode 100644
index 00000000..2bea3f42
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -0,0 +1,126 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2023 Selva Nair <selva.nair@...277...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation, either version 2 of the License,
+ *  or (at your option) any later version.
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
+#include "manage.h"
+#include "integer.h"
+#include "xkey_common.h"
+
+#if defined(HAVE_XKEY_PROVIDER) && defined (ENABLE_CRYPTOAPI)
+#include <setjmp.h>
+#include <cmocka.h>
+#include <openssl/bio.h>
+#include <openssl/pem.h>
+#include <openssl/core_names.h>
+#include <openssl/evp.h>
+
+#include <cryptoapi.h>
+#include <cryptoapi.c> /* pull-in the whole file to test static functions */
+
+struct management *management; /* global */
+
+/* mock a management function that xkey_provider needs */
+char *
+management_query_pk_sig(struct management *man, const char *b64_data,
+                        const char *algorithm)
+{
+    (void) man;
+    (void) b64_data;
+    (void) algorithm;
+    return NULL;
+}
+
+/* tls_libctx is defined in ssl_openssl.c which we do not want to compile in */
+OSSL_LIB_CTX *tls_libctx;
+
+#ifndef _countof
+#define _countof(x) sizeof((x))/sizeof(*(x))
+#endif
+
+/* test data */
+static const uint8_t test_hash[] = {
+    0x77, 0x38, 0x65, 0x00, 0x1e, 0x96, 0x48, 0xc6, 0x57, 0x0b, 0xae,
+    0xc0, 0xb7, 0x96, 0xf9, 0x66, 0x4d, 0x5f, 0xd0, 0xb7
+};
+
+/* valid test strings to test with and without embedded and trailing spaces */
+static const char *valid_str[] = {
+    "773865001e9648c6570baec0b796f9664d5fd0b7",
+    " 77 386500 1e 96 48 c6570b aec0b7   96f9664d5f  d0 b7",
+    "   773865001e9648c6570baec0b796f9664d5fd0b7  ",
+};
+
+/* some invalid strings to test with and without embedded and trailing spaces */
+static const char *invalid_str[] = {
+    "773 865001e9648c6570baec0b796f9664d5fd012",  /* space within byte */
+    "77:38:65001e9648c6570baec0b796f9664d5fd0b7", /* invalid separator */
+    "7738x5001e9648c6570baec0b796f9664d5fd0b7",   /* non hex character */
+};
+
+static void
+test_parse_hexstring(void **state)
+{
+    unsigned char hash[255];
+    (void) state;
+
+    for (int i = 0; i < _countof(valid_str); i++)
+    {
+        int len = parse_hexstring(valid_str[i], hash, _countof(hash));
+        assert_int_equal(len, sizeof(test_hash));
+        assert_memory_equal(hash, test_hash, sizeof(test_hash));
+        memset(hash, 0, _countof(hash));
+    }
+
+    for (int i = 0; i < _countof(invalid_str); i++)
+    {
+        int len = parse_hexstring(invalid_str[i], hash, _countof(hash));
+        assert_int_equal(len, 0);
+    }
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] = { cmocka_unit_test(test_parse_hexstring) };
+
+    int ret = cmocka_run_group_tests_name("cryptoapi tests", tests, NULL, NULL);
+
+    return ret;
+}
+
+#else  /* ifdef HAVE_XKEY_PROVIDER */
+
+int
+main(void)
+{
+    return 0;
+}
+
+#endif  /* ifdef HAVE_XKEY_PROVIDER */
-- 
2.34.1


