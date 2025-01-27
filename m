From: "mrbff (Code Review)" <gerrit@...515...>
Date: Mon, 27 Jan 2025 17:39:48 +0000
In-Reply-To: <gerrit.1722331476000.I87777e74b1fd34781e1d72c9f994eb84f39d800c@...2715...>
References: <gerrit.1722331476000.I87777e74b1fd34781e1d72c9f994eb84f39d800c@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a1c60683cc58cce060fe7aab744847953498c903-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fHjypya2p+I="; charset=UTF-8
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

--fHjypya2p+I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail

to look at the new patch set (#11).


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
7 files changed, 420 insertions(+), 253 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/721/11

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f3f3503..7352418 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -427,7 +427,7 @@
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
index 4014517..280a9b9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1152,7 +1152,7 @@
     tuncfg(options->dev, options->dev_type, options->dev_node,
            options->persist_mode,
            options->username, options->groupname, &options->tuntap_options,
-           ctx);
+           ctx, options->mode =3D=3D MODE_SERVER);
     if (options->persist_mode && options->lladdr)
     {
         set_lladdr(ctx, options->dev, options->lladdr, NULL);
@@ -1719,13 +1719,14 @@
          const struct tuntap *tt,
          const struct plugin_list *plugins,
          struct env_set *es,
-         openvpn_net_ctx_t *ctx)
+         openvpn_net_ctx_t *ctx,
+         const bool is_multipoint)
 {
     bool ret =3D true;
     if (!route_noexec_enabled(options, tt) && ( route_list || route_ipv6_l=
ist ) )
     {
         ret =3D add_routes(route_list, route_ipv6_list, tt, ROUTE_OPTION_F=
LAGS(options),
-                         es, ctx);
+                         es, ctx, is_multipoint);
         setenv_int(es, "redirect_gateway", route_did_redirect_default_gate=
way(route_list));
     }
 #ifdef ENABLE_MANAGEMENT
@@ -1987,7 +1988,7 @@
                                                  c->options.dev_type,
                                                  c->options.dev_node,
                                                  &gc);
-            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es=
, &c->net_ctx);
+            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es=
, &c->net_ctx, c->mode =3D=3D CM_TOP);
         }

         /* possibly add routes */
@@ -1995,7 +1996,7 @@
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
@@ -2022,7 +2023,7 @@
             && ifconfig_order(c->c1.tuntap) =3D=3D IFCONFIG_AFTER_TUN_OPEN)
         {
             do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
-                        c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
+                        c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx, c->mod=
e =3D=3D CM_TOP);
         }

         /* run the up script */
@@ -2048,7 +2049,7 @@
         if ((route_order(c->c1.tuntap) =3D=3D ROUTE_AFTER_TUN) && (!c->opt=
ions.route_delay_defined))
         {
             int status =3D do_route(&c->options, c->c1.route_list, c->c1.r=
oute_ipv6_list,
-                                  c->c1.tuntap, c->plugins, c->c2.es, &c->=
net_ctx);
+                                  c->c1.tuntap, c->plugins, c->c2.es, &c->=
net_ctx, c->mode =3D=3D CM_TOP);
             *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);
         }

@@ -2116,7 +2117,7 @@
         }
         else
         {
-            close_tun(c->c1.tuntap, &c->net_ctx);
+            close_tun(c->c1.tuntap, &c->net_ctx, c->mode =3D=3D CM_TOP);
         }
         c->c1.tuntap =3D NULL;
     }
@@ -2186,7 +2187,7 @@

             delete_routes(c->c1.route_list, c->c1.route_ipv6_list,
                           c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options),
-                          c->c2.es, &c->net_ctx);
+                          c->c2.es, &c->net_ctx, c->mode =3D=3D CM_TOP);
         }

         /* actually close tun/tap device based on --down-pre flag */
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 11c32ac..f841402 100644
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
index e9de795..1b419f8 100644
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
                     if (ret)
                     {
                         rl->iflags |=3D RL_DID_LOCAL;
@@ -1074,7 +1079,7 @@
=20
             /* route DHCP/DNS server traffic through original default gate=
way */
             ret =3D add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.ad=
dr, tt, flags,
-                                    &rl->rgi, es, ctx) && ret;
+                                    &rl->rgi, es, ctx, is_multipoint) && r=
et;

             if (rl->flags & RG_REROUTE_GW)
             {
@@ -1082,11 +1087,11 @@
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
@@ -1095,12 +1100,12 @@
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

@@ -1115,7 +1120,8 @@
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
@@ -1129,13 +1135,14 @@
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
@@ -1149,7 +1156,8 @@
                            flags,
                            &rl->rgi,
                            es,
-                           ctx);
+                           ctx,
+                           is_multipoint);

                 /* delete default route (2nd component) */
                 del_route3(0x80000000,
@@ -1159,7 +1167,8 @@
                            flags,
                            &rl->rgi,
                            es,
-                           ctx);
+                           ctx,
+                           is_multipoint);
             }
             else
             {
@@ -1171,12 +1180,13 @@
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
@@ -1188,9 +1198,10 @@
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
@@ -1221,9 +1232,9 @@
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
@@ -1243,9 +1254,9 @@
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
@@ -1256,19 +1267,20 @@
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
@@ -1280,7 +1292,7 @@
         struct route_ipv6 *r6;
         for (r6 =3D rl6->routes_ipv6; r6; r6 =3D r6->next)
         {
-            delete_route_ipv6(r6, tt, flags, es, ctx);
+            delete_route_ipv6(r6, tt, flags, es, ctx, is_multipoint);
         }
         rl6->iflags &=3D ~RL_ROUTES_ADDED;
     }
@@ -1564,13 +1576,48 @@
 }
 #endif

+static bool
+is_gateway_needed_ipv4(const struct route_ipv4 *r4,
+                       const struct route_gateway_info *rgi,
+                       const struct tuntap *tt,
+                       const bool is_dco_enabled,
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
+    if (is_multipoint && is_dco_enabled)
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
@@ -1598,21 +1645,7 @@
         goto done;
     }

-#ifndef _WIN32
-    if (rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi->iface[0] !=3D 0)  =
/* vpn server special route */
-    {
-        if (rgi->flags & RGI_ADDR_DEFINED && r->gateway !=3D 0)
-        {
-            gateway_needed =3D true;
-        }
-    }
-#endif
-
-    if (tt->type =3D=3D DEV_TYPE_TAP
-        && !( (r->flags & RT_METRIC_DEFINED) && r->metric =3D=3D 0 ) )
-    {
-        gateway_needed =3D true;
-    }
+    gateway_needed =3D is_gateway_needed_ipv4(r, rgi, tt, tt->backend_driv=
er =3D=3D DRIVER_DCO, is_multipoint);

     if (gateway_needed && r->gateway =3D=3D 0)
     {
@@ -1624,18 +1657,21 @@
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
+#endif

+#if defined(TARGET_LINUX)
     int metric =3D -1;

     if (is_on_link(is_local_route, flags, rgi))
     {
-        iface =3D rgi->iface;
+        device =3D rgi->iface;
     }

     if (r->flags & RT_METRIC_DEFINED)
@@ -1646,7 +1682,7 @@
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
@@ -1663,7 +1699,7 @@

     if (rgi)
     {
-        snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, ga=
teway, rgi->iface);
+        snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, ga=
teway, device);
     }
     else
     {
@@ -1767,9 +1803,9 @@
                                     "ERROR: Solaris route add command fail=
ed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;

-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

-    argv_printf(&argv, "%s add",
+    argv_printf(&argv, "%s add ",
                 ROUTE_PATH);

 #if 0
@@ -1779,45 +1815,28 @@
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
@@ -1838,10 +1857,19 @@
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
@@ -1851,7 +1879,7 @@

 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)

-    argv_printf(&argv, "%s add",
+    argv_printf(&argv, "%s add ",
                 ROUTE_PATH);

 #if 0
@@ -1861,12 +1889,20 @@
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
@@ -1945,10 +1981,99 @@
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
+                       const bool is_dco_enabled,
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
+    if (is_multipoint && is_dco_enabled)
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
@@ -1961,22 +2086,12 @@
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

+    gateway_needed =3D is_gateway_needed_ipv6(r6, tt, network, tt->backend=
_driver =3D=3D DRIVER_DCO, is_multipoint);
+
 #if defined(TARGET_DARWIN)    \
     || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
     || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
@@ -1995,6 +2110,15 @@
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
@@ -2004,23 +2128,6 @@
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
@@ -2033,6 +2140,7 @@

 #if defined(TARGET_LINUX)
     int metric =3D -1;
+
     if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
         metric =3D r6->metric;
@@ -2102,7 +2210,7 @@

 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

-    argv_printf(&argv, "%s add -inet6 %s/%d",
+    argv_printf(&argv, "%s add -inet6 %s/%d ",
                 ROUTE_PATH,
                 network,
                 r6->netbits);
@@ -2123,7 +2231,7 @@

 #elif defined(TARGET_DARWIN)

-    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d",
+    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d ",
                 ROUTE_PATH,
                 network, r6->netbits );

@@ -2141,26 +2249,24 @@
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
@@ -2214,7 +2320,8 @@
              unsigned int flags,
              const struct route_gateway_info *rgi,
              const struct env_set *es,
-             openvpn_net_ctx_t *ctx)
+             openvpn_net_ctx_t *ctx,
+             const bool is_multipoint)
 {
 #if !defined(TARGET_LINUX)
     const char *network;
@@ -2229,6 +2336,21 @@
 #endif
     int is_local_route;

+#if defined(TARGET_DARWIN) || defined(TARGET_LINUX)  \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
+    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+
+    bool gateway_needed =3D is_gateway_needed_ipv4(r, rgi, tt, tt->backend=
_driver =3D=3D DRIVER_DCO, is_multipoint);
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
@@ -2255,13 +2377,20 @@

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
@@ -2320,27 +2449,26 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route delete comman=
d failed");

-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
=20
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

@@ -2354,11 +2482,22 @@
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
@@ -2366,11 +2505,22 @@

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
@@ -2417,7 +2567,7 @@
 void
 delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
                   unsigned int flags, const struct env_set *es,
-                  openvpn_net_ctx_t *ctx)
+                  openvpn_net_ctx_t *ctx, const bool is_multipoint)
 {
     const char *network;

@@ -2430,23 +2580,15 @@
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

@@ -2458,6 +2600,16 @@
     gateway =3D print_in6_addr( r6->gateway, 0, &gc);
 #endif

+#if defined(TARGET_DARWIN) || defined(TARGET_LINUX)  \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
+    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+    /* if we used a gateway on "add route", we also need to specify it on
+     * delete, otherwise some OSes will refuse to delete the route
+     */
+    bool gateway_needed =3D false;
+    gateway_needed =3D is_gateway_needed_ipv6(r6, tt, network, tt->backend=
_driver =3D=3D DRIVER_DCO, is_multipoint);
+#endif
+
 #if defined(TARGET_DARWIN)    \
     || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
     || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
@@ -2552,23 +2704,19 @@
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
=20
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
index 33830fc..37260ee 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1043,7 +1043,7 @@
  */
 static void
 add_route_connected_v6_net(struct tuntap *tt,
-                           const struct env_set *es)
+                           const struct env_set *es, const bool is_multipo=
int)
 {
     struct route_ipv6 r6;
=20
@@ -1053,11 +1053,11 @@
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

@@ -1068,7 +1068,7 @@
     r6.metric  =3D 0;                     /* connected route */
     r6.flags   =3D RT_DEFINED | RT_ADDED | RT_METRIC_DEFINED;
     route_ipv6_clear_host_bits(&r6);
-    delete_route_ipv6(&r6, tt, 0, NULL, NULL);
+    delete_route_ipv6(&r6, tt, 0, NULL, NULL, is_multipoint);
 }
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_N=
ETBSD) || defined(TARGET_OPENBSD) */

