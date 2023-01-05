From: selva.nair@...277...
Date: Wed,  4 Jan 2023 21:27:18 -0500
Message-Id: <20230105022718.1641751-3-selva.nair@...277...>
In-Reply-To: <20230105022718.1641751-1-selva.nair@...277...>
References: <20230105022718.1641751-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Propagate route error to
 initialization_completed()
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

From: Selva Nair <selva.nair@...277...>

Makes it possible to report management state as CONNECTED,ROUTE_ERROR
instead of CONNECTED,SUCCESS in case of routing errors.

This depends on treating "route already exists" as not
an error which right now works when using netlink on Linux
and IPAPI or iservice on Windows.

For route set via command line there is no easy way to get this
information and current behaviour is unchanged: i.e., the management
state continues to be reported as CONNECTED,SUCCESS.

Status notification to systemd is not affected.

To test on Linux, build with netlink and use a --route option with
an unreachable gateway like:
"--route 192.168.122.0 255.255.255.0 1.1.1.1"

Notes:
On windows, if the route method is "exe", setting a route
that exists *may* get logged as error and this patch will lead to
a slightly misleading CONNECTED,ROUTE_ERROR state message. This is
considered tolerable as no one should be using "exe" (i.e. route.exe)
as the route method.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/forward.c | 10 +++--
 src/openvpn/init.c    | 42 +++++++++++++------
 src/openvpn/init.h    | 10 ++---
 src/openvpn/route.c   | 97 +++++++++++++++++--------------------------
 src/openvpn/route.h   | 18 +++-----
 5 files changed, 85 insertions(+), 92 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index af4ed05d..d7b0a2d3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -405,12 +405,16 @@ send_control_channel_string(struct context *c, const char *str, int msglevel)
 static void
 check_add_routes_action(struct context *c, const bool errors)
 {
-    do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
-             c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
+    bool route_status = do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
+                                 c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
+
+    int flags = (errors ? ISC_ERRORS : 0);
+    flags |= (!route_status ? ISC_ROUTE_ERRORS : 0);
+
     update_time();
     event_timeout_clear(&c->c2.route_wakeup);
     event_timeout_clear(&c->c2.route_wakeup_expire);
-    initialization_sequence_completed(c, errors ? ISC_ERRORS : 0); /* client/p2p --route-delay was defined */
+    initialization_sequence_completed(c, flags); /* client/p2p --route-delay was defined */
 }
 
 static void
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2e95256c..a5e7399a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1648,6 +1648,15 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
         {
             detail = "ERROR";
         }
+        /* Flag route error only on platforms where trivial "already exists" errors
+         * are filtered out. Currently this is the case on Windows or if usng netlink.
+         */
+#if defined(_WIN32) || defined(ENABLE_SITNL)
+        else if (flags & ISC_ROUTE_ERRORS)
+        {
+            detail = "ROUTE_ERROR";
+        }
+#endif
 
         CLEAR(local);
         actual = &get_link_socket_info(c)->lsa->actual;
@@ -1697,7 +1706,7 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
  * Possibly add routes and/or call route-up script
  * based on options.
  */
-void
+bool
 do_route(const struct options *options,
          struct route_list *route_list,
          struct route_ipv6_list *route_ipv6_list,
@@ -1706,10 +1715,11 @@ do_route(const struct options *options,
          struct env_set *es,
          openvpn_net_ctx_t *ctx)
 {
+    bool ret = true;
     if (!options->route_noexec && ( route_list || route_ipv6_list ) )
     {
-        add_routes(route_list, route_ipv6_list, tt, ROUTE_OPTION_FLAGS(options),
-                   es, ctx);
+        ret = add_routes(route_list, route_ipv6_list, tt, ROUTE_OPTION_FLAGS(options),
+                         es, ctx);
         setenv_int(es, "redirect_gateway", route_did_redirect_default_gateway(route_list));
     }
 #ifdef ENABLE_MANAGEMENT
@@ -1748,6 +1758,7 @@ do_route(const struct options *options,
         show_adapters(D_SHOW_NET|M_NOPREFIX);
     }
 #endif
+    return ret;
 }
 
 /*
@@ -1798,10 +1809,11 @@ can_preserve_tun(struct tuntap *tt)
 }
 
 static bool
-do_open_tun(struct context *c)
+do_open_tun(struct context *c, int *error_flags)
 {
     struct gc_arena gc = gc_new();
     bool ret = false;
+    *error_flags = 0;
 
     if (!can_preserve_tun(c->c1.tuntap))
     {
@@ -1868,8 +1880,9 @@ do_open_tun(struct context *c)
         if (route_order() == ROUTE_BEFORE_TUN)
         {
             /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be ignored */
-            do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
-                     c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
+            bool status = do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
+                                   c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
+            *error_flags |= (status ? 0 : ISC_ROUTE_ERRORS);
         }
 #ifdef TARGET_ANDROID
         /* Store the old fd inside the fd so open_tun can use it */
