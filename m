From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 5 May 2017 19:44:51 +0200
Message-ID: <1494006291-3522-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <2b6a9a4a-2126-7c7d-25d3-23af23050a65@...1435...>
References: <2b6a9a4a-2126-7c7d-25d3-23af23050a65@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] cleanup: merge
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

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2 - rebased onto current master branch

 src/openvpn/crypto.c                      |  20 ++--
 src/openvpn/packet_id.c                   |  24 ++++-
 src/openvpn/packet_id.h                   |  35 +++----
 src/openvpn/tls_crypt.c                   |   6 +-
 tests/unit_tests/openvpn/Makefile.am      |  13 ++-
 tests/unit_tests/openvpn/mock_msg.c       |  15 ++-
 tests/unit_tests/openvpn/test_packet_id.c | 168 ++++++++++++++++++++++++++++++
 7 files changed, 228 insertions(+), 53 deletions(-)
 create mode 100644 tests/unit_tests/openvpn/test_packet_id.c

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 7b00601..f5250ac 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -85,7 +85,6 @@ openvpn_encrypt_aead(struct buffer *buf, struct buffer work,
     /* Prepare IV */
     {
         struct buffer iv_buffer;
-        struct packet_id_net pin;
         uint8_t iv[OPENVPN_MAX_IV_LENGTH] = {0};
         const int iv_len = cipher_ctx_iv_length(ctx->cipher);
 
@@ -94,8 +93,7 @@ openvpn_encrypt_aead(struct buffer *buf, struct buffer work,
         buf_set_write(&iv_buffer, iv, iv_len);
 
         /* IV starts with packet id to make the IV unique for packet */
-        packet_id_alloc_outgoing(&opt->packet_id.send, &pin, false);
-        ASSERT(packet_id_write(&pin, &iv_buffer, false, false));
+        ASSERT(packet_id_write(&opt->packet_id.send, &iv_buffer, false, false));
 
         /* Remainder of IV consists of implicit part (unique per session) */
         ASSERT(buf_write(&iv_buffer, ctx->implicit_iv, ctx->implicit_iv_len));
@@ -195,22 +193,20 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
                 /* Put packet ID in plaintext buffer */
                 if (packet_id_initialized(&opt->packet_id))
                 {
-                    struct packet_id_net pin;
-                    packet_id_alloc_outgoing(&opt->packet_id.send, &pin, BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM));
-                    ASSERT(packet_id_write(&pin, buf, BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM), true));
+                    ASSERT(packet_id_write(&opt->packet_id.send, buf,
+                                           opt->flags & CO_PACKET_ID_LONG_FORM,
+                                           true));
                 }
             }
             else if (cipher_kt_mode_ofb_cfb(cipher_kt))
             {
-                struct packet_id_net pin;
                 struct buffer b;
 
                 /* packet-ID required for this mode. */
                 ASSERT(packet_id_initialized(&opt->packet_id));
 
-                packet_id_alloc_outgoing(&opt->packet_id.send, &pin, true);
                 buf_set_write(&b, iv_buf, iv_size);
-                ASSERT(packet_id_write(&pin, &b, true, false));
+                ASSERT(packet_id_write(&opt->packet_id.send, &b, true, false));
             }
             else /* We only support CBC, CFB, or OFB modes right now */
             {
@@ -257,9 +253,9 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
         {
             if (packet_id_initialized(&opt->packet_id))
             {
-                struct packet_id_net pin;
-                packet_id_alloc_outgoing(&opt->packet_id.send, &pin, BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM));
-                ASSERT(packet_id_write(&pin, buf, BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM), true));
+                ASSERT(packet_id_write(&opt->packet_id.send, buf,
+                        BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM),
+                        true));
             }
             if (ctx->hmac)
             {
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index e34c228..5175fb0 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -325,12 +325,30 @@ packet_id_read(struct packet_id_net *pin, struct buffer *buf, bool long_form)
     return true;
 }
 
+static void
+packet_id_send_update(struct packet_id_send *p, bool long_form)
+{
+    if (!p->time)
+    {
+        p->time = now;
+    }
+    p->id++;
+    if (!p->id)
+    {
+        ASSERT(long_form);
+        p->time = now;
+        p->id = 1;
+    }
+}
+
 bool
