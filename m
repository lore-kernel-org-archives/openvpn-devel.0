From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 30 Mar 2023 11:42:15 +0200
Message-Id: <20230330094215.487924-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Do not include net/in_systm.h
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

This only defines three types and none of them is
used anywhere in our source code.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 configure.ac          |  5 +----
 src/openvpn/syshead.h | 16 ----------------
 2 files changed, 1 insertion(+), 20 deletions(-)

Suggested by Arne in his CMake patch.
Confirmed and tested.

diff --git a/configure.ac b/configure.ac
index ca85e5ed..e1e79ebf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -453,7 +453,7 @@ AC_CHECK_HEADERS([ \
 	fcntl.h io.h \
 	sys/types.h sys/socket.h \
 	unistd.h dlfcn.h \
-	netinet/in.h netinet/in_systm.h \
+	netinet/in.h \
 	netinet/tcp.h arpa/inet.h netdb.h \
 	versionhelpers.h \
 ])
@@ -489,9 +489,6 @@ SOCKET_INCLUDES="
 #ifdef _WIN32
 #include <ws2tcpip.h>
 #endif
-#ifdef HAVE_NETINET_IN_SYSTM_H
-#include <netinet/in_systm.h>
-#endif
 #ifdef HAVE_NETINET_IP_H
 #include <netinet/ip.h>
 #endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 53359225..7181b94d 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -221,10 +221,6 @@
 #include <sys/sockio.h>
 #endif
 
-#ifdef HAVE_NETINET_IN_SYSTM_H
-#include <netinet/in_systm.h>
-#endif
-
 #ifdef HAVE_NETINET_IP_H
 #include <netinet/ip.h>
 #endif
@@ -241,10 +237,6 @@
 #include <sys/uio.h>
 #endif
 
-#ifdef HAVE_NETINET_IN_SYSTM_H
-#include <netinet/in_systm.h>
-#endif
-
 #ifdef HAVE_NETINET_IP_H
 #include <netinet/ip.h>
 #endif
@@ -265,10 +257,6 @@
 #include <sys/uio.h>
 #endif
 
-#ifdef HAVE_NETINET_IN_SYSTM_H
-#include <netinet/in_systm.h>
-#endif
-
 #ifdef HAVE_NETINET_IP_H
 #include <netinet/ip.h>
 #endif
@@ -301,10 +289,6 @@
 #include <sys/uio.h>
 #endif
 
-#ifdef HAVE_NETINET_IN_SYSTM_H
-#include <netinet/in_systm.h>
-#endif
-
 #ifdef HAVE_NETINET_IP_H
 #include <netinet/ip.h>
 #endif
-- 
2.34.1


