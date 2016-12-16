From: Christian Hesse <list@...1798...>
Date: Fri, 16 Dec 2016 16:57:55 +0100
Message-Id: <20161216155755.29931-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH 1/1] do not race on RuntimeDirectory
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

So create a RuntimeDirectory per instance.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 distro/systemd/openvpn-client@...1685... | 2 +-
 distro/systemd/openvpn-server@...1685... | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/openvpn-client@...1685...
index 5618af3..fcb5302 100644
--- a/distro/systemd/openvpn-client@...1685...
+++ b/distro/systemd/openvpn-client@...1685...
@@ -9,7 +9,7 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 Type=notify
 PrivateTmp=true
-RuntimeDirectory=openvpn-client
+RuntimeDirectory=openvpn-client@%i
 RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/client
 ExecStart=/usr/sbin/openvpn --suppress-timestamps --nobind --config %i.conf
diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/openvpn-server@...1685...
index b9b4dba..8b240cf 100644
--- a/distro/systemd/openvpn-server@...1685...
+++ b/distro/systemd/openvpn-server@...1685...
@@ -9,10 +9,10 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 Type=notify
 PrivateTmp=true
-RuntimeDirectory=openvpn-server
+RuntimeDirectory=openvpn-server@%i
 RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/server
-ExecStart=/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
+ExecStart=/usr/sbin/openvpn --status %t/openvpn-server@%i/status.log --status-version 2 --suppress-timestamps --config %i.conf
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
-- 
2.11.0


