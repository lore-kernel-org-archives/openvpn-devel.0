From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 25 Feb 2025 09:49:49 +0000
References: <gerrit.1740476988000.Ifc54be34101c0eb0f3dc479a9480d7219628cc76@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c73e63adf423c67fc8164fc3c7be4541b92457c2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="674wSEu9mm4="; charset=UTF-8
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

--674wSEu9mm4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/902?usp=3Demail

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

Change-Id: Ifc54be34101c0eb0f3dc479a9480d7219628cc76
---
M src/openvpn/route.c
1 file changed, 14 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/902/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bc41492..3ddc333 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -655,10 +655,12 @@
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
@@ -668,6 +670,8 @@
         dmsg(D_ROUTE, "ROUTE: default_gateway=3DUNDEF");
     }

+    get_default_gateway(&rl->rgi, remote_host !=3D IPV4_INVALID_ADDR ? rem=
ote_host : INADDR_ANY, ctx);
+
     if (rl->spec.flags & RTSA_REMOTE_HOST)
     {
         rl->spec.remote_host_local =3D test_local_addr(remote_host, &rl->r=
gi);
@@ -818,10 +822,12 @@
     msg(D_ROUTE, "GDG6: remote_host_ipv6=3D%s",
         remote_host_ipv6 ?  print_in6_addr(*remote_host_ipv6, 0, &gc) : "n=
/a" );

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
@@ -831,6 +837,8 @@
         dmsg(D_ROUTE, "ROUTE6: default_gateway=3DUNDEF");
     }

+    get_default_gateway_ipv6(&rl6->rgi6, remote_host_ipv6, ctx);
+
     if (is_route_parm_defined( remote_endpoint ))
     {
         if (inet_pton( AF_INET6, remote_endpoint,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/902?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc54be34101c0eb0f3dc479a9480d7219628cc76
Gerrit-Change-Number: 902
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--674wSEu9mm4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/902?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">route: handle default gateway (net_gateway) and nexthop towar=
ds VPN server separately<br><br>Right now there is the assumption that the =
gateway used for net_gateway is the same used to reach the VPN server.<br>H=
owever, these two gateways may be different (i.e. when there is a specific =
hostroute for the VPN server using a different nexthop).<br>For this reason=
 we must adapt init_route_list() to fetch the two gateways separately.<br><=
br>Change-Id: Ifc54be34101c0eb0f3dc479a9480d7219628cc76<br>---<br>M src/ope=
nvpn/route.c<br>1 file changed, 14 insertions(+), 6 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/902/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>i=
ndex bc41492..3ddc333 100644</span><br><span>--- a/src/openvpn/route.c</spa=
n><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -655,10 +655,12 @@=
</span><br><span>         rl-&gt;spec.flags |=3D RTSA_DEFAULT_METRIC;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    get_default_gateway(&amp;rl-&gt;rgi, remote_host !=3D IPV=
4_INVALID_ADDR ? remote_host : INADDR_ANY, ctx);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (rl-&gt;rgi.flags &amp; RGI_ADDR_DEFINED)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct route_ga=
teway_info ngi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    get_default_gateway=
(&amp;ngi, INADDR_ANY, ctx);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (ngi.flags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_route_ad=
dr(es, &quot;net_gateway&quot;, rl-&gt;rgi.gateway.addr, -1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        setenv_route_addr(es, &qu=
ot;net_gateway&quot;, ngi.gateway.addr, -1);</span><br><span> #if defined(E=
NABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span>         pri=
nt_default_gateway(D_ROUTE, &amp;rl-&gt;rgi, NULL);</span><br><span> #endif=
</span><br><span>@@ -668,6 +670,8 @@</span><br><span>         dmsg(D_ROUTE,=
 &quot;ROUTE: default_gateway=3DUNDEF&quot;);</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    get_=
default_gateway(&amp;rl-&gt;rgi, remote_host !=3D IPV4_INVALID_ADDR ? remot=
e_host : INADDR_ANY, ctx);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     if (rl-&gt;spec.flags &amp; RTSA_REMOTE_HOST)<=
/span><br><span>     {</span><br><span>         rl-&gt;spec.remote_host_loc=
al =3D test_local_addr(remote_host, &amp;rl-&gt;rgi);</span><br><span>@@ -8=
18,10 +822,12 @@</span><br><span>     msg(D_ROUTE, &quot;GDG6: remote_host_=
ipv6=3D%s&quot;,</span><br><span>         remote_host_ipv6 ?  print_in6_add=
r(*remote_host_ipv6, 0, &amp;gc) : &quot;n/a&quot; );</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    get_default_gateway_i=
pv6(&amp;rl6-&gt;rgi6, remote_host_ipv6, ctx);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (rl6-&gt;rgi6.flags &amp; RGI_ADDR_DEFINED)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct route_ip=
v6_gateway_info ngi6;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    get_default_g=
ateway_ipv6(&amp;ngi6, NULL, ctx);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (ngi6.flags &amp; RGI_ADDR_DEFINED)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_s=
tr(es, &quot;net_gateway_ipv6&quot;, print_in6_addr(rl6-&gt;rgi6.gateway.ad=
dr_ipv6, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        setenv_str(es, &quot;net_gateway_ipv6&quot;, print_in6_addr(ngi6=
.gateway.addr_ipv6, 0, &amp;gc));</span><br><span> #if defined(ENABLE_DEBUG=
) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span>         print_default_=
gateway(D_ROUTE, NULL, &amp;rl6-&gt;rgi6);</span><br><span> #endif</span><b=
r><span>@@ -831,6 +837,8 @@</span><br><span>         dmsg(D_ROUTE, &quot;RO=
UTE6: default_gateway=3DUNDEF&quot;);</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    get_default_=
gateway_ipv6(&amp;rl6-&gt;rgi6, remote_host_ipv6, ctx);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (is_route_parm=
_defined( remote_endpoint ))</span><br><span>     {</span><br><span>       =
  if (inet_pton( AF_INET6, remote_endpoint,</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/902?us=
p=3Demail">change 902</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/902?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc54be34101c0eb0f3dc479a948=
0d7219628cc76 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 902 </div>
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


--674wSEu9mm4=--

