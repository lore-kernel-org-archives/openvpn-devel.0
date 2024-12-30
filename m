From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Dec 2024 17:32:34 +0000
In-Reply-To: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
References: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <b5b149d2603ddc21677f098e6ab5674bb0bfc51d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TAJoIA3qT5Y="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Adapt socket
 handling to support listening on multiple sockets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: its_Giaan <gianmarco@...2726...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TAJoIA3qT5Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/43=
4?usp=3Demail )

Change subject: Adapt socket handling to support listening on multiple sock=
ets
......................................................................

Adapt socket handling to support listening on multiple sockets

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
Message-Id: <20241230162338.21401-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
309.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/mss.c
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/mudp.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/openvpn.c
M src/openvpn/openvpn.h
M src/openvpn/ping.h
M src/openvpn/socket.c
M src/openvpn/socket.h
16 files changed, 326 insertions(+), 183 deletions(-)




diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index dcc80d3..8f2adb5 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -478,11 +478,11 @@
         return 0;
     }

-    struct link_socket *ls =3D c->c2.link_socket;
+    struct link_socket *sock =3D c->c2.link_sockets[0];

-    ASSERT(ls->info.connection_established);
+    ASSERT(sock->info.connection_established);

-    struct sockaddr *remoteaddr =3D &ls->info.lsa->actual.dest.addr.sa;
+    struct sockaddr *remoteaddr =3D &sock->info.lsa->actual.dest.addr.sa;
     struct tls_multi *multi =3D c->c2.tls_multi;
 #ifdef TARGET_FREEBSD
     /* In Linux in P2P mode the kernel automatically removes an existing p=
eer
@@ -494,7 +494,7 @@
     }
 #endif
     int ret =3D dco_new_peer(&c->c1.tuntap->dco, multi->peer_id,
-                           c->c2.link_socket->sd, NULL, remoteaddr, NULL, =
NULL);
+                           c->c2.link_sockets[0]->sd, NULL, remoteaddr, NU=
LL, NULL);
     if (ret < 0)
     {
         return ret;
@@ -527,12 +527,12 @@
 #if ENABLE_IP_PKTINFO
     struct context *c =3D &mi->context;

-    if (!proto_is_udp(c->c2.link_socket->info.proto) || !(c->options.sockf=
lags & SF_USE_IP_PKTINFO))
+    if (!proto_is_udp(c->c2.link_sockets[0]->info.proto) || !(c->options.s=
ockflags & SF_USE_IP_PKTINFO))
     {
         return false;
     }

-    struct link_socket_actual *actual =3D &c->c2.link_socket_info->lsa->ac=
tual;
+    struct link_socket_actual *actual =3D &c->c2.link_socket_infos[0]->lsa=
->actual;

     switch (actual->dest.addr.sa.sa_family)
     {
@@ -577,7 +577,7 @@
     int peer_id =3D c->c2.tls_multi->peer_id;
     struct sockaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
-    int sd =3D c->c2.link_socket->sd;
+    int sd =3D c->c2.link_sockets[0]->sd;


     if (c->mode =3D=3D CM_CHILD_TCP)
@@ -587,8 +587,8 @@
     }
     else
     {
-        ASSERT(c->c2.link_socket_info->connection_established);
-        remoteaddr =3D &c->c2.link_socket_info->lsa->actual.dest.addr.sa;
+        ASSERT(c->c2.link_socket_infos[0]->connection_established);
+        remoteaddr =3D &c->c2.link_socket_infos[0]->lsa->actual.dest.addr.=
sa;
     }

     /* In server mode we need to fetch the remote addresses from the push =
config */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 2c72001..f3f3503 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -58,12 +58,17 @@
 wait_status_string(struct context *c, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(64, gc);
-    buf_printf(&out, "I/O WAIT %s|%s|%s|%s %s",
+
+    buf_printf(&out, "I/O WAIT %s|%s| %s",
                tun_stat(c->c1.tuntap, EVENT_READ, gc),
                tun_stat(c->c1.tuntap, EVENT_WRITE, gc),
-               socket_stat(c->c2.link_socket, EVENT_READ, gc),
-               socket_stat(c->c2.link_socket, EVENT_WRITE, gc),
                tv_string(&c->c2.timeval, gc));
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
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
         decrypt_status =3D openvpn_decrypt(&c->c2.buf, c->c2.buffers->decr=
ypt_buf,
                                          co, &c->c2.frame, ad_start);

-        if (!decrypt_status && link_socket_connection_oriented(c->c2.link_=
socket))
+        if (!decrypt_status
+            /* on the instance context we have only one socket, so just ch=
eck the first one */
+            && link_socket_connection_oriented(c->c2.link_sockets[0]))
         {
             /* decryption errors are fatal in TCP mode */
             register_signal(c->sig, SIGUSR1, "decryption-error"); /* SOFT-=
SIGUSR1 -- decryption error in TCP mode */
@@ -1451,7 +1459,7 @@
  */

 void
-process_incoming_tun(struct context *c)
+process_incoming_tun(struct context *c, struct link_socket *out_sock)
 {
     struct gc_arena gc =3D gc_new();

@@ -1484,7 +1492,7 @@
          */
         unsigned int flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_N=
AT
                              | PIPV6_ICMP_NOHOST_CLIENT;
-        process_ip_header(c, flags, &c->c2.buf);
+        process_ip_header(c, flags, &c->c2.buf, out_sock);

 #ifdef PACKET_TRUNCATION_CHECK
         /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
@@ -1645,7 +1653,8 @@
 }

 void
-process_ip_header(struct context *c, unsigned int flags, struct buffer *bu=
f)
+process_ip_header(struct context *c, unsigned int flags, struct buffer *bu=
f,
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
-                      PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIEN=
T_NAT | PIP_OUTGOING,
-                      &c->c2.to_tun);
+    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIENT=
_NAT|PIP_OUTGOING, &c->c2.to_tun,
+                      in_sock);

     if (c->c2.to_tun.len <=3D c->c2.frame.buf.payload_size)
     {
@@ -2180,8 +2188,11 @@
     /*
      * Configure event wait based on socket, tuntap flags.
      */
-    socket_set(c->c2.link_socket, c->c2.event_set, socket,
-               &c->c2.link_socket->ev_arg, NULL);
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        socket_set(c->c2.link_sockets[i], c->c2.event_set, socket,
+                   &c->c2.link_sockets[i]->ev_arg, NULL);
+    }
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL=
);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (socket & EVENT_READ && c->c2.did_open_tun)
@@ -2219,7 +2230,7 @@

     if (!c->sig->signal_received)
     {
-        if (!(flags & IOW_CHECK_RESIDUAL) || !socket_read_residual(c->c2.l=
ink_socket))
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


 /*************************************************************************=
*/
@@ -304,20 +307,21 @@
 #define PIPV6_ICMP_NOHOST_SERVER        (1<<6)


-void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf);
+void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf,
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
-                c->c1.link_socket_addr.current_remote =3D
-                    c->c1.link_socket_addr.current_remote->ai_next;
+                c->c1.link_socket_addrs[0].current_remote =3D
+                    c->c1.link_socket_addrs[0].current_remote->ai_next;
             }
             else
             {
@@ -557,20 +557,20 @@
                      * skipped by management on the previous loop.
                      * If so, clear the addrinfo objects as close_instance=
 does
                      */
-                    if (c->c1.link_socket_addr.remote_list)
+                    if (c->c1.link_socket_addrs[0].remote_list)
                     {
-                        clear_remote_addrlist(&c->c1.link_socket_addr,
+                        clear_remote_addrlist(&c->c1.link_socket_addrs[0],
                                               !c->options.resolve_in_advan=
ce);
                     }

                     /* close_instance should have cleared the addrinfo obj=
ects */
-                    ASSERT(c->c1.link_socket_addr.current_remote =3D=3D NU=
LL);
-                    ASSERT(c->c1.link_socket_addr.remote_list =3D=3D NULL);
+                    ASSERT(c->c1.link_socket_addrs[0].current_remote =3D=
=3D NULL);
+                    ASSERT(c->c1.link_socket_addrs[0].remote_list =3D=3D N=
ULL);
                 }
                 else
                 {
-                    c->c1.link_socket_addr.current_remote =3D
-                        c->c1.link_socket_addr.remote_list;
+                    c->c1.link_socket_addrs[0].current_remote =3D
+                        c->c1.link_socket_addrs[0].remote_list;
                 }

                 int advance_count =3D 1;
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

+    c->c1.link_sockets_num =3D 1;
+
+    do_link_socket_addr_new(c);
+
 #if defined(ENABLE_PKCS11)
     if (c->first_time)
     {
@@ -1644,7 +1655,7 @@
         CLEAR(local);
         actual =3D &get_link_socket_info(c)->lsa->actual;
         remote =3D actual->dest;
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
-                               &c->c2.link_socket->info, c->c2.es, &c->net=
_ctx);
+                               &c->c2.link_sockets[0]->info, c->c2.es, &c-=
>net_ctx);
         }
         if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
         {
             do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list,
-                                    &c->c2.link_socket->info, c->c2.es,
-                                    &c->net_ctx);
+                                    &c->c2.link_sockets[0]->info, c->c2.es=
, &c->net_ctx);
         }

         /* do ifconfig */
@@ -1977,8 +1987,7 @@
                                                  c->options.dev_type,
                                                  c->options.dev_node,
                                                  &gc);
-            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es,
-                        &c->net_ctx);
+            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es=
, &c->net_ctx);
         }

         /* possibly add routes */
@@ -1993,6 +2002,7 @@
         /* Store the old fd inside the fd so open_tun can use it */
         c->c1.tuntap->fd =3D oldtunfd;
 #endif
+
         if (dco_enabled(&c->options))
         {
             ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
@@ -2004,8 +2014,7 @@
         /* set the hardware address */
         if (c->options.lladdr)
         {
-            set_lladdr(&c->net_ctx, c->c1.tuntap->actual_name, c->options.=
lladdr,
-                       c->c2.es);
+            set_lladdr(&c->net_ctx, c->c1.tuntap->actual_name, c->options.=
lladdr, c->c2.es);
         }

         /* do ifconfig */
@@ -2486,7 +2495,7 @@
                 {
                     msg(M_NONFATAL, "dco-win doesn't yet support reopening=
 TUN device");
                     /* prevent link_socket_close() from closing handle wit=
h WinSock API */
-                    c->c2.link_socket->sd =3D SOCKET_UNDEFINED;
+                    c->c2.link_sockets[0]->sd =3D SOCKET_UNDEFINED;
                     return false;
                 }
                 else
@@ -2709,13 +2718,23 @@
     if (found & OPT_P_SOCKBUF)
     {
         msg(D_PUSH, "OPTIONS IMPORT: --sndbuf/--rcvbuf options modified");
-        link_socket_update_buffer_sizes(c->c2.link_socket, c->options.rcvb=
uf, c->options.sndbuf);
+
+        for (int i =3D 0; i < c->c1.link_sockets_num; i++)
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
+        for (int i =3D 0; i < c->c1.link_sockets_num; i++)
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
-    c->c2.link_socket =3D link_socket_new();
+    ASSERT(!c->c2.link_sockets);
+
+    ALLOC_ARRAY_GC(c->c2.link_sockets, struct link_socket *,
+                   c->c1.link_sockets_num, &c->c2.gc);
+
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        c->c2.link_sockets[i] =3D link_socket_new();
+    }
     c->c2.link_socket_owned =3D true;
 }

 /*
+ * bind TCP/UDP sockets
+ */
+static void
+do_init_socket_phase1(struct context *c)
+{
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        int mode =3D LS_MODE_DEFAULT;
+
+        /* mode allows CM_CHILD_TCP
+         * instances to inherit acceptable fds
+         * from a top-level parent */
+        if (c->options.mode =3D=3D MODE_SERVER)
+        {
+            /* initializing listening socket */
+            if (c->mode =3D=3D CM_TOP)
+            {
+                mode =3D LS_MODE_TCP_LISTEN;
+            }
+            /* initializing socket to client */
+            else if (c->mode =3D=3D CM_CHILD_TCP)
+            {
+                mode =3D LS_MODE_TCP_ACCEPT_FROM;
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
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
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
-        c->c2.link_socket->sd =3D SOCKET_UNDEFINED;
+        for (int i =3D 0; i < c->c1.link_sockets_num; i++)
+        {
+            c->c2.link_sockets[i]->sd =3D SOCKET_UNDEFINED;
+        }
     }

-    if (c->c2.link_socket && c->c2.link_socket_owned)
+    if (c->c2.link_sockets && c->c2.link_socket_owned)
     {
-        link_socket_close(c->c2.link_socket);
-        c->c2.link_socket =3D NULL;
+        for (int i =3D 0; i < c->c1.link_sockets_num; i++)
+        {
+            link_socket_close(c->c2.link_sockets[i]);
+        }
+        c->c2.link_sockets =3D NULL;
     }


@@ -3970,28 +4046,36 @@
           && ( (c->options.persist_remote_ip)
                ||
                ( c->sig->source !=3D SIG_SOURCE_HARD
-                 && ((c->c1.link_socket_addr.current_remote
-                      && c->c1.link_socket_addr.current_remote->ai_next)
+                 && ((c->c1.link_socket_addrs[0].current_remote
+                      && c->c1.link_socket_addrs[0].current_remote->ai_nex=
t)
                      || c->options.no_advance))
                )))
     {
-        clear_remote_addrlist(&c->c1.link_socket_addr, !c->options.resolve=
_in_advance);
+        clear_remote_addrlist(&c->c1.link_socket_addrs[0],
+                              !c->options.resolve_in_advance);
     }

     /* Clear the remote actual address when persist_remote_ip is not in us=
e */
     if (!(c->sig->signal_received =3D=3D SIGUSR1 && c->options.persist_rem=
ote_ip))
     {
-        CLEAR(c->c1.link_socket_addr.actual);
+        for (int i =3D 0; i < c->c1.link_sockets_num; i++)
+        {
+            CLEAR(c->c1.link_socket_addrs[i].actual);
+        }
     }

     if (!(c->sig->signal_received =3D=3D SIGUSR1 && c->options.persist_loc=
al_ip))
     {
-        if (c->c1.link_socket_addr.bind_local && !c->options.resolve_in_ad=
vance)
+        for (int i =3D 0; i < c->c1.link_sockets_num; i++)
         {
-            freeaddrinfo(c->c1.link_socket_addr.bind_local);
-        }
+            if (c->c1.link_socket_addrs[i].bind_local
+                && !c->options.resolve_in_advance)
+            {
+                freeaddrinfo(c->c1.link_socket_addrs[i].bind_local);
+            }

-        c->c1.link_socket_addr.bind_local =3D NULL;
+            c->c1.link_socket_addrs[i].bind_local =3D NULL;
+        }
     }
 }

