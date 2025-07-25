From: Gert Doering <gert@...1296...>
Date: Fri, 25 Jul 2025 19:27:02 +0200
Message-ID: <20250725172708.19456-1-gert@...1296...>
In-Reply-To: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
References: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] dco_linux: fix async message reception
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

Currently whenever we send a PEER_GET request to ovpn, we also
set the CB that is supposed to parse the reply.

However, due to the async nature of netlink messages, we could
get an unrelated notification, sent by ovpn upon some event,
after having set the CB, but before parsing the awaited reply.

When this happens, the notification is then parsed with the
configured CB instead of the notification parser, thus effectively
rejecting the notification and losing the event.

To fix this inconsistency, make ovpn_handle_msg() the default and
only netlink parser CB. It is configured upon DCO initialization
and is never removed.

ovpn_handle_msg() will check the message type and will call the
according parser. This way, no matter what message we get at
what time, but we'll always parse it correctly.

As a bonus we can also simplify the nl_sendmsg() API as we
don't need to pass the cb and its argument anymore.

The ID of the NLCTRL family is now also stored in the DCO
context as we need it to check when we receive a mcast ID
lookup message.

Change-Id: I23ad79e14844aefde9ece34dadef0b75ff267201
Github: OpenVPN/openvpn#793
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1100
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 7c639d9..728fb7e 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -167,23 +167,19 @@
 }
 
 /**
- * Send a prepared netlink message and registers cb as callback if non-null.
+ * Send a prepared netlink message.
  *
  * The method will also free nl_msg
  * @param dco       The dco context to use
  * @param nl_msg    the message to use
- * @param cb        An optional callback if the caller expects an answer
- * @param cb_arg    An optional param to pass to the callback
  * @param prefix    A prefix to report in the error message to give the user context
  * @return          status of sending the message
  */
 static int
-ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb cb,
-                 void *cb_arg, const char *prefix)
+ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, const char *prefix)
 {
     dco->status = 1;
 
-    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, cb_arg);
     nl_send_auto(dco->nl_sock, nl_msg);
 
     while (dco->status == 1)
@@ -285,7 +281,7 @@
     }
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -385,6 +381,29 @@
 }
 
 static void
+ovpn_dco_register(dco_context_t *dco)
+{
+    msg(D_DCO_DEBUG, __func__);
+    ovpn_get_mcast_id(dco);
+
+    if (dco->ovpn_dco_mcast_id < 0)
+    {
+        msg(M_FATAL, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_dco_mcast_id));
+    }
+
+    /* Register for ovpn-dco specific multicast messages that the kernel may
+     * send
+     */
+    int ret = nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast_id);
+    if (ret)
+    {
+        msg(M_FATAL, "%s: failed to join groups: %d", __func__, ret);
+    }
+}
+
+static int ovpn_handle_msg(struct nl_msg *msg, void *arg);
+
+static void
 ovpn_dco_init_netlink(dco_context_t *dco)
 {
     dco->ovpn_dco_id = resolve_ovpn_netlink_id(M_FATAL);
@@ -420,11 +439,15 @@
 
     nl_socket_set_cb(dco->nl_sock, dco->nl_cb);
 
+    dco->dco_message_peer_id = -1;
     nl_cb_err(dco->nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_FINISH, NL_CB_CUSTOM, ovpn_nl_cb_finish,
               &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish,
               &dco->status);
+    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
+
+    ovpn_dco_register(dco);
 
     /* The async PACKET messages confuse libnl and it will drop them with
      * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libnl's sequence
@@ -476,27 +499,6 @@
     CLEAR(dco);
 }
 
-static void
-ovpn_dco_register(dco_context_t *dco)
-{
-    msg(D_DCO_DEBUG, __func__);
-    ovpn_get_mcast_id(dco);
-
-    if (dco->ovpn_dco_mcast_id < 0)
-    {
-        msg(M_FATAL, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_dco_mcast_id));
-    }
-
-    /* Register for ovpn-dco specific multicast messages that the kernel may
-     * send
-     */
-    int ret = nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast_id);
-    if (ret)
-    {
-        msg(M_FATAL, "%s: failed to join groups: %d", __func__, ret);
-    }
-}
-
 int
 open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
 {
@@ -516,10 +518,6 @@
         msg(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev);
     }
 
-    tt->dco.dco_message_peer_id = -1;
-
-    ovpn_dco_register(&tt->dco);
-
     return 0;
 }
 
@@ -548,7 +546,7 @@
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -572,7 +570,7 @@
     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -598,7 +596,7 @@
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);
     nla_nest_end(nl_msg, keyconf);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -657,7 +655,7 @@
     nla_nest_end(nl_msg, key_conf);
 
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -686,7 +684,7 @@
                 keepalive_timeout);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -754,7 +752,7 @@
 
     /* Even though 'nlctrl' is a constant, there seem to be no library
      * provided define for it */
-    int ctrlid = genl_ctrl_resolve(dco->nl_sock, "nlctrl");
+    dco->ctrlid = genl_ctrl_resolve(dco->nl_sock, "nlctrl");
 
     struct nl_msg *nl_msg = nlmsg_alloc();
     if (!nl_msg)
@@ -762,12 +760,12 @@
         return -ENOMEM;
     }
 
-    genlmsg_put(nl_msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);
+    genlmsg_put(nl_msg, 0, 0, dco->ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);
 
     int ret = -EMSGSIZE;
     NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_FAMILY_NAME);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, dco, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -879,31 +877,34 @@
 }
 
 static int
