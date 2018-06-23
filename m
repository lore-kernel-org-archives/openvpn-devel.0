From: Gert Doering <gert@...1296...>
Date: Sat, 23 Jun 2018 20:15:30 +0200
Message-Id: <20180623181530.19484-1-gert@...1296...>
In-Reply-To: <20180623173104.GT57262@...1296...>
References: <20180623173104.GT57262@...1296...>
Subject: [Openvpn-devel] [PATCH v2] Add %d,
 %u and %lu tests to test_argv unit tests.
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

Some basic integer tests to verify signed, unsigned and
long unsigned (2^33) printing.

Signed-off-by: Gert Doering <gert@...1296...>
--
v2: test %lu with "1" as windows and linux/i386 do not have 64 bit long
---
 tests/unit_tests/openvpn/test_argv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 4a3ba559..202a8ff5 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -116,8 +116,12 @@ argv_str__multiple_argv__correct_output(void **state)
     argv_printf(&a, "%s%sc", PATH1, PATH2);
     argv_printf_cat(&a, "%s", PARAM1);
     argv_printf_cat(&a, "%s", PARAM2);
+    argv_printf_cat(&a, "%d", -1);
+    argv_printf_cat(&a, "%u", -1);
+    argv_printf_cat(&a, "%lu", 1 );
     output = argv_str(&a, &gc, PA_BRACKET);
-    assert_string_equal(output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2 "]");
+    assert_string_equal(output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2 "]"
+				" [-1] [4294967295] [1]");
 
     argv_reset(&a);
     gc_free(&gc);
-- 
2.16.4


