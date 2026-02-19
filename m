From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 19 Feb 2026 15:52:03 +0000
In-Reply-To: <gerrit.1771437772000.I560f45fb0011180be8ca2b0e7fbc63030fa10f35@...2715...>
References: <gerrit.1771437772000.I560f45fb0011180be8ca2b0e7fbc63030fa10f35@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., antonio@...2726...
Message-ID: <d84c5438569466be84e072edf56715f3f3cda223-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BRM83XHSm0w="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: DCO Linux: Fix
 setting DCO ifmode failing on big endian archs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: ralf_lici <ralf@...2726...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BRM83XHSm0w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
47?usp=3Demail )

Change subject: DCO Linux: Fix setting DCO ifmode failing on big endian arc=
hs
......................................................................

DCO Linux: Fix setting DCO ifmode failing on big endian archs

The problem is that SITNL_ADDATTR is not forcing type safety and on
big endian architcutre passing a smaller size than the underlying
integer type of data causes only the more significant byte(s) to be passed
instead.

A proper fix would be to add specific methods for common integer types like
SITNL_ADDATTR_u8, SITNL_ADDATTR_u16, SITNL_ADDATTR_u32 like netlink library
does with NLA_PUT_U32, NLA_PUT_U16, NLA_PUT_U8.

Change-Id: I560f45fb0011180be8ca2b0e7fbc63030fa10f35
Github: closes OpenVPN/ovpn-dco#96
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1547
Message-Id: <20260219110954.21471-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
752.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/networking_sitnl.c
1 file changed, 9 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index a5b2905..ad7edef 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1337,7 +1337,15 @@
     {
         dco_context_t *dco =3D arg;
         struct rtattr *data =3D SITNL_NEST(&req.n, sizeof(req), IFLA_INFO_=
DATA);
-        SITNL_ADDATTR(&req.n, sizeof(req), IFLA_OVPN_MODE, &dco->ifmode, s=
izeof(uint8_t));
+
+        /* the netlink format is uint8_t for this and using something
+         * other than uint8_t here (enum underlying type is undefined but
+         * commonly int) causes the values to be 0 when passed
+         * on big endian arch as we only take the (biggest endian) byte
+         * directly at the address
+         */
+        uint8_t ifmode =3D (uint8_t)dco->ifmode;
+        SITNL_ADDATTR(&req.n, sizeof(req), IFLA_OVPN_MODE, &ifmode, sizeof=
(uint8_t));
         SITNL_NEST_END(&req.n, data);
     }
 #endif

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I560f45fb0011180be8ca2b0e7fbc63030fa10f35
Gerrit-Change-Number: 1547
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: ralf_lici <ralf@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BRM83XHSm0w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1547?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">DCO Linux: Fix setting DCO ifmode failing on big=
 endian archs<br><br>The problem is that SITNL_ADDATTR is not forcing type =
safety and on<br>big endian architcutre passing a smaller size than the und=
erlying<br>integer type of data causes only the more significant byte(s) to=
 be passed<br>instead.<br><br>A proper fix would be to add specific methods=
 for common integer types like<br>SITNL_ADDATTR_u8, SITNL_ADDATTR_u16, SITN=
L_ADDATTR_u32 like netlink library<br>does with NLA_PUT_U32, NLA_PUT_U16, N=
LA_PUT_U8.<br><br>Change-Id: I560f45fb0011180be8ca2b0e7fbc63030fa10f35<br>G=
ithub: closes OpenVPN/ovpn-dco#96<br>Signed-off-by: Arne Schwabe &lt;arne@...220...=
..1227...&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>=
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1547<br>Message-Id: &lt;=
20260219110954.21471-1-gert@...1296...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg35752.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/networking_sitnl=
.c<br>1 file changed, 9 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sit=
nl.c</span><br><span>index a5b2905..ad7edef 100644</span><br><span>--- a/sr=
c/openvpn/networking_sitnl.c</span><br><span>+++ b/src/openvpn/networking_s=
itnl.c</span><br><span>@@ -1337,7 +1337,15 @@</span><br><span>     {</span>=
<br><span>         dco_context_t *dco =3D arg;</span><br><span>         str=
uct rtattr *data =3D SITNL_NEST(&amp;req.n, sizeof(req), IFLA_INFO_DATA);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        SITNL_ADDATTR(&=
amp;req.n, sizeof(req), IFLA_OVPN_MODE, &amp;dco-&gt;ifmode, sizeof(uint8_t=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* the netlink format is ui=
nt8_t for this and using something</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * other than uint8_t here (enum underlying type is =
undefined but</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * commonly int) causes the values to be 0 when passed</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * on big endian arch as we on=
ly take the (biggest endian) byte</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * directly at the address</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        uint8_t ifmode =3D (uint8_t)dco-&gt;ifmode;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        SITNL_ADDATTR(=
&amp;req.n, sizeof(req), IFLA_OVPN_MODE, &amp;ifmode, sizeof(uint8_t));</sp=
an><br><span>         SITNL_NEST_END(&amp;req.n, data);</span><br><span>   =
  }</span><br><span> #endif</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail">chan=
ge 1547</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I560f45fb0011180be8ca2b0e7fb=
c63030fa10f35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1547 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--BRM83XHSm0w=--

