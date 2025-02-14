From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 17:45:13 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <58153fdbcef03ba369177f3a6b6b3bc2d3809ef3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nnJI5fbik1o="; charset=UTF-8
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

--nnJI5fbik1o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, its_Giaan, ordex, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail

to look at the new patch set (#19).

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
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/mudp.c
M src/openvpn/mudp.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/multi_io.c
M src/openvpn/multi_io.h
M src/openvpn/openvpn.h
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/socket.c
M src/openvpn/ssl_common.h
17 files changed, 404 insertions(+), 311 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/764/19

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
index f3f3503..31aeaf3 100644
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
@@ -2057,52 +2057,24 @@
     check_timeout_random_component(c);
 }

-/*
- * Wait for I/O events.  Used for both TCP & UDP sockets
- * in point-to-point mode and for UDP sockets in
- * point-to-multipoint mode.
- */
-
-void
-io_wait_dowork(struct context *c, const unsigned int flags)
+static void
+multi_io_process_flags(struct context *c, struct event_set *es,
+                       const unsigned int flags, unsigned int *out_socket,
+                       unsigned int *out_tuntap)
 {
     unsigned int socket =3D 0;
     unsigned int tuntap =3D 0;
-    struct event_set_return esr[4];
-
-    /* These shifts all depend on EVENT_READ and EVENT_WRITE */
-    static uintptr_t socket_shift =3D SOCKET_SHIFT;   /* depends on SOCKET=
_READ and SOCKET_WRITE */
-    static uintptr_t tun_shift =3D TUN_SHIFT;      /* depends on TUN_READ =
and TUN_WRITE */
-    static uintptr_t err_shift =3D ERR_SHIFT;      /* depends on ES_ERROR =
*/
-#ifdef ENABLE_MANAGEMENT
-    static uintptr_t management_shift =3D MANAGEMENT_SHIFT; /* depends on =
MANAGEMENT_READ and MANAGEMENT_WRITE */
-#endif
-#ifdef ENABLE_ASYNC_PUSH
-    static uintptr_t file_shift =3D FILE_SHIFT;
-#endif
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    static uintptr_t dco_shift =3D DCO_SHIFT;    /* Event from DCO linux k=
ernel module */
-#endif
+    static uintptr_t tun_shift =3D TUN_SHIFT;
+    static uintptr_t err_shift =3D ERR_SHIFT;

     /*
-     * Decide what kind of events we want to wait for.
-     */
-    event_reset(c->c2.event_set);
-
-    /*
-     * On win32 we use the keyboard or an event object as a source
-     * of asynchronous signals.
+     * Calculate the flags based on the provided 'flags' argument.
      */
     if (flags & IOW_WAIT_SIGNAL)
     {
-        wait_signal(c->c2.event_set, (void *)err_shift);
+        wait_signal(es, (void *)err_shift);
     }

-    /*
-     * If outgoing data (for TCP/UDP port) pending, wait for ready-to-send
-     * status from TCP/UDP port. Otherwise, wait for incoming data on
-     * TUN/TAP device.
-     */
     if (flags & IOW_TO_LINK)
     {
         if (flags & IOW_SHAPER)
@@ -2190,12 +2162,120 @@
      */
     for (int i =3D 0; i < c->c1.link_sockets_num; i++)
     {
-        socket_set(c->c2.link_sockets[i], c->c2.event_set, socket,
+        socket_set(c->c2.link_sockets[i], es, socket,
                    &c->c2.link_sockets[i]->ev_arg, NULL);
     }
-    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL=
);
+
+    tun_set(c->c1.tuntap, es, tuntap, (void *)tun_shift, NULL);
+
+    if (out_socket)
+    {
+        *out_socket =3D socket;
+    }
+
+    if (out_tuntap)
+    {
+        *out_tuntap =3D tuntap;
+    }
+
+}
+
+/*
+ * Wait for I/O events.  Used for both TCP & UDP sockets
+ * in point-to-point mode and for UDP sockets in
+ * point-to-multipoint mode.
+ */
+
+void
+get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io, cons=
t unsigned int flags)
+{
+    unsigned int out_socket, out_tuntap;
+
+    multi_io_process_flags(c, multi_io->es, flags, &out_socket, &out_tunta=
p);
+    multi_io->udp_flags =3D out_socket | out_tuntap;
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
+io_wait_dowork(struct context *c, const unsigned int flags)
+{
+    unsigned int out_socket;
+    unsigned int out_tuntap;
+    struct event_set_return esr[4];
+
+    /* These shifts all depend on EVENT_READ and EVENT_WRITE */
+    static uintptr_t socket_shift =3D SOCKET_SHIFT;   /* depends on SOCKET=
_READ and SOCKET_WRITE */
+#ifdef ENABLE_MANAGEMENT
+    static uintptr_t management_shift =3D MANAGEMENT_SHIFT; /* depends on =
MANAGEMENT_READ and MANAGEMENT_WRITE */
+#endif
+#ifdef ENABLE_ASYNC_PUSH
+    static uintptr_t file_shift =3D FILE_SHIFT;
+#endif
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    if (socket & EVENT_READ && c->c2.did_open_tun)
+    static uintptr_t dco_shift =3D DCO_SHIFT;    /* Event from DCO linux k=
ernel module */
+#endif
+
+    /*
+     * Decide what kind of events we want to wait for.
+     */
+    event_reset(c->c2.event_set);
+
+    multi_io_process_flags(c, c->c2.event_set, flags, &out_socket, &out_tu=
ntap);
+
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    if (out_socket & EVENT_READ && c->c2.did_open_tun)
     {
         dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)dco_shi=
ft);
     }
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
index da20241..3b2b75c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -612,6 +612,7 @@
         }

         c->options.ce =3D *ce;
