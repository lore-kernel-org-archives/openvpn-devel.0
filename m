From: Xavier Franquet <xavier@...1461...>
Date: Wed, 18 May 2011 16:38:21 +0200
Message-Id: <1305729501-500-1-git-send-email-xavier@...1461...>
Subject: [Openvpn-devel] +++ route.c	2011-05-18 09:15:17.000000000 +0200
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

