From: Ralf Lici <ralf@...2726...>
Date: Wed,  4 Jun 2025 15:11:58 +0200
Message-ID: <20250604131158.1417342-1-ralf@...2726...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: propagate socket mark
 to skb in UDP
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

openvpn implements the `--mark` option, which utilizes the `SO_MARK`
Linux socket option. However, in the UDP code path, the socket's
`sk_mark` value is not currently propagated to `skb` objects that pass
through our socket.

This commit ensures proper inheritance of the field by assigning
`sk_mark` to `skb->mark` before handing the `skb` to the network stack
for transmission.

Signed-off-by: Ralf Lici <ralf@...2726...>
---
 drivers/net/ovpn/udp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index b4fbebad8f45..4f9c9a9a889a 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -344,6 +344,7 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 	int ret;
 
 	skb->dev = peer->ovpn->dev;
+	skb->mark = READ_ONCE(sk->sk_mark);
 	/* no checksum performed at this layer */
 	skb->ip_summed = CHECKSUM_NONE;
 
-- 
2.49.0


