From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 20 Feb 2024 13:57:26 +0000
In-Reply-To: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <08e00663ec7c73d04a3f1654c6b11c30dc4fb9b9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="maGyo9MO/3o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Route: add support
 for user defined routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--maGyo9MO/3o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Route: add support for user defined routing table
......................................................................

Route: add support for user defined routing table

Add the ability for users to specify a custom
routing table where routes should be installed in.
As of now routes are always installed in the main
routing table of the operating system, however,
with the new --route-table option it is possibile
to specify the ID of the default routing table
to be used by --route(-ipv6).

The --route(-ipv6) directives have been extended
with an additional argument (5th for --route)
(4th for --route-ipv6) so that each of them
can possibly use an independent routing table.

Please note: this feature is currently supported
only by Linux/SITNL.
Support for other platforms should be added in related backends.

Fixes: Trac #1399
Change-Id: I3e4ebef484d2a04a383a65ede5617ee98bf218a7
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M doc/man-sections/vpn-network-options.rst
M src/openvpn/helper.c
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/route.c
M src/openvpn/route.h
7 files changed, 214 insertions(+), 19 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/524/2

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 41d367b..9a7ba02 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -367,6 +367,14 @@
   Like ``--redirect-gateway``, but omit actually changing the default gate=
way.
   Useful when pushing private subnets.

+--route-table id
+  Specify a default table id for use with --route.
+  By default, OpenVPN installs routes in the main routing
+  table of the operating system, but with this option,
+  a user defined routing table can be used instead.
+
+  (Supported on Linux only, on other platforms this is a no-op).
+
 --route args
   Add route to routing table after connection is established. Multiple
   routes can be specified. Routes will be automatically torn down in
@@ -379,6 +387,7 @@
       route network/IP netmask
       route network/IP netmask gateway
       route network/IP netmask gateway metric
+      route network/IP netmask gateway metric table-id

   This option is intended as a convenience proxy for the ``route``\(8)
   shell command, while at the same time providing portable semantics
@@ -394,6 +403,10 @@
   ``metric``
         default taken from ``--route-metric`` if set, otherwise :code:`0`.

+  ``table-id`` (Supported on Linux only, on other platforms this is a no-o=
p).
+        Since this option must be an entirely local choice, won't be pusha=
ble.
+	      default taken from ``--route-table`` if set, otherwise :code:`0`.
+
   The default can be specified by leaving an option blank or setting it to
   :code:`default`.
=20
@@ -441,14 +454,25 @@
   Setup IPv6 routing in the system to send the specified IPv6 network into
   OpenVPN's *tun*.

-  Valid syntax:
+  Valid syntaxes:
   ::

+     route-ipv6 ipv6addr/bits
+     route-ipv6 ipv6addr/bits [gateway]
      route-ipv6 ipv6addr/bits [gateway] [metric]
