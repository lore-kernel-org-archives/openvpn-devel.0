From: Gert Doering <gert@...1296...>
Date: Tue, 22 Sep 2015 22:31:24 +0200
Message-Id: <1442953884-54602-1-git-send-email-gert@...1296...>
In-Reply-To: <1441985627-14822-11-git-send-email-gert@...1296...>
References: <1441985627-14822-11-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Add custom check for
	inet_pton()/inet_ntop() on MinGW/WIN32
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

More recent MinGW versions have these functions (if compiling at
_VISTA level or higher), but the normal AC_CHECK_FUNCS() check does
not find them because the necessary header file is not #include'd and
the libws2_32 not linked - and our compat functions are incompatible
with the definitions in <ws2tcpip.h>, so compilation fails.

Fix with a custom AC_LINK_IFELSE()/AC_LANG_PROGRAM() construct.

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 0a8255c..2e651d8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -632,7 +632,7 @@ AC_SUBST([SOCKETS_LIBS])
 
 old_LIBS="${LIBS}"
 LIBS="${LIBS} ${SOCKETS_LIBS}"
-AC_CHECK_FUNCS([sendmsg recvmsg inet_ntop inet_pton])
+AC_CHECK_FUNCS([sendmsg recvmsg])
 # Windows use stdcall for winsock so we cannot auto detect these
 m4_define(
 	[SOCKET_FUNCS],
@@ -644,6 +644,27 @@ m4_define(
 	[setsockopt getsockopt getsockname poll]dnl
 )
 if test "${WIN32}" = "yes"; then
+# normal autoconf function checking does not find inet_ntop/inet_pton
+# because they need to include the actual header file and link ws2_32.dll
+	LIBS="${LIBS} -lws2_32"
+	AC_MSG_CHECKING([for MinGW inet_ntop()/inet_pton()])
+	AC_LINK_IFELSE(
+		[AC_LANG_PROGRAM(
+			[[
+#include <ws2tcpip.h>
+			]],
+			[[
+int r = (int) inet_ntop (0, NULL, NULL, 0);
+    r += inet_pton(AF_INET, NULL, NULL);
+return r;
+			]]
+		)],
+		[AC_MSG_RESULT([OK])
+		 AC_DEFINE([HAVE_INET_NTOP],[1],[MinGW inet_ntop])
+		 AC_DEFINE([HAVE_INET_PTON],[1],[MinGW inet_pton])
+		],
+		[AC_MSG_RESULT([not found])]
+	)
 	m4_foreach(
 		[F],
 		m4_split(SOCKET_FUNCS SOCKET_OPT_FUNCS),
@@ -651,6 +672,7 @@ if test "${WIN32}" = "yes"; then
 			AC_DEFINE([UF], [1], [Win32 builtin])
 	)
 else
+	AC_CHECK_FUNCS([inet_ntop inet_pton])
 	AC_CHECK_FUNCS(
 		SOCKET_FUNCS,
 		,
-- 
2.4.6