@@ -1110,7 +1110,8 @@
  */
 static void
 do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
-                 const struct env_set *es, openvpn_net_ctx_t *ctx)
+                 const struct env_set *es, openvpn_net_ctx_t *ctx,
+                 const bool is_multipoint)
 {
 #if !defined(TARGET_LINUX)
     struct argv argv =3D argv_new();
@@ -1249,7 +1250,7 @@
         do_address_service(true, AF_INET6, tt);
         if (tt->type =3D=3D DEV_TYPE_TUN)
         {
-            add_route_connected_v6_net(tt, es);
+            add_route_connected_v6_net(tt, es, is_multipoint);
         }
         do_dns_service(true, AF_INET6, tt);
         do_set_mtu_service(tt, AF_INET6, tun_mtu);
@@ -1277,7 +1278,7 @@
         netsh_command(&argv, 4, M_FATAL);
         if (tt->type =3D=3D DEV_TYPE_TUN)
         {
-            add_route_connected_v6_net(tt, es);
+            add_route_connected_v6_net(tt, es, is_multipoint);
         }
         /* set ipv6 dns servers if any are specified */
         netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, tt-=
>adapter_index);
@@ -1309,7 +1310,7 @@
  */
 static void
 do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
-                 const struct env_set *es, openvpn_net_ctx_t *ctx)
+                 const struct env_set *es, openvpn_net_ctx_t *ctx, const b=
ool is_multipoint)
 {
 #if !defined(_WIN32) && !defined(TARGET_ANDROID)
     /*
@@ -1414,7 +1415,7 @@
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D tt->local;
         r.metric =3D 0;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_OPENBSD)
@@ -1461,7 +1462,7 @@
         r.network =3D tt->local & tt->remote_netmask;
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D remote_end;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_NETBSD)
@@ -1503,7 +1504,7 @@
         r.network =3D tt->local & tt->remote_netmask;
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D remote_end;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_DARWIN)
@@ -1550,7 +1551,7 @@
         r.network =3D tt->local & tt->remote_netmask;
         r.netmask =3D tt->remote_netmask;
         r.gateway =3D tt->local;
-        add_route(&r, tt, 0, NULL, es, NULL);
+        add_route(&r, tt, 0, NULL, es, NULL, is_multipoint);
     }

 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
@@ -1651,7 +1652,7 @@
 /* execute the ifconfig command through the shell */
 void
 do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
-            const struct env_set *es, openvpn_net_ctx_t *ctx)
+            const struct env_set *es, openvpn_net_ctx_t *ctx, const bool i=
s_multipoint)
 {
     msg(D_LOW, "do_ifconfig, ipv4=3D%d, ipv6=3D%d", tt->did_ifconfig_setup,
         tt->did_ifconfig_ipv6_setup);
@@ -1671,12 +1672,12 @@

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
@@ -2127,12 +2128,13 @@
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
@@ -2289,7 +2291,8 @@
 void
 tuncfg(const char *dev, const char *dev_type, const char *dev_node,
        int persist_mode, const char *username, const char *groupname,
-       const struct tuntap_options *options, openvpn_net_ctx_t *ctx)
+       const struct tuntap_options *options, openvpn_net_ctx_t *ctx,
+       const bool is_multipoint)
 {
     struct tuntap *tt;

@@ -2329,14 +2332,14 @@
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

@@ -2348,6 +2351,7 @@
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
=20
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
=20
 int
@@ -3398,7 +3410,7 @@
 }

 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -3420,6 +3432,7 @@
     free(tt);
     argv_free(&argv);
     gc_free(&gc);
+    (void)is_multipoint;
 }

 int
@@ -3541,7 +3554,7 @@
 /* tap devices need to be manually destroyed on AIX
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -3569,6 +3582,7 @@
     free(tt);
     env_set_destroy(es);
     argv_free(&argv);
+    (void)is_multipoint;
 }

 int
@@ -6850,7 +6864,7 @@
 }

 static void
-netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_are=
na *gc)
+netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_are=
na *gc, const bool is_multipoint)
 {
     const char *ifconfig_ip_local;
     struct argv argv =3D argv_new();
@@ -6880,7 +6894,7 @@

     if (ipv6 && tt->type =3D=3D DEV_TYPE_TUN)
     {
-        delete_route_connected_v6_net(tt);
+        delete_route_connected_v6_net(tt, is_multipoint);
     }

     /* "store=3Dactive" is needed in Windows 8(.1) to delete the
@@ -6950,7 +6964,7 @@
 }

 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipo=
int)
 {
     ASSERT(tt);

@@ -6970,7 +6984,7 @@
                 do_dns_domain_service(false, tt);
             }
             do_dns_service(false, AF_INET6, tt);
-            delete_route_connected_v6_net(tt);
+            delete_route_connected_v6_net(tt, is_multipoint);
             do_address_service(false, AF_INET6, tt);
         }
         else
@@ -6980,7 +6994,7 @@
                 do_dns_domain_wmic(false, tt);
             }

-            netsh_delete_address_dns(tt, true, &gc);
+            netsh_delete_address_dns(tt, true, &gc, is_multipoint);
         }
     }

@@ -7007,7 +7021,7 @@

             if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
             {
-                netsh_delete_address_dns(tt, false, &gc);
+                netsh_delete_address_dns(tt, false, &gc, is_multipoint);
             }
         }
     }
@@ -7109,12 +7123,13 @@
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
index ccba0bc..4f502cd 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -282,7 +282,7 @@
 void open_tun(const char *dev, const char *dev_type, const char *dev_node,
               struct tuntap *tt, openvpn_net_ctx_t *ctx);

-void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_mu=
ltipoint);

 void tun_open_device(struct tuntap *tt, const char *dev_node,
                      const char **device_guid, struct gc_arena *gc);
@@ -296,7 +296,7 @@
 void tuncfg(const char *dev, const char *dev_type, const char *dev_node,
             int persist_mode, const char *username,
             const char *groupname, const struct tuntap_options *options,
-            openvpn_net_ctx_t *ctx);
+            openvpn_net_ctx_t *ctx, const bool is_multipoint);

 const char *guess_tuntap_dev(const char *dev,
                              const char *dev_type,
@@ -335,7 +335,7 @@
  * @param ctx       the networking API opaque context
  */
 void do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
-                 const struct env_set *es, openvpn_net_ctx_t *ctx);
+                 const struct env_set *es, openvpn_net_ctx_t *ctx, const b=
ool is_multipoint);

 /**
  * undo_ifconfig - undo configuration of the tunnel interface
@@ -781,6 +781,7 @@
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
Gerrit-PatchSet: 11
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--fHjypya2p+I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #11</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">route: extended logic to omit gateway when unnecessary<br><br>    Extrac=
ted and extended the logic behind &#39;gateway_needed&#39; both in<br>    a=
dd_route() and add_route_ipv6(). Other than checking the dev-type,<br>    s=
pecial routes and if the gateway is on-link,<br>    - set gateway_needed to=
 true if the vpn instance is a multipoint server<br>      and DCO is enable=
d.<br>    - set gateway_needed to false if the gateway is in the vpn subnet=
.<br>    Additionally, extended support for these checks and conditions to =
DARWIN<br>    and BSD-based operating systems.<br><br>    These changes ens=
ure that the gateway is only included when necessary,<br>    optimizing rou=
te configuration and potentially reducing redundant route entries.<br><br>C=
hange-Id: I87777e74b1fd34781e1d72c9f994eb84f39d800c<br>Signed-off-by: Marco=
 Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/=
openvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn/route.c<br>M src/op=
envpn/route.h<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>7 files chan=
ged, 420 insertions(+), 253 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/21/721/11</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/forward.c b/src/openvpn/forward.c</span><br><span>index f3f3503..73524=
18 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b=
/src/openvpn/forward.c</span><br><span>@@ -427,7 +427,7 @@</span><br><span>=
 check_add_routes_action(struct context *c, const bool errors)</span><br><s=
pan> {</span><br><span>     bool route_status =3D do_route(&amp;c-&gt;optio=
ns, c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                 c-&gt;c1.tunt=
ap, c-&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                 c-&gt;c1=
.tuntap, c-&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D =
CM_TOP);</span><br><span> </span><br><span>     int flags =3D (errors ? ISC=
_ERRORS : 0);</span><br><span>     flags |=3D (!route_status ? ISC_ROUTE_ER=
RORS : 0);</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/in=
it.c</span><br><span>index 4014517..280a9b9 100644</span><br><span>--- a/sr=
c/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@=
@ -1152,7 +1152,7 @@</span><br><span>     tuncfg(options-&gt;dev, options-&=
gt;dev_type, options-&gt;dev_node,</span><br><span>            options-&gt;=
persist_mode,</span><br><span>            options-&gt;username, options-&gt=
;groupname, &amp;options-&gt;tuntap_options,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-           ctx);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+           ctx, options-&gt;mode =3D=3D MODE_SERVER);</=
span><br><span>     if (options-&gt;persist_mode &amp;&amp; options-&gt;lla=
ddr)</span><br><span>     {</span><br><span>         set_lladdr(ctx, option=
s-&gt;dev, options-&gt;lladdr, NULL);</span><br><span>@@ -1719,13 +1719,14 =
@@</span><br><span>          const struct tuntap *tt,</span><br><span>     =
     const struct plugin_list *plugins,</span><br><span>          struct en=
v_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         op=
envpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         const bool is_multipoint)</span><br><span> {</span>=
<br><span>     bool ret =3D true;</span><br><span>     if (!route_noexec_en=
abled(options, tt) &amp;&amp; ( route_list || route_ipv6_list ) )</span><br=
><span>     {</span><br><span>         ret =3D add_routes(route_list, route=
_ipv6_list, tt, ROUTE_OPTION_FLAGS(options),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                         es, ctx);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                         es, ctx, is_=
multipoint);</span><br><span>         setenv_int(es, &quot;redirect_gateway=
&quot;, route_did_redirect_default_gateway(route_list));</span><br><span>  =
   }</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>@@ -1987,7 +=
1988,7 @@</span><br><span>                                                 =
 c-&gt;options.dev_type,</span><br><span>                                  =
                c-&gt;options.dev_node,</span><br><span>                   =
                               &amp;gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            do_ifconfig(c-&gt;c1.tuntap, guess, c-&gt;c2=
.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            do_ifconfig(c-&gt;c1.tuntap, gues=
s, c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=
=3D CM_TOP);</span><br><span>         }</span><br><span> </span><br><span> =
        /* possibly add routes */</span><br><span>@@ -1995,7 +1996,7 @@</sp=
