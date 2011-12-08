From: David Sommerseth <davids@...1347...>
Date: Thu,  8 Dec 2011 14:03:27 +0100
Message-Id: <1323349407-21374-1-git-send-email-davids@...1347...>
In-Reply-To: <CAOazyz13pmU4=6XOA-2uq0rAwTMRrRYF73sszehxbcPQsa2rmQ@...278...>
References: <CAOazyz13pmU4=6XOA-2uq0rAwTMRrRYF73sszehxbcPQsa2rmQ@...278...>
Subject: [Openvpn-devel] [PATCH] Enable access() when building in Visual
	Studio
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

Visual Studio does not enable certiain standard Unix functions,
such as access().  By defining _CRT_NONSTDC_NO_WARNINGS and
_CRT_SECURE_NO_WARNINGS, these functions are enabled.

This patch also adds a ./configure check for access() as well,
in case this needs to be implemented on other platforms lacking
this feature.  Which is why HAVE_ACCESS is defined in win/config.h.in

Thanks to Alon Bar-Lev for helping solving this.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac    |    2 +-
 options.c       |    1 -
 win/config.h.in |   28 ++++++++++++++++++++++++++++
 win/msvc.mak.in |    2 +-
 4 files changed, 30 insertions(+), 3 deletions(-)

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
index e9df379..b5c31b8 100644
--- a/win/config.h.in
+++ b/win/config.h.in
@@ -223,6 +223,34 @@ typedef unsigned long in_addr_t;
 /* Special Windows version of getpass() defined in io.c */
 #define HAVE_GETPASS 1
 
+
+/* The POSIX access() function is available, but requires
+ * _CRT_NONSTDC_NO_WARNINGS and _CRT_SECURE_NO_WARNINGS
+ * to be defined
+ */
+#define HAVE_ACCESS 1
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
diff --git a/win/msvc.mak.in b/win/msvc.mak.in
index 26d7a33..115e395 100644
--- a/win/msvc.mak.in
+++ b/win/msvc.mak.in
@@ -38,7 +38,7 @@ LIB_DIRS = -LIBPATH:$(OPENSSL)\lib -LIBPATH:$(POLARSSL)\build\library -LIBPATH:$
 EXE = openvpn.exe
 
 CPP=cl.exe
-CPP_ARG_COMMON=/nologo /W3 -DWIN32 -DWIN32_LEAN_AND_MEAN -D_CONSOLE -D_MBCS -D_CRT_SECURE_NO_DEPRECATE $(INCLUDE_DIRS) /FD /c
+CPP_ARG_COMMON=/nologo /W3 -DWIN32 -DWIN32_LEAN_AND_MEAN -D_CONSOLE -D_MBCS -D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_WARNINGS -D_CRT_SECURE_NO_WARNINGS $(INCLUDE_DIRS) /FD /c
 
 LINK32=link.exe
 
-- 
1.7.4.4


