From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:26 -0500
Message-Id: <20211214165928.30676-17-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 16/18] Add a unit test for external key
 provider
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

Tests:
- Check SIGNATURE and KEYMGMT methods can be fetched
  from the provider
- Load sample RSA and EC keys as management-external-key
  and check that their sign callbacks are correctly exercised:
  with and without digest support mocked in the client
  capability flag.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 configure.ac                             |   2 +
 tests/unit_tests/openvpn/Makefile.am     |  20 ++
 tests/unit_tests/openvpn/test_provider.c | 305 +++++++++++++++++++++++
 3 files changed, 327 insertions(+)
 create mode 100644 tests/unit_tests/openvpn/test_provider.c

diff --git a/configure.ac b/configure.ac
index e0f9c332..c446f631 100644
--- a/configure.ac
+++ b/configure.ac
@@ -766,6 +766,8 @@ PKG_CHECK_MODULES(
 	[]
 )
 
+AM_CONDITIONAL([HAVE_XKEY_PROVIDER], [false])
+
 if test "${with_crypto_library}" = "openssl"; then
 	AC_ARG_VAR([OPENSSL_CFLAGS], [C compiler flags for OpenSSL])
 	AC_ARG_VAR([OPENSSL_LIBS], [linker flags for OpenSSL])
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 44b77cc5..96b670ae 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -11,6 +11,10 @@ if HAVE_LD_WRAP_SUPPORT
 test_binaries += tls_crypt_testdriver
 endif
 
+if HAVE_XKEY_PROVIDER
+test_binaries += provider_testdriver
+endif
+
 TESTS = $(test_binaries)
 check_PROGRAMS = $(test_binaries)
 
@@ -95,6 +99,22 @@ networking_testdriver_SOURCES = test_networking.c mock_msg.c \
 	$(openvpn_srcdir)/platform.c
 endif
 
+if HAVE_XKEY_PROVIDER
+provider_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	$(OPTIONAL_CRYPTO_CFLAGS)
+provider_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
+	$(OPTIONAL_CRYPTO_LIBS)
+
+provider_testdriver_SOURCES = test_provider.c mock_msg.c \
+	$(openvpn_srcdir)/xkey_helper.c \
+	$(openvpn_srcdir)/xkey_provider.c \
+	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/base64.c \
+	mock_get_random.c \
+	$(openvpn_srcdir)/platform.c
+endif
+
 auth_token_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
