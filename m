From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 22:00:13 +0000
In-Reply-To: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
References: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <8e01e99c68a9192bf8f0467c4d8015146bd29827-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tPhZfurvShQ="; charset=UTF-8
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

--tPhZfurvShQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


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
2 files changed, 110 insertions(+), 67 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1100/5

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 7c639d9..728fb7e 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -167,23 +167,19 @@
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
@@ -879,31 +877,34 @@
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
-        msg(M_WARN, "%s: no peer-id provided in reply", __func__);
+        msg(M_WARN, "ovpn-dco: no peer-id provided in (MULTI) PEER_GET rep=
ly");
         return NL_SKIP;
     }

-    struct multi_context *m =3D arg;
+    struct multi_context *m =3D dco->c->multi;
     uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);

     if (peer_id >=3D m->max_clients || !m->instances[peer_id])
@@ -919,39 +920,53 @@
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
-        msg(M_WARN, "%s: no peer-id provided in reply", __func__);
+        msg(M_WARN, "ovpn-dco: no peer-id provided in PEER_GET reply");
         return NL_SKIP;
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
@@ -1120,9 +1135,22 @@
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

     nlmsg_hdr(nl_msg)->nlmsg_flags |=3D NLM_F_DUMP;

-    int ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __f=
unc__);
+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);

     nlmsg_free(nl_msg);

@@ -1227,7 +1269,7 @@
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
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--tPhZfurvShQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>ordex <strong>uploaded patch set #5</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco_linux: fix async message reception<br><br>Curren=
tly whenever we send a PEER_GET request to ovpn, we also<br>set the CB that=
 is supposed to parse the reply.<br><br>However, due to the async nature of=
 netlink messages, we could<br>get an unrelated notification, sent by ovpn =
upon some event,<br>after having set the CB, but before parsing the awaited=
 reply.<br><br>When this happens, the notification is then parsed with the<=
br>configured CB instead of the notification parser, thus effectively<br>re=
jecting the notification and losing the event.<br><br>To fix this inconsist=
ency, make ovpn_handle_msg() the default and<br>only netlink parser CB. It =
is configured upon DCO initialization<br>and is never removed.<br><br>ovpn_=
handle_msg() will check the message type and will call the<br>according par=
ser. This way, no matter what message we get at<br>what time, but we&#39;ll=
 always parse it correctly.<br><br>As a bonus we can also simplify the nl_s=
endmsg() API as we<br>don&#39;t need to pass the cb and its argument anymor=
e.<br><br>The ID of the NLCTRL family is now also stored in the DCO<br>cont=
ext as we need it to check when we receive a mcast ID<br>lookup message.<br=
><br>Change-Id: I23ad79e14844aefde9ece34dadef0b75ff267201<br>Github: OpenVP=
N/openvpn#793<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt=
;<br>---<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_linux.h<br>2 fil=
es changed, 110 insertions(+), 67 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/00/1100/5</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/s=
rc/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 7c63=
9d9..728fb7e 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br=
><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -167,23 +167,19 @@<=
/span><br><span> }</span><br><span> </span><br><span> /**</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Send a prepared netlink message and =
registers cb as callback if non-null.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Send a prepared netlink message.</span><br><span>  *</=
span><br><span>  * The method will also free nl_msg</span><br><span>  * @pa=
ram dco       The dco context to use</span><br><span>  * @param nl_msg    t=
he message to use</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
param cb        An optional callback if the caller expects an answer</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param cb_arg    An optio=
nal param to pass to the callback</span><br><span>  * @param prefix    A pr=
efix to report in the error message to give the user context</span><br><spa=
n>  * @return          status of sending the message</span><br><span>  */</=
span><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb=
 cb,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
