From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 6 Aug 2012 17:21:50 +0200
Message-ID: <1344266510-17788-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] get IPv4 default route on Linux via
	rtnetlink
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

The file /proc/net/route only contains routes from the main routing
table. When a default route is set in the "default" table, openvpn
cannot find it by parsing that file. Using the routing netlink socket
removes this limitation.

While getting the IPv6 default route would be possible with rtnetlink
as well, this patch skips that part intentionally, as --redirect-gateway
is not yet supported for IPv6.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>

---
 src/openvpn/route.c |  356 +++++++++++++++++++++++++++++++++------------------
 src/openvpn/route.h |    5 +
 2 files changed, 236 insertions(+), 125 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d967d4f..71d7068 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -752,13 +752,14 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
 }
 
 static void
-add_route3 (in_addr_t network,
-	    in_addr_t netmask,
-	    in_addr_t gateway,
-	    const struct tuntap *tt,
-	    unsigned int flags,
-	    const struct route_gateway_info *rgi,
-	    const struct env_set *es)
+add_route4 (in_addr_t network,
+            in_addr_t netmask,
+            in_addr_t gateway,
+            unsigned char table,
+            const struct tuntap *tt,
+            unsigned int flags,
+            const struct route_gateway_info *rgi,
+            const struct env_set *es)
 {
   struct route r;
   CLEAR (r);
@@ -766,17 +767,35 @@ add_route3 (in_addr_t network,
   r.network = network;
   r.netmask = netmask;
   r.gateway = gateway;
+  if (table)
+    {
+      r.flags |= RT_TABLE_DEFINED;
+      r.table = table;
+    }
   add_route (&r, tt, flags, rgi, es);
 }
 
 static void
-del_route3 (in_addr_t network,
-	    in_addr_t netmask,
-	    in_addr_t gateway,
-	    const struct tuntap *tt,
-	    unsigned int flags,
-	    const struct route_gateway_info *rgi,
-	    const struct env_set *es)
+add_route3 (in_addr_t network,
+            in_addr_t netmask,
+            in_addr_t gateway,
+            const struct tuntap *tt,
+            unsigned int flags,
+            const struct route_gateway_info *rgi,
+            const struct env_set *es)
+{
+  add_route4 (network, netmask, gateway, 0, tt, flags, rgi, es);
+}
+
+static void
+del_route4 (in_addr_t network,
+            in_addr_t netmask,
+            in_addr_t gateway,
+            unsigned char table,
+            const struct tuntap *tt,
+            unsigned int flags,
+            const struct route_gateway_info *rgi,
+            const struct env_set *es)
 {
   struct route r;
   CLEAR (r);
@@ -784,10 +803,27 @@ del_route3 (in_addr_t network,
   r.network = network;
   r.netmask = netmask;
   r.gateway = gateway;
+  if (table)
+    {
+      r.flags |= RT_TABLE_DEFINED;
+      r.table = table;
+    }
   delete_route (&r, tt, flags, rgi, es);
 }
 
 static void
+del_route3 (in_addr_t network,
+            in_addr_t netmask,
+            in_addr_t gateway,
+            const struct tuntap *tt,
+            unsigned int flags,
+            const struct route_gateway_info *rgi,
+            const struct env_set *es)
+{
+  del_route4 (network, netmask, gateway, 0, tt, flags, rgi, es);
+}
+
+static void
 add_bypass_routes (struct route_bypass *rb,
 		   in_addr_t gateway,
 		   const struct tuntap *tt,
@@ -912,23 +948,25 @@ redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *tt, u
 		}
 	      else
 		{
-		  /* delete default route */
-		  del_route3 (0,
-			      0,
-			      rl->rgi.gateway.addr,
-			      tt,
-			      flags | ROUTE_REF_GW,
-			      &rl->rgi,
-			      es);
-
-		  /* add new default route */
-		  add_route3 (0,
-			      0,
-			      rl->spec.remote_endpoint,
-			      tt,
-			      flags,
-			      &rl->rgi,
-			      es);
+                  /* delete default route */
+                  del_route4 (0,
+                              0,
+                              rl->rgi.gateway.addr,
+                              rl->rgi.table,
+                              tt,
+                              flags | ROUTE_REF_GW,
+                              &rl->rgi,
+                              es);
+
+                  /* add new default route */
+                  add_route4 (0,
+                              0,
+                              rl->spec.remote_endpoint,
+                              rl->rgi.table,
+                              tt,
+                              flags,
+                              &rl->rgi,
+                              es);
 		}
 	    }
 
@@ -983,23 +1021,25 @@ undo_redirect_default_route_to_vpn (struct route_list *rl, const struct tuntap *
 	    }
 	  else
 	    {
-	      /* delete default route */
-	      del_route3 (0,
-			  0,
-			  rl->spec.remote_endpoint,
-			  tt,
-			  flags,
-			  &rl->rgi,
-			  es);
-
-	      /* restore original default route */
-	      add_route3 (0,
-			  0,
-			  rl->rgi.gateway.addr,
-			  tt,
-			  flags | ROUTE_REF_GW,
-			  &rl->rgi,
-			  es);
+              /* delete default route */
+              del_route4 (0,
+                          0,
+                          rl->spec.remote_endpoint,
+                          rl->rgi.table,
+                          tt,
+                          flags,
+                          &rl->rgi,
+                          es);
+
+              /* restore original default route */
+              add_route4 (0,
+                          0,
+                          rl->rgi.gateway.addr,
+                          rl->rgi.table,
+                          tt,
+                          flags | ROUTE_REF_GW,
+                          &rl->rgi,
+                          es);
 	    }
 	}
 
