From: Gert Doering <gert@...1296...>
Date: Tue, 21 Apr 2026 10:49:01 +0200
Message-ID: <20260421084906.5720-1-gert@...1296...>
In-Reply-To: <gerrit.1776701747000.I92c5f74a27b40fede204f714b042a6cc80b3703e@...2715...>
References: <gerrit.1776701747000.I92c5f74a27b40fede204f714b042a6cc80b3703e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco: backport immediate notification
 processing on Linux and FreeBSD
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

From: Ralf Lici <ralf@...2726...>

Backport the immediate DCO message processing model from commit 7791f53
("dco: process messages immediately after read").

Change the core DCO API from dco_do_read() to dco_read_and_process(),
and make the backend read paths own the parsing and immediate handling
of kernel notifications before handing the resulting state to
process_incoming_dco() or multi_process_incoming_dco().

On Linux, install a permanent netlink callback and process GET_PEER and
DEL_PEER messages as they are received, instead of switching callbacks
for each read and deferring handling through shared DCO message state.
Also add a small guard to avoid requesting peer stats while libnl is
still parsing a batch of notifications.

On FreeBSD, move notification handling into dco_read_and_process() and
update peer statistics directly from the backend instead of storing
temporary byte counters in dco_context_t.

This commit is part of a reworked backport of PR #945 originally
proposed by Nikolai Shelekhov <nickshv13@...2314...>.

Change-Id: I92c5f74a27b40fede204f714b042a6cc80b3703e
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1632
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1632
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 334d468..3a36ddc 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -128,12 +128,13 @@
 void close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 /**
- * Read data from the DCO communication channel (i.e. a control packet)
+ * Read and process data from the DCO communication channel
+ * (i.e. a control packet)
  *
  * @param dco       the DCO context
  * @return          0 on success or a negative error code otherwise
  */
-int dco_do_read(dco_context_t *dco);
+int dco_read_and_process(dco_context_t *dco);
 
 /**
  * Install a DCO in the main event loop
@@ -300,7 +301,7 @@
 }
 
 static inline int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     ASSERT(false);
     return 0;
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index b164bd3..9384bf1 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -560,8 +560,23 @@
     return ret;
 }
 
+static void
+dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)
+{
+    if (peerid >= m->max_clients || !m->instances[peerid])
+    {
+        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %d returned by kernel", peerid);
+        return;
+    }
+
+    struct multi_instance *mi = m->instances[peerid];
+
+    mi->context.c2.dco_read_bytes = nvlist_get_number(nvl, "in");
+    mi->context.c2.dco_write_bytes = nvlist_get_number(nvl, "out");
+}
+
 int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     struct ifdrv drv;
     uint8_t buf[4096];
@@ -592,9 +607,13 @@
         return -EINVAL;
     }
 
-    dco->dco_message_peer_id = nvlist_get_number(nvl, "peerid");
+    /* dco_message_peer_id is signed int, because other parts of the
+     * code treat "-1" as "this is a message not specific to one peer"
+     */
+    dco->dco_message_peer_id = (int)nvlist_get_number(nvl, "peerid");
 
