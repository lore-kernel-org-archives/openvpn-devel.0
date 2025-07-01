From: Ralf Lici <ralf@...2726...>
Date: Tue,  1 Jul 2025 14:47:44 +0200
Message-ID: <20250701124744.259472-1-ralf@...2726...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: reset GSO metadata
 after decapsulation
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

The ovpn_netdev_write() function is responsible for injecting
decapsulated and decrypted packets back into the local network stack.
Prior to this change, the skb could retain GSO metadata from the outer,
encrypted tunnel packet. This original GSO metadata, relevant to the
sender's context for the tunnel, becomes invalid and misleading for the
local receive path once the inner packet is exposed.

Leaving this stale metadata intact causes internal GSO validation checks
further down the kernel's network stack (validate_xmit_skb()) to fail,
leading to packet drops. The reasons for these failures vary by
protocol, for example:
- for ICMP, no offload handler is registered;
- for TCP and UDP, the respective offload handlers return errors when
  comparing skb->len to the outdated skb_shinfo(skb)->gso_size.

By calling skb_gso_reset(skb) we ensure the inner packet is presented to
gro_cells_receive() with a clean slate, correctly indicating it is an
individual packet from the perspective of the local stack.

This change eliminates the "Driver has suspect GRO implementation, TCP
performance may be compromised" warning and improves overall TCP
performance by allowing GSO/GRO to function as intended on the
decapsulated traffic. (Note: UDP GSO is not currently supported in ovpn)

Signed-off-by: Ralf Lici <ralf@...2726...>
---
 drivers/net/ovpn/io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ebf1e849506b..3e9e7f8444b3 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -62,6 +62,13 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	unsigned int pkt_len;
 	int ret;
 
+	/*
+	 * GSO state from the transport layer is not valid for the tunnel/data
+	 * path. Reset all GSO fields to prevent any further GSO processing
+	 * from entering an inconsistent state.
+	 */
+	skb_gso_reset(skb);
+
 	/* we can't guarantee the packet wasn't corrupted before entering the
 	 * VPN, therefore we give other layers a chance to check that
 	 */
-- 
2.50.0


