From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 13:52:15 +0000
In-Reply-To: <gerrit.1738150255000.Ic438c583a782035ecb9b5ea65702a768ae2585f5@...2715...>
References: <gerrit.1738150255000.Ic438c583a782035ecb9b5ea65702a768ae2585f5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <1da31e4b673ef53623b9880ba07baf63d0c79ae3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G1CnyHECwwA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: add IPv4
 support to '--show-gateway <arg>'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--G1CnyHECwwA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: options: add IPv4 support to '--show-gateway <arg>'
......................................................................

options: add IPv4 support to '--show-gateway <arg>'

This is an old debug option, which used to print "the default routes found"
for IPv4 and IPv6, and optionally "a route to a particular IPv6 target"
if passed an argument.

With the work started in commit 0fcfc8381f60d we want this to handle
IPv4 as well, mostly to be able to easily test per-platform
get_default_gateway() implementations.

The implementation is simplistic - if <arg> can be parsed as an IPv4 or
IPv6 address, that particular protocol lookup will do "the host route"
and the other one will stick to "the default route".

NOTE: as of this commit, there is no backend functionality for IPv4, so
it will not actually print anything interesting.  This will be added in
further platform dependent commits.

v2: amend --help output

Change-Id: Ic438c583a782035ecb9b5ea65702a768ae2585f5
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/advanced-options.rst
M src/openvpn/options.c
2 files changed, 19 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/881/2

diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advan=
ced-options.rst
index d5a6b4f..e1115e4 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -9,13 +9,17 @@
   ::

      --show-gateway
+     --show-gateway IPv4-target
      --show-gateway IPv6-target

+  For IPv4 it looks for a 0.0.0.0/0 route, or the specified IPv4 address
+  if the target can be parsed as an IPv4 address.
   For IPv6 this queries the route towards ::/128, or the specified IPv6
-  target address if passed as argument.
-  For IPv4 on Linux, Windows, MacOS and BSD it looks for a 0.0.0.0/0 route.
-  If there are more specific routes, the result will not always be matching
-  the route of the IPv4 packets to the VPN gateway.
+  target address if the argument is an IPv6 address.
+
+  Adding a target is helpful for diagnostics to see if OpenVPN will do
+  the right thing if there are more specific IPv4/IPv6 routes to a
+  VPN server.


 Advanced Expert Options
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5a80e6b..00c6fce 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -788,7 +788,7 @@
     "\n"
     "General Standalone Options:\n"
 #ifdef ENABLE_DEBUG
-    "--show-gateway : Show info about default gateway.\n"
+    "--show-gateway [address]: Show info about gateway [to v4/v6 address].=
\n"
 #endif
 ;

