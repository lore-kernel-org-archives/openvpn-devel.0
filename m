From: Christian Hesse <list@...1798...>
Date: Mon, 23 Apr 2018 11:28:13 +0200
Message-Id: <20180423092813.24844-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH 1/1] systemd: run openvpn with dedicated user
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
user 'openvpn'. This is possible by granting ambient capabilities, see
systemd.exec(5).

Signed-off-by: Christian Hesse <mail@...1798...>
---
 .gitignore                                |  1 +
 configure.ac                              |  9 +++++++++
 distro/systemd/Makefile.am                | 24 ++++++++++++++++++++++-
 distro/systemd/openvpn-client@...2221... |  4 +++-
 distro/systemd/openvpn-server@...2221... |  4 +++-
 distro/systemd/sysusers-openvpn.conf      |  1 +
 distro/systemd/tmpfiles-openvpn.conf      |  2 --
 distro/systemd/tmpfiles-openvpn.conf.in   |  4 ++++
 src/openvpn/init.c                        |  8 ++++++++
 9 files changed, 52 insertions(+), 5 deletions(-)
 create mode 100644 distro/systemd/sysusers-openvpn.conf
 delete mode 100644 distro/systemd/tmpfiles-openvpn.conf
 create mode 100644 distro/systemd/tmpfiles-openvpn.conf.in

