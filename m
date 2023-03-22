From: selva.nair@...277...
Date: Wed, 22 Mar 2023 18:14:54 -0400
Message-Id: <20230322221456.1660425-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Move digest_sign_verify out of
 test_cryptoapi.c
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

- This function will be reused for testing pkcs11

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 tests/unit_tests/openvpn/Makefile.am       |   1 +
 tests/unit_tests/openvpn/pkey_test_utils.c | 141 +++++++++++++++++++++
 tests/unit_tests/openvpn/test_cryptoapi.c  |  98 +-------------
 3 files changed, 143 insertions(+), 97 deletions(-)
 create mode 100644 tests/unit_tests/openvpn/pkey_test_utils.c

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 4391a54e..30659561 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -156,6 +156,7 @@ cryptoapi_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 cryptoapi_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt
 cryptoapi_testdriver_SOURCES = test_cryptoapi.c mock_msg.c \
+	pkey_test_utils.c \
 	$(top_srcdir)/src/openvpn/xkey_helper.c \
 	$(top_srcdir)/src/openvpn/xkey_provider.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
diff --git a/tests/unit_tests/openvpn/pkey_test_utils.c b/tests/unit_tests/openvpn/pkey_test_utils.c
new file mode 100644
index 00000000..7adaf33f
--- /dev/null
+++ b/tests/unit_tests/openvpn/pkey_test_utils.c
@@ -0,0 +1,141 @@
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
+
+#include "syshead.h"
+#include "xkey_common.h"
+#include <setjmp.h>
+#include <cmocka.h>
+
+#ifdef HAVE_XKEY_PROVIDER
+
+#include <openssl/core_names.h>
+#include <openssl/evp.h>
+
+extern OSSL_LIB_CTX *tls_libctx;
+
+/* A message for signing */
+static const char *test_msg = "Lorem ipsum dolor sit amet, consectetur "
+                              "adipisici elit, sed eiusmod tempor incidunt "
+                              "ut labore et dolore magna aliqua.";
+
+/**
+ * Sign "test_msg" using a private key. The key may be a "provided" key
+ * in which case its signed by the provider's backend -- cryptoapi in our
+ * case. Then verify the signature using OpenSSL.
+ * Returns 1 on success, 0 on error.
+ */
+int
+digest_sign_verify(EVP_PKEY *privkey, EVP_PKEY *pubkey)
+{
+    uint8_t *sig = NULL;
+    size_t siglen = 0;
+    int ret = 0;
+
+    OSSL_PARAM params[2] = {OSSL_PARAM_END};
+    const char *mdname = "SHA256";
+
+    if (EVP_PKEY_get_id(privkey) == EVP_PKEY_RSA)
+    {
+        const char *padmode = "pss"; /* RSA_PSS: for all other params, use defaults */
+        params[0] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_PAD_MODE,
+                                                     (char *)padmode, 0);
+        params[1] = OSSL_PARAM_construct_end();
+    }
+    else if (EVP_PKEY_get_id(privkey) == EVP_PKEY_EC)
+    {
+        params[0] = OSSL_PARAM_construct_end();
+    }
+    else
+    {
+        print_error("Unknown key type in digest_sign_verify()");
+        return ret;
+    }
+
+    EVP_PKEY_CTX *pctx = NULL;
+    EVP_MD_CTX *mctx = EVP_MD_CTX_new();
+
+    if (!mctx
+        || EVP_DigestSignInit_ex(mctx, &pctx, mdname, tls_libctx, NULL, privkey,  params) <= 0)
+    {
+        /* cmocka assert output for these kinds of failures is hardly explanatory,
+         * print a message and assert in caller. */
+        print_error("Failed to initialize EVP_DigestSignInit_ex()\n");
+        goto done;
+    }
+
+    /* sign with sig = NULL to get required siglen */
+    if (EVP_DigestSign(mctx, sig, &siglen, (uint8_t *)test_msg, strlen(test_msg)) != 1)
+    {
+        print_error("EVP_DigestSign: failed to get required signature size");
+        goto done;
+    }
+    assert_true(siglen > 0);
+
+    if ((sig = test_calloc(1, siglen)) == NULL)
+    {
+        print_error("Out of memory");
+        goto done;
+    }
+    if (EVP_DigestSign(mctx, sig, &siglen, (uint8_t *)test_msg, strlen(test_msg)) != 1)
+    {
+        print_error("EVP_DigestSign: signing failed");
+        goto done;
+    }
+
+    /*
+     * Now validate the signature using OpenSSL. Just use the public key
+     * which is a native OpenSSL key.
+     */
+    EVP_MD_CTX_free(mctx); /* this also frees pctx */
+    mctx = EVP_MD_CTX_new();
+    pctx = NULL;
+    if (!mctx
+        || EVP_DigestVerifyInit_ex(mctx, &pctx, mdname, tls_libctx, NULL, pubkey,  params) <= 0)
+    {
+        print_error("Failed to initialize EVP_DigestVerifyInit_ex()");
+        goto done;
+    }
+    if (EVP_DigestVerify(mctx, sig, siglen, (uint8_t *)test_msg, strlen(test_msg)) != 1)
+    {
+        print_error("EVP_DigestVerify failed");
+        goto done;
+    }
+    ret = 1;
+
+done:
+    if (mctx)
+    {
+        EVP_MD_CTX_free(mctx); /* this also frees pctx */
+    }
+    test_free(sig);
+    return ret;
+}
+#endif /* HAVE_XKEY_PROVIDER */
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index e64a1de3..c8468103 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -67,11 +67,6 @@ OSSL_LIB_CTX *tls_libctx;
 #define _countof(x) sizeof((x))/sizeof(*(x))
 #endif
 
