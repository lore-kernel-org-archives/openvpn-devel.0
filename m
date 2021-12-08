From: Arne Schwabe <arne@...1227...>
Date: Wed,  8 Dec 2021 18:06:14 +0100
Message-Id: <20211208170614.3404821-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add argv_insert_head__empty_argv__head_only
 to argv tests
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

The unit test argv_insert_head__empty_argv__head_only was defined
but never used. Add it to the array of unit tests.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/openvpn/test_argv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index e686adcb5..1b18ac0d4 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -266,6 +266,7 @@ main(void)
         cmocka_unit_test(argv_str__empty_argv__empty_output),
         cmocka_unit_test(argv_str__multiple_argv__correct_output),
         cmocka_unit_test(argv_insert_head__non_empty_argv__head_added),
+        cmocka_unit_test(argv_insert_head__empty_argv__head_only),
     };
 
     return cmocka_run_group_tests_name("argv", tests, NULL, NULL);
-- 
2.33.0


