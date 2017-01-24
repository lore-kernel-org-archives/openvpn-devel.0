From: Christian Hesse <list@...1798...>
Date: Tue, 24 Jan 2017 15:39:47 +0100
Message-Id: <20170124143947.27385-2-list@...1798...>
In-Reply-To: <20170124143947.27385-1-list@...1798...>
References: <e6deb9e1-bc10-9085-4ebe-31e8e34b8b6b@...2080...>
	<20170124143947.27385-1-list@...1798...>
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
To: openvpn-devel@lists.sourceforge.net
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
 distro/systemd/Makefile.am                | 6 ++++++
 distro/systemd/openvpn-client@...2221... | 2 --
 distro/systemd/openvpn-server@...2221... | 2 --
 distro/systemd/tmpfiles-openvpn.conf      | 2 ++
 5 files changed, 16 insertions(+), 4 deletions(-)
 create mode 100644 distro/systemd/tmpfiles-openvpn.conf

diff --git a/configure.ac b/configure.ac
index 48d8f0c..79fb1ba 100644
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
@@ -1106,6 +1107,12 @@ if test "$enable_systemd" = "yes" ; then
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
 
 
@@ -1283,6 +1290,7 @@ AC_SUBST([plugindir])
 AC_SUBST([sampledir])
 
 AC_SUBST([systemdunitdir])
+AC_SUBST([tmpfilesdir])
 
 VENDOR_SRC_ROOT="\$(abs_top_srcdir)/vendor/"
 VENDOR_DIST_ROOT="\$(abs_top_builddir)/vendor/dist"
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index b10c6ed..1e3f3ea 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -13,6 +13,7 @@
 		$< > $@.tmp && mv $@.tmp $@
 
 EXTRA_DIST = \
+	tmpfiles-openvpn.conf \
 	openvpn-client@...2221... \
 	openvpn-server@...2221...
 
@@ -20,6 +21,11 @@ if ENABLE_SYSTEMD
 systemdunit_DATA = \
 	openvpn-client@...1685... \
 	openvpn-server@...1685...
+tmpfiles_DATA = \
+	tmpfiles-openvpn.conf
+
+install-data-hook:
+	mv $(DESTDIR)$(tmpfilesdir)/tmpfiles-openvpn.conf $(DESTDIR)$(tmpfilesdir)/openvpn.conf
 endif
 
 MAINTAINERCLEANFILES = \
diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/openvpn-client@...2221...
index d933772..1be1e33 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -9,8 +9,6 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 Type=notify
 PrivateTmp=true
-RuntimeDirectory=openvpn-client
-RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/client
 ExecStart=@sbindir@/openvpn --suppress-timestamps --nobind --config %i.conf
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index da5c78e..3dccaf2 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -9,8 +9,6 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 Type=notify
 PrivateTmp=true
-RuntimeDirectory=openvpn-server
-RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/server
 ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
diff --git a/distro/systemd/tmpfiles-openvpn.conf b/distro/systemd/tmpfiles-openvpn.conf
new file mode 100644
index 0000000..bb79671
--- /dev/null
+++ b/distro/systemd/tmpfiles-openvpn.conf
@@ -0,0 +1,2 @@
+d /run/openvpn-client 0710 root root -
+d /run/openvpn-server 0710 root root -
-- 
2.11.0


