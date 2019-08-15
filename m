From: =?UTF-8?q?Fran=C3=A7ois=20Kooman?= <fkooman@...2318...>
Date: Thu, 15 Aug 2019 09:28:55 +0200
Message-Id: <20190815072855.21232-1-fkooman@...2318...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] More specific syslog process name with
 systemd
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

Adds the `--syslog` option to specify the unit and configuration
name when using systemd.

Signed-off-by: François Kooman <fkooman@...2318...>
---
 distro/systemd/openvpn-client@...2221... | 2 +-
 distro/systemd/openvpn-server@...2221... | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/openvpn-client@...2221...
index cbcef653..266d9f9c 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -10,7 +10,7 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 Type=notify
 PrivateTmp=true
 WorkingDirectory=/etc/openvpn/client
-ExecStart=@sbindir@/openvpn --suppress-timestamps --nobind --config %i.conf
+ExecStart=@sbindir@/openvpn --syslog %p@%i --suppress-timestamps --nobind --config %i.conf
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index d1cc72cb..be086b79 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -10,7 +10,7 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 Type=notify
 PrivateTmp=true
 WorkingDirectory=/etc/openvpn/server
-ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
+ExecStart=@sbindir@/openvpn --syslog %p@%i --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AUDIT_WRITE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
-- 
2.21.0


