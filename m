From: Antonio Quartulli <a@...2181...>
Date: Fri, 12 Oct 2018 02:41:58 +0800
Message-Id: <20181011184200.22175-6-a@...2181...>
In-Reply-To: <20181011184200.22175-1-a@...2181...>
References: <20181011184200.22175-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 5/7] route.c: use new networking API to
 handle routing table on Linux
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
Cc: Antonio Quartulli <a@...2181...>

By switching to the networking API (for Linux) openvpn will
now use any of the available implementations to handle the
routing table.

At the moment only iproute2 is implemented.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/forward.c       |   2 +-
 src/openvpn/init.c          |  24 ++-
 src/openvpn/init.h          |   3 +-
 src/openvpn/networking_ip.c |   1 -
 src/openvpn/options.c       |   4 +-
 src/openvpn/route.c         | 336 +++++++++++++++---------------------
 src/openvpn/route.h         |  19 +-
 src/openvpn/ssl.c           |   2 +-
 src/openvpn/ssl_common.h    |   1 +
 src/openvpn/tun.c           |  18 +-
 src/openvpn/tun.h           |   2 +-
 11 files changed, 184 insertions(+), 228 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f8faa810..03579e44 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -508,7 +508,7 @@ static void
 check_add_routes_action(struct context *c, const bool errors)
 {
     do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
-             c->c1.tuntap, c->plugins, c->c2.es);
+             c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
     update_time();
     event_timeout_clear(&c->c2.route_wakeup);
     event_timeout_clear(&c->c2.route_wakeup_expire);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1eba49ab..79541cc8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1402,7 +1402,8 @@ static void
 do_init_route_list(const struct options *options,
                    struct route_list *route_list,
                    const struct link_socket_info *link_socket_info,
-                   struct env_set *es)
+                   struct env_set *es,
+                   openvpn_net_ctx_t *ctx)
 {
     const char *gw = NULL;
     int dev = dev_type_enum(options->dev, options->dev_type);
@@ -1426,7 +1427,8 @@ do_init_route_list(const struct options *options,
                         gw,
                         metric,
                         link_socket_current_remote(link_socket_info),
-                        es))
+                        es,
+                        ctx))
     {
         /* copy routes to environment */
         setenv_routes(es, route_list);
@@ -1611,11 +1613,13 @@ do_route(const struct options *options,
          struct route_ipv6_list *route_ipv6_list,
          const struct tuntap *tt,
          const struct plugin_list *plugins,
-         struct env_set *es)
+         struct env_set *es,
+         openvpn_net_ctx_t *ctx)
 {
     if (!options->route_noexec && ( route_list || route_ipv6_list ) )
     {
-        add_routes(route_list, route_ipv6_list, tt, ROUTE_OPTION_FLAGS(options), es);
+        add_routes(route_list, route_ipv6_list, tt, ROUTE_OPTION_FLAGS(options),
+                   es, ctx);
         setenv_int(es, "redirect_gateway", route_did_redirect_default_gateway(route_list));
     }
 #ifdef ENABLE_MANAGEMENT
@@ -1728,7 +1732,7 @@ do_open_tun(struct context *c)
     if (c->options.routes && c->c1.route_list)
     {
         do_init_route_list(&c->options, c->c1.route_list,
-                           &c->c2.link_socket->info, c->c2.es);
+                           &c->c2.link_socket->info, c->c2.es, &c->net_ctx);
     }
     if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
     {
@@ -1755,7 +1759,7 @@ do_open_tun(struct context *c)
     {
         /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be ignored */
         do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
-                 c->c1.tuntap, c->plugins, c->c2.es);
+                 c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
     }
 #ifdef TARGET_ANDROID
     /* Store the old fd inside the fd so open_tun can use it */
@@ -1812,7 +1816,7 @@ do_open_tun(struct context *c)
     if ((route_order() == ROUTE_AFTER_TUN) && (!c->options.route_delay_defined))
     {
         do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
-                 c->c1.tuntap, c->plugins, c->c2.es);
+                 c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
     }
 
     /*
@@ -1941,7 +1945,8 @@ do_close_tun(struct context *c, bool force)
                             c->c2.es);
 
                 delete_routes(c->c1.route_list, c->c1.route_ipv6_list,
-                              c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options), c->c2.es);
+                              c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options),
+                              c->c2.es, &c->net_ctx);
             }
 
             /* actually close tun/tap device based on --down-pre flag */
