From: Gert Doering <gert@...1296...>
Date: Tue,  7 Oct 2025 20:52:09 +0200
Message-ID: <20251007185217.19381-1-gert@...1296...>
In-Reply-To: <gerrit.1759239739000.I937105abeb5e8f796bf6bbe8432972adb60b3e2a@...2715...>
References: <gerrit.1759239739000.I937105abeb5e8f796bf6bbe8432972adb60b3e2a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] unit_tests: Remove useless wrapping for
 argv/buffer tests
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

If not using mock() or check_expected(), and
not linking the original function, then there
is no need for wrapping support.

Change-Id: I937105abeb5e8f796bf6bbe8432972adb60b3e2a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1243
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1243
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index be66357..aeef480 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -654,6 +654,7 @@
     endif ()
 
     set(unit_tests
+        "test_argv"
         "test_auth_token"
         "test_buffer"
         "test_crypto"
@@ -684,7 +685,6 @@
     # Clang-cl (which is also MSVC) is wrongly detected to support wrap
     if (NOT MSVC AND "${LD_SUPPORTS_WRAP}")
         list(APPEND unit_tests
-            "test_argv"
             "test_tls_crypt"
             )
     endif ()
@@ -887,13 +887,10 @@
         src/openvpn/list.c
         )
 
-    if (TARGET test_argv)
-        target_link_options(test_argv PRIVATE -Wl,--wrap=parse_line)
-        target_sources(test_argv PRIVATE
-            tests/unit_tests/openvpn/mock_get_random.c
-            src/openvpn/argv.c
-            )
-    endif ()
+    target_sources(test_argv PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        src/openvpn/argv.c
+        )
 
     if (TARGET test_cryptoapi)
         target_sources(test_cryptoapi PRIVATE
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index ec8cc69..f7b1bc8 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -4,12 +4,11 @@
 
 AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) Unit-Tests'
 
-test_binaries = crypto_testdriver packet_id_testdriver auth_token_testdriver \
+test_binaries = argv_testdriver buffer_testdriver crypto_testdriver packet_id_testdriver auth_token_testdriver \
 	ncp_testdriver misc_testdriver pkt_testdriver ssl_testdriver \
 	user_pass_testdriver push_update_msg_testdriver provider_testdriver socket_testdriver
 
 if HAVE_LD_WRAP_SUPPORT
-test_binaries += argv_testdriver buffer_testdriver
 if !WIN32
 test_binaries += tls_crypt_testdriver
 endif
@@ -36,7 +35,7 @@
 endif
 
 argv_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@
-argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=parse_line
+argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
 argv_testdriver_SOURCES = test_argv.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
@@ -46,7 +45,7 @@
 	$(top_srcdir)/src/openvpn/argv.c
 
 buffer_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@
-buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=parse_line
+buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
 buffer_testdriver_SOURCES = test_buffer.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index a04fabc..25c0371 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -22,8 +22,8 @@
 #define SCRIPT_CMD "\"" PATH1 PATH2 "\"" PARAM1 "\"" PARAM2 "\""
 
 int
-__wrap_parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
-                  msglvl_t msglevel, struct gc_arena *gc)
+parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     p[0] = PATH1 PATH2;
     p[1] = PARAM1;

