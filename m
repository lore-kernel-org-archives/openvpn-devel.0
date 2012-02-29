From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:12:16 +0200
Message-Id: <1330546342-17794-47-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 46/52] build: move daemon() emulation into
	compat
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/compat/Makefile.am     |    3 +-
 src/compat/compat-daemon.c |  100 ++++++++++++++++++++++++++++++++++++++++++++
 src/compat/compat.h        |    4 ++
 src/compat/compat.vcproj   |    4 ++
 src/openvpn/init.c         |    2 +-
 src/openvpn/misc.c         |   32 --------------
 src/openvpn/misc.h         |    4 --
 7 files changed, 111 insertions(+), 38 deletions(-)
 create mode 100644 src/compat/compat-daemon.c

diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 5e9db5f..c8a92ce 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -21,4 +21,5 @@ libcompat_la_SOURCES = \
 	compat.h \
 	compat-dirname.c \
 	compat-basename.c \
-	compat-gettimeofday.c
+	compat-gettimeofday.c \
+	compat-daemon.c
diff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c
new file mode 100644
index 0000000..dde96a2
--- /dev/null
+++ b/src/compat/compat-daemon.c
@@ -0,0 +1,100 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
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
+#ifndef HAVE_DAEMON
+
+#ifdef HAVE_UNISTD_H
+#include <unistd.h>
+#endif
+
+#ifdef HAVE_STDLIB_H
+#include <stdlib.h>
+#endif
+
+#ifdef HAVE_SYS_TYPES_H
+#include <sys/types.h>
+#endif
+
+#ifdef HAVE_SYS_STAT_H
+#include <sys/stat.h>
+#endif
+
+#ifdef HAVE_FCNTL_H
+#include <fcntl.h>
+#endif
+
+#ifdef HAVE_ERRNO_H
+#include <errno.h>
+#endif
+
+int
+daemon(int nochdir, int noclose)
+{
+#if defined(HAVE_FORK) && defined(HAVE_SETSID)
+	switch (fork()) {
+		case -1:
+			return (-1);
+		case 0:
+		break;
+		default:
+			exit(0);
+	}
+
+	if (setsid() == -1)
+		return (-1);
+
+	if (!nochdir)
+		chdir("/");
+
+	if (!noclose) {
+#if defined(HAVE_DUP) && defined(HAVE_DUP2)
+		int fd;
+		if ((fd = open ("/dev/null", O_RDWR, 0)) != -1) {
+			dup2 (fd, 0);
+			dup2 (fd, 1);
+			dup2 (fd, 2);
+			if (fd > 2) {
+				close (fd);
+			}
+		}
+#endif
+	}
+
+	return 0;
+#else
+	(void)nochdir;
+	(void)noclose;
+	errno = EFAULT;
+	return -1;
+#endif
+}
+
+#endif
+
diff --git a/src/compat/compat.h b/src/compat/compat.h
index 3f9ac31..e9d51b8 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -46,4 +46,8 @@ char * basename(char *str);
 int gettimeofday (struct timeval *tv, void *tz);
 #endif
 
+#ifndef HAVE_DAEMON
+int daemon(int nochdir, int noclose);
+#endif
+
 #endif /* COMPAT_H */
diff --git a/src/compat/compat.vcproj b/src/compat/compat.vcproj
index 235163c..efdecb4 100644
--- a/src/compat/compat.vcproj
+++ b/src/compat/compat.vcproj
@@ -162,6 +162,10 @@
 				RelativePath=".\compat-gettimeofday.c"
 				>
 			</File>
+			<File
+				RelativePath=".\compat-daemon.c"
+				>
+			</File>
 		</Filter>
 		<Filter
 			Name="Header Files"
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e7edb05..bba3cf8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -993,7 +993,7 @@ possibly_become_daemon (const struct options *options, const bool first_time)
     {
       ASSERT (!options->inetd);
       if (daemon (options->cd_dir != NULL, options->log) < 0)
-	msg (M_ERR, "daemon() failed");
+	msg (M_ERR, "daemon() failed or unsupported");
       restore_signal_state ();
       if (options->log)
 	set_std_files_to_null (true);
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 898a183..07beaf0 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -301,38 +301,6 @@ do_mlockall(bool print_msg)
 #endif
 }
 
-#ifndef HAVE_DAEMON
-
-int
-daemon(int nochdir, int noclose)
-{
-#if defined(HAVE_FORK) && defined(HAVE_SETSID)
-  switch (fork())
-    {
-    case -1:
-      return (-1);
-    case 0:
-      break;
-    default:
-      openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); /* exit point */
-    }
-
-  if (setsid() == -1)
-    return (-1);
-
-  if (!nochdir)
-    openvpn_chdir ("/");
-
-  if (!noclose)
-    set_std_files_to_null (false);
-#else
-  msg (M_FATAL, "Sorry but I can't become a daemon because this operating system doesn't appear to support either the daemon() or fork() system calls");
-#endif
-  return (0);
-}
-
-#endif
-
 /*
  * Set standard file descriptors to /dev/null
  */
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 9fa8106..9bb2fa2 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -115,10 +115,6 @@ unsigned int openvpn_getpid (void);
 
 void do_mlockall (bool print_msg); /* Disable paging */
 
-#ifndef HAVE_DAEMON
-int daemon (int nochdir, int noclose);
-#endif
-
 /* check file protections */
 void warn_if_group_others_accessible(const char* filename);
 
-- 
1.7.3.4


