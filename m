From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 21 Apr 2026 20:35:08 +0000
References: <gerrit.1776803704000.I9b1f4fd06c8a02d3f51b6a3bdea2f92191669660@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6c110bb90f975c364f9a7f8b5be81de56d0e4a6f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JbpMYy4wRz4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JbpMYy4wRz4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1636?usp=3Demail

to review the following change.


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
---
M src/openvpn/dco_linux.c
1 file changed, 17 insertions(+), 17 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1636/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I9b1f4fd06c8a02d3f51b6a3bdea2f92191669660
Gerrit-Change-Number: 1636
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--JbpMYy4wRz4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1636?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco-linux: enforce ifindex only for DEL_PEE=
R notifications<br><br>The unconditional ifindex check introduced by commit=
 e78a8af2f5ce<br>rejects legitimate kernel replies, specifically peer stats=
 responses,<br>because those messages do not carry OVPN_ATTR_IFINDEX.<br><b=
r>Move the check into ovpn_handle_del_peer() so it applies only to<br>spont=
aneous DEL_PEER notifications from the kernel. This keeps<br>response handl=
ing working while still filtering foreign-instance<br>notifications.<br><br=
>Fixes: e78a8af2f5ce (&quot;dco: backport immediate notification processing=
 on Linux and FreeBSD&quot;)<br>Github: closes OpenVPN/openvpn#1020<br>Chan=
ge-Id: I9b1f4fd06c8a02d3f51b6a3bdea2f92191669660<br>Signed-off-by: Ralf Lic=
i &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>1 file cha=
nged, 17 insertions(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1636/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>=
index 8ce7026..1df56cf 100644</span><br><span>--- a/src/openvpn/dco_linux.c=
</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -857,6 +8=
57,23 @@</span><br><span> static int</span><br><span> ovpn_handle_del_peer(=
dco_context_t *dco, struct nlattr *attrs[])</span><br><span> {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* we must know which interf=
ace this message is referring to in order to</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * avoid mixing messages for other instances</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_ATTR_IFINDEX]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dc=
o: Received message without ifindex&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return NL_STOP;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (ifindex !=3D dco-&gt;ifindex=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;o=
vpn-dco: ignoring message for foreign ifindex %d&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            ifindex);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return NL_SKIP;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     if (!attrs[OVPN_ATTR_DEL_=
PEER])</span><br><span>     {</span><br><span>         msg(D_DCO, &quot;ovp=
n-dco: no attributes in OVPN_DEL_PEER message&quot;);</span><br><span>@@ -9=
30,23 +947,6 @@</span><br><span>         return NL_STOP;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* we must know which interface this message is referring to in order =
to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * avoid mixing=
 messages for other instances</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (!attrs[OVPN_ATTR_IFINDEX])</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(D_DCO, &quot;ovpn-dco: Received message without ifindex&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return NL_STOP;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex !=3D d=
co-&gt;ifindex)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBU=
G, &quot;ovpn-dco: ignoring message for foreign ifindex %d&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            ifindex);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* based on the messa=
ge type, we parse the subobject contained in the</span><br><span>      * me=
ssage, that stores the type-specific attributes.</span><br><span>      *</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1636?usp=3Demail">change 1636</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1636?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b1f4fd06c8a02d3f51b6a3bdea=
2f92191669660 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1636 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--JbpMYy4wRz4=--

