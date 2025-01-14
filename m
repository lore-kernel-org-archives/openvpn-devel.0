From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 13:14:14 +0000
References: <gerrit.1736860439000.If570253e57371e4126b0e8aa4c349e2051cb8b00@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f5a051ea167dd8807a30f978b250ffd3a8d48cd4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3D0QBMjEMts="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3D0QBMjEMts=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/863?usp=3Demail

to review the following change.


Change subject: Remove unused function check_subnet_conflict
......................................................................

Remove unused function check_subnet_conflict

This has been #if 0 for over a decade. Let's just
remove this.

Change-Id: If570253e57371e4126b0e8aa4c349e2051cb8b00
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/route.c
M src/openvpn/tun.c
M src/openvpn/tun.h
3 files changed, 0 insertions(+), 52 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/863/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 278233f..b8ede01 100644
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
index 9dce8da..3f2ec4a 100644
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
index a5b9a48..911e58b 100644
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--3D0QBMjEMts=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/863?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove unused function check_subnet_conflict<br><br>This has =
been #if 0 for over a decade. Let&#39;s just<br>remove this.<br><br>Change-=
Id: If570253e57371e4126b0e8aa4c349e2051cb8b00<br>Signed-off-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/route.c<br>M src/op=
envpn/tun.c<br>M src/openvpn/tun.h<br>3 files changed, 0 insertions(+), 52 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/63/863/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/route.c b/src/openvpn/ro=
ute.c</span><br><span>index 278233f..b8ede01 100644</span><br><span>--- a/s=
rc/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><spa=
n>@@ -1218,7 +1218,6 @@</span><br><span> </span><br><span>         for (r =
=3D rl-&gt;routes; r; r =3D r-&gt;next)</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            check_subnet_confl=
ict(r-&gt;network, r-&gt;netmask, &quot;route&quot;);</span><br><span>     =
        if (flags &amp; ROUTE_DELETE_FIRST)</span><br><span>             {<=
/span><br><span>                 delete_route(r, tt, flags, &amp;rl-&gt;rgi=
, es, ctx);</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tu=
n.c</span><br><span>index 9dce8da..3f2ec4a 100644</span><br><span>--- a/src=
/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -=
626,44 +626,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Issue a warning if i=
p/netmask (on the virtual IP network) conflicts with</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * the settings on the local LAN.  This is =
designed to flag issues where</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * (for example) the OpenVPN server LAN is running on 192.168.1.x, =
but then</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * an OpenVPN=
 client tries to connect from a public location that is also running</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * off of a router set to 19=
2.168.1.x.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-check_subnet_conflict(const in_addr_t ip,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                      cons=
t in_addr_t netmask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                     const char *prefix)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if 0 /* too many false positives */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    in_addr_t lan_gw =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    in_addr_t lan_netmask =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (get_default_gateway(&amp;lan_gw, &amp;lan_=
netmask) &amp;&amp; lan_netmask)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   const in_addr_t lan_network =3D lan_gw &amp; lan_netmask;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        const in_addr_t network =3D =
ip &amp; netmask;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* do the two sub=
nets defined by network/netmask and lan_network/lan_netmask intersect? */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((network &a=
mp; lan_netmask) =3D=3D lan_network</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            || (lan_network &amp; netmask) =3D=3D network)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WARNIN=
G: potential %s subnet conflict between local LAN [%s/%s] and remote VPN [%=
s/%s]&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         print_in_addr_t(lan_network, 0, &amp;gc),</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                print_in_addr_t(lan_netmask, 0=
, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      print_in_addr_t(network, 0, &amp;gc),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                print_in_addr_t(netmask, 0, &amp;gc))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif /* if 0 */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> void</span><br><span> warn_on_use_of_common_subnets(op=
envpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>@@ -922,15 +884,6 =
@@</span><br><span>                                      tt-&gt;remote_netm=
ask);</span><br><span>                 }</span><br><span>             }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            if (!tun_p2p)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                check_subnet_conflict(tt-&gt;local=
, tt-&gt;remote_netmask, &quot;TUN/TAP adapter&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                check_subnet_conflict(tt-&gt;local, IPV4_NETMAS=
K_HOST, &quot;TUN/TAP adapter&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span>         }</span><br><span> <=
/span><br><span> #ifdef _WIN32</span><br><span>diff --git a/src/openvpn/tun=
.h b/src/openvpn/tun.h</span><br><span>index a5b9a48..911e58b 100644</span>=
<br><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</=
span><br><span>@@ -355,10 +355,6 @@</span><br><span> </span><br><span> bool=
 is_tun_p2p(const struct tuntap *tt);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void check_subnet_conflict(const in_addr_=
t ip,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
           const in_addr_t netmask,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                           const char *prefix);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void warn_on_use_=
of_common_subnets(openvpn_net_ctx_t *ctx);</span><br><span> </span><br><spa=
n> /**</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/863?usp=3Demail">change 863</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/863?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If570253e57371e4126b0e8aa4c3=
49e2051cb8b00 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 863 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--3D0QBMjEMts=--

