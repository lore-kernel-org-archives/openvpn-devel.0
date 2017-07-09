From: Antonio Quartulli <a@...2181...>
Date: Sun,  9 Jul 2017 10:27:39 +0800
Message-Id: <20170709022739.359-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] route: avoid definition of variable on
 unused platforms
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
 src/openvpn/route.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index a1811f41..349b2c76 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2133,7 +2133,9 @@ delete_route(struct route_ipv4 *r,
     struct argv argv = argv_new();
     const char *network;
     const char *netmask;
+#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     const char *gateway;
+#endif
     int is_local_route;
 
     if ((r->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
@@ -2145,7 +2147,9 @@ delete_route(struct route_ipv4 *r,
 
     network = print_in_addr_t(r->network, 0, &gc);
     netmask = print_in_addr_t(r->netmask, 0, &gc);
+#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     gateway = print_in_addr_t(r->gateway, 0, &gc);
+#endif
 
     is_local_route = local_route(r->network, r->netmask, r->gateway, rgi);
     if (is_local_route == LR_ERROR)
-- 
2.13.2