+
 #ifdef ENABLE_MANAGEMENT
         if (ce_defined && management && management_query_remote_enabled(ma=
nagement))
         {
@@ -2681,7 +2682,9 @@

     if (found & OPT_P_EXPLICIT_NOTIFY)
     {
-        if (!proto_is_udp(c->options.ce.proto) && c->options.ce.explicit_e=
xit_notification)
+        /* Client side, so just check the first link_socket */
+        if (!proto_is_udp(c->c2.link_sockets[0]->info.proto)
+            && c->options.ce.explicit_exit_notification)
         {
             msg(D_PUSH, "OPTIONS IMPORT: --explicit-exit-notify can only b=
e used with --proto udp");
             c->options.ce.explicit_exit_notification =3D 0;
@@ -2850,14 +2853,14 @@
     int sec =3D 2;
     int backoff =3D 0;

-    switch (c->options.ce.proto)
+    switch (c->mode)
     {
-        case PROTO_TCP_SERVER:
+        case CM_TOP:
             sec =3D 1;
             break;

-        case PROTO_UDP:
-        case PROTO_TCP_CLIENT:
+        case CM_CHILD_UDP:
+        case CM_CHILD_TCP:
             sec =3D c->options.ce.connect_retry_seconds;
             break;
     }
@@ -2875,7 +2878,7 @@
     }

     /* Slow down reconnection after 5 retries per remote -- for TCP client=
 or UDP tls-client only */
-    if (c->options.ce.proto =3D=3D PROTO_TCP_CLIENT
+    if (c->mode =3D=3D CM_CHILD_TCP
         || (c->options.ce.proto =3D=3D PROTO_UDP && c->options.tls_client))
     {
         backoff =3D (c->options.unsuccessful_attempts / c->options.connect=
ion_list->len) - 4;
@@ -3355,7 +3358,6 @@
     to.server =3D options->tls_server;
     to.replay_window =3D options->replay_window;
     to.replay_time =3D options->replay_time;
-    to.tcp_mode =3D link_socket_proto_connection_oriented(options->ce.prot=
o);
     to.config_ciphername =3D c->options.ciphername;
     to.config_ncp_ciphers =3D c->options.ncp_ciphers;
     to.transition_window =3D options->transition_window;
@@ -3409,7 +3411,7 @@

     /* should we not xmit any packets until we get an initial
      * response from client? */
-    if (to.server && options->ce.proto =3D=3D PROTO_TCP_SERVER)
+    if (to.server && c->mode =3D=3D CM_CHILD_TCP)
     {
         to.xmit_hold =3D true;
     }
@@ -4260,20 +4262,13 @@
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
@@ -4680,7 +4675,7 @@
     }

     /* our wait-for-i/o objects, different for posix vs. win32 */
-    if (c->mode =3D=3D CM_P2P)
+    if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP)
     {
         do_event_set_init(c, SHAPER_DEFINED(&c->options));
     }
@@ -4947,7 +4942,7 @@
     CLEAR(*dest);

     /* proto_is_dgram will ASSERT(0) if proto is invalid */
-    dest->mode =3D proto_is_dgram(src->options.ce.proto) ? CM_CHILD_UDP : =
CM_CHILD_TCP;
+    dest->mode =3D proto_is_dgram(ls->info.proto) ? CM_CHILD_UDP : CM_CHIL=
D_TCP;

     dest->gc =3D gc_new();

@@ -4973,8 +4968,11 @@

     /* options */
     dest->options =3D src->options;
+    dest->options.ce.proto =3D ls->info.proto;
     options_detach(&dest->options);

+    dest->c2.event_set =3D src->c2.event_set;
+
     if (dest->mode =3D=3D CM_CHILD_TCP)
     {
         /*
@@ -5066,10 +5064,7 @@
     dest->c2.es_owned =3D false;

     dest->c2.event_set =3D NULL;
-    if (proto_is_dgram(src->options.ce.proto))
-    {
-        do_event_set_init(dest, false);
-    }
+    do_event_set_init(dest, false);

 #ifdef USE_COMP
     dest->c2.comp_context =3D NULL;
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 9a8b1cb..0d409b6 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -149,20 +149,6 @@
     multi_io->n_esr =3D 0;
 }

-void
-multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instan=
ce *mi)
-{
-    if (mi)
-    {
-        mi->socket_set_called =3D true;
-        socket_set(mi->context.c2.link_sockets[0],
-                   m->multi_io->es,
-                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
-                   &mi->ev_arg,
-                   &mi->tcp_rwflags);
-    }
-}
-
 bool
 multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct mult=
i_instance *mi, const unsigned int mpp_flags)
 {
@@ -230,87 +216,3 @@
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
index 0da0a7d..9de5203 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -40,8 +40,6 @@

 void multi_tcp_instance_specific_free(struct multi_instance *mi);

-void multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_i=
nstance *mi);
-
 bool multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, =
const unsigned int mpp_flags);

 bool multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct=
 multi_instance *mi, const unsigned int mpp_flags);
@@ -50,17 +48,6 @@

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
index 5f43db9..3472fa2 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -195,6 +195,7 @@
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;
     real.proto =3D ls->info.proto;
+    m->hmac_reply_ls =3D ls;

     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
@@ -321,7 +322,8 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link =3D m->hmac_reply;
         m->top.c2.to_link_addr =3D m->hmac_reply_dest;
-        process_outgoing_link(&m->top, m->top.c2.link_sockets[0]);
+        process_outgoing_link(&m->top, m->hmac_reply_ls);
+        m->hmac_reply_ls =3D NULL;
         m->hmac_reply_dest =3D NULL;
     }
 }
@@ -329,10 +331,10 @@
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
@@ -425,7 +427,7 @@
  * Return the io_wait() flags appropriate for
  * a point-to-multipoint tunnel.
  */
-static inline unsigned int
+unsigned int
 p2mp_iow_flags(const struct multi_context *m)
 {
     unsigned int flags =3D IOW_WAIT_SIGNAL;
@@ -460,87 +462,3 @@
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
index f76dad8..0b1f91e 100644
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
=20
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
@@ -3400,7 +3400,7 @@
             /* decrypt in instance context */

             perf_push(PERF_PROC_IN_LINK);
-            lsi =3D get_link_socket_info(c);
+            lsi =3D &ls->info;
             orig_buf =3D c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
@@ -3849,7 +3849,7 @@
     while ((he =3D hash_iterator_next(&hi)))
     {
         struct multi_instance *mi =3D (struct multi_instance *) he->value;
-        if (!mi->halt)
+        if (!mi->halt && proto_is_dgram(mi->context.c2.link_sockets[0]->in=
fo.proto))
         {
             send_control_channel_string(&mi->context, next_server ? "RESTA=
RT,[N]" : "RESTART", D_PUSH);
             multi_schedule_context_wakeup(m, mi);
@@ -3887,7 +3887,7 @@
         status_close(so);
         return false;
     }
-    else if (proto_is_dgram(m->top.options.ce.proto)
+    else if (has_udp_in_local_list(&m->top.options)
              && is_exit_restart(m->top.sig->signal_received)
              && (m->deferred_shutdown_signal.signal_received =3D=3D 0)
              && m->top.options.ce.explicit_exit_notification !=3D 0)
@@ -4168,6 +4168,45 @@
     ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
 }

+/*************************************************************************=
*/
+/**
+ * Main event loop for OpenVPN in point-to-multipoint server mode.
+ * @ingroup eventloop
+ *
+ * @param top - Top-level context structure.
+ */
+static void
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

 /*
  * Top level event loop.
@@ -4177,12 +4216,53 @@
 {
     ASSERT(top->options.mode =3D=3D MODE_SERVER);

-    if (proto_is_dgram(top->options.ce.proto))
+    struct multi_context multi;
+
+    top->mode =3D CM_TOP;
+    context_clear_2(top);
+
+    /* initialize top-tunnel instance */
+    init_instance_handle_signals(top, top->es, CC_HARD_USR1_TO_HUP);
+    if (IS_SIG(top))
     {
-        tunnel_server_udp(top);
+        return;
     }
-    else
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
     {
-        tunnel_server_tcp(top);
+        msg(D_MULTI_ERRORS | M_ERRNO, "MULTI: inotify_init error");
     }
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
+
 }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index eacfb52..5d10237 100644
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

diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index e4174dd..62b8bb2 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -133,6 +133,20 @@
 }

 void
+multi_io_set_global_rw_flags(struct multi_context *m, struct multi_instanc=
e *mi)
+{
+    if (mi)
+    {
+        mi->socket_set_called =3D true;
+        socket_set(mi->context.c2.link_sockets[0],
+                   m->multi_io->es,
+                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
+                   !proto_is_dgram(mi->context.c2.link_sockets[0]->info.pr=
oto) ? &mi->ev_arg : &mi->context.c2.link_sockets[0]->ev_arg,
+                   !proto_is_dgram(mi->context.c2.link_sockets[0]->info.pr=
oto) ? &mi->tcp_rwflags : NULL);
+    }
+}
+
+void
 multi_io_free(struct multi_io *multi_io)
 {
     if (multi_io)
@@ -155,6 +169,11 @@
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
@@ -333,7 +352,7 @@

         case TA_INITIAL:
             ASSERT(mi);
-            multi_tcp_set_global_rw_flags(m, mi);
+            multi_io_set_global_rw_flags(m, mi);
             multi_process_post(m, mi, mpp_flags);
             break;

@@ -383,7 +402,7 @@
             }
             else
             {
-                multi_tcp_set_global_rw_flags(m, mi);
+                multi_io_set_global_rw_flags(m, mi);
             }
             break;

@@ -442,14 +461,13 @@
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
@@ -460,6 +478,19 @@
                         }
                         break;
                     }
+                    else
+                    {
+                        multi_process_io_udp(m, ev_arg->u.sock);
+                        mi =3D m->pending;
+                        /* Mimic TCP and monitor and/or handle events that
+                         * are triggered in succession by the first one
+                         * before returning to the main loop. */
+                        if (mi)
+                        {
+                            multi_io_action(m, mi, TA_INITIAL, false);
+                        }
+                        break;
+                    }
             }
         }
         else
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 03d708c..0887a5e 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -70,6 +70,8 @@

 void multi_io_process_io(struct multi_context *m);

+void multi_io_set_global_rw_flags(struct multi_context *m, struct multi_in=
stance *mi);
+
 void multi_io_action(struct multi_context *m, struct multi_instance *mi, i=
nt action, bool poll);

 void multi_io_delete_event(struct multi_io *multi_io, event_t event);
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
index 3ae44db..a422b88 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -999,10 +999,6 @@
                         const struct connection_entry *e,
                         const int i)
 {
-    setenv_str_i(es, "proto", proto2ascii(e->proto, e->af, false), i);
-    /* expected to be for single socket contexts only */
-    setenv_str_i(es, "local", e->local_list->array[0]->local, i);
-    setenv_str_i(es, "local_port", e->local_list->array[0]->port, i);
     setenv_str_i(es, "remote", e->remote, i);
     setenv_str_i(es, "remote_port", e->remote_port, i);

@@ -1018,6 +1014,16 @@
     }
 }

+static void
+setenv_local_entry(struct env_set *es,
+                   const struct local_entry *e,
+                   const int i)
+{
+    setenv_str_i(es, "proto", proto2ascii(e->proto, AF_UNSPEC, false), i);
+    setenv_str_i(es, "local", e->local, i);
+    setenv_str_i(es, "local_port", e->port, i);
+}
+
 void
 setenv_settings(struct env_set *es, const struct options *o)
 {
@@ -1041,6 +1047,14 @@
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
@@ -2205,6 +2219,7 @@
     }

     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);
+    e->proto =3D PROTO_NONE;
     l->array[l->len++] =3D e;

     return e;
