Message-ID: <44AED16A.2060207@...684...>
Date: Fri, 07 Jul 2006 23:26:02 +0200
From: Christian Holler <decoder@...684...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020101040407070600020500"
Subject: [Openvpn-devel] Bugreport: FIX for previously reported get_default
 gateway bug (demo patch included)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020101040407070600020500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I have written a patch for the previously reported get_default_gateway
bug in openvpn. The patch applies to 2.0.7 and fixes ONLY the linux
code and the windows code, though I have NOT tested the windows code.
The linux code works fine for me in all my test cases. Note that due
to function prototype changes, this code will not compile on other
OSes now. Developers need to apply the changes I did for windows and
linux to the code for other OSes and since my code is rather hackish,
they surely can improve it.


Basically I return the iface now as well from get_default_gateway and
I have modified the according route structures to contain this
variable as well, here is some example output on Linux with a normal
gateway situation, and a zero gateway through tun0 situation:

Fri Jul  7 23:19:30 2006 us=52669 GDG: route[1]
192.168.1.0/255.255.255.0/0.0.0.0 m=2000
Fri Jul  7 23:19:30 2006 us=52688 GDG: route[2]
127.0.0.0/255.0.0.0/0.0.0.0 m=0
Fri Jul  7 23:19:30 2006 us=52705 GDG: route[3]
0.0.0.0/0.0.0.0/192.168.1.1 m=2000
Fri Jul  7 23:19:30 2006 us=52723 GDG: best=192.168.1.1[3] lm=2000
Fri Jul  7 23:19:30 2006 us=52741 ROUTE: default_gateway=192.168.1.1
default_gateway_iface=wlan0

and here with tun0 and * as gw:

Fri Jul  7 22:13:48 2006 us=714642 GDG: route[1]
134.96.12.2/255.255.255.255/192.168.1.1 m=0
Fri Jul  7 22:13:48 2006 us=714661 GDG: route[2]
192.168.1.0/255.255.255.0/0.0.0.0 m=2000
Fri Jul  7 22:13:48 2006 us=714678 GDG: route[3]
127.0.0.0/255.0.0.0/0.0.0.0 m=0
Fri Jul  7 22:13:48 2006 us=714694 GDG: route[4]
0.0.0.0/0.0.0.0/0.0.0.0 m=0
Fri Jul  7 22:13:48 2006 us=714719 GDG: best=0.0.0.0[4] lm=0
Fri Jul  7 22:13:48 2006 us=714737 ROUTE: default_gateway=0.0.0.0
default_gateway_iface=tun0

After that, openvpn sets properly my hosts with tun0 and * as default
route. :)

I attached the patch, please review and improve it, and include it in
the main release if it is stable. Some windows user could maybe
compile it and see if it works as well under windows :)


Cheers


- --

Christian Holler
System Administrator

Chair of Prof. Dr. W.J. Paul
Saarland University
Germany
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErtFaJQIKXnJyDxURAosmAJ9VvlYfbRM/Z9ljxtDVC7Engj4I4wCeOf6m
oJI9LfkLiw5Qq8nYRRltGHA=
=sEb8
-----END PGP SIGNATURE-----


--------------020101040407070600020500
Content-Type: text/plain;
 name="route.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="route.patch"