an><br><span>         {</span><br><span>             /* Ignore route_delay,=
 would cause ROUTE_BEFORE_TUN to be ignored */</span><br><span>            =
 bool status =3D do_route(&amp;c-&gt;options, c-&gt;c1.route_list, c-&gt;c1=
.route_ipv6_list,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                               c-&gt;c1.tuntap, c-&gt;plugins, c-&gt;c2.es,=
 &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                   c-&gt;c1.tuntap, c-&gt;plugins, c-&gt;=
c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D CM_TOP);</span><br><span>     =
        *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);</span><br><span>=
         }</span><br><span> #ifdef TARGET_ANDROID</span><br><span>@@ -2022,=
7 +2023,7 @@</span><br><span>             &amp;&amp; ifconfig_order(c-&gt;c=
1.tuntap) =3D=3D IFCONFIG_AFTER_TUN_OPEN)</span><br><span>         {</span>=
<br><span>             do_ifconfig(c-&gt;c1.tuntap, c-&gt;c1.tuntap-&gt;act=
ual_name,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                        c=
-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D C=
M_TOP);</span><br><span>         }</span><br><span> </span><br><span>      =
   /* run the up script */</span><br><span>@@ -2048,7 +2049,7 @@</span><br>=
<span>         if ((route_order(c-&gt;c1.tuntap) =3D=3D ROUTE_AFTER_TUN) &a=
mp;&amp; (!c-&gt;options.route_delay_defined))</span><br><span>         {</=
span><br><span>             int status =3D do_route(&amp;c-&gt;options, c-&=
gt;c1.route_list, c-&gt;c1.route_ipv6_list,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                  c-&gt;c1.tuntap, c-=
&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                  c-&gt;c1.tunta=
p, c-&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D CM_TOP=
);</span><br><span>             *error_flags |=3D (status ? 0 : ISC_ROUTE_E=
RRORS);</span><br><span>         }</span><br><span> </span><br><span>@@ -21=
16,7 +2117,7 @@</span><br><span>         }</span><br><span>         else</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            close_tun(c-&gt;c1.tuntap, &amp;c-&gt;net_ctx);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            close_tun(c-&gt;c1.t=
untap, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D CM_TOP);</span><br><span>     =
    }</span><br><span>         c-&gt;c1.tuntap =3D NULL;</span><br><span>  =
   }</span><br><span>@@ -2186,7 +2187,7 @@</span><br><span> </span><br><spa=
n>             delete_routes(c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,=
</span><br><span>                           c-&gt;c1.tuntap, ROUTE_OPTION_F=
LAGS(&amp;c-&gt;options),</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                          c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                          c-&gt=
;c2.es, &amp;c-&gt;net_ctx, c-&gt;mode =3D=3D CM_TOP);</span><br><span>    =
     }</span><br><span> </span><br><span>         /* actually close tun/tap=
 device based on --down-pre flag */</span><br><span>diff --git a/src/openvp=
n/init.h b/src/openvpn/init.h</span><br><span>index 11c32ac..f841402 100644=
</span><br><span>--- a/src/openvpn/init.h</span><br><span>+++ b/src/openvpn=
/init.h</span><br><span>@@ -74,7 +74,7 @@</span><br><span> bool do_route(co=
nst struct options *options, struct route_list *route_list,</span><br><span=
>               struct route_ipv6_list *route_ipv6_list, const struct tunta=
p *tt,</span><br><span>               const struct plugin_list *plugins, st=
ruct env_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
          openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+              openvpn_net_ctx_t *ctx, const bool is_multipoi=
nt);</span><br><span> </span><br><span> void close_instance(struct context =
*c);</span><br><span> </span><br><span>diff --git a/src/openvpn/route.c b/s=
rc/openvpn/route.c</span><br><span>index e9de795..1b419f8 100644</span><br>=
<span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</=
span><br><span>@@ -77,7 +77,7 @@</span><br><span> </span><br><span> static =
void delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned i=
nt flags,</span><br><span>                          const struct route_gate=
way_info *rgi, const struct env_set *es,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                         openvpn_net_ctx_t *ctx);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                         o=
penvpn_net_ctx_t *ctx, const bool is_multipoint);</span><br><span> </span><=
br><span> static void get_bypass_addresses(struct route_bypass *rb, const u=
nsigned int flags);</span><br><span> </span><br><span>@@ -927,7 +927,8 @@</=
span><br><span>            unsigned int flags,</span><br><span>            =
const struct route_gateway_info *rgi,</span><br><span>            const str=
uct env_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
      openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+           openvpn_net_ctx_t *ctx,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+           const bool is_multipoint)</span><br><sp=
an> {</span><br><span>     struct route_ipv4 r;</span><br><span>     CLEAR(=
r);</span><br><span>@@ -935,7 +936,7 @@</span><br><span>     r.network =3D =
network;</span><br><span>     r.netmask =3D netmask;</span><br><span>     r=
.gateway =3D gateway;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return add_route(&amp;r, tt, flags, rgi, es, ctx);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return add_route(&amp;r, tt, flags, =
rgi, es, ctx, is_multipoint);</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br><span>@@ -946,7 +947,8 @@</span><br><span>  =
          unsigned int flags,</span><br><span>            const struct rout=
e_gateway_info *rgi,</span><br><span>            const struct env_set *es,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-           openvpn_net=
_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
    openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+           const bool is_multipoint)</span><br><span> {</span><br><=
span>     struct route_ipv4 r;</span><br><span>     CLEAR(r);</span><br><sp=
an>@@ -954,7 +956,7 @@</span><br><span>     r.network =3D network;</span><b=
r><span>     r.netmask =3D netmask;</span><br><span>     r.gateway =3D gate=
way;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    delete_route(=
&amp;r, tt, flags, rgi, es, ctx);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    delete_route(&amp;r, tt, flags, rgi, es, ctx, is_multipoi=
nt);</span><br><span> }</span><br><span> </span><br><span> static bool</spa=
n><br><span>@@ -964,7 +966,8 @@</span><br><span>                   unsigned=
 int flags,</span><br><span>                   const struct route_gateway_i=
nfo *rgi,</span><br><span>                   const struct env_set *es,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                  openvpn_=
net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
              openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                  const bool is_multipoint)</span><br><sp=
an> {</span><br><span>     int ret =3D true;</span><br><span>     for (int =
i =3D 0; i &lt; rb-&gt;n_bypass; ++i)</span><br><span>@@ -972,7 +975,7 @@</=
span><br><span>         if (rb-&gt;bypass[i])</span><br><span>         {</s=
pan><br><span>             ret =3D add_route3(rb-&gt;bypass[i], IPV4_NETMAS=
K_HOST, gateway, tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                            flags | ROUTE_REF_GW, rgi, es, ctx) &amp;&amp; =
ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
              flags | ROUTE_REF_GW, rgi, es, ctx, is_multipoint) &amp;&amp;=
 ret;</span><br><span>         }</span><br><span>     }</span><br><span>   =
  return ret;</span><br><span>@@ -985,7 +988,8 @@</span><br><span>         =
          unsigned int flags,</span><br><span>                   const stru=
ct route_gateway_info *rgi,</span><br><span>                   const struct=
 env_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
          openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                  openvpn_net_ctx_t *ctx,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                  const bool is_multipo=
int)</span><br><span> {</span><br><span>     int i;</span><br><span>     fo=
r (i =3D 0; i &lt; rb-&gt;n_bypass; ++i)</span><br><span>@@ -999,7 +1003,8 =
@@</span><br><span>                        flags | ROUTE_REF_GW,</span><br>=
<span>                        rgi,</span><br><span>                        =
es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
     ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                      is_multipoint);</span><br><span>         }</span><br>=