void *cb_arg, const char *prefix)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, c=
onst char *prefix)</span><br><span> {</span><br><span>     dco-&gt;status =
=3D 1;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    nl_cb_set(dco-&gt;nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, cb_arg);</sp=
an><br><span>     nl_send_auto(dco-&gt;nl_sock, nl_msg);</span><br><span> <=
/span><br><span>     while (dco-&gt;status =3D=3D 1)</span><br><span>@@ -28=
5,7 +281,7 @@</span><br><span>     }</span><br><span>     nla_nest_end(nl_m=
sg, attr);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg=
_send(dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_put_fa=
ilure:</span><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -385,6 +=
381,29 @@</span><br><span> }</span><br><span> </span><br><span> static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_register(d=
co_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG=
, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ovp=
n_get_mcast_id(dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ov=
pn_dco_mcast_id &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_FATAL, &quot;cannot get mcast group: %s&quot;,  nl_geterror(dco-&gt;ovp=
n_dco_mcast_id));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Register for ovpn-dco specif=
ic multicast messages that the kernel may</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * send</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int ret =3D nl_socket_add_membership(dco-&gt;nl_sock, dco-&gt;ovpn_dc=
o_mcast_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;%=
s: failed to join groups: %d&quot;, __func__, ret);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int ovpn_h=
andle_msg(struct nl_msg *msg, void *arg);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span> ovpn_dco_init_netlink(dco_context_t *dco)</=
span><br><span> {</span><br><span>     dco-&gt;ovpn_dco_id =3D resolve_ovpn=
_netlink_id(M_FATAL);</span><br><span>@@ -420,11 +439,15 @@</span><br><span=
> </span><br><span>     nl_socket_set_cb(dco-&gt;nl_sock, dco-&gt;nl_cb);</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 dco-&gt;dco_message_peer_id =3D -1;</span><br><span>     nl_cb_err(dco-&gt=
;nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &amp;dco-&gt;status);</span><br><sp=
an>     nl_cb_set(dco-&gt;nl_cb, NL_CB_FINISH, NL_CB_CUSTOM, ovpn_nl_cb_fin=
ish,</span><br><span>               &amp;dco-&gt;status);</span><br><span> =
    nl_cb_set(dco-&gt;nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish,</s=
pan><br><span>               &amp;dco-&gt;status);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    nl_cb_set(dco-&gt;nl_cb, NL_CB_VALID, NL=
_CB_CUSTOM, ovpn_handle_msg, dco);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ovpn_dco_register(dco);</span><br><span> </span><br><span>     /* The async=
 PACKET messages confuse libnl and it will drop them with</span><br><span> =
     * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libnl&#39;s se=
quence</span><br><span>@@ -476,27 +499,6 @@</span><br><span>     CLEAR(dco)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-ovpn_dco_register(dco_context_t *dco)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    msg(D_DCO_DEBUG, __func__);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ovpn_get_mcast_id(dco);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (dco-&gt;ovpn_dco_mcast_id &lt; 0)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_FATAL, &quot;cannot get mcast group: %s&quot;,  nl_geterror=
(dco-&gt;ovpn_dco_mcast_id));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Register for ovpn-dco =
specific multicast messages that the kernel may</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     * send</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int ret =3D nl_socket_add_membership(dco-&gt;nl_sock, dco-&gt;ovpn_dc=
o_mcast_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r=
et)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;%s: fai=
led to join groups: %d&quot;, __func__, ret);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> int</span><br><span> open_tun_dco(struct tuntap *tt, openvpn_net_ctx_=
t *ctx, const char *dev)</span><br><span> {</span><br><span>@@ -516,10 +518=
,6 @@</span><br><span>         msg(M_FATAL, &quot;DCO: cannot retrieve ifin=
dex for interface %s&quot;, dev);</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tt-&gt;dco.dco_mes=
sage_peer_id =3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ovpn_dco_register(=
&amp;tt-&gt;dco);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     return 0;</span><br><span> }</span><br><span> </span><br>=
<span>@@ -548,7 +546,7 @@</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_K=
EYCONF_PEER_ID, peerid);</span><br><span>     nla_nest_end(nl_msg, attr);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
et =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, n=
l_msg, __func__);</span><br><span> </span><br><span> nla_put_failure:</span=
><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -572,7 +570,7 @@</sp=
an><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);</span><br><s=
pan>     nla_nest_end(nl_msg, attr);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, =
NULL, NULL, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> </=
span><br><span> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</=
span><br><span>@@ -598,7 +596,7 @@</span><br><span>     NLA_PUT_U32(nl_msg,=
 OVPN_A_KEYCONF_SLOT, slot);</span><br><span>     nla_nest_end(nl_msg, keyc=
onf);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send=
(dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_put_failure=
:</span><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -657,7 +655,7=
 @@</span><br><span>     nla_nest_end(nl_msg, key_conf);</span><br><span> <=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, =
nl_msg, __func__);</span><br><span> </span><br><span> nla_put_failure:</spa=
n><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -686,7 +684,7 @@</s=
pan><br><span>                 keepalive_timeout);</span><br><span>     nla=
_nest_end(nl_msg, attr);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, =
__func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br><s=
pan> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</span><br><s=
pan>@@ -754,7 +752,7 @@</span><br><span> </span><br><span>     /* Even thou=
gh &#39;nlctrl&#39; is a constant, there seem to be no library</span><br><s=
pan>      * provided define for it */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int ctrlid =3D genl_ctrl_resolve(dco-&gt;nl_sock, &quot=
;nlctrl&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
dco-&gt;ctrlid =3D genl_ctrl_resolve(dco-&gt;nl_sock, &quot;nlctrl&quot;);<=
/span><br><span> </span><br><span>     struct nl_msg *nl_msg =3D nlmsg_allo=
c();</span><br><span>     if (!nl_msg)</span><br><span>@@ -762,12 +760,12 @=
@</span><br><span>         return -ENOMEM;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    genlmsg_p=
ut(nl_msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    genlmsg_put(nl_msg, 0, 0, dco-&gt;ct=
rlid, 0, 0, CTRL_CMD_GETFAMILY, 0);</span><br><span> </span><br><span>     =
int ret =3D -EMSGSIZE;</span><br><span>     NLA_PUT_STRING(nl_msg, CTRL_ATT=
R_FAMILY_NAME, OVPN_FAMILY_NAME);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, m=
cast_family_handler, dco, __func__);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span=
><br><span> </span><br><span> nla_put_failure:</span><br><span>     nlmsg_f=
ree(nl_msg);</span><br><span>@@ -879,31 +877,34 @@</span><br><span> }</span=
><br><span> </span><br><span> static int</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-dco_parse_peer_multi(struct nl_msg *msg, void *arg)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_handle_peer_multi(d=
co_context_t *dco, struct nlattr *attrs[])</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb[OVPN_A_MAX + =
1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct genlmsg=
hdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: parsin=
g message...&quot;, __func__);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(g=
nlh, 0),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
 genlmsg_attrlen(gnlh, 0), NULL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* this function assumes openvpn is running in multipeer =
mode as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * it ac=
cesses c-&gt;multi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&=
gt;ifmode !=3D OVPN_MODE_MP)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_WARN, &quot;%s: can&#39;t parse &#39;multi-peer&#39; message on P2=
P instance&quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return NL_SKIP;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (!tb[OVPN_A_PEER])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!attrs[OVPN_A_PEER])</span><br><span>     {</s=
pan><br><span>         return NL_SKIP;</span><br><span>     }</span><br><sp=
an> </span><br><span>     struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_parse_nested(tb_pe=
er, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, att=
rs[OVPN_A_PEER], NULL);</span><br><span> </span><br><span>     if (!tb_peer=
[OVPN_A_PEER_ID])</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no peer-id provided in rep=
ly&quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(M_WARN, &quot;ovpn-dco: no peer-id provided in (MULTI) PEER_GE=
T reply&quot;);</span><br><span>         return NL_SKIP;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct multi_context *m =3D arg;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct multi_context *m =3D dco-&gt;c-&gt;multi;</spa=
n><br><span>     uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);=
</span><br><span> </span><br><span>     if (peer_id &gt;=3D m-&gt;max_clien=
ts || !m-&gt;instances[peer_id])</span><br><span>@@ -919,39 +920,53 @@</spa=
n><br><span> }</span><br><span> </span><br><span> static int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-dco_parse_peer(struct nl_msg *msg, v=
oid *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_handl=
e_peer(dco_context_t *dco, struct nlattr *attrs[])</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D a=
rg;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr =
*tb[OVPN_A_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     msg(D_DCO_DEBUG,=
 &quot;%s: parsing message...&quot;, __func__);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb, OVPN_A_MAX, g=
enlmsg_attrdata(gnlh, 0),</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-              genlmsg_attrlen(gnlh, 0), NULL);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (!tb[OVPN_A_PEER])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!attrs[OVPN_A_PEER])</span><br><span>     {</span><br=
><span>         msg(D_DCO_DEBUG, &quot;%s: malformed reply&quot;, __func__)=
;</span><br><span>         return NL_SKIP;</span><br><span>     }</span><br=
><span> </span><br><span>     struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_parse_nested(t=
b_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX,=
 attrs[OVPN_A_PEER], NULL);</span><br><span> </span><br><span>     if (!tb_=
peer[OVPN_A_PEER_ID])</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no peer-id provided in=
 reply&quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_WARN, &quot;ovpn-dco: no peer-id provided in PEER_GET re=