-    type = nvlist_get_number(nvl, "notification");
+    type = (enum ovpn_notif_type)nvlist_get_number(nvl, "notification");
+
     switch (type)
     {
         case OVPN_NOTIF_DEL_PEER:
@@ -617,8 +636,15 @@
             {
                 const nvlist_t *bytes = nvlist_get_nvlist(nvl, "bytes");
 
-                dco->dco_read_bytes = nvlist_get_number(bytes, "in");
-                dco->dco_write_bytes = nvlist_get_number(bytes, "out");
+                if (dco->c->mode == CM_TOP)
+                {
+                    dco_update_peer_stat(dco->c->multi, dco->dco_message_peer_id, bytes);
+                }
+                else
+                {
+                    dco->c->c2.dco_read_bytes = nvlist_get_number(bytes, "in");
+                    dco->c->c2.dco_write_bytes = nvlist_get_number(bytes, "out");
+                }
             }
 
             dco->dco_message_type = OVPN_CMD_DEL_PEER;
@@ -628,7 +654,8 @@
             dco->dco_message_type = OVPN_CMD_SWAP_KEYS;
             break;
 
-        case OVPN_NOTIF_FLOAT: {
+        case OVPN_NOTIF_FLOAT:
+        {
             const nvlist_t *address;
 
             if (!nvlist_exists_nvlist(nvl, "address"))
@@ -649,11 +676,21 @@
 
         default:
             msg(M_WARN, "Unknown kernel notification %d", type);
+            dco->dco_message_type = OVPN_CMD_NO_MESSAGE;
             break;
     }
 
     nvlist_destroy(nvl);
 
+    if (dco->c->mode == CM_TOP)
+    {
+        multi_process_incoming_dco(dco);
+    }
+    else
+    {
+        process_incoming_dco(dco);
+    }
+
     return 0;
 }
 
@@ -773,26 +810,9 @@
     nvlist_destroy(nvl);
 }
 
-static void
-dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)
-{
-
-    if (peerid >= m->max_clients || !m->instances[peerid])
-    {
-        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %d returned by kernel", peerid);
-        return;
-    }
-
-    struct multi_instance *mi = m->instances[peerid];
-
-    mi->context.c2.dco_read_bytes = nvlist_get_number(nvl, "in");
-    mi->context.c2.dco_write_bytes = nvlist_get_number(nvl, "out");
-}
-
 int
 dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
 {
-
     struct ifdrv drv;
     uint8_t *buf = NULL;
     size_t buf_size = 4096;
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index e8f723e..d2cc045 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -33,6 +33,8 @@
 typedef enum ovpn_key_cipher dco_cipher_t;
 
 enum ovpn_message_type_t {
+    /* message type #0 is treated as magic number by process_incoming_dco() */
+    OVPN_CMD_NO_MESSAGE = 0,
     OVPN_CMD_DEL_PEER,
     OVPN_CMD_PACKET,
     OVPN_CMD_SWAP_KEYS,
@@ -57,9 +59,8 @@
     int dco_message_peer_id;
     int dco_del_peer_reason;
     struct sockaddr_storage dco_float_peer_ss;
+
     struct context *c;
-    uint64_t dco_read_bytes;
-    uint64_t dco_write_bytes;
 } dco_context_t;
 
 #endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 493fce6..8ce7026 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -50,6 +50,15 @@
 #include <netlink/genl/family.h>
 #include <netlink/genl/ctrl.h>
 
+/* When parsing multiple DEL_PEER notifications, openvpn tries to request stats
+ * for each DEL_PEER message (see setenv_stats). This triggers a GET_PEER
+ * request-reply while we are still parsing the rest of the initial
+ * notifications, which can lead to NLE_BUSY or even NLE_NOMEM.
+ *
+ * This basic lock ensures we don't bite our own tail by issuing a dco_get_peer
+ * while still busy receiving and parsing other messages.
+ */
+static bool __is_locked = false;
 
 /* libnl < 3.5.0 does not set the NLA_F_NESTED on its own, therefore we
  * have to explicitly do it to prevent the kernel from failing upon
@@ -62,8 +71,6 @@
 
 void dco_check_key_ctx(const struct key_ctx_bi *key);
 
-typedef int (*ovpn_nl_cb)(struct nl_msg *msg, void *arg);
-
 /**
  * @brief resolves the netlink ID for ovpn-dco
  *
@@ -131,7 +138,9 @@
 static int
 ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
 {
+    __is_locked = true;
     int ret = nl_recvmsgs(dco->nl_sock, dco->nl_cb);
+    __is_locked = false;
 
     switch (ret)
     {
@@ -167,23 +176,19 @@
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
@@ -274,7 +279,7 @@
     }
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -342,6 +347,8 @@
     return NL_STOP;
 }
 
+static int ovpn_handle_msg(struct nl_msg *msg, void *arg);
+
 static void
 ovpn_dco_init_netlink(dco_context_t *dco)
 {
@@ -373,11 +380,13 @@
 
     nl_socket_set_cb(dco->nl_sock, dco->nl_cb);
 
+    dco->dco_message_peer_id = -1;
     nl_cb_err(dco->nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_FINISH, NL_CB_CUSTOM, ovpn_nl_cb_finish,
               &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish,
               &dco->status);
+    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
 
     /* The async PACKET messages confuse libnl and it will drop them with
      * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libnl's sequence
@@ -501,7 +510,7 @@
     NLA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -525,7 +534,7 @@
     NLA_PUT_U32(nl_msg, OVPN_DEL_PEER_ATTR_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -551,7 +560,7 @@
     NLA_PUT_U8(nl_msg, OVPN_DEL_KEY_ATTR_KEY_SLOT, slot);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -608,7 +617,7 @@
 
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -637,7 +646,7 @@
                 keepalive_timeout);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -705,7 +714,7 @@
 
     /* Even though 'nlctrl' is a constant, there seem to be no library
      * provided define for it */
-    int ctrlid = genl_ctrl_resolve(dco->nl_sock, "nlctrl");
+    dco->ctrlid = genl_ctrl_resolve(dco->nl_sock, "nlctrl");
 
     struct nl_msg *nl_msg = nlmsg_alloc();
     if (!nl_msg)
@@ -713,12 +722,12 @@
         return -ENOMEM;
     }
 
