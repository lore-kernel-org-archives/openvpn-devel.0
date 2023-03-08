From: Antonio Quartulli <a@...2181...>
Date: Wed,  8 Mar 2023 20:16:05 +0100
Message-Id: <20230308191605.31353-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: don't use NetLink to exchange control
 packets
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
Cc: Antonio Quartulli <a@...2181...>

Using NetLink has proved to be overkill and performance critical.
The amount of control traffic can also easily overrun the NetLink buffer
when a server has enough clients connected.

Stop using NetLink to send/receive control packets and just use the
transport socket as if DCO was not there at all.

Under the hood DCO will redirect control packets to the transport socket
without altering them, so that userspace can happily process them as
usual.

Change-Id: Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d
[lev@...515...: ensure win_dco flag is still exposed]
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco.c            |  12 -----
 src/openvpn/dco.h            |  16 ------
 src/openvpn/dco_freebsd.c    |  10 ----
 src/openvpn/dco_freebsd.h    |   2 -
 src/openvpn/dco_linux.c      | 101 -----------------------------------
 src/openvpn/dco_linux.h      |   2 -
 src/openvpn/dco_win.c        |   8 ---
 src/openvpn/forward.c        |  63 +++-------------------
 src/openvpn/init.c           |   3 +-
 src/openvpn/mtcp.c           |  22 +-------
 src/openvpn/multi.c          |  39 +-------------
 src/openvpn/ovpn_dco_linux.h |  16 +-----
 src/openvpn/socket.c         |   8 +--
 src/openvpn/socket.h         |  22 ++++----
 14 files changed, 29 insertions(+), 295 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index b53332a8..308578b4 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -485,7 +485,6 @@ dco_p2p_add_new_peer(struct context *c)
     }
 
     c->c2.tls_multi->dco_peer_id = multi->peer_id;
-    c->c2.link_socket->dco_installed = true;
 
     return 0;
 }
@@ -605,17 +604,6 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
 
     c->c2.tls_multi->dco_peer_id = peer_id;
 
-    if (c->mode == CM_CHILD_TCP)
-    {
-        multi_tcp_dereference_instance(m->mtcp, mi);
-        if (close(sd))
-        {
-            msg(D_DCO|M_ERRNO, "error closing TCP socket after DCO handover");
-        }
-        c->c2.link_socket->dco_installed = true;
-        c->c2.link_socket->sd = SOCKET_UNDEFINED;
-    }
-
     return 0;
 }
 
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 18a9d78b..2fe671bf 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -127,15 +127,6 @@ void close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx);
  */
 int dco_do_read(dco_context_t *dco);
 
-/**
- * Write data to the DCO communication channel (control packet expected)
- *
- * @param dco       the DCO context
- * @param peer_id   the ID of the peer to send the data to
- * @param buf       the buffer containing the data to send
- */
-int dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf);
-
 /**
  * Install a DCO in the main event loop
  */
@@ -301,13 +292,6 @@ dco_do_read(dco_context_t *dco)
     return 0;
 }
 
-static inline int
-dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
-{
-    ASSERT(false);
-    return 0;
-}
-
 static inline void
 dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 {
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index cd4083c4..92de5f04 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -142,7 +142,6 @@ open_fd(dco_context_t *dco)
     {
         dco->open = true;
     }
-    dco->dco_packet_in = alloc_buf(PAGE_SIZE);
 
     return dco->fd;
 }
@@ -560,15 +559,6 @@ dco_do_read(dco_context_t *dco)
     return 0;
 }
 
