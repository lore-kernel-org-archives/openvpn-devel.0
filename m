From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 25 Jul 2025 18:06:25 +0000
In-Reply-To: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
References: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <fd2a5587d23a2ff7d10434b2d5e6ed617b0efc82-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kEfPAx8siSo="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kEfPAx8siSo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
00?usp=3Demail )

Change subject: dco_linux: fix async message reception
......................................................................

dco_linux: fix async message reception

Currently whenever we send a PEER_GET request to ovpn, we also
set the CB that is supposed to parse the reply.

However, due to the async nature of netlink messages, we could
get an unrelated notification, sent by ovpn (kernel) upon some event,
after userland has set the CB, but before parsing the awaited reply.

When this happens, the notification is then parsed with the
configured CB instead of the notification parser, thus effectively
rejecting the notification and losing the event.

To fix this inconsistency, make ovpn_handle_msg() the default and
only netlink parser CB. It is configured upon DCO initialization
and is never removed.

ovpn_handle_msg() will check the message type and will call the
corresponding handler. This way, no matter what message we get at
what time, we'll always parse it correctly.

As a bonus we can also simplify the nl_sendmsg() API as we
don't need to pass the cb and its argument anymore.

The ID of the NLCTRL family is now also stored in the DCO
context as we need it to check when we receive a mcast ID
lookup message.

Change-Id: I23ad79e14844aefde9ece34dadef0b75ff267201
Github: closes OpenVPN/openvpn#793
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250725172708.19456-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
339.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
2 files changed, 110 insertions(+), 67 deletions(-)




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
Gerrit-PatchSet: 6
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--kEfPAx8siSo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1100?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco_linux: fix async message reception<br><br=
>Currently whenever we send a PEER_GET request to ovpn, we also<br>set the =
CB that is supposed to parse the reply.<br><br>However, due to the async na=
ture of netlink messages, we could<br>get an unrelated notification, sent b=
y ovpn (kernel) upon some event,<br>after userland has set the CB, but befo=
re parsing the awaited reply.<br><br>When this happens, the notification is=
 then parsed with the<br>configured CB instead of the notification parser, =
thus effectively<br>rejecting the notification and losing the event.<br><br=
>To fix this inconsistency, make ovpn_handle_msg() the default and<br>only =
netlink parser CB. It is configured upon DCO initialization<br>and is never=
 removed.<br><br>ovpn_handle_msg() will check the message type and will cal=
l the<br>corresponding handler. This way, no matter what message we get at<=
br>what time, we&#39;ll always parse it correctly.<br><br>As a bonus we can=
 also simplify the nl_sendmsg() API as we<br>don&#39;t need to pass the cb =
and its argument anymore.<br><br>The ID of the NLCTRL family is now also st=
ored in the DCO<br>context as we need it to check when we receive a mcast I=
D<br>lookup message.<br><br>Change-Id: I23ad79e14844aefde9ece34dadef0b75ff2=
67201<br>Github: closes OpenVPN/openvpn#793<br>Signed-off-by: Antonio Quart=
ulli &lt;antonio@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>Message-Id: &lt;20250725172708.19456-1-gert@...1296...&gt;<br>URL=
: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32339=
.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M sr=
c/openvpn/dco_linux.c<br>M src/openvpn/dco_linux.h<br>2 files changed, 110 =
insertions(+), 67 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br=
><span>index 7c639d9..728fb7e 100644</span><br><span>--- a/src/openvpn/dco_=
linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -1=
67,23 +167,19 @@</span><br><span> }</span><br><span> </span><br><span> /**<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Send a prepared net=
link message and registers cb as callback if non-null.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Send a prepared netlink message.</spa=
n><br><span>  *</span><br><span>  * The method will also free nl_msg</span>=
<br><span>  * @param dco       The dco context to use</span><br><span>  * @=
param nl_msg    the message to use</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @param cb        An optional callback if the caller expects=
 an answer</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param c=
b_arg    An optional param to pass to the callback</span><br><span>  * @par=
am prefix    A prefix to report in the error message to give the user conte=
xt</span><br><span>  * @return          status of sending the message</span=
><br><span>  */</span><br><span> static int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *n=
l_msg, ovpn_nl_cb cb,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                 void *cb_arg, const char *prefix)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ovpn_nl_msg_send(dco_context_t *dco, struct =
nl_msg *nl_msg, const char *prefix)</span><br><span> {</span><br><span>    =
 dco-&gt;status =3D 1;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    nl_cb_set(dco-&gt;nl_cb, NL_CB_VALID, NL_CB_CUSTOM, =
cb, cb_arg);</span><br><span>     nl_send_auto(dco-&gt;nl_sock, nl_msg);</s=
pan><br><span> </span><br><span>     while (dco-&gt;status =3D=3D 1)</span>=
<br><span>@@ -285,7 +281,7 @@</span><br><span>     }</span><br><span>     n=
la_nest_end(nl_msg, attr);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL=
, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
 =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br><=
span> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</span><br><=
span>@@ -385,6 +381,29 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovp=
n_dco_register(dco_context_t *dco)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 msg(D_DCO_DEBUG, __func__);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ovpn_get_mcast_id(dco);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (dco-&gt;ovpn_dco_mcast_id &lt; 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_FATAL, &quot;cannot get mcast group: %s&quot;,  nl_gete=
rror(dco-&gt;ovpn_dco_mcast_id));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Register for=
 ovpn-dco specific multicast messages that the kernel may</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * send</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int ret =3D nl_socket_add_membership(dco-&gt;nl_sock,=
 dco-&gt;ovpn_dco_mcast_id);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_FATAL, &quot;%s: failed to join groups: %d&quot;, __func__, ret);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic int ovpn_handle_msg(struct nl_msg *msg, void *arg);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span> ovpn_dco_init_netlink(dco_con=
text_t *dco)</span><br><span> {</span><br><span>     dco-&gt;ovpn_dco_id =
=3D resolve_ovpn_netlink_id(M_FATAL);</span><br><span>@@ -420,11 +439,15 @@=
</span><br><span> </span><br><span>     nl_socket_set_cb(dco-&gt;nl_sock, d=
co-&gt;nl_cb);</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    dco-&gt;dco_message_peer_id =3D -1;</span><br><span>     n=
l_cb_err(dco-&gt;nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &amp;dco-&gt;status=
);</span><br><span>     nl_cb_set(dco-&gt;nl_cb, NL_CB_FINISH, NL_CB_CUSTOM=
, ovpn_nl_cb_finish,</span><br><span>               &amp;dco-&gt;status);</=
span><br><span>     nl_cb_set(dco-&gt;nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_=
nl_cb_finish,</span><br><span>               &amp;dco-&gt;status);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    nl_cb_set(dco-&gt;nl_cb,=
 NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ovpn_dco_register(dco);</span><br><span> </span><br><span> =
    /* The async PACKET messages confuse libnl and it will drop them with</=
span><br><span>      * wrong sequence numbers (NLE_SEQ_MISMATCH), so disabl=
e libnl&#39;s sequence</span><br><span>@@ -476,27 +499,6 @@</span><br><span=
>     CLEAR(dco);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-ovpn_dco_register(dco_context_t *dco)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    msg(D_DCO_DEBUG, __func__);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ovpn_get_mcast_id(dco);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (dco-&gt;ovpn_dco_mcast_id &lt; 0)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(M_FATAL, &quot;cannot get mcast group: %s&quo=
t;,  nl_geterror(dco-&gt;ovpn_dco_mcast_id));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Regist=
er for ovpn-dco specific multicast messages that the kernel may</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     * send</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int ret =3D nl_socket_add_membership(dco-&gt;nl_sock,=
 dco-&gt;ovpn_dco_mcast_id);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (ret)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATA=
L, &quot;%s: failed to join groups: %d&quot;, __func__, ret);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> int</span><br><span> open_tun_dco(struct tuntap *tt, =
openvpn_net_ctx_t *ctx, const char *dev)</span><br><span> {</span><br><span=
>@@ -516,10 +518,6 @@</span><br><span>         msg(M_FATAL, &quot;DCO: cann=
ot retrieve ifindex for interface %s&quot;, dev);</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tt=
-&gt;dco.dco_message_peer_id =3D -1;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ov=
pn_dco_register(&amp;tt-&gt;dco);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     return 0;</span><br><span> }</span><br><s=
pan> </span><br><span>@@ -548,7 +546,7 @@</span><br><span>     NLA_PUT_U32(=
nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);</span><br><span>     nla_nest_end(=
nl_msg, attr);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl=
_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_pu=
t_failure:</span><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -572=
,7 +570,7 @@</span><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peeri=
d);</span><br><span>     nla_nest_end(nl_msg, attr);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_se=
nd(dco, nl_msg, NULL, NULL, __func__);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</sp=
an><br><span> </span><br><span> nla_put_failure:</span><br><span>     nlmsg=
_free(nl_msg);</span><br><span>@@ -598,7 +596,7 @@</span><br><span>     NLA=
_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);</span><br><span>     nla_nest_=
end(nl_msg, keyconf);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __f=
unc__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D =
ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br><span>=
 nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</span><br><span>=
@@ -657,7 +655,7 @@</span><br><span>     nla_nest_end(nl_msg, key_conf);</s=
pan><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_n=
l_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br><span> nla_p=
ut_failure:</span><br><span>     nlmsg_free(nl_msg);</span><br><span>@@ -68=
6,7 +684,7 @@</span><br><span>                 keepalive_timeout);</span><b=
r><span>     nla_nest_end(nl_msg, attr);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_m=
sg, NULL, NULL, __func__);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span=
> </span><br><span> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg=
);</span><br><span>@@ -754,7 +752,7 @@</span><br><span> </span><br><span>  =
   /* Even though &#39;nlctrl&#39; is a constant, there seem to be no libra=
ry</span><br><span>      * provided define for it */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ctrlid =3D genl_ctrl_resolve(dco-&g=
t;nl_sock, &quot;nlctrl&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    dco-&gt;ctrlid =3D genl_ctrl_resolve(dco-&gt;nl_sock, &quot=
;nlctrl&quot;);</span><br><span> </span><br><span>     struct nl_msg *nl_ms=
g =3D nlmsg_alloc();</span><br><span>     if (!nl_msg)</span><br><span>@@ -=
762,12 +760,12 @@</span><br><span>         return -ENOMEM;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    genlmsg_put(nl_msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    genlmsg_put(nl_msg, =
0, 0, dco-&gt;ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);</span><br><span> </span=
><br><span>     int ret =3D -EMSGSIZE;</span><br><span>     NLA_PUT_STRING(=
nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_FAMILY_NAME);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(=
dco, nl_msg, mcast_family_handler, dco, __func__);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __=
func__);</span><br><span> </span><br><span> nla_put_failure:</span><br><spa=
n>     nlmsg_free(nl_msg);</span><br><span>@@ -879,31 +877,34 @@</span><br>=
<span> }</span><br><span> </span><br><span> static int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-dco_parse_peer_multi(struct nl_msg *msg, v=
oid *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_handl=
e_peer_multi(dco_context_t *dco, struct nlattr *attrs[])</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb=
[OVPN_A_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     msg(D_DCO_DEBUG, &q=
uot;%s: parsing message...&quot;, __func__);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb, OVPN_A_MAX, genl=
msg_attrdata(gnlh, 0),</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-              genlmsg_attrlen(gnlh, 0), NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* this function assumes openvpn is running=
 in multipeer mode as</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * it accesses c-&gt;multi</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (dco-&gt;ifmode !=3D OVPN_MODE_MP)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_WARN, &quot;%s: can&#39;t parse &#39;multi-peer&#39;=
 message on P2P instance&quot;, __func__);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return NL_SKIP;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!tb[OVPN_A_PEER])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_A_PEER])</span><br><=
