From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 17 May 2025 08:46:42 +0000
In-Reply-To: <gerrit.1747427153000.I104b4adeb9f65cce3487b82f35470174acba92bc@...2715...>
References: <gerrit.1747427153000.I104b4adeb9f65cce3487b82f35470174acba92bc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <ac8e8fecbcc3f4ffdf133a63eadb83997a0803af-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BlapsHX6Ulc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: fix peer
 stats parsing with new ovpn kernel module
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BlapsHX6Ulc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
25?usp=3Demail )

Change subject: dco_linux: fix peer stats parsing with new ovpn kernel modu=
le
......................................................................

dco_linux: fix peer stats parsing with new ovpn kernel module

The new ovpn kernel module has changed the netlink attribute
type of the fields containing the pkt/bytes counters in the
peer stats.

We moved from uint64 to uint (a dynamic type can be either
32 or 64 bits), therefore the parsing code must be adapted
accordingly.

While at it, also fix the peer object parsing in the P2P code path.

The fix can be verified by enabling --status with verb 6 and
watching the counters increasing:

	2025-05-16 22:23:56 us=3D649488 dco_get_peer_stats_multi
	2025-05-16 22:23:56 us=3D651008 dco_parse_peer_multi: parsing message...
	2025-05-16 22:23:56 us=3D651734 dco_update_peer_stat / dco_read_bytes: 116=
280
	2025-05-16 22:23:56 us=3D652682 dco_update_peer_stat / dco_write_bytes: 11=
5776
	2025-05-16 22:23:56 us=3D653467 dco_update_peer_stat / tun_read_bytes: 900=
48
	2025-05-16 22:23:56 us=3D654110 dco_update_peer_stat / tun_write_bytes: 90=
048

Change-Id: I104b4adeb9f65cce3487b82f35470174acba92bc
Github: closes OpenVPN/openvpn#746
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250517083231.27977-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
666.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
1 file changed, 21 insertions(+), 10 deletions(-)




diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index a5f9e06..3f7965e 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -908,12 +908,26 @@
     return ovpn_nl_recvmsgs(dco, __func__);
 }

+/* libnl < 3.11.0 does not implement nla_get_uint() */
+static uint64_t
+ovpn_nla_get_uint(struct nlattr *attr)
+{
+    if (nla_len(attr) =3D=3D sizeof(uint32_t))
+    {
+        return nla_get_u32(attr);
+    }
+    else
+    {
+        return nla_get_u64(attr);
+    }
+}
+
 static void
 dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t i=
d)
 {
     if (tb[OVPN_A_PEER_LINK_RX_BYTES])
     {
-        c2->dco_read_bytes =3D nla_get_u64(tb[OVPN_A_PEER_LINK_RX_BYTES]);
+        c2->dco_read_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_RX_BY=
TES]);
         msg(D_DCO_DEBUG, "%s / dco_read_bytes: " counter_format, __func__,
             c2->dco_read_bytes);
     }
@@ -925,7 +939,7 @@

     if (tb[OVPN_A_PEER_LINK_TX_BYTES])
     {
-        c2->dco_write_bytes =3D nla_get_u64(tb[OVPN_A_PEER_LINK_TX_BYTES]);
+        c2->dco_write_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_TX_B=
YTES]);
         msg(D_DCO_DEBUG, "%s / dco_write_bytes: " counter_format, __func__,
             c2->dco_write_bytes);
     }
@@ -937,7 +951,7 @@

     if (tb[OVPN_A_PEER_VPN_RX_BYTES])
     {
-        c2->tun_read_bytes =3D nla_get_u64(tb[OVPN_A_PEER_VPN_RX_BYTES]);
+        c2->tun_read_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_RX_BYT=
ES]);
         msg(D_DCO_DEBUG, "%s / tun_read_bytes: " counter_format, __func__,
             c2->tun_read_bytes);
     }
