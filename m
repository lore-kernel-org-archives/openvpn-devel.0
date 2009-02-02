Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Mon, 2 Feb 2009 10:49:50 +0100
Message-ID: <499929A843E2C541A8AD31A881A2B6A202DF38BE@...1006...>
From: "David Balazic" <David.Balazic@...1005...>
Subject: Re: [Openvpn-devel] [PATCH] Fix for "Cannot read current default
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

diff -u openvpn_trunk/route.c openvpn_patched/route.c
--- openvpn_trunk/route.c	2009-01-29 15:00:04.525034400 +0100
+++ openvpn_patched/route.c	2009-01-29 15:03:41.116012000 +0100
@@ -45,7 +45,7 @@
=20
 static void add_route (struct route *r, const struct tuntap *tt, unsigned =
int flags, const struct env_set *es);
 static void delete_route (const struct route *r, const struct tuntap *tt, =
unsigned int flags, const struct env_set *es);
-static bool get_default_gateway (in_addr_t *ret);
+static bool get_default_gateway (in_addr_t *ret, char *gw_if_name);
=20
 struct route_option_list *
 new_route_option_list (struct gc_arena *a)
@@ -298,7 +298,7 @@
       rl->spec.remote_host_defined =3D true;
     }
=20
-  rl->spec.net_gateway_defined =3D get_default_gateway (&rl->spec.net_gate=
way);
+  rl->spec.net_gateway_defined =3D get_default_gateway (&rl->spec.net_gate=
way, rl->spec.net_gateway_ifname);
   if (rl->spec.net_gateway_defined)
     {
       setenv_route_addr (es, "net_gateway", rl->spec.net_gateway, -1);
@@ -362,6 +362,7 @@
 add_route3 (in_addr_t network,
 	    in_addr_t netmask,
 	    in_addr_t gateway,
+	    char * gateway_ifname,
 	    const struct tuntap *tt,
 	    unsigned int flags,
 	    const struct env_set *es)
@@ -372,6 +373,7 @@
   r.network =3D network;
   r.netmask =3D netmask;
   r.gateway =3D gateway;
+  r.gateway_ifname =3D gateway_ifname;
   add_route (&r, tt, flags, es);
 }
=20
@@ -418,6 +420,7 @@
 	    add_route3 (rl->spec.remote_host,
 			~0,
 			rl->spec.net_gateway,
+			rl->spec.net_gateway_ifname,
 			tt,
 			flags,
 			es);
@@ -428,6 +431,7 @@
 	      add_route3 (0x00000000,
 			  0x80000000,
 			  rl->spec.remote_endpoint,
+			  NULL,
 			  tt,
 			  flags,
 			  es);
@@ -436,6 +440,7 @@
 	      add_route3 (0x80000000,
 			  0x80000000,
 			  rl->spec.remote_endpoint,
+			  NULL,
 			  tt,
 			  flags,
 			  es);
@@ -454,6 +459,7 @@
 	      add_route3 (0,
 			  0,
 			  rl->spec.remote_endpoint,
+			  NULL,
 			  tt,
 			  flags,
 			  es);
@@ -511,6 +517,7 @@
 	  add_route3 (0,
 		      0,
 		      rl->spec.net_gateway,
+		      rl->spec.net_gateway_ifname,
 		      tt,
 		      flags,
 		      es);
@@ -678,18 +685,24 @@
=20
 #if defined(TARGET_LINUX)
 #ifdef CONFIG_FEATURE_IPROUTE
-  buf_printf (&buf, IPROUTE_PATH " route add %s/%d via %s",
+  buf_printf (&buf, IPROUTE_PATH " route add %s/%d",
 	      network,
-	      count_netmask_bits(netmask),
-	      gateway);
+	      count_netmask_bits(netmask));
+  if (r->gateway)
+    argv_printf_cat (&argv, "via %s", gateway);
+  else
+    argv_printf_cat (&argv, "dev %s", r->gateway_ifname);
   if (r->metric_defined)
     buf_printf (&buf, " metric %d", r->metric);
