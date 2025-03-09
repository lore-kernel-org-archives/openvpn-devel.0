From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 9 Mar 2025 17:01:55 +0000
In-Reply-To: <gerrit.1736860439000.If570253e57371e4126b0e8aa4c349e2051cb8b00@...2715...>
References: <gerrit.1736860439000.If570253e57371e4126b0e8aa4c349e2051cb8b00@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6afe9e21d1c056bc84a38d2372e6e580f9bd68a8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1a5EA0N/yrc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove unused
 function check_subnet_conflict
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1a5EA0N/yrc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/86=
3?usp=3Demail )

Change subject: Remove unused function check_subnet_conflict
......................................................................

Remove unused function check_subnet_conflict

This has been #if 0 for over a decade. Let's just
remove this.

Change-Id: If570253e57371e4126b0e8aa4c349e2051cb8b00
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250309165500.21796-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
083.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
M src/openvpn/tun.c
M src/openvpn/tun.h
3 files changed, 0 insertions(+), 52 deletions(-)




diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 245b15b..dbdc01d 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1218,7 +1218,6 @@

         for (r =3D rl->routes; r; r =3D r->next)
         {
-            check_subnet_conflict(r->network, r->netmask, "route");
             if (flags & ROUTE_DELETE_FIRST)
             {
                 delete_route(r, tt, flags, &rl->rgi, es, ctx);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 4817f45..de54e89 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -626,44 +626,6 @@
     gc_free(&gc);
 }

-/*
- * Issue a warning if ip/netmask (on the virtual IP network) conflicts with
- * the settings on the local LAN.  This is designed to flag issues where
- * (for example) the OpenVPN server LAN is running on 192.168.1.x, but then
- * an OpenVPN client tries to connect from a public location that is also =
running
- * off of a router set to 192.168.1.x.
- */
-void
-check_subnet_conflict(const in_addr_t ip,
-                      const in_addr_t netmask,
-                      const char *prefix)
-{
-#if 0 /* too many false positives */
-    struct gc_arena gc =3D gc_new();
-    in_addr_t lan_gw =3D 0;
-    in_addr_t lan_netmask =3D 0;
-
-    if (get_default_gateway(&lan_gw, &lan_netmask) && lan_netmask)
-    {
-        const in_addr_t lan_network =3D lan_gw & lan_netmask;
-        const in_addr_t network =3D ip & netmask;
-
-        /* do the two subnets defined by network/netmask and lan_network/l=
an_netmask intersect? */
-        if ((network & lan_netmask) =3D=3D lan_network
-            || (lan_network & netmask) =3D=3D network)
-        {
-            msg(M_WARN, "WARNING: potential %s subnet conflict between loc=
al LAN [%s/%s] and remote VPN [%s/%s]",
-                prefix,
-                print_in_addr_t(lan_network, 0, &gc),
-                print_in_addr_t(lan_netmask, 0, &gc),
-                print_in_addr_t(network, 0, &gc),
-                print_in_addr_t(netmask, 0, &gc));
-        }
-    }
-    gc_free(&gc);
-#endif /* if 0 */
-}
-
 void
 warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx)
 {
@@ -922,15 +884,6 @@
                                      tt->remote_netmask);
                 }
             }
