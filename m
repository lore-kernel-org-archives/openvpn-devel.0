From: Arne Schwabe <arne@...1227...>
Date: Sun, 28 Mar 2021 14:53:03 +0200
Message-Id: <20210328125303.326-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove support for non ISO C99 vararg
 support
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

We ISO C99 as minimum support for our source code and all compilers
should support the ISO C99 macros. Especially gcc does not need
the gcc extensions anymore. Also MSVC has support for it (as defined
in the config-msvc.h but also double checked)

LCLINT seems to be a C analyzer that history has forgotten about. I could
only find https://splint.org/release1.3.html and an similarly old research
paper.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 config-msvc.h       |  1 -
 m4/ax_varargs.m4    | 77 ---------------------------------------------
 src/openvpn/error.c |  4 ---
 src/openvpn/error.h | 21 -------------
 src/tapctl/error.h  |  1 -
 5 files changed, 104 deletions(-)
 delete mode 100644 m4/ax_varargs.m4

diff --git a/config-msvc.h b/config-msvc.h
index 0260927ce..4db9efae2 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -47,7 +47,6 @@
 #define HAVE_ACCESS 1
 #define HAVE_CHDIR 1
 #define HAVE_CHSIZE 1
-#define HAVE_CPP_VARARG_MACRO_ISO 1
 #define HAVE_CTIME 1
 #define HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH 1
 #define HAVE_IN_PKTINFO 1
diff --git a/m4/ax_varargs.m4 b/m4/ax_varargs.m4
deleted file mode 100644
index c295d21f4..000000000
--- a/m4/ax_varargs.m4
+++ /dev/null
@@ -1,77 +0,0 @@
-dnl @synopsis AX_CPP_VARARG_MACRO_GCC
-dnl
-dnl Test if the preprocessor understands GNU GCC-style vararg macros.
-dnl If it does, defines HAVE_CPP_VARARG_MACRO_GCC to 1.
-dnl
-dnl @version
-dnl @author James Yonan <jim@...41...>, Matthias Andree <matthias.andree@...83...>
-AC_DEFUN([AX_CPP_VARARG_MACRO_GCC], [dnl
-	AS_VAR_PUSHDEF([VAR], [ax_cv_cpp_vararg_macro_gcc])dnl
-	AC_CACHE_CHECK(
-		[for GNU GCC vararg macro support],
-		[VAR],
-		[AC_COMPILE_IFELSE(
-			[AC_LANG_PROGRAM(
-				[[
-#define macro(a, b...) func(a, b)
-int func(int a, int b, int c);
-				]],
-				[[
-int i = macro(1, 2, 3);
-				]]
-			)],
-			[VAR=yes],
-			[VAR=no]
-		)]
-	)dnl
-
-	AS_VAR_IF(
-		[VAR],
-		[yes],
-		[AC_DEFINE(
-			[HAVE_CPP_VARARG_MACRO_GCC],
-			[1], 
-			[Define to 1 if your compiler supports GNU GCC-style variadic macros]
-		)]
-	)dnl
-	AS_VAR_POPDEF([VAR])dnl
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
-	AS_VAR_PUSHDEF([VAR],[ax_cv_cpp_vararg_macro_iso])dnl
-	AC_CACHE_CHECK(
-		[for ISO C 1999 vararg macro support],
-		[VAR],
-		[AC_COMPILE_IFELSE(
-			[AC_LANG_PROGRAM(
-				[[
-#define macro(a, ...) func(a, __VA_ARGS__)
-int func(int a, int b, int c);
-				]],
-				[[
-int i = macro(1, 2, 3);
-				]]
-			)],
-			[VAR=yes],
-			[VAR=no]
-		)]
-	)dnl
-
-	AS_VAR_IF(
-		[VAR],
-		[yes],
-		[AC_DEFINE(
-			[HAVE_CPP_VARARG_MACRO_ISO],
-			[1], 
-			[Define to 1 if your compiler supports ISO C99 variadic macros]
-		)]
-	)dnl
-	AS_VAR_POPDEF([VAR])dnl
-])
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 0ecbfc330..e6f7ff0ff 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -236,26 +236,22 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
 
     void usage_small(void);
 
-#ifndef HAVE_VARARG_MACROS
     /* the macro has checked this otherwise */
     if (!msg_test(flags))
     {
         return;
     }
-#endif
 
     e = openvpn_errno();
 
     /*
      * Apply muting filter.
      */
-#ifndef HAVE_VARARG_MACROS
     /* the macro has checked this otherwise */
     if (!dont_mute(flags))
     {
         return;
     }
-#endif
 
     gc_init(&gc);
 
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index eaedf172c..1a5521654 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -146,33 +146,12 @@ bool dont_mute(unsigned int flags);
 /* Macro to ensure (and teach static analysis tools) we exit on fatal errors */
 #define EXIT_FATAL(flags) do { if ((flags) & M_FATAL) {_exit(1);}} while (false)
 
-#if defined(HAVE_CPP_VARARG_MACRO_ISO) && !defined(__LCLINT__)
-#define HAVE_VARARG_MACROS
 #define msg(flags, ...) do { if (msg_test(flags)) {x_msg((flags), __VA_ARGS__);} EXIT_FATAL(flags); } while (false)
 #ifdef ENABLE_DEBUG
 #define dmsg(flags, ...) do { if (msg_test(flags)) {x_msg((flags), __VA_ARGS__);} EXIT_FATAL(flags); } while (false)
 #else
 #define dmsg(flags, ...)
 #endif
-#elif defined(HAVE_CPP_VARARG_MACRO_GCC) && !defined(__LCLINT__)
-#define HAVE_VARARG_MACROS
-#define msg(flags, args ...) do { if (msg_test(flags)) {x_msg((flags), args);} EXIT_FATAL(flags); } while (false)
-#ifdef ENABLE_DEBUG
-#define dmsg(flags, args ...) do { if (msg_test(flags)) {x_msg((flags), args);} EXIT_FATAL(flags); } while (false)
-#else
-#define dmsg(flags, args ...)
-#endif
-#else  /* if defined(HAVE_CPP_VARARG_MACRO_ISO) && !defined(__LCLINT__) */
-#if !PEDANTIC
-#ifdef _MSC_VER
-#pragma message("this compiler appears to lack vararg macros which will cause a significant degradation in efficiency")
-#else
-#warning this compiler appears to lack vararg macros which will cause a significant degradation in efficiency (you can ignore this warning if you are using LCLINT)
-#endif
-#endif
-#define msg x_msg
-#define dmsg x_msg
-#endif /* if defined(HAVE_CPP_VARARG_MACRO_ISO) && !defined(__LCLINT__) */
 
 void x_msg(const unsigned int flags, const char *format, ...)
 #ifdef __GNUC__
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index 924cbbe89..cea50ba52 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -67,7 +67,6 @@ bool dont_mute(unsigned int flags);
 #endif
 #define EXIT_FATAL(flags) do { if ((flags) & M_FATAL) {_exit(1);}} while (false)
 
-#define HAVE_VARARG_MACROS
 #define msg(flags, ...) do { if (msg_test(flags)) {x_msg((flags), __VA_ARGS__);} EXIT_FATAL(flags); } while (false)
 #ifdef ENABLE_DEBUG
 #define dmsg(flags, ...) do { if (msg_test(flags)) {x_msg((flags), __VA_ARGS__);} EXIT_FATAL(flags); } while (false)
-- 
2.30.1


