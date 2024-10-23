From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 23 Oct 2024 11:04:53 +0000
In-Reply-To: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
References: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <c17de84bba0eda775e62335a99f62bf9ff1a9f74-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RKzxyuoISIg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RKzxyuoISIg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

its_Giaan has uploaded a new patch set (#7) to the change originally create=
d by ordex. ( http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail )


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
17 files changed, 380 insertions(+), 251 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/434/7

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
index d50b24c..7e033c9 100644
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
+            /* all sockets are of the same type, so just check the first o=
ne */
+            && link_socket_connection_oriented(c->c2.link_sockets[0]))
         {
             /* decryption errors are fatal in TCP mode */
             register_signal(c->sig, SIGUSR1, "decryption-error"); /* SOFT-=
SIGUSR1 -- decryption error in TCP mode */
@@ -1454,7 +1462,7 @@
  */

 void
-process_incoming_tun(struct context *c)
+process_incoming_tun(struct context *c, struct link_socket *out_sock)
 {
     struct gc_arena gc =3D gc_new();

@@ -1487,7 +1495,7 @@
          */
         unsigned int flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_N=
AT
                              | PIPV6_ICMP_NOHOST_CLIENT;
-        process_ip_header(c, flags, &c->c2.buf);
+        process_ip_header(c, flags, &c->c2.buf, out_sock);

 #ifdef PACKET_TRUNCATION_CHECK
         /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
@@ -1648,7 +1656,8 @@
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
@@ -1682,7 +1691,7 @@
             /* extract TOS from IP header */
             if (flags & PIPV4_PASSTOS)
             {
-                link_socket_extract_tos(c->c2.link_socket, &ipbuf);
+                link_socket_extract_tos(sock, &ipbuf);
             }
 #endif

@@ -1890,7 +1899,7 @@
  */

 void
-process_outgoing_tun(struct context *c)
+process_outgoing_tun(struct context *c, struct link_socket *in_sock)
 {
     /*
      * Set up for write() call to TUN/TAP
@@ -1907,9 +1916,8 @@
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
@@ -2183,8 +2191,11 @@
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
@@ -2222,7 +2233,7 @@

     if (!c->sig->signal_received)
     {
-        if (!(flags & IOW_CHECK_RESIDUAL) || !socket_read_residual(c->c2.l=
ink_socket))
+        if (!(flags & IOW_CHECK_RESIDUAL) || !sockets_read_residual(c))
         {
             int status;

@@ -2261,6 +2272,9 @@
                         }

                         shift =3D socket_shift;
+                        /* mark socket so that the multi code knows where =
we
+                         * have pending i/o */
+                        ev_arg->pending =3D true;
                     }
                     else
                     {
@@ -2314,7 +2328,7 @@
     /* TUN device ready to accept write */
     else if (status & TUN_WRITE)
     {
-        process_outgoing_tun(c);
+        process_outgoing_tun(c, sock);
     }
     /* Incoming data on TCP/UDP port */
     else if (status & SOCKET_READ)
@@ -2331,7 +2345,7 @@
         read_incoming_tun(c);
         if (!IS_SIG(c))
         {
-            process_incoming_tun(c);
+            process_incoming_tun(c, sock);
         }
     }
     else if (status & DCO_READ)
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 8ef19b4..5c2fdb8 100644
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
=20
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
index 9371024..adf24ea 100644
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
@@ -1636,7 +1646,7 @@
         CLEAR(local);
         actual =3D &get_link_socket_info(c)->lsa->actual;
         remote =3D actual->dest;
-        getsockname(c->c2.link_socket->sd, &local.addr.sa, &sa_len);
+        getsockname(c->c2.link_sockets[0]->sd, &local.addr.sa, &sa_len);
 #if ENABLE_IP_PKTINFO
         if (!addr_defined(&local))
         {
@@ -1762,8 +1772,8 @@
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
@@ -1946,17 +1956,16 @@
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
@@ -1969,8 +1978,7 @@
                                                  c->options.dev_type,
                                                  c->options.dev_node,
                                                  &gc);
-            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es,
-                        &c->net_ctx);
+            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es=
, &c->net_ctx);
         }

         /* possibly add routes */
@@ -1985,6 +1993,7 @@
         /* Store the old fd inside the fd so open_tun can use it */
         c->c1.tuntap->fd =3D oldtunfd;
 #endif
+
         if (dco_enabled(&c->options))
         {
             ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
@@ -1996,16 +2005,14 @@
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
@@ -2478,7 +2485,7 @@
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
@@ -2701,13 +2708,23 @@
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
@@ -3783,12 +3800,63 @@
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
+do_init_socket_1(struct context *c)
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
+do_init_socket_2(struct context *c)
+{
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
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
@@ -3940,18 +4008,13 @@
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
-
-    if (c->c2.link_socket && c->c2.link_socket_owned)
-    {
-        link_socket_close(c->c2.link_socket);
-        c->c2.link_socket =3D NULL;
+        for (int i =3D 0; i < c->c1.link_sockets_num; i++)
+        {
+            link_socket_close(c->c2.link_sockets[i]);
+        }
+        c->c2.link_sockets =3D NULL;
     }


@@ -3962,28 +4025,33 @@
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

@@ -4466,7 +4534,6 @@
 {
     const struct options *options =3D &c->options;
     const bool child =3D (c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=3D CM=
_CHILD_UDP);
-    int link_socket_mode =3D LS_MODE_DEFAULT;

     /* init garbage collection level */
     gc_init(&c->c2.gc);
@@ -4507,21 +4574,6 @@
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
@@ -4664,7 +4716,7 @@
     /* bind the TCP/UDP socket */
     if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP || c->mode =3D=3D C=
M_CHILD_TCP)
     {
-        link_socket_init_phase1(c, link_socket_mode);
+        do_init_socket_1(c);
     }

     /* initialize tun/tap device object,
@@ -4707,7 +4759,7 @@
     /* finalize the TCP/UDP socket */
     if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP || c->mode =3D=3D C=
M_CHILD_TCP)
     {
-        link_socket_init_phase2(c);
+        do_init_socket_2(c);


         /* Update dynamic frame calculation as exact transport socket info=
rmation
@@ -4843,7 +4895,8 @@

 void
 inherit_context_child(struct context *dest,
-                      const struct context *src)
+                      const struct context *src,
+                      struct link_socket *ls)
 {
     CLEAR(*dest);

@@ -4856,6 +4909,8 @@

     /* c1 init */
     packet_id_persist_init(&dest->c1.pid_persist);
+    dest->c1.link_sockets_num =3D 1;
+    do_link_socket_addr_new(dest);

     dest->c1.ks.key_type =3D src->c1.ks.key_type;
     /* inherit SSL context */
@@ -4880,7 +4935,7 @@
          * The CM_TOP context does the socket listen(),
          * and the CM_CHILD_TCP context does the accept().
          */
-        dest->c2.accept_from =3D src->c2.link_socket;
+        dest->c2.accept_from =3D ls;
     }

 #ifdef ENABLE_PLUGIN
@@ -4904,18 +4959,26 @@
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
index 5fbd7b0..9e915b2 100644
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
@@ -380,10 +381,19 @@
     /* Incoming data on UDP port */
     else if (status & SOCKET_READ)
     {
-        read_incoming_link(&m->top, m->top.c2.link_socket);
-        if (!IS_SIG(&m->top))
+        for (int i =3D 0; i < m->top.c1.link_sockets_num; i++)
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
index 45b3cfa..d9e6b1f 100644
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
 *instance, const unsigned int mpp_flags,
+                            struct link_socket *ls)
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
index f386a3b..a4cea79 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -274,7 +274,8 @@

 void multi_top_free(struct multi_context *m);

-struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real);
+struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real,
+                                             struct link_socket *ls);

 void multi_close_instance(struct multi_context *m, struct multi_instance *=
mi, bool shutdown);

@@ -288,7 +289,8 @@
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
@@ -353,8 +355,10 @@
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
@@ -668,7 +672,7 @@
 #endif
     set_prefix(mi);
     vlan_process_outgoing_tun(m, mi);
-    process_outgoing_tun(&mi->context);
+    process_outgoing_tun(&mi->context, mi->context.c2.link_sockets[0]);
     ret =3D multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
@@ -683,7 +687,7 @@
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
index efd742c..b7d80ee 100644
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
@@ -1837,112 +1849,111 @@
 }

 void
