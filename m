From: Gert Doering <gert@...1296...>
Date: Mon, 30 Dec 2024 17:23:37 +0100
Message-ID: <20241230162338.21401-1-gert@...1296...>
In-Reply-To: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
References: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v11] Adapt socket handling to support
 listening on multiple sockets
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

From: Antonio Quartulli <a@...2181...>

    Introduce internal changes preparing the server to
    handle multiple sockets concurrently for both
    TCP and UDP protocols. While no user-visible
    features are implemented yet, these modifications
    are essential for enabling future functionality
    such as listening on multiple ports.

    Key changes are: converting link_socket from a
    single pointer to an array in various contexts,
    in order to be able to store multiple sockets
    at once.

Change-Id: Ia0a889e800f0b36aed770ee36e31afeec5df6084
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/434
This mail reflects revision 11 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index dcc80d3..8f2adb5 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -478,11 +478,11 @@
         return 0;
     }
 
-    struct link_socket *ls = c->c2.link_socket;
+    struct link_socket *sock = c->c2.link_sockets[0];
 
-    ASSERT(ls->info.connection_established);
+    ASSERT(sock->info.connection_established);
 
-    struct sockaddr *remoteaddr = &ls->info.lsa->actual.dest.addr.sa;
+    struct sockaddr *remoteaddr = &sock->info.lsa->actual.dest.addr.sa;
     struct tls_multi *multi = c->c2.tls_multi;
 #ifdef TARGET_FREEBSD
     /* In Linux in P2P mode the kernel automatically removes an existing peer
@@ -494,7 +494,7 @@
     }
 #endif
     int ret = dco_new_peer(&c->c1.tuntap->dco, multi->peer_id,
-                           c->c2.link_socket->sd, NULL, remoteaddr, NULL, NULL);
+                           c->c2.link_sockets[0]->sd, NULL, remoteaddr, NULL, NULL);
     if (ret < 0)
     {
         return ret;
@@ -527,12 +527,12 @@
 #if ENABLE_IP_PKTINFO
     struct context *c = &mi->context;
 
-    if (!proto_is_udp(c->c2.link_socket->info.proto) || !(c->options.sockflags & SF_USE_IP_PKTINFO))
+    if (!proto_is_udp(c->c2.link_sockets[0]->info.proto) || !(c->options.sockflags & SF_USE_IP_PKTINFO))
     {
         return false;
     }
 
-    struct link_socket_actual *actual = &c->c2.link_socket_info->lsa->actual;
+    struct link_socket_actual *actual = &c->c2.link_socket_infos[0]->lsa->actual;
 
     switch (actual->dest.addr.sa.sa_family)
     {
@@ -577,7 +577,7 @@
     int peer_id = c->c2.tls_multi->peer_id;
     struct sockaddr *remoteaddr, *localaddr = NULL;
     struct sockaddr_storage local = { 0 };
-    int sd = c->c2.link_socket->sd;
+    int sd = c->c2.link_sockets[0]->sd;
 
 
     if (c->mode == CM_CHILD_TCP)
@@ -587,8 +587,8 @@
     }
     else
     {
-        ASSERT(c->c2.link_socket_info->connection_established);
-        remoteaddr = &c->c2.link_socket_info->lsa->actual.dest.addr.sa;
+        ASSERT(c->c2.link_socket_infos[0]->connection_established);
+        remoteaddr = &c->c2.link_socket_infos[0]->lsa->actual.dest.addr.sa;
     }
 
     /* In server mode we need to fetch the remote addresses from the push config */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 2c72001..f3f3503 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -58,12 +58,17 @@
 wait_status_string(struct context *c, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(64, gc);
-    buf_printf(&out, "I/O WAIT %s|%s|%s|%s %s",
+
+    buf_printf(&out, "I/O WAIT %s|%s| %s",
                tun_stat(c->c1.tuntap, EVENT_READ, gc),
                tun_stat(c->c1.tuntap, EVENT_WRITE, gc),
-               socket_stat(c->c2.link_socket, EVENT_READ, gc),
-               socket_stat(c->c2.link_socket, EVENT_WRITE, gc),
                tv_string(&c->c2.timeval, gc));
+    for (int i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        buf_printf(&out, "\n %s|%s",
+                   socket_stat(c->c2.link_sockets[i], EVENT_READ, gc),
+                   socket_stat(c->c2.link_sockets[i], EVENT_WRITE, gc));
+    }
     return BSTR(&out);
 }
 
@@ -99,7 +104,7 @@
 {
     if (c->c2.tls_multi && c->c2.tls_exit_signal)
     {
-        if (link_socket_connection_oriented(c->c2.link_socket))
+        if (link_socket_connection_oriented(c->c2.link_sockets[0]))
         {
             if (c->c2.tls_multi->n_soft_errors)
             {
@@ -567,6 +572,7 @@
 #ifdef ENABLE_FRAGMENT
 /*
  * Should we deliver a datagram fragment to remote?
+ * c is expected to be a single-link context (p2p or child)
  */
 static void
 check_fragment(struct context *c)
@@ -1123,7 +1129,9 @@
         decrypt_status = openvpn_decrypt(&c->c2.buf, c->c2.buffers->decrypt_buf,
                                          co, &c->c2.frame, ad_start);
 
-        if (!decrypt_status && link_socket_connection_oriented(c->c2.link_socket))
+        if (!decrypt_status
+            /* on the instance context we have only one socket, so just check the first one */
+            && link_socket_connection_oriented(c->c2.link_sockets[0]))
         {
             /* decryption errors are fatal in TCP mode */
             register_signal(c->sig, SIGUSR1, "decryption-error"); /* SOFT-SIGUSR1 -- decryption error in TCP mode */
@@ -1451,7 +1459,7 @@
  */
 
 void
-process_incoming_tun(struct context *c)
+process_incoming_tun(struct context *c, struct link_socket *out_sock)
 {
     struct gc_arena gc = gc_new();
 
@@ -1484,7 +1492,7 @@
          */
         unsigned int flags = PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT
                              | PIPV6_ICMP_NOHOST_CLIENT;
-        process_ip_header(c, flags, &c->c2.buf);
+        process_ip_header(c, flags, &c->c2.buf, out_sock);
 
 #ifdef PACKET_TRUNCATION_CHECK
         /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
@@ -1645,7 +1653,8 @@
 }
 
 void
-process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
+process_ip_header(struct context *c, unsigned int flags, struct buffer *buf,
+                  struct link_socket *sock)
 {
     if (!c->options.ce.mssfix)
     {
@@ -1679,7 +1688,7 @@
             /* extract TOS from IP header */
             if (flags & PIPV4_PASSTOS)
             {
-                link_socket_extract_tos(c->c2.link_socket, &ipbuf);
+                link_socket_extract_tos(sock, &ipbuf);
             }
 #endif
 
@@ -1887,7 +1896,7 @@
  */
 
 void
-process_outgoing_tun(struct context *c)
+process_outgoing_tun(struct context *c, struct link_socket *in_sock)
 {
     /*
      * Set up for write() call to TUN/TAP
@@ -1904,9 +1913,8 @@
      * The --mssfix option requires
      * us to examine the IP header (IPv4 or IPv6).
      */
-    process_ip_header(c,
-                      PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIENT_NAT | PIP_OUTGOING,
-                      &c->c2.to_tun);
+    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIENT_NAT|PIP_OUTGOING, &c->c2.to_tun,
+                      in_sock);
 
     if (c->c2.to_tun.len <= c->c2.frame.buf.payload_size)
     {
@@ -2180,8 +2188,11 @@
     /*
      * Configure event wait based on socket, tuntap flags.
      */
-    socket_set(c->c2.link_socket, c->c2.event_set, socket,
-               &c->c2.link_socket->ev_arg, NULL);
+    for (int i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        socket_set(c->c2.link_sockets[i], c->c2.event_set, socket,
+                   &c->c2.link_sockets[i]->ev_arg, NULL);
+    }
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (socket & EVENT_READ && c->c2.did_open_tun)
@@ -2219,7 +2230,7 @@
 
     if (!c->sig->signal_received)
     {
-        if (!(flags & IOW_CHECK_RESIDUAL) || !socket_read_residual(c->c2.link_socket))
+        if (!(flags & IOW_CHECK_RESIDUAL) || !sockets_read_residual(c))
         {
             int status;
 
@@ -2311,7 +2322,7 @@
     /* TUN device ready to accept write */
     else if (status & TUN_WRITE)
     {
-        process_outgoing_tun(c);
+        process_outgoing_tun(c, sock);
     }
     /* Incoming data on TCP/UDP port */
     else if (status & SOCKET_READ)
@@ -2328,7 +2339,7 @@
         read_incoming_tun(c);
         if (!IS_SIG(c))
         {
-            process_incoming_tun(c);
+            process_incoming_tun(c, sock);
         }
     }
     else if (status & DCO_READ)
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 4cd470a..ca2a695 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -231,10 +231,12 @@
  *
  * If an error occurs, it is logged and the packet is dropped.
  *
- * @param c - The context structure of the VPN tunnel associated with the
- *     packet.
+ * @param c       The context structure of the VPN tunnel associated with
+ *                the packet.
+ * @param out_sock  Socket that will be used to send out the packet.
+ *
  */
-void process_incoming_tun(struct context *c);
+void process_incoming_tun(struct context *c, struct link_socket *out_sock);
 
 
 /**
@@ -246,10 +248,11 @@
  *
  * If an error occurs, it is logged and the packet is dropped.
  *
- * @param c - The context structure of the VPN tunnel associated with
- *     the packet.
+ * @param c      The context structure of the VPN tunnel associated
+ *               with the packet.
+ * @param in_sock  Socket where the packet was received.
  */
-void process_outgoing_tun(struct context *c);
+void process_outgoing_tun(struct context *c, struct link_socket *in_sock);
 
 
 /**************************************************************************/
@@ -304,20 +307,21 @@
 #define PIPV6_ICMP_NOHOST_SERVER        (1<<6)
 
 
-void process_ip_header(struct context *c, unsigned int flags, struct buffer *buf);
+void process_ip_header(struct context *c, unsigned int flags, struct buffer *buf,
+                       struct link_socket *sock);
 
 bool schedule_exit(struct context *c);
 
 static inline struct link_socket_info *
 get_link_socket_info(struct context *c)
 {
-    if (c->c2.link_socket_info)
+    if (c->c2.link_socket_infos)
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
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a23cb24..850cd12 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -536,12 +536,12 @@
         {
             /* Check if there is another resolved address to try for
              * the current connection */
-            if (c->c1.link_socket_addr.current_remote
-                && c->c1.link_socket_addr.current_remote->ai_next
+            if (c->c1.link_socket_addrs[0].current_remote
+                && c->c1.link_socket_addrs[0].current_remote->ai_next
                 && !c->options.advance_next_remote)
             {
-                c->c1.link_socket_addr.current_remote =
-                    c->c1.link_socket_addr.current_remote->ai_next;
+                c->c1.link_socket_addrs[0].current_remote =
+                    c->c1.link_socket_addrs[0].current_remote->ai_next;
             }
             else
             {
@@ -557,20 +557,20 @@
                      * skipped by management on the previous loop.
                      * If so, clear the addrinfo objects as close_instance does
                      */
-                    if (c->c1.link_socket_addr.remote_list)
+                    if (c->c1.link_socket_addrs[0].remote_list)
                     {
-                        clear_remote_addrlist(&c->c1.link_socket_addr,
+                        clear_remote_addrlist(&c->c1.link_socket_addrs[0],
                                               !c->options.resolve_in_advance);
                     }
 
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
 
                 int advance_count = 1;
@@ -735,6 +735,13 @@
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
@@ -744,6 +751,10 @@
 
     init_connection_list(c);
 
+    c->c1.link_sockets_num = 1;
+
+    do_link_socket_addr_new(c);
+
 #if defined(ENABLE_PKCS11)
     if (c->first_time)
     {
@@ -1644,7 +1655,7 @@
         CLEAR(local);
         actual = &get_link_socket_info(c)->lsa->actual;
         remote = actual->dest;
-        getsockname(c->c2.link_socket->sd, &local.addr.sa, &sa_len);
+        getsockname(c->c2.link_sockets[0]->sd, &local.addr.sa, &sa_len);
 #if ENABLE_IP_PKTINFO
         if (!addr_defined(&local))
         {
@@ -1770,8 +1781,8 @@
                             c->options.ifconfig_ipv6_local,
                             c->options.ifconfig_ipv6_netbits,
                             c->options.ifconfig_ipv6_remote,
-                            c->c1.link_socket_addr.bind_local,
-                            c->c1.link_socket_addr.remote_list,
+                            c->c1.link_socket_addrs[0].bind_local,
+                            c->c1.link_socket_addrs[0].remote_list,
                             !c->options.ifconfig_nowarn,
                             c->c2.es,
                             &c->net_ctx,
@@ -1954,17 +1965,16 @@
         do_alloc_route_list(c);
 
         /* parse and resolve the route option list */
-        ASSERT(c->c2.link_socket);
+        ASSERT(c->c2.link_sockets[0]);
         if (c->options.routes && c->c1.route_list)
         {
             do_init_route_list(&c->options, c->c1.route_list,
-                               &c->c2.link_socket->info, c->c2.es, &c->net_ctx);
+                               &c->c2.link_sockets[0]->info, c->c2.es, &c->net_ctx);
         }
         if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
         {
             do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list,
-                                    &c->c2.link_socket->info, c->c2.es,
-                                    &c->net_ctx);
+                                    &c->c2.link_sockets[0]->info, c->c2.es, &c->net_ctx);
         }
 
         /* do ifconfig */
@@ -1977,8 +1987,7 @@
                                                  c->options.dev_type,
                                                  c->options.dev_node,
                                                  &gc);
-            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es,
-                        &c->net_ctx);
+            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
         }
 
         /* possibly add routes */
@@ -1993,6 +2002,7 @@
         /* Store the old fd inside the fd so open_tun can use it */
         c->c1.tuntap->fd = oldtunfd;
 #endif
+
         if (dco_enabled(&c->options))
         {
             ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
@@ -2004,8 +2014,7 @@
         /* set the hardware address */
         if (c->options.lladdr)
         {
-            set_lladdr(&c->net_ctx, c->c1.tuntap->actual_name, c->options.lladdr,
-                       c->c2.es);
+            set_lladdr(&c->net_ctx, c->c1.tuntap->actual_name, c->options.lladdr, c->c2.es);
         }
 
         /* do ifconfig */
@@ -2486,7 +2495,7 @@
                 {
                     msg(M_NONFATAL, "dco-win doesn't yet support reopening TUN device");
                     /* prevent link_socket_close() from closing handle with WinSock API */
-                    c->c2.link_socket->sd = SOCKET_UNDEFINED;
+                    c->c2.link_sockets[0]->sd = SOCKET_UNDEFINED;
                     return false;
                 }
                 else
@@ -2709,13 +2718,23 @@
     if (found & OPT_P_SOCKBUF)
     {
         msg(D_PUSH, "OPTIONS IMPORT: --sndbuf/--rcvbuf options modified");
-        link_socket_update_buffer_sizes(c->c2.link_socket, c->options.rcvbuf, c->options.sndbuf);
+
+        for (int i = 0; i < c->c1.link_sockets_num; i++)
+        {
+            link_socket_update_buffer_sizes(c->c2.link_sockets[i],
+                                            c->options.rcvbuf,
+                                            c->options.sndbuf);
+        }
     }
 
     if (found & OPT_P_SOCKFLAGS)
     {
         msg(D_PUSH, "OPTIONS IMPORT: --socket-flags option modified");
-        link_socket_update_flags(c->c2.link_socket, c->options.sockflags);
+        for (int i = 0; i < c->c1.link_sockets_num; i++)
+        {
+            link_socket_update_flags(c->c2.link_sockets[i],
+                                     c->options.sockflags);
+        }
     }
 
     if (found & OPT_P_PERSIST)
@@ -3791,12 +3810,63 @@
 static void
 do_link_socket_new(struct context *c)
 {
-    ASSERT(!c->c2.link_socket);
-    c->c2.link_socket = link_socket_new();
+    ASSERT(!c->c2.link_sockets);
+
+    ALLOC_ARRAY_GC(c->c2.link_sockets, struct link_socket *,
+                   c->c1.link_sockets_num, &c->c2.gc);
+
+    for (int i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        c->c2.link_sockets[i] = link_socket_new();
+    }
     c->c2.link_socket_owned = true;
 }
 
 /*
+ * bind TCP/UDP sockets
+ */
+static void
+do_init_socket_phase1(struct context *c)
+{
+    for (int i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        int mode = LS_MODE_DEFAULT;
+
+        /* mode allows CM_CHILD_TCP
+         * instances to inherit acceptable fds
+         * from a top-level parent */
+        if (c->options.mode == MODE_SERVER)
+        {
+            /* initializing listening socket */
+            if (c->mode == CM_TOP)
+            {
+                mode = LS_MODE_TCP_LISTEN;
+            }
+            /* initializing socket to client */
+            else if (c->mode == CM_CHILD_TCP)
+            {
+                mode = LS_MODE_TCP_ACCEPT_FROM;
+            }
+        }
+
+        /* init each socket with its specific args */
+        link_socket_init_phase1(c, i, mode);
+    }
+}
+
+/*
+ * finalize TCP/UDP sockets
+ */
+static void
+do_init_socket_phase2(struct context *c)
+{
+    for (int i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        link_socket_init_phase2(c, c->c2.link_sockets[i]);
+    }
+}
+
+/*
  * Print MTU INFO
  */
 static void
@@ -3951,15 +4021,21 @@
     /* in dco-win case, link socket is a tun handle which is
      * closed in do_close_tun(). Set it to UNDEFINED so
      * we won't use WinSock API to close it. */
-    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_socket)
+    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_sockets)
     {
-        c->c2.link_socket->sd = SOCKET_UNDEFINED;
+        for (int i = 0; i < c->c1.link_sockets_num; i++)
+        {
+            c->c2.link_sockets[i]->sd = SOCKET_UNDEFINED;
+        }
     }
 
-    if (c->c2.link_socket && c->c2.link_socket_owned)
+    if (c->c2.link_sockets && c->c2.link_socket_owned)
     {
-        link_socket_close(c->c2.link_socket);
-        c->c2.link_socket = NULL;
+        for (int i = 0; i < c->c1.link_sockets_num; i++)
+        {
+            link_socket_close(c->c2.link_sockets[i]);
+        }
+        c->c2.link_sockets = NULL;
     }
 
 
@@ -3970,28 +4046,36 @@
           && ( (c->options.persist_remote_ip)
                ||
                ( c->sig->source != SIG_SOURCE_HARD
-                 && ((c->c1.link_socket_addr.current_remote
-                      && c->c1.link_socket_addr.current_remote->ai_next)
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
+        for (int i = 0; i < c->c1.link_sockets_num; i++)
+        {
+            CLEAR(c->c1.link_socket_addrs[i].actual);
+        }
     }
 
     if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_local_ip))
     {
-        if (c->c1.link_socket_addr.bind_local && !c->options.resolve_in_advance)
+        for (int i = 0; i < c->c1.link_sockets_num; i++)
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
 
@@ -4474,7 +4558,6 @@
 {
     const struct options *options = &c->options;
     const bool child = (c->mode == CM_CHILD_TCP || c->mode == CM_CHILD_UDP);
-    int link_socket_mode = LS_MODE_DEFAULT;
 
     /* init garbage collection level */
     gc_init(&c->c2.gc);
@@ -4515,21 +4598,6 @@
     /* map in current connection entry */
     next_connection_entry(c);
 
-    /* link_socket_mode allows CM_CHILD_TCP
-     * instances to inherit acceptable fds
-     * from a top-level parent */
-    if (c->options.ce.proto == PROTO_TCP_SERVER)
-    {
-        if (c->mode == CM_TOP)
-        {
-            link_socket_mode = LS_MODE_TCP_LISTEN;
-        }
-        else if (c->mode == CM_CHILD_TCP)
-        {
-            link_socket_mode = LS_MODE_TCP_ACCEPT_FROM;
-        }
-    }
-
     /* should we disable paging? */
     if (c->first_time && options->mlock)
     {
@@ -4672,7 +4740,7 @@
     /* bind the TCP/UDP socket */
     if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
     {
-        link_socket_init_phase1(c, link_socket_mode);
+        do_init_socket_phase1(c);
     }
 
     /* initialize tun/tap device object,
@@ -4715,15 +4783,18 @@
     /* finalize the TCP/UDP socket */
     if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
     {
-        link_socket_init_phase2(c);
+        do_init_socket_phase2(c);
 
 
         /* Update dynamic frame calculation as exact transport socket information
          * (IP vs IPv6) may be only available after socket phase2 has finished.
          * This is only needed for --static or no crypto, NCP will recalculate this
          * in tls_session_update_crypto_params (P2MP) */
-        frame_calculate_dynamic(&c->c2.frame, &c->c1.ks.key_type, &c->options,
-                                get_link_socket_info(c));
+        for (int i = 0; i < c->c1.link_sockets_num; i++)
+        {
+            frame_calculate_dynamic(&c->c2.frame, &c->c1.ks.key_type, &c->options,
+                                    &c->c2.link_sockets[i]->info);
+        }
     }
 
     /*
@@ -4851,7 +4922,8 @@
 
 void
 inherit_context_child(struct context *dest,
-                      const struct context *src)
+                      const struct context *src,
+                      struct link_socket *ls)
 {
     CLEAR(*dest);
 
@@ -4864,6 +4936,8 @@
 
     /* c1 init */
     packet_id_persist_init(&dest->c1.pid_persist);
+    dest->c1.link_sockets_num = 1;
+    do_link_socket_addr_new(dest);
 
     dest->c1.ks.key_type = src->c1.ks.key_type;
     /* inherit SSL context */
@@ -4888,7 +4962,7 @@
          * The CM_TOP context does the socket listen(),
          * and the CM_CHILD_TCP context does the accept().
          */
-        dest->c2.accept_from = src->c2.link_socket;
+        dest->c2.accept_from = ls;
     }
 
 #ifdef ENABLE_PLUGIN
@@ -4903,28 +4977,33 @@
      */
     dest->c1.tuntap = src->c1.tuntap;
 
+    /* UDP inherits some extra things which TCP does not */
+    if (dest->mode == CM_CHILD_UDP)
+    {
+        ASSERT(!dest->c2.link_sockets);
+
+        /* inherit buffers */
+        dest->c2.buffers = src->c2.buffers;
+
+        ALLOC_ARRAY_GC(dest->c2.link_sockets, struct link_socket *, 1, &dest->gc);
+
+        /* inherit parent link_socket and tuntap */
+        dest->c2.link_sockets[0] = ls;
+
+        ALLOC_ARRAY_GC(dest->c2.link_socket_infos, struct link_socket_info *, 1, &dest->gc);
+        ALLOC_OBJ_GC(dest->c2.link_socket_infos[0], struct link_socket_info, &dest->gc);
+        *dest->c2.link_socket_infos[0] = ls->info;
+
+        /* locally override some link_socket_info fields */
+        dest->c2.link_socket_infos[0]->lsa = &dest->c1.link_socket_addrs[0];
+        dest->c2.link_socket_infos[0]->connection_established = false;
+    }
+
     init_instance(dest, src->c2.es, CC_NO_CLOSE | CC_USR1_TO_HUP);
     if (IS_SIG(dest))
     {
         return;
     }
-
-    /* UDP inherits some extra things which TCP does not */
-    if (dest->mode == CM_CHILD_UDP)
-    {
-        /* inherit buffers */
-        dest->c2.buffers = src->c2.buffers;
-
-        /* inherit parent link_socket and tuntap */
-        dest->c2.link_socket = src->c2.link_socket;
-
-        ALLOC_OBJ_GC(dest->c2.link_socket_info, struct link_socket_info, &dest->gc);
-        *dest->c2.link_socket_info = src->c2.link_socket->info;
-
-        /* locally override some link_socket_info fields */
-        dest->c2.link_socket_info->lsa = &dest->c1.link_socket_addr;
-        dest->c2.link_socket_info->connection_established = false;
-    }
 }
 
 void
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index ea7eb30..11c32ac 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -95,7 +95,8 @@
 bool do_deferred_options(struct context *c, const unsigned int found);
 
 void inherit_context_child(struct context *dest,
-                           const struct context *src);
+                           const struct context *src,
+                           struct link_socket *ls);
 
 void inherit_context_top(struct context *dest,
                          const struct context *src);
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index ebdec25..89dee7d 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -357,7 +357,7 @@
     struct link_socket_info *lsi = get_link_socket_info(c);
     struct options *o = &c->options;
 
-    int pmtu = c->c2.link_socket->mtu;
+    int pmtu = c->c2.link_sockets[0]->mtu;
     sa_family_t af = lsi->lsa->actual.dest.addr.sa.sa_family;
     int proto = lsi->proto;
 
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index a2841f0..b5bbf13 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -114,13 +114,13 @@
 #endif /* ENABLE_DEBUG */
 
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
@@ -170,13 +170,16 @@
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
@@ -232,7 +235,7 @@
 void
 multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instance *mi)
 {
-    struct link_socket *ls = mi->context.c2.link_socket;
+    struct link_socket *ls = mi->context.c2.link_sockets[0];
     if (ls && mi->socket_set_called)
     {
         event_del(mtcp->es, socket_event_handle(ls));
@@ -247,7 +250,7 @@
     if (mi)
     {
         mi->socket_set_called = true;
-        socket_set(mi->context.c2.link_socket,
+        socket_set(mi->context.c2.link_sockets[0],
                    m->mtcp->es,
                    mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,
                    &mi->ev_arg,
@@ -261,8 +264,12 @@
 {
     int status;
     unsigned int *persistent = &mtcp->tun_rwflags;
-    socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
-                                 &c->c2.link_socket->ev_arg);
+
+    for (int i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        socket_set_listen_persistent(c->c2.link_sockets[i], mtcp->es,
+                                     &c->c2.link_sockets[i]->ev_arg);
+    }
 
 #ifdef _WIN32
     if (tuntap_is_wintun(c->c1.tuntap))
@@ -480,16 +487,18 @@
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
@@ -565,7 +574,7 @@
             break;
 
         case MTP_NONE:
-            if (mi && socket_read_residual(c->c2.link_socket))
+            if (mi && sockets_read_residual(c))
             {
                 newaction = TA_SOCKET_READ_RESIDUAL;
             }
@@ -720,9 +729,14 @@
 
                 /* new incoming TCP client attempting to connect? */
                 case EVENT_ARG_LINK_SOCKET:
-                    ASSERT(m->top.c2.link_socket);
-                    socket_reset_listen_persistent(m->top.c2.link_socket);
-                    mi = multi_create_instance_tcp(m);
+                    if (!ev_arg->u.sock)
+                    {
+                        msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null socket");
+                        break;
+                    }
+
+                    socket_reset_listen_persistent(ev_arg->u.sock);
+                    mi = multi_create_instance_tcp(m, ev_arg->u.sock);
                     if (mi)
                     {
                         multi_tcp_action(m, mi, TA_INITIAL, false);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 5fbd7b0..6137578 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -185,7 +185,8 @@
  */
 
 struct multi_instance *
-multi_get_create_instance_udp(struct multi_context *m, bool *floated)
+multi_get_create_instance_udp(struct multi_context *m, bool *floated,
+                              struct link_socket *ls)
 {
     struct gc_arena gc = gc_new();
     struct mroute_addr real = {0};
@@ -256,7 +257,7 @@
                      * connect-freq but not against connect-freq-initial */
                     reflect_filter_rate_limit_decrease(m->initial_rate_limiter);
 
-                    mi = multi_create_instance(m, &real);
+                    mi = multi_create_instance(m, &real, ls);
                     if (mi)
                     {
                         hash_add_fast(hash, bucket, &mi->real, hv, mi);
@@ -317,7 +318,7 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link = m->hmac_reply;
         m->top.c2.to_link_addr = m->hmac_reply_dest;
-        process_outgoing_link(&m->top, m->top.c2.link_socket);
+        process_outgoing_link(&m->top, m->top.c2.link_sockets[0]);
         m->hmac_reply_dest = NULL;
     }
 }
@@ -326,7 +327,7 @@
  * Process an I/O event.
  */
 static void
-multi_process_io_udp(struct multi_context *m)
+multi_process_io_udp(struct multi_context *m, struct link_socket *sock)
 {
     const unsigned int status = m->top.c2.event_set_status;
     const unsigned int mpp_flags = m->top.c2.fast_io
@@ -380,10 +381,10 @@
     /* Incoming data on UDP port */
     else if (status & SOCKET_READ)
     {
-        read_incoming_link(&m->top, m->top.c2.link_socket);
+        read_incoming_link(&m->top, sock);
         if (!IS_SIG(&m->top))
         {
-            multi_process_incoming_link(m, NULL, mpp_flags);
+            multi_process_incoming_link(m, NULL, mpp_flags, sock);
         }
     }
     /* Incoming data on TUN device */
@@ -514,7 +515,11 @@
         else
         {
             /* process I/O */
-            multi_process_io_udp(&multi);
+
+            /* Since there's only one link_socket just use the first, in an upcoming
+             * patch this will be changed by using the link_socket returned by the
+             * event set */
+            multi_process_io_udp(&multi, top->c2.link_sockets[0]);
             MULTI_CHECK_SIG(&multi);
         }
 
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 14e90d0..b378754 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -55,12 +55,14 @@
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
 
 #endif /* ifndef MUDP_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 45b3cfa..67bb58f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -750,7 +750,8 @@
  * Create a client instance object for a newly connected client.
  */
 struct multi_instance *
-multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
+multi_create_instance(struct multi_context *m, const struct mroute_addr *real,
+                      struct link_socket *ls)
 {
     struct gc_arena gc = gc_new();
     struct multi_instance *mi;
@@ -773,7 +774,7 @@
         generate_prefix(mi);
     }
 
-    inherit_context_child(&mi->context, &m->top);
+    inherit_context_child(&mi->context, &m->top, ls);
     if (IS_SIG(&mi->context))
     {
         goto err;
@@ -3124,7 +3125,8 @@
 }
 
 void
-multi_process_float(struct multi_context *m, struct multi_instance *mi)
+multi_process_float(struct multi_context *m, struct multi_instance *mi,
+                    struct link_socket *ls)
 {
     struct mroute_addr real = {0};
     struct hash *hash = m->hash;
@@ -3180,8 +3182,8 @@
     mi->context.c2.to_link_addr = &mi->context.c2.from;
 
     /* inherit parent link_socket and link_socket_info */
-    mi->context.c2.link_socket = m->top.c2.link_socket;
-    mi->context.c2.link_socket_info->lsa->actual = m->top.c2.from;
+    mi->context.c2.link_sockets[0] = ls;
+    mi->context.c2.link_socket_infos[0]->lsa->actual = m->top.c2.from;
 
     tls_update_remote_addr(mi->context.c2.tls_multi, &mi->context.c2.from);
 
@@ -3329,7 +3331,8 @@
  * i.e. client -> server direction.
  */
 bool
-multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance, const unsigned int mpp_flags)
+multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance,
+                            const unsigned int mpp_flags, struct link_socket *ls)
 {
     struct gc_arena gc = gc_new();
 
@@ -3350,7 +3353,7 @@
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TCP/UDP -> TUN [%d]\n", BLEN(&m->top.c2.buf));
 #endif
-        multi_set_pending(m, multi_get_create_instance_udp(m, &floated));
+        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, ls));
     }
     else
     {
@@ -3391,7 +3394,7 @@
                 /* nonzero length means that we have a valid, decrypted packed */
                 if (floated && c->c2.buf.len > 0)
                 {
-                    multi_process_float(m, m->pending);
+                    multi_process_float(m, m->pending, ls);
                 }
 
                 process_incoming_link_part2(c, lsi, orig_buf);
@@ -3610,7 +3613,7 @@
                     }
 
                     /* encrypt in instance context */
-                    process_incoming_tun(c);
+                    process_incoming_tun(c, c->c2.link_sockets[0]);
 
                     /* postprocess and set wakeup */
                     ret = multi_process_post(m, m->pending, mpp_flags);
@@ -3642,7 +3645,8 @@
         {
             pip_flags |= PIP_MSSFIX;
         }
-        process_ip_header(&item.instance->context, pip_flags, &item.instance->context.c2.buf);
+        process_ip_header(&item.instance->context, pip_flags, &item.instance->context.c2.buf,
+                          item.instance->context.c2.link_sockets[0]);
         encrypt_sign(&item.instance->context, true);
         mbuf_free_buf(item.buffer);
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 93ac9e7..9b6834a 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -275,7 +275,8 @@
 
 void multi_top_free(struct multi_context *m);
 
-struct multi_instance *multi_create_instance(struct multi_context *m, const struct mroute_addr *real);
+struct multi_instance *multi_create_instance(struct multi_context *m, const struct mroute_addr *real,
+                                             struct link_socket *ls);
 
 void multi_close_instance(struct multi_context *m, struct multi_instance *mi, bool shutdown);
 
@@ -289,7 +290,8 @@
  * existing peer. Updates multi_instance with new address,
  * updates hashtables in multi_context.
  */
-void multi_process_float(struct multi_context *m, struct multi_instance *mi);
+void multi_process_float(struct multi_context *m, struct multi_instance *mi,
+                         struct link_socket *ls);
 
 #define MPP_PRE_SELECT             (1<<0)
 #define MPP_CONDITIONAL_PRE_SELECT (1<<1)
@@ -354,8 +356,10 @@
  *                       when using TCP transport. Otherwise NULL, as is
  *                       the case when using UDP transport.
  * @param mpp_flags    - Fast I/O optimization flags.
+ * @param ls           - Socket where the packet was received.
  */
-bool multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance, const unsigned int mpp_flags);
+bool multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance, const unsigned int mpp_flags,
+                                 struct link_socket *ls);
 
 
 /**
@@ -669,7 +673,7 @@
 #endif
     set_prefix(mi);
     vlan_process_outgoing_tun(m, mi);
-    process_outgoing_tun(&mi->context);
+    process_outgoing_tun(&mi->context, mi->context.c2.link_sockets[0]);
     ret = multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
@@ -684,7 +688,7 @@
 {
     bool ret = true;
     set_prefix(mi);
-    process_outgoing_link(&mi->context, mi->context.c2.link_socket);
+    process_outgoing_link(&mi->context, mi->context.c2.link_sockets[0]);
     ret = multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index c52540c..977d02d 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -91,7 +91,7 @@
         }
 
         /* process the I/O which triggered select */
-        process_io(c, c->c2.link_socket);
+        process_io(c, c->c2.link_sockets[0]);
         P2P_CHECK_SIG();
 
         perf_pop();
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 8dfcab4..df43bba 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -154,7 +154,8 @@
  */
 struct context_1
 {
-    struct link_socket_addr link_socket_addr;
+    int link_sockets_num;
+    struct link_socket_addr *link_socket_addrs;
     /**< Local and remote addresses on the
      *   external network. */
 
@@ -233,11 +234,11 @@
     /* bitmask for event status. Check event.h for possible values */
     unsigned int event_set_status;
 
-    struct link_socket *link_socket;     /* socket used for TCP/UDP connection to remote */
+    struct link_socket **link_sockets;
+    struct link_socket_info **link_socket_infos;
+
     bool link_socket_owned;
 
-    /** This variable is used instead link_socket->info for P2MP UDP childs */
-    struct link_socket_info *link_socket_info;
     const struct link_socket *accept_from; /* possibly do accept() on a parent link_socket */
 
     struct link_socket_actual *to_link_addr;    /* IP address of remote */
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 887172c..4a87895 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -63,7 +63,7 @@
         && event_timeout_trigger(&c->c2.ping_rec_interval,
                                  &c->c2.timeval,
                                  (!c->options.ping_timer_remote
-                                  || link_socket_actual_defined(&c->c1.link_socket_addr.actual))
+                                  || link_socket_actual_defined(&c->c1.link_socket_addrs[0].actual))
                                  ? ETT_DEFAULT : 15))
     {
         trigger_ping_timeout_signal(c);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index b895bd4..f9f2a3b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -42,6 +42,21 @@
 
 #include "memdbg.h"
 
+bool
+sockets_read_residual(const struct context *c)
+{
+    int i;
+
+    for (i = 0; i < c->c1.link_sockets_num; i++)
+    {
+        if (c->c2.link_sockets[i]->stream_buf.residual_fully_formed)
+        {
+            return true;
+        }
+    }
+    return false;
+}
+
 /*
  * Convert sockflags/getaddr_flags into getaddr_flags
  */
@@ -1454,7 +1469,6 @@
 #ifdef TARGET_ANDROID
     protect_fd_nonlocal(sd, remote);
 #endif
-
     set_nonblock(sd);
     status = connect(sd, remote, af_addr_size(remote->sa_family));
     if (status)
@@ -1851,9 +1865,9 @@
 }
 
 void
-link_socket_init_phase1(struct context *c, int mode)
+link_socket_init_phase1(struct context *c, int sock_index, int mode)
 {
-    struct link_socket *sock = c->c2.link_socket;
+    struct link_socket *sock = c->c2.link_sockets[sock_index];
     struct options *o = &c->options;
     ASSERT(sock);
 
@@ -1879,19 +1893,20 @@
     sock->socket_buffer_sizes.sndbuf = o->sndbuf;
 
     sock->sockflags = o->sockflags;
+
 #if PORT_SHARE
     if (o->port_share_host && o->port_share_port)
     {
         sock->sockflags |= SF_PORT_SHARE;
     }
 #endif
+
     sock->mark = o->mark;
     sock->bind_dev = o->bind_dev;
-
     sock->info.proto = o->ce.proto;
     sock->info.af = o->ce.af;
     sock->info.remote_float = o->ce.remote_float;
-    sock->info.lsa = &c->c1.link_socket_addr;
+    sock->info.lsa = &c->c1.link_socket_addrs[sock_index];
     sock->info.bind_ipv6_only = o->ce.bind_ipv6_only;
     sock->info.ipchange_command = o->ipchange;
     sock->info.plugins = c->plugins;
@@ -2186,9 +2201,9 @@
 
 /* finalize socket initialization */
 void
-link_socket_init_phase2(struct context *c)
+link_socket_init_phase2(struct context *c,
+                        struct link_socket *sock)
 {
-    struct link_socket *sock = c->c2.link_socket;
     const struct frame *frame = &c->c2.frame;
     struct signal_info *sig_info = c->sig;
 
@@ -2234,7 +2249,6 @@
         {
             create_socket(sock, sock->info.lsa->current_remote);
         }
-
     }
 
     /* If socket has not already been created create it now */
@@ -2253,7 +2267,6 @@
                     addr_family_name(sock->info.lsa->bind_local->ai_family));
                 sock->info.af = sock->info.lsa->bind_local->ai_family;
             }
-
             create_socket(sock, sock->info.lsa->bind_local);
         }
     }
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 465d92b..16106d4 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -344,9 +344,13 @@
 /*
  * Initialize link_socket object.
  */
-void link_socket_init_phase1(struct context *c, int mode);
+void
+link_socket_init_phase1(struct context *c,
+                        int sock_index,
+                        int mode);
 
-void link_socket_init_phase2(struct context *c);
+void link_socket_init_phase2(struct context *c,
+                             struct link_socket *sock);
 
 void do_preresolve(struct context *c);
 
@@ -1228,11 +1232,12 @@
  * Socket I/O wait functions
  */
 
-static inline bool
-socket_read_residual(const struct link_socket *sock)
-{
-    return sock && sock->stream_buf.residual_fully_formed;
-}
+/*
+ * Extends the pre-existing read residual logic
+ * to all initialized sockets, ensuring the complete
+ * packet is read.
+ */
+bool sockets_read_residual(const struct context *c);
 
 static inline event_t
 socket_event_handle(const struct link_socket *sock)

