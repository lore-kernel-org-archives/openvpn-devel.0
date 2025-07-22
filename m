From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 22 Jul 2025 20:22:22 +0000
References: <gerrit.1753215725000.I94004579aef4a1ccccdbcf8edd7b722e5a611c72@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ecfd2b477198438f10609c2e338701fc1bb34ece-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PzsQWWitjAA="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco_linux: rearrange
 functions
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

--PzsQWWitjAA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1098?usp=3Demail

to review the following change.


Change subject: dco_linux: rearrange functions
......................................................................

dco_linux: rearrange functions

In preparation for the implementation of a generic netlink
message parser, move all parsing functions above ovpn_handle_msg().

The latter is soon going to become a generic message parser which
will invoke specific handlers, thus they are required to be defined
earlier in the file.

No functional change is intended.

This patch is only meant to reduce entropy in the patch which will do
the real netlink parser change.

Better reviewed with: git show --color-moved

Change-Id: I94004579aef4a1ccccdbcf8edd7b722e5a611c72
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/dco_linux.c
1 file changed, 144 insertions(+), 144 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/1098/1

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 13506a1..ec6efaa 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -812,6 +812,150 @@
     return false;
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
+static void
+dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t i=
d)
+{
+    if (tb[OVPN_A_PEER_LINK_RX_BYTES])
+    {
+        c2->dco_read_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_RX_BY=
TES]);
+        msg(D_DCO_DEBUG, "%s / dco_read_bytes: " counter_format, __func__,
+            c2->dco_read_bytes);
+    }
+    else
+    {
+        msg(M_WARN, "%s: no link RX bytes provided in reply for peer %u",
+            __func__, id);
+    }
+
+    if (tb[OVPN_A_PEER_LINK_TX_BYTES])
+    {
+        c2->dco_write_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_TX_B=
YTES]);
+        msg(D_DCO_DEBUG, "%s / dco_write_bytes: " counter_format, __func__,
+            c2->dco_write_bytes);
+    }
+    else
+    {
+        msg(M_WARN, "%s: no link TX bytes provided in reply for peer %u",
+            __func__, id);
+    }
+
+    if (tb[OVPN_A_PEER_VPN_RX_BYTES])
+    {
+        c2->tun_read_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_RX_BYT=
ES]);
+        msg(D_DCO_DEBUG, "%s / tun_read_bytes: " counter_format, __func__,
+            c2->tun_read_bytes);
+    }
+    else
+    {
+        msg(M_WARN, "%s: no VPN RX bytes provided in reply for peer %u",
+            __func__, id);
+    }
+
+    if (tb[OVPN_A_PEER_VPN_TX_BYTES])
+    {
+        c2->tun_write_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_TX_BY=
TES]);
+        msg(D_DCO_DEBUG, "%s / tun_write_bytes: " counter_format, __func__,
+            c2->tun_write_bytes);
+    }
+    else
+    {
+        msg(M_WARN, "%s: no VPN TX bytes provided in reply for peer %u",
+            __func__, id);
+    }
+}
+
+static int
+dco_parse_peer_multi(struct nl_msg *msg, void *arg)
+{
+    struct nlattr *tb[OVPN_A_MAX + 1];
+    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
+
+    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
+
+    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
+              genlmsg_attrlen(gnlh, 0), NULL);
+
+    if (!tb[OVPN_A_PEER])
+    {
+        return NL_SKIP;
+    }
+
+    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];
+    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);
+
+    if (!tb_peer[OVPN_A_PEER_ID])
+    {
+        msg(M_WARN, "%s: no peer-id provided in reply", __func__);
+        return NL_SKIP;
+    }
+
+    struct multi_context *m =3D arg;
+    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
+
+    if (peer_id >=3D m->max_clients || !m->instances[peer_id])
+    {
+        msg(M_WARN, "%s: cannot store DCO stats for peer %u", __func__,
+            peer_id);
+        return NL_SKIP;
+    }
+
+    dco_update_peer_stat(&m->instances[peer_id]->context.c2, tb_peer, peer=
_id);
+
+    return NL_OK;
+}
+
+static int
+dco_parse_peer(struct nl_msg *msg, void *arg)
+{
+    struct context *c =3D arg;
+    struct nlattr *tb[OVPN_A_MAX + 1];
+    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
+
+    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
+
+    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
+              genlmsg_attrlen(gnlh, 0), NULL);
+
+    if (!tb[OVPN_A_PEER])
+    {
+        msg(D_DCO_DEBUG, "%s: malformed reply", __func__);
+        return NL_SKIP;
+    }
+
+    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];
+    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);
+
+    if (!tb_peer[OVPN_A_PEER_ID])
+    {
+        msg(M_WARN, "%s: no peer-id provided in reply", __func__);
+        return NL_SKIP;
+    }
+
+    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
+    if (c->c2.tls_multi->dco_peer_id !=3D peer_id)
+    {
+        return NL_SKIP;
+    }
+
+    dco_update_peer_stat(&c->c2, tb_peer, peer_id);
+
+    return NL_OK;
+}
+
 /* This function parses any netlink message sent by ovpn-dco to userspace =
*/
 static int
 ovpn_handle_msg(struct nl_msg *msg, void *arg)