-dco_parse_peer_multi(struct nl_msg *msg, void *arg)
+ovpn_handle_peer_multi(dco_context_t *dco, struct nlattr *attrs[])
 {
-    struct nlattr *tb[OVPN_A_MAX + 1];
-    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
-
     msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
 
-    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
-              genlmsg_attrlen(gnlh, 0), NULL);
+    /* this function assumes openvpn is running in multipeer mode as
+     * it accesses c->multi
+     */
+    if (dco->ifmode != OVPN_MODE_MP)
+    {
+        msg(M_WARN, "%s: can't parse 'multi-peer' message on P2P instance", __func__);
+        return NL_SKIP;
+    }
 
-    if (!tb[OVPN_A_PEER])
+    if (!attrs[OVPN_A_PEER])
     {
         return NL_SKIP;
     }
 
     struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];
-    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);
+    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NULL);
 
     if (!tb_peer[OVPN_A_PEER_ID])
     {
-        msg(M_WARN, "%s: no peer-id provided in reply", __func__);
+        msg(M_WARN, "ovpn-dco: no peer-id provided in (MULTI) PEER_GET reply");
         return NL_SKIP;
     }
 
-    struct multi_context *m = arg;
+    struct multi_context *m = dco->c->multi;
     uint32_t peer_id = nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
 
     if (peer_id >= m->max_clients || !m->instances[peer_id])
@@ -919,39 +920,53 @@
 }
 
 static int
-dco_parse_peer(struct nl_msg *msg, void *arg)
+ovpn_handle_peer(dco_context_t *dco, struct nlattr *attrs[])
 {
-    struct context *c = arg;
-    struct nlattr *tb[OVPN_A_MAX + 1];
-    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
-
     msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
 
-    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
-              genlmsg_attrlen(gnlh, 0), NULL);
-
-    if (!tb[OVPN_A_PEER])
+    if (!attrs[OVPN_A_PEER])
     {
         msg(D_DCO_DEBUG, "%s: malformed reply", __func__);
         return NL_SKIP;
     }
 
     struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];
-    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);
+    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NULL);
 
     if (!tb_peer[OVPN_A_PEER_ID])
     {
-        msg(M_WARN, "%s: no peer-id provided in reply", __func__);
+        msg(M_WARN, "ovpn-dco: no peer-id provided in PEER_GET reply");
         return NL_SKIP;
     }
 
     uint32_t peer_id = nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
-    if (c->c2.tls_multi->dco_peer_id != peer_id)
+    struct context_2 *c2;
+
+    if (dco->ifmode == OVPN_MODE_P2P)
+    {
+        c2 = &dco->c->c2;
+    }
+    else
+    {
+        struct multi_instance *mi = dco->c->multi->instances[peer_id];
+        if (!mi)
+        {
+            msg(M_WARN, "%s: received data for a non-existing peer %u", __func__, peer_id);
+            return NL_SKIP;
+        }
+
+        c2 = &mi->context.c2;
+    }
+
+    /* at this point this check should never fail for MP mode,
+     * but it's still fully valid for P2P mode
+     */
+    if (c2->tls_multi->dco_peer_id != peer_id)
     {
         return NL_SKIP;
     }
 
-    dco_update_peer_stat(&c->c2, tb_peer, peer_id);
+    dco_update_peer_stat(c2, tb_peer, peer_id);
 
     return NL_OK;
 }
@@ -1120,9 +1135,22 @@
 {
     dco_context_t *dco = arg;
 
-    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
     struct nlattr *attrs[OVPN_A_MAX + 1];
     struct nlmsghdr *nlh = nlmsg_hdr(msg);
+    struct genlmsghdr *gnlh = genlmsg_hdr(nlh);
+
+    msg(D_DCO_DEBUG, "ovpn-dco: received netlink message type=%u cmd=%u flags=%#.4x",
+        nlh->nlmsg_type, gnlh->cmd, nlh->nlmsg_flags);
+
+    /* if we get a message from the NLCTRL family, it means
+     * this is the reply to the mcast ID resolution request
+     * and we parse it accordingly.
+     */
+    if (nlh->nlmsg_type == dco->ctrlid)
+    {
+        msg(D_DCO_DEBUG, "ovpn-dco: received CTRLID message");
+        return mcast_family_handler(msg, dco);
+    }
 
     if (!genlmsg_valid_hdr(nlh, 0))
     {
@@ -1146,6 +1174,21 @@
      */
     switch (gnlh->cmd)
     {
+        case OVPN_CMD_PEER_GET:
+        {
+            /* this message is part of a peer list dump, hence triggered
+             * by a MP/server instance
+             */
+            if (nlh->nlmsg_flags & NLM_F_MULTI)
+            {
+                return ovpn_handle_peer_multi(dco, attrs);
+            }
+            else
+            {
+                return ovpn_handle_peer(dco, attrs);
+            }
+        }
+
         case OVPN_CMD_PEER_DEL_NTF:
         {
             return ovpn_handle_peer_del_ntf(dco, attrs);
@@ -1174,7 +1217,6 @@
 dco_do_read(dco_context_t *dco)
 {
     msg(D_DCO_DEBUG, __func__);
-    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
 
     return ovpn_nl_recvmsgs(dco, __func__);
 }
@@ -1189,7 +1231,7 @@
 
     nlmsg_hdr(nl_msg)->nlmsg_flags |= NLM_F_DUMP;
 
-    int ret = ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __func__);
+    int ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
     nlmsg_free(nl_msg);
 
@@ -1227,7 +1269,7 @@
     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer, c, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 5e61cf1..cc14f45 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -66,6 +66,7 @@
     int status;
 
     struct context *c;
+    int ctrlid;
 
     enum ovpn_mode ifmode;
 

