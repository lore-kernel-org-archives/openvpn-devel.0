From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 2 Jul 2024 13:50:20 +0000
In-Reply-To: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <b116e61b1806a09dfdc364ae94fa26ce5cf72454-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="31E8QLscdhM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--31E8QLscdhM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, plais=
thos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review-1 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


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
7 files changed, 153 insertions(+), 19 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/524/5

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 84d4273..9d4235b 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -371,6 +371,14 @@
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
@@ -445,14 +453,20 @@
   Setup IPv6 routing in the system to send the specified IPv6 network into
   OpenVPN's *tun*.

-  Valid syntax:
+  Valid syntaxes:
   ::

-     route-ipv6 ipv6addr/bits [gateway] [metric]
+     route-ipv6 ipv6addr/bits
+     route-ipv6 ipv6addr/bits gateway
+     route-ipv6 ipv6addr/bits gateway metric

-  The gateway parameter is only used for IPv6 routes across *tap* devices,
-  and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or
-  ``--route-ipv6-gateway`` is used.
+  ``gateway``
+        Only used for IPv6 routes across *tap* devices,
+        and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` =
or
+        ``--route-ipv6-gateway`` is used.
+
+  ``metric``
+        default taken from ``--route-metric`` if set, otherwise :code:`0`.

 --route-gateway arg
   Specify a default *gateway* for use with ``--route``.
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index bbdbc04..2306760 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -118,7 +118,8 @@
                              print_in_addr_t(network, 0, &o->gc),
                              print_in_addr_t(netmask, 0, &o->gc),
                              NULL,
-                             NULL);
+                             NULL,
+                             o->route_default_table_id);
 }

 static void
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a49e563..8a1038b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1499,6 +1499,7 @@
                         options->routes,
                         gw,
                         metric,
+                        options->route_default_table_id,
                         link_socket_current_remote(link_socket_info),
                         es,
                         ctx))
@@ -1546,7 +1547,7 @@
         {
             add_route_ipv6_to_option_list( options->routes_ipv6,
                                            string_alloc(opt_list[i], optio=
ns->routes_ipv6->gc),
-                                           NULL, NULL );
+                                           NULL, NULL, options->route_defa=
ult_table_id);
         }
     }

@@ -1554,6 +1555,7 @@
                              options->routes_ipv6,
                              gw,
                              metric,
+                             options->route_default_table_id,
                              link_socket_current_remote_ipv6(link_socket_i=
nfo),
                              es,
                              ctx))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dbe1425..0214735 100644
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
@@ -817,6 +821,7 @@
     o->ce.mssfix =3D 0;
     o->ce.mssfix_default =3D true;
     o->ce.mssfix_encap =3D true;
+    o->route_default_table_id =3D 0;
     o->route_delay_window =3D 30;
     o->resolve_retry_seconds =3D RESOLV_RETRY_INFINITE;
     o->resolve_in_advance =3D false;
@@ -1908,6 +1913,7 @@
     SHOW_STR(route_script);
     SHOW_STR(route_default_gateway);
     SHOW_INT(route_default_metric);
+    SHOW_INT(route_default_table_id);
     SHOW_BOOL(route_noexec);
     SHOW_INT(route_delay);
     SHOW_INT(route_delay_window);
@@ -6987,6 +6993,15 @@
         cnol_check_alloc(options);
         add_client_nat_to_option_list(options->client_nat, p[1], p[2], p[3=
], p[4], msglevel);
     }
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
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
@@ -7008,8 +7023,10 @@
                 msg(msglevel, "route parameter gateway '%s' must be a vali=
d address", p[3]);
                 goto err;
             }
+            /* p[4] is metric, if specified */
         }
-        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4]);
+
+        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4], =
options->route_default_table_id);
     }
     else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
     {
@@ -7027,9 +7044,10 @@
                 msg(msglevel, "route-ipv6 parameter gateway '%s' must be a=
 valid address", p[2]);
                 goto err;
             }
-            /* p[3] is metric, if present */
+            /* p[3] is metric, if specified */
         }
-        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[=
3]);
+
+        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[=
3], options->route_default_table_id);
     }
     else if (streq(p[0], "max-routes") && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f608cb8..d3a8141 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -410,6 +410,7 @@
     const char *route_predown_script;
     const char *route_default_gateway;
     const char *route_ipv6_default_gateway;
+    int route_default_table_id;
     int route_default_metric;
     bool route_noexec;
     int route_delay;
@@ -740,6 +741,7 @@
 #define OPT_P_PEER_ID         (1<<28)
 #define OPT_P_INLINE          (1<<29)
 #define OPT_P_PUSH_MTU        (1<<30)
+#define OPT_P_ROUTE_TABLE     (1<<31)

 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 91f2032..4b61ea1 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -328,7 +328,6 @@

     CLEAR(*r);
     r->option =3D ro;
-
     /* network */

     if (!is_route_parm_defined(ro->network))
@@ -442,6 +441,27 @@

     r->flags |=3D RT_DEFINED;

+    /* routing table id */
+
+    r->table_id =3D 0;
+    if (ro->table_id)
+    {
+        r->table_id =3D ro->table_id;
+        if (r->table_id < 0)
+        {
+            msg(M_WARN, PACKAGE_NAME "ROUTE: routing table id for network =
%s (%d) must be >=3D 0",
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
@@ -498,6 +518,27 @@

     r6->flags |=3D RT_DEFINED;

+    /* routing table id */
+
+    r6->table_id =3D 0;
+    if (r6o->table_id)
+    {
+        r6->table_id =3D r6o->table_id;
+        if (r6->table_id < 0)
+        {
+            msg(M_WARN, PACKAGE_NAME "ROUTE: routing table id for network =
%s (%d) must be >=3D 0",
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
@@ -511,7 +552,8 @@
                          const char *network,
                          const char *netmask,
                          const char *gateway,
-                         const char *metric)
+                         const char *metric,
+                         int table_id)
 {
     struct route_option *ro;
     ALLOC_OBJ_GC(ro, struct route_option, l->gc);
@@ -519,6 +561,7 @@
     ro->netmask =3D netmask;
     ro->gateway =3D gateway;
     ro->metric =3D metric;
+    ro->table_id =3D table_id;
     ro->next =3D l->routes;
     l->routes =3D ro;

@@ -528,13 +571,15 @@
 add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,
                               const char *prefix,
                               const char *gateway,
-                              const char *metric)
+                              const char *metric,
+                              int table_id)
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
@@ -632,6 +677,7 @@
                 const struct route_option_list *opt,
                 const char *remote_endpoint,
                 int default_metric,
+                int table_id,
                 in_addr_t remote_host,
                 struct env_set *es,
                 openvpn_net_ctx_t *ctx)
@@ -655,6 +701,12 @@
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
@@ -791,6 +843,7 @@
                      const struct route_ipv6_option_list *opt6,
                      const char *remote_endpoint,
                      int default_metric,
+                     int table_id,
                      const struct in6_addr *remote_host_ipv6,
                      struct env_set *es,
                      openvpn_net_ctx_t *ctx)
@@ -815,6 +868,12 @@
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

@@ -1608,9 +1667,15 @@
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
@@ -1988,10 +2053,16 @@
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
@@ -2196,8 +2267,14 @@
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
@@ -2409,8 +2486,16 @@
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
index 421e7d2..815aea6 100644
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
+    int table_id;
     const char *metric;
 };

@@ -101,6 +104,7 @@
     const char *prefix;         /* e.g. "2001:db8:1::/64" */
     const char *gateway;        /* e.g. "2001:db8:0::2" */
     const char *metric;         /* e.g. "5" */
+    int table_id;
 };

 struct route_ipv6_option_list {
@@ -113,12 +117,14 @@
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

@@ -129,6 +135,7 @@
     unsigned int netbits;
     struct in6_addr gateway;
     int metric;
+    int table_id;
     /* gateway interface */
 #ifdef _WIN32
     DWORD adapter_index;        /* interface or ~0 if undefined */
@@ -223,6 +230,7 @@
     struct in6_addr remote_endpoint_ipv6; /* inside tun */
     struct in6_addr remote_host_ipv6;   /* --remote address */
     int default_metric;
+    int default_route_table_id;

     struct route_ipv6_gateway_info rgi6;
     unsigned int flags;                 /* RG_x flags, see route_option_li=
st */
@@ -283,17 +291,20 @@
                               const char *network,
                               const char *netmask,
                               const char *gateway,
-                              const char *metric);
+                              const char *metric,
+                              int table_id);

 void add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,
                                    const char *prefix,
                                    const char *gateway,
-                                   const char *metric);
+                                   const char *metric,
+                                   int table_id);

 bool init_route_list(struct route_list *rl,
                      const struct route_option_list *opt,
                      const char *remote_endpoint,
                      int default_metric,
+                     int table_id,
                      in_addr_t remote_host,
                      struct env_set *es,
                      openvpn_net_ctx_t *ctx);
@@ -302,6 +313,7 @@
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
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--31E8QLscdhM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, its_Giaan, p=
laisthos. </p>
<p>its_Giaan <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review-1 by cron2</p><p>The change is n=
o longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisfi=
ed now.</p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">Route: add support for user defined routing table<br><br>Add the ab=
ility for users to specify a custom<br>routing table where routes should be=
 installed in.<br>As of now routes are always installed in the main<br>rout=
ing table of the operating system, however,<br>with the new --route-table o=
ption it is possibile<br>to specify the ID of the default routing table<br>=
to be used by --route(-ipv6).<br><br>Please note: this feature is currently=
 supported<br>only by Linux/SITNL.<br>Support for other platforms should be=
 added in related backends.<br><br>Fixes: Trac #1399<br>Change-Id: I3e4ebef=
484d2a04a383a65ede5617ee98bf218a7<br>Signed-off-by: Gianmarco De Gregori &l=
t;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/vpn-network-options=
.rst<br>M src/openvpn/helper.c<br>M src/openvpn/init.c<br>M src/openvpn/opt=
ions.c<br>M src/openvpn/options.h<br>M src/openvpn/route.c<br>M src/openvpn=
/route.h<br>7 files changed, 153 insertions(+), 19 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/524/5</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/=
vpn-network-options.rst</span><br><span>index 84d4273..9d4235b 100644</span=
><br><span>--- a/doc/man-sections/vpn-network-options.rst</span><br><span>+=
++ b/doc/man-sections/vpn-network-options.rst</span><br><span>@@ -371,6 +37=
1,14 @@</span><br><span>   Like ``--redirect-gateway``, but omit actually c=
hanging the default gateway.</span><br><span>   Useful when pushing private=
 subnets.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+--route-table id</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  Specify a default table id for use with --route.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  By default, OpenVPN installs routes i=
n the main routing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 table of the operating system, but with this option,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  a user defined routing table can be use=
d instead.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  (Supported on Linux only, =
on other platforms this is a no-op).</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> --route args</span><br><span>   Add rout=
e to routing table after connection is established. Multiple</span><br><spa=
n>   routes can be specified. Routes will be automatically torn down in</sp=
an><br><span>@@ -445,14 +453,20 @@</span><br><span>   Setup IPv6 routing in=
 the system to send the specified IPv6 network into</span><br><span>   Open=
VPN&#39;s *tun*.</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  Valid syntax:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  Valid syntaxes:</span><br><span>   ::</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     route-ipv6 ipv6addr/bits =
[gateway] [metric]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    route-ipv6 ipv6addr/bits</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     route-ipv6 ipv6addr/bits gateway</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     route-ipv6 ipv6addr/bits gateway metric</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The g=
ateway parameter is only used for IPv6 routes across *tap* devices,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  and if missing, the ``ipv6r=
emote`` field from ``--ifconfig-ipv6`` or</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  ``--route-ipv6-gateway`` is used.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  ``gateway``</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        Only used for IPv6 routes across *tap=
* devices,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
nd if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ``--route-ipv6-gate=
way`` is used.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``metric``</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        default taken from ``--=
route-metric`` if set, otherwise :code:`0`.</span><br><span> </span><br><sp=
an> --route-gateway arg</span><br><span>   Specify a default *gateway* for =
use with ``--route``.</span><br><span>diff --git a/src/openvpn/helper.c b/s=
rc/openvpn/helper.c</span><br><span>index bbdbc04..2306760 100644</span><br=
><span>--- a/src/openvpn/helper.c</span><br><span>+++ b/src/openvpn/helper.=
c</span><br><span>@@ -118,7 +118,8 @@</span><br><span>                     =
         print_in_addr_t(network, 0, &amp;o-&gt;gc),</span><br><span>      =
                        print_in_addr_t(netmask, 0, &amp;o-&gt;gc),</span><=
br><span>                              NULL,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                             NULL);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                             NULL,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
        o-&gt;route_default_table_id);</span><br><span> }</span><br><span> =
</span><br><span> static void</span><br><span>diff --git a/src/openvpn/init=
.c b/src/openvpn/init.c</span><br><span>index a49e563..8a1038b 100644</span=
><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.=
c</span><br><span>@@ -1499,6 +1499,7 @@</span><br><span>                   =
      options-&gt;routes,</span><br><span>                         gw,</spa=
n><br><span>                         metric,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        options-&gt;route_default_=
table_id,</span><br><span>                         link_socket_current_remo=
te(link_socket_info),</span><br><span>                         es,</span><b=
r><span>                         ctx))</span><br><span>@@ -1546,7 +1547,7 @=
@</span><br><span>         {</span><br><span>             add_route_ipv6_to=
_option_list( options-&gt;routes_ipv6,</span><br><span>                    =
                        string_alloc(opt_list[i], options-&gt;routes_ipv6-&=
gt;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                             NULL, NULL );</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                           NULL, NUL=
L, options-&gt;route_default_table_id);</span><br><span>         }</span><b=
r><span>     }</span><br><span> </span><br><span>@@ -1554,6 +1555,7 @@</spa=
n><br><span>                              options-&gt;routes_ipv6,</span><b=
r><span>                              gw,</span><br><span>                 =
             metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                             options-&gt;route_default_table_id,</span><br=
><span>                              link_socket_current_remote_ipv6(link_s=
ocket_info),</span><br><span>                              es,</span><br><s=
pan>                              ctx))</span><br><span>diff --git a/src/op=
envpn/options.c b/src/openvpn/options.c</span><br><span>index dbe1425..0214=
735 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ =
b/src/openvpn/options.c</span><br><span>@@ -201,6 +201,10 @@</span><br><spa=
n>     &quot;                    pass --ifconfig parms by environment to sc=
ripts.\n&quot;</span><br><span>     &quot;--ifconfig-nowarn : Don&#39;t war=
n if the --ifconfig option on this side of the\n&quot;</span><br><span>    =
 &quot;                    connection doesn&#39;t match the remote side.\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_=
LINUX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--ro=
ute-table table_id : Specify a custom routing table for use with --route(-i=
pv6).\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &q=
uot;                           If not specified, the id of the default rout=
ing table will be used.\n&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span>     &quot;--route network [netmask] [ga=
teway] [metric] :\n&quot;</span><br><span>     &quot;                  Add =
route to routing table after connection\n&quot;</span><br><span>     &quot;=
                  is established.  Multiple routes can be specified.\n&quot=
;</span><br><span>@@ -817,6 +821,7 @@</span><br><span>     o-&gt;ce.mssfix =
=3D 0;</span><br><span>     o-&gt;ce.mssfix_default =3D true;</span><br><sp=
an>     o-&gt;ce.mssfix_encap =3D true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    o-&gt;route_default_table_id =3D 0;</span><br><span=
>     o-&gt;route_delay_window =3D 30;</span><br><span>     o-&gt;resolve_r=
etry_seconds =3D RESOLV_RETRY_INFINITE;</span><br><span>     o-&gt;resolve_=
in_advance =3D false;</span><br><span>@@ -1908,6 +1913,7 @@</span><br><span=
>     SHOW_STR(route_script);</span><br><span>     SHOW_STR(route_default_g=
ateway);</span><br><span>     SHOW_INT(route_default_metric);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    SHOW_INT(route_default_table_=
id);</span><br><span>     SHOW_BOOL(route_noexec);</span><br><span>     SHO=
W_INT(route_delay);</span><br><span>     SHOW_INT(route_delay_window);</spa=
n><br><span>@@ -6987,6 +6993,15 @@</span><br><span>         cnol_check_allo=
c(options);</span><br><span>         add_client_nat_to_option_list(options-=
&gt;client_nat, p[1], p[2], p[3], p[4], msglevel);</span><br><span>     }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[=
0], &quot;route-table&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#ifndef ENABLE_SITNL</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;NOTE: --route-table=
 is supported only on Linux when SITNL is built-in&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;rou=
te_default_table_id =3D positive_atoi(p[1]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span>     else if (streq(p[0], &quot;route&quot;) &a=
mp;&amp; p[1] &amp;&amp; !p[5])</span><br><span>     {</span><br><span>    =
     VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span>@@ -7008,8 +7023,10 @@=
</span><br><span>                 msg(msglevel, &quot;route parameter gatew=
ay &#39;%s&#39; must be a valid address&quot;, p[3]);</span><br><span>     =
            goto err;</span><br><span>             }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* p[4] is metric, if specifi=
ed */</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        add_route_to_option_list(options-&gt;routes, p[1], p[2],=
 p[3], p[4]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_route_to_opti=
on_list(options-&gt;routes, p[1], p[2], p[3], p[4], options-&gt;route_defau=
lt_table_id);</span><br><span>     }</span><br><span>     else if (streq(p[=
0], &quot;route-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><sp=
an>     {</span><br><span>@@ -7027,9 +7044,10 @@</span><br><span>          =
       msg(msglevel, &quot;route-ipv6 parameter gateway &#39;%s&#39; must b=
e a valid address&quot;, p[2]);</span><br><span>                 goto err;<=
/span><br><span>             }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            /* p[3] is metric, if present */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* p[3] is metric, if specifi=
ed */</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        add_route_ipv6_to_option_list(options-&gt;routes_ipv6, p=
[1], p[2], p[3]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_route_ipv=
6_to_option_list(options-&gt;routes_ipv6, p[1], p[2], p[3], options-&gt;rou=
te_default_table_id);</span><br><span>     }</span><br><span>     else if (=
streq(p[0], &quot;max-routes&quot;) &amp;&amp; !p[2])</span><br><span>     =
{</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/options.=
h</span><br><span>index f608cb8..d3a8141 100644</span><br><span>--- a/src/o=
penvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><spa=
n>@@ -410,6 +410,7 @@</span><br><span>     const char *route_predown_script=
;</span><br><span>     const char *route_default_gateway;</span><br><span> =
    const char *route_ipv6_default_gateway;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int route_default_table_id;</span><br><span>   =
  int route_default_metric;</span><br><span>     bool route_noexec;</span><=
br><span>     int route_delay;</span><br><span>@@ -740,6 +741,7 @@</span><b=
r><span> #define OPT_P_PEER_ID         (1&lt;&lt;28)</span><br><span> #defi=
ne OPT_P_INLINE          (1&lt;&lt;29)</span><br><span> #define OPT_P_PUSH_=
MTU        (1&lt;&lt;30)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define OPT_P_ROUTE_TABLE     (1&lt;&lt;31)</span><br><span> </span><b=
r><span> #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/=
route.c</span><br><span>index 91f2032..4b61ea1 100644</span><br><span>--- a=
/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><s=
pan>@@ -328,7 +328,6 @@</span><br><span> </span><br><span>     CLEAR(*r);</=
span><br><span>     r-&gt;option =3D ro;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span>     /* network */</span><br><span> </s=
pan><br><span>     if (!is_route_parm_defined(ro-&gt;network))</span><br><s=
pan>@@ -442,6 +441,27 @@</span><br><span> </span><br><span>     r-&gt;flags=
 |=3D RT_DEFINED;</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* routing table id */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    r-&gt;table_id =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (ro-&gt;table_id)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        r-&gt;table_id =3D ro-&gt;table_id;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (r-&gt;table_id &lt; 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(M_WARN, PACKAGE_NAME &quot;RO=
UTE: routing table id for network %s (%d) must be &gt;=3D 0&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                ro-&gt;netwo=
rk,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
ro-&gt;table_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          goto fail;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
-&gt;flags |=3D RT_TABLE_DEFINED;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else if (rl-&gt;spec.flags &amp; RTSA_DEFAULT_TABLE_ID)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        r-&gt;table_id =3D rl-&gt;spec.table_id;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r-&gt;flags =
|=3D RT_TABLE_DEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     return true;</span><br><span> </span><br><span> fail:</span><br>=
<span>@@ -498,6 +518,27 @@</span><br><span> </span><br><span>     r6-&gt;fl=
ags |=3D RT_DEFINED;</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* routing table id */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    r6-&gt;table_id =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (r6o-&gt;table_id)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        r6-&gt;table_id =3D r6o-&gt;table_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (r6-&gt;table_id &lt; 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, PACKAGE_NAM=
E &quot;ROUTE: routing table id for network %s (%d) must be &gt;=3D 0&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                r6=
o-&gt;prefix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          r6o-&gt;table_id);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            goto fail;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        r6-&gt;flags |=3D RT_TABLE_DEFINED;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (rl6-&gt;spec_flags &amp; RTSA_DEFAULT_TABLE_ID)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        r6-&gt;table_id =3D rl6-&gt;=
default_route_table_id;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        r6-&gt;flags |=3D RT_TABLE_DEFINED;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     return true;</span><br><span> </span><b=
r><span> fail:</span><br><span>@@ -511,7 +552,8 @@</span><br><span>        =
                  const char *network,</span><br><span>                    =
      const char *netmask,</span><br><span>                          const =
char *gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                  const char *metric)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                         const char *metric,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                         int tab=
le_id)</span><br><span> {</span><br><span>     struct route_option *ro;</sp=
an><br><span>     ALLOC_OBJ_GC(ro, struct route_option, l-&gt;gc);</span><b=
r><span>@@ -519,6 +561,7 @@</span><br><span>     ro-&gt;netmask =3D netmask=
;</span><br><span>     ro-&gt;gateway =3D gateway;</span><br><span>     ro-=
&gt;metric =3D metric;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ro-&gt;table_id =3D table_id;</span><br><span>     ro-&gt;next =3D l=
-&gt;routes;</span><br><span>     l-&gt;routes =3D ro;</span><br><span> </s=
pan><br><span>@@ -528,13 +571,15 @@</span><br><span> add_route_ipv6_to_opti=
on_list(struct route_ipv6_option_list *l,</span><br><span>                 =
              const char *prefix,</span><br><span>                         =
      const char *gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                              const char *metric)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                              const char=
 *metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                    int table_id)</span><br><span> {</span><br><span>     s=
truct route_ipv6_option *ro;</span><br><span>     ALLOC_OBJ_GC(ro, struct r=
oute_ipv6_option, l-&gt;gc);</span><br><span>     ro-&gt;prefix =3D prefix;=
</span><br><span>     ro-&gt;gateway =3D gateway;</span><br><span>     ro-&=
gt;metric =3D metric;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ro-&gt;table_id =3D table_id;</span><br><span>     ro-&gt;next =3D l-=
&gt;routes_ipv6;</span><br><span>     l-&gt;routes_ipv6 =3D ro;</span><br><=
span> }</span><br><span>@@ -632,6 +677,7 @@</span><br><span>               =
  const struct route_option_list *opt,</span><br><span>                 con=
st char *remote_endpoint,</span><br><span>                 int default_metr=
ic,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
int table_id,</span><br><span>                 in_addr_t remote_host,</span=
><br><span>                 struct env_set *es,</span><br><span>           =
      openvpn_net_ctx_t *ctx)</span><br><span>@@ -655,6 +701,12 @@</span><b=
r><span>         rl-&gt;spec.flags |=3D RTSA_DEFAULT_METRIC;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (table_id)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
l-&gt;spec.table_id =3D table_id;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        rl-&gt;spec.flags |=3D RTSA_DEFAULT_TABLE_ID;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     get_default_gateway=
(&amp;rl-&gt;rgi, ctx);</span><br><span>     if (rl-&gt;rgi.flags &amp; RGI=
_ADDR_DEFINED)</span><br><span>     {</span><br><span>@@ -791,6 +843,7 @@</=
span><br><span>                      const struct route_ipv6_option_list *o=
pt6,</span><br><span>                      const char *remote_endpoint,</sp=
an><br><span>                      int default_metric,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     int table_id,</span=
><br><span>                      const struct in6_addr *remote_host_ipv6,</=
span><br><span>                      struct env_set *es,</span><br><span>  =
                    openvpn_net_ctx_t *ctx)</span><br><span>@@ -815,6 +868,=
12 @@</span><br><span>         rl6-&gt;spec_flags |=3D RTSA_DEFAULT_METRIC;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (table_id)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        rl6-&gt;default_route_table_id =3D table_id;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        rl6-&gt;spec_flags |=3D RTSA=
_DEFAULT_TABLE_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     msg(D_ROUTE, &quot;GDG6: remote_host_ipv6=3D%s&quot;,</span><br><spa=
n>         remote_host_ipv6 ?  print_in6_addr(*remote_host_ipv6, 0, &amp;gc=
) : &quot;n/a&quot; );</span><br><span> </span><br><span>@@ -1608,9 +1667,1=
5 @@</span><br><span>         metric =3D r-&gt;metric;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int table_id =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (r-&gt;flags &amp; RT_TABLE_DEFINED)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        table_id =3D r-&gt;table_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     status =3D RTA_SUCCESS;</span><br=
><span>     int ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, netmask_t=
o_netbits2(r-&gt;netmask),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                               &amp;r-&gt;gateway, iface, 0, metric);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
           &amp;r-&gt;gateway, iface, table_id, metric);</span><br><span>  =
   if (ret =3D=3D -EEXIST)</span><br><span>     {</span><br><span>         =
msg(D_ROUTE, &quot;NOTE: Linux route add command failed because route exist=
s&quot;);</span><br><span>@@ -1988,10 +2053,16 @@</span><br><span>         =
metric =3D r6-&gt;metric;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int table_id =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((r6-&gt;flags &a=
mp; RT_TABLE_DEFINED) &amp;&amp; (r6-&gt;table_id &gt; 0))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        table_id =3D r6-&gt;table_id;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     status =3D RTA_SUCCESS;<=
/span><br><span>     int ret =3D net_route_v6_add(ctx, &amp;r6-&gt;network,=
 r6-&gt;netbits,</span><br><span>                                gateway_ne=
eded ? &amp;r6-&gt;gateway : NULL,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                               device, 0, metric);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
device, table_id, metric);</span><br><span>     if (ret =3D=3D -EEXIST)</sp=
an><br><span>     {</span><br><span>         msg(D_ROUTE, &quot;NOTE: Linux=
 route add command failed because route exists&quot;);</span><br><span>@@ -=
2196,8 +2267,14 @@</span><br><span>         metric =3D r-&gt;metric;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int table_id =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (r-&gt;flags &amp; RT_TABLE_DEFINED)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        table_id =3D r-&gt;table_id;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (net_route_v4_de=
l(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask),</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                         &amp;r-&g=
t;gateway, NULL, 0, metric) &lt; 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                         &amp;r-&gt;gateway, NULL, table_id=
, metric) &lt; 0)</span><br><span>     {</span><br><span>         msg(M_WAR=
N, &quot;ERROR: Linux route delete command failed&quot;);</span><br><span> =
    }</span><br><span>@@ -2409,8 +2486,16 @@</span><br><span>         metri=
c =3D r6-&gt;metric;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int table_id =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (r6-&gt;flags &amp; RT=
_TABLE_DEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        table_id =
=3D r6-&gt;table_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     if (net_route_v6_del(ctx, &am=
p;r6-&gt;network, r6-&gt;netbits,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                         gateway_needed ? &amp;r6-&gt;gateway :=
 NULL, device, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                       gateway_needed ? &amp;r6-&gt;gateway : NULL, device,=
 table_id,</span><br><span>                          metric) &lt; 0)</span>=
<br><span>     {</span><br><span>         msg(M_WARN, &quot;ERROR: Linux ro=
ute v6 delete command failed&quot;);</span><br><span>diff --git a/src/openv=
pn/route.h b/src/openvpn/route.h</span><br><span>index 421e7d2..815aea6 100=
644</span><br><span>--- a/src/openvpn/route.h</span><br><span>+++ b/src/ope=
nvpn/route.h</span><br><span>@@ -63,12 +63,14 @@</span><br><span> #define R=
TSA_REMOTE_ENDPOINT  (1&lt;&lt;0)</span><br><span> #define RTSA_REMOTE_HOST=
      (1&lt;&lt;1)</span><br><span> #define RTSA_DEFAULT_METRIC   (1&lt;&lt=
;2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RTSA_DEF=
AULT_TABLE_ID (1&lt;&lt;3)</span><br><span>     unsigned int flags;</span><=
br><span> </span><br><span>     in_addr_t remote_endpoint;</span><br><span>=
     in_addr_t remote_host;</span><br><span>     int remote_host_local; /* =
TLA_x value */</span><br><span>     struct route_bypass bypass;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int table_id;</span><br><sp=
an>     int default_metric;</span><br><span> };</span><br><span> </span><br=
><span>@@ -77,6 +79,7 @@</span><br><span>     const char *network;</span><b=
r><span>     const char *netmask;</span><br><span>     const char *gateway;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int table_id;</=
span><br><span>     const char *metric;</span><br><span> };</span><br><span=
> </span><br><span>@@ -101,6 +104,7 @@</span><br><span>     const char *pre=
fix;         /* e.g. &quot;2001:db8:1::/64&quot; */</span><br><span>     co=
nst char *gateway;        /* e.g. &quot;2001:db8:0::2&quot; */</span><br><s=
pan>     const char *metric;         /* e.g. &quot;5&quot; */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int table_id;</span><br><span=
> };</span><br><span> </span><br><span> struct route_ipv6_option_list {</sp=
an><br><span>@@ -113,12 +117,14 @@</span><br><span> #define RT_DEFINED     =
   (1&lt;&lt;0)</span><br><span> #define RT_ADDED          (1&lt;&lt;1)</sp=
an><br><span> #define RT_METRIC_DEFINED (1&lt;&lt;2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define RT_TABLE_DEFINED  (1&lt;&lt;3)</s=
pan><br><span>     struct route_ipv4 *next;</span><br><span>     unsigned i=
nt flags;</span><br><span>     const struct route_option *option;</span><br=
><span>     in_addr_t network;</span><br><span>     in_addr_t netmask;</spa=
n><br><span>     in_addr_t gateway;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int table_id;</span><br><span>     int metric;</span><b=
r><span> };</span><br><span> </span><br><span>@@ -129,6 +135,7 @@</span><br=
><span>     unsigned int netbits;</span><br><span>     struct in6_addr gate=
way;</span><br><span>     int metric;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int table_id;</span><br><span>     /* gateway interfa=
ce */</span><br><span> #ifdef _WIN32</span><br><span>     DWORD adapter_ind=
ex;        /* interface or ~0 if undefined */</span><br><span>@@ -223,6 +23=
0,7 @@</span><br><span>     struct in6_addr remote_endpoint_ipv6; /* inside=
 tun */</span><br><span>     struct in6_addr remote_host_ipv6;   /* --remot=
e address */</span><br><span>     int default_metric;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int default_route_table_id;</span><br=
><span> </span><br><span>     struct route_ipv6_gateway_info rgi6;</span><b=
r><span>     unsigned int flags;                 /* RG_x flags, see route_o=
ption_list */</span><br><span>@@ -283,17 +291,20 @@</span><br><span>       =
                        const char *network,</span><br><span>              =
                 const char *netmask,</span><br><span>                     =
          const char *gateway,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                              const char *metric);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                              const=
 char *metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                         int table_id);</span><br><span> </span><br><span> =
void add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,</span>=
<br><span>                                    const char *prefix,</span><br=
><span>                                    const char *gateway,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
  const char *metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                   const char *metric,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                   in=
t table_id);</span><br><span> </span><br><span> bool init_route_list(struct=
 route_list *rl,</span><br><span>                      const struct route_o=
ption_list *opt,</span><br><span>                      const char *remote_e=
ndpoint,</span><br><span>                      int default_metric,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                     int tab=
le_id,</span><br><span>                      in_addr_t remote_host,</span><=
br><span>                      struct env_set *es,</span><br><span>        =
              openvpn_net_ctx_t *ctx);</span><br><span>@@ -302,6 +313,7 @@<=
/span><br><span>                           const struct route_ipv6_option_l=
ist *opt6,</span><br><span>                           const char *remote_en=
dpoint,</span><br><span>                           int default_metric,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
  int table_id,</span><br><span>                           const struct in6=
_addr *remote_host,</span><br><span>                           struct env_s=
et *es,</span><br><span>                           openvpn_net_ctx_t *ctx);=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/524?usp=3Demail">change 524</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/524?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede56=
17ee98bf218a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 524 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--31E8QLscdhM=--

