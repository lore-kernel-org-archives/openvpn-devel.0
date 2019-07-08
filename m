From: Antonio Quartulli <a@...2181...>
Date: Tue,  9 Jul 2019 00:48:06 +0200
Message-Id: <20190708224806.19887-1-a@...2181...>
In-Reply-To: <201906051034.x55AYdRT080096@...2054...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] route.c: use sitnl to implement
 get_default_gateway_ipv6()
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

get_default_gateway_ipv6() has always been implemented using
netlink, however, now that we have sitnl, we can re-use the
latter and get rid of the netlink code from route.c.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---

Changes from v1:
- use IN6_IS_ADDR_UNSPECIFIED to check if GW address is specified. This fixes
  the issue of never setting the ON_LINK flag for IPv6 routes


 src/openvpn/init.c                |   9 +-
 src/openvpn/networking_iproute2.c |   2 +-
 src/openvpn/options.c             |   2 +-
 src/openvpn/route.c               | 163 ++++--------------------------
 src/openvpn/route.h               |   7 +-
 5 files changed, 31 insertions(+), 152 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 87976290..5ccf4d9d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1486,7 +1486,8 @@ static void
 do_init_route_ipv6_list(const struct options *options,
                         struct route_ipv6_list *route_ipv6_list,
                         const struct link_socket_info *link_socket_info,
-                        struct env_set *es)
+                        struct env_set *es,
+                        openvpn_net_ctx_t *ctx)
 {
     const char *gw = NULL;
     int metric = -1;            /* no metric set */
@@ -1522,7 +1523,8 @@ do_init_route_ipv6_list(const struct options *options,
                              gw,
                              metric,
                              link_socket_current_remote_ipv6(link_socket_info),
-                             es))
+                             es,
+                             ctx))
     {
         /* copy routes to environment */
         setenv_routes_ipv6(es, route_ipv6_list);
@@ -1782,7 +1784,8 @@ do_open_tun(struct context *c)
     if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
     {
         do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list,
-                                &c->c2.link_socket->info, c->c2.es);
+                                &c->c2.link_socket->info, c->c2.es,
+                                &c->net_ctx);
     }
 
     /* do ifconfig */
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 918d62ef..a5824306 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -375,7 +375,7 @@ net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
 
 /*
  * The following function is not implemented in the iproute backend as it
- * already uses netlink in route.c.
+ * uses the sitnl implementation from networking_sitnl.c.
  *
  * int
  * net_route_v6_best_gw(const struct in6_addr *dst, int prefixlen,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a37b7146..2d3865a6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5012,7 +5012,7 @@ add_option(struct options *options,
         }
         net_ctx_init(NULL, &net_ctx);
         get_default_gateway(&rgi, &net_ctx);
-        get_default_gateway_ipv6(&rgi6, &remote);
+        get_default_gateway_ipv6(&rgi6, &remote, &net_ctx);
         print_default_gateway(M_INFO, &rgi, &rgi6);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 4cdc4a9f..a9071dff 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -765,7 +765,8 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
                      const char *remote_endpoint,
                      int default_metric,
                      const struct in6_addr *remote_host_ipv6,
-                     struct env_set *es)
+                     struct env_set *es,
+                     openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     bool ret = true;
@@ -790,7 +791,7 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
     msg(D_ROUTE, "GDG6: remote_host_ipv6=%s",
         remote_host_ipv6 ?  print_in6_addr(*remote_host_ipv6, 0, &gc) : "n/a" );
 
-    get_default_gateway_ipv6(&rl6->rgi6, remote_host_ipv6);
+    get_default_gateway_ipv6(&rl6->rgi6, remote_host_ipv6, ctx);
     if (rl6->rgi6.flags & RGI_ADDR_DEFINED)
     {
         setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->rgi6.gateway.addr_ipv6, 0, &gc));
@@ -2799,7 +2800,7 @@ windows_route_find_if_index(const struct route_ipv4 *r, const struct tuntap *tt)
  */
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
-                         const struct in6_addr *dest)
+                         const struct in6_addr *dest, openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     MIB_IPFORWARD_ROW2 BestRoute;
@@ -3323,152 +3324,30 @@ struct rtreq {
 
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
-                         const struct in6_addr *dest)
+                         const struct in6_addr *dest, openvpn_net_ctx_t *ctx)
 {
-    int nls = -1;
-    struct rtreq rtreq;
-    struct rtattr *rta;
+    struct in_addr gw;
+    int flags;
 
-    char rtbuf[2000];
-    ssize_t ssize;
+    CLEAR(gw);
 
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
-
-    /* send and receive reply */
-    if (send( nls, &rtreq, rtreq.nh.nlmsg_len, 0 ) < 0)
-    {
-        msg(M_WARN|M_ERRNO, "GDG6: send() failed" ); goto done;
-    }
-
-    ssize = recv(nls, rtbuf, sizeof(rtbuf), MSG_TRUNC);
-
-    if (ssize < 0)
+    if (net_route_v6_best_gw(ctx, dest, 0, &rgi6->gateway.addr_ipv6,
+                             rgi6->iface) == 0)
     {
-        msg(M_WARN|M_ERRNO, "GDG6: recv() failed" ); goto done;
-    }
-
-    if (ssize > sizeof(rtbuf))
-    {
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
-        {
-            break;
-        }
-
-        if (nh->nlmsg_type == NLMSG_ERROR)
+        if (!IN6_IS_ADDR_UNSPECIFIED(rgi6->gateway.addr_ipv6.s6_addr))
         {
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
@@ -3476,12 +3355,6 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
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
@@ -3758,7 +3631,7 @@ done:
 
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
-                         const struct in6_addr *dest)
+                         const struct in6_addr *dest, openvpn_net_ctx_t *ctx)
 {
 
     struct rtmsg m_rtmsg;
@@ -3944,7 +3817,7 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
 }
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
-                         const struct in6_addr *dest)
+                         const struct in6_addr *dest, openvpn_net_ctx_t *ctx)
 {
     msg(D_ROUTE, "no support for get_default_gateway_ipv6() on this system");
     CLEAR(*rgi6);
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index e552e6ec..31d38e36 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -31,6 +31,7 @@
 #include "basic.h"
 #include "tun.h"
 #include "misc.h"
+#include "networking.h"
 
 #ifdef _WIN32
 /*
@@ -291,7 +292,8 @@ bool init_route_ipv6_list(struct route_ipv6_list *rl6,
                           const char *remote_endpoint,
                           int default_metric,
                           const struct in6_addr *remote_host,
-                          struct env_set *es);
+                          struct env_set *es,
+                          openvpn_net_ctx_t *ctx);
 
 void route_list_add_vpn_gateway(struct route_list *rl,
                                 struct env_set *es,
@@ -323,7 +325,8 @@ void get_default_gateway(struct route_gateway_info *rgi,
                          openvpn_net_ctx_t *ctx);
 
 void get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi,
-                              const struct in6_addr *dest);
+                              const struct in6_addr *dest,
+                              openvpn_net_ctx_t *ctx);
 
 void print_default_gateway(const int msglevel,
                            const struct route_gateway_info *rgi,
-- 
2.22.0