@@ -949,7 +963,7 @@

     if (tb[OVPN_A_PEER_VPN_TX_BYTES])
     {
-        c2->tun_write_bytes =3D nla_get_u64(tb[OVPN_A_PEER_VPN_TX_BYTES]);
+        c2->tun_write_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_TX_BY=
TES]);
         msg(D_DCO_DEBUG, "%s / tun_write_bytes: " counter_format, __func__,
             c2->tun_write_bytes);
     }
@@ -1028,12 +1042,12 @@
 dco_parse_peer(struct nl_msg *msg, void *arg)
 {
     struct context *c =3D arg;
-    struct nlattr *tb[OVPN_A_MAX];
+    struct nlattr *tb[OVPN_A_MAX + 1];
     struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));

     msg(D_DCO_DEBUG, "%s: parsing message...", __func__);

-    nla_parse(tb, OVPN_A_PEER_MAX, genlmsg_attrdata(gnlh, 0),
+    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
               genlmsg_attrlen(gnlh, 0), NULL);

     if (!tb[OVPN_A_PEER])
@@ -1043,10 +1057,7 @@
     }

     struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];
-
-    nla_parse(tb_peer, OVPN_A_PEER,
-              nla_data(tb[OVPN_A_PEER]),
-              nla_len(tb[OVPN_A_PEER]), NULL);
+    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);

     if (!tb_peer[OVPN_A_PEER_ID])
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1025?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I104b4adeb9f65cce3487b82f35470174acba92bc
Gerrit-Change-Number: 1025
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--BlapsHX6Ulc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1025?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco_linux: fix peer stats parsing with new ov=
pn kernel module<br><br>The new ovpn kernel module has changed the netlink =
attribute<br>type of the fields containing the pkt/bytes counters in the<br=
>peer stats.<br><br>We moved from uint64 to uint (a dynamic type can be eit=
her<br>32 or 64 bits), therefore the parsing code must be adapted<br>accord=
ingly.<br><br>While at it, also fix the peer object parsing in the P2P code=
 path.<br><br>The fix can be verified by enabling --status with verb 6 and<=
br>watching the counters increasing:<br><br>	2025-05-16 22:23:56 us=3D64948=
8 dco_get_peer_stats_multi<br>	2025-05-16 22:23:56 us=3D651008 dco_parse_pe=
er_multi: parsing message...<br>	2025-05-16 22:23:56 us=3D651734 dco_update=
_peer_stat / dco_read_bytes: 116280<br>	2025-05-16 22:23:56 us=3D652682 dco=
_update_peer_stat / dco_write_bytes: 115776<br>	2025-05-16 22:23:56 us=3D65=
3467 dco_update_peer_stat / tun_read_bytes: 90048<br>	2025-05-16 22:23:56 u=
s=3D654110 dco_update_peer_stat / tun_write_bytes: 90048<br><br>Change-Id: =
I104b4adeb9f65cce3487b82f35470174acba92bc<br>Github: closes OpenVPN/openvpn=
#746<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Acke=
d-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;2025051708323=
1.27977-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-=
devel@lists.sourceforge.net/msg31666.html<br>Signed-off-by: Gert Doering &l=
t;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>1 file changed=
, 21 insertions(+), 10 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br=
><span>index a5f9e06..3f7965e 100644</span><br><span>--- a/src/openvpn/dco_=
linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -9=
08,12 +908,26 @@</span><br><span>     return ovpn_nl_recvmsgs(dco, __func__=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* libnl &lt; 3.11.0 does not implement nla_get_uint() =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static uint64_t</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_nla_get_uint(str=
uct nlattr *attr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (nla_len(attr=
) =3D=3D sizeof(uint32_t))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return nla_get_u32(attr);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return nla_get_u64(attr)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> dco=
_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)</=
span><br><span> {</span><br><span>     if (tb[OVPN_A_PEER_LINK_RX_BYTES])</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        c2-&gt;dco_read_bytes =3D nla_get_u64(tb[OVPN_A_PEER_LINK_RX_BYTES]=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c2-&gt;dc=
o_read_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_RX_BYTES]);</span><b=
r><span>         msg(D_DCO_DEBUG, &quot;%s / dco_read_bytes: &quot; counter=
_format, __func__,</span><br><span>             c2-&gt;dco_read_bytes);</sp=
an><br><span>     }</span><br><span>@@ -925,7 +939,7 @@</span><br><span> </=
span><br><span>     if (tb[OVPN_A_PEER_LINK_TX_BYTES])</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c2-&gt;dco_=
write_bytes =3D nla_get_u64(tb[OVPN_A_PEER_LINK_TX_BYTES]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        c2-&gt;dco_write_bytes =3D =
ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_TX_BYTES]);</span><br><span>         =
msg(D_DCO_DEBUG, &quot;%s / dco_write_bytes: &quot; counter_format, __func_=
_,</span><br><span>             c2-&gt;dco_write_bytes);</span><br><span>  =
   }</span><br><span>@@ -937,7 +951,7 @@</span><br><span> </span><br><span>=
     if (tb[OVPN_A_PEER_VPN_RX_BYTES])</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        c2-&gt;tun_read_bytes =3D n=
