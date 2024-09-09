From: "mrbff (Code Review)" <gerrit@...515...>
Date: Mon, 9 Sep 2024 15:36:52 +0000
In-Reply-To: <gerrit.1722331476000.I87777e74b1fd34781e1d72c9f994eb84f39d800c@...2715...>
References: <gerrit.1722331476000.I87777e74b1fd34781e1d72c9f994eb84f39d800c@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <162186a0cbbb770c6195f78e5d9e8b79e939d8ed-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iywsJUmL9fE="; charset=UTF-8
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

--iywsJUmL9fE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail

to look at the new patch set (#5).


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
    optimizing route configuration and potentially reducing redundant route=
 entries.

Change-Id: I87777e74b1fd34781e1d72c9f994eb84f39d800c
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/route.c
M src/openvpn/route.h
M src/openvpn/tun.c
M src/openvpn/tun.h
7 files changed, 417 insertions(+), 256 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/721/5

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
index dd56961..446537a 100644
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
index 2033433..31a634a 100644
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
@@ -1595,23 +1641,7 @@
         goto done;
     }

-#ifndef _WIN32
-
-    if (rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi->iface[0] !=3D 0)  =
/* vpn server special route */
-    {
-        if (rgi->flags & RGI_ADDR_DEFINED && r->gateway !=3D 0)
-        {
-            gateway_needed =3D true;
-        }
-    }
-
-#endif
-
-    if (tt->type =3D=3D DEV_TYPE_TAP
-        && !( (r->flags & RT_METRIC_DEFINED) && r->metric =3D=3D 0 ) )
-    {
-        gateway_needed =3D true;
-    }
+    gateway_needed =3D is_gateway_needed_ipv4(r, rgi, tt, is_multipoint);

     if (gateway_needed && r->gateway =3D=3D 0)
     {
@@ -1623,11 +1653,12 @@
         goto done;
     }

-#if defined(TARGET_LINUX)
-    const char *iface =3D tt->actual_name;
+#if !defined(_WIN32) && !defined(TARGET_SOLARIS) \
+    && !defined(TARGET_AIX)
+    const char *device =3D tt->actual_name;
     if (!gateway_needed && rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi-=
>iface[0] !=3D 0)  /* vpn server special route */
     {
-        iface =3D rgi->iface;
+        device =3D rgi->iface;
     }
 #endif

@@ -1636,7 +1667,7 @@

     if (is_on_link(is_local_route, flags, rgi))
     {
-        iface =3D rgi->iface;
+        device =3D rgi->iface;
     }

     if (r->flags & RT_METRIC_DEFINED)
@@ -1647,7 +1678,7 @@
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
@@ -1664,7 +1695,7 @@

     if (rgi)
     {
-        snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, ga=
teway, rgi->iface);
+        snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, ga=
teway, device);
     }
     else
     {
@@ -1768,9 +1799,9 @@
                                     "ERROR: Solaris route add command fail=
ed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;

-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

-    argv_printf(&argv, "%s add",
+    argv_printf(&argv, "%s add ",
                 ROUTE_PATH);

 #if 0
@@ -1780,45 +1811,28 @@
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
@@ -1839,10 +1853,19 @@
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
@@ -1852,7 +1875,7 @@

 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)

-    argv_printf(&argv, "%s add",
+    argv_printf(&argv, "%s add ",
                 ROUTE_PATH);

 #if 0
@@ -1862,12 +1885,20 @@
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
@@ -1932,10 +1963,98 @@
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
@@ -1948,22 +2067,12 @@
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
@@ -1982,6 +2091,15 @@
     }
 #endif

+#if !defined(_WIN32)
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
@@ -1991,23 +2109,6 @@
         r6->adapter_index ? r6->adapter_index : tt->adapter_index);
 #endif

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
@@ -2020,6 +2121,7 @@

 #if defined(TARGET_LINUX)
     int metric =3D -1;
+
     if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
         metric =3D r6->metric;
@@ -2089,7 +2191,7 @@

 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

-    argv_printf(&argv, "%s add -inet6 %s/%d",
+    argv_printf(&argv, "%s add -inet6 %s/%d ",
                 ROUTE_PATH,
                 network,
                 r6->netbits);
@@ -2110,7 +2212,7 @@

 #elif defined(TARGET_DARWIN)

-    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d",
+    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d ",
                 ROUTE_PATH,
                 network, r6->netbits );

@@ -2128,26 +2230,24 @@
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
@@ -2187,7 +2287,8 @@
              unsigned int flags,
              const struct route_gateway_info *rgi,
              const struct env_set *es,
-             openvpn_net_ctx_t *ctx)
+             openvpn_net_ctx_t *ctx,
+             const bool is_multipoint)
 {
 #if !defined(TARGET_LINUX)
     const char *network;
@@ -2202,6 +2303,21 @@
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
@@ -2228,13 +2344,20 @@

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
@@ -2293,27 +2416,26 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route delete comman=
d failed");

-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

-    argv_printf(&argv, "%s delete -net %s %s %s",
-                ROUTE_PATH,
-                network,
-                gateway,
-                netmask);
+    argv_printf(&argv, "%s delete", ROUTE_PATH);
+
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
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: DragonFly route delete comm=
and failed");
+    openvpn_execve_check(&argv, es, 0, "ERROR: BSD route delete command fa=
iled");

 #elif defined(TARGET_DARWIN)

@@ -2327,11 +2449,22 @@
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
@@ -2339,11 +2472,22 @@

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
@@ -2378,7 +2522,7 @@
 void
 delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
                   unsigned int flags, const struct env_set *es,
-                  openvpn_net_ctx_t *ctx)
+                  openvpn_net_ctx_t *ctx, const bool is_multipoint)
 {
     const char *network;

@@ -2391,23 +2535,15 @@
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

@@ -2419,6 +2555,16 @@
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
@@ -2513,23 +2659,19 @@
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
index 739e008..28fca0e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1018,7 +1018,7 @@
  */
 static void
 add_route_connected_v6_net(struct tuntap *tt,
-                           const struct env_set *es)
+                           const struct env_set *es, const bool is_multipo=
int)
 {
     struct route_ipv6 r6;

@@ -1028,11 +1028,11 @@
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

@@ -1043,7 +1043,7 @@
     r6.metric  =3D 0;                     /* connected route */
     r6.flags   =3D RT_DEFINED | RT_ADDED | RT_METRIC_DEFINED;
     route_ipv6_clear_host_bits(&r6);
-    delete_route_ipv6(&r6, tt, 0, NULL, NULL);
+    delete_route_ipv6(&r6, tt, 0, NULL, NULL, is_multipoint);
 }
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_N=
ETBSD) || defined(TARGET_OPENBSD) */

@@ -1085,7 +1085,8 @@
  */
 static void
 do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
-                 const struct env_set *es, openvpn_net_ctx_t *ctx)
+                 const struct env_set *es, openvpn_net_ctx_t *ctx,
+                 const bool is_multipoint)
 {
 #if !defined(TARGET_LINUX)
     struct argv argv =3D argv_new();
@@ -1203,7 +1204,7 @@
 #if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
     || defined(TARGET_DARWIN)
     /* and, hooray, we explicitly need to add a route... */
-    add_route_connected_v6_net(tt, es);
+    add_route_connected_v6_net(tt, es, is_multipoint);
 #endif
 #elif defined(TARGET_AIX)
     argv_printf(&argv, "%s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, ifnam=
e,
@@ -1229,7 +1230,7 @@
         do_address_service(true, AF_INET6, tt);
         if (tt->type =3D=3D DEV_TYPE_TUN)
         {
-            add_route_connected_v6_net(tt, es);
+            add_route_connected_v6_net(tt, es, is_multipoint);
         }
         do_dns_service(true, AF_INET6, tt);
         do_set_mtu_service(tt, AF_INET6, tun_mtu);
@@ -1257,7 +1258,7 @@
         netsh_command(&argv, 4, M_FATAL);
         if (tt->type =3D=3D DEV_TYPE_TUN)
         {
-            add_route_connected_v6_net(tt, es);
+            add_route_connected_v6_net(tt, es, is_multipoint);
         }
         /* set ipv6 dns servers if any are specified */
         netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, tt-=
>adapter_index);
@@ -1289,7 +1290,7 @@
  */
 static void
 do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
-                 const struct env_set *es, openvpn_net_ctx_t *ctx)
+                 const struct env_set *es, openvpn_net_ctx_t *ctx, const b=
ool is_multipoint)
 {
 #if !defined(_WIN32) && !defined(TARGET_ANDROID)
     /*
@@ -1394,7 +1395,7 @@
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D tt->local;
         r.metric =3D 0;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_OPENBSD)
@@ -1441,7 +1442,7 @@
         r.network =3D tt->local & tt->remote_netmask;
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D remote_end;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_NETBSD)
@@ -1483,7 +1484,7 @@
         r.network =3D tt->local & tt->remote_netmask;
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D remote_end;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_DARWIN)
@@ -1530,7 +1531,7 @@
         r.network =3D tt->local & tt->remote_netmask;
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D tt->local;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
@@ -1624,7 +1625,7 @@
 /* execute the ifconfig command through the shell */
 void
 do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
-            const struct env_set *es, openvpn_net_ctx_t *ctx)
+            const struct env_set *es, openvpn_net_ctx_t *ctx, const bool i=
s_multipoint)
 {
     msg(D_LOW, "do_ifconfig, ipv4=3D%d, ipv6=3D%d", tt->did_ifconfig_setup,
         tt->did_ifconfig_ipv6_setup);
@@ -1644,12 +1645,12 @@

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
@@ -2114,12 +2115,13 @@
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
@@ -2283,7 +2285,8 @@
 void
 tuncfg(const char *dev, const char *dev_type, const char *dev_node,
        int persist_mode, const char *username, const char *groupname,
-       const struct tuntap_options *options, openvpn_net_ctx_t *ctx)
+       const struct tuntap_options *options, openvpn_net_ctx_t *ctx,
+       const bool is_multipoint)
 {
     struct tuntap *tt;

@@ -2323,14 +2326,14 @@
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

@@ -2342,6 +2345,7 @@
 #endif
     close_tun_generic(tt);
     free(tt);
+    (void)is_multipoint;
 }

 int
