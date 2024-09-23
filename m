From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 23 Sep 2024 13:41:30 +0000
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2080b9e7d6e7f700844b3735ff6424243c019849-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S9+VPPiJgZI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Bind to multiple
 ipv4/ipv6 addresses
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

--S9+VPPiJgZI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail

to review the following change.


Change subject: Bind to multiple ipv4/ipv6 addresses
......................................................................

Bind to multiple ipv4/ipv6 addresses

Enables the binding of multiple listen
sockets based on the specified "--local"
directives.

The main server loop has been updated
to handle both TCP and UDP connections.

The hash function has also been modified
to include the protocol during the
creation of new client instances.

Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/init.c
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/mudp.c
M src/openvpn/mudp.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/openvpn.h
M src/openvpn/options.c
M src/openvpn/options.h
14 files changed, 419 insertions(+), 278 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/764/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 2246cf7..7559a71 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1764,7 +1764,7 @@
             if (c->options.shaper)
             {
                 int overhead =3D datagram_overhead(c->c2.to_link_addr->des=
t.addr.sa.sa_family,
-                                                 c->options.ce.proto);
+                                                 ls->info.proto);
                 shaper_wrote_bytes(&c->c2.shaper,
                                    BLEN(&c->c2.to_link) + overhead);
             }
@@ -1805,8 +1805,8 @@

                 /* Send packet */
                 size =3D (int)link_socket_write(ls,
-                                         &c->c2.to_link,
-                                         to_addr);
+                                              &c->c2.to_link,
+                                              to_addr);

                 /* Undo effect of prepend */
                 link_socket_write_post_size_adjust(&size, size_delta, &c->=
c2.to_link);
@@ -2054,6 +2054,173 @@
  */

 void
+get_io_flags_dowork_udp(struct context *c, struct multi_protocol *multi_io=
, const unsigned int flags)
+{
+    unsigned int socket =3D 0;
+    unsigned int tuntap =3D 0;
+    static uintptr_t tun_shift =3D 2;
+    static uintptr_t err_shift =3D 4;
+
+    /*
+     * Calculate the flags based on the provided 'flags' argument.
+     */
+    if (flags & IOW_WAIT_SIGNAL)
+    {
+        wait_signal(multi_io->es, (void *)err_shift);
+    }
+
+    if (flags & IOW_TO_LINK)
+    {
+        if (flags & IOW_SHAPER)
+        {
+            /*
+             * If sending this packet would put us over our traffic shaping
+             * quota, don't send -- instead compute the delay we must wait
+             * until it will be OK to send the packet.
+             */
+            int delay =3D 0;
+
+            /* set traffic shaping delay in microseconds */
+            if (c->options.shaper)
+            {
+                delay =3D max_int(delay, shaper_delay(&c->c2.shaper));
+            }
+
+            if (delay < 1000)
+            {
+                socket |=3D EVENT_WRITE;
+            }
+            else
+            {
+                shaper_soonest_event(&c->c2.timeval, delay);
+            }
+        }
+        else
+        {
+            socket |=3D EVENT_WRITE;
+        }
+    }
+    else if (!((flags & IOW_FRAG) && TO_LINK_FRAG(c)))
+    {
+        if (flags & IOW_READ_TUN)
+        {
+            tuntap |=3D EVENT_READ;
+        }
+    }
+
+    /*
+     * If outgoing data (for TUN/TAP device) pending, wait for ready-to-se=
nd status
+     * from device.  Otherwise, wait for incoming data on TCP/UDP port.
+     */
+    if (flags & IOW_TO_TUN)
+    {
+        tuntap |=3D EVENT_WRITE;
+    }
+    else
+    {
+        if (flags & IOW_READ_LINK)
+        {
+            socket |=3D EVENT_READ;
+        }
+    }
+
+    /*
+     * outgoing bcast buffer waiting to be sent?
+     */
+    if (flags & IOW_MBUF)
+    {
+        socket |=3D EVENT_WRITE;
+    }
+
+    /*
+     * Force wait on TUN input, even if also waiting on TCP/UDP output
+     */
+    if (flags & IOW_READ_TUN_FORCE)
+    {
+        tuntap |=3D EVENT_READ;
+    }
+
+#ifdef _WIN32
+    if (tuntap_is_wintun(c->c1.tuntap))
+    {
+        /*
+         * With wintun we are only interested in read event. Ring buffer is
+         * always ready for write, so we don't do wait.
+         */
+        tuntap =3D EVENT_READ;
+    }
+#endif
+
+    /*
+     * Configure event wait based on socket, tuntap flags.
+     */
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        if (proto_is_dgram(c->c2.link_sockets[i]->info.proto))
+        {
+            socket_set(c->c2.link_sockets[i], multi_io->es, socket,
+                       &c->c2.link_sockets[i]->ev_arg, NULL);
+        }
+    }
+    tun_set(c->c1.tuntap, multi_io->es, tuntap, (void *)tun_shift, NULL);
+
+    multi_io->udp_flags =3D socket | tuntap;
+}
+
+void
+get_io_flags_udp(struct context *c, struct multi_protocol *multi_io, const=
 unsigned int flags)
