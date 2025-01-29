From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 17:02:31 +0000
In-Reply-To: <gerrit.1738150255000.Ic438c583a782035ecb9b5ea65702a768ae2585f5@...2715...>
References: <gerrit.1738150255000.Ic438c583a782035ecb9b5ea65702a768ae2585f5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <e957f9f3510174d8be6ade0ce41d6c98883f3827-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rLYSHNNhZuQ="; charset=UTF-8
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

--rLYSHNNhZuQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, stipa.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail

to look at the new patch set (#3).


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
---
M doc/man-sections/advanced-options.rst
M src/openvpn/options.c
2 files changed, 20 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/881/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--rLYSHNNhZuQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos, stipa. </p>
<p>cron2 <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">options: add IPv4 support to &#39;--show-gateway &lt;arg&gt;&#39;<br><br>=
This is an old debug option, which used to print &quot;the default routes f=
ound&quot;<br>for IPv4 and IPv6, and optionally &quot;a route to a particul=
ar IPv6 target&quot;<br>if passed an argument.<br><br>With the work started=
 in commit 0fcfc8381f60d we want this to handle<br>IPv4 as well, mostly to =
be able to easily test per-platform<br>get_default_gateway() implementation=
s.<br><br>The implementation is simplistic - if &lt;arg&gt; can be parsed a=
s an IPv4 or<br>IPv6 address, that particular protocol lookup will do &quot=
;the host route&quot;<br>and the other one will stick to &quot;the default =
route&quot;.<br><br>NOTE: as of this commit, there is no backend functional=
ity for IPv4, so<br>it will not actually print anything interesting.  This =
will be added in<br>further platform dependent commits.<br><br>v2: amend --=
help output<br>v3: uncrustify (#ifdef block too long, comments at #endif re=
quired now)<br><br>Change-Id: Ic438c583a782035ecb9b5ea65702a768ae2585f5<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sec=
tions/advanced-options.rst<br>M src/openvpn/options.c<br>2 files changed, 2=
0 insertions(+), 10 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/81/881/3</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections=
/advanced-options.rst b/doc/man-sections/advanced-options.rst</span><br><sp=
an>index d5a6b4f..e1115e4 100644</span><br><span>--- a/doc/man-sections/adv=
anced-options.rst</span><br><span>+++ b/doc/man-sections/advanced-options.r=
st</span><br><span>@@ -9,13 +9,17 @@</span><br><span>   ::</span><br><span>=
 </span><br><span>      --show-gateway</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     --show-gateway IPv4-target</span><br><span>      --=
show-gateway IPv6-target</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  For IPv4 it looks for a 0.0.0.0/0 route, or the sp=
ecified IPv4 address</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  if the target can be parsed as an IPv4 address.</span><br><span>   For I=
Pv6 this queries the route towards ::/128, or the specified IPv6</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  target address if passed as ar=
gument.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  For IPv4 on =
Linux, Windows, MacOS and BSD it looks for a 0.0.0.0/0 route.</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  If there are more specific routes=
, the result will not always be matching</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  the route of the IPv4 packets to the VPN gateway.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  target address if the =
argument is an IPv6 address.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Adding a=
 target is helpful for diagnostics to see if OpenVPN will do</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  the right thing if there are mor=
e specific IPv4/IPv6 routes to a</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  VPN server.</span><br><span> </span><br><span> </span><br><s=
pan> Advanced Expert Options</span><br><span>diff --git a/src/openvpn/optio=
ns.c b/src/openvpn/options.c</span><br><span>index 5a80e6b..218d8a6 100644<=
/span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openv=
pn/options.c</span><br><span>@@ -788,7 +788,7 @@</span><br><span>     &quot=
;\n&quot;</span><br><span>     &quot;General Standalone Options:\n&quot;</s=
pan><br><span> #ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &quot;--show-gateway : Show info about default gateway.\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--sh=
ow-gateway [address]: Show info about gateway [to v4/v6 address].\n&quot;</=
span><br><span> #endif</span><br><span> ;</span><br><span> </span><br><span=
>@@ -5858,20 +5858,26 @@</span><br><span>     {</span><br><span>         st=
ruct route_gateway_info rgi;</span><br><span>         struct route_ipv6_gat=
eway_info rgi6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct in6_addr remote =3D IN6ADDR_ANY_INIT;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        in_addr_t remote_ipv4 =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        struct in6_addr remote_=
ipv6 =3D IN6ADDR_ANY_INIT;</span><br><span>         openvpn_net_ctx_t net_c=
tx;</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><s=
pan>         if (p[1])</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            get_ipv6_addr(p[1], &amp;remote, NU=
LL, M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     /* try parsing the argument as a v4 or v6 address - if</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             * possible, the output=
 will show the exact route there, and</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             * &quot;the default route&quot; for the othe=
r protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
    */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
emote_ipv4 =3D get_ip_addr(p[1], M_WARN, NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            get_ipv6_addr(p[1], &amp;remote_ipv=
6, NULL, M_WARN);</span><br><span>         }</span><br><span>         net_c=
tx_init(NULL, &amp;net_ctx);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        get_default_gateway(&amp;rgi, 0, &amp;net_ctx);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        get_default_gateway_ipv6(&=
amp;rgi6, &amp;remote, &amp;net_ctx);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        get_default_gateway(&amp;rgi, remote_ipv4, &amp;n=
et_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        get=
_default_gateway_ipv6(&amp;rgi6, &amp;remote_ipv6, &amp;net_ctx);</span><br=
><span>         print_default_gateway(M_INFO, &amp;rgi, &amp;rgi6);</span><=
br><span>         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */<=
/span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if=
 defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL) */</span><br><span=
>     else if (streq(p[0], &quot;echo&quot;) || streq(p[0], &quot;parameter=
&quot;))</span><br><span>     {</span><br><span>         struct buffer stri=
ng =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/88=
1?usp=3Demail">change 881</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/881?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic438c583a782035ecb9b5ea6570=
2a768ae2585f5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 881 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--rLYSHNNhZuQ=--

