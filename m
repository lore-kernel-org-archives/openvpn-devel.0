From: David Sommerseth <openvpn.list@...1114...>
Date: Thu, 18 Sep 2014 11:02:16 +0200
Message-Id: <1411030936-16309-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Add systemd unit file for OpenVPN
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

From: David Sommerseth <davids@...1347...>

This is to encourage all Linux distributions to use a unified systemd
unit file.

This unit file also tries to reduce the capabilities of the running
openvpn process.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 distro/systemd/openvpn@...1685... | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 distro/systemd/openvpn@...1685...

diff --git a/distro/systemd/openvpn@...1685... b/distro/systemd/openvpn@...1685...
new file mode 100644
index 0000000..e17a8a5
--- /dev/null
+++ b/distro/systemd/openvpn@...1685...
@@ -0,0 +1,19 @@
+[Unit]
+Description=OpenVPN tunnel for %I
+After=syslog.target network.target
+Documentation=man:openvpn(8)
+Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage
+Documentation=http://community.openvpn.net/openvpn/wiki/HOWTO
+
+[Service]
+PrivateTmp=true
+Type=forking
+PIDFile=/var/run/openvpn/%i.pid
+ExecStart=/usr/sbin/openvpn --daemon --writepid /var/run/openvpn/%i.pid --cd /etc/openvpn/ --config %i.conf
+CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH 
+LimitNPROC=10
+DeviceAllow=/dev/null rw
+DeviceAllow=/dev/net/tun rw
+
+[Install]
+WantedBy=multi-user.target
-- 
1.8.3.1


