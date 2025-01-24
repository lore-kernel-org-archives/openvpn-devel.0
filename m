From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 24 Jan 2025 11:45:38 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <8f12f55f12026e1ae0184a5355dfd6ee607b4888-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="42E7jK901Sk="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for
 simultaneous use of UDP and TCP sockets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--42E7jK901Sk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, its_Giaan, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail

to look at the new patch set (#15).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: Add support for simultaneous use of UDP and TCP sockets
......................................................................

Add support for simultaneous use of UDP and TCP sockets

Add all the bound sockets to the event loop.

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
17 files changed, 496 insertions(+), 274 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/764/15

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index 4496da2..d48021e 100644
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
index f3f3503..9e9da6c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1767,7 +1767,7 @@
             if (c->options.shaper)
             {
                 int overhead =3D datagram_overhead(c->c2.to_link_addr->des=
t.addr.sa.sa_family,
-                                                 c->options.ce.proto);
+                                                 sock->info.proto);
                 shaper_wrote_bytes(&c->c2.shaper,
                                    BLEN(&c->c2.to_link) + overhead);
             }
@@ -2064,6 +2064,173 @@
  */

 void
+get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io, cons=
t unsigned int flags)
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
+get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsig=
ned int flags)
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
@@ -2301,6 +2468,7 @@
     dmsg(D_EVENT_WAIT, "I/O WAIT status=3D0x%04x", c->c2.event_set_status);
 }

+
 void
 process_io(struct context *c, struct link_socket *sock)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 214a322..441bc16 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -69,6 +69,10 @@

 extern counter_type link_write_bytes_global;

+void get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io,=
 const unsigned int flags);
+
+void get_io_flags_udp(struct context *c, struct multi_io *multi_io, const =
unsigned int flags);
+
 void io_wait_dowork(struct context *c, const unsigned int flags);

 void pre_select(struct context *c);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4014517..d84f826 100644
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
@@ -611,7 +611,10 @@
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
@@ -2681,7 +2684,7 @@

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
@@ -2837,14 +2840,21 @@
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
@@ -2862,7 +2872,7 @@
     }

     /* Slow down reconnection after 5 retries per remote -- for TCP client=
 or UDP tls-client only */
-    if (c->options.ce.proto =3D=3D PROTO_TCP_CLIENT
+    if (c->mode =3D=3D CM_CHILD_TCP
         || (c->options.ce.proto =3D=3D PROTO_UDP && c->options.tls_client))
     {
         backoff =3D (c->options.unsuccessful_attempts / c->options.connect=
ion_list->len) - 4;
@@ -3342,7 +3352,21 @@
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
@@ -3387,7 +3411,7 @@

     /* should we not xmit any packets until we get an initial
      * response from client? */
-    if (to.server && options->ce.proto =3D=3D PROTO_TCP_SERVER)
+    if (to.server && c->mode =3D=3D CM_CHILD_TCP)
     {
         to.xmit_hold =3D true;
     }
@@ -3831,7 +3855,6 @@
     for (int i =3D 0; i < c->c1.link_sockets_num; i++)
     {
         int mode =3D LS_MODE_DEFAULT;
-
         /* mode allows CM_CHILD_TCP
          * instances to inherit acceptable fds
          * from a top-level parent */
@@ -3848,7 +3871,6 @@
                 mode =3D LS_MODE_TCP_ACCEPT_FROM;
             }
         }
-
         /* init each socket with its specific args */
         link_socket_init_phase1(c, i, mode);
     }
@@ -4238,20 +4260,13 @@
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
@@ -4658,7 +4673,7 @@
     }

     /* our wait-for-i/o objects, different for posix vs. win32 */
-    if (c->mode =3D=3D CM_P2P)
+    if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP)
     {
         do_event_set_init(c, SHAPER_DEFINED(&c->options));
     }
@@ -4925,7 +4940,7 @@
     CLEAR(*dest);

     /* proto_is_dgram will ASSERT(0) if proto is invalid */
-    dest->mode =3D proto_is_dgram(src->options.ce.proto) ? CM_CHILD_UDP : =
CM_CHILD_TCP;
+    dest->mode =3D proto_is_dgram(ls->info.proto) ? CM_CHILD_UDP : CM_CHIL=
D_TCP;

     dest->gc =3D gc_new();

@@ -4951,8 +4966,11 @@

     /* options */
     dest->options =3D src->options;
+    dest->options.ce.proto =3D ls->info.proto;
     options_detach(&dest->options);

+    dest->c2.event_set =3D src->c2.event_set;
+
     if (dest->mode =3D=3D CM_CHILD_TCP)
     {
         /*
@@ -5044,10 +5062,7 @@
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
index 74923cf..5e37799 100644
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
index 1c44b35..2659695 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -210,6 +210,10 @@
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
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 62ed044..582e9b3 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -54,7 +54,7 @@
     struct hash *hash =3D m->hash;

     mi =3D multi_create_instance(m, NULL, ls);
-    if (mi)
+    if (mi && !proto_is_dgram(ls->info.proto))
     {
         mi->real.proto =3D ls->info.proto;
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

@@ -229,87 +236,3 @@
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
-        status =3D multi_io_wait(&multi);
-        MULTI_CHECK_SIG(&multi);
-
-        /* check on status of coarse timers */
-        multi_process_per_second_timers(&multi);
-
-        /* timeout? */
-        if (status > 0)
-        {
-            /* process the I/O which triggered select */
-            multi_io_process_io(&multi);
-            MULTI_CHECK_SIG(&multi);
-        }
-        else if (status =3D=3D 0)
-        {
-            multi_io_action(&multi, NULL, TA_TIMEOUT, false);
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
index 0da0a7d..0a5b045 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -50,17 +50,6 @@

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
 void multi_tcp_delete_event(struct multi_io *multi_io, event_t event);

 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 4f2bbd7..86e1713 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -193,6 +193,7 @@
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;
     real.proto =3D ls->info.proto;
+    m->hmac_reply_ls =3D ls;

     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
@@ -319,7 +320,8 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link =3D m->hmac_reply;
         m->top.c2.to_link_addr =3D m->hmac_reply_dest;
-        process_outgoing_link(&m->top, m->top.c2.link_sockets[0]);
+        process_outgoing_link(&m->top, m->hmac_reply_ls);
+        m->hmac_reply_ls =3D NULL;
         m->hmac_reply_dest =3D NULL;
     }
 }
@@ -327,10 +329,10 @@
 /*
  * Process an I/O event.
  */
