From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  1 Feb 2024 15:48:17 +0100
Message-Id: <20240201144817.188884-1-frank@...2641...>
In-Reply-To: <gerrit.1706531144000.Ide72b81f497088dd0fd2cdcfff83cbce5b48f145@...2715...>
References: <gerrit.1706531144000.Ide72b81f497088dd0fd2cdcfff83cbce5b48f145@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] [CMake] Allow unit tests to fall back to
 hard coded location
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

From: Arne Schwabe <arne@...1227...>

Settings the environment variable required for running unit tests is
tiresome in my IDE (Clion). So allow unit tests to fall back to a hard
coded location in case the environment variable is not set.

Change-Id: Ide72b81f497088dd0fd2cdcfff83cbce5b48f145
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/509
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index be55c60..fdd2b01 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -682,6 +682,10 @@
 
         target_include_directories(${test_name} PRIVATE src/openvpn)
 
+        # for compat with IDEs like Clion that ignore the tests properties
+        # for the environment variable srcdir when running tests as fallback
+        target_compile_definitions(${test_name} PRIVATE "-DUNIT_TEST_SOURCEDIR=\"${CMAKE_SOURCE_DIR}/tests/unit_tests/openvpn\"")
+
         if (NOT ${test_name} STREQUAL "test_buffer")
             target_sources(${test_name} PRIVATE
                 src/openvpn/buffer.c
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h
index 50e16d6..f219e93 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -32,9 +32,36 @@
  * This has a openvpn prefix to avoid confusion with cmocka's unit_test_setup_*
  * methods
  */
-void
+static inline void
 openvpn_unit_test_setup()
 {
     assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);
     assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);
 }
+
+/**
+ * Helper function to get a file path from the unit test directory to open it
+ * or pass its path to another function. This function will first look for
+ * an environment variable or if failing that, will fall back to a hardcoded
+ * value from compile time if compiled with CMake.
+ *
+ * @param buf           buffer holding the path to the file
+ * @param bufsize       size of buf
+ * @param filename      name of the filename to retrieve relative to the
+ *                      unit test source directory
+ */
+void
+openvpn_test_get_srcdir_dir(char *buf, size_t bufsize, const char *filename)
+{
+    const char *srcdir = getenv("srcdir");
+
+#if defined(UNIT_TEST_SOURCEDIR)
+    if (!srcdir)
+    {
+        srcdir = UNIT_TEST_SOURCEDIR;
+    }
+#endif
+    assert_non_null(srcdir);
+
+    snprintf(buf, bufsize, "%s/%s", srcdir, filename);
+}
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index ab4dfe4..fee5891 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -35,6 +35,7 @@
 #include <string.h>
 #include <setjmp.h>
 #include <cmocka.h>
+#include "test_common.h"
 
 #include "misc.c"
 
@@ -209,11 +210,9 @@
     reset_user_pass(&up);
     unsigned int flags = 0;
 
-    const char *srcdir = getenv("srcdir");
-    assert_non_null(srcdir);
     char authfile[PATH_MAX] = { 0 };
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/user_pass.txt" );
 
-    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/user_pass.txt");
     /*FIXME: query_user_exec() called even though nothing queued */
     will_return(query_user_exec_builtin, true);
     assert_true(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
@@ -223,7 +222,7 @@
 
     reset_user_pass(&up);
 
-    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/user_only.txt");
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/user_only.txt");
     expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT Password:");
     will_return(query_user_exec_builtin, "cpassword");
     will_return(query_user_exec_builtin, true);
@@ -236,7 +235,7 @@
     reset_user_pass(&up);
 
     flags |= GET_USER_PASS_PASSWORD_ONLY;
-    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/user_only.txt");
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/user_only.txt");
     /*FIXME: query_user_exec() called even though nothing queued */
     will_return(query_user_exec_builtin, true);
     assert_true(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
@@ -256,5 +255,6 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     return cmocka_run_group_tests(user_pass_tests, NULL, NULL);
 }