-int
-dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
-{
-    /* Control packets are passed through the socket, so this should never get
-     * called. See should_use_dco_socket(). */
-    ASSERT(0);
-    return -EINVAL;
-}
-
 bool
 dco_available(int msglevel)
 {
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index 970beca0..a07f9b69 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -51,8 +51,6 @@ typedef struct dco_context {
 
     char ifname[IFNAMSIZ];
 
-    struct buffer dco_packet_in;
-
     int dco_message_type;
     int dco_message_peer_id;
     int dco_del_peer_reason;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index c84f9cfe..308abfc4 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -434,24 +434,6 @@ ovpn_dco_register(dco_context_t *dco)
     {
         msg(M_ERR, "%s: failed to join groups: %d", __func__, ret);
     }
-
-    /* Register for non-data packets that ovpn-dco may receive. They will be
-     * forwarded to userspace
-     */
-    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_REGISTER_PACKET);
-    if (!nl_msg)
-    {
-        msg(M_ERR, "%s: cannot allocate message to register for control packets",
-            __func__);
-    }
-
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
-    if (ret)
-    {
-        msg(M_ERR, "%s: failed to register for control packets: %d", __func__,
-            ret);
-    }
-    nlmsg_free(nl_msg);
 }
 
 int
@@ -474,8 +456,6 @@ open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
     }
 
     tt->actual_name = string_alloc(dev, NULL);
-    uint8_t *dcobuf = malloc(65536);
-    buf_set_write(&tt->dco.dco_packet_in, dcobuf, 65536);
     tt->dco.dco_message_peer_id = -1;
 
     ovpn_dco_register(&tt->dco);
@@ -490,7 +470,6 @@ close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 
     net_iface_del(ctx, tt->actual_name);
     ovpn_dco_uninit_netlink(&tt->dco);
-    free(tt->dco.dco_packet_in.data);
 }
 
 int
@@ -821,51 +800,6 @@ ovpn_handle_msg(struct nl_msg *msg, void *arg)
             break;
         }
 
-        case OVPN_CMD_PACKET:
-        {
-            if (!attrs[OVPN_ATTR_PACKET])
-            {
-                msg(D_DCO, "ovpn-dco: no packet in OVPN_CMD_PACKET message");
-                return NL_SKIP;
-            }
-            struct nlattr *pkt_attrs[OVPN_PACKET_ATTR_MAX + 1];
-
-            if (nla_parse_nested(pkt_attrs, OVPN_PACKET_ATTR_MAX,
-                                 attrs[OVPN_ATTR_PACKET], NULL))
-            {
-                msg(D_DCO, "received bogus cmd packet data from ovpn-dco");
-                return NL_SKIP;
-            }
-            if (!pkt_attrs[OVPN_PACKET_ATTR_PEER_ID])
-            {
-                msg(D_DCO, "ovpn-dco: Received OVPN_CMD_PACKET message without peer id");
-                return NL_SKIP;
-            }
-            if (!pkt_attrs[OVPN_PACKET_ATTR_PACKET])
-            {
-                msg(D_DCO, "ovpn-dco: Received OVPN_CMD_PACKET message without packet");
-                return NL_SKIP;
-            }
-
-            unsigned int peerid = nla_get_u32(pkt_attrs[OVPN_PACKET_ATTR_PEER_ID]);
-
-            uint8_t *data = nla_data(pkt_attrs[OVPN_PACKET_ATTR_PACKET]);
-            int len = nla_len(pkt_attrs[OVPN_PACKET_ATTR_PACKET]);
-
-            msg(D_DCO_DEBUG, "ovpn-dco: received OVPN_PACKET_ATTR_PACKET, ifindex: %d peer-id: %d, len %d",
-                ifindex, peerid, len);
-            if (BLEN(&dco->dco_packet_in) > 0)
-            {
-                msg(D_DCO, "DCO packet buffer still full?!");
-                return NL_SKIP;
-            }
-            buf_init(&dco->dco_packet_in, 0);
-            buf_write(&dco->dco_packet_in, data, len);
-            dco->dco_message_peer_id = peerid;
-            dco->dco_message_type = OVPN_CMD_PACKET;
-            break;
-        }
-
         default:
             msg(D_DCO, "ovpn-dco: received unknown command: %d", gnlh->cmd);
             dco->dco_message_type = 0;
@@ -884,41 +818,6 @@ dco_do_read(dco_context_t *dco)
     return ovpn_nl_recvmsgs(dco, __func__);
 }
 