-packet_id_write(const struct packet_id_net *pin, struct buffer *buf, bool long_form, bool prepend)
+packet_id_write(struct packet_id_send *p, struct buffer *buf, bool long_form,
+        bool prepend)
 {
-    packet_id_type net_id = htonpid(pin->id);
-    net_time_t net_time = htontime(pin->time);
+    packet_id_send_update(p, long_form);
 
+    const packet_id_type net_id = htonpid(p->id);
+    const net_time_t net_time = htontime(p->time);
     if (prepend)
     {
         if (long_form)
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index ecc25a6..109e56a 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -254,7 +254,18 @@ const char *packet_id_persist_print(const struct packet_id_persist *p, struct gc
 
 bool packet_id_read(struct packet_id_net *pin, struct buffer *buf, bool long_form);
 
-bool packet_id_write(const struct packet_id_net *pin, struct buffer *buf, bool long_form, bool prepend);
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
+bool packet_id_write(struct packet_id_send *p, struct buffer *buf,
+        bool long_form, bool prepend);
 
 /*
  * Inline functions.
@@ -304,28 +315,6 @@ packet_id_close_to_wrapping(const struct packet_id_send *p)
     return p->id >= PACKET_ID_WRAP_TRIGGER;
 }
 
-/*
- * Allocate an outgoing packet id.
- * Sequence number ranges from 1 to 2^32-1.
- * In long_form, a time_t is added as well.
- */
-static inline void
-packet_id_alloc_outgoing(struct packet_id_send *p, struct packet_id_net *pin, bool long_form)
-{
-    if (!p->time)
-    {
-        p->time = now;
-    }
-    pin->id = ++p->id;
-    if (!pin->id)
-    {
-        ASSERT(long_form);
-        p->time = now;
-        pin->id = p->id = 1;
-    }
-    pin->time = p->time;
-}
-
 static inline bool
 check_timestamp_delta(time_t remote, unsigned int max_delta)
 {
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index e2fdbed..e47d25c 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -98,11 +98,7 @@ tls_crypt_wrap(const struct buffer *src, struct buffer *dst,
          format_hex(BPTR(src), BLEN(src), 80, &gc));
 
     /* Get packet ID */
-    {
-        struct packet_id_net pin;
-        packet_id_alloc_outgoing(&opt->packet_id.send, &pin, true);
-        packet_id_write(&pin, dst, true, false);
-    }
+    ASSERT(packet_id_write(&opt->packet_id.send, dst, true, false));
 
     dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s",
          format_hex(BPTR(dst), BLEN(dst), 0, &gc));
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index b902b20..5d7123e 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -3,7 +3,7 @@ AUTOMAKE_OPTIONS = foreign
 check_PROGRAMS=
 
 if HAVE_LD_WRAP_SUPPORT
-check_PROGRAMS += argv_testdriver buffer_testdriver
+check_PROGRAMS += argv_testdriver buffer_testdriver packet_id_testdriver
 endif
 
 if ENABLE_CRYPTO
@@ -31,6 +31,17 @@ buffer_testdriver_SOURCES = test_buffer.c mock_msg.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/platform.c
 
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
+
 tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index eb0d5e9..060588f 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -29,9 +29,12 @@
 #endif
 
 #include <stdarg.h>
-#include <stdbool.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
 
 #include "errlevel.h"
 #include "error.h"
@@ -70,14 +73,8 @@ x_msg(const unsigned int flags, const char *format, ...)
 void
 assert_failed(const char *filename, int line, const char *condition)
 {
-    if (condition)
-    {
-        printf("Assertion failed at %s:%d (%s)", filename, line, condition);
-    }
-    else
-    {
-        printf("Assertion failed at %s:%d", filename, line);
-    }
+    mock_assert(false, condition ? condition : "", filename, line);
+    /* Keep compiler happy.  Should not happen, mock_assert() does not return */
     exit(1);
 }
 
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
new file mode 100644
index 0000000..5627a5b
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -0,0 +1,168 @@
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


