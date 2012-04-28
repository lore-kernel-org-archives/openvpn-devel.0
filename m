From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 28 Apr 2012 21:00:13 +0300
Message-Id: <1335636013-7717-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] build: add git revision to --version output
	if build from git repository
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

If configure is located at git repository, acquire branch and revision
of head to be printed at --version output.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac          |   11 +++++++++++
 src/openvpn/options.c |    3 +++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 399b4e7..812d336 100644
--- a/configure.ac
+++ b/configure.ac
@@ -307,11 +307,13 @@ AC_ARG_VAR([ROUTE], [full path to route utility])
 AC_ARG_VAR([IPROUTE], [full path to ip utility])
 AC_ARG_VAR([NETSTAT], [path to netstat utility]) # tests
 AC_ARG_VAR([MAN2HTML], [path to man2html utility])
+AC_ARG_VAR([GIT], [path to git utility])
 AC_PATH_PROGS([IFCONFIG], [ifconfig],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([ROUTE], [route],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([IPROUTE], [ip],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_CHECK_PROGS([NETSTAT], [netstat], [netstat], [$PATH:/usr/local/sbin:/usr/sbin:/sbin:/etc]) # tests
 AC_CHECK_PROGS([MAN2HTML], [man2html])
+AC_CHECK_PROGS([GIT], [git]) # optional
 AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig tool])
 AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
 AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
@@ -781,6 +783,15 @@ PKG_CHECK_MODULES(
 	[]
 )
 
+AC_MSG_CHECKING([git checkout])
+if test -n "${GIT}" -a -d "${srcdir}/.git"; then
+	PACKAGE_VERSION_EXTRA_GIT_REVISION="`GIT_DIR=\"${srcdir}/.git\" git rev-parse --symbolic-full-name HEAD`/`GIT_DIR=\"${srcdir}/.git\" git rev-parse --short HEAD`"
+	AC_MSG_RESULT([${PACKAGE_VERSION_EXTRA_GIT_REVISION}])
+	AC_DEFINE_UNQUOTED([PACKAGE_VERSION_EXTRA_GIT_REVISION], ["${PACKAGE_VERSION_EXTRA_GIT_REVISION}"], [Git checkout revision])
+else
+	AC_MSG_RESULT([no])
+fi
+
 if test -n "${SP_PLATFORM_WINDOWS}"; then
 	AC_DEFINE_UNQUOTED([PATH_SEPARATOR], ['\\\\'], [Path separator]) #"
 	AC_DEFINE_UNQUOTED([PATH_SEPARATOR_STR], ["\\\\"], [Path separator]) #"
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 019be57..c1aedfb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3430,6 +3430,9 @@ usage_version (void)
 #ifdef CONFIGURE_DEFINES
   msg (M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
 #endif
+#ifdef PACKAGE_VERSION_EXTRA_GIT_REVISION
+  msg (M_INFO|M_NOPREFIX, "git revision: %s", PACKAGE_VERSION_EXTRA_GIT_REVISION);
+#endif
 #endif
   openvpn_exit (OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
-- 
1.7.3.4