@@ -2653,7 +2657,7 @@
  * Close TUN device.
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -2663,6 +2667,7 @@

     clear_tuntap(tt);
     free(tt);
+    (void)is_multipoint;
 }

 static void
@@ -2686,7 +2691,7 @@

     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, 0, "Solaris ifconfig unplumb failed");
-    close_tun(tt, NULL);
+    close_tun(tt, NULL, false);
     msg(M_FATAL, "Solaris ifconfig failed");
     argv_free(&argv);
 }
@@ -2750,10 +2755,12 @@
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
@@ -2864,10 +2871,12 @@
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
@@ -3020,10 +3029,12 @@
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
@@ -3137,12 +3148,13 @@
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
@@ -3404,7 +3416,7 @@
 }

 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -3426,6 +3438,7 @@
     free(tt);
     argv_free(&argv);
     gc_free(&gc);
+    (void)is_multipoint;
 }

 int
@@ -3553,7 +3566,7 @@
 /* tap devices need to be manually destroyed on AIX
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -3581,6 +3594,7 @@
     free(tt);
     env_set_destroy(es);
     argv_free(&argv);
+    (void)is_multipoint;
 }

 int
@@ -6868,7 +6882,7 @@
 }

 static void
-netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_are=
na *gc)
+netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_are=
na *gc, const bool is_multipoint)
 {
     const char *ifconfig_ip_local;
     struct argv argv =3D argv_new();
@@ -6898,7 +6912,7 @@

     if (ipv6 && tt->type =3D=3D DEV_TYPE_TUN)
     {
-        delete_route_connected_v6_net(tt);
+        delete_route_connected_v6_net(tt, is_multipoint);
     }

     /* "store=3Dactive" is needed in Windows 8(.1) to delete the
@@ -6968,7 +6982,7 @@
 }

 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -6988,7 +7002,7 @@
                 do_dns_domain_service(false, tt);
             }
             do_dns_service(false, AF_INET6, tt);
-            delete_route_connected_v6_net(tt);
+            delete_route_connected_v6_net(tt, is_multipoint);
             do_address_service(false, AF_INET6, tt);
         }
         else
@@ -6998,7 +7012,7 @@
                 do_dns_domain_wmic(false, tt);
             }

-            netsh_delete_address_dns(tt, true, &gc);
+            netsh_delete_address_dns(tt, true, &gc, is_multipoint);
         }
     }

@@ -7025,7 +7039,7 @@

             if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
             {
-                netsh_delete_address_dns(tt, false, &gc);
+                netsh_delete_address_dns(tt, false, &gc, is_multipoint);
             }
         }
     }
@@ -7146,12 +7160,13 @@
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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87777e74b1fd34781e1d72c9f994eb84f39d800c
Gerrit-Change-Number: 721
Gerrit-PatchSet: 5
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--iywsJUmL9fE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #5</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">route: extended logic to omit gateway when unnecessary<br><br>    Extract=
ed and extended the logic behind &#39;gateway_needed&#39; both in<br>    ad=
d_route() and add_route_ipv6(). Other than checking the dev-type,<br>    sp=
ecial routes and if the gateway is on-link,<br>    - set gateway_needed to =
true if the vpn instance is a multipoint server<br>      and DCO is enabled=
.<br>    - set gateway_needed to false if the gateway is in the vpn subnet.=
<br>    Additionally, extended support for these checks and conditions to D=
ARWIN<br>    and BSD-based operating systems.<br><br>    These changes ensu=
re that the gateway is only included when necessary,<br>    optimizing rout=
e configuration and potentially reducing redundant route entries.<br><br>Ch=
ange-Id: I87777e74b1fd34781e1d72c9f994eb84f39d800c<br>Signed-off-by: Marco =
Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/o=
penvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn/route.c<br>M src/ope=
nvpn/route.h<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>7 files chang=
ed, 417 insertions(+), 256 deletions(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/21/721/5</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/forward.c b/src/openvpn/forward.c</span><br><span>index 40b7cc4..8c22bc9=
 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/s=
rc/openvpn/forward.c</span><br><span>@@ -421,7 +421,7 @@</span><br><span> c=
heck_add_routes_action(struct context *c, const bool errors)</span><br><spa=
n> {</span><br><span>     bool route_status =3D do_route(&amp;c-&gt;options=
, c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                 c-&gt;c1.tuntap=
, c-&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                 c-&gt;c1.tu=
ntap, c-&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D CM_=
TOP);</span><br><span> </span><br><span>     int flags =3D (errors ? ISC_ER=
RORS : 0);</span><br><span>     flags |=3D (!route_status ? ISC_ROUTE_ERROR=
S : 0);</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.=
c</span><br><span>index dd56961..446537a 100644</span><br><span>--- a/src/o=
penvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -=
1134,7 +1134,7 @@</span><br><span>     tuncfg(options-&gt;dev, options-&gt;=
dev_type, options-&gt;dev_node,</span><br><span>            options-&gt;per=
sist_mode,</span><br><span>            options-&gt;username, options-&gt;gr=
oupname, &amp;options-&gt;tuntap_options,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-           ctx);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+           ctx, options-&gt;mode =3D=3D MODE_SERVER);</spa=
n><br><span>     if (options-&gt;persist_mode &amp;&amp; options-&gt;lladdr=
)</span><br><span>     {</span><br><span>         set_lladdr(ctx, options-&=
gt;dev, options-&gt;lladdr, NULL);</span><br><span>@@ -1689,13 +1689,14 @@<=
/span><br><span>          const struct tuntap *tt,</span><br><span>        =
  const struct plugin_list *plugins,</span><br><span>          struct env_s=
et *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         openv=
pn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         const bool is_multipoint)</span><br><span> {</span><br=
><span>     bool ret =3D true;</span><br><span>     if (!options-&gt;route_=
noexec &amp;&amp; ( route_list || route_ipv6_list ) )</span><br><span>     =
{</span><br><span>         ret =3D add_routes(route_list, route_ipv6_list, =
tt, ROUTE_OPTION_FLAGS(options),</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                         es, ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                         es, ctx, is_multipoint);=
</span><br><span>         setenv_int(es, &quot;redirect_gateway&quot;, rout=
e_did_redirect_default_gateway(route_list));</span><br><span>     }</span><=
br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>@@ -1898,7 +1899,7 @@</s=
pan><br><span>                                                  c-&gt;optio=
ns.dev_node,</span><br><span>                                              =
    &amp;gc);</span><br><span>             do_ifconfig(c-&gt;c1.tuntap, gue=
ss, c-&gt;c2.frame.tun_mtu, c-&gt;c2.es,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                        &amp;c-&gt;net_ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        &amp;c-=
&gt;net_ctx, c-&gt;mode =3D=3D CM_TOP);</span><br><span>         }</span><b=
r><span> </span><br><span>         /* possibly add routes */</span><br><spa=
n>@@ -1906,7 +1907,7 @@</span><br><span>         {</span><br><span>        =
     /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be ignored */</=
span><br><span>             bool status =3D do_route(&amp;c-&gt;options, c-=
&gt;c1.route_list, c-&gt;c1.route_ipv6_list,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                   c-&gt;c1.tuntap, =
c-&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                   c-&gt;c1.tu=
ntap, c-&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D CM_=
TOP);</span><br><span>             *error_flags |=3D (status ? 0 : ISC_ROUT=
E_ERRORS);</span><br><span>         }</span><br><span> #ifdef TARGET_ANDROI=
D</span><br><span>@@ -1934,7 +1935,7 @@</span><br><span>             &amp;&=
amp; ifconfig_order() =3D=3D IFCONFIG_AFTER_TUN_OPEN)</span><br><span>     =
    {</span><br><span>             do_ifconfig(c-&gt;c1.tuntap, c-&gt;c1.tu=
ntap-&gt;actual_name,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net=
_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;m=
ode =3D=3D CM_TOP);</span><br><span>         }</span><br><span> </span><br>=
<span>         /* run the up script */</span><br><span>@@ -1960,7 +1961,7 @=
@</span><br><span>         if ((route_order() =3D=3D ROUTE_AFTER_TUN) &amp;=
&amp; (!c-&gt;options.route_delay_defined))</span><br><span>         {</spa=
n><br><span>             int status =3D do_route(&amp;c-&gt;options, c-&gt;=
c1.route_list, c-&gt;c1.route_ipv6_list,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                  c-&gt;c1.tuntap, c-&gt=
;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                  c-&gt;c1.tuntap, =
c-&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D CM_TOP);<=
/span><br><span>             *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRO=
RS);</span><br><span>         }</span><br><span> </span><br><span>@@ -2017,=
7 +2018,7 @@</span><br><span>         {</span><br><span>             undo_i=
fconfig(c-&gt;c1.tuntap, &amp;c-&gt;net_ctx);</span><br><span>         }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        close_tun(c-&gt;=
c1.tuntap, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        close_tun(c-&gt;c1.tuntap, &amp;c-&gt;net_ctx, c-&gt;mo=
de =3D=3D CM_TOP);</span><br><span>         c-&gt;c1.tuntap =3D NULL;</span=
><br><span>     }</span><br><span>     c-&gt;c1.tuntap_owned =3D false;</sp=
an><br><span>@@ -2086,7 +2087,7 @@</span><br><span> </span><br><span>      =
       delete_routes(c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,</span><=
br><span>                           c-&gt;c1.tuntap, ROUTE_OPTION_FLAGS(&am=
p;c-&gt;options),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                      c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                          c-&gt;c2.es, =
&amp;c-&gt;net_ctx, c-&gt;mode =3D=3D CM_TOP);</span><br><span>         }</=
span><br><span> </span><br><span>         /* actually close tun/tap device =
based on --down-pre flag */</span><br><span>diff --git a/src/openvpn/init.h=
 b/src/openvpn/init.h</span><br><span>index ea7eb30..82eec7e 100644</span><=
