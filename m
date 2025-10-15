From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 15 Oct 2025 18:37:40 +0000
In-Reply-To: <gerrit.1740476883000.Ic7b486ccb85df7fc1d6a573ac1315d235728822c@...2715...>
References: <gerrit.1740476883000.Ic7b486ccb85df7fc1d6a573ac1315d235728822c@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <057e16068a61ddf2661dcb94e01b88622a637f0c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T9aB/c0/Iwk="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, stipa <lstipakov@...277...>

--T9aB/c0/Iwk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/901?usp=3Demail

to look at the new patch set (#4).


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
3 files changed, 189 insertions(+), 22 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/901/4

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index aaa0573..c5f10ee 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2106,6 +2106,10 @@
                         signal_description(c->sig->signal_received, c->sig=
->signal_text),
                         "route-pre-down", c->c2.es);

+            if (c->mode =3D=3D CM_P2P && c->options.persist_tun)
+            {
+                del_route_towards_remote(c);
+            }
             delete_routes(c->c1.route_list, c->c1.route_ipv6_list, c->c1.t=
untap,
                           ROUTE_OPTION_FLAGS(&c->options), c->c2.es, &c->n=
et_ctx);
         }
@@ -2150,6 +2154,11 @@
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
@@ -4723,6 +4732,17 @@
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
index 7d988da..94a1d53 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -42,6 +42,7 @@
 #include "options.h"
 #include "networking.h"
 #include "integer.h"
+#include "openvpn.h"

 #include "memdbg.h"

@@ -840,30 +841,14 @@
     }

     /* add VPN server host route if needed */
-    if (need_remote_ipv6_route)
+    if (need_remote_ipv6_route
+        && !(rl6->iflags & RL_DID_LOCAL))
     {
         if ((rl6->rgi6.flags & (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED))
             =3D=3D (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED))
         {
-            struct route_ipv6 *r6;
-            ALLOC_OBJ_CLEAR_GC(r6, struct route_ipv6, &rl6->gc);
-
-            r6->network =3D *remote_host_ipv6;
-            r6->netbits =3D 128;
-            if (!(rl6->rgi6.flags & RGI_ON_LINK))
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
@@ -876,6 +861,30 @@
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
+    if (!(rl6->rgi6.flags & RGI_ON_LINK))
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
 add_route3(in_addr_t network, in_addr_t netmask, in_addr_t gateway, const =
struct tuntap *tt,
            unsigned int flags, const struct route_gateway_info *rgi, const=
 struct env_set *es,
@@ -988,7 +997,8 @@
                 /* if remote_host is not ipv4 (ie: ipv6), just skip
                  * adding this special /32 route */
                 if ((rl->spec.flags & RTSA_REMOTE_HOST)
-                    && rl->spec.remote_host !=3D IPV4_INVALID_ADDR)
+                    && rl->spec.remote_host !=3D IPV4_INVALID_ADDR
+                    && !(rl->iflags & RL_DID_LOCAL))
                 {
                     ret =3D add_route3(rl->spec.remote_host, IPV4_NETMASK_=
HOST, rl->rgi.gateway.addr,
                                      tt, flags | ROUTE_REF_GW, &rl->rgi, e=
s, ctx);
@@ -1199,7 +1209,7 @@
         {
             delete_route_ipv6(r6, tt, es, ctx);
         }
-        rl6->iflags &=3D ~RL_ROUTES_ADDED;
+        rl6->iflags &=3D ~(RL_ROUTES_ADDED | RL_DID_LOCAL);
     }

     if (rl6)
@@ -1208,6 +1218,132 @@
     }
 }