-link_socket_init_phase1(struct context *c, int mode)
+link_socket_init_phase1(struct context *c,
+                        int sock_index,
+                        int mode)
 {
-    struct link_socket *sock =3D c->c2.link_socket;
-    struct options *o =3D &c->options;
-    ASSERT(sock);
+    ASSERT(c->c2.link_sockets[sock_index]);

-    const char *remote_host =3D o->ce.remote;
-    const char *remote_port =3D o->ce.remote_port;
-
-    sock->local_host =3D o->ce.local;
-    sock->local_port =3D o->ce.local_port;
-    sock->remote_host =3D remote_host;
-    sock->remote_port =3D remote_port;
-    sock->dns_cache =3D c->c1.dns_cache;
-    sock->http_proxy =3D c->c1.http_proxy;
-    sock->socks_proxy =3D c->c1.socks_proxy;
-    sock->bind_local =3D o->ce.bind_local;
-    sock->resolve_retry_seconds =3D o->resolve_retry_seconds;
-    sock->mtu_discover_type =3D o->ce.mtu_discover_type;
+    c->c2.link_sockets[sock_index]->local_host =3D c->options.ce.local;
+    c->c2.link_sockets[sock_index]->local_port =3D c->options.ce.local_por=
t;
+    c->c2.link_sockets[sock_index]->remote_host =3D c->options.ce.remote;
+    c->c2.link_sockets[sock_index]->remote_port =3D c->options.ce.remote_p=
ort;
+    c->c2.link_sockets[sock_index]->dns_cache =3D c->c1.dns_cache;
+    c->c2.link_sockets[sock_index]->http_proxy =3D c->c1.http_proxy;
+    c->c2.link_sockets[sock_index]->socks_proxy =3D c->c1.socks_proxy;
+    c->c2.link_sockets[sock_index]->bind_local =3D c->options.ce.bind_loca=
l;
+    c->c2.link_sockets[sock_index]->resolve_retry_seconds =3D c->options.r=
esolve_retry_seconds;
+    c->c2.link_sockets[sock_index]->mtu_discover_type =3D c->options.ce.mt=
u_discover_type;

 #ifdef ENABLE_DEBUG
-    sock->gremlin =3D o->gremlin;
+    c->c2.link_sockets[sock_index]->gremlin =3D c->options.gremlin;
 #endif

-    sock->socket_buffer_sizes.rcvbuf =3D o->rcvbuf;
-    sock->socket_buffer_sizes.sndbuf =3D o->sndbuf;
+    c->c2.link_sockets[sock_index]->socket_buffer_sizes.rcvbuf =3D c->opti=
ons.rcvbuf;
+    c->c2.link_sockets[sock_index]->socket_buffer_sizes.sndbuf =3D c->opti=
ons.sndbuf;

-    sock->sockflags =3D o->sockflags;
+    c->c2.link_sockets[sock_index]->sockflags =3D c->options.sockflags;
+
 #if PORT_SHARE
-    if (o->port_share_host && o->port_share_port)
+    if (c->options.port_share_host && c->options.port_share_port)
     {
-        sock->sockflags |=3D SF_PORT_SHARE;
+        c->c2.link_sockets[sock_index]->sockflags |=3D SF_PORT_SHARE;
     }
 #endif
-    sock->mark =3D o->mark;
-    sock->bind_dev =3D o->bind_dev;

-    sock->info.proto =3D o->ce.proto;
-    sock->info.af =3D o->ce.af;
-    sock->info.remote_float =3D o->ce.remote_float;
-    sock->info.lsa =3D &c->c1.link_socket_addr;
-    sock->info.bind_ipv6_only =3D o->ce.bind_ipv6_only;
-    sock->info.ipchange_command =3D o->ipchange;
-    sock->info.plugins =3D c->plugins;
-    sock->server_poll_timeout =3D &c->c2.server_poll_interval;
+    c->c2.link_sockets[sock_index]->mark =3D c->options.mark;

-    sock->mode =3D mode;
+    c->c2.link_sockets[sock_index]->info.proto =3D c->options.ce.proto;
+    c->c2.link_sockets[sock_index]->info.af =3D c->options.ce.af;
+    c->c2.link_sockets[sock_index]->info.remote_float =3D c->options.ce.re=
mote_float;
+    c->c2.link_sockets[sock_index]->info.lsa =3D &c->c1.link_socket_addrs[=
sock_index];
+    c->c2.link_sockets[sock_index]->info.bind_ipv6_only =3D c->options.ce.=
bind_ipv6_only;
+    c->c2.link_sockets[sock_index]->info.ipchange_command =3D c->options.i=
pchange;
+    c->c2.link_sockets[sock_index]->info.plugins =3D c->plugins;
+    c->c2.link_sockets[sock_index]->server_poll_timeout =3D &c->c2.server_=
poll_interval;
+
+    c->c2.link_sockets[sock_index]->mode =3D mode;
     if (mode =3D=3D LS_MODE_TCP_ACCEPT_FROM)
     {
         ASSERT(c->c2.accept_from);
-        ASSERT(sock->info.proto =3D=3D PROTO_TCP_SERVER);
-        sock->sd =3D c->c2.accept_from->sd;
+        ASSERT(c->c2.link_sockets[sock_index]->info.proto =3D=3D PROTO_TCP=
_SERVER);
+        c->c2.link_sockets[sock_index]->sd =3D c->c2.accept_from->sd;
         /* inherit (possibly guessed) info AF from parent context */
-        sock->info.af =3D c->c2.accept_from->info.af;
+        c->c2.link_sockets[sock_index]->info.af =3D c->c2.accept_from->inf=
o.af;
     }

     /* are we running in HTTP proxy mode? */
-    if (sock->http_proxy)
+    if (c->c2.link_sockets[sock_index]->http_proxy)
     {
-        ASSERT(sock->info.proto =3D=3D PROTO_TCP_CLIENT);
+        ASSERT(c->c2.link_sockets[sock_index]->info.proto =3D=3D PROTO_TCP=
_CLIENT);

         /* the proxy server */
-        sock->remote_host =3D c->c1.http_proxy->options.server;
-        sock->remote_port =3D c->c1.http_proxy->options.port;
+        c->c2.link_sockets[sock_index]->remote_host =3D c->c1.http_proxy->=
options.server;
+        c->c2.link_sockets[sock_index]->remote_port =3D c->c1.http_proxy->=
options.port;

         /* the OpenVPN server we will use the proxy to connect to */
-        sock->proxy_dest_host =3D remote_host;
-        sock->proxy_dest_port =3D remote_port;
+        c->c2.link_sockets[sock_index]->proxy_dest_host =3D c->options.ce.=
remote;
+        c->c2.link_sockets[sock_index]->proxy_dest_port =3D c->options.ce.=
remote_port;
     }
     /* or in Socks proxy mode? */
-    else if (sock->socks_proxy)
+    else if (c->c2.link_sockets[sock_index]->socks_proxy)
     {
+
         /* the proxy server */
-        sock->remote_host =3D c->c1.socks_proxy->server;
-        sock->remote_port =3D c->c1.socks_proxy->port;
+        c->c2.link_sockets[sock_index]->remote_host =3D c->c1.socks_proxy-=
>server;
+        c->c2.link_sockets[sock_index]->remote_port =3D c->c1.socks_proxy-=
>port;

         /* the OpenVPN server we will use the proxy to connect to */
-        sock->proxy_dest_host =3D remote_host;
-        sock->proxy_dest_port =3D remote_port;
+        c->c2.link_sockets[sock_index]->proxy_dest_host =3D c->options.ce.=
remote;
+        c->c2.link_sockets[sock_index]->proxy_dest_port =3D c->options.ce.=
remote_port;
     }
     else
     {
-        sock->remote_host =3D remote_host;
-        sock->remote_port =3D remote_port;
+        c->c2.link_sockets[sock_index]->remote_host =3D c->options.ce.remo=
te;
+        c->c2.link_sockets[sock_index]->remote_port =3D c->options.ce.remo=
te_port;
     }

     /* bind behavior for TCP server vs. client */
-    if (sock->info.proto =3D=3D PROTO_TCP_SERVER)
+    if (c->c2.link_sockets[sock_index]->info.proto =3D=3D PROTO_TCP_SERVER)
     {
-        if (sock->mode =3D=3D LS_MODE_TCP_ACCEPT_FROM)
+        if (c->c2.link_sockets[sock_index]->mode =3D=3D LS_MODE_TCP_ACCEPT=
_FROM)
         {
-            sock->bind_local =3D false;
+            c->c2.link_sockets[sock_index]->bind_local =3D false;
         }
         else
         {
-            sock->bind_local =3D true;
+            c->c2.link_sockets[sock_index]->bind_local =3D true;
         }
     }

     if (mode !=3D LS_MODE_TCP_ACCEPT_FROM)
     {
-        if (sock->bind_local)
+        if (c->c2.link_sockets[sock_index]->bind_local)
         {
-            resolve_bind_local(sock, sock->info.af);
+            resolve_bind_local(c->c2.link_sockets[sock_index], c->c2.link_=
sockets[sock_index]->info.af);
         }
-        resolve_remote(sock, 1, NULL, NULL);
+        resolve_remote(c->c2.link_sockets[sock_index], 1, NULL, NULL);
     }
 }

@@ -2172,22 +2183,21 @@

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
@@ -2209,7 +2219,7 @@
     /* If a valid remote has been found, create the socket with its addrin=
fo */
     if (sock->info.lsa->current_remote)
     {
-#if defined(_WIN32)
+#if defined (_WIN32)
         if (dco_enabled(&c->options))
         {
             create_socket_dco_win(c, sock, sig_info);
@@ -2220,7 +2230,6 @@
         {
             create_socket(sock, sock->info.lsa->current_remote);
         }
-
     }

     /* If socket has not already been created create it now */
@@ -2239,7 +2248,6 @@
                     addr_family_name(sock->info.lsa->bind_local->ai_family=
));
                 sock->info.af =3D sock->info.lsa->bind_local->ai_family;
             }
-
             create_socket(sock, sock->info.lsa->bind_local);
         }
     }
