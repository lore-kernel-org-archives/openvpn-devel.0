From: Gert Doering <gert@...1296...>
Date: Thu,  6 Mar 2025 10:59:28 +0100
Message-ID: <20250306095928.10229-1-gert@...1296...>
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v21] Add support for simultaneous use of UDP
 and TCP sockets
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

From: Gianmarco De Gregori <gianmarco@...2726...>

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
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/764
This mail reflects revision 21 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 4496da2..d48021e 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -106,7 +106,7 @@
   is not reliable. It is recommended to set tun-mtu with enough headroom
   instead.
 
---local host|* [port]
+--local host|* [port] [protocol]
   Local host name or IP address and port for bind. If specified, OpenVPN will bind
   to this address. If unspecified, OpenVPN will bind to all interfaces.
   '*' can be used as hostname and means 'any host' (OpenVPN will listen on what
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8b94469..b025344 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1770,7 +1770,7 @@
             if (c->options.shaper)
             {
                 int overhead = datagram_overhead(c->c2.to_link_addr->dest.addr.sa.sa_family,
-                                                 c->options.ce.proto);
+                                                 sock->info.proto);
                 shaper_wrote_bytes(&c->c2.shaper,
                                    BLEN(&c->c2.to_link) + overhead);
             }
@@ -2060,52 +2060,24 @@
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
     unsigned int socket = 0;
     unsigned int tuntap = 0;
-    struct event_set_return esr[4];
-
-    /* These shifts all depend on EVENT_READ and EVENT_WRITE */
-    static uintptr_t socket_shift = SOCKET_SHIFT;   /* depends on SOCKET_READ and SOCKET_WRITE */
-    static uintptr_t tun_shift = TUN_SHIFT;      /* depends on TUN_READ and TUN_WRITE */
-    static uintptr_t err_shift = ERR_SHIFT;      /* depends on ES_ERROR */
-#ifdef ENABLE_MANAGEMENT
-    static uintptr_t management_shift = MANAGEMENT_SHIFT; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */
-#endif
-#ifdef ENABLE_ASYNC_PUSH
-    static uintptr_t file_shift = FILE_SHIFT;
-#endif
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32)
-    static uintptr_t dco_shift = DCO_SHIFT;    /* Event from DCO kernel module */
-#endif
+    static uintptr_t tun_shift = TUN_SHIFT;
+    static uintptr_t err_shift = ERR_SHIFT;
 
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
@@ -2193,12 +2165,120 @@
      */
     for (int i = 0; i < c->c1.link_sockets_num; i++)
     {
-        socket_set(c->c2.link_sockets[i], c->c2.event_set, socket,
+        socket_set(c->c2.link_sockets[i], es, socket,
                    &c->c2.link_sockets[i]->ev_arg, NULL);
     }
-    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL);
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32)
-    if (socket & EVENT_READ && c->c2.did_open_tun)
+
+    tun_set(c->c1.tuntap, es, tuntap, (void *)tun_shift, NULL);
+
+    if (out_socket)
+    {
+        *out_socket = socket;
+    }
+
+    if (out_tuntap)
+    {
+        *out_tuntap = tuntap;
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
+get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags)
+{
+    unsigned int out_socket, out_tuntap;
+
+    multi_io_process_flags(c, multi_io->es, flags, &out_socket, &out_tuntap);
+    multi_io->udp_flags = out_socket | out_tuntap;
+}
+
+void
+get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags)
+{
+    multi_io->udp_flags = ES_ERROR;
+    if (c->c2.fast_io && (flags & (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))
+    {
+        /* fast path -- only for TUN/TAP/UDP writes */
+        unsigned int ret = 0;
+        if (flags & IOW_TO_TUN)
+        {
+            ret |= TUN_WRITE;
+        }
+        if (flags & (IOW_TO_LINK | IOW_MBUF))
+        {
+            ret |= SOCKET_WRITE;
+        }
+        multi_io->udp_flags = ret;
+    }
+    else
+    {
+#ifdef _WIN32
+        bool skip_iowait = flags & IOW_TO_TUN;
+        if (flags & IOW_READ_TUN)
+        {
+            /*
+             * don't read from tun if we have pending write to link,
+             * since every tun read overwrites to_link buffer filled
+             * by previous tun read
+             */
+            skip_iowait = !(flags & IOW_TO_LINK);
+        }
+        if (tuntap_is_wintun(c->c1.tuntap) && skip_iowait)
+        {
+            unsigned int ret = 0;
+            if (flags & IOW_TO_TUN)
+            {
+                ret |= TUN_WRITE;
+            }
+            if (flags & IOW_READ_TUN)
+            {
+                ret |= TUN_READ;
+            }
+            multi_io->udp_flags = ret;
+        }
+        else
+#endif /* ifdef _WIN32 */
+        {
+            /* slow path - delegate to io_wait_dowork_udp to calculate flags */
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
+    static uintptr_t socket_shift = SOCKET_SHIFT;   /* depends on SOCKET_READ and SOCKET_WRITE */
+#ifdef ENABLE_MANAGEMENT
+    static uintptr_t management_shift = MANAGEMENT_SHIFT; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */
+#endif
+#ifdef ENABLE_ASYNC_PUSH
+    static uintptr_t file_shift = FILE_SHIFT;
+#endif
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    static uintptr_t dco_shift = DCO_SHIFT;    /* Event from DCO linux kernel module */
+#endif
+
+    /*
+     * Decide what kind of events we want to wait for.
+     */
+    event_reset(c->c2.event_set);
+
+    multi_io_process_flags(c, c->c2.event_set, flags, &out_socket, &out_tuntap);
+
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    if (out_socket & EVENT_READ && c->c2.did_open_tun)
     {
         dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)dco_shift);
     }
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 214a322..77892d6 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -69,6 +69,10 @@
 
 extern counter_type link_write_bytes_global;
 
+void get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags);
+
+void get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags);
+
 void io_wait_dowork(struct context *c, const unsigned int flags);
 
 void pre_select(struct context *c);