@@ -2777,6 +2782,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.x509_username_field = X509_USERNAME_FIELD_DEFAULT;
 #endif
     to.es = c->c2.es;
+    to.net_ctx = &c->net_ctx;
 
 #ifdef ENABLE_DEBUG
     to.gremlin = c->options.gremlin;
@@ -3123,7 +3129,7 @@ do_option_warnings(struct context *c)
 
     if (o->tls_server)
     {
-        warn_on_use_of_common_subnets();
+        warn_on_use_of_common_subnets(&c->net_ctx);
     }
     if (o->tls_client
         && !o->tls_verify
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index ba5eda06..fa70bab2 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -76,7 +76,8 @@ void do_route(const struct options *options,
               struct route_ipv6_list *route_ipv6_list,
               const struct tuntap *tt,
               const struct plugin_list *plugins,
-              struct env_set *es);
+              struct env_set *es,
+              openvpn_net_ctx_t *ctx);
 
 void close_instance(struct context *c);
 
diff --git a/src/openvpn/networking_ip.c b/src/openvpn/networking_ip.c
index ae667a9c..918d62ef 100644
--- a/src/openvpn/networking_ip.c
+++ b/src/openvpn/networking_ip.c
@@ -29,7 +29,6 @@
 #include "syshead.h"
 
 #include "networking.h"
-#include "networking_ip.h"
 #include "misc.h"
 #include "openvpn.h"
 #include "run_command.h"
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 55559dfd..df927056 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5028,12 +5028,14 @@ add_option(struct options *options,
         struct route_gateway_info rgi;
         struct route_ipv6_gateway_info rgi6;
         struct in6_addr remote = IN6ADDR_ANY_INIT;
+        openvpn_net_ctx_t net_ctx;
         VERIFY_PERMISSION(OPT_P_GENERAL);
         if (p[1])
         {
             get_ipv6_addr(p[1], &remote, NULL, M_WARN);
         }
-        get_default_gateway(&rgi);
+        net_ctx_init(NULL, &net_ctx);
+        get_default_gateway(&rgi, &net_ctx);
         get_default_gateway_ipv6(&rgi6, &remote);
         print_default_gateway(M_INFO, &rgi, &rgi6);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d97e8dba..fd6274da 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -41,6 +41,7 @@
 #include "manage.h"
 #include "win32.h"
 #include "options.h"
+#include "networking.h"
 
 #include "memdbg.h"
 
@@ -62,7 +63,7 @@ static bool del_route_ipv6_service(const struct route_ipv6 *, const struct tunta
 
 #endif
 
-static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags, const struct route_gateway_info *rgi, const struct env_set *es);
+static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags, const struct route_gateway_info *rgi, const struct env_set *es, openvpn_net_ctx_t *ctx);
 
 static void get_bypass_addresses(struct route_bypass *rb, const unsigned int flags);
 
@@ -613,7 +614,8 @@ init_route_list(struct route_list *rl,
                 const char *remote_endpoint,
                 int default_metric,
                 in_addr_t remote_host,
-                struct env_set *es)
+                struct env_set *es,
+                openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     bool ret = true;
@@ -634,7 +636,7 @@ init_route_list(struct route_list *rl,
         rl->spec.flags |= RTSA_DEFAULT_METRIC;
     }
 
-    get_default_gateway(&rl->rgi);
+    get_default_gateway(&rl->rgi, ctx);
     if (rl->rgi.flags & RGI_ADDR_DEFINED)
     {
         setenv_route_addr(es, "net_gateway", rl->rgi.gateway.addr, -1);
@@ -901,7 +903,8 @@ add_route3(in_addr_t network,
            const struct tuntap *tt,
            unsigned int flags,
            const struct route_gateway_info *rgi,
-           const struct env_set *es)
+           const struct env_set *es,
+           openvpn_net_ctx_t *ctx)
 {
     struct route_ipv4 r;
     CLEAR(r);
@@ -909,7 +912,7 @@ add_route3(in_addr_t network,
     r.network = network;
     r.netmask = netmask;
     r.gateway = gateway;
-    add_route(&r, tt, flags, rgi, es);
+    add_route(&r, tt, flags, rgi, es, ctx);
 }
 
 static void
@@ -919,7 +922,8 @@ del_route3(in_addr_t network,
            const struct tuntap *tt,
            unsigned int flags,
            const struct route_gateway_info *rgi,
-           const struct env_set *es)
+           const struct env_set *es,
+           openvpn_net_ctx_t *ctx)
 {
     struct route_ipv4 r;
     CLEAR(r);
@@ -927,7 +931,7 @@ del_route3(in_addr_t network,
     r.network = network;
     r.netmask = netmask;
     r.gateway = gateway;
-    delete_route(&r, tt, flags, rgi, es);
+    delete_route(&r, tt, flags, rgi, es, ctx);
 }
 
 static void
@@ -936,7 +940,8 @@ add_bypass_routes(struct route_bypass *rb,
                   const struct tuntap *tt,
                   unsigned int flags,
                   const struct route_gateway_info *rgi,
-                  const struct env_set *es)
+                  const struct env_set *es,
+                  openvpn_net_ctx_t *ctx)
 {
     int i;
     for (i = 0; i < rb->n_bypass; ++i)
@@ -949,7 +954,8 @@ add_bypass_routes(struct route_bypass *rb,
                        tt,
                        flags | ROUTE_REF_GW,
                        rgi,
-                       es);
+                       es,
+                       ctx);
         }
     }
 }
