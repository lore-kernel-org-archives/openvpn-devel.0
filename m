From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 16 Sep 2025 13:50:02 +0000
In-Reply-To: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
References: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a040451a978b7f438a217f92a9efa4462502b5e4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c4lhaRy6ujY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Install host routes
 with onlink scope iroutes for ifconfig-push routes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--c4lhaRy6ujY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail

to look at the new patch set (#3).


Change subject: Install host routes with onlink scope iroutes for ifconfig-=
push routes
......................................................................

Install host routes with onlink scope iroutes for ifconfig-push routes

Additional IP addresses for hosts that lie outside the primary network
of the configured device need to be added to the operating system to
ensure that traffic for these IP addresses is also directed to the VPN.

For Linux it is important that these extra routes are routes using scope li=
nk
rather than static since otherwise routes via these IP addresses, like
iroute, will not work.

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

Change-Id: I83295e00d1a756dfa44050b0a4493095fb050fff
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M doc/man-sections/server-options.rst
M src/openvpn/dco.c
M src/openvpn/mroute.h
M src/openvpn/multi.c
M src/openvpn/multi.h
5 files changed, 156 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1192/3

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index ccc1374..3cd84dd 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -314,6 +314,9 @@
   3.  Use ``--ifconfig-pool`` allocation for dynamic IP (last
       choice).

+  When DCO is enabled, OpenVPN will install a /32 route for the local IP
+  address
+
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` per-client static IPv6 interface
   configuration, see ``--client-config-dir`` and ``--ifconfig-push`` for
@@ -324,6 +327,9 @@

      ifconfig-ipv6-push ipv6addr/bits ipv6remote

+  When DCO is enabled, OpenVPN will install a /128 route for the local IP
+  address.
+
 --multihome
   Configure a multi-homed UDP server. This option needs to be used when a
   server has more than one IP address (e.g. multiple interfaces, or
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 70a8c0a..bbcda1d 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -670,8 +670,14 @@
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
@@ -682,7 +688,13 @@
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
@@ -713,6 +725,18 @@
                              DCO_IROUTE_METRIC);
 #endif
         }
+
+        /* Check if we added the local network as /32 route as it was not =
in
+         * the normal on link scope */
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
@@ -727,6 +751,15 @@
                              DCO_IROUTE_METRIC);
 #endif
         }
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
index 5b0c694..f4e54ca 100644
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
=20
+/* MRoute is an on link/scope address  ather than a route */
+#define MR_ONLINK_ADDR 64
+
 struct mroute_addr
 {
     uint8_t len;     /* length of address */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6e4cc42..efbaa22 100644
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
+    if (primary && multi_check_push_ifconfig_extra_route(mi))
+    {
+        /* "primary" is the VPN ifconfig address of the peer */
+        /* if it does not fall into the network defined by ifconfig_local
+         * we install this as extra onscope address on the interface  */
+        struct gc_arena gc =3D gc_new();
+        /* The IP address is not assigned to the interface of the DCO devi=
ce */
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
+
     if (!primary)
     {
-        /* "primary" is the VPN ifconfig address of the peer and already
-         * known to DCO, so only install "extra" iroutes (primary =3D fals=
e)
-         */
         ASSERT(netbits >=3D 0); /* DCO requires populated netbits */
         dco_install_iroute(m, mi, &addr);
     }
@@ -1278,6 +1294,24 @@
         management_learn_addr(management, &mi->context.c2.mda_context, &ad=
dr, primary);
     }
 #endif
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
     if (!primary)
     {
         /* "primary" is the VPN ifconfig address of the peer and already
@@ -4309,3 +4343,57 @@
      *  }
      */
 }
+
+/**
+ * Determines if the ifconfig_push_local address falls into the range of t=
he local
+ * IP addresses of the VPN interface (ifconfig_local with ifconfig_remote_=
netmask)
+ *
+ * @return Returns true if ifconfig_push is outside that range and require=
s an extra
+ * route to be installed.
+ */
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
+    return (!route_ipv6_match_host(&ifconfig_local, o->ifconfig_ipv6_netbi=
ts,
+                                   &o->push_ifconfig_ipv6_local));
+}
\ No newline at end of file
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 087c0e6..5ec3904 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -666,6 +666,26 @@
     return ret;
 }

+/**
+ * Determines if the ifconfig_push_local address falls into the range of t=
he local
+ * IP addresses of the VPN interface (ifconfig_local with ifconfig_remote_=
netmask)
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--c4lhaRy6ujY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Install host routes with onlink scope iroutes for ifconfig-push rout=
es<br><br>Additional IP addresses for hosts that lie outside the primary ne=
twork<br>of the configured device need to be added to the operating system =
to<br>ensure that traffic for these IP addresses is also directed to the VP=
N.<br><br>For Linux it is important that these extra routes are routes usin=
g scope link<br>rather than static since otherwise routes via these IP addr=
esses, like<br>iroute, will not work.<br><br>Tested using a server with ccd=
:<br><br>   openvpn --server 10.33.0.0 255.255.192.0 --server-ipv6 fd00:f00=
f::1/64  --client-config-dir ~/ccd [...]<br><br>and a client with lwipvonpn=
 and the following ccd file:<br><br>   iroute-ipv6 FD00:F00F:CAFE::1001/64<=
br>   ifconfig-ipv6-push FD00:F00F:D00D::77/64<br>   push &quot;setenv-safe=
 ifconfig_ipv6_local_2 FD00:F00F:CAFE::1001&quot;<br>   push &quot;setenv-s=
afe ifconfig_ipv6_netbits_2 64&quot;<br><br>   iroute 10.234.234.0 255.255.=
255.0<br>   ifconfig-push 10.11.12.13 255.255.255.0<br>   push &quot;setenv=
-safe ifconfig_local_2 10.234.234.12&quot;<br>   push &quot;setenv-safe ifc=
onfig_netmask_2 255.255.255.0&quot;<br><br>Change-Id: I83295e00d1a756dfa440=
50b0a4493095fb050fff<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;=
<br>---<br>M doc/man-sections/server-options.rst<br>M src/openvpn/dco.c<br>=
M src/openvpn/mroute.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br=
>5 files changed, 156 insertions(+), 5 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/92/1192/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options=
.rst</span><br><span>index ccc1374..3cd84dd 100644</span><br><span>--- a/do=
c/man-sections/server-options.rst</span><br><span>+++ b/doc/man-sections/se=
rver-options.rst</span><br><span>@@ -314,6 +314,9 @@</span><br><span>   3. =
 Use ``--ifconfig-pool`` allocation for dynamic IP (last</span><br><span>  =
     choice).</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  When DCO is enabled, OpenVPN will install a /32 route for the=
 local IP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  address =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> -=
-ifconfig-ipv6-push args</span><br><span>   for ``--client-config-dir`` per=
-client static IPv6 interface</span><br><span>   configuration, see ``--cli=
ent-config-dir`` and ``--ifconfig-push`` for</span><br><span>@@ -324,6 +327=
,9 @@</span><br><span> </span><br><span>      ifconfig-ipv6-push ipv6addr/b=
its ipv6remote</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  When DCO is enabled, OpenVPN will install a /128 route for t=
he local IP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  addres=
s.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 --multihome</span><br><span>   Configure a multi-homed UDP server. This op=
tion needs to be used when a</span><br><span>   server has more than one IP=
 address (e.g. multiple interfaces, or</span><br><span>diff --git a/src/ope=
nvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 70a8c0a..bbcda1d 10064=
4</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn=
/dco.c</span><br><span>@@ -670,8 +670,14 @@</span><br><span>         dco_wi=
n_add_iroute_ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v6.addr, addr-&gt;=
netbits,</span><br><span>                                 c-&gt;c2.tls_mult=
i-&gt;peer_id);</span><br><span> #else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        const struct in6_addr *gateway =3D &amp;mi-&gt;c=
ontext.c2.push_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (addr-&gt;type &amp; MR_ONLINK_ADDR)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            gateway =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         net_route_v6_ad=
d(&amp;m-&gt;top.net_ctx, &amp;addr-&gt;v6.addr, addr-&gt;netbits,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                         &amp;=
mi-&gt;context.c2.push_ifconfig_ipv6_local, c-&gt;c1.tuntap-&gt;actual_name=
, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
          gateway, c-&gt;c1.tuntap-&gt;actual_name, 0,</span><br><span>    =
                      DCO_IROUTE_METRIC);</span><br><span> #endif</span><br=
><span>     }</span><br><span>@@ -682,7 +688,13 @@</span><br><span>        =
                         c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span> =
#else</span><br><span>         in_addr_t dest =3D htonl(addr-&gt;v4.addr);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        net_route_v4_a=
dd(&amp;m-&gt;top.net_ctx, &amp;dest, addr-&gt;netbits, &amp;mi-&gt;context=
.c2.push_ifconfig_local,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        const in_addr_t *gateway =3D &amp;mi-&gt;context.c2.push_ifcon=
fig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (addr-&gt;type &amp; MR_ONLINK_ADDR)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            gateway =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ne=
t_route_v4_add(&amp;m-&gt;top.net_ctx, &amp;dest, addr-&gt;netbits, gateway=
,</span><br><span>                          c-&gt;c1.tuntap-&gt;actual_name=
, 0, DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><span>     }</sp=
an><br><span>@@ -713,6 +725,18 @@</span><br><span>                         =
     DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><span>         }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* Check if we added the local=
 network as /32 route as it was not in</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * the normal on link scope */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (multi_check_push_ifconfig=
_extra_route(mi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
dco_win_del_iroute_ipv4(&amp;c-&gt;c1.tuntap-&gt;dco, mi-&gt;context.c2.pus=
h_ifconfig_local, 32);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 net_route_v4_del(&amp;m-&gt;top.net_ctx, &amp;mi-&gt;context.c2.push_ifcon=
fig_local, 32,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                        NULL, c-&gt;c1.tuntap-&gt;actual_name, 0, DCO_IROUT=
E_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan>     }</span><br><span> </span><br><span>     if (mi-&gt;context.c2.pus=
h_ifconfig_ipv6_defined)</span><br><span>@@ -727,6 +751,15 @@</span><br><sp=
an>                              DCO_IROUTE_METRIC);</span><br><span> #endi=
f</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (multi_check_push_ifconfig_ipv6_extra_route(mi))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            dco_win_del_iroute_ipv6(=
&amp;c-&gt;c1.tuntap-&gt;dco, mi-&gt;context.c2.push_ifconfig_ipv6_local, 1=
28);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            net_route_v6_del(=
&amp;m-&gt;top.net_ctx, &amp;mi-&gt;context.c2.push_ifconfig_ipv6_local, 12=
8,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
            NULL, c-&gt;c1.tuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</=
span><br><span> #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D) || defined(_WIN32) */</span><br><span> }</span><br><span>diff --git a/sr=
c/openvpn/mroute.h b/src/openvpn/mroute.h</span><br><span>index 5b0c694..f4=
e54ca 100644</span><br><span>--- a/src/openvpn/mroute.h</span><br><span>+++=
 b/src/openvpn/mroute.h</span><br><span>@@ -20,6 +20,7 @@</span><br><span> =
 *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</=
span><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> #ifndef MROUTE_H</span><br><span> #defi=
ne MROUTE_H</span><br><span> </span><br><span>@@ -74,6 +75,9 @@</span><br><=
span> /* Address type mask indicating that proto # is part of address */</s=
pan><br><span> #define MR_WITH_PROTO 32</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* MRoute is an on link/scope address=
  ather than a route */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define MR_ONLINK_ADDR 64</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> struct mroute_addr</span><br><span> {</span><br=
><span>     uint8_t len;     /* length of address */</span><br><span>diff -=
-git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 6e4c=
c42..efbaa22 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><sp=
an>+++ b/src/openvpn/multi.c</span><br><span>@@ -42,6 +42,7 @@</span><br><s=
pan> #include &quot;ssl_ncp.h&quot;</span><br><span> #include &quot;vlan.h&=
quot;</span><br><span> #include &quot;auth_token.h&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;route.h&quot;</span><br=
><span> #include &lt;inttypes.h&gt;</span><br><span> #include &lt;string.h&=
gt;</span><br><span> </span><br><span>@@ -1240,11 +1241,26 @@</span><br><sp=
an>         management_learn_addr(management, &amp;mi-&gt;context.c2.mda_co=
ntext, &amp;addr, primary);</span><br><span>     }</span><br><span> #endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (primary &amp=
;&amp; multi_check_push_ifconfig_extra_route(mi))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* &quot;primary&quot; is the VPN ifconfig address =
of the peer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* if it does not fall into the network defined by ifconfig_local</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * we install this=
 as extra onscope address on the interface  */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The IP address i=
s not assigned to the interface of the DCO device */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;MULTI: Add=
ing /32 on-link route for route %s -&gt; %s&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            print_in_addr_t(remote_si.addr.i=
n4.sin_addr.s_addr, 0, &amp;gc),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            multi_instance_string(mi, false, &amp;gc));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        addr.netbits =3D 32;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        addr.type |=3D MR_ONLINK_ADD=
R;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        dco_install_iroute(m, mi, &a=
mp;addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    if (!primary)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        /* &quot;primary&quot; is the VPN ifconfig addre=
ss of the peer and already</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-         * known to DCO, so only install &quot;extra&quot; iroutes (pr=
imary =3D false)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
    */</span><br><span>         ASSERT(netbits &gt;=3D 0); /* DCO requires =
populated netbits */</span><br><span>         dco_install_iroute(m, mi, &am=
p;addr);</span><br><span>     }</span><br><span>@@ -1278,6 +1294,24 @@</spa=
n><br><span>         management_learn_addr(management, &amp;mi-&gt;context.=
c2.mda_context, &amp;addr, primary);</span><br><span>     }</span><br><span=
> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pri=
mary &amp;&amp; multi_check_push_ifconfig_ipv6_extra_route(mi))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* &quot;primary&quot; is the VPN ifc=
onfig address of the peer */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* if it does not fall into the network defined by ifconfi=
g_local</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * w=
e install this as extra onscope address on the interface  */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Th=
e IP address is not assigned to the interface of the DCO device */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &qu=
ot;MULTI: Adding /128 on-link route for &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                         &quot;ifconfig-ipv6-pus=
h %s -&gt; %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            print_in6_addr(mi-&gt;context.options.push_ifconfig_ipv6_local=
, 0, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       multi_instance_string(mi, false, &amp;gc));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        addr.netbits =3D 128;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        addr.type |=3D MR_ONLINK_ADDR;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        dco_install_iroute(m, mi, &amp;addr);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
>     if (!primary)</span><br><span>     {</span><br><span>         /* &quo=
t;primary&quot; is the VPN ifconfig address of the peer and already</span><=
br><span>@@ -4309,3 +4343,57 @@</span><br><span>      *  }</span><br><span>=
      */</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Determines if the ifconf=
ig_push_local address falls into the range of the local</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * IP addresses of the VPN interface (i=
fconfig_local with ifconfig_remote_netmask)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return Returns true if ifconfig_push is outside that range and r=
equires an extra</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
route to be installed.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_ex=
tra_route(struct multi_instance *mi)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct options *o =3D &amp;mi-&gt;context.options;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    in_addr_t local_addr, local_netmask;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;ifconfig_local || !o-&gt=
;ifconfig_remote_netmask)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* If we do not have a local address, we just return false as</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * this check doesn&#39;t=
 make sense. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* if it falls into the network=
 defined by ifconfig_local we assume</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * it is already known to DCO and only install &quot;e=
xtra&quot; iroutes  */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    in_addr_t push_ifconfig_local =3D htonl(mi-&gt;context.c2.push_ifcon=
fig_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet=
_pton(AF_INET, o-&gt;ifconfig_local, &amp;local_addr);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    inet_pton(AF_INET, o-&gt;ifconfig_re=
mote_netmask, &amp;local_netmask);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return (local_addr &amp; local_netmask) !=3D (push_ifconfig_local &amp; loc=
al_netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mul=
ti_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct options *o =3D &amp;mi-&gt;context.=
options;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;ifconfig_ipv6_l=
ocal || !o-&gt;ifconfig_ipv6_netbits)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* If we do not have a local address, we just return false as</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * this check=
 doesn&#39;t make sense. */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if it falls into=
 the network defined by ifconfig_local we assume</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * it is already known to DCO and only ins=
tall &quot;extra&quot; iroutes  */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct in6_addr ifconfig_local;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (inet_pton(AF_INET6, o-&gt;ifconfig_i=
pv6_local, &amp;ifconfig_local) !=3D 1)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (!route_ipv6_m=
atch_host(&amp;ifconfig_local, o-&gt;ifconfig_ipv6_netbits,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
&amp;o-&gt;push_ifconfig_ipv6_local));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span><br>=
<span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><spa=
n>index 087c0e6..5ec3904 100644</span><br><span>--- a/src/openvpn/multi.h</=
span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -666,6 +666,26 =
@@</span><br><span>     return ret;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Determines if the ifconfig_push_loc=
al address falls into the range of the local</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * IP addresses of the VPN interface (ifconfig_loc=
al with ifconfig_remote_netmask)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
return Returns true if ifconfig_push is outside that range and requires an =
extra</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * route to be=
 installed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_extra_route(s=
truct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Determines if the ifconfi=
g_ipv6_local address falls into the range of the local</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * IP addresses of the VPN interface (if=
config_local with ifconfig_remote_netmask)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @return Returns true if ifconfig_push is outside that range and re=
quires an extra</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * r=
oute to be installed.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_push_ifconfig_ipv=
6_extra_route(struct multi_instance *mi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Check for si=
gnals.</span><br><span>  */</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">chan=
ge 1192</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I83295e00d1a756dfa44050b0a44=
93095fb050fff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1192 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--c4lhaRy6ujY=--

