From: David Sommerseth <davids@...515...>
Date: Thu,  7 Sep 2017 19:20:04 +0200
Message-Id: <20170907172004.22534-1-davids@...515...>
In-Reply-To: <20170907022827.10658-1-davids@...515...>
References: <20170907022827.10658-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH v2] lz4: Move towards a newer LZ4 API
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

We are using a deprecated function, LZ4_compress_limitedOutput(), which
will be removed with time.  The correct function to use is LZ4_compress_default().
Both function takes the same number of arguments and data types, so the change
is minimal.

This patch will also enforce the system LZ4 library to be at least v1.7.1.  If
the system library is not found or it is older, it will be build using the bundled
LZ4 library.  The version number requirement is based on the LZ4 version we ship.

The changes in configure.ac for the version check is modelled around the same
approach we use for OpenSSL.  Plus it does a few minor reformats and improvements
to comply with more recommend autoconf coding style.

This patch is a result of the discussions in this mail thread:
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14135.html

Signed-off-by: David Sommerseth <davids@...515...>

---
v2 - Don't use LZ4 version based #ifdef wrapper function
     Do the LZ4 version check in ./configure
---
 configure.ac           | 72 +++++++++++++++++++++++++++++++++++---------------
 src/openvpn/comp-lz4.c |  3 ++-
 2 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6f1044e8..74443353 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1088,37 +1088,67 @@ dnl
 AC_ARG_VAR([LZ4_CFLAGS], [C compiler flags for lz4])
 AC_ARG_VAR([LZ4_LIBS], [linker flags for lz4])
 if test "$enable_lz4" = "yes" && test "$enable_comp_stub" = "no"; then
-    AC_CHECKING([for LZ4 Library and Header files])
-    havelz4lib=1
-
-    # if LZ4_LIBS is set, we assume it will work, otherwise test
-    if test -z "${LZ4_LIBS}"; then
-	AC_CHECK_LIB(lz4, LZ4_compress,
-	    [ LZ4_LIBS="-llz4" ],
-	    [
-	        AC_MSG_RESULT([LZ4 library not found.])
-	        havelz4lib=0
-	    ])
+    if test -z "${LZ4_CFLAGS}" -a -z "${LZ4_LIBS}"; then
+	# if the user did not explicitly specify flags, try to autodetect
+	PKG_CHECK_MODULES([LZ4],
+			  [liblz4 >= 1.7.1],
+			  [have_lz4="yes"],
+			  [] # If this fails, we will do another test next
+	)
     fi
 
     saved_CFLAGS="${CFLAGS}"
+    saved_LIBS="${LIBS}"
     CFLAGS="${CFLAGS} ${LZ4_CFLAGS}"
-    AC_CHECK_HEADERS(lz4.h,
-       ,
-       [
-	   AC_MSG_RESULT([LZ4 headers not found.])
-	   havelz4lib=0
-       ])
-
-    if test $havelz4lib = 0 ; then
-	AC_MSG_RESULT([LZ4 library or header not found, using version in src/compat/compat-lz4.*])
+    LIBS="${LIBS} ${LZ4_LIBS}"
+
+    # If pkgconfig check failed or LZ4_CFLAGS/LZ4_LIBS env vars
+    # are used, check the version directly in the LZ4 include file
+    if test "${have_lz4}" != "yes"; then
+	AC_CHECK_HEADERS([lz4.h],
+			 [have_lz4h="yes"],
+			 [])
+
+	if test "${have_lz4h}" = "yes" ; then
+	    AC_MSG_CHECKING([additionally if system LZ4 version >= 1.7.1])
+	    AC_COMPILE_IFELSE(
+		[AC_LANG_PROGRAM([[
+#include <lz4.h>
+				 ]],
+				 [[
+/* Version encoding: MMNNPP (Major miNor Patch) - see lz4.h for details */
+#if LZ4_VERSION_NUMBER < 10701L
+#error LZ4 is too old
+#endif
+				 ]]
+				)],
+		[
+		    AC_MSG_RESULT([ok])
+		    have_lz4="yes"
+		],
+		[AC_MSG_RESULT([system LZ4 library is too old])]
+	    )
+	fi
+    fi
+
+    # if LZ4_LIBS is set, we assume it will work, otherwise test
+    if test -z "${LZ4_LIBS}"; then
+	AC_CHECK_LIB([lz4],
+		     [LZ4_compress],
+		     [LZ4_LIBS="-llz4"],
+		     [have_lz4="no"])
+    fi
+
+    if test "${have_lz4}" != "yes" ; then
+	AC_MSG_RESULT([		usuable LZ4 library or header not found, using version in src/compat/compat-lz4.*])
 	AC_DEFINE([NEED_COMPAT_LZ4], [1], [use copy of LZ4 source in compat/])
 	LZ4_LIBS=""
     fi
     OPTIONAL_LZ4_CFLAGS="${LZ4_CFLAGS}"
     OPTIONAL_LZ4_LIBS="${LZ4_LIBS}"
-    AC_DEFINE(ENABLE_LZ4, 1, [Enable LZ4 compression library])
+    AC_DEFINE(ENABLE_LZ4, [1], [Enable LZ4 compression library])
     CFLAGS="${saved_CFLAGS}"
+    LIBS="${saved_LIBS}"
 fi
 
 
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index e056caa8..bdb3247d 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -43,6 +43,7 @@
 
 #include "memdbg.h"
 
+
 static void
 lz4_compress_init(struct compress_context *compctx)
 {
@@ -86,7 +87,7 @@ do_lz4_compress(struct buffer *buf,
             return false;
         }
 
-        zlen = LZ4_compress_limitedOutput((const char *)BPTR(buf), (char *)BPTR(work), BLEN(buf), zlen_max );
+        zlen = LZ4_compress_default((const char *)BPTR(buf), (char *)BPTR(work), BLEN(buf), zlen_max );
 
         if (zlen <= 0)
         {
-- 
2.13.5


