From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 6 Jun 2024 07:57:37 +0000
References: <gerrit.1717660653000.I6662605b60d4859949970cfe256c55cbcbd4a672@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d6d7319c09738cd68970925f457a0b54c7f46a2a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qMxNiFmUErI="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Lay the foundation
 to support both old and new versions of DCO
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

--qMxNiFmUErI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/661?usp=3Demail

to review the following change.


Change subject: Lay the foundation to support both old and new versions of =
DCO
......................................................................

Lay the foundation to support both old and new versions of DCO

Added a new abstraction layer based on the `struct dco_ops`,
a structure of function pointers that ensures the appropriate
APIs at runtime are used for DCO communication between kernel
and user space, selection is based on the available module's
family name.

The old version, referred to as "ovpn_dco_v2", and its related
commands and functions, will be distinguished with the "v2" suffix.

Change-Id: I6662605b60d4859949970cfe256c55cbcbd4a672
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
M src/openvpn/dco.c
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
A src/openvpn/dco_linux_v2.c
M src/openvpn/dco_win.c
M src/openvpn/forward.c
M src/openvpn/ovpn_dco_linux.h
11 files changed, 1,082 insertions(+), 813 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/661/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 096837d..732be9e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -398,6 +398,7 @@
     src/openvpn/dco_win.h
     src/openvpn/dco_linux.c
     src/openvpn/dco_linux.h
+    src/openvpn/dco_linux_v2.c
     src/openvpn/dco_freebsd.c
     src/openvpn/dco_freebsd.h
     src/openvpn/dhcp.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 56cce9d..286d3c5 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -54,6 +54,7 @@
 	dco.c dco.h dco_internal.h \
 	dco_freebsd.c dco_freebsd.h \
 	dco_linux.c dco_linux.h \
+	dco_linux_v2.c \
 	dco_win.c dco_win.h \
 	dhcp.c dhcp.h \
 	dns.c dns.h \
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 78243b1..80184f8 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -396,7 +396,7 @@
     /* now that all options have been confirmed to be supported, check
      * if DCO is truly available on the system
      */
-    return dco_available(msglevel);
+    return dco_available(msglevel, NULL);
 }

 bool
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 50ebb35..fc34da8 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -56,7 +56,7 @@
  * @param msglevel      level to print messages to
  * @return              true if ovpn-dco is available, false otherwise
  */
-bool dco_available(int msglevel);
+bool dco_available(int msglevel, dco_context_t *dco);


 /**
@@ -254,7 +254,7 @@
 typedef void *dco_context_t;

 static inline bool
-dco_available(int msglevel)
+dco_available(int msglevel, dco_context_t *dco)
 {
     return false;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 7c8b29c..93c0813 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -569,7 +569,7 @@
 }

 bool
-dco_available(int msglevel)
+dco_available(int msglevel, dco_context_t *dco)
 {
     struct if_clonereq ifcr;
     char *buf =3D NULL;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b2584b9..4feae6d 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -51,32 +51,28 @@
 #include <netlink/genl/ctrl.h>


-/* libnl < 3.5.0 does not set the NLA_F_NESTED on its own, therefore we
- * have to explicitly do it to prevent the kernel from failing upon
- * parsing of the message
- */
-#define nla_nest_start(_msg, _type) \
-    nla_nest_start(_msg, (_type) | NLA_F_NESTED)
-
-static int ovpn_get_mcast_id(dco_context_t *dco);
-
-void dco_check_key_ctx(const struct key_ctx_bi *key);
-
-typedef int (*ovpn_nl_cb)(struct nl_msg *msg, void *arg);
-
-/**
- * @brief resolves the netlink ID for ovpn-dco
- *
- * This function queries the kernel via a netlink socket
- * whether the ovpn-dco netlink namespace is available
- *
- * This function can be used to determine if the kernel
- * supports DCO offloading.
- *
- * @return ID on success, negative error code on error
- */
 static int
-resolve_ovpn_netlink_id(int msglevel)
+do_family_name_resolve(struct nl_sock *nl_sock, int msglevel, const char *=
family_name,
+                       dco_context_t *dco, const struct dco_ops *ops)
+{
+    int ret =3D genl_ctrl_resolve(nl_sock, family_name);
+
+    if (ret < 0)
+    {
+        msg(msglevel, "Cannot find %s netlink component: %s", family_name,=
 nl_geterror(ret));
+    }
+
+    if (dco)
+    {
+        /* Ensures that we will use the proper ops for the dco version ava=
ilable */
+        dco->ops =3D ops;
+    }
+
+    return ret;
+}
+
+int
+resolve_ovpn_netlink_id(int msglevel, dco_context_t *dco)
 {
     int ret;
     struct nl_sock *nl_sock =3D nl_socket_alloc();
@@ -96,39 +92,14 @@
     }
     set_cloexec(nl_socket_get_fd(nl_sock));

-    ret =3D genl_ctrl_resolve(nl_sock, OVPN_NL_NAME);
-    if (ret < 0)
-    {
-        msg(msglevel, "Cannot find ovpn_dco netlink component: %s",
-            nl_geterror(ret));
-    }
+    ret =3D do_family_name_resolve(nl_sock, msglevel, OVPN_NL_NAME, dco, &=
dco_ops_v2);

 err_sock:
     nl_socket_free(nl_sock);
     return ret;
 }

-static struct nl_msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco, enum ovpn_nl_commands cmd)
-{
-    struct nl_msg *nl_msg =3D nlmsg_alloc();
-    if (!nl_msg)
-    {
-        msg(M_ERR, "cannot allocate netlink message");
-        return NULL;
-    }
-
-    genlmsg_put(nl_msg, 0, 0, dco->ovpn_dco_id, 0, 0, cmd, 0);
-    NLA_PUT_U32(nl_msg, OVPN_ATTR_IFINDEX, dco->ifindex);
-
-    return nl_msg;
-nla_put_failure:
-    nlmsg_free(nl_msg);
-    msg(M_INFO, "cannot put into netlink message");
-    return NULL;
-}
-
-static int
+int
 ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
 {
     int ret =3D nl_recvmsgs(dco->nl_sock, dco->nl_cb);
@@ -166,18 +137,7 @@
     return ret;
 }

-/**
- * Send a prepared netlink message and registers cb as callback if non-nul=
l.
- *
- * The method will also free nl_msg
- * @param dco       The dco context to use
- * @param nl_msg    the message to use
- * @param cb        An optional callback if the caller expects an answer
- * @param cb_arg    An optional param to pass to the callback
- * @param prefix    A prefix to report in the error message to give the us=
er context
- * @return          status of sending the message
- */
-static int
+int
 ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb cb,
                  void *cb_arg, const char *prefix)
 {
@@ -218,71 +178,6 @@
 }

 int
-dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
-             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
-             struct in_addr *remote_in4, struct in6_addr *remote_in6)
-{
-    struct gc_arena gc =3D gc_new();
-    const char *remotestr =3D "[undefined]";
-    if (remoteaddr)
-    {
-        remotestr =3D print_sockaddr(remoteaddr, &gc);
-    }
-    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d, remote addr: %s", __func__,
-        peerid, sd, remotestr);
-
-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_NEW_PEER=
);
-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_NEW_PEER);
-    int ret =3D -EMSGSIZE;
-
-    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_PEER_ID, peerid);
-    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_SOCKET, sd);
-
-    /* Set the remote endpoint if defined (for UDP) */
-    if (remoteaddr)
-    {
-        remoteaddr =3D mapped_v4_to_v6(remoteaddr, &gc);
-        int alen =3D af_addr_size(remoteaddr->sa_family);
-
-        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE, alen, remotead=
dr);
-    }
-
-    if (localaddr)
-    {
-        localaddr =3D mapped_v4_to_v6(localaddr, &gc);
-        if (localaddr->sa_family =3D=3D AF_INET)
-        {
-            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in_=
addr),
-                    &((struct sockaddr_in *)localaddr)->sin_addr);
-        }
-        else if (localaddr->sa_family =3D=3D AF_INET6)
-        {
-            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in6=
_addr),
-                    &((struct sockaddr_in6 *)localaddr)->sin6_addr);
-        }
-    }
-
-    /* Set the primary VPN IP addresses of the peer */
-    if (remote_in4)
-    {
-        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, remote_in4->s_addr);
-    }
-    if (remote_in6)
-    {
-        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr),
-                remote_in6);
-    }
-    nla_nest_end(nl_msg, attr);
-
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
-
-nla_put_failure:
-    nlmsg_free(nl_msg);
-    gc_free(&gc);
-    return ret;
-}
-
-static int
 ovpn_nl_cb_finish(struct nl_msg (*msg) __attribute__ ((unused)), void *arg)
 {
     int *status =3D arg;
@@ -291,15 +186,7 @@
     return NL_SKIP;
 }

-/* This function is used as error callback on the netlink socket.
- * When something goes wrong and the kernel returns an error, this functio=
n is
- * invoked.
- *
- * We pass the error code to the user by means of a variable pointed by *a=
rg
- * (supplied by the user when setting this callback) and we parse the kern=
el
- * reply to see if it contains a human-readable error. If found, it is pri=
nted.
- */
-static int
+int
 ovpn_nl_cb_error(struct sockaddr_nl (*nla) __attribute__ ((unused)),
                  struct nlmsgerr *err, void *arg)
 {
@@ -342,10 +229,16 @@
     return NL_STOP;
 }

-static void
+void
 ovpn_dco_init_netlink(dco_context_t *dco)
 {
-    dco->ovpn_dco_id =3D resolve_ovpn_netlink_id(M_ERR);
+    struct gc_arena gc =3D gc_new();
+    if (!dco->ops)
+    {
+        ALLOC_OBJ_CLEAR_GC(dco->ops, struct dco_ops, &gc);
+    }
+
+    dco->ovpn_dco_id =3D resolve_ovpn_netlink_id(M_ERR, dco);

     dco->nl_sock =3D nl_socket_alloc();

@@ -388,6 +281,7 @@
      * overrun with very fast connecting/disconnecting clients.
      * TODO: fix this in a better and more reliable way */
     ASSERT(!nl_socket_set_buffer_size(dco->nl_sock, 1024*1024, 1024*1024));
+    gc_free(&gc);
 }

 bool
@@ -411,7 +305,7 @@
     return true;
 }

-static void
+void
 ovpn_dco_uninit_netlink(dco_context_t *dco)
 {
     nl_socket_free(dco->nl_sock);
@@ -423,7 +317,7 @@
     CLEAR(dco);
 }

-static void
+void
 ovpn_dco_register(dco_context_t *dco)
 {
     msg(D_DCO_DEBUG, __func__);
@@ -447,205 +341,11 @@
 int
 open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
 {
-    msg(D_DCO_DEBUG, "%s: %s", __func__, dev);
-    ASSERT(tt->type =3D=3D DEV_TYPE_TUN);
-
-    int ret =3D net_iface_new(ctx, dev, "ovpn-dco", &tt->dco);
-    if (ret < 0)
-    {
-        msg(D_DCO_DEBUG, "Cannot create DCO interface %s: %d", dev, ret);
-        return ret;
-    }
-
-    tt->dco.ifindex =3D if_nametoindex(dev);
-    if (!tt->dco.ifindex)
-    {
-        msg(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev);
-    }
-
-    tt->dco.dco_message_peer_id =3D -1;
-
-    ovpn_dco_register(&tt->dco);
-
-    return 0;
-}
-
-void
-close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx)
-{
-    msg(D_DCO_DEBUG, __func__);
-
-    net_iface_del(ctx, tt->actual_name);
-    ovpn_dco_uninit_netlink(&tt->dco);
-}
-
-int
-dco_swap_keys(dco_context_t *dco, unsigned int peerid)
-{
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
-
-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_SWAP_KEY=
S);
-    if (!nl_msg)
-    {
-        return -ENOMEM;
-    }
-
-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_SWAP_KEYS);
-    int ret =3D -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR_PEER_ID, peerid);
-    nla_nest_end(nl_msg, attr);
-
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
-
-nla_put_failure:
-    nlmsg_free(nl_msg);
-    return ret;
-}
-
-
-int
-dco_del_peer(dco_context_t *dco, unsigned int peerid)
-{
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
-
-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_DEL_PEER=
);
-    if (!nl_msg)
-    {
-        return -ENOMEM;
-    }
-
-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_DEL_PEER);
-    int ret =3D -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_DEL_PEER_ATTR_PEER_ID, peerid);
-    nla_nest_end(nl_msg, attr);
-
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
-
-nla_put_failure:
-    nlmsg_free(nl_msg);
-    return ret;
-}
-
-
-int
-dco_del_key(dco_context_t *dco, unsigned int peerid,
-            dco_key_slot_t slot)
-{
-    msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, peerid, slot);
-
-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_DEL_KEY);
-    if (!nl_msg)
-    {
-        return -ENOMEM;
-    }
-
-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_DEL_KEY);
-    int ret =3D -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_DEL_KEY_ATTR_PEER_ID, peerid);
-    NLA_PUT_U8(nl_msg, OVPN_DEL_KEY_ATTR_KEY_SLOT, slot);
-    nla_nest_end(nl_msg, attr);
-
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
-
-nla_put_failure:
-    nlmsg_free(nl_msg);
+    int ret =3D tt->dco.ops->open_tun_dco(tt, ctx, dev);
     return ret;
 }

 int
-dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
-            dco_key_slot_t slot,
-            const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
-            const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
-            const char *ciphername)
-{
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
-        __func__, slot, keyid, peerid, ciphername);
-
-    const size_t key_len =3D cipher_kt_key_size(ciphername);
-    const int nonce_tail_len =3D 8;
-
-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_NEW_KEY);
-    if (!nl_msg)
-    {
-        return -ENOMEM;
-    }
-
-    dco_cipher_t dco_cipher =3D dco_get_cipher(ciphername);
-
-    int ret =3D -EMSGSIZE;
-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_NEW_KEY);
-    NLA_PUT_U32(nl_msg, OVPN_NEW_KEY_ATTR_PEER_ID, peerid);
-    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_SLOT, slot);
-    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_ID, keyid);
-    NLA_PUT_U16(nl_msg, OVPN_NEW_KEY_ATTR_CIPHER_ALG, dco_cipher);
-
-    struct nlattr *key_enc =3D nla_nest_start(nl_msg,
-                                            OVPN_NEW_KEY_ATTR_ENCRYPT_KEY);
-    if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)
-    {
-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, encrypt_key=
);
-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,
-                encrypt_iv);
-    }
-    nla_nest_end(nl_msg, key_enc);
-
-    struct nlattr *key_dec =3D nla_nest_start(nl_msg,
-                                            OVPN_NEW_KEY_ATTR_DECRYPT_KEY);
-    if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)
-    {
-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, decrypt_key=
);
-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,
-                decrypt_iv);
-    }
-    nla_nest_end(nl_msg, key_dec);
-
-    nla_nest_end(nl_msg, attr);
-
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
-
-nla_put_failure:
-    nlmsg_free(nl_msg);
-    return ret;
-}
-
-int
-dco_set_peer(dco_context_t *dco, unsigned int peerid,
-             int keepalive_interval, int keepalive_timeout, int mss)
-{
-    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__,
-        peerid, keepalive_interval, keepalive_timeout, mss);
-
-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_SET_PEER=
);
-    if (!nl_msg)
-    {
-        return -ENOMEM;
-    }
-
-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_SET_PEER);
-    int ret =3D -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_PEER_ID, peerid);
-    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,
-                keepalive_interval);
-    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,
-                keepalive_timeout);
-    nla_nest_end(nl_msg, attr);
-
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
-
-nla_put_failure:
-    nlmsg_free(nl_msg);
-    return ret;
-}
-
-/* This function parses the reply provided by the kernel to the CTRL_CMD_G=
ETFAMILY
- * message. We parse the reply and we retrieve the multicast group ID asso=
ciated
- * with the "ovpn-dco" netlink family.
- *
- * The ID is later used to subscribe to the multicast group and be notified
- * about any multicast message sent by the ovpn-dco kernel module.
- */
-static int
 mcast_family_handler(struct nl_msg *msg, void *arg)
 {
     dco_context_t *dco =3D arg;
@@ -687,12 +387,8 @@

     return NL_SKIP;
 }
-/**
- * Lookup the multicast id for OpenVPN. This method and its help method cu=
rrently
- * hardcode the lookup to OVPN_NL_NAME and OVPN_NL_MULTICAST_GROUP_PEERS b=
ut
- * extended in the future if we need to lookup more than one mcast id.
- */
-static int
+
+int
 ovpn_get_mcast_id(dco_context_t *dco)
 {
     dco->ovpn_dco_mcast_id =3D -ENOENT;
@@ -719,299 +415,15 @@
     return ret;
 }

