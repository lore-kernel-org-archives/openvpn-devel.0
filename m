From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 22 Jul 2025 20:22:23 +0000
References: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <deb40d0222bb59d20a95e9afb70d16b85209caed-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="++K2NxgjKMg="; charset=UTF-8
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

--++K2NxgjKMg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail

to review the following change.


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
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
2 files changed, 130 insertions(+), 85 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1100/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--++K2NxgjKMg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco_linux: fix async message reception<br><br>Currently when=
ever we send a PEER_GET request to ovpn, we also<br>set the CB that is supp=
osed to parse the reply.<br><br>However, due to the async nature of netlink=
 messages, we could<br>get an unrelated notification, sent by ovpn upon som=
e event,<br>after having set the CB, but before parsing the awaited reply.<=
br><br>When this happens, the notification is then parsed with the<br>confi=
gured CB instead of the notification parser, thus effectively<br>rejecting =
the notification and losing the event.<br><br>To fix this inconsistency, ma=
ke ovpn_handle_msg() the default and<br>only netlink parser CB. It is confi=
gured upon DCO initialization<br>and is never removed.<br><br>ovpn_handle_m=
sg() will check the message type and will call the<br>according parser. Thi=
s way, no matter what message we get at<br>what time, but we&#39;ll always =
parse it correctly.<br><br>As a bonus we can also simplify the nl_sendmsg()=
 API as we<br>don&#39;t need to pass the cb and its argument anymore.<br><b=
r>The ID of the NLCTRL family is now also stored in the DCO<br>context as w=
e need it to check when we receive a mcast ID<br>lookup message.<br><br>Cha=
nge-Id: I23ad79e14844aefde9ece34dadef0b75ff267201<br>Signed-off-by: Antonio=
 Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/openvpn/dco_linux.c<b=
r>M src/openvpn/dco_linux.h<br>2 files changed, 130 insertions(+), 85 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/00/1100/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dc=
o_linux.c</span><br><span>index 0a22879..62052f3 100644</span><br><span>---=
 a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</s=