@@ -994,112 +1138,6 @@
     return ovpn_nl_recvmsgs(dco, __func__);
 }

-/* libnl < 3.11.0 does not implement nla_get_uint() */
-static uint64_t
-ovpn_nla_get_uint(struct nlattr *attr)
-{
-    if (nla_len(attr) =3D=3D sizeof(uint32_t))
-    {
-        return nla_get_u32(attr);
-    }
-    else
-    {
-        return nla_get_u64(attr);
-    }
-}
-
-static void
-dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t i=
d)
-{
-    if (tb[OVPN_A_PEER_LINK_RX_BYTES])
-    {
-        c2->dco_read_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_RX_BY=
TES]);
-        msg(D_DCO_DEBUG, "%s / dco_read_bytes: " counter_format, __func__,
-            c2->dco_read_bytes);
-    }
-    else
-    {
-        msg(M_WARN, "%s: no link RX bytes provided in reply for peer %u",
-            __func__, id);
-    }
-
-    if (tb[OVPN_A_PEER_LINK_TX_BYTES])
-    {
-        c2->dco_write_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_TX_B=
YTES]);
-        msg(D_DCO_DEBUG, "%s / dco_write_bytes: " counter_format, __func__,
-            c2->dco_write_bytes);
-    }
-    else
-    {
-        msg(M_WARN, "%s: no link TX bytes provided in reply for peer %u",
-            __func__, id);
-    }
-
-    if (tb[OVPN_A_PEER_VPN_RX_BYTES])
-    {
-        c2->tun_read_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_RX_BYT=
ES]);
-        msg(D_DCO_DEBUG, "%s / tun_read_bytes: " counter_format, __func__,
-            c2->tun_read_bytes);
-    }
-    else
-    {
-        msg(M_WARN, "%s: no VPN RX bytes provided in reply for peer %u",
-            __func__, id);
-    }
-
-    if (tb[OVPN_A_PEER_VPN_TX_BYTES])
-    {
-        c2->tun_write_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_TX_BY=
TES]);
-        msg(D_DCO_DEBUG, "%s / tun_write_bytes: " counter_format, __func__,
-            c2->tun_write_bytes);
-    }
-    else
-    {
-        msg(M_WARN, "%s: no VPN TX bytes provided in reply for peer %u",
-            __func__, id);
-    }
-}
-
-int
-dco_parse_peer_multi(struct nl_msg *msg, void *arg)
-{
-    struct nlattr *tb[OVPN_A_MAX + 1];
-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
-
-    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
-
-    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
-              genlmsg_attrlen(gnlh, 0), NULL);
-
-    if (!tb[OVPN_A_PEER])
-    {
-        return NL_SKIP;
-    }
-
-    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];
-    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);
-
-    if (!tb_peer[OVPN_A_PEER_ID])
-    {
-        msg(M_WARN, "%s: no peer-id provided in reply", __func__);
-        return NL_SKIP;
-    }
-
-    struct multi_context *m =3D arg;
-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
-
-    if (peer_id >=3D m->max_clients || !m->instances[peer_id])
-    {
-        msg(M_WARN, "%s: cannot store DCO stats for peer %u", __func__,
-            peer_id);
-        return NL_SKIP;
-    }
-
-    dco_update_peer_stat(&m->instances[peer_id]->context.c2, tb_peer, peer=
_id);
-
-    return NL_OK;
-}
-
 int
 dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
                          const bool raise_sigusr1_on_err)
