From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 10 Oct 2018 08:51:46 +0200
Message-ID: <1539154306-27462-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove example unit tests
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

We have plenty real unit test that can be used as examples, so the
example tests are no longer needed. Let's get rid of them.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 tests/unit_tests/Makefile.am              |  2 +-
 tests/unit_tests/example_test/Makefile.am | 13 --------
 tests/unit_tests/example_test/README.md   |  3 --
 tests/unit_tests/example_test/test.c      | 52 -------------------------------
 tests/unit_tests/example_test/test2.c     | 23 --------------
 5 files changed, 1 insertion(+), 92 deletions(-)
 delete mode 100644 tests/unit_tests/example_test/Makefile.am
 delete mode 100644 tests/unit_tests/example_test/README.md
 delete mode 100644 tests/unit_tests/example_test/test.c
 delete mode 100644 tests/unit_tests/example_test/test2.c

diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index 31d37b8..cb3d63a 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -1,5 +1,5 @@
 AUTOMAKE_OPTIONS = foreign
 
 if CMOCKA_INITIALIZED
-SUBDIRS = example_test openvpn plugins
+SUBDIRS = openvpn plugins
 endif
diff --git a/tests/unit_tests/example_test/Makefile.am b/tests/unit_tests/example_test/Makefile.am
deleted file mode 100644
index 04a5ad3..0000000
--- a/tests/unit_tests/example_test/Makefile.am
+++ /dev/null
@@ -1,13 +0,0 @@
-AUTOMAKE_OPTIONS = foreign
-
-check_PROGRAMS = example_testdriver example2_testdriver
-
-TESTS = $(check_PROGRAMS)
-
-example_testdriver_CFLAGS  = @TEST_CFLAGS@
-example_testdriver_LDFLAGS = @TEST_LDFLAGS@
-example_testdriver_SOURCES = test.c
-
-example2_testdriver_CFLAGS  = @TEST_CFLAGS@
-example2_testdriver_LDFLAGS = @TEST_LDFLAGS@
-example2_testdriver_SOURCES = test2.c
diff --git a/tests/unit_tests/example_test/README.md b/tests/unit_tests/example_test/README.md
deleted file mode 100644
index cb75d68..0000000
--- a/tests/unit_tests/example_test/README.md
+++ /dev/null
@@ -1,3 +0,0 @@
-This test only checks that test compilation works. This example contains two test executables.
-
-These tests can be used as template for 'real' tests.
diff --git a/tests/unit_tests/example_test/test.c b/tests/unit_tests/example_test/test.c
deleted file mode 100644
index d48e5f5..0000000
--- a/tests/unit_tests/example_test/test.c
+++ /dev/null
@@ -1,52 +0,0 @@
-#include <stdio.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <string.h>
-#include <setjmp.h>
-#include <cmocka.h>
-
-static int
-setup(void **state) {
-    int *answer  = malloc(sizeof(int));
-
-    *answer = 42;
-    *state = answer;
-
-    return 0;
-}
-
-static int
-teardown(void **state) {
-    free(*state);
-
-    return 0;
-}
-
-static void
-null_test_success(void **state) {
-    (void) state;
-}
-
-static void
-int_test_success(void **state) {
-    int *answer = *state;
-    assert_int_equal(*answer, 42);
-}
-
-static void
-failing_test(void **state) {
-    /* This tests fails to test that make check fails */
-    assert_int_equal(0, 42);
-}
-
-int
-main(void) {
-    const struct CMUnitTest tests[] = {
-        cmocka_unit_test(null_test_success),
-        cmocka_unit_test_setup_teardown(int_test_success, setup, teardown),
-/*        cmocka_unit_test(failing_test), */
-    };
-
-    return cmocka_run_group_tests_name("success_test", tests, NULL, NULL);
-}
diff --git a/tests/unit_tests/example_test/test2.c b/tests/unit_tests/example_test/test2.c
deleted file mode 100644
index b5d4fa6..0000000
--- a/tests/unit_tests/example_test/test2.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include <stdio.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <string.h>
-#include <setjmp.h>
-#include <cmocka.h>
-
-
-static void
-test_true(void **state) {
-    (void) state;
-}
-
-
-int
-main(void) {
-    const struct CMUnitTest tests[] = {
-        cmocka_unit_test(test_true),
-    };
-
-    return cmocka_run_group_tests_name("success_test2", tests, NULL, NULL);
-}
-- 
2.7.4