+     route-ipv6 ipv6addr/bits [gateway] [metric] [table-id]
+
+  ``gateway``
+        Only used for IPv6 routes across *tap* devices,
+        and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` =
or
+        ``--route-ipv6-gateway`` is used.

-  The gateway parameter is only used for IPv6 routes across *tap* devices,
-  and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or
-  ``--route-ipv6-gateway`` is used.
+  ``metric``
+        default taken from ``--route-metric`` if set, otherwise :code:`0`.
+
+  ``table-id`` (Supported on Linux only, on other platforms this is a no-o=
p).
+        Since this option must be an entirely local choice, won't be pusha=
ble.
+	      default taken from ``--route-table`` if set, otherwise :code:`0`.

 --route-gateway arg
   Specify a default *gateway* for use with ``--route``.
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index fa011ff..758160d 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -118,6 +118,7 @@
                              print_in_addr_t(network, 0, &o->gc),
                              print_in_addr_t(netmask, 0, &o->gc),
                              NULL,
+                             NULL,
                              NULL);
 }

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c5cc154..c24e736 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1481,6 +1481,7 @@
     const char *gw =3D NULL;
     int dev =3D dev_type_enum(options->dev, options->dev_type);
     int metric =3D 0;
+    int table_id =3D 0; /* unspec table */

     /* if DCO is enabled we have both regular routes and iroutes in the sy=
stem
      * routing table, and normal routes must have a higher metric for that=
 to
@@ -1499,6 +1500,10 @@
     {
         gw =3D options->route_default_gateway;
     }
+    if (options->route_default_table_id)
+    {
+        table_id =3D options->route_default_table_id;
+    }
     if (options->route_default_metric)
     {
         metric =3D options->route_default_metric;
@@ -1508,6 +1513,7 @@
                         options->routes,
                         gw,
                         metric,
+                        table_id,
                         link_socket_current_remote(link_socket_info),
                         es,
                         ctx))
@@ -1526,6 +1532,7 @@
 {
     const char *gw =3D NULL;
     int metric =3D -1;            /* no metric set */
+    int table_id =3D 0; /* unspec table */

     /* see explanation in do_init_route_list() */
     if (dco_enabled(options))
@@ -1544,6 +1551,11 @@
         metric =3D options->route_default_metric;
     }

+    if (options->route_default_table_id)
+    {
+        table_id =3D options->route_default_table_id;
+    }
+
     /* redirect (IPv6) gateway to VPN?  if yes, add a few more specifics
      */
     if (options->routes_ipv6->flags & RG_REROUTE_GW)
@@ -1555,7 +1567,7 @@
         {
             add_route_ipv6_to_option_list( options->routes_ipv6,
                                            string_alloc(opt_list[i], optio=
ns->routes_ipv6->gc),
-                                           NULL, NULL );
+                                           NULL, NULL, NULL );
         }
     }

@@ -1563,6 +1575,7 @@
                              options->routes_ipv6,
                              gw,
                              metric,
+                             table_id,
                              link_socket_current_remote_ipv6(link_socket_i=
nfo),
                              es,
                              ctx))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2c79a1e..0fe4595 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -201,6 +201,10 @@
     "                    pass --ifconfig parms by environment to scripts.\=
n"
     "--ifconfig-nowarn : Don't warn if the --ifconfig option on this side =
of the\n"
     "                    connection doesn't match the remote side.\n"
+#ifdef TARGET_LINUX
+    "--route-table table_id : Specify a custom routing table for use with =
--route(-ipv6).\n"
+    "                           If not specified, the id of the default ro=
uting table will be used.\n"
+#endif
     "--route network [netmask] [gateway] [metric] :\n"
     "                  Add route to routing table after connection\n"
     "                  is established.  Multiple routes can be specified.\=
n"
@@ -1909,6 +1913,7 @@
     SHOW_STR(route_script);
     SHOW_STR(route_default_gateway);
     SHOW_INT(route_default_metric);
+    SHOW_INT(route_default_table_id);
     SHOW_BOOL(route_noexec);
     SHOW_INT(route_delay);
     SHOW_INT(route_delay_window);
@@ -6981,7 +6986,16 @@
         cnol_check_alloc(options);
         add_client_nat_to_option_list(options->client_nat, p[1], p[2], p[3=
], p[4], msglevel);
     }
-    else if (streq(p[0], "route") && p[1] && !p[5])
+    else if (streq(p[0], "route-table") && p[1] && !p[2])
+    {
+#ifndef ENABLE_SITNL
+        msg(M_WARN, "NOTE: --route-table is supported only on Linux when S=
ITNL is built-in");
+#endif
+        VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);
+        options->route_default_table_id =3D positive_atoi(p[1]);
+
+    }
+    else if (streq(p[0], "route") && p[1] && !p[6])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
         rol_check_alloc(options);
@@ -7002,10 +7016,31 @@
                 msg(msglevel, "route parameter gateway '%s' must be a vali=
d address", p[3]);
                 goto err;
             }
+            /* p[4] is metric, if specified */
+
+            /* discard pulled routing table_id from server
+             * since this must be an entirely local choice */
+            if (p[5])
+            {
+                p[5] =3D NULL;
+            }
         }
-        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4]);
+        /* at the moment the routing table id is supported only by Linux/S=
ITNL */
+#ifndef ENABLE_SITNL
+        if (p[5])
+        {
+            static bool route_table_warned =3D false;
+
+            if (!route_table_warned)
+            {
+                msg(M_WARN, "NOTE: table specified for --route, but not su=
pported on this platform");
+                route_table_warned =3D true;
+            }
+        }
+#endif
+        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4], =
p[5]);
     }
-    else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
+    else if (streq(p[0], "route-ipv6") && p[1] && !p[5])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
         rol6_check_alloc(options);
@@ -7021,9 +7056,31 @@
                 msg(msglevel, "route-ipv6 parameter gateway '%s' must be a=
 valid address", p[2]);
                 goto err;
             }
-            /* p[3] is metric, if present */
+            /* p[3] is metric, if specified */
+
+            /* discard pulled routing table_id from server
+             * since this must be an entirely local choice */
+            if (p[4])
+            {
+                p[4] =3D NULL;
+            }
         }
-        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[=
3]);
+
+        /* at the moment the routing table id is supported only by Linux/S=
ITNL */
+#ifndef ENABLE_SITNL
+        if (p[4])
+        {
+            static bool route6_table_warned =3D false;
+
+            if (!route6_table_warned)
+            {
+                msg(M_WARN, "NOTE: table specified for --route-ipv6, but n=
ot supported on this platform");
+                route6_table_warned =3D true;
+            }
+        }
+#endif
+
+        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[=
3], p[4]);
     }
     else if (streq(p[0], "max-routes") && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 85de887..dced452 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -411,6 +411,7 @@
     const char *route_predown_script;
     const char *route_default_gateway;
     const char *route_ipv6_default_gateway;
+    int route_default_table_id;
     int route_default_metric;
     bool route_noexec;
     int route_delay;
@@ -741,6 +742,7 @@
 #define OPT_P_PEER_ID         (1<<28)
 #define OPT_P_INLINE          (1<<29)
 #define OPT_P_PUSH_MTU        (1<<30)
+#define OPT_P_ROUTE_TABLE     (1<<31)

 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6c027d9..e02c28a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -325,7 +325,6 @@

     CLEAR(*r);
     r->option =3D ro;
-
     /* network */

     if (!is_route_parm_defined(ro->network))
@@ -439,6 +438,27 @@

     r->flags |=3D RT_DEFINED;

+    /* routing table id */
+
+    r->table_id =3D 0;
+    if (ro->table_id)
+    {
+        r->table_id =3D atoi(ro->table_id);
+        if (r->table_id < 0)
+        {
+            msg(M_WARN, PACKAGE_NAME "ROUTE: routing table id for network =
%s (%s) must be >=3D 0",
+                ro->network,
+                ro->table_id);
+            goto fail;
+        }
+        r->flags |=3D RT_TABLE_DEFINED;
+    }
+    else if (rl->spec.flags & RTSA_DEFAULT_TABLE_ID)
+    {
+        r->table_id =3D rl->spec.table_id;
+        r->flags |=3D RT_TABLE_DEFINED;
+    }
+
     return true;

 fail:
@@ -495,6 +515,27 @@

     r6->flags |=3D RT_DEFINED;

+    /* routing table id */
+
+    r6->table_id =3D 0;
+    if (r6o->table_id)
+    {
+        r6->table_id =3D atoi(r6o->table_id);
+        if (r6->table_id < 0)
+        {
+            msg(M_WARN, PACKAGE_NAME "ROUTE: routing table id for network =
%s (%s) must be >=3D 0",
+                r6o->prefix,
+                r6o->table_id);
+            goto fail;
+        }
+        r6->flags |=3D RT_TABLE_DEFINED;
+    }
+    else if (rl6->spec_flags & RTSA_DEFAULT_TABLE_ID)
+    {
+        r6->table_id =3D rl6->default_route_table_id;
+        r6->flags |=3D RT_TABLE_DEFINED;
+    }
+
     return true;

 fail:
@@ -508,7 +549,8 @@
                          const char *network,
                          const char *netmask,
                          const char *gateway,
-                         const char *metric)
+                         const char *metric,
+                         const char *table_id)
 {
     struct route_option *ro;
     ALLOC_OBJ_GC(ro, struct route_option, l->gc);
@@ -516,6 +558,7 @@
     ro->netmask =3D netmask;
     ro->gateway =3D gateway;
     ro->metric =3D metric;
+    ro->table_id =3D table_id;
     ro->next =3D l->routes;
     l->routes =3D ro;

@@ -525,13 +568,15 @@
 add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,
                               const char *prefix,
                               const char *gateway,
-                              const char *metric)
+                              const char *metric,
+                              const char *table_id)
 {
     struct route_ipv6_option *ro;
     ALLOC_OBJ_GC(ro, struct route_ipv6_option, l->gc);
     ro->prefix =3D prefix;
     ro->gateway =3D gateway;
     ro->metric =3D metric;
+    ro->table_id =3D table_id;
     ro->next =3D l->routes_ipv6;
     l->routes_ipv6 =3D ro;
 }
@@ -630,6 +675,7 @@
                 const struct route_option_list *opt,
                 const char *remote_endpoint,
                 int default_metric,
+                int table_id,
                 in_addr_t remote_host,
                 struct env_set *es,
                 openvpn_net_ctx_t *ctx)
@@ -653,6 +699,12 @@
         rl->spec.flags |=3D RTSA_DEFAULT_METRIC;
     }

+    if (table_id)
+    {
+        rl->spec.table_id =3D table_id;
+        rl->spec.flags |=3D RTSA_DEFAULT_TABLE_ID;
+    }
+
     get_default_gateway(&rl->rgi, ctx);
     if (rl->rgi.flags & RGI_ADDR_DEFINED)
     {
@@ -786,6 +838,7 @@
                      const struct route_ipv6_option_list *opt6,
                      const char *remote_endpoint,
                      int default_metric,
+                     int table_id,
                      const struct in6_addr *remote_host_ipv6,
                      struct env_set *es,
                      openvpn_net_ctx_t *ctx)
@@ -810,6 +863,12 @@
         rl6->spec_flags |=3D RTSA_DEFAULT_METRIC;
     }

+    if (table_id)
+    {
+        rl6->default_route_table_id =3D table_id;
+        rl6->spec_flags |=3D RTSA_DEFAULT_TABLE_ID;
+    }
+
     msg(D_ROUTE, "GDG6: remote_host_ipv6=3D%s",
         remote_host_ipv6 ?  print_in6_addr(*remote_host_ipv6, 0, &gc) : "n=
/a" );

@@ -1602,9 +1661,15 @@
         metric =3D r->metric;
     }

+    int table_id =3D 0;
+    if (r->flags & RT_TABLE_DEFINED)
+    {
+        table_id =3D r->table_id;
+    }
+
     status =3D RTA_SUCCESS;
     int ret =3D net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->=
netmask),
-                               &r->gateway, iface, 0, metric);
+                               &r->gateway, iface, table_id, metric);
     if (ret =3D=3D -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed because route e=
xists");
@@ -1982,10 +2047,16 @@
         metric =3D r6->metric;
     }

+    int table_id =3D 0;
+    if ((r6->flags & RT_TABLE_DEFINED) && (r6->table_id > 0))
+    {
+        table_id =3D r6->table_id;
+    }
+
     status =3D RTA_SUCCESS;
     int ret =3D net_route_v6_add(ctx, &r6->network, r6->netbits,
                                gateway_needed ? &r6->gateway : NULL,
-                               device, 0, metric);
+                               device, table_id, metric);
     if (ret =3D=3D -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed because route e=
xists");
@@ -2190,8 +2261,14 @@
         metric =3D r->metric;
     }

+    int table_id =3D 0;
+    if (r->flags & RT_TABLE_DEFINED)
+    {
+        table_id =3D r->table_id;
+    }
+
     if (net_route_v4_del(ctx, &r->network, netmask_to_netbits2(r->netmask),
-                         &r->gateway, NULL, 0, metric) < 0)
+                         &r->gateway, NULL, table_id, metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route delete command failed");
     }
@@ -2403,8 +2480,16 @@
         metric =3D r6->metric;
     }

+    int table_id =3D 0;
+    if (r6->flags & RT_TABLE_DEFINED)
+    {
+        table_id =3D r6->table_id;
+    }
+
+
+
     if (net_route_v6_del(ctx, &r6->network, r6->netbits,
-                         gateway_needed ? &r6->gateway : NULL, device, 0,
+                         gateway_needed ? &r6->gateway : NULL, device, tab=
le_id,
                          metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route v6 delete command failed");
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 71b4cf4..ab7eaa4 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -63,12 +63,14 @@
 #define RTSA_REMOTE_ENDPOINT  (1<<0)
 #define RTSA_REMOTE_HOST      (1<<1)
 #define RTSA_DEFAULT_METRIC   (1<<2)
+#define RTSA_DEFAULT_TABLE_ID (1<<3)
     unsigned int flags;

     in_addr_t remote_endpoint;
     in_addr_t remote_host;
     int remote_host_local; /* TLA_x value */
     struct route_bypass bypass;
+    int table_id;
     int default_metric;
 };

@@ -77,6 +79,7 @@
     const char *network;
     const char *netmask;
     const char *gateway;
+    const char *table_id;
     const char *metric;
 };

@@ -92,6 +95,7 @@

 struct route_option_list {
     unsigned int flags; /* RG_x flags */
+
     struct route_option *routes;
     struct gc_arena *gc;
 };
@@ -101,6 +105,7 @@
     const char *prefix;         /* e.g. "2001:db8:1::/64" */
     const char *gateway;        /* e.g. "2001:db8:0::2" */
     const char *metric;         /* e.g. "5" */
+    const char *table_id;
 };

 struct route_ipv6_option_list {
@@ -113,12 +118,14 @@
 #define RT_DEFINED        (1<<0)
 #define RT_ADDED          (1<<1)
 #define RT_METRIC_DEFINED (1<<2)
+#define RT_TABLE_DEFINED  (1<<3)
     struct route_ipv4 *next;
     unsigned int flags;
     const struct route_option *option;
     in_addr_t network;
     in_addr_t netmask;
     in_addr_t gateway;
+    int table_id;
     int metric;
 };

@@ -129,6 +136,7 @@
     unsigned int netbits;
     struct in6_addr gateway;
     int metric;
+    int table_id;
     /* gateway interface */
 #ifdef _WIN32
     DWORD adapter_index;        /* interface or ~0 if undefined */
@@ -223,6 +231,7 @@
     struct in6_addr remote_endpoint_ipv6; /* inside tun */
     struct in6_addr remote_host_ipv6;   /* --remote address */
     int default_metric;
+    int default_route_table_id;

     struct route_ipv6_gateway_info rgi6;
     unsigned int flags;                 /* RG_x flags, see route_option_li=
st */
@@ -271,17 +280,20 @@
                               const char *network,
                               const char *netmask,
                               const char *gateway,
-                              const char *metric);
+                              const char *metric,
+                              const char *table_id);

 void add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,
                                    const char *prefix,
                                    const char *gateway,
-                                   const char *metric);
+                                   const char *metric,
+                                   const char *table_id);

 bool init_route_list(struct route_list *rl,
                      const struct route_option_list *opt,
                      const char *remote_endpoint,
                      int default_metric,
+                     int table_id,
                      in_addr_t remote_host,
                      struct env_set *es,
                      openvpn_net_ctx_t *ctx);
@@ -290,6 +302,7 @@
                           const struct route_ipv6_option_list *opt6,
                           const char *remote_endpoint,
                           int default_metric,
+                          int table_id,
                           const struct in6_addr *remote_host,
                           struct env_set *es,
                           openvpn_net_ctx_t *ctx);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede5617ee98bf218a7
Gerrit-Change-Number: 524
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--maGyo9MO/3o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Route: add support for user defined routing t=
able<br><br>Add the ability for users to specify a custom<br>routing table =
where routes should be installed in.<br>As of now routes are always install=
ed in the main<br>routing table of the operating system, however,<br>with t=
he new --route-table option it is possibile<br>to specify the ID of the def=
ault routing table<br>to be used by --route(-ipv6).<br><br>The --route(-ipv=
6) directives have been extended<br>with an additional argument (5th for --=
route)<br>(4th for --route-ipv6) so that each of them<br>can possibly use a=
n independent routing table.<br><br>Please note: this feature is currently =
supported<br>only by Linux/SITNL.<br>Support for other platforms should be =
added in related backends.<br><br>Fixes: Trac #1399<br>Change-Id: I3e4ebef4=
84d2a04a383a65ede5617ee98bf218a7<br>Signed-off-by: Gianmarco De Gregori &lt=
;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/vpn-network-options.=
rst<br>M src/openvpn/helper.c<br>M src/openvpn/init.c<br>M src/openvpn/opti=
ons.c<br>M src/openvpn/options.h<br>M src/openvpn/route.c<br>M src/openvpn/=
route.h<br>7 files changed, 214 insertions(+), 19 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/524/2</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/v=
pn-network-options.rst</span><br><span>index 41d367b..9a7ba02 100644</span>=
<br><span>--- a/doc/man-sections/vpn-network-options.rst</span><br><span>++=
+ b/doc/man-sections/vpn-network-options.rst</span><br><span>@@ -367,6 +367=
,14 @@</span><br><span>   Like ``--redirect-gateway``, but omit actually ch=
anging the default gateway.</span><br><span>   Useful when pushing private =
subnets.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+--route-table id</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  Specify a default table id for use with --route.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  By default, OpenVPN installs routes in=
 the main routing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
table of the operating system, but with this option,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  a user defined routing table can be use=
d instead.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  (Supported on Linux only, =
on other platforms this is a no-op).</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> --route args</span><br><span>   Add rout=
e to routing table after connection is established. Multiple</span><br><spa=
n>   routes can be specified. Routes will be automatically torn down in</sp=
an><br><span>@@ -379,6 +387,7 @@</span><br><span>       route network/IP ne=
tmask</span><br><span>       route network/IP netmask gateway</span><br><sp=
an>       route network/IP netmask gateway metric</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      route network/IP netmask gateway metric=
 table-id</span><br><span> </span><br><span>   This option is intended as a=
 convenience proxy for the ``route``\(8)</span><br><span>   shell command, =
while at the same time providing portable semantics</span><br><span>@@ -394=
,6 +403,10 @@</span><br><span>   ``metric``</span><br><span>         defaul=
t taken from ``--route-metric`` if set, otherwise :code:`0`.</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``table-id`` (=
Supported on Linux only, on other platforms this is a no-op).</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        Since this option must be=
 an entirely local choice, won&#39;t be pushable.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	      default taken from ``--route-table`` i=
f set, otherwise :code:`0`.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>   The default can be specified by leaving an opti=
on blank or setting it to</span><br><span>   :code:`default`.</span><br><sp=
an> </span><br><span>@@ -441,14 +454,25 @@</span><br><span>   Setup IPv6 ro=
uting in the system to send the specified IPv6 network into</span><br><span=
>   OpenVPN&#39;s *tun*.</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  Valid syntax:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  Valid syntaxes:</span><br><span>   ::</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     route-ipv6 ipv6=
addr/bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     route=
-ipv6 ipv6addr/bits [gateway]</span><br><span>      route-ipv6 ipv6addr/bit=
s [gateway] [metric]</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     route-ipv6 ipv6addr/bits [gateway] [metric] [table-id]</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  ``gateway``</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        Only used for IPv6 routes across *tap* devices,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        and if missin=
g, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        ``--route-ipv6-gateway`` is use=
d.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 The gateway parameter is only used for IPv6 routes across *tap* devices,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  and if missing, the `=
`ipv6remote`` field from ``--ifconfig-ipv6`` or</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  ``--route-ipv6-gateway`` is used.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  ``metric``</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        default taken from ``--route-met=
ric`` if set, otherwise :code:`0`.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``=
table-id`` (Supported on Linux only, on other platforms this is a no-op).</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Since this op=
tion must be an entirely local choice, won&#39;t be pushable.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	      default taken from ``--rou=
te-table`` if set, otherwise :code:`0`.</span><br><span> </span><br><span> =
--route-gateway arg</span><br><span>   Specify a default *gateway* for use =
with ``--route``.</span><br><span>diff --git a/src/openvpn/helper.c b/src/o=
penvpn/helper.c</span><br><span>index fa011ff..758160d 100644</span><br><sp=
an>--- a/src/openvpn/helper.c</span><br><span>+++ b/src/openvpn/helper.c</s=
pan><br><span>@@ -118,6 +118,7 @@</span><br><span>                         =
     print_in_addr_t(network, 0, &amp;o-&gt;gc),</span><br><span>          =
                    print_in_addr_t(netmask, 0, &amp;o-&gt;gc),</span><br><=
span>                              NULL,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                             NULL,</span><br><span>   =
                           NULL);</span><br><span> }</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br>=
<span>index c5cc154..c24e736 100644</span><br><span>--- a/src/openvpn/init.=
c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -1481,6 +1481=
,7 @@</span><br><span>     const char *gw =3D NULL;</span><br><span>     in=
t dev =3D dev_type_enum(options-&gt;dev, options-&gt;dev_type);</span><br><=
span>     int metric =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int table_id =3D 0; /* unspec table */</span><br><span> </span>=
<br><span>     /* if DCO is enabled we have both regular routes and iroutes=
 in the system</span><br><span>      * routing table, and normal routes mus=
t have a higher metric for that to</span><br><span>@@ -1499,6 +1500,10 @@</=
span><br><span>     {</span><br><span>         gw =3D options-&gt;route_def=
ault_gateway;</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (options-&gt;route_default_table_id)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        table_id =3D options-&gt;route_default_t=
able_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span>     if (options-&gt;route_default_metric)</span><br><span>     =
{</span><br><span>         metric =3D options-&gt;route_default_metric;</sp=
an><br><span>@@ -1508,6 +1513,7 @@</span><br><span>                        =
 options-&gt;routes,</span><br><span>                         gw,</span><br=
><span>                         metric,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        table_id,</span><br><span>     =
                    link_socket_current_remote(link_socket_info),</span><br=
><span>                         es,</span><br><span>                       =
  ctx))</span><br><span>@@ -1526,6 +1532,7 @@</span><br><span> {</span><br>=
<span>     const char *gw =3D NULL;</span><br><span>     int metric =3D -1;=
            /* no metric set */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int table_id =3D 0; /* unspec table */</span><br><span> </s=
pan><br><span>     /* see explanation in do_init_route_list() */</span><br>=
<span>     if (dco_enabled(options))</span><br><span>@@ -1544,6 +1551,11 @@=
</span><br><span>         metric =3D options-&gt;route_default_metric;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (options-&gt;route_default_table_id)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        table_id =3D options-&gt;route_default_t=
able_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* =
redirect (IPv6) gateway to VPN?  if yes, add a few more specifics</span><br=
><span>      */</span><br><span>     if (options-&gt;routes_ipv6-&gt;flags =
&amp; RG_REROUTE_GW)</span><br><span>@@ -1555,7 +1567,7 @@</span><br><span>=
         {</span><br><span>             add_route_ipv6_to_option_list( opti=
ons-&gt;routes_ipv6,</span><br><span>                                      =
      string_alloc(opt_list[i], options-&gt;routes_ipv6-&gt;gc),</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
           NULL, NULL );</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                           NULL, NULL, NULL );</span><=
br><span>         }</span><br><span>     }</span><br><span> </span><br><spa=
n>@@ -1563,6 +1575,7 @@</span><br><span>                              optio=
ns-&gt;routes_ipv6,</span><br><span>                              gw,</span=
><br><span>                              metric,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                             table_id,</span><=
br><span>                              link_socket_current_remote_ipv6(link=
_socket_info),</span><br><span>                              es,</span><br>=
<span>                              ctx))</span><br><span>diff --git a/src/=
openvpn/options.c b/src/openvpn/options.c</span><br><span>index 2c79a1e..0f=
e4595 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -201,6 +201,10 @@</span><br><s=
pan>     &quot;                    pass --ifconfig parms by environment to =
scripts.\n&quot;</span><br><span>     &quot;--ifconfig-nowarn : Don&#39;t w=
arn if the --ifconfig option on this side of the\n&quot;</span><br><span>  =
   &quot;                    connection doesn&#39;t match the remote side.\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGE=
T_LINUX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--=
route-table table_id : Specify a custom routing table for use with --route(=
-ipv6).\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&quot;                           If not specified, the id of the default ro=
uting table will be used.\n&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span>     &quot;--route network [netmask] [=
gateway] [metric] :\n&quot;</span><br><span>     &quot;                  Ad=
d route to routing table after connection\n&quot;</span><br><span>     &quo=
t;                  is established.  Multiple routes can be specified.\n&qu=
ot;</span><br><span>@@ -1909,6 +1913,7 @@</span><br><span>     SHOW_STR(rou=
te_script);</span><br><span>     SHOW_STR(route_default_gateway);</span><br=
><span>     SHOW_INT(route_default_metric);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    SHOW_INT(route_default_table_id);</span><br><sp=
an>     SHOW_BOOL(route_noexec);</span><br><span>     SHOW_INT(route_delay)=
;</span><br><span>     SHOW_INT(route_delay_window);</span><br><span>@@ -69=
81,7 +6986,16 @@</span><br><span>         cnol_check_alloc(options);</span>=
<br><span>         add_client_nat_to_option_list(options-&gt;client_nat, p[=
1], p[2], p[3], p[4], msglevel);</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;route&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[5])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (streq(p[0], &quot;route-table&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef =
ENABLE_SITNL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(M_WARN, &quot;NOTE: --route-table is supported only on Linux when SITN=
L is built-in&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VER=
IFY_PERMISSION(OPT_P_ROUTE_TABLE);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        options-&gt;route_default_table_id =3D positive_atoi=
(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;route&quot;) &=
amp;&amp; p[1] &amp;&amp; !p[6])</span><br><span>     {</span><br><span>   =
      VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span>         rol_check_al=
loc(options);</span><br><span>@@ -7002,10 +7016,31 @@</span><br><span>     =
            msg(msglevel, &quot;route parameter gateway &#39;%s&#39; must b=
e a valid address&quot;, p[3]);</span><br><span>                 goto err;<=
/span><br><span>             }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            /* p[4] is metric, if specified */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            /* discard pulled routing table_id from serv=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * si=
nce this must be an entirely local choice */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (p[5])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                p[5] =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>         }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        add_route_to_o=
ption_list(options-&gt;routes, p[1], p[2], p[3], p[4]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* at the moment the routing ta=
ble id is supported only by Linux/SITNL */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifndef ENABLE_SITNL</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (p[5])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            static bool route_table_warned =3D false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (!route_table_warned)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;NOT=
E: table specified for --route, but not supported on this platform&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                rout=
e_table_warned =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_route_to_opt=
ion_list(options-&gt;routes, p[1], p[2], p[3], p[4], p[5]);</span><br><span=
>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (s=
treq(p[0], &quot;route-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &=
quot;route-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; !p[5])</span><br><span>  =
   {</span><br><span>         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><sp=
an>         rol6_check_alloc(options);</span><br><span>@@ -7021,9 +7056,31 =
@@</span><br><span>                 msg(msglevel, &quot;route-ipv6 paramete=
r gateway &#39;%s&#39; must be a valid address&quot;, p[2]);</span><br><spa=
n>                 goto err;</span><br><span>             }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /* p[3] is metric, if pre=
sent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
/* p[3] is metric, if specified */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        /* discard pulled routing table_id from server</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+             * since this must be an ent=
irely local choice */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              p[4] =3D NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span>         }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        add_route_ipv6_to_option_list(options-&=
gt;routes_ipv6, p[1], p[2], p[3]);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* at the moment the routing table id is supported only by Linux/SITNL =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SI=
TNL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[4]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            static bool rout=
e6_table_warned =3D false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (!route6_table_warned)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(M_WARN, &quot;NOTE: table specified for --route-ipv6, b=
ut not supported on this platform&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                route6_table_warned =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        add_route_ipv6_to_option_list(options-&gt;routes_ipv6, p[1], p[2]=
, p[3], p[4]);</span><br><span>     }</span><br><span>     else if (streq(p=
[0], &quot;max-routes&quot;) &amp;&amp; !p[2])</span><br><span>     {</span=
><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span=
><br><span>index 85de887..dced452 100644</span><br><span>--- a/src/openvpn/=
options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -4=
11,6 +411,7 @@</span><br><span>     const char *route_predown_script;</span=
><br><span>     const char *route_default_gateway;</span><br><span>     con=
st char *route_ipv6_default_gateway;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int route_default_table_id;</span><br><span>     int r=
oute_default_metric;</span><br><span>     bool route_noexec;</span><br><spa=
n>     int route_delay;</span><br><span>@@ -741,6 +742,7 @@</span><br><span=
> #define OPT_P_PEER_ID         (1&lt;&lt;28)</span><br><span> #define OPT_=
P_INLINE          (1&lt;&lt;29)</span><br><span> #define OPT_P_PUSH_MTU    =
    (1&lt;&lt;30)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine OPT_P_ROUTE_TABLE     (1&lt;&lt;31)</span><br><span> </span><br><span=
> #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c=
</span><br><span>index 6c027d9..e02c28a 100644</span><br><span>--- a/src/op=
envpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ =
-325,7 +325,6 @@</span><br><span> </span><br><span>     CLEAR(*r);</span><b=
r><span>     r-&gt;option =3D ro;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     /* network */</span><br><span> </span><br=
><span>     if (!is_route_parm_defined(ro-&gt;network))</span><br><span>@@ =
-439,6 +438,27 @@</span><br><span> </span><br><span>     r-&gt;flags |=3D R=
T_DEFINED;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* routing table id */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 r-&gt;table_id =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (ro-&gt;table_id)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  r-&gt;table_id =3D atoi(ro-&gt;table_id);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (r-&gt;table_id &lt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(M_WARN, PACKAGE_NAME &quot;ROU=
TE: routing table id for network %s (%s) must be &gt;=3D 0&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                ro-&gt;networ=
k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                r=
o-&gt;table_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto fail;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r-=
&gt;flags |=3D RT_TABLE_DEFINED;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else if (rl-&gt;spec.flags &amp; RTSA_DEFAULT_TABLE_ID)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        r-&gt;table_id =3D rl-&gt;spec.table_id;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r-&gt;flags |=
=3D RT_TABLE_DEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     return true;</span><br><span> </span><br><span> fail:</span><br><=
span>@@ -495,6 +515,27 @@</span><br><span> </span><br><span>     r6-&gt;fla=
gs |=3D RT_DEFINED;</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* routing table id */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    r6-&gt;table_id =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (r6o-&gt;table_id)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        r6-&gt;table_id =3D atoi(r6o-&gt;table_id);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (r6-&gt;table_id &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, PACKAGE_=
NAME &quot;ROUTE: routing table id for network %s (%s) must be &gt;=3D 0&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 r6o-&gt;prefix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             r6o-&gt;table_id);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            goto fail;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        r6-&gt;flags |=3D RT_TABLE_DEFINED;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else if (rl6-&gt;spec_flags &amp; RTSA_DEFAULT_TABLE_ID)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        r6-&gt;table_id =3D rl6-&=
gt;default_route_table_id;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        r6-&gt;flags |=3D RT_TABLE_DEFINED;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>     return true;</span><br><span> </span=
><br><span> fail:</span><br><span>@@ -508,7 +549,8 @@</span><br><span>     =
                     const char *network,</span><br><span>                 =
         const char *netmask,</span><br><span>                          con=
st char *gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                     const char *metric)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                         const char *metric,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                         cons=
t char *table_id)</span><br><span> {</span><br><span>     struct route_opti=
on *ro;</span><br><span>     ALLOC_OBJ_GC(ro, struct route_option, l-&gt;gc=
);</span><br><span>@@ -516,6 +558,7 @@</span><br><span>     ro-&gt;netmask =
=3D netmask;</span><br><span>     ro-&gt;gateway =3D gateway;</span><br><sp=
an>     ro-&gt;metric =3D metric;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ro-&gt;table_id =3D table_id;</span><br><span>     ro-&gt=
;next =3D l-&gt;routes;</span><br><span>     l-&gt;routes =3D ro;</span><br=
><span> </span><br><span>@@ -525,13 +568,15 @@</span><br><span> add_route_i=
pv6_to_option_list(struct route_ipv6_option_list *l,</span><br><span>      =
                         const char *prefix,</span><br><span>              =
                 const char *gateway,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                              const char *metric)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
 const char *metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                              const char *table_id)</span><br><span> {</sp=
an><br><span>     struct route_ipv6_option *ro;</span><br><span>     ALLOC_=
OBJ_GC(ro, struct route_ipv6_option, l-&gt;gc);</span><br><span>     ro-&gt=
;prefix =3D prefix;</span><br><span>     ro-&gt;gateway =3D gateway;</span>=
<br><span>     ro-&gt;metric =3D metric;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ro-&gt;table_id =3D table_id;</span><br><span>    =
 ro-&gt;next =3D l-&gt;routes_ipv6;</span><br><span>     l-&gt;routes_ipv6 =
=3D ro;</span><br><span> }</span><br><span>@@ -630,6 +675,7 @@</span><br><s=
pan>                 const struct route_option_list *opt,</span><br><span> =
                const char *remote_endpoint,</span><br><span>              =
   int default_metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                int table_id,</span><br><span>                 in_addr_t=
 remote_host,</span><br><span>                 struct env_set *es,</span><b=
r><span>                 openvpn_net_ctx_t *ctx)</span><br><span>@@ -653,6 =
+699,12 @@</span><br><span>         rl-&gt;spec.flags |=3D RTSA_DEFAULT_MET=
RIC;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (table_id)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        rl-&gt;spec.table_id =3D table_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        rl-&gt;spec.flags |=3D RTSA_DEFAU=
LT_TABLE_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
 get_default_gateway(&amp;rl-&gt;rgi, ctx);</span><br><span>     if (rl-&gt=
;rgi.flags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</span><br><span>@=
@ -786,6 +838,7 @@</span><br><span>                      const struct route=
_ipv6_option_list *opt6,</span><br><span>                      const char *=
remote_endpoint,</span><br><span>                      int default_metric,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
 int table_id,</span><br><span>                      const struct in6_addr =
*remote_host_ipv6,</span><br><span>                      struct env_set *es=
,</span><br><span>                      openvpn_net_ctx_t *ctx)</span><br><=
span>@@ -810,6 +863,12 @@</span><br><span>         rl6-&gt;spec_flags |=3D =
RTSA_DEFAULT_METRIC;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (table_id)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        rl6-&gt;default_route_table_id =3D table_=
id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rl6-&gt;=
spec_flags |=3D RTSA_DEFAULT_TABLE_ID;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     msg(D_ROUTE, &quot;GDG6: remote_host_ipv6=3D%s&q=
uot;,</span><br><span>         remote_host_ipv6 ?  print_in6_addr(*remote_h=
ost_ipv6, 0, &amp;gc) : &quot;n/a&quot; );</span><br><span> </span><br><spa=
n>@@ -1602,9 +1661,15 @@</span><br><span>         metric =3D r-&gt;metric;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int table_id =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (r-&gt;flags &amp; RT_TABLE_DEFINED)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        table_id =3D r-&gt;table_id;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     status =3D RTA_=
SUCCESS;</span><br><span>     int ret =3D net_route_v4_add(ctx, &amp;r-&gt;=
network, netmask_to_netbits2(r-&gt;netmask),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                               &amp;r-&gt;gateway, i=
face, 0, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                             &amp;r-&gt;gateway, iface, table_id, metric);<=
/span><br><span>     if (ret =3D=3D -EEXIST)</span><br><span>     {</span><=
br><span>         msg(D_ROUTE, &quot;NOTE: Linux route add command failed b=
ecause route exists&quot;);</span><br><span>@@ -1982,10 +2047,16 @@</span><=
br><span>         metric =3D r6-&gt;metric;</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ta=
ble_id =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 ((r6-&gt;flags &amp; RT_TABLE_DEFINED) &amp;&amp; (r6-&gt;table_id &gt; 0)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        table_id =3D r6-&gt;tabl=
e_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     status=
 =3D RTA_SUCCESS;</span><br><span>     int ret =3D net_route_v6_add(ctx, &a=
mp;r6-&gt;network, r6-&gt;netbits,</span><br><span>                        =
        gateway_needed ? &amp;r6-&gt;gateway : NULL,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                               device, 0, m=
etric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                   device, table_id, metric);</span><br><span>     if (ret =
=3D=3D -EEXIST)</span><br><span>     {</span><br><span>         msg(D_ROUTE=
, &quot;NOTE: Linux route add command failed because route exists&quot;);</=
span><br><span>@@ -2190,8 +2261,14 @@</span><br><span>         metric =3D r=
-&gt;metric;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int table_id =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (r-&gt;flags &amp; RT_TABLE_DE=
FINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        table_id =3D r-&gt;=
table_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if=
 (net_route_v4_del(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netma=
sk),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
        &amp;r-&gt;gateway, NULL, 0, metric) &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                         &amp;r-&gt;gatew=
ay, NULL, table_id, metric) &lt; 0)</span><br><span>     {</span><br><span>=
         msg(M_WARN, &quot;ERROR: Linux route delete command failed&quot;);=
</span><br><span>     }</span><br><span>@@ -2403,8 +2480,16 @@</span><br><s=
pan>         metric =3D r6-&gt;metric;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int table_i=
d =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (r6-=
&gt;flags &amp; RT_TABLE_DEFINED)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        table_id =3D r6-&gt;table_id;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (net_rout=
e_v6_del(ctx, &amp;r6-&gt;network, r6-&gt;netbits,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                         gateway_needed ? &amp=
;r6-&gt;gateway : NULL, device, 0,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                         gateway_needed ? &amp;r6-&gt;gatewa=
y : NULL, device, table_id,</span><br><span>                          metri=
c) &lt; 0)</span><br><span>     {</span><br><span>         msg(M_WARN, &quo=
t;ERROR: Linux route v6 delete command failed&quot;);</span><br><span>diff =
--git a/src/openvpn/route.h b/src/openvpn/route.h</span><br><span>index 71b=
4cf4..ab7eaa4 100644</span><br><span>--- a/src/openvpn/route.h</span><br><s=
pan>+++ b/src/openvpn/route.h</span><br><span>@@ -63,12 +63,14 @@</span><br=
><span> #define RTSA_REMOTE_ENDPOINT  (1&lt;&lt;0)</span><br><span> #define=
 RTSA_REMOTE_HOST      (1&lt;&lt;1)</span><br><span> #define RTSA_DEFAULT_M=
ETRIC   (1&lt;&lt;2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define RTSA_DEFAULT_TABLE_ID (1&lt;&lt;3)</span><br><span>     unsigned i=
nt flags;</span><br><span> </span><br><span>     in_addr_t remote_endpoint;=
</span><br><span>     in_addr_t remote_host;</span><br><span>     int remot=
e_host_local; /* TLA_x value */</span><br><span>     struct route_bypass by=
pass;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int table_=
id;</span><br><span>     int default_metric;</span><br><span> };</span><br>=
<span> </span><br><span>@@ -77,6 +79,7 @@</span><br><span>     const char *=
network;</span><br><span>     const char *netmask;</span><br><span>     con=
st char *gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *table_id;</span><br><span>     const char *metric;</span><br>=
<span> };</span><br><span> </span><br><span>@@ -92,6 +95,7 @@</span><br><sp=
an> </span><br><span> struct route_option_list {</span><br><span>     unsig=
ned int flags; /* RG_x flags */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     struct route_option *routes;</span><br><s=
pan>     struct gc_arena *gc;</span><br><span> };</span><br><span>@@ -101,6=
 +105,7 @@</span><br><span>     const char *prefix;         /* e.g. &quot;2=
001:db8:1::/64&quot; */</span><br><span>     const char *gateway;        /*=
 e.g. &quot;2001:db8:0::2&quot; */</span><br><span>     const char *metric;=
         /* e.g. &quot;5&quot; */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *table_id;</span><br><span> };</span><br><span=
> </span><br><span> struct route_ipv6_option_list {</span><br><span>@@ -113=
,12 +118,14 @@</span><br><span> #define RT_DEFINED        (1&lt;&lt;0)</spa=
n><br><span> #define RT_ADDED          (1&lt;&lt;1)</span><br><span> #defin=
e RT_METRIC_DEFINED (1&lt;&lt;2)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define RT_TABLE_DEFINED  (1&lt;&lt;3)</span><br><span>     st=
ruct route_ipv4 *next;</span><br><span>     unsigned int flags;</span><br><=
span>     const struct route_option *option;</span><br><span>     in_addr_t=
 network;</span><br><span>     in_addr_t netmask;</span><br><span>     in_a=
ddr_t gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt table_id;</span><br><span>     int metric;</span><br><span> };</span><br=
><span> </span><br><span>@@ -129,6 +136,7 @@</span><br><span>     unsigned =
int netbits;</span><br><span>     struct in6_addr gateway;</span><br><span>=
     int metric;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int table_id;</span><br><span>     /* gateway interface */</span><br><span=
> #ifdef _WIN32</span><br><span>     DWORD adapter_index;        /* interfa=
ce or ~0 if undefined */</span><br><span>@@ -223,6 +231,7 @@</span><br><spa=
n>     struct in6_addr remote_endpoint_ipv6; /* inside tun */</span><br><sp=
an>     struct in6_addr remote_host_ipv6;   /* --remote address */</span><b=
r><span>     int default_metric;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int default_route_table_id;</span><br><span> </span><br><s=
pan>     struct route_ipv6_gateway_info rgi6;</span><br><span>     unsigned=
 int flags;                 /* RG_x flags, see route_option_list */</span><=
br><span>@@ -271,17 +280,20 @@</span><br><span>                            =
   const char *network,</span><br><span>                               cons=
t char *netmask,</span><br><span>                               const char =
*gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                  const char *metric);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                              const char *metric,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
    const char *table_id);</span><br><span> </span><br><span> void add_rout=
e_ipv6_to_option_list(struct route_ipv6_option_list *l,</span><br><span>   =
                                 const char *prefix,</span><br><span>      =
                              const char *gateway,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                   const char =
*metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                         const char *metric,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                   const char *tab=
le_id);</span><br><span> </span><br><span> bool init_route_list(struct rout=
e_list *rl,</span><br><span>                      const struct route_option=
_list *opt,</span><br><span>                      const char *remote_endpoi=
nt,</span><br><span>                      int default_metric,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                     int table_id=
,</span><br><span>                      in_addr_t remote_host,</span><br><s=
pan>                      struct env_set *es,</span><br><span>             =
         openvpn_net_ctx_t *ctx);</span><br><span>@@ -290,6 +302,7 @@</span=
><br><span>                           const struct route_ipv6_option_list *=
opt6,</span><br><span>                           const char *remote_endpoin=
t,</span><br><span>                           int default_metric,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                          int=
 table_id,</span><br><span>                           const struct in6_addr=
 *remote_host,</span><br><span>                           struct env_set *e=
s,</span><br><span>                           openvpn_net_ctx_t *ctx);</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/524?usp=3Demail">change 524</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/524?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede56=
17ee98bf218a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 524 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--maGyo9MO/3o=--

