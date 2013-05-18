From: Gert Doering <gert@...1296...>
Date: Sat, 18 May 2013 12:43:01 +0200
Message-Id: <1368873781-29552-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Improve documentation and help text for
	--route-ipv6.
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

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8         | 6 +++++-
 src/openvpn/options.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index cbfc107..366e2f5 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5359,7 +5359,11 @@ if no gateway is specified.
 .TP
 .B --route-ipv6 ipv6addr/bits [gateway] [metric]
 setup IPv6 routing in the system to send the specified IPv6 network
-into OpenVPN's ``tun'' device
+into OpenVPN's ``tun''.  The gateway parameter is only used for
+IPv6 routes across ``tap'' devices, and if missing, the ``ipv6remote''
+field from
+.B --ifconfig-ipv6
+is used.
 .TP
 .B --server-ipv6 ipv6addr/bits
 convenience-function to enable a number of IPv6 related options at
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c5ed0d6..fdf52e0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -215,7 +215,7 @@ static const char usage_message[] =
   "--route-ipv6 network/bits [gateway] [metric] :\n"
   "                  Add IPv6 route to routing table after connection\n"
   "                  is established.  Multiple routes can be specified.\n"
-  "                  gateway default: taken from --route-ipv6-gateway or --ifconfig\n"
+  "                  gateway default: taken from 'remote' in --ifconfig-ipv6\n"
   "--max-routes n :  Specify the maximum number of routes that may be defined\n"
   "                  or pulled from a server.\n"
   "--route-gateway gw|'dhcp' : Specify a default gateway for use with --route.\n"
-- 
1.8.1.5


