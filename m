From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 23 Jun 2025 14:34:28 +0000
In-Reply-To: <gerrit.1750684356000.I4fa2d578f9c0a5a8aa24ca1d396102ef2ed9a425@...2715...>
References: <gerrit.1750684356000.I4fa2d578f9c0a5a8aa24ca1d396102ef2ed9a425@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...,
 antonio@...2726...
Message-ID: <c5fbf1062d1acd61afcaf7057301d492d0039470-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KnzEBaltbQA="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KnzEBaltbQA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
64?usp=3Demail )

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
Message-Id: <20250623140748.13960-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
961.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.h
1 file changed, 7 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 273a6ad..4e441ec 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -40,6 +40,8 @@

 /* OVPN section */

+#ifndef IFLA_OVPN_MAX
+
 enum ovpn_mode {
     OVPN_MODE_P2P,
     OVPN_MODE_MP,
@@ -49,10 +51,13 @@
     IFLA_OVPN_UNSPEC =3D 0,
     IFLA_OVPN_MODE,

-    __IFLA_OVPN_AFTER_LAST,
-    IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,
+    __IFLA_OVPN_MAX,
 };

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
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--KnzEBaltbQA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1064?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco linux: avoid redefining ovpn enums<br><br=
>Starting with Linux kernel version 6.16, a couple of ovpn-related enum<br>=
definitions were introduced in the `include/uapi/linux/if_link.h`<br>header=
. Redefining them in openvpn when they are already present in the<br>system=
 headers can lead to conflicts or build issues.<br><br>This commit ensures =
that enum redefinitions are avoided by conditionally<br>using the existing =
definitions from the system header when available.<br><br>Change-Id: I4fa2d=
578f9c0a5a8aa24ca1d396102ef2ed9a425<br>Signed-off-by: Ralf Lici &lt;ralf@...1186...=
.2726...&gt;<br>Message-Id: &lt;20250623140748.13960-1-gert@...1296...&gt;<=
br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g31961.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M src/openvpn/dco_linux.h<br>1 file changed, 7 insertions(+), 2 deletions=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h</span><br=
><span>index 273a6ad..4e441ec 100644</span><br><span>--- a/src/openvpn/dco_=
linux.h</span><br><span>+++ b/src/openvpn/dco_linux.h</span><br><span>@@ -4=
0,6 +40,8 @@</span><br><span> </span><br><span> /* OVPN section */</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef IF=
LA_OVPN_MAX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> enum ovpn_mode {</span><br><span>     OVPN_MODE_P2P,</span><br><s=
pan>     OVPN_MODE_MP,</span><br><span>@@ -49,10 +51,13 @@</span><br><span>=
     IFLA_OVPN_UNSPEC =3D 0,</span><br><span>     IFLA_OVPN_MODE,</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    __IFLA_OV=
PN_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    IFL=
A_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    __IFLA_OVPN_MAX,</span><br><span> };</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IFLA_=
OVPN_MAX (__IFLA_OVPN_MAX - 1)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /=
* ifndef IFLA_OVPN_MAX */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> typedef struct</span><br><span> {</span><br><span> =
    struct nl_sock *nl_sock;</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1064?usp=3Demail">cha=
nge 1064</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1064?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4fa2d578f9c0a5a8aa24ca1d396=
102ef2ed9a425 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1064 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--KnzEBaltbQA=--