br><span>--- a/src/openvpn/init.h</span><br><span>+++ b/src/openvpn/init.h<=
/span><br><span>@@ -74,7 +74,7 @@</span><br><span> bool do_route(const stru=
ct options *options, struct route_list *route_list,</span><br><span>       =
        struct route_ipv6_list *route_ipv6_list, const struct tuntap *tt,</=
span><br><span>               const struct plugin_list *plugins, struct env=
_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
  openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+              openvpn_net_ctx_t *ctx, const bool is_multipoint);</sp=
an><br><span> </span><br><span> void close_instance(struct context *c);</sp=
an><br><span> </span><br><span>diff --git a/src/openvpn/route.c b/src/openv=
pn/route.c</span><br><span>index 2033433..31a634a 100644</span><br><span>--=
- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br=
><span>@@ -77,7 +77,7 @@</span><br><span> </span><br><span> static void del=
ete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags=
,</span><br><span>                          const struct route_gateway_info=
 *rgi, const struct env_set *es,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                         openvpn_net_ctx_t *ctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                         openvpn_n=
et_ctx_t *ctx, const bool is_multipoint);</span><br><span> </span><br><span=
> static void get_bypass_addresses(struct route_bypass *rb, const unsigned =
int flags);</span><br><span> </span><br><span>@@ -927,7 +927,8 @@</span><br=
><span>            unsigned int flags,</span><br><span>            const st=
ruct route_gateway_info *rgi,</span><br><span>            const struct env_=
set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           op=
envpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+           openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+           const bool is_multipoint)</span><br><span> {</s=
pan><br><span>     struct route_ipv4 r;</span><br><span>     CLEAR(r);</spa=
n><br><span>@@ -935,7 +936,7 @@</span><br><span>     r.network =3D network;=
</span><br><span>     r.netmask =3D netmask;</span><br><span>     r.gateway=
 =3D gateway;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn add_route(&amp;r, tt, flags, rgi, es, ctx);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return add_route(&amp;r, tt, flags, rgi, es,=
 ctx, is_multipoint);</span><br><span> }</span><br><span> </span><br><span>=
 static void</span><br><span>@@ -946,7 +947,8 @@</span><br><span>          =
  unsigned int flags,</span><br><span>            const struct route_gatewa=
y_info *rgi,</span><br><span>            const struct env_set *es,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-           openvpn_net_ctx_t *=
ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           open=
vpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
           const bool is_multipoint)</span><br><span> {</span><br><span>   =
  struct route_ipv4 r;</span><br><span>     CLEAR(r);</span><br><span>@@ -9=
54,7 +956,7 @@</span><br><span>     r.network =3D network;</span><br><span>=
     r.netmask =3D netmask;</span><br><span>     r.gateway =3D gateway;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    delete_route(&amp;r, =
tt, flags, rgi, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    delete_route(&amp;r, tt, flags, rgi, es, ctx, is_multipoint);</sp=
an><br><span> }</span><br><span> </span><br><span> static bool</span><br><s=
pan>@@ -964,7 +966,8 @@</span><br><span>                   unsigned int fla=
gs,</span><br><span>                   const struct route_gateway_info *rgi=
,</span><br><span>                   const struct env_set *es,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                  openvpn_net_ctx_=
t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
      openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                  const bool is_multipoint)</span><br><span> {</s=
pan><br><span>     int ret =3D true;</span><br><span>     for (int i =3D 0;=
 i &lt; rb-&gt;n_bypass; ++i)</span><br><span>@@ -972,7 +975,7 @@</span><br=
><span>         if (rb-&gt;bypass[i])</span><br><span>         {</span><br>=
<span>             ret =3D add_route3(rb-&gt;bypass[i], IPV4_NETMASK_HOST, =
gateway, tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                    flags | ROUTE_REF_GW, rgi, es, ctx) &amp;&amp; ret;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
      flags | ROUTE_REF_GW, rgi, es, ctx, is_multipoint) &amp;&amp; ret;</s=
pan><br><span>         }</span><br><span>     }</span><br><span>     return=
 ret;</span><br><span>@@ -985,7 +988,8 @@</span><br><span>                 =
  unsigned int flags,</span><br><span>                   const struct route=
_gateway_info *rgi,</span><br><span>                   const struct env_set=
 *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
  openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                  openvpn_net_ctx_t *ctx,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                  const bool is_multipoint)</sp=
an><br><span> {</span><br><span>     int i;</span><br><span>     for (i =3D=
 0; i &lt; rb-&gt;n_bypass; ++i)</span><br><span>@@ -999,7 +1003,8 @@</span=
><br><span>                        flags | ROUTE_REF_GW,</span><br><span>  =
                      rgi,</span><br><span>                        es,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                       ctx=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
      ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              is_multipoint);</span><br><span>         }</span><br><span>  =
   }</span><br><span> }</span><br><span>@@ -1007,7 +1012,7 @@</span><br><sp=
an> static bool</span><br><span> redirect_default_route_to_vpn(struct route=
_list *rl, const struct tuntap *tt,</span><br><span>                       =
        unsigned int flags, const struct env_set *es,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                              openvpn_net_c=
tx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                     openvpn_net_ctx_t *ctx, const bool is_multipoint)</spa=
n><br><span> {</span><br><span>     const char err[] =3D &quot;NOTE: unable=
 to redirect IPv4 default gateway --&quot;;</span><br><span>     bool ret =
=3D true;</span><br><span>@@ -1059,7 +1064,7 @@</span><br><span>           =
      {</span><br><span>                     ret =3D add_route3(rl-&gt;spec=
.remote_host, IPV4_NETMASK_HOST,</span><br><span>                          =
            rl-&gt;rgi.gateway.addr, tt, flags | ROUTE_REF_GW,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
   &amp;rl-&gt;rgi, es, ctx);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                     &amp;rl-&gt;rgi, es, ctx, is=
_multipoint);</span><br><span>                     rl-&gt;iflags |=3D RL_DI=
D_LOCAL;</span><br><span>                 }</span><br><span>               =
  else</span><br><span>@@ -1071,7 +1076,7 @@</span><br><span> </span><br><s=