@@ -2248,7 +2256,7 @@
     if (sock->sd =3D=3D SOCKET_UNDEFINED)
     {
         msg(M_WARN, "Could not determine IPv4/IPv6 protocol");
-        register_signal(sig_info, SIGUSR1, "Could not determine IPv4/IPv6 =
protocol");
+        sig_info->signal_received =3D SIGUSR1;
         goto done;
     }

@@ -2259,7 +2267,8 @@

     if (sock->info.proto =3D=3D PROTO_TCP_SERVER)
     {
-        phase2_tcp_server(sock, remote_dynamic, sig_info);
+        phase2_tcp_server(sock, remote_dynamic,
+                          sig_info);
     }
     else if (sock->info.proto =3D=3D PROTO_TCP_CLIENT)
     {
@@ -2285,16 +2294,11 @@
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
index 465d92b..13b51c3 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -344,9 +344,15 @@
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
+                             struct link_socket *sock,
+                             const struct frame *frame,
+                             struct signal_info *sig_info);

 void do_preresolve(struct context *c);

@@ -1228,11 +1234,12 @@
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
Gerrit-PatchSet: 7
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--RKzxyuoISIg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>its_Giaan <strong>uploaded patch set #7</strong> to the change originall=
y created by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
434?usp=3Demail">View Change</a></p><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Adapt socket handling to support listening=
 on multiple sockets<br><br>    Introduce internal changes preparing the se=
rver to<br>    handle multiple sockets concurrently for both<br>    TCP and=
 UDP protocols. While no user-visible<br>    features are implemented yet, =
these modifications<br>    are essential for enabling future functionality<=
br>    such as listening on multiple ports.<br><br>    Key changes are: con=
verting link_socket from a<br>    single pointer to an array in various con=
texts,<br>    in order to be able to store multiple sockets<br>    at once.=
<br><br>Change-Id: Ia0a889e800f0b36aed770ee36e31afeec5df6084<br>Signed-off-=
by: Antonio Quartulli &lt;a@...2181...&gt;<br>Signed-off-by: Gianmarco De G=
regori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/dco.c<br>M src/=
openvpn/event.h<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M =
src/openvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn/mss.c<br>M src/=
openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M src/openvpn/mudp.h<br>M src/ope=
nvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/openvpn.c<br>M src/o=
penvpn/openvpn.h<br>M src/openvpn/ping.h<br>M src/openvpn/socket.c<br>M src=
/openvpn/socket.h<br>17 files changed, 380 insertions(+), 251 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/4=
34/7</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><=
span>index 38f934a..c18ba3e 100644</span><br><span>--- a/src/openvpn/dco.c<=
/span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -479,11 +479,11 =
@@</span><br><span>         return 0;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_so=
cket *ls =3D c-&gt;c2.link_socket;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct link_socket *sock =3D c-&gt;c2.link_sockets[0];</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    A=
SSERT(ls-&gt;info.connection_established);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ASSERT(sock-&gt;info.connection_established);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct sockaddr *remoteaddr =3D &amp;ls-&gt;info.lsa-&gt;actual.dest.addr.sa;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr=
 *remoteaddr =3D &amp;sock-&gt;info.lsa-&gt;actual.dest.addr.sa;</span><br>=
<span>     struct tls_multi *multi =3D c-&gt;c2.tls_multi;</span><br><span>=
 #ifdef TARGET_FREEBSD</span><br><span>     /* In Linux in P2P mode the ker=
nel automatically removes an existing peer</span><br><span>@@ -495,7 +495,7=
 @@</span><br><span>     }</span><br><span> #endif</span><br><span>     int=
 ret =3D dco_new_peer(&amp;c-&gt;c1.tuntap-&gt;dco, multi-&gt;peer_id,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
 c-&gt;c2.link_socket-&gt;sd, NULL, remoteaddr, NULL, NULL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                           c-&gt;c=
2.link_sockets[0]-&gt;sd, NULL, remoteaddr, NULL, NULL);</span><br><span>  =
   if (ret &lt; 0)</span><br><span>     {</span><br><span>         return r=
et;</span><br><span>@@ -528,12 +528,12 @@</span><br><span> #if ENABLE_IP_PK=
TINFO</span><br><span>     struct context *c =3D &amp;mi-&gt;context;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
proto_is_udp(c-&gt;c2.link_socket-&gt;info.proto) || !(c-&gt;options.sockfl=
ags &amp; SF_USE_IP_PKTINFO))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!proto_is_udp(c-&gt;c2.link_sockets[0]-&gt;info.proto) ||=
 !(c-&gt;options.sockflags &amp; SF_USE_IP_PKTINFO))</span><br><span>     {=
</span><br><span>         return false;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_=
socket_actual *actual =3D &amp;c-&gt;c2.link_socket_info-&gt;lsa-&gt;actual=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_so=
cket_actual *actual =3D &amp;c-&gt;c2.link_socket_infos[0]-&gt;lsa-&gt;actu=
al;</span><br><span> </span><br><span>     switch (actual-&gt;dest.addr.sa.=
sa_family)</span><br><span>     {</span><br><span>@@ -578,7 +578,7 @@</span=
><br><span>     int peer_id =3D c-&gt;c2.tls_multi-&gt;peer_id;</span><br><=
span>     struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><span=
>     struct sockaddr_storage local =3D { 0 };</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int sd =3D c-&gt;c2.link_socket-&gt;sd;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int sd =3D c-&gt;c2.li=
nk_sockets[0]-&gt;sd;</span><br><span> </span><br><span> </span><br><span> =
    if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span>@@ -588,8 +588,8 @@=
</span><br><span>     }</span><br><span>     else</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(c-&gt;c2.=
link_socket_info-&gt;connection_established);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        remoteaddr =3D &amp;c-&gt;c2.link_socket_in=
fo-&gt;lsa-&gt;actual.dest.addr.sa;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ASSERT(c-&gt;c2.link_socket_infos[0]-&gt;connection=
_established);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   remoteaddr =3D &amp;c-&gt;c2.link_socket_infos[0]-&gt;lsa-&gt;actual.des=
t.addr.sa;</span><br><span>     }</span><br><span> </span><br><span>     /*=
 In server mode we need to fetch the remote addresses from the push config =
*/</span><br><span>diff --git a/src/openvpn/event.h b/src/openvpn/event.h</=
span><br><span>index c212e07..329a8f8 100644</span><br><span>--- a/src/open=
vpn/event.h</span><br><span>+++ b/src/openvpn/event.h</span><br><span>@@ -1=
41,6 +141,7 @@</span><br><span> struct event_arg</span><br><span> {</span><=
br><span>     event_arg_t type;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    bool pending; /* in UDP/P2P mode marks sockets waiting for =
processing */</span><br><span>     union {</span><br><span>         struct =
multi_instance *mi; /* if type =3D EVENT_ARG_MULTI_INSTANCE */</span><br><s=
pan>         struct link_socket *sock; /* if type =3D EVENT_ARG_LINK_SOCKET=
 */</span><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forwar=
d.c</span><br><span>index d50b24c..7e033c9 100644</span><br><span>--- a/src=
/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><s=
pan>@@ -58,12 +58,17 @@</span><br><span> wait_status_string(struct context =
*c, struct gc_arena *gc)</span><br><span> {</span><br><span>     struct buf=
fer out =3D alloc_buf_gc(64, gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    buf_printf(&amp;out, &quot;I/O WAIT %s|%s|%s|%s %s&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;I/O WAIT =
%s|%s| %s&quot;,</span><br><span>                tun_stat(c-&gt;c1.tuntap, =
EVENT_READ, gc),</span><br><span>                tun_stat(c-&gt;c1.tuntap, =
EVENT_WRITE, gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
           socket_stat(c-&gt;c2.link_socket, EVENT_READ, gc),</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-               socket_stat(c-&gt;c2=
.link_socket, EVENT_WRITE, gc),</span><br><span>                tv_string(&=
amp;c-&gt;c2.timeval, gc));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;\n %s=
|%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
          socket_stat(c-&gt;c2.link_sockets[i], EVENT_READ, gc),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                   socket_stat=
(c-&gt;c2.link_sockets[i], EVENT_WRITE, gc));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span>     return BSTR(&amp;out);=
</span><br><span> }</span><br><span> </span><br><span>@@ -99,7 +104,7 @@</s=
pan><br><span> {</span><br><span>     if (c-&gt;c2.tls_multi &amp;&amp; c-&=
gt;c2.tls_exit_signal)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (link_socket_connection_oriented(c-&gt;c=
2.link_socket))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (link_socket_connection_oriented(c-&gt;c2.link_sockets[0]))</span><b=
r><span>         {</span><br><span>             if (c-&gt;c2.tls_multi-&gt;=
n_soft_errors)</span><br><span>             {</span><br><span>@@ -567,6 +57=
2,7 @@</span><br><span> #ifdef ENABLE_FRAGMENT</span><br><span> /*</span><b=
r><span>  * Should we deliver a datagram fragment to remote?</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * c is expected to be a single-li=
nk context (p2p or child)</span><br><span>  */</span><br><span> static void=
</span><br><span> check_fragment(struct context *c)</span><br><span>@@ -112=
3,7 +1129,9 @@</span><br><span>         decrypt_status =3D openvpn_decrypt(=
&amp;c-&gt;c2.buf, c-&gt;c2.buffers-&gt;decrypt_buf,</span><br><span>      =
                                    co, &amp;c-&gt;c2.frame, ad_start);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (!decrypt_status &amp;&amp; link_socket_connection_oriented(c-&gt;c2.li=
nk_socket))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!decrypt_status</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /* all sockets are of the same type, so just check the first on=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &am=
p;&amp; link_socket_connection_oriented(c-&gt;c2.link_sockets[0]))</span><b=
r><span>         {</span><br><span>             /* decryption errors are fa=
tal in TCP mode */</span><br><span>             register_signal(c-&gt;sig, =
SIGUSR1, &quot;decryption-error&quot;); /* SOFT-SIGUSR1 -- decryption error=
 in TCP mode */</span><br><span>@@ -1454,7 +1462,7 @@</span><br><span>  */<=
/span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-process_incoming_tun(struct context *c)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+process_incoming_tun(struct context *=
c, struct link_socket *out_sock)</span><br><span> {</span><br><span>     st=
ruct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -1487,7=
 +1495,7 @@</span><br><span>          */</span><br><span>         unsigned =
int flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT</span><br><span=
>                              | PIPV6_ICMP_NOHOST_CLIENT;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        process_ip_header(c, flags, &a=
mp;c-&gt;c2.buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      process_ip_header(c, flags, &amp;c-&gt;c2.buf, out_sock);</span><br><=
span> </span><br><span> #ifdef PACKET_TRUNCATION_CHECK</span><br><span>    =
     /* if (c-&gt;c2.buf.len &gt; 1) --c-&gt;c2.buf.len; */</span><br><span=
>@@ -1648,7 +1656,8 @@</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-process_ip_head=
er(struct context *c, unsigned int flags, struct buffer *buf)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+process_ip_header(struct context =
*c, unsigned int flags, struct buffer *buf,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                  struct link_socket *sock)</span><=
br><span> {</span><br><span>     if (!c-&gt;options.ce.mssfix)</span><br><s=
pan>     {</span><br><span>@@ -1682,7 +1691,7 @@</span><br><span>          =
   /* extract TOS from IP header */</span><br><span>             if (flags =
&amp; PIPV4_PASSTOS)</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                link_socket_extract_tos(c-&=
gt;c2.link_socket, &amp;ipbuf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                link_socket_extract_tos(sock, &amp;ipbuf);</spa=
n><br><span>             }</span><br><span> #endif</span><br><span> </span>=
<br><span>@@ -1890,7 +1899,7 @@</span><br><span>  */</span><br><span> </spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-proc=
ess_outgoing_tun(struct context *c)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+process_outgoing_tun(struct context *c, struct link_socket =
*in_sock)</span><br><span> {</span><br><span>     /*</span><br><span>      =
* Set up for write() call to TUN/TAP</span><br><span>@@ -1907,9 +1916,8 @@<=
/span><br><span>      * The --mssfix option requires</span><br><span>      =
* us to examine the IP header (IPv4 or IPv6).</span><br><span>      */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    process_ip_header(c,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      P=
IP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIENT_NAT | PIP_OUTGOING,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                      &a=
mp;c-&gt;c2.to_tun);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIENT=
_NAT|PIP_OUTGOING, &amp;c-&gt;c2.to_tun,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                      in_sock);</span><br><span> </spa=
n><br><span>     if (c-&gt;c2.to_tun.len &lt;=3D c-&gt;c2.frame.buf.payload=
_size)</span><br><span>     {</span><br><span>@@ -2183,8 +2191,11 @@</span>=
<br><span>     /*</span><br><span>      * Configure event wait based on soc=
ket, tuntap flags.</span><br><span>      */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    socket_set(c-&gt;c2.link_socket, c-&gt;c2.event_s=
et, socket,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
     &amp;c-&gt;c2.link_socket-&gt;ev_arg, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; c-&gt;c1.link_so=
ckets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_set=
(c-&gt;c2.link_sockets[i], c-&gt;c2.event_set, socket,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                   &amp;c-&gt;c2.link_so=
ckets[i]-&gt;ev_arg, NULL);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span>     tun_set(c-&gt;c1.tuntap, c-&gt;c2.event_=
set, tuntap, (void *)tun_shift, NULL);</span><br><span> #if defined(TARGET_=
LINUX) || defined(TARGET_FREEBSD)</span><br><span>     if (socket &amp; EVE=
NT_READ &amp;&amp; c-&gt;c2.did_open_tun)</span><br><span>@@ -2222,7 +2233,=
7 @@</span><br><span> </span><br><span>     if (!c-&gt;sig-&gt;signal_recei=
ved)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (!(flags &amp; IOW_CHECK_RESIDUAL) || !socket_read_residua=
l(c-&gt;c2.link_socket))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (!(flags &amp; IOW_CHECK_RESIDUAL) || !sockets_read_residua=
l(c))</span><br><span>         {</span><br><span>             int status;</=
span><br><span> </span><br><span>@@ -2261,6 +2272,9 @@</span><br><span>    =
                     }</span><br><span> </span><br><span>                  =
       shift =3D socket_shift;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        /* mark socket so that the multi code kn=
ows where we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                  * have pending i/o */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        ev_arg-&gt;pending =3D true;</s=
pan><br><span>                     }</span><br><span>                     e=
lse</span><br><span>                     {</span><br><span>@@ -2314,7 +2328=
,7 @@</span><br><span>     /* TUN device ready to accept write */</span><br=
><span>     else if (status &amp; TUN_WRITE)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        process_outgoing_tun(=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        process_=
outgoing_tun(c, sock);</span><br><span>     }</span><br><span>     /* Incom=
ing data on TCP/UDP port */</span><br><span>     else if (status &amp; SOCK=
ET_READ)</span><br><span>@@ -2331,7 +2345,7 @@</span><br><span>         rea=
d_incoming_tun(c);</span><br><span>         if (!IS_SIG(c))</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  process_incoming_tun(c);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            process_incoming_tun(c, sock);</span><br><span>         =
}</span><br><span>     }</span><br><span>     else if (status &amp; DCO_REA=
D)</span><br><span>diff --git a/src/openvpn/forward.h b/src/openvpn/forward=
.h</span><br><span>index 8ef19b4..5c2fdb8 100644</span><br><span>--- a/src/=
openvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.h</span><br><sp=
an>@@ -231,10 +231,12 @@</span><br><span>  *</span><br><span>  * If an erro=
r occurs, it is logged and the packet is dropped.</span><br><span>  *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param c - The context s=
tructure of the VPN tunnel associated with the</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *     packet.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param c       The context structure of the VPN tunn=
el associated with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*                the packet.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param out_sock  Socket that will be used to send out the packe=
t.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void process_in=
coming_tun(struct context *c);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void process_incoming_tun(struct context *c, struct link_socket =
*out_sock);</span><br><span> </span><br><span> </span><br><span> /**</span>=
<br><span>@@ -246,10 +248,11 @@</span><br><span>  *</span><br><span>  * If =
an error occurs, it is logged and the packet is dropped.</span><br><span>  =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param c - The co=
ntext structure of the VPN tunnel associated with</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *     the packet.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param c      The context structure of the VP=
N tunnel associated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *               with the packet.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param in_sock  Socket where the packet was received.</spa=
n><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
process_outgoing_tun(struct context *c);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void process_outgoing_tun(struct context *c, struct li=
nk_socket *in_sock);</span><br><span> </span><br><span> </span><br><span> /=
**************************************************************************/=
</span><br><span>@@ -304,20 +307,21 @@</span><br><span> #define PIPV6_ICMP_=
NOHOST_SERVER        (1&lt;&lt;6)</span><br><span> </span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void process_ip_header(stru=
ct context *c, unsigned int flags, struct buffer *buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void process_ip_header(struct context *=
c, unsigned int flags, struct buffer *buf,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                       struct link_socket *sock);</s=
pan><br><span> </span><br><span> bool schedule_exit(struct context *c);</sp=
an><br><span> </span><br><span> static inline struct link_socket_info *</sp=
an><br><span> get_link_socket_info(struct context *c)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.link_so=
cket_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
-&gt;c2.link_socket_infos)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return c-&gt;c2.link_socket_info;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return c-&gt;c2.l=
ink_socket_infos[0];</span><br><span>     }</span><br><span>     else</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return &amp;c-&gt;c2.link_socket-&gt;info;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return &amp;c-&gt;c2.link_sockets[0]-&gt=
;info;</span><br><span>     }</span><br><span> }</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><spa=
n>index 9371024..adf24ea 100644</span><br><span>--- a/src/openvpn/init.c</s=
pan><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -528,12 +528,11 @=
@</span><br><span>         {</span><br><span>             /* Check if there=
 is another resolved address to try for</span><br><span>              * the=
 current connection */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (c-&gt;c1.link_socket_addr.current_remote</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                &amp;&amp; c-&gt;c1.lin=
k_socket_addr.current_remote-&gt;ai_next</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                &amp;&amp; !c-&gt;options.advance_next_r=
emote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (c-&gt;c1.link_socket_addrs[0].current_remote</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                &amp;&amp; c-&gt;c1.link_socket=
_addrs[0].current_remote-&gt;ai_next)</span><br><span>             {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c1.lin=
k_socket_addr.current_remote =3D</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    c-&gt;c1.link_socket_addr.current_remote-&gt=
;ai_next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      c-&gt;c1.link_socket_addrs[0].current_remote =3D</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    c-&gt;c1.link_socket=
_addrs[0].current_remote-&gt;ai_next;</span><br><span>             }</span>=
<br><span>             else</span><br><span>             {</span><br><span>=
@@ -549,20 +548,20 @@</span><br><span>                      * skipped by ma=
nagement on the previous loop.</span><br><span>                      * If s=
o, clear the addrinfo objects as close_instance does</span><br><span>      =
                */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 if (c-&gt;c1.link_socket_addr.remote_list)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    if (c-&gt;c1.li=
nk_socket_addrs[0].remote_list)</span><br><span>                     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        cl=
ear_remote_addrlist(&amp;c-&gt;c1.link_socket_addr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        clear_remote_addr=
list(&amp;c-&gt;c1.link_socket_addrs[0],</span><br><span>                  =
                             !c-&gt;options.resolve_in_advance);</span><br>=
<span>                     }</span><br><span> </span><br><span>            =
         /* close_instance should have cleared the addrinfo objects */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ASSERT=
(c-&gt;c1.link_socket_addr.current_remote =3D=3D NULL);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    ASSERT(c-&gt;c1.link_=
socket_addr.remote_list =3D=3D NULL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    ASSERT(c-&gt;c1.link_socket_addrs[0].=
current_remote =3D=3D NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    ASSERT(c-&gt;c1.link_socket_addrs[0].remote_li=
st =3D=3D NULL);</span><br><span>                 }</span><br><span>       =
          else</span><br><span>                 {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    c-&gt;c1.link_socket_addr.c=
urrent_remote =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    c-&gt;c1.link_socket_addr.remote_list;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    c-&gt;c1.link_so=
cket_addrs[0].current_remote =3D</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        c-&gt;c1.link_socket_addrs[0].remote_l=
ist;</span><br><span>                 }</span><br><span> </span><br><span> =
                int advance_count =3D 1;</span><br><span>@@ -727,6 +726,13 =
@@</span><br><span>     uninit_proxy_dowork(c);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_link_socket_add=
r_new(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARR=
AY_CLEAR_GC(c-&gt;c1.link_socket_addrs, struct link_socket_addr,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                         c-&gt=
;c1.link_sockets_num, &amp;c-&gt;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> void</span><br><span> context_init_1(struct context *c)</=
span><br><span> {</span><br><span>@@ -736,6 +742,10 @@</span><br><span> </s=
pan><br><span>     init_connection_list(c);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c1.link_sockets_num =3D=
 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    do_link_socket_addr_new(c);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if d=
efined(ENABLE_PKCS11)</span><br><span>     if (c-&gt;first_time)</span><br>=
<span>     {</span><br><span>@@ -1636,7 +1646,7 @@</span><br><span>        =
 CLEAR(local);</span><br><span>         actual =3D &amp;get_link_socket_inf=
o(c)-&gt;lsa-&gt;actual;</span><br><span>         remote =3D actual-&gt;des=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        getsockname=
(c-&gt;c2.link_socket-&gt;sd, &amp;local.addr.sa, &amp;sa_len);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        getsockname(c-&gt;c2.li=
nk_sockets[0]-&gt;sd, &amp;local.addr.sa, &amp;sa_len);</span><br><span> #i=
f ENABLE_IP_PKTINFO</span><br><span>         if (!addr_defined(&amp;local))=
</span><br><span>         {</span><br><span>@@ -1762,8 +1772,8 @@</span><br=
><span>                             c-&gt;options.ifconfig_ipv6_local,</spa=
n><br><span>                             c-&gt;options.ifconfig_ipv6_netbit=
s,</span><br><span>                             c-&gt;options.ifconfig_ipv6=
_remote,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
               c-&gt;c1.link_socket_addr.bind_local,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                            c-&gt;c1.link_s=
ocket_addr.remote_list,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                            c-&gt;c1.link_socket_addrs[0].bind_local,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
       c-&gt;c1.link_socket_addrs[0].remote_list,</span><br><span>         =
                    !c-&gt;options.ifconfig_nowarn,</span><br><span>       =
                      c-&gt;c2.es,</span><br><span>                        =
     &amp;c-&gt;net_ctx,</span><br><span>@@ -1946,17 +1956,16 @@</span><br>=
<span>         do_alloc_route_list(c);</span><br><span> </span><br><span>  =
       /* parse and resolve the route option list */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(c-&gt;c2.link_socket);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(c-&gt;c2.l=
ink_sockets);</span><br><span>         if (c-&gt;options.routes &amp;&amp; =
c-&gt;c1.route_list)</span><br><span>         {</span><br><span>           =
  do_init_route_list(&amp;c-&gt;options, c-&gt;c1.route_list,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                               &amp=
;c-&gt;c2.link_socket-&gt;info, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
  &amp;c-&gt;c2.link_sockets[0]-&gt;info, c-&gt;c2.es, &amp;c-&gt;net_ctx);=
</span><br><span>         }</span><br><span>         if (c-&gt;options.rout=
es_ipv6 &amp;&amp; c-&gt;c1.route_ipv6_list)</span><br><span>         {</sp=
an><br><span>             do_init_route_ipv6_list(&amp;c-&gt;options, c-&gt=
;c1.route_ipv6_list,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                   &amp;c-&gt;c2.link_socket-&gt;info, c-&g=
t;c2.es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                       &amp;c-&gt;net_ctx);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                    &amp;c-&gt;c2.l=
ink_sockets[0]-&gt;info, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span>=
         }</span><br><span> </span><br><span>         /* do ifconfig */</sp=
an><br><span>@@ -1969,8 +1978,7 @@</span><br><span>                        =
                          c-&gt;options.dev_type,</span><br><span>         =
                                         c-&gt;options.dev_node,</span><br>=
<span>                                                  &amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            do_ifconfig(c-&gt;c=
1.tuntap, guess, c-&gt;c2.frame.tun_mtu, c-&gt;c2.es,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        &amp;c-&gt;net_ctx)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            do_ifc=
onfig(c-&gt;c1.tuntap, guess, c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&=
gt;net_ctx);</span><br><span>         }</span><br><span> </span><br><span> =
        /* possibly add routes */</span><br><span>@@ -1985,6 +1993,7 @@</sp=
an><br><span>         /* Store the old fd inside the fd so open_tun can use=
 it */</span><br><span>         c-&gt;c1.tuntap-&gt;fd =3D oldtunfd;</span>=
<br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>         if (dco_enabled(&amp;c-&gt;options))</span><br><spa=
n>         {</span><br><span>             ovpn_dco_init(c-&gt;mode, &amp;c-=
&gt;c1.tuntap-&gt;dco);</span><br><span>@@ -1996,16 +2005,14 @@</span><br><=
span>         /* set the hardware address */</span><br><span>         if (c=
-&gt;options.lladdr)</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            set_lladdr(&amp;c-&gt;net_ctx, c-&gt;=
c1.tuntap-&gt;actual_name, c-&gt;options.lladdr,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                       c-&gt;c2.es);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            set_lladdr(&amp;c-&=
gt;net_ctx, c-&gt;c1.tuntap-&gt;actual_name, c-&gt;options.lladdr, c-&gt;c2=
.es);</span><br><span>         }</span><br><span> </span><br><span>        =
 /* do ifconfig */</span><br><span>         if (!ifconfig_noexec_enabled(c)=
</span><br><span>             &amp;&amp; ifconfig_order(c-&gt;c1.tuntap) =
=3D=3D IFCONFIG_AFTER_TUN_OPEN)</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            do_ifconfig(c-&gt;c1.tunta=
p, c-&gt;c1.tuntap-&gt;actual_name,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, =
&amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            do_ifconfig(c-&gt;c1.tuntap, c-&gt;c1.tuntap-&gt;actual_name, =
c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span> =
        }</span><br><span> </span><br><span>         /* run the up script *=
/</span><br><span>@@ -2478,7 +2485,7 @@</span><br><span>                 {<=
/span><br><span>                     msg(M_NONFATAL, &quot;dco-win doesn&#3=
9;t yet support reopening TUN device&quot;);</span><br><span>              =
       /* prevent link_socket_close() from closing handle with WinSock API =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 c-&gt;c2.link_socket-&gt;sd =3D SOCKET_UNDEFINED;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    c-&gt;c2.link_sockets[0]=
-&gt;sd =3D SOCKET_UNDEFINED;</span><br><span>                     return f=
alse;</span><br><span>                 }</span><br><span>                 e=
lse</span><br><span>@@ -2701,13 +2708,23 @@</span><br><span>     if (found =
&amp; OPT_P_SOCKBUF)</span><br><span>     {</span><br><span>         msg(D_=
PUSH, &quot;OPTIONS IMPORT: --sndbuf/--rcvbuf options modified&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        link_socket_update=
_buffer_sizes(c-&gt;c2.link_socket, c-&gt;options.rcvbuf, c-&gt;options.snd=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; =
c-&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            link_socket_update_buffer_sizes(c-&gt;c2.link_sockets[i],</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                     c-&gt;options.rcvbuf,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                            c-&gt;op=
tions.sndbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span>     }</span><br><span> </span><br><span>     if (foun=
d &amp; OPT_P_SOCKFLAGS)</span><br><span>     {</span><br><span>         ms=
g(D_PUSH, &quot;OPTIONS IMPORT: --socket-flags option modified&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        link_socket_update=
_flags(c-&gt;c2.link_socket, c-&gt;options.sockflags);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; c-&gt;c=
1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       link_socket_update_flags(c-&gt;c2.link_sockets[i],</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
c-&gt;options.sockflags);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span>     }</span><br><span> </span><br><span>  =
   if (found &amp; OPT_P_PERSIST)</span><br><span>@@ -3783,12 +3800,63 @@</=
span><br><span> static void</span><br><span> do_link_socket_new(struct cont=
ext *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    ASSERT(!c-&gt;c2.link_socket);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    c-&gt;c2.link_socket =3D link_socket_new();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!c-&gt;c2.link_soc=
kets);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY_GC(c-&gt;c2.link=
_sockets, struct link_socket *,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                   c-&gt;c1.link_sockets_num, &amp;c-&gt;c2.gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; c-&gt;c1=
.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-=
&gt;c2.link_sockets[i] =3D link_socket_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span>     c-&gt;c2.link_socket_o=
wned =3D true;</span><br><span> }</span><br><span> </span><br><span> /*</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * bind TCP/UDP sockets=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+do_init_socket_1(struct context *c)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; c-&gt;c1.lin=
k_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int mo=
de =3D LS_MODE_DEFAULT;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* mode=
 allows CM_CHILD_TCP</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+         * instances to inherit acceptable fds</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * from a top-level parent */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;options.mod=
e =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    /* initializing listening socket */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (c-&gt;mode =3D=3D CM_TOP)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                mode =3D LS_MODE_TCP_LI=
STEN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* initi=
alizing socket to client */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            else if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                mode =3D LS_MODE_TCP_ACC=
EPT_FROM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* init each socket with its specific=
 args */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        lin=
k_socket_init_phase1(c, i, mode);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * finalize TCP/UDP sockets</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+do_init_socket_2(struct context *c)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        link_socket_init_phase2(c, c-&gt;c2.l=
ink_sockets[i], &amp;c-&gt;c2.frame, c-&gt;sig);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  *=
 Print MTU INFO</span><br><span>  */</span><br><span> static void</span><br=
><span>@@ -3940,18 +4008,13 @@</span><br><span> static void</span><br><span=
> do_close_link_socket(struct context *c)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* in dco-win case, link socket =
is a tun handle which is</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * closed in do_close_tun(). Set it to UNDEFINED so</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * we won&#39;t use WinSock API to=
 close it. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
tuntap_is_dco_win(c-&gt;c1.tuntap) &amp;&amp; c-&gt;c2.link_socket)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.link_socke=
ts &amp;&amp; c-&gt;c2.link_socket_owned)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2.link_socket-&gt=
;sd =3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.link_socket &amp=
;&amp; c-&gt;c2.link_socket_owned)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     link_socket_close(c-&gt;c2.link_socket);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        c-&gt;c2.link_socket =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt;=
 c-&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            link_socket_close(c-&gt;c2.link_sockets[i]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        c-&gt;c2.link_sockets =3D NULL;</span=
><br><span>     }</span><br><span> </span><br><span> </span><br><span>@@ -3=
962,28 +4025,33 @@</span><br><span>           &amp;&amp; ( (c-&gt;options.p=
ersist_remote_ip)</span><br><span>                ||</span><br><span>      =
          ( c-&gt;sig-&gt;source !=3D SIG_SOURCE_HARD</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 &amp;&amp; ((c-&gt;c1.link=
_socket_addr.current_remote</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                      &amp;&amp; c-&gt;c1.link_socket_addr.current_re=
mote-&gt;ai_next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
               &amp;&amp; ((c-&gt;c1.link_socket_addrs[0].current_remote</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
&amp;&amp; c-&gt;c1.link_socket_addrs[0].current_remote-&gt;ai_next)</span>=
<br><span>                      || c-&gt;options.no_advance))</span><br><sp=
an>                )))</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        clear_remote_addrlist(&amp;c-&gt;c1.link_so=
cket_addr, !c-&gt;options.resolve_in_advance);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        clear_remote_addrlist(&amp;c-&gt;c1.link=
_socket_addrs[0],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                            !c-&gt;options.resolve_in_advance);</span><br><=
span>     }</span><br><span> </span><br><span>     /* Clear the remote actu=
al address when persist_remote_ip is not in use */</span><br><span>     if =
(!(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1 &amp;&amp; c-&gt;options.pe=
rsist_remote_ip))</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        CLEAR(c-&gt;c1.link_socket_addr.actual);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(c-&gt;c1.link=
_socket_addrs[0].actual);</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(c-&gt;sig-&gt;signal=
_received =3D=3D SIGUSR1 &amp;&amp; c-&gt;options.persist_local_ip))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &l=
t; c-&gt;c1.link_sockets_num; i++)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;c1.link_socket_addr.b=
ind_local &amp;&amp; !c-&gt;options.resolve_in_advance)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!(c-&gt;sig-&gt;signal_rece=
ived =3D=3D SIGUSR1 &amp;&amp; c-&gt;options.persist_local_ip))</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      freeaddrinfo(c-&gt;c1.link_socket_addr.bind_local);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if (c-&gt;c1.link_socket_addrs[i].bin=
d_local</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    &amp;&amp; !c-&gt;options.resolve_in_advance)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                freeaddrinfo(c-&gt;c1.link_socket_a=
ddrs[i].bind_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        c-&gt;c1.link_socket_addr.bind_local =3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c1.link_soc=
ket_addrs[i].bind_local =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span>@@ -4466,7 +4534,6 @@</span><br><span> {</span><br=
><span>     const struct options *options =3D &amp;c-&gt;options;</span><br=
><span>     const bool child =3D (c-&gt;mode =3D=3D CM_CHILD_TCP || c-&gt;m=
ode =3D=3D CM_CHILD_UDP);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int link_socket_mode =3D LS_MODE_DEFAULT;</span><br><span> </span><=
br><span>     /* init garbage collection level */</span><br><span>     gc_i=
nit(&amp;c-&gt;c2.gc);</span><br><span>@@ -4507,21 +4574,6 @@</span><br><sp=
an>     /* map in current connection entry */</span><br><span>     next_con=
nection_entry(c);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* link_socket_mode allows CM_CHILD_TCP</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-     * instances to inherit acceptable =
fds</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * from a top-=
level parent */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (c-&gt;options.ce.proto =3D=3D PROTO_TCP_SERVER)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            link_socket_mode =3D LS_MODE_TCP_LISTEN;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        else if (c-&gt;mode =3D=3D CM_CH=
ILD_TCP)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            link_socket_m=
ode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
     /* should we disable paging? */</span><br><span>     if (c-&gt;first_t=
ime &amp;&amp; options-&gt;mlock)</span><br><span>     {</span><br><span>@@=
 -4664,7 +4716,7 @@</span><br><span>     /* bind the TCP/UDP socket */</spa=
n><br><span>     if (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP |=
| c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        link_socket_init_phase1(c, link_=
socket_mode);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  do_init_socket_1(c);</span><br><span>     }</span><br><span> </span><br><=
span>     /* initialize tun/tap device object,</span><br><span>@@ -4707,7 +=
4759,7 @@</span><br><span>     /* finalize the TCP/UDP socket */</span><br>=
<span>     if (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP || c-&g=
t;mode =3D=3D CM_CHILD_TCP)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        link_socket_init_phase2(c);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        do_init_socket_2(c);</=
span><br><span> </span><br><span> </span><br><span>         /* Update dynam=
ic frame calculation as exact transport socket information</span><br><span>=
@@ -4843,7 +4895,8 @@</span><br><span> </span><br><span> void</span><br><sp=
an> inherit_context_child(struct context *dest,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                      const struct context *src)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
  const struct context *src,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                      struct link_socket *ls)</span><br><span> {</=
span><br><span>     CLEAR(*dest);</span><br><span> </span><br><span>@@ -485=
6,6 +4909,8 @@</span><br><span> </span><br><span>     /* c1 init */</span><=
br><span>     packet_id_persist_init(&amp;dest-&gt;c1.pid_persist);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;c1.link_socket=
s_num =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do_=
link_socket_addr_new(dest);</span><br><span> </span><br><span>     dest-&gt=
;c1.ks.key_type =3D src-&gt;c1.ks.key_type;</span><br><span>     /* inherit=
 SSL context */</span><br><span>@@ -4880,7 +4935,7 @@</span><br><span>     =
     * The CM_TOP context does the socket listen(),</span><br><span>       =
   * and the CM_CHILD_TCP context does the accept().</span><br><span>      =
    */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dest-&g=
t;c2.accept_from =3D src-&gt;c2.link_socket;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        dest-&gt;c2.accept_from =3D ls;</span><br>=
<span>     }</span><br><span> </span><br><span> #ifdef ENABLE_PLUGIN</span>=
<br><span>@@ -4904,18 +4959,26 @@</span><br><span>     /* UDP inherits some=
 extra things which TCP does not */</span><br><span>     if (dest-&gt;mode =
=3D=3D CM_CHILD_UDP)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ASSERT(!dest-&gt;c2.link_sockets);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         /*=
 inherit buffers */</span><br><span>         dest-&gt;c2.buffers =3D src-&g=
t;c2.buffers;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        /* inherit parent link_socket and tuntap */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        dest-&gt;c2.link_socket =3D=
 src-&gt;c2.link_socket;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        ALLOC_ARRAY_GC(dest-&gt;c2.link_sockets, struct link_socket *,=
 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
       &amp;dest-&gt;gc);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        ALLOC_OBJ_GC(dest-&gt;c2.link_socket_info, st=
ruct link_socket_info, &amp;dest-&gt;gc);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        *dest-&gt;c2.link_socket_info =3D src-&gt;c2.li=
nk_socket-&gt;info;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* inherit parent link_socket and tuntap */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        dest-&gt;c2.link_sockets[0] =3D l=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_ARRAY_GC(dest-&gt;c2.l=
ink_socket_infos, struct link_socket_info *, 1,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                       &amp;dest-&gt;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_GC(dest=
-&gt;c2.link_socket_infos[0], struct link_socket_info,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     &amp;dest-&gt;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *dest-&gt;c2=
.link_socket_infos[0] =3D ls-&gt;info;</span><br><span> </span><br><span>  =
       /* locally override some link_socket_info fields */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        dest-&gt;c2.link_socket_info-&=
gt;lsa =3D &amp;dest-&gt;c1.link_socket_addr;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        dest-&gt;c2.link_socket_info-&gt;connection=
_established =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        dest-&gt;c2.link_socket_infos[0]-&gt;lsa =3D &amp;dest-&gt;c1.l=
ink_socket_addrs[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        dest-&gt;c2.link_socket_infos[0]-&gt;connection_established =3D fa=
lse;</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/init.h b/src/openvpn/init.h</span><br><span>=
index ea7eb30..11c32ac 100644</span><br><span>--- a/src/openvpn/init.h</spa=
n><br><span>+++ b/src/openvpn/init.h</span><br><span>@@ -95,7 +95,8 @@</spa=
n><br><span> bool do_deferred_options(struct context *c, const unsigned int=
 found);</span><br><span> </span><br><span> void inherit_context_child(stru=
ct context *dest,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                       const struct context *src);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                           const struct cont=
ext *src,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                 struct link_socket *ls);</span><br><span> </span><br><span=
> void inherit_context_top(struct context *dest,</span><br><span>          =
                const struct context *src);</span><br><span>diff --git a/sr=
c/openvpn/mss.c b/src/openvpn/mss.c</span><br><span>index ebdec25..89dee7d =
100644</span><br><span>--- a/src/openvpn/mss.c</span><br><span>+++ b/src/op=
envpn/mss.c</span><br><span>@@ -357,7 +357,7 @@</span><br><span>     struct=
 link_socket_info *lsi =3D get_link_socket_info(c);</span><br><span>     st=
ruct options *o =3D &amp;c-&gt;options;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int pmtu =3D c-&gt;c2.link_socket-&=
gt;mtu;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int pmtu=
 =3D c-&gt;c2.link_sockets[0]-&gt;mtu;</span><br><span>     sa_family_t af =
=3D lsi-&gt;lsa-&gt;actual.dest.addr.sa.sa_family;</span><br><span>     int=
 proto =3D lsi-&gt;proto;</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index a2841f0..b5bbf1=
3 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src=
/openvpn/mtcp.c</span><br><span>@@ -114,13 +114,13 @@</span><br><span> #end=
if /* ENABLE_DEBUG */</span><br><span> </span><br><span> static struct mult=
i_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_cre=
ate_instance_tcp(struct multi_context *m)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+multi_create_instance_tcp(struct multi_context *m, st=
ruct link_socket *ls)</span><br><span> {</span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span>     struct multi_instance *mi =3D NULL=
;</span><br><span>     struct hash *hash =3D m-&gt;hash;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi =3D multi_creat=
e_instance(m, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mi =3D multi_create_instance(m, NULL, ls);</span><br><span>     if (mi=
)</span><br><span>     {</span><br><span>         struct hash_element *he;<=
/span><br><span>@@ -170,13 +170,16 @@</span><br><span>     /* buffer for qu=
eued TCP socket output packets */</span><br><span>     mi-&gt;tcp_link_out_=
deferred =3D mbuf_init(m-&gt;top.options.n_bcast_buf);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;contex=
t.c2.link_socket);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 ASSERT(mi-&gt;context.c2.link_socket-&gt;info.lsa);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;context.c2.link_socket-&g=
t;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ASSERT(mi-&gt;context.c2.link_socket-&gt;info.lsa-&gt=
;actual.dest.addr.sa.sa_family =3D=3D AF_INET</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-           || mi-&gt;context.c2.link_socket-&gt;inf=
o.lsa-&gt;actual.dest.addr.sa.sa_family =3D=3D AF_INET6</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context.c2.link_socke=
ts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&=
gt;context.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ASSERT(mi-&gt;context.c2.link_sockets[0]-&gt;info.lsa);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;conte=
xt.c2.link_sockets[0]-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context.c2.li=
nk_sockets[0]-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =3D=3D AF_INET=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           || mi-&g=
t;context.c2.link_sockets[0]-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family=
 =3D=3D AF_INET6</span><br><span>            );</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (!mroute_extract_openvpn_sockaddr(&amp;mi-=
&gt;real, &amp;mi-&gt;context.c2.link_socket-&gt;info.lsa-&gt;actual.dest, =
true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mrou=
te_extract_openvpn_sockaddr(&amp;mi-&gt;real,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                         &amp;mi-=
&gt;context.c2.link_sockets[0]-&gt;info.lsa-&gt;actual.dest,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
       true))</span><br><span>     {</span><br><span>         msg(D_MULTI_E=
RRORS, &quot;MULTI TCP: TCP client address is undefined&quot;);</span><br><=
span>         return false;</span><br><span>@@ -232,7 +235,7 @@</span><br><=
span> void</span><br><span> multi_tcp_dereference_instance(struct multi_tcp=
 *mtcp, struct multi_instance *mi)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct link_socket *ls =3D mi-&gt;conte=
xt.c2.link_socket;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct link_socket *ls =3D mi-&gt;context.c2.link_sockets[0];</span><br>=
<span>     if (ls &amp;&amp; mi-&gt;socket_set_called)</span><br><span>    =
 {</span><br><span>         event_del(mtcp-&gt;es, socket_event_handle(ls))=
;</span><br><span>@@ -247,7 +250,7 @@</span><br><span>     if (mi)</span><b=
r><span>     {</span><br><span>         mi-&gt;socket_set_called =3D true;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket_set(mi-=
&gt;context.c2.link_socket,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        socket_set(mi-&gt;context.c2.link_sockets[0],</span><br><sp=
an>                    m-&gt;mtcp-&gt;es,</span><br><span>                 =
   mbuf_defined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</=
span><br><span>                    &amp;mi-&gt;ev_arg,</span><br><span>@@ -=
261,8 +264,12 @@</span><br><span> {</span><br><span>     int status;</span>=
<br><span>     unsigned int *persistent =3D &amp;mtcp-&gt;tun_rwflags;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    socket_set_listen_pers=
istent(c-&gt;c2.link_socket, mtcp-&gt;es,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                 &amp;c-&gt;c2.link_soc=
ket-&gt;ev_arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; =
i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        socket_set_listen_persistent(c-&gt;c2.link_sockets[i], mtcp-&g=
t;es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                       &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span=
><br><span> #ifdef _WIN32</span><br><span>     if (tuntap_is_wintun(c-&gt;c=
1.tuntap))</span><br><span>@@ -480,16 +487,18 @@</span><br><span>         c=
ase TA_SOCKET_READ:</span><br><span>         case TA_SOCKET_READ_RESIDUAL:<=
/span><br><span>             ASSERT(mi);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            ASSERT(mi-&gt;context.c2.link_socket);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(mi-&gt=
;context.c2.link_sockets);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            ASSERT(mi-&gt;context.c2.link_sockets[0]);</span><br><sp=
an>             set_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            read_incoming_link(&amp;mi-&gt;context, mi-&gt;contex=
t.c2.link_socket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           read_incoming_link(&amp;mi-&gt;context, mi-&gt;context.c2.link_s=
ockets[0]);</span><br><span>             clear_prefix();</span><br><span>  =
           if (!IS_SIG(&amp;mi-&gt;context))</span><br><span>             {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                multi=
_process_incoming_link(m, mi, mpp_flags);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                multi_process_incoming_link(m, mi, mp=
p_flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                                 mi-&gt;context.c2.link_sockets[0]);</span>=
<br><span>                 if (!IS_SIG(&amp;mi-&gt;context))</span><br><spa=
n>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   stream_buf_read_setup(mi-&gt;context.c2.link_socket);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    st=
ream_buf_read_setup(mi-&gt;context.c2.link_sockets[0]);</span><br><span>   =
              }</span><br><span>             }</span><br><span>            =
 break;</span><br><span>@@ -565,7 +574,7 @@</span><br><span>             br=
eak;</span><br><span> </span><br><span>         case MTP_NONE:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (mi &amp;&amp; sock=
et_read_residual(c-&gt;c2.link_socket))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (mi &amp;&amp; sockets_read_residual(c))=
</span><br><span>             {</span><br><span>                 newaction =
=3D TA_SOCKET_READ_RESIDUAL;</span><br><span>             }</span><br><span=
>@@ -720,9 +729,14 @@</span><br><span> </span><br><span>                 /*=
 new incoming TCP client attempting to connect? */</span><br><span>        =
         case EVENT_ARG_LINK_SOCKET:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    ASSERT(m-&gt;top.c2.link_socket);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    socket_r=
eset_listen_persistent(m-&gt;top.c2.link_socket);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    mi =3D multi_create_instanc=
e_tcp(m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          if (!ev_arg-&gt;u.sock)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        msg(D_MULTI_ERRORS, &quot;MULTI: mt=
cp_proc_io: null socket&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        break;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    socket_reset_listen_persistent(ev_arg-&gt;u.sock)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  mi =3D multi_create_instance_tcp(m, ev_arg-&gt;u.sock);</span><br><span> =
                    if (mi)</span><br><span>                     {</span><b=
r><span>                         multi_tcp_action(m, mi, TA_INITIAL, false)=
;</span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</spa=
n><br><span>index 5fbd7b0..9e915b2 100644</span><br><span>--- a/src/openvpn=
/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -185,7 =
+185,8 @@</span><br><span>  */</span><br><span> </span><br><span> struct mu=
lti_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_g=
et_create_instance_udp(struct multi_context *m, bool *floated)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+multi_get_create_instance_udp(st=
ruct multi_context *m, bool *floated,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                              struct link_socket *ls)</sp=
an><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span=
><br><span>     struct mroute_addr real =3D {0};</span><br><span>@@ -256,7 =
+257,7 @@</span><br><span>                      * connect-freq but not agai=
nst connect-freq-initial */</span><br><span>                     reflect_fi=
lter_rate_limit_decrease(m-&gt;initial_rate_limiter);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mi =
=3D multi_create_instance(m, &amp;real);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    mi =3D multi_create_instance(m, &a=
mp;real, ls);</span><br><span>                     if (mi)</span><br><span>=
                     {</span><br><span>                         hash_add_fa=
st(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span>@@ -317,7 +318,=
7 @@</span><br><span>         msg_set_prefix(&quot;Connection Attempt&quot;=
);</span><br><span>         m-&gt;top.c2.to_link =3D m-&gt;hmac_reply;</spa=
n><br><span>         m-&gt;top.c2.to_link_addr =3D m-&gt;hmac_reply_dest;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        process_outgoin=
g_link(&amp;m-&gt;top, m-&gt;top.c2.link_socket);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        process_outgoing_link(&amp;m-&gt;top,=
 m-&gt;top.c2.link_sockets[0]);</span><br><span>         m-&gt;hmac_reply_d=
est =3D NULL;</span><br><span>     }</span><br><span> }</span><br><span>@@ =
-380,10 +381,19 @@</span><br><span>     /* Incoming data on UDP port */</sp=
an><br><span>     else if (status &amp; SOCKET_READ)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        read_incoming=
_link(&amp;m-&gt;top, m-&gt;top.c2.link_socket);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (!IS_SIG(&amp;m-&gt;top))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt=
; m-&gt;top.c1.link_sockets_num; i++)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            multi_process_incomi=
ng_link(m, NULL, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (!m-&gt;top.c2.link_sockets[i]-&gt;ev_arg.pending)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                continue;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            read_incoming_link(&amp;m-&gt;top=
, m-&gt;top.c2.link_sockets[i]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (!IS_SIG(&amp;m-&gt;top))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                multi_process_incoming_link(m, =
NULL, mpp_flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                         m-&gt;top.c2.link_sockets[i]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span>         }</span><br><span>     }</span><br><span>     /* Incoming d=
ata on TUN device */</span><br><span>diff --git a/src/openvpn/mudp.h b/src/=
openvpn/mudp.h</span><br><span>index 14e90d0..b378754 100644</span><br><spa=
n>--- a/src/openvpn/mudp.h</span><br><span>+++ b/src/openvpn/mudp.h</span><=
br><span>@@ -55,12 +55,14 @@</span><br><span>  * it.  If no entry exists, t=
his function handles its creation, and if</span><br><span>  * successful, r=
eturns the newly created instance.</span><br><span>  *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * @param m            - The single multi_=
context structure.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param m           - The single multi_context structure.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param ls          - Listening so=
cket where this instance is connecting to</span><br><span>  *</span><br><sp=
an>  * @return A pointer to a multi_instance if one already existed for the=
</span><br><span>  *     packet&#39;s source address or if one was a newly =
created successfully.</span><br><span>  *      NULL if one did not yet exis=
t and a new one was not created.</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-struct multi_instance *multi_get_create_ins=
tance_udp(struct multi_context *m, bool *floated);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+struct multi_instance *multi_get_create_inst=
ance_udp(struct multi_context *m, bool *floated,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                              =
       struct link_socket *ls);</span><br><span> </span><br><span> #endif /=
* ifndef MUDP_H */</span><br><span>diff --git a/src/openvpn/multi.c b/src/o=
penvpn/multi.c</span><br><span>index 45b3cfa..d9e6b1f 100644</span><br><spa=
n>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span=
><br><span>@@ -750,7 +750,8 @@</span><br><span>  * Create a client instance=
 object for a newly connected client.</span><br><span>  */</span><br><span>=
 struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-multi_create_instance(struct multi_context *m, const struct mroute_addr =
*real)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_create_=
instance(struct multi_context *m, const struct mroute_addr *real,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                      struct =
link_socket *ls)</span><br><span> {</span><br><span>     struct gc_arena gc=
 =3D gc_new();</span><br><span>     struct multi_instance *mi;</span><br><s=
pan>@@ -773,7 +774,7 @@</span><br><span>         generate_prefix(mi);</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    inherit_context_child(&amp;mi-&gt;context, &amp;m-&gt;top=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inherit_conte=
xt_child(&amp;mi-&gt;context, &amp;m-&gt;top, ls);</span><br><span>     if =
(IS_SIG(&amp;mi-&gt;context))</span><br><span>     {</span><br><span>      =
   goto err;</span><br><span>@@ -3124,7 +3125,8 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-multi_process_float(struct multi_context *m, struct multi_inst=
ance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_proc=
ess_float(struct multi_context *m, struct multi_instance *mi,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    struct link_s=
ocket *ls)</span><br><span> {</span><br><span>     struct mroute_addr real =
=3D {0};</span><br><span>     struct hash *hash =3D m-&gt;hash;</span><br><=
span>@@ -3180,8 +3182,8 @@</span><br><span>     mi-&gt;context.c2.to_link_a=
ddr =3D &amp;mi-&gt;context.c2.from;</span><br><span> </span><br><span>    =
 /* inherit parent link_socket and link_socket_info */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.link_socket =3D m-&g=
t;top.c2.link_socket;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    mi-&gt;context.c2.link_socket_info-&gt;lsa-&gt;actual =3D m-&gt;top.c2.=
from;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;con=
text.c2.link_sockets[0] =3D ls;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    mi-&gt;context.c2.link_socket_infos[0]-&gt;lsa-&gt;actual =
=3D m-&gt;top.c2.from;</span><br><span> </span><br><span>     tls_update_re=
mote_addr(mi-&gt;context.c2.tls_multi, &amp;mi-&gt;context.c2.from);</span>=
<br><span> </span><br><span>@@ -3329,7 +3331,8 @@</span><br><span>  * i.e. =
client -&gt; server direction.</span><br><span>  */</span><br><span> bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_incoming_=
link(struct multi_context *m, struct multi_instance *instance, const unsign=
ed int mpp_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mu=
lti_process_incoming_link(struct multi_context *m, struct multi_instance *i=
nstance, const unsigned int mpp_flags,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                            struct link_socket *ls)</spa=
n><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span>=
<br><span> </span><br><span>@@ -3350,7 +3353,7 @@</span><br><span> #ifdef M=
ULTI_DEBUG_EVENT_LOOP</span><br><span>         printf(&quot;TCP/UDP -&gt; T=
UN [%d]\n&quot;, BLEN(&amp;m-&gt;top.c2.buf));</span><br><span> #endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_set_pending(=
m, multi_get_create_instance_udp(m, &amp;floated));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi_set_pending(m, multi_get_cr=
eate_instance_udp(m, &amp;floated, ls));</span><br><span>     }</span><br><=
span>     else</span><br><span>     {</span><br><span>@@ -3391,7 +3394,7 @@=
</span><br><span>                 /* nonzero length means that we have a va=
lid, decrypted packed */</span><br><span>                 if (floated &amp;=
&amp; c-&gt;c2.buf.len &gt; 0)</span><br><span>                 {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    multi_proce=
ss_float(m, m-&gt;pending);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    multi_process_float(m, m-&gt;pending, ls);</spa=
n><br><span>                 }</span><br><span> </span><br><span>          =
       process_incoming_link_part2(c, lsi, orig_buf);</span><br><span>@@ -3=
610,7 +3613,7 @@</span><br><span>                     }</span><br><span> </=
span><br><span>                     /* encrypt in instance context */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    process=
_incoming_tun(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  process_incoming_tun(c, c-&gt;c2.link_sockets[0]);</span>=
<br><span> </span><br><span>                     /* postprocess and set wak=
eup */</span><br><span>                     ret =3D multi_process_post(m, m=
-&gt;pending, mpp_flags);</span><br><span>@@ -3642,7 +3645,8 @@</span><br><=
span>         {</span><br><span>             pip_flags |=3D PIP_MSSFIX;</sp=
an><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        process_ip_header(&amp;item.instance-&gt;context, pip_flags, &amp=
;item.instance-&gt;context.c2.buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        process_ip_header(&amp;item.instance-&gt;context, p=
ip_flags, &amp;item.instance-&gt;context.c2.buf,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                          item.instance-&gt;co=
ntext.c2.link_sockets[0]);</span><br><span>         encrypt_sign(&amp;item.=
instance-&gt;context, true);</span><br><span>         mbuf_free_buf(item.bu=
ffer);</span><br><span> </span><br><span>diff --git a/src/openvpn/multi.h b=
/src/openvpn/multi.h</span><br><span>index f386a3b..a4cea79 100644</span><b=
r><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h=
</span><br><span>@@ -274,7 +274,8 @@</span><br><span> </span><br><span> voi=
d multi_top_free(struct multi_context *m);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-struct multi_instance *multi_create_=
instance(struct multi_context *m, const struct mroute_addr *real);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *multi=
_create_instance(struct multi_context *m, const struct mroute_addr *real,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                        struct link_socket *ls);</span><br><span> </span><b=
r><span> void multi_close_instance(struct multi_context *m, struct multi_in=
stance *mi, bool shutdown);</span><br><span> </span><br><span>@@ -288,7 +28=
9,8 @@</span><br><span>  * existing peer. Updates multi_instance with new a=
ddress,</span><br><span>  * updates hashtables in multi_context.</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_=
process_float(struct multi_context *m, struct multi_instance *mi);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void multi_process_float(str=
uct multi_context *m, struct multi_instance *mi,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                         struct link_socket *l=
s);</span><br><span> </span><br><span> #define MPP_PRE_SELECT             (=
1&lt;&lt;0)</span><br><span> #define MPP_CONDITIONAL_PRE_SELECT (1&lt;&lt;1=
)</span><br><span>@@ -353,8 +355,10 @@</span><br><span>  *                 =
      when using TCP transport. Otherwise NULL, as is</span><br><span>  *  =
                     the case when using UDP transport.</span><br><span>  *=
 @param mpp_flags    - Fast I/O optimization flags.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param ls           - Socket where the=
 packet was received.</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-bool multi_process_incoming_link(struct multi_context =
*m, struct multi_instance *instance, const unsigned int mpp_flags);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool multi_process_incoming=
_link(struct multi_context *m, struct multi_instance *instance, const unsig=
ned int mpp_flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                struct link_socket *ls);</span><br><span> <=
/span><br><span> </span><br><span> /**</span><br><span>@@ -668,7 +672,7 @@<=
/span><br><span> #endif</span><br><span>     set_prefix(mi);</span><br><spa=
n>     vlan_process_outgoing_tun(m, mi);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    process_outgoing_tun(&amp;mi-&gt;context);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_tun(&amp=
;mi-&gt;context, mi-&gt;context.c2.link_sockets[0]);</span><br><span>     r=
et =3D multi_process_post(m, mi, mpp_flags);</span><br><span>     clear_pre=
fix();</span><br><span>     return ret;</span><br><span>@@ -683,7 +687,7 @@=
</span><br><span> {</span><br><span>     bool ret =3D true;</span><br><span=
>     set_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    process_outgoing_link(&amp;mi-&gt;context, mi-&gt;context.c2.link_socke=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    process_outg=
oing_link(&amp;mi-&gt;context, mi-&gt;context.c2.link_sockets[0]);</span><b=
r><span>     ret =3D multi_process_post(m, mi, mpp_flags);</span><br><span>=
     clear_prefix();</span><br><span>     return ret;</span><br><span>diff =
--git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c</span><br><span>index=
 1db5422..bdbe126 100644</span><br><span>--- a/src/openvpn/openvpn.c</span>=
<br><span>+++ b/src/openvpn/openvpn.c</span><br><span>@@ -91,7 +91,7 @@</sp=
an><br><span>         }</span><br><span> </span><br><span>         /* proce=
ss the I/O which triggered select */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        process_io(c, c-&gt;c2.link_socket);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        process_io(c, c-&gt;c2.link=
_sockets[0]);</span><br><span>         P2P_CHECK_SIG();</span><br><span> </=
span><br><span>         perf_pop();</span><br><span>diff --git a/src/openvp=
n/openvpn.h b/src/openvpn/openvpn.h</span><br><span>index 8dfcab4..df43bba =
100644</span><br><span>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/sr=
c/openvpn/openvpn.h</span><br><span>@@ -154,7 +154,8 @@</span><br><span>  *=
/</span><br><span> struct context_1</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct link_socket_addr link_socket_ad=
dr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int link_soc=
kets_num;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 link_socket_addr *link_socket_addrs;</span><br><span>     /**&lt; Local an=
d remote addresses on the</span><br><span>      *   external network. */</s=
pan><br><span> </span><br><span>@@ -233,11 +234,11 @@</span><br><span>     =
/* bitmask for event status. Check event.h for possible values */</span><br=
><span>     unsigned int event_set_status;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct link_socket *link_socket;=
     /* socket used for TCP/UDP connection to remote */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct link_socket **link_sockets;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_sock=
et_info **link_socket_infos;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     bool link_socket_owned;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    /** This variable is=
 used instead link_socket-&gt;info for P2MP UDP childs */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct link_socket_info *link_socke=
t_info;</span><br><span>     const struct link_socket *accept_from; /* poss=
ibly do accept() on a parent link_socket */</span><br><span> </span><br><sp=
an>     struct link_socket_actual *to_link_addr;    /* IP address of remote=
 */</span><br><span>diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h</s=
pan><br><span>index 887172c..4a87895 100644</span><br><span>--- a/src/openv=
pn/ping.h</span><br><span>+++ b/src/openvpn/ping.h</span><br><span>@@ -63,7=
 +63,7 @@</span><br><span>         &amp;&amp; event_timeout_trigger(&amp;c-=
&gt;c2.ping_rec_interval,</span><br><span>                                 =
 &amp;c-&gt;c2.timeval,</span><br><span>                                  (=
!c-&gt;options.ping_timer_remote</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                  || link_socket_actual_defined(=
&amp;c-&gt;c1.link_socket_addr.actual))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                  || link_socket_actual=
_defined(&amp;c-&gt;c1.link_socket_addrs[0].actual))</span><br><span>      =
                            ? ETT_DEFAULT : 15))</span><br><span>     {</sp=
an><br><span>         trigger_ping_timeout_signal(c);</span><br><span>diff =
--git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index e=
fd742c..b7d80ee 100644</span><br><span>--- a/src/openvpn/socket.c</span><br=
><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -42,6 +42,21 @@</span>=
<br><span> </span><br><span> #include &quot;memdbg.h&quot;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+sockets_read_residual(const struc=
t context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; =
i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2.link_soc=
kets[i]-&gt;stream_buf.residual_fully_formed)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</s=
pan><br><span>  * Convert sockflags/getaddr_flags into getaddr_flags</span>=
<br><span>  */</span><br><span>@@ -1002,7 +1017,6 @@</span><br><span> creat=
e_socket_tcp(struct addrinfo *addrinfo)</span><br><span> {</span><br><span>=
     socket_descriptor_t sd;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     ASSERT(addrinfo);</span><br><span>     ASSERT(=
addrinfo-&gt;ai_socktype =3D=3D SOCK_STREAM);</span><br><span> </span><br><=
span>@@ -1034,7 +1048,6 @@</span><br><span> create_socket_udp(struct addrin=
fo *addrinfo, const unsigned int flags)</span><br><span> {</span><br><span>=
     socket_descriptor_t sd;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     ASSERT(addrinfo);</span><br><span>     ASSERT(=
addrinfo-&gt;ai_socktype =3D=3D SOCK_DGRAM);</span><br><span> </span><br><s=
pan>@@ -1444,7 +1457,6 @@</span><br><span> #ifdef TARGET_ANDROID</span><br>=
<span>     protect_fd_nonlocal(sd, remote);</span><br><span> #endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     set_non=
block(sd);</span><br><span>     status =3D connect(sd, remote, af_addr_size=
(remote-&gt;sa_family));</span><br><span>     if (status)</span><br><span>@=
@ -1837,112 +1849,111 @@</span><br><span> }</span><br><span> </span><br><sp=
an> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_i=
nit_phase1(struct context *c, int mode)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+link_socket_init_phase1(struct context *c,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        int sock=
_index,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            int mode)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct link_socket *sock =3D c-&gt;c2.link_socket;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct options *o =
=3D &amp;c-&gt;options;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ASSERT(sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(c-&gt;c2.link_sockets[sock_index]);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const char *remote_host =3D =
o-&gt;ce.remote;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
onst char *remote_port =3D o-&gt;ce.remote_port;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    sock-&gt;local_host =3D o-&gt;ce.local;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    sock-&gt;local_port =3D o-&gt;ce.local_port=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;remote_=
host =3D remote_host;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    sock-&gt;remote_port =3D remote_port;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    sock-&gt;dns_cache =3D c-&gt;c1.dns_cache;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;http_proxy =3D c-=
&gt;c1.http_proxy;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 sock-&gt;socks_proxy =3D c-&gt;c1.socks_proxy;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    sock-&gt;bind_local =3D o-&gt;ce.bind_local;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;resolve_r=
etry_seconds =3D o-&gt;resolve_retry_seconds;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    sock-&gt;mtu_discover_type =3D o-&gt;ce.mtu_dis=
cover_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&g=
t;c2.link_sockets[sock_index]-&gt;local_host =3D c-&gt;options.ce.local;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sock=
ets[sock_index]-&gt;local_port =3D c-&gt;options.ce.local_port;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets[sock_=
index]-&gt;remote_host =3D c-&gt;options.ce.remote;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets[sock_index]-&gt=
;remote_port =3D c-&gt;options.ce.remote_port;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets[sock_index]-&gt;dns_ca=
che =3D c-&gt;c1.dns_cache;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    c-&gt;c2.link_sockets[sock_index]-&gt;http_proxy =3D c-&gt;c1.h=
ttp_proxy;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt=
;c2.link_sockets[sock_index]-&gt;socks_proxy =3D c-&gt;c1.socks_proxy;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_socket=
s[sock_index]-&gt;bind_local =3D c-&gt;options.ce.bind_local;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets[sock_in=
dex]-&gt;resolve_retry_seconds =3D c-&gt;options.resolve_retry_seconds;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_socke=
ts[sock_index]-&gt;mtu_discover_type =3D c-&gt;options.ce.mtu_discover_type=
;</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;gremlin =3D o-&gt;gremlin;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_so=
ckets[sock_index]-&gt;gremlin =3D c-&gt;options.gremlin;</span><br><span> #=
endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    sock-&gt;socket_buffer_sizes.rcvbuf =3D o-&gt;rcvbuf;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;socket_buffer_sizes.sndb=
uf =3D o-&gt;sndbuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    c-&gt;c2.link_sockets[sock_index]-&gt;socket_buffer_sizes.rcvbuf =3D c=
-&gt;options.rcvbuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    c-&gt;c2.link_sockets[sock_index]-&gt;socket_buffer_sizes.sndbuf =3D c=
-&gt;options.sndbuf;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    sock-&gt;sockflags =3D o-&gt;sockflags;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets[sock_ind=
ex]-&gt;sockflags =3D c-&gt;options.sockflags;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> #if PORT_SHARE</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;port_share_host &amp;&a=
mp; o-&gt;port_share_port)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (c-&gt;options.port_share_host &amp;&amp; c-&gt;options.port_=
share_port)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        sock-&gt;sockflags |=3D SF_PORT_SHARE;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2.link_sockets[sock_=
index]-&gt;sockflags |=3D SF_PORT_SHARE;</span><br><span>     }</span><br><=
span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-=
&gt;mark =3D o-&gt;mark;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    sock-&gt;bind_dev =3D o-&gt;bind_dev;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.proto =3D o-&gt;=
ce.proto;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt=
;info.af =3D o-&gt;ce.af;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    sock-&gt;info.remote_float =3D o-&gt;ce.remote_float;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.lsa =3D &amp;c-&g=
t;c1.link_socket_addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    sock-&gt;info.bind_ipv6_only =3D o-&gt;ce.bind_ipv6_only;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.ipchange_command=
 =3D o-&gt;ipchange;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   sock-&gt;info.plugins =3D c-&gt;plugins;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    sock-&gt;server_poll_timeout =3D &amp;c-&gt;c2.se=
rver_poll_interval;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    c-&gt;c2.link_sockets[sock_index]-&gt;mark =3D c-&gt;options.mark;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock=
-&gt;mode =3D mode;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    c-&gt;c2.link_sockets[sock_index]-&gt;info.proto =3D c-&gt;options.ce.p=
roto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.l=
ink_sockets[sock_index]-&gt;info.af =3D c-&gt;options.ce.af;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets[sock_ind=
ex]-&gt;info.remote_float =3D c-&gt;options.ce.remote_float;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets[sock_ind=
ex]-&gt;info.lsa =3D &amp;c-&gt;c1.link_socket_addrs[sock_index];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets[soc=
k_index]-&gt;info.bind_ipv6_only =3D c-&gt;options.ce.bind_ipv6_only;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets=
[sock_index]-&gt;info.ipchange_command =3D c-&gt;options.ipchange;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets[so=
ck_index]-&gt;info.plugins =3D c-&gt;plugins;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    c-&gt;c2.link_sockets[sock_index]-&gt;server_=
poll_timeout =3D &amp;c-&gt;c2.server_poll_interval;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    c-&gt;c2.link_sockets[sock_index]-&gt;mode =3D mode;</sp=
an><br><span>     if (mode =3D=3D LS_MODE_TCP_ACCEPT_FROM)</span><br><span>=
     {</span><br><span>         ASSERT(c-&gt;c2.accept_from);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(sock-&gt;info.proto =
=3D=3D PROTO_TCP_SERVER);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        sock-&gt;sd =3D c-&gt;c2.accept_from-&gt;sd;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        ASSERT(c-&gt;c2.link_sockets[s=
ock_index]-&gt;info.proto =3D=3D PROTO_TCP_SERVER);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2.link_sockets[sock_index]=
-&gt;sd =3D c-&gt;c2.accept_from-&gt;sd;</span><br><span>         /* inheri=
t (possibly guessed) info AF from parent context */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;info.af =3D c-&gt;c2.accep=
t_from-&gt;info.af;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        c-&gt;c2.link_sockets[sock_index]-&gt;info.af =3D c-&gt;c2.accept_f=
rom-&gt;info.af;</span><br><span>     }</span><br><span> </span><br><span> =
    /* are we running in HTTP proxy mode? */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (sock-&gt;http_proxy)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.link_sockets[sock_index]=
-&gt;http_proxy)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        ASSERT(sock-&gt;info.proto =3D=3D PROTO_TCP_CLIEN=
T);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(c=
-&gt;c2.link_sockets[sock_index]-&gt;info.proto =3D=3D PROTO_TCP_CLIENT);</=
span><br><span> </span><br><span>         /* the proxy server */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;remote_host =3D=
 c-&gt;c1.http_proxy-&gt;options.server;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        sock-&gt;remote_port =3D c-&gt;c1.http_proxy-&gt=
;options.port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   c-&gt;c2.link_sockets[sock_index]-&gt;remote_host =3D c-&gt;c1.http_prox=
y-&gt;options.server;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        c-&gt;c2.link_sockets[sock_index]-&gt;remote_port =3D c-&gt;c1.ht=
tp_proxy-&gt;options.port;</span><br><span> </span><br><span>         /* th=
e OpenVPN server we will use the proxy to connect to */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;proxy_dest_host =3D remo=
te_host;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sock-=
&gt;proxy_dest_port =3D remote_port;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        c-&gt;c2.link_sockets[sock_index]-&gt;proxy_dest_h=
ost =3D c-&gt;options.ce.remote;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        c-&gt;c2.link_sockets[sock_index]-&gt;proxy_dest_port =
=3D c-&gt;options.ce.remote_port;</span><br><span>     }</span><br><span>  =
   /* or in Socks proxy mode? */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    else if (sock-&gt;socks_proxy)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (c-&gt;c2.link_sockets[sock_index]-&g=
t;socks_proxy)</span><br><span>     {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>         /* the proxy server */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;remote_host =
=3D c-&gt;c1.socks_proxy-&gt;server;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        sock-&gt;remote_port =3D c-&gt;c1.socks_proxy-&gt;po=
rt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=
.link_sockets[sock_index]-&gt;remote_host =3D c-&gt;c1.socks_proxy-&gt;serv=
er;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=
.link_sockets[sock_index]-&gt;remote_port =3D c-&gt;c1.socks_proxy-&gt;port=
;</span><br><span> </span><br><span>         /* the OpenVPN server we will =
use the proxy to connect to */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        sock-&gt;proxy_dest_host =3D remote_host;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;proxy_dest_port =3D r=
emote_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
c-&gt;c2.link_sockets[sock_index]-&gt;proxy_dest_host =3D c-&gt;options.ce.=
remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&g=
t;c2.link_sockets[sock_index]-&gt;proxy_dest_port =3D c-&gt;options.ce.remo=
te_port;</span><br><span>     }</span><br><span>     else</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt=
;remote_host =3D remote_host;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        sock-&gt;remote_port =3D remote_port;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2.link_sockets[sock_index]=
-&gt;remote_host =3D c-&gt;options.ce.remote;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        c-&gt;c2.link_sockets[sock_index]-&gt;rem=
ote_port =3D c-&gt;options.ce.remote_port;</span><br><span>     }</span><br=
><span> </span><br><span>     /* bind behavior for TCP server vs. client */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;info=
.proto =3D=3D PROTO_TCP_SERVER)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (c-&gt;c2.link_sockets[sock_index]-&gt;info.proto =3D=3D=
 PROTO_TCP_SERVER)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (sock-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FRO=
M)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt=
;c2.link_sockets[sock_index]-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM)</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            sock-&gt;bind_local =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            c-&gt;c2.link_sockets[sock_index]-&gt;bi=
nd_local =3D false;</span><br><span>         }</span><br><span>         els=
e</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            sock-&gt;bind_local =3D true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            c-&gt;c2.link_sockets[sock_index]-=
&gt;bind_local =3D true;</span><br><span>         }</span><br><span>     }<=
/span><br><span> </span><br><span>     if (mode !=3D LS_MODE_TCP_ACCEPT_FRO=
M)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (sock-&gt;bind_local)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (c-&gt;c2.link_sockets[sock_index]-&gt;bind_loc=
al)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            resolve_bind_local(sock, sock-&gt;info.af);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            resolve_bind_local=
(c-&gt;c2.link_sockets[sock_index], c-&gt;c2.link_sockets[sock_index]-&gt;i=
nfo.af);</span><br><span>         }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        resolve_remote(sock, 1, NULL, NULL);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        resolve_remote(c-&gt;c2.link=
_sockets[sock_index], 1, NULL, NULL);</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span>@@ -2172,22 +2183,21 @@</span><br><s=
pan> </span><br><span> /* finalize socket initialization */</span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_ini=
t_phase2(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+link_socket_init_phase2(struct context *c,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        struct link_socket *=
sock,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          const struct frame *frame,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        struct signal_info *sig_info)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct link_socket *sock =3D c-&gt;c2.link_socket;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const struct frame *frame =3D &amp;c-&gt;c2.f=
rame;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct signa=
l_info *sig_info =3D c-&gt;sig;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span>     const char *remote_dynamic =3D NULL;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct signal_info sig_s=
ave =3D {0};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 sig_save =3D 0;</span><br><span> </span><br><span>     ASSERT(sock);</span=
><br><span>     ASSERT(sig_info);</span><br><span> </span><br><span>     if=
 (sig_info-&gt;signal_received)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        sig_save =3D *sig_info;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        sig_save.signal_received=
 =3D signal_reset(sig_info, 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        sig_save =3D sig_info-&gt;signal_received;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        sig_info-&gt;signal_rece=
ived =3D 0;</span><br><span>     }</span><br><span> </span><br><span>     /=
* initialize buffers */</span><br><span>@@ -2209,7 +2219,7 @@</span><br><sp=
an>     /* If a valid remote has been found, create the socket with its add=
rinfo */</span><br><span>     if (sock-&gt;info.lsa-&gt;current_remote)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined (_WIN32)</span><br><span>         if (dco_enabled(&amp;c-&gt;opti=
ons))</span><br><span>         {</span><br><span>             create_socket=
_dco_win(c, sock, sig_info);</span><br><span>@@ -2220,7 +2230,6 @@</span><b=
r><span>         {</span><br><span>             create_socket(sock, sock-&g=
t;info.lsa-&gt;current_remote);</span><br><span>         }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     }</span><br><spa=
n> </span><br><span>     /* If socket has not already been created create i=
t now */</span><br><span>@@ -2239,7 +2248,6 @@</span><br><span>            =
         addr_family_name(sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family));=
</span><br><span>                 sock-&gt;info.af =3D sock-&gt;info.lsa-&g=
t;bind_local-&gt;ai_family;</span><br><span>             }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>             create_s=
ocket(sock, sock-&gt;info.lsa-&gt;bind_local);</span><br><span>         }</=
span><br><span>     }</span><br><span>@@ -2248,7 +2256,7 @@</span><br><span=
>     if (sock-&gt;sd =3D=3D SOCKET_UNDEFINED)</span><br><span>     {</span=
><br><span>         msg(M_WARN, &quot;Could not determine IPv4/IPv6 protoco=
l&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        regi=
ster_signal(sig_info, SIGUSR1, &quot;Could not determine IPv4/IPv6 protocol=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sig=
_info-&gt;signal_received =3D SIGUSR1;</span><br><span>         goto done;<=
/span><br><span>     }</span><br><span> </span><br><span>@@ -2259,7 +2267,8=
 @@</span><br><span> </span><br><span>     if (sock-&gt;info.proto =3D=3D P=
ROTO_TCP_SERVER)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        phase2_tcp_server(sock, remote_dynamic, sig_info)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        phase2_tcp=
_server(sock, remote_dynamic,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                          sig_info);</span><br><span>     }</span=
><br><span>     else if (sock-&gt;info.proto =3D=3D PROTO_TCP_CLIENT)</span=
><br><span>     {</span><br><span>@@ -2285,16 +2294,11 @@</span><br><span> =
    linksock_print_addr(sock);</span><br><span> </span><br><span> done:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sig_save.signal_r=
eceived)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sig=
_save)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        /* Always restore the saved signal -- register/throw_signal=
 will handle priority */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (sig_save.source =3D=3D SIG_SOURCE_HARD &amp;&amp; sig_info =
=3D=3D &amp;siginfo_static)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!sig_info-&gt;signal_received)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            throw_s=
ignal(sig_save.signal_received);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            register_s=
ignal(sig_info, sig_save.signal_received, sig_save.signal_text);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            sig_info-&gt;signa=
l_received =3D sig_save;</span><br><span>         }</span><br><span>     }<=
/span><br><span> }</span><br><span>diff --git a/src/openvpn/socket.h b/src/=
openvpn/socket.h</span><br><span>index 465d92b..13b51c3 100644</span><br><s=
pan>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/socket.h</=
span><br><span>@@ -344,9 +344,15 @@</span><br><span> /*</span><br><span>  *=
 Initialize link_socket object.</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void link_socket_init_phase1(struct context=
 *c, int mode);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_init_ph=
ase1(struct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        int sock_index,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        int mode);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void link_socket_ini=
t_phase2(struct context *c);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void link_socket_init_phase2(struct context *c,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                             struct li=
nk_socket *sock,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                          const struct frame *frame,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                             struct signa=
l_info *sig_info);</span><br><span> </span><br><span> void do_preresolve(st=
ruct context *c);</span><br><span> </span><br><span>@@ -1228,11 +1234,12 @@=
</span><br><span>  * Socket I/O wait functions</span><br><span>  */</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inli=
ne bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_read_re=
sidual(const struct link_socket *sock)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return sock &amp;&amp; sock-&gt;stream_buf.residual_fully_formed;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Extends the pre-existing read residual logic</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * to all initialized sockets, ensuri=
ng the complete</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * p=
acket is read.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool sockets_read_res=
idual(const struct context *c);</span><br><span> </span><br><span> static i=
nline event_t</span><br><span> socket_event_handle(const struct link_socket=
 *sock)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail">change 434</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/434?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e3=
1afeec5df6084 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 434 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@...1664...=
26...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--RKzxyuoISIg=--

