From: David Sommerseth <dazo@...384...>
Date: Thu, 11 Mar 2010 17:01:59 +0100
Message-Id: <1268323319-7161-1-git-send-email-dazo@...384...>
In-Reply-To: <4B8ADF36.3050201@...1114...>
References: <4B8ADF36.3050201@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix autotools cross-compiling support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

This is a modified version of a patch sent to the sf.net
patch tracker:
<http://sourceforge.net/tracker/?func=detail&aid=2491190&group_id=48978&atid=454721>

After having disucssed this patch on IRC (#openvpn-discussions)
March 4, 2010, it was decided to accept this patch when not modifying
TARGET_* defines through out the code.  Further, in a mail comment
Alon Bar-Lev had some other comments of what would be needed to be done.

Mail reference:
<http://thread.gmane.org/gmane.network.openvpn.devel/3176>

This patch has been tested by bootstrapping the code on a RHEL4.6 box.
with the following autotools packages installed:
autoconf-2.59-5
automake-1.9.2-3
libtool-1.5.6-4.EL4.2

It builds cleanly and 'make check' passes.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 acinclude.m4 |   10 +++++-----
 configure.ac |   35 +++++++++++++++++------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index f099de5..2d49020 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -224,8 +224,8 @@ acx_pthread_flags="pthreads none -Kthread -kthread lthread -pthread -pthreads -m
 # pthread: Linux, etcetera
 # --thread-safe: KAI C++
 
-case "$target" in
-        *solaris*)
+case "$host" in
+        *-*-solaris*)
 
         # On Solaris (at least, for some versions), libc contains stubbed
         # (non-functional) versions of the pthreads routines, so link-based
@@ -321,9 +321,9 @@ if test "x$acx_pthread_ok" = xyes; then
 
         AC_MSG_CHECKING([if more special flags are required for pthreads])
         flag=no
-        case "$target" in
-                *-aix* | *-freebsd*)               flag="-D_THREAD_SAFE";;
-                *solaris* | alpha*-osf* | *linux*) flag="-D_REENTRANT";;
+        case "$host" in
+                *-*-aix* | *-freebsd*)               flag="-D_THREAD_SAFE";;
+                *-*-solaris* | alpha*-osf* | *linux*) flag="-D_REENTRANT";;
         esac
         AC_MSG_RESULT(${flag})
         if test "x$flag" != xno; then
diff --git a/configure.ac b/configure.ac
index 116ff7c..a829a7d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,7 +32,6 @@ AC_CONFIG_SRCDIR(syshead.h)
 
 dnl Guess host type.
 AC_CANONICAL_HOST
-AC_CANONICAL_SYSTEM
 AM_INIT_AUTOMAKE(openvpn, [$PACKAGE_VERSION])
 
 AC_ARG_WITH(cygwin-native,
@@ -44,11 +43,11 @@ AC_ARG_WITH(cygwin-native,
 WIN32="no"
 CYGWIN="no"
 case "${host}" in
-	*-mingw*)
+	*-*-mingw*)
 		WIN32="yes"
 		cross_compiling="yes"
 	;;
-	*-cygwin*)
+	*-*-cygwin*)
 		AC_MSG_CHECKING([cygwin mode to use])
 		if test "${CYGWIN_NATIVE}" = "yes"; then
 			AC_MSG_RESULT([Using native win32])
@@ -275,38 +274,38 @@ AC_ARG_WITH(mem-check,
 dnl fix search path, to allow compilers to find syshead.h
 CPPFLAGS="$CPPFLAGS -I${srcdir}"
 
-dnl check target OS
-openvpn_target=$target
-if test $target_alias; then
-  openvpn_target=$target_alias
+dnl check host OS
+openvpn_host=$host
+if test $host_alias; then
+  openvpn_host=$host_alias
 fi
-AC_DEFINE_UNQUOTED(TARGET_ALIAS, "$openvpn_target", [A string representing our target])
-case "$target" in
-*linux*)
+AC_DEFINE_UNQUOTED(TARGET_ALIAS, "$openvpn_host", [A string representing our host])
+case "$host" in
+*-*-linux*)
 	AC_DEFINE(TARGET_LINUX, 1, [Are we running on Linux?])
 	dnl RH9 SSL headers workaround
         if test -z $CS_HDR_DIR && test "$CRYPTO" = "yes"; then
            CPPFLAGS="$CPPFLAGS $(pkg-config --cflags openssl 2>/dev/null)"
         fi
 	;;
-*solaris*)
+*-*-solaris*)
 	AC_DEFINE(TARGET_SOLARIS, 1, [Are we running on Solaris?])
 	;;
-*openbsd*)
+*-*-openbsd*)
 	AC_DEFINE(TARGET_OPENBSD, 1, [Are we running on OpenBSD?])
 	;;
-*freebsd*)
+*-*-freebsd*)
 	AC_DEFINE(TARGET_FREEBSD, 1, [Are we running on FreeBSD?])
 	;;
-*netbsd*)
+*-*-netbsd*)
 	AC_DEFINE(TARGET_NETBSD, 1, [Are we running NetBSD?])
 	;;
-*darwin*)
+*-*-darwin*)
 	dnl some Mac OS X tendering (we use vararg macros...)
 	AC_DEFINE(TARGET_DARWIN, 1, [Are we running on Mac OS X?])
 	CPPFLAGS="$CPPFLAGS -no-cpp-precomp"
 	;;
-*mingw*)
+*-*-mingw*)
 	AC_DEFINE(TARGET_WIN32, 1, [Are we running WIN32?])
 	OPENVPN_ADD_LIBS(-lgdi32)
 	OPENVPN_ADD_LIBS(-lws2_32)
@@ -315,7 +314,7 @@ case "$target" in
 	OPENVPN_ADD_LIBS(-liphlpapi)
 	OPENVPN_ADD_LIBS(-lwinmm)
 	;;
-*dragonfly*)
+*-*-dragonfly*)
 	AC_DEFINE(TARGET_DRAGONFLY, 1, [Are we running on DragonFlyBSD?])
 	;;
 	
@@ -574,7 +573,7 @@ if test "$PTHREAD" = "yes"; then
   AC_MSG_RESULT([********* WARNING: pthread support is experimental for OpenVPN 2.0])
   ACX_PTHREAD(
         [
-	    case "$target" in
+	    case "$host" in
 	    *openbsd*)
 		AC_MSG_RESULT([WARNING: pthread support on OpenBSD is unstable!])
 		CFLAGS="$CFLAGS -pthread"
-- 
1.5.4.7


