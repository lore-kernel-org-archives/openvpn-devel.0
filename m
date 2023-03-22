From: Antonio Quartulli <a@...2181...>
Date: Wed, 22 Mar 2023 11:06:10 +0100
Message-Id: <20230322100610.14234-2-a@...2181...>
In-Reply-To: <20230321230807.1382-1-a@...2181...>
References: <20230322100610.14234-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dco-linux: implement dco_get_peer_stats{,
 multi} API
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
Cc: Antonio Quartulli <a@...2181...>

With this API it is possible to retrieve the stats for a specific peer
or for all peers and then update the userspace counters with the value
reported by DCO.

Change-Id: Ia3990b86b1be7ca844fb1674b39ce0d60528ccff
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* use m->instances[] instead of iterating over m->hash

Changes from v2:
* added boundary check on peer-id
---
 src/openvpn/dco_linux.c      | 190 ++++++++++++++++++++++++++++++++---
 src/openvpn/ovpn_dco_linux.h |  14 ++-
 2 files changed, 186 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 47961849..8e7b4eab 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -41,6 +41,7 @@
 #include "tun.h"
 #include "ssl.h"
 #include "fdmisc.h"
+#include "multi.h"
 #include "ssl_verify.h"
 
 #include "ovpn_dco_linux.h"
@@ -168,16 +169,17 @@ ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
  * @param dco       The dco context to use
  * @param nl_msg    the message to use
  * @param cb        An optional callback if the caller expects an answer
+ * @param cb_arg    An optional param to pass to the callback
  * @param prefix    A prefix to report in the error message to give the user context
  * @return          status of sending the message
  */
 static int
 ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb cb,
-                 const char *prefix)
+                 void *cb_arg, const char *prefix)
 {
     dco->status = 1;
 
-    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, dco);
+    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, cb_arg);
     nl_send_auto(dco->nl_sock, nl_msg);
 
     while (dco->status == 1)
@@ -268,7 +270,7 @@ dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
     }
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -489,7 +491,7 @@ dco_swap_keys(dco_context_t *dco, unsigned int peerid)
     NLA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -513,7 +515,7 @@ dco_del_peer(dco_context_t *dco, unsigned int peerid)
     NLA_PUT_U32(nl_msg, OVPN_DEL_PEER_ATTR_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -539,7 +541,7 @@ dco_del_key(dco_context_t *dco, unsigned int peerid,
     NLA_PUT_U8(nl_msg, OVPN_DEL_KEY_ATTR_KEY_SLOT, slot);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -596,7 +598,7 @@ dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
 
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -625,7 +627,7 @@ dco_set_peer(dco_context_t *dco, unsigned int peerid,
                 keepalive_timeout);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -706,7 +708,7 @@ ovpn_get_mcast_id(dco_context_t *dco)
     int ret = -EMSGSIZE;
     NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_NL_NAME);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, dco, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -819,18 +821,180 @@ dco_do_read(dco_context_t *dco)
     return ovpn_nl_recvmsgs(dco, __func__);
 }
 
