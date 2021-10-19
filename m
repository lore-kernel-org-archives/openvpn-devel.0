From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:23:20 +0200
Message-Id: <20211019182332.613155-16-arne@...1227...>
In-Reply-To: <20211019182332.613155-1-arne@...1227...>
References: <20211019182332.613155-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 12/16] [OSSL 3.0] Remove dependency on
 BF-CBC existance from test_ncp
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

The test_check_ncp_ciphers_list test assumed that BF-CBC is always
available, which is no longer the case with OpenSSL 3.0. Rewrite the
test to not rely on BF-CBC to be available.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/openvpn/test_ncp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 613b5f1ba..a77afde17 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -41,6 +41,7 @@
 /* Defines for use in the tests and the mock parse_line() */
 
 const char *bf_chacha = "BF-CBC:CHACHA20-POLY1305";
+const char *aes_chacha = "AES-128-CBC:CHACHA20-POLY1305";
 const char *aes_ciphers = "AES-256-GCM:AES-128-GCM";
 
 
@@ -59,6 +60,7 @@ test_check_ncp_ciphers_list(void **state)
 {
     struct gc_arena gc = gc_new();
     bool have_chacha = cipher_kt_get("CHACHA20-POLY1305");
+    bool have_blowfish= cipher_kt_get("BF-CBC");
 
     assert_string_equal(mutate_ncp_cipher_list("none", &gc), "none");
     assert_string_equal(mutate_ncp_cipher_list("AES-256-GCM:none", &gc),
@@ -66,7 +68,12 @@ test_check_ncp_ciphers_list(void **state)
 
     assert_string_equal(mutate_ncp_cipher_list(aes_ciphers, &gc), aes_ciphers);
 
-    if (have_chacha)
+    if(have_chacha)
+    {
+        assert_string_equal(mutate_ncp_cipher_list(aes_chacha, &gc), aes_chacha);
+    }
+
+    if (have_chacha && have_blowfish)
     {
         assert_string_equal(mutate_ncp_cipher_list(bf_chacha, &gc), bf_chacha);
         assert_string_equal(mutate_ncp_cipher_list("BF-CBC:CHACHA20-POLY1305", &gc),
@@ -82,8 +89,8 @@ test_check_ncp_ciphers_list(void **state)
     bool have_chacha_mixed_case = cipher_kt_get("ChaCha20-Poly1305");
     if (have_chacha_mixed_case)
     {
-        assert_string_equal(mutate_ncp_cipher_list("BF-CBC:ChaCha20-Poly1305", &gc),
-                            bf_chacha);
+        assert_string_equal(mutate_ncp_cipher_list("AES-128-CBC:ChaCha20-Poly1305", &gc),
+                            aes_chacha);
     }
 
     assert_ptr_equal(mutate_ncp_cipher_list("vollbit", &gc), NULL);
-- 
2.33.0