+{
+    multi_io->udp_flags =3D ES_ERROR;
+    if (c->c2.fast_io && (flags & (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))
+    {
+        /* fast path -- only for TUN/TAP/UDP writes */
+        unsigned int ret =3D 0;
+        if (flags & IOW_TO_TUN)
+        {
+            ret |=3D TUN_WRITE;
+        }
+        if (flags & (IOW_TO_LINK | IOW_MBUF))
+        {
+            ret |=3D SOCKET_WRITE;
+        }
+        multi_io->udp_flags =3D ret;
+    }
+    else
+    {
+#ifdef _WIN32
+        bool skip_iowait =3D flags & IOW_TO_TUN;
+        if (flags & IOW_READ_TUN)
+        {
+            /*
+             * don't read from tun if we have pending write to link,
+             * since every tun read overwrites to_link buffer filled
+             * by previous tun read
+             */
+            skip_iowait =3D !(flags & IOW_TO_LINK);
+        }
+        if (tuntap_is_wintun(c->c1.tuntap) && skip_iowait)
+        {
+            unsigned int ret =3D 0;
+            if (flags & IOW_TO_TUN)
+            {
+                ret |=3D TUN_WRITE;
+            }
+            if (flags & IOW_READ_TUN)
+            {
+                ret |=3D TUN_READ;
+            }
+            multi_io->udp_flags =3D ret;
+        }
+        else
+#endif /* ifdef _WIN32 */
+        {
+            /* slow path - delegate to io_wait_dowork_udp to calculate fla=
gs */
+            get_io_flags_dowork_udp(c, multi_io, flags);
+        }
+    }
+}
+
+void
 io_wait_dowork(struct context *c, const unsigned int flags)
 {
     unsigned int socket =3D 0;
@@ -2295,6 +2462,7 @@
     dmsg(D_EVENT_WAIT, "I/O WAIT status=3D0x%04x", c->c2.event_set_status);
 }

+
 void
 process_io(struct context *c, struct link_socket *ls)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 3acbdd0..5fb631f 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -69,6 +69,10 @@

 extern counter_type link_write_bytes_global;

+void get_io_flags_dowork_udp(struct context *c, struct multi_protocol *mul=
ti_io, const unsigned int flags);
+
+void get_io_flags_udp(struct context *c, struct multi_protocol *multi_io, =
const unsigned int flags);
+
 void io_wait_dowork(struct context *c, const unsigned int flags);

 void pre_select(struct context *c);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 6f21752..c817ce6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3756,6 +3756,24 @@
     unsigned int sockflags =3D c->options.sockflags;
     int i;

+    int mode =3D LS_MODE_DEFAULT;
+    /* mode allows CM_CHILD_TCP
+     * instances to inherit acceptable fds
+     * from a top-level parent */
+    if (c->options.mode =3D=3D MODE_SERVER)
+    {
+        /* initializing listening socket */
+        if (c->mode =3D=3D CM_TOP)
+        {
+            mode =3D LS_MODE_TCP_LISTEN;
+        }
+        /* initializing socket to client */
+        else if (c->mode =3D=3D CM_CHILD_TCP)
+        {
+            mode =3D LS_MODE_TCP_ACCEPT_FROM;
+        }
+    }
+
 #if PORT_SHARE
     if (c->options.port_share_host && c->options.port_share_port)
     {
@@ -3765,33 +3783,37 @@

     for (i =3D 0; i < c->c1.link_sockets_num; i++)
     {
-        int mode =3D LS_MODE_DEFAULT;
+        const char *host =3D c->options.ce.local_list->array[i]->local;
+        const char *port =3D c->options.ce.local_list->array[i]->port;
+        int proto =3D c->options.ce.local_list->array[i]->proto;
+        bool bind_local =3D c->options.ce.local_list->array[i]->bind_local;

-        /* mode allows CM_CHILD_TCP
-         * instances to inherit acceptable fds
-         * from a top-level parent */
-        if (c->options.mode =3D=3D MODE_SERVER)
+        if (c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=3D CM_CHILD_UDP)
         {
-            /* initializing listening socket */
-            if (c->mode =3D=3D CM_TOP)
+            const struct link_socket *ls =3D NULL;
+            if (c->mode =3D=3D CM_CHILD_TCP)
             {
-                mode =3D LS_MODE_TCP_LISTEN;
+                ls =3D c->c2.accept_from;
             }
-            /* initializing socket to client */
-            else if (c->mode =3D=3D CM_CHILD_TCP)
+            else if (c->mode =3D=3D CM_CHILD_UDP)
             {
-                mode =3D LS_MODE_TCP_ACCEPT_FROM;
+                ls =3D c->c2.link_sockets[0];
             }
+
+            host =3D ls->local_host;
+            port =3D ls->local_port;
+            proto =3D ls->info.proto;
+            bind_local =3D ls->bind_local;
         }

         /* init each socket with its specific port */
         link_socket_init_phase1(c->c2.link_sockets[i],
-                                c->options.ce.local_list->array[i]->local,
-                                c->options.ce.local_list->array[i]->port,
+                                host,
+                                port,
                                 c->options.ce.remote,
                                 c->options.ce.remote_port,
                                 c->c1.dns_cache,
-                                c->options.ce.proto,
+                                proto,
                                 c->options.ce.af,
                                 c->options.ce.bind_ipv6_only,
                                 mode,
@@ -3801,7 +3823,7 @@
 #ifdef ENABLE_DEBUG
                                 c->options.gremlin,
 #endif
-                                c->options.ce.local_list->array[i]->bind_l=
ocal,
+                                bind_local,
                                 c->options.ce.remote_float,
                                 &c->c1.link_socket_addrs[i],
                                 c->options.ipchange,
@@ -4612,7 +4634,7 @@
     }

     /* our wait-for-i/o objects, different for posix vs. win32 */
-    if (c->mode =3D=3D CM_P2P)
+    if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP)
     {
         do_event_set_init(c, SHAPER_DEFINED(&c->options));
     }
@@ -4876,7 +4898,7 @@
     CLEAR(*dest);

     /* proto_is_dgram will ASSERT(0) if proto is invalid */
-    dest->mode =3D proto_is_dgram(src->options.ce.proto) ? CM_CHILD_UDP : =
CM_CHILD_TCP;
+    dest->mode =3D proto_is_dgram(ls->info.proto) ? CM_CHILD_UDP : CM_CHIL=
D_TCP;

     dest->gc =3D gc_new();

@@ -4904,6 +4926,8 @@
     dest->options =3D src->options;
     options_detach(&dest->options);

+    dest->c2.event_set =3D src->c2.event_set;
+
     if (dest->mode =3D=3D CM_CHILD_TCP)
     {
         /*
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index f4539dc..6c8e8dd 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -421,6 +421,7 @@
                 {
                     buf_printf(&out, ":%d", ntohs(maddr.v4.port));
                 }
+                buf_printf(&out, ":%d", maddr.proto);
             }
             break;

diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 8b457d4..fd1dbfe 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -76,6 +76,7 @@
     uint8_t len;    /* length of address */
     uint8_t unused;
     uint8_t type;   /* MR_ADDR/MR_WITH flags */
+    uint8_t proto;
     uint8_t netbits; /* number of bits in network part of address,
                       * valid if MR_WITH_NETBITS is set */
     union {
@@ -201,6 +202,10 @@
     {
         return false;
     }
+    if (a1->proto !=3D a2->proto)
+    {
+        return false;
+    }
     if (a1->netbits !=3D a2->netbits)
     {
         return false;
@@ -222,7 +227,7 @@
 static inline uint32_t
 mroute_addr_hash_len(const struct mroute_addr *a)
 {
-    return (uint32_t) a->len + 2;
+    return (uint32_t) a->len + 3;
 }

 static inline void
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 29706d0..73f6bcc 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -54,7 +54,7 @@
     struct hash *hash =3D m->hash;

     mi =3D multi_create_instance(m, NULL, ls);
-    if (mi)
+    if (mi && !proto_is_dgram(ls->info.proto))
     {
         struct hash_element *he;
         const uint32_t hv =3D hash_value(hash, &mi->real);
@@ -241,87 +241,3 @@
     }
     return ret;
 }
-
-/*
- * Top level event loop for single-threaded operation.
- * TCP mode.
- */
-void
-tunnel_server_tcp(struct context *top)
-{
-    struct multi_context multi;
-    int status;
-
-    top->mode =3D CM_TOP;
-    context_clear_2(top);
-
-    /* initialize top-tunnel instance */
-    init_instance_handle_signals(top, top->es, CC_HARD_USR1_TO_HUP);
-    if (IS_SIG(top))
-    {
-        return;
-    }
-
-    /* initialize global multi_context object */
-    multi_init(&multi, top, true);
-
-    /* initialize our cloned top object */
-    multi_top_init(&multi, top);
-
-    /* initialize management interface */
-    init_management_callback_multi(&multi);
-
-    /* finished with initialization */
-    initialization_sequence_completed(top, ISC_SERVER); /* --mode server -=
-proto tcp-server */
-
-#ifdef ENABLE_ASYNC_PUSH
-    multi.top.c2.inotify_fd =3D inotify_init();
-    if (multi.top.c2.inotify_fd < 0)
-    {
-        msg(D_MULTI_ERRORS | M_ERRNO, "MULTI: inotify_init error");
-    }
-#endif
-
-    /* per-packet event loop */
-    while (true)
-    {
-        perf_push(PERF_EVENT_LOOP);
-
-        /* wait on tun/socket list */
-        multi_get_timeout(&multi, &multi.top.c2.timeval);
-        status =3D multi_protocol_io_wait(&multi);
-        MULTI_CHECK_SIG(&multi);
-
-        /* check on status of coarse timers */
-        multi_process_per_second_timers(&multi);
-
-        /* timeout? */
-        if (status > 0)
-        {
-            /* process the I/O which triggered select */
-            multi_protocol_process_io(&multi);
-            MULTI_CHECK_SIG(&multi);
-        }
-        else if (status =3D=3D 0)
-        {
-            multi_protocol_action(&multi, NULL, TA_TIMEOUT, false);
-        }
-
-        perf_pop();
-    }
-
-#ifdef ENABLE_ASYNC_PUSH
-    close(top->c2.inotify_fd);
-#endif
-
-    /* shut down management interface */
-    uninit_management_callback();
-
-    /* save ifconfig-pool */
-    multi_ifconfig_pool_persist(&multi, true);
-
-    /* tear down tunnel instance (unless --persist-tun) */
-    multi_uninit(&multi);
-    multi_top_free(&multi);
-    close_instance(top);
-}
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index e48481a..1cc1a51 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -51,17 +51,6 @@

 void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_ins=
tance *mi);

-
-/*************************************************************************=
*/
-/**
- * Main event loop for OpenVPN in TCP server mode.
- * @ingroup eventloop
- *
- * @param top - Top-level context structure.
- */
-void tunnel_server_tcp(struct context *top);
-
-
 void multi_tcp_delete_event(struct multi_protocol *multi_io, event_t event=
);

 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 37af88e..a7e6e1d 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -192,6 +192,7 @@
     struct mroute_addr real =3D {0};
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;
+    real.proto =3D ls->info.proto;

     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
@@ -318,18 +319,66 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link =3D m->hmac_reply;
         m->top.c2.to_link_addr =3D m->hmac_reply_dest;
-        process_outgoing_link(&m->top, m->top.c2.link_sockets[0]);
+        for (int i =3D 0; i < m->top.c1.link_sockets_num; i++)
+        {
+            if (!proto_is_dgram(m->top.c2.link_sockets[i]->info.proto))
+            {
+                continue;
+            }
+
+            process_outgoing_link(&m->top, m->top.c2.link_sockets[i]);
+        }
         m->hmac_reply_dest =3D NULL;
     }
 }

 /*
+ * Return the io_wait() flags appropriate for
+ * a point-to-multipoint tunnel.
+ */
+unsigned int
+p2mp_iow_flags(const struct multi_context *m)
+{
+    unsigned int flags =3D IOW_WAIT_SIGNAL;
+    if (m->pending)
+    {
+        if (TUN_OUT(&m->pending->context))
+        {
+            flags |=3D IOW_TO_TUN;
+        }
+        if (LINK_OUT(&m->pending->context))
+        {
+            flags |=3D IOW_TO_LINK;
+        }
+    }
+    else if (mbuf_defined(m->mbuf))
+    {
+        flags |=3D IOW_MBUF;
+    }
+    else if (m->hmac_reply_dest)
+    {
+        flags |=3D IOW_TO_LINK;
+    }
+    else
+    {
+        flags |=3D IOW_READ;
+    }
+#ifdef _WIN32
+    if (tuntap_ring_empty(m->top.c1.tuntap))
+    {
+        flags &=3D ~IOW_READ_TUN;
+    }
+#endif
+    return flags;
+}
+
+/*
  * Process an I/O event.
  */
-static void
+void
 multi_process_io_udp(struct multi_context *m)
 {
-    const unsigned int status =3D m->top.c2.event_set_status;
+    const unsigned int status =3D m->multi_io->udp_flags;
     const unsigned int mpp_flags =3D m->top.c2.fast_io
                                    ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
                                    : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
@@ -427,123 +476,3 @@
     }
 #endif
 }