@@ -367,12 +371,13 @@
 
 /*
  * This is the core I/O wait function, used for all I/O waits except
- * for TCP in server mode.
+ * for the top-level server sockets.
  */
 static inline void
 io_wait(struct context *c, const unsigned int flags)
 {
-    if (c->c2.fast_io && (flags & (IOW_TO_TUN|IOW_TO_LINK|IOW_MBUF)))
+    if (proto_is_dgram(c->c2.link_sockets[0]->info.proto)
+        && c->c2.fast_io && (flags & (IOW_TO_TUN|IOW_TO_LINK|IOW_MBUF)))
     {
         /* fast path -- only for TUN/TAP/UDP writes */
         unsigned int ret = 0;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b57e5f8..c21474a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -612,6 +612,7 @@
         }
 
         c->options.ce = *ce;
+
 #ifdef ENABLE_MANAGEMENT
         if (ce_defined && management && management_query_remote_enabled(management))
         {
@@ -2681,7 +2682,9 @@
 
     if (found & OPT_P_EXPLICIT_NOTIFY)
     {
-        if (!proto_is_udp(c->options.ce.proto) && c->options.ce.explicit_exit_notification)
+        /* Client side, so just check the first link_socket */
+        if (!proto_is_udp(c->c2.link_sockets[0]->info.proto)
+            && c->options.ce.explicit_exit_notification)
         {
             msg(D_PUSH, "OPTIONS IMPORT: --explicit-exit-notify can only be used with --proto udp");
             c->options.ce.explicit_exit_notification = 0;
@@ -2850,14 +2853,14 @@
     int sec = 2;
     int backoff = 0;
 
-    switch (c->options.ce.proto)
+    switch (c->mode)
     {
-        case PROTO_TCP_SERVER:
+        case CM_TOP:
             sec = 1;
             break;
 
-        case PROTO_UDP:
-        case PROTO_TCP_CLIENT:
+        case CM_CHILD_UDP:
+        case CM_CHILD_TCP:
             sec = c->options.ce.connect_retry_seconds;
             break;
     }
@@ -2875,7 +2878,7 @@
     }
 
     /* Slow down reconnection after 5 retries per remote -- for TCP client or UDP tls-client only */
-    if (c->options.ce.proto == PROTO_TCP_CLIENT
+    if (c->mode == CM_CHILD_TCP
         || (c->options.ce.proto == PROTO_UDP && c->options.tls_client))
     {
         backoff = (c->options.unsuccessful_attempts / c->options.connection_list->len) - 4;
@@ -3355,7 +3358,6 @@
     to.server = options->tls_server;
     to.replay_window = options->replay_window;
     to.replay_time = options->replay_time;
-    to.tcp_mode = link_socket_proto_connection_oriented(options->ce.proto);
     to.config_ciphername = c->options.ciphername;
     to.config_ncp_ciphers = c->options.ncp_ciphers;
     to.transition_window = options->transition_window;
@@ -3409,7 +3411,7 @@
 
     /* should we not xmit any packets until we get an initial
      * response from client? */
-    if (to.server && options->ce.proto == PROTO_TCP_SERVER)
+    if (to.server && c->mode == CM_CHILD_TCP)
     {
         to.xmit_hold = true;
     }
@@ -4260,20 +4262,13 @@
 #ifdef _WIN32
         msg(M_INFO, "NOTE: --fast-io is disabled since we are running on Windows");
 #else
-        if (!proto_is_udp(c->options.ce.proto))
+        if (c->options.shaper)
         {
-            msg(M_INFO, "NOTE: --fast-io is disabled since we are not using UDP");
+            msg(M_INFO, "NOTE: --fast-io is disabled since we are using --shaper");
         }
         else
         {
-            if (c->options.shaper)
-            {
-                msg(M_INFO, "NOTE: --fast-io is disabled since we are using --shaper");
-            }
-            else
-            {
-                c->c2.fast_io = true;
-            }
+            c->c2.fast_io = true;
         }
 #endif
     }
@@ -4689,7 +4684,7 @@
     }
 
     /* our wait-for-i/o objects, different for posix vs. win32 */
-    if (c->mode == CM_P2P)
+    if (c->mode == CM_P2P || c->mode == CM_TOP)
     {
         do_event_set_init(c, SHAPER_DEFINED(&c->options));
     }
@@ -4956,7 +4951,7 @@
     CLEAR(*dest);
 
     /* proto_is_dgram will ASSERT(0) if proto is invalid */
-    dest->mode = proto_is_dgram(src->options.ce.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;
+    dest->mode = proto_is_dgram(ls->info.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;
 
     dest->gc = gc_new();
 
@@ -4982,8 +4977,11 @@
 
     /* options */
     dest->options = src->options;
+    dest->options.ce.proto = ls->info.proto;
     options_detach(&dest->options);
 
+    dest->c2.event_set = src->c2.event_set;
+
     if (dest->mode == CM_CHILD_TCP)
     {
         /*
@@ -5075,10 +5073,7 @@
     dest->c2.es_owned = false;
 
     dest->c2.event_set = NULL;
-    if (proto_is_dgram(src->options.ce.proto))
-    {
-        do_event_set_init(dest, false);
-    }
+    do_event_set_init(dest, false);
 
 #ifdef USE_COMP
     dest->c2.comp_context = NULL;
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 9a8b1cb..0d409b6 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -149,20 +149,6 @@
     multi_io->n_esr = 0;
 }
 
-void
-multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi)
-{
-    if (mi)
-    {
-        mi->socket_set_called = true;
-        socket_set(mi->context.c2.link_sockets[0],
-                   m->multi_io->es,
-                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,
-                   &mi->ev_arg,
-                   &mi->tcp_rwflags);
-    }
-}
-
 bool
 multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
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
-    top->mode = CM_TOP;
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
-    initialization_sequence_completed(top, ISC_SERVER); /* --mode server --proto tcp-server */
-
-#ifdef ENABLE_ASYNC_PUSH
-    multi.top.c2.inotify_fd = inotify_init();
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
-        status = multi_io_wait(&multi);
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
-        else if (status == 0)
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
 
-void multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi);
-
 bool multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, const unsigned int mpp_flags);
 
 bool multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags);
@@ -50,17 +48,6 @@
 
 void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_instance *mi);
 
-
-/**************************************************************************/
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
index e0b27af..c0344b1 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -195,6 +195,7 @@
     struct multi_instance *mi = NULL;
     struct hash *hash = m->hash;
     real.proto = ls->info.proto;
+    m->hmac_reply_ls = ls;
 
     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
@@ -321,7 +322,8 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link = m->hmac_reply;
         m->top.c2.to_link_addr = m->hmac_reply_dest;
-        process_outgoing_link(&m->top, m->top.c2.link_sockets[0]);
+        process_outgoing_link(&m->top, m->hmac_reply_ls);
+        m->hmac_reply_ls = NULL;
         m->hmac_reply_dest = NULL;
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
-    const unsigned int status = m->top.c2.event_set_status;
+    const unsigned int status = m->multi_io->udp_flags;
     const unsigned int mpp_flags = m->top.c2.fast_io
                                    ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)
                                    : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);
