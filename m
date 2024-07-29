From: "mrbff (Code Review)" <gerrit@...515...>
Date: Mon, 29 Jul 2024 15:42:44 +0000
In-Reply-To: <gerrit.1721311407000.I3dbd61fef20d683734b55b73e40afe56c3b733e1@...2715...>
References: <gerrit.1721311407000.I3dbd61fef20d683734b55b73e40afe56c3b733e1@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <24547f6e0e64b78b5539832c1860234caed068ea-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pSOeZibMVeA="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: route: extended
 logic to omit gateway when unnecessary
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

--pSOeZibMVeA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/678?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: route: extended logic to omit gateway when unnecessary
......................................................................

route: extended logic to omit gateway when unnecessary

Extracted and extended the logic behind 'gateway_needed' both in
add_route() and add_route_ipv6(). Other than checking the dev-type,
special routes and if the gateway is on-link,
- set gateway_needed to true if the vpn instance is a multipoint server
  and DCO is enabled.
- set gateway_needed to false if the gateway is in the vpn subnet.
Additionally, extended support for these checks and conditions to DARWIN
and BSD-based operating systems.

These changes ensure that the gateway is only included when necessary,
optimizing route configuration and potentially reducing redundant route ent=
ries.

Change-Id: I3dbd61fef20d683734b55b73e40afe56c3b733e1
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/route.c
M src/openvpn/route.h
M src/openvpn/tun.c
M src/openvpn/tun.h
7 files changed, 425 insertions(+), 247 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/678/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 40b7cc4..8c22bc9 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -421,7 +421,7 @@
 check_add_routes_action(struct context *c, const bool errors)
 {
     bool route_status =3D do_route(&c->options, c->c1.route_list, c->c1.ro=
ute_ipv6_list,
-                                 c->c1.tuntap, c->plugins, c->c2.es, &c->n=
et_ctx);
+                                 c->c1.tuntap, c->plugins, c->c2.es, &c->n=
et_ctx, c->mode =3D=3D CM_TOP);

     int flags =3D (errors ? ISC_ERRORS : 0);
     flags |=3D (!route_status ? ISC_ROUTE_ERRORS : 0);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a49e563..b0b2145 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1134,7 +1134,7 @@
     tuncfg(options->dev, options->dev_type, options->dev_node,
            options->persist_mode,
            options->username, options->groupname, &options->tuntap_options,
-           ctx);
+           ctx, options->mode =3D=3D MODE_SERVER);
     if (options->persist_mode && options->lladdr)
     {
         set_lladdr(ctx, options->dev, options->lladdr, NULL);
@@ -1689,13 +1689,14 @@
          const struct tuntap *tt,
          const struct plugin_list *plugins,
          struct env_set *es,
-         openvpn_net_ctx_t *ctx)
+         openvpn_net_ctx_t *ctx,
+         const bool is_multipoint)
 {
     bool ret =3D true;
     if (!options->route_noexec && ( route_list || route_ipv6_list ) )
     {
         ret =3D add_routes(route_list, route_ipv6_list, tt, ROUTE_OPTION_F=
LAGS(options),
-                         es, ctx);
+                         es, ctx, is_multipoint);
         setenv_int(es, "redirect_gateway", route_did_redirect_default_gate=
way(route_list));
     }
 #ifdef ENABLE_MANAGEMENT
@@ -1898,7 +1899,7 @@
                                                  c->options.dev_node,
                                                  &gc);
             do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es,
-                        &c->net_ctx);
+                        &c->net_ctx, c->mode =3D=3D CM_TOP);
         }

         /* possibly add routes */
@@ -1906,7 +1907,7 @@
         {
             /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be igno=
red */
             bool status =3D do_route(&c->options, c->c1.route_list, c->c1.=
route_ipv6_list,
-                                   c->c1.tuntap, c->plugins, c->c2.es, &c-=
>net_ctx);
+                                   c->c1.tuntap, c->plugins, c->c2.es, &c-=
>net_ctx, c->mode =3D=3D CM_TOP);
             *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);
         }
 #ifdef TARGET_ANDROID
@@ -1934,7 +1935,7 @@
             && ifconfig_order() =3D=3D IFCONFIG_AFTER_TUN_OPEN)
         {
             do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
-                        c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
+                        c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx, c->mod=
e =3D=3D CM_TOP);
         }

         /* run the up script */
@@ -1960,7 +1961,7 @@
         if ((route_order() =3D=3D ROUTE_AFTER_TUN) && (!c->options.route_d=
elay_defined))
         {
             int status =3D do_route(&c->options, c->c1.route_list, c->c1.r=
oute_ipv6_list,
-                                  c->c1.tuntap, c->plugins, c->c2.es, &c->=
net_ctx);
+                                  c->c1.tuntap, c->plugins, c->c2.es, &c->=
net_ctx, c->mode =3D=3D CM_TOP);
             *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);
         }

@@ -2017,7 +2018,7 @@
         {
             undo_ifconfig(c->c1.tuntap, &c->net_ctx);
         }
-        close_tun(c->c1.tuntap, &c->net_ctx);
+        close_tun(c->c1.tuntap, &c->net_ctx, c->mode =3D=3D CM_TOP);
         c->c1.tuntap =3D NULL;
     }
     c->c1.tuntap_owned =3D false;
@@ -2086,7 +2087,7 @@

             delete_routes(c->c1.route_list, c->c1.route_ipv6_list,
                           c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options),
-                          c->c2.es, &c->net_ctx);
+                          c->c2.es, &c->net_ctx, c->mode =3D=3D CM_TOP);
         }

         /* actually close tun/tap device based on --down-pre flag */
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index ea7eb30..82eec7e 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -74,7 +74,7 @@
 bool do_route(const struct options *options, struct route_list *route_list,
               struct route_ipv6_list *route_ipv6_list, const struct tuntap=
 *tt,
               const struct plugin_list *plugins, struct env_set *es,
-              openvpn_net_ctx_t *ctx);
+              openvpn_net_ctx_t *ctx, const bool is_multipoint);

 void close_instance(struct context *c);

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bc8f561..5870a0f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -77,7 +77,7 @@

 static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, un=
signed int flags,
                          const struct route_gateway_info *rgi, const struc=
t env_set *es,
-                         openvpn_net_ctx_t *ctx);
+                         openvpn_net_ctx_t *ctx, const bool is_multipoint);

 static void get_bypass_addresses(struct route_bypass *rb, const unsigned i=
nt flags);

@@ -927,7 +927,8 @@
            unsigned int flags,
            const struct route_gateway_info *rgi,
            const struct env_set *es,
-           openvpn_net_ctx_t *ctx)
+           openvpn_net_ctx_t *ctx,
+           const bool is_multipoint)
 {
     struct route_ipv4 r;
     CLEAR(r);
@@ -935,7 +936,7 @@
     r.network =3D network;
     r.netmask =3D netmask;
     r.gateway =3D gateway;
-    return add_route(&r, tt, flags, rgi, es, ctx);
+    return add_route(&r, tt, flags, rgi, es, ctx, is_multipoint);
 }

 static void
@@ -946,7 +947,8 @@
            unsigned int flags,
            const struct route_gateway_info *rgi,
            const struct env_set *es,
-           openvpn_net_ctx_t *ctx)
+           openvpn_net_ctx_t *ctx,
+           const bool is_multipoint)
 {
     struct route_ipv4 r;
     CLEAR(r);
@@ -954,7 +956,7 @@
     r.network =3D network;
     r.netmask =3D netmask;
     r.gateway =3D gateway;
-    delete_route(&r, tt, flags, rgi, es, ctx);
+    delete_route(&r, tt, flags, rgi, es, ctx, is_multipoint);
 }

 static bool
@@ -964,7 +966,8 @@
                   unsigned int flags,
                   const struct route_gateway_info *rgi,
                   const struct env_set *es,
-                  openvpn_net_ctx_t *ctx)
+                  openvpn_net_ctx_t *ctx,
+                  const bool is_multipoint)
 {
     int ret =3D true;
     for (int i =3D 0; i < rb->n_bypass; ++i)
@@ -972,7 +975,7 @@
         if (rb->bypass[i])
         {
             ret =3D add_route3(rb->bypass[i], IPV4_NETMASK_HOST, gateway, =
tt,
-                             flags | ROUTE_REF_GW, rgi, es, ctx) && ret;
+                             flags | ROUTE_REF_GW, rgi, es, ctx, is_multip=
oint) && ret;
         }
     }
     return ret;
@@ -985,7 +988,8 @@
                   unsigned int flags,
                   const struct route_gateway_info *rgi,
                   const struct env_set *es,
-                  openvpn_net_ctx_t *ctx)
+                  openvpn_net_ctx_t *ctx,
+                  const bool is_multipoint)
 {
     int i;
     for (i =3D 0; i < rb->n_bypass; ++i)
@@ -999,7 +1003,8 @@
                        flags | ROUTE_REF_GW,
                        rgi,
                        es,
-                       ctx);
+                       ctx,
+                       is_multipoint);
         }
     }
 }
@@ -1007,7 +1012,7 @@
 static bool
 redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *=
tt,
                               unsigned int flags, const struct env_set *es,
-                              openvpn_net_ctx_t *ctx)
+                              openvpn_net_ctx_t *ctx, const bool is_multip=
oint)
 {
     const char err[] =3D "NOTE: unable to redirect IPv4 default gateway --=
";
     bool ret =3D true;
@@ -1059,7 +1064,7 @@
                 {
                     ret =3D add_route3(rl->spec.remote_host, IPV4_NETMASK_=
HOST,
                                      rl->rgi.gateway.addr, tt, flags | ROU=
TE_REF_GW,
-                                     &rl->rgi, es, ctx);
+                                     &rl->rgi, es, ctx, is_multipoint);
                     rl->iflags |=3D RL_DID_LOCAL;
                 }
                 else
@@ -1071,7 +1076,7 @@

             /* route DHCP/DNS server traffic through original default gate=
way */
             ret =3D add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.ad=
dr, tt, flags,
-                                    &rl->rgi, es, ctx) && ret;
+                                    &rl->rgi, es, ctx, is_multipoint) && r=
et;

             if (rl->flags & RG_REROUTE_GW)
             {
@@ -1079,11 +1084,11 @@
                 {
                     /* add new default route (1st component) */
                     ret =3D add_route3(0x00000000, 0x80000000, rl->spec.re=
mote_endpoint,
-                                     tt, flags, &rl->rgi, es, ctx) && ret;
+                                     tt, flags, &rl->rgi, es, ctx, is_mult=
ipoint) && ret;

                     /* add new default route (2nd component) */
                     ret =3D add_route3(0x80000000, 0x80000000, rl->spec.re=
mote_endpoint,
-                                     tt, flags, &rl->rgi, es, ctx) && ret;
+                                     tt, flags, &rl->rgi, es, ctx, is_mult=
ipoint) && ret;
                 }
                 else
                 {
@@ -1092,12 +1097,12 @@
                     {
                         /* delete default route */
                         del_route3(0, 0, rl->rgi.gateway.addr, tt,
-                                   flags | ROUTE_REF_GW, &rl->rgi, es, ctx=
);
+                                   flags | ROUTE_REF_GW, &rl->rgi, es, ctx=
, is_multipoint);
                     }

                     /* add new default route */
                     ret =3D add_route3(0, 0, rl->spec.remote_endpoint, tt,
-                                     flags, &rl->rgi, es, ctx) && ret;
+                                     flags, &rl->rgi, es, ctx, is_multipoi=
nt) && ret;
                 }
             }

@@ -1112,7 +1117,8 @@
 undo_redirect_default_route_to_vpn(struct route_list *rl,
                                    const struct tuntap *tt, unsigned int f=
lags,
                                    const struct env_set *es,
-                                   openvpn_net_ctx_t *ctx)
+                                   openvpn_net_ctx_t *ctx,
+                                   const bool is_multipoint)
 {
     if (rl && rl->iflags & RL_DID_REDIRECT_DEFAULT_GATEWAY)
     {
@@ -1126,13 +1132,14 @@
                        flags | ROUTE_REF_GW,
                        &rl->rgi,
                        es,
-                       ctx);
+                       ctx,
+                       is_multipoint);
             rl->iflags &=3D ~RL_DID_LOCAL;
         }

         /* delete special DHCP/DNS bypass route */
         del_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flag=
s,
-                          &rl->rgi, es, ctx);
+                          &rl->rgi, es, ctx, is_multipoint);

         if (rl->flags & RG_REROUTE_GW)
         {
@@ -1146,7 +1153,8 @@
                            flags,
                            &rl->rgi,
                            es,
-                           ctx);
+                           ctx,
+                           is_multipoint);

                 /* delete default route (2nd component) */
                 del_route3(0x80000000,
@@ -1156,7 +1164,8 @@
                            flags,
                            &rl->rgi,
                            es,
-                           ctx);
+                           ctx,
+                           is_multipoint);
             }
             else
             {
@@ -1168,12 +1177,13 @@
                            flags,
                            &rl->rgi,
                            es,
-                           ctx);
+                           ctx,
+                           is_multipoint);
                 /* restore original default route if there was any */
                 if (rl->rgi.flags & RGI_ADDR_DEFINED)
                 {
                     add_route3(0, 0, rl->rgi.gateway.addr, tt,
-                               flags | ROUTE_REF_GW, &rl->rgi, es, ctx);
+                               flags | ROUTE_REF_GW, &rl->rgi, es, ctx, is=
_multipoint);
                 }
             }
         }
@@ -1185,9 +1195,10 @@
 bool
 add_routes(struct route_list *rl, struct route_ipv6_list *rl6,
            const struct tuntap *tt, unsigned int flags,
-           const struct env_set *es, openvpn_net_ctx_t *ctx)
+           const struct env_set *es, openvpn_net_ctx_t *ctx,
+           const bool is_multipoint)
 {
-    bool ret =3D redirect_default_route_to_vpn(rl, tt, flags, es, ctx);
+    bool ret =3D redirect_default_route_to_vpn(rl, tt, flags, es, ctx, is_=
multipoint);
     if (rl && !(rl->iflags & RL_ROUTES_ADDED) )
     {
         struct route_ipv4 *r;
@@ -1218,9 +1229,9 @@
             check_subnet_conflict(r->network, r->netmask, "route");
             if (flags & ROUTE_DELETE_FIRST)
             {
-                delete_route(r, tt, flags, &rl->rgi, es, ctx);
+                delete_route(r, tt, flags, &rl->rgi, es, ctx, is_multipoin=
t);
             }
-            ret =3D add_route(r, tt, flags, &rl->rgi, es, ctx) && ret;
+            ret =3D add_route(r, tt, flags, &rl->rgi, es, ctx, is_multipoi=
nt) && ret;
         }
         rl->iflags |=3D RL_ROUTES_ADDED;
     }