-static void
+void
 multi_process_io_udp(struct multi_context *m, struct link_socket *sock)
 {
-    const unsigned int status =3D m->top.c2.event_set_status;
+    const unsigned int status =3D m->multi_io->udp_flags;
     const unsigned int mpp_flags =3D m->top.c2.fast_io
                                    ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
                                    : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
@@ -423,7 +425,7 @@
  * Return the io_wait() flags appropriate for
  * a point-to-multipoint tunnel.
  */
-static inline unsigned int
+unsigned int
 p2mp_iow_flags(const struct multi_context *m)
 {
     unsigned int flags =3D IOW_WAIT_SIGNAL;
@@ -458,87 +460,3 @@
 #endif
     return flags;
 }
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
-
-            /* Since there's only one link_socket just use the first, in a=
n upcoming
-             * patch this will be changed by using the link_socket returne=
d by the
-             * event set */
-            multi_process_io_udp(&multi, top->c2.link_sockets[0]);
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
index b378754..357b684 100644
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
+void multi_process_io_udp(struct multi_context *m, struct link_socket *ls);
 /*************************************************************************=
*/
 /**
  * Get, and if necessary create, the multi_instance associated with a
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 63c5a83..809fde5 100644
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
-        m->multi_io =3D multi_io_init(t->options.max_clients, &m->max_clie=
nts);
-    }
+    m->multi_io =3D multi_io_init(t->options.max_clients, &m->max_clients);
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
@@ -794,6 +794,7 @@
         {
             goto err;
         }
+        mi->real.proto =3D ls->info.proto;
         generate_prefix(mi);
     }

@@ -3389,7 +3390,7 @@
             /* decrypt in instance context */

             perf_push(PERF_PROC_IN_LINK);
-            lsi =3D get_link_socket_info(c);
+            lsi =3D &ls->info;
             orig_buf =3D c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
@@ -3837,7 +3838,7 @@
     while ((he =3D hash_iterator_next(&hi)))
     {
         struct multi_instance *mi =3D (struct multi_instance *) he->value;
-        if (!mi->halt)
+        if (!mi->halt && proto_is_dgram(mi->context.options.ce.proto))
         {
             send_control_channel_string(&mi->context, next_server ? "RESTA=
RT,[N]" : "RESTART", D_PUSH);
             multi_schedule_context_wakeup(m, mi);
@@ -3875,13 +3876,15 @@
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
@@ -4154,6 +4157,98 @@
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
+        status =3D multi_io_wait(multi);
+        MULTI_CHECK_SIG(multi);
+
+        /* check on status of coarse timers */
+        multi_process_per_second_timers(multi);
+
+        /* timeout? */
+        if (status > 0)
+        {
+            /* process the I/O which triggered select */
+            multi_io_process_io(multi);
+            MULTI_CHECK_SIG(multi);
+        }
+        else if (status =3D=3D 0)
+        {
+            multi_io_action(multi, NULL, TA_TIMEOUT, false);
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
@@ -4163,12 +4258,6 @@
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
index eacfb52..092aed6 100644
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
index e4174dd..9e012e0 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -155,6 +155,11 @@
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
@@ -442,14 +447,13 @@
                     }
                     break;

-                /* new incoming TCP client attempting to connect? */
                 case EVENT_ARG_LINK_SOCKET:
                     if (!ev_arg->u.sock)
                     {
                         msg(D_MULTI_ERRORS, "MULTI IO: multi_io_proc_io: n=
ull socket");
                         break;
                     }
-
+                    /* new incoming TCP client attempting to connect? */
                     if (!proto_is_dgram(ev_arg->u.sock->info.proto))
                     {
                         socket_reset_listen_persistent(ev_arg->u.sock);
@@ -460,6 +464,11 @@
                         }
                         break;
                     }
+                    else
+                    {
+                        multi_process_io_udp(m, ev_arg->u.sock);
+                        break;
+                    }
             }
         }
         else
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index df43bba..581d248 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -216,8 +216,8 @@
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
index c938999..58e8c14 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -997,10 +997,6 @@
                         const struct connection_entry *e,
                         const int i)
 {
-    setenv_str_i(es, "proto", proto2ascii(e->proto, e->af, false), i);
-    /* expected to be for single socket contexts only */
-    setenv_str_i(es, "local", e->local_list->array[0]->local, i);
-    setenv_str_i(es, "local_port", e->local_list->array[0]->port, i);
     setenv_str_i(es, "remote", e->remote, i);
     setenv_str_i(es, "remote_port", e->remote_port, i);
=20
@@ -1016,6 +1012,16 @@
     }
 }

+static void
+setenv_local_entry(struct env_set *es,
+                   const struct local_entry *e,
+                   const int i)
+{
+    setenv_str_i(es, "proto", proto2ascii(e->proto, AF_UNSPEC, false), i+1=
);
+    setenv_str_i(es, "local", e->local, i+1);
+    setenv_str_i(es, "local_port", e->port, i+1);
+}
+
 void
 setenv_settings(struct env_set *es, const struct options *o)
 {
@@ -1039,6 +1045,14 @@
         setenv_connection_entry(es, &o->ce, 1);
     }

+    if (o->ce.local_list)
+    {
+        for (int i =3D 0; i < o->ce.local_list->len; i++)
+        {
+            setenv_local_entry(es, o->ce.local_list->array[i], i+1);
+        }
+    }
+
     if (!o->pull)
     {
         setenv_dns_options(&o->dns_options, es);
@@ -2203,6 +2217,7 @@
     }

     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);
+    e->proto =3D PROTO_NONE;
     l->array[l->len++] =3D e;

     return e;
@@ -2469,7 +2484,7 @@
     {
         struct local_entry *le =3D ce->local_list->array[i];

-        if (proto_is_net(ce->proto)
+        if (proto_is_net(le->proto)
             && string_defined_equal(le->local, ce->remote)
             && string_defined_equal(le->port, ce->remote_port))
         {
@@ -3174,14 +3189,30 @@
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

@@ -3330,6 +3361,11 @@
     {
         le->port =3D ce.local_port;
     }
+    if (!le->proto)
+    {
+        le->proto =3D ce.proto;
+    }
+
 }

 #ifdef _WIN32
@@ -3787,6 +3823,7 @@
         struct local_entry *e =3D alloc_local_entry(&o->ce, M_USAGE, &o->g=
c);
         ASSERT(e);
         e->port =3D o->ce.local_port;
+        e->proto =3D o->ce.proto;
     }

     /* use the same listen list for every outgoing connection */
@@ -3795,6 +3832,12 @@
         o->connection_list->array[i]->local_list =3D o->ce.local_list;
     }

+    if (has_tcp_in_local_list(o))
+    {
+        o->fast_io =3D false;
+        msg(M_INFO, "NOTE: --fast-io is disabled while using multi-socket"=
);
+    }
+
     if (o->tls_server)
     {
         /* Check that DH file is specified, or explicitly disabled */
@@ -6190,7 +6233,7 @@
         VERIFY_PERMISSION(OPT_P_UP);
         options->ifconfig_nowarn =3D true;
     }
-    else if (streq(p[0], "local") && p[1] && !p[3])
+    else if (streq(p[0], "local") && p[1] && !p[4])
     {
         struct local_entry *e;

@@ -6211,6 +6254,11 @@
         {
             e->port =3D p[2];
         }
+
+        if (p[3])
+        {
+            e->proto =3D ascii2proto(p[3]);
+        }
     }
     else if (streq(p[0], "remote-random") && !p[1])
     {
@@ -9645,3 +9693,37 @@
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
+
+    return false;
+}
+
+bool
+has_tcp_in_local_list(const struct options *options)
+{
+    if (options->ce.local_list)
+    {
+        for (int i =3D 0; i < options->ce.local_list->len; i++)
+        {
+            if (!proto_is_dgram(options->ce.local_list->array[i]->proto))
+            {
+                return true;
+            }
+        }
+    }
+
+    return false;
+}
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3f4cb90..161899a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -98,6 +98,7 @@
 {
     const char *local;
     const char *port;
+    int proto;
 };

 struct connection_entry
@@ -917,6 +918,10 @@

 bool key_is_external(const struct options *options);

+bool has_udp_in_local_list(const struct options *options);
+
+bool has_tcp_in_local_list(const struct options *options);
+
 /**
  * Returns whether the current configuration has dco enabled.
  */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 97dce02..ba0891a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1888,11 +1888,33 @@
     struct options *o =3D &c->options;
     ASSERT(sock);
=20
+    const char *host =3D o->ce.local_list->array[sock_index]->local;
+    const char *port =3D o->ce.local_list->array[sock_index]->port;
+    int proto =3D o->ce.local_list->array[sock_index]->proto;
     const char *remote_host =3D o->ce.remote;
     const char *remote_port =3D o->ce.remote_port;

-    sock->local_host =3D o->ce.local_list->array[sock_index]->local;
-    sock->local_port =3D o->ce.local_list->array[sock_index]->port;
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
+    }
+
+    ASSERT(c->c2.link_sockets[sock_index]);
+
+    sock->local_host =3D host;
+    sock->local_port =3D port;
     sock->remote_host =3D remote_host;
     sock->remote_port =3D remote_port;
     sock->dns_cache =3D c->c1.dns_cache;
@@ -1920,7 +1942,7 @@

     sock->mark =3D o->mark;
     sock->bind_dev =3D o->bind_dev;
-    sock->info.proto =3D o->ce.proto;
+    sock->info.proto =3D proto;
     sock->info.af =3D o->ce.af;
     sock->info.remote_float =3D o->ce.remote_float;
     sock->info.lsa =3D &c->c1.link_socket_addrs[sock_index];

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Gerrit-Change-Number: 764
Gerrit-PatchSet: 15
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-MessageType: newpatchset

