From: David Sommerseth <davids@...515...>
Date: Tue, 28 Mar 2017 00:16:20 +0200
Message-Id: <20170327221620.24639-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] systemd: Add and ship README.systemd
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

This new README file describes how to use the new
openvpn-client@...1685... and openvpn-server@...1685... unit files properly.

The purpose of this file is primarily for all systemd based
distributions to have a common set of documentation.

Signed-off-by: David Sommerseth <davids@...515...>
---
 distro/systemd/Makefile.am    |  2 ++
 distro/systemd/README.systemd | 71 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 distro/systemd/README.systemd

diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index 1e3f3ea..5da926b 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -23,6 +23,8 @@ systemdunit_DATA = \
 	openvpn-server@...1685...
 tmpfiles_DATA = \
 	tmpfiles-openvpn.conf
+dist_doc_DATA = \
+	README.systemd
 
 install-data-hook:
 	mv $(DESTDIR)$(tmpfilesdir)/tmpfiles-openvpn.conf $(DESTDIR)$(tmpfilesdir)/openvpn.conf
diff --git a/distro/systemd/README.systemd b/distro/systemd/README.systemd
new file mode 100644
index 0000000..cf0003e
--- /dev/null
+++ b/distro/systemd/README.systemd
@@ -0,0 +1,71 @@
+OpenVPN and systemd
+===================
+
+As of OpenVPN v2.4, upstream is shipping systemd unit files to provide a
+fine grained control of each OpenVPN configuration as well as trying to
+restrict the capabilities the OpenVPN process have on a system.
+
+
+Configuration profile types
+---------------------------
+These new unit files separates between client and server profiles.  The
+configuration files are kept in separate directories, to provide clarity
+of the profile they run under.
+
+Typically the client profile cannot bind to any ports below port 1024
+and the client configuration is always started with --nobind.
+
+The server profile is allowed to bind to any ports.  In addition it enables
+a client status file, usually found in the /run/openvpn-server directory.
+The status format is set to version 2 by default.  These settings may be
+overridden by adding --status and/or --status-version in the OpenVPN
+configuration file.
+
+Neither of these profiles makes use of PID files, but OpenVPN reports back to
+systemd its PID once it has initialized.
+
+For configuration using a peer-to-peer mode (not using --mode server on one
+of the sides) it is recommended to use the client profile.
+
+
+Configuration files
+-------------------
+These new unit files expects client configuration files to be made available
+in /etc/openvpn/client.  Similar for the server configurations, it is expected
+to be found in /etc/openvpn/server.  The configuration files must have a .conf
+file extension.
+
+
+Managing VPN tunnels
+--------------------
+Use the normal systemctl tool to start, stop VPN tunnels, as well as enable
+and disable tunnels at boot time.  The syntax is:
+
+ - client configurations:
+    # systemctl $OPER openvpn-client@$CONFIGNAME
+
+ - server configurations:
+    # systemctl $OPER openvpn-server@$CONFIGNAME
+
+Similarly, to view the OpenVPN journal log use a similar syntax:
+
+   # journalctl -u openvpn-client@$CONFIGNAME
+ or
+   # journalctl -u openvpn-server@$CONFIGNAME
+
+* Examples
+  Say your server configuration is /etc/openvpn/server/tun0.conf, you
+  start this VPN service like this:
+
+    # systemctl start openvpn-server@...2255...
+
+  A client configuration file in /etc/openvpn/client/corpvpn.conf is
+  started like this:
+
+    # systemctl start openvpn-client@...2256...
+
+  To view the server configuration's journal only listing entries from
+  yesterday and until today:
+
+    # journalctl --since yesterday -u openvpn-server@...2255...
+
-- 
2.11.0