<span>     }</span><br><span> }</span><br><span>@@ -1007,7 +1012,7 @@</span=
><br><span> static bool</span><br><span> redirect_default_route_to_vpn(stru=
ct route_list *rl, const struct tuntap *tt,</span><br><span>               =
                unsigned int flags, const struct env_set *es,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                              openv=
pn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                             openvpn_net_ctx_t *ctx, const bool is_multipoi=
nt)</span><br><span> {</span><br><span>     const char err[] =3D &quot;NOTE=
: unable to redirect IPv4 default gateway --&quot;;</span><br><span>     bo=
ol ret =3D true;</span><br><span>@@ -1059,7 +1064,7 @@</span><br><span>    =
             {</span><br><span>                     ret =3D add_route3(rl-&=
gt;spec.remote_host, IPV4_NETMASK_HOST,</span><br><span>                   =
                   rl-&gt;rgi.gateway.addr, tt, flags | ROUTE_REF_GW,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
          &amp;rl-&gt;rgi, es, ctx);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                     &amp;rl-&gt;rgi, es, =
ctx, is_multipoint);</span><br><span>                     if (ret)</span><b=
r><span>                     {</span><br><span>                         rl-=
&gt;iflags |=3D RL_DID_LOCAL;</span><br><span>@@ -1074,7 +1079,7 @@</span><=
br><span> </span><br><span>             /* route DHCP/DNS server traffic th=
rough original default gateway */</span><br><span>             ret =3D add_=
bypass_routes(&amp;rl-&gt;spec.bypass, rl-&gt;rgi.gateway.addr, tt, flags,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
              &amp;rl-&gt;rgi, es, ctx) &amp;&amp; ret;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                    &am=
p;rl-&gt;rgi, es, ctx, is_multipoint) &amp;&amp; ret;</span><br><span> </sp=
an><br><span>             if (rl-&gt;flags &amp; RG_REROUTE_GW)</span><br><=
span>             {</span><br><span>@@ -1082,11 +1087,11 @@</span><br><span=
>                 {</span><br><span>                     /* add new default=
 route (1st component) */</span><br><span>                     ret =3D add_=
route3(0x00000000, 0x80000000, rl-&gt;spec.remote_endpoint,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
tt, flags, &amp;rl-&gt;rgi, es, ctx) &amp;&amp; ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                     tt, =
flags, &amp;rl-&gt;rgi, es, ctx, is_multipoint) &amp;&amp; ret;</span><br><=
span> </span><br><span>                     /* add new default route (2nd c=
omponent) */</span><br><span>                     ret =3D add_route3(0x8000=
0000, 0x80000000, rl-&gt;spec.remote_endpoint,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                     tt, flags, &a=
mp;rl-&gt;rgi, es, ctx) &amp;&amp; ret;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                     tt, flags, &amp;rl=
-&gt;rgi, es, ctx, is_multipoint) &amp;&amp; ret;</span><br><span>         =
        }</span><br><span>                 else</span><br><span>           =
      {</span><br><span>@@ -1095,12 +1100,12 @@</span><br><span>           =
          {</span><br><span>                         /* delete default rout=
e */</span><br><span>                         del_route3(0, 0, rl-&gt;rgi.g=
ateway.addr, tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                              flags | ROUTE_REF_GW, &amp;rl-&gt;rgi, es, ct=
x);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                   flags | ROUTE_REF_GW, &amp;rl-&gt;rgi, es, ctx, is_multi=
point);</span><br><span>                     }</span><br><span> </span><br>=
<span>                     /* add new default route */</span><br><span>    =
                 ret =3D add_route3(0, 0, rl-&gt;spec.remote_endpoint, tt,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
               flags, &amp;rl-&gt;rgi, es, ctx) &amp;&amp; ret;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
      flags, &amp;rl-&gt;rgi, es, ctx, is_multipoint) &amp;&amp; ret;</span=
><br><span>                 }</span><br><span>             }</span><br><spa=
n> </span><br><span>@@ -1115,7 +1120,8 @@</span><br><span> undo_redirect_de=
fault_route_to_vpn(struct route_list *rl,</span><br><span>                 =
                   const struct tuntap *tt, unsigned int flags,</span><br><=
span>                                    const struct env_set *es,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
     openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                   openvpn_net_ctx_t *ctx,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
        const bool is_multipoint)</span><br><span> {</span><br><span>     i=
f (rl &amp;&amp; rl-&gt;iflags &amp; RL_DID_REDIRECT_DEFAULT_GATEWAY)</span=
><br><span>     {</span><br><span>@@ -1129,13 +1135,14 @@</span><br><span> =
                       flags | ROUTE_REF_GW,</span><br><span>              =
          &amp;rl-&gt;rgi,</span><br><span>                        es,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                       ctx=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
      ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              is_multipoint);</span><br><span>             rl-&gt;iflags &a=
mp;=3D ~RL_DID_LOCAL;</span><br><span>         }</span><br><span> </span><b=
r><span>         /* delete special DHCP/DNS bypass route */</span><br><span=
>         del_bypass_routes(&amp;rl-&gt;spec.bypass, rl-&gt;rgi.gateway.add=
r, tt, flags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                  &amp;rl-&gt;rgi, es, ctx);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                          &amp;rl-&gt;rgi, es, ctx=
, is_multipoint);</span><br><span> </span><br><span>         if (rl-&gt;fla=
gs &amp; RG_REROUTE_GW)</span><br><span>         {</span><br><span>@@ -1149=
,7 +1156,8 @@</span><br><span>                            flags,</span><br>=
<span>                            &amp;rl-&gt;rgi,</span><br><span>        =
                    es,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                           ctx);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                           ctx,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                           is_multipoint);</span=
><br><span> </span><br><span>                 /* delete default route (2nd =
component) */</span><br><span>                 del_route3(0x80000000,</span=
><br><span>@@ -1159,7 +1167,8 @@</span><br><span>                          =
  flags,</span><br><span>                            &amp;rl-&gt;rgi,</span=
><br><span>                            es,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                           ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           ctx,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                           is=
_multipoint);</span><br><span>             }</span><br><span>             e=
lse</span><br><span>             {</span><br><span>@@ -1171,12 +1180,13 @@<=
/span><br><span>                            flags,</span><br><span>        =
                    &amp;rl-&gt;rgi,</span><br><span>                      =
      es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
               ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                           ctx,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                           is_multipoint);</span><br><span>   =
              /* restore original default route if there was any */</span><=
br><span>                 if (rl-&gt;rgi.flags &amp; RGI_ADDR_DEFINED)</spa=
n><br><span>                 {</span><br><span>                     add_rou=
te3(0, 0, rl-&gt;rgi.gateway.addr, tt,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                               flags | ROUTE_REF_GW, &amp;=
rl-&gt;rgi, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                               flags | ROUTE_REF_GW, &amp;rl-&gt;rgi, es,=
 ctx, is_multipoint);</span><br><span>                 }</span><br><span>  =
           }</span><br><span>         }</span><br><span>@@ -1188,9 +1198,10=
 @@</span><br><span> bool</span><br><span> add_routes(struct route_list *rl=
, struct route_ipv6_list *rl6,</span><br><span>            const struct tun=
tap *tt, unsigned int flags,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-           const struct env_set *es, openvpn_net_ctx_t *ctx)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+           const struct env=
_set *es, openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+           const bool is_multipoint)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D redirect_d=
efault_route_to_vpn(rl, tt, flags, es, ctx);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool ret =3D redirect_default_route_to_vpn(rl,=
 tt, flags, es, ctx, is_multipoint);</span><br><span>     if (rl &amp;&amp;=
 !(rl-&gt;iflags &amp; RL_ROUTES_ADDED) )</span><br><span>     {</span><br>=
<span>         struct route_ipv4 *r;</span><br><span>@@ -1221,9 +1232,9 @@<=
/span><br><span>             check_subnet_conflict(r-&gt;network, r-&gt;net=
mask, &quot;route&quot;);</span><br><span>             if (flags &amp; ROUT=
E_DELETE_FIRST)</span><br><span>             {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                delete_route(r, tt, flags, &amp;rl=
-&gt;rgi, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                delete_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx, is_mul=
tipoint);</span><br><span>             }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            ret =3D add_route(r, tt, flags, &amp;rl-&gt;=
rgi, es, ctx) &amp;&amp; ret;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            ret =3D add_route(r, tt, flags, &amp;rl-&gt;rgi, es, =
ctx, is_multipoint) &amp;&amp; ret;</span><br><span>         }</span><br><s=
pan>         rl-&gt;iflags |=3D RL_ROUTES_ADDED;</span><br><span>     }</sp=
an><br><span>@@ -1243,9 +1254,9 @@</span><br><span>         {</span><br><sp=
an>             if (flags &amp; ROUTE_DELETE_FIRST)</span><br><span>       =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  delete_route_ipv6(r, tt, flags, es, ctx);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                delete_route_ipv6(r, tt, flags, es,=
 ctx, is_multipoint);</span><br><span>             }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ret =3D add_route_ipv6(r, tt, f=
lags, es, ctx) &amp;&amp; ret;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            ret =3D add_route_ipv6(r, tt, flags, es, ctx, is_mul=
tipoint) &amp;&amp; ret;</span><br><span>         }</span><br><span>       =
  rl6-&gt;iflags |=3D RL_ROUTES_ADDED;</span><br><span>     }</span><br><sp=
an>@@ -1256,19 +1267,20 @@</span><br><span> void</span><br><span> delete_ro=
utes(struct route_list *rl, struct route_ipv6_list *rl6,</span><br><span>  =
             const struct tuntap *tt, unsigned int flags,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-              const struct env_set *es,=
 openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+              const struct env_set *es, openvpn_net_ctx_t *ctx,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+              const bool i=
s_multipoint)</span><br><span> {</span><br><span>     if (rl &amp;&amp; rl-=
&gt;iflags &amp; RL_ROUTES_ADDED)</span><br><span>     {</span><br><span>  =
       struct route_ipv4 *r;</span><br><span>         for (r =3D rl-&gt;rou=
tes; r; r =3D r-&gt;next)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            delete_route(r, tt, flags, &amp=
;rl-&gt;rgi, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            delete_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx, is_mult=
ipoint);</span><br><span>         }</span><br><span>         rl-&gt;iflags =
&amp;=3D ~RL_ROUTES_ADDED;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    undo_redirect_default_rou=
te_to_vpn(rl, tt, flags, es, ctx);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    undo_redirect_default_route_to_vpn(rl, tt, flags, es, ct=
x, is_multipoint);</span><br><span> </span><br><span>     if (rl)</span><br=
><span>     {</span><br><span>@@ -1280,7 +1292,7 @@</span><br><span>       =
  struct route_ipv6 *r6;</span><br><span>         for (r6 =3D rl6-&gt;route=
s_ipv6; r6; r6 =3D r6-&gt;next)</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            delete_route_ipv6(r6, tt, =
flags, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         delete_route_ipv6(r6, tt, flags, es, ctx, is_multipoint);</span><b=
r><span>         }</span><br><span>         rl6-&gt;iflags &amp;=3D ~RL_ROU=
TES_ADDED;</span><br><span>     }</span><br><span>@@ -1564,13 +1576,48 @@</=
span><br><span> }</span><br><span> #endif</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+is_gateway_needed_ipv4(const struct route=
_ipv4 *r4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              const struct route_gateway_info *rgi,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       const struct tunta=
p *tt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
          const bool is_dco_enabled,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                       const bool is_multipoint)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rgi &am=
