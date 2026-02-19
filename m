From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 19 Feb 2026 10:20:36 +0000
In-Reply-To: <gerrit.1771437772000.I560f45fb0011180be8ca2b0e7fbc63030fa10f35@...2715...>
References: <gerrit.1771437772000.I560f45fb0011180be8ca2b0e7fbc63030fa10f35@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 ralf@...2726..., antonio@...2726...
Message-ID: <dafe558fbb1c20e81a0345632d4f47f98588ff7f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cVg0oBp33kc="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cVg0oBp33kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici.

Hello ordex, ralf_lici,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail

to look at the new patch set (#3).


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
---
M src/openvpn/networking_sitnl.c
1 file changed, 9 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/1547/3

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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I560f45fb0011180be8ca2b0e7fbc63030fa10f35
Gerrit-Change-Number: 1547
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: ralf_lici <ralf@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ralf_lici <ralf@...2726...>

--cVg0oBp33kc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">DCO Linux: Fix setting DCO ifmode failing on big en=
dian archs<br><br>The problem is that SITNL_ADDATTR is not forcing type saf=
ety and on<br>big endian architcutre passing a smaller size than the underl=
ying<br>integer type of data causes only the more significant byte(s) to be=
 passed<br>instead.<br><br>A proper fix would be to add specific methods fo=
r common integer types like<br>SITNL_ADDATTR_u8, SITNL_ADDATTR_u16, SITNL_A=
DDATTR_u32 like netlink library<br>does with NLA_PUT_U32, NLA_PUT_U16, NLA_=
PUT_U8.<br><br>Change-Id: I560f45fb0011180be8ca2b0e7fbc63030fa10f35<br>Gith=
ub: closes OpenVPN/ovpn-dco#96<br>Signed-off-by: Arne Schwabe &lt;arne@...1386...=
227...&gt;<br>---<br>M src/openvpn/networking_sitnl.c<br>1 file changed, 9 =
insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/47/1547/3</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c</span><br><sp=
an>index a5b2905..ad7edef 100644</span><br><span>--- a/src/openvpn/networki=
ng_sitnl.c</span><br><span>+++ b/src/openvpn/networking_sitnl.c</span><br><=
span>@@ -1337,7 +1337,15 @@</span><br><span>     {</span><br><span>        =
 dco_context_t *dco =3D arg;</span><br><span>         struct rtattr *data =
=3D SITNL_NEST(&amp;req.n, sizeof(req), IFLA_INFO_DATA);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        SITNL_ADDATTR(&amp;req.n, sizeof=
(req), IFLA_OVPN_MODE, &amp;dco-&gt;ifmode, sizeof(uint8_t));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* the netlink format is uint8_t for this an=
d using something</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * other than uint8_t here (enum underlying type is undefined but</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * commonly int=
) causes the values to be 0 when passed</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * on big endian arch as we only take the (bigg=
est endian) byte</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * directly at the address</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        uint8_t ifmode =3D (uint8_t)dco-&gt;ifmode;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        SITNL_ADDATTR(&amp;req.n, sizeo=
f(req), IFLA_OVPN_MODE, &amp;ifmode, sizeof(uint8_t));</span><br><span>    =
     SITNL_NEST_END(&amp;req.n, data);</span><br><span>     }</span><br><sp=
an> #endif</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail">change 1547</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I560f45fb0011180be8ca2b0e7fb=
c63030fa10f35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1547 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>

</body></html>=

--cVg0oBp33kc=--