@@ -1326,6 +1366,8 @@ add_route (struct route *r,
 	      gateway);
   if (r->flags & RT_METRIC_DEFINED)
     argv_printf_cat (&argv, "metric %d", r->metric);
+  if (r->flags & RT_TABLE_DEFINED)
+    argv_printf_cat (&argv, "table %d", r->table);
 
 #else
   argv_printf (&argv, "%s add -net %s netmask %s",
@@ -1758,6 +1800,8 @@ delete_route (struct route *r,
   	      iproute_path,
 	      network,
 	      count_netmask_bits(netmask));
+  if (r->flags & RT_TABLE_DEFINED)
+    argv_printf_cat (&argv, "table %d", r->table);
 #else
   argv_printf (&argv, "%s del -net %s netmask %s",
 	       ROUTE_PATH,
@@ -2425,72 +2469,144 @@ show_routes (int msglev)
 
 #elif defined(TARGET_LINUX)
 
+#include <asm/types.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <sys/socket.h>
+
+static void
+get_default_gateway_rtnl (struct route_gateway_info *rgi, int *iface_index)
+{
+  struct nlmsghdr *nh;
+  ssize_t len;
+  int rtnl_fd;
+
+  union {
+    struct {
+      struct nlmsghdr nh;
+      struct rtmsg rt;
+    } m;
+    char buf[4096];
+  } rtu;
+
+  CLEAR (*rgi);
+  CLEAR (rtu);
+
+  rtu.m.nh.nlmsg_len = NLMSG_LENGTH(sizeof(rtu.m.rt));
+  rtu.m.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+  rtu.m.nh.nlmsg_type = RTM_GETROUTE;
+  rtu.m.rt.rtm_family = AF_INET;
+  rtu.m.rt.rtm_table = RT_TABLE_UNSPEC;
+  rtu.m.rt.rtm_protocol = RTPROT_UNSPEC;
+  rtu.m.rt.rtm_type = RTN_UNICAST;
+
+  rtnl_fd = socket (AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
+  if (rtnl_fd == -1)
+    {
+      msg (M_WARN|M_ERRNO, "ROUTE: problem creating rtnetlink socket");
+      return;
+    }
+
+  while (true)
+    {
+      len = send (rtnl_fd, &rtu, rtu.m.nh.nlmsg_len, 0);
+      if (len == -1)
+        {
+          if (errno == EAGAIN)
+            continue;
+
+          msg (M_WARN|M_ERRNO, "ROUTE: problem writing to rtnetlink socket");
+          close (rtnl_fd);
+          return;
+        }
+      break;
+    };
+
+  while (true)
+    {
+      len = recv (rtnl_fd, &rtu, sizeof(rtu), MSG_WAITALL);
+      if (len == -1)
+        {
+          if (errno == EAGAIN)
+            continue;
+
+          msg (M_WARN|M_ERRNO, "ROUTE: problem reading from rtnetlink socket");
+          close (rtnl_fd);
+          return;
+        }
+      break;
+    }
+
+  close (rtnl_fd);
+
+  for (nh = &rtu.m.nh; NLMSG_OK (nh, len); nh = NLMSG_NEXT (nh, len))
+    {
+      struct rtmsg *rt;
+      struct rtattr *rta;
+      uint32_t rtalen, metric = 0, best_metric = ~0;
+      in_addr_t gw = INADDR_ANY;
+      int if_index = 0;
+
+      if (nh->nlmsg_type == NLMSG_ERROR)
+        {
+          struct nlmsgerr *nlerr = NLMSG_DATA (nh);
+          errno = -nlerr->error;
+          msg (M_WARN|M_ERRNO, "ROUTE: problem fetching routes with rtnetlink");
+          return;
+        }
+
+      if (nh->nlmsg_type == NLMSG_DONE)
+        break;
+
+      rt = NLMSG_DATA (nh);
+      if ( rt->rtm_dst_len != 0
+      ||  (rt->rtm_table != RT_TABLE_MAIN
+        && rt->rtm_table != RT_TABLE_DEFAULT) )
+        continue;
+
+      rta = RTM_RTA (rt);
+      rtalen = RTM_PAYLOAD (nh);
+      while ( RTA_OK (rta, rtalen) )
+        {
+          switch (rta->rta_type)
+            {
+            case RTA_GATEWAY:
+              gw = *(in_addr_t *)RTA_DATA (rta);
+              break;
+            case RTA_OIF:
+              if_index = *(int *)RTA_DATA (rta);
+              break;
+            case RTA_PRIORITY:
+              metric = *(uint32_t *)RTA_DATA (rta);
+              break;
+            }
+          rta = RTA_NEXT (rta, rtalen);
+        }
+
+      if (metric < best_metric)
+        {
+          best_metric = metric;
+          rgi->gateway.addr = ntohl (gw);
+          rgi->table = rt->rtm_table;
+          *iface_index = if_index;
+
+          rgi->flags |= RGI_ADDR_DEFINED;
+          if (!gw && if_index)
+            rgi->flags |= RGI_ON_LINK;
+          else
+            rgi->flags &= ~(RGI_ON_LINK);
+        }
+    }
+}
+
 void
 get_default_gateway (struct route_gateway_info *rgi)
 {
-  struct gc_arena gc = gc_new ();
+  int iface_index = 0;
   int sd = -1;
-  char best_name[16];
-  best_name[0] = 0;
-
-  CLEAR(*rgi);
 
-  /* get default gateway IP addr */
-  {
-    FILE *fp = fopen ("/proc/net/route", "r");
-    if (fp)
-      {
-	char line[256];
-	int count = 0;
-	unsigned int lowest_metric = UINT_MAX;
-	in_addr_t best_gw = 0;
-	bool found = false;
-	while (fgets (line, sizeof (line), fp) != NULL)
-	  {
-	    if (count)
-	      {
-		unsigned int net_x = 0;
-		unsigned int mask_x = 0;
-		unsigned int gw_x = 0;
-		unsigned int metric = 0;
-		unsigned int flags = 0;
-		char name[16];
-		name[0] = 0;
-		const int np = sscanf (line, "%15s\t%x\t%x\t%x\t%*s\t%*s\t%d\t%x",
-				       name,
-				       &net_x,
-				       &gw_x,
-				       &flags,
-				       &metric,
-				       &mask_x);
-		if (np == 6 && (flags & IFF_UP))
-		  {
-		    const in_addr_t net = ntohl (net_x);
-		    const in_addr_t mask = ntohl (mask_x);
-		    const in_addr_t gw = ntohl (gw_x);
-
-		    if (!net && !mask && metric < lowest_metric)
-		      {
-			found = true;
-			best_gw = gw;
-			strcpy (best_name, name);
-			lowest_metric = metric;
-		      }
-		  }
-	      }
-	    ++count;
-	  }
-	fclose (fp);
-
-	if (found)
-	  {
-	    rgi->gateway.addr = best_gw;
-	    rgi->flags |= RGI_ADDR_DEFINED;
-	    if (!rgi->gateway.addr && best_name[0])
-	      rgi->flags |= RGI_ON_LINK;
-	  }
-      }
-  }
+  /* get default gateway address or interface */
+  get_default_gateway_rtnl (rgi, &iface_index);
 
   /* scan adapter list */
   if (rgi->flags & RGI_ADDR_DEFINED)
@@ -2504,7 +2620,7 @@ get_default_gateway (struct route_gateway_info *rgi)
       if ((sd = socket (AF_INET, SOCK_DGRAM, 0)) < 0)
 	{
 	  msg (M_WARN, "GDG: socket() failed");
-	  goto done;
+	  return;
 	}
       ifc.ifc_len = sizeof (ifs);
       ifc.ifc_req = ifs;
@@ -2534,19 +2650,10 @@ get_default_gateway (struct route_gateway_info *rgi)
 
 	      if (rgi->flags & RGI_ON_LINK)
 		{
-		  /* check that interface name of current interface
-		     matches interface name of best default route */
-		  if (strcmp(ifreq.ifr_name, best_name))
+		  /* check that interface index of current interface
+		     matches interface index of best default route */
+		  if (ifreq.ifr_ifindex != iface_index)
 		    continue;
-#if 0
-		  /* if point-to-point link, use remote addr as route gateway */
-		  if ((ifreq.ifr_flags & IFF_POINTOPOINT) && ioctl (sd, SIOCGIFDSTADDR, &ifreq) >= 0)
-		    {
-		      rgi->gateway.addr = ntohl(((struct sockaddr_in *) &ifreq.ifr_addr)->sin_addr.s_addr);
-		      if (rgi->gateway.addr)
-			rgi->flags &= ~RGI_ON_LINK;
-		    }
-#endif
 		}
 	      else
 		{
@@ -2583,10 +2690,9 @@ get_default_gateway (struct route_gateway_info *rgi)
 	}
     }
 
- done:
-  if (sd >= 0)
+done:
+  if (sd != -1)
     close (sd);
-  gc_free (&gc);
 }
 
 #elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index e63db59..2b1059e 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -114,11 +114,13 @@ struct route {
 # define RT_DEFINED        (1<<0)
 # define RT_ADDED          (1<<1)
 # define RT_METRIC_DEFINED (1<<2)
+# define RT_TABLE_DEFINED  (1<<3)
   unsigned int flags;
   const struct route_option *option;
   in_addr_t network;
   in_addr_t netmask;
   in_addr_t gateway;
+  unsigned char table;
   int metric;
 };
 
@@ -167,6 +169,9 @@ struct route_gateway_info {
   char iface[16]; /* interface name (null terminated), may be empty */
 #endif
 
+  /* routing table for default route */
+  unsigned char table;
+
   /* gateway interface hardware address */
   uint8_t hwaddr[6];
 
-- 
tg: (16ec489..) t/0005/get_default_route_via_rtnetlink (depends on: t/0004/src_and_dst_addr_status_output)

