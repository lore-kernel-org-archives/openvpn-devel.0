From: Xavier Franquet <xavier@...1461...>
Date: Fri, 20 May 2011 10:33:25 +0200
Message-Id: <1305880405-8928-1-git-send-email-xavier@...1461...>
Subject: [Openvpn-devel] [PATCH] Add parameter "dev <device>" to add_route
	and delete_route for IPv4, as it is done for IPv6.
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

When openvpn tries to add (or delete) an IPv4 route, doesn't use the parameter "dev <device>" in the command.
If there's a local subnet that matches the VPN Server network, the route would use a wrong interface.
Ex:
   local subnet 10.100.0.0/24 on iface eth2
   openvpn pool 10.100.0.0/16 on iface tap2 (ifconfig_pool_remote_ip is 10.100.0.1)
      push "route 10.10.0.1 255.255.255.255"

   Without the patch, the route will be added with eth2, instead of tap2

Signed-off-by: Xavier Franquet <xavier@...1461...>
---
 route.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/route.c b/route.c
index cb685c3..b9b478f 100644
--- a/route.c
+++ b/route.c
@@ -1090,6 +1090,7 @@ add_route (struct route *r, const struct tuntap *tt, unsigned int flags, const s
   const char *netmask;
   const char *gateway;
   bool status = false;
+  const char *device = tt->actual_name;
 
   if (!r->defined)
     return;
@@ -1113,23 +1114,26 @@ add_route (struct route *r, const struct tuntap *tt, unsigned int flags, const s
 
 #if defined(TARGET_LINUX)
 #ifdef CONFIG_FEATURE_IPROUTE
-  argv_printf (&argv, "%s route add %s/%d via %s",
+  argv_printf (&argv, "%s route add %s/%d via %s dev %s",
   	      iproute_path,
 	      network,
 	      count_netmask_bits(netmask),
-	      gateway);
+	      gateway,
+	      device);
   if (r->metric_defined)
     argv_printf_cat (&argv, "metric %d", r->metric);
 
 #else
-  argv_printf (&argv, "%s add -net %s netmask %s gw %s",
+  argv_printf (&argv, "%s add -net %s netmask %s gw %s dev %s",
 		ROUTE_PATH,
 	      network,
 	      netmask,
-	      gateway);
+	      gateway,
+	      device);
   if (r->metric_defined)
     argv_printf_cat (&argv, "metric %d", r->metric);
 #endif  /*CONFIG_FEATURE_IPROUTE*/
+
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route add command failed");
 
@@ -1452,6 +1456,7 @@ delete_route (const struct route *r, const struct tuntap *tt, unsigned int flags
   const char *network;
   const char *netmask;
   const char *gateway;
+  const char *device = tt->actual_name;
 
   if (!r->defined)
     return;
@@ -1465,16 +1470,18 @@ delete_route (const struct route *r, const struct tuntap *tt, unsigned int flags
 
 #if defined(TARGET_LINUX)
 #ifdef CONFIG_FEATURE_IPROUTE
-  argv_printf (&argv, "%s route del %s/%d",
+  argv_printf (&argv, "%s route del %s/%d dev %s",
   	      iproute_path,
 	      network,
-	      count_netmask_bits(netmask));
+	      count_netmask_bits(netmask),
+	      device);
 #else
 
-  argv_printf (&argv, "%s del -net %s netmask %s",
+  argv_printf (&argv, "%s del -net %s netmask %s dev %s",
 		ROUTE_PATH,
 	      network,
-	      netmask);
+	      netmask,
+	      device);
 #endif /*CONFIG_FEATURE_IPROUTE*/
   if (r->metric_defined)
     argv_printf_cat (&argv, "metric %d", r->metric);
-- 
1.7.1


