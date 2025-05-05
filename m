From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 5 May 2025 09:15:16 +0000
In-Reply-To: <gerrit.1744809221000.I009f4e7ad38636f1c0b78d267561194c2bb4c051@...2715...>
References: <gerrit.1744809221000.I009f4e7ad38636f1c0b78d267561194c2bb4c051@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., antonio@...2726...
Message-ID: <19bbe75ca1eb6dd3c600e7875c6774bc0fa3ae25-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2zg4UMfL8gY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco_linux: Introduce
 new uAPIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2zg4UMfL8gY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/941?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dco_linux: Introduce new uAPIs
......................................................................

dco_linux: Introduce new uAPIs

This patch updates the dco userspace API to
support communication with the new in-kernel
driver.

The main change involves updating the enums
used for Netlink messages to match the
definitions expected by the kernel module.

Change-Id: I009f4e7ad38636f1c0b78d267561194c2bb4c051
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250505085722.28761-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
554.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
M src/openvpn/networking_sitnl.c
M src/openvpn/ovpn_dco_linux.h
4 files changed, 249 insertions(+), 350 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/941/7

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b0a85fd..c950e3d 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -96,7 +96,7 @@
     }
     set_cloexec(nl_socket_get_fd(nl_sock));

-    ret =3D genl_ctrl_resolve(nl_sock, OVPN_NL_NAME);
+    ret =3D genl_ctrl_resolve(nl_sock, OVPN_FAMILY_NAME);
     if (ret < 0)
     {
         msg(msglevel, "Cannot find ovpn_dco netlink component: %s",
@@ -109,7 +109,7 @@
 }

 static struct nl_msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco, enum ovpn_nl_commands cmd)
+ovpn_dco_nlmsg_create(dco_context_t *dco, int cmd)
 {
     struct nl_msg *nl_msg =3D nlmsg_alloc();
     if (!nl_msg)
@@ -119,7 +119,7 @@
     }

     genlmsg_put(nl_msg, 0, 0, dco->ovpn_dco_id, 0, 0, cmd, 0);
-    NLA_PUT_U32(nl_msg, OVPN_ATTR_IFINDEX, dco->ifindex);
+    NLA_PUT_U32(nl_msg, OVPN_A_IFINDEX, dco->ifindex);

     return nl_msg;
 nla_put_failure:
@@ -231,20 +231,31 @@
     msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d, remote addr: %s", __func__,
         peerid, sd, remotestr);

-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_NEW_PEER=
);
-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_NEW_PEER);
+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NEW=
);
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE;

-    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_PEER_ID, peerid);
-    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_SOCKET, sd);
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_SOCKET, sd);

     /* Set the remote endpoint if defined (for UDP) */
     if (remoteaddr)
     {
         remoteaddr =3D mapped_v4_to_v6(remoteaddr, &gc);
-        int alen =3D af_addr_size(remoteaddr->sa_family);

-        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE, alen, remotead=
dr);
+        if (remoteaddr->sa_family =3D=3D AF_INET)
+        {
+            NLA_PUT(nl_msg, OVPN_A_PEER_REMOTE_IPV4, sizeof(struct in_addr=
),
+                    &((struct sockaddr_in *)remoteaddr)->sin_addr);
+            NLA_PUT_U16(nl_msg, OVPN_A_PEER_REMOTE_PORT, ((struct sockaddr=
_in *)remoteaddr)->sin_port);
+        }
+        else if (remoteaddr->sa_family =3D=3D AF_INET6)
+        {
+            NLA_PUT(nl_msg, OVPN_A_PEER_REMOTE_IPV6, sizeof(struct in6_add=
r),
+                    &((struct sockaddr_in6 *)remoteaddr)->sin6_addr);
+            NLA_PUT_U16(nl_msg, OVPN_A_PEER_REMOTE_PORT, ((struct sockaddr=
_in6 *)remoteaddr)->sin6_port);
+            NLA_PUT_U32(nl_msg, OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID, ((struct=
 sockaddr_in6 *)remoteaddr)->sin6_scope_id);
+        }
     }

     if (localaddr)
@@ -252,24 +263,26 @@
         localaddr =3D mapped_v4_to_v6(localaddr, &gc);
         if (localaddr->sa_family =3D=3D AF_INET)
         {
-            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in_=
addr),
+            NLA_PUT(nl_msg, OVPN_A_PEER_LOCAL_IPV4, sizeof(struct in_addr),
                     &((struct sockaddr_in *)localaddr)->sin_addr);
+            NLA_PUT_U16(nl_msg, OVPN_A_PEER_LOCAL_PORT, ((struct sockaddr_=
in *)localaddr)->sin_port);
         }
         else if (localaddr->sa_family =3D=3D AF_INET6)
         {
-            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in6=
_addr),
+            NLA_PUT(nl_msg, OVPN_A_PEER_LOCAL_IPV6, sizeof(struct in6_addr=
),
                     &((struct sockaddr_in6 *)localaddr)->sin6_addr);
+            NLA_PUT_U16(nl_msg, OVPN_A_PEER_LOCAL_PORT, ((struct sockaddr_=
in6 *)localaddr)->sin6_port);
         }
     }

     /* Set the primary VPN IP addresses of the peer */
     if (vpn_ipv4)
     {
-        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, vpn_ipv4->s_addr);
+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_VPN_IPV4, vpn_ipv4->s_addr);
     }
     if (vpn_ipv6)
     {
-        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr),
+        NLA_PUT(nl_msg, OVPN_A_PEER_VPN_IPV6, sizeof(struct in6_addr),
                 vpn_ipv6);
     }
     nla_nest_end(nl_msg, attr);
@@ -481,7 +494,7 @@
     msg(D_DCO_DEBUG, "%s: %s", __func__, dev);
     ASSERT(tt->type =3D=3D DEV_TYPE_TUN);

-    int ret =3D net_iface_new(ctx, dev, "ovpn-dco", &tt->dco);
+    int ret =3D net_iface_new(ctx, dev, OVPN_FAMILY_NAME, &tt->dco);
     if (ret < 0)
     {
         msg(D_DCO_DEBUG, "Cannot create DCO interface %s: %d", dev, ret);
@@ -515,15 +528,15 @@
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);

-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_SWAP_KEY=
S);
+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_SWAP=
);
     if (!nl_msg)
     {
         return -ENOMEM;
     }

-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_SWAP_KEYS);
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);
     int ret =3D -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);

     ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
@@ -539,15 +552,15 @@
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);

-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_DEL_PEER=
);
+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_DEL=
);
     if (!nl_msg)
     {
         return -ENOMEM;
     }

-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_DEL_PEER);
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_DEL_PEER_ATTR_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
     nla_nest_end(nl_msg, attr);

     ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
@@ -562,19 +575,19 @@
 dco_del_key(dco_context_t *dco, unsigned int peerid,
             dco_key_slot_t slot)
 {
+    int ret =3D -EMSGSIZE;
     msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, peerid, slot);

-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_DEL_KEY);
+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_DEL);
     if (!nl_msg)
     {
         return -ENOMEM;
     }

-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_DEL_KEY);
-    int ret =3D -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_DEL_KEY_ATTR_PEER_ID, peerid);
-    NLA_PUT_U8(nl_msg, OVPN_DEL_KEY_ATTR_KEY_SLOT, slot);
-    nla_nest_end(nl_msg, attr);
+    struct nlattr *keyconf =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);
+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);
+    nla_nest_end(nl_msg, keyconf);

     ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);

@@ -596,7 +609,7 @@
     const size_t key_len =3D cipher_kt_key_size(ciphername);
     const int nonce_tail_len =3D 8;

-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_NEW_KEY);
+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_NEW);
     if (!nl_msg)
     {
         return -ENOMEM;
@@ -605,33 +618,35 @@
     dco_cipher_t dco_cipher =3D dco_get_cipher(ciphername);

     int ret =3D -EMSGSIZE;
-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_NEW_KEY);
-    NLA_PUT_U32(nl_msg, OVPN_NEW_KEY_ATTR_PEER_ID, peerid);
-    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_SLOT, slot);
-    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_ID, keyid);
-    NLA_PUT_U16(nl_msg, OVPN_NEW_KEY_ATTR_CIPHER_ALG, dco_cipher);
+
+    struct nlattr *key_conf =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);
+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);
+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_KEY_ID, keyid);
+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_CIPHER_ALG, dco_cipher);

     struct nlattr *key_enc =3D nla_nest_start(nl_msg,
-                                            OVPN_NEW_KEY_ATTR_ENCRYPT_KEY);
+                                            OVPN_A_KEYCONF_ENCRYPT_DIR);
     if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)
     {
-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, encrypt_key=
);
-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,
+        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, key_len, encrypt_key);
+        NLA_PUT(nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, nonce_tail_len,
                 encrypt_iv);
     }
     nla_nest_end(nl_msg, key_enc);

     struct nlattr *key_dec =3D nla_nest_start(nl_msg,
-                                            OVPN_NEW_KEY_ATTR_DECRYPT_KEY);
+                                            OVPN_A_KEYCONF_DECRYPT_DIR);
     if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)
     {
-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, decrypt_key=
);
-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,
+        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, key_len, decrypt_key);
+        NLA_PUT(nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, nonce_tail_len,
                 decrypt_iv);
     }
     nla_nest_end(nl_msg, key_dec);

-    nla_nest_end(nl_msg, attr);
+    nla_nest_end(nl_msg, key_conf);
+

     ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);

@@ -647,18 +662,18 @@
     msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__,
         peerid, keepalive_interval, keepalive_timeout, mss);

-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_SET_PEER=
);
+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_SET=
);
     if (!nl_msg)
     {
         return -ENOMEM;
     }

-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_SET_PEER);
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_PEER_ID, peerid);
-    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_KEEPALIVE_INTERVAL,
                 keepalive_interval);
-    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_KEEPALIVE_TIMEOUT,
                 keepalive_timeout);
     nla_nest_end(nl_msg, attr);

@@ -707,7 +722,7 @@
         }

         if (strncmp(nla_data(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME]),
-                    OVPN_NL_MULTICAST_GROUP_PEERS,
+                    OVPN_MCGRP_PEERS,
                     nla_len(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME])) !=3D 0)
         {
             continue;
@@ -720,7 +735,7 @@
 }
 /**
  * Lookup the multicast id for OpenVPN. This method and its help method cu=
rrently
- * hardcode the lookup to OVPN_NL_NAME and OVPN_NL_MULTICAST_GROUP_PEERS b=
ut
+ * hardcode the lookup to OVPN_FAMILY_NAME and OVPN_MCGRP_PEERS but
  * extended in the future if we need to lookup more than one mcast id.
  */
 static int
@@ -741,7 +756,7 @@
     genlmsg_put(nl_msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);

     int ret =3D -EMSGSIZE;
-    NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_NL_NAME);
+    NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_FAMILY_NAME);

     ret =3D ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, dco, __fun=
c__);

@@ -757,38 +772,38 @@
     dco_context_t *dco =3D arg;

     struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