@@ -1240,9 +1251,9 @@
         {
             if (flags & ROUTE_DELETE_FIRST)
             {
-                delete_route_ipv6(r, tt, flags, es, ctx);
+                delete_route_ipv6(r, tt, flags, es, ctx, is_multipoint);
             }
-            ret =3D add_route_ipv6(r, tt, flags, es, ctx) && ret;
+            ret =3D add_route_ipv6(r, tt, flags, es, ctx, is_multipoint) &=
& ret;
         }
         rl6->iflags |=3D RL_ROUTES_ADDED;
     }
@@ -1253,19 +1264,20 @@
 void
 delete_routes(struct route_list *rl, struct route_ipv6_list *rl6,
               const struct tuntap *tt, unsigned int flags,
-              const struct env_set *es, openvpn_net_ctx_t *ctx)
+              const struct env_set *es, openvpn_net_ctx_t *ctx,
+              const bool is_multipoint)
 {
     if (rl && rl->iflags & RL_ROUTES_ADDED)
     {
         struct route_ipv4 *r;
         for (r =3D rl->routes; r; r =3D r->next)
         {
-            delete_route(r, tt, flags, &rl->rgi, es, ctx);
+            delete_route(r, tt, flags, &rl->rgi, es, ctx, is_multipoint);
         }
         rl->iflags &=3D ~RL_ROUTES_ADDED;
     }

-    undo_redirect_default_route_to_vpn(rl, tt, flags, es, ctx);
+    undo_redirect_default_route_to_vpn(rl, tt, flags, es, ctx, is_multipoi=
nt);

     if (rl)
     {
@@ -1277,7 +1289,7 @@
         struct route_ipv6 *r6;
         for (r6 =3D rl6->routes_ipv6; r6; r6 =3D r6->next)
         {
-            delete_route_ipv6(r6, tt, flags, es, ctx);
+            delete_route_ipv6(r6, tt, flags, es, ctx, is_multipoint);
         }
         rl6->iflags &=3D ~RL_ROUTES_ADDED;
     }
@@ -1561,13 +1573,47 @@
 }
 #endif

+static bool
+is_gateway_needed_ipv4(const struct route_ipv4 *r4,
+                       const struct route_gateway_info *rgi,
+                       const struct tuntap *tt,
+                       const bool is_multipoint)
+{
+
+#ifndef _WIN32
+
+    if (rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi->iface[0] !=3D 0)  =
/* vpn server special route */
+    {
+        if (rgi->flags & RGI_ADDR_DEFINED && r4->gateway !=3D 0)
+        {
+            return true;
+        }
+    }
+
+#endif
+
+    if (tt->type =3D=3D DEV_TYPE_TAP
+        && !( (r4->flags & RT_METRIC_DEFINED) && r4->metric =3D=3D 0 ) )
+    {
+        return true;
+    }
+
+    if (is_multipoint && !tt->options.disable_dco)
+    {
+        return true;
+    }
+
+    return false;
+}
+
 bool
 add_route(struct route_ipv4 *r,
           const struct tuntap *tt,
           unsigned int flags,
           const struct route_gateway_info *rgi,  /* may be NULL */
           const struct env_set *es,
-          openvpn_net_ctx_t *ctx)
+          openvpn_net_ctx_t *ctx,
+          const bool is_multipoint)
 {
     int status =3D 0;
     int is_local_route;
@@ -1581,18 +1627,6 @@
     struct argv argv =3D argv_new();
     struct gc_arena gc =3D gc_new();

-#if defined(TARGET_LINUX)
-    const char *iface =3D tt->actual_name;
-    if (rgi && rgi->iface[0] !=3D '\0')  /* vpn server special route */
-    {
-        iface =3D rgi->iface;
-        if (r->gateway !=3D 0)
-        {
-            gateway_needed =3D true;
-        }
-    }
-#endif
-
     const char *network =3D print_in_addr_t(r->network, 0, &gc);
 #if !defined(TARGET_LINUX)
 #if !defined(TARGET_AIX)
@@ -1607,10 +1641,7 @@
         goto done;
     }

-    if (tt->type =3D=3D DEV_TYPE_TAP && !(r->flags & RT_METRIC_DEFINED && =
r->metric =3D=3D 0))
-    {
-        gateway_needed =3D true;
-    }
+    gateway_needed =3D is_gateway_needed_ipv4(r, rgi, tt, is_multipoint);

     if (gateway_needed && r->gateway =3D=3D 0)
     {
@@ -1622,12 +1653,21 @@
         goto done;
     }

+#if !defined(_WIN32) && !defined(TARGET_SOLARIS) \
+    && !defined(TARGET_AIX)
+    const char *device =3D tt->actual_name;
+    if (!gateway_needed && rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi-=
>iface[0] !=3D 0)  /* vpn server special route */
+    {
+        device =3D rgi->iface;
+    }
+#endif
+
 #if defined(TARGET_LINUX)
     int metric =3D -1;

     if (is_on_link(is_local_route, flags, rgi))
     {
-        iface =3D rgi->iface;
+        device =3D rgi->iface;
     }

     if (r->flags & RT_METRIC_DEFINED)
@@ -1638,7 +1678,7 @@
     status =3D RTA_SUCCESS;
     int ret =3D net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->=
netmask),
                                gateway_needed ? &r->gateway : NULL,
-                               iface, 0, metric);
+                               device, 0, metric);
     if (ret =3D=3D -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed because route e=
xists");
@@ -1655,7 +1695,7 @@

     if (rgi)
     {
-        snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, ga=
teway, rgi->iface);
+        snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, ga=
teway, device);
     }
     else
     {
@@ -1759,9 +1799,9 @@
                                     "ERROR: Solaris route add command fail=
ed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;

-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

-    argv_printf(&argv, "%s add",
+    argv_printf(&argv, "%s add ",
                 ROUTE_PATH);
=20
 #if 0
@@ -1771,45 +1811,28 @@
     }
 #endif

-    argv_printf_cat(&argv, "-net %s %s %s",
-                    network,
-                    gateway,
-                    netmask);
-
-    /* FIXME -- add on-link support for FreeBSD */
-
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&argv, es, 0,
-                                    "ERROR: FreeBSD route add command fail=
ed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
-
-#elif defined(TARGET_DRAGONFLY)
-
-    argv_printf(&argv, "%s add",
-                ROUTE_PATH);
-
-#if 0
-    if (r->flags & RT_METRIC_DEFINED)
+    if (gateway_needed)
     {
-        argv_printf_cat(&argv, "-rtt %d", r->metric);
+        argv_printf_cat(&argv, "-net %s %s %s",
+                        network,
+                        gateway,
+                        netmask);
     }
-#endif
-
-    argv_printf_cat(&argv, "-net %s %s %s",
-                    network,
-                    gateway,
-                    netmask);
-
-    /* FIXME -- add on-link support for Dragonfly */
+    else
+    {
+        argv_printf_cat(&argv, "-net %s -iface %s",
+                        network,
+                        device);
+    }

     argv_msg(D_ROUTE, &argv);
     bool ret =3D openvpn_execve_check(&argv, es, 0,
-                                    "ERROR: DragonFly route add command fa=
iled");
+                                    "ERROR: BSD route add command failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;

 #elif defined(TARGET_DARWIN)

-    argv_printf(&argv, "%s add",
+    argv_printf(&argv, "%s add ",
                 ROUTE_PATH);

 #if 0
@@ -1830,10 +1853,19 @@
     }
     else
     {
-        argv_printf_cat(&argv, "-net %s %s %s",
-                        network,
-                        gateway,
-                        netmask);
+        if (gateway_needed)
+        {
+            argv_printf_cat(&argv, "-net %s %s %s",
+                            network,
+                            gateway,
+                            netmask);
+        }
+        else
+        {
+            argv_printf_cat(&argv, "-net %s -interface %s",
+                            network,
+                            device);
+        }
     }

     argv_msg(D_ROUTE, &argv);
@@ -1843,7 +1875,7 @@

 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)

-    argv_printf(&argv, "%s add",
+    argv_printf(&argv, "%s add ",
                 ROUTE_PATH);

 #if 0
@@ -1853,12 +1885,20 @@
     }
 #endif

-    argv_printf_cat(&argv, "-net %s %s -netmask %s",
-                    network,
-                    gateway,
-                    netmask);
-
-    /* FIXME -- add on-link support for OpenBSD/NetBSD */
+    if (gateway_needed)
+    {
+        argv_printf_cat(&argv, "-net %s %s -netmask %s",
+                        network,
+                        gateway,
+                        netmask);
+    }
+    else
+    {
+        argv_printf_cat(&argv, "-net %s -netmask %s -link -iface %s",
+                        network,
+                        netmask,
+                        device);
+    }

     argv_msg(D_ROUTE, &argv);
     bool ret =3D openvpn_execve_check(&argv, es, 0,
@@ -1923,10 +1963,98 @@
     }
 }

+static inline struct in6_addr
+netbits_to_netmask_ipv6(const int netbits)
+{
+    struct in6_addr netmask =3D {{{0}}};
+
+    if (netbits > 0 && netbits <=3D 128)
+    {
+        const int full_bytes =3D netbits / 8;
+        int i;
+        for (i =3D 0; i < full_bytes; i++)
+        {
+            netmask.s6_addr[i] =3D 0xFF;
+        }
+        if (netbits % 8)
+        {
+            netmask.s6_addr[i] =3D (0xFF << (8 - (netbits % 8)));
+        }
+    }
+
+    return netmask;
+}
+
+static bool
+is_gateway_in_vpn_subnet_ipv6(const struct in6_addr *gateway,
+                              const struct in6_addr *vpn_subnet,
+                              int netbits)
+{
+    struct in6_addr netmask =3D netbits_to_netmask_ipv6(netbits);
+
+    for (int i =3D 0; i < 16; i++)
+    {
+        if ((gateway->s6_addr[i] & netmask.s6_addr[i]) !=3D (vpn_subnet->s=
6_addr[i] & netmask.s6_addr[i]))
+        {
+            return false;
+        }
+    }
+    return true;
+}
+
+static bool
+is_gateway_needed_ipv6(const struct route_ipv6 *r6,
+                       const struct tuntap *tt,
+                       const char *network,
+                       const bool is_multipoint)
+{
+
+#ifndef _WIN32
+    if (r6->iface !=3D NULL)   /* VPN server special route */
+    {
+        if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway))
+        {
+            return true;
+        }
+    }
+#endif
+
+    /*
+     * Filter out routes which are essentially no-ops
+     * (not currently done for IPv6)
+     */
+
+    /* On "tun" interface, we never set a gateway if the operating system
+     * can do "route to interface" - it does not add value, as the target
+     * dev already fully qualifies the route destination on point-to-point
+     * interfaces.   OTOH, on "tap" interface, we must always set the
+     * gateway unless the route is to be an on-link network
+     */
+    if (tt->type =3D=3D DEV_TYPE_TAP
+        && !( (r6->flags & RT_METRIC_DEFINED) && r6->metric =3D=3D 0 ) )
+    {
+        return true;
+    }
+
+    /* if is server and dco enabled, the gateway is needed*/
+    if (is_multipoint && !tt->options.disable_dco)
+    {
+        return true;
+    }
+
+    if (is_gateway_in_vpn_subnet_ipv6(&r6->gateway, &tt->local_ipv6, tt->n=
etbits_ipv6))
+    {
+        msg(D_ROUTE, "Ignoring gateway in VPN subnet for route %s/%d", net=
work, r6->netbits);
+        return false;
+    }
+
+    return false;
+}
+
 bool
 add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
                unsigned int flags, const struct env_set *es,
-               openvpn_net_ctx_t *ctx)
+               openvpn_net_ctx_t *ctx, const bool is_multipoint)
 {
     int status =3D 0;
     bool gateway_needed =3D false;
@@ -1939,22 +2067,12 @@
     struct argv argv =3D argv_new();
     struct gc_arena gc =3D gc_new();

-#ifndef _WIN32
-    const char *device =3D tt->actual_name;
-    if (r6->iface !=3D NULL)              /* vpn server special route */
-    {
-        device =3D r6->iface;
-        if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
-        {
-            gateway_needed =3D true;
-        }
-    }
-#endif
-
     route_ipv6_clear_host_bits(r6);
     const char *network =3D print_in6_addr( r6->network, 0, &gc);
     const char *gateway =3D print_in6_addr( r6->gateway, 0, &gc);

+    gateway_needed =3D is_gateway_needed_ipv6(r6, tt, network, is_multipoi=
nt);
+
 #if defined(TARGET_DARWIN)    \
     || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
     || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
@@ -1973,6 +2091,16 @@
     }
 #endif

+#if !defined(_WIN32) && !defined(TARGET_SOLARIS) \
+    && !defined(TARGET_AIX)
+
+    const char *device =3D tt->actual_name;
+    if (r6->iface !=3D NULL)
+    {
+        device =3D r6->iface;
+    }
+#endif
+
 #ifndef _WIN32
     msg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) dev %s",
         network, r6->netbits, gateway, r6->metric, device );
@@ -1982,23 +2110,6 @@
         r6->adapter_index ? r6->adapter_index : tt->adapter_index);
 #endif
