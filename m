From: "mrbff (Code Review)" <gerrit@...515...>
Date: Thu, 18 Dec 2025 15:20:10 +0000
References: <gerrit.1766071205000.I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <093e7078915f3182b53d524f2f83b8ae3d40331c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KPOuYXB9uPw="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: add DCO
 and iroutes support on server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KPOuYXB9uPw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1450?usp=3Demail

to review the following change.


Change subject: PUSH_UPDATE: add DCO and iroutes support on server
......................................................................

PUSH_UPDATE: add DCO and iroutes support on server

Renamed update_vhash() to update_vaddr().
Moved the -ifconfig logic from send_single_push_update() to update_vaddr().
Changed canary logic to use the current value of ifconfig (if present) as
canary. Added logic in the update_vaddr() to not unlearn and re-learn the s=
ame
address.

Added logic to update the peer's virtual address(es) in the DCO to the curr=
ent
value(s) after sending a PUSH_UPDATE message on Linux.
Added dco_multi_update_peer_addr() and dco_update_peer_addr() to do so.

Added logic to update iroutes after changing the peer's virtual address(es).
Divided dco_delete_iroutes() in _v4() and _v6() to better updating iroutes.

Change-Id: I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/dco.c
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/test_push_update_msg.c
9 files changed, 377 insertions(+), 142 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/1450/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 6a1a5c9..eccfac2 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -658,6 +658,41 @@
     return 0;
 }

+int
+dco_multi_update_peer_addr(struct multi_context *m, struct multi_instance =
*mi, int flags)
+{
+    if (!flags)
+    {
+        return 0;
+    }
+
+    struct context *c =3D &mi->context;
+    int peer_id =3D c->c2.tls_multi->dco_peer_id;
+
+    /* In server mode we need to fetch the remote addresses from the push =
config */
+    struct in_addr vpn_ip4 =3D { 0 };
+    struct in_addr *vpn_addr4 =3D NULL;
+    if (c->c2.push_ifconfig_defined)
+    {
+        vpn_ip4.s_addr =3D htonl(c->c2.push_ifconfig_local);
+        vpn_addr4 =3D &vpn_ip4;
+    }
+
+    struct in6_addr *vpn_addr6 =3D NULL;
+    if (c->c2.push_ifconfig_ipv6_defined)
+    {
+        vpn_addr6 =3D &c->c2.push_ifconfig_ipv6_local;
+    }
+
+    int ret =3D dco_update_peer_addr(&c->c1.tuntap->dco, peer_id, vpn_addr=
4, vpn_addr6, flags);
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+    return 0;
+}
+
 void
 dco_install_iroute(struct multi_context *m, struct multi_instance *mi, str=
uct mroute_addr *addr)
 {
@@ -723,7 +758,7 @@
 }

 void
-dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+dco_delete_iroutes_v4(struct multi_context *m, struct multi_instance *mi)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&m->top.options))
@@ -734,7 +769,7 @@

     struct context *c =3D &mi->context;

-    if (mi->context.c2.push_ifconfig_defined)
+    if (c->c2.push_ifconfig_defined)
     {
         for (const struct iroute *ir =3D c->options.iroutes; ir; ir =3D ir=
->next)
         {
@@ -742,7 +777,7 @@
             dco_win_del_iroute_ipv4(&c->c1.tuntap->dco, htonl(ir->network)=
, ir->netbits);
 #else
             net_route_v4_del(&m->top.net_ctx, &ir->network, ir->netbits,
-                             &mi->context.c2.push_ifconfig_local, c->c1.tu=
ntap->actual_name, 0,
+                             &c->c2.push_ifconfig_local, c->c1.tuntap->act=
ual_name, 0,
                              DCO_IROUTE_METRIC);
 #endif
         }
@@ -750,7 +785,7 @@
 #if !defined(_WIN32)
         /* Check if we added a host route as the assigned client IP addres=
s was
          * not in the on link scope defined by --ifconfig */
-        in_addr_t ifconfig_local =3D mi->context.c2.push_ifconfig_local;
+        in_addr_t ifconfig_local =3D c->c2.push_ifconfig_local;

         if (multi_check_push_ifconfig_extra_route(mi, htonl(ifconfig_local=
)))
         {
@@ -761,8 +796,22 @@
         }
 #endif
     }
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_=
WIN32) */
+}

-    if (mi->context.c2.push_ifconfig_ipv6_defined)
+void
+dco_delete_iroutes_v6(struct multi_context *m, struct multi_instance *mi)
+{
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
+    if (!dco_enabled(&m->top.options))
+    {
+        return;
+    }
+    ASSERT(TUNNEL_TYPE(mi->context.c1.tuntap) =3D=3D DEV_TYPE_TUN);
+
+    struct context *c =3D &mi->context;
+
+    if (c->c2.push_ifconfig_ipv6_defined)
     {
         for (const struct iroute_ipv6 *ir6 =3D c->options.iroutes_ipv6; ir=
6; ir6 =3D ir6->next)
         {
@@ -770,7 +819,7 @@
             dco_win_del_iroute_ipv6(&c->c1.tuntap->dco, ir6->network, ir6-=
>netbits);
 #else
             net_route_v6_del(&m->top.net_ctx, &ir6->network, ir6->netbits,
-                             &mi->context.c2.push_ifconfig_ipv6_local, c->=
c1.tuntap->actual_name, 0,
+                             &c->c2.push_ifconfig_ipv6_local, c->c1.tuntap=
->actual_name, 0,
                              DCO_IROUTE_METRIC);
 #endif
         }
@@ -778,7 +827,7 @@
         /* Checked if we added a host route as the assigned client IP addr=
ess was
          * outside the --ifconfig-ipv6 tun interface config */
 #if !defined(_WIN32)
-        struct in6_addr *dest =3D &mi->context.c2.push_ifconfig_ipv6_local;
+        struct in6_addr *dest =3D &c->c2.push_ifconfig_ipv6_local;
         if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))
         {
             /* On windows we do not install these routes, so we also do no=
t need to delete them */
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index cd6e32a..3bc28a8 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -191,6 +191,30 @@
                  int keepalive_timeout, int mss);

 /**
+ * Update the peer's virtual address(es) in the DCO to the current value(s)
+ *
+ * @param dco       DCO device contect
+ * @param peerid    the ID of the peer to be modified
+ * @param vpn_ipv4  new IPv4 or NULL to remove the outdated one, only used=
 when `(1 << AF_INET)` flag is present
+ * @param vpn_ipv6  new IPv6 or NULL to remove the outdated one, only used=
 when `(1 << AF_INET6)` flag is present
+ * @param flags     `(1 << AF_INET)`, `(1 << AF_INET6)` or `(1 << AF_INET)=
 | (1 << AF_INET6)` depending on wich address has changed
+ * @return int      the DCO message status on success or a negative error =
code otherwise
+ */
+int
+dco_update_peer_addr(dco_context_t *dco, unsigned int peerid, struct in_ad=
dr *vpn_ipv4, struct in6_addr *vpn_ipv6, int flags);
+
+/**
+ * Update the peer's virtual address(es) in the DCO to the current value(s)
+ *
+ * @param m         server multi context
+ * @param mi        peer multi instnace
+ * @param flags     `(1 << AF_INET)`, `(1 << AF_INET6)` or `(1 << AF_INET)=
 | (1 << AF_INET6)` depending on wich address has changed
+ * @return int      0 on success or a negative error code otherwise
+ */
+int
+dco_multi_update_peer_addr(struct multi_context *m, struct multi_instance =
*mi, int flags);
+
+/**
  * Remove a peer from DCO
  *
  * @param c         the main instance context of the peer to remove
@@ -218,12 +242,20 @@
                         struct mroute_addr *addr);

 /**
- * Remove all routes added through the specified client
+ * Remove all IPv4 routes added through the specified client
  *
  * @param m         the server context
  * @param mi        the client instance for which routes have to be removed
  */
