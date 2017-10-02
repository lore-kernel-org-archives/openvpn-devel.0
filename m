From: David Sommerseth <davids@...515...>
Date: Mon,  2 Oct 2017 18:18:12 +0200
Message-Id: <20171002161812.9376-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] lz4: Fix confused version check
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

Older LZ4 library versions used a version number > 100 and not the
current x.y.z versioning scheme.  This results in version 122 being
numberically higher than the check we have liblz4 > 1.7.1.  And
since that old version (122) does not have the LZ4_compress_default(),
the building explodes later on.

This patch enhances the version check to also ensure the version
number is lower than 100.  In addition the function checking we
had was not triggered if system library was found via pkg-config,
so this have now been reworked to really check if we have at least
two of the most important LZ4 functions - as long as a system
library have been found or been accepted via the LZ4_{CFLAGS,LIBS}
variables.

There are more ways to check for functions in autoconf.  I opted
for AC_CHECK_LIB() instead of AC_CHECK_FUNC{,S}() as the latter
ones does not test if a function exists in a specific library. This
have the downside of needing to tests instead of AC_CHECK_FUNCS()
which could test for more functions in one go.  We also do not
overwrite the LZ4_LIBS variable on success, as that could change
already set library paths (-L)

Finally, a stupid typo got fixed as well.

Trac: 939
Signed-off-by: David Sommerseth <davids@...515...>
Tested-by: Richard Bonhomme <fragmentux@...277...>
---
 configure.ac | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 74443353..394f5b09 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1091,7 +1091,7 @@ if test "$enable_lz4" = "yes" && test "$enable_comp_stub" = "no"; then
     if test -z "${LZ4_CFLAGS}" -a -z "${LZ4_LIBS}"; then
 	# if the user did not explicitly specify flags, try to autodetect
 	PKG_CHECK_MODULES([LZ4],
-			  [liblz4 >= 1.7.1],
+			  [liblz4 >= 1.7.1 liblz4 < 100],
 			  [have_lz4="yes"],
 			  [] # If this fails, we will do another test next
 	)
@@ -1131,16 +1131,20 @@ if test "$enable_lz4" = "yes" && test "$enable_comp_stub" = "no"; then
 	fi
     fi
 
-    # if LZ4_LIBS is set, we assume it will work, otherwise test
-    if test -z "${LZ4_LIBS}"; then
+    # Double check we have a few needed functions
+    if test "${have_lz4}" = "yes" ; then
 	AC_CHECK_LIB([lz4],
-		     [LZ4_compress],
-		     [LZ4_LIBS="-llz4"],
+		     [LZ4_compress_default],
+		     [],
+		     [have_lz4="no"])
+	AC_CHECK_LIB([lz4],
+		     [LZ4_decompress_safe],
+		     [],
 		     [have_lz4="no"])
     fi
 
     if test "${have_lz4}" != "yes" ; then
-	AC_MSG_RESULT([		usuable LZ4 library or header not found, using version in src/compat/compat-lz4.*])
+	AC_MSG_RESULT([		usable LZ4 library or header not found, using version in src/compat/compat-lz4.*])
 	AC_DEFINE([NEED_COMPAT_LZ4], [1], [use copy of LZ4 source in compat/])
 	LZ4_LIBS=""
     fi
-- 
2.13.5


