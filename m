From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 25 Feb 2025 09:48:06 +0000
References: <gerrit.1740476883000.Ic7b486ccb85df7fc1d6a573ac1315d235728822c@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <59b9f9a5fbf15b28541a27925a75d25abd90da63-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="prdlv6MB17E="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: redirect-gateway:
 add route toward new remote host when using persist...
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

--prdlv6MB17E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/901?usp=3Demail

to review the following change.


Change subject: redirect-gateway: add route toward new remote host when usi=
ng persist-tun
......................................................................

redirect-gateway: add route toward new remote host when using persist-tun

When both --redirect-gateway and --persist-tun are used together,
a route must be added for each new remote host we attempt to connect to.

Change-Id: Ic7b486ccb85df7fc1d6a573ac1315d235728822c
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/init.c
M src/openvpn/route.c
M src/openvpn/route.h
3 files changed, 188 insertions(+), 22 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/901/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b57e5f8..63b7bbf 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2184,6 +2184,10 @@
                         "route-pre-down",
                         c->c2.es);

+            if (c->mode =3D=3D CM_P2P && c->options.persist_tun)
+            {
+                del_route_towards_remote(c);
+            }
             delete_routes(c->c1.route_list, c->c1.route_ipv6_list,
                           c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->options),
                           c->c2.es, &c->net_ctx);
@@ -2245,6 +2249,11 @@
                         c->c2.es);
         }

+        if (c->mode =3D=3D CM_P2P && c->options.persist_tun)
+        {
+            del_route_towards_remote(c);
+        }
+
         del_wfp_block(c, adapter_index);
     }
     gc_free(&gc);
@@ -4825,6 +4834,17 @@
         }
     }

+    /**
+     * When using both --redirect-gateway and --persist-tun,
+     * if the connection to the server is lost, a /32 (or /128 if IPv6) ro=
ute must be added
+     * to ensure connectivity to the next remote.
+     */
+    if (c->mode =3D=3D CM_P2P
+        && c->options.persist_tun)
+    {
+        add_route_towards_remote(c);
+    }
+
     /*
      * Actually do UID/GID downgrade, and chroot, if requested.
      * May be delayed by --client, --pull, or --up-delay.
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bc41492..1e4deb5 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -43,6 +43,7 @@
 #include "options.h"
 #include "networking.h"
 #include "integer.h"
+#include "openvpn.h"

 #include "memdbg.h"

@@ -884,30 +885,14 @@
     }

     /* add VPN server host route if needed */