@@ -960,7 +966,8 @@ del_bypass_routes(struct route_bypass *rb,
                   const struct tuntap *tt,
                   unsigned int flags,
                   const struct route_gateway_info *rgi,
-                  const struct env_set *es)
+                  const struct env_set *es,
+                  openvpn_net_ctx_t *ctx)
 {
     int i;
     for (i = 0; i < rb->n_bypass; ++i)
@@ -973,13 +980,16 @@ del_bypass_routes(struct route_bypass *rb,
                        tt,
                        flags | ROUTE_REF_GW,
                        rgi,
-                       es);
+                       es,
+                       ctx);
         }
     }
 }
 
 static void
-redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
+                              unsigned int flags, const struct env_set *es,
+                              openvpn_net_ctx_t *ctx)
 {
     const char err[] = "NOTE: unable to redirect default gateway --";
 
@@ -1035,7 +1045,8 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
                                tt,
                                flags | ROUTE_REF_GW,
                                &rl->rgi,
-                               es);
+                               es,
+                               ctx);
                     rl->iflags |= RL_DID_LOCAL;
                 }
                 else
@@ -1046,7 +1057,8 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
 #endif /* ifndef TARGET_ANDROID */
 
             /* route DHCP/DNS server traffic through original default gateway */
-            add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags, &rl->rgi, es);
+            add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags,
+                              &rl->rgi, es, ctx);
 
             if (rl->flags & RG_REROUTE_GW)
             {
@@ -1059,7 +1071,8 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
                                tt,
                                flags,
                                &rl->rgi,
-                               es);
+                               es,
+                               ctx);
 
                     /* add new default route (2nd component) */
                     add_route3(0x80000000,
@@ -1068,7 +1081,8 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
                                tt,
                                flags,
                                &rl->rgi,
-                               es);
+                               es,
+                               ctx);
                 }
                 else
                 {
@@ -1077,7 +1091,7 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
                     {
                         /* delete default route */
                         del_route3(0, 0, rl->rgi.gateway.addr, tt,
-                                   flags | ROUTE_REF_GW, &rl->rgi, es);
+                                   flags | ROUTE_REF_GW, &rl->rgi, es, ctx);
                     }
 
                     /* add new default route */
@@ -1087,7 +1101,8 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
                                tt,
                                flags,
                                &rl->rgi,
-                               es);
+                               es,
+                               ctx);
                 }
             }
 
@@ -1098,7 +1113,10 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, un
 }
 
 static void
-undo_redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+undo_redirect_default_route_to_vpn(struct route_list *rl,
+                                   const struct tuntap *tt, unsigned int flags,
+                                   const struct env_set *es,
+                                   openvpn_net_ctx_t *ctx)
 {
     if (rl && rl->iflags & RL_DID_REDIRECT_DEFAULT_GATEWAY)
     {
@@ -1111,12 +1129,14 @@ undo_redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *t
                        tt,
                        flags | ROUTE_REF_GW,
                        &rl->rgi,
-                       es);
+                       es,
+                       ctx);
             rl->iflags &= ~RL_DID_LOCAL;
         }
 
         /* delete special DHCP/DNS bypass route */
