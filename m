From: gianmarco@...2726...
Date: Wed, 13 Mar 2024 16:01:40 +0100
Message-Id: <20240313150140.45117-1-gianmarco@...2726...>
In-Reply-To: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Route: add support for user defined
 routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Gianmarco De Gregori <gianmarco@...2726...>

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
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/524
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index abe474f..3e3b365 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -367,6 +367,14 @@
   Like ``--redirect-gateway``, but omit actually changing the default gateway.
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
 
+  ``table-id`` (Supported on Linux only, on other platforms this is a no-op).
+        Since this option must be an entirely local choice, it isn't pushable.
+        default taken from ``--route-table`` if set, otherwise :code:`0`.
+
   The default can be specified by leaving an option blank or setting it to
   :code:`default`.
 
@@ -441,14 +454,25 @@
   Setup IPv6 routing in the system to send the specified IPv6 network into
   OpenVPN's *tun*.
 
-  Valid syntax:
+  Valid syntaxes:
   ::
 
-     route-ipv6 ipv6addr/bits [gateway] [metric]
+     route-ipv6 ipv6addr/bits
+     route-ipv6 ipv6addr/bits gateway
+     route-ipv6 ipv6addr/bits gateway metric
+     route-ipv6 ipv6addr/bits gateway metric table-id
 
-  The gateway parameter is only used for IPv6 routes across *tap* devices,
-  and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or
-  ``--route-ipv6-gateway`` is used.
+  ``gateway``
+        Only used for IPv6 routes across *tap* devices,
+        and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or
+        ``--route-ipv6-gateway`` is used.
+
+  ``metric``
+        default taken from ``--route-metric`` if set, otherwise :code:`0`.
+
+  ``table-id`` (Supported on Linux only, on other platforms this is a no-op).
+        Since this option must be an entirely local choice, it isn't pushable.
+        default taken from ``--route-table`` if set, otherwise :code:`0`.
 
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
index 52b3931..5a24899 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1476,6 +1476,7 @@
     const char *gw = NULL;
     int dev = dev_type_enum(options->dev, options->dev_type);
     int metric = 0;
+    int table_id = 0; /* unspec table */
 
     /* if DCO is enabled we have both regular routes and iroutes in the system
      * routing table, and normal routes must have a higher metric for that to
@@ -1494,6 +1495,10 @@
     {
         gw = options->route_default_gateway;
     }
+    if (options->route_default_table_id)
+    {
+        table_id = options->route_default_table_id;
+    }
     if (options->route_default_metric)
     {
         metric = options->route_default_metric;
@@ -1503,6 +1508,7 @@
                         options->routes,
                         gw,
                         metric,
+                        table_id,
                         link_socket_current_remote(link_socket_info),
                         es,
                         ctx))
@@ -1521,6 +1527,7 @@
 {
     const char *gw = NULL;
     int metric = -1;            /* no metric set */
+    int table_id = 0; /* unspec table */
 
     /* see explanation in do_init_route_list() */
     if (dco_enabled(options))
@@ -1539,6 +1546,11 @@
         metric = options->route_default_metric;
     }
 
+    if (options->route_default_table_id)
+    {
+        table_id = options->route_default_table_id;
+    }
+
     /* redirect (IPv6) gateway to VPN?  if yes, add a few more specifics
      */
     if (options->routes_ipv6->flags & RG_REROUTE_GW)
@@ -1550,7 +1562,7 @@
         {
             add_route_ipv6_to_option_list( options->routes_ipv6,
                                            string_alloc(opt_list[i], options->routes_ipv6->gc),
-                                           NULL, NULL );
+                                           NULL, NULL, NULL );
         }
     }
 
@@ -1558,6 +1570,7 @@
                              options->routes_ipv6,
                              gw,
                              metric,
+                             table_id,
                              link_socket_current_remote_ipv6(link_socket_info),
                              es,
                              ctx))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 94a88f9..159bb4c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -201,6 +201,10 @@
     "                    pass --ifconfig parms by environment to scripts.\n"
     "--ifconfig-nowarn : Don't warn if the --ifconfig option on this side of the\n"
     "                    connection doesn't match the remote side.\n"
+#ifdef TARGET_LINUX
+    "--route-table table_id : Specify a custom routing table for use with --route(-ipv6).\n"
+    "                           If not specified, the id of the default routing table will be used.\n"
+#endif
     "--route network [netmask] [gateway] [metric] :\n"
     "                  Add route to routing table after connection\n"
     "                  is established.  Multiple routes can be specified.\n"
