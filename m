From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 26 Jun 2024 18:19:21 +0200
Message-Id: <20240626161921.179301-1-frank@...2641...>
In-Reply-To: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
References: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] configure: Try to detect LZO with
 pkg-config
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
Cc: Gert Doering <gert@...1296...>

On most systems this should work just fine.

v2:
 - simplify code by removing -llzo special handling
v3:
 - reintroduce support for autodetection without pkg-config,
   no need to break backwards compatibility right now
v7:
 - Handle case correctly where lzo/lzo1x.h can not be included
   at all. On most distros this works even though the .pc
   file suggests to use it without. We had some partly
   solution for that but it wasn't really working.
v8:
 - Handle systems that do not implicitly include limits.h
   in configure test builds.
   lzodefs.h usually relies on lzoconf.h to include it.

Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/556
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/config.h.cmake.in b/config.h.cmake.in
index effca2a..720d679 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -178,9 +178,6 @@
 /* Define to 1 if you have the <linux/types.h> header file. */
 #cmakedefine HAVE_LINUX_TYPES_H
 
-/* Define to 1 if you have the <lzoconf.h> header file. */
-#define HAVE_LZO_CONF_H
-
 /* Define to 1 if you have the <lzo1x.h> header file. */
 #define HAVE_LZO1X_H 1
 
diff --git a/configure.ac b/configure.ac
index c01ad09..555c97e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1143,8 +1143,17 @@
 
 AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])
 AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])
-have_lzo="yes"
-if test -z "${LZO_LIBS}"; then
+if test -z "${LZO_CFLAGS}" -a -z "${LZO_LIBS}"; then
+    # if the user did not explicitly specify flags, try to autodetect
+    PKG_CHECK_MODULES([LZO],
+		[lzo2],
+		[have_lzo="yes"],
+		[]
+    )
+
+    if test "${have_lzo}" != "yes"; then
+	# try to detect without pkg-config
+	have_lzo="yes"
 	AC_CHECK_LIB(
 		[lzo2],
 		[lzo1x_1_15_compress],
@@ -1156,6 +1165,10 @@
 			[have_lzo="no"]
 		)]
 	)
+    fi
+else
+    # assume the user configured it correctly
+    have_lzo="yes"
 fi
 if test "${have_lzo}" = "yes"; then
 	saved_CFLAGS="${CFLAGS}"
@@ -1166,8 +1179,11 @@
 		[AC_CHECK_HEADERS(
 			[lzo1x.h],
 			,
-			[AC_MSG_ERROR([lzo1x.h is missing])]
-		)]
+			[AC_MSG_ERROR([lzo1x.h is missing])],
+                        [#include <limits.h>
+                         #include <lzodefs.h>
+                         #include <lzoconf.h>]
+		)],
 	)
 	CFLAGS="${saved_CFLAGS}"
 fi
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index 62d73a1..c271527 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -37,17 +37,15 @@
  * @addtogroup compression
  * @{
  */
-#if defined(HAVE_LZO_CONF_H)
+#if defined(HAVE_LZO_LZO1X_H)
+#include <lzo/lzo1x.h>
+#elif defined(HAVE_LZO1X_H)
 /* The lzo.h magic gets confused and still wants
  * to include lzo/lzoconf.h even if our include paths
  * are setup to include the paths without lzo/
  */
 #include <lzodefs.h>
 #include <lzoconf.h>
-#endif
-#if defined(HAVE_LZO_LZO1X_H)
-#include <lzo/lzo1x.h>
-#elif defined(HAVE_LZO1X_H)
 #include <lzo1x.h>
 #endif
 

