From: Arne Schwabe <arne@...1227...>
Date: Thu, 12 May 2022 14:14:29 +0200
Message-Id: <20220512121429.2096164-8-arne@...1227...>
In-Reply-To: <20220512121429.2096164-1-arne@...1227...>
References: <20220512121429.2096164-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/7] Remove dependency on BF-CBC existance
 from test_ncp
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
Cc: Max Fillinger <maximilian.fillinger@...2507...>, Gert Doering <gert@...1296...>

The test_check_ncp_ciphers_list test assumed that BF-CBC is always
available, which is no longer the case with OpenSSL 3.0. Rewrite the
test to not rely on BF-CBC to be available.

Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
Message-Id: <20211019183127.614175-14-arne@...1227...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23003.html
Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/unit_tests/openvpn/test_ncp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index e38a5738e..d4164ef7a 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -42,6 +42,7 @@
 /* Defines for use in the tests and the mock parse_line() */
 
 const char *bf_chacha = "BF-CBC:CHACHA20-POLY1305";
+const char *aes_chacha = "AES-128-CBC:CHACHA20-POLY1305";
 const char *aes_ciphers = "AES-256-GCM:AES-128-GCM";
 
 static void
@@ -57,6 +58,11 @@ test_check_ncp_ciphers_list(void **state)
 
     assert_string_equal(mutate_ncp_cipher_list(aes_ciphers, &gc), aes_ciphers);
 
+    if (have_chacha && have_blowfish)
+    {
+        assert_string_equal(mutate_ncp_cipher_list(aes_chacha, &gc), aes_chacha);
+    }
+
     if (have_chacha && have_blowfish)
     {
         assert_string_equal(mutate_ncp_cipher_list(bf_chacha, &gc), bf_chacha);
@@ -73,8 +79,8 @@ test_check_ncp_ciphers_list(void **state)
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
2.32.0 (Apple Git-132)


