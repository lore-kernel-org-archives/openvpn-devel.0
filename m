From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  3 Feb 2023 20:14:37 +0100
Message-Id: <20230203191440.136050-3-frank@...2641...>
In-Reply-To: <20230203191440.136050-1-frank@...2641...>
References: <20230203191440.136050-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/5] Windows: fix unused variables in
 delete_route_ipv6
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

At this point it might be easier to create a
dedicated function for Windows...

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/route.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 82519c94..3798bc65 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2333,12 +2333,6 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
                   openvpn_net_ctx_t *ctx)
 {
     const char *network;
-#if !defined(TARGET_LINUX)
-    const char *gateway;
-#else
-    int metric;
-#endif
-    bool gateway_needed = false;
 
     if ((r6->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
     {
@@ -2346,19 +2340,34 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
     }
 
 #ifndef _WIN32
+#if !defined(TARGET_LINUX)
+    const char *gateway;
+#else
+    int metric;
+#endif
+    bool gateway_needed = false;
     const char *device = tt->actual_name;
     if (r6->iface != NULL)              /* vpn server special route */
     {
         device = r6->iface;
         gateway_needed = true;
     }
+
+    /* if we used a gateway on "add route", we also need to specify it on
+     * delete, otherwise some OSes will refuse to delete the route
+     */
+    if (tt->type == DEV_TYPE_TAP
+        && !( (r6->flags & RT_METRIC_DEFINED) && r6->metric == 0 ) )
+    {
+        gateway_needed = true;
+    }
 #endif
 
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
 
     network = print_in6_addr( r6->network, 0, &gc);
-#if !defined(TARGET_LINUX)
+#if !defined(TARGET_LINUX) && !defined(_WIN32)
     gateway = print_in6_addr( r6->gateway, 0, &gc);
 #endif
 
@@ -2382,15 +2391,6 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
 
     msg( M_INFO, "delete_route_ipv6(%s/%d)", network, r6->netbits );
 
-    /* if we used a gateway on "add route", we also need to specify it on
-     * delete, otherwise some OSes will refuse to delete the route
-     */
-    if (tt->type == DEV_TYPE_TAP
-        && !( (r6->flags & RT_METRIC_DEFINED) && r6->metric == 0 ) )
-    {
-        gateway_needed = true;
-    }
-
 #if defined(TARGET_LINUX)
     metric = -1;
     if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
-- 
2.34.1


