From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 18:13:52 +0200
Message-ID: <20251008161357.5679-1-gert@...1296...>
In-Reply-To: <gerrit.1759937374000.I60df1e61ed89be52e9d032b5b49133a784f9811e@...2715...>
References: <gerrit.1759937374000.I60df1e61ed89be52e9d032b5b49133a784f9811e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] test_options_parse: Remove --wrap
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

After removing --wrap from some other tests in
a previous commit I got confused here myself.
--wrap is really only needed when you have the
original function linked in. Somehow I thought
the call ordering and mocking logic needed this.

But this is wrong, so no need to use --wrap here
since we currently do not link any of those
functions.

Change-Id: I60df1e61ed89be52e9d032b5b49133a784f9811e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1258
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1258
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 37bfc03..9511bda 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -660,6 +660,7 @@
         "test_crypto"
         "test_misc"
         "test_ncp"
+        "test_options_parse"
         "test_packet_id"
         "test_pkt"
         "test_provider"
@@ -685,7 +686,6 @@
     # Clang-cl (which is also MSVC) is wrongly detected to support wrap
     if (NOT MSVC AND "${LD_SUPPORTS_WRAP}")
         list(APPEND unit_tests
-            "test_options_parse"
             "test_tls_crypt"
             )
     endif ()
@@ -827,19 +827,11 @@
         src/compat/compat-strsep.c
         )
 
-    if (TARGET test_options_parse)
-        target_link_options(test_options_parse PRIVATE
-            -Wl,--wrap=add_option
-            -Wl,--wrap=remove_option
-            -Wl,--wrap=update_option
-	    -Wl,--wrap=usage
+    target_sources(test_options_parse PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        src/openvpn/options_parse.c
+        src/openvpn/options_util.c
         )
-        target_sources(test_options_parse PRIVATE
-            tests/unit_tests/openvpn/mock_get_random.c
-            src/openvpn/options_parse.c
-            src/openvpn/options_util.c
-        )
-    endif ()
 
     target_sources(test_packet_id PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 8e94665..05c0ea5 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -5,11 +5,10 @@
 AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) Unit-Tests'
 
 test_binaries = argv_testdriver buffer_testdriver crypto_testdriver packet_id_testdriver auth_token_testdriver \
-	ncp_testdriver misc_testdriver pkt_testdriver ssl_testdriver \
+	ncp_testdriver misc_testdriver options_parse_testdriver pkt_testdriver ssl_testdriver \
 	user_pass_testdriver push_update_msg_testdriver provider_testdriver socket_testdriver
 
 if HAVE_LD_WRAP_SUPPORT
-test_binaries += options_parse_testdriver
 if !WIN32
 test_binaries += tls_crypt_testdriver
 endif
@@ -192,11 +191,7 @@
 endif
 
 options_parse_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@
-options_parse_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \
-	-Wl,--wrap=add_option \
-	-Wl,--wrap=update_option \
-	-Wl,--wrap=remove_option \
-	-Wl,--wrap=usage
+options_parse_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
 options_parse_testdriver_SOURCES = test_options_parse.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tests/openvpn/test_options_parse.c
index 0ae37f5..59a3f6d 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -38,10 +38,10 @@
 #include "mock_msg.h"
 
 void
-__wrap_add_option(struct options *options, char *p[], bool is_inline, const char *file,
-                  int line, const int level, const msglvl_t msglevel,
-                  const unsigned int permission_mask, unsigned int *option_types_found,
-                  struct env_set *es)
+add_option(struct options *options, char *p[], bool is_inline, const char *file,
+           int line, const int level, const msglvl_t msglevel,
+           const unsigned int permission_mask, unsigned int *option_types_found,
+           struct env_set *es)
 {
     function_called();
     check_expected(p);
@@ -49,23 +49,23 @@
 }
 
 void
-__wrap_remove_option(struct context *c, struct options *options, char *p[], bool is_inline,
-                     const char *file, int line, const msglvl_t msglevel,
-                     const unsigned int permission_mask, unsigned int *option_types_found,
-                     struct env_set *es)
+remove_option(struct context *c, struct options *options, char *p[], bool is_inline,
+              const char *file, int line, const msglvl_t msglevel,
+              const unsigned int permission_mask, unsigned int *option_types_found,
+              struct env_set *es)
 {
 }
 
 void
-__wrap_update_option(struct context *c, struct options *options, char *p[], bool is_inline,
-                     const char *file, int line, const int level, const msglvl_t msglevel,
-                     const unsigned int permission_mask, unsigned int *option_types_found,
-                     struct env_set *es, unsigned int *update_options_found)
+update_option(struct context *c, struct options *options, char *p[], bool is_inline,
+              const char *file, int line, const int level, const msglvl_t msglevel,
+              const unsigned int permission_mask, unsigned int *option_types_found,
+              struct env_set *es, unsigned int *update_options_found)
 {
 }
 
 void
-__wrap_usage(void)
+usage(void)
 {
 }
 
@@ -270,34 +270,34 @@
     p_expect_inlineopt[1] = "some text\nother text\n";
 
     /* basic test */
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_someopt);
-    expect_value(__wrap_add_option, is_inline, 0);
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_otheropt);
-    expect_value(__wrap_add_option, is_inline, 0);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_someopt);
+    expect_value(add_option, is_inline, 0);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_otheropt);
+    expect_value(add_option, is_inline, 0);
     read_single_config(&o, "someopt parm1 parm2\n  otheropt 1 2");
 
     /* -- gets stripped */
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_someopt);
-    expect_value(__wrap_add_option, is_inline, 0);
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_otheropt);
-    expect_value(__wrap_add_option, is_inline, 0);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_someopt);
+    expect_value(add_option, is_inline, 0);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_otheropt);
+    expect_value(add_option, is_inline, 0);
     read_single_config(&o, "someopt parm1 parm2\n\t--otheropt 1 2");
 
     /* inline options */
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_inlineopt);
-    expect_value(__wrap_add_option, is_inline, 1);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_inlineopt);
+    expect_value(add_option, is_inline, 1);
     read_single_config(&o, "<inlineopt>\nsome text\nother text\n</inlineopt>");
 
     p_expect_inlineopt[0] = "inlineopt";
     p_expect_inlineopt[1] = A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 "\n";
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_inlineopt);
-    expect_value(__wrap_add_option, is_inline, 1);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_inlineopt);
+    expect_value(add_option, is_inline, 1);
     read_single_config(&o, "<inlineopt>\n" A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 "\n</inlineopt>");
 
     gc_free(&o.gc);

