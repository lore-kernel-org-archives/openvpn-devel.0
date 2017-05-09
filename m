From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 9 May 2017 21:10:36 +0200
Message-ID: <1494357036-3529-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH (release/2.3)] cleanup: merge
	packet_id_alloc_outgoing() into packet_id_write()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The functions packet_id_alloc_outgoing() and packet_id_write() were
always called in tandem.  Instead of forcing the caller to allocate a
packet_id_net to do so, merge the two functions.  This simplifies the API
and reduces the chance on mistakes in the future.

This patch adds unit tests to verify the behaviour of packet_id_write().
Verifying that we assert out correctly required the change to mock_msg.c.

This patch was cherry-picked from a87e1431 (master).

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 configure.ac                              |   1 +
 src/openvpn/crypto.c                      |  12 +--
 src/openvpn/packet_id.c                   |  24 ++++-
 src/openvpn/packet_id.h                   |  34 +++---
 tests/unit_tests/Makefile.am              |   2 +-
 tests/unit_tests/openvpn/Makefile.am      |  24 +++++
 tests/unit_tests/openvpn/mock_msg.c       |  98 +++++++++++++++++
 tests/unit_tests/openvpn/mock_msg.h       |  35 +++++++
 tests/unit_tests/openvpn/test_packet_id.c | 169 ++++++++++++++++++++++++++++++
 9 files changed, 365 insertions(+), 34 deletions(-)
 create mode 100644 tests/unit_tests/openvpn/Makefile.am
 create mode 100644 tests/unit_tests/openvpn/mock_msg.c
 create mode 100644 tests/unit_tests/openvpn/mock_msg.h
 create mode 100644 tests/unit_tests/openvpn/test_packet_id.c

