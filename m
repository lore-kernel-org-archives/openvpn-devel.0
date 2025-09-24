From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 15:26:55 +0000
References: <gerrit.1758727613000.Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e864d0cb021f89e7a7a66f7a421070dbb50b4ca1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zPBKj9T2P7Y="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zPBKj9T2P7Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1214?usp=3Demail

to review the following change.


Change subject: route: Fix a unused-but-set-variable warning on OpenBSD
......................................................................

route: Fix a unused-but-set-variable warning on OpenBSD

So we could enable -Werror for OpenBSD builds.

Change-Id: Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/route.c
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/1214/1

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
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9
Gerrit-Change-Number: 1214
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--zPBKj9T2P7Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1214?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">route: Fix a unused-but-set-variable warning on OpenBSD<br><=
br>So we could enable -Werror for OpenBSD builds.<br><br>Change-Id: Ic97160=
4beb1320d7b9d6121cd8e8519ccc1a7eb9<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>---<br>M src/openvpn/route.c<br>1 file changed, 1 i=
nsertion(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/14/1214/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/route.c =
b/src/openvpn/route.c</span><br><span>index 156a99e..05a0c8f 100644</span><=
br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.=
c</span><br><span>@@ -2221,6 +2221,7 @@</span><br><span>         device =3D=
 r6-&gt;iface;</span><br><span>         gateway_needed =3D true;</span><br>=
<span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (vo=
id)device; /* unused on some platforms */</span><br><span> </span><br><span=
>     /* if we used a gateway on &quot;add route&quot;, we also need to spe=
cify it on</span><br><span>      * delete, otherwise some OSes will refuse =
to delete the route</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1214?usp=3Demail">change 1214<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1214?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic971604beb1320d7b9d6121cd8e=
8519ccc1a7eb9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1214 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--zPBKj9T2P7Y=--