+void
+add_route_towards_remote(struct context *c)
+{
+    ASSERT(c->c1.link_socket_addrs);
+
+    struct openvpn_sockaddr dest =3D c->c1.link_socket_addrs[0].actual.des=
t;
+
+    int current_remote_family =3D dest.addr.sa.sa_family;
+
+    if (current_remote_family =3D=3D AF_INET && c->c1.route_list
+        && (c->c1.route_list->flags & RG_REROUTE_GW))
+    {
+        if (c->c1.route_list->iflags & RL_DID_LOCAL)
+        {
+            del_route_towards_remote(c);
+        }
+
+        in_addr_t current_remote =3D ntohl(dest.addr.in4.sin_addr.s_addr);
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
+        const struct in6_addr *remote_host_ipv6 =3D &(dest.addr.in6.sin6_a=
ddr);
+        struct route_ipv6_list *rl6 =3D c->c1.route_ipv6_list;
+
+        if ((rl6->rgi6.flags & (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED)) =3D=
=3D (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED))
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
re\n");
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
+            delete_route_ipv6(r6, c->c1.tuntap, c->c2.es, &c->net_ctx);
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
index 54fa137..56c9c7f 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -309,6 +309,14 @@
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
 void add_route_to_option_list(struct route_option_list *l, const char *net=
work, const char *netmask,
                               const char *gateway, const char *metric, int=
 table_id);

@@ -359,6 +367,9 @@
 void print_default_gateway(const msglvl_t msglevel, const struct route_gat=
eway_info *rgi,
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
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic7b486ccb85df7fc1d6a573ac1315d235728822c
Gerrit-Change-Number: 901
Gerrit-PatchSet: 4
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>

--T9aB/c0/Iwk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #4</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/901?usp=3Demail">View Change</a=
></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">redirect-gateway: add route toward new remote host when =
using persist-tun<br><br>When both --redirect-gateway and --persist-tun are=
 used together,<br>a route must be added for each new remote host we attemp=
t to connect to.<br><br>Change-Id: Ic7b486ccb85df7fc1d6a573ac1315d235728822=
c<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/op=
envpn/init.c<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>3 files c=
hanged, 189 insertions(+), 22 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/901/4</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index aa=
a0573..c5f10ee 100644</span><br><span>--- a/src/openvpn/init.c</span><br><s=
pan>+++ b/src/openvpn/init.c</span><br><span>@@ -2106,6 +2106,10 @@</span><=
br><span>                         signal_description(c-&gt;sig-&gt;signal_r=
eceived, c-&gt;sig-&gt;signal_text),</span><br><span>                      =
   &quot;route-pre-down&quot;, c-&gt;c2.es);</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (c-&gt;mode =3D=
=3D CM_P2P &amp;&amp; c-&gt;options.persist_tun)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                del_route_towards_remote(c);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an>             delete_routes(c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list=
, c-&gt;c1.tuntap,</span><br><span>                           ROUTE_OPTION_=
FLAGS(&amp;c-&gt;options), c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><spa=
n>         }</span><br><span>@@ -2150,6 +2154,11 @@</span><br><span>       =
                  c-&gt;c2.es);</span><br><span>         }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;=
