From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:43 +0300
Message-Id: <1336850389-23719-11-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 10/16] cleanup: syshead: split pedantic into
	pedantic, lint
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Split pedantic into two: pedantic (compiler only), lint (functional).
Move settings into basic.h.
Remove lint stub in tun.c.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac          |   18 ++++++++++++++++--
 src/openvpn/basic.h   |   14 ++++++++++++++
 src/openvpn/error.h   |    2 +-
 src/openvpn/openvpn.c |    2 +-
 src/openvpn/syshead.h |   16 ----------------
 src/openvpn/tun.c     |   12 ------------
 6 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9fcd7fe..078e46f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -202,12 +202,19 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[pedantic],
-	[AS_HELP_STRING([--enable-pedantic], [enable pedantic compiler warnings, will not generate a working executable (debugging option) @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-pedantic], [enable pedantic compiler warnings (debugging option) @<:@default=no@:>@])],
 	,
 	[enable_pedantic="no"]
 )
 
 AC_ARG_ENABLE(
+	[lint],
+	[AS_HELP_STRING([--enable-lint], [enable lint friendly build, will not generate a working executable (debugging option) @<:@default=no@:>@])],
+	,
+	[enable_lint="no"]
+)
+
+AC_ARG_ENABLE(
 	[strict-options],
 	[AS_HELP_STRING([--enable-strict-options], [enable strict options check between peers (debugging option) @<:@default=no@:>@])],
 	,
@@ -342,7 +349,6 @@ ifdef(
 )
 
 AC_C_CONST
-AC_C_INLINE
 AC_C_VOLATILE
 AC_TYPE_OFF_T
 AC_TYPE_PID_T
@@ -938,6 +944,10 @@ if test "${enable_pkcs11}" = "yes"; then
 	AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])
 fi
 
+if test "${enable_lint}" = "yes"; then
+	enable_pedantic="yes"
+	AC_DEFINE([ENABLE_LINT], [1], [Enable lint build])
+fi
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
 	CFLAGS="${CFLAGS} -pedantic"
@@ -947,6 +957,10 @@ if test "${enable_strict}" = "yes"; then
 	CFLAGS="${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
 fi
 
+# check inline after pedantic/lint CFLAGS as it may produce
+# different result
+AC_C_INLINE
+
 if test "${WIN32}" = "yes"; then
 	test -z "${MAN2HTML}" && AC_MSG_ERROR([man2html is required for win32])
 fi
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index f2d5041..9746315 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -44,4 +44,18 @@
 # define unlikely(x)    (x)
 #endif
 
+/*
+ * Lint mode is meant to accomplish lint-style program checking,
+ * not to build a working executable.
+ */
+#ifdef ENABLE_LINT
+# undef HAVE_CPP_VARARG_MACRO_GCC
+# undef HAVE_CPP_VARARG_MACRO_ISO
+# undef EMPTY_ARRAY_SIZE
+# define EMPTY_ARRAY_SIZE 1
+# ifdef inline
+#  undef inline
+# endif
+#endif
+
 #endif
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index ed8f903..fb7fad7 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -165,7 +165,7 @@ bool dont_mute (unsigned int flags); /* check muting filter */
 #  define dmsg(flags, args...)
 # endif
 #else
-# if !PEDANTIC
+# ifndef ENABLE_LINT
 #  ifdef _MSC_VER
 #   pragma message("this compiler appears to lack vararg macros which will cause a significant degradation in efficiency")
 #  else
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 75c751d..acba8e9 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -132,7 +132,7 @@ main (int argc, char *argv[])
 {
   struct context c;
 
-#if PEDANTIC
+#ifdef ENABLE_LINT
   fprintf (stderr, "Sorry, I was built with --enable-pedantic and I am incapable of doing any real work!\n");
   return 1;
 #endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index d095799..e522876 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -335,22 +335,6 @@
 #endif
 
 /*
- * Pedantic mode is meant to accomplish lint-style program checking,
- * not to build a working executable.
- */
-#ifdef __STRICT_ANSI__
-# define PEDANTIC 1
-# undef HAVE_CPP_VARARG_MACRO_GCC
-# undef HAVE_CPP_VARARG_MACRO_ISO
-# undef EMPTY_ARRAY_SIZE
-# define EMPTY_ARRAY_SIZE 1
-# undef inline
-# define inline
-#else
-# define PEDANTIC 0
-#endif
-
-/*
  * Do we have the capability to support the --passtos option?
  */
 #if defined(IPPROTO_IP) && defined(IP_TOS) && defined(HAVE_SETSOCKOPT)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 633150f..71abbf3 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1373,8 +1373,6 @@ close_tun_generic (struct tuntap *tt)
 #error header file linux/sockios.h required
 #endif
 
-#if !PEDANTIC
-
 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 {
@@ -1487,16 +1485,6 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 {
-  ASSERT (0);
-}
-
-#endif
-
-#else
-
-void
-open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
-{
   open_tun_generic (dev, dev_type, dev_node, false, true, tt);
 }
 
-- 
1.7.3.4


