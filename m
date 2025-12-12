From: Gert Doering <gert@...1296...>
Date: Fri, 12 Dec 2025 13:03:46 +0100
Message-ID: <20251212120352.17402-1-gert@...1296...>
In-Reply-To: <gerrit.1765383841000.Icab68a5fd1b6288955f0073179f1ddde1468d951@...2715...>
References: <gerrit.1765383841000.Icab68a5fd1b6288955f0073179f1ddde1468d951@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] mbuf: Add unit tests
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

While fixing the conversion warning I was
somewhat confused how this works, so added
UTs to verify I understood it.

v2:
 - disable assert test for MS VS
 - add define for memory-intensive UTs and
   only enable it by default for CMake builds,
   so we do not break a lot of builds out there
   due to memory allocation failures

Change-Id: Icab68a5fd1b6288955f0073179f1ddde1468d951
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1432
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1432
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 906fa04..bdb1904 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -633,6 +633,7 @@
     endif ()
 endif ()
 
+option(UT_ALLOW_BIG_ALLOC "Allow unit-tests to use > 1 GB of memory" ON)
 
 if (BUILD_TESTING)
     find_package(cmocka CONFIG)
@@ -649,6 +650,7 @@
         "test_buffer"
         "test_crypto"
         "test_dhcp"
+        "test_mbuf"
         "test_misc"
         "test_ncp"
         "test_options_parse"
@@ -739,6 +741,9 @@
         # for compat with IDEs like Clion that ignore the tests properties
         # for the environment variable srcdir when running tests as fallback
         target_compile_definitions(${test_name} PRIVATE "UNIT_TEST_SOURCEDIR=\"${_UT_SOURCE_DIR}\"")
+        if (UT_ALLOW_BIG_ALLOC)
+            target_compile_definitions(${test_name} PRIVATE UNIT_TEST_ALLOW_BIG_ALLOC)
+        endif ()
 
         if (NOT ${test_name} STREQUAL "test_buffer")
             target_sources(${test_name} PRIVATE
@@ -800,6 +805,12 @@
             src/openvpn/xkey_provider.c
     )
 
