From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 21 Apr 2026 14:22:06 +0000
In-Reply-To: <gerrit.1776701747000.I92c5f74a27b40fede204f714b042a6cc80b3703e@...2715...>
References: <gerrit.1776701747000.I92c5f74a27b40fede204f714b042a6cc80b3703e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <b69e7d13bf1ee6bfb9efb6c9b3be5da5ba3797de-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y9m7DFyQ0f4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[release/2.6]: dco: backport
 immediate notification processing on Linux and FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Y9m7DFyQ0f4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
32?usp=3Demail )

Change subject: dco: backport immediate notification processing on Linux an=
d FreeBSD
......................................................................

dco: backport immediate notification processing on Linux and FreeBSD

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

Github: OpenVPN/openvpn#900
Github: OpenVPN/openvpn#918
Github: OpenVPN/openvpn#931
Github: fixes OpenVPN/openvpn#919
Github: closes OpenVPN/openvpn#945

Change-Id: I92c5f74a27b40fede204f714b042a6cc80b3703e
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1632
Message-Id: <20260421084906.5720-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
707.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_freebsd.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
M src/openvpn/dco_win.c
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
12 files changed, 299 insertions(+), 242 deletions(-)




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
+dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlis=
t_t *nvl)
+{
+    if (peerid >=3D m->max_clients || !m->instances[peerid])
+    {
+        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %d returned by =
kernel", peerid);
+        return;
+    }
+
+    struct multi_instance *mi =3D m->instances[peerid];
+
+    mi->context.c2.dco_read_bytes =3D nvlist_get_number(nvl, "in");
+    mi->context.c2.dco_write_bytes =3D nvlist_get_number(nvl, "out");
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

-    dco->dco_message_peer_id =3D nvlist_get_number(nvl, "peerid");
+    /* dco_message_peer_id is signed int, because other parts of the
+     * code treat "-1" as "this is a message not specific to one peer"
+     */
+    dco->dco_message_peer_id =3D (int)nvlist_get_number(nvl, "peerid");

-    type =3D nvlist_get_number(nvl, "notification");
+    type =3D (enum ovpn_notif_type)nvlist_get_number(nvl, "notification");
+
     switch (type)
     {
         case OVPN_NOTIF_DEL_PEER:
@@ -617,8 +636,15 @@
             {
                 const nvlist_t *bytes =3D nvlist_get_nvlist(nvl, "bytes");

-                dco->dco_read_bytes =3D nvlist_get_number(bytes, "in");
-                dco->dco_write_bytes =3D nvlist_get_number(bytes, "out");
+                if (dco->c->mode =3D=3D CM_TOP)
+                {
+                    dco_update_peer_stat(dco->c->multi, dco->dco_message_p=
eer_id, bytes);
+                }
+                else
+                {
+                    dco->c->c2.dco_read_bytes =3D nvlist_get_number(bytes,=
 "in");
+                    dco->c->c2.dco_write_bytes =3D nvlist_get_number(bytes=
, "out");
+                }
             }

             dco->dco_message_type =3D OVPN_CMD_DEL_PEER;
@@ -628,7 +654,8 @@
             dco->dco_message_type =3D OVPN_CMD_SWAP_KEYS;
             break;

-        case OVPN_NOTIF_FLOAT: {
+        case OVPN_NOTIF_FLOAT:
+        {
             const nvlist_t *address;

             if (!nvlist_exists_nvlist(nvl, "address"))
@@ -649,11 +676,21 @@

         default:
             msg(M_WARN, "Unknown kernel notification %d", type);
+            dco->dco_message_type =3D OVPN_CMD_NO_MESSAGE;
             break;
     }

     nvlist_destroy(nvl);

+    if (dco->c->mode =3D=3D CM_TOP)
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
-dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlis=
t_t *nvl)
-{
-
-    if (peerid >=3D m->max_clients || !m->instances[peerid])
-    {
-        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %d returned by =
kernel", peerid);
-        return;
-    }
-
-    struct multi_instance *mi =3D m->instances[peerid];
-
-    mi->context.c2.dco_read_bytes =3D nvlist_get_number(nvl, "in");
-    mi->context.c2.dco_write_bytes =3D nvlist_get_number(nvl, "out");
-}
-
 int
 dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
 {
-
     struct ifdrv drv;
     uint8_t *buf =3D NULL;
     size_t buf_size =3D 4096;
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index e8f723e..d2cc045 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -33,6 +33,8 @@
 typedef enum ovpn_key_cipher dco_cipher_t;

 enum ovpn_message_type_t {
+    /* message type #0 is treated as magic number by process_incoming_dco(=
) */
+    OVPN_CMD_NO_MESSAGE =3D 0,
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

+/* When parsing multiple DEL_PEER notifications, openvpn tries to request =
stats
+ * for each DEL_PEER message (see setenv_stats). This triggers a GET_PEER
+ * request-reply while we are still parsing the rest of the initial
+ * notifications, which can lead to NLE_BUSY or even NLE_NOMEM.
+ *
+ * This basic lock ensures we don't bite our own tail by issuing a dco_get=
_peer
+ * while still busy receiving and parsing other messages.
+ */
+static bool __is_locked =3D false;

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
+    __is_locked =3D true;
     int ret =3D nl_recvmsgs(dco->nl_sock, dco->nl_cb);
+    __is_locked =3D false;

     switch (ret)
     {
@@ -167,23 +176,19 @@
 }

 /**
- * Send a prepared netlink message and registers cb as callback if non-nul=
l.
+ * Send a prepared netlink message.
  *
  * The method will also free nl_msg
  * @param dco       The dco context to use
  * @param nl_msg    the message to use
- * @param cb        An optional callback if the caller expects an answer
- * @param cb_arg    An optional param to pass to the callback
  * @param prefix    A prefix to report in the error message to give the us=
er context
  * @return          status of sending the message
  */
 static int
-ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb cb,
-                 void *cb_arg, const char *prefix)
+ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, const char *pr=
efix)
 {
     dco->status =3D 1;

-    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, cb_arg);
     nl_send_auto(dco->nl_sock, nl_msg);

     while (dco->status =3D=3D 1)
@@ -274,7 +279,7 @@
     }
     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

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

+    dco->dco_message_peer_id =3D -1;
     nl_cb_err(dco->nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_FINISH, NL_CB_CUSTOM, ovpn_nl_cb_finish,
               &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish,
               &dco->status);
+    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);

     /* The async PACKET messages confuse libnl and it will drop them with
      * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libnl's seque=
nce
@@ -501,7 +510,7 @@
     NLA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -525,7 +534,7 @@
     NLA_PUT_U32(nl_msg, OVPN_DEL_PEER_ATTR_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -551,7 +560,7 @@
     NLA_PUT_U8(nl_msg, OVPN_DEL_KEY_ATTR_KEY_SLOT, slot);
     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -608,7 +617,7 @@

     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -637,7 +646,7 @@
                 keepalive_timeout);
     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -705,7 +714,7 @@

     /* Even though 'nlctrl' is a constant, there seem to be no library
      * provided define for it */
