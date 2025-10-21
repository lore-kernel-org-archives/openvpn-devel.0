From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 21 Oct 2025 14:05:10 +0000
In-Reply-To: <gerrit.1722331476000.I87777e74b1fd34781e1d72c9f994eb84f39d800c@...2715...>
References: <gerrit.1722331476000.I87777e74b1fd34781e1d72c9f994eb84f39d800c@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <b61627a6562641cde2b4c78d367e596b0750013f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a4ANLehE0xY="; charset=UTF-8
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

--a4ANLehE0xY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail

to look at the new patch set (#12).


Change subject: route: extended logic to omit gateway when unnecessary
......................................................................

route: extended logic to omit gateway when unnecessary

Extracted and extended the logic behind gateway_needed both in
add_route() and add_route_ipv6(). Checking dev-type, special
routes, if the gateway is on-link and if the gateway is in the
vpn subnet. Additionally, extended support for these checks and
conditions to DARWIN and BSD-based operating systems.

These changes ensure that the gateway is only included when
necessary, optimizing route configuration and potentially
reducing redundant route entries.

Additionally, Dragonfly's do_ifconfig_ipv4() code is now shared
with NetBSD's, rather than FreeBSD's.

Change-Id: I87777e74b1fd34781e1d72c9f994eb84f39d800c
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/route.c
M src/openvpn/tun.c
2 files changed, 210 insertions(+), 130 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/721/12

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index c249b38..4dc4005 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -42,6 +42,7 @@
 #include "options.h"
 #include "networking.h"
 #include "integer.h"
+#include "openvpn.h"

 #include "memdbg.h"

@@ -1396,6 +1397,7 @@
     }
     gc_free(&gc);
 }
+
 void
 setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6)
 {
@@ -1472,6 +1474,37 @@
 }
 #endif

+static bool
+is_gateway_needed_ipv4(const struct route_ipv4 *r4,
+                       const struct route_gateway_info *rgi,
+                       const struct tuntap *tt)
+{
+#ifndef _WIN32
+    /* server told us which interface to use; pass gateway if it gave one =
*/
+    if (rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi->iface[0] !=3D 0)
+    {
+        if (rgi->flags & RGI_ADDR_DEFINED && r4->gateway !=3D 0)
+        {
+            return true;
+        }
+    }
+#endif
+
+    /* TAP is an L2 device, so for destinations that are not explicitly
+     * on-link the kernel needs a gateway so it can ARP/ND for the
+     * MAC address. We make an exception only when the user explicitly sets
+     * metric 0, which is taken as a request for an on-link =E2=80=9Croute=
 to
+     * interface=E2=80=9D (no gateway). This keeps parity with the IPv6 co=
de.
+     */
+    if (tt->type =3D=3D DEV_TYPE_TAP
+        && !((r4->flags & RT_METRIC_DEFINED) && r4->metric =3D=3D 0))
+    {
+        return true;
+    }
+
+    return false;
+}
+
 bool
 add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flag=
s,
           const struct route_gateway_info *rgi, /* may be NULL */
@@ -1503,28 +1536,7 @@
         goto done;
     }

-#ifndef _WIN32
-    /* server told us which interface to use; pass gateway if it gave one =
*/
-    if (rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi->iface[0] !=3D 0)
-    {
-        if (rgi->flags & RGI_ADDR_DEFINED && r->gateway !=3D 0)
-        {
-            gateway_needed =3D true;
-        }
-    }
-#endif
-
-    /* TAP is an L2 device, so for destinations that are not explicitly
-     * on-link the kernel needs a gateway so it can ARP/ND for the
-     * MAC address. We make an exception only when the user explicitly sets
-     * metric 0, which is taken as a request for an on-link =E2=80=9Croute=
 to
-     * interface=E2=80=9D (no gateway). This keeps parity with the IPv6 co=
de.
-     */
-    if (tt->type =3D=3D DEV_TYPE_TAP
-        && !((r->flags & RT_METRIC_DEFINED) && r->metric =3D=3D 0))
-    {
-        gateway_needed =3D true;
-    }
+    gateway_needed =3D is_gateway_needed_ipv4(r, rgi, tt);

     if (gateway_needed && r->gateway =3D=3D 0)
     {
@@ -1537,18 +1549,21 @@
         goto done;
     }

-#if defined(TARGET_LINUX)
-    const char *iface =3D tt->actual_name;
+#if !defined(_WIN32) && !defined(TARGET_SOLARIS) \
+    && !defined(TARGET_AIX)
+    const char *device =3D tt->actual_name;
     if (!gateway_needed && rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi-=
>iface[0] !=3D 0) /* vpn server special route */
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
@@ -1560,7 +1575,7 @@
     status =3D RTA_SUCCESS;
     int ret =3D net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->=
netmask),
                                gateway_needed ? &r->gateway : NULL,
