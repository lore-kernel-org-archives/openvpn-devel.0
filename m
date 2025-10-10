From: Gert Doering <gert@...1296...>
Date: Fri, 10 Oct 2025 23:11:47 +0200
Message-ID: <20251010211154.2780-1-gert@...1296...>
In-Reply-To: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
References: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v13] test_user_pass: Check fatal errors for
 empty username/password
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

From: Frank Lichtenheld <frank@...2641...>

Required a fix to mock_msg to make tests of M_FATAL
possible at all.
This also tests some cases which arguably should throw
a fatal error but do not.

v2:
 - Suppress LeakSanitizer errors for fatal error tests.
   Due to aborting the function, the memory will not be
   cleaned up, but that is expected.
v3:
 - Disable assert tests with MSVC. Does not seem to catch
   the error correctly.
 - Rebase on top of parallel-tests series to get
   AM_TESTS_ENVIRONMENT.
v8:
 - Update srcdir handling according to master.
v10:
 - Update mock_msg.c fatal handling to be compatible
   with NO_CMOCKA.

Change-Id: Icabc8acf75638c86c8c395e9ffecba7a7226cd97
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/474
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/474
This mail reflects revision 13 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9511bda..9e0b46e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -729,7 +729,7 @@
             add_test(${test_name} ${test_name})
             # for compat with autotools make check
             set_tests_properties(${test_name} PROPERTIES
-                ENVIRONMENT "srcdir=${_UT_SOURCE_DIR}")
+                ENVIRONMENT "srcdir=${_UT_SOURCE_DIR};LSAN_OPTIONS=suppressions=${_UT_SOURCE_DIR}/input/leak_suppr.txt")
         endif ()
         add_executable(${test_name}
             tests/unit_tests/openvpn/${test_name}.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 05c0ea5..50f4a11 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -4,6 +4,8 @@
 
 AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) Unit-Tests'
 
+AM_TESTS_ENVIRONMENT = export LSAN_OPTIONS=suppressions=$(srcdir)/input/leak_suppr.txt;
+
 test_binaries = argv_testdriver buffer_testdriver crypto_testdriver packet_id_testdriver auth_token_testdriver \
 	ncp_testdriver misc_testdriver options_parse_testdriver pkt_testdriver ssl_testdriver \
 	user_pass_testdriver push_update_msg_testdriver provider_testdriver socket_testdriver
diff --git a/tests/unit_tests/openvpn/input/appears_empty.txt b/tests/unit_tests/openvpn/input/appears_empty.txt
new file mode 100644
index 0000000..ffb749a
--- /dev/null
+++ b/tests/unit_tests/openvpn/input/appears_empty.txt
@@ -0,0 +1,3 @@
+	
+	
+(contains \t\n\t\n)
diff --git a/tests/unit_tests/openvpn/input/empty.txt b/tests/unit_tests/openvpn/input/empty.txt
new file mode 100644
index 0000000..e69de29
--- /dev/null
+++ b/tests/unit_tests/openvpn/input/empty.txt
diff --git a/tests/unit_tests/openvpn/input/leak_suppr.txt b/tests/unit_tests/openvpn/input/leak_suppr.txt
new file mode 100644
index 0000000..72ebfe0
--- /dev/null
+++ b/tests/unit_tests/openvpn/input/leak_suppr.txt
@@ -0,0 +1 @@
+leak:_assertions$
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index a2aa3f9..2cd1336 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -41,7 +41,6 @@
 msglvl_t x_debug_level = 0; /* Default to (almost) no debugging output */
 msglvl_t print_x_debug_level = 0;
 
-bool fatal_error_triggered = false;
 
 char mock_msg_buf[MOCK_MSG_BUF];
 
@@ -75,7 +74,6 @@
 {
     if (flags & M_FATAL)
     {
-        fatal_error_triggered = true;
         printf("FATAL ERROR:");
     }
     CLEAR(mock_msg_buf);
@@ -86,6 +84,12 @@
         printf("%s", mock_msg_buf);
         printf("\n");
     }
+#ifndef NO_CMOCKA
+    if (flags & M_FATAL)
+    {
+        mock_assert(false, "FATAL ERROR", __FILE__, __LINE__);
+    }
+#endif
 }
 
 void
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index 32ec59f..f5dddd6 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -180,6 +180,16 @@
 
     reset_user_pass(&up);
 
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    /*FIXME: silently removes control characters but does not error out */
+    assert_true(get_user_pass_cr(&up, "\t\n\t", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "");
+    assert_string_equal(up.password, "");
+
+    reset_user_pass(&up);
+
     expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT Password:");
     will_return(query_user_exec_builtin, "cpassword");
     will_return(query_user_exec_builtin, true);
@@ -212,6 +222,25 @@
     assert_string_equal(up.password, "cpassword");
 }
 
