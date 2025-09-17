From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 17 Sep 2025 13:23:24 +0000
In-Reply-To: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
References: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
Reply-To: arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <35c2806c8ce94212807ca296f51844037b42952f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qTtnHLPrV3E="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Install host routes
 for ifconfig-push routes when DCO is enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: d12fk <heiko@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qTtnHLPrV3E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, ordex, plaisthos.

Hello flichtenheld, ordex,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail

to look at the new patch set (#6).


Change subject: Install host routes for ifconfig-push routes when DCO is en=
abled
......................................................................

Install host routes for ifconfig-push routes when DCO is enabled

ifconfig-push and ifconfig-ipv6-push can configure the IP address of a
client. If this IP address lies inside the network that is configured
on the ovpn/tun device this works as expected as the routing table point to
the ovpn/tun interface. However, if the IP address
is outside that range, the IP packets are not forwarded to the ovpn/tun
interface.

This patch adds logic to add host routes for these
ifconfig-push/ifconfig-ipv6-push addresses to ensure that traffic for
these IP addresses is also directed to the VPN.

For Linux it is important that these extra routes are routes using scope li=
nk
rather than static since otherwise routes via these IP addresses, like
iroute, will not work. On FreeBSD we also use interface routes as works and
routes that target interfaces instead of IP addresses are less brittle.

Tested using a server with ccd:

   openvpn --server 10.33.0.0 255.255.192.0 --server-ipv6 fd00:f00f::1/64  =
--client-config-dir ~/ccd [...]

and a client with lwipvonpn and the following ccd file:

   iroute-ipv6 FD00:F00F:CAFE::1001/64
   ifconfig-ipv6-push FD00:F00F:D00D::77/64
   push "setenv-safe ifconfig_ipv6_local_2 FD00:F00F:CAFE::1001"
   push "setenv-safe ifconfig_ipv6_netbits_2 64"

   iroute 10.234.234.0 255.255.255.0
   ifconfig-push 10.11.12.13 255.255.255.0
   push "setenv-safe ifconfig_local_2 10.234.234.12"
   push "setenv-safe ifconfig_netmask_2 255.255.255.0"

This setups an ifconfig-push addresses outside the --server/--server-ipv6
network and additionally configures a iroute behind that client. The
setenv-safe configure lwipovpn to use that additional IP addresses to allow
testing via ping.

Change-Id: I83295e00d1a756dfa44050b0a4493095fb050fff
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M doc/man-sections/server-options.rst
M src/openvpn/dco.c
M src/openvpn/mroute.h
M src/openvpn/multi.c
M src/openvpn/multi.h
5 files changed, 165 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1192/6

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index ccc1374..9c7fa46 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -314,6 +314,10 @@
   3.  Use ``--ifconfig-pool`` allocation for dynamic IP (last
       choice).

+  When DCO is enabled and the IP is not in contained in the network specif=
ied
+  by ``--ifconfig``, OpenVPN will install a /32 host route for the ``local=
``
+  IP address.
+
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` per-client static IPv6 interface
   configuration, see ``--client-config-dir`` and ``--ifconfig-push`` for
@@ -324,6 +328,10 @@

      ifconfig-ipv6-push ipv6addr/bits ipv6remote

+  When DCO is enabled and the IP is not in contained in the network specif=
ied
+  by ``--ifconfig-ipv6``, OpenVPN will install a /128 host route for the
+  ``ipv6addr`` IP address.
+
 --multihome
   Configure a multi-homed UDP server. This option needs to be used when a
   server has more than one IP address (e.g. multiple interfaces, or
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 70a8c0a..aae0b23 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -663,6 +663,14 @@
         return;
     }

+#if defined(_WIN32)
+    if (addr->type & MR_ONLINK_ADDR)
+    {
+        msg(D_MULTI_ERRORS, "Adding extra interface routes on Windows is "
+                            "currently not supported.");
+    }
+#endif
+
     struct context *c =3D &mi->context;
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
@@ -670,8 +678,14 @@
         dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->n=
etbits,
                                 c->c2.tls_multi->peer_id);
 #else
+        const struct in6_addr *gateway =3D &mi->context.c2.push_ifconfig_i=
pv6_local;
+        if (addr->type & MR_ONLINK_ADDR)
+        {
+            gateway =3D NULL;
+        }
+
         net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, addr->netbits,
-                         &mi->context.c2.push_ifconfig_ipv6_local, c->c1.t=
untap->actual_name, 0,
+                         gateway, c->c1.tuntap->actual_name, 0,
                          DCO_IROUTE_METRIC);
 #endif
     }
@@ -682,7 +696,13 @@
                                 c->c2.tls_multi->peer_id);
 #else
         in_addr_t dest =3D htonl(addr->v4.addr);
-        net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits, &mi->conte=
xt.c2.push_ifconfig_local,
+        const in_addr_t *gateway =3D &mi->context.c2.push_ifconfig_local;
+        if (addr->type & MR_ONLINK_ADDR)
+        {
+            gateway =3D NULL;
+        }
+
+        net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits, gateway,
                          c->c1.tuntap->actual_name, 0, DCO_IROUTE_METRIC);
 #endif
     }
@@ -713,6 +733,18 @@
                              DCO_IROUTE_METRIC);
 #endif
         }
+
+        /* Check if we added a host route as the assigned client IP addres=
s was
+         * not in the on link scope defined by --ifconfig */
+        if (multi_check_push_ifconfig_extra_route(mi))
+        {
+#if defined(_WIN32)
+            dco_win_del_iroute_ipv4(&c->c1.tuntap->dco, mi->context.c2.pus=
h_ifconfig_local, 32);
+#else
+            net_route_v4_del(&m->top.net_ctx, &mi->context.c2.push_ifconfi=
g_local, 32,
+                             NULL, c->c1.tuntap->actual_name, 0, DCO_IROUT=
E_METRIC);
+#endif
+        }
     }

     if (mi->context.c2.push_ifconfig_ipv6_defined)
@@ -727,6 +759,18 @@
                              DCO_IROUTE_METRIC);
 #endif
         }
+
+        /* Checked if we added a host route as the assigned client IP addr=
ess was
+         * outside the --ifconfig-ipv6 tun interface config */
+        if (multi_check_push_ifconfig_ipv6_extra_route(mi))
+        {
+#if defined(_WIN32)
+            dco_win_del_iroute_ipv6(&c->c1.tuntap->dco, mi->context.c2.pus=
h_ifconfig_ipv6_local, 128);
+#else
+            net_route_v6_del(&m->top.net_ctx, &mi->context.c2.push_ifconfi=
g_ipv6_local, 128,
+                             NULL, c->c1.tuntap->actual_name, 0, DCO_IROUT=
E_METRIC);
+#endif
+        }
     }
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_=
WIN32) */
 }
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 5b0c694..852ccb6 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -20,6 +20,7 @@
  *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

+
 #ifndef MROUTE_H
 #define MROUTE_H

@@ -74,6 +75,9 @@
 /* Address type mask indicating that proto # is part of address */
 #define MR_WITH_PROTO 32

+/* MRoute is an on link/scope address rather than a route */
+#define MR_ONLINK_ADDR 64
+
 struct mroute_addr
 {
     uint8_t len;     /* length of address */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6e4cc42..43ed4be 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -42,6 +42,7 @@
 #include "ssl_ncp.h"
 #include "vlan.h"
 #include "auth_token.h"
+#include "route.h"
 #include <inttypes.h>
 #include <string.h>

@@ -1240,11 +1241,26 @@
         management_learn_addr(management, &mi->context.c2.mda_context, &ad=
dr, primary);
     }
 #endif
-    if (!primary)
+    if (primary && multi_check_push_ifconfig_extra_route(mi))
     {
-        /* "primary" is the VPN ifconfig address of the peer and already
-         * known to DCO, so only install "extra" iroutes (primary =3D fals=
e)
-         */
+        /* "primary" is the VPN ifconfig address of the peer */
+        /* if it does not fall into the network defined by ifconfig_local
+         * we install this as extra onscope address on the interface  */
+        struct gc_arena gc =3D gc_new();
+        /* The IP address is not assigned inside the network of
+         * the DCO interface configured by --ifconfig */
+        msg(D_MULTI_LOW, "MULTI: Adding /32 on-link route for route %s -> =
%s",
+            print_in_addr_t(remote_si.addr.in4.sin_addr.s_addr, 0, &gc),
+            multi_instance_string(mi, false, &gc));
+
+        addr.netbits =3D 32;
+        addr.type |=3D MR_ONLINK_ADDR;
+
+        dco_install_iroute(m, mi, &addr);
+        gc_free(&gc);
+    }
+    else if (!primary)
+    {
         ASSERT(netbits >=3D 0); /* DCO requires populated netbits */
         dco_install_iroute(m, mi, &addr);
     }
@@ -1278,7 +1294,25 @@
         management_learn_addr(management, &mi->context.c2.mda_context, &ad=
dr, primary);
     }
 #endif
-    if (!primary)
+    if (primary && multi_check_push_ifconfig_ipv6_extra_route(mi))
+    {
+        /* "primary" is the VPN ifconfig address of the peer */
+        /* if it does not fall into the network defined by ifconfig_local
+         * we install this as extra onscope address on the interface  */
+        struct gc_arena gc =3D gc_new();
+        /* The IP address is not assigned to the interface of the DCO devi=
ce */
+        msg(D_MULTI_LOW, "MULTI: Adding /128 on-link route for "
+                         "ifconfig-ipv6-push %s -> %s",
+            print_in6_addr(mi->context.options.push_ifconfig_ipv6_local, 0=
, &gc),
+            multi_instance_string(mi, false, &gc));
+
+        addr.netbits =3D 128;
+        addr.type |=3D MR_ONLINK_ADDR;
+
+        dco_install_iroute(m, mi, &addr);
+        gc_free(&gc);
+    }
+    else if (!primary)
     {
         /* "primary" is the VPN ifconfig address of the peer and already
          * known to DCO, so only install "extra" iroutes (primary =3D fals=
e)
@@ -4309,3 +4343,49 @@
      *  }
      */
 }
+
+bool
+multi_check_push_ifconfig_extra_route(struct multi_instance *mi)
+{
+    struct options *o =3D &mi->context.options;
+    in_addr_t local_addr, local_netmask;
+
+    if (!o->ifconfig_local || !o->ifconfig_remote_netmask)
+    {
+        /* If we do not have a local address, we just return false as
+         * this check doesn't make sense. */
+        return false;
+    }
+
+    /* if it falls into the network defined by ifconfig_local we assume
+     * it is already known to DCO and only install "extra" iroutes  */
+    in_addr_t push_ifconfig_local =3D htonl(mi->context.c2.push_ifconfig_l=
ocal);
+    inet_pton(AF_INET, o->ifconfig_local, &local_addr);
+    inet_pton(AF_INET, o->ifconfig_remote_netmask, &local_netmask);
+
+    return (local_addr & local_netmask) !=3D (push_ifconfig_local & local_=
netmask);
+}
+
+bool
+multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi)
+{
+    struct options *o =3D &mi->context.options;
+
+    if (!o->ifconfig_ipv6_local || !o->ifconfig_ipv6_netbits)
+    {
+        /* If we do not have a local address, we just return false as
+         * this check doesn't make sense. */
+        return false;
+    }
+
+    /* if it falls into the network defined by ifconfig_local we assume
+     * it is already known to DCO and only install "extra" iroutes  */
+    struct in6_addr ifconfig_local;
+    if (inet_pton(AF_INET6, o->ifconfig_ipv6_local, &ifconfig_local) !=3D =
1)
+    {
+        return false;
+    }
+
+    return (!ipv6_net_contains_host(&ifconfig_local, o->ifconfig_ipv6_netb=
its,
+                                    &o->push_ifconfig_ipv6_local));
+}
\ No newline at end of file
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 087c0e6..bc58d38 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -666,6 +666,28 @@
     return ret;
 }

+/**
+ * Determines if the ifconfig_push_local address falls into the range of t=
he local
+ * IP addresses of the VPN interface (ifconfig_local with ifconfig_remote_=
netmask)
+ *
+ * @param mi           The multi-instance to check this condition for
+ *
+ * @return Returns true if ifconfig_push is outside that range and require=
s an extra
+ * route to be installed.
+ */
+bool
+multi_check_push_ifconfig_extra_route(struct multi_instance *mi);
+
+/**
+ * Determines if the ifconfig_ipv6_local address falls into the range of t=
he local
+ * IP addresses of the VPN interface (ifconfig_local with ifconfig_remote_=
netmask)
+ *
+ * @return Returns true if ifconfig_push is outside that range and require=
s an extra
+ * route to be installed.
+ */
+bool
+multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi);
+
 /*
  * Check for signals.
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I83295e00d1a756dfa44050b0a4493095fb050fff
Gerrit-Change-Number: 1192
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--qTtnHLPrV3E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, ordex, plais=
thos. </p>
<p>plaisthos <strong>uploaded patch set #6</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Install host routes for ifconfig-push routes when DCO is enabled<br>=
<br>ifconfig-push and ifconfig-ipv6-push can configure the IP address of a<=
br>client. If this IP address lies inside the network that is configured<br=
>on the ovpn/tun device this works as expected as the routing table point t=
o<br>the ovpn/tun interface. However, if the IP address<br>is outside that =
range, the IP packets are not forwarded to the ovpn/tun<br>interface.<br><b=
r>This patch adds logic to add host routes for these<br>ifconfig-push/ifcon=
fig-ipv6-push addresses to ensure that traffic for<br>these IP addresses is=
 also directed to the VPN.<br><br>For Linux it is important that these extr=
a routes are routes using scope link<br>rather than static since otherwise =
routes via these IP addresses, like<br>iroute, will not work. On FreeBSD we=
 also use interface routes as works and<br>routes that target interfaces in=
stead of IP addresses are less brittle.<br><br>Tested using a server with c=
cd:<br><br>   openvpn --server 10.33.0.0 255.255.192.0 --server-ipv6 fd00:f=
00f::1/64  --client-config-dir ~/ccd [...]<br><br>and a client with lwipvon=
pn and the following ccd file:<br><br>   iroute-ipv6 FD00:F00F:CAFE::1001/6=
4<br>   ifconfig-ipv6-push FD00:F00F:D00D::77/64<br>   push &quot;setenv-sa=
fe ifconfig_ipv6_local_2 FD00:F00F:CAFE::1001&quot;<br>   push &quot;setenv=
-safe ifconfig_ipv6_netbits_2 64&quot;<br><br>   iroute 10.234.234.0 255.25=
5.255.0<br>   ifconfig-push 10.11.12.13 255.255.255.0<br>   push &quot;sete=
nv-safe ifconfig_local_2 10.234.234.12&quot;<br>   push &quot;setenv-safe i=
fconfig_netmask_2 255.255.255.0&quot;<br><br>This setups an ifconfig-push a=
ddresses outside the --server/--server-ipv6<br>network and additionally con=
figures a iroute behind that client. The<br>setenv-safe configure lwipovpn =
to use that additional IP addresses to allow<br>testing via ping.<br><br>Ch=
ange-Id: I83295e00d1a756dfa44050b0a4493095fb050fff<br>Signed-off-by: Arne S=
chwabe &lt;arne@...1227...&gt;<br>---<br>M doc/man-sections/server-options.=
rst<br>M src/openvpn/dco.c<br>M src/openvpn/mroute.h<br>M src/openvpn/multi=
.c<br>M src/openvpn/multi.h<br>5 files changed, 165 insertions(+), 7 deleti=
ons(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/92/1192/6</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/doc/man-sections/server-options.rst b/doc=
/man-sections/server-options.rst</span><br><span>index ccc1374..9c7fa46 100=
644</span><br><span>--- a/doc/man-sections/server-options.rst</span><br><sp=
an>+++ b/doc/man-sections/server-options.rst</span><br><span>@@ -314,6 +314=
,10 @@</span><br><span>   3.  Use ``--ifconfig-pool`` allocation for dynami=
c IP (last</span><br><span>       choice).</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  When DCO is enabled and the IP i=
s not in contained in the network specified</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  by ``--ifconfig``, OpenVPN will install a /32 hos=
t route for the ``local``</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  IP address.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> --ifconfig-ipv6-push args</span><br><span>   for ``--clie=
nt-config-dir`` per-client static IPv6 interface</span><br><span>   configu=
ration, see ``--client-config-dir`` and ``--ifconfig-push`` for</span><br><=
span>@@ -324,6 +328,10 @@</span><br><span> </span><br><span>      ifconfig-=
ipv6-push ipv6addr/bits ipv6remote</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  When DCO is enabled and the IP is not i=
n contained in the network specified</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  by ``--ifconfig-ipv6``, OpenVPN will install a /128 host=
 route for the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``i=
pv6addr`` IP address.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> --multihome</span><br><span>   Configure a multi-homed =
UDP server. This option needs to be used when a</span><br><span>   server h=
as more than one IP address (e.g. multiple interfaces, or</span><br><span>d=
iff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 70a=
8c0a..aae0b23 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><spa=
n>+++ b/src/openvpn/dco.c</span><br><span>@@ -663,6 +663,14 @@</span><br><s=
pan>         return;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (addr-&gt;type &amp; MR_ON=
LINK_ADDR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERR=
ORS, &quot;Adding extra interface routes on Windows is &quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                            &quot=
;currently not supported.&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     struct context *c =3D &amp;mi-&gt;context;</span><br><span>     if=
 (addrtype =3D=3D MR_ADDR_IPV6)</span><br><span>     {</span><br><span>@@ -=
670,8 +678,14 @@</span><br><span>         dco_win_add_iroute_ipv6(&amp;c-&g=
t;c1.tuntap-&gt;dco, addr-&gt;v6.addr, addr-&gt;netbits,</span><br><span>  =
                               c-&gt;c2.tls_multi-&gt;peer_id);</span><br><=
span> #else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
const struct in6_addr *gateway =3D &amp;mi-&gt;context.c2.push_ifconfig_ipv=
6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(addr-&gt;type &amp; MR_ONLINK_ADDR)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            gateway =3D NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>         net_route_v6_add(&amp;m-&gt;top.net_ctx, &=
amp;addr-&gt;v6.addr, addr-&gt;netbits,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                         &amp;mi-&gt;context.c2.push_ifco=
nfig_ipv6_local, c-&gt;c1.tuntap-&gt;actual_name, 0,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                         gateway, c-&gt;c=
1.tuntap-&gt;actual_name, 0,</span><br><span>                          DCO_=
IROUTE_METRIC);</span><br><span> #endif</span><br><span>     }</span><br><s=
pan>@@ -682,7 +696,13 @@</span><br><span>                                 c=
-&gt;c2.tls_multi-&gt;peer_id);</span><br><span> #else</span><br><span>    =
     in_addr_t dest =3D htonl(addr-&gt;v4.addr);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        net_route_v4_add(&amp;m-&gt;top.net_ctx,=
 &amp;dest, addr-&gt;netbits, &amp;mi-&gt;context.c2.push_ifconfig_local,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const in_addr=
_t *gateway =3D &amp;mi-&gt;context.c2.push_ifconfig_local;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (addr-&gt;type &amp; MR_=
ONLINK_ADDR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gatew=
ay =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        net_route_v4_add(&amp;m-&gt;=
top.net_ctx, &amp;dest, addr-&gt;netbits, gateway,</span><br><span>        =
                  c-&gt;c1.tuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</=
span><br><span> #endif</span><br><span>     }</span><br><span>@@ -713,6 +73=
3,18 @@</span><br><span>                              DCO_IROUTE_METRIC);</=
span><br><span> #endif</span><br><span>         }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* Check if we added a host route as the assigned client=
 IP address was</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * not in the on link scope defined by --ifconfig */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (multi_check_push_ifconfig_=
extra_route(mi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            d=
co_win_del_iroute_ipv4(&amp;c-&gt;c1.tuntap-&gt;dco, mi-&gt;context.c2.push=
_ifconfig_local, 32);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
net_route_v4_del(&amp;m-&gt;top.net_ctx, &amp;mi-&gt;context.c2.push_ifconf=
ig_local, 32,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                       NULL, c-&gt;c1.tuntap-&gt;actual_name, 0, DCO_IROUTE=
_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an>     }</span><br><span> </span><br><span>     if (mi-&gt;context.c2.push=
_ifconfig_ipv6_defined)</span><br><span>@@ -727,6 +759,18 @@</span><br><spa=
n>                              DCO_IROUTE_METRIC);</span><br><span> #endif=
</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
Checked if we added a host route as the assigned client IP address was</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * outside the -=
-ifconfig-ipv6 tun interface config */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (multi_check_push_ifconfig_ipv6_extra_route(m=
i))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            dco_win_del_ir=
oute_ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, mi-&gt;context.c2.push_ifconfig_ipv=
6_local, 128);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            net_rou=
te_v6_del(&amp;m-&gt;top.net_ctx, &amp;mi-&gt;context.c2.push_ifconfig_ipv6=
_local, 128,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                      NULL, c-&gt;c1.tuntap-&gt;actual_name, 0, DCO_IROUTE_=
METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n>     }</span><br><span> #endif /* if defined(TARGET_LINUX) || defined(TAR=
GET_FREEBSD) || defined(_WIN32) */</span><br><span> }</span><br><span>diff =
--git a/src/openvpn/mroute.h b/src/openvpn/mroute.h</span><br><span>index 5=
b0c694..852ccb6 100644</span><br><span>--- a/src/openvpn/mroute.h</span><br=
><span>+++ b/src/openvpn/mroute.h</span><br><span>@@ -20,6 +20,7 @@</span><=
br><span>  *  with this program; if not, see &lt;https://www.gnu.org/licens=
es/&gt;.</span><br><span>  */</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> #ifndef MROUTE_H</span><br><s=
pan> #define MROUTE_H</span><br><span> </span><br><span>@@ -74,6 +75,9 @@</=
span><br><span> /* Address type mask indicating that proto # is part of add=
ress */</span><br><span> #define MR_WITH_PROTO 32</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* MRoute is an on link/sco=
pe address rather than a route */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define MR_ONLINK_ADDR 64</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> struct mroute_addr</span><br><span> {=
</span><br><span>     uint8_t len;     /* length of address */</span><br><s=
pan>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>=
index 6e4cc42..43ed4be 100644</span><br><span>--- a/src/openvpn/multi.c</sp=
an><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -42,6 +42,7 @@</s=
pan><br><span> #include &quot;ssl_ncp.h&quot;</span><br><span> #include &qu=
ot;vlan.h&quot;</span><br><span> #include &quot;auth_token.h&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;route.h&quot;=
</span><br><span> #include &lt;inttypes.h&gt;</span><br><span> #include &lt=
;string.h&gt;</span><br><span> </span><br><span>@@ -1240,11 +1241,26 @@</sp=
an><br><span>         management_learn_addr(management, &amp;mi-&gt;context=
.c2.mda_context, &amp;addr, primary);</span><br><span>     }</span><br><spa=
n> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!pri=
mary)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (primar=
y &amp;&amp; multi_check_push_ifconfig_extra_route(mi))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* &quot;p=
rimary&quot; is the VPN ifconfig address of the peer and already</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-         * known to DCO, so only=
 install &quot;extra&quot; iroutes (primary =3D false)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* &quot;primary&quot; is the VPN ifconfig=
 address of the peer */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* if it does not fall into the network defined by ifconfig_loc=
al</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * we ins=
tall this as extra onscope address on the interface  */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The IP =
address is not assigned inside the network of</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * the DCO interface configured by --ifco=
nfig */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
D_MULTI_LOW, &quot;MULTI: Adding /32 on-link route for route %s -&gt; %s&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pri=
nt_in_addr_t(remote_si.addr.in4.sin_addr.s_addr, 0, &amp;gc),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            multi_instance_string=
(mi, false, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        addr.net=
bits =3D 32;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 addr.type |=3D MR_ONLINK_ADDR;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 dco_install_iroute(m, mi, &amp;addr);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else if (!primary)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span>         ASSERT(netbits &gt;=3D 0); /* =
DCO requires populated netbits */</span><br><span>         dco_install_irou=
te(m, mi, &amp;addr);</span><br><span>     }</span><br><span>@@ -1278,7 +12=
94,25 @@</span><br><span>         management_learn_addr(management, &amp;mi=
-&gt;context.c2.mda_context, &amp;addr, primary);</span><br><span>     }</s=
pan><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (!primary)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (primary &amp;&amp; multi_check_push_ifconfig_ipv6_extra_route(mi))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* &quot;primary&quot; is th=
e VPN ifconfig address of the peer */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* if it does not fall into the network defined b=
y ifconfig_local</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * we install this as extra onscope address on the interface  */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* The IP address is not assigned to the interface of the DCO device */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI=
_LOW, &quot;MULTI: Adding /128 on-link route for &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                         &quot;ifconfig=
-ipv6-push %s -&gt; %s&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            print_in6_addr(mi-&gt;context.options.push_ifconfig_i=
pv6_local, 0, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            multi_instance_string(mi, false, &amp;gc));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        addr.netbits =3D 128;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        addr.type |=3D MR_ONLINK_ADDR;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        dco_install_iroute(m, mi, &amp;addr)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (!primary)</sp=
an><br><span>     {</span><br><span>         /* &quot;primary&quot; is the =
VPN ifconfig address of the peer and already</span><br><span>          * kn=
own to DCO, so only install &quot;extra&quot; iroutes (primary =3D false)</=
span><br><span>@@ -4309,3 +4343,49 @@</span><br><span>      *  }</span><br>=
<span>      */</span><br><span> }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifc=
onfig_extra_route(struct multi_instance *mi)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct options *o =3D &amp;mi-&gt;context.options;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t local_addr, local_n=
etmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;ifconfig_local |=
| !o-&gt;ifconfig_remote_netmask)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* If we do not have a local address, we just return false as</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * this check doe=
sn&#39;t make sense. */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if it falls into the=
 network defined by ifconfig_local we assume</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * it is already known to DCO and only install=
 &quot;extra&quot; iroutes  */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    in_addr_t push_ifconfig_local =3D htonl(mi-&gt;context.c2.pu=
sh_ifconfig_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    inet_pton(AF_INET, o-&gt;ifconfig_local, &amp;local_addr);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    inet_pton(AF_INET, o-&gt;ifc=
onfig_remote_netmask, &amp;local_netmask);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return (local_addr &amp; local_netmask) !=3D (push_ifconfig_local &=
amp; local_netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+multi_check_push_ifconfig_ipv6_extra_route(struct m=
ulti_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct options =
*o =3D &amp;mi-&gt;context.options;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!o-&gt;ifconfig_ipv6_local || !o-&gt;ifconfig_ipv6_netbits)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* If we do not have a local address=
, we just return false as</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         * this check doesn&#39;t make sense. */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* if it falls into the network defined by ifconfig_local we assume=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * it is alread=
y known to DCO and only install &quot;extra&quot; iroutes  */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr ifconfig_loca=
l;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (inet_pton=
(AF_INET6, o-&gt;ifconfig_ipv6_local, &amp;ifconfig_local) !=3D 1)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return (!ipv6_net_contains_host(&amp;ifconfig_local, o-&gt;ifconfig_=
ipv6_netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                              &amp;o-&gt;push_ifconfig_ipv6_local));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No new=
line at end of file</span><br><span>diff --git a/src/openvpn/multi.h b/src/=
openvpn/multi.h</span><br><span>index 087c0e6..bc58d38 100644</span><br><sp=
an>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</spa=
n><br><span>@@ -666,6 +666,28 @@</span><br><span>     return ret;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Deter=
mines if the ifconfig_push_local address falls into the range of the local<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * IP addresses of t=
he VPN interface (ifconfig_local with ifconfig_remote_netmask)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param mi           The multi-instance to chec=
k this condition for</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Retur=
ns true if ifconfig_push is outside that range and requires an extra</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * route to be installed.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+multi_check_push_ifconfig_extra_route(struct multi_=
instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Determines if the ifconfig_ipv6_local=
 address falls into the range of the local</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * IP addresses of the VPN interface (ifconfig_local=
 with ifconfig_remote_netmask)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn Returns true if ifconfig_push is outside that range and requires an ex=
tra</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * route to be i=
nstalled.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_ipv6_extra_rout=
e(struct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /*</span><br><span>  * Check for signals.</span=
><br><span>  */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">change 1192</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1192?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I83295e00d1a756dfa44050b0a44=
93095fb050fff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1192 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--qTtnHLPrV3E=--