-                               iface, r->table_id, metric);
+                               device, r->table_id, metric);
     if (ret =3D=3D -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed because route e=
xists");
@@ -1577,7 +1592,7 @@

     if (rgi)
     {
-        snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, ga=
teway, rgi->iface);
+        snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, ga=
teway, device);
     }
     else
     {
@@ -1672,7 +1687,7 @@
     bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route =
add command failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;

-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

     argv_printf(&argv, "%s add", ROUTE_PATH);

@@ -1683,31 +1698,18 @@
     }
 #endif

-    argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netmask);
-
-    /* FIXME -- add on-link support for FreeBSD */
-
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: FreeBSD route =
add command failed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
-
-#elif defined(TARGET_DRAGONFLY)
-
-    argv_printf(&argv, "%s add", ROUTE_PATH);
-
-#if 0
-    if (r->flags & RT_METRIC_DEFINED)
+    if (gateway_needed)
     {
-        argv_printf_cat(&argv, "-rtt %d", r->metric);
+        argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netmask);
     }
-#endif
-
-    argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netmask);
-
-    /* FIXME -- add on-link support for Dragonfly */
+    else
+    {
+        argv_printf_cat(&argv, "-net %s -iface %s", network, device);
+    }

     argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: DragonFly rout=
e add command failed");
+    bool ret =3D openvpn_execve_check(&argv, es, 0,
+                                    "ERROR: BSD route add command failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;

 #elif defined(TARGET_DARWIN)
@@ -1730,7 +1732,14 @@
     }
     else
     {
-        argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netmask);
+        if (gateway_needed)
+        {
+            argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netm=
ask);
+        }
+        else
+        {
+            argv_printf_cat(&argv, "-net %s -interface %s", network, devic=
e);
+        }
     }

     argv_msg(D_ROUTE, &argv);
@@ -1748,9 +1757,14 @@
     }
 #endif

-    argv_printf_cat(&argv, "-net %s %s -netmask %s", network, gateway, net=
mask);
-
-    /* FIXME -- add on-link support for OpenBSD/NetBSD */
+    if (gateway_needed)
+    {
+        argv_printf_cat(&argv, "-net %s %s -netmask %s", network, gateway,=
 netmask);
+    }
+    else
+    {
+        argv_printf_cat(&argv, "-net %s -netmask %s -link -iface %s", netw=
ork, netmask, device);
+    }

     argv_msg(D_ROUTE, &argv);
     bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD=
 route add command failed");
@@ -1827,6 +1841,47 @@
     }
 }

+static bool
+is_gateway_needed_ipv6(const struct route_ipv6 *r6,
+                       const struct tuntap *tt,
+                       const char *network)
+{
+#ifndef _WIN32
+    if (r6->iface !=3D NULL) /* VPN server special route */
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
+        && !((r6->flags & RT_METRIC_DEFINED) && r6->metric =3D=3D 0))
+    {
+        return true;
+    }
+
+    if (ipv6_net_contains_host(&tt->local_ipv6, tt->netbits_ipv6, &r6->gat=
eway))
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
 add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned in=
t flags,
                const struct env_set *es, openvpn_net_ctx_t *ctx)
@@ -1842,22 +1897,12 @@
     struct argv argv =3D argv_new();
     struct gc_arena gc =3D gc_new();

-#ifndef _WIN32
-    const char *device =3D tt->actual_name;
-    if (r6->iface !=3D NULL) /* vpn server special route */
-    {
-        device =3D r6->iface;
-        if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway))
-        {
-            gateway_needed =3D true;
-        }
-    }
-#endif
-
     route_ipv6_clear_host_bits(r6);
     const char *network =3D print_in6_addr(r6->network, 0, &gc);
     const char *gateway =3D print_in6_addr(r6->gateway, 0, &gc);

+    gateway_needed =3D is_gateway_needed_ipv6(r6, tt, network);
+
 #if defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) || defined(TARGET_DR=
AGONFLY) \
     || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)

@@ -1875,6 +1920,15 @@
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
     msg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) dev %s", network, =
r6->netbits, gateway,
         r6->metric, device);
@@ -1883,22 +1937,6 @@
         r6->metric, r6->adapter_index ? r6->adapter_index : tt->adapter_in=