-    struct nlattr *attrs[OVPN_ATTR_MAX + 1];
+    struct nlattr *attrs[OVPN_A_MAX + 1];
     struct nlmsghdr *nlh =3D nlmsg_hdr(msg);

     if (!genlmsg_valid_hdr(nlh, 0))
     {
         msg(D_DCO, "ovpn-dco: invalid header");
-        return NL_SKIP;
+        return NL_STOP;
     }

-    if (nla_parse(attrs, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+    if (nla_parse(attrs, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
                   genlmsg_attrlen(gnlh, 0), NULL))
     {
         msg(D_DCO, "received bogus data from ovpn-dco");
-        return NL_SKIP;
+        return NL_STOP;
     }

     /* we must know which interface this message is referring to in order =
to
      * avoid mixing messages for other instances
      */
-    if (!attrs[OVPN_ATTR_IFINDEX])
+    if (!attrs[OVPN_A_IFINDEX])
     {
         msg(D_DCO, "ovpn-dco: Received message without ifindex");
-        return NL_SKIP;
+        return NL_STOP;
     }

-    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
+    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]);
     if (ifindex !=3D dco->ifindex)
     {
         msg(D_DCO_DEBUG,
             "ovpn-dco: ignoring message (type=3D%d) for foreign ifindex %d=
",
             gnlh->cmd, ifindex);
-        return NL_SKIP;
+        return NL_STOP;
     }

     /* based on the message type, we parse the subobject contained in the
@@ -800,48 +815,85 @@
      */
     switch (gnlh->cmd)
     {
-        case OVPN_CMD_DEL_PEER:
+        case OVPN_CMD_PEER_DEL_NTF:
         {
-            if (!attrs[OVPN_ATTR_DEL_PEER])
+            if (!attrs[OVPN_A_PEER])
             {
-                msg(D_DCO, "ovpn-dco: no attributes in OVPN_DEL_PEER messa=
ge");
-                return NL_SKIP;
+                msg(D_DCO, "ovpn-dco: no peer in PEER_DEL_NTF message");
+                return NL_STOP;
             }

-            struct nlattr *dp_attrs[OVPN_DEL_PEER_ATTR_MAX + 1];
-            if (nla_parse_nested(dp_attrs, OVPN_DEL_PEER_ATTR_MAX,
-                                 attrs[OVPN_ATTR_DEL_PEER], NULL))
+            struct nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];
+            if (nla_parse_nested(dp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_P=
EER],
+                                 NULL))
             {
-                msg(D_DCO, "received bogus del peer packet data from ovpn-=
dco");
-                return NL_SKIP;
+                msg(D_DCO, "ovpn-dco: can't parse peer in PEER_DEL_NTF mes=
ssage");
+                return NL_STOP;
             }

-            if (!dp_attrs[OVPN_DEL_PEER_ATTR_REASON])
+            if (!dp_attrs[OVPN_A_PEER_DEL_REASON])
             {
-                msg(D_DCO, "ovpn-dco: no reason in DEL_PEER message");
-                return NL_SKIP;
+                msg(D_DCO, "ovpn-dco: no reason in PEER_DEL_NTF message");
+                return NL_STOP;
             }
-            if (!dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])
+            if (!dp_attrs[OVPN_A_PEER_ID])
             {
-                msg(D_DCO, "ovpn-dco: no peer-id in DEL_PEER message");
-                return NL_SKIP;
+                msg(D_DCO, "ovpn-dco: no peer-id in PEER_DEL_NTF message");
+                return NL_STOP;
             }
-            int reason =3D nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_REASON]);
-            unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATT=
R_PEER_ID]);

-            msg(D_DCO_DEBUG, "ovpn-dco: received CMD_DEL_PEER, ifindex: %d=
, peer-id %d, reason: %d",
+            int reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);
+            unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
+
+            msg(D_DCO_DEBUG, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex=
: %d, peer-id %u, reason: %d",
                 ifindex, peerid, reason);
             dco->dco_message_peer_id =3D peerid;
             dco->dco_del_peer_reason =3D reason;
-            dco->dco_message_type =3D OVPN_CMD_DEL_PEER;
+            dco->dco_message_type =3D OVPN_CMD_PEER_DEL_NTF;
+            break;
+        }

+        case OVPN_CMD_KEY_SWAP_NTF:
+        {
+            if (!attrs[OVPN_A_KEYCONF])
+            {
+                msg(D_DCO, "ovpn-dco: no keyconf in KEY_SWAP_NTF message");
+                return NL_STOP;
+            }
+
+            struct nlattr *dp_attrs[OVPN_A_KEYCONF_MAX + 1];
+            if (nla_parse_nested(dp_attrs, OVPN_A_KEYCONF_MAX,
+                                 attrs[OVPN_A_KEYCONF], NULL))
+            {
+                msg(D_DCO, "ovpn-dco: can't parse keyconf in KEY_SWAP_NTF =
message");
+                return NL_STOP;
+            }
+            if (!dp_attrs[OVPN_A_KEYCONF_PEER_ID])
+            {
+                msg(D_DCO, "ovpn-dco: no peer-id in KEY_SWAP_NTF message");
+                return NL_STOP;
+            }
+            if (!dp_attrs[OVPN_A_KEYCONF_KEY_ID])
+            {
+                msg(D_DCO, "ovpn-dco: no key-id in KEY_SWAP_NTF message");
+                return NL_STOP;
+            }
+
+            int key_id =3D nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);
+            unsigned int peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_P=
EER_ID]);
+
+            msg(D_DCO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex=
: %d, peer-id %u, key-id: %d",
+                ifindex, peer_id, key_id);
+            dco->dco_message_peer_id =3D peer_id;
+            dco->dco_message_key_id =3D key_id;
+            dco->dco_message_type =3D OVPN_CMD_KEY_SWAP_NTF;
             break;
         }

         default:
             msg(D_DCO, "ovpn-dco: received unknown command: %d", gnlh->cmd=
);
             dco->dco_message_type =3D 0;
-            return NL_SKIP;
+            return NL_STOP;
     }

     return NL_OK;
@@ -859,9 +911,9 @@
 static void
 dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t i=
d)
 {
-    if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES])
+    if (tb[OVPN_A_PEER_LINK_RX_BYTES])
     {
-        c2->dco_read_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_LINK=
_RX_BYTES]);
+        c2->dco_read_bytes =3D nla_get_u64(tb[OVPN_A_PEER_LINK_RX_BYTES]);
         msg(D_DCO_DEBUG, "%s / dco_read_bytes: " counter_format, __func__,
             c2->dco_read_bytes);
     }
@@ -871,9 +923,9 @@
             __func__, id);
     }

-    if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES])
+    if (tb[OVPN_A_PEER_LINK_TX_BYTES])
     {
-        c2->dco_write_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_LIN=
K_TX_BYTES]);
+        c2->dco_write_bytes =3D nla_get_u64(tb[OVPN_A_PEER_LINK_TX_BYTES]);
         msg(D_DCO_DEBUG, "%s / dco_write_bytes: " counter_format, __func__,
             c2->dco_write_bytes);
     }
@@ -883,9 +935,9 @@
             __func__, id);
     }

-    if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES])
+    if (tb[OVPN_A_PEER_VPN_RX_BYTES])
     {
-        c2->tun_read_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN_=
RX_BYTES]);
+        c2->tun_read_bytes =3D nla_get_u64(tb[OVPN_A_PEER_VPN_RX_BYTES]);
         msg(D_DCO_DEBUG, "%s / tun_read_bytes: " counter_format, __func__,
             c2->tun_read_bytes);
     }
@@ -895,9 +947,9 @@
             __func__, id);
     }

-    if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES])
+    if (tb[OVPN_A_PEER_VPN_TX_BYTES])
     {
-        c2->tun_write_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN=
_TX_BYTES]);
+        c2->tun_write_bytes =3D nla_get_u64(tb[OVPN_A_PEER_VPN_TX_BYTES]);
         msg(D_DCO_DEBUG, "%s / tun_write_bytes: " counter_format, __func__,
             c2->tun_write_bytes);
     }
@@ -911,33 +963,30 @@
 int
 dco_parse_peer_multi(struct nl_msg *msg, void *arg)
 {
-    struct nlattr *tb[OVPN_ATTR_MAX + 1];
+    struct nlattr *tb[OVPN_A_MAX + 1];
     struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));

     msg(D_DCO_DEBUG, "%s: parsing message...", __func__);

-    nla_parse(tb, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),
               genlmsg_attrlen(gnlh, 0), NULL);

-    if (!tb[OVPN_ATTR_GET_PEER])
+    if (!tb[OVPN_A_PEER])
     {
         return NL_SKIP;
     }

-    struct nlattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];
+    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];
+    nla_parse_nested(tb_peer, OVPN_A_PEER_MAX, tb[OVPN_A_PEER], NULL);

-    nla_parse(tb_peer, OVPN_GET_PEER_RESP_ATTR_MAX,
-              nla_data(tb[OVPN_ATTR_GET_PEER]),
-              nla_len(tb[OVPN_ATTR_GET_PEER]), NULL);
-
-    if (!tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])
+    if (!tb_peer[OVPN_A_PEER_ID])
     {
         msg(M_WARN, "%s: no peer-id provided in reply", __func__);
         return NL_SKIP;
     }

     struct multi_context *m =3D arg;
-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_=
ID]);
+    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);

     if (peer_id >=3D m->max_clients || !m->instances[peer_id])
     {
@@ -957,7 +1006,7 @@
 {
     msg(D_DCO_DEBUG, "%s", __func__);

-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER=
);
+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET=
);

     nlmsg_hdr(nl_msg)->nlmsg_flags |=3D NLM_F_DUMP;

@@ -979,33 +1028,33 @@
 dco_parse_peer(struct nl_msg *msg, void *arg)
 {
     struct context *c =3D arg;
-    struct nlattr *tb[OVPN_ATTR_MAX + 1];
+    struct nlattr *tb[OVPN_A_MAX];
     struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));

     msg(D_DCO_DEBUG, "%s: parsing message...", __func__);

-    nla_parse(tb, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+    nla_parse(tb, OVPN_A_PEER_MAX, genlmsg_attrdata(gnlh, 0),
               genlmsg_attrlen(gnlh, 0), NULL);

-    if (!tb[OVPN_ATTR_GET_PEER])
+    if (!tb[OVPN_A_PEER])
     {
         msg(D_DCO_DEBUG, "%s: malformed reply", __func__);
         return NL_SKIP;
     }

-    struct nlattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];
+    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];

-    nla_parse(tb_peer, OVPN_GET_PEER_RESP_ATTR_MAX,
-              nla_data(tb[OVPN_ATTR_GET_PEER]),
-              nla_len(tb[OVPN_ATTR_GET_PEER]), NULL);
+    nla_parse(tb_peer, OVPN_A_PEER,
+              nla_data(tb[OVPN_A_PEER]),
+              nla_len(tb[OVPN_A_PEER]), NULL);

-    if (!tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])
+    if (!tb_peer[OVPN_A_PEER_ID])
     {
         msg(M_WARN, "%s: no peer-id provided in reply", __func__);
         return NL_SKIP;
     }

