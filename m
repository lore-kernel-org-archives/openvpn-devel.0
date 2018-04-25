From: Antonio Quartulli <a@...2181...>
Date: Thu, 26 Apr 2018 03:57:19 +0800
Message-Id: <20180425195722.20744-6-a@...2181...>
In-Reply-To: <20180425195722.20744-1-a@...2181...>
References: <20180425195722.20744-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 5/8] allow tcp/udp server to listen on
 multiple ports at the same time
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

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/event.h          |   1 +
 src/openvpn/forward-inline.h |  15 ++-
 src/openvpn/forward.c        |  51 ++++++---
 src/openvpn/forward.h        |  18 ++--
 src/openvpn/init.c           | 197 +++++++++++++++++++++++------------
 src/openvpn/init.h           |   3 +-
 src/openvpn/mtcp.c           |  57 ++++++----
 src/openvpn/mudp.c           |  19 +++-
 src/openvpn/mudp.h           |   6 +-
 src/openvpn/multi.c          |  24 +++--
 src/openvpn/multi.h          |  14 ++-
 src/openvpn/openvpn.c        |   2 +-
 src/openvpn/openvpn.h        |   9 +-
 src/openvpn/ping-inline.h    |   2 +-
 src/openvpn/socket.c         |  13 +++
 src/openvpn/socket.h         |   6 +-
 16 files changed, 289 insertions(+), 148 deletions(-)

diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index fd0ede04..2b9c1b58 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -100,6 +100,7 @@ typedef enum {
 struct event_arg
 {
     event_arg_t type;
+    bool pending; /* in UDP/P2P mode marks sockets waiting for processing */
     union {
         struct multi_instance *mi; /* if type = EVENT_ARG_MULTI_INSTANCE */
         struct link_socket *ls; /* if type = EVENT_ARG_LINK_SOCKET */
diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
index feb0ba70..29751a1b 100644
--- a/src/openvpn/forward-inline.h
+++ b/src/openvpn/forward-inline.h
@@ -55,7 +55,8 @@ check_tls_errors(struct context *c)
 
     if (c->c2.tls_multi && c->c2.tls_exit_signal)
     {
-        if (link_socket_connection_oriented(c->c2.link_socket))
+        /* all sockets are of the same type, so just check the first one */
+        if (link_socket_connection_oriented(c->c2.link_sockets[0]))
         {
             if (c->c2.tls_multi->n_soft_errors)
             {
@@ -254,16 +255,21 @@ context_reschedule_sec(struct context *c, int sec)
     }
 }
 
+/*
+ * This function is invoked only on single-link contexts
+ * (i.e. p2p or child contexts), therefore we can explicitly
+ * work on the first socket
+ */
 static inline struct link_socket_info *
 get_link_socket_info(struct context *c)
 {
-    if (c->c2.link_socket_info)
+    if (c->c2.link_socket_infos && c->c2.link_socket_infos[0])
     {
-        return c->c2.link_socket_info;
+        return c->c2.link_socket_infos[0];
     }
     else
     {
-        return &c->c2.link_socket->info;
+        return &c->c2.link_sockets[0]->info;
     }
 }
 
@@ -330,6 +336,7 @@ io_wait(struct context *c, const unsigned int flags)
     }
 }
 
+/* invoked only on single-link instances */
 #define CONNECTION_ESTABLISHED(c) (get_link_socket_info(c)->connection_established)
 
 #endif /* EVENT_INLINE_H */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 1b5dad9b..76c73a6d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -58,12 +58,18 @@ const char *
 wait_status_string(struct context *c, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(64, gc);
-    buf_printf(&out, "I/O WAIT %s|%s|%s|%s %s",
+    int i;
+
+    buf_printf(&out, "I/O WAIT %s|%s| %s",
                tun_stat(c->c1.tuntap, EVENT_READ, gc),
                tun_stat(c->c1.tuntap, EVENT_WRITE, gc),
-               socket_stat(c->c2.link_socket, EVENT_READ, gc),
-               socket_stat(c->c2.link_socket, EVENT_WRITE, gc),
                tv_string(&c->c2.timeval, gc));
+    for (i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        buf_printf(&out, "\n %s|%s",
+                   socket_stat(c->c2.link_sockets[i], EVENT_READ, gc),
+                   socket_stat(c->c2.link_sockets[i], EVENT_WRITE, gc));
+    }
     return BSTR(&out);
 }
 
@@ -396,6 +402,7 @@ check_status_file_dowork(struct context *c)
 #ifdef ENABLE_FRAGMENT
 /*
  * Should we deliver a datagram fragment to remote?
+ * c is expected to be a single-link context (p2p or child)
  */
 void
 check_fragment_dowork(struct context *c)
@@ -405,7 +412,7 @@ check_fragment_dowork(struct context *c)
     /* OS MTU Hint? */
     if (lsi->mtu_changed)
     {
-        frame_adjust_path_mtu(&c->c2.frame_fragment, c->c2.link_socket->mtu,
+        frame_adjust_path_mtu(&c->c2.frame_fragment, c->c2.link_sockets[0]->mtu,
                               c->options.ce.proto);
         lsi->mtu_changed = false;
     }
@@ -895,7 +902,9 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
         decrypt_status = openvpn_decrypt(&c->c2.buf, c->c2.buffers->decrypt_buf,
                                          co, &c->c2.frame, ad_start);
 
-        if (!decrypt_status && link_socket_connection_oriented(c->c2.link_socket))
+        if (!decrypt_status
+            /* all sockets are of the same type, so just check the first one */
+            && link_socket_connection_oriented(c->c2.link_sockets[0]))
         {
             /* decryption errors are fatal in TCP mode */
             register_signal(c, SIGUSR1, "decryption-error"); /* SOFT-SIGUSR1 -- decryption error in TCP mode */
@@ -1156,7 +1165,7 @@ drop_if_recursive_routing(struct context *c, struct buffer *buf)
  */
 
 void
-process_incoming_tun(struct context *c)
+process_incoming_tun(struct context *c, struct link_socket *out_ls)
 {
     struct gc_arena gc = gc_new();
 
@@ -1187,7 +1196,8 @@ process_incoming_tun(struct context *c)
          * The --passtos and --mssfix options require
          * us to examine the IP header (IPv4 or IPv6).
          */
-        process_ip_header(c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT, &c->c2.buf);
+        process_ip_header(c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT, &c->c2.buf,
+                          out_ls);
 
 #ifdef PACKET_TRUNCATION_CHECK
         /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
@@ -1209,7 +1219,8 @@ process_incoming_tun(struct context *c)
 }
 
 void
-process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
+process_ip_header(struct context *c, unsigned int flags, struct buffer *buf,
+                  struct link_socket *ls)
 {
     if (!c->options.ce.mssfix)
     {
@@ -1251,7 +1262,7 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
                 /* extract TOS from IP header */
                 if (flags & PIPV4_PASSTOS)
                 {
-                    link_socket_extract_tos(c->c2.link_socket, &ipbuf);
+                    link_socket_extract_tos(ls, &ipbuf);
                 }
 #endif
 
@@ -1445,7 +1456,7 @@ process_outgoing_link(struct context *c, struct link_socket *ls)
  */
 
 void
-process_outgoing_tun(struct context *c)
+process_outgoing_tun(struct context *c, struct link_socket *in_ls)
 {
     struct gc_arena gc = gc_new();
 
@@ -1464,7 +1475,8 @@ process_outgoing_tun(struct context *c)
      * The --mssfix option requires
      * us to examine the IP header (IPv4 or IPv6).
      */
-    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIENT_NAT|PIPV4_OUTGOING, &c->c2.to_tun);
+    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIENT_NAT|PIPV4_OUTGOING, &c->c2.to_tun,
+                      in_ls);
 
     if (c->c2.to_tun.len <= MAX_RW_SIZE_TUN(&c->c2.frame))
     {
@@ -1616,6 +1628,7 @@ io_wait_dowork(struct context *c, const unsigned int flags)
 #ifdef ENABLE_ASYNC_PUSH
     static int file_shift = 8;     /* listening inotify events */
 #endif
+    int i;
 
     /*
      * Decide what kind of events we want to wait for.
@@ -1714,8 +1727,11 @@ io_wait_dowork(struct context *c, const unsigned int flags)
     /*
      * Configure event wait based on socket, tuntap flags.
      */
-    socket_set(c->c2.link_socket, c->c2.event_set, socket,
-               &c->c2.link_socket->ev_arg, NULL);
+    for (i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        socket_set(c->c2.link_sockets[i], c->c2.event_set, socket,
+                   &c->c2.link_sockets[i]->ev_arg, NULL);
+    }
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL);
 
 #ifdef ENABLE_MANAGEMENT
@@ -1747,7 +1763,7 @@ io_wait_dowork(struct context *c, const unsigned int flags)
 
     if (!c->sig->signal_received)
     {
-        if (!(flags & IOW_CHECK_RESIDUAL) || !socket_read_residual(c->c2.link_socket))
+        if (!(flags & IOW_CHECK_RESIDUAL) || !sockets_read_residual(c))
         {
             int status;
 
@@ -1786,6 +1802,9 @@ io_wait_dowork(struct context *c, const unsigned int flags)
                         }
 
                         shift = socket_shift;
+                        /* mark socket so that the multi code knows where we
+                         * have pending i/o */
+                        ev_arg->pending = true;
                     }
                     else
                     {
@@ -1839,7 +1858,7 @@ process_io(struct context *c, struct link_socket *ls)
     /* TUN device ready to accept write */
     else if (status & TUN_WRITE)
     {
-        process_outgoing_tun(c);
+        process_outgoing_tun(c, ls);
     }
     /* Incoming data on TCP/UDP port */
     else if (status & SOCKET_READ)
@@ -1856,7 +1875,7 @@ process_io(struct context *c, struct link_socket *ls)
         read_incoming_tun(c);
         if (!IS_SIG(c))
         {
-            process_incoming_tun(c);
+            process_incoming_tun(c, ls);
         }
     }
 }
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 16639f75..45f8cc59 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -227,10 +227,12 @@ void read_incoming_tun(struct context *c);
  *
  * If an error occurs, it is logged and the packet is dropped.
  *
- * @param c - The context structure of the VPN tunnel associated with the
- *     packet.
+ * @param c       The context structure of the VPN tunnel associated with
+ *                the packet.
+ * @param out_ls  Socket that will be used to send out the packet.
+ *
  */
-void process_incoming_tun(struct context *c);
+void process_incoming_tun(struct context *c, struct link_socket *out_ls);
 
 
 /**
@@ -242,10 +244,11 @@ void process_incoming_tun(struct context *c);
  *
  * If an error occurs, it is logged and the packet is dropped.
  *
- * @param c - The context structure of the VPN tunnel associated with
- *     the packet.
+ * @param c      The context structure of the VPN tunnel associated
+ *               with the packet.
+ * @param in_ls  Socket where the packet was received.
  */
-void process_outgoing_tun(struct context *c);
+void process_outgoing_tun(struct context *c, struct link_socket *in_ls);
 
 
 /**************************************************************************/
@@ -258,7 +261,8 @@ bool send_control_channel_string(struct context *c, const char *str, int msgleve
 #define PIPV4_EXTRACT_DHCP_ROUTER (1<<3)
 #define PIPV4_CLIENT_NAT      (1<<4)
 
-void process_ip_header(struct context *c, unsigned int flags, struct buffer *buf);
+void process_ip_header(struct context *c, unsigned int flags, struct buffer *buf,
+                       struct link_socket *ls);
 
 #if P2MP
 void schedule_exit(struct context *c, const int n_seconds, const int signal);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 36c1a4c4..a2b474c8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -440,11 +440,11 @@ next_connection_entry(struct context *c)
         {
             /* Check if there is another resolved address to try for
              * the current connection */
-            if (c->c1.link_socket_addr.current_remote
-                && c->c1.link_socket_addr.current_remote->ai_next)
+            if (c->c1.link_socket_addrs[0].current_remote
+                && c->c1.link_socket_addrs[0].current_remote->ai_next)
             {
-                c->c1.link_socket_addr.current_remote =
-                    c->c1.link_socket_addr.current_remote->ai_next;
+                c->c1.link_socket_addrs[0].current_remote =
+                    c->c1.link_socket_addrs[0].current_remote->ai_next;
             }
             else
             {
@@ -455,13 +455,13 @@ next_connection_entry(struct context *c)
                 if (!c->options.persist_remote_ip)
                 {
                     /* close_instance should have cleared the addrinfo objects */
-                    ASSERT(c->c1.link_socket_addr.current_remote == NULL);
-                    ASSERT(c->c1.link_socket_addr.remote_list == NULL);
+                    ASSERT(c->c1.link_socket_addrs[0].current_remote == NULL);
+                    ASSERT(c->c1.link_socket_addrs[0].remote_list == NULL);
                 }
                 else
                 {
-                    c->c1.link_socket_addr.current_remote =
-                        c->c1.link_socket_addr.remote_list;
+                    c->c1.link_socket_addrs[0].current_remote =
+                        c->c1.link_socket_addrs[0].remote_list;
                 }
 
                 /*
@@ -611,6 +611,13 @@ uninit_proxy(struct context *c)
     uninit_proxy_dowork(c);
 }
 
+static void
+do_link_socket_addr_new(struct context *c)
+{
+    ALLOC_ARRAY_CLEAR_GC(c->c1.link_socket_addrs, struct link_socket_addr,
+                         c->c1.link_sockets_num, &c->gc);
+}
+
 void
 context_init_1(struct context *c)
 {
@@ -620,6 +627,10 @@ context_init_1(struct context *c)
 
     init_connection_list(c);
 
+    c->c1.link_sockets_num = 1;
+
+    do_link_socket_addr_new(c);
+
 #if defined(ENABLE_PKCS11)
     if (c->first_time)
     {
@@ -1531,7 +1542,7 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
         CLEAR(local);
         actual = &get_link_socket_info(c)->lsa->actual;
         remote = actual->dest;
-        getsockname(c->c2.link_socket->sd, &local.addr.sa, &sa_len);
+        getsockname(c->c2.link_sockets[0]->sd, &local.addr.sa, &sa_len);
 #if ENABLE_IP_PKTINFO
         if (!addr_defined(&local))
         {
@@ -1641,8 +1652,8 @@ do_init_tun(struct context *c)
                             c->options.ifconfig_ipv6_local,
                             c->options.ifconfig_ipv6_netbits,
                             c->options.ifconfig_ipv6_remote,
-                            c->c1.link_socket_addr.bind_local,
-                            c->c1.link_socket_addr.remote_list,
+                            c->c1.link_socket_addrs[0].bind_local,
+                            c->c1.link_socket_addrs[0].remote_list,
                             !c->options.ifconfig_nowarn,
                             c->c2.es);
 
@@ -1691,16 +1702,16 @@ do_open_tun(struct context *c)
     do_alloc_route_list(c);
 
     /* parse and resolve the route option list */
-    ASSERT(c->c2.link_socket);
+    ASSERT(c->c2.link_sockets);
     if (c->options.routes && c->c1.route_list)
     {
         do_init_route_list(&c->options, c->c1.route_list,
-                           &c->c2.link_socket->info, c->c2.es);
+                           &c->c2.link_sockets[0]->info, c->c2.es);
     }
     if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
     {
         do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list,
-                                &c->c2.link_socket->info, c->c2.es);
+                                &c->c2.link_sockets[0]->info, c->c2.es);
     }
 
     /* do ifconfig */
@@ -2175,14 +2186,28 @@ do_deferred_options(struct context *c, const unsigned int found)
 
     if (found & OPT_P_SOCKBUF)
     {
+        int i;
+
         msg(D_PUSH, "OPTIONS IMPORT: --sndbuf/--rcvbuf options modified");
-        link_socket_update_buffer_sizes(c->c2.link_socket, c->options.rcvbuf, c->options.sndbuf);
+
+        for (i = 0; i < c->c1.link_sockets_num; i++)
+        {
+            link_socket_update_buffer_sizes(c->c2.link_sockets[i],
+                                            c->options.rcvbuf,
+                                            c->options.sndbuf);
+        }
     }
 
     if (found & OPT_P_SOCKFLAGS)
     {
+        int i;
+
         msg(D_PUSH, "OPTIONS IMPORT: --socket-flags option modified");
-        link_socket_update_flags(c->c2.link_socket, c->options.sockflags);
+        for (i = 0; i < c->c1.link_sockets_num; i++)
+        {
+            link_socket_update_flags(c->c2.link_sockets[i],
+                                     c->options.sockflags);
+        }
     }
 
     if (found & OPT_P_PERSIST)
@@ -3189,18 +3214,28 @@ do_init_fragment(struct context *c)
 static void
 do_link_socket_new(struct context *c)
 {
-    ASSERT(!c->c2.link_socket);
-    c->c2.link_socket = link_socket_new();
+    int i;
+
+    ASSERT(!c->c2.link_sockets);
+
+    ALLOC_ARRAY_GC(c->c2.link_sockets, struct link_socket *,
+                   c->c1.link_sockets_num, &c->c2.gc);
+
+    for (i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        c->c2.link_sockets[i] = link_socket_new();
+    }
     c->c2.link_socket_owned = true;
 }
 
 /*
- * bind the TCP/UDP socket
+ * bind TCP/UDP sockets
  */
 static void
 do_init_socket_1(struct context *c, const int mode)
 {
     unsigned int sockflags = c->options.sockflags;
+    int i;
 
 #if PORT_SHARE
     if (c->options.port_share_host && c->options.port_share_port)
@@ -3209,45 +3244,53 @@ do_init_socket_1(struct context *c, const int mode)
     }
 #endif
 
-    link_socket_init_phase1(c->c2.link_socket,
-                            c->options.ce.local,
-                            c->options.ce.local_port,
-                            c->options.ce.remote,
-                            c->options.ce.remote_port,
-                            c->c1.dns_cache,
-                            c->options.ce.proto,
-                            c->options.ce.af,
-                            c->options.ce.bind_ipv6_only,
-                            mode,
-                            c->c2.accept_from,
-                            c->c1.http_proxy,
-                            c->c1.socks_proxy,
+    for (i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        /* init each socket with its specific port */
+        link_socket_init_phase1(c->c2.link_sockets[i],
+                                c->options.ce.local,
+                                c->options.ce.local_port,
+                                c->options.ce.remote,
+                                c->options.ce.remote_port,
+                                c->c1.dns_cache,
+                                c->options.ce.proto,
+                                c->options.ce.af,
+                                c->options.ce.bind_ipv6_only,
+                                mode,
+                                c->c2.accept_from,
+                                c->c1.http_proxy,
+                                c->c1.socks_proxy,
 #ifdef ENABLE_DEBUG
-                            c->options.gremlin,
+                                c->options.gremlin,
 #endif
-                            c->options.ce.bind_local,
-                            c->options.ce.remote_float,
-                            c->options.inetd,
-                            &c->c1.link_socket_addr,
-                            c->options.ipchange,
-                            c->plugins,
-                            c->options.resolve_retry_seconds,
-                            c->options.ce.mtu_discover_type,
-                            c->options.rcvbuf,
-                            c->options.sndbuf,
-                            c->options.mark,
-                            &c->c2.server_poll_interval,
-                            sockflags);
+                                c->options.ce.bind_local,
+                                c->options.ce.remote_float,
+                                c->options.inetd,
+                                &c->c1.link_socket_addrs[i],
+                                c->options.ipchange,
+                                c->plugins,
+                                c->options.resolve_retry_seconds,
+                                c->options.ce.mtu_discover_type,
+                                c->options.rcvbuf,
+                                c->options.sndbuf,
+                                c->options.mark,
+                                &c->c2.server_poll_interval,
+                                sockflags);
+    }
 }
 
 /*
- * finalize the TCP/UDP socket
+ * finalize TCP/UDP sockets
  */
 static void
 do_init_socket_2(struct context *c)
 {
-    link_socket_init_phase2(c->c2.link_socket, &c->c2.frame,
-                            c->sig);
+    int i;
+
+    for (i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        link_socket_init_phase2(c->c2.link_sockets[i], &c->c2.frame, c->sig);
+    }
 }
 
 /*
@@ -3410,10 +3453,15 @@ do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
 static void
 do_close_link_socket(struct context *c)
 {
-    if (c->c2.link_socket && c->c2.link_socket_owned)
+    if (c->c2.link_sockets && c->c2.link_socket_owned)
     {
-        link_socket_close(c->c2.link_socket);
-        c->c2.link_socket = NULL;
+        int i;
+
+        for (i = 0; i < c->c1.link_sockets_num; i++)
+        {
+            link_socket_close(c->c2.link_sockets[i]);
+        }
+        c->c2.link_sockets = NULL;
     }
 
 
@@ -3424,27 +3472,33 @@ do_close_link_socket(struct context *c)
           && ( (c->options.persist_remote_ip)
                ||
                ( c->sig->source != SIG_SOURCE_HARD
-                 && ((c->c1.link_socket_addr.current_remote && c->c1.link_socket_addr.current_remote->ai_next)
+                 && ((c->c1.link_socket_addrs[0].current_remote
+                      && c->c1.link_socket_addrs[0].current_remote->ai_next)
                      || c->options.no_advance))
                )))
     {
-        clear_remote_addrlist(&c->c1.link_socket_addr, !c->options.resolve_in_advance);
+        clear_remote_addrlist(&c->c1.link_socket_addrs[0],
+                              !c->options.resolve_in_advance);
     }
 
     /* Clear the remote actual address when persist_remote_ip is not in use */
     if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_remote_ip))
     {
-        CLEAR(c->c1.link_socket_addr.actual);
+        CLEAR(c->c1.link_socket_addrs[0].actual);
     }
 
-    if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_local_ip))
+    for (int i = 0; i < c->c1.link_sockets_num; i++)
     {
-        if (c->c1.link_socket_addr.bind_local && !c->options.resolve_in_advance)
+        if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_local_ip))
         {
-            freeaddrinfo(c->c1.link_socket_addr.bind_local);
-        }
+            if (c->c1.link_socket_addrs[i].bind_local
+                && !c->options.resolve_in_advance)
+            {
+                freeaddrinfo(c->c1.link_socket_addrs[i].bind_local);
+            }
 