dex);
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
-    if (tt->type =3D=3D DEV_TYPE_TAP && !((r6->flags & RT_METRIC_DEFINED) =
&& r6->metric =3D=3D 0))
-    {
-        gateway_needed =3D true;
-    }
-
     if (gateway_needed && IN6_IS_ADDR_UNSPECIFIED(&r6->gateway))
     {
         msg(M_WARN,
@@ -1913,6 +1951,7 @@

 #if defined(TARGET_LINUX)
     int metric =3D -1;
+
     if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
         metric =3D r6->metric;
@@ -2008,21 +2047,21 @@
     bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: MacOS X route =
add -inet6 command failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;

-#elif defined(TARGET_OPENBSD)
+#elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)

-    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d %s", ROUTE_PATH, ne=
twork, r6->netbits,
-                gateway);
+    argv_printf(&argv, "%s add -inet6 %s -prefixlen %d ", ROUTE_PATH, netw=
ork, r6->netbits);
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
-    bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD route =
add -inet6 command failed");
-    status =3D ret ? RTA_SUCCESS : RTA_ERROR;
-
-#elif defined(TARGET_NETBSD)
-
-    argv_printf(&argv, "%s add -inet6 %s/%d %s", ROUTE_PATH, network, r6->=
netbits, gateway);
-
-    argv_msg(D_ROUTE, &argv);
-    bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: NetBSD route a=
dd -inet6 command failed");
+    bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD=
 route add -inet6 command failed");
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;

 #elif defined(TARGET_AIX)
@@ -2080,6 +2119,21 @@
 #endif
     int is_local_route;

+#if defined(TARGET_DARWIN) || defined(TARGET_LINUX)         \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) \
+    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+
+    bool gateway_needed =3D is_gateway_needed_ipv4(r, rgi, tt);
+
+#if !defined(TARGET_OPENBSD) && !defined(TARGET_NETBSD)
+    const char *device =3D tt->actual_name;
+    if (!gateway_needed && rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi-=
>iface[0] !=3D 0) /* vpn server special route */
+    {
+        device =3D rgi->iface;
+    }
+#endif
+#endif
+
     if ((r->flags & (RT_DEFINED | RT_ADDED)) !=3D (RT_DEFINED | RT_ADDED))
     {
         return;
@@ -2106,12 +2160,19 @@

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

-    if (net_route_v4_del(ctx, &r->network, netmask_to_netbits2(r->netmask)=
, &r->gateway, NULL,
+    if (net_route_v4_del(ctx, &r->network, netmask_to_netbits2(r->netmask),
+                         gateway_needed ? &r->gateway : NULL, device,
                          r->table_id, metric)
         < 0)
     {
@@ -2165,19 +2226,21 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route delete comman=
d failed");

-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)

-    argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network, gat=
eway, netmask);
+    argv_printf(&argv, "%s delete", ROUTE_PATH);
+
+    if (gateway_needed)
+    {
+        argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netmask);
+    }
+    else
+    {
+        argv_printf_cat(&argv, "-net %s -iface %s", network, device);
+    }

     argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: FreeBSD route delete comman=
d failed");
-
-#elif defined(TARGET_DRAGONFLY)
-
-    argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network, gat=
eway, netmask);
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: DragonFly route delete comm=
and failed");
+    openvpn_execve_check(&argv, es, 0, "ERROR: BSD route delete command fa=
iled");

 #elif defined(TARGET_DARWIN)

@@ -2188,7 +2251,16 @@
     }
     else
     {
-        argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network,=
 gateway, netmask);
+        argv_printf(&argv, "%s delete ", ROUTE_PATH);
+
+        if (gateway_needed)
+        {
+            argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netm=
ask);
+        }
+        else
+        {
+            argv_printf_cat(&argv, "-net %s -interface %s", network, devic=
e);
+        }
     }

     argv_msg(D_ROUTE, &argv);
@@ -2196,7 +2268,16 @@

 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)

-    argv_printf(&argv, "%s delete -net %s %s -netmask %s", ROUTE_PATH, net=
work, gateway, netmask);
+    argv_printf(&argv, "%s delete ", ROUTE_PATH);
+
+    if (gateway_needed)
+    {
+        argv_printf_cat(&argv, "-net %s %s -netmask %s", network, gateway,=
 netmask);
+    }
+    else
+    {
+        argv_printf_cat(&argv, "-net %s -netmask %s", network, netmask);
+    }

     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete=
 command failed");
@@ -2250,23 +2331,16 @@
 #if !defined(TARGET_LINUX)
     const char *gateway;
 #endif
-#if !defined(TARGET_SOLARIS)
-    bool gateway_needed =3D false;
+#if defined(TARGET_DARWIN) || defined(TARGET_LINUX) \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
+
     const char *device =3D tt->actual_name;
     if (r6->iface !=3D NULL) /* vpn server special route */
     {
         device =3D r6->iface;
-        gateway_needed =3D true;
     }
     (void)device; /* unused on some platforms */

-    /* if we used a gateway on "add route", we also need to specify it on
-     * delete, otherwise some OSes will refuse to delete the route
-     */
-    if (tt->type =3D=3D DEV_TYPE_TAP && !((r6->flags & RT_METRIC_DEFINED) =
&& r6->metric =3D=3D 0))
-    {
-        gateway_needed =3D true;
-    }
 #endif
 #endif

@@ -2278,6 +2352,15 @@
     gateway =3D print_in6_addr(r6->gateway, 0, &gc);
 #endif

+#if defined(TARGET_DARWIN) || defined(TARGET_LINUX) || defined(TARGET_FREE=
BSD) \
+    || defined(TARGET_DRAGONFLY) || defined(TARGET_OPENBSD) || defined(TAR=
GET_NETBSD)
+    /* if we used a gateway on "add route", we also need to specify it on
+     * delete, otherwise some OSes will refuse to delete the route
+     */
+    bool gateway_needed =3D false;
+    gateway_needed =3D is_gateway_needed_ipv6(r6, tt, network);
+#endif
+
 #if defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) || defined(TARGET_DR=
AGONFLY) \
     || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)