@@ -1930,8 +1943,9 @@ do_open_tun(struct context *c)
         /* possibly add routes */
         if ((route_order() == ROUTE_AFTER_TUN) && (!c->options.route_delay_defined))
         {
-            do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
-                     c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
+            int status = do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
+                                  c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
+            *error_flags |= (status ? 0 : ISC_ROUTE_ERRORS);
         }
 
         ret = true;
@@ -2227,6 +2241,7 @@ do_deferred_options_part2(struct context *c)
 bool
 do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
 {
+    int error_flags = 0;
     if (!c->c2.do_up_ran)
     {
         reset_coarse_timers(c);
@@ -2243,7 +2258,7 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
         /* if --up-delay specified, open tun, do ifconfig, and run up script now */
         if (c->options.up_delay || PULL_DEFINED(&c->options))
         {
-            c->c2.did_open_tun = do_open_tun(c);
+            c->c2.did_open_tun = do_open_tun(c, &error_flags);
             update_time();
 
             /*
@@ -2272,7 +2287,7 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
                 else
                 {
                     management_sleep(1);
-                    c->c2.did_open_tun = do_open_tun(c);
+                    c->c2.did_open_tun = do_open_tun(c, &error_flags);
                     update_time();
                 }
             }
@@ -2345,12 +2360,12 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
             }
             else
             {
-                initialization_sequence_completed(c, 0); /* client/p2p --route-delay undefined */
+                initialization_sequence_completed(c, error_flags); /* client/p2p --route-delay undefined */
             }
         }
         else if (c->options.mode == MODE_POINT_TO_POINT)
         {
-            initialization_sequence_completed(c, 0); /* client/p2p restart with --persist-tun */
+            initialization_sequence_completed(c, error_flags); /* client/p2p restart with --persist-tun */
         }
 
         c->c2.do_up_ran = true;
@@ -4483,7 +4498,8 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
      * open tun/tap device, ifconfig, run up script, etc. */
     if (!(options->up_delay || PULL_DEFINED(options)) && (c->mode == CM_P2P || c->mode == CM_TOP))
     {
-        c->c2.did_open_tun = do_open_tun(c);
+        int error_flags = 0;
+        c->c2.did_open_tun = do_open_tun(c, &error_flags);
     }
 
     c->c2.frame_initial = c->c2.frame;
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index d0fb6ea1..2315b3ca 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -71,12 +71,9 @@ void init_instance(struct context *c, const struct env_set *env, const unsigned
  */
 void init_query_passwords(const struct context *c);
 
-void do_route(const struct options *options,
-              struct route_list *route_list,
-              struct route_ipv6_list *route_ipv6_list,
-              const struct tuntap *tt,
-              const struct plugin_list *plugins,
-              struct env_set *es,
+bool do_route(const struct options *options, struct route_list *route_list,
+              struct route_ipv6_list *route_ipv6_list, const struct tuntap *tt,
+              const struct plugin_list *plugins, struct env_set *es,
               openvpn_net_ctx_t *ctx);
 
 void close_instance(struct context *c);
@@ -116,6 +113,7 @@ void free_context_buffers(struct context_buffers *b);
 
 #define ISC_ERRORS (1<<0)
 #define ISC_SERVER (1<<1)
+#define ISC_ROUTE_ERRORS (1<<2)
 void initialization_sequence_completed(struct context *c, const unsigned int flags);
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index b4a9d56a..d406770d 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -907,7 +907,7 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
     return ret;
 }
 
-static void
+static bool
 add_route3(in_addr_t network,
            in_addr_t netmask,
            in_addr_t gateway,
@@ -923,7 +923,7 @@ add_route3(in_addr_t network,
     r.network = network;
     r.netmask = netmask;
     r.gateway = gateway;
-    add_route(&r, tt, flags, rgi, es, ctx);
+    return add_route(&r, tt, flags, rgi, es, ctx);
 }
 
 static void
@@ -945,7 +945,7 @@ del_route3(in_addr_t network,
     delete_route(&r, tt, flags, rgi, es, ctx);
 }
 
-static void
+static bool
 add_bypass_routes(struct route_bypass *rb,
                   in_addr_t gateway,
                   const struct tuntap *tt,
@@ -954,21 +954,16 @@ add_bypass_routes(struct route_bypass *rb,
                   const struct env_set *es,
                   openvpn_net_ctx_t *ctx)
 {
-    int i;
-    for (i = 0; i < rb->n_bypass; ++i)
+    int ret = true;
+    for (int i = 0; i < rb->n_bypass; ++i)
     {
         if (rb->bypass[i])
         {
-            add_route3(rb->bypass[i],
-                       IPV4_NETMASK_HOST,
-                       gateway,
-                       tt,
-                       flags | ROUTE_REF_GW,
-                       rgi,
-                       es,
-                       ctx);
+            ret = add_route3(rb->bypass[i], IPV4_NETMASK_HOST, gateway, tt,
+                             flags | ROUTE_REF_GW, rgi, es, ctx) && ret;
         }
     }
+    return ret;
 }
 
 static void
@@ -997,12 +992,13 @@ del_bypass_routes(struct route_bypass *rb,
     }
 }
 
-static void
+static bool
 redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
                               unsigned int flags, const struct env_set *es,
                               openvpn_net_ctx_t *ctx)
 {
     const char err[] = "NOTE: unable to redirect IPv4 default gateway --";
+    bool ret = true;
 
     if (rl && rl->flags & RG_ENABLE)
     {
@@ -1011,6 +1007,7 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
         if (!(rl->spec.flags & RTSA_REMOTE_ENDPOINT) && (rl->flags & RG_REROUTE_GW))
         {
             msg(M_WARN, "%s VPN gateway parameter (--route-gateway or --ifconfig) is missing", err);
+            ret = false;
         }
         /*
          * check if a default route is defined, unless:
@@ -1021,6 +1018,7 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
                  && (rl->spec.flags & RTSA_REMOTE_HOST))
         {
             msg(M_WARN, "%s Cannot read current default gateway from system", err);
+            ret = false;
         }
         else
         {
@@ -1047,14 +1045,9 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
                 if ((rl->spec.flags & RTSA_REMOTE_HOST)
                     && rl->spec.remote_host != IPV4_INVALID_ADDR)
                 {
-                    add_route3(rl->spec.remote_host,
-                               IPV4_NETMASK_HOST,
-                               rl->rgi.gateway.addr,
-                               tt,
-                               flags | ROUTE_REF_GW,
-                               &rl->rgi,
-                               es,
-                               ctx);
+                    ret = add_route3(rl->spec.remote_host, IPV4_NETMASK_HOST,
+                                     rl->rgi.gateway.addr, tt, flags | ROUTE_REF_GW,
+                                     &rl->rgi, es, ctx);
                     rl->iflags |= RL_DID_LOCAL;
                 }
                 else
@@ -1065,32 +1058,20 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
 #endif /* ifndef TARGET_ANDROID */
 
             /* route DHCP/DNS server traffic through original default gateway */
-            add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags,
-                              &rl->rgi, es, ctx);
+            ret = add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags,
+                                    &rl->rgi, es, ctx);
 
             if (rl->flags & RG_REROUTE_GW)
             {
                 if (rl->flags & RG_DEF1)
                 {
                     /* add new default route (1st component) */
-                    add_route3(0x00000000,
-                               0x80000000,
-                               rl->spec.remote_endpoint,
-                               tt,
-                               flags,
-                               &rl->rgi,
-                               es,
-                               ctx);
+                    ret = add_route3(0x00000000, 0x80000000, rl->spec.remote_endpoint,
+                                     tt, flags, &rl->rgi, es, ctx) && ret;
 
                     /* add new default route (2nd component) */
-                    add_route3(0x80000000,
-                               0x80000000,
-                               rl->spec.remote_endpoint,
-                               tt,
-                               flags,
-                               &rl->rgi,
-                               es,
-                               ctx);
+                    ret = add_route3(0x80000000, 0x80000000, rl->spec.remote_endpoint,
+                                     tt, flags, &rl->rgi, es, ctx) && ret;
                 }
                 else
                 {
@@ -1103,14 +1084,8 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
                     }
 
                     /* add new default route */
-                    add_route3(0,
-                               0,
-                               rl->spec.remote_endpoint,
-                               tt,
-                               flags,
-                               &rl->rgi,
-                               es,
-                               ctx);
+                    ret = add_route3(0, 0, rl->spec.remote_endpoint, tt,
+                                     flags, &rl->rgi, es, ctx) && ret;
                 }
             }
 
@@ -1118,6 +1093,7 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
             rl->iflags |= RL_DID_REDIRECT_DEFAULT_GATEWAY;
         }
     }
