From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 09:59:41 +0000
In-Reply-To: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
References: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ee8aa7a5a9aecac60468ba67cbe2c987e4796f40-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qHdP6SgZaGM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: fix async
 message reception
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

--qHdP6SgZaGM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail

to look at the new patch set (#3).


Change subject: dco_linux: fix async message reception
......................................................................

dco_linux: fix async message reception

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
---
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
2 files changed, 130 insertions(+), 85 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1100/3

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 0a22879..62052f3 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -172,18 +172,14 @@
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
@@ -285,7 +281,7 @@
     }
     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

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
+        msg(M_FATAL, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_=
dco_mcast_id));
+    }
+
+    /* Register for ovpn-dco specific multicast messages that the kernel m=
ay
+     * send
+     */
+    int ret =3D nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast=
_id);
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
     dco->ovpn_dco_id =3D resolve_ovpn_netlink_id(M_FATAL);
@@ -420,11 +439,15 @@

     nl_socket_set_cb(dco->nl_sock, dco->nl_cb);

+    dco->dco_message_peer_id =3D -1;
     nl_cb_err(dco->nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_FINISH, NL_CB_CUSTOM, ovpn_nl_cb_finish,
               &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish,
               &dco->status);
+    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
+
+    ovpn_dco_register(dco);

     /* The async PACKET messages confuse libnl and it will drop them with
      * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libnl's seque=
nce
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
-        msg(M_FATAL, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_=
dco_mcast_id));
-    }
-
-    /* Register for ovpn-dco specific multicast messages that the kernel m=
ay
-     * send
-     */
-    int ret =3D nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast=
_id);
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

-    tt->dco.dco_message_peer_id =3D -1;
-
-    ovpn_dco_register(&tt->dco);
-
     return 0;
 }

@@ -548,7 +546,7 @@
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -572,7 +570,7 @@
     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -598,7 +596,7 @@
     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);
     nla_nest_end(nl_msg, keyconf);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -657,7 +655,7 @@
     nla_nest_end(nl_msg, key_conf);


-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -686,7 +684,7 @@
                 keepalive_timeout);
     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -754,7 +752,7 @@

     /* Even though 'nlctrl' is a constant, there seem to be no library
      * provided define for it */
-    int ctrlid =3D genl_ctrl_resolve(dco->nl_sock, "nlctrl");
+    dco->ctrlid =3D genl_ctrl_resolve(dco->nl_sock, "nlctrl");

     struct nl_msg *nl_msg =3D nlmsg_alloc();
     if (!nl_msg)
@@ -762,12 +760,12 @@
         return -ENOMEM;
     }

-    genlmsg_put(nl_msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);
+    genlmsg_put(nl_msg, 0, 0, dco->ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);

     int ret =3D -EMSGSIZE;
     NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_FAMILY_NAME);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, dco, __fun=
c__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

 nla_put_failure:
     nlmsg_free(nl_msg);
@@ -879,23 +877,26 @@
 }

 static int
-dco_parse_peer_multi(struct nl_msg *msg, void *arg)
+ovpn_handle_peer_multi(dco_context_t *dco, struct nlattr *attrs[])
 {
-    struct nlattr *tb[OVPN_A_MAX + 1];
-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
-
     msg(D_DCO_DEBUG, "%s: parsing message...", __func__);

-    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
-              genlmsg_attrlen(gnlh, 0), NULL);
+    /* this function assumes openvpn is running in multipeer mode as
+     * it accesses c->multi
+     */
+    if (dco->ifmode !=3D OVPN_MODE_MP)
+    {
+        msg(M_WARN, "%s: can't parse 'multi-peer' message on P2P instance"=
, __func__);
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
@@ -903,7 +904,7 @@
         return NL_SKIP;
     }

-    struct multi_context *m =3D arg;
+    struct multi_context *m =3D dco->c->multi;
     uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);

     if (peer_id >=3D m->max_clients || !m->instances[peer_id])
@@ -919,25 +920,18 @@
 }

 static int