-/* This function parses any netlink message sent by ovpn-dco to userspace =
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
-int
-dco_do_read(dco_context_t *dco)
-{
-    msg(D_DCO_DEBUG, __func__);
-    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
-
-    return ovpn_nl_recvmsgs(dco, __func__);
-}
-
-static void
-dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t i=
d)
-{
-    if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES])
-    {
-        c2->dco_read_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_LINK=
_RX_BYTES]);
-        msg(D_DCO_DEBUG, "%s / dco_read_bytes: " counter_format, __func__,
-            c2->dco_read_bytes);
-    }
-    else
-    {
-        msg(M_WARN, "%s: no link RX bytes provided in reply for peer %u",
-            __func__, id);
-    }
-
-    if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES])
-    {
-        c2->dco_write_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_LIN=
K_TX_BYTES]);
-        msg(D_DCO_DEBUG, "%s / dco_write_bytes: " counter_format, __func__,
-            c2->dco_write_bytes);
-    }
-    else
-    {
-        msg(M_WARN, "%s: no link TX bytes provided in reply for peer %u",
-            __func__, id);
-    }
-
-    if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES])
-    {
-        c2->tun_read_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN_=
RX_BYTES]);
-        msg(D_DCO_DEBUG, "%s / tun_read_bytes: " counter_format, __func__,
-            c2->tun_read_bytes);
-    }
-    else
-    {
-        msg(M_WARN, "%s: no VPN RX bytes provided in reply for peer %u",
-            __func__, id);
-    }
-
-    if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES])
-    {
-        c2->tun_write_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN=
_TX_BYTES]);
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
-    struct multi_context *m =3D arg;
-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_=
ID]);
-
-    if (peer_id >=3D m->max_clients || !m->instances[peer_id])
-    {
-        msg(M_WARN, "%s: cannot store DCO stats for peer %u", __func__,
-            peer_id);
-        return NL_SKIP;
-    }
-
-    dco_update_peer_stat(&m->instances[peer_id]->context.c2, tb_peer, peer=
_id);
-
-    return NL_OK;
-}
-
-int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
-{
-    msg(D_DCO_DEBUG, "%s", __func__);
-
-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER=
);
-
-    nlmsg_hdr(nl_msg)->nlmsg_flags |=3D NLM_F_DUMP;
-
-    int ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __f=
unc__);
-
-    nlmsg_free(nl_msg);
-    return ret;
-}
-
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
-int
-dco_get_peer_stats(struct context *c)
-{
-    uint32_t peer_id =3D c->c2.tls_multi->dco_peer_id;
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
-
-    if (!c->c1.tuntap)
-    {
-        return 0;
-    }
-
-    dco_context_t *dco =3D &c->c1.tuntap->dco;
-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER=
);
-    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_GET_PEER);
-    int ret =3D -EMSGSIZE;
-
-    NLA_PUT_U32(nl_msg, OVPN_GET_PEER_ATTR_PEER_ID, peer_id);
-    nla_nest_end(nl_msg, attr);
-
-    ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer, c, __func__);
-
-nla_put_failure:
-    nlmsg_free(nl_msg);
-    return ret;
-}
-
 bool
-dco_available(int msglevel)
+dco_available(int msglevel, dco_context_t *dco)
 {
-    if (resolve_ovpn_netlink_id(D_DCO_DEBUG) < 0)
+    if (resolve_ovpn_netlink_id(D_DCO_DEBUG, dco) < 0)
     {
         msg(msglevel,
             "Note: Kernel support for ovpn-dco missing, disabling data cha=
nnel offload.");
         return false;
     }
-
     return true;
 }

@@ -1043,6 +455,94 @@
     return BSTR(&out);
 }

+int
+dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
+             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+{
+    int ret =3D dco->ops->dco_new_peer(dco, peerid, sd, localaddr, remotea=
ddr, remote_in4, remote_in6);
+    return ret;
+}
+
+void
+close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+{
+    tt->dco.ops->close_tun_dco(tt, ctx);
+}
+
+int
+dco_swap_keys(dco_context_t *dco, unsigned int peerid)
+{
+    int ret =3D dco->ops->dco_swap_keys(dco, peerid);
+    return ret;
+}
+
+
+int
+dco_del_peer(dco_context_t *dco, unsigned int peerid)
+{
+    int ret =3D dco->ops->dco_del_peer(dco, peerid);
+    return ret;
+}
+
+
+int
+dco_del_key(dco_context_t *dco, unsigned int peerid,
+            dco_key_slot_t slot)
+{
+    int ret =3D dco->ops->dco_del_key(dco, peerid, slot);
+    return ret;
+}
+
+int
+dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
+            dco_key_slot_t slot,
+            const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
+            const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
+            const char *ciphername)
+{
+    int ret =3D dco->ops->dco_new_key(dco, peerid, keyid, slot, encrypt_ke=
y, encrypt_iv, decrypt_key, decrypt_iv, ciphername);
+    return ret;
+}
+
+int
+dco_set_peer(dco_context_t *dco, unsigned int peerid,
+             int keepalive_interval, int keepalive_timeout, int mss)
+{
+    int ret =3D dco->ops->dco_set_peer(dco, peerid, keepalive_interval, ke=
epalive_timeout, mss);
+    return ret;
+}
+
+int
+dco_do_read(dco_context_t *dco)
+{
+    int ret =3D dco->ops->dco_do_read(dco);
+    return ret;
+}
+
+int
+dco_parse_peer_multi(struct nl_msg *msg, void *arg)
+{
+    struct multi_context *m =3D arg;
+    int ret =3D m->top.c1.tuntap->dco.ops->dco_parse_peer_multi(msg, arg);
+
+    return ret;
+}
+
+int
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
+{
+    int ret =3D dco->ops->dco_get_peer_stats_multi(dco, m);
+    return ret;
+}
+
+int
+dco_get_peer_stats(struct context *c)
+{
+    int ret =3D c->c1.tuntap->dco.ops->dco_get_peer_stats(c);
+    return ret;
+}
+
 void
 dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 {
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 511519a..a3cf528 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -31,9 +31,30 @@
 #include <netlink/socket.h>
 #include <netlink/netlink.h>

+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+
+#include "networking.h"
+#include "fdmisc.h"
+
+/* forward declarations (including other headers leads to nasty include
+ * order problems)
+ */
+struct multi_context;
+struct context_2;
+struct key_ctx_bi;
+
 typedef enum ovpn_key_slot dco_key_slot_t;
 typedef enum ovpn_cipher_alg dco_cipher_t;

+/* libnl < 3.5.0 does not set the NLA_F_NESTED on its own, therefore we
+ * have to explicitly do it to prevent the kernel from failing upon
+ * parsing of the message
+ */
+#define nla_nest_start(_msg, _type) \
+    nla_nest_start(_msg, (_type) | NLA_F_NESTED)
+

 typedef struct
 {
@@ -53,7 +74,114 @@
     int dco_del_peer_reason;
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
+
+    const struct dco_ops *ops;
 } dco_context_t;

+struct dco_ops
+{
+    struct nl_msg *(*ovpn_dco_nlmsg_create)(dco_context_t *dco, int cmd);
+    int (*dco_new_peer)(dco_context_t *dco, unsigned int peerid, int sd, s=
truct sockaddr *localaddr, struct sockaddr *remoteaddr, struct in_addr *rem=
ote_in4, struct in6_addr *remote_in6);
+    int (*open_tun_dco)(struct tuntap *tt, openvpn_net_ctx_t *ctx, const c=
har *dev);
+    void (*close_tun_dco)(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+    int (*dco_swap_keys)(dco_context_t *dco, unsigned int peerid);
+    int (*dco_del_peer)(dco_context_t *dco, unsigned int peerid);
+    int (*dco_del_key)(dco_context_t *dco, unsigned int peerid, dco_key_sl=
ot_t slot);
+    int (*dco_new_key)(dco_context_t *dco, unsigned int peerid, int keyid,=
 dco_key_slot_t slot, const uint8_t *encrypt_key, const uint8_t *encrypt_iv=
, const uint8_t *decrypt_key, const uint8_t *decrypt_iv, const char *cipher=
name);
+    int (*dco_set_peer)(dco_context_t *dco, unsigned int peerid, int keepa=
live_interval, int keepalive_timeout, int mss);
+    int (*ovpn_handle_msg)(struct nl_msg *msg, void *arg);
+    int (*dco_do_read)(dco_context_t *dco);
+    void (*dco_update_peer_stat)(struct context_2 *c2, struct nlattr *tb[]=
, uint32_t id);
+    int (*dco_parse_peer_multi)(struct nl_msg *msg, void *arg);
+    int (*dco_get_peer_stats_multi)(dco_context_t *dco, struct multi_conte=
xt *m);
+    int (*dco_parse_peer)(struct nl_msg *msg, void *arg);
+    int (*dco_get_peer_stats)(struct context *c);
+};
+
+extern const struct dco_ops dco_ops_v2;
+
+int ovpn_get_mcast_id(dco_context_t *dco);
+
+void dco_check_key_ctx(const struct key_ctx_bi *key);
+
+typedef int (*ovpn_nl_cb)(struct nl_msg *msg, void *arg);
+
+/**
+ * @brief resolves the netlink ID for ovpn-dco
+ *
+ * This function queries the kernel via a netlink socket
+ * whether the ovpn-dco netlink namespace is available
+ *
+ * This function can be used to determine if the kernel
+ * supports DCO offloading.
+ *
+ * @return ID on success, negative error code on error
+ */
+int resolve_ovpn_netlink_id(int msglevel, dco_context_t *dco);
+
+int ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix);
+
+/**
+ * Send a prepared netlink message and registers cb as callback if non-nul=
l.
+ *
+ * The method will also free nl_msg
+ * @param dco       The dco context to use
+ * @param nl_msg    the message to use
+ * @param cb        An optional callback if the caller expects an answer
+ * @param cb_arg    An optional param to pass to the callback
+ * @param prefix    A prefix to report in the error message to give the us=
er context
+ * @return          status of sending the message
+ */
+int ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb=
 cb,
+                     void *cb_arg, const char *prefix);
+
+struct sockaddr *
+mapped_v4_to_v6(struct sockaddr *sock, struct gc_arena *gc);
+
+int ovpn_nl_cb_finish(struct nl_msg (*msg) __attribute__ ((unused)), void =
*arg);
+
+/* This function is used as error callback on the netlink socket.
+ * When something goes wrong and the kernel returns an error, this functio=
n is
+ * invoked.
+ *
+ * We pass the error code to the user by means of a variable pointed by *a=
rg
+ * (supplied by the user when setting this callback) and we parse the kern=
el
+ * reply to see if it contains a human-readable error. If found, it is pri=
nted.
+ */
+int ovpn_nl_cb_error(struct sockaddr_nl (*nla) __attribute__ ((unused)),
+                     struct nlmsgerr *err, void *arg);
+
+void ovpn_dco_init_netlink(dco_context_t *dco);
+
+bool ovpn_dco_init(int mode, dco_context_t *dco);
+
+void ovpn_dco_uninit_netlink(dco_context_t *dco);
+
+void ovpn_dco_register(dco_context_t *dco);
+
+/* This function parses the reply provided by the kernel to the CTRL_CMD_G=
ETFAMILY
+ * message. We parse the reply and we retrieve the multicast group ID asso=
ciated
+ * with the "ovpn-dco" netlink family.
+ *
+ * The ID is later used to subscribe to the multicast group and be notified
+ * about any multicast message sent by the ovpn-dco kernel module.
+ */
+int mcast_family_handler(struct nl_msg *msg, void *arg);
+
+/**
+ * Lookup the multicast id for OpenVPN. This method and its help method cu=
rrently
+ * hardcode the lookup to OVPN_NL_NAME and OVPN_NL_MULTICAST_GROUP_PEERS b=
ut
+ * extended in the future if we need to lookup more than one mcast id.
+ */
+int ovpn_get_mcast_id(dco_context_t *dco);
+
+bool dco_available(int msglevel, dco_context_t *dco);
+
+const char *dco_version_string(struct gc_arena *gc);
+
+void dco_event_set(dco_context_t *dco, struct event_set *es, void *arg);
+
+const char *dco_get_supported_ciphers();
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
 #endif /* ifndef DCO_LINUX_H */
