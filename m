From: Antonio Quartulli <a@...2181...>
Date: Wed, 30 Apr 2025 14:32:50 +0200
Message-ID: <20250430123250.8627-2-a@...2181...>
In-Reply-To: <20250430123250.8627-1-a@...2181...>
References: <20250430123250.8627-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH ovpn-net-next 2/2] ovpn: drop useless
 reg_state check in keepalive worker
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
Cc: Antonio Quartulli <antonio@...515...>, sd@...2891...

From: Antonio Quartulli <antonio@...515...>

The keepalive worker is cancelled before calling
unregister_netdevice_queue(), therefore it will never
hit a situation where the reg_state can be different
than NETDEV_REGISTERED.

For this reason, checking reg_state is useless and the
condition can be removed.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 drivers/net/ovpn/peer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a37f89fffb02..24eb9d81429e 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1353,8 +1353,7 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
 	}
 
 	/* prevent rearming if the interface is being destroyed */
-	if (next_run > 0 &&
-	    READ_ONCE(ovpn->dev->reg_state) == NETREG_REGISTERED) {
+	if (next_run > 0) {
 		netdev_dbg(ovpn->dev,
 			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
 			   next_run, now, next_run - now);
-- 
2.49.0


