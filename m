From: Antonio Quartulli <a@...2181...>
Date: Mon, 17 Jun 2019 14:41:10 +0200
Message-Id: <20190617124110.30907-2-a@...2181...>
In-Reply-To: <20190617124110.30907-1-a@...2181...>
References: <20190617124110.30907-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] route.c: fix windows build by removing
 mismatching function parameter
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index c92a1343..4cdc4a9f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2799,7 +2799,7 @@ windows_route_find_if_index(const struct route_ipv4 *r, const struct tuntap *tt)
  */
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
-                         const struct in6_addr *dest, openvpn_net_ctx_t *ctx)
+                         const struct in6_addr *dest)
 {
     struct gc_arena gc = gc_new();
     MIB_IPFORWARD_ROW2 BestRoute;
-- 
2.22.0


