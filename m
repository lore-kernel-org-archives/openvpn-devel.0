From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Jan 2025 18:13:20 +0000
References: <gerrit.1738260795000.I1db72d7dca648a8ea4ec65d173290a819971305c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b6d77eb7a6a30c52e59dd86b0e7c23528728b186-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OcxkluBt6mU="; charset=UTF-8
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

--OcxkluBt6mU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/883?usp=3Demail

to review the following change.


Change subject: get_default_gateway(): implement platform support for Linux=
/SITNL
......................................................................

get_default_gateway(): implement platform support for Linux/SITNL

This adds Linux/SITNL platform functionality to the framework started by
commit 9df51cf56 and commit 0fcfc8381f.

Change-Id: I1db72d7dca648a8ea4ec65d173290a819971305c
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/883/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3501e35..3605671 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3333,7 +3333,7 @@
     CLEAR(best_name);

     /* get default gateway IP addr */
-    if (net_route_v4_best_gw(ctx, NULL, &rgi->gateway.addr, best_name) =3D=
=3D 0)
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
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--OcxkluBt6mU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/883?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">get_default_gateway(): implement platform support for Linux/S=
ITNL<br><br>This adds Linux/SITNL platform functionality to the framework s=
tarted by<br>commit 9df51cf56 and commit 0fcfc8381f.<br><br>Change-Id: I1db=
72d7dca648a8ea4ec65d173290a819971305c<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>1 file changed, 1 inse=
rtion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/83/883/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/route.c b/src=
/openvpn/route.c</span><br><span>index 3501e35..3605671 100644</span><br><s=
pan>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</sp=
an><br><span>@@ -3333,7 +3333,7 @@</span><br><span>     CLEAR(best_name);</=
span><br><span> </span><br><span>     /* get default gateway IP addr */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (net_route_v4_best=
_gw(ctx, NULL, &amp;rgi-&gt;gateway.addr, best_name) =3D=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (net_route_v4_best_gw(ctx=
, &amp;dest, &amp;rgi-&gt;gateway.addr, best_name) =3D=3D 0)</span><br><spa=
n>     {</span><br><span>         rgi-&gt;flags |=3D RGI_ADDR_DEFINED;</spa=
n><br><span>         if (!rgi-&gt;gateway.addr &amp;&amp; best_name[0])</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/883?usp=3Demail">change 883</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/883?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1db72d7dca648a8ea4ec65d1732=
90a819971305c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 883 </div>
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


--OcxkluBt6mU=--