-    genlmsg_put(nl_msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);
+    genlmsg_put(nl_msg, 0, 0, dco->ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);
 
     int ret = -EMSGSIZE;
     NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_NL_NAME);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, dco, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -726,108 +735,10 @@
 }
 
 /* This function parses any netlink message sent by ovpn-dco to userspace */
-static int
-ovpn_handle_msg(struct nl_msg *msg, void *arg)
-{
-    dco_context_t *dco = arg;
-
-    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
-    struct nlattr *attrs[OVPN_ATTR_MAX + 1];
-    struct nlmsghdr *nlh = nlmsg_hdr(msg);
-
-    if (!genlmsg_valid_hdr(nlh, 0))
-    {
-        msg(D_DCO, "ovpn-dco: invalid header");
-        return NL_SKIP;
-    }
-
-    if (nla_parse(attrs, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
-                  genlmsg_attrlen(gnlh, 0), NULL))
-    {
-        msg(D_DCO, "received bogus data from ovpn-dco");
-        return NL_SKIP;
-    }
-
-    /* we must know which interface this message is referring to in order to
-     * avoid mixing messages for other instances
-     */
-    if (!attrs[OVPN_ATTR_IFINDEX])
-    {
-        msg(D_DCO, "ovpn-dco: Received message without ifindex");
-        return NL_SKIP;
-    }
-
-    uint32_t ifindex = nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
-    if (ifindex != dco->ifindex)
-    {
-        msg(D_DCO_DEBUG,
-            "ovpn-dco: ignoring message (type=%d) for foreign ifindex %d",
-            gnlh->cmd, ifindex);
-        return NL_SKIP;
-    }
-
-    /* based on the message type, we parse the subobject contained in the
-     * message, that stores the type-specific attributes.
-     *
-     * the "dco" object is then filled accordingly with the information
-     * retrieved from the message, so that the rest of the OpenVPN code can
-     * react as need be.
-     */
-    switch (gnlh->cmd)
-    {
-        case OVPN_CMD_DEL_PEER:
-        {
-            if (!attrs[OVPN_ATTR_DEL_PEER])
-            {
-                msg(D_DCO, "ovpn-dco: no attributes in OVPN_DEL_PEER message");
-                return NL_SKIP;
-            }
-
-            struct nlattr *dp_attrs[OVPN_DEL_PEER_ATTR_MAX + 1];
-            if (nla_parse_nested(dp_attrs, OVPN_DEL_PEER_ATTR_MAX,
-                                 attrs[OVPN_ATTR_DEL_PEER], NULL))
-            {
-                msg(D_DCO, "received bogus del peer packet data from ovpn-dco");
-                return NL_SKIP;
-            }
-
-            if (!dp_attrs[OVPN_DEL_PEER_ATTR_REASON])
-            {
-                msg(D_DCO, "ovpn-dco: no reason in DEL_PEER message");
-                return NL_SKIP;
-            }
-            if (!dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])
-            {
-                msg(D_DCO, "ovpn-dco: no peer-id in DEL_PEER message");
-                return NL_SKIP;
-            }
-            int reason = nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_REASON]);
-            unsigned int peerid = nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID]);
-
-            msg(D_DCO_DEBUG, "ovpn-dco: received CMD_DEL_PEER, ifindex: %d, peer-id %d, reason: %d",
-                ifindex, peerid, reason);
-            dco->dco_message_peer_id = peerid;
-            dco->dco_del_peer_reason = reason;
-            dco->dco_message_type = OVPN_CMD_DEL_PEER;
-
-            break;
-        }
-
-        default:
-            msg(D_DCO, "ovpn-dco: received unknown command: %d", gnlh->cmd);
-            dco->dco_message_type = 0;
-            return NL_SKIP;
-    }
-
-    return NL_OK;
-}
-
 int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     msg(D_DCO_DEBUG, __func__);