diff --git a/src/openvpn/dco_linux_v2.c b/src/openvpn/dco_linux_v2.c
new file mode 100644
index 0000000..6fc47fa
--- /dev/null
+++ b/src/openvpn/dco_linux_v2.c
@@ -0,0 +1,636 @@
+/*
+ *  Interface to linux dco networking code
+ *
+ *  Copyright (C) 2020-2024 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020-2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2024 Gianmarco De Gregori <gianmarco@...2726...>
+ *  Copyright (C) 2020-2024 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+
+#include "syshead.h"
+
+#include "dco_linux.h"
+#include "errlevel.h"
+#include "buffer.h"
+#include "networking.h"
+#include "openvpn.h"
+
+#include "socket.h"
+#include "tun.h"
+#include "ssl.h"
+#include "fdmisc.h"
+#include "multi.h"
+#include "ssl_verify.h"
+
+#include "ovpn_dco_linux.h"
+
+#include <netlink/socket.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+
+int
+open_tun_dco_v2(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
+{
+    msg(D_DCO_DEBUG, "%s: %s", __func__, dev);
+    ASSERT(tt->type =3D=3D DEV_TYPE_TUN);
+
+    int ret =3D net_iface_new(ctx, dev, "ovpn-dco", &tt->dco);
+    if (ret < 0)
+    {
+        msg(D_DCO_DEBUG, "Cannot create DCO interface %s: %d", dev, ret);
+        return ret;
+    }
+
+    tt->dco.ifindex =3D if_nametoindex(dev);
+    if (!tt->dco.ifindex)
+    {
+        msg(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev);
+    }
+
+    tt->dco.dco_message_peer_id =3D -1;
+
+    ovpn_dco_register(&tt->dco);
+
+    return 0;
+}
+
+static struct nl_msg *
+ovpn_dco_v2_nlmsg_create(dco_context_t *dco, int cmd)
+{
+    enum ovpn_nl_commands enum_cmd =3D (enum ovpn_nl_commands)cmd;
+    struct nl_msg *nl_msg =3D nlmsg_alloc();
+    if (!nl_msg)
+    {
+        msg(M_ERR, "cannot allocate netlink message");
+        return NULL;
+    }
+
+    genlmsg_put(nl_msg, 0, 0, dco->ovpn_dco_id, 0, 0, enum_cmd, 0);
+    NLA_PUT_U32(nl_msg, OVPN_ATTR_IFINDEX, dco->ifindex);
+
+    return nl_msg;
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    msg(M_INFO, "cannot put into netlink message");
+    return NULL;
+}
+
+int
+dco_v2_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
+                struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+                struct in_addr *remote_in4, struct in6_addr *remote_in6)
+{
+    struct gc_arena gc =3D gc_new();
+    const char *remotestr =3D "[undefined]";
+    if (remoteaddr)
+    {
+        remotestr =3D print_sockaddr(remoteaddr, &gc);
+    }
+    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d, remote addr: %s", __func__,
+        peerid, sd, remotestr);
+
+    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_NEW_P=
EER);
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_NEW_PEER);
+    int ret =3D -EMSGSIZE;
+
+    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_SOCKET, sd);
+
+    /* Set the remote endpoint if defined (for UDP) */
+    if (remoteaddr)
+    {
+        remoteaddr =3D mapped_v4_to_v6(remoteaddr, &gc);
+        int alen =3D af_addr_size(remoteaddr->sa_family);
+
+        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE, alen, remotead=
dr);
+    }
+
+    if (localaddr)
+    {
+        localaddr =3D mapped_v4_to_v6(localaddr, &gc);
+        if (localaddr->sa_family =3D=3D AF_INET)
+        {
+            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in_=
addr),
+                    &((struct sockaddr_in *)localaddr)->sin_addr);
+        }
+        else if (localaddr->sa_family =3D=3D AF_INET6)
+        {
+            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in6=
_addr),
+                    &((struct sockaddr_in6 *)localaddr)->sin6_addr);
+        }
+    }
+
+    /* Set the primary VPN IP addresses of the peer */
+    if (remote_in4)
+    {
+        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, remote_in4->s_addr);
+    }
+    if (remote_in6)
+    {
+        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr),
+                remote_in6);
+    }
+    nla_nest_end(nl_msg, attr);
+
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    gc_free(&gc);
+    return ret;
+}
+
+void
+close_tun_dco_v2(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+{
+    msg(D_DCO_DEBUG, __func__);
+
+    net_iface_del(ctx, tt->actual_name);
+    ovpn_dco_uninit_netlink(&tt->dco);
+}
+
+int
+dco_v2_swap_keys(dco_context_t *dco, unsigned int peerid)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+
+    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_SWAP_=
KEYS);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_SWAP_KEYS);
+    int ret =3D -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR_PEER_ID, peerid);
+    nla_nest_end(nl_msg, attr);
+
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+
+int
+dco_v2_del_peer(dco_context_t *dco, unsigned int peerid)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+
+    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_DEL_P=
EER);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_DEL_PEER);
+    int ret =3D -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_DEL_PEER_ATTR_PEER_ID, peerid);
+    nla_nest_end(nl_msg, attr);
+
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+
+int
+dco_v2_del_key(dco_context_t *dco, unsigned int peerid,
+               dco_key_slot_t slot)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, peerid, slot);
+
+    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_DEL_K=
EY);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_DEL_KEY);
+    int ret =3D -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_DEL_KEY_ATTR_PEER_ID, peerid);
+    NLA_PUT_U8(nl_msg, OVPN_DEL_KEY_ATTR_KEY_SLOT, slot);
+    nla_nest_end(nl_msg, attr);
+
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+int
+dco_v2_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
+               dco_key_slot_t slot,
+               const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
+               const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
+               const char *ciphername)
+{
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
+        __func__, slot, keyid, peerid, ciphername);
+
+    const size_t key_len =3D cipher_kt_key_size(ciphername);
+    const int nonce_tail_len =3D 8;
+
+    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_NEW_K=
EY);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    dco_cipher_t dco_cipher =3D dco_get_cipher(ciphername);
+
+    int ret =3D -EMSGSIZE;
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_NEW_KEY);
+    NLA_PUT_U32(nl_msg, OVPN_NEW_KEY_ATTR_PEER_ID, peerid);
+    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_SLOT, slot);
+    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_ID, keyid);
+    NLA_PUT_U16(nl_msg, OVPN_NEW_KEY_ATTR_CIPHER_ALG, dco_cipher);
+
+    struct nlattr *key_enc =3D nla_nest_start(nl_msg,
+                                            OVPN_NEW_KEY_ATTR_ENCRYPT_KEY);
+    if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)
+    {
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, encrypt_key=
);
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,
+                encrypt_iv);
+    }
+    nla_nest_end(nl_msg, key_enc);
+
+    struct nlattr *key_dec =3D nla_nest_start(nl_msg,
+                                            OVPN_NEW_KEY_ATTR_DECRYPT_KEY);
+    if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)
+    {
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, decrypt_key=
);
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,
+                decrypt_iv);
+    }
+    nla_nest_end(nl_msg, key_dec);
+
+    nla_nest_end(nl_msg, attr);
+
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+int
+dco_v2_set_peer(dco_context_t *dco, unsigned int peerid,
+                int keepalive_interval, int keepalive_timeout, int mss)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__,
+        peerid, keepalive_interval, keepalive_timeout, mss);
+
+    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_SET_P=
EER);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_SET_PEER);
+    int ret =3D -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,
+                keepalive_interval);
+    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,
+                keepalive_timeout);
+    nla_nest_end(nl_msg, attr);
+
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+/* This function parses any netlink message sent by ovpn-dco to userspace =
*/
+static int
+ovpn_v2_handle_msg(struct nl_msg *msg, void *arg)
+{
+    dco_context_t *dco =3D arg;
+
+    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
+    struct nlattr *attrs[OVPN_ATTR_MAX + 1];
+    struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
+
+    if (!genlmsg_valid_hdr(nlh, 0))
+    {
+        msg(D_DCO, "ovpn-dco: invalid header");
+        return NL_SKIP;
+    }
+
+    if (nla_parse(attrs, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+                  genlmsg_attrlen(gnlh, 0), NULL))
+    {
+        msg(D_DCO, "received bogus data from ovpn-dco");
+        return NL_SKIP;
+    }
+
+    /* we must know which interface this message is referring to in order =
to
+     * avoid mixing messages for other instances
+     */
+    if (!attrs[OVPN_ATTR_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return NL_SKIP;
+    }
+
+    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
+    if (ifindex !=3D dco->ifindex)
+    {
+        msg(D_DCO_DEBUG,
+            "ovpn-dco: ignoring message (type=3D%d) for foreign ifindex %d=
",
+            gnlh->cmd, ifindex);
+        return NL_SKIP;
+    }
+
+    /* based on the message type, we parse the subobject contained in the
+     * message, that stores the type-specific attributes.
+     *
+     * the "dco" object is then filled accordingly with the information
+     * retrieved from the message, so that the rest of the OpenVPN code can
+     * react as need be.
+     */
+    switch (gnlh->cmd)
+    {
+        case OVPN_CMD_DEL_PEER:
+        {
+            if (!attrs[OVPN_ATTR_DEL_PEER])
+            {
+                msg(D_DCO, "ovpn-dco: no attributes in OVPN_DEL_PEER messa=
ge");
+                return NL_SKIP;
+            }
+
+            struct nlattr *dp_attrs[OVPN_DEL_PEER_ATTR_MAX + 1];
+            if (nla_parse_nested(dp_attrs, OVPN_DEL_PEER_ATTR_MAX,
+                                 attrs[OVPN_ATTR_DEL_PEER], NULL))
+            {
+                msg(D_DCO, "received bogus del peer packet data from ovpn-=
dco");
+                return NL_SKIP;
+            }
+
+            if (!dp_attrs[OVPN_DEL_PEER_ATTR_REASON])
+            {
+                msg(D_DCO, "ovpn-dco: no reason in DEL_PEER message");
+                return NL_SKIP;
+            }
+            if (!dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])
+            {
+                msg(D_DCO, "ovpn-dco: no peer-id in DEL_PEER message");
+                return NL_SKIP;
+            }
+            int reason =3D nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_REASON]);
+            unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATT=
R_PEER_ID]);
+
+            msg(D_DCO_DEBUG, "ovpn-dco: received CMD_DEL_PEER, ifindex: %d=
, peer-id %d, reason: %d",
+                ifindex, peerid, reason);
+            dco->dco_message_peer_id =3D peerid;
+            dco->dco_del_peer_reason =3D reason;
+            dco->dco_message_type =3D OVPN_CMD_DEL_PEER;
+
+            break;
+        }
+
+        default:
+            msg(D_DCO, "ovpn-dco: received unknown command: %d", gnlh->cmd=
);
+            dco->dco_message_type =3D 0;
+            return NL_SKIP;
+    }
+
+    return NL_OK;
+}
+
+static int
+dco_v2_do_read(dco_context_t *dco)
+{
+    msg(D_DCO_DEBUG, __func__);
+    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_v2_handle_msg, d=
co);
+
+    return ovpn_nl_recvmsgs(dco, __func__);
+}
+
+static void
+dco_v2_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_=
t id)
+{
+    if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES])
+    {
+        c2->dco_read_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_LINK=
_RX_BYTES]);
+        msg(D_DCO_DEBUG, "%s / dco_read_bytes: " counter_format, __func__,
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
+        c2->dco_write_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_LIN=
K_TX_BYTES]);
+        msg(D_DCO_DEBUG, "%s / dco_write_bytes: " counter_format, __func__,
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
+        c2->tun_read_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN_=
RX_BYTES]);
+        msg(D_DCO_DEBUG, "%s / tun_read_bytes: " counter_format, __func__,
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
+        c2->tun_write_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN=
_TX_BYTES]);
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
+int
+dco_v2_parse_peer_multi(struct nl_msg *msg, void *arg)
+{
+    struct nlattr *tb[OVPN_ATTR_MAX + 1];
+    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
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
+    struct multi_context *m =3D arg;
+    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_=
ID]);
+
+    if (peer_id >=3D m->max_clients || !m->instances[peer_id])
+    {
+        msg(M_WARN, "%s: cannot store DCO stats for peer %u", __func__,
+            peer_id);
+        return NL_SKIP;
+    }
+
+    dco_v2_update_peer_stat(&m->instances[peer_id]->context.c2, tb_peer, p=
eer_id);
+
+    return NL_OK;
+}
+
+int
+dco_v2_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
+{
+    msg(D_DCO_DEBUG, "%s", __func__);
+
+    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_GET_P=
EER);
+
+    nlmsg_hdr(nl_msg)->nlmsg_flags |=3D NLM_F_DUMP;
+
+    int ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_v2_parse_peer_multi, m, =
__func__);
+
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+static int
+dco_v2_parse_peer(struct nl_msg *msg, void *arg)
+{
+    struct context *c =3D arg;
+    struct nlattr *tb[OVPN_ATTR_MAX + 1];
+    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
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
+    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_=
ID]);
+    if (c->c2.tls_multi->dco_peer_id !=3D peer_id)
+    {
+        return NL_SKIP;
+    }
+
+    dco_v2_update_peer_stat(&c->c2, tb_peer, peer_id);
+
+    return NL_OK;
+}
+
+int
+dco_v2_get_peer_stats(struct context *c)
+{
+    uint32_t peer_id =3D c->c2.tls_multi->dco_peer_id;
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
+
+    if (!c->c1.tuntap)
+    {
+        return 0;
+    }
+
+    dco_context_t *dco =3D &c->c1.tuntap->dco;
+    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_GET_P=
EER);
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_GET_PEER);
+    int ret =3D -EMSGSIZE;
+
+    NLA_PUT_U32(nl_msg, OVPN_GET_PEER_ATTR_PEER_ID, peer_id);
+    nla_nest_end(nl_msg, attr);
+
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, dco_v2_parse_peer, c, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+const struct dco_ops dco_ops_v2 =3D {
+    .ovpn_dco_nlmsg_create =3D ovpn_dco_v2_nlmsg_create,
+    .dco_new_peer =3D &dco_v2_new_peer,
+    .open_tun_dco =3D open_tun_dco_v2,
+    .close_tun_dco =3D close_tun_dco_v2,
+    .dco_swap_keys =3D &dco_v2_swap_keys,
+    .dco_del_peer =3D &dco_v2_del_peer,
+    .dco_del_key =3D &dco_v2_del_key,
+    .dco_new_key =3D &dco_v2_new_key,
+    .dco_set_peer =3D &dco_v2_set_peer,
+    .ovpn_handle_msg =3D &ovpn_v2_handle_msg,
+    .dco_do_read =3D &dco_v2_do_read,
+    .dco_update_peer_stat =3D &dco_v2_update_peer_stat,
+    .dco_parse_peer_multi =3D &dco_v2_parse_peer_multi,
+    .dco_get_peer_stats_multi =3D &dco_v2_get_peer_stats_multi,
+    .dco_parse_peer =3D &dco_v2_parse_peer,
+    .dco_get_peer_stats =3D &dco_v2_get_peer_stats
+};
+
+#endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index e3ada76..65be766 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -357,7 +357,7 @@
 }

 bool
-dco_available(int msglevel)
+dco_available(int msglevel, dco_context_t *dco)
 {
     /* try to open device by symbolic name */
     HANDLE h =3D CreateFile("\\\\.\\ovpn-dco", GENERIC_READ | GENERIC_WRIT=
E,
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 01165b2..118c32a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1230,6 +1230,9 @@
 process_incoming_dco(struct context *c)
 {
 #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
+    int cmd_del_peer =3D OVPN_CMD_DEL_PEER;
+    int cmd_swap_keys =3D OVPN_CMD_SWAP_KEYS;
+
     dco_context_t *dco =3D &c->c1.tuntap->dco;

     dco_do_read(dco);
@@ -1245,31 +1248,30 @@
         return;
     }

-    switch (dco->dco_message_type)
+    if (dco->dco_message_type =3D=3D cmd_del_peer)
     {
-        case OVPN_CMD_DEL_PEER:
-            if (dco->dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_EXPIR=
ED)
-            {
-                msg(D_DCO_DEBUG, "%s: received peer expired notification o=
f for peer-id "
-                    "%d", __func__, dco->dco_message_peer_id);
-                trigger_ping_timeout_signal(c);
-                return;
-            }
-            break;
-
-        case OVPN_CMD_SWAP_KEYS:
-            msg(D_DCO_DEBUG, "%s: received key rotation notification for p=
eer-id %d",
-                __func__, dco->dco_message_peer_id);
-            tls_session_soft_reset(c->c2.tls_multi);
-            break;
-
-        default:
-            msg(D_DCO_DEBUG, "%s: received message of type %u - ignoring",=
 __func__,
-                dco->dco_message_type);
+        if (dco->dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_EXPIRED)
+        {
+            msg(D_DCO_DEBUG, "%s: received peer expired notification of fo=
r peer-id "
+                "%d", __func__, dco->dco_message_peer_id);
+            trigger_ping_timeout_signal(c);
             return;
+        }
+    }
+    else if (dco->dco_message_type =3D=3D cmd_swap_keys)
+    {
+        msg(D_DCO_DEBUG, "%s: received key rotation notification for peer-=
id %d",
+            __func__, dco->dco_message_peer_id);
+        tls_session_soft_reset(c->c2.tls_multi);
+    }
+    else
+    {
+        msg(D_DCO_DEBUG, "%s: received message of type %u - ignoring", __f=
unc__,
+            dco->dco_message_type);
+        return;
     }

-#endif /* if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARG=
ET_FREEBSD)) */
+#endif /* #if defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
 }

 /*
diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h
index 73e19b5..4d198db 100644
--- a/src/openvpn/ovpn_dco_linux.h
+++ b/src/openvpn/ovpn_dco_linux.h
@@ -4,14 +4,15 @@
  *
  *  Copyright (C) 2019-2023 OpenVPN, Inc.
  *
- *  Author:	James Yonan <james@...515...>
- *		Antonio Quartulli <antonio@...515...>
+ *  Author:     James Yonan <james@...515...>
+ *              Antonio Quartulli <antonio@...515...>
  */

 #ifndef _UAPI_LINUX_OVPN_DCO_H_
 #define _UAPI_LINUX_OVPN_DCO_H_

 #define OVPN_NL_NAME "ovpn-dco-v2"
+#define OVPN_FAMILY_NAME        "ovpn"

 #define OVPN_NL_MULTICAST_GROUP_PEERS "peers"

@@ -19,238 +20,238 @@
  * enum ovpn_nl_commands - supported netlink commands
  */
 enum ovpn_nl_commands {
-	/**
-	 * @OVPN_CMD_UNSPEC: unspecified command to catch errors
-	 */
-	OVPN_CMD_UNSPEC =3D 0,
+    /**
+     * @OVPN_CMD_UNSPEC: unspecified command to catch errors
+     */
+    OVPN_CMD_UNSPEC =3D 0,

-	/**
-	 * @OVPN_CMD_NEW_PEER: Configure peer with its crypto keys
-	 */
-	OVPN_CMD_NEW_PEER,
+    /**
+     * @OVPN_CMD_NEW_PEER: Configure peer with its crypto keys
+     */
+    OVPN_CMD_NEW_PEER,

-	/**
-	 * @OVPN_CMD_SET_PEER: Tweak parameters for an existing peer
-	 */
-	OVPN_CMD_SET_PEER,
+    /**
+     * @OVPN_CMD_SET_PEER: Tweak parameters for an existing peer
+     */
+    OVPN_CMD_SET_PEER,

-	/**
-	 * @OVPN_CMD_DEL_PEER: Remove peer from internal table
-	 */
-	OVPN_CMD_DEL_PEER,
+    /**
+     * @OVPN_CMD_DEL_PEER: Remove peer from internal table
+     */
+    OVPN_CMD_DEL_PEER,

-	OVPN_CMD_NEW_KEY,
+    OVPN_CMD_NEW_KEY,

-	OVPN_CMD_SWAP_KEYS,
+    OVPN_CMD_SWAP_KEYS,

-	OVPN_CMD_DEL_KEY,
+    OVPN_CMD_DEL_KEY,

-	/**
-	 * @OVPN_CMD_GET_PEER: Retrieve the status of a peer or all peers
-	 */
-	OVPN_CMD_GET_PEER,
+    /**
+     * @OVPN_CMD_GET_PEER: Retrieve the status of a peer or all peers
+     */
+    OVPN_CMD_GET_PEER,
 };

 enum ovpn_cipher_alg {
-	/**
-	 * @OVPN_CIPHER_ALG_NONE: No encryption - reserved for debugging only
-	 */
-	OVPN_CIPHER_ALG_NONE =3D 0,
-	/**
-	 * @OVPN_CIPHER_ALG_AES_GCM: AES-GCM AEAD cipher with any allowed key size
-	 */
-	OVPN_CIPHER_ALG_AES_GCM,
-	/**
-	 * @OVPN_CIPHER_ALG_CHACHA20_POLY1305: ChaCha20Poly1305 AEAD cipher
-	 */
-	OVPN_CIPHER_ALG_CHACHA20_POLY1305,
+/**
+ * @OVPN_CIPHER_ALG_NONE: No encryption - reserved for debugging only
+ */
+    OVPN_CIPHER_ALG_NONE =3D 0,
+/**
+ * @OVPN_CIPHER_ALG_AES_GCM: AES-GCM AEAD cipher with any allowed key size
+ */
+    OVPN_CIPHER_ALG_AES_GCM,
+/**
+ * @OVPN_CIPHER_ALG_CHACHA20_POLY1305: ChaCha20Poly1305 AEAD cipher
+ */
+    OVPN_CIPHER_ALG_CHACHA20_POLY1305,
 };

 enum ovpn_del_peer_reason {
-	__OVPN_DEL_PEER_REASON_FIRST,
-	OVPN_DEL_PEER_REASON_TEARDOWN =3D __OVPN_DEL_PEER_REASON_FIRST,
-	OVPN_DEL_PEER_REASON_USERSPACE,
-	OVPN_DEL_PEER_REASON_EXPIRED,
-	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
-	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
-	__OVPN_DEL_PEER_REASON_AFTER_LAST
+    __OVPN_DEL_PEER_REASON_FIRST,
+    OVPN_DEL_PEER_REASON_TEARDOWN =3D __OVPN_DEL_PEER_REASON_FIRST,
+    OVPN_DEL_PEER_REASON_USERSPACE,
+    OVPN_DEL_PEER_REASON_EXPIRED,
+    OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
+    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
+    __OVPN_DEL_PEER_REASON_AFTER_LAST
 };

 enum ovpn_key_slot {
-	__OVPN_KEY_SLOT_FIRST,
-	OVPN_KEY_SLOT_PRIMARY =3D __OVPN_KEY_SLOT_FIRST,
-	OVPN_KEY_SLOT_SECONDARY,
-	__OVPN_KEY_SLOT_AFTER_LAST,
+    __OVPN_KEY_SLOT_FIRST,
+    OVPN_KEY_SLOT_PRIMARY =3D __OVPN_KEY_SLOT_FIRST,
+    OVPN_KEY_SLOT_SECONDARY,
+    __OVPN_KEY_SLOT_AFTER_LAST,
 };
