From: Gert Doering <gert@...1296...>
Date: Thu, 27 Nov 2025 11:51:20 +0100
Message-ID: <20251127105125.30457-1-gert@...1296...>
In-Reply-To: <gerrit.1764176048000.Ie460eec488a8781e3b1ee4f8b2ae2090729ed175@...2715...>
References: <gerrit.1764176048000.Ie460eec488a8781e3b1ee4f8b2ae2090729ed175@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Linux: Assume we have a kernel that was
 release in the last 15 years
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

From: Frank Lichtenheld <frank@...2641...>

Just assume that we have all the linux headers that
were part of linux since 2.6 (or 2.4 in some cases).

Simplifies configuration.

Change-Id: Ie460eec488a8781e3b1ee4f8b2ae2090729ed175
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1408
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1408
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index e812145..c4d50e4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -145,7 +145,6 @@
     set(TARGET_ANDROID YES)
     set(ENABLE_ASYNC_PUSH YES)
     set(ENABLE_SITNL YES)
-    set(HAVE_LINUX_TYPES_H 1)
     # Wacky workaround as OpenSSL package detection is otherwise broken (https://stackoverflow.com/questions/45958214/android-cmake-could-not-find-openssl)
     list(APPEND CMAKE_FIND_ROOT_PATH ${OPENSSL_ROOT_DIR})
 elseif (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
@@ -153,9 +152,6 @@
     set(ENABLE_ASYNC_PUSH YES)
     set(ENABLE_LINUXDCO YES)
     set(ENABLE_SITNL YES)
-    set(HAVE_DECL_SO_MARK YES)
-    set(ENABLE_FEATURE_TUN_PERSIST 1)
-    set(HAVE_LINUX_TYPES_H 1)
     set(ENABLE_DCO YES)
 elseif (${CMAKE_SYSTEM_NAME} STREQUAL "FreeBSD")
     set(TARGET_FREEBSD YES)
@@ -258,8 +254,6 @@
 check_include_files(dmalloc.h HAVE_DMALLOC_H)
 check_include_files(fcntl.h HAVE_FCNTL_H)
 check_include_files(err.h HAVE_ERR_H)
-check_include_files(linux/if_tun.h HAVE_LINUX_IF_TUN_H)
-check_include_files(linux/sockios.h HAVE_LINUX_SOCKIOS_H)
 check_include_files(netdb.h HAVE_NETDB_H)
 check_include_files("${NETEXTRA};netinet/in6.h" HAVE_NETINET_IN_H)
 check_include_files(net/if.h HAVE_NET_IF_H)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 1c443ab..bf1899c 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -20,9 +20,6 @@
 /* Enable debugging support (needed for verb>=4) */
 #define ENABLE_DEBUG 1
 
-/* We have persist tun capability */
-#cmakedefine ENABLE_FEATURE_TUN_PERSIST
-
 /* Enable internal fragmentation support */
 #define ENABLE_FRAGMENT 1
 
@@ -92,10 +89,6 @@
 /* Define to 1 if you have the `daemon' function. */
 #cmakedefine HAVE_DAEMON
 
-/* Define to 1 if you have the declaration of `SO_MARK', and to 0 if you
-don't. */
-#cmakedefine01 HAVE_DECL_SO_MARK
-
 /* Define to 1 if you have the <direct.h> header file. */
 #cmakedefine HAVE_DIRECT_H
 
@@ -166,15 +159,6 @@
 /* Define to 1 if you have the <limits.h> header file. */
 #define HAVE_LIMITS_H 1
 
-/* Define to 1 if you have the <linux/if_tun.h> header file. */
-#cmakedefine HAVE_LINUX_IF_TUN_H
-
-/* Define to 1 if you have the <linux/sockios.h> header file. */
-#cmakedefine HAVE_LINUX_SOCKIOS_H
-
-/* Define to 1 if you have the <linux/types.h> header file. */
-#cmakedefine HAVE_LINUX_TYPES_H
-
 /* Define to 1 if you have the <lzo1x.h> header file. */
 #define HAVE_LZO1X_H 1
 
diff --git a/configure.ac b/configure.ac
index 44c7b65..030f8de 100644
--- a/configure.ac
+++ b/configure.ac
@@ -494,8 +494,8 @@
 	sys/mman.h sys/file.h sys/wait.h \
 	unistd.h libgen.h stropts.h \
 	syslog.h pwd.h grp.h termios.h \
-	sys/sockio.h sys/uio.h linux/sockios.h \
-	linux/types.h linux/errqueue.h poll.h sys/epoll.h err.h \
+	sys/sockio.h sys/uio.h \
+	poll.h sys/epoll.h err.h \
 ])
 
 SOCKET_INCLUDES="
