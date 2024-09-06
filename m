From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  6 Sep 2024 12:39:00 +0200
Message-Id: <20240906103900.37037-1-frank@...2641...>
In-Reply-To: <gerrit.1724095724000.I7615116b5251319aa1f13d671bab7013f3a043ea@...2715...>
References: <gerrit.1724095724000.I7615116b5251319aa1f13d671bab7013f3a043ea@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add a test for loading certificate and
 key using file: URI
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

We do not load any providers, so only file: URI internally supported by
OpenSSL 3+ is tested. On non-OpenSSL 3 builds the test prints "SKIPPED".

v2: avoid dead code; rebase to current master

Change-Id: I7615116b5251319aa1f13d671bab7013f3a043ea
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/730
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index a5c58a0..a1ca344 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -66,6 +66,10 @@
 }
 #endif
 
+#if defined(ENABLE_CRYPTO_OPENSSL) && (OPENSSL_VERSION_NUMBER > 0x30000000L)
+#define HAVE_OPENSSL_STORE
+#endif
+
 /* stubs for some unused functions instead of pulling in too many dependencies */
 bool
 get_user_pass_cr(struct user_pass *up, const char *auth_file, const char *prefix,
@@ -234,6 +238,45 @@
     tls_ctx_free(&ctx);
 }
 
+/* test loading cert and key using file:/path URI */
+static void
+test_load_certificate_and_key_uri(void **state)
+{
+    (void) state;
+
+#if !defined(HAVE_OPENSSL_STORE)
+    skip();
+#else /* HAVE_OPENSSL_STORE */
+
+    struct tls_root_ctx ctx = { 0 };
+    const char *certfile = global_state.certfile;
+    const char *keyfile = global_state.keyfile;
+    struct gc_arena *gc = &global_state.gc;
+
+    struct buffer certuri = alloc_buf_gc(6 + strlen(certfile) + 1, gc); /* 6 bytes for "file:/" */
+    struct buffer keyuri = alloc_buf_gc(6 + strlen(keyfile) + 1, gc);   /* 6 bytes for "file:/" */
+
+    /* Windows temp file path starts with drive letter -- add a leading slash for URI */
+    const char *lead = "";
+#ifdef _WIN32
+    lead = "/";
+#endif /* _WIN32 */
+    assert_true(buf_printf(&certuri, "file:%s%s", lead, certfile));
+    assert_true(buf_printf(&keyuri, "file:%s%s", lead, keyfile));
+
+    /* On Windows replace any '\' in path by '/' required for URI */
+#ifdef _WIN32
+    string_mod(BSTR(&certuri), CC_ANY, CC_BACKSLASH, '/');
+    string_mod(BSTR(&keyuri), CC_ANY, CC_BACKSLASH, '/');
+#endif /* _WIN32 */
+
+    tls_ctx_client_new(&ctx);
+    tls_ctx_load_cert_file(&ctx, BSTR(&certuri), false);
+    assert_int_equal(tls_ctx_load_priv_file(&ctx, BSTR(&keyuri), false), 0);
+    tls_ctx_free(&ctx);
+#endif /* HAVE_OPENSSL_STORE */
+}
+
 static void
 init_implicit_iv(struct crypto_options *co)
 {
@@ -469,6 +512,7 @@
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(crypto_pem_encode_certificate),
         cmocka_unit_test(test_load_certificate_and_key),
+        cmocka_unit_test(test_load_certificate_and_key_uri),
         cmocka_unit_test(test_data_channel_roundtrip_aes_128_gcm),
         cmocka_unit_test(test_data_channel_roundtrip_aes_192_gcm),
         cmocka_unit_test(test_data_channel_roundtrip_aes_256_gcm),

