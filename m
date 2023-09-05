From: Antonio Quartulli <a@...2181...>
Date: Tue,  5 Sep 2023 23:13:57 +0200
Message-ID: <20230905211357.581-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] man: extend description for "dhcp-option
 DNS" on Windows
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
Cc: Antonio Quartulli <antonio@...2726...>

From: Antonio Quartulli <antonio@...2726...>

Add an important detail about the DNS configured via this option
to be an "interface-specific" DNS. This detail is important when
troubleshooting DNS issues since this logic will bypass the
routing table.

Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
 doc/man-sections/vpn-network-options.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index b7f33acd..17c7d4a2 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -158,6 +158,12 @@ routing.
         Set primary domain name server IPv4 or IPv6 address.
         Repeat this option to set secondary DNS server addresses.
 
+        On Windows this option sets an "interface-specific" DNS, meaning
+        that the system will try to reach it via the VPN interface, no
+        matter what the routing table says. If the wanted DNS is not
+        expected to be reached via VPN, please don't use this option, but
+        rather set the DNS manually (or via DHCP).
+
         Note: DNS IPv6 servers are currently set using netsh (the existing
         DHCP code can only do IPv4 DHCP, and that protocol only permits
         IPv4 addresses anywhere). The option will be put into the
-- 
2.41.0


