From: Alon Bar-Lev <alon.barlev@...277...>
Date: Fri,  4 May 2012 09:14:57 +0300
Message-Id: <1336112097-3043-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz00YYGEpLTe3t3Rt9+mDU+tSbEvXwXbJKbmnZBiB0fQ6Q@...278...>
References: <CAOazyz00YYGEpLTe3t3Rt9+mDU+tSbEvXwXbJKbmnZBiB0fQ6Q@...278...>
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

If source is located at git repository, acquire branch and revision
of head to be printed at --version output.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 .gitignore            |    1 +
 Makefile.am           |   21 +++++++++++++++++++++
 compat.m4             |    5 +++++
 config-version.h.in   |    1 +
 configure.ac          |   12 ++++++++++++
 src/openvpn/options.c |    6 ++++++
 6 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 config-version.h.in

diff --git a/.gitignore b/.gitignore
index 60b9433..9f546a3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,3 +49,4 @@ doc/openvpn.8.html
 distro/rpm/openvpn.spec
 tests/t_client.sh
 src/openvpn/openvpn
+config-version.h
diff --git a/Makefile.am b/Makefile.am
index ab3e3d2..f3567f6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -40,10 +40,20 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/depcomp $(srcdir)/aclocal.m4 \
 	$(srcdir)/config.guess $(srcdir)/config.sub
 
+CLEANFILES = \
+	config-version.h
+
 EXTRA_DIST = \
 	contrib \
 	debug
 
+.PHONY: config-version.h
+
+if GIT_CHECKOUT
+BUILT_SOURCES = \
+	config-version.h
+endif
+
 SUBDIRS = build distro include src sample doc tests
 
 dist_doc_DATA = \
@@ -53,6 +63,7 @@ dist_doc_DATA = \
 dist_noinst_DATA = \
 	.gitignore \
 	.gitattributes \
+	config-version.h.in \
 	PORTS \
 	README.IPv6 TODO.IPv6 \
 	README.polarssl \
@@ -75,3 +86,13 @@ if WIN32
 rootdir=$(prefix)
 root_DATA = version.sh
 endif
+
+config-version.h:
+	@PACKAGE_VERSION_EXTRA_GIT_REVISION="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) rev-parse --symbolic-full-name HEAD`/`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) rev-parse --short=16 HEAD`"; \
+		$(SED) "s#@PACKAGE_VERSION_EXTRA_GIT_REVISION[@]#$${PACKAGE_VERSION_EXTRA_GIT_REVISION}#g" "$(srcdir)/config-version.h.in" > config-version.h.tmp
+	@if ! [ -f config-version.h ] || ! cmp -s config-version.h.tmp config-version.h; then \
+		echo "replacing config-version.h"; \
+		mv config-version.h.tmp config-version.h; \
+	else \
+		rm -f config-version.h.tmp; \
+	fi
diff --git a/compat.m4 b/compat.m4
index d5c01f7..4c13254 100644
--- a/compat.m4
+++ b/compat.m4
@@ -43,6 +43,11 @@ ifdef(
 	[AC_DEFUN([AC_USE_SYSTEM_EXTENSIONS], [GNU_SOURCE])]
 )
 ifdef(
+	[AC_PROG_SED],
+	,
+	[AC_DEFUN([AC_PROG_SED], [AC_CHECK_PROGS([SED], [sed])])]
+)
+ifdef(
 	[AC_TYPE_INT8_T],
 	,
 	[
diff --git a/config-version.h.in b/config-version.h.in
new file mode 100644
index 0000000..dd68c18
--- /dev/null
+++ b/config-version.h.in
@@ -0,0 +1 @@
+#define PACKAGE_VERSION_EXTRA_GIT_REVISION "@PACKAGE_VERSION_EXTRA_GIT_REVISION@"
diff --git a/configure.ac b/configure.ac
index 399b4e7..d2851f6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -300,6 +300,7 @@ PKG_PROG_PKG_CONFIG
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S
+AC_PROG_SED
 AC_PROG_MAKE_SET
 
 AC_ARG_VAR([IFCONFIG], [full path to ipconfig utility])
@@ -307,11 +308,13 @@ AC_ARG_VAR([ROUTE], [full path to route utility])
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
@@ -781,6 +784,14 @@ PKG_CHECK_MODULES(
 	[]
 )
 
+AC_MSG_CHECKING([git checkout])
+GIT_CHECKOUT="no"
+if test -n "${GIT}" -a -d "${srcdir}/.git"; then
+	AC_DEFINE([HAVE_CONFIG_VERSION_H], [1], [extra version available in config-version.h])
+	GIT_CHECKOUT="yes"
+fi
+AC_MSG_RESULT([${GIT_CHECKOUT}])
+
 if test -n "${SP_PLATFORM_WINDOWS}"; then
 	AC_DEFINE_UNQUOTED([PATH_SEPARATOR], ['\\\\'], [Path separator]) #"
 	AC_DEFINE_UNQUOTED([PATH_SEPARATOR_STR], ["\\\\"], [Path separator]) #"
@@ -928,6 +939,7 @@ AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 
 AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
+AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
 
 sampledir="\$(docdir)/sample"
 AC_SUBST([sampledir])
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 019be57..3717137 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -35,6 +35,9 @@
 #elif defined(_MSC_VER)
 #include "config-msvc.h"
 #endif
+#ifdef HAVE_CONFIG_VERSION_H
+#include "config-version.h"
+#endif
 
 #include "syshead.h"
 
@@ -3430,6 +3433,9 @@ usage_version (void)
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