pan>             /* route DHCP/DNS server traffic through original default =
gateway */</span><br><span>             ret =3D add_bypass_routes(&amp;rl-&=
gt;spec.bypass, rl-&gt;rgi.gateway.addr, tt, flags,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                    &amp;rl=
-&gt;rgi, es, ctx) &amp;&amp; ret;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                    &amp;rl-&gt;rgi, es, ctx=
, is_multipoint) &amp;&amp; ret;</span><br><span> </span><br><span>        =
     if (rl-&gt;flags &amp; RG_REROUTE_GW)</span><br><span>             {</=
span><br><span>@@ -1079,11 +1084,11 @@</span><br><span>                 {</=
span><br><span>                     /* add new default route (1st component=
) */</span><br><span>                     ret =3D add_route3(0x00000000, 0x=
80000000, rl-&gt;spec.remote_endpoint,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                     tt, flags, &amp;rl-&g=
t;rgi, es, ctx) &amp;&amp; ret;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                     tt, flags, &amp;rl-&gt;rgi=
, es, ctx, is_multipoint) &amp;&amp; ret;</span><br><span> </span><br><span=
>                     /* add new default route (2nd component) */</span><br=
><span>                     ret =3D add_route3(0x80000000, 0x80000000, rl-&=
gt;spec.remote_endpoint,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                     tt, flags, &amp;rl-&gt;rgi, es, ctx=
) &amp;&amp; ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                   tt, flags, &amp;rl-&gt;rgi, es, ctx, is_=
multipoint) &amp;&amp; ret;</span><br><span>                 }</span><br><s=
pan>                 else</span><br><span>                 {</span><br><spa=
n>@@ -1092,12 +1097,12 @@</span><br><span>                     {</span><br>=
<span>                         /* delete default route */</span><br><span> =
                        del_route3(0, 0, rl-&gt;rgi.gateway.addr, tt,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
        flags | ROUTE_REF_GW, &amp;rl-&gt;rgi, es, ctx);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                   fla=
gs | ROUTE_REF_GW, &amp;rl-&gt;rgi, es, ctx, is_multipoint);</span><br><spa=
n>                     }</span><br><span> </span><br><span>                =
     /* add new default route */</span><br><span>                     ret =
=3D add_route3(0, 0, rl-&gt;spec.remote_endpoint, tt,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                     flags,=
 &amp;rl-&gt;rgi, es, ctx) &amp;&amp; ret;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                     flags, &amp;rl-=
&gt;rgi, es, ctx, is_multipoint) &amp;&amp; ret;</span><br><span>          =
       }</span><br><span>             }</span><br><span> </span><br><span>@=
@ -1112,7 +1117,8 @@</span><br><span> undo_redirect_default_route_to_vpn(st=
ruct route_list *rl,</span><br><span>                                    co=
nst struct tuntap *tt, unsigned int flags,</span><br><span>                =
                    const struct env_set *es,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                   openvpn_net_ctx_=
t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                       openvpn_net_ctx_t *ctx,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                   const bool is=
_multipoint)</span><br><span> {</span><br><span>     if (rl &amp;&amp; rl-&=
gt;iflags &amp; RL_DID_REDIRECT_DEFAULT_GATEWAY)</span><br><span>     {</sp=
an><br><span>@@ -1126,13 +1132,14 @@</span><br><span>                      =
  flags | ROUTE_REF_GW,</span><br><span>                        &amp;rl-&gt=
;rgi,</span><br><span>                        es,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                       ctx);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                       ctx,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                       is_mult=
ipoint);</span><br><span>             rl-&gt;iflags &amp;=3D ~RL_DID_LOCAL;=
</span><br><span>         }</span><br><span> </span><br><span>         /* d=
elete special DHCP/DNS bypass route */</span><br><span>         del_bypass_=
routes(&amp;rl-&gt;spec.bypass, rl-&gt;rgi.gateway.addr, tt, flags,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                          &am=
p;rl-&gt;rgi, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                          &amp;rl-&gt;rgi, es, ctx, is_multipoint);</sp=
an><br><span> </span><br><span>         if (rl-&gt;flags &amp; RG_REROUTE_G=
W)</span><br><span>         {</span><br><span>@@ -1146,7 +1153,8 @@</span><=
br><span>                            flags,</span><br><span>               =
             &amp;rl-&gt;rgi,</span><br><span>                            e=
s,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
        ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                     ctx,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                           is_multipoint);</span><br><span> </span><b=
r><span>                 /* delete default route (2nd component) */</span><=
br><span>                 del_route3(0x80000000,</span><br><span>@@ -1156,7=
 +1164,8 @@</span><br><span>                            flags,</span><br><s=
pan>                            &amp;rl-&gt;rgi,</span><br><span>          =
                  es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                           ctx);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                           ctx,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                           is_multipoint);</span><=
br><span>             }</span><br><span>             else</span><br><span> =
            {</span><br><span>@@ -1168,12 +1177,13 @@</span><br><span>     =
                       flags,</span><br><span>                            &=
amp;rl-&gt;rgi,</span><br><span>                            es,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                           ctx);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
       ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                   is_multipoint);</span><br><span>                 /* rest=
ore original default route if there was any */</span><br><span>            =
     if (rl-&gt;rgi.flags &amp; RGI_ADDR_DEFINED)</span><br><span>         =
        {</span><br><span>                     add_route3(0, 0, rl-&gt;rgi.=
gateway.addr, tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                           flags | ROUTE_REF_GW, &amp;rl-&gt;rgi, es, ctx);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
            flags | ROUTE_REF_GW, &amp;rl-&gt;rgi, es, ctx, is_multipoint);=