-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_=
ID]);
+    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
     if (c->c2.tls_multi->dco_peer_id !=3D peer_id)
     {
         return NL_SKIP;
@@ -1033,11 +1082,11 @@
     }

     dco_context_t *dco =3D &c->c1.tuntap->dco;
-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER=
);
-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_GET_PEER);
+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET=
);
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE;

-    NLA_PUT_U32(nl_msg, OVPN_GET_PEER_ATTR_PEER_ID, peer_id);
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peer_id);
     nla_nest_end(nl_msg, attr);

     ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer, c, __func__);
@@ -1071,29 +1120,7 @@
 const char *
 dco_version_string(struct gc_arena *gc)
 {
-    struct buffer out =3D alloc_buf_gc(256, gc);
-    FILE *fp =3D fopen("/sys/module/ovpn_dco_v2/version", "r");
-    if (!fp)
-    {
-        return "N/A";
-    }
-
-    if (!fgets(BSTR(&out), BCAP(&out), fp))
-    {
-        fclose(fp);
-        return "ERR";
-    }
-
-    /* remove potential newline at the end of the string */
-    char *str =3D BSTR(&out);
-    char *nl =3D strchr(str, '\n');
-    if (nl)
-    {
-        *nl =3D '\0';
-    }
-
-    fclose(fp);
-    return BSTR(&out);
+    return "Unknown";
 }

 void
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 511519a..f3abc15 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -31,9 +31,27 @@
 #include <netlink/socket.h>
 #include <netlink/netlink.h>

+/* Defines to avoid mismatching with other platforms */
+#define OVPN_CMD_DEL_PEER OVPN_CMD_PEER_DEL_NTF
+#define OVPN_CMD_SWAP_KEYS OVPN_CMD_KEY_SWAP_NTF
+
 typedef enum ovpn_key_slot dco_key_slot_t;
 typedef enum ovpn_cipher_alg dco_cipher_t;