=20
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
+enum ovpn_v2_netlink_attrs {
+    OVPN_ATTR_UNSPEC =3D 0,
+    OVPN_ATTR_IFINDEX,
+    OVPN_ATTR_NEW_PEER,
+    OVPN_ATTR_SET_PEER,
+    OVPN_ATTR_DEL_PEER,
+    OVPN_ATTR_NEW_KEY,
+    OVPN_ATTR_SWAP_KEYS,
+    OVPN_ATTR_DEL_KEY,
+    OVPN_ATTR_GET_PEER,

-	__OVPN_ATTR_AFTER_LAST,
-	OVPN_ATTR_MAX =3D __OVPN_ATTR_AFTER_LAST - 1,
+    __OVPN_ATTR_AFTER_LAST,
+    OVPN_ATTR_MAX =3D __OVPN_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_key_dir_attrs {
-	OVPN_KEY_DIR_ATTR_UNSPEC =3D 0,
-	OVPN_KEY_DIR_ATTR_CIPHER_KEY,
-	OVPN_KEY_DIR_ATTR_NONCE_TAIL,
+    OVPN_KEY_DIR_ATTR_UNSPEC =3D 0,
+    OVPN_KEY_DIR_ATTR_CIPHER_KEY,
+    OVPN_KEY_DIR_ATTR_NONCE_TAIL,

-	__OVPN_KEY_DIR_ATTR_AFTER_LAST,
-	OVPN_KEY_DIR_ATTR_MAX =3D __OVPN_KEY_DIR_ATTR_AFTER_LAST - 1,
+    __OVPN_KEY_DIR_ATTR_AFTER_LAST,
+    OVPN_KEY_DIR_ATTR_MAX =3D __OVPN_KEY_DIR_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_new_key_attrs {
-	OVPN_NEW_KEY_ATTR_UNSPEC =3D 0,
-	OVPN_NEW_KEY_ATTR_PEER_ID,
-	OVPN_NEW_KEY_ATTR_KEY_SLOT,
-	OVPN_NEW_KEY_ATTR_KEY_ID,
-	OVPN_NEW_KEY_ATTR_CIPHER_ALG,
-	OVPN_NEW_KEY_ATTR_ENCRYPT_KEY,
-	OVPN_NEW_KEY_ATTR_DECRYPT_KEY,
+    OVPN_NEW_KEY_ATTR_UNSPEC =3D 0,
+    OVPN_NEW_KEY_ATTR_PEER_ID,
+    OVPN_NEW_KEY_ATTR_KEY_SLOT,
+    OVPN_NEW_KEY_ATTR_KEY_ID,
+    OVPN_NEW_KEY_ATTR_CIPHER_ALG,
+    OVPN_NEW_KEY_ATTR_ENCRYPT_KEY,
+    OVPN_NEW_KEY_ATTR_DECRYPT_KEY,

-	__OVPN_NEW_KEY_ATTR_AFTER_LAST,
-	OVPN_NEW_KEY_ATTR_MAX =3D __OVPN_NEW_KEY_ATTR_AFTER_LAST - 1,
+    __OVPN_NEW_KEY_ATTR_AFTER_LAST,
+    OVPN_NEW_KEY_ATTR_MAX =3D __OVPN_NEW_KEY_ATTR_AFTER_LAST - 1,
 };
=20
 enum ovpn_netlink_del_key_attrs {
-	OVPN_DEL_KEY_ATTR_UNSPEC =3D 0,
-	OVPN_DEL_KEY_ATTR_PEER_ID,
-	OVPN_DEL_KEY_ATTR_KEY_SLOT,
+    OVPN_DEL_KEY_ATTR_UNSPEC =3D 0,
+    OVPN_DEL_KEY_ATTR_PEER_ID,
+    OVPN_DEL_KEY_ATTR_KEY_SLOT,

-	__OVPN_DEL_KEY_ATTR_AFTER_LAST,
-	OVPN_DEL_KEY_ATTR_MAX =3D __OVPN_DEL_KEY_ATTR_AFTER_LAST - 1,
+    __OVPN_DEL_KEY_ATTR_AFTER_LAST,
+    OVPN_DEL_KEY_ATTR_MAX =3D __OVPN_DEL_KEY_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_swap_keys_attrs {
-	OVPN_SWAP_KEYS_ATTR_UNSPEC =3D 0,
-	OVPN_SWAP_KEYS_ATTR_PEER_ID,
+    OVPN_SWAP_KEYS_ATTR_UNSPEC =3D 0,
+    OVPN_SWAP_KEYS_ATTR_PEER_ID,

-	__OVPN_SWAP_KEYS_ATTR_AFTER_LAST,
-	OVPN_SWAP_KEYS_ATTR_MAX =3D __OVPN_SWAP_KEYS_ATTR_AFTER_LAST - 1,
+    __OVPN_SWAP_KEYS_ATTR_AFTER_LAST,
+    OVPN_SWAP_KEYS_ATTR_MAX =3D __OVPN_SWAP_KEYS_ATTR_AFTER_LAST - 1,

 };

 enum ovpn_netlink_new_peer_attrs {
-	OVPN_NEW_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_NEW_PEER_ATTR_PEER_ID,
-	OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE,
-	OVPN_NEW_PEER_ATTR_SOCKET,
-	OVPN_NEW_PEER_ATTR_IPV4,
-	OVPN_NEW_PEER_ATTR_IPV6,
-	OVPN_NEW_PEER_ATTR_LOCAL_IP,
+    OVPN_NEW_PEER_ATTR_UNSPEC =3D 0,
+    OVPN_NEW_PEER_ATTR_PEER_ID,
+    OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE,
+    OVPN_NEW_PEER_ATTR_SOCKET,
+    OVPN_NEW_PEER_ATTR_IPV4,
+    OVPN_NEW_PEER_ATTR_IPV6,
+    OVPN_NEW_PEER_ATTR_LOCAL_IP,

-	__OVPN_NEW_PEER_ATTR_AFTER_LAST,
-	OVPN_NEW_PEER_ATTR_MAX =3D __OVPN_NEW_PEER_ATTR_AFTER_LAST - 1,
+    __OVPN_NEW_PEER_ATTR_AFTER_LAST,
+    OVPN_NEW_PEER_ATTR_MAX =3D __OVPN_NEW_PEER_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_set_peer_attrs {
-	OVPN_SET_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_SET_PEER_ATTR_PEER_ID,
-	OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,
-	OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,
+    OVPN_SET_PEER_ATTR_UNSPEC =3D 0,
+    OVPN_SET_PEER_ATTR_PEER_ID,
+    OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,
+    OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,

-	__OVPN_SET_PEER_ATTR_AFTER_LAST,
-	OVPN_SET_PEER_ATTR_MAX =3D __OVPN_SET_PEER_ATTR_AFTER_LAST - 1,
+    __OVPN_SET_PEER_ATTR_AFTER_LAST,
+    OVPN_SET_PEER_ATTR_MAX =3D __OVPN_SET_PEER_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_del_peer_attrs {
-	OVPN_DEL_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_DEL_PEER_ATTR_REASON,
-	OVPN_DEL_PEER_ATTR_PEER_ID,
+    OVPN_DEL_PEER_ATTR_UNSPEC =3D 0,
+    OVPN_DEL_PEER_ATTR_REASON,
+    OVPN_DEL_PEER_ATTR_PEER_ID,

-	__OVPN_DEL_PEER_ATTR_AFTER_LAST,
-	OVPN_DEL_PEER_ATTR_MAX =3D __OVPN_DEL_PEER_ATTR_AFTER_LAST - 1,
+    __OVPN_DEL_PEER_ATTR_AFTER_LAST,
+    OVPN_DEL_PEER_ATTR_MAX =3D __OVPN_DEL_PEER_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_get_peer_attrs {
-	OVPN_GET_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_GET_PEER_ATTR_PEER_ID,
+    OVPN_GET_PEER_ATTR_UNSPEC =3D 0,
+    OVPN_GET_PEER_ATTR_PEER_ID,

-	__OVPN_GET_PEER_ATTR_AFTER_LAST,
-	OVPN_GET_PEER_ATTR_MAX =3D __OVPN_GET_PEER_ATTR_AFTER_LAST - 1,
+    __OVPN_GET_PEER_ATTR_AFTER_LAST,
+    OVPN_GET_PEER_ATTR_MAX =3D __OVPN_GET_PEER_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_get_peer_response_attrs {
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
+    OVPN_GET_PEER_RESP_ATTR_UNSPEC =3D 0,
+    OVPN_GET_PEER_RESP_ATTR_PEER_ID,
+    OVPN_GET_PEER_RESP_ATTR_SOCKADDR_REMOTE,
+    OVPN_GET_PEER_RESP_ATTR_IPV4,
+    OVPN_GET_PEER_RESP_ATTR_IPV6,
+    OVPN_GET_PEER_RESP_ATTR_LOCAL_IP,
+    OVPN_GET_PEER_RESP_ATTR_LOCAL_PORT,
+    OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_INTERVAL,
+    OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_TIMEOUT,
+    OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES,
+    OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES,
+    OVPN_GET_PEER_RESP_ATTR_VPN_RX_PACKETS,
+    OVPN_GET_PEER_RESP_ATTR_VPN_TX_PACKETS,
+    OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES,
+    OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES,
+    OVPN_GET_PEER_RESP_ATTR_LINK_RX_PACKETS,
+    OVPN_GET_PEER_RESP_ATTR_LINK_TX_PACKETS,

-	__OVPN_GET_PEER_RESP_ATTR_AFTER_LAST,
-	OVPN_GET_PEER_RESP_ATTR_MAX =3D __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST - 1,
+    __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST,
+    OVPN_GET_PEER_RESP_ATTR_MAX =3D __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST -=
 1,
 };

 enum ovpn_netlink_peer_stats_attrs {
-	OVPN_PEER_STATS_ATTR_UNSPEC =3D 0,
-	OVPN_PEER_STATS_BYTES,
-	OVPN_PEER_STATS_PACKETS,
+    OVPN_PEER_STATS_ATTR_UNSPEC =3D 0,
+    OVPN_PEER_STATS_BYTES,
+    OVPN_PEER_STATS_PACKETS,

-	__OVPN_PEER_STATS_ATTR_AFTER_LAST,
-	OVPN_PEER_STATS_ATTR_MAX =3D __OVPN_PEER_STATS_ATTR_AFTER_LAST - 1,
+    __OVPN_PEER_STATS_ATTR_AFTER_LAST,
+    OVPN_PEER_STATS_ATTR_MAX =3D __OVPN_PEER_STATS_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_peer_attrs {
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
+    OVPN_PEER_ATTR_UNSPEC =3D 0,
+    OVPN_PEER_ATTR_PEER_ID,
+    OVPN_PEER_ATTR_SOCKADDR_REMOTE,
+    OVPN_PEER_ATTR_IPV4,
+    OVPN_PEER_ATTR_IPV6,
+    OVPN_PEER_ATTR_LOCAL_IP,
+    OVPN_PEER_ATTR_KEEPALIVE_INTERVAL,
+    OVPN_PEER_ATTR_KEEPALIVE_TIMEOUT,
+    OVPN_PEER_ATTR_ENCRYPT_KEY,
+    OVPN_PEER_ATTR_DECRYPT_KEY,
+    OVPN_PEER_ATTR_RX_STATS,
+    OVPN_PEER_ATTR_TX_STATS,

-	__OVPN_PEER_ATTR_AFTER_LAST,
-	OVPN_PEER_ATTR_MAX =3D __OVPN_PEER_ATTR_AFTER_LAST - 1,
+    __OVPN_PEER_ATTR_AFTER_LAST,
+    OVPN_PEER_ATTR_MAX =3D __OVPN_PEER_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_packet_attrs {
-	OVPN_PACKET_ATTR_UNSPEC =3D 0,
-	OVPN_PACKET_ATTR_PACKET,
-	OVPN_PACKET_ATTR_PEER_ID,
+    OVPN_PACKET_ATTR_UNSPEC =3D 0,
+    OVPN_PACKET_ATTR_PACKET,
+    OVPN_PACKET_ATTR_PEER_ID,

-	__OVPN_PACKET_ATTR_AFTER_LAST,
-	OVPN_PACKET_ATTR_MAX =3D __OVPN_PACKET_ATTR_AFTER_LAST - 1,
+    __OVPN_PACKET_ATTR_AFTER_LAST,
+    OVPN_PACKET_ATTR_MAX =3D __OVPN_PACKET_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_ifla_attrs {
-	IFLA_OVPN_UNSPEC =3D 0,
-	IFLA_OVPN_MODE,
+    IFLA_OVPN_UNSPEC =3D 0,
+    IFLA_OVPN_MODE,

-	__IFLA_OVPN_AFTER_LAST,
-	IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,
+    __IFLA_OVPN_AFTER_LAST,
+    IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,
 };

 enum ovpn_mode {
-	__OVPN_MODE_FIRST =3D 0,
-	OVPN_MODE_P2P =3D __OVPN_MODE_FIRST,
-	OVPN_MODE_MP,
+    __OVPN_MODE_FIRST =3D 0,
+    OVPN_MODE_P2P =3D __OVPN_MODE_FIRST,
+    OVPN_MODE_MP,

-	__OVPN_MODE_AFTER_LAST,
+    __OVPN_MODE_AFTER_LAST,
 };

 #endif /* _UAPI_LINUX_OVPN_DCO_H_ */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/661?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6662605b60d4859949970cfe256c55cbcbd4a672
Gerrit-Change-Number: 661
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--qMxNiFmUErI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/661?usp=3Demail">Vi=
ew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">Lay the foundation to support both old and n=
ew versions of DCO<br><br>Added a new abstraction layer based on the `struc=
t dco_ops`,<br>a structure of function pointers that ensures the appropriat=
e<br>APIs at runtime are used for DCO communication between kernel<br>and u=
ser space, selection is based on the available module&#39;s<br>family name.=
<br><br>The old version, referred to as &quot;ovpn_dco_v2&quot;, and its re=
lated<br>commands and functions, will be distinguished with the &quot;v2&qu=
ot; suffix.<br><br>Change-Id: I6662605b60d4859949970cfe256c55cbcbd4a672<br>=
Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>=
M CMakeLists.txt<br>M src/openvpn/Makefile.am<br>M src/openvpn/dco.c<br>M s=
rc/openvpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.=
c<br>M src/openvpn/dco_linux.h<br>A src/openvpn/dco_linux_v2.c<br>M src/ope=
nvpn/dco_win.c<br>M src/openvpn/forward.c<br>M src/openvpn/ovpn_dco_linux.h=
<br>11 files changed, 1,082 insertions(+), 813 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61=
/661/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span=
>index 096837d..732be9e 100644</span><br><span>--- a/CMakeLists.txt</span><=
br><span>+++ b/CMakeLists.txt</span><br><span>@@ -398,6 +398,7 @@</span><br=
><span>     src/openvpn/dco_win.h</span><br><span>     src/openvpn/dco_linu=
x.c</span><br><span>     src/openvpn/dco_linux.h</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    src/openvpn/dco_linux_v2.c</span><br><span=
>     src/openvpn/dco_freebsd.c</span><br><span>     src/openvpn/dco_freebs=
d.h</span><br><span>     src/openvpn/dhcp.c</span><br><span>diff --git a/sr=
c/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index 56cce=
9d..286d3c5 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><br>=
<span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -54,6 +54,7 @@</span=
><br><span> 	dco.c dco.h dco_internal.h \</span><br><span> 	dco_freebsd.c d=
co_freebsd.h \</span><br><span> 	dco_linux.c dco_linux.h \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	dco_linux_v2.c \</span><br><span> 	=
dco_win.c dco_win.h \</span><br><span> 	dhcp.c dhcp.h \</span><br><span> 	d=
ns.c dns.h \</span><br><span>diff --git a/src/openvpn/dco.c b/src/openvpn/d=
co.c</span><br><span>index 78243b1..80184f8 100644</span><br><span>--- a/sr=
c/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ =
-396,7 +396,7 @@</span><br><span>     /* now that all options have been con=
firmed to be supported, check</span><br><span>      * if DCO is truly avail=
able on the system</span><br><span>      */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return dco_available(msglevel);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return dco_available(msglevel, NU=
LL);</span><br><span> }</span><br><span> </span><br><span> bool</span><br><=
span>diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>ind=
ex 50ebb35..fc34da8 100644</span><br><span>--- a/src/openvpn/dco.h</span><b=
r><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -56,7 +56,7 @@</span><br=
><span>  * @param msglevel      level to print messages to</span><br><span>=
  * @return              true if ovpn-dco is available, false otherwise</sp=
an><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool=
 dco_available(int msglevel);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool dco_available(int msglevel, dco_context_t *dco);</span><br><=
span> </span><br><span> </span><br><span> /**</span><br><span>@@ -254,7 +25=
4,7 @@</span><br><span> typedef void *dco_context_t;</span><br><span> </spa=
n><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-dco_available(int msglevel)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_available(int msglevel, dco_context_t *dco)</span><br=
><span> {</span><br><span>     return false;</span><br><span> }</span><br><=
span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</sp=
an><br><span>index 7c8b29c..93c0813 100644</span><br><span>--- a/src/openvp=
n/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><=
span>@@ -569,7 +569,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_available=
(int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_a=
vailable(int msglevel, dco_context_t *dco)</span><br><span> {</span><br><sp=
an>     struct if_clonereq ifcr;</span><br><span>     char *buf =3D NULL;</=
span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux=
.c</span><br><span>index b2584b9..4feae6d 100644</span><br><span>--- a/src/=
openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br=
><span>@@ -51,32 +51,28 @@</span><br><span> #include &lt;netlink/genl/ctrl.=
h&gt;</span><br><span> </span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/* libnl &lt; 3.5.0 does not set the NLA_F_NESTED on it=
s own, therefore we</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 have to explicitly do it to prevent the kernel from failing upon</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * parsing of the message</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define nla_nest_start(_msg, _type) \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_nest_start(_msg, (_=
type) | NLA_F_NESTED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int ovpn_get_m=
cast_id(dco_context_t *dco);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void dco_check=
_key_ctx(const struct key_ctx_bi *key);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-typ=
edef int (*ovpn_nl_cb)(struct nl_msg *msg, void *arg);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @br=
ief resolves the netlink ID for ovpn-dco</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * This function queries the kernel via a netlink socket</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * whether the ovpn-dco netlink namespac=
e is available</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * This function can be us=
ed to determine if the kernel</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * supports DCO offloading.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @r=
eturn ID on success, negative error code on error</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- */</span><br><span> static int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-resolve_ovpn_netlink_id(int msglevel)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_family_name_reso=
lve(struct nl_sock *nl_sock, int msglevel, const char *family_name,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                       dco_=
context_t *dco, const struct dco_ops *ops)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int ret =3D genl_ctrl_resolve(nl_sock, family_name);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(msglevel, &quot;Cannot find %s netlink component: %s&q=
uot;, family_name, nl_geterror(ret));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* Ensures that we will use =
the proper ops for the dco version available */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        dco-&gt;ops =3D ops;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+resolve_ovpn_netlink_id(int msglevel, dco_context_t *=
dco)</span><br><span> {</span><br><span>     int ret;</span><br><span>     =
struct nl_sock *nl_sock =3D nl_socket_alloc();</span><br><span>@@ -96,39 +9=
2,14 @@</span><br><span>     }</span><br><span>     set_cloexec(nl_socket_g=
et_fd(nl_sock));</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ret =3D genl_ctrl_resolve(nl_sock, OVPN_NL_NAME);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (ret &lt; 0)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;Cannot find ovpn_dco=
 netlink component: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            nl_geterror(ret));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ret =3D do_family_name_resolve(nl_sock, msglevel, OVPN_NL_NAME, dco,=
 &amp;dco_ops_v2);</span><br><span> </span><br><span> err_sock:</span><br><=
span>     nl_socket_free(nl_sock);</span><br><span>     return ret;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static struct nl_msg *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-ovpn_dco_nlmsg_create(dco_context_t *dco, enum ovpn_nl_commands cm=
d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct nl_msg *nl_msg =3D nlmsg_all=
oc();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!nl_msg)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;cannot alloc=
ate netlink message&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    genlmsg_put(nl_msg, 0, 0, dc=
o-&gt;ovpn_dco_id, 0, 0, cmd, 0);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_ATTR_IFINDEX, dco-&gt;ifindex);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return nl_msg;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-nla_put_failure:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    nlmsg_free(nl_msg);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    msg(M_INFO, &quot;cannot put into netlink mes=
sage&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+int</span><br><span> ovpn_nl_recvmsgs(dco_context_t *dco, const =
char *prefix)</span><br><span> {</span><br><span>     int ret =3D nl_recvms=
gs(dco-&gt;nl_sock, dco-&gt;nl_cb);</span><br><span>@@ -166,18 +137,7 @@</s=
pan><br><span>     return ret;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Send a prepared netlink message and register=
s cb as callback if non-null.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The meth=
od will also free nl_msg</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @param dco       The dco context to use</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @param nl_msg    the message to use</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param cb        An optional ca=
llback if the caller expects an answer</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @param cb_arg    An optional param to pass to the callb=
ack</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param prefix  =
  A prefix to report in the error message to give the user context</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @return          status of =
sending the message</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span> ovpn_nl_=
msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb cb,</span><b=
r><span>                  void *cb_arg, const char *prefix)</span><br><span=
> {</span><br><span>@@ -218,71 +178,6 @@</span><br><span> }</span><br><span=
> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-             struct sockaddr *loc=
aladdr, struct sockaddr *remoteaddr,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-             struct in_addr *remote_in4, struct in6_addr *re=
mote_in6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *r=
emotestr =3D &quot;[undefined]&quot;;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (remoteaddr)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      remotestr =3D print_sockaddr(remoteaddr, &amp;gc);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd %d, remote=
 addr: %s&quot;, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        peerid, sd, remotestr);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_NEW_PEER);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *attr =
=3D nla_nest_start(nl_msg, OVPN_ATTR_NEW_PEER);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int ret =3D -EMSGSIZE;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_PEER_ID, peerid);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, O=
VPN_NEW_PEER_ATTR_SOCKET, sd);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Set t=
he remote endpoint if defined (for UDP) */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (remoteaddr)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        remoteaddr =3D mapped_v4_to_v6(remoteaddr, &amp;gc);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        int alen =3D af_addr_size=
(remoteaddr-&gt;sa_family);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        NLA_PUT=
(nl_msg, OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE, alen, remoteaddr);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (localaddr)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        locala=
ddr =3D mapped_v4_to_v6(localaddr, &amp;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (localaddr-&gt;sa_family =3D=3D AF_INET)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            NLA_PUT(nl_msg, OVPN_N=
EW_PEER_ATTR_LOCAL_IP, sizeof(struct in_addr),</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    &amp;((struct sockaddr_in *)lo=
caladdr)-&gt;sin_addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        el=
se if (localaddr-&gt;sa_family =3D=3D AF_INET6)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, size=
of(struct in6_addr),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   &amp;((struct sockaddr_in6 *)localaddr)-&gt;sin6_addr);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* Set the primary VPN IP addresses of the peer */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (remote_in4)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, rem=
ote_in4-&gt;s_addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (remote_in=
6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        NLA_PUT(nl_msg, OVPN_NEW_PE=
ER_ATTR_IPV6, sizeof(struct in6_addr),</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                remote_in6);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    nla_nest_end(nl_msg, attr);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-nla_put_failure:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    nlmsg_free(nl_msg);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span> ovp=
n_nl_cb_finish(struct nl_msg (*msg) __attribute__ ((unused)), void *arg)</s=
pan><br><span> {</span><br><span>     int *status =3D arg;</span><br><span>=
@@ -291,15 +186,7 @@</span><br><span>     return NL_SKIP;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
 This function is used as error callback on the netlink socket.</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * When something goes wrong and =
the kernel returns an error, this function is</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * invoked.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * We=
 pass the error code to the user by means of a variable pointed by *arg</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * (supplied by the user =
when setting this callback) and we parse the kernel</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * reply to see if it contains a human-read=
able error. If found, it is printed.</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><b=
r><span> ovpn_nl_cb_error(struct sockaddr_nl (*nla) __attribute__ ((unused)=
),</span><br><span>                  struct nlmsgerr *err, void *arg)</span=
><br><span> {</span><br><span>@@ -342,10 +229,16 @@</span><br><span>     re=
turn NL_STOP;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span> ovpn_dco_init_netlink(dco_contex=
t_t *dco)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    dco-&gt;ovpn_dco_id =3D resolve_ovpn_netlink_id(M_ERR);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dc=
o-&gt;ops)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_CLEAR=
_GC(dco-&gt;ops, struct dco_ops, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&g=
t;ovpn_dco_id =3D resolve_ovpn_netlink_id(M_ERR, dco);</span><br><span> </s=
pan><br><span>     dco-&gt;nl_sock =3D nl_socket_alloc();</span><br><span> =
</span><br><span>@@ -388,6 +281,7 @@</span><br><span>      * overrun with v=
ery fast connecting/disconnecting clients.</span><br><span>      * TODO: fi=
x this in a better and more reliable way */</span><br><span>     ASSERT(!nl=
_socket_set_buffer_size(dco-&gt;nl_sock, 1024*1024, 1024*1024));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span> }</span><br><span> </span><br><span> bool</span><br><span>@@ -411,=
7 +305,7 @@</span><br><span>     return true;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> =
ovpn_dco_uninit_netlink(dco_context_t *dco)</span><br><span> {</span><br><s=
pan>     nl_socket_free(dco-&gt;nl_sock);</span><br><span>@@ -423,7 +317,7 =
@@</span><br><span>     CLEAR(dco);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> ovpn_dco_r=
egister(dco_context_t *dco)</span><br><span> {</span><br><span>     msg(D_D=
CO_DEBUG, __func__);</span><br><span>@@ -447,205 +341,11 @@</span><br><span=
> int</span><br><span> open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *c=
tx, const char *dev)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: %s&quot;, __func__, dev);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(tt-&gt;type=
 =3D=3D DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D net_=
iface_new(ctx, dev, &quot;ovpn-dco&quot;, &amp;tt-&gt;dco);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (ret &lt; 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;Cannot create DCO interf=
ace %s: %d&quot;, dev, ret);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    tt-&gt;dco.ifindex =3D if_na=
metoindex(dev);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (!tt-&gt;dco.ifindex)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_F=
ATAL, &quot;DCO: cannot retrieve ifindex for interface %s&quot;, dev);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    tt-&gt;dco.dco_message_peer_id =3D -1;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ovpn_dco_register(&amp;tt-&gt;dco);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, __func__);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    net_iface_del(ctx, tt-&gt;actual_name);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ovpn_dco_uninit_netlink(&=
amp;tt-&gt;dco);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-dco_swap_keys(dco_context_t *dco, unsigned int peerid)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __=
func__, peerid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nl_msg *nl_msg =
=3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_SWAP_KEYS);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!nl_msg)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        return -ENOMEM;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *attr =
=3D nla_nest_start(nl_msg, OVPN_ATTR_SWAP_KEYS);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int ret =3D -EMSGSIZE;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR=
_PEER_ID, peerid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 nla_nest_end(nl_msg, attr);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ov=
pn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-nla_put_failure:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    nlmsg_free(nl_msg);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_de=
l_peer(dco_context_t *dco, unsigned int peerid)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peerid);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct nl_msg *nl_msg =3D ovpn_dco_nlms=
g_create(dco, OVPN_CMD_DEL_PEER);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!nl_msg)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn -ENOMEM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *attr =3D nla_nest_start(=
nl_msg, OVPN_ATTR_DEL_PEER);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int ret =3D -EMSGSIZE;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_DEL_PEER_ATTR_PEER_ID, peerid);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_nest_end(nl_msg,=
 attr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, n=
l_msg, NULL, NULL, __func__);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nla_put_failu=
re:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nlmsg_free(nl_=
msg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_del_key(dco_context_t *=
dco, unsigned int peerid,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            dco_key_slot_t slot)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
sg(D_DCO_DEBUG, &quot;%s: peer-id %d, slot %d&quot;, __func__, peerid, slot=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct nl_msg *nl_msg =3D ovpn_dco_n=
lmsg_create(dco, OVPN_CMD_DEL_KEY);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (!nl_msg)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return -ENOMEM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *attr =3D nla_nest_start=
(nl_msg, OVPN_ATTR_DEL_KEY);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int ret =3D -EMSGSIZE;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_DEL_KEY_ATTR_PEER_ID, peerid);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U8(nl_msg, OV=
PN_DEL_KEY_ATTR_KEY_SLOT, slot);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    nla_nest_end(nl_msg, attr);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-nla_put_failure:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    nlmsg_free(nl_msg);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int ret =3D tt-&gt;dco.ops-&gt;open_tun_dco(tt, ct=
x, dev);</span><br><span>     return ret;</span><br><span> }</span><br><spa=
n> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            dco_key_slot_t slo=
t,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const u=
int8_t *encrypt_key, const uint8_t *encrypt_iv,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            const uint8_t *decrypt_key, const uin=
t8_t *decrypt_iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        const char *ciphername)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_=
DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %d, cipher %s&quot;,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        __func__, slot, key=
id, peerid, ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const size_t k=
ey_len =3D cipher_kt_key_size(ciphername);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const int nonce_tail_len =3D 8;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN=
_CMD_NEW_KEY);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!nl_msg)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return -ENOMEM;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    dco_cipher_t dco_cipher =3D dco_get_cipher(ciphername);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    int ret =3D -EMSGSIZE;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *attr =3D nla_nest_star=
t(nl_msg, OVPN_ATTR_NEW_KEY);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    NLA_PUT_U32(nl_msg, OVPN_NEW_KEY_ATTR_PEER_ID, peerid);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U8(nl_msg, OVPN_N=
EW_KEY_ATTR_KEY_SLOT, slot);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_ID, keyid);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U16(nl_msg, OVPN_NEW_=
KEY_ATTR_CIPHER_ALG, dco_cipher);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t nlattr *key_enc =3D nla_nest_start(nl_msg,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                            OVPN_NEW=
_KEY_ATTR_ENCRYPT_KEY);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, en=
crypt_key);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        NL=
A_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                encrypt_iv);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    nla_nest_end(nl_msg, key_enc);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct nlattr *key_dec =3D nla_nest_start(nl_msg,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
                      OVPN_NEW_KEY_ATTR_DECRYPT_KEY);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (dco_cipher !=3D OVPN_CIPHER_ALG_NON=
E)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        NLA_PUT(nl_msg, OVPN_KEY_DI=
R_ATTR_CIPHER_KEY, key_len, decrypt_key);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, n=
once_tail_len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         decrypt_iv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_nest_end=
(nl_msg, key_dec);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_nest_end(nl_msg,=
 attr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, n=
l_msg, NULL, NULL, __func__);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nla_put_failu=
re:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nlmsg_free(nl_=
msg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_se=
t_peer(dco_context_t *dco, unsigned int peerid,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-             int keepalive_interval, int keepaliv=
e_timeout, int mss)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &=
quot;%s: peer-id %d, keepalive %d/%d, mss %d&quot;, __func__,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        peerid, keepalive_interval,=
 keepalive_timeout, mss);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nl_msg=
 *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_SET_PEER);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (!nl_msg)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return -ENOMEM;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr =
*attr =3D nla_nest_start(nl_msg, OVPN_ATTR_SET_PEER);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -EMSGSIZE;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_=
ATTR_PEER_ID, peerid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                keepalive_interva=
l);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NLA_PUT_U32(nl=
_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                keepalive_timeout);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    nla_nest_end(nl_msg, attr);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NU=
LL, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-nla_put_failure:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    nlmsg_free(nl_msg);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* =
This function parses the reply provided by the kernel to the CTRL_CMD_GETFA=
MILY</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * message. We pa=
rse the reply and we retrieve the multicast group ID associated</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * with the &quot;ovpn-dco&quot; =
netlink family.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * The ID is later used t=
o subscribe to the multicast group and be notified</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * about any multicast message sent by the ovp=
n-dco kernel module.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><b=
r><span> mcast_family_handler(struct nl_msg *msg, void *arg)</span><br><spa=
n> {</span><br><span>     dco_context_t *dco =3D arg;</span><br><span>@@ -6=
87,12 +387,8 @@</span><br><span> </span><br><span>     return NL_SKIP;</spa=
n><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Lookup the multicast i=
d for OpenVPN. This method and its help method currently</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * hardcode the lookup to OVPN_NL_NAME a=
nd OVPN_NL_MULTICAST_GROUP_PEERS but</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * extended in the future if we need to lookup more than one=
 mcast id.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+int</span><br><span> ovpn_get_mcast_id(dco_context_t *dco=
)</span><br><span> {</span><br><span>     dco-&gt;ovpn_dco_mcast_id =3D -EN=
OENT;</span><br><span>@@ -719,299 +415,15 @@</span><br><span>     return re=
t;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/* This function parses any netlink message sent by ovpn-=
dco to userspace */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_handle_m=
sg(struct nl_msg *msg, void *arg)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_=
context_t *dco =3D arg;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct genlmsgh=
dr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct nlattr *attrs[OVPN_ATTR_MAX + 1];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct nlmsghdr *nlh =3D nlms=
g_hdr(msg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (!genlmsg_valid_hdr(nlh,=
 0))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco=
: invalid header&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (nla_parse(attrs, OVPN_AT=
TR_MAX, genlmsg_attrdata(gnlh, 0),</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                  genlmsg_attrlen(gnlh, 0), NULL))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(D_DCO, &quot;received bogus data from=
 ovpn-dco&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* we must know which interface thi=
s message is referring to in order to</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     * avoid mixing messages for other instances</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!attrs[OVPN_ATTR_IFINDEX])</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: Received messa=
ge without ifindex&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t ifindex =3D nla_g=
et_u32(attrs[OVPN_ATTR_IFINDEX]);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (ifindex !=3D dco-&gt;ifindex)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(D_DCO_DEBUG,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            &quot;ovpn-dco: ignoring message (type=3D%d) for=
 foreign ifindex %d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            gnlh-&gt;cmd, ifindex);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return NL_SKIP;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* based on =
the message type, we parse the subobject contained in the</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-     * message, that stores the type-sp=
ecific attributes.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the &quot;d=
co&quot; object is then filled accordingly with the information</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     * retrieved from the message=
, so that the rest of the OpenVPN code can</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     * react as need be.</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    switch (gnlh-&gt;cmd)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      case OVPN_CMD_DEL_PEER:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (!attrs[OVPN_ATTR_DEL_PEER])</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                msg(D_DCO, &quot;ovpn-dco: no attributes in OVPN_=
DEL_PEER message&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                return NL_SKIP;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            stru=
ct nlattr *dp_attrs[OVPN_DEL_PEER_ATTR_MAX + 1];</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (nla_parse_nested(dp_attrs, OVPN_=
DEL_PEER_ATTR_MAX,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                              attrs[OVPN_ATTR_DEL_PEER], NULL))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;received=
 bogus del peer packet data from ovpn-dco&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                return NL_SKIP;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (!dp_attrs[OVPN_DEL_PEER_ATTR_REASON])</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dc=
o: no reason in DEL_PEER message&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                return NL_SKIP;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if (!dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_DCO, &q=
uot;ovpn-dco: no peer-id in DEL_PEER message&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                return NL_SKIP;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            int reason =3D nla_get_u8(dp_=
attrs[OVPN_DEL_PEER_ATTR_REASON]);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_=
DEL_PEER_ATTR_PEER_ID]);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_=
DCO_DEBUG, &quot;ovpn-dco: received CMD_DEL_PEER, ifindex: %d, peer-id %d, =
reason: %d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            ifindex, peerid, reason);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            dco-&gt;dco_message_peer_id =3D peerid;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            dco-&gt;dco_del_p=
eer_reason =3D reason;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            dco-&gt;dco_message_type =3D OVPN_CMD_DEL_PEER;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        default:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_DCO, =
&quot;ovpn-dco: received unknown command: %d&quot;, gnlh-&gt;cmd);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            dco-&gt;dco_messag=
e_type =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return NL_OK;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_do_read(dco_context_t *=
dco)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, __func__);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    nl_cb_set(dco-&gt;nl_cb=
, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return ovpn_nl_recvmsgs(dco, __func__);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_update_peer_st=
at(struct context_2 *c2, struct nlattr *tb[], uint32_t id)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES])</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        c2-&gt;dco_read_bytes =3D nla_get_u=
64(tb[OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES]);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s / dco_read_bytes=
: &quot; counter_format, __func__,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            c2-&gt;dco_read_bytes);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN=
, &quot;%s: no link RX bytes provided in reply for peer %u&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            __func__, id);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES])</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        c2-&gt;dco_write_bytes =3D nla_get_u64(tb[=
OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES]);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s / dco_write_bytes: &qu=
ot; counter_format, __func__,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            c2-&gt;dco_write_bytes);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &q=
uot;%s: no link TX bytes provided in reply for peer %u&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            __func__, id);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES])</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        c2-&gt;tun_read_bytes =3D nla_get_u64(tb[OVPN_G=
ET_PEER_RESP_ATTR_VPN_RX_BYTES]);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s / tun_read_bytes: &quot; coun=
ter_format, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            c2-&gt;tun_read_bytes);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: n=
o VPN RX bytes provided in reply for peer %u&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            __func__, id);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES])</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        c2-&gt;tun_write_bytes =3D nla_get_u64(tb[OVPN_GET_PEER=
_RESP_ATTR_VPN_TX_BYTES]);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        msg(D_DCO_DEBUG, &quot;%s / tun_write_bytes: &quot; counter_fo=
rmat, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      c2-&gt;tun_write_bytes);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: no VPN=
 TX bytes provided in reply for peer %u&quot;,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            __func__, id);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_parse_peer_multi(struct nl_msg *msg, vo=
id *arg)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb[OVPN_ATTR_M=
AX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct ge=
nlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __func__);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    nla_parse(tb, OVPN_ATTR_MAX, genlmsg_attrd=
ata(gnlh, 0),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
      genlmsg_attrlen(gnlh, 0), NULL);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!tb[OVPN_ATTR_GET_PEER])</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *tb_peer[OVPN_GET_PEER_RE=
SP_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_parse(tb_peer, OV=
PN_GET_PEER_RESP_ATTR_MAX,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-              nla_data(tb[OVPN_ATTR_GET_PEER]),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-              nla_len(tb[OVPN_ATTR_GET_PEER=
]), NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!tb_peer[OVPN_GET_PEER_R=
ESP_ATTR_PEER_ID])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN,=
 &quot;%s: no peer-id provided in reply&quot;, __func__);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct multi_context *m =3D arg;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_=
