From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 19 Nov 2025 03:22:20 +0000
In-Reply-To: <gerrit.1758894427000.I16d90221d0a75193035253817ff195f6da9dc0b3@...2715...>
References: <gerrit.1758894427000.I16d90221d0a75193035253817ff195f6da9dc0b3@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <ff7faaec167f5c580f4d8ef843d85905a5f41570-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FKTaMb3eEW4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: handle
 default gateway (net_gateway) and nexthop towards VPN s...
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

--FKTaMb3eEW4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1222?usp=3Demail

to look at the new patch set (#4).


Change subject: route: handle default gateway (net_gateway) and nexthop tow=
ards VPN server separately
......................................................................

route: handle default gateway (net_gateway) and nexthop towards VPN server =
separately

Right now there is the assumption that the gateway used for net_gateway is =
the same used to reach the VPN server.
However, these two gateways may be different (i.e. when there is a specific=
 hostroute for the VPN server using a different nexthop).
For this reason we must adapt init_route_list() to fetch the two gateways s=
eparately.

Github: fixes OpenVPN/openvpn#890

Change-Id: I16d90221d0a75193035253817ff195f6da9dc0b3
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/route.c
M src/openvpn/route.h
2 files changed, 16 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1222/4

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 7d988da..770300a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -257,9 +257,9 @@
     {
         if (rl)
         {
-            if (rl->rgi.flags & RGI_ADDR_DEFINED)
+            if (rl->ngi.flags & RGI_ADDR_DEFINED)
             {
-                *out =3D rl->rgi.gateway.addr;
+                *out =3D rl->ngi.gateway.addr;
             }
             else
             {
@@ -624,10 +624,10 @@
         rl->spec.flags |=3D RTSA_DEFAULT_METRIC;
     }

-    get_default_gateway(&rl->rgi, remote_host !=3D IPV4_INVALID_ADDR ? rem=
ote_host : INADDR_ANY, ctx);
-    if (rl->rgi.flags & RGI_ADDR_DEFINED)
+    get_default_gateway(&rl->ngi, INADDR_ANY, ctx);
+    if (rl->ngi.flags & RGI_ADDR_DEFINED)
     {
-        setenv_route_addr(es, "net_gateway", rl->rgi.gateway.addr, -1);
+        setenv_route_addr(es, "net_gateway", rl->ngi.gateway.addr, -1);
 #if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
         print_default_gateway(D_ROUTE, &rl->rgi, NULL);
 #endif
@@ -637,6 +637,8 @@
         dmsg(D_ROUTE, "ROUTE: default_gateway=3DUNDEF");
     }

+    get_default_gateway(&rl->rgi, remote_host !=3D IPV4_INVALID_ADDR ? rem=
ote_host : INADDR_ANY, ctx);
+
     if (rl->spec.flags & RTSA_REMOTE_HOST)
     {
         rl->spec.remote_host_local =3D test_local_addr(remote_host, &rl->r=
gi);
@@ -773,10 +775,10 @@
     msg(D_ROUTE, "GDG6: remote_host_ipv6=3D%s",
         remote_host_ipv6 ? print_in6_addr(*remote_host_ipv6, 0, &gc) : "n/=
a");

-    get_default_gateway_ipv6(&rl6->rgi6, remote_host_ipv6, ctx);
-    if (rl6->rgi6.flags & RGI_ADDR_DEFINED)
+    get_default_gateway_ipv6(&rl6->ngi6, NULL, ctx);
+    if (rl6->ngi6.flags & RGI_ADDR_DEFINED)
     {
-        setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->rgi6.gatewa=
y.addr_ipv6, 0, &gc));
+        setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->ngi6.gatewa=
y.addr_ipv6, 0, &gc));
 #if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
         print_default_gateway(D_ROUTE, NULL, &rl6->rgi6);
 #endif
@@ -786,6 +788,8 @@
         dmsg(D_ROUTE, "ROUTE6: default_gateway=3DUNDEF");
     }

+    get_default_gateway_ipv6(&rl6->rgi6, remote_host_ipv6, ctx);
+
     if (is_route_parm_defined(remote_endpoint))
     {
         if (inet_pton(AF_INET6, remote_endpoint, &rl6->remote_endpoint_ipv=
6) =3D=3D 1)
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 54fa137..3d19dbd 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -234,7 +234,8 @@

     struct route_special_addr spec;
     struct route_gateway_info rgi;
-    unsigned int flags; /* RG_x flags */
+    struct route_gateway_info ngi; /* net_gateway */
+    unsigned int flags;            /* RG_x flags */
     struct route_ipv4 *routes;
     struct gc_arena gc;
 };
@@ -249,7 +250,8 @@
     int default_metric;

     struct route_ipv6_gateway_info rgi6;
-    unsigned int flags; /* RG_x flags, see route_option_list */
+    struct route_ipv6_gateway_info ngi6; /* net_gateway_ipv6 */
+    unsigned int flags;                  /* RG_x flags, see route_option_l=
ist */
     struct route_ipv6 *routes_ipv6;
     struct gc_arena gc;
 };

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1222?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I16d90221d0a75193035253817ff195f6da9dc0b3
Gerrit-Change-Number: 1222
Gerrit-PatchSet: 4
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>