-void dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi=
);
+void dco_delete_iroutes_v4(struct multi_context *m, struct multi_instance =
*mi);
+
+/**
+ * Remove all IPv6 routes added through the specified client
+ *
+ * @param m         the server context
+ * @param mi        the client instance for which routes have to be removed
+ */
+void dco_delete_iroutes_v6(struct multi_context *m, struct multi_instance =
*mi);

 /**
  * Update traffic statistics for all peers
@@ -361,7 +393,12 @@
 }

 static inline void
-dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+dco_delete_iroutes_v4(struct multi_context *m, struct multi_instance *mi)
+{
+}
+
+static inline void
+dco_delete_iroutes_v6(struct multi_context *m, struct multi_instance *mi)
 {
 }

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index d1ad092..6bee21b 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -559,6 +559,12 @@
     return ret;
 }

+int
+dco_update_peer_addr(dco_context_t *dco, unsigned int peerid, struct in_ad=
dr *vpn_ipv4, struct in6_addr *vpn_ipv6, int flags)
+{
+    return 0
+}
+
 static void
 dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlis=
t_t *nvl)
 {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 2664029..eb9e4f9 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -684,6 +684,50 @@
     return ret;
 }

+int
+dco_update_peer_addr(dco_context_t *dco, unsigned int peerid, struct in_ad=
dr *vpn_ipv4, struct in6_addr *vpn_ipv6, int flags)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+
+    if (!flags)
+    {
+        return 0;
+    }
+
+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_SET=
);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
+    int ret =3D -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
+
+    if (flags & (1 << AF_INET))
+    {
+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_VPN_IPV4, vpn_ipv4 ? vpn_ipv4->s_a=
ddr : 0);
+    }
+
+    if (flags & (1 << AF_INET6))
+    {
+        struct in6_addr addr6;
+        if (!vpn_ipv6)
+        {
+            CLEAR(addr6);
+            vpn_ipv6 =3D &addr6;
+        }
+        NLA_PUT(nl_msg, OVPN_A_PEER_VPN_IPV6, sizeof(struct in6_addr), vpn=
_ipv6);
+    }
+
+    nla_nest_end(nl_msg, attr);
+    ret =3D ovpn_nl_msg_send(dco, nl_msg, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
 /* This function parses the reply provided by the kernel to the CTRL_CMD_G=
ETFAMILY
  * message. We parse the reply and we retrieve the multicast group ID asso=
ciated
  * with the "ovpn-dco" netlink family.
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 94f043f..6a1806d 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -526,6 +526,12 @@
 }
=20
 int
+dco_update_peer_addr(dco_context_t *dco, unsigned int peerid, struct in_ad=
dr *vpn_ipv4, struct in6_addr *vpn_ipv6, int flags)
+{
+    return 0
+}
+
+int
 dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_sl=
ot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const u=
int8_t *decrypt_key,
             const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 329d0a3..878871f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -476,6 +476,40 @@
     set_prefix(mi);
 }

+static void
+multi_del_iroutes_v4(struct multi_context *m, struct multi_instance *mi)
+{
+    if (TUNNEL_TYPE(mi->context.c1.tuntap) !=3D DEV_TYPE_TUN)
+    {
+        return;
+    }
+
+    const struct iroute *ir;
+
+    dco_delete_iroutes_v4(m, mi);
+    for (ir =3D mi->context.options.iroutes; ir !=3D NULL; ir =3D ir->next)
+    {
+        mroute_helper_del_iroute46(m->route_helper, ir->netbits);
+    }
+}
+
+static void
+multi_del_iroutes_v6(struct multi_context *m, struct multi_instance *mi)
+{
+    if (TUNNEL_TYPE(mi->context.c1.tuntap) !=3D DEV_TYPE_TUN)
+    {
+        return;
+    }
+
+    const struct iroute_ipv6 *ir6;
+
+    dco_delete_iroutes_v6(m, mi);
+    for (ir6 =3D mi->context.options.iroutes_ipv6; ir6 !=3D NULL; ir6 =3D =
ir6->next)
+    {
+        mroute_helper_del_iroute46(m->route_helper, ir6->netbits);
+    }
+}
+
 /*
  * Tell the route helper about deleted iroutes so
  * that it can update its mask of currently used
@@ -484,23 +518,8 @@
 static void
 multi_del_iroutes(struct multi_context *m, struct multi_instance *mi)
 {
-    const struct iroute *ir;
-    const struct iroute_ipv6 *ir6;
-
-    dco_delete_iroutes(m, mi);
-
-    if (TUNNEL_TYPE(mi->context.c1.tuntap) =3D=3D DEV_TYPE_TUN)
-    {
-        for (ir =3D mi->context.options.iroutes; ir !=3D NULL; ir =3D ir->=
next)
-        {
-            mroute_helper_del_iroute46(m->route_helper, ir->netbits);
-        }
-
-        for (ir6 =3D mi->context.options.iroutes_ipv6; ir6 !=3D NULL; ir6 =
=3D ir6->next)
-        {
-            mroute_helper_del_iroute46(m->route_helper, ir6->netbits);
-        }
-    }
+    multi_del_iroutes_v4(m, mi);
+    multi_del_iroutes_v6(m, mi);
 }

 static void
@@ -1282,6 +1301,64 @@
     return owner;
 }

+static void
+multi_add_iroutes_v4(struct multi_context *m, struct multi_instance *mi)
+{
+    if (TUNNEL_TYPE(mi->context.c1.tuntap) !=3D DEV_TYPE_TUN)
+    {
+        return;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    const struct iroute *ir;
+
+    mi->did_iroutes =3D true;
+    for (ir =3D mi->context.options.iroutes; ir !=3D NULL; ir =3D ir->next)
+    {
+        if (ir->netbits >=3D 0)
+        {
+            msg(D_MULTI_LOW, "MULTI: internal route %s/%d -> %s",
+                print_in_addr_t(ir->network, 0, &gc), ir->netbits,
+                multi_instance_string(mi, false, &gc));
+        }
+        else
+        {
+            msg(D_MULTI_LOW, "MULTI: internal route %s -> %s",
+                print_in_addr_t(ir->network, 0, &gc), multi_instance_strin=
g(mi, false, &gc));
+        }
+
+        mroute_helper_add_iroute46(m->route_helper, ir->netbits);
+
+        multi_learn_in_addr_t(m, mi, ir->network, ir->netbits, false);
+    }
+    gc_free(&gc);
+}
+
+static void
+multi_add_iroutes_v6(struct multi_context *m, struct multi_instance *mi)
+{
+    if (TUNNEL_TYPE(mi->context.c1.tuntap) !=3D DEV_TYPE_TUN)
+    {
+        return;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    const struct iroute_ipv6 *ir6;
+
+    mi->did_iroutes =3D true;
+    for (ir6 =3D mi->context.options.iroutes_ipv6; ir6 !=3D NULL; ir6 =3D =
ir6->next)
+    {
+        msg(D_MULTI_LOW, "MULTI: internal route %s/%d -> %s",
+            print_in6_addr(ir6->network, 0, &gc), ir6->netbits,
+            multi_instance_string(mi, false, &gc));
+
+        mroute_helper_add_iroute46(m->route_helper, ir6->netbits);
+
+        multi_learn_in6_addr(m, mi, ir6->network, ir6->netbits, false);
+    }
+    gc_free(&gc);
+}
+
 /*
  * A new client has connected, add routes (server -> client)
  * to internal routing table.
@@ -1289,42 +1366,8 @@
 static void
 multi_add_iroutes(struct multi_context *m, struct multi_instance *mi)
 {
-    struct gc_arena gc =3D gc_new();
-    const struct iroute *ir;
-    const struct iroute_ipv6 *ir6;
-    if (TUNNEL_TYPE(mi->context.c1.tuntap) =3D=3D DEV_TYPE_TUN)
-    {
-        mi->did_iroutes =3D true;
-        for (ir =3D mi->context.options.iroutes; ir !=3D NULL; ir =3D ir->=
next)
-        {
-            if (ir->netbits >=3D 0)
-            {
-                msg(D_MULTI_LOW, "MULTI: internal route %s/%d -> %s",
-                    print_in_addr_t(ir->network, 0, &gc), ir->netbits,
-                    multi_instance_string(mi, false, &gc));
-            }
-            else
-            {
-                msg(D_MULTI_LOW, "MULTI: internal route %s -> %s",
-                    print_in_addr_t(ir->network, 0, &gc), multi_instance_s=
tring(mi, false, &gc));
-            }
-
-            mroute_helper_add_iroute46(m->route_helper, ir->netbits);
-
-            multi_learn_in_addr_t(m, mi, ir->network, ir->netbits, false);
-        }
-        for (ir6 =3D mi->context.options.iroutes_ipv6; ir6 !=3D NULL; ir6 =
=3D ir6->next)
-        {
-            msg(D_MULTI_LOW, "MULTI: internal route %s/%d -> %s",
-                print_in6_addr(ir6->network, 0, &gc), ir6->netbits,
-                multi_instance_string(mi, false, &gc));
-
-            mroute_helper_add_iroute46(m->route_helper, ir6->netbits);
-
-            multi_learn_in6_addr(m, mi, ir6->network, ir6->netbits, false);
-        }
-    }
-    gc_free(&gc);
+    multi_add_iroutes_v4(m, mi);
+    multi_add_iroutes_v6(m, mi);
 }

 /*
@@ -4327,9 +4370,10 @@
 }

 /* Function to unlearn previous ifconfig of a client in the server multi_c=
ontext after a PUSH_UPDATE */
-void
+static void
 unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)
 {
+    multi_del_iroutes_v4(m, mi);
     in_addr_t old_addr =3D 0;
     old_addr =3D htonl(mi->context.c2.push_ifconfig_local);
     multi_unlearn_in_addr_t(m, mi, old_addr);
@@ -4339,9 +4383,10 @@
 }

 /* Function to unlearn previous ifconfig-ipv6 of a client in the server mu=
lti_context after a PUSH_UPDATE */
-void
+static void
 unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)
 {
+    multi_del_iroutes_v6(m, mi);
     struct in6_addr old_addr6;
     CLEAR(old_addr6);
     old_addr6 =3D mi->context.c2.push_ifconfig_ipv6_local;
@@ -4352,59 +4397,118 @@
 }

 /**
- * Update the vhash with new IP/IPv6 addresses in the multi_context when a
- * push-update message containing ifconfig/ifconfig-ipv6 options is sent
- * from the server.
+ * When a push-update message containing ifconfig/ifconfig-ipv6 options is=
 sent
+ * from the server, update the vhash with new IP/IPv6 addresses in the
+ * multi_context and update the virtual peer addresses in the DCO.
+ * Also remove the iroutes and readd it with the new IP if needed.
  *
  * @param m         The multi_context
  * @param mi        The multi_instance of the client we are updating
- * @param new_ip    The new IPv4 address or NULL if no change
- * @param new_ipv6  The new IPv6 address or NULL if no change
+ * @param new_ip    The new IPv4 address, NULL for -ifconfig or the curren=
t IPv4 if no change
+ * @param new_ipv6  The new IPv6 address, NULL for -ifconfig-ipv6 or the c=
urrent IPv6 if no change
  */
 void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *new_ip, const char *new_ipv6)