</span><br><span>                 }</span><br><span>             }</span><b=
r><span>         }</span><br><span>@@ -1185,9 +1195,10 @@</span><br><span> =
bool</span><br><span> add_routes(struct route_list *rl, struct route_ipv6_l=
ist *rl6,</span><br><span>            const struct tuntap *tt, unsigned int=
 flags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           con=
st struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+           const struct env_set *es, openvpn_net=
_ctx_t *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
    const bool is_multipoint)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    bool ret =3D redirect_default_route_to_vpn(r=
l, tt, flags, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool ret =3D redirect_default_route_to_vpn(rl, tt, flags, es, ctx, =
is_multipoint);</span><br><span>     if (rl &amp;&amp; !(rl-&gt;iflags &amp=
; RL_ROUTES_ADDED) )</span><br><span>     {</span><br><span>         struct=
 route_ipv4 *r;</span><br><span>@@ -1218,9 +1229,9 @@</span><br><span>     =
        check_subnet_conflict(r-&gt;network, r-&gt;netmask, &quot;route&quo=
t;);</span><br><span>             if (flags &amp; ROUTE_DELETE_FIRST)</span=
><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                delete_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                delet=
e_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx, is_multipoint);</span><br><=
span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          ret =3D add_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx) &amp;&a=
mp; ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 ret =3D add_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx, is_multipoint) &=
amp;&amp; ret;</span><br><span>         }</span><br><span>         rl-&gt;i=
flags |=3D RL_ROUTES_ADDED;</span><br><span>     }</span><br><span>@@ -1240=
,9 +1251,9 @@</span><br><span>         {</span><br><span>             if (f=
lags &amp; ROUTE_DELETE_FIRST)</span><br><span>             {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                delete_route_ipv6(r=
, tt, flags, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                delete_route_ipv6(r, tt, flags, es, ctx, is_multipoint);=
</span><br><span>             }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            ret =3D add_route_ipv6(r, tt, flags, es, ctx) &amp;&a=
mp; ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 ret =3D add_route_ipv6(r, tt, flags, es, ctx, is_multipoint) &amp;&amp; re=
t;</span><br><span>         }</span><br><span>         rl6-&gt;iflags |=3D =
RL_ROUTES_ADDED;</span><br><span>     }</span><br><span>@@ -1253,19 +1264,2=
0 @@</span><br><span> void</span><br><span> delete_routes(struct route_list=
 *rl, struct route_ipv6_list *rl6,</span><br><span>               const str=
uct tuntap *tt, unsigned int flags,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-              const struct env_set *es, openvpn_net_ctx_t *ct=
x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              con=
st struct env_set *es, openvpn_net_ctx_t *ctx,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+              const bool is_multipoint)</span><b=
r><span> {</span><br><span>     if (rl &amp;&amp; rl-&gt;iflags &amp; RL_RO=
UTES_ADDED)</span><br><span>     {</span><br><span>         struct route_ip=
v4 *r;</span><br><span>         for (r =3D rl-&gt;routes; r; r =3D r-&gt;ne=
xt)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            delete_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            delete_r=
oute(r, tt, flags, &amp;rl-&gt;rgi, es, ctx, is_multipoint);</span><br><spa=
n>         }</span><br><span>         rl-&gt;iflags &amp;=3D ~RL_ROUTES_ADD=
ED;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    undo_redirect_default_route_to_vpn(rl, tt, flags=
, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    undo=
_redirect_default_route_to_vpn(rl, tt, flags, es, ctx, is_multipoint);</spa=
n><br><span> </span><br><span>     if (rl)</span><br><span>     {</span><br=
><span>@@ -1277,7 +1289,7 @@</span><br><span>         struct route_ipv6 *r6=
;</span><br><span>         for (r6 =3D rl6-&gt;routes_ipv6; r6; r6 =3D r6-&=
gt;next)</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            delete_route_ipv6(r6, tt, flags, es, ctx);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            delete_route_i=
pv6(r6, tt, flags, es, ctx, is_multipoint);</span><br><span>         }</spa=
n><br><span>         rl6-&gt;iflags &amp;=3D ~RL_ROUTES_ADDED;</span><br><s=
pan>     }</span><br><span>@@ -1561,13 +1573,47 @@</span><br><span> }</span=
><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+is_gateway_needed_ipv4(const struct route_ipv4 *r4,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                       const struc=
t route_gateway_info *rgi,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                       const struct tuntap *tt,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                       const bool is_mul=
tipoint)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEFINED) &amp;&amp=
; rgi-&gt;iface[0] !=3D 0)  /* vpn server special route */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (rgi-&gt;flags &amp; RGI_ADDR_DEFINED &=
amp;&amp; r4-&gt;gateway !=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        &amp;&amp; !( (r4-&gt;flags &amp; RT_ME=
TRIC_DEFINED) &amp;&amp; r4-&gt;metric =3D=3D 0 ) )</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_m=
ultipoint &amp;&amp; !tt-&gt;options.disable_dco)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><sp=
an> add_route(struct route_ipv4 *r,</span><br><span>           const struct=
 tuntap *tt,</span><br><span>           unsigned int flags,</span><br><span=
>           const struct route_gateway_info *rgi,  /* may be NULL */</span>=
<br><span>           const struct env_set *es,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-          openvpn_net_ctx_t *ctx)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+          openvpn_net_ctx_t *ctx,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+          const bool i=
s_multipoint)</span><br><span> {</span><br><span>     int status =3D 0;</sp=
an><br><span>     int is_local_route;</span><br><span>@@ -1595,23 +1641,7 @=
@</span><br><span>         goto done;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef _WIN32</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (rgi &amp;&amp; (rgi-&gt;flags &amp; RG=
I_IFACE_DEFINED) &amp;&amp; rgi-&gt;iface[0] !=3D 0)  /* vpn server special=
 route */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (rgi-&gt;flags &a=
mp; RGI_ADDR_DEFINED &amp;&amp; r-&gt;gateway !=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            gateway_needed =3D true;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !( (r-&gt;fla=
gs &amp; RT_METRIC_DEFINED) &amp;&amp; r-&gt;metric =3D=3D 0 ) )</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        gateway_needed =3D true;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gateway_needed =3D is_gateway_needed_ipv4(r, rg=
i, tt, is_multipoint);</span><br><span> </span><br><span>     if (gateway_n=
eeded &amp;&amp; r-&gt;gateway =3D=3D 0)</span><br><span>     {</span><br><=
span>@@ -1623,11 +1653,12 @@</span><br><span>         goto done;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const char *iface =3D tt-&gt;actual_name;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if !defined(_WIN32) &amp;&amp; !def=
ined(TARGET_SOLARIS) \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &amp;&amp; !defined(TARGET_AIX)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *device =3D tt-&gt;actual_name;</span><br=
><span>     if (!gateway_needed &amp;&amp; rgi &amp;&amp; (rgi-&gt;flags &a=
mp; RGI_IFACE_DEFINED) &amp;&amp; rgi-&gt;iface[0] !=3D 0)  /* vpn server s=
pecial route */</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        iface =3D rgi-&gt;iface;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        device =3D rgi-&gt;iface;</span><br><=
span>     }</span><br><span> #endif</span><br><span> </span><br><span>@@ -1=
636,7 +1667,7 @@</span><br><span> </span><br><span>     if (is_on_link(is_l=
ocal_route, flags, rgi))</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        iface =3D rgi-&gt;iface;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        device =3D rgi-&gt;iface;</s=
pan><br><span>     }</span><br><span> </span><br><span>     if (r-&gt;flags=
 &amp; RT_METRIC_DEFINED)</span><br><span>@@ -1647,7 +1678,7 @@</span><br><=
span>     status =3D RTA_SUCCESS;</span><br><span>     int ret =3D net_rout=
e_v4_add(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask),</span=
><br><span>                                gateway_needed ? &amp;r-&gt;gate=
way : NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                     iface, 0, metric);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                               device, 0, metric);</spa=
n><br><span>     if (ret =3D=3D -EEXIST)</span><br><span>     {</span><br><=
span>         msg(D_ROUTE, &quot;NOTE: Linux route add command failed becau=
se route exists&quot;);</span><br><span>@@ -1664,7 +1695,7 @@</span><br><sp=
an> </span><br><span>     if (rgi)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        snprintf(out, sizeof(out), &quo=
t;%s %s %s dev %s&quot;, network, netmask, gateway, rgi-&gt;iface);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(out, sizeo=
f(out), &quot;%s %s %s dev %s&quot;, network, netmask, gateway, device);</s=
pan><br><span>     }</span><br><span>     else</span><br><span>     {</span=
><br><span>@@ -1768,9 +1799,9 @@</span><br><span>                          =
           &quot;ERROR: Solaris route add command failed&quot;);</span><br>=
<span>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEB=
SD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TA=
RGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s =
add&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_=
printf(&amp;argv, &quot;%s add &quot;,</span><br><span>                 ROU=
TE_PATH);</span><br><span> </span><br><span> #if 0</span><br><span>@@ -1780=
,45 +1811,28 @@</span><br><span>     }</span><br><span> #endif</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf_=
cat(&amp;argv, &quot;-net %s %s %s&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    network,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    gateway,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    netmask);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* FIXME -- add on-link support for FreeBSD */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D openvpn_execve_ch=
eck(&amp;argv, es, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                    &quot;ERROR: FreeBSD route add command =
failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sta=
tus =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#eli=
f defined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf=
(&amp;argv, &quot;%s add&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                ROUTE_PATH);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r-&gt;flags =
&amp; RT_METRIC_DEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (gateway_needed)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-r=
tt %d&quot;, r-&gt;metric);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                        n=
etwork,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        netmask);</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    network,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    gateway,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    netma=
sk);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add on-link support fo=
r Dragonfly */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;a=
rgv, &quot;-net %s -iface %s&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        network,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        device);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br=
><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     bool ret =3D=
 openvpn_execve_check(&amp;argv, es, 0,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                    &quot;ERROR: DragonFl=
y route add command failed&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                    &quot;ERROR: BSD route a=
dd command failed&quot;);</span><br><span>     status =3D ret ? RTA_SUCCESS=
 : RTA_ERROR;</span><br><span> </span><br><span> #elif defined(TARGET_DARWI=
N)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   argv_printf(&amp;argv, &quot;%s add&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s add &quot;,</=
span><br><span>                 ROUTE_PATH);</span><br><span> </span><br><s=
pan> #if 0</span><br><span>@@ -1839,10 +1853,19 @@</span><br><span>     }</=
span><br><span>     else</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-net %s =
%s %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
               network,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        gateway,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        netmask);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (gateway_needed)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            argv_printf_cat(&amp;argv, &quot;-net =
%s %s %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                        network,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            gateway,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            netmask);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            argv_printf_cat(&amp;argv, &quot;-net %s -=
interface %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                            network,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            device);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><b=
r><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><spa=
n>@@ -1852,7 +1875,7 @@</span><br><span> </span><br><span> #elif defined(TA=
RGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s add=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_pri=
ntf(&amp;argv, &quot;%s add &quot;,</span><br><span>                 ROUTE_=
PATH);</span><br><span> </span><br><span> #if 0</span><br><span>@@ -1862,12=
 +1885,20 @@</span><br><span>     }</span><br><span> #endif</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf_cat=
(&amp;argv, &quot;-net %s %s -netmask %s&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    network,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    gateway,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    netmask);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* FIXME -- add on-link support for OpenBSD/=
NetBSD */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ga=
teway_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_=
cat(&amp;argv, &quot;-net %s %s -netmask %s&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        network,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        gateway=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;=
-net %s -netmask %s -link -iface %s&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        network,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        netmask,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        de=
vice);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><sp=
an>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0,</span><br><span=
>@@ -1932,10 +1963,98 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inl=
ine struct in6_addr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
netbits_to_netmask_ipv6(const int netbits)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct in6_addr netmask =3D {{{0}}};</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (netbits &gt; 0 &amp;&amp; netbits &lt;=3D 128)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const int full_bytes =3D netbits / 8;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int i;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &l=
t; full_bytes; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  netmask.s6_addr[i] =3D 0xFF;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (netbits % 8)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        netmask.s6_addr[i] =3D (0xFF &lt;&lt; (8 - (netbits % 8)));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+is_gateway_in_vpn_subnet_ipv6(const stru=
ct in6_addr *gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                              const struct in6_addr *vpn_subnet,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
  int netbits)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr net=