+    return ret;
 }
 
 static void
@@ -1194,12 +1170,12 @@ undo_redirect_default_route_to_vpn(struct route_list *rl,
     }
 }
 
-void
+bool
 add_routes(struct route_list *rl, struct route_ipv6_list *rl6,
            const struct tuntap *tt, unsigned int flags,
            const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
-    redirect_default_route_to_vpn(rl, tt, flags, es, ctx);
+    bool ret = redirect_default_route_to_vpn(rl, tt, flags, es, ctx);
     if (rl && !(rl->iflags & RL_ROUTES_ADDED) )
     {
         struct route_ipv4 *r;
@@ -1232,7 +1208,7 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6,
             {
                 delete_route(r, tt, flags, &rl->rgi, es, ctx);
             }
-            add_route(r, tt, flags, &rl->rgi, es, ctx);
+            ret = add_route(r, tt, flags, &rl->rgi, es, ctx) && ret;
         }
         rl->iflags |= RL_ROUTES_ADDED;
     }
@@ -1254,10 +1230,11 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6,
             {
                 delete_route_ipv6(r, tt, flags, es, ctx);
             }
-            add_route_ipv6(r, tt, flags, es, ctx);
+            ret = add_route_ipv6(r, tt, flags, es, ctx) && ret;
         }
         rl6->iflags |= RL_ROUTES_ADDED;
     }