-
-/*
- * Return the io_wait() flags appropriate for
- * a point-to-multipoint tunnel.
- */
-static inline unsigned int
-p2mp_iow_flags(const struct multi_context *m)
-{
-    unsigned int flags =3D IOW_WAIT_SIGNAL;
-    if (m->pending)
-    {
-        if (TUN_OUT(&m->pending->context))
-        {
-            flags |=3D IOW_TO_TUN;
-        }
-        if (LINK_OUT(&m->pending->context))
-        {
-            flags |=3D IOW_TO_LINK;
-        }
-    }
-    else if (mbuf_defined(m->mbuf))
-    {
-        flags |=3D IOW_MBUF;
-    }
-    else if (m->hmac_reply_dest)
-    {
-        flags |=3D IOW_TO_LINK;
-    }
-    else
-    {
-        flags |=3D IOW_READ;
-    }
-#ifdef _WIN32
-    if (tuntap_ring_empty(m->top.c1.tuntap))
-    {
-        flags &=3D ~IOW_READ_TUN;
-    }
-#endif
-    return flags;
-}
-
-
-void
-tunnel_server_udp(struct context *top)
-{
-    struct multi_context multi;
-
-    top->mode =3D CM_TOP;
-    context_clear_2(top);
-
-    /* initialize top-tunnel instance */
-    init_instance_handle_signals(top, top->es, CC_HARD_USR1_TO_HUP);
-    if (IS_SIG(top))
-    {
-        return;
-    }
-
-    /* initialize global multi_context object */
-    multi_init(&multi, top, false);
-
-    /* initialize our cloned top object */
-    multi_top_init(&multi, top);
-
-    /* initialize management interface */
-    init_management_callback_multi(&multi);
-
-    /* finished with initialization */
-    initialization_sequence_completed(top, ISC_SERVER); /* --mode server -=
-proto udp */
-
-#ifdef ENABLE_ASYNC_PUSH
-    multi.top.c2.inotify_fd =3D inotify_init();
-    if (multi.top.c2.inotify_fd < 0)
-    {
-        msg(D_MULTI_ERRORS | M_ERRNO, "MULTI: inotify_init error");
-    }
-#endif
-
-    /* per-packet event loop */
-    while (true)
-    {
-        perf_push(PERF_EVENT_LOOP);
-
-        /* set up and do the io_wait() */
-        multi_get_timeout(&multi, &multi.top.c2.timeval);
-        io_wait(&multi.top, p2mp_iow_flags(&multi));
-        MULTI_CHECK_SIG(&multi);
-
-        /* check on status of coarse timers */
-        multi_process_per_second_timers(&multi);
-
-        /* timeout? */
-        if (multi.top.c2.event_set_status =3D=3D ES_TIMEOUT)
-        {
-            multi_process_timeout(&multi, MPP_PRE_SELECT|MPP_CLOSE_ON_SIGN=
AL);
-        }
-        else
-        {
-            /* process I/O */
-            multi_process_io_udp(&multi);
-            MULTI_CHECK_SIG(&multi);
-        }
-
-        perf_pop();
-    }
-
-#ifdef ENABLE_ASYNC_PUSH
-    close(top->c2.inotify_fd);
-#endif
-
-    /* shut down management interface */
-    uninit_management_callback();
-
-    /* save ifconfig-pool */
-    multi_ifconfig_pool_persist(&multi, true);
-
-    /* tear down tunnel instance (unless --persist-tun) */
-    multi_uninit(&multi);
-    multi_top_free(&multi);
-    close_instance(top);
-}
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index b378754..68d2d6d 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -31,18 +31,9 @@
 struct context;
 struct multi_context;

+unsigned int p2mp_iow_flags(const struct multi_context *m);

-/**
- * Main event loop for OpenVPN in UDP server mode.
- * @ingroup eventloop
- *
- * This function implements OpenVPN's main event loop for UDP server mode.
- *
- * @param top - Top-level context structure.
- */
-void tunnel_server_udp(struct context *top);
-
-
+void multi_process_io_udp(struct multi_context *m);
 /*************************************************************************=
*/
 /**
  * Get, and if necessary create, the multi_instance associated with a
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d7b4e3b..2d4fbe7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -289,7 +289,7 @@
  * Main initialization function, init multi_context object.
  */
 void