-    if (need_remote_ipv6_route)
+    if (need_remote_ipv6_route
+        && !(rl6->iflags & RL_DID_LOCAL))
     {
         if ( (rl6->rgi6.flags & (RGI_ADDR_DEFINED|RGI_IFACE_DEFINED) ) =3D=
=3D
              (RGI_ADDR_DEFINED|RGI_IFACE_DEFINED) )
         {
-            struct route_ipv6 *r6;
-            ALLOC_OBJ_CLEAR_GC(r6, struct route_ipv6, &rl6->gc);
-
-            r6->network =3D *remote_host_ipv6;
-            r6->netbits =3D 128;
-            if (!(rl6->rgi6.flags & RGI_ON_LINK) )
-            {
-                r6->gateway =3D rl6->rgi6.gateway.addr_ipv6;
-            }
-            r6->metric =3D 1;
-#ifdef _WIN32
-            r6->adapter_index =3D rl6->rgi6.adapter_index;
-#else
-            r6->iface =3D rl6->rgi6.iface;
-#endif
-            r6->flags =3D RT_DEFINED | RT_METRIC_DEFINED;
-
-            r6->next =3D rl6->routes_ipv6;
-            rl6->routes_ipv6 =3D r6;
+            rl6->routes_ipv6 =3D create_host_route_ipv6(*remote_host_ipv6,=
 rl6);
+            rl6->iflags |=3D RL_DID_LOCAL;
         }
         else
         {
@@ -919,6 +904,30 @@
     return ret;
 }

+struct route_ipv6 *
+create_host_route_ipv6(struct in6_addr remote_host_ipv6, struct route_ipv6=
_list *rl6)
+{
+    struct route_ipv6 *r6;
+    ALLOC_OBJ_CLEAR_GC(r6, struct route_ipv6, &rl6->gc);
+
+    r6->network =3D remote_host_ipv6;
+    r6->netbits =3D 128;
+    if (!(rl6->rgi6.flags & RGI_ON_LINK) )
+    {
+        r6->gateway =3D rl6->rgi6.gateway.addr_ipv6;
+    }
+    r6->metric =3D 1;
+#ifdef _WIN32
+    r6->adapter_index =3D rl6->rgi6.adapter_index;
+#else
+    r6->iface =3D rl6->rgi6.iface;
+#endif
+    r6->flags =3D RT_DEFINED | RT_METRIC_DEFINED;
+    r6->next =3D rl6->routes_ipv6;
+
+    return r6;
+}
+
 static bool
 add_route3(in_addr_t network,
            in_addr_t netmask,
@@ -1055,7 +1064,8 @@
                 /* if remote_host is not ipv4 (ie: ipv6), just skip
                  * adding this special /32 route */
                 if ((rl->spec.flags & RTSA_REMOTE_HOST)
-                    && rl->spec.remote_host !=3D IPV4_INVALID_ADDR)
+                    && rl->spec.remote_host !=3D IPV4_INVALID_ADDR
+                    && !(rl->iflags & RL_DID_LOCAL))
                 {
                     ret =3D add_route3(rl->spec.remote_host, IPV4_NETMASK_=
HOST,
                                      rl->rgi.gateway.addr, tt, flags | ROU=
TE_REF_GW,
@@ -1282,7 +1292,7 @@
         {
             delete_route_ipv6(r6, tt, flags, es, ctx);
         }
-        rl6->iflags &=3D ~RL_ROUTES_ADDED;
+        rl6->iflags &=3D ~(RL_ROUTES_ADDED | RL_DID_LOCAL);
     }

     if (rl6)
@@ -1291,6 +1301,131 @@
     }
 }

