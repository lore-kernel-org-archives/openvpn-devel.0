From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 27 Aug 2025 19:03:20 +0000
In-Reply-To: <gerrit.1755980171000.I1e623b4a836f7216750867243299c7e4d0bd32d0@...2715...>
References: <gerrit.1755980171000.I1e623b4a836f7216750867243299c7e4d0bd32d0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b061fd3a937f43ff63995bb17e8dd9e0eb23af33-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hur27uXR1WQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce env
 variables to communicate desired gateway redirection to...
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

--hur27uXR1WQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1156?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Introduce env variables to communicate desired gateway redi=
rection to NM.
......................................................................

Introduce env variables to communicate desired gateway redirection to NM.

When run under Network Manager control, OpenVPN is not allowed to
control routing.  Instead, NM uses the OpenVPN-set environment variables
("route_network_1" etc) to set up routes as requested.  This method never
worked properly for "redirect-gateway", as the information was not made
available in environment variables.

Introduce new env vars:

 route_redirect_gateway_ipv4
 route_redirect_gateway_ipv6

to communicate desired state:

 <not set> =3D no gateway redirection desired
 1 =3D "redirect-gateway for that protocol in question"
 2 =3D "include block-local to redirect the local LAN as well"

We intentionally do not expose all the IPv4 flags ("local", "def1", ...)
as this is really internal OpenVPN historical cruft.

Change-Id: I1e623b4a836f7216750867243299c7e4d0bd32d0
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250826184046.21434-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
686.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/script-options.rst
M src/openvpn/options.c
2 files changed, 22 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/1156/2

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-=
options.rst
index bd5ecd4..670cd33 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -874,6 +874,14 @@
     translations will be recorded rather than their names as denoted on the
     command line or configuration file.

+:code:`route_redirect_gateway_ipv4`
+
+:code:`route_redirect_gateway_ipv6`
+    Set to `1` if the corresponding default gateway should be redirected
+    into the tunnel, and to `2` if also the local LAN segment should be
+    blocked (`block-local`).  Not set otherwise.  Set prior to **--up** sc=
ript
+    execution.
+
 :code:`script_context`
     Set to "init" or "restart" prior to up/down script execution. For more
     information, see documentation for ``--up``.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0b16c5a..648d526 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5720,6 +5720,8 @@
         {
             options->routes_ipv6->flags =3D 0;
         }
+        env_set_del(es, "route_redirect_gateway_ipv4");
+        env_set_del(es, "route_redirect_gateway_ipv6");
     }
     else if (streq(p[0], "dns") && !p[1])
     {
@@ -6039,6 +6041,8 @@
             {
                 options->routes_ipv6->flags =3D 0;
             }
+            env_set_del(es, "route_redirect_gateway_ipv4");
+            env_set_del(es, "route_redirect_gateway_ipv6");
             *update_options_found |=3D OPT_P_U_REDIR_GATEWAY;
         }
     }
@@ -7661,6 +7665,16 @@
                 goto err;
             }
         }
+        if (options->routes->flags & RG_REROUTE_GW)
+        {
+            setenv_int(es, "route_redirect_gateway_ipv4",
+                       options->routes->flags & RG_BLOCK_LOCAL ? 2 : 1);
+        }
+        if (options->routes_ipv6 && (options->routes_ipv6->flags & RG_RERO=
UTE_GW))
+        {
+            setenv_int(es, "route_redirect_gateway_ipv6",
+                       options->routes->flags & RG_BLOCK_LOCAL ? 2 : 1);
+        }
 #ifdef _WIN32
         /* we need this here to handle pushed --redirect-gateway */
         remap_redirect_gateway_flags(options);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1156?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1e623b4a836f7216750867243299c7e4d0bd32d0
