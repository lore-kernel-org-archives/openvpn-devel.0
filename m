From: Gert Doering <gert@...1296...>
Date: Sun, 31 Aug 2025 17:11:26 +0200
Message-ID: <20250831151133.25684-1-gert@...1296...>
In-Reply-To: <gerrit.1756402061000.If546f64a4554b292623bfcfe9ee53bac17dfa803@...2715...>
References: <gerrit.1756402061000.If546f64a4554b292623bfcfe9ee53bac17dfa803@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Add new unit test module test_socket
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

With a first UT that tests add_in6_addr() (and
print_in6_addr implicitly).

Change-Id: If546f64a4554b292623bfcfe9ee53bac17dfa803
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1160
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 45044af..35513e9 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -628,9 +628,11 @@
     target_compile_options(openvpn PRIVATE -DPLUGIN_LIBDIR=\"${PLUGIN_DIR}\")
 
     find_library(resolv resolv)
-    # some platform like BSDs already include resolver functionality in the libc and not have an extra resolv library
+    # some platform like BSDs already include resolver functionality in the libc
+    # and do not have an extra resolv library
     if (${resolv} OR APPLE)
-        target_link_libraries(openvpn PUBLIC -lresolv)
+        set(RESOLV_LIBRARIES resolv)
+        target_link_libraries(openvpn PUBLIC ${RESOLV_LIBRARIES})
     endif ()
 endif ()
 
@@ -653,6 +655,7 @@
         "test_packet_id"
         "test_pkt"
         "test_provider"
+        "test_socket"
         "test_ssl"
         "test_user_pass"
         "test_push_update_msg"
@@ -849,6 +852,16 @@
         src/openvpn/base64.c
         )
 
+    target_link_libraries(test_socket PUBLIC ${RESOLV_LIBRARIES})
+    target_sources(test_socket PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        tests/unit_tests/openvpn/mock_management.c
+        tests/unit_tests/openvpn/mock_win32_execve.c
+        src/openvpn/env_set.c
+        src/openvpn/run_command.c
+        src/openvpn/socket_util.c
+        )
+
     target_sources(test_user_pass PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
         tests/unit_tests/openvpn/mock_win32_execve.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index b24e03c..d030185 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -4,23 +4,17 @@
 
 AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) Unit-Tests'
 
-test_binaries=
+test_binaries = crypto_testdriver packet_id_testdriver auth_token_testdriver \
+	ncp_testdriver misc_testdriver pkt_testdriver ssl_testdriver \
+	user_pass_testdriver push_update_msg_testdriver provider_testdriver socket_testdriver
 
 if HAVE_LD_WRAP_SUPPORT
 test_binaries += argv_testdriver buffer_testdriver
-endif
-
-test_binaries += crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_testdriver misc_testdriver \
-	pkt_testdriver ssl_testdriver user_pass_testdriver push_update_msg_testdriver
-
-if HAVE_LD_WRAP_SUPPORT
 if !WIN32
 test_binaries += tls_crypt_testdriver
 endif
 endif
 
-test_binaries += provider_testdriver
-
 if WIN32
 test_binaries += cryptoapi_testdriver
 LDADD = -lws2_32
@@ -343,4 +337,22 @@
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/push_util.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
-	$(top_srcdir)/src/openvpn/otime.c
\ No newline at end of file
+	$(top_srcdir)/src/openvpn/otime.c
+
+socket_testdriver_CFLAGS  = \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	-DSOURCEDIR=\"$(top_srcdir)\" @TEST_CFLAGS@
+
+socket_testdriver_LDFLAGS = @TEST_LDFLAGS@ $(SOCKETS_LIBS)
+
+socket_testdriver_SOURCES = test_socket.c \
+	mock_msg.c test_common.h  \
+	mock_get_random.c \
+	mock_management.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/env_set.c \
+	$(top_srcdir)/src/openvpn/run_command.c \
+	$(top_srcdir)/src/openvpn/socket_util.c
+
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/openvpn/mock_management.c
index b24e4c4..28e541c 100644
--- a/tests/unit_tests/openvpn/mock_management.c
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -46,4 +46,18 @@
 {
     return NULL;
 }