--FKTaMb3eEW4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #4</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1222?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: handle default gateway (net_gateway) and nexthop=
 towards VPN server separately<br><br>Right now there is the assumption tha=
t the gateway used for net_gateway is the same used to reach the VPN server=
.<br>However, these two gateways may be different (i.e. when there is a spe=
cific hostroute for the VPN server using a different nexthop).<br>For this =
reason we must adapt init_route_list() to fetch the two gateways separately=
.<br><br>Github: fixes OpenVPN/openvpn#890<br><br>Change-Id: I16d90221d0a75=
193035253817ff195f6da9dc0b3<br>Signed-off-by: Marco Baffo &lt;marco@...2787...=
...&gt;<br>---<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>2 files=
 changed, 16 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1222/4</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>inde=
x 7d988da..770300a 100644</span><br><span>--- a/src/openvpn/route.c</span><=
br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -257,9 +257,9 @@</spa=
n><br><span>     {</span><br><span>         if (rl)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (rl=
-&gt;rgi.flags &amp; RGI_ADDR_DEFINED)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (rl-&gt;ngi.flags &amp; RGI_ADDR_DEFINED)=
</span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                *out =3D rl-&gt;rgi.gateway.addr;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                *out =3D rl-&gt;ngi=
.gateway.addr;</span><br><span>             }</span><br><span>             =
else</span><br><span>             {</span><br><span>@@ -624,10 +624,10 @@</=
span><br><span>         rl-&gt;spec.flags |=3D RTSA_DEFAULT_METRIC;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    get_default_gateway(&amp;rl-&gt;rgi, remote_host !=3D IPV4_=
INVALID_ADDR ? remote_host : INADDR_ANY, ctx);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (rl-&gt;rgi.flags &amp; RGI_ADDR_DEFINED)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    get_default_gatew=
ay(&amp;rl-&gt;ngi, INADDR_ANY, ctx);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (rl-&gt;ngi.flags &amp; RGI_ADDR_DEFINED)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 setenv_route_addr(es, &quot;net_gateway&quot;, rl-&gt;rgi.gateway.addr, -1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        setenv_ro=
ute_addr(es, &quot;net_gateway&quot;, rl-&gt;ngi.gateway.addr, -1);</span><=
br><span> #if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span=
><br><span>         print_default_gateway(D_ROUTE, &amp;rl-&gt;rgi, NULL);<=
/span><br><span> #endif</span><br><span>@@ -637,6 +637,8 @@</span><br><span=
>         dmsg(D_ROUTE, &quot;ROUTE: default_gateway=3DUNDEF&quot;);</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    get_default_gateway(&amp;rl-&gt;rgi, remote_host !=3D IP=
V4_INVALID_ADDR ? remote_host : INADDR_ANY, ctx);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     if (rl-&gt;spec.flags &=
amp; RTSA_REMOTE_HOST)</span><br><span>     {</span><br><span>         rl-&=
gt;spec.remote_host_local =3D test_local_addr(remote_host, &amp;rl-&gt;rgi)=
;</span><br><span>@@ -773,10 +775,10 @@</span><br><span>     msg(D_ROUTE, &=
quot;GDG6: remote_host_ipv6=3D%s&quot;,</span><br><span>         remote_hos=
t_ipv6 ? print_in6_addr(*remote_host_ipv6, 0, &amp;gc) : &quot;n/a&quot;);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
get_default_gateway_ipv6(&amp;rl6-&gt;rgi6, remote_host_ipv6, ctx);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (rl6-&gt;rgi6.flags &a=
mp; RGI_ADDR_DEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    get_default_gateway_ipv6(&amp;rl6-&gt;ngi6, NULL, ctx);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (rl6-&gt;ngi6.flags &amp; =
RGI_ADDR_DEFINED)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        setenv_str(es, &quot;net_gateway_ipv6&quot;, pri=
nt_in6_addr(rl6-&gt;rgi6.gateway.addr_ipv6, 0, &amp;gc));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        setenv_str(es, &quot;net_gate=
way_ipv6&quot;, print_in6_addr(rl6-&gt;ngi6.gateway.addr_ipv6, 0, &amp;gc))=
;</span><br><span> #if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMA=
LL)</span><br><span>         print_default_gateway(D_ROUTE, NULL, &amp;rl6-=
&gt;rgi6);</span><br><span> #endif</span><br><span>@@ -786,6 +788,8 @@</spa=
n><br><span>         dmsg(D_ROUTE, &quot;ROUTE6: default_gateway=3DUNDEF&qu=
ot;);</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    get_default_gateway_ipv6(&amp;rl6-&gt;rgi6, =
remote_host_ipv6, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     if (is_route_parm_defined(remote_endpoint))</span=
><br><span>     {</span><br><span>         if (inet_pton(AF_INET6, remote_e=
ndpoint, &amp;rl6-&gt;remote_endpoint_ipv6) =3D=3D 1)</span><br><span>diff =
--git a/src/openvpn/route.h b/src/openvpn/route.h</span><br><span>index 54f=
a137..3d19dbd 100644</span><br><span>--- a/src/openvpn/route.h</span><br><s=
pan>+++ b/src/openvpn/route.h</span><br><span>@@ -234,7 +234,8 @@</span><br=
><span> </span><br><span>     struct route_special_addr spec;</span><br><sp=
an>     struct route_gateway_info rgi;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    unsigned int flags; /* RG_x flags */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct route_gateway_info ngi; /*=
 net_gateway */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
unsigned int flags;            /* RG_x flags */</span><br><span>     struct=
 route_ipv4 *routes;</span><br><span>     struct gc_arena gc;</span><br><sp=
an> };</span><br><span>@@ -249,7 +250,8 @@</span><br><span>     int default=
_metric;</span><br><span> </span><br><span>     struct route_ipv6_gateway_i=
nfo rgi6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned=
 int flags; /* RG_x flags, see route_option_list */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct route_ipv6_gateway_info ngi6; =
/* net_gateway_ipv6 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    unsigned int flags;                  /* RG_x flags, see route_option=
_list */</span><br><span>     struct route_ipv6 *routes_ipv6;</span><br><sp=
an>     struct gc_arena gc;</span><br><span> };</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/12=
22?usp=3Demail">change 1222</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1222?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16d90221d0a75193035253817ff=
195f6da9dc0b3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1222 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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

</body></html>=

--FKTaMb3eEW4=--