-        del_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags, &rl->rgi, es);
+        del_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags,
+                          &rl->rgi, es, ctx);
 
         if (rl->flags & RG_REROUTE_GW)
         {
@@ -1129,7 +1149,8 @@ undo_redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *t
                            tt,
                            flags,
                            &rl->rgi,
-                           es);
+                           es,
+                           ctx);
 
                 /* delete default route (2nd component) */
                 del_route3(0x80000000,
@@ -1138,7 +1159,8 @@ undo_redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *t
                            tt,
                            flags,
                            &rl->rgi,
-                           es);
+                           es,
+                           ctx);
             }
             else
             {
@@ -1149,12 +1171,13 @@ undo_redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *t
                            tt,
                            flags,
                            &rl->rgi,
-                           es);
+                           es,
+                           ctx);
                 /* restore original default route if there was any */
                 if (rl->rgi.flags & RGI_ADDR_DEFINED)
                 {
                     add_route3(0, 0, rl->rgi.gateway.addr, tt,
-                               flags | ROUTE_REF_GW, &rl->rgi, es);
+                               flags | ROUTE_REF_GW, &rl->rgi, es, ctx);
                 }
             }
         }
@@ -1164,9 +1187,11 @@ undo_redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *t
 }
 
 void
-add_routes(struct route_list *rl, struct route_ipv6_list *rl6, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+add_routes(struct route_list *rl, struct route_ipv6_list *rl6,
+           const struct tuntap *tt, unsigned int flags,
+           const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
-    redirect_default_route_to_vpn(rl, tt, flags, es);
+    redirect_default_route_to_vpn(rl, tt, flags, es, ctx);
     if (rl && !(rl->iflags & RL_ROUTES_ADDED) )
     {
         struct route_ipv4 *r;
@@ -1189,9 +1214,9 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6, const struct tunt
             check_subnet_conflict(r->network, r->netmask, "route");
             if (flags & ROUTE_DELETE_FIRST)
             {
-                delete_route(r, tt, flags, &rl->rgi, es);
+                delete_route(r, tt, flags, &rl->rgi, es, ctx);
             }
-            add_route(r, tt, flags, &rl->rgi, es);
+            add_route(r, tt, flags, &rl->rgi, es, ctx);
         }
         rl->iflags |= RL_ROUTES_ADDED;
     }
@@ -1211,9 +1236,9 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6, const struct tunt
         {
             if (flags & ROUTE_DELETE_FIRST)
             {
-                delete_route_ipv6(r, tt, flags, es);
+                delete_route_ipv6(r, tt, flags, es, ctx);
             }
-            add_route_ipv6(r, tt, flags, es);
+            add_route_ipv6(r, tt, flags, es, ctx);
         }
         rl6->iflags |= RL_ROUTES_ADDED;
     }
@@ -1221,19 +1246,20 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6, const struct tunt
 
 void
 delete_routes(struct route_list *rl, struct route_ipv6_list *rl6,
-              const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+              const struct tuntap *tt, unsigned int flags,
+              const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     if (rl && rl->iflags & RL_ROUTES_ADDED)
     {
         struct route_ipv4 *r;
         for (r = rl->routes; r; r = r->next)
         {
-            delete_route(r, tt, flags, &rl->rgi, es);
+            delete_route(r, tt, flags, &rl->rgi, es, ctx);
         }
         rl->iflags &= ~RL_ROUTES_ADDED;
     }
 
-    undo_redirect_default_route_to_vpn(rl, tt, flags, es);
+    undo_redirect_default_route_to_vpn(rl, tt, flags, es, ctx);
 
     if (rl)
     {
@@ -1245,7 +1271,7 @@ delete_routes(struct route_list *rl, struct route_ipv6_list *rl6,
         struct route_ipv6 *r6;
         for (r6 = rl6->routes_ipv6; r6; r6 = r6->next)
         {
-            delete_route_ipv6(r6, tt, flags, es);
+            delete_route_ipv6(r6, tt, flags, es, ctx);
         }
         rl6->iflags &= ~RL_ROUTES_ADDED;
     }
@@ -1525,15 +1551,21 @@ add_route(struct route_ipv4 *r,
           const struct tuntap *tt,
           unsigned int flags,
           const struct route_gateway_info *rgi,  /* may be NULL */
-          const struct env_set *es)
+          const struct env_set *es,
+          openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc;
     struct argv argv = argv_new();
+#if !defined(TARGET_LINUX)
     const char *network;
 #if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
     const char *netmask;
 #endif
     const char *gateway;
+#else
+    const char *iface;
+    int metric;
+#endif
     bool status = false;
     int is_local_route;
 
@@ -1544,11 +1576,13 @@ add_route(struct route_ipv4 *r,
 
     gc_init(&gc);
 
+#if !defined(TARGET_LINUX)
     network = print_in_addr_t(r->network, 0, &gc);
 #if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
     netmask = print_in_addr_t(r->netmask, 0, &gc);
 #endif
     gateway = print_in_addr_t(r->gateway, 0, &gc);
+#endif
 
     is_local_route = local_route(r->network, r->netmask, r->gateway, rgi);
     if (is_local_route == LR_ERROR)
@@ -1557,47 +1591,26 @@ add_route(struct route_ipv4 *r,
     }
 
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s route add %s/%d",
-                iproute_path,
-                network,
-                netmask_to_netbits2(r->netmask));
-
-    if (r->flags & RT_METRIC_DEFINED)
-    {
-        argv_printf_cat(&argv, "metric %d", r->metric);
-    }
-
+    iface = NULL;
     if (is_on_link(is_local_route, flags, rgi))
     {
-        argv_printf_cat(&argv, "dev %s", rgi->iface);
-    }
-    else
-    {
-        argv_printf_cat(&argv, "via %s", gateway);
+        iface = rgi->iface;
     }
-#else  /* ifdef ENABLE_IPROUTE */
-    argv_printf(&argv, "%s add -net %s netmask %s",
-                ROUTE_PATH,
-                network,
-                netmask);
+
+    metric = -1;
     if (r->flags & RT_METRIC_DEFINED)
     {
-        argv_printf_cat(&argv, "metric %d", r->metric);
+        metric = r->metric;
     }
-    if (is_on_link(is_local_route, flags, rgi))
-    {
-        argv_printf_cat(&argv, "dev %s", rgi->iface);
-    }
-    else
+
+    status = true;
+    if (net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask),
+                         &r->gateway, iface, 0, metric) < 0)
     {
-        argv_printf_cat(&argv, "gw %s", gateway);
+        msg(M_WARN, "ERROR: Linux route add command failed");
+        status = false;
     }
 
