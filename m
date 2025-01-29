From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 19:26:46 +0000
In-Reply-To: <gerrit.1738150255000.Ic438c583a782035ecb9b5ea65702a768ae2585f5@...2715...>
References: <gerrit.1738150255000.Ic438c583a782035ecb9b5ea65702a768ae2585f5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <bbb7d5db6ec0618a658c72d5e3a2d74e0f0528c8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FoaclkgxkKQ="; charset=UTF-8
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

--FoaclkgxkKQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review+2 by stipa


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
v3: uncrustify (#ifdef block too long, comments at #endif required now)

Change-Id: Ic438c583a782035ecb9b5ea65702a768ae2585f5
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20250129173007.3280-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
728.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/advanced-options.rst
M src/openvpn/options.c
2 files changed, 20 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/881/4

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
index 5a80e6b..218d8a6 100644
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

@@ -5858,20 +5858,26 @@
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
-#endif
+#endif /* if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL) */
     else if (streq(p[0], "echo") || streq(p[0], "parameter"))
     {
         struct buffer string =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic438c583a782035ecb9b5ea65702a768ae2585f5
Gerrit-Change-Number: 881
Gerrit-PatchSet: 4
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--FoaclkgxkKQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">options: add IPv4 support to &#39;--show-gateway &lt=
;arg&gt;&#39;<br><br>This is an old debug option, which used to print &quot=
;the default routes found&quot;<br>for IPv4 and IPv6, and optionally &quot;=
a route to a particular IPv6 target&quot;<br>if passed an argument.<br><br>=
With the work started in commit 0fcfc8381f60d we want this to handle<br>IPv=
4 as well, mostly to be able to easily test per-platform<br>get_default_gat=
eway() implementations.<br><br>The implementation is simplistic - if &lt;ar=
g&gt; can be parsed as an IPv4 or<br>IPv6 address, that particular protocol=
 lookup will do &quot;the host route&quot;<br>and the other one will stick =
to &quot;the default route&quot;.<br><br>NOTE: as of this commit, there is =
no backend functionality for IPv4, so<br>it will not actually print anythin=
g interesting.  This will be added in<br>further platform dependent commits=
.<br><br>v2: amend --help output<br>v3: uncrustify (#ifdef block too long, =
comments at #endif required now)<br><br>Change-Id: Ic438c583a782035ecb9b5ea=
65702a768ae2585f5<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Message-Id: &lt;2025=
0129173007.3280-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/=
openvpn-devel@lists.sourceforge.net/msg30728.html<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections/advanced-options=
.rst<br>M src/openvpn/options.c<br>2 files changed, 20 insertions(+), 10 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/81/881/4</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/doc/man-sections/advanced-options.rst =
b/doc/man-sections/advanced-options.rst</span><br><span>index d5a6b4f..e111=
5e4 100644</span><br><span>--- a/doc/man-sections/advanced-options.rst</spa=
n><br><span>+++ b/doc/man-sections/advanced-options.rst</span><br><span>@@ =
-9,13 +9,17 @@</span><br><span>   ::</span><br><span> </span><br><span>    =
  --show-gateway</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  --show-gateway IPv4-target</span><br><span>      --show-gateway IPv6-targ=
et</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  For IPv4 it looks for a 0.0.0.0/0 route, or the specified IPv4 address</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  if the target can b=
e parsed as an IPv4 address.</span><br><span>   For IPv6 this queries the r=
oute towards ::/128, or the specified IPv6</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  target address if passed as argument.</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  For IPv4 on Linux, Windows, MacOS =
and BSD it looks for a 0.0.0.0/0 route.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  If there are more specific routes, the result will not =
always be matching</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  t=
he route of the IPv4 packets to the VPN gateway.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  target address if the argument is an IPv6 ad=
dress.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  Adding a target is helpful for=
 diagnostics to see if OpenVPN will do</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  the right thing if there are more specific IPv4/IPv6 r=
outes to a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  VPN ser=
ver.</span><br><span> </span><br><span> </span><br><span> Advanced Expert O=
ptions</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/opt=
ions.c</span><br><span>index 5a80e6b..218d8a6 100644</span><br><span>--- a/=
src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br=
><span>@@ -788,7 +788,7 @@</span><br><span>     &quot;\n&quot;</span><br><s=
pan>     &quot;General Standalone Options:\n&quot;</span><br><span> #ifdef =
ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot=
;--show-gateway : Show info about default gateway.\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;--show-gateway [address]: =
Show info about gateway [to v4/v6 address].\n&quot;</span><br><span> #endif=
</span><br><span> ;</span><br><span> </span><br><span>@@ -5858,20 +5858,26 =
@@</span><br><span>     {</span><br><span>         struct route_gateway_inf=
o rgi;</span><br><span>         struct route_ipv6_gateway_info rgi6;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        struct in6_addr remo=
te =3D IN6ADDR_ANY_INIT;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        in_addr_t remote_ipv4 =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct in6_addr remote_ipv6 =3D IN6ADDR_ANY_I=
NIT;</span><br><span>         openvpn_net_ctx_t net_ctx;</span><br><span>  =
       VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         if (p[1])=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            get_ipv6_addr(p[1], &amp;remote, NULL, M_WARN);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            /* try parsing th=
e argument as a v4 or v6 address - if</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             * possible, the output will show the exact r=
oute there, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
         * &quot;the default route&quot; for the other protocol</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+             */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            remote_ipv4 =3D get_ip_=
addr(p[1], M_WARN, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            get_ipv6_addr(p[1], &amp;remote_ipv6, NULL, M_WARN);</spa=
n><br><span>         }</span><br><span>         net_ctx_init(NULL, &amp;net=
_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        get_def=
ault_gateway(&amp;rgi, 0, &amp;net_ctx);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        get_default_gateway_ipv6(&amp;rgi6, &amp;remote,=
 &amp;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    get_default_gateway(&amp;rgi, remote_ipv4, &amp;net_ctx);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        get_default_gateway_ipv6(=
&amp;rgi6, &amp;remote_ipv6, &amp;net_ctx);</span><br><span>         print_=
default_gateway(M_INFO, &amp;rgi, &amp;rgi6);</span><br><span>         open=
vpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */</span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(ENABLE_DEBUG)=
 &amp;&amp; !defined(ENABLE_SMALL) */</span><br><span>     else if (streq(p=
[0], &quot;echo&quot;) || streq(p[0], &quot;parameter&quot;))</span><br><sp=
an>     {</span><br><span>         struct buffer string =3D alloc_buf_gc(OP=
TION_PARM_SIZE, &amp;gc);</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail">change =
881</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic438c583a782035ecb9b5ea6570=
2a768ae2585f5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 881 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--FoaclkgxkKQ=--

