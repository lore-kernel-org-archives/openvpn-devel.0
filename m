From: Gert Doering <gert@...1296...>
Date: Mon, 27 Apr 2015 21:27:21 +0200
Message-Id: <1430162841-5840-1-git-send-email-gert@...1296...>
In-Reply-To: <CAK6ywb+fMsyvOz+saw9XBO4KDx1srdB92H71OwcKFPZnyxHkqw@...278...>
References: <CAK6ywb+fMsyvOz+saw9XBO4KDx1srdB92H71OwcKFPZnyxHkqw@...278...>
Subject: [Openvpn-devel] [PATCH] assume res_init() is always there.
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

Previously, the code tried to find res_init(), and on some systems
got it wrong in configure, silently not-using res_init(), leading
to unexpected failures to re-init the resolver.

We know that all supported OSes (except Windows) have res_init(), so
change the call to "#ifndef WIN32", and adjust configure.ac to just
find the library to link (if any).  With that, failures to find
res_init() are no longer "hidden" but clearly visible at link time.

AC_SEARCH_LIBS() bits inspired by CUPS' cups_network.m4 (GPLv2)

Fix trac #523

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac         | 11 +++++------
 src/openvpn/socket.c |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9132468..a495c0d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -613,12 +613,6 @@ AC_SUBST([SOCKETS_LIBS])
 old_LIBS="${LIBS}"
 LIBS="${LIBS} ${SOCKETS_LIBS}"
 AC_CHECK_FUNCS([sendmsg recvmsg inet_ntop inet_pton])
-AC_CHECK_FUNCS(
-	[res_init],
-	,
-	,
-	[[#include <resolv.h>]]
-)
 # Windows use stdcall for winsock so we cannot auto detect these
 m4_define(
 	[SOCKET_FUNCS],
@@ -646,6 +640,11 @@ else
 fi
 LIBS="${old_LIBS}"
 
+# we assume res_init() always exist, but need to find out *where*...
+AC_SEARCH_LIBS(__res_init, resolv bind, ,
+    AC_SEARCH_LIBS(res_9_init, resolv bind, ,
+	AC_SEARCH_LIBS(res_init, resolv bind, , )))
+
 AC_ARG_VAR([TAP_CFLAGS], [C compiler flags for tap])
 old_CFLAGS="${CFLAGS}"
 CFLAGS="${CFLAGS} ${TAP_CFLAGS}"
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index afc1e60..13ed981 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -314,7 +314,7 @@ openvpn_getaddrinfo (unsigned int flags,
 
   ASSERT(res);
 
-#if defined(HAVE_RES_INIT)
+#ifndef WIN32
   res_init ();
 #endif
 
-- 
2.0.5


