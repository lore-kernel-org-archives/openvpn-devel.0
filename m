From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 25 Sep 2023 11:44:09 +0200
Message-Id: <20230925094409.40429-1-frank@...2641...>
In-Reply-To: <gerrit.1689947729000.I8c8fe298eb30e211279f3fc010584b9d3bc14b4a@...2715...>
References: <gerrit.1689947729000.I8c8fe298eb30e211279f3fc010584b9d3bc14b4a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Mock openvpn_exece on win32 also for
 test_tls_crypt
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
Cc: Arne Schwabe <arne@...1227...>, Heiko Hund <heiko@...515...>

From: Arne Schwabe <arne@...1227...>

This function is needed to commpile on win32 as run_command.c defines it
on Unix Linux but on windows it is defined in win32.c which pulls in too
many other unresolvable symbols.

Patch v2: Also add mock_win32_execve.c to automake files

Change-Id: I8c8fe298eb30e211279f3fc010584b9d3bc14b4a
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Heiko Hund <heiko@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
(cherry picked from commit ede590e57c96c2b16d9bf462c4b1dd967b37c432)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/313
This mail reflects revision 2 of this Change.
Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@...515...>

        
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 650126c..dd3985d 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -77,7 +77,7 @@
 pkt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn
 pkt_testdriver_LDFLAGS = @TEST_LDFLAGS@
-pkt_testdriver_SOURCES = test_pkt.c mock_msg.c mock_msg.h \
+pkt_testdriver_SOURCES = test_pkt.c mock_msg.c mock_msg.h mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -104,6 +104,7 @@
 	-Wl,--wrap=parse_line \
 	-Wl,--wrap=rand_bytes
 tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c mock_msg.h \
+	mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
diff --git a/tests/unit_tests/openvpn/mock_win32_execve.c b/tests/unit_tests/openvpn/mock_win32_execve.c
new file mode 100644
index 0000000..4d37ebe
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_win32_execve.c
@@ -0,0 +1,37 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2023 Arne Schwabe <arne@...1227...>
+ *
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
+#include "config.h"
+#include "syshead.h"
+
+#include "win32.h"
+
+#ifdef _WIN32
+int
+openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags)
+{
+    ASSERT(0);
+}
+#endif
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 736f131..eb69829 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -71,14 +71,6 @@
     return "dummy print_link_socket_actual from unit test";
 }
 
-#ifdef _WIN32
-int
-openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags)
-{
-    ASSERT(0);
-}
-#endif
-
 struct test_pkt_context {
     struct tls_auth_standalone tas_tls_auth;
     struct tls_auth_standalone tas_crypt;

