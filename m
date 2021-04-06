From: Arne Schwabe <arne@...1227...>
Date: Tue,  6 Apr 2021 18:25:14 +0200
Message-Id: <20210406162518.4075-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/5] Remove check for socket functions and
 Win XP compatbility code
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

While the check if all socket related functions are present sounds like
a good idea in theory, in reality it just adds time to configure runs.

Our poll check on windows is currently only depending on sys/poll.h
non-existance. Make the check and comment more explicit.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 config-msvc.h                 | 23 ----------
 configure.ac                  | 48 +--------------------
 src/compat/Makefile.am        |  2 -
 src/compat/compat-inet_ntop.c | 78 ---------------------------------
 src/compat/compat-inet_pton.c | 81 -----------------------------------
 src/compat/compat.h           | 10 -----
 src/compat/compat.vcxproj     |  2 -
 src/openvpn/mtu.c             |  4 +-
 src/openvpn/socket.c          | 12 +++---
 src/openvpn/syshead.h         |  8 ++--
 10 files changed, 14 insertions(+), 254 deletions(-)
 delete mode 100644 src/compat/compat-inet_ntop.c
 delete mode 100644 src/compat/compat-inet_pton.c

diff --git a/config-msvc.h b/config-msvc.h
index aea2628be..0f5b539fa 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -53,23 +53,6 @@
 #define HAVE_PUTENV 1
 #define HAVE_STAT 1
 
-#define HAVE_SOCKET 1
-#define HAVE_RECV 1
-#define HAVE_RECVFROM 1
-#define HAVE_SEND 1
-#define HAVE_SENDTO 1
-#define HAVE_LISTEN 1
-#define HAVE_ACCEPT 1
-#define HAVE_CONNECT 1
-#define HAVE_BIND 1
-#define HAVE_SELECT 1
-#define HAVE_GETHOSTBYNAME 1
-#define HAVE_INET_NTOA 1
-#define HAVE_SETSOCKOPT 1
-#define HAVE_GETSOCKOPT 1
-#define HAVE_GETSOCKNAME 1
-#define HAVE_POLL 1
-
 #define HAVE_OPENSSL_ENGINE 1
 /* hardcode usage of OpenSSL 1.1.x */
 #define HAVE_EVP_MD_CTX_RESET 1
@@ -155,9 +138,3 @@ typedef uint16_t in_port_t;
 #ifdef HAVE_CONFIG_MSVC_LOCAL_H
 #include <config-msvc-local.h>
 #endif
-
-/* Vista and above has implementation of inet_ntop / inet_pton */
-#if _WIN32_WINNT >= _WIN32_WINNT_VISTA
-    #define HAVE_INET_NTOP
-    #define HAVE_INET_PTON
-#endif
diff --git a/configure.ac b/configure.ac
index 7bc6c7b90..23dac74f1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -684,53 +684,7 @@ AC_SUBST([SOCKETS_LIBS])
 old_LIBS="${LIBS}"
 LIBS="${LIBS} ${SOCKETS_LIBS}"
 AC_CHECK_FUNCS([sendmsg recvmsg])
