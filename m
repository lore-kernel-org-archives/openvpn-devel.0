From: Christian Hesse <list@...1798...>
Date: Tue, 27 Dec 2016 23:18:32 +0100
Message-Id: <20161227221832.610-1-list@...1798...>
In-Reply-To: <20161209181303.20267-1-list@...1798...>
References: <20161209181303.20267-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH v2 1/1] add more security feature for
	systemd units
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

ProtectSystem=true mounts the /usr and /boot directories read-only.

ProtectHome=true makes the directories /home, /root and /run/user
inaccessible and empty for the process.

See systemd.exec(5) [0] for details.

v2: Replace ProtectSystem=strict with ProtectSystem=true. Some configurations
    may want to write to /etc or the like.

[0] https://www.freedesktop.org/software/systemd/man/systemd.exec.html

Signed-off-by: Christian Hesse <mail@...1798...>
---
 distro/systemd/openvpn-client@...1685... | 2 ++
 distro/systemd/openvpn-server@...1685... | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/openvpn-client@...1685...
index 5618af3..b92f2fa 100644
--- a/distro/systemd/openvpn-client@...1685...
+++ b/distro/systemd/openvpn-client@...1685...
@@ -17,6 +17,8 @@ CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETU
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
+ProtectSystem=true
+ProtectHome=true
 
 [Install]
 WantedBy=multi-user.target
diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/openvpn-server@...1685...
index b9b4dba..535a79d 100644
--- a/distro/systemd/openvpn-server@...1685...
+++ b/distro/systemd/openvpn-server@...1685...
@@ -17,6 +17,8 @@ CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RA
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
+ProtectSystem=true
+ProtectHome=true
 
 [Install]
 WantedBy=multi-user.target
-- 
2.11.0