+
+void
+management_set_state(struct management *man, const int state, const char *detail,
+                     const in_addr_t *tun_local_ip, const struct in6_addr *tun_local_ip6,
+                     const struct openvpn_sockaddr *local_addr,
+                     const struct openvpn_sockaddr *remote_addr)
+{
+}
+
 #endif
+
+void
+management_sleep(const int n)
+{
+}
diff --git a/tests/unit_tests/openvpn/test_socket.c b/tests/unit_tests/openvpn/test_socket.c
new file mode 100644
index 0000000..2da2529
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_socket.c
@@ -0,0 +1,126 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2021-2025 Arne Schwabe <arne@...1227...>
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
+#include "socket.h"
+#include "win32.h"
+
+/* stubs for some unused functions instead of pulling in too many dependencies */
+struct signal_info siginfo_static; /* GLOBAL */
+
+int
+signal_reset(struct signal_info *si, int signum)
+{
+    assert_true(0);
+    return 0;
+}
+
+#ifdef _WIN32
+struct win32_signal win32_signal; /* GLOBAL */
+
+int
+win32_signal_get(struct win32_signal *ws)
+{
+    assert_true(0);
+    return 0;
+}
+#endif
+
+int
+parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
+           int msglevel, struct gc_arena *gc)
+{
+    assert_true(0);
+    return 0;
+}
+
+static void
+test_add_in6_addr_tc(const char *orig_str, uint32_t add, const char *expect_str)
+{
+    struct in6_addr orig, result, expected;
+    struct gc_arena gc = gc_new();
+    assert_int_equal(inet_pton(AF_INET6, orig_str, &orig), 1);
+    assert_int_equal(inet_pton(AF_INET6, expect_str, &expected), 1);
+    result = add_in6_addr(orig, add);
+    const char *result_str = print_in6_addr(result, 0, &gc);
+    assert_string_equal(result_str, expect_str);
+    assert_memory_equal(&result, &expected, sizeof(struct in6_addr));
+    gc_free(&gc);
+}
+
+static bool
+check_mapped_ipv4_address(void)
+{
+    struct gc_arena gc = gc_new();
+    const char *ipv4_output = "::255.255.255.255";
+    struct in6_addr addr;
+    assert_int_equal(inet_pton(AF_INET6, ipv4_output, &addr), 1);
+    const char *test_output = print_in6_addr(addr, 0, &gc);
+    bool ret = strcmp(test_output, ipv4_output) == 0;
+    gc_free(&gc);
+    return ret;
+}
+
+static void
+test_add_in6_addr(void **state)
+{
+    /* Note that some of the result strings need to account for
+       print_in6_addr formatting the addresses potentially as IPv4 */
+    bool mapped_ipv4 = check_mapped_ipv4_address();
+    test_add_in6_addr_tc("::", 1, "::1");
+    test_add_in6_addr_tc("::ff", 1, "::100");
+    test_add_in6_addr_tc("::ffff", 1, mapped_ipv4 ? "::0.1.0.0" : "::1:0");
+    test_add_in6_addr_tc("ffff::ffff", 1, "ffff::1:0");
+    test_add_in6_addr_tc("::ffff:ffff", 1, "::1:0:0");
+    test_add_in6_addr_tc("ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", 1, "::");
+    test_add_in6_addr_tc("ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", 2, "::1");
+
+    test_add_in6_addr_tc("::", UINT32_MAX, mapped_ipv4 ? "::255.255.255.255" : "::ffff:ffff");
+    test_add_in6_addr_tc("::1", UINT32_MAX, "::1:0:0");
+    test_add_in6_addr_tc("::ffff", UINT32_MAX, "::1:0:fffe");
+    test_add_in6_addr_tc("ffff::ffff", UINT32_MAX, "ffff::1:0:fffe");
+    test_add_in6_addr_tc("::ffff:ffff", UINT32_MAX, "::1:ffff:fffe");
+    test_add_in6_addr_tc("ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", UINT32_MAX,
+                         mapped_ipv4 ? "::255.255.255.254" : "::ffff:fffe");
+}
+
+const struct CMUnitTest socket_tests[] = {
+    cmocka_unit_test(test_add_in6_addr)
+};
+
+int
+main(void)
+{
+    return cmocka_run_group_tests(socket_tests, NULL, NULL);
+}

