From: Gert Doering <gert@...1296...>
Date: Thu, 18 Dec 2025 11:40:32 +0100
Message-ID: <20251218104042.5961-1-gert@...1296...>
In-Reply-To: <gerrit.1765989193000.Ifb6594700db71d219643a29c581099c778bcbbc6@...2715...>
References: <gerrit.1765989193000.Ifb6594700db71d219643a29c581099c778bcbbc6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] tests/unit_tests: Port to cmocka 2.0.0
 API
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

But add compat layer so that we can still build
against older versions of cmocka. Mostly this is
trivial but the custom check function changed its
prototype, so that requires some more work.

Change-Id: Ifb6594700db71d219643a29c581099c778bcbbc6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1449
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1449
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index bdb1904..fc5eaf1 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -379,6 +379,18 @@
     )
 set(HAVE_CONFIG_VERSION_H YES)
 
+if (BUILD_TESTING)
+    find_package(cmocka CONFIG)
+    if (TARGET cmocka::cmocka)
+        set(CMOCKA_LIBRARIES cmocka::cmocka)
+    else ()
+        pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
+        set(CMOCKA_LIBRARIES PkgConfig::cmocka)
+    endif ()
+    set(CMAKE_REQUIRED_LIBRARIES ${CMOCKA_LIBRARIES}) 
+    check_include_files(cmocka_version.h HAVE_CMOCKA_VERSION_H)
+endif ()
+
 configure_file(config.h.cmake.in config.h)
 configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)
 # TODO we should remove the need for this, and always include config.h
@@ -636,14 +648,6 @@
 option(UT_ALLOW_BIG_ALLOC "Allow unit-tests to use > 1 GB of memory" ON)
 
 if (BUILD_TESTING)
-    find_package(cmocka CONFIG)
-    if (TARGET cmocka::cmocka)
-        set(CMOCKA_LIBRARIES cmocka::cmocka)
-    else ()
-        pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
-        set(CMOCKA_LIBRARIES PkgConfig::cmocka)
-    endif ()
-
     set(unit_tests
         "test_argv"
         "test_auth_token"
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 53c3598..01bbadc 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -86,6 +86,9 @@
 /* git version information in config-version.h */
 #cmakedefine HAVE_CONFIG_VERSION_H
 
+/* cmocka version information available in cmocka_version.h (>= 2.0.0) */
+#cmakedefine HAVE_CMOCKA_VERSION_H
+
 /* Define to 1 if you have the `daemon' function. */
 #cmakedefine HAVE_DAEMON
 
diff --git a/configure.ac b/configure.ac
index d5a0c70..f363e0f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1415,7 +1415,16 @@
 	[have_cmocka="yes"],
 	[AC_MSG_WARN([cmocka.pc not found on the system using pkg-config ${pkg_config_found}.  Unit tests disabled])]
 )
-AM_CONDITIONAL([ENABLE_UNITTESTS], [test "${enable_unit_tests}" = "yes" -a "${have_cmocka}" = "yes" ])
+AM_CONDITIONAL([ENABLE_UNITTESTS], [false])
+if test "${enable_unit_tests}" = "yes" -a "${have_cmocka}" = "yes"; then
+   AM_CONDITIONAL([ENABLE_UNITTESTS], [true])
+
+   saved_CFLAGS="${CFLAGS}"
+   CFLAGS="${CFLAGS} ${CMOCKA_CFLAGS}"
+   # detect cmocka < 2.0.0 that had no cmocka_version.h
+   AC_CHECK_HEADERS([cmocka_version.h])
+   CFLAGS="${saved_CFLAGS}"
+fi
 AC_SUBST([ENABLE_UNITTESTS])
 
 TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}"
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h
index da98531..3a0598d 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -24,6 +24,27 @@
 #include <setjmp.h>
 #include <cmocka.h>
 
