From: selva.nair@...277...
Date: Tue, 14 Mar 2023 21:35:14 -0400
Message-Id: <20230315013516.1256700-3-selva.nair@...277...>
In-Reply-To: <20230315013516.1256700-1-selva.nair@...277...>
References: <20230315013516.1256700-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] Add tests for finding certificates in
 Windows cert store
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

- find_certificate_in_store tested using 'SUBJ:', 'THUMB:'
  and 'ISSUER:' select strings. Uses test certificates
  imported into the store during the import test.

Change-Id: Ib5138465e6228538af592ca98b3d877277355f59
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 tests/unit_tests/openvpn/test_cryptoapi.c | 102 ++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 54dbd094..ccb3207c 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -237,6 +237,105 @@ cleanup(void **state)
     return 0;
 }
 
+static void
+test_find_cert_bythumb(void **state)
+{
+    (void) state;
+    char select_string[64];
+    struct gc_arena gc = gc_new();
+    const CERT_CONTEXT *ctx;
+
+    import_certs(state); /* a no-op if already imported */
+    assert_non_null(user_store);
+
+    for (struct test_cert *c = certs; c->cert; c++)
+    {
+        openvpn_snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash);
+        ctx = find_certificate_in_store(select_string, user_store);
+        if (ctx)
+        {
+            /* check we got the right certificate and is valid */
+            assert_int_equal(c->valid, 1);
+            char *friendly_name = get_cert_name(ctx, &gc);
+            assert_string_equal(c->friendly_name, friendly_name);
+            CertFreeCertificateContext(ctx);
+        }
+        else
+        {
+            /* find should fail only if the certificate has expired */
+            assert_int_equal(c->valid, 0);
+        }
+    }
+
+    gc_free(&gc);
+}
+
+static void
+test_find_cert_byname(void **state)
+{
+    (void) state;
+    char select_string[64];
+    struct gc_arena gc = gc_new();
+    const CERT_CONTEXT *ctx;
+
+    import_certs(state); /* a no-op if already imported */
+    assert_non_null(user_store);
+
+    for (struct test_cert *c = certs; c->cert; c++)
+    {
+        openvpn_snprintf(select_string, sizeof(select_string), "SUBJ:%s", c->cname);
+        ctx = find_certificate_in_store(select_string, user_store);
+        /* In this case we expect a successful return as there is at least one valid
+         * cert that matches the common name. But the returned cert may not exactly match
+         * c->cert as multiple certs with same common names exist in the db. We check that
+         * the return cert is one from our db, has a matching common name and is valid.
+         */
+        assert_non_null(ctx);
+
+        char *friendly_name = get_cert_name(ctx, &gc);
+        struct test_cert *found = lookup_cert(friendly_name);
+        assert_non_null(found);
+        assert_string_equal(found->cname, c->cname);
+        assert_int_equal(found->valid, 1);
+        CertFreeCertificateContext(ctx);
+    }
+
+    gc_free(&gc);
+}
+
+static void
+test_find_cert_byissuer(void **state)
+{
+    (void) state;
+    char select_string[64];
+    struct gc_arena gc = gc_new();
+    const CERT_CONTEXT *ctx;
+
+    import_certs(state); /* a no-op if already imported */
+    assert_non_null(user_store);
+
+    for (struct test_cert *c = certs; c->cert; c++)
+    {
+        openvpn_snprintf(select_string, sizeof(select_string), "ISSUER:%s", c->issuer);
+        ctx = find_certificate_in_store(select_string, user_store);
+        /* In this case we expect a successful return as there is at least one valid
+         * cert that matches the issuer. But the returned cert may not exactly match
+         * c->cert as multiple certs with same issuer exist in the db. We check that
+         * the returned cert is one from our db, has a matching issuer name and is valid.
+         */
+        assert_non_null(ctx);
+
+        char *friendly_name = get_cert_name(ctx, &gc);
+        struct test_cert *found = lookup_cert(friendly_name);
+        assert_non_null(found);
+        assert_string_equal(found->issuer, c->issuer);
+        assert_int_equal(found->valid, 1);
+        CertFreeCertificateContext(ctx);
+    }
+
+    gc_free(&gc);
+}
+
 static void
 test_parse_hexstring(void **state)
 {
@@ -264,6 +363,9 @@ main(void)
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(test_parse_hexstring),
         cmocka_unit_test(import_certs),
+        cmocka_unit_test(test_find_cert_bythumb),
+        cmocka_unit_test(test_find_cert_byname),
+        cmocka_unit_test(test_find_cert_byissuer),
     };
 
     int ret = cmocka_run_group_tests_name("cryptoapi tests", tests, NULL, cleanup);
-- 
2.34.1