+static void
+dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)
+{
+    if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES])
+    {
+        c2->dco_read_bytes = nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES]);
+        msg(D_DCO_DEBUG, "%s / dco_read_bytes: %lu", __func__,
+            c2->dco_read_bytes);
+    }
+    else
+    {
+        msg(M_WARN, "%s: no link RX bytes provided in reply for peer %u",
+            __func__, id);
+    }
+
+    if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES])
+    {
+        c2->dco_write_bytes = nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES]);
+        msg(D_DCO_DEBUG, "%s / dco_write_bytes: %lu", __func__,
+            c2->dco_write_bytes);
+    }
+    else
+    {
+        msg(M_WARN, "%s: no link TX bytes provided in reply for peer %u",
+            __func__, id);
+    }
+
+    if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES])
+    {
+        c2->tun_read_bytes = nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES]);
+        msg(D_DCO_DEBUG, "%s / tun_read_bytes: %lu", __func__,
+            c2->tun_read_bytes);
+    }
+    else
+    {
+        msg(M_WARN, "%s: no VPN RX bytes provided in reply for peer %u",
+            __func__, id);
+    }
+
+    if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES])
+    {
+        c2->tun_write_bytes = nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES]);
+        msg(D_DCO_DEBUG, "%s / tun_write_bytes: %lu", __func__,
+            c2->tun_write_bytes);
+    }
+    else
+    {
+        msg(M_WARN, "%s: no VPN TX bytes provided in reply for peer %u",
+            __func__, id);
+    }
+}
+
+int
+dco_parse_peer_multi(struct nl_msg *msg, void *arg)
+{
+    struct nlattr *tb[OVPN_ATTR_MAX + 1];
+    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+
+    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
+
+    nla_parse(tb, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+              genlmsg_attrlen(gnlh, 0), NULL);
+
+    if (!tb[OVPN_ATTR_GET_PEER])
+    {
+        return NL_SKIP;
+    }
+
+    struct nlattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];
+
+    nla_parse(tb_peer, OVPN_GET_PEER_RESP_ATTR_MAX,
+              nla_data(tb[OVPN_ATTR_GET_PEER]),
+              nla_len(tb[OVPN_ATTR_GET_PEER]), NULL);
+
+    if (!tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])
+    {
+        msg(M_WARN, "%s: no peer-id provided in reply", __func__);
+        return NL_SKIP;
+    }
+
+    struct multi_context *m = arg;
+    uint32_t peer_id = nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID]);
+    if (peer_id >= m->max_clients)
+    {
+        msg(M_WARN, "%s: cannot retrieve stats for peer %u. ID is invalid (out of bound)!",
+            __func__, peer_id);
+        return NL_SKIP;
+    }
+
+    struct multi_instance *mi = m->instances[peer_id];
+    if (!mi)
+    {
+        msg(D_DCO_DEBUG, "%s: peer %d returned by kernel, but not found locally",
+            __func__, peer_id);
+        return NL_SKIP;
+    }
+
+    dco_update_peer_stat(&mi->context.c2, tb_peer, peer_id);
+
+    return NL_OK;
+}
+
 int
 dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
 {
-    /* Not implemented. */
-    return 0;
+    msg(D_DCO_DEBUG, "%s", __func__);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER);
+
+    nlmsg_hdr(nl_msg)->nlmsg_flags |= NLM_F_DUMP;
+
+    return ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __func__);
+}
+
+static int
+dco_parse_peer(struct nl_msg *msg, void *arg)
+{
+    struct context *c = arg;
+    struct nlattr *tb[OVPN_ATTR_MAX + 1];
+    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+
+    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
+
+    nla_parse(tb, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+              genlmsg_attrlen(gnlh, 0), NULL);
+
+    if (!tb[OVPN_ATTR_GET_PEER])
+    {
+        msg(D_DCO_DEBUG, "%s: malformed reply", __func__);
+        return NL_SKIP;
+    }
+
+    struct nlattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];
+
+    nla_parse(tb_peer, OVPN_GET_PEER_RESP_ATTR_MAX,
+              nla_data(tb[OVPN_ATTR_GET_PEER]),
+              nla_len(tb[OVPN_ATTR_GET_PEER]), NULL);
+
+    if (!tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])
+    {
+        msg(M_WARN, "%s: no peer-id provided in reply", __func__);
+        return NL_SKIP;
+    }
+
+    uint32_t peer_id = nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID]);
+    if (c->c2.tls_multi->dco_peer_id != peer_id)
+    {
+        return NL_SKIP;
+    }
+
+    dco_update_peer_stat(&c->c2, tb_peer, peer_id);
+
+    return NL_OK;
 }
 
 int
 dco_get_peer_stats(struct context *c)
 {
-    /* Not implemented. */
-    return 0;
+    uint32_t peer_id = c->c2.tls_multi->dco_peer_id;
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
+
+    dco_context_t *dco = &c->c1.tuntap->dco;
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER);
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_GET_PEER);
+    int ret = -EMSGSIZE;
+
+    NLA_PUT_U32(nl_msg, OVPN_GET_PEER_ATTR_PEER_ID, peer_id);
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer, c, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
 }
 
 bool
diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h
index d3fd9a89..73e19b59 100644
--- a/src/openvpn/ovpn_dco_linux.h
+++ b/src/openvpn/ovpn_dco_linux.h
@@ -2,7 +2,7 @@
 /*
  *  OpenVPN data channel accelerator
  *
- *  Copyright (C) 2019-2022 OpenVPN, Inc.
+ *  Copyright (C) 2019-2023 OpenVPN, Inc.
  *
  *  Author:	James Yonan <james@...515...>
  *		Antonio Quartulli <antonio@...515...>
@@ -188,10 +188,14 @@ enum ovpn_netlink_get_peer_response_attrs {
 	OVPN_GET_PEER_RESP_ATTR_LOCAL_PORT,
 	OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_INTERVAL,
 	OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_TIMEOUT,
-	OVPN_GET_PEER_RESP_ATTR_RX_BYTES,
-	OVPN_GET_PEER_RESP_ATTR_TX_BYTES,
-	OVPN_GET_PEER_RESP_ATTR_RX_PACKETS,
-	OVPN_GET_PEER_RESP_ATTR_TX_PACKETS,
+	OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES,
+	OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES,
+	OVPN_GET_PEER_RESP_ATTR_VPN_RX_PACKETS,
+	OVPN_GET_PEER_RESP_ATTR_VPN_TX_PACKETS,
+	OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES,
+	OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES,
+	OVPN_GET_PEER_RESP_ATTR_LINK_RX_PACKETS,
+	OVPN_GET_PEER_RESP_ATTR_LINK_TX_PACKETS,
 
 	__OVPN_GET_PEER_RESP_ATTR_AFTER_LAST,
 	OVPN_GET_PEER_RESP_ATTR_MAX = __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST - 1,
-- 
2.39.2