+/* OVPN section */
+
+enum ovpn_mode {
+    OVPN_MODE_P2P,
+    OVPN_MODE_MP,
+};
+
+enum ovpn_ifla_attrs {
+    IFLA_OVPN_UNSPEC =3D 0,
+    IFLA_OVPN_MODE,
+
+    __IFLA_OVPN_AFTER_LAST,
+    IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,
+};

 typedef struct
 {
@@ -50,6 +68,7 @@

     int dco_message_type;
     int dco_message_peer_id;
+    int dco_message_key_id;
     int dco_del_peer_reason;
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 9de8912..a75de9b 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1354,7 +1354,7 @@
     struct rtattr *linkinfo =3D SITNL_NEST(&req.n, sizeof(req), IFLA_LINKI=
NFO);
     SITNL_ADDATTR(&req.n, sizeof(req), IFLA_INFO_KIND, type, strlen(type) =
+ 1);
 #if defined(ENABLE_DCO)
-    if (arg && (strcmp(type, "ovpn-dco") =3D=3D 0))
+    if (arg && (strcmp(type, OVPN_FAMILY_NAME) =3D=3D 0))
     {
         dco_context_t *dco =3D arg;
         struct rtattr *data =3D SITNL_NEST(&req.n, sizeof(req), IFLA_INFO_=
DATA);
diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h
index 73e19b5..680d152 100644
--- a/src/openvpn/ovpn_dco_linux.h
+++ b/src/openvpn/ovpn_dco_linux.h
@@ -1,256 +1,109 @@
-/* SPDX-License-Identifier: (GPL-2.0-only WITH Linux-syscall-note) OR MIT =
*/
-/*
- *  OpenVPN data channel accelerator
- *
- *  Copyright (C) 2019-2023 OpenVPN, Inc.
- *
- *  Author:	James Yonan <james@...515...>
- *		Antonio Quartulli <antonio@...515...>
- */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cl=
ause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ovpn.yaml */
+/* YNL-GEN uapi header */

-#ifndef _UAPI_LINUX_OVPN_DCO_H_
-#define _UAPI_LINUX_OVPN_DCO_H_
+#ifndef _UAPI_LINUX_OVPN_H
+#define _UAPI_LINUX_OVPN_H

-#define OVPN_NL_NAME "ovpn-dco-v2"
+#define OVPN_FAMILY_NAME	"ovpn"
+#define OVPN_FAMILY_VERSION	1

-#define OVPN_NL_MULTICAST_GROUP_PEERS "peers"
-
-/**
- * enum ovpn_nl_commands - supported netlink commands
- */
-enum ovpn_nl_commands {
-	/**
-	 * @OVPN_CMD_UNSPEC: unspecified command to catch errors
-	 */
-	OVPN_CMD_UNSPEC =3D 0,
-
-	/**
-	 * @OVPN_CMD_NEW_PEER: Configure peer with its crypto keys
-	 */
-	OVPN_CMD_NEW_PEER,
-
-	/**
-	 * @OVPN_CMD_SET_PEER: Tweak parameters for an existing peer
-	 */
-	OVPN_CMD_SET_PEER,
-
-	/**
-	 * @OVPN_CMD_DEL_PEER: Remove peer from internal table
-	 */
-	OVPN_CMD_DEL_PEER,
-
-	OVPN_CMD_NEW_KEY,
-
-	OVPN_CMD_SWAP_KEYS,
-
-	OVPN_CMD_DEL_KEY,
-
-	/**
-	 * @OVPN_CMD_GET_PEER: Retrieve the status of a peer or all peers
-	 */
-	OVPN_CMD_GET_PEER,
-};
+#define OVPN_NONCE_TAIL_SIZE	8

 enum ovpn_cipher_alg {
-	/**
-	 * @OVPN_CIPHER_ALG_NONE: No encryption - reserved for debugging only
-	 */
-	OVPN_CIPHER_ALG_NONE =3D 0,
-	/**
-	 * @OVPN_CIPHER_ALG_AES_GCM: AES-GCM AEAD cipher with any allowed key size
-	 */
+	OVPN_CIPHER_ALG_NONE,
 	OVPN_CIPHER_ALG_AES_GCM,
-	/**
-	 * @OVPN_CIPHER_ALG_CHACHA20_POLY1305: ChaCha20Poly1305 AEAD cipher
-	 */
 	OVPN_CIPHER_ALG_CHACHA20_POLY1305,
 };

 enum ovpn_del_peer_reason {
-	__OVPN_DEL_PEER_REASON_FIRST,
-	OVPN_DEL_PEER_REASON_TEARDOWN =3D __OVPN_DEL_PEER_REASON_FIRST,
+	OVPN_DEL_PEER_REASON_TEARDOWN,
 	OVPN_DEL_PEER_REASON_USERSPACE,
 	OVPN_DEL_PEER_REASON_EXPIRED,
 	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
 	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
-	__OVPN_DEL_PEER_REASON_AFTER_LAST
 };

 enum ovpn_key_slot {
-	__OVPN_KEY_SLOT_FIRST,
-	OVPN_KEY_SLOT_PRIMARY =3D __OVPN_KEY_SLOT_FIRST,
+	OVPN_KEY_SLOT_PRIMARY,
 	OVPN_KEY_SLOT_SECONDARY,
-	__OVPN_KEY_SLOT_AFTER_LAST,
 };

-enum ovpn_netlink_attrs {
-	OVPN_ATTR_UNSPEC =3D 0,
-	OVPN_ATTR_IFINDEX,
-	OVPN_ATTR_NEW_PEER,
-	OVPN_ATTR_SET_PEER,
-	OVPN_ATTR_DEL_PEER,
-	OVPN_ATTR_NEW_KEY,
-	OVPN_ATTR_SWAP_KEYS,
-	OVPN_ATTR_DEL_KEY,
-	OVPN_ATTR_GET_PEER,
+enum {
+	OVPN_A_PEER_ID =3D 1,
+	OVPN_A_PEER_REMOTE_IPV4,
+	OVPN_A_PEER_REMOTE_IPV6,
+	OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
+	OVPN_A_PEER_REMOTE_PORT,
+	OVPN_A_PEER_SOCKET,
+	OVPN_A_PEER_SOCKET_NETNSID,
+	OVPN_A_PEER_VPN_IPV4,
+	OVPN_A_PEER_VPN_IPV6,
+	OVPN_A_PEER_LOCAL_IPV4,
+	OVPN_A_PEER_LOCAL_IPV6,
+	OVPN_A_PEER_LOCAL_PORT,
+	OVPN_A_PEER_KEEPALIVE_INTERVAL,
+	OVPN_A_PEER_KEEPALIVE_TIMEOUT,
+	OVPN_A_PEER_DEL_REASON,
+	OVPN_A_PEER_VPN_RX_BYTES,
+	OVPN_A_PEER_VPN_TX_BYTES,
+	OVPN_A_PEER_VPN_RX_PACKETS,
+	OVPN_A_PEER_VPN_TX_PACKETS,
+	OVPN_A_PEER_LINK_RX_BYTES,
+	OVPN_A_PEER_LINK_TX_BYTES,
+	OVPN_A_PEER_LINK_RX_PACKETS,
+	OVPN_A_PEER_LINK_TX_PACKETS,

-	__OVPN_ATTR_AFTER_LAST,
-	OVPN_ATTR_MAX =3D __OVPN_ATTR_AFTER_LAST - 1,
+	__OVPN_A_PEER_MAX,
+	OVPN_A_PEER_MAX =3D (__OVPN_A_PEER_MAX - 1)
 };

-enum ovpn_netlink_key_dir_attrs {
-	OVPN_KEY_DIR_ATTR_UNSPEC =3D 0,
-	OVPN_KEY_DIR_ATTR_CIPHER_KEY,
-	OVPN_KEY_DIR_ATTR_NONCE_TAIL,
+enum {
+	OVPN_A_KEYCONF_PEER_ID =3D 1,
+	OVPN_A_KEYCONF_SLOT,
+	OVPN_A_KEYCONF_KEY_ID,
+	OVPN_A_KEYCONF_CIPHER_ALG,
+	OVPN_A_KEYCONF_ENCRYPT_DIR,
+	OVPN_A_KEYCONF_DECRYPT_DIR,

-	__OVPN_KEY_DIR_ATTR_AFTER_LAST,
-	OVPN_KEY_DIR_ATTR_MAX =3D __OVPN_KEY_DIR_ATTR_AFTER_LAST - 1,
+	__OVPN_A_KEYCONF_MAX,
+	OVPN_A_KEYCONF_MAX =3D (__OVPN_A_KEYCONF_MAX - 1)
 };

-enum ovpn_netlink_new_key_attrs {
-	OVPN_NEW_KEY_ATTR_UNSPEC =3D 0,
-	OVPN_NEW_KEY_ATTR_PEER_ID,
-	OVPN_NEW_KEY_ATTR_KEY_SLOT,
-	OVPN_NEW_KEY_ATTR_KEY_ID,
-	OVPN_NEW_KEY_ATTR_CIPHER_ALG,
-	OVPN_NEW_KEY_ATTR_ENCRYPT_KEY,
-	OVPN_NEW_KEY_ATTR_DECRYPT_KEY,
+enum {
+	OVPN_A_KEYDIR_CIPHER_KEY =3D 1,
+	OVPN_A_KEYDIR_NONCE_TAIL,

-	__OVPN_NEW_KEY_ATTR_AFTER_LAST,
-	OVPN_NEW_KEY_ATTR_MAX =3D __OVPN_NEW_KEY_ATTR_AFTER_LAST - 1,
+	__OVPN_A_KEYDIR_MAX,
+	OVPN_A_KEYDIR_MAX =3D (__OVPN_A_KEYDIR_MAX - 1)
 };

-enum ovpn_netlink_del_key_attrs {
-	OVPN_DEL_KEY_ATTR_UNSPEC =3D 0,
-	OVPN_DEL_KEY_ATTR_PEER_ID,
-	OVPN_DEL_KEY_ATTR_KEY_SLOT,
+enum {
+	OVPN_A_IFINDEX =3D 1,
+	OVPN_A_PEER,
+	OVPN_A_KEYCONF,

-	__OVPN_DEL_KEY_ATTR_AFTER_LAST,
-	OVPN_DEL_KEY_ATTR_MAX =3D __OVPN_DEL_KEY_ATTR_AFTER_LAST - 1,
+	__OVPN_A_MAX,
+	OVPN_A_MAX =3D (__OVPN_A_MAX - 1)
 };

-enum ovpn_netlink_swap_keys_attrs {
-	OVPN_SWAP_KEYS_ATTR_UNSPEC =3D 0,
-	OVPN_SWAP_KEYS_ATTR_PEER_ID,
+enum {
+	OVPN_CMD_PEER_NEW =3D 1,
+	OVPN_CMD_PEER_SET,
+	OVPN_CMD_PEER_GET,
+	OVPN_CMD_PEER_DEL,
+	OVPN_CMD_PEER_DEL_NTF,
+	OVPN_CMD_KEY_NEW,
+	OVPN_CMD_KEY_GET,
+	OVPN_CMD_KEY_SWAP,
+	OVPN_CMD_KEY_SWAP_NTF,
+	OVPN_CMD_KEY_DEL,

-	__OVPN_SWAP_KEYS_ATTR_AFTER_LAST,
-	OVPN_SWAP_KEYS_ATTR_MAX =3D __OVPN_SWAP_KEYS_ATTR_AFTER_LAST - 1,
-
+	__OVPN_CMD_MAX,
+	OVPN_CMD_MAX =3D (__OVPN_CMD_MAX - 1)
 };

-enum ovpn_netlink_new_peer_attrs {
-	OVPN_NEW_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_NEW_PEER_ATTR_PEER_ID,
-	OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE,
-	OVPN_NEW_PEER_ATTR_SOCKET,
-	OVPN_NEW_PEER_ATTR_IPV4,
-	OVPN_NEW_PEER_ATTR_IPV6,
-	OVPN_NEW_PEER_ATTR_LOCAL_IP,
+#define OVPN_MCGRP_PEERS	"peers"

-	__OVPN_NEW_PEER_ATTR_AFTER_LAST,
-	OVPN_NEW_PEER_ATTR_MAX =3D __OVPN_NEW_PEER_ATTR_AFTER_LAST - 1,
-};
-
-enum ovpn_netlink_set_peer_attrs {
-	OVPN_SET_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_SET_PEER_ATTR_PEER_ID,
-	OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,
-	OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,
-
-	__OVPN_SET_PEER_ATTR_AFTER_LAST,
-	OVPN_SET_PEER_ATTR_MAX =3D __OVPN_SET_PEER_ATTR_AFTER_LAST - 1,
-};
-
-enum ovpn_netlink_del_peer_attrs {
-	OVPN_DEL_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_DEL_PEER_ATTR_REASON,
-	OVPN_DEL_PEER_ATTR_PEER_ID,
-
-	__OVPN_DEL_PEER_ATTR_AFTER_LAST,
-	OVPN_DEL_PEER_ATTR_MAX =3D __OVPN_DEL_PEER_ATTR_AFTER_LAST - 1,
-};
-
-enum ovpn_netlink_get_peer_attrs {
-	OVPN_GET_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_GET_PEER_ATTR_PEER_ID,
-
-	__OVPN_GET_PEER_ATTR_AFTER_LAST,
-	OVPN_GET_PEER_ATTR_MAX =3D __OVPN_GET_PEER_ATTR_AFTER_LAST - 1,
-};
-
-enum ovpn_netlink_get_peer_response_attrs {
-	OVPN_GET_PEER_RESP_ATTR_UNSPEC =3D 0,
-	OVPN_GET_PEER_RESP_ATTR_PEER_ID,
-	OVPN_GET_PEER_RESP_ATTR_SOCKADDR_REMOTE,
-	OVPN_GET_PEER_RESP_ATTR_IPV4,
-	OVPN_GET_PEER_RESP_ATTR_IPV6,
-	OVPN_GET_PEER_RESP_ATTR_LOCAL_IP,
-	OVPN_GET_PEER_RESP_ATTR_LOCAL_PORT,
-	OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_INTERVAL,
-	OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_TIMEOUT,
-	OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES,
-	OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES,
-	OVPN_GET_PEER_RESP_ATTR_VPN_RX_PACKETS,
-	OVPN_GET_PEER_RESP_ATTR_VPN_TX_PACKETS,
-	OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES,
-	OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES,
-	OVPN_GET_PEER_RESP_ATTR_LINK_RX_PACKETS,
-	OVPN_GET_PEER_RESP_ATTR_LINK_TX_PACKETS,
-
-	__OVPN_GET_PEER_RESP_ATTR_AFTER_LAST,
-	OVPN_GET_PEER_RESP_ATTR_MAX =3D __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST - 1,
-};
-
-enum ovpn_netlink_peer_stats_attrs {
-	OVPN_PEER_STATS_ATTR_UNSPEC =3D 0,
-	OVPN_PEER_STATS_BYTES,
-	OVPN_PEER_STATS_PACKETS,
-
-	__OVPN_PEER_STATS_ATTR_AFTER_LAST,
-	OVPN_PEER_STATS_ATTR_MAX =3D __OVPN_PEER_STATS_ATTR_AFTER_LAST - 1,
-};
-
-enum ovpn_netlink_peer_attrs {
-	OVPN_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_PEER_ATTR_PEER_ID,
-	OVPN_PEER_ATTR_SOCKADDR_REMOTE,
-	OVPN_PEER_ATTR_IPV4,
-	OVPN_PEER_ATTR_IPV6,
-	OVPN_PEER_ATTR_LOCAL_IP,
-	OVPN_PEER_ATTR_KEEPALIVE_INTERVAL,
-	OVPN_PEER_ATTR_KEEPALIVE_TIMEOUT,
-	OVPN_PEER_ATTR_ENCRYPT_KEY,
-	OVPN_PEER_ATTR_DECRYPT_KEY,
-	OVPN_PEER_ATTR_RX_STATS,
-	OVPN_PEER_ATTR_TX_STATS,
-
-	__OVPN_PEER_ATTR_AFTER_LAST,
-	OVPN_PEER_ATTR_MAX =3D __OVPN_PEER_ATTR_AFTER_LAST - 1,
-};
-
-enum ovpn_netlink_packet_attrs {
-	OVPN_PACKET_ATTR_UNSPEC =3D 0,
-	OVPN_PACKET_ATTR_PACKET,
-	OVPN_PACKET_ATTR_PEER_ID,
-
-	__OVPN_PACKET_ATTR_AFTER_LAST,
-	OVPN_PACKET_ATTR_MAX =3D __OVPN_PACKET_ATTR_AFTER_LAST - 1,
-};
-
-enum ovpn_ifla_attrs {
-	IFLA_OVPN_UNSPEC =3D 0,
-	IFLA_OVPN_MODE,
-
-	__IFLA_OVPN_AFTER_LAST,
-	IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,
-};
-
-enum ovpn_mode {
-	__OVPN_MODE_FIRST =3D 0,
-	OVPN_MODE_P2P =3D __OVPN_MODE_FIRST,
-	OVPN_MODE_MP,
-
-	__OVPN_MODE_AFTER_LAST,
-};
-
-#endif /* _UAPI_LINUX_OVPN_DCO_H_ */
+#endif /* _UAPI_LINUX_OVPN_H */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/941?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I009f4e7ad38636f1c0b78d267561194c2bb4c051
Gerrit-Change-Number: 941
Gerrit-PatchSet: 7
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--2zg4UMfL8gY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #7</strong> to the change originally cr=
eated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
941?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco_linux: Introduce new uAPIs<br><br>This patch upd=
ates the dco userspace API to<br>support communication with the new in-kern=
el<br>driver.<br><br>The main change involves updating the enums<br>used fo=
r Netlink messages to match the<br>definitions expected by the kernel modul=
e.<br><br>Change-Id: I009f4e7ad38636f1c0b78d267561194c2bb4c051<br>Signed-of=
f-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>Acked-by: Gert D=
oering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250505085722.28761-1-ge=
rt@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg31554.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_linux.h<=
br>M src/openvpn/networking_sitnl.c<br>M src/openvpn/ovpn_dco_linux.h<br>4 =
files changed, 249 insertions(+), 350 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/41/941/7</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index =
b0a85fd..c950e3d 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span=
><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -96,7 +96,7 @@<=
/span><br><span>     }</span><br><span>     set_cloexec(nl_socket_get_fd(nl=
_sock));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    ret =3D genl_ctrl_resolve(nl_sock, OVPN_NL_NAME);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ret =3D genl_ctrl_resolve(nl_soc=
k, OVPN_FAMILY_NAME);</span><br><span>     if (ret &lt; 0)</span><br><span>=
     {</span><br><span>         msg(msglevel, &quot;Cannot find ovpn_dco ne=
tlink component: %s&quot;,</span><br><span>@@ -109,7 +109,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static struct nl_msg *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_nlmsg_create(dco_contex=
t_t *dco, enum ovpn_nl_commands cmd)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ovpn_dco_nlmsg_create(dco_context_t *dco, int cmd)</span><=
br><span> {</span><br><span>     struct nl_msg *nl_msg =3D nlmsg_alloc();</=
span><br><span>     if (!nl_msg)</span><br><span>@@ -119,7 +119,7 @@</span>=
<br><span>     }</span><br><span> </span><br><span>     genlmsg_put(nl_msg,=
 0, 0, dco-&gt;ovpn_dco_id, 0, 0, cmd, 0);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_ATTR_IFINDEX, dco-&gt;ifi=
ndex);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U=
32(nl_msg, OVPN_A_IFINDEX, dco-&gt;ifindex);</span><br><span> </span><br><s=
pan>     return nl_msg;</span><br><span> nla_put_failure:</span><br><span>@=
@ -231,20 +231,31 @@</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-i=
d %d, fd %d, remote addr: %s&quot;, __func__,</span><br><span>         peer=
id, sd, remotestr);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OV=
PN_CMD_NEW_PEER);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_NEW_PEER);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl_msg *nl_msg =
=3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NEW);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct nlattr *attr =3D nla_nest_start(n=
l_msg, OVPN_A_PEER);</span><br><span>     int ret =3D -EMSGSIZE;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U3=
2(nl_msg, OVPN_NEW_PEER_ATTR_PEER_ID, peerid);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_SOCKET,=
 sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U3=
2(nl_msg, OVPN_A_PEER_ID, peerid);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_SOCKET, sd);</span><br><=
span> </span><br><span>     /* Set the remote endpoint if defined (for UDP)=
 */</span><br><span>     if (remoteaddr)</span><br><span>     {</span><br><=
span>         remoteaddr =3D mapped_v4_to_v6(remoteaddr, &amp;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        int alen =3D af_addr_s=
ize(remoteaddr-&gt;sa_family);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_SOCKA=
DDR_REMOTE, alen, remoteaddr);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (remoteaddr-&gt;sa_family =3D=3D AF_INET)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            NLA_PUT(nl_msg, OVPN_A_PEER_R=
EMOTE_IPV4, sizeof(struct in_addr),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    &amp;((struct sockaddr_in *)remoteaddr)=
-&gt;sin_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        NLA_PUT_U16(nl_msg, OVPN_A_PEER_REMOTE_PORT, ((struct sockaddr_in *=
)remoteaddr)-&gt;sin_port);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else if (remoteaddr-&gt;sa_family =3D=3D AF_INET6)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            NLA_PUT(nl_msg, OVPN_A_PEER_REMOTE_I=
PV6, sizeof(struct in6_addr),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    &amp;((struct sockaddr_in6 *)remoteaddr)-&gt;=
sin6_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    NLA_PUT_U16(nl_msg, OVPN_A_PEER_REMOTE_PORT, ((struct sockaddr_in6 *)re=
moteaddr)-&gt;sin6_port);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            NLA_PUT_U32(nl_msg, OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID, ((s=
truct sockaddr_in6 *)remoteaddr)-&gt;sin6_scope_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><b=
r><span> </span><br><span>     if (localaddr)</span><br><span>@@ -252,24 +2=
63,26 @@</span><br><span>         localaddr =3D mapped_v4_to_v6(localaddr, =
&amp;gc);</span><br><span>         if (localaddr-&gt;sa_family =3D=3D AF_IN=
ET)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(st=
ruct in_addr),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       NLA_PUT(nl_msg, OVPN_A_PEER_LOCAL_IPV4, sizeof(struct in_addr),</spa=
n><br><span>                     &amp;((struct sockaddr_in *)localaddr)-&gt=
;sin_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    NLA_PUT_U16(nl_msg, OVPN_A_PEER_LOCAL_PORT, ((struct sockaddr_in *)loca=
laddr)-&gt;sin_port);</span><br><span>         }</span><br><span>         e=
lse if (localaddr-&gt;sa_family =3D=3D AF_INET6)</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            NLA_PUT(n=
l_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in6_addr),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            NLA_PUT(nl_msg, OVPN_A=
_PEER_LOCAL_IPV6, sizeof(struct in6_addr),</span><br><span>                =
     &amp;((struct sockaddr_in6 *)localaddr)-&gt;sin6_addr);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            NLA_PUT_U16(nl_msg, OV=
PN_A_PEER_LOCAL_PORT, ((struct sockaddr_in6 *)localaddr)-&gt;sin6_port);</s=
pan><br><span>         }</span><br><span>     }</span><br><span> </span><br=
><span>     /* Set the primary VPN IP addresses of the peer */</span><br><s=
pan>     if (vpn_ipv4)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4=
, vpn_ipv4-&gt;s_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_VPN_IPV4, vpn_ipv4-&gt;s_addr);=
</span><br><span>     }</span><br><span>     if (vpn_ipv6)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        NLA_PUT=
(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        NLA_PUT(nl_msg, OVPN_A_PEER_=
VPN_IPV6, sizeof(struct in6_addr),</span><br><span>                 vpn_ipv=
6);</span><br><span>     }</span><br><span>     nla_nest_end(nl_msg, attr);=
</span><br><span>@@ -481,7 +494,7 @@</span><br><span>     msg(D_DCO_DEBUG, =
&quot;%s: %s&quot;, __func__, dev);</span><br><span>     ASSERT(tt-&gt;type=
 =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int ret =3D net_iface_new(ctx, dev, &quot;ovpn-dco&q=
uot;, &amp;tt-&gt;dco);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int ret =3D net_iface_new(ctx, dev, OVPN_FAMILY_NAME, &amp;tt-&gt;d=
co);</span><br><span>     if (ret &lt; 0)</span><br><span>     {</span><br>=
<span>         msg(D_DCO_DEBUG, &quot;Cannot create DCO interface %s: %d&qu=
ot;, dev, ret);</span><br><span>@@ -515,15 +528,15 @@</span><br><span> {</s=
pan><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, p=
eerid);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_SWAP_=
KEYS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl=
_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_SWAP);</span><br><=
span>     if (!nl_msg)</span><br><span>     {</span><br><span>         retu=
rn -ENOMEM;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *attr =3D nla_nest_start(=
nl_msg, OVPN_ATTR_SWAP_KEYS);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF=
);</span><br><span>     int ret =3D -EMSGSIZE;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR_PEER_I=
D, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_=
PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);</span><br><span>     nla_n=
est_end(nl_msg, attr);</span><br><span> </span><br><span>     ret =3D ovpn_=
nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><span>@@ -539,15 =
+552,15 @@</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%=
s: peer-id %d&quot;, __func__, peerid);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct nl_msg *nl_msg =3D ovpn_dco_=
nlmsg_create(dco, OVPN_CMD_DEL_PEER);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, =
OVPN_CMD_PEER_DEL);</span><br><span>     if (!nl_msg)</span><br><span>     =
{</span><br><span>         return -ENOMEM;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nl=
attr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_DEL_PEER);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *attr =3D nla_nest=
_start(nl_msg, OVPN_A_PEER);</span><br><span>     int ret =3D -EMSGSIZE;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, =
OVPN_DEL_PEER_ATTR_PEER_ID, peerid);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);</span><br=
><span>     nla_nest_end(nl_msg, attr);</span><br><span> </span><br><span> =
    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br>=