RESP_ATTR_PEER_ID]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (peer_id &gt;=
=3D m-&gt;max_clients || !m-&gt;instances[peer_id])</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_WARN, &quot;%s: cannot store DCO stats for pe=
er %u&quot;, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            peer_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    dco_update_peer_stat(&amp;m-&g=
t;instances[peer_id]-&gt;context.c2, tb_peer, peer_id);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return NL_OK;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-dco_get_peer_stats_multi(dco_context_t *dco, struc=
t multi_context *m)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &=
quot;%s&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nl_msg=
 *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    nlmsg_hdr(nl_msg)-&gt;nlmsg_flags |=3D NLM_F_DUMP;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    int ret =3D ovpn_nl_msg_send(dco, nl_msg, =
dco_parse_peer_multi, m, __func__);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nlm=
sg_free(nl_msg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-dco_parse_peer(struct nl_msg *msg, void *arg)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct context *c =3D arg;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct nlattr *tb[OVPN_ATTR_MAX + 1];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct genlmsghdr *gnlh =
=3D nlmsg_data(nlmsg_hdr(msg));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_D=
CO_DEBUG, &quot;%s: parsing message...&quot;, __func__);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    nla_parse(tb, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-              genlmsg_a=
ttrlen(gnlh, 0), NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!tb[OVPN_AT=
TR_GET_PEER])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG,=
 &quot;%s: malformed reply&quot;, __func__);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return NL_SKIP;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct n=
lattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    nla_parse(tb_peer, OVPN_GET_PEER_RESP_ATTR_MAX,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-              nla_data(tb[OVPN_ATTR_GET=
_PEER]),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
 nla_len(tb[OVPN_ATTR_GET_PEER]), NULL);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        msg(M_WARN, &quot;%s: no peer-id provided in reply&quot;=
, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn NL_SKIP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint32_t peer_id =3D nla_get_u32(tb_pee=
r[OVPN_GET_PEER_RESP_ATTR_PEER_ID]);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (c-&gt;c2.tls_multi-&gt;dco_peer_id !=3D peer_id)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return NL_SKIP;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   dco_update_peer_stat(&amp;c-&gt;c2, tb_peer, peer_id);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return NL_OK;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-dco_get_peer_stats(struct context *c)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    uint32_t peer_id =3D c-&gt;c2.tls_multi-&gt;dco_=
peer_id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO=
_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peer_id);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (!c-&gt;c1.tuntap)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    dco_context_t *dco =3D &amp;c-&gt;c1=
.tuntap-&gt;dco;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *attr =
=3D nla_nest_start(nl_msg, OVPN_ATTR_GET_PEER);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int ret =3D -EMSGSIZE;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    NLA_PUT_U32(nl_msg, OVPN_GET_PEER_ATTR_PEER_ID, peer_id);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    nla_nest_end(nl_msg,=
 attr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ovpn_nl_msg_send(dco, n=
l_msg, dco_parse_peer, c, __func__);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nla_pu=
t_failure:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nlmsg_f=
ree(nl_msg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-dco_available(int msglevel)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+dco_available(int msglevel=
, dco_context_t *dco)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (resolve_ovpn_netlink_id(D_DCO_DEBUG) &lt; 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (resolve_ovpn_ne=
tlink_id(D_DCO_DEBUG, dco) &lt; 0)</span><br><span>     {</span><br><span> =
        msg(msglevel,</span><br><span>             &quot;Note: Kernel suppo=
rt for ovpn-dco missing, disabling data channel offload.&quot;);</span><br>=
<span>         return false;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     return true;</span><b=
r><span> }</span><br><span> </span><br><span>@@ -1043,6 +455,94 @@</span><b=
r><span>     return BSTR(&amp;out);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dco_new_peer(dco_context_t *dco, unsig=
ned int peerid, int sd,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+             struct sockaddr *localaddr, struct sockaddr *remoteaddr,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             struct i=
n_addr *remote_in4, struct in6_addr *remote_in6)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int ret =3D dco-&gt;ops-&gt;dco_new_peer(dco, peerid, sd, lo=
caladdr, remoteaddr, remote_in4, remote_in6);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+close_tun_dco(struct tuntap *t=
t, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;=
dco.ops-&gt;close_tun_dco(tt, ctx);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+dco_swap_keys(dco_context_t *dco, uns=
igned int peerid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco-=
&gt;ops-&gt;dco_swap_keys(dco, peerid);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+dco_del_peer(dco_context_t *dco, unsigned int peerid)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco-&gt;ops-&gt;dco_del_=
peer(dco, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
co_del_key(dco_context_t *dco, unsigned int peerid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            dco_key_slot_t slot)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int ret =3D dco-&gt;ops-&gt;dco_del_key(dc=
o, peerid, slot);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_new_key(dco_context_t *dco, unsigned int peerid, int =
keyid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            d=
co_key_slot_t slot,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            const uint8_t *encrypt_key, const uint8_t *encrypt_iv,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            const uint8_t *d=
ecrypt_key, const uint8_t *decrypt_iv,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            const char *ciphername)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int ret =3D dco-&gt;ops-&gt;dco_new_key(dco, peerid, k=
eyid, slot, encrypt_key, encrypt_iv, decrypt_key, decrypt_iv, ciphername);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
co_set_peer(dco_context_t *dco, unsigned int peerid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             int keepalive_interval, int =
keepalive_timeout, int mss)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int re=
t =3D dco-&gt;ops-&gt;dco_set_peer(dco, peerid, keepalive_interval, keepali=
ve_timeout, mss);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_do_read(dco_context_t *dco)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int ret =3D dco-&gt;ops-&gt;dco_do_read(dco);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_parse_peer_=
multi(struct nl_msg *msg, void *arg)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct multi_context *m =3D arg;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int ret =3D m-&gt;top.c1.tuntap-&gt;dco.ops-&gt;dco_par=
se_peer_multi(msg, arg);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco-&gt;ops-&gt;dco_get=
_peer_stats_multi(dco, m);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+dco_get_peer_stats(struct context *c)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int ret =3D c-&gt;c1.tuntap-&gt;dco.ops-&gt;dc=
o_get_peer_stats(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> voi=
d</span><br><span> dco_event_set(dco_context_t *dco, struct event_set *es, =
void *arg)</span><br><span> {</span><br><span>diff --git a/src/openvpn/dco_=
linux.h b/src/openvpn/dco_linux.h</span><br><span>index 511519a..a3cf528 10=
0644</span><br><span>--- a/src/openvpn/dco_linux.h</span><br><span>+++ b/sr=
c/openvpn/dco_linux.h</span><br><span>@@ -31,9 +31,30 @@</span><br><span> #=
include &lt;netlink/socket.h&gt;</span><br><span> #include &lt;netlink/netl=
ink.h&gt;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &lt;netlink/genl/genl.h&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;netlink/genl/family.h&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;netlink/genl/ctrl.=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;networking.h&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;fdmi=
sc.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* forward declarations (inc=
luding other headers leads to nasty include</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * order problems)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+struct multi_context;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+struct context_2;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+struct key_ctx_bi;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> typedef enum ovpn_key_slot dco_key_slot_t;</span><b=
r><span> typedef enum ovpn_cipher_alg dco_cipher_t;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* libnl &lt; 3.5.0 does =
not set the NLA_F_NESTED on its own, therefore we</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * have to explicitly do it to prevent the ke=
rnel from failing upon</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * parsing of the message</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 nla_nest_start(_msg, _type) \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    nla_nest_start(_msg, (_type) | NLA_F_NESTED)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span>=
 typedef struct</span><br><span> {</span><br><span>@@ -53,7 +74,114 @@</spa=
n><br><span>     int dco_del_peer_reason;</span><br><span>     uint64_t dco=
_read_bytes;</span><br><span>     uint64_t dco_write_bytes;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct dco_ops *ops;</span><br><span> } dco_=
context_t;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+struct dco_ops</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl_=
msg *(*ovpn_dco_nlmsg_create)(dco_context_t *dco, int cmd);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int (*dco_new_peer)(dco_context=
_t *dco, unsigned int peerid, int sd, struct sockaddr *localaddr, struct so=
ckaddr *remoteaddr, struct in_addr *remote_in4, struct in6_addr *remote_in6=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int (*open_tu=
n_dco)(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    void (*close_tun_dco)(s=
truct tuntap *tt, openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int (*dco_swap_keys)(dco_context_t *dco, unsigne=
d int peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt (*dco_del_peer)(dco_context_t *dco, unsigned int peerid);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int (*dco_del_key)(dco_context=
_t *dco, unsigned int peerid, dco_key_slot_t slot);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int (*dco_new_key)(dco_context_t *dco=
, unsigned int peerid, int keyid, dco_key_slot_t slot, const uint8_t *encry=
pt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key, const uint8_=
t *decrypt_iv, const char *ciphername);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int (*dco_set_peer)(dco_context_t *dco, unsigned in=
t peerid, int keepalive_interval, int keepalive_timeout, int mss);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int (*ovpn_handle_msg)(s=
truct nl_msg *msg, void *arg);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int (*dco_do_read)(dco_context_t *dco);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    void (*dco_update_peer_stat)(struct =
context_2 *c2, struct nlattr *tb[], uint32_t id);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int (*dco_parse_peer_multi)(struct nl_msg=
 *msg, void *arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int (*dco_get_peer_stats_multi)(dco_context_t *dco, struct multi_context=
 *m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int (*dco_=
parse_peer)(struct nl_msg *msg, void *arg);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int (*dco_get_peer_stats)(struct context *c);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+extern const struct dco_ops dco_ops_v2;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+int ovpn_get_mcast_id(dco_context_t *dco);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void dco_check_key_ctx(const struct key_ctx_bi *key)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+typedef int (*ovpn_nl_cb)(struct nl_m=
sg *msg, void *arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @brief resolves the netlink ID =
for ovpn-dco</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function queries=
 the kernel via a netlink socket</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * whether the ovpn-dco netlink namespace is available</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * This function can be used to determine if=
 the kernel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * suppo=
rts DCO offloading.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return ID on =
success, negative error code on error</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int resolve_ovpn_netlink_id(int msglevel, dco_context_t *dco);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+int ovpn_nl_recvmsgs(dco_context_t *dco, const ch=
ar *prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Send a prepared netlink message and re=
gisters cb as callback if non-null.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* The method will also free nl_msg</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param dco       The dco context to use</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param nl_msg    the message to us=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param cb      =
  An optional callback if the caller expects an answer</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param cb_arg    An optional param to=
 pass to the callback</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param prefix    A prefix to report in the error message to give the u=
ser context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn          status of sending the message</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+int ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_=
nl_cb cb,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
           void *cb_arg, const char *prefix);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+struct sockaddr *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+mapped_v4_to_v6(struct sockaddr *sock, struct gc_arena *gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+int ovpn_nl_cb_finish(struct nl_msg (*msg) __att=
ribute__ ((unused)), void *arg);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Thi=
s function is used as error callback on the netlink socket.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * When something goes wrong and th=
e kernel returns an error, this function is</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * invoked.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* We pass the error code to the user by means of a variable pointed by *arg=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (supplied by the=
 user when setting this callback) and we parse the kernel</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * reply to see if it contains a huma=
n-readable error. If found, it is printed.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int ovpn_nl_cb_error(struct sockaddr_nl (*nla) __attribute__ ((unuse=
d)),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
      struct nlmsgerr *err, void *arg);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void ovpn_dco_init_netlink(dco_context_t *dco);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool ovpn_dco_init(int mode, dco_context_t *dco);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void ovpn_dco_uninit_netlink(dco_context_t *dco);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void ovpn_dco_register(dco_context_t *dco=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* This function parses the reply pr=
ovided by the kernel to the CTRL_CMD_GETFAMILY</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * message. We parse the reply and we retrieve t=
he multicast group ID associated</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * with the &quot;ovpn-dco&quot; netlink family.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * The ID is later used to subscribe to the multic=
ast group and be notified</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * about any multicast message sent by the ovpn-dco kernel module.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+int mcast_family_handler(struct nl_msg=
 *msg, void *arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Lookup the multicast id for OpenV=
PN. This method and its help method currently</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * hardcode the lookup to OVPN_NL_NAME and OVPN_N=
L_MULTICAST_GROUP_PEERS but</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * extended in the future if we need to lookup more than one mcast =
id.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+int ovpn_get_mcast_id(dco_contex=
t_t *dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool dco_available(int msgle=
vel, dco_context_t *dco);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *d=
co_version_string(struct gc_arena *gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void dco_event_set(dco_context_t *dco, struct event_set *es, void *arg);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+const char *dco_get_supported_ciphers();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #=
endif /* defined(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX) */</span><br>=
<span> #endif /* ifndef DCO_LINUX_H */</span><br><span>diff --git a/src/ope=
nvpn/dco_linux_v2.c b/src/openvpn/dco_linux_v2.c</span><br><span>new file m=
ode 100644</span><br><span>index 0000000..6fc47fa</span><br><span>--- /dev/=
null</span><br><span>+++ b/src/openvpn/dco_linux_v2.c</span><br><span>@@ -0=
,0 +1,636 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Interface to linux d=
co networking code</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) =
2020-2024 Antonio Quartulli &lt;a@...2181...&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2020-2024 Arne Schwabe &lt;a=
rne@...1227...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  Copyright (C) 2020-2024 Gianmarco De Gregori &lt;gianmarco@...2726...&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) =
2020-2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  This program is free software; you can redistribute it and/or =
modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under =
the terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distribu=
ted in the hope that it will be useful,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied =
warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mo=
re details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have recei=
ved a copy of the GNU General Public License</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  along with this program (see the file COPYING =
included with this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  distribution); if not, write to the Free Software Foundation, Inc.,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  59 Temple Place, Sui=
te 330, Boston, MA  02111-1307  USA</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;dco_linux.h&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;errlevel.h&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer.h&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;networking.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;openvpn.h&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;socket.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;tun.h&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;ssl.h&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;fdmisc.h&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;multi.h&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_verify.h&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;ovpn_dco_linux.h&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;netlink/socket.h&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;netlink/netlink.h&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;netl=
ink/genl/genl.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;netlink/genl/family.h&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &lt;netlink/genl/ctrl.h&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+open_tun_dco_v2(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s&qu=
ot;, __func__, dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(tt-&gt;type =3D=3D DEV_TYPE_TUN);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int ret =3D net_iface_new(ctx, dev, &quot;ovpn-dco&quot;, &amp;t=
t-&gt;dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBU=
G, &quot;Cannot create DCO interface %s: %d&quot;, dev, ret);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return ret;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    tt-&gt;dco.ifindex =3D if_nametoindex(dev);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!tt-&gt;dco.ifindex)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;DCO: cannot re=
trieve ifindex for interface %s&quot;, dev);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tt-&=
gt;dco.dco_message_peer_id =3D -1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ovpn_dco_register(&amp;tt-&gt;dco);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static struct nl_msg *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_v2_nlmsg_create(dco_context_t *d=
co, int cmd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum ovpn_nl_commands=
 enum_cmd =3D (enum ovpn_nl_commands)cmd;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct nl_msg *nl_msg =3D nlmsg_alloc();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;cannot allocate netl=
ink message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    genlmsg_put(nl_msg, 0, 0, dc=
o-&gt;ovpn_dco_id, 0, 0, enum_cmd, 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_ATTR_IFINDEX, dco-&gt;ifind=
ex);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return nl_msg;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+nla_put_failure:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    nlmsg_free(nl_msg);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;cannot put i=
nto netlink message&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dco_v2_new_peer(dco_context_t *dco, unsigned int=
 peerid, int sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                struct in=
_addr *remote_in4, struct in6_addr *remote_in6)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *remotestr =3D &quot;[undefined]&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (remot=
eaddr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        remotestr =3D print=
_sockaddr(remoteaddr, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd %d, remote addr: %s&quot;, __fu=
nc__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        peerid=
, sd, remotestr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl_msg *nl=
_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_NEW_PEER);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *attr =3D nla_nest=
_start(nl_msg, OVPN_ATTR_NEW_PEER);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int ret =3D -EMSGSIZE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_PEER_ID, peerid);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_N=
EW_PEER_ATTR_SOCKET, sd);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set th=
e remote endpoint if defined (for UDP) */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (remoteaddr)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        remoteaddr =3D mapped_v4_to_v6(remoteaddr, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        int alen =3D af_ad=
dr_size(remoteaddr-&gt;sa_family);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE, alen, remoteaddr);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (localaddr)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        localaddr =3D mapped_v4_to_v6(localaddr, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (localaddr-&gt;sa_=
family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in_addr),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &=
amp;((struct sockaddr_in *)localaddr)-&gt;sin_addr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else if (localaddr-&gt;sa_family =3D=3D AF_=
INET6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            NLA_PUT(nl_=
msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in6_addr),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    &amp;((struct so=
ckaddr_in6 *)localaddr)-&gt;sin6_addr);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set the primary =
VPN IP addresses of the peer */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (remote_in4)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, remote_in4-&gt;s_addr);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (remote_in6)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6,=
 sizeof(struct in6_addr),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                remote_in6);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    nla_nest_end(nl_msg, attr);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
t =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+nla_put_failure:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    nlmsg_free(nl_msg);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+close_tun_dco_v2(struct tuntap *t=
t, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_D=
CO_DEBUG, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    net_iface_del(=
ctx, tt-&gt;actual_name);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ovpn_dco_uninit_netlink(&amp;tt-&gt;dco);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_v2_swap_keys(dc=
o_context_t *dco, unsigned int peerid)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peerid);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlm=
sg_create(dco, OVPN_CMD_SWAP_KEYS);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!nl_msg)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return -ENOMEM;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *attr =3D nl=
a_nest_start(nl_msg, OVPN_ATTR_SWAP_KEYS);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int ret =3D -EMSGSIZE;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR_P=
EER_ID, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 nla_nest_end(nl_msg, attr);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+nla_put_failure:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    nlmsg_free(nl_msg);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_v2_del_peer(dco_context_t *dco, unsigned int peerid)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id=
 %d&quot;, __func__, peerid);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_DEL_PEER);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return -ENOMEM;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_DEL_PEER)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -E=
MSGSIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT=
_U32(nl_msg, OVPN_DEL_PEER_ATTR_PEER_ID, peerid);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    nla_nest_end(nl_msg, attr);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL=
, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+nla_put_failure:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    nlmsg_free(nl_msg);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+dco_v2_del_key(dco_context=
_t *dco, unsigned int peerid,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+               dco_key_slot_t slot)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, slot %d&quot;, __func__,=
 peerid, slot);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl_msg *nl_m=
sg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_DEL_KEY);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return -ENOMEM;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_DEL_KEY);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -EMSGSIZE;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OV=
PN_DEL_KEY_ATTR_PEER_ID, peerid);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    NLA_PUT_U8(nl_msg, OVPN_DEL_KEY_ATTR_KEY_SLOT, slot);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_nest_end(nl_msg=
, attr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(d=
co, nl_msg, NULL, NULL, __func__);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+nla_=
put_failure:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nlm=
sg_free(nl_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dco_v2_new_key(dco_context_t *dco, unsigned int peerid, int =
keyid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
  dco_key_slot_t slot,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+               const uint8_t *encrypt_key, const uint8_t *encrypt_iv,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+               const u=
int8_t *decrypt_key, const uint8_t *decrypt_iv,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+               const char *ciphername)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id=
 %d, peer-id %d, cipher %s&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        __func__, slot, keyid, peerid, ciphername);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const size_t key_len =3D cipher_kt_key_size(=
ciphername);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st int nonce_tail_len =3D 8;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_NEW_KEY);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return -ENOMEM;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    dco_cipher_t dco_cipher =3D dco_get_cipher(ciphername);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int ret =3D -EMSGSIZE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *attr =3D nla_nest_star=
t(nl_msg, OVPN_ATTR_NEW_KEY);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_NEW_KEY_ATTR_PEER_ID, peerid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U8(nl_msg, OV=
PN_NEW_KEY_ATTR_KEY_SLOT, slot);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_ID, keyid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U16(nl_msg, O=
VPN_NEW_KEY_ATTR_CIPHER_ALG, dco_cipher);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct nlattr *key_enc =3D nla_nest_start(nl_msg,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
      OVPN_NEW_KEY_ATTR_ENCRYPT_KEY);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (dco_cipher !=3D OVPN_CIPHER_ALG_NONE)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIP=
HER_KEY, key_len, encrypt_key);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tai=
l_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   encrypt_iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_nest_end(n=
l_msg, key_enc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *key=
_dec =3D nla_nest_start(nl_msg,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                            OVPN_NEW_KEY_ATTR_D=
ECRYPT_KEY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(dco_cipher !=3D OVPN_CIPHER_ALG_NONE)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, decrypt=
_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        NLA_P=
UT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                decrypt_iv);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    nla_nest_end(nl_msg, key_dec);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    nla_nest_end(nl_msg, attr);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL=
, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+nla_put_failure:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    nlmsg_free(nl_msg);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_v2_=
set_peer(dco_context_t *dco, unsigned int peerid,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                int keepalive_interval, int k=
eepalive_timeout, int mss)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_D=
CO_DEBUG, &quot;%s: peer-id %d, keepalive %d/%d, mss %d&quot;, __func__,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        peerid, keepal=
ive_interval, keepalive_timeout, mss);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_SET_PE=
ER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return -ENOMEM;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR=
_SET_PEER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
ret =3D -EMSGSIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_PEER_ID, peerid);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_SET_PE=
ER_ATTR_KEEPALIVE_INTERVAL,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                keepalive_interval);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALI=
VE_TIMEOUT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        keepalive_timeout);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    nla_nest_end(nl_msg, attr);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, NULL, __func__);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+nla_put_failure:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    nlmsg_free(nl_msg);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* This funct=
ion parses any netlink message sent by ovpn-dco to userspace */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ovpn_v2_handle_msg(struct nl_msg *msg, v=
oid *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    dco_context_t *dco =3D a=
rg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct genlmsghdr *gnlh =3D nlm=
sg_data(nlmsg_hdr(msg));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct nlattr *attrs[OVPN_ATTR_MAX + 1];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct nlmsghdr *nlh =3D nlmsg_hdr(msg);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!genlmsg_valid_hdr(nlh, 0))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: in=
valid header&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (nla_parse(attrs, OVP=
N_ATTR_MAX, genlmsg_attrdata(gnlh, 0),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                  genlmsg_attrlen(gnlh, 0), NULL))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;received bogus=
 data from ovpn-dco&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return NL_SKIP;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we must know w=
hich interface this message is referring to in order to</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * avoid mixing messages for other =
instances</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_AT=
TR_IFINDEX])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &q=
uot;ovpn-dco: Received message without ifindex&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return NL_SKIP;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ifindex !=3D dco-=
&gt;ifindex)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEB=
UG,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;ovpn-dco: ignoring message (type=3D%d) for foreign ifindex %d&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            gnlh-&gt;cmd=
, ifindex);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* based on the message type, we =
parse the subobject contained in the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * message, that stores the type-specific attributes.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * the &quot;dco&quot; object=
 is then filled accordingly with the information</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * retrieved from the message, so that the=
 rest of the OpenVPN code can</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * react as need be.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    switch (gnlh-&gt;cmd)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case OVPN_CMD_DEL_PEER:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (!attrs[OVPN_ATTR_DEL_PEER])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                msg(D_DCO, &quot;ovpn-dco: no attributes in =
OVPN_DEL_PEER message&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                return NL_SKIP;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         struct nlattr *dp_attrs[OVPN_DEL_PEER_ATTR_MAX + 1];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (nla_parse_nested(=
dp_attrs, OVPN_DEL_PEER_ATTR_MAX,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                 attrs[OVPN_ATTR_DEL_PEER], N=
ULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
D_DCO, &quot;received bogus del peer packet data from ovpn-dco&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                return N=
L_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (!dp_attrs[OVPN_DEL_PE=
ER_ATTR_REASON])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       msg(D_DCO, &quot;ovpn-dco: no reason in DEL_PEER message&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                return =
NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!=
dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                msg(D_DCO, &quot;ovpn-dco: no peer-id in DEL_PE=
ER message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            int reason =3D nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_REAS=
ON]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            un=
signed int peerid =3D nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO_DEBUG, &quot;ovpn-d=
co: received CMD_DEL_PEER, ifindex: %d, peer-id %d, reason: %d&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                ifindex, =
peerid, reason);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         dco-&gt;dco_message_peer_id =3D peerid;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            dco-&gt;dco_del_peer_reason =3D re=
ason;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dc=
o-&gt;dco_message_type =3D OVPN_CMD_DEL_PEER;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO, &qu=
ot;ovpn-dco: received unknown command: %d&quot;, gnlh-&gt;cmd);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            dco-&gt;dco_message=
_type =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return NL_OK;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_v=
2_do_read(dco_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
D_DCO_DEBUG, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    nl_cb_set(dco-&gt;nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_v2_handle_=
msg, dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return ovpn_nl_recvmsgs(=
dco, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+dco_v2_update_peer_stat(struct context_2 *c2, str=
uct nlattr *tb[], uint32_t id)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(tb[OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        c2-&gt;dco_read_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RE=
SP_ATTR_LINK_RX_BYTES]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(D_DCO_DEBUG, &quot;%s / dco_read_bytes: &quot; counter_for=
mat, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       c2-&gt;dco_read_bytes);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s=
: no link RX bytes provided in reply for peer %u&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            __func__, id);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        c2-&gt;dco_write_bytes =3D nla_get_u64(t=
b[OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES]);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s / dco_write_bytes:=
 &quot; counter_format, __func__,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            c2-&gt;dco_write_bytes);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(M_WARN, &quot;%s: no link TX bytes provided in reply for peer %u&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            __func_=
_, id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYT=
ES])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        c2-&gt;tun_read_bytes=
 =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s /=
 tun_read_bytes: &quot; counter_format, __func__,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            c2-&gt;tun_read_bytes);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_WARN, &quot;%s: no VPN RX bytes provided in reply fo=
r peer %u&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         __func__, id);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (tb[OVPN_GET_PEER_RESP=
_ATTR_VPN_TX_BYTES])</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c2-&g=
t;tun_write_bytes =3D nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_=
DEBUG, &quot;%s / tun_write_bytes: &quot; counter_format, __func__,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            c2-&gt;tun_writ=
e_bytes);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s: no VPN TX bytes pro=
vided in reply for peer %u&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            __func__, id);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+dco_v2_parse_peer_multi(struct nl_msg *msg, vo=
id *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *tb[OVPN_AT=
TR_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: parsing message...&quot;, __f=
unc__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    nla_parse(tb, OVPN_ATTR_MAX=
, genlmsg_attrdata(gnlh, 0),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+              genlmsg_attrlen(gnlh, 0), NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!tb[OVPN_ATTR_GET_PEER])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return NL_SKIP;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl=
attr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    nla_parse(tb_peer, OVPN_GET_PEER_RESP_ATTR_MAX,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+              nla_data(tb[OVPN_ATT=
R_GET_PEER]),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
        nla_len(tb[OVPN_ATTR_GET_PEER]), NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s: no peer-id provided=
 in reply&quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return NL_SKIP;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_cont=
ext *m =3D arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (peer_id &gt;=3D m-&gt;max_clie=
nts || !m-&gt;instances[peer_id])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(M_WARN, &quot;%s: cannot store DCO stats for peer %u&quot;, __f=
unc__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            p=
eer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    dco_v2_update_peer_stat(&amp;m-&gt;i=
nstances[peer_id]-&gt;context.c2, tb_peer, peer_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return NL_OK;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+dco_v2_get_peer_stats_multi(dco_context_=
t *dco, struct multi_context *m)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg(D_DCO_DEBUG, &quot;%s&quot;, __func__);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_CMD_GE=
T_PEER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    nlmsg_hdr(nl_msg)-&gt;nlms=
g_flags |=3D NLM_F_DUMP;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D ovpn_nl_msg_send(dco, nl_msg, dco_v2_parse_peer_multi, m, __func__);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    nlmsg_free(nl_msg);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_v2_parse=
_peer(struct nl_msg *msg, void *arg)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct context *c =3D arg;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct nlattr *tb[OVPN_ATTR_MAX + 1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct genlmsghdr *gnlh =3D nlmsg_dat=
a(nlmsg_hdr(msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG,=
 &quot;%s: parsing message...&quot;, __func__);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    nla_parse(tb, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+              genlmsg_attr=
len(gnlh, 0), NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tb[OVPN_A=
TTR_GET_PEER])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_D=
EBUG, &quot;%s: malformed reply&quot;, __func__);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return NL_SKIP;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct nlattr *tb_peer[OVPN_GET_PEER_RESP_ATTR_MAX + 1];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    nla_parse(tb_peer, OVPN_GET_PEER_RESP_ATTR_MAX,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+              nla_da=
ta(tb[OVPN_ATTR_GET_PEER]),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+              nla_len(tb[OVPN_ATTR_GET_PEER]), NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s: no pe=
er-id provided in reply&quot;, __func__);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return NL_SKIP;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t32_t peer_id =3D nla_get_u32(tb_peer[OVPN_GET_PEER_RESP_ATTR_PEER_ID]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.tls_m=
ulti-&gt;dco_peer_id !=3D peer_id)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return NL_SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    dco_v2_update_peer_stat(=
&amp;c-&gt;c2, tb_peer, peer_id);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn NL_OK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dco_v2_get_peer_stats(struct context *c)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint32_t peer_id =3D c-&gt;c2.tls_multi-&gt;dco_peer_=
id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DE=
BUG, &quot;%s: peer-id %d&quot;, __func__, peer_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!c-&gt;c1.tuntap)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    dco_context_t *dco =3D &=
amp;c-&gt;c1.tuntap-&gt;dco;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct nl_msg *nl_msg =3D ovpn_dco_v2_nlmsg_create(dco, OVPN_C=
MD_GET_PEER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_ATTR_GET_PEER);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -EMSGSIZE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    NLA_PUT_U32(nl_msg, OVPN_GET_PEER_ATT=
R_PEER_ID, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    nla_nest_end(nl_msg, attr);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
t =3D ovpn_nl_msg_send(dco, nl_msg, dco_v2_parse_peer, c, __func__);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+nla_put_failure:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    nlmsg_free(nl_msg);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const stru=
ct dco_ops dco_ops_v2 =3D {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    .ovpn_dco_nlmsg_create =3D ovpn_dco_v2_nlmsg_create,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    .dco_new_peer =3D &amp;dco=
_v2_new_peer,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    .o=
pen_tun_dco =3D open_tun_dco_v2,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    .close_tun_dco =3D close_tun_dco_v2,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    .dco_swap_keys =3D &amp;dco_v2_swap_k=
eys,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    .dco_del_pe=
er =3D &amp;dco_v2_del_peer,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    .dco_del_key =3D &amp;dco_v2_del_key,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    .dco_new_key =3D &amp;dco_v2_new_key,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    .dco_set_peer =3D =
&amp;dco_v2_set_peer,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    .ovpn_handle_msg =3D &amp;ovpn_v2_handle_msg,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    .dco_do_read =3D &amp;dco_v2_do_read,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    .dco_update_pee=
r_stat =3D &amp;dco_v2_update_peer_stat,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    .dco_parse_peer_multi =3D &amp;dco_v2_parse_peer_m=
ulti,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    .dco_get_p=
eer_stats_multi =3D &amp;dco_v2_get_peer_stats_multi,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    .dco_parse_peer =3D &amp;dco_v2_parse=
_peer,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    .dco_get_=
peer_stats =3D &amp;dco_v2_get_peer_stats</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* defi=
ned(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX) */</span><br><span>diff --=
git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index e=
3ada76..65be766 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><b=
r><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -357,7 +357,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-dco_available(int msglevel)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+dco_available(int msglevel, dco_c=
ontext_t *dco)</span><br><span> {</span><br><span>     /* try to open devic=
e by symbolic name */</span><br><span>     HANDLE h =3D CreateFile(&quot;\\=
\\.\\ovpn-dco&quot;, GENERIC_READ | GENERIC_WRITE,</span><br><span>diff --g=
it a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index 01=
165b2..118c32a 100644</span><br><span>--- a/src/openvpn/forward.c</span><br=
><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1230,6 +1230,9 @@</s=
pan><br><span> process_incoming_dco(struct context *c)</span><br><span> {</=
span><br><span> #if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) |=
| defined(TARGET_FREEBSD))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int cmd_del_peer =3D OVPN_CMD_DEL_PEER;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int cmd_swap_keys =3D OVPN_CMD_SWAP_KEYS=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    dco_context_t *dco =3D &amp;c-&gt;c1.tuntap-&gt;dco;</span><br><span> <=
/span><br><span>     dco_do_read(dco);</span><br><span>@@ -1245,31 +1248,30=
 @@</span><br><span>         return;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (dco-&gt=
;dco_message_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (dco-&gt;dco_message_type =3D=3D cmd_del_peer)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case OVPN_CMD=
_DEL_PEER:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (dco-&gt;dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_EXPIRED)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                msg(D_DCO_DEBUG, &q=
uot;%s: received peer expired notification of for peer-id &quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;%d&quo=
t;, __func__, dco-&gt;dco_message_peer_id);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                trigger_ping_timeout_signal(c);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                return;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        case OVPN_CMD_SWAP_KEYS:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG, &quot;%s: receive=
d key rotation notification for peer-id %d&quot;,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                __func__, dco-&gt;dco_message_p=
eer_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            t=
ls_session_soft_reset(c-&gt;c2.tls_multi);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(D_DCO_DEBUG, &quot;%s: received message of type %u - ignoring&quot;=
, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      dco-&gt;dco_message_type);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (dco-&gt;dco_del_peer_reason =3D=3D OVPN_DEL_PEER_R=
EASON_EXPIRED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(D_DCO_DEBUG, &quot;%s: received peer expired notification of for peer-id &=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  &quot;%d&quot;, __func__, dco-&gt;dco_message_peer_id);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            trigger_ping_timeout_sign=
al(c);</span><br><span>             return;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else if (dco-&gt;dco_message_type =3D=3D cmd_swap_keys)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s: received key r=
otation notification for peer-id %d&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            __func__, dco-&gt;dco_message_peer_id);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_session_=
soft_reset(c-&gt;c2.tls_multi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &q=
uot;%s: received message of type %u - ignoring&quot;, __func__,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            dco-&gt;dco_message=
_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif /* if defined(ENABLE_DCO) &amp;&amp; (defined=
(TARGET_LINUX) || defined(TARGET_FREEBSD)) */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif /* #if defined(ENABLE_DCO) &amp;&amp; defi=
ned(TARGET_FREEBSD) */</span><br><span> }</span><br><span> </span><br><span=
> /*</span><br><span>diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvp=
n/ovpn_dco_linux.h</span><br><span>index 73e19b5..4d198db 100644</span><br>=
<span>--- a/src/openvpn/ovpn_dco_linux.h</span><br><span>+++ b/src/openvpn/=
ovpn_dco_linux.h</span><br><span>@@ -4,14 +4,15 @@</span><br><span>  *</spa=
n><br><span>  *  Copyright (C) 2019-2023 OpenVPN, Inc.</span><br><span>  *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Author:	James Yona=
n &lt;james@...515...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *		Antonio Quartulli &lt;antonio@...515...&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Author:     James Yonan &lt;james@...493...=
515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
       Antonio Quartulli &lt;antonio@...515...&gt;</span><br><span>  */</sp=
an><br><span> </span><br><span> #ifndef _UAPI_LINUX_OVPN_DCO_H_</span><br><=
span> #define _UAPI_LINUX_OVPN_DCO_H_</span><br><span> </span><br><span> #d=
efine OVPN_NL_NAME &quot;ovpn-dco-v2&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define OVPN_FAMILY_NAME        &quot;ovpn&quot;</sp=
an><br><span> </span><br><span> #define OVPN_NL_MULTICAST_GROUP_PEERS &quot=
;peers&quot;</span><br><span> </span><br><span>@@ -19,238 +20,238 @@</span>=
<br><span>  * enum ovpn_nl_commands - supported netlink commands</span><br>=
<span>  */</span><br><span> enum ovpn_nl_commands {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	/**</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	 * @OVPN_CMD_UNSPEC: unspecified command to catch errors</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	 */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_UNSPEC =3D 0,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * @OVPN_CMD_UNSPEC: unspecified command to c=
atch errors</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_UNSPEC =
=3D 0,</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 * @OVPN_CMD_=
NEW_PEER: Configure peer with its crypto keys</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	 */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	OVPN_CMD_NEW_PEER,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* @OVPN_CMD_NEW_PEER: Configure peer with its crypto keys</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    OVPN_CMD_NEW_PEER,</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	/**</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	 * @OVPN_CMD_SET_PEER: Tweak parameters for an=
 existing peer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_SET_PEER,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * @OVPN_CMD_SET_PEER: Tweak par=
ameters for an existing peer</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 OVPN_CMD_SET_PEER,</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
 * @OVPN_CMD_DEL_PEER: Remove peer from internal table</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	 */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	OVPN_CMD_DEL_PEER,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * @OVPN_CMD_DEL_PEER: Remove peer from internal table</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    OVPN_CMD_DEL_PEER,</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_NEW_KEY,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_NEW_KEY,</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CM=
D_SWAP_KEYS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_CMD_SWAP_KEYS,</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	OVPN_CMD_DEL_KEY,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    OVPN_CMD_DEL_KEY,</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	/**</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	 * @OVPN_CMD_GET_PEER: Retrieve the status of a peer or all=
 peers</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_GET_PEER,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * @OVPN_CMD_GET_PEER: Retrieve the stat=
us of a peer or all peers</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OV=
PN_CMD_GET_PEER,</span><br><span> };</span><br><span> </span><br><span> enu=
m ovpn_cipher_alg {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	/=
**</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 * @OVPN_CIPHER_AL=
G_NONE: No encryption - reserved for debugging only</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	 */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	OVPN_CIPHER_ALG_NONE =3D 0,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	/**</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	 * @OVPN_CIPHER_ALG_AES_GCM: AES-GCM AEAD cipher with any allowed key=
 size</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG_AES_GCM,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	/**</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	 * @OVPN_CIPHER_ALG_CHACHA20_POLY1305: ChaCha=
20Poly1305 AEAD cipher</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG=
_CHACHA20_POLY1305,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @OVPN_CIPHER_=
ALG_NONE: No encryption - reserved for debugging only</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    OVPN_CIPHER_ALG_NONE =3D 0,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @OVPN_CIPHER_ALG_AES_GCM: AES-GCM AEAD cipher with any all=
owed key size</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CIPHER_ALG_AE=
S_GCM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @OVPN_CIPHER_ALG_CHACHA20_=
POLY1305: ChaCha20Poly1305 AEAD cipher</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_CIPHER_ALG_CHACHA20_POLY1305,</span><br><span> };</span><br><sp=
an> </span><br><span> enum ovpn_del_peer_reason {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	__OVPN_DEL_PEER_REASON_FIRST,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_TEARDOWN =3D __O=
VPN_DEL_PEER_REASON_FIRST,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	OVPN_DEL_PEER_REASON_USERSPACE,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	OVPN_DEL_PEER_REASON_EXPIRED,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_TRANSPORT_D=
ISCONNECT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_DEL=
_PEER_REASON_AFTER_LAST</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    __OVPN_DEL_PEER_REASON_FIRST,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TEARDOWN =3D __OVPN_DEL_PEER_REA=
SON_FIRST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_=
DEL_PEER_REASON_USERSPACE,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OVPN_DEL_PEER_REASON_EXPIRED,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TRANSPO=
RT_DISCONNECT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    _=
_OVPN_DEL_PEER_REASON_AFTER_LAST</span><br><span> };</span><br><span> </spa=
n><br><span> enum ovpn_key_slot {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	__OVPN_KEY_SLOT_FIRST,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	OVPN_KEY_SLOT_PRIMARY =3D __OVPN_KEY_SLOT_FIRST,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_SLOT_SECONDARY,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_KEY_SLOT_AFTER_LAST,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_KEY_SLOT_=
FIRST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_KEY_=
SLOT_PRIMARY =3D __OVPN_KEY_SLOT_FIRST,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    OVPN_KEY_SLOT_SECONDARY,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    __OVPN_KEY_SLOT_AFTER_LAST,</span><br><spa=
n> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-enum ovpn_netlink_attrs {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	OVPN_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	OVPN_ATTR_IFINDEX,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	OVPN_ATTR_NEW_PEER,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	OVPN_ATTR_SET_PEER,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	OVPN_ATTR_DEL_PEER,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	OVPN_ATTR_NEW_KEY,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	OVPN_ATTR_SWAP_KEYS,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	OVPN_ATTR_DEL_KEY,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	OVPN_ATTR_GET_PEER,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+enum ovpn_v2_netlink_attrs {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    OVPN_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    OVPN_ATTR_IFINDEX,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    OVPN_ATTR_NEW_PEER,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    OVPN_ATTR_SET_PEER,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    OVPN_ATTR_DEL_PEER,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR_NEW_KEY,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR_SWAP_KEYS,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR_DEL_KEY,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR_GET_PEER,</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_AT=
TR_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A=
TTR_MAX =3D __OVPN_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    __OVPN_ATTR_AFTER_LAST,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OVPN_ATTR_MAX =3D __OVPN_ATTR_AFTER_LAST - =
1,</span><br><span> };</span><br><span> </span><br><span> enum ovpn_netlink=
_key_dir_attrs {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN=
_KEY_DIR_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	OVPN_KEY_DIR_ATTR_CIPHER_KEY,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	OVPN_KEY_DIR_ATTR_NONCE_TAIL,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    OVPN_KEY_DIR_ATTR_UNSPEC =3D 0,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    OVPN_KEY_DIR_ATTR_CIPHER_KEY,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_KEY_DIR_AT=
TR_NONCE_TAIL,</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	__OVPN_KEY_DIR_ATTR_AFTER_LAST,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	OVPN_KEY_DIR_ATTR_MAX =3D __OVPN_KEY_DIR_ATTR_AFTER_=
LAST - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN=
_KEY_DIR_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    OVPN_KEY_DIR_ATTR_MAX =3D __OVPN_KEY_DIR_ATTR_AFTER_LAST - 1,</sp=
an><br><span> };</span><br><span> </span><br><span> enum ovpn_netlink_new_k=
ey_attrs {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_K=
EY_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	OVPN_NEW_KEY_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	OVPN_NEW_KEY_ATTR_KEY_SLOT,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	OVPN_NEW_KEY_ATTR_KEY_ID,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_CIPHER_ALG,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_ENCRYPT_KEY,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_DECRYPT_KEY,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW_KEY_ATTR_UNSP=
EC =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_N=
EW_KEY_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    OVPN_NEW_KEY_ATTR_KEY_SLOT,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_NEW_KEY_ATTR_KEY_ID,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    OVPN_NEW_KEY_ATTR_CIPHER_ALG,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW_KEY_ATTR_ENCRYPT_KEY,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW_KEY_ATTR_D=
ECRYPT_KEY,</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	__OVPN_NEW_KEY_ATTR_AFTER_LAST,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_MAX =3D __OVPN_NEW_KEY_ATTR_AFTER_LAS=
T - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_NE=
W_KEY_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_NEW_KEY_ATTR_MAX =3D __OVPN_NEW_KEY_ATTR_AFTER_LAST - 1,</span>=
<br><span> };</span><br><span> </span><br><span> enum ovpn_netlink_del_key_=
attrs {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_KEY_=
ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OV=
PN_DEL_KEY_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	OVPN_DEL_KEY_ATTR_KEY_SLOT,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    OVPN_DEL_KEY_ATTR_UNSPEC =3D 0,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OVPN_DEL_KEY_ATTR_PEER_ID,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_KEY_ATTR_KEY_SLOT,</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_=
DEL_KEY_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	OVPN_DEL_KEY_ATTR_MAX =3D __OVPN_DEL_KEY_ATTR_AFTER_LAST - 1,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_DEL_KEY_ATTR_AFTER=
_LAST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_=
KEY_ATTR_MAX =3D __OVPN_DEL_KEY_ATTR_AFTER_LAST - 1,</span><br><span> };</s=
pan><br><span> </span><br><span> enum ovpn_netlink_swap_keys_attrs {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_SWAP_KEYS_ATTR_UNSPEC =
=3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_SWAP_KEYS=
_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    O=
VPN_SWAP_KEYS_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_SWAP_KEYS_ATTR_PEER_ID,</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_SWAP_KEYS_ATTR_AFTER_LAST=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_SWAP_KEYS_ATTR=
_MAX =3D __OVPN_SWAP_KEYS_ATTR_AFTER_LAST - 1,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    __OVPN_SWAP_KEYS_ATTR_AFTER_LAST,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_SWAP_KEYS_ATTR_MAX =
=3D __OVPN_SWAP_KEYS_ATTR_AFTER_LAST - 1,</span><br><span> </span><br><span=
> };</span><br><span> </span><br><span> enum ovpn_netlink_new_peer_attrs {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_UN=
SPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_=
PEER_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OV=
PN_NEW_PEER_ATTR_SOCKADDR_REMOTE,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	OVPN_NEW_PEER_ATTR_SOCKET,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_IPV4,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_IPV6,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_LOCAL_IP,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW_PEER_ATTR_UNSPEC =3D 0,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW_PEER_ATTR=
_PEER_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_N=
EW_PEER_ATTR_SOCKADDR_REMOTE,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    OVPN_NEW_PEER_ATTR_SOCKET,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    OVPN_NEW_PEER_ATTR_IPV4,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OVPN_NEW_PEER_ATTR_IPV6,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW_PEER_ATTR_LOCAL_IP,</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN=
_NEW_PEER_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	OVPN_NEW_PEER_ATTR_MAX =3D __OVPN_NEW_PEER_ATTR_AFTER_LAST - 1,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_NEW_PEER_ATTR_=
AFTER_LAST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN=
_NEW_PEER_ATTR_MAX =3D __OVPN_NEW_PEER_ATTR_AFTER_LAST - 1,</span><br><span=
> };</span><br><span> </span><br><span> enum ovpn_netlink_set_peer_attrs {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_SET_PEER_ATTR_UN=
SPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_SET_=
PEER_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OV=
PN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_SET_PEER_ATTR_UNSPEC =3D 0,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_SET_PEER_ATTR_P=
EER_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_SET=
_PEER_ATTR_KEEPALIVE_INTERVAL,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_SET_PEER_ATTR_AFTE=
R_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_SET_PEER=
_ATTR_MAX =3D __OVPN_SET_PEER_ATTR_AFTER_LAST - 1,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    __OVPN_SET_PEER_ATTR_AFTER_LAST,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_SET_PEER_ATTR_MAX =
=3D __OVPN_SET_PEER_ATTR_AFTER_LAST - 1,</span><br><span> };</span><br><spa=
n> </span><br><span> enum ovpn_netlink_del_peer_attrs {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_ATTR_UNSPEC =3D 0,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_ATTR_REASON,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_ATTR_PEE=
R_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_P=
EER_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_DEL_PEER_ATTR_REASON,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    OVPN_DEL_PEER_ATTR_PEER_ID,</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_DEL_PEER_ATTR_AFTER_LAST,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_ATTR_M=
AX =3D __OVPN_DEL_PEER_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    __OVPN_DEL_PEER_ATTR_AFTER_LAST,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_ATTR_MAX =3D __O=
VPN_DEL_PEER_ATTR_AFTER_LAST - 1,</span><br><span> };</span><br><span> </sp=
an><br><span> enum ovpn_netlink_get_peer_attrs {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_ATTR_UNSPEC =3D 0,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_ATTR_PEER_ID,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_ATTR_UNSP=
EC =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_G=
ET_PEER_ATTR_PEER_ID,</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	__OVPN_GET_PEER_ATTR_AFTER_LAST,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_ATTR_MAX =3D __OVPN_GET_PEER=
_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    __OVPN_GET_PEER_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    OVPN_GET_PEER_ATTR_MAX =3D __OVPN_GET_PEER_ATTR_AFTE=
R_LAST - 1,</span><br><span> };</span><br><span> </span><br><span> enum ovp=
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
SP_ATTR_LINK_TX_PACKETS,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_GET_PEER_RESP_ATTR_UNSPEC =3D 0,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_PEER_ID,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_SOC=
KADDR_REMOTE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OV=
PN_GET_PEER_RESP_ATTR_IPV4,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    OVPN_GET_PEER_RESP_ATTR_IPV6,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_LOCAL_IP,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_LOCAL_P=
ORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PE=
ER_RESP_ATTR_KEEPALIVE_INTERVAL,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_TIMEOUT,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_VPN_RX_=
BYTES,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_=
PEER_RESP_ATTR_VPN_TX_BYTES,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    OVPN_GET_PEER_RESP_ATTR_VPN_RX_PACKETS,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_VPN_TX_PACKET=
S,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER=
_RESP_ATTR_LINK_RX_BYTES,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_LINK_RX_PACKETS,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RES=
P_ATTR_LINK_TX_PACKETS,</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	__OVPN_GET_PEER_RESP_ATTR_AFTER_LAST,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_MAX =3D __OVP=
N_GET_PEER_RESP_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_MAX =3D =
__OVPN_GET_PEER_RESP_ATTR_AFTER_LAST - 1,</span><br><span> };</span><br><sp=
an> </span><br><span> enum ovpn_netlink_peer_stats_attrs {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_STATS_ATTR_UNSPEC =3D 0,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_STATS_BYTES,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_STATS_PACKE=
TS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_ST=
ATS_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_PEER_STATS_BYTES,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    OVPN_PEER_STATS_PACKETS,</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	__OVPN_PEER_STATS_ATTR_AFTER_LAST,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_STATS_ATTR_MAX =
=3D __OVPN_PEER_STATS_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    __OVPN_PEER_STATS_ATTR_AFTER_LAST,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_STATS_ATTR_MAX =3D =
__OVPN_PEER_STATS_ATTR_AFTER_LAST - 1,</span><br><span> };</span><br><span>=
 </span><br><span> enum ovpn_netlink_peer_attrs {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_UNSPEC =3D 0,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_PEER_ID,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_SOCKADDR_REMOTE,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_IPV4,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_IPV6,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_LOCAL_IP,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_KEEPA=
LIVE_INTERVAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_P=
EER_ATTR_KEEPALIVE_TIMEOUT,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	OVPN_PEER_ATTR_ENCRYPT_KEY,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	OVPN_PEER_ATTR_DECRYPT_KEY,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	OVPN_PEER_ATTR_RX_STATS,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_TX_STATS,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OVPN_PEER_ATTR_UNSPEC =3D 0,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_ATTR_PEER_ID,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_ATTR_SOCKA=
DDR_REMOTE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN=
_PEER_ATTR_IPV4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 OVPN_PEER_ATTR_IPV6,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    OVPN_PEER_ATTR_LOCAL_IP,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    OVPN_PEER_ATTR_KEEPALIVE_INTERVAL,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OVPN_PEER_ATTR_KEEPALIVE_TIMEOUT,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_ATTR_ENCRYPT_=
KEY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_A=
TTR_DECRYPT_KEY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 OVPN_PEER_ATTR_RX_STATS,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    OVPN_PEER_ATTR_TX_STATS,</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	__OVPN_PEER_ATTR_AFTER_LAST,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_MAX =3D __OVPN_PEER=
_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    __OVPN_PEER_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    OVPN_PEER_ATTR_MAX =3D __OVPN_PEER_ATTR_AFTER_LAST - 1,<=
/span><br><span> };</span><br><span> </span><br><span> enum ovpn_netlink_pa=
cket_attrs {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PAC=
KET_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	OVPN_PACKET_ATTR_PACKET,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	OVPN_PACKET_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    OVPN_PACKET_ATTR_UNSPEC =3D 0,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    OVPN_PACKET_ATTR_PACKET,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    OVPN_PACKET_ATTR_PEER_ID,</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_PACKE=
T_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OV=
PN_PACKET_ATTR_MAX =3D __OVPN_PACKET_ATTR_AFTER_LAST - 1,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    __OVPN_PACKET_ATTR_AFTER_LAST,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PACKET_ATTR_M=
AX =3D __OVPN_PACKET_ATTR_AFTER_LAST - 1,</span><br><span> };</span><br><sp=
an> </span><br><span> enum ovpn_ifla_attrs {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	IFLA_OVPN_UNSPEC =3D 0,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	IFLA_OVPN_MODE,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    IFLA_OVPN_UNSPEC =3D 0,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    IFLA_OVPN_MODE,</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	__IFLA_OVPN_AFTER_LAST,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	IFLA_OVPN_MAX =3D __IFLA=
_OVPN_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    __IFLA_OVPN_AFTER_LAST,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,</span><br><span=
> };</span><br><span> </span><br><span> enum ovpn_mode {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	__OVPN_MODE_FIRST =3D 0,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_MODE_P2P =3D __OVPN_MODE_FIRST=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_MODE_MP,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_MODE_FIRST =3D=
 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE_P2=
P =3D __OVPN_MODE_FIRST,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_MODE_MP,</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	__OVPN_MODE_AFTER_LAST,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    __OVPN_MODE_AFTER_LAST,</span><br><span> };</sp=
an><br><span> </span><br><span> #endif /* _UAPI_LINUX_OVPN_DCO_H_ */</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/661?usp=3Demail">change 661</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/661?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6662605b60d4859949970cfe256=
c55cbcbd4a672 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 661 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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

</body></html>=

--qMxNiFmUErI=--

