From: Antonio Quartulli <a@...2181...>
Date: Sat, 21 Jan 2017 21:01:50 +0800
Message-Id: <20170121130150.11687-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] fix "redirect-gateway autolocal" behaviour
	when no def route exists
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

When no default route exists the autolocal detection breaks and
therefore the redirect-gateway mechanism can't work as expected.

This should not happen, because the remote host may actually be
within the client network and therefore the autolocal mechanism
should happily detect it.

The misbehaviour is given by the test_local_addr() which
tries to match the remote host against the routes installed on
the same interface as the default GW. However, when no default GW
is there the entire mechanism fails.

Re-implement test_local_addr() with a proper routing table
lookup performed via netlink (applied to linux and android only).

The aforementioned check has been implemented by generalizing and
re-using the code in get_default_gateway_ipv6().

Signed-off-by: Antonio Quartulli <a@...2181...>
---

This patch has been tested on linux only.

If I am not wrong, I see that get_default_gateway() uses netlink
also on solaris and other systems. Does it mean that we can
re-implement test_local_addr() with netlink also on those systems?
Anybody with experience on non-linux systems can share some thoughts?


Thanks!


Cheers,


 src/openvpn/route.c | 232 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 159 insertions(+), 73 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index e23f79a..e5f73fb 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -648,7 +648,8 @@ init_route_list(struct route_list *rl,
         dmsg(D_ROUTE, "ROUTE: default_gateway=UNDEF");
     }
 
-    if (rl->spec.flags & RTSA_REMOTE_HOST)
+    if ((rl->spec.flags & RTSA_REMOTE_HOST)
+        && (remote_host != IPV4_INVALID_ADDR))
     {
         rl->spec.remote_host_local = test_local_addr(remote_host, &rl->rgi);
     }
@@ -980,7 +981,8 @@ del_bypass_routes(struct route_bypass *rb,
 }
 
 static void
-redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
+                              unsigned int flags, const struct env_set *es)
 {
     const char err[] = "NOTE: unable to redirect default gateway --";
 
@@ -988,6 +990,27 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
     {
         bool local = rl->flags & RG_LOCAL;
 
+#ifndef TARGET_ANDROID
+        /*
+         * if autolocal is enabled, try to determine it now (before doing the
+         * default GW existence check)
+         */
+        if (rl->flags & RG_AUTO_LOCAL)
+        {
+            const int tla = rl->spec.remote_host_local;
+            if (tla == TLA_NONLOCAL)
+            {
+                dmsg(D_ROUTE, "ROUTE remote_host is NOT LOCAL");
+                local = false;
+            }
+            else if (tla == TLA_LOCAL)
+            {
+                dmsg(D_ROUTE, "ROUTE remote_host is LOCAL");
+                local = true;
+            }
+        }
+#endif
+
         if (!(rl->spec.flags & RTSA_REMOTE_ENDPOINT) && (rl->flags & RG_REROUTE_GW))
         {
             msg(M_WARN, "%s VPN gateway parameter (--route-gateway or --ifconfig) is missing", err);
@@ -1009,20 +1032,6 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
         else
         {
 #ifndef TARGET_ANDROID
-            if (rl->flags & RG_AUTO_LOCAL)
-            {
-                const int tla = rl->spec.remote_host_local;
-                if (tla == TLA_NONLOCAL)
-                {
-                    dmsg(D_ROUTE, "ROUTE remote_host is NOT LOCAL");
-                    local = false;
-                }
-                else if (tla == TLA_LOCAL)
-                {
-                    dmsg(D_ROUTE, "ROUTE remote_host is LOCAL");
-                    local = true;
-                }
-            }
             if (!local)
             {
                 /* route remote host to original default gateway */
@@ -3333,7 +3342,7 @@ done:
     gc_free(&gc);
 }
 
-/* IPv6 implementation using netlink
+/* Implementation using netlink
  * http://www.linuxjournal.com/article/7356
  * netlink(3), netlink(7), rtnetlink(7)
  * http://www.virtualbox.org/svn/vbox/trunk/src/VBox/NetworkServices/NAT/rtmon_linux.c
@@ -3344,23 +3353,52 @@ struct rtreq {
     char attrbuf[512];
 };
 
-void
-get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
-                         const struct in6_addr *dest)
+/**
+ * Attempt to extract the route for the specified destination from the main
+ * routing table. This routine is generic and works with both IPv4 and IPv6.
+ *
+ * @param dest      A pointer to the destination address
+ * @param gw        The location where the nexthop resulting from the route has
+ *                  to be stored (can be NULL)
+ * @param iface     The location where the outgoing interface resulting from
+ *                  the route has to be stored (can be NULL)
+ * @param family    The address family. This is used to compute the address
+ *                  length. AF_INET and AF_INET6 are the only supported values
+ *
+ * @return          A bitmap with RGI_IFACE_DEFINED and RGI_ADDR_DEFINED set
+ *                  if an outgoing interface and a nexthop were respectively
+ *                  found for the specified destination address. 0 if no route
+ *                  could be found.
+ */
+static int
+route_get(const void *dest, void *gw, void *iface, sa_family_t family)
 {
-    int nls = -1;
+    ssize_t ssize, addr_size;
+    int nls, flags = 0;
     struct rtreq rtreq;
     struct rtattr *rta;
+    char rtbuf[2000], addr_str[1000];
 
-    char rtbuf[2000];
-    ssize_t ssize;
+    switch (family)
+    {
+        case AF_INET:
+            addr_size = sizeof(struct in_addr);
+            break;
+        case AF_INET6:
+            addr_size = sizeof(struct in6_addr);
+            break;
+        default:
+            msg(M_WARN, "RTNL: unexpected AF family: %d", family);
+            return 0;
+    }
 
-    CLEAR(*rgi6);
+    msg(M_WARN, "route_get: %s", inet_ntop(family, dest, addr_str, 1000));
 
     nls = socket( PF_NETLINK, SOCK_RAW, NETLINK_ROUTE );
     if (nls < 0)
     {
-        msg(M_WARN|M_ERRNO, "GDG6: socket() failed" ); goto done;
+        msg(M_WARN | M_ERRNO, "RTNL: socket() failed" );
+        return 0;
     }
 
     /* bind() is not needed, no unsolicited msgs coming in */
@@ -3370,52 +3408,53 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
     CLEAR(rtreq);
     rtreq.nh.nlmsg_type = RTM_GETROUTE;
     rtreq.nh.nlmsg_flags = NLM_F_REQUEST;       /* best match only */
-    rtreq.rtm.rtm_family = AF_INET6;
+    rtreq.rtm.rtm_family = family;
     rtreq.rtm.rtm_src_len = 0;                  /* not source dependent */
-    rtreq.rtm.rtm_dst_len = 128;                /* exact dst */
+    rtreq.rtm.rtm_dst_len = addr_size * 8;      /* exact dst */
     rtreq.rtm.rtm_table = RT_TABLE_MAIN;
     rtreq.rtm.rtm_protocol = RTPROT_UNSPEC;
     rtreq.nh.nlmsg_len = NLMSG_SPACE(sizeof(rtreq.rtm));
 
-    /* set RTA_DST for target IPv6 address we want */
-    rta = (struct rtattr *)(((char *) &rtreq)+NLMSG_ALIGN(rtreq.nh.nlmsg_len));
+    /* set RTA_DST for target address we want */
+    rta = (struct rtattr *)(((char *)&rtreq) + NLMSG_ALIGN(rtreq.nh.nlmsg_len));
     rta->rta_type = RTA_DST;
-    rta->rta_len = RTA_LENGTH(16);
-    rtreq.nh.nlmsg_len = NLMSG_ALIGN(rtreq.nh.nlmsg_len)
-                         +RTA_LENGTH(16);
+    rta->rta_len = RTA_LENGTH(addr_size);
+    rtreq.nh.nlmsg_len = NLMSG_ALIGN(rtreq.nh.nlmsg_len) +
+                         RTA_LENGTH(addr_size);
 
-    if (dest == NULL)                   /* ::, unspecified */
+    if (dest == NULL) /* get default route */
     {
-        memset( RTA_DATA(rta), 0, 16 ); /* :: = all-zero */
+        memset(RTA_DATA(rta), 0, addr_size);
     }
     else
     {
-        memcpy( RTA_DATA(rta), (void *)dest, 16 );
+        memcpy(RTA_DATA(rta), dest, addr_size);
     }
 
     /* send and receive reply */
-    if (send( nls, &rtreq, rtreq.nh.nlmsg_len, 0 ) < 0)
+    if (send(nls, &rtreq, rtreq.nh.nlmsg_len, 0) < 0)
     {
-        msg(M_WARN|M_ERRNO, "GDG6: send() failed" ); goto done;
+        msg(M_WARN | M_ERRNO, "RTNL: send() failed" );
+        goto done;
     }
 
     ssize = recv(nls, rtbuf, sizeof(rtbuf), MSG_TRUNC);
-
     if (ssize < 0)
     {
-        msg(M_WARN|M_ERRNO, "GDG6: recv() failed" ); goto done;
+        msg(M_WARN | M_ERRNO, "GDG6: recv() failed" );
+        goto done;
     }
 
     if (ssize > sizeof(rtbuf))
     {
-        msg(M_WARN, "get_default_gateway_ipv6: returned message too big for buffer (%d>%d)", (int)ssize, (int)sizeof(rtbuf) );
+        msg(M_WARN, "RTNL: returned message too big for buffer (%zd>%zd)",
+            ssize, sizeof(rtbuf) );
         goto done;
     }
 
     struct nlmsghdr *nh;
 
-    for (nh = (struct nlmsghdr *)rtbuf;
-         NLMSG_OK(nh, ssize);
+    for (nh = (struct nlmsghdr *)rtbuf; NLMSG_OK(nh, ssize);
          nh = NLMSG_NEXT(nh, ssize))
     {
         struct rtmsg *rtm;
@@ -3429,62 +3468,85 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
         if (nh->nlmsg_type == NLMSG_ERROR)
         {
             struct nlmsgerr *ne = (struct nlmsgerr *)NLMSG_DATA(nh);
-            msg(M_WARN, "GDG6: NLSMG_ERROR: error %d\n", ne->error);
+            msg(M_WARN, "RTNL: NLSMG_ERROR: error %s", strerror(-ne->error));
             break;
         }
 
         if (nh->nlmsg_type != RTM_NEWROUTE)
         {
             /* shouldn't happen */
-            msg(M_WARN, "GDG6: unexpected msg_type %d", nh->nlmsg_type );
+            msg(M_WARN, "RTNL: unexpected msg_type %d", nh->nlmsg_type);
             continue;
         }
 
         rtm = (struct rtmsg *)NLMSG_DATA(nh);
         attrlen = RTM_PAYLOAD(nh);
 
-        /* we're only looking for routes in the main table, as "we have
-         * no IPv6" will lead to a lookup result in "Local" (::/0 reject)
-         */
-        if (rtm->rtm_family != AF_INET6
-            || rtm->rtm_table != RT_TABLE_MAIN)
+        /* we're only looking for routes in the main table */
+        if ((rtm->rtm_family != family) || (rtm->rtm_table != RT_TABLE_MAIN))
         {
             continue;
-        }                               /* we're not interested */
+        }
 
-        for (rta = RTM_RTA(rtm);
-             RTA_OK(rta, attrlen);
+        for (rta = RTM_RTA(rtm); RTA_OK(rta, attrlen);
              rta = RTA_NEXT(rta, attrlen))
         {
             if (rta->rta_type == RTA_GATEWAY)
             {
-                if (RTA_PAYLOAD(rta) != sizeof(struct in6_addr) )
+                if (RTA_PAYLOAD(rta) != addr_size)
+                {
+                    msg(M_WARN, "RTNL: RTA_GW size mismatch");
+                    continue;
+                }
+
+                flags |= RGI_ADDR_DEFINED;
+
+                if (gw)
                 {
-                    msg(M_WARN, "GDG6: RTA_GW size mismatch"); continue;
+                    ASSERT(RTA_DATA(rta));
+                    memcpy(gw, RTA_DATA(rta), addr_size);
                 }
-                rgi6->gateway.addr_ipv6 = *(struct in6_addr *) RTA_DATA(rta);
-                rgi6->flags |= RGI_ADDR_DEFINED;
             }
             else if (rta->rta_type == RTA_OIF)
             {
-                char ifname[IF_NAMESIZE+1];
-                int oif;
-                if (RTA_PAYLOAD(rta) != sizeof(oif) )
+                if (RTA_PAYLOAD(rta) != sizeof(uint32_t) )
                 {
-                    msg(M_WARN, "GDG6: oif size mismatch"); continue;
+                    msg(M_WARN, "RTNL: oif size mismatch");
+                    continue;
                 }
 
-                memcpy(&oif, RTA_DATA(rta), sizeof(oif));
-                if_indextoname(oif,ifname);
-                strncpy( rgi6->iface, ifname, sizeof(rgi6->iface)-1 );
-                rgi6->flags |= RGI_IFACE_DEFINED;
+                flags |= RGI_IFACE_DEFINED;
+
+                if (iface)
+                {
+                    ASSERT(RTA_DATA(rta));
+                    if (!if_indextoname(*(uint32_t *)RTA_DATA(rta), iface))
+                    {
+                        msg(M_WARN, "RTNL: couldn't get out ifname for route");
+                    }
+                }
             }
         }
     }
 
+done:
+    close(nls);
+
+    return flags;
+}
+
+void
+get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
+                         const struct in6_addr *dest)
+{
+    int flags;
+
+    rgi6->flags |= route_get(dest, &rgi6->gateway.addr_ipv6, rgi6->iface,
+                             AF_INET6);
+
     /* if we have an interface but no gateway, the destination is on-link */
-    if ( ( rgi6->flags & (RGI_IFACE_DEFINED|RGI_ADDR_DEFINED) ) ==
-         RGI_IFACE_DEFINED)
+    flags = RGI_IFACE_DEFINED | RGI_ADDR_DEFINED;
+    if ((rgi6->flags & flags) == RGI_IFACE_DEFINED)
     {
         rgi6->flags |= (RGI_ADDR_DEFINED | RGI_ON_LINK);
         if (dest)
@@ -3492,12 +3554,6 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
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
@@ -4127,7 +4183,37 @@ test_local_addr(const in_addr_t addr, const struct route_gateway_info *rgi)
     return ret;
 }
 
-#else  /* if defined(_WIN32) */
+#elif defined(TARGET_LINUX) || defined(TARGET_ANDROID)
+
+int
+test_local_addr(const in_addr_t addr, const struct route_gateway_info *rgi)
+{
+    in_addr_t addr_net = htonl(addr);
+    int flags;
+
+    flags = route_get(&addr_net, NULL, NULL, AF_INET);
+    /*
+     * the address is local if there is a rule in the routing table having an
+     * outgoing interface but no nexthop
+     */
+    if ((flags & RGI_IFACE_DEFINED) && !(flags & RGI_ADDR_DEFINED))
+    {
+        return TLA_LOCAL;
+    }
+    /* if a nexthop exists, this address is definitely non-local */
+    else if (flags & RGI_ADDR_DEFINED)
+    {
+        return TLA_NONLOCAL;
+    }
+
+    /*
+     * can't reach this address (i.e. non local address, but we have no default
+     * route)
+     */
+    return TLA_NOT_IMPLEMENTED;
+}
+
+#else
 
 int
 test_local_addr(const in_addr_t addr, const struct route_gateway_info *rgi)  /* PLATFORM-SPECIFIC */
-- 
2.11.0


