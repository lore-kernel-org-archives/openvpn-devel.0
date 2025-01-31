From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 31 Jan 2025 08:40:39 +0000
In-Reply-To: <gerrit.1738260795000.I1db72d7dca648a8ea4ec65d173290a819971305c@...2715...>
References: <gerrit.1738260795000.I1db72d7dca648a8ea4ec65d173290a819971305c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7a9b2e1057cd662add7fa61035051f834a70b198-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0RCXYSiABd4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 get_default_gateway(): implement platform support for Linux/SITNL
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

--0RCXYSiABd4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/883?usp=3Demail

to look at the new patch set (#2).


Change subject: get_default_gateway(): implement platform support for Linux=
/SITNL
......................................................................

get_default_gateway(): implement platform support for Linux/SITNL

This adds Linux/SITNL platform functionality to the framework started by
commit 9df51cf56 and commit 0fcfc8381f.

v2: make comment reflect reality

Change-Id: I1db72d7dca648a8ea4ec65d173290a819971305c
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/883/2

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3501e35..dd37fb9 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3332,8 +3332,8 @@
     CLEAR(*rgi);
     CLEAR(best_name);

-    /* get default gateway IP addr */
-    if (net_route_v4_best_gw(ctx, NULL, &rgi->gateway.addr, best_name) =3D=
=3D 0)
+    /* find best route to 'dest', get gateway IP addr + interface */
+    if (net_route_v4_best_gw(ctx, &dest, &rgi->gateway.addr, best_name) =
=3D=3D 0)
     {
         rgi->flags |=3D RGI_ADDR_DEFINED;
         if (!rgi->gateway.addr && best_name[0])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/883?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1db72d7dca648a8ea4ec65d173290a819971305c
Gerrit-Change-Number: 883
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--0RCXYSiABd4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/883?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">get_default_gateway(): implement platform support for Linux/SITNL<br><br>=
This adds Linux/SITNL platform functionality to the framework started by<br=
>commit 9df51cf56 and commit 0fcfc8381f.<br><br>v2: make comment reflect re=
ality<br><br>Change-Id: I1db72d7dca648a8ea4ec65d173290a819971305c<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/route=
.c<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/83/883/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 3501e=
35..dd37fb9 100644</span><br><span>--- a/src/openvpn/route.c</span><br><spa=
n>+++ b/src/openvpn/route.c</span><br><span>@@ -3332,8 +3332,8 @@</span><br=
><span>     CLEAR(*rgi);</span><br><span>     CLEAR(best_name);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* get defa=
ult gateway IP addr */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (net_route_v4_best_gw(ctx, NULL, &amp;rgi-&gt;gateway.addr, best_na=
me) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 find best route to &#39;dest&#39;, get gateway IP addr + interface */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (net_route_v4_bes=
t_gw(ctx, &amp;dest, &amp;rgi-&gt;gateway.addr, best_name) =3D=3D 0)</span>=
<br><span>     {</span><br><span>         rgi-&gt;flags |=3D RGI_ADDR_DEFIN=
ED;</span><br><span>         if (!rgi-&gt;gateway.addr &amp;&amp; best_name=
[0])</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/883?usp=3Demail">change 883</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/883?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1db72d7dca648a8ea4ec65d1732=
90a819971305c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 883 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--0RCXYSiABd4=--