@@ -2362,20 +2445,17 @@
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: MacOS X route delete -inet6=
 command failed");

-#elif defined(TARGET_OPENBSD)
+#elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)

-    argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d %s", ROUTE_PATH,=
 network, r6->netbits,
-                gateway);
+    argv_printf(&argv, "%s delete -inet6 %s -prefixlen %d", ROUTE_PATH, ne=
twork, r6->netbits);
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
-    argv_printf(&argv, "%s delete -inet6 %s/%d %s", ROUTE_PATH, network, r=
6->netbits, gateway);
-
-    argv_msg(D_ROUTE, &argv);
-    openvpn_execve_check(&argv, es, 0, "ERROR: NetBSD route delete -inet6 =
command failed");
+    openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete=
 -inet6 command failed");

 #elif defined(TARGET_AIX)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 06b7ae5..0df946b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1383,7 +1383,7 @@
         add_route(&r, tt, 0, NULL, es, NULL);
     }

-#elif defined(TARGET_NETBSD)
+#elif defined(TARGET_NETBSD) || defined(TARGET_DRAGONFLY)
     in_addr_t remote_end =3D INADDR_ANY; /* for "virtual" subnet topology =
*/

     if (tun_p2p)
@@ -1466,7 +1466,7 @@
         add_route(&r, tt, 0, NULL, es, NULL);
     }

-#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
+#elif defined(TARGET_FREEBSD)

     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.2=
55.255 up */
     if (tun_p2p) /* point-to-point tun */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87777e74b1fd34781e1d72c9f994eb84f39d800c
Gerrit-Change-Number: 721
Gerrit-PatchSet: 12
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>

--a4ANLehE0xY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff. </p>
<p>mrbff <strong>uploaded patch set #12</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: extended logic to omit gateway when unnecessary<=
br><br>Extracted and extended the logic behind gateway_needed both in<br>ad=
d_route() and add_route_ipv6(). Checking dev-type, special<br>routes, if th=
e gateway is on-link and if the gateway is in the<br>vpn subnet. Additional=
ly, extended support for these checks and<br>conditions to DARWIN and BSD-b=
ased operating systems.<br><br>These changes ensure that the gateway is onl=
y included when<br>necessary, optimizing route configuration and potentiall=
y<br>reducing redundant route entries.<br><br>Additionally, Dragonfly&#39;s=
 do_ifconfig_ipv4() code is now shared<br>with NetBSD&#39;s, rather than Fr=