+void
+add_route_towards_remote(struct context *c)
+{
+    ASSERT(c->c1.link_socket_addrs);
+
+    int current_remote_family =3D c->c1.link_socket_addrs[0].actual.dest.a=
ddr.sa.sa_family;
+
+    if (current_remote_family =3D=3D AF_INET && c->c1.route_list
+        && (c->c1.route_list->flags & RG_REROUTE_GW))
+    {
+        if (c->c1.route_list->iflags & RL_DID_LOCAL)
+        {
+            del_route_towards_remote(c);
+        }
+
+        in_addr_t current_remote =3D ntohl(c->c1.link_socket_addrs[0].actu=
al.dest.addr.in4.sin_addr.s_addr);
+
+        if (add_route3(current_remote,
+                       IPV4_NETMASK_HOST,
+                       c->c1.route_list->rgi.gateway.addr,
+                       c->c1.tuntap,
+                       ROUTE_OPTION_FLAGS(&c->options) | ROUTE_REF_GW,
+                       &c->c1.route_list->rgi,
+                       c->c2.es,
+                       &c->net_ctx))
+        {
+            c->c1.route_list->iflags |=3D RL_DID_LOCAL;
+            c->c1.route_list->spec.remote_host =3D current_remote;
+        }
+    }
+    else if (current_remote_family =3D=3D AF_INET6 && c->c1.route_ipv6_list
+             && (c->c1.route_ipv6_list->flags & RG_REROUTE_GW))
+    {
+        if (c->c1.route_ipv6_list->iflags & RL_DID_LOCAL)
+        {
+            del_route_towards_remote(c);
+        }
+
+        const struct in6_addr *remote_host_ipv6 =3D &(c->c1.link_socket_ad=
drs[0].actual.dest.addr.in6.sin6_addr);
+        struct route_ipv6_list *rl6 =3D c->c1.route_ipv6_list;
+
+        if ((rl6->rgi6.flags & (RGI_ADDR_DEFINED|RGI_IFACE_DEFINED)) =3D=3D
+            (RGI_ADDR_DEFINED|RGI_IFACE_DEFINED))
+        {
+            struct route_ipv6 *r6 =3D create_host_route_ipv6(*remote_host_=
ipv6, rl6);
+
+            if (add_route_ipv6(r6, c->c1.tuntap,
+                               ROUTE_OPTION_FLAGS(&c->options), c->c2.es, =
&c->net_ctx))
+            {
+                rl6->routes_ipv6 =3D r6;
+                rl6->iflags |=3D RL_DID_LOCAL;
+            }
+        }
+        else
+        {
+            msg(M_WARN, "ROUTE6: IPv6 route overlaps with IPv6 remote addr=
ess, but could not determine IPv6 gateway address + interface, expect failu=
re\n" );
+        }
+    }
+}
+
+void
+del_route_towards_remote(struct context *c)
+{
+    /* If the function is called from do_close_tun() it means that the soc=
ket
+     * has already been closed and c->c2.link_sockets[0]->info.lsa` used in
+     * `add_route_towards_remote()` cleaned up. So we should use
+     * `c->c1.link_socket_addrs[0]` instead.
+     */
+    ASSERT(c->c1.link_socket_addrs);
+
+    int current_remote_family =3D 0;
+
+    if (c->c1.link_socket_addrs[0].actual.dest.addr.sa.sa_family)
+    {
+        current_remote_family =3D c->c1.link_socket_addrs[0].actual.dest.a=
ddr.sa.sa_family;
+    }
+    else if (c->c1.link_socket_addrs[0].current_remote)
+    {
+        current_remote_family =3D c->c1.link_socket_addrs[0].current_remot=
e->ai_family;
+    }
+
+    if (current_remote_family =3D=3D AF_INET && c->c1.route_list
+        && (c->c1.route_list->flags & RG_REROUTE_GW)
+        && (c->c1.route_list->iflags & RL_DID_LOCAL))
+    {
+        del_route3(c->c1.route_list->spec.remote_host,
+                   IPV4_NETMASK_HOST,
+                   c->c1.route_list->rgi.gateway.addr,
+                   c->c1.tuntap,
+                   ROUTE_OPTION_FLAGS(&c->options) | ROUTE_REF_GW,
+                   &c->c1.route_list->rgi,
+                   c->c2.es,
+                   &c->net_ctx);
+        c->c1.route_list->iflags &=3D ~RL_DID_LOCAL;
+    }
+    else if (current_remote_family =3D=3D AF_INET6 && c->c1.route_ipv6_list
+             && (c->c1.route_ipv6_list->flags & RG_REROUTE_GW)
+             && (c->c1.route_ipv6_list->iflags & RL_DID_LOCAL))
+    {
+        struct in6_addr *remote_host_ipv6 =3D &c->c1.route_ipv6_list->remo=
te_host_ipv6;
+        struct route_ipv6 *host_route =3D create_host_route_ipv6(*remote_h=
ost_ipv6, c->c1.route_ipv6_list);
+
+        for (struct route_ipv6 *prev =3D NULL, *r6 =3D c->c1.route_ipv6_li=
st->routes_ipv6; r6; r6 =3D r6->next)
+        {
+            if (memcmp(&r6->network, &host_route->network, sizeof(struct i=
n6_addr))
+                || r6->netbits !=3D host_route->netbits
+                || memcmp(&r6->gateway, &host_route->gateway, sizeof(struc=
t in6_addr)))
+            {
+                continue;
+            }
+
+            delete_route_ipv6(r6, c->c1.tuntap, ROUTE_OPTION_FLAGS(&c->opt=
ions), c->c2.es, &c->net_ctx);
+            if (!prev)
+            {
+                c->c1.route_ipv6_list->routes_ipv6 =3D r6->next;
+            }
+            else
+            {
+                prev->next =3D r6->next;
+            }
+            c->c1.route_ipv6_list->iflags &=3D ~RL_DID_LOCAL;
+        }
+    }
+}
+
 #ifndef ENABLE_SMALL

 static const char *
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 98ea79e..b1b23f9 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -286,6 +286,14 @@
                const struct route_gateway_info *rgi, const struct env_set =
*es,
                openvpn_net_ctx_t *ctx);