mode =3D=3D CM_P2P &amp;&amp; c-&gt;options.persist_tun)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            del_route_towards_remote(c);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         del_wfp_blo=
ck(c, adapter_index);</span><br><span>     }</span><br><span>     gc_free(&=
amp;gc);</span><br><span>@@ -4723,6 +4732,17 @@</span><br><span>         }<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * When using both --redirect-gateway and --persist-tun,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * if the connection =
to the server is lost, a /32 (or /128 if IPv6) route must be added</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * to ensure connectivit=
y to the next remote.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-=
&gt;mode =3D=3D CM_P2P</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &amp;&amp; c-&gt;options.persist_tun)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        add_route_towards_remote(c);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     /*</span><br><span>      * Actual=
ly do UID/GID downgrade, and chroot, if requested.</span><br><span>      * =
May be delayed by --client, --pull, or --up-delay.</span><br><span>diff --g=
it a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 7d988d=
a..94a1d53 100644</span><br><span>--- a/src/openvpn/route.c</span><br><span=
>+++ b/src/openvpn/route.c</span><br><span>@@ -42,6 +42,7 @@</span><br><spa=
n> #include &quot;options.h&quot;</span><br><span> #include &quot;networkin=
g.h&quot;</span><br><span> #include &quot;integer.h&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn.h&quot;</span>=
<br><span> </span><br><span> #include &quot;memdbg.h&quot;</span><br><span>=
 </span><br><span>@@ -840,30 +841,14 @@</span><br><span>     }</span><br><s=
pan> </span><br><span>     /* add VPN server host route if needed */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (need_remote_ipv6_rou=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (need_rem=
ote_ipv6_route</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   &amp;&amp; !(rl6-&gt;iflags &amp; RL_DID_LOCAL))</span><br><span>     {<=
/span><br><span>         if ((rl6-&gt;rgi6.flags &amp; (RGI_ADDR_DEFINED | =
RGI_IFACE_DEFINED))</span><br><span>             =3D=3D (RGI_ADDR_DEFINED |=
 RGI_IFACE_DEFINED))</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            struct route_ipv6 *r6;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            ALLOC_OBJ_CLEAR_GC(r6, s=
truct route_ipv6, &amp;rl6-&gt;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     r6-&gt;network =3D *remote_host_ipv6;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            r6-&gt;netbits =3D 128;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (!(rl6-&gt;rgi6.flags &am=
p; RGI_ON_LINK))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   r6-&gt;gateway =3D rl6-&gt;rgi6.gateway.addr_ipv6;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            r6-&gt;metric =3D 1;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            r6-&gt;adapter_index =3D rl6-&gt;rgi=
6.adapter_index;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            r6-&gt;if=
ace =3D rl6-&gt;rgi6.iface;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   r6-&gt;flags =3D RT_DEFINED | RT_METRIC_DEFINED;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            r6-&gt;next =3D rl6-&gt;routes_ipv6;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            rl6-&gt;routes_ipv6 =3D r=
6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            rl6-&=
gt;routes_ipv6 =3D create_host_route_ipv6(*remote_host_ipv6, rl6);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            rl6-&gt;iflags |=
=3D RL_DID_LOCAL;</span><br><span>         }</span><br><span>         else<=
/span><br><span>         {</span><br><span>@@ -876,6 +861,30 @@</span><br><=
span>     return ret;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+struct route_ipv6 *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+create_host_route_ipv6(struct in6_ad=
dr remote_host_ipv6, struct route_ipv6_list *rl6)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct route_ipv6 *r6;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(r6, struct route_ipv6, &amp;rl6-&=
gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    r6-&gt;network =3D remote_h=
ost_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6-&gt=
;netbits =3D 128;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!(rl6-&gt;rgi6.flags &amp; RGI_ON_LINK))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        r6-&gt;gateway =3D rl6-&gt;rgi6.gateway.addr_ipv6;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    r6-&gt;metric =3D 1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    r6-&gt;adapter_index =3D rl6-&gt;r=
gi6.adapter_index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6-&gt;ifac=
e =3D rl6-&gt;rgi6.iface;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6-=
&gt;flags =3D RT_DEFINED | RT_METRIC_DEFINED;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    r6-&gt;next =3D rl6-&gt;routes_ipv6;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return r6;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> static bool</span><br><span> add_route3(in_addr_t ne=
twork, in_addr_t netmask, in_addr_t gateway, const struct tuntap *tt,</span=
><br><span>            unsigned int flags, const struct route_gateway_info =
*rgi, const struct env_set *es,</span><br><span>@@ -988,7 +997,8 @@</span><=
br><span>                 /* if remote_host is not ipv4 (ie: ipv6), just sk=
ip</span><br><span>                  * adding this special /32 route */</sp=
an><br><span>                 if ((rl-&gt;spec.flags &amp; RTSA_REMOTE_HOST=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
&amp;&amp; rl-&gt;spec.remote_host !=3D IPV4_INVALID_ADDR)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    &amp;&amp; rl-&g=
t;spec.remote_host !=3D IPV4_INVALID_ADDR</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &amp;&amp; !(rl-&gt;iflags &amp; =
RL_DID_LOCAL))</span><br><span>                 {</span><br><span>         =
            ret =3D add_route3(rl-&gt;spec.remote_host, IPV4_NETMASK_HOST, =
rl-&gt;rgi.gateway.addr,</span><br><span>                                  =
    tt, flags | ROUTE_REF_GW, &amp;rl-&gt;rgi, es, ctx);</span><br><span>@@=
 -1199,7 +1209,7 @@</span><br><span>         {</span><br><span>            =
 delete_route_ipv6(r6, tt, es, ctx);</span><br><span>         }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        rl6-&gt;iflags &amp;=3D ~=
RL_ROUTES_ADDED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     rl6-&gt;iflags &amp;=3D ~(RL_ROUTES_ADDED | RL_DID_LOCAL);</span><br><=
span>     }</span><br><span> </span><br><span>     if (rl6)</span><br><span=
>@@ -1208,6 +1218,132 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+add_route_towards_remote(=
struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(c-&gt;c1=
.link_socket_addrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn=
_sockaddr dest =3D c-&gt;c1.link_socket_addrs[0].actual.dest;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int current_remote_family =3D dest.addr.sa.sa_fa=
mily;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (current_remote_family =3D=
=3D AF_INET &amp;&amp; c-&gt;c1.route_list</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        &amp;&amp; (c-&gt;c1.route_list-&gt;flags &a=
mp; RG_REROUTE_GW))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-=
&gt;c1.route_list-&gt;iflags &amp; RL_DID_LOCAL)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            del_route_towards_remote(c);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        in_addr_t current_remote =3D ntohl(dest.addr.in4.sin_add=
r.s_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (add_route3(curre=
nt_remote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              IPV4_NETMASK_HOST,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                       c-&gt;c1.route_list-&gt;rgi.gateway.add=
r,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
      c-&gt;c1.tuntap,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                       ROUTE_OPTION_FLAGS(&amp;c-&gt;options) | ROUTE_RE=
F_GW,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
         &amp;c-&gt;c1.route_list-&gt;rgi,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                       c-&gt;c2.es,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                       &amp;c-&gt;ne=
t_ctx))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c1.r=
oute_list-&gt;iflags |=3D RL_DID_LOCAL;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            c-&gt;c1.route_list-&gt;spec.remote_host =
=3D current_remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (current_rem=
ote_family =3D=3D AF_INET6 &amp;&amp; c-&gt;c1.route_ipv6_list</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; (c-&gt;c=
1.route_ipv6_list-&gt;flags &amp; RG_REROUTE_GW))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (c-&gt;c1.route_ipv6_list-&gt;iflags &amp; RL_DI=
D_LOCAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            del_route=
_towards_remote(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const struct in6_addr=
 *remote_host_ipv6 =3D &amp;(dest.addr.in6.sin6_addr);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct route_ipv6_list *rl6 =3D =
c-&gt;c1.route_ipv6_list;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((=
rl6-&gt;rgi6.flags &amp; (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED)) =3D=3D (RG=
I_ADDR_DEFINED | RGI_IFACE_DEFINED))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            struct route_ipv6 *r6 =3D create_host_route_ipv6(*remote=
_host_ipv6, rl6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (add_r=
oute_ipv6(r6, c-&gt;c1.tuntap,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                               ROUTE_OPTION_FLAGS(&amp;c-&gt;opt=
ions), c-&gt;c2.es, &amp;c-&gt;net_ctx))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                rl6-&gt;routes_ipv6 =3D r6;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                rl6-&gt;iflags |=3D =
RL_DID_LOCAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;ROUTE6: I=
Pv6 route overlaps with IPv6 remote address, but could not determine IPv6 g=
ateway address + interface, expect failure\n&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+del_route_towards_remote(struct context *=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* If the function is called fr=
om do_close_tun() it means that the socket</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * has already been closed and c-&gt;c2.link_soc=
kets[0]-&gt;info.lsa` used in</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * `add_route_towards_remote()` cleaned up. So we should use<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * `c-&gt;c1.lin=
k_socket_addrs[0]` instead.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ASSERT(c-&gt;c1.link_socket_addrs);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int current_remote_family =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (c-&gt;c1.link_socket_addrs[0].actual.dest.addr.sa.sa_family)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        current_remote_family =3D c-&gt;c1.li=
nk_socket_addrs[0].actual.dest.addr.sa.sa_family;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (c-&gt;c1.link_socket_addrs[0].current_remote)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        current_remote_family =3D =
c-&gt;c1.link_socket_addrs[0].current_remote-&gt;ai_family;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (current_remote_family =3D=3D AF_INET &amp;&amp; c-&gt;c1.rou=
te_list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp=
;&amp; (c-&gt;c1.route_list-&gt;flags &amp; RG_REROUTE_GW)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; (c-&gt;c1.route_l=
ist-&gt;iflags &amp; RL_DID_LOCAL))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        del_route3(c-&gt;c1.route_list-&gt;spec.remote_host,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                   IPV4_NETMASK_=
HOST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
     c-&gt;c1.route_list-&gt;rgi.gateway.addr,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                   c-&gt;c1.tuntap,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                   ROUTE_OPTION_=
FLAGS(&amp;c-&gt;options) | ROUTE_REF_GW,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                   &amp;c-&gt;c1.route_list-&gt;rgi,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   c=
-&gt;c2.es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
           &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        c-&gt;c1.route_list-&gt;iflags &amp;=3D ~RL_DID_LOCAL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else if (current_remote_family=
 =3D=3D AF_INET6 &amp;&amp; c-&gt;c1.route_ipv6_list</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; (c-&gt;c1.route_i=
pv6_list-&gt;flags &amp; RG_REROUTE_GW)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+             &amp;&amp; (c-&gt;c1.route_ipv6_list-&gt;i=
flags &amp; RL_DID_LOCAL))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct in6_addr *remote_host_ipv6 =3D &amp;c-&gt;c1.route_ipv6_list-&gt;re=
mote_host_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct route_ipv6 *host_route =3D create_host_route_ipv6(*remote_host_i=
pv6, c-&gt;c1.route_ipv6_list);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 for (struct route_ipv6 *prev =3D NULL, *r6 =3D c-&gt;c1.route_ipv6_list-&g=
t;routes_ipv6; r6; r6 =3D r6-&gt;next)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (memcmp(&amp;r6-&gt;network, &amp;host_route-&gt;ne=
twork, sizeof(struct in6_addr))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                || r6-&gt;netbits !=3D host_route-&gt;netbits</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                || me=
mcmp(&amp;r6-&gt;gateway, &amp;host_route-&gt;gateway, sizeof(struct in6_ad=
dr)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                cont=
inue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            delete_route_ipv6(r6, c-&gt=
;c1.tuntap, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if (!prev)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                c-&gt;c1.route_ipv6_list-&gt;routes_=
ipv6 =3D r6-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   prev-&gt;next =3D r6-&gt;next;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            c-&gt;c1.route_ipv6_list-&gt;iflags &amp;=3D ~RL_DID_LO=
CAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> #ifndef ENABLE_SMALL</span><br><span> <=
/span><br><span> static const char *</span><br><span>diff --git a/src/openv=
pn/route.h b/src/openvpn/route.h</span><br><span>index 54fa137..56c9c7f 100=
644</span><br><span>--- a/src/openvpn/route.h</span><br><span>+++ b/src/ope=
nvpn/route.h</span><br><span>@@ -309,6 +309,14 @@</span><br><span>         =
       const struct route_gateway_info *rgi, const struct env_set *es,</spa=
n><br><span>                openvpn_net_ctx_t *ctx);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Function to add a rou=
te towards the new remote when using</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * `--redirect-gateway` and `--persist-tun` options togeth=
er. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void add_rout=
e_towards_remote(struct context *c);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Function to delete the route towards the remote when using</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * `--redirect-gateway` and `--pers=
ist-tun` options together. */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void del_route_towards_remote(struct context *c);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void add_route_to=
_option_list(struct route_option_list *l, const char *network, const char *=
netmask,</span><br><span>                               const char *gateway=
, const char *metric, int table_id);</span><br><span> </span><br><span>@@ -=
359,6 +367,9 @@</span><br><span> void print_default_gateway(const msglvl_t =
msglevel, const struct route_gateway_info *rgi,</span><br><span>           =
                 const struct route_ipv6_gateway_info *rgi6);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Return a `ro=
ute_ipv6 *` /128 IPv6 route toward the remote host */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct route_ipv6 *create_host_route_ipv6=
(struct in6_addr remote_host_ipv6, struct route_ipv6_list *rl6);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br=
><span>  * Test if addr is reachable via a local interface (return ILA_LOCA=
L),</span><br><span>  * or if it needs to be routed via the default gateway=
 (return</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/901?usp=3Demail">change 901</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/901?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic7b486ccb85df7fc1d6a573ac13=
15d235728822c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 901 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>

</body></html>=

--T9aB/c0/Iwk=--