@@ -420,13 +422,15 @@
         }
     }
 #endif
+
+    m->multi_io->udp_flags = ES_ERROR;
 }
 
 /*
  * Return the io_wait() flags appropriate for
  * a point-to-multipoint tunnel.
  */
-static inline unsigned int
+unsigned int
 p2mp_iow_flags(const struct multi_context *m)
 {
     unsigned int flags = IOW_WAIT_SIGNAL;
@@ -461,87 +465,3 @@
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
-    top->mode = CM_TOP;
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
-    initialization_sequence_completed(top, ISC_SERVER); /* --mode server --proto udp */
-
-#ifdef ENABLE_ASYNC_PUSH
-    multi.top.c2.inotify_fd = inotify_init();
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
-        if (multi.top.c2.event_set_status == ES_TIMEOUT)
-        {
-            multi_process_timeout(&multi, MPP_PRE_SELECT|MPP_CLOSE_ON_SIGNAL);
-        }
-        else
-        {
-            /* process I/O */
-
-            /* Since there's only one link_socket just use the first, in an upcoming
-             * patch this will be changed by using the link_socket returned by the
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
 /**************************************************************************/
 /**
  * Get, and if necessary create, the multi_instance associated with a
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 7ab9289..07258be 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -289,7 +289,7 @@
  * Main initialization function, init multi_context object.
  */
 void
-multi_init(struct multi_context *m, struct context *t, bool tcp_mode)
+multi_init(struct multi_context *m, struct context *t)
 {
     int dev = DEV_TYPE_UNDEF;
 
@@ -435,13 +435,12 @@
 
     m->instances = calloc(m->max_clients, sizeof(struct multi_instance *));
 
+    m->top.c2.event_set = t->c2.event_set;
+
     /*
-     * Initialize multi-socket TCP I/O wait object
+     * Initialize multi-socket I/O wait object
      */
-    if (tcp_mode)
-    {
-        m->multi_io = multi_io_init(t->options.max_clients, &m->max_clients);
-    }
+    m->multi_io = multi_io_init(t->options.max_clients, &m->max_clients);
     m->tcp_queue_limit = t->options.tcp_queue_limit;
 
     /*
@@ -607,6 +606,7 @@
 
     ASSERT(!mi->halt);
     mi->halt = true;
+    bool is_dgram = proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto);
 
     dmsg(D_MULTI_DEBUG, "MULTI: multi_close_instance called");
 
@@ -665,7 +665,7 @@
             mi->did_iroutes = false;
         }
 
-        if (m->multi_io)
+        if (!is_dgram)
         {
             multi_tcp_dereference_instance(m->multi_io, mi);
         }
@@ -3401,7 +3401,7 @@
             /* decrypt in instance context */
 
             perf_push(PERF_PROC_IN_LINK);
-            lsi = get_link_socket_info(c);
+            lsi = &ls->info;
             orig_buf = c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
@@ -3850,7 +3850,7 @@
     while ((he = hash_iterator_next(&hi)))
     {
         struct multi_instance *mi = (struct multi_instance *) he->value;
-        if (!mi->halt)
+        if (!mi->halt && proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
         {
             send_control_channel_string(&mi->context, next_server ? "RESTART,[N]" : "RESTART", D_PUSH);
             multi_schedule_context_wakeup(m, mi);
@@ -3888,7 +3888,7 @@
         status_close(so);
         return false;
     }
-    else if (proto_is_dgram(m->top.options.ce.proto)
+    else if (has_udp_in_local_list(&m->top.options)
              && is_exit_restart(m->top.sig->signal_received)
              && (m->deferred_shutdown_signal.signal_received == 0)
              && m->top.options.ce.explicit_exit_notification != 0)
@@ -4169,6 +4169,45 @@
     ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
 }
 
+/**************************************************************************/
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
+        status = multi_io_wait(multi);
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
+        else if (status == 0)
+        {
+            multi_io_action(multi, NULL, TA_TIMEOUT, false);
+        }
+
+        perf_pop();
+    }
+}
 
 /*
  * Top level event loop.
@@ -4178,12 +4217,53 @@
 {
     ASSERT(top->options.mode == MODE_SERVER);
 
-    if (proto_is_dgram(top->options.ce.proto))
+    struct multi_context multi;
+
+    top->mode = CM_TOP;
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
+    initialization_sequence_completed(top, ISC_SERVER); /* --mode server --proto tcp-server */
+
+#ifdef ENABLE_ASYNC_PUSH
+    multi.top.c2.inotify_fd = inotify_init();
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
index eacfb52..4104706 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -204,6 +204,7 @@
 
     struct buffer hmac_reply;
     struct link_socket_actual *hmac_reply_dest;
+    struct link_socket *hmac_reply_ls;
 
     /*
      * Timer object for stale route check
@@ -251,11 +252,6 @@
  * Main event loop for OpenVPN in server mode.
  * @ingroup eventloop
  *
- * This function calls the appropriate main event loop function depending
- * on the transport protocol used:
- *  - \c tunnel_server_udp()
- *  - \c tunnel_server_tcp()
- *
  * @param top          - Top-level context structure.
  */
 void tunnel_server(struct context *top);
@@ -267,7 +263,7 @@
  * Called by mtcp.c, mudp.c, or other (to be written) protocol drivers
  */
 
-void multi_init(struct multi_context *m, struct context *t, bool tcp_mode);
+void multi_init(struct multi_context *m, struct context *t);
 
 void multi_uninit(struct multi_context *m);
 
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index e4174dd..f1751ff 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -133,6 +133,33 @@
 }
 
 void
+multi_io_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi)
+{
+    if (!mi)
+    {
+        return;
+    }
+
+    mi->socket_set_called = true;
+    if (proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
+    {
+        socket_set(mi->context.c2.link_sockets[0],
+                   m->multi_io->es,
+                   EVENT_READ,
+                   &mi->context.c2.link_sockets[0]->ev_arg,
+                   NULL);
+    }
+    else
+    {
+        socket_set(mi->context.c2.link_sockets[0],
+                   m->multi_io->es,
+                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,
+                   &mi->ev_arg,
+                   &mi->tcp_rwflags);
+    }
+}
+
+void
 multi_io_free(struct multi_io *multi_io)
 {
     if (multi_io)
@@ -155,6 +182,11 @@
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
@@ -333,7 +365,7 @@
 
         case TA_INITIAL:
             ASSERT(mi);
-            multi_tcp_set_global_rw_flags(m, mi);
+            multi_io_set_global_rw_flags(m, mi);
             multi_process_post(m, mi, mpp_flags);
             break;
 
@@ -383,7 +415,7 @@
             }
             else
             {
-                multi_tcp_set_global_rw_flags(m, mi);
+                multi_io_set_global_rw_flags(m, mi);
             }
             break;
 
@@ -442,24 +474,31 @@
                     }
                     break;
 
-                /* new incoming TCP client attempting to connect? */
                 case EVENT_ARG_LINK_SOCKET:
                     if (!ev_arg->u.sock)
                     {
                         msg(D_MULTI_ERRORS, "MULTI IO: multi_io_proc_io: null socket");
                         break;
                     }
-
+                    /* new incoming TCP client attempting to connect? */
                     if (!proto_is_dgram(ev_arg->u.sock->info.proto))
                     {
                         socket_reset_listen_persistent(ev_arg->u.sock);
                         mi = multi_create_instance_tcp(m, ev_arg->u.sock);
-                        if (mi)
-                        {
-                            multi_io_action(m, mi, TA_INITIAL, false);
-                        }
-                        break;
                     }
+                    else
+                    {
+                        multi_process_io_udp(m, ev_arg->u.sock);
+                        mi = m->pending;
+                    }
+                    /* monitor and/or handle events that are
+                     * triggered in succession by the first one
+                     * before returning to the main loop. */
+                    if (mi)
+                    {
+                        multi_io_action(m, mi, TA_INITIAL, false);
+                    }
+                    break;
             }
         }
         else
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 03d708c..0887a5e 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -70,6 +70,8 @@
 
 void multi_io_process_io(struct multi_context *m);
 
