From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 24 Mar 2012 09:58:34 +0200
Message-Id: <1332575918-3384-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <4F6D06C5.3030408@...1114...>
References: <4F6D06C5.3030408@...1114...>
Subject: [Openvpn-devel] [PATCH 2/6] build: autoconf: misc sockets fixups
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |   53 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/configure.ac b/configure.ac
index c6cabee..9a6ff29 100644
--- a/configure.ac
+++ b/configure.ac
@@ -522,6 +522,33 @@ AC_CHECK_FUNCS([ \
 	chsize ftruncate execve getpeereid umask basename dirname access \
 	epoll_create \
 ])
+
+AC_CHECK_LIB(
+	[dl],
+	[dlopen],
+	[DL_LIBS="-ldl"]
+)
+AC_SUBST([DL_LIBS])
+
+AC_CHECK_LIB(
+	[nsl],
+	[inet_ntoa],
+	[SOCKETS_LIBS="${SOCKETS_LIBS} -lnsl"]
+)
+AC_CHECK_LIB(
+	[socket],
+	[socket],
+	[SOCKETS_LIBS="${SOCKETS_LIBS} -lsocket"]
+)
+AC_CHECK_LIB(
+	[resolv],
+	[gethostbyname],
+	[SOCKETS_LIBS="${SOCKETS_LIBS} -lresolv"]
+)
+AC_SUBST([SOCKETS_LIBS])
+
+old_LIBS="${LIBS}"
+LIBS="${LIBS} ${SOCKETS_LIBS}"
 AC_CHECK_FUNCS([sendmsg recvmsg inet_ntop inet_pton])
 AC_CHECK_FUNCS(
 	[res_init],
@@ -529,7 +556,6 @@ AC_CHECK_FUNCS(
 	,
 	[[#include <resolv.h>]]
 )
-
 # Windows use stdcall for winsock so we cannot auto detect these
 m4_define(
 	[SOCKET_FUNCS],
@@ -555,30 +581,7 @@ else
 	)
 	AC_CHECK_FUNCS(SOCKET_OPT_FUNCS)
 fi
-
-AC_CHECK_LIB(
-	[dl],
-	[dlopen],
-	[DL_LIBS="-ldl"]
-)
-AC_SUBST([DL_LIBS])
-
-AC_CHECK_LIB(
-	[nsl],
-	[inet_ntoa],
-	[SOCKETS_LIBS="${SOCKETS_LIBS} -lnsl"]
-)
-AC_CHECK_LIB(
-	[socket],
-	[socket],
-	[SOCKETS_LIBS="${SOCKETS_LIBS} -lsocket"]
-)
-AC_CHECK_LIB(
-	[resolv],
-	[gethostbyname],
-	[SOCKETS_LIBS="${SOCKETS_LIBS} -lresolv"]
-)
-AC_SUBST([SOCKETS_LIBS])
+LIBS="${old_LIBS}"
 
 AC_CHECK_LIB(
 	[selinux],
-- 
1.7.3.4


