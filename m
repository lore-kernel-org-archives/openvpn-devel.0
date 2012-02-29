From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:53 +0200
Message-Id: <1330546342-17794-24-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 23/52] build: m4/ax_varargs.m4: cleanup
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
 m4/ax_varargs.m4 |   78 ++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/m4/ax_varargs.m4 b/m4/ax_varargs.m4
index fd5e8b0..37cdebe 100644
--- a/m4/ax_varargs.m4
+++ b/m4/ax_varargs.m4
@@ -6,18 +6,34 @@ dnl
 dnl @version
 dnl @author James Yonan <jim@...41...>, Matthias Andree <matthias.andree@...83...>
 AC_DEFUN([AX_CPP_VARARG_MACRO_GCC], [dnl
-    AS_VAR_PUSHDEF([VAR],[ax_cv_cpp_vararg_macro_gcc])dnl
-    AC_CACHE_CHECK([for GNU GCC vararg macro support], VAR, [dnl
-      AC_COMPILE_IFELSE([AC_LANG_SOURCE([
-	#define macro(a, b...) func(a, b)
-	int func(int a, int b, int c);
-	int test() { return macro(1, 2, 3); }
-	])], [ VAR=yes ], [VAR=no])])
-    if test $VAR = yes ; then
-    AC_DEFINE([HAVE_CPP_VARARG_MACRO_GCC], 1,
-      [Define to 1 if your compiler supports GNU GCC-style variadic macros])
-    fi
-    AS_VAR_POPDEF([VAR])dnl
+	AS_VAR_PUSHDEF([VAR], [ax_cv_cpp_vararg_macro_gcc])dnl
+	AC_CACHE_CHECK(
+		[for GNU GCC vararg macro support],
+		[VAR],
+		[AC_COMPILE_IFELSE(
+			[AC_LANG_PROGRAM(
+				,
+				[[
+#define macro(a, b...) func(a, b)
+int func(int a, int b, int c);
+int test() { return macro(1, 2, 3); }
+				]]
+			)],
+			[VAR=yes],
+			[VAR=no]
+		)]
+	)dnl
+
+	AS_VAR_IF(
+		[VAR],
+		[yes],
+		[AC_DEFINE(
+			[HAVE_CPP_VARARG_MACRO_GCC],
+			[1], 
+			[Define to 1 if your compiler supports GNU GCC-style variadic macros]
+		)]
+	)dnl
+	AS_VAR_POPDEF([VAR])dnl
 ])
 
 dnl @synopsis AX_CPP_VARARG_MACRO_ISO
@@ -28,16 +44,32 @@ dnl
 dnl @version
 dnl @author James Yonan <jim@...41...>, Matthias Andree <matthias.andree@...83...>
 AC_DEFUN([AX_CPP_VARARG_MACRO_ISO], [dnl
-    AS_VAR_PUSHDEF([VAR],[ax_cv_cpp_vararg_macro_iso])dnl
-    AC_CACHE_CHECK([for ISO C 1999 vararg macro support], VAR, [dnl
-      AC_COMPILE_IFELSE([AC_LANG_SOURCE([
+	AS_VAR_PUSHDEF([VAR],[ax_cv_cpp_vararg_macro_iso])dnl
+	AC_CACHE_CHECK(
+		[for ISO C 1999 vararg macro support],
+		[VAR],
+		[AC_COMPILE_IFELSE(
+			[AC_LANG_PROGRAM(
+				,
+				[[
 #define macro(a, ...) func(a, __VA_ARGS__)
-	int func(int a, int b, int c);
-	int test() { return macro(1, 2, 3); }
-	])], [ VAR=yes ], [VAR=no])])
-    if test $VAR = yes ; then
-    AC_DEFINE([HAVE_CPP_VARARG_MACRO_ISO], 1,
-      [Define to 1 if your compiler supports ISO C99 variadic macros])
-    fi
-    AS_VAR_POPDEF([VAR])dnl
+int func(int a, int b, int c);
+int test() { return macro(1, 2, 3); }
+				]]
+			)],
+			[VAR=yes],
+			[VAR=no]
+		)]
+	)dnl
+
+	AS_VAR_IF(
+		[VAR],
+		[yes],
+		[AC_DEFINE(
+			[HAVE_CPP_VARARG_MACRO_ISO],
+			[1], 
+			[Define to 1 if your compiler supports ISO C99 variadic macros]
+		)]
+	)dnl
+	AS_VAR_POPDEF([VAR])dnl
 ])
-- 
1.7.3.4


