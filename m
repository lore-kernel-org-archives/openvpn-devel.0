From: Arne Schwabe <arne@...1227...>
Date: Fri,  5 Jun 2020 13:25:19 +0200
Message-Id: <20200605112519.22714-3-arne@...1227...>
In-Reply-To: <20200605112519.22714-1-arne@...1227...>
References: <20200605112519.22714-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/3] Add unit test for cipher name
 translations
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

The unit test duplicates some part of the test for
the ncp-cipher list but that is not a bad thing.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/openvpn/test_crypto.c | 68 ++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index fdf814de..ea9b99b2 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -69,11 +69,79 @@ crypto_pem_encode_decode_loopback(void **state)
     gc_free(&gc);
 }
 
+static void
+test_translate_cipher(const char *ciphername, const char *openvpn_name)
+{
+    const cipher_kt_t *cipher = cipher_kt_get(ciphername);
+
+    /* Empty cipher is fine */
+    if (!cipher)
+    {
+        return;
+    }
+
+    const char *kt_name = cipher_kt_name(cipher);
+
+    assert_string_equal(kt_name, openvpn_name);
+}
+
+static void
+test_cipher_names(const char *ciphername, const char *openvpn_name)
+{
+    struct gc_arena gc = gc_new();
+    /* Go through some variants, if the cipher library accepts these, they
+     * should be normalised to the openvpn name */
+    char *upper = string_alloc(ciphername, &gc);
+    char *lower = string_alloc(ciphername, &gc);
+    char *random_case = string_alloc(ciphername, &gc);
+
+    for (int i = 0; i < strlen(ciphername); i++)
+    {
+        upper[i] = toupper(ciphername[i]);
+        lower[i] = tolower(ciphername[i]);
+        if (rand() & 0x1)
+        {
+            random_case[i] = upper[i];
+        }
+        else
+        {
+            random_case[i] = lower[i];
+        }
+    }
+
+    if (!openvpn_name)
+    {
+        openvpn_name = upper;
+    }
+
+    test_translate_cipher(upper, openvpn_name);
+    test_translate_cipher(lower, openvpn_name);
+    test_translate_cipher(random_case, openvpn_name);
+    test_translate_cipher(ciphername, openvpn_name);
+
+
+    gc_free(&gc);
+}
+
+static void
+crypto_translate_cipher_names(void **state)
+{
+    /* Test that a number of ciphers to see that they turn out correctly */
+    test_cipher_names("BF-CBC", NULL);
+    test_cipher_names("BLOWFISH-CBC", "BF-CBC");
+    test_cipher_names("Chacha20-Poly1305", NULL);
+    test_cipher_names("AES-128-GCM", NULL);
+    test_cipher_names("AES-128-CBC", NULL);
+    test_cipher_names("CAMELLIA-128-CFB128", "CAMELLIA-128-CFB");
+    test_cipher_names("id-aes256-GCM", "AES-256-GCM");
+}
+
 int
 main(void)
 {
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(crypto_pem_encode_decode_loopback),
+        cmocka_unit_test(crypto_translate_cipher_names),
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
-- 
2.26.0


