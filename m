From: Dmitrij Tejblum <dt@...1411...>
Date: Sat,  8 Feb 2014 19:33:49 +0400
Message-Id: <1391873629-14388-1-git-send-email-dt@...1411...>
Subject: [Openvpn-devel] [PATCH] Fix is_ipv6 in case of tap interface.
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

While checking a packet on a TAP interface, is_ipv_X() in proto.c
insist that the ethertype must be OPENVPN_ETH_P_IPV4, even if
the protocol is IPv6. So the protocol never match, and, thus,
mssfix doesn't work for IPv6 on TAP interface. Fix that.

Signed-off-by: Dmitrij Tejblum <dt@...1411...>
---
 src/openvpn/proto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index b437f1a..7b58e6a 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -60,7 +60,7 @@ is_ipv_X ( int tunnel_type, struct buffer *buf, int ip_ver )
 	  + sizeof (struct openvpn_iphdr)))
 	return false;
       eh = (const struct openvpn_ethhdr *) BPTR (buf);
-      if (ntohs (eh->proto) != OPENVPN_ETH_P_IPV4)
+      if (ntohs (eh->proto) != (ip_ver == 6 ? OPENVPN_ETH_P_IPV6 : OPENVPN_ETH_P_IPV4))
 	return false;
       offset = sizeof (struct openvpn_ethhdr);
     }
-- 
1.8.3.4 (Apple Git-47)