=20
-    /*
-     * Filter out routes which are essentially no-ops
-     * (not currently done for IPv6)
-     */
-
-    /* On "tun" interface, we never set a gateway if the operating system
-     * can do "route to interface" - it does not add value, as the target
-     * dev already fully qualifies the route destination on point-to-point
-     * interfaces.   OTOH, on "tap" interface, we must always set the
-     * gateway unless the route is to be an on-link network
-     */
-    if (tt->type =3D=3D DEV_TYPE_TAP
-        && !( (r6->flags & RT_METRIC_DEFINED) && r6->metric =3D=3D 0 ) )
-    {
-        gateway_needed =3D true;
-    }
-
     if (gateway_needed && IN6_IS_ADDR_UNSPECIFIED(&r6->gateway))
     {
         msg(M_WARN, "ROUTE6 WARNING: " PACKAGE_NAME " needs a gateway "
@@ -2011,6 +2122,7 @@

 #if defined(TARGET_LINUX)
     int metric =3D -1;
+
     if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
         metric =3D r6->metric;
@@ -2080,7 +2192,7 @@

 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

-    argv_printf(&argv, "%s add -inet6 %s/%d",
+    argv_printf(&argv, "%s add -inet6 %s/%d ",
                 ROUTE_PATH,
                 network,
                 r6->netbits);
@@ -2101,7 +2213,7 @@

 #elif defined(TARGET_DARWIN)

-    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d",
+    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d ",
                 ROUTE_PATH,
                 network, r6->netbits );

@@ -2119,26 +2231,27 @@
                                     "ERROR: MacOS X route add -inet6 comma=
nd failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;

-#elif defined(TARGET_OPENBSD)
+#elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)

-    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d %s",
+    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d ",
                 ROUTE_PATH,
-                network, r6->netbits, gateway );
+                network, r6->netbits);
+
+    if (gateway_needed)
+    {
+        argv_printf_cat(&argv, "%s", gateway);
+    }
+    else
+    {
+        argv_printf_cat(&argv, "-link -iface %s", device);
+    }
+    /* FIX ME: in NetBSD in TUN mode, the route is already added by ifconf=
ig
+     * so add_route_ipv6 fail with 'Invalid argument' or 'File exists'
+     */

     argv_msg(D_ROUTE, &argv);
     bool ret =3D openvpn_execve_check(&argv, es, 0,
-                                    "ERROR: OpenBSD route add -inet6 comma=
nd failed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
-
-#elif defined(TARGET_NETBSD)
-
-    argv_printf(&argv, "%s add -inet6 %s/%d %s",
-                ROUTE_PATH,
-                network, r6->netbits, gateway );
-
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&argv, es, 0,
-                                    "ERROR: NetBSD route add -inet6 comman=
d failed");
+                                    "ERROR: OpenBSD/NetBSD route add -inet=
6 command failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;

 #elif defined(TARGET_AIX)
@@ -2178,7 +2291,8 @@
              unsigned int flags,
              const struct route_gateway_info *rgi,
              const struct env_set *es,
-             openvpn_net_ctx_t *ctx)
+             openvpn_net_ctx_t *ctx,
+             const bool is_multipoint)
 {
 #if !defined(TARGET_LINUX)
     const char *network;
@@ -2193,6 +2307,21 @@
 #endif
     int is_local_route;

+#if defined(TARGET_DARWIN) || defined(TARGET_LINUX)  \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
+    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+
+    bool gateway_needed =3D is_gateway_needed_ipv4(r, rgi, tt, is_multipoi=
nt);
+
+#if !defined(TARGET_OPENBSD) && !defined(TARGET_NETBSD)
+    const char *device =3D tt->actual_name;
+    if (!gateway_needed && rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi-=
>iface[0] !=3D 0)  /* vpn server special route */
+    {
+        device =3D rgi->iface;
+    }
+#endif
+#endif
+
     if ((r->flags & (RT_DEFINED|RT_ADDED)) !=3D (RT_DEFINED|RT_ADDED))
     {
         return;
@@ -2219,13 +2348,20 @@

 #if defined(TARGET_LINUX)
     metric =3D -1;
+
+    if (is_on_link(is_local_route, flags, rgi))
+    {
+        device =3D rgi->iface;
+    }
+
     if (r->flags & RT_METRIC_DEFINED)
     {
         metric =3D r->metric;
     }

     if (net_route_v4_del(ctx, &r->network, netmask_to_netbits2(r->netmask),
-                         &r->gateway, NULL, 0, metric) < 0)
+                         gateway_needed ? &r->gateway : NULL,
+                         device, 0, metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route delete command failed");
     }
@@ -2284,27 +2420,30 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route delete comman=
d failed");

-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

-    argv_printf(&argv, "%s delete -net %s %s %s",
+    argv_printf(&argv, "%s delete",
                 ROUTE_PATH,
                 network,
                 gateway,
                 netmask);

-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: FreeBSD route delete comman=
d failed");
-
-#elif defined(TARGET_DRAGONFLY)
-
-    argv_printf(&argv, "%s delete -net %s %s %s",
-                ROUTE_PATH,
-                network,
-                gateway,
-                netmask);
+    if (gateway_needed)
+    {
+        argv_printf_cat(&argv, "-net %s %s %s",
+                        network,
+                        gateway,
+                        netmask);
+    }
+    else
+    {
+        argv_printf_cat(&argv, "-net %s -iface %s",
+                        network,
+                        device);
+    }

     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: DragonFly route delete comm=
and failed");
+    openvpn_execve_check(&argv, es, 0, "ERROR: BSD route delete command fa=
iled");

 #elif defined(TARGET_DARWIN)

@@ -2318,11 +2457,22 @@
     }
     else
     {
-        argv_printf(&argv, "%s delete -net %s %s %s",
-                    ROUTE_PATH,
-                    network,
-                    gateway,
-                    netmask);
+        argv_printf(&argv, "%s delete ",
+                    ROUTE_PATH);
+
+        if (gateway_needed)
+        {
+            argv_printf_cat(&argv, "-net %s %s %s",
+                            network,
+                            gateway,
+                            netmask);
+        }
+        else
+        {
+            argv_printf_cat(&argv, "-net %s -interface %s",
+                            network,
+                            device);
+        }
     }

     argv_msg(D_ROUTE, &argv);
@@ -2330,11 +2480,22 @@

 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)

-    argv_printf(&argv, "%s delete -net %s %s -netmask %s",
-                ROUTE_PATH,
-                network,
-                gateway,
-                netmask);
+    argv_printf(&argv, "%s delete ",
+                ROUTE_PATH);
+
+    if (gateway_needed)
+    {
+        argv_printf_cat(&argv, "-net %s %s -netmask %s",
+                        network,
+                        gateway,
+                        netmask);
+    }
+    else
+    {
+        argv_printf_cat(&argv, "-net %s -netmask %s",
+                        network,
+                        netmask);
+    }

     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete=
 command failed");
@@ -2369,7 +2530,7 @@
 void
 delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
                   unsigned int flags, const struct env_set *es,
-                  openvpn_net_ctx_t *ctx)
+                  openvpn_net_ctx_t *ctx, const bool is_multipoint)
 {
     const char *network;

@@ -2382,23 +2543,15 @@
 #if !defined(TARGET_LINUX)
     const char *gateway;
 #endif
-#if !defined(TARGET_SOLARIS)
-    bool gateway_needed =3D false;
+#if defined(TARGET_DARWIN) || defined(TARGET_LINUX)  \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
+
     const char *device =3D tt->actual_name;
     if (r6->iface !=3D NULL)              /* vpn server special route */
     {
         device =3D r6->iface;
-        gateway_needed =3D true;
     }

-    /* if we used a gateway on "add route", we also need to specify it on
-     * delete, otherwise some OSes will refuse to delete the route
-     */
-    if (tt->type =3D=3D DEV_TYPE_TAP
-        && !( (r6->flags & RT_METRIC_DEFINED) && r6->metric =3D=3D 0 ) )
-    {
-        gateway_needed =3D true;
-    }
 #endif
 #endif

@@ -2410,6 +2563,16 @@
     gateway =3D print_in6_addr( r6->gateway, 0, &gc);
 #endif

+#if defined(TARGET_DARWIN) || defined(TARGET_LINUX)  \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
+    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+    /* if we used a gateway on "add route", we also need to specify it on
+     * delete, otherwise some OSes will refuse to delete the route
+     */
+    bool gateway_needed =3D false;
+    gateway_needed =3D is_gateway_needed_ipv6(r6, tt, network, is_multipoi=
nt);
+#endif
+
 #if defined(TARGET_DARWIN)    \
     || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
     || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
@@ -2504,23 +2667,19 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: MacOS X route delete -inet6=
 command failed");

-#elif defined(TARGET_OPENBSD)
+#elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)

-    argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d %s",
+    argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d",
                 ROUTE_PATH,
-                network, r6->netbits, gateway );
+                network, r6->netbits);
+
+    if (gateway_needed)
+    {
+        argv_printf_cat(&argv, "%s", gateway);
+    }

     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD route delete -inet6=
 command failed");
-
-#elif defined(TARGET_NETBSD)
-
-    argv_printf(&argv, "%s delete -inet6 %s/%d %s",
-                ROUTE_PATH,
-                network, r6->netbits, gateway );
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: NetBSD route delete -inet6 =
command failed");
+    openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete=
 -inet6 command failed");

 #elif defined(TARGET_AIX)

diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 421e7d2..4c3f317 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -271,13 +271,13 @@

 void route_ipv6_clear_host_bits( struct route_ipv6 *r6 );

-bool add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigne=
d int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
+bool add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigne=
d int flags, const struct env_set *es, openvpn_net_ctx_t *ctx, const bool i=
s_multipoint);

-void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt=
, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
+void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt=
, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx, con=
st bool is_multipoint);

 bool add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int=
 flags,
                const struct route_gateway_info *rgi, const struct env_set =
*es,
-               openvpn_net_ctx_t *ctx);
+               openvpn_net_ctx_t *ctx, const bool is_multipoint);

 void add_route_to_option_list(struct route_option_list *l,
                               const char *network,
@@ -312,14 +312,16 @@

 bool add_routes(struct route_list *rl, struct route_ipv6_list *rl6,
                 const struct tuntap *tt, unsigned int flags,
-                const struct env_set *es, openvpn_net_ctx_t *ctx);
+                const struct env_set *es, openvpn_net_ctx_t *ctx,
+                const bool is_multipoint);

 void delete_routes(struct route_list *rl,
                    struct route_ipv6_list *rl6,
                    const struct tuntap *tt,
                    unsigned int flags,
                    const struct env_set *es,
-                   openvpn_net_ctx_t *ctx);
+                   openvpn_net_ctx_t *ctx,
+                   const bool is_multipoint);

 void setenv_routes(struct env_set *es, const struct route_list *rl);

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ce3d882..d878161 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1020,7 +1020,7 @@
  */
 static void
 add_route_connected_v6_net(struct tuntap *tt,
-                           const struct env_set *es)
+                           const struct env_set *es, const bool is_multipo=
int)
 {
     struct route_ipv6 r6;

@@ -1030,11 +1030,11 @@
     r6.gateway =3D tt->local_ipv6;
     r6.metric  =3D 0;                     /* connected route */
     r6.flags   =3D RT_DEFINED | RT_METRIC_DEFINED;
-    add_route_ipv6(&r6, tt, 0, es, NULL);
+    add_route_ipv6(&r6, tt, 0, es, NULL, is_multipoint);
 }

 void
-delete_route_connected_v6_net(const struct tuntap *tt)
+delete_route_connected_v6_net(const struct tuntap *tt, const bool is_multi=
point)
 {
     struct route_ipv6 r6;

@@ -1045,7 +1045,7 @@
     r6.metric  =3D 0;                     /* connected route */
     r6.flags   =3D RT_DEFINED | RT_ADDED | RT_METRIC_DEFINED;
     route_ipv6_clear_host_bits(&r6);
-    delete_route_ipv6(&r6, tt, 0, NULL, NULL);
+    delete_route_ipv6(&r6, tt, 0, NULL, NULL, is_multipoint);
 }
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_N=
ETBSD) || defined(TARGET_OPENBSD) */

@@ -1087,7 +1087,8 @@
  */
 static void
 do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
-                 const struct env_set *es, openvpn_net_ctx_t *ctx)
+                 const struct env_set *es, openvpn_net_ctx_t *ctx,
+                 const bool is_multipoint)
 {
 #if !defined(TARGET_LINUX)
     struct argv argv =3D argv_new();
@@ -1205,7 +1206,7 @@
 #if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
     || defined(TARGET_DARWIN)
     /* and, hooray, we explicitly need to add a route... */
-    add_route_connected_v6_net(tt, es);
+    add_route_connected_v6_net(tt, es, is_multipoint);
 #endif
 #elif defined(TARGET_AIX)
     argv_printf(&argv, "%s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, ifnam=
e,
@@ -1231,7 +1232,7 @@
         do_address_service(true, AF_INET6, tt);
         if (tt->type =3D=3D DEV_TYPE_TUN)
         {
-            add_route_connected_v6_net(tt, es);
+            add_route_connected_v6_net(tt, es, is_multipoint);
         }
         do_dns_service(true, AF_INET6, tt);
         do_set_mtu_service(tt, AF_INET6, tun_mtu);
@@ -1259,7 +1260,7 @@
         netsh_command(&argv, 4, M_FATAL);
         if (tt->type =3D=3D DEV_TYPE_TUN)
         {
-            add_route_connected_v6_net(tt, es);
+            add_route_connected_v6_net(tt, es, is_multipoint);
         }
         /* set ipv6 dns servers if any are specified */
         netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, tt-=
>adapter_index);
@@ -1291,7 +1292,7 @@
  */
 static void
 do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
-                 const struct env_set *es, openvpn_net_ctx_t *ctx)
+                 const struct env_set *es, openvpn_net_ctx_t *ctx, const b=
ool is_multipoint)
 {
 #if !defined(_WIN32) && !defined(TARGET_ANDROID)
     /*
@@ -1415,7 +1416,7 @@
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D tt->local;
         r.metric =3D 0;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_OPENBSD)
@@ -1462,7 +1463,7 @@
         r.network =3D tt->local & tt->remote_netmask;
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D remote_end;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_NETBSD)
@@ -1504,7 +1505,7 @@
         r.network =3D tt->local & tt->remote_netmask;
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D remote_end;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_DARWIN)
@@ -1554,7 +1555,7 @@
         r.network =3D tt->local & tt->remote_netmask;
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D tt->local;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
@@ -1648,7 +1649,7 @@
 /* execute the ifconfig command through the shell */
 void
 do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
-            const struct env_set *es, openvpn_net_ctx_t *ctx)
+            const struct env_set *es, openvpn_net_ctx_t *ctx, const bool i=
s_multipoint)
 {
     msg(D_LOW, "do_ifconfig, ipv4=3D%d, ipv6=3D%d", tt->did_ifconfig_setup,
         tt->did_ifconfig_ipv6_setup);
@@ -1668,12 +1669,12 @@

     if (tt->did_ifconfig_setup)
     {
-        do_ifconfig_ipv4(tt, ifname, tun_mtu, es, ctx);
+        do_ifconfig_ipv4(tt, ifname, tun_mtu, es, ctx, is_multipoint);
     }

     if (tt->did_ifconfig_ipv6_setup)
     {
-        do_ifconfig_ipv6(tt, ifname, tun_mtu, es, ctx);
+        do_ifconfig_ipv6(tt, ifname, tun_mtu, es, ctx, is_multipoint);
     }

     /* release resources potentially allocated during interface setup */
@@ -2138,12 +2139,13 @@
 }

 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

     close_tun_generic(tt);
     free(tt);
+    (void)is_multipoint;
 }

 int
@@ -2307,7 +2309,8 @@
 void
 tuncfg(const char *dev, const char *dev_type, const char *dev_node,
        int persist_mode, const char *username, const char *groupname,
-       const struct tuntap_options *options, openvpn_net_ctx_t *ctx)
+       const struct tuntap_options *options, openvpn_net_ctx_t *ctx,
+       const bool is_multipoint)
 {
     struct tuntap *tt;

@@ -2347,14 +2350,14 @@
             msg(M_ERR, "Cannot ioctl TUNSETGROUP(%s) %s", groupname, dev);
         }
     }
