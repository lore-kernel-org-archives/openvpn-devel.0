From: Antonio Quartulli <a@...2181...>
Date: Fri, 20 Apr 2018 19:16:20 +0800
Message-Id: <20180420111624.7230-5-a@...2181...>
In-Reply-To: <20180420111624.7230-1-a@...2181...>
References: <20180420111624.7230-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 4/8] route.c: use new networking API to
 handle routing table on Linux
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

By switching to the networking API (for Linux) openvpn will
now use any of the available implementations to handle the
routing table.

At the moment only iproute2 is implemented.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/networking_ip.c |   1 -
 src/openvpn/route.c         | 214 ++++++++++--------------------------
 2 files changed, 60 insertions(+), 155 deletions(-)

diff --git a/src/openvpn/networking_ip.c b/src/openvpn/networking_ip.c
index bfe7b459..0f8a6cd3 100644
--- a/src/openvpn/networking_ip.c
+++ b/src/openvpn/networking_ip.c
@@ -29,7 +29,6 @@
 #include "syshead.h"
 
 #include "networking.h"
-#include "networking_ip.h"
 #include "misc.h"
 #include "socket.h"
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8990a986..50aead73 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -41,6 +41,7 @@
 #include "manage.h"
 #include "win32.h"
 #include "options.h"
+#include "networking.h"
 
 #include "memdbg.h"
 
@@ -1529,13 +1530,17 @@ add_route(struct route_ipv4 *r,
 {
     struct gc_arena gc;
     struct argv argv = argv_new();
+#if !defined(TARGET_LINUX)
     const char *network;
 #if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
     const char *netmask;
 #endif
     const char *gateway;
+#endif
+    const char *iface;
     bool status = false;
     int is_local_route;
+    int metric;
 
     if (!(r->flags & RT_DEFINED))
     {
@@ -1544,11 +1549,13 @@ add_route(struct route_ipv4 *r,
 
     gc_init(&gc);
 
+#if !defined(TARGET_LINUX)
     network = print_in_addr_t(r->network, 0, &gc);
 #if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
     netmask = print_in_addr_t(r->netmask, 0, &gc);
 #endif
     gateway = print_in_addr_t(r->gateway, 0, &gc);
+#endif
 
     is_local_route = local_route(r->network, r->netmask, r->gateway, rgi);
     if (is_local_route == LR_ERROR)
@@ -1557,47 +1564,26 @@ add_route(struct route_ipv4 *r,
     }
 
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s route add %s/%d",
-                iproute_path,
-                network,
-                netmask_to_netbits2(r->netmask));
-
-    if (r->flags & RT_METRIC_DEFINED)
-    {
-        argv_printf_cat(&argv, "metric %d", r->metric);
-    }
-
+    iface = NULL;
     if (is_on_link(is_local_route, flags, rgi))
     {
-        argv_printf_cat(&argv, "dev %s", rgi->iface);
+        iface = rgi->iface;
     }
-    else
-    {
-        argv_printf_cat(&argv, "via %s", gateway);
-    }
-#else  /* ifdef ENABLE_IPROUTE */
-    argv_printf(&argv, "%s add -net %s netmask %s",
-                ROUTE_PATH,
-                network,
-                netmask);
+
+    metric = -1;
     if (r->flags & RT_METRIC_DEFINED)
     {
-        argv_printf_cat(&argv, "metric %d", r->metric);
+        metric = r->metric;
     }
-    if (is_on_link(is_local_route, flags, rgi))
-    {
-        argv_printf_cat(&argv, "dev %s", rgi->iface);
-    }
-    else
+
+    status = true;
+    if (net_route_v4_add(&r->network, netmask_to_netbits2(r->netmask),
+                         &r->gateway, iface, 0, metric) < 0)
     {
-        argv_printf_cat(&argv, "gw %s", gateway);
+        msg(M_WARN, "ERROR: Linux route add command failed");
+        status = false;
     }
 
-#endif  /*ENABLE_IPROUTE*/
-    argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: Linux route add command failed");
-
 #elif defined (TARGET_ANDROID)
     char out[128];
 
@@ -1853,7 +1839,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     const char *gateway;
     bool status = false;
     const char *device = tt->actual_name;
-
+    int metric;
     bool gateway_needed = false;
 
     if (!(r6->flags & RT_DEFINED) )
@@ -1918,38 +1904,20 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     }
 
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s -6 route add %s/%d dev %s",
-                iproute_path,
-                network,
-                r6->netbits,
-                device);
-    if (gateway_needed)
+    metric = -1;
+    if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
-        argv_printf_cat(&argv, "via %s", gateway);
-    }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
-    {
-        argv_printf_cat(&argv, " metric %d", r6->metric);
+        metric = r6->metric;
     }
 
