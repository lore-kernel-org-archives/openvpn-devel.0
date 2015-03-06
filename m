MIME-Version: 1.0
From: Nicholas Hall <ngharo@...277...>
Date: Fri, 6 Mar 2015 13:07:38 -0600
Message-ID: <CAK6ywb+fMsyvOz+saw9XBO4KDx1srdB92H71OwcKFPZnyxHkqw@...278...>
Subject: [Openvpn-devel] [PATCH] Fix autotools check for res_init
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Autotools configure check fails to detect res_init on recent glibc
versions.  It appears that resolv.h in recent glibc maps res_init to
__res_init which autotools doesn't catch.

This is my first patch ever to anything autotools related.  I used the
check that the ntpd uses and tested on Debian 8 x64 (glibc 2.19) and
LFS 7.4 (glibc 2.18) successfully.

This fixes bug #525
https://community.openvpn.net/openvpn/ticket/523
---
 configure.ac         | 14 ++++++++------
 src/openvpn/socket.c |  4 ++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9132468..c4db43a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -613,12 +613,14 @@ AC_SUBST([SOCKETS_LIBS])
 old_LIBS="${LIBS}"
 LIBS="${LIBS} ${SOCKETS_LIBS}"
 AC_CHECK_FUNCS([sendmsg recvmsg inet_ntop inet_pton])
-AC_CHECK_FUNCS(
-    [res_init],
-    ,
-    ,
-    [[#include <resolv.h>]]
-)
+AC_SEARCH_LIBS([res_init], [resolv], [], [], [-lsocket -lnsl])
+case "$host" in
+    *-*-darwin*)
+        AC_CHECK_LIB([resolv],[res_9_init])
+        ;;
+esac
+AC_HEADER_RESOLV
+AC_CHECK_FUNCS([res_init __res_init])
 # Windows use stdcall for winsock so we cannot auto detect these
 m4_define(
     [SOCKET_FUNCS],
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index f5c740d..5f98f01 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -41,6 +41,10 @@
 #include "manage.h"
 #include "openvpn.h"

+#if !defined(HAVE_RES_INIT) && defined(HAVE___RES_INIT)
+# define HAVE_RES_INIT
+#endif
+
 #include "memdbg.h"

 const int proto_overhead[] = { /* indexed by PROTO_x */
-- 
2.1.4