-    close_tun(tt, ctx);
+    close_tun(tt, ctx, is_multipoint);
     msg(M_INFO, "Persist state set to: %s", (persist_mode ? "ON" : "OFF"));
 }

 #endif /* ENABLE_FEATURE_TUN_PERSIST */

 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -2366,6 +2369,7 @@
 #endif
     close_tun_generic(tt);
     free(tt);
+    (void)is_multipoint;
 }

 int
@@ -2677,7 +2681,7 @@
  * Close TUN device.
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -2687,6 +2691,7 @@

     clear_tuntap(tt);
     free(tt);
+    (void)is_multipoint;
 }

 static void
@@ -2710,7 +2715,7 @@

     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, 0, "Solaris ifconfig unplumb failed");
-    close_tun(tt, NULL);
+    close_tun(tt, NULL, false);
     msg(M_FATAL, "Solaris ifconfig failed");
     argv_free(&argv);
 }
@@ -2774,10 +2779,12 @@
  */

 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

+    (void)is_multipoint;
+
     /* only *TAP* devices need destroying, tun devices auto-self-destruct
      */
     if (tt->type =3D=3D DEV_TYPE_TUN || tt->persistent_if)
@@ -2888,10 +2895,12 @@
  * need to be explicitly destroyed
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

+    (void)is_multipoint;
+
     /* only tun devices need destroying, tap devices auto-self-destruct
      */
     if (tt->type !=3D DEV_TYPE_TUN || tt->persistent_if)
@@ -3044,10 +3053,12 @@
  * we need to call "ifconfig ... destroy" for cleanup
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

+    (void)is_multipoint;
+
     if (tt->persistent_if)        /* keep pre-existing if around */
     {
         close_tun_generic(tt);
@@ -3161,12 +3172,13 @@
 }

 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

     close_tun_generic(tt);
     free(tt);
+    (void)is_multipoint;
 }

 int
@@ -3428,7 +3440,7 @@
 }

 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -3450,6 +3462,7 @@
     free(tt);
     argv_free(&argv);
     gc_free(&gc);
+    (void)is_multipoint;
 }

 int
@@ -3577,7 +3590,7 @@
 /* tap devices need to be manually destroyed on AIX
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -3605,6 +3618,7 @@
     free(tt);
     env_set_destroy(es);
     argv_free(&argv);
+    (void)is_multipoint;
 }

 int
@@ -6892,7 +6906,7 @@
 }

 static void
-netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_are=
na *gc)
+netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_are=
na *gc, const bool is_multipoint)
 {
     const char *ifconfig_ip_local;
     struct argv argv =3D argv_new();
@@ -6922,7 +6936,7 @@

     if (ipv6 && tt->type =3D=3D DEV_TYPE_TUN)
     {
-        delete_route_connected_v6_net(tt);
+        delete_route_connected_v6_net(tt, is_multipoint);
     }

     /* "store=3Dactive" is needed in Windows 8(.1) to delete the
@@ -6992,7 +7006,7 @@
 }

 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -7012,7 +7026,7 @@
                 do_dns_domain_service(false, tt);
             }
             do_dns_service(false, AF_INET6, tt);
-            delete_route_connected_v6_net(tt);
+            delete_route_connected_v6_net(tt, is_multipoint);
             do_address_service(false, AF_INET6, tt);
         }
         else
@@ -7022,7 +7036,7 @@
                 do_dns_domain_wmic(false, tt);
             }

-            netsh_delete_address_dns(tt, true, &gc);
+            netsh_delete_address_dns(tt, true, &gc, is_multipoint);
         }
     }

@@ -7049,7 +7063,7 @@

             if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
             {
-                netsh_delete_address_dns(tt, false, &gc);
+                netsh_delete_address_dns(tt, false, &gc, is_multipoint);
             }
         }
     }
@@ -7170,12 +7184,13 @@
 }

 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

     close_tun_generic(tt);
     free(tt);
+    (void)is_multipoint;
 }

 int
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 33b9552..9716d19 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -266,7 +266,7 @@
 void open_tun(const char *dev, const char *dev_type, const char *dev_node,
               struct tuntap *tt, openvpn_net_ctx_t *ctx);

-void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_mu=
ltipoint);

 void tun_open_device(struct tuntap *tt, const char *dev_node,
                      const char **device_guid, struct gc_arena *gc);
@@ -280,7 +280,7 @@
 void tuncfg(const char *dev, const char *dev_type, const char *dev_node,
             int persist_mode, const char *username,
             const char *groupname, const struct tuntap_options *options,
-            openvpn_net_ctx_t *ctx);
+            openvpn_net_ctx_t *ctx, const bool is_multipoint);

 const char *guess_tuntap_dev(const char *dev,
                              const char *dev_type,
@@ -319,7 +319,7 @@
  * @param ctx       the networking API opaque context
  */
 void do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
-                 const struct env_set *es, openvpn_net_ctx_t *ctx);
+                 const struct env_set *es, openvpn_net_ctx_t *ctx, const b=
ool is_multipoint);

 /**
  * undo_ifconfig - undo configuration of the tunnel interface
@@ -754,6 +754,7 @@
 }

 const char *tun_stat(const struct tuntap *tt, unsigned int rwflags, struct=
 gc_arena *gc);
+
 bool tun_name_is_fixed(const char *dev);

 static inline bool

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/678?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3dbd61fef20d683734b55b73e40afe56c3b733e1
Gerrit-Change-Number: 678
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-MessageType: newpatchset

--pSOeZibMVeA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>mrbff <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/678?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">route: extended logic to omit gateway when un=
necessary<br><br>Extracted and extended the logic behind &#39;gateway_neede=
d&#39; both in<br>add_route() and add_route_ipv6(). Other than checking the=
 dev-type,<br>special routes and if the gateway is on-link,<br>- set gatewa=
y_needed to true if the vpn instance is a multipoint server<br>  and DCO is=
 enabled.<br>- set gateway_needed to false if the gateway is in the vpn sub=
net.<br>Additionally, extended support for these checks and conditions to D=
ARWIN<br>and BSD-based operating systems.<br><br>These changes ensure that =
the gateway is only included when necessary,<br>optimizing route configurat=
ion and potentially reducing redundant route entries.<br><br>Change-Id: I3d=
bd61fef20d683734b55b73e40afe56c3b733e1<br>Signed-off-by: Marco Baffo &lt;ma=
rco@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/init.=
c<br>M src/openvpn/init.h<br>M src/openvpn/route.c<br>M src/openvpn/route.h=
<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>7 files changed, 425 inse=
rtions(+), 247 deletions(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/78/678/2</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c=
 b/src/openvpn/forward.c</span><br><span>index 40b7cc4..8c22bc9 100644</spa=
n><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/f=
orward.c</span><br><span>@@ -421,7 +421,7 @@</span><br><span> check_add_rou=
tes_action(struct context *c, const bool errors)</span><br><span> {</span><=
br><span>     bool route_status =3D do_route(&amp;c-&gt;options, c-&gt;c1.r=
oute_list, c-&gt;c1.route_ipv6_list,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                 c-&gt;c1.tuntap, c-&gt;plug=
ins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                 c-&gt;c1.tuntap, c-&gt;=
plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D CM_TOP);</span>=
<br><span> </span><br><span>     int flags =3D (errors ? ISC_ERRORS : 0);</=
span><br><span>     flags |=3D (!route_status ? ISC_ROUTE_ERRORS : 0);</spa=
n><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br>=
<span>index a49e563..b0b2145 100644</span><br><span>--- a/src/openvpn/init.=
c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -1134,7 +1134=
,7 @@</span><br><span>     tuncfg(options-&gt;dev, options-&gt;dev_type, op=
tions-&gt;dev_node,</span><br><span>            options-&gt;persist_mode,</=
span><br><span>            options-&gt;username, options-&gt;groupname, &am=
p;options-&gt;tuntap_options,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-           ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+           ctx, options-&gt;mode =3D=3D MODE_SERVER);</span><br><span>=
     if (options-&gt;persist_mode &amp;&amp; options-&gt;lladdr)</span><br>=
<span>     {</span><br><span>         set_lladdr(ctx, options-&gt;dev, opti=
ons-&gt;lladdr, NULL);</span><br><span>@@ -1689,13 +1689,14 @@</span><br><s=
pan>          const struct tuntap *tt,</span><br><span>          const stru=
ct plugin_list *plugins,</span><br><span>          struct env_set *es,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-         openvpn_net_ctx_t=
 *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         open=
vpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         const bool is_multipoint)</span><br><span> {</span><br><span>     =
bool ret =3D true;</span><br><span>     if (!options-&gt;route_noexec &amp;=
&amp; ( route_list || route_ipv6_list ) )</span><br><span>     {</span><br>=
<span>         ret =3D add_routes(route_list, route_ipv6_list, tt, ROUTE_OP=
TION_FLAGS(options),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                        es, ctx);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                         es, ctx, is_multipoint);</span><br><=
span>         setenv_int(es, &quot;redirect_gateway&quot;, route_did_redire=
ct_default_gateway(route_list));</span><br><span>     }</span><br><span> #i=
fdef ENABLE_MANAGEMENT</span><br><span>@@ -1898,7 +1899,7 @@</span><br><spa=
n>                                                  c-&gt;options.dev_node,=
</span><br><span>                                                  &amp;gc)=
;</span><br><span>             do_ifconfig(c-&gt;c1.tuntap, guess, c-&gt;c2=
.frame.tun_mtu, c-&gt;c2.es,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                        &amp;c-&gt;net_ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &amp;c-&gt;net_ct=
x, c-&gt;mode =3D=3D CM_TOP);</span><br><span>         }</span><br><span> <=
/span><br><span>         /* possibly add routes */</span><br><span>@@ -1906=
,7 +1907,7 @@</span><br><span>         {</span><br><span>             /* Ig=
nore route_delay, would cause ROUTE_BEFORE_TUN to be ignored */</span><br><=
span>             bool status =3D do_route(&amp;c-&gt;options, c-&gt;c1.rou=
te_list, c-&gt;c1.route_ipv6_list,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                   c-&gt;c1.tuntap, c-&gt;plug=
ins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                   c-&gt;c1.tuntap, c-&g=
t;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D CM_TOP);</spa=
n><br><span>             *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);=
</span><br><span>         }</span><br><span> #ifdef TARGET_ANDROID</span><b=
r><span>@@ -1934,7 +1935,7 @@</span><br><span>             &amp;&amp; ifcon=
fig_order() =3D=3D IFCONFIG_AFTER_TUN_OPEN)</span><br><span>         {</spa=
n><br><span>             do_ifconfig(c-&gt;c1.tuntap, c-&gt;c1.tuntap-&gt;a=
ctual_name,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D=
 CM_TOP);</span><br><span>         }</span><br><span> </span><br><span>    =
     /* run the up script */</span><br><span>@@ -1960,7 +1961,7 @@</span><b=
r><span>         if ((route_order() =3D=3D ROUTE_AFTER_TUN) &amp;&amp; (!c-=
&gt;options.route_delay_defined))</span><br><span>         {</span><br><spa=
n>             int status =3D do_route(&amp;c-&gt;options, c-&gt;c1.route_l=
ist, c-&gt;c1.route_ipv6_list,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                  c-&gt;c1.tuntap, c-&gt;plugins, =
c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                  c-&gt;c1.tuntap, c-&gt;plug=
ins, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D CM_TOP);</span><br>=
<span>             *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);</span=
><br><span>         }</span><br><span> </span><br><span>@@ -2017,7 +2018,7 =
@@</span><br><span>         {</span><br><span>             undo_ifconfig(c-=
&gt;c1.tuntap, &amp;c-&gt;net_ctx);</span><br><span>         }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        close_tun(c-&gt;c1.tuntap,=
 &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        close_tun(c-&gt;c1.tuntap, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D =
CM_TOP);</span><br><span>         c-&gt;c1.tuntap =3D NULL;</span><br><span=
>     }</span><br><span>     c-&gt;c1.tuntap_owned =3D false;</span><br><sp=
an>@@ -2086,7 +2087,7 @@</span><br><span> </span><br><span>             del=
ete_routes(c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,</span><br><span> =
                          c-&gt;c1.tuntap, ROUTE_OPTION_FLAGS(&amp;c-&gt;op=
tions),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
            c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                          c-&gt;c2.es, &amp;c-&gt=
;net_ctx, c-&gt;mode =3D=3D CM_TOP);</span><br><span>         }</span><br><=
span> </span><br><span>         /* actually close tun/tap device based on -=
-down-pre flag */</span><br><span>diff --git a/src/openvpn/init.h b/src/ope=
nvpn/init.h</span><br><span>index ea7eb30..82eec7e 100644</span><br><span>-=
-- a/src/openvpn/init.h</span><br><span>+++ b/src/openvpn/init.h</span><br>=
<span>@@ -74,7 +74,7 @@</span><br><span> bool do_route(const struct options=
 *options, struct route_list *route_list,</span><br><span>               st=
ruct route_ipv6_list *route_ipv6_list, const struct tuntap *tt,</span><br><=
span>               const struct plugin_list *plugins, struct env_set *es,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-              openvpn_=
net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
           openvpn_net_ctx_t *ctx, const bool is_multipoint);</span><br><sp=
an> </span><br><span> void close_instance(struct context *c);</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c=
</span><br><span>index bc8f561..5870a0f 100644</span><br><span>--- a/src/op=
envpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ =
-77,7 +77,7 @@</span><br><span> </span><br><span> static void delete_route(=
struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,</span><b=
r><span>                          const struct route_gateway_info *rgi, con=
st struct env_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                         openvpn_net_ctx_t *ctx);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                         openvpn_net_ctx_t *=
ctx, const bool is_multipoint);</span><br><span> </span><br><span> static v=
oid get_bypass_addresses(struct route_bypass *rb, const unsigned int flags)=
;</span><br><span> </span><br><span>@@ -927,7 +927,8 @@</span><br><span>   =
         unsigned int flags,</span><br><span>            const struct route=
_gateway_info *rgi,</span><br><span>            const struct env_set *es,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-           openvpn_net_=
ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
   openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+           const bool is_multipoint)</span><br><span> {</span><br><s=
pan>     struct route_ipv4 r;</span><br><span>     CLEAR(r);</span><br><spa=
n>@@ -935,7 +936,7 @@</span><br><span>     r.network =3D network;</span><br=
><span>     r.netmask =3D netmask;</span><br><span>     r.gateway =3D gatew=
ay;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return add_rou=
te(&amp;r, tt, flags, rgi, es, ctx);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return add_route(&amp;r, tt, flags, rgi, es, ctx, is_m=
ultipoint);</span><br><span> }</span><br><span> </span><br><span> static vo=
id</span><br><span>@@ -946,7 +947,8 @@</span><br><span>            unsigned=
 int flags,</span><br><span>            const struct route_gateway_info *rg=