la_get_u64(tb[OVPN_A_PEER_VPN_RX_BYTES]);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        c2-&gt;tun_read_bytes =3D ovpn_nla_get_uint(t=
b[OVPN_A_PEER_VPN_RX_BYTES]);</span><br><span>         msg(D_DCO_DEBUG, &qu=
ot;%s / tun_read_bytes: &quot; counter_format, __func__,</span><br><span>  =
           c2-&gt;tun_read_bytes);</span><br><span>     }</span><br><span>@=
@ -949,7 +963,7 @@</span><br><span> </span><br><span>     if (tb[OVPN_A_PEE=
R_VPN_TX_BYTES])</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        c2-&gt;tun_write_bytes =3D nla_get_u64(tb[OVPN_A_=
PEER_VPN_TX_BYTES]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        c2-&gt;tun_write_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_TX=
_BYTES]);</span><br><span>         msg(D_DCO_DEBUG, &quot;%s / tun_write_by=
tes: &quot; counter_format, __func__,</span><br><span>             c2-&gt;t=
un_write_bytes);</span><br><span>     }</span><br><span>@@ -1028,12 +1042,1=
2 @@</span><br><span> dco_parse_peer(struct nl_msg *msg, void *arg)</span><=
br><span> {</span><br><span>     struct context *c =3D arg;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb[OVPN_A_MAX];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *tb[=
OVPN_A_MAX + 1];</span><br><span>     struct genlmsghdr *gnlh =3D nlmsg_dat=
a(nlmsg_hdr(msg));</span><br><span> </span><br><span>     msg(D_DCO_DEBUG, =
&quot;%s: parsing message...&quot;, __func__);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb, OVPN_A_PEER_MA=
X, genlmsg_attrdata(gnlh, 0),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),</span><b=
r><span>               genlmsg_attrlen(gnlh, 0), NULL);</span><br><span> </=
span><br><span>     if (!tb[OVPN_A_PEER])</span><br><span>@@ -1043,10 +1057=
,7 @@</span><br><span>     }</span><br><span> </span><br><span>     struct =
nlattr *tb_peer[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    n=
la_parse(tb_peer, OVPN_A_PEER,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-              nla_data(tb[OVPN_A_PEER]),</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-              nla_len(tb[OVPN_A_PEER]), NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_parse_nested=
(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);</span><br><span> </span>=
<br><span>     if (!tb_peer[OVPN_A_PEER_ID])</span><br><span>     {</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1025?usp=3Demail">change 1025</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1025?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I104b4adeb9f65cce3487b82f354=
70174acba92bc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1025 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--BlapsHX6Ulc=--

