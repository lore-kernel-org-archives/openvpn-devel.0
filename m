From: David Sommerseth <davids@...515...>
Date: Thu,  7 Sep 2017 03:22:25 +0200
Message-Id: <20170907012225.21661-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] lz4: Changing how LZ4 library handling is
 done
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

This change will expect the system to have LZ4 libraries and headers
installed by default.  We still carry a bundled LZ4 library, which
must now be explicitly enabled through providing --enable-bundled-lz4
to ./configure.  Otherwise, as before, --disable-lz4 will completely
remove any LZ4 support.

Also improve the autoconf code slightly, to use AS_HELP_STRING() where
needed and wrap some strings/values with [] where it was missing in
the LZ4 segment of ./confiugre.ac.

Signed-off-by: David Sommerseth <davids@...515...>
---
 Changes.rst            |  8 +++++++
 configure.ac           | 57 ++++++++++++++++++++++++++------------------------
 src/compat/Makefile.am |  5 ++++-
 3 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 53a14438..128f148a 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -308,6 +308,14 @@ User-visible Changes
 
 Maintainer-visible changes
 --------------------------
+- OpenVPN will not use the bundled LZ4 library by default if a system
+  library have not been found.  The bundled library needs to be enabled
+  explicitly by adding --enable-bundled-lz4 to ./configure.  This is to
+  remove any ambiguity of which library is being used.  And defaulting to
+  use the system library is best from a security perspective; this way the
+  LZ4 library can be updated externally without requiring OpenVPN to be
+  rebuilt and packaged.
+
 - OpenVPN no longer supports building with crypto support, but without TLS
   support.  As a consequence, OPENSSL_CRYPTO_{CFLAGS,LIBS} and
   OPENSSL_SSL_{CFLAGS,LIBS} have been merged into OPENSSL_{CFLAGS,LIBS}.  This
diff --git a/configure.ac b/configure.ac
index 6f1044e8..a33e9172 100644
--- a/configure.ac
+++ b/configure.ac
@@ -66,11 +66,17 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_ENABLE(lz4,
-	[  --disable-lz4           Disable LZ4 compression support],
-	[enable_lz4="$enableval"],
+	[AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=enabled@:>@])],
+	,
 	[enable_lz4="yes"]
 )
 
+AC_ARG_ENABLE(bundled-lz4,
+	[AS_HELP_STRING([--enable-bundled-lz4], [enable bundled LZ4 library instead of system library @<:@default=disabled@:>@])],
+	[enable_bundled_lz4="$enableval"],
+	[enable_bundled_lz4="no"]
+)
+
 AC_ARG_ENABLE(comp-stub,
 	[  --enable-comp-stub      Don't compile compression support but still allow limited interoperability with compression-enabled peers],
 	[enable_comp_stub="$enableval"],
@@ -1087,37 +1093,34 @@ dnl
 
 AC_ARG_VAR([LZ4_CFLAGS], [C compiler flags for lz4])
 AC_ARG_VAR([LZ4_LIBS], [linker flags for lz4])
+AM_CONDITIONAL([ENABLE_BUNDLED_LZ4], [test "${enable_bundled_lz4}" = "yes"])
 if test "$enable_lz4" = "yes" && test "$enable_comp_stub" = "no"; then
-    AC_CHECKING([for LZ4 Library and Header files])
-    havelz4lib=1
+    if test "$enable_bundled_lz4" = "no"; then
+	AC_CHECKING([for LZ4 Library and Header files])
 
-    # if LZ4_LIBS is set, we assume it will work, otherwise test
-    if test -z "${LZ4_LIBS}"; then
-	AC_CHECK_LIB(lz4, LZ4_compress,
-	    [ LZ4_LIBS="-llz4" ],
-	    [
-	        AC_MSG_RESULT([LZ4 library not found.])
-	        havelz4lib=0
-	    ])
-    fi
-
-    saved_CFLAGS="${CFLAGS}"
-    CFLAGS="${CFLAGS} ${LZ4_CFLAGS}"
-    AC_CHECK_HEADERS(lz4.h,
-       ,
-       [
-	   AC_MSG_RESULT([LZ4 headers not found.])
-	   havelz4lib=0
-       ])
-
-    if test $havelz4lib = 0 ; then
-	AC_MSG_RESULT([LZ4 library or header not found, using version in src/compat/compat-lz4.*])
-	AC_DEFINE([NEED_COMPAT_LZ4], [1], [use copy of LZ4 source in compat/])
+	# if LZ4_LIBS is set, we assume it will work, otherwise test
+	if test -z "${LZ4_LIBS}"; then
+	   AC_CHECK_LIB(lz4, LZ4_compress,
+			[ LZ4_LIBS="-llz4" ],
+			[
+			     AC_MSG_ERROR([LZ4 library not found.  An alternative is to use --enable-bundled-lz4, or just --disable-lz4])
+			])
+	fi
+	saved_CFLAGS="${CFLAGS}"
+	CFLAGS="${CFLAGS} ${LZ4_CFLAGS}"
+	AC_CHECK_HEADERS(lz4.h,
+			 ,
+			 [
+			     AC_MSG_ERROR([LZ4 headers not found.  An alternative is to use --enable-bundled-lz4, or just --disable-lz4])
+			 ])
+    else
+	AC_MSG_RESULT([using bundled lz4 library (in src/compat/compat-lz4.*)])
+	AC_DEFINE([NEED_COMPAT_LZ4], [1], [use bundled copy of LZ4 source in compat/])
 	LZ4_LIBS=""
     fi
     OPTIONAL_LZ4_CFLAGS="${LZ4_CFLAGS}"
     OPTIONAL_LZ4_LIBS="${LZ4_LIBS}"
-    AC_DEFINE(ENABLE_LZ4, 1, [Enable LZ4 compression library])
+    AC_DEFINE(ENABLE_LZ4, [1], [Enable LZ4 compression library])
     CFLAGS="${saved_CFLAGS}"
 fi
 
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 444a8f8b..3dc25f39 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -26,5 +26,8 @@ libcompat_la_SOURCES = \
 	compat-daemon.c \
 	compat-inet_ntop.c \
 	compat-inet_pton.c \
-	compat-lz4.c compat-lz4.h \
 	compat-versionhelpers.h
+
+if ENABLE_BUNDLED_LZ4
+libcompat_la_SOURCES += compat-lz4.c compat-lz4.h
+endif
-- 
2.13.5


