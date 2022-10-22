From: John Thomson <git@...2701...>
Date: Sat, 22 Oct 2022 18:38:42 +1000
Message-Id: <20221022083842.4093941-1-git@...2701...>
In-Reply-To: <8f4f2e11-6418-58ac-0fd5-f9a19450102a@...2181...>
References: <8f4f2e11-6418-58ac-0fd5-f9a19450102a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] ovpn-dco: fix kernel 6.1 compile issue
 in ovpn_peer_create
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
To: openvpn-devel@lists.sourceforge.net, a@...2181...

Linux 5.19 replaces netif_tx_napi_add, but maintains a definition to the
new function in: 58caed3dacb4 ("netdev: reshuffle netif_napi_add() APIs
to allow dropping weigh") [0]

Linux 6.1 removes netif_tx_napi_add in c3f760ef1287 ("net: remove
netif_tx_napi_add()") [1]

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58caed3dacb4354a25a1aa8d2febc3e9648ba1f4
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c3f760ef128789252e7c4f10d3c1721422dceba9

Signed-off-by: John Thomson <git@...2701...>
---
v2: Do not throw ifdefs into the middle of the code

compile tested only: openwrt toolchain aarch64: kernel v6.1rc1, kernel 5.10
---
 drivers/net/ovpn-dco/peer.c | 2 +-
 linux-compat.h              | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn-dco/peer.c b/drivers/net/ovpn-dco/peer.c
index 5838286..8fc619c 100644
--- a/drivers/net/ovpn-dco/peer.c
+++ b/drivers/net/ovpn-dco/peer.c
@@ -88,7 +88,7 @@ static struct ovpn_peer *ovpn_peer_create(struct ovpn_struct *ovpn, u32 id)
 	}
 
 	/* configure and start NAPI */
-	netif_tx_napi_add(ovpn->dev, &peer->napi, ovpn_napi_poll,
+	netif_napi_add_tx_weight(ovpn->dev, &peer->napi, ovpn_napi_poll,
 			  NAPI_POLL_WEIGHT);
 	napi_enable(&peer->napi);
 
diff --git a/linux-compat.h b/linux-compat.h
index 3fb0208..b5af7e9 100644
--- a/linux-compat.h
+++ b/linux-compat.h
@@ -104,4 +104,12 @@ static inline void dev_sw_netstats_rx_add(struct net_device *dev, unsigned int l
 
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(5, 2, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 19, 0)
+/**
+ * commit 58caed3dacb4 renamed to netif_napi_add_tx_weight,
+ * commit c3f760ef1287 removed netif_tx_napi_add
+ */
+#define netif_napi_add_tx_weight netif_tx_napi_add
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(5, 19, 0) */
+
 #endif /* _NET_OVPN_DCO_LINUX_COMPAT_H_ */
-- 
2.37.2