+/* Do we use cmocka < 2.0.0? */
+#ifndef HAVE_CMOCKA_VERSION_H
+#define HAVE_OLD_CMOCKA_API 1
+/* compat with various versions of cmocka.h
+ * Older versions have LargestIntegralType. Newer
+ * versions use uintmax_t. But LargestIntegralType
+ * is not guaranteed to be equal to uintmax_t, so
+ * we can't use that unconditionally. So we only use
+ * it if cmocka.h does not define LargestIntegralType.
+ */
+#ifndef LargestIntegralType
+#define LargestIntegralType uintmax_t
+#endif
+/* redefine 2.x API in terms of 1.x API */
+#define CMockaValueData             LargestIntegralType
+#define check_expected_uint         check_expected
+#define expect_uint_value           expect_value
+#define expect_check_data           expect_check
+#define cast_ptr_to_cmocka_value(x) (x)
+#endif
+
 /**
  * Sets up the environment for unit tests like making both stderr and stdout
  * non-buffered to avoid messages getting lost if the program exits early.
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tests/openvpn/test_options_parse.c
index adf3e5b..5af84f5 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -44,8 +44,8 @@
            struct env_set *es)
 {
     function_called();
-    check_expected(p);
-    check_expected(is_inline);
+    check_expected_ptr(p);
+    check_expected_uint(is_inline);
 }
 
 void
@@ -198,31 +198,27 @@
                        &option_types_found, &es);
 }
 
-/* compat with various versions of cmocka.h
- * Older versions have LargestIntegralType. Newer
- * versions use uintmax_t. But LargestIntegralType
- * is not guaranteed to be equal to uintmax_t, so
- * we can't use that unconditionally. So we only use
- * it if cmocka.h does not define LargestIntegralType.
- */
-#ifndef LargestIntegralType
-#define LargestIntegralType uintmax_t
+#if HAVE_OLD_CMOCKA_API
+union token_parameter
+{
+    LargestIntegralType int_val;
+    void *ptr;
+};
 #endif
 
-union tokens_parameter
-{
-    LargestIntegralType as_int;
-    void *as_pointer;
-};
-
 static int
-check_tokens(const LargestIntegralType value, const LargestIntegralType expected)
+check_tokens(const CMockaValueData value, const CMockaValueData expected)
 {
-    union tokens_parameter temp;
-    temp.as_int = value;
-    const char **p = (const char **)temp.as_pointer;
-    temp.as_int = expected;
-    const char **expected_p = (const char **)temp.as_pointer;
+#if HAVE_OLD_CMOCKA_API
+    union token_parameter temp;
+    temp.int_val = value;
+    const char **p = (const char **)temp.ptr;
+    temp.int_val = expected;
+    const char **expected_p = (const char **)temp.ptr;
+#else
+    const char **p = (const char **)value.ptr;
+    const char **expected_p = (const char **)expected.ptr;
+#endif
     for (int i = 0; i < MAX_PARMS; i++)
     {
         if (!p[i] && !expected_p[i])
@@ -271,33 +267,33 @@
 
     /* basic test */
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_someopt);
-    expect_value(add_option, is_inline, 0);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value(p_expect_someopt));
+    expect_uint_value(add_option, is_inline, 0);
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_otheropt);
-    expect_value(add_option, is_inline, 0);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value(p_expect_otheropt));
+    expect_uint_value(add_option, is_inline, 0);
     read_single_config(&o, "someopt parm1 parm2\n  otheropt 1 2");
 
     /* -- gets stripped */
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_someopt);
-    expect_value(add_option, is_inline, 0);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value(p_expect_someopt));
+    expect_uint_value(add_option, is_inline, 0);
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_otheropt);
-    expect_value(add_option, is_inline, 0);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value(p_expect_otheropt));
+    expect_uint_value(add_option, is_inline, 0);
     read_single_config(&o, "someopt parm1 parm2\n\t--otheropt 1 2");
 
     /* inline options */
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_inlineopt);
-    expect_value(add_option, is_inline, 1);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value(p_expect_inlineopt));
+    expect_uint_value(add_option, is_inline, 1);
     read_single_config(&o, "<inlineopt>\nsome text\nother text\n</inlineopt>");
 
     p_expect_inlineopt[0] = "inlineopt";
     p_expect_inlineopt[1] = A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 "\n";
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_inlineopt);
-    expect_value(add_option, is_inline, 1);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value(p_expect_inlineopt));
+    expect_uint_value(add_option, is_inline, 1);
     read_single_config(&o, "<inlineopt>\n" A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 "\n</inlineopt>");
 
     gc_free(&o.gc);
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 5c16001..9b7978e 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -171,7 +171,7 @@
 bool
 send_control_channel_string(struct context *c, const char *str, msglvl_t msglevel)
 {
-    check_expected(str);
+    check_expected_ptr(str);
     return true;
 }
 
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index abe223c..a109201 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -52,7 +52,7 @@
     /* Loop through configured query_user slots */
     for (int i = 0; i < QUERY_USER_NUMSLOTS && query_user[i].response != NULL; i++)
     {
-        check_expected(query_user[i].prompt);
+        check_expected_ptr(query_user[i].prompt);
         strncpy(query_user[i].response, mock_ptr_type(char *), query_user[i].response_len);
     }
 

