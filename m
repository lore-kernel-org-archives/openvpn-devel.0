From: selva.nair@...277...
Date: Tue, 14 Mar 2023 21:35:16 -0400
Message-Id: <20230315013516.1256700-5-selva.nair@...277...>
In-Reply-To: <20230315013516.1256700-1-selva.nair@...277...>
References: <20230315013516.1256700-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] Add a test for signing with
 certificates in Windows store
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

- For each sample certificate/key pair imported into the store,
  load the key into xkey-provider and sign a test message.
  As the key is "provided", signing will use appropriate
  backend (Windows CNG in this case).

  The signature is then verified using OpenSSL.

Change-Id: I520b34ba51e8c6d0247a82edc52bde181ab5a717
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 tests/unit_tests/openvpn/Makefile.am      |   1 +
 tests/unit_tests/openvpn/test_cryptoapi.c | 166 ++++++++++++++++++++++
 2 files changed, 167 insertions(+)

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 339c7ef3..4391a54e 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -157,6 +157,7 @@ cryptoapi_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt
 cryptoapi_testdriver_SOURCES = test_cryptoapi.c mock_msg.c \
 	$(top_srcdir)/src/openvpn/xkey_helper.c \
+	$(top_srcdir)/src/openvpn/xkey_provider.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/platform.c \
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index ccb3207c..b07e8935 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -47,6 +47,7 @@
 #include <cryptoapi.c> /* pull-in the whole file to test static functions */
 
 struct management *management; /* global */
+static OSSL_PROVIDER *prov[2];
 
 /* mock a management function that xkey_provider needs */
 char *
@@ -66,6 +67,11 @@ OSSL_LIB_CTX *tls_libctx;
 #define _countof(x) sizeof((x))/sizeof(*(x))
 #endif
 
+/* A message for signing */
+static const char *test_msg = "Lorem ipsum dolor sit amet, consectetur "
+                              "adipisici elit, sed eiusmod tempor incidunt "
+                              "ut labore et dolore magna aliqua.";
+
 /* test data */
 static const uint8_t test_hash[] = {
     0x77, 0x38, 0x65, 0x00, 0x1e, 0x96, 0x48, 0xc6, 0x57, 0x0b, 0xae,
@@ -336,6 +342,164 @@ test_find_cert_byissuer(void **state)
     gc_free(&gc);
 }
 
+static int
+setup_cryptoapi_sign(void **state)
+{
+    (void) state;
+    /* Initialize providers in a way matching what OpenVPN core does */
+    tls_libctx = OSSL_LIB_CTX_new();
+    prov[0] = OSSL_PROVIDER_load(tls_libctx, "default");
+    OSSL_PROVIDER_add_builtin(tls_libctx, "ovpn.xkey", xkey_provider_init);
+    prov[1] = OSSL_PROVIDER_load(tls_libctx, "ovpn.xkey");
+
+    /* set default propq as we do in ssl_openssl.c */
+    EVP_set_default_properties(tls_libctx, "?provider!=ovpn.xkey");
+    return 0;
+}
+
+static int
+teardown_cryptoapi_sign(void **state)
+{
+    (void) state;
+    for (size_t i = 0; i < _countof(prov); i++)
+    {
+        if (prov[i])
+        {
+            OSSL_PROVIDER_unload(prov[i]);
+            prov[i] = NULL;
+        }
+    }
+    OSSL_LIB_CTX_free(tls_libctx);
+    tls_libctx = NULL;
+    return 0;
+}
+
+/**
+ * Sign "test_msg" using a private key. The key may be a "provided" key
+ * in which case its signed by the provider's backend -- cryptoapi in our
+ * case. Then verify the signature using OpenSSL.
+ * Returns 1 on success, 0 on error.
+ */
+static int
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
+
+/* Load sample certificates & keys, sign a test message using
+ * them and verify the signature.
+ */
+void
+test_cryptoapi_sign(void **state)
+{
+    (void) state;
+    char select_string[64];
+    X509 *x509 = NULL;
+    EVP_PKEY *privkey = NULL;
+
+    import_certs(state); /* a no-op if already imported */
+    assert_true(certs_loaded);
+
+    for (struct test_cert *c = certs; c->cert; c++)
+    {
+        if (c->valid == 0)
+        {
+            continue;
+        }
+        openvpn_snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash);
+        if (Load_CryptoAPI_certificate(select_string, &x509, &privkey) != 1)
+        {
+            fail_msg("Load_CryptoAPI_certificate failed: <%s>", c->friendly_name);
+            return;
+        }
+        EVP_PKEY *pubkey = X509_get_pubkey(x509);
+        assert_int_equal(digest_sign_verify(privkey, pubkey), 1);
+        X509_free(x509);
+        EVP_PKEY_free(privkey);
+    }
+}
+
 static void
 test_parse_hexstring(void **state)
 {
@@ -366,6 +530,8 @@ main(void)
         cmocka_unit_test(test_find_cert_bythumb),
         cmocka_unit_test(test_find_cert_byname),
         cmocka_unit_test(test_find_cert_byissuer),
+        cmocka_unit_test_setup_teardown(test_cryptoapi_sign, setup_cryptoapi_sign,
+                                        teardown_cryptoapi_sign),
     };
 
     int ret = cmocka_run_group_tests_name("cryptoapi tests", tests, NULL, cleanup);
-- 
2.34.1