-    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
-
     return ovpn_nl_recvmsgs(dco, __func__);
 }
 
@@ -883,27 +794,21 @@
     }
 }
 
-int
-dco_parse_peer_multi(struct nl_msg *msg, void *arg)
+static int
+ovpn_handle_peer(dco_context_t *dco, struct nlattr *attrs[])
 {
-    struct nlattr *tb[OVPN_ATTR_MAX + 1];
-    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+    struct nlattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];
+    struct context_2 *c2;
 
-    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
-
-    nla_parse(tb, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
-              genlmsg_attrlen(gnlh, 0), NULL);
-
-    if (!tb[OVPN_ATTR_GET_PEER])
+    if (!attrs[OVPN_ATTR_GET_PEER])
     {
+        msg(D_DCO_DEBUG, "%s: malformed reply", __func__);
         return NL_SKIP;
     }
 
-    struct nlattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];
-
     nla_parse(tb_peer, OVPN_GET_PEER_RESP_ATTR_MAX,
-              nla_data(tb[OVPN_ATTR_GET_PEER]),
-              nla_len(tb[OVPN_ATTR_GET_PEER]), NULL);
+              nla_data(attrs[OVPN_ATTR_GET_PEER]),
+              nla_len(attrs[OVPN_ATTR_GET_PEER]), NULL);
 
     if (!tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])
     {
@@ -911,17 +816,180 @@
         return NL_SKIP;
     }
 
-    struct multi_context *m = arg;
     uint32_t peer_id = nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID]);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: parsing message for peer %u...",
+        __func__, peer_id);
 