-int
-dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
-{
-    packet_size_type len = BLEN(buf);
-    dmsg(D_STREAM_DEBUG, "DCO: WRITE %d offset=%d", (int)len, buf->offset);
-
-    msg(D_DCO_DEBUG, "%s: peer-id %d, len=%d", __func__, peer_id, len);
-
-    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PACKET);
-
-    if (!nl_msg)
-    {
-        return -ENOMEM;
-    }
-
-    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_PACKET);
-    int ret = -EMSGSIZE;
-    NLA_PUT_U32(nl_msg, OVPN_PACKET_ATTR_PEER_ID, peer_id);
-    NLA_PUT(nl_msg, OVPN_PACKET_ATTR_PACKET, len, BSTR(buf));
-    nla_nest_end(nl_msg, attr);
-
-    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
-    if (ret)
-    {
-        goto nla_put_failure;
-    }
-
-    /* return the length of the written data in case of success */
-    ret = len;
-
-nla_put_failure:
-    nlmsg_free(nl_msg);
-    return ret;
-}
-
 int
 dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
 {
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 4d996d98..d28e3658 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -48,8 +48,6 @@ typedef struct
 
     unsigned int ifindex;
 
-    struct buffer dco_packet_in;
-
     int dco_message_type;
     int dco_message_peer_id;
     int dco_del_peer_reason;
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 0931fb30..a805c2a0 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -393,14 +393,6 @@ dco_do_read(dco_context_t *dco)
     return 0;
 }
 
-int
-dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
-{
-    /* no-op on windows */
-    ASSERT(0);
-    return 0;
-}
-
 int
 dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
 {
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 257c7c75..0e86b58c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1191,7 +1191,6 @@ static void
 process_incoming_dco(struct context *c)
 {
 #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
-    struct link_socket_info *lsi = get_link_socket_info(c);
     dco_context_t *dco = &c->c1.tuntap->dco;
 
     dco_do_read(dco);
@@ -1204,35 +1203,23 @@ process_incoming_dco(struct context *c)
         msg(D_DCO_DEBUG, "%s: received message for mismatching peer-id %d, "
             "expected %d", __func__, dco->dco_message_peer_id,
             c->c2.tls_multi->dco_peer_id);
-        /* ensure we also drop a message if there is one in the buffer */
-        buf_init(&dco->dco_packet_in, 0);
         return;
     }
 
-    if ((dco->dco_message_type == OVPN_CMD_DEL_PEER)
-        && (dco->dco_del_peer_reason == OVPN_DEL_PEER_REASON_EXPIRED))
+    if (dco->dco_message_type != OVPN_CMD_DEL_PEER)
     {
-        msg(D_DCO_DEBUG, "%s: received peer expired notification of for peer-id "
-            "%d", __func__, dco->dco_message_peer_id);
-        trigger_ping_timeout_signal(c);
+        msg(D_DCO_DEBUG, "%s: received message of type %u - ignoring", __func__,
+            dco->dco_message_type);
         return;
     }
 
-    if (dco->dco_message_type != OVPN_CMD_PACKET)
+    if (dco->dco_del_peer_reason == OVPN_DEL_PEER_REASON_EXPIRED)
     {
-        msg(D_DCO_DEBUG, "%s: received message of type %u - ignoring", __func__,
-            dco->dco_message_type);
+        msg(D_DCO_DEBUG, "%s: received peer expired notification of for peer-id "
+            "%d", __func__, dco->dco_message_peer_id);
+        trigger_ping_timeout_signal(c);
         return;
     }
-
-    struct buffer orig_buff = c->c2.buf;
-    c->c2.buf = dco->dco_packet_in;
-    c->c2.from = lsi->lsa->actual;
-
-    process_incoming_link(c);
-
-    c->c2.buf = orig_buff;
-    buf_init(&dco->dco_packet_in, 0);
 #endif /* if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD)) */
 }
 
@@ -1686,30 +1673,6 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
     }
 }
 