span>     {</span><br><span>         return NL_SKIP;</span><br><span>     }=
</span><br><span> </span><br><span>     struct nlattr *tb_peer[OVPN_A_PEER_=
MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_pars=
e_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    nla_parse_nested(tb_peer, OVPN_A=
_PEER_MAX, attrs[OVPN_A_PEER], NULL);</span><br><span> </span><br><span>   =
  if (!tb_peer[OVPN_A_PEER_ID])</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no peer-id p=
rovided in reply&quot;, __func__);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(M_WARN, &quot;ovpn-dco: no peer-id provided in (=
MULTI) PEER_GET reply&quot;);</span><br><span>         return NL_SKIP;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct multi_context *m =3D arg;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D dco-&gt;c=
-&gt;multi;</span><br><span>     uint32_t peer_id =3D nla_get_u32(tb_peer[O=
VPN_A_PEER_ID]);</span><br><span> </span><br><span>     if (peer_id &gt;=3D=
 m-&gt;max_clients || !m-&gt;instances[peer_id])</span><br><span>@@ -919,39=
 +920,53 @@</span><br><span> }</span><br><span> </span><br><span> static in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_parse_peer(struc=
t nl_msg *msg, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ovpn_handle_peer(dco_context_t *dco, struct nlattr *attrs[])</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
context *c =3D arg;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct nlattr *tb[OVPN_A_MAX + 1];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __func__);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_parse(t=
b, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-              genlmsg_attrlen(gnlh, 0), NULL);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (!tb[OVPN_A_PEER])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_A_PEER])</span><br><span>=
     {</span><br><span>         msg(D_DCO_DEBUG, &quot;%s: malformed reply&=
quot;, __func__);</span><br><span>         return NL_SKIP;</span><br><span>=
     }</span><br><span> </span><br><span>     struct nlattr *tb_peer[OVPN_A=
_PEER_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nl=
a_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    nla_parse_nested(tb_peer, =
OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NULL);</span><br><span> </span><br><sp=
an>     if (!tb_peer[OVPN_A_PEER_ID])</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no pee=
r-id provided in reply&quot;, __func__);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(M_WARN, &quot;ovpn-dco: no peer-id provide=
d in PEER_GET reply&quot;);</span><br><span>         return NL_SKIP;</span>=
<br><span>     }</span><br><span> </span><br><span>     uint32_t peer_id =
=3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (c-&gt;c2.tls_multi-&gt;dco_peer_id !=3D peer_id=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context=
_2 *c2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode =3D=3D O=
VPN_MODE_P2P)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c2 =3D &amp;=
dco-&gt;c-&gt;c2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct multi_instance *mi =3D dco=
-&gt;c-&gt;multi-&gt;instances[peer_id];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (!mi)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_WARN, &quot;%s: received data for a non-existing =
peer %u&quot;, __func__, peer_id);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return NL_SKIP;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  c2 =3D &amp;mi-&gt;context.c2;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* at this point=
 this check should never fail for MP mode,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * but it&#39;s still fully valid for P2P mode</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (c2-&gt;tls_multi-&gt;dco_=
