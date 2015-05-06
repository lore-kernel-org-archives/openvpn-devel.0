From: David Sommerseth <openvpn.list@...1114...>
Date: Wed,  6 May 2015 22:06:24 +0200
Message-Id: <1430942786-31419-3-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1430942786-31419-1-git-send-email-openvpn.list@...1114...>
References: <1430942786-31419-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCHv2 2/4] Re-implement the systemd support
	using the new query user API
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

From: David Sommerseth <davids@...1347...>

This provides exactly the same systemd functionality which existed
before the query user infrastructure got implemented.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac                  |   2 +-
 src/openvpn/Makefile.am       |  13 +++++
 src/openvpn/console_systemd.c | 112 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 src/openvpn/console_systemd.c

diff --git a/configure.ac b/configure.ac
index 9132468..4e9fbfc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -993,7 +993,7 @@ fi
 dnl
 dnl Check for systemd
 dnl
-
+AM_CONDITIONAL([ENABLE_SYSTEMD], [test "${enable_systemd}" = "yes"])
 if test "$enable_systemd" = "yes" ; then
     PKG_CHECK_MODULES([libsystemd], [systemd libsystemd],
                       [],
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index e07389f..29cafd7 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -117,6 +117,19 @@ openvpn_SOURCES = \
 	tun.c tun.h \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
+
+
+if ENABLE_SYSTEMD
+#
+# If --enable-systemd have been used, build the alternative systemd mechanism
+# The CFLAGS macro set here ensures the alternative mechanism is being used.
+# See console.h for more information.
+#
+AM_CFLAGS += -DQUERY_USER_EXEC_ALTERNATIVE
+openvpn_SOURCES += console_systemd.c
+endif
+
+
 openvpn_LDADD = \
 	$(top_builddir)/src/compat/libcompat.la \
 	$(SOCKETS_LIBS) \
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
new file mode 100644
index 0000000..1fb0891
--- /dev/null
+++ b/src/openvpn/console_systemd.c
@@ -0,0 +1,112 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
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
+/**
+ * @file Alternative method to query for user input, using systemd
+ *
+ */
+
+#include "config.h"
+#include "syshead.h"
+#include "console.h"
+#include "misc.h"
+
+#include <systemd/sd-daemon.h>
+
+/*
+ * is systemd running
+ */
+
+static bool
+check_systemd_running ()
+{
+    struct stat c;
+
+    /* We simply test whether the systemd cgroup hierarchy is
+     * mounted, as well as the systemd-ask-password executable
+     * being available */
+
+    return (sd_booted() > 0)
+	&& (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) == 0);
+
+}
+
+static bool
+get_console_input_systemd (const char *prompt, const bool echo, char *input, const int capacity)
+{
+    int std_out;
+    bool ret = false;
+    struct argv argv;
+
+    argv_init (&argv);
+    argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
+    argv_printf_cat (&argv, "%s", prompt);
+
+    if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
+	return false;
+    }
+    CLEAR (*input);
+    if (read (std_out, input, capacity) != 0)
+    {
+	chomp (input);
+	ret = true;
+    }
+    close (std_out);
+
+    argv_reset (&argv);
+
+    return ret;
+}
+
+/**
+ *  Systemd aware implementation of query_user_exec().  If systemd is not running
+ *  it will fall back to use query_user_exec_builtin() instead.
+ *
+ */
+bool query_user_exec(struct query_user * setup)
+{
+    struct query_user *p;
+    bool ret = true;
+
+    ASSERT( setup != NULL );
+
+    /* If systemd is not available, use the default built-in mechanism */
+    if (!check_systemd_running())
+    {
+        return query_user_exec_builtin(setup);
+    }
+
+    /* Loop through the complete query setup and when needed, collect the information */
+    QUERY_USER_FOREACH(setup, p)
+    {
+        if( p->query )
+        {
+            ret &= get_console_input_systemd(p->prompt, p->echo, p->response, p->response_len);
+        } else {
+            msg(M_INFO|M_NOPREFIX, "%s", p->prompt);
+        }
+    }
+
+    return ret;
+}
-- 
1.8.3.1


