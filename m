From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:27 -0500
Message-Id: <20211214165928.30676-18-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 17/18] xkey-provider: Add a test for
 generic key load and signature
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

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 configure.ac                             |   2 -
 tests/unit_tests/openvpn/Makefile.am     |   4 -
 tests/unit_tests/openvpn/test_provider.c | 112 +++++++++++++++++++++--
 3 files changed, 105 insertions(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index c446f631..e0f9c332 100644
--- a/configure.ac
+++ b/configure.ac
@@ -766,8 +766,6 @@ PKG_CHECK_MODULES(
 	[]
 )
 
-AM_CONDITIONAL([HAVE_XKEY_PROVIDER], [false])
-
 if test "${with_crypto_library}" = "openssl"; then
 	AC_ARG_VAR([OPENSSL_CFLAGS], [C compiler flags for OpenSSL])
 	AC_ARG_VAR([OPENSSL_LIBS], [linker flags for OpenSSL])
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 96b670ae..6b5c94ab 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -11,9 +11,7 @@ if HAVE_LD_WRAP_SUPPORT
 test_binaries += tls_crypt_testdriver
 endif
 
-if HAVE_XKEY_PROVIDER
 test_binaries += provider_testdriver
-endif
 
 TESTS = $(test_binaries)
 check_PROGRAMS = $(test_binaries)
@@ -99,7 +97,6 @@ networking_testdriver_SOURCES = test_networking.c mock_msg.c \
 	$(openvpn_srcdir)/platform.c
 endif
 
-if HAVE_XKEY_PROVIDER
 provider_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
@@ -113,7 +110,6 @@ provider_testdriver_SOURCES = test_provider.c mock_msg.c \
 	$(openvpn_srcdir)/base64.c \
 	mock_get_random.c \
 	$(openvpn_srcdir)/platform.c
-endif
 
 auth_token_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index dcf39019..0182b3b4 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -29,6 +29,10 @@
 #endif
 
 #include "syshead.h"
+#include "manage.h"
+#include "xkey_common.h"
+
+#ifdef HAVE_XKEY_PROVIDER
 
 #include <setjmp.h>
 #include <cmocka.h>
@@ -37,9 +41,6 @@
 #include <openssl/core_names.h>
 #include <openssl/evp.h>
 
-#include "manage.h"
-#include "xkey_common.h"
-
 struct management *management; /* global */
 static int mgmt_callback_called;
 
@@ -91,11 +92,11 @@ static const char *test_digest_b64 = "dzhlAB6WSMZXC67At5b5Zk1f0Lfb8zq/Asx4YYMgIO
  * --- the smallest size of the actual signature with the above
  * keys.
  */
-const uint8_t good_sig[] =
+static const uint8_t good_sig[] =
    {0xd8, 0xa7, 0xd9, 0x81, 0xd8, 0xaa, 0xd8, 0xad, 0x20, 0xd9, 0x8a, 0xd8,
     0xa7, 0x20, 0xd8, 0xb3, 0xd9, 0x85, 0xd8, 0xb3, 0xd9, 0x85, 0x0};
 
-const char *good_sig_b64 = "2KfZgdiq2K0g2YrYpyDYs9mF2LPZhQA=";
+static const char *good_sig_b64 = "2KfZgdiq2K0g2YrYpyDYs9mF2LPZhQA=";
 
 static EVP_PKEY *
 load_pubkey(const char *pem)
@@ -155,10 +156,16 @@ management_query_pk_sig(struct management *man, const char *b64_data,
     if (strstr(algorithm, "data=message"))
     {
          expected_tbs = test_msg_b64;
+         assert_non_null(strstr(algorithm, "hashalg=SHA256"));
     }
-
     assert_string_equal(b64_data, expected_tbs);
 
+    /* We test using ECDSA or PSS with saltlen = digest */
+    if (!strstr(algorithm, "ECDSA"))
+    {
+        assert_non_null(strstr(algorithm, "RSA_PKCS1_PSS_PADDING,hashalg=SHA256,saltlen=digest"));
+    }
+
     /* Return a predefined string as sig so that the caller
      * can confirm that this callback was exercised.
      */
@@ -230,7 +237,6 @@ digest_sign(EVP_PKEY *pkey)
         goto done;
     }
 
-
     /* sign with sig = NULL to get required siglen */
     assert_int_equal(EVP_DigestSign(mctx, sig, &siglen, (uint8_t*)test_msg, strlen(test_msg)), 1);
     assert_true(siglen > 0);
@@ -288,6 +294,90 @@ again:
     }
 }
 
