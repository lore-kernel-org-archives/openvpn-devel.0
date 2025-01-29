From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 13:49:10 +0000
References: <gerrit.1738158547000.I9e96af79981c4cb050f5b963837c7166e92e6791@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8000d2ec789a09800e794a76a7c5fe2de5b65e64-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XqXsdam8Bnk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XqXsdam8Bnk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/882?usp=3Demail

to review the following change.


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

Change-Id: Ic438c583a782035ecb9b5ea65702a768ae2585f5
Signed-off-by: Gert Doering <gert@...1296...>

--
v2: amend --help output

Change-Id: I9e96af79981c4cb050f5b963837c7166e92e6791
---
M doc/man-sections/advanced-options.rst
M src/openvpn/options.c
2 files changed, 19 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/882/1

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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/882?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e96af79981c4cb050f5b963837c7166e92e6791
Gerrit-Change-Number: 882
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--XqXsdam8Bnk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/882?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">options: add IPv4 support to &#39;--show-gateway &lt;arg&gt;&=
#39;<br><br>This is an old debug option, which used to print &quot;the defa=
ult routes found&quot;<br>for IPv4 and IPv6, and optionally &quot;a route t=
o a particular IPv6 target&quot;<br>if passed an argument.<br><br>With the =
work started in commit 0fcfc8381f60d we want this to handle<br>IPv4 as well=
, mostly to be able to easily test per-platform<br>get_default_gateway() im=
plementations.<br><br>The implementation is simplistic - if &lt;arg&gt; can=
 be parsed as an IPv4 or<br>IPv6 address, that particular protocol lookup w=
ill do &quot;the host route&quot;<br>and the other one will stick to &quot;=
the default route&quot;.<br><br>NOTE: as of this commit, there is no backen=
d functionality for IPv4, so<br>it will not actually print anything interes=
ting.  This will be added in<br>further platform dependent commits.<br><br>=
Change-Id: Ic438c583a782035ecb9b5ea65702a768ae2585f5<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br><br>--<br>v2: amend --help output<br><b=
r>Change-Id: I9e96af79981c4cb050f5b963837c7166e92e6791<br>---<br>M doc/man-=
sections/advanced-options.rst<br>M src/openvpn/options.c<br>2 files changed=
, 19 insertions(+), 9 deletions(-)<br><br></pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/82/882/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sectio=
ns/advanced-options.rst b/doc/man-sections/advanced-options.rst</span><br><=
span>index d5a6b4f..e1115e4 100644</span><br><span>--- a/doc/man-sections/a=
dvanced-options.rst</span><br><span>+++ b/doc/man-sections/advanced-options=
.rst</span><br><span>@@ -9,13 +9,17 @@</span><br><span>   ::</span><br><spa=
n> </span><br><span>      --show-gateway</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     --show-gateway IPv4-target</span><br><span>      =
--show-gateway IPv6-target</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  For IPv4 it looks for a 0.0.0.0/0 route, or the =
specified IPv4 address</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  if the target can be parsed as an IPv4 address.</span><br><span>   For=
 IPv6 this queries the route towards ::/128, or the specified IPv6</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  target address if passed as =
argument.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  For IPv4 o=
n Linux, Windows, MacOS and BSD it looks for a 0.0.0.0/0 route.</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  If there are more specific rout=
es, the result will not always be matching</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  the route of the IPv4 packets to the VPN gateway.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  target address if th=
e argument is an IPv6 address.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Adding=
 a target is helpful for diagnostics to see if OpenVPN will do</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  the right thing if there are m=
ore specific IPv4/IPv6 routes to a</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  VPN server.</span><br><span> </span><br><span> </span><br>=
<span> Advanced Expert Options</span><br><span>diff --git a/src/openvpn/opt=
ions.c b/src/openvpn/options.c</span><br><span>index 5a80e6b..00c6fce 10064=
4</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/ope=
nvpn/options.c</span><br><span>@@ -788,7 +788,7 @@</span><br><span>     &qu=
ot;\n&quot;</span><br><span>     &quot;General Standalone Options:\n&quot;<=
/span><br><span> #ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &quot;--show-gateway : Show info about default gateway.\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--=
show-gateway [address]: Show info about gateway [to v4/v6 address].\n&quot;=
</span><br><span> #endif</span><br><span> ;</span><br><span> </span><br><sp=
an>@@ -5858,16 +5858,22 @@</span><br><span>     {</span><br><span>         =
struct route_gateway_info rgi;</span><br><span>         struct route_ipv6_g=
ateway_info rgi6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    struct in6_addr remote =3D IN6ADDR_ANY_INIT;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        in_addr_t remote_ipv4 =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        struct in6_addr remot=
e_ipv6 =3D IN6ADDR_ANY_INIT;</span><br><span>         openvpn_net_ctx_t net=
_ctx;</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br>=
<span>         if (p[1])</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            get_ipv6_addr(p[1], &amp;remote=
, NULL, M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         /* try parsing the argument as a v4 or v6 address - if</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+             * possible, the ou=
tput will show the exact route there, and</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+             * &quot;the default route&quot; for the =
other protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
        */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   remote_ipv4 =3D get_ip_addr(p[1], M_WARN, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            get_ipv6_addr(p[1], &amp;remo=
te_ipv6, NULL, M_WARN);</span><br><span>         }</span><br><span>        =
 net_ctx_init(NULL, &amp;net_ctx);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        get_default_gateway(&amp;rgi, 0, &amp;net_ctx);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        get_default_gateway_=
ipv6(&amp;rgi6, &amp;remote, &amp;net_ctx);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        get_default_gateway(&amp;rgi, remote_ipv4, =
&amp;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   get_default_gateway_ipv6(&amp;rgi6, &amp;remote_ipv6, &amp;net_ctx);</sp=
an><br><span>         print_default_gateway(M_INFO, &amp;rgi, &amp;rgi6);</=
span><br><span>         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit poi=
nt */</span><br><span>     }</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/882?usp=3Demail">chan=
ge 882</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/882?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e96af79981c4cb050f5b963837=
c7166e92e6791 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 882 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
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


--XqXsdam8Bnk=--