-# Windows use stdcall for winsock so we cannot auto detect these
-m4_define(
-	[SOCKET_FUNCS],
-[socket recv recvfrom send sendto listen dnl
-accept connect bind select gethostbyname inet_ntoa]dnl
-)
-m4_define(
-	[SOCKET_OPT_FUNCS],
-	[setsockopt getsockopt getsockname poll]dnl
-)
-if test "${WIN32}" = "yes"; then
-# normal autoconf function checking does not find inet_ntop/inet_pton
-# because they need to include the actual header file and link ws2_32.dll
-	LIBS="${LIBS} -lws2_32"
-	AC_MSG_CHECKING([for MinGW inet_ntop()/inet_pton()])
-	AC_LINK_IFELSE(
-		[AC_LANG_PROGRAM(
-			[[
-#include <ws2tcpip.h>
-			]],
-			[[
-int r = (int) inet_ntop (0, NULL, NULL, 0);
-    r += inet_pton(AF_INET, NULL, NULL);
-return r;
-			]]
-		)],
-		[AC_MSG_RESULT([OK])
-		 AC_DEFINE([HAVE_INET_NTOP],[1],[MinGW inet_ntop])
-		 AC_DEFINE([HAVE_INET_PTON],[1],[MinGW inet_pton])
-		],
-		[AC_MSG_RESULT([not found])]
-	)
-	m4_foreach(
-		[F],
-		m4_split(SOCKET_FUNCS SOCKET_OPT_FUNCS),
-			m4_define([UF], [[m4_join([_], [HAVE], m4_toupper(F))]])
-			AC_DEFINE([UF], [1], [Win32 builtin])
-	)
-else
-	AC_CHECK_FUNCS([inet_ntop inet_pton])
-	AC_CHECK_FUNCS(
-		SOCKET_FUNCS,
-		,
-		[AC_MSG_ERROR([Required library function not found])]
-	)
-	AC_CHECK_FUNCS(SOCKET_OPT_FUNCS)
-fi
+
 LIBS="${old_LIBS}"
 
 # we assume res_init() always exist, but need to find out *where*...
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 34b7ce773..206ea145b 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -27,7 +27,5 @@ libcompat_la_SOURCES = \
 	compat-basename.c \
 	compat-gettimeofday.c \
 	compat-daemon.c \
-	compat-inet_ntop.c \
-	compat-inet_pton.c \
 	compat-strsep.c \
 	compat-versionhelpers.h
diff --git a/src/compat/compat-inet_ntop.c b/src/compat/compat-inet_ntop.c
deleted file mode 100644
index f2a181e86..000000000
--- a/src/compat/compat-inet_ntop.c
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-
-#ifndef HAVE_INET_NTOP
-
-#include "compat.h"
-
-#ifdef _WIN32
-
-#include <windows.h>
-
-/*
- * inet_ntop() and inet_pton() wrap-implementations using
- * WSAAddressToString() and WSAStringToAddress() functions
- *
- * this is needed as long as we support running OpenVPN on WinXP
- */
-
-const char *
-inet_ntop(int af, const void *src, char *dst, socklen_t size)
-{
-    struct sockaddr_storage ss;
-    unsigned long s = size;
-
-    ZeroMemory(&ss, sizeof(ss));
-    ss.ss_family = af;
-
-    switch (af)
-    {
-        case AF_INET:
-            ((struct sockaddr_in *)&ss)->sin_addr = *(struct in_addr *)src;
-            break;
-
-        case AF_INET6:
-            ((struct sockaddr_in6 *)&ss)->sin6_addr = *(struct in6_addr *)src;
-            break;
-
-        default:
-            return NULL;
-    }
-    /* cannot direclty use &size because of strict aliasing rules */
-    return (WSAAddressToString((struct sockaddr *)&ss, sizeof(ss), NULL, dst, &s) == 0) ?
-           dst : NULL;
-}
-
-#else  /* ifdef _WIN32 */
-
-#error no emulation for inet_ntop
-
-#endif /* ifdef _WIN32 */
-
-#endif /* ifndef HAVE_INET_NTOP */
diff --git a/src/compat/compat-inet_pton.c b/src/compat/compat-inet_pton.c
deleted file mode 100644
index 9d451ccad..000000000
--- a/src/compat/compat-inet_pton.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-
-#ifndef HAVE_INET_PTON
-
-#include "compat.h"
-
-#ifdef _WIN32
-
-#include <windows.h>
-#include <string.h>
-
-/*
- * inet_ntop() and inet_pton() wrap-implementations using
- * WSAAddressToString() and WSAStringToAddress() functions
- *
- * this is needed as long as we support running OpenVPN on WinXP
- */
-
-
-int
-inet_pton(int af, const char *src, void *dst)
-{
-    struct sockaddr_storage ss;
-    int size = sizeof(ss);
-    char src_copy[INET6_ADDRSTRLEN+1];
-
-    ZeroMemory(&ss, sizeof(ss));
-    /* stupid non-const API */
-    strncpy(src_copy, src, INET6_ADDRSTRLEN+1);
-    src_copy[INET6_ADDRSTRLEN] = 0;
-
-    if (WSAStringToAddress(src_copy, af, NULL, (struct sockaddr *)&ss, &size) == 0)
-    {
-        switch (af)
-        {
-            case AF_INET:
-                *(struct in_addr *)dst = ((struct sockaddr_in *)&ss)->sin_addr;
-                return 1;
-
-            case AF_INET6:
-                *(struct in6_addr *)dst = ((struct sockaddr_in6 *)&ss)->sin6_addr;
-                return 1;
-        }
-    }
-    return 0;
-}
-
-#else  /* ifdef _WIN32 */
-
-#error no emulation for inet_ntop
-
-#endif /* ifdef _WIN32 */
-
-#endif /* ifndef HAVE_INET_PTON */
diff --git a/src/compat/compat.h b/src/compat/compat.h
index a66a42350..2bf48a5eb 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -60,16 +60,6 @@ int daemon(int nochdir, int noclose);
 
 #endif
 