-        c->c1.link_socket_addr.bind_local = NULL;
+            c->c1.link_socket_addrs[i].bind_local = NULL;
+        }
     }
 }
 
@@ -4311,7 +4365,8 @@ close_instance(struct context *c)
 
 void
 inherit_context_child(struct context *dest,
-                      const struct context *src)
+                      const struct context *src,
+                      struct link_socket *ls)
 {
     CLEAR(*dest);
 
@@ -4345,7 +4400,7 @@ inherit_context_child(struct context *dest,
          * The CM_TOP context does the socket listen(),
          * and the CM_CHILD_TCP context does the accept().
          */
-        dest->c2.accept_from = src->c2.link_socket;
+        dest->c2.accept_from = ls;
     }
 
 #ifdef ENABLE_PLUGIN
@@ -4366,18 +4421,26 @@ inherit_context_child(struct context *dest,
     /* UDP inherits some extra things which TCP does not */
     if (dest->mode == CM_CHILD_UDP)
     {
+        ASSERT(!dest->c2.link_sockets);
+
         /* inherit buffers */
         dest->c2.buffers = src->c2.buffers;
 
+        ALLOC_ARRAY_GC(dest->c2.link_sockets, struct link_socket *, 1,
+                       &dest->gc);
+
         /* inherit parent link_socket and tuntap */
-        dest->c2.link_socket = src->c2.link_socket;
+        dest->c2.link_sockets[0] = ls;
 
-        ALLOC_OBJ_GC(dest->c2.link_socket_info, struct link_socket_info, &dest->gc);
-        *dest->c2.link_socket_info = src->c2.link_socket->info;
+        ALLOC_ARRAY_GC(dest->c2.link_socket_infos, struct link_socket_info *, 1,
+                       &dest->gc);
+        ALLOC_OBJ_GC(dest->c2.link_socket_infos[0], struct link_socket_info,
+                     &dest->gc);
+        *dest->c2.link_socket_infos[0] = ls->info;
 
         /* locally override some link_socket_info fields */
-        dest->c2.link_socket_info->lsa = &dest->c1.link_socket_addr;
-        dest->c2.link_socket_info->connection_established = false;
+        dest->c2.link_socket_infos[0]->lsa = &dest->c1.link_socket_addrs[0];
+        dest->c2.link_socket_infos[0]->connection_established = false;
     }
 }
 
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index c8ebe768..590dd81b 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -97,7 +97,8 @@ void reset_coarse_timers(struct context *c);
 bool do_deferred_options(struct context *c, const unsigned int found);
 
 void inherit_context_child(struct context *dest,
-                           const struct context *src);
+                           const struct context *src,
+                           struct link_socket *ls);
 
 void inherit_context_top(struct context *dest,
                          const struct context *src);
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 0be97ae4..78d127b6 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -120,13 +120,13 @@ pract(int action)
 }
 
 static struct multi_instance *