Gerrit-Change-Number: 1156
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--hur27uXR1WQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1156?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Introduce env variables to communicate desired g=
ateway redirection to NM.<br><br>When run under Network Manager control, Op=
enVPN is not allowed to<br>control routing.  Instead, NM uses the OpenVPN-s=
et environment variables<br>(&quot;route_network_1&quot; etc) to set up rou=
tes as requested.  This method never<br>worked properly for &quot;redirect-=
gateway&quot;, as the information was not made<br>available in environment =
variables.<br><br>Introduce new env vars:<br><br> route_redirect_gateway_ip=
v4<br> route_redirect_gateway_ipv6<br><br>to communicate desired state:<br>=
<br> &lt;not set&gt; =3D no gateway redirection desired<br> 1 =3D &quot;red=
irect-gateway for that protocol in question&quot;<br> 2 =3D &quot;include b=
lock-local to redirect the local LAN as well&quot;<br><br>We intentionally =
do not expose all the IPv4 flags (&quot;local&quot;, &quot;def1&quot;, ...)=
<br>as this is really internal OpenVPN historical cruft.<br><br>Change-Id: =
I1e623b4a836f7216750867243299c7e4d0bd32d0<br>Signed-off-by: Gert Doering &l=
t;gert@...1296...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...=
&gt;<br>Message-Id: &lt;20250826184046.21434-1-gert@...1296...&gt;<br>URL: =
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32686.h=
tml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/=
man-sections/script-options.rst<br>M src/openvpn/options.c<br>2 files chang=
ed, 22 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/56/1156/2</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sec=
tions/script-options.rst b/doc/man-sections/script-options.rst</span><br><s=
pan>index bd5ecd4..670cd33 100644</span><br><span>--- a/doc/man-sections/sc=
ript-options.rst</span><br><span>+++ b/doc/man-sections/script-options.rst<=
/span><br><span>@@ -874,6 +874,14 @@</span><br><span>     translations will=
 be recorded rather than their names as denoted on the</span><br><span>    =
 command line or configuration file.</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+:code:`route_redirect_gateway_ipv4`</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+:code:`route_redirect_gateway_ipv6`</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    Set to `1` if the cor=
responding default gateway should be redirected</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    into the tunnel, and to `2` if also the loc=
al LAN segment should be</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    blocked (`block-local`).  Not set otherwise.  Set prior to **--up*=
* script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    executi=
on.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> :code:`script_context`</span><br><span>     Set to &quot;init&quot; or &q=
uot;restart&quot; prior to up/down script execution. For more</span><br><sp=
an>     information, see documentation for ``--up``.</span><br><span>diff -=
-git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index =
0b16c5a..648d526 100644</span><br><span>--- a/src/openvpn/options.c</span><=
br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -5720,6 +5720,8 @@<=
/span><br><span>         {</span><br><span>             options-&gt;routes_=
ipv6-&gt;flags =3D 0;</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        env_set_del(es, &quot;route_redirect_g=
ateway_ipv4&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        env_set_del(es, &quot;route_redirect_gateway_ipv6&quot;);</span><br=
><span>     }</span><br><span>     else if (streq(p[0], &quot;dns&quot;) &a=
mp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -6039,6 +6041,8 @=
@</span><br><span>             {</span><br><span>                 options-&=
gt;routes_ipv6-&gt;flags =3D 0;</span><br><span>             }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            env_set_del(es, &quo=
t;route_redirect_gateway_ipv4&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            env_set_del(es, &quot;route_redirect_gateway_=
ipv6&quot;);</span><br><span>             *update_options_found |=3D OPT_P_=
U_REDIR_GATEWAY;</span><br><span>         }</span><br><span>     }</span><b=
r><span>@@ -7661,6 +7665,16 @@</span><br><span>                 goto err;</=
span><br><span>             }</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;routes-&gt;fla=
gs &amp; RG_REROUTE_GW)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      setenv_int(es, &quot;route_redirect_gateway_ipv4&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                       options-&g=
t;routes-&gt;flags &amp; RG_BLOCK_LOCAL ? 2 : 1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (options-&gt;routes_ipv6 &amp;&amp; (options=
-&gt;routes_ipv6-&gt;flags &amp; RG_REROUTE_GW))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            setenv_int(es, &quot;route_redirect_gateway_=
ipv6&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
               options-&gt;routes-&gt;flags &amp; RG_BLOCK_LOCAL ? 2 : 1);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span> #ifdef _WIN32</span><br><span>         /* we need this here to handl=
e pushed --redirect-gateway */</span><br><span>         remap_redirect_gate=
way_flags(options);</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1156?usp=3Demail">change 1156<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1156?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e623b4a836f721675086724329=
9c7e4d0bd32d0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1156 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--hur27uXR1WQ=--