-dco_parse_peer(struct nl_msg *msg, void *arg)
+ovpn_handle_peer(dco_context_t *dco, struct nlattr *attrs[])
 {
-    struct context *c =3D arg;
-    struct nlattr *tb[OVPN_A_MAX + 1];
-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
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
@@ -946,18 +940,39 @@
     }

     uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
-    if (c->c2.tls_multi->dco_peer_id !=3D peer_id)
+    struct context_2 *c2;
+
+    if (dco->ifmode =3D=3D OVPN_MODE_P2P)
+    {
+        c2 =3D &dco->c->c2;
+    }
+    else
+    {
+        struct multi_instance *mi =3D dco->c->multi->instances[peer_id];
+        if (!mi)
+        {
+            msg(M_WARN, "%s: received data for a non-existing peer %u", __=
func__, peer_id);
+            return NL_SKIP;
+        }
+
+        c2 =3D &mi->context.c2;
+    }
+
+    /* at this point this check should never fail for MP mode,
+     * but it's still fully valid for P2P mode
+     */
+    if (c2->tls_multi->dco_peer_id !=3D peer_id)
     {
         return NL_SKIP;
     }

-    dco_update_peer_stat(&c->c2, tb_peer, peer_id);
+    dco_update_peer_stat(c2, tb_peer, peer_id);

     return NL_OK;
 }