<span>@@ -562,19 +575,19 @@</span><br><span> dco_del_key(dco_context_t *dco=
, unsigned int peerid,</span><br><span>             dco_key_slot_t slot)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int ret =3D -EMSGSIZE;</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: pee=
r-id %d, slot %d&quot;, __func__, peerid, slot);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct nl_msg *nl_msg =3D =
ovpn_dco_nlmsg_create(dco, OVPN_CMD_DEL_KEY);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_crea=
te(dco, OVPN_CMD_KEY_DEL);</span><br><span>     if (!nl_msg)</span><br><spa=
n>     {</span><br><span>         return -ENOMEM;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_DEL_KEY);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -EMSGSIZE;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVP=
N_DEL_KEY_ATTR_PEER_ID, peerid);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    NLA_PUT_U8(nl_msg, OVPN_DEL_KEY_ATTR_KEY_SLOT, slot);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_nest_end(nl_msg, att=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlatt=
r *keyconf =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_P=
EER_ID, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, slot);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    nla_nest_end(nl_msg, keyconf);</span><br><=
span> </span><br><span>     ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NUL=
L, __func__);</span><br><span> </span><br><span>@@ -596,7 +609,7 @@</span><=
br><span>     const size_t key_len =3D cipher_kt_key_size(ciphername);</spa=
n><br><span>     const int nonce_tail_len =3D 8;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct nl_msg *nl_msg =3D =
ovpn_dco_nlmsg_create(dco, OVPN_CMD_NEW_KEY);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_crea=
te(dco, OVPN_CMD_KEY_NEW);</span><br><span>     if (!nl_msg)</span><br><spa=
n>     {</span><br><span>         return -ENOMEM;</span><br><span>@@ -605,3=
3 +618,35 @@</span><br><span>     dco_cipher_t dco_cipher =3D dco_get_ciphe=
r(ciphername);</span><br><span> </span><br><span>     int ret =3D -EMSGSIZE=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *a=
ttr =3D nla_nest_start(nl_msg, OVPN_ATTR_NEW_KEY);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_NEW_KEY_ATTR_PEER=
_ID, peerid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_=
PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_SLOT, slot);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_ID=
, keyid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_=
U16(nl_msg, OVPN_NEW_KEY_ATTR_CIPHER_ALG, dco_cipher);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct nlattr *key_conf =3D nla_nest_start(nl_msg, OVPN=
_A_KEYCONF);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA=
_PUT_U32(nl_msg, OVPN_A_KEYCONF_PEER_ID, peerid);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_SLOT, =
slot);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U=
32(nl_msg, OVPN_A_KEYCONF_KEY_ID, keyid);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_KEYCONF_CIPHER_ALG, dc=
o_cipher);</span><br><span> </span><br><span>     struct nlattr *key_enc =
=3D nla_nest_start(nl_msg,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                            OVPN_NEW_KEY_ATTR_ENCRYPT_=
KEY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                              OVPN_A_KEYCONF_ENCRYPT_DIR);</span><br><span>=
     if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        NLA_PUT(nl_msg, OVP=
N_KEY_DIR_ATTR_CIPHER_KEY, key_len, encrypt_key);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE=
_TAIL, nonce_tail_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, key_len, encrypt_key);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        NLA_PUT(nl_=
msg, OVPN_A_KEYDIR_NONCE_TAIL, nonce_tail_len,</span><br><span>            =
     encrypt_iv);</span><br><span>     }</span><br><span>     nla_nest_end(=
nl_msg, key_enc);</span><br><span> </span><br><span>     struct nlattr *key=
_dec =3D nla_nest_start(nl_msg,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                            OVPN_NEW_KEY_ATTR_DEC=
RYPT_KEY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                   OVPN_A_KEYCONF_DECRYPT_DIR);</span><br><=
span>     if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        NLA_PUT(nl_msg=
, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, decrypt_key);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_=
NONCE_TAIL, nonce_tail_len,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        NLA_PUT(nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, key_len, decrypt_=
key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        NLA_PU=
T(nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, nonce_tail_len,</span><br><span>       =
          decrypt_iv);</span><br><span>     }</span><br><span>     nla_nest=
_end(nl_msg, key_dec);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    nla_nest_end(nl_msg, attr);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    nla_nest_end(nl_msg, key_conf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br=
><span>     ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</s=
pan><br><span> </span><br><span>@@ -647,18 +662,18 @@</span><br><span>     =
msg(D_DCO_DEBUG, &quot;%s: peer-id %d, keepalive %d/%d, mss %d&quot;, __fun=
c__,</span><br><span>         peerid, keepalive_interval, keepalive_timeout=
, mss);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_SET_P=
EER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl_=
msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_SET);</span><br><s=
pan>     if (!nl_msg)</span><br><span>     {</span><br><span>         retur=
n -ENOMEM;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *attr =3D nla_nest_start(=
nl_msg, OVPN_ATTR_SET_PEER);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);</=
span><br><span>     int ret =3D -EMSGSIZE;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_PEER_ID, pe=
erid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32=
(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl=
_msg, OVPN_A_PEER_KEEPALIVE_INTERVAL,</span><br><span>                 keep=
alive_interval);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    N=
LA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_KE=
EPALIVE_TIMEOUT,</span><br><span>                 keepalive_timeout);</span=
><br><span>     nla_nest_end(nl_msg, attr);</span><br><span> </span><br><sp=
an>@@ -707,7 +722,7 @@</span><br><span>         }</span><br><span> </span><=
br><span>         if (strncmp(nla_data(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME]),=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    O=
VPN_NL_MULTICAST_GROUP_PEERS,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    OVPN_MCGRP_PEERS,</span><br><span>           =
          nla_len(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME])) !=3D 0)</span><br><s=