p;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEFINED) &amp;&amp; rgi-&gt;iface[0]=
 !=3D 0)  /* vpn server special route */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (rgi-&gt;flags &amp; RGI_ADDR_DEFINED &amp;&amp; r4-&gt;g=
ateway !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret=
urn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt=
-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        &amp;&amp; !( (r4-&gt;flags &amp; RT_METRIC_DEFINED) &amp=
;&amp; r4-&gt;metric =3D=3D 0 ) )</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (is_multipoint &amp;&amp;=
 is_dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> bool</span><br><span> add_route(struct route_ipv4 *=
r,</span><br><span>           const struct tuntap *tt,</span><br><span>    =
       unsigned int flags,</span><br><span>           const struct route_ga=
teway_info *rgi,  /* may be NULL */</span><br><span>           const struct=
 env_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
  openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+          openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          const bool is_multipoint)</span><br><span> {<=
/span><br><span>     int status =3D 0;</span><br><span>     int is_local_ro=
ute;</span><br><span>@@ -1598,21 +1645,7 @@</span><br><span>         goto d=
one;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifndef _WIN32</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEFI=
NED) &amp;&amp; rgi-&gt;iface[0] !=3D 0)  /* vpn server special route */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (rgi-&gt;flags &amp; RGI_ADDR=
_DEFINED &amp;&amp; r-&gt;gateway !=3D 0)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            gateway_needed =3D true;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TAP</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !( (=
r-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp; r-&gt;metric =3D=3D 0 ) )</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        gateway_needed =3D true;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gateway_needed =3D is_gateway_needed_=
ipv4(r, rgi, tt, tt-&gt;backend_driver =3D=3D DRIVER_DCO, is_multipoint);</=
span><br><span> </span><br><span>     if (gateway_needed &amp;&amp; r-&gt;g=
ateway =3D=3D 0)</span><br><span>     {</span><br><span>@@ -1624,18 +1657,2=
1 @@</span><br><span>         goto done;</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TAR=
GET_LINUX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const c=
har *iface =3D tt-&gt;actual_name;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if !defined(_WIN32) &amp;&amp; !defined(TARGET_SOLARIS) \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &amp;&amp; !defin=
ed(TARGET_AIX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *device =3D tt-&gt;actual_name;</span><br><span>     if (!gateway=
_needed &amp;&amp; rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEFINED) &=
amp;&amp; rgi-&gt;iface[0] !=3D 0)  /* vpn server special route */</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 iface =3D rgi-&gt;iface;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        device =3D rgi-&gt;iface;</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</=
span><br><span>     int metric =3D -1;</span><br><span> </span><br><span>  =
   if (is_on_link(is_local_route, flags, rgi))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        iface =3D rgi-&gt;i=
face;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        device=
 =3D rgi-&gt;iface;</span><br><span>     }</span><br><span> </span><br><spa=
n>     if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span>@@ -1646,7 =
+1682,7 @@</span><br><span>     status =3D RTA_SUCCESS;</span><br><span>   =
  int ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_netbits2=
(r-&gt;netmask),</span><br><span>                                gateway_ne=
eded ? &amp;r-&gt;gateway : NULL,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                               iface, 0, metric);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                               de=
vice, 0, metric);</span><br><span>     if (ret =3D=3D -EEXIST)</span><br><s=
pan>     {</span><br><span>         msg(D_ROUTE, &quot;NOTE: Linux route ad=
d command failed because route exists&quot;);</span><br><span>@@ -1663,7 +1=
699,7 @@</span><br><span> </span><br><span>     if (rgi)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        snprintf(=
out, sizeof(out), &quot;%s %s %s dev %s&quot;, network, netmask, gateway, r=
gi-&gt;iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   snprintf(out, sizeof(out), &quot;%s %s %s dev %s&quot;, network, netmask=
, gateway, device);</span><br><span>     }</span><br><span>     else</span>=
<br><span>     {</span><br><span>@@ -1767,9 +1803,9 @@</span><br><span>    =
                                 &quot;ERROR: Solaris route add command fai=
led&quot;);</span><br><span>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#eli=
f defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_print=
f(&amp;argv, &quot;%s add&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    argv_printf(&amp;argv, &quot;%s add &quot;,</span><br><spa=
n>                 ROUTE_PATH);</span><br><span> </span><br><span> #if 0</s=
pan><br><span>@@ -1779,45 +1815,28 @@</span><br><span>     }</span><br><spa=
n> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    network,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    gatewa=
y,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add on-link supp=
ort for FreeBSD */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &a=
mp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret=
 =3D openvpn_execve_check(&amp;argv, es, 0,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                    &quot;ERROR: Free=
BSD route add command failed&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#elif defined(TARGET_DRAGONFLY)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    argv_printf(&amp;argv, &quot;%s add&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                ROUTE_PATH);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (gateway_needed)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat=
(&amp;argv, &quot;-rtt %d&quot;, r-&gt;metric);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-net %=
s %s %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   network,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        gateway,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        netmask);</span><br><span>    =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot=
;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 network,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- ad=
d on-link support for Dragonfly */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ar=
gv_printf_cat(&amp;argv, &quot;-net %s -iface %s&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        network,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        de=
vice);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><sp=
an>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                    &=
quot;ERROR: DragonFly route add command failed&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                    &quo=
t;ERROR: BSD route add command failed&quot;);</span><br><span>     status =
=3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span> #elif=
 defined(TARGET_DARWIN)</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s add&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &=
quot;%s add &quot;,</span><br><span>                 ROUTE_PATH);</span><br=
><span> </span><br><span> #if 0</span><br><span>@@ -1838,10 +1857,19 @@</sp=
an><br><span>     }</span><br><span>     else</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp=
;argv, &quot;-net %s %s %s&quot;,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        network,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        gateway,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                        netmask);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (gateway_needed)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            argv_printf_cat(&=
amp;argv, &quot;-net %s %s %s&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            network,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            gateway,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
    netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            argv_printf_cat(&amp;=
argv, &quot;-net %s -interface %s&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                            network,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                            device);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span>     }</span><br><span> </span><br><span>     argv_msg(D_ROUTE, &amp;=
argv);</span><br><span>@@ -1851,7 +1879,7 @@</span><br><span> </span><br><s=
pan> #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&a=
mp;argv, &quot;%s add&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    argv_printf(&amp;argv, &quot;%s add &quot;,</span><br><span>  =
               ROUTE_PATH);</span><br><span> </span><br><span> #if 0</span>=