-#endif  /*ENABLE_IPROUTE*/
-    argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: Linux route add command failed");
-
 #elif defined (TARGET_ANDROID)
     char out[128];
 
@@ -1844,7 +1857,9 @@ route_ipv6_clear_host_bits( struct route_ipv6 *r6 )
 }
 
 void
-add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
+               unsigned int flags, const struct env_set *es,
+               openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc;
     struct argv argv = argv_new();
@@ -1853,7 +1868,9 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     const char *gateway;
     bool status = false;
     const char *device = tt->actual_name;
-
+#if defined(TARGET_LINUX)
+    int metric;
+#endif
     bool gateway_needed = false;
 
     if (!(r6->flags & RT_DEFINED) )
@@ -1918,38 +1935,20 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     }
 
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s -6 route add %s/%d dev %s",
-                iproute_path,
-                network,
-                r6->netbits,
-                device);
-    if (gateway_needed)
-    {
-        argv_printf_cat(&argv, "via %s", gateway);
-    }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
+    metric = -1;
+    if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
-        argv_printf_cat(&argv, " metric %d", r6->metric);
+        metric = r6->metric;
     }
 
-#else  /* ifdef ENABLE_IPROUTE */
-    argv_printf(&argv, "%s -A inet6 add %s/%d dev %s",
-                ROUTE_PATH,
-                network,
-                r6->netbits,
-                device);
-    if (gateway_needed)
+    status = true;
+    if (net_route_v6_add(ctx, &r6->network, r6->netbits,
+                         gateway_needed ? &r6->gateway : NULL, device, 0,
+                         metric) < 0)
     {
-        argv_printf_cat(&argv, "gw %s", gateway);
+        msg(M_WARN, "ERROR: Linux IPv6 route can't be added");
+        status = false;
     }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
-    {
-        argv_printf_cat(&argv, " metric %d", r6->metric);
-    }
-#endif  /*ENABLE_IPROUTE*/
-    argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: Linux route -6/-A inet6 add command failed");
 
 #elif defined (TARGET_ANDROID)
     char out[64];
@@ -2131,16 +2130,21 @@ delete_route(struct route_ipv4 *r,
              const struct tuntap *tt,
              unsigned int flags,
              const struct route_gateway_info *rgi,
-             const struct env_set *es)
+             const struct env_set *es,
+             openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc;
     struct argv argv = argv_new();
+#if !defined(TARGET_LINUX)
     const char *network;
 #if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
     const char *netmask;
 #endif
 #if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     const char *gateway;
+#endif
+#else
+    int metric;
 #endif
     int is_local_route;
 