i,</span><br><span>            const struct env_set *es,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-           openvpn_net_ctx_t *ctx)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+           openvpn_net_ct=
x_t *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
 const bool is_multipoint)</span><br><span> {</span><br><span>     struct r=
oute_ipv4 r;</span><br><span>     CLEAR(r);</span><br><span>@@ -954,7 +956,=
7 @@</span><br><span>     r.network =3D network;</span><br><span>     r.net=
mask =3D netmask;</span><br><span>     r.gateway =3D gateway;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    delete_route(&amp;r, tt, flags,=
 rgi, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
delete_route(&amp;r, tt, flags, rgi, es, ctx, is_multipoint);</span><br><sp=
an> }</span><br><span> </span><br><span> static bool</span><br><span>@@ -96=
4,7 +966,8 @@</span><br><span>                   unsigned int flags,</span>=
<br><span>                   const struct route_gateway_info *rgi,</span><b=
r><span>                   const struct env_set *es,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                  openvpn_net_ctx_t *ctx)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  ope=
nvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                  const bool is_multipoint)</span><br><span> {</span><br><=
span>     int ret =3D true;</span><br><span>     for (int i =3D 0; i &lt; r=
b-&gt;n_bypass; ++i)</span><br><span>@@ -972,7 +975,7 @@</span><br><span>  =
       if (rb-&gt;bypass[i])</span><br><span>         {</span><br><span>   =
          ret =3D add_route3(rb-&gt;bypass[i], IPV4_NETMASK_HOST, gateway, =
tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
           flags | ROUTE_REF_GW, rgi, es, ctx) &amp;&amp; ret;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                             fla=
gs | ROUTE_REF_GW, rgi, es, ctx, is_multipoint) &amp;&amp; ret;</span><br><=
span>         }</span><br><span>     }</span><br><span>     return ret;</sp=
an><br><span>@@ -985,7 +988,8 @@</span><br><span>                   unsigne=
d int flags,</span><br><span>                   const struct route_gateway_=
info *rgi,</span><br><span>                   const struct env_set *es,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                  openvpn=
_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
               openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                  const bool is_multipoint)</span><br><s=
pan> {</span><br><span>     int i;</span><br><span>     for (i =3D 0; i &lt=
; rb-&gt;n_bypass; ++i)</span><br><span>@@ -999,7 +1003,8 @@</span><br><spa=
n>                        flags | ROUTE_REF_GW,</span><br><span>           =
             rgi,</span><br><span>                        es,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                       ctx);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                       ctx=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
     is_multipoint);</span><br><span>         }</span><br><span>     }</spa=
n><br><span> }</span><br><span>@@ -1007,7 +1012,7 @@</span><br><span> stati=
c bool</span><br><span> redirect_default_route_to_vpn(struct route_list *rl=
, const struct tuntap *tt,</span><br><span>                               u=
nsigned int flags, const struct env_set *es,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                              openvpn_net_ctx_t *ctx=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
            openvpn_net_ctx_t *ctx, const bool is_multipoint)</span><br><sp=
an> {</span><br><span>     const char err[] =3D &quot;NOTE: unable to redir=
ect IPv4 default gateway --&quot;;</span><br><span>     bool ret =3D true;<=
/span><br><span>@@ -1059,7 +1064,7 @@</span><br><span>                 {</s=
pan><br><span>                     ret =3D add_route3(rl-&gt;spec.remote_ho=
st, IPV4_NETMASK_HOST,</span><br><span>                                    =
  rl-&gt;rgi.gateway.addr, tt, flags | ROUTE_REF_GW,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                     &amp;r=
l-&gt;rgi, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                     &amp;rl-&gt;rgi, es, ctx, is_multipoi=
nt);</span><br><span>                     rl-&gt;iflags |=3D RL_DID_LOCAL;<=
/span><br><span>                 }</span><br><span>                 else</s=
pan><br><span>@@ -1071,7 +1076,7 @@</span><br><span> </span><br><span>     =
        /* route DHCP/DNS server traffic through original default gateway *=
/</span><br><span>             ret =3D add_bypass_routes(&amp;rl-&gt;spec.b=
ypass, rl-&gt;rgi.gateway.addr, tt, flags,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                    &amp;rl-&gt;rgi, e=
s, ctx) &amp;&amp; ret;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                    &amp;rl-&gt;rgi, es, ctx, is_multip=
oint) &amp;&amp; ret;</span><br><span> </span><br><span>             if (rl=
-&gt;flags &amp; RG_REROUTE_GW)</span><br><span>             {</span><br><s=
pan>@@ -1079,11 +1084,11 @@</span><br><span>                 {</span><br><s=
pan>                     /* add new default route (1st component) */</span>=
<br><span>                     ret =3D add_route3(0x00000000, 0x80000000, r=
l-&gt;spec.remote_endpoint,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                     tt, flags, &amp;rl-&gt;rgi, es, =
ctx) &amp;&amp; ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                     tt, flags, &amp;rl-&gt;rgi, es, ctx, =
is_multipoint) &amp;&amp; ret;</span><br><span> </span><br><span>          =
           /* add new default route (2nd component) */</span><br><span>    =
                 ret =3D add_route3(0x80000000, 0x80000000, rl-&gt;spec.rem=
ote_endpoint,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                             tt, flags, &amp;rl-&gt;rgi, es, ctx) &amp;&amp=
; ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                        tt, flags, &amp;rl-&gt;rgi, es, ctx, is_multipoint)=
 &amp;&amp; ret;</span><br><span>                 }</span><br><span>       =
          else</span><br><span>                 {</span><br><span>@@ -1092,=
12 +1097,12 @@</span><br><span>                     {</span><br><span>     =
                    /* delete default route */</span><br><span>            =
             del_route3(0, 0, rl-&gt;rgi.gateway.addr, tt,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                   fla=
gs | ROUTE_REF_GW, &amp;rl-&gt;rgi, es, ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                   flags | ROUTE_=
REF_GW, &amp;rl-&gt;rgi, es, ctx, is_multipoint);</span><br><span>         =
            }</span><br><span> </span><br><span>                     /* add=
 new default route */</span><br><span>                     ret =3D add_rout=
e3(0, 0, rl-&gt;spec.remote_endpoint, tt,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                     flags, &amp;rl-&gt=
;rgi, es, ctx) &amp;&amp; ret;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                     flags, &amp;rl-&gt;rgi, es,=
 ctx, is_multipoint) &amp;&amp; ret;</span><br><span>                 }</sp=
an><br><span>             }</span><br><span> </span><br><span>@@ -1112,7 +1=
117,8 @@</span><br><span> undo_redirect_default_route_to_vpn(struct route_l=
ist *rl,</span><br><span>                                    const struct t=
untap *tt, unsigned int flags,</span><br><span>                            =
        const struct env_set *es,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                   openvpn_net_ctx_t *ctx)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
           openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                   const bool is_multipoint)=
</span><br><span> {</span><br><span>     if (rl &amp;&amp; rl-&gt;iflags &a=
mp; RL_DID_REDIRECT_DEFAULT_GATEWAY)</span><br><span>     {</span><br><span=
>@@ -1126,13 +1132,14 @@</span><br><span>                        flags | RO=
UTE_REF_GW,</span><br><span>                        &amp;rl-&gt;rgi,</span>=
<br><span>                        es,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                       ctx);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                       ctx,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       is_multipoint);</s=
pan><br><span>             rl-&gt;iflags &amp;=3D ~RL_DID_LOCAL;</span><br>=
<span>         }</span><br><span> </span><br><span>         /* delete speci=
al DHCP/DNS bypass route */</span><br><span>         del_bypass_routes(&amp=
;rl-&gt;spec.bypass, rl-&gt;rgi.gateway.addr, tt, flags,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                          &amp;rl-&gt;rg=
i, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                   &amp;rl-&gt;rgi, es, ctx, is_multipoint);</span><br><spa=
n> </span><br><span>         if (rl-&gt;flags &amp; RG_REROUTE_GW)</span><b=
r><span>         {</span><br><span>@@ -1146,7 +1153,8 @@</span><br><span>  =
                          flags,</span><br><span>                          =
  &amp;rl-&gt;rgi,</span><br><span>                            es,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                           ctx=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
          ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                      is_multipoint);</span><br><span> </span><br><span>   =
              /* delete default route (2nd component) */</span><br><span>  =
               del_route3(0x80000000,</span><br><span>@@ -1156,7 +1164,8 @@=
</span><br><span>                            flags,</span><br><span>       =
                     &amp;rl-&gt;rgi,</span><br><span>                     =
       es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                           ctx,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                           is_multipoint);</span><br><span>  =
           }</span><br><span>             else</span><br><span>            =
 {</span><br><span>@@ -1168,12 +1177,13 @@</span><br><span>                =
            flags,</span><br><span>                            &amp;rl-&gt;=
rgi,</span><br><span>                            es,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                           ctx);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                           ctx=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
         is_multipoint);</span><br><span>                 /* restore origin=
al default route if there was any */</span><br><span>                 if (r=
l-&gt;rgi.flags &amp; RGI_ADDR_DEFINED)</span><br><span>                 {<=
/span><br><span>                     add_route3(0, 0, rl-&gt;rgi.gateway.ad=
dr, tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                 flags | ROUTE_REF_GW, &amp;rl-&gt;rgi, es, ctx);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
  flags | ROUTE_REF_GW, &amp;rl-&gt;rgi, es, ctx, is_multipoint);</span><br=
><span>                 }</span><br><span>             }</span><br><span>  =
       }</span><br><span>@@ -1185,9 +1195,10 @@</span><br><span> bool</span=
><br><span> add_routes(struct route_list *rl, struct route_ipv6_list *rl6,<=
/span><br><span>            const struct tuntap *tt, unsigned int flags,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-           const struct =
env_set *es, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+           const struct env_set *es, openvpn_net_ctx_t *ct=
x,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           const =
bool is_multipoint)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    bool ret =3D redirect_default_route_to_vpn(rl, tt, fla=
gs, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bo=
ol ret =3D redirect_default_route_to_vpn(rl, tt, flags, es, ctx, is_multipo=
int);</span><br><span>     if (rl &amp;&amp; !(rl-&gt;iflags &amp; RL_ROUTE=
S_ADDED) )</span><br><span>     {</span><br><span>         struct route_ipv=
4 *r;</span><br><span>@@ -1218,9 +1229,9 @@</span><br><span>             ch=
eck_subnet_conflict(r-&gt;network, r-&gt;netmask, &quot;route&quot;);</span=
><br><span>             if (flags &amp; ROUTE_DELETE_FIRST)</span><br><span=
>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          delete_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                delete_route(r,=
 tt, flags, &amp;rl-&gt;rgi, es, ctx, is_multipoint);</span><br><span>     =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
ret =3D add_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx) &amp;&amp; ret;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =3D a=
dd_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx, is_multipoint) &amp;&amp; =
ret;</span><br><span>         }</span><br><span>         rl-&gt;iflags |=3D=
 RL_ROUTES_ADDED;</span><br><span>     }</span><br><span>@@ -1240,9 +1251,9=
 @@</span><br><span>         {</span><br><span>             if (flags &amp;=
 ROUTE_DELETE_FIRST)</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                delete_route_ipv6(r, tt, fl=
ags, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           delete_route_ipv6(r, tt, flags, es, ctx, is_multipoint);</span><=
br><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            ret =3D add_route_ipv6(r, tt, flags, es, ctx) &amp;&amp; ret;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =3D=
 add_route_ipv6(r, tt, flags, es, ctx, is_multipoint) &amp;&amp; ret;</span=
><br><span>         }</span><br><span>         rl6-&gt;iflags |=3D RL_ROUTE=
S_ADDED;</span><br><span>     }</span><br><span>@@ -1253,19 +1264,20 @@</sp=
an><br><span> void</span><br><span> delete_routes(struct route_list *rl, st=
ruct route_ipv6_list *rl6,</span><br><span>               const struct tunt=
ap *tt, unsigned int flags,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-              const struct env_set *es, openvpn_net_ctx_t *ctx)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+              const struc=
t env_set *es, openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+              const bool is_multipoint)</span><br><span>=
 {</span><br><span>     if (rl &amp;&amp; rl-&gt;iflags &amp; RL_ROUTES_ADD=
ED)</span><br><span>     {</span><br><span>         struct route_ipv4 *r;</=
span><br><span>         for (r =3D rl-&gt;routes; r; r =3D r-&gt;next)</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            delete_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            delete_route(r, =
tt, flags, &amp;rl-&gt;rgi, es, ctx, is_multipoint);</span><br><span>      =
   }</span><br><span>         rl-&gt;iflags &amp;=3D ~RL_ROUTES_ADDED;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    undo_redirect_default_route_to_vpn(rl, tt, flags, es, ct=
x);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    undo_redirec=
t_default_route_to_vpn(rl, tt, flags, es, ctx, is_multipoint);</span><br><s=
pan> </span><br><span>     if (rl)</span><br><span>     {</span><br><span>@=
@ -1277,7 +1289,7 @@</span><br><span>         struct route_ipv6 *r6;</span>=
<br><span>         for (r6 =3D rl6-&gt;routes_ipv6; r6; r6 =3D r6-&gt;next)=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            delete_route_ipv6(r6, tt, flags, es, ctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            delete_route_ipv6(r6, =
tt, flags, es, ctx, is_multipoint);</span><br><span>         }</span><br><s=
pan>         rl6-&gt;iflags &amp;=3D ~RL_ROUTES_ADDED;</span><br><span>    =
 }</span><br><span>@@ -1561,13 +1573,47 @@</span><br><span> }</span><br><sp=
an> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+is_gateway_needed_ipv4(const struct route_ipv4 *r4,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       const struct route=
_gateway_info *rgi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                       const struct tuntap *tt,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                       const bool is_multipoint=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEFINED) &amp;&amp; rgi-&=
gt;iface[0] !=3D 0)  /* vpn server special route */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (rgi-&gt;flags &amp; RGI_ADDR_DEFINED &amp;&=
amp; r4-&gt;gateway !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        &amp;&amp; !( (r4-&gt;flags &amp; RT_METRIC_=
DEFINED) &amp;&amp; r4-&gt;metric =3D=3D 0 ) )</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_multipoi=
nt &amp;&amp; !tt-&gt;options.disable_dco)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> a=
dd_route(struct route_ipv4 *r,</span><br><span>           const struct tunt=
ap *tt,</span><br><span>           unsigned int flags,</span><br><span>    =
       const struct route_gateway_info *rgi,  /* may be NULL */</span><br><=
span>           const struct env_set *es,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-          openvpn_net_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          openvpn_net_ctx_t *ctx,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+          const bool is_mul=
tipoint)</span><br><span> {</span><br><span>     int status =3D 0;</span><b=
r><span>     int is_local_route;</span><br><span>@@ -1581,18 +1627,6 @@</sp=
an><br><span>     struct argv argv =3D argv_new();</span><br><span>     str=
uct gc_arena gc =3D gc_new();</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *iface =3D tt-&gt;actual_nam=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (rgi &amp;&a=
mp; rgi-&gt;iface[0] !=3D &#39;\0&#39;)  /* vpn server special route */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        iface =3D rgi-&gt;iface;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (r-&gt;gateway !=3D=
 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            gateway_needed =3D=
 true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>     const char *network =3D print_in_add=
r_t(r-&gt;network, 0, &amp;gc);</span><br><span> #if !defined(TARGET_LINUX)=
</span><br><span> #if !defined(TARGET_AIX)</span><br><span>@@ -1607,10 +164=
1,7 @@</span><br><span>         goto done;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&g=
t;type =3D=3D DEV_TYPE_TAP &amp;&amp; !(r-&gt;flags &amp; RT_METRIC_DEFINED=
 &amp;&amp; r-&gt;metric =3D=3D 0))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      gateway_needed =3D true;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
ateway_needed =3D is_gateway_needed_ipv4(r, rgi, tt, is_multipoint);</span>=
<br><span> </span><br><span>     if (gateway_needed &amp;&amp; r-&gt;gatewa=
y =3D=3D 0)</span><br><span>     {</span><br><span>@@ -1622,12 +1653,21 @@<=
/span><br><span>         goto done;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(_WIN3=
2) &amp;&amp; !defined(TARGET_SOLARIS) \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &amp;&amp; !defined(TARGET_AIX)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *device =3D tt-&gt;actu=
al_name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ga=
teway_needed &amp;&amp; rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEFIN=
ED) &amp;&amp; rgi-&gt;iface[0] !=3D 0)  /* vpn server special route */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        device =3D rgi-&gt;iface;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> #if defined(TARGET_LINUX)</span>=
<br><span>     int metric =3D -1;</span><br><span> </span><br><span>     if=
 (is_on_link(is_local_route, flags, rgi))</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        iface =3D rgi-&gt;iface;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        device =3D =
rgi-&gt;iface;</span><br><span>     }</span><br><span> </span><br><span>   =
  if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span>@@ -1638,7 +1678=
,7 @@</span><br><span>     status =3D RTA_SUCCESS;</span><br><span>     int=
 ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&g=
t;netmask),</span><br><span>                                gateway_needed =
? &amp;r-&gt;gateway : NULL,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                               iface, 0, metric);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                               device,=
 0, metric);</span><br><span>     if (ret =3D=3D -EEXIST)</span><br><span> =
    {</span><br><span>         msg(D_ROUTE, &quot;NOTE: Linux route add com=
mand failed because route exists&quot;);</span><br><span>@@ -1655,7 +1695,7=
 @@</span><br><span> </span><br><span>     if (rgi)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        snprintf(out, =
sizeof(out), &quot;%s %s %s dev %s&quot;, network, netmask, gateway, rgi-&g=
t;iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sn=
printf(out, sizeof(out), &quot;%s %s %s dev %s&quot;, network, netmask, gat=
eway, device);</span><br><span>     }</span><br><span>     else</span><br><=
span>     {</span><br><span>@@ -1759,9 +1799,9 @@</span><br><span>         =
                            &quot;ERROR: Solaris route add command failed&q=
uot;);</span><br><span>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif def=
ined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&am=
p;argv, &quot;%s add&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    argv_printf(&amp;argv, &quot;%s add &quot;,</span><br><span>   =
              ROUTE_PATH);</span><br><span> </span><br><span> #if 0</span><=
br><span>@@ -1771,45 +1811,28 @@</span><br><span>     }</span><br><span> #e=
ndif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    network,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    gateway,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    netm=
ask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add on-link support f=
or FreeBSD */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;ar=
gv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D =
openvpn_execve_check(&amp;argv, es, 0,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                    &quot;ERROR: FreeBSD r=
oute add command failed&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#elif defined(TARGET_DRAGONFLY)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    argv_printf(&amp;argv, &quot;%s add&quot;,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                ROUTE_PATH);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (gateway_needed)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp=
;argv, &quot;-rtt %d&quot;, r-&gt;metric);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-net %s %s =
%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              network,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        gateway,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        netmask);</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    netw=
ork,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add on-=
link support for Dragonfly */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_pr=
intf_cat(&amp;argv, &quot;-net %s -iface %s&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        network,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        device)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>  =
   bool ret =3D openvpn_execve_check(&amp;argv, es, 0,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                    &quot;=
ERROR: DragonFly route add command failed&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                    &quot;ERR=
OR: BSD route add command failed&quot;);</span><br><span>     status =3D re=
t ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span> #elif defin=
ed(TARGET_DARWIN)</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    argv_printf(&amp;argv, &quot;%s add&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%=
s add &quot;,</span><br><span>                 ROUTE_PATH);</span><br><span=
> </span><br><span> #if 0</span><br><span>@@ -1830,10 +1853,19 @@</span><br=
><span>     }</span><br><span>     else</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv,=
 &quot;-net %s %s %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                        network,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                        gateway,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        netmask);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (gateway_needed)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            argv_printf_cat(&amp;ar=
gv, &quot;-net %s %s %s&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                            network,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                            gateway,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                            ne=
tmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            argv_printf_cat(&amp;argv, =
&quot;-net %s -interface %s&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                            network,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            device);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n>     }</span><br><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv=
);</span><br><span>@@ -1843,7 +1875,7 @@</span><br><span> </span><br><span>=
 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;a=
rgv, &quot;%s add&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    argv_printf(&amp;argv, &quot;%s add &quot;,</span><br><span>      =
           ROUTE_PATH);</span><br><span> </span><br><span> #if 0</span><br>=