pan>         {</span><br><span>             continue;</span><br><span>@@ -7=
20,7 +735,7 @@</span><br><span> }</span><br><span> /**</span><br><span>  * =
Lookup the multicast id for OpenVPN. This method and its help method curren=
tly</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * hardcode the lo=
okup to OVPN_NL_NAME and OVPN_NL_MULTICAST_GROUP_PEERS but</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * hardcode the lookup to OVPN_FAMIL=
Y_NAME and OVPN_MCGRP_PEERS but</span><br><span>  * extended in the future =
if we need to lookup more than one mcast id.</span><br><span>  */</span><br=
><span> static int</span><br><span>@@ -741,7 +756,7 @@</span><br><span>    =
 genlmsg_put(nl_msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);</span><br>=
<span> </span><br><span>     int ret =3D -EMSGSIZE;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY=
_NAME, OVPN_NL_NAME);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_FAMILY_NAME);</spa=
n><br><span> </span><br><span>     ret =3D ovpn_nl_msg_send(dco, nl_msg, mc=
ast_family_handler, dco, __func__);</span><br><span> </span><br><span>@@ -7=
57,38 +772,38 @@</span><br><span>     dco_context_t *dco =3D arg;</span><br=
><span> </span><br><span>     struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_=
hdr(msg));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
nlattr *attrs[OVPN_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct nlattr *attrs[OVPN_A_MAX + 1];</span><br><span>   =
  struct nlmsghdr *nlh =3D nlmsg_hdr(msg);</span><br><span> </span><br><spa=
n>     if (!genlmsg_valid_hdr(nlh, 0))</span><br><span>     {</span><br><sp=
an>         msg(D_DCO, &quot;ovpn-dco: invalid header&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return NL_STOP;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (nla_parse(attrs, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, =
0),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (nla_pars=
e(attrs, OVPN_A_MAX, genlmsg_attrdata(gnlh, 0),</span><br><span>           =
        genlmsg_attrlen(gnlh, 0), NULL))</span><br><span>     {</span><br><=
span>         msg(D_DCO, &quot;received bogus data from ovpn-dco&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NL_ST=
OP;</span><br><span>     }</span><br><span> </span><br><span>     /* we mus=
t know which interface this message is referring to in order to</span><br><=
span>      * avoid mixing messages for other instances</span><br><span>    =
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!attrs[OV=
PN_ATTR_IFINDEX])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!attrs[OVPN_A_IFINDEX])</span><br><span>     {</span><br><span>      =
   msg(D_DCO, &quot;ovpn-dco: Received message without ifindex&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NL_STOP=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_I=
FINDEX]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32=
_t ifindex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]);</span><br><span>     if =
(ifindex !=3D dco-&gt;ifindex)</span><br><span>     {</span><br><span>     =
    msg(D_DCO_DEBUG,</span><br><span>             &quot;ovpn-dco: ignoring =
message (type=3D%d) for foreign ifindex %d&quot;,</span><br><span>         =
    gnlh-&gt;cmd, ifindex);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return NL_STOP;</span><br><span>     }</span><br><span> <=
/span><br><span>     /* based on the message type, we parse the subobject c=
ontained in the</span><br><span>@@ -800,48 +815,85 @@</span><br><span>     =
 */</span><br><span>     switch (gnlh-&gt;cmd)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        case OVPN_CMD_DEL_P=
EER:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case OV=
PN_CMD_PEER_DEL_NTF:</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            if (!attrs[OVPN_ATTR_DEL_PEER])</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!attrs[OV=
PN_A_PEER])</span><br><span>             {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: no attribut=
es in OVPN_DEL_PEER message&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                return NL_SKIP;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                msg(D_DCO, &quot;ovpn-dco: no pee=
r in PEER_DEL_NTF message&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                return NL_STOP;</span><br><span>             =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          struct nlattr *dp_attrs[OVPN_DEL_PEER_ATTR_MAX + 1];</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (nla_parse_nested(d=
p_attrs, OVPN_DEL_PEER_ATTR_MAX,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                 attrs[OVPN_ATTR_DEL_PEER], NULL=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struc=
t nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (nla_parse_nested(dp_attrs, OVPN_A_PEER=
_MAX, attrs[OVPN_A_PEER],</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                 NULL))</span><br><span>             =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(=
D_DCO, &quot;received bogus del peer packet data from ovpn-dco&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                return NL_=
SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  msg(D_DCO, &quot;ovpn-dco: can&#39;t parse peer in PEER_DEL_NTF messsage&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    return NL_STOP;</span><br><span>             }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!dp_attrs[OV=
PN_DEL_PEER_ATTR_REASON])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (!dp_attrs[OVPN_A_PEER_DEL_REASON])</span><br><span>  =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       msg(D_DCO, &quot;ovpn-dco: no reason in DEL_PEER message&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                return NL=
_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   msg(D_DCO, &quot;ovpn-dco: no reason in PEER_DEL_NTF message&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                return =
NL_STOP;</span><br><span>             }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (!dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!dp_at=
trs[OVPN_A_PEER_ID])</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: =
no peer-id in DEL_PEER message&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                return NL_SKIP;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                msg(D_DCO, &quot;ovpn-dco: no =
peer-id in PEER_DEL_NTF message&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                return NL_STOP;</span><br><span>       =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            in=
t reason =3D nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_REASON]);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            unsigned int peerid =3D=
 nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID]);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG=
, &quot;ovpn-dco: received CMD_DEL_PEER, ifindex: %d, peer-id %d, reason: %=
d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 int reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            unsigned int peerid =
=3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_PEER_DEL_NTF,=
 ifindex: %d, peer-id %u, reason: %d&quot;,</span><br><span>               =
  ifindex, peerid, reason);</span><br><span>             dco-&gt;dco_messag=
e_peer_id =3D peerid;</span><br><span>             dco-&gt;dco_del_peer_rea=
son =3D reason;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      dco-&gt;dco_message_type =3D OVPN_CMD_DEL_PEER;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            dco-&gt;dco_message_type =3D =
OVPN_CMD_PEER_DEL_NTF;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case OVPN_CMD_KEY_SWAP_NTF:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (!attrs[OVPN_A_KEYCONF])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                msg(D_DCO, &quot;ovpn-dco: no=
 keyconf in KEY_SWAP_NTF message&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                return NL_STOP;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            struct nlattr *dp_attrs[OVPN_A_KEYCONF_MAX + 1];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (nla_parse=
_nested(dp_attrs, OVPN_A_KEYCONF_MAX,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                 attrs[OVPN_A_KEYCONF], N=
ULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
D_DCO, &quot;ovpn-dco: can&#39;t parse keyconf in KEY_SWAP_NTF message&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (!dp_attrs[OVPN_A_KEYCONF_PEER_ID])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                msg(D_DCO, &quot;ovpn-dco: no peer-id in KEY=
_SWAP_NTF message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                return NL_STOP;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (!dp_attrs[OVPN_A_KEYCONF_KEY_ID])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                msg(D_DCO, &quot;ovpn-d=
co: no key-id in KEY_SWAP_NTF message&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                return NL_STOP;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            int key_id =3D nla_get_u16(dp_attrs[OVPN_A_KEYCO=
NF_KEY_ID]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     unsigned int peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO_DEBUG, &quot;ov=
pn-dco: received CMD_KEY_SWAP_NTF, ifindex: %d, peer-id %u, key-id: %d&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                i=
findex, peer_id, key_id);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            dco-&gt;dco_message_peer_id =3D peer_id;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            dco-&gt;dco_message_key_=
id =3D key_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       dco-&gt;dco_message_type =3D OVPN_CMD_KEY_SWAP_NTF;</span><br><span>=
             break;</span><br><span>         }</span><br><span> </span><br>=
<span>         default:</span><br><span>             msg(D_DCO, &quot;ovpn-=
dco: received unknown command: %d&quot;, gnlh-&gt;cmd);</span><br><span>   =
          dco-&gt;dco_message_type =3D 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            return NL_SKIP;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return NL_STOP;</span><br><span>   =
  }</span><br><span> </span><br><span>     return NL_OK;</span><br><span>@@=
 -859,9 +911,9 @@</span><br><span> static void</span><br><span> dco_update_=
peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tb[O=
VPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (tb[OVPN_A_PEER_LINK_RX_BYTES])</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c2-&gt;d=
co_read_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c2-&gt;dco_re=
ad_bytes =3D nla_get_u64(tb[OVPN_A_PEER_LINK_RX_BYTES]);</span><br><span>  =
       msg(D_DCO_DEBUG, &quot;%s / dco_read_bytes: &quot; counter_format, _=
_func__,</span><br><span>             c2-&gt;dco_read_bytes);</span><br><sp=
an>     }</span><br><span>@@ -871,9 +923,9 @@</span><br><span>             =
__func__, id);</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_T=
X_BYTES])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tb=
[OVPN_A_PEER_LINK_TX_BYTES])</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        c2-&gt;dco_write_bytes =3D nla_get_=
u64(tb[OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        c2-&gt;dco_write_bytes =3D nla_get_u64(=
tb[OVPN_A_PEER_LINK_TX_BYTES]);</span><br><span>         msg(D_DCO_DEBUG, &=
quot;%s / dco_write_bytes: &quot; counter_format, __func__,</span><br><span=
>             c2-&gt;dco_write_bytes);</span><br><span>     }</span><br><sp=
an>@@ -883,9 +935,9 @@</span><br><span>             __func__, id);</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (tb[OVPN_A_PEER_VPN_RX_BYTE=
S])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        c2-&gt;tun_read_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_AT=
TR_VPN_RX_BYTES]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       c2-&gt;tun_read_bytes =3D nla_get_u64(tb[OVPN_A_PEER_VPN_RX_BYTES]);=
</span><br><span>         msg(D_DCO_DEBUG, &quot;%s / tun_read_bytes: &quot=
; counter_format, __func__,</span><br><span>             c2-&gt;tun_read_by=
tes);</span><br><span>     }</span><br><span>@@ -895,9 +947,9 @@</span><br>=
<span>             __func__, id);</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tb[OVPN_GET_PE=
ER_RESP_ATTR_VPN_TX_BYTES])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (tb[OVPN_A_PEER_VPN_TX_BYTES])</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        c2-&gt;tun_write_byt=
es =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES]);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        c2-&gt;tun_write_bytes =
=3D nla_get_u64(tb[OVPN_A_PEER_VPN_TX_BYTES]);</span><br><span>         msg=
(D_DCO_DEBUG, &quot;%s / tun_write_bytes: &quot; counter_format, __func__,<=
/span><br><span>             c2-&gt;tun_write_bytes);</span><br><span>     =
}</span><br><span>@@ -911,33 +963,30 @@</span><br><span> int</span><br><spa=
n> dco_parse_peer_multi(struct nl_msg *msg, void *arg)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb[O=
VPN_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct nlattr *tb[OVPN_A_MAX + 1];</span><br><span>     struct genlmsghd=
r *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span> </span><br><span> =
    msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __func__);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_par=