-    int ctrlid =3D genl_ctrl_resolve(dco->nl_sock, "nlctrl");
+    dco->ctrlid =3D genl_ctrl_resolve(dco->nl_sock, "nlctrl");

     struct nl_msg *nl_msg =3D nlmsg_alloc();
     if (!nl_msg)
@@ -713,12 +722,12 @@
         return -ENOMEM;
     }

-    genlmsg_put(nl_msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);
+    genlmsg_put(nl_msg, 0, 0, dco->ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);

     int ret =3D -EMSGSIZE;
     NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_NL_NAME);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, dco, __fun=
c__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -726,108 +735,10 @@
 }

 /* This function parses any netlink message sent by ovpn-dco to userspace =
*/
-static int
-ovpn_handle_msg(struct nl_msg *msg, void *arg)
-{
-    dco_context_t *dco =3D arg;
-
-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
-    struct nlattr *attrs[OVPN_ATTR_MAX + 1];
-    struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
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
-    /* we must know which interface this message is referring to in order =
to
-     * avoid mixing messages for other instances
-     */
-    if (!attrs[OVPN_ATTR_IFINDEX])
-    {
-        msg(D_DCO, "ovpn-dco: Received message without ifindex");
-        return NL_SKIP;
-    }
-
-    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
-    if (ifindex !=3D dco->ifindex)
-    {
-        msg(D_DCO_DEBUG,
-            "ovpn-dco: ignoring message (type=3D%d) for foreign ifindex %d=
",
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
-                msg(D_DCO, "ovpn-dco: no attributes in OVPN_DEL_PEER messa=
ge");
-                return NL_SKIP;
-            }
-
-            struct nlattr *dp_attrs[OVPN_DEL_PEER_ATTR_MAX + 1];
-            if (nla_parse_nested(dp_attrs, OVPN_DEL_PEER_ATTR_MAX,
-                                 attrs[OVPN_ATTR_DEL_PEER], NULL))
-            {
-                msg(D_DCO, "received bogus del peer packet data from ovpn-=
dco");
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
-            int reason =3D nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_REASON]);
-            unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATT=
R_PEER_ID]);
-
-            msg(D_DCO_DEBUG, "ovpn-dco: received CMD_DEL_PEER, ifindex: %d=
, peer-id %d, reason: %d",
-                ifindex, peerid, reason);
-            dco->dco_message_peer_id =3D peerid;
-            dco->dco_del_peer_reason =3D reason;
-            dco->dco_message_type =3D OVPN_CMD_DEL_PEER;
-
-            break;
-        }
-
-        default:
-            msg(D_DCO, "ovpn-dco: received unknown command: %d", gnlh->cmd=
);
-            dco->dco_message_type =3D 0;
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
-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
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

-    struct multi_context *m =3D arg;
     uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_=
ID]);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: parsing message for peer %u...",
+        __func__, peer_id);

-    if (peer_id >=3D m->max_clients || !m->instances[peer_id])
+    if (dco->ifmode =3D=3D OVPN_MODE_P2P)
     {
-        msg(M_WARN, "%s: cannot store DCO stats for peer %u", __func__,
-            peer_id);
+        c2 =3D &dco->c->c2;
+        if (c2->tls_multi->dco_peer_id !=3D (int)peer_id)
+        {
+            return NL_SKIP;
+        }
+    }
+    else
+    {
+        if (peer_id >=3D dco->c->multi->max_clients)
+        {
+            msg(M_WARN, "%s: received out of bound peer_id %u (max=3D%u)",
+                __func__, peer_id, dco->c->multi->max_clients);
+            return NL_SKIP;
+        }
+
+        struct multi_instance *mi =3D dco->c->multi->instances[peer_id];
+        if (!mi)
+        {
+            msg(M_WARN | M_NOIPREFIX,
+                "%s: received data for a non-existing peer %u",
+                __func__, peer_id);
+            return NL_SKIP;
+        }
+
+        c2 =3D &mi->context.c2;
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
+    int reason =3D nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_REASON]);
+    unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATTR_PEER_I=
D]);
+
+    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_DEL_PEER, ifindex: %d, peer-i=
d %d, reason: %d",
+        dco->ifindex, peerid, reason);
+    dco->dco_message_peer_id =3D peerid;
+    dco->dco_del_peer_reason =3D reason;
+    dco->dco_message_type =3D OVPN_CMD_DEL_PEER;
+
+    return NL_OK;
+}
+
+static int
+ovpn_handle_msg(struct nl_msg *msg, void *arg)
+{
+    dco_context_t *dco =3D arg;
+
+    struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
+    struct genlmsghdr *gnlh =3D genlmsg_hdr(nlh);
+    struct nlattr *attrs[OVPN_ATTR_MAX + 1];
+
+    msg(D_DCO_DEBUG | M_NOIPREFIX,
+        "ovpn-dco: received netlink message type=3D%u cmd=3D%u flags=3D%#.=
4x",
+        nlh->nlmsg_type, gnlh->cmd, nlh->nlmsg_flags);
+
+    /* if we get a message from the NLCTRL family, it means
+     * this is the reply to the mcast ID resolution request
+     * and we parse it accordingly.
+     */
+    if (nlh->nlmsg_type =3D=3D dco->ctrlid)
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
+    /* we must know which interface this message is referring to in order =
to
+     * avoid mixing messages for other instances
+     */
+    if (!attrs[OVPN_ATTR_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return NL_STOP;
+    }
+
+    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
+    if (ifindex !=3D dco->ifindex)
+    {
+        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex %=
d",
+            ifindex);
         return NL_SKIP;
     }

-    dco_update_peer_stat(&m->instances[peer_id]->context.c2, tb_peer, peer=
_id);
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
+            ret =3D ovpn_handle_del_peer(dco, attrs);
+            break;
+        }
+
+        default:
+            msg(D_DCO, "ovpn-dco: received unknown command: %d", gnlh->cmd=
);
+            dco->dco_message_type =3D 0;
+            return NL_STOP;
+    }
+
+    if (ret !=3D NL_OK)
+    {
+        return ret;
+    }
+
+    if (dco->c->mode =3D=3D CM_TOP)
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
+        msg(D_DCO_DEBUG, "%s: cannot request peer stats while parsing othe=
r messages",
+            __func__);
+        return 0;
+    }
+
+    ASSERT(dco->c->multi =3D=3D m);
+
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER=
);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }

     nlmsg_hdr(nl_msg)->nlmsg_flags |=3D NLM_F_DUMP;

-    int ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __f=
unc__);
+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

     nlmsg_free(nl_msg);
     return ret;
 }

-static int
-dco_parse_peer(struct nl_msg *msg, void *arg)
-{
-    struct context *c =3D arg;
-    struct nlattr *tb[OVPN_ATTR_MAX + 1];
-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
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
-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_=
ID]);
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
 dco_get_peer_stats(struct context *c)
 {
@@ -993,6 +1033,13 @@
         return 0;
     }

