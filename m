From: David Sommerseth <davids@...515...>
Date: Thu,  7 Sep 2017 01:52:02 +0200
Message-Id: <20170906235202.26551-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
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

Systemd supervises services it has started and can act upon unexpected
scenarios.  This change will restart OpenVPN after 5 seconds if the OpenVPN
process exits unexpectedly.

The on-failure mode is the recommended mode by upstream systemd.

This change have been tested on a test server for some month, and it
works indeed as intended when provoking the OpenVPN process to stop.

Signed-off-by: David Sommerseth <davids@...515...>
---
 distro/systemd/openvpn-server@...2221... | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index b343868a..a8366a04 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -18,6 +18,8 @@ DeviceAllow=/dev/net/tun rw
 ProtectSystem=true
 ProtectHome=true
 KillMode=process
+RestartSec=5s
+Restart=on-failure
 
 [Install]
 WantedBy=multi-user.target
-- 
2.13.5