mask =3D netbits_to_netmask_ipv6(netbits);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (int i =3D 0; i &lt; 16; i++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if ((gateway-&gt;s6_addr[i] &amp; netmask.s6_addr[i]) !=3D =
(vpn_subnet-&gt;s6_addr[i] &amp; netmask.s6_addr[i]))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+is_gateway_needed_ipv6(const struct route=
_ipv6 *r6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              const struct tuntap *tt,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                       const char *network,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                       const boo=
l is_multipoint)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (r6-&gt;iface !=3D NULL)   /* VPN serv=
er special route */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!I=
N6_IS_ADDR_UNSPECIFIED(&amp;r6-&gt;gateway))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * Filter out routes which are essentially no=
-ops</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (not cur=
rently done for IPv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* On &quot;tun&quot; int=
erface, we never set a gateway if the operating system</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * can do &quot;route to interface&q=
uot; - it does not add value, as the target</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * dev already fully qualifies the route destin=
ation on point-to-point</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * interfaces.   OTOH, on &quot;tap&quot; interface, we must always=
 set the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * gate=
way unless the route is to be an on-link network</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !( (r6-&gt;flags &a=
mp; RT_METRIC_DEFINED) &amp;&amp; r6-&gt;metric =3D=3D 0 ) )</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* if is server and dco enabled, the gateway is needed*/</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (is_multipoint &amp;&amp; !tt-&g=
t;options.disable_dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (is_gateway_in_vpn_subnet_ipv6(&am=
p;r6-&gt;gateway, &amp;tt-&gt;local_ipv6, tt-&gt;netbits_ipv6))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(D_ROUTE, &quot;Ignoring gateway i=
n VPN subnet for route %s/%d&quot;, network, r6-&gt;netbits);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> bool</span><br><span> add_route_ipv6(struct route_ipv6 *r6, const =
struct tuntap *tt,</span><br><span>                unsigned int flags, cons=
t struct env_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
               openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+               openvpn_net_ctx_t *ctx, const bool is_mul=
tipoint)</span><br><span> {</span><br><span>     int status =3D 0;</span><b=
r><span>     bool gateway_needed =3D false;</span><br><span>@@ -1948,22 +20=
67,12 @@</span><br><span>     struct argv argv =3D argv_new();</span><br><s=
pan>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifndef _WIN32</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *device =3D tt-&gt;actual_na=
me;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r6-&gt;ifa=
ce !=3D NULL)              /* vpn server special route */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        device =3D r6-&gt;iface;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!IN6_IS_ADDR_UNSPECIFIED(&amp;r=
6-&gt;gateway) )</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            gatew=
ay_needed =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     route_ipv6_clear_host=
_bits(r6);</span><br><span>     const char *network =3D print_in6_addr( r6-=
&gt;network, 0, &amp;gc);</span><br><span>     const char *gateway =3D prin=
t_in6_addr( r6-&gt;gateway, 0, &amp;gc);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gateway_needed =3D is_gateway_ne=
eded_ipv6(r6, tt, network, is_multipoint);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> #if defined(TARGET_DARWIN)    \</s=
pan><br><span>     || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) =
   \</span><br><span>     || defined(TARGET_OPENBSD) || defined(TARGET_NETB=
SD)</span><br><span>@@ -1982,6 +2091,15 @@</span><br><span>     }</span><br=
><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if !defined(_WIN32)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *device =3D tt-&gt;actual_name;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (r6-&gt;iface !=3D NULL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        device =3D r6-&gt;iface;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> #ifndef _WIN32</span><br><span>     msg(D_ROUTE, &=
quot;add_route_ipv6(%s/%d -&gt; %s metric %d) dev %s&quot;,</span><br><span=
>         network, r6-&gt;netbits, gateway, r6-&gt;metric, device );</span>=
<br><span>@@ -1991,23 +2109,6 @@</span><br><span>         r6-&gt;adapter_in=
dex ? r6-&gt;adapter_index : tt-&gt;adapter_index);</span><br><span> #endif=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Filter out =
routes which are essentially no-ops</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     * (not currently done for IPv6)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
 On &quot;tun&quot; interface, we never set a gateway if the operating syst=
em</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * can do &quot=
;route to interface&quot; - it does not add value, as the target</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     * dev already fully qualifi=
es the route destination on point-to-point</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     * interfaces.   OTOH, on &quot;tap&quot; interfac=
e, we must always set the</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * gateway unless the route is to be an on-link network</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !( (r6-&gt=
;flags &amp; RT_METRIC_DEFINED) &amp;&amp; r6-&gt;metric =3D=3D 0 ) )</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        gateway_needed =3D true;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span>     if (gateway_needed &amp;&a=
mp; IN6_IS_ADDR_UNSPECIFIED(&amp;r6-&gt;gateway))</span><br><span>     {</s=
pan><br><span>         msg(M_WARN, &quot;ROUTE6 WARNING: &quot; PACKAGE_NAM=
E &quot; needs a gateway &quot;</span><br><span>@@ -2020,6 +2121,7 @@</span=
><br><span> </span><br><span> #if defined(TARGET_LINUX)</span><br><span>   =
  int metric =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     if ((r6-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp=
; (r6-&gt;metric &gt; 0))</span><br><span>     {</span><br><span>         m=
etric =3D r6-&gt;metric;</span><br><span>@@ -2089,7 +2191,7 @@</span><br><s=
pan> </span><br><span> #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAG=
ONFLY)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    argv_printf(&amp;argv, &quot;%s add -inet6 %s/%d&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot=
;%s add -inet6 %s/%d &quot;,</span><br><span>                 ROUTE_PATH,</=
span><br><span>                 network,</span><br><span>                 r=
6-&gt;netbits);</span><br><span>@@ -2110,7 +2212,7 @@</span><br><span> </sp=
an><br><span> #elif defined(TARGET_DARWIN)</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s =
add -inet6 %s -prefixlen %d&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s add -inet6 %s -prefixlen=
 %d &quot;,</span><br><span>                 ROUTE_PATH,</span><br><span>  =
               network, r6-&gt;netbits );</span><br><span> </span><br><span=
>@@ -2128,26 +2230,24 @@</span><br><span>                                  =
   &quot;ERROR: MacOS X route add -inet6 command failed&quot;);</span><br><=
span>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_OPENBS=
D)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TAR=
GET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s add =
-inet6 %s -prefixlen %d %s&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    argv_printf(&amp;argv, &quot;%s add -inet6 %s -prefixlen =
%d &quot;,</span><br><span>                 ROUTE_PATH,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                network, r6-&gt;netbits, =
gateway );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       network, r6-&gt;netbits);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (gateway_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_pri=
ntf_cat(&amp;argv, &quot;%s&quot;, gateway);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_p=
rintf_cat(&amp;argv, &quot;-link -iface %s&quot;, device);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><s=
pan>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     bool ret =3D op=
envpn_execve_check(&amp;argv, es, 0,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                    &quot;ERROR: OpenBSD rou=
te add -inet6 command failed&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#elif defined(TARGET_NETBSD)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    argv_printf(&amp;argv, &quot;%s add -inet6 %s/%d %s&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                ROUTE_PATH,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                network,=
 r6-&gt;netbits, gateway );</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_=
ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 bool ret =3D openvpn_execve_check(&amp;argv, es, 0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                    &quot;E=
RROR: NetBSD route add -inet6 command failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                    &quot=
;ERROR: OpenBSD/NetBSD route add -inet6 command failed&quot;);</span><br><s=
pan>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span>=
<br><span> #elif defined(TARGET_AIX)</span><br><span>@@ -2187,7 +2287,8 @@<=
/span><br><span>              unsigned int flags,</span><br><span>         =
     const struct route_gateway_info *rgi,</span><br><span>              co=
nst struct env_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-             openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             openvpn_net_ctx_t *ctx,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+             const bool is_multipoint)<=
/span><br><span> {</span><br><span> #if !defined(TARGET_LINUX)</span><br><s=
pan>     const char *network;</span><br><span>@@ -2202,6 +2303,21 @@</span>=
<br><span> #endif</span><br><span>     int is_local_route;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET=
_DARWIN) || defined(TARGET_LINUX)  \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY=
)    \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    || define=
d(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool gateway_needed =3D is_gateway_needed_ipv4(r, rgi, tt, is_mult=
ipoint);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_OPENBSD) &=
amp;&amp; !defined(TARGET_NETBSD)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *device =3D tt-&gt;actual_name;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!gateway_needed &amp;&amp;=
 rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEFINED) &amp;&amp; rgi-&gt;=
