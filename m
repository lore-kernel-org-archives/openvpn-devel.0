From: David Sommerseth <davids@...515...>
Date: Mon,  8 Aug 2016 21:28:06 +0200
Message-Id: <1470684488-21307-3-git-send-email-davids@...515...>
In-Reply-To: <1470684488-21307-1-git-send-email-davids@...515...>
References: <1470684488-21307-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v4 2/4] Re-implement the systemd support
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

This provides exactly the same systemd functionality which existed
before the query user infrastructure got implemented.

  [v4 - change disapproved &= syntax ]

  [v3 - Remove QUERY_USER_EXEC_ALTERNATIVE macro, simplify
        alternatives definition directly in console.h.  For
        now only depend on ENABLE_SYSTEMD]

  [v2 - Removed the QUERY_USER_FOREACH macro]

Signed-off-by: David Sommerseth <davids@...515...>
---
 configure.ac                  |   2 +-
 src/openvpn/Makefile.am       |   2 +-
 src/openvpn/console.h         |   6 +--
 src/openvpn/console_systemd.c | 115 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 5 deletions(-)
 create mode 100644 src/openvpn/console_systemd.c

diff --git a/configure.ac b/configure.ac
index 4f14ebd..c3088fd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1006,7 +1006,7 @@ fi
 dnl
 dnl Check for systemd
 dnl
-
+AM_CONDITIONAL([ENABLE_SYSTEMD], [test "${enable_systemd}" = "yes"])
 if test "$enable_systemd" = "yes" ; then
     PKG_CHECK_MODULES([libsystemd], [systemd libsystemd],
                       [],
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 8d6d39f..a306726 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -68,7 +68,7 @@ openvpn_SOURCES = \
 	memdbg.h \
 	misc.c misc.h \
 	platform.c platform.h \
-	console.c console.h console_builtin.c \
+	console.c console.h console_builtin.c console_systemd.c \
 	mroute.c mroute.h \
 	mss.c mss.h \
 	mstats.c mstats.h \
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 44d49ef..41f2b8c 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -76,7 +76,7 @@ void query_user_add (char *prompt, size_t prompt_len,
 bool query_user_exec_builtin ();
 
 
-#ifdef QUERY_USER_EXEC_ALTERNATIVE
+#if defined(ENABLE_SYSTEMD)
 /**
  * Executes a configured setup, using the compiled method for querying the user
  *
@@ -86,7 +86,7 @@ bool query_user_exec_builtin ();
  */
 bool query_user_exec ();
 
-#else  /* QUERY_USER_EXEC_ALTERNATIVE not defined*/
+#else  /* ENABLE_SYSTEMD not defined*/
 /**
  * Wrapper function enabling query_user_exec() if no alternative methods have
  * been enabled
@@ -96,7 +96,7 @@ static bool query_user_exec ()
 {
     return query_user_exec_builtin();
 }
-#endif  /* QUERY_USER_EXEC_ALTERNATIVE */
+#endif  /* defined(ENABLE_SYSTEMD) */
 
 
 /**
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
new file mode 100644
index 0000000..bf0f99d
--- /dev/null
+++ b/src/openvpn/console_systemd.c
@@ -0,0 +1,115 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
+ *  Copyright (C) 2016      David Sommerseth <davids@...515...>
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
+
+#ifdef ENABLE_SYSTEMD
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
+bool query_user_exec()
+{
+    bool ret = true;  /* Presume everything goes okay */
+    int i;
+
+    /* If systemd is not available, use the default built-in mechanism */
+    if (!check_systemd_running())
+    {
+        return query_user_exec_builtin();
+    }
+
+    /* Loop through the complete query setup and when needed, collect the information */
+    for (i = 0; i < QUERY_USER_NUMSLOTS && query_user[i].response != NULL; i++)
+    {
+	if (!get_console_input_systemd(query_user[i].prompt, query_user[i].echo,
+				       query_user[i].response, query_user[i].response_len) )
+	{
+	    /* Force the final result state to failed on failure */
+	    ret = false;
+	}
+    }
+
+    return ret;
+}
+
+#endif /* ENABLE_SYSTEMD */
-- 
1.8.3.1


