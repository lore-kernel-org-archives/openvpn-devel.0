From: Christian Ehrhardt <christian.ehrhardt@...1808...>
Date: Wed, 29 Aug 2018 16:27:15 +0200
Message-Id: <20180829142715.417-3-christian.ehrhardt@...1808...>
In-Reply-To: <20180829142715.417-1-christian.ehrhardt@...1808...>
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
Subject: [Openvpn-devel] [PATCH 2/2] systemd: extend CapabilityBoundingSet
 for learn-address
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

It seems a not too uncommon case that learn-address needs to recycle
dnsmasq - to do so it would need CAP_KILL.

This was suggested on https://community.openvpn.net/openvpn/ticket/918

Signed-off-by: Christian Ehrhardt <christian.ehrhardt@...1808...>
---
 distro/systemd/openvpn-server@...2221... | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index d1cc72cb..edace213 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -11,7 +11,7 @@ Type=notify
 PrivateTmp=true
 WorkingDirectory=/etc/openvpn/server
 ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AUDIT_WRITE
+CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AUDIT_WRITE CAP_KILL
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
-- 
2.17.1