iface[0] !=3D 0)  /* vpn server special route */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        device =3D rgi-&gt;iface;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     if ((r-&gt;flags &amp; (RT_DEFINED|RT_ADDED)) !=3D (RT_DEFINED|R=
T_ADDED))</span><br><span>     {</span><br><span>         return;</span><br=
><span>@@ -2228,13 +2344,20 @@</span><br><span> </span><br><span> #if defin=
ed(TARGET_LINUX)</span><br><span>     metric =3D -1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (is_on_link(is_local_route, flags, rgi))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        device =3D rgi-&gt;iface;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     if (r-&gt;flags &amp; RT=
_METRIC_DEFINED)</span><br><span>     {</span><br><span>         metric =3D=
 r-&gt;metric;</span><br><span>     }</span><br><span> </span><br><span>   =
  if (net_route_v4_del(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;n=
etmask),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
            &amp;r-&gt;gateway, NULL, 0, metric) &lt; 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                         gateway_neede=
d ? &amp;r-&gt;gateway : NULL,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                         device, 0, metric) &lt; 0)</span><br><s=
pan>     {</span><br><span>         msg(M_WARN, &quot;ERROR: Linux route de=
lete command failed&quot;);</span><br><span>     }</span><br><span>@@ -2293=
,27 +2416,26 @@</span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><b=
r><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Solaris ro=
ute delete command failed&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_FREEBSD) || =
defined(TARGET_DRAGONFLY)</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delete -net %s %s=
 %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     ROUTE_PATH,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           network,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                netmask);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    argv_printf(&amp;argv, &quot;%s delete&quot;, ROUTE_PATH);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (gateway_needed)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-net %s %s %s=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        gateway,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        netmask);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        arg=
v_printf_cat(&amp;argv, &quot;-net %s -iface %s&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        network,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        dev=
ice);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, =
es, 0, &quot;ERROR: FreeBSD route delete command failed&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#elif defined(TARGET_DRAGONFLY)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    argv_printf(&amp;argv, &quot;%s delete -net %s %s %s&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ROUTE_=
PATH,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
network,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;=
argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_exe=
cve_check(&amp;argv, es, 0, &quot;ERROR: DragonFly route delete command fai=
led&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    open=
vpn_execve_check(&amp;argv, es, 0, &quot;ERROR: BSD route delete command fa=
iled&quot;);</span><br><span> </span><br><span> #elif defined(TARGET_DARWIN=
)</span><br><span> </span><br><span>@@ -2327,11 +2449,22 @@</span><br><span=
>     }</span><br><span>     else</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s =
delete -net %s %s %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    ROUTE_PATH,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    network,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    gateway,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    netmask);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &q=
uot;%s delete &quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    ROUTE_PATH);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (gateway_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                            network=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
          gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                           netmask);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  argv_printf_cat(&amp;argv, &quot;-net %s -interface %s&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                            net=
work,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
              device);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span>     }</span><br><span> </span><br><span>     =