<span>@@ -1853,12 +1885,20 @@</span><br><span>     }</span><br><span> #endi=
f</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  argv_printf_cat(&amp;argv, &quot;-net %s %s -netmask %s&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    network,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    gatew=
ay,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add on-link sup=
port for OpenBSD/NetBSD */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (gateway_needed)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     argv_printf_cat(&amp;argv, &quot;-net %s %s -netmask %s&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        net=
work,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       netmask);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&a=
mp;argv, &quot;-net %s -netmask %s -link -iface %s&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        network,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
netmask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             device);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv)=
;</span><br><span>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0,<=
/span><br><span>@@ -1923,10 +1963,98 @@</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static inline struct in6_addr</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+netbits_to_netmask_ipv6(const int netbits)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct in6_addr netmask =3D {{{0}}};</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (netbits &gt; 0 &amp;&amp; netbits &lt;=3D 128=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        const int full_bytes =3D=
 netbits / 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for=
 (i =3D 0; i &lt; full_bytes; i++)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            netmask.s6_addr[i] =3D 0xFF;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (netbits % 8)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            netmask.s6_addr[i] =3D (0xFF &lt;&lt; (8 - (netbits =
% 8)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return netmask;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+is_gateway_in_vpn_subnet_=
ipv6(const struct in6_addr *gateway,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                              const struct in6_addr *vpn_s=
ubnet,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                 int netbits)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct in6_addr netmask =3D netbits_to_netmask_ipv6(netbits);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (int i =3D 0; i &lt; 16; i++)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if ((gateway-&gt;s6_addr[i] &amp; netmask.s6=
_addr[i]) !=3D (vpn_subnet-&gt;s6_addr[i] &amp; netmask.s6_addr[i]))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+is_gateway_needed_ipv6(cons=
t struct route_ipv6 *r6,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                       const struct tuntap *tt,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       const char *networ=
k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
      const bool is_multipoint)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (r6-&gt;iface !=3D NULL=
)   /* VPN server special route */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!IN6_IS_ADDR_UNSPECIFIED(&amp;r6-&gt;gateway))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * Filter out routes which are=
 essentially no-ops</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * (not currently done for IPv6)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* On &quo=
t;tun&quot; interface, we never set a gateway if the operating system</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * can do &quot;route=
 to interface&quot; - it does not add value, as the target</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * dev already fully qualifies t=
he route destination on point-to-point</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * interfaces.   OTOH, on &quot;tap&quot; interface,=
 we must always set the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * gateway unless the route is to be an on-link network</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;type =3D=3D DEV_TYPE_TAP</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !(=
 (r6-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp; r6-&gt;metric =3D=3D 0 )=
 )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* if is server and dco enabled, the gateway is needed*/</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_multipoint =
&amp;&amp; !tt-&gt;options.disable_dco)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_gateway_in_vpn_=
subnet_ipv6(&amp;r6-&gt;gateway, &amp;tt-&gt;local_ipv6, tt-&gt;netbits_ipv=
6))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_ROUTE, &quot;Ign=
oring gateway in VPN subnet for route %s/%d&quot;, network, r6-&gt;netbits)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> bool</span><br><span> add_route_ipv6(struct route_i=
pv6 *r6, const struct tuntap *tt,</span><br><span>                unsigned =
int flags, const struct env_set *es,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-               openvpn_net_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+               openvpn_net_ctx_t *ctx, co=
nst bool is_multipoint)</span><br><span> {</span><br><span>     int status =
=3D 0;</span><br><span>     bool gateway_needed =3D false;</span><br><span>=
@@ -1939,22 +2067,12 @@</span><br><span>     struct argv argv =3D argv_new(=
);</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef _WIN32</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *device =3D tt=
-&gt;actual_name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (r6-&gt;iface !=3D NULL)              /* vpn server special route */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        device =3D r6-&gt;iface;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (!IN6_IS_ADDR_UNSPE=
CIFIED(&amp;r6-&gt;gateway) )</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        gateway_needed =3D true;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     route_ipv6=
_clear_host_bits(r6);</span><br><span>     const char *network =3D print_in=
6_addr( r6-&gt;network, 0, &amp;gc);</span><br><span>     const char *gatew=
ay =3D print_in6_addr( r6-&gt;gateway, 0, &amp;gc);</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gateway_needed =3D is=
_gateway_needed_ipv6(r6, tt, network, is_multipoint);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(TARGET_DARW=
IN)    \</span><br><span>     || defined(TARGET_FREEBSD) || defined(TARGET_=
DRAGONFLY)    \</span><br><span>     || defined(TARGET_OPENBSD) || defined(=
TARGET_NETBSD)</span><br><span>@@ -1973,6 +2091,16 @@</span><br><span>     =
}</span><br><span> #endif</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if !defined(_WIN32) &amp;&amp; !defined(TARGET_SOL=
ARIS) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &amp;&am=
p; !defined(TARGET_AIX)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*device =3D tt-&gt;actual_name;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (r6-&gt;iface !=3D NULL)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        device =3D r6-&gt;iface;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> #ifndef _WIN32</span><br><span>     msg(D_ROUTE, &quot;add_ro=
ute_ipv6(%s/%d -&gt; %s metric %d) dev %s&quot;,</span><br><span>         n=
etwork, r6-&gt;netbits, gateway, r6-&gt;metric, device );</span><br><span>@=
@ -1982,23 +2110,6 @@</span><br><span>         r6-&gt;adapter_index ? r6-&g=
t;adapter_index : tt-&gt;adapter_index);</span><br><span> #endif</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-     * Filter out routes whic=
h are essentially no-ops</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * (not currently done for IPv6)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* On &quot;t=
un&quot; interface, we never set a gateway if the operating system</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     * can do &quot;route to i=
nterface&quot; - it does not add value, as the target</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * dev already fully qualifies the rout=
e destination on point-to-point</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-     * interfaces.   OTOH, on &quot;tap&quot; interface, we must =
always set the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
gateway unless the route is to be an on-link network</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !( (r6-&gt;flags &am=
p; RT_METRIC_DEFINED) &amp;&amp; r6-&gt;metric =3D=3D 0 ) )</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        gateway_needed =3D true;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>     if (gateway_needed &amp;&amp; IN6_IS=
_ADDR_UNSPECIFIED(&amp;r6-&gt;gateway))</span><br><span>     {</span><br><s=
pan>         msg(M_WARN, &quot;ROUTE6 WARNING: &quot; PACKAGE_NAME &quot; n=
eeds a gateway &quot;</span><br><span>@@ -2011,6 +2122,7 @@</span><br><span=
> </span><br><span> #if defined(TARGET_LINUX)</span><br><span>     int metr=
ic =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     if ((r6-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp; (r6-&gt;=
metric &gt; 0))</span><br><span>     {</span><br><span>         metric =3D =
r6-&gt;metric;</span><br><span>@@ -2080,7 +2192,7 @@</span><br><span> </spa=
n><br><span> #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    arg=
v_printf(&amp;argv, &quot;%s add -inet6 %s/%d&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s add -=
inet6 %s/%d &quot;,</span><br><span>                 ROUTE_PATH,</span><br>=
<span>                 network,</span><br><span>                 r6-&gt;net=
bits);</span><br><span>@@ -2101,7 +2213,7 @@</span><br><span> </span><br><s=
pan> #elif defined(TARGET_DARWIN)</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s add -in=
et6 %s -prefixlen %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    argv_printf(&amp;argv, &quot;%s add -inet6 %s -prefixlen %d &qu=
ot;,</span><br><span>                 ROUTE_PATH,</span><br><span>         =
        network, r6-&gt;netbits );</span><br><span> </span><br><span>@@ -21=
19,26 +2231,27 @@</span><br><span>                                     &quo=
t;ERROR: MacOS X route add -inet6 command failed&quot;);</span><br><span>  =
   status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_OPENBSD)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_OPE=
NBSD) || defined(TARGET_NETBSD)</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s add -inet6 =
%s -prefixlen %d %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    argv_printf(&amp;argv, &quot;%s add -inet6 %s -prefixlen %d &quo=
t;,</span><br><span>                 ROUTE_PATH,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                network, r6-&gt;netbits, gateway=
 );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
network, r6-&gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (gatew=
ay_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat=
(&amp;argv, &quot;%s&quot;, gateway);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_c=
at(&amp;argv, &quot;-link -iface %s&quot;, device);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* FIX ME: in NetBSD in TUN mode, the route is alre=
ady added by ifconfig</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * so add_route_ipv6 fail with &#39;Invalid argument&#39; or &#39;Fil=
e exists&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
/</span><br><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);</spa=
n><br><span>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
        &quot;ERROR: OpenBSD route add -inet6 command failed&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D ret ? RTA_SUC=
CESS : RTA_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_NETB=
SD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s add=
 -inet6 %s/%d %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                ROUTE_PATH,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                network, r6-&gt;netbits, gateway );</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    bool ret =3D openvpn_execve_check(&amp;arg=
v, es, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                        &quot;ERROR: NetBSD route add -inet6 command failed=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                         &quot;ERROR: OpenBSD/NetBSD route add -inet6 comma=
nd failed&quot;);</span><br><span>     status =3D ret ? RTA_SUCCESS : RTA_E=
RROR;</span><br><span> </span><br><span> #elif defined(TARGET_AIX)</span><b=
r><span>@@ -2178,7 +2291,8 @@</span><br><span>              unsigned int fl=
ags,</span><br><span>              const struct route_gateway_info *rgi,</s=
pan><br><span>              const struct env_set *es,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             openvpn_net_ctx_t *ctx)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+             openvpn_net_c=
tx_t *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
    const bool is_multipoint)</span><br><span> {</span><br><span> #if !defi=
ned(TARGET_LINUX)</span><br><span>     const char *network;</span><br><span=
>@@ -2193,6 +2307,21 @@</span><br><span> #endif</span><br><span>     int is=
_local_route;</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(TARGET_DARWIN) || defined(TARGET_LINUX)  \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    || defined(TARGET_FREEBS=
D) || defined(TARGET_DRAGONFLY)    \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    bool gateway_needed =3D is_gateway_n=
eeded_ipv4(r, rgi, tt, is_multipoint);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if !defined(TARGET_OPENBSD) &amp;&amp; !defined(TARGET_NETBSD)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *device =3D tt-&=
gt;actual_name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!gateway_needed &amp;&amp; rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFAC=
E_DEFINED) &amp;&amp; rgi-&gt;iface[0] !=3D 0)  /* vpn server special route=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        device =3D rgi-&gt;ifa=
ce;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     if ((r-&gt;flags &amp; (RT_DEFIN=
ED|RT_ADDED)) !=3D (RT_DEFINED|RT_ADDED))</span><br><span>     {</span><br>=
<span>         return;</span><br><span>@@ -2219,13 +2348,20 @@</span><br><s=
pan> </span><br><span> #if defined(TARGET_LINUX)</span><br><span>     metri=
c =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_on_link(is_local_r=
oute, flags, rgi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        device =
=3D rgi-&gt;iface;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span>     {</spa=
n><br><span>         metric =3D r-&gt;metric;</span><br><span>     }</span>=
<br><span> </span><br><span>     if (net_route_v4_del(ctx, &amp;r-&gt;netwo=
rk, netmask_to_netbits2(r-&gt;netmask),</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                         &amp;r-&gt;gateway, NULL, 0, met=
ric) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                  gateway_needed ? &amp;r-&gt;gateway : NULL,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                         device, =
0, metric) &lt; 0)</span><br><span>     {</span><br><span>         msg(M_WA=
RN, &quot;ERROR: Linux route delete command failed&quot;);</span><br><span>=
     }</span><br><span>@@ -2284,27 +2420,30 @@</span><br><span>     argv_ms=
g(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_check(&amp;argv,=
 es, 0, &quot;ERROR: Solaris route delete command failed&quot;);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(=
TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#eli=
f defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;arg=
v, &quot;%s delete -net %s %s %s&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s delete&quot;,</span=
><br><span>                 ROUTE_PATH,</span><br><span>                 ne=
twork,</span><br><span>                 gateway,</span><br><span>          =
       netmask);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot;E=
RROR: FreeBSD route delete command failed&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#elif defined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
argv_printf(&amp;argv, &quot;%s delete -net %s %s %s&quot;,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                ROUTE_PATH,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                network,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                gateway,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                netmask);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (gateway_nee=
ded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;=
argv, &quot;-net %s %s %s&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        network,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                        gateway,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        netmask);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-net %s -iface %s&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      device);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span> </span><br><span>     argv_msg(D_ROUTE, &=
amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn=
_execve_check(&amp;argv, es, 0, &quot;ERROR: DragonFly route delete command=
 failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: BSD route delete comman=
d failed&quot;);</span><br><span> </span><br><span> #elif defined(TARGET_DA=
RWIN)</span><br><span> </span><br><span>@@ -2318,11 +2457,22 @@</span><br><=
span>     }</span><br><span>     else</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot=
;%s delete -net %s %s %s&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    ROUTE_PATH,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    network,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    gateway,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    netmask);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, =
&quot;%s delete &quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    ROUTE_PATH);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (gateway_needed)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                            netwo=
rk,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
            gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                            netmask);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    argv_printf_cat(&amp;argv, &quot;-net %s -interface %s&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                            n=
etwork,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                device);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span>     }</span><br><span> </span><br><span>   =
  argv_msg(D_ROUTE, &amp;argv);</span><br><span>@@ -2330,11 +2480,22 @@</sp=
an><br><span> </span><br><span> #elif defined(TARGET_OPENBSD) || defined(TA=
RGET_NETBSD)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    argv_printf(&amp;argv, &quot;%s delete -net %s %s -netmask %s&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 ROUTE_PATH,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       network,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    argv_printf(&amp;argv, &quot;%s delete &quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ROUTE_PATH);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (gateway_needed)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-net %s %s -netmask =
%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              network,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        gateway,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        netmask);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
rgv_printf_cat(&amp;argv, &quot;-net %s -netmask %s&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        network,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br=
><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: OpenBSD/Net=
BSD route delete command failed&quot;);</span><br><span>@@ -2369,7 +2530,7 =
@@</span><br><span> void</span><br><span> delete_route_ipv6(const struct ro=
ute_ipv6 *r6, const struct tuntap *tt,</span><br><span>                   u=
nsigned int flags, const struct env_set *es,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                  openvpn_net_ctx_t *ctx)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                  openvpn_net_=
ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><span>  =
   const char *network;</span><br><span> </span><br><span>@@ -2382,23 +2543=
,15 @@</span><br><span> #if !defined(TARGET_LINUX)</span><br><span>     con=
st char *gateway;</span><br><span> #endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if !defined(TARGET_SOLARIS)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    bool gateway_needed =3D false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_DARWIN) || def=
ined(TARGET_LINUX)  \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     const char =
*device =3D tt-&gt;actual_name;</span><br><span>     if (r6-&gt;iface !=3D =
NULL)              /* vpn server special route */</span><br><span>     {</s=
pan><br><span>         device =3D r6-&gt;iface;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        gateway_needed =3D true;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* if we used a gateway on &quot;add route&quot;, we also need to sp=
ecify it on</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * del=
ete, otherwise some OSes will refuse to delete the route</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !( (r6-&gt;flags =
&amp; RT_METRIC_DEFINED) &amp;&amp; r6-&gt;metric =3D=3D 0 ) )</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        gateway_needed =3D true;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> #endif</span><br=
><span> #endif</span><br><span> </span><br><span>@@ -2410,6 +2563,16 @@</sp=
an><br><span>     gateway =3D print_in6_addr( r6-&gt;gateway, 0, &amp;gc);<=
/span><br><span> #endif</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(TARGET_DARWIN) || defined(TARGET_LINUX)  =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    || defined(TAR=
GET_FREEBSD) || defined(TARGET_DRAGONFLY)    \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    || defined(TARGET_OPENBSD) || defined(TARGET=
_NETBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if w=
e used a gateway on &quot;add route&quot;, we also need to specify it on</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * delete, otherwi=
se some OSes will refuse to delete the route</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool gateway_needed =3D false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gateway_needed =3D is_gateway_needed_ipv6(r=
6, tt, network, is_multipoint);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> #if defined(TARGET_DARWIN)    \</span><br><span>     || de=
fined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \</span><br><span>   =
  || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span>@@ -=
2504,23 +2667,19 @@</span><br><span>     argv_msg(D_ROUTE, &amp;argv);</spa=
n><br><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: MacOS =
X route delete -inet6 command failed&quot;);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_OPENBSD)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_OPE=
NBSD) || defined(TARGET_NETBSD)</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delete -ine=
t6 %s -prefixlen %d %s&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    argv_printf(&amp;argv, &quot;%s delete -inet6 %s -prefixlen %=
d&quot;,</span><br><span>                 ROUTE_PATH,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                network, r6-&gt;netbits, ga=
teway );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     network, r6-&gt;netbits);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
gateway_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_print=
f_cat(&amp;argv, &quot;%s&quot;, gateway);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     argv_ms=
g(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: OpenBSD route dele=
te -inet6 command failed&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defi=
ned(TARGET_NETBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;arg=
v, &quot;%s delete -inet6 %s/%d %s&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                ROUTE_PATH,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                network, r6-&gt;netbits, gateway =
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&am=
p;argv, es, 0, &quot;ERROR: NetBSD route delete -inet6 command failed&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_execv=
e_check(&amp;argv, es, 0, &quot;ERROR: OpenBSD/NetBSD route delete -inet6 c=
ommand failed&quot;);</span><br><span> </span><br><span> #elif defined(TARG=
ET_AIX)</span><br><span> </span><br><span>diff --git a/src/openvpn/route.h =
b/src/openvpn/route.h</span><br><span>index 421e7d2..4c3f317 100644</span><=
br><span>--- a/src/openvpn/route.h</span><br><span>+++ b/src/openvpn/route.=
h</span><br><span>@@ -271,13 +271,13 @@</span><br><span> </span><br><span> =
void route_ipv6_clear_host_bits( struct route_ipv6 *r6 );</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool add_route_ipv6(s=
truct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const str=
uct env_set *es, openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool add_route_ipv6(struct route_ipv6 *r, const struc=
t tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx=
_t *ctx, const bool is_multipoint);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void delete_route_ipv6(const struct route_i=
pv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *=
es, openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void delete_route_ipv6(const struct route_ipv6 *r, const struct tu=
ntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *=
ctx, const bool is_multipoint);</span><br><span> </span><br><span> bool add=
_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,</=
span><br><span>                const struct route_gateway_info *rgi, const =
struct env_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
             openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+               openvpn_net_ctx_t *ctx, const bool is_mult=
ipoint);</span><br><span> </span><br><span> void add_route_to_option_list(s=
truct route_option_list *l,</span><br><span>                               =
const char *network,</span><br><span>@@ -312,14 +312,16 @@</span><br><span>=
 </span><br><span> bool add_routes(struct route_list *rl, struct route_ipv6=
_list *rl6,</span><br><span>                 const struct tuntap *tt, unsig=
ned int flags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         const struct env_set *es, openvpn_net_ctx_t *ctx);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                const struct env_se=
t *es, openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                const bool is_multipoint);</span><br><span> </sp=
an><br><span> void delete_routes(struct route_list *rl,</span><br><span>   =
                 struct route_ipv6_list *rl6,</span><br><span>             =
       const struct tuntap *tt,</span><br><span>                    unsigne=
d int flags,</span><br><span>                    const struct env_set *es,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   ope=
nvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   openvpn_net_ctx_t *ctx,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                   const bool is_multipoint);</spa=
n><br><span> </span><br><span> void setenv_routes(struct env_set *es, const=
 struct route_list *rl);</span><br><span> </span><br><span>diff --git a/src=
/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index ce3d882..d878161 1=
00644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/ope=
nvpn/tun.c</span><br><span>@@ -1020,7 +1020,7 @@</span><br><span>  */</span=
><br><span> static void</span><br><span> add_route_connected_v6_net(struct =
tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                 const struct env_set *es)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                           const struct env_set *es,=
 const bool is_multipoint)</span><br><span> {</span><br><span>     struct r=
oute_ipv6 r6;</span><br><span> </span><br><span>@@ -1030,11 +1030,11 @@</sp=
an><br><span>     r6.gateway =3D tt-&gt;local_ipv6;</span><br><span>     r6=
.metric  =3D 0;                     /* connected route */</span><br><span> =
    r6.flags   =3D RT_DEFINED | RT_METRIC_DEFINED;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    add_route_ipv6(&amp;r6, tt, 0, es, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_route_ipv6(&=
amp;r6, tt, 0, es, NULL, is_multipoint);</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-delete_route_connected_v6_net(const struct tuntap *tt)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+delete_route_connected_v6_net(const s=
truct tuntap *tt, const bool is_multipoint)</span><br><span> {</span><br><s=
pan>     struct route_ipv6 r6;</span><br><span> </span><br><span>@@ -1045,7=
 +1045,7 @@</span><br><span>     r6.metric  =3D 0;                     /* c=
onnected route */</span><br><span>     r6.flags   =3D RT_DEFINED | RT_ADDED=
 | RT_METRIC_DEFINED;</span><br><span>     route_ipv6_clear_host_bits(&amp;=
r6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    delete_route_=
ipv6(&amp;r6, tt, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    delete_route_ipv6(&amp;r6, tt, 0, NULL, NULL, is_multipoi=
nt);</span><br><span> }</span><br><span> #endif /* if defined(_WIN32) || de=
fined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD) *=
/</span><br><span> </span><br><span>@@ -1087,7 +1087,8 @@</span><br><span> =
 */</span><br><span> static void</span><br><span> do_ifconfig_ipv6(struct t=
untap *tt, const char *ifname, int tun_mtu,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                 const struct env_set *es, openvpn_ne=
t_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
           const struct env_set *es, openvpn_net_ctx_t *ctx,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 const bool is_mul=
tipoint)</span><br><span> {</span><br><span> #if !defined(TARGET_LINUX)</sp=
an><br><span>     struct argv argv =3D argv_new();</span><br><span>@@ -1205=
,7 +1206,7 @@</span><br><span> #if defined(TARGET_OPENBSD) || defined(TARGE=
T_NETBSD) \</span><br><span>     || defined(TARGET_DARWIN)</span><br><span>=
     /* and, hooray, we explicitly need to add a route... */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    add_route_connected_v6_net(tt, e=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_route_co=
nnected_v6_net(tt, es, is_multipoint);</span><br><span> #endif</span><br><s=
pan> #elif defined(TARGET_AIX)</span><br><span>     argv_printf(&amp;argv, =
&quot;%s %s inet6 %s/%d mtu %d up&quot;, IFCONFIG_PATH, ifname,</span><br><=
span>@@ -1231,7 +1232,7 @@</span><br><span>         do_address_service(true=
, AF_INET6, tt);</span><br><span>         if (tt-&gt;type =3D=3D DEV_TYPE_T=
UN)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            add_route_connected_v6_net(tt, es);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            add_route_connected_v6_net=
(tt, es, is_multipoint);</span><br><span>         }</span><br><span>       =
  do_dns_service(true, AF_INET6, tt);</span><br><span>         do_set_mtu_s=
ervice(tt, AF_INET6, tun_mtu);</span><br><span>@@ -1259,7 +1260,7 @@</span>=
<br><span>         netsh_command(&amp;argv, 4, M_FATAL);</span><br><span>  =
       if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            add_route_conn=
ected_v6_net(tt, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            add_route_connected_v6_net(tt, es, is_multipoint);</span><br>=
<span>         }</span><br><span>         /* set ipv6 dns servers if any ar=
e specified */</span><br><span>         netsh_set_dns6_servers(tt-&gt;optio=
ns.dns6, tt-&gt;options.dns6_len, tt-&gt;adapter_index);</span><br><span>@@=
 -1291,7 +1292,7 @@</span><br><span>  */</span><br><span> static void</span=
><br><span> do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun=
_mtu,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
 const struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                 const struct env_set *es, o=
penvpn_net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><=
br><span> #if !defined(_WIN32) &amp;&amp; !defined(TARGET_ANDROID)</span><b=
r><span>     /*</span><br><span>@@ -1415,7 +1416,7 @@</span><br><span>     =
    r.netmask =3D tt-&gt;remote_netmask;</span><br><span>         r.gateway=
 =3D tt-&gt;local;</span><br><span>         r.metric =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        add_route(&amp;r, tt, 0, NULL=
, es, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 add_route(&amp;r, tt, 0, NULL, es, NULL, is_multipoint);</span><br><span> =
    }</span><br><span> </span><br><span> #elif defined(TARGET_OPENBSD)</spa=
n><br><span>@@ -1462,7 +1463,7 @@</span><br><span>         r.network =3D tt=
-&gt;local &amp; tt-&gt;remote_netmask;</span><br><span>         r.netmask =
=3D tt-&gt;remote_netmask;</span><br><span>         r.gateway =3D remote_en=
d;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        add_route(&=
amp;r, tt, 0, NULL, es, NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        add_route(&amp;r, tt, 0, NULL, es, NULL, is_multipoint);=
</span><br><span>     }</span><br><span> </span><br><span> #elif defined(TA=
RGET_NETBSD)</span><br><span>@@ -1504,7 +1505,7 @@</span><br><span>        =
 r.network =3D tt-&gt;local &amp; tt-&gt;remote_netmask;</span><br><span>  =
       r.netmask =3D tt-&gt;remote_netmask;</span><br><span>         r.gate=
way =3D remote_end;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      add_route(&amp;r, tt, 0, NULL, es, NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        add_route(&amp;r, tt, 0, NULL, es, NULL=
, is_multipoint);</span><br><span>     }</span><br><span> </span><br><span>=
 #elif defined(TARGET_DARWIN)</span><br><span>@@ -1554,7 +1555,7 @@</span><=
br><span>         r.network =3D tt-&gt;local &amp; tt-&gt;remote_netmask;</=
span><br><span>         r.netmask =3D tt-&gt;remote_netmask;</span><br><spa=
n>         r.gateway =3D tt-&gt;local;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        add_route(&amp;r, tt, 0, NULL, es, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        add_route(&amp;r, tt=
, 0, NULL, es, NULL, is_multipoint);</span><br><span>     }</span><br><span=
> </span><br><span> #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONF=
LY)</span><br><span>@@ -1648,7 +1649,7 @@</span><br><span> /* execute the i=
fconfig command through the shell */</span><br><span> void</span><br><span>=
 do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            const struct env_set=
 *es, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            const struct env_set *es, openvpn_net_ctx_t *ctx, con=
st bool is_multipoint)</span><br><span> {</span><br><span>     msg(D_LOW, &=
quot;do_ifconfig, ipv4=3D%d, ipv6=3D%d&quot;, tt-&gt;did_ifconfig_setup,</s=
pan><br><span>         tt-&gt;did_ifconfig_ipv6_setup);</span><br><span>@@ =
-1668,12 +1669,12 @@</span><br><span> </span><br><span>     if (tt-&gt;did_=
ifconfig_setup)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        do_ifconfig_ipv4(tt, ifname, tun_mtu, es, ctx);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        do_ifconfig_ip=
v4(tt, ifname, tun_mtu, es, ctx, is_multipoint);</span><br><span>     }</sp=
an><br><span> </span><br><span>     if (tt-&gt;did_ifconfig_ipv6_setup)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      do_ifconfig_ipv6(tt, ifname, tun_mtu, es, ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        do_ifconfig_ipv6(tt, ifname, tun_=
mtu, es, ctx, is_multipoint);</span><br><span>     }</span><br><span> </spa=
n><br><span>     /* release resources potentially allocated during interfac=
e setup */</span><br><span>@@ -2138,12 +2139,13 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, =
openvpn_net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span>=
<br><span>     ASSERT(tt);</span><br><span> </span><br><span>     close_tun=
_generic(tt);</span><br><span>     free(tt);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    (void)is_multipoint;</span><br><span> }</span>=
<br><span> </span><br><span> int</span><br><span>@@ -2307,7 +2309,8 @@</spa=
n><br><span> void</span><br><span> tuncfg(const char *dev, const char *dev_=
type, const char *dev_node,</span><br><span>        int persist_mode, const=
 char *username, const char *groupname,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-       const struct tuntap_options *options, openvpn_net_=
ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       c=
onst struct tuntap_options *options, openvpn_net_ctx_t *ctx,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+       const bool is_multipoint)</=
span><br><span> {</span><br><span>     struct tuntap *tt;</span><br><span> =
</span><br><span>@@ -2347,14 +2350,14 @@</span><br><span>             msg(M=
_ERR, &quot;Cannot ioctl TUNSETGROUP(%s) %s&quot;, groupname, dev);</span><=
br><span>         }</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    close_tun(tt, ctx);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    close_tun(tt, ctx, is_multipoint);</span><br><=
span>     msg(M_INFO, &quot;Persist state set to: %s&quot;, (persist_mode ?=
 &quot;ON&quot; : &quot;OFF&quot;));</span><br><span> }</span><br><span> </=
span><br><span> #endif /* ENABLE_FEATURE_TUN_PERSIST */</span><br><span> </=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-c=
lose_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, openvpn_net_=
ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><span>  =
   ASSERT(tt);</span><br><span> </span><br><span>@@ -2366,6 +2369,7 @@</spa=
n><br><span> #endif</span><br><span>     close_tun_generic(tt);</span><br><=
span>     free(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    (void)is_multipoint;</span><br><span> }</span><br><span> </span><br><sp=
an> int</span><br><span>@@ -2677,7 +2681,7 @@</span><br><span>  * Close TUN=
 device.</span><br><span>  */</span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-close_tun(struct tuntap *tt, openvpn_net_ct=
x_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+close_tun(=
struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipoint)</span>=
<br><span> {</span><br><span>     ASSERT(tt);</span><br><span> </span><br><=
span>@@ -2687,6 +2691,7 @@</span><br><span> </span><br><span>     clear_tun=
tap(tt);</span><br><span>     free(tt);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    (void)is_multipoint;</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span>@@ -2710,7 +2715,7 @@</=
span><br><span> </span><br><span>     argv_msg(M_INFO, &amp;argv);</span><b=
r><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;Solaris ifconfig =
unplumb failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    close_tun(tt, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    close_tun(tt, NULL, false);</span><br><span>     msg(M_FATAL, &qu=
ot;Solaris ifconfig failed&quot;);</span><br><span>     argv_free(&amp;argv=
);</span><br><span> }</span><br><span>@@ -2774,10 +2779,12 @@</span><br><sp=
an>  */</span><br><span> </span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *c=
tx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct=
 tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipoint)</span><br><s=
pan> {</span><br><span>     ASSERT(tt);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    (void)is_multipoint;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* only *T=
AP* devices need destroying, tun devices auto-self-destruct</span><br><span=
>      */</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN || tt-&g=
t;persistent_if)</span><br><span>@@ -2888,10 +2895,12 @@</span><br><span>  =
* need to be explicitly destroyed</span><br><span>  */</span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-close_tun(struct tun=
tap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const boo=
l is_multipoint)</span><br><span> {</span><br><span>     ASSERT(tt);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (voi=
d)is_multipoint;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     /* only tun devices need destroying, tap devices auto-se=
lf-destruct</span><br><span>      */</span><br><span>     if (tt-&gt;type !=
=3D DEV_TYPE_TUN || tt-&gt;persistent_if)</span><br><span>@@ -3044,10 +3053=
,12 @@</span><br><span>  * we need to call &quot;ifconfig ... destroy&quot;=
 for cleanup</span><br><span>  */</span><br><span> void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-close_tun(struct tuntap *tt, openvpn_net_=
ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+close_tu=
n(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipoint)</spa=
n><br><span> {</span><br><span>     ASSERT(tt);</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    (void)is_multipoint;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if=
 (tt-&gt;persistent_if)        /* keep pre-existing if around */</span><br>=
<span>     {</span><br><span>         close_tun_generic(tt);</span><br><spa=
n>@@ -3161,12 +3172,13 @@</span><br><span> }</span><br><span> </span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-close_tun(st=
ruct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, c=
onst bool is_multipoint)</span><br><span> {</span><br><span>     ASSERT(tt)=
;</span><br><span> </span><br><span>     close_tun_generic(tt);</span><br><=
span>     free(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    (void)is_multipoint;</span><br><span> }</span><br><span> </span><br><sp=
an> int</span><br><span>@@ -3428,7 +3440,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, openv=
pn_net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><=
span>     ASSERT(tt);</span><br><span> </span><br><span>@@ -3450,6 +3462,7 =
@@</span><br><span>     free(tt);</span><br><span>     argv_free(&amp;argv)=
;</span><br><span>     gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    (void)is_multipoint;</span><br><span> }</span><br>=
<span> </span><br><span> int</span><br><span>@@ -3577,7 +3590,7 @@</span><b=
r><span> /* tap devices need to be manually destroyed on AIX</span><br><spa=
n>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, openvp=
n_net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><s=
pan>     ASSERT(tt);</span><br><span> </span><br><span>@@ -3605,6 +3618,7 @=
@</span><br><span>     free(tt);</span><br><span>     env_set_destroy(es);<=
/span><br><span>     argv_free(&amp;argv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    (void)is_multipoint;</span><br><span> }</span><b=
r><span> </span><br><span> int</span><br><span>@@ -6892,7 +6906,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-netsh_delete_address_dns(const struct=
 tuntap *tt, bool ipv6, struct gc_arena *gc)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+netsh_delete_address_dns(const struct tuntap *tt, =
bool ipv6, struct gc_arena *gc, const bool is_multipoint)</span><br><span> =
{</span><br><span>     const char *ifconfig_ip_local;</span><br><span>     =
struct argv argv =3D argv_new();</span><br><span>@@ -6922,7 +6936,7 @@</spa=
n><br><span> </span><br><span>     if (ipv6 &amp;&amp; tt-&gt;type =3D=3D D=
EV_TYPE_TUN)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        delete_route_connected_v6_net(tt);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        delete_route_connected_v6_net(=
tt, is_multipoint);</span><br><span>     }</span><br><span> </span><br><spa=
n>     /* &quot;store=3Dactive&quot; is needed in Windows 8(.1) to delete t=
he</span><br><span>@@ -6992,7 +7006,7 @@</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, openvpn_ne=
t_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><span>=
     ASSERT(tt);</span><br><span> </span><br><span>@@ -7012,7 +7026,7 @@</s=
pan><br><span>                 do_dns_domain_service(false, tt);</span><br>=
<span>             }</span><br><span>             do_dns_service(false, AF_=
INET6, tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  delete_route_connected_v6_net(tt);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            delete_route_connected_v6_net(tt, is_multipoin=
t);</span><br><span>             do_address_service(false, AF_INET6, tt);</=
span><br><span>         }</span><br><span>         else</span><br><span>@@ =
-7022,7 +7036,7 @@</span><br><span>                 do_dns_domain_wmic(fals=
e, tt);</span><br><span>             }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            netsh_delete_address_dns(tt,=
 true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         netsh_delete_address_dns(tt, true, &amp;gc, is_multipoint);</span>=
<br><span>         }</span><br><span>     }</span><br><span> </span><br><sp=
an>@@ -7049,7 +7063,7 @@</span><br><span> </span><br><span>             if =
(tt-&gt;options.ip_win32_type =3D=3D IPW32_SET_NETSH)</span><br><span>     =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    netsh_delete_address_dns(tt, false, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                netsh_delete_address_dns(tt, =
false, &amp;gc, is_multipoint);</span><br><span>             }</span><br><s=
pan>         }</span><br><span>     }</span><br><span>@@ -7170,12 +7184,13 =
@@</span><br><span> }</span><br><span> </span><br><span> void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-close_tun(struct tuntap *tt, openvp=
n_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cl=
ose_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipoint=
)</span><br><span> {</span><br><span>     ASSERT(tt);</span><br><span> </sp=
an><br><span>     close_tun_generic(tt);</span><br><span>     free(tt);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)is_multipoint=
;</span><br><span> }</span><br><span> </span><br><span> int</span><br><span=
>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index 3=
3b9552..9716d19 100644</span><br><span>--- a/src/openvpn/tun.h</span><br><s=
pan>+++ b/src/openvpn/tun.h</span><br><span>@@ -266,7 +266,7 @@</span><br><=
span> void open_tun(const char *dev, const char *dev_type, const char *dev_=
node,</span><br><span>               struct tuntap *tt, openvpn_net_ctx_t *=
ctx);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void close_tun(struct tuntap *tt, =
openvpn_net_ctx_t *ctx, const bool is_multipoint);</span><br><span> </span>=
<br><span> void tun_open_device(struct tuntap *tt, const char *dev_node,</s=
pan><br><span>                      const char **device_guid, struct gc_are=
na *gc);</span><br><span>@@ -280,7 +280,7 @@</span><br><span> void tuncfg(c=
onst char *dev, const char *dev_type, const char *dev_node,</span><br><span=
>             int persist_mode, const char *username,</span><br><span>     =
        const char *groupname, const struct tuntap_options *options,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            openvpn_net_ctx_=
t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 openvpn_net_ctx_t *ctx, const bool is_multipoint);</span><br><span> </span=
><br><span> const char *guess_tuntap_dev(const char *dev,</span><br><span> =
                             const char *dev_type,</span><br><span>@@ -319,=
7 +319,7 @@</span><br><span>  * @param ctx       the networking API opaque =
context</span><br><span>  */</span><br><span> void do_ifconfig(struct tunta=
p *tt, const char *ifname, int tun_mtu,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                 const struct env_set *es, openvpn_net_ct=
x_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
        const struct env_set *es, openvpn_net_ctx_t *ctx, const bool is_mul=
tipoint);</span><br><span> </span><br><span> /**</span><br><span>  * undo_i=
fconfig - undo configuration of the tunnel interface</span><br><span>@@ -75=
4,6 +754,7 @@</span><br><span> }</span><br><span> </span><br><span> const c=
har *tun_stat(const struct tuntap *tt, unsigned int rwflags, struct gc_aren=
a *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> bool tun_name_is_fixed(const char *dev);</span><br><span> </span><br>=
<span> static inline bool</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/678?usp=3Demail">change =
678</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/678?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3dbd61fef20d683734b55b73e40=
afe56c3b733e1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 678 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--pSOeZibMVeA=--

