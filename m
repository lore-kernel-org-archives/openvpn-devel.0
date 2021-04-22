From: Arne Schwabe <arne@...1227...>
Date: Thu, 22 Apr 2021 17:29:39 +0200
Message-Id: <20210422152939.2134046-6-arne@...1227...>
In-Reply-To: <20210422152939.2134046-1-arne@...1227...>
References: <20210422152939.2134046-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 6/6] Remove a number of platform specific
 checks in configure.ac
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

- Remove windows XP/old mingw compat code in socket.c
- Use _WIN32 instead checking for existence of windows.h, winsock2.h
  and ws2tcpip.h in autconf
- Remove check for unlink. The last remaining use is a check inside
  a Unix socket.
- Even Windows has umask, so remove the check for it
- Move epoll.h inclusion to event.c

Patch V2: Add epoll.h syshead.h that accidently was put into another
          patch

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 configure.ac          | 11 +++++------
 src/compat/compat.h   |  5 +----
 src/openvpn/event.c   |  4 ++++
 src/openvpn/socket.c  | 16 ----------------
 src/openvpn/syshead.h | 16 ++--------------
 5 files changed, 12 insertions(+), 40 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3b4d3cbc7..94897c863 100644
--- a/configure.ac
+++ b/configure.ac
@@ -412,7 +412,6 @@ AC_CHECK_HEADERS([ \
 	unistd.h dlfcn.h \
 	netinet/in.h netinet/in_systm.h \
 	netinet/tcp.h arpa/inet.h netdb.h \
-	windows.h winsock2.h ws2tcpip.h \
 	versionhelpers.h \
 ])
 AC_CHECK_HEADERS([ \
@@ -438,13 +437,13 @@ SOCKET_INCLUDES="
 #ifdef HAVE_NETINET_IN_H
 #include <netinet/in.h>
 #endif
-#ifdef HAVE_WINDOWS_H
+#ifdef _WIN32
 #include <windows.h>
 #endif
-#ifdef HAVE_WINSOCK2_H
+#ifdef _WIN32
 #include <winsock2.h>
 #endif
-#ifdef HAVE_WS2TCPIP_H
+#ifdef _WIN32
 #include <ws2tcpip.h>
 #endif
 #ifdef HAVE_NETINET_IN_SYSTM_H
@@ -623,8 +622,8 @@ AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice system getpid dup dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
 	setgroups flock readv writev time gettimeofday \
-	setsid chdir getpeername unlink \
-	chsize ftruncate execve getpeereid umask basename dirname access \
+	setsid chdir getpeername \
+	chsize ftruncate execve getpeereid basename dirname access \
 	epoll_create strsep \
 ])
 
diff --git a/src/compat/compat.h b/src/compat/compat.h
index 2bf48a5eb..026974a81 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -24,11 +24,8 @@
 #ifndef COMPAT_H
 #define COMPAT_H
 
-#ifdef HAVE_WINSOCK2_H
+#ifdef _WIN32
 #include <winsock2.h>
-#endif
-
-#ifdef HAVE_WS2TCPIP_H
 #include <ws2tcpip.h>
 #endif
 
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 14a25155c..d766f8be8 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -35,6 +35,10 @@
 #include "event.h"
 #include "fdmisc.h"
 
+#if EPOLL
+#include <sys/epoll.h>
+#endif
+
 #include "memdbg.h"
 
 /*
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 4e13c65e8..01c65b3e0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1385,14 +1385,6 @@ socket_listen_accept(socket_descriptor_t sd,
     return new_sd;
 }
 
-/* older mingw versions and WinXP do not have this define,
- * but Vista and up support the functionality - just define it here
- */
-#ifdef _WIN32
-#ifndef IPV6_V6ONLY
-#define IPV6_V6ONLY 27
-#endif
-#endif
 void
 socket_bind(socket_descriptor_t sd,
             struct addrinfo *local,
@@ -3905,10 +3897,7 @@ socket_bind_unix(socket_descriptor_t sd,
                  const char *prefix)
 {
     struct gc_arena gc = gc_new();
-
-#ifdef HAVE_UMASK
     const mode_t orig_umask = umask(0);
-#endif
 
     if (bind(sd, (struct sockaddr *) local, sizeof(struct sockaddr_un)))
     {
@@ -3919,10 +3908,7 @@ socket_bind_unix(socket_descriptor_t sd,
             sockaddr_unix_name(local, "NULL"));
     }
 
-#ifdef HAVE_UMASK
     umask(orig_umask);
-#endif
-
     gc_free(&gc);
 }
 
@@ -3967,12 +3953,10 @@ void
 socket_delete_unix(const struct sockaddr_un *local)
 {
     const char *name = sockaddr_unix_name(local, NULL);
-#ifdef HAVE_UNLINK
     if (name && strlen(name))
     {
         unlink(name);
     }
-#endif
 }
 
 bool
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index bc628eac4..a9680f72f 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -100,10 +100,6 @@
 #include <fcntl.h>
 #endif
 
-#ifdef HAVE_IO_H
-#include <io.h>
-#endif
-
 #ifdef HAVE_SYS_FILE_H
 #include <sys/file.h>
 #endif
@@ -155,10 +151,6 @@
 #include <poll.h>
 #endif
 
-#ifdef HAVE_SYS_EPOLL_H
-#include <sys/epoll.h>
-#endif
-
 #ifdef ENABLE_SELINUX
 #include <selinux/selinux.h>
 #endif
@@ -342,6 +334,8 @@ typedef int MIB_TCP_STATE;
 #include <iphlpapi.h>
 #include <wininet.h>
 #include <shellapi.h>
+#include <io.h>
+
 /* The following two headers are needed of PF_INET6 */
 #include <winsock2.h>
 #include <ws2tcpip.h>
@@ -541,12 +535,6 @@ socket_defined(const socket_descriptor_t sd)
 #define EPOLL 0
 #endif
 
-/* Disable EPOLL */
-#if 0
-#undef EPOLL
-#define EPOLL 0
-#endif
-
 /*
  * Compression support
  */
-- 
2.31.1


