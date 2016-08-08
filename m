From: David Sommerseth <davids@...515...>
Date: Mon,  8 Aug 2016 21:28:07 +0200
Message-Id: <1470684488-21307-4-git-send-email-davids@...515...>
In-Reply-To: <1470684488-21307-1-git-send-email-davids@...515...>
References: <1470684488-21307-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v4 3/4] autotools: Add support for
	extracting version information from pkg-config modules
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

This patch adds extracting the pkg-config --modversion output into a
variable configure.ac can consume.  The extracted content is put
into ${pkgname}_MODVERSION.  See config.log for details after
./configure have run.

The patch also modifies slightly how the pkg-config result is
processed.  Pkg-config can in some situations report more than one
line of information if more pkg-config meta-data files are available
for the same package.  This can cause automake to choke as certain
variables may be split over more lines.  A simple fix was chosen,
using 'tail' to ensure only one line is being processed.

Signed-off-by: David Sommerseth <davids@...515...>
---
 m4/pkg.m4 | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/m4/pkg.m4 b/m4/pkg.m4
index 9a71878..94e4589 100644
--- a/m4/pkg.m4
+++ b/m4/pkg.m4
@@ -73,7 +73,7 @@ m4_define([_PKG_CONFIG],
     pkg_cv_[]$1="$$1"
  elif test -n "$PKG_CONFIG"; then
     PKG_CHECK_EXISTS([$3],
-                     [pkg_cv_[]$1=`$PKG_CONFIG --[]$2 "$3" 2>/dev/null`
+                     [pkg_cv_[]$1=`$PKG_CONFIG --[]$2 "$3" | tail -n1 2>/dev/null`
 		      test "x$?" != "x0" && pkg_failed=yes ],
 		     [pkg_failed=yes])
  else
@@ -107,16 +107,18 @@ AC_DEFUN([PKG_CHECK_MODULES],
 [AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
 AC_ARG_VAR([$1][_CFLAGS], [C compiler flags for $1, overriding pkg-config])dnl
 AC_ARG_VAR([$1][_LIBS], [linker flags for $1, overriding pkg-config])dnl
+AC_ARG_VAR([$1][_MODVERSION], [module version])dnl
 
 pkg_failed=no
 AC_MSG_CHECKING([for $1])
 
 _PKG_CONFIG([$1][_CFLAGS], [cflags], [$2])
 _PKG_CONFIG([$1][_LIBS], [libs], [$2])
+_PKG_CONFIG([$1][_MODVERSION], [modversion], [$2])
 
 m4_define([_PKG_TEXT], [Alternatively, you may set the environment variables $1[]_CFLAGS
-and $1[]_LIBS to avoid the need to call pkg-config.
-See the pkg-config man page for more details.])
+and $1[]_LIBS to avoid the need to call pkg-config.  The $1[]_MODVERSION provides version
+information.  See the pkg-config man page for more details.])
 
 if test $pkg_failed = yes; then
    	AC_MSG_RESULT([no])
@@ -153,6 +155,7 @@ To get pkg-config, see <http://pkg-config.freedesktop.org/>.])[]dnl
 else
 	$1[]_CFLAGS=$pkg_cv_[]$1[]_CFLAGS
 	$1[]_LIBS=$pkg_cv_[]$1[]_LIBS
+	$1[]_MODVERSION=$pkg_cv_[]$1[]_MODVERSION
         AC_MSG_RESULT([yes])
 	$3
 fi[]dnl
-- 
1.8.3.1


