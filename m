From: Antonio Quartulli <a@...2181...>
Date: Wed, 16 Aug 2017 19:46:43 +0800
Message-Id: <20170816114643.1860-1-a@...2181...>
In-Reply-To: <20170816103120.13752-1-a@...2181...>
References: <20170816103120.13752-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v3] route: avoid definition of unused
 variables in certain configurations
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

Although this patch adds more ifdefs, this is an easy
fix towards a no-warning-build process.

A proper cleanup should be carried out later on route.c.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
v2:
- add commit message
- fix warning about another unused variable when --enable-iproute2 is selected
v3:
- don't write into (now) removed variables


 src/openvpn/route.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 1d8bb001..081cfec0 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1530,7 +1530,9 @@ add_route(struct route_ipv4 *r,
     struct gc_arena gc;
     struct argv argv = argv_new();
     const char *network;
+#ifndef ENABLE_IPROUTE
     const char *netmask;
+#endif
     const char *gateway;
     bool status = false;
     int is_local_route;
@@ -1543,7 +1545,9 @@ add_route(struct route_ipv4 *r,
     gc_init(&gc);
 
     network = print_in_addr_t(r->network, 0, &gc);
+#ifndef ENABLE_IPROUTE
     netmask = print_in_addr_t(r->netmask, 0, &gc);
+#endif
     gateway = print_in_addr_t(r->gateway, 0, &gc);
 
     is_local_route = local_route(r->network, r->netmask, r->gateway, rgi);
@@ -2132,8 +2136,12 @@ delete_route(struct route_ipv4 *r,
     struct gc_arena gc;
     struct argv argv = argv_new();
     const char *network;
+#ifndef ENABLE_IPROUTE
     const char *netmask;
+#endif
+#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     const char *gateway;
+#endif
     int is_local_route;
 
     if ((r->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
@@ -2144,8 +2152,12 @@ delete_route(struct route_ipv4 *r,
     gc_init(&gc);
 
     network = print_in_addr_t(r->network, 0, &gc);
+#ifndef ENABLE_IPROUTE
     netmask = print_in_addr_t(r->netmask, 0, &gc);
+#endif
+#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     gateway = print_in_addr_t(r->gateway, 0, &gc);
+#endif
 
     is_local_route = local_route(r->network, r->netmask, r->gateway, rgi);
     if (is_local_route == LR_ERROR)
-- 
2.14.0


