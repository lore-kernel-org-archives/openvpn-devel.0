From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 19:26:48 +0000
In-Reply-To: <gerrit.1738150255000.Ic438c583a782035ecb9b5ea65702a768ae2585f5@...2715...>
References: <gerrit.1738150255000.Ic438c583a782035ecb9b5ea65702a768ae2585f5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <bbb7d5db6ec0618a658c72d5e3a2d74e0f0528c8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZLcL+QF/RQU="; charset=UTF-8
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
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZLcL+QF/RQU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/88=
1?usp=3Demail )

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
Gerrit-MessageType: merged

--ZLcL+QF/RQU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/881?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">options: add IPv4 support to &#39;--show-gatew=
ay &lt;arg&gt;&#39;<br><br>This is an old debug option, which used to print=
 &quot;the default routes found&quot;<br>for IPv4 and IPv6, and optionally =
&quot;a route to a particular IPv6 target&quot;<br>if passed an argument.<b=
r><br>With the work started in commit 0fcfc8381f60d we want this to handle<=
br>IPv4 as well, mostly to be able to easily test per-platform<br>get_defau=
lt_gateway() implementations.<br><br>The implementation is simplistic - if =
&lt;arg&gt; can be parsed as an IPv4 or<br>IPv6 address, that particular pr=
otocol lookup will do &quot;the host route&quot;<br>and the other one will =
stick to &quot;the default route&quot;.<br><br>NOTE: as of this commit, the=
re is no backend functionality for IPv4, so<br>it will not actually print a=
nything interesting.  This will be added in<br>further platform dependent c=
ommits.<br><br>v2: amend --help output<br>v3: uncrustify (#ifdef block too =
long, comments at #endif required now)<br><br>Change-Id: Ic438c583a782035ec=
b9b5ea65702a768ae2585f5<br>Signed-off-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Message-Id: &l=
t;20250129173007.3280-1-gert@...1296...&gt;<br>URL: https://www.mail-archiv=
e.com/openvpn-devel@lists.sourceforge.net/msg30728.html<br>Signed-off-by: G=
ert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections/advanced-o=
ptions.rst<br>M src/openvpn/options.c<br>2 files changed, 20 insertions(+),=
 10 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/ad=
vanced-options.rst</span><br><span>index d5a6b4f..e1115e4 100644</span><br>=
<span>--- a/doc/man-sections/advanced-options.rst</span><br><span>+++ b/doc=
/man-sections/advanced-options.rst</span><br><span>@@ -9,13 +9,17 @@</span>=
<br><span>   ::</span><br><span> </span><br><span>      --show-gateway</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     --show-gateway IPv4=
-target</span><br><span>      --show-gateway IPv6-target</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  For IPv4 it looks =
for a 0.0.0.0/0 route, or the specified IPv4 address</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  if the target can be parsed as an IPv4 =
address.</span><br><span>   For IPv6 this queries the route towards ::/128,=
 or the specified IPv6</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  target address if passed as argument.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  For IPv4 on Linux, Windows, MacOS and BSD it looks for=
 a 0.0.0.0/0 route.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
If there are more specific routes, the result will not always be matching</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the route of the IPv4=
 packets to the VPN gateway.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  target address if the argument is an IPv6 address.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  Adding a target is helpful for diagnostics to see =
if OpenVPN will do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 the right thing if there are more specific IPv4/IPv6 routes to a</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  VPN server.</span><br><span=
> </span><br><span> </span><br><span> Advanced Expert Options</span><br><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 5a80e6b..218d8a6 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -788,7 +78=
8,7 @@</span><br><span>     &quot;\n&quot;</span><br><span>     &quot;Gener=
al Standalone Options:\n&quot;</span><br><span> #ifdef ENABLE_DEBUG</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--show-gateway : Sh=
ow info about default gateway.\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;--show-gateway [address]: Show info about gate=
way [to v4/v6 address].\n&quot;</span><br><span> #endif</span><br><span> ;<=
/span><br><span> </span><br><span>@@ -5858,20 +5858,26 @@</span><br><span> =
    {</span><br><span>         struct route_gateway_info rgi;</span><br><sp=
an>         struct route_ipv6_gateway_info rgi6;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        struct in6_addr remote =3D IN6ADDR_ANY_I=
NIT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        in_addr=
_t remote_ipv4 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        struct in6_addr remote_ipv6 =3D IN6ADDR_ANY_INIT;</span><br><span=
>         openvpn_net_ctx_t net_ctx;</span><br><span>         VERIFY_PERMIS=
SION(OPT_P_GENERAL);</span><br><span>         if (p[1])</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ge=
t_ipv6_addr(p[1], &amp;remote, NULL, M_WARN);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /* try parsing the argument as a v4 o=
r v6 address - if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
           * possible, the output will show the exact route there, and</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+             * &quot;the=
 default route&quot; for the other protocol</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            remote_ipv4 =3D get_ip_addr(p[1], M_WARN, N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ge=
t_ipv6_addr(p[1], &amp;remote_ipv6, NULL, M_WARN);</span><br><span>        =
 }</span><br><span>         net_ctx_init(NULL, &amp;net_ctx);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        get_default_gateway(&amp;rg=
i, 0, &amp;net_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       get_default_gateway_ipv6(&amp;rgi6, &amp;remote, &amp;net_ctx);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        get_default_gate=
way(&amp;rgi, remote_ipv4, &amp;net_ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        get_default_gateway_ipv6(&amp;rgi6, &amp;remo=
te_ipv6, &amp;net_ctx);</span><br><span>         print_default_gateway(M_IN=
FO, &amp;rgi, &amp;rgi6);</span><br><span>         openvpn_exit(OPENVPN_EXI=
T_STATUS_GOOD); /* exit point */</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif /* if defined(ENABLE_DEBUG) &amp;&amp; !defined=
(ENABLE_SMALL) */</span><br><span>     else if (streq(p[0], &quot;echo&quot=
;) || streq(p[0], &quot;parameter&quot;))</span><br><span>     {</span><br>=
<span>         struct buffer string =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp=
;gc);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail">change 881</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/881?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--ZLcL+QF/RQU=--