<br><span>@@ -1861,12 +1889,20 @@</span><br><span>     }</span><br><span> #=
endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    argv_printf_cat(&amp;argv, &quot;-net %s %s -netmask %s&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    network,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    g=
ateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      netmask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add on-link=
 support for OpenBSD/NetBSD */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (gateway_needed)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        argv_printf_cat(&amp;argv, &quot;-net %s %s -netmask %s&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        netmask);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_ca=
t(&amp;argv, &quot;-net %s -netmask %s -link -iface %s&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        network,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    netmask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 device);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span> </span><br><span>     argv_msg(D_ROUTE, &amp;a=
rgv);</span><br><span>     bool ret =3D openvpn_execve_check(&amp;argv, es,=
 0,</span><br><span>@@ -1945,10 +1981,99 @@</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static inline struct in6_addr</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+netbits_to_netmask_ipv6(const int netbits)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct in6_addr netmask =3D {{{0}}};</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (netbits &gt; 0 &amp;&amp; netbits &lt;=3D=
 128)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const int full_bytes=
 =3D netbits / 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 for (i =3D 0; i &lt; full_bytes; i++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            netmask.s6_addr[i] =3D 0xFF;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (netbits % 8)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            netmask.s6_addr[i] =3D (0xFF &lt;&lt; (8 - (netb=
its % 8)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return netmask;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+is_gateway_in_vpn_sub=
net_ipv6(const struct in6_addr *gateway,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                              const struct in6_addr *v=
pn_subnet,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                     int netbits)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct in6_addr netmask =3D netbits_to_netmask_ipv6(netbits);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 16; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if ((gateway-&gt;s6_addr[i] &amp; netmas=
k.s6_addr[i]) !=3D (vpn_subnet-&gt;s6_addr[i] &amp; netmask.s6_addr[i]))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+is_gateway_needed_ipv6(=
const struct route_ipv6 *r6,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                       const struct tuntap *tt,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                       const char *net=
work,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
         const bool is_dco_enabled,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                       const bool is_multipoint)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (r6-&gt;iface !=3D NULL)   /* VPN server special route */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!IN6_IS_ADDR_UNSPECIFIED(&amp=
;r6-&gt;gateway))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * Filter out routes which are essentially no-ops</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * (not currently done for IPv6)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* On &quot;tun&quot; interface, we never set a gat=
eway if the operating system</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * can do &quot;route to interface&quot; - it does not add val=
ue, as the target</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * dev already fully qualifies the route destination on point-to-point</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * interfaces.   O=
TOH, on &quot;tap&quot; interface, we must always set the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * gateway unless the route is to=
 be an on-link network</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (t=
t-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        &amp;&amp; !( (r6-&gt;flags &amp; RT_METRIC_DEFINED) &am=
p;&amp; r6-&gt;metric =3D=3D 0 ) )</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* if is server and dco ena=
bled, the gateway is needed*/</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (is_multipoint &amp;&amp; is_dco_enabled)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(is_gateway_in_vpn_subnet_ipv6(&amp;r6-&gt;gateway, &amp;tt-&gt;local_ipv6,=
 tt-&gt;netbits_ipv6))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(D_ROUTE, &quot;Ignoring gateway in VPN subnet for route %s/%d&quot;, netwo=
rk, r6-&gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> add_route_=
ipv6(struct route_ipv6 *r6, const struct tuntap *tt,</span><br><span>      =
          unsigned int flags, const struct env_set *es,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-               openvpn_net_ctx_t *ctx)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+               openvpn=
_net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><sp=
an>     int status =3D 0;</span><br><span>     bool gateway_needed =3D fals=
e;</span><br><span>@@ -1961,22 +2086,12 @@</span><br><span>     struct argv=
 argv =3D argv_new();</span><br><span>     struct gc_arena gc =3D gc_new();=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
ndef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
char *device =3D tt-&gt;actual_name;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (r6-&gt;iface !=3D NULL)              /* vpn server s=
pecial route */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        device =3D r6-=
&gt;iface;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(!IN6_IS_ADDR_UNSPECIFIED(&amp;r6-&gt;gateway) )</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            gateway_needed =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>     route_ipv6_clear_host_bits(r6);</span><br><span>     const char =
*network =3D print_in6_addr( r6-&gt;network, 0, &amp;gc);</span><br><span> =
    const char *gateway =3D print_in6_addr( r6-&gt;gateway, 0, &amp;gc);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gateway_needed =3D is_gateway_needed_ipv6(r6, tt, network, tt-&gt;backend_d=
river =3D=3D DRIVER_DCO, is_multipoint);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> #if defined(TARGET_DARWIN)    \</spa=
n><br><span>     || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)   =
 \</span><br><span>     || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD=
)</span><br><span>@@ -1995,6 +2110,15 @@</span><br><span>     }</span><br><=
span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if !defined(_WIN32)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *device =3D tt-&gt;actual_name;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (r6-&gt;iface !=3D NULL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        device =3D r6-&gt;iface;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> #ifndef _WIN32</span><br><span>     msg(D_ROUTE, &=
quot;add_route_ipv6(%s/%d -&gt; %s metric %d) dev %s&quot;,</span><br><span=
>         network, r6-&gt;netbits, gateway, r6-&gt;metric, device );</span>=
<br><span>@@ -2004,23 +2128,6 @@</span><br><span>         r6-&gt;adapter_in=
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
E &quot; needs a gateway &quot;</span><br><span>@@ -2033,6 +2140,7 @@</span=
><br><span> </span><br><span> #if defined(TARGET_LINUX)</span><br><span>   =
  int metric =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     if ((r6-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp=
; (r6-&gt;metric &gt; 0))</span><br><span>     {</span><br><span>         m=
etric =3D r6-&gt;metric;</span><br><span>@@ -2102,7 +2210,7 @@</span><br><s=
pan> </span><br><span> #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAG=
ONFLY)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    argv_printf(&amp;argv, &quot;%s add -inet6 %s/%d&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot=
;%s add -inet6 %s/%d &quot;,</span><br><span>                 ROUTE_PATH,</=
span><br><span>                 network,</span><br><span>                 r=
6-&gt;netbits);</span><br><span>@@ -2123,7 +2231,7 @@</span><br><span> </sp=
an><br><span> #elif defined(TARGET_DARWIN)</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s =
add -inet6 %s -prefixlen %d&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s add -inet6 %s -prefixlen=
 %d &quot;,</span><br><span>                 ROUTE_PATH,</span><br><span>  =
               network, r6-&gt;netbits );</span><br><span> </span><br><span=
>@@ -2141,26 +2249,24 @@</span><br><span>                                  =
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
<br><span> #elif defined(TARGET_AIX)</span><br><span>@@ -2214,7 +2320,8 @@<=
/span><br><span>              unsigned int flags,</span><br><span>         =
     const struct route_gateway_info *rgi,</span><br><span>              co=
nst struct env_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-             openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             openvpn_net_ctx_t *ctx,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+             const bool is_multipoint)<=
/span><br><span> {</span><br><span> #if !defined(TARGET_LINUX)</span><br><s=
pan>     const char *network;</span><br><span>@@ -2229,6 +2336,21 @@</span>=
<br><span> #endif</span><br><span>     int is_local_route;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET=
_DARWIN) || defined(TARGET_LINUX)  \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY=
)    \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    || define=
d(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool gateway_needed =3D is_gateway_needed_ipv4(r, rgi, tt, tt-&gt;=
backend_driver =3D=3D DRIVER_DCO, is_multipoint);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if !defined(TARGET_OPENBSD) &amp;&amp; !defined(TARGET_NETBSD)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *devi=
ce =3D tt-&gt;actual_name;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!gateway_needed &amp;&amp; rgi &amp;&amp; (rgi-&gt;flags &am=
p; RGI_IFACE_DEFINED) &amp;&amp; rgi-&gt;iface[0] !=3D 0)  /* vpn server sp=
ecial route */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        device =3D =
rgi-&gt;iface;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     if ((r-&gt;flags &amp; =
(RT_DEFINED|RT_ADDED)) !=3D (RT_DEFINED|RT_ADDED))</span><br><span>     {</=
span><br><span>         return;</span><br><span>@@ -2255,13 +2377,20 @@</sp=
an><br><span> </span><br><span> #if defined(TARGET_LINUX)</span><br><span> =
    metric =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_on_link(i=
s_local_route, flags, rgi))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  device =3D rgi-&gt;iface;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span>  =
   {</span><br><span>         metric =3D r-&gt;metric;</span><br><span>    =
 }</span><br><span> </span><br><span>     if (net_route_v4_del(ctx, &amp;r-=
&gt;network, netmask_to_netbits2(r-&gt;netmask),</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                         &amp;r-&gt;gateway, NUL=
L, 0, metric) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                         gateway_needed ? &amp;r-&gt;gateway : NULL,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
 device, 0, metric) &lt; 0)</span><br><span>     {</span><br><span>        =
 msg(M_WARN, &quot;ERROR: Linux route delete command failed&quot;);</span><=
br><span>     }</span><br><span>@@ -2320,27 +2449,26 @@</span><br><span>   =
  argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_check(&=
amp;argv, es, 0, &quot;ERROR: Solaris route delete command failed&quot;);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif=
 defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf=
(&amp;argv, &quot;%s delete -net %s %s %s&quot;,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                ROUTE_PATH,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                network,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                gateway,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                netmask);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &qu=
ot;%s delete&quot;, ROUTE_PATH);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (gateway_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_pri=
ntf_cat(&amp;argv, &quot;-net %s %s %s&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                        network,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        gateway,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-net %s=
 -iface %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      network,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        device);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     argv_m=
sg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: FreeBSD route del=
ete command failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TA=
RGET_DRAGONFLY)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, =
&quot;%s delete -net %s %s %s&quot;,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                ROUTE_PATH,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                network,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                gateway,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                netmask);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERR=
OR: DragonFly route delete command failed&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    openvpn_execve_check(&amp;argv, es, 0, &q=
uot;ERROR: BSD route delete command failed&quot;);</span><br><span> </span>=
<br><span> #elif defined(TARGET_DARWIN)</span><br><span> </span><br><span>@=
@ -2354,11 +2482,22 @@</span><br><span>     }</span><br><span>     else</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      argv_printf(&amp;argv, &quot;%s delete -net %s %s %s&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    ROUTE_PATH,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    n=
etwork,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        argv_printf(&amp;argv, &quot;%s delete &quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    ROUTE_PATH);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (gateway_needed)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            argv_printf_cat(&amp;argv, &q=
uot;-net %s %s %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                            network,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                            gateway,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                            netmask)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            argv_printf_cat(&amp;argv, &quot;=
-net %s -interface %s&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                            network,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                            device);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }=
</span><br><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span=
><br><span>@@ -2366,11 +2505,22 @@</span><br><span> </span><br><span> #elif=
 defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &=
quot;%s delete -net %s %s -netmask %s&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                ROUTE_PATH,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                network,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                gateway,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                netmask);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%=
s delete &quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             ROUTE_PATH);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (gatew=
ay_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat=
(&amp;argv, &quot;-net %s %s -netmask %s&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        network,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        gateway,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-net =
%s -netmask %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        network,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        netmask);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     a=
rgv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_check(&amp=
;argv, es, 0, &quot;ERROR: OpenBSD/NetBSD route delete command failed&quot;=
);</span><br><span>@@ -2417,7 +2567,7 @@</span><br><span> void</span><br><s=
pan> delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt=
,</span><br><span>                   unsigned int flags, const struct env_s=
et *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
    openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                  openvpn_net_ctx_t *ctx, const bool is_multipoint)=
</span><br><span> {</span><br><span>     const char *network;</span><br><sp=
an> </span><br><span>@@ -2430,23 +2580,15 @@</span><br><span> #if !defined(=
TARGET_LINUX)</span><br><span>     const char *gateway;</span><br><span> #e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARG=
ET_SOLARIS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool g=
ateway_needed =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(TARGET_DARWIN) || defined(TARGET_LINUX)  \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    || defined(TARGET_FREEBSD) || d=
efined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     const char *device =3D tt-&gt;actual_name;</span=
><br><span>     if (r6-&gt;iface !=3D NULL)              /* vpn server spec=
ial route */</span><br><span>     {</span><br><span>         device =3D r6-=
&gt;iface;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gat=
eway_needed =3D true;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* if we used a gateway on &qu=
ot;add route&quot;, we also need to specify it on</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     * delete, otherwise some OSes will refuse =
to delete the route</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;t=
ype =3D=3D DEV_TYPE_TAP</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        &amp;&amp; !( (r6-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp; r=
6-&gt;metric =3D=3D 0 ) )</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gate=
way_needed =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span> #endif</span><br><span> #endif</span><br><span> </spa=
n><br><span>@@ -2458,6 +2600,16 @@</span><br><span>     gateway =3D print_i=
n6_addr( r6-&gt;gateway, 0, &amp;gc);</span><br><span> #endif</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TAR=
GET_DARWIN) || defined(TARGET_LINUX)  \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGON=
FLY)    \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    || def=
ined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* if we used a gateway on &quot;add route&q=
uot;, we also need to specify it on</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * delete, otherwise some OSes will refuse to delete th=
e route</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool gateway_needed =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gatew=
ay_needed =3D is_gateway_needed_ipv6(r6, tt, network, tt-&gt;backend_driver=
 =3D=3D DRIVER_DCO, is_multipoint);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #if defined(TARGET_DARWIN)    \</span><br><span>     |=
| defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \</span><br><span=
>     || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span>=
@@ -2552,23 +2704,19 @@</span><br><span>     argv_msg(D_ROUTE, &amp;argv);<=
/span><br><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: Ma=
cOS X route delete -inet6 command failed&quot;);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_OPENBSD)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET=
_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delete =
-inet6 %s -prefixlen %d %s&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    argv_printf(&amp;argv, &quot;%s delete -inet6 %s -prefixl=
en %d&quot;,</span><br><span>                 ROUTE_PATH,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                network, r6-&gt;netbits=
, gateway );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         network, r6-&gt;netbits);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (gateway_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_p=
rintf_cat(&amp;argv, &quot;%s&quot;, gateway);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     arg=
v_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: OpenBSD route =
delete -inet6 command failed&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif =
defined(TARGET_NETBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp=
;argv, &quot;%s delete -inet6 %s/%d %s&quot;,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                ROUTE_PATH,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                network, r6-&gt;netbits, ga=
teway );</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_che=
ck(&amp;argv, es, 0, &quot;ERROR: NetBSD route delete -inet6 command failed=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn=
_execve_check(&amp;argv, es, 0, &quot;ERROR: OpenBSD/NetBSD route delete -i=
net6 command failed&quot;);</span><br><span> </span><br><span> #elif define=
d(TARGET_AIX)</span><br><span> </span><br><span>diff --git a/src/openvpn/ro=
ute.h b/src/openvpn/route.h</span><br><span>index 421e7d2..4c3f317 100644</=
span><br><span>--- a/src/openvpn/route.h</span><br><span>+++ b/src/openvpn/=
route.h</span><br><span>@@ -271,13 +271,13 @@</span><br><span> </span><br><=
span> void route_ipv6_clear_host_bits( struct route_ipv6 *r6 );</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool add_route_=
ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, con=
st struct env_set *es, openvpn_net_ctx_t *ctx);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool add_route_ipv6(struct route_ipv6 *r, const=
 struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_n=
et_ctx_t *ctx, const bool is_multipoint);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void delete_route_ipv6(const struct r=
oute_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env=
_set *es, openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void delete_route_ipv6(const struct route_ipv6 *r, const str=
uct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_c=
tx_t *ctx, const bool is_multipoint);</span><br><span> </span><br><span> bo=
ol add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int fl=
ags,</span><br><span>                const struct route_gateway_info *rgi, =
const struct env_set *es,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-               openvpn_net_ctx_t *ctx);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+               openvpn_net_ctx_t *ctx, const bool i=
s_multipoint);</span><br><span> </span><br><span> void add_route_to_option_=
list(struct route_option_list *l,</span><br><span>                         =
      const char *network,</span><br><span>@@ -312,14 +312,16 @@</span><br>=
<span> </span><br><span> bool add_routes(struct route_list *rl, struct rout=
e_ipv6_list *rl6,</span><br><span>                 const struct tuntap *tt,=
 unsigned int flags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               const struct env_set *es, openvpn_net_ctx_t *ctx);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                const struct =
env_set *es, openvpn_net_ctx_t *ctx,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                const bool is_multipoint);</span><br><span=
> </span><br><span> void delete_routes(struct route_list *rl,</span><br><sp=
an>                    struct route_ipv6_list *rl6,</span><br><span>       =
             const struct tuntap *tt,</span><br><span>                    u=
nsigned int flags,</span><br><span>                    const struct env_set=
 *es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
   openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                   openvpn_net_ctx_t *ctx,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                   const bool is_multipoint)=
;</span><br><span> </span><br><span> void setenv_routes(struct env_set *es,=
 const struct route_list *rl);</span><br><span> </span><br><span>diff --git=
 a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 33830fc..372=
60ee 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/s=
rc/openvpn/tun.c</span><br><span>@@ -1043,7 +1043,7 @@</span><br><span>  */=
</span><br><span> static void</span><br><span> add_route_connected_v6_net(s=
truct tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                       const struct env_set *es)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                           const struct env_se=
t *es, const bool is_multipoint)</span><br><span> {</span><br><span>     st=
ruct route_ipv6 r6;</span><br><span> </span><br><span>@@ -1053,11 +1053,11 =
@@</span><br><span>     r6.gateway =3D tt-&gt;local_ipv6;</span><br><span> =
    r6.metric  =3D 0;                     /* connected route */</span><br><=
span>     r6.flags   =3D RT_DEFINED | RT_METRIC_DEFINED;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    add_route_ipv6(&amp;r6, tt, 0, es, N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_route_=
ipv6(&amp;r6, tt, 0, es, NULL, is_multipoint);</span><br><span> }</span><br=
><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-delete_route_connected_v6_net(const struct tuntap *tt)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+delete_route_connected_v6_net(c=
onst struct tuntap *tt, const bool is_multipoint)</span><br><span> {</span>=
<br><span>     struct route_ipv6 r6;</span><br><span> </span><br><span>@@ -=
1068,7 +1068,7 @@</span><br><span>     r6.metric  =3D 0;                   =
  /* connected route */</span><br><span>     r6.flags   =3D RT_DEFINED | RT=
_ADDED | RT_METRIC_DEFINED;</span><br><span>     route_ipv6_clear_host_bits=
(&amp;r6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    delete_=
route_ipv6(&amp;r6, tt, 0, NULL, NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    delete_route_ipv6(&amp;r6, tt, 0, NULL, NULL, is_mu=
ltipoint);</span><br><span> }</span><br><span> #endif /* if defined(_WIN32)=
 || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPEN=
BSD) */</span><br><span> </span><br><span>@@ -1110,7 +1110,8 @@</span><br><=
span>  */</span><br><span> static void</span><br><span> do_ifconfig_ipv6(st=
ruct tuntap *tt, const char *ifname, int tun_mtu,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                 const struct env_set *es, open=
vpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 const struct env_set *es, openvpn_net_ctx_t *ctx,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                 const bool =
is_multipoint)</span><br><span> {</span><br><span> #if !defined(TARGET_LINU=
X)</span><br><span>     struct argv argv =3D argv_new();</span><br><span>@@=
 -1249,7 +1250,7 @@</span><br><span>         do_address_service(true, AF_IN=
ET6, tt);</span><br><span>         if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            add_route_connected_v6_net(tt, es);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            add_route_connected_v6_net(tt, es=
, is_multipoint);</span><br><span>         }</span><br><span>         do_dn=
s_service(true, AF_INET6, tt);</span><br><span>         do_set_mtu_service(=
tt, AF_INET6, tun_mtu);</span><br><span>@@ -1277,7 +1278,7 @@</span><br><sp=
an>         netsh_command(&amp;argv, 4, M_FATAL);</span><br><span>         =
if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            add_route_connected_v=
6_net(tt, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       add_route_connected_v6_net(tt, es, is_multipoint);</span><br><span> =
        }</span><br><span>         /* set ipv6 dns servers if any are speci=
fied */</span><br><span>         netsh_set_dns6_servers(tt-&gt;options.dns6=
, tt-&gt;options.dns6_len, tt-&gt;adapter_index);</span><br><span>@@ -1309,=
7 +1310,7 @@</span><br><span>  */</span><br><span> static void</span><br><s=
pan> do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 const =
struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 const struct env_set *es, openvpn_=
net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><spa=
n> #if !defined(_WIN32) &amp;&amp; !defined(TARGET_ANDROID)</span><br><span=
>     /*</span><br><span>@@ -1414,7 +1415,7 @@</span><br><span>         r.n=
etmask =3D tt-&gt;remote_netmask;</span><br><span>         r.gateway =3D tt=
-&gt;local;</span><br><span>         r.metric =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        add_route(&amp;r, tt, 0, NULL, es, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_r=
oute(&amp;r, tt, 0, NULL, es, NULL, is_multipoint);</span><br><span>     }<=
/span><br><span> </span><br><span> #elif defined(TARGET_OPENBSD)</span><br>=
<span>@@ -1461,7 +1462,7 @@</span><br><span>         r.network =3D tt-&gt;l=
ocal &amp; tt-&gt;remote_netmask;</span><br><span>         r.netmask =3D tt=
-&gt;remote_netmask;</span><br><span>         r.gateway =3D remote_end;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        add_route(&amp;r,=
 tt, 0, NULL, es, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        add_route(&amp;r, tt, 0, NULL, es, NULL, is_multipoint);</span=
><br><span>     }</span><br><span> </span><br><span> #elif defined(TARGET_N=
ETBSD)</span><br><span>@@ -1503,7 +1504,7 @@</span><br><span>         r.net=
work =3D tt-&gt;local &amp; tt-&gt;remote_netmask;</span><br><span>        =
 r.netmask =3D tt-&gt;remote_netmask;</span><br><span>         r.gateway =
=3D remote_end;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  add_route(&amp;r, tt, 0, NULL, es, NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        add_route(&amp;r, tt, 0, NULL, es, NULL, is=
_multipoint);</span><br><span>     }</span><br><span> </span><br><span> #el=
if defined(TARGET_DARWIN)</span><br><span>@@ -1550,7 +1551,7 @@</span><br><=
span>         r.network =3D tt-&gt;local &amp; tt-&gt;remote_netmask;</span=
><br><span>         r.netmask =3D tt-&gt;remote_netmask;</span><br><span>  =
       r.gateway =3D tt-&gt;local;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        add_route(&amp;r, tt, 0, NULL, es, NULL);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        add_route(&amp;r, tt, 0,=
 NULL, es, NULL, is_multipoint);</span><br><span>     }</span><br><span> </=
span><br><span> #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)<=
/span><br><span>@@ -1651,7 +1652,7 @@</span><br><span> /* execute the ifcon=
fig command through the shell */</span><br><span> void</span><br><span> do_=
ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            const struct env_set *es=
, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            const struct env_set *es, openvpn_net_ctx_t *ctx, const b=
ool is_multipoint)</span><br><span> {</span><br><span>     msg(D_LOW, &quot=
;do_ifconfig, ipv4=3D%d, ipv6=3D%d&quot;, tt-&gt;did_ifconfig_setup,</span>=
<br><span>         tt-&gt;did_ifconfig_ipv6_setup);</span><br><span>@@ -167=
1,12 +1672,12 @@</span><br><span> </span><br><span>     if (tt-&gt;did_ifco=
nfig_setup)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        do_ifconfig_ipv4(tt, ifname, tun_mtu, es, ctx);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        do_ifconfig_ipv4(t=
t, ifname, tun_mtu, es, ctx, is_multipoint);</span><br><span>     }</span><=
br><span> </span><br><span>     if (tt-&gt;did_ifconfig_ipv6_setup)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  do_ifconfig_ipv6(tt, ifname, tun_mtu, es, ctx);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        do_ifconfig_ipv6(tt, ifname, tun_mtu,=
 es, ctx, is_multipoint);</span><br><span>     }</span><br><span> </span><b=
r><span>     /* release resources potentially allocated during interface se=
tup */</span><br><span>@@ -2127,12 +2128,13 @@</span><br><span> }</span><br=
><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, open=
vpn_net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br>=
<span>     ASSERT(tt);</span><br><span> </span><br><span>     close_tun_gen=
eric(tt);</span><br><span>     free(tt);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    (void)is_multipoint;</span><br><span> }</span><br>=
<span> </span><br><span> int</span><br><span>@@ -2289,7 +2291,8 @@</span><b=
r><span> void</span><br><span> tuncfg(const char *dev, const char *dev_type=
, const char *dev_node,</span><br><span>        int persist_mode, const cha=
r *username, const char *groupname,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-       const struct tuntap_options *options, openvpn_net_ctx_=
t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       const=
 struct tuntap_options *options, openvpn_net_ctx_t *ctx,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+       const bool is_multipoint)</span=
