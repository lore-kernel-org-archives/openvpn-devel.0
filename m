From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 15 Feb 2024 14:52:42 +0000
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8738adedc06e1ff9a2cabed71838bf35bcb92068-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gE87unOuKaI="; charset=UTF-8
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

--gE87unOuKaI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail

to review the following change.


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
7 files changed, 201 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/524/1

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 41d367b..75da049 100644
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
@@ -394,6 +403,9 @@
   ``metric``
         default taken from ``--route-metric`` if set, otherwise :code:`0`.

+  ``table-id`` (Supported on Linux only, on other platforms this is a no-o=
p).
+	default taken from ``--route-table`` if set, otherwise :code:`0`.
+
   The default can be specified by leaving an option blank or setting it to
   :code:`default`.

@@ -444,12 +456,14 @@
   Valid syntax:
   ::

-     route-ipv6 ipv6addr/bits [gateway] [metric]
+     route-ipv6 ipv6addr/bits [gateway] [metric] [table-id]

   The gateway parameter is only used for IPv6 routes across *tap* devices,
   and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or
   ``--route-ipv6-gateway`` is used.

+  (table-id supported on Linux only, on other platforms this is a no-op).
+
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
index 2c79a1e..e35cf9a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -201,6 +201,10 @@
     "                    pass --ifconfig parms by environment to scripts.\=
n"
     "--ifconfig-nowarn : Don't warn if the --ifconfig option on this side =
of the\n"
     "                    connection doesn't match the remote side.\n"
+#ifdef TARGET_LINUX
+    "--route-table [table_id] : Specify a custom routing table for use wit=
h --route(-ipv6).\n"
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
+        msg(M_WARN, "NOTE: --route-table specified, but not supported on t=
his platform");
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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--gE87unOuKaI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Route: add support for user defined routing table<br><br>Add =
the ability for users to specify a custom<br>routing table where routes sho=
uld be installed in.<br>As of now routes are always installed in the main<b=
r>routing table of the operating system, however,<br>with the new --route-t=
able option it is possibile<br>to specify the ID of the default routing tab=
le<br>to be used by --route(-ipv6).<br><br>The --route(-ipv6) directives ha=
ve been extended<br>with an additional argument (5th for --route)<br>(4th f=
or --route-ipv6) so that each of them<br>can possibly use an independent ro=
uting table.<br><br>Please note: this feature is currently supported<br>onl=
y by Linux/SITNL.<br>Support for other platforms should be added in related=
 backends.<br><br>Fixes: Trac #1399<br>Change-Id: I3e4ebef484d2a04a383a65ed=
e5617ee98bf218a7<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...1664...=
26...&gt;<br>---<br>M doc/man-sections/vpn-network-options.rst<br>M src/ope=
nvpn/helper.c<br>M src/openvpn/init.c<br>M src/openvpn/options.c<br>M src/o=
penvpn/options.h<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>7 fil=
es changed, 201 insertions(+), 16 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/24/524/1</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/do=
c/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-optio=
ns.rst</span><br><span>index 41d367b..75da049 100644</span><br><span>--- a/=
doc/man-sections/vpn-network-options.rst</span><br><span>+++ b/doc/man-sect=
ions/vpn-network-options.rst</span><br><span>@@ -367,6 +367,14 @@</span><br=
><span>   Like ``--redirect-gateway``, but omit actually changing the defau=
lt gateway.</span><br><span>   Useful when pushing private subnets.</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--route-t=
able id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Specify a =
default table id for use with --route.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  By default, OpenVPN installs routes in the main routin=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  table of the ope=
rating system, but with this option,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  a user defined routing table can be used instead.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  (Supported on Linux only, on other platform=
s this is a no-op).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> --route args</span><br><span>   Add route to routing tabl=
e after connection is established. Multiple</span><br><span>   routes can b=
e specified. Routes will be automatically torn down in</span><br><span>@@ -=
379,6 +387,7 @@</span><br><span>       route network/IP netmask</span><br><=
span>       route network/IP netmask gateway</span><br><span>       route n=
etwork/IP netmask gateway metric</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      route network/IP netmask gateway metric table-id</span><=
br><span> </span><br><span>   This option is intended as a convenience prox=
y for the ``route``\(8)</span><br><span>   shell command, while at the same=
 time providing portable semantics</span><br><span>@@ -394,6 +403,9 @@</spa=
n><br><span>   ``metric``</span><br><span>         default taken from ``--r=
oute-metric`` if set, otherwise :code:`0`.</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  ``table-id`` (Supported on Linux=
 only, on other platforms this is a no-op).</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	default taken from ``--route-table`` if set, other=
wise :code:`0`.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>   The default can be specified by leaving an option blank or =
setting it to</span><br><span>   :code:`default`.</span><br><span> </span><=
br><span>@@ -444,12 +456,14 @@</span><br><span>   Valid syntax:</span><br><=
span>   ::</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     route-ipv6 ipv6addr/bits [gateway] [metric]</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     route-ipv6 ipv6addr/bits [gateway]=
 [metric] [table-id]</span><br><span> </span><br><span>   The gateway param=
eter is only used for IPv6 routes across *tap* devices,</span><br><span>   =
and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or</span>=
<br><span>   ``--route-ipv6-gateway`` is used.</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  (table-id supported on Linux=
 only, on other platforms this is a no-op).</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> --route-gateway arg</span><br><sp=
an>   Specify a default *gateway* for use with ``--route``.</span><br><span=
> </span><br><span>diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c=
</span><br><span>index fa011ff..758160d 100644</span><br><span>--- a/src/op=
envpn/helper.c</span><br><span>+++ b/src/openvpn/helper.c</span><br><span>@=
@ -118,6 +118,7 @@</span><br><span>                              print_in_a=
ddr_t(network, 0, &amp;o-&gt;gc),</span><br><span>                         =
     print_in_addr_t(netmask, 0, &amp;o-&gt;gc),</span><br><span>          =
                    NULL,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                             NULL,</span><br><span>                  =
            NULL);</span><br><span> }</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index c5c=
