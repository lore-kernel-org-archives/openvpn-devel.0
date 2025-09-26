From: "mrbff (Code Review)" <gerrit@...515...>
Date: Fri, 26 Sep 2025 13:47:10 +0000
References: <gerrit.1758894427000.I16d90221d0a75193035253817ff195f6da9dc0b3@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5b7b9be45732de88f129388a99df89db4de8c781-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0PM/JcO2tNU="; charset=UTF-8
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

--0PM/JcO2tNU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1222?usp=3Demail

to review the following change.


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

Change-Id: I16d90221d0a75193035253817ff195f6da9dc0b3
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/route.c
1 file changed, 14 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1222/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 156a99e..29c7d7c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -624,10 +624,12 @@
         rl->spec.flags |=3D RTSA_DEFAULT_METRIC;
     }

-    get_default_gateway(&rl->rgi, remote_host !=3D IPV4_INVALID_ADDR ? rem=
ote_host : INADDR_ANY, ctx);
-    if (rl->rgi.flags & RGI_ADDR_DEFINED)
+    struct route_gateway_info ngi;
+
+    get_default_gateway(&ngi, INADDR_ANY, ctx);
+    if (ngi.flags & RGI_ADDR_DEFINED)
     {
-        setenv_route_addr(es, "net_gateway", rl->rgi.gateway.addr, -1);
+        setenv_route_addr(es, "net_gateway", ngi.gateway.addr, -1);
 #if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
         print_default_gateway(D_ROUTE, &rl->rgi, NULL);
 #endif
@@ -637,6 +639,8 @@
         dmsg(D_ROUTE, "ROUTE: default_gateway=3DUNDEF");
     }

+    get_default_gateway(&rl->rgi, remote_host !=3D IPV4_INVALID_ADDR ? rem=
ote_host : INADDR_ANY, ctx);
+
     if (rl->spec.flags & RTSA_REMOTE_HOST)
     {
         rl->spec.remote_host_local =3D test_local_addr(remote_host, &rl->r=
gi);
@@ -778,10 +782,12 @@
     msg(D_ROUTE, "GDG6: remote_host_ipv6=3D%s",
         remote_host_ipv6 ? print_in6_addr(*remote_host_ipv6, 0, &gc) : "n/=
a");

-    get_default_gateway_ipv6(&rl6->rgi6, remote_host_ipv6, ctx);
-    if (rl6->rgi6.flags & RGI_ADDR_DEFINED)
+    struct route_ipv6_gateway_info ngi6;
+
+    get_default_gateway_ipv6(&ngi6, NULL, ctx);
+    if (ngi6.flags & RGI_ADDR_DEFINED)
     {
-        setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->rgi6.gatewa=
y.addr_ipv6, 0, &gc));
+        setenv_str(es, "net_gateway_ipv6", print_in6_addr(ngi6.gateway.add=
r_ipv6, 0, &gc));
 #if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
         print_default_gateway(D_ROUTE, NULL, &rl6->rgi6);
 #endif
@@ -791,6 +797,8 @@
         dmsg(D_ROUTE, "ROUTE6: default_gateway=3DUNDEF");
     }

