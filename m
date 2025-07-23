From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 08:35:18 +0000
In-Reply-To: <gerrit.1753215725000.I94004579aef4a1ccccdbcf8edd7b722e5a611c72@...2715...>
References: <gerrit.1753215725000.I94004579aef4a1ccccdbcf8edd7b722e5a611c72@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <642690e84bcc344ac8889c089fdab814d0e0874b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vF/T+TfwphU="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vF/T+TfwphU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
98?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250723060747.19524-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
263.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
1 file changed, 144 insertions(+), 144 deletions(-)




diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index a04a164..3652a49 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -806,6 +806,150 @@
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
@@ -988,112 +1132,6 @@
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
@@ -1118,44 +1156,6 @@
     return ret;
 }

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
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--vF/T+TfwphU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1098?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco_linux: rearrange functions<br><br>In prep=
aration for the implementation of a generic netlink<br>message parser, move=
 all parsing functions above ovpn_handle_msg().<br><br>The latter is soon g=
oing to become a generic message parser which<br>will invoke specific handl=
ers, thus they are required to be defined<br>earlier in the file.<br><br>No=
 functional change is intended.<br><br>This patch is only meant to reduce e=
ntropy in the patch which will do<br>the real netlink parser change.<br><br=
>Better reviewed with: git show --color-moved<br><br>Change-Id: I94004579ae=
f4a1ccccdbcf8edd7b722e5a611c72<br>Signed-off-by: Antonio Quartulli &lt;anto=
nio@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Mes=
sage-Id: &lt;20250723060747.19524-1-gert@...1296...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32263.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco=
_linux.c<br>1 file changed, 144 insertions(+), 144 deletions(-)<br><br></pr=
e>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br=
><span>index a04a164..3652a49 100644</span><br><span>--- a/src/openvpn/dco_=
linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -8=
06,6 +806,150 @@</span><br><span>     return false;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* lib=
nl &lt; 3.11.0 does not implement nla_get_uint() */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static uint64_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ovpn_nla_get_uint(struct nlattr *attr)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (nla_len(attr) =3D=3D sizeof(uint32_t=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return nla_get_u32(attr=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return nla_get_u64(attr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_stat(stru=
ct context_2 *c2, struct nlattr *tb[], uint32_t id)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (tb[OVPN_A_PEER_LINK_RX_BYTES])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        c2-&gt;dco_read_bytes =3D ovpn_nla_get_uint(tb=
[OVPN_A_PEER_LINK_RX_BYTES]);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(D_DCO_DEBUG, &quot;%s / dco_read_bytes: &quot; counte=
r_format, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            c2-&gt;dco_read_bytes);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &qu=
ot;%s: no link RX bytes provided in reply for peer %u&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            __func__, id);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (tb[OVPN_A_PEER_LINK_TX_BYTES])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        c2-&gt;dco_write_bytes =3D ovpn_nla_get_uint(tb=
[OVPN_A_PEER_LINK_TX_BYTES]);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(D_DCO_DEBUG, &quot;%s / dco_write_bytes: &quot; count=
er_format, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            c2-&gt;dco_write_bytes);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &=
quot;%s: no link TX bytes provided in reply for peer %u&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            __func__, id);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (tb[OVPN_A_PEER_VPN_RX_BYTES])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        c2-&gt;tun_read_bytes =3D ovpn_nla_get_uint(tb=
[OVPN_A_PEER_VPN_RX_BYTES]);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(D_DCO_DEBUG, &quot;%s / tun_read_bytes: &quot; counter=
_format, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           c2-&gt;tun_read_bytes);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quo=
t;%s: no VPN RX bytes provided in reply for peer %u&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            __func__, id);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (tb[OVPN_A_PEER_VPN_TX_BYTES])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        c2-&gt;tun_write_bytes =3D ovpn_nla_get_uint(tb=
[OVPN_A_PEER_VPN_TX_BYTES]);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(D_DCO_DEBUG, &quot;%s / tun_write_bytes: &quot; counte=
r_format, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            c2-&gt;tun_write_bytes);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &q=
uot;%s: no VPN TX bytes provided in reply for peer %u&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            __func__, id);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_parse_pe=
er_multi(struct nl_msg *msg, void *arg)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct nlattr *tb[OVPN_A_MAX + 1];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(m=
sg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: pa=
rsing message...&quot;, __func__);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              genlmsg_attrlen(gnlh, 0), N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!tb[OVPN_A_PEER])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return NL_SKIP;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    nla_parse_nested(tb_peer, OVPN_A_PEER=
_MAX, tb[OVPN_A_PEER], NULL);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
tb_peer[OVPN_A_PEER_ID])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(M_WARN, &quot;%s: no peer-id provided in reply&quot;, __func__);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return NL_SKIP;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct multi_context *m =3D arg;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    uint32_t peer_id =3D nla_get_u32(tb=
_peer[OVPN_A_PEER_ID]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (peer_id=
 &gt;=3D m-&gt;max_clients || !m-&gt;instances[peer_id])</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s: cannot store DCO stats=
 for peer %u&quot;, __func__,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            peer_id);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return NL_SKIP;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_update_pe=