@@ -2471,7 +2486,7 @@
     {
         struct local_entry *le =3D ce->local_list->array[i];

-        if (proto_is_net(ce->proto)
+        if (proto_is_net(le->proto)
             && string_defined_equal(le->local, ce->remote)
             && string_defined_equal(le->port, ce->remote_port))
         {
@@ -3179,11 +3194,12 @@
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

@@ -3332,6 +3348,10 @@
     {
         le->port =3D ce->local_port;
     }
+    if (!le->proto)
+    {
+        le->proto =3D ce->proto;
+    }
 }

 #ifdef _WIN32
@@ -3781,6 +3801,18 @@
         {
             options_postprocess_mutate_le(&o->ce, o->ce.local_list->array[=
i]);
         }
+
+        for (int i =3D 0; i < o->ce.local_list->len; i++)
+        {
+            if (o->ce.local_list->array[i]->proto =3D=3D PROTO_TCP)
+            {
+                o->ce.local_list->array[i]->proto =3D PROTO_TCP_SERVER;
+            }
+            else if (o->ce.local_list->array[i]->proto =3D=3D PROTO_NONE)
+            {
+                o->ce.local_list->array[i]->proto =3D o->ce.proto;
+            }
+        }
     }
     else
     {
@@ -3789,6 +3821,7 @@
         struct local_entry *e =3D alloc_local_entry(&o->ce, M_USAGE, &o->g=
c);
         ASSERT(e);
         e->port =3D o->ce.local_port;
+        e->proto =3D o->ce.proto;
     }

     /* use the same listen list for every outgoing connection */
@@ -3797,6 +3830,12 @@
         o->connection_list->array[i]->local_list =3D o->ce.local_list;
     }

