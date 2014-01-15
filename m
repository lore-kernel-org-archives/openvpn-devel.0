From: davids@...1347...
Date: Wed, 15 Jan 2014 17:36:04 +0100
Message-Id: <1389803764-5879-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Adjusted autotools files to build more
	cleanly on newer autoconf/automake versions
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

From: David Sommerseth <davids@...1347...>

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac            | 8 ++++----
 src/openvpn/Makefile.am | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 636d4e2..ec8b96b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -680,7 +680,7 @@ fi
 
 case "${with_mem_check}" in
 	valgrind)
-		AC_CHECK_HEADER(
+		AC_CHECK_HEADERS(
 			[valgrind/memcheck.h],
 			[
 				CFLAGS="${CFLAGS} -g -fno-inline"
@@ -694,7 +694,7 @@ case "${with_mem_check}" in
 		)
 		;;
 	dmalloc)
-		AC_CHECK_HEADER(
+		AC_CHECK_HEADERS(
 			[dmalloc.h],
 			[AC_CHECK_LIB(
 				[dmalloc],
@@ -923,7 +923,7 @@ if test "$enable_snappy" = "yes" && test "$enable_comp_stub" = "no"; then
 
     saved_CFLAGS="${CFLAGS}"
     CFLAGS="${CFLAGS} ${SNAPPY_CFLAGS}"
-    AC_CHECK_HEADER(snappy-c.h,
+    AC_CHECK_HEADERS(snappy-c.h,
        ,
        [
 	   AC_MSG_RESULT([Snappy headers not found.])
@@ -962,7 +962,7 @@ if test "$enable_lz4" = "yes" && test "$enable_comp_stub" = "no"; then
 
     saved_CFLAGS="${CFLAGS}"
     CFLAGS="${CFLAGS} ${LZ4_CFLAGS}"
-    AC_CHECK_HEADER(lz4.h,
+    AC_CHECK_HEADERS(lz4.h,
        ,
        [
 	   AC_MSG_RESULT([LZ4 headers not found.])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 0b79e10..fd593c5 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -18,7 +18,7 @@ EXTRA_DIST = \
 	openvpn.vcxproj \
 	openvpn.vcxproj.filters
 
-INCLUDES = \
+AM_CPPFLAGS = \
 	-I$(top_srcdir)/include \
 	-I$(top_srcdir)/src/compat
 
-- 
1.8.5.2


