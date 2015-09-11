From: Gert Doering <gert@...1296...>
Date: Fri, 11 Sep 2015 17:33:38 +0200
Message-Id: <1441985627-14822-2-git-send-email-gert@...1296...>
In-Reply-To: <1441985627-14822-1-git-send-email-gert@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 01/10] refactor struct route_ipv6,
	bring in line with struct route_ipv4 again
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

adjust "struct route_ipv6" (and all users) to reflect changes
to "struct route_ipv4" done in commit 7fb0e07e, namely:

 - new member "r6->flags"
 - "r6->defined"        becomes "r6->flags & RT_DEFINED"
 - "r6->metric_defined" becomes "r6->flags & RT_METRIC_DEFINED"
 - route addition status is stored in "r6->flags & RT_ADDED"

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 35 ++++++++++++++++++-----------------
 src/openvpn/route.h |  3 +--
 src/openvpn/tun.c   |  6 ++----
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ee7c0de..0f91652 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -374,7 +374,7 @@ init_route_ipv6 (struct route_ipv6 *r6,
 	         const struct route_ipv6_option *r6o,
 	         const struct route_ipv6_list *rl6 )
 {
-  r6->defined = false;
+  CLEAR (*r6);
 
   if ( !get_ipv6_addr( r6o->prefix, &r6->network, &r6->netbits, NULL, M_WARN ))
     goto fail;
@@ -399,7 +399,6 @@ init_route_ipv6 (struct route_ipv6 *r6,
 
   /* metric */
 
-  r6->metric_defined = false;
   r6->metric = -1;
   if (is_route_parm_defined (r6o->metric))
     {
@@ -411,22 +410,21 @@ init_route_ipv6 (struct route_ipv6 *r6,
 	       r6o->metric);
 	  goto fail;
 	}
-      r6->metric_defined = true;
+      r6->flags |= RT_METRIC_DEFINED;
     }
   else if (rl6->default_metric_defined)
     {
       r6->metric = rl6->default_metric;
-      r6->metric_defined = true;
+      r6->flags |= RT_METRIC_DEFINED;
     }
 
-  r6->defined = true;
+  r6->flags |= RT_DEFINED;
 
   return true;
 
  fail:
   msg (M_WARN, PACKAGE_NAME " ROUTE: failed to parse/resolve route for host/network: %s",
        r6o->prefix);
-  r6->defined = false;
   return false;
 }
 
@@ -1168,7 +1166,7 @@ static void
 setenv_route_ipv6 (struct env_set *es, const struct route_ipv6 *r6, int i)
 {
   struct gc_arena gc = gc_new ();
-  if (r6->defined)
+  if (r6->flags & RT_DEFINED)
     {
       struct buffer name1 = alloc_buf_gc( 256, &gc );
       struct buffer val = alloc_buf_gc( 256, &gc );
@@ -1545,7 +1543,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 
   bool gateway_needed = false;
 
-  if (!r6->defined)
+  if (! (r6->flags & RT_DEFINED) )
     return;
 
   gc_init (&gc);
@@ -1576,7 +1574,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
    * gateway unless the route is to be an on-link network
    */
   if ( tt->type == DEV_TYPE_TAP &&
-                  !(r6->metric_defined && r6->metric == 0 ) )
+                  !( (r6->flags & RT_METRIC_DEFINED) && r6->metric == 0 ) )
     {
       gateway_needed = true;
     }
@@ -1590,7 +1588,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 	      device);
   if (gateway_needed)
     argv_printf_cat (&argv, "via %s", gateway);
-  if (r6->metric_defined && r6->metric > 0 )
+  if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0 )
     argv_printf_cat (&argv, " metric %d", r6->metric);
 
 #else
@@ -1601,7 +1599,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 	      device);
   if (gateway_needed)
     argv_printf_cat (&argv, "gw %s", gateway);
-  if (r6->metric_defined && r6->metric > 0 )
+  if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0 )
     argv_printf_cat (&argv, " metric %d", r6->metric);
 #endif  /*ENABLE_IPROUTE*/
   argv_msg (D_ROUTE, &argv);
@@ -1635,7 +1633,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 	argv_printf_cat( &argv, " %s", gateway );
 
 #if 0
-  if (r->metric_defined)
+  if (r6->flags & RT_METRIC_DEFINED)
     argv_printf_cat (&argv, " METRIC %d", r->metric);
 #endif
 
@@ -1727,7 +1725,10 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
   msg (M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif
 
-  r6->defined = status;
+  if (status)
+    r6->flags |= RT_ADDED;
+  else
+    r6->flags &= ~RT_ADDED;
   argv_reset (&argv);
   gc_free (&gc);
 }
@@ -1916,7 +1917,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
   const char *device = tt->actual_name;
   bool gateway_needed = false;
 
-  if (!r6->defined)
+  if ((r6->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
     return;
 
   gc_init (&gc);
@@ -1938,7 +1939,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
    * delete, otherwise some OSes will refuse to delete the route
    */
   if ( tt->type == DEV_TYPE_TAP &&
-                  !(r6->metric_defined && r6->metric == 0 ) )
+                  !( (r6->flags & RT_METRIC_DEFINED) && r6->metric == 0 ) )
     {
       gateway_needed = true;
     }
@@ -1961,7 +1962,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 	      device);
   if (gateway_needed)
     argv_printf_cat (&argv, "gw %s", gateway);
-  if (r6->metric_defined && r6->metric > 0 )
+  if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0 )
     argv_printf_cat (&argv, " metric %d", r6->metric);
 #endif  /*ENABLE_IPROUTE*/
   argv_msg (D_ROUTE, &argv);
@@ -1989,7 +1990,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 	argv_printf_cat( &argv, " %s", gateway );
 
 #if 0
-  if (r->metric_defined)
+  if (r6->flags & RT_METRIC_DEFINED)
     argv_printf_cat (&argv, "METRIC %d", r->metric);
 #endif
 
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 3cec08d..13882a4 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -123,11 +123,10 @@ struct route_ipv4 {
 
 struct route_ipv6 {
   struct route_ipv6 *next;
-  bool defined;
+  unsigned int flags;				/* RT_ flags, see route_ipv4 */
   struct in6_addr network;
   unsigned int netbits;
   struct in6_addr gateway;
-  bool metric_defined;
   int metric;
 };
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 13e3826..766a73c 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -607,12 +607,11 @@ void add_route_connected_v6_net(struct tuntap * tt,
 {
     struct route_ipv6 r6;
 
-    r6.defined = true;
     r6.network = tt->local_ipv6;
     r6.netbits = tt->netbits_ipv6;
     r6.gateway = tt->local_ipv6;
     r6.metric  = 0;			/* connected route */
-    r6.metric_defined = true;
+    r6.flags   = RT_DEFINED | RT_METRIC_DEFINED;
     add_route_ipv6 (&r6, tt, 0, es);
 }
 
@@ -621,12 +620,11 @@ void delete_route_connected_v6_net(struct tuntap * tt,
 {
     struct route_ipv6 r6;
 
-    r6.defined = true;
     r6.network = tt->local_ipv6;
     r6.netbits = tt->netbits_ipv6;
     r6.gateway = tt->local_ipv6;
     r6.metric  = 0;			/* connected route */
-    r6.metric_defined = true;
+    r6.flags   = RT_DEFINED | RT_ADDED | RT_METRIC_DEFINED;
     delete_route_ipv6 (&r6, tt, 0, es);
 }
 #endif
-- 
2.3.6