er_stat(&amp;m-&gt;instances[peer_id]-&gt;context.c2, tb_peer, peer_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return NL_OK;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_parse_pe=
er(struct nl_msg *msg, void *arg)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct context *c =3D arg;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct nlattr *tb[OVPN_A_MAX + 1];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_=
hdr(msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%=
s: parsing message...&quot;, __func__);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+              genlmsg_attrlen(gnlh, 0=
), NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tb[OVPN_A_PEER])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s: ma=
lformed reply&quot;, __func__);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return NL_SKIP;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr=
 *tb_peer[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER],=
 NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!tb_peer[OVPN_A_PEER_ID=
])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s: n=
o peer-id provided in reply&quot;, __func__);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return NL_SKIP;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.tls_multi-&gt;dco_=
peer_id !=3D peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dco_update_peer_stat(&amp;c-&gt;c2, t=
b_peer, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NL_OK;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* This function parses=
 any netlink message sent by ovpn-dco to userspace */</span><br><span> stat=
ic int</span><br><span> ovpn_handle_msg(struct nl_msg *msg, void *arg)</spa=
n><br><span>@@ -988,112 +1132,6 @@</span><br><span>     return ovpn_nl_recv=
msgs(dco, __func__);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/* libnl &lt; 3.11.0 does not implement=
 nla_get_uint() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_nla_=
get_uint(struct nlattr *attr)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (nla_=
len(attr) =3D=3D sizeof(uint32_t))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return nla_get_u32(attr);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return nla_get_u64(attr);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_update_peer_=
stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (tb[OVPN_A_PEER_LINK_RX_BYTES])</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        c2-&gt;dco_read_bytes =3D ovpn_nla_get_uint(tb[=
OVPN_A_PEER_LINK_RX_BYTES]);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(D_DCO_DEBUG, &quot;%s / dco_read_bytes: &quot; counter_f=
ormat, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       c2-&gt;dco_read_bytes);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no lin=
k RX bytes provided in reply for peer %u&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            __func__, id);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (tb[OVPN_A_PEER_LINK_TX_BYTES])</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    c2-&gt;dco_write_bytes =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_TX_BYT=
ES]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DC=
O_DEBUG, &quot;%s / dco_write_bytes: &quot; counter_format, __func__,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            c2-&gt;dco_writ=
e_bytes);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no link TX bytes provided i=
n reply for peer %u&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            __func__, id);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tb[OVPN_A_PEER_VPN_=
RX_BYTES])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        c2-&gt;tun_read_byt=
es =3D ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_RX_BYTES]);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s / tun_r=
ead_bytes: &quot; counter_format, __func__,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            c2-&gt;tun_read_bytes);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(M_WARN, &quot;%s: no VPN RX bytes provided in reply for peer %u&quot;,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            __func__, i=
d);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (tb[OVPN_A_PEER_VPN_TX_BYTES])</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        c2-&gt;tun_write_bytes =3D ovpn_nla_get_uint(tb=
[OVPN_A_PEER_VPN_TX_BYTES]);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(D_DCO_DEBUG, &quot;%s / tun_write_bytes: &quot; counter_=
format, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        c2-&gt;tun_write_bytes);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no V=
PN TX bytes provided in reply for peer %u&quot;,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            __func__, id);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_parse_peer_multi(struct nl_msg *msg, vo=
id *arg)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb[OVPN_A_MAX =
+ 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct genlm=
sghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __func__);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gn=
lh, 0),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
genlmsg_attrlen(gnlh, 0), NULL);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!t=
b[OVPN_A_PEER])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    nla_parse_nested(tb_peer, =
OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!tb_peer[OVPN_A_PEER_ID])</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  msg(M_WARN, &quot;%s: no peer-id provided in reply&quot;, __func__);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct multi_context *m =3D arg;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    uint32_t peer_id =3D nla_get_u32(tb_peer[O=
VPN_A_PEER_ID]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (peer_id &gt;=3D m-=
&gt;max_clients || !m-&gt;instances[peer_id])</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        msg(M_WARN, &quot;%s: cannot store DCO stats for peer %u&qu=
ot;, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     peer_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    dco_update_peer_stat(&amp;m-&gt;instan=
ces[peer_id]-&gt;context.c2, tb_peer, peer_id);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return NL_OK;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> i=
nt</span><br><span> dco_get_peer_stats_multi(dco_context_t *dco, struct mul=
ti_context *m,</span><br><span>                          const bool raise_s=
igusr1_on_err)</span><br><span>@@ -1118,44 +1156,6 @@</span><br><span>     =
return ret;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-dco_parse_peer(struct nl_msg *msg, void *arg)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct context *c =3D arg;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct nlattr *tb[OVPN_A_MAX + 1];</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct genlmsghdr *gnlh =
=3D nlmsg_data(nlmsg_hdr(msg));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_D=
CO_DEBUG, &quot;%s: parsing message...&quot;, __func__);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-              genlmsg_attr=
len(gnlh, 0), NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tb[OVPN_A_PEE=
R])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s:=
 malformed reply&quot;, __func__);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        return NL_SKIP;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb_=
peer[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (!tb_peer[OVPN_A_PEER_ID])</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no peer-id provi=
ded in reply&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t peer_id =3D n=
la_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (c-&gt;c2.tls_multi-&gt;dco_peer_id !=3D peer_id)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   dco_update_peer_stat(&amp;c-&gt;c2, tb_peer, peer_id);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return NL_OK;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> int</span><br><span> dco_get_peer_stats(struct context *c, const b=
ool raise_sigusr1_on_err)</span><br><span> {</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1098?=
usp=3Demail">change 1098</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1098?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I94004579aef4a1ccccdbcf8edd7=
b722e5a611c72 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1098 </div>
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


--vF/T+TfwphU=--

