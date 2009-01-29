Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 29 Jan 2009 12:15:53 +0100
Message-ID: <499929A843E2C541A8AD31A881A2B6A202DAB58F@...1006...>
From: "David Balazic" <David.Balazic@...1005...>
Subject: [Openvpn-devel] [PATCH] Fix for "Cannot read current default
	gateway" problem on Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi!

I'm resending this patch. Originally I sent it here [1].

In short:
In the diff (agains 2.1_rc15) is the solution for the old*
problem of (not) detecting default gateway on linux systems
if it is a device route.

It was tested by one affected user (Antonis Tsolomitis, see the
thread "openvpn and ppp" on the openvpn-users list). Successfully.

If I forgot anything, ask.

Regards,
David

*See mail list threads:
"Redirect-gateway on dialup"
 <http://thread.gmane.org/gmane.network.openvpn.user/20407>
"redirect-gateway + http-proxy + ppp problem"
 <http://thread.gmane.org/gmane.network.openvpn.user/20994>
"Cannot redirect gateway after pppd connection"
 <http://thread.gmane.org/gmane.network.openvpn.user/23972>
"openvpn and ppp"
 <http://thread.gmane.org/gmane.network.openvpn.user/25117>


[1]: http://article.gmane.org/gmane.network.openvpn.devel/2472


The patch:

diff -u -r openvpn-2.1_rc15/route.c openvpn-2.1_rc15_gwfix/route.c
--- openvpn-2.1_rc15/route.c	2008-11-17 00:48:04.000000000 +0000
+++ openvpn-2.1_rc15_gwfix/route.c	2008-12-18 19:59:36.455394121 +0000
@@ -371,7 +371,7 @@
       rl->spec.default_metric_defined =3D true;
     }
=20
-  rl->spec.net_gateway_defined =3D get_default_gateway (&rl->spec.net_gate=
way, NULL);
+  rl->spec.net_gateway_defined =3D get_default_gateway (&rl->spec.net_gate=
way, NULL, rl->spec.net_gateway_ifname);
   if (rl->spec.net_gateway_defined)
     {
       setenv_route_addr (es, "net_gateway", rl->spec.net_gateway, -1);
@@ -440,6 +440,7 @@
 add_route3 (in_addr_t network,
 	    in_addr_t netmask,
 	    in_addr_t gateway,
+	    char * gateway_ifname,
 	    const struct tuntap *tt,
 	    unsigned int flags,
 	    const struct env_set *es)
@@ -450,6 +451,7 @@
   r.network =3D network;
   r.netmask =3D netmask;
   r.gateway =3D gateway;
+  r.gateway_ifname =3D gateway_ifname;
   add_route (&r, tt, flags, es);
 }
=20
@@ -473,6 +475,7 @@
 static void
 add_bypass_routes (struct route_bypass *rb,
 		   in_addr_t gateway,
+		   char * gateway_ifname,
 		   const struct tuntap *tt,
 		   unsigned int flags,
 		   const struct env_set *es)
@@ -484,6 +487,7 @@
 	add_route3 (rb->bypass[i],
 		    ~0,
 		    gateway,
+		    gateway_ifname,
 		    tt,
 		    flags,
 		    es);
@@ -536,12 +540,13 @@
 	    add_route3 (rl->spec.remote_host,
 			~0,
 			rl->spec.net_gateway,
+			rl->spec.net_gateway_ifname,
 			tt,
 			flags,
 			es);
=20
 	  /* route DHCP/DNS server traffic through original default gateway */
