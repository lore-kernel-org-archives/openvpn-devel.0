From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 31 Mar 2010 23:58:20 +0200
Message-Id: <af55818bf66513c1c21e025916a6b72e797474f9.1270060247.git.fabian.knittel@...1338...>
In-Reply-To: <cover.1270060247.git.fabian.knittel@...1338...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 7/9] vlan: Slightly enhance PF's protocol
	inspection of 802.1Q packets
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

To allow openvpn's PF code to inspect IP packets contained within 802.1Q
packets, this patch enhances mroute_extract_addr_ether() to properly
skip over the 802.1Q header.
---
 mroute.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/mroute.c b/mroute.c
index 1040b8f..4aa7bb4 100644
--- a/mroute.c
+++ b/mroute.c
@@ -205,7 +205,15 @@ mroute_extract_addr_ether (struct mroute_addr *src,
 	  struct buffer b = *buf;
 	  if (buf_advance (&b, sizeof (struct openvpn_ethhdr)))
 	    {
-	      switch (ntohs (eth->proto))
+	      uint16_t proto = ntohs (eth->proto);
+	      if (proto == OPENVPN_ETH_P_8021Q)
+		{
+		  const struct openvpn_8021qhdr *tag = (const struct openvpn_8021qhdr *) BPTR (buf);
+		  proto = ntohs (tag->proto);
+		  buf_advance (&b, SIZE_ETH_TO_8021Q_HDR);
+		}
+
+	      switch (proto)
 		{
 		case OPENVPN_ETH_P_IPV4:
 		  ret |= (mroute_extract_addr_ipv4 (esrc, edest, &b) << MROUTE_SEC_SHIFT);
-- 
1.7.0


