From: Alon Bar-Lev <alon.barlev@...277...>
Date: Thu,  3 May 2012 20:36:52 +0300
Message-Id: <1336066612-17740-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <4FA239AB.4080308@...1114...>
References: <4FA239AB.4080308@...1114...>
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
 Makefile.am           |   25 ++++++++++++++++++++++++-
 configure.ac          |   11 +++++++++++
 src/openvpn/options.c |    6 ++++++
 3 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ab3e3d2..d6dc2c5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -40,11 +40,18 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/depcomp $(srcdir)/aclocal.m4 \
 	$(srcdir)/config.guess $(srcdir)/config.sub
 
+CLEANFILES = \
+	config-version.h
+
 EXTRA_DIST = \
 	contrib \
 	debug
 
-SUBDIRS = build distro include src sample doc tests
+if GIT_CHECKOUT
+.PHONY: config-version.h
+endif
+
+SUBDIRS = . build distro include src sample doc tests
 
 dist_doc_DATA = \
 	COPYRIGHT.GPL \
@@ -53,6 +60,7 @@ dist_doc_DATA = \
 dist_noinst_DATA = \
 	.gitignore \
 	.gitattributes \
+	config-version.h.in \
 	PORTS \
 	README.IPv6 TODO.IPv6 \
 	README.polarssl \
@@ -75,3 +83,18 @@ if WIN32
 rootdir=$(prefix)
 root_DATA = version.sh
 endif
+
+if GIT_CHECKOUT
+nodist_noinst_HEADERS = \
+	config-version.h
+config-version.h:
+	@PACKAGE_VERSION_EXTRA_GIT_REVISION="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) rev-parse --symbolic-full-name HEAD`/`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) rev-parse --short=16 HEAD`"; \
+		sed "s#@PACKAGE_VERSION_EXTRA_GIT_REVISION[@]#$${PACKAGE_VERSION_EXTRA_GIT_REVISION}#g" "$(srcdir)/config-version.h.in" > config-version.h.tmp
+	@if ! [ -f config-version.h ] || ! cmp -s config-version.h.tmp config-version.h; then \
+		echo "replacing config-version.h"; \
+		mv config-version.h.tmp config-version.h; \
+	else \
+		rm config-version.h.tmp; \
+	fi
+endif
+
diff --git a/configure.ac b/configure.ac
index 399b4e7..dd94522 100644
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
@@ -781,6 +783,14 @@ PKG_CHECK_MODULES(
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
@@ -928,6 +938,7 @@ AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
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


