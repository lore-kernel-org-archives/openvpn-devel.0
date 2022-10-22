From: John Thomson <git@...2701...>
Date: Sat, 22 Oct 2022 16:16:19 +1000
Message-Id: <20221022061619.3923529-1-git@...2701...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] ovpn-dco: fix kernel 6.1 compile issue in
 ovpn_peer_create
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

Linux 5.19 replaces netif_tx_napi_add, but maintains a definition to the
new function in: 58caed3dacb4 ("netdev: reshuffle netif_napi_add() APIs
to allow dropping weigh") [0]

Linux 6.1 removes netif_tx_napi_add in c3f760ef1287 ("net: remove
netif_tx_napi_add()") [1]

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58caed3dacb4354a25a1aa8d2febc3e9648ba1f4
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c3f760ef128789252e7c4f10d3c1721422dceba9

Signed-off-by: John Thomson <git@...2701...>
---
compile test only, on kernel 6.1rc1
---
 drivers/net/ovpn-dco/peer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ovpn-dco/peer.c b/drivers/net/ovpn-dco/peer.c
index 5838286..c460976 100644
--- a/drivers/net/ovpn-dco/peer.c
+++ b/drivers/net/ovpn-dco/peer.c
@@ -88,8 +88,12 @@ static struct ovpn_peer *ovpn_peer_create(struct ovpn_struct *ovpn, u32 id)
 	}
 
 	/* configure and start NAPI */
+#if(LINUX_VERSION_CODE < KERNEL_VERSION(5,19,0))
 	netif_tx_napi_add(ovpn->dev, &peer->napi, ovpn_napi_poll,
 			  NAPI_POLL_WEIGHT);
+#else
+	netif_napi_add_tx(ovpn->dev, &peer->napi, ovpn_napi_poll);
+#endif
 	napi_enable(&peer->napi);
 
 	dev_hold(ovpn->dev);
-- 
2.37.2