-multi_create_instance_tcp(struct multi_context *m)
+multi_create_instance_tcp(struct multi_context *m, struct link_socket *ls)
 {
     struct gc_arena gc = gc_new();
     struct multi_instance *mi = NULL;
     struct hash *hash = m->hash;
 
-    mi = multi_create_instance(m, NULL);
+    mi = multi_create_instance(m, NULL, ls);
     if (mi)
     {
         struct hash_element *he;
@@ -174,13 +174,16 @@ multi_tcp_instance_specific_init(struct multi_context *m, struct multi_instance
     /* buffer for queued TCP socket output packets */
     mi->tcp_link_out_deferred = mbuf_init(m->top.options.n_bcast_buf);
 
-    ASSERT(mi->context.c2.link_socket);
-    ASSERT(mi->context.c2.link_socket->info.lsa);
-    ASSERT(mi->context.c2.link_socket->mode == LS_MODE_TCP_ACCEPT_FROM);
-    ASSERT(mi->context.c2.link_socket->info.lsa->actual.dest.addr.sa.sa_family == AF_INET
-           || mi->context.c2.link_socket->info.lsa->actual.dest.addr.sa.sa_family == AF_INET6
+    ASSERT(mi->context.c2.link_sockets);
+    ASSERT(mi->context.c2.link_sockets[0]);
+    ASSERT(mi->context.c2.link_sockets[0]->info.lsa);
+    ASSERT(mi->context.c2.link_sockets[0]->mode == LS_MODE_TCP_ACCEPT_FROM);
+    ASSERT(mi->context.c2.link_sockets[0]->info.lsa->actual.dest.addr.sa.sa_family == AF_INET
+           || mi->context.c2.link_sockets[0]->info.lsa->actual.dest.addr.sa.sa_family == AF_INET6
            );
-    if (!mroute_extract_openvpn_sockaddr(&mi->real, &mi->context.c2.link_socket->info.lsa->actual.dest, true))
+    if (!mroute_extract_openvpn_sockaddr(&mi->real,
+                                         &mi->context.c2.link_sockets[0]->info.lsa->actual.dest,
+                                         true))
     {
         msg(D_MULTI_ERRORS, "MULTI TCP: TCP client address is undefined");
         return false;
@@ -239,7 +242,7 @@ multi_tcp_free(struct multi_tcp *mtcp)
 void
 multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instance *mi)
 {
-    struct link_socket *ls = mi->context.c2.link_socket;
+    struct link_socket *ls = mi->context.c2.link_sockets[0];
     if (ls && mi->socket_set_called)
     {
         event_del(mtcp->es, socket_event_handle(ls));
@@ -253,7 +256,7 @@ multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi
     if (mi)
     {
         mi->socket_set_called = true;
-        socket_set(mi->context.c2.link_socket,
+        socket_set(mi->context.c2.link_sockets[0],
                    m->mtcp->es,
                    mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,
                    &mi->ev_arg,
@@ -265,9 +268,14 @@ static inline int
 multi_tcp_wait(const struct context *c,
                struct multi_tcp *mtcp)
 {
-    int status;
-    socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
-                                 &c->c2.link_socket->ev_arg);
+    int status, i;
+
+    for (i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        socket_set_listen_persistent(c->c2.link_sockets[i], mtcp->es,
+                                     &c->c2.link_sockets[i]->ev_arg);
+    }
+
     tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwflags);
 #ifdef ENABLE_MANAGEMENT
     if (management)
@@ -466,16 +474,18 @@ multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int
         case TA_SOCKET_READ:
         case TA_SOCKET_READ_RESIDUAL:
             ASSERT(mi);
-            ASSERT(mi->context.c2.link_socket);
+            ASSERT(mi->context.c2.link_sockets);
+            ASSERT(mi->context.c2.link_sockets[0]);
             set_prefix(mi);
-            read_incoming_link(&mi->context, mi->context.c2.link_socket);
+            read_incoming_link(&mi->context, mi->context.c2.link_sockets[0]);
             clear_prefix();
             if (!IS_SIG(&mi->context))
             {
-                multi_process_incoming_link(m, mi, mpp_flags);
+                multi_process_incoming_link(m, mi, mpp_flags,
+                                            mi->context.c2.link_sockets[0]);
                 if (!IS_SIG(&mi->context))
                 {
-                    stream_buf_read_setup(mi->context.c2.link_socket);
+                    stream_buf_read_setup(mi->context.c2.link_sockets[0]);
                 }
             }
             break;
@@ -551,7 +561,7 @@ multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act
             break;
 
         case MTP_NONE:
-            if (mi && socket_read_residual(c->c2.link_socket))
+            if (mi && sockets_read_residual(c))
             {
                 newaction = TA_SOCKET_READ_RESIDUAL;
             }
@@ -706,9 +716,14 @@ multi_tcp_process_io(struct multi_context *m)
                     break;
                 /* new incoming TCP client attempting to connect? */
                 case EVENT_ARG_LINK_SOCKET:
-                    ASSERT(m->top.c2.link_socket);
-                    socket_reset_listen_persistent(m->top.c2.link_socket);
-                    mi = multi_create_instance_tcp(m);
+                    if (!ev_arg->u.ls)
+                    {
+                        msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null socket");
+                        break;
+                    }
+
+                    socket_reset_listen_persistent(ev_arg->u.ls);
+                    mi = multi_create_instance_tcp(m, ev_arg->u.ls);
                     if (mi)
                     {
                         multi_tcp_action(m, mi, TA_INITIAL, false);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 80efefb3..bfe24c01 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -48,7 +48,8 @@
  */
 
 struct multi_instance *
-multi_get_create_instance_udp(struct multi_context *m, bool *floated)
+multi_get_create_instance_udp(struct multi_context *m, bool *floated,
+                              struct link_socket *ls)
 {
     struct gc_arena gc = gc_new();
     struct mroute_addr real;
@@ -102,7 +103,7 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
             {
                 if (frequency_limit_event_allowed(m->new_connection_limiter))
                 {
-                    mi = multi_create_instance(m, &real);
+                    mi = multi_create_instance(m, &real, ls);
                     if (mi)
                     {
                         int i;
@@ -227,10 +228,18 @@ multi_process_io_udp(struct multi_context *m)
     /* Incoming data on UDP port */
     else if (status & SOCKET_READ)
     {
-        read_incoming_link(&m->top, m->top.c2.link_socket);
-        if (!IS_SIG(&m->top))
+        int i;
+        for (i = 0; i < m->top.c1.link_sockets_num; i++)
         {
-            multi_process_incoming_link(m, NULL, mpp_flags);
+            if (!m->top.c2.link_sockets[i]->ev_arg.pending)
+                continue;
+
+            read_incoming_link(&m->top, m->top.c2.link_sockets[i]);
+            if (!IS_SIG(&m->top))
+            {
+                multi_process_incoming_link(m, NULL, mpp_flags,
+                                            m->top.c2.link_sockets[i]);
+            }
         }
     }
     /* Incoming data on TUN device */
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 7e311519..3ab442ba 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -58,13 +58,15 @@ void tunnel_server_udp(struct context *top);
  * it.  If no entry exists, this function handles its creation, and if
  * successful, returns the newly created instance.
  *
- * @param m            - The single multi_context structure.
+ * @param m           - The single multi_context structure.
+ * @param ls          - Listening socket where this instance is connecting to
  *
  * @return A pointer to a multi_instance if one already existed for the
  *     packet's source address or if one was a newly created successfully.
  *      NULL if one did not yet exist and a new one was not created.
  */
-struct multi_instance *multi_get_create_instance_udp(struct multi_context *m, bool *floated);
+struct multi_instance *multi_get_create_instance_udp(struct multi_context *m, bool *floated,
+                                                     struct link_socket *ls);
 
 #endif
 #endif
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f877c060..a6534c16 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -765,7 +765,8 @@ multi_uninit(struct multi_context *m)
  * Create a client instance object for a newly connected client.
  */
 struct multi_instance *
-multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
+multi_create_instance(struct multi_context *m, const struct mroute_addr *real,
+                      struct link_socket *ls)
 {
     struct gc_arena gc = gc_new();
     struct multi_instance *mi;
@@ -789,7 +790,7 @@ multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
     }
 
     mi->did_open_context = true;
-    inherit_context_child(&mi->context, &m->top);
+    inherit_context_child(&mi->context, &m->top, ls);
     if (IS_SIG(&mi->context))
     {
         goto err;
@@ -2409,7 +2410,8 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
 }
 
 void
-multi_process_float(struct multi_context *m, struct multi_instance *mi)
+multi_process_float(struct multi_context *m, struct multi_instance *mi,
+                    struct link_socket *ls)
 {
     struct mroute_addr real;
     struct hash *hash = m->hash;
@@ -2465,8 +2467,8 @@ multi_process_float(struct multi_context *m, struct multi_instance *mi)
     mi->context.c2.to_link_addr = &mi->context.c2.from;
 
     /* inherit parent link_socket and link_socket_info */
-    mi->context.c2.link_socket = m->top.c2.link_socket;
-    mi->context.c2.link_socket_info->lsa->actual = m->top.c2.from;
+    mi->context.c2.link_sockets[0] = ls;
+    mi->context.c2.link_socket_infos[0]->lsa->actual = m->top.c2.from;
 
     tls_update_remote_addr(mi->context.c2.tls_multi, &mi->context.c2.from);
 
@@ -2486,7 +2488,8 @@ done:
  * i.e. client -> server direction.
  */
 bool
-multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance, const unsigned int mpp_flags)
+multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance, const unsigned int mpp_flags,
+                            struct link_socket *ls)
 {
     struct gc_arena gc = gc_new();
 
@@ -2507,7 +2510,7 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TCP/UDP -> TUN [%d]\n", BLEN(&m->top.c2.buf));
 #endif
-        multi_set_pending(m, multi_get_create_instance_udp(m, &floated));
+        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, ls));
     }
     else
     {
@@ -2547,7 +2550,7 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
             {
                 if (floated)
                 {
-                    multi_process_float(m, m->pending);
+                    multi_process_float(m, m->pending, ls);
                 }
 
                 process_incoming_link_part2(c, lsi, orig_buf);
@@ -2816,7 +2819,7 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
                     }
 
                     /* encrypt in instance context */
-                    process_incoming_tun(c);
+                    process_incoming_tun(c, c->c2.link_sockets[0]);
 
                     /* postprocess and set wakeup */
                     ret = multi_process_post(m, m->pending, mpp_flags);
@@ -2849,7 +2852,8 @@ multi_get_queue(struct mbuf_set *ms)
         {
             pip_flags |= PIP_MSSFIX;
         }
-        process_ip_header(&item.instance->context, pip_flags, &item.instance->context.c2.buf);
+        process_ip_header(&item.instance->context, pip_flags, &item.instance->context.c2.buf,
+                          item.instance->context.c2.link_sockets[0]);
         encrypt_sign(&item.instance->context, true);
         mbuf_free_buf(item.buffer);
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 5fb8402f..a7bb0852 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -238,7 +238,8 @@ void multi_top_init(struct multi_context *m, const struct context *top);
 
 void multi_top_free(struct multi_context *m);
 
-struct multi_instance *multi_create_instance(struct multi_context *m, const struct mroute_addr *real);
+struct multi_instance *multi_create_instance(struct multi_context *m, const struct mroute_addr *real,
+                                             struct link_socket *ls);
 
 void multi_close_instance(struct multi_context *m, struct multi_instance *mi, bool shutdown);
 
@@ -252,7 +253,8 @@ bool multi_process_timeout(struct multi_context *m, const unsigned int mpp_flags
  * existing peer. Updates multi_instance with new address,
  * updates hashtables in multi_context.
  */
-void multi_process_float(struct multi_context *m, struct multi_instance *mi);
+void multi_process_float(struct multi_context *m, struct multi_instance *mi,
+                         struct link_socket *ls);
 
 #define MPP_PRE_SELECT             (1<<0)
 #define MPP_CONDITIONAL_PRE_SELECT (1<<1)
@@ -307,8 +309,10 @@ bool multi_process_post(struct multi_context *m, struct multi_instance *mi, cons
  *                       when using TCP transport. Otherwise NULL, as is
  *                       the case when using UDP transport.
  * @param mpp_flags    - Fast I/O optimization flags.
+ * @param ls           - Socket where the packet was received.
  */
-bool multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance, const unsigned int mpp_flags);
+bool multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance, const unsigned int mpp_flags,
+                                 struct link_socket *ls);
 
 
 /**
@@ -624,7 +628,7 @@ multi_process_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags
            mi->context.c2.to_tun.len);
 #endif
     set_prefix(mi);
-    process_outgoing_tun(&mi->context);
+    process_outgoing_tun(&mi->context, mi->context.c2.link_sockets[0]);
     ret = multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
@@ -637,7 +641,7 @@ multi_process_outgoing_link_dowork(struct multi_context *m, struct multi_instanc
 {
     bool ret = true;
     set_prefix(mi);
-    process_outgoing_link(&mi->context, mi->context.c2.link_socket);
+    process_outgoing_link(&mi->context, mi->context.c2.link_sockets[0]);
     ret = multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index b52063a2..4cd6ecf1 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -115,7 +115,7 @@ tunnel_point_to_point(struct context *c)
         }
 
         /* process the I/O which triggered select */
-        process_io(c, c->c2.link_socket);
+        process_io(c, c->c2.link_sockets[0]);
         P2P_CHECK_SIG();
 
         perf_pop();
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index c5c767c0..17509d75 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -149,7 +149,8 @@ struct context_0
  */
 struct context_1
 {
-    struct link_socket_addr link_socket_addr;
+    int link_sockets_num;
+    struct link_socket_addr *link_socket_addrs;
     /**< Local and remote addresses on the
      *   external network. */
 
@@ -247,9 +248,11 @@ struct context_2
 
     unsigned int event_set_status;
 
-    struct link_socket *link_socket;     /* socket used for TCP/UDP connection to remote */
+    struct link_socket **link_sockets;
+    struct link_socket_info **link_socket_infos;
+
     bool link_socket_owned;
-    struct link_socket_info *link_socket_info;
+
     const struct link_socket *accept_from; /* possibly do accept() on a parent link_socket */
 
     struct link_socket_actual *to_link_addr;    /* IP address of remote */
diff --git a/src/openvpn/ping-inline.h b/src/openvpn/ping-inline.h
index 1a5c8bc3..d5f5d0d6 100644
--- a/src/openvpn/ping-inline.h
+++ b/src/openvpn/ping-inline.h
@@ -37,7 +37,7 @@ check_ping_restart(struct context *c)
         && event_timeout_trigger(&c->c2.ping_rec_interval,
                                  &c->c2.timeval,
                                  (!c->options.ping_timer_remote
-                                  || link_socket_actual_defined(&c->c1.link_socket_addr.actual))
+                                  || link_socket_actual_defined(&c->c1.link_socket_addrs[0].actual))
                                  ? ETT_DEFAULT : 15))
     {
         check_ping_restart_dowork(c);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 564948a2..84d828e6 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -54,6 +54,19 @@ const int proto_overhead[] = { /* indexed by PROTO_x */
     IPv6_TCP_HEADER_SIZE,
 };
 
+bool
+sockets_read_residual(const struct context *c)
+{
+    int i;
+
+    for (i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        if (c->c2.link_sockets[i]->stream_buf.residual_fully_formed)
+            return true;
+    }
+    return false;
+}
+
 /*
  * Convert sockflags/getaddr_flags into getaddr_flags
  */
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 46000246..c80a230d 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1220,11 +1220,7 @@ link_socket_set_tos(struct link_socket *ls)
  * Socket I/O wait functions
  */
 
-static inline bool
-socket_read_residual(const struct link_socket *s)
-{
-    return s && s->stream_buf.residual_fully_formed;
-}
+bool sockets_read_residual(const struct context *c);
 
 static inline event_t
 socket_event_handle(const struct link_socket *s)
-- 
2.17.0