+void multi_io_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi);
+
 void multi_io_action(struct multi_context *m, struct multi_instance *mi, int action, bool poll);
 
 void multi_io_delete_event(struct multi_io *multi_io, event_t event);
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index df43bba..0bbd1a4 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -216,8 +216,8 @@
  * \c SIGUSR1 restarts.
  *
  * This structure is initialized at the top of the \c
- * tunnel_point_to_point(), \c tunnel_server_udp(), and \c
- * tunnel_server_tcp() functions.  In other words, it is reset for every
+ * tunnel_point_to_point() and \c tunnel_server() \c
+ * functions.  In other words, it is reset for every
  * iteration of the \c main() function's inner \c SIGUSR1 loop.
  */
 struct context_2
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6b2dfa5..511ce05 100644
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
+        for (int i = 0; i < o->ce.local_list->len; i++)
+        {
+            setenv_local_entry(es, o->ce.local_list->array[i], i+1);
+        }
+    }
+
     if (!o->pull)
     {
         setenv_dns_options(&o->dns_options, es);
@@ -1725,12 +1739,17 @@
 static void
 show_connection_entry(const struct connection_entry *o)
 {
-    msg(D_SHOW_PARMS, "  proto = %s", proto2ascii(o->proto, o->af, false));
+    /* Display the global proto only in client mode or with no '--local'*/
+    if (o->local_list->len == 1)
+    {
+        msg(D_SHOW_PARMS, "  proto = %s", proto2ascii(o->proto, o->af, false));
+    }
+
     msg(D_SHOW_PARMS, "  Local Sockets:");
     for (int i = 0; i < o->local_list->len; i++)
     {
-        msg(D_SHOW_PARMS, "    [%s]:%s", o->local_list->array[i]->local,
-            o->local_list->array[i]->port);
+        msg(D_SHOW_PARMS, "    [%s]:%s-%s", o->local_list->array[i]->local,
+            o->local_list->array[i]->port, proto2ascii(o->local_list->array[i]->proto, o->af, false));
     }
     SHOW_STR(remote);
     SHOW_STR(remote_port);
@@ -2205,6 +2224,7 @@
     }
 
     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);
