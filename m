From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 17 Oct 2024 14:47:28 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <27ac4d3ac9b8eedd34d03f5a309da22298ee5056-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ICBUIu9k/8E="; charset=UTF-8
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

--ICBUIu9k/8E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail

to look at the new patch set (#5).


Change subject: Bind to multiple ipv4/ipv6 addresses
......................................................................

Bind to multiple ipv4/ipv6 addresses

Enables the binding of multiple listen sockets based
on the specified "--local" directives.

The main server loop has been updated to handle both
TCP and UDP connections.

The hash function has also been modified to include the
protocol during the creation of new client instances.

There are also a couple of refinements to make the
whole code flow management capable of handling
different kind of clients:

MULTI: properly remove TCP instances by checking the multi_instance
       protocol instead of the global one.

TLS: set the tls_option xmit_hold bool value to true only in case of
     TCP child instance to avoid checking the global protocol
     value.

INIT: initialize the c->c2.event_set in the inherit_context_top()
      by default and not only in case of UDP since we could have
      multiple different sockets.

Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M doc/man-sections/link-options.rst
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
M src/openvpn/multi_io.c
M src/openvpn/openvpn.h
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/socket.c
17 files changed, 539 insertions(+), 311 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/764/5

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index d519539..fa17716 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -106,7 +106,7 @@
   is not reliable. It is recommended to set tun-mtu with enough headroom
   instead.

---local host|* [port]
+--local host|* [port] [protocol]
   Local host name or IP address and port for bind. If specified, OpenVPN w=
ill bind
   to this address. If unspecified, OpenVPN will bind to all interfaces.
   '*' can be used as hostname and means 'any host' (OpenVPN will listen on=
 what
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 2033a36..0a9c286 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1773,7 +1773,7 @@
             if (c->options.shaper)
             {
                 int overhead =3D datagram_overhead(c->c2.to_link_addr->des=
t.addr.sa.sa_family,
-                                                 c->options.ce.proto);
+                                                 sock->info.proto);
                 shaper_wrote_bytes(&c->c2.shaper,
                                    BLEN(&c->c2.to_link) + overhead);
             }
@@ -2070,6 +2070,173 @@
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
@@ -2310,6 +2477,7 @@
     dmsg(D_EVENT_WAIT, "I/O WAIT status=3D0x%04x", c->c2.event_set_status);
 }