eeBSD&#39;s.<br><br>Change-Id: I87777e74b1fd34781e1d72c9f994eb84f39d800c<br=
>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvp=
n/route.c<br>M src/openvpn/tun.c<br>2 files changed, 210 insertions(+), 130=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/21/721/12</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/route=
.c b/src/openvpn/route.c</span><br><span>index c249b38..4dc4005 100644</spa=
n><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/rou=
te.c</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;opti=
ons.h&quot;</span><br><span> #include &quot;networking.h&quot;</span><br><s=
pan> #include &quot;integer.h&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;openvpn.h&quot;</span><br><span> </span><br>=
<span> #include &quot;memdbg.h&quot;</span><br><span> </span><br><span>@@ -=
1396,6 +1397,7 @@</span><br><span>     }</span><br><span>     gc_free(&amp;=
gc);</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> void</span><br><span> setenv_routes_ipv6(struct env_s=
et *es, const struct route_ipv6_list *rl6)</span><br><span> {</span><br><sp=
an>@@ -1472,6 +1474,37 @@</span><br><span> }</span><br><span> #endif</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+is_gateway_neede=
d_ipv4(const struct route_ipv4 *r4,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                       const struct route_gateway_info *rgi=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
     const struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef =
_WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* server=
 told us which interface to use; pass gateway if it gave one */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (rgi &amp;&amp; (rgi-&gt=
;flags &amp; RGI_IFACE_DEFINED) &amp;&amp; rgi-&gt;iface[0] !=3D 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (rgi-&gt;flags &amp; RGI_ADDR_=
DEFINED &amp;&amp; r4-&gt;gateway !=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* TAP is an L2 device, so for dest=
inations that are not explicitly</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * on-link the kernel needs a gateway so it can ARP/ND for=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * MAC addr=
ess. We make an exception only when the user explicitly sets</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * metric 0, which is taken as=
 a request for an on-link =E2=80=9Croute to</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * interface=E2=80=9D (no gateway). This keeps =
parity with the IPv6 code.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        &amp;&amp; !((r4-&gt;flags &amp; RT_METRIC_DEFINED) =
&amp;&amp; r4-&gt;metric =3D=3D 0))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> add_route(=
struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,</span><b=
r><span>           const struct route_gateway_info *rgi, /* may be NULL */<=
/span><br><span>@@ -1503,28 +1536,7 @@</span><br><span>         goto done;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#ifndef _WIN32</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* server told us which interface to use; pass gateway if i=
t gave one */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEFINED) &amp;&amp; rgi-&gt;i=
face[0] !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (rgi-&gt;fl=
ags &amp; RGI_ADDR_DEFINED &amp;&amp; r-&gt;gateway !=3D 0)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            gateway_needed =3D true;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TAP is an L2 dev=
ice, so for destinations that are not explicitly</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * on-link the kernel needs a gateway so it =
can ARP/ND for the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * MAC address. We make an exception only when the user explicitly sets</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * metric 0, which i=
s taken as a request for an on-link =E2=80=9Croute to</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * interface=E2=80=9D (no gateway). Thi=
s keeps parity with the IPv6 code.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        &amp;&amp; !((r-&gt;flags &amp; RT_METRIC_DEFINED)=
 &amp;&amp; r-&gt;metric =3D=3D 0))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      gateway_needed =3D true;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
ateway_needed =3D is_gateway_needed_ipv4(r, rgi, tt);</span><br><span> </sp=
an><br><span>     if (gateway_needed &amp;&amp; r-&gt;gateway =3D=3D 0)</sp=
an><br><span>     {</span><br><span>@@ -1537,18 +1549,21 @@</span><br><span=
>         goto done;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const char *iface =3D tt-&g=
t;actual_name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !=
defined(_WIN32) &amp;&amp; !defined(TARGET_SOLARIS) \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &amp;&amp; !defined(TARGET_AIX)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *device =
=3D tt-&gt;actual_name;</span><br><span>     if (!gateway_needed &amp;&amp;=
 rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEFINED) &amp;&amp; rgi-&gt;=
iface[0] !=3D 0) /* vpn server special route */</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        iface =3D rgi-&gt;=
iface;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        devic=
e =3D rgi-&gt;iface;</span><br><span>     }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><span>    =
 int metric =3D -1;</span><br><span> </span><br><span>     if (is_on_link(i=
s_local_route, flags, rgi))</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        iface =3D rgi-&gt;iface;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        device =3D rgi-&gt;iface;=
</span><br><span>     }</span><br><span> </span><br><span>     if (r-&gt;fl=
ags &amp; RT_METRIC_DEFINED)</span><br><span>@@ -1560,7 +1575,7 @@</span><b=
r><span>     status =3D RTA_SUCCESS;</span><br><span>     int ret =3D net_r=
oute_v4_add(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask),</s=
pan><br><span>                                gateway_needed ? &amp;r-&gt;g=
ateway : NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                        iface, r-&gt;table_id, metric);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                               device, =
r-&gt;table_id, metric);</span><br><span>     if (ret =3D=3D -EEXIST)</span=
><br><span>     {</span><br><span>         msg(D_ROUTE, &quot;NOTE: Linux r=
oute add command failed because route exists&quot;);</span><br><span>@@ -15=
77,7 +1592,7 @@</span><br><span> </span><br><span>     if (rgi)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sn=
printf(out, sizeof(out), &quot;%s %s %s dev %s&quot;, network, netmask, gat=
eway, rgi-&gt;iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        snprintf(out, sizeof(out), &quot;%s %s %s dev %s&quot;, network, =
netmask, gateway, device);</span><br><span>     }</span><br><span>     else=
</span><br><span>     {</span><br><span>@@ -1672,7 +1687,7 @@</span><br><sp=
an>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: So=
laris route add command failed&quot;);</span><br><span>     status =3D ret =
? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_FREEBSD) || defined(=
TARGET_DRAGONFLY)</span><br><span> </span><br><span>     argv_printf(&amp;a=
rgv, &quot;%s add&quot;, ROUTE_PATH);</span><br><span> </span><br><span>@@ =
-1683,31 +1698,18 @@</span><br><span>     }</span><br><span> #endif</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_pr=
intf_cat(&amp;argv, &quot;-net %s %s %s&quot;, network, gateway, netmask);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add on-link support for Fre=
eBSD */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D openvp=
n_execve_check(&amp;argv, es, 0, &quot;ERROR: FreeBSD route add command fai=
led&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status=
 =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif d=
efined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&a=
mp;argv, &quot;%s add&quot;, ROUTE_PATH);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r-&gt;fla=
gs &amp; RT_METRIC_DEFINED)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (gateway_needed)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        argv_printf_cat(&amp;argv, &quot;-=
rtt %d&quot;, r-&gt;metric);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, netw=
ork, gateway, netmask);</span><br><span>     }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_pr=
intf_cat(&amp;argv, &quot;-net %s %s %s&quot;, network, gateway, netmask);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add on-link support for Dra=
gonfly */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, =
&quot;-net %s -iface %s&quot;, network, device);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     a=
rgv_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR:=
 DragonFly route add command failed&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    bool ret =3D openvpn_execve_check(&amp;argv, es=
, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                     &quot;ERROR: BSD route add command failed&quot;);</spa=
n><br><span>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span>=
 </span><br><span> #elif defined(TARGET_DARWIN)</span><br><span>@@ -1730,7 =
