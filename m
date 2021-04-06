From: Arne Schwabe <arne@...1227...>
Date: Tue,  6 Apr 2021 18:25:16 +0200
Message-Id: <20210406162518.4075-3-arne@...1227...>
In-Reply-To: <20210406162518.4075-1-arne@...1227...>
References: <20210406162518.4075-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/5] Remove a number of checks for
 functions/headers that are always present
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

For the unlink function we actually have code that just ignores
the unlink call if the unlink function is not present. But all
platforms should have an unlink function.

This also removes all conditionals check for the headers that
belong to the C99 standard library header list
(https://en.cppreference.com/w/c/header).

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 config-msvc.h                    | 11 -----------
 configure.ac                     | 26 ++++++-------------------
 src/compat/compat-daemon.c       |  4 ----
 src/compat/compat-gettimeofday.c |  2 --
 src/openvpn/platform.c           |  4 +---
 src/openvpn/sig.c                | 10 ----------
 src/openvpn/syshead.h            | 33 ++++----------------------------
 7 files changed, 11 insertions(+), 79 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 0f5b539fa..2d5e1a51c 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -5,7 +5,6 @@
 #define ENABLE_PF 1
 #define ENABLE_CRYPTO_OPENSSL 1
 #define ENABLE_DEBUG 1
-#define ENABLE_EUREPHIA 1
 #define ENABLE_FRAGMENT 1
 #define ENABLE_HTTP_PROXY 1
 #define ENABLE_LZO 1
@@ -17,13 +16,9 @@
 #define ENABLE_PORT_SHARE 1
 #define ENABLE_SOCKS 1
 
-#define HAVE_ERRNO_H 1
 #define HAVE_FCNTL_H 1
-#define HAVE_CTYPE_H 1
-#define HAVE_STDARG_H 1
 #define HAVE_STDIO_H 1
 #define HAVE_STDLIB_H 1
-#define HAVE_STRDUP 1
 #define HAVE_STRERROR 1
 #define HAVE_STRINGS_H 1
 #define HAVE_STRING_H 1
@@ -31,8 +26,6 @@
 #define HAVE_SYSTEM 1
 #define HAVE_TIME 1
 #define HAVE_TIME_H 1
-#define HAVE_UNLINK 1
-#define HAVE_VSNPRINTF 1
 #define HAVE_WINDOWS_H 1
 #define HAVE_WINSOCK2_H 1
 #define HAVE_WS2TCPIP_H 1
@@ -47,11 +40,7 @@
 #define HAVE_ACCESS 1
 #define HAVE_CHDIR 1
 #define HAVE_CHSIZE 1
-#define HAVE_CTIME 1
 #define HAVE_IN_PKTINFO 1
-#define HAVE_MEMSET 1
-#define HAVE_PUTENV 1
-#define HAVE_STAT 1
 
 #define HAVE_OPENSSL_ENGINE 1
 /* hardcode usage of OpenSSL 1.1.x */
diff --git a/configure.ac b/configure.ac
index 07a62ad8f..81700abcb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -414,10 +414,9 @@ AX_TYPE_SOCKLEN_T
 AC_CHECK_SIZEOF([unsigned int])
 AC_CHECK_SIZEOF([unsigned long])
 AC_CHECK_HEADERS([ \
-	stdio.h stdarg.h limits.h \
-	time.h errno.h fcntl.h io.h direct.h \
-	ctype.h sys/types.h sys/socket.h \
-	signal.h unistd.h dlfcn.h \
+	fcntl.h io.h direct.h \
+	sys/types.h sys/socket.h \
+	unistd.h dlfcn.h \
 	netinet/in.h netinet/in_systm.h \
 	netinet/tcp.h arpa/inet.h netdb.h \
 	windows.h winsock2.h ws2tcpip.h \
@@ -426,16 +425,14 @@ AC_CHECK_HEADERS([ \
 AC_CHECK_HEADERS([ \
 	sys/time.h sys/ioctl.h sys/stat.h \
 	sys/mman.h sys/file.h sys/wait.h \
-	unistd.h signal.h libgen.h stropts.h \
+	unistd.h libgen.h stropts.h \
 	syslog.h pwd.h grp.h termios.h \
 	sys/sockio.h sys/uio.h linux/sockios.h \
 	linux/types.h poll.h sys/epoll.h err.h \
 ])
 
 SOCKET_INCLUDES="
-#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
-#endif
 #ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif
@@ -591,9 +588,7 @@ AC_CHECK_DECLS(
 	,
 	[AC_DEFINE([SIGHUP], [1], [SIGHUP replacement])],
 	[[
-		#ifdef HAVE_SIGNAL_H
 		#include <signal.h>
-		#endif
 	]]
 )
 AC_CHECK_DECLS(
@@ -601,9 +596,7 @@ AC_CHECK_DECLS(
 	,
 	[AC_DEFINE([SIGINT], [2], [SIGINT replacement])],
 	[[
-		#ifdef HAVE_SIGNAL_H
 		#include <signal.h>
-		#endif
 	]]
 )
 AC_CHECK_DECLS(
@@ -611,9 +604,7 @@ AC_CHECK_DECLS(
 	,
 	[AC_DEFINE([SIGUSR1], [10], [SIGUSR1 replacement])],
 	[[
-		#ifdef HAVE_SIGNAL_H
 		#include <signal.h>
-		#endif
 	]]
 )
 AC_CHECK_DECLS(
@@ -621,9 +612,7 @@ AC_CHECK_DECLS(
 	,
 	[AC_DEFINE([SIGUSR2], [12], [SIGUSR2 replacement])],
 	[[
-		#ifdef HAVE_SIGNAL_H
 		#include <signal.h>
-		#endif
 	]]
 )
 AC_CHECK_DECLS(
@@ -631,9 +620,7 @@ AC_CHECK_DECLS(
 	,
 	[AC_DEFINE([SIGTERM], [15], [SIGTERM replacement])],
 	[[
-		#ifdef HAVE_SIGNAL_H
 		#include <signal.h>
-		#endif
 	]]
 )
 
@@ -642,9 +629,8 @@ AC_FUNC_FORK
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice system getpid dup dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
-	setgroups stat flock readv writev time gettimeofday \
-	ctime memset vsnprintf strdup \
-	setsid chdir putenv getpeername unlink \
+	setgroups flock readv writev time gettimeofday \
+	setsid chdir getpeername unlink \
 	chsize ftruncate execve getpeereid umask basename dirname access \
 	epoll_create strsep \
 ])
diff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c
index 4ef28faf0..197bc3f1b 100644
--- a/src/compat/compat-daemon.c
+++ b/src/compat/compat-daemon.c
@@ -33,9 +33,7 @@
 #include <unistd.h>
 #endif
 
-#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
-#endif
 
 #ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
@@ -49,9 +47,7 @@
 #include <fcntl.h>
 #endif
 
-#ifdef HAVE_ERRNO_H
 #include <errno.h>
-#endif
 
 int
 daemon(int nochdir, int noclose)
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index e63c8d7f8..823dfba6a 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -117,9 +117,7 @@ gettimeofday(struct timeval *tv, void *tz)
 
 #else  /* ifdef _WIN32 */
 
-#ifdef HAVE_TIME_H
 #include <time.h>
-#endif
 
 int
 gettimeofday(struct timeval *tv, void *tz)
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 3bf95f843..45ee54541 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -354,10 +354,8 @@ platform_unlink(const char *filename)
     BOOL ret = DeleteFileW(wide_string(filename, &gc));
     gc_free(&gc);
     return (ret != 0);
-#elif defined(HAVE_UNLINK)
+#else
     return (unlink(filename) == 0);
-#else  /* if defined(_WIN32) */
-    return false;
 #endif
 }
 
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 24a2878fa..3409c3adb 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -214,7 +214,6 @@ signal_restart_status(const struct signal_info *si)
 #endif /* ifdef ENABLE_MANAGEMENT */
 }
 
-#ifdef HAVE_SIGNAL_H
 
 /* normal signal handler, when we are in event loop */
 static void
@@ -224,22 +223,18 @@ signal_handler(const int signum)
     signal(signum, signal_handler);
 }
 
-#endif
 
 /* set handlers for unix signals */
 
-#ifdef HAVE_SIGNAL_H
 #define SM_UNDEF     0
 #define SM_PRE_INIT  1
 #define SM_POST_INIT 2
 static int signal_mode; /* GLOBAL */
-#endif
 
 void
 pre_init_signal_catch(void)
 {
 #ifndef _WIN32
-#ifdef HAVE_SIGNAL_H
     signal_mode = SM_PRE_INIT;
     signal(SIGINT, signal_handler);
     signal(SIGTERM, signal_handler);
@@ -247,7 +242,6 @@ pre_init_signal_catch(void)
     signal(SIGUSR1, SIG_IGN);
     signal(SIGUSR2, SIG_IGN);
     signal(SIGPIPE, SIG_IGN);
-#endif /* HAVE_SIGNAL_H */
 #endif /* _WIN32 */
 }
 
@@ -255,7 +249,6 @@ void
 post_init_signal_catch(void)
 {
 #ifndef _WIN32
-#ifdef HAVE_SIGNAL_H
     signal_mode = SM_POST_INIT;
     signal(SIGINT, signal_handler);
     signal(SIGTERM, signal_handler);
@@ -263,7 +256,6 @@ post_init_signal_catch(void)
     signal(SIGUSR1, signal_handler);
     signal(SIGUSR2, signal_handler);
     signal(SIGPIPE, SIG_IGN);
-#endif /* HAVE_SIGNAL_H */
 #endif
 }
 
@@ -271,7 +263,6 @@ post_init_signal_catch(void)
 void
 restore_signal_state(void)
 {
-#ifdef HAVE_SIGNAL_H
     if (signal_mode == SM_PRE_INIT)
     {
         pre_init_signal_catch();
@@ -280,7 +271,6 @@ restore_signal_state(void)
     {
         post_init_signal_catch();
     }
-#endif
 }
 
 /*
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index bca71d5cf..bac07d102 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -78,9 +78,7 @@
 #include <sys/time.h>
 #endif
 
-#ifdef HAVE_TIME_H
 #include <time.h>
-#endif
 
 #ifdef HAVE_SYS_SOCKET_H
 #include <sys/socket.h>
@@ -114,40 +112,19 @@
 #include <sys/file.h>
 #endif
 
-#ifdef HAVE_STDLIB_H
-#include <stdlib.h>
-#endif
-
 /* These headers belong to C99 and should be always be present */
+#include <stdlib.h>
 #include <inttypes.h>
 #include <stdint.h>
-
-#ifdef HAVE_STDARG_H
 #include <stdarg.h>
-#endif
-
-#ifdef HAVE_UNISTD_H
-#include <unistd.h>
-#endif
-
-#ifdef HAVE_SIGNAL_H
 #include <signal.h>
-#endif
-
-#ifdef HAVE_LIMITS_H
 #include <limits.h>
-#endif
-
-#ifdef HAVE_STDIO_H
 #include <stdio.h>
-#endif
-
-#ifdef HAVE_CTYPE_H
 #include <ctype.h>
-#endif
-
-#ifdef HAVE_ERRNO_H
 #include <errno.h>
+
+#ifdef HAVE_UNISTD_H
+#include <unistd.h>
 #endif
 
 #ifdef HAVE_ERR_H
@@ -199,10 +176,8 @@
 #include <strings.h>
 #endif
 #else
-#ifdef HAVE_STRING_H
 #include <string.h>
 #endif
-#endif
 
 #ifdef HAVE_ARPA_INET_H
 #include <arpa/inet.h>
-- 
2.30.1


