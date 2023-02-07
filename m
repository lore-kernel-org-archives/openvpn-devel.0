From: Frank Lichtenheld <frank@...2641...>
Date: Tue,  7 Feb 2023 14:20:26 +0100
Message-Id: <20230207132026.41580-1-frank@...2641...>
In-Reply-To: <20230206112218.51430-1-frank@...2641...>
References: <20230206112218.51430-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] configure: enable DCO by default on
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

Automatically disabled when
- iproute2 is enabled
  (Don't want to force people specifying --disable-dco explicitely)
- libnv is missing on FreeBSD
  (FreeBSD version too old anyway)

Will still error out if libnl-genl is missing on Linux to
make people aware of the new dependency.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 configure.ac | 82 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 19 deletions(-)

v2: error out when libnl-genl is missing as discussed with ordex on
    IRC.

v3:
 - improvements to the messages, suggested by Selva
 - further improvements to the default specification, trying to make it clear
 - if enabling iproute2, do not test for libnl-genl


diff --git a/configure.ac b/configure.ac
index 78c99740..ba33ccd8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -146,14 +146,27 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[dco],
-	[AS_HELP_STRING([--enable-dco], [enable data channel offload support using the ovpn-dco kernel module (always enabled on Windows) @<:@default=no@:>@])],
+	[AS_HELP_STRING([--disable-dco], [disable data channel offload support using the ovpn-dco kernel module @<:@default=yes@:>@ on Linux/FreeBSD, can't disable on Windows])],
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
@@ -536,7 +549,7 @@ AC_CHECK_DECLS(
 	,
 	[[${SOCKET_INCLUDES}]]
 )
-AC_CHECKING([anonymous union support])
+AC_MSG_CHECKING([anonymous union support])
 AC_COMPILE_IFELSE(
 	[AC_LANG_PROGRAM(
 		[[
@@ -771,28 +784,59 @@ PKG_CHECK_MODULES(
 )
 
 
-if test "$enable_dco" = "yes"; then
-dnl
-dnl Include generic netlink library used to talk to ovpn-dco
-dnl
+if test "$enable_dco" != "no"; then
+	enable_dco_arg="$enable_dco"
+	if test "${enable_iproute2}" = "yes"; then
+		AC_MSG_WARN([DCO cannot be enabled when using iproute2])
+		enable_dco="no"
+	fi
 	case "$host" in
 		*-*-linux*)
-			PKG_CHECK_MODULES([LIBNL_GENL],
+			if test "$enable_dco" = "no"; then
+				if test "$enable_dco_arg" = "auto"; then
+					AC_MSG_WARN([DCO support disabled])
+				else
+					AC_MSG_ERROR([DCO support can't be enabled])
+				fi
+			else
+				dnl
+				dnl Include generic netlink library used to talk to ovpn-dco
+				dnl
+				PKG_CHECK_MODULES([LIBNL_GENL],
 					  [libnl-genl-3.0 >= 3.4.0],
 					  [have_libnl="yes"],
-					  [AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
-			)
-
-			CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
-			LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
+					  [
+					   AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer for DCO])
+					  ]
+				)
+				CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
+				LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
 
-			AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
-			AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
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


