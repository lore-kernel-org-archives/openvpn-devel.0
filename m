From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:31:42 +0300
Message-Id: <1336851105-24172-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336851105-24172-1-git-send-email-alon.barlev@...277...>
References: <1336851105-24172-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [V2.4 1/4] cleanup: remove check_subnet_conflict
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Commeted out as "too many false positives".

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/route.c |    1 -
 src/openvpn/tun.c   |   43 -------------------------------------------
 src/openvpn/tun.h   |    4 ----
 3 files changed, 0 insertions(+), 48 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 7c25c77..f36c324 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1030,7 +1030,6 @@ add_routes (struct route_list *rl, struct route_ipv6_list *rl6, const struct tun
       for (i = 0; i < rl->n; ++i)
 	{
 	  struct route *r = &rl->routes[i];
-	  check_subnet_conflict (r->network, r->netmask, "route");
 	  if (flags & ROUTE_DELETE_FIRST)
 	    delete_route (r, tt, flags, &rl->rgi, es);
 	  add_route (r, tt, flags, &rl->rgi, es);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 71abbf3..033c1e2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -242,44 +242,6 @@ check_addr_clash (const char *name,
   gc_free (&gc);
 }
 
-/*
- * Issue a warning if ip/netmask (on the virtual IP network) conflicts with
- * the settings on the local LAN.  This is designed to flag issues where
- * (for example) the OpenVPN server LAN is running on 192.168.1.x, but then
- * an OpenVPN client tries to connect from a public location that is also running
- * off of a router set to 192.168.1.x.
- */
-void
-check_subnet_conflict (const in_addr_t ip,
-		       const in_addr_t netmask,
-		       const char *prefix)
-{
-#if 0 /* too many false positives */
-  struct gc_arena gc = gc_new ();
-  in_addr_t lan_gw = 0;
-  in_addr_t lan_netmask = 0;
-
-  if (get_default_gateway (&lan_gw, &lan_netmask) && lan_netmask)
-    {
-      const in_addr_t lan_network = lan_gw & lan_netmask; 
-      const in_addr_t network = ip & netmask;
-
-      /* do the two subnets defined by network/netmask and lan_network/lan_netmask intersect? */
-      if ((network & lan_netmask) == lan_network
-	  || (lan_network & netmask) == network)
-	{
-	  msg (M_WARN, "WARNING: potential %s subnet conflict between local LAN [%s/%s] and remote VPN [%s/%s]",
-	       prefix,
-	       print_in_addr_t (lan_network, 0, &gc),
-	       print_in_addr_t (lan_netmask, 0, &gc),
-	       print_in_addr_t (network, 0, &gc),
-	       print_in_addr_t (netmask, 0, &gc));
-	}
-    }
-  gc_free (&gc);
-#endif
-}
-
 void
 warn_on_use_of_common_subnets (void)
 {
@@ -485,11 +447,6 @@ init_tun (const char *dev,       /* --dev option */
 			    remote_public,
 			    tt->local,
 			    tt->remote_netmask);
-
-	  if (tt->type == DEV_TYPE_TAP || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET))
-	    check_subnet_conflict (tt->local, tt->remote_netmask, "TUN/TAP adapter");
-	  else if (tt->type == DEV_TYPE_TUN)
-	    check_subnet_conflict (tt->local, IPV4_NETMASK_HOST, "TUN/TAP adapter");
 	}
 
       /*
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 9bd990f..bea1554 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -251,10 +251,6 @@ const char *ifconfig_options_string (const struct tuntap* tt, bool remote, bool
 
 bool is_tun_p2p (const struct tuntap *tt);
 
-void check_subnet_conflict (const in_addr_t ip,
-			    const in_addr_t netmask,
-			    const char *prefix);
-
 void warn_on_use_of_common_subnets (void);
 
 /*
-- 
1.7.3.4