+/* helpers for testing generic key load and sign */
+static int xkey_free_called;
+static int xkey_sign_called;
+static void
+xkey_free(void *handle)
+{
+    xkey_free_called = 1;
+    /* We use a dummy string as handle -- check its value */
+    assert_string_equal(handle, "xkey_handle");
+}
+
+static int
+xkey_sign(void *handle, unsigned char *sig, size_t *siglen,
+          const unsigned char *tbs, size_t tbslen, XKEY_SIGALG s)
+{
+    if (!sig)
+    {
+        *siglen = 256; /* some arbitrary size */
+        return 1;
+    }
+
+    xkey_sign_called = 1; /* called with non-null sig */
+
+    if (!strcmp(s.op, "DigestSign"))
+    {
+        assert_memory_equal(tbs, test_msg, strlen(test_msg));
+    }
+    else
+    {
+        assert_memory_equal(tbs, test_digest, sizeof(test_digest));
+    }
+
+    /* For the test use sha256 and PSS padding for RSA */
+    assert_int_equal(OBJ_sn2nid(s.mdname), NID_sha256);
+    if (!strcmp(s.keytype, "RSA"))
+    {
+        assert_string_equal(s.padmode, "pss"); /* we use PSS for the test */
+    }
+    else if (strcmp(s.keytype, "EC"))
+    {
+        fail_msg("Unknown keytype: %s", s.keytype);
+    }
+
+    /* return a predefined string as sig */
+    memcpy(sig, good_sig, min_int(sizeof(good_sig), *siglen));
+
+    return 1;
+}
+
+/* Load a key as a generic key and check its sign op gets
+ * called for signature.
+ */
+static void
+xkey_provider_test_generic_sign_cb(void **state)
+{
+    EVP_PKEY *pubkey;
+    const char *dummy = "xkey_handle"; /* a dummy handle for the external key */
+
+    for (size_t i = 0; i < _countof(pubkeys); i++)
+    {
+        pubkey = load_pubkey(pubkeys[i]);
+        assert_true(pubkey != NULL);
+
+        EVP_PKEY *privkey = xkey_load_generic_key(NULL, (void*)dummy, pubkey, xkey_sign, xkey_free);
+        assert_true(privkey != NULL);
+
+        xkey_sign_called = 0;
+        xkey_free_called = 0;
+        uint8_t *sig = digest_sign(privkey);
+        assert_non_null(sig);
+
+        /* check callback for signature got exercised */
+        assert_int_equal(xkey_sign_called, 1);
+        assert_memory_equal(sig, good_sig, sizeof(good_sig));
+        test_free(sig);
+
+        EVP_PKEY_free(pubkey);
+        EVP_PKEY_free(privkey);
+
+        /* check key's free-op got called */
+        assert_int_equal(xkey_free_called, 1);
+    }
+}
+
 int
 main(void)
 {
@@ -296,6 +386,7 @@ main(void)
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(xkey_provider_test_fetch),
         cmocka_unit_test(xkey_provider_test_mgmt_sign_cb),
+        cmocka_unit_test(xkey_provider_test_generic_sign_cb),
     };
 
     int ret = cmocka_run_group_tests_name("xkey provider tests", tests, NULL, NULL);
@@ -303,3 +394,10 @@ main(void)
     uninit_test();
     return ret;
 }
+#else
+int
+main(void)
+{
+    return 0;
+}
+#endif /* HAVE_XKEY_PROVIDER */
-- 
2.30.2