-static int
-ovpn_handle_peer_del_ntf(dco_context_t *dco, struct nlattr *attrs[])
+static bool
+ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])
 {
     /* we must know which interface this message is referring to in order =
to
      * avoid mixing messages for other instances
@@ -965,6 +980,25 @@
     if (!attrs[OVPN_A_IFINDEX])
     {
         msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return false;
+    }
+
+    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]);
+    if (ifindex !=3D dco->ifindex)
+    {
+        msg(D_DCO_DEBUG,
+            "ovpn-dco: ignoring message for foreign ifindex %d", ifindex);
+        return false;
+    }
+
+    return true;
+}
+
+static int
+ovpn_handle_peer_del_ntf(dco_context_t *dco, struct nlattr *attrs[])
+{
+    if (!ovpn_iface_check(dco, attrs))
+    {
         return NL_STOP;
     }

@@ -1008,12 +1042,8 @@
 static int
 ovpn_handle_peer_float_ntf(dco_context_t *dco, struct nlattr *attrs[])
 {
-    /* we must know which interface this message is referring to in order =
to
-     * avoid mixing messages for other instances
-     */
-    if (!attrs[OVPN_A_IFINDEX])
+    if (!ovpn_iface_check(dco, attrs))
     {
-        msg(D_DCO, "ovpn-dco: Received message without ifindex");
         return NL_STOP;
     }

@@ -1058,12 +1088,8 @@
 static int
 ovpn_handle_key_swap_ntf(dco_context_t *dco, struct nlattr *attrs[])
 {
-    /* we must know which interface this message is referring to in order =
to
-     * avoid mixing messages for other instances
-     */
-    if (!attrs[OVPN_A_IFINDEX])
+    if (!ovpn_iface_check(dco, attrs))
     {
-        msg(D_DCO, "ovpn-dco: Received message without ifindex");
         return NL_STOP;
     }

@@ -1109,9 +1135,22 @@
 {
     dco_context_t *dco =3D arg;

-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
     struct nlattr *attrs[OVPN_A_MAX + 1];
     struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
+    struct genlmsghdr *gnlh =3D genlmsg_hdr(nlh);
+
+    msg(D_DCO_DEBUG, "ovpn-dco: received netlink message type=3D%u cmd=3D%=
u flags=3D%#.4x",
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

     if (!genlmsg_valid_hdr(nlh, 0))
     {
@@ -1126,15 +1165,6 @@
         return NL_STOP;
     }

-    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]);
-    if (ifindex !=3D dco->ifindex)
-    {
-        msg(D_DCO_DEBUG,
-            "ovpn-dco: ignoring message (type=3D%d) for foreign ifindex %d=
",
-            gnlh->cmd, ifindex);
-        return NL_STOP;
-    }
-
     /* based on the message type, we parse the subobject contained in the
      * message, that stores the type-specific attributes.
      *
@@ -1144,6 +1174,21 @@
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
@@ -1172,7 +1217,6 @@
 dco_do_read(dco_context_t *dco)
 {
     msg(D_DCO_DEBUG, __func__);
-    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);

     return ovpn_nl_recvmsgs(dco, __func__);
 }
@@ -1187,7 +1231,7 @@

     nlmsg_hdr(nl_msg)->nlmsg_flags |=3D NLM_F_DUMP;

-    int ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __f=
unc__);
+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

     nlmsg_free(nl_msg);

@@ -1225,7 +1269,7 @@
     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);
     nla_nest_end(nl_msg, attr);

-    ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer, c, __func__);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

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


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23ad79e14844aefde9ece34dadef0b75ff267201
Gerrit-Change-Number: 1100
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--qHdP6SgZaGM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">dco_linux: fix async message reception<br><br>Currently whenever we send=
 a PEER_GET request to ovpn, we also<br>set the CB that is supposed to pars=
e the reply.<br><br>However, due to the async nature of netlink messages, w=
e could<br>get an unrelated notification, sent by ovpn upon some event,<br>=
after having set the CB, but before parsing the awaited reply.<br><br>When =
this happens, the notification is then parsed with the<br>configured CB ins=
tead of the notification parser, thus effectively<br>rejecting the notifica=
tion and losing the event.<br><br>To fix this inconsistency, make ovpn_hand=
le_msg() the default and<br>only netlink parser CB. It is configured upon D=
CO initialization<br>and is never removed.<br><br>ovpn_handle_msg() will ch=
eck the message type and will call the<br>according parser. This way, no ma=
tter what message we get at<br>what time, but we&#39;ll always parse it cor=
rectly.<br><br>As a bonus we can also simplify the nl_sendmsg() API as we<b=
r>don&#39;t need to pass the cb and its argument anymore.<br><br>The ID of =
the NLCTRL family is now also stored in the DCO<br>context as we need it to=
 check when we receive a mcast ID<br>lookup message.<br><br>Change-Id: I23a=
d79e14844aefde9ece34dadef0b75ff267201<br>Github: OpenVPN/openvpn#793<br>Sig=
ned-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/op=
envpn/dco_linux.c<br>M src/openvpn/dco_linux.h<br>2 files changed, 130 inse=
rtions(+), 85 deletions(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/00/1100/3</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux=
.c b/src/openvpn/dco_linux.c</span><br><span>index 0a22879..62052f3 100644<=
/span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/ope=
nvpn/dco_linux.c</span><br><span>@@ -172,18 +172,14 @@</span><br><span>  * =
The method will also free nl_msg</span><br><span>  * @param dco       The d=
co context to use</span><br><span>  * @param nl_msg    the message to use</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param cb        An =
optional callback if the caller expects an answer</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @param cb_arg    An optional param to pass t=
o the callback</span><br><span>  * @param prefix    A prefix to report in t=
he error message to give the user context</span><br><span>  * @return      =
    status of sending the message</span><br><span>  */</span><br><span> sta=
tic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_nl_msg_se=
nd(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb cb,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                 void *cb_arg, const=
 char *prefix)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_=
nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, const char *prefix)<=
/span><br><span> {</span><br><span>     dco-&gt;status =3D 1;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nl_cb_set(dco=
-&gt;nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, cb_arg);</span><br><span>     nl=
_send_auto(dco-&gt;nl_sock, nl_msg);</span><br><span> </span><br><span>    =
 while (dco-&gt;status =3D=3D 1)</span><br><span>@@ -285,7 +281,7 @@</span>=
<br><span>     }</span><br><span>     nla_nest_end(nl_msg, attr);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D o=
vpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg,=
 __func__);</span><br><span> </span><br><span> nla_put_failure:</span><br><=
