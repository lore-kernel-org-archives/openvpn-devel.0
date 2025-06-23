From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 23 Jun 2025 13:12:38 +0000
References: <gerrit.1750684356000.I4fa2d578f9c0a5a8aa24ca1d396102ef2ed9a425@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <36119a5eecabf4a2970145c53d64bf470f810f06-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AF1xgNONUSw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco linux: avoid
 redefining ovpn enums
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

--AF1xgNONUSw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1064?usp=3Demail

to review the following change.


Change subject: dco linux: avoid redefining ovpn enums
......................................................................

dco linux: avoid redefining ovpn enums

Starting with Linux kernel version 6.16, a couple of ovpn-related enum
definitions were introduced in the `include/uapi/linux/if_link.h`
header. Redefining them in openvpn when they are already present in the
system headers can lead to conflicts or build issues.

This commit ensures that enum redefinitions are avoided by conditionally
using the existing definitions from the system header when available.

Change-Id: I4fa2d578f9c0a5a8aa24ca1d396102ef2ed9a425
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco_linux.h
1 file changed, 6 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1064/1

diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 273a6ad..f6e2d13 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -40,6 +40,8 @@

 /* OVPN section */

+#ifndef IFLA_OVPN_MAX
+
 enum ovpn_mode {
     OVPN_MODE_P2P,
     OVPN_MODE_MP,
@@ -50,9 +52,12 @@
     IFLA_OVPN_MODE,

     __IFLA_OVPN_AFTER_LAST,
-    IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,
 };
=20
+#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)
+
+#endif /* ifndef IFLA_OVPN_MAX */
+
 typedef struct
 {
     struct nl_sock *nl_sock;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1064?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4fa2d578f9c0a5a8aa24ca1d396102ef2ed9a425
Gerrit-Change-Number: 1064
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--AF1xgNONUSw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1064?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco linux: avoid redefining ovpn enums<br><br>Starting with =
Linux kernel version 6.16, a couple of ovpn-related enum<br>definitions wer=
e introduced in the `include/uapi/linux/if_link.h`<br>header. Redefining th=
em in openvpn when they are already present in the<br>system headers can le=
ad to conflicts or build issues.<br><br>This commit ensures that enum redef=
initions are avoided by conditionally<br>using the existing definitions fro=
m the system header when available.<br><br>Change-Id: I4fa2d578f9c0a5a8aa24=
ca1d396102ef2ed9a425<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br=
>---<br>M src/openvpn/dco_linux.h<br>1 file changed, 6 insertions(+), 1 del=
etion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/64/1064/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux.h b/src/openvpn/d=
co_linux.h</span><br><span>index 273a6ad..f6e2d13 100644</span><br><span>--=
- a/src/openvpn/dco_linux.h</span><br><span>+++ b/src/openvpn/dco_linux.h</=
span><br><span>@@ -40,6 +40,8 @@</span><br><span> </span><br><span> /* OVPN=
 section */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifndef IFLA_OVPN_MAX</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> enum ovpn_mode {</span><br><span>     OVPN_MO=
DE_P2P,</span><br><span>     OVPN_MODE_MP,</span><br><span>@@ -50,9 +52,12 =
@@</span><br><span>     IFLA_OVPN_MODE,</span><br><span> </span><br><span> =
    __IFLA_OVPN_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,</span><br><span> };=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif /* ifndef IFLA_OVPN_MAX */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> typedef struct</span><br><span> {</span=
><br><span>     struct nl_sock *nl_sock;</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1064?usp=
=3Demail">change 1064</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1064?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4fa2d578f9c0a5a8aa24ca1d396=
102ef2ed9a425 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1064 </div>
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


--AF1xgNONUSw=--