c154..c24e736 100644</span><br><span>--- a/src/openvpn/init.c</span><br><sp=
an>+++ b/src/openvpn/init.c</span><br><span>@@ -1481,6 +1481,7 @@</span><br=
><span>     const char *gw =3D NULL;</span><br><span>     int dev =3D dev_t=
ype_enum(options-&gt;dev, options-&gt;dev_type);</span><br><span>     int m=
etric =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 table_id =3D 0; /* unspec table */</span><br><span> </span><br><span>     =
/* if DCO is enabled we have both regular routes and iroutes in the system<=
/span><br><span>      * routing table, and normal routes must have a higher=
 metric for that to</span><br><span>@@ -1499,6 +1500,10 @@</span><br><span>=
     {</span><br><span>         gw =3D options-&gt;route_default_gateway;</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (options-&gt;route_default_table_id)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        table_id =3D options-&gt;route_default_table_id;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>    =
 if (options-&gt;route_default_metric)</span><br><span>     {</span><br><sp=
an>         metric =3D options-&gt;route_default_metric;</span><br><span>@@=
 -1508,6 +1513,7 @@</span><br><span>                         options-&gt;ro=
utes,</span><br><span>                         gw,</span><br><span>        =
                 metric,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        table_id,</span><br><span>                    =
     link_socket_current_remote(link_socket_info),</span><br><span>        =
                 es,</span><br><span>                         ctx))</span><=
br><span>@@ -1526,6 +1532,7 @@</span><br><span> {</span><br><span>     cons=
t char *gw =3D NULL;</span><br><span>     int metric =3D -1;            /* =
no metric set */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int table_id =3D 0; /* unspec table */</span><br><span> </span><br><span> =
    /* see explanation in do_init_route_list() */</span><br><span>     if (=
dco_enabled(options))</span><br><span>@@ -1544,6 +1551,11 @@</span><br><spa=
n>         metric =3D options-&gt;route_default_metric;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (options-&gt;route_default_table_id)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        table_id =3D options-&gt;route_default_table_id;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* redirect (IPv6)=
 gateway to VPN?  if yes, add a few more specifics</span><br><span>      */=
