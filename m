From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 11 Oct 2024 14:07:43 +0000
In-Reply-To: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
References: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <93ebb5413e2ac9a21b25f03a184a7af18f31d3d9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r/WalaqeY9g="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: allow tcp/udp server
 to listen on multiple ports at the same time
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

--r/WalaqeY9g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos.

its_Giaan has uploaded a new patch set (#5) to the change originally create=
d by ordex. ( http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail )


Change subject: allow tcp/udp server to listen on multiple ports at the sam=
e time
......................................................................

allow tcp/udp server to listen on multiple ports at the same time

Change-Id: Ia0a889e800f0b36aed770ee36e31afeec5df6084
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/dco.c
M src/openvpn/event.h
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
17 files changed, 459 insertions(+), 237 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/434/5

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 38f934a..c18ba3e 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -479,11 +479,11 @@
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
@@ -495,7 +495,7 @@
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
@@ -528,12 +528,12 @@
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
@@ -578,7 +578,7 @@
     int peer_id =3D c->c2.tls_multi->peer_id;
     struct sockaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
-    int sd =3D c->c2.link_socket->sd;
+    int sd =3D c->c2.link_sockets[0]->sd;


     if (c->mode =3D=3D CM_CHILD_TCP)
@@ -588,8 +588,8 @@
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
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index c212e07..329a8f8 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -141,6 +141,7 @@
 struct event_arg
 {
     event_arg_t type;
+    bool pending; /* in UDP/P2P mode marks sockets waiting for processing =
*/
     union {
         struct multi_instance *mi; /* if type =3D EVENT_ARG_MULTI_INSTANCE=
 */
         struct link_socket *sock; /* if type =3D EVENT_ARG_LINK_SOCKET */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d50b24c..5e56be0 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -58,12 +58,18 @@
 wait_status_string(struct context *c, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(64, gc);
-    buf_printf(&out, "I/O WAIT %s|%s|%s|%s %s",
+    int i;
+
+    buf_printf(&out, "I/O WAIT %s|%s| %s",
                tun_stat(c->c1.tuntap, EVENT_READ, gc),
                tun_stat(c->c1.tuntap, EVENT_WRITE, gc),
-               socket_stat(c->c2.link_socket, EVENT_READ, gc),
-               socket_stat(c->c2.link_socket, EVENT_WRITE, gc),
                tv_string(&c->c2.timeval, gc));
+    for (i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        buf_printf(&out, "\n %s|%s",
+                   socket_stat(c->c2.link_sockets[i], EVENT_READ, gc),
+                   socket_stat(c->c2.link_sockets[i], EVENT_WRITE, gc));
+    }
     return BSTR(&out);
 }

@@ -99,7 +105,7 @@
 {
     if (c->c2.tls_multi && c->c2.tls_exit_signal)
     {
-        if (link_socket_connection_oriented(c->c2.link_socket))
+        if (link_socket_connection_oriented(c->c2.link_sockets[0]))
         {
             if (c->c2.tls_multi->n_soft_errors)
             {
@@ -567,6 +573,7 @@
 #ifdef ENABLE_FRAGMENT
 /*
  * Should we deliver a datagram fragment to remote?
+ * c is expected to be a single-link context (p2p or child)
  */
 static void
 check_fragment(struct context *c)
@@ -1123,7 +1130,9 @@
         decrypt_status =3D openvpn_decrypt(&c->c2.buf, c->c2.buffers->decr=
ypt_buf,
                                          co, &c->c2.frame, ad_start);

-        if (!decrypt_status && link_socket_connection_oriented(c->c2.link_=
socket))
+        if (!decrypt_status
+            /* all sockets are of the same type, so just check the first o=
ne */
+            && link_socket_connection_oriented(c->c2.link_sockets[0]))
         {
             /* decryption errors are fatal in TCP mode */
             register_signal(c->sig, SIGUSR1, "decryption-error"); /* SOFT-=
SIGUSR1 -- decryption error in TCP mode */
@@ -1454,7 +1463,7 @@
  */

 void
-process_incoming_tun(struct context *c)
+process_incoming_tun(struct context *c, struct link_socket *out_ls)
 {
     struct gc_arena gc =3D gc_new();

@@ -1487,7 +1496,8 @@
          */
         unsigned int flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_N=
AT
                              | PIPV6_ICMP_NOHOST_CLIENT;
-        process_ip_header(c, flags, &c->c2.buf);
+        process_ip_header(c, flags, &c->c2.buf,
+                          out_ls);

 #ifdef PACKET_TRUNCATION_CHECK
         /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
@@ -1648,7 +1658,8 @@
 }

 void
-process_ip_header(struct context *c, unsigned int flags, struct buffer *bu=
f)
+process_ip_header(struct context *c, unsigned int flags, struct buffer *bu=
f,
+                  struct link_socket *ls)
 {
     if (!c->options.ce.mssfix)
     {
@@ -1682,7 +1693,7 @@
             /* extract TOS from IP header */
             if (flags & PIPV4_PASSTOS)
             {
-                link_socket_extract_tos(c->c2.link_socket, &ipbuf);
+                link_socket_extract_tos(ls, &ipbuf);
             }
 #endif

@@ -1890,7 +1901,7 @@
  */

 void
-process_outgoing_tun(struct context *c)
+process_outgoing_tun(struct context *c, struct link_socket *in_ls)
 {
     /*
      * Set up for write() call to TUN/TAP
@@ -1907,9 +1918,8 @@
      * The --mssfix option requires
      * us to examine the IP header (IPv4 or IPv6).
      */
-    process_ip_header(c,
-                      PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIEN=
T_NAT | PIP_OUTGOING,
-                      &c->c2.to_tun);
+    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIENT=
_NAT|PIP_OUTGOING, &c->c2.to_tun,
+                      in_ls);

     if (c->c2.to_tun.len <=3D c->c2.frame.buf.payload_size)
     {
@@ -2078,6 +2088,7 @@
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     static uintptr_t dco_shift =3D DCO_SHIFT;    /* Event from DCO linux k=
ernel module */
 #endif
+    int i;

     /*
      * Decide what kind of events we want to wait for.
@@ -2183,8 +2194,11 @@
     /*
      * Configure event wait based on socket, tuntap flags.
      */
-    socket_set(c->c2.link_socket, c->c2.event_set, socket,
-               &c->c2.link_socket->ev_arg, NULL);
+    for (i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        socket_set(c->c2.link_sockets[i], c->c2.event_set, socket,
+                   &c->c2.link_sockets[i]->ev_arg, NULL);
+    }
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL=
);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (socket & EVENT_READ && c->c2.did_open_tun)
@@ -2222,7 +2236,7 @@

     if (!c->sig->signal_received)
     {
-        if (!(flags & IOW_CHECK_RESIDUAL) || !socket_read_residual(c->c2.l=
ink_socket))
+        if (!(flags & IOW_CHECK_RESIDUAL) || !sockets_read_residual(c))
         {
             int status;

@@ -2261,6 +2275,9 @@
                         }

                         shift =3D socket_shift;
+                        /* mark socket so that the multi code knows where =
we
+                         * have pending i/o */
+                        ev_arg->pending =3D true;
                     }
                     else
                     {
@@ -2314,7 +2331,7 @@
     /* TUN device ready to accept write */
     else if (status & TUN_WRITE)
     {
-        process_outgoing_tun(c);
+        process_outgoing_tun(c, sock);
     }
     /* Incoming data on TCP/UDP port */
     else if (status & SOCKET_READ)
@@ -2331,7 +2348,7 @@
         read_incoming_tun(c);
         if (!IS_SIG(c))
         {
-            process_incoming_tun(c);
+            process_incoming_tun(c, sock);
         }
     }
     else if (status & DCO_READ)
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 8ef19b4..4ff5b04 100644
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
+ * @param out_ls  Socket that will be used to send out the packet.
+ *
  */
-void process_incoming_tun(struct context *c);
+void process_incoming_tun(struct context *c, struct link_socket *out_ls);


 /**
@@ -246,10 +248,11 @@
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


 /*************************************************************************=
*/
@@ -304,20 +307,21 @@
 #define PIPV6_ICMP_NOHOST_SERVER        (1<<6)


-void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf);
+void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf,
+                       struct link_socket *ls);

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
index ae911a9..f406c0f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -528,12 +528,11 @@
         {
             /* Check if there is another resolved address to try for
              * the current connection */
-            if (c->c1.link_socket_addr.current_remote
-                && c->c1.link_socket_addr.current_remote->ai_next
-                && !c->options.advance_next_remote)
+            if (c->c1.link_socket_addrs[0].current_remote
+                && c->c1.link_socket_addrs[0].current_remote->ai_next)
             {
-                c->c1.link_socket_addr.current_remote =3D
-                    c->c1.link_socket_addr.current_remote->ai_next;
+                c->c1.link_socket_addrs[0].current_remote =3D
+                    c->c1.link_socket_addrs[0].current_remote->ai_next;
             }
             else
             {
@@ -549,20 +548,20 @@
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
@@ -727,6 +726,13 @@
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
@@ -736,6 +742,10 @@

     init_connection_list(c);

+    c->c1.link_sockets_num =3D 1;
+
+    do_link_socket_addr_new(c);
+
 #if defined(ENABLE_PKCS11)
     if (c->first_time)
     {
@@ -1638,7 +1648,7 @@
         CLEAR(local);
         actual =3D &get_link_socket_info(c)->lsa->actual;
         remote =3D actual->dest;
-        getsockname(c->c2.link_socket->sd, &local.addr.sa, &sa_len);
+        getsockname(c->c2.link_sockets[0]->sd, &local.addr.sa, &sa_len);
 #if ENABLE_IP_PKTINFO
         if (!addr_defined(&local))
         {
@@ -1764,8 +1774,8 @@
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
@@ -1948,17 +1958,16 @@
         do_alloc_route_list(c);

         /* parse and resolve the route option list */
-        ASSERT(c->c2.link_socket);
+        ASSERT(c->c2.link_sockets);
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
@@ -1971,8 +1980,7 @@
                                                  c->options.dev_type,
                                                  c->options.dev_node,
                                                  &gc);
-            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es,
-                        &c->net_ctx);
+            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es=
, &c->net_ctx);
         }

         /* possibly add routes */
@@ -1987,6 +1995,7 @@
         /* Store the old fd inside the fd so open_tun can use it */
         c->c1.tuntap->fd =3D oldtunfd;
 #endif
+
         if (dco_enabled(&c->options))
         {
             ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
@@ -1998,16 +2007,14 @@
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
         if (!ifconfig_noexec_enabled(c)
             && ifconfig_order(c->c1.tuntap) =3D=3D IFCONFIG_AFTER_TUN_OPEN)
         {
-            do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
-                        c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
+            do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name, c->c2.fra=
me.tun_mtu, c->c2.es, &c->net_ctx);
         }

         /* run the up script */
@@ -2480,7 +2487,7 @@
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
@@ -2702,14 +2709,28 @@

     if (found & OPT_P_SOCKBUF)
     {
+        int i;
+
         msg(D_PUSH, "OPTIONS IMPORT: --sndbuf/--rcvbuf options modified");
-        link_socket_update_buffer_sizes(c->c2.link_socket, c->options.rcvb=
uf, c->options.sndbuf);
+
+        for (i =3D 0; i < c->c1.link_sockets_num; i++)
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
+        for (i =3D 0; i < c->c1.link_sockets_num; i++)
+        {
+            link_socket_update_flags(c->c2.link_sockets[i],
+                                     c->options.sockflags);
+        }
     }

     if (found & OPT_P_PERSIST)
@@ -3785,12 +3806,103 @@
 static void
 do_link_socket_new(struct context *c)
 {
-    ASSERT(!c->c2.link_socket);
-    c->c2.link_socket =3D link_socket_new();
+    int i;
+
+    ASSERT(!c->c2.link_sockets);
+
+    ALLOC_ARRAY_GC(c->c2.link_sockets, struct link_socket *,
+                   c->c1.link_sockets_num, &c->c2.gc);
+
+    for (i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        c->c2.link_sockets[i] =3D link_socket_new();
+    }
     c->c2.link_socket_owned =3D true;
 }

 /*
+ * bind TCP/UDP sockets
+ */
+static void
+do_init_socket_1(struct context *c)
+{
+    unsigned int sockflags =3D c->options.sockflags;
+    int i;
+
+#if PORT_SHARE
+    if (c->options.port_share_host && c->options.port_share_port)
+    {
+        sockflags |=3D SF_PORT_SHARE;
+    }
+#endif
+
+    for (i =3D 0; i < c->c1.link_sockets_num; i++)
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
+#ifdef ENABLE_DEBUG
+                                c->options.gremlin,
+#endif
+                                c->options.ce.bind_local,
+                                c->options.ce.remote_float,
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
+}
+
+/*
+ * finalize TCP/UDP sockets
+ */
+static void
+do_init_socket_2(struct context *c)
+{
+    int i;
+    for (i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        link_socket_init_phase2(c, c->c2.link_sockets[i], &c->c2.frame, c-=
>sig);
+    }
+}
+
+/*
  * Print MTU INFO
  */
 static void
@@ -3942,18 +4054,15 @@
 static void
 do_close_link_socket(struct context *c)
 {
-    /* in dco-win case, link socket is a tun handle which is
-     * closed in do_close_tun(). Set it to UNDEFINED so
-     * we won't use WinSock API to close it. */
-    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_socket)
+    if (c->c2.link_sockets && c->c2.link_socket_owned)
     {
-        c->c2.link_socket->sd =3D SOCKET_UNDEFINED;
-    }
+        int i;

-    if (c->c2.link_socket && c->c2.link_socket_owned)
-    {
-        link_socket_close(c->c2.link_socket);
-        c->c2.link_socket =3D NULL;
+        for (i =3D 0; i < c->c1.link_sockets_num; i++)
+        {
+            link_socket_close(c->c2.link_sockets[i]);
+        }
+        c->c2.link_sockets =3D NULL;
     }


@@ -3964,28 +4073,33 @@
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
+        CLEAR(c->c1.link_socket_addrs[0].actual);
     }

-    if (!(c->sig->signal_received =3D=3D SIGUSR1 && c->options.persist_loc=
al_ip))
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
     {
-        if (c->c1.link_socket_addr.bind_local && !c->options.resolve_in_ad=
vance)
+        if (!(c->sig->signal_received =3D=3D SIGUSR1 && c->options.persist=
_local_ip))
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

@@ -4468,7 +4582,6 @@
 {
     const struct options *options =3D &c->options;
     const bool child =3D (c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=3D CM=
_CHILD_UDP);
-    int link_socket_mode =3D LS_MODE_DEFAULT;

     /* init garbage collection level */
     gc_init(&c->c2.gc);
@@ -4509,21 +4622,6 @@
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
@@ -4666,7 +4764,7 @@
     /* bind the TCP/UDP socket */
     if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP || c->mode =3D=3D C=
M_CHILD_TCP)
     {
-        link_socket_init_phase1(c, link_socket_mode);
+        do_init_socket_1(c);
     }

     /* initialize tun/tap device object,
@@ -4709,7 +4807,7 @@
     /* finalize the TCP/UDP socket */
     if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP || c->mode =3D=3D C=
M_CHILD_TCP)
     {
-        link_socket_init_phase2(c);
+        do_init_socket_2(c);


         /* Update dynamic frame calculation as exact transport socket info=
rmation
@@ -4845,7 +4943,8 @@

 void
 inherit_context_child(struct context *dest,
-                      const struct context *src)
+                      const struct context *src,
+                      struct link_socket *ls)
 {
     CLEAR(*dest);

@@ -4858,6 +4957,8 @@

     /* c1 init */
     packet_id_persist_init(&dest->c1.pid_persist);
+    dest->c1.link_sockets_num =3D 1;
+    do_link_socket_addr_new(dest);

     dest->c1.ks.key_type =3D src->c1.ks.key_type;
     /* inherit SSL context */
@@ -4882,7 +4983,7 @@
          * The CM_TOP context does the socket listen(),
          * and the CM_CHILD_TCP context does the accept().
          */
-        dest->c2.accept_from =3D src->c2.link_socket;
+        dest->c2.accept_from =3D ls;
     }

 #ifdef ENABLE_PLUGIN
@@ -4906,18 +5007,26 @@
     /* UDP inherits some extra things which TCP does not */
     if (dest->mode =3D=3D CM_CHILD_UDP)
     {
+        ASSERT(!dest->c2.link_sockets);
+
         /* inherit buffers */
         dest->c2.buffers =3D src->c2.buffers;

-        /* inherit parent link_socket and tuntap */
-        dest->c2.link_socket =3D src->c2.link_socket;
+        ALLOC_ARRAY_GC(dest->c2.link_sockets, struct link_socket *, 1,
+                       &dest->gc);

-        ALLOC_OBJ_GC(dest->c2.link_socket_info, struct link_socket_info, &=
dest->gc);
-        *dest->c2.link_socket_info =3D src->c2.link_socket->info;
+        /* inherit parent link_socket and tuntap */
+        dest->c2.link_sockets[0] =3D ls;
+
+        ALLOC_ARRAY_GC(dest->c2.link_socket_infos, struct link_socket_info=
 *, 1,
+                       &dest->gc);
+        ALLOC_OBJ_GC(dest->c2.link_socket_infos[0], struct link_socket_inf=
o,
+                     &dest->gc);
+        *dest->c2.link_socket_infos[0] =3D ls->info;

         /* locally override some link_socket_info fields */
-        dest->c2.link_socket_info->lsa =3D &dest->c1.link_socket_addr;
-        dest->c2.link_socket_info->connection_established =3D false;
+        dest->c2.link_socket_infos[0]->lsa =3D &dest->c1.link_socket_addrs=
[0];
+        dest->c2.link_socket_infos[0]->connection_established =3D false;
     }
 }

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
index e89ddba..5a03146 100644
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
@@ -259,9 +262,13 @@
 multi_tcp_wait(const struct context *c,
                struct multi_tcp *mtcp)
 {
-    int status;
-    socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
-                                 &c->c2.link_socket->ev_arg);
+    int status, i;
+
+    for (i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        socket_set_listen_persistent(c->c2.link_sockets[i], mtcp->es,
+                                     &c->c2.link_sockets[i]->ev_arg);
+    }

 #ifdef _WIN32
     if (tuntap_is_wintun(c->c1.tuntap))
@@ -277,6 +284,7 @@
         persistent =3D NULL;
     }
 #endif
+
     tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwfla=
gs);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
@@ -479,16 +487,18 @@
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
@@ -564,7 +574,7 @@
             break;

         case MTP_NONE:
-            if (mi && socket_read_residual(c->c2.link_socket))
+            if (mi && sockets_read_residual(c))
             {
                 newaction =3D TA_SOCKET_READ_RESIDUAL;
             }
@@ -719,9 +729,14 @@

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
index 5fbd7b0..37af88e 100644
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
@@ -380,10 +381,20 @@
     /* Incoming data on UDP port */
     else if (status & SOCKET_READ)
     {
-        read_incoming_link(&m->top, m->top.c2.link_socket);
-        if (!IS_SIG(&m->top))
+        int i;
+        for (i =3D 0; i < m->top.c1.link_sockets_num; i++)
         {
-            multi_process_incoming_link(m, NULL, mpp_flags);
+            if (!m->top.c2.link_sockets[i]->ev_arg.pending)
+            {
+                continue;
+            }
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
index 45b3cfa..e7d742b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -682,7 +682,10 @@
         multi_client_disconnect_script(m, mi);
     }

-    close_context(&mi->context, SIGTERM, CC_GC_FREE);
+    if (mi->did_open_context)
+    {
+        close_context(&mi->context, SIGTERM, CC_GC_FREE);
+    }

     multi_tcp_instance_specific_free(mi);

@@ -750,7 +753,8 @@
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
@@ -773,7 +777,8 @@
         generate_prefix(mi);
     }

-    inherit_context_child(&mi->context, &m->top);
+    mi->did_open_context =3D true;
+    inherit_context_child(&mi->context, &m->top, ls);
     if (IS_SIG(&mi->context))
     {
         goto err;
@@ -3124,7 +3129,8 @@
 }

 void
-multi_process_float(struct multi_context *m, struct multi_instance *mi)
+multi_process_float(struct multi_context *m, struct multi_instance *mi,
+                    struct link_socket *ls)
 {
     struct mroute_addr real =3D {0};
     struct hash *hash =3D m->hash;
@@ -3180,8 +3186,8 @@
     mi->context.c2.to_link_addr =3D &mi->context.c2.from;

     /* inherit parent link_socket and link_socket_info */
-    mi->context.c2.link_socket =3D m->top.c2.link_socket;
-    mi->context.c2.link_socket_info->lsa->actual =3D m->top.c2.from;
+    mi->context.c2.link_sockets[0] =3D ls;
+    mi->context.c2.link_socket_infos[0]->lsa->actual =3D m->top.c2.from;

     tls_update_remote_addr(mi->context.c2.tls_multi, &mi->context.c2.from);

@@ -3329,7 +3335,8 @@
  * i.e. client -> server direction.
  */
 bool
-multi_process_incoming_link(struct multi_context *m, struct multi_instance=
 *instance, const unsigned int mpp_flags)
+multi_process_incoming_link(struct multi_context *m, struct multi_instance=
 *instance, const unsigned int mpp_flags,
+                            struct link_socket *ls)
 {
     struct gc_arena gc =3D gc_new();

@@ -3350,7 +3357,7 @@
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TCP/UDP -> TUN [%d]\n", BLEN(&m->top.c2.buf));
 #endif
-        multi_set_pending(m, multi_get_create_instance_udp(m, &floated));
+        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, ls=
));
     }
     else
     {
@@ -3391,7 +3398,7 @@
                 /* nonzero length means that we have a valid, decrypted pa=
cked */
                 if (floated && c->c2.buf.len > 0)
                 {
-                    multi_process_float(m, m->pending);
+                    multi_process_float(m, m->pending, ls);
                 }

                 process_incoming_link_part2(c, lsi, orig_buf);
@@ -3610,7 +3617,7 @@
                     }

                     /* encrypt in instance context */
-                    process_incoming_tun(c);
+                    process_incoming_tun(c, c->c2.link_sockets[0]);

                     /* postprocess and set wakeup */
                     ret =3D multi_process_post(m, m->pending, mpp_flags);
@@ -3642,7 +3649,8 @@
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
index f386a3b..5175f90 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -130,6 +130,7 @@
     in_addr_t reporting_addr;     /* IP address shown in status listing */
     struct in6_addr reporting_addr_ipv6; /* IPv6 address in status listing=
 */

+    bool did_open_context;
     bool did_real_hash;
     bool did_iter;
 #ifdef ENABLE_MANAGEMENT
@@ -274,7 +275,8 @@

 void multi_top_free(struct multi_context *m);

-struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real);
+struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real,
+                                             struct link_socket *ls);

 void multi_close_instance(struct multi_context *m, struct multi_instance *=
mi, bool shutdown);

@@ -288,7 +290,8 @@
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
@@ -353,8 +356,10 @@
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
@@ -668,7 +673,7 @@
 #endif
     set_prefix(mi);
     vlan_process_outgoing_tun(m, mi);
-    process_outgoing_tun(&mi->context);
+    process_outgoing_tun(&mi->context, mi->context.c2.link_sockets[0]);
     ret =3D multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
@@ -683,7 +688,7 @@
 {
     bool ret =3D true;
     set_prefix(mi);
-    process_outgoing_link(&mi->context, mi->context.c2.link_socket);
+    process_outgoing_link(&mi->context, mi->context.c2.link_sockets[0]);
     ret =3D multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 1db5422..bdbe126 100644
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
index e98c93e..77bb41d 100644
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

@@ -237,11 +238,11 @@
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
index efd742c..1e48d9a 100644
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
@@ -1002,7 +1017,6 @@
 create_socket_tcp(struct addrinfo *addrinfo)
 {
     socket_descriptor_t sd;
-
     ASSERT(addrinfo);
     ASSERT(addrinfo->ai_socktype =3D=3D SOCK_STREAM);

@@ -1034,7 +1048,6 @@
 create_socket_udp(struct addrinfo *addrinfo, const unsigned int flags)
 {
     socket_descriptor_t sd;
-
     ASSERT(addrinfo);
     ASSERT(addrinfo->ai_socktype =3D=3D SOCK_DGRAM);

@@ -1444,7 +1457,6 @@
 #ifdef TARGET_ANDROID
     protect_fd_nonlocal(sd, remote);
 #endif
-
     set_nonblock(sd);
     status =3D connect(sd, remote, af_addr_size(remote->sa_family));
     if (status)
@@ -1837,60 +1849,75 @@
 }

 void
-link_socket_init_phase1(struct context *c, int mode)
+link_socket_init_phase1(struct link_socket *sock,
+                        const char *local_host,
+                        const char *local_port,
+                        const char *remote_host,
+                        const char *remote_port,
+                        struct cached_dns_entry *dns_cache,
+                        int proto,
+                        sa_family_t af,
+                        bool bind_ipv6_only,
+                        int mode,
+                        const struct link_socket *accept_from,
+                        struct http_proxy_info *http_proxy,
+                        struct socks_proxy_info *socks_proxy,
+#ifdef ENABLE_DEBUG
+                        int gremlin,
+#endif
+                        bool bind_local,
+                        bool remote_float,
+                        struct link_socket_addr *lsa,
+                        const char *ipchange_command,
+                        const struct plugin_list *plugins,
+                        int resolve_retry_seconds,
+                        int mtu_discover_type,
+                        int rcvbuf,
+                        int sndbuf,
+                        int mark,
+                        struct event_timeout *server_poll_timeout,
+                        unsigned int sockflags)
 {
-    struct link_socket *sock =3D c->c2.link_socket;
-    struct options *o =3D &c->options;
     ASSERT(sock);

-    const char *remote_host =3D o->ce.remote;
-    const char *remote_port =3D o->ce.remote_port;
-
-    sock->local_host =3D o->ce.local;
-    sock->local_port =3D o->ce.local_port;
+    sock->local_host =3D local_host;
+    sock->local_port =3D local_port;
     sock->remote_host =3D remote_host;
     sock->remote_port =3D remote_port;
-    sock->dns_cache =3D c->c1.dns_cache;
-    sock->http_proxy =3D c->c1.http_proxy;
-    sock->socks_proxy =3D c->c1.socks_proxy;
-    sock->bind_local =3D o->ce.bind_local;
-    sock->resolve_retry_seconds =3D o->resolve_retry_seconds;
-    sock->mtu_discover_type =3D o->ce.mtu_discover_type;
+    sock->dns_cache =3D dns_cache;
+    sock->http_proxy =3D http_proxy;
+    sock->socks_proxy =3D socks_proxy;
+    sock->bind_local =3D bind_local;
+    sock->resolve_retry_seconds =3D resolve_retry_seconds;
+    sock->mtu_discover_type =3D mtu_discover_type;

 #ifdef ENABLE_DEBUG
-    sock->gremlin =3D o->gremlin;
+    sock->gremlin =3D gremlin;
 #endif

-    sock->socket_buffer_sizes.rcvbuf =3D o->rcvbuf;
-    sock->socket_buffer_sizes.sndbuf =3D o->sndbuf;
+    sock->socket_buffer_sizes.rcvbuf =3D rcvbuf;
+    sock->socket_buffer_sizes.sndbuf =3D sndbuf;

-    sock->sockflags =3D o->sockflags;
-#if PORT_SHARE
-    if (o->port_share_host && o->port_share_port)
-    {
-        sock->sockflags |=3D SF_PORT_SHARE;
-    }
-#endif
-    sock->mark =3D o->mark;
-    sock->bind_dev =3D o->bind_dev;
+    sock->sockflags =3D sockflags;
+    sock->mark =3D mark;

-    sock->info.proto =3D o->ce.proto;
-    sock->info.af =3D o->ce.af;
-    sock->info.remote_float =3D o->ce.remote_float;
-    sock->info.lsa =3D &c->c1.link_socket_addr;
-    sock->info.bind_ipv6_only =3D o->ce.bind_ipv6_only;
-    sock->info.ipchange_command =3D o->ipchange;
-    sock->info.plugins =3D c->plugins;
-    sock->server_poll_timeout =3D &c->c2.server_poll_interval;
+    sock->info.proto =3D proto;
+    sock->info.af =3D af;
+    sock->info.remote_float =3D remote_float;
+    sock->info.lsa =3D lsa;
+    sock->info.bind_ipv6_only =3D bind_ipv6_only;
+    sock->info.ipchange_command =3D ipchange_command;
+    sock->info.plugins =3D plugins;
+    sock->server_poll_timeout =3D server_poll_timeout;

     sock->mode =3D mode;
     if (mode =3D=3D LS_MODE_TCP_ACCEPT_FROM)
     {
-        ASSERT(c->c2.accept_from);
+        ASSERT(accept_from);
         ASSERT(sock->info.proto =3D=3D PROTO_TCP_SERVER);
-        sock->sd =3D c->c2.accept_from->sd;
+        sock->sd =3D accept_from->sd;
         /* inherit (possibly guessed) info AF from parent context */
-        sock->info.af =3D c->c2.accept_from->info.af;
+        sock->info.af =3D accept_from->info.af;
     }

     /* are we running in HTTP proxy mode? */
@@ -1899,8 +1926,8 @@
         ASSERT(sock->info.proto =3D=3D PROTO_TCP_CLIENT);

         /* the proxy server */
-        sock->remote_host =3D c->c1.http_proxy->options.server;
-        sock->remote_port =3D c->c1.http_proxy->options.port;
+        sock->remote_host =3D http_proxy->options.server;
+        sock->remote_port =3D http_proxy->options.port;

         /* the OpenVPN server we will use the proxy to connect to */
         sock->proxy_dest_host =3D remote_host;
@@ -1909,9 +1936,10 @@
     /* or in Socks proxy mode? */
     else if (sock->socks_proxy)
     {
+
         /* the proxy server */
-        sock->remote_host =3D c->c1.socks_proxy->server;
-        sock->remote_port =3D c->c1.socks_proxy->port;
+        sock->remote_host =3D socks_proxy->server;
+        sock->remote_port =3D socks_proxy->port;

         /* the OpenVPN server we will use the proxy to connect to */
         sock->proxy_dest_host =3D remote_host;
@@ -2172,22 +2200,21 @@

 /* finalize socket initialization */
 void
-link_socket_init_phase2(struct context *c)
+link_socket_init_phase2(struct context *c,
+                        struct link_socket *sock,
+                        const struct frame *frame,
+                        struct signal_info *sig_info)
 {
-    struct link_socket *sock =3D c->c2.link_socket;
-    const struct frame *frame =3D &c->c2.frame;
-    struct signal_info *sig_info =3D c->sig;
-
     const char *remote_dynamic =3D NULL;
-    struct signal_info sig_save =3D {0};
+    int sig_save =3D 0;

     ASSERT(sock);
     ASSERT(sig_info);

     if (sig_info->signal_received)
     {
-        sig_save =3D *sig_info;
-        sig_save.signal_received =3D signal_reset(sig_info, 0);
+        sig_save =3D sig_info->signal_received;
+        sig_info->signal_received =3D 0;
     }

     /* initialize buffers */
@@ -2209,18 +2236,17 @@
     /* If a valid remote has been found, create the socket with its addrin=
fo */
     if (sock->info.lsa->current_remote)
     {
-#if defined(_WIN32)
+    #if defined (_WIN32)
         if (dco_enabled(&c->options))
         {
             create_socket_dco_win(c, sock, sig_info);
             goto done;
         }
         else
-#endif
+    #endif
         {
             create_socket(sock, sock->info.lsa->current_remote);
         }
-
     }

     /* If socket has not already been created create it now */
@@ -2239,7 +2265,6 @@
                     addr_family_name(sock->info.lsa->bind_local->ai_family=
));
                 sock->info.af =3D sock->info.lsa->bind_local->ai_family;
             }
-
             create_socket(sock, sock->info.lsa->bind_local);
         }
     }
@@ -2248,7 +2273,7 @@
     if (sock->sd =3D=3D SOCKET_UNDEFINED)
     {
         msg(M_WARN, "Could not determine IPv4/IPv6 protocol");
-        register_signal(sig_info, SIGUSR1, "Could not determine IPv4/IPv6 =
protocol");
+        sig_info->signal_received =3D SIGUSR1;
         goto done;
     }

@@ -2259,7 +2284,8 @@

     if (sock->info.proto =3D=3D PROTO_TCP_SERVER)
     {
-        phase2_tcp_server(sock, remote_dynamic, sig_info);
+        phase2_tcp_server(sock, remote_dynamic,
+                          sig_info);
     }
     else if (sock->info.proto =3D=3D PROTO_TCP_CLIENT)
     {
@@ -2285,16 +2311,11 @@
     linksock_print_addr(sock);

 done:
-    if (sig_save.signal_received)
+    if (sig_save)
     {
-        /* Always restore the saved signal -- register/throw_signal will h=
andle priority */
-        if (sig_save.source =3D=3D SIG_SOURCE_HARD && sig_info =3D=3D &sig=
info_static)
+        if (!sig_info->signal_received)
         {
-            throw_signal(sig_save.signal_received);
-        }
-        else
-        {
-            register_signal(sig_info, sig_save.signal_received, sig_save.s=
ignal_text);
+            sig_info->signal_received =3D sig_save;
         }
     }
 }
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 566efee..67816d3 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -344,9 +344,40 @@
 /*
  * Initialize link_socket object.
  */
-void link_socket_init_phase1(struct context *c, int mode);
+void
+link_socket_init_phase1(struct link_socket *sock,
+                        const char *local_host,
+                        const char *local_port,
+                        const char *remote_host,
+                        const char *remote_port,
+                        struct cached_dns_entry *dns_cache,
+                        int proto,
+                        sa_family_t af,
+                        bool bind_ipv6_only,
+                        int mode,
+                        const struct link_socket *accept_from,
+                        struct http_proxy_info *http_proxy,
+                        struct socks_proxy_info *socks_proxy,
+#ifdef ENABLE_DEBUG
+                        int gremlin,
+#endif
+                        bool bind_local,
+                        bool remote_float,
+                        struct link_socket_addr *lsa,
+                        const char *ipchange_command,
+                        const struct plugin_list *plugins,
+                        int resolve_retry_seconds,
+                        int mtu_discover_type,
+                        int rcvbuf,
+                        int sndbuf,
+                        int mark,
+                        struct event_timeout *server_poll_timeout,
+                        unsigned int sockflags);

-void link_socket_init_phase2(struct context *c);
+void link_socket_init_phase2(struct context *c,
+                             struct link_socket *sock,
+                             const struct frame *frame,
+                             struct signal_info *sig_info);

 void do_preresolve(struct context *c);

@@ -1254,11 +1285,7 @@
  * Socket I/O wait functions
  */

-static inline bool
-socket_read_residual(const struct link_socket *sock)
-{
-    return sock && sock->stream_buf.residual_fully_formed;
-}
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
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--r/WalaqeY9g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, ordex, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #5</strong> to the change originall=
y created by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
434?usp=3Demail">View Change</a></p><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">allow tcp/udp server to listen on multiple=
 ports at the same time<br><br>Change-Id: Ia0a889e800f0b36aed770ee36e31afee=
c5df6084<br>Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>---<br=
>M src/openvpn/dco.c<br>M src/openvpn/event.h<br>M src/openvpn/forward.c<br=
>M src/openvpn/forward.h<br>M src/openvpn/init.c<br>M src/openvpn/init.h<br=
>M src/openvpn/mss.c<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M s=
rc/openvpn/mudp.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M sr=
c/openvpn/openvpn.c<br>M src/openvpn/openvpn.h<br>M src/openvpn/ping.h<br>M=
 src/openvpn/socket.c<br>M src/openvpn/socket.h<br>17 files changed, 459 in=
sertions(+), 237 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/34/434/5</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.c b=
/src/openvpn/dco.c</span><br><span>index 38f934a..c18ba3e 100644</span><br>=
<span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span=
><br><span>@@ -479,11 +479,11 @@</span><br><span>         return 0;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct link_socket *ls =3D c-&gt;c2.link_socket;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket *sock =
=3D c-&gt;c2.link_sockets[0];</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ASSERT(ls-&gt;info.connection_established);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(sock-&gt;i=
nfo.connection_established);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct sockaddr *remoteaddr =3D &amp;ls-&gt;in=
fo.lsa-&gt;actual.dest.addr.sa;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct sockaddr *remoteaddr =3D &amp;sock-&gt;info.lsa-&gt;=
actual.dest.addr.sa;</span><br><span>     struct tls_multi *multi =3D c-&gt=
;c2.tls_multi;</span><br><span> #ifdef TARGET_FREEBSD</span><br><span>     =
/* In Linux in P2P mode the kernel automatically removes an existing peer</=
span><br><span>@@ -495,7 +495,7 @@</span><br><span>     }</span><br><span> =
#endif</span><br><span>     int ret =3D dco_new_peer(&amp;c-&gt;c1.tuntap-&=
gt;dco, multi-&gt;peer_id,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                           c-&gt;c2.link_socket-&gt;sd, NULL, remotead=
dr, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                        c-&gt;c2.link_sockets[0]-&gt;sd, NULL, remoteaddr, =
NULL, NULL);</span><br><span>     if (ret &lt; 0)</span><br><span>     {</s=
pan><br><span>         return ret;</span><br><span>@@ -528,12 +528,12 @@</s=
pan><br><span> #if ENABLE_IP_PKTINFO</span><br><span>     struct context *c=
 =3D &amp;mi-&gt;context;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!proto_is_udp(c-&gt;c2.link_socket-&gt;info.p=
roto) || !(c-&gt;options.sockflags &amp; SF_USE_IP_PKTINFO))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!proto_is_udp(c-&gt;c2.lin=
k_sockets[0]-&gt;info.proto) || !(c-&gt;options.sockflags &amp; SF_USE_IP_P=
KTINFO))</span><br><span>     {</span><br><span>         return false;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct link_socket_actual *actual =3D &amp;c-&gt;c2.link=
_socket_info-&gt;lsa-&gt;actual;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct link_socket_actual *actual =3D &amp;c-&gt;c2.link_s=
ocket_infos[0]-&gt;lsa-&gt;actual;</span><br><span> </span><br><span>     s=
witch (actual-&gt;dest.addr.sa.sa_family)</span><br><span>     {</span><br>=
<span>@@ -578,7 +578,7 @@</span><br><span>     int peer_id =3D c-&gt;c2.tls=
_multi-&gt;peer_id;</span><br><span>     struct sockaddr *remoteaddr, *loca=
laddr =3D NULL;</span><br><span>     struct sockaddr_storage local =3D { 0 =
};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int sd =3D c-&g=
t;c2.link_socket-&gt;sd;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int sd =3D c-&gt;c2.link_sockets[0]-&gt;sd;</span><br><span> </spa=
n><br><span> </span><br><span>     if (c-&gt;mode =3D=3D CM_CHILD_TCP)</spa=
n><br><span>@@ -588,8 +588,8 @@</span><br><span>     }</span><br><span>    =
 else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        ASSERT(c-&gt;c2.link_socket_info-&gt;connection_established)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        remoteaddr =
=3D &amp;c-&gt;c2.link_socket_info-&gt;lsa-&gt;actual.dest.addr.sa;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(c-&gt;c2.lin=
k_socket_infos[0]-&gt;connection_established);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        remoteaddr =3D &amp;c-&gt;c2.link_socket=
_infos[0]-&gt;lsa-&gt;actual.dest.addr.sa;</span><br><span>     }</span><br=
><span> </span><br><span>     /* In server mode we need to fetch the remote=
 addresses from the push config */</span><br><span>diff --git a/src/openvpn=
/event.h b/src/openvpn/event.h</span><br><span>index c212e07..329a8f8 10064=
4</span><br><span>--- a/src/openvpn/event.h</span><br><span>+++ b/src/openv=
pn/event.h</span><br><span>@@ -141,6 +141,7 @@</span><br><span> struct even=
t_arg</span><br><span> {</span><br><span>     event_arg_t type;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool pending; /* in UDP/P2P=
 mode marks sockets waiting for processing */</span><br><span>     union {<=
/span><br><span>         struct multi_instance *mi; /* if type =3D EVENT_AR=
G_MULTI_INSTANCE */</span><br><span>         struct link_socket *sock; /* i=
f type =3D EVENT_ARG_LINK_SOCKET */</span><br><span>diff --git a/src/openvp=
n/forward.c b/src/openvpn/forward.c</span><br><span>index d50b24c..5e56be0 =
100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/sr=
c/openvpn/forward.c</span><br><span>@@ -58,12 +58,18 @@</span><br><span> wa=
it_status_string(struct context *c, struct gc_arena *gc)</span><br><span> {=
</span><br><span>     struct buffer out =3D alloc_buf_gc(64, gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;=
I/O WAIT %s|%s|%s|%s %s&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&a=
mp;out, &quot;I/O WAIT %s|%s| %s&quot;,</span><br><span>                tun=
_stat(c-&gt;c1.tuntap, EVENT_READ, gc),</span><br><span>                tun=
_stat(c-&gt;c1.tuntap, EVENT_WRITE, gc),</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-               socket_stat(c-&gt;c2.link_socket, EVENT_R=
EAD, gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
   socket_stat(c-&gt;c2.link_socket, EVENT_WRITE, gc),</span><br><span>    =
            tv_string(&amp;c-&gt;c2.timeval, gc));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_socke=
ts_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&a=
mp;out, &quot;\n %s|%s&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                   socket_stat(c-&gt;c2.link_sockets[i], EVENT_RE=
AD, gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
        socket_stat(c-&gt;c2.link_sockets[i], EVENT_WRITE, gc));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     ret=
urn BSTR(&amp;out);</span><br><span> }</span><br><span> </span><br><span>@@=
 -99,7 +105,7 @@</span><br><span> {</span><br><span>     if (c-&gt;c2.tls_m=
ulti &amp;&amp; c-&gt;c2.tls_exit_signal)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (link_socket_connecti=
on_oriented(c-&gt;c2.link_socket))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (link_socket_connection_oriented(c-&gt;c2.link_so=
ckets[0]))</span><br><span>         {</span><br><span>             if (c-&g=
t;c2.tls_multi-&gt;n_soft_errors)</span><br><span>             {</span><br>=
<span>@@ -567,6 +573,7 @@</span><br><span> #ifdef ENABLE_FRAGMENT</span><br=
><span> /*</span><br><span>  * Should we deliver a datagram fragment to rem=
ote?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * c is expecte=
d to be a single-link context (p2p or child)</span><br><span>  */</span><br=
><span> static void</span><br><span> check_fragment(struct context *c)</spa=
n><br><span>@@ -1123,7 +1130,9 @@</span><br><span>         decrypt_status =
=3D openvpn_decrypt(&amp;c-&gt;c2.buf, c-&gt;c2.buffers-&gt;decrypt_buf,</s=
pan><br><span>                                          co, &amp;c-&gt;c2.f=
rame, ad_start);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (!decrypt_status &amp;&amp; link_socket_connection_=
oriented(c-&gt;c2.link_socket))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!decrypt_status</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            /* all sockets are of the same type, so jus=
t check the first one */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &amp;&amp; link_socket_connection_oriented(c-&gt;c2.link_s=
ockets[0]))</span><br><span>         {</span><br><span>             /* decr=
yption errors are fatal in TCP mode */</span><br><span>             registe=
r_signal(c-&gt;sig, SIGUSR1, &quot;decryption-error&quot;); /* SOFT-SIGUSR1=
 -- decryption error in TCP mode */</span><br><span>@@ -1454,7 +1463,7 @@</=
span><br><span>  */</span><br><span> </span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-process_incoming_tun(struct context *=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process_incoming_=
tun(struct context *c, struct link_socket *out_ls)</span><br><span> {</span=
><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><b=
r><span>@@ -1487,7 +1496,8 @@</span><br><span>          */</span><br><span>=
         unsigned int flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_N=
AT</span><br><span>                              | PIPV6_ICMP_NOHOST_CLIENT=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        process_ip_h=
eader(c, flags, &amp;c-&gt;c2.buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        process_ip_header(c, flags, &amp;c-&gt;c2.buf,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
  out_ls);</span><br><span> </span><br><span> #ifdef PACKET_TRUNCATION_CHEC=
K</span><br><span>         /* if (c-&gt;c2.buf.len &gt; 1) --c-&gt;c2.buf.l=
en; */</span><br><span>@@ -1648,7 +1658,8 @@</span><br><span> }</span><br><=
span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-process_ip_header(struct context *c, unsigned int flags, struct buff=
er *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process_ip_=
header(struct context *c, unsigned int flags, struct buffer *buf,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                  struct link=
_socket *ls)</span><br><span> {</span><br><span>     if (!c-&gt;options.ce.=
mssfix)</span><br><span>     {</span><br><span>@@ -1682,7 +1693,7 @@</span>=
<br><span>             /* extract TOS from IP header */</span><br><span>   =
          if (flags &amp; PIPV4_PASSTOS)</span><br><span>             {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                link_sock=
et_extract_tos(c-&gt;c2.link_socket, &amp;ipbuf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                link_socket_extract_tos(ls, &=
amp;ipbuf);</span><br><span>             }</span><br><span> #endif</span><b=
r><span> </span><br><span>@@ -1890,7 +1901,7 @@</span><br><span>  */</span>=
<br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-process_outgoing_tun(struct context *c)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+process_outgoing_tun(struct context *c, s=
truct link_socket *in_ls)</span><br><span> {</span><br><span>     /*</span>=
<br><span>      * Set up for write() call to TUN/TAP</span><br><span>@@ -19=
07,9 +1918,8 @@</span><br><span>      * The --mssfix option requires</span>=
<br><span>      * us to examine the IP header (IPv4 or IPv6).</span><br><sp=
an>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    proces=
s_ip_header(c,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
               PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIENT_NAT | =
PIP_OUTGOING,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
              &amp;c-&gt;c2.to_tun);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROU=
TER|PIPV4_CLIENT_NAT|PIP_OUTGOING, &amp;c-&gt;c2.to_tun,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                      in_ls);</span><b=
r><span> </span><br><span>     if (c-&gt;c2.to_tun.len &lt;=3D c-&gt;c2.fra=
me.buf.payload_size)</span><br><span>     {</span><br><span>@@ -2078,6 +208=
8,7 @@</span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD=
)</span><br><span>     static uintptr_t dco_shift =3D DCO_SHIFT;    /* Even=
t from DCO linux kernel module */</span><br><span> #endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span> </span><b=
r><span>     /*</span><br><span>      * Decide what kind of events we want =
to wait for.</span><br><span>@@ -2183,8 +2194,11 @@</span><br><span>     /*=
</span><br><span>      * Configure event wait based on socket, tuntap flags=
.</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    socket_set(c-&gt;c2.link_socket, c-&gt;c2.event_set, socket,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-               &amp;c-&gt;c=
2.link_socket-&gt;ev_arg, NULL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        socket_set(c-&gt;c2.link_socket=
s[i], c-&gt;c2.event_set, socket,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                   &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span>     tun_set(c-&gt;c1.tuntap, c-&gt;c2.event_set, tuntap, (void *)=
tun_shift, NULL);</span><br><span> #if defined(TARGET_LINUX) || defined(TAR=
GET_FREEBSD)</span><br><span>     if (socket &amp; EVENT_READ &amp;&amp; c-=
&gt;c2.did_open_tun)</span><br><span>@@ -2222,7 +2236,7 @@</span><br><span>=
 </span><br><span>     if (!c-&gt;sig-&gt;signal_received)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!(f=
lags &amp; IOW_CHECK_RESIDUAL) || !socket_read_residual(c-&gt;c2.link_socke=
t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(fl=
ags &amp; IOW_CHECK_RESIDUAL) || !sockets_read_residual(c))</span><br><span=
>         {</span><br><span>             int status;</span><br><span> </spa=
n><br><span>@@ -2261,6 +2275,9 @@</span><br><span>                         =
}</span><br><span> </span><br><span>                         shift =3D sock=
et_shift;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              /* mark socket so that the multi code knows where we</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                         * h=
ave pending i/o */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       ev_arg-&gt;pending =3D true;</span><br><span>       =
              }</span><br><span>                     else</span><br><span> =
                    {</span><br><span>@@ -2314,7 +2331,7 @@</span><br><span=
>     /* TUN device ready to accept write */</span><br><span>     else if (=
status &amp; TUN_WRITE)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        process_outgoing_tun(c);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        process_outgoing_tun(c, sock)=
;</span><br><span>     }</span><br><span>     /* Incoming data on TCP/UDP p=
ort */</span><br><span>     else if (status &amp; SOCKET_READ)</span><br><s=
pan>@@ -2331,7 +2348,7 @@</span><br><span>         read_incoming_tun(c);</s=
pan><br><span>         if (!IS_SIG(c))</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            process_incoming_tu=
n(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pr=
ocess_incoming_tun(c, sock);</span><br><span>         }</span><br><span>   =
  }</span><br><span>     else if (status &amp; DCO_READ)</span><br><span>di=
ff --git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>in=
dex 8ef19b4..4ff5b04 100644</span><br><span>--- a/src/openvpn/forward.h</sp=
an><br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -231,10 +231,12=
 @@</span><br><span>  *</span><br><span>  * If an error occurs, it is logge=
d and the packet is dropped.</span><br><span>  *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * @param c - The context structure of the VPN t=
unnel associated with the</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *     packet.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param c       The context structure of the VPN tunnel associated with</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                the =
packet.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ou=
t_ls  Socket that will be used to send out the packet.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void process_incoming_tun(struct conte=
xt *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void process=
_incoming_tun(struct context *c, struct link_socket *out_ls);</span><br><sp=
an> </span><br><span> </span><br><span> /**</span><br><span>@@ -246,10 +248=
,11 @@</span><br><span>  *</span><br><span>  * If an error occurs, it is lo=
gged and the packet is dropped.</span><br><span>  *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param c - The context structure of the =
VPN tunnel associated with</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *     the packet.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param c      The context structure of the VPN tunnel associated</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *               with t=
he packet.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 in_ls  Socket where the packet was received.</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void process_outgoing_tun(stru=
ct context *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 process_outgoing_tun(struct context *c, struct link_socket *in_ls);</span>=
<br><span> </span><br><span> </span><br><span> /***************************=
***********************************************/</span><br><span>@@ -304,20=
 +307,21 @@</span><br><span> #define PIPV6_ICMP_NOHOST_SERVER        (1&lt;=
&lt;6)</span><br><span> </span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void process_ip_header(struct context *c, unsigned int=
 flags, struct buffer *buf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void process_ip_header(struct context *c, unsigned int flags, stru=
ct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                   struct link_socket *ls);</span><br><span> </span><br><sp=
an> bool schedule_exit(struct context *c);</span><br><span> </span><br><spa=
n> static inline struct link_socket_info *</span><br><span> get_link_socket=
_info(struct context *c)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (c-&gt;c2.link_socket_info)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.link_socket_infos)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return c-&gt;c2.link_socket_info;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return c-&gt;c2.link_socket_infos[0];</span><b=
r><span>     }</span><br><span>     else</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return &amp;c-&gt;c2.link=
_socket-&gt;info;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return &amp;c-&gt;c2.link_sockets[0]-&gt;info;</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/open=
vpn/init.c b/src/openvpn/init.c</span><br><span>index ae911a9..f406c0f 1006=
44</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openv=
pn/init.c</span><br><span>@@ -528,12 +528,11 @@</span><br><span>         {<=
/span><br><span>             /* Check if there is another resolved address =
to try for</span><br><span>              * the current connection */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if (c-&gt;c1.lin=
k_socket_addr.current_remote</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                &amp;&amp; c-&gt;c1.link_socket_addr.current_remote-=
&gt;ai_next</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      &amp;&amp; !c-&gt;options.advance_next_remote)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (c-&gt;c1.link_socket_addr=
s[0].current_remote</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &amp;&amp; c-&gt;c1.link_socket_addrs[0].current_remote-&gt=
;ai_next)</span><br><span>             {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                c-&gt;c1.link_socket_addr.current_remote=
 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   c-&gt;c1.link_socket_addr.current_remote-&gt;ai_next;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c1.link_socket_a=
ddrs[0].current_remote =3D</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    c-&gt;c1.link_socket_addrs[0].current_remote-&gt=
;ai_next;</span><br><span>             }</span><br><span>             else<=
/span><br><span>             {</span><br><span>@@ -549,20 +548,20 @@</span>=
<br><span>                      * skipped by management on the previous loo=
p.</span><br><span>                      * If so, clear the addrinfo object=
s as close_instance does</span><br><span>                      */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    if (c-&gt;c=
1.link_socket_addr.remote_list)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    if (c-&gt;c1.link_socket_addrs[0].remote_li=
st)</span><br><span>                     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        clear_remote_addrlist(&amp;c-&=
gt;c1.link_socket_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        clear_remote_addrlist(&amp;c-&gt;c1.link_socket=
_addrs[0],</span><br><span>                                               !=
c-&gt;options.resolve_in_advance);</span><br><span>                     }</=
span><br><span> </span><br><span>                     /* close_instance sho=
uld have cleared the addrinfo objects */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    ASSERT(c-&gt;c1.link_socket_addr.cur=
rent_remote =3D=3D NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    ASSERT(c-&gt;c1.link_socket_addr.remote_list =3D=3D=
 NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        ASSERT(c-&gt;c1.link_socket_addrs[0].current_remote =3D=3D NULL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    A=
SSERT(c-&gt;c1.link_socket_addrs[0].remote_list =3D=3D NULL);</span><br><sp=
an>                 }</span><br><span>                 else</span><br><span=
>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  c-&gt;c1.link_socket_addr.current_remote =3D</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        c-&gt;c1.l=
ink_socket_addr.remote_list;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    c-&gt;c1.link_socket_addrs[0].current_remote =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        c-&gt;c1.link_socket_addrs[0].remote_list;</span><br><span>        =
         }</span><br><span> </span><br><span>                 int advance_c=
ount =3D 1;</span><br><span>@@ -727,6 +726,13 @@</span><br><span>     unini=
t_proxy_dowork(c);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+do_link_socket_addr_new(struct context *c)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY_CLEAR_GC(c-&gt;c1.link_so=
cket_addrs, struct link_socket_addr,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                         c-&gt;c1.link_sockets_num, &amp;c=
-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span=
><br><span> context_init_1(struct context *c)</span><br><span> {</span><br>=
<span>@@ -736,6 +742,10 @@</span><br><span> </span><br><span>     init_conn=
ection_list(c);</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    c-&gt;c1.link_sockets_num =3D 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    do_link_socket_addr_new(c);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> #if defined(ENABLE_PKCS11)</span>=
<br><span>     if (c-&gt;first_time)</span><br><span>     {</span><br><span=
>@@ -1638,7 +1648,7 @@</span><br><span>         CLEAR(local);</span><br><sp=
an>         actual =3D &amp;get_link_socket_info(c)-&gt;lsa-&gt;actual;</sp=
an><br><span>         remote =3D actual-&gt;dest;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        getsockname(c-&gt;c2.link_socket-&gt;sd=
, &amp;local.addr.sa, &amp;sa_len);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        getsockname(c-&gt;c2.link_sockets[0]-&gt;sd, &amp;l=
ocal.addr.sa, &amp;sa_len);</span><br><span> #if ENABLE_IP_PKTINFO</span><b=
r><span>         if (!addr_defined(&amp;local))</span><br><span>         {<=
/span><br><span>@@ -1764,8 +1774,8 @@</span><br><span>                     =
        c-&gt;options.ifconfig_ipv6_local,</span><br><span>                =
             c-&gt;options.ifconfig_ipv6_netbits,</span><br><span>         =
                    c-&gt;options.ifconfig_ipv6_remote,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                            c-&gt;c1.link=
_socket_addr.bind_local,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                            c-&gt;c1.link_socket_addr.remote_list,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
   c-&gt;c1.link_socket_addrs[0].bind_local,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                            c-&gt;c1.link_socket_a=
ddrs[0].remote_list,</span><br><span>                             !c-&gt;op=
tions.ifconfig_nowarn,</span><br><span>                             c-&gt;c=
2.es,</span><br><span>                             &amp;c-&gt;net_ctx,</spa=
n><br><span>@@ -1948,17 +1958,16 @@</span><br><span>         do_alloc_route=
_list(c);</span><br><span> </span><br><span>         /* parse and resolve t=
he route option list */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ASSERT(c-&gt;c2.link_socket);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ASSERT(c-&gt;c2.link_sockets);</span><br><span>=
         if (c-&gt;options.routes &amp;&amp; c-&gt;c1.route_list)</span><br=
><span>         {</span><br><span>             do_init_route_list(&amp;c-&g=
t;options, c-&gt;c1.route_list,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                               &amp;c-&gt;c2.link_socket-&gt;info=
, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                               &amp;c-&gt;c2.link_sockets[0=
]-&gt;info, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span>         }</s=
pan><br><span>         if (c-&gt;options.routes_ipv6 &amp;&amp; c-&gt;c1.ro=
ute_ipv6_list)</span><br><span>         {</span><br><span>             do_i=
nit_route_ipv6_list(&amp;c-&gt;options, c-&gt;c1.route_ipv6_list,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
     &amp;c-&gt;c2.link_socket-&gt;info, c-&gt;c2.es,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                    &amp;c-=
&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                              &amp;c-&gt;c2.link_sockets[0]-&gt;info, c-&gt=
;c2.es, &amp;c-&gt;net_ctx);</span><br><span>         }</span><br><span> </=
span><br><span>         /* do ifconfig */</span><br><span>@@ -1971,8 +1980,=
7 @@</span><br><span>                                                  c-&g=
t;options.dev_type,</span><br><span>                                       =
           c-&gt;options.dev_node,</span><br><span>                        =
                          &amp;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            do_ifconfig(c-&gt;c1.tuntap, guess, c-&gt;c2.fram=
e.tun_mtu, c-&gt;c2.es,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        &amp;c-&gt;net_ctx);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            do_ifconfig(c-&gt;c1.tuntap, guess, =
c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span> =
        }</span><br><span> </span><br><span>         /* possibly add routes=
 */</span><br><span>@@ -1987,6 +1995,7 @@</span><br><span>         /* Store=
 the old fd inside the fd so open_tun can use it */</span><br><span>       =
  c-&gt;c1.tuntap-&gt;fd =3D oldtunfd;</span><br><span> #endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (dc=
o_enabled(&amp;c-&gt;options))</span><br><span>         {</span><br><span> =
            ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tuntap-&gt;dco);</span>=
<br><span>@@ -1998,16 +2007,14 @@</span><br><span>         /* set the hardw=
are address */</span><br><span>         if (c-&gt;options.lladdr)</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        set_lladdr(&amp;c-&gt;net_ctx, c-&gt;c1.tuntap-&gt;actual_name, c-&=
gt;options.lladdr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                    c-&gt;c2.es);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            set_lladdr(&amp;c-&gt;net_ctx, c-&gt;c1.tuntap-&g=
t;actual_name, c-&gt;options.lladdr, c-&gt;c2.es);</span><br><span>        =
 }</span><br><span> </span><br><span>         /* do ifconfig */</span><br><=
span>         if (!ifconfig_noexec_enabled(c)</span><br><span>             =
&amp;&amp; ifconfig_order(c-&gt;c1.tuntap) =3D=3D IFCONFIG_AFTER_TUN_OPEN)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            do_ifconfig(c-&gt;c1.tuntap, c-&gt;c1.tuntap-&gt;actual_na=
me,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            do_ifconfig(c-&gt;c=
1.tuntap, c-&gt;c1.tuntap-&gt;actual_name, c-&gt;c2.frame.tun_mtu, c-&gt;c2=
.es, &amp;c-&gt;net_ctx);</span><br><span>         }</span><br><span> </spa=
n><br><span>         /* run the up script */</span><br><span>@@ -2480,7 +24=
87,7 @@</span><br><span>                 {</span><br><span>                =
     msg(M_NONFATAL, &quot;dco-win doesn&#39;t yet support reopening TUN de=
vice&quot;);</span><br><span>                     /* prevent link_socket_cl=
ose() from closing handle with WinSock API */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    c-&gt;c2.link_socket-&gt;sd =3D=
 SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   c-&gt;c2.link_sockets[0]-&gt;sd =3D SOCKET_UNDEFINED;</s=
pan><br><span>                     return false;</span><br><span>          =
       }</span><br><span>                 else</span><br><span>@@ -2702,14 =
+2709,28 @@</span><br><span> </span><br><span>     if (found &amp; OPT_P_SO=
CKBUF)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        int i;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>         msg(D_PUSH, &quot;OPTIONS IMPORT: --sndbuf/-=
-rcvbuf options modified&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        link_socket_update_buffer_sizes(c-&gt;c2.link_socket, c-=
&gt;options.rcvbuf, c-&gt;options.sndbuf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            link_socket_update_buffer_si=
zes(c-&gt;c2.link_sockets[i],</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                            c-&gt;options.rcvbuf,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                         c-&gt;options.sndbuf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><spa=
n> </span><br><span>     if (found &amp; OPT_P_SOCKFLAGS)</span><br><span> =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int i;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
       msg(D_PUSH, &quot;OPTIONS IMPORT: --socket-flags option modified&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        link_sock=
et_update_flags(c-&gt;c2.link_socket, c-&gt;options.sockflags);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt; c-=
&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            link_socket_update_flags(c-&gt;c2.link_sockets[i],</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
     c-&gt;options.sockflags);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span>     }</span><br><span> </span><br><sp=
an>     if (found &amp; OPT_P_PERSIST)</span><br><span>@@ -3785,12 +3806,10=
3 @@</span><br><span> static void</span><br><span> do_link_socket_new(struc=
t context *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ASSERT(!c-&gt;c2.link_socket);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    c-&gt;c2.link_socket =3D link_socket_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ASSERT(!c-&gt;c2.link_sockets);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ALLOC_ARRAY_GC(c-&gt;c2.link_sockets, struct link_=
socket *,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
         c-&gt;c1.link_sockets_num, &amp;c-&gt;c2.gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2.link_sockets[i] =3D=
 link_socket_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span>     c-&gt;c2.link_socket_owned =3D true;</span><br><=
span> }</span><br><span> </span><br><span> /*</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * bind TCP/UDP sockets</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+do_init_socket_1(struct context *c)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    unsigned int sockflags =3D c-&gt;options.sockflags;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if PORT_SHARE</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (c-&gt;options.port_share_host &amp;&amp; c-&gt;options.port_=
share_port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        sockflags |=3D=
 SF_PORT_SHARE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num=
; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        int mode =3D LS_MOD=
E_DEFAULT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* mode allows CM_CH=
ILD_TCP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * i=
nstances to inherit acceptable fds</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * from a top-level parent */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;options.mode =3D=3D MOD=
E_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* initi=
alizing listening socket */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                mode =3D LS_MODE_TCP_LISTEN;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            /* initializing sock=
et to client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        else if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                mode =3D LS_MODE_TCP_ACCEPT_FROM;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* init each socket with its specific port */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        link_socket_ini=
t_phase1(c-&gt;c2.link_sockets[i],</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                c-&gt;options.ce.local,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
        c-&gt;options.ce.local_port,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                c-&gt;options.ce.remote,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
           c-&gt;options.ce.remote_port,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                c-&gt;c1.dns_cache,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
          c-&gt;options.ce.proto,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                c-&gt;options.ce.af,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
    c-&gt;options.ce.bind_ipv6_only,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                mode,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                c-&gt;c2=
.accept_from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                          c-&gt;c1.http_proxy,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                c-&gt;c1.socks_p=
roxy,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_=
DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                  c-&gt;options.gremlin,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                c-&gt;options.ce.bind_local,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
      c-&gt;options.ce.remote_float,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                &amp;c-&gt;c1.link_socket_=
addrs[i],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                      c-&gt;options.ipchange,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                c-&gt;plugins,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
          c-&gt;options.resolve_retry_seconds,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                c-&gt;options.ce=
.mtu_discover_type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                c-&gt;options.rcvbuf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                c-&gt;opt=
ions.sndbuf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                         c-&gt;options.mark,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                &amp;c-&gt;c2.serv=
er_poll_interval,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                              sockflags);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * finalize TCP/UDP sockets</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+do_init_socket_2(struct context *c)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        link_socket_init_phase2(c, c-&gt;c2.link_s=
ockets[i], &amp;c-&gt;c2.frame, c-&gt;sig);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Prin=
t MTU INFO</span><br><span>  */</span><br><span> static void</span><br><spa=
n>@@ -3942,18 +4054,15 @@</span><br><span> static void</span><br><span> do_=
close_link_socket(struct context *c)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* in dco-win case, link socket is a =
tun handle which is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * closed in do_close_tun(). Set it to UNDEFINED so</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * we won&#39;t use WinSock API to clos=
e it. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tunta=
p_is_dco_win(c-&gt;c1.tuntap) &amp;&amp; c-&gt;c2.link_socket)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.link_sockets &a=
mp;&amp; c-&gt;c2.link_socket_owned)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2.link_socket-&gt;sd =
=3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int i;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (c-&gt;c2.link_socket &amp;&amp; c-&gt;c2.link_socket_owned)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        link_socket_close(c-&gt;c2.link_socket);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2.link=
_socket =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            link_socket_close(c-&gt;c2.link_so=
ckets[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2.li=
nk_sockets =3D NULL;</span><br><span>     }</span><br><span> </span><br><sp=
an> </span><br><span>@@ -3964,28 +4073,33 @@</span><br><span>           &am=
p;&amp; ( (c-&gt;options.persist_remote_ip)</span><br><span>               =
 ||</span><br><span>                ( c-&gt;sig-&gt;source !=3D SIG_SOURCE_=
HARD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
&amp;&amp; ((c-&gt;c1.link_socket_addr.current_remote</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                      &amp;&amp; c-&gt;c1.l=
ink_socket_addr.current_remote-&gt;ai_next)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 &amp;&amp; ((c-&gt;c1.link_socket_=
addrs[0].current_remote</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                      &amp;&amp; c-&gt;c1.link_socket_addrs[0].current_=
remote-&gt;ai_next)</span><br><span>                      || c-&gt;options.=
no_advance))</span><br><span>                )))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        clear_remote_addr=
list(&amp;c-&gt;c1.link_socket_addr, !c-&gt;options.resolve_in_advance);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        clear_remote_a=
ddrlist(&amp;c-&gt;c1.link_socket_addrs[0],</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                              !c-&gt;options.resolv=
e_in_advance);</span><br><span>     }</span><br><span> </span><br><span>   =
  /* Clear the remote actual address when persist_remote_ip is not in use *=
/</span><br><span>     if (!(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1 &=
amp;&amp; c-&gt;options.persist_remote_ip))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(c-&gt;c1.link_so=
cket_addr.actual);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       CLEAR(c-&gt;c1.link_socket_addrs[0].actual);</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1 &amp;&amp; c-&gt;options=
.persist_local_ip))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c=
-&gt;c1.link_socket_addr.bind_local &amp;&amp; !c-&gt;options.resolve_in_ad=
vance)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1 &amp;&amp; c-&gt;options.pers=
ist_local_ip))</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            freeaddrinfo(c-&gt;c1.link_socket_addr.bind=
_local);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (c-&gt;c=
1.link_socket_addrs[i].bind_local</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                &amp;&amp; !c-&gt;options.resolve_in_advance)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                freeaddri=
nfo(c-&gt;c1.link_socket_addrs[i].bind_local);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c1.link_socket_addr.bind=
_local =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         c-&gt;c1.link_socket_addrs[i].bind_local =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span>@@ -4468,7 +4582,6 @@</s=
pan><br><span> {</span><br><span>     const struct options *options =3D &am=
p;c-&gt;options;</span><br><span>     const bool child =3D (c-&gt;mode =3D=
=3D CM_CHILD_TCP || c-&gt;mode =3D=3D CM_CHILD_UDP);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int link_socket_mode =3D LS_MODE_DEFAUL=
T;</span><br><span> </span><br><span>     /* init garbage collection level =
*/</span><br><span>     gc_init(&amp;c-&gt;c2.gc);</span><br><span>@@ -4509=
,21 +4622,6 @@</span><br><span>     /* map in current connection entry */</=
span><br><span>     next_connection_entry(c);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* link_socket_mode allows CM=
_CHILD_TCP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * inst=
ances to inherit acceptable fds</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-     * from a top-level parent */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (c-&gt;options.ce.proto =3D=3D PROTO_TCP_SERVE=
R)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;mode =3D=3D CM_TO=
P)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            link_socket_mode =
=3D LS_MODE_TCP_LISTEN;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        el=
se if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            link_socket_mode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span>     /* should we disable paging? */</span><b=
r><span>     if (c-&gt;first_time &amp;&amp; options-&gt;mlock)</span><br><=
span>     {</span><br><span>@@ -4666,7 +4764,7 @@</span><br><span>     /* b=
ind the TCP/UDP socket */</span><br><span>     if (c-&gt;mode =3D=3D CM_P2P=
 || c-&gt;mode =3D=3D CM_TOP || c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        li=
nk_socket_init_phase1(c, link_socket_mode);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        do_init_socket_1(c);</span><br><span>     }=
</span><br><span> </span><br><span>     /* initialize tun/tap device object=
,</span><br><span>@@ -4709,7 +4807,7 @@</span><br><span>     /* finalize th=
e TCP/UDP socket */</span><br><span>     if (c-&gt;mode =3D=3D CM_P2P || c-=
&gt;mode =3D=3D CM_TOP || c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        link_soc=
ket_init_phase2(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        do_init_socket_2(c);</span><br><span> </span><br><span> </span><br>=
<span>         /* Update dynamic frame calculation as exact transport socke=
t information</span><br><span>@@ -4845,7 +4943,8 @@</span><br><span> </span=
><br><span> void</span><br><span> inherit_context_child(struct context *des=
t,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
   const struct context *src)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                      const struct context *src,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                      struct link_so=
cket *ls)</span><br><span> {</span><br><span>     CLEAR(*dest);</span><br><=
span> </span><br><span>@@ -4858,6 +4957,8 @@</span><br><span> </span><br><s=
pan>     /* c1 init */</span><br><span>     packet_id_persist_init(&amp;des=
t-&gt;c1.pid_persist);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    dest-&gt;c1.link_sockets_num =3D 1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    do_link_socket_addr_new(dest);</span><br><span> =
</span><br><span>     dest-&gt;c1.ks.key_type =3D src-&gt;c1.ks.key_type;</=
span><br><span>     /* inherit SSL context */</span><br><span>@@ -4882,7 +4=
983,7 @@</span><br><span>          * The CM_TOP context does the socket lis=
ten(),</span><br><span>          * and the CM_CHILD_TCP context does the ac=
cept().</span><br><span>          */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        dest-&gt;c2.accept_from =3D src-&gt;c2.link_socket;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dest-&gt;c2.=
accept_from =3D ls;</span><br><span>     }</span><br><span> </span><br><spa=
n> #ifdef ENABLE_PLUGIN</span><br><span>@@ -4906,18 +5007,26 @@</span><br><=
span>     /* UDP inherits some extra things which TCP does not */</span><br=
><span>     if (dest-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span>     {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(!dest-=
&gt;c2.link_sockets);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>         /* inherit buffers */</span><br><span>         =
dest-&gt;c2.buffers =3D src-&gt;c2.buffers;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* inherit parent link_sock=
et and tuntap */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   dest-&gt;c2.link_socket =3D src-&gt;c2.link_socket;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ALLOC_ARRAY_GC(dest-&gt;c2.link_=
sockets, struct link_socket *, 1,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                       &amp;dest-&gt;gc);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ALLOC_OBJ_GC(de=
st-&gt;c2.link_socket_info, struct link_socket_info, &amp;dest-&gt;gc);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        *dest-&gt;c2.link=
_socket_info =3D src-&gt;c2.link_socket-&gt;info;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* inherit parent link_socket and tun=
tap */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dest-=
&gt;c2.link_sockets[0] =3D ls;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ALLOC_ARRAY_GC(dest-&gt;c2.link_socket_infos, struct link_socket_info *, 1,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
    &amp;dest-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        ALLOC_OBJ_GC(dest-&gt;c2.link_socket_infos[0], struct link_socke=
t_info,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
         &amp;dest-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        *dest-&gt;c2.link_socket_infos[0] =3D ls-&gt;info;</span><b=
r><span> </span><br><span>         /* locally override some link_socket_inf=
o fields */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        de=
st-&gt;c2.link_socket_info-&gt;lsa =3D &amp;dest-&gt;c1.link_socket_addr;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dest-&gt;c2.lin=
k_socket_info-&gt;connection_established =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        dest-&gt;c2.link_socket_infos[0]-=
&gt;lsa =3D &amp;dest-&gt;c1.link_socket_addrs[0];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        dest-&gt;c2.link_socket_infos[0]-&gt=
;connection_established =3D false;</span><br><span>     }</span><br><span> =
}</span><br><span> </span><br><span>diff --git a/src/openvpn/init.h b/src/o=
penvpn/init.h</span><br><span>index ea7eb30..11c32ac 100644</span><br><span=
>--- a/src/openvpn/init.h</span><br><span>+++ b/src/openvpn/init.h</span><b=
r><span>@@ -95,7 +95,8 @@</span><br><span> bool do_deferred_options(struct =
context *c, const unsigned int found);</span><br><span> </span><br><span> v=
oid inherit_context_child(struct context *dest,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                           const struct context *=
src);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
             const struct context *src,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                           struct link_socket *ls);</sp=
an><br><span> </span><br><span> void inherit_context_top(struct context *de=
st,</span><br><span>                          const struct context *src);</=
span><br><span>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c</span><br=
><span>index ebdec25..89dee7d 100644</span><br><span>--- a/src/openvpn/mss.=
c</span><br><span>+++ b/src/openvpn/mss.c</span><br><span>@@ -357,7 +357,7 =
@@</span><br><span>     struct link_socket_info *lsi =3D get_link_socket_in=
fo(c);</span><br><span>     struct options *o =3D &amp;c-&gt;options;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int p=
mtu =3D c-&gt;c2.link_socket-&gt;mtu;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int pmtu =3D c-&gt;c2.link_sockets[0]-&gt;mtu;</span>=
<br><span>     sa_family_t af =3D lsi-&gt;lsa-&gt;actual.dest.addr.sa.sa_fa=
mily;</span><br><span>     int proto =3D lsi-&gt;proto;</span><br><span> </=
span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><=
br><span>index e89ddba..5a03146 100644</span><br><span>--- a/src/openvpn/mt=
cp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -114,13 +1=
14,13 @@</span><br><span> #endif /* ENABLE_DEBUG */</span><br><span> </span=
><br><span> static struct multi_instance *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-multi_create_instance_tcp(struct multi_context *m)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_create_instance_t=
cp(struct multi_context *m, struct link_socket *ls)</span><br><span> {</spa=
n><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     stru=
ct multi_instance *mi =3D NULL;</span><br><span>     struct hash *hash =3D =
m-&gt;hash;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    mi =3D multi_create_instance(m, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    mi =3D multi_create_instance(m, NULL, ls=
);</span><br><span>     if (mi)</span><br><span>     {</span><br><span>    =
     struct hash_element *he;</span><br><span>@@ -170,13 +170,16 @@</span><=
br><span>     /* buffer for queued TCP socket output packets */</span><br><=
span>     mi-&gt;tcp_link_out_deferred =3D mbuf_init(m-&gt;top.options.n_bc=
ast_buf);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ASSERT(mi-&gt;context.c2.link_socket);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;context.c2.link_socket-&gt;inf=
o.lsa);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi-=
&gt;context.c2.link_socket-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;context.c2=
.link_socket-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =3D=3D AF_INET<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-           || mi-&gt;c=
ontext.c2.link_socket-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =3D=3D=
 AF_INET6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(mi-&gt;context.c2.link_sockets);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ASSERT(mi-&gt;context.c2.link_sockets[0]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context.c2.link_=
sockets[0]-&gt;info.lsa);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(mi-&gt;context.c2.link_sockets[0]-&gt;mode =3D=3D LS_MODE_=
TCP_ACCEPT_FROM);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ASSERT(mi-&gt;context.c2.link_sockets[0]-&gt;info.lsa-&gt;actual.dest.add=
r.sa.sa_family =3D=3D AF_INET</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+           || mi-&gt;context.c2.link_sockets[0]-&gt;info.lsa-&gt;=
actual.dest.addr.sa.sa_family =3D=3D AF_INET6</span><br><span>            )=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mroute_extr=
act_openvpn_sockaddr(&amp;mi-&gt;real, &amp;mi-&gt;context.c2.link_socket-&=
gt;info.lsa-&gt;actual.dest, true))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!mroute_extract_openvpn_sockaddr(&amp;mi-&gt;real,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                     &amp;mi-&gt;context.c2.link_sockets[0]-&gt;info.lsa-&g=
t;actual.dest,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                    true))</span><br><span>     {</span><br=
><span>         msg(D_MULTI_ERRORS, &quot;MULTI TCP: TCP client address is =
undefined&quot;);</span><br><span>         return false;</span><br><span>@@=
 -232,7 +235,7 @@</span><br><span> void</span><br><span> multi_tcp_derefere=
nce_instance(struct multi_tcp *mtcp, struct multi_instance *mi)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct lin=
k_socket *ls =3D mi-&gt;context.c2.link_socket;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct link_socket *ls =3D mi-&gt;context.c=
2.link_sockets[0];</span><br><span>     if (ls &amp;&amp; mi-&gt;socket_set=
_called)</span><br><span>     {</span><br><span>         event_del(mtcp-&gt=
;es, socket_event_handle(ls));</span><br><span>@@ -247,7 +250,7 @@</span><b=
r><span>     if (mi)</span><br><span>     {</span><br><span>         mi-&gt=
;socket_set_called =3D true;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        socket_set(mi-&gt;context.c2.link_socket,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        socket_set(mi-&gt;context.c2.l=
ink_sockets[0],</span><br><span>                    m-&gt;mtcp-&gt;es,</spa=
n><br><span>                    mbuf_defined(mi-&gt;tcp_link_out_deferred) =
? EVENT_WRITE : EVENT_READ,</span><br><span>                    &amp;mi-&gt=
;ev_arg,</span><br><span>@@ -259,9 +262,13 @@</span><br><span> multi_tcp_wa=
it(const struct context *c,</span><br><span>                struct multi_tc=
p *mtcp)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    socket_set_listen_persistent(c-&gt;c2.link_socket, mtcp-&gt;es,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
    &amp;c-&gt;c2.link_socket-&gt;ev_arg);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int status, i;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        socket_set_listen_persistent(c-&gt;c2.lin=
k_sockets[i], mtcp-&gt;es,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                     &amp;c-&gt;c2.link_sockets[i]-&=
gt;ev_arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span> </span><br><span> #ifdef _WIN32</span><br><span>     if (tun=
tap_is_wintun(c-&gt;c1.tuntap))</span><br><span>@@ -277,6 +284,7 @@</span><=
br><span>         persistent =3D NULL;</span><br><span>     }</span><br><sp=
an> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     tun_set(c-&gt;c1.tuntap, mtcp-&gt;es, EVENT_READ, MTCP_TUN, &a=
mp;mtcp-&gt;tun_rwflags);</span><br><span> #if defined(TARGET_LINUX) || def=
ined(TARGET_FREEBSD)</span><br><span>     dco_event_set(&amp;c-&gt;c1.tunta=
p-&gt;dco, mtcp-&gt;es, MTCP_DCO);</span><br><span>@@ -479,16 +487,18 @@</s=
pan><br><span>         case TA_SOCKET_READ:</span><br><span>         case T=
A_SOCKET_READ_RESIDUAL:</span><br><span>             ASSERT(mi);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi-&gt;contex=
t.c2.link_socket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           ASSERT(mi-&gt;context.c2.link_sockets);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            ASSERT(mi-&gt;context.c2.link_so=
ckets[0]);</span><br><span>             set_prefix(mi);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            read_incoming_link(&amp;mi-&g=
t;context, mi-&gt;context.c2.link_socket);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            read_incoming_link(&amp;mi-&gt;context, =
mi-&gt;context.c2.link_sockets[0]);</span><br><span>             clear_pref=
ix();</span><br><span>             if (!IS_SIG(&amp;mi-&gt;context))</span>=
<br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                multi_process_incoming_link(m, mi, mpp_flags);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                multi_process=
_incoming_link(m, mi, mpp_flags,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                            mi-&gt;context.c2.=
link_sockets[0]);</span><br><span>                 if (!IS_SIG(&amp;mi-&gt;=
context))</span><br><span>                 {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    stream_buf_read_setup(mi-&gt;con=
text.c2.link_socket);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    stream_buf_read_setup(mi-&gt;context.c2.link_sockets[=
0]);</span><br><span>                 }</span><br><span>             }</spa=
n><br><span>             break;</span><br><span>@@ -564,7 +574,7 @@</span><=
br><span>             break;</span><br><span> </span><br><span>         cas=
e MTP_NONE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (mi &amp;&amp; socket_read_residual(c-&gt;c2.link_socket))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (mi &amp;&amp; s=
ockets_read_residual(c))</span><br><span>             {</span><br><span>   =
              newaction =3D TA_SOCKET_READ_RESIDUAL;</span><br><span>      =
       }</span><br><span>@@ -719,9 +729,14 @@</span><br><span> </span><br><=
span>                 /* new incoming TCP client attempting to connect? */<=
/span><br><span>                 case EVENT_ARG_LINK_SOCKET:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    ASSERT(m-&gt;top=
.c2.link_socket);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                socket_reset_listen_persistent(m-&gt;top.c2.link_socket);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mi =
=3D multi_create_instance_tcp(m);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    if (!ev_arg-&gt;u.sock)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        msg(D_MULTI=
_ERRORS, &quot;MULTI: mtcp_proc_io: null socket&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        break;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    socket_reset_listen_persi=
stent(ev_arg-&gt;u.sock);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    mi =3D multi_create_instance_tcp(m, ev_arg-&gt;u.=
sock);</span><br><span>                     if (mi)</span><br><span>       =
              {</span><br><span>                         multi_tcp_action(m=
, mi, TA_INITIAL, false);</span><br><span>diff --git a/src/openvpn/mudp.c b=
/src/openvpn/mudp.c</span><br><span>index 5fbd7b0..37af88e 100644</span><br=
><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</s=
pan><br><span>@@ -185,7 +185,8 @@</span><br><span>  */</span><br><span> </s=
pan><br><span> struct multi_instance *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-multi_get_create_instance_udp(struct multi_context *m, boo=
l *floated)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_ge=
t_create_instance_udp(struct multi_context *m, bool *floated,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                              str=
uct link_socket *ls)</span><br><span> {</span><br><span>     struct gc_aren=
a gc =3D gc_new();</span><br><span>     struct mroute_addr real =3D {0};</s=
pan><br><span>@@ -256,7 +257,7 @@</span><br><span>                      * c=
onnect-freq but not against connect-freq-initial */</span><br><span>       =
              reflect_filter_rate_limit_decrease(m-&gt;initial_rate_limiter=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   mi =3D multi_create_instance(m, &amp;real);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    mi =3D multi=
_create_instance(m, &amp;real, ls);</span><br><span>                     if=
 (mi)</span><br><span>                     {</span><br><span>              =
           hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br=
><span>@@ -317,7 +318,7 @@</span><br><span>         msg_set_prefix(&quot;Co=
nnection Attempt&quot;);</span><br><span>         m-&gt;top.c2.to_link =3D =
m-&gt;hmac_reply;</span><br><span>         m-&gt;top.c2.to_link_addr =3D m-=
&gt;hmac_reply_dest;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       process_outgoing_link(&amp;m-&gt;top, m-&gt;top.c2.link_socket);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        process_outgoin=
g_link(&amp;m-&gt;top, m-&gt;top.c2.link_sockets[0]);</span><br><span>     =
    m-&gt;hmac_reply_dest =3D NULL;</span><br><span>     }</span><br><span>=
 }</span><br><span>@@ -380,10 +381,20 @@</span><br><span>     /* Incoming d=
ata on UDP port */</span><br><span>     else if (status &amp; SOCKET_READ)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        read_incoming_link(&amp;m-&gt;top, m-&gt;top.c2.link_socket);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!IS_SIG(&amp;m=
-&gt;top))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
nt i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i=
 =3D 0; i &lt; m-&gt;top.c1.link_sockets_num; i++)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_p=
rocess_incoming_link(m, NULL, mpp_flags);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if (!m-&gt;top.c2.link_sockets[i]-&gt;ev_=
arg.pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            read_incoming_link(&=
amp;m-&gt;top, m-&gt;top.c2.link_sockets[i]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if (!IS_SIG(&amp;m-&gt;top))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                multi_process_inco=
ming_link(m, NULL, mpp_flags,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                            m-&gt;top.c2.link_soc=
kets[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span>         }</span><br><span>     }</span><br><span>     =
/* Incoming data on TUN device */</span><br><span>diff --git a/src/openvpn/=
mudp.h b/src/openvpn/mudp.h</span><br><span>index 14e90d0..b378754 100644</=
span><br><span>--- a/src/openvpn/mudp.h</span><br><span>+++ b/src/openvpn/m=
udp.h</span><br><span>@@ -55,12 +55,14 @@</span><br><span>  * it.  If no en=
try exists, this function handles its creation, and if</span><br><span>  * =
successful, returns the newly created instance.</span><br><span>  *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param m            - The =
single multi_context structure.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param m           - The single multi_context structure.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ls          -=
 Listening socket where this instance is connecting to</span><br><span>  *<=
/span><br><span>  * @return A pointer to a multi_instance if one already ex=
isted for the</span><br><span>  *     packet&#39;s source address or if one=
 was a newly created successfully.</span><br><span>  *      NULL if one did=
 not yet exist and a new one was not created.</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-struct multi_instance *multi_g=
et_create_instance_udp(struct multi_context *m, bool *floated);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *multi_ge=
t_create_instance_udp(struct multi_context *m, bool *floated,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
                    struct link_socket *ls);</span><br><span> </span><br><s=
pan> #endif /* ifndef MUDP_H */</span><br><span>diff --git a/src/openvpn/mu=
lti.c b/src/openvpn/multi.c</span><br><span>index 45b3cfa..e7d742b 100644</=
span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/=
multi.c</span><br><span>@@ -682,7 +682,10 @@</span><br><span>         multi=
_client_disconnect_script(m, mi);</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    close_context(&amp=
;mi-&gt;context, SIGTERM, CC_GC_FREE);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (mi-&gt;did_open_context)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        close_context(&amp;mi-&gt;context, SIGTERM, CC_=
GC_FREE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span> </span><br><span>     multi_tcp_instance_specific_free(mi);</s=
pan><br><span> </span><br><span>@@ -750,7 +753,8 @@</span><br><span>  * Cre=
ate a client instance object for a newly connected client.</span><br><span>=
  */</span><br><span> struct multi_instance *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+multi_create_instance(struct multi_context *m, const struct mroute_=
addr *real,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
              struct link_socket *ls)</span><br><span> {</span><br><span>  =
   struct gc_arena gc =3D gc_new();</span><br><span>     struct multi_insta=
nce *mi;</span><br><span>@@ -773,7 +777,8 @@</span><br><span>         gener=
ate_prefix(mi);</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    inherit_context_child(&amp;mi-&gt;co=
ntext, &amp;m-&gt;top);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    mi-&gt;did_open_context =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    inherit_context_child(&amp;mi-&gt;context, &amp;m=
-&gt;top, ls);</span><br><span>     if (IS_SIG(&amp;mi-&gt;context))</span>=
<br><span>     {</span><br><span>         goto err;</span><br><span>@@ -312=
4,7 +3129,8 @@</span><br><span> }</span><br><span> </span><br><span> void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_float(str=
uct multi_context *m, struct multi_instance *mi)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+multi_process_float(struct multi_context *m, s=
truct multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    struct link_socket *ls)</span><br><span> {</span>=
<br><span>     struct mroute_addr real =3D {0};</span><br><span>     struct=
 hash *hash =3D m-&gt;hash;</span><br><span>@@ -3180,8 +3186,8 @@</span><br=
><span>     mi-&gt;context.c2.to_link_addr =3D &amp;mi-&gt;context.c2.from;=
</span><br><span> </span><br><span>     /* inherit parent link_socket and l=
ink_socket_info */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 mi-&gt;context.c2.link_socket =3D m-&gt;top.c2.link_socket;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.link_socket_in=
fo-&gt;lsa-&gt;actual =3D m-&gt;top.c2.from;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    mi-&gt;context.c2.link_sockets[0] =3D ls;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;context.c2.li=
nk_socket_infos[0]-&gt;lsa-&gt;actual =3D m-&gt;top.c2.from;</span><br><spa=
n> </span><br><span>     tls_update_remote_addr(mi-&gt;context.c2.tls_multi=
, &amp;mi-&gt;context.c2.from);</span><br><span> </span><br><span>@@ -3329,=
7 +3335,8 @@</span><br><span>  * i.e. client -&gt; server direction.</span>=
<br><span>  */</span><br><span> bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-multi_process_incoming_link(struct multi_context *m, struct =
multi_instance *instance, const unsigned int mpp_flags)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+multi_process_incoming_link(struct mult=
i_context *m, struct multi_instance *instance, const unsigned int mpp_flags=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
          struct link_socket *ls)</span><br><span> {</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -3350,=
7 +3357,7 @@</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span=
>         printf(&quot;TCP/UDP -&gt; TUN [%d]\n&quot;, BLEN(&amp;m-&gt;top.=
c2.buf));</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        multi_set_pending(m, multi_get_create_instance_udp(m, &=
amp;floated));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   multi_set_pending(m, multi_get_create_instance_udp(m, &amp;floated, ls))=
;</span><br><span>     }</span><br><span>     else</span><br><span>     {</=
span><br><span>@@ -3391,7 +3398,7 @@</span><br><span>                 /* no=
nzero length means that we have a valid, decrypted packed */</span><br><spa=
n>                 if (floated &amp;&amp; c-&gt;c2.buf.len &gt; 0)</span><b=
r><span>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    multi_process_float(m, m-&gt;pending);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    multi_proce=
ss_float(m, m-&gt;pending, ls);</span><br><span>                 }</span><b=
r><span> </span><br><span>                 process_incoming_link_part2(c, l=
si, orig_buf);</span><br><span>@@ -3610,7 +3617,7 @@</span><br><span>      =
               }</span><br><span> </span><br><span>                     /* =
encrypt in instance context */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    process_incoming_tun(c);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    process_incoming_tun(=
c, c-&gt;c2.link_sockets[0]);</span><br><span> </span><br><span>           =
          /* postprocess and set wakeup */</span><br><span>                =
     ret =3D multi_process_post(m, m-&gt;pending, mpp_flags);</span><br><sp=
an>@@ -3642,7 +3649,8 @@</span><br><span>         {</span><br><span>       =
      pip_flags |=3D PIP_MSSFIX;</span><br><span>         }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        process_ip_header(&amp;item.i=
nstance-&gt;context, pip_flags, &amp;item.instance-&gt;context.c2.buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        process_ip_head=
er(&amp;item.instance-&gt;context, pip_flags, &amp;item.instance-&gt;contex=
t.c2.buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                item.instance-&gt;context.c2.link_sockets[0]);</span><br><s=
pan>         encrypt_sign(&amp;item.instance-&gt;context, true);</span><br>=
<span>         mbuf_free_buf(item.buffer);</span><br><span> </span><br><spa=
n>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>in=
dex f386a3b..5175f90 100644</span><br><span>--- a/src/openvpn/multi.h</span=
><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -130,6 +130,7 @@</s=
pan><br><span>     in_addr_t reporting_addr;     /* IP address shown in sta=
tus listing */</span><br><span>     struct in6_addr reporting_addr_ipv6; /*=
 IPv6 address in status listing */</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool did_open_context;</span><br><spa=
n>     bool did_real_hash;</span><br><span>     bool did_iter;</span><br><s=
pan> #ifdef ENABLE_MANAGEMENT</span><br><span>@@ -274,7 +275,8 @@</span><br=
><span> </span><br><span> void multi_top_free(struct multi_context *m);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct =
multi_instance *multi_create_instance(struct multi_context *m, const struct=
 mroute_addr *real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                             struct link_socket *ls=
);</span><br><span> </span><br><span> void multi_close_instance(struct mult=
i_context *m, struct multi_instance *mi, bool shutdown);</span><br><span> <=
/span><br><span>@@ -288,7 +290,8 @@</span><br><span>  * existing peer. Upda=
tes multi_instance with new address,</span><br><span>  * updates hashtables=
 in multi_context.</span><br><span>  */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void multi_process_float(struct multi_context *m, struct =
multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void multi_process_float(struct multi_context *m, struct multi_instance *m=
i,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
        struct link_socket *ls);</span><br><span> </span><br><span> #define=
 MPP_PRE_SELECT             (1&lt;&lt;0)</span><br><span> #define MPP_CONDI=
TIONAL_PRE_SELECT (1&lt;&lt;1)</span><br><span>@@ -353,8 +356,10 @@</span><=
br><span>  *                       when using TCP transport. Otherwise NULL=
, as is</span><br><span>  *                       the case when using UDP t=
ransport.</span><br><span>  * @param mpp_flags    - Fast I/O optimization f=
lags.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ls  =
         - Socket where the packet was received.</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_process_incoming=
_link(struct multi_context *m, struct multi_instance *instance, const unsig=
ned int mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool multi_process_incoming_link(struct multi_context *m, struct multi_inst=
ance *instance, const unsigned int mpp_flags,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                 struct link_sock=
et *ls);</span><br><span> </span><br><span> </span><br><span> /**</span><br=
><span>@@ -668,7 +673,7 @@</span><br><span> #endif</span><br><span>     set=
_prefix(mi);</span><br><span>     vlan_process_outgoing_tun(m, mi);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    process_outgoing_tun(&amp=
;mi-&gt;context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  process_outgoing_tun(&amp;mi-&gt;context, mi-&gt;context.c2.link_sockets[=
0]);</span><br><span>     ret =3D multi_process_post(m, mi, mpp_flags);</sp=
an><br><span>     clear_prefix();</span><br><span>     return ret;</span><b=
r><span>@@ -683,7 +688,7 @@</span><br><span> {</span><br><span>     bool re=
t =3D true;</span><br><span>     set_prefix(mi);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    process_outgoing_link(&amp;mi-&gt;context, m=
i-&gt;context.c2.link_socket);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    process_outgoing_link(&amp;mi-&gt;context, mi-&gt;context.c2=
.link_sockets[0]);</span><br><span>     ret =3D multi_process_post(m, mi, m=
pp_flags);</span><br><span>     clear_prefix();</span><br><span>     return=
 ret;</span><br><span>diff --git a/src/openvpn/openvpn.c b/src/openvpn/open=
vpn.c</span><br><span>index 1db5422..bdbe126 100644</span><br><span>--- a/s=
rc/openvpn/openvpn.c</span><br><span>+++ b/src/openvpn/openvpn.c</span><br>=
<span>@@ -91,7 +91,7 @@</span><br><span>         }</span><br><span> </span>=
<br><span>         /* process the I/O which triggered select */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        process_io(c, c-&gt;c2.li=
nk_socket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
process_io(c, c-&gt;c2.link_sockets[0]);</span><br><span>         P2P_CHECK=
_SIG();</span><br><span> </span><br><span>         perf_pop();</span><br><s=
pan>diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h</span><br><s=
pan>index e98c93e..77bb41d 100644</span><br><span>--- a/src/openvpn/openvpn=
.h</span><br><span>+++ b/src/openvpn/openvpn.h</span><br><span>@@ -154,7 +1=
54,8 @@</span><br><span>  */</span><br><span> struct context_1</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link=
_socket_addr link_socket_addr;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int link_sockets_num;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct link_socket_addr *link_socket_addrs;</span><br>=
<span>     /**&lt; Local and remote addresses on the</span><br><span>      =
*   external network. */</span><br><span> </span><br><span>@@ -237,11 +238,=
11 @@</span><br><span>     /* bitmask for event status. Check event.h for p=
ossible values */</span><br><span>     unsigned int event_set_status;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t link_socket *link_socket;     /* socket used for TCP/UDP connection to re=
mote */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct l=
ink_socket **link_sockets;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct link_socket_info **link_socket_infos;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool link_socket_=
owned;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /** This variable is used instead link_socket-&gt;info for P2MP UDP =
childs */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct l=
ink_socket_info *link_socket_info;</span><br><span>     const struct link_s=
ocket *accept_from; /* possibly do accept() on a parent link_socket */</spa=
n><br><span> </span><br><span>     struct link_socket_actual *to_link_addr;=
    /* IP address of remote */</span><br><span>diff --git a/src/openvpn/pin=
g.h b/src/openvpn/ping.h</span><br><span>index 887172c..4a87895 100644</spa=
n><br><span>--- a/src/openvpn/ping.h</span><br><span>+++ b/src/openvpn/ping=
.h</span><br><span>@@ -63,7 +63,7 @@</span><br><span>         &amp;&amp; ev=
ent_timeout_trigger(&amp;c-&gt;c2.ping_rec_interval,</span><br><span>      =
                            &amp;c-&gt;c2.timeval,</span><br><span>        =
                          (!c-&gt;options.ping_timer_remote</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                  || =
link_socket_actual_defined(&amp;c-&gt;c1.link_socket_addr.actual))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
      || link_socket_actual_defined(&amp;c-&gt;c1.link_socket_addrs[0].actu=
al))</span><br><span>                                  ? ETT_DEFAULT : 15))=
</span><br><span>     {</span><br><span>         trigger_ping_timeout_signa=
l(c);</span><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socke=
t.c</span><br><span>index efd742c..1e48d9a 100644</span><br><span>--- a/src=
/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><spa=
n>@@ -42,6 +42,21 @@</span><br><span> </span><br><span> #include &quot;memd=
bg.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket=
s_read_residual(const struct context *c)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; =
c-&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (c-&gt;c2.link_sockets[i]-&gt;stream_buf.residual_fully_formed)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> /*</span><br><span>  * Convert sockflags/getaddr_flag=
s into getaddr_flags</span><br><span>  */</span><br><span>@@ -1002,7 +1017,=
6 @@</span><br><span> create_socket_tcp(struct addrinfo *addrinfo)</span><b=
r><span> {</span><br><span>     socket_descriptor_t sd;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(addrinfo);</=
span><br><span>     ASSERT(addrinfo-&gt;ai_socktype =3D=3D SOCK_STREAM);</s=
pan><br><span> </span><br><span>@@ -1034,7 +1048,6 @@</span><br><span> crea=
te_socket_udp(struct addrinfo *addrinfo, const unsigned int flags)</span><b=
r><span> {</span><br><span>     socket_descriptor_t sd;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(addrinfo);</=
span><br><span>     ASSERT(addrinfo-&gt;ai_socktype =3D=3D SOCK_DGRAM);</sp=
an><br><span> </span><br><span>@@ -1444,7 +1457,6 @@</span><br><span> #ifde=
f TARGET_ANDROID</span><br><span>     protect_fd_nonlocal(sd, remote);</spa=
n><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>     set_nonblock(sd);</span><br><span>     status =3D conne=
ct(sd, remote, af_addr_size(remote-&gt;sa_family));</span><br><span>     if=
 (status)</span><br><span>@@ -1837,60 +1849,75 @@</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-link_socket_init_phase1(struct context *c, int mode)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+link_socket_init_phase1(struct=
 link_socket *sock,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        const char *local_host,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        const char *local_port,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     const char *remote_host,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        const char *remote_port,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        struct cache=
d_dns_entry *dns_cache,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        int proto,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        sa_family_t af,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        bool bind_ip=
v6_only,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             int mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        const struct link_socket *accept_from,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        struc=
t http_proxy_info *http_proxy,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        struct socks_proxy_info *socks_proxy,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  int gremlin,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      bool bind_local,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        bool remote_float,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                        struct link_socket_addr *=
lsa,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         const char *ipchange_command,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        const struct plugin_list *plugin=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       int resolve_retry_seconds,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        int mtu_discover_type,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        int rcvbuf=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      int sndbuf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      int mark,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        struct event_timeout *server_poll_timeo=
ut,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        unsigned int sockflags)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct link_socket *sock =3D c-&gt;c2.link=
_socket;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct op=
tions *o =3D &amp;c-&gt;options;</span><br><span>     ASSERT(sock);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const c=
har *remote_host =3D o-&gt;ce.remote;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    const char *remote_port =3D o-&gt;ce.remote_port;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    sock-&gt;local_host =3D o-&gt;ce.local;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;local_port =
=3D o-&gt;ce.local_port;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    sock-&gt;local_host =3D local_host;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    sock-&gt;local_port =3D local_port;</span><br>=
<span>     sock-&gt;remote_host =3D remote_host;</span><br><span>     sock-=
&gt;remote_port =3D remote_port;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    sock-&gt;dns_cache =3D c-&gt;c1.dns_cache;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;http_proxy =3D c-&gt;c1.ht=
tp_proxy;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt=
;socks_proxy =3D c-&gt;c1.socks_proxy;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    sock-&gt;bind_local =3D o-&gt;ce.bind_local;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;resolve_retry_seco=
nds =3D o-&gt;resolve_retry_seconds;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    sock-&gt;mtu_discover_type =3D o-&gt;ce.mtu_discover_typ=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;dns_=
cache =3D dns_cache;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    sock-&gt;http_proxy =3D http_proxy;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    sock-&gt;socks_proxy =3D socks_proxy;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;bind_local =3D bind=
_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt=
;resolve_retry_seconds =3D resolve_retry_seconds;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    sock-&gt;mtu_discover_type =3D mtu_discov=
er_type;</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;gremlin =3D o-&gt;gr=
emlin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;=
gremlin =3D gremlin;</span><br><span> #endif</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;socket_buffer_sizes.r=
cvbuf =3D o-&gt;rcvbuf;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    sock-&gt;socket_buffer_sizes.sndbuf =3D o-&gt;sndbuf;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;socket_buffer_sizes.rc=
vbuf =3D rcvbuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 sock-&gt;socket_buffer_sizes.sndbuf =3D sndbuf;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;sockflags =3D o-&=
gt;sockflags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if PORT=
_SHARE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;p=
ort_share_host &amp;&amp; o-&gt;port_share_port)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        sock-&gt;sockflags |=3D SF_PORT_SHARE;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    sock-&gt;mark =3D o-&gt;mark;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    sock-&gt;bind_dev =3D o-&gt;bind_dev;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;sockflags =3D sockflags=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;mark =
=3D mark;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    sock-&gt;info.proto =3D o-&gt;ce.proto;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    sock-&gt;info.af =3D o-&gt;ce.af;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.remote_float =
=3D o-&gt;ce.remote_float;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    sock-&gt;info.lsa =3D &amp;c-&gt;c1.link_socket_addr;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.bind_ipv6_only =
=3D o-&gt;ce.bind_ipv6_only;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    sock-&gt;info.ipchange_command =3D o-&gt;ipchange;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.plugins =3D c-&gt=
;plugins;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt=
;server_poll_timeout =3D &amp;c-&gt;c2.server_poll_interval;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info.proto =3D proto;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info.a=
f =3D af;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&=
gt;info.remote_float =3D remote_float;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    sock-&gt;info.lsa =3D lsa;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    sock-&gt;info.bind_ipv6_only =3D bind_ipv=
6_only;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt=
;info.ipchange_command =3D ipchange_command;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    sock-&gt;info.plugins =3D plugins;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;server_poll_timeou=
t =3D server_poll_timeout;</span><br><span> </span><br><span>     sock-&gt;=
mode =3D mode;</span><br><span>     if (mode =3D=3D LS_MODE_TCP_ACCEPT_FROM=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        ASSERT(c-&gt;c2.accept_from);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        ASSERT(accept_from);</span><br><span>         =
ASSERT(sock-&gt;info.proto =3D=3D PROTO_TCP_SERVER);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;sd =3D c-&gt;c2.accept_fro=
m-&gt;sd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        so=
ck-&gt;sd =3D accept_from-&gt;sd;</span><br><span>         /* inherit (poss=
ibly guessed) info AF from parent context */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        sock-&gt;info.af =3D c-&gt;c2.accept_from-&g=
t;info.af;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
ock-&gt;info.af =3D accept_from-&gt;info.af;</span><br><span>     }</span><=
br><span> </span><br><span>     /* are we running in HTTP proxy mode? */</s=
pan><br><span>@@ -1899,8 +1926,8 @@</span><br><span>         ASSERT(sock-&g=
t;info.proto =3D=3D PROTO_TCP_CLIENT);</span><br><span> </span><br><span>  =
       /* the proxy server */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        sock-&gt;remote_host =3D c-&gt;c1.http_proxy-&gt;options.se=
rver;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt=
;remote_port =3D c-&gt;c1.http_proxy-&gt;options.port;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;remote_host =3D http_pr=
oxy-&gt;options.server;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        sock-&gt;remote_port =3D http_proxy-&gt;options.port;</span><br=
><span> </span><br><span>         /* the OpenVPN server we will use the pro=
xy to connect to */</span><br><span>         sock-&gt;proxy_dest_host =3D r=
emote_host;</span><br><span>@@ -1909,9 +1936,10 @@</span><br><span>     /* =
or in Socks proxy mode? */</span><br><span>     else if (sock-&gt;socks_pro=
xy)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>         /* the proxy server */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;remote_host =3D c-&gt;c1=
.socks_proxy-&gt;server;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        sock-&gt;remote_port =3D c-&gt;c1.socks_proxy-&gt;port;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;remote_host=
 =3D socks_proxy-&gt;server;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        sock-&gt;remote_port =3D socks_proxy-&gt;port;</span><br><=
span> </span><br><span>         /* the OpenVPN server we will use the proxy=
 to connect to */</span><br><span>         sock-&gt;proxy_dest_host =3D rem=
ote_host;</span><br><span>@@ -2172,22 +2200,21 @@</span><br><span> </span><=
br><span> /* finalize socket initialization */</span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_init_phase2(stru=
ct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_=
socket_init_phase2(struct context *c,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        struct link_socket *sock,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        con=
st struct frame *frame,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        struct signal_info *sig_info)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_sock=
et *sock =3D c-&gt;c2.link_socket;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const struct frame *frame =3D &amp;c-&gt;c2.frame;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct signal_info *sig_i=
nfo =3D c-&gt;sig;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>     const char *remote_dynamic =3D NULL;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct signal_info sig_save =3D {0};<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int sig_save =3D=
 0;</span><br><span> </span><br><span>     ASSERT(sock);</span><br><span>  =
   ASSERT(sig_info);</span><br><span> </span><br><span>     if (sig_info-&g=
t;signal_received)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        sig_save =3D *sig_info;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        sig_save.signal_received =3D signal=
_reset(sig_info, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        sig_save =3D sig_info-&gt;signal_received;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sig_info-&gt;signal_received =3D =
0;</span><br><span>     }</span><br><span> </span><br><span>     /* initial=
ize buffers */</span><br><span>@@ -2209,18 +2236,17 @@</span><br><span>    =
 /* If a valid remote has been found, create the socket with its addrinfo *=
/</span><br><span>     if (sock-&gt;info.lsa-&gt;current_remote)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #if d=
efined (_WIN32)</span><br><span>         if (dco_enabled(&amp;c-&gt;options=
))</span><br><span>         {</span><br><span>             create_socket_dc=
o_win(c, sock, sig_info);</span><br><span>             goto done;</span><br=
><span>         }</span><br><span>         else</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    #endif</span><br><span>         {</span><br><span>        =
     create_socket(sock, sock-&gt;info.lsa-&gt;current_remote);</span><br><=
span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span>     }</span><br><span> </span><br><span>     /* If socket has n=
ot already been created create it now */</span><br><span>@@ -2239,7 +2265,6=
 @@</span><br><span>                     addr_family_name(sock-&gt;info.lsa=
-&gt;bind_local-&gt;ai_family));</span><br><span>                 sock-&gt;=
info.af =3D sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span=
>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span>             create_socket(sock, sock-&gt;info.lsa-&gt;bind_loca=
l);</span><br><span>         }</span><br><span>     }</span><br><span>@@ -2=
248,7 +2273,7 @@</span><br><span>     if (sock-&gt;sd =3D=3D SOCKET_UNDEFIN=
ED)</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;Could=
 not determine IPv4/IPv6 protocol&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        register_signal(sig_info, SIGUSR1, &quot;Could =
not determine IPv4/IPv6 protocol&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        sig_info-&gt;signal_received =3D SIGUSR1;</spa=
n><br><span>         goto done;</span><br><span>     }</span><br><span> </s=
pan><br><span>@@ -2259,7 +2284,8 @@</span><br><span> </span><br><span>     =
if (sock-&gt;info.proto =3D=3D PROTO_TCP_SERVER)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        phase2_tcp_server=
(sock, remote_dynamic, sig_info);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        phase2_tcp_server(sock, remote_dynamic,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                          sig_inf=
o);</span><br><span>     }</span><br><span>     else if (sock-&gt;info.prot=
o =3D=3D PROTO_TCP_CLIENT)</span><br><span>     {</span><br><span>@@ -2285,=
16 +2311,11 @@</span><br><span>     linksock_print_addr(sock);</span><br><s=
pan> </span><br><span> done:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (sig_save.signal_received)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (sig_save)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* Always restore the saved=
 signal -- register/throw_signal will handle priority */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (sig_save.source =3D=3D SIG_S=
OURCE_HARD &amp;&amp; sig_info =3D=3D &amp;siginfo_static)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (!sig_info-&gt;signal_rec=
eived)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            throw_signal(sig_save.signal_received);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            register_signal(sig_info, sig_save.signal_received, =
sig_save.signal_text);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            sig_info-&gt;signal_received =3D sig_save;</span><br><span> =
        }</span><br><span>     }</span><br><span> }</span><br><span>diff --=
git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span>index 566=
efee..67816d3 100644</span><br><span>--- a/src/openvpn/socket.h</span><br><=
span>+++ b/src/openvpn/socket.h</span><br><span>@@ -344,9 +344,40 @@</span>=
<br><span> /*</span><br><span>  * Initialize link_socket object.</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void link_s=
ocket_init_phase1(struct context *c, int mode);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+link_socket_init_phase1(struct link_socket *sock,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        const ch=
ar *local_host,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    const char *local_port,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        const char *remote_host,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  const char *remote_port,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        struct cached_dns_entry *dns_cache,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        int =
proto,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           sa_family_t af,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        bool bind_ipv6_only,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        int mode,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        con=
st struct link_socket *accept_from,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        struct http_proxy_info *http_proxy,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     struct socks_proxy_info *socks_proxy,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        int gremlin,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        bool bind_local,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        boo=
l remote_float,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    struct link_socket_addr *lsa,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        const char *ipchange_=
command,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             const struct plugin_list *plugins,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        int resolve_retry_secon=
ds,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        int mtu_discover_type,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        int rcvbuf,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        int sndbuf,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        int mark=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      struct event_timeout *server_poll_timeout,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        unsigned int sockflags=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid link_socket_init_phase2(struct context *c);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void link_socket_init_phase2(struct context *c,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
          struct link_socket *sock,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                             const struct frame *frame,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
      struct signal_info *sig_info);</span><br><span> </span><br><span> voi=
d do_preresolve(struct context *c);</span><br><span> </span><br><span>@@ -1=
254,11 +1285,7 @@</span><br><span>  * Socket I/O wait functions</span><br><=
span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-socket_read_residual(const struct link_socket *sock)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return sock &amp;&amp; sock-&gt;stream_buf.residual_fully=
_formed;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool sockets_read_residual(cons=
t struct context *c);</span><br><span> </span><br><span> static inline even=
t_t</span><br><span> socket_event_handle(const struct link_socket *sock)</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/434?usp=3Demail">change 434</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/434?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e3=
1afeec5df6084 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 434 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--r/WalaqeY9g=--