-multi_init(struct multi_context *m, struct context *t, bool tcp_mode)
+multi_init(struct multi_context *m, struct context *t)
 {
     int dev =3D DEV_TYPE_UNDEF;

@@ -435,13 +435,12 @@

     m->instances =3D calloc(m->max_clients, sizeof(struct multi_instance *=
));

+    m->top.c2.event_set =3D t->c2.event_set;
+
     /*
-     * Initialize multi-socket TCP I/O wait object
+     * Initialize multi-socket I/O wait object
      */
-    if (tcp_mode)
-    {
-        m->multi_io =3D multi_protocol_init(t->options.max_clients, &m->ma=
x_clients);
-    }
+    m->multi_io =3D multi_protocol_init(t->options.max_clients, &m->max_cl=
ients);
     m->tcp_queue_limit =3D t->options.tcp_queue_limit;

     /*
@@ -665,7 +664,7 @@
             mi->did_iroutes =3D false;
         }

-        if (m->multi_io)
+        if (m->multi_io && !proto_is_dgram(m->top.options.ce.proto))
         {
             multi_tcp_dereference_instance(m->multi_io, mi);
         }
@@ -776,7 +775,6 @@
         mi->real =3D *real;
         generate_prefix(mi);
     }
-
     mi->did_open_context =3D true;
     inherit_context_child(&mi->context, &m->top, ls);
     if (IS_SIG(&mi->context))
@@ -798,6 +796,7 @@
         {
             goto err;
         }
+        mi->real.proto =3D ls->info.proto;
         generate_prefix(mi);
     }

@@ -4158,6 +4157,98 @@
     ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
 }

+/*************************************************************************=
*/
+/**
+ * Main event loop for OpenVPN in multi-protocol server mode.
+ * @ingroup eventloop
+ *
+ * @param top - Top-level context structure.
+ */
+void
+tunnel_server_loop(struct multi_context *multi)
+{
+    int status;
+
+    while (true)
+    {
+        perf_push(PERF_EVENT_LOOP);
+
+        /* wait on tun/socket list */
+        multi_get_timeout(multi, &multi->top.c2.timeval);
+        status =3D multi_protocol_io_wait(multi);
+        MULTI_CHECK_SIG(multi);
+
+        /* check on status of coarse timers */
+        multi_process_per_second_timers(multi);
+
+        /* timeout? */
+        if (status > 0)
+        {
+            /* process the I/O which triggered select */
+            multi_protocol_process_io(multi);
+            MULTI_CHECK_SIG(multi);
+        }
+        else if (status =3D=3D 0)
+        {
+            multi_protocol_action(multi, NULL, TA_TIMEOUT, false);
+        }
+
+        perf_pop();
+    }
+}
+
+void
+tunnel_server_init(struct context *top)
+{
+    struct multi_context multi;
+
+    top->mode =3D CM_TOP;
+    context_clear_2(top);
+
+    /* initialize top-tunnel instance */
+    init_instance_handle_signals(top, top->es, CC_HARD_USR1_TO_HUP);
+    if (IS_SIG(top))
+    {
+        return;
+    }
+
+    /* initialize global multi_context object */
+    multi_init(&multi, top);
+
+    /* initialize our cloned top object */
+    multi_top_init(&multi, top);
+
+    /* initialize management interface */
+    init_management_callback_multi(&multi);
+
+    /* finished with initialization */
+    initialization_sequence_completed(top, ISC_SERVER); /* --mode server -=
-proto tcp-server */
+
+#ifdef ENABLE_ASYNC_PUSH
+    multi.top.c2.inotify_fd =3D inotify_init();
+    if (multi.top.c2.inotify_fd < 0)
+    {
+        msg(D_MULTI_ERRORS | M_ERRNO, "MULTI: inotify_init error");
+    }
+#endif
+
+    tunnel_server_loop(&multi);
+
+    #ifdef ENABLE_ASYNC_PUSH
+    close(top->c2.inotify_fd);
+#endif
+
+    /* shut down management interface */
+    uninit_management_callback();
+
+    /* save ifconfig-pool */
+    multi_ifconfig_pool_persist(&multi, true);
+
+    /* tear down tunnel instance (unless --persist-tun) */
+    multi_uninit(&multi);
+    multi_top_free(&multi);
+    close_instance(top);
+}

 /*
  * Top level event loop.
@@ -4167,12 +4258,6 @@
 {
     ASSERT(top->options.mode =3D=3D MODE_SERVER);

-    if (proto_is_dgram(top->options.ce.proto))
-    {
-        tunnel_server_udp(top);
-    }
-    else
-    {
-        tunnel_server_tcp(top);
-    }
+    tunnel_server_init(top);
+
 }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index a25aeda..65fd320 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -247,10 +247,8 @@
  * Main event loop for OpenVPN in server mode.
  * @ingroup eventloop
  *
- * This function calls the appropriate main event loop function depending
- * on the transport protocol used:
- *  - \c tunnel_server_udp()
- *  - \c tunnel_server_tcp()
+ * This function calls the main event loop function
+ * on the transport protocols:
  *
  * @param top          - Top-level context structure.
  */
@@ -263,7 +261,7 @@
  * Called by mtcp.c, mudp.c, or other (to be written) protocol drivers
  */

-void multi_init(struct multi_context *m, struct context *t, bool tcp_mode);
+void multi_init(struct multi_context *m, struct context *t);

 void multi_uninit(struct multi_context *m);

@@ -659,9 +657,12 @@
 multi_process_outgoing_tun(struct multi_context *m, const unsigned int mpp=
_flags)
 {
     struct multi_instance *mi =3D m->pending;
+    if (!mi)
+    {
+        return false;
+    }
     bool ret =3D true;

-    ASSERT(mi);
 #ifdef MULTI_DEBUG_EVENT_LOOP
     printf("%s -> TUN len=3D%d\n",
            id(mi),
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 77bb41d..821ac2e 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -220,8 +220,8 @@
  * \c SIGUSR1 restarts.
  *
  * This structure is initialized at the top of the \c
- * tunnel_point_to_point(), \c tunnel_server_udp(), and \c
- * tunnel_server_tcp() functions.  In other words, it is reset for every
+ * tunnel_point_to_point(), \c tunnel_server() \c
+ * functions.  In other words, it is reset for every
  * iteration of the \c main() function's inner \c SIGUSR1 loop.
  */
 struct context_2
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 25bdd44..42210da 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2199,6 +2199,7 @@
     }

     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);
+    e->proto =3D PROTO_NONE;
     l->array[l->len++] =3D e;
=20
     return e;
@@ -3170,14 +3171,30 @@
         if (ce->proto =3D=3D PROTO_TCP)
         {
             ce->proto =3D PROTO_TCP_SERVER;
+            o->ce.proto =3D ce->proto;
+        }
+        if (ce->local_list)
+        {
+            for (int i =3D 0; i < ce->local_list->len; i++)
+            {
+                if (ce->local_list->array[i]->proto =3D=3D PROTO_TCP)
+                {
+                    ce->local_list->array[i]->proto =3D PROTO_TCP_SERVER;
+                }
+                else if (ce->local_list->array[i]->proto =3D=3D PROTO_NONE)
+                {
+                    ce->local_list->array[i]->proto =3D ce->proto;
+                }
+            }
         }
     }

-    if (o->client)
+    if (o->mode !=3D MODE_SERVER)
     {
         if (ce->proto =3D=3D PROTO_TCP)
         {
             ce->proto =3D PROTO_TCP_CLIENT;
+            o->ce.proto =3D ce->proto;
         }
     }

@@ -3331,6 +3348,10 @@
     {
         le->port =3D o->ce.local_port;
     }
+    if (!le->proto)
+    {
+        le->proto =3D o->ce.proto;
+    }
 }

 #ifdef _WIN32
@@ -3822,6 +3843,7 @@
         ASSERT(e);
         e->port =3D o->ce.local_port;
         e->bind_local =3D o->ce.bind_local;
+        e->proto =3D o->ce.proto;
     }

     /* use the same listen list for every outgoing connection */
@@ -6232,7 +6254,7 @@
         VERIFY_PERMISSION(OPT_P_UP);
         options->ifconfig_nowarn =3D true;
     }
-    else if (streq(p[0], "local") && p[1] && !p[3])
+    else if (streq(p[0], "local") && p[1] && !p[4])
     {
         struct local_entry *e;

@@ -6253,7 +6275,12 @@
         if (p[2])
         {
             e->port =3D p[2];
-            e->bind_local =3D true;
+            /*e->bind_local =3D true; */
+        }
+
+        if (p[3])
+        {
+            e->proto =3D ascii2proto(p[3]);
         }
     }
     else if (streq(p[0], "remote-random") && !p[1])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 6942455..f3cf7e5 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -99,6 +99,7 @@
     const char *local;
     const char *port;
     bool bind_local;
+    int proto;
 };

 struct connection_entry

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Gerrit-Change-Number: 764
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--S9+VPPiJgZI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Bind to multiple ipv4/ipv6 addresses<br><br>Enables the bindi=
ng of multiple listen<br>sockets based on the specified &quot;--local&quot;=
<br>directives.<br><br>The main server loop has been updated<br>to handle b=
oth TCP and UDP connections.<br><br>The hash function has also been modifie=
d<br>to include the protocol during the<br>creation of new client instances=
.<br><br>Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363<br>Signed-off=
-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/open=
vpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/init.c<br>M src/o=
penvpn/mroute.c<br>M src/openvpn/mroute.h<br>M src/openvpn/mtcp.c<br>M src/=
openvpn/mtcp.h<br>M src/openvpn/mudp.c<br>M src/openvpn/mudp.h<br>M src/ope=
nvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/openvpn.h<br>M src/o=
penvpn/options.c<br>M src/openvpn/options.h<br>14 files changed, 419 insert=
ions(+), 278 deletions(-)<br><br></pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/64/764/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b=
/src/openvpn/forward.c</span><br><span>index 2246cf7..7559a71 100644</span>=
<br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/for=
ward.c</span><br><span>@@ -1764,7 +1764,7 @@</span><br><span>             i=
f (c-&gt;options.shaper)</span><br><span>             {</span><br><span>   =
              int overhead =3D datagram_overhead(c-&gt;c2.to_link_addr-&gt;=
dest.addr.sa.sa_family,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                                 c-&gt;options.ce.proto);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                              ls-&gt;info.proto);</span><br><span>         =
        shaper_wrote_bytes(&amp;c-&gt;c2.shaper,</span><br><span>          =
                          BLEN(&amp;c-&gt;c2.to_link) + overhead);</span><b=
r><span>             }</span><br><span>@@ -1805,8 +1805,8 @@</span><br><spa=
n> </span><br><span>                 /* Send packet */</span><br><span>    =
             size =3D (int)link_socket_write(ls,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                         &amp;c-=
&gt;c2.to_link,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                                   to_addr);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                              &amp=
;c-&gt;c2.to_link,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                             to_addr);</span><br><span> </s=
pan><br><span>                 /* Undo effect of prepend */</span><br><span=
>                 link_socket_write_post_size_adjust(&amp;size, size_delta,=
 &amp;c-&gt;c2.to_link);</span><br><span>@@ -2054,6 +2054,173 @@</span><br>=