+    e->proto = PROTO_NONE;
     l->array[l->len++] = e;
 
     return e;
@@ -2471,7 +2491,7 @@
     {
         struct local_entry *le = ce->local_list->array[i];
 
-        if (proto_is_net(ce->proto)
+        if (proto_is_net(le->proto)
             && string_defined_equal(le->local, ce->remote)
             && string_defined_equal(le->port, ce->remote_port))
         {
@@ -3176,14 +3196,16 @@
         if (ce->proto == PROTO_TCP)
         {
             ce->proto = PROTO_TCP_SERVER;
+            o->ce.proto = ce->proto;
         }
     }
 
-    if (o->client)
+    if (o->mode != MODE_SERVER)
     {
         if (ce->proto == PROTO_TCP)
         {
             ce->proto = PROTO_TCP_CLIENT;
+            o->ce.proto = ce->proto;
         }
     }
 
@@ -3325,13 +3347,19 @@
 }
 
 static void
-options_postprocess_mutate_le(struct connection_entry *ce, struct local_entry *le)
+options_postprocess_mutate_le(struct connection_entry *ce, struct local_entry *le, int mode)
 {
     /* use the global port if none is specified */
     if (!le->port)
     {
         le->port = ce->local_port;
     }
+    /* use the global proto if none is specified and
+     * allow proto bindings on server mode only */
+    if (!le->proto || mode == MODE_POINT_TO_POINT)
+    {
+        le->proto = ce->proto;
+    }
 }
 
 #ifdef _WIN32
@@ -3779,7 +3807,19 @@
     {
         for (i = 0; i < o->ce.local_list->len; i++)
         {
-            options_postprocess_mutate_le(&o->ce, o->ce.local_list->array[i]);
+            options_postprocess_mutate_le(&o->ce, o->ce.local_list->array[i], o->mode);
+        }
+
+        for (int i = 0; i < o->ce.local_list->len; i++)
+        {
+            if (o->ce.local_list->array[i]->proto == PROTO_TCP)
+            {
+                o->ce.local_list->array[i]->proto = PROTO_TCP_SERVER;
+            }
+            else if (o->ce.local_list->array[i]->proto == PROTO_NONE)
+            {
+                o->ce.local_list->array[i]->proto = o->ce.proto;
+            }
         }
     }
     else
@@ -3789,6 +3829,7 @@
         struct local_entry *e = alloc_local_entry(&o->ce, M_USAGE, &o->gc);
         ASSERT(e);
         e->port = o->ce.local_port;
+        e->proto = o->ce.proto;
     }
 
     /* use the same listen list for every outgoing connection */