span>     nlmsg_free(nl_msg);</span><br><span>@@ -385,6 +381,29 @@</span><b=
r><span> }</span><br><span> </span><br><span> static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_register(dco_context_t *dco)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, __func__);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ovpn_get_mcast_id(dco=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ovpn_dco_mcast_id &l=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;c=
annot get mcast group: %s&quot;,  nl_geterror(dco-&gt;ovpn_dco_mcast_id));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Register for ovpn-dco specific multicast messa=
ges that the kernel may</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * send</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D =
nl_socket_add_membership(dco-&gt;nl_sock, dco-&gt;ovpn_dco_mcast_id);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;%s: failed to join =
groups: %d&quot;, __func__, ret);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static int ovpn_handle_msg(struct nl_=
msg *msg, void *arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span> ovpn_dco_init_netlink(dco_context_t *dco)</span><br><span> {</s=
pan><br><span>     dco-&gt;ovpn_dco_id =3D resolve_ovpn_netlink_id(M_FATAL)=
;</span><br><span>@@ -420,11 +439,15 @@</span><br><span> </span><br><span> =
    nl_socket_set_cb(dco-&gt;nl_sock, dco-&gt;nl_cb);</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_message=
_peer_id =3D -1;</span><br><span>     nl_cb_err(dco-&gt;nl_cb, NL_CB_CUSTOM=
, ovpn_nl_cb_error, &amp;dco-&gt;status);</span><br><span>     nl_cb_set(dc=
o-&gt;nl_cb, NL_CB_FINISH, NL_CB_CUSTOM, ovpn_nl_cb_finish,</span><br><span=
>               &amp;dco-&gt;status);</span><br><span>     nl_cb_set(dco-&g=
t;nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish,</span><br><span>      =
         &amp;dco-&gt;status);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    nl_cb_set(dco-&gt;nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_han=
dle_msg, dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ovpn_dco_register(dc=
o);</span><br><span> </span><br><span>     /* The async PACKET messages con=
fuse libnl and it will drop them with</span><br><span>      * wrong sequenc=
e numbers (NLE_SEQ_MISMATCH), so disable libnl&#39;s sequence</span><br><sp=
an>@@ -476,27 +499,6 @@</span><br><span>     CLEAR(dco);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_regi=
ster(dco_context_t *dco)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEB=
UG, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ovp=
n_get_mcast_id(dco);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco-&gt;ovpn_d=
co_mcast_id &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATA=
L, &quot;cannot get mcast group: %s&quot;,  nl_geterror(dco-&gt;ovpn_dco_mc=
ast_id));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* Register for ovpn-dco specific multicast m=
essages that the kernel may</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     * send</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D nl=
_socket_add_membership(dco-&gt;nl_sock, dco-&gt;ovpn_dco_mcast_id);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ret)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;%s: failed to join groups: =
%d&quot;, __func__, ret);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br>=
<span> open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *=
dev)</span><br><span> {</span><br><span>@@ -516,10 +518,6 @@</span><br><spa=
n>         msg(M_FATAL, &quot;DCO: cannot retrieve ifindex for interface %s=
&quot;, dev);</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    tt-&gt;dco.dco_message_peer_id =3D -1;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ovpn_dco_register(&amp;tt-&gt;dco);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     re=
turn 0;</span><br><span> }</span><br><span> </span><br><span>@@ -548,7 +546=
,7 @@</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peer=
id);</span><br><span>     nla_nest_end(nl_msg, attr);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_s=
end(dco, nl_msg, NULL, NULL, __func__);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</s=
pan><br><span> </span><br><span> nla_put_failure:</span><br><span>     nlms=
g_free(nl_msg);</span><br><span>@@ -572,7 +570,7 @@</span><br><span>     NL=
A_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);</span><br><span>     nla_nest_en=
d(nl_msg, attr);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_=
nl_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_=
put_failure:</span><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -5=
98,7 +596,7 @@</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT=
, slot);</span><br><span>     nla_nest_end(nl_msg, keyconf);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_n=
l_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func=
__);</span><br><span> </span><br><span> nla_put_failure:</span><br><span>  =
   nlmsg_free(nl_msg);</span><br><span>@@ -657,7 +655,7 @@</span><br><span>=
     nla_nest_end(nl_msg, key_conf);</span><br><span> </span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_=
send(dco, nl_msg, NULL, NULL, __func__);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</=
span><br><span> </span><br><span> nla_put_failure:</span><br><span>     nlm=
sg_free(nl_msg);</span><br><span>@@ -686,7 +684,7 @@</span><br><span>      =
           keepalive_timeout);</span><br><span>     nla_nest_end(nl_msg, at=
tr);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(=
dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_put_failure:=
</span><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -754,7 +752,7 =
@@</span><br><span> </span><br><span>     /* Even though &#39;nlctrl&#39; i=
s a constant, there seem to be no library</span><br><span>      * provided =
define for it */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt ctrlid =3D genl_ctrl_resolve(dco-&gt;nl_sock, &quot;nlctrl&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;ctrlid =3D ge=
nl_ctrl_resolve(dco-&gt;nl_sock, &quot;nlctrl&quot;);</span><br><span> </sp=
an><br><span>     struct nl_msg *nl_msg =3D nlmsg_alloc();</span><br><span>=
     if (!nl_msg)</span><br><span>@@ -762,12 +760,12 @@</span><br><span>   =
      return -ENOMEM;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    genlmsg_put(nl_msg, 0, 0, ctrl=
id, 0, 0, CTRL_CMD_GETFAMILY, 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    genlmsg_put(nl_msg, 0, 0, dco-&gt;ctrlid, 0, 0, CTRL_CMD_=
GETFAMILY, 0);</span><br><span> </span><br><span>     int ret =3D -EMSGSIZE=
;</span><br><span>     NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_F=
AMILY_NAME);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, dc=
o, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
t =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br>=
<span> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</span><br>=
<span>@@ -879,23 +877,26 @@</span><br><span> }</span><br><span> </span><br>=
<span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_=
parse_peer_multi(struct nl_msg *msg, void *arg)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ovpn_handle_peer_multi(dco_context_t *dco, stru=
ct nlattr *attrs[])</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct nlattr *tb[OVPN_A_MAX + 1];</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct genlmsghdr *gnlh =3D nlmsg_dat=
a(nlmsg_hdr(msg));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>     msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __f=
unc__);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-              genlmsg_attrlen(gnlh, =
0), NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* th=
is function assumes openvpn is running in multipeer mode as</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * it accesses c-&gt;multi</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode !=3D OVPN_MOD=
E_MP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s=
: can&#39;t parse &#39;multi-peer&#39; message on P2P instance&quot;, __fun=
c__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
!tb[OVPN_A_PEER])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!attrs[OVPN_A_PEER])</span><br><span>     {</span><br><span>         =
return NL_SKIP;</span><br><span>     }</span><br><span> </span><br><span>  =
   struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb=
