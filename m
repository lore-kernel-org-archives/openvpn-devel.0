From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 22 Apr 2026 07:04:59 +0000
In-Reply-To: <gerrit.1776803704000.I9b1f4fd06c8a02d3f51b6a3bdea2f92191669660@...2715...>
References: <gerrit.1776803704000.I9b1f4fd06c8a02d3f51b6a3bdea2f92191669660@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <2ddecfe4811f592fc229523e11ff954ee2d7931d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TOb65ISqMD8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: dco-linux:
 enforce ifindex only for DEL_PEER notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TOb65ISqMD8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/1636?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dco-linux: enforce ifindex only for DEL_PEER notifications
......................................................................

dco-linux: enforce ifindex only for DEL_PEER notifications

The unconditional ifindex check introduced by commit e78a8af2f5ce
rejects legitimate kernel replies, specifically peer stats responses,
because those messages do not carry OVPN_ATTR_IFINDEX.

Move the check into ovpn_handle_del_peer() so it applies only to
spontaneous DEL_PEER notifications from the kernel. This keeps
response handling working while still filtering foreign-instance
notifications.

Fixes: e78a8af2f5ce ("dco: backport immediate notification processing on Li=
nux and FreeBSD")
Github: closes OpenVPN/openvpn#1020
Change-Id: I9b1f4fd06c8a02d3f51b6a3bdea2f92191669660
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1636
Message-Id: <20260422055636.20691-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
721.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
1 file changed, 17 insertions(+), 17 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1636/2

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 8ce7026..1df56cf 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -857,6 +857,23 @@
 static int
 ovpn_handle_del_peer(dco_context_t *dco, struct nlattr *attrs[])
 {
+    /* we must know which interface this message is referring to in order =
to
+     * avoid mixing messages for other instances
+     */
+    if (!attrs[OVPN_ATTR_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return NL_STOP;
+    }
+
+    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
+    if (ifindex !=3D dco->ifindex)
+    {
+        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex %=
d",
+            ifindex);
+        return NL_SKIP;
+    }
+
     if (!attrs[OVPN_ATTR_DEL_PEER])
     {
         msg(D_DCO, "ovpn-dco: no attributes in OVPN_DEL_PEER message");
@@ -930,23 +947,6 @@
         return NL_STOP;
     }

-    /* we must know which interface this message is referring to in order =
to
-     * avoid mixing messages for other instances
-     */
-    if (!attrs[OVPN_ATTR_IFINDEX])
-    {
-        msg(D_DCO, "ovpn-dco: Received message without ifindex");
-        return NL_STOP;
-    }
-
-    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
-    if (ifindex !=3D dco->ifindex)
-    {
-        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex %=
d",
-            ifindex);
-        return NL_SKIP;
-    }
-
     /* based on the message type, we parse the subobject contained in the
      * message, that stores the type-specific attributes.
      *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1636?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I9b1f4fd06c8a02d3f51b6a3bdea2f92191669660
Gerrit-Change-Number: 1636
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TOb65ISqMD8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by ralf_lici.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1636?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">dco-linux: enforce ifindex only for=
 DEL_PEER notifications<br><br>The unconditional ifindex check introduced b=
y commit e78a8af2f5ce<br>rejects legitimate kernel replies, specifically pe=
er stats responses,<br>because those messages do not carry OVPN_ATTR_IFINDE=
X.<br><br>Move the check into ovpn_handle_del_peer() so it applies only to<=
br>spontaneous DEL_PEER notifications from the kernel. This keeps<br>respon=
se handling working while still filtering foreign-instance<br>notifications=
.<br><br>Fixes: e78a8af2f5ce (&quot;dco: backport immediate notification pr=
ocessing on Linux and FreeBSD&quot;)<br>Github: closes OpenVPN/openvpn#1020=
<br>Change-Id: I9b1f4fd06c8a02d3f51b6a3bdea2f92191669660<br>Signed-off-by: =
Ralf Lici &lt;ralf@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1636<br>Mess=
age-Id: &lt;20260422055636.20691-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36721.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_=
linux.c<br>1 file changed, 17 insertions(+), 17 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/3=
6/1636/2</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_lin=
ux.c</span><br><span>index 8ce7026..1df56cf 100644</span><br><span>--- a/sr=
c/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><=
br><span>@@ -857,6 +857,23 @@</span><br><span> static int</span><br><span> =
ovpn_handle_del_peer(dco_context_t *dco, struct nlattr *attrs[])</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we m=
ust know which interface this message is referring to in order to</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * avoid mixing messages =
for other instances</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!att=
rs[OVPN_ATTR_IFINDEX])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(D_DCO, &quot;ovpn-dco: Received message without ifindex&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return NL_STOP;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_IFINDE=
X]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ifindex=
 !=3D dco-&gt;ifindex)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(D_DCO_DEBUG, &quot;ovpn-dco: ignoring message for foreign ifindex %d&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ifinde=
x);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return N=
L_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (=
!attrs[OVPN_ATTR_DEL_PEER])</span><br><span>     {</span><br><span>        =
 msg(D_DCO, &quot;ovpn-dco: no attributes in OVPN_DEL_PEER message&quot;);<=
/span><br><span>@@ -930,23 +947,6 @@</span><br><span>         return NL_STO=
P;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* we must know which interface this message is r=
eferring to in order to</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * avoid mixing messages for other instances</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (!attrs[OVPN_ATTR_IFINDEX])</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: Received message without ifi=
ndex&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn NL_STOP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint32_t ifindex =3D nla_get_u32(attrs[=
OVPN_ATTR_IFINDEX]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (ifindex !=3D dco-&gt;ifindex)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msg(D_DCO_DEBUG, &quot;ovpn-dco: ignoring message for foreign ifinde=
x %d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  ifindex);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*=
 based on the message type, we parse the subobject contained in the</span><=
br><span>      * message, that stores the type-specific attributes.</span><=
br><span>      *</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1636?usp=3Demail">change 1636</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1636?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b1f4fd06c8a02d3f51b6a3bdea=
2f92191669660 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1636 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--TOb65ISqMD8=--

