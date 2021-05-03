From: Arne Schwabe <arne@...1227...>
Date: Mon,  3 May 2021 13:40:43 +0200
Message-Id: <20210503114043.3909319-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix memory leak in misc unit test
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

Detected-by: clang -fsanitize=address
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/openvpn/test_misc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 15f6cbff6..c3bea8fc8 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -70,6 +70,7 @@ test_compat_lzo_string(void **state)
     /* 999 -> 1000, 3 to 4 chars */
     assert_string_equal(output, "V4,dev-type tun,link-mtu 1000,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server,comp-lzo");
 
+    gc_free(&gc);
 };
 
 const struct CMUnitTest misc_tests[] = {
-- 
2.31.1