><br><span> {</span><br><span>     struct tuntap *tt;</span><br><span> </sp=
an><br><span>@@ -2329,14 +2332,14 @@</span><br><span>             msg(M_ERR=
, &quot;Cannot ioctl TUNSETGROUP(%s) %s&quot;, groupname, dev);</span><br><=
span>         }</span><br><span>     }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    close_tun(tt, ctx);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    close_tun(tt, ctx, is_multipoint);</span><br><span=
>     msg(M_INFO, &quot;Persist state set to: %s&quot;, (persist_mode ? &qu=
ot;ON&quot; : &quot;OFF&quot;));</span><br><span> }</span><br><span> </span=
><br><span> #endif /* ENABLE_FEATURE_TUN_PERSIST */</span><br><span> </span=
><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-close=
_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, openvpn_net_ctx_t =
*ctx, const bool is_multipoint)</span><br><span> {</span><br><span>     ASS=
ERT(tt);</span><br><span> </span><br><span>@@ -2348,6 +2351,7 @@</span><br>=
<span> #endif</span><br><span>     close_tun_generic(tt);</span><br><span> =
    free(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (v=
oid)is_multipoint;</span><br><span> }</span><br><span> </span><br><span> in=
t</span><br><span>@@ -2653,7 +2657,7 @@</span><br><span>  * Close TUN devic=
e.</span><br><span>  */</span><br><span> void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct t=
untap *tt, openvpn_net_ctx_t *ctx, const bool is_multipoint)</span><br><spa=
n> {</span><br><span>     ASSERT(tt);</span><br><span> </span><br><span>@@ =
-2663,6 +2667,7 @@</span><br><span> </span><br><span>     clear_tuntap(tt);=
</span><br><span>     free(tt);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    (void)is_multipoint;</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br><span>@@ -2686,7 +2691,7 @@</span><br=
><span> </span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span>=
     openvpn_execve_check(&amp;argv, es, 0, &quot;Solaris ifconfig unplumb =
failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    clo=
se_tun(tt, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  close_tun(tt, NULL, false);</span><br><span>     msg(M_FATAL, &quot;Solar=
is ifconfig failed&quot;);</span><br><span>     argv_free(&amp;argv);</span=
><br><span> }</span><br><span>@@ -2750,10 +2755,12 @@</span><br><span>  */<=
/span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap =
*tt, openvpn_net_ctx_t *ctx, const bool is_multipoint)</span><br><span> {</=
span><br><span>     ASSERT(tt);</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    (void)is_multipoint;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* only *TAP* devi=
ces need destroying, tun devices auto-self-destruct</span><br><span>      *=
/</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN || tt-&gt;persis=
tent_if)</span><br><span>@@ -2864,10 +2871,12 @@</span><br><span>  * need t=
o be explicitly destroyed</span><br><span>  */</span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-close_tun(struct tuntap *tt,=
 openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_mul=
tipoint)</span><br><span> {</span><br><span>     ASSERT(tt);</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)is_mul=
tipoint;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     /* only tun devices need destroying, tap devices auto-self-destr=
uct</span><br><span>      */</span><br><span>     if (tt-&gt;type !=3D DEV_=
TYPE_TUN || tt-&gt;persistent_if)</span><br><span>@@ -3020,10 +3029,12 @@</=
span><br><span>  * we need to call &quot;ifconfig ... destroy&quot; for cle=
anup</span><br><span>  */</span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-close_tun(struct tuntap *tt, openvpn_net_ctx_t *c=
tx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+close_tun(struct=
 tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipoint)</span><br><s=
pan> {</span><br><span>     ASSERT(tt);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    (void)is_multipoint;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (tt-&gt=
;persistent_if)        /* keep pre-existing if around */</span><br><span>  =
   {</span><br><span>         close_tun_generic(tt);</span><br><span>@@ -31=
37,12 +3148,13 @@</span><br><span> }</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-close_tun(struct tun=
tap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx, const boo=
l is_multipoint)</span><br><span> {</span><br><span>     ASSERT(tt);</span>=
<br><span> </span><br><span>     close_tun_generic(tt);</span><br><span>   =
  free(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (voi=
d)is_multipoint;</span><br><span> }</span><br><span> </span><br><span> int<=
/span><br><span>@@ -3398,7 +3410,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, openvpn_net_=
ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><span>  =
   ASSERT(tt);</span><br><span> </span><br><span>@@ -3420,6 +3432,7 @@</spa=
n><br><span>     free(tt);</span><br><span>     argv_free(&amp;argv);</span=
><br><span>     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    (void)is_multipoint;</span><br><span> }</span><br><span> =
</span><br><span> int</span><br><span>@@ -3541,7 +3554,7 @@</span><br><span=
> /* tap devices need to be manually destroyed on AIX</span><br><span>  */<=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, openvpn_net_=
ctx_t *ctx, const bool is_multipoint)</span><br><span> {</span><br><span>  =
   ASSERT(tt);</span><br><span> </span><br><span>@@ -3569,6 +3582,7 @@</spa=
n><br><span>     free(tt);</span><br><span>     env_set_destroy(es);</span>=
<br><span>     argv_free(&amp;argv);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    (void)is_multipoint;</span><br><span> }</span><br><spa=
n> </span><br><span> int</span><br><span>@@ -6850,7 +6864,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-netsh_delete_address_dns(const struct tunta=
p *tt, bool ipv6, struct gc_arena *gc)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+netsh_delete_address_dns(const struct tuntap *tt, bool i=
pv6, struct gc_arena *gc, const bool is_multipoint)</span><br><span> {</spa=
n><br><span>     const char *ifconfig_ip_local;</span><br><span>     struct=
 argv argv =3D argv_new();</span><br><span>@@ -6880,7 +6894,7 @@</span><br>=
<span> </span><br><span>     if (ipv6 &amp;&amp; tt-&gt;type =3D=3D DEV_TYP=
E_TUN)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        delete_route_connected_v6_net(tt);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        delete_route_connected_v6_net(tt, is=
_multipoint);</span><br><span>     }</span><br><span> </span><br><span>    =
 /* &quot;store=3Dactive&quot; is needed in Windows 8(.1) to delete the</sp=
an><br><span>@@ -6950,7 +6964,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-clo=
se_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+close_tun(struct tuntap *tt, openvpn_net_ctx_=
t *ctx, const bool is_multipoint)</span><br><span> {</span><br><span>     A=
SSERT(tt);</span><br><span> </span><br><span>@@ -6970,7 +6984,7 @@</span><b=
r><span>                 do_dns_domain_service(false, tt);</span><br><span>=
             }</span><br><span>             do_dns_service(false, AF_INET6,=
 tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dele=
te_route_connected_v6_net(tt);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            delete_route_connected_v6_net(tt, is_multipoint);</s=
pan><br><span>             do_address_service(false, AF_INET6, tt);</span><=
br><span>         }</span><br><span>         else</span><br><span>@@ -6980,=
7 +6994,7 @@</span><br><span>                 do_dns_domain_wmic(false, tt)=
;</span><br><span>             }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            netsh_delete_address_dns(tt, true,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   netsh_delete_address_dns(tt, true, &amp;gc, is_multipoint);</span><br><s=
pan>         }</span><br><span>     }</span><br><span> </span><br><span>@@ =
-7007,7 +7021,7 @@</span><br><span> </span><br><span>             if (tt-&g=
t;options.ip_win32_type =3D=3D IPW32_SET_NETSH)</span><br><span>           =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ne=
tsh_delete_address_dns(tt, false, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                netsh_delete_address_dns(tt, false,=
 &amp;gc, is_multipoint);</span><br><span>             }</span><br><span>  =
       }</span><br><span>     }</span><br><span>@@ -7109,12 +7123,13 @@</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-close_tun(struct tuntap *tt, openvpn_net_=
ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+close_tu=
n(struct tuntap *tt, openvpn_net_ctx_t *ctx, const bool is_multipoint)</spa=
n><br><span> {</span><br><span>     ASSERT(tt);</span><br><span> </span><br=
><span>     close_tun_generic(tt);</span><br><span>     free(tt);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    (void)is_multipoint;</spa=
n><br><span> }</span><br><span> </span><br><span> int</span><br><span>diff =
--git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index ccba0bc=
..4f502cd 100644</span><br><span>--- a/src/openvpn/tun.h</span><br><span>++=
+ b/src/openvpn/tun.h</span><br><span>@@ -282,7 +282,7 @@</span><br><span> =
void open_tun(const char *dev, const char *dev_type, const char *dev_node,<=
/span><br><span>               struct tuntap *tt, openvpn_net_ctx_t *ctx);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void=
 close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void close_tun(struct tuntap *tt, openvp=
n_net_ctx_t *ctx, const bool is_multipoint);</span><br><span> </span><br><s=
pan> void tun_open_device(struct tuntap *tt, const char *dev_node,</span><b=
r><span>                      const char **device_guid, struct gc_arena *gc=
);</span><br><span>@@ -296,7 +296,7 @@</span><br><span> void tuncfg(const c=
har *dev, const char *dev_type, const char *dev_node,</span><br><span>     =
        int persist_mode, const char *username,</span><br><span>           =
  const char *groupname, const struct tuntap_options *options,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            openvpn_net_ctx_t *ctx=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            openv=
pn_net_ctx_t *ctx, const bool is_multipoint);</span><br><span> </span><br><=
span> const char *guess_tuntap_dev(const char *dev,</span><br><span>       =
                       const char *dev_type,</span><br><span>@@ -335,7 +335=
,7 @@</span><br><span>  * @param ctx       the networking API opaque contex=
t</span><br><span>  */</span><br><span> void do_ifconfig(struct tuntap *tt,=
 const char *ifname, int tun_mtu,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                 const struct env_set *es, openvpn_net_ctx_t *c=
tx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  const struct env_set *es, openvpn_net_ctx_t *ctx, const bool is_multipoin=
t);</span><br><span> </span><br><span> /**</span><br><span>  * undo_ifconfi=
g - undo configuration of the tunnel interface</span><br><span>@@ -781,6 +7=
81,7 @@</span><br><span> }</span><br><span> </span><br><span> const char *t=
un_stat(const struct tuntap *tt, unsigned int rwflags, struct gc_arena *gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
bool tun_name_is_fixed(const char *dev);</span><br><span> </span><br><span>=
 static inline bool</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail">change 721</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/721?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87777e74b1fd34781e1d72c9f99=
4eb84f39d800c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 721 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
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


--fHjypya2p+I=--