+/* NOTE: expect_assert_failure does not seem to work with MSVC */
+#ifndef _MSC_VER
+/* NOTE: leaks gc memory */
+static void
+test_get_user_pass_inline_creds_assertions(void **state)
+{
+    struct user_pass up = { 0 };
+    reset_user_pass(&up);
+    unsigned int flags = GET_USER_PASS_INLINE_CREDS;
+
+    reset_user_pass(&up);
+
+    /*FIXME: query_user_exec() called even though nothing queued */
+    /*FIXME? username error thrown very late in stdin handling */
+    will_return(query_user_exec_builtin, true);
+    expect_assert_failure(get_user_pass_cr(&up, "\nipassword\n", "UT", flags, NULL));
+}
+#endif
+
 static void
 test_get_user_pass_authfile_stdin(void **state)
 {
@@ -239,8 +268,39 @@
     assert_true(up.defined);
     assert_string_equal(up.username, "user");
     assert_string_equal(up.password, "cpassword");
+
+    reset_user_pass(&up);
+
+    flags |= GET_USER_PASS_PASSWORD_ONLY;
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT Password:");
+    will_return(query_user_exec_builtin, "");
+    will_return(query_user_exec_builtin, true);
+    /*FIXME? does not error out on empty password */
+    assert_true(get_user_pass_cr(&up, "stdin", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "user");
+    assert_string_equal(up.password, "");
 }
 
+/* NOTE: expect_assert_failure does not seem to work with MSVC */
+#ifndef _MSC_VER
+/* NOTE: leaks gc memory */
+static void
+test_get_user_pass_authfile_stdin_assertions(void **state)
+{
+    struct user_pass up = { 0 };
+    reset_user_pass(&up);
+    unsigned int flags = 0;
+
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT Username:");
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT Password:");
+    will_return(query_user_exec_builtin, "");
+    will_return(query_user_exec_builtin, "cpassword");
+    will_return(query_user_exec_builtin, true);
+    expect_assert_failure(get_user_pass_cr(&up, "stdin", "UT", flags, NULL));
+}
+#endif
+
 static void
 test_get_user_pass_authfile_file(void **state)
 {
@@ -260,6 +320,17 @@
 
     reset_user_pass(&up);
 
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/appears_empty.txt");
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    /*FIXME? does not error out */
+    assert_true(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "");
+    assert_string_equal(up.password, "");
+
+    reset_user_pass(&up);
+
     openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/user_only.txt");
     expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT Password:");
     will_return(query_user_exec_builtin, "cpassword");
@@ -361,6 +432,29 @@
 }
 #endif /* ENABLE_MANAGEMENT */
 
+/* NOTE: expect_assert_failure does not seem to work with MSVC */
+#ifndef _MSC_VER
+/* NOTE: leaks gc memory */
+static void
+test_get_user_pass_authfile_file_assertions(void **state)
+{
+    struct user_pass up = { 0 };
+    reset_user_pass(&up);
+    unsigned int flags = 0;
+
+    char authfile[PATH_MAX] = { 0 };
+
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/empty.txt");
+    expect_assert_failure(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
+
+    reset_user_pass(&up);
+
+    flags |= GET_USER_PASS_PASSWORD_ONLY;
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/empty.txt");
+    expect_assert_failure(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
+}
+#endif /* ifndef _MSC_VER */
+
 const struct CMUnitTest user_pass_tests[] = {
     cmocka_unit_test(test_get_user_pass_defined),
     cmocka_unit_test(test_get_user_pass_needok),
@@ -371,6 +465,11 @@
     cmocka_unit_test(test_get_user_pass_dynamic_challenge),
     cmocka_unit_test(test_get_user_pass_static_challenge),
 #endif /* ENABLE_MANAGEMENT */
+#ifndef _MSC_VER
+    cmocka_unit_test(test_get_user_pass_inline_creds_assertions),
+    cmocka_unit_test(test_get_user_pass_authfile_stdin_assertions),
+    cmocka_unit_test(test_get_user_pass_authfile_file_assertions),
+#endif
 };
 
 int