+    target_sources(test_mbuf PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        src/openvpn/buffer.c
+        src/openvpn/mbuf.c
+        )
+
     target_sources(test_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
         src/openvpn/options_util.c
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 448124c..42858ec 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -42,6 +42,8 @@
 struct mbuf_set *
 mbuf_init(unsigned int size)
 {
+    ASSERT(size <= MBUF_SIZE_MAX);
+
     struct mbuf_set *ret;
     ALLOC_OBJ_CLEAR(ret, struct mbuf_set);
     ret->capacity = adjust_power_of_2(size);
@@ -121,6 +123,7 @@
     bool ret = false;
     if (ms)
     {
+        ASSERT(item);
         while (ms->len)
         {
             *item = ms->array[ms->head];
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index 7f8c1b7..f741e21 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -36,6 +36,8 @@
 struct multi_instance;
 
 #define MBUF_INDEX(head, offset, size) (((head) + (offset)) & ((size) - 1))
+/* limited by adjust_power_of_2 and array_mult_safe */
+#define MBUF_SIZE_MAX                  (ALLOC_SIZE_MAX / sizeof(struct mbuf_item))
 
 struct mbuf_buffer
 {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d01ec47..24c3e92 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -62,6 +62,7 @@
 #include "options_util.h"
 #include "tun_afunix.h"
 #include "domain_helper.h"
+#include "mbuf.h"
 
 #include <ctype.h>
 
@@ -7552,7 +7553,7 @@
     else if (streq(p[0], "bcast-buffers") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        atoi_constrained(p[1], &options->n_bcast_buf, p[0], 1, INT_MAX, msglevel);
+        atoi_constrained(p[1], &options->n_bcast_buf, p[0], 1, MBUF_SIZE_MAX, msglevel);
     }
     else if (streq(p[0], "tcp-queue-limit") && p[1] && !p[2])
     {
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 0f13172..7aeea47 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -6,9 +6,22 @@
 
 AM_TESTS_ENVIRONMENT = export LSAN_OPTIONS=suppressions=$(srcdir)/input/leak_suppr.txt;
 
-test_binaries = argv_testdriver buffer_testdriver crypto_testdriver dhcp_testdriver packet_id_testdriver auth_token_testdriver \
-	ncp_testdriver misc_testdriver options_parse_testdriver pkt_testdriver ssl_testdriver \
-	user_pass_testdriver push_update_msg_testdriver provider_testdriver socket_testdriver
+test_binaries = argv_testdriver \
+	auth_token_testdriver \
+	buffer_testdriver \
+	crypto_testdriver \
+	dhcp_testdriver \
+	ncp_testdriver \
+	mbuf_testdriver \
+	misc_testdriver \
+	options_parse_testdriver \
+	packet_id_testdriver \
+	pkt_testdriver \
+	provider_testdriver \
+	push_update_msg_testdriver \
+	socket_testdriver \
+	ssl_testdriver \
+	user_pass_testdriver
 
 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
@@ -327,6 +340,20 @@
 	$(top_srcdir)/src/compat/compat-strsep.c \
 	$(top_srcdir)/src/openvpn/ssl_util.c
 
+mbuf_testdriver_CFLAGS  = \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	-DSOURCEDIR=\"$(top_srcdir)\" @TEST_CFLAGS@
+
+mbuf_testdriver_LDFLAGS = @TEST_LDFLAGS@
+
+mbuf_testdriver_SOURCES = test_mbuf.c \
+	mock_msg.c test_common.h  \
+	mock_get_random.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/mbuf.c
+
 misc_testdriver_CFLAGS  = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	-DSOURCEDIR=\"$(top_srcdir)\" @TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 25a8def..8855e5b 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -386,7 +386,7 @@
 
     /* Instead of trying to trick the compiler here, disable the warnings
      * for this unit test. We know that the results will be truncated
-     * and we want to test that. Not we need the clang as clang-cl (msvc) does
+     * and we want to test that. Note we need the clang as clang-cl (msvc) does
      * not define __GNUC__ like it does under UNIX(-like) platforms */
 #if defined(__GNUC__) || defined(__clang__)
 /* some clang version do not understand -Wformat-truncation, so ignore the
diff --git a/tests/unit_tests/openvpn/test_mbuf.c b/tests/unit_tests/openvpn/test_mbuf.c
new file mode 100644
index 0000000..cba4da7
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_mbuf.c
@@ -0,0 +1,160 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 OpenVPN Inc. <sales@...2722...>
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
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "buffer.h"
+#include "multi.h"
+#include "mbuf.h"
+#include "test_common.h"
+
+static void
+test_mbuf_init(void **state)
+{
+    struct mbuf_set *ms = mbuf_init(256);
+    assert_int_equal(ms->capacity, 256);
+    assert_false(mbuf_defined(ms));
+    assert_non_null(ms->array);
+    mbuf_free(ms);
+
+    ms = mbuf_init(257);
+    assert_int_equal(ms->capacity, 512);
+    mbuf_free(ms);
+
+#ifdef UNIT_TEST_ALLOW_BIG_ALLOC /* allocates up to 2GB of memory */
+    ms = mbuf_init(MBUF_SIZE_MAX);
+    assert_int_equal(ms->capacity, MBUF_SIZE_MAX);
+    mbuf_free(ms);
+
+/* NOTE: expect_assert_failure does not seem to work with MSVC */
+#ifndef _MSC_VER
+    expect_assert_failure(mbuf_init(MBUF_SIZE_MAX + 1));
+#endif
+#endif
+}
+
+static void
+test_mbuf_add_remove(void **state)
+{
+    struct mbuf_set *ms = mbuf_init(4);
+    assert_int_equal(ms->capacity, 4);
+    assert_false(mbuf_defined(ms));
+    assert_non_null(ms->array);
+
+    /* instances */
+    struct multi_instance mi = { 0 };
+    struct multi_instance mi2 = { 0 };
+    /* buffers */
+    struct buffer buf = alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf = mbuf_alloc_buf(&buf);
+    assert_int_equal(mbuf_buf->refcount, 1);
+    struct mbuf_buffer *mbuf_buf2 = mbuf_alloc_buf(&buf);
+    assert_int_equal(mbuf_buf2->refcount, 1);
+    free_buf(&buf);
+    /* items */
+    struct mbuf_item mb_item = { .buffer = mbuf_buf, .instance = &mi };
+    struct mbuf_item mb_item2 = { .buffer = mbuf_buf2, .instance = &mi2 };
+
+    mbuf_add_item(ms, &mb_item);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 1);
+    assert_int_equal(mbuf_len(ms), 1);
+    assert_int_equal(mbuf_maximum_queued(ms), 1);
+    assert_int_equal(ms->head, 0);
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_add_item(ms, &mb_item2);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 2);
+    assert_int_equal(mbuf_len(ms), 2);
+    assert_int_equal(mbuf_maximum_queued(ms), 2);
+    assert_int_equal(ms->head, 0);
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_add_item(ms, &mb_item2);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 3);
+    assert_int_equal(mbuf_len(ms), 3);
+    assert_int_equal(mbuf_maximum_queued(ms), 3);
+    assert_int_equal(ms->head, 0);
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_add_item(ms, &mb_item2);
+    mbuf_add_item(ms, &mb_item2); /* overflow, first item gets removed */
+    assert_int_equal(mbuf_buf->refcount, 1);
+    assert_int_equal(mbuf_buf2->refcount, 5);
+    assert_int_equal(mbuf_len(ms), 4);
+    assert_int_equal(mbuf_maximum_queued(ms), 4);
+    assert_int_equal(ms->head, 1);
+    assert_ptr_equal(mbuf_peek(ms), &mi2);
+
+    mbuf_add_item(ms, &mb_item);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 4);
+    assert_int_equal(mbuf_len(ms), 4);
+    assert_int_equal(mbuf_maximum_queued(ms), 4);
+    assert_int_equal(ms->head, 2);
+    assert_ptr_equal(mbuf_peek(ms), &mi2);
+
+    struct mbuf_item out_item;
+    assert_true(mbuf_extract_item(ms, &out_item));
+    assert_ptr_equal(out_item.instance, mb_item2.instance);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 4);
+    assert_int_equal(mbuf_len(ms), 3);
+    assert_int_equal(mbuf_maximum_queued(ms), 4);
+    assert_int_equal(ms->head, 3);
+    assert_ptr_equal(mbuf_peek(ms), &mi2);
+    mbuf_free_buf(out_item.buffer);
+
+    mbuf_dereference_instance(ms, &mi2);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 1);
+    assert_int_equal(mbuf_len(ms), 3);
+    assert_int_equal(mbuf_maximum_queued(ms), 4);
+    assert_int_equal(ms->head, 3);
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_free(ms);
+    assert_int_equal(mbuf_buf->refcount, 1);
+    mbuf_free_buf(mbuf_buf);
+    assert_int_equal(mbuf_buf2->refcount, 1);
+    mbuf_free_buf(mbuf_buf2);
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(test_mbuf_init),
+        cmocka_unit_test(test_mbuf_add_remove),
+    };
+
+    return cmocka_run_group_tests_name("mbuf", tests, NULL, NULL);
+}

