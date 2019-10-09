From: Antonio Quartulli <a@...2181...>
Date: Wed,  9 Oct 2019 16:34:14 +0200
Message-Id: <20191009143422.9419-2-a@...2181...>
In-Reply-To: <20191009143422.9419-1-a@...2181...>
References: <20191009143422.9419-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/9] maddr: create helper function to
 populate maddr object from eth_addr
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/mroute.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index db8c9876..c52ef7b1 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -247,6 +247,16 @@ mroute_extract_addr_ip(struct mroute_addr *src, struct mroute_addr *dest,
     return ret;
 }
 
+static void
+mroute_copy_ether_to_addr(struct mroute_addr *maddr,
+                          const uint8_t *ether_addr)
+{
+    maddr->type = MR_ADDR_ETHER;
+    maddr->netbits = 0;
+    maddr->len = OPENVPN_ETH_ALEN;
+    memcpy(maddr->eth_addr, ether_addr, OPENVPN_ETH_ALEN);
+}
+
 unsigned int
 mroute_extract_addr_ether(struct mroute_addr *src,
                           struct mroute_addr *dest,
@@ -260,17 +270,11 @@ mroute_extract_addr_ether(struct mroute_addr *src,
         const struct openvpn_ethhdr *eth = (const struct openvpn_ethhdr *) BPTR(buf);
         if (src)
         {
-            src->type = MR_ADDR_ETHER;
-            src->netbits = 0;
-            src->len = 6;
-            memcpy(src->eth_addr, eth->source, sizeof(dest->eth_addr));
+            mroute_copy_ether_to_addr(src, eth->source);
         }
         if (dest)
         {
-            dest->type = MR_ADDR_ETHER;
-            dest->netbits = 0;
-            dest->len = 6;
-            memcpy(dest->eth_addr, eth->dest, sizeof(dest->eth_addr));
+            mroute_copy_ether_to_addr(dest, eth->dest);
 
             /* ethernet broadcast/multicast packet? */
             if (is_mac_mcast_addr(eth->dest))
-- 
2.23.0


