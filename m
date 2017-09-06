From: David Sommerseth <davids@...515...>
Date: Thu,  7 Sep 2017 01:47:05 +0200
Message-Id: <20170906234705.26202-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] systemd: Ensure systemd shuts down OpenVPN
 in a proper way
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
To: openvpn-devel@lists.sourceforge.net

By default, when systemd is stopping OpenVPN it will send the SIGTERM
to all processes within the same process control-group.  This can come
as a surprise to plug-ins which may have fork()ed out child processes.

So we tell systemd to only send the SIGTERM signal to the main OpenVPN
process and let OpenVPN take care of the shutdown process on its own.

If the main OpenVPN process does not stop within 90 seconds (unless
changed), it will send SIGKILL to all remaining processes within
the same process control-group.

This issue have been reported in both Debian and Fedora.

Trac: 581
Signed-off-by: David Sommerseth <davids@...515...>
---
 distro/systemd/openvpn-client@...2221... | 1 +
 distro/systemd/openvpn-server@...2221... | 1 +
 2 files changed, 2 insertions(+)

diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/openvpn-client@...2221...
index 49e3f51c..cbcef653 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -17,6 +17,7 @@ DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
 ProtectSystem=true
 ProtectHome=true
+KillMode=process
 
 [Install]
 WantedBy=multi-user.target
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index 9a8a2c73..b343868a 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -17,6 +17,7 @@ DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
 ProtectSystem=true
 ProtectHome=true
+KillMode=process
 
 [Install]
 WantedBy=multi-user.target
-- 
2.13.5


