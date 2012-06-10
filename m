From: Gert Doering <gert@...1296...>
Date: Sun, 10 Jun 2012 17:41:30 +0200
Message-Id: <1339342891-28443-5-git-send-email-gert@...1296...>
In-Reply-To: <1339342891-28443-1-git-send-email-gert@...1296...>
References: <1339342891-28443-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 4/5] Add missing pieces to IPv6 route
	gateway handling.
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

OpenVPN on Linux (iproute2+ifconfig), FreeBSD and MacOS X (Darwin)
normally points routes directly towards the "tun" interface, obviating
the need for a gateway.  For "tap" interfaces, now add gateway spec to
linux route command, and replace "-iface <dev>" with gateway spec (both
together do not work) on FreeBSD and MacOS X.

Also adapt "route delete" appropriately, otherwise route will not be found.

All other platforms already use the gateway address for tun and tap,
because there's no way to install a route "towards an interface" there.

Remove warning about missing IPv6 route gateway handling.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c  |    3 --
 src/openvpn/route.c |   75 +++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b726b93..320edcc 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1253,9 +1253,6 @@ do_init_route_ipv6_list (const struct options *options,
   int dev = dev_type_enum (options->dev, options->dev_type);
   int metric = -1;		/* no metric set */
 
-  if (dev != DEV_TYPE_TUN )
-    msg( M_WARN, "IPv6 routes on TAP devices are going to fail on some platforms (need gateway spec)" );	/* TODO-GERT */
-
   gw = options->ifconfig_ipv6_remote;		/* default GW = remote end */
 #if 0					/* not yet done for IPv6 - TODO!*/
   if ( options->route_ipv6_default_gateway )		/* override? */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index aadbacc..5848d45 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1550,6 +1550,8 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
   bool status = false;
   const char *device = tt->actual_name;
 
+  bool gateway_needed = false;
+
   if (!r6->defined)
     return;
 
@@ -1574,6 +1576,18 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
    * (not currently done for IPv6)
    */
 
+  /* On "tun" interface, we never set a gateway if the operating system
+   * can do "route to interface" - it does not add value, as the target
+   * dev already fully qualifies the route destination on point-to-point
+   * interfaces.   OTOH, on "tap" interface, we must always set the
+   * gateway unless the route is to be an on-link network
+   */
+  if ( tt->type == DEV_TYPE_TAP && 
+                  !(r6->metric_defined && r6->metric == 0 ) )
+    {
+      gateway_needed = true;
+    }
+
 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
   argv_printf (&argv, "%s -6 route add %s/%d dev %s",
@@ -1581,6 +1595,8 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 	      network,
 	      r6->netbits,
 	      device);
+  if (gateway_needed)
+    argv_printf_cat (&argv, "via %s", gateway);
   if (r6->metric_defined && r6->metric > 0 )
     argv_printf_cat (&argv, " metric %d", r6->metric);
 
@@ -1590,6 +1606,8 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 	      network,
 	      r6->netbits,
 	      device);
+  if (gateway_needed)
+    argv_printf_cat (&argv, "gw %s", gateway);
   if (r6->metric_defined && r6->metric > 0 )
     argv_printf_cat (&argv, " metric %d", r6->metric);
 #endif  /*ENABLE_IPROUTE*/
@@ -1652,20 +1670,29 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
-  argv_printf (&argv, "%s add -inet6 %s/%d -iface %s",
+  argv_printf (&argv, "%s add -inet6 %s/%d",
 		ROUTE_PATH,
 	        network,
-	        r6->netbits,
-	        device );
+	        r6->netbits);
+
+  if (gateway_needed)
+    argv_printf_cat (&argv, "%s", gateway);
+  else
+    argv_printf_cat (&argv, "-iface %s", device);
 
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: *BSD route add -inet6 command failed");
 
 #elif defined(TARGET_DARWIN) 
 
-  argv_printf (&argv, "%s add -inet6 %s -prefixlen %d -iface %s",
+  argv_printf (&argv, "%s add -inet6 %s -prefixlen %d",
 		ROUTE_PATH,
-	        network, r6->netbits, device );
+	        network, r6->netbits );
+
+  if (gateway_needed)
+    argv_printf_cat (&argv, "%s", gateway);
+  else
+    argv_printf_cat (&argv, "-iface %s", device);
 
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: MacOS X route add -inet6 command failed");
@@ -1865,6 +1892,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
   const char *network;
   const char *gateway;
   const char *device = tt->actual_name;
+  bool gateway_needed = false;
 
   if (!r6->defined)
     return;
@@ -1884,6 +1912,16 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 
   msg( M_INFO, "delete_route_ipv6(%s/%d)", network, r6->netbits );
 
+  /* if we used a gateway on "add route", we also need to specify it on
+   * delete, otherwise some OSes will refuse to delete the route
+   */
+  if ( tt->type == DEV_TYPE_TAP && 
+                  !(r6->metric_defined && r6->metric == 0 ) )
+    {
+      gateway_needed = true;
+    }
+
+
 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
   argv_printf (&argv, "%s -6 route del %s/%d dev %s",
@@ -1891,12 +1929,18 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 	      network,
 	      r6->netbits,
 	      device);
+  if (gateway_needed)
+    argv_printf_cat (&argv, "via %s", gateway);
 #else
   argv_printf (&argv, "%s -A inet6 del %s/%d dev %s",
 		ROUTE_PATH,
 	      network,
 	      r6->netbits,
 	      device);
+  if (gateway_needed)
+    argv_printf_cat (&argv, "gw %s", gateway);
+  if (r6->metric_defined && r6->metric > 0 )
+    argv_printf_cat (&argv, " metric %d", r6->metric);
 #endif  /*ENABLE_IPROUTE*/
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: Linux route -6/-A inet6 del command failed");
@@ -1949,23 +1993,32 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
-  argv_printf (&argv, "%s delete -inet6 %s/%d -iface %s",
+  argv_printf (&argv, "%s delete -inet6 %s/%d",
 		ROUTE_PATH,
 	        network,
-	        r6->netbits,
-	        device );
+	        r6->netbits );
+
+  if (gateway_needed)
+    argv_printf_cat (&argv, "%s", gateway);
+  else
+    argv_printf_cat (&argv, "-iface %s", device);
 
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: *BSD route delete -inet6 command failed");
 
 #elif defined(TARGET_DARWIN) 
 
-  argv_printf (&argv, "%s delete -inet6 %s -prefixlen %d -iface %s",
+  argv_printf (&argv, "%s delete -inet6 %s -prefixlen %d",
 		ROUTE_PATH, 
-		network, r6->netbits, device );
+		network, r6->netbits );
+
+  if (gateway_needed)
+    argv_printf_cat (&argv, "%s", gateway);
+  else
+    argv_printf_cat (&argv, "-iface %s", device);
 
   argv_msg (D_ROUTE, &argv);
-  openvpn_execve_check (&argv, es, 0, "ERROR: *BSD route delete -inet6 command failed");
+  openvpn_execve_check (&argv, es, 0, "ERROR: MacOS X route delete -inet6 command failed");
 
 #elif defined(TARGET_OPENBSD)
 
-- 
1.7.3.4