peer_id !=3D peer_id)</span><br><span>     {</span><br><span>         retur=
n NL_SKIP;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    dco_update_peer_stat(&amp;c-&gt;c2, tb_=
peer, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
dco_update_peer_stat(c2, tb_peer, peer_id);</span><br><span> </span><br><sp=
an>     return NL_OK;</span><br><span> }</span><br><span>@@ -1120,9 +1135,2=
2 @@</span><br><span> {</span><br><span>     dco_context_t *dco =3D arg;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span>     =
struct nlattr *attrs[OVPN_A_MAX + 1];</span><br><span>     struct nlmsghdr =
*nlh =3D nlmsg_hdr(msg);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct genlmsghdr *gnlh =3D genlmsg_hdr(nlh);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;ovpn-dco: received netlink messa=
ge type=3D%u cmd=3D%u flags=3D%#.4x&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        nlh-&gt;nlmsg_type, gnlh-&gt;cmd, nlh-&gt;nl=
msg_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if we get a message =
from the NLCTRL family, it means</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * this is the reply to the mcast ID resolution request</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and we parse it=
 accordingly.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (nlh-&gt;nl=
msg_type =3D=3D dco-&gt;ctrlid)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(D_DCO_DEBUG, &quot;ovpn-dco: received CTRLID message&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return mcast_fam=
ily_handler(msg, dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span> </span><br><span>     if (!genlmsg_valid_hdr(nlh,=
 0))</span><br><span>     {</span><br><span>@@ -1146,6 +1174,21 @@</span><b=
r><span>      */</span><br><span>     switch (gnlh-&gt;cmd)</span><br><span=
>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case=
 OVPN_CMD_PEER_GET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  /* this message is part of a peer list dump, hence triggered</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+             * by a MP/server in=
stance</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (n=
lh-&gt;nlmsg_flags &amp; NLM_F_MULTI)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                return ovpn_handle_peer_multi(dco, attrs);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                return ovpn_handle_peer=
(dco, attrs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     =
    case OVPN_CMD_PEER_DEL_NTF:</span><br><span>         {</span><br><span>=
             return ovpn_handle_peer_del_ntf(dco, attrs);</span><br><span>@=
@ -1174,7 +1217,6 @@</span><br><span> dco_do_read(dco_context_t *dco)</span=
><br><span> {</span><br><span>     msg(D_DCO_DEBUG, __func__);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    nl_cb_set(dco-&gt;nl_cb, NL_CB=
_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);</span><br><span> </span><br><s=
pan>     return ovpn_nl_recvmsgs(dco, __func__);</span><br><span> }</span><=
br><span>@@ -1189,7 +1231,7 @@</span><br><span> </span><br><span>     nlmsg=
_hdr(nl_msg)-&gt;nlmsg_flags |=3D NLM_F_DUMP;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D ovpn_nl_msg_send(=
dco, nl_msg, dco_parse_peer_multi, m, __func__);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, =
__func__);</span><br><span> </span><br><span>     nlmsg_free(nl_msg);</span=
><br><span> </span><br><span>@@ -1227,7 +1269,7 @@</span><br><span>     NLA=
_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);</span><br><span>     nla_nest_en=
d(nl_msg, attr);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer, c, _=
_func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D ovpn_nl_msg_send(dco, nl_msg, __func__);</span><br><span> </span><br><s=
pan> nla_put_failure:</span><br><span>     nlmsg_free(nl_msg);</span><br><s=
pan>diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h</span><b=
r><span>index 5e61cf1..cc14f45 100644</span><br><span>--- a/src/openvpn/dco=
_linux.h</span><br><span>+++ b/src/openvpn/dco_linux.h</span><br><span>@@ -=
66,6 +66,7 @@</span><br><span>     int status;</span><br><span> </span><br>=
<span>     struct context *c;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int ctrlid;</span><br><span> </span><br><span>     enum ovpn_=
mode ifmode;</span><br><span> </span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail">c=
hange 1100</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23ad79e14844aefde9ece34dade=
f0b75ff267201 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1100 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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


--kEfPAx8siSo=--

