From: Steffan Karger <steffan@...1856...>
Date: Thu, 15 Dec 2016 22:46:06 +0100
Message-Id: <1481838366-32335-1-git-send-email-steffan@...1856...>
In-Reply-To: <1481827955-18896-1-git-send-email-steffan@...1856...>
References: <1481827955-18896-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v2] Don't reopen tun if cipher changes
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

When the pulled options change, OpenVPN will attempt to reopen the tun
device.  That might fail if the process has already dropper privileges,
and is not needed unless the tun MTU is changed.  This patch therefore
ignores the cipher value for the digest if a fixed tun-mtu is used.

Additionally, this patch changes the md_ctx_update() call to include the
trailing zero byte of each option, to make sure that parsing "foo,bar"
results in a different hash than "foobar".  (Sorry for not catching that
during the review...)

The unit tests are a bit lame, but it secretly serves as a way to lower
the bar for adding more buffer.c unit tests.

Trac: #761

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2: check for prefix properly, add unit tests for prefix check.

 src/openvpn/buffer.h                   |  8 +++++
 src/openvpn/push.c                     | 15 ++++++---
 tests/unit_tests/openvpn/Makefile.am   |  8 ++++-
 tests/unit_tests/openvpn/test_buffer.c | 56 ++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 5 deletions(-)
 create mode 100644 tests/unit_tests/openvpn/test_buffer.c

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 6bd5e20..a1a130c 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -923,6 +923,14 @@ const char *string_mod_const(const char *str,
 
 void string_replace_leading(char *str, const char match, const char replace);
 
+/** Return true iff str starts with prefix */
+static inline bool
+strprefix(const char *str, const char *prefix)
+{
+    return 0 == strncmp(str, prefix, strlen(prefix));
+}
+
+
 #ifdef CHARACTER_CLASS_DEBUG
 void character_class_debug(void);
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 34c65c4..77adf84 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -677,17 +677,23 @@ process_incoming_push_request(struct context *c)
 #endif /* if P2MP_SERVER */
 
 static void
-push_update_digest(md_ctx_t *ctx, struct buffer *buf)
+push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct options *opt)
 {
     char line[OPTION_PARM_SIZE];
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
         /* peer-id might change on restart and this should not trigger reopening tun */
-        if (strstr(line, "peer-id ") != line)
+        if (strprefix(line, "peer-id "))
         {
-            md_ctx_update(ctx, (const uint8_t *) line, strlen(line));
+            continue;
+        }
+        /* tun reopen only needed if cipher change can change tun MTU */
+        if (strprefix(line, "cipher ") && !opt->ce.tun_mtu_defined)
+        {
+            continue;
         }
     }
+    md_ctx_update(ctx, (const uint8_t *) line, strlen(line)+1);
 }
 
 int
@@ -730,7 +736,8 @@ process_incoming_push_msg(struct context *c,
                                    option_types_found,
                                    c->c2.es))
             {
-                push_update_digest(&c->c2.pulled_options_state, &buf_orig);
+                push_update_digest(&c->c2.pulled_options_state, &buf_orig,
+                                   &c->options);
                 switch (c->options.push_continuation)
                 {
                     case 0:
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 632ff58..fafe6b2 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -1,6 +1,6 @@
 AUTOMAKE_OPTIONS = foreign
 
-check_PROGRAMS = argv_testdriver
+check_PROGRAMS = argv_testdriver buffer_testdriver
 
 if ENABLE_CRYPTO
 check_PROGRAMS += tls_crypt_testdriver
@@ -21,6 +21,12 @@ argv_testdriver_SOURCES = test_argv.c mock_msg.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/argv.c
 
+buffer_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
+buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line
+buffer_testdriver_SOURCES = test_buffer.c mock_msg.c \
+	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/platform.c
+
 tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
new file mode 100644
index 0000000..5d25437
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -0,0 +1,56 @@
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
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "buffer.h"
+
+static void
+buffer_strprefix(void **state)
+{
+    assert_true(strprefix("123456", "123456"));
+    assert_true(strprefix("123456", "123"));
+    assert_true(strprefix("123456", ""));
+    assert_false(strprefix("123456", "456"));
+    assert_false(strprefix("12", "123"));
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(buffer_strprefix),
+    };
+
+    return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);
+}
-- 
2.7.4


