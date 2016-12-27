From: Christian Hesse <list@...1798...>
Date: Tue, 27 Dec 2016 23:15:38 +0100
Message-Id: <20161227221539.329-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH 1/2] use automake tools to install systemd
	files
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

If systemd is enabled we install unit files to $libdir/systemd/system
(or the path specified by SYSTEMD_UNIT_DIR).
The unit files are generated on the fly with matching $sbindir.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 configure.ac                                       | 10 ++++++++
 distro/Makefile.am                                 |  4 +---
 distro/systemd/.gitignore                          |  1 +
 distro/systemd/Makefile.am                         | 27 ++++++++++++++++++++++
 ...-client@...1685... => openvpn-client@...2221...} |  2 +-
 ...-server@...1685... => openvpn-server@...2221...} |  2 +-
 6 files changed, 41 insertions(+), 5 deletions(-)
 create mode 100644 distro/systemd/.gitignore
 create mode 100644 distro/systemd/Makefile.am
 rename distro/systemd/{openvpn-client@...1685... => openvpn-client@...2221...} (89%)
 rename distro/systemd/{openvpn-server@...1685... => openvpn-server@...2221...} (83%)

diff --git a/configure.ac b/configure.ac
index 43487b0..114fcb9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -378,6 +378,7 @@ AC_ARG_VAR([NETSTAT], [path to netstat utility]) # tests
 AC_ARG_VAR([MAN2HTML], [path to man2html utility])
 AC_ARG_VAR([GIT], [path to git utility])
 AC_ARG_VAR([SYSTEMD_ASK_PASSWORD], [path to systemd-ask-password utility])
+AC_ARG_VAR([SYSTEMD_UNIT_DIR], [Path of systemd unit directory @<:@default=LIBDIR/systemd/system@:>@])
 AC_PATH_PROGS([IFCONFIG], [ifconfig],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([ROUTE], [route],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([IPROUTE], [ip],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
@@ -1075,6 +1076,12 @@ if test "$enable_systemd" = "yes" ; then
     OPTIONAL_SYSTEMD_LIBS="${libsystemd_LIBS}"
     AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd integration])
     LIBS="${saved_LIBS}"
+
+    if test -n "${SYSTEMD_UNIT_DIR}"; then
+        systemdunitdir="${SYSTEMD_UNIT_DIR}"
+    else
+        systemdunitdir="\${libdir}/systemd/system"
+    fi
 fi
 
 
@@ -1250,6 +1257,8 @@ sampledir="\$(docdir)/sample"
 AC_SUBST([plugindir])
 AC_SUBST([sampledir])
 
+AC_SUBST([systemdunitdir])
+
 VENDOR_SRC_ROOT="\$(abs_top_srcdir)/vendor/"
 VENDOR_DIST_ROOT="\$(abs_top_builddir)/vendor/dist"
 VENDOR_BUILD_ROOT="\$(abs_top_builddir)/vendor/.build"
@@ -1288,6 +1297,7 @@ AC_CONFIG_FILES([
 	distro/Makefile
 	distro/rpm/Makefile
 	distro/rpm/openvpn.spec
+	distro/systemd/Makefile
 	include/Makefile
 	src/Makefile
 	src/compat/Makefile
diff --git a/distro/Makefile.am b/distro/Makefile.am
index 7a9ffd0..eb0e554 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -12,6 +12,4 @@
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
-SUBDIRS = rpm
-
-EXTRA_DIST = systemd/openvpn-client@...1685... systemd/openvpn-server@...1685...
+SUBDIRS = rpm systemd
diff --git a/distro/systemd/.gitignore b/distro/systemd/.gitignore
new file mode 100644
index 0000000..ef4c0b8
--- /dev/null
+++ b/distro/systemd/.gitignore
@@ -0,0 +1 @@
+*.service
\ No newline at end of file
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
new file mode 100644
index 0000000..53a88c9
--- /dev/null
+++ b/distro/systemd/Makefile.am
@@ -0,0 +1,27 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2017 OpenVPN Technologies, Inc. <sales@...515...>
+#
+
+%.service: %.service.in Makefile
+	$(AM_V_GEN)sed -e 's|\@sbindir\@|$(sbindir)|' \
+		$< > $@.tmp && mv $@.tmp $@
+
+EXTRA_DIST = \
+	openvpn-client@...2221... \
+	openvpn-server@...2221...
+
+if ENABLE_SYSTEMD
+systemdunitdir = $(systemdunitdir)
+systemdunit_DATA = \
+	openvpn-client@...1685... \
+	openvpn-server@...1685...
+endif
+
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/openvpn-client@...2221...
similarity index 89%
rename from distro/systemd/openvpn-client@...1685...
rename to distro/systemd/openvpn-client@...2221...
index 5618af3..d9fd6b0 100644
--- a/distro/systemd/openvpn-client@...1685...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -12,7 +12,7 @@ PrivateTmp=true
 RuntimeDirectory=openvpn-client
 RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/client
-ExecStart=/usr/sbin/openvpn --suppress-timestamps --nobind --config %i.conf
+ExecStart=@sbindir@ --suppress-timestamps --nobind --config %i.conf
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/openvpn-server@...2221...
similarity index 83%
rename from distro/systemd/openvpn-server@...1685...
rename to distro/systemd/openvpn-server@...2221...
index b9b4dba..a270982 100644
--- a/distro/systemd/openvpn-server@...1685...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -12,7 +12,7 @@ PrivateTmp=true
 RuntimeDirectory=openvpn-server
 RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/server
-ExecStart=/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
+ExecStart=@sbindir@ --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
-- 
2.11.0