+    if (has_tcp_in_local_list(o))
+    {
+        o->fast_io =3D false;
+        msg(M_INFO, "NOTE: --fast-io is disabled if there is a TCP socket =
active");
+    }
+
     if (o->tls_server)
     {
         /* Check that DH file is specified, or explicitly disabled */
@@ -6191,7 +6230,7 @@
         VERIFY_PERMISSION(OPT_P_UP);
         options->ifconfig_nowarn =3D true;
     }
-    else if (streq(p[0], "local") && p[1] && !p[3])
+    else if (streq(p[0], "local") && p[1] && !p[4])
     {
         struct local_entry *e;

@@ -6212,6 +6251,11 @@
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
@@ -9646,3 +9690,37 @@
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
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 9625a99..6916ad4 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -362,7 +362,6 @@

     int replay_window;                 /* --replay-window parm */
     int replay_time;                   /* --replay-window parm */
-    bool tcp_mode;

     const char *config_ciphername;
     const char *config_ncp_ciphers;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Gerrit-Change-Number: 764
Gerrit-PatchSet: 19
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--nnJI5fbik1o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, its_Giaan, ordex, plaistho=
s. </p>
<p>its_Giaan <strong>uploaded patch set #19</strong> to this change.</p><p>=
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
vpn/mtcp.c<br>M src/openvpn/mtcp.h<br>M src/openvpn/mudp.c<br>M src/openvpn=
/mudp.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/=
multi_io.c<br>M src/openvpn/multi_io.h<br>M src/openvpn/openvpn.h<br>M src/=
openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/socket.c<br>M=
 src/openvpn/ssl_common.h<br>17 files changed, 404 insertions(+), 311 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/64/764/19</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/doc/man-sections/link-options.rst b/doc/=
man-sections/link-options.rst</span><br><span>index 4496da2..d48021e 100644=
</span><br><span>--- a/doc/man-sections/link-options.rst</span><br><span>++=
+ b/doc/man-sections/link-options.rst</span><br><span>@@ -106,7 +106,7 @@</=
span><br><span>   is not reliable. It is recommended to set tun-mtu with en=
ough headroom</span><br><span>   instead.</span><br><span> </span><br><span=
>---local host|* [port]</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+--local host|* [port] [protocol]</span><br><span>   Local host name or =
IP address and port for bind. If specified, OpenVPN will bind</span><br><sp=
an>   to this address. If unspecified, OpenVPN will bind to all interfaces.=
</span><br><span>   &#39;*&#39; can be used as hostname and means &#39;any =
host&#39; (OpenVPN will listen on what</span><br><span>diff --git a/src/ope=
nvpn/forward.c b/src/openvpn/forward.c</span><br><span>index f3f3503..31aea=
f3 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b=
/src/openvpn/forward.c</span><br><span>@@ -1767,7 +1767,7 @@</span><br><spa=
n>             if (c-&gt;options.shaper)</span><br><span>             {</sp=
an><br><span>                 int overhead =3D datagram_overhead(c-&gt;c2.t=
o_link_addr-&gt;dest.addr.sa.sa_family,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                                 c-&gt;op=
tions.ce.proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                              sock-&gt;info.proto);</span><=
br><span>                 shaper_wrote_bytes(&amp;c-&gt;c2.shaper,</span><b=
r><span>                                    BLEN(&amp;c-&gt;c2.to_link) + o=
verhead);</span><br><span>             }</span><br><span>@@ -2057,52 +2057,=
24 @@</span><br><span>     check_timeout_random_component(c);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Wait for I/O e=
vents.  Used for both TCP &amp; UDP sockets</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * in point-to-point mode and for UDP sockets in</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * point-to-multipoint mod=
e.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
io_wait_dowork(struct context *c, const unsigned int flags)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_io_process_flags(struct context *c,=
 struct event_set *es,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                       const unsigned int flags, unsigned int *out_socke=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
      unsigned int *out_tuntap)</span><br><span> {</span><br><span>     uns=
igned int socket =3D 0;</span><br><span>     unsigned int tuntap =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct event_set_retu=
rn esr[4];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* These shifts all depend o=
n EVENT_READ and EVENT_WRITE */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    static uintptr_t socket_shift =3D SOCKET_SHIFT;   /* depends =
on SOCKET_READ and SOCKET_WRITE */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    static uintptr_t tun_shift =3D TUN_SHIFT;      /* depends =
on TUN_READ and TUN_WRITE */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    static uintptr_t err_shift =3D ERR_SHIFT;      /* depends on ES_=
ERROR */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE=
_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static=
 uintptr_t management_shift =3D MANAGEMENT_SHIFT; /* depends on MANAGEMENT_=
READ and MANAGEMENT_WRITE */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef E=
NABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
tatic uintptr_t file_shift =3D FILE_SHIFT;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    static uintptr_t dco_shift =3D DCO=
_SHIFT;    /* Event from DCO linux kernel module */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    static uintptr_t tun_shift =3D TUN_SHIFT;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t err_shift=
 =3D ERR_SHIFT;</span><br><span> </span><br><span>     /*</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-     * Decide what kind of events we wa=
nt to wait for.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    event_reset(c-&g=
t;c2.event_set);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * On win32 we use the keyboard or an=
 event object as a source</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * of asynchronous signals.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * Calculate the flags based on the provided &#39;flags=
&#39; argument.</span><br><span>      */</span><br><span>     if (flags &am=
p; IOW_WAIT_SIGNAL)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        wait_signal(c-&gt;c2.event_set, (void *)err_sh=
ift);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wait_s=
ignal(es, (void *)err_shift);</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * If outgoing data (for TCP/UDP port=
) pending, wait for ready-to-send</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * status from TCP/UDP port. Otherwise, wait for incoming d=
ata on</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * TUN/TAP =
device.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span>=
<br><span>     if (flags &amp; IOW_TO_LINK)</span><br><span>     {</span><b=
r><span>         if (flags &amp; IOW_SHAPER)</span><br><span>@@ -2190,12 +2=
162,120 @@</span><br><span>      */</span><br><span>     for (int i =3D 0; =
i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        socket_set(c-&gt;c2.link_so=
ckets[i], c-&gt;c2.event_set, socket,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        socket_set(c-&gt;c2.link_sockets[i], es, socket,<=
/span><br><span>                    &amp;c-&gt;c2.link_sockets[i]-&gt;ev_ar=
g, NULL);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    tun_set(c-&gt;c1.tuntap, c-&gt;c2.event_set, tuntap, (void *=
)tun_shift, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tun_set(c-&gt;c1=
.tuntap, es, tuntap, (void *)tun_shift, NULL);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (out_socket)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  *out_socket =3D socket;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (out_tuntap)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *out_tuntap =3D tuntap;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Wait for I/O events.  Used for both =
TCP &amp; UDP sockets</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * in point-to-point mode and for UDP sockets in</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * point-to-multipoint mode.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_io_fla=
gs_dowork_udp(struct context *c, struct multi_io *multi_io, const unsigned =
int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int out_socket=
, out_tuntap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io_process_flag=
s(c, multi_io-&gt;es, flags, &amp;out_socket, &amp;out_tuntap);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;udp_flags =3D =
out_socket | out_tuntap;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+get_io_flags_udp(struct context *c, struct mult=
i_io *multi_io, const unsigned int flags)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (c-&gt;c2.fast_io &amp;&amp; (flags &amp; (=
IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* fast path -- only for TUN/TAP/UDP writes */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        unsigned int ret =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp;=
 IOW_TO_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret |=
=3D TUN_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (fla=
gs &amp; (IOW_TO_LINK | IOW_MBUF))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ret |=3D SOCKET_WRITE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        multi_io-&gt;udp_flags =3D ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _W=
IN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool sk=
ip_iowait =3D flags &amp; IOW_TO_TUN;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (flags &amp; IOW_READ_TUN)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+             * don&#39;t read from tun if we have pend=
ing write to link,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
            * since every tun read overwrites to_link buffer filled</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+             * by previous =
tun read</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ski=
p_iowait =3D !(flags &amp; IOW_TO_LINK);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (tuntap_is_wintun(c-&gt;c1.tuntap) &amp;&amp; skip_io=
wait)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            unsigned int=
 ret =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                ret |=3D TUN_WRITE;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (flags &amp; IOW_READ_TUN)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ret |=3D TUN_READ;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            multi_io-&gt;udp_fla=
gs =3D ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef _WIN32 */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            /* slow path - de=
legate to io_wait_dowork_udp to calculate flags */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            get_io_flags_dowork_udp(c, multi=
_io, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+io_wait_=
dowork(struct context *c, const unsigned int flags)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    unsigned int out_socket;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    unsigned int out_tuntap;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct event_set_return esr[4];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* These shifts all depend on EVENT_READ=
 and EVENT_WRITE */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    static uintptr_t socket_shift =3D SOCKET_SHIFT;   /* depends on SOCKET_=
READ and SOCKET_WRITE */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    static uintptr_t management_shift =3D MANAGEMENT_SHIFT; /* de=
pends on MANAGEMENT_READ and MANAGEMENT_WRITE */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    static uintptr_t file_shift =3D FILE_SHIFT;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> #i=
f defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (socket &amp; EVENT_READ &amp;&amp; c-&=
gt;c2.did_open_tun)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    static uintptr_t dco_shift =3D DCO_SHIFT;    /* Event from DCO linux ke=
rnel module */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * Decide what kind of events we want to wait =
for.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    event_reset(c-&gt;c2.ev=
ent_set);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io_process_flags(c,=
 c-&gt;c2.event_set, flags, &amp;out_socket, &amp;out_tuntap);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (out_socket=
 &amp; EVENT_READ &amp;&amp; c-&gt;c2.did_open_tun)</span><br><span>     {<=
/span><br><span>         dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, c-&gt;=
c2.event_set, (void *)dco_shift);</span><br><span>     }</span><br><span>di=
ff --git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>in=
dex 214a322..441bc16 100644</span><br><span>--- a/src/openvpn/forward.h</sp=
an><br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -69,6 +69,10 @@=
</span><br><span> </span><br><span> extern counter_type link_write_bytes_gl=
obal;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_=
io, const unsigned int flags);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void get=
_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned =
int flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> void io_wait_dowork(struct context *c, const unsigned int flags);=
</span><br><span> </span><br><span> void pre_select(struct context *c);</sp=
an><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br=
><span>index da20241..3b2b75c 100644</span><br><span>--- a/src/openvpn/init=
.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -612,6 +612,=
7 @@</span><br><span>         }</span><br><span> </span><br><span>         =
c-&gt;options.ce =3D *ce;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>         i=
f (ce_defined &amp;&amp; management &amp;&amp; management_query_remote_enab=
led(management))</span><br><span>         {</span><br><span>@@ -2681,7 +268=
2,9 @@</span><br><span> </span><br><span>     if (found &amp; OPT_P_EXPLICI=
T_NOTIFY)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!proto_is_udp(c-&gt;options.ce.proto) &amp;&amp; c-&=
gt;options.ce.explicit_exit_notification)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        /* Client side, so just check the first link_=
socket */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!proto_is_udp(c-&gt;c2.link_sockets[0]-&gt;info.proto)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; c-&gt;options.c=
e.explicit_exit_notification)</span><br><span>         {</span><br><span>  =
           msg(D_PUSH, &quot;OPTIONS IMPORT: --explicit-exit-notify can onl=
y be used with --proto udp&quot;);</span><br><span>             c-&gt;optio=
ns.ce.explicit_exit_notification =3D 0;</span><br><span>@@ -2850,14 +2853,1=
4 @@</span><br><span>     int sec =3D 2;</span><br><span>     int backoff =
=3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    switch (c-&gt;options.ce.proto)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    switch (c-&gt;mode)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        case PROTO_TCP_SERVER:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case CM_TOP:=
</span><br><span>             sec =3D 1;</span><br><span>             break=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      case PROTO_UDP:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        case PROTO_TCP_CLIENT:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        case CM_CHILD_UDP:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        case CM_CHILD_TCP:</span><br><span>             s=
ec =3D c-&gt;options.ce.connect_retry_seconds;</span><br><span>            =
 break;</span><br><span>     }</span><br><span>@@ -2875,7 +2878,7 @@</span>=
<br><span>     }</span><br><span> </span><br><span>     /* Slow down reconn=
ection after 5 retries per remote -- for TCP client or UDP tls-client only =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;optio=
ns.ce.proto =3D=3D PROTO_TCP_CLIENT</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_CHILD_TCP</span><br><span>    =
     || (c-&gt;options.ce.proto =3D=3D PROTO_UDP &amp;&amp; c-&gt;options.t=
ls_client))</span><br><span>     {</span><br><span>         backoff =3D (c-=
&gt;options.unsuccessful_attempts / c-&gt;options.connection_list-&gt;len) =
- 4;</span><br><span>@@ -3355,7 +3358,6 @@</span><br><span>     to.server =
=3D options-&gt;tls_server;</span><br><span>     to.replay_window =3D optio=
ns-&gt;replay_window;</span><br><span>     to.replay_time =3D options-&gt;r=
eplay_time;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    to.tcp=
_mode =3D link_socket_proto_connection_oriented(options-&gt;ce.proto);</spa=
n><br><span>     to.config_ciphername =3D c-&gt;options.ciphername;</span><=
br><span>     to.config_ncp_ciphers =3D c-&gt;options.ncp_ciphers;</span><b=
r><span>     to.transition_window =3D options-&gt;transition_window;</span>=
<br><span>@@ -3409,7 +3411,7 @@</span><br><span> </span><br><span>     /* s=
hould we not xmit any packets until we get an initial</span><br><span>     =
 * response from client? */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (to.server &amp;&amp; options-&gt;ce.proto =3D=3D PROTO_TCP_SE=
RVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (to.ser=
ver &amp;&amp; c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span>     {</span=
><br><span>         to.xmit_hold =3D true;</span><br><span>     }</span><br=
><span>@@ -4260,20 +4262,13 @@</span><br><span> #ifdef _WIN32</span><br><sp=
an>         msg(M_INFO, &quot;NOTE: --fast-io is disabled since we are runn=
ing on Windows&quot;);</span><br><span> #else</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (!proto_is_udp(c-&gt;options.ce.proto))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;op=
tions.shaper)</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            msg(M_INFO, &quot;NOTE: --fast-io is disable=
d since we are not using UDP&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(M_INFO, &quot;NOTE: --fast-io is disabled =
since we are using --shaper&quot;);</span><br><span>         }</span><br><s=
pan>         else</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (c-&gt;options.shaper)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(M_INFO, &quot;NOTE: --f=
ast-io is disabled since we are using --shaper&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                c-&gt;c2.fast_io =3D true;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            c-&gt;c2.fast_io =3D true;</span><br=
><span>         }</span><br><span> #endif</span><br><span>     }</span><br>=
<span>@@ -4680,7 +4675,7 @@</span><br><span>     }</span><br><span> </span>=
<br><span>     /* our wait-for-i/o objects, different for posix vs. win32 *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;mode =
=3D=3D CM_P2P)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP)</span><br><span>  =
   {</span><br><span>         do_event_set_init(c, SHAPER_DEFINED(&amp;c-&g=
t;options));</span><br><span>     }</span><br><span>@@ -4947,7 +4942,7 @@</=
span><br><span>     CLEAR(*dest);</span><br><span> </span><br><span>     /*=
 proto_is_dgram will ASSERT(0) if proto is invalid */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    dest-&gt;mode =3D proto_is_dgram(src-&g=
t;options.ce.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    dest-&gt;mode =3D proto_is_dgram(ls-&gt;=
info.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;</span><br><span> </span><br><spa=
n>     dest-&gt;gc =3D gc_new();</span><br><span> </span><br><span>@@ -4973=
,8 +4968,11 @@</span><br><span> </span><br><span>     /* options */</span><=
br><span>     dest-&gt;options =3D src-&gt;options;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;options.ce.proto =3D ls-&gt;=
info.proto;</span><br><span>     options_detach(&amp;dest-&gt;options);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    d=
est-&gt;c2.event_set =3D src-&gt;c2.event_set;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     if (dest-&gt;mode =3D=3D C=
M_CHILD_TCP)</span><br><span>     {</span><br><span>         /*</span><br><=
span>@@ -5066,10 +5064,7 @@</span><br><span>     dest-&gt;c2.es_owned =3D f=
alse;</span><br><span> </span><br><span>     dest-&gt;c2.event_set =3D NULL=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (proto_is_dgr=
am(src-&gt;options.ce.proto))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
do_event_set_init(dest, false);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
do_event_set_init(dest, false);</span><br><span> </span><br><span> #ifdef U=
SE_COMP</span><br><span>     dest-&gt;c2.comp_context =3D NULL;</span><br><=
span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>i=
ndex 9a8b1cb..0d409b6 100644</span><br><span>--- a/src/openvpn/mtcp.c</span=
><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -149,20 +149,6 @@</s=
pan><br><span>     multi_io-&gt;n_esr =3D 0;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_set_global_rw_flags(st=
ruct multi_context *m, struct multi_instance *mi)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;soc=
ket_set_called =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        socket_set(mi-&gt;context.c2.link_sockets[0],</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                   m-&gt;multi_io-&gt;es=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   m=
buf_defined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                   &amp;mi-=
&gt;ev_arg,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
         &amp;mi-&gt;tcp_rwflags);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool<=
/span><br><span> multi_tcp_process_outgoing_link_ready(struct multi_context=
 *m, struct multi_instance *mi, const unsigned int mpp_flags)</span><br><sp=
an> {</span><br><span>@@ -230,87 +216,3 @@</span><br><span>     }</span><br=
><span>     return ret;</span><br><span> }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Top level event =
loop for single-threaded operation.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * TCP mode.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-tunnel_server_tcp(struct conte=
xt *top)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_context multi;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int status;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    top-&gt;mode =3D CM_TOP;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    context_clear_2(top);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* initialize top-tunnel instance */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    init_instance_handle_signals(top, top=
-&gt;es, CC_HARD_USR1_TO_HUP);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (IS_SIG(top))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* initialize global multi_context object */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_init(&amp;mult=
i, top, true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* initialize our cloned=
 top object */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mul=
ti_top_init(&amp;multi, top);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* initia=
lize management interface */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    init_management_callback_multi(&amp;multi);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* finished with initialization */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    initialization_sequence_completed(top, ISC=
_SERVER); /* --mode server --proto tcp-server */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    multi.top.c2.inotify_fd =3D inotify_init();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (multi.top.c2.inotify_fd &lt; 0)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_ERRORS | M_ERRNO, =
&quot;MULTI: inotify_init error&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* per-packet event loop */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (true)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        perf_push(PERF_EVENT_LOOP);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /* wait on tun/socket list */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        multi_get_timeout(&amp;mul=
ti, &amp;multi.top.c2.timeval);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        status =3D multi_io_wait(&amp;multi);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        MULTI_CHECK_SIG(&amp;multi);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        /* check on status of coarse timers */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_process_=
per_second_timers(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* t=
imeout? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(status &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* pro=
cess the I/O which triggered select */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            multi_io_process_io(&amp;multi);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            MULTI_CHECK_SIG(&amp;mu=
lti);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (status =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_io_action=
(&amp;multi, NULL, TA_TIMEOUT, false);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop=
();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    close(top-&gt;c2.inotify_fd);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* shut down management interface */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    uninit_management_callback();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* save ifconfig-pool */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    multi_ifconfig_pool_persist(&amp;multi, true);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* tear down tunnel instance (unless --persis=
t-tun) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_un=
init(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
multi_top_free(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    close_instance(top);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span>diff --git a/src/openvpn/mtcp.h b/src/openvpn/mt=
cp.h</span><br><span>index 0da0a7d..9de5203 100644</span><br><span>--- a/sr=
c/openvpn/mtcp.h</span><br><span>+++ b/src/openvpn/mtcp.h</span><br><span>@=
@ -40,8 +40,6 @@</span><br><span> </span><br><span> void multi_tcp_instance=
_specific_free(struct multi_instance *mi);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void multi_tcp_set_global_rw_flags(s=
truct multi_context *m, struct multi_instance *mi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool multi_tcp_process_ou=
tgoing_link(struct multi_context *m, bool defer, const unsigned int mpp_fla=
gs);</span><br><span> </span><br><span> bool multi_tcp_process_outgoing_lin=
k_ready(struct multi_context *m, struct multi_instance *mi, const unsigned =
int mpp_flags);</span><br><span>@@ -50,17 +48,6 @@</span><br><span> </span>=
<br><span> void multi_tcp_link_out_deferred(struct multi_context *m, struct=
 multi_instance *mi);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**=
************************************************************************/</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Main event loop for OpenVPN in TCP ser=
ver mode.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ingroup =
eventloop</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @param top - Top-level conte=
xt structure.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void tunnel_server_tcp(str=
uct context *top);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void m=
ulti_tcp_delete_event(struct multi_io *multi_io, event_t event);</span><br>=
<span> </span><br><span> #endif /* ifndef MTCP_H */</span><br><span>diff --=
git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 5f43db9=
..3472fa2 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+=
++ b/src/openvpn/mudp.c</span><br><span>@@ -195,6 +195,7 @@</span><br><span=
>     struct multi_instance *mi =3D NULL;</span><br><span>     struct hash =
*hash =3D m-&gt;hash;</span><br><span>     real.proto =3D ls-&gt;info.proto=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;hmac_rep=
ly_ls =3D ls;</span><br><span> </span><br><span>     if (mroute_extract_ope=
nvpn_sockaddr(&amp;real, &amp;m-&gt;top.c2.from.dest, true)</span><br><span=
>         &amp;&amp; m-&gt;top.c2.buf.len &gt; 0)</span><br><span>@@ -321,7=
 +322,8 @@</span><br><span>         msg_set_prefix(&quot;Connection Attempt=
&quot;);</span><br><span>         m-&gt;top.c2.to_link =3D m-&gt;hmac_reply=
;</span><br><span>         m-&gt;top.c2.to_link_addr =3D m-&gt;hmac_reply_d=
est;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        process_o=
utgoing_link(&amp;m-&gt;top, m-&gt;top.c2.link_sockets[0]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        process_outgoing_link(&amp;=
m-&gt;top, m-&gt;hmac_reply_ls);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        m-&gt;hmac_reply_ls =3D NULL;</span><br><span>        =
 m-&gt;hmac_reply_dest =3D NULL;</span><br><span>     }</span><br><span> }<=
/span><br><span>@@ -329,10 +331,10 @@</span><br><span> /*</span><br><span> =
 * Process an I/O event.</span><br><span>  */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span> multi_process_io_udp(struct multi_con=
text *m, struct link_socket *sock)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const unsigned int status =3D m-&gt;top=
.c2.event_set_status;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const unsigned int status =3D m-&gt;multi_io-&gt;udp_flags;</span><br=
><span>     const unsigned int mpp_flags =3D m-&gt;top.c2.fast_io</span><br=
><span>                                    ? (MPP_CONDITIONAL_PRE_SELECT | =
MPP_CLOSE_ON_SIGNAL)</span><br><span>                                    : =
(MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span>@@ -425,7 +427,7 @@=
</span><br><span>  * Return the io_wait() flags appropriate for</span><br><=
span>  * a point-to-multipoint tunnel.</span><br><span>  */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static inline unsigned int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span> =
p2mp_iow_flags(const struct multi_context *m)</span><br><span> {</span><br>=
<span>     unsigned int flags =3D IOW_WAIT_SIGNAL;</span><br><span>@@ -460,=
87 +462,3 @@</span><br><span> #endif</span><br><span>     return flags;</sp=
an><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-tunnel_server_udp(struct context *top)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct multi_context multi;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
top-&gt;mode =3D CM_TOP;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    context_clear_2(top);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* initial=
ize top-tunnel instance */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    init_instance_handle_signals(top, top-&gt;es, CC_HARD_USR1_TO_HUP)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (IS_SIG(top))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* initialize global multi_context object */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    multi_init(&amp;multi, top, false);</span><br><sp=
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
-proto udp */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi.top.c2.inotify_f=
d =3D inotify_init();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (multi.top.c2.inotify_fd &lt; 0)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(D_MULTI_ERRORS | M_ERRNO, &quot;MULTI: inotify_init error&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* per-packet event loop */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    while (true)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   perf_push(PERF_EVENT_LOOP);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* s=
et up and do the io_wait() */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        multi_get_timeout(&amp;multi, &amp;multi.top.c2.timeval);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        io_wait(&amp;mu=
lti.top, p2mp_iow_flags(&amp;multi));</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        MULTI_CHECK_SIG(&amp;multi);</span><br><span style=
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
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            /* Since there&#39;s only one link_socket just us=
e the first, in an upcoming</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-             * patch this will be changed by using the link_socket re=
turned by the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
     * event set */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          multi_process_io_udp(&amp;multi, top-&gt;c2.link_sockets[0]);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            MULTI_CHECK_S=
IG(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
def ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    close(top-&gt;c2.inotify_fd);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* shut down managem=
ent interface */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    u=
ninit_management_callback();</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* save if=
config-pool */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mul=
ti_ifconfig_pool_persist(&amp;multi, true);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* tear down tunnel instance (unless --persist-tun) */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    multi_uninit(&amp;multi);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_top_free(&amp;multi=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    close_instance(=
top);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n>diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h</span><br><span>inde=
x b378754..357b684 100644</span><br><span>--- a/src/openvpn/mudp.h</span><b=
r><span>+++ b/src/openvpn/mudp.h</span><br><span>@@ -31,18 +31,9 @@</span><=
br><span> struct context;</span><br><span> struct multi_context;</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int=
 p2mp_iow_flags(const struct multi_context *m);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Main event loop for OpenVPN in UDP server mode=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ingroup eventloo=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * This function implements OpenVPN&#39=
;s main event loop for UDP server mode.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @param top - Top-level context structure.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void tunnel_server_udp(struct context *top);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_pr=
ocess_io_udp(struct multi_context *m, struct link_socket *ls);</span><br><s=
pan> /*********************************************************************=
*****/</span><br><span> /**</span><br><span>  * Get, and if necessary creat=
e, the multi_instance associated with a</span><br><span>diff --git a/src/op=
envpn/multi.c b/src/openvpn/multi.c</span><br><span>index f76dad8..0b1f91e =
100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/=
openvpn/multi.c</span><br><span>@@ -289,7 +289,7 @@</span><br><span>  * Mai=
n initialization function, init multi_context object.</span><br><span>  */<=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
multi_init(struct multi_context *m, struct context *t, bool tcp_mode)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_init(struct multi_c=
ontext *m, struct context *t)</span><br><span> {</span><br><span>     int d=
ev =3D DEV_TYPE_UNDEF;</span><br><span> </span><br><span>@@ -435,13 +435,12=
 @@</span><br><span> </span><br><span>     m-&gt;instances =3D calloc(m-&gt=
;max_clients, sizeof(struct multi_instance *));</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;top.c2.event_set =
=3D t-&gt;c2.event_set;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     /*</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     * Initialize multi-socket TCP I/O wait object</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * Initialize multi-socket I/O wa=
it object</span><br><span>      */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (tcp_mode)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 m-&gt;multi_io =3D multi_io_init(t-&gt;options.max_clients, &amp;m-&gt;max=
_clients);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;multi_io =3D mu=
lti_io_init(t-&gt;options.max_clients, &amp;m-&gt;max_clients);</span><br><=
span>     m-&gt;tcp_queue_limit =3D t-&gt;options.tcp_queue_limit;</span><b=
r><span> </span><br><span>     /*</span><br><span>@@ -607,6 +606,7 @@</span=
><br><span> </span><br><span>     ASSERT(!mi-&gt;halt);</span><br><span>   =
  mi-&gt;halt =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool is_dgram =3D proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-=
&gt;info.proto);</span><br><span> </span><br><span>     dmsg(D_MULTI_DEBUG,=
 &quot;MULTI: multi_close_instance called&quot;);</span><br><span> </span><=
br><span>@@ -665,7 +665,7 @@</span><br><span>             mi-&gt;did_iroute=
s =3D false;</span><br><span>         }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (m-&gt;multi_io)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!is_dgram)</span><b=
r><span>         {</span><br><span>             multi_tcp_dereference_insta=
nce(m-&gt;multi_io, mi);</span><br><span>         }</span><br><span>@@ -340=
0,7 +3400,7 @@</span><br><span>             /* decrypt in instance context =
*/</span><br><span> </span><br><span>             perf_push(PERF_PROC_IN_LI=
NK);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            lsi =
=3D get_link_socket_info(c);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            lsi =3D &amp;ls-&gt;info;</span><br><span>            =
 orig_buf =3D c-&gt;c2.buf.data;</span><br><span>             if (process_i=
ncoming_link_part1(c, lsi, floated))</span><br><span>             {</span><=
br><span>@@ -3849,7 +3849,7 @@</span><br><span>     while ((he =3D hash_ite=
rator_next(&amp;hi)))</span><br><span>     {</span><br><span>         struc=
t multi_instance *mi =3D (struct multi_instance *) he-&gt;value;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (!mi-&gt;halt)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!mi-&gt;halt &=
amp;&amp; proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto))=
</span><br><span>         {</span><br><span>             send_control_chann=
el_string(&amp;mi-&gt;context, next_server ? &quot;RESTART,[N]&quot; : &quo=
t;RESTART&quot;, D_PUSH);</span><br><span>             multi_schedule_conte=
xt_wakeup(m, mi);</span><br><span>@@ -3887,7 +3887,7 @@</span><br><span>   =
      status_close(so);</span><br><span>         return false;</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if=
 (proto_is_dgram(m-&gt;top.options.ce.proto)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (has_udp_in_local_list(&amp;m-&gt;top.=
options)</span><br><span>              &amp;&amp; is_exit_restart(m-&gt;top=
.sig-&gt;signal_received)</span><br><span>              &amp;&amp; (m-&gt;d=
eferred_shutdown_signal.signal_received =3D=3D 0)</span><br><span>         =
     &amp;&amp; m-&gt;top.options.ce.explicit_exit_notification !=3D 0)</sp=
an><br><span>@@ -4168,6 +4168,45 @@</span><br><span>     ASSERT(mi-&gt;cont=
ext.c2.tls_multi-&gt;peer_id &lt; m-&gt;max_clients);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/***=
***********************************************************************/</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Main event loop for OpenVPN in poin=
t-to-multipoint server mode.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @ingroup eventloop</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram top - Top-level context structure.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tunne=
l_server_loop(struct multi_context *multi)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (true)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        perf_push(PERF_EVENT_LOOP);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* wait on tun/socket list */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_get_ti=
meout(multi, &amp;multi-&gt;top.c2.timeval);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        status =3D multi_io_wait(multi);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        MULTI_CHECK_SIG(multi=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* check on status of coarse=
 timers */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
ulti_process_per_second_timers(multi);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* timeout? */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (status &gt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /* process the I/O which triggered select */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            multi_io_process_io(multi)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            MULTI_=
CHECK_SIG(multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
 if (status =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    multi_io_action(multi, NULL, TA_TIMEOUT, false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        perf_pop();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span> </span><br><span> /*</span><br><span>  * Top level event loop.</s=
pan><br><span>@@ -4177,12 +4216,53 @@</span><br><span> {</span><br><span>  =
   ASSERT(top-&gt;options.mode =3D=3D MODE_SERVER);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (proto_is_dgram(top-=
&gt;options.ce.proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct multi_context multi;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
top-&gt;mode =3D CM_TOP;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    context_clear_2(top);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* i=
nitialize top-tunnel instance */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    init_instance_handle_signals(top, top-&gt;es, CC_HARD_USR1=
_TO_HUP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (IS=
_SIG(top))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        tunnel_server_udp(top);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return;</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* initialize global multi_context object */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    multi_init(&amp;multi, top);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* initialize our cloned top object *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_top_init=
(&amp;multi, top);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* initialize ma=
nagement interface */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    init_management_callback_multi(&amp;multi);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* finished with initialization */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    initialization_sequence_completed(top, IS=
C_SERVER); /* --mode server --proto tcp-server */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    multi.top.c2.inotify_fd =3D inotify_init();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (multi.top.c2.inotify_fd=
 &lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        tunnel_server_tcp(top);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS | M_ERRNO, &quot;MULTI: in=
otify_init error&quot;);</span><br><span>     }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
tunnel_server_loop(&amp;multi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #if=
def ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    close(top-&gt;c2.inotify_fd);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* shut down=
 management interface */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uninit_management_callback();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* save ifconfig-pool */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    multi_ifconfig_pool_persist(&amp;multi, true);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* tear down tunnel instance (unless --persist-tun=
) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_unini=
t(&amp;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
ulti_top_free(&amp;multi);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    close_instance(top);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> }</span><br><span>diff --git a/src/openvpn/mu=
lti.h b/src/openvpn/multi.h</span><br><span>index eacfb52..5d10237 100644</=
span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/=
multi.h</span><br><span>@@ -204,6 +204,7 @@</span><br><span> </span><br><sp=
an>     struct buffer hmac_reply;</span><br><span>     struct link_socket_a=
ctual *hmac_reply_dest;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct link_socket *hmac_reply_ls;</span><br><span> </span><br><spa=
n>     /*</span><br><span>      * Timer object for stale route check</span>=
<br><span>@@ -251,10 +252,8 @@</span><br><span>  * Main event loop for Open=
VPN in server mode.</span><br><span>  * @ingroup eventloop</span><br><span>=
  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This function c=
alls the appropriate main event loop function depending</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * on the transport protocol used:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  - \c tunnel_server_udp()=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - \c tunnel_serve=
r_tcp()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This func=
tion calls the main event loop function</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * on the transport protocols:</span><br><span>  *</spa=
n><br><span>  * @param top          - Top-level context structure.</span><b=
r><span>  */</span><br><span>@@ -267,7 +266,7 @@</span><br><span>  * Called=
 by mtcp.c, mudp.c, or other (to be written) protocol drivers</span><br><sp=
an>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void multi_init(struct multi_context *m, struct context *t, bool tcp_mo=
de);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_init=
(struct multi_context *m, struct context *t);</span><br><span> </span><br><=
span> void multi_uninit(struct multi_context *m);</span><br><span> </span><=
br><span>diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c</span=
><br><span>index e4174dd..62b8bb2 100644</span><br><span>--- a/src/openvpn/=
multi_io.c</span><br><span>+++ b/src/openvpn/multi_io.c</span><br><span>@@ =
-133,6 +133,20 @@</span><br><span> }</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_set_globa=
l_rw_flags(struct multi_context *m, struct multi_instance *mi)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (mi)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        mi-&gt;socket_set_called =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        socket_set(mi-&gt;context.c2.link_sockets=
[0],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
    m-&gt;multi_io-&gt;es,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                   mbuf_defined(mi-&gt;tcp_link_out_deferred) ? EVEN=
T_WRITE : EVENT_READ,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   !proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;=
info.proto) ? &amp;mi-&gt;ev_arg : &amp;mi-&gt;context.c2.link_sockets[0]-&=
gt;ev_arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
          !proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto)=
 ? &amp;mi-&gt;tcp_rwflags : NULL);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> multi_io_free=
(struct multi_io *multi_io)</span><br><span> {</span><br><span>     if (mul=
ti_io)</span><br><span>@@ -155,6 +169,11 @@</span><br><span>               =
                       &amp;m-&gt;top.c2.link_sockets[i]-&gt;ev_arg);</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (has_udp_in_local_list(&amp;m-&gt;top.options))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        get_io_flags_udp(&amp;m-&gt;to=
p, m-&gt;multi_io, p2mp_iow_flags(m));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> #ifdef _WIN32</span><br><span>     if (tuntap_is_win=
tun(m-&gt;top.c1.tuntap))</span><br><span>     {</span><br><span>@@ -333,7 =
+352,7 @@</span><br><span> </span><br><span>         case TA_INITIAL:</span=
><br><span>             ASSERT(mi);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            multi_tcp_set_global_rw_flags(m, mi);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            multi_io_set_global=
_rw_flags(m, mi);</span><br><span>             multi_process_post(m, mi, mp=
p_flags);</span><br><span>             break;</span><br><span> </span><br><=
span>@@ -383,7 +402,7 @@</span><br><span>             }</span><br><span>   =
          else</span><br><span>             {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                multi_tcp_set_global_rw_flags(m, mi=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
ulti_io_set_global_rw_flags(m, mi);</span><br><span>             }</span><b=
r><span>             break;</span><br><span> </span><br><span>@@ -442,14 +4=
61,13 @@</span><br><span>                     }</span><br><span>           =
          break;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                /* new incoming TCP client attempting to conne=
ct? */</span><br><span>                 case EVENT_ARG_LINK_SOCKET:</span><=
br><span>                     if (!ev_arg-&gt;u.sock)</span><br><span>     =
                {</span><br><span>                         msg(D_MULTI_ERRO=
RS, &quot;MULTI IO: multi_io_proc_io: null socket&quot;);</span><br><span> =
                        break;</span><br><span>                     }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    /* new incoming TCP client=
 attempting to connect? */</span><br><span>                     if (!proto_=
is_dgram(ev_arg-&gt;u.sock-&gt;info.proto))</span><br><span>               =
      {</span><br><span>                         socket_reset_listen_persis=
tent(ev_arg-&gt;u.sock);</span><br><span>@@ -460,6 +478,19 @@</span><br><sp=
an>                         }</span><br><span>                         brea=
k;</span><br><span>                     }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        multi_process_io_udp(m=
, ev_arg-&gt;u.sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        mi =3D m-&gt;pending;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        /* Mimic TCP and monito=
r and/or handle events that</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                         * are triggered in succession by the first=
 one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
          * before returning to the main loop. */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        if (mi)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
 multi_io_action(m, mi, TA_INITIAL, false);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        break;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><s=
pan>             }</span><br><span>         }</span><br><span>         else=
</span><br><span>diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io=
.h</span><br><span>index 03d708c..0887a5e 100644</span><br><span>--- a/src/=
openvpn/multi_io.h</span><br><span>+++ b/src/openvpn/multi_io.h</span><br><=
span>@@ -70,6 +70,8 @@</span><br><span> </span><br><span> void multi_io_pro=
cess_io(struct multi_context *m);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void multi_io_set_global_rw_flags(struct =
multi_context *m, struct multi_instance *mi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> void multi_io_action(struct mul=
ti_context *m, struct multi_instance *mi, int action, bool poll);</span><br=
><span> </span><br><span> void multi_io_delete_event(struct multi_io *multi=
_io, event_t event);</span><br><span>diff --git a/src/openvpn/openvpn.h b/s=
rc/openvpn/openvpn.h</span><br><span>index df43bba..581d248 100644</span><b=
r><span>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvpn/openv=
pn.h</span><br><span>@@ -216,8 +216,8 @@</span><br><span>  * \c SIGUSR1 res=
tarts.</span><br><span>  *</span><br><span>  * This structure is initialize=
d at the top of the \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * tunnel_point_to_point(), \c tunnel_server_udp(), and \c</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * tunnel_server_tcp() functions.  In=
 other words, it is reset for every</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * tunnel_point_to_point(), \c tunnel_server() \c</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * functions.  In other words=
, it is reset for every</span><br><span>  * iteration of the \c main() func=
tion&#39;s inner \c SIGUSR1 loop.</span><br><span>  */</span><br><span> str=
uct context_2</span><br><span>diff --git a/src/openvpn/options.c b/src/open=
vpn/options.c</span><br><span>index 3ae44db..a422b88 100644</span><br><span=
>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</s=
pan><br><span>@@ -999,10 +999,6 @@</span><br><span>                        =
 const struct connection_entry *e,</span><br><span>                        =
 const int i)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    setenv_str_i(es, &quot;proto&quot;, proto2ascii(e-&gt;proto,=
 e-&gt;af, false), i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* expected to be for single socket contexts only */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;local&quot;,=
 e-&gt;local_list-&gt;array[0]-&gt;local, i);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;local_port&quot;, e-&gt;=
local_list-&gt;array[0]-&gt;port, i);</span><br><span>     setenv_str_i(es,=
 &quot;remote&quot;, e-&gt;remote, i);</span><br><span>     setenv_str_i(es=
, &quot;remote_port&quot;, e-&gt;remote_port, i);</span><br><span> </span><=
br><span>@@ -1018,6 +1014,16 @@</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+setenv_loca=
l_entry(struct env_set *es,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                   const struct local_entry *e,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                   const int i)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    setenv_str_i(es, &quot;proto&quot;, proto=
2ascii(e-&gt;proto, AF_UNSPEC, false), i);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    setenv_str_i(es, &quot;local&quot;, e-&gt;local,=
 i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str_=
i(es, &quot;local_port&quot;, e-&gt;port, i);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> void</span><br><span> setenv_settings(struct env_=
set *es, const struct options *o)</span><br><span> {</span><br><span>@@ -10=
41,6 +1047,14 @@</span><br><span>         setenv_connection_entry(es, &amp;=
o-&gt;ce, 1);</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;ce.local_list)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; o-&gt;ce.loc=
al_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    setenv_local_entry(es, o-&gt;ce.local_list-&gt;array[i], i+1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     if (!o-&gt;pull)</span><br><sp=
an>     {</span><br><span>         setenv_dns_options(&amp;o-&gt;dns_option=
s, es);</span><br><span>@@ -2205,6 +2219,7 @@</span><br><span>     }</span>=
<br><span> </span><br><span>     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, =
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e-&gt;proto=
 =3D PROTO_NONE;</span><br><span>     l-&gt;array[l-&gt;len++] =3D e;</span=
><br><span> </span><br><span>     return e;</span><br><span>@@ -2471,7 +248=
6,7 @@</span><br><span>     {</span><br><span>         struct local_entry *=
le =3D ce-&gt;local_list-&gt;array[i];</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (proto_is_net(ce-&gt;proto)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (proto_is_=
net(le-&gt;proto)</span><br><span>             &amp;&amp; string_defined_eq=
ual(le-&gt;local, ce-&gt;remote)</span><br><span>             &amp;&amp; st=
ring_defined_equal(le-&gt;port, ce-&gt;remote_port))</span><br><span>      =
   {</span><br><span>@@ -3179,11 +3194,12 @@</span><br><span>         }</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (o-&gt;client)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (o-&gt;mode !=3D MODE_SERVER)</span><br><span>    =
 {</span><br><span>         if (ce-&gt;proto =3D=3D PROTO_TCP)</span><br><s=
pan>         {</span><br><span>             ce-&gt;proto =3D PROTO_TCP_CLIE=
NT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&g=
t;ce.proto =3D ce-&gt;proto;</span><br><span>         }</span><br><span>   =
  }</span><br><span> </span><br><span>@@ -3332,6 +3348,10 @@</span><br><spa=
n>     {</span><br><span>         le-&gt;port =3D ce-&gt;local_port;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!le-&gt;proto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        le-&gt=
;proto =3D ce-&gt;proto;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span> }</span><br><span> </span><br><span> #ifdef _WI=
N32</span><br><span>@@ -3781,6 +3801,18 @@</span><br><span>         {</span=
><br><span>             options_postprocess_mutate_le(&amp;o-&gt;ce, o-&gt;=
ce.local_list-&gt;array[i]);</span><br><span>         }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        for (int i =3D 0; i &lt; o-&gt;ce.local_list-&gt;l=
en; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (o-&gt=
;ce.local_list-&gt;array[i]-&gt;proto =3D=3D PROTO_TCP)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                o-&gt;ce.local_list-&gt;array=
[i]-&gt;proto =3D PROTO_TCP_SERVER;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            else if (o-&gt;ce.local_list-&gt;array[i]-&gt;proto =
=3D=3D PROTO_NONE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         o-&gt;ce.local_list-&gt;array[i]-&gt;proto =3D o-&gt;ce.proto;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>   =
  }</span><br><span>     else</span><br><span>     {</span><br><span>@@ -37=
89,6 +3821,7 @@</span><br><span>         struct local_entry *e =3D alloc_lo=
cal_entry(&amp;o-&gt;ce, M_USAGE, &amp;o-&gt;gc);</span><br><span>         =
ASSERT(e);</span><br><span>         e-&gt;port =3D o-&gt;ce.local_port;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        e-&gt;proto =3D=
 o-&gt;ce.proto;</span><br><span>     }</span><br><span> </span><br><span> =
    /* use the same listen list for every outgoing connection */</span><br>=
<span>@@ -3797,6 +3830,12 @@</span><br><span>         o-&gt;connection_list=
-&gt;array[i]-&gt;local_list =3D o-&gt;ce.local_list;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (has_tcp_in_local_list(o))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        o-&gt;fast_io =3D false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_INFO, &quot;NOTE: --fast-io is disabled if there=
 is a TCP socket active&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     if (o-&gt;tls_server)</span><br><span>     {</span><br>=
<span>         /* Check that DH file is specified, or explicitly disabled *=
/</span><br><span>@@ -6191,7 +6230,7 @@</span><br><span>         VERIFY_PER=
MISSION(OPT_P_UP);</span><br><span>         options-&gt;ifconfig_nowarn =3D=
 true;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    else if (streq(p[0], &quot;local&quot;) &amp;&amp; p[1] &amp;&a=
mp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (streq(p[0], &quot;local&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span>=
<br><span>     {</span><br><span>         struct local_entry *e;</span><br>=
<span> </span><br><span>@@ -6212,6 +6251,11 @@</span><br><span>         {</=
span><br><span>             e-&gt;port =3D p[2];</span><br><span>         }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (p[3])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            e-&gt;proto =3D ascii2proto(p[3]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an>     }</span><br><span>     else if (streq(p[0], &quot;remote-random&quo=
t;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -9646,3 +96=
90,37 @@</span><br><span> err:</span><br><span>     gc_free(&amp;gc);</span=
><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+has_udp_in_local_list(const struct optio=
ns *options)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;ce.lo=
cal_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0=
; i &lt; options-&gt;ce.local_list-&gt;len; i++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (proto_is_dgram(options-&gt;ce.local_list=
-&gt;array[i]-&gt;proto))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+has_tcp_in_local_l=
ist(const struct options *options)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (options-&gt;ce.local_list)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      for (int i =3D 0; i &lt; options-&gt;ce.local_list-&gt;len; i++)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (!proto_is_dgram(op=
tions-&gt;ce.local_list-&gt;array[i]-&gt;proto))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span=
>index 3f4cb90..161899a 100644</span><br><span>--- a/src/openvpn/options.h<=
/span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -98,6 +98,7 =
@@</span><br><span> {</span><br><span>     const char *local;</span><br><sp=
an>     const char *port;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int proto;</span><br><span> };</span><br><span> </span><br><span>=
 struct connection_entry</span><br><span>@@ -917,6 +918,10 @@</span><br><sp=
an> </span><br><span> bool key_is_external(const struct options *options);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol has_udp_in_local_list(const struct options *options);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool has_tcp_in_local_list(const struct options *options)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/**</span><br><span>  * Returns whether the current configuration has dco e=
nabled.</span><br><span>  */</span><br><span>diff --git a/src/openvpn/socke=
t.c b/src/openvpn/socket.c</span><br><span>index 97dce02..ba0891a 100644</s=
pan><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/=
socket.c</span><br><span>@@ -1888,11 +1888,33 @@</span><br><span>     struc=
t options *o =3D &amp;c-&gt;options;</span><br><span>     ASSERT(sock);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *host =3D o-&gt;ce.local_list-&gt;array[sock_index]-&gt;local;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *port =
=3D o-&gt;ce.local_list-&gt;array[sock_index]-&gt;port;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int proto =3D o-&gt;ce.local_list-&=
gt;array[sock_index]-&gt;proto;</span><br><span>     const char *remote_hos=
t =3D o-&gt;ce.remote;</span><br><span>     const char *remote_port =3D o-&=
gt;ce.remote_port;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    sock-&gt;local_host =3D o-&gt;ce.local_list-&gt;array[so=
ck_index]-&gt;local;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   sock-&gt;local_port =3D o-&gt;ce.local_list-&gt;array[sock_index]-&gt;po=
rt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;mo=
de =3D=3D CM_CHILD_TCP || c-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct link_socket *tmp_sock =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;mode =
=3D=3D CM_CHILD_TCP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   tmp_sock =3D (struct link_socket *)c-&gt;c2.accept_from;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        else if (c-&gt;mode =3D=3D CM_CHILD_U=
DP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            tmp_sock =3D c=
-&gt;c2.link_sockets[0];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        host =3D tmp_soc=
k-&gt;local_host;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      port =3D tmp_sock-&gt;local_port;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        proto =3D tmp_sock-&gt;info.proto;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(c-&gt;c2.link_sockets[sock_index]);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    sock-&gt;local_host =3D host;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;local_port =3D port;</span><=
br><span>     sock-&gt;remote_host =3D remote_host;</span><br><span>     so=
ck-&gt;remote_port =3D remote_port;</span><br><span>     sock-&gt;dns_cache=
 =3D c-&gt;c1.dns_cache;</span><br><span>@@ -1920,7 +1942,7 @@</span><br><s=
pan> </span><br><span>     sock-&gt;mark =3D o-&gt;mark;</span><br><span>  =
   sock-&gt;bind_dev =3D o-&gt;bind_dev;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    sock-&gt;info.proto =3D o-&gt;ce.proto;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info.proto =3D prot=
o;</span><br><span>     sock-&gt;info.af =3D o-&gt;ce.af;</span><br><span> =
    sock-&gt;info.remote_float =3D o-&gt;ce.remote_float;</span><br><span> =
    sock-&gt;info.lsa =3D &amp;c-&gt;c1.link_socket_addrs[sock_index];</spa=
n><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.=
h</span><br><span>index 9625a99..6916ad4 100644</span><br><span>--- a/src/o=
penvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span><b=
r><span>@@ -362,7 +362,6 @@</span><br><span> </span><br><span>     int repl=
ay_window;                 /* --replay-window parm */</span><br><span>     =
int replay_time;                   /* --replay-window parm */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    bool tcp_mode;</span><br><span>=
 </span><br><span>     const char *config_ciphername;</span><br><span>     =
const char *config_ncp_ciphers;</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">c=
hange 764</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31bbf87e4e568021445c7512ece=
fadfd4a69b363 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 764 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
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
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--nnJI5fbik1o=--