-/*
- * Linux DCO implementations pass the socket to the kernel and
- * disallow usage of it from userland for TCP, so (control) packets
- * sent and received by OpenVPN need to go through the DCO interface.
- *
- * Windows DCO needs control packets to be sent via the normal
- * standard Overlapped I/O.
- *
- * FreeBSD DCO allows control packets to pass through the socket in both
- * directions.
- *
- * Hide that complexity (...especially if more platforms show up
- * in the future...) in a small inline function.
- */
-static inline bool
-should_use_dco_socket(struct link_socket *ls)
-{
-#if defined(TARGET_LINUX)
-    return ls->dco_installed && proto_is_tcp(ls->info.proto);
-#else
-    return false;
-#endif
-}
-
 /*
  * Input: c->c2.to_link
  */
@@ -1783,17 +1746,7 @@ process_outgoing_link(struct context *c)
                 socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
 
                 /* Send packet */
-                if (should_use_dco_socket(c->c2.link_socket))
-                {
-                    size = dco_do_write(&c->c1.tuntap->dco,
-                                        c->c2.tls_multi->dco_peer_id,
-                                        &c->c2.to_link);
-                }
-                else
-                {
-                    size = link_socket_write(c->c2.link_socket, &c->c2.to_link,
-                                             to_addr);
-                }
+                size = link_socket_write(c->c2.link_socket, &c->c2.to_link, to_addr);
 
                 /* Undo effect of prepend */
                 link_socket_write_post_size_adjust(&size, size_delta, &c->c2.to_link);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e67b93d3..124ac76b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3914,8 +3914,7 @@ do_close_link_socket(struct context *c)
     /* in dco-win case, link socket is a tun handle which is
      * closed in do_close_tun(). Set it to UNDEFINED so
      * we won't use WinSock API to close it. */
-    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_socket
-        && c->c2.link_socket->dco_installed)
+    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_socket)
     {
         c->c2.link_socket->sd = SOCKET_UNDEFINED;
     }
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 59131ac9..6c56a260 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -402,18 +402,6 @@ multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, const in
 
     tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
 
-    if (mi && mi->context.c2.link_socket->dco_installed)
-    {
-        /* If we got a socket that has been handed over to the kernel
-         * we must not call the normal socket function to figure out
-         * if it is readable or writable */
-        /* Assert that we only have the DCO exptected flags */
-        ASSERT(action & (TA_SOCKET_READ | TA_SOCKET_WRITE));
-
-        /* We are always ready! */
-        return action;
-    }
-
     switch (action)
     {
         case TA_TUN_READ:
@@ -537,10 +525,7 @@ multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int
 
         case TA_INITIAL:
             ASSERT(mi);
-            if (!mi->context.c2.link_socket->dco_installed)
-            {
-                multi_tcp_set_global_rw_flags(m, mi);
-            }
+            multi_tcp_set_global_rw_flags(m, mi);
             multi_process_post(m, mi, mpp_flags);
             break;
 
@@ -590,10 +575,7 @@ multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act
             }
             else
             {
-                if (!c->c2.link_socket->dco_installed)
-                {
-                    multi_tcp_set_global_rw_flags(m, mi);
-                }
+                multi_tcp_set_global_rw_flags(m, mi);
             }
             break;
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 59c980b0..53c17b3a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3202,37 +3202,6 @@ multi_signal_instance(struct multi_context *m, struct multi_instance *mi, const
 #endif
 
 #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
-static void
-process_incoming_dco_packet(struct multi_context *m, struct multi_instance *mi,
-                            dco_context_t *dco)
-{
-    if (BLEN(&dco->dco_packet_in) < 1)
-    {
-        msg(D_DCO, "Received too short packet for peer %d",
-            dco->dco_message_peer_id);
-        goto done;
-    }
-
-    uint8_t *ptr = BPTR(&dco->dco_packet_in);
-    uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
-    if ((op == P_DATA_V1) || (op == P_DATA_V2))
-    {
-        msg(D_DCO, "DCO: received data channel packet for peer %d",
-            dco->dco_message_peer_id);
-        goto done;
-    }
-
-    struct buffer orig_buf = mi->context.c2.buf;
-    mi->context.c2.buf = dco->dco_packet_in;
-
-    multi_process_incoming_link(m, mi, 0);
-
-    mi->context.c2.buf = orig_buf;
-
-done:
-    buf_init(&dco->dco_packet_in, 0);
-}
-
 static void
 process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi,
                           dco_context_t *dco)