+update_vaddr(struct multi_context *m, struct multi_instance *mi, const cha=
r *new_ip, const char *new_ipv6)
 {
+    /* to avoid resetting an IP to its current value, the dco_update_peer_=
addr() function used to update the DCO,
+     * needs to know if actually an IPv4 or an IPv6 has been modified
+     */
+    int update_flags =3D 0;
+
+    /* -ifconfig */
+    if (!new_ip && mi->context.c2.push_ifconfig_defined)
+    {
+        unlearn_ifconfig(m, mi);
+        update_flags |=3D (1 << AF_INET);
+    }
+    /* -ifconfig-ipv6 */
+    if (!new_ipv6 && mi->context.c2.push_ifconfig_ipv6_defined)
+    {
+        unlearn_ifconfig_ipv6(m, mi);
+        update_flags |=3D (1 << AF_INET6);
+    }
+
     if (new_ip)
     {
-        /* Remove old IP */
-        if (mi->context.c2.push_ifconfig_defined)
-        {
-            unlearn_ifconfig(m, mi);
-        }
-
-        /* Add new IP */
         struct in_addr new_addr;
         CLEAR(new_addr);
-        if (inet_pton(AF_INET, new_ip, &new_addr) =3D=3D 1
-            && multi_learn_in_addr_t(m, mi, ntohl(new_addr.s_addr), -1, tr=
ue))
+        if (inet_pton(AF_INET, new_ip, &new_addr) =3D=3D 1)
         {
-            mi->context.c2.push_ifconfig_defined =3D true;
-            mi->context.c2.push_ifconfig_local =3D ntohl(new_addr.s_addr);
-            /* set our client's VPN endpoint for status reporting purposes=
 */
-            mi->reporting_addr =3D mi->context.c2.push_ifconfig_local;
+            new_addr.s_addr =3D ntohl(new_addr.s_addr);
+            /* if no previous IP or the new IP is different */
+            if (!mi->context.c2.push_ifconfig_defined
+                || (mi->context.c2.push_ifconfig_defined
+                    && new_addr.s_addr !=3D mi->context.c2.push_ifconfig_l=
ocal))
+            {
+                /* Remove old IP */
+                if (mi->context.c2.push_ifconfig_defined)
+                {
+                    unlearn_ifconfig(m, mi);
+                }
+
+                /* Add new IP */
+                if (multi_learn_in_addr_t(m, mi, new_addr.s_addr, -1, true=
))
+                {
+                    mi->context.c2.push_ifconfig_defined =3D true;
+                    mi->context.c2.push_ifconfig_local =3D new_addr.s_addr;
+                    /* set our client's VPN endpoint for status reporting =
purposes */
+                    mi->reporting_addr =3D mi->context.c2.push_ifconfig_lo=
cal;
+                    update_flags |=3D (1 << AF_INET);
+                }
+            }
         }
     }

     if (new_ipv6)
     {
-        /* Remove old IPv6 */
-        if (mi->context.c2.push_ifconfig_ipv6_defined)
-        {
-            unlearn_ifconfig_ipv6(m, mi);
-        }
-
-        /* Add new IPv6 */
         struct in6_addr new_addr6;
         CLEAR(new_addr6);
-        if (inet_pton(AF_INET6, new_ipv6, &new_addr6) =3D=3D 1
-            && multi_learn_in6_addr(m, mi, new_addr6, -1, true))
+        if (inet_pton(AF_INET6, new_ipv6, &new_addr6) =3D=3D 1)
         {
-            mi->context.c2.push_ifconfig_ipv6_defined =3D true;
-            mi->context.c2.push_ifconfig_ipv6_local =3D new_addr6;
-            /* set our client's VPN endpoint for status reporting purposes=
 */
-            mi->reporting_addr_ipv6 =3D mi->context.c2.push_ifconfig_ipv6_=
local;
+            /* if no previous IPv6 or the new IPv6 is different */
+            if (!mi->context.c2.push_ifconfig_ipv6_defined
+                || (mi->context.c2.push_ifconfig_ipv6_defined
+                    && memcmp(&new_addr6, &mi->context.c2.push_ifconfig_ip=
v6_local, sizeof(struct in6_addr))))
+            {
+                /* Remove old IPv6 */
+                if (mi->context.c2.push_ifconfig_ipv6_defined)
+                {
+                    unlearn_ifconfig_ipv6(m, mi);
+                }
+
+                /* Add new IPv6 */
+                if (multi_learn_in6_addr(m, mi, new_addr6, -1, true))
+                {
+                    mi->context.c2.push_ifconfig_ipv6_defined =3D true;
+                    mi->context.c2.push_ifconfig_ipv6_local =3D new_addr6;
+                    /* set our client's VPN endpoint for status reporting =
purposes */
+                    mi->reporting_addr_ipv6 =3D mi->context.c2.push_ifconf=
ig_ipv6_local;
+                    update_flags |=3D (1 << AF_INET);
+                }
+            }
         }
     }
+
+    if (!update_flags)
+    {
+        return;
+    }
+
+    /* we update the virtual addresses of the peer in the DCO */
+    if (dco_enabled(&m->top.options))
+    {
+        dco_multi_update_peer_addr(m, mi, update_flags);
+    }
+
+    /* we add the iroutes with the new VPN IP */
+    if (update_flags & (1 << AF_INET) && new_ip)
+    {
+        multi_add_iroutes_v4(m, mi);
+    }
+    if (update_flags & (1 << AF_INET6) && new_ipv6)
+    {
+        multi_add_iroutes_v6(m, mi);
+    }
 }

 bool
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 1209dfb..7bda347 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -714,8 +714,6 @@
 #endif

 void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *new_ip, const char *new_ipv6);
