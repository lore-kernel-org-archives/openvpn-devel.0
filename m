From: Antonio Quartulli <a@...2181...>
Date: Sun,  1 Apr 2018 21:16:15 +0800
Message-Id: <20180401131615.12567-5-a@...2181...>
In-Reply-To: <20180401131615.12567-1-a@...2181...>
References: <20180401131615.12567-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 4/4] route.c: use sitnl to handle route
 configuration on Linux
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
 src/openvpn/route.c | 364 ++++++++++------------------------------------------
 1 file changed, 71 insertions(+), 293 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8990a986..4b398366 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -41,6 +41,7 @@
 #include "manage.h"
 #include "win32.h"
 #include "options.h"
+#include "sitnl.h"
 
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
-    }
-    if (is_on_link(is_local_route, flags, rgi))
-    {
-        argv_printf_cat(&argv, "dev %s", rgi->iface);
+        metric = r->metric;
     }
-    else
+
+    status = true;
+    if (sitnl_route_v4_add(&r->network, netmask_to_netbits2(r->netmask),
+                           &r->gateway, iface, 0, metric) < 0)
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
-    {
-        argv_printf_cat(&argv, "via %s", gateway);
-    }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
+    metric = -1;
+    if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
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
+    status = true;
+    if (sitnl_route_v6_add(&r6->network, r6->netbits,
+                           gateway_needed ? &r6->gateway : NULL, device, 0,
+                           metric) < 0)
     {
-        argv_printf_cat(&argv, "gw %s", gateway);
+        msg(M_WARN, "ERROR: Linux IPv6 route can't be added");
+        status = false;
     }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
-    {
-        argv_printf_cat(&argv, " metric %d", r6->metric);
-    }
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
+    if (sitnl_route_v4_del(&r->network, netmask_to_netbits2(r->netmask),
+                           &r->gateway, NULL, 0, metric) < 0)
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
-    {
-        argv_printf_cat(&argv, "via %s", gateway);
-    }
-#else  /* ifdef ENABLE_IPROUTE */
-    argv_printf(&argv, "%s -A inet6 del %s/%d dev %s",
-                ROUTE_PATH,
-                network,
-                r6->netbits,
-                device);
-    if (gateway_needed)
+    metric = -1;
+    if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
-        argv_printf_cat(&argv, "gw %s", gateway);
+        metric = r6->metric;
     }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
