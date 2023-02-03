From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  3 Feb 2023 17:55:29 +0100
Message-Id: <20230203165529.125771-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] configure: enable DCO by default on
 FreeBSD/Linux
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

It is time.

Automatically disabled when
- iproute2 is enabled
- libnl-genl is missing on Linux
- libnv is missing on FreeBSD

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 configure.ac | 79 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 17 deletions(-)

diff --git a/configure.ac b/configure.ac
index 91500087..808b9c06 100644
--- a/configure.ac
+++ b/configure.ac
@@ -144,14 +144,27 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[dco],
-	[AS_HELP_STRING([--enable-dco], [enable data channel offload support using the ovpn-dco kernel module (always enabled on Windows) @<:@default=no@:>@])],
+	[AS_HELP_STRING([--disable-dco], [enable data channel offload support using the ovpn-dco kernel module (always enabled on Windows) @<:@default=yes@:>@])],
 	,
-	[enable_dco="no"]
+	[
+		case "$host" in
+			*-*-linux*)
+				enable_dco="auto"
+			;;
+			*-*-freebsd*)
+				enable_dco="auto"
+			;;
+			*)
+				# note that this does not disable it for Windows
+				enable_dco="no"
+			;;
+		esac
+	]
 )
 
 AC_ARG_ENABLE(
 	[iproute2],
-	[AS_HELP_STRING([--enable-iproute2], [enable support for iproute2 @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-iproute2], [enable support for iproute2 (disables DCO) @<:@default=no@:>@])],
 	,
 	[enable_iproute2="no"]
 )
@@ -534,7 +547,7 @@ AC_CHECK_DECLS(
 	,
 	[[${SOCKET_INCLUDES}]]
 )
-AC_CHECKING([anonymous union support])
+AC_MSG_CHECKING([anonymous union support])
 AC_COMPILE_IFELSE(
 	[AC_LANG_PROGRAM(
 		[[
@@ -769,28 +782,60 @@ PKG_CHECK_MODULES(
 )
 
 
-if test "$enable_dco" = "yes"; then
+if test "$enable_dco" != "no"; then
+	enable_dco_arg="$enable_dco"
+	if test "${enable_iproute2}" = "yes"; then
+		AC_MSG_WARN([iproute2 support cannot be enabled when using DCO])
+		enable_dco="no"
+	fi
+	case "$host" in
+		*-*-linux*)
 dnl
 dnl Include generic netlink library used to talk to ovpn-dco
 dnl
-	case "$host" in
-		*-*-linux*)
 			PKG_CHECK_MODULES([LIBNL_GENL],
 					  [libnl-genl-3.0 >= 3.4.0],
 					  [have_libnl="yes"],
-					  [AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
+					  [
+					   AC_MSG_WARN([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer for DCO])
+					   enable_dco="no"
+					  ]
 			)
-
-			CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
-			LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
-
-			AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
-			AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
+			if test "$enable_dco" = "no"; then
+				if test "$enable_dco_arg" = "auto"; then
+					AC_MSG_WARN([DCO support disabled])
+				else
+					AC_MSG_ERROR([DCO support can't be enabled])
+				fi
+			else
+				CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
+				LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
+
+				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
+				AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
+			fi
 			;;
 		*-*-freebsd*)
-			LIBS="${LIBS} -lnv"
-			AC_DEFINE(ENABLE_DCO, 1, [Enable data channel offload for FreeBSD])
-			AC_MSG_NOTICE([Enabled ovpn-dco support for FreeBSD])
+			AC_CHECK_LIB(
+				[nv],
+				[nvlist_create],
+				[
+				 LIBS="${LIBS} -lnv"
+				 AC_DEFINE(ENABLE_DCO, 1, [Enable data channel offload for FreeBSD])
+				 AC_MSG_NOTICE([Enabled ovpn-dco support for FreeBSD])
+				],
+				[
+				 enable_dco="no"
+				 AC_MSG_WARN([Name/Value pair library not found.])
+				]
+			)
+			if test "$enable_dco" = "no"; then
+				if test "$enable_dco_arg" = "auto"; then
+					AC_MSG_WARN([DCO support disabled])
+				else
+					AC_MSG_ERROR([DCO support can't be enabled])
+				fi
+			fi
 			;;
 		*-mingw*)
 			AC_MSG_NOTICE([NOTE: --enable-dco ignored on Windows because it's always enabled])
-- 
2.34.1