@@ -1124,44 +1162,6 @@
     return ret;
 }
=20
-static int
-dco_parse_peer(struct nl_msg *msg, void *arg)
-{
-    struct context *c =3D arg;
-    struct nlattr *tb[OVPN_A_MAX + 1];
-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
-
-    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
-
-    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
-              genlmsg_attrlen(gnlh, 0), NULL);
-
-    if (!tb[OVPN_A_PEER])
-    {
-        msg(D_DCO_DEBUG, "%s: malformed reply", __func__);
-        return NL_SKIP;
-    }
-
-    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];
-    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);
-
-    if (!tb_peer[OVPN_A_PEER_ID])
-    {
-        msg(M_WARN, "%s: no peer-id provided in reply", __func__);
-        return NL_SKIP;
-    }
-
-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
-    if (c->c2.tls_multi->dco_peer_id !=3D peer_id)
-    {
-        return NL_SKIP;
-    }
-
-    dco_update_peer_stat(&c->c2, tb_peer, peer_id);
-
-    return NL_OK;
-}
-
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1098?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I94004579aef4a1ccccdbcf8edd7b722e5a611c72
Gerrit-Change-Number: 1098
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--PzsQWWitjAA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1098?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco_linux: rearrange functions<br><br>In preparation for the=
 implementation of a generic netlink<br>message parser, move all parsing fu=
nctions above ovpn_handle_msg().<br><br>The latter is soon going to become =
a generic message parser which<br>will invoke specific handlers, thus they =
are required to be defined<br>earlier in the file.<br><br>No functional cha=
nge is intended.<br><br>This patch is only meant to reduce entropy in the p=
atch which will do<br>the real netlink parser change.<br><br>Better reviewe=
d with: git show --color-moved<br><br>Change-Id: I94004579aef4a1ccccdbcf8ed=
d7b722e5a611c72<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&=
gt;<br>---<br>M src/openvpn/dco_linux.c<br>1 file changed, 144 insertions(+=
), 144 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/98/1098/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux.c b/sr=
c/openvpn/dco_linux.c</span><br><span>index 13506a1..ec6efaa 100644</span><=
br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dc=
o_linux.c</span><br><span>@@ -812,6 +812,150 @@</span><br><span>     return=
 false;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* libnl &lt; 3.11.0 does not implement nla_get_ui=