-    if (peer_id >= m->max_clients || !m->instances[peer_id])
+    if (dco->ifmode == OVPN_MODE_P2P)
     {
-        msg(M_WARN, "%s: cannot store DCO stats for peer %u", __func__,
-            peer_id);
+        c2 = &dco->c->c2;
+        if (c2->tls_multi->dco_peer_id != (int)peer_id)
+        {
+            return NL_SKIP;
+        }
+    }
+    else
+    {
+        if (peer_id >= dco->c->multi->max_clients)
+        {
+            msg(M_WARN, "%s: received out of bound peer_id %u (max=%u)",
+                __func__, peer_id, dco->c->multi->max_clients);
+            return NL_SKIP;
+        }
+
+        struct multi_instance *mi = dco->c->multi->instances[peer_id];
+        if (!mi)
+        {
+            msg(M_WARN | M_NOIPREFIX,
+                "%s: received data for a non-existing peer %u",
+                __func__, peer_id);
+            return NL_SKIP;
+        }
+
+        c2 = &mi->context.c2;
+    }
+
+    dco_update_peer_stat(c2, tb_peer, peer_id);
+
+    return NL_OK;
+}
+
+static int
+ovpn_handle_del_peer(dco_context_t *dco, struct nlattr *attrs[])
+{
+    if (!attrs[OVPN_ATTR_DEL_PEER])
+    {
+        msg(D_DCO, "ovpn-dco: no attributes in OVPN_DEL_PEER message");
+        return NL_STOP;
+    }
+
+    struct nlattr *dp_attrs[OVPN_DEL_PEER_ATTR_MAX + 1];
+    if (nla_parse_nested(dp_attrs, OVPN_DEL_PEER_ATTR_MAX,
+                         attrs[OVPN_ATTR_DEL_PEER], NULL))
+    {
+        msg(D_DCO, "received bogus del peer packet data from ovpn-dco");
+        return NL_STOP;
+    }
+
+    if (!dp_attrs[OVPN_DEL_PEER_ATTR_REASON])
+    {
+        msg(D_DCO, "ovpn-dco: no reason in DEL_PEER message");
+        return NL_STOP;
+    }
+    if (!dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])
+    {
+        msg(D_DCO, "ovpn-dco: no peer-id in DEL_PEER message");
+        return NL_STOP;
+    }
+
+    int reason = nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_REASON]);
+    unsigned int peerid = nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID]);
+
+    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_DEL_PEER, ifindex: %d, peer-id %d, reason: %d",
+        dco->ifindex, peerid, reason);
+    dco->dco_message_peer_id = peerid;
+    dco->dco_del_peer_reason = reason;
+    dco->dco_message_type = OVPN_CMD_DEL_PEER;
+
+    return NL_OK;
+}
+
+static int
+ovpn_handle_msg(struct nl_msg *msg, void *arg)
+{
+    dco_context_t *dco = arg;
+
+    struct nlmsghdr *nlh = nlmsg_hdr(msg);
+    struct genlmsghdr *gnlh = genlmsg_hdr(nlh);
+    struct nlattr *attrs[OVPN_ATTR_MAX + 1];
+
+    msg(D_DCO_DEBUG | M_NOIPREFIX,
+        "ovpn-dco: received netlink message type=%u cmd=%u flags=%#.4x",
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
+
+    if (!genlmsg_valid_hdr(nlh, 0))
+    {
+        msg(D_DCO, "ovpn-dco: invalid header");
+        return NL_STOP;
+    }
+
+    if (nla_parse(attrs, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+                  genlmsg_attrlen(gnlh, 0), NULL))
+    {
+        msg(D_DCO, "received bogus data from ovpn-dco");
+        return NL_STOP;
+    }
+
+    /* we must know which interface this message is referring to in order to
+     * avoid mixing messages for other instances
+     */
+    if (!attrs[OVPN_ATTR_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return NL_STOP;
+    }
+
+    uint32_t ifindex = nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
+    if (ifindex != dco->ifindex)
+    {
+        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex %d",
+            ifindex);
         return NL_SKIP;
     }
 
-    dco_update_peer_stat(&m->instances[peer_id]->context.c2, tb_peer, peer_id);
+    /* based on the message type, we parse the subobject contained in the
+     * message, that stores the type-specific attributes.
+     *
+     * the "dco" object is then filled accordingly with the information
+     * retrieved from the message, so that *process_incoming_dco can react
+     * as need be.
+     */
+    int ret;
+    switch (gnlh->cmd)
+    {
+        case OVPN_CMD_GET_PEER:
+        {
+            /* return directly, there are no messages to pass to
+             * *process_incoming_dco()
+             */
+            return ovpn_handle_peer(dco, attrs);
+        }
+
+        case OVPN_CMD_DEL_PEER:
+        {
+            ret = ovpn_handle_del_peer(dco, attrs);
+            break;
+        }
+
+        default:
+            msg(D_DCO, "ovpn-dco: received unknown command: %d", gnlh->cmd);
+            dco->dco_message_type = 0;
+            return NL_STOP;
+    }
+
+    if (ret != NL_OK)
+    {
+        return ret;
+    }
+
+    if (dco->c->mode == CM_TOP)
+    {
+        multi_process_incoming_dco(dco);
+    }
+    else
+    {
+        process_incoming_dco(dco);
+    }
 
     return NL_OK;
 }
@@ -931,57 +999,29 @@
 {
     msg(D_DCO_DEBUG, "%s", __func__);
 
+    if (__is_locked)
+    {
+        msg(D_DCO_DEBUG, "%s: cannot request peer stats while parsing other messages",
+            __func__);
+        return 0;
+    }
+
+    ASSERT(dco->c->multi == m);
+
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
 
     nlmsg_hdr(nl_msg)->nlmsg_flags |= NLM_F_DUMP;
 
-    int ret = ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __func__);
+    int ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
     nlmsg_free(nl_msg);
     return ret;
 }
 