=20
 #else
-  buf_printf (&buf, ROUTE_PATH " add -net %s netmask %s gw %s",
+  buf_printf (&buf, ROUTE_PATH " add -net %s netmask %s",
 	      network,
-	      netmask,
-	      gateway);
+	      netmask);
+  if (r->gateway)
+    argv_printf_cat (&argv, "gw %s", gateway);
+  else
+    argv_printf_cat (&argv, "dev %s", r->gateway_ifname);
   if (r->metric_defined)
     buf_printf (&buf, " metric %d", r->metric);
 #endif  /*CONFIG_FEATURE_IPROUTE*/
@@ -1014,7 +1027,7 @@
 }
=20
 static bool
-get_default_gateway (in_addr_t *gateway)
+get_default_gateway (in_addr_t *gateway, char *gw_ifname)
 {
   struct gc_arena gc =3D gc_new ();
   int i;
@@ -1242,7 +1255,7 @@
 #elif defined(TARGET_LINUX)
=20
 static bool
-get_default_gateway (in_addr_t *gateway)
+get_default_gateway (in_addr_t *gateway, char *gw_if_name)
 {
   struct gc_arena gc =3D gc_new ();
   bool ret =3D false;
@@ -1283,6 +1296,10 @@
 		  if (!net && !mask && metric < lowest_metric)
 		    {
 		      best_gw =3D gw;
+		      if (gw_if_name)
+				{
+		    	  sscanf (line, "%" IFNAME_MAXLEN_STR "s\t", gw_if_name);
+				}
 		      lowest_metric =3D metric;
 		      best_count =3D count;
 		    }
@@ -1292,7 +1309,7 @@
 	}
       fclose (fp);
=20
-      if (best_gw)
+      if (best_count)
 	{
 	  *gateway =3D best_gw;
 	  ret =3D true;
@@ -1370,7 +1387,7 @@
         ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
=20
 static bool
-get_default_gateway (in_addr_t *ret)
+get_default_gateway (in_addr_t *ret, char *gw_if_name)
 {
   struct gc_arena gc =3D gc_new ();
   int s, seq, l, pid, rtm_addrs, i;
@@ -1527,7 +1544,7 @@
         ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
=20
 static bool
-get_default_gateway (in_addr_t *ret)
+get_default_gateway (in_addr_t *ret, char *gw_if_name)
 {
   struct gc_arena gc =3D gc_new ();
   int s, seq, l, pid, rtm_addrs, i;
@@ -1683,7 +1700,7 @@
         ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
=20
 static bool
-get_default_gateway (in_addr_t *ret)
+get_default_gateway (in_addr_t *ret, char *gw_if_name)
 {
   struct gc_arena gc =3D gc_new ();
   int s, seq, l, rtm_addrs, i;
@@ -1782,7 +1799,7 @@
 #else
=20
 static bool
-get_default_gateway (in_addr_t *ret)
+get_default_gateway (in_addr_t *ret, char *gw_if_name)
 {
   return false;
 }
diff -u openvpn_trunk/route.h openvpn_patched/route.h
--- openvpn_trunk/route.h	2009-01-29 15:00:04.650032800 +0100
+++ openvpn_patched/route.h	2009-01-29 15:03:46.100323200 +0100
@@ -48,11 +48,15 @@
  */
 #define ROUTE_DELETE_FIRST  2
=20
+#define IFNAME_MAXLEN 32
+#define IFNAME_MAXLEN_STR "32"
+
 struct route_special_addr
 {
   in_addr_t remote_endpoint;
   bool remote_endpoint_defined;
   in_addr_t net_gateway;
+  char net_gateway_ifname[IFNAME_MAXLEN];
   bool net_gateway_defined;
   in_addr_t remote_host;
   bool remote_host_defined;
@@ -79,6 +83,7 @@
   in_addr_t network;
   in_addr_t netmask;
   in_addr_t gateway;
+  char * gateway_ifname;
   bool metric_defined;
   int metric;
 };

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