-#else  /* ifdef ENABLE_IPROUTE */
-    argv_printf(&argv, "%s -A inet6 add %s/%d dev %s",
-                ROUTE_PATH,
-                network,
-                r6->netbits,
-                device);
-    if (gateway_needed)
-    {
-        argv_printf_cat(&argv, "gw %s", gateway);
-    }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
+    status = true;
+    if (net_route_v6_add(&r6->network, r6->netbits,
+                         gateway_needed ? &r6->gateway : NULL, device, 0,
+                         metric) < 0)
     {
-        argv_printf_cat(&argv, " metric %d", r6->metric);
+        msg(M_WARN, "ERROR: Linux IPv6 route can't be added");
+        status = false;
     }
-#endif  /*ENABLE_IPROUTE*/
-    argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: Linux route -6/-A inet6 add command failed");
 
 #elif defined (TARGET_ANDROID)
     char out[64];
@@ -2135,6 +2103,7 @@ delete_route(struct route_ipv4 *r,
 {
     struct gc_arena gc;
     struct argv argv = argv_new();
+#if !defined(TARGET_LINUX)
     const char *network;
 #if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
     const char *netmask;
@@ -2142,7 +2111,8 @@ delete_route(struct route_ipv4 *r,
 #if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     const char *gateway;
 #endif
-    int is_local_route;
+#endif
+    int is_local_route, metric;
 
     if ((r->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
     {
@@ -2151,12 +2121,14 @@ delete_route(struct route_ipv4 *r,
 
     gc_init(&gc);
 
+#if !defined(TARGET_LINUX)
     network = print_in_addr_t(r->network, 0, &gc);
 #if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
     netmask = print_in_addr_t(r->netmask, 0, &gc);
 #endif
 #if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     gateway = print_in_addr_t(r->gateway, 0, &gc);
+#endif
 #endif
 
     is_local_route = local_route(r->network, r->netmask, r->gateway, rgi);
@@ -2166,23 +2138,17 @@ delete_route(struct route_ipv4 *r,
     }
 
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s route del %s/%d",
-                iproute_path,
-                network,
-                netmask_to_netbits2(r->netmask));
-#else
-    argv_printf(&argv, "%s del -net %s netmask %s",
-                ROUTE_PATH,
-                network,
-                netmask);
-#endif /*ENABLE_IPROUTE*/
+    metric = -1;
     if (r->flags & RT_METRIC_DEFINED)
     {
-        argv_printf_cat(&argv, "metric %d", r->metric);
+        metric = r->metric;
+    }
+
+    if (net_route_v4_del(&r->network, netmask_to_netbits2(r->netmask),
+                         &r->gateway, NULL, 0, metric) < 0)
+    {
+        msg(M_WARN, "ERROR: Linux route delete command failed");
     }
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: Linux route delete command failed");
 
 #elif defined (_WIN32)
 
@@ -2324,9 +2290,12 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
     struct gc_arena gc;
     struct argv argv = argv_new();
     const char *network;
+#if !defined(TARGET_LINUX)
     const char *gateway;
+#endif
     const char *device = tt->actual_name;
     bool gateway_needed = false;
+    int metric;
 
     if ((r6->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
     {
@@ -2344,7 +2313,9 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
     gc_init(&gc);
 
     network = print_in6_addr( r6->network, 0, &gc);
+#if !defined(TARGET_LINUX)
     gateway = print_in6_addr( r6->gateway, 0, &gc);
+#endif
 
 #if defined(TARGET_DARWIN)    \
     || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
@@ -2375,35 +2346,19 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
         gateway_needed = true;
     }
 
-
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s -6 route del %s/%d dev %s",
-                iproute_path,
-                network,
-                r6->netbits,
-                device);
-    if (gateway_needed)
+    metric = -1;
+    if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
-        argv_printf_cat(&argv, "via %s", gateway);
+        metric = r6->metric;
     }
-#else  /* ifdef ENABLE_IPROUTE */
-    argv_printf(&argv, "%s -A inet6 del %s/%d dev %s",
-                ROUTE_PATH,
-                network,
-                r6->netbits,
-                device);
-    if (gateway_needed)
-    {
-        argv_printf_cat(&argv, "gw %s", gateway);
-    }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
+
+    if (net_route_v6_del(&r6->network, r6->netbits,
+                         gateway_needed ? &r6->gateway : NULL, device, 0,
+                         metric) < 0)
     {
-        argv_printf_cat(&argv, " metric %d", r6->metric);
+        msg(M_WARN, "ERROR: Linux route v6 delete command failed");
     }
-#endif  /*ENABLE_IPROUTE*/
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: Linux route -6/-A inet6 del command failed");
 
 #elif defined (_WIN32)
 
@@ -3167,68 +3122,19 @@ get_default_gateway(struct route_gateway_info *rgi)
 {
     struct gc_arena gc = gc_new();
     int sd = -1;
-    char best_name[16];
-    best_name[0] = 0;
+    char best_name[IFNAMSIZ];
 
     CLEAR(*rgi);
+    CLEAR(best_name);
 
 #ifndef TARGET_ANDROID
     /* get default gateway IP addr */
+    if (net_route_v4_best_gw(NULL, 0, &rgi->gateway.addr, best_name) == 0)
     {
-        FILE *fp = fopen("/proc/net/route", "r");
-        if (fp)
+        rgi->flags |= RGI_ADDR_DEFINED;
+        if (!rgi->gateway.addr && best_name[0])
         {
-            char line[256];
-            int count = 0;
-            unsigned int lowest_metric = UINT_MAX;
-            in_addr_t best_gw = 0;
-            bool found = false;
-            while (fgets(line, sizeof(line), fp) != NULL)
-            {
-                if (count)
-                {
-                    unsigned int net_x = 0;
-                    unsigned int mask_x = 0;
-                    unsigned int gw_x = 0;
-                    unsigned int metric = 0;
-                    unsigned int flags = 0;
-                    char name[16];
-                    name[0] = 0;
-                    const int np = sscanf(line, "%15s\t%x\t%x\t%x\t%*s\t%*s\t%d\t%x",
-                                          name,
-                                          &net_x,
-                                          &gw_x,
-                                          &flags,
-                                          &metric,
-                                          &mask_x);
-                    if (np == 6 && (flags & IFF_UP))
-                    {
-                        const in_addr_t net = ntohl(net_x);
-                        const in_addr_t mask = ntohl(mask_x);
-                        const in_addr_t gw = ntohl(gw_x);
-
-                        if (!net && !mask && metric < lowest_metric)
-                        {
-                            found = true;
-                            best_gw = gw;
-                            strcpy(best_name, name);
-                            lowest_metric = metric;
-                        }
-                    }
-                }
-                ++count;
-            }
-            fclose(fp);
-
-            if (found)
-            {
-                rgi->gateway.addr = best_gw;
-                rgi->flags |= RGI_ADDR_DEFINED;
-                if (!rgi->gateway.addr && best_name[0])
-                {
-                    rgi->flags |= RGI_ON_LINK;
-                }
-            }
+            rgi->flags |= RGI_ON_LINK;
         }
     }
 #else  /* ifndef TARGET_ANDROID */
-- 
2.17.0