+
 void
 process_io(struct context *c, struct link_socket *sock)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 924fb17..1c64033 100644
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
index e9352fb..b722e79 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -225,7 +225,7 @@
         if (streq(p[1], "HTTP"))
         {
             struct http_proxy_options *ho;
-            if (ce->proto !=3D PROTO_TCP && ce->proto !=3D PROTO_TCP_CLIEN=
T)
+            if (ce->proto !=3D PROTO_TCP && c->mode !=3D CM_CHILD_TCP)
             {
                 msg(M_WARN, "HTTP proxy support only works for TCP based c=
onnections");
                 return false;
@@ -602,7 +602,10 @@
             ce_defined =3D false;
         }

+        int proto =3D c->options.ce.proto;
         c->options.ce =3D *ce;
+        c->options.ce.proto =3D proto;
+
 #ifdef ENABLE_MANAGEMENT
         if (ce_defined && management && management_query_remote_enabled(ma=
nagement))
         {
@@ -2673,7 +2676,7 @@

     if (found & OPT_P_EXPLICIT_NOTIFY)
     {
-        if (!proto_is_udp(c->options.ce.proto) && c->options.ce.explicit_e=
xit_notification)
+        if (!proto_is_udp(c->c2.link_sockets[0]->info.proto) && c->options=
.ce.explicit_exit_notification)
         {
             msg(D_PUSH, "OPTIONS IMPORT: --explicit-exit-notify can only b=
e used with --proto udp");
             c->options.ce.explicit_exit_notification =3D 0;
@@ -2829,14 +2832,21 @@
     int sec =3D 2;
     int backoff =3D 0;

-    switch (c->options.ce.proto)
+    switch (c->mode)
     {
-        case PROTO_TCP_SERVER:
-            sec =3D 1;
+        case CM_TOP:
+            if (has_udp_in_local_list(&c->options))
+            {
+                sec =3D c->options.ce.connect_retry_seconds;
+            }
+            else
+            {
+                sec =3D 1;
+            }
             break;

-        case PROTO_UDP:
-        case PROTO_TCP_CLIENT:
+        case CM_CHILD_UDP:
+        case CM_CHILD_TCP:
             sec =3D c->options.ce.connect_retry_seconds;
             break;
     }
@@ -2854,7 +2864,7 @@
     }

     /* Slow down reconnection after 5 retries per remote -- for TCP client=
 or UDP tls-client only */
-    if (c->options.ce.proto =3D=3D PROTO_TCP_CLIENT
+    if (c->mode =3D=3D CM_CHILD_TCP
         || (c->options.ce.proto =3D=3D PROTO_UDP && c->options.tls_client))
     {
         backoff =3D (c->options.unsuccessful_attempts / c->options.connect=
ion_list->len) - 4;
@@ -3334,7 +3344,21 @@
     to.server =3D options->tls_server;
     to.replay_window =3D options->replay_window;
     to.replay_time =3D options->replay_time;
-    to.tcp_mode =3D link_socket_proto_connection_oriented(options->ce.prot=
o);
+
+    if (c->options.ce.local_list->len > 1)
+    {
+        for (int i =3D 0; i < c->options.ce.local_list->len; i++)
+        {
+            if (proto_is_dgram(c->options.ce.local_list->array[i]->proto))
+            {
+                to.tcp_mode =3D false;
+            }
+        }
+    }
+    else
+    {
+        to.tcp_mode =3D link_socket_proto_connection_oriented(c->options.c=
e.local_list->array[0]->proto);
+    }
     to.config_ciphername =3D c->options.ciphername;
     to.config_ncp_ciphers =3D c->options.ncp_ciphers;
     to.transition_window =3D options->transition_window;
@@ -3379,7 +3403,7 @@

     /* should we not xmit any packets until we get an initial
      * response from client? */
-    if (to.server && options->ce.proto =3D=3D PROTO_TCP_SERVER)
+    if (to.server && c->mode =3D=3D CM_CHILD_TCP)
     {
         to.xmit_hold =3D true;
     }
@@ -3823,7 +3847,6 @@
     for (int i =3D 0; i < c->c1.link_sockets_num; i++)
     {
         int mode =3D LS_MODE_DEFAULT;
-
         /* mode allows CM_CHILD_TCP
          * instances to inherit acceptable fds
          * from a top-level parent */
@@ -3840,7 +3863,6 @@
                 mode =3D LS_MODE_TCP_ACCEPT_FROM;
             }
         }
-
         /* init each socket with its specific args */
         link_socket_init_phase1(c, i, mode);
     }
@@ -4219,20 +4241,13 @@
 #ifdef _WIN32
         msg(M_INFO, "NOTE: --fast-io is disabled since we are running on W=
indows");
 #else
-        if (!proto_is_udp(c->options.ce.proto))
+        if (c->options.shaper)
         {
-            msg(M_INFO, "NOTE: --fast-io is disabled since we are not usin=
g UDP");
+            msg(M_INFO, "NOTE: --fast-io is disabled since we are using --=
shaper");
         }
         else
         {
-            if (c->options.shaper)
-            {
-                msg(M_INFO, "NOTE: --fast-io is disabled since we are usin=
g --shaper");
-            }
-            else
-            {
-                c->c2.fast_io =3D true;
-            }
+            c->c2.fast_io =3D true;
         }
 #endif
     }
@@ -4639,7 +4654,7 @@
     }

     /* our wait-for-i/o objects, different for posix vs. win32 */
-    if (c->mode =3D=3D CM_P2P)
+    if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP)
     {
         do_event_set_init(c, SHAPER_DEFINED(&c->options));
     }
@@ -4903,7 +4918,7 @@
     CLEAR(*dest);

     /* proto_is_dgram will ASSERT(0) if proto is invalid */
-    dest->mode =3D proto_is_dgram(src->options.ce.proto) ? CM_CHILD_UDP : =
CM_CHILD_TCP;
+    dest->mode =3D proto_is_dgram(sock->info.proto) ? CM_CHILD_UDP : CM_CH=
ILD_TCP;

     dest->gc =3D gc_new();

@@ -4929,8 +4944,11 @@

     /* options */
     dest->options =3D src->options;
+    dest->options.ce.proto =3D sock->info.proto;
     options_detach(&dest->options);

+    dest->c2.event_set =3D src->c2.event_set;
+
     if (dest->mode =3D=3D CM_CHILD_TCP)
     {
         /*
@@ -5025,10 +5043,7 @@
     dest->c2.es_owned =3D false;

     dest->c2.event_set =3D NULL;
-    if (proto_is_dgram(src->options.ce.proto))
-    {
-        do_event_set_init(dest, false);
-    }
+    do_event_set_init(dest, false);

 #ifdef USE_COMP
     dest->c2.comp_context =3D NULL;
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 3a0224e..6f0170a 100644
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
index 570ccaa..e844c21 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -201,6 +201,10 @@
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
@@ -222,7 +226,7 @@
 static inline uint32_t
 mroute_addr_hash_len(const struct mroute_addr *a)
 {
-    return (uint32_t) a->len + 2;
+    return (uint32_t) a->len + 3;
 }

 static inline void
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index e173b80..c1107ab 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -54,7 +54,7 @@
     struct hash *hash =3D m->hash;

     mi =3D multi_create_instance(m, NULL, sock);
-    if (mi)
+    if (mi && !proto_is_dgram(sock->info.proto))
     {
         mi->real.proto =3D sock->info.proto;
         struct hash_element *he;
@@ -153,12 +153,19 @@
 {
     if (mi)
     {
-        mi->socket_set_called =3D true;
-        socket_set(mi->context.c2.link_sockets[0],
-                   m->multi_io->es,
-                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
-                   &mi->ev_arg,
-                   &mi->tcp_rwflags);
+        if (proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
+        {
+            return;
+        }
+        else
+        {
+            mi->socket_set_called =3D true;
+            socket_set(mi->context.c2.link_sockets[0],
+                       m->multi_io->es,
+                       mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRI=
TE : EVENT_READ,
+                       &mi->ev_arg,
+                       &mi->tcp_rwflags);
+        }
     }
 }

@@ -242,87 +249,3 @@
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
index b9f73d4..51b209b 100644
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
index cd53742..c71f0e2 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -194,6 +194,7 @@
     struct hash *hash =3D m->hash;
     real.proto =3D sock->info.proto;
     m->local.proto =3D real.proto;
+    m->hmac_reply_ls =3D sock;

     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
@@ -320,18 +321,59 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link =3D m->hmac_reply;
         m->top.c2.to_link_addr =3D m->hmac_reply_dest;
-        process_outgoing_link(&m->top, m->top.c2.link_sockets[0]);
+        process_outgoing_link(&m->top, m->hmac_reply_ls);
+        m->hmac_reply_ls =3D NULL;
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
@@ -428,123 +470,3 @@
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
index 3107cc6..e329832 100644
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
index 31b7224..47fd62b 100644
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
@@ -607,6 +606,7 @@

     ASSERT(!mi->halt);
     mi->halt =3D true;
+    bool is_dgram =3D proto_is_dgram(mi->context.c2.link_sockets[0]->info.=
proto);

     dmsg(D_MULTI_DEBUG, "MULTI: multi_close_instance called");

@@ -665,7 +665,7 @@
             mi->did_iroutes =3D false;
         }

-        if (m->multi_io)
+        if (!is_dgram)
         {
             multi_tcp_dereference_instance(m->multi_io, mi);
         }
@@ -774,7 +774,7 @@
         generate_prefix(mi);
     }

-    inherit_context_child(&mi->context, &m->top, ls);
+    inherit_context_child(&mi->context, &m->top, sock);
     if (IS_SIG(&mi->context))
     {
         goto err;
@@ -794,6 +794,7 @@
         {
             goto err;
         }
+        mi->real.proto =3D sock->info.proto;
         generate_prefix(mi);
     }

@@ -3397,7 +3398,7 @@
             /* decrypt in instance context */

             perf_push(PERF_PROC_IN_LINK);
-            lsi =3D get_link_socket_info(c);
+            lsi =3D &sock->info;
             orig_buf =3D c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
@@ -3848,7 +3849,7 @@
     while ((he =3D hash_iterator_next(&hi)))
     {
         struct multi_instance *mi =3D (struct multi_instance *) he->value;
-        if (!mi->halt)
+        if (!mi->halt && proto_is_dgram(mi->context.options.ce.proto))
         {
             send_control_channel_string(&mi->context, next_server ? "RESTA=
RT,[N]" : "RESTART", D_PUSH);
             multi_schedule_context_wakeup(m, mi);
@@ -3886,13 +3887,15 @@
         status_close(so);
         return false;
     }
-    else if (proto_is_dgram(m->top.options.ce.proto)
-             && is_exit_restart(m->top.sig->signal_received)
-             && (m->deferred_shutdown_signal.signal_received =3D=3D 0)
-             && m->top.options.ce.explicit_exit_notification !=3D 0)
+    else if (has_udp_in_local_list(&m->top.options))
     {
-        multi_push_restart_schedule_exit(m, m->top.options.ce.explicit_exi=
t_notification =3D=3D 2);
-        return false;
+        if (is_exit_restart(m->top.sig->signal_received)
+            && (m->deferred_shutdown_signal.signal_received =3D=3D 0)
+            && m->top.options.ce.explicit_exit_notification !=3D 0)
+        {
+            multi_push_restart_schedule_exit(m, m->top.options.ce.explicit=
_exit_notification =3D=3D 2);
+            return false;
+        }
     }
     return true;
 }
@@ -4165,6 +4168,98 @@
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
@@ -4174,12 +4269,6 @@
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
index bef0b73..2bd168a 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -204,6 +204,7 @@

     struct buffer hmac_reply;
     struct link_socket_actual *hmac_reply_dest;
+    struct link_socket *hmac_reply_ls;

     /*
      * Timer object for stale route check
@@ -251,10 +252,8 @@
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
@@ -267,7 +266,7 @@
  * Called by mtcp.c, mudp.c, or other (to be written) protocol drivers
  */

-void multi_init(struct multi_context *m, struct context *t, bool tcp_mode);
+void multi_init(struct multi_context *m, struct context *t);

 void multi_uninit(struct multi_context *m);

@@ -663,9 +662,12 @@
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
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 43fe24b..59661ed 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -142,6 +142,11 @@
                                      &m->top.c2.link_sockets[i]->ev_arg);
     }

+    if (has_udp_in_local_list(&m->top.options))
+    {
+        get_io_flags_udp(&m->top, m->multi_io, p2mp_iow_flags(m));
+    }
+
 #ifdef _WIN32
     if (tuntap_is_wintun(m->top.c1.tuntap))
     {
@@ -396,6 +401,10 @@
 multi_protocol_process_io(struct multi_context *m)
 {
     struct multi_protocol *multi_io =3D m->multi_io;
+    const unsigned int udp_status =3D multi_io->udp_flags;
+    const unsigned int mpp_flags =3D m->top.c2.fast_io
+                                   ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
+                                   : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
     int i;

     for (i =3D 0; i < multi_io->n_esr; ++i)
@@ -447,6 +456,39 @@
                         }
                         break;
                     }
+                    else
+                    {
+                        if (e->arg >=3D MULTI_N)
+                        {
+                            struct event_arg *ev_arg =3D (struct event_arg=
 *)e->arg;
+                            if (ev_arg->type !=3D EVENT_ARG_LINK_SOCKET)
+                            {
+                                multi_io->udp_flags =3D ES_ERROR;
+                                msg(D_LINK_ERRORS,
+                                    "MULTI PROTOCOL: io_work: non socket e=
vent delivered");
+                                break;
+                            }
+                        }
+                        else
+                        {
+                            ev_arg->pending =3D true;
+                        }
+
+                        if (udp_status & SOCKET_READ)
+                        {
+                            read_incoming_link(&m->top, ev_arg->u.sock);
+                            if (!IS_SIG(&m->top))
+                            {
+                                multi_process_incoming_link(m, NULL, mpp_f=
lags,
+                                                            ev_arg->u.sock=
);
+                            }
+                        }
+                        else
+                        {
+                            multi_process_io_udp(m);
+                        }
+                        break;
+                    }
             }
         }
         else
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
index d8b56ff..0091e42 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -993,10 +993,13 @@
                         const struct connection_entry *e,
                         const int i)
 {
-    setenv_str_i(es, "proto", proto2ascii(e->proto, e->af, false), i);
-    /* expected to be for single socket contexts only */
-    setenv_str_i(es, "local", e->local_list->array[0]->local, i);
-    setenv_str_i(es, "local_port", e->local_list->array[0]->port, i);
+    for (int j =3D 0; j < e->local_list->len; j++)
+    {
+        setenv_str_i(es, "proto", proto2ascii(e->local_list->array[j]->pro=
to, e->af, false), i);
+        /* expected to be for single socket contexts only */
+        setenv_str_i(es, "local", e->local_list->array[j]->local, i);
+        setenv_str_i(es, "local_port", e->local_list->array[j]->port, i);
+    }
     setenv_str_i(es, "remote", e->remote, i);
     setenv_str_i(es, "remote_port", e->remote_port, i);

@@ -2199,6 +2202,7 @@
     }

     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);
+    e->proto =3D PROTO_NONE;
     l->array[l->len++] =3D e;

     return e;
@@ -2465,7 +2469,7 @@
     {
         struct local_entry *le =3D ce->local_list->array[i];

-        if (proto_is_net(ce->proto)
+        if (proto_is_net(le->proto)
             && string_defined_equal(le->local, ce->remote)
             && string_defined_equal(le->port, ce->remote_port))
         {
@@ -3170,14 +3174,30 @@
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

@@ -3331,6 +3351,10 @@
     {
         le->port =3D ce.local_port;
     }
+    if (!le->proto)
+    {
+        le->proto =3D ce.proto;
+    }
 }

 #ifdef _WIN32
@@ -3807,6 +3831,12 @@
         options_postprocess_mutate_ce(o, o->connection_list->array[i]);
     }

+    if (!has_udp_in_local_list(o))
+    {
+        o->fast_io =3D false;
+        msg(M_INFO, "NOTE: --fast-io is disabled while using multi-socket"=
);
+    }
+
     if (o->ce.local_list)
     {
         for (i =3D 0; i < o->ce.local_list->len; i++)
@@ -3822,6 +3852,7 @@
         ASSERT(e);
         e->port =3D o->ce.local_port;
         e->bind_local =3D o->connection_list->array[0]->bind_local;
+        e->proto =3D o->ce.proto;
     }

     /* use the same listen list for every outgoing connection */
@@ -6232,7 +6263,7 @@
         VERIFY_PERMISSION(OPT_P_UP);
         options->ifconfig_nowarn =3D true;
     }
-    else if (streq(p[0], "local") && p[1] && !p[3])
+    else if (streq(p[0], "local") && p[1] && !p[4])
     {
         struct local_entry *e;

@@ -6253,7 +6284,12 @@
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
@@ -9695,3 +9731,19 @@
 err:
     gc_free(&gc);
 }
+
+bool
+has_udp_in_local_list(const struct options *options)
+{
+    if (options->ce.local_list)
+    {
+        for (int i =3D 0; i < options->ce.local_list->len; i++)
+        {
+            if (proto_is_dgram(options->ce.local_list->array[i]->proto))
+            {
+                return true;
+            }
+        }
+    }
+    return false;
+}
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 6942455..30bd5aa 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -99,6 +99,7 @@
     const char *local;
     const char *port;
     bool bind_local;
+    int proto;
 };

 struct connection_entry
@@ -916,6 +917,8 @@

 bool key_is_external(const struct options *options);

+bool has_udp_in_local_list(const struct options *options);
+
 /**
  * Returns whether the current configuration has dco enabled.
  */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 06acd5a..67c88f0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1874,16 +1874,39 @@
                         int sock_index,
                         int mode)
 {
+    const char *host =3D c->options.ce.local_list->array[sock_index]->loca=
l;
+    const char *port =3D c->options.ce.local_list->array[sock_index]->port;
+    int proto =3D c->options.ce.local_list->array[sock_index]->proto;
+    bool bind_local =3D c->options.ce.local_list->array[sock_index]->bind_=
local;
+
+    if (c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=3D CM_CHILD_UDP)
+    {
+        struct link_socket *tmp_sock =3D NULL;
+        if (c->mode =3D=3D CM_CHILD_TCP)
+        {
+            tmp_sock =3D (struct link_socket *)c->c2.accept_from;
+        }
+        else if (c->mode =3D=3D CM_CHILD_UDP)
+        {
+            tmp_sock =3D c->c2.link_sockets[0];
+        }
+
+        host =3D tmp_sock->local_host;
+        port =3D tmp_sock->local_port;
+        proto =3D tmp_sock->info.proto;
+        bind_local =3D tmp_sock->bind_local;
+    }
+
     ASSERT(c->c2.link_sockets[sock_index]);

-    c->c2.link_sockets[sock_index]->local_host =3D c->options.ce.local_lis=
t->array[sock_index]->local;
-    c->c2.link_sockets[sock_index]->local_port =3D c->options.ce.local_lis=
t->array[sock_index]->port;
+    c->c2.link_sockets[sock_index]->local_host =3D host;
+    c->c2.link_sockets[sock_index]->local_port =3D port;
     c->c2.link_sockets[sock_index]->remote_host =3D c->options.ce.remote;
     c->c2.link_sockets[sock_index]->remote_port =3D c->options.ce.remote_p=
ort;
     c->c2.link_sockets[sock_index]->dns_cache =3D c->c1.dns_cache;
     c->c2.link_sockets[sock_index]->http_proxy =3D c->c1.http_proxy;
     c->c2.link_sockets[sock_index]->socks_proxy =3D c->c1.socks_proxy;
-    c->c2.link_sockets[sock_index]->bind_local =3D c->options.ce.local_lis=
t->array[sock_index]->bind_local;
+    c->c2.link_sockets[sock_index]->bind_local =3D bind_local;
     c->c2.link_sockets[sock_index]->resolve_retry_seconds =3D c->options.r=
esolve_retry_seconds;
     c->c2.link_sockets[sock_index]->mtu_discover_type =3D c->options.ce.mt=
u_discover_type;

@@ -1905,7 +1928,7 @@

     c->c2.link_sockets[sock_index]->mark =3D c->options.mark;

-    c->c2.link_sockets[sock_index]->info.proto =3D c->options.ce.proto;
+    c->c2.link_sockets[sock_index]->info.proto =3D proto;
     c->c2.link_sockets[sock_index]->info.af =3D c->options.ce.af;
     c->c2.link_sockets[sock_index]->info.remote_float =3D c->options.ce.re=
mote_float;
     c->c2.link_sockets[sock_index]->info.lsa =3D &c->c1.link_socket_addrs[=
sock_index];

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Gerrit-Change-Number: 764
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-MessageType: newpatchset

--ICBUIu9k/8E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Bind to multiple ipv4/ipv6 addresses<br><br>Enables the binding of mu=
ltiple listen sockets based<br>on the specified &quot;--local&quot; directi=
ves.<br><br>The main server loop has been updated to handle both<br>TCP and=
 UDP connections.<br><br>The hash function has also been modified to includ=
e the<br>protocol during the creation of new client instances.<br><br>There=
 are also a couple of refinements to make the<br>whole code flow management=
 capable of handling<br>different kind of clients:<br><br>MULTI: properly r=
emove TCP instances by checking the multi_instance<br>       protocol inste=
ad of the global one.<br><br>TLS: set the tls_option xmit_hold bool value t=
o true only in case of<br>     TCP child instance to avoid checking the glo=
bal protocol<br>     value.<br><br>INIT: initialize the c-&gt;c2.event_set =
in the inherit_context_top()<br>      by default and not only in case of UD=
P since we could have<br>      multiple different sockets.<br><br>Change-Id=
: I31bbf87e4e568021445c7512ecefadfd4a69b363<br>Signed-off-by: Gianmarco De =
Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/link-opti=
ons.rst<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/open=
vpn/init.c<br>M src/openvpn/mroute.c<br>M src/openvpn/mroute.h<br>M src/ope=
nvpn/mtcp.c<br>M src/openvpn/mtcp.h<br>M src/openvpn/mudp.c<br>M src/openvp=
n/mudp.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn=
/multi_io.c<br>M src/openvpn/openvpn.h<br>M src/openvpn/options.c<br>M src/=
openvpn/options.h<br>M src/openvpn/socket.c<br>17 files changed, 539 insert=
ions(+), 311 deletions(-)<br><br></pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/64/764/5</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/link-o=
ptions.rst b/doc/man-sections/link-options.rst</span><br><span>index d51953=
9..fa17716 100644</span><br><span>--- a/doc/man-sections/link-options.rst</=
span><br><span>+++ b/doc/man-sections/link-options.rst</span><br><span>@@ -=
106,7 +106,7 @@</span><br><span>   is not reliable. It is recommended to se=
t tun-mtu with enough headroom</span><br><span>   instead.</span><br><span>=
 </span><br><span>---local host|* [port]</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+--local host|* [port] [protocol]</span><br><span>   Lo=
cal host name or IP address and port for bind. If specified, OpenVPN will b=
ind</span><br><span>   to this address. If unspecified, OpenVPN will bind t=
o all interfaces.</span><br><span>   &#39;*&#39; can be used as hostname an=
d means &#39;any host&#39; (OpenVPN will listen on what</span><br><span>dif=
f --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>ind=
ex 2033a36..0a9c286 100644</span><br><span>--- a/src/openvpn/forward.c</spa=
n><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1773,7 +1773,7 =
@@</span><br><span>             if (c-&gt;options.shaper)</span><br><span> =
            {</span><br><span>                 int overhead =3D datagram_ov=
erhead(c-&gt;c2.to_link_addr-&gt;dest.addr.sa.sa_family,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                        =
         c-&gt;options.ce.proto);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                                 sock-&gt;inf=
o.proto);</span><br><span>                 shaper_wrote_bytes(&amp;c-&gt;c2=
.shaper,</span><br><span>                                    BLEN(&amp;c-&g=
t;c2.to_link) + overhead);</span><br><span>             }</span><br><span>@=
@ -2070,6 +2070,173 @@</span><br><span>  */</span><br><span> </span><br><sp=
an> void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_io_flag=
s_dowork_udp(struct context *c, struct multi_protocol *multi_io, const unsi=
gned int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int socke=
t =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigne=
d int tuntap =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    static uintptr_t tun_shift =3D 2;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    static uintptr_t err_shift =3D 4;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * Calculate the flags based on the provided &#39;flags&#39; argume=
nt.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; IOW_WAIT=
_SIGNAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        wait_signal(multi=
_io-&gt;es, (void *)err_shift);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; I=
OW_TO_LINK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp=
; IOW_SHAPER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * If sen=
ding this packet would put us over our traffic shaping</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+             * quota, don&#39;t send -- =
instead compute the delay we must wait</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             * until it will be OK to send the packet.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            int delay =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            /* set traffic shaping =
delay in microseconds */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if (c-&gt;options.shaper)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                delay =3D max_int(delay, shaper_delay(&amp=
;c-&gt;c2.shaper));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (delay &lt=
; 1000)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                so=
cket |=3D EVENT_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    shaper_soonest_event(&amp;c-&gt;c2.timeval, delay);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            socket |=3D EVENT_WRITE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (!((flags &amp; IOW_FRAG) &amp;&amp; TO_LINK_FRAG(c)))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (flags &amp; IOW_READ_TUN)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            tuntap |=3D EVENT_READ;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * If outgoing data (for TUN/TAP device) pending, wait for ready-to-send s=
tatus</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * from de=
vice.  Otherwise, wait for incoming data on TCP/UDP port.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (flags &amp; IOW_TO_TUN)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        tuntap |=3D EVENT_WRITE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (flags &amp; IOW_READ_LINK)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            socket |=3D EVENT_READ;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * outgoing bcast buffer wait=
ing to be sent?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &a=
mp; IOW_MBUF)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket |=3D =
EVENT_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * Force wait on TUN input, even if also waiting =
on TCP/UDP output</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags =
&amp; IOW_READ_TUN_FORCE)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
tuntap |=3D EVENT_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (tuntap_is_wintun(c-&gt;c1.t=
untap))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * With wintun we are only =
interested in read event. Ring buffer is</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         * always ready for write, so we don&#39;t do =
wait.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        tuntap =3D EVE=
NT_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * Configure event wait based on socket, tuntap flags.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; c-&gt;c1.lin=
k_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (pr=
oto_is_dgram(c-&gt;c2.link_sockets[i]-&gt;info.proto))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            socket_set(c-&gt;c2.link_sockets[i], m=
ulti_io-&gt;es, socket,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                       &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg, NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tun_set(c-&gt;c1.tuntap, multi_io-&gt=
;es, tuntap, (void *)tun_shift, NULL);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    multi_io-&gt;udp_flags =3D socket | tuntap;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+get_io_flags_udp(struct =
context *c, struct multi_protocol *multi_io, const unsigned int flags)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;udp_flags =3D ES_ERROR;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.fas=
t_io &amp;&amp; (flags &amp; (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* fast path -- only for TUN/TAP=
/UDP writes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   unsigned int ret =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            ret |=3D TUN_WRITE;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (flags &amp; (IOW_TO_LINK | IOW_MBUF))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            ret |=3D SOCKET_WRITE;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        multi_io-&gt;udp_flags =3D =
ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        bool skip_iowait =3D flags &amp; IOW_TO_TUN;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp; IOW=
_READ_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+             * don&#39;t=
 read from tun if we have pending write to link,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             * since every tun read overwrites=
 to_link buffer filled</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+             * by previous tun read</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            skip_iowait =3D !(flags &amp; IOW_TO_LINK);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (tuntap_is_wintun(c-&gt=
;c1.tuntap) &amp;&amp; skip_iowait)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            unsigned int ret =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if (flags &amp; IOW_TO_TUN)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                ret |=3D TUN_WRITE;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (flags &amp; I=
OW_READ_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   ret |=3D TUN_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        multi_io-&gt;udp_flags =3D ret;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           /* slow path - delegate to io_wait_dowork_udp to calculate flags=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            get_=
io_flags_dowork_udp(c, multi_io, flags);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> io_wait_dowork(str=
uct context *c, const unsigned int flags)</span><br><span> {</span><br><spa=
n>     unsigned int socket =3D 0;</span><br><span>@@ -2310,6 +2477,7 @@</sp=
an><br><span>     dmsg(D_EVENT_WAIT, &quot;I/O WAIT status=3D0x%04x&quot;, =
c-&gt;c2.event_set_status);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><=
br><span> process_io(struct context *c, struct link_socket *sock)</span><br=
><span> {</span><br><span>diff --git a/src/openvpn/forward.h b/src/openvpn/=
forward.h</span><br><span>index 924fb17..1c64033 100644</span><br><span>---=
 a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.h</span>=
<br><span>@@ -69,6 +69,10 @@</span><br><span> </span><br><span> extern coun=
ter_type link_write_bytes_global;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void get_io_flags_dowork_udp(struct conte=
xt *c, struct multi_protocol *multi_io, const unsigned int flags);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void get_io_flags_udp(struct context *c, struct=
 multi_protocol *multi_io, const unsigned int flags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void io_wait_dowork(str=
uct context *c, const unsigned int flags);</span><br><span> </span><br><spa=
n> void pre_select(struct context *c);</span><br><span>diff --git a/src/ope=
nvpn/init.c b/src/openvpn/init.c</span><br><span>index e9352fb..b722e79 100=
644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/open=
vpn/init.c</span><br><span>@@ -225,7 +225,7 @@</span><br><span>         if =
(streq(p[1], &quot;HTTP&quot;))</span><br><span>         {</span><br><span>=
             struct http_proxy_options *ho;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            if (ce-&gt;proto !=3D PROTO_TCP &amp;&amp=
; ce-&gt;proto !=3D PROTO_TCP_CLIENT)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (ce-&gt;proto !=3D PROTO_TCP &amp;&amp; c-=
&gt;mode !=3D CM_CHILD_TCP)</span><br><span>             {</span><br><span>=
                 msg(M_WARN, &quot;HTTP proxy support only works for TCP ba=
sed connections&quot;);</span><br><span>                 return false;</spa=
n><br><span>@@ -602,7 +602,10 @@</span><br><span>             ce_defined =
=3D false;</span><br><span>         }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        int proto =3D c-&gt;options.ce.=
proto;</span><br><span>         c-&gt;options.ce =3D *ce;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        c-&gt;options.ce.proto =3D pr=
oto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> #ifdef ENABLE_MANAGEMENT</span><br><span>         if (ce_defined &amp;&a=
mp; management &amp;&amp; management_query_remote_enabled(management))</spa=
n><br><span>         {</span><br><span>@@ -2673,7 +2676,7 @@</span><br><spa=
n> </span><br><span>     if (found &amp; OPT_P_EXPLICIT_NOTIFY)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (!proto_is_udp(c-&gt;options.ce.proto) &amp;&amp; c-&gt;options.ce.explici=
t_exit_notification)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!proto_is_udp(c-&gt;c2.link_sockets[0]-&gt;info.proto) &amp;&a=
mp; c-&gt;options.ce.explicit_exit_notification)</span><br><span>         {=
</span><br><span>             msg(D_PUSH, &quot;OPTIONS IMPORT: --explicit-=
exit-notify can only be used with --proto udp&quot;);</span><br><span>     =
        c-&gt;options.ce.explicit_exit_notification =3D 0;</span><br><span>=
@@ -2829,14 +2832,21 @@</span><br><span>     int sec =3D 2;</span><br><span=
>     int backoff =3D 0;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    switch (c-&gt;options.ce.proto)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    switch (c-&gt;mode)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case =
PROTO_TCP_SERVER:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        sec =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       case CM_TOP:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (has_udp_in_local_list(&amp;c-&gt;options))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                sec =3D c-&gt;options.ce.=
connect_retry_seconds;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    sec =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span>             break;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        case PROTO_UDP:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        case PROTO_TCP_CLIENT:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case CM_CHILD=
_UDP:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case C=
M_CHILD_TCP:</span><br><span>             sec =3D c-&gt;options.ce.connect_=
retry_seconds;</span><br><span>             break;</span><br><span>     }</=
span><br><span>@@ -2854,7 +2864,7 @@</span><br><span>     }</span><br><span=
> </span><br><span>     /* Slow down reconnection after 5 retries per remot=
e -- for TCP client or UDP tls-client only */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (c-&gt;options.ce.proto =3D=3D PROTO_TCP_CLI=
ENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;mo=
de =3D=3D CM_CHILD_TCP</span><br><span>         || (c-&gt;options.ce.proto =
=3D=3D PROTO_UDP &amp;&amp; c-&gt;options.tls_client))</span><br><span>    =
 {</span><br><span>         backoff =3D (c-&gt;options.unsuccessful_attempt=
s / c-&gt;options.connection_list-&gt;len) - 4;</span><br><span>@@ -3334,7 =
+3344,21 @@</span><br><span>     to.server =3D options-&gt;tls_server;</spa=
n><br><span>     to.replay_window =3D options-&gt;replay_window;</span><br>=
<span>     to.replay_time =3D options-&gt;replay_time;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    to.tcp_mode =3D link_socket_proto_conn=
ection_oriented(options-&gt;ce.proto);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (c-&gt;options.ce.local_list-&gt;len &gt; 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        for (int i =3D 0; i &lt; c-&gt;options.ce.local=
_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (proto_is_dgram(c-&gt;options.ce.local_list-&gt;array[i]-&gt;proto))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                to.tcp_mode=
 =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        to.tcp_mode =3D link_socket_proto_connection_oriented(c=
-&gt;options.ce.local_list-&gt;array[0]-&gt;proto);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     to.config_ciph=
ername =3D c-&gt;options.ciphername;</span><br><span>     to.config_ncp_cip=
hers =3D c-&gt;options.ncp_ciphers;</span><br><span>     to.transition_wind=
ow =3D options-&gt;transition_window;</span><br><span>@@ -3379,7 +3403,7 @@=
</span><br><span> </span><br><span>     /* should we not xmit any packets u=
ntil we get an initial</span><br><span>      * response from client? */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (to.server &amp;&a=
mp; options-&gt;ce.proto =3D=3D PROTO_TCP_SERVER)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (to.server &amp;&amp; c-&gt;mode =3D=
=3D CM_CHILD_TCP)</span><br><span>     {</span><br><span>         to.xmit_h=
old =3D true;</span><br><span>     }</span><br><span>@@ -3823,7 +3847,6 @@<=
/span><br><span>     for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i+=
+)</span><br><span>     {</span><br><span>         int mode =3D LS_MODE_DEF=
AULT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
>         /* mode allows CM_CHILD_TCP</span><br><span>          * instances=
 to inherit acceptable fds</span><br><span>          * from a top-level par=
ent */</span><br><span>@@ -3840,7 +3863,6 @@</span><br><span>              =
   mode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span>             }</span><=
br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>         /* init each socket with its specific args */</span=
><br><span>         link_socket_init_phase1(c, i, mode);</span><br><span>  =
   }</span><br><span>@@ -4219,20 +4241,13 @@</span><br><span> #ifdef _WIN32=
</span><br><span>         msg(M_INFO, &quot;NOTE: --fast-io is disabled sin=
ce we are running on Windows&quot;);</span><br><span> #else</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (!proto_is_udp(c-&gt;optio=
ns.ce.proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (c-&gt;options.shaper)</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;NOTE: --fast=
-io is disabled since we are not using UDP&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot;NOTE: --fast-i=
o is disabled since we are using --shaper&quot;);</span><br><span>         =
}</span><br><span>         else</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (c-&gt;options.shaper)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_INFO, &q=
uot;NOTE: --fast-io is disabled since we are using --shaper&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                c-&gt;c2.fast_io =3D true;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2.fast_io =3D tr=
ue;</span><br><span>         }</span><br><span> #endif</span><br><span>    =
 }</span><br><span>@@ -4639,7 +4654,7 @@</span><br><span>     }</span><br><=