--42E7jK901Sk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #15</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Add support for simultaneous use of UDP and TCP sock=
ets<br><br>Add all the bound sockets to the event loop.<br><br>The main ser=
ver loop has been updated to handle both<br>TCP and UDP connections.<br><br=
>The hash function has also been modified to include the<br>protocol during=
 the creation of new client instances.<br><br>There are also a couple of re=
finements to make the<br>whole code flow management capable of handling<br>=
different kind of clients:<br><br>MULTI: properly remove TCP instances by c=
hecking the multi_instance<br>       protocol instead of the global one.<br=
><br>TLS: set the tls_option xmit_hold bool value to true only in case of<b=
r>     TCP child instance to avoid checking the global protocol<br>     val=
ue.<br><br>INIT: initialize the c-&gt;c2.event_set in the inherit_context_t=
op()<br>      by default and not only in case of UDP since we could have<br=
>      multiple different sockets.<br><br>Change-Id: I31bbf87e4e568021445c7=
512ecefadfd4a69b363<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...1186...=
.2726...&gt;<br>---<br>M doc/man-sections/link-options.rst<br>M src/openvpn=
/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/init.c<br>M src/open=
vpn/mroute.c<br>M src/openvpn/mroute.h<br>M src/openvpn/mtcp.c<br>M src/ope=
nvpn/mtcp.h<br>M src/openvpn/mudp.c<br>M src/openvpn/mudp.h<br>M src/openvp=
n/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/multi_io.c<br>M src/ope=
nvpn/openvpn.h<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M s=
rc/openvpn/socket.c<br>17 files changed, 496 insertions(+), 274 deletions(-=
)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64=
/764/15</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/doc/man-sections/link-options.rst b/doc/man-se=
ctions/link-options.rst</span><br><span>index 4496da2..d48021e 100644</span=
><br><span>--- a/doc/man-sections/link-options.rst</span><br><span>+++ b/do=
c/man-sections/link-options.rst</span><br><span>@@ -106,7 +106,7 @@</span><=
br><span>   is not reliable. It is recommended to set tun-mtu with enough h=
eadroom</span><br><span>   instead.</span><br><span> </span><br><span>---lo=
cal host|* [port]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--=
local host|* [port] [protocol]</span><br><span>   Local host name or IP add=
ress and port for bind. If specified, OpenVPN will bind</span><br><span>   =
to this address. If unspecified, OpenVPN will bind to all interfaces.</span=
><br><span>   &#39;*&#39; can be used as hostname and means &#39;any host&#=
39; (OpenVPN will listen on what</span><br><span>diff --git a/src/openvpn/f=
orward.c b/src/openvpn/forward.c</span><br><span>index f3f3503..9e9da6c 100=
644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/o=
penvpn/forward.c</span><br><span>@@ -1767,7 +1767,7 @@</span><br><span>    =
         if (c-&gt;options.shaper)</span><br><span>             {</span><br=
><span>                 int overhead =3D datagram_overhead(c-&gt;c2.to_link=
_addr-&gt;dest.addr.sa.sa_family,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                                 c-&gt;options.=
ce.proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                        sock-&gt;info.proto);</span><br><sp=
an>                 shaper_wrote_bytes(&amp;c-&gt;c2.shaper,</span><br><spa=
n>                                    BLEN(&amp;c-&gt;c2.to_link) + overhea=
d);</span><br><span>             }</span><br><span>@@ -2064,6 +2064,173 @@<=
/span><br><span>  */</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+get_io_flags_dowork_udp(struct con=
text *c, struct multi_io *multi_io, const unsigned int flags)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    unsigned int socket =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    unsigned int tuntap =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t tun_shif=
t =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static =
uintptr_t err_shift =3D 4;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Calculate the flag=
s based on the provided &#39;flags&#39; argument.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (flags &amp; IOW_WAIT_SIGNAL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        wait_signal(multi_io-&gt;es, (void *)err_shift=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (flags &amp; IOW_TO_LINK)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (flags &amp; IOW_SHAPER)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             * If sending this packet would put us=
 over our traffic shaping</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+             * quota, don&#39;t send -- instead compute the delay we =
must wait</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
   * until it will be OK to send the packet.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            int delay =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            /* set traffic shaping delay in microseconds */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (c-&gt;op=
tions.shaper)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    delay =3D max_int(delay, shaper_delay(&amp;c-&gt;c2.shaper));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (delay &lt; 1000)</span><br><span style=
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
 hsl(120, 100%, 40%);">+get_io_flags_udp(struct context *c, struct multi_io=
 *multi_io, const unsigned int flags)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (c-&gt;c2.fast_io &amp;&amp; (flags &amp; (IOW_=
TO_TUN | IOW_TO_LINK | IOW_MBUF)))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* fast path -- only for TUN/TAP/UDP writes */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        unsigned int ret =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp; IOW=
_TO_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret |=3D =
TUN_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &=
amp; (IOW_TO_LINK | IOW_MBUF))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            ret |=3D SOCKET_WRITE;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        multi_io-&gt;udp_flags =3D ret;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool skip_i=
owait =3D flags &amp; IOW_TO_TUN;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (flags &amp; IOW_READ_TUN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             * don&#39;t read from tun if we have pendin=
g write to link,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          * since every tun read overwrites to_link buffer filled</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+             * by previous tu=
n read</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            skip_=
iowait =3D !(flags &amp; IOW_TO_LINK);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (tuntap_is_wintun(c-&gt;c1.tuntap) &amp;&amp; skip_iowa=
it)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            unsigned int r=
et =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                ret |=3D TUN_WRITE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (flags &amp; IOW_READ_TUN)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                ret |=3D TUN_READ;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            multi_io-&gt;udp_flags =
=3D ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef _WIN32 */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            /* slow path - deleg=
ate to io_wait_dowork_udp to calculate flags */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            get_io_flags_dowork_udp(c, multi_io=
, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span> io_wait_dowork(struct context *c, const unsigned =
int flags)</span><br><span> {</span><br><span>     unsigned int socket =3D =
0;</span><br><span>@@ -2301,6 +2468,7 @@</span><br><span>     dmsg(D_EVENT_=
WAIT, &quot;I/O WAIT status=3D0x%04x&quot;, c-&gt;c2.event_set_status);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> void</span><br><span> process_io(struct con=
text *c, struct link_socket *sock)</span><br><span> {</span><br><span>diff =
--git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>index=
 214a322..441bc16 100644</span><br><span>--- a/src/openvpn/forward.h</span>=
<br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -69,6 +69,10 @@</s=
pan><br><span> </span><br><span> extern counter_type link_write_bytes_globa=
l;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io,=
 const unsigned int flags);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void get_io=
_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned int=
 flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> void io_wait_dowork(struct context *c, const unsigned int flags);</s=
pan><br><span> </span><br><span> void pre_select(struct context *c);</span>=
<br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><s=
pan>index 4014517..d84f826 100644</span><br><span>--- a/src/openvpn/init.c<=
/span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -225,7 +225,7 @=
@</span><br><span>         if (streq(p[1], &quot;HTTP&quot;))</span><br><sp=
an>         {</span><br><span>             struct http_proxy_options *ho;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (ce-&gt;=
proto !=3D PROTO_TCP &amp;&amp; ce-&gt;proto !=3D PROTO_TCP_CLIENT)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (ce-&gt;prot=
o !=3D PROTO_TCP &amp;&amp; c-&gt;mode !=3D CM_CHILD_TCP)</span><br><span> =
            {</span><br><span>                 msg(M_WARN, &quot;HTTP proxy=
 support only works for TCP based connections&quot;);</span><br><span>     =
            return false;</span><br><span>@@ -611,7 +611,10 @@</span><br><s=
pan>             ce_defined =3D false;</span><br><span>         }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int=
 proto =3D c-&gt;options.ce.proto;</span><br><span>         c-&gt;options.c=
e =3D *ce;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
-&gt;options.ce.proto =3D proto;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>   =
      if (ce_defined &amp;&amp; management &amp;&amp; management_query_remo=
te_enabled(management))</span><br><span>         {</span><br><span>@@ -2681=
,7 +2684,7 @@</span><br><span> </span><br><span>     if (found &amp; OPT_P_=
EXPLICIT_NOTIFY)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (!proto_is_udp(c-&gt;options.ce.proto) &amp;&a=
mp; c-&gt;options.ce.explicit_exit_notification)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (!proto_is_udp(c-&gt;c2.link_socket=
s[0]-&gt;info.proto) &amp;&amp; c-&gt;options.ce.explicit_exit_notification=
)</span><br><span>         {</span><br><span>             msg(D_PUSH, &quot=
;OPTIONS IMPORT: --explicit-exit-notify can only be used with --proto udp&q=
uot;);</span><br><span>             c-&gt;options.ce.explicit_exit_notifica=
tion =3D 0;</span><br><span>@@ -2837,14 +2840,21 @@</span><br><span>     in=
t sec =3D 2;</span><br><span>     int backoff =3D 0;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (c-&gt;options.=
ce.proto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch=
 (c-&gt;mode)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        case PROTO_TCP_SERVER:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            sec =3D 1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        case CM_TOP:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (has_udp_in_local_list(&amp;c-&g=
t;options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  sec =3D c-&gt;options.ce.connect_retry_seconds;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                sec =3D 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span>             break;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 case PROTO_UDP:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   case PROTO_TCP_CLIENT:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        case CM_CHILD_UDP:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        case CM_CHILD_TCP:</span><br><span>             sec =
=3D c-&gt;options.ce.connect_retry_seconds;</span><br><span>             br=
eak;</span><br><span>     }</span><br><span>@@ -2862,7 +2872,7 @@</span><br=
><span>     }</span><br><span> </span><br><span>     /* Slow down reconnect=
ion after 5 retries per remote -- for TCP client or UDP tls-client only */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options.=
ce.proto =3D=3D PROTO_TCP_CLIENT</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (c-&gt;mode =3D=3D CM_CHILD_TCP</span><br><span>       =
  || (c-&gt;options.ce.proto =3D=3D PROTO_UDP &amp;&amp; c-&gt;options.tls_=
client))</span><br><span>     {</span><br><span>         backoff =3D (c-&gt=
;options.unsuccessful_attempts / c-&gt;options.connection_list-&gt;len) - 4=
;</span><br><span>@@ -3342,7 +3352,21 @@</span><br><span>     to.server =3D=
 options-&gt;tls_server;</span><br><span>     to.replay_window =3D options-=
&gt;replay_window;</span><br><span>     to.replay_time =3D options-&gt;repl=
ay_time;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    to.tcp_mo=
de =3D link_socket_proto_connection_oriented(options-&gt;ce.proto);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (c-&gt;options.ce.local_list-&gt;len &g=
t; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i =
&lt; c-&gt;options.ce.local_list-&gt;len; i++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (proto_is_dgram(c-&gt;options.ce.local_list=
-&gt;array[i]-&gt;proto))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                to.tcp_mode =3D false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        to.tcp_mode =3D link_socket_=
proto_connection_oriented(c-&gt;options.ce.local_list-&gt;array[0]-&gt;prot=
o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span>     to.config_ciphername =3D c-&gt;options.ciphername;</span><br><sp=
an>     to.config_ncp_ciphers =3D c-&gt;options.ncp_ciphers;</span><br><spa=
n>     to.transition_window =3D options-&gt;transition_window;</span><br><s=
pan>@@ -3387,7 +3411,7 @@</span><br><span> </span><br><span>     /* should =
we not xmit any packets until we get an initial</span><br><span>      * res=
ponse from client? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (to.server &amp;&amp; options-&gt;ce.proto =3D=3D PROTO_TCP_SERVER)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (to.server &a=
mp;&amp; c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span>     {</span><br><=
span>         to.xmit_hold =3D true;</span><br><span>     }</span><br><span=
>@@ -3831,7 +3855,6 @@</span><br><span>     for (int i =3D 0; i &lt; c-&gt;=
c1.link_sockets_num; i++)</span><br><span>     {</span><br><span>         i=
nt mode =3D LS_MODE_DEFAULT;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>         /* mode allows CM_CHILD_TCP</span><br><spa=
n>          * instances to inherit acceptable fds</span><br><span>         =
 * from a top-level parent */</span><br><span>@@ -3848,7 +3871,6 @@</span><=
br><span>                 mode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span=
>             }</span><br><span>         }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span>         /* init each socket with its=
 specific args */</span><br><span>         link_socket_init_phase1(c, i, mo=
de);</span><br><span>     }</span><br><span>@@ -4238,20 +4260,13 @@</span><=
br><span> #ifdef _WIN32</span><br><span>         msg(M_INFO, &quot;NOTE: --=
fast-io is disabled since we are running on Windows&quot;);</span><br><span=
> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!p=
roto_is_udp(c-&gt;options.ce.proto))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (c-&gt;options.shaper)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_I=
NFO, &quot;NOTE: --fast-io is disabled since we are not using UDP&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INF=
O, &quot;NOTE: --fast-io is disabled since we are using --shaper&quot;);</s=
pan><br><span>         }</span><br><span>         else</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if =
(c-&gt;options.shaper)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         msg(M_INFO, &quot;NOTE: --fast-io is disabled since we are using -=
-shaper&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c2.fa=
st_io =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
c-&gt;c2.fast_io =3D true;</span><br><span>         }</span><br><span> #end=
if</span><br><span>     }</span><br><span>@@ -4658,7 +4673,7 @@</span><br><=
span>     }</span><br><span> </span><br><span>     /* our wait-for-i/o obje=
cts, different for posix vs. win32 */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (c-&gt;mode =3D=3D CM_P2P)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_P2P || c-&gt;mod=
e =3D=3D CM_TOP)</span><br><span>     {</span><br><span>         do_event_s=
et_init(c, SHAPER_DEFINED(&amp;c-&gt;options));</span><br><span>     }</spa=
n><br><span>@@ -4925,7 +4940,7 @@</span><br><span>     CLEAR(*dest);</span>=
<br><span> </span><br><span>     /* proto_is_dgram will ASSERT(0) if proto =
is invalid */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dest=
-&gt;mode =3D proto_is_dgram(src-&gt;options.ce.proto) ? CM_CHILD_UDP : CM_=
CHILD_TCP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dest-=
&gt;mode =3D proto_is_dgram(ls-&gt;info.proto) ? CM_CHILD_UDP : CM_CHILD_TC=
P;</span><br><span> </span><br><span>     dest-&gt;gc =3D gc_new();</span><=
br><span> </span><br><span>@@ -4951,8 +4966,11 @@</span><br><span> </span><=
br><span>     /* options */</span><br><span>     dest-&gt;options =3D src-&=
gt;options;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dest=
-&gt;options.ce.proto =3D ls-&gt;info.proto;</span><br><span>     options_d=
etach(&amp;dest-&gt;options);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    dest-&gt;c2.event_set =3D src-&gt;c2.event_=
set;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     if (dest-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span>     {</span>=
<br><span>         /*</span><br><span>@@ -5044,10 +5062,7 @@</span><br><spa=
n>     dest-&gt;c2.es_owned =3D false;</span><br><span> </span><br><span>  =
   dest-&gt;c2.event_set =3D NULL;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (proto_is_dgram(src-&gt;options.ce.proto))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        do_event_set_init(dest, false);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    do_event_set_init(dest, false);</span><br>=
<span> </span><br><span> #ifdef USE_COMP</span><br><span>     dest-&gt;c2.c=
omp_context =3D NULL;</span><br><span>diff --git a/src/openvpn/mroute.c b/s=
rc/openvpn/mroute.c</span><br><span>index 74923cf..5e37799 100644</span><br=
><span>--- a/src/openvpn/mroute.c</span><br><span>+++ b/src/openvpn/mroute.=
c</span><br><span>@@ -421,6 +421,7 @@</span><br><span>                 {</s=
pan><br><span>                     buf_printf(&amp;out, &quot;:%d&quot;, nt=
ohs(maddr.v4.port));</span><br><span>                 }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                buf_printf(&amp;out, &q=
uot;:%d&quot;, maddr.proto);</span><br><span>             }</span><br><span=
>             break;</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/mroute.h b/src/openvpn/mroute.h</span><br><span>index 1c44b35..2659695=
 100644</span><br><span>--- a/src/openvpn/mroute.h</span><br><span>+++ b/sr=
c/openvpn/mroute.h</span><br><span>@@ -210,6 +210,10 @@</span><br><span>   =
  {</span><br><span>         return false;</span><br><span>     }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (a1-&gt;proto !=3D a2-=
&gt;proto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
>     if (a1-&gt;netbits !=3D a2-&gt;netbits)</span><br><span>     {</span>=
<br><span>         return false;</span><br><span>diff --git a/src/openvpn/m=
tcp.c b/src/openvpn/mtcp.c</span><br><span>index 62ed044..582e9b3 100644</s=
pan><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mt=
cp.c</span><br><span>@@ -54,7 +54,7 @@</span><br><span>     struct hash *ha=
sh =3D m-&gt;hash;</span><br><span> </span><br><span>     mi =3D multi_crea=
te_instance(m, NULL, ls);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (mi &amp;&amp; !proto_is_dgram(ls-&gt;info.proto))</span><br><span>     =
{</span><br><span>         mi-&gt;real.proto =3D ls-&gt;info.proto;</span><=
br><span>         struct hash_element *he;</span><br><span>@@ -153,12 +153,=
19 @@</span><br><span> {</span><br><span>     if (mi)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;socke=
t_set_called =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        socket_set(mi-&gt;context.c2.link_sockets[0],</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                   m-&gt;multi_io-&gt;es,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   mbu=
f_defined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                   &amp;mi-&g=
t;ev_arg,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
       &amp;mi-&gt;tcp_rwflags);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&=
gt;info.proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;socket_set_called =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            so=
cket_set(mi-&gt;context.c2.link_sockets[0],</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                       m-&gt;multi_io-&gt;es,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                       mb=
uf_defined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                       &am=
p;mi-&gt;ev_arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                    &amp;mi-&gt;tcp_rwflags);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span>@@ -229,87 +236,3 @@</span><br><span> =
    }</span><br><span>     return ret;</span><br><span> }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * T=
op level event loop for single-threaded operation.</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * TCP mode.</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tunnel_server_t=
cp(struct context *top)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_c=
ontext multi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    top-&gt;mode =3D CM_TOP;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    context_clear_2(top);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* initialize top-tunnel instance */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_instance_handle=
_signals(top, top-&gt;es, CC_HARD_USR1_TO_HUP);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (IS_SIG(top))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* initialize global multi_con=
text object */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mul=
ti_init(&amp;multi, top, true);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* init=
ialize our cloned top object */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    multi_top_init(&amp;multi, top);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* initialize management interface */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    init_management_callback_multi(&amp;multi);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* finished with initialization */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    initialization_sequence_c=
ompleted(top, ISC_SERVER); /* --mode server --proto tcp-server */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    multi.top.c2.inotify_fd =3D inotify_init();</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (multi.top.c2.in=
otify_fd &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_E=
RRORS | M_ERRNO, &quot;MULTI: inotify_init error&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* per-packet=
 event loop */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    whi=
le (true)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_push(PERF_EVENT=
_LOOP);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* wait on tun/socket list =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_get_t=
imeout(&amp;multi, &amp;multi.top.c2.timeval);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        status =3D multi_io_wait(&amp;multi);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        MULTI_CHECK_SIG(&a=
mp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        /* check on status of co=
arse timers */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 multi_process_per_second_timers(&amp;multi);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        /* timeout? */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (status &gt; 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         /* process the I/O which triggered select */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            multi_io_process_io(&amp;multi)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MULTI_CH=
ECK_SIG(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else =
if (status =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
ulti_io_action(&amp;multi, NULL, TA_TIMEOUT, false);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       perf_pop();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    close(top-&gt;c2.inotify_fd);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* shut down management interface */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    uninit_management_callback();</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* save ifconfig-pool */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    multi_ifconfig_pool_persist(&amp;multi,=
 true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* tear down tunnel instance (u=
nless --persist-tun) */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    multi_uninit(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    multi_top_free(&amp;multi);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    close_instance(top);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span>diff --git a/src/openvpn/mtcp.h b/=
src/openvpn/mtcp.h</span><br><span>index 0da0a7d..0a5b045 100644</span><br>=
<span>--- a/src/openvpn/mtcp.h</span><br><span>+++ b/src/openvpn/mtcp.h</sp=
an><br><span>@@ -50,17 +50,6 @@</span><br><span> </span><br><span> void mul=
ti_tcp_link_out_deferred(struct multi_context *m, struct multi_instance *mi=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*********************=
*****************************************************/</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * Main event loop for OpenVPN in TCP server mode.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @ingroup eventloop</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @param top - Top-level context structure.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void tunnel_server_tcp(struct context *top)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void multi_tcp_delete_e=
vent(struct multi_io *multi_io, event_t event);</span><br><span> </span><br=
><span> #endif /* ifndef MTCP_H */</span><br><span>diff --git a/src/openvpn=
/mudp.c b/src/openvpn/mudp.c</span><br><span>index 4f2bbd7..86e1713 100644<=
/span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/=
mudp.c</span><br><span>@@ -193,6 +193,7 @@</span><br><span>     struct mult=
i_instance *mi =3D NULL;</span><br><span>     struct hash *hash =3D m-&gt;h=
ash;</span><br><span>     real.proto =3D ls-&gt;info.proto;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;hmac_reply_ls =3D ls;</sp=
an><br><span> </span><br><span>     if (mroute_extract_openvpn_sockaddr(&am=
p;real, &amp;m-&gt;top.c2.from.dest, true)</span><br><span>         &amp;&a=
mp; m-&gt;top.c2.buf.len &gt; 0)</span><br><span>@@ -319,7 +320,8 @@</span>=
<br><span>         msg_set_prefix(&quot;Connection Attempt&quot;);</span><b=
r><span>         m-&gt;top.c2.to_link =3D m-&gt;hmac_reply;</span><br><span=
>         m-&gt;top.c2.to_link_addr =3D m-&gt;hmac_reply_dest;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        process_outgoing_link(&amp=
;m-&gt;top, m-&gt;top.c2.link_sockets[0]);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        process_outgoing_link(&amp;m-&gt;top, m-&gt;=
hmac_reply_ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    m-&gt;hmac_reply_ls =3D NULL;</span><br><span>         m-&gt;hmac_reply=
_dest =3D NULL;</span><br><span>     }</span><br><span> }</span><br><span>@=
@ -327,10 +329,10 @@</span><br><span> /*</span><br><span>  * Process an I/O=
 event.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid</span><br><span> multi_process_io_udp(struct multi_context *m, struct l=
ink_socket *sock)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const unsigned int status =3D m-&gt;top.c2.event_set_sta=
tus;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsig=
ned int status =3D m-&gt;multi_io-&gt;udp_flags;</span><br><span>     const=
 unsigned int mpp_flags =3D m-&gt;top.c2.fast_io</span><br><span>          =
                          ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOSE_ON_SIGN=
AL)</span><br><span>                                    : (MPP_PRE_SELECT |=
 MPP_CLOSE_ON_SIGNAL);</span><br><span>@@ -423,7 +425,7 @@</span><br><span>=
  * Return the io_wait() flags appropriate for</span><br><span>  * a point-=
to-multipoint tunnel.</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static inline unsigned int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+unsigned int</span><br><span> p2mp_iow_flags(co=
nst struct multi_context *m)</span><br><span> {</span><br><span>     unsign=
ed int flags =3D IOW_WAIT_SIGNAL;</span><br><span>@@ -458,87 +460,3 @@</spa=
n><br><span> #endif</span><br><span>     return flags;</span><br><span> }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tunnel=
_server_udp(struct context *top)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t multi_context multi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    top-&gt;mode =3D=
 CM_TOP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    context_c=
lear_2(top);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /* initialize top-tunnel i=
nstance */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_in=
stance_handle_signals(top, top-&gt;es, CC_HARD_USR1_TO_HUP);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (IS_SIG(top))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* initialize glo=
bal multi_context object */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    multi_init(&amp;multi, top, false);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* initialize our cloned top object */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    multi_top_init(&amp;multi, top);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* initialize management interface */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    init_management_callback_multi(&a=
mp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* finished with initializat=
ion */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    initializat=
ion_sequence_completed(top, ISC_SERVER); /* --mode server --proto udp */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    multi.top.c2.inotify_fd =3D inotify_=
init();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (multi.=
top.c2.inotify_fd &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
D_MULTI_ERRORS | M_ERRNO, &quot;MULTI: inotify_init error&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* p=
er-packet event loop */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    while (true)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_push(P=
ERF_EVENT_LOOP);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* set up and do t=
he io_wait() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  multi_get_timeout(&amp;multi, &amp;multi.top.c2.timeval);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        io_wait(&amp;multi.top, p2mp_=
iow_flags(&amp;multi));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        MULTI_CHECK_SIG(&amp;multi);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* check on status of coarse timers */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        multi_process_per_second_timers(&amp;multi);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* timeout? */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (multi.top.c2.event_set_status =
=3D=3D ES_TIMEOUT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mul=
ti_process_timeout(&amp;multi, MPP_PRE_SELECT|MPP_CLOSE_ON_SIGNAL);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            /* process I/O */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            /* Since there&#39;s only one link_socket just use the first, i=
n an upcoming</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
     * patch this will be changed by using the link_socket returned by the<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * event s=
et */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mult=
i_process_io_udp(&amp;multi, top-&gt;c2.link_sockets[0]);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            MULTI_CHECK_SIG(&amp;multi)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        perf_pop();</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASY=
NC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    close(top-=
&gt;c2.inotify_fd);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* shut down management interface =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uninit_manageme=
nt_callback();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* save ifconfig-pool */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_ifconfig_po=
ol_persist(&amp;multi, true);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tear d=
own tunnel instance (unless --persist-tun) */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    multi_uninit(&amp;multi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    multi_top_free(&amp;multi);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    close_instance(top);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --git a=
/src/openvpn/mudp.h b/src/openvpn/mudp.h</span><br><span>index b378754..357=
b684 100644</span><br><span>--- a/src/openvpn/mudp.h</span><br><span>+++ b/=
src/openvpn/mudp.h</span><br><span>@@ -31,18 +31,9 @@</span><br><span> stru=
ct context;</span><br><span> struct multi_context;</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int p2mp_iow_flag=
s(const struct multi_context *m);</span><br><span> </span><br><span style=
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
(struct multi_context *m, struct link_socket *ls);</span><br><span> /******=
********************************************************************/</span=
><br><span> /**</span><br><span>  * Get, and if necessary create, the multi=
_instance associated with a</span><br><span>diff --git a/src/openvpn/multi.=
c b/src/openvpn/multi.c</span><br><span>index 63c5a83..809fde5 100644</span=
><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/mult=
i.c</span><br><span>@@ -289,7 +289,7 @@</span><br><span>  * Main initializa=
tion function, init multi_context object.</span><br><span>  */</span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_init(s=
truct multi_context *m, struct context *t, bool tcp_mode)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+multi_init(struct multi_context *m, s=
truct context *t)</span><br><span> {</span><br><span>     int dev =3D DEV_T=
YPE_UNDEF;</span><br><span> </span><br><span>@@ -435,13 +435,12 @@</span><b=
r><span> </span><br><span>     m-&gt;instances =3D calloc(m-&gt;max_clients=
, sizeof(struct multi_instance *));</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    m-&gt;top.c2.event_set =3D t-&gt;c2.e=
vent_set;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
Initialize multi-socket TCP I/O wait object</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * Initialize multi-socket I/O wait object</spa=
n><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (tcp_mode)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m-&gt;multi_i=
o =3D multi_io_init(t-&gt;options.max_clients, &amp;m-&gt;max_clients);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    m-&gt;multi_io =3D multi_io_init(t-=
&gt;options.max_clients, &amp;m-&gt;max_clients);</span><br><span>     m-&g=
t;tcp_queue_limit =3D t-&gt;options.tcp_queue_limit;</span><br><span> </spa=
n><br><span>     /*</span><br><span>@@ -607,6 +606,7 @@</span><br><span> </=
span><br><span>     ASSERT(!mi-&gt;halt);</span><br><span>     mi-&gt;halt =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool i=
s_dgram =3D proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto=
);</span><br><span> </span><br><span>     dmsg(D_MULTI_DEBUG, &quot;MULTI: =
multi_close_instance called&quot;);</span><br><span> </span><br><span>@@ -6=
65,7 +665,7 @@</span><br><span>             mi-&gt;did_iroutes =3D false;</=
span><br><span>         }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (m-&gt;multi_io)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (!is_dgram)</span><br><span>      =
   {</span><br><span>             multi_tcp_dereference_instance(m-&gt;mult=
i_io, mi);</span><br><span>         }</span><br><span>@@ -794,6 +794,7 @@</=
span><br><span>         {</span><br><span>             goto err;</span><br>=
<span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     mi-&gt;real.proto =3D ls-&gt;info.proto;</span><br><span>         gene=
rate_prefix(mi);</span><br><span>     }</span><br><span> </span><br><span>@=
@ -3389,7 +3390,7 @@</span><br><span>             /* decrypt in instance co=
ntext */</span><br><span> </span><br><span>             perf_push(PERF_PROC=
_IN_LINK);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 lsi =3D get_link_socket_info(c);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            lsi =3D &amp;ls-&gt;info;</span><br><span>       =
      orig_buf =3D c-&gt;c2.buf.data;</span><br><span>             if (proc=
ess_incoming_link_part1(c, lsi, floated))</span><br><span>             {</s=
pan><br><span>@@ -3837,7 +3838,7 @@</span><br><span>     while ((he =3D has=
h_iterator_next(&amp;hi)))</span><br><span>     {</span><br><span>         =
struct multi_instance *mi =3D (struct multi_instance *) he-&gt;value;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!mi-&gt;halt)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!mi-&gt;h=
alt &amp;&amp; proto_is_dgram(mi-&gt;context.options.ce.proto))</span><br><=
span>         {</span><br><span>             send_control_channel_string(&a=
mp;mi-&gt;context, next_server ? &quot;RESTART,[N]&quot; : &quot;RESTART&qu=
ot;, D_PUSH);</span><br><span>             multi_schedule_context_wakeup(m,=
 mi);</span><br><span>@@ -3875,13 +3876,15 @@</span><br><span>         stat=
us_close(so);</span><br><span>         return false;</span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (proto_is=
_dgram(m-&gt;top.options.ce.proto)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-             &amp;&amp; is_exit_restart(m-&gt;top.sig-&gt;sign=
al_received)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
    &amp;&amp; (m-&gt;deferred_shutdown_signal.signal_received =3D=3D 0)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-             &amp;&amp; =
m-&gt;top.options.ce.explicit_exit_notification !=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (has_udp_in_local_list(&amp=
;m-&gt;top.options))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        multi_push_restart_schedule_exit(m, m-&gt;top=
.options.ce.explicit_exit_notification =3D=3D 2);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (is_exit_restart(m-&gt;top.sig-&gt=
;signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &amp;&amp; (m-&gt;deferred_shutdown_signal.signal_received =3D=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp=
;&amp; m-&gt;top.options.ce.explicit_exit_notification !=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            multi_push_restart_schedule_e=
xit(m, m-&gt;top.options.ce.explicit_exit_notification =3D=3D 2);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an>     }</span><br><span>     return true;</span><br><span> }</span><br><s=
pan>@@ -4154,6 +4157,98 @@</span><br><span>     ASSERT(mi-&gt;context.c2.tl=
s_multi-&gt;peer_id &lt; m-&gt;max_clients);</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/************=
**************************************************************/</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Main event loop for OpenVPN in multi-protoco=
l server mode.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @i=
ngroup eventloop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param top - Top-=
level context structure.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+tunnel_server_loop(struct =
multi_context *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int status;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    while (true)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        perf_push(PERF_EVENT_LOOP);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* wait on tun/socket list */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        multi_get_timeout(multi, &amp;mu=
lti-&gt;top.c2.timeval);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        status =3D multi_io_wait(multi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        MULTI_CHECK_SIG(multi);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* check on status of coarse timers */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        multi_process_per_sec=
ond_timers(multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* timeout? =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (statu=
s &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* proce=
ss the I/O which triggered select */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            multi_io_process_io(multi);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            MULTI_CHECK_SIG(multi);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else if (status =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            multi_io_action(=
multi, NULL, TA_TIMEOUT, false);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        perf_pop=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tunnel_=
server_init(struct context *top)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct multi_context multi;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    top-&gt;=
mode =3D CM_TOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 context_clear_2(top);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* initializ=
e top-tunnel instance */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    init_instance_handle_signals(top, top-&gt;es, CC_HARD_USR1_TO_HUP)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (IS_SIG(top=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* initialize global multi_context object */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    multi_init(&amp;multi, top);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* initialize our cloned top object */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_top_init(&am=
p;multi, top);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* initialize manage=
ment interface */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  init_management_callback_multi(&amp;multi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* finished with initialization */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    initialization_sequence_completed(top, ISC_SE=
RVER); /* --mode server --proto tcp-server */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    multi.top.c2.inotify_fd =3D inotify_init();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (multi.top.c2.inotify_fd &lt=
; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS | =
M_ERRNO, &quot;MULTI: inotify_init error&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tunnel_server=
_loop(&amp;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #ifdef ENABLE_AS=
YNC_PUSH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    close(t=
op-&gt;c2.inotify_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* shut down management i=
nterface */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unin=
it_management_callback();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* save i=
fconfig-pool */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
multi_ifconfig_pool_persist(&amp;multi, true);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* tear down tunnel instance (unless --persist-tun) */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    multi_uninit(&amp;multi)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_top_free=
(&amp;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cl=
ose_instance(top);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span> </span><br><span> /*</span><br><span>  * Top level event =
loop.</span><br><span>@@ -4163,12 +4258,6 @@</span><br><span> {</span><br><=
span>     ASSERT(top-&gt;options.mode =3D=3D MODE_SERVER);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (proto_is_dgr=
am(top-&gt;options.ce.proto))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
tunnel_server_udp(top);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        tunnel_server_tcp(top);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tunnel_server_init(top);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> }</span><br><span>di=
ff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>index =
eacfb52..092aed6 100644</span><br><span>--- a/src/openvpn/multi.h</span><br=
><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -204,6 +204,7 @@</span>=
<br><span> </span><br><span>     struct buffer hmac_reply;</span><br><span>=
     struct link_socket_actual *hmac_reply_dest;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct link_socket *hmac_reply_ls;</span><=
br><span> </span><br><span>     /*</span><br><span>      * Timer object for=
 stale route check</span><br><span>@@ -251,10 +252,8 @@</span><br><span>  *=
 Main event loop for OpenVPN in server mode.</span><br><span>  * @ingroup e=
ventloop</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * This function calls the appropriate main event loop function depe=
nding</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * on the transp=
ort protocol used:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 - \c tunnel_server_udp()</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *  - \c tunnel_server_tcp()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * This function calls the main event loop function</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * on the transport protocols:=
</span><br><span>  *</span><br><span>  * @param top          - Top-level co=
ntext structure.</span><br><span>  */</span><br><span>@@ -267,7 +266,7 @@</=
span><br><span>  * Called by mtcp.c, mudp.c, or other (to be written) proto=
col drivers</span><br><span>  */</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-void multi_init(struct multi_context *m, struc=
t context *t, bool tcp_mode);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void multi_init(struct multi_context *m, struct context *t);</spa=
n><br><span> </span><br><span> void multi_uninit(struct multi_context *m);<=
/span><br><span> </span><br><span>@@ -663,9 +662,12 @@</span><br><span> mul=
ti_process_outgoing_tun(struct multi_context *m, const unsigned int mpp_fla=
gs)</span><br><span> {</span><br><span>     struct multi_instance *mi =3D m=
-&gt;pending;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>   =
  bool ret =3D true;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ASSERT(mi);</span><br><span> #ifdef MULTI_DEBUG_EVENT_=
LOOP</span><br><span>     printf(&quot;%s -&gt; TUN len=3D%d\n&quot;,</span=
><br><span>            id(mi),</span><br><span>diff --git a/src/openvpn/mul=
ti_io.c b/src/openvpn/multi_io.c</span><br><span>index e4174dd..9e012e0 100=
644</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/=
openvpn/multi_io.c</span><br><span>@@ -155,6 +155,11 @@</span><br><span>   =
                                   &amp;m-&gt;top.c2.link_sockets[i]-&gt;ev=
_arg);</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (has_udp_in_local_list(&amp;m-&gt;top.op=
tions))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        get_io_flags_udp(&=
amp;m-&gt;top, m-&gt;multi_io, p2mp_iow_flags(m));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><br><span>     if (t=
untap_is_wintun(m-&gt;top.c1.tuntap))</span><br><span>     {</span><br><spa=
n>@@ -442,14 +447,13 @@</span><br><span>                     }</span><br><s=
pan>                     break;</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                /* new incoming TCP client atte=
mpting to connect? */</span><br><span>                 case EVENT_ARG_LINK_=
SOCKET:</span><br><span>                     if (!ev_arg-&gt;u.sock)</span>=
<br><span>                     {</span><br><span>                         m=
sg(D_MULTI_ERRORS, &quot;MULTI IO: multi_io_proc_io: null socket&quot;);</s=
pan><br><span>                         break;</span><br><span>             =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    /* new inco=
ming TCP client attempting to connect? */</span><br><span>                 =
    if (!proto_is_dgram(ev_arg-&gt;u.sock-&gt;info.proto))</span><br><span>=
                     {</span><br><span>                         socket_rese=
t_listen_persistent(ev_arg-&gt;u.sock);</span><br><span>@@ -460,6 +464,11 @=
@</span><br><span>                         }</span><br><span>              =
           break;</span><br><span>                     }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        multi_p=
rocess_io_udp(m, ev_arg-&gt;u.sock);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        break;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    }</span><br><span>         =
    }</span><br><span>         }</span><br><span>         else</span><br><s=
pan>diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h</span><br><s=
pan>index df43bba..581d248 100644</span><br><span>--- a/src/openvpn/openvpn=
.h</span><br><span>+++ b/src/openvpn/openvpn.h</span><br><span>@@ -216,8 +2=
16,8 @@</span><br><span>  * \c SIGUSR1 restarts.</span><br><span>  *</span>=
<br><span>  * This structure is initialized at the top of the \c</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * tunnel_point_to_point(), \c t=
unnel_server_udp(), and \c</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * tunnel_server_tcp() functions.  In other words, it is reset for eve=
ry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * tunnel_point_t=
o_point(), \c tunnel_server() \c</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * functions.  In other words, it is reset for every</span><br=
><span>  * iteration of the \c main() function&#39;s inner \c SIGUSR1 loop.=
</span><br><span>  */</span><br><span> struct context_2</span><br><span>dif=
f --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>ind=
ex c938999..58e8c14 100644</span><br><span>--- a/src/openvpn/options.c</spa=
n><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -997,10 +997,6 @=
@</span><br><span>                         const struct connection_entry *e=
,</span><br><span>                         const int i)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i(es, &=
quot;proto&quot;, proto2ascii(e-&gt;proto, e-&gt;af, false), i);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* expected to be for single=
 socket contexts only */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    setenv_str_i(es, &quot;local&quot;, e-&gt;local_list-&gt;array[0]-&g=
t;local, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    seten=
v_str_i(es, &quot;local_port&quot;, e-&gt;local_list-&gt;array[0]-&gt;port,=
 i);</span><br><span>     setenv_str_i(es, &quot;remote&quot;, e-&gt;remote=
, i);</span><br><span>     setenv_str_i(es, &quot;remote_port&quot;, e-&gt;=
remote_port, i);</span><br><span> </span><br><span>@@ -1016,6 +1012,16 @@</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+setenv_local_entry(struct env_set *es,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                   const =
struct local_entry *e,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                   const int i)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 setenv_str_i(es, &quot;proto&quot;, proto2ascii(e-&gt;proto, AF_UNSPEC, fa=
lse), i+1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sete=
nv_str_i(es, &quot;local&quot;, e-&gt;local, i+1);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    setenv_str_i(es, &quot;local_port&quot;,=
 e-&gt;port, i+1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> v=
oid</span><br><span> setenv_settings(struct env_set *es, const struct optio=
ns *o)</span><br><span> {</span><br><span>@@ -1039,6 +1045,14 @@</span><br>=
<span>         setenv_connection_entry(es, &amp;o-&gt;ce, 1);</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (o-&gt;ce.local_list)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        for (int i =3D 0; i &lt; o-&gt;ce.local_list-&gt;len; i++)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            setenv_local_entry(es, =
o-&gt;ce.local_list-&gt;array[i], i+1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     if (!o-&gt;pull)</span><br><span>     {</span><br><span> =
        setenv_dns_options(&amp;o-&gt;dns_options, es);</span><br><span>@@ =
-2203,6 +2217,7 @@</span><br><span>     }</span><br><span> </span><br><span=
>     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    e-&gt;proto =3D PROTO_NONE;</span><br=
><span>     l-&gt;array[l-&gt;len++] =3D e;</span><br><span> </span><br><sp=
an>     return e;</span><br><span>@@ -2469,7 +2484,7 @@</span><br><span>   =
  {</span><br><span>         struct local_entry *le =3D ce-&gt;local_list-&=
gt;array[i];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (proto_is_net(ce-&gt;proto)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (proto_is_net(le-&gt;proto)</span><b=
r><span>             &amp;&amp; string_defined_equal(le-&gt;local, ce-&gt;r=
emote)</span><br><span>             &amp;&amp; string_defined_equal(le-&gt;=
port, ce-&gt;remote_port))</span><br><span>         {</span><br><span>@@ -3=
174,14 +3189,30 @@</span><br><span>         if (ce-&gt;proto =3D=3D PROTO_T=
CP)</span><br><span>         {</span><br><span>             ce-&gt;proto =
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
<span>@@ -3330,6 +3361,11 @@</span><br><span>     {</span><br><span>       =
  le-&gt;port =3D ce.local_port;</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!le-&gt;proto)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        le-&gt;proto =3D ce.proto;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> }</span><br><span> </span><br><=
span> #ifdef _WIN32</span><br><span>@@ -3787,6 +3823,7 @@</span><br><span> =
        struct local_entry *e =3D alloc_local_entry(&amp;o-&gt;ce, M_USAGE,=
 &amp;o-&gt;gc);</span><br><span>         ASSERT(e);</span><br><span>      =
   e-&gt;port =3D o-&gt;ce.local_port;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        e-&gt;proto =3D o-&gt;ce.proto;</span><br><span>=
     }</span><br><span> </span><br><span>     /* use the same listen list f=
or every outgoing connection */</span><br><span>@@ -3795,6 +3832,12 @@</spa=
n><br><span>         o-&gt;connection_list-&gt;array[i]-&gt;local_list =3D =
o-&gt;ce.local_list;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (has_tcp_in_local_list(o))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;fast_io =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, =
&quot;NOTE: --fast-io is disabled while using multi-socket&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (o-&gt;tls_serve=
r)</span><br><span>     {</span><br><span>         /* Check that DH file is=
 specified, or explicitly disabled */</span><br><span>@@ -6190,7 +6233,7 @@=
</span><br><span>         VERIFY_PERMISSION(OPT_P_UP);</span><br><span>    =
     options-&gt;ifconfig_nowarn =3D true;</span><br><span>     }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;=
local&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;local&quot;) &amp=
;&amp; p[1] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>      =
   struct local_entry *e;</span><br><span> </span><br><span>@@ -6211,6 +625=
4,11 @@</span><br><span>         {</span><br><span>             e-&gt;port =
=3D p[2];</span><br><span>         }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e-=
&gt;proto =3D ascii2proto(p[3]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span>     }</span><br><span>     else if =
(streq(p[0], &quot;remote-random&quot;) &amp;&amp; !p[1])</span><br><span> =
    {</span><br><span>@@ -9645,3 +9693,37 @@</span><br><span> err:</span><b=
r><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+has_=
udp_in_local_list(const struct options *options)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (options-&gt;ce.local_list)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        for (int i =3D 0; i &lt; options-&gt;ce.local_list-&gt;=
len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (prot=
o_is_dgram(options-&gt;ce.local_list-&gt;array[i]-&gt;proto))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                return true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+has_tcp_in_local_list(const struct options *options)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;ce.local_list)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; options=
-&gt;ce.local_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (!proto_is_dgram(options-&gt;ce.local_list-&gt;array[i]-&=
gt;proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/options.h b/sr=
c/openvpn/options.h</span><br><span>index 3f4cb90..161899a 100644</span><br=
><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/option=
s.h</span><br><span>@@ -98,6 +98,7 @@</span><br><span> {</span><br><span>  =
   const char *local;</span><br><span>     const char *port;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int proto;</span><br><span> };=
</span><br><span> </span><br><span> struct connection_entry</span><br><span=
>@@ -917,6 +918,10 @@</span><br><span> </span><br><span> bool key_is_extern=
al(const struct options *options);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool has_udp_in_local_list(const struct o=
ptions *options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool has_tcp_in_local=
_list(const struct options *options);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Returns whether=
 the current configuration has dco enabled.</span><br><span>  */</span><br>=
<span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><s=
pan>index 97dce02..ba0891a 100644</span><br><span>--- a/src/openvpn/socket.=
c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -1888,11 +1=
888,33 @@</span><br><span>     struct options *o =3D &amp;c-&gt;options;</s=
pan><br><span>     ASSERT(sock);</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *host =3D o-&gt;ce.local_list=
-&gt;array[sock_index]-&gt;local;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *port =3D o-&gt;ce.local_list-&gt;array[sock_i=
ndex]-&gt;port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int proto =3D o-&gt;ce.local_list-&gt;array[sock_index]-&gt;proto;</span><b=
r><span>     const char *remote_host =3D o-&gt;ce.remote;</span><br><span> =
    const char *remote_port =3D o-&gt;ce.remote_port;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;local_host =
=3D o-&gt;ce.local_list-&gt;array[sock_index]-&gt;local;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;local_port =3D o-&gt;ce.loc=
al_list-&gt;array[sock_index]-&gt;port;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_CHILD_TCP || c-&gt;mode =
=3D=3D CM_CHILD_UDP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t link_socket *tmp_sock =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            tmp_sock =3D (struct link_socket *)=
c-&gt;c2.accept_from;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else if (c-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            tmp_sock =3D c-&gt;c2.link_sockets[0];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        host =3D tmp_sock-&gt;local_host;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        port =3D tmp_sock-&gt;local_po=
rt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        proto =
=3D tmp_sock-&gt;info.proto;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(c-&gt;c2.link=
_sockets[sock_index]);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;loc=
al_host =3D host;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  sock-&gt;local_port =3D port;</span><br><span>     sock-&gt;remote_host =
=3D remote_host;</span><br><span>     sock-&gt;remote_port =3D remote_port;=
</span><br><span>     sock-&gt;dns_cache =3D c-&gt;c1.dns_cache;</span><br>=
<span>@@ -1920,7 +1942,7 @@</span><br><span> </span><br><span>     sock-&gt=
;mark =3D o-&gt;mark;</span><br><span>     sock-&gt;bind_dev =3D o-&gt;bind=
_dev;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;inf=
o.proto =3D o-&gt;ce.proto;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    sock-&gt;info.proto =3D proto;</span><br><span>     sock-&gt;in=
fo.af =3D o-&gt;ce.af;</span><br><span>     sock-&gt;info.remote_float =3D =
o-&gt;ce.remote_float;</span><br><span>     sock-&gt;info.lsa =3D &amp;c-&g=
t;c1.link_socket_addrs[sock_index];</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demai=
l">change 764</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31bbf87e4e568021445c7512ece=
fadfd4a69b363 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 764 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--42E7jK901Sk=--

