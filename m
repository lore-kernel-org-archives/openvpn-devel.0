From: Arne Schwabe <arne@...1227...>
Date: Fri, 20 May 2022 23:32:49 +0200
Message-Id: <20220520213250.3126372-4-arne@...1227...>
In-Reply-To: <20220520213250.3126372-1-arne@...1227...>
References: <20220520213250.3126372-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 3/4] Implement AUTH_FAIL,
 TEMP message support
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

This allows a server to indicate a temporary problem on the server and
allows the server to indicate how to proceed (i.e. move to the next server,
retry the same server, wait a certain time,...)

This adds options_utils.c/h to be able to unit test the new function.

Patch v2: Improve documentation, format man page better, comment that
          protocol-flags is not a user usable option.
---
 doc/man-sections/script-options.rst  |  36 ++++++++++
 src/openvpn/Makefile.am              |   1 +
 src/openvpn/init.c                   |   9 ++-
 src/openvpn/openvpn.vcxproj          |   2 +
 src/openvpn/openvpn.vcxproj.filters  |   3 +
 src/openvpn/options.h                |   9 ++-
 src/openvpn/options_util.c           | 104 +++++++++++++++++++++++++++
 src/openvpn/options_util.h           |  33 +++++++++
 src/openvpn/push.c                   |  11 ++-
 src/openvpn/ssl.c                    |  13 ++--
 src/openvpn/ssl.h                    |   3 +
 tests/unit_tests/openvpn/Makefile.am |   1 +
 tests/unit_tests/openvpn/test_misc.c |  49 +++++++++++++
 13 files changed, 266 insertions(+), 8 deletions(-)
 create mode 100644 src/openvpn/options_util.c
 create mode 100644 src/openvpn/options_util.h

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 6be0686d7..8a58eaad0 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -97,6 +97,42 @@ SCRIPT HOOKS
   the authentication, a :code:`1` or :code:`0` must be written to the
   file specified by the :code:`auth_control_file`.
 
+  If the file specified by :code:`auth_failed_reason` exists and has non-empty
+  content, the content of this file will be used as AUTH_FAILED message. To
+  avoid race conditions, this file should be written before
+  :code:`auth_control_file`.
+
+  This auth fail reason can be something simple like "User has been permanently
+  disabled" but there are also some special auth failed messages.
+
+  The ``TEMP`` message indicates that the authentication
+  temporarily failed and that the client should continue to retry to connect.
+  The server can optionally give a user readable message and hint the client a
+  behavior how to proceed. The keywords of the ``AUTH_FAILED,TEMP`` message
+  are comma separated keys/values and provide a hint to the client how to
+  proceed. Currently defined keywords are:
+
+  ``backoff`` :code:`s`
+        instructs the client to wait at least :code:`s` seconds before the next
+        connection attempt. If the client already uses a higher delay for
+        reconnection attempt, the delay will not be shortened.
+
+  ``advance addr``
+        Instructs the client to reconnect to the next (IP) address of the
+        current server.
+
+  ``advance remote``
+        Instructs the client to skip the remaining IP addresses of the current
+        server and instead connect to the next server specified in the
+        configuration file.
+
+  ``advance no``
+        Instructs the client to retry connecting to the same server again.
+
+  For example, the message ``TEMP[backoff 42,advance no]: No free IP addresses``
+  indicates that the VPN connection can currently not succeed and instructs
+  the client to retry in 42 seconds again.
+
   When deferred authentication is in use, the script can also request
   pending authentication by writing to the file specified by the
   :code:`auth_pending_file`. The first line must be the timeout in
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 577294804..a619aac38 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -95,6 +95,7 @@ openvpn_SOURCES = \
 	pkcs11_mbedtls.c \
 	openvpn.c openvpn.h \
 	options.c options.h \
+    options_util.c options_util.h \
 	otime.c otime.h \
 	packet_id.c packet_id.h \
 	perf.c perf.h \
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b0c62a859..b2a1e92a5 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -483,13 +483,15 @@ next_connection_entry(struct context *c)
             /* Check if there is another resolved address to try for
              * the current connection */
             if (c->c1.link_socket_addr.current_remote
-                && c->c1.link_socket_addr.current_remote->ai_next)
+                && c->c1.link_socket_addr.current_remote->ai_next
+                && !c->options.advance_next_remote)
             {
                 c->c1.link_socket_addr.current_remote =
                     c->c1.link_socket_addr.current_remote->ai_next;
             }
             else
             {
+                c->options.advance_next_remote = false;
                 /* FIXME (schwabe) fix the persist-remote-ip option for real,
                  * this is broken probably ever since connection lists and multiple
                  * remote existed
@@ -2357,6 +2359,11 @@ socket_restart_pause(struct context *c)
             /* sec is less than 2^16; we can left shift it by up to 15 bits without overflow */
             sec = max_int(sec, 1) << min_int(backoff, 15);
         }
