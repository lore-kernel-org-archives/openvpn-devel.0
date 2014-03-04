From: "Vladimir V. Kamarzin" <vvk@...1868...>
Date: Tue,  4 Mar 2014 16:37:29 +0600
Message-Id: <1393929449-423915-1-git-send-email-vvk@...1868...>
Subject: [Openvpn-devel] [PATCH] Extract MAC addresses from ARP packets
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

From: "Vladimir V. Kamarzin" <vvk@...1868...>

When working in TAP mode, openvpn at server side maintains mapping table
"MAC" -> "client". It needs to know what MAC belongs to what client to
be able to forward traffic.

Before this change extraction of MAC addresses was performed only from
ethernet headers of packets, coming from the client. This patch
introduces extraction from ARP packets.

Why extraction only from ethernet header may be not enought? Obviously
in such cases, when MAC in ethernet header differs from ARP message
"Sender Hardware Address" field. For example, one device (A) performs
handling of ARP traffic for other device (B) on the client side (C)
connected to server (S) via TAP (server bridge mode). Unless (B) send
some traffic to server-side network, it will be inaccessible because ARP
handling performed by (A) and not (B) itself.

Signed-off-by: Vladimir V. Kamarzin <vvk@...1868...>
---
 src/openvpn/mroute.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 850e336..608b432 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -226,7 +226,26 @@ mroute_extract_addr_ether (struct mroute_addr *src,
 	  src->type = MR_ADDR_ETHER;
 	  src->netbits = 0;
 	  src->len = 6;
-	  memcpy (src->addr, eth->source, 6);
+	  struct buffer b = *buf;
+	  if (buf_advance (&b, sizeof (struct openvpn_ethhdr)))
+	    {
+	      if (ntohs (eth->proto) == OPENVPN_ETH_P_ARP
+		  && BLEN (&b) >= (int) sizeof (struct openvpn_arp))
+		{
+		  const struct openvpn_arp *arp = (const struct openvpn_arp *) BPTR (&b);
+		  if (arp->mac_addr_type == htons(0x0001)
+		      && arp->proto_addr_type == htons(0x0800)
+		      && arp->mac_addr_size == 0x06
+		      && arp->proto_addr_size == 0x04)
+		    {
+		      memcpy (src->addr, arp->mac_src, 6);
+		    }
+		}
+	      else
+		{
+		  memcpy (src->addr, eth->source, 6);
+		}
+	    }
 	}
       if (dest)
 	{
-- 
1.8.3.2