@@ -1907,6 +1911,7 @@
     SHOW_STR(route_script);
     SHOW_STR(route_default_gateway);
     SHOW_INT(route_default_metric);
+    SHOW_INT(route_default_table_id);
     SHOW_BOOL(route_noexec);
     SHOW_INT(route_delay);
     SHOW_INT(route_delay_window);
@@ -6978,7 +6983,16 @@
         cnol_check_alloc(options);
         add_client_nat_to_option_list(options->client_nat, p[1], p[2], p[3], p[4], msglevel);
     }
-    else if (streq(p[0], "route") && p[1] && !p[5])
+    else if (streq(p[0], "route-table") && p[1] && !p[2])
+    {
+#ifndef ENABLE_SITNL
+        msg(M_WARN, "NOTE: --route-table is supported only on Linux when SITNL is built-in");
+#endif
+        VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);
+        options->route_default_table_id = positive_atoi(p[1]);
+
+    }
+    else if (streq(p[0], "route") && p[1] && !p[6])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
         rol_check_alloc(options);
@@ -6999,10 +7013,31 @@
                 msg(msglevel, "route parameter gateway '%s' must be a valid address", p[3]);
                 goto err;
             }
+            /* p[4] is metric, if specified */
+
+            /* discard pulled routing table_id from server
+             * since this must be an entirely local choice */
+            if (p[5])
+            {
+                p[5] = NULL;
+            }
         }
-        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4]);
+        /* at the moment the routing table id is supported only by Linux/SITNL */
+#ifndef ENABLE_SITNL
+        if (p[5])
+        {
+            static bool route_table_warned = false;
+
+            if (!route_table_warned)
+            {
+                msg(M_WARN, "NOTE: table specified for --route, but not supported on this platform");
+                route_table_warned = true;
+            }
+        }
+#endif
+        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4], p[5]);
     }
-    else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
+    else if (streq(p[0], "route-ipv6") && p[1] && !p[5])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
         rol6_check_alloc(options);
@@ -7018,9 +7053,31 @@
                 msg(msglevel, "route-ipv6 parameter gateway '%s' must be a valid address", p[2]);
                 goto err;
             }
-            /* p[3] is metric, if present */
+            /* p[3] is metric, if specified */
+
+            /* discard pulled routing table_id from server
+             * since this must be an entirely local choice */
+            if (p[4])
+            {
+                p[4] = NULL;
+            }
         }
-        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[3]);
+
+        /* at the moment the routing table id is supported only by Linux/SITNL */
+#ifndef ENABLE_SITNL
+        if (p[4])
+        {
+            static bool route6_table_warned = false;
+
+            if (!route6_table_warned)
+            {
+                msg(M_WARN, "NOTE: table specified for --route-ipv6, but not supported on this platform");
+                route6_table_warned = true;
+            }
+        }
+#endif
+
+        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[3], p[4]);
     }
     else if (streq(p[0], "max-routes") && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2b37d1f..6a57813 100644
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
index 6c027d9..e02c28a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -325,7 +325,6 @@
 
     CLEAR(*r);
     r->option = ro;
-
     /* network */
 
     if (!is_route_parm_defined(ro->network))
@@ -439,6 +438,27 @@
 
     r->flags |= RT_DEFINED;
 
+    /* routing table id */
+
+    r->table_id = 0;
+    if (ro->table_id)
+    {
+        r->table_id = atoi(ro->table_id);
+        if (r->table_id < 0)
+        {
+            msg(M_WARN, PACKAGE_NAME "ROUTE: routing table id for network %s (%s) must be >= 0",
+                ro->network,
+                ro->table_id);
+            goto fail;
+        }
+        r->flags |= RT_TABLE_DEFINED;
+    }
+    else if (rl->spec.flags & RTSA_DEFAULT_TABLE_ID)
+    {
+        r->table_id = rl->spec.table_id;
+        r->flags |= RT_TABLE_DEFINED;
+    }
+
     return true;
 
 fail:
@@ -495,6 +515,27 @@
 
     r6->flags |= RT_DEFINED;
 
+    /* routing table id */
+
+    r6->table_id = 0;
+    if (r6o->table_id)
+    {
+        r6->table_id = atoi(r6o->table_id);
+        if (r6->table_id < 0)
+        {
+            msg(M_WARN, PACKAGE_NAME "ROUTE: routing table id for network %s (%s) must be >= 0",
+                r6o->prefix,
+                r6o->table_id);
+            goto fail;
+        }
+        r6->flags |= RT_TABLE_DEFINED;
+    }
+    else if (rl6->spec_flags & RTSA_DEFAULT_TABLE_ID)
+    {
+        r6->table_id = rl6->default_route_table_id;
+        r6->flags |= RT_TABLE_DEFINED;
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
     ro->netmask = netmask;
     ro->gateway = gateway;
     ro->metric = metric;
+    ro->table_id = table_id;
     ro->next = l->routes;
     l->routes = ro;
 
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
     ro->prefix = prefix;
     ro->gateway = gateway;
     ro->metric = metric;
+    ro->table_id = table_id;
     ro->next = l->routes_ipv6;
     l->routes_ipv6 = ro;
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
         rl->spec.flags |= RTSA_DEFAULT_METRIC;
     }
 
+    if (table_id)
+    {
+        rl->spec.table_id = table_id;
+        rl->spec.flags |= RTSA_DEFAULT_TABLE_ID;
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
         rl6->spec_flags |= RTSA_DEFAULT_METRIC;
     }
 
+    if (table_id)
+    {
+        rl6->default_route_table_id = table_id;
+        rl6->spec_flags |= RTSA_DEFAULT_TABLE_ID;
+    }
+
     msg(D_ROUTE, "GDG6: remote_host_ipv6=%s",
         remote_host_ipv6 ?  print_in6_addr(*remote_host_ipv6, 0, &gc) : "n/a" );
 
@@ -1602,9 +1661,15 @@
         metric = r->metric;
     }
 
