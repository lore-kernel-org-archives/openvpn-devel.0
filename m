From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:52 +0200
Message-Id: <1330546342-17794-23-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 22/52] build: split acinclude.m4 into m4/*
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

ax_emptyarray.m4  ax_openvpn_lib.m4  ax_socklen_t.m4  ax_varargs.m4

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 Makefile.am          |    1 +
 acinclude.m4         |  131 --------------------------------------------------
 configure.ac         |    1 +
 m4/ax_emptyarray.m4  |   27 ++++++++++
 m4/ax_openvpn_lib.m4 |    4 ++
 m4/ax_socklen_t.m4   |   50 +++++++++++++++++++
 m4/ax_varargs.m4     |   43 ++++++++++++++++
 7 files changed, 126 insertions(+), 131 deletions(-)
 delete mode 100644 acinclude.m4
 create mode 100644 m4/.keep
 create mode 100644 m4/ax_emptyarray.m4
 create mode 100644 m4/ax_openvpn_lib.m4
 create mode 100644 m4/ax_socklen_t.m4
 create mode 100644 m4/ax_varargs.m4

diff --git a/Makefile.am b/Makefile.am
index a14f4e1..4b883da 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -28,6 +28,7 @@ LDADD = @LIBOBJS@
 # This option prevents autoreconf from overriding our COPYING and
 # INSTALL targets:
 AUTOMAKE_OPTIONS = foreign
+ACLOCAL_AMFLAGS = -I m4
 
 MAINTAINERCLEANFILES = \
 	config.log config.status \
diff --git a/acinclude.m4 b/acinclude.m4
deleted file mode 100644
index 58e2a35..0000000
--- a/acinclude.m4
+++ /dev/null
@@ -1,131 +0,0 @@
-dnl Special Autoconf Macros for OpenVPN
-
-dnl OPENVPN_ADD_LIBS(LIB)
-AC_DEFUN([OPENVPN_ADD_LIBS], [
-  LIBS="$1 $LIBS"
-])
-
-dnl @synopsis AX_EMPTY_ARRAY
-dnl
-dnl Define EMPTY_ARRAY_SIZE to be either "0"
-dnl or "" depending on which syntax the compiler
-dnl prefers for empty arrays in structs.
-dnl
-dnl @version
-dnl @author James Yonan <jim@...41...>
-
-
-AC_DEFUN([AX_EMPTY_ARRAY], [
-  AC_MSG_RESULT([checking for C compiler empty array support])
-  AC_COMPILE_IFELSE([AC_LANG_SOURCE(
-    [
-        struct { int foo; int bar[[0]]; } mystruct;
-    ])], [
-        AC_DEFINE_UNQUOTED(EMPTY_ARRAY_SIZE, 0, [Dimension to use for empty array declaration])
-    ], [
-        AC_COMPILE_IFELSE([AC_LANG_SOURCE(
-	    [
-	        struct { int foo; int bar[[]]; } mystruct;
-	    ])], [
-                AC_DEFINE_UNQUOTED(EMPTY_ARRAY_SIZE,, [Dimension to use for empty array declaration])
-	    ], [
-	        AC_MSG_ERROR([C compiler is unable to creaty empty arrays])
-	    ])
-    ])
-  ]
-)
-
-dnl @synopsis AX_CPP_VARARG_MACRO_GCC
-dnl
-dnl Test if the preprocessor understands GNU GCC-style vararg macros.
-dnl If it does, defines HAVE_CPP_VARARG_MACRO_GCC to 1.
-dnl
-dnl @version
-dnl @author James Yonan <jim@...41...>, Matthias Andree <matthias.andree@...83...>
-AC_DEFUN([AX_CPP_VARARG_MACRO_GCC], [dnl
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
-])
-
-dnl @synopsis AX_CPP_VARARG_MACRO_ISO
-dnl
-dnl Test if the preprocessor understands ISO C 1999 vararg macros.
-dnl If it does, defines HAVE_CPP_VARARG_MACRO_ISO to 1.
-dnl
-dnl @version
-dnl @author James Yonan <jim@...41...>, Matthias Andree <matthias.andree@...83...>
-AC_DEFUN([AX_CPP_VARARG_MACRO_ISO], [dnl
-    AS_VAR_PUSHDEF([VAR],[ax_cv_cpp_vararg_macro_iso])dnl
-    AC_CACHE_CHECK([for ISO C 1999 vararg macro support], VAR, [dnl
-      AC_COMPILE_IFELSE([AC_LANG_SOURCE([
-#define macro(a, ...) func(a, __VA_ARGS__)
-	int func(int a, int b, int c);
-	int test() { return macro(1, 2, 3); }
-	])], [ VAR=yes ], [VAR=no])])
-    if test $VAR = yes ; then
-    AC_DEFINE([HAVE_CPP_VARARG_MACRO_ISO], 1,
-      [Define to 1 if your compiler supports ISO C99 variadic macros])
-    fi
-    AS_VAR_POPDEF([VAR])dnl
-])
-
-dnl -- The following is taken from curl's acinclude.m4 --
-dnl Check for socklen_t: historically on BSD it is an int, and in
-dnl POSIX 1g it is a type of its own, but some platforms use different
-dnl types for the argument to getsockopt, getpeername, etc.  So we
-dnl have to test to find something that will work.
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
-#ifdef WIN32
-#include <ws2tcpip.h>
-#else
-#include <sys/socket.h>
-#endif])
-])
diff --git a/configure.ac b/configure.ac
index 3346e9f..fbed6bf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,6 +32,7 @@ AC_CONFIG_SRCDIR(syshead.h)
 
 dnl Guess host type.
 AC_CANONICAL_HOST
+AC_CONFIG_MACRO_DIR([m4])
 AM_INIT_AUTOMAKE(openvpn, [$PACKAGE_VERSION])
 
 AC_ARG_WITH(cygwin-native,
diff --git a/m4/.keep b/m4/.keep
new file mode 100644
index 0000000..e69de29
diff --git a/m4/ax_emptyarray.m4 b/m4/ax_emptyarray.m4
new file mode 100644
index 0000000..0a8755c
--- /dev/null
+++ b/m4/ax_emptyarray.m4
@@ -0,0 +1,27 @@
+dnl @synopsis AX_EMPTY_ARRAY
+dnl
+dnl Define EMPTY_ARRAY_SIZE to be either "0"
+dnl or "" depending on which syntax the compiler
+dnl prefers for empty arrays in structs.
+dnl
+dnl @version
+dnl @author James Yonan <jim@...41...>
+AC_DEFUN([AX_EMPTY_ARRAY], [
+  AC_MSG_RESULT([checking for C compiler empty array support])
+  AC_COMPILE_IFELSE([AC_LANG_SOURCE(
+    [
+        struct { int foo; int bar[[0]]; } mystruct;
+    ])], [
+        AC_DEFINE_UNQUOTED(EMPTY_ARRAY_SIZE, 0, [Dimension to use for empty array declaration])
+    ], [
+        AC_COMPILE_IFELSE([AC_LANG_SOURCE(
+	    [
+	        struct { int foo; int bar[[]]; } mystruct;
+	    ])], [
+                AC_DEFINE_UNQUOTED(EMPTY_ARRAY_SIZE,, [Dimension to use for empty array declaration])
+	    ], [
+	        AC_MSG_ERROR([C compiler is unable to creaty empty arrays])
+	    ])
+    ])
+  ]
+)
diff --git a/m4/ax_openvpn_lib.m4 b/m4/ax_openvpn_lib.m4
new file mode 100644
index 0000000..bcfe1ab
--- /dev/null
+++ b/m4/ax_openvpn_lib.m4
@@ -0,0 +1,4 @@
+dnl OPENVPN_ADD_LIBS(LIB)
+AC_DEFUN([OPENVPN_ADD_LIBS], [
+  LIBS="$1 $LIBS"
+])
diff --git a/m4/ax_socklen_t.m4 b/m4/ax_socklen_t.m4
new file mode 100644
index 0000000..70ddcc2
--- /dev/null
+++ b/m4/ax_socklen_t.m4
@@ -0,0 +1,50 @@
+dnl -- The following is taken from curl's acinclude.m4 --
+dnl Check for socklen_t: historically on BSD it is an int, and in
+dnl POSIX 1g it is a type of its own, but some platforms use different
+dnl types for the argument to getsockopt, getpeername, etc.  So we
+dnl have to test to find something that will work.
+AC_DEFUN([TYPE_SOCKLEN_T],
+[
+   AC_CHECK_TYPE([socklen_t], ,[
+      AC_MSG_CHECKING([for socklen_t equivalent])
+      AC_CACHE_VAL([curl_cv_socklen_t_equiv],
+      [
+         case "$host" in
+	 *-mingw*) curl_cv_socklen_t_equiv=int ;;
+	 *)
+            # Systems have either "struct sockaddr *" or
+            # "void *" as the second argument to getpeername
+            curl_cv_socklen_t_equiv=
+            for arg2 in "struct sockaddr" void; do
+               for t in int size_t unsigned long "unsigned long"; do
+                  AC_TRY_COMPILE([
+                     #include <sys/types.h>
+                     #include <sys/socket.h>
+
+                     int getpeername (int, $arg2 *, $t *);
+                  ],[
+                     $t len;
+                     getpeername(0,0,&len);
+                  ],[
+                     curl_cv_socklen_t_equiv="$t"
+                     break
+                  ])
+               done
+            done
+	 ;;
+	 esac
+
+         if test "x$curl_cv_socklen_t_equiv" = x; then
+            AC_MSG_ERROR([Cannot find a type to use in place of socklen_t])
+         fi
+      ])
+      AC_MSG_RESULT($curl_cv_socklen_t_equiv)
+      AC_DEFINE_UNQUOTED(socklen_t, $curl_cv_socklen_t_equiv,
+			[type to use in place of socklen_t if not defined])],
+      [#include <sys/types.h>
+#ifdef WIN32
+#include <ws2tcpip.h>
+#else
+#include <sys/socket.h>
+#endif])
+])
diff --git a/m4/ax_varargs.m4 b/m4/ax_varargs.m4
new file mode 100644
index 0000000..fd5e8b0
--- /dev/null
+++ b/m4/ax_varargs.m4
@@ -0,0 +1,43 @@
+dnl @synopsis AX_CPP_VARARG_MACRO_GCC
+dnl
+dnl Test if the preprocessor understands GNU GCC-style vararg macros.
+dnl If it does, defines HAVE_CPP_VARARG_MACRO_GCC to 1.
+dnl
+dnl @version
+dnl @author James Yonan <jim@...41...>, Matthias Andree <matthias.andree@...83...>
+AC_DEFUN([AX_CPP_VARARG_MACRO_GCC], [dnl
+    AS_VAR_PUSHDEF([VAR],[ax_cv_cpp_vararg_macro_gcc])dnl
+    AC_CACHE_CHECK([for GNU GCC vararg macro support], VAR, [dnl
+      AC_COMPILE_IFELSE([AC_LANG_SOURCE([
+	#define macro(a, b...) func(a, b)
+	int func(int a, int b, int c);
+	int test() { return macro(1, 2, 3); }
+	])], [ VAR=yes ], [VAR=no])])
+    if test $VAR = yes ; then
+    AC_DEFINE([HAVE_CPP_VARARG_MACRO_GCC], 1,
+      [Define to 1 if your compiler supports GNU GCC-style variadic macros])
+    fi
+    AS_VAR_POPDEF([VAR])dnl
+])
+
+dnl @synopsis AX_CPP_VARARG_MACRO_ISO
+dnl
+dnl Test if the preprocessor understands ISO C 1999 vararg macros.
+dnl If it does, defines HAVE_CPP_VARARG_MACRO_ISO to 1.
+dnl
+dnl @version
+dnl @author James Yonan <jim@...41...>, Matthias Andree <matthias.andree@...83...>
+AC_DEFUN([AX_CPP_VARARG_MACRO_ISO], [dnl
+    AS_VAR_PUSHDEF([VAR],[ax_cv_cpp_vararg_macro_iso])dnl
+    AC_CACHE_CHECK([for ISO C 1999 vararg macro support], VAR, [dnl
+      AC_COMPILE_IFELSE([AC_LANG_SOURCE([
+#define macro(a, ...) func(a, __VA_ARGS__)
+	int func(int a, int b, int c);
+	int test() { return macro(1, 2, 3); }
+	])], [ VAR=yes ], [VAR=no])])
+    if test $VAR = yes ; then
+    AC_DEFINE([HAVE_CPP_VARARG_MACRO_ISO], 1,
+      [Define to 1 if your compiler supports ISO C99 variadic macros])
+    fi
+    AS_VAR_POPDEF([VAR])dnl
+])
-- 
1.7.3.4