-void unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi);
-void unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance =
*mi);
+update_vaddr(struct multi_context *m, struct multi_instance *mi, const cha=
r *new_ip, const char *new_ipv6);

 #endif /* MULTI_H */
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 51c7b5f..bcab1d0 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -151,14 +151,35 @@
     struct options o;
     CLEAR(o);

-    /* Set canary values to detect ifconfig options in push-update message=
s.
-     * These placeholder strings will be overwritten to NULL by the option
-     * parser if -ifconfig or -ifconfig-ipv6 options are present in the
-     * push-update.
+    /* Set canary values to detect -ifconfig and -ifconfig-ipv6 options in
+     * push-update messages. These placeholder strings will be overwritten
+     * to NULL by the option parser if -ifconfig or -ifconfig-ipv6 options
+     * are present in the push-update, by the a new value if present, or
+     * they will remain equals to the current values otherwise.
+     * If the current values are not defined they will remain NULL.
      */
-    const char *canary =3D "canary";
-    o.ifconfig_local =3D canary;
-    o.ifconfig_ipv6_local =3D canary;
+
+    char ifconfig_local[INET_ADDRSTRLEN];
+    struct in_addr addr4 =3D { .s_addr =3D htonl(mi->context.c2.push_ifcon=
fig_local) };
+    if (mi->context.c2.push_ifconfig_defined)
+    {
+        o.ifconfig_local =3D inet_ntop(AF_INET, &addr4, ifconfig_local, si=
zeof(ifconfig_local));
+        if (!o.ifconfig_local)
+        {
+            return false;
+        }
+    }
+
+    char ifconfig_ipv6_local[INET6_ADDRSTRLEN];
+    if (mi->context.c2.push_ifconfig_ipv6_defined)
+    {
+        o.ifconfig_ipv6_local =3D inet_ntop(AF_INET6, &mi->context.c2.push=
_ifconfig_ipv6_local,
+                                          ifconfig_ipv6_local, sizeof(ifco=
nfig_ipv6_local));
+        if (!o.ifconfig_ipv6_local)
+        {
+            return false;
+        }
+    }

     struct buffer_entry *e =3D msgs->head;
     while (e)
@@ -195,28 +216,8 @@

     if (option_types_found & OPT_P_UP)
     {
-        /* -ifconfig */
-        if (!o.ifconfig_local && mi->context.c2.push_ifconfig_defined)
-        {
-            unlearn_ifconfig(m, mi);
-        }
-        /* -ifconfig-ipv6 */
-        if (!o.ifconfig_ipv6_local && mi->context.c2.push_ifconfig_ipv6_de=
fined)
-        {
-            unlearn_ifconfig_ipv6(m, mi);
-        }
-
-        if (o.ifconfig_local && !strcmp(o.ifconfig_local, canary))
-        {
-            o.ifconfig_local =3D NULL;
-        }
-        if (o.ifconfig_ipv6_local && !strcmp(o.ifconfig_ipv6_local, canary=
))
-        {
-            o.ifconfig_ipv6_local =3D NULL;
-        }
-
-        /* new ifconfig or new ifconfig-ipv6 */
-        update_vhash(m, mi, o.ifconfig_local, o.ifconfig_ipv6_local);
+        /* ifconfig or ifconfig-ipv6 */
+        update_vaddr(m, mi, o.ifconfig_local, o.ifconfig_ipv6_local);
     }

     return true;