<span>  */</span><br><span> </span><br><span> void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+get_io_flags_dowork_udp(struct context *c, s=
truct multi_protocol *multi_io, const unsigned int flags)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    unsigned int socket =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    unsigned int tuntap =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t tun_shift =
=3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static ui=
ntptr_t err_shift =3D 4;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * Calculate the flags =
based on the provided &#39;flags&#39; argument.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (flags &amp; IOW_WAIT_SIGNAL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        wait_signal(multi_io-&gt;es, (void *)err_shift)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (flags &amp; IOW_TO_LINK)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (flags &amp; IOW_SHAPER)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            /*</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             * If sending this packet would put us =
over our traffic shaping</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+             * quota, don&#39;t send -- instead compute the delay we m=
ust wait</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
  * until it will be OK to send the packet.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            int delay =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            /* set traffic shaping delay in microseconds */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (c-&gt;opt=
ions.shaper)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   delay =3D max_int(delay, shaper_delay(&amp;c-&gt;c2.shaper));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (delay &lt; 1000)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                socket |=3D EVENT_WRITE;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                shaper_soonest_event(&amp=
;c-&gt;c2.timeval, delay);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            socket |=3D EV=
ENT_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else if (!((flags &amp; IOW_F=
RAG) &amp;&amp; TO_LINK_FRAG(c)))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (flags &amp; IOW_READ_TUN)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            tuntap |=3D EVENT_READ;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * If outgoing data (for TUN=
/TAP device) pending, wait for ready-to-send status</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * from device.  Otherwise, wait for =
incoming data on TCP/UDP port.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     tuntap |=3D EVENT_WRITE;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp; IOW_R=
EAD_LINK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            socket |=
=3D EVENT_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * outgoing bcast buffer waiting to be sent?</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; IOW_MBUF)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        socket |=3D EVENT_WRITE;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * Force wait on TUN input, even if also waiting on TCP/UDP output</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; IOW_READ_TUN_FORCE)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        tuntap |=3D EVENT_READ;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (tuntap_is_wintun(c-&gt;c1.tuntap))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * With wintun we are only interested in read event.=
 Ring buffer is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * always ready for write, so we don&#39;t do wait.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        tuntap =3D EVENT_READ;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Configure eve=