nt() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static uint6=
4_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_nla_get_uin=
t(struct nlattr *attr)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (nla_len=
(attr) =3D=3D sizeof(uint32_t))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return nla_get_u32(attr);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return nla_get_u64(=
attr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t=
 id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (tb[OVPN_A_PEER_LINK_RX_BY=
TES])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        c2-&gt;dco_read_byte=
s =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_RX_BYTES]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s / dco=
_read_bytes: &quot; counter_format, __func__,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            c2-&gt;dco_read_bytes);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_WARN, &quot;%s: no link RX bytes provided in reply for pee=
r %u&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    __func__, id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (tb[OVPN_A_PEER_LINK_TX_BYT=
ES])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        c2-&gt;dco_write_byte=
s =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_TX_BYTES]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s / dco=
_write_bytes: &quot; counter_format, __func__,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            c2-&gt;dco_write_bytes);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_WARN, &quot;%s: no link TX bytes provided in reply for p=
eer %u&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      __func__, id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (tb[OVPN_A_PEER_VPN_RX_BY=
TES])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        c2-&gt;tun_read_byte=
s =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_RX_BYTES]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s / tun_=
read_bytes: &quot; counter_format, __func__,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            c2-&gt;tun_read_bytes);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_WARN, &quot;%s: no VPN RX bytes provided in reply for peer =
%u&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  __func__, id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (tb[OVPN_A_PEER_VPN_TX_BYTES]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        c2-&gt;tun_write_bytes =
=3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_TX_BYTES]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s / tun_w=
rite_bytes: &quot; counter_format, __func__,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            c2-&gt;tun_write_bytes);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_WARN, &quot;%s: no VPN TX bytes provided in reply for peer=
 %u&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   __func__, id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dco_parse_peer_multi(struct nl_msg *msg, void *arg)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct nlattr *tb[OVPN_A_MAX + 1];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct genlmsghdr *gnlh =
=3D nlmsg_data(nlmsg_hdr(msg));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __func__);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, =
0),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              ge=
nlmsg_attrlen(gnlh, 0), NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!tb[OVPN_A_PEER])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return N=
L_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct nlattr *tb_peer[OVPN_A_PEER_MAX + =
1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_parse_ne=
sted(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!tb_peer[OVPN_A_PEER_ID])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(M_WARN, &quot;%s: no peer-id provided in reply&=
quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D=
 arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t p=
eer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (peer_id &gt;=3D m-&gt;max_clients || !m-&gt;instances[pee=
r_id])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%=
s: cannot store DCO stats for peer %u&quot;, __func__,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            peer_id);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return NL_SKIP;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    dco_update_peer_stat(&amp;m-&gt;instances[peer_id]-&gt;context.=
c2, tb_peer, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NL_OK=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+dco_parse_peer(struct nl_msg *msg, void *arg)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct context *c =3D arg;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct nlattr *tb[OVPN_A_MAX + 1];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct genlmsghdr *gnl=
h =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __func__);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh=
, 0),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
genlmsg_attrlen(gnlh, 0), NULL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!tb[OVPN_A_PEER])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_=
DCO_DEBUG, &quot;%s: malformed reply&quot;, __func__);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return NL_SKIP;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    nla_parse_nested(tb_peer, OVPN_A_PEE=
R_MAX, tb[OVPN_A_PEER], NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!tb_peer[OVPN_A_PEER_ID])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(M_WARN, &quot;%s: no peer-id provided in reply&quot;, __func__);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return NL_SKIP;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEE=
R_ID]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&g=
t;c2.tls_multi-&gt;dco_peer_id !=3D peer_id)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return NL_SKIP;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_update_pee=
r_stat(&amp;c-&gt;c2, tb_peer, peer_id);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return NL_OK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/* This function parses any netlink message sent by ovpn-dco to userspace *=
/</span><br><span> static int</span><br><span> ovpn_handle_msg(struct nl_ms=
g *msg, void *arg)</span><br><span>@@ -994,112 +1138,6 @@</span><br><span> =
    return ovpn_nl_recvmsgs(dco, __func__);</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* libnl &lt; 3.=
11.0 does not implement nla_get_uint() */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static uint64_t</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-ovpn_nla_get_uint(struct nlattr *attr)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (nla_len(attr) =3D=3D sizeof(uint32_t))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return nla_get_u32(attr);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn nla_get_u64(attr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uin=
t32_t id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (tb[OVPN_A_PEER_LINK_RX_B=
YTES])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        c2-&gt;dco_read_bytes =
=3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_RX_BYTES]);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s / dco_rea=
d_bytes: &quot; counter_format, __func__,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            c2-&gt;dco_read_bytes);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(M_WARN, &quot;%s: no link RX bytes provided in reply for peer %u&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            __func__, id=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (tb[OVPN_A_PEER_LINK_TX_BYTES])</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        c2-&gt;dco_write_bytes =3D ovpn_nla_get_uint(tb=
[OVPN_A_PEER_LINK_TX_BYTES]);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        msg(D_DCO_DEBUG, &quot;%s / dco_write_bytes: &quot; counter=
_format, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         c2-&gt;dco_write_bytes);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no =
link TX bytes provided in reply for peer %u&quot;,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            __func__, id);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (tb[OVPN_A_PEER_VPN_RX_BYTES])</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     c2-&gt;tun_read_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_RX_BYTE=
S]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO=
_DEBUG, &quot;%s / tun_read_bytes: &quot; counter_format, __func__,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            c2-&gt;tun_read_b=
ytes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_WARN, &quot;%s: no VPN RX bytes provided in r=
eply for peer %u&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            __func__, id);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (tb[OVPN_A_PEER_VPN_TX_=
BYTES])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        c2-&gt;tun_write_bytes=
 =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_TX_BYTES]);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s / tun_wri=
