From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Wed, 8 Dec 2021 14:46:55 +0100
Message-ID: <20211208134655.28905-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Don't use BF-CBC in unit tests if we don't
 have it
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

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 tests/unit_tests/openvpn/test_ncp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 6702133a..f4c28ffd 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -120,8 +120,11 @@ test_check_ncp_ciphers_list(void **state)
     assert_string_equal(mutate_ncp_cipher_list("id-aes128-GCM:id-aes256-GCM",
                                                &gc), "AES-128-GCM:AES-256-GCM");
 #else
-    assert_string_equal(mutate_ncp_cipher_list("BLOWFISH-CBC",
-                                               &gc), "BF-CBC");
+    if (have_blowfish)
+    {
+        assert_string_equal(mutate_ncp_cipher_list("BLOWFISH-CBC",
+                                                   &gc), "BF-CBC");
+    }
 #endif
     gc_free(&gc);
 }
-- 
2.11.0


