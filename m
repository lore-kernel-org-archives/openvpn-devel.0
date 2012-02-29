From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:55 +0200
Message-Id: <1330546342-17794-26-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 25/52] build: m4/ax_socklen_t.m4: cleanup
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac       |    2 +-
 m4/ax_socklen_t.m4 |   97 ++++++++++++++++++++++++++++++----------------------
 2 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/configure.ac b/configure.ac
index fbed6bf..69a3736 100644
--- a/configure.ac
+++ b/configure.ac
@@ -381,10 +381,10 @@ AC_TYPE_OFF_T
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
 AC_TYPE_UID_T
-TYPE_SOCKLEN_T
 AC_HEADER_TIME
 AX_CPP_VARARG_MACRO_ISO
 AX_CPP_VARARG_MACRO_GCC
+AX_TYPE_SOCKLEN_T
 AX_EMPTY_ARRAY
 
 dnl Check for more header files.
diff --git a/m4/ax_socklen_t.m4 b/m4/ax_socklen_t.m4
index 70ddcc2..cd7cad8 100644
--- a/m4/ax_socklen_t.m4
+++ b/m4/ax_socklen_t.m4
@@ -1,50 +1,65 @@
-dnl -- The following is taken from curl's acinclude.m4 --
+dnl -- The following is base of curl's acinclude.m4 --
 dnl Check for socklen_t: historically on BSD it is an int, and in
 dnl POSIX 1g it is a type of its own, but some platforms use different
 dnl types for the argument to getsockopt, getpeername, etc.  So we
 dnl have to test to find something that will work.
-AC_DEFUN([TYPE_SOCKLEN_T],
-[
-   AC_CHECK_TYPE([socklen_t], ,[
-      AC_MSG_CHECKING([for socklen_t equivalent])
-      AC_CACHE_VAL([curl_cv_socklen_t_equiv],
-      [
-         case "$host" in
-	 *-mingw*) curl_cv_socklen_t_equiv=int ;;
-	 *)
-            # Systems have either "struct sockaddr *" or
-            # "void *" as the second argument to getpeername
-            curl_cv_socklen_t_equiv=
-            for arg2 in "struct sockaddr" void; do
-               for t in int size_t unsigned long "unsigned long"; do
-                  AC_TRY_COMPILE([
-                     #include <sys/types.h>
-                     #include <sys/socket.h>
-
-                     int getpeername (int, $arg2 *, $t *);
-                  ],[
-                     $t len;
-                     getpeername(0,0,&len);
-                  ],[
-                     curl_cv_socklen_t_equiv="$t"
-                     break
-                  ])
-               done
-            done
-	 ;;
-	 esac
-
-         if test "x$curl_cv_socklen_t_equiv" = x; then
-            AC_MSG_ERROR([Cannot find a type to use in place of socklen_t])
-         fi
-      ])
-      AC_MSG_RESULT($curl_cv_socklen_t_equiv)
-      AC_DEFINE_UNQUOTED(socklen_t, $curl_cv_socklen_t_equiv,
-			[type to use in place of socklen_t if not defined])],
-      [#include <sys/types.h>
+AC_DEFUN([AX_TYPE_SOCKLEN_T], [
+	AC_CHECK_TYPE(
+		[socklen_t],
+		,
+		[
+			AS_VAR_PUSHDEF([VAR],[ax_cv_socklen_t_equiv])dnl
+			AC_CACHE_CHECK(
+				[for socklen_t equivalent],
+				[VAR],
+				[
+					#AS_CASE is not supported on <autoconf-2.60
+					case "${host}" in
+					*-mingw*) VAR=int ;;
+					*)
+						# Systems have either "struct sockaddr *" or
+						# "void *" as the second argument to getpeername
+						for arg2 in "struct sockaddr" void; do
+							for t in int size_t unsigned long "unsigned long"; do
+								AC_COMPILE_IFELSE(
+									[AC_LANG_PROGRAM(
+										[[
+#include <sys/types.h>
+#include <sys/socket.h>
+int getpeername (int, $arg2 *, $t *);
+										]],
+										[[
+$t len;
+getpeername(0,0,&len);
+										]]
+									)],
+									[VAR="$t"; break]
+								)
+							done
+							test -n "$VAR" && break
+						done
+						;;
+					esac
+				]
+				AS_VAR_IF(
+					[VAR],
+					[],
+					[AC_MSG_ERROR([Cannot find a type to use in place of socklen_t])],
+					[AC_DEFINE_UNQUOTED(
+						[socklen_t],
+						[$VAR],
+						[type to use in place of socklen_t if not defined]
+					)]
+				)
+			)
+		],
+		[[
+#include <sys/types.h>
 #ifdef WIN32
 #include <ws2tcpip.h>
 #else
 #include <sys/socket.h>
-#endif])
+#endif
+		]]
+	)
 ])
-- 
1.7.3.4


