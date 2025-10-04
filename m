From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 4 Oct 2025 16:05:56 +0000
In-Reply-To: <gerrit.1758727613000.Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9@...2715...>
References: <gerrit.1758727613000.Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <680bcfde297e544fa0c00d50e351203efe77a05d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YlfU2tfW17Y="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: Fix a
 unused-but-set-variable warning on OpenBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YlfU2tfW17Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1214?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


Change subject: route: Fix a unused-but-set-variable warning on OpenBSD
......................................................................

route: Fix a unused-but-set-variable warning on OpenBSD

So we could enable -Werror for OpenBSD builds.

Change-Id: Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1214
Message-Id: <20251004141935.17815-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59242246/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/1214/2

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 156a99e..05a0c8f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2221,6 +2221,7 @@
         device =3D r6->iface;
         gateway_needed =3D true;
     }
+    (void)device; /* unused on some platforms */

     /* if we used a gateway on "add route", we also need to specify it on
      * delete, otherwise some OSes will refuse to delete the route

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1214?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9
Gerrit-Change-Number: 1214
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YlfU2tfW17Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1214?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by MaxF</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">route: Fix a unused-but-set-variable=
 warning on OpenBSD<br><br>So we could enable -Werror for OpenBSD builds.<b=
r><br>Change-Id: Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: MaxF &lt;max@...1665...=
606...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1214<br>Me=
ssage-Id: &lt;20251004141935.17815-1-gert@...1296...&gt;<br>URL: https://so=
urceforge.net/p/openvpn/mailman/message/59242246/<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>1 file cha=
nged, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/14/1214/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 156a9=
9e..05a0c8f 100644</span><br><span>--- a/src/openvpn/route.c</span><br><spa=
n>+++ b/src/openvpn/route.c</span><br><span>@@ -2221,6 +2221,7 @@</span><br=
><span>         device =3D r6-&gt;iface;</span><br><span>         gateway_n=
eeded =3D true;</span><br><span>     }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    (void)device; /* unused on some platforms */</span><=
br><span> </span><br><span>     /* if we used a gateway on &quot;add route&=
quot;, we also need to specify it on</span><br><span>      * delete, otherw=
ise some OSes will refuse to delete the route</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1214=
?usp=3Demail">change 1214</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1214?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic971604beb1320d7b9d6121cd8e=
8519ccc1a7eb9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1214 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--YlfU2tfW17Y=--

