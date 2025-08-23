From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 23 Aug 2025 20:16:13 +0000
References: <gerrit.1755980171000.I1e623b4a836f7216750867243299c7e4d0bd32d0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f4c8b9f13b0f71a8d23e17e9ea8b245277129e35-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="en2ySXKUMq0="; charset=UTF-8
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

--en2ySXKUMq0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1156?usp=3Demail

to review the following change.


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
---
M doc/man-sections/script-options.rst
M src/openvpn/options.c
2 files changed, 22 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/1156/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--en2ySXKUMq0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1156?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Introduce env variables to communicate desired gateway redir=
ection to NM.<br><br>When run under Network Manager control, OpenVPN is not=
 allowed to<br>control routing.  Instead, NM uses the OpenVPN-set environme=
nt variables<br>(&quot;route_network_1&quot; etc) to set up routes as reque=
sted.  This method never<br>worked properly for &quot;redirect-gateway&quot=
;, as the information was not made<br>available in environment variables.<b=
r><br>Introduce new env vars:<br><br> route_redirect_gateway_ipv4<br> route=
_redirect_gateway_ipv6<br><br>to communicate desired state:<br><br> &lt;not=
 set&gt; =3D no gateway redirection desired<br> 1 =3D &quot;redirect-gatewa=
y for that protocol in question&quot;<br> 2 =3D &quot;include block-local t=
o redirect the local LAN as well&quot;<br><br>We intentionally do not expos=
e all the IPv4 flags (&quot;local&quot;, &quot;def1&quot;, ...)<br>as this =
is really internal OpenVPN historical cruft.<br><br>Change-Id: I1e623b4a836=
f7216750867243299c7e4d0bd32d0<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M doc/man-sections/script-options.rst<br>M src/openvpn/=
options.c<br>2 files changed, 22 insertions(+), 0 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/1156/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/scrip=
t-options.rst</span><br><span>index bd5ecd4..670cd33 100644</span><br><span=
>--- a/doc/man-sections/script-options.rst</span><br><span>+++ b/doc/man-se=
ctions/script-options.rst</span><br><span>@@ -874,6 +874,14 @@</span><br><s=
pan>     translations will be recorded rather than their names as denoted o=
n the</span><br><span>     command line or configuration file.</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`route_r=
edirect_gateway_ipv4`</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`route_redi=
rect_gateway_ipv6`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   Set to `1` if the corresponding default gateway should be redirected</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    into the tunnel, an=
d to `2` if also the local LAN segment should be</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    blocked (`block-local`).  Not set otherwis=
e.  Set prior to **--up** script</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    execution.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> :code:`script_context`</span><br><span>     Set t=
o &quot;init&quot; or &quot;restart&quot; prior to up/down script execution=
. For more</span><br><span>     information, see documentation for ``--up``=
.</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.=
c</span><br><span>index 0b16c5a..648d526 100644</span><br><span>--- a/src/o=
penvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><spa=
n>@@ -5720,6 +5720,8 @@</span><br><span>         {</span><br><span>        =
     options-&gt;routes_ipv6-&gt;flags =3D 0;</span><br><span>         }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        env_set_del(es=
, &quot;route_redirect_gateway_ipv4&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        env_set_del(es, &quot;route_redirect_gatewa=
y_ipv6&quot;);</span><br><span>     }</span><br><span>     else if (streq(p=
[0], &quot;dns&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><s=
pan>@@ -6039,6 +6041,8 @@</span><br><span>             {</span><br><span>  =
               options-&gt;routes_ipv6-&gt;flags =3D 0;</span><br><span>   =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    env_set_del(es, &quot;route_redirect_gateway_ipv4&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            env_set_del(es, &quot=
;route_redirect_gateway_ipv6&quot;);</span><br><span>             *update_o=
ptions_found |=3D OPT_P_U_REDIR_GATEWAY;</span><br><span>         }</span><=
br><span>     }</span><br><span>@@ -7661,6 +7665,16 @@</span><br><span>    =
             goto err;</span><br><span>             }</span><br><span>     =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (op=
tions-&gt;routes-&gt;flags &amp; RG_REROUTE_GW)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            setenv_int(es, &quot;route_redirect_gateway_i=
pv4&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              options-&gt;routes-&gt;flags &amp; RG_BLOCK_LOCAL ? 2 : 1);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;routes_=
ipv6 &amp;&amp; (options-&gt;routes_ipv6-&gt;flags &amp; RG_REROUTE_GW))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            setenv_int(es, &quot=
;route_redirect_gateway_ipv6&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                       options-&gt;routes-&gt;flags &amp; R=
G_BLOCK_LOCAL ? 2 : 1);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span> #ifdef _WIN32</span><br><span>         /* we=
 need this here to handle pushed --redirect-gateway */</span><br><span>    =
     remap_redirect_gateway_flags(options);</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1156?u=
sp=3Demail">change 1156</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1156?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e623b4a836f721675086724329=
9c7e4d0bd32d0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1156 </div>
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


--en2ySXKUMq0=--

