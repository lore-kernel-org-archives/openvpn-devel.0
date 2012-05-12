From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:49 +0300
Message-Id: <1336850389-23719-17-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 16/16] clenaup: syshead: reworder/cleanup
	includes
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac          |    2 +-
 src/openvpn/syshead.h |  146 ++++++++++++-------------------------------------
 2 files changed, 36 insertions(+), 112 deletions(-)

diff --git a/configure.ac b/configure.ac
index cca9508..97eb5f0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -643,7 +643,7 @@ old_CFLAGS="${CFLAGS}"
 CFLAGS="${CFLAGS} ${TAP_CFLAGS}"
 AC_CHECK_HEADERS(
 	[ \
-		net/if_tun.h net/tun/if_tun.h \
+		net/if_tun.h net/tun/if_tun.h net/if_tap.h \
 		linux/if_tun.h \
 		tap-windows.h \
 	],
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index d5a9af1..1b9cbe0 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -31,6 +31,10 @@
 #ifdef WIN32
 #include <windows.h>
 #include <winsock2.h>
+#include <ws2tcpip.h>
+#include <iphlpapi.h>
+#include <ntddndis.h>
+#include <wininet.h>
 #endif
 
 #ifdef HAVE_SYS_TYPES_H
@@ -135,18 +139,6 @@
 #include <grp.h>
 #endif
 
-#ifdef HAVE_NETDB_H
-#include <netdb.h>
-#endif
-
-#ifdef HAVE_NETINET_IN_H
-#include <netinet/in.h>
-#endif
-
-#ifdef HAVE_RESOLV_H
-#include <resolv.h>
-#endif
-
 #ifdef HAVE_SYS_POLL_H
 #include <sys/poll.h>
 #endif
@@ -155,6 +147,10 @@
 #include <sys/epoll.h>
 #endif
 
+#ifdef HAVE_SYS_MMAN_H
+#include <sys/mman.h>
+#endif
+
 #ifdef ENABLE_SELINUX
 #include <selinux/selinux.h>
 #endif
@@ -163,29 +159,47 @@
 #include <libgen.h>
 #endif
 
-#ifdef TARGET_SOLARIS
 #ifdef HAVE_STRINGS_H
 #include <strings.h>
 #endif
-#else
+
 #ifdef HAVE_STRING_H
 #include <string.h>
 #endif
+
+#ifdef HAVE_STROPTS_H
+#include <stropts.h>
+#endif
+
+#ifdef HAVE_NETDB_H
+#include <netdb.h>
 #endif
 
 #ifdef HAVE_ARPA_INET_H
 #include <arpa/inet.h>
 #endif
 
+#ifdef HAVE_NETINET_IN_H
+#include <netinet/in.h>
+#endif
+
+#ifdef HAVE_NETINET_IP_H
+#include <netinet/ip.h>
+#endif
+
+#ifdef HAVE_NETINET_TCP_H
+#include <netinet/tcp.h>
+#endif
+
 #ifdef HAVE_NET_IF_H
 #include <net/if.h>
 #endif
 
-#ifdef TARGET_NETBSD
-#include <net/if_tap.h>
+#ifdef HAVE_RESOLV_H
+#include <resolv.h>
 #endif
 
-#ifdef TARGET_LINUX
+#if defined(TARGET_LINUX)
 
 #if defined(HAVE_NETINET_IF_ETHER_H)
 #include <netinet/if_ether.h>
@@ -195,10 +209,6 @@
 #include <linux/if_tun.h>
 #endif
 
-#ifdef HAVE_NETINET_IP_H
-#include <netinet/ip.h>
-#endif
-
 #ifdef HAVE_LINUX_SOCKIOS_H
 #include <linux/sockios.h>
 #endif
@@ -211,17 +221,7 @@
 #include <linux/errqueue.h>
 #endif
 
-#ifdef HAVE_NETINET_TCP_H
-#include <netinet/tcp.h>
-#endif
-
-#endif /* TARGET_LINUX */
-
-#ifdef TARGET_SOLARIS
-
-#ifdef HAVE_STROPTS_H
-#include <stropts.h>
-#endif
+#elif defined(TARGET_SOLARIS)
 
 #ifdef HAVE_NET_IF_TUN_H
 #include <net/if_tun.h>
@@ -231,41 +231,7 @@
 #include <sys/sockio.h>
 #endif
 
-#ifdef HAVE_NETINET_IN_SYSTM_H
-#include <netinet/in_systm.h>
-#endif
-
-#ifdef HAVE_NETINET_IP_H
-#include <netinet/ip.h>
-#endif
-
-#ifdef HAVE_NETINET_TCP_H
-#include <netinet/tcp.h>
-#endif
-
-#endif /* TARGET_SOLARIS */
-
-#ifdef TARGET_OPENBSD
-
-#ifdef HAVE_SYS_UIO_H
-#include <sys/uio.h>
-#endif
-
-#ifdef HAVE_NETINET_IN_SYSTM_H
-#include <netinet/in_systm.h>
-#endif
-
-#ifdef HAVE_NETINET_IP_H
-#include <netinet/ip.h>
-#endif
-
-#ifdef HAVE_NET_IF_TUN_H
-#include <net/if_tun.h>
-#endif
-
-#endif /* TARGET_OPENBSD */
-
-#ifdef TARGET_FREEBSD
+#elif defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || defined(TARGET_NETBSD) || defined(TARGET_DRAGONFLY)
 
 #ifdef HAVE_SYS_UIO_H
 #include <sys/uio.h>
@@ -275,60 +241,18 @@
 #include <netinet/in_systm.h>
 #endif
 
-#ifdef HAVE_NETINET_IP_H
-#include <netinet/ip.h>
-#endif
-
 #ifdef HAVE_NET_IF_TUN_H
 #include <net/if_tun.h>
 #endif
 
-#endif /* TARGET_FREEBSD */
-
-#ifdef TARGET_NETBSD
-
-#ifdef HAVE_NET_IF_TUN_H
-#include <net/if_tun.h>
-#endif
-
-#ifdef HAVE_NETINET_TCP_H
-#include <netinet/tcp.h>
-#endif
-
-#endif /* TARGET_NETBSD */
-
-#ifdef TARGET_DRAGONFLY
-
-#ifdef HAVE_SYS_UIO_H
-#include <sys/uio.h>
-#endif
-
-#ifdef HAVE_NETINET_IN_SYSTM_H
-#include <netinet/in_systm.h>
-#endif
-
-#ifdef HAVE_NETINET_IP_H
-#include <netinet/ip.h>
-#endif
-
 #ifdef HAVE_NET_TUN_IF_TUN_H
 #include <net/tun/if_tun.h>
 #endif
 
-#endif /* TARGET_DRAGONFLY */
-
-#ifdef WIN32
-#include <iphlpapi.h>
-#include <ntddndis.h>
-#include <wininet.h>
-#include <shellapi.h>
-/* The following two headers are needed of PF_INET6 */
-#include <winsock2.h>
-#include <ws2tcpip.h>
+#ifdef HAVE_NET_IF_TAP_H
+#include <net/if_tap.h>
 #endif
 
-#ifdef HAVE_SYS_MMAN_H
-#include <sys/mman.h>
 #endif
 
 /*
-- 
1.7.3.4