+    int table_id = 0;
+    if (r->flags & RT_TABLE_DEFINED)
+    {
+        table_id = r->table_id;
+    }
+
     status = RTA_SUCCESS;
     int ret = net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask),
-                               &r->gateway, iface, 0, metric);
+                               &r->gateway, iface, table_id, metric);
     if (ret == -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed because route exists");
@@ -1982,10 +2047,16 @@
         metric = r6->metric;
     }
 
+    int table_id = 0;
+    if ((r6->flags & RT_TABLE_DEFINED) && (r6->table_id > 0))
+    {
+        table_id = r6->table_id;
+    }
+
     status = RTA_SUCCESS;
     int ret = net_route_v6_add(ctx, &r6->network, r6->netbits,
                                gateway_needed ? &r6->gateway : NULL,
-                               device, 0, metric);
+                               device, table_id, metric);
     if (ret == -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed because route exists");
@@ -2190,8 +2261,14 @@
         metric = r->metric;
     }
 
+    int table_id = 0;
+    if (r->flags & RT_TABLE_DEFINED)
+    {
+        table_id = r->table_id;
+    }
+
     if (net_route_v4_del(ctx, &r->network, netmask_to_netbits2(r->netmask),
-                         &r->gateway, NULL, 0, metric) < 0)
+                         &r->gateway, NULL, table_id, metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route delete command failed");
     }
@@ -2403,8 +2480,16 @@
         metric = r6->metric;
     }
 
+    int table_id = 0;
+    if (r6->flags & RT_TABLE_DEFINED)
+    {
+        table_id = r6->table_id;
+    }
+
+
+
     if (net_route_v6_del(ctx, &r6->network, r6->netbits,
-                         gateway_needed ? &r6->gateway : NULL, device, 0,
+                         gateway_needed ? &r6->gateway : NULL, device, table_id,
                          metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route v6 delete command failed");
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 71b4cf4..50883c0 100644
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
 
@@ -101,6 +104,7 @@
     const char *prefix;         /* e.g. "2001:db8:1::/64" */
     const char *gateway;        /* e.g. "2001:db8:0::2" */
     const char *metric;         /* e.g. "5" */
+    const char *table_id;
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
     unsigned int flags;                 /* RG_x flags, see route_option_list */
@@ -271,17 +279,20 @@
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
@@ -290,6 +301,7 @@
                           const struct route_ipv6_option_list *opt6,
                           const char *remote_endpoint,
                           int default_metric,
+                          int table_id,
                           const struct in6_addr *remote_host,
                           struct env_set *es,
                           openvpn_net_ctx_t *ctx);