ply&quot;);</span><br><span>         return NL_SKIP;</span><br><span>     }=
</span><br><span> </span><br><span>     uint32_t peer_id =3D nla_get_u32(tb=
_peer[OVPN_A_PEER_ID]);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (c-&gt;c2.tls_multi-&gt;dco_peer_id !=3D peer_id)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct context_2 *c2;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        c2 =3D &amp;dco-&gt;c-&gt;c2;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct multi_instance *mi =3D dco-&gt;c-&gt;multi-&=
gt;instances[peer_id];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(M_WARN, &quot;%s: received data for a non-existing peer %u&quot;, __f=
unc__, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        c2 =3D &amp;mi-&=
gt;context.c2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* at this point this check should=
 never fail for MP mode,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * but it&#39;s still fully valid for P2P mode</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (c2-&gt;tls_multi-&gt;dco_peer_id !=3D peer_=
id)</span><br><span>     {</span><br><span>         return NL_SKIP;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    dco_update_peer_stat(&amp;c-&gt;c2, tb_peer, peer_id);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_update_peer_stat=
(c2, tb_peer, peer_id);</span><br><span> </span><br><span>     return NL_OK=
;</span><br><span> }</span><br><span>@@ -1120,9 +1135,22 @@</span><br><span=
> {</span><br><span>     dco_context_t *dco =3D arg;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct genlmsghdr *gnl=
h =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span>     struct nlattr *attrs=
[OVPN_A_MAX + 1];</span><br><span>     struct nlmsghdr *nlh =3D nlmsg_hdr(m=
sg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct genl=
msghdr *gnlh =3D genlmsg_hdr(nlh);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
msg(D_DCO_DEBUG, &quot;ovpn-dco: received netlink message type=3D%u cmd=3D%=
u flags=3D%#.4x&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        nlh-&gt;nlmsg_type, gnlh-&gt;cmd, nlh-&gt;nlmsg_flags);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* if we get a message from the NLCTRL fami=
ly, it means</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
this is the reply to the mcast ID resolution request</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * and we parse it accordingly.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (nlh-&gt;nlmsg_type =3D=3D dco=
-&gt;ctrlid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEB=
UG, &quot;ovpn-dco: received CTRLID message&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return mcast_family_handler(msg, =
dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span> </span><br><span>     if (!genlmsg_valid_hdr(nlh, 0))</span><br><s=
pan>     {</span><br><span>@@ -1146,6 +1174,21 @@</span><br><span>      */<=
/span><br><span>     switch (gnlh-&gt;cmd)</span><br><span>     {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        case OVPN_CMD_PEER_GE=
T:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            /* this message=
 is part of a peer list dump, hence triggered</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             * by a MP/server instance</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+             */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (nlh-&gt;nlmsg_flag=
s &amp; NLM_F_MULTI)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           return ovpn_handle_peer_multi(dco, attrs);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                return ovpn_handle_peer(dco, attrs);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         case OVPN_CMD=
_PEER_DEL_NTF:</span><br><span>         {</span><br><span>             retu=
rn ovpn_handle_peer_del_ntf(dco, attrs);</span><br><span>@@ -1174,7 +1217,6=
 @@</span><br><span> dco_do_read(dco_context_t *dco)</span><br><span> {</sp=
an><br><span>     msg(D_DCO_DEBUG, __func__);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    nl_cb_set(dco-&gt;nl_cb, NL_CB_VALID, NL_CB_CUS=
TOM, ovpn_handle_msg, dco);</span><br><span> </span><br><span>     return o=
vpn_nl_recvmsgs(dco, __func__);</span><br><span> }</span><br><span>@@ -1189=
,7 +1231,7 @@</span><br><span> </span><br><span>     nlmsg_hdr(nl_msg)-&gt;=
nlmsg_flags |=3D NLM_F_DUMP;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_=
parse_peer_multi, m, __func__);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span>=
<br><span> </span><br><span>     nlmsg_free(nl_msg);</span><br><span> </spa=
n><br><span>@@ -1227,7 +1269,7 @@</span><br><span>     NLA_PUT_U32(nl_msg, =
OVPN_A_PEER_ID, peer_id);</span><br><span>     nla_nest_end(nl_msg, attr);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer, c, __func__);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_sen=
d(dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_put_failur=
e:</span><br><span>     nlmsg_free(nl_msg);</span><br><span>diff --git a/sr=
c/openvpn/dco_linux.h b/src/openvpn/dco_linux.h</span><br><span>index 5e61c=
f1..cc14f45 100644</span><br><span>--- a/src/openvpn/dco_linux.h</span><br>=
<span>+++ b/src/openvpn/dco_linux.h</span><br><span>@@ -66,6 +66,7 @@</span=
><br><span>     int status;</span><br><span> </span><br><span>     struct c=
ontext *c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int c=
trlid;</span><br><span> </span><br><span>     enum ovpn_mode ifmode;</span>=
<br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail">change 1100</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1100?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23ad79e14844aefde9ece34dade=
f0b75ff267201 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1100 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--tPhZfurvShQ=--