nt wait based on socket, tuntap flags.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (proto_is_dgram(c-&gt;c2.link_=
sockets[i]-&gt;info.proto))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          socket_set(c-&gt;c2.link_sockets[i], multi_io-&gt;es, socket,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
&amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg, NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    tun_set(c-&gt;c1.tuntap, multi_io-&gt;es, tuntap, (void *)tun_shif=
t, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;udp_flags =
=3D socket | tuntap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+get_io_flags_udp(struct context *c, struct multi_pr=
otocol *multi_io, const unsigned int flags)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (c-&gt;c2.fast_io &amp;&amp; (flags &amp;=
 (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* fast path -- only for TUN/TAP/UDP writes */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        unsigned int ret =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &am=
p; IOW_TO_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret=
 |=3D TUN_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (f=
lags &amp; (IOW_TO_LINK | IOW_MBUF))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            ret |=3D SOCKET_WRITE;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        multi_io-&gt;udp_flags =3D ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        boo=
l skip_iowait =3D flags &amp; IOW_TO_TUN;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (flags &amp; IOW_READ_TUN)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             * don&#39;t read from tun if we have =
pending write to link,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+             * since every tun read overwrites to_link buffer filled</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+             * by previ=
ous tun read</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 skip_iowait =3D !(flags &amp; IOW_TO_LINK);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (tuntap_is_wintun(c-&gt;c1.tuntap) &amp;&amp; ski=
p_iowait)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            unsigned=
 int ret =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                ret |=3D TUN_WRITE;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (flags &amp; IOW_READ_TUN)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                ret |=3D TUN_READ;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            multi_io-&gt;udp_f=
lags =3D ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef _WIN32 =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            /* slow path - =
delegate to io_wait_dowork_udp to calculate flags */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            get_io_flags_dowork_udp(c, mu=
lti_io, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span> io_wait_dowork(struct context *c, const uns=
igned int flags)</span><br><span> {</span><br><span>     unsigned int socke=
t =3D 0;</span><br><span>@@ -2295,6 +2462,7 @@</span><br><span>     dmsg(D_=
EVENT_WAIT, &quot;I/O WAIT status=3D0x%04x&quot;, c-&gt;c2.event_set_status=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> void</span><br><span> process_io(stru=
ct context *c, struct link_socket *ls)</span><br><span> {</span><br><span>d=
iff --git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>i=
ndex 3acbdd0..5fb631f 100644</span><br><span>--- a/src/openvpn/forward.h</s=
pan><br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -69,6 +69,10 @=
@</span><br><span> </span><br><span> extern counter_type link_write_bytes_g=
lobal;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void get_io_flags_dowork_udp(struct context *c, struct multi_protocol =
*multi_io, const unsigned int flags);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid get_io_flags_udp(struct context *c, struct multi_protocol *multi_io, co=
nst unsigned int flags);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> void io_wait_dowork(struct context *c, const unsigne=
d int flags);</span><br><span> </span><br><span> void pre_select(struct con=
text *c);</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/ini=
t.c</span><br><span>index 6f21752..c817ce6 100644</span><br><span>--- a/src=
/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@=
 -3756,6 +3756,24 @@</span><br><span>     unsigned int sockflags =3D c-&gt;=
options.sockflags;</span><br><span>     int i;</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int mode =3D LS_MODE_DEFAU=
LT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* mode allo=
ws CM_CHILD_TCP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * instances to inherit acceptable fds</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * from a top-level parent */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options.mode =3D=3D MODE_SE=
RVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* initializing list=
ening socket */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            mode =3D LS_MODE_TCP_LISTEN;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* initializing socket to client */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        else if (c-&gt;mode =3D=3D C=
M_CHILD_TCP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mode =
=3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> #if PORT_SHARE</span><br><span>     if (c-&gt;options.port_share_host &a=
mp;&amp; c-&gt;options.port_share_port)</span><br><span>     {</span><br><s=
pan>@@ -3765,33 +3783,37 @@</span><br><span> </span><br><span>     for (i =
=3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        int mode =3D LS_MODE=
_DEFAULT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst char *host =3D c-&gt;options.ce.local_list-&gt;array[i]-&gt;local;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *port=
 =3D c-&gt;options.ce.local_list-&gt;array[i]-&gt;port;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        int proto =3D c-&gt;options.ce.=
local_list-&gt;array[i]-&gt;proto;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        bool bind_local =3D c-&gt;options.ce.local_list-&gt;=
array[i]-&gt;bind_local;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* mode allows CM_CHILD_TCP</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-         * instances to inherit acceptab=
le fds</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * from=
 a top-level parent */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (c-&gt;options.mode =3D=3D MODE_SERVER)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;mode =3D=3D CM_CHILD_TC=
P || c-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            /* initializing liste=
ning socket */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            const struct link_socket *ls =3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (c-&gt;mode =
=3D=3D CM_CHILD_TCP)</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                mode =3D LS_MODE_TCP_LISTEN=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ls=
 =3D c-&gt;c2.accept_from;</span><br><span>             }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            /* initializing socket to c=
lient */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e=
lse if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            else if (c-&gt;mode =3D=3D CM_CHILD_UDP)</s=
pan><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                mode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                ls =3D c-&gt;c2.link_s=
ockets[0];</span><br><span>             }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            host =3D ls-&gt;local_host;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            port =3D ls-&gt;local_port;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            proto =3D ls-&gt;inf=
o.proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 bind_local =3D ls-&gt;bind_local;</span><br><span>         }</span><br><sp=
an> </span><br><span>         /* init each socket with its specific port */=
</span><br><span>         link_socket_init_phase1(c-&gt;c2.link_sockets[i],=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
           c-&gt;options.ce.local_list-&gt;array[i]-&gt;local,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                c-=
&gt;options.ce.local_list-&gt;array[i]-&gt;port,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                host,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
    port,</span><br><span>                                 c-&gt;options.ce=
.remote,</span><br><span>                                 c-&gt;options.ce.=
remote_port,</span><br><span>                                 c-&gt;c1.dns_=
cache,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                 c-&gt;options.ce.proto,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                proto,</span><br><span=
>                                 c-&gt;options.ce.af,</span><br><span>    =
                             c-&gt;options.ce.bind_ipv6_only,</span><br><sp=
an>                                 mode,</span><br><span>@@ -3801,7 +3823,=
7 @@</span><br><span> #ifdef ENABLE_DEBUG</span><br><span>                 =
                c-&gt;options.gremlin,</span><br><span> #endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                c-=
&gt;options.ce.local_list-&gt;array[i]-&gt;bind_local,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                bind_loc=
al,</span><br><span>                                 c-&gt;options.ce.remot=
e_float,</span><br><span>                                 &amp;c-&gt;c1.lin=
k_socket_addrs[i],</span><br><span>                                 c-&gt;o=
ptions.ipchange,</span><br><span>@@ -4612,7 +4634,7 @@</span><br><span>    =
 }</span><br><span> </span><br><span>     /* our wait-for-i/o objects, diff=
erent for posix vs. win32 */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (c-&gt;mode =3D=3D CM_P2P)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D =
CM_TOP)</span><br><span>     {</span><br><span>         do_event_set_init(c=
, SHAPER_DEFINED(&amp;c-&gt;options));</span><br><span>     }</span><br><sp=
an>@@ -4876,7 +4898,7 @@</span><br><span>     CLEAR(*dest);</span><br><span=
> </span><br><span>     /* proto_is_dgram will ASSERT(0) if proto is invali=
d */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dest-&gt;mode=
 =3D proto_is_dgram(src-&gt;options.ce.proto) ? CM_CHILD_UDP : CM_CHILD_TCP=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;mode =
=3D proto_is_dgram(ls-&gt;info.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;</span>=
<br><span> </span><br><span>     dest-&gt;gc =3D gc_new();</span><br><span>=
 </span><br><span>@@ -4904,6 +4926,8 @@</span><br><span>     dest-&gt;optio=
ns =3D src-&gt;options;</span><br><span>     options_detach(&amp;dest-&gt;o=
ptions);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    dest-&gt;c2.event_set =3D src-&gt;c2.event_set;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (dest-&gt;m=
ode =3D=3D CM_CHILD_TCP)</span><br><span>     {</span><br><span>         /*=
</span><br><span>diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</=
span><br><span>index f4539dc..6c8e8dd 100644</span><br><span>--- a/src/open=
vpn/mroute.c</span><br><span>+++ b/src/openvpn/mroute.c</span><br><span>@@ =
-421,6 +421,7 @@</span><br><span>                 {</span><br><span>       =
              buf_printf(&amp;out, &quot;:%d&quot;, ntohs(maddr.v4.port));<=
/span><br><span>                 }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                buf_printf(&amp;out, &quot;:%d&quot;, maddr.=
proto);</span><br><span>             }</span><br><span>             break;<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/mroute.h b/src/o=
penvpn/mroute.h</span><br><span>index 8b457d4..fd1dbfe 100644</span><br><sp=
an>--- a/src/openvpn/mroute.h</span><br><span>+++ b/src/openvpn/mroute.h</s=
pan><br><span>@@ -76,6 +76,7 @@</span><br><span>     uint8_t len;    /* len=
gth of address */</span><br><span>     uint8_t unused;</span><br><span>    =
 uint8_t type;   /* MR_ADDR/MR_WITH flags */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint8_t proto;</span><br><span>     uint8_t ne=
tbits; /* number of bits in network part of address,</span><br><span>      =
                 * valid if MR_WITH_NETBITS is set */</span><br><span>     =
union {</span><br><span>@@ -201,6 +202,10 @@</span><br><span>     {</span><=
br><span>         return false;</span><br><span>     }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (a1-&gt;proto !=3D a2-&gt;proto)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     if (a=
1-&gt;netbits !=3D a2-&gt;netbits)</span><br><span>     {</span><br><span> =
        return false;</span><br><span>@@ -222,7 +227,7 @@</span><br><span> =
static inline uint32_t</span><br><span> mroute_addr_hash_len(const struct m=
route_addr *a)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return (uint32_t) a-&gt;len + 2;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return (uint32_t) a-&gt;len + 3;</span><br=
><span> }</span><br><span> </span><br><span> static inline void</span><br><=
span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>i=
ndex 29706d0..73f6bcc 100644</span><br><span>--- a/src/openvpn/mtcp.c</span=
><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -54,7 +54,7 @@</span=
><br><span>     struct hash *hash =3D m-&gt;hash;</span><br><span> </span><=
br><span>     mi =3D multi_create_instance(m, NULL, ls);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (mi)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; !proto_is_dgram(ls-&gt;inf=
o.proto))</span><br><span>     {</span><br><span>         struct hash_eleme=
nt *he;</span><br><span>         const uint32_t hv =3D hash_value(hash, &am=
p;mi-&gt;real);</span><br><span>@@ -241,87 +241,3 @@</span><br><span>     }=
</span><br><span>     return ret;</span><br><span> }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Top l=
evel event loop for single-threaded operation.</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * TCP mode.</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tunnel_server_tcp(s=
truct context *top)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_conte=
xt multi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int stat=
us;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    top-&gt;mode =3D CM_TOP;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    context_clear_2(top);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* initialize top-tunnel instance */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    init_instance_handle_signa=
ls(top, top-&gt;es, CC_HARD_USR1_TO_HUP);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (IS_SIG(top))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* initialize global multi_context o=
bject */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_ini=
t(&amp;multi, top, true);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* initialize=
 our cloned top object */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    multi_top_init(&amp;multi, top);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  /* initialize management interface */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    init_management_callback_multi(&amp;multi);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* finished with initialization */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    initialization_sequence_complet=
ed(top, ISC_SERVER); /* --mode server --proto tcp-server */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    multi.top.c2.inotify_fd =3D inotify_init();</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (multi.top.c2.inotify_=
fd &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_ERRORS =
| M_ERRNO, &quot;MULTI: inotify_init error&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* per-packet event=
 loop */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (tr=
ue)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        perf_push(PERF_EVENT_LOOP)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /* wait on tun/socket list */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_get_timeout=
(&amp;multi, &amp;multi.top.c2.timeval);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        status =3D multi_protocol_io_wait(&amp;multi);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MULTI_CHECK_SIG=
(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /* check on status of=
 coarse timers */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    multi_process_per_second_timers(&amp;multi);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        /* timeout? */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (status &gt; 0)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            /* process the I/O which triggered select */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            multi_protocol_process_io(&a=
mp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 MULTI_CHECK_SIG(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    else if (status =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        multi_protocol_action(&amp;multi, NULL, TA_TIMEOUT, false);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        perf_pop();</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    close(top-&gt;c2.in=
otify_fd);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* shut down management interface */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    uninit_management_callba=
ck();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* save ifconfig-pool */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    multi_ifconfig_pool_persis=
t(&amp;multi, true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tear down tunne=
l instance (unless --persist-tun) */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    multi_uninit(&amp;multi);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    multi_top_free(&amp;multi);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    close_instance(top);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --git a/src/open=
vpn/mtcp.h b/src/openvpn/mtcp.h</span><br><span>index e48481a..1cc1a51 1006=
44</span><br><span>--- a/src/openvpn/mtcp.h</span><br><span>+++ b/src/openv=
pn/mtcp.h</span><br><span>@@ -51,17 +51,6 @@</span><br><span> </span><br><s=
pan> void multi_tcp_link_out_deferred(struct multi_context *m, struct multi=
_instance *mi);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/********=
******************************************************************/</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Main event loop for OpenVPN in TCP server mo=
de.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ingroup eventl=
oop</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * @param top - Top-level context str=
ucture.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void tunnel_server_tcp(struct co=
ntext *top);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void multi_t=
cp_delete_event(struct multi_protocol *multi_io, event_t event);</span><br>=
<span> </span><br><span> #endif /* ifndef MTCP_H */</span><br><span>diff --=
git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 37af88e=
..a7e6e1d 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+=
++ b/src/openvpn/mudp.c</span><br><span>@@ -192,6 +192,7 @@</span><br><span=
>     struct mroute_addr real =3D {0};</span><br><span>     struct multi_in=
stance *mi =3D NULL;</span><br><span>     struct hash *hash =3D m-&gt;hash;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    real.proto =3D =
ls-&gt;info.proto;</span><br><span> </span><br><span>     if (mroute_extrac=
t_openvpn_sockaddr(&amp;real, &amp;m-&gt;top.c2.from.dest, true)</span><br>=
<span>         &amp;&amp; m-&gt;top.c2.buf.len &gt; 0)</span><br><span>@@ -=
318,18 +319,66 @@</span><br><span>         msg_set_prefix(&quot;Connection =
Attempt&quot;);</span><br><span>         m-&gt;top.c2.to_link =3D m-&gt;hma=
c_reply;</span><br><span>         m-&gt;top.c2.to_link_addr =3D m-&gt;hmac_=
reply_dest;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pr=
ocess_outgoing_link(&amp;m-&gt;top, m-&gt;top.c2.link_sockets[0]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i =
&lt; m-&gt;top.c1.link_sockets_num; i++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (!proto_is_dgram(m-&gt;top.c2.link_sockets[i]-&gt=
;info.proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            process_outgoing_li=
nk(&amp;m-&gt;top, m-&gt;top.c2.link_sockets[i]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span>         m-&gt;hmac=
_reply_dest =3D NULL;</span><br><span>     }</span><br><span> }</span><br><=
span> </span><br><span> /*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Return the io_wait() flags appropriate for</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * a point-to-multipoint tunnel.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+p2mp_iow_flags(const struct multi_context *m)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D IOW_WAIT_SIGNA=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;pen=
ding)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (TUN_OUT(&amp;m-&=
gt;pending-&gt;context))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       flags |=3D IOW_TO_TUN;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (LINK_OUT(&amp;m-&gt;pending-&gt;context))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            flags |=3D IOW_TO_LINK;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (mbuf_defined(m-&gt;mbuf))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        flags |=3D IOW_MBUF;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (m-&gt;hmac_reply_dest)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        flags |=3D IOW_TO_LINK;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   flags |=3D IOW_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WI=
N32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tuntap_r=
ing_empty(m-&gt;top.c1.tuntap))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      flags &amp;=3D ~IOW_READ_TUN;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span>  * Process an I/O event.</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span> multi_process_io_udp(struct multi_context *m)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned int s=
tatus =3D m-&gt;top.c2.event_set_status;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const unsigned int status =3D m-&gt;multi_io-&gt;u=
dp_flags;</span><br><span>     const unsigned int mpp_flags =3D m-&gt;top.c=
2.fast_io</span><br><span>                                    ? (MPP_CONDIT=
IONAL_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)</span><br><span>                   =
                 : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span>=
@@ -427,123 +476,3 @@</span><br><span>     }</span><br><span> #endif</span>=
<br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Return the io_wait() flags appropriate for</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * a point-to-multipoint =
tunnel.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static inline unsigned int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-p2mp_iow_flags(const struct=
 multi_context *m)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int flags =
=3D IOW_WAIT_SIGNAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (m-&gt;pending)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (TUN_=
OUT(&amp;m-&gt;pending-&gt;context))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            flags |=3D IOW_TO_TUN;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (LINK_OUT(&amp;m-&gt;pending-&gt;context))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            flags |=3D IOW_TO_LINK;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    else if (mbuf_defined(m-&gt;mbuf))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        flags |=3D IOW_MBUF;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else if (m-&gt;hmac_reply_dest)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        flags |=3D IOW_TO_LINK;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        flags |=3D IOW_READ;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (tuntap_ring_empty(m-&gt;top.c1.tuntap))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        flags &amp;=3D ~IOW_READ_TUN;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return flags;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-tunnel_server_udp(struct context *top)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct multi_context multi;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 top-&gt;mode =3D CM_TOP;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    context_clear_2(top);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* initia=
lize top-tunnel instance */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    init_instance_handle_signals(top, top-&gt;es, CC_HARD_USR1_TO_HUP=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (IS_SIG(top)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* initialize global multi_context object */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    multi_init(&amp;multi, top, false);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* initialize our cloned top object */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    multi_top_init(&amp;multi, top=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* initialize management interface *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_management_=
callback_multi(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* finished=
 with initialization */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    initialization_sequence_completed(top, ISC_SERVER); /* --mode server =
--proto udp */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi.top.c2.inotify_=
fd =3D inotify_init();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (multi.top.c2.inotify_fd &lt; 0)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(D_MULTI_ERRORS | M_ERRNO, &quot;MULTI: inotify_init error&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* per-packet event loop */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    while (true)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    perf_push(PERF_EVENT_LOOP);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* =
set up and do the io_wait() */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        multi_get_timeout(&amp;multi, &amp;multi.top.c2.timeval);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        io_wait(&amp;m=
ulti.top, p2mp_iow_flags(&amp;multi));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        MULTI_CHECK_SIG(&amp;multi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* check on status of coarse timers */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        multi_process_per_second_timers=
(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /* timeout? */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (multi.top.c2.eve=
nt_set_status =3D=3D ES_TIMEOUT)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           multi_process_timeout(&amp;multi, MPP_PRE_SELECT|MPP_CLOSE_ON_SI=
GNAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            /* process I/O */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            multi_process_io_udp(&amp;mu=
lti);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MULT=
I_CHECK_SIG(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    close(top-&gt;c2.inotify_fd);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* shut dow=
n management interface */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    uninit_management_callback();</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* save ifconfig-pool */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    multi_ifconfig_pool_persist(&amp;multi, true);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* tear down tunnel instance (unless --persist-tun) */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_uninit(&amp;multi=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_top_free(=
&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    close=
_instance(top);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span>diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h</span><br>=
<span>index b378754..68d2d6d 100644</span><br><span>--- a/src/openvpn/mudp.=
h</span><br><span>+++ b/src/openvpn/mudp.h</span><br><span>@@ -31,18 +31,9 =
@@</span><br><span> struct context;</span><br><span> struct multi_context;<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+un=
signed int p2mp_iow_flags(const struct multi_context *m);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Main event loop for OpenVPN in UDP s=
erver mode.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ingrou=
p eventloop</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * This function implements O=
penVPN&#39;s main event loop for UDP server mode.</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @param top - Top-level context structure.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void tunnel_server_udp(struct context *top);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d multi_process_io_udp(struct multi_context *m);</span><br><span> /********=
******************************************************************/</span><=
br><span> /**</span><br><span>  * Get, and if necessary create, the multi_i=
nstance associated with a</span><br><span>diff --git a/src/openvpn/multi.c =
b/src/openvpn/multi.c</span><br><span>index d7b4e3b..2d4fbe7 100644</span><=
br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.=
c</span><br><span>@@ -289,7 +289,7 @@</span><br><span>  * Main initializati=
on function, init multi_context object.</span><br><span>  */</span><br><spa=
n> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_init(str=
uct multi_context *m, struct context *t, bool tcp_mode)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+multi_init(struct multi_context *m, str=
uct context *t)</span><br><span> {</span><br><span>     int dev =3D DEV_TYP=
E_UNDEF;</span><br><span> </span><br><span>@@ -435,13 +435,12 @@</span><br>=
<span> </span><br><span>     m-&gt;instances =3D calloc(m-&gt;max_clients, =
sizeof(struct multi_instance *));</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    m-&gt;top.c2.event_set =3D t-&gt;c2.e=
vent_set;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
Initialize multi-socket TCP I/O wait object</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * Initialize multi-socket I/O wait object</spa=
n><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (tcp_mode)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m-&gt;multi_i=
o =3D multi_protocol_init(t-&gt;options.max_clients, &amp;m-&gt;max_clients=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;multi_io =3D multi_prot=
ocol_init(t-&gt;options.max_clients, &amp;m-&gt;max_clients);</span><br><sp=
an>     m-&gt;tcp_queue_limit =3D t-&gt;options.tcp_queue_limit;</span><br>=
<span> </span><br><span>     /*</span><br><span>@@ -665,7 +664,7 @@</span><=
br><span>             mi-&gt;did_iroutes =3D false;</span><br><span>       =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (m-&gt;multi_io)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (m-&gt;multi_io &amp;&amp; !proto_is_dgram(m-&gt;top.opt=
ions.ce.proto))</span><br><span>         {</span><br><span>             mul=
ti_tcp_dereference_instance(m-&gt;multi_io, mi);</span><br><span>         }=
</span><br><span>@@ -776,7 +775,6 @@</span><br><span>         mi-&gt;real =
=3D *real;</span><br><span>         generate_prefix(mi);</span><br><span>  =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
     mi-&gt;did_open_context =3D true;</span><br><span>     inherit_context=
_child(&amp;mi-&gt;context, &amp;m-&gt;top, ls);</span><br><span>     if (I=
S_SIG(&amp;mi-&gt;context))</span><br><span>@@ -798,6 +796,7 @@</span><br><=
span>         {</span><br><span>             goto err;</span><br><span>    =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&g=
t;real.proto =3D ls-&gt;info.proto;</span><br><span>         generate_prefi=
x(mi);</span><br><span>     }</span><br><span> </span><br><span>@@ -4158,6 =
+4157,98 @@</span><br><span>     ASSERT(mi-&gt;context.c2.tls_multi-&gt;pee=
r_id &lt; m-&gt;max_clients);</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/***************************=
***********************************************/</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Main event loop for OpenVPN in multi-protocol server mode.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ingroup eventloo=
p</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param top - Top-level context s=
tructure.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tunnel_server_loop(struct multi_context *=
multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int status;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    while (true)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        perf_push(PERF_EVENT_LOOP);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* wait on tun/socket list */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        multi_get_timeout(multi, &amp;multi-&gt;top.c2.t=
imeval);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sta=
tus =3D multi_protocol_io_wait(multi);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        MULTI_CHECK_SIG(multi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* check on status of coarse timers */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        multi_process_per_second_tim=
ers(multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* timeout? */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (status &gt; =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            /* process the =
I/O which triggered select */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            multi_protocol_process_io(multi);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            MULTI_CHECK_SIG(multi);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        else if (status =3D=3D 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            multi_protocol_ac=
tion(multi, NULL, TA_TIMEOUT, false);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        per=
f_pop();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
tunnel_server_init(struct context *top)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct multi_context multi;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
op-&gt;mode =3D CM_TOP;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    context_clear_2(top);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* in=
itialize top-tunnel instance */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    init_instance_handle_signals(top, top-&gt;es, CC_HARD_USR1_=
TO_HUP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (IS_=
SIG(top))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* initialize global multi_context object */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    multi_init(&amp;multi, top)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* initialize our cloned top obje=
ct */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_top_=
init(&amp;multi, top);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* initializ=
e management interface */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    init_management_callback_multi(&amp;multi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* finished with initialization */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    initialization_sequence_completed(top=
, ISC_SERVER); /* --mode server --proto tcp-server */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    multi.top.c2.inotify_fd =3D inotify_init();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi.top.c2.inotif=
y_fd &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_E=
RRORS | M_ERRNO, &quot;MULTI: inotify_init error&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tunne=
l_server_loop(&amp;multi);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #ifdef E=
NABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 close(top-&gt;c2.inotify_fd);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* shut down mana=
gement interface */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uninit_management_callback();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* save ifconfig-pool */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    multi_ifconfig_pool_persist(&amp;multi, true);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* tear down tunnel instance (unless --persist-tun) */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_uninit(&am=
p;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_=
top_free(&amp;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    close_instance(top);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span> </span><br><span> /*</span><br><span>  * Top leve=
l event loop.</span><br><span>@@ -4167,12 +4258,6 @@</span><br><span> {</sp=
an><br><span>     ASSERT(top-&gt;options.mode =3D=3D MODE_SERVER);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (prot=
o_is_dgram(top-&gt;options.ce.proto))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        tunnel_server_udp(top);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        tunnel_server_tcp(top);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    tunnel_server_init(top);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> }</span><br>=
<span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><spa=
n>index a25aeda..65fd320 100644</span><br><span>--- a/src/openvpn/multi.h</=
span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -247,10 +247,8 =
@@</span><br><span>  * Main event loop for OpenVPN in server mode.</span><b=
r><span>  * @ingroup eventloop</span><br><span>  *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * This function calls the appropriate main ev=
ent loop function depending</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * on the transport protocol used:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  - \c tunnel_server_udp()</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  - \c tunnel_server_tcp()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * This function calls the main event lo=
op function</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * on th=
e transport protocols:</span><br><span>  *</span><br><span>  * @param top  =
        - Top-level context structure.</span><br><span>  */</span><br><span=
>@@ -263,7 +261,7 @@</span><br><span>  * Called by mtcp.c, mudp.c, or other=
 (to be written) protocol drivers</span><br><span>  */</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_init(struct m=
ulti_context *m, struct context *t, bool tcp_mode);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void multi_init(struct multi_context *m, =
struct context *t);</span><br><span> </span><br><span> void multi_uninit(st=
ruct multi_context *m);</span><br><span> </span><br><span>@@ -659,9 +657,12=
 @@</span><br><span> multi_process_outgoing_tun(struct multi_context *m, co=
nst unsigned int mpp_flags)</span><br><span> {</span><br><span>     struct =
multi_instance *mi =3D m-&gt;pending;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!mi)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span>     bool ret =3D true;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi);</span><br><span> #=
ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>     printf(&quot;%s -&gt; TUN=
 len=3D%d\n&quot;,</span><br><span>            id(mi),</span><br><span>diff=
 --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h</span><br><span>inde=
x 77bb41d..821ac2e 100644</span><br><span>--- a/src/openvpn/openvpn.h</span=
><br><span>+++ b/src/openvpn/openvpn.h</span><br><span>@@ -220,8 +220,8 @@<=
/span><br><span>  * \c SIGUSR1 restarts.</span><br><span>  *</span><br><spa=
n>  * This structure is initialized at the top of the \c</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * tunnel_point_to_point(), \c tunnel_se=
rver_udp(), and \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
tunnel_server_tcp() functions.  In other words, it is reset for every</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * tunnel_point_to_point(=
), \c tunnel_server() \c</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * functions.  In other words, it is reset for every</span><br><span> =
 * iteration of the \c main() function&#39;s inner \c SIGUSR1 loop.</span><=
br><span>  */</span><br><span> struct context_2</span><br><span>diff --git =
a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 25bdd=
44..42210da 100644</span><br><span>--- a/src/openvpn/options.c</span><br><s=
pan>+++ b/src/openvpn/options.c</span><br><span>@@ -2199,6 +2199,7 @@</span=
><br><span>     }</span><br><span> </span><br><span>     ALLOC_OBJ_CLEAR_GC=
(e, struct local_entry, gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    e-&gt;proto =3D PROTO_NONE;</span><br><span>     l-&gt;array[l=
-&gt;len++] =3D e;</span><br><span> </span><br><span>     return e;</span><=
br><span>@@ -3170,14 +3171,30 @@</span><br><span>         if (ce-&gt;proto =
=3D=3D PROTO_TCP)</span><br><span>         {</span><br><span>             c=
e-&gt;proto =3D PROTO_TCP_SERVER;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            o-&gt;ce.proto =3D ce-&gt;proto;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (ce-&gt;local_list)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            for (int i =3D 0; i &lt; ce-&gt;l=
ocal_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              if (ce-&gt;local_list-&gt;array[i]-&gt;proto =3D=3D PROTO_TCP=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
ce-&gt;local_list-&gt;array[i]-&gt;proto =3D PROTO_TCP_SERVER;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                else if (ce-&gt;lo=
cal_list-&gt;array[i]-&gt;proto =3D=3D PROTO_NONE)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    ce-&gt;local_list-&gt;arra=
y[i]-&gt;proto =3D ce-&gt;proto;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span>         }</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (o-&gt;client)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (o-&gt;mode !=3D MODE_SERVER)</span><br><span>     {</span><br><span> =
        if (ce-&gt;proto =3D=3D PROTO_TCP)</span><br><span>         {</span=
><br><span>             ce-&gt;proto =3D PROTO_TCP_CLIENT;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;ce.proto =3D ce-&g=
t;proto;</span><br><span>         }</span><br><span>     }</span><br><span>=
 </span><br><span>@@ -3331,6 +3348,10 @@</span><br><span>     {</span><br><=
span>         le-&gt;port =3D o-&gt;ce.local_port;</span><br><span>     }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!le-&gt;proto=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        le-&gt;proto =3D o-&gt;c=
e.proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span> }</span><br><span> </span><br><span> #ifdef _WIN32</span><br><s=
pan>@@ -3822,6 +3843,7 @@</span><br><span>         ASSERT(e);</span><br><sp=
an>         e-&gt;port =3D o-&gt;ce.local_port;</span><br><span>         e-=
&gt;bind_local =3D o-&gt;ce.bind_local;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        e-&gt;proto =3D o-&gt;ce.proto;</span><br><span=
>     }</span><br><span> </span><br><span>     /* use the same listen list =
for every outgoing connection */</span><br><span>@@ -6232,7 +6254,7 @@</spa=
n><br><span>         VERIFY_PERMISSION(OPT_P_UP);</span><br><span>         =
options-&gt;ifconfig_nowarn =3D true;</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;local=
&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (streq(p[0], &quot;local&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>         st=
ruct local_entry *e;</span><br><span> </span><br><span>@@ -6253,7 +6275,12 =
@@</span><br><span>         if (p[2])</span><br><span>         {</span><br>=
<span>             e-&gt;port =3D p[2];</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            e-&gt;bind_local =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /*e-&gt;bind_local =3D tru=
e; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (p[3])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            e-&gt;proto =3D ascii2proto(p[3]);</spa=
n><br><span>         }</span><br><span>     }</span><br><span>     else if =
(streq(p[0], &quot;remote-random&quot;) &amp;&amp; !p[1])</span><br><span>d=
iff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>i=
ndex 6942455..f3cf7e5 100644</span><br><span>--- a/src/openvpn/options.h</s=
pan><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -99,6 +99,7 @@=
</span><br><span>     const char *local;</span><br><span>     const char *p=
ort;</span><br><span>     bool bind_local;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int proto;</span><br><span> };</span><br><span> =
</span><br><span> struct connection_entry</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=
=3Demail">change 764</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31bbf87e4e568021445c7512ece=
fadfd4a69b363 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 764 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--S9+VPPiJgZI=--