+1732,14 @@</span><br><span>     }</span><br><span>     else</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        argv_=
printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, network, gateway, netmask)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (gatewa=
y_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            argv_pri=
ntf_cat(&amp;argv, &quot;-net %s %s %s&quot;, network, gateway, netmask);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            argv_printf_cat(&amp;argv, &quot;-ne=
t %s -interface %s&quot;, network, device);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> <=
/span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>@@ -1748=
,9 +1757,14 @@</span><br><span>     }</span><br><span> #endif</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf_c=
at(&amp;argv, &quot;-net %s %s -netmask %s&quot;, network, gateway, netmask=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add on-link support for =
OpenBSD/NetBSD */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (gateway_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv=
_printf_cat(&amp;argv, &quot;-net %s %s -netmask %s&quot;, network, gateway=
, netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-net %=
s -netmask %s -link -iface %s&quot;, network, netmask, device);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><=
br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     bool ret =
=3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: OpenBSD/NetBSD rout=
e add command failed&quot;);</span><br><span>@@ -1827,6 +1841,47 @@</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+is_gateway_needed_ipv6(const struct route_ipv6 *r=
6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
      const struct tuntap *tt,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                       const char *network)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (r6-&gt;iface !=3D NULL) /* VPN server special route */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (!IN6_IS_ADDR_UNSPECIFI=
ED(&amp;r6-&gt;gateway))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * Filter out routes which are essentially no-ops</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * (not currently done for IPv6=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* On &quot;tun&quot; interface, we never set=
 a gateway if the operating system</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * can do &quot;route to interface&quot; - it does not a=
dd value, as the target</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * dev already fully qualifies the route destination on point-to-po=
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * interface=
s.   OTOH, on &quot;tap&quot; interface, we must always set the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * gateway unless the route=
 is to be an on-link network</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (tt-&gt;type =3D=3D DEV_TYPE_TAP</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        &amp;&amp; !((r6-&gt;flags &amp; RT_METRIC_DEFINED=
) &amp;&amp; r6-&gt;metric =3D=3D 0))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ipv6_net_contains_ho=
st(&amp;tt-&gt;local_ipv6, tt-&gt;netbits_ipv6, &amp;r6-&gt;gateway))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(D_ROUTE, &quot;Ignoring gat=
eway in VPN subnet for route %s/%d&quot;, network, r6-&gt;netbits);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> bool</span><br><span> add_route_ipv6(struct route_ipv6 *r6, =
const struct tuntap *tt, unsigned int flags,</span><br><span>              =
  const struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span>@@ -184=
2,22 +1897,12 @@</span><br><span>     struct argv argv =3D argv_new();</spa=
n><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef _WIN32</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const char *device =3D tt-&gt;ac=
tual_name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r6-=
&gt;iface !=3D NULL) /* vpn server special route */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        device =3D r6-&gt;iface;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (!IN6_IS_ADDR_UNSPECIFIED(&amp;r6-&gt=
;gateway))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            gateway_nee=
ded =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span>     route_ipv6_clear_host_bits(r6=
);</span><br><span>     const char *network =3D print_in6_addr(r6-&gt;netwo=
rk, 0, &amp;gc);</span><br><span>     const char *gateway =3D print_in6_add=
r(r6-&gt;gateway, 0, &amp;gc);</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gateway_needed =3D is_gateway_needed_ipv6(=
r6, tt, network);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> #if defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) || de=
fined(TARGET_DRAGONFLY) \</span><br><span>     || defined(TARGET_OPENBSD) |=
| defined(TARGET_NETBSD)</span><br><span> </span><br><span>@@ -1875,6 +1920=
,15 @@</span><br><span>     }</span><br><span> #endif</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(_WIN32)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *device =3D tt-&gt;actual_=
name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (r6-&gt=
;iface !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        device =
=3D r6-&gt;iface;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifndef _WI=
N32</span><br><span>     msg(D_ROUTE, &quot;add_route_ipv6(%s/%d -&gt; %s m=
etric %d) dev %s&quot;, network, r6-&gt;netbits, gateway,</span><br><span> =
        r6-&gt;metric, device);</span><br><span>@@ -1883,22 +1937,6 @@</spa=
n><br><span>         r6-&gt;metric, r6-&gt;adapter_index ? r6-&gt;adapter_i=
ndex : tt-&gt;adapter_index);</span><br><span> #endif</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     * Filter out routes which are essen=
tially no-ops</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * (=
not currently done for IPv6)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* On &quot;tun&quot; in=
terface, we never set a gateway if the operating system</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * can do &quot;route to interface&qu=
ot; - it does not add value, as the target</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     * dev already fully qualifies the route destinati=
on on point-to-point</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * interfaces.   OTOH, on &quot;tap&quot; interface, we must always set =
the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * gateway unl=
ess the route is to be an on-link network</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TAP &amp;&amp; !((r6-&gt;flags &a=
mp; RT_METRIC_DEFINED) &amp;&amp; r6-&gt;metric =3D=3D 0))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        gateway_needed =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     if (gateway_needed &amp;&amp; IN6_IS_=
ADDR_UNSPECIFIED(&amp;r6-&gt;gateway))</span><br><span>     {</span><br><sp=
an>         msg(M_WARN,</span><br><span>@@ -1913,6 +1951,7 @@</span><br><sp=
an> </span><br><span> #if defined(TARGET_LINUX)</span><br><span>     int me=
tric =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     if ((r6-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp; (r6-&g=
t;metric &gt; 0))</span><br><span>     {</span><br><span>         metric =
=3D r6-&gt;metric;</span><br><span>@@ -2008,21 +2047,21 @@</span><br><span>=
     bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: MacOS=
 X route add -inet6 command failed&quot;);</span><br><span>     status =3D =
ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#elif defined(TARGET_OPENBSD)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_OPENBSD) || defin=
ed(TARGET_NETBSD)</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    argv_printf(&amp;argv, &quot;%s add -inet6 %s -prefixlen =
%d %s&quot;, ROUTE_PATH, network, r6-&gt;netbits,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                gateway);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s add -=
inet6 %s -prefixlen %d &quot;, ROUTE_PATH, network, r6-&gt;netbits);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (gateway_needed)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;%s&quot;, gate=
way);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-link -iface=
 %s&quot;, device);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D openv=
