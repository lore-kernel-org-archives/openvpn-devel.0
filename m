Resent-Message-Id: <201406062025.s56KPtEO015804@...1295...>
From: Gert Doering <gert@...1296...>
Date: Fri,  6 Jun 2014 20:43:55 +0200
Message-Id: <1402080235-24409-1-git-send-email-gert@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [PATCH] Drop incoming fe80:: packets silently now.
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

IPv6 has the concept of "link local" addresses, fe80::<host id>, which
normally are present on every link, and are used for stuff like DHCPv6,
neighbor discovery, etc.

OpenVPN point-to-multipoint mode currently does neither configure them on
tun interfaces, nor are they handled in a meaningful way if a client OS
always has them (like Windows or Solaris) - so the log fills with many
lines of "MULTI: bad source address from client [fe80::...]", serving
no useful purpose.

This patch just recognizes IPv6 LL packets and silently drops them.

Further patches can build on this and add full link-local support, which
would require address learning (as the addresse are based on host IDs, not
assigned by the server).

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/multi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e451924..f00a9cf 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2161,8 +2161,18 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 	      /* make sure that source address is associated with this client */
 	      else if (multi_get_instance_by_virtual_addr (m, &src, true) != m->pending)
 		{
-		  msg (D_MULTI_DROPPED, "MULTI: bad source address from client [%s], packet dropped",
-		       mroute_addr_print (&src, &gc));
+		  /* IPv6 link-local address (fe80::xxx)?
+                   */
+		  if ( (src.type & MR_ADDR_MASK) == MR_ADDR_IPV6 &&
+		        src.addr[0] == 0xfe && src.addr[1] == 0x80 )
+		    {
+		      /* do nothing, for now.  TODO: add address learning */
+		    }
+		  else
+		    {
+		      msg (D_MULTI_DROPPED, "MULTI: bad source address from client [%s], packet dropped",
+		           mroute_addr_print (&src, &gc));
+		    }
 		  c->c2.to_tun.len = 0;
 		}
 	      /* client-to-client communication enabled? */
-- 
1.8.3.2