</span><br><span>     if (options-&gt;routes_ipv6-&gt;flags &amp; RG_REROUT=
E_GW)</span><br><span>@@ -1555,7 +1567,7 @@</span><br><span>         {</spa=
n><br><span>             add_route_ipv6_to_option_list( options-&gt;routes_=
ipv6,</span><br><span>                                            string_al=
loc(opt_list[i], options-&gt;routes_ipv6-&gt;gc),</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                           NULL=
, NULL );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                 NULL, NULL, NULL );</span><br><span>      =
   }</span><br><span>     }</span><br><span> </span><br><span>@@ -1563,6 +1=
575,7 @@</span><br><span>                              options-&gt;routes_i=
pv6,</span><br><span>                              gw,</span><br><span>    =
                          metric,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                             table_id,</span><br><span>      =
                        link_socket_current_remote_ipv6(link_socket_info),<=
/span><br><span>                              es,</span><br><span>         =
                     ctx))</span><br><span>diff --git a/src/openvpn/options=
.c b/src/openvpn/options.c</span><br><span>index 2c79a1e..e35cf9a 100644</s=
pan><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn=
/options.c</span><br><span>@@ -201,6 +201,10 @@</span><br><span>     &quot;=
                    pass --ifconfig parms by environment to scripts.\n&quot=
;</span><br><span>     &quot;--ifconfig-nowarn : Don&#39;t warn if the --if=
config option on this side of the\n&quot;</span><br><span>     &quot;      =
              connection doesn&#39;t match the remote side.\n&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_LINUX</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--route-table [ta=
ble_id] : Specify a custom routing table for use with --route(-ipv6).\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;       =
                    If not specified, the id of the default routing table w=
ill be used.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span>     &quot;--route network [netmask] [gateway] [met=
ric] :\n&quot;</span><br><span>     &quot;                  Add route to ro=
uting table after connection\n&quot;</span><br><span>     &quot;           =
       is established.  Multiple routes can be specified.\n&quot;</span><br=