-/* A message for signing */
-static const char *test_msg = "Lorem ipsum dolor sit amet, consectetur "
-                              "adipisici elit, sed eiusmod tempor incidunt "
-                              "ut labore et dolore magna aliqua.";
-
 /* test data */
 static const uint8_t test_hash[] = {
     0x77, 0x38, 0x65, 0x00, 0x1e, 0x96, 0x48, 0xc6, 0x57, 0x0b, 0xae,
@@ -374,98 +369,7 @@ teardown_xkey_provider(void **state)
     return 0;
 }
 
-/**
- * Sign "test_msg" using a private key. The key may be a "provided" key
- * in which case its signed by the provider's backend -- cryptoapi in our
- * case. Then verify the signature using OpenSSL.
- * Returns 1 on success, 0 on error.
- */
-static int
-digest_sign_verify(EVP_PKEY *privkey, EVP_PKEY *pubkey)
-{
-    uint8_t *sig = NULL;
-    size_t siglen = 0;
-    int ret = 0;
-
-    OSSL_PARAM params[2] = {OSSL_PARAM_END};
-    const char *mdname = "SHA256";
-
-    if (EVP_PKEY_get_id(privkey) == EVP_PKEY_RSA)
-    {
-        const char *padmode = "pss"; /* RSA_PSS: for all other params, use defaults */
-        params[0] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_PAD_MODE,
-                                                     (char *)padmode, 0);
-        params[1] = OSSL_PARAM_construct_end();
-    }
-    else if (EVP_PKEY_get_id(privkey) == EVP_PKEY_EC)
-    {
-        params[0] = OSSL_PARAM_construct_end();
-    }
-    else
-    {
-        print_error("Unknown key type in digest_sign_verify()");
-        return ret;
-    }
-
-    EVP_PKEY_CTX *pctx = NULL;
-    EVP_MD_CTX *mctx = EVP_MD_CTX_new();
-
-    if (!mctx
-        || EVP_DigestSignInit_ex(mctx, &pctx, mdname, tls_libctx, NULL, privkey,  params) <= 0)
-    {
-        /* cmocka assert output for these kinds of failures is hardly explanatory,
-         * print a message and assert in caller. */
-        print_error("Failed to initialize EVP_DigestSignInit_ex()\n");
-        goto done;
-    }
-
-    /* sign with sig = NULL to get required siglen */
-    if (EVP_DigestSign(mctx, sig, &siglen, (uint8_t *)test_msg, strlen(test_msg)) != 1)
-    {
-        print_error("EVP_DigestSign: failed to get required signature size");
-        goto done;
-    }
-    assert_true(siglen > 0);
-
-    if ((sig = test_calloc(1, siglen)) == NULL)
-    {
-        print_error("Out of memory");
-        goto done;
-    }
-    if (EVP_DigestSign(mctx, sig, &siglen, (uint8_t *)test_msg, strlen(test_msg)) != 1)
-    {
-        print_error("EVP_DigestSign: signing failed");
-        goto done;
-    }
-
-    /*
-     * Now validate the signature using OpenSSL. Just use the public key
-     * which is a native OpenSSL key.
-     */
-    EVP_MD_CTX_free(mctx); /* this also frees pctx */
-    mctx = EVP_MD_CTX_new();
-    pctx = NULL;
-    if (!mctx
-        || EVP_DigestVerifyInit_ex(mctx, &pctx, mdname, tls_libctx, NULL, pubkey,  params) <= 0)
-    {
-        print_error("Failed to initialize EVP_DigestVerifyInit_ex()");
-        goto done;
-    }
-    if (EVP_DigestVerify(mctx, sig, siglen, (uint8_t *)test_msg, strlen(test_msg)) != 1)
-    {
-        print_error("EVP_DigestVerify failed");
-        goto done;
-    }
-    ret = 1;
-
-done:
-    if (mctx)
-    {
-        EVP_MD_CTX_free(mctx); /* this also frees pctx */
-    }
-    test_free(sig);
-    return ret;
-}
+int digest_sign_verify(EVP_PKEY *privkey, EVP_PKEY *pubkey);
 
 /* Load sample certificates & keys, sign a test message using
  * them and verify the signature.
-- 
2.34.1