pn_execve_check(&amp;argv, es, 0, &quot;ERROR: OpenBSD route add -inet6 com=
mand failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#elif defined(TARGET_NETBSD)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_prin=
tf(&amp;argv, &quot;%s add -inet6 %s/%d %s&quot;, ROUTE_PATH, network, r6-&=
gt;netbits, gateway);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE,=
 &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool =
ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: NetBSD route ad=
d -inet6 command failed&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    bool ret =3D openvpn_execve_check(&amp;argv, es, 0, &quot;E=
RROR: OpenBSD/NetBSD route add -inet6 command failed&quot;);</span><br><spa=
n>     status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span> </span><b=
r><span> #elif defined(TARGET_AIX)</span><br><span>@@ -2080,6 +2119,21 @@</=
span><br><span> #endif</span><br><span>     int is_local_route;</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(T=
ARGET_DARWIN) || defined(TARGET_LINUX)         \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    || defined(TARGET_FREEBSD) || defined(TARG=
ET_DRAGONFLY) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
|| defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool gateway_needed =3D is_gateway_needed_ipv4(r, rgi, t=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_OPENBSD) &amp;&=
amp; !defined(TARGET_NETBSD)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *device =3D tt-&gt;actual_name;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!gateway_needed &amp;&amp; rgi =
&amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEFINED) &amp;&amp; rgi-&gt;iface=
[0] !=3D 0) /* vpn server special route */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        device =3D rgi-&gt;iface;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
     if ((r-&gt;flags &amp; (RT_DEFINED | RT_ADDED)) !=3D (RT_DEFINED | RT_=
ADDED))</span><br><span>     {</span><br><span>         return;</span><br><=
span>@@ -2106,12 +2160,19 @@</span><br><span> </span><br><span> #if defined=
(TARGET_LINUX)</span><br><span>     metric =3D -1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (is_on_link(is_local_route, flags, rgi))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        device =3D rgi-&gt;iface;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     if (r-&gt;flags &amp; RT_ME=
TRIC_DEFINED)</span><br><span>     {</span><br><span>         metric =3D r-=
&gt;metric;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (net_route_v4_del(ctx, &amp;r-&gt;ne=
twork, netmask_to_netbits2(r-&gt;netmask), &amp;r-&gt;gateway, NULL,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (net_route_v4_del(c=
tx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                         gateway_ne=
eded ? &amp;r-&gt;gateway : NULL, device,</span><br><span>                 =
         r-&gt;table_id, metric)</span><br><span>         &lt; 0)</span><br=
><span>     {</span><br><span>@@ -2165,19 +2226,21 @@</span><br><span>     =
argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_check(&am=
p;argv, es, 0, &quot;ERROR: Solaris route delete command failed&quot;);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif d=
efined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&=
amp;argv, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gateway=
, netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv=
_printf(&amp;argv, &quot;%s delete&quot;, ROUTE_PATH);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (gateway_needed)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, network=
, gateway, netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &qu=
ot;-net %s -iface %s&quot;, network, device);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     argv=
_msg(D_ROUTE, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: FreeBSD route d=
elete command failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(=
TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv=
, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gateway, netmas=
k);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&a=
mp;argv, es, 0, &quot;ERROR: DragonFly route delete command failed&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_execve_c=
heck(&amp;argv, es, 0, &quot;ERROR: BSD route delete command failed&quot;);=
</span><br><span> </span><br><span> #elif defined(TARGET_DARWIN)</span><br>=
<span> </span><br><span>@@ -2188,7 +2251,16 @@</span><br><span>     }</span=
><br><span>     else</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s delete -net %=
s %s %s&quot;, ROUTE_PATH, network, gateway, netmask);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s =
delete &quot;, ROUTE_PATH);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(gateway_needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            a=
rgv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, network, gateway, netm=
ask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            argv_printf_cat(&amp;argv, &q=
uot;-net %s -interface %s&quot;, network, device);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><=
span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>@=
@ -2196,7 +2268,16 @@</span><br><span> </span><br><span> #elif defined(TARG=
ET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delet=
e -net %s %s -netmask %s&quot;, ROUTE_PATH, network, gateway, netmask);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;ar=
gv, &quot;%s delete &quot;, ROUTE_PATH);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (gateway_needed)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
argv_printf_cat(&amp;argv, &quot;-net %s %s -netmask %s&quot;, network, gat=
eway, netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;=
-net %s -netmask %s&quot;, network, netmask);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     argv=
_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_check(&amp;ar=
gv, es, 0, &quot;ERROR: OpenBSD/NetBSD route delete command failed&quot;);<=
/span><br><span>@@ -2250,23 +2331,16 @@</span><br><span> #if !defined(TARGE=
T_LINUX)</span><br><span>     const char *gateway;</span><br><span> #endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_SO=
LARIS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool gatewa=
y_needed =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(TARGET_DARWIN) || defined(TARGET_LINUX) \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    || defined(TARGET_FREEBSD) || defined=
(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>     const char *device =3D tt-&gt;actual_name;</span><br><=
span>     if (r6-&gt;iface !=3D NULL) /* vpn server special route */</span>=
<br><span>     {</span><br><span>         device =3D r6-&gt;iface;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        gateway_needed =3D tru=
e;</span><br><span>     }</span><br><span>     (void)device; /* unused on s=
ome platforms */</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* if we used a gateway on &quot;add route&quot;, we also =
need to specify it on</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     * delete, otherwise some OSes will refuse to delete the route</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TAP &am=
p;&amp; !((r6-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp; r6-&gt;metric =
=3D=3D 0))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        gateway_needed =3D =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span> #endif</span><br><span> #endif</span><br><span> </span><br><span>@@ =
-2278,6 +2352,15 @@</span><br><span>     gateway =3D print_in6_addr(r6-&gt;=
gateway, 0, &amp;gc);</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_DARWIN) || d=
efined(TARGET_LINUX) || defined(TARGET_FREEBSD) \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    || defined(TARGET_DRAGONFLY) || defined(T=
ARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* if we used a gateway on &quot;add route&quot;, =
we also need to specify it on</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * delete, otherwise some OSes will refuse to delete the rout=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool gateway_needed =3D fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gateway_nee=
ded =3D is_gateway_needed_ipv6(r6, tt, network);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> #if defined(TARGET_DARWIN) || defined(TAR=
GET_FREEBSD) || defined(TARGET_DRAGONFLY) \</span><br><span>     || defined=
(TARGET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </span><br><spa=
n>@@ -2362,20 +2445,17 @@</span><br><span>     argv_msg(D_ROUTE, &amp;argv)=
;</span><br><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: =
MacOS X route delete -inet6 command failed&quot;);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_OPENBSD=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARG=
ET_OPENBSD) || defined(TARGET_NETBSD)</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delet=
e -inet6 %s -prefixlen %d %s&quot;, ROUTE_PATH, network, r6-&gt;netbits,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                gateway)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&a=
mp;argv, &quot;%s delete -inet6 %s -prefixlen %d&quot;, ROUTE_PATH, network=
, r6-&gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (gateway_need=
ed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;a=
rgv, &quot;%s&quot;, gateway);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span> </span><br><span>     argv_msg(D_ROUTE, &=
amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn=
_execve_check(&amp;argv, es, 0, &quot;ERROR: OpenBSD route delete -inet6 co=
mmand failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_N=
ETBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s =
delete -inet6 %s/%d %s&quot;, ROUTE_PATH, network, r6-&gt;netbits, gateway)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    argv_msg(D_ROUTE, &amp;argv);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp=
;argv, es, 0, &quot;ERROR: NetBSD route delete -inet6 command failed&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_execve=
_check(&amp;argv, es, 0, &quot;ERROR: OpenBSD/NetBSD route delete -inet6 co=
mmand failed&quot;);</span><br><span> </span><br><span> #elif defined(TARGE=
T_AIX)</span><br><span> </span><br><span>diff --git a/src/openvpn/tun.c b/s=
rc/openvpn/tun.c</span><br><span>index 06b7ae5..0df946b 100644</span><br><s=
pan>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><=
br><span>@@ -1383,7 +1383,7 @@</span><br><span>         add_route(&amp;r, t=
t, 0, NULL, es, NULL);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_NETBSD)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_NET=
BSD) || defined(TARGET_DRAGONFLY)</span><br><span>     in_addr_t remote_end=
 =3D INADDR_ANY; /* for &quot;virtual&quot; subnet topology */</span><br><s=
pan> </span><br><span>     if (tun_p2p)</span><br><span>@@ -1466,7 +1466,7 =
@@</span><br><span>         add_route(&amp;r, tt, 0, NULL, es, NULL);</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_F=
REEBSD)</span><br><span> </span><br><span>     /* example: ifconfig tun2 10=
.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */</span><br><span>    =
 if (tun_p2p) /* point-to-point tun */</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/721?usp=3De=
mail">change 721</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87777e74b1fd34781e1d72c9f99=
4eb84f39d800c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 721 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>

</body></html>=

--a4ANLehE0xY=--