-#ifndef HAVE_INET_NTOP
-const char *inet_ntop(int af, const void *src, char *dst, socklen_t size);
-
-#endif
-
-#ifndef HAVE_INET_PTON
-int inet_pton(int af, const char *src, void *dst);
-
-#endif
-
 #ifndef HAVE_STRSEP
 char *strsep(char **stringp, const char *delim);
 
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index 23e9b9c00..b9dba0c46 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -98,8 +98,6 @@
     <ClCompile Include="compat-basename.c" />
     <ClCompile Include="compat-dirname.c" />
     <ClCompile Include="compat-gettimeofday.c" />
-    <ClCompile Include="compat-inet_ntop.c" />
-    <ClCompile Include="compat-inet_pton.c" />
     <ClCompile Include="compat-daemon.c" />
     <ClCompile Include="compat-strsep.c" />
   </ItemGroup>
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 3317c884d..15e4cedea 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -172,7 +172,7 @@ set_mtu_discover_type(socket_descriptor_t sd, int mtu_type, sa_family_t proto_af
     {
         switch (proto_af)
         {
-#if defined(HAVE_SETSOCKOPT) && defined(IP_MTU_DISCOVER)
+#if defined(IP_MTU_DISCOVER)
             case AF_INET:
                 if (setsockopt(sd, IPPROTO_IP, IP_MTU_DISCOVER,
                                (void *) &mtu_type, sizeof(mtu_type)))
@@ -183,7 +183,7 @@ set_mtu_discover_type(socket_descriptor_t sd, int mtu_type, sa_family_t proto_af
                 break;
 
 #endif
-#if defined(HAVE_SETSOCKOPT) && defined(IPV6_MTU_DISCOVER)
+#if defined(IPV6_MTU_DISCOVER)
             case AF_INET6:
                 if (setsockopt(sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER,
                                (void *) &mtu_type, sizeof(mtu_type)))
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6bb107de6..b13d2e0f1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -848,7 +848,7 @@ mac_addr_safe(const char *mac_addr)
 static int
 socket_get_sndbuf(socket_descriptor_t sd)
 {
-#if defined(HAVE_GETSOCKOPT) && defined(SOL_SOCKET) && defined(SO_SNDBUF)
+#if defined(SOL_SOCKET) && defined(SO_SNDBUF)
     int val;
     socklen_t len;
 
@@ -865,7 +865,7 @@ socket_get_sndbuf(socket_descriptor_t sd)
 static void
 socket_set_sndbuf(socket_descriptor_t sd, int size)
 {
-#if defined(HAVE_SETSOCKOPT) && defined(SOL_SOCKET) && defined(SO_SNDBUF)
+#if defined(SOL_SOCKET) && defined(SO_SNDBUF)
     if (setsockopt(sd, SOL_SOCKET, SO_SNDBUF, (void *) &size, sizeof(size)) != 0)
     {
         msg(M_WARN, "NOTE: setsockopt SO_SNDBUF=%d failed", size);
@@ -876,7 +876,7 @@ socket_set_sndbuf(socket_descriptor_t sd, int size)
 static int
 socket_get_rcvbuf(socket_descriptor_t sd)
 {
-#if defined(HAVE_GETSOCKOPT) && defined(SOL_SOCKET) && defined(SO_RCVBUF)
+#if defined(SOL_SOCKET) && defined(SO_RCVBUF)
     int val;
     socklen_t len;
 
@@ -893,7 +893,7 @@ socket_get_rcvbuf(socket_descriptor_t sd)
 static bool
 socket_set_rcvbuf(socket_descriptor_t sd, int size)
 {
-#if defined(HAVE_SETSOCKOPT) && defined(SOL_SOCKET) && defined(SO_RCVBUF)
+#if defined(SOL_SOCKET) && defined(SO_RCVBUF)
     if (setsockopt(sd, SOL_SOCKET, SO_RCVBUF, (void *) &size, sizeof(size)) != 0)
     {
         msg(M_WARN, "NOTE: setsockopt SO_RCVBUF=%d failed", size);
@@ -936,7 +936,7 @@ socket_set_buffers(socket_descriptor_t fd, const struct socket_buffer_size *sbs)
 static bool
 socket_set_tcp_nodelay(socket_descriptor_t sd, int state)
 {
-#if defined(_WIN32) || (defined(HAVE_SETSOCKOPT) && defined(IPPROTO_TCP) && defined(TCP_NODELAY))
+#if defined(_WIN32) || (defined(IPPROTO_TCP) && defined(TCP_NODELAY))
     if (setsockopt(sd, IPPROTO_TCP, TCP_NODELAY, (void *) &state, sizeof(state)) != 0)
     {
         msg(M_WARN, "NOTE: setsockopt TCP_NODELAY=%d failed", state);
@@ -947,7 +947,7 @@ socket_set_tcp_nodelay(socket_descriptor_t sd, int state)
         dmsg(D_OSBUF, "Socket flags: TCP_NODELAY=%d succeeded", state);
         return true;
     }
-#else  /* if defined(_WIN32) || (defined(HAVE_SETSOCKOPT) && defined(IPPROTO_TCP) && defined(TCP_NODELAY)) */
+#else  /* if defined(_WIN32) || (defined(IPPROTO_TCP) && defined(TCP_NODELAY)) */
     msg(M_WARN, "NOTE: setsockopt TCP_NODELAY=%d failed (No kernel support)", state);
     return false;
 #endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index de4fbbf94..16f5ab11f 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -399,7 +399,7 @@ typedef int MIB_TCP_STATE;
 /*
  * Do we have the capability to support the --passtos option?
  */
-#if defined(IPPROTO_IP) && defined(IP_TOS) && defined(HAVE_SETSOCKOPT)
+#if defined(IPPROTO_IP) && defined(IP_TOS)
 #define PASSTOS_CAPABILITY 1
 #else
 #define PASSTOS_CAPABILITY 0
@@ -557,8 +557,10 @@ socket_defined(const socket_descriptor_t sd)
 
 /*
  * Is poll available on this platform?
+ * (Note: on win32 select is faster than poll and we avoid
+ * using poll there)
  */
-#if defined(HAVE_POLL) && defined(HAVE_POLL_H)
+#if defined(HAVE_POLL_H) || !defined(_WIN32)
 #define POLL 1
 #else
 #define POLL 0
@@ -582,7 +584,7 @@ socket_defined(const socket_descriptor_t sd)
 /*
  * Is non-blocking connect() supported?
  */
-#if defined(HAVE_GETSOCKOPT) && defined(SOL_SOCKET) && defined(SO_ERROR) && defined(EINPROGRESS) && defined(ETIMEDOUT)
+#if defined(SOL_SOCKET) && defined(SO_ERROR) && defined(EINPROGRESS) && defined(ETIMEDOUT)
 #define CONNECT_NONBLOCK
 #endif
 
-- 
2.30.1