+    return ret;
 }
 
 void
@@ -1569,7 +1546,7 @@ is_on_link(const int is_local_route, const unsigned int flags, const struct rout
     return rgi && (is_local_route == LR_MATCH || ((flags & ROUTE_REF_GW) && (rgi->flags & RGI_ON_LINK)));
 }
 
-void
+bool
 add_route(struct route_ipv4 *r,
           const struct tuntap *tt,
           unsigned int flags,
@@ -1582,7 +1559,7 @@ add_route(struct route_ipv4 *r,
 
     if (!(r->flags & RT_DEFINED))
     {
-        return;
+        return true; /* no error */
     }
 
     struct argv argv = argv_new();
@@ -1635,7 +1612,7 @@ add_route(struct route_ipv4 *r,
     {
         openvpn_snprintf(out, sizeof(out), "%s %s %s", network, netmask, gateway);
     }
-    management_android_control(management, "ROUTE", out);
+    status = management_android_control(management, "ROUTE", out);
 
 #elif defined (_WIN32)
     {
@@ -1845,6 +1822,8 @@ done:
     gc_free(&gc);
     /* release resources potentially allocated during route setup */
     net_ctx_reset(ctx);
+
+    return (status != 0);
 }
 
 
@@ -1871,7 +1850,7 @@ route_ipv6_clear_host_bits( struct route_ipv6 *r6 )
     }
 }
 
-void
+bool
 add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
                unsigned int flags, const struct env_set *es,
                openvpn_net_ctx_t *ctx)
@@ -1882,7 +1861,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
 
     if (!(r6->flags & RT_DEFINED) )
     {
-        return;
+        return true; /* no error */
     }
 
     struct argv argv = argv_new();
@@ -1972,7 +1951,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
 
     openvpn_snprintf(out, sizeof(out), "%s/%d %s", network, r6->netbits, device);
 
-    management_android_control(management, "ROUTE6", out);
+    status = management_android_control(management, "ROUTE6", out);
 
 #elif defined (_WIN32)
 
@@ -2092,6 +2071,8 @@ done:
     gc_free(&gc);
     /* release resources potentially allocated during route setup */
     net_ctx_reset(ctx);
+
+    return (status != 0);
 }
 
 static void
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 74ecd343..1c940a9b 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -259,15 +259,12 @@ void copy_route_ipv6_option_list(struct route_ipv6_option_list *dest,
 
 void route_ipv6_clear_host_bits( struct route_ipv6 *r6 );
 
-void add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
+bool add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
 
 void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
 
-void add_route(struct route_ipv4 *r,
-               const struct tuntap *tt,
-               unsigned int flags,
-               const struct route_gateway_info *rgi,
-               const struct env_set *es,
+bool add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
+               const struct route_gateway_info *rgi, const struct env_set *es,
                openvpn_net_ctx_t *ctx);
 
 void add_route_to_option_list(struct route_option_list *l,
@@ -301,12 +298,9 @@ void route_list_add_vpn_gateway(struct route_list *rl,
                                 struct env_set *es,
                                 const in_addr_t addr);
 
-void add_routes(struct route_list *rl,
-                struct route_ipv6_list *rl6,
-                const struct tuntap *tt,
-                unsigned int flags,
-                const struct env_set *es,
-                openvpn_net_ctx_t *ctx);
+bool add_routes(struct route_list *rl, struct route_ipv6_list *rl6,
+                const struct tuntap *tt, unsigned int flags,
+                const struct env_set *es, openvpn_net_ctx_t *ctx);
 
 void delete_routes(struct route_list *rl,
                    struct route_ipv6_list *rl6,
-- 
2.34.1


