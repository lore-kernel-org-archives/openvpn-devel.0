From: selva.nair@...277...
Date: Sat, 18 Mar 2023 10:43:25 -0400
Message-Id: <20230318144325.1316320-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Unit tests: add test for
 SSL_CTX_use_Cryptoapi_certificate()
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

- This is the only remaining function in cryptoapi.c that has no
  direct or indirect test.

  This test confirms that an SSL_CTX context gets a certificate and
  private key loaded into it and the public key in the certificate
  matches the private key. As signing with certificate/key pairs
  fetched from the store is independently tested by the 'cryptoapi_sign'
  test, signing is not re-tested here.

  The functions "setup_/teardown_cryptoapi_sign()" are renamed to
  "setup_/teardown_xkey_provider()" to better reflect their purpose.
  These are also reused for the new test.

  While touching this context, also fix a memory leak in
  test_cryptoapi_sign: X509_get_pubkey() -> X509_get0_pubkey()

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 tests/unit_tests/openvpn/test_cryptoapi.c | 51 ++++++++++++++++++++---
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index b07e8935..e64a1de3 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -343,7 +343,7 @@ test_find_cert_byissuer(void **state)
 }
 
 static int
-setup_cryptoapi_sign(void **state)
+setup_xkey_provider(void **state)
 {
     (void) state;
     /* Initialize providers in a way matching what OpenVPN core does */
@@ -358,7 +358,7 @@ setup_cryptoapi_sign(void **state)
 }
 
 static int
-teardown_cryptoapi_sign(void **state)
+teardown_xkey_provider(void **state)
 {
     (void) state;
     for (size_t i = 0; i < _countof(prov); i++)
@@ -493,13 +493,52 @@ test_cryptoapi_sign(void **state)
             fail_msg("Load_CryptoAPI_certificate failed: <%s>", c->friendly_name);
             return;
         }
-        EVP_PKEY *pubkey = X509_get_pubkey(x509);
+        EVP_PKEY *pubkey = X509_get0_pubkey(x509);
+        assert_non_null(pubkey);
         assert_int_equal(digest_sign_verify(privkey, pubkey), 1);
         X509_free(x509);
         EVP_PKEY_free(privkey);
     }
 }
 
+/* Test that SSL_CTX_use_Cryptoapi_certificate() sets a matching certificate
+ * and key in ssl_ctx.
+ */
+void
+test_ssl_ctx_use_cryptoapicert(void **state)
+{
+    (void) state;
+    char select_string[64];
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
+        SSL_CTX *ssl_ctx = SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_client_method());
+        assert_non_null(ssl_ctx);
+
+        openvpn_snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash);
+        if (!SSL_CTX_use_CryptoAPI_certificate(ssl_ctx, select_string))
+        {
+            fail_msg("SSL_CTX_use_CryptoAPI_certificate failed: <%s>", c->friendly_name);
+            return;
+        }
+        /* Use OpenSSL to check that the cert and private key in ssl_ctx "match" */
+        if (!SSL_CTX_check_private_key(ssl_ctx))
+        {
+            fail_msg("Certificate and private key in ssl_ctx do not match for <%s>", c->friendly_name);
+            return;
+        }
+
+        SSL_CTX_free(ssl_ctx);
+    }
+}
+
 static void
 test_parse_hexstring(void **state)
 {
@@ -530,8 +569,10 @@ main(void)
         cmocka_unit_test(test_find_cert_bythumb),
         cmocka_unit_test(test_find_cert_byname),
         cmocka_unit_test(test_find_cert_byissuer),
-        cmocka_unit_test_setup_teardown(test_cryptoapi_sign, setup_cryptoapi_sign,
-                                        teardown_cryptoapi_sign),
+        cmocka_unit_test_setup_teardown(test_cryptoapi_sign, setup_xkey_provider,
+                                        teardown_xkey_provider),
+        cmocka_unit_test_setup_teardown(test_ssl_ctx_use_cryptoapicert, setup_xkey_provider,
+                                        teardown_xkey_provider),
     };
 
     int ret = cmocka_run_group_tests_name("cryptoapi tests", tests, NULL, cleanup);
-- 
2.34.1