@@ -587,12 +587,6 @@
 	[AC_MSG_ERROR([struct sockaddr_in6 not found, needed for ipv6 transport support.])],
 	[[${SOCKET_INCLUDES}]]
 )
-AC_CHECK_DECLS(
-	[SO_MARK],
-	,
-	,
-	[[${SOCKET_INCLUDES}]]
-)
 
 saved_LDFLAGS="$LDFLAGS"
 LDFLAGS="$LDFLAGS -Wl,--wrap=exit"
@@ -717,16 +711,6 @@
 	],
 	[have_tap_header="yes"]
 )
-AC_CHECK_DECLS(
-	[TUNSETPERSIST],
-	[AC_DEFINE([ENABLE_FEATURE_TUN_PERSIST], [1], [We have persist tun capability])],
-	,
-	[[
-		#ifdef HAVE_LINUX_IF_TUN_H
-		#include <linux/if_tun.h>
-		#endif
-	]]
-)
 CFLAGS="${old_CFLAGS}"
 test "${have_tap_header}" = "yes" || AC_MSG_ERROR([no tap header could be found])
 
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 9e152df..e080ea9 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -274,6 +274,8 @@
 
 #if EXTENDED_SOCKET_ERROR_CAPABILITY
 
+#include <linux/errqueue.h>
+
 struct probehdr
 {
     uint32_t ttl;
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 3bbff6f..b690149 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -262,8 +262,7 @@
 
 /*
  * EXTENDED_SOCKET_ERROR_CAPABILITY functions -- print extra error info
- * on socket errors, such as PMTU size.  As of 2003.05.11, only works
- * on Linux 2.4+.
+ * on socket errors, such as PMTU size.
  */
 
 #if EXTENDED_SOCKET_ERROR_CAPABILITY
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4794315..f610256 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -315,7 +315,7 @@
     "                  or --fragment max value, whichever is lower.\n"
     "--sndbuf size   : Set the TCP/UDP send buffer size.\n"
     "--rcvbuf size   : Set the TCP/UDP receive buffer size.\n"
-#if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
+#if defined(TARGET_LINUX)
     "--mark value    : Mark encrypted packets being sent with value. The mark value\n"
     "                  can be matched in policy routing and packetfilter rules.\n"
     "--bind-dev dev  : Bind to the given device when making connection to a peer or\n"
@@ -768,7 +768,7 @@
     "                         (for use with --tls-auth or --tls-crypt)."
 #ifdef ENABLE_FEATURE_TUN_PERSIST
     "\n"
-    "Tun/tap config mode (available with linux 2.4+):\n"
+    "Tun/tap config mode:\n"
     "--mktun         : Create a persistent tunnel.\n"
     "--rmtun         : Remove a persistent tunnel.\n"
     "--dev tunX|tapX : tun/tap device\n"
@@ -1792,7 +1792,7 @@
     SHOW_BOOL(occ);
     SHOW_INT(rcvbuf);
     SHOW_INT(sndbuf);
-#if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
+#if defined(TARGET_LINUX)
     SHOW_INT(mark);
 #endif
     SHOW_INT(sockflags);
@@ -6510,7 +6510,7 @@
     }
     else if (streq(p[0], "mark") && p[1] && !p[2])
     {
-#if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
+#if defined(TARGET_LINUX)
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->mark = atoi_warn(p[1], msglevel);
 #endif
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8b6e35e..5247e07 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -524,7 +524,7 @@
 static inline void
 socket_set_mark(socket_descriptor_t sd, int mark)
 {
-#if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
+#if defined(TARGET_LINUX)
     if (mark && setsockopt(sd, SOL_SOCKET, SO_MARK, (void *)&mark, sizeof(mark)) != 0)
     {
         msg(M_WARN, "NOTE: setsockopt SO_MARK=%d failed", mark);
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 90045a9..c6f2608 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -185,26 +185,19 @@
 
 #if defined(TARGET_LINUX) || defined(TARGET_ANDROID)
 
-#ifdef HAVE_LINUX_IF_TUN_H
-#include <linux/if_tun.h>
+#define EXTENDED_SOCKET_ERROR_CAPABILITY 1
+
+#ifdef TARGET_LINUX
+#define ENABLE_FEATURE_TUN_PERSIST
 #endif
 
+#include <linux/if_tun.h>
+#include <linux/sockios.h>
+
 #ifdef HAVE_NETINET_IP_H
 #include <netinet/ip.h>
 #endif
 
-#ifdef HAVE_LINUX_SOCKIOS_H
-#include <linux/sockios.h>
-#endif
-
-#ifdef HAVE_LINUX_TYPES_H
-#include <linux/types.h>
-#endif
-
-#ifdef HAVE_LINUX_ERRQUEUE_H
-#include <linux/errqueue.h>
-#endif
-
 #ifdef HAVE_NETINET_TCP_H
 #include <netinet/tcp.h>
 #endif
@@ -361,15 +354,6 @@
 #endif
 
 /*
- * Do we have the capability to report extended socket errors?
- */
-#if defined(HAVE_LINUX_TYPES_H) && defined(HAVE_LINUX_ERRQUEUE_H)
-#define EXTENDED_SOCKET_ERROR_CAPABILITY 1
-#else
-#define EXTENDED_SOCKET_ERROR_CAPABILITY 0
-#endif
-
-/*
  * Does this platform support linux-style IP_PKTINFO
  * or bsd-style IP_RECVDSTADDR ?
  */
@@ -397,14 +381,6 @@
 #endif
 
 /*
- * Disable ESEC
- */
-#if 0
-#undef EXTENDED_SOCKET_ERROR_CAPABILITY
-#define EXTENDED_SOCKET_ERROR_CAPABILITY 0
-#endif
-
-/*
  * Do we have a syslog capability?
  */
 #if defined(HAVE_OPENLOG) && defined(HAVE_SYSLOG)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 06b7ae5..7c61dcf 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2055,10 +2055,6 @@
 
 #elif defined(TARGET_LINUX)
 
-#ifndef HAVE_LINUX_SOCKIOS_H
-#error header file linux/sockios.h required
-#endif
-
 #if !PEDANTIC
 
 void
@@ -2186,11 +2182,6 @@
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
 
-/* TUNSETGROUP appeared in 2.6.23 */
-#ifndef TUNSETGROUP
-#define TUNSETGROUP _IOW('T', 206, int)
-#endif
-
 void
 tuncfg(const char *dev, const char *dev_type, const char *dev_node, int persist_mode,
        const char *username, const char *groupname, const struct tuntap_options *options,
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index e13f99f..876f147 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -278,9 +278,11 @@
 
 int read_tun(struct tuntap *tt, uint8_t *buf, int len);
 
+#ifdef ENABLE_FEATURE_TUN_PERSIST
 void tuncfg(const char *dev, const char *dev_type, const char *dev_node, int persist_mode,
             const char *username, const char *groupname, const struct tuntap_options *options,
             openvpn_net_ctx_t *ctx);
+#endif
 
 const char *guess_tuntap_dev(const char *dev, const char *dev_type, const char *dev_node,
                              struct gc_arena *gc);

