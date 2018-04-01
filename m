From: Christian Hesse <list@...1798...>
Date: Sun,  1 Apr 2018 21:13:07 +0200
Message-Id: <20180401191309.32211-2-list@...1798...>
In-Reply-To: <20180401191309.32211-1-list@...1798...>
References: <20180401191309.32211-1-list@...1798...>
Subject: [Openvpn-devel] [RFC 1/3] systemd: run openvpn with dedicated user
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

Now that we have a native netlink interface run the process with dedicated
user 'openvpn'. This is possibly by granting ambient capabilities, see
systemd.exec(5).

Signed-off-by: Christian Hesse <mail@...1798...>
---
 configure.ac                              | 8 ++++++++
 distro/systemd/Makefile.am                | 4 ++++
 distro/systemd/openvpn-client@...2221... | 4 +++-
 distro/systemd/openvpn-server@...2221... | 4 +++-
 distro/systemd/sysusers-openvpn.conf      | 1 +
 distro/systemd/tmpfiles-openvpn.conf      | 4 ++--
 6 files changed, 21 insertions(+), 4 deletions(-)
 create mode 100644 distro/systemd/sysusers-openvpn.conf

diff --git a/configure.ac b/configure.ac
index f2e4aa47..3d9d2ed5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -365,6 +365,7 @@ AC_ARG_VAR([GIT], [path to git utility])
 AC_ARG_VAR([SYSTEMD_ASK_PASSWORD], [path to systemd-ask-password utility])
 AC_ARG_VAR([SYSTEMD_UNIT_DIR], [Path of systemd unit directory @<:@default=LIBDIR/systemd/system@:>@])
 AC_ARG_VAR([TMPFILES_DIR], [Path of tmpfiles directory @<:@default=LIBDIR/tmpfiles.d@:>@])
+AC_ARG_VAR([SYSUSERS_DIR], [Path of sysusers directory @<:@default=LIBDIR/sysusers.d@:>@])
 AC_PATH_PROGS([IFCONFIG], [ifconfig],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([ROUTE], [route],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([IPROUTE], [ip],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
@@ -1198,6 +1199,12 @@ if test "$enable_systemd" = "yes" ; then
     else
         tmpfilesdir="\${libdir}/tmpfiles.d"
     fi
+
+    if test -n "${SYSUSERS_DIR}"; then
+        sysusersdir="${SYSUSERS_DIR}"
+    else
+        sysusersdir="\${libdir}/sysusers.d"
+    fi
 fi
 
 
@@ -1381,6 +1388,7 @@ AC_SUBST([sampledir])
 
 AC_SUBST([systemdunitdir])
 AC_SUBST([tmpfilesdir])
+AC_SUBST([sysusersdir])
 
 VENDOR_SRC_ROOT="\$(abs_top_srcdir)/vendor/"
 VENDOR_DIST_ROOT="\$(abs_top_builddir)/vendor/dist"
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index 69e12699..2641a63d 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -14,6 +14,7 @@
 
 EXTRA_DIST = \
 	tmpfiles-openvpn.conf \
+	sysusers-openvpn.conf \
 	openvpn-client@...2221... \
 	openvpn-server@...2221...
 
@@ -23,11 +24,14 @@ systemdunit_DATA = \
 	openvpn-server@...1685...
 tmpfiles_DATA = \
 	tmpfiles-openvpn.conf
+sysusers_DATA = \
+	sysusers-openvpn.conf
 dist_doc_DATA = \
 	README.systemd
 
 install-data-hook:
 	mv $(DESTDIR)$(tmpfilesdir)/tmpfiles-openvpn.conf $(DESTDIR)$(tmpfilesdir)/openvpn.conf
+	mv $(DESTDIR)$(sysusersdir)/sysusers-openvpn.conf $(DESTDIR)$(sysusersdir)/openvpn.conf
 endif
 
 MAINTAINERCLEANFILES = \
diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/openvpn-client@...2221...
index cbcef653..a103d751 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -9,9 +9,11 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 Type=notify
 PrivateTmp=true
+User=openvpn
+Group=openvpn
 WorkingDirectory=/etc/openvpn/client
 ExecStart=@sbindir@/openvpn --suppress-timestamps --nobind --config %i.conf
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+AmbientCapabilities=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index a8366a04..7275e86a 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -9,9 +9,11 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 Type=notify
 PrivateTmp=true
+User=openvpn
+Group=openvpn
 WorkingDirectory=/etc/openvpn/server
 ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+AmbientCapabilities=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
diff --git a/distro/systemd/sysusers-openvpn.conf b/distro/systemd/sysusers-openvpn.conf
new file mode 100644
index 00000000..d200852b
--- /dev/null
+++ b/distro/systemd/sysusers-openvpn.conf
@@ -0,0 +1 @@
+u openvpn - "OpenVPN user" /
diff --git a/distro/systemd/tmpfiles-openvpn.conf b/distro/systemd/tmpfiles-openvpn.conf
index bb79671e..835dc1c8 100644
--- a/distro/systemd/tmpfiles-openvpn.conf
+++ b/distro/systemd/tmpfiles-openvpn.conf
@@ -1,2 +1,2 @@
-d /run/openvpn-client 0710 root root -
-d /run/openvpn-server 0710 root root -
+d /run/openvpn-client 0750 openvpn openvpn -
+d /run/openvpn-server 0750 openvpn openvpn -

