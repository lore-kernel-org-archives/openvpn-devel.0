From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:12:04 +0200
Message-Id: <1330546342-17794-35-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 34/52] build: autoconf: minor cleanups
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
 configure.ac |  145 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 72 insertions(+), 73 deletions(-)

diff --git a/configure.ac b/configure.ac
index c540f82..98615c6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -400,6 +400,16 @@ AC_CHECK_HEADERS([ \
 	netinet/tcp.h arpa/inet.h netdb.h \
 	windows.h winsock2.h ws2tcpip.h \
 ])
+AC_CHECK_HEADERS([ \
+	sys/time.h sys/un.h sys/ioctl.h sys/stat.h \
+	sys/mman.h sys/file.h \
+	unistd.h signal.h  \
+	syslog.h pwd.h grp.h \
+	net/if_tun.h net/tun/if_tun.h stropts.h \
+	sys/sockio.h \
+	sys/uio.h linux/if_tun.h linux/sockios.h \
+	linux/types.h sys/poll.h sys/epoll.h err.h \
+])
 
 SOCKET_INCLUDES="
 #ifdef HAVE_STDLIB_H
@@ -425,76 +435,11 @@ SOCKET_INCLUDES="
 #endif
 "
 
-if test "${WIN32}" != "yes"; then
-	AC_CHECK_HEADERS([ \
-		sys/time.h sys/un.h sys/ioctl.h sys/stat.h \
-		sys/mman.h sys/file.h \
-		syslog.h pwd.h grp.h \
-		net/if_tun.h net/tun/if_tun.h stropts.h \
-		sys/sockio.h \
-		sys/uio.h linux/if_tun.h linux/sockios.h \
-		linux/types.h sys/poll.h sys/epoll.h err.h \
-	])
-	AC_CHECK_HEADERS(
-		[net/if.h netinet/ip.h netinet/if_ether.h resolv.h],
-		,
-		,
-		[[${SOCKET_INCLUDES}]]
-	)
-
-	AC_FUNC_FORK
-fi
-
-dnl We emulate signals in Windows
-AC_CHECK_DECLS(
-	[SIGHUP],
-	,
-	[AC_DEFINE([SIGHUP], [1], [SIGHUP replacement])],
-	[[
-		#ifdef HAVE_SIGNAL_H
-		#include <signal.h>
-		#endif
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGINT],
-	,
-	[AC_DEFINE([SIGINT], [2], [SIGINT replacement])],
-	[[
-		#ifdef HAVE_SIGNAL_H
-		#include <signal.h>
-		#endif
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGUSR1],
+AC_CHECK_HEADERS(
+	[net/if.h netinet/ip.h netinet/if_ether.h resolv.h],
 	,
-	[AC_DEFINE([SIGUSR1], [10], [SIGUSR1 replacement])],
-	[[
-		#ifdef HAVE_SIGNAL_H
-		#include <signal.h>
-		#endif
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGUSR2],
 	,
-	[AC_DEFINE([SIGUSR2], [12], [SIGUSR2 replacement])],
-	[[
-		#ifdef HAVE_SIGNAL_H
-		#include <signal.h>
-		#endif
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGTERM],
-	,
-	[AC_DEFINE([SIGTERM], [15], [SIGTERM replacement])],
-	[[
-		#ifdef HAVE_SIGNAL_H
-		#include <signal.h>
-		#endif
-	]]
+	[[${SOCKET_INCLUDES}]]
 )
 
 AC_CHECK_TYPES(
@@ -503,8 +448,6 @@ AC_CHECK_TYPES(
 	[AC_DEFINE([in_addr_t], [uint32_t], [Workaround missing in_addr_t])],
 	[[${SOCKET_INCLUDES}]]
 )
-
-dnl check for IPv6 types
 AC_CHECK_TYPE(
 	[struct tun_pi],
 	[AC_DEFINE(HAVE_TUN_PI, 1, [struct tun_pi needed for IPv6 support])],
@@ -547,16 +490,72 @@ AC_CHECK_TYPE(
 	[AC_MSG_ERROR([struct sockaddr_in6 not found, needed for ipv6 transport support.])],
 	[[${SOCKET_INCLUDES}]]
 )
+AC_CHECK_DECLS(
+	[SO_MARK],
+	,
+	,
+	[[${SOCKET_INCLUDES}]]
+)
 
-AC_CHECK_FUNCS(
-	[ctime memset vsnprintf strdup],
+dnl We emulate signals in Windows
+AC_CHECK_DECLS(
+	[SIGHUP],
 	,
-	[AC_MSG_ERROR([Required library function not found])]
+	[AC_DEFINE([SIGHUP], [1], [SIGHUP replacement])],
+	[[
+		#ifdef HAVE_SIGNAL_H
+		#include <signal.h>
+		#endif
+	]]
 )
+AC_CHECK_DECLS(
+	[SIGINT],
+	,
+	[AC_DEFINE([SIGINT], [2], [SIGINT replacement])],
+	[[
+		#ifdef HAVE_SIGNAL_H
+		#include <signal.h>
+		#endif
+	]]
+)
+AC_CHECK_DECLS(
+	[SIGUSR1],
+	,
+	[AC_DEFINE([SIGUSR1], [10], [SIGUSR1 replacement])],
+	[[
+		#ifdef HAVE_SIGNAL_H
+		#include <signal.h>
+		#endif
+	]]
+)
+AC_CHECK_DECLS(
+	[SIGUSR2],
+	,
+	[AC_DEFINE([SIGUSR2], [12], [SIGUSR2 replacement])],
+	[[
+		#ifdef HAVE_SIGNAL_H
+		#include <signal.h>
+		#endif
+	]]
+)
+AC_CHECK_DECLS(
+	[SIGTERM],
+	,
+	[AC_DEFINE([SIGTERM], [15], [SIGTERM replacement])],
+	[[
+		#ifdef HAVE_SIGNAL_H
+		#include <signal.h>
+		#endif
+	]]
+)
+
+AC_FUNC_FORK
+
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice system getpid dup dup2 \
 	getpass strerror syslog openlog mlockall getgrnam setgid \
 	setgroups stat flock readv writev time gettimeofday \
+	ctime memset vsnprintf strdup \
 	setsid chdir putenv getpeername unlink \
 	chsize ftruncate execve getpeereid umask basename dirname access \
 	epoll_create \
-- 
1.7.3.4