new file mode 100644
index 00000000..dcf39019
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -0,0 +1,305 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2021 Selva Nair <selva.nair@...277...>
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
+
+#include <setjmp.h>
+#include <cmocka.h>
+#include <openssl/bio.h>
+#include <openssl/pem.h>
+#include <openssl/core_names.h>
+#include <openssl/evp.h>
+
+#include "manage.h"
+#include "xkey_common.h"
+
+struct management *management; /* global */
+static int mgmt_callback_called;
+
+#ifndef _countof
+#define _countof(x) sizeof((x))/sizeof(*(x))
+#endif
+
+static OSSL_PROVIDER *prov[2];
+
+/* public keys for testing -- RSA and EC */
+static const char * const pubkey1 = "-----BEGIN PUBLIC KEY-----\n"
+    "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7GWP6RLCGlvmVioIqYI6\n"
+    "LUR4owA7sJ/nJxBAk+/xzD6gqgSigBsTqeb+gdZwkKjY1N4w2DUA0r5i8Eja/BWN\n"
+    "xMZtC5nxK4MACtMqIwvlzfk130NhFXKtlZj2cyFBXqDdRyeg1ZrUQagcHVcgcReP\n"
+    "9yiePgfO7NUOQk8edEeOR53SFCgnLBQQ9dGWtZN0hO/5BN6NSm/fd6vq0VjTRP5a\n"
+    "BAH/BnqX9/3jV0jh8N9AE59mI1rjVVQ9VDnuAPkS8dLfdC661/CNxt0YWByTIgt1\n"
+    "+qjW4LUvLbnU/rlPhuJ1SBZg+z/JtDBCKfs7syu5WYFqRvNFg7/91Rr/NwxvW/1h\n"
+    "8QIDAQAB\n"
+    "-----END PUBLIC KEY-----\n";
+
+static const char * const pubkey2 = "-----BEGIN PUBLIC KEY-----\n"
+    "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAEO85iXW+HgnUkwlj1DohNVw0GsnGIh1gZ\n"
+    "u95ff1JiUaJIkYNIkZA+hwIPFVH5aJcSCv3SPIeDS2VUAESNKHZJBQ==\n"
+    "-----END PUBLIC KEY-----\n";
+
+static const char *pubkeys[] = {pubkey1, pubkey2};
+
+static const char *prov_name = "ovpn.xkey";
+
+static const char* test_msg = "Lorem ipsum dolor sit amet, consectetur "
+                              "adipisici elit, sed eiusmod tempor incidunt "
+                              "ut labore et dolore magna aliqua.";
+
+static const char* test_msg_b64 =
+    "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2ljaS"
+    "BlbGl0LCBzZWQgZWl1c21vZCB0ZW1wb3IgaW5jaWR1bnQgdXQgbGFib3JlIGV0IGRv"
+    "bG9yZSBtYWduYSBhbGlxdWEu";
+
+/* Sha256 digest of test_msg excluding NUL terminator */
+static const uint8_t test_digest[] =
+    {0x77, 0x38, 0x65, 0x00, 0x1e, 0x96, 0x48, 0xc6, 0x57, 0x0b, 0xae,
+     0xc0, 0xb7, 0x96, 0xf9, 0x66, 0x4d, 0x5f, 0xd0, 0xb7, 0xdb, 0xf3,
+     0x3a, 0xbf, 0x02, 0xcc, 0x78, 0x61, 0x83, 0x20, 0x20, 0xee};
+
+static const char *test_digest_b64 = "dzhlAB6WSMZXC67At5b5Zk1f0Lfb8zq/Asx4YYMgIO4=";
+
+/* Dummy signature used only to check that the expected callback
+ * was successfully exercised. Keep this shorter than 64 bytes
+ * --- the smallest size of the actual signature with the above
+ * keys.
+ */
+const uint8_t good_sig[] =
+   {0xd8, 0xa7, 0xd9, 0x81, 0xd8, 0xaa, 0xd8, 0xad, 0x20, 0xd9, 0x8a, 0xd8,
+    0xa7, 0x20, 0xd8, 0xb3, 0xd9, 0x85, 0xd8, 0xb3, 0xd9, 0x85, 0x0};
+
+const char *good_sig_b64 = "2KfZgdiq2K0g2YrYpyDYs9mF2LPZhQA=";
+
+static EVP_PKEY *
+load_pubkey(const char *pem)
+{
+    BIO *in = BIO_new_mem_buf(pem, -1);
+    assert_non_null(in);
+
+    EVP_PKEY *pkey = PEM_read_bio_PUBKEY(in, NULL, NULL, NULL);
+    assert_non_null(pkey);
+
+    BIO_free(in);
+    return pkey;
+}
+
+static void
+init_test()
+{
+    prov[0] = OSSL_PROVIDER_load(NULL,"default");
+    OSSL_PROVIDER_add_builtin(NULL, prov_name, xkey_provider_init);
+    prov[1] = OSSL_PROVIDER_load(NULL, prov_name);
+
+    /* set default propq matching what we use in ssl_openssl.c */
+    EVP_set_default_properties(NULL, "?provider!=ovpn.xkey");
+
+    management = test_calloc(sizeof(*management), 1);
+}
+
+static void
+uninit_test()
+{
+    for (size_t i = 0; i < _countof(prov); i++)
+    {
+        if (prov[i])
+        {
+            OSSL_PROVIDER_unload(prov[i]);
+        }
+    }
+    test_free(management);
+}
+
+/* Mock management callback for signature.
+ * We check that the received data to sign matches test_msg or
+ * test_digest and return a predefined string as signature so that
+ * the caller can validate all steps up to sending the data to
+ * the management client.
+ */
+char *
+management_query_pk_sig(struct management *man, const char *b64_data,
+                        const char *algorithm)
+{
+    char *out = NULL;
+
+    /* indicate entry to the callback */
+    mgmt_callback_called = 1;
+
+    const char *expected_tbs = test_digest_b64;
+    if (strstr(algorithm, "data=message"))
+    {
+         expected_tbs = test_msg_b64;
+    }
+
+    assert_string_equal(b64_data, expected_tbs);
+
+    /* Return a predefined string as sig so that the caller
+     * can confirm that this callback was exercised.
+     */
+    out = strdup(good_sig_b64);
+    assert_non_null(out);
+
+    return out;
+}
+
+/* Check signature and keymgmt methods can be fetched from the provider */
+static void
+xkey_provider_test_fetch(void **state)
+{
+    assert_true(OSSL_PROVIDER_available(NULL, prov_name));
+
+    const char *algs[] = {"RSA", "ECDSA"};
+
+    for (size_t i = 0; i < _countof(algs); i++)
+    {
+        EVP_SIGNATURE *sig = EVP_SIGNATURE_fetch(NULL, algs[i], "provider=ovpn.xkey");
+        assert_non_null(sig);
+        assert_string_equal(OSSL_PROVIDER_get0_name(EVP_SIGNATURE_get0_provider(sig)), prov_name);
+
+        EVP_SIGNATURE_free(sig);
+    }
+
+    const char *names[] = {"RSA", "EC"};
+
+    for (size_t i = 0; i < _countof(names); i++)
+    {
+        EVP_KEYMGMT *km = EVP_KEYMGMT_fetch(NULL, names[i], "provider=ovpn.xkey");
+        assert_non_null(km);
+        assert_string_equal(OSSL_PROVIDER_get0_name(EVP_KEYMGMT_get0_provider(km)), prov_name);
+
+        EVP_KEYMGMT_free(km);
+    }
+}
+
+/* sign a test message using pkey -- caller must free the returned sig */
+static uint8_t *
+digest_sign(EVP_PKEY *pkey)
+{
+    uint8_t *sig = NULL;
+    size_t siglen = 0;
+
+    OSSL_PARAM params[6] = {OSSL_PARAM_END};
+
+    const char *mdname = "SHA256";
+    const char *padmode = "pss";
+    const char *saltlen = "digest";
+
+    if (EVP_PKEY_get_id(pkey) == EVP_PKEY_RSA)
+    {
+        params[0] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_DIGEST, (char *)mdname, 0);
+        params[1] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_PAD_MODE, (char *)padmode, 0);
+        params[2] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_PSS_SALTLEN, (char *)saltlen, 0);
+        /* same digest for mgf1 */
+        params[3] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_MGF1_DIGEST, (char *)saltlen, 0);
+        params[4] = OSSL_PARAM_construct_end();
+    }
+
+    EVP_PKEY_CTX *pctx = NULL;
+    EVP_MD_CTX *mctx = EVP_MD_CTX_new();
+
+    if (!mctx
+        || EVP_DigestSignInit_ex(mctx, &pctx, mdname, NULL, NULL, pkey,  params) <= 0)
+    {
+        fail_msg("Failed to initialize EVP_DigestSignInit_ex()");
+        goto done;
+    }
+
+
+    /* sign with sig = NULL to get required siglen */
+    assert_int_equal(EVP_DigestSign(mctx, sig, &siglen, (uint8_t*)test_msg, strlen(test_msg)), 1);
+    assert_true(siglen > 0);
+
+    if ((sig = test_calloc(1, siglen)) == NULL)
+    {
+        fail_msg("Out of memory");
+    }
+    assert_int_equal(EVP_DigestSign(mctx, sig, &siglen, (uint8_t*)test_msg, strlen(test_msg)), 1);
+
+done:
+    if (mctx)
+    {
+        EVP_MD_CTX_free(mctx); /* pctx is internally allocated and freed by mctx */
+    }
+    return sig;
+}
+
+/* Check loading of management external key and have sign callback exercised
+ * for RSA and EC keys with and without digest support in management client.
+ * Sha256 digest used for both cases with pss padding for RSA.
+ */
+static void
+xkey_provider_test_mgmt_sign_cb(void **state)
+{
+    EVP_PKEY *pubkey;
+    for (size_t i = 0; i < _countof(pubkeys); i++)
+    {
+        pubkey = load_pubkey(pubkeys[i]);
+        assert_true(pubkey != NULL);
+        EVP_PKEY *privkey = xkey_load_management_key(NULL, pubkey);
+        assert_true(privkey != NULL);
+
+        management->settings.flags = MF_EXTERNAL_KEY|MF_EXTERNAL_KEY_PSSPAD;
+
+        /* first without digest support in management client */
+again:
+        mgmt_callback_called = 0;
+        uint8_t *sig = digest_sign(privkey);
+        assert_non_null(sig);
+
+        /* check callback for signature got exercised */
+        assert_int_equal(mgmt_callback_called, 1);
+        assert_memory_equal(sig, good_sig, sizeof(good_sig));
+        test_free(sig);
+
+        if (!(management->settings.flags & MF_EXTERNAL_KEY_DIGEST))
+        {
+            management->settings.flags |= MF_EXTERNAL_KEY_DIGEST;
+            goto again; /* this time with digest support announced */
+        }
+
+        EVP_PKEY_free(pubkey);
+        EVP_PKEY_free(privkey);
+    }
+}
+
+int
+main(void)
+{
+    init_test();
+
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(xkey_provider_test_fetch),
+        cmocka_unit_test(xkey_provider_test_mgmt_sign_cb),
+    };
+
+    int ret = cmocka_run_group_tests_name("xkey provider tests", tests, NULL, NULL);
+
+    uninit_test();
+    return ret;
+}
-- 
2.30.2


