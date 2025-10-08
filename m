From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 12:10:09 +0200
Message-ID: <20251008101014.5691-1-gert@...1296...>
In-Reply-To: <gerrit.1759239739000.I95032d2539d994abf69fc17319ed1a429c3bb948@...2715...>
References: <gerrit.1759239739000.I95032d2539d994abf69fc17319ed1a429c3bb948@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] test_options_parse: Start new UT for
 options_parse.c
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

For now contains one test case for parse_line.

Change-Id: I95032d2539d994abf69fc17319ed1a429c3bb948
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1244
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1244
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index aeef480..37bfc03 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -685,6 +685,7 @@
     # Clang-cl (which is also MSVC) is wrongly detected to support wrap
     if (NOT MSVC AND "${LD_SUPPORTS_WRAP}")
         list(APPEND unit_tests
+            "test_options_parse"
             "test_tls_crypt"
             )
     endif ()
@@ -826,6 +827,20 @@
         src/compat/compat-strsep.c
         )
 
+    if (TARGET test_options_parse)
+        target_link_options(test_options_parse PRIVATE
+            -Wl,--wrap=add_option
+            -Wl,--wrap=remove_option
+            -Wl,--wrap=update_option
+	    -Wl,--wrap=usage
+        )
+        target_sources(test_options_parse PRIVATE
+            tests/unit_tests/openvpn/mock_get_random.c
+            src/openvpn/options_parse.c
+            src/openvpn/options_util.c
+        )
+    endif ()
+
     target_sources(test_packet_id PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
         src/openvpn/otime.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index f7b1bc8..8e94665 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -9,6 +9,7 @@
 	user_pass_testdriver push_update_msg_testdriver provider_testdriver socket_testdriver
 
 if HAVE_LD_WRAP_SUPPORT
+test_binaries += options_parse_testdriver
 if !WIN32
 test_binaries += tls_crypt_testdriver
 endif
@@ -190,6 +191,21 @@
 	$(top_srcdir)/src/openvpn/platform.c
 endif
 
+options_parse_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@
+options_parse_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \
+	-Wl,--wrap=add_option \
+	-Wl,--wrap=update_option \
+	-Wl,--wrap=remove_option \
+	-Wl,--wrap=usage
+options_parse_testdriver_SOURCES = test_options_parse.c \
+	mock_msg.c mock_msg.h test_common.h \
+	mock_get_random.c \
+	$(top_srcdir)/src/openvpn/options_parse.c \
+	$(top_srcdir)/src/openvpn/options_util.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/platform.c
+
 provider_testdriver_CFLAGS  = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tests/openvpn/test_options_parse.c
new file mode 100644
index 0000000..9472c78
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -0,0 +1,196 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "options.h"
+#include "test_common.h"
+#include "mock_msg.h"
+
+void
+__wrap_add_option(struct options *options, char *p[], bool is_inline, const char *file,
+                  int line, const int level, const msglvl_t msglevel,
+                  const unsigned int permission_mask, unsigned int *option_types_found,
+                  struct env_set *es)
+{
+}
+
+void
+__wrap_remove_option(struct context *c, struct options *options, char *p[], bool is_inline,
+                     const char *file, int line, const msglvl_t msglevel,
+                     const unsigned int permission_mask, unsigned int *option_types_found,
+                     struct env_set *es)
+{
+}
+
+void
+__wrap_update_option(struct context *c, struct options *options, char *p[], bool is_inline,
+                     const char *file, int line, const int level, const msglvl_t msglevel,
+                     const unsigned int permission_mask, unsigned int *option_types_found,
+                     struct env_set *es, unsigned int *update_options_found)
+{
+}
+
+void
+__wrap_usage(void)
+{
+}
+
+/* for building long texts */
+#define A_TIMES_256 "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO"
+
+static void
+test_parse_line(void **state)
+{
+    char *p[MAX_PARMS + 1] = { 0 };
+    struct gc_arena gc = gc_new();
+    int res = 0;
+
+#define PARSE_LINE_TST(string)                                                          \
+    do                                                                                  \
+    {                                                                                   \
+        CLEAR(p);                                                                       \
+        res = parse_line(string, p, SIZE(p) - 1, "test_options_parse", 1, M_INFO, &gc); \
+    } while (0);
+
+    /* basic example */
+    PARSE_LINE_TST("some-opt firstparm second-parm");
+    assert_int_equal(res, 3);
+    assert_string_equal(p[0], "some-opt");
+    assert_string_equal(p[1], "firstparm");
+    assert_string_equal(p[2], "second-parm");
+    assert_null(p[res]);
+
+    /* basic quoting, -- is not handled special */
+    PARSE_LINE_TST("--some-opt 'first parm' \"second' 'parm\"");
+    assert_int_equal(res, 3);
+    assert_string_equal(p[0], "--some-opt");
+    assert_string_equal(p[1], "first parm");
+    assert_string_equal(p[2], "second' 'parm");
+    assert_null(p[res]);
+
+    /* escaped quotes */
+    PARSE_LINE_TST("\"some opt\" 'first\" \"parm' \"second\\\" \\\"parm\"");
+    assert_int_equal(res, 3);
+    assert_string_equal(p[0], "some opt");
+    assert_string_equal(p[1], "first\" \"parm");
+    assert_string_equal(p[2], "second\" \"parm");
+    assert_null(p[res]);
+
+    /* missing closing quote */
+    PARSE_LINE_TST("--some-opt 'first parm \"second parm\"");
+    assert_int_equal(res, 0);
+
+    /* escaped backslash */
+    PARSE_LINE_TST("some\\\\opt C:\\\\directory\\\\file");
+    assert_int_equal(res, 2);
+    assert_string_equal(p[0], "some\\opt");
+    assert_string_equal(p[1], "C:\\directory\\file");
+    assert_null(p[res]);
+
+    /* comment chars are not special inside parameter */
+    PARSE_LINE_TST("some-opt firstparm; second#parm");
+    assert_int_equal(res, 3);
+    assert_string_equal(p[0], "some-opt");
+    assert_string_equal(p[1], "firstparm;");
+    assert_string_equal(p[2], "second#parm");
+    assert_null(p[res]);
+
+    /* comment */
+    PARSE_LINE_TST("some-opt firstparm # secondparm");
+    assert_int_equal(res, 2);
+    assert_string_equal(p[0], "some-opt");
+    assert_string_equal(p[1], "firstparm");
+    assert_null(p[res]);
+
+    /* parameter just long enough */
+    PARSE_LINE_TST("opt " A_TIMES_256);
+    assert_int_equal(res, 2);
+    assert_string_equal(p[0], "opt");
+    assert_string_equal(p[1], A_TIMES_256);
+    assert_null(p[res]);
+
+    /* quoting doesn't count for parameter length */
+    PARSE_LINE_TST("opt \"" A_TIMES_256 "\"");
+    assert_int_equal(res, 2);
+    assert_string_equal(p[0], "opt");
+    assert_string_equal(p[1], A_TIMES_256);
+    assert_null(p[res]);
+
+    /* very long line */
+    PARSE_LINE_TST("opt " A_TIMES_256 " " A_TIMES_256 " " A_TIMES_256 " " A_TIMES_256);
+    assert_int_equal(res, 5);
+    assert_string_equal(p[0], "opt");
+    assert_string_equal(p[1], A_TIMES_256);
+    assert_string_equal(p[2], A_TIMES_256);
+    assert_string_equal(p[3], A_TIMES_256);
+    assert_string_equal(p[4], A_TIMES_256);
+    assert_null(p[res]);
+
+    /* parameter too long */
+    PARSE_LINE_TST("opt " A_TIMES_256 "B");
+    assert_int_equal(res, 0);
+
+    /* max parameters */
+    PARSE_LINE_TST("0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15");
+    assert_int_equal(res, MAX_PARMS);
+    char num[3];
+    for (int i = 0; i < MAX_PARMS; i++)
+    {
+        assert_true(snprintf(num, 3, "%d", i) < 3);
+        assert_string_equal(p[i], num);
+    }
+    assert_null(p[res]);
+
+    /* too many parameters, overflow is ignored */
+    PARSE_LINE_TST("0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16");
+    assert_int_equal(res, MAX_PARMS);
+    for (int i = 0; i < MAX_PARMS; i++)
+    {
+        assert_true(snprintf(num, 3, "%d", i) < 3);
+        assert_string_equal(p[i], num);
+    }
+    assert_null(p[res]);
+
+    gc_free(&gc);
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(test_parse_line),
+    };
+
+    return cmocka_run_group_tests_name("options_parse", tests, NULL, NULL);
+}