se(tb, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    nla_parse(tb, OVPN_A_MAX, genlmsg_attrdata=
(gnlh, 0),</span><br><span>               genlmsg_attrlen(gnlh, 0), NULL);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!tb[OVPN_ATTR_GET_PEER])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!tb[OVPN_A_PEER])</span><br><span>     {</span><br><span> =
        return NL_SKIP;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb_peer[OVPN_=
GET_PEER_RESP_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    nla_parse_nested(tb_peer, OVPN_A_=
PEER_MAX, tb[OVPN_A_PEER], NULL);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb_peer, OVPN_GET_PEER_RESP_A=
TTR_MAX,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
 nla_data(tb[OVPN_ATTR_GET_PEER]),</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-              nla_len(tb[OVPN_ATTR_GET_PEER]), NULL);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (!tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tb_peer[OVP=
N_A_PEER_ID])</span><br><span>     {</span><br><span>         msg(M_WARN, &=
quot;%s: no peer-id provided in reply&quot;, __func__);</span><br><span>   =
      return NL_SKIP;</span><br><span>     }</span><br><span> </span><br><s=
pan>     struct multi_context *m =3D arg;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_P=
EER_RESP_ATTR_PEER_ID]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><=
br><span> </span><br><span>     if (peer_id &gt;=3D m-&gt;max_clients || !m=
-&gt;instances[peer_id])</span><br><span>     {</span><br><span>@@ -957,7 +=
1006,7 @@</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s=
&quot;, __func__);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVP=
N_CMD_GET_PEER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);</=
span><br><span> </span><br><span>     nlmsg_hdr(nl_msg)-&gt;nlmsg_flags |=
=3D NLM_F_DUMP;</span><br><span> </span><br><span>@@ -979,33 +1028,33 @@</s=
pan><br><span> dco_parse_peer(struct nl_msg *msg, void *arg)</span><br><spa=
n> {</span><br><span>     struct context *c =3D arg;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb[OVPN_ATTR_MAX + 1];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *tb=
[OVPN_A_MAX];</span><br><span>     struct genlmsghdr *gnlh =3D nlmsg_data(n=
lmsg_hdr(msg));</span><br><span> </span><br><span>     msg(D_DCO_DEBUG, &qu=
ot;%s: parsing message...&quot;, __func__);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb, OVPN_ATTR_MAX, ge=
nlmsg_attrdata(gnlh, 0),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    nla_parse(tb, OVPN_A_PEER_MAX, genlmsg_attrdata(gnlh, 0),</span><b=
r><span>               genlmsg_attrlen(gnlh, 0), NULL);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tb[OVPN_ATTR_G=
ET_PEER])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!t=
b[OVPN_A_PEER])</span><br><span>     {</span><br><span>         msg(D_DCO_D=
EBUG, &quot;%s: malformed reply&quot;, __func__);</span><br><span>         =
return NL_SKIP;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb_peer[OVPN_GET_PEER=
_RESP_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct nlattr *tb_peer[OVPN_A_PEER_MAX + 1];</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb_peer, OVPN_G=
ET_PEER_RESP_ATTR_MAX,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-              nla_data(tb[OVPN_ATTR_GET_PEER]),</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-              nla_len(tb[OVPN_ATTR_GET_PEER]), N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_parse(=
tb_peer, OVPN_A_PEER,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+              nla_data(tb[OVPN_A_PEER]),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+              nla_len(tb[OVPN_A_PEER]), NULL);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!tb_peer[OVPN_A_PEER_ID])</span><br><span>   =
  {</span><br><span>         msg(M_WARN, &quot;%s: no peer-id provided in r=
eply&quot;, __func__);</span><br><span>         return NL_SKIP;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATT=
R_PEER_ID]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span>   =
  if (c-&gt;c2.tls_multi-&gt;dco_peer_id !=3D peer_id)</span><br><span>    =
 {</span><br><span>         return NL_SKIP;</span><br><span>@@ -1033,11 +10=
82,11 @@</span><br><span>     }</span><br><span> </span><br><span>     dco_=
context_t *dco =3D &amp;c-&gt;c1.tuntap-&gt;dco;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_cre=
ate(dco, OVPN_CMD_GET_PEER);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_GET_PEE=
R);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl_ms=
g *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *attr =3D nla_ne=
st_start(nl_msg, OVPN_A_PEER);</span><br><span>     int ret =3D -EMSGSIZE;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
NLA_PUT_U32(nl_msg, OVPN_GET_PEER_ATTR_PEER_ID, peer_id);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_I=
D, peer_id);</span><br><span>     nla_nest_end(nl_msg, attr);</span><br><sp=
an> </span><br><span>     ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_p=
eer, c, __func__);</span><br><span>@@ -1071,29 +1120,7 @@</span><br><span> =
const char *</span><br><span> dco_version_string(struct gc_arena *gc)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct buffer out =3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    FILE *fp =3D fopen(&quot;/sys/module/ovpn_dco_v2/ver=
sion&quot;, &quot;r&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (!fp)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return &quo=
t;N/A&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!fgets(BSTR(&amp;out), BCAP(&amp;out),=
 fp))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        fclose(fp);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return &quot;ERR&quot;;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* remove potential newline at the end of the string */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *str =3D BSTR(=
&amp;out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *n=
l =3D strchr(str, &#39;\n&#39;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (nl)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *nl =3D=
 &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    fclose(fp);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return BSTR(&amp;out);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return &quot;Unknown&quot;;</span><br=
><span> }</span><br><span> </span><br><span> void</span><br><span>diff --gi=
t a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h</span><br><span>index=
 511519a..f3abc15 100644</span><br><span>--- a/src/openvpn/dco_linux.h</spa=
n><br><span>+++ b/src/openvpn/dco_linux.h</span><br><span>@@ -31,9 +31,27 @=
@</span><br><span> #include &lt;netlink/socket.h&gt;</span><br><span> #incl=
ude &lt;netlink/netlink.h&gt;</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Defines to avoid mismatching with other plat=
forms */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVP=
N_CMD_DEL_PEER OVPN_CMD_PEER_DEL_NTF</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define OVPN_CMD_SWAP_KEYS OVPN_CMD_KEY_SWAP_NTF</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef enu=
m ovpn_key_slot dco_key_slot_t;</span><br><span> typedef enum ovpn_cipher_a=
lg dco_cipher_t;</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* OVPN section */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum =
ovpn_mode {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN=
_MODE_P2P,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_=
MODE_MP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+enum ovpn_ifla_attrs {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    IFLA_OVPN_UNSPEC =3D 0,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    IFLA_OVPN_MODE,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    __IFLA_OVPN_AFTER_LAST,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - =
1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><spa=
n> </span><br><span> typedef struct</span><br><span> {</span><br><span>@@ -=
50,6 +68,7 @@</span><br><span> </span><br><span>     int dco_message_type;<=
/span><br><span>     int dco_message_peer_id;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int dco_message_key_id;</span><br><span>     =
int dco_del_peer_reason;</span><br><span>     uint64_t dco_read_bytes;</spa=
n><br><span>     uint64_t dco_write_bytes;</span><br><span>diff --git a/src=
/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c</span><br><spa=
n>index 9de8912..a75de9b 100644</span><br><span>--- a/src/openvpn/networkin=
g_sitnl.c</span><br><span>+++ b/src/openvpn/networking_sitnl.c</span><br><s=
pan>@@ -1354,7 +1354,7 @@</span><br><span>     struct rtattr *linkinfo =3D =
SITNL_NEST(&amp;req.n, sizeof(req), IFLA_LINKINFO);</span><br><span>     SI=
TNL_ADDATTR(&amp;req.n, sizeof(req), IFLA_INFO_KIND, type, strlen(type) + 1=
);</span><br><span> #if defined(ENABLE_DCO)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (arg &amp;&amp; (strcmp(type, &quot;ovpn-dco&q=
uot;) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (arg &amp;&amp; (strcmp(type, OVPN_FAMILY_NAME) =3D=3D 0))</span><br><s=
pan>     {</span><br><span>         dco_context_t *dco =3D arg;</span><br><=
span>         struct rtattr *data =3D SITNL_NEST(&amp;req.n, sizeof(req), I=
FLA_INFO_DATA);</span><br><span>diff --git a/src/openvpn/ovpn_dco_linux.h b=
/src/openvpn/ovpn_dco_linux.h</span><br><span>index 73e19b5..680d152 100644=
</span><br><span>--- a/src/openvpn/ovpn_dco_linux.h</span><br><span>+++ b/s=
rc/openvpn/ovpn_dco_linux.h</span><br><span>@@ -1,256 +1,109 @@</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/* SPDX-License-Identifier: (GPL-=
2.0-only WITH Linux-syscall-note) OR MIT */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  OpenVPN data channel accelerator</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  Copyright (C) 2019-2023 OpenVPN, Inc.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  Author:	James Yonan &lt;james@...515...&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *		Antonio Quartulli &lt;antonio@...515...&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* SPDX-License-Identifier: ((GPL-2.0 W=
ITH Linux-syscall-note) OR BSD-3-Clause) */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Do not edit directly, auto-generated from: */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*	Documentation/netli=
nk/specs/ovpn.yaml */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* YNL-GEN uapi header */</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifndef _UAPI_LINUX_OVPN_DCO_H_</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define _UAPI_LINUX_OVPN_DCO_H_</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _UAPI_LINUX_OVPN_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define _UAPI_LINUX_OV=
PN_H</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define OVPN_NL_NAME &quot;ovpn-dco-v2&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define OVPN_FAMILY_NAME	&quot;ovpn&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_FAMILY_VERSION=
	1</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define OVPN_NL_MULTICAST_GROUP_PEERS &quot;peers&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * enu=
m ovpn_nl_commands - supported netlink commands</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-enum ovpn_nl_commands {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 * @OV=
PN_CMD_UNSPEC: unspecified command to catch errors</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	 */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	OVPN_CMD_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	/**</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	 * @OVPN_CMD_NEW_PEER: =
Configure peer with its crypto keys</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OV=
PN_CMD_NEW_PEER,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	/**</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	 * @OVPN_CMD_SET_PEER: Tweak parameters fo=
r an existing peer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_SET_PEER,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	/**</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	 * @OVPN_CMD_DEL_PEER: Remove peer from internal table</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_DEL_PEER,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	OVPN_CMD_NEW_KEY,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_SWA=
P_KEYS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_DEL_KEY,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
 * @OVPN_CMD_GET_PEER: Retrieve the status of a peer or all peers</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	 */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	OVPN_CMD_GET_PEER,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define OVPN_NONCE_TAIL_SIZE	8</span><br><span> </span><br><span> e=
num ovpn_cipher_alg {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 * @OVPN_CIPHER_=
ALG_NONE: No encryption - reserved for debugging only</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	 */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	OVPN_CIPHER_ALG_NONE =3D 0,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	/**</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	 * @OVPN_CIPHER_ALG_AES_GCM: AES-GCM AEAD cipher with any allowed key=
 size</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_CIPHER_ALG_NONE,</span><b=
r><span> 	OVPN_CIPHER_ALG_AES_GCM,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 * =
@OVPN_CIPHER_ALG_CHACHA20_POLY1305: ChaCha20Poly1305 AEAD cipher</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	 */</span><br><span> 	OVPN_CIPH=
ER_ALG_CHACHA20_POLY1305,</span><br><span> };</span><br><span> </span><br><=
span> enum ovpn_del_peer_reason {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	__OVPN_DEL_PEER_REASON_FIRST,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_TEARDOWN =3D __OVPN_DEL_PEER_REA=
SON_FIRST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_DEL=
_PEER_REASON_TEARDOWN,</span><br><span> 	OVPN_DEL_PEER_REASON_USERSPACE,</s=
pan><br><span> 	OVPN_DEL_PEER_REASON_EXPIRED,</span><br><span> 	OVPN_DEL_PE=
ER_REASON_TRANSPORT_ERROR,</span><br><span> 	OVPN_DEL_PEER_REASON_TRANSPORT=
_DISCONNECT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_D=
EL_PEER_REASON_AFTER_LAST</span><br><span> };</span><br><span> </span><br><=
span> enum ovpn_key_slot {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	__OVPN_KEY_SLOT_FIRST,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	OVPN_KEY_SLOT_PRIMARY =3D __OVPN_KEY_SLOT_FIRST,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	OVPN_KEY_SLOT_PRIMARY,</span><br><spa=
n> 	OVPN_KEY_SLOT_SECONDARY,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	__OVPN_KEY_SLOT_AFTER_LAST,</span><br><span> };</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_netlink_attrs=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_UNSPEC =
=3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_IFIN=
DEX,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_NEW_PE=
ER,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_SET_PEE=
R,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_DEL_PEER=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_NEW_KEY,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_SWAP_KEYS,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_DEL_KEY,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_GET_PEER,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+enum {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_ID =3D 1,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_REMOTE_IPV4,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_REMOTE_IPV6,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_REMOTE_I=
PV6_SCOPE_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_=
A_PEER_REMOTE_PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	OVPN_A_PEER_SOCKET,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	OVPN_A_PEER_SOCKET_NETNSID,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	OVPN_A_PEER_VPN_IPV4,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	OVPN_A_PEER_VPN_IPV6,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	OVPN_A_PEER_LOCAL_IPV4,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	OVPN_A_PEER_LOCAL_IPV6,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	OVPN_A_PEER_LOCAL_PORT,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_KEEPALIVE_INTERVAL,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_KEEPALIVE_TIMEOUT,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_DEL_RE=
ASON,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_V=
PN_RX_BYTES,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A=
_PEER_VPN_TX_BYTES,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	OVPN_A_PEER_VPN_RX_PACKETS,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	OVPN_A_PEER_VPN_TX_PACKETS,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	OVPN_A_PEER_LINK_RX_BYTES,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	OVPN_A_PEER_LINK_TX_BYTES,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_LINK_RX_PACKETS,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_LINK_TX_PACKETS,</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OV=
PN_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	O=
VPN_ATTR_MAX =3D __OVPN_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	__OVPN_A_PEER_MAX,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	OVPN_A_PEER_MAX =3D (__OVPN_A_PEER_MAX - 1)</span=
><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-enum ovpn_netlink_key_dir_attrs {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	OVPN_KEY_DIR_ATTR_UNSPEC =3D 0,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_DIR_ATTR_CIPHER_KEY,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_DIR_ATTR_NONCE_TAIL,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_KEYCONF_PEER_ID =3D 1,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_KEYCONF_SLOT,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_KEYCONF_KEY_I=
D,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_KEYCONF_C=
IPHER_ALG,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_K=
EYCONF_ENCRYPT_DIR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	OVPN_A_KEYCONF_DECRYPT_DIR,</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	__OVPN_KEY_DIR_ATTR_AFTER_LAST,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_DIR_ATTR_MAX =3D __OVPN_KEY_D=
IR_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	__OVPN_A_KEYCONF_MAX,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	OVPN_A_KEYCONF_MAX =3D (__OVPN_A_KEYCONF_MAX - 1)</span><br><span> =
};</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-e=
num ovpn_netlink_new_key_attrs {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	OVPN_NEW_KEY_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_PEER_ID,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_KEY_SLOT,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_KEY_ID,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_CIPHER_ALG,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_ENCRYPT=
_KEY,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_AT=
TR_DECRYPT_KEY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_KEYDIR_CI=
PHER_KEY =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVP=
N_A_KEYDIR_NONCE_TAIL,</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	__OVPN_NEW_KEY_ATTR_AFTER_LAST,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_MAX =3D __OVPN_NEW_KEY_A=
TTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	__OVPN_A_KEYDIR_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	OVPN_A_KEYDIR_MAX =3D (__OVPN_A_KEYDIR_MAX - 1)</span><br><span> };</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovp=
n_netlink_del_key_attrs {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	OVPN_DEL_KEY_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	OVPN_DEL_KEY_ATTR_PEER_ID,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	OVPN_DEL_KEY_ATTR_KEY_SLOT,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+enum {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	OVPN_A_IFINDEX =3D 1,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	OVPN_A_PEER,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	OVPN_A_KEYCONF,</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	__OVPN_DEL_KEY_ATTR_AFTER_LAST,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_KEY_ATTR_MAX =3D __OVPN_DEL=
_KEY_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	__OVPN_A_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	OVPN_A_MAX =3D (__OVPN_A_MAX - 1)</span><br><span> };</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_netlink_swap_=
keys_attrs {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_SWA=
P_KEYS_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	OVPN_SWAP_KEYS_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+enum {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	OVPN_CMD_PEER_NEW =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	OVPN_CMD_PEER_SET,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	OVPN_CMD_PEER_GET,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	OVPN_CMD_PEER_DEL,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	OVPN_CMD_PEER_DEL_NTF,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	OVPN_CMD_KEY_NEW,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	OVPN_CMD_KEY_GET,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	OVPN_CMD_KEY_SWAP,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	OVPN_CMD_KEY_SWAP_NTF,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	OVPN_CMD_KEY_DEL,</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	__OVPN_SWAP_KEYS_ATTR_AFTER_LAST,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	OVPN_SWAP_KEYS_ATTR_MAX =3D __OVP=
N_SWAP_KEYS_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	__OVPN_=
CMD_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN_CMD_M=
AX =3D (__OVPN_CMD_MAX - 1)</span><br><span> };</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_netlink_new_peer_attr=
s {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATT=
R_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_=
NEW_PEER_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_SOCKET,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_IPV4,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_IPV6,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_LOCAL_IP,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_MCGRP_PEERS	&quot;pe=
ers&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	__OVPN_NEW_PEER_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_MAX =3D __OVPN_NEW_PEER_ATTR_AFTER_LA=
ST - 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-enum ovpn_netlink_set_peer_attrs {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	OVPN_SET_PEER_ATTR_UNSPEC =3D 0,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_SET_PEER_ATTR_PEER_ID,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_SET_PEER_ATTR_KE=
EPALIVE_INTERVAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVP=
N_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_=
SET_PEER_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	OVPN_SET_PEER_ATTR_MAX =3D __OVPN_SET_PEER_ATTR_AFTER_LAST - 1,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-enum ovpn_netlink_del_peer_attrs {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	OVPN_DEL_PEER_ATTR_UNSPEC =3D 0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_ATTR_REASON,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_ATTR_PEER_ID,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	__OVPN_DEL_PEER_ATTR_AFTER_LAST,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_ATTR_MAX =3D __OVPN_DEL_=
PEER_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_netlink_get_peer_attrs {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_ATTR_UNS=
PEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_P=
EER_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_GET_PEER_ATTR_AFT=
ER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEE=
R_ATTR_MAX =3D __OVPN_GET_PEER_ATTR_AFTER_LAST - 1,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovp=
n_netlink_get_peer_response_attrs {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_UNSPEC =3D 0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_PEER_ID,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_SOCKAD=
DR_REMOTE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_P=
EER_RESP_ATTR_IPV4,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	O=
VPN_GET_PEER_RESP_ATTR_IPV6,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	OVPN_GET_PEER_RESP_ATTR_LOCAL_IP,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_LOCAL_PORT,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_INTER=
VAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RE=
SP_ATTR_KEEPALIVE_TIMEOUT,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_VPN_RX_PACK=
ETS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RE=
SP_ATTR_VPN_TX_PACKETS,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_LINK_RX_PACK=
ETS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RE=
SP_ATTR_LINK_TX_PACKETS,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_GET_PEER_R=
ESP_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
OVPN_GET_PEER_RESP_ATTR_MAX =3D __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST - 1,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-enum ovpn_netlink_peer_stats_attrs {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	OVPN_PEER_STATS_ATTR_UNSPEC =3D 0,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_STATS_BYTES,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_STATS_PACKETS,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	__OVPN_PEER_STATS_ATTR_AFTER_LAST,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_STATS_ATTR_MAX =3D __OVP=
N_PEER_STATS_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_netlink_peer_attrs=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_UNS=
PEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_=
ATTR_PEER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PE=
ER_ATTR_SOCKADDR_REMOTE,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	OVPN_PEER_ATTR_IPV4,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	OVPN_PEER_ATTR_IPV6,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	OVPN_PEER_ATTR_LOCAL_IP,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	OVPN_PEER_ATTR_KEEPALIVE_INTERVAL,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_KEEPALIVE_TIMEOUT,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_ENCRYPT_KEY,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_DECRYPT_KEY,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_RX_STATS,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_TX_STAT=
S,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	__OVPN_PEER_ATTR_AFTER_LAST,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_MAX =3D __OVPN_P=
EER_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_netlink_packet_attrs {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PACKET_ATTR_UNSPEC =
=3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PACKET_AT=
TR_PACKET,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PACKE=
T_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_PACKET_ATTR_AFTER_L=
AST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PACKET_ATTR=
_MAX =3D __OVPN_PACKET_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_ifla_att=
rs {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	IFLA_OVPN_UNSPEC=
 =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	IFLA_OVPN_MOD=
E,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	__IFLA_OVPN_AFTER_LAST,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_=
LAST - 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-enum ovpn_mode {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	__OVPN_MODE_FIRST =3D 0,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	OVPN_MODE_P2P =3D __OVPN_MODE_FIRST,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	OVPN_MODE_MP,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	__OVPN_MODE_AFTER_LAST,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* _UAPI_LINUX_OVPN=
_DCO_H_ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /*=
 _UAPI_LINUX_OVPN_H */</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/941?usp=3Demail">change 941=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/941?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I009f4e7ad38636f1c0b78d26756=
1194c2bb4c051 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 941 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--2zg4UMfL8gY=--