@@ -5858,16 +5858,22 @@
     {
         struct route_gateway_info rgi;
         struct route_ipv6_gateway_info rgi6;
-        struct in6_addr remote =3D IN6ADDR_ANY_INIT;
+        in_addr_t remote_ipv4 =3D 0;
+        struct in6_addr remote_ipv6 =3D IN6ADDR_ANY_INIT;
         openvpn_net_ctx_t net_ctx;
         VERIFY_PERMISSION(OPT_P_GENERAL);
         if (p[1])
         {
-            get_ipv6_addr(p[1], &remote, NULL, M_WARN);
+            /* try parsing the argument as a v4 or v6 address - if
+             * possible, the output will show the exact route there, and
+             * "the default route" for the other protocol
+             */
+            remote_ipv4 =3D get_ip_addr(p[1], M_WARN, NULL);
+            get_ipv6_addr(p[1], &remote_ipv6, NULL, M_WARN);
         }
         net_ctx_init(NULL, &net_ctx);
-        get_default_gateway(&rgi, 0, &net_ctx);
-        get_default_gateway_ipv6(&rgi6, &remote, &net_ctx);
+        get_default_gateway(&rgi, remote_ipv4, &net_ctx);
+        get_default_gateway_ipv6(&rgi6, &remote_ipv6, &net_ctx);
         print_default_gateway(M_INFO, &rgi, &rgi6);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic438c583a782035ecb9b5ea65702a768ae2585f5
Gerrit-Change-Number: 881
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--G1CnyHECwwA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">options: add IPv4 support to &#39;--show-gate=
way &lt;arg&gt;&#39;<br><br>This is an old debug option, which used to prin=
t &quot;the default routes found&quot;<br>for IPv4 and IPv6, and optionally=
 &quot;a route to a particular IPv6 target&quot;<br>if passed an argument.<=
br><br>With the work started in commit 0fcfc8381f60d we want this to handle=
<br>IPv4 as well, mostly to be able to easily test per-platform<br>get_defa=
ult_gateway() implementations.<br><br>The implementation is simplistic - if=
 &lt;arg&gt; can be parsed as an IPv4 or<br>IPv6 address, that particular p=
rotocol lookup will do &quot;the host route&quot;<br>and the other one will=
 stick to &quot;the default route&quot;.<br><br>NOTE: as of this commit, th=
ere is no backend functionality for IPv4, so<br>it will not actually print =
anything interesting.  This will be added in<br>further platform dependent =
commits.<br><br>v2: amend --help output<br><br>Change-Id: Ic438c583a782035e=
cb9b5ea65702a768ae2585f5<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M doc/man-sections/advanced-options.rst<br>M src/openvpn/opt=
ions.c<br>2 files changed, 19 insertions(+), 9 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/881/2</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advance=
d-options.rst</span><br><span>index d5a6b4f..e1115e4 100644</span><br><span=
>--- a/doc/man-sections/advanced-options.rst</span><br><span>+++ b/doc/man-=
sections/advanced-options.rst</span><br><span>@@ -9,13 +9,17 @@</span><br><=
span>   ::</span><br><span> </span><br><span>      --show-gateway</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     --show-gateway IPv4-targ=
et</span><br><span>      --show-gateway IPv6-target</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  For IPv4 it looks for a=
 0.0.0.0/0 route, or the specified IPv4 address</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  if the target can be parsed as an IPv4 addres=
s.</span><br><span>   For IPv6 this queries the route towards ::/128, or th=
e specified IPv6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  tar=
get address if passed as argument.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  For IPv4 on Linux, Windows, MacOS and BSD it looks for a 0.0=
.0.0/0 route.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  If the=
re are more specific routes, the result will not always be matching</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  the route of the IPv4 packe=
ts to the VPN gateway.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  target address if the argument is an IPv6 address.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  Adding a target is helpful for diagnostics to see if Ope=
nVPN will do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the r=
ight thing if there are more specific IPv4/IPv6 routes to a</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  VPN server.</span><br><span> </sp=
an><br><span> </span><br><span> Advanced Expert Options</span><br><span>dif=
f --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>ind=
ex 5a80e6b..00c6fce 100644</span><br><span>--- a/src/openvpn/options.c</spa=
n><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -788,7 +788,7 @@=
</span><br><span>     &quot;\n&quot;</span><br><span>     &quot;General Sta=
ndalone Options:\n&quot;</span><br><span> #ifdef ENABLE_DEBUG</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    &quot;--show-gateway : Show inf=
o about default gateway.\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;--show-gateway [address]: Show info about gateway [t=
o v4/v6 address].\n&quot;</span><br><span> #endif</span><br><span> ;</span>=
<br><span> </span><br><span>@@ -5858,16 +5858,22 @@</span><br><span>     {<=
/span><br><span>         struct route_gateway_info rgi;</span><br><span>   =
      struct route_ipv6_gateway_info rgi6;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        struct in6_addr remote =3D IN6ADDR_ANY_INIT;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        in_addr_t rem=
ote_ipv4 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct in6_addr remote_ipv6 =3D IN6ADDR_ANY_INIT;</span><br><span>     =
    openvpn_net_ctx_t net_ctx;</span><br><span>         VERIFY_PERMISSION(O=
PT_P_GENERAL);</span><br><span>         if (p[1])</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            get_ipv6=
_addr(p[1], &amp;remote, NULL, M_WARN);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            /* try parsing the argument as a v4 or v6 a=
ddress - if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
     * possible, the output will show the exact route there, and</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+             * &quot;the defau=
lt route&quot; for the other protocol</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            remote_ipv4 =3D get_ip_addr(p[1], M_WARN, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            get_ipv6=
_addr(p[1], &amp;remote_ipv6, NULL, M_WARN);</span><br><span>         }</sp=
an><br><span>         net_ctx_init(NULL, &amp;net_ctx);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        get_default_gateway(&amp;rgi, 0, =
&amp;net_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 get_default_gateway_ipv6(&amp;rgi6, &amp;remote, &amp;net_ctx);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        get_default_gateway(&a=
mp;rgi, remote_ipv4, &amp;net_ctx);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        get_default_gateway_ipv6(&amp;rgi6, &amp;remote_ipv=
6, &amp;net_ctx);</span><br><span>         print_default_gateway(M_INFO, &a=
mp;rgi, &amp;rgi6);</span><br><span>         openvpn_exit(OPENVPN_EXIT_STAT=
US_GOOD); /* exit point */</span><br><span>     }</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
881?usp=3Demail">change 881</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic438c583a782035ecb9b5ea6570=
2a768ae2585f5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 881 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--G1CnyHECwwA=--