@@ -253,12 +254,14 @@
 static int
 send_push_update(struct multi_context *m, const void *target, const char *=
msg, const push_update_type type, const size_t push_bundle_size)
 {
+#if !defined(TARGET_LINUX)
     if (dco_enabled(&m->top.options))
     {
         msg(M_WARN, "WARN: PUSH_UPDATE messages cannot currently be sent w=
hile DCO is enabled."
                     " To send a PUSH_UPDATE message, be sure to use the --=
disable-dco option.");
         return 0;
     }
+#endif

     if (!msg || !*msg || !m || (!target && type !=3D UPT_BROADCAST))
     {
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 9b7978e..2d2fc93 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -31,19 +31,7 @@
 }

 void
-unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)
-{
-    return;
-}
-
-void
-unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)
-{
-    return;
-}
-
-void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const cha=
r *new_ip, const char *new_ipv6)
+update_vaddr(struct multi_context *m, struct multi_instance *mi, const cha=
r *new_ip, const char *new_ipv6)
 {
     return;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1450?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297
Gerrit-Change-Number: 1450
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--KPOuYXB9uPw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>mrbff would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1450?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">PUSH_UPDATE: add DCO and iroutes support on=
 server<br><br>Renamed update_vhash() to update_vaddr().<br>Moved the -ifco=
nfig logic from send_single_push_update() to update_vaddr().<br>Changed can=
ary logic to use the current value of ifconfig (if present) as<br>canary. A=
dded logic in the update_vaddr() to not unlearn and re-learn the same<br>ad=
dress.<br><br>Added logic to update the peer&#39;s virtual address(es) in t=
he DCO to the current<br>value(s) after sending a PUSH_UPDATE message on Li=
nux.<br>Added dco_multi_update_peer_addr() and dco_update_peer_addr() to do=
 so.<br><br>Added logic to update iroutes after changing the peer&#39;s vir=
tual address(es).<br>Divided dco_delete_iroutes() in _v4() and _v6() to bet=
ter updating iroutes.<br><br>Change-Id: I88f37e47026a7d7ea0f7c6bde1d79d32c1=
4e5297<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M s=
rc/openvpn/dco.c<br>M src/openvpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M=
 src/openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>M src/openvpn/multi.=
c<br>M src/openvpn/multi.h<br>M src/openvpn/push_util.c<br>M tests/unit_tes=
ts/openvpn/test_push_update_msg.c<br>9 files changed, 377 insertions(+), 14=
2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/50/1450/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.=
c b/src/openvpn/dco.c</span><br><span>index 6a1a5c9..eccfac2 100644</span><=
br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</s=
pan><br><span>@@ -658,6 +658,41 @@</span><br><span>     return 0;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_mult=
i_update_peer_addr(struct multi_context *m, struct multi_instance *mi, int =
flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t context *c =3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int peer_id =3D c-&gt;c2.tls_multi-&gt;dco_peer_id;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we need to fetch t=
he remote addresses from the push config */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct in_addr vpn_ip4 =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct in_addr *vpn_addr4 =3D=
 NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt=
;c2.push_ifconfig_defined)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 vpn_ip4.s_addr =3D htonl(c-&gt;c2.push_ifconfig_local);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        vpn_addr4 =3D &amp;vpn_ip4;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct in6_addr *vpn_addr6 =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.push_ifconfig_ipv=
6_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        vpn_addr6 =3D &=
amp;c-&gt;c2.push_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D dco_update_peer_addr(&amp;c-&gt;c1.tuntap-&gt;dco, peer_id, vpn_addr4, =
vpn_addr6, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> void</span><br><span> dco_install_iroute(struct multi_=
context *m, struct multi_instance *mi, struct mroute_addr *addr)</span><br>=
<span> {</span><br><span>@@ -723,7 +758,7 @@</span><br><span> }</span><br><=
span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-dco_delete_iroutes(struct multi_context *m, struct multi_instance *m=
i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroute=
s_v4(struct multi_context *m, struct multi_instance *mi)</span><br><span> {=
</span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || d=
efined(_WIN32)</span><br><span>     if (!dco_enabled(&amp;m-&gt;top.options=
))</span><br><span>@@ -734,7 +769,7 @@</span><br><span> </span><br><span>  =
   struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;context.c2.push_if=
config_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (c-&gt;c2.push_ifconfig_defined)</span><br><span>     {</span><br><span>=
         for (const struct iroute *ir =3D c-&gt;options.iroutes; ir; ir =3D=
 ir-&gt;next)</span><br><span>         {</span><br><span>@@ -742,7 +777,7 @=
@</span><br><span>             dco_win_del_iroute_ipv4(&amp;c-&gt;c1.tuntap=
-&gt;dco, htonl(ir-&gt;network), ir-&gt;netbits);</span><br><span> #else</s=
pan><br><span>             net_route_v4_del(&amp;m-&gt;top.net_ctx, &amp;ir=
-&gt;network, ir-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                             &amp;mi-&gt;context.c2.push_ifconfig_l=
ocal, c-&gt;c1.tuntap-&gt;actual_name, 0,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                             &amp;c-&gt;c2.push_ifcon=
fig_local, c-&gt;c1.tuntap-&gt;actual_name, 0,</span><br><span>            =
                  DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><sp=
an>         }</span><br><span>@@ -750,7 +785,7 @@</span><br><span> #if !def=
ined(_WIN32)</span><br><span>         /* Check if we added a host route as =
the assigned client IP address was</span><br><span>          * not in the o=
n link scope defined by --ifconfig */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        in_addr_t ifconfig_local =3D mi-&gt;context.c2.push=
_ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     in_addr_t ifconfig_local =3D c-&gt;c2.push_ifconfig_local;</span><br><=
span> </span><br><span>         if (multi_check_push_ifconfig_extra_route(m=
i, htonl(ifconfig_local)))</span><br><span>         {</span><br><span>@@ -7=
61,8 +796,22 @@</span><br><span>         }</span><br><span> #endif</span><b=
r><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;con=
text.c2.push_ifconfig_ipv6_defined)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_delete_iroutes_v6(struct multi_context *m, struct multi_instance *mi)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(T=
ARGET_FREEBSD) || defined(_WIN32)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!dco_enabled(&amp;m-&gt;top.options))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(TUNNEL_TYPE(mi-&gt;context.c1.tuntap) =3D=3D DEV_TYPE_TU=
N);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi-&=
gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.push_ifcon=
fig_ipv6_defined)</span><br><span>     {</span><br><span>         for (cons=
t struct iroute_ipv6 *ir6 =3D c-&gt;options.iroutes_ipv6; ir6; ir6 =3D ir6-=
&gt;next)</span><br><span>         {</span><br><span>@@ -770,7 +819,7 @@</s=
pan><br><span>             dco_win_del_iroute_ipv6(&amp;c-&gt;c1.tuntap-&gt=
;dco, ir6-&gt;network, ir6-&gt;netbits);</span><br><span> #else</span><br><=
span>             net_route_v6_del(&amp;m-&gt;top.net_ctx, &amp;ir6-&gt;net=
work, ir6-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                             &amp;mi-&gt;context.c2.push_ifconfig_ipv6_loc=
al, c-&gt;c1.tuntap-&gt;actual_name, 0,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                             &amp;c-&gt;c2.push_ifconfi=
g_ipv6_local, c-&gt;c1.tuntap-&gt;actual_name, 0,</span><br><span>         =
                     DCO_IROUTE_METRIC);</span><br><span> #endif</span><br>=
<span>         }</span><br><span>@@ -778,7 +827,7 @@</span><br><span>      =
   /* Checked if we added a host route as the assigned client IP address wa=
s</span><br><span>          * outside the --ifconfig-ipv6 tun interface con=
fig */</span><br><span> #if !defined(_WIN32)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        struct in6_addr *dest =3D &amp;mi-&gt;contex=
t.c2.push_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct in6_addr *dest =3D &amp;c-&gt;c2.push_ifconfig_ip=
v6_local;</span><br><span>         if (multi_check_push_ifconfig_ipv6_extra=
_route(mi, dest))</span><br><span>         {</span><br><span>             /=
* On windows we do not install these routes, so we also do not need to dele=
te them */</span><br><span>diff --git a/src/openvpn/dco.h b/src/openvpn/dco=
.h</span><br><span>index cd6e32a..3bc28a8 100644</span><br><span>--- a/src/=
openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -1=
91,6 +191,30 @@</span><br><span>                  int keepalive_timeout, in=
t mss);</span><br><span> </span><br><span> /**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Update the peer&#39;s virtual address(es) in =
the DCO to the current value(s)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram dco       DCO device contect</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param peerid    the ID of the peer to be modified</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param vpn_ipv4  new IPv=
4 or NULL to remove the outdated one, only used when `(1 &lt;&lt; AF_INET)`=
 flag is present</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param vpn_ipv6  new IPv6 or NULL to remove the outdated one, only used whe=
n `(1 &lt;&lt; AF_INET6)` flag is present</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param flags     `(1 &lt;&lt; AF_INET)`, `(1 &lt;&=
lt; AF_INET6)` or `(1 &lt;&lt; AF_INET) | (1 &lt;&lt; AF_INET6)` depending =
on wich address has changed</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @return int      the DCO message status on success or a negative=
 error code otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_addr(dco_conte=
xt_t *dco, unsigned int peerid, struct in_addr *vpn_ipv4, struct in6_addr *=
vpn_ipv6, int flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Update the peer&#39;s virtual =
address(es) in the DCO to the current value(s)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param m         server multi context</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param mi        peer multi instnace</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param flags     `(1 =
&lt;&lt; AF_INET)`, `(1 &lt;&lt; AF_INET6)` or `(1 &lt;&lt; AF_INET) | (1 &=
lt;&lt; AF_INET6)` depending on wich address has changed</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return int      0 on success or a =
negative error code otherwise</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_update_peer_=
addr(struct multi_context *m, struct multi_instance *mi, int flags);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Remove a peer from DC=
O</span><br><span>  *</span><br><span>  * @param c         the main instanc=
e context of the peer to remove</span><br><span>@@ -218,12 +242,20 @@</span=
><br><span>                         struct mroute_addr *addr);</span><br><s=
pan> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Remove all routes added through the specified client</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Remove all IPv4 routes added th=
rough the specified client</span><br><span>  *</span><br><span>  * @param m=
         the server context</span><br><span>  * @param mi        the client=
 instance for which routes have to be removed</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void dco_delete_iroutes(struct=
 multi_context *m, struct multi_instance *mi);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void dco_delete_iroutes_v4(struct multi_context =
*m, struct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remove all IPv6 rout=
es added through the specified client</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param m         the server context</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param mi        the client instance for which route=
s have to be removed</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void dco_delete=
_iroutes_v6(struct multi_context *m, struct multi_instance *mi);</span><br>=
<span> </span><br><span> /**</span><br><span>  * Update traffic statistics =
for all peers</span><br><span>@@ -361,7 +393,12 @@</span><br><span> }</span=
><br><span> </span><br><span> static inline void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-dco_delete_iroutes(struct multi_context *m, stru=
ct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+dco_delete_iroutes_v4(struct multi_context *m, struct multi_instance *mi=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static inline void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_delete_iroutes_v6(struct multi_context *m, struct multi_instance *mi)<=
/span><br><span> {</span><br><span> }</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><=
span>index d1ad092..6bee21b 100644</span><br><span>--- a/src/openvpn/dco_fr=
eebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ =
-559,6 +559,12 @@</span><br><span>     return ret;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_addr(dc=
o_context_t *dco, unsigned int peerid, struct in_addr *vpn_ipv4, struct in6=
_addr *vpn_ipv6, int flags)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span=
><br><span> dco_update_peer_stat(struct multi_context *m, uint32_t peerid, =
const nvlist_t *nvl)</span><br><span> {</span><br><span>diff --git a/src/op=
envpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 2664029..=
eb9e4f9 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><spa=
n>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -684,6 +684,50 @@</span>=
<br><span>     return ret;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+dco_update_peer_addr(dco_context_t *dco, unsign=
ed int peerid, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6, int fla=
gs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: pee=
r-id %d&quot;, __func__, peerid);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, O=
VPN_CMD_PEER_SET);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!nl_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -EN=
OMEM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct nlattr *attr =3D nla_nest_start(nl_m=
sg, OVPN_A_PEER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int ret =3D -EMSGSIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (flags &amp; (1 &lt;&lt; AF_INET))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_VPN_IPV4, vp=
n_ipv4 ? vpn_ipv4-&gt;s_addr : 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp=
; (1 &lt;&lt; AF_INET6))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
truct in6_addr addr6;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!vpn_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       CLEAR(addr6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            vpn_ipv6 =3D &amp;addr6;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        NLA_PUT(nl_msg, OVPN_A_PEER_VPN_IPV6, sizeof(struct in6_add=
r), vpn_ipv6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    nla_nest_end(nl_msg, attr);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_se=
nd(dco, nl_msg, __func__);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+nla_put_fail=
ure:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nlmsg_free(=
nl_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* This functio=
n parses the reply provided by the kernel to the CTRL_CMD_GETFAMILY</span><=
br><span>  * message. We parse the reply and we retrieve the multicast grou=
p ID associated</span><br><span>  * with the &quot;ovpn-dco&quot; netlink f=
amily.</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco=
_win.c</span><br><span>index 94f043f..6a1806d 100644</span><br><span>--- a/=
src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br=
><span>@@ -526,6 +526,12 @@</span><br><span> }</span><br><span> </span><br>=
<span> int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_updat=
e_peer_addr(dco_context_t *dco, unsigned int peerid, struct in_addr *vpn_ip=
v4, struct in6_addr *vpn_ipv6, int flags)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+int</span><br><span> dco_new_key(dco_con=
text_t *dco, unsigned int peerid, int keyid, dco_key_slot_t slot,</span><br=
><span>             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, =
const uint8_t *decrypt_key,</span><br><span>             const uint8_t *dec=
rypt_iv, const char *ciphername, bool epoch)</span><br><span>diff --git a/s=
rc/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 329d0a3..878=
871f 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b=
/src/openvpn/multi.c</span><br><span>@@ -476,6 +476,40 @@</span><br><span> =
    set_prefix(mi);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+multi_del_iroutes_v4(struct multi_context *m, =
struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (TUN=
NEL_TYPE(mi-&gt;context.c1.tuntap) !=3D DEV_TYPE_TUN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct =
iroute *ir;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_delete_iroutes_v4(m=
, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (ir =
=3D mi-&gt;context.options.iroutes; ir !=3D NULL; ir =3D ir-&gt;next)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        mroute_helper_del_iroute46(m-&g=
t;route_helper, ir-&gt;netbits);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+multi_del_iroutes_v6(struct multi_context *m, =
struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (TUN=
NEL_TYPE(mi-&gt;context.c1.tuntap) !=3D DEV_TYPE_TUN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct =
iroute_ipv6 *ir6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_delete_iroute=
s_v6(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (ir6 =3D mi-&gt;context.options.iroutes_ipv6; ir6 !=3D NULL; ir6 =3D ir6-&=
gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        mroute_helper_del=
_iroute46(m-&gt;route_helper, ir6-&gt;netbits);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> /*</span><br><span>  * Tell the route helper about deleted ir=
outes so</span><br><span>  * that it can update its mask of currently used<=
/span><br><span>@@ -484,23 +518,8 @@</span><br><span> static void</span><br=
><span> multi_del_iroutes(struct multi_context *m, struct multi_instance *m=
i)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    const struct iroute *ir;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const struct iroute_ipv6 *ir6;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   dco_delete_iroutes(m, mi);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (TUNNE=
L_TYPE(mi-&gt;context.c1.tuntap) =3D=3D DEV_TYPE_TUN)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        for (ir =3D mi-&gt;context.options.iroutes; ir !=3D=
 NULL; ir =3D ir-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     mroute_helper_del_iroute46(m-&gt;route_helper, ir-&gt;netbits);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        for (ir6 =3D mi-&gt;context.options.iroutes_ipv6; ir6=
 !=3D NULL; ir6 =3D ir6-&gt;next)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            mroute_helper_del_iroute46(m-&gt;route_helper, ir6-&gt;netbits)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    multi_del_iroutes_v4(m, mi);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    multi_del_iroutes_v6(m, mi);<=
/span><br><span> }</span><br><span> </span><br><span> static void</span><br=
><span>@@ -1282,6 +1301,64 @@</span><br><span>     return owner;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
ulti_add_iroutes_v4(struct multi_context *m, struct multi_instance *mi)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (TUNNEL_TYPE(mi-&gt;context.c1.tun=
tap) !=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const struct iroute *ir;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;did_iroutes =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    for (ir =3D mi-&gt;cont=
ext.options.iroutes; ir !=3D NULL; ir =3D ir-&gt;next)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (ir-&gt;netbits &gt;=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(D_MULTI_LOW, &quot;MULTI: inte=
rnal route %s/%d -&gt; %s&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                print_in_addr_t(ir-&gt;network, 0, &amp;gc), i=
r-&gt;netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           multi_instance_string(mi, false, &amp;gc));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(D_MULTI_LOW, &quot;MULTI: internal route %s -&gt; %=
s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     print_in_addr_t(ir-&gt;network, 0, &amp;gc), multi_instance_string(mi,=
 false, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        mroute_helper_add_irou=
te46(m-&gt;route_helper, ir-&gt;netbits);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        multi_learn_in_addr_t(m, mi, ir-&gt;network, ir-&gt;netbits, fal=
se);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+multi_add_iroutes_v6(struct multi_context *m, struct multi_instance *mi)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (TUNNEL_TYPE(mi-&gt;context.c1=
.tuntap) !=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct iroute_=
ipv6 *ir6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;did_iroutes =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (ir6 =
=3D mi-&gt;context.options.iroutes_ipv6; ir6 !=3D NULL; ir6 =3D ir6-&gt;nex=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;=
MULTI: internal route %s/%d -&gt; %s&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            print_in6_addr(ir6-&gt;network, 0, &amp=
;gc), ir6-&gt;netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            multi_instance_string(mi, false, &amp;gc));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        mroute_helper_add_iroute46(m-&gt;route_helper, =
ir6-&gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_learn_i=
n6_addr(m, mi, ir6-&gt;network, ir6-&gt;netbits, false);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> /*</span><br><span>  * A new client has connected,=
 add routes (server -&gt; client)</span><br><span>  * to internal routing t=
able.</span><br><span>@@ -1289,42 +1366,8 @@</span><br><span> static void</=
span><br><span> multi_add_iroutes(struct multi_context *m, struct multi_ins=
tance *mi)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const struct iroute *ir;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const struct iroute_ipv6 *ir6;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (TUNNEL_TYPE(mi-&gt;con=
text.c1.tuntap) =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       mi-&gt;did_iroutes =3D true;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        for (ir =3D mi-&gt;context.options.iroutes; ir !=3D N=
ULL; ir =3D ir-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (ir-&gt;netbits &gt;=3D 0)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                msg(D_MULTI_LOW, &quot;MULTI: internal route %s/%d -&gt;=
 %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         print_in_addr_t(ir-&gt;network, 0, &amp;gc), ir-&gt;netbits,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    multi_i=
nstance_string(mi, false, &amp;gc));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          msg(D_MULTI_LOW, &quot;MULTI: internal route %s -&gt; %s&quot;,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    pri=
nt_in_addr_t(ir-&gt;network, 0, &amp;gc), multi_instance_string(mi, false, =
&amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            mroute_helper_add_iroute46(m=
-&gt;route_helper, ir-&gt;netbits);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     multi_learn_in_addr_t(m, mi, ir-&gt;network, ir-&gt;netbits, false);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        for (ir6 =3D mi-&gt;context=
.options.iroutes_ipv6; ir6 !=3D NULL; ir6 =3D ir6-&gt;next)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW, &quot;MULTI: interna=
l route %s/%d -&gt; %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                print_in6_addr(ir6-&gt;network, 0, &amp;gc), ir6-&g=
t;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     multi_instance_string(mi, false, &amp;gc));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            mroute_helper_add_iroute46(m-&gt;route_helper, ir6-&gt;ne=
tbits);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            multi_learn_in6_addr(m,=
 mi, ir6-&gt;network, ir6-&gt;netbits, false);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   multi_add_iroutes_v4(m, mi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    multi_add_iroutes_v6(m, mi);</span><br><span> }</span><br><=
span> </span><br><span> /*</span><br><span>@@ -4327,9 +4370,10 @@</span><br=
><span> }</span><br><span> </span><br><span> /* Function to unlearn previou=
s ifconfig of a client in the server multi_context after a PUSH_UPDATE */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> unlearn_i=
fconfig(struct multi_context *m, struct multi_instance *mi)</span><br><span=
> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_del_ir=
outes_v4(m, mi);</span><br><span>     in_addr_t old_addr =3D 0;</span><br><=
span>     old_addr =3D htonl(mi-&gt;context.c2.push_ifconfig_local);</span>=
<br><span>     multi_unlearn_in_addr_t(m, mi, old_addr);</span><br><span>@@=
 -4339,9 +4383,10 @@</span><br><span> }</span><br><span> </span><br><span> =
/* Function to unlearn previous ifconfig-ipv6 of a client in the server mul=
ti_context after a PUSH_UPDATE */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span> unlearn_ifconfig_ipv6(struct multi_context *m, st=
ruct multi_instance *mi)</span><br><span> {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    multi_del_iroutes_v6(m, mi);</span><br><span>  =
   struct in6_addr old_addr6;</span><br><span>     CLEAR(old_addr6);</span>=
<br><span>     old_addr6 =3D mi-&gt;context.c2.push_ifconfig_ipv6_local;</s=
pan><br><span>@@ -4352,59 +4397,118 @@</span><br><span> }</span><br><span> =
</span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * Update the vhash with new IP/IPv6 addresses in the multi_context when a<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * push-update message=
 containing ifconfig/ifconfig-ipv6 options is sent</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * from the server.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * When a push-update message containing ifcon=
fig/ifconfig-ipv6 options is sent</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * from the server, update the vhash with new IP/IPv6 address=
es in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * multi_c=
ontext and update the virtual peer addresses in the DCO.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Also remove the iroutes and readd i=
t with the new IP if needed.</span><br><span>  *</span><br><span>  * @param=
 m         The multi_context</span><br><span>  * @param mi        The multi=
_instance of the client we are updating</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * @param new_ip    The new IPv4 address or NULL if no ch=
ange</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param new_ipv=
6  The new IPv6 address or NULL if no change</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param new_ip    The new IPv4 address, NULL for=
 -ifconfig or the current IPv4 if no change</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param new_ipv6  The new IPv6 address, NULL for =
-ifconfig-ipv6 or the current IPv6 if no change</span><br><span>  */</span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-update=
_vhash(struct multi_context *m, struct multi_instance *mi, const char *new_=
ip, const char *new_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+update_vaddr(struct multi_context *m, struct multi_instance *mi, cons=
t char *new_ip, const char *new_ipv6)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* to avoid resetting an IP to its=
 current value, the dco_update_peer_addr() function used to update the DCO,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * needs to kno=
w if actually an IPv4 or an IPv6 has been modified</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int update_flags =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* -ifconfig */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!new_ip &amp;&amp; mi-&gt;context.c2.push_ifconfig_defined)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        unlearn_ifconfig(m, mi);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        update_flags=
 |=3D (1 &lt;&lt; AF_INET);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 -ifconfig-ipv6 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!new_ipv6 &amp;&amp; mi-&gt;context.c2.push_ifconfig_ipv6_defined)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        unlearn_ifconfig_ipv6(m, mi=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        update_fl=
ags |=3D (1 &lt;&lt; AF_INET6);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     if (new_ip)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        /* Remove old IP */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context.c2.push_i=
fconfig_defined)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            unlea=
rn_ifconfig(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* Add new IP */</span><br>=
<span>         struct in_addr new_addr;</span><br><span>         CLEAR(new_=
addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ine=
t_pton(AF_INET, new_ip, &amp;new_addr) =3D=3D 1</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            &amp;&amp; multi_learn_in_addr_t(m, m=
i, ntohl(new_addr.s_addr), -1, true))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (inet_pton(AF_INET, new_ip, &amp;new_addr) =3D=
=3D 1)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            mi-&gt;context.c2.push_ifconfig_defined =3D true;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;cont=
ext.c2.push_ifconfig_local =3D ntohl(new_addr.s_addr);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            /* set our client&#39;s VPN en=
dpoint for status reporting purposes */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            mi-&gt;reporting_addr =3D mi-&gt;context.c2.p=
ush_ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            new_addr.s_addr =3D ntohl(new_addr.s_addr);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            /* if no previous IP or the=
 new IP is different */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (!mi-&gt;context.c2.push_ifconfig_defined</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                || (mi-&gt;context=
.c2.push_ifconfig_defined</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    &amp;&amp; new_addr.s_addr !=3D mi-&gt;context.c2=
.push_ifconfig_local))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             /* Remove old IP */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                if (mi-&gt;context.c2.push_ifconfig_defined)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    unl=
earn_ifconfig(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* =
Add new IP */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          if (multi_learn_in_addr_t(m, mi, new_addr.s_addr, -1, true))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt=
;context.c2.push_ifconfig_defined =3D true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    mi-&gt;context.c2.push_ifconfig=
_local =3D new_addr.s_addr;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    /* set our client&#39;s VPN endpoint for status=
 reporting purposes */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    mi-&gt;reporting_addr =3D mi-&gt;context.c2.push_ifc=
onfig_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             update_flags |=3D (1 &lt;&lt; AF_INET);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>         }<=
/span><br><span>     }</span><br><span> </span><br><span>     if (new_ipv6)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        /* Remove old IPv6 */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (mi-&gt;context.c2.push_ifconfig_ipv6_defined)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            unlearn_ifconfig_ipv6(m, mi);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* Add new IPv6 */</span><br><span>         st=
ruct in6_addr new_addr6;</span><br><span>         CLEAR(new_addr6);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (inet_pton(AF_INET=
6, new_ipv6, &amp;new_addr6) =3D=3D 1</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            &amp;&amp; multi_learn_in6_addr(m, mi, new_addr=
6, -1, true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (inet_pton(AF_INET6, new_ipv6, &amp;new_addr6) =3D=3D 1)</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    mi-&gt;context.c2.push_ifconfig_ipv6_defined =3D true;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;context.c2.push_ifc=
onfig_ipv6_local =3D new_addr6;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            /* set our client&#39;s VPN endpoint for status repor=
ting purposes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       mi-&gt;reporting_addr_ipv6 =3D mi-&gt;context.c2.push_ifconfig_ipv6_=
local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* if no previous IPv6 or the new IPv6 is different */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!mi-&gt;context.c2.push_i=
fconfig_ipv6_defined</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                || (mi-&gt;context.c2.push_ifconfig_ipv6_defined</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    &amp;&amp=
; memcmp(&amp;new_addr6, &amp;mi-&gt;context.c2.push_ifconfig_ipv6_local, s=
izeof(struct in6_addr))))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                /* Remove old IPv6 */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                if (mi-&gt;context.c2.push_ifconfig_ipv6_=
defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       unlearn_ifconfig_ipv6(m, mi);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            /* Add new IPv6 */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                if (multi_learn_in6_addr(m, mi, new_addr6, -1, t=
rue))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    mi-&gt;context.c2.push_ifconfig_ipv6_defined =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context.c=
2.push_ifconfig_ipv6_local =3D new_addr6;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    /* set our client&#39;s VPN endpo=
int for status reporting purposes */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    mi-&gt;reporting_addr_ipv6 =3D mi-&gt;=
context.c2.push_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    update_flags |=3D (1 &lt;&lt; AF_INET)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span>         }</span><br><span>     }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!update_flags)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* we update the virtual addresses of=
 the peer in the DCO */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (dco_enabled(&amp;m-&gt;top.options))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        dco_multi_update_peer_addr(m, mi, update_flags);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* we add the iroutes with the new VPN IP */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (update_flags &amp; =
(1 &lt;&lt; AF_INET) &amp;&amp; new_ip)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        multi_add_iroutes_v4(m, mi);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (update_flags &amp; (1 &lt;&lt; AF_INET6) &amp;&amp; new_ip=
v6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        multi_add_iroutes_v6(m=
, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span> }</span><br><span> </span><br><span> bool</span><br><span>diff --=
git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>index 1209d=
fb..7bda347 100644</span><br><span>--- a/src/openvpn/multi.h</span><br><spa=
n>+++ b/src/openvpn/multi.h</span><br><span>@@ -714,8 +714,6 @@</span><br><=
span> #endif</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-update_vhash(struct multi_context *m, struc=
t multi_instance *mi, const char *new_ip, const char *new_ipv6);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void unlearn_ifconfig(struct mul=
ti_context *m, struct multi_instance *mi);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void unlearn_ifconfig_ipv6(struct multi_context *m, st=
ruct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+update_vaddr(struct multi_context *m, struct multi_instance *mi, cons=
t char *new_ip, const char *new_ipv6);</span><br><span> </span><br><span> #=
endif /* MULTI_H */</span><br><span>diff --git a/src/openvpn/push_util.c b/=
src/openvpn/push_util.c</span><br><span>index 51c7b5f..bcab1d0 100644</span=
><br><span>--- a/src/openvpn/push_util.c</span><br><span>+++ b/src/openvpn/=
push_util.c</span><br><span>@@ -151,14 +151,35 @@</span><br><span>     stru=
ct options o;</span><br><span>     CLEAR(o);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* Set canary values to detect=
 ifconfig options in push-update messages.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     * These placeholder strings will be overwritten t=
o NULL by the option</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * parser if -ifconfig or -ifconfig-ipv6 options are present in the</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     * push-update.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set canary values t=
o detect -ifconfig and -ifconfig-ipv6 options in</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * push-update messages. These placeholder=
 strings will be overwritten</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * to NULL by the option parser if -ifconfig or -ifconfig-ipv6=
 options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * are =
present in the push-update, by the a new value if present, or</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * they will remain equals to=
 the current values otherwise.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * If the current values are not defined they will remain NU=
LL.</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const char *canary =3D &quot;canary&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    o.ifconfig_local =3D canary;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    o.ifconfig_ipv6_local =3D ca=
nary;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    char ifconfig_local[INET_ADDR=
STRLEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
in_addr addr4 =3D { .s_addr =3D htonl(mi-&gt;context.c2.push_ifconfig_local=
) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;=
context.c2.push_ifconfig_defined)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        o.ifconfig_local =3D inet_ntop(AF_INET, &amp;addr4, ifconfig_local,=
 sizeof(ifconfig_local));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (!o.ifconfig_local)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char ifconfig_ipv6_local[I=
NET6_ADDRSTRLEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (mi-&gt;context.c2.push_ifconfig_ipv6_defined)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        o.ifconfig_ipv6_local =3D inet_ntop(AF_INET6, &=
amp;mi-&gt;context.c2.push_ifconfig_ipv6_local,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                          ifcon=
fig_ipv6_local, sizeof(ifconfig_ipv6_local));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!o.ifconfig_ipv6_local)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     =
struct buffer_entry *e =3D msgs-&gt;head;</span><br><span>     while (e)</s=
pan><br><span>@@ -195,28 +216,8 @@</span><br><span> </span><br><span>     i=
f (option_types_found &amp; OPT_P_UP)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /* -ifconfig */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (!o.ifconfig_local &amp=
;&amp; mi-&gt;context.c2.push_ifconfig_defined)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            unlearn_ifconfig(m, mi);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        /* -ifconfig-ipv6 */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (!o.ifconfig_ipv6_local &amp;&amp; mi-&g=
t;context.c2.push_ifconfig_ipv6_defined)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            unlearn_ifconfig_ipv6(m, mi);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (o.ifconfig_local &amp;&amp; !strcmp(o.ifconfig_local, canary))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            o.ifconfig_local =3D NULL;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (o.ifconfig_ipv6_local &=
amp;&amp; !strcmp(o.ifconfig_ipv6_local, canary))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            o.ifconfig_ipv6_local =3D NULL;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /* new ifconfig or new ifconfig-ipv6 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        update_vhash(m, mi, o.ifconfig_loca=
l, o.ifconfig_ipv6_local);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* ifconfig or ifconfig-ipv6 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        update_vaddr(m, mi, o.ifconfig_local, o.=
ifconfig_ipv6_local);</span><br><span>     }</span><br><span> </span><br><s=
pan>     return true;</span><br><span>@@ -253,12 +254,14 @@</span><br><span=
> static int</span><br><span> send_push_update(struct multi_context *m, con=
st void *target, const char *msg, const push_update_type type, const size_t=
 push_bundle_size)</span><br><span> {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if !defined(TARGET_LINUX)</span><br><span>     if (dco_e=
nabled(&amp;m-&gt;top.options))</span><br><span>     {</span><br><span>    =
     msg(M_WARN, &quot;WARN: PUSH_UPDATE messages cannot currently be sent =
while DCO is enabled.&quot;</span><br><span>                     &quot; To =
send a PUSH_UPDATE message, be sure to use the --disable-dco option.&quot;)=
;</span><br><span>         return 0;</span><br><span>     }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br>=
<span>     if (!msg || !*msg || !m || (!target &amp;&amp; type !=3D UPT_BRO=
ADCAST))</span><br><span>     {</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_upda=
te_msg.c</span><br><span>index 9b7978e..2d2fc93 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_push_update_msg.c</span><br><span>@@ -31,19 +31,=
7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-unlearn_ifconfig(struct multi_con=
text *m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-update_vhash(struct multi_context *=
m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+update_vaddr(struct mul=
ti_context *m, struct multi_instance *mi, const char *new_ip, const char *n=
ew_ipv6)</span><br><span> {</span><br><span>     return;</span><br><span> }=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1450?usp=3Demail">change 1450</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1450?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88f37e47026a7d7ea0f7c6bde1d=
79d32c14e5297 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1450 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--KPOuYXB9uPw=--