-	  add_bypass_routes (&rl->spec.bypass, rl->spec.net_gateway, tt, flags, e=
s);
+	  add_bypass_routes (&rl->spec.bypass, rl->spec.net_gateway, rl->spec.net=
_gateway_ifname, tt, flags, es);
=20
 	  if (rl->flags & RG_DEF1)
 	    {
@@ -549,6 +554,7 @@
 	      add_route3 (0x00000000,
 			  0x80000000,
 			  rl->spec.remote_endpoint,
+			  NULL,
 			  tt,
 			  flags,
 			  es);
@@ -557,6 +563,7 @@
 	      add_route3 (0x80000000,
 			  0x80000000,
 			  rl->spec.remote_endpoint,
+			  NULL,
 			  tt,
 			  flags,
 			  es);
@@ -575,6 +582,7 @@
 	      add_route3 (0,
 			  0,
 			  rl->spec.remote_endpoint,
+			  NULL,
 			  tt,
 			  flags,
 			  es);
@@ -635,6 +643,7 @@
 	  add_route3 (0,
 		      0,
 		      rl->spec.net_gateway,
+		      rl->spec.net_gateway_ifname,
 		      tt,
 		      flags,
 		      es);
@@ -805,20 +814,26 @@
=20
 #if defined(TARGET_LINUX)
 #ifdef CONFIG_FEATURE_IPROUTE
-  argv_printf (&argv, "%s route add %s/%d via %s",
+  argv_printf (&argv, "%s route add %s/%d",
   	      iproute_path,
 	      network,
-	      count_netmask_bits(netmask),
-	      gateway);
+	      count_netmask_bits(netmask));
+  if (r->gateway)
+    argv_printf_cat (&argv, "via %s", gateway);
+  else
+    argv_printf_cat (&argv, "dev %s", r->gateway_ifname);
   if (r->metric_defined)
     argv_printf_cat (&argv, "metric %d", r->metric);
=20
 #else
-  argv_printf (&argv, "%s add -net %s netmask %s gw %s",
+  argv_printf (&argv, "%s add -net %s netmask %s",
 		ROUTE_PATH,
 	      network,
-	      netmask,
-	      gateway);
+	      netmask);
+  if (r->gateway)
+    argv_printf_cat (&argv, "gw %s", gateway);
+  else
+    argv_printf_cat (&argv, "dev %s", r->gateway_ifname);
   if (r->metric_defined)
     argv_printf_cat (&argv, "metric %d", r->metric);
 #endif  /*CONFIG_FEATURE_IPROUTE*/
@@ -1253,7 +1268,7 @@
 }
=20
 bool
