From: David Sommerseth <openvpn.list@...1114...>
Date: Wed,  6 May 2015 22:06:25 +0200
Message-Id: <1430942786-31419-4-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1430942786-31419-1-git-send-email-openvpn.list@...1114...>
References: <1430942786-31419-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCHv2 3/4] autotools: Add support for extracting
	version information from pkg-config modules
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
 m4/pkg.m4 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/m4/pkg.m4 b/m4/pkg.m4
index 9a71878..f82496b 100644
--- a/m4/pkg.m4
+++ b/m4/pkg.m4
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


