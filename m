From: Selva Nair <selva.nair@...277...>
Date: Sun,  6 Dec 2015 19:01:46 -0500
Message-Id: <1449446507-16654-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH master] Add an autoconf macro to check
	WINAPI functions
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

This adds a macro file with a permissive license. Its small so I don't
mind inlining the macro into configure.ac if that is preferred.
-------8<--------

Makes configure tests for Windows API neater and consistent.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 check_symbols_in.m4 |   43 +++++++++++++++++++++++++++++++++++++++++++
 configure.ac        |   35 +++++++----------------------------
 2 files changed, 50 insertions(+), 28 deletions(-)
 create mode 100644 check_symbols_in.m4

diff --git a/check_symbols_in.m4 b/check_symbols_in.m4
new file mode 100644
index 0000000..339ac59
--- /dev/null
+++ b/check_symbols_in.m4
@@ -0,0 +1,43 @@
+dnl AX_CHECK_SYMBOL - check for a symbol in specified header files
+dnl
+dnl Usage: AX_CHECK_SYMBOL_IN(symbol, header [,action-if-found [,action-if-not-found]])
+dnl        AX_CHECK_SYMBOLS_IN(symbol..., header [,action-if-found [,action-if-not-found]])
+dnl If the symbol is found define HAVE_SYMBOL (with symbol capitalised) in addition to
+dnl running the optional 'action-if-found'
+dnl
+dnl Works as a complement to AC_CHECK_FUNCS for detecting stdcall
+dnl functions or functions renamed in headers. Especially useful
+dnl for Windows API
+dnl
+dnl Copyright (c) 2015 Selva Nair <selva.nair@...277...>
+dnl
+dnl LICENSE
+dnl Copying and distribution of this file, with or without modification,
+dnl are permitted in any medium without royalty provided the copyright
+dnl notice and this notice are preserved.  This file is offered as-is,
+dnl without any warranty.
+dnl
+AC_DEFUN([AX_CHECK_SYMBOL_IN],
+         [AC_CACHE_CHECK([for $1 in $2],
+          [AS_TR_SH([ac_cv_have_symbol_$1])],
+          [AC_TRY_COMPILE([#include <$2>], [(void) $1;],
+                [eval "AS_TR_SH([ac_cv_have_symbol_$1])=yes"],
+                [eval "AS_TR_SH([ac_cv_have_symbol_$1])=no"])dnl
+               ])
+if eval test "x$AS_TR_SH([ac_cv_have_symbol_$1])" = xyes; then
+    AC_DEFINE_UNQUOTED(AS_TR_CPP([HAVE_$1]), [1],
+                       [Define to 1 if you have $1.])dnl
+    [$3]
+else
+    ifelse([$4], ,[:], [$4])
+fi
+])dnl
+dnl
+dnl check for multiple symbols
+dnl Usage: AX_CHECK_SYMBOLS_IN(symbol..., header [,action-if-found [,action-if-not-found]])
+dnl
+AC_DEFUN([AX_CHECK_SYMBOLS_IN], [
+for ac_symbol in $1; do
+   AX_CHECK_SYMBOL_IN([$ac_symbol], [$2], [$3], [$4])dnl
+done
+])dnl
diff --git a/configure.ac b/configure.ac
index 721395d..1fb81d1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -627,7 +627,8 @@ AC_SUBST([SOCKETS_LIBS])
 old_LIBS="${LIBS}"
 LIBS="${LIBS} ${SOCKETS_LIBS}"
 AC_CHECK_FUNCS([sendmsg recvmsg])
-# Windows use stdcall for winsock so we cannot auto detect these
+# Windows use stdcall for winsock so use AX_CHECK_SYMBOLS_IN to detect these
+m4_include(check_symbols_in.m4)
 m4_define(
 	[SOCKET_FUNCS],
 [socket recv recvfrom send sendto listen dnl
@@ -638,33 +639,11 @@ m4_define(
 	[setsockopt getsockopt getsockname poll]dnl
 )
 if test "${WIN32}" = "yes"; then
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
+        AX_CHECK_SYMBOLS_IN([inet_ntop inet_pton], [ws2tcpip.h])
+        AX_CHECK_SYMBOLS_IN(SOCKET_FUNCS, [ws2tcpip.h], ,
+              [AC_MSG_ERROR([Required library function not found])]
+        )
+        AX_CHECK_SYMBOLS_IN(SOCKET_OPT_FUNCS, [ws2tcpip.h])
 else
 	AC_CHECK_FUNCS([inet_ntop inet_pton])
 	AC_CHECK_FUNCS(
-- 
1.7.10.4


