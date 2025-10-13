From: Gert Doering <gert@...1296...>
Date: Mon, 13 Oct 2025 17:47:53 +0200
Message-ID: <20251013154758.21695-1-gert@...1296...>
In-Reply-To: <gerrit.1760136547000.I08e50030b1b692d351509f541e5c0b03b5170615@...2715...>
References: <gerrit.1760136547000.I08e50030b1b692d351509f541e5c0b03b5170615@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] test_dhcp: Start a dhcp helper functions
 UT
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

Use extra define to allow testing code only
used on Windows but not actually dependent
on Windows.

Change-Id: I08e50030b1b692d351509f541e5c0b03b5170615
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1267
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1267
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9e0b46e..b773dcb 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -658,6 +658,7 @@
         "test_auth_token"
         "test_buffer"
         "test_crypto"
+        "test_dhcp"
         "test_misc"
         "test_ncp"
         "test_options_parse"
@@ -910,6 +911,11 @@
             )
     endif ()
 
+    target_compile_definitions(test_dhcp PRIVATE DHCP_UNIT_TEST)
+    target_sources(test_dhcp PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        )
+
     if (TARGET test_networking)
         target_link_options(test_networking PRIVATE -Wl,--wrap=parse_line)
         target_compile_options(test_networking PRIVATE -UNDEBUG)
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 56f03f2..0893ec7 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -186,7 +186,7 @@
     return 0;
 }
 
-#if defined(_WIN32)
+#if defined(_WIN32) || defined(DHCP_UNIT_TEST)
 
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index 3fcd2b6..2ad31a6 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -93,7 +93,7 @@
 
 in_addr_t dhcp_extract_router_msg(struct buffer *ipbuf);
 
-#if defined(_WIN32)
+#if defined(_WIN32) || defined(DHCP_UNIT_TEST)
 #include "tun.h"
 
 bool build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 6562c22..741798d 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -59,7 +59,7 @@
 #define DCO_WIN_REFERENCE_STRING "ovpn-dco"
 #endif
 
-#if defined(_WIN32) || defined(TARGET_ANDROID)
+#if defined(_WIN32) || defined(TARGET_ANDROID) || defined(DHCP_UNIT_TEST)
 
 #define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)
 
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 50f4a11..17aa0ce 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -6,7 +6,7 @@
 
 AM_TESTS_ENVIRONMENT = export LSAN_OPTIONS=suppressions=$(srcdir)/input/leak_suppr.txt;
 
-test_binaries = argv_testdriver buffer_testdriver crypto_testdriver packet_id_testdriver auth_token_testdriver \
+test_binaries = argv_testdriver buffer_testdriver crypto_testdriver dhcp_testdriver packet_id_testdriver auth_token_testdriver \
 	ncp_testdriver misc_testdriver options_parse_testdriver pkt_testdriver ssl_testdriver \
 	user_pass_testdriver push_update_msg_testdriver provider_testdriver socket_testdriver
 
@@ -72,6 +72,15 @@
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/mss.c
 
+dhcp_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
+dhcp_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
+dhcp_testdriver_SOURCES = test_dhcp.c \
+	mock_msg.c mock_msg.h test_common.h \
+	mock_get_random.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/win32-util.c
+
 ssl_testdriver_CFLAGS  = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
index c6321dc..62afde5 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -23,6 +23,8 @@
 #ifndef MOCK_MSG_H
 #define MOCK_MSG_H
 
+#include "error.h"
+
 /**
  * Mock debug level defaults to 0, which gives clean(-ish) test reports.  Call
  * this function from your test driver to increase debug output when you
diff --git a/tests/unit_tests/openvpn/test_dhcp.c b/tests/unit_tests/openvpn/test_dhcp.c
new file mode 100644
index 0000000..729ca58
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_dhcp.c
@@ -0,0 +1,134 @@
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
+#include "test_common.h"
+#include "mock_msg.h"
+
+#include "dhcp.c"
+
+uint16_t
+ip_checksum(const sa_family_t af, const uint8_t *payload, const int len_payload,
+            const uint8_t *src_addr, const uint8_t *dest_addr, const int proto)
+{
+    return 0;
+}
+const char *
+print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc)
+{
+    return "dummy";
+}
+
+static void
+test_write_dhcp_search_str(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer out_buf = alloc_buf_gc(512, &gc);
+    struct buffer clear_buf = alloc_buf_gc(512, &gc);
+    buf_clear(&clear_buf);
+    bool error = false;
+
+#define LONGDOMAIN "a-reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaally-long-domain"
+    const char *search_list[] = {
+        "openvpn.net",
+        "openvpn.org",
+        LONGDOMAIN,
+        "subdomain." LONGDOMAIN ".top123",  /* maximum length */
+        "subdomain-" LONGDOMAIN "-top123",  /* maximum length */
+        "subdomain." LONGDOMAIN ".top1234", /* too long */
+        "sub..tld",                         /* invalid */
+    };
+    const unsigned char output_1[28] = "\x77\x1a\x07openvpn\x03net\x00\x07openvpn\x03org";
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list, 2, &error);
+    assert_memory_equal(BPTR(&out_buf), output_1, sizeof(output_1));
+    assert_false(error);
+
+    /* buf too small */
+    struct buffer small_buf = alloc_buf_gc(sizeof(output_1) - 1, &gc);
+    buf_clear(&small_buf);
+    write_dhcp_search_str(&small_buf, DHCP_DOMAIN_SEARCH, search_list, 2, &error);
+    assert_memory_equal(BPTR(&small_buf), BPTR(&clear_buf), buf_forward_capacity_total(&small_buf));
+    assert_true(error);
+    error = false;
+
+    const unsigned char output_2[0xEC + 3 + 1] = "\x77\xEE\xEC" LONGDOMAIN;
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 2, 1, &error);
+    assert_memory_equal(BPTR(&out_buf), output_2, sizeof(output_2));
+    assert_false(error);
+
+    const unsigned char output_3[0xEC + 3 + 10 + 7 + 1] = "\x77\xFF\x09subdomain\xEC" LONGDOMAIN "\x06top123";
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 3, 1, &error);
+    assert_memory_equal(BPTR(&out_buf), output_3, sizeof(output_3));
+    assert_false(error);
+
+    const unsigned char output_4[0xEC + 3 + 10 + 7 + 1] = "\x77\xFF\xFDsubdomain-" LONGDOMAIN "-top123";
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 4, 1, &error);
+    assert_memory_equal(BPTR(&out_buf), output_4, sizeof(output_4));
+    assert_false(error);
+
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 5, 1, &error);
+    assert_memory_equal(BPTR(&out_buf), BPTR(&clear_buf), buf_forward_capacity_total(&clear_buf));
+    assert_true(error);
+    error = false;
+
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list, 3, &error);
+    assert_memory_equal(BPTR(&out_buf), BPTR(&clear_buf), buf_forward_capacity_total(&clear_buf));
+    assert_true(error);
+    error = false;
+
+    /* FIXME: should probably throw an error instead adding that \x00 ? */
+    const char output_5[12] = "\x77\x0a\x03sub\x00\x03tld";
+    buf_clear(&out_buf);
+    write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 6, 1, &error);
+    assert_memory_equal(BPTR(&out_buf), output_5, sizeof(output_5));
+    assert_false(error);
+
+    gc_free(&gc);
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(test_write_dhcp_search_str),
+    };
+
+    return cmocka_run_group_tests_name("dhcp", tests, NULL, NULL);
+}

