From: Selva Nair <selva.nair@...277...>
Date: Sun,  6 Dec 2015 21:17:40 -0500
Message-Id: <1449454660-20050-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Make default dhcp server ip offset = 0 for
	subnet topology
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

This makes the default choice for the emulated dhcp server
address to be the network address, same as in the TAP mode. Also
change the default ifconfig_pool_end to broadcast - 1.

Currently the default ip for the dhcp server is the broadcast
address - 1, making that address not available for windows clients.
This change also brings the code in agreement with the comments in
helper.c and the documentation.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/helper.c |    2 +-
 src/openvpn/tun.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 62f88ec..cf29246 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -309,7 +309,7 @@ helper_client_server (struct options *o)
 		{
 		  o->ifconfig_pool_defined = true;
 		  o->ifconfig_pool_start = o->server_network + 2;
-		  o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - 2;
+		  o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - 1;
 		  ifconfig_pool_verify_range (M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
 		}
 	      o->ifconfig_pool_netmask = o->server_netmask;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 014d988..c09fefd 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5324,7 +5324,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 	      if (tt->options.dhcp_masq_custom_offset)
 		ep[2] = dhcp_masq_addr (tt->local, tt->remote_netmask, tt->options.dhcp_masq_offset);
 	      else
-		ep[2] = dhcp_masq_addr (tt->local, tt->remote_netmask, -1);
+		ep[2] = dhcp_masq_addr (tt->local, tt->remote_netmask, 0);
 	    }
 	  else
 	    ep[2] = htonl (tt->remote_netmask);
-- 
1.7.10.4