-get_default_gateway (in_addr_t *gw, in_addr_t *netmask)
+get_default_gateway (in_addr_t *gw, in_addr_t *netmask, char *gw_ifname)
 {
   struct gc_arena gc =3D gc_new ();
   bool ret_bool =3D false;
@@ -1475,7 +1490,7 @@
 #elif defined(TARGET_LINUX)
=20
 bool
-get_default_gateway (in_addr_t *gateway, in_addr_t *netmask)
+get_default_gateway (in_addr_t *gateway, in_addr_t *netmask, char *gw_if_n=
ame)
 {
   struct gc_arena gc =3D gc_new ();
   bool ret =3D false;
@@ -1516,6 +1531,10 @@
 		  if (!net && !mask && metric < lowest_metric)
 		    {
 		      best_gw =3D gw;
+		      if (gw_if_name)
+			{
+			  sscanf (line, "%s\t", gw_if_name);
+			}=20=20=20
 		      lowest_metric =3D metric;
 		      best_count =3D count;
 		    }
@@ -1525,7 +1544,7 @@
 	}
       fclose (fp);
=20
-      if (best_gw)
+      if (best_count)
 	{
 	  *gateway =3D best_gw;
 	  if (netmask)
@@ -1607,7 +1626,7 @@
         ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
=20
 bool
-get_default_gateway (in_addr_t *ret, in_addr_t *netmask)
+get_default_gateway (in_addr_t *ret, in_addr_t *netmask, char *gw_if_name)
 {
   struct gc_arena gc =3D gc_new ();
   int s, seq, l, pid, rtm_addrs, i;
@@ -1769,7 +1788,7 @@
         ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
=20
 bool
-get_default_gateway (in_addr_t *ret, in_addr_t *netmask)
+get_default_gateway (in_addr_t *ret, in_addr_t *netmask, char *gw_if_name)
 {
   struct gc_arena gc =3D gc_new ();
   int s, seq, l, pid, rtm_addrs, i;
@@ -1930,7 +1949,7 @@
         ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
=20
 bool
-get_default_gateway (in_addr_t *ret, in_addr_t *netmask)
+get_default_gateway (in_addr_t *ret, in_addr_t *netmask, char *gw_if_name)
 {
   struct gc_arena gc =3D gc_new ();
   int s, seq, l, rtm_addrs, i;
@@ -2034,7 +2053,7 @@
 #else
=20
 bool
-get_default_gateway (in_addr_t *ret, in_addr_t *netmask)
+get_default_gateway (in_addr_t *ret, in_addr_t *netmask, char *gw_ifname)
 {
   return false;
 }
@@ -2152,7 +2171,7 @@
   in_addr_t gwip =3D 0;
   bool ret =3D false;
=20
-  if (!get_default_gateway (&gwip, NULL))
+  if (!get_default_gateway (&gwip, NULL, NULL))
     {
       msg (M_WARN, "GDGMA: get_default_gateway failed");
       goto err;
@@ -2249,7 +2268,7 @@
   DWORD a_index;
   const IP_ADAPTER_INFO *ai;
=20
-  if (!get_default_gateway (&gwip, NULL))
+  if (!get_default_gateway (&gwip, NULL, NULL))
     {
       msg (M_WARN, "GDGMA: get_default_gateway failed");
       goto err;
diff -u -r openvpn-2.1_rc15/route.h openvpn-2.1_rc15_gwfix/route.h
--- openvpn-2.1_rc15/route.h	2008-10-06 07:22:20.000000000 +0000
+++ openvpn-2.1_rc15_gwfix/route.h	2008-12-18 18:29:54.996393885 +0000
@@ -61,6 +61,7 @@
   in_addr_t remote_endpoint;
   bool remote_endpoint_defined;
   in_addr_t net_gateway;
+  char net_gateway_ifname[32];
   bool net_gateway_defined;
   in_addr_t remote_host;
   bool remote_host_defined;
@@ -95,6 +96,7 @@
   in_addr_t network;
   in_addr_t netmask;
   in_addr_t gateway;
+  char * gateway_ifname;
   bool metric_defined;
   int metric;
 };
@@ -156,7 +158,7 @@
=20
 bool is_special_addr (const char *addr_str);
=20
-bool get_default_gateway (in_addr_t *ip, in_addr_t *netmask);
+bool get_default_gateway (in_addr_t *ip, in_addr_t *netmask, char *gw_if_n=
ame);
=20
 #if AUTO_USERID
 bool get_default_gateway_mac_addr (unsigned char *macaddr);
diff -u -r openvpn-2.1_rc15/tun.c openvpn-2.1_rc15_gwfix/tun.c
--- openvpn-2.1_rc15/tun.c	2008-11-17 00:48:04.000000000 +0000
+++ openvpn-2.1_rc15_gwfix/tun.c	2008-12-18 11:26:07.951394102 +0000
@@ -274,7 +274,7 @@
   in_addr_t lan_gw =3D 0;
   in_addr_t lan_netmask =3D 0;
=20
-  if (get_default_gateway (&lan_gw, &lan_netmask))
+  if (get_default_gateway (&lan_gw, &lan_netmask, NULL))
     {
       const in_addr_t lan_network =3D lan_gw & lan_netmask;=20
       const in_addr_t network =3D ip & netmask;
@@ -301,7 +301,7 @@
   in_addr_t lan_gw =3D 0;
   in_addr_t lan_netmask =3D 0;
=20
-  if (get_default_gateway (&lan_gw, &lan_netmask))
+  if (get_default_gateway (&lan_gw, &lan_netmask, NULL))
     {
       const in_addr_t lan_network =3D lan_gw & lan_netmask;=20
       if (lan_network =3D=3D 0xC0A80000 || lan_network =3D=3D 0xC0A80100)

---------------------------------------------------------------------
http://www.nosoftwarepatents.com         Innovation, not litigation !
---
David Bala=BEic                 mailto:david.balazic@...1005...
HERMES Softlab                http://www.hermes-softlab.com
Zagrebska cesta 104           Phone: +386 2 450 8947=20
SI-2000 Maribor
Slovenija
---------------------------------------------------------------------
"Be excellent to each other." -
Bill S. Preston, Esq. & "Ted" Theodore Logan
---------------------------------------------------------------------

