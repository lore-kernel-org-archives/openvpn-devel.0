From: Gert Doering <gert@...1296...>
Date: Sun, 22 Jun 2025 13:03:05 +0200
Message-ID: <20250622110311.1140-1-gert@...1296...>
In-Reply-To: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] Route: add support for user defined
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

Please note: this feature is currently supported
only by Linux/SITNL.
Support for other platforms should be added in related backends.

Trac #1399
Change-Id: I3e4ebef484d2a04a383a65ede5617ee98bf218a7
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/524
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 40b8c19..4a64e8d 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -389,6 +389,14 @@
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
@@ -463,14 +471,20 @@
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
+        and if missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or
+        ``--route-ipv6-gateway`` is used.
+
+  ``metric``
+        default taken from ``--route-metric`` if set, otherwise :code:`0`.
 
 --route-gateway arg
   Specify a default *gateway* for use with ``--route``.
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 8761826..7cef9db 100644
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
index 7d4eb85..77747a2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1566,7 +1566,7 @@
         {
             add_route_ipv6_to_option_list( options->routes_ipv6,
                                            string_alloc(opt_list[i], options->routes_ipv6->gc),
-                                           NULL, NULL );
+                                           NULL, NULL, options->route_default_table_id);
         }
     }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3cf8c2a..7e26069 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -213,6 +213,10 @@
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
@@ -829,6 +833,7 @@
     o->ce.mssfix = 0;
     o->ce.mssfix_default = true;
     o->ce.mssfix_encap = true;
+    o->route_default_table_id = 0;
     o->route_delay_window = 30;
     o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
     o->resolve_in_advance = false;
@@ -1799,6 +1804,7 @@
     SHOW_STR(route_script);
     SHOW_STR(route_default_gateway);
     SHOW_INT(route_default_metric);
+    SHOW_INT(route_default_table_id);
     SHOW_BOOL(route_noexec);
     SHOW_INT(route_delay);
     SHOW_INT(route_delay_window);
@@ -7064,6 +7070,14 @@
         cnol_check_alloc(options);
         add_client_nat_to_option_list(options->client_nat, p[1], p[2], p[3], p[4], msglevel);
     }
+    else if (streq(p[0], "route-table") && p[1] && !p[2])
+    {
+#ifndef ENABLE_SITNL
+        msg(M_WARN, "NOTE: --route-table is supported only on Linux when SITNL is built-in");
+#endif
+        VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);
+        options->route_default_table_id = positive_atoi(p[1], msglevel);
+    }
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
@@ -7085,8 +7099,9 @@
                 msg(msglevel, "route parameter gateway '%s' must be a valid address", p[3]);
                 goto err;
             }
+            /* p[4] is metric, if specified */
         }
-        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4]);
+        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4], options->route_default_table_id);
     }
     else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
     {
@@ -7104,9 +7119,9 @@
                 msg(msglevel, "route-ipv6 parameter gateway '%s' must be a valid address", p[2]);
                 goto err;
             }
-            /* p[3] is metric, if present */
+            /* p[3] is metric, if specified */
         }
-        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[3]);
+        add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[3], options->route_default_table_id);
     }
     else if (streq(p[0], "max-routes") && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 46ec32b..56e85d7 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -427,6 +427,7 @@
     const char *route_predown_script;
     const char *route_default_gateway;
     const char *route_ipv6_default_gateway;
+    int route_default_table_id;
     int route_default_metric;
     bool route_noexec;
     int route_delay;
@@ -758,6 +759,7 @@
 #define OPT_P_PEER_ID         (1<<28)
 #define OPT_P_INLINE          (1<<29)
 #define OPT_P_PUSH_MTU        (1<<30)
+#define OPT_P_ROUTE_TABLE     (1<<31)
 
 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bd79a28..156262a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -330,13 +330,11 @@
     r->option = ro;
 
     /* network */
-
     if (!is_route_parm_defined(ro->network))
     {
         goto fail;
     }
 
-
     /* get_special_addr replaces specialaddr with a special ip addr
      * like gw. getaddrinfo is called to convert a a addrinfo struct */
 
@@ -442,6 +440,9 @@
 
     r->flags |= RT_DEFINED;
 
+    /* routing table id */
+    r->table_id = ro->table_id;
+
     return true;
 
 fail:
@@ -498,6 +499,9 @@
 
     r6->flags |= RT_DEFINED;
 
+    /* routing table id */
+    r6->table_id = r6o->table_id;
+
     return true;
 
 fail:
@@ -511,7 +515,8 @@
                          const char *network,
                          const char *netmask,
                          const char *gateway,
-                         const char *metric)
+                         const char *metric,
+                         int table_id)
 {
     struct route_option *ro;
     ALLOC_OBJ_GC(ro, struct route_option, l->gc);
@@ -519,6 +524,7 @@
     ro->netmask = netmask;
     ro->gateway = gateway;
     ro->metric = metric;
+    ro->table_id = table_id;
     ro->next = l->routes;
     l->routes = ro;
 
@@ -528,13 +534,15 @@
 add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,
                               const char *prefix,
                               const char *gateway,
-                              const char *metric)
+                              const char *metric,
+                              int table_id)
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
@@ -1610,9 +1618,10 @@
         metric = r->metric;
     }
 
+
     status = RTA_SUCCESS;
     int ret = net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask),
-                               &r->gateway, iface, 0, metric);
+                               &r->gateway, iface, r->table_id, metric);
     if (ret == -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed because route exists");
@@ -2007,7 +2016,7 @@
     status = RTA_SUCCESS;
     int ret = net_route_v6_add(ctx, &r6->network, r6->netbits,
                                gateway_needed ? &r6->gateway : NULL,
-                               device, 0, metric);
+                               device, r6->table_id, metric);
     if (ret == -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed because route exists");
@@ -2227,7 +2236,7 @@
     }
 
     if (net_route_v4_del(ctx, &r->network, netmask_to_netbits2(r->netmask),
-                         &r->gateway, NULL, 0, metric) < 0)
+                         &r->gateway, NULL, r->table_id, metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route delete command failed");
     }
@@ -2452,7 +2461,7 @@
     }
 
     if (net_route_v6_del(ctx, &r6->network, r6->netbits,
-                         gateway_needed ? &r6->gateway : NULL, device, 0,
+                         gateway_needed ? &r6->gateway : NULL, device, r6->table_id,
                          metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route v6 delete command failed");
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index aa3114c..237375c 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -69,6 +69,7 @@
     in_addr_t remote_host;
     int remote_host_local; /* TLA_x value */
     struct route_bypass bypass;
+    int table_id;
     int default_metric;
 };
 
@@ -77,6 +78,7 @@
     const char *network;
     const char *netmask;
     const char *gateway;
+    int table_id;
     const char *metric;
 };
 
@@ -101,6 +103,7 @@
     const char *prefix;         /* e.g. "2001:db8:1::/64" */
     const char *gateway;        /* e.g. "2001:db8:0::2" */
     const char *metric;         /* e.g. "5" */
+    int table_id;
 };
 
 struct route_ipv6_option_list {
@@ -119,6 +122,7 @@
     in_addr_t network;
     in_addr_t netmask;
     in_addr_t gateway;
+    int table_id;
     int metric;
 };
 
@@ -129,6 +133,7 @@
     unsigned int netbits;
     struct in6_addr gateway;
     int metric;
+    int table_id;
     /* gateway interface */
 #ifdef _WIN32
     DWORD adapter_index;        /* interface or ~0 if undefined */
@@ -290,12 +295,14 @@
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

