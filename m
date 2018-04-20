From: Antonio Quartulli <a@...2181...>
Date: Fri, 20 Apr 2018 19:16:23 +0800
Message-Id: <20180420111624.7230-8-a@...2181...>
In-Reply-To: <20180420111624.7230-1-a@...2181...>
References: <20180420111624.7230-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 7/8] route.c: use sitnl to implement
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
Cc: Antonio Quartulli <a@...2181...>

get_default_gateway_ipv6() has always been implemented using
netlink, however, now that we have sitnl, we can re-use the
latter and get rid of the netlink code from route.c.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/networking_ip.c |   2 +-
 src/openvpn/route.c         | 150 +++---------------------------------
 2 files changed, 12 insertions(+), 140 deletions(-)

diff --git a/src/openvpn/networking_ip.c b/src/openvpn/networking_ip.c
index 0f8a6cd3..7f27f375 100644
--- a/src/openvpn/networking_ip.c
+++ b/src/openvpn/networking_ip.c
@@ -358,7 +358,7 @@ net_route_v4_best_gw(const in_addr_t *dst, int prefixlen,
 
 /*
  * The following function is not implemented in the iproute backend as it
- * already uses netlink in route.c.
+ * uses the sitnl implementation from networking_sitnl.c.
  *
  * int
  * net_route_v6_best_gw(const struct in6_addr *dst, int prefixlen,
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 50aead73..be0228a9 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3277,150 +3277,28 @@ void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
                          const struct in6_addr *dest)
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
+    if (net_route_v6_best_gw(dest, 128, &rgi6->gateway.addr_ipv6,
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
+        if (rgi6->gateway.addr_ipv6.s6_addr)
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
@@ -3428,12 +3306,6 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
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
2.17.0