-
-            if (!tun_p2p)
-            {
-                check_subnet_conflict(tt->local, tt->remote_netmask, "TUN/=
TAP adapter");
-            }
-            else
-            {
-                check_subnet_conflict(tt->local, IPV4_NETMASK_HOST, "TUN/T=
AP adapter");
-            }
         }

 #ifdef _WIN32
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index ccba0bc..b616f5d 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -355,10 +355,6 @@

 bool is_tun_p2p(const struct tuntap *tt);

-void check_subnet_conflict(const in_addr_t ip,
-                           const in_addr_t netmask,
-                           const char *prefix);
-
 void warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx);

 /**

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/863?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If570253e57371e4126b0e8aa4c349e2051cb8b00
Gerrit-Change-Number: 863
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--1a5EA0N/yrc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/863?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove unused function check_subnet_conflict<b=
r><br>This has been #if 0 for over a decade. Let&#39;s just<br>remove this.=
<br><br>Change-Id: If570253e57371e4126b0e8aa4c349e2051cb8b00<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &l=
t;gert@...1296...&gt;<br>Message-Id: &lt;20250309165500.21796-1-gert@...1826...=
6...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg31083.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M src/openvpn/route.c<br>M src/openvpn/tun.c<br>M src/openvpn/tu=
n.h<br>3 files changed, 0 insertions(+), 52 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>i=
ndex 245b15b..dbdc01d 100644</span><br><span>--- a/src/openvpn/route.c</spa=
n><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -1218,7 +1218,6 @@=
</span><br><span> </span><br><span>         for (r =3D rl-&gt;routes; r; r =
=3D r-&gt;next)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            check_subnet_conflict(r-&gt;network, r-&gt=
;netmask, &quot;route&quot;);</span><br><span>             if (flags &amp; =
ROUTE_DELETE_FIRST)</span><br><span>             {</span><br><span>        =
         delete_route(r, tt, flags, &amp;rl-&gt;rgi, es, ctx);</span><br><s=
pan>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>inde=
x 4817f45..de54e89 100644</span><br><span>--- a/src/openvpn/tun.c</span><br=
><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -626,44 +626,6 @@</span><=
br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Issue a warning if ip/netmask (on the virtua=
l IP network) conflicts with</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * the settings on the local LAN.  This is designed to flag issues w=
here</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * (for example) =
the OpenVPN server LAN is running on 192.168.1.x, but then</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * an OpenVPN client tries to connect =
from a public location that is also running</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * off of a router set to 192.168.1.x.</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-check_subnet_conflict(const in_addr_t ip,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                      const in_addr_t netmask,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                      cons=
t char *prefix)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 0 /* too many false po=
sitives */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    in_addr_t lan_gw =3D 0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    in_addr_t lan_netmask =3D 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (get_default_gateway(&amp;lan_gw, &amp;lan_netmask) &amp;&amp; lan_n=
etmask)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        const in_addr_t lan_ne=
twork =3D lan_gw &amp; lan_netmask;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        const in_addr_t network =3D ip &amp; netmask;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /* do the two subnets defined by network/n=
etmask and lan_network/lan_netmask intersect? */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if ((network &amp; lan_netmask) =3D=3D l=
an_network</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 || (lan_network &amp; netmask) =3D=3D network)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            msg(M_WARN, &quot;WARNING: potential %s subnet co=
nflict between local LAN [%s/%s] and remote VPN [%s/%s]&quot;,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                prefix,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                print_in_addr_t(=
lan_network, 0, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                print_in_addr_t(lan_netmask, 0, &amp;gc),</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                print_in_addr_t(net=
work, 0, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             print_in_addr_t(netmask, 0, &amp;gc));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif /* if 0 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> vo=
id</span><br><span> warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx)</=
span><br><span> {</span><br><span>@@ -922,15 +884,6 @@</span><br><span>    =
                                  tt-&gt;remote_netmask);</span><br><span> =
                }</span><br><span>             }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (!tun_p2p)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                check_subnet_conflict(tt-&gt;local, tt-&gt;remote_netmask=
, &quot;TUN/TAP adapter&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     check_subnet_conflict(tt-&gt;local, IPV4_NETMASK_HOST, &quot;TUN/TAP a=
dapter&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     }</span><br><span>         }</span><br><span> </span><br><span> #ifdef=
 _WIN32</span><br><span>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h<=
/span><br><span>index ccba0bc..b616f5d 100644</span><br><span>--- a/src/ope=
nvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span><br><span>@@ -355,=
10 +355,6 @@</span><br><span> </span><br><span> bool is_tun_p2p(const struc=
t tuntap *tt);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void check_subnet_conflict(const in_addr_t ip,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                           const in_add=
r_t netmask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                  const char *prefix);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> void warn_on_use_of_common_subnets(openv=
pn_net_ctx_t *ctx);</span><br><span> </span><br><span> /**</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/863?usp=3Demail">change 863</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/863?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If570253e57371e4126b0e8aa4c3=
49e2051cb8b00 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 863 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--1a5EA0N/yrc=--