+/* Function to add a route towards the new remote when using
+ * `--redirect-gateway` and `--persist-tun` options together. */
+void add_route_towards_remote(struct context *c);
+
+/* Function to delete the route towards the remote when using
+ * `--redirect-gateway` and `--persist-tun` options together. */
+void del_route_towards_remote(struct context *c);
+
 void add_route_to_option_list(struct route_option_list *l,
                               const char *network,
                               const char *netmask,
@@ -353,6 +361,9 @@
                            const struct route_gateway_info *rgi,
                            const struct route_ipv6_gateway_info *rgi6);

+/* Return a `route_ipv6 *` /128 IPv6 route toward the remote host */
+struct route_ipv6 *create_host_route_ipv6(struct in6_addr remote_host_ipv6=
, struct route_ipv6_list *rl6);
+
 /*
  * Test if addr is reachable via a local interface (return ILA_LOCAL),
  * or if it needs to be routed via the default gateway (return

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/901?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic7b486ccb85df7fc1d6a573ac1315d235728822c
Gerrit-Change-Number: 901
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--prdlv6MB17E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/901?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">redirect-gateway: add route toward new remote host when using=
 persist-tun<br><br>When both --redirect-gateway and --persist-tun are used=
 together,<br>a route must be added for each new remote host we attempt to =
connect to.<br><br>Change-Id: Ic7b486ccb85df7fc1d6a573ac1315d235728822c<br>=
Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn=
/init.c<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>3 files change=
d, 188 insertions(+), 22 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/01/901/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/init.c b/src/openvpn/init.c</span><br><span>index b57e5f8..63b7bbf 100644<=
/span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/=
init.c</span><br><span>@@ -2184,6 +2184,10 @@</span><br><span>             =
            &quot;route-pre-down&quot;,</span><br><span>                   =
      c-&gt;c2.es);</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (c-&gt;mode =3D=3D CM_P2P &amp;&amp; c-&gt=
;options.persist_tun)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            del_route_towards_remote(c);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span>             delete_rout=
es(c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,</span><br><span>         =
                  c-&gt;c1.tuntap, ROUTE_OPTION_FLAGS(&amp;c-&gt;options),<=
/span><br><span>                           c-&gt;c2.es, &amp;c-&gt;net_ctx)=
;</span><br><span>@@ -2245,6 +2249,11 @@</span><br><span>                  =
       c-&gt;c2.es);</span><br><span>         }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;mode =3D=3D=
 CM_P2P &amp;&amp; c-&gt;options.persist_tun)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            del_route_towards_remote(c);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>         del_wfp_block(c, adapt=
er_index);</span><br><span>     }</span><br><span>     gc_free(&amp;gc);</s=
pan><br><span>@@ -4825,6 +4834,17 @@</span><br><span>         }</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * When using both --redirect-gateway and --persist-tun,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * if the connection to the serv=
er is lost, a /32 (or /128 if IPv6) route must be added</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * to ensure connectivity to the ne=
xt remote.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =
=3D=3D CM_P2P</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &amp;&amp; c-&gt;options.persist_tun)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        add_route_towards_remote(c);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     /*</span><br><span>      * Actually do UID/G=
ID downgrade, and chroot, if requested.</span><br><span>      * May be dela=
yed by --client, --pull, or --up-delay.</span><br><span>diff --git a/src/op=
envpn/route.c b/src/openvpn/route.c</span><br><span>index bc41492..1e4deb5 =
100644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/=
openvpn/route.c</span><br><span>@@ -43,6 +43,7 @@</span><br><span> #include=
 &quot;options.h&quot;</span><br><span> #include &quot;networking.h&quot;</=
span><br><span> #include &quot;integer.h&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;openvpn.h&quot;</span><br><span> =
</span><br><span> #include &quot;memdbg.h&quot;</span><br><span> </span><br=
><span>@@ -884,30 +885,14 @@</span><br><span>     }</span><br><span> </span=
><br><span>     /* add VPN server host route if needed */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (need_remote_ipv6_route)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (need_remote_ipv6_ro=
ute</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&am=
p; !(rl6-&gt;iflags &amp; RL_DID_LOCAL))</span><br><span>     {</span><br><=
span>         if ( (rl6-&gt;rgi6.flags &amp; (RGI_ADDR_DEFINED|RGI_IFACE_DE=
FINED) ) =3D=3D</span><br><span>              (RGI_ADDR_DEFINED|RGI_IFACE_D=
EFINED) )</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            struct route_ipv6 *r6;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            ALLOC_OBJ_CLEAR_GC(r6, struct route=
_ipv6, &amp;rl6-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            r6-&gt=
;network =3D *remote_host_ipv6;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            r6-&gt;netbits =3D 128;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (!(rl6-&gt;rgi6.flags &amp; RGI_ON_L=
INK) )</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                r6-&gt;=
gateway =3D rl6-&gt;rgi6.gateway.addr_ipv6;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            r6-&gt;metric =3D 1;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            r6-&gt;adapter_index =3D rl6-&gt;rgi6.adapter_=
index;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            r6-&gt;iface =3D rl=
6-&gt;rgi6.iface;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            r6-&gt;=
flags =3D RT_DEFINED | RT_METRIC_DEFINED;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           r6-&gt;next =3D rl6-&gt;routes_ipv6;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            rl6-&gt;routes_ipv6 =3D r6;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            rl6-&gt;routes_ip=
v6 =3D create_host_route_ipv6(*remote_host_ipv6, rl6);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            rl6-&gt;iflags |=3D RL_DID_L=
OCAL;</span><br><span>         }</span><br><span>         else</span><br><s=
pan>         {</span><br><span>@@ -919,6 +904,30 @@</span><br><span>     re=
turn ret;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+struct route_ipv6 *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+create_host_route_ipv6(struct in6_addr remote_ho=
st_ipv6, struct route_ipv6_list *rl6)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct route_ipv6 *r6;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ALLOC_OBJ_CLEAR_GC(r6, struct route_ipv6, &amp;rl6-&gt;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    r6-&gt;network =3D remote_host_ipv6;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6-&gt;netbits =
=3D 128;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!(r=
l6-&gt;rgi6.flags &amp; RGI_ON_LINK) )</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        r6-&gt;gateway =3D rl6-&gt;rgi6.gateway.addr_ipv6;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    r6-&gt;metric =3D 1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    r6-&gt;adapter_index =3D rl6-&gt;rgi6.adap=
ter_index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6-&gt;iface =3D rl=
6-&gt;rgi6.iface;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6-&gt;flag=
s =3D RT_DEFINED | RT_METRIC_DEFINED;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    r6-&gt;next =3D rl6-&gt;routes_ipv6;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return r6;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> static bool</span><br><span> add_route3(in_addr_t network,</=
span><br><span>            in_addr_t netmask,</span><br><span>@@ -1055,7 +1=
064,8 @@</span><br><span>                 /* if remote_host is not ipv4 (ie=
: ipv6), just skip</span><br><span>                  * adding this special =
/32 route */</span><br><span>                 if ((rl-&gt;spec.flags &amp; =
RTSA_REMOTE_HOST)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                &amp;&amp; rl-&gt;spec.remote_host !=3D IPV4_INVALID_ADDR)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
&amp;&amp; rl-&gt;spec.remote_host !=3D IPV4_INVALID_ADDR</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    &amp;&amp; !(rl-&=
gt;iflags &amp; RL_DID_LOCAL))</span><br><span>                 {</span><br=
><span>                     ret =3D add_route3(rl-&gt;spec.remote_host, IPV=
4_NETMASK_HOST,</span><br><span>                                      rl-&g=
t;rgi.gateway.addr, tt, flags | ROUTE_REF_GW,</span><br><span>@@ -1282,7 +1=
292,7 @@</span><br><span>         {</span><br><span>             delete_rou=
te_ipv6(r6, tt, flags, es, ctx);</span><br><span>         }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        rl6-&gt;iflags &amp;=3D ~RL_R=
OUTES_ADDED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 rl6-&gt;iflags &amp;=3D ~(RL_ROUTES_ADDED | RL_DID_LOCAL);</span><br><span=
>     }</span><br><span> </span><br><span>     if (rl6)</span><br><span>@@ =
-1291,6 +1301,131 @@</span><br><span>     }</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+add_route_towards_remote(stru=
ct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(c-&gt;c1.lin=
k_socket_addrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int current_remote=
_family =3D c-&gt;c1.link_socket_addrs[0].actual.dest.addr.sa.sa_family;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (current_remote_family =3D=3D AF_I=
NET &amp;&amp; c-&gt;c1.route_list</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        &amp;&amp; (c-&gt;c1.route_list-&gt;flags &amp; RG_R=
EROUTE_GW))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c1.r=
oute_list-&gt;iflags &amp; RL_DID_LOCAL)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            del_route_towards_remote(c);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        in_addr_t current_remote =3D ntohl(c-&gt;c1.link_socket_addrs[=
0].actual.dest.addr.in4.sin_addr.s_addr);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (add_route3(current_remote,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                       IPV4_NETMASK_HOST,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                       c-&gt;c1=
.route_list-&gt;rgi.gateway.addr,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                       c-&gt;c1.tuntap,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       ROUTE_OPTION_FLAGS=
(&amp;c-&gt;options) | ROUTE_REF_GW,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                       &amp;c-&gt;c1.route_list-&gt;rgi,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
  c-&gt;c2.es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                  &amp;c-&gt;net_ctx))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            c-&gt;c1.route_list-&gt;iflags |=3D RL_DID_LOCAL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c1.rou=
te_list-&gt;spec.remote_host =3D current_remote;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (current_remote_family =3D=3D AF_INET6 &amp;&amp; c-&gt;c1=
.route_ipv6_list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          &amp;&amp; (c-&gt;c1.route_ipv6_list-&gt;flags &amp; RG_REROUTE_G=
W))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c1.route_ipv=
6_list-&gt;iflags &amp; RL_DID_LOCAL)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            del_route_towards_remote(c);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        const struct in6_addr *remote_host_ipv6 =3D &amp;(c-&gt;c1.link_soc=
ket_addrs[0].actual.dest.addr.in6.sin6_addr);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct route_ipv6_list *rl6 =3D c-&gt;c1.=
route_ipv6_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((rl6-&gt;r=
gi6.flags &amp; (RGI_ADDR_DEFINED|RGI_IFACE_DEFINED)) =3D=3D</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            (RGI_ADDR_DEFINED|RGI_=
IFACE_DEFINED))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            st=
ruct route_ipv6 *r6 =3D create_host_route_ipv6(*remote_host_ipv6, rl6);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (add_route_ipv6(r6, c-&gt;=
c1.tuntap,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                      ROUTE_OPTION_FLAGS(&amp;c-&gt;options), c-&gt;c2.es, =
&amp;c-&gt;net_ctx))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           rl6-&gt;routes_ipv6 =3D r6;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                rl6-&gt;iflags |=3D RL_DID_LOCAL;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(M_WARN, &quot;ROUTE6: IPv6 route overlaps =
with IPv6 remote address, but could not determine IPv6 gateway address + in=
terface, expect failure\n&quot; );</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+del_route_towards_remote(struct context *c)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* If the function is called from do_close_tun() it=
 means that the socket</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * has already been closed and c-&gt;c2.link_sockets[0]-&gt;info.lsa=
` used in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * `ad=
d_route_towards_remote()` cleaned up. So we should use</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * `c-&gt;c1.link_socket_addrs[0]` i=
nstead.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(c-&gt;c1.link=
_socket_addrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int current_remote_=
family =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c1.link_soc=
ket_addrs[0].actual.dest.addr.sa.sa_family)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        current_remote_family =3D c-&gt;c1.link_socket_addrs[0].a=
ctual.dest.addr.sa.sa_family;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (c-&gt;c1.link_socket_addrs[0].current_remote)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        current_remote_family =3D c-&gt;c1.link_socket=
_addrs[0].current_remote-&gt;ai_family;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (curre=
nt_remote_family =3D=3D AF_INET &amp;&amp; c-&gt;c1.route_list</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; (c-&gt;c1.rou=
te_list-&gt;flags &amp; RG_REROUTE_GW)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        &amp;&amp; (c-&gt;c1.route_list-&gt;iflags &amp;=
 RL_DID_LOCAL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        del_route3=
(c-&gt;c1.route_list-&gt;spec.remote_host,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                   IPV4_NETMASK_HOST,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                   c-&gt;c1.route_=
list-&gt;rgi.gateway.addr,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                   c-&gt;c1.tuntap,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                   ROUTE_OPTION_FLAGS(&amp;c-&gt;opt=
ions) | ROUTE_REF_GW,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   &amp;c-&gt;c1.route_list-&gt;rgi,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                   c-&gt;c2.es,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                   &amp;c-&g=
t;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
c-&gt;c1.route_list-&gt;iflags &amp;=3D ~RL_DID_LOCAL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else if (current_remote_family =3D=3D AF_INET6 &am=
p;&amp; c-&gt;c1.route_ipv6_list</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+             &amp;&amp; (c-&gt;c1.route_ipv6_list-&gt;flags &a=
mp; RG_REROUTE_GW)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
            &amp;&amp; (c-&gt;c1.route_ipv6_list-&gt;iflags &amp; RL_DID_LO=
CAL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct in6_addr *rem=
ote_host_ipv6 =3D &amp;c-&gt;c1.route_ipv6_list-&gt;remote_host_ipv6;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct route_ipv6=
 *host_route =3D create_host_route_ipv6(*remote_host_ipv6, c-&gt;c1.route_i=
pv6_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        for (struct route_ip=
v6 *prev =3D NULL, *r6 =3D c-&gt;c1.route_ipv6_list-&gt;routes_ipv6; r6; r6=
 =3D r6-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (memcmp(&amp;r6-&gt;network, &amp;host_route-&gt;network, sizeof(struct =
in6_addr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       || r6-&gt;netbits !=3D host_route-&gt;netbits</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                || memcmp(&amp;r6-&gt;gat=
eway, &amp;host_route-&gt;gateway, sizeof(struct in6_addr)))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                continue;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            delete_route_ipv6(r6, c-&gt;c1.tuntap, ROUTE_OP=
TION_FLAGS(&amp;c-&gt;options), c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (!prev)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c1.route_i=
pv6_list-&gt;routes_ipv6 =3D r6-&gt;next;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                prev-&gt;next =3D r6-&gt;next;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            c-&gt;c1.route_ipv6_list-&gt;iflags=
 &amp;=3D ~RL_DID_LOCAL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifndef ENABLE_SMAL=
L</span><br><span> </span><br><span> static const char *</span><br><span>di=
ff --git a/src/openvpn/route.h b/src/openvpn/route.h</span><br><span>index =
98ea79e..b1b23f9 100644</span><br><span>--- a/src/openvpn/route.h</span><br=
><span>+++ b/src/openvpn/route.h</span><br><span>@@ -286,6 +286,14 @@</span=
><br><span>                const struct route_gateway_info *rgi, const stru=
ct env_set *es,</span><br><span>                openvpn_net_ctx_t *ctx);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* F=
unction to add a route towards the new remote when using</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * `--redirect-gateway` and `--persist=
-tun` options together. */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void add_route_towards_remote(struct context *c);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Function to delete the route towards the remote when u=
sing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * `--redirect-=
gateway` and `--persist-tun` options together. */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void del_route_towards_remote(struct context =
*c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> void add_route_to_option_list(struct route_option_list *l,</span><br><sp=
an>                               const char *network,</span><br><span>    =
                           const char *netmask,</span><br><span>@@ -353,6 +=
361,9 @@</span><br><span>                            const struct route_gat=
eway_info *rgi,</span><br><span>                            const struct ro=
ute_ipv6_gateway_info *rgi6);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Return a `route_ipv6 *` /128 IPv6 route towa=
rd the remote host */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+struct route_ipv6 *create_host_route_ipv6(struct in6_addr remote_host_ipv=
6, struct route_ipv6_list *rl6);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> /*</span><br><span>  * Test if addr is reach=
able via a local interface (return ILA_LOCAL),</span><br><span>  * or if it=
 needs to be routed via the default gateway (return</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/901?usp=3Demail">change 901</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/901?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic7b486ccb85df7fc1d6a573ac13=
15d235728822c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 901 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--prdlv6MB17E=--