+    if (__is_locked)
+    {
+        msg(D_DCO_DEBUG, "%s: cannot request peer stats while parsing othe=
r messages",
+            __func__);
+        return 0;
+    }
+
     dco_context_t *dco =3D &c->c1.tuntap->dco;
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER=
);
     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_GET_PEER);
@@ -1001,7 +1048,7 @@
     NLA_PUT_U32(nl_msg, OVPN_GET_PEER_ATTR_PEER_ID, peer_id);
     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer, c, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

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
 #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
-    dco_context_t *dco =3D &c->c1.tuntap->dco;
-
-    dco_do_read(dco);
+    struct context *c =3D dco->c;

     /* FreeBSD currently sends us removal notifcation with the old peer-id=
 in
      * p2p mode with the ping timeout reason, so ignore that one to not sh=
oot
@@ -1291,6 +1289,8 @@
     switch (dco->dco_message_type)
     {
         case OVPN_CMD_DEL_PEER:
+            /* peer is gone, unset ID to prevent more kernel calls */
+            c->c2.tls_multi->dco_peer_id =3D -1;
             if (dco->dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_EXPIR=
ED)
             {
                 msg(D_DCO_DEBUG, "%s: received peer expired notification o=
f for peer-id "
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
             else if (e->arg =3D=3D MTCP_DCO)
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
-            bool ret =3D true;
-            while (ret)
-            {
-                ret =3D multi_process_incoming_dco(m);
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
     mi->context.c2.tls_multi->dco_peer_id =3D -1;
     mi->context.sig->signal_text =3D reason;
-    mi->context.c2.dco_read_bytes =3D dco->dco_read_bytes;
-    mi->context.c2.dco_write_bytes =3D dco->dco_write_bytes;
     multi_signal_instance(m, mi, SIGTERM);
 }

-bool
-multi_process_incoming_dco(struct multi_context *m)
+void
+multi_process_incoming_dco(dco_context_t *dco)
 {
-    dco_context_t *dco =3D &m->top.c1.tuntap->dco;
+    ASSERT(dco->c->multi);

+    struct multi_context *m =3D dco->c->multi;
     struct multi_instance *mi =3D NULL;

-    int ret =3D dco_do_read(&m->top.c1.tuntap->dco);
-
     int peer_id =3D dco->dco_message_peer_id;

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
-    dco->dco_message_type =3D 0;
-    dco->dco_message_peer_id =3D -1;
-    dco->dco_del_peer_reason =3D -1;
-    dco->dco_read_bytes =3D 0;
-    dco->dco_write_bytes =3D 0;
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

 /*************************************************************************=
*/
 /**

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1632?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I92c5f74a27b40fede204f714b042a6cc80b3703e
Gerrit-Change-Number: 1632
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Y9m7DFyQ0f4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1632?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">dco: backport immediate notification processing =
on Linux and FreeBSD<br><br>Backport the immediate DCO message processing m=
odel from commit 7791f53<br>(&quot;dco: process messages immediately after =
read&quot;).<br><br>Change the core DCO API from dco_do_read() to dco_read_=
and_process(),<br>and make the backend read paths own the parsing and immed=
iate handling<br>of kernel notifications before handing the resulting state=
 to<br>process_incoming_dco() or multi_process_incoming_dco().<br><br>On Li=
nux, install a permanent netlink callback and process GET_PEER and<br>DEL_P=
EER messages as they are received, instead of switching callbacks<br>for ea=
ch read and deferring handling through shared DCO message state.<br>Also ad=
d a small guard to avoid requesting peer stats while libnl is<br>still pars=
ing a batch of notifications.<br><br>On FreeBSD, move notification handling=
 into dco_read_and_process() and<br>update peer statistics directly from th=
e backend instead of storing<br>temporary byte counters in dco_context_t.<b=
r><br>This commit is part of a reworked backport of PR #945 originally<br>p=
roposed by Nikolai Shelekhov &lt;nickshv13@...2314...&gt;.<br><br>Github: O=
penVPN/openvpn#900<br>Github: OpenVPN/openvpn#918<br>Github: OpenVPN/openvp=
n#931<br>Github: fixes OpenVPN/openvpn#919<br>Github: closes OpenVPN/openvp=
n#945<br><br>Change-Id: I92c5f74a27b40fede204f714b042a6cc80b3703e<br>Signed=
-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/163=
2<br>Message-Id: &lt;20260421084906.5720-1-gert@...1296...&gt;<br>URL: http=
s://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36707.html<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/open=
vpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_freebsd.h<br>=
M src/openvpn/dco_linux.c<br>M src/openvpn/dco_linux.h<br>M src/openvpn/dco=
_win.c<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/openv=
pn/mtcp.c<br>M src/openvpn/mudp.c<br>M src/openvpn/multi.c<br>M src/openvpn=
/multi.h<br>12 files changed, 299 insertions(+), 242 deletions(-)<br><br></=
pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>index=
 334d468..3a36ddc 100644</span><br><span>--- a/src/openvpn/dco.h</span><br>=
<span>+++ b/src/openvpn/dco.h</span><br><span>@@ -128,12 +128,13 @@</span><=
br><span> void close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx);</s=
pan><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * Read data from the DCO communication channel (i.e. a cont=
rol packet)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read =
and process data from the DCO communication channel</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * (i.e. a control packet)</span><br><spa=
n>  *</span><br><span>  * @param dco       the DCO context</span><br><span>=
  * @return          0 on success or a negative error code otherwise</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco=
_do_read(dco_context_t *dco);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+int dco_read_and_process(dco_context_t *dco);</span><br><span> </=
span><br><span> /**</span><br><span>  * Install a DCO in the main event loo=
p</span><br><span>@@ -300,7 +301,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> static inline int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-dco_do_read(dco_context_t *dco)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+dco_read_and_process(dco_context_t *dco)</span><br=
><span> {</span><br><span>     ASSERT(false);</span><br><span>     return 0=
;</span><br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_=
freebsd.c</span><br><span>index b164bd3..9384bf1 100644</span><br><span>---=
 a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.=
c</span><br><span>@@ -560,8 +560,23 @@</span><br><span>     return ret;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const =
nvlist_t *nvl)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (peerid &gt;=3D =
m-&gt;max_clients || !m-&gt;instances[peerid])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_WARN, &quot;dco_update_peer_stat: invalid peer I=
D %d returned by kernel&quot;, peerid);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_=
instance *mi =3D m-&gt;instances[peerid];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    mi-&gt;context.c2.dco_read_bytes =3D nvlist_get_number(nvl, &quot;in=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;=
context.c2.dco_write_bytes =3D nvlist_get_number(nvl, &quot;out&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-dco_do_read(dco_context_t *dco)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+dco_read_and_process(dco_cont=
ext_t *dco)</span><br><span> {</span><br><span>     struct ifdrv drv;</span=
><br><span>     uint8_t buf[4096];</span><br><span>@@ -592,9 +607,13 @@</sp=
an><br><span>         return -EINVAL;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_me=
ssage_peer_id =3D nvlist_get_number(nvl, &quot;peerid&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* dco_message_peer_id is sig=
ned int, because other parts of the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * code treat &quot;-1&quot; as &quot;this is a message=
 not specific to one peer&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    dco-&gt;dco_message_peer_id =3D (int)nvlist_get_number(nvl, &quot;peeri=
d&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    type =3D nvlist_get_number(nvl, &quot;notification&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    type =3D (enum ovpn_no=
tif_type)nvlist_get_number(nvl, &quot;notification&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     switch (type)<=
/span><br><span>     {</span><br><span>         case OVPN_NOTIF_DEL_PEER:</=
span><br><span>@@ -617,8 +636,15 @@</span><br><span>             {</span><b=
r><span>                 const nvlist_t *bytes =3D nvlist_get_nvlist(nvl, &=
quot;bytes&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                dco-&gt;dco_read_bytes =3D nvlist_get_number=
(bytes, &quot;in&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                dco-&gt;dco_write_bytes =3D nvlist_get_number(bytes, &qu=
ot;out&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    dco_update_peer_stat(dco-&gt=
;c-&gt;multi, dco-&gt;dco_message_peer_id, bytes);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    dco-&gt;c-&gt;c2.dco_read_b=
ytes =3D nvlist_get_number(bytes, &quot;in&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    dco-&gt;c-&gt;c2.dco_wri=
te_bytes =3D nvlist_get_number(bytes, &quot;out&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span>     =
        }</span><br><span> </span><br><span>             dco-&gt;dco_messag=
e_type =3D OVPN_CMD_DEL_PEER;</span><br><span>@@ -628,7 +654,8 @@</span><br=
><span>             dco-&gt;dco_message_type =3D OVPN_CMD_SWAP_KEYS;</span>=
<br><span>             break;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        case OVPN_NOTIF_FLOAT: {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        case OVPN_NOTIF_FLOAT:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
>             const nvlist_t *address;</span><br><span> </span><br><span>  =
           if (!nvlist_exists_nvlist(nvl, &quot;address&quot;))</span><br><=
span>@@ -649,11 +676,21 @@</span><br><span> </span><br><span>         defau=
lt:</span><br><span>             msg(M_WARN, &quot;Unknown kernel notificat=
ion %d&quot;, type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            dco-&gt;dco_message_type =3D OVPN_CMD_NO_MESSAGE;</span><br><s=
pan>             break;</span><br><span>     }</span><br><span> </span><br>=
<span>     nvlist_destroy(nvl);</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        multi_process_incoming_dco(dc=
o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        process_incoming_dco(dco);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     return 0;</span><br><span> }</sp=
an><br><span> </span><br><span>@@ -773,26 +810,9 @@</span><br><span>     nv=
list_destroy(nvl);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-dco_update_peer_stat(struct multi_context *m, uint3=
2_t peerid, const nvlist_t *nvl)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (peerid &gt;=3D m-&gt;m=
ax_clients || !m-&gt;instances[peerid])</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_WARN, &quot;dco_update_peer_stat: invalid peer ID %d return=
ed by kernel&quot;, peerid);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D m-=
&gt;instances[peerid];</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context.c=
2.dco_read_bytes =3D nvlist_get_number(nvl, &quot;in&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.dco_write_byte=
s =3D nvlist_get_number(nvl, &quot;out&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> int</span><br><span> dco_get_peer_stats_multi(dco_co=
ntext_t *dco, struct multi_context *m)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     struct ifdrv drv;=
</span><br><span>     uint8_t *buf =3D NULL;</span><br><span>     size_t bu=
f_size =3D 4096;</span><br><span>diff --git a/src/openvpn/dco_freebsd.h b/s=
rc/openvpn/dco_freebsd.h</span><br><span>index e8f723e..d2cc045 100644</spa=
n><br><span>--- a/src/openvpn/dco_freebsd.h</span><br><span>+++ b/src/openv=
pn/dco_freebsd.h</span><br><span>@@ -33,6 +33,8 @@</span><br><span> typedef=
 enum ovpn_key_cipher dco_cipher_t;</span><br><span> </span><br><span> enum=
 ovpn_message_type_t {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* message type #0 is treated as magic number by process_incoming_dc=
o() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_=
NO_MESSAGE =3D 0,</span><br><span>     OVPN_CMD_DEL_PEER,</span><br><span> =
    OVPN_CMD_PACKET,</span><br><span>     OVPN_CMD_SWAP_KEYS,</span><br><sp=
an>@@ -57,9 +59,8 @@</span><br><span>     int dco_message_peer_id;</span><b=
r><span>     int dco_del_peer_reason;</span><br><span>     struct sockaddr_=
storage dco_float_peer_ss;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     struct context *c;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    uint64_t dco_read_bytes;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    uint64_t dco_write_bytes;</span><br><s=
pan> } dco_context_t;</span><br><span> </span><br><span> #endif /* defined(=
ENABLE_DCO) &amp;&amp; defined(TARGET_FREEBSD) */</span><br><span>diff --gi=
t a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index=
 493fce6..8ce7026 100644</span><br><span>--- a/src/openvpn/dco_linux.c</spa=
n><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -50,6 +50,15 @=
@</span><br><span> #include &lt;netlink/genl/family.h&gt;</span><br><span> =
#include &lt;netlink/genl/ctrl.h&gt;</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* When parsing multiple DEL_PEER notifi=
cations, openvpn tries to request stats</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * for each DEL_PEER message (see setenv_stats). This t=
riggers a GET_PEER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* request-reply while we are still parsing the rest of the initial</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * notifications, which can =
lead to NLE_BUSY or even NLE_NOMEM.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* This basic lock ensures we don&#39;t bite our own tail by issuing a dco_g=
et_peer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * while sti=
ll busy receiving and parsing other messages.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static bool __is_locked =3D false;</span><br><span> </span><br><s=
pan> /* libnl &lt; 3.5.0 does not set the NLA_F_NESTED on its own, therefor=
e we</span><br><span>  * have to explicitly do it to prevent the kernel fro=
m failing upon</span><br><span>@@ -62,8 +71,6 @@</span><br><span> </span><b=
r><span> void dco_check_key_ctx(const struct key_ctx_bi *key);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef int (*ov=
pn_nl_cb)(struct nl_msg *msg, void *arg);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * @brief resolv=
es the netlink ID for ovpn-dco</span><br><span>  *</span><br><span>@@ -131,=
7 +138,9 @@</span><br><span> static int</span><br><span> ovpn_nl_recvmsgs(d=
co_context_t *dco, const char *prefix)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    __is_locked =3D true;</span><br><=
span>     int ret =3D nl_recvmsgs(dco-&gt;nl_sock, dco-&gt;nl_cb);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    __is_locked =3D false;</=
span><br><span> </span><br><span>     switch (ret)</span><br><span>     {</=
span><br><span>@@ -167,23 +176,19 @@</span><br><span> }</span><br><span> </=
span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Send a prepared netlink message and registers cb as callback if non-null.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Send a prepared n=
etlink message.</span><br><span>  *</span><br><span>  * The method will als=
o free nl_msg</span><br><span>  * @param dco       The dco context to use</=
span><br><span>  * @param nl_msg    the message to use</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * @param cb        An optional callback i=
f the caller expects an answer</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @param cb_arg    An optional param to pass to the callback</spa=
n><br><span>  * @param prefix    A prefix to report in the error message to=
 give the user context</span><br><span>  * @return          status of sendi=
ng the message</span><br><span>  */</span><br><span> static int</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-ovpn_nl_msg_send(dco_context_t *d=
co, struct nl_msg *nl_msg, ovpn_nl_cb cb,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                 void *cb_arg, const char *prefix)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_nl_msg_send(dco_con=
text_t *dco, struct nl_msg *nl_msg, const char *prefix)</span><br><span> {<=
/span><br><span>     dco-&gt;status =3D 1;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    nl_cb_set(dco-&gt;nl_cb, NL_CB_V=
ALID, NL_CB_CUSTOM, cb, cb_arg);</span><br><span>     nl_send_auto(dco-&gt;=
nl_sock, nl_msg);</span><br><span> </span><br><span>     while (dco-&gt;sta=
tus =3D=3D 1)</span><br><span>@@ -274,7 +279,7 @@</span><br><span>     }</s=
pan><br><span>     nla_nest_end(nl_msg, attr);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco=
, nl_msg, NULL, NULL, __func__);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br=
><span> </span><br><span> nla_put_failure:</span><br><span>     nlmsg_free(=
nl_msg);</span><br><span>@@ -342,6 +347,8 @@</span><br><span>     return NL=
_STOP;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static int ovpn_handle_msg(struct nl_msg *msg, void=
 *arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> static void</span><br><span> ovpn_dco_init_netlink(dco_context_t *dco=
)</span><br><span> {</span><br><span>@@ -373,11 +380,13 @@</span><br><span>=
 </span><br><span>     nl_socket_set_cb(dco-&gt;nl_sock, dco-&gt;nl_cb);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
dco-&gt;dco_message_peer_id =3D -1;</span><br><span>     nl_cb_err(dco-&gt;=
nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &amp;dco-&gt;status);</span><br><spa=
n>     nl_cb_set(dco-&gt;nl_cb, NL_CB_FINISH, NL_CB_CUSTOM, ovpn_nl_cb_fini=
sh,</span><br><span>               &amp;dco-&gt;status);</span><br><span>  =
   nl_cb_set(dco-&gt;nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish,</sp=
an><br><span>               &amp;dco-&gt;status);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    nl_cb_set(dco-&gt;nl_cb, NL_CB_VALID, NL_=
CB_CUSTOM, ovpn_handle_msg, dco);</span><br><span> </span><br><span>     /*=
 The async PACKET messages confuse libnl and it will drop them with</span><=
br><span>      * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libn=
l&#39;s sequence</span><br><span>@@ -501,7 +510,7 @@</span><br><span>     N=
LA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR_PEER_ID, peerid);</span><br><span>  =
   nla_nest_end(nl_msg, attr);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, =
NULL, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> </span><=
br><span> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</span><=
br><span>@@ -525,7 +534,7 @@</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_=
DEL_PEER_ATTR_PEER_ID, peerid);</span><br><span>     nla_nest_end(nl_msg, a=
ttr);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send=
(dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_put_failure=
:</span><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -551,7 +560,7=
 @@</span><br><span>     NLA_PUT_U8(nl_msg, OVPN_DEL_KEY_ATTR_KEY_SLOT, slo=
t);</span><br><span>     nla_nest_end(nl_msg, attr);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_se=
nd(dco, nl_msg, NULL, NULL, __func__);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</sp=
an><br><span> </span><br><span> nla_put_failure:</span><br><span>     nlmsg=
_free(nl_msg);</span><br><span>@@ -608,7 +617,7 @@</span><br><span> </span>=
<br><span>     nla_nest_end(nl_msg, attr);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl=
_msg, NULL, NULL, __func__);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><sp=
an> </span><br><span> nla_put_failure:</span><br><span>     nlmsg_free(nl_m=
sg);</span><br><span>@@ -637,7 +646,7 @@</span><br><span>                 k=
eepalive_timeout);</span><br><span>     nla_nest_end(nl_msg, attr);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D=
 ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg,=
 __func__);</span><br><span> </span><br><span> nla_put_failure:</span><br><=
span>     nlmsg_free(nl_msg);</span><br><span>@@ -705,7 +714,7 @@</span><br=
><span> </span><br><span>     /* Even though &#39;nlctrl&#39; is a constant=
, there seem to be no library</span><br><span>      * provided define for i=
t */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ctrlid =
=3D genl_ctrl_resolve(dco-&gt;nl_sock, &quot;nlctrl&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;ctrlid =3D genl_ctrl_re=
solve(dco-&gt;nl_sock, &quot;nlctrl&quot;);</span><br><span> </span><br><sp=
an>     struct nl_msg *nl_msg =3D nlmsg_alloc();</span><br><span>     if (!=
nl_msg)</span><br><span>@@ -713,12 +722,12 @@</span><br><span>         retu=
rn -ENOMEM;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    genlmsg_put(nl_msg, 0, 0, ctrlid, 0, 0,=
 CTRL_CMD_GETFAMILY, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    genlmsg_put(nl_msg, 0, 0, dco-&gt;ctrlid, 0, 0, CTRL_CMD_GETFAMILY=
, 0);</span><br><span> </span><br><span>     int ret =3D -EMSGSIZE;</span><=
br><span>     NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_NL_NAME);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ret =3D ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, dco, __func__);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl=
_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_pu=
t_failure:</span><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -726=
,108 +735,10 @@</span><br><span> }</span><br><span> </span><br><span> /* Th=
is function parses any netlink message sent by ovpn-dco to userspace */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-ovpn_handle_msg(struct nl_msg *msg, =
void *arg)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    dco_context_t *dco =3D arg;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct genlmsghdr *gnlh =3D nlmsg_data=
(nlmsg_hdr(msg));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct nlattr *attrs[OVPN_ATTR_MAX + 1];</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct nlmsghdr *nlh =3D nlmsg_hdr(msg);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (!genlmsg_valid_hdr(nlh, 0))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: invalid header&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return NL_SK=
IP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (nla_parse(attrs, OVPN_ATTR_MAX, genlmsg_attrdat=
a(gnlh, 0),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
        genlmsg_attrlen(gnlh, 0), NULL))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(D_DCO, &quot;received bogus data from ovpn-dco&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* we must know which interface this message is referring =
to in order to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
avoid mixing messages for other instances</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (!attrs[OVPN_ATTR_IFINDEX])</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(D_DCO, &quot;ovpn-dco: Received message without ifindex&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return NL_=
SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_=
IFINDEX]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifi=
ndex !=3D dco-&gt;ifindex)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(D_DCO_DEBUG,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    &quot;ovpn-dco: ignoring message (type=3D%d) for foreign ifindex %d&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            gnlh-&=
gt;cmd, ifindex);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* based on the message type, we pa=
rse the subobject contained in the</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     * message, that stores the type-specific attributes.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * the &quot;dco&quot; object is then=
 filled accordingly with the information</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * retrieved from the message, so that the rest of t=
he OpenVPN code can</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * react as need be.</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (g=
nlh-&gt;cmd)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        case OVPN_CMD_DEL=
_PEER:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!attrs[OVPN=
_ATTR_DEL_PEER])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   msg(D_DCO, &quot;ovpn-dco: no attributes in OVPN_DEL_PEER message&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                retu=
rn NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            struct nlattr *dp_attrs[OVP=
N_DEL_PEER_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            if (nla_parse_nested(dp_attrs, OVPN_DEL_PEER_ATTR_MAX,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
       attrs[OVPN_ATTR_DEL_PEER], NULL))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                msg(D_DCO, &quot;received bogus del peer packet =
data from ovpn-dco&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                return NL_SKIP;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (!dp_attrs[OVPN_DEL_PEER_ATTR_REASON])</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                msg(D_DCO, &quot;ovpn-dco: no reason in DEL_PEER =
message&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (!dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: no peer-id =
in DEL_PEER message&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                return NL_SKIP;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            int reason =3D nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_R=
EASON]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            u=
nsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID]);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG, &quot;ovpn-dco=
: received CMD_DEL_PEER, ifindex: %d, peer-id %d, reason: %d&quot;,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                ifindex, peer=
id, reason);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   dco-&gt;dco_message_peer_id =3D peerid;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            dco-&gt;dco_del_peer_reason =3D reason;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            dco-&gt;dco_=
message_type =3D OVPN_CMD_DEL_PEER;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(D_DCO, &quot;ovpn-dco: received =
unknown command: %d&quot;, gnlh-&gt;cmd);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            dco-&gt;dco_message_type =3D 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            return NL_SKIP;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return NL_OK;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_do_read(d=
co_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
co_read_and_process(dco_context_t *dco)</span><br><span> {</span><br><span>=
     msg(D_DCO_DEBUG, __func__);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    nl_cb_set(dco-&gt;nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_han=
dle_msg, dco);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span>     return ovpn_nl_recvmsgs(dco, __func__);</span><br><span> }</=
span><br><span> </span><br><span>@@ -883,27 +794,21 @@</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
dco_parse_peer_multi(struct nl_msg *msg, void *arg)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ovpn_handle_peer(dco_context_t *dco, struct nlattr=
 *attrs[])</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct nlattr *tb[OVPN_ATTR_MAX + 1];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct genlmsghdr *gnlh =3D nlmsg_data(nlms=
g_hdr(msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct nlattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct context_2 *c2;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG=
, &quot;%s: parsing message...&quot;, __func__);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    nla_parse(tb, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-              genlmsg_attrlen(g=
nlh, 0), NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tb[OVPN_ATTR_GET_P=
EER])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!attrs=
[OVPN_ATTR_GET_PEER])</span><br><span>     {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s: malformed reply=
&quot;, __func__);</span><br><span>         return NL_SKIP;</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct nlattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     nla_parse(=
tb_peer, OVPN_GET_PEER_RESP_ATTR_MAX,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-              nla_data(tb[OVPN_ATTR_GET_PEER]),</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-              nla_len(tb[OVPN_ATT=
R_GET_PEER]), NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+              nla_data(attrs[OVPN_ATTR_GET_PEER]),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              nla_len(attrs[OVPN_ATTR_GET=
_PEER]), NULL);</span><br><span> </span><br><span>     if (!tb_peer[OVPN_GE=
T_PEER_RESP_ATTR_PEER_ID])</span><br><span>     {</span><br><span>@@ -911,1=
7 +816,180 @@</span><br><span>         return NL_SKIP;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct multi_context *m =3D arg;</span><br><span>     uint32_t peer_id =
=3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &=
quot;%s: parsing message for peer %u...&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        __func__, peer_id);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (peer_id &gt;=3D =
m-&gt;max_clients || !m-&gt;instances[peer_id])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msg(M_WARN, &quot;%s: cannot store DCO stats for peer %u&quot;, __fu=
nc__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            peer=
_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c2 =3D=
 &amp;dco-&gt;c-&gt;c2;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (c2-&gt;tls_multi-&gt;dco_peer_id !=3D (int)peer_id)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return NL_SKIP;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (peer_id &gt;=3D dco-&gt;c-&gt;multi-&gt;max_clients)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;%s: receive=
d out of bound peer_id %u (max=3D%u)&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                __func__, peer_id, dco-&gt;c-&gt;mu=
lti-&gt;max_clients);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct mult=
i_instance *mi =3D dco-&gt;c-&gt;multi-&gt;instances[peer_id];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!mi)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(M_WARN | M_NOIPREFIX,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;%s: r=
eceived data for a non-existing peer %u&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                __func__, peer_id);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return NL_SKIP;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        c2 =3D &amp;mi-&gt;context.c2;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    dco_update_peer_stat(c2, tb_peer, peer_id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return NL_OK;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ovpn_handle_del_peer(dco_contex=
t_t *dco, struct nlattr *attrs[])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!attrs[OVPN_ATTR_DEL_PEER])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(D_DCO, &quot;ovpn-dco: no attributes in OVPN_DEL_PEER message&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct nlattr *dp_attrs[OVPN_DEL_PEER_AT=
TR_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(nla_parse_nested(dp_attrs, OVPN_DEL_PEER_ATTR_MAX,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                         attrs[OVPN_ATTR_=
DEL_PEER], NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DC=
O, &quot;received bogus del peer packet data from ovpn-dco&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return NL_STOP;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!dp_attrs[OVPN_DEL_PEER_ATTR_REASON])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: no reason =
in DEL_PEER message&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return NL_STOP;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: no peer-id in DEL_PEER messag=
e&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int reason =3D nla_get_u8(dp_attrs[=
OVPN_DEL_PEER_ATTR_REASON]);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATT=
R_PEER_ID]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot=
;ovpn-dco: received CMD_DEL_PEER, ifindex: %d, peer-id %d, reason: %d&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco-&gt;if=
index, peerid, reason);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    dco-&gt;dco_message_peer_id =3D peerid;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    dco-&gt;dco_del_peer_reason =3D reason;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_message=
_type =3D OVPN_CMD_DEL_PEER;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 NL_OK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ovpn_handle_msg(struct nl_msg *msg, void *arg)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    dco_context_t *dco =3D arg;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct nlmsghdr *nlh =3D nlmsg_hdr(msg);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct genlmsghdr *gnlh =3D=
 genlmsg_hdr(nlh);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct nlattr *attrs[OVPN_ATTR_MAX + 1];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    msg(D_DCO_DEBUG | M_NOIPREFIX,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        &quot;ovpn-dco: received netlink message type=
=3D%u cmd=3D%u flags=3D%#.4x&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        nlh-&gt;nlmsg_type, gnlh-&gt;cmd, nlh-&gt;nlmsg_fla=
gs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* if we get a message from th=
e NLCTRL family, it means</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * this is the reply to the mcast ID resolution request</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * and we parse it accord=
ingly.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (nlh-&gt;nlmsg_typ=
e =3D=3D dco-&gt;ctrlid)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(D_DCO_DEBUG, &quot;ovpn-dco: received CTRLID message&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return mcast_family_han=
dler(msg, dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!genlmsg_valid_hdr(nlh, 0))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: =
invalid header&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (nla_parse(attrs, O=
VPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                  genlmsg_attrlen(gnlh, 0), NULL))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;received bog=
us data from ovpn-dco&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return NL_STOP;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we must know=
 which interface this message is referring to in order to</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * avoid mixing messages for othe=
r instances</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_=
ATTR_IFINDEX])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, =
&quot;ovpn-dco: Received message without ifindex&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return NL_STOP;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ifindex !=3D dc=
o-&gt;ifindex)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_D=
EBUG, &quot;ovpn-dco: ignoring message for foreign ifindex %d&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            ifindex);</spa=
n><br><span>         return NL_SKIP;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_update_peer=
_stat(&amp;m-&gt;instances[peer_id]-&gt;context.c2, tb_peer, peer_id);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* based on the mess=
age type, we parse the subobject contained in the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * message, that stores the type-specific=
 attributes.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the &quot;dco=
&quot; object is then filled accordingly with the information</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * retrieved from the message=
, so that *process_incoming_dco can react</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * as need be.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    switch (gnlh-&gt;cmd)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  case OVPN_CMD_GET_PEER:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        /* return directly, there are no messages to pass to</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+             * *process_incoming_d=
co()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
ovpn_handle_peer(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case OVPN_C=
MD_DEL_PEER:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret =
=3D ovpn_handle_del_peer(dco, attrs);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        defa=
ult:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(D_DCO, &quot;ovpn-dco: received unknown command: %d&quot;, gnlh-&gt;cmd);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dco-&gt;=
dco_message_type =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return NL_STOP;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret !=3D NL_O=
K)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return ret;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (dco-&gt;c-&gt;mode =3D=3D CM_TOP)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        multi_process_incoming_dco(dco);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        process_incoming_dco(dco);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span> </span><br><span>     return NL_OK;=
</span><br><span> }</span><br><span>@@ -931,57 +999,29 @@</span><br><span> =
{</span><br><span>     msg(D_DCO_DEBUG, &quot;%s&quot;, __func__);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (__=
is_locked)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG=
, &quot;%s: cannot request peer stats while parsing other messages&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            __func__)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(dco-&gt;c-&gt;multi =3D=3D m);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct nl=
_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return -ENOMEM;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>    =
 nlmsg_hdr(nl_msg)-&gt;nlmsg_flags |=3D NLM_F_DUMP;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D ovpn_nl_msg=
_send(dco, nl_msg, dco_parse_peer_multi, m, __func__);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int ret =3D ovpn_nl_msg_send(dco, nl=
_msg, __func__);</span><br><span> </span><br><span>     nlmsg_free(nl_msg);=
</span><br><span>     return ret;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-dco_parse_peer(struct nl_msg *msg, vo=
id *arg)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D arg;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb[OV=
PN_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __fun=
c__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb, OVPN_ATTR_MAX, genl=
msg_attrdata(gnlh, 0),</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-              genlmsg_attrlen(gnlh, 0), NULL);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!tb[OVPN_ATTR_GET_PEER])</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(D_DCO_DEBUG, &quot;%s: malformed reply&quot;, __func__);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct nlattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb_peer, OVPN_GET_PEER_RESP_A=
TTR_MAX,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
 nla_data(tb[OVPN_ATTR_GET_PEER]),</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-              nla_len(tb[OVPN_ATTR_GET_PEER]), NULL);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (!tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no peer-=
id provided in reply&quot;, __func__);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return NL_SKIP;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t peer_=
id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID]);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.tls_multi-&gt;dco_=
peer_id !=3D peer_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return N=
L_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    dco_update_peer_stat(&amp;c-&gt;c2, tb_peer, pe=
er_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return NL_OK;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> int</span><br><span> dco_get_peer_stats(s=
truct context *c)</span><br><span> {</span><br><span>@@ -993,6 +1033,13 @@<=
/span><br><span>         return 0;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (__is_locked=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%=
s: cannot request peer stats while parsing other messages&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            __func__);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     dco_context_t *dco =
=3D &amp;c-&gt;c1.tuntap-&gt;dco;</span><br><span>     struct nl_msg *nl_ms=
g =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER);</span><br><span>     s=
truct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_GET_PEER);</span><b=
r><span>@@ -1001,7 +1048,7 @@</span><br><span>     NLA_PUT_U32(nl_msg, OVPN=
_GET_PEER_ATTR_PEER_ID, peer_id);</span><br><span>     nla_nest_end(nl_msg,=
 attr);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer, c, __func__);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl=
_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_pu=
t_failure:</span><br><span>     nlmsg_free(nl_msg);</span><br><span>diff --=
git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h</span><br><span>ind=
ex cf6bdd4..9209915 100644</span><br><span>--- a/src/openvpn/dco_linux.h</s=
pan><br><span>+++ b/src/openvpn/dco_linux.h</span><br><span>@@ -44,6 +44,7 =
@@</span><br><span>     int status;</span><br><span> </span><br><span>     =
struct context *c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int ctrlid;</span><br><span> </span><br><span>     enum ovpn_mode ifmode=
;</span><br><span> </span><br><span>@@ -55,8 +56,6 @@</span><br><span>     =
int dco_message_type;</span><br><span>     int dco_message_peer_id;</span><=
br><span>     int dco_del_peer_reason;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    uint64_t dco_read_bytes;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    uint64_t dco_write_bytes;</span><br><span> } dc=
o_context_t;</span><br><span> </span><br><span> #endif /* defined(ENABLE_DC=
O) &amp;&amp; defined(TARGET_LINUX) */</span><br><span>diff --git a/src/ope=
nvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index bc465db..b11d5=
06 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b=
/src/openvpn/dco_win.c</span><br><span>@@ -423,7 +423,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-dco_do_read(dco_context_t *dco)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_read_and_process(dco_context_t *dco)<=
/span><br><span> {</span><br><span>     /* no-op on windows */</span><br><s=
pan>     ASSERT(0);</span><br><span>diff --git a/src/openvpn/forward.c b/sr=
c/openvpn/forward.c</span><br><span>index 4e9e739..e43ce28 100644</span><br=
><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forwar=
d.c</span><br><span>@@ -1269,13 +1269,11 @@</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pro=
cess_incoming_dco(struct context *c)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+process_incoming_dco(dco_context_t *dco)</span><br><span> {</span><br><sp=
an> #if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TA=
RGET_FREEBSD))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco=
_context_t *dco =3D &amp;c-&gt;c1.tuntap-&gt;dco;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    dco_do_read(dco);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct context *c =3D dco-&gt;c;</span><br><span> </span><br><=
span>     /* FreeBSD currently sends us removal notifcation with the old pe=
er-id in</span><br><span>      * p2p mode with the ping timeout reason, so =
ignore that one to not shoot</span><br><span>@@ -1291,6 +1289,8 @@</span><b=
r><span>     switch (dco-&gt;dco_message_type)</span><br><span>     {</span=
><br><span>         case OVPN_CMD_DEL_PEER:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* peer is gone, unset ID to prevent mo=
re kernel calls */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           c-&gt;c2.tls_multi-&gt;dco_peer_id =3D -1;</span><br><span>     =
        if (dco-&gt;dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_EXPIRED=
)</span><br><span>             {</span><br><span>                 msg(D_DCO=
_DEBUG, &quot;%s: received peer expired notification of for peer-id &quot;<=
/span><br><span>@@ -2344,7 +2344,7 @@</span><br><span>     {</span><br><spa=
n>         if (!IS_SIG(c))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            process_incoming_dco(c);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            dco_read_and_p=
rocess(&amp;c-&gt;c1.tuntap-&gt;dco);</span><br><span>         }</span><br>=
<span>     }</span><br><span> }</span><br><span>diff --git a/src/openvpn/fo=
rward.h b/src/openvpn/forward.h</span><br><span>index 3d0abd5..1de2aa2 1006=
44</span><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/op=
envpn/forward.h</span><br><span>@@ -50,6 +50,7 @@</span><br><span> #include=
 &quot;openvpn.h&quot;</span><br><span> #include &quot;occ.h&quot;</span><b=
r><span> #include &quot;ping.h&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;dco.h&quot;</span><br><span> </span><br><sp=
an> #define IOW_TO_TUN          (1&lt;&lt;0)</span><br><span> #define IOW_T=
O_LINK         (1&lt;&lt;1)</span><br><span>@@ -248,6 +249,12 @@</span><br>=
<span>  */</span><br><span> void process_incoming_tun(struct context *c);</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Process an incom=
ing DCO message (from kernel space).</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param dco - Pointer to the structure representing the DCO context.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void process_incoming_dco(dco_context_t =
*dco);</span><br><span> </span><br><span> /**</span><br><span>  * Write a p=
acket to the virtual tun/tap network interface.</span><br><span>diff --git =
a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 38c938e..b1=
714c8 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b=
/src/openvpn/mtcp.c</span><br><span>@@ -747,7 +747,7 @@</span><br><span>   =
          /* incoming data on DCO? */</span><br><span>             else if =
(e-&gt;arg =3D=3D MTCP_DCO)</span><br><span>             {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                multi_process_incoming=
_dco(m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     dco_read_and_process(&amp;m-&gt;top.c1.tuntap-&gt;dco);</span><br><spa=
n>             }</span><br><span> #endif</span><br><span>             /* si=
gnal received? */</span><br><span>diff --git a/src/openvpn/mudp.c b/src/ope=
nvpn/mudp.c</span><br><span>index 8cc717b..9a71eeb 100644</span><br><span>-=
-- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br>=
<span>@@ -409,11 +409,7 @@</span><br><span>     {</span><br><span>         =
if (!IS_SIG(&amp;m-&gt;top))</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            bool ret =3D true;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            while (ret)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                ret =3D multi_process_=
incoming_dco(m);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 dco_read_and_process(&amp;m-&gt;top.c1.tuntap-&gt;dco);</span><br><span>  =
       }</span><br><span>     }</span><br><span> #endif</span><br><span>dif=
f --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 6=
9497a6..7620065 100644</span><br><span>--- a/src/openvpn/multi.c</span><br>=
<span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3287,20 +3287,17 @@</sp=
an><br><span>      * installed, and we do not need to clean up the state in=
 the kernel */</span><br><span>     mi-&gt;context.c2.tls_multi-&gt;dco_pee=
r_id =3D -1;</span><br><span>     mi-&gt;context.sig-&gt;signal_text =3D re=
ason;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;conte=
xt.c2.dco_read_bytes =3D dco-&gt;dco_read_bytes;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.dco_write_bytes =3D dco-&g=
t;dco_write_bytes;</span><br><span>     multi_signal_instance(m, mi, SIGTER=
M);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-multi_process_incoming_dco(struct multi_context *m)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+multi_process_incoming_dco(dco_context_t *dco)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_cont=
ext_t *dco =3D &amp;m-&gt;top.c1.tuntap-&gt;dco;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ASSERT(dco-&gt;c-&gt;multi);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mult=
i_context *m =3D dco-&gt;c-&gt;multi;</span><br><span>     struct multi_ins=
tance *mi =3D NULL;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int ret =3D dco_do_read(&amp;m-&gt;top.c1.tuntap-&gt;dc=
o);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
    int peer_id =3D dco-&gt;dco_message_peer_id;</span><br><span> </span><b=
r><span>     /* no peer-specific message delivered -&gt; nothing to process=
.</span><br><span>@@ -3308,7 +3305,7 @@</span><br><span>      */</span><br>=
<span>     if (peer_id &lt; 0)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return ret &gt; 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span>    =
 }</span><br><span> </span><br><span>     if ((peer_id &lt; m-&gt;max_clien=
ts) &amp;&amp; (m-&gt;instances[peer_id]))</span><br><span>@@ -3355,13 +335=
2,6 @@</span><br><span>             &quot;type %d, del_peer_reason %d&quot;=
, peer_id, dco-&gt;dco_message_type,</span><br><span>             dco-&gt;d=
co_del_peer_reason);</span><br><span>     }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    dco-&gt;dco_message_type =3D 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    dco-&gt;dco_message_peer_id =3D -1;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_del_peer_reason =3D -1;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_read_byt=
es =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;=
dco_write_bytes =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return ret &gt; 0;</span><br><span> }</span><br><span> #endif /* if de=
fined(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX) */</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><=
br><span>index 7167639..1b784e1 100644</span><br><span>--- a/src/openvpn/mu=
lti.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -317,13 =
+317,9 @@</span><br><span> /**</span><br><span>  * Process an incoming DCO =
message (from kernel space).</span><br><span>  *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * @param m            - The single \c multi_con=
text structur.e</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *  - True, if the message was recei=
ved correctly.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - F=
alse, if there was an error while reading the message.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param dco - The DCO context containi=
ng the parsed message.</span><br><span>  */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-bool multi_process_incoming_dco(struct multi_context =
*m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_proc=
ess_incoming_dco(dco_context_t *dco);</span><br><span> </span><br><span> /*=
*************************************************************************/<=
/span><br><span> /**</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1632?usp=3Demail">change 1632=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1632?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I92c5f74a27b40fede204f714b04=
2a6cc80b3703e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1632 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Y9m7DFyQ0f4=--