><span>@@ -1909,6 +1913,7 @@</span><br><span>     SHOW_STR(route_script);</=
span><br><span>     SHOW_STR(route_default_gateway);</span><br><span>     S=
HOW_INT(route_default_metric);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    SHOW_INT(route_default_table_id);</span><br><span>     SHOW_=
BOOL(route_noexec);</span><br><span>     SHOW_INT(route_delay);</span><br><=
span>     SHOW_INT(route_delay_window);</span><br><span>@@ -6981,7 +6986,16=
 @@</span><br><span>         cnol_check_alloc(options);</span><br><span>   =
      add_client_nat_to_option_list(options-&gt;client_nat, p[1], p[2], p[3=
], p[4], msglevel);</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;route&quot;) &amp;&amp;=
 p[1] &amp;&amp; !p[5])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else if (streq(p[0], &quot;route-table&quot;) &amp;&amp; p[1] &amp;=
&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SITNL<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, =
&quot;NOTE: --route-table specified, but not supported on this platform&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OP=
T_P_ROUTE_TABLE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      options-&gt;route_default_table_id =3D positive_atoi(p[1]);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else if (streq(p[0], &quot;route&quot;) &amp;&amp; p[1] &a=
mp;&amp; !p[6])</span><br><span>     {</span><br><span>         VERIFY_PERM=
ISSION(OPT_P_ROUTE);</span><br><span>         rol_check_alloc(options);</sp=
an><br><span>@@ -7002,10 +7016,31 @@</span><br><span>                 msg(m=
sglevel, &quot;route parameter gateway &#39;%s&#39; must be a valid address=
&quot;, p[3]);</span><br><span>                 goto err;</span><br><span> =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      /* p[4] is metric, if specified */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /* discard pulled routing table_id from server</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+             * since this must be =
an entirely local choice */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (p[5])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                p[5] =3D NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span>         }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        add_route_to_option_list(options-=
&gt;routes, p[1], p[2], p[3], p[4]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* at the moment the routing table id is supported=
 only by Linux/SITNL */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifndef ENABLE_SITNL</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (p[5])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     static bool route_table_warned =3D false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (!route_table_warned)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                msg(M_WARN, &quot;NOTE: table specified =
for --route, but not supported on this platform&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                route_table_warned =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        add_route_to_option_list(options-=
&gt;routes, p[1], p[2], p[3], p[4], p[5]);</span><br><span>     }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;=
route-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;route-ipv6=
&quot;) &amp;&amp; p[1] &amp;&amp; !p[5])</span><br><span>     {</span><br>=
<span>         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span>         rol=
6_check_alloc(options);</span><br><span>@@ -7021,9 +7056,31 @@</span><br><s=
pan>                 msg(msglevel, &quot;route-ipv6 parameter gateway &#39;=
%s&#39; must be a valid address&quot;, p[2]);</span><br><span>             =
    goto err;</span><br><span>             }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            /* p[3] is metric, if present */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            /* p[3] is metr=
ic, if specified */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* disc=
ard pulled routing table_id from server</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+             * since this must be an entirely local cho=
ice */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                p=
[4] =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        add_route_ipv6_to_option_list(options-&gt;routes_ipv6,=
 p[1], p[2], p[3]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* at the m=
oment the routing table id is supported only by Linux/SITNL */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SITNL</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (p[4])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            static bool route6_table_warn=
ed =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!route6_t=
able_warned)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   msg(M_WARN, &quot;NOTE: table specified for --route-ipv6, but not suppor=
ted on this platform&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                route6_table_warned =3D true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_r=
oute_ipv6_to_option_list(options-&gt;routes_ipv6, p[1], p[2], p[3], p[4]);<=
/span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;max-=
routes&quot;) &amp;&amp; !p[2])</span><br><span>     {</span><br><span>diff=
 --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>inde=
x 85de887..dced452 100644</span><br><span>--- a/src/openvpn/options.h</span=
><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -411,6 +411,7 @@<=
/span><br><span>     const char *route_predown_script;</span><br><span>    =
 const char *route_default_gateway;</span><br><span>     const char *route_=
ipv6_default_gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int route_default_table_id;</span><br><span>     int route_default_me=
tric;</span><br><span>     bool route_noexec;</span><br><span>     int rout=
e_delay;</span><br><span>@@ -741,6 +742,7 @@</span><br><span> #define OPT_P=
_PEER_ID         (1&lt;&lt;28)</span><br><span> #define OPT_P_INLINE       =
   (1&lt;&lt;29)</span><br><span> #define OPT_P_PUSH_MTU        (1&lt;&lt;3=
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ROU=
TE_TABLE     (1&lt;&lt;31)</span><br><span> </span><br><span> #define OPT_P=
_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><spa=
n>index 6c027d9..e02c28a 100644</span><br><span>--- a/src/openvpn/route.c</=
span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -325,7 +325,6 @=
@</span><br><span> </span><br><span>     CLEAR(*r);</span><br><span>     r-=
&gt;option =3D ro;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>     /* network */</span><br><span> </span><br><span>     if =
(!is_route_parm_defined(ro-&gt;network))</span><br><span>@@ -439,6 +438,27 =
@@</span><br><span> </span><br><span>     r-&gt;flags |=3D RT_DEFINED;</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 routing table id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;table_id=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ro-&=
gt;table_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r-&gt;table_i=
d =3D atoi(ro-&gt;table_id);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (r-&gt;table_id &lt; 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(M_WARN, PACKAGE_NAME &quot;ROUTE: routing tab=
le id for network %s (%s) must be &gt;=3D 0&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                ro-&gt;network,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                ro-&gt;table_id)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto f=
ail;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        r-&gt;flags |=3D =
RT_TABLE_DEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (rl-=
&gt;spec.flags &amp; RTSA_DEFAULT_TABLE_ID)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        r-&gt;table_id =3D rl-&gt;spec.table_id;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        r-&gt;flags |=3D RT_TABLE_DE=
FINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     retur=
n true;</span><br><span> </span><br><span> fail:</span><br><span>@@ -495,6 =
+515,27 @@</span><br><span> </span><br><span>     r6-&gt;flags |=3D RT_DEFI=
NED;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* routing table id */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6-&g=
t;table_id =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (r6o-&gt;table_id)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r6=
-&gt;table_id =3D atoi(r6o-&gt;table_id);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (r6-&gt;table_id &lt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(M_WARN, PACKAGE_NAME &quot;ROUT=
E: routing table id for network %s (%s) must be &gt;=3D 0&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                r6o-&gt;prefix=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                r6=
o-&gt;table_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto fail;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r6=
-&gt;flags |=3D RT_TABLE_DEFINED;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else if (rl6-&gt;spec_flags &amp; RTSA_DEFAULT_TABLE_ID)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        r6-&gt;table_id =3D rl6-&gt;default_rout=
e_table_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
r6-&gt;flags |=3D RT_TABLE_DEFINED;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     return true;</span><br><span> </span><br><span> fai=
l:</span><br><span>@@ -508,7 +549,8 @@</span><br><span>                    =
      const char *network,</span><br><span>                          const =
char *netmask,</span><br><span>                          const char *gatewa=
y,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
      const char *metric)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                         const char *metric,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                         const char *table_i=
d)</span><br><span> {</span><br><span>     struct route_option *ro;</span><=
br><span>     ALLOC_OBJ_GC(ro, struct route_option, l-&gt;gc);</span><br><s=
pan>@@ -516,6 +558,7 @@</span><br><span>     ro-&gt;netmask =3D netmask;</s=
pan><br><span>     ro-&gt;gateway =3D gateway;</span><br><span>     ro-&gt;=
metric =3D metric;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ro-&gt;table_id =3D table_id;</span><br><span>     ro-&gt;next =3D l-&gt=
;routes;</span><br><span>     l-&gt;routes =3D ro;</span><br><span> </span>=
<br><span>@@ -525,13 +568,15 @@</span><br><span> add_route_ipv6_to_option_l=
ist(struct route_ipv6_option_list *l,</span><br><span>                     =
          const char *prefix,</span><br><span>                             =
  const char *gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                              const char *metric)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                              const char *me=
tric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                const char *table_id)</span><br><span> {</span><br><span>  =
   struct route_ipv6_option *ro;</span><br><span>     ALLOC_OBJ_GC(ro, stru=
ct route_ipv6_option, l-&gt;gc);</span><br><span>     ro-&gt;prefix =3D pre=
fix;</span><br><span>     ro-&gt;gateway =3D gateway;</span><br><span>     =
ro-&gt;metric =3D metric;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ro-&gt;table_id =3D table_id;</span><br><span>     ro-&gt;next =
=3D l-&gt;routes_ipv6;</span><br><span>     l-&gt;routes_ipv6 =3D ro;</span=
><br><span> }</span><br><span>@@ -630,6 +675,7 @@</span><br><span>         =
        const struct route_option_list *opt,</span><br><span>              =
   const char *remote_endpoint,</span><br><span>                 int defaul=
t_metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      int table_id,</span><br><span>                 in_addr_t remote_host,=
</span><br><span>                 struct env_set *es,</span><br><span>     =
            openvpn_net_ctx_t *ctx)</span><br><span>@@ -653,6 +699,12 @@</s=
pan><br><span>         rl-&gt;spec.flags |=3D RTSA_DEFAULT_METRIC;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (table_id)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     rl-&gt;spec.table_id =3D table_id;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        rl-&gt;spec.flags |=3D RTSA_DEFAULT_TABLE_ID;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     get_default_g=
ateway(&amp;rl-&gt;rgi, ctx);</span><br><span>     if (rl-&gt;rgi.flags &am=
p; RGI_ADDR_DEFINED)</span><br><span>     {</span><br><span>@@ -786,6 +838,=
7 @@</span><br><span>                      const struct route_ipv6_option_l=
ist *opt6,</span><br><span>                      const char *remote_endpoin=
t,</span><br><span>                      int default_metric,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                     int table_id,=
</span><br><span>                      const struct in6_addr *remote_host_i=
pv6,</span><br><span>                      struct env_set *es,</span><br><s=
pan>                      openvpn_net_ctx_t *ctx)</span><br><span>@@ -810,6=
 +863,12 @@</span><br><span>         rl6-&gt;spec_flags |=3D RTSA_DEFAULT_M=
ETRIC;</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (table_id)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        rl6-&gt;default_route_table_id =3D table_id;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        rl6-&gt;spec_flags |=
=3D RTSA_DEFAULT_TABLE_ID;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     msg(D_ROUTE, &quot;GDG6: remote_host_ipv6=3D%s&quot;,</span>=
<br><span>         remote_host_ipv6 ?  print_in6_addr(*remote_host_ipv6, 0,=
 &amp;gc) : &quot;n/a&quot; );</span><br><span> </span><br><span>@@ -1602,9=
 +1661,15 @@</span><br><span>         metric =3D r-&gt;metric;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int table_id =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (r-&gt;flags &amp; RT_TABLE_DEFINED)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        table_id =3D r-&gt;table_id;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     status =3D RTA_SUCCESS;</sp=
an><br><span>     int ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, net=
mask_to_netbits2(r-&gt;netmask),</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                               &amp;r-&gt;gateway, iface, 0, met=
ric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                 &amp;r-&gt;gateway, iface, table_id, metric);</span><br><s=
pan>     if (ret =3D=3D -EEXIST)</span><br><span>     {</span><br><span>   =
      msg(D_ROUTE, &quot;NOTE: Linux route add command failed because route=
 exists&quot;);</span><br><span>@@ -1982,10 +2047,16 @@</span><br><span>   =
      metric =3D r6-&gt;metric;</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int table_id =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((r6-&gt;fl=
ags &amp; RT_TABLE_DEFINED) &amp;&amp; (r6-&gt;table_id &gt; 0))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        table_id =3D r6-&gt;table_id;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     status =3D RTA_SUC=
CESS;</span><br><span>     int ret =3D net_route_v6_add(ctx, &amp;r6-&gt;ne=
twork, r6-&gt;netbits,</span><br><span>                                gate=
way_needed ? &amp;r6-&gt;gateway : NULL,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                               device, 0, metric);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
      device, table_id, metric);</span><br><span>     if (ret =3D=3D -EEXIS=
T)</span><br><span>     {</span><br><span>         msg(D_ROUTE, &quot;NOTE:=
 Linux route add command failed because route exists&quot;);</span><br><spa=
n>@@ -2190,8 +2261,14 @@</span><br><span>         metric =3D r-&gt;metric;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int table_id =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (r-&gt;flags &amp; RT_TABLE_DEFINED)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        table_id =3D r-&gt;table_id;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (net_route_v=
4_del(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask),</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                         &amp;=
r-&gt;gateway, NULL, 0, metric) &lt; 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                         &amp;r-&gt;gateway, NULL, tabl=
e_id, metric) &lt; 0)</span><br><span>     {</span><br><span>         msg(M=
_WARN, &quot;ERROR: Linux route delete command failed&quot;);</span><br><sp=
an>     }</span><br><span>@@ -2403,8 +2480,16 @@</span><br><span>         m=
etric =3D r6-&gt;metric;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int table_id =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (r6-&gt;flags &amp=
; RT_TABLE_DEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        table_=
id =3D r6-&gt;table_id;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     if (net_route_v6_del(ctx, =
&amp;r6-&gt;network, r6-&gt;netbits,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                         gateway_needed ? &amp;r6-&gt;gatewa=
y : NULL, device, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                         gateway_needed ? &amp;r6-&gt;gateway : NULL, devi=
ce, table_id,</span><br><span>                          metric) &lt; 0)</sp=
an><br><span>     {</span><br><span>         msg(M_WARN, &quot;ERROR: Linux=
 route v6 delete command failed&quot;);</span><br><span>diff --git a/src/op=
envpn/route.h b/src/openvpn/route.h</span><br><span>index 71b4cf4..ab7eaa4 =
100644</span><br><span>--- a/src/openvpn/route.h</span><br><span>+++ b/src/=
openvpn/route.h</span><br><span>@@ -63,12 +63,14 @@</span><br><span> #defin=
e RTSA_REMOTE_ENDPOINT  (1&lt;&lt;0)</span><br><span> #define RTSA_REMOTE_H=
OST      (1&lt;&lt;1)</span><br><span> #define RTSA_DEFAULT_METRIC   (1&lt;=
&lt;2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RTSA_=
DEFAULT_TABLE_ID (1&lt;&lt;3)</span><br><span>     unsigned int flags;</spa=
n><br><span> </span><br><span>     in_addr_t remote_endpoint;</span><br><sp=
an>     in_addr_t remote_host;</span><br><span>     int remote_host_local; =
/* TLA_x value */</span><br><span>     struct route_bypass bypass;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int table_id;</span><br>=
<span>     int default_metric;</span><br><span> };</span><br><span> </span>=
<br><span>@@ -77,6 +79,7 @@</span><br><span>     const char *network;</span=
><br><span>     const char *netmask;</span><br><span>     const char *gatew=
ay;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
table_id;</span><br><span>     const char *metric;</span><br><span> };</spa=
n><br><span> </span><br><span>@@ -92,6 +95,7 @@</span><br><span> </span><br=
><span> struct route_option_list {</span><br><span>     unsigned int flags;=
 /* RG_x flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     struct route_option *routes;</span><br><span>     struc=
t gc_arena *gc;</span><br><span> };</span><br><span>@@ -101,6 +105,7 @@</sp=
an><br><span>     const char *prefix;         /* e.g. &quot;2001:db8:1::/64=
&quot; */</span><br><span>     const char *gateway;        /* e.g. &quot;20=
01:db8:0::2&quot; */</span><br><span>     const char *metric;         /* e.=
g. &quot;5&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *table_id;</span><br><span> };</span><br><span> </span><br><=
span> struct route_ipv6_option_list {</span><br><span>@@ -113,12 +118,14 @@=
</span><br><span> #define RT_DEFINED        (1&lt;&lt;0)</span><br><span> #=
define RT_ADDED          (1&lt;&lt;1)</span><br><span> #define RT_METRIC_DE=
FINED (1&lt;&lt;2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define RT_TABLE_DEFINED  (1&lt;&lt;3)</span><br><span>     struct route_ipv=
4 *next;</span><br><span>     unsigned int flags;</span><br><span>     cons=
t struct route_option *option;</span><br><span>     in_addr_t network;</spa=
n><br><span>     in_addr_t netmask;</span><br><span>     in_addr_t gateway;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int table_id;</=
span><br><span>     int metric;</span><br><span> };</span><br><span> </span=
><br><span>@@ -129,6 +136,7 @@</span><br><span>     unsigned int netbits;</=
span><br><span>     struct in6_addr gateway;</span><br><span>     int metri=
c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int table_id;=
</span><br><span>     /* gateway interface */</span><br><span> #ifdef _WIN3=
2</span><br><span>     DWORD adapter_index;        /* interface or ~0 if un=
defined */</span><br><span>@@ -223,6 +231,7 @@</span><br><span>     struct =
in6_addr remote_endpoint_ipv6; /* inside tun */</span><br><span>     struct=
 in6_addr remote_host_ipv6;   /* --remote address */</span><br><span>     i=
nt default_metric;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int default_route_table_id;</span><br><span> </span><br><span>     struc=
t route_ipv6_gateway_info rgi6;</span><br><span>     unsigned int flags;   =
              /* RG_x flags, see route_option_list */</span><br><span>@@ -2=
71,17 +280,20 @@</span><br><span>                               const char =
*network,</span><br><span>                               const char *netmas=
k,</span><br><span>                               const char *gateway,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
    const char *metric);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                              const char *metric,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                              const char=
 *table_id);</span><br><span> </span><br><span> void add_route_ipv6_to_opti=
on_list(struct route_ipv6_option_list *l,</span><br><span>                 =
                   const char *prefix,</span><br><span>                    =
                const char *gateway,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                   const char *metric);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
           const char *metric,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                   const char *table_id);</span>=
<br><span> </span><br><span> bool init_route_list(struct route_list *rl,</s=
pan><br><span>                      const struct route_option_list *opt,</s=
pan><br><span>                      const char *remote_endpoint,</span><br>=
<span>                      int default_metric,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                     int table_id,</span><br><s=
pan>                      in_addr_t remote_host,</span><br><span>          =
            struct env_set *es,</span><br><span>                      openv=
pn_net_ctx_t *ctx);</span><br><span>@@ -290,6 +302,7 @@</span><br><span>   =
                        const struct route_ipv6_option_list *opt6,</span><b=
r><span>                           const char *remote_endpoint,</span><br><=
span>                           int default_metric,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                          int table_id,</=
span><br><span>                           const struct in6_addr *remote_hos=
t,</span><br><span>                           struct env_set *es,</span><br=
><span>                           openvpn_net_ctx_t *ctx);</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/524?usp=3Demail">change 524</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede56=
17ee98bf218a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 524 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--gE87unOuKaI=--

