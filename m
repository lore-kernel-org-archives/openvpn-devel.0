From: Antonio Quartulli <a@...2181...>
Date: Tue,  7 Dec 2021 13:11:37 +0100
Message-Id: <20211207121137.3221-9-a@...2181...>
In-Reply-To: <20211207121137.3221-1-a@...2181...>
References: <20211207121137.3221-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC 8/8] ovpn-dco: force user to set DCO_INCLUDEDIR
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/configure.ac b/configure.ac
index b6ecb23a..1911f24e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -777,29 +777,22 @@ PKG_CHECK_MODULES(
 
 if test "$enable_dco" = "yes"; then
 dnl
-dnl  Configure path for the ovpn-dco kernel module source directory.
+dnl  Configure path for the ovpn-dco header directory.
 dnl
-dnl  This is similar to the core librariy, there is an embedded
-dnl  version in this tree which will be used by default.  The
-dnl  git checkout inside the ovpn-dco/ directory is managed via git
-dnl  submodule.
-dnl
-	AC_ARG_VAR([DCO_SOURCEDIR], [Alternative ovpn-dco kernel module source directory])
-	if test -z "${DCO_SOURCEDIR}"; then
-		case "$host" in
-			*-mingw*) DCO_SOURCEDIR="${srcdir}/../ovpn-dco-win";;
-			*) DCO_SOURCEDIR="${srcdir}/../ovpn-dco";;
-		esac
+	AC_ARG_VAR([DCO_INCLUDEDIR], [ovpn-dco header directory (where to find ovpn-dco.h)])
+	if test -z "${DCO_INCLUDEDIR}"; then
+		AC_MSG_ERROR([You must specify DCO_INCLUDEDIR when using --enable-dco.])
+
 	fi
-	AC_MSG_NOTICE([Using ovpn-dco source directory: ${DCO_SOURCEDIR}])
-	AC_SUBST([DCO_SOURCEDIR])
+
+	AC_MSG_NOTICE([Using ovpn-dco header directory: ${DCO_INCLUDEDIR}])
+	DCO_CFLAGS="-I${DCO_INCLUDEDIR}"
 
 	case "$host" in
 		*-*-linux*)
 dnl
 dnl Include generic netlink library used to talk to ovpn-dco
 dnl
-			saved_CFLAGS="${CFLAGS}"
 			PKG_CHECK_MODULES(
 				[LIBNL_GENL],
 				[libnl-genl-3.0 >= 3.2.29],
@@ -807,16 +800,12 @@ dnl
 				[AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
 			)
 
-			DCO_CFLAGS="-I${DCO_SOURCEDIR}/include/uapi ${LIBNL_GENL_CFLAGS}"
-
-			CFLAGS="${CFLAGS} ${DCO_CFLAGS}"
+			CFLAGS="${CFLAGS} ${DCO_CFLAGS} ${LIBNL_GENL_CFLAGS}"
 			AC_CHECK_HEADERS(
 				[linux/ovpn_dco.h],
 				,
-				[AC_MSG_ERROR([linux/ovpn_dco.h is missing (use DCO_SOURCE to set path to it, CFLAGS=${CFLAGS})])]
+				[AC_MSG_ERROR([linux/ovpn_dco.h couldn't be found (use DCO_INCLUDEDIR to set the path to it, CFLAGS=${CFLAGS})])]
 			)
-			CFLAGS=${saved_CFLAGS}
-
 			OPTIONAL_DCO_LIBS="${LIBNL_GENL_LIBS}"
 
 			AC_DEFINE(ENABLE_LINUXDCO, 1, [Enable linux data channel offload])
@@ -1407,7 +1396,6 @@ AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 AC_SUBST([OPTIONAL_INOTIFY_CFLAGS])
 AC_SUBST([OPTIONAL_INOTIFY_LIBS])
-AC_SUBST([OPTIONAL_DCO_CFLAGS])
 AC_SUBST([OPTIONAL_DCO_LIBS])
 
 AC_SUBST([PLUGIN_AUTH_PAM_CFLAGS])
-- 
2.32.0