diff -Naur openvpn-2.0.7/route.c openvpn-2.0.7.new/route.c
--- openvpn-2.0.7/route.c	2006-07-07 23:24:00.000000000 +0200
+++ openvpn-2.0.7.new/route.c	2006-07-07 23:24:09.000000000 +0200
@@ -45,7 +45,7 @@
 
 static void add_route (struct route *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
 static void delete_route (const struct route *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
-static bool get_default_gateway (in_addr_t *ret);
+static bool get_default_gateway (in_addr_t *ret, char *iface_out);
 
 struct route_option_list *
 new_route_option_list (struct gc_arena *a)
@@ -104,6 +104,7 @@
 get_special_addr (const struct route_special_addr *spec,
 		  const char *string,
 		  in_addr_t *out,
+		  char *out_iface,
 		  bool *status)
 {
   *status = true;
@@ -120,8 +121,10 @@
     }
   else if (!strcmp (string, "net_gateway"))
     {
-      if (spec->net_gateway_defined)
+      if (spec->net_gateway_defined) {
 	*out = spec->net_gateway;
+	strncpy(out_iface, spec->net_gateway_iface, IFACE_LEN);
+	}
       else
 	{
 	  msg (M_INFO, PACKAGE_NAME " ROUTE: net_gateway undefined -- unable to get default gateway from system");
@@ -161,7 +164,7 @@
       goto fail;
     }
   
-  if (!get_special_addr (spec, ro->network, &r->network, &status))
+  if (!get_special_addr (spec, ro->network, &r->network, NULL, &status))
     {
       r->network = getaddr (
 			    GETADDR_RESOLVE
@@ -197,7 +200,7 @@
 
   if (is_route_parm_defined (ro->gateway))
     {
-      if (!get_special_addr (spec, ro->gateway, &r->gateway, &status))
+      if (!get_special_addr (spec, ro->gateway, &r->gateway, r->iface, &status))
 	{
 	  r->gateway = getaddr (
 				GETADDR_RESOLVE
@@ -208,6 +211,9 @@
 				&status,
 				NULL);
 	}
+      else
+	r->iface_defined = true;
+	
       if (!status)
 	goto fail;
     }
@@ -298,11 +304,11 @@
       rl->spec.remote_host_defined = true;
     }
 
-  rl->spec.net_gateway_defined = get_default_gateway (&rl->spec.net_gateway);
+  rl->spec.net_gateway_defined = get_default_gateway (&rl->spec.net_gateway, rl->spec.net_gateway_iface);
   if (rl->spec.net_gateway_defined)
     {
       setenv_route_addr (es, "net_gateway", rl->spec.net_gateway, -1);
-      dmsg (D_ROUTE_DEBUG, "ROUTE: default_gateway=%s", print_in_addr_t (rl->spec.net_gateway, 0, &gc));
+      dmsg (D_ROUTE_DEBUG, "ROUTE: default_gateway=%s default_gateway_iface=%s", print_in_addr_t (rl->spec.net_gateway, 0, &gc), rl->spec.net_gateway_iface);
     }
   else
     {
@@ -678,20 +684,26 @@
 
 #if defined(TARGET_LINUX)
 #ifdef CONFIG_FEATURE_IPROUTE
-  buf_printf (&buf, IPROUTE_PATH " route add %s/%d via %s",
+  buf_printf (&buf, IPROUTE_PATH " route add %s/%d ",
 	      network,
-	      count_netmask_bits(netmask),
-	      gateway);
+	      count_netmask_bits(netmask));
+  if (r->gateway)
+    buf_printf (&buf, " via %s", gateway);
   if (r->metric_defined)
     buf_printf (&buf, " metric %d", r->metric);
+  if (r->iface_defined)
+    buf_printf (&buf, " dev %s", r->iface);
 
 #else
-  buf_printf (&buf, ROUTE_PATH " add -net %s netmask %s gw %s",
+  buf_printf (&buf, ROUTE_PATH " add -net %s netmask %s",
 	      network,
-	      netmask,
-	      gateway);
+	      netmask);
+  if (r->gateway)
+    buf_printf (&buf, " gw %s", gateway);
   if (r->metric_defined)
     buf_printf (&buf, " metric %d", r->metric);
+  if (r->iface_defined)
+    buf_printf (&buf, " dev %s", r->iface);
 #endif  /*CONFIG_FEATURE_IPROUTE*/
   msg (D_ROUTE, "%s", BSTR (&buf));
   status = system_check (BSTR (&buf), es, 0, "ERROR: Linux route add command failed");
@@ -1014,7 +1026,7 @@
 }
 
 static bool
-get_default_gateway (in_addr_t *gateway)
+get_default_gateway (in_addr_t *gateway, char *ret_iface)
 {
   struct gc_arena gc = gc_new ();
   int i;
@@ -1033,6 +1045,8 @@
       const in_addr_t mask = ntohl (row->dwForwardMask);
       const in_addr_t gw = ntohl (row->dwForwardNextHop);
       const DWORD metric = row->dwForwardMetric1;
+      char iface[IFACE_LEN];
+      snprintf(iface, IFACE_LEN - 1, "%d", row->dwForwardIfIndex);
 
       msg (D_ROUTE_DEBUG, "GDG: route[%d] %s %s %s m=%u",
 	   i,
@@ -1044,6 +1058,7 @@
       if (!net && !mask && metric < lowest_metric)
 	{
 	  ret = gw;
+	  snprintf(ret_iface, iface, IFACE_LEN - 1);
 	  lowest_metric = metric;
 	  best = i;
 	}
@@ -1052,9 +1067,9 @@
  done:
   gc_free (&gc);
 
-  if (ret)
+  if (best >= 0)
     {
-      dmsg (D_ROUTE_DEBUG, "GDGR: best=%d lm=%u", best, (unsigned int)lowest_metric);
+      dmsg (D_ROUTE_DEBUG, "GDGR: best=%d lm=%u iface=%s", best, (unsigned int)lowest_metric, ret_iface);
       *gateway = ret;
       return true;
     }
@@ -1113,7 +1128,11 @@
   struct gc_arena gc = gc_new ();
   bool ret = false;
   DWORD status;
-  const DWORD if_index = windows_route_find_if_index (r, tt);  
+  DWORD if_index;
+  if (r->iface_defined)
+    if_index = DWORD(atoi(r->iface))
+  else
+    if_index = windows_route_find_if_index (r, tt);
 
   if (if_index != ~0)
     {
@@ -1242,7 +1261,7 @@
 #elif defined(TARGET_LINUX)
 
 static bool
-get_default_gateway (in_addr_t *gateway)
+get_default_gateway (in_addr_t *gateway, char *iface)
 {
   struct gc_arena gc = gc_new ();
   bool ret = false;
@@ -1251,9 +1270,10 @@
     {
       char line[256];
       int count = 0;
-      int best_count = 0;
+      int best_count = -1;
       unsigned int lowest_metric = ~0;
       in_addr_t best_gw = 0;
+      char best_iface[IFACE_LEN];
       while (fgets (line, sizeof (line), fp) != NULL)
 	{
 	  if (count)
@@ -1262,12 +1282,14 @@
 	      unsigned int mask_x = 0;
 	      unsigned int gw_x = 0;
 	      unsigned int metric = 0;
-	      const int np = sscanf (line, "%*s\t%x\t%x\t%*s\t%*s\t%*s\t%d\t%x",
+	      char iface_x[IFACE_LEN];
+	      const int np = sscanf (line, "%10s\t%x\t%x\t%*s\t%*s\t%*s\t%d\t%x",
+				     &iface_x,
 				     &net_x,
 				     &gw_x,
 				     &metric,
 				     &mask_x);
-	      if (np == 4)
+	      if (np == 5)
 		{
 		  const in_addr_t net = ntohl (net_x);
 		  const in_addr_t mask = ntohl (mask_x);
@@ -1283,6 +1305,7 @@
 		  if (!net && !mask && metric < lowest_metric)
 		    {
 		      best_gw = gw;
+		      strncpy(best_iface, iface_x, IFACE_LEN);
 		      lowest_metric = metric;
 		      best_count = count;
 		    }
@@ -1292,9 +1315,10 @@
 	}
       fclose (fp);
 
-      if (best_gw)
+      if (best_count >= 0)
 	{
 	  *gateway = best_gw;
+	  strncpy(iface, best_iface, IFACE_LEN);
 	  ret = true;
 	}
 
diff -Naur openvpn-2.0.7/route.h openvpn-2.0.7.new/route.h
--- openvpn-2.0.7/route.h	2006-07-07 23:24:00.000000000 +0200
+++ openvpn-2.0.7.new/route.h	2006-07-07 23:24:09.000000000 +0200
@@ -33,6 +33,7 @@
 #include "misc.h"
 
 #define MAX_ROUTES 100
+#define IFACE_LEN 16
 
 #ifdef WIN32
 /*
@@ -53,6 +54,7 @@
   in_addr_t remote_endpoint;
   bool remote_endpoint_defined;
   in_addr_t net_gateway;
+  char net_gateway_iface[IFACE_LEN];
   bool net_gateway_defined;
   in_addr_t remote_host;
   bool remote_host_defined;
@@ -81,6 +83,8 @@
   in_addr_t gateway;
   bool metric_defined;
   int metric;
+  bool iface_defined;
+  char iface[IFACE_LEN];
 };
 
 struct route_list {

--------------020101040407070600020500--