diff --git a/configure.ac b/configure.ac
index 25452a6..d2ce76e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1174,6 +1174,7 @@ AC_CONFIG_FILES([
 	src/plugins/down-root/Makefile
 	tests/Makefile
         tests/unit_tests/Makefile
+        tests/unit_tests/openvpn/Makefile
         tests/unit_tests/plugins/Makefile
         tests/unit_tests/plugins/auth-pam/Makefile
         tests/unit_tests/example_test/Makefile
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e9d6f03..f153367 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -114,23 +114,19 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	      /* Put packet ID in plaintext buffer or IV, depending on cipher mode */
 	      if (opt->packet_id)
 		{
-		  struct packet_id_net pin;
-		  packet_id_alloc_outgoing (&opt->packet_id->send, &pin, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM));
-		  ASSERT (packet_id_write (&pin, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
+		  ASSERT (packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
 		}
 	    }
 	  else if (cipher_kt_mode_ofb_cfb(cipher_kt))
 	    {
-	      struct packet_id_net pin;
 	      struct buffer b;
 
 	      ASSERT (opt->flags & CO_USE_IV);    /* IV and packet-ID required */
 	      ASSERT (opt->packet_id); /*  for this mode. */
 
-	      packet_id_alloc_outgoing (&opt->packet_id->send, &pin, true);
 	      memset (iv_buf, 0, iv_size);
 	      buf_set_write (&b, iv_buf, iv_size);
-	      ASSERT (packet_id_write (&pin, &b, true, false));
+	      ASSERT (packet_id_write (&opt->packet_id->send, &b, true, false));
 	    }
 	  else /* We only support CBC, CFB, or OFB modes right now */
 	    {
@@ -191,9 +187,7 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	{
 	  if (opt->packet_id)
 	    {
-	      struct packet_id_net pin;
-	      packet_id_alloc_outgoing (&opt->packet_id->send, &pin, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM));
-	      ASSERT (packet_id_write (&pin, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
+	      ASSERT (packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
 	    }
 	  work = *buf;
 	}
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index a690bbc..c637be6 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -294,12 +294,30 @@ packet_id_read (struct packet_id_net *pin, struct buffer *buf, bool long_form)
   return true;
 }
 
+static void
+packet_id_send_update(struct packet_id_send *p, bool long_form)
+{
+  if (!p->time)
+    {
+      p->time = now;
+    }
+  p->id++;
+  if (!p->id)
+    {
+      ASSERT(long_form);
+      p->time = now;
+      p->id = 1;
+    }
+}
+
 bool
-packet_id_write (const struct packet_id_net *pin, struct buffer *buf, bool long_form, bool prepend)
+packet_id_write (struct packet_id_send *p, struct buffer *buf, bool long_form,
+        bool prepend)
 {
-  packet_id_type net_id = htonpid (pin->id);
-  net_time_t net_time = htontime (pin->time);
+  packet_id_send_update(p, long_form);
 
+  const packet_id_type net_id = htonpid(p->id);
+  const net_time_t net_time = htontime(p->time);
   if (prepend)
     {
       if (long_form)
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index b02d6fc..f6fa9bd 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -252,7 +252,19 @@ const char *packet_id_persist_print (const struct packet_id_persist *p, struct g
  */
 
 bool packet_id_read (struct packet_id_net *pin, struct buffer *buf, bool long_form);
-bool packet_id_write (const struct packet_id_net *pin, struct buffer *buf, bool long_form, bool prepend);
+
+/**
+ * Write a packet ID to buf, and update the packet ID state.
+ *
+ * @param p             Packet ID state.
+ * @param buf           Buffer to write the packet ID too
+ * @param long_form     If true, also update and write time_t to buf
+ * @param prepend       If true, prepend to buffer, otherwise apppend.
+ *
+ * @return true if successful, false otherwise.
+ */
+bool packet_id_write (struct packet_id_send *p, struct buffer *buf,
+        bool long_form, bool prepend);
 
 /*
  * Inline functions.
@@ -294,26 +306,6 @@ packet_id_close_to_wrapping (const struct packet_id_send *p)
   return p->id >= PACKET_ID_WRAP_TRIGGER;
 }
 
-/*
- * Allocate an outgoing packet id.
- * Sequence number ranges from 1 to 2^32-1.
- * In long_form, a time_t is added as well.
- */
-static inline void
-packet_id_alloc_outgoing (struct packet_id_send *p, struct packet_id_net *pin, bool long_form)
-{
-  if (!p->time)
-    p->time = now;
-  pin->id = ++p->id;
-  if (!pin->id)
-    {
-      ASSERT (long_form);
-      p->time = now;
-      pin->id = p->id = 1;
-    }
-  pin->time = p->time;
-}
-
 static inline bool
 check_timestamp_delta (time_t remote, unsigned int max_delta)
 {
diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index 8868c1c..31d37b8 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -1,5 +1,5 @@
 AUTOMAKE_OPTIONS = foreign
 
 if CMOCKA_INITIALIZED
-SUBDIRS = example_test plugins
+SUBDIRS = example_test openvpn plugins
 endif
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
new file mode 100644
index 0000000..eb85f83
--- /dev/null
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -0,0 +1,24 @@
+AUTOMAKE_OPTIONS = foreign
+
+check_PROGRAMS=
+
+if ENABLE_CRYPTO
+check_PROGRAMS += packet_id_testdriver
+endif
+
+TESTS = $(check_PROGRAMS)
+
+openvpn_includedir = $(top_srcdir)/include
+openvpn_srcdir = $(top_srcdir)/src/openvpn
+compat_srcdir = $(top_srcdir)/src/compat
+
+packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	$(OPTIONAL_CRYPTO_CFLAGS)
+packet_id_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
+	$(OPTIONAL_CRYPTO_LIBS)
+packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c \
+	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/otime.c \
+	$(openvpn_srcdir)/packet_id.c \
+	$(openvpn_srcdir)/platform.c
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
new file mode 100644
index 0000000..60d80dd
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -0,0 +1,98 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include <stdarg.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+
+#include "errlevel.h"
+#include "error.h"
+
+#include "mock_msg.h"
+
+unsigned int x_debug_level = 0; /* Default to (almost) no debugging output */
+bool fatal_error_triggered = false;
+
+void
+mock_set_debug_level(int level)
+{
+    x_debug_level = level;
+}
+
+void
+x_msg_va(const unsigned int flags, const char *format,
+         va_list arglist)
+{
+    if (flags & M_FATAL)
+    {
+        fatal_error_triggered = true;
+        printf("FATAL ERROR:");
+    }
+    vprintf(format, arglist);
+    printf("\n");
+}
+
+void
+x_msg(const unsigned int flags, const char *format, ...)
+{
+    va_list arglist;
+    va_start(arglist, format);
+    x_msg_va(flags, format, arglist);
+    va_end(arglist);
+}
+
+void
+assert_failed(const char *filename, int line, const char *condition)
+{
+    mock_assert(false, condition ? condition : "", filename, line);
+    /* Keep compiler happy.  Should not happen, mock_assert() does not return */
+    exit(1);
+}
+
+/*
+ * Fail memory allocation.  Don't use msg() because it tries
+ * to allocate memory as part of its operation.
+ */
+void
+out_of_memory(void)
+{
+    fprintf(stderr, "Out of Memory\n");
+    exit(1);
+}
+
+bool
+dont_mute(unsigned int flags)
+{
+    return true;
+}
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
new file mode 100644
index 0000000..e0933c6
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef MOCK_MSG_H
+#define MOCK_MSG_H
+
+/**
+ * Mock debug level defaults to 0, which gives clean(-ish) test reports.  Call
+ * this function from your test driver to increase debug output when you
+ * need debug output.
+ */
+void mock_set_debug_level(int level);
+
+#endif /* MOCK_MSG */
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
new file mode 100644
index 0000000..3662e17
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -0,0 +1,169 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#include <assert.h>
+#include <stdarg.h>
+#include <stddef.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "packet_id.h"
+
+#include "mock_msg.h"
+
+struct test_packet_id_write_data {
+    struct {
+        uint32_t buf_id;
+        uint32_t buf_time;
+    } test_buf_data;
+    struct buffer test_buf;
+    struct packet_id_send pis;
+};
+
+static int
+test_packet_id_write_setup(void **state) {
+    struct test_packet_id_write_data *data =
+            calloc(1, sizeof(struct test_packet_id_write_data));
+
+    if (!data)
+    {
+        return -1;
+    }
+
+    data->test_buf.data = (void *) &data->test_buf_data;
+    data->test_buf.capacity = sizeof(data->test_buf_data);
+
+    *state = data;
+    return 0;
+}
+
+static int
+test_packet_id_write_teardown(void **state) {
+    free(*state);
+    return 0;
+}
+
+static void
+test_packet_id_write_short(void **state)
+{
+    struct test_packet_id_write_data *data = *state;
+
+    now = 5010;
+    assert_true(packet_id_write(&data->pis, &data->test_buf, false, false));
+    assert_true(data->pis.id == 1);
+    assert_true(data->test_buf_data.buf_id == htonl(1));
+    assert_true(data->test_buf_data.buf_time == 0);
+}
+
+static void
+test_packet_id_write_long(void **state)
+{
+    struct test_packet_id_write_data *data = *state;
+
+    now = 5010;
+    assert_true(packet_id_write(&data->pis, &data->test_buf, true, false));
+    assert(data->pis.id == 1);
+    assert(data->pis.time == now);
+    assert_true(data->test_buf_data.buf_id == htonl(1));
+    assert_true(data->test_buf_data.buf_time == htonl(now));
+}
+
+static void
+test_packet_id_write_short_prepend(void **state)
+{
+    struct test_packet_id_write_data *data = *state;
+
+    data->test_buf.offset = sizeof(packet_id_type);
+    now = 5010;
+    assert_true(packet_id_write(&data->pis, &data->test_buf, false, true));
+    assert_true(data->pis.id == 1);
+    assert_true(data->test_buf_data.buf_id == htonl(1));
+    assert_true(data->test_buf_data.buf_time == 0);
+}
+
+static void
+test_packet_id_write_long_prepend(void **state)
+{
+    struct test_packet_id_write_data *data = *state;
+
+    data->test_buf.offset = sizeof(data->test_buf_data);
+    now = 5010;
+    assert_true(packet_id_write(&data->pis, &data->test_buf, true, true));
+    assert(data->pis.id == 1);
+    assert(data->pis.time == now);
+    assert_true(data->test_buf_data.buf_id == htonl(1));
+    assert_true(data->test_buf_data.buf_time == htonl(now));
+}
+
+static void
+test_packet_id_write_short_wrap(void **state)
+{
+    struct test_packet_id_write_data *data = *state;
+
+    data->pis.id = ~0;
+    expect_assert_failure(
+            packet_id_write(&data->pis, &data->test_buf, false, false));
+}
+
+static void
+test_packet_id_write_long_wrap(void **state)
+{
+    struct test_packet_id_write_data *data = *state;
+
+    data->pis.id = ~0;
+    now = 5010;
+    assert_true(packet_id_write(&data->pis, &data->test_buf, true, false));
+    assert(data->pis.id == 1);
+    assert(data->pis.time == now);
+    assert_true(data->test_buf_data.buf_id == htonl(1));
+    assert_true(data->test_buf_data.buf_time == htonl(now));
+}
+
+int
+main(void) {
+    const struct CMUnitTest tests[] = {
+            cmocka_unit_test_setup_teardown(test_packet_id_write_short,
+                    test_packet_id_write_setup, test_packet_id_write_teardown),
+            cmocka_unit_test_setup_teardown(test_packet_id_write_long,
+                    test_packet_id_write_setup, test_packet_id_write_teardown),
+            cmocka_unit_test_setup_teardown(test_packet_id_write_short_prepend,
+                    test_packet_id_write_setup, test_packet_id_write_teardown),
+            cmocka_unit_test_setup_teardown(test_packet_id_write_long_prepend,
+                    test_packet_id_write_setup, test_packet_id_write_teardown),
+            cmocka_unit_test_setup_teardown(test_packet_id_write_short_wrap,
+                    test_packet_id_write_setup, test_packet_id_write_teardown),
+            cmocka_unit_test_setup_teardown(test_packet_id_write_long_wrap,
+                    test_packet_id_write_setup, test_packet_id_write_teardown),
+    };
+
+    return cmocka_run_group_tests_name("packet_id tests", tests, NULL, NULL);
+}
-- 
2.7.4