diff --git a/.gitignore b/.gitignore
index 25009d81..00abdd5a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -55,6 +55,7 @@ doc/openvpn.8.html
 /doc/doxygen/openvpn.doxyfile
 distro/rpm/openvpn.spec
 distro/systemd/*.service
+distro/systemd/tmpfiles-openvpn.conf
 sample/sample-keys/sample-ca/
 vendor/.build
 vendor/dist
diff --git a/configure.ac b/configure.ac
index 251cb9a2..ef8f5864 100644
--- a/configure.ac
+++ b/configure.ac
@@ -367,6 +367,7 @@ AC_ARG_VAR([GIT], [path to git utility])
 AC_ARG_VAR([SYSTEMD_ASK_PASSWORD], [path to systemd-ask-password utility])
 AC_ARG_VAR([SYSTEMD_UNIT_DIR], [Path of systemd unit directory @<:@default=LIBDIR/systemd/system@:>@])
 AC_ARG_VAR([TMPFILES_DIR], [Path of tmpfiles directory @<:@default=LIBDIR/tmpfiles.d@:>@])
+AC_ARG_VAR([SYSUSERS_DIR], [Path of sysusers directory @<:@default=LIBDIR/sysusers.d@:>@])
 AC_PATH_PROGS([IFCONFIG], [ifconfig],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([ROUTE], [route],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
 AC_PATH_PROGS([IPROUTE], [ip],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
@@ -1200,6 +1201,12 @@ if test "$enable_systemd" = "yes" ; then
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
 
 
@@ -1375,6 +1382,7 @@ AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "yes"])
 AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" = "yes"])
+AM_CONDITIONAL([ENABLE_IPROUTE], [test "${enable_iproute2}" = "yes"])
 
 sampledir="\$(docdir)/sample"
 AC_SUBST([plugindir])
@@ -1382,6 +1390,7 @@ AC_SUBST([sampledir])
 
 AC_SUBST([systemdunitdir])
 AC_SUBST([tmpfilesdir])
+AC_SUBST([sysusersdir])
 
 VENDOR_SRC_ROOT="\$(abs_top_srcdir)/vendor/"
 VENDOR_DIST_ROOT="\$(abs_top_builddir)/vendor/dist"
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index 69e12699..1b7ce5f9 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -10,14 +10,35 @@
 
 %.service: %.service.in Makefile
 	$(AM_V_GEN)sed -e 's|\@sbindir\@|$(sbindir)|' \
+		-e 's|\@SYSTEMD_USER\@|$(SYSTEMD_USER)|' \
+		-e 's|\@SYSTEMD_CAPS_OPTION\@|$(SYSTEMD_CAPS_OPTION)|' \
+		-e 's|\@SYSTEMD_CAPS_VALUES\@|$(SYSTEMD_CAPS_VALUES)|' \
+		$< > $@.tmp && mv $@.tmp $@
+
+%.conf: %.conf.in Makefile
+	$(AM_V_GEN)sed -e 's|\@SYSTEMD_USER\@|$(SYSTEMD_USER)|g' \
 		$< > $@.tmp && mv $@.tmp $@
 
 EXTRA_DIST = \
-	tmpfiles-openvpn.conf \
+	sysusers-openvpn.conf \
+	tmpfiles-openvpn.conf.in \
 	openvpn-client@...2221... \
 	openvpn-server@...2221...
 
 if ENABLE_SYSTEMD
+if ENABLE_IPROUTE
+SYSTEMD_USER=root
+SYSTEMD_CAPS_OPTION=CapabilityBoundingSet
+SYSTEMD_CAPS_VALUES=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+else
+SYSTEMD_USER=openvpn
+SYSTEMD_CAPS_OPTION=AmbientCapabilities
+SYSTEMD_CAPS_VALUES=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+
+sysusers_DATA = \
+	sysusers-openvpn.conf
+endif
+
 systemdunit_DATA = \
 	openvpn-client@...1685... \
 	openvpn-server@...1685...
@@ -28,6 +49,7 @@ dist_doc_DATA = \
 
 install-data-hook:
 	mv $(DESTDIR)$(tmpfilesdir)/tmpfiles-openvpn.conf $(DESTDIR)$(tmpfilesdir)/openvpn.conf
+	mv $(DESTDIR)$(sysusersdir)/sysusers-openvpn.conf $(DESTDIR)$(sysusersdir)/openvpn.conf || true
 endif
 
 MAINTAINERCLEANFILES = \
diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/openvpn-client@...2221...
index cbcef653..96cbf68e 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -9,9 +9,11 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 Type=notify
 PrivateTmp=true
+User=@SYSTEMD_USER@
+Group=@SYSTEMD_USER@
 WorkingDirectory=/etc/openvpn/client
 ExecStart=@sbindir@/openvpn --suppress-timestamps --nobind --config %i.conf
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+@SYSTEMD_CAPS_OPTION@=@SYSTEMD_CAPS_VALUES@
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index a8366a04..3f00642e 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -9,9 +9,11 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 Type=notify
 PrivateTmp=true
+User=@SYSTEMD_USER@
+Group=@SYSTEMD_USER@
 WorkingDirectory=/etc/openvpn/server
 ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+@SYSTEMD_CAPS_OPTION@=@SYSTEMD_CAPS_VALUES@
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
deleted file mode 100644
index bb79671e..00000000
--- a/distro/systemd/tmpfiles-openvpn.conf
+++ /dev/null
@@ -1,2 +0,0 @@
-d /run/openvpn-client 0710 root root -
-d /run/openvpn-server 0710 root root -
diff --git a/distro/systemd/tmpfiles-openvpn.conf.in b/distro/systemd/tmpfiles-openvpn.conf.in
new file mode 100644
index 00000000..f58d2967
--- /dev/null
+++ b/distro/systemd/tmpfiles-openvpn.conf.in
@@ -0,0 +1,4 @@
+d /run/openvpn-client 0750 @SYSTEMD_USER@ @SYSTEMD_USER@ -
+d /run/openvpn-server 0750 @SYSTEMD_USER@ @SYSTEMD_USER@ -
+d /etc/openvpn/client 0750 @SYSTEMD_USER@ @SYSTEMD_USER@ -
+d /etc/openvpn/server 0750 @SYSTEMD_USER@ @SYSTEMD_USER@ -
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 36c1a4c4..0fc60d62 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1151,6 +1151,14 @@ do_uid_gid_chroot(struct context *c, bool no_delay)
         /* set user and/or group if we want to setuid/setgid */
         if (c0->uid_gid_specified)
         {
+#ifdef ENABLE_SYSTEMD
+            if (sd_notify(0, "READY=0") > 0 && getuid() != 0)
+            {
+                msg(M_INFO, "NOTE: Running from systemd with non-root uid, skipping downgrade");
+                return;
+            }
+#endif
+
             if (no_delay)
             {
                 platform_group_set(&c0->platform_state_group);

