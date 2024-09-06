From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 6 Sep 2024 15:44:48 +0000
References: <gerrit.1725637486000.I2f55eabd0e950edc3fbcd08b257257cf9ed9c8d8@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f9f0326682ea7ae7af91dce81f369af384d58051-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HN8je6Met2Y="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Minor fix on
 ifconfig parameter warning
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

--HN8je6Met2Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/736?usp=3Demail

to review the following change.


Change subject: Minor fix on ifconfig parameter warning
......................................................................

Minor fix on ifconfig parameter warning

Handle the case of tun device and subnet topology in
ifconfig_sanity_check(). Emit a warning if the second parameter of
ifconfig doesn't look like a netmask.

Change-Id: I2f55eabd0e950edc3fbcd08b257257cf9ed9c8d8
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/tun.c
1 file changed, 5 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/736/1

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ce3d882..875f558 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -510,20 +510,21 @@
 {
     struct gc_arena gc =3D gc_new();
     const bool looks_like_netmask =3D ((addr & 0xFF000000) =3D=3D 0xFF0000=
00);
-    if (tun)
+    if (tun && (topology =3D=3D TOP_NET30 || topology =3D=3D TOP_P2P))
     {
-        if (looks_like_netmask && (topology =3D=3D TOP_NET30 || topology =
=3D=3D TOP_P2P))
+        if (looks_like_netmask)
         {
             msg(M_WARN, "WARNING: Since you are using --dev tun with a poi=
nt-to-point topology, the second argument to --ifconfig must be an IP addre=
ss.  You are using something (%s) that looks more like a netmask. %s",
                 print_in_addr_t(addr, 0, &gc),
                 ifconfig_warn_how_to_silence);
         }
     }
-    else /* tap */
+    else /* tap or tun with subnet topology */
     {
         if (!looks_like_netmask)
         {
-            msg(M_WARN, "WARNING: Since you are using --dev tap, the secon=
d argument to --ifconfig must be a netmask, for example something like 255.=
255.255.0. %s",
+            msg(M_WARN, "WARNING: Since you are using --dev %s, the second=
 argument to --ifconfig must be a netmask, for example something like 255.2=
55.255.0. %s",
+                tun ? "tun with a subnet topology" : "tap",
                 ifconfig_warn_how_to_silence);
         }
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/736?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2f55eabd0e950edc3fbcd08b257257cf9ed9c8d8
Gerrit-Change-Number: 736
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--HN8je6Met2Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/736?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Minor fix on ifconfig parameter warning<br><br>Handle the cas=
e of tun device and subnet topology in<br>ifconfig_sanity_check(). Emit a w=
arning if the second parameter of<br>ifconfig doesn&#39;t look like a netma=
sk.<br><br>Change-Id: I2f55eabd0e950edc3fbcd08b257257cf9ed9c8d8<br>Signed-o=
ff-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/tun.c<br>1=
 file changed, 5 insertions(+), 4 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/36/736/1</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index ce3d882..875f558 =
100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/op=
envpn/tun.c</span><br><span>@@ -510,20 +510,21 @@</span><br><span> {</span>=
<br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     const =
bool looks_like_netmask =3D ((addr &amp; 0xFF000000) =3D=3D 0xFF000000);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tun)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (tun &amp;&amp; (topolog=
y =3D=3D TOP_NET30 || topology =3D=3D TOP_P2P))</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (looks_like_net=
mask &amp;&amp; (topology =3D=3D TOP_NET30 || topology =3D=3D TOP_P2P))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (looks_like_=
netmask)</span><br><span>         {</span><br><span>             msg(M_WARN=
, &quot;WARNING: Since you are using --dev tun with a point-to-point topolo=
gy, the second argument to --ifconfig must be an IP address.  You are using=
 something (%s) that looks more like a netmask. %s&quot;,</span><br><span> =
                print_in_addr_t(addr, 0, &amp;gc),</span><br><span>        =
         ifconfig_warn_how_to_silence);</span><br><span>         }</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e /* tap */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 /* tap or tun with subnet topology */</span><br><span>     {</span><br><sp=
an>         if (!looks_like_netmask)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WAR=
NING: Since you are using --dev tap, the second argument to --ifconfig must=
 be a netmask, for example something like 255.255.255.0. %s&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quo=
t;WARNING: Since you are using --dev %s, the second argument to --ifconfig =
must be a netmask, for example something like 255.255.255.0. %s&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                tun ? &q=
uot;tun with a subnet topology&quot; : &quot;tap&quot;,</span><br><span>   =
              ifconfig_warn_how_to_silence);</span><br><span>         }</sp=
an><br><span>     }</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/736?usp=3Demail">change 736</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/736?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2f55eabd0e950edc3fbcd08b257=
257cf9ed9c8d8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 736 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
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


--HN8je6Met2Y=--