span> </span><br><span>     /* our wait-for-i/o objects, different for posi=
x vs. win32 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(c-&gt;mode =3D=3D CM_P2P)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP)</span>=
<br><span>     {</span><br><span>         do_event_set_init(c, SHAPER_DEFIN=
ED(&amp;c-&gt;options));</span><br><span>     }</span><br><span>@@ -4903,7 =
+4918,7 @@</span><br><span>     CLEAR(*dest);</span><br><span> </span><br><=
span>     /* proto_is_dgram will ASSERT(0) if proto is invalid */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    dest-&gt;mode =3D proto_is_=
dgram(src-&gt;options.ce.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;mode =3D proto_is_d=
gram(sock-&gt;info.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;</span><br><span> <=
/span><br><span>     dest-&gt;gc =3D gc_new();</span><br><span> </span><br>=
<span>@@ -4929,8 +4944,11 @@</span><br><span> </span><br><span>     /* opti=
ons */</span><br><span>     dest-&gt;options =3D src-&gt;options;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;options.ce.proto=
 =3D sock-&gt;info.proto;</span><br><span>     options_detach(&amp;dest-&gt=
;options);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    dest-&gt;c2.event_set =3D src-&gt;c2.event_set;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (dest-&gt=
;mode =3D=3D CM_CHILD_TCP)</span><br><span>     {</span><br><span>         =
/*</span><br><span>@@ -5025,10 +5043,7 @@</span><br><span>     dest-&gt;c2.=
es_owned =3D false;</span><br><span> </span><br><span>     dest-&gt;c2.even=
t_set =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (proto_is_dgram(src-&gt;options.ce.proto))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        do_event_set_init(dest, false);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    do_event_set_init(dest, false);</span><br><span> </span><br><=
span> #ifdef USE_COMP</span><br><span>     dest-&gt;c2.comp_context =3D NUL=
L;</span><br><span>diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c=
</span><br><span>index 3a0224e..6f0170a 100644</span><br><span>--- a/src/op=
envpn/mroute.c</span><br><span>+++ b/src/openvpn/mroute.c</span><br><span>@=
@ -421,6 +421,7 @@</span><br><span>                 {</span><br><span>     =
                buf_printf(&amp;out, &quot;:%d&quot;, ntohs(maddr.v4.port))=
;</span><br><span>                 }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                buf_printf(&amp;out, &quot;:%d&quot;, madd=
r.proto);</span><br><span>             }</span><br><span>             break=
;</span><br><span> </span><br><span>diff --git a/src/openvpn/mroute.h b/src=
/openvpn/mroute.h</span><br><span>index 570ccaa..e844c21 100644</span><br><=
span>--- a/src/openvpn/mroute.h</span><br><span>+++ b/src/openvpn/mroute.h<=
/span><br><span>@@ -201,6 +201,10 @@</span><br><span>     {</span><br><span=
>         return false;</span><br><span>     }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (a1-&gt;proto !=3D a2-&gt;proto)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     if (a1-&gt;n=
etbits !=3D a2-&gt;netbits)</span><br><span>     {</span><br><span>        =
 return false;</span><br><span>@@ -222,7 +226,7 @@</span><br><span> static =
inline uint32_t</span><br><span> mroute_addr_hash_len(const struct mroute_a=
ddr *a)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return (uint32_t) a-&gt;len + 2;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return (uint32_t) a-&gt;len + 3;</span><br><span>=
 }</span><br><span> </span><br><span> static inline void</span><br><span>di=
ff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index e1=
73b80..c1107ab 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><s=
pan>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -54,7 +54,7 @@</span><br><s=
pan>     struct hash *hash =3D m-&gt;hash;</span><br><span> </span><br><spa=
n>     mi =3D multi_create_instance(m, NULL, sock);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (mi)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (mi &amp;&amp; !proto_is_dgram(sock-&gt;info=
.proto))</span><br><span>     {</span><br><span>         mi-&gt;real.proto =
=3D sock-&gt;info.proto;</span><br><span>         struct hash_element *he;<=
/span><br><span>@@ -153,12 +153,19 @@</span><br><span> {</span><br><span>  =
   if (mi)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        mi-&gt;socket_set_called =3D true;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        socket_set(mi-&gt;context.c2.link_=
sockets[0],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
         m-&gt;multi_io-&gt;es,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                   mbuf_defined(mi-&gt;tcp_link_out_deferred) ? E=
VENT_WRITE : EVENT_READ,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                   &amp;mi-&gt;ev_arg,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                   &amp;mi-&gt;tcp_rwflags);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (proto_is_dgram(mi-=
&gt;context.c2.link_sockets[0]-&gt;info.proto))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   mi-&gt;socket_set_called =3D true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            socket_set(mi-&gt;context.c2.link_sockets[0],=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
    m-&gt;multi_io-&gt;es,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                       mbuf_defined(mi-&gt;tcp_link_out_deferred) ? =
EVENT_WRITE : EVENT_READ,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                       &amp;mi-&gt;ev_arg,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                       &amp;mi-&gt;tcp_rwflags=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span>@@ -24=
2,87 +249,3 @@</span><br><span>     }</span><br><span>     return ret;</spa=
n><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Top level event loop for single-threaded ope=
ration.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * TCP mode.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-tunnel_server_tcp(struct context *top)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct multi_context multi;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int status;</span><br><span style=3D"color: hsl=
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
: hsl(0, 100%, 40%);">-    multi_init(&amp;multi, top, true);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /* initialize our cloned top object */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    multi_top_init(&amp;multi, top)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* initialize management interface */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_management_c=
allback_multi(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* finished =
with initialization */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    initialization_sequence_completed(top, ISC_SERVER); /* --mode server -=
-proto tcp-server */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PU=
SH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi.top.c2.in=
otify_fd =3D inotify_init();</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (multi.top.c2.inotify_fd &lt; 0)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(D_MULTI_ERRORS | M_ERRNO, &quot;MULTI: inotify_init er=
ror&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* per-packet event loop */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    while (true)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        perf_push(PERF_EVENT_LOOP);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   /* wait on tun/socket list */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        multi_get_timeout(&amp;multi, &amp;multi.top.c2.timeval)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =3D m=
ulti_protocol_io_wait(&amp;multi);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        MULTI_CHECK_SIG(&amp;multi);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* check on status of coarse timers */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        multi_process_per_second_timers(&am=
p;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* timeout? */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (status &gt; 0)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            /* process the I/O which tr=
iggered select */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        multi_protocol_process_io(&amp;multi);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            MULTI_CHECK_SIG(&amp;multi);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else if (status =3D=3D 0)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            multi_protocol_action(&amp;mult=
i, NULL, TA_TIMEOUT, false);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    close(top-&gt;c2.inotify_fd);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* shu=
t down management interface */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    uninit_management_callback();</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* save ifconfig-pool */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    multi_ifconfig_pool_persist(&amp;multi, true);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* tear down tunnel instance (unless --persist-tun) */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_uninit(&amp;m=
ulti);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_top_f=
ree(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
lose_instance(top);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span>diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h</span>=
<br><span>index b9f73d4..51b209b 100644</span><br><span>--- a/src/openvpn/m=
tcp.h</span><br><span>+++ b/src/openvpn/mtcp.h</span><br><span>@@ -51,17 +5=
1,6 @@</span><br><span> </span><br><span> void multi_tcp_link_out_deferred(=
struct multi_context *m, struct multi_instance *mi);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/**********************************************=
****************************/</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Main ev=
ent loop for OpenVPN in TCP server mode.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @ingroup eventloop</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param top - Top-level context structure.</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void tunnel_server_tcp(struct context *top);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> void multi_tcp_delete_event(struct multi_protocol =
*multi_io, event_t event);</span><br><span> </span><br><span> #endif /* ifn=
def MTCP_H */</span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn=
/mudp.c</span><br><span>index cd53742..c71f0e2 100644</span><br><span>--- a=
/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><spa=
n>@@ -194,6 +194,7 @@</span><br><span>     struct hash *hash =3D m-&gt;hash=
;</span><br><span>     real.proto =3D sock-&gt;info.proto;</span><br><span>=
     m-&gt;local.proto =3D real.proto;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    m-&gt;hmac_reply_ls =3D sock;</span><br><span> </spa=
n><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;=
top.c2.from.dest, true)</span><br><span>         &amp;&amp; m-&gt;top.c2.bu=
f.len &gt; 0)</span><br><span>@@ -320,18 +321,59 @@</span><br><span>       =
  msg_set_prefix(&quot;Connection Attempt&quot;);</span><br><span>         =
m-&gt;top.c2.to_link =3D m-&gt;hmac_reply;</span><br><span>         m-&gt;t=
op.c2.to_link_addr =3D m-&gt;hmac_reply_dest;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        process_outgoing_link(&amp;m-&gt;top, m-&gt=
;top.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        process_outgoing_link(&amp;m-&gt;top, m-&gt;hmac_reply_ls);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m-&gt;hmac_re=
ply_ls =3D NULL;</span><br><span>         m-&gt;hmac_reply_dest =3D NULL;</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span>=
 /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the io=
_wait() flags appropriate for</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * a point-to-multipoint tunnel.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
p2mp_iow_flags(const struct multi_context *m)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    unsigned int flags =3D IOW_WAIT_SIGNAL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;pending)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (TUN_OUT(&amp;m-&gt;pending-&gt;context))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            flags |=3D IOW_TO=
_TUN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (LINK_OUT(&am=
p;m-&gt;pending-&gt;context))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            flags |=3D IOW_TO_LINK;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (mbuf_defined(m-&gt;mbuf))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     flags |=3D IOW_MBUF;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (m-&gt;hmac_reply_dest)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  flags |=3D IOW_TO_LINK;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D IOW_READ;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (tuntap_ring_empty(m-&gt;top.c1.tunta=
p))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        flags &amp;=3D ~IOW_RE=
AD_TUN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return flags;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span>  * Process an I/O event.</span><br><span>  */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> multi_process_io_ud=
p(struct multi_context *m)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const unsigned int status =3D m-&gt;top.c2.even=
t_set_status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst unsigned int status =3D m-&gt;multi_io-&gt;udp_flags;</span><br><span> =
    const unsigned int mpp_flags =3D m-&gt;top.c2.fast_io</span><br><span> =
                                   ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOS=
E_ON_SIGNAL)</span><br><span>                                    : (MPP_PRE=
_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span>@@ -428,123 +470,3 @@</span=
><br><span>     }</span><br><span> #endif</span><br><span> }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* Return the io_wait() flags appropriate for</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * a point-to-multipoint tunnel.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static inline unsigned int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-p2mp_iow_flags(const struct multi_context *m)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    unsigned int flags =3D IOW_WAIT_SIGNAL;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;pending)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (TUN_OUT(&amp;m-&gt;pending-&gt;=
context))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            flags |=3D I=
OW_TO_TUN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (LINK_OUT(&a=
mp;m-&gt;pending-&gt;context))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         flags |=3D IOW_TO_LINK;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (mbuf=
_defined(m-&gt;mbuf))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        flags |=
=3D IOW_MBUF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (m-&gt;hmac_=
reply_dest)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        flags |=3D IOW_TO_=
LINK;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        flags |=3D IOW_READ;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (tuntap_ring_empty(m-&gt;top.c1.tuntap))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        flags &amp;=3D ~IOW_READ_TUN;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tunnel_server_=
udp(struct context *top)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_=
context multi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    top-&gt;mode =3D CM_TOP;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    context_clear_2(t=
op);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* initialize top-tunnel instance =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_instance_h=
andle_signals(top, top-&gt;es, CC_HARD_USR1_TO_HUP);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (IS_SIG(top))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* initialize global mu=
lti_context object */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    multi_init(&amp;multi, top, false);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* initialize our cloned top object */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    multi_top_init(&amp;multi, top);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* initialize management interface */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    init_management_callback_multi(&amp;mul=
ti);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* finished with initialization */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    initialization_se=
quence_completed(top, ISC_SERVER); /* --mode server --proto udp */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    multi.top.c2.inotify_fd =3D inotify_init();<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (multi.top.c2.i=
notify_fd &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_=
ERRORS | M_ERRNO, &quot;MULTI: inotify_init error&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* per-packe=
t event loop */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wh=
ile (true)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_push(PERF_EVEN=
T_LOOP);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        /* set up and do the io_wa=
it() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_=
get_timeout(&amp;multi, &amp;multi.top.c2.timeval);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        io_wait(&amp;multi.top, p2mp_iow_fl=
ags(&amp;multi));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    MULTI_CHECK_SIG(&amp;multi);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*=
 check on status of coarse timers */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        multi_process_per_second_timers(&amp;multi);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /* timeout? */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (multi.top.c2.event_set_status =3D=3D =
ES_TIMEOUT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_proc=
ess_timeout(&amp;multi, MPP_PRE_SELECT|MPP_CLOSE_ON_SIGNAL);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            /* process I/O */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            multi_process_io_udp(&amp;multi);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            MULTI_CHECK_SIG(&amp;mult=
i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_A=
SYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    close(to=
p-&gt;c2.inotify_fd);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* shut down management interfac=
e */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uninit_manage=
ment_callback();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* save ifconfig-pool =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_ifconfig_=
pool_persist(&amp;multi, true);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tear=
 down tunnel instance (unless --persist-tun) */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    multi_uninit(&amp;multi);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    multi_top_free(&amp;multi);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    close_instance(top);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --git=
 a/src/openvpn/mudp.h b/src/openvpn/mudp.h</span><br><span>index 3107cc6..e=
329832 100644</span><br><span>--- a/src/openvpn/mudp.h</span><br><span>+++ =
b/src/openvpn/mudp.h</span><br><span>@@ -31,18 +31,9 @@</span><br><span> st=
ruct context;</span><br><span> struct multi_context;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int p2mp_iow_fl=
ags(const struct multi_context *m);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Main event loop for OpenVPN in UDP server mode.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * @ingroup eventloop</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * This function implements OpenVPN&#39;s main even=
t loop for UDP server mode.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param top=
 - Top-level context structure.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tun=
nel_server_udp(struct context *top);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_process_io_udp=
(struct multi_context *m);</span><br><span> /******************************=
********************************************/</span><br><span> /**</span><b=
r><span>  * Get, and if necessary create, the multi_instance associated wit=
h a</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c<=
/span><br><span>index 31b7224..47fd62b 100644</span><br><span>--- a/src/ope=
nvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -=
289,7 +289,7 @@</span><br><span>  * Main initialization function, init mult=
i_context object.</span><br><span>  */</span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-multi_init(struct multi_context *m, =
struct context *t, bool tcp_mode)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+multi_init(struct multi_context *m, struct context *t)</span>=
<br><span> {</span><br><span>     int dev =3D DEV_TYPE_UNDEF;</span><br><sp=
an> </span><br><span>@@ -435,13 +435,12 @@</span><br><span> </span><br><spa=
n>     m-&gt;instances =3D calloc(m-&gt;max_clients, sizeof(struct multi_in=
stance *));</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    m-&gt;top.c2.event_set =3D t-&gt;c2.event_set;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     * Initialize multi-socket =
TCP I/O wait object</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * Initialize multi-socket I/O wait object</span><br><span>      */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tcp_mode)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        m-&gt;multi_io =3D multi_protocol_i=
nit(t-&gt;options.max_clients, &amp;m-&gt;max_clients);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    m-&gt;multi_io =3D multi_protocol_init(t-&gt;option=
s.max_clients, &amp;m-&gt;max_clients);</span><br><span>     m-&gt;tcp_queu=
e_limit =3D t-&gt;options.tcp_queue_limit;</span><br><span> </span><br><spa=
n>     /*</span><br><span>@@ -607,6 +606,7 @@</span><br><span> </span><br><=
span>     ASSERT(!mi-&gt;halt);</span><br><span>     mi-&gt;halt =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool is_dgram =
=3D proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto);</span=
><br><span> </span><br><span>     dmsg(D_MULTI_DEBUG, &quot;MULTI: multi_cl=
ose_instance called&quot;);</span><br><span> </span><br><span>@@ -665,7 +66=
5,7 @@</span><br><span>             mi-&gt;did_iroutes =3D false;</span><br=
><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (m-&gt;multi_io)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!is_dgram)</span><br><span>         {</sp=
an><br><span>             multi_tcp_dereference_instance(m-&gt;multi_io, mi=
);</span><br><span>         }</span><br><span>@@ -774,7 +774,7 @@</span><br=
><span>         generate_prefix(mi);</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inherit_context=
_child(&amp;mi-&gt;context, &amp;m-&gt;top, ls);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    inherit_context_child(&amp;mi-&gt;context,=
 &amp;m-&gt;top, sock);</span><br><span>     if (IS_SIG(&amp;mi-&gt;context=
))</span><br><span>     {</span><br><span>         goto err;</span><br><spa=
n>@@ -794,6 +794,7 @@</span><br><span>         {</span><br><span>          =
   goto err;</span><br><span>         }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        mi-&gt;real.proto =3D sock-&gt;info.proto;</spa=
n><br><span>         generate_prefix(mi);</span><br><span>     }</span><br>=
<span> </span><br><span>@@ -3397,7 +3398,7 @@</span><br><span>             =
/* decrypt in instance context */</span><br><span> </span><br><span>       =
      perf_push(PERF_PROC_IN_LINK);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            lsi =3D get_link_socket_info(c);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            lsi =3D &amp;sock-&gt;in=
fo;</span><br><span>             orig_buf =3D c-&gt;c2.buf.data;</span><br>=
<span>             if (process_incoming_link_part1(c, lsi, floated))</span>=
<br><span>             {</span><br><span>@@ -3848,7 +3849,7 @@</span><br><s=
pan>     while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span>     =
{</span><br><span>         struct multi_instance *mi =3D (struct multi_inst=
ance *) he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (!mi-&gt;halt)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (!mi-&gt;halt &amp;&amp; proto_is_dgram(mi-&gt;context.opt=
ions.ce.proto))</span><br><span>         {</span><br><span>             sen=
d_control_channel_string(&amp;mi-&gt;context, next_server ? &quot;RESTART,[=
N]&quot; : &quot;RESTART&quot;, D_PUSH);</span><br><span>             multi=
_schedule_context_wakeup(m, mi);</span><br><span>@@ -3886,13 +3887,15 @@</s=
pan><br><span>         status_close(so);</span><br><span>         return fa=
lse;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else if (proto_is_dgram(m-&gt;top.options.ce.proto)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-             &amp;&amp; is_exit_res=
tart(m-&gt;top.sig-&gt;signal_received)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-             &amp;&amp; (m-&gt;deferred_shutdown_signal.s=
ignal_received =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-             &amp;&amp; m-&gt;top.options.ce.explicit_exit_notification =
!=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(has_udp_in_local_list(&amp;m-&gt;top.options))</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_push_restart=
_schedule_exit(m, m-&gt;top.options.ce.explicit_exit_notification =3D=3D 2)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (is_exi=
t_restart(m-&gt;top.sig-&gt;signal_received)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &amp;&amp; (m-&gt;deferred_shutdown_si=
gnal.signal_received =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &amp;&amp; m-&gt;top.options.ce.explicit_exit_notifi=
cation !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mul=
ti_push_restart_schedule_exit(m, m-&gt;top.options.ce.explicit_exit_notific=
ation =3D=3D 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span>     }</span><br><span>     return true;</span=
><br><span> }</span><br><span>@@ -4165,6 +4168,98 @@</span><br><span>     A=
SSERT(mi-&gt;context.c2.tls_multi-&gt;peer_id &lt; m-&gt;max_clients);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/*************************************************************=
*************/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Main event loop fo=
r OpenVPN in multi-protocol server mode.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @ingroup eventloop</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param top - Top-level context structure.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
tunnel_server_loop(struct multi_context *multi)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int status;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (tr=
ue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        perf_push(PERF_EVENT_L=
OOP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* wait on tun/socket lis=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_g=
et_timeout(multi, &amp;multi-&gt;top.c2.timeval);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        status =3D multi_protocol_io_wait(mul=
ti);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MULTI_C=
HECK_SIG(multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* check on st=
atus of coarse timers */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        multi_process_per_second_timers(multi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* timeout? */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (status &gt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /* process the I/O which triggered select */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_proto=
col_process_io(multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            MULTI_CHECK_SIG(multi);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else if (status =3D=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            multi_protocol_action(multi, NULL, TA_TIMEOUT, fal=
se);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        perf_pop();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+tunnel_server_init(struct context *=
top)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context multi;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    top-&gt;mode =3D CM_TOP;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    context_clear_2(top);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* initialize top-tunnel instance */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_instance_handl=
e_signals(top, top-&gt;es, CC_HARD_USR1_TO_HUP);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (IS_SIG(top))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* initialize glo=
bal multi_context object */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    multi_init(&amp;multi, top);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* initialize our cloned top object */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    multi_top_init(&amp;multi, top);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* initialize management interface */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    init_management_callback_m=
ulti(&amp;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* finished with =
initialization */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  initialization_sequence_completed(top, ISC_SERVER); /* --mode server --pr=
oto tcp-server */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_ASYNC_P=
USH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi.top.c2=
.inotify_fd =3D inotify_init();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (multi.top.c2.inotify_fd &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(D_MULTI_ERRORS | M_ERRNO, &quot;MULTI: inot=
ify_init error&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tunnel_server_loop(&amp;multi);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    #ifdef ENABLE_ASYNC_PUSH</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    close(top-&gt;c2.inotify_fd);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* shut down management interface */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uninit_management_callback()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* save ifconfig-pool */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    multi_ifconfig_pool_pers=
ist(&amp;multi, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* tear down=
 tunnel instance (unless --persist-tun) */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    multi_uninit(&amp;multi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi_top_free(&amp;multi);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    close_instance(top);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </spa=
n><br><span> /*</span><br><span>  * Top level event loop.</span><br><span>@=
@ -4174,12 +4269,6 @@</span><br><span> {</span><br><span>     ASSERT(top-&g=
t;options.mode =3D=3D MODE_SERVER);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (proto_is_dgram(top-&gt;options.ce.p=
roto))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        tunnel_server_udp(top);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        tunnel_server_tcp(top);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    tunnel_server_init(top);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> }</span><br><span>diff --git a/src/openvpn/=
multi.h b/src/openvpn/multi.h</span><br><span>index bef0b73..2bd168a 100644=
</span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvp=
n/multi.h</span><br><span>@@ -204,6 +204,7 @@</span><br><span> </span><br><=
span>     struct buffer hmac_reply;</span><br><span>     struct link_socket=
_actual *hmac_reply_dest;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct link_socket *hmac_reply_ls;</span><br><span> </span><br><s=
pan>     /*</span><br><span>      * Timer object for stale route check</spa=
n><br><span>@@ -251,10 +252,8 @@</span><br><span>  * Main event loop for Op=
enVPN in server mode.</span><br><span>  * @ingroup eventloop</span><br><spa=
n>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This function=
 calls the appropriate main event loop function depending</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * on the transport protocol used:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - \c tunnel_server_udp=
()</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - \c tunnel_ser=
ver_tcp()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This fu=
nction calls the main event loop function</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * on the transport protocols:</span><br><span>  *</s=
pan><br><span>  * @param top          - Top-level context structure.</span>=
<br><span>  */</span><br><span>@@ -267,7 +266,7 @@</span><br><span>  * Call=
ed by mtcp.c, mudp.c, or other (to be written) protocol drivers</span><br><=
span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void multi_init(struct multi_context *m, struct context *t, bool tcp_=
mode);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_in=
it(struct multi_context *m, struct context *t);</span><br><span> </span><br=
><span> void multi_uninit(struct multi_context *m);</span><br><span> </span=
><br><span>@@ -663,9 +662,12 @@</span><br><span> multi_process_outgoing_tun=
(struct multi_context *m, const unsigned int mpp_flags)</span><br><span> {<=
/span><br><span>     struct multi_instance *mi =3D m-&gt;pending;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mi)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span>     bool ret =3D true;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    AS=
SERT(mi);</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>  =
   printf(&quot;%s -&gt; TUN len=3D%d\n&quot;,</span><br><span>            =
id(mi),</span><br><span>diff --git a/src/openvpn/multi_io.c b/src/openvpn/m=
ulti_io.c</span><br><span>index 43fe24b..59661ed 100644</span><br><span>---=
 a/src/openvpn/multi_io.c</span><br><span>+++ b/src/openvpn/multi_io.c</spa=
n><br><span>@@ -142,6 +142,11 @@</span><br><span>                          =
            &amp;m-&gt;top.c2.link_sockets[i]-&gt;ev_arg);</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (has_udp_in_local_list(&amp;m-&gt;top.options))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        get_io_flags_udp(&amp;m-&gt;top, m-&gt;mu=
lti_io, p2mp_iow_flags(m));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> #ifdef _WIN32</span><br><span>     if (tuntap_is_wintun(m-&gt;t=
op.c1.tuntap))</span><br><span>     {</span><br><span>@@ -396,6 +401,10 @@<=
/span><br><span> multi_protocol_process_io(struct multi_context *m)</span><=
br><span> {</span><br><span>     struct multi_protocol *multi_io =3D m-&gt;=
multi_io;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
unsigned int udp_status =3D multi_io-&gt;udp_flags;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const unsigned int mpp_flags =3D m-&g=
t;top.c2.fast_io</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOSE_O=
N_SIGNAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                         : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><b=
r><span>     int i;</span><br><span> </span><br><span>     for (i =3D 0; i =
&lt; multi_io-&gt;n_esr; ++i)</span><br><span>@@ -447,6 +456,39 @@</span><b=
r><span>                         }</span><br><span>                        =
 break;</span><br><span>                     }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        if (e-&gt;arg &=
gt;=3D MULTI_N)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                            struct event_arg *ev_arg =3D (struct event_ar=
g *)e-&gt;arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                       if (ev_arg-&gt;type !=3D EVENT_ARG_LINK_SOCKET)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                  multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                msg(D_LI=
NK_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                           &quot;MULTI PROTOCOL: io_work: non socket event =
delivered&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                              break;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
  ev_arg-&gt;pending =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      if (udp_status &amp; SOCKET_READ)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                            read_=
incoming_link(&amp;m-&gt;top, ev_arg-&gt;u.sock);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            if (!IS_SIG(&amp;=
m-&gt;top))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                multi_process_incoming_link(m, NULL, mpp_=
flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                               ev_arg-&gt;u.sock);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                            multi_process_io_udp(m);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        break;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }<=
/span><br><span>             }</span><br><span>         }</span><br><span> =
        else</span><br><span>diff --git a/src/openvpn/openvpn.h b/src/openv=
pn/openvpn.h</span><br><span>index 77bb41d..821ac2e 100644</span><br><span>=
--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</sp=
an><br><span>@@ -220,8 +220,8 @@</span><br><span>  * \c SIGUSR1 restarts.</=
span><br><span>  *</span><br><span>  * This structure is initialized at the=
 top of the \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * tunn=
el_point_to_point(), \c tunnel_server_udp(), and \c</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * tunnel_server_tcp() functions.  In other=
 words, it is reset for every</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * tunnel_point_to_point(), \c tunnel_server() \c</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * functions.  In other words, it i=
s reset for every</span><br><span>  * iteration of the \c main() function&#=
39;s inner \c SIGUSR1 loop.</span><br><span>  */</span><br><span> struct co=
ntext_2</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/op=
tions.c</span><br><span>index d8b56ff..0091e42 100644</span><br><span>--- a=
/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><b=
r><span>@@ -993,10 +993,13 @@</span><br><span>                         cons=
t struct connection_entry *e,</span><br><span>                         cons=
t int i)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    setenv_str_i(es, &quot;proto&quot;, proto2ascii(e-&gt;proto, e-&g=
t;af, false), i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* expected to be for single socket contexts only */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;local&quot;, e-&=
gt;local_list-&gt;array[0]-&gt;local, i);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    setenv_str_i(es, &quot;local_port&quot;, e-&gt;loca=
l_list-&gt;array[0]-&gt;port, i);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    for (int j =3D 0; j &lt; e-&gt;local_list-&gt;len; j++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        setenv_str_i(es, &quot;prot=
o&quot;, proto2ascii(e-&gt;local_list-&gt;array[j]-&gt;proto, e-&gt;af, fal=
se), i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
expected to be for single socket contexts only */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        setenv_str_i(es, &quot;local&quot;, e=
-&gt;local_list-&gt;array[j]-&gt;local, i);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        setenv_str_i(es, &quot;local_port&quot;, e-=
&gt;local_list-&gt;array[j]-&gt;port, i);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span>     setenv_str_i(es, &quot;rem=
ote&quot;, e-&gt;remote, i);</span><br><span>     setenv_str_i(es, &quot;re=
mote_port&quot;, e-&gt;remote_port, i);</span><br><span> </span><br><span>@=
@ -2199,6 +2202,7 @@</span><br><span>     }</span><br><span> </span><br><sp=
an>     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    e-&gt;proto =3D PROTO_NONE;</span><b=
r><span>     l-&gt;array[l-&gt;len++] =3D e;</span><br><span> </span><br><s=
pan>     return e;</span><br><span>@@ -2465,7 +2469,7 @@</span><br><span>  =
   {</span><br><span>         struct local_entry *le =3D ce-&gt;local_list-=
&gt;array[i];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (proto_is_net(ce-&gt;proto)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (proto_is_net(le-&gt;proto)</span><=
br><span>             &amp;&amp; string_defined_equal(le-&gt;local, ce-&gt;=
remote)</span><br><span>             &amp;&amp; string_defined_equal(le-&gt=
;port, ce-&gt;remote_port))</span><br><span>         {</span><br><span>@@ -=
3170,14 +3174,30 @@</span><br><span>         if (ce-&gt;proto =3D=3D PROTO_=
TCP)</span><br><span>         {</span><br><span>             ce-&gt;proto =
=3D PROTO_TCP_SERVER;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            o-&gt;ce.proto =3D ce-&gt;proto;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (ce-&gt;local_list)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            for (int i =3D 0; i &lt; ce-&gt;local_list-&g=
t;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  if (ce-&gt;local_list-&gt;array[i]-&gt;proto =3D=3D PROTO_TCP)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    ce-&gt;local=
_list-&gt;array[i]-&gt;proto =3D PROTO_TCP_SERVER;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                else if (ce-&gt;local_list-&gt=
;array[i]-&gt;proto =3D=3D PROTO_NONE)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    ce-&gt;local_list-&gt;array[i]-&gt;pro=
to =3D ce-&gt;proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span>         }</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;cl=
ient)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;=
mode !=3D MODE_SERVER)</span><br><span>     {</span><br><span>         if (=
ce-&gt;proto =3D=3D PROTO_TCP)</span><br><span>         {</span><br><span> =
            ce-&gt;proto =3D PROTO_TCP_CLIENT;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            o-&gt;ce.proto =3D ce-&gt;proto;</sp=
an><br><span>         }</span><br><span>     }</span><br><span> </span><br>=
<span>@@ -3331,6 +3351,10 @@</span><br><span>     {</span><br><span>       =
  le-&gt;port =3D ce.local_port;</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!le-&gt;proto)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        le-&gt;proto =3D ce.proto;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br>=
<span> </span><br><span> #ifdef _WIN32</span><br><span>@@ -3807,6 +3831,12 =
@@</span><br><span>         options_postprocess_mutate_ce(o, o-&gt;connecti=
on_list-&gt;array[i]);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!has_udp_in_local_list(=
o))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;fast_io =3D fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INF=
O, &quot;NOTE: --fast-io is disabled while using multi-socket&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (o-&gt;ce.loca=
l_list)</span><br><span>     {</span><br><span>         for (i =3D 0; i &lt=
; o-&gt;ce.local_list-&gt;len; i++)</span><br><span>@@ -3822,6 +3852,7 @@</=
span><br><span>         ASSERT(e);</span><br><span>         e-&gt;port =3D =
o-&gt;ce.local_port;</span><br><span>         e-&gt;bind_local =3D o-&gt;co=
nnection_list-&gt;array[0]-&gt;bind_local;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        e-&gt;proto =3D o-&gt;ce.proto;</span><br><s=
pan>     }</span><br><span> </span><br><span>     /* use the same listen li=
st for every outgoing connection */</span><br><span>@@ -6232,7 +6263,7 @@</=
span><br><span>         VERIFY_PERMISSION(OPT_P_UP);</span><br><span>      =
   options-&gt;ifconfig_nowarn =3D true;</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;lo=
cal&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;local&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>        =
 struct local_entry *e;</span><br><span> </span><br><span>@@ -6253,7 +6284,=
12 @@</span><br><span>         if (p[2])</span><br><span>         {</span><=
br><span>             e-&gt;port =3D p[2];</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            e-&gt;bind_local =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            /*e-&gt;bind_local =3D =
true; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (p[3])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            e-&gt;proto =3D ascii2proto(p[3]);</spa=
n><br><span>         }</span><br><span>     }</span><br><span>     else if =
(streq(p[0], &quot;remote-random&quot;) &amp;&amp; !p[1])</span><br><span>@=
@ -9695,3 +9731,19 @@</span><br><span> err:</span><br><span>     gc_free(&a=
mp;gc);</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+has_udp_in_local_list(const=
 struct options *options)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opti=
ons-&gt;ce.local_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for=
 (int i =3D 0; i &lt; options-&gt;ce.local_list-&gt;len; i++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (proto_is_dgram(options-&g=
t;ce.local_list-&gt;array[i]-&gt;proto))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span>=
<br><span>index 6942455..30bd5aa 100644</span><br><span>--- a/src/openvpn/o=
ptions.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -99=
,6 +99,7 @@</span><br><span>     const char *local;</span><br><span>     co=
nst char *port;</span><br><span>     bool bind_local;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int proto;</span><br><span> };</span>=
<br><span> </span><br><span> struct connection_entry</span><br><span>@@ -91=
6,6 +917,8 @@</span><br><span> </span><br><span> bool key_is_external(const=
 struct options *options);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool has_udp_in_local_list(const struct options *o=
ptions);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /**</span><br><span>  * Returns whether the current configuration ha=
s dco enabled.</span><br><span>  */</span><br><span>diff --git a/src/openvp=
n/socket.c b/src/openvpn/socket.c</span><br><span>index 06acd5a..67c88f0 10=
0644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/o=
penvpn/socket.c</span><br><span>@@ -1874,16 +1874,39 @@</span><br><span>   =
                      int sock_index,</span><br><span>                     =
    int mode)</span><br><span> {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char *host =3D c-&gt;options.ce.local_list-&gt;array=
[sock_index]-&gt;local;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *port =3D c-&gt;options.ce.local_list-&gt;array[sock_ind=
ex]-&gt;port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t proto =3D c-&gt;options.ce.local_list-&gt;array[sock_index]-&gt;proto;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool bind_local =
=3D c-&gt;options.ce.local_list-&gt;array[sock_index]-&gt;bind_local;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_CHILD_TCP || c-=
&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct link_socket *tmp_sock =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            tmp_sock =3D (struct link_=
socket *)c-&gt;c2.accept_from;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        else if (c-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            tmp_sock =3D c-&gt;c2.link_sockets[0];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        host =3D tmp_sock-&gt;local_host;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        port =3D tmp_sock-&gt;l=
ocal_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p=
roto =3D tmp_sock-&gt;info.proto;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        bind_local =3D tmp_sock-&gt;bind_local;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     ASSERT(c-&gt;c2.link_sock=
ets[sock_index]);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    c-&gt;c2.link_sockets[sock_index]-&gt;local_host =3D c-&g=
t;options.ce.local_list-&gt;array[sock_index]-&gt;local;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2.link_sockets[sock_index]-&g=
t;local_port =3D c-&gt;options.ce.local_list-&gt;array[sock_index]-&gt;port=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_=
sockets[sock_index]-&gt;local_host =3D host;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets[sock_index]-&gt;local_po=
rt =3D port;</span><br><span>     c-&gt;c2.link_sockets[sock_index]-&gt;rem=
ote_host =3D c-&gt;options.ce.remote;</span><br><span>     c-&gt;c2.link_so=
ckets[sock_index]-&gt;remote_port =3D c-&gt;options.ce.remote_port;</span><=
br><span>     c-&gt;c2.link_sockets[sock_index]-&gt;dns_cache =3D c-&gt;c1.=
dns_cache;</span><br><span>     c-&gt;c2.link_sockets[sock_index]-&gt;http_=
proxy =3D c-&gt;c1.http_proxy;</span><br><span>     c-&gt;c2.link_sockets[s=
ock_index]-&gt;socks_proxy =3D c-&gt;c1.socks_proxy;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2.link_sockets[sock_index]-&gt;b=
ind_local =3D c-&gt;options.ce.local_list-&gt;array[sock_index]-&gt;bind_lo=
cal;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.li=
nk_sockets[sock_index]-&gt;bind_local =3D bind_local;</span><br><span>     =
c-&gt;c2.link_sockets[sock_index]-&gt;resolve_retry_seconds =3D c-&gt;optio=
ns.resolve_retry_seconds;</span><br><span>     c-&gt;c2.link_sockets[sock_i=
ndex]-&gt;mtu_discover_type =3D c-&gt;options.ce.mtu_discover_type;</span><=
br><span> </span><br><span>@@ -1905,7 +1928,7 @@</span><br><span> </span><b=
r><span>     c-&gt;c2.link_sockets[sock_index]-&gt;mark =3D c-&gt;options.m=
ark;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    c-&gt;c2.link_sockets[sock_index]-&gt;info.proto =3D c-&gt;options.ce.=
proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.=
link_sockets[sock_index]-&gt;info.proto =3D proto;</span><br><span>     c-&=
gt;c2.link_sockets[sock_index]-&gt;info.af =3D c-&gt;options.ce.af;</span><=
br><span>     c-&gt;c2.link_sockets[sock_index]-&gt;info.remote_float =3D c=
-&gt;options.ce.remote_float;</span><br><span>     c-&gt;c2.link_sockets[so=
ck_index]-&gt;info.lsa =3D &amp;c-&gt;c1.link_socket_addrs[sock_index];</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/764?usp=3Demail">change 764</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/764?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31bbf87e4e568021445c7512ece=
fadfd4a69b363 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 764 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ICBUIu9k/8E=--