+    get_default_gateway_ipv6(&rl6->rgi6, remote_host_ipv6, ctx);
+
     if (is_route_parm_defined(remote_endpoint))
     {
         if (inet_pton(AF_INET6, remote_endpoint, &rl6->remote_endpoint_ipv=
6) =3D=3D 1)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1222?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I16d90221d0a75193035253817ff195f6da9dc0b3
Gerrit-Change-Number: 1222
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--0PM/JcO2tNU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1222?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">route: handle default gateway (net_gateway) and nexthop towa=
rds VPN server separately<br><br>Right now there is the assumption that the=
 gateway used for net_gateway is the same used to reach the VPN server.<br>=
However, these two gateways may be different (i.e. when there is a specific=
 hostroute for the VPN server using a different nexthop).<br>For this reaso=
n we must adapt init_route_list() to fetch the two gateways separately.<br>=
<br>Change-Id: I16d90221d0a75193035253817ff195f6da9dc0b3<br>Signed-off-by: =
Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn/route.c<br>1 f=
ile changed, 14 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/22/1222/1</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 156a99e..29c7=
d7c 100644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/=
src/openvpn/route.c</span><br><span>@@ -624,10 +624,12 @@</span><br><span> =
        rl-&gt;spec.flags |=3D RTSA_DEFAULT_METRIC;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
get_default_gateway(&amp;rl-&gt;rgi, remote_host !=3D IPV4_INVALID_ADDR ? r=
emote_host : INADDR_ANY, ctx);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (rl-&gt;rgi.flags &amp; RGI_ADDR_DEFINED)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct route_gateway_info ngi;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    get_default_gateway(&amp;ngi, INADDR_=
ANY, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (n=
gi.flags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        setenv_route_addr(es, &quot;net_g=
ateway&quot;, rl-&gt;rgi.gateway.addr, -1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        setenv_route_addr(es, &quot;net_gateway&quo=
t;, ngi.gateway.addr, -1);</span><br><span> #if defined(ENABLE_DEBUG) &amp;=
&amp; !defined(ENABLE_SMALL)</span><br><span>         print_default_gateway=
(D_ROUTE, &amp;rl-&gt;rgi, NULL);</span><br><span> #endif</span><br><span>@=
@ -637,6 +639,8 @@</span><br><span>         dmsg(D_ROUTE, &quot;ROUTE: defa=
ult_gateway=3DUNDEF&quot;);</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    get_default_gateway(&a=
mp;rl-&gt;rgi, remote_host !=3D IPV4_INVALID_ADDR ? remote_host : INADDR_AN=
Y, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     if (rl-&gt;spec.flags &amp; RTSA_REMOTE_HOST)</span><br><span>  =
   {</span><br><span>         rl-&gt;spec.remote_host_local =3D test_local_=
addr(remote_host, &amp;rl-&gt;rgi);</span><br><span>@@ -778,10 +782,12 @@</=
span><br><span>     msg(D_ROUTE, &quot;GDG6: remote_host_ipv6=3D%s&quot;,</=
span><br><span>         remote_host_ipv6 ? print_in6_addr(*remote_host_ipv6=
, 0, &amp;gc) : &quot;n/a&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    get_default_gateway_ipv6(&amp;rl6-&gt;r=
gi6, remote_host_ipv6, ctx);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (rl6-&gt;rgi6.flags &amp; RGI_ADDR_DEFINED)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct route_ipv6_gateway_info ng=
i6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    get_default_gateway_ipv6(&amp;n=
gi6, NULL, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (ngi6.flags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        setenv_str(es, &quot;net_g=
ateway_ipv6&quot;, print_in6_addr(rl6-&gt;rgi6.gateway.addr_ipv6, 0, &amp;g=
c));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        setenv_=
str(es, &quot;net_gateway_ipv6&quot;, print_in6_addr(ngi6.gateway.addr_ipv6=
, 0, &amp;gc));</span><br><span> #if defined(ENABLE_DEBUG) &amp;&amp; !defi=
ned(ENABLE_SMALL)</span><br><span>         print_default_gateway(D_ROUTE, N=
ULL, &amp;rl6-&gt;rgi6);</span><br><span> #endif</span><br><span>@@ -791,6 =
+797,8 @@</span><br><span>         dmsg(D_ROUTE, &quot;ROUTE6: default_gate=
way=3DUNDEF&quot;);</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    get_default_gateway_ipv6(&amp;=
rl6-&gt;rgi6, remote_host_ipv6, ctx);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     if (is_route_parm_defined(remote_en=
dpoint))</span><br><span>     {</span><br><span>         if (inet_pton(AF_I=
NET6, remote_endpoint, &amp;rl6-&gt;remote_endpoint_ipv6) =3D=3D 1)</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1222?usp=3Demail">change 1222</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1222?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16d90221d0a75193035253817ff=
195f6da9dc0b3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1222 </div>
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


--0PM/JcO2tNU=--

