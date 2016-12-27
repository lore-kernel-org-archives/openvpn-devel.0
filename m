From: Christian Hesse <list@...1798...>
Date: Tue, 27 Dec 2016 23:15:39 +0100
Message-Id: <20161227221539.329-2-list@...1798...>
In-Reply-To: <20161227221539.329-1-list@...1798...>
References: <20161227221539.329-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH 2/2] do not race on RuntimeDirectory
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

Different unit instances create and destroy the same RuntimeDirectory.
This leads to running instances where the status file (and possibly
more runtime data) is no longer accessible.

So do not handle this in unit files but provide a tmpfiles.d
configuration and let systemd-tmpfiles do the work.
Nobody will (unintentionally) delete the directories and its content.
As /run is volatile we do not have to care about cleanup.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 configure.ac                              | 8 ++++++++
 distro/systemd/Makefile.am                | 8 ++++++++
 distro/systemd/openvpn-client@...2221... | 2 --
 distro/systemd/openvpn-server@...2221... | 2 --
 distro/systemd/openvpn.conf               | 2 ++
 5 files changed, 18 insertions(+), 4 deletions(-)
 create mode 100644 distro/systemd/openvpn.conf

diff --git a/configure.ac b/configure.ac
index 114fcb9..e3a682a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -379,6 +379,7 @@ AC_ARG_VAR([MAN2HTML], [path to man2html utility])
 AC_ARG_VAR([GIT], [path to git utility])
 AC_ARG_VAR([SYSTEMD_ASK_PASSWORD], [path to systemd-ask-password utility])
 AC_ARG_VAR([SYSTEMD_UNIT_DIR], [Path of systemd unit directory @<:@default=LIBDIR/systemd/system@:>@])
+AC_ARG_VAR([TMPFILES_DIR], [Path of tmpfiles directory @<:@default=LIBDIR/tmpfiles.d@:>@])
 AC_PATH_PROGS([IFCONFIG], [ifconfig],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([ROUTE], [route],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([IPROUTE], [ip],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
@@ -1082,6 +1083,12 @@ if test "$enable_systemd" = "yes" ; then
     else
         systemdunitdir="\${libdir}/systemd/system"
     fi
+
+    if test -n "${TMPFILES_DIR}"; then
+        tmpfilesdir="${TMPFILES_DIR}"
+    else
+        tmpfilesdir="\${libdir}/tmpfiles.d"
+    fi
 fi
 
 
@@ -1258,6 +1265,7 @@ AC_SUBST([plugindir])
 AC_SUBST([sampledir])
 
 AC_SUBST([systemdunitdir])
+AC_SUBST([tmpfilesdir])
 
 VENDOR_SRC_ROOT="\$(abs_top_srcdir)/vendor/"
 VENDOR_DIST_ROOT="\$(abs_top_builddir)/vendor/dist"
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index 53a88c9..1a6c974 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -12,7 +12,12 @@
 	$(AM_V_GEN)sed -e 's|\@sbindir\@|$(sbindir)|' \
 		$< > $@.tmp && mv $@.tmp $@
 
+install-data-local:
+	$(INSTALL) -d -m0710 $(DESTDIR)/run/openvpn-client
+	$(INSTALL) -d -m0710 $(DESTDIR)/run/openvpn-server
+
 EXTRA_DIST = \
+	openvpn.conf \
 	openvpn-client@...2221... \
 	openvpn-server@...2221...
 
@@ -21,6 +26,9 @@ systemdunitdir = $(systemdunitdir)
 systemdunit_DATA = \
 	openvpn-client@...1685... \
 	openvpn-server@...1685...
+tmpfilesdir = $(tmpfilesdir)
+tmpfiles_DATA = \
+	openvpn.conf
 endif
 
 MAINTAINERCLEANFILES = \
diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/openvpn-client@...2221...
index d9fd6b0..354d206 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -9,8 +9,6 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 Type=notify
 PrivateTmp=true
-RuntimeDirectory=openvpn-client
-RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/client
 ExecStart=@sbindir@ --suppress-timestamps --nobind --config %i.conf
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index a270982..35f4a14 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -9,8 +9,6 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 Type=notify
 PrivateTmp=true
-RuntimeDirectory=openvpn-server
-RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/server
 ExecStart=@sbindir@ --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
diff --git a/distro/systemd/openvpn.conf b/distro/systemd/openvpn.conf
new file mode 100644
index 0000000..57f20cd
--- /dev/null
+++ b/distro/systemd/openvpn.conf
@@ -0,0 +1,2 @@
+d /run/openvpn-client 0710 root root -
+d /run/openvpn-server 0710 root root -
\ No newline at end of file
-- 
2.11.0


