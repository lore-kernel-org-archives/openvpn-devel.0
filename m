From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Wed, 8 Dec 2021 15:41:01 +0100
Message-ID: <20211208144101.19166-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2.5] Define have_blowfish variable in ncp
 unit tests
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

The previous commit was backported from master and needs this variable
to exist.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 tests/unit_tests/openvpn/test_ncp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 8da76c03..bcafd232 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -49,6 +49,7 @@ test_check_ncp_ciphers_list(void **state)
 {
     struct gc_arena gc = gc_new();
     bool have_chacha = cipher_kt_get("CHACHA20-POLY1305");
+    bool have_blowfish = cipher_kt_get("BF-CBC");
 
     assert_string_equal(mutate_ncp_cipher_list("none", &gc), "none");
     assert_string_equal(mutate_ncp_cipher_list("AES-256-GCM:none", &gc),
@@ -56,7 +57,7 @@ test_check_ncp_ciphers_list(void **state)
 
     assert_string_equal(mutate_ncp_cipher_list(aes_ciphers, &gc), aes_ciphers);
 
-    if (have_chacha)
+    if (have_chacha && have_blowfish)
     {
         assert_string_equal(mutate_ncp_cipher_list(bf_chacha, &gc), bf_chacha);
         assert_string_equal(mutate_ncp_cipher_list("BF-CBC:CHACHA20-POLY1305", &gc),
-- 
2.11.0