@@ -3299,11 +3268,7 @@ multi_process_incoming_dco(struct multi_context *m)
     if ((peer_id < m->max_clients) && (m->instances[peer_id]))
     {
         mi = m->instances[peer_id];
-        if (dco->dco_message_type == OVPN_CMD_PACKET)
-        {
-            process_incoming_dco_packet(m, mi, dco);
-        }
-        else if (dco->dco_message_type == OVPN_CMD_DEL_PEER)
+        if (dco->dco_message_type == OVPN_CMD_DEL_PEER)
         {
             process_incoming_del_peer(m, mi, dco);
         }
@@ -3326,8 +3291,6 @@ multi_process_incoming_dco(struct multi_context *m)
         msg(msglevel, "Received DCO message for unknown peer-id: %d, "
             "type %d, del_peer_reason %d", peer_id, dco->dco_message_type,
             dco->dco_del_peer_reason);
-        /* Also clear the buffer if this was incoming packet for a dropped peer */
-        buf_init(&dco->dco_packet_in, 0);
     }
 
     dco->dco_message_type = 0;
diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h
index 96395886..d3fd9a89 100644
--- a/src/openvpn/ovpn_dco_linux.h
+++ b/src/openvpn/ovpn_dco_linux.h
@@ -11,7 +11,7 @@
 #ifndef _UAPI_LINUX_OVPN_DCO_H_
 #define _UAPI_LINUX_OVPN_DCO_H_
 
-#define OVPN_NL_NAME "ovpn-dco"
+#define OVPN_NL_NAME "ovpn-dco-v2"
 
 #define OVPN_NL_MULTICAST_GROUP_PEERS "peers"
 
