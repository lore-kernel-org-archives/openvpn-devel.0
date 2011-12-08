MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Thu, 08 Dec 2011 01:13:49 +0100
Message-id: <1323303229-31079-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Add a wrapper for access() when compiling
	via Visual Studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

This adds the access() function as a wrapper for _access() to be
able to compile OpenVPN via Visual Studio.  It also adds the required
macros which used in POSIX environments (R_OK, W_OK, X_OK, F_OK).

This patch will also disable a compiler warning, C4996, as the compiler
complains about the usage of access() - despite it is being redefinded
as _access().

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac    |    2 +-
 options.c       |    1 -
 win/config.h.in |   29 +++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 173d6e2..f8b3dd6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -515,7 +515,7 @@ AC_CHECK_FUNCS(daemon chroot getpwnam setuid nice system getpid dup dup2 dnl
 	       getpass strerror syslog openlog mlockall getgrnam setgid dnl
 	       setgroups stat flock readv writev time dnl
 	       setsid chdir putenv getpeername unlink dnl
-	       chsize ftruncate execve getpeereid umask basename dirname)
+	       chsize ftruncate execve getpeereid umask basename dirname access)
 
 # Windows use stdcall for winsock so we cannot auto detect these
 m4_define([SOCKET_FUNCS], [socket recv recvfrom send sendto listen dnl
diff --git a/options.c b/options.c
index 2280e9b..508fc82 100644
--- a/options.c
+++ b/options.c
@@ -52,7 +52,6 @@
 #include "configure.h"
 #include "forward.h"
 #include <ctype.h>
-#include <unistd.h>
 
 #include "memdbg.h"
 
diff --git a/win/config.h.in b/win/config.h.in
index e9df379..b44f564 100644
--- a/win/config.h.in
+++ b/win/config.h.in
@@ -223,6 +223,35 @@ typedef unsigned long in_addr_t;
 /* Special Windows version of getpass() defined in io.c */
 #define HAVE_GETPASS 1
 
+
+/* The POSIX access() function is called via _access() on Windows,
+ * defined in io.h
+ */
+#define HAVE_ACCESS 1
+#define access _access
+#pragma warning(disable : 4996) /* Avoid Visual Studio to complain about access(), which is redefined */
+
+/* Macros used by the POSIX access() function might not be available on Windows.
+ * Based on information found here:
+ * http://msdn.microsoft.com/en-us/library/1w06ktdy%28v=vs.80%29.aspx
+ */
+#ifndef R_OK
+#define R_OK 4
+#endif
+
+#ifndef W_OK
+#define W_OK 2
+#endif
+
+#ifndef X_OK
+#define X_OK 1
+#endif
+
+#ifndef F_OK
+#define F_OK 0
+#endif
+
+
 /* Define to the full name and version of this package. */
 #ifdef DEBUG_LABEL
 #define PACKAGE_STRING PACKAGE_NAME " " PACKAGE_VERSION " " DEBUG_LABEL
-- 
1.7.4.4