[OVPN_A_PEER], NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NULL);=
</span><br><span> </span><br><span>     if (!tb_peer[OVPN_A_PEER_ID])</span=
><br><span>     {</span><br><span>@@ -903,7 +904,7 @@</span><br><span>     =
    return NL_SKIP;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct multi_context *m =3D arg;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_co=
ntext *m =3D dco-&gt;c-&gt;multi;</span><br><span>     uint32_t peer_id =3D=
 nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span> </span><br><span>  =
   if (peer_id &gt;=3D m-&gt;max_clients || !m-&gt;instances[peer_id])</spa=
n><br><span>@@ -919,25 +920,18 @@</span><br><span> }</span><br><span> </spa=
n><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-dco_parse_peer(struct nl_msg *msg, void *arg)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ovpn_handle_peer(dco_context_t *dco, struct nla=
ttr *attrs[])</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct context *c =3D arg;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct nlattr *tb[OVPN_A_MAX + 1];</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct genlmsghdr *gnlh =3D nlmsg_=
data(nlmsg_hdr(msg));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, =
__func__);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-              genlmsg_attrlen(gnl=
h, 0), NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tb[OVPN_A_PEER])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_A_P=
EER])</span><br><span>     {</span><br><span>         msg(D_DCO_DEBUG, &quo=
t;%s: malformed reply&quot;, __func__);</span><br><span>         return NL_=
SKIP;</span><br><span>     }</span><br><span> </span><br><span>     struct =
nlattr *tb_peer[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PE=
ER], NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_=
parse_nested(tb_peer, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NULL);</span><br=
><span> </span><br><span>     if (!tb_peer[OVPN_A_PEER_ID])</span><br><span=
>     {</span><br><span>@@ -946,18 +940,39 @@</span><br><span>     }</span>=
<br><span> </span><br><span>     uint32_t peer_id =3D nla_get_u32(tb_peer[O=
VPN_A_PEER_ID]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (c-&gt;c2.tls_multi-&gt;dco_peer_id !=3D peer_id)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct context_2 *c2;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c2 =3D &amp;dco-&gt;c-&gt;c2;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        struct multi_instance *mi =3D dco-&gt;c-&gt;multi-&gt;=
instances[peer_id];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(M_WARN, &quot;%s: received data for a non-existing peer %u&quot;, __func=
__, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        c2 =3D &amp;mi-&gt;=
context.c2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* at this point this check should ne=
ver fail for MP mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * but it&#39;s still fully valid for P2P mode</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (c2-&gt;tls_multi-&gt;dco_peer_id !=3D peer_id=
)</span><br><span>     {</span><br><span>         return NL_SKIP;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    dco_update_peer_stat(&amp;c-&gt;c2, tb_peer, peer_id);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_update_peer_stat(c=
2, tb_peer, peer_id);</span><br><span> </span><br><span>     return NL_OK;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-ovpn_handle_peer_del_ntf(dco_context_t *dco, struct nlattr *attrs[])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ovpn_iface_check(dco_context_t=
 *dco, struct nlattr *attrs[])</span><br><span> {</span><br><span>     /* w=
e must know which interface this message is referring to in order to</span>=
<br><span>      * avoid mixing messages for other instances</span><br><span=
>@@ -965,6 +980,25 @@</span><br><span>     if (!attrs[OVPN_A_IFINDEX])</spa=
n><br><span>     {</span><br><span>         msg(D_DCO, &quot;ovpn-dco: Rece=
ived message without ifindex&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t i=
findex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (ifindex !=3D dco-&gt;ifindex)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            &quot;ovpn-dco: ignoring me=
ssage for foreign ifindex %d&quot;, ifindex);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ovpn_handle_peer_del_ntf(dco_context_t *dco, struct nl=
attr *attrs[])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ovpn_iface_che=
ck(dco, attrs))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span>         return NL_STOP;</span><br><span>     }</span><br=
><span> </span><br><span>@@ -1008,12 +1042,8 @@</span><br><span> static int=
</span><br><span> ovpn_handle_peer_float_ntf(dco_context_t *dco, struct nla=
ttr *attrs[])</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* we must know which interface this message is referring to=
 in order to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * av=
oid mixing messages for other instances</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (!attrs[OVPN_A_IFINDEX])</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!ovpn_iface_check(dco, attrs))</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO, =
&quot;ovpn-dco: Received message without ifindex&quot;);</span><br><span>  =
       return NL_STOP;</span><br><span>     }</span><br><span> </span><br><=
span>@@ -1058,12 +1088,8 @@</span><br><span> static int</span><br><span> ov=
pn_handle_key_swap_ntf(dco_context_t *dco, struct nlattr *attrs[])</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* we m=
ust know which interface this message is referring to in order to</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     * avoid mixing messages fo=
r other instances</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!attrs[OVP=
N_A_IFINDEX])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!ovpn_iface_check(dco, attrs))</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: Receiv=
ed message without ifindex&quot;);</span><br><span>         return NL_STOP;=
</span><br><span>     }</span><br><span> </span><br><span>@@ -1109,9 +1135,=
22 @@</span><br><span> {</span><br><span>     dco_context_t *dco =3D arg;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span>    =
 struct nlattr *attrs[OVPN_A_MAX + 1];</span><br><span>     struct nlmsghdr=
 *nlh =3D nlmsg_hdr(msg);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct genlmsghdr *gnlh =3D genlmsg_hdr(nlh);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;ovpn-dco: received netlink mess=
age type=3D%u cmd=3D%u flags=3D%#.4x&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        nlh-&gt;nlmsg_type, gnlh-&gt;cmd, nlh-&gt;n=
lmsg_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if we get a message=
 from the NLCTRL family, it means</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * this is the reply to the mcast ID resolution request</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and we parse i=
t accordingly.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (nlh-&gt;n=
lmsg_type =3D=3D dco-&gt;ctrlid)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(D_DCO_DEBUG, &quot;ovpn-dco: received CTRLID message&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return mcast_fa=
mily_handler(msg, dco);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span> </span><br><span>     if (!genlmsg_valid_hdr(nlh=
, 0))</span><br><span>     {</span><br><span>@@ -1126,15 +1165,6 @@</span><=
br><span>         return NL_STOP;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t ifindex =
=3D nla_get_u32(attrs[OVPN_A_IFINDEX]);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (ifindex !=3D dco-&gt;ifindex)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(D_DCO_DEBUG,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            &quot;ovpn-dco: ignoring message (type=3D%=
d) for foreign ifindex %d&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            gnlh-&gt;cmd, ifindex);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return NL_STOP;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span>     /* based on the message type, we parse the=
 subobject contained in the</span><br><span>      * message, that stores th=
e type-specific attributes.</span><br><span>      *</span><br><span>@@ -114=
4,6 +1174,21 @@</span><br><span>      */</span><br><span>     switch (gnlh-=
&gt;cmd)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        case OVPN_CMD_PEER_GET:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            /* this message is part of a peer list dump, henc=
e triggered</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
     * by a MP/server instance</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (nlh-&gt;nlmsg_flags &amp; NLM_F_MULTI)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                return ovpn_handle_peer=
_multi(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return ovpn_handle_peer(dco, attrs);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>         case OVPN_CMD_PEER_DEL_NTF:</span><br><span>   =
      {</span><br><span>             return ovpn_handle_peer_del_ntf(dco, a=
ttrs);</span><br><span>@@ -1172,7 +1217,6 @@</span><br><span> dco_do_read(d=
co_context_t *dco)</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG,=
 __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nl_cb_=
set(dco-&gt;nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);</span>=
<br><span> </span><br><span>     return ovpn_nl_recvmsgs(dco, __func__);</s=
pan><br><span> }</span><br><span>@@ -1187,7 +1231,7 @@</span><br><span> </s=
pan><br><span>     nlmsg_hdr(nl_msg)-&gt;nlmsg_flags |=3D NLM_F_DUMP;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int r=
et =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __func__);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D ovpn_n=
l_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br><span>     n=
lmsg_free(nl_msg);</span><br><span> </span><br><span>@@ -1225,7 +1269,7 @@<=
/span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);</span><b=
r><span>     nla_nest_end(nl_msg, attr);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_m=
sg, dco_parse_peer, c, __func__);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><b=
r><span> </span><br><span> nla_put_failure:</span><br><span>     nlmsg_free=
(nl_msg);</span><br><span>diff --git a/src/openvpn/dco_linux.h b/src/openvp=
n/dco_linux.h</span><br><span>index 5e61cf1..cc14f45 100644</span><br><span=
>--- a/src/openvpn/dco_linux.h</span><br><span>+++ b/src/openvpn/dco_linux.=
h</span><br><span>@@ -66,6 +66,7 @@</span><br><span>     int status;</span>=
<br><span> </span><br><span>     struct context *c;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int ctrlid;</span><br><span> </span><=
br><span>     enum ovpn_mode ifmode;</span><br><span> </span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1100?usp=3Demail">change 1100</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23ad79e14844aefde9ece34dade=
f0b75ff267201 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1100 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--qHdP6SgZaGM=--