+        if (c->options.server_backoff_time)
+        {
+            sec = max_int(sec, c->options.server_backoff_time);
+            c->options.server_backoff_time = 0;
+        }
 
         if (sec > c->options.ce.connect_retry_seconds_max)
         {
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 860ef8926..e82be2698 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -306,6 +306,7 @@
     <ClCompile Include="occ.c" />
     <ClCompile Include="openvpn.c" />
     <ClCompile Include="options.c" />
+    <ClCompile Include="options_util.c" />
     <ClCompile Include="otime.c" />
     <ClCompile Include="packet_id.c" />
     <ClCompile Include="perf.c" />
@@ -395,6 +396,7 @@
     <ClInclude Include="occ.h" />
     <ClInclude Include="openvpn.h" />
     <ClInclude Include="options.h" />
+    <ClInclude Include="options_util.h" />
     <ClInclude Include="otime.h" />
     <ClInclude Include="packet_id.h" />
     <ClInclude Include="perf.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index f76e59235..616b71ab2 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -395,6 +395,9 @@
     <ClInclude Include="options.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="options_util.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
     <ClInclude Include="otime.h">
       <Filter>Header Files</Filter>
     </ClInclude>
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c2937dc37..0c1a31389 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -272,10 +272,17 @@ struct options
     struct connection_list *connection_list;
 
     struct remote_list *remote_list;
-    /* Do not advanced the connection or remote addr list*/
+    /* Do not advance the connection or remote addr list*/
     bool no_advance;
+    /* Advance directly to the next remote, skipping remaining addresses of the
+     * current remote */
+    bool advance_next_remote;
     /* Counts the number of unsuccessful connection attempts */
     unsigned int unsuccessful_attempts;
+    /* the server can suggest a backoff time to the client, it
+     * will still be capped by the max timeout between connections
+     * (300s by default) */
+    int server_backoff_time;
 
 #if ENABLE_MANAGEMENT
     struct http_proxy_options *http_proxy_override;
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
new file mode 100644
index 000000000..d8a7e2343
--- /dev/null
+++ b/src/openvpn/options_util.c
@@ -0,0 +1,104 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
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
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
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
+#include "options_util.h"
+
+const char *
+parse_auth_failed_temp(struct options *o, const struct buffer *buf)
+{
+    struct gc_arena gc = gc_new();
+    char *m = string_alloc(BSTR(buf), &gc);
+    /* skip TEMP */
+    m += strlen("TEMP");
+    const char *message = BSTR(buf) + 4;
+
+
+    /* Check if the message uses the TEMP[flags]: message format*/
+    char *endofflags = strstr(m, "]");
+
+    /* Temporary failure from the server */
+    if (m[0] == '[' && endofflags)
+    {
+        message = strstr(BSTR(buf), "]") + 1;
+        /* null terminate the substring to only looks for flags between [ and ] */
+        *endofflags = '\x00';
+        const char *token = strtok(m, "[,");
+        while (token)
+        {
+            if (!strncmp(token, "backoff ", strlen("backoff ")))
+            {
+                if (sscanf(token, "backoff %d", &o->server_backoff_time) != 1)
+                {
+                    msg(D_PUSH, "invalid AUTH_FAIL,TEMP flag: %s", token);
+                    o->server_backoff_time = 0;
+                }
+            }
+            else if (!strncmp(token, "advance ", strlen("advance ")))
+            {
+                token += strlen("advance ");
+                if (!strcmp(token, "no"))
+                {
+                    o->no_advance = true;
+                }
+                else if (!strcmp(token, "remote"))
+                {
+                    o->advance_next_remote = true;
+                    o->no_advance = false;
+                }
+                else if (!strcmp(token, "addr"))
+                {
+                    /* Go on to the next remote */
+                    o->no_advance = false;
+                }
+            }
+            else
+            {
+                msg(D_PUSH_ERRORS, "WARNING: unknown AUTH_FAIL,TEMP flag: %s", token);
+            }
+            token = strtok(NULL, "[,");
+        }
+    }
+
+    /* Look for the message in the original buffer to safely be
+     * able to return it */
+    if (!message || message[0] != ':')
+    {
+        message = "";
+    }
+    else
+    {
+        /* Skip the : at the beginning */
+        message += 1;
+    }
+    gc_free(&gc);
+    return message;
+}
\ No newline at end of file
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
new file mode 100644
index 000000000..9785bb239
--- /dev/null
+++ b/src/openvpn/options_util.h
@@ -0,0 +1,33 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
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
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef OPTIONS_UTIL_H_
+#define OPTIONS_UTIL_H_
+
+#include "options.h"
+
+const char *
+parse_auth_failed_temp(struct options *o, const struct buffer *buf);
+
+#endif
\ No newline at end of file
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 1c4e637e4..3b3dce642 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -38,6 +38,7 @@
 
 #include "memdbg.h"
 #include "ssl_util.h"
+#include "options_util.h"
 
 static char push_reply_cmd[] = "PUSH_REPLY";
 
@@ -51,7 +52,6 @@ void
 receive_auth_failed(struct context *c, const struct buffer *buffer)
 {
     msg(M_VERB0, "AUTH: Received control message: %s", BSTR(buffer));
-    c->options.no_advance = true;
 
     if (!c->options.pull)
     {
@@ -64,15 +64,22 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
      * contains further flags */
     bool authfail_extended = buf_string_compare_advance(&buf, "AUTH_FAILED,");
 
+    if (authfail_extended && buf_string_match_head_str(&buf, "TEMP"))
+    {
+        parse_auth_failed_temp(&c->options, &buf);
+        c->sig->signal_received = SIGUSR1;
+        c->sig->signal_text = "auth-temp-failure (server temporary reject)";
+    }
     /* Before checking how to react on AUTH_FAILED, first check if the
      * failed auth might be the result of an expired auth-token.
      * Note that a server restart will trigger a generic AUTH_FAILED
      * instead an AUTH_FAILED,SESSION so handle all AUTH_FAILED message
      * identical for this scenario */
-    if (ssl_clean_auth_token())
+    else if (ssl_clean_auth_token())
     {
         c->sig->signal_received = SIGUSR1;     /* SOFT-SIGUSR1 -- Auth failure error */
         c->sig->signal_text = "auth-failure (auth-token)";
+        c->options.no_advance = true;
     }
     else
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4506b7504..f11b3afb3 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1943,14 +1943,19 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         /* support for exit notify via control channel */
         iv_proto |= IV_PROTO_CC_EXIT_NOTIFY;
 
-        /* support for receiving push_reply before sending
-         * push request, also signal that the client wants
-         * to get push-reply messages without without requiring a round
-         * trip for a push request message*/
         if (session->opt->pull)
         {
+            /* support for receiving push_reply before sending
+             * push request, also signal that the client wants
+             * to get push-reply messages without requiring a round
+             * trip for a push request message*/
             iv_proto |= IV_PROTO_REQUEST_PUSH;
+
+            /* Support keywords in the AUTH_PENDING control message */
             iv_proto |= IV_PROTO_AUTH_PENDING_KW;
+
+            /* support for AUTH_FAIL,TEMP control message */
+            iv_proto |= IV_PROTO_AUTH_FAIL_TEMP;
         }
 
         /* support for Negotiable Crypto Parameters */
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 1b8b736b9..981bb3403 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -93,6 +93,9 @@
  * result. */
 #define IV_PROTO_NCP_P2P         (1<<5)
 
+/** Support for AUTH_FAIL,TEMP messages */
+#define IV_PROTO_AUTH_FAIL_TEMP  (1<<6)
+
 /** Support for explicit exit notify via control channel */
 #define IV_PROTO_CC_EXIT_NOTIFY  (1<<7)
 
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 63b53a6ac..65cf9549c 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -176,5 +176,6 @@ misc_testdriver_LDFLAGS = @TEST_LDFLAGS@
 misc_testdriver_SOURCES = test_misc.c mock_msg.c \
     mock_get_random.c \
 	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/options_util.c \
 	$(openvpn_srcdir)/ssl_util.c \
 	$(openvpn_srcdir)/platform.c
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 636fc45d6..802307fb7 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -37,6 +37,7 @@
 #include <cmocka.h>
 
 #include "ssl_util.h"
+#include "options_util.h"
 
 static void
 test_compat_lzo_string(void **state)
@@ -72,8 +73,56 @@ test_compat_lzo_string(void **state)
     gc_free(&gc);
 }
 
+static void
+test_auth_fail_temp_no_flags(void **state)
+{
+    struct options o;
+
+    struct buffer buf;
+    const char *teststr = "TEMP:There are no flags here [really not]";
+
+    buf_set_read(&buf, (uint8_t *)teststr,strlen(teststr));
+
+    const char *msg = parse_auth_failed_temp(&o, &buf);
+    assert_string_equal(msg, "There are no flags here [really not]");
+}
+
+static void
+test_auth_fail_temp_flags(void **state)
+{
+    struct options o;
+
+    struct buffer buf;
+    const char *teststr = "TEMP[backoff 42,advance no]";
+
+    buf_set_read(&buf, (uint8_t *)teststr,strlen(teststr));
+
+    const char *msg = parse_auth_failed_temp(&o, &buf);
+    assert_string_equal(msg, "");
+    assert_int_equal(o.server_backoff_time, 42);
+    assert_int_equal(o.no_advance, true);
+}
+
+static void
+test_auth_fail_temp_flags_msg(void **state)
+{
+    struct options o;
+
+    struct buffer buf;
+    const char *teststr = "TEMP[advance remote,backoff 77]:go round and round";
+
+    buf_set_read(&buf, (uint8_t *)teststr,strlen(teststr));
+
+    const char *msg = parse_auth_failed_temp(&o, &buf);
+    assert_string_equal(msg, "go round and round");
+    assert_int_equal(o.server_backoff_time, 77);
+}
+
 const struct CMUnitTest misc_tests[] = {
     cmocka_unit_test(test_compat_lzo_string),
+    cmocka_unit_test(test_auth_fail_temp_no_flags),
+    cmocka_unit_test(test_auth_fail_temp_flags),
+    cmocka_unit_test(test_auth_fail_temp_flags_msg),
 };
 
 int
-- 
2.32.0 (Apple Git-132)