te_bytes: &quot; counter_format, __func__,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            c2-&gt;tun_write_bytes);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(M_WARN, &quot;%s: no VPN TX bytes provided in reply for peer %u&quot;,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            __func__, i=
d);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_parse_peer_mul=
ti(struct nl_msg *msg, void *arg)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct nlattr *tb[OVPN_A_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: parsing message...=
&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb, OVPN_A=
_MAX, genlmsg_attrdata(gnlh, 0),</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-              genlmsg_attrlen(gnlh, 0), NULL);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (!tb[OVPN_A_PEER])</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb_peer[OVPN_=
A_PEER_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    n=
la_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!tb_peer[OVPN_A_PEER_ID])</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no peer-id provided in rep=
ly&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct multi_context *m =3D arg;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t peer_id =
=3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (peer_id &gt;=3D m-&gt;max_clients || !m-&gt;instances[peer_id])</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: cannot store=
 DCO stats for peer %u&quot;, __func__,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            peer_id);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return NL_SKIP;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_update_pe=
er_stat(&amp;m-&gt;instances[peer_id]-&gt;context.c2, tb_peer, peer_id);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return NL_OK;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> int</span><br><span> dco_get_peer_stats_multi(dco=
_context_t *dco, struct multi_context *m,</span><br><span>                 =
         const bool raise_sigusr1_on_err)</span><br><span>@@ -1124,44 +1162=
,6 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-dco_parse_peer(struct nl_msg *ms=
g, void *arg)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D ar=
g;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *=
tb[OVPN_A_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __f=
unc__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb, OVPN_A_MAX, genlm=
sg_attrdata(gnlh, 0),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
              genlmsg_attrlen(gnlh, 0), NULL);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (!tb[OVPN_A_PEER])</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
msg(D_DCO_DEBUG, &quot;%s: malformed reply&quot;, __func__);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    nla_parse_nested(tb_peer, OVPN_A_PEER_M=
AX, tb[OVPN_A_PEER], NULL);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tb_pee=
r[OVPN_A_PEER_ID])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN,=
 &quot;%s: no peer-id provided in reply&quot;, __func__);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.tls_multi-&gt;dc=
o_peer_id !=3D peer_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return=
 NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    dco_update_peer_stat(&amp;c-&gt;c2, tb_peer, =
peer_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return NL_OK;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> int</span><br><span> dco_get_peer_stats=
(struct context *c, const bool raise_sigusr1_on_err)</span><br><span> {</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1098?usp=3Demail">change 1098</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1098?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I94004579aef4a1ccccdbcf8edd7=
b722e5a611c72 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1098 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
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


--PzsQWWitjAA=--

