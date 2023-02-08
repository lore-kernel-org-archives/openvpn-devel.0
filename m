From: Arne Schwabe <arne@...1227...>
Date: Wed,  8 Feb 2023 01:18:18 +0100
Message-Id: <20230208001819.244694-5-arne@...1227...>
In-Reply-To: <20230208001819.244694-1-arne@...1227...>
References: <20230208001819.244694-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/5] Add missing stdint.h includes in unit
 tests files
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

My mingw compiler/headers (mingw-w64 10.0.0 on macOS) seem to be more
pendantic than the one that comes with Ubuntu 22.04 (github actions) or
any of the other platforms including msvc/normal windows header.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/example_test/test.c  | 1 +
 tests/unit_tests/example_test/test2.c | 1 +
 tests/unit_tests/openvpn/mock_msg.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/unit_tests/example_test/test.c b/tests/unit_tests/example_test/test.c
index ea31b884d..c174025cc 100644
--- a/tests/unit_tests/example_test/test.c
+++ b/tests/unit_tests/example_test/test.c
@@ -4,6 +4,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include <setjmp.h>
+#include <stdint.h>
 #include <cmocka.h>
 
 static int
diff --git a/tests/unit_tests/example_test/test2.c b/tests/unit_tests/example_test/test2.c
index 5a186d5d7..bb54633c8 100644
--- a/tests/unit_tests/example_test/test2.c
+++ b/tests/unit_tests/example_test/test2.c
@@ -4,6 +4,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include <setjmp.h>
+#include <stdint.h>
 #include <cmocka.h>
 
 
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index 3ede98c00..3fa9a166f 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -32,6 +32,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <setjmp.h>
+#include <stdint.h>
 #include <cmocka.h>
 
 
-- 
2.37.1 (Apple Git-137.1)