@@ -45,19 +45,6 @@ enum ovpn_nl_commands {
 
 	OVPN_CMD_DEL_KEY,
 
-	/**
-	 * @OVPN_CMD_REGISTER_PACKET: Register for specific packet types to be
-	 * forwarded to userspace
-	 */
-	OVPN_CMD_REGISTER_PACKET,
-
-	/**
-	 * @OVPN_CMD_PACKET: Send a packet from userspace to kernelspace. Also
-	 * used to send to userspace packets for which a process had registered
-	 * with OVPN_CMD_REGISTER_PACKET
-	 */
-	OVPN_CMD_PACKET,
-
 	/**
 	 * @OVPN_CMD_GET_PEER: Retrieve the status of a peer or all peers
 	 */
@@ -105,7 +92,6 @@ enum ovpn_netlink_attrs {
 	OVPN_ATTR_NEW_KEY,
 	OVPN_ATTR_SWAP_KEYS,
 	OVPN_ATTR_DEL_KEY,
-	OVPN_ATTR_PACKET,
 	OVPN_ATTR_GET_PEER,
 
 	__OVPN_ATTR_AFTER_LAST,
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index eff21ca5..216f2ad7 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2151,7 +2151,7 @@ create_socket_dco_win(struct context *c, struct link_socket *sock,
                       get_server_poll_remaining_time(sock->server_poll_timeout),
                       sig_info);
 
-    sock->dco_installed = true;
+    sock->sockflags |= SF_DCO_WIN;
 
     if (sig_info->signal_received)
     {
@@ -3505,7 +3505,7 @@ link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
 static int
 socket_get_last_error(const struct link_socket *sock)
 {
-    if (sock->dco_installed)
+    if (socket_is_dco_win(sock))
     {
         return GetLastError();
     }
@@ -3546,7 +3546,7 @@ socket_recv_queue(struct link_socket *sock, int maxsize)
         ASSERT(ResetEvent(sock->reads.overlapped.hEvent));
         sock->reads.flags = 0;
 
-        if (sock->dco_installed)
+        if (socket_is_dco_win(sock))
         {
             status = ReadFile((HANDLE)sock->sd, wsabuf[0].buf, wsabuf[0].len,
                               &sock->reads.size, &sock->reads.overlapped);
@@ -3651,7 +3651,7 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
         ASSERT(ResetEvent(sock->writes.overlapped.hEvent));
         sock->writes.flags = 0;
 
-        if (sock->dco_installed)
+        if (socket_is_dco_win(sock))
         {
             status = WriteFile((HANDLE)sock->sd, wsabuf[0].buf, wsabuf[0].len,
                                &sock->writes.size, &sock->writes.overlapped);
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 605b6ad2..cc963a1c 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -168,7 +168,6 @@ struct link_socket
 
     socket_descriptor_t sd;
     socket_descriptor_t ctrl_sd; /* only used for UDP over Socks */
-    bool dco_installed;
 
 #ifdef _WIN32
     struct overlapped_io reads;
@@ -207,6 +206,7 @@ struct link_socket
 #define SF_PORT_SHARE (1<<2)
 #define SF_HOST_RANDOMIZE (1<<3)
 #define SF_GETADDRINFO_DGRAM (1<<4)
+#define SF_DCO_WIN (1<<5)
     unsigned int sockflags;
     int mark;
     const char *bind_dev;
@@ -1021,6 +1021,12 @@ stream_buf_read_setup(struct link_socket *sock)
     }
 }
 
+static inline bool
+socket_is_dco_win(const struct link_socket *s)
+{
+    return s->sockflags & SF_DCO_WIN;
+}
+
 /*
  * Socket Read Routines
  */
@@ -1036,7 +1042,7 @@ link_socket_read_udp_win32(struct link_socket *sock,
                            struct link_socket_actual *from)
 {
     sockethandle_t sh = { .s = sock->sd };
-    if (sock->dco_installed)
+    if (socket_is_dco_win(sock))
     {
         *from = sock->info.lsa->actual;
         sh.is_handle = true;
@@ -1058,11 +1064,7 @@ link_socket_read(struct link_socket *sock,
                  struct buffer *buf,
                  struct link_socket_actual *from)
 {
-#ifdef _WIN32
-    if (proto_is_udp(sock->info.proto) || sock->dco_installed)
-#else
-    if (proto_is_udp(sock->info.proto))
-#endif
+    if (proto_is_udp(sock->info.proto) || socket_is_dco_win(sock))
     /* unified UDPv4 and UDPv6, for DCO the kernel
      * will strip the length header */
     {
@@ -1105,7 +1107,7 @@ link_socket_write_win32(struct link_socket *sock,
 {
     int err = 0;
     int status = 0;
-    sockethandle_t sh = { .s = sock->sd, .is_handle = sock->dco_installed };
+    sockethandle_t sh = { .s = sock->sd, .is_handle = socket_is_dco_win(sock) };
     if (overlapped_io_active(&sock->writes))
     {
         status = sockethandle_finalize(sh, &sock->writes, NULL, NULL);
@@ -1179,9 +1181,9 @@ link_socket_write(struct link_socket *sock,
                   struct buffer *buf,
                   struct link_socket_actual *to)
 {
-    if (proto_is_udp(sock->info.proto) || sock->dco_installed)
+    if (proto_is_udp(sock->info.proto) || socket_is_dco_win(sock))
     {
-        /* unified UDPv4 and UDPv6 and DCO (kernel adds size header) */
+        /* unified UDPv4 and UDPv6 */
         return link_socket_write_udp(sock, buf, to);
     }
     else if (proto_is_tcp(sock->info.proto)) /* unified TCPv4 and TCPv6 */
-- 
2.39.2