argv_msg(D_ROUTE, &amp;argv);</span><br><span>@@ -2339,11 +2472,22 @@</span=
><br><span> </span><br><span> #elif defined(TARGET_OPENBSD) || defined(TARG=
ET_NETBSD)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    argv_printf(&amp;argv, &quot;%s delete -net %s %s -netmask %s&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                R=
OUTE_PATH,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     network,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    argv_printf(&amp;argv, &quot;%s delete &quot;,</span><br><span style=
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
BSD route delete command failed&quot;);</span><br><span>@@ -2378,7 +2522,7 =
@@</span><br><span> void</span><br><span> delete_route_ipv6(const struct ro=
ute_ipv6 *r6, const struct tuntap *tt,</span><br><span>                   u=
nsigned int flags, const struct env_set *es,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                  openvpn_net_ctx_t *ctx)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                  openvpn_net_=
ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><span>  =
   const char *network;</span><br><span> </span><br><span>@@ -2391,23 +2535=
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
><span> #endif</span><br><span> </span><br><span>@@ -2419,6 +2555,16 @@</sp=
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
2513,23 +2659,19 @@</span><br><span>     argv_msg(D_ROUTE, &amp;argv);</spa=
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
/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 739e008..28fca0e 1=
00644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/ope=
nvpn/tun.c</span><br><span>@@ -1018,7 +1018,7 @@</span><br><span>  */</span=
><br><span> static void</span><br><span> add_route_connected_v6_net(struct =
tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                 const struct env_set *es)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                           const struct env_set *es,=
 const bool is_multipoint)</span><br><span> {</span><br><span>     struct r=
oute_ipv6 r6;</span><br><span> </span><br><span>@@ -1028,11 +1028,11 @@</sp=
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
pan>     struct route_ipv6 r6;</span><br><span> </span><br><span>@@ -1043,7=
 +1043,7 @@</span><br><span>     r6.metric  =3D 0;                     /* c=
onnected route */</span><br><span>     r6.flags   =3D RT_DEFINED | RT_ADDED=
 | RT_METRIC_DEFINED;</span><br><span>     route_ipv6_clear_host_bits(&amp;=
r6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    delete_route_=
ipv6(&amp;r6, tt, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    delete_route_ipv6(&amp;r6, tt, 0, NULL, NULL, is_multipoi=
nt);</span><br><span> }</span><br><span> #endif /* if defined(_WIN32) || de=
fined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD) *=
/</span><br><span> </span><br><span>@@ -1085,7 +1085,8 @@</span><br><span> =
 */</span><br><span> static void</span><br><span> do_ifconfig_ipv6(struct t=
untap *tt, const char *ifname, int tun_mtu,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                 const struct env_set *es, openvpn_ne=
t_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
           const struct env_set *es, openvpn_net_ctx_t *ctx,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 const bool is_mul=
tipoint)</span><br><span> {</span><br><span> #if !defined(TARGET_LINUX)</sp=
an><br><span>     struct argv argv =3D argv_new();</span><br><span>@@ -1203=
,7 +1204,7 @@</span><br><span> #if defined(TARGET_OPENBSD) || defined(TARGE=
T_NETBSD) \</span><br><span>     || defined(TARGET_DARWIN)</span><br><span>=
     /* and, hooray, we explicitly need to add a route... */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    add_route_connected_v6_net(tt, e=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_route_co=
nnected_v6_net(tt, es, is_multipoint);</span><br><span> #endif</span><br><s=
pan> #elif defined(TARGET_AIX)</span><br><span>     argv_printf(&amp;argv, =
&quot;%s %s inet6 %s/%d mtu %d up&quot;, IFCONFIG_PATH, ifname,</span><br><=
span>@@ -1229,7 +1230,7 @@</span><br><span>         do_address_service(true=
, AF_INET6, tt);</span><br><span>         if (tt-&gt;type =3D=3D DEV_TYPE_T=
UN)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            add_route_connected_v6_net(tt, es);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            add_route_connected_v6_net=
(tt, es, is_multipoint);</span><br><span>         }</span><br><span>       =
  do_dns_service(true, AF_INET6, tt);</span><br><span>         do_set_mtu_s=
ervice(tt, AF_INET6, tun_mtu);</span><br><span>@@ -1257,7 +1258,7 @@</span>=
<br><span>         netsh_command(&amp;argv, 4, M_FATAL);</span><br><span>  =
       if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            add_route_conn=
ected_v6_net(tt, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            add_route_connected_v6_net(tt, es, is_multipoint);</span><br>=
<span>         }</span><br><span>         /* set ipv6 dns servers if any ar=
e specified */</span><br><span>         netsh_set_dns6_servers(tt-&gt;optio=
ns.dns6, tt-&gt;options.dns6_len, tt-&gt;adapter_index);</span><br><span>@@=
 -1289,7 +1290,7 @@</span><br><span>  */</span><br><span> static void</span=
><br><span> do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun=
_mtu,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
 const struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                 const struct env_set *es, o=
penvpn_net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><=
br><span> #if !defined(_WIN32) &amp;&amp; !defined(TARGET_ANDROID)</span><b=
r><span>     /*</span><br><span>@@ -1394,7 +1395,7 @@</span><br><span>     =
    r.netmask =3D tt-&gt;remote_netmask;</span><br><span>         r.gateway=
 =3D tt-&gt;local;</span><br><span>         r.metric =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        add_route(&amp;r, tt, 0, NULL=
, es, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 add_route(&amp;r, tt, 0, NULL, es, NULL, is_multipoint);</span><br><span> =
    }</span><br><span> </span><br><span> #elif defined(TARGET_OPENBSD)</spa=
n><br><span>@@ -1441,7 +1442,7 @@</span><br><span>         r.network =3D tt=
-&gt;local &amp; tt-&gt;remote_netmask;</span><br><span>         r.netmask =
=3D tt-&gt;remote_netmask;</span><br><span>         r.gateway =3D remote_en=
d;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        add_route(&=
amp;r, tt, 0, NULL, es, NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        add_route(&amp;r, tt, 0, NULL, es, NULL, is_multipoint);=
</span><br><span>     }</span><br><span> </span><br><span> #elif defined(TA=
RGET_NETBSD)</span><br><span>@@ -1483,7 +1484,7 @@</span><br><span>        =
 r.network =3D tt-&gt;local &amp; tt-&gt;remote_netmask;</span><br><span>  =
       r.netmask =3D tt-&gt;remote_netmask;</span><br><span>         r.gate=
way =3D remote_end;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      add_route(&amp;r, tt, 0, NULL, es, NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        add_route(&amp;r, tt, 0, NULL, es, NULL=
, is_multipoint);</span><br><span>     }</span><br><span> </span><br><span>=
 #elif defined(TARGET_DARWIN)</span><br><span>@@ -1530,7 +1531,7 @@</span><=
br><span>         r.network =3D tt-&gt;local &amp; tt-&gt;remote_netmask;</=
span><br><span>         r.netmask =3D tt-&gt;remote_netmask;</span><br><spa=
n>         r.gateway =3D tt-&gt;local;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        add_route(&amp;r, tt, 0, NULL, es, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        add_route(&amp;r, tt=
, 0, NULL, es, NULL, is_multipoint);</span><br><span>     }</span><br><span=
> </span><br><span> #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONF=
LY)</span><br><span>@@ -1624,7 +1625,7 @@</span><br><span> /* execute the i=
fconfig command through the shell */</span><br><span> void</span><br><span>=
 do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            const struct env_set=
 *es, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            const struct env_set *es, openvpn_net_ctx_t *ctx, con=
st bool is_multipoint)</span><br><span> {</span><br><span>     msg(D_LOW, &=
quot;do_ifconfig, ipv4=3D%d, ipv6=3D%d&quot;, tt-&gt;did_ifconfig_setup,</s=
pan><br><span>         tt-&gt;did_ifconfig_ipv6_setup);</span><br><span>@@ =
-1644,12 +1645,12 @@</span><br><span> </span><br><span>     if (tt-&gt;did_=
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
e setup */</span><br><span>@@ -2114,12 +2115,13 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, =
openvpn_net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span>=
<br><span>     ASSERT(tt);</span><br><span> </span><br><span>     close_tun=
_generic(tt);</span><br><span>     free(tt);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    (void)is_multipoint;</span><br><span> }</span>=
<br><span> </span><br><span> int</span><br><span>@@ -2283,7 +2285,8 @@</spa=
n><br><span> void</span><br><span> tuncfg(const char *dev, const char *dev_=
type, const char *dev_node,</span><br><span>        int persist_mode, const=
 char *username, const char *groupname,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-       const struct tuntap_options *options, openvpn_net_=
ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       c=
onst struct tuntap_options *options, openvpn_net_ctx_t *ctx,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+       const bool is_multipoint)</=
span><br><span> {</span><br><span>     struct tuntap *tt;</span><br><span> =
</span><br><span>@@ -2323,14 +2326,14 @@</span><br><span>             msg(M=
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
   ASSERT(tt);</span><br><span> </span><br><span>@@ -2342,6 +2345,7 @@</spa=
n><br><span> #endif</span><br><span>     close_tun_generic(tt);</span><br><=
span>     free(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    (void)is_multipoint;</span><br><span> }</span><br><span> </span><br><sp=
an> int</span><br><span>@@ -2653,7 +2657,7 @@</span><br><span>  * Close TUN=
 device.</span><br><span>  */</span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-close_tun(struct tuntap *tt, openvpn_net_ct=
x_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+close_tun(=
struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipoint)</span>=
<br><span> {</span><br><span>     ASSERT(tt);</span><br><span> </span><br><=
span>@@ -2663,6 +2667,7 @@</span><br><span> </span><br><span>     clear_tun=
tap(tt);</span><br><span>     free(tt);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    (void)is_multipoint;</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span>@@ -2686,7 +2691,7 @@</=
span><br><span> </span><br><span>     argv_msg(M_INFO, &amp;argv);</span><b=
r><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;Solaris ifconfig =
unplumb failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    close_tun(tt, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    close_tun(tt, NULL, false);</span><br><span>     msg(M_FATAL, &qu=
ot;Solaris ifconfig failed&quot;);</span><br><span>     argv_free(&amp;argv=
);</span><br><span> }</span><br><span>@@ -2750,10 +2755,12 @@</span><br><sp=
an>  */</span><br><span> </span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *c=
tx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct=
 tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipoint)</span><br><s=
pan> {</span><br><span>     ASSERT(tt);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    (void)is_multipoint;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* only *T=
AP* devices need destroying, tun devices auto-self-destruct</span><br><span=
>      */</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN || tt-&g=
t;persistent_if)</span><br><span>@@ -2864,10 +2871,12 @@</span><br><span>  =
* need to be explicitly destroyed</span><br><span>  */</span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-close_tun(struct tun=
tap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const boo=
l is_multipoint)</span><br><span> {</span><br><span>     ASSERT(tt);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (voi=
d)is_multipoint;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     /* only tun devices need destroying, tap devices auto-se=
lf-destruct</span><br><span>      */</span><br><span>     if (tt-&gt;type !=
=3D DEV_TYPE_TUN || tt-&gt;persistent_if)</span><br><span>@@ -3020,10 +3029=
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
n>@@ -3137,12 +3148,13 @@</span><br><span> }</span><br><span> </span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-close_tun(st=
ruct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, c=
onst bool is_multipoint)</span><br><span> {</span><br><span>     ASSERT(tt)=
;</span><br><span> </span><br><span>     close_tun_generic(tt);</span><br><=
span>     free(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    (void)is_multipoint;</span><br><span> }</span><br><span> </span><br><sp=
an> int</span><br><span>@@ -3404,7 +3416,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, openv=
pn_net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><=
span>     ASSERT(tt);</span><br><span> </span><br><span>@@ -3426,6 +3438,7 =
@@</span><br><span>     free(tt);</span><br><span>     argv_free(&amp;argv)=
;</span><br><span>     gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    (void)is_multipoint;</span><br><span> }</span><br>=
<span> </span><br><span> int</span><br><span>@@ -3553,7 +3566,7 @@</span><b=
r><span> /* tap devices need to be manually destroyed on AIX</span><br><spa=
n>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, openvp=
n_net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><s=
pan>     ASSERT(tt);</span><br><span> </span><br><span>@@ -3581,6 +3594,7 @=
@</span><br><span>     free(tt);</span><br><span>     env_set_destroy(es);<=
/span><br><span>     argv_free(&amp;argv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    (void)is_multipoint;</span><br><span> }</span><b=
r><span> </span><br><span> int</span><br><span>@@ -6868,7 +6882,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-netsh_delete_address_dns(const struct=
 tuntap *tt, bool ipv6, struct gc_arena *gc)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+netsh_delete_address_dns(const struct tuntap *tt, =
bool ipv6, struct gc_arena *gc, const bool is_multipoint)</span><br><span> =
{</span><br><span>     const char *ifconfig_ip_local;</span><br><span>     =
struct argv argv =3D argv_new();</span><br><span>@@ -6898,7 +6912,7 @@</spa=
n><br><span> </span><br><span>     if (ipv6 &amp;&amp; tt-&gt;type =3D=3D D=
EV_TYPE_TUN)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        delete_route_connected_v6_net(tt);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        delete_route_connected_v6_net(=
tt, is_multipoint);</span><br><span>     }</span><br><span> </span><br><spa=
n>     /* &quot;store=3Dactive&quot; is needed in Windows 8(.1) to delete t=
he</span><br><span>@@ -6968,7 +6982,7 @@</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, openvpn_ne=
t_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><span>=
     ASSERT(tt);</span><br><span> </span><br><span>@@ -6988,7 +7002,7 @@</s=
pan><br><span>                 do_dns_domain_service(false, tt);</span><br>=
<span>             }</span><br><span>             do_dns_service(false, AF_=
INET6, tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  delete_route_connected_v6_net(tt);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            delete_route_connected_v6_net(tt, is_multipoin=
t);</span><br><span>             do_address_service(false, AF_INET6, tt);</=
span><br><span>         }</span><br><span>         else</span><br><span>@@ =
-6998,7 +7012,7 @@</span><br><span>                 do_dns_domain_wmic(fals=
e, tt);</span><br><span>             }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            netsh_delete_address_dns(tt,=
 true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         netsh_delete_address_dns(tt, true, &amp;gc, is_multipoint);</span>=
<br><span>         }</span><br><span>     }</span><br><span> </span><br><sp=
an>@@ -7025,7 +7039,7 @@</span><br><span> </span><br><span>             if =
(tt-&gt;options.ip_win32_type =3D=3D IPW32_SET_NETSH)</span><br><span>     =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    netsh_delete_address_dns(tt, false, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                netsh_delete_address_dns(tt, =
false, &amp;gc, is_multipoint);</span><br><span>             }</span><br><s=
pan>         }</span><br><span>     }</span><br><span>@@ -7146,12 +7160,13 =
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
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail">change =
721</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87777e74b1fd34781e1d72c9f99=
4eb84f39d800c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 721 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--iywsJUmL9fE=--

