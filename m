From: Arne Schwabe <arne@...1227...>
Date: Thu, 22 Apr 2021 17:29:34 +0200
Message-Id: <20210422152939.2134046-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/6] Avoid failing_test unused warning in
 example_test
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

This warnings makes make check fail if Werror is exmaple on
LLVM/Clang on macOS for me.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/example_test/test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/unit_tests/example_test/test.c b/tests/unit_tests/example_test/test.c
index bc3fdc17c..ea31b884d 100644
--- a/tests/unit_tests/example_test/test.c
+++ b/tests/unit_tests/example_test/test.c
@@ -38,6 +38,7 @@ int_test_success(void **state)
     assert_int_equal(*answer, 42);
 }
 
+__attribute__((unused))
 static void
 failing_test(void **state)
 {
-- 
2.31.1