+
+    if (sitnl_route_v6_del(&r6->network, r6->netbits,
+                           gateway_needed ? &r6->gateway : NULL, device,
+                           0, metric) < 0)
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
+    if (sitnl_route_v4_best_gw(NULL, 0, &rgi->gateway.addr, best_name) == 0)
     {
-        FILE *fp = fopen("/proc/net/route", "r");
-        if (fp)
+        rgi->flags |= RGI_ADDR_DEFINED;
+        if (!rgi->gateway.addr && (strlen(best_name) > 0))
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
@@ -3371,150 +3277,28 @@ void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
                          const struct in6_addr *dest)
 {
-    int nls = -1;
-    struct rtreq rtreq;
-    struct rtattr *rta;
-
-    char rtbuf[2000];
-    ssize_t ssize;
-
-    CLEAR(*rgi6);
-
-    nls = socket( PF_NETLINK, SOCK_RAW, NETLINK_ROUTE );
-    if (nls < 0)
-    {
-        msg(M_WARN|M_ERRNO, "GDG6: socket() failed" ); goto done;
-    }
-
-    /* bind() is not needed, no unsolicited msgs coming in */
-
-    /* request best matching route, see netlink(7) for explanations
-     */
-    CLEAR(rtreq);
-    rtreq.nh.nlmsg_type = RTM_GETROUTE;
-    rtreq.nh.nlmsg_flags = NLM_F_REQUEST;       /* best match only */
-    rtreq.rtm.rtm_family = AF_INET6;
-    rtreq.rtm.rtm_src_len = 0;                  /* not source dependent */
-    rtreq.rtm.rtm_dst_len = 128;                /* exact dst */
-    rtreq.rtm.rtm_table = RT_TABLE_MAIN;
-    rtreq.rtm.rtm_protocol = RTPROT_UNSPEC;
-    rtreq.nh.nlmsg_len = NLMSG_SPACE(sizeof(rtreq.rtm));
-
-    /* set RTA_DST for target IPv6 address we want */
-    rta = (struct rtattr *)(((char *) &rtreq)+NLMSG_ALIGN(rtreq.nh.nlmsg_len));
-    rta->rta_type = RTA_DST;
-    rta->rta_len = RTA_LENGTH(16);
-    rtreq.nh.nlmsg_len = NLMSG_ALIGN(rtreq.nh.nlmsg_len)
-                         +RTA_LENGTH(16);
-
-    if (dest == NULL)                   /* ::, unspecified */
-    {
-        memset( RTA_DATA(rta), 0, 16 ); /* :: = all-zero */
-    }
-    else
-    {
-        memcpy( RTA_DATA(rta), (void *)dest, 16 );
-    }
+    struct in_addr gw;
+    int flags;
 
-    /* send and receive reply */
-    if (send( nls, &rtreq, rtreq.nh.nlmsg_len, 0 ) < 0)
-    {
-        msg(M_WARN|M_ERRNO, "GDG6: send() failed" ); goto done;
-    }
-
-    ssize = recv(nls, rtbuf, sizeof(rtbuf), MSG_TRUNC);
-
-    if (ssize < 0)
-    {
-        msg(M_WARN|M_ERRNO, "GDG6: recv() failed" ); goto done;
-    }
+    CLEAR(gw);
 
-    if (ssize > sizeof(rtbuf))
+    if (sitnl_route_v6_best_gw(dest, 128, &rgi6->gateway.addr_ipv6,
+                               rgi6->iface) == 0)
     {
-        msg(M_WARN, "get_default_gateway_ipv6: returned message too big for buffer (%d>%d)", (int)ssize, (int)sizeof(rtbuf) );
-        goto done;
-    }
-
-    struct nlmsghdr *nh;
-
-    for (nh = (struct nlmsghdr *)rtbuf;
-         NLMSG_OK(nh, ssize);
-         nh = NLMSG_NEXT(nh, ssize))
-    {
-        struct rtmsg *rtm;
-        int attrlen;
-
-        if (nh->nlmsg_type == NLMSG_DONE)
+        if (rgi6->gateway.addr_ipv6.s6_addr)
         {
-            break;
-        }
-
-        if (nh->nlmsg_type == NLMSG_ERROR)
-        {
-            struct nlmsgerr *ne = (struct nlmsgerr *)NLMSG_DATA(nh);
-
-            /* since linux-4.11 -ENETUNREACH is returned when no route can be
-             * found. Don't print any error message in this case */
-            if (ne->error != -ENETUNREACH)
-            {
-                msg(M_WARN, "GDG6: NLMSG_ERROR: error %s\n",
-                    strerror(-ne->error));
-            }
-            break;
+            rgi6->flags |= RGI_ADDR_DEFINED;
         }
 
-        if (nh->nlmsg_type != RTM_NEWROUTE)
+        if (rgi6->iface)
         {
-            /* shouldn't happen */
-            msg(M_WARN, "GDG6: unexpected msg_type %d", nh->nlmsg_type );
-            continue;
-        }
-
-        rtm = (struct rtmsg *)NLMSG_DATA(nh);
-        attrlen = RTM_PAYLOAD(nh);
-
-        /* we're only looking for routes in the main table, as "we have
-         * no IPv6" will lead to a lookup result in "Local" (::/0 reject)
-         */
-        if (rtm->rtm_family != AF_INET6
-            || rtm->rtm_table != RT_TABLE_MAIN)
-        {
-            continue;
-        }                               /* we're not interested */
-
-        for (rta = RTM_RTA(rtm);
-             RTA_OK(rta, attrlen);
-             rta = RTA_NEXT(rta, attrlen))
-        {
-            if (rta->rta_type == RTA_GATEWAY)
-            {
-                if (RTA_PAYLOAD(rta) != sizeof(struct in6_addr) )
-                {
-                    msg(M_WARN, "GDG6: RTA_GW size mismatch"); continue;
-                }
-                rgi6->gateway.addr_ipv6 = *(struct in6_addr *) RTA_DATA(rta);
-                rgi6->flags |= RGI_ADDR_DEFINED;
-            }
-            else if (rta->rta_type == RTA_OIF)
-            {
-                char ifname[IF_NAMESIZE+1];
-                int oif;
-                if (RTA_PAYLOAD(rta) != sizeof(oif) )
-                {
-                    msg(M_WARN, "GDG6: oif size mismatch"); continue;
-                }
-
-                memcpy(&oif, RTA_DATA(rta), sizeof(oif));
-                if_indextoname(oif,ifname);
-                strncpy( rgi6->iface, ifname, sizeof(rgi6->iface)-1 );
-                rgi6->flags |= RGI_IFACE_DEFINED;
-            }
+            rgi6->flags |= RGI_IFACE_DEFINED;
         }
     }
 
     /* if we have an interface but no gateway, the destination is on-link */
-    if ( ( rgi6->flags & (RGI_IFACE_DEFINED|RGI_ADDR_DEFINED) ) ==
-         RGI_IFACE_DEFINED)
+    flags = rgi6->flags & (RGI_IFACE_DEFINED | RGI_ADDR_DEFINED);
+    if (flags == RGI_IFACE_DEFINED)
     {
         rgi6->flags |= (RGI_ADDR_DEFINED | RGI_ON_LINK);
         if (dest)
@@ -3522,12 +3306,6 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
             rgi6->gateway.addr_ipv6 = *dest;
         }
     }
-
-done:
-    if (nls >= 0)
-    {
-        close(nls);
-    }
 }
 
 #elif defined(TARGET_DARWIN) || defined(TARGET_SOLARIS)    \
-- 
2.16.3


