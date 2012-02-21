From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:31 +0200
Message-Id: <1329787361-26096-26-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 25/35] build: autoconf: commands as
	environment
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
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |   66 ++++++++++++++++++++++++---------------------------------
 1 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5afcacc..c34e8c4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -266,37 +266,6 @@ AC_ARG_WITH(
 )
 
 AC_ARG_WITH(
-	[ifconfig-path],
-	[AS_HELP_STRING([--with-ifconfig-path=PATH], [Path to ifconfig tool])],
-	[IFCONFIG="$withval"],
-	[AC_PATH_PROG([IFCONFIG], [ifconfig], [ifconfig], [$PATH:/usr/local/sbin:/usr/sbin:/sbin])]
-)
-AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig tool])
-
-AC_ARG_WITH(
-	[iproute-path],
-	[AS_HELP_STRING([--with-iproute-path=PATH], [Path to iproute tool])],
-	[IPROUTE="$withval"],
-	[AC_PATH_PROG([IPROUTE], [ip], [ip], [$PATH:/usr/local/sbin:/usr/sbin:/sbin])]
-)
-AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
-
-AC_ARG_WITH([route-path],
-   [AS_HELP_STRING([--with-route-path=PATH], [Path to route tool])],
-   [ROUTE="$withval"],
-   [AC_PATH_PROG([ROUTE], [route], [route], [$PATH:/usr/local/sbin:/usr/sbin:/sbin])]
-)
-AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
-
-AC_ARG_WITH(
-	[netstat-path],
-	[AS_HELP_STRING([--with-netstat-path=PATH], [Path to netstat tool])],
-	[NETSTAT="$withval"],
-	[AC_PATH_PROG([NETSTAT], [netstat], [netstat], [$PATH:/usr/local/sbin:/usr/sbin:/sbin:/etc])]
-)
-AC_DEFINE_UNQUOTED([NETSTAT_PATH], ["$NETSTAT"], [Path to netstat tool])
-
-AC_ARG_WITH(
 	[mem-check],
 	[AS_HELP_STRING([--with-mem-check=TYPE], [build with debug memory checking, TYPE=dmalloc|valgrind|ssl])],
 	,
@@ -355,6 +324,20 @@ AC_PROG_MKDIR_P
 AC_PROG_SED
 AC_PROG_MAKE_SET
 
+AC_ARG_VAR([IFCONFIG], [path to ipconfig utility])
+AC_ARG_VAR([ROUTE], [path to route utility])
+AC_ARG_VAR([IPROUTE], [path to ip utility])
+AC_ARG_VAR([NETSTAT], [path to netstat utility]) # tests
+AC_ARG_VAR([MAN2HTML], [path to man2html utility])
+AC_PATH_PROGS([IFCONFIG], [ifconfig],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
+AC_PATH_PROGS([ROUTE], [route],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
+AC_PATH_PROGS([IPROUTE], [ip],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
+AC_CHECK_PROGS([NETSTAT], [netstat], [netstat], [$PATH:/usr/local/sbin:/usr/sbin:/sbin:/etc]) # tests
+AC_CHECK_PROGS([MAN2HTML], [man2html])
+AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig tool])
+AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
+AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
+
 #
 # Libtool
 #
@@ -371,12 +354,6 @@ ifdef(
 	]
 )
 
-if test "${WIN32}" = "yes"; then
-	AC_ARG_VAR([MAN2HTML], [man2html utility])
-	AC_CHECK_PROGS([MAN2HTML], [man2html])
-	test -z "${MAN2HTML}" && AC_MSG_ERROR([man2html is required for win32])
-fi
-
 AC_C_CONST
 AC_C_INLINE
 AC_C_VOLATILE
@@ -898,7 +875,16 @@ test "${enable_pf}" = "yes" && AC_DEFINE([ENABLE_PF], [1], [Enable internal pack
 test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHECK], [1], [Enable strict options check between peers])
 test "${enable_password_save}" = "yes" && AC_DEFINE([ENABLE_PASSWORD_SAVE], [1], [Allow --askpass and --auth-user-pass passwords to be read from a file])
 test "${enable_systemd}" = "yes" && AC_DEFINE([ENABLE_SYSTEMD], [1], [Enable systemd support])
-test "${enable_iproute2}" = "yes" && AC_DEFINE([ENABLE_IPROUTE], [1], [enable iproute2 support])
+
+if test "${enable_iproute2}" = "yes"; then
+	test -z "${IPROUTE}" && AC_MSG_ERROR([ip utility is required but missing])
+	AC_DEFINE([ENABLE_IPROUTE], [1], [enable iproute2 support])
+else
+	if test "${WIN32}" != "yes"; then
+		test -z "${ROUTE}" && AC_MSG_ERROR([route utility is required but missing])
+		test -z "${IFCONFIG}" && AC_MSG_ERROR([ifconfig utility is required but missing])
+	fi
+fi
 
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
@@ -908,6 +894,10 @@ if test "${enable_strict}" = "yes"; then
 	CFLAGS="${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
 fi
 
+if test "${WIN32}" = "yes"; then
+	test -z "${MAN2HTML}" && AC_MSG_ERROR([man2html is required for win32])
+fi
+
 CONFIGURE_DEFINES="`set | grep '^enable_.*=' ; set | grep '^with_.*='`"
 AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], ["`echo ${CONFIGURE_DEFINES}`"], [Configuration settings])
 
-- 
1.7.3.4