-static int
-dco_parse_peer(struct nl_msg *msg, void *arg)
-{
-    struct context *c = arg;
-    struct nlattr *tb[OVPN_ATTR_MAX + 1];
-    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
-
-    msg(D_DCO_DEBUG, "%s: parsing message...", __func__);
-
-    nla_parse(tb, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
-              genlmsg_attrlen(gnlh, 0), NULL);
-
-    if (!tb[OVPN_ATTR_GET_PEER])
-    {
-        msg(D_DCO_DEBUG, "%s: malformed reply", __func__);
-        return NL_SKIP;
-    }
-
-    struct nlattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];
-
-    nla_parse(tb_peer, OVPN_GET_PEER_RESP_ATTR_MAX,
-              nla_data(tb[OVPN_ATTR_GET_PEER]),
-              nla_len(tb[OVPN_ATTR_GET_PEER]), NULL);
-
-    if (!tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])
-    {
-        msg(M_WARN, "%s: no peer-id provided in reply", __func__);
-        return NL_SKIP;
-    }
-
-    uint32_t peer_id = nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID]);
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
 dco_get_peer_stats(struct context *c)
 {
@@ -993,6 +1033,13 @@
         return 0;
     }
 
+    if (__is_locked)
+    {
+        msg(D_DCO_DEBUG, "%s: cannot request peer stats while parsing other messages",
+            __func__);
+        return 0;
+    }
+
     dco_context_t *dco = &c->c1.tuntap->dco;
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER);
     struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_GET_PEER);
@@ -1001,7 +1048,7 @@
     NLA_PUT_U32(nl_msg, OVPN_GET_PEER_ATTR_PEER_ID, peer_id);
     nla_nest_end(nl_msg, attr);
 
-    ret = ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer, c, __func__);
+    ret = ovpn_nl_msg_send(dco, nl_msg, __func__);
 
 nla_put_failure:
     nlmsg_free(nl_msg);
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index cf6bdd4..9209915 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -44,6 +44,7 @@
     int status;
 
     struct context *c;
+    int ctrlid;
 
     enum ovpn_mode ifmode;
 
@@ -55,8 +56,6 @@
     int dco_message_type;
     int dco_message_peer_id;
     int dco_del_peer_reason;
-    uint64_t dco_read_bytes;
-    uint64_t dco_write_bytes;
 } dco_context_t;
 
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index bc465db..b11d506 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -423,7 +423,7 @@
 }
 
 int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     /* no-op on windows */
     ASSERT(0);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 4e9e739..e43ce28 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1269,13 +1269,11 @@
     }
 }
 