@@ -2151,12 +2155,14 @@ delete_route(struct route_ipv4 *r,
 
     gc_init(&gc);
 
+#if !defined(TARGET_LINUX)
     network = print_in_addr_t(r->network, 0, &gc);
 #if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
     netmask = print_in_addr_t(r->netmask, 0, &gc);
 #endif
 #if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     gateway = print_in_addr_t(r->gateway, 0, &gc);
+#endif
 #endif
 
     is_local_route = local_route(r->network, r->netmask, r->gateway, rgi);
@@ -2166,24 +2172,17 @@ delete_route(struct route_ipv4 *r,
     }
 
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s route del %s/%d",
-                iproute_path,
-                network,
-                netmask_to_netbits2(r->netmask));
-#else
-    argv_printf(&argv, "%s del -net %s netmask %s",
-                ROUTE_PATH,
-                network,
-                netmask);
-#endif /*ENABLE_IPROUTE*/
+    metric = -1;
     if (r->flags & RT_METRIC_DEFINED)
     {
-        argv_printf_cat(&argv, "metric %d", r->metric);
+        metric = r->metric;
     }
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: Linux route delete command failed");
 
+    if (net_route_v4_del(ctx, &r->network, netmask_to_netbits2(r->netmask),
+                         &r->gateway, NULL, 0, metric) < 0)
+    {
+        msg(M_WARN, "ERROR: Linux route delete command failed");
+    }
 #elif defined (_WIN32)
 
     argv_printf(&argv, "%s%sc DELETE %s MASK %s %s",
@@ -2319,12 +2318,18 @@ done:
 }
 
 void
-delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
+delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
+                  unsigned int flags, const struct env_set *es,
+                  openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc;
     struct argv argv = argv_new();
     const char *network;
+#if !defined(TARGET_LINUX)
     const char *gateway;
+#else
+    int metric;
+#endif
     const char *device = tt->actual_name;
     bool gateway_needed = false;
 
@@ -2344,7 +2349,9 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
     gc_init(&gc);
 
     network = print_in6_addr( r6->network, 0, &gc);
+#if !defined(TARGET_LINUX)
     gateway = print_in6_addr( r6->gateway, 0, &gc);
+#endif
 
 #if defined(TARGET_DARWIN)    \
     || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
@@ -2375,35 +2382,19 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
         gateway_needed = true;
     }
 
-
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-    argv_printf(&argv, "%s -6 route del %s/%d dev %s",
-                iproute_path,
-                network,
-                r6->netbits,
-                device);
-    if (gateway_needed)
+    metric = -1;
+    if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
-        argv_printf_cat(&argv, "via %s", gateway);
+        metric = r6->metric;
     }
-#else  /* ifdef ENABLE_IPROUTE */
-    argv_printf(&argv, "%s -A inet6 del %s/%d dev %s",
-                ROUTE_PATH,
-                network,
-                r6->netbits,
-                device);
-    if (gateway_needed)
-    {
-        argv_printf_cat(&argv, "gw %s", gateway);
-    }
-    if ( (r6->flags & RT_METRIC_DEFINED) && r6->metric > 0)
+
+    if (net_route_v6_del(ctx, &r6->network, r6->netbits,
+                         gateway_needed ? &r6->gateway : NULL, device, 0,
+                         metric) < 0)
     {
-        argv_printf_cat(&argv, " metric %d", r6->metric);
+        msg(M_WARN, "ERROR: Linux route v6 delete command failed");
     }
-#endif  /*ENABLE_IPROUTE*/
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: Linux route -6/-A inet6 del command failed");
 
 #elif defined (_WIN32)
 
@@ -2715,7 +2706,7 @@ get_default_gateway_row(const MIB_IPFORWARDTABLE *routes)
 }
 
 void
-get_default_gateway(struct route_gateway_info *rgi)
+get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
 
@@ -2802,7 +2793,7 @@ windows_route_find_if_index(const struct route_ipv4 *r, const struct tuntap *tt)
  */
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
-                         const struct in6_addr *dest)
+                         const struct in6_addr *dest, openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     MIB_IPFORWARD_ROW2 BestRoute;
@@ -3163,72 +3154,23 @@ show_routes(int msglev)
 #elif defined(TARGET_LINUX) || defined(TARGET_ANDROID)
 
 void
-get_default_gateway(struct route_gateway_info *rgi)
+get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     int sd = -1;
-    char best_name[16];
-    best_name[0] = 0;
+    char best_name[IFNAMSIZ];
 
     CLEAR(*rgi);
