From: Gert Doering <gert@...1296...>
Date: Wed, 23 Jul 2025 08:07:41 +0200
Message-ID: <20250723060747.19524-1-gert@...1296...>
In-Reply-To: <gerrit.1753215725000.I94004579aef4a1ccccdbcf8edd7b722e5a611c72@...2715...>
References: <gerrit.1753215725000.I94004579aef4a1ccccdbcf8edd7b722e5a611c72@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco_linux: rearrange functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Antonio Quartulli <antonio@...2726...>

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
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1098
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
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
+    if (nla_len(attr) == sizeof(uint32_t))
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
+dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)
+{
+    if (tb[OVPN_A_PEER_LINK_RX_BYTES])
+    {
+        c2->dco_read_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_RX_BYTES]);
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
+        c2->dco_write_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_TX_BYTES]);
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
+        c2->tun_read_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_RX_BYTES]);
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
+        c2->tun_write_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_TX_BYTES]);
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
+    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
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
+    struct multi_context *m = arg;
+    uint32_t peer_id = nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
+
+    if (peer_id >= m->max_clients || !m->instances[peer_id])
+    {
+        msg(M_WARN, "%s: cannot store DCO stats for peer %u", __func__,
+            peer_id);
+        return NL_SKIP;
+    }
+
+    dco_update_peer_stat(&m->instances[peer_id]->context.c2, tb_peer, peer_id);
+
+    return NL_OK;
+}
+
+static int
+dco_parse_peer(struct nl_msg *msg, void *arg)
+{
+    struct context *c = arg;
+    struct nlattr *tb[OVPN_A_MAX + 1];
+    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
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
+    uint32_t peer_id = nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
+    if (c->c2.tls_multi->dco_peer_id != peer_id)
+    {
+        return NL_SKIP;
+    }
+
+    dco_update_peer_stat(&c->c2, tb_peer, peer_id);
+
+    return NL_OK;
+}
+
 /* This function parses any netlink message sent by ovpn-dco to userspace */
 static int
 ovpn_handle_msg(struct nl_msg *msg, void *arg)
@@ -994,112 +1138,6 @@
     return ovpn_nl_recvmsgs(dco, __func__);
 }
 
-/* libnl < 3.11.0 does not implement nla_get_uint() */
-static uint64_t
-ovpn_nla_get_uint(struct nlattr *attr)
-{
-    if (nla_len(attr) == sizeof(uint32_t))
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
-dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)
-{
-    if (tb[OVPN_A_PEER_LINK_RX_BYTES])
-    {
-        c2->dco_read_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_RX_BYTES]);
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
-        c2->dco_write_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_LINK_TX_BYTES]);
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
-        c2->tun_read_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_RX_BYTES]);
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
-        c2->tun_write_bytes = ovpn_nla_get_uint(tb[OVPN_A_PEER_VPN_TX_BYTES]);
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
-    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
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
-    struct multi_context *m = arg;
-    uint32_t peer_id = nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
-
-    if (peer_id >= m->max_clients || !m->instances[peer_id])
-    {
-        msg(M_WARN, "%s: cannot store DCO stats for peer %u", __func__,
-            peer_id);
-        return NL_SKIP;
-    }
-
-    dco_update_peer_stat(&m->instances[peer_id]->context.c2, tb_peer, peer_id);
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
 
-static int
-dco_parse_peer(struct nl_msg *msg, void *arg)
-{
-    struct context *c = arg;
-    struct nlattr *tb[OVPN_A_MAX + 1];
-    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
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
-    uint32_t peer_id = nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
-    if (c->c2.tls_multi->dco_peer_id != peer_id)
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