-static void
-process_incoming_dco(struct context *c)
+void
+process_incoming_dco(dco_context_t *dco)
 {
 #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
-    dco_context_t *dco = &c->c1.tuntap->dco;
-
-    dco_do_read(dco);
+    struct context *c = dco->c;
 
     /* FreeBSD currently sends us removal notifcation with the old peer-id in
      * p2p mode with the ping timeout reason, so ignore that one to not shoot
@@ -1291,6 +1289,8 @@
     switch (dco->dco_message_type)
     {
         case OVPN_CMD_DEL_PEER:
+            /* peer is gone, unset ID to prevent more kernel calls */
+            c->c2.tls_multi->dco_peer_id = -1;
             if (dco->dco_del_peer_reason == OVPN_DEL_PEER_REASON_EXPIRED)
             {
                 msg(D_DCO_DEBUG, "%s: received peer expired notification of for peer-id "
@@ -2344,7 +2344,7 @@
     {
         if (!IS_SIG(c))
         {
-            process_incoming_dco(c);
+            dco_read_and_process(&c->c1.tuntap->dco);
         }
     }
 }
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 3d0abd5..1de2aa2 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -50,6 +50,7 @@
 #include "openvpn.h"
 #include "occ.h"
 #include "ping.h"
+#include "dco.h"
 
 #define IOW_TO_TUN          (1<<0)
 #define IOW_TO_LINK         (1<<1)
@@ -248,6 +249,12 @@
  */
 void process_incoming_tun(struct context *c);
 
+/**
+ * Process an incoming DCO message (from kernel space).
+ *
+ * @param dco - Pointer to the structure representing the DCO context.
+ */
+void process_incoming_dco(dco_context_t *dco);
 
 /**
  * Write a packet to the virtual tun/tap network interface.
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 38c938e..b1714c8 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -747,7 +747,7 @@
             /* incoming data on DCO? */
             else if (e->arg == MTCP_DCO)
             {
-                multi_process_incoming_dco(m);
+                dco_read_and_process(&m->top.c1.tuntap->dco);
             }
 #endif
             /* signal received? */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 8cc717b..9a71eeb 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -409,11 +409,7 @@
     {
         if (!IS_SIG(&m->top))
         {
-            bool ret = true;
-            while (ret)
-            {
-                ret = multi_process_incoming_dco(m);
-            }
+            dco_read_and_process(&m->top.c1.tuntap->dco);
         }
     }
 #endif
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 69497a6..7620065 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3287,20 +3287,17 @@
      * installed, and we do not need to clean up the state in the kernel */
     mi->context.c2.tls_multi->dco_peer_id = -1;
     mi->context.sig->signal_text = reason;
-    mi->context.c2.dco_read_bytes = dco->dco_read_bytes;
-    mi->context.c2.dco_write_bytes = dco->dco_write_bytes;
     multi_signal_instance(m, mi, SIGTERM);
 }
 
-bool
-multi_process_incoming_dco(struct multi_context *m)
+void
+multi_process_incoming_dco(dco_context_t *dco)
 {
-    dco_context_t *dco = &m->top.c1.tuntap->dco;
+    ASSERT(dco->c->multi);
 
+    struct multi_context *m = dco->c->multi;
     struct multi_instance *mi = NULL;
 
-    int ret = dco_do_read(&m->top.c1.tuntap->dco);
-
     int peer_id = dco->dco_message_peer_id;
 
     /* no peer-specific message delivered -> nothing to process.
@@ -3308,7 +3305,7 @@
      */
     if (peer_id < 0)
     {
-        return ret > 0;
+        return;
     }
 
     if ((peer_id < m->max_clients) && (m->instances[peer_id]))
@@ -3355,13 +3352,6 @@
             "type %d, del_peer_reason %d", peer_id, dco->dco_message_type,
             dco->dco_del_peer_reason);
     }
-
-    dco->dco_message_type = 0;
-    dco->dco_message_peer_id = -1;
-    dco->dco_del_peer_reason = -1;
-    dco->dco_read_bytes = 0;
-    dco->dco_write_bytes = 0;
-    return ret > 0;
 }
 #endif /* if defined(ENABLE_DCO) && defined(TARGET_LINUX) */
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 7167639..1b784e1 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -317,13 +317,9 @@
 /**
  * Process an incoming DCO message (from kernel space).
  *
- * @param m            - The single \c multi_context structur.e
- *
- * @return
- *  - True, if the message was received correctly.
- *  - False, if there was an error while reading the message.
+ * @param dco - The DCO context containing the parsed message.
  */
-bool multi_process_incoming_dco(struct multi_context *m);
+void multi_process_incoming_dco(dco_context_t *dco);
 
 /**************************************************************************/
 /**