+    CLEAR(best_name);
 
 #ifndef TARGET_ANDROID
     /* get default gateway IP addr */
+    if (net_route_v4_best_gw(ctx, NULL, 0, &rgi->gateway.addr, best_name) == 0)
     {
-        FILE *fp = fopen("/proc/net/route", "r");
-        if (fp)
+        rgi->flags |= RGI_ADDR_DEFINED;
+        if (!rgi->gateway.addr && best_name[0])
         {
-            char line[256];
-            int count = 0;
-            unsigned int lowest_metric = UINT_MAX;
-            in_addr_t best_gw = 0;
-            bool found = false;
-            while (fgets(line, sizeof(line), fp) != NULL)
-            {
-                if (count)
-                {
-                    unsigned int net_x = 0;
-                    unsigned int mask_x = 0;
-                    unsigned int gw_x = 0;
-                    unsigned int metric = 0;
-                    unsigned int flags = 0;
-                    char name[16];
-                    name[0] = 0;
-                    const int np = sscanf(line, "%15s\t%x\t%x\t%x\t%*s\t%*s\t%d\t%x",
-                                          name,
-                                          &net_x,
-                                          &gw_x,
-                                          &flags,
-                                          &metric,
-                                          &mask_x);
-                    if (np == 6 && (flags & IFF_UP))
-                    {
-                        const in_addr_t net = ntohl(net_x);
-                        const in_addr_t mask = ntohl(mask_x);
-                        const in_addr_t gw = ntohl(gw_x);
-
-                        if (!net && !mask && metric < lowest_metric)
-                        {
-                            found = true;
-                            best_gw = gw;
-                            strcpy(best_name, name);
-                            lowest_metric = metric;
-                        }
-                    }
-                }
-                ++count;
-            }
-            fclose(fp);
-
-            if (found)
-            {
-                rgi->gateway.addr = best_gw;
-                rgi->flags |= RGI_ADDR_DEFINED;
-                if (!rgi->gateway.addr && best_name[0])
-                {
-                    rgi->flags |= RGI_ON_LINK;
-                }
-            }
+            rgi->flags |= RGI_ON_LINK;
         }
     }
 #else  /* ifndef TARGET_ANDROID */
@@ -3590,7 +3532,7 @@ struct rtmsg {
 #define max(a,b) ((a) > (b) ? (a) : (b))
 
 void
-get_default_gateway(struct route_gateway_info *rgi)
+get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     struct rtmsg m_rtmsg;
@@ -3990,7 +3932,7 @@ done:
  * may be disabled by missing items.
  */
 void
-get_default_gateway(struct route_gateway_info *rgi)
+get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
 {
     CLEAR(*rgi);
 }
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 69420228..e552e6ec 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -256,15 +256,16 @@ void copy_route_ipv6_option_list(struct route_ipv6_option_list *dest,
 
 void route_ipv6_clear_host_bits( struct route_ipv6 *r6 );
 
-void add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
+void add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
 
-void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
+void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
 
 void add_route(struct route_ipv4 *r,
                const struct tuntap *tt,
                unsigned int flags,
                const struct route_gateway_info *rgi,
-               const struct env_set *es);
+               const struct env_set *es,
+               openvpn_net_ctx_t *ctx);
 
 void add_route_to_option_list(struct route_option_list *l,
                               const char *network,
@@ -282,7 +283,8 @@ bool init_route_list(struct route_list *rl,
                      const char *remote_endpoint,
                      int default_metric,
                      in_addr_t remote_host,
-                     struct env_set *es);
+                     struct env_set *es,
+                     openvpn_net_ctx_t *ctx);
 
 bool init_route_ipv6_list(struct route_ipv6_list *rl6,
                           const struct route_ipv6_option_list *opt6,
@@ -299,13 +301,15 @@ void add_routes(struct route_list *rl,
                 struct route_ipv6_list *rl6,
                 const struct tuntap *tt,
                 unsigned int flags,
-                const struct env_set *es);
+                const struct env_set *es,
+                openvpn_net_ctx_t *ctx);
 
 void delete_routes(struct route_list *rl,
                    struct route_ipv6_list *rl6,
                    const struct tuntap *tt,
                    unsigned int flags,
-                   const struct env_set *es);
+                   const struct env_set *es,
+                   openvpn_net_ctx_t *ctx);
 
 void setenv_routes(struct env_set *es, const struct route_list *rl);
 
