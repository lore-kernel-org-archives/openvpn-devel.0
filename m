MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Mon, 21 Nov 2011 12:59:25 +0100
Message-id: <1321876765-16500-2-git-send-email-davids@...1347...>
In-reply-to: <1321876765-16500-1-git-send-email-davids@...1347...>
References: <1321876765-16500-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Clean-up: check_subnet_conflict() function
 was #if 0 -> remove it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

As the body of the check_subnet_conflict() function was disabled with
an #if 0 clause, remove this function and clean up all places this function
was called.

This function also expected get_default_gateway() to return data,
which it does not do any more.  Hence this function is "out-of-date" and no
longer usefull.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 route.c |    1 -
 tun.c   |   42 ------------------------------------------
 tun.h   |    4 ----
 3 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/route.c b/route.c
index be23a89..9357cb6 100644
--- a/route.c
+++ b/route.c
@@ -1001,7 +1001,6 @@ add_routes (struct route_list *rl, struct route_ipv6_list *rl6, const struct tun
       for (i = 0; i < rl->n; ++i)
 	{
 	  struct route *r = &rl->routes[i];
-	  check_subnet_conflict (r->network, r->netmask, "route");
 	  if (flags & ROUTE_DELETE_FIRST)
 	    delete_route (r, tt, flags, &rl->rgi, es);
 	  add_route (r, tt, flags, &rl->rgi, es);
diff --git a/tun.c b/tun.c
index c8ac394..e7a2150 100644
--- a/tun.c
+++ b/tun.c
@@ -236,44 +236,6 @@ check_addr_clash (const char *name,
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
@@ -479,10 +441,6 @@ init_tun (const char *dev,       /* --dev option */
 			    tt->local,
 			    tt->remote_netmask);
 
-	  if (tt->type == DEV_TYPE_TAP || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET))
-	    check_subnet_conflict (tt->local, tt->remote_netmask, "TUN/TAP adapter");
-	  else if (tt->type == DEV_TYPE_TUN)
-	    check_subnet_conflict (tt->local, ~0, "TUN/TAP adapter");
 	}
 
       /*
diff --git a/tun.h b/tun.h
index f28b8d8..de330b6 100644
--- a/tun.h
+++ b/tun.h
@@ -248,10 +248,6 @@ const char *ifconfig_options_string (const struct tuntap* tt, bool remote, bool
 
 bool is_tun_p2p (const struct tuntap *tt);
 
-void check_subnet_conflict (const in_addr_t ip,
-			    const in_addr_t netmask,
-			    const char *prefix);
-
 void warn_on_use_of_common_subnets (void);
 
 /*
-- 
1.7.4.4


