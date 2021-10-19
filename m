From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:23:23 +0200
Message-Id: <20211019182332.613155-19-arne@...1227...>
In-Reply-To: <20211019182332.613155-1-arne@...1227...>
References: <20211019182332.613155-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 14/16] Add small unit test for testing
 HMAC
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

This just adds a very simple unit test to check that the HMAC
implementation produces a well known hash.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/openvpn/test_crypto.c | 61 +++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 32063fc46..66f53a020 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -141,6 +141,11 @@ static uint8_t good_prf[32] = {0xd9, 0x8c, 0x85, 0x18, 0xc8, 0x5e, 0x94, 0x69,
                                0x27, 0x91, 0x6a, 0xcf, 0xc2, 0xd5, 0x92, 0xfb,
                                0xb1, 0x56, 0x7e, 0x4b, 0x4b, 0x14, 0x59, 0xe6,
                                0xa9, 0x04, 0xac, 0x2d, 0xda, 0xb7, 0x2d, 0x67};
+
+static const char* ipsumlorem = "Lorem ipsum dolor sit amet, consectetur "
+                                "adipisici elit, sed eiusmod tempor incidunt "
+                                "ut labore et dolore magna aliqua.";
+
 static void
 crypto_test_tls_prf(void **state)
 {
@@ -150,12 +155,6 @@ crypto_test_tls_prf(void **state)
     const size_t seed_len = strlen(seedstr);
 
 
-
-
-    const char* ipsumlorem = "Lorem ipsum dolor sit amet, consectetur "
-                             "adipisici elit, sed eiusmod tempor incidunt ut "
-                             "labore et dolore magna aliqua.";
-
     const unsigned char *secret = (const unsigned char *) ipsumlorem;
     size_t secret_len = strlen((const char *)secret);
 
@@ -166,13 +165,61 @@ crypto_test_tls_prf(void **state)
     assert_memory_equal(good_prf, out, sizeof(out));
 }
 
+static uint8_t testkey[20] = {0x0b, 0x00};
+static uint8_t goodhash[20] = {0x58, 0xea, 0x5a, 0xf0, 0x42, 0x94, 0xe9, 0x17,
+                               0xed, 0x84, 0xb9, 0xf0, 0x83, 0x30, 0x23, 0xae,
+                               0x8b, 0xa7, 0x7e, 0xb8};
+
+static void
+crypto_test_hmac(void **state)
+{
+    hmac_ctx_t *hmac = hmac_ctx_new();
+    const md_kt_t *sha1 = md_kt_get("SHA1");
+
+    assert_int_equal(md_kt_size(sha1), 20);
+
+    uint8_t key[20];
+    memcpy(key, testkey, sizeof(key));
+
+    hmac_ctx_init(hmac, key, 20, sha1);
+    hmac_ctx_update(hmac, (const uint8_t *)ipsumlorem, (int) strlen(ipsumlorem));
+    hmac_ctx_update(hmac, (const uint8_t *)ipsumlorem, (int) strlen(ipsumlorem));
+
+    uint8_t hash[20];
+    hmac_ctx_final(hmac, hash);
+
+    assert_memory_equal(hash, goodhash, sizeof(hash));
+    memset(hash, 0x00, sizeof(hash));
+
+    /* try again */
+    hmac_ctx_reset(hmac);
+    hmac_ctx_update(hmac, (const uint8_t *)ipsumlorem, (int) strlen(ipsumlorem));
+    hmac_ctx_update(hmac, (const uint8_t *)ipsumlorem, (int) strlen(ipsumlorem));
+    hmac_ctx_final(hmac, hash);
+
+    assert_memory_equal(hash, goodhash, sizeof(hash));
+
+    /* Fill our key with random data to ensure it is not used by hmac anymore */
+    memset(key, 0x55, sizeof(key));
+
+    hmac_ctx_reset(hmac);
+    hmac_ctx_update(hmac, (const uint8_t *)ipsumlorem, (int) strlen(ipsumlorem));
+    hmac_ctx_update(hmac, (const uint8_t *)ipsumlorem, (int) strlen(ipsumlorem));
+    hmac_ctx_final(hmac, hash);
+
+    assert_memory_equal(hash, goodhash, sizeof(hash));
+    hmac_ctx_cleanup(hmac);
+    hmac_ctx_free(hmac);
+}
+
 int
 main(void)
 {
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(crypto_pem_encode_decode_loopback),
         cmocka_unit_test(crypto_translate_cipher_names),
-        cmocka_unit_test(crypto_test_tls_prf)
+        cmocka_unit_test(crypto_test_tls_prf),
+        cmocka_unit_test(crypto_test_hmac)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
-- 
2.33.0