@@ -315,7 +319,8 @@ void setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6);
 
 bool is_special_addr(const char *addr_str);
 
-void get_default_gateway(struct route_gateway_info *rgi);
+void get_default_gateway(struct route_gateway_info *rgi,
+                         openvpn_net_ctx_t *ctx);
 
 void get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi,
                               const struct in6_addr *dest);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4ec85f50..e763133a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2282,7 +2282,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         {
             /* push mac addr */
             struct route_gateway_info rgi;
-            get_default_gateway(&rgi);
+            get_default_gateway(&rgi, session->opt->net_ctx);
             if (rgi.flags & RGI_HWADDR_DEFINED)
             {
                 buf_printf(&out, "IV_HWADDR=%s\n", format_hex_ex(rgi.hwaddr, 6, 0, 1, ":", &gc));
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 919ec57c..a9747d38 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -306,6 +306,7 @@ struct tls_options
 
     /* instance-wide environment variable set */
     struct env_set *es;
+    openvpn_net_ctx_t *net_ctx;
     const struct plugin_list *plugins;
 
     /* compression parms */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 002c3e6c..fb9fbdc6 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -453,13 +453,13 @@ check_subnet_conflict(const in_addr_t ip,
 }
 
 void
-warn_on_use_of_common_subnets(void)
+warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     struct route_gateway_info rgi;
     const int needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
 
-    get_default_gateway(&rgi);
+    get_default_gateway(&rgi, ctx);
     if ((rgi.flags & needed) == needed)
     {
         const in_addr_t lan_network = rgi.gateway.addr & rgi.gateway.netmask;
@@ -818,7 +818,7 @@ add_route_connected_v6_net(struct tuntap *tt,
     r6.gateway = tt->local_ipv6;
     r6.metric  = 0;                     /* connected route */
     r6.flags   = RT_DEFINED | RT_METRIC_DEFINED;
-    add_route_ipv6(&r6, tt, 0, es);
+    add_route_ipv6(&r6, tt, 0, es, NULL);
 }
 
 void
@@ -834,7 +834,7 @@ delete_route_connected_v6_net(struct tuntap *tt,
     r6.metric  = 0;                     /* connected route */
     r6.flags   = RT_DEFINED | RT_ADDED | RT_METRIC_DEFINED;
     route_ipv6_clear_host_bits(&r6);
-    delete_route_ipv6(&r6, tt, 0, es);
+    delete_route_ipv6(&r6, tt, 0, es, NULL);
 }
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD) */
 
@@ -1170,7 +1170,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         r.netmask = tt->remote_netmask;
         r.gateway = tt->local;
         r.metric = 0;
-        add_route(&r, tt, 0, NULL, es);
+        add_route(&r, tt, 0, NULL, es, NULL);
     }
 
 #elif defined(TARGET_OPENBSD)
@@ -1217,7 +1217,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         r.network = tt->local & tt->remote_netmask;
         r.netmask = tt->remote_netmask;
         r.gateway = remote_end;
-        add_route(&r, tt, 0, NULL, es);
+        add_route(&r, tt, 0, NULL, es, NULL);
     }
 
 #elif defined(TARGET_NETBSD)
@@ -1259,7 +1259,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         r.network = tt->local & tt->remote_netmask;
         r.netmask = tt->remote_netmask;
         r.gateway = remote_end;
-        add_route(&r, tt, 0, NULL, es);
+        add_route(&r, tt, 0, NULL, es, NULL);
     }
 
 #elif defined(TARGET_DARWIN)
@@ -1309,7 +1309,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         r.network = tt->local & tt->remote_netmask;
         r.netmask = tt->remote_netmask;
         r.gateway = tt->local;
-        add_route(&r, tt, 0, NULL, es);
+        add_route(&r, tt, 0, NULL, es, NULL);
     }
 
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
@@ -1348,7 +1348,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         r.network = tt->local & tt->remote_netmask;
         r.netmask = tt->remote_netmask;
         r.gateway = remote_end;
-        add_route(&r, tt, 0, NULL, es);
+        add_route(&r, tt, 0, NULL, es, NULL);
     }
 
 #elif defined(TARGET_AIX)
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index a68ecaa9..24c2ae58 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -275,7 +275,7 @@ void check_subnet_conflict(const in_addr_t ip,
                            const in_addr_t netmask,
                            const char *prefix);
 
-void warn_on_use_of_common_subnets(void);
+void warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx);
 
 /*
  * Inline functions
-- 
2.19.1