@@ -4474,7 +4558,6 @@
 {
     const struct options *options =3D &c->options;
     const bool child =3D (c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=3D CM=
_CHILD_UDP);
-    int link_socket_mode =3D LS_MODE_DEFAULT;

     /* init garbage collection level */
     gc_init(&c->c2.gc);
@@ -4515,21 +4598,6 @@
     /* map in current connection entry */
     next_connection_entry(c);

-    /* link_socket_mode allows CM_CHILD_TCP
-     * instances to inherit acceptable fds
-     * from a top-level parent */
-    if (c->options.ce.proto =3D=3D PROTO_TCP_SERVER)
-    {
-        if (c->mode =3D=3D CM_TOP)
-        {
-            link_socket_mode =3D LS_MODE_TCP_LISTEN;
-        }
-        else if (c->mode =3D=3D CM_CHILD_TCP)
-        {
-            link_socket_mode =3D LS_MODE_TCP_ACCEPT_FROM;
-        }
-    }
-
     /* should we disable paging? */
     if (c->first_time && options->mlock)
     {
@@ -4672,7 +4740,7 @@
     /* bind the TCP/UDP socket */
     if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP || c->mode =3D=3D C=
M_CHILD_TCP)
     {
-        link_socket_init_phase1(c, link_socket_mode);
+        do_init_socket_phase1(c);
     }

     /* initialize tun/tap device object,
@@ -4715,15 +4783,18 @@
     /* finalize the TCP/UDP socket */
     if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP || c->mode =3D=3D C=
M_CHILD_TCP)
     {
-        link_socket_init_phase2(c);
+        do_init_socket_phase2(c);


         /* Update dynamic frame calculation as exact transport socket info=
rmation
          * (IP vs IPv6) may be only available after socket phase2 has fini=
shed.
          * This is only needed for --static or no crypto, NCP will recalcu=
late this
          * in tls_session_update_crypto_params (P2MP) */
-        frame_calculate_dynamic(&c->c2.frame, &c->c1.ks.key_type, &c->opti=
ons,
-                                get_link_socket_info(c));
+        for (int i =3D 0; i < c->c1.link_sockets_num; i++)
+        {
+            frame_calculate_dynamic(&c->c2.frame, &c->c1.ks.key_type, &c->=
options,
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
+    dest->c1.link_sockets_num =3D 1;
+    do_link_socket_addr_new(dest);

     dest->c1.ks.key_type =3D src->c1.ks.key_type;
     /* inherit SSL context */
@@ -4888,7 +4962,7 @@
          * The CM_TOP context does the socket listen(),
          * and the CM_CHILD_TCP context does the accept().
          */
-        dest->c2.accept_from =3D src->c2.link_socket;
+        dest->c2.accept_from =3D ls;
     }

 #ifdef ENABLE_PLUGIN
@@ -4903,28 +4977,33 @@
      */
     dest->c1.tuntap =3D src->c1.tuntap;

+    /* UDP inherits some extra things which TCP does not */
+    if (dest->mode =3D=3D CM_CHILD_UDP)
+    {
+        ASSERT(!dest->c2.link_sockets);
+
+        /* inherit buffers */
+        dest->c2.buffers =3D src->c2.buffers;
+
+        ALLOC_ARRAY_GC(dest->c2.link_sockets, struct link_socket *, 1, &de=
st->gc);
+
+        /* inherit parent link_socket and tuntap */
+        dest->c2.link_sockets[0] =3D ls;
+
+        ALLOC_ARRAY_GC(dest->c2.link_socket_infos, struct link_socket_info=
 *, 1, &dest->gc);
+        ALLOC_OBJ_GC(dest->c2.link_socket_infos[0], struct link_socket_inf=
o, &dest->gc);
+        *dest->c2.link_socket_infos[0] =3D ls->info;
+
+        /* locally override some link_socket_info fields */
+        dest->c2.link_socket_infos[0]->lsa =3D &dest->c1.link_socket_addrs=
[0];
+        dest->c2.link_socket_infos[0]->connection_established =3D false;
+    }
+
     init_instance(dest, src->c2.es, CC_NO_CLOSE | CC_USR1_TO_HUP);
     if (IS_SIG(dest))
     {
         return;
     }
-
-    /* UDP inherits some extra things which TCP does not */
-    if (dest->mode =3D=3D CM_CHILD_UDP)
-    {
-        /* inherit buffers */
-        dest->c2.buffers =3D src->c2.buffers;
-
-        /* inherit parent link_socket and tuntap */
-        dest->c2.link_socket =3D src->c2.link_socket;
-
-        ALLOC_OBJ_GC(dest->c2.link_socket_info, struct link_socket_info, &=
dest->gc);
-        *dest->c2.link_socket_info =3D src->c2.link_socket->info;
-
-        /* locally override some link_socket_info fields */
-        dest->c2.link_socket_info->lsa =3D &dest->c1.link_socket_addr;
-        dest->c2.link_socket_info->connection_established =3D false;
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
     struct link_socket_info *lsi =3D get_link_socket_info(c);
     struct options *o =3D &c->options;

-    int pmtu =3D c->c2.link_socket->mtu;
+    int pmtu =3D c->c2.link_sockets[0]->mtu;
     sa_family_t af =3D lsi->lsa->actual.dest.addr.sa.sa_family;
     int proto =3D lsi->proto;

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
     struct gc_arena gc =3D gc_new();
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;

-    mi =3D multi_create_instance(m, NULL);
+    mi =3D multi_create_instance(m, NULL, ls);
     if (mi)
     {
         struct hash_element *he;
@@ -170,13 +170,16 @@
     /* buffer for queued TCP socket output packets */
     mi->tcp_link_out_deferred =3D mbuf_init(m->top.options.n_bcast_buf);

-    ASSERT(mi->context.c2.link_socket);
-    ASSERT(mi->context.c2.link_socket->info.lsa);
-    ASSERT(mi->context.c2.link_socket->mode =3D=3D LS_MODE_TCP_ACCEPT_FROM=
);
-    ASSERT(mi->context.c2.link_socket->info.lsa->actual.dest.addr.sa.sa_fa=
mily =3D=3D AF_INET
-           || mi->context.c2.link_socket->info.lsa->actual.dest.addr.sa.sa=
_family =3D=3D AF_INET6
+    ASSERT(mi->context.c2.link_sockets);
+    ASSERT(mi->context.c2.link_sockets[0]);
+    ASSERT(mi->context.c2.link_sockets[0]->info.lsa);
+    ASSERT(mi->context.c2.link_sockets[0]->mode =3D=3D LS_MODE_TCP_ACCEPT_=
FROM);
+    ASSERT(mi->context.c2.link_sockets[0]->info.lsa->actual.dest.addr.sa.s=
a_family =3D=3D AF_INET
+           || mi->context.c2.link_sockets[0]->info.lsa->actual.dest.addr.s=
a.sa_family =3D=3D AF_INET6
            );
-    if (!mroute_extract_openvpn_sockaddr(&mi->real, &mi->context.c2.link_s=
ocket->info.lsa->actual.dest, true))
+    if (!mroute_extract_openvpn_sockaddr(&mi->real,
+                                         &mi->context.c2.link_sockets[0]->=
info.lsa->actual.dest,
+                                         true))
     {
         msg(D_MULTI_ERRORS, "MULTI TCP: TCP client address is undefined");
         return false;
@@ -232,7 +235,7 @@
 void
 multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instan=
ce *mi)
 {
-    struct link_socket *ls =3D mi->context.c2.link_socket;
+    struct link_socket *ls =3D mi->context.c2.link_sockets[0];
     if (ls && mi->socket_set_called)
     {
         event_del(mtcp->es, socket_event_handle(ls));
@@ -247,7 +250,7 @@
     if (mi)
     {
         mi->socket_set_called =3D true;
-        socket_set(mi->context.c2.link_socket,
+        socket_set(mi->context.c2.link_sockets[0],
                    m->mtcp->es,
                    mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
                    &mi->ev_arg,
@@ -261,8 +264,12 @@
 {
     int status;
     unsigned int *persistent =3D &mtcp->tun_rwflags;
-    socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
-                                 &c->c2.link_socket->ev_arg);
+
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
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
+            read_incoming_link(&mi->context, mi->context.c2.link_sockets[0=
]);
             clear_prefix();
             if (!IS_SIG(&mi->context))
             {
-                multi_process_incoming_link(m, mi, mpp_flags);
+                multi_process_incoming_link(m, mi, mpp_flags,
+                                            mi->context.c2.link_sockets[0]=
);
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
                 newaction =3D TA_SOCKET_READ_RESIDUAL;
             }
@@ -720,9 +729,14 @@

                 /* new incoming TCP client attempting to connect? */
                 case EVENT_ARG_LINK_SOCKET:
-                    ASSERT(m->top.c2.link_socket);
-                    socket_reset_listen_persistent(m->top.c2.link_socket);
-                    mi =3D multi_create_instance_tcp(m);
+                    if (!ev_arg->u.sock)
+                    {
+                        msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null soc=
ket");
+                        break;
+                    }
+
+                    socket_reset_listen_persistent(ev_arg->u.sock);
+                    mi =3D multi_create_instance_tcp(m, ev_arg->u.sock);
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
     struct gc_arena gc =3D gc_new();
     struct mroute_addr real =3D {0};
@@ -256,7 +257,7 @@
                      * connect-freq but not against connect-freq-initial */
                     reflect_filter_rate_limit_decrease(m->initial_rate_lim=
iter);

-                    mi =3D multi_create_instance(m, &real);
+                    mi =3D multi_create_instance(m, &real, ls);
                     if (mi)
                     {
                         hash_add_fast(hash, bucket, &mi->real, hv, mi);
@@ -317,7 +318,7 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link =3D m->hmac_reply;
         m->top.c2.to_link_addr =3D m->hmac_reply_dest;
-        process_outgoing_link(&m->top, m->top.c2.link_socket);
+        process_outgoing_link(&m->top, m->top.c2.link_sockets[0]);
         m->hmac_reply_dest =3D NULL;
     }
 }
@@ -326,7 +327,7 @@
  * Process an I/O event.
  */
 static void
-multi_process_io_udp(struct multi_context *m)
+multi_process_io_udp(struct multi_context *m, struct link_socket *sock)
 {
     const unsigned int status =3D m->top.c2.event_set_status;
     const unsigned int mpp_flags =3D m->top.c2.fast_io
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
+            /* Since there's only one link_socket just use the first, in a=
n upcoming
+             * patch this will be changed by using the link_socket returne=
d by the
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
+ * @param ls          - Listening socket where this instance is connecting=
 to
  *
  * @return A pointer to a multi_instance if one already existed for the
  *     packet's source address or if one was a newly created successfully.
  *      NULL if one did not yet exist and a new one was not created.
  */
-struct multi_instance *multi_get_create_instance_udp(struct multi_context =
*m, bool *floated);
+struct multi_instance *multi_get_create_instance_udp(struct multi_context =
*m, bool *floated,
+                                                     struct link_socket *l=
s);

 #endif /* ifndef MUDP_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 45b3cfa..67bb58f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -750,7 +750,8 @@
  * Create a client instance object for a newly connected client.
  */
 struct multi_instance *
-multi_create_instance(struct multi_context *m, const struct mroute_addr *r=
eal)
+multi_create_instance(struct multi_context *m, const struct mroute_addr *r=
eal,
+                      struct link_socket *ls)
 {
     struct gc_arena gc =3D gc_new();
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
     struct mroute_addr real =3D {0};
     struct hash *hash =3D m->hash;
@@ -3180,8 +3182,8 @@
     mi->context.c2.to_link_addr =3D &mi->context.c2.from;

     /* inherit parent link_socket and link_socket_info */
-    mi->context.c2.link_socket =3D m->top.c2.link_socket;
-    mi->context.c2.link_socket_info->lsa->actual =3D m->top.c2.from;
+    mi->context.c2.link_sockets[0] =3D ls;
+    mi->context.c2.link_socket_infos[0]->lsa->actual =3D m->top.c2.from;

     tls_update_remote_addr(mi->context.c2.tls_multi, &mi->context.c2.from);

@@ -3329,7 +3331,8 @@
  * i.e. client -> server direction.
  */
 bool
-multi_process_incoming_link(struct multi_context *m, struct multi_instance=
 *instance, const unsigned int mpp_flags)
+multi_process_incoming_link(struct multi_context *m, struct multi_instance=
 *instance,
+                            const unsigned int mpp_flags, struct link_sock=
et *ls)
 {
     struct gc_arena gc =3D gc_new();

@@ -3350,7 +3353,7 @@
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TCP/UDP -> TUN [%d]\n", BLEN(&m->top.c2.buf));
 #endif
-        multi_set_pending(m, multi_get_create_instance_udp(m, &floated));
+        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, ls=
));
     }
     else
     {
@@ -3391,7 +3394,7 @@
                 /* nonzero length means that we have a valid, decrypted pa=
cked */
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
                     ret =3D multi_process_post(m, m->pending, mpp_flags);
@@ -3642,7 +3645,8 @@
         {
             pip_flags |=3D PIP_MSSFIX;
         }
-        process_ip_header(&item.instance->context, pip_flags, &item.instan=
ce->context.c2.buf);
+        process_ip_header(&item.instance->context, pip_flags, &item.instan=
ce->context.c2.buf,
+                          item.instance->context.c2.link_sockets[0]);
         encrypt_sign(&item.instance->context, true);
         mbuf_free_buf(item.buffer);

diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 93ac9e7..9b6834a 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -275,7 +275,8 @@

 void multi_top_free(struct multi_context *m);

-struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real);
+struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real,
+                                             struct link_socket *ls);

 void multi_close_instance(struct multi_context *m, struct multi_instance *=
mi, bool shutdown);

@@ -289,7 +290,8 @@
  * existing peer. Updates multi_instance with new address,
  * updates hashtables in multi_context.
  */
-void multi_process_float(struct multi_context *m, struct multi_instance *m=
i);
+void multi_process_float(struct multi_context *m, struct multi_instance *m=
i,
+                         struct link_socket *ls);

 #define MPP_PRE_SELECT             (1<<0)
 #define MPP_CONDITIONAL_PRE_SELECT (1<<1)
@@ -354,8 +356,10 @@
  *                       when using TCP transport. Otherwise NULL, as is
  *                       the case when using UDP transport.
  * @param mpp_flags    - Fast I/O optimization flags.
+ * @param ls           - Socket where the packet was received.
  */
-bool multi_process_incoming_link(struct multi_context *m, struct multi_ins=
tance *instance, const unsigned int mpp_flags);
+bool multi_process_incoming_link(struct multi_context *m, struct multi_ins=
tance *instance, const unsigned int mpp_flags,
+                                 struct link_socket *ls);


 /**
@@ -669,7 +673,7 @@
 #endif
     set_prefix(mi);
     vlan_process_outgoing_tun(m, mi);
-    process_outgoing_tun(&mi->context);
+    process_outgoing_tun(&mi->context, mi->context.c2.link_sockets[0]);
     ret =3D multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
@@ -684,7 +688,7 @@
 {
     bool ret =3D true;
     set_prefix(mi);
-    process_outgoing_link(&mi->context, mi->context.c2.link_socket);
+    process_outgoing_link(&mi->context, mi->context.c2.link_sockets[0]);
     ret =3D multi_process_post(m, mi, mpp_flags);
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

-    struct link_socket *link_socket;     /* socket used for TCP/UDP connec=
tion to remote */
+    struct link_socket **link_sockets;
+    struct link_socket_info **link_socket_infos;
+
     bool link_socket_owned;

-    /** This variable is used instead link_socket->info for P2MP UDP child=
s */
-    struct link_socket_info *link_socket_info;
     const struct link_socket *accept_from; /* possibly do accept() on a pa=
rent link_socket */

     struct link_socket_actual *to_link_addr;    /* IP address of remote */
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 887172c..4a87895 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -63,7 +63,7 @@
         && event_timeout_trigger(&c->c2.ping_rec_interval,
                                  &c->c2.timeval,
                                  (!c->options.ping_timer_remote
-                                  || link_socket_actual_defined(&c->c1.lin=
k_socket_addr.actual))
+                                  || link_socket_actual_defined(&c->c1.lin=
k_socket_addrs[0].actual))
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
+    for (i =3D 0; i < c->c1.link_sockets_num; i++)
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
     status =3D connect(sd, remote, af_addr_size(remote->sa_family));
     if (status)
@@ -1851,9 +1865,9 @@
 }

 void
-link_socket_init_phase1(struct context *c, int mode)
+link_socket_init_phase1(struct context *c, int sock_index, int mode)
 {
-    struct link_socket *sock =3D c->c2.link_socket;
+    struct link_socket *sock =3D c->c2.link_sockets[sock_index];
     struct options *o =3D &c->options;
     ASSERT(sock);

@@ -1879,19 +1893,20 @@
     sock->socket_buffer_sizes.sndbuf =3D o->sndbuf;

     sock->sockflags =3D o->sockflags;
+
 #if PORT_SHARE
     if (o->port_share_host && o->port_share_port)
     {
         sock->sockflags |=3D SF_PORT_SHARE;
     }
 #endif
+
     sock->mark =3D o->mark;
     sock->bind_dev =3D o->bind_dev;
-
     sock->info.proto =3D o->ce.proto;
     sock->info.af =3D o->ce.af;
     sock->info.remote_float =3D o->ce.remote_float;
-    sock->info.lsa =3D &c->c1.link_socket_addr;
+    sock->info.lsa =3D &c->c1.link_socket_addrs[sock_index];
     sock->info.bind_ipv6_only =3D o->ce.bind_ipv6_only;
     sock->info.ipchange_command =3D o->ipchange;
     sock->info.plugins =3D c->plugins;
@@ -2186,9 +2201,9 @@

 /* finalize socket initialization */
 void
-link_socket_init_phase2(struct context *c)
+link_socket_init_phase2(struct context *c,
+                        struct link_socket *sock)
 {
-    struct link_socket *sock =3D c->c2.link_socket;
     const struct frame *frame =3D &c->c2.frame;
     struct signal_info *sig_info =3D c->sig;

@@ -2234,7 +2249,6 @@
         {
             create_socket(sock, sock->info.lsa->current_remote);
         }
-
     }

     /* If socket has not already been created create it now */
@@ -2253,7 +2267,6 @@
                     addr_family_name(sock->info.lsa->bind_local->ai_family=
));
                 sock->info.af =3D sock->info.lsa->bind_local->ai_family;
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e31afeec5df6084
Gerrit-Change-Number: 434
Gerrit-PatchSet: 12
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--TAJoIA3qT5Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/434?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Adapt socket handling to support listening on =
multiple sockets<br><br>    Introduce internal changes preparing the server=
 to<br>    handle multiple sockets concurrently for both<br>    TCP and UDP=
 protocols. While no user-visible<br>    features are implemented yet, thes=
e modifications<br>    are essential for enabling future functionality<br> =
   such as listening on multiple ports.<br><br>    Key changes are: convert=
ing link_socket from a<br>    single pointer to an array in various context=
s,<br>    in order to be able to store multiple sockets<br>    at once.<br>=
<br>Change-Id: Ia0a889e800f0b36aed770ee36e31afeec5df6084<br>Signed-off-by: =
Antonio Quartulli &lt;a@...2181...&gt;<br>Signed-off-by: Gianmarco De Grego=
ri &lt;gianmarco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>Message-Id: &lt;20241230162338.21401-1-gert@...1296...&gt;<br>URL=
: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30309=
.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M sr=
c/openvpn/dco.c<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M =
src/openvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn/mss.c<br>M src/=
openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M src/openvpn/mudp.h<br>M src/ope=
nvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/openvpn.c<br>M src/o=
penvpn/openvpn.h<br>M src/openvpn/ping.h<br>M src/openvpn/socket.c<br>M src=
/openvpn/socket.h<br>16 files changed, 326 insertions(+), 183 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 dcc80d3..8f2adb5 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -478,11 +478,11 @@</span><=
br><span>         return 0;</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_socket *ls =
=3D c-&gt;c2.link_socket;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct link_socket *sock =3D c-&gt;c2.link_sockets[0];</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(ls-=
&gt;info.connection_established);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ASSERT(sock-&gt;info.connection_established);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct sock=
addr *remoteaddr =3D &amp;ls-&gt;info.lsa-&gt;actual.dest.addr.sa;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr *remotea=
ddr =3D &amp;sock-&gt;info.lsa-&gt;actual.dest.addr.sa;</span><br><span>   =
  struct tls_multi *multi =3D c-&gt;c2.tls_multi;</span><br><span> #ifdef T=
ARGET_FREEBSD</span><br><span>     /* In Linux in P2P mode the kernel autom=
atically removes an existing peer</span><br><span>@@ -494,7 +494,7 @@</span=
><br><span>     }</span><br><span> #endif</span><br><span>     int ret =3D =
dco_new_peer(&amp;c-&gt;c1.tuntap-&gt;dco, multi-&gt;peer_id,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                           c-&gt;c2=
.link_socket-&gt;sd, NULL, remoteaddr, NULL, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           c-&gt;c2.link_=
sockets[0]-&gt;sd, NULL, remoteaddr, NULL, NULL);</span><br><span>     if (=
ret &lt; 0)</span><br><span>     {</span><br><span>         return ret;</sp=
an><br><span>@@ -527,12 +527,12 @@</span><br><span> #if ENABLE_IP_PKTINFO</=
span><br><span>     struct context *c =3D &amp;mi-&gt;context;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!proto_i=
s_udp(c-&gt;c2.link_socket-&gt;info.proto) || !(c-&gt;options.sockflags &am=
p; SF_USE_IP_PKTINFO))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!proto_is_udp(c-&gt;c2.link_sockets[0]-&gt;info.proto) || !(c-&g=
t;options.sockflags &amp; SF_USE_IP_PKTINFO))</span><br><span>     {</span>=
<br><span>         return false;</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_socket_=
actual *actual =3D &amp;c-&gt;c2.link_socket_info-&gt;lsa-&gt;actual;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_ac=
tual *actual =3D &amp;c-&gt;c2.link_socket_infos[0]-&gt;lsa-&gt;actual;</sp=
an><br><span> </span><br><span>     switch (actual-&gt;dest.addr.sa.sa_fami=
ly)</span><br><span>     {</span><br><span>@@ -577,7 +577,7 @@</span><br><s=
pan>     int peer_id =3D c-&gt;c2.tls_multi-&gt;peer_id;</span><br><span>  =
   struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><span>     s=
truct sockaddr_storage local =3D { 0 };</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int sd =3D c-&gt;c2.link_socket-&gt;sd;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int sd =3D c-&gt;c2.link_sock=
ets[0]-&gt;sd;</span><br><span> </span><br><span> </span><br><span>     if =
(c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span>@@ -587,8 +587,8 @@</span>=
<br><span>     }</span><br><span>     else</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(c-&gt;c2.link_so=
cket_info-&gt;connection_established);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        remoteaddr =3D &amp;c-&gt;c2.link_socket_info-&gt;=
lsa-&gt;actual.dest.addr.sa;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        ASSERT(c-&gt;c2.link_socket_infos[0]-&gt;connection_establ=
ished);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        remo=
teaddr =3D &amp;c-&gt;c2.link_socket_infos[0]-&gt;lsa-&gt;actual.dest.addr.=
sa;</span><br><span>     }</span><br><span> </span><br><span>     /* In ser=
ver mode we need to fetch the remote addresses from the push config */</spa=
n><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</spa=
n><br><span>index 2c72001..f3f3503 100644</span><br><span>--- a/src/openvpn=
/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -=
58,12 +58,17 @@</span><br><span> wait_status_string(struct context *c, stru=
ct gc_arena *gc)</span><br><span> {</span><br><span>     struct buffer out =
=3D alloc_buf_gc(64, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    buf_printf(&amp;out, &quot;I/O WAIT %s|%s|%s|%s %s&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;I/O WAIT %s|%s| %=
s&quot;,</span><br><span>                tun_stat(c-&gt;c1.tuntap, EVENT_RE=
AD, gc),</span><br><span>                tun_stat(c-&gt;c1.tuntap, EVENT_WR=
ITE, gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
   socket_stat(c-&gt;c2.link_socket, EVENT_READ, gc),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-               socket_stat(c-&gt;c2.link_so=
cket, EVENT_WRITE, gc),</span><br><span>                tv_string(&amp;c-&g=
t;c2.timeval, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;\n %s|%s&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
  socket_stat(c-&gt;c2.link_sockets[i], EVENT_READ, gc),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                   socket_stat(c-&gt;c=
2.link_sockets[i], EVENT_WRITE, gc));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span>     return BSTR(&amp;out);</span><=
br><span> }</span><br><span> </span><br><span>@@ -99,7 +104,7 @@</span><br>=
<span> {</span><br><span>     if (c-&gt;c2.tls_multi &amp;&amp; c-&gt;c2.tl=
s_exit_signal)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (link_socket_connection_oriented(c-&gt;c2.link_s=
ocket))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
link_socket_connection_oriented(c-&gt;c2.link_sockets[0]))</span><br><span>=
         {</span><br><span>             if (c-&gt;c2.tls_multi-&gt;n_soft_e=
rrors)</span><br><span>             {</span><br><span>@@ -567,6 +572,7 @@</=
span><br><span> #ifdef ENABLE_FRAGMENT</span><br><span> /*</span><br><span>=
  * Should we deliver a datagram fragment to remote?</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * c is expected to be a single-link cont=
ext (p2p or child)</span><br><span>  */</span><br><span> static void</span>=
<br><span> check_fragment(struct context *c)</span><br><span>@@ -1123,7 +11=
29,9 @@</span><br><span>         decrypt_status =3D openvpn_decrypt(&amp;c-=
&gt;c2.buf, c-&gt;c2.buffers-&gt;decrypt_buf,</span><br><span>             =
                             co, &amp;c-&gt;c2.frame, ad_start);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!d=
ecrypt_status &amp;&amp; link_socket_connection_oriented(c-&gt;c2.link_sock=
et))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!de=
crypt_status</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     /* on the instance context we have only one socket, so just check the =
first one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &amp;&amp; link_socket_connection_oriented(c-&gt;c2.link_sockets[0]))<=
/span><br><span>         {</span><br><span>             /* decryption error=
s are fatal in TCP mode */</span><br><span>             register_signal(c-&=
gt;sig, SIGUSR1, &quot;decryption-error&quot;); /* SOFT-SIGUSR1 -- decrypti=
on error in TCP mode */</span><br><span>@@ -1451,7 +1459,7 @@</span><br><sp=
an>  */</span><br><span> </span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-process_incoming_tun(struct context *c)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+process_incoming_tun(struct c=
ontext *c, struct link_socket *out_sock)</span><br><span> {</span><br><span=
>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@=
 -1484,7 +1492,7 @@</span><br><span>          */</span><br><span>         u=
nsigned int flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT</span><=
br><span>                              | PIPV6_ICMP_NOHOST_CLIENT;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        process_ip_header(c, f=
lags, &amp;c-&gt;c2.buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        process_ip_header(c, flags, &amp;c-&gt;c2.buf, out_sock);</sp=
an><br><span> </span><br><span> #ifdef PACKET_TRUNCATION_CHECK</span><br><s=
pan>         /* if (c-&gt;c2.buf.len &gt; 1) --c-&gt;c2.buf.len; */</span><=
br><span>@@ -1645,7 +1653,8 @@</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-process=
_ip_header(struct context *c, unsigned int flags, struct buffer *buf)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+process_ip_header(struct =
context *c, unsigned int flags, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  struct link_socket *soc=
k)</span><br><span> {</span><br><span>     if (!c-&gt;options.ce.mssfix)</s=
pan><br><span>     {</span><br><span>@@ -1679,7 +1688,7 @@</span><br><span>=
             /* extract TOS from IP header */</span><br><span>             =
if (flags &amp; PIPV4_PASSTOS)</span><br><span>             {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                link_socket_extract=
_tos(c-&gt;c2.link_socket, &amp;ipbuf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                link_socket_extract_tos(sock, &amp;ipbu=
f);</span><br><span>             }</span><br><span> #endif</span><br><span>=
 </span><br><span>@@ -1887,7 +1896,7 @@</span><br><span>  */</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-process_outgoing_tun(struct context *c)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+process_outgoing_tun(struct context *c, struct link=
_socket *in_sock)</span><br><span> {</span><br><span>     /*</span><br><spa=
n>      * Set up for write() call to TUN/TAP</span><br><span>@@ -1904,9 +19=
13,8 @@</span><br><span>      * The --mssfix option requires</span><br><spa=
n>      * us to examine the IP header (IPv4 or IPv6).</span><br><span>     =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    process_ip_hea=
der(c,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
       PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIENT_NAT | PIP_OUTG=
OING,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
      &amp;c-&gt;c2.to_tun);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV=
4_CLIENT_NAT|PIP_OUTGOING, &amp;c-&gt;c2.to_tun,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                      in_sock);</span><br><spa=
n> </span><br><span>     if (c-&gt;c2.to_tun.len &lt;=3D c-&gt;c2.frame.buf=
.payload_size)</span><br><span>     {</span><br><span>@@ -2180,8 +2188,11 @=
@</span><br><span>     /*</span><br><span>      * Configure event wait base=
d on socket, tuntap flags.</span><br><span>      */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    socket_set(c-&gt;c2.link_socket, c-&gt;=
c2.event_set, socket,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
               &amp;c-&gt;c2.link_socket-&gt;ev_arg, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; c-&gt;=
c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
socket_set(c-&gt;c2.link_sockets[i], c-&gt;c2.event_set, socket,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                   &amp;c-&gt;=
c2.link_sockets[i]-&gt;ev_arg, NULL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span>     tun_set(c-&gt;c1.tuntap, c-&gt=
;c2.event_set, tuntap, (void *)tun_shift, NULL);</span><br><span> #if defin=
ed(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span>     if (socket=
 &amp; EVENT_READ &amp;&amp; c-&gt;c2.did_open_tun)</span><br><span>@@ -221=
9,7 +2230,7 @@</span><br><span> </span><br><span>     if (!c-&gt;sig-&gt;si=
gnal_received)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (!(flags &amp; IOW_CHECK_RESIDUAL) || !socket_re=
ad_residual(c-&gt;c2.link_socket))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!(flags &amp; IOW_CHECK_RESIDUAL) || !sockets_re=
ad_residual(c))</span><br><span>         {</span><br><span>             int=
 status;</span><br><span> </span><br><span>@@ -2311,7 +2322,7 @@</span><br>=
<span>     /* TUN device ready to accept write */</span><br><span>     else=
 if (status &amp; TUN_WRITE)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        process_outgoing_tun(c);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        process_outgoing_tun(c=
, sock);</span><br><span>     }</span><br><span>     /* Incoming data on TC=
P/UDP port */</span><br><span>     else if (status &amp; SOCKET_READ)</span=
><br><span>@@ -2328,7 +2339,7 @@</span><br><span>         read_incoming_tun=
(c);</span><br><span>         if (!IS_SIG(c))</span><br><span>         {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            process_inco=
ming_tun(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     process_incoming_tun(c, sock);</span><br><span>         }</span><br><s=
pan>     }</span><br><span>     else if (status &amp; DCO_READ)</span><br><=
span>diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><=
span>index 4cd470a..ca2a695 100644</span><br><span>--- a/src/openvpn/forwar=
d.h</span><br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -231,10 =
+231,12 @@</span><br><span>  *</span><br><span>  * If an error occurs, it i=
s logged and the packet is dropped.</span><br><span>  *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * @param c - The context structure of th=
e VPN tunnel associated with the</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *     packet.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param c       The context structure of the VPN tunnel associated =
with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
   the packet.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram out_sock  Socket that will be used to send out the packet.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void process_incoming_tun(str=
uct context *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d process_incoming_tun(struct context *c, struct link_socket *out_sock);</s=
pan><br><span> </span><br><span> </span><br><span> /**</span><br><span>@@ -=
246,10 +248,11 @@</span><br><span>  *</span><br><span>  * If an error occur=
s, it is logged and the packet is dropped.</span><br><span>  *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param c - The context structur=
e of the VPN tunnel associated with</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *     the packet.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param c      The context structure of the VPN tunnel assoc=
iated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
   with the packet.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param in_sock  Socket where the packet was received.</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void process_outgoi=
ng_tun(struct context *c);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void process_outgoing_tun(struct context *c, struct link_socket *in_=
sock);</span><br><span> </span><br><span> </span><br><span> /**************=
************************************************************/</span><br><sp=
an>@@ -304,20 +307,21 @@</span><br><span> #define PIPV6_ICMP_NOHOST_SERVER =
       (1&lt;&lt;6)</span><br><span> </span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void process_ip_header(struct context *c,=
 unsigned int flags, struct buffer *buf);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void process_ip_header(struct context *c, unsigned in=
t flags, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                       struct link_socket *sock);</span><br><span>=
 </span><br><span> bool schedule_exit(struct context *c);</span><br><span> =
</span><br><span> static inline struct link_socket_info *</span><br><span> =
get_link_socket_info(struct context *c)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.link_socket_info)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.link_s=
ocket_infos)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        return c-&gt;c2.link_socket_info;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return c-&gt;c2.link_socket_inf=
os[0];</span><br><span>     }</span><br><span>     else</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return &am=
p;c-&gt;c2.link_socket-&gt;info;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return &amp;c-&gt;c2.link_sockets[0]-&gt;info;</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index a23cb2=
4..850cd12 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>=
+++ b/src/openvpn/init.c</span><br><span>@@ -536,12 +536,12 @@</span><br><s=
pan>         {</span><br><span>             /* Check if there is another re=
solved address to try for</span><br><span>              * the current conne=
ction */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (c-&gt;c1.link_socket_addr.current_remote</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                &amp;&amp; c-&gt;c1.link_socket_addr.=
current_remote-&gt;ai_next</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (c-&gt;c1.link_socket_addrs[0].current_remote</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; =
c-&gt;c1.link_socket_addrs[0].current_remote-&gt;ai_next</span><br><span>  =
               &amp;&amp; !c-&gt;options.advance_next_remote)</span><br><sp=
an>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            c-&gt;c1.link_socket_addr.current_remote =3D</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    c-&gt;c1.link_socket=
_addr.current_remote-&gt;ai_next;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                c-&gt;c1.link_socket_addrs[0].current_remote =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    c-&gt;c1.link_socket_addrs[0].current_remote-&gt;ai_next;</span><br><sp=
an>             }</span><br><span>             else</span><br><span>       =
      {</span><br><span>@@ -557,20 +557,20 @@</span><br><span>             =
         * skipped by management on the previous loop.</span><br><span>    =
                  * If so, clear the addrinfo objects as close_instance doe=
s</span><br><span>                      */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    if (c-&gt;c1.link_socket_addr.remo=
te_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         if (c-&gt;c1.link_socket_addrs[0].remote_list)</span><br><span>   =
                  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                      clear_remote_addrlist(&amp;c-&gt;c1.link_socket_addr,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     clear_remote_addrlist(&amp;c-&gt;c1.link_socket_addrs[0],</span><br><s=
pan>                                               !c-&gt;options.resolve_i=
n_advance);</span><br><span>                     }</span><br><span> </span>=
<br><span>                     /* close_instance should have cleared the ad=
drinfo objects */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                ASSERT(c-&gt;c1.link_socket_addr.current_remote =3D=3D NULL=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 ASSERT(c-&gt;c1.link_socket_addr.remote_list =3D=3D NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    ASSERT(c-&gt;c1=
.link_socket_addrs[0].current_remote =3D=3D NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    ASSERT(c-&gt;c1.link_soc=
ket_addrs[0].remote_list =3D=3D NULL);</span><br><span>                 }</=
span><br><span>                 else</span><br><span>                 {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    c-&gt=
;c1.link_socket_addr.current_remote =3D</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        c-&gt;c1.link_socket_addr.remote_=
list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      c-&gt;c1.link_socket_addrs[0].current_remote =3D</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        c-&gt;c1.link_so=
cket_addrs[0].remote_list;</span><br><span>                 }</span><br><sp=
an> </span><br><span>                 int advance_count =3D 1;</span><br><s=
pan>@@ -735,6 +735,13 @@</span><br><span>     uninit_proxy_dowork(c);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+do_link_socket_addr_new(struct context *c)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ALLOC_ARRAY_CLEAR_GC(c-&gt;c1.link_socket_addrs, struct link_s=
ocket_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                 c-&gt;c1.link_sockets_num, &amp;c-&gt;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> void</span><br><span> context_init_=
1(struct context *c)</span><br><span> {</span><br><span>@@ -744,6 +751,10 @=
@</span><br><span> </span><br><span>     init_connection_list(c);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c=
1.link_sockets_num =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do_link_s=
ocket_addr_new(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> #if defined(ENABLE_PKCS11)</span><br><span>     if (c-&gt;=
first_time)</span><br><span>     {</span><br><span>@@ -1644,7 +1655,7 @@</s=
pan><br><span>         CLEAR(local);</span><br><span>         actual =3D &a=
mp;get_link_socket_info(c)-&gt;lsa-&gt;actual;</span><br><span>         rem=
ote =3D actual-&gt;dest;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        getsockname(c-&gt;c2.link_socket-&gt;sd, &amp;local.addr.sa, &am=
p;sa_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        g=
etsockname(c-&gt;c2.link_sockets[0]-&gt;sd, &amp;local.addr.sa, &amp;sa_len=
);</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span>         if (!add=
r_defined(&amp;local))</span><br><span>         {</span><br><span>@@ -1770,=
8 +1781,8 @@</span><br><span>                             c-&gt;options.ifc=
onfig_ipv6_local,</span><br><span>                             c-&gt;option=
s.ifconfig_ipv6_netbits,</span><br><span>                             c-&gt=
;options.ifconfig_ipv6_remote,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                            c-&gt;c1.link_socket_addr.bind_local,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
      c-&gt;c1.link_socket_addr.remote_list,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                            c-&gt;c1.link_socket_a=
ddrs[0].bind_local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                            c-&gt;c1.link_socket_addrs[0].remote_list,</spa=
n><br><span>                             !c-&gt;options.ifconfig_nowarn,</s=
pan><br><span>                             c-&gt;c2.es,</span><br><span>   =
                          &amp;c-&gt;net_ctx,</span><br><span>@@ -1954,17 +=
1965,16 @@</span><br><span>         do_alloc_route_list(c);</span><br><span=
> </span><br><span>         /* parse and resolve the route option list */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(c-&gt;c2=
.link_socket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ASSERT(c-&gt;c2.link_sockets[0]);</span><br><span>         if (c-&gt;opt=
ions.routes &amp;&amp; c-&gt;c1.route_list)</span><br><span>         {</spa=
n><br><span>             do_init_route_list(&amp;c-&gt;options, c-&gt;c1.ro=
ute_list,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                   &amp;c-&gt;c2.link_socket-&gt;info, c-&gt;c2.es, &amp;c-=
&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                         &amp;c-&gt;c2.link_sockets[0]-&gt;info, c-&gt;c2.e=
s, &amp;c-&gt;net_ctx);</span><br><span>         }</span><br><span>        =
 if (c-&gt;options.routes_ipv6 &amp;&amp; c-&gt;c1.route_ipv6_list)</span><=
br><span>         {</span><br><span>             do_init_route_ipv6_list(&a=
mp;c-&gt;options, c-&gt;c1.route_ipv6_list,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                    &amp;c-&gt;c2.lin=
k_socket-&gt;info, c-&gt;c2.es,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                    &amp;c-&gt;net_ctx);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
        &amp;c-&gt;c2.link_sockets[0]-&gt;info, c-&gt;c2.es, &amp;c-&gt;net=
_ctx);</span><br><span>         }</span><br><span> </span><br><span>       =
  /* do ifconfig */</span><br><span>@@ -1977,8 +1987,7 @@</span><br><span> =
                                                 c-&gt;options.dev_type,</s=
pan><br><span>                                                  c-&gt;optio=
ns.dev_node,</span><br><span>                                              =
    &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    do_ifconfig(c-&gt;c1.tuntap, guess, c-&gt;c2.frame.tun_mtu, c-&gt;c2.es=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
    &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            do_ifconfig(c-&gt;c1.tuntap, guess, c-&gt;c2.frame.tun_mtu=
, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span>         }</span><br><s=
pan> </span><br><span>         /* possibly add routes */</span><br><span>@@=
 -1993,6 +2002,7 @@</span><br><span>         /* Store the old fd inside the=
 fd so open_tun can use it */</span><br><span>         c-&gt;c1.tuntap-&gt;=
fd =3D oldtunfd;</span><br><span> #endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>         if (dco_enabled(&amp;c-&gt;o=
ptions))</span><br><span>         {</span><br><span>             ovpn_dco_i=
nit(c-&gt;mode, &amp;c-&gt;c1.tuntap-&gt;dco);</span><br><span>@@ -2004,8 +=
2014,7 @@</span><br><span>         /* set the hardware address */</span><br=
><span>         if (c-&gt;options.lladdr)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            set_lladdr(&amp;=
c-&gt;net_ctx, c-&gt;c1.tuntap-&gt;actual_name, c-&gt;options.lladdr,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                       c-&g=
t;c2.es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  set_lladdr(&amp;c-&gt;net_ctx, c-&gt;c1.tuntap-&gt;actual_name, c-&gt;opt=
ions.lladdr, c-&gt;c2.es);</span><br><span>         }</span><br><span> </sp=
an><br><span>         /* do ifconfig */</span><br><span>@@ -2486,7 +2495,7 =
@@</span><br><span>                 {</span><br><span>                     =
msg(M_NONFATAL, &quot;dco-win doesn&#39;t yet support reopening TUN device&=
quot;);</span><br><span>                     /* prevent link_socket_close()=
 from closing handle with WinSock API */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    c-&gt;c2.link_socket-&gt;sd =3D SOCK=
ET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              c-&gt;c2.link_sockets[0]-&gt;sd =3D SOCKET_UNDEFINED;</span><=
br><span>                     return false;</span><br><span>               =
  }</span><br><span>                 else</span><br><span>@@ -2709,13 +2718=
,23 @@</span><br><span>     if (found &amp; OPT_P_SOCKBUF)</span><br><span>=
     {</span><br><span>         msg(D_PUSH, &quot;OPTIONS IMPORT: --sndbuf/=
--rcvbuf options modified&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        link_socket_update_buffer_sizes(c-&gt;c2.link_socket, c=
-&gt;options.rcvbuf, c-&gt;options.sndbuf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            link_socket_update_buff=
er_sizes(c-&gt;c2.link_sockets[i],</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                            c-&gt;options.rc=
vbuf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                              c-&gt;options.sndbuf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><b=
r><span> </span><br><span>     if (found &amp; OPT_P_SOCKFLAGS)</span><br><=
span>     {</span><br><span>         msg(D_PUSH, &quot;OPTIONS IMPORT: --so=
cket-flags option modified&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        link_socket_update_flags(c-&gt;c2.link_socket, c-&gt;o=
ptions.sockflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            link_socket_update_flags(c-&g=
t;c2.link_sockets[i],</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                     c-&gt;options.sockflags);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>    =
 }</span><br><span> </span><br><span>     if (found &amp; OPT_P_PERSIST)</s=
pan><br><span>@@ -3791,12 +3810,63 @@</span><br><span> static void</span><b=
r><span> do_link_socket_new(struct context *c)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(!c-&gt;c2.link_socke=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2.link_=
socket =3D link_socket_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(!c-&gt;c2.link_sockets);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ALLOC_ARRAY_GC(c-&gt;c2.link_sockets, struct link_socket *,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                   c-&gt=
;c1.link_sockets_num, &amp;c-&gt;c2.gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        c-&gt;c2.link_sockets[i] =3D link_sock=
et_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span>     c-&gt;c2.link_socket_owned =3D true;</span><br><span> }</s=
pan><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * bind TCP/UDP sockets</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_i=
nit_socket_phase1(struct context *c)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        int mode =3D LS_MODE_DEFAULT;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* mode allows CM_CHILD_TCP</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * instances to inherit ac=
ceptable fds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * from a top-level parent */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (c-&gt;options.mode =3D=3D MODE_SERVER)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* initializing listening soc=
ket */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                mode =3D LS_MODE_TCP_LISTEN;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            /* initializing socket to client */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if (c-&g=
t;mode =3D=3D CM_CHILD_TCP)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                mode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* init each socket with its specific args */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        link_socket_init_phase1(c, i, mod=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * finali=
ze TCP/UDP sockets</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+do_init_socket_phase2(str=
uct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; =
i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        link_socket_init_phase2(c, c-&gt;c2.link_sockets[i]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span>  * Print MTU INFO</span><br><span>  */</span><br><span> st=
atic void</span><br><span>@@ -3951,15 +4021,21 @@</span><br><span>     /* i=
n dco-win case, link socket is a tun handle which is</span><br><span>      =
* closed in do_close_tun(). Set it to UNDEFINED so</span><br><span>      * =
we won&#39;t use WinSock API to close it. */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (tuntap_is_dco_win(c-&gt;c1.tuntap) &amp;&amp=
; c-&gt;c2.link_socket)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (tuntap_is_dco_win(c-&gt;c1.tuntap) &amp;&amp; c-&gt;c2.link_soc=
kets)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        c-&gt;c2.link_socket-&gt;sd =3D SOCKET_UNDEFINED;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &l=
t; c-&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            c-&gt;c2.link_sockets[i]-&gt;sd =3D SOCKET_UNDEFINED;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (c-&gt;c2.link_socket &amp;&amp; c-&gt;c2.link_socket_owned)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.link_=
sockets &amp;&amp; c-&gt;c2.link_socket_owned)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        link_socket_close(c=
-&gt;c2.link_socket);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        c-&gt;c2.link_socket =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_n=
um; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            link_sock=
et_close(c-&gt;c2.link_sockets[i]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        c-&gt;c2.link_sockets =3D NULL;</span><br><span>     }</span>=
<br><span> </span><br><span> </span><br><span>@@ -3970,28 +4046,36 @@</span=
><br><span>           &amp;&amp; ( (c-&gt;options.persist_remote_ip)</span>=
<br><span>                ||</span><br><span>                ( c-&gt;sig-&g=
t;source !=3D SIG_SOURCE_HARD</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                 &amp;&amp; ((c-&gt;c1.link_socket_addr.current_rem=
ote</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
    &amp;&amp; c-&gt;c1.link_socket_addr.current_remote-&gt;ai_next)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 &amp;&amp=
; ((c-&gt;c1.link_socket_addrs[0].current_remote</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                      &amp;&amp; c-&gt;c1.link=
_socket_addrs[0].current_remote-&gt;ai_next)</span><br><span>              =
        || c-&gt;options.no_advance))</span><br><span>                )))</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        clear_remote_addrlist(&amp;c-&gt;c1.link_socket_addr, !c-&gt;option=
s.resolve_in_advance);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        clear_remote_addrlist(&amp;c-&gt;c1.link_socket_addrs[0],</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
    !c-&gt;options.resolve_in_advance);</span><br><span>     }</span><br><s=
pan> </span><br><span>     /* Clear the remote actual address when persist_=
remote_ip is not in use */</span><br><span>     if (!(c-&gt;sig-&gt;signal_=
received =3D=3D SIGUSR1 &amp;&amp; c-&gt;options.persist_remote_ip))</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   CLEAR(c-&gt;c1.link_socket_addr.actual);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; c-&gt;c1.link_sock=
ets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            CLEA=
R(c-&gt;c1.link_socket_addrs[i].actual);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </sp=
an><br><span>     if (!(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1 &amp;&=
amp; c-&gt;options.persist_local_ip))</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;c1.link_socket_add=
r.bind_local &amp;&amp; !c-&gt;options.resolve_in_advance)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; c-&=
gt;c1.link_sockets_num; i++)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            freeaddrinfo(c-&gt;c1.link_so=
cket_addr.bind_local);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (c-&gt;c1.link_socket_addrs[i].bind_local</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                &amp;&amp; !c-&gt;options.resol=
ve_in_advance)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     freeaddrinfo(c-&gt;c1.link_socket_addrs[i].bind_local);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c1.link_so=
cket_addr.bind_local =3D NULL;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            c-&gt;c1.link_socket_addrs[i].bind_local =3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span>@@ -4474,7=
 +4558,6 @@</span><br><span> {</span><br><span>     const struct options *o=
ptions =3D &amp;c-&gt;options;</span><br><span>     const bool child =3D (c=
-&gt;mode =3D=3D CM_CHILD_TCP || c-&gt;mode =3D=3D CM_CHILD_UDP);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int link_socket_mode =3D LS=
_MODE_DEFAULT;</span><br><span> </span><br><span>     /* init garbage colle=
ction level */</span><br><span>     gc_init(&amp;c-&gt;c2.gc);</span><br><s=
pan>@@ -4515,21 +4598,6 @@</span><br><span>     /* map in current connectio=
n entry */</span><br><span>     next_connection_entry(c);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* link_socket_mo=
de allows CM_CHILD_TCP</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * instances to inherit acceptable fds</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     * from a top-level parent */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options.ce.proto =3D=3D PRO=
TO_TCP_SERVER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;mode =
=3D=3D CM_TOP)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            link_so=
cket_mode =3D LS_MODE_TCP_LISTEN;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        else if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            link_socket_mode =3D LS_MODE_TCP_ACCEPT_FROM;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>     /* should we disable paging? *=
/</span><br><span>     if (c-&gt;first_time &amp;&amp; options-&gt;mlock)</=
span><br><span>     {</span><br><span>@@ -4672,7 +4740,7 @@</span><br><span=
>     /* bind the TCP/UDP socket */</span><br><span>     if (c-&gt;mode =3D=
=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP || c-&gt;mode =3D=3D CM_CHILD_TCP)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        link_socket_init_phase1(c, link_socket_mode);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        do_init_socket_phase1(c);</span><=
br><span>     }</span><br><span> </span><br><span>     /* initialize tun/ta=
p device object,</span><br><span>@@ -4715,15 +4783,18 @@</span><br><span>  =
   /* finalize the TCP/UDP socket */</span><br><span>     if (c-&gt;mode =
=3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP || c-&gt;mode =3D=3D CM_CHILD_TCP=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        link_socket_init_phase2(c);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        do_init_socket_phase2(c);</span><br><span> </spa=
n><br><span> </span><br><span>         /* Update dynamic frame calculation =
as exact transport socket information</span><br><span>          * (IP vs IP=
v6) may be only available after socket phase2 has finished.</span><br><span=
>          * This is only needed for --static or no crypto, NCP will recalc=
ulate this</span><br><span>          * in tls_session_update_crypto_params =
(P2MP) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fram=
e_calculate_dynamic(&amp;c-&gt;c2.frame, &amp;c-&gt;c1.ks.key_type, &amp;c-=
&gt;options,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                       get_link_socket_info(c));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; c-&gt;c1.link=
_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 frame_calculate_dynamic(&amp;c-&gt;c2.frame, &amp;c-&gt;c1.ks.key_type, &a=
mp;c-&gt;options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                  &amp;c-&gt;c2.link_sockets[i]-&gt;info);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span>     }</span><br><span> </span><br><span>     /*</span><br><span>@@ -=
4851,7 +4922,8 @@</span><br><span> </span><br><span> void</span><br><span> =
inherit_context_child(struct context *dest,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                      const struct context *src)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                      co=
nst struct context *src,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                      struct link_socket *ls)</span><br><span> {</span=
><br><span>     CLEAR(*dest);</span><br><span> </span><br><span>@@ -4864,6 =
+4936,8 @@</span><br><span> </span><br><span>     /* c1 init */</span><br><=
span>     packet_id_persist_init(&amp;dest-&gt;c1.pid_persist);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;c1.link_sockets_nu=
m =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do_link=
_socket_addr_new(dest);</span><br><span> </span><br><span>     dest-&gt;c1.=
ks.key_type =3D src-&gt;c1.ks.key_type;</span><br><span>     /* inherit SSL=
 context */</span><br><span>@@ -4888,7 +4962,7 @@</span><br><span>         =
 * The CM_TOP context does the socket listen(),</span><br><span>          *=
 and the CM_CHILD_TCP context does the accept().</span><br><span>          =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dest-&gt;c2=
.accept_from =3D src-&gt;c2.link_socket;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        dest-&gt;c2.accept_from =3D ls;</span><br><spa=
n>     }</span><br><span> </span><br><span> #ifdef ENABLE_PLUGIN</span><br>=
<span>@@ -4903,28 +4977,33 @@</span><br><span>      */</span><br><span>    =
 dest-&gt;c1.tuntap =3D src-&gt;c1.tuntap;</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* UDP inherits some extra thi=
ngs which TCP does not */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (dest-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        ASSERT(!dest-&gt;c2.link_sockets);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* inherit buffers */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        dest-&gt;c2.buffers =3D src-&gt;c2.buf=
fers;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_ARRAY_GC(dest-&gt;c=
2.link_sockets, struct link_socket *, 1, &amp;dest-&gt;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* inherit parent link_socket and tuntap */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        dest-&gt;c2.li=
nk_sockets[0] =3D ls;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_ARR=
AY_GC(dest-&gt;c2.link_socket_infos, struct link_socket_info *, 1, &amp;des=
t-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        A=
LLOC_OBJ_GC(dest-&gt;c2.link_socket_infos[0], struct link_socket_info, &amp=
;dest-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   *dest-&gt;c2.link_socket_infos[0] =3D ls-&gt;info;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* locally override some link_socket_info fields */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dest-&gt;c2.=
link_socket_infos[0]-&gt;lsa =3D &amp;dest-&gt;c1.link_socket_addrs[0];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        dest-&gt;c2.lin=
k_socket_infos[0]-&gt;connection_established =3D false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     init_instance(dest, src-&gt;c2.=
es, CC_NO_CLOSE | CC_USR1_TO_HUP);</span><br><span>     if (IS_SIG(dest))</=
span><br><span>     {</span><br><span>         return;</span><br><span>    =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* UDP inherits some extra things wh=
ich TCP does not */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (dest-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        /* inherit buffers */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        dest-&gt;c2.buffers =3D src-&gt;c2.buffers;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /* inherit parent link_socket and tuntap */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        dest-&gt;c2.link_=
socket =3D src-&gt;c2.link_socket;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
ALLOC_OBJ_GC(dest-&gt;c2.link_socket_info, struct link_socket_info, &amp;de=
st-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *d=
est-&gt;c2.link_socket_info =3D src-&gt;c2.link_socket-&gt;info;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        /* locally override some link_socket_info fie=
lds */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dest-&g=
t;c2.link_socket_info-&gt;lsa =3D &amp;dest-&gt;c1.link_socket_addr;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        dest-&gt;c2.link_soc=
ket_info-&gt;connection_established =3D false;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span>diff --git a/src/openvpn/init.h b/src/openvp=
n/init.h</span><br><span>index ea7eb30..11c32ac 100644</span><br><span>--- =
a/src/openvpn/init.h</span><br><span>+++ b/src/openvpn/init.h</span><br><sp=
an>@@ -95,7 +95,8 @@</span><br><span> bool do_deferred_options(struct conte=
xt *c, const unsigned int found);</span><br><span> </span><br><span> void i=
nherit_context_child(struct context *dest,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                           const struct context *src);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
        const struct context *src,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                           struct link_socket *ls);</span><b=
r><span> </span><br><span> void inherit_context_top(struct context *dest,</=
span><br><span>                          const struct context *src);</span>=
<br><span>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c</span><br><spa=
n>index ebdec25..89dee7d 100644</span><br><span>--- a/src/openvpn/mss.c</sp=
an><br><span>+++ b/src/openvpn/mss.c</span><br><span>@@ -357,7 +357,7 @@</s=
pan><br><span>     struct link_socket_info *lsi =3D get_link_socket_info(c)=
;</span><br><span>     struct options *o =3D &amp;c-&gt;options;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int pmtu =
=3D c-&gt;c2.link_socket-&gt;mtu;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int pmtu =3D c-&gt;c2.link_sockets[0]-&gt;mtu;</span><br>=
<span>     sa_family_t af =3D lsi-&gt;lsa-&gt;actual.dest.addr.sa.sa_family=
;</span><br><span>     int proto =3D lsi-&gt;proto;</span><br><span> </span=
><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><=
span>index a2841f0..b5bbf13 100644</span><br><span>--- a/src/openvpn/mtcp.c=
</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -114,13 +114,1=
3 @@</span><br><span> #endif /* ENABLE_DEBUG */</span><br><span> </span><br=
><span> static struct multi_instance *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-multi_create_instance_tcp(struct multi_context *m)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+multi_create_instance_tcp(s=
truct multi_context *m, struct link_socket *ls)</span><br><span> {</span><b=
r><span>     struct gc_arena gc =3D gc_new();</span><br><span>     struct m=
ulti_instance *mi =3D NULL;</span><br><span>     struct hash *hash =3D m-&g=
t;hash;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    mi =3D multi_create_instance(m, NULL);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    mi =3D multi_create_instance(m, NULL, ls);</=
span><br><span>     if (mi)</span><br><span>     {</span><br><span>        =
 struct hash_element *he;</span><br><span>@@ -170,13 +170,16 @@</span><br><=
span>     /* buffer for queued TCP socket output packets */</span><br><span=
>     mi-&gt;tcp_link_out_deferred =3D mbuf_init(m-&gt;top.options.n_bcast_=
buf);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ASSERT(mi-&gt;context.c2.link_socket);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;context.c2.link_socket-&gt;info.ls=
a);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;=
context.c2.link_socket-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;context.c2.lin=
k_socket-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =3D=3D AF_INET</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-           || mi-&gt;conte=
xt.c2.link_socket-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =3D=3D AF_=
INET6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-=
&gt;context.c2.link_sockets);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(mi-&gt;context.c2.link_sockets[0]);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context.c2.link_sock=
ets[0]-&gt;info.lsa);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ASSERT(mi-&gt;context.c2.link_sockets[0]-&gt;mode =3D=3D LS_MODE_TCP_=
ACCEPT_FROM);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AS=
SERT(mi-&gt;context.c2.link_sockets[0]-&gt;info.lsa-&gt;actual.dest.addr.sa=
.sa_family =3D=3D AF_INET</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+           || mi-&gt;context.c2.link_sockets[0]-&gt;info.lsa-&gt;actu=
al.dest.addr.sa.sa_family =3D=3D AF_INET6</span><br><span>            );</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mroute_extract_=
openvpn_sockaddr(&amp;mi-&gt;real, &amp;mi-&gt;context.c2.link_socket-&gt;i=
nfo.lsa-&gt;actual.dest, true))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!mroute_extract_openvpn_sockaddr(&amp;mi-&gt;real,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                 &amp;mi-&gt;context.c2.link_sockets[0]-&gt;info.lsa-&gt;ac=
tual.dest,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                true))</span><br><span>     {</span><br><sp=
an>         msg(D_MULTI_ERRORS, &quot;MULTI TCP: TCP client address is unde=
fined&quot;);</span><br><span>         return false;</span><br><span>@@ -23=
2,7 +235,7 @@</span><br><span> void</span><br><span> multi_tcp_dereference_=
instance(struct multi_tcp *mtcp, struct multi_instance *mi)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_so=
cket *ls =3D mi-&gt;context.c2.link_socket;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct link_socket *ls =3D mi-&gt;context.c2.li=
nk_sockets[0];</span><br><span>     if (ls &amp;&amp; mi-&gt;socket_set_cal=
led)</span><br><span>     {</span><br><span>         event_del(mtcp-&gt;es,=
 socket_event_handle(ls));</span><br><span>@@ -247,7 +250,7 @@</span><br><s=
pan>     if (mi)</span><br><span>     {</span><br><span>         mi-&gt;soc=
ket_set_called =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        socket_set(mi-&gt;context.c2.link_socket,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        socket_set(mi-&gt;context.c2.link=
_sockets[0],</span><br><span>                    m-&gt;mtcp-&gt;es,</span><=
br><span>                    mbuf_defined(mi-&gt;tcp_link_out_deferred) ? E=
VENT_WRITE : EVENT_READ,</span><br><span>                    &amp;mi-&gt;ev=
_arg,</span><br><span>@@ -261,8 +264,12 @@</span><br><span> {</span><br><sp=
an>     int status;</span><br><span>     unsigned int *persistent =3D &amp;=
mtcp-&gt;tun_rwflags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    socket_set_listen_persistent(c-&gt;c2.link_socket, mtcp-&gt;es,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
    &amp;c-&gt;c2.link_socket-&gt;ev_arg);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        socket_set_listen_persistent(c-&gt;c=
2.link_sockets[i], mtcp-&gt;es,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                     &amp;c-&gt;c2.link_sockets=
[i]-&gt;ev_arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span>     if=
 (tuntap_is_wintun(c-&gt;c1.tuntap))</span><br><span>@@ -480,16 +487,18 @@<=
/span><br><span>         case TA_SOCKET_READ:</span><br><span>         case=
 TA_SOCKET_READ_RESIDUAL:</span><br><span>             ASSERT(mi);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi-&gt;cont=
ext.c2.link_socket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            ASSERT(mi-&gt;context.c2.link_sockets);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ASSERT(mi-&gt;context.c2.link=
_sockets[0]);</span><br><span>             set_prefix(mi);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            read_incoming_link(&amp;mi=
-&gt;context, mi-&gt;context.c2.link_socket);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            read_incoming_link(&amp;mi-&gt;contex=
t, mi-&gt;context.c2.link_sockets[0]);</span><br><span>             clear_p=
refix();</span><br><span>             if (!IS_SIG(&amp;mi-&gt;context))</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                multi_process_incoming_link(m, mi, mpp_flags);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                multi_proc=
ess_incoming_link(m, mi, mpp_flags,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                            mi-&gt;context.=
c2.link_sockets[0]);</span><br><span>                 if (!IS_SIG(&amp;mi-&=
gt;context))</span><br><span>                 {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    stream_buf_read_setup(mi-&gt;=
context.c2.link_socket);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    stream_buf_read_setup(mi-&gt;context.c2.link_socke=
ts[0]);</span><br><span>                 }</span><br><span>             }</=
span><br><span>             break;</span><br><span>@@ -565,7 +574,7 @@</spa=
n><br><span>             break;</span><br><span> </span><br><span>         =
case MTP_NONE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (mi &amp;&amp; socket_read_residual(c-&gt;c2.link_socket))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (mi &amp;&amp=
; sockets_read_residual(c))</span><br><span>             {</span><br><span>=
                 newaction =3D TA_SOCKET_READ_RESIDUAL;</span><br><span>   =
          }</span><br><span>@@ -720,9 +729,14 @@</span><br><span> </span><b=
r><span>                 /* new incoming TCP client attempting to connect? =
*/</span><br><span>                 case EVENT_ARG_LINK_SOCKET:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    ASSERT(m-&gt;=
top.c2.link_socket);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   socket_reset_listen_persistent(m-&gt;top.c2.link_socket)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
mi =3D multi_create_instance_tcp(m);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    if (!ev_arg-&gt;u.sock)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        msg(D_MU=
LTI_ERRORS, &quot;MULTI: mtcp_proc_io: null socket&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        break;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    socket_reset_listen_p=
ersistent(ev_arg-&gt;u.sock);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    mi =3D multi_create_instance_tcp(m, ev_arg-&g=
t;u.sock);</span><br><span>                     if (mi)</span><br><span>   =
                  {</span><br><span>                         multi_tcp_acti=
on(m, mi, TA_INITIAL, false);</span><br><span>diff --git a/src/openvpn/mudp=
.c b/src/openvpn/mudp.c</span><br><span>index 5fbd7b0..6137578 100644</span=
><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.=
c</span><br><span>@@ -185,7 +185,8 @@</span><br><span>  */</span><br><span>=
 </span><br><span> struct multi_instance *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-multi_get_create_instance_udp(struct multi_context *m,=
 bool *floated)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mult=
i_get_create_instance_udp(struct multi_context *m, bool *floated,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
 struct link_socket *ls)</span><br><span> {</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span>     struct mroute_addr real =3D {0}=
;</span><br><span>@@ -256,7 +257,7 @@</span><br><span>                     =
 * connect-freq but not against connect-freq-initial */</span><br><span>   =
                  reflect_filter_rate_limit_decrease(m-&gt;initial_rate_lim=
iter);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    mi =3D multi_create_instance(m, &amp;real);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    mi =3D m=
ulti_create_instance(m, &amp;real, ls);</span><br><span>                   =
  if (mi)</span><br><span>                     {</span><br><span>          =
               hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span=
><br><span>@@ -317,7 +318,7 @@</span><br><span>         msg_set_prefix(&quo=
t;Connection Attempt&quot;);</span><br><span>         m-&gt;top.c2.to_link =
=3D m-&gt;hmac_reply;</span><br><span>         m-&gt;top.c2.to_link_addr =
=3D m-&gt;hmac_reply_dest;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        process_outgoing_link(&amp;m-&gt;top, m-&gt;top.c2.link_socket=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        process_o=
utgoing_link(&amp;m-&gt;top, m-&gt;top.c2.link_sockets[0]);</span><br><span=
>         m-&gt;hmac_reply_dest =3D NULL;</span><br><span>     }</span><br>=
<span> }</span><br><span>@@ -326,7 +327,7 @@</span><br><span>  * Process an=
 I/O event.</span><br><span>  */</span><br><span> static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-multi_process_io_udp(struct multi_c=
ontext *m)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_pro=
cess_io_udp(struct multi_context *m, struct link_socket *sock)</span><br><s=
pan> {</span><br><span>     const unsigned int status =3D m-&gt;top.c2.even=
t_set_status;</span><br><span>     const unsigned int mpp_flags =3D m-&gt;t=
op.c2.fast_io</span><br><span>@@ -380,10 +381,10 @@</span><br><span>     /*=
 Incoming data on UDP port */</span><br><span>     else if (status &amp; SO=
CKET_READ)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        read_incoming_link(&amp;m-&gt;top, m-&gt;top.c2.link_so=
cket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        read_=
incoming_link(&amp;m-&gt;top, sock);</span><br><span>         if (!IS_SIG(&=
amp;m-&gt;top))</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            multi_process_incoming_link(m, NULL, mpp_f=
lags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
ulti_process_incoming_link(m, NULL, mpp_flags, sock);</span><br><span>     =
    }</span><br><span>     }</span><br><span>     /* Incoming data on TUN d=
evice */</span><br><span>@@ -514,7 +515,11 @@</span><br><span>         else=
</span><br><span>         {</span><br><span>             /* process I/O */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_proc=
ess_io_udp(&amp;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* =
Since there&#39;s only one link_socket just use the first, in an upcoming</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * patch =
this will be changed by using the link_socket returned by the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             * event set */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_process=
_io_udp(&amp;multi, top-&gt;c2.link_sockets[0]);</span><br><span>          =
   MULTI_CHECK_SIG(&amp;multi);</span><br><span>         }</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h</spa=
n><br><span>index 14e90d0..b378754 100644</span><br><span>--- a/src/openvpn=
/mudp.h</span><br><span>+++ b/src/openvpn/mudp.h</span><br><span>@@ -55,12 =
+55,14 @@</span><br><span>  * it.  If no entry exists, this function handle=
s its creation, and if</span><br><span>  * successful, returns the newly cr=
eated instance.</span><br><span>  *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * @param m            - The single multi_context structure.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m         =
  - The single multi_context structure.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param ls          - Listening socket where this ins=
tance is connecting to</span><br><span>  *</span><br><span>  * @return A po=
inter to a multi_instance if one already existed for the</span><br><span>  =
*     packet&#39;s source address or if one was a newly created successfull=
y.</span><br><span>  *      NULL if one did not yet exist and a new one was=
 not created.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-struct multi_instance *multi_get_create_instance_udp(struct mu=
lti_context *m, bool *floated);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct multi_instance *multi_get_create_instance_udp(struct mul=
ti_context *m, bool *floated,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                                     struct link_=
socket *ls);</span><br><span> </span><br><span> #endif /* ifndef MUDP_H */<=
/span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</spa=
n><br><span>index 45b3cfa..67bb58f 100644</span><br><span>--- a/src/openvpn=
/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -750,=
7 +750,8 @@</span><br><span>  * Create a client instance object for a newly=
 connected client.</span><br><span>  */</span><br><span> struct multi_insta=
nce *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_create_ins=
tance(struct multi_context *m, const struct mroute_addr *real)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+multi_create_instance(struct mul=
ti_context *m, const struct mroute_addr *real,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                      struct link_socket *ls)</s=
pan><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</spa=
n><br><span>     struct multi_instance *mi;</span><br><span>@@ -773,7 +774,=
7 @@</span><br><span>         generate_prefix(mi);</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nherit_context_child(&amp;mi-&gt;context, &amp;m-&gt;top);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    inherit_context_child(&amp;mi-&g=
t;context, &amp;m-&gt;top, ls);</span><br><span>     if (IS_SIG(&amp;mi-&gt=
;context))</span><br><span>     {</span><br><span>         goto err;</span>=
<br><span>@@ -3124,7 +3125,8 @@</span><br><span> }</span><br><span> </span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_=
process_float(struct multi_context *m, struct multi_instance *mi)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+multi_process_float(struct mu=
lti_context *m, struct multi_instance *mi,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    struct link_socket *ls)</span><b=
r><span> {</span><br><span>     struct mroute_addr real =3D {0};</span><br>=
<span>     struct hash *hash =3D m-&gt;hash;</span><br><span>@@ -3180,8 +31=
82,8 @@</span><br><span>     mi-&gt;context.c2.to_link_addr =3D &amp;mi-&gt=
;context.c2.from;</span><br><span> </span><br><span>     /* inherit parent =
link_socket and link_socket_info */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    mi-&gt;context.c2.link_socket =3D m-&gt;top.c2.link_socke=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context.=
c2.link_socket_info-&gt;lsa-&gt;actual =3D m-&gt;top.c2.from;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;context.c2.link_socket=
s[0] =3D ls;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-=
&gt;context.c2.link_socket_infos[0]-&gt;lsa-&gt;actual =3D m-&gt;top.c2.fro=
m;</span><br><span> </span><br><span>     tls_update_remote_addr(mi-&gt;con=
text.c2.tls_multi, &amp;mi-&gt;context.c2.from);</span><br><span> </span><b=
r><span>@@ -3329,7 +3331,8 @@</span><br><span>  * i.e. client -&gt; server =
direction.</span><br><span>  */</span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-multi_process_incoming_link(struct multi_co=
ntext *m, struct multi_instance *instance, const unsigned int mpp_flags)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_process_incoming=
_link(struct multi_context *m, struct multi_instance *instance,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                            con=
st unsigned int mpp_flags, struct link_socket *ls)</span><br><span> {</span=
><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><b=
r><span>@@ -3350,7 +3353,7 @@</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOO=
P</span><br><span>         printf(&quot;TCP/UDP -&gt; TUN [%d]\n&quot;, BLE=
N(&amp;m-&gt;top.c2.buf));</span><br><span> #endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        multi_set_pending(m, multi_get_create_=
instance_udp(m, &amp;floated));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        multi_set_pending(m, multi_get_create_instance_udp(m, &=
amp;floated, ls));</span><br><span>     }</span><br><span>     else</span><=
br><span>     {</span><br><span>@@ -3391,7 +3394,7 @@</span><br><span>     =
            /* nonzero length means that we have a valid, decrypted packed =
*/</span><br><span>                 if (floated &amp;&amp; c-&gt;c2.buf.len=
 &gt; 0)</span><br><span>                 {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    multi_process_float(m, m-&gt;pend=
ing);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      multi_process_float(m, m-&gt;pending, ls);</span><br><span>          =
       }</span><br><span> </span><br><span>                 process_incomin=
g_link_part2(c, lsi, orig_buf);</span><br><span>@@ -3610,7 +3613,7 @@</span=
><br><span>                     }</span><br><span> </span><br><span>       =
              /* encrypt in instance context */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    process_incoming_tun(c);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    proc=
ess_incoming_tun(c, c-&gt;c2.link_sockets[0]);</span><br><span> </span><br>=
<span>                     /* postprocess and set wakeup */</span><br><span=
>                     ret =3D multi_process_post(m, m-&gt;pending, mpp_flag=
s);</span><br><span>@@ -3642,7 +3645,8 @@</span><br><span>         {</span>=
<br><span>             pip_flags |=3D PIP_MSSFIX;</span><br><span>         =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        process_ip_h=
eader(&amp;item.instance-&gt;context, pip_flags, &amp;item.instance-&gt;con=
text.c2.buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  process_ip_header(&amp;item.instance-&gt;context, pip_flags, &amp;item.in=
stance-&gt;context.c2.buf,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                          item.instance-&gt;context.c2.link_sockets[=
0]);</span><br><span>         encrypt_sign(&amp;item.instance-&gt;context, =
true);</span><br><span>         mbuf_free_buf(item.buffer);</span><br><span=
> </span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</=
span><br><span>index 93ac9e7..9b6834a 100644</span><br><span>--- a/src/open=
vpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -2=
75,7 +275,8 @@</span><br><span> </span><br><span> void multi_top_free(struc=
t multi_context *m);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-struct multi_instance *multi_create_instance(struct multi_=
context *m, const struct mroute_addr *real);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct multi_instance *multi_create_instance(struc=
t multi_context *m, const struct mroute_addr *real,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
    struct link_socket *ls);</span><br><span> </span><br><span> void multi_=
close_instance(struct multi_context *m, struct multi_instance *mi, bool shu=
tdown);</span><br><span> </span><br><span>@@ -289,7 +290,8 @@</span><br><sp=
an>  * existing peer. Updates multi_instance with new address,</span><br><s=
pan>  * updates hashtables in multi_context.</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void multi_process_float(struct=
 multi_context *m, struct multi_instance *mi);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void multi_process_float(struct multi_context *m=
, struct multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                         struct link_socket *ls);</span><br><span>=
 </span><br><span> #define MPP_PRE_SELECT             (1&lt;&lt;0)</span><b=
r><span> #define MPP_CONDITIONAL_PRE_SELECT (1&lt;&lt;1)</span><br><span>@@=
 -354,8 +356,10 @@</span><br><span>  *                       when using TCP=
 transport. Otherwise NULL, as is</span><br><span>  *                      =
 the case when using UDP transport.</span><br><span>  * @param mpp_flags   =
 - Fast I/O optimization flags.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param ls           - Socket where the packet was received.<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-b=
ool multi_process_incoming_link(struct multi_context *m, struct multi_insta=
nce *instance, const unsigned int mpp_flags);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool multi_process_incoming_link(struct multi_con=
text *m, struct multi_instance *instance, const unsigned int mpp_flags,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
          struct link_socket *ls);</span><br><span> </span><br><span> </spa=
n><br><span> /**</span><br><span>@@ -669,7 +673,7 @@</span><br><span> #endi=
f</span><br><span>     set_prefix(mi);</span><br><span>     vlan_process_ou=
tgoing_tun(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 process_outgoing_tun(&amp;mi-&gt;context);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    process_outgoing_tun(&amp;mi-&gt;context, mi-&g=
t;context.c2.link_sockets[0]);</span><br><span>     ret =3D multi_process_p=
ost(m, mi, mpp_flags);</span><br><span>     clear_prefix();</span><br><span=
>     return ret;</span><br><span>@@ -684,7 +688,7 @@</span><br><span> {</s=
pan><br><span>     bool ret =3D true;</span><br><span>     set_prefix(mi);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    process_outgoing_l=
ink(&amp;mi-&gt;context, mi-&gt;context.c2.link_socket);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_link(&amp;mi-&gt;=
context, mi-&gt;context.c2.link_sockets[0]);</span><br><span>     ret =3D m=
ulti_process_post(m, mi, mpp_flags);</span><br><span>     clear_prefix();</=
span><br><span>     return ret;</span><br><span>diff --git a/src/openvpn/op=
envpn.c b/src/openvpn/openvpn.c</span><br><span>index c52540c..977d02d 1006=
44</span><br><span>--- a/src/openvpn/openvpn.c</span><br><span>+++ b/src/op=
envpn/openvpn.c</span><br><span>@@ -91,7 +91,7 @@</span><br><span>         =
}</span><br><span> </span><br><span>         /* process the I/O which trigg=
ered select */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 process_io(c, c-&gt;c2.link_socket);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        process_io(c, c-&gt;c2.link_sockets[0]);</span><b=
r><span>         P2P_CHECK_SIG();</span><br><span> </span><br><span>       =
  perf_pop();</span><br><span>diff --git a/src/openvpn/openvpn.h b/src/open=
vpn/openvpn.h</span><br><span>index 8dfcab4..df43bba 100644</span><br><span=
>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</s=
pan><br><span>@@ -154,7 +154,8 @@</span><br><span>  */</span><br><span> str=
uct context_1</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct link_socket_addr link_socket_addr;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int link_sockets_num;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_addr *lin=
k_socket_addrs;</span><br><span>     /**&lt; Local and remote addresses on =
the</span><br><span>      *   external network. */</span><br><span> </span>=
<br><span>@@ -233,11 +234,11 @@</span><br><span>     /* bitmask for event s=
tatus. Check event.h for possible values */</span><br><span>     unsigned i=
nt event_set_status;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct link_socket *link_socket;     /* socket used fo=
r TCP/UDP connection to remote */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct link_socket **link_sockets;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_info **link_socket=
_infos;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     bool link_socket_owned;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /** This variable is used instead link_=
socket-&gt;info for P2MP UDP childs */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct link_socket_info *link_socket_info;</span><br><=
span>     const struct link_socket *accept_from; /* possibly do accept() on=
 a parent link_socket */</span><br><span> </span><br><span>     struct link=
_socket_actual *to_link_addr;    /* IP address of remote */</span><br><span=
>diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h</span><br><span>index=
 887172c..4a87895 100644</span><br><span>--- a/src/openvpn/ping.h</span><br=
><span>+++ b/src/openvpn/ping.h</span><br><span>@@ -63,7 +63,7 @@</span><br=
><span>         &amp;&amp; event_timeout_trigger(&amp;c-&gt;c2.ping_rec_int=
erval,</span><br><span>                                  &amp;c-&gt;c2.time=
val,</span><br><span>                                  (!c-&gt;options.ping=
_timer_remote</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                          || link_socket_actual_defined(&amp;c-&gt;c1.link_=
socket_addr.actual))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                  || link_socket_actual_defined(&amp;c-&gt=
;c1.link_socket_addrs[0].actual))</span><br><span>                         =
         ? ETT_DEFAULT : 15))</span><br><span>     {</span><br><span>      =
   trigger_ping_timeout_signal(c);</span><br><span>diff --git a/src/openvpn=
/socket.c b/src/openvpn/socket.c</span><br><span>index b895bd4..f9f2a3b 100=
644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/op=
envpn/socket.c</span><br><span>@@ -42,6 +42,21 @@</span><br><span> </span><=
br><span> #include &quot;memdbg.h&quot;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+sockets_read_residual(const struct context *c)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (c-&gt;c2.link_sockets[i]-&gt;strea=
m_buf.residual_fully_formed)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  *=
 Convert sockflags/getaddr_flags into getaddr_flags</span><br><span>  */</s=
pan><br><span>@@ -1454,7 +1469,6 @@</span><br><span> #ifdef TARGET_ANDROID<=
/span><br><span>     protect_fd_nonlocal(sd, remote);</span><br><span> #end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>  =
   set_nonblock(sd);</span><br><span>     status =3D connect(sd, remote, af=
_addr_size(remote-&gt;sa_family));</span><br><span>     if (status)</span><=
br><span>@@ -1851,9 +1865,9 @@</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_so=
cket_init_phase1(struct context *c, int mode)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+link_socket_init_phase1(struct context *c, int so=
ck_index, int mode)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct link_socket *sock =3D c-&gt;c2.link_socket;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket =
*sock =3D c-&gt;c2.link_sockets[sock_index];</span><br><span>     struct op=
tions *o =3D &amp;c-&gt;options;</span><br><span>     ASSERT(sock);</span><=
br><span> </span><br><span>@@ -1879,19 +1893,20 @@</span><br><span>     soc=
k-&gt;socket_buffer_sizes.sndbuf =3D o-&gt;sndbuf;</span><br><span> </span>=
<br><span>     sock-&gt;sockflags =3D o-&gt;sockflags;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if PORT_SHARE</span><=
br><span>     if (o-&gt;port_share_host &amp;&amp; o-&gt;port_share_port)</=
span><br><span>     {</span><br><span>         sock-&gt;sockflags |=3D SF_P=
ORT_SHARE;</span><br><span>     }</span><br><span> #endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     sock-&gt;mark =
=3D o-&gt;mark;</span><br><span>     sock-&gt;bind_dev =3D o-&gt;bind_dev;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
sock-&gt;info.proto =3D o-&gt;ce.proto;</span><br><span>     sock-&gt;info.=
af =3D o-&gt;ce.af;</span><br><span>     sock-&gt;info.remote_float =3D o-&=
gt;ce.remote_float;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  sock-&gt;info.lsa =3D &amp;c-&gt;c1.link_socket_addr;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info.lsa =3D &amp;c-&gt;c1=
.link_socket_addrs[sock_index];</span><br><span>     sock-&gt;info.bind_ipv=
6_only =3D o-&gt;ce.bind_ipv6_only;</span><br><span>     sock-&gt;info.ipch=
ange_command =3D o-&gt;ipchange;</span><br><span>     sock-&gt;info.plugins=
 =3D c-&gt;plugins;</span><br><span>@@ -2186,9 +2201,9 @@</span><br><span> =
</span><br><span> /* finalize socket initialization */</span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_init_pha=
se2(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+link_socket_init_phase2(struct context *c,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                        struct link_socket *sock)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct link_socket *sock =3D c-&gt;c2.link_socket;</span><br><span>     c=
onst struct frame *frame =3D &amp;c-&gt;c2.frame;</span><br><span>     stru=
ct signal_info *sig_info =3D c-&gt;sig;</span><br><span> </span><br><span>@=
@ -2234,7 +2249,6 @@</span><br><span>         {</span><br><span>           =
  create_socket(sock, sock-&gt;info.lsa-&gt;current_remote);</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span>     }</span><br><span> </span><br><span>     /* If socket has not =
already been created create it now */</span><br><span>@@ -2253,7 +2267,6 @@=
</span><br><span>                     addr_family_name(sock-&gt;info.lsa-&g=
t;bind_local-&gt;ai_family));</span><br><span>                 sock-&gt;inf=
o.af =3D sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span>  =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span>             create_socket(sock, sock-&gt;info.lsa-&gt;bind_local);=
</span><br><span>         }</span><br><span>     }</span><br><span>diff --g=
it a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span>index 465d=
92b..16106d4 100644</span><br><span>--- a/src/openvpn/socket.h</span><br><s=
pan>+++ b/src/openvpn/socket.h</span><br><span>@@ -344,9 +344,13 @@</span><=
br><span> /*</span><br><span>  * Initialize link_socket object.</span><br><=
span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void link_so=
cket_init_phase1(struct context *c, int mode);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+link_socket_init_phase1(struct context *c,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        int sock_index,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    int mode);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void link_socket_init_phase2(struct context *c);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void link_socket_init_phase2(struct=
 context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                      struct link_socket *sock);</span><br><span> </span><b=
r><span> void do_preresolve(struct context *c);</span><br><span> </span><br=
><span>@@ -1228,11 +1232,12 @@</span><br><span>  * Socket I/O wait function=
s</span><br><span>  */</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-socket_read_residual(const struct link_socket *sock)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return sock &amp;&amp; sock-&gt;stream_buf.r=
esidual_fully_formed;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Extends the pre-existing read re=
sidual logic</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to a=
ll initialized sockets, ensuring the complete</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * packet is read.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool sockets_read_residual(const struct context *c);</span><br><sp=
an> </span><br><span> static inline event_t</span><br><span> socket_event_h=
andle(const struct link_socket *sock)</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Dem=
ail">change 434</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e3=
1afeec5df6084 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 434 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@...1664...=
26...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--TAJoIA3qT5Y=--