@@ -6191,7 +6232,7 @@
         VERIFY_PERMISSION(OPT_P_UP);
         options->ifconfig_nowarn = true;
     }
-    else if (streq(p[0], "local") && p[1] && !p[3])
+    else if (streq(p[0], "local") && p[1] && !p[4])
     {
         struct local_entry *e;
 
@@ -6212,6 +6253,11 @@
         {
             e->port = p[2];
         }
+
+        if (p[3])
+        {
+            e->proto = ascii2proto(p[3]);
+        }
     }
     else if (streq(p[0], "remote-random") && !p[1])
     {
@@ -9621,3 +9667,37 @@
 err:
     gc_free(&gc);
 }
+
+bool
+has_udp_in_local_list(const struct options *options)
+{
+    if (options->ce.local_list)
+    {
+        for (int i = 0; i < options->ce.local_list->len; i++)
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
+        for (int i = 0; i < options->ce.local_list->len; i++)
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
index 79ee65b..7c0f3d0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1888,11 +1888,31 @@
     struct options *o = &c->options;
     ASSERT(sock);
 
+    const char *host = o->ce.local_list->array[sock_index]->local;
+    const char *port = o->ce.local_list->array[sock_index]->port;
+    int proto = o->ce.local_list->array[sock_index]->proto;
     const char *remote_host = o->ce.remote;
     const char *remote_port = o->ce.remote_port;
 
-    sock->local_host = o->ce.local_list->array[sock_index]->local;
-    sock->local_port = o->ce.local_list->array[sock_index]->port;
+    if (c->mode == CM_CHILD_TCP || c->mode == CM_CHILD_UDP)
+    {
+        struct link_socket *tmp_sock = NULL;
+        if (c->mode == CM_CHILD_TCP)
+        {
+            tmp_sock = (struct link_socket *)c->c2.accept_from;
+        }
+        else if (c->mode == CM_CHILD_UDP)
+        {
+            tmp_sock = c->c2.link_sockets[0];
+        }
+
+        host = tmp_sock->local_host;
+        port = tmp_sock->local_port;
+        proto = tmp_sock->info.proto;
+    }
+
+    sock->local_host = host;
+    sock->local_port = port;
     sock->remote_host = remote_host;
     sock->remote_port = remote_port;
     sock->dns_cache = c->c1.dns_cache;
@@ -1920,7 +1940,7 @@
 
     sock->mark = o->mark;
     sock->bind_dev = o->bind_dev;
-    sock->info.proto = o->ce.proto;
+    sock->info.proto = proto;
     sock->info.af = o->ce.af;
     sock->info.remote_float = o->ce.remote_float;
     sock->info.lsa = &c->c1.link_socket_addrs[sock_index];
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