pan><br><span>@@ -172,18 +172,14 @@</span><br><span>  * The method will als=
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
tus =3D=3D 1)</span><br><span>@@ -285,7 +281,7 @@</span><br><span>     }</s=
pan><br><span>     nla_nest_end(nl_msg, attr);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco=
, nl_msg, NULL, NULL, __func__);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br=
><span> </span><br><span> nla_put_failure:</span><br><span>     nlmsg_free(=
nl_msg);</span><br><span>@@ -385,6 +381,29 @@</span><br><span> }</span><br>=
<span> </span><br><span> static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ovpn_dco_register(dco_context_t *dco)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_DCO_DEBUG, __func__);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ovpn_get_mcast_id(dco);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (dco-&gt;ovpn_dco_mcast_id &lt; 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;cannot get mcast group=
: %s&quot;,  nl_geterror(dco-&gt;ovpn_dco_mcast_id));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Register for ovpn-dco specific multicast messages that the kernel m=
ay</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * send</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int ret =3D nl_socket_add_members=
hip(dco-&gt;nl_sock, dco-&gt;ovpn_dco_mcast_id);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (ret)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_FATAL, &quot;%s: failed to join groups: %d&quot;, __f=
unc__, ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static int ovpn_handle_msg(struct nl_msg *msg, void *arg);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> ovpn_dco_=
init_netlink(dco_context_t *dco)</span><br><span> {</span><br><span>     dc=
o-&gt;ovpn_dco_id =3D resolve_ovpn_netlink_id(M_FATAL);</span><br><span>@@ =
-420,11 +439,15 @@</span><br><span> </span><br><span>     nl_socket_set_cb(=
dco-&gt;nl_sock, dco-&gt;nl_cb);</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_peer_id =3D -1;</spa=
n><br><span>     nl_cb_err(dco-&gt;nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &=
amp;dco-&gt;status);</span><br><span>     nl_cb_set(dco-&gt;nl_cb, NL_CB_FI=
NISH, NL_CB_CUSTOM, ovpn_nl_cb_finish,</span><br><span>               &amp;=
dco-&gt;status);</span><br><span>     nl_cb_set(dco-&gt;nl_cb, NL_CB_ACK, N=
L_CB_CUSTOM, ovpn_nl_cb_finish,</span><br><span>               &amp;dco-&gt=
;status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nl_cb_=
set(dco-&gt;nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ovpn_dco_register(dco);</span><br><span> =
</span><br><span>     /* The async PACKET messages confuse libnl and it wil=
l drop them with</span><br><span>      * wrong sequence numbers (NLE_SEQ_MI=
SMATCH), so disable libnl&#39;s sequence</span><br><span>@@ -476,27 +499,6 =
@@</span><br><span>     CLEAR(dco);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_register(dco_context_t *d=
co)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, __func__);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ovpn_get_mcast_id(dco);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (dco-&gt;ovpn_dco_mcast_id &lt; 0)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;cannot get m=
cast group: %s&quot;,  nl_geterror(dco-&gt;ovpn_dco_mcast_id));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* Register for ovpn-dco specific multicast messages that the kern=
el may</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * send</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int ret =3D nl_socket_add_membershi=
p(dco-&gt;nl_sock, dco-&gt;ovpn_dco_mcast_id);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (ret)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(M_FATAL, &quot;%s: failed to join groups: %d&quot;, __func__, r=
et);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> open_tun_dco(s=
truct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)</span><br><span>=
 {</span><br><span>@@ -516,10 +518,6 @@</span><br><span>         msg(M_FATA=
L, &quot;DCO: cannot retrieve ifindex for interface %s&quot;, dev);</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    tt-&gt;dco.dco_message_peer_id =3D -1;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ovpn_dco_register(&amp;tt-&gt;dco);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     return 0;</span><br><=
span> }</span><br><span> </span><br><span>@@ -548,7 +546,7 @@</span><br><sp=
an>     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);</span><br><spa=
n>     nla_nest_end(nl_msg, attr);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, N=
ULL, NULL, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> </s=
pan><br><span> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</s=
pan><br><span>@@ -572,7 +570,7 @@</span><br><span>     NLA_PUT_U32(nl_msg, =
OVPN_A_PEER_ID, peerid);</span><br><span>     nla_nest_end(nl_msg, attr);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
et =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, n=
l_msg, __func__);</span><br><span> </span><br><span> nla_put_failure:</span=
><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -598,7 +596,7 @@</sp=
an><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);</span><br=
><span>     nla_nest_end(nl_msg, keyconf);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl=
_msg, NULL, NULL, __func__);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><sp=
an> </span><br><span> nla_put_failure:</span><br><span>     nlmsg_free(nl_m=
sg);</span><br><span>@@ -657,7 +655,7 @@</span><br><span>     nla_nest_end(=
nl_msg, key_conf);</span><br><span> </span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, =
NULL, NULL, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> </=
span><br><span> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</=
span><br><span>@@ -686,7 +684,7 @@</span><br><span>                 keepali=
ve_timeout);</span><br><span>     nla_nest_end(nl_msg, attr);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_=
nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __fun=
c__);</span><br><span> </span><br><span> nla_put_failure:</span><br><span> =
    nlmsg_free(nl_msg);</span><br><span>@@ -754,7 +752,7 @@</span><br><span=
> </span><br><span>     /* Even though &#39;nlctrl&#39; is a constant, ther=
e seem to be no library</span><br><span>      * provided define for it */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ctrlid =3D genl=
_ctrl_resolve(dco-&gt;nl_sock, &quot;nlctrl&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;ctrlid =3D genl_ctrl_resolve(=
dco-&gt;nl_sock, &quot;nlctrl&quot;);</span><br><span> </span><br><span>   =
  struct nl_msg *nl_msg =3D nlmsg_alloc();</span><br><span>     if (!nl_msg=
)</span><br><span>@@ -762,12 +760,12 @@</span><br><span>         return -EN=
OMEM;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    genlmsg_put(nl_msg, 0, 0, ctrlid, 0, 0, CTRL_C=
MD_GETFAMILY, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  genlmsg_put(nl_msg, 0, 0, dco-&gt;ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);</=
span><br><span> </span><br><span>     int ret =3D -EMSGSIZE;</span><br><spa=
n>     NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_FAMILY_NAME);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
 =3D ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, dco, __func__);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_ms=
g_send(dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_put_f=
ailure:</span><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -879,23=
 +877,26 @@</span><br><span> }</span><br><span> </span><br><span> static in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_parse_peer_multi=
(struct nl_msg *msg, void *arg)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ovpn_handle_peer_multi(dco_context_t *dco, struct nlattr *attrs=
[])</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct nlattr *tb[OVPN_A_MAX + 1];</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>  =
   msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __func__);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_pars=
e(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-              genlmsg_attrlen(gnlh, 0), NULL);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* this function assu=
mes openvpn is running in multipeer mode as</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * it accesses c-&gt;multi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode !=3D OVPN_MODE_MP)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s: can&#39;t pars=
e &#39;multi-peer&#39; message on P2P instance&quot;, __func__);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return NL_SKIP;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tb[OVPN_A_PEER]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVP=
N_A_PEER])</span><br><span>     {</span><br><span>         return NL_SKIP;<=
/span><br><span>     }</span><br><span> </span><br><span>     struct nlattr=
 *tb_peer[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_parse_=
nested(tb_peer, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NULL);</span><br><span=
> </span><br><span>     if (!tb_peer[OVPN_A_PEER_ID])</span><br><span>     =
{</span><br><span>@@ -903,7 +904,7 @@</span><br><span>         return NL_SK=
IP;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct multi_context *m =3D arg;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D dco=
-&gt;c-&gt;multi;</span><br><span>     uint32_t peer_id =3D nla_get_u32(tb_=
peer[OVPN_A_PEER_ID]);</span><br><span> </span><br><span>     if (peer_id &=
gt;=3D m-&gt;max_clients || !m-&gt;instances[peer_id])</span><br><span>@@ -=
919,25 +920,18 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_parse_peer=
(struct nl_msg *msg, void *arg)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ovpn_handle_peer(dco_context_t *dco, struct nlattr *attrs[])</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct context *c =3D arg;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct nlattr *tb[OVPN_A_MAX + 1];</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(m=
sg));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
>     msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __func__);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_p=
arse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-              genlmsg_attrlen(gnlh, 0), NULL);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!tb[OVPN_A_PEER])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_A_PEER])</span><b=
r><span>     {</span><br><span>         msg(D_DCO_DEBUG, &quot;%s: malforme=
d reply&quot;, __func__);</span><br><span>         return NL_SKIP;</span><b=
r><span>     }</span><br><span> </span><br><span>     struct nlattr *tb_pee=
r[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_parse_nested(t=
b_peer, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NULL);</span><br><span> </span=
><br><span>     if (!tb_peer[OVPN_A_PEER_ID])</span><br><span>     {</span>=
<br><span>@@ -946,18 +940,39 @@</span><br><span>     }</span><br><span> </s=
pan><br><span>     uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.tl=
s_multi-&gt;dco_peer_id !=3D peer_id)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct context_2 *c2;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        c2 =3D &amp;dco-&gt;c-&gt;c2;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   struct multi_instance *mi =3D dco-&gt;c-&gt;multi-&gt;instances[peer_id]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!mi)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;%=
s: received data for a non-existing peer %u&quot;, __func__, peer_id);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return NL_SK=
IP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        c2 =3D &amp;mi-&gt;context.c2;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* at this point this check should never fail for MP mo=
de,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * but it&#3=
9;s still fully valid for P2P mode</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (c2-&gt;tls_multi-&gt;dco_peer_id !=3D peer_id)</span><br><span> =
    {</span><br><span>         return NL_SKIP;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_u=
pdate_peer_stat(&amp;c-&gt;c2, tb_peer, peer_id);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    dco_update_peer_stat(c2, tb_peer, peer_id=
);</span><br><span> </span><br><span>     return NL_OK;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_handle_pee=
r_del_ntf(dco_context_t *dco, struct nlattr *attrs[])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ovpn_iface_check(dco_context_t *dco, struct nlatt=
r *attrs[])</span><br><span> {</span><br><span>     /* we must know which i=
nterface this message is referring to in order to</span><br><span>      * a=
void mixing messages for other instances</span><br><span>@@ -965,6 +980,25 =
@@</span><br><span>     if (!attrs[OVPN_A_IFINDEX])</span><br><span>     {<=
/span><br><span>         msg(D_DCO, &quot;ovpn-dco: Received message withou=
t ifindex&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    uint32_t ifindex =3D nla_get_=
u32(attrs[OVPN_A_IFINDEX]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (ifindex !=3D dco-&gt;ifindex)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(D_DCO_DEBUG,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;ovpn-dco: ignoring message for foreign i=
findex %d&quot;, ifindex);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ovpn_handle_peer_del_ntf(dco_context_t *dco, struct nlattr *attrs[])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!ovpn_iface_check(dco, attrs))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span>=
         return NL_STOP;</span><br><span>     }</span><br><span> </span><br=
><span>@@ -1008,12 +1042,8 @@</span><br><span> static int</span><br><span> =
ovpn_handle_peer_float_ntf(dco_context_t *dco, struct nlattr *attrs[])</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
we must know which interface this message is referring to in order to</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-     * avoid mixing message=
s for other instances</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!attrs=
[OVPN_A_IFINDEX])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!ovpn_iface_check(dco, attrs))</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: Re=
ceived message without ifindex&quot;);</span><br><span>         return NL_S=
TOP;</span><br><span>     }</span><br><span> </span><br><span>@@ -1058,12 +=
1088,8 @@</span><br><span> static int</span><br><span> ovpn_handle_key_swap=
_ntf(dco_context_t *dco, struct nlattr *attrs[])</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* we must know which int=
erface this message is referring to in order to</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     * avoid mixing messages for other instances<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (!attrs[OVPN_A_IFINDEX])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ovpn_iface_chec=
k(dco, attrs))</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: Received message without=
 ifindex&quot;);</span><br><span>         return NL_STOP;</span><br><span> =
    }</span><br><span> </span><br><span>@@ -1109,9 +1135,22 @@</span><br><s=
pan> {</span><br><span>     dco_context_t *dco =3D arg;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct genlmsghdr *=
gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span>     struct nlattr *at=
trs[OVPN_A_MAX + 1];</span><br><span>     struct nlmsghdr *nlh =3D nlmsg_hd=
r(msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
enlmsghdr *gnlh =3D genlmsg_hdr(nlh);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msg(D_DCO_DEBUG, &quot;ovpn-dco: received netlink message type=3D%u cmd=
=3D%u flags=3D%#.4x&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        nlh-&gt;nlmsg_type, gnlh-&gt;cmd, nlh-&gt;nlmsg_flags);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* if we get a message from the NLCTR=
L family, it means</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * this is the reply to the mcast ID resolution request</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * and we parse it accordingly.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (nlh-&gt;nlmsg_type =3D=
=3D dco-&gt;ctrlid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_=
DCO_DEBUG, &quot;ovpn-dco: received CTRLID message&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return mcast_family_handler(=
msg, dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span> </span><br><span>     if (!genlmsg_valid_hdr(nlh, 0))</span><=
br><span>     {</span><br><span>@@ -1126,15 +1165,6 @@</span><br><span>    =
     return NL_STOP;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    uint32_t ifindex =3D nla_get_u3=
2(attrs[OVPN_A_IFINDEX]);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (ifindex !=3D dco-&gt;ifindex)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msg(D_DCO_DEBUG,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            &quot;ovpn-dco: ignoring message (type=3D%d) for foreign=
 ifindex %d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         gnlh-&gt;cmd, ifindex);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        return NL_STOP;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>     /* based on the message type, we parse the subobject con=
tained in the</span><br><span>      * message, that stores the type-specifi=
c attributes.</span><br><span>      *</span><br><span>@@ -1144,6 +1174,21 @=
@</span><br><span>      */</span><br><span>     switch (gnlh-&gt;cmd)</span=
><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      case OVPN_CMD_PEER_GET:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /* this message is part of a peer list dump, hence triggered</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             * by a MP=
/server instance</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (nlh-&gt;nlmsg_flags &amp; NLM_F_MULTI)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                return ovpn_handle_peer_multi(dco, at=
trs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                return ovpn_h=
andle_peer(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>         case OVPN_CMD_PEER_DEL_NTF:</span><br><span>         {</span>=
<br><span>             return ovpn_handle_peer_del_ntf(dco, attrs);</span><=
br><span>@@ -1172,7 +1217,6 @@</span><br><span> dco_do_read(dco_context_t *=
dco)</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, __func__);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    nl_cb_set(dco-&gt;nl=
_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);</span><br><span> </s=
pan><br><span>     return ovpn_nl_recvmsgs(dco, __func__);</span><br><span>=
 }</span><br><span>@@ -1187,7 +1231,7 @@</span><br><span> </span><br><span>=
     nlmsg_hdr(nl_msg)-&gt;nlmsg_flags |=3D NLM_F_DUMP;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D ovpn_nl=
_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __func__);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D ovpn_nl_msg_send(dco=
, nl_msg, __func__);</span><br><span> </span><br><span>     nlmsg_free(nl_m=
sg);</span><br><span> </span><br><span>@@ -1225,7 +1269,7 @@</span><br><spa=
n>     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);</span><br><span>     n=
la_nest_end(nl_msg, attr);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_=
peer, c, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> </spa=
n><br><span> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</spa=
n><br><span>diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h<=
/span><br><span>index 5e61cf1..cc14f45 100644</span><br><span>--- a/src/ope=
nvpn/dco_linux.h</span><br><span>+++ b/src/openvpn/dco_linux.h</span><br><s=
pan>@@ -66,6 +66,7 @@</span><br><span>     int status;</span><br><span> </s=
pan><br><span>     struct context *c;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int ctrlid;</span><br><span> </span><br><span>     en=
um ovpn_mode ifmode;</span><br><span> </span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3D=
email">change 1100</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23ad79e14844aefde9ece34dade=
f0b75ff267201 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1100 </div>
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


--++K2NxgjKMg=--

