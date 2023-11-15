From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 13:45:10 +0000
References: <gerrit.1700055887000.Ia0a889e800f0b36aed770ee36e31afeec5df6084@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3772879ca9877fe0c4e8b08504c1cf51fcd03ee3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GqDOsDN9DE8="; charset=UTF-8
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

--GqDOsDN9DE8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail

to review the following change.


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
M src/openvpn/ovpn_dco_win.h
M src/openvpn/ping.h
M src/openvpn/socket.c
M src/openvpn/socket.h
18 files changed, 458 insertions(+), 231 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/434/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index cd3e0ad..6f6d7f0 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -460,7 +460,7 @@
         return 0;
     }

-    struct link_socket *ls =3D c->c2.link_socket;
+    struct link_socket *ls =3D c->c2.link_sockets[0];

     ASSERT(ls->info.connection_established);

@@ -476,7 +476,7 @@
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
@@ -509,12 +509,12 @@
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
@@ -559,7 +559,7 @@
     int peer_id =3D c->c2.tls_multi->peer_id;
     struct sockaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
-    int sd =3D c->c2.link_socket->sd;
+    int sd =3D c->c2.link_sockets[0]->sd;


     if (c->mode =3D=3D CM_CHILD_TCP)
@@ -569,8 +569,8 @@
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
index f04318f..3c11b9a 100644
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
         struct link_socket *ls; /* if type =3D EVENT_ARG_LINK_SOCKET */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 9700c6c..9a6dcd8 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -57,12 +57,18 @@
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

@@ -98,7 +104,7 @@
 {
     if (c->c2.tls_multi && c->c2.tls_exit_signal)
     {
-        if (link_socket_connection_oriented(c->c2.link_socket))
+        if (link_socket_connection_oriented(c->c2.link_sockets[0]))
         {
             if (c->c2.tls_multi->n_soft_errors)
             {
@@ -551,6 +557,7 @@
 #ifdef ENABLE_FRAGMENT
 /*
  * Should we deliver a datagram fragment to remote?
+ * c is expected to be a single-link context (p2p or child)
  */
 static void
 check_fragment(struct context *c)
@@ -1107,7 +1114,9 @@
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
@@ -1429,7 +1438,7 @@
  */

 void
-process_incoming_tun(struct context *c)
+process_incoming_tun(struct context *c, struct link_socket *out_ls)
 {
     struct gc_arena gc =3D gc_new();

@@ -1462,7 +1471,8 @@
          */
         unsigned int flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_N=
AT
                              | PIPV6_IMCP_NOHOST_CLIENT;
-        process_ip_header(c, flags, &c->c2.buf);
+        process_ip_header(c, flags, &c->c2.buf,
+                          out_ls);

 #ifdef PACKET_TRUNCATION_CHECK
         /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
@@ -1623,7 +1633,8 @@
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
@@ -1669,7 +1680,7 @@
                 /* extract TOS from IP header */
                 if (flags & PIPV4_PASSTOS)
                 {
-                    link_socket_extract_tos(c->c2.link_socket, &ipbuf);
+                    link_socket_extract_tos(ls, &ipbuf);
                 }
 #endif

@@ -1878,7 +1889,7 @@
  */

 void
-process_outgoing_tun(struct context *c)
+process_outgoing_tun(struct context *c, struct link_socket *in_ls)
 {
     /*
      * Set up for write() call to TUN/TAP
@@ -1895,9 +1906,8 @@
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
@@ -2059,6 +2069,7 @@
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     static int dco_shift =3D DCO_SHIFT;    /* Event from DCO linux kernel =
module */
 #endif
+    int i;

     /*
      * Decide what kind of events we want to wait for.
@@ -2164,8 +2175,11 @@
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
@@ -2203,7 +2217,7 @@

     if (!c->sig->signal_received)
     {
-        if (!(flags & IOW_CHECK_RESIDUAL) || !socket_read_residual(c->c2.l=
ink_socket))
+        if (!(flags & IOW_CHECK_RESIDUAL) || !sockets_read_residual(c))
         {
             int status;

@@ -2242,6 +2256,9 @@
                         }

                         shift =3D socket_shift;
+                        /* mark socket so that the multi code knows where =
we
+                         * have pending i/o */
+                        ev_arg->pending =3D true;
                     }
                     else
                     {
@@ -2295,7 +2312,7 @@
     /* TUN device ready to accept write */
     else if (status & TUN_WRITE)
     {
-        process_outgoing_tun(c);
+        process_outgoing_tun(c, ls);
     }
     /* Incoming data on TCP/UDP port */
     else if (status & SOCKET_READ)
@@ -2312,7 +2329,7 @@
         read_incoming_tun(c);
         if (!IS_SIG(c))
         {
-            process_incoming_tun(c);
+            process_incoming_tun(c, ls);
         }
     }
     else if (status & DCO_READ)
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index fdc9f0e..333dcdc 100644
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
@@ -303,20 +306,21 @@
 #define PIPV6_IMCP_NOHOST_CLIENT        (1<<5)
 #define PIPV6_IMCP_NOHOST_SERVER        (1<<6)

-void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf);
+void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf,
+                       struct link_socket *ls);

 void schedule_exit(struct context *c, const int n_seconds, const int signa=
l);

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
index 8c707a4..f8dd01f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -533,12 +533,11 @@
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
@@ -554,20 +553,20 @@
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
@@ -730,6 +729,13 @@
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
@@ -739,6 +745,10 @@

     init_connection_list(c);

+    c->c1.link_sockets_num =3D 1;
+
+    do_link_socket_addr_new(c);
+
 #if defined(ENABLE_PKCS11)
     if (c->first_time)
     {
@@ -1667,7 +1677,7 @@
         CLEAR(local);
         actual =3D &get_link_socket_info(c)->lsa->actual;
         remote =3D actual->dest;
-        getsockname(c->c2.link_socket->sd, &local.addr.sa, &sa_len);
+        getsockname(c->c2.link_sockets[0]->sd, &local.addr.sa, &sa_len);
 #if ENABLE_IP_PKTINFO
         if (!addr_defined(&local))
         {
@@ -1781,8 +1791,8 @@
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
@@ -1856,17 +1866,16 @@
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
@@ -1879,8 +1888,7 @@
                                                  c->options.dev_type,
                                                  c->options.dev_node,
                                                  &gc);
-            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es,
-                        &c->net_ctx);
+            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es=
, &c->net_ctx);
         }

         /* possibly add routes */
@@ -1895,6 +1903,7 @@
         /* Store the old fd inside the fd so open_tun can use it */
         c->c1.tuntap->fd =3D oldtunfd;
 #endif
+
         if (dco_enabled(&c->options))
         {
             ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
@@ -1907,16 +1916,14 @@
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
         if (!c->options.ifconfig_noexec
             && ifconfig_order() =3D=3D IFCONFIG_AFTER_TUN_OPEN)
         {
-            do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
-                        c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
+            do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name, c->c2.fra=
me.tun_mtu, c->c2.es, &c->net_ctx);
         }

         /* run the up script */
@@ -2427,7 +2434,7 @@
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
@@ -2657,14 +2664,28 @@

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
@@ -3747,12 +3768,103 @@
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
+        link_socket_init_phase2(c, c->c2.link_sockets[i]);
+    }
+}
+
+/*
  * Print MTU INFO
  */
 static void
@@ -3907,15 +4019,20 @@
     /* in dco-win case, link socket is a tun handle which is
      * closed in do_close_tun(). Set it to UNDEFINED so
      * we won't use WinSock API to close it. */
-    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_socket)
+    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_sockets && c->c2.lin=
k_sockets[0])
     {
-        c->c2.link_socket->sd =3D SOCKET_UNDEFINED;
+        c->c2.link_sockets[0]->sd =3D SOCKET_UNDEFINED;
     }

-    if (c->c2.link_socket && c->c2.link_socket_owned)
+    if (c->c2.link_sockets && c->c2.link_socket_owned)
     {
-        link_socket_close(c->c2.link_socket);
-        c->c2.link_socket =3D NULL;
+        int i;
+
+        for (i =3D 0; i < c->c1.link_sockets_num; i++)
+        {
+            link_socket_close(c->c2.link_sockets[i]);
+        }
+        c->c2.link_sockets =3D NULL;
     }


@@ -3926,28 +4043,33 @@
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

@@ -4430,7 +4552,6 @@
 {
     const struct options *options =3D &c->options;
     const bool child =3D (c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=3D CM=
_CHILD_UDP);
-    int link_socket_mode =3D LS_MODE_DEFAULT;

     /* init garbage collection level */
     gc_init(&c->c2.gc);
@@ -4471,21 +4592,6 @@
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
@@ -4628,7 +4734,7 @@
     /* bind the TCP/UDP socket */
     if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP || c->mode =3D=3D C=
M_CHILD_TCP)
     {
-        link_socket_init_phase1(c, link_socket_mode);
+        do_init_socket_1(c);
     }

     /* initialize tun/tap device object,
@@ -4671,7 +4777,7 @@
     /* finalize the TCP/UDP socket */
     if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP || c->mode =3D=3D C=
M_CHILD_TCP)
     {
-        link_socket_init_phase2(c);
+        do_init_socket_2(c);


         /* Update dynamic frame calculation as exact transport socket info=
rmation
@@ -4807,7 +4913,8 @@

 void
 inherit_context_child(struct context *dest,
-                      const struct context *src)
+                      const struct context *src,
+                      struct link_socket *ls)
 {
     CLEAR(*dest);

@@ -4820,6 +4927,8 @@

     /* c1 init */
     packet_id_persist_init(&dest->c1.pid_persist);
+    dest->c1.link_sockets_num =3D 1;
+    do_link_socket_addr_new(dest);

     dest->c1.ks.key_type =3D src->c1.ks.key_type;
     /* inherit SSL context */
@@ -4844,7 +4953,7 @@
          * The CM_TOP context does the socket listen(),
          * and the CM_CHILD_TCP context does the accept().
          */
-        dest->c2.accept_from =3D src->c2.link_socket;
+        dest->c2.accept_from =3D ls;
     }

 #ifdef ENABLE_PLUGIN
@@ -4868,18 +4977,26 @@
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
index 7731f5a..85de096 100644
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
index 1566c64..9b6360f 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -357,7 +357,7 @@
     struct link_socket_info *lsi =3D get_link_socket_info(c);
     struct options *o =3D &c->options;
=20
-    int pmtu =3D c->c2.link_socket->mtu;
+    int pmtu =3D c->c2.link_sockets[0]->mtu;
     sa_family_t af =3D lsi->lsa->actual.dest.addr.sa.sa_family;
     int proto =3D lsi->proto;

diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 3772acf..06073cd 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -115,13 +115,13 @@
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
@@ -171,13 +171,16 @@
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
@@ -233,7 +236,7 @@
 void
 multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instan=
ce *mi)
 {
-    struct link_socket *ls =3D mi->context.c2.link_socket;
+    struct link_socket *ls =3D mi->context.c2.link_sockets[0];
     if (ls && mi->socket_set_called)
     {
         event_del(mtcp->es, socket_event_handle(ls));
@@ -248,7 +251,7 @@
     if (mi)
     {
         mi->socket_set_called =3D true;
-        socket_set(mi->context.c2.link_socket,
+        socket_set(mi->context.c2.link_sockets[0],
                    m->mtcp->es,
                    mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
                    &mi->ev_arg,
@@ -260,10 +263,14 @@
 multi_tcp_wait(const struct context *c,
                struct multi_tcp *mtcp)
 {
-    int status;
+    int i, status;
     unsigned int *persistent =3D &mtcp->tun_rwflags;
-    socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
-                                 &c->c2.link_socket->ev_arg);
+
+    for (i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        socket_set_listen_persistent(c->c2.link_sockets[i], mtcp->es,
+                                     &c->c2.link_sockets[i]->ev_arg);
+    }

 #ifdef _WIN32
     if (tuntap_is_wintun(c->c1.tuntap))
@@ -481,16 +488,18 @@
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
@@ -566,7 +575,7 @@
             break;

         case MTP_NONE:
-            if (mi && socket_read_residual(c->c2.link_socket))
+            if (mi && sockets_read_residual(c))
             {
                 newaction =3D TA_SOCKET_READ_RESIDUAL;
             }
@@ -721,9 +730,14 @@

                 /* new incoming TCP client attempting to connect? */
                 case EVENT_ARG_LINK_SOCKET:
-                    ASSERT(m->top.c2.link_socket);
-                    socket_reset_listen_persistent(m->top.c2.link_socket);
-                    mi =3D multi_create_instance_tcp(m);
+                    if (!ev_arg->u.ls)
+                    {
+                        msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null soc=
ket");
+                        break;
+                    }
+
+                    socket_reset_listen_persistent(ev_arg->u.ls);
+                    mi =3D multi_create_instance_tcp(m, ev_arg->u.ls);
                     if (mi)
                     {
                         multi_tcp_action(m, mi, TA_INITIAL, false);
@@ -757,9 +771,9 @@
             else if (e->arg =3D=3D MTCP_SOCKET)
             {
                 struct multi_instance *mi;
-                ASSERT(m->top.c2.link_socket);
-                socket_reset_listen_persistent(m->top.c2.link_socket);
-                mi =3D multi_create_instance_tcp(m);
+                ASSERT(m->top.c2.link_sockets[0]);
+                socket_reset_listen_persistent(m->top.c2.link_sockets[0]);
+                mi =3D multi_create_instance_tcp(m, m->top.c2.link_sockets=
[0]);
                 if (mi)
                 {
                     multi_tcp_action(m, mi, TA_INITIAL, false);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 5bd7354..dd45720 100644
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
     struct mroute_addr real;
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
-        process_outgoing_link(&m->top, &m->top.c2.link_socket[0]);
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
index 8383c64..1088246 100644
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
index af04dc8..e9a3945 100644
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
@@ -3128,7 +3133,8 @@
 }

 void
-multi_process_float(struct multi_context *m, struct multi_instance *mi)
+multi_process_float(struct multi_context *m, struct multi_instance *mi,
+                    struct link_socket *ls)
 {
     struct mroute_addr real;
     struct hash *hash =3D m->hash;
@@ -3184,8 +3190,8 @@
     mi->context.c2.to_link_addr =3D &mi->context.c2.from;

     /* inherit parent link_socket and link_socket_info */
-    mi->context.c2.link_socket =3D m->top.c2.link_socket;
-    mi->context.c2.link_socket_info->lsa->actual =3D m->top.c2.from;
+    mi->context.c2.link_sockets[0] =3D ls;
+    mi->context.c2.link_socket_infos[0]->lsa->actual =3D m->top.c2.from;

     tls_update_remote_addr(mi->context.c2.tls_multi, &mi->context.c2.from);

@@ -3333,7 +3339,8 @@
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

@@ -3354,7 +3361,7 @@
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TCP/UDP -> TUN [%d]\n", BLEN(&m->top.c2.buf));
 #endif
-        multi_set_pending(m, multi_get_create_instance_udp(m, &floated));
+        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, ls=
));
     }
     else
     {
@@ -3395,7 +3402,7 @@
                 /* nonzero length means that we have a valid, decrypted pa=
cked */
                 if (floated && c->c2.buf.len > 0)
                 {
-                    multi_process_float(m, m->pending);
+                    multi_process_float(m, m->pending, ls);
                 }

                 process_incoming_link_part2(c, lsi, orig_buf);
@@ -3614,7 +3621,7 @@
                     }

                     /* encrypt in instance context */
-                    process_incoming_tun(c);
+                    process_incoming_tun(c, c->c2.link_sockets[0]);

                     /* postprocess and set wakeup */
                     ret =3D multi_process_post(m, m->pending, mpp_flags);
@@ -3646,7 +3653,8 @@
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
index a736809..0d4ec63 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -125,6 +125,7 @@
     in_addr_t reporting_addr;     /* IP address shown in status listing */
     struct in6_addr reporting_addr_ipv6; /* IPv6 address in status listing=
 */

+    bool did_open_context;
     bool did_real_hash;
     bool did_iter;
 #ifdef ENABLE_MANAGEMENT
@@ -269,7 +270,8 @@

 void multi_top_free(struct multi_context *m);

-struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real);
+struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real,
+                                             struct link_socket *ls);

 void multi_close_instance(struct multi_context *m, struct multi_instance *=
mi, bool shutdown);

@@ -283,7 +285,8 @@
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
@@ -348,8 +351,10 @@
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
@@ -663,7 +668,7 @@
 #endif
     set_prefix(mi);
     vlan_process_outgoing_tun(m, mi);
-    process_outgoing_tun(&mi->context);
+    process_outgoing_tun(&mi->context, mi->context.c2.link_sockets[0]);
     ret =3D multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
@@ -678,7 +683,7 @@
 {
     bool ret =3D true;
     set_prefix(mi);
-    process_outgoing_link(&mi->context, mi->context.c2.link_socket);
+    process_outgoing_link(&mi->context, mi->context.c2.link_sockets[0]);
     ret =3D multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 060f192..22eecf9 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -89,7 +89,7 @@
         }

         /* process the I/O which triggered select */
-        process_io(c, c->c2.link_socket);
+        process_io(c, c->c2.link_sockets[0]);
         P2P_CHECK_SIG();

         perf_pop();
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 5b2be63..0ed9286 100644
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
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index e8bd074..787ba2a 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -104,7 +104,7 @@
     LONG Major;
     LONG Minor;
     LONG Patch;
-} OVPN_VERSION, * POVPN_VERSION;
+} OVPN_VERSION, *POVPN_VERSION;

 #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 6243cf6..9501f39 100644
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
index 0ccddbe..f2bd624 100644
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
@@ -999,7 +1014,6 @@
 create_socket_tcp(struct addrinfo *addrinfo)
 {
     socket_descriptor_t sd;
-
     ASSERT(addrinfo);
     ASSERT(addrinfo->ai_socktype =3D=3D SOCK_STREAM);

@@ -1031,7 +1045,6 @@
 create_socket_udp(struct addrinfo *addrinfo, const unsigned int flags)
 {
     socket_descriptor_t sd;
-
     ASSERT(addrinfo);
     ASSERT(addrinfo->ai_socktype =3D=3D SOCK_DGRAM);

@@ -1441,7 +1454,6 @@
 #ifdef TARGET_ANDROID
     protect_fd_nonlocal(sd, remote);
 #endif
-
     set_nonblock(sd);
     status =3D connect(sd, remote, af_addr_size(remote->sa_family));
     if (status)
@@ -1834,60 +1846,75 @@
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
@@ -1896,8 +1923,8 @@
         ASSERT(sock->info.proto =3D=3D PROTO_TCP_CLIENT);

         /* the proxy server */
-        sock->remote_host =3D c->c1.http_proxy->options.server;
-        sock->remote_port =3D c->c1.http_proxy->options.port;
+        sock->remote_host =3D http_proxy->options.server;
+        sock->remote_port =3D http_proxy->options.port;

         /* the OpenVPN server we will use the proxy to connect to */
         sock->proxy_dest_host =3D remote_host;
@@ -1906,9 +1933,10 @@
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
@@ -2166,22 +2194,21 @@

 /* finalize socket initialization */
 void
-link_socket_init_phase2(struct context *c)
+link_socket_init_phase2(struct context *c,
+                        struct link_socket *sock)
 {
-    struct link_socket *sock =3D c->c2.link_socket;
     const struct frame *frame =3D &c->c2.frame;
     struct signal_info *sig_info =3D c->sig;
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
@@ -2203,7 +2230,7 @@
     /* If a valid remote has been found, create the socket with its addrin=
fo */
     if (sock->info.lsa->current_remote)
     {
-#if defined(_WIN32)
+#if defined (_WIN32)
         if (dco_enabled(&c->options))
         {
             create_socket_dco_win(c, sock, sig_info);
@@ -2214,7 +2241,6 @@
         {
             create_socket(sock, sock->info.lsa->current_remote);
         }
-
     }

     /* If socket has not already been created create it now */
@@ -2233,7 +2259,6 @@
                     addr_family_name(sock->info.lsa->bind_local->ai_family=
));
                 sock->info.af =3D sock->info.lsa->bind_local->ai_family;
             }
-
             create_socket(sock, sock->info.lsa->bind_local);
         }
     }
@@ -2242,7 +2267,7 @@
     if (sock->sd =3D=3D SOCKET_UNDEFINED)
     {
         msg(M_WARN, "Could not determine IPv4/IPv6 protocol");
-        register_signal(sig_info, SIGUSR1, "Could not determine IPv4/IPv6 =
protocol");
+        sig_info->signal_received =3D SIGUSR1;
         goto done;
     }

@@ -2253,7 +2278,8 @@

     if (sock->info.proto =3D=3D PROTO_TCP_SERVER)
     {
-        phase2_tcp_server(sock, remote_dynamic, sig_info);
+        phase2_tcp_server(sock, remote_dynamic,
+                          sig_info);
     }
     else if (sock->info.proto =3D=3D PROTO_TCP_CLIENT)
     {
@@ -2279,16 +2305,11 @@
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
index 39e30b8..2098333 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -329,9 +329,38 @@
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
+                             struct link_socket *sock);

 void do_preresolve(struct context *c);

@@ -1239,11 +1268,7 @@
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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e31afeec5df6084
Gerrit-Change-Number: 434
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--GqDOsDN9DE8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">allow tcp/udp server to listen on multiple ports at the same =
time<br><br>Change-Id: Ia0a889e800f0b36aed770ee36e31afeec5df6084<br>Signed-=
off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>---<br>M src/openvpn/dco.=
c<br>M src/openvpn/event.h<br>M src/openvpn/forward.c<br>M src/openvpn/forw=
ard.h<br>M src/openvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn/mss.=
c<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M src/openvpn/mudp.h<b=
r>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/openvpn.c=
<br>M src/openvpn/openvpn.h<br>M src/openvpn/ovpn_dco_win.h<br>M src/openvp=
n/ping.h<br>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>18 files ch=
anged, 458 insertions(+), 231 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/34/434/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/dco.c b/src/openvpn/dco.c</span><br><span>index cd3e0ad..6f6d7f0 1006=
44</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvp=
n/dco.c</span><br><span>@@ -460,7 +460,7 @@</span><br><span>         return=
 0;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct link_socket *ls =3D c-&gt;c2.link_socket;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_soc=
ket *ls =3D c-&gt;c2.link_sockets[0];</span><br><span> </span><br><span>   =
  ASSERT(ls-&gt;info.connection_established);</span><br><span> </span><br><=
span>@@ -476,7 +476,7 @@</span><br><span>     }</span><br><span> #endif</sp=
an><br><span>     int ret =3D dco_new_peer(&amp;c-&gt;c1.tuntap-&gt;dco, mu=
lti-&gt;peer_id,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                      c-&gt;c2.link_socket-&gt;sd, NULL, remoteaddr, NULL, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
              c-&gt;c2.link_sockets[0]-&gt;sd, NULL, remoteaddr, NULL, NULL=
);</span><br><span>     if (ret &lt; 0)</span><br><span>     {</span><br><s=
pan>         return ret;</span><br><span>@@ -509,12 +509,12 @@</span><br><s=
pan> #if ENABLE_IP_PKTINFO</span><br><span>     struct context *c =3D &amp;=
mi-&gt;context;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!proto_is_udp(c-&gt;c2.link_socket-&gt;info.proto) || !=
(c-&gt;options.sockflags &amp; SF_USE_IP_PKTINFO))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!proto_is_udp(c-&gt;c2.link_sockets[=
0]-&gt;info.proto) || !(c-&gt;options.sockflags &amp; SF_USE_IP_PKTINFO))</=
span><br><span>     {</span><br><span>         return false;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct link_socket_actual *actual =3D &amp;c-&gt;c2.link_socket_in=
fo-&gt;lsa-&gt;actual;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct link_socket_actual *actual =3D &amp;c-&gt;c2.link_socket_info=
s[0]-&gt;lsa-&gt;actual;</span><br><span> </span><br><span>     switch (act=
ual-&gt;dest.addr.sa.sa_family)</span><br><span>     {</span><br><span>@@ -=
559,7 +559,7 @@</span><br><span>     int peer_id =3D c-&gt;c2.tls_multi-&gt=
;peer_id;</span><br><span>     struct sockaddr *remoteaddr, *localaddr =3D =
NULL;</span><br><span>     struct sockaddr_storage local =3D { 0 };</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int sd =3D c-&gt;c2.link_=
socket-&gt;sd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt sd =3D c-&gt;c2.link_sockets[0]-&gt;sd;</span><br><span> </span><br><spa=
n> </span><br><span>     if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><spa=
n>@@ -569,8 +569,8 @@</span><br><span>     }</span><br><span>     else</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     ASSERT(c-&gt;c2.link_socket_info-&gt;connection_established);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        remoteaddr =3D &amp;c-=
&gt;c2.link_socket_info-&gt;lsa-&gt;actual.dest.addr.sa;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        ASSERT(c-&gt;c2.link_socket_in=
fos[0]-&gt;connection_established);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        remoteaddr =3D &amp;c-&gt;c2.link_socket_infos[0]-&=
gt;lsa-&gt;actual.dest.addr.sa;</span><br><span>     }</span><br><span> </s=
pan><br><span>     /* In server mode we need to fetch the remote addresses =
from the push config */</span><br><span>diff --git a/src/openvpn/event.h b/=
src/openvpn/event.h</span><br><span>index f04318f..3c11b9a 100644</span><br=
><span>--- a/src/openvpn/event.h</span><br><span>+++ b/src/openvpn/event.h<=
/span><br><span>@@ -141,6 +141,7 @@</span><br><span> struct event_arg</span=
><br><span> {</span><br><span>     event_arg_t type;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool pending; /* in UDP/P2P mode mark=
s sockets waiting for processing */</span><br><span>     union {</span><br>=
<span>         struct multi_instance *mi; /* if type =3D EVENT_ARG_MULTI_IN=
STANCE */</span><br><span>         struct link_socket *ls; /* if type =3D E=
VENT_ARG_LINK_SOCKET */</span><br><span>diff --git a/src/openvpn/forward.c =
b/src/openvpn/forward.c</span><br><span>index 9700c6c..9a6dcd8 100644</span=
><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/fo=
rward.c</span><br><span>@@ -57,12 +57,18 @@</span><br><span> wait_status_st=
ring(struct context *c, struct gc_arena *gc)</span><br><span> {</span><br><=
span>     struct buffer out =3D alloc_buf_gc(64, gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;I/O WAIT %s|=
%s|%s|%s %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quo=
t;I/O WAIT %s|%s| %s&quot;,</span><br><span>                tun_stat(c-&gt;=
c1.tuntap, EVENT_READ, gc),</span><br><span>                tun_stat(c-&gt;=
c1.tuntap, EVENT_WRITE, gc),</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-               socket_stat(c-&gt;c2.link_socket, EVENT_READ, gc),</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-               socket_st=
at(c-&gt;c2.link_socket, EVENT_WRITE, gc),</span><br><span>                =
tv_string(&amp;c-&gt;c2.timeval, gc));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quo=
t;\n %s|%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                 socket_stat(c-&gt;c2.link_sockets[i], EVENT_READ, gc),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                   sock=
et_stat(c-&gt;c2.link_sockets[i], EVENT_WRITE, gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     return BSTR(&a=
mp;out);</span><br><span> }</span><br><span> </span><br><span>@@ -98,7 +104=
,7 @@</span><br><span> {</span><br><span>     if (c-&gt;c2.tls_multi &amp;&=
amp; c-&gt;c2.tls_exit_signal)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (link_socket_connection_oriented=
(c-&gt;c2.link_socket))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (link_socket_connection_oriented(c-&gt;c2.link_sockets[0]))<=
/span><br><span>         {</span><br><span>             if (c-&gt;c2.tls_mu=
lti-&gt;n_soft_errors)</span><br><span>             {</span><br><span>@@ -5=
51,6 +557,7 @@</span><br><span> #ifdef ENABLE_FRAGMENT</span><br><span> /*<=
/span><br><span>  * Should we deliver a datagram fragment to remote?</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * c is expected to be a s=
ingle-link context (p2p or child)</span><br><span>  */</span><br><span> sta=
tic void</span><br><span> check_fragment(struct context *c)</span><br><span=
>@@ -1107,7 +1114,9 @@</span><br><span>         decrypt_status =3D openvpn_=
decrypt(&amp;c-&gt;c2.buf, c-&gt;c2.buffers-&gt;decrypt_buf,</span><br><spa=
n>                                          co, &amp;c-&gt;c2.frame, ad_sta=
rt);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (!decrypt_status &amp;&amp; link_socket_connection_oriented(c-&=
gt;c2.link_socket))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!decrypt_status</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            /* all sockets are of the same type, so just check the =
first one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &amp;&amp; link_socket_connection_oriented(c-&gt;c2.link_sockets[0]))<=
/span><br><span>         {</span><br><span>             /* decryption error=
s are fatal in TCP mode */</span><br><span>             register_signal(c-&=
gt;sig, SIGUSR1, &quot;decryption-error&quot;); /* SOFT-SIGUSR1 -- decrypti=
on error in TCP mode */</span><br><span>@@ -1429,7 +1438,7 @@</span><br><sp=
an>  */</span><br><span> </span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-process_incoming_tun(struct context *c)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+process_incoming_tun(struct c=
ontext *c, struct link_socket *out_ls)</span><br><span> {</span><br><span> =
    struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -=
1462,7 +1471,8 @@</span><br><span>          */</span><br><span>         uns=
igned int flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT</span><br=
><span>                              | PIPV6_IMCP_NOHOST_CLIENT;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        process_ip_header(c, fla=
gs, &amp;c-&gt;c2.buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        process_ip_header(c, flags, &amp;c-&gt;c2.buf,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                          out_ls);</=
span><br><span> </span><br><span> #ifdef PACKET_TRUNCATION_CHECK</span><br>=
<span>         /* if (c-&gt;c2.buf.len &gt; 1) --c-&gt;c2.buf.len; */</span=
><br><span>@@ -1623,7 +1633,8 @@</span><br><span> }</span><br><span> </span=
><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-proce=
ss_ip_header(struct context *c, unsigned int flags, struct buffer *buf)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+process_ip_header(struc=
t context *c, unsigned int flags, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  struct link_socket *ls)=
</span><br><span> {</span><br><span>     if (!c-&gt;options.ce.mssfix)</spa=
n><br><span>     {</span><br><span>@@ -1669,7 +1680,7 @@</span><br><span>  =
               /* extract TOS from IP header */</span><br><span>           =
      if (flags &amp; PIPV4_PASSTOS)</span><br><span>                 {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    link_=
socket_extract_tos(c-&gt;c2.link_socket, &amp;ipbuf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    link_socket_extract_t=
os(ls, &amp;ipbuf);</span><br><span>                 }</span><br><span> #en=
dif</span><br><span> </span><br><span>@@ -1878,7 +1889,7 @@</span><br><span=
>  */</span><br><span> </span><br><span> void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-process_outgoing_tun(struct context *c)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+process_outgoing_tun(struct con=
text *c, struct link_socket *in_ls)</span><br><span> {</span><br><span>    =
 /*</span><br><span>      * Set up for write() call to TUN/TAP</span><br><s=
pan>@@ -1895,9 +1906,8 @@</span><br><span>      * The --mssfix option requi=
res</span><br><span>      * us to examine the IP header (IPv4 or IPv6).</sp=
an><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    process_ip_header(c,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                      PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLI=
ENT_NAT | PIP_OUTGOING,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                      &amp;c-&gt;c2.to_tun);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRAC=
T_DHCP_ROUTER|PIPV4_CLIENT_NAT|PIP_OUTGOING, &amp;c-&gt;c2.to_tun,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                      in_ls)=
;</span><br><span> </span><br><span>     if (c-&gt;c2.to_tun.len &lt;=3D c-=
&gt;c2.frame.buf.payload_size)</span><br><span>     {</span><br><span>@@ -2=
059,6 +2069,7 @@</span><br><span> #if defined(TARGET_LINUX) || defined(TARG=
ET_FREEBSD)</span><br><span>     static int dco_shift =3D DCO_SHIFT;    /* =
Event from DCO linux kernel module */</span><br><span> #endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span> </spa=
n><br><span>     /*</span><br><span>      * Decide what kind of events we w=
ant to wait for.</span><br><span>@@ -2164,8 +2175,11 @@</span><br><span>   =
  /*</span><br><span>      * Configure event wait based on socket, tuntap f=
lags.</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    socket_set(c-&gt;c2.link_socket, c-&gt;c2.event_set, socket,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-               &amp;c-&=
gt;c2.link_socket-&gt;ev_arg, NULL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        socket_set(c-&gt;c2.link_so=
ckets[i], c-&gt;c2.event_set, socket,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                   &amp;c-&gt;c2.link_sockets[i]-&gt;ev_a=
rg, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span>     tun_set(c-&gt;c1.tuntap, c-&gt;c2.event_set, tuntap, (voi=
d *)tun_shift, NULL);</span><br><span> #if defined(TARGET_LINUX) || defined=
(TARGET_FREEBSD)</span><br><span>     if (socket &amp; EVENT_READ &amp;&amp=
; c-&gt;c2.did_open_tun)</span><br><span>@@ -2203,7 +2217,7 @@</span><br><s=
pan> </span><br><span>     if (!c-&gt;sig-&gt;signal_received)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(!(flags &amp; IOW_CHECK_RESIDUAL) || !socket_read_residual(c-&gt;c2.link_s=
ocket))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
!(flags &amp; IOW_CHECK_RESIDUAL) || !sockets_read_residual(c))</span><br><=
span>         {</span><br><span>             int status;</span><br><span> <=
/span><br><span>@@ -2242,6 +2256,9 @@</span><br><span>                     =
    }</span><br><span> </span><br><span>                         shift =3D =
socket_shift;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  /* mark socket so that the multi code knows where we</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
 * have pending i/o */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        ev_arg-&gt;pending =3D true;</span><br><span>   =
                  }</span><br><span>                     else</span><br><sp=
an>                     {</span><br><span>@@ -2295,7 +2312,7 @@</span><br><=
span>     /* TUN device ready to accept write */</span><br><span>     else =
if (status &amp; TUN_WRITE)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        process_outgoing_tun(c);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        process_outgoing_tun(c, l=
s);</span><br><span>     }</span><br><span>     /* Incoming data on TCP/UDP=
 port */</span><br><span>     else if (status &amp; SOCKET_READ)</span><br>=
<span>@@ -2312,7 +2329,7 @@</span><br><span>         read_incoming_tun(c);<=
/span><br><span>         if (!IS_SIG(c))</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            process_incoming_=
tun(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
process_incoming_tun(c, ls);</span><br><span>         }</span><br><span>   =
  }</span><br><span>     else if (status &amp; DCO_READ)</span><br><span>di=
ff --git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>in=
dex fdc9f0e..333dcdc 100644</span><br><span>--- a/src/openvpn/forward.h</sp=
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
***********************************************/</span><br><span>@@ -303,20=
 +306,21 @@</span><br><span> #define PIPV6_IMCP_NOHOST_CLIENT        (1&lt;=
&lt;5)</span><br><span> #define PIPV6_IMCP_NOHOST_SERVER        (1&lt;&lt;6=
)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id process_ip_header(struct context *c, unsigned int flags, struct buffer *=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void process_i=
p_header(struct context *c, unsigned int flags, struct buffer *buf,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                       stru=
ct link_socket *ls);</span><br><span> </span><br><span> void schedule_exit(=
struct context *c, const int n_seconds, const int signal);</span><br><span>=
 </span><br><span> static inline struct link_socket_info *</span><br><span>=
 get_link_socket_info(struct context *c)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.link_socket_info)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.link_=
socket_infos)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        return c-&gt;c2.link_socket_info;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return c-&gt;c2.link_socket_in=
fos[0];</span><br><span>     }</span><br><span>     else</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return &a=
mp;c-&gt;c2.link_socket-&gt;info;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return &amp;c-&gt;c2.link_sockets[0]-&gt;info;</span>=
<br><span>     }</span><br><span> }</span><br><span> </span><br><span>diff =
--git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 8c707=
a4..f8dd01f 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span=
>+++ b/src/openvpn/init.c</span><br><span>@@ -533,12 +533,11 @@</span><br><=
span>         {</span><br><span>             /* Check if there is another r=
esolved address to try for</span><br><span>              * the current conn=
ection */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if (c-&gt;c1.link_socket_addr.current_remote</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                &amp;&amp; c-&gt;c1.link_socket_addr=
.current_remote-&gt;ai_next</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                &amp;&amp; !c-&gt;options.advance_next_remote)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (c-&gt;c1.l=
ink_socket_addrs[0].current_remote</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                &amp;&amp; c-&gt;c1.link_socket_addrs[0].cur=
rent_remote-&gt;ai_next)</span><br><span>             {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c1.link_socket_addr=
.current_remote =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  c-&gt;c1.link_socket_addr.current_remote-&gt;ai_next;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c=
1.link_socket_addrs[0].current_remote =3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    c-&gt;c1.link_socket_addrs[0].cur=
rent_remote-&gt;ai_next;</span><br><span>             }</span><br><span>   =
          else</span><br><span>             {</span><br><span>@@ -554,20 +5=
53,20 @@</span><br><span>                      * skipped by management on t=
he previous loop.</span><br><span>                      * If so, clear the =
addrinfo objects as close_instance does</span><br><span>                   =
   */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    if (c-&gt;c1.link_socket_addr.remote_list)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    if (c-&gt;c1.link_socket_add=
rs[0].remote_list)</span><br><span>                     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                        clear_remote_ad=
drlist(&amp;c-&gt;c1.link_socket_addr,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        clear_remote_addrlist(&amp;c-&gt=
;c1.link_socket_addrs[0],</span><br><span>                                 =
              !c-&gt;options.resolve_in_advance);</span><br><span>         =
            }</span><br><span> </span><br><span>                     /* clo=
se_instance should have cleared the addrinfo objects */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    ASSERT(c-&gt;c1.link_=
socket_addr.current_remote =3D=3D NULL);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    ASSERT(c-&gt;c1.link_socket_addr.rem=
ote_list =3D=3D NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    ASSERT(c-&gt;c1.link_socket_addrs[0].current_remote =
=3D=3D NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              ASSERT(c-&gt;c1.link_socket_addrs[0].remote_list =3D=3D NULL)=
;</span><br><span>                 }</span><br><span>                 else<=
/span><br><span>                 {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    c-&gt;c1.link_socket_addr.current_remote =
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      c-&gt;c1.link_socket_addr.remote_list;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    c-&gt;c1.link_socket_addrs[0].=
current_remote =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       c-&gt;c1.link_socket_addrs[0].remote_list;</span><br=
><span>                 }</span><br><span> </span><br><span>               =
  int advance_count =3D 1;</span><br><span>@@ -730,6 +729,13 @@</span><br><=
span>     uninit_proxy_dowork(c);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+do_link_socket_addr_new(struct c=
ontext *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY_CLEAR_GC(c-=
&gt;c1.link_socket_addrs, struct link_socket_addr,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                         c-&gt;c1.link_socke=
ts_num, &amp;c-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> void</span><br><span> context_init_1(struct context *c)</span><br><span=
> {</span><br><span>@@ -739,6 +745,10 @@</span><br><span> </span><br><span>=
     init_connection_list(c);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    c-&gt;c1.link_sockets_num =3D 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    do_link_socket_addr_new(c);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(ENABLE_=
PKCS11)</span><br><span>     if (c-&gt;first_time)</span><br><span>     {</=
span><br><span>@@ -1667,7 +1677,7 @@</span><br><span>         CLEAR(local);=
</span><br><span>         actual =3D &amp;get_link_socket_info(c)-&gt;lsa-&=
gt;actual;</span><br><span>         remote =3D actual-&gt;dest;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        getsockname(c-&gt;c2.link=
_socket-&gt;sd, &amp;local.addr.sa, &amp;sa_len);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        getsockname(c-&gt;c2.link_sockets[0]-=
&gt;sd, &amp;local.addr.sa, &amp;sa_len);</span><br><span> #if ENABLE_IP_PK=
TINFO</span><br><span>         if (!addr_defined(&amp;local))</span><br><sp=
an>         {</span><br><span>@@ -1781,8 +1791,8 @@</span><br><span>       =
                      c-&gt;options.ifconfig_ipv6_local,</span><br><span>  =
                           c-&gt;options.ifconfig_ipv6_netbits,</span><br><=
span>                             c-&gt;options.ifconfig_ipv6_remote,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
 c-&gt;c1.link_socket_addr.bind_local,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                            c-&gt;c1.link_socket_addr.remo=
te_list,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                 c-&gt;c1.link_socket_addrs[0].bind_local,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                            c-&gt;c1=
.link_socket_addrs[0].remote_list,</span><br><span>                        =
     !c-&gt;options.ifconfig_nowarn,</span><br><span>                      =
       c-&gt;c2.es,</span><br><span>                             &amp;c-&gt=
;net_ctx,</span><br><span>@@ -1856,17 +1866,16 @@</span><br><span>         =
do_alloc_route_list(c);</span><br><span> </span><br><span>         /* parse=
 and resolve the route option list */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        ASSERT(c-&gt;c2.link_socket);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ASSERT(c-&gt;c2.link_sockets);</s=
pan><br><span>         if (c-&gt;options.routes &amp;&amp; c-&gt;c1.route_l=
ist)</span><br><span>         {</span><br><span>             do_init_route_=
list(&amp;c-&gt;options, c-&gt;c1.route_list,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                               &amp;c-&gt;c2.link_s=
ocket-&gt;info, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                               &amp;c-&gt;c2.=
link_sockets[0]-&gt;info, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span=
>         }</span><br><span>         if (c-&gt;options.routes_ipv6 &amp;&am=
p; c-&gt;c1.route_ipv6_list)</span><br><span>         {</span><br><span>   =
          do_init_route_ipv6_list(&amp;c-&gt;options, c-&gt;c1.route_ipv6_l=
ist,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                   &amp;c-&gt;c2.link_socket-&gt;info, c-&gt;c2.es,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
       &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                    &amp;c-&gt;c2.link_sockets[0]-&=
gt;info, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span>         }</span=
><br><span> </span><br><span>         /* do ifconfig */</span><br><span>@@ =
-1879,8 +1888,7 @@</span><br><span>                                        =
          c-&gt;options.dev_type,</span><br><span>                         =
                         c-&gt;options.dev_node,</span><br><span>          =
                                        &amp;gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            do_ifconfig(c-&gt;c1.tuntap, guess,=
 c-&gt;c2.frame.tun_mtu, c-&gt;c2.es,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        &amp;c-&gt;net_ctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            do_ifconfig(c-&gt;c1.t=
untap, guess, c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</sp=
an><br><span>         }</span><br><span> </span><br><span>         /* possi=
bly add routes */</span><br><span>@@ -1895,6 +1903,7 @@</span><br><span>   =
      /* Store the old fd inside the fd so open_tun can use it */</span><br=
><span>         c-&gt;c1.tuntap-&gt;fd =3D oldtunfd;</span><br><span> #endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
        if (dco_enabled(&amp;c-&gt;options))</span><br><span>         {</sp=
an><br><span>             ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tuntap-&g=
t;dco);</span><br><span>@@ -1907,16 +1916,14 @@</span><br><span>         /*=
 set the hardware address */</span><br><span>         if (c-&gt;options.lla=
ddr)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            set_lladdr(&amp;c-&gt;net_ctx, c-&gt;c1.tuntap-&gt;ac=
tual_name, c-&gt;options.lladdr,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                       c-&gt;c2.es);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            set_lladdr(&amp;c-&gt;net_ctx, c-&g=
t;c1.tuntap-&gt;actual_name, c-&gt;options.lladdr, c-&gt;c2.es);</span><br>=
<span>         }</span><br><span> </span><br><span>         /* do ifconfig =
*/</span><br><span>         if (!c-&gt;options.ifconfig_noexec</span><br><s=
pan>             &amp;&amp; ifconfig_order() =3D=3D IFCONFIG_AFTER_TUN_OPEN=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            do_ifconfig(c-&gt;c1.tuntap, c-&gt;c1.tuntap-&gt;actual_=
name,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
        c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            do_ifconfig(c-&gt=
;c1.tuntap, c-&gt;c1.tuntap-&gt;actual_name, c-&gt;c2.frame.tun_mtu, c-&gt;=
c2.es, &amp;c-&gt;net_ctx);</span><br><span>         }</span><br><span> </s=
pan><br><span>         /* run the up script */</span><br><span>@@ -2427,7 +=
2434,7 @@</span><br><span>                 {</span><br><span>              =
       msg(M_NONFATAL, &quot;dco-win doesn&#39;t yet support reopening TUN =
device&quot;);</span><br><span>                     /* prevent link_socket_=
close() from closing handle with WinSock API */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    c-&gt;c2.link_socket-&gt;sd =
=3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    c-&gt;c2.link_sockets[0]-&gt;sd =3D SOCKET_UNDEFINED;=
</span><br><span>                     return false;</span><br><span>       =
          }</span><br><span>                 else</span><br><span>@@ -2657,=
14 +2664,28 @@</span><br><span> </span><br><span>     if (found &amp; OPT_P=
_SOCKBUF)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        int i;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>         msg(D_PUSH, &quot;OPTIONS IMPORT: --sndbu=
f/--rcvbuf options modified&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        link_socket_update_buffer_sizes(c-&gt;c2.link_socket,=
 c-&gt;options.rcvbuf, c-&gt;options.sndbuf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            link_socket_update_buffer=
_sizes(c-&gt;c2.link_sockets[i],</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                            c-&gt;options.rcvb=
uf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                            c-&gt;options.sndbuf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><=
span> </span><br><span>     if (found &amp; OPT_P_SOCKFLAGS)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int=
 i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>         msg(D_PUSH, &quot;OPTIONS IMPORT: --socket-flags option modified&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        link_s=
ocket_update_flags(c-&gt;c2.link_socket, c-&gt;options.sockflags);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt;=
 c-&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            link_socket_update_flags(c-&gt;c2.link_sockets[i],</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
        c-&gt;options.sockflags);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span>     }</span><br><span> </span><br>=
<span>     if (found &amp; OPT_P_PERSIST)</span><br><span>@@ -3747,12 +3768=
,103 @@</span><br><span> static void</span><br><span> do_link_socket_new(st=
ruct context *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ASSERT(!c-&gt;c2.link_socket);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    c-&gt;c2.link_socket =3D link_socket_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ASSERT(!c-&gt;c2.link_sockets);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ALLOC_ARRAY_GC(c-&gt;c2.link_sockets, struct li=
nk_socket *,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
            c-&gt;c1.link_sockets_num, &amp;c-&gt;c2.gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2.link_sockets[i] =
=3D link_socket_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span>     c-&gt;c2.link_socket_owned =3D true;</span><b=
r><span> }</span><br><span> </span><br><span> /*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * bind TCP/UDP sockets</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+do_init_socket_1(struct context *c)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    unsigned int sockflags =3D c-&gt;options.sockflags;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if PORT_SHARE</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (c-&gt;options.port_share_host &amp;&amp; c-&gt;options.p=
ort_share_port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sockflags =
|=3D SF_PORT_SHARE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets=
_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        int mode =3D LS=
_MODE_DEFAULT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* mode allows C=
M_CHILD_TCP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * instances to inherit acceptable fds</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * from a top-level parent */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;options.mode =3D=3D =
MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* in=
itializing listening socket */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (c-&gt;mode =3D=3D CM_TOP)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                mode =3D LS_MODE_TCP_LISTEN;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* initializing =
socket to client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            else if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                mode =3D LS_MODE_TCP_ACCEPT_FRO=
M;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* init each socket with its specific port *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        link_socke=
t_init_phase1(c-&gt;c2.link_sockets[i],</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                c-&gt;options.ce.local,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
             c-&gt;options.ce.local_port,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                c-&gt;options.ce.remo=
te,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                c-&gt;options.ce.remote_port,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                c-&gt;c1.dns_cach=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
               c-&gt;options.ce.proto,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                c-&gt;options.ce.af,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
         c-&gt;options.ce.bind_ipv6_only,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                mode,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                c-&=
gt;c2.accept_from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                               c-&gt;c1.http_proxy,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                c-&gt;c1.=
socks_proxy,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                         c-&gt;options.gremlin,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                c-&gt;options.ce.bind_local,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
             c-&gt;options.ce.remote_float,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                &amp;c-&gt;c1.link_=
socket_addrs[i],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                             c-&gt;options.ipchange,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                c-&gt;plu=
gins,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                  c-&gt;options.resolve_retry_seconds,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                c-&gt;op=
tions.ce.mtu_discover_type,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                c-&gt;options.rcvbuf,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                c=
-&gt;options.sndbuf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                c-&gt;options.mark,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                &amp;c-&g=
t;c2.server_poll_interval,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                sockflags);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * finalize TCP/UDP sockets</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+do_init_socket_2(struct context *c)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int i;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        link_socket_init_phase2(c, c-&gt;=
c2.link_sockets[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span>  * Print MTU INFO</span><br><s=
pan>  */</span><br><span> static void</span><br><span>@@ -3907,15 +4019,20 =
@@</span><br><span>     /* in dco-win case, link socket is a tun handle whi=
ch is</span><br><span>      * closed in do_close_tun(). Set it to UNDEFINED=
 so</span><br><span>      * we won&#39;t use WinSock API to close it. */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tuntap_is_dco_wi=
n(c-&gt;c1.tuntap) &amp;&amp; c-&gt;c2.link_socket)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tuntap_is_dco_win(c-&gt;c1.tuntap=
) &amp;&amp; c-&gt;c2.link_sockets &amp;&amp; c-&gt;c2.link_sockets[0])</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      c-&gt;c2.link_socket-&gt;sd =3D SOCKET_UNDEFINED;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2.link_sockets[0]-&gt;sd=
 =3D SOCKET_UNDEFINED;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.link_socket &amp=
;&amp; c-&gt;c2.link_socket_owned)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (c-&gt;c2.link_sockets &amp;&amp; c-&gt;c2.link_socke=
t_owned)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        link_socket_close(c-&gt;c2.link_socket);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2.link_socket =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int i;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt; c-&gt;c1.lin=
k_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  link_socket_close(c-&gt;c2.link_sockets[i]);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        c-&gt;c2.link_sockets =3D NULL;</span><br><span>  =
   }</span><br><span> </span><br><span> </span><br><span>@@ -3926,28 +4043,=
33 @@</span><br><span>           &amp;&amp; ( (c-&gt;options.persist_remote=
_ip)</span><br><span>                ||</span><br><span>                ( c=
-&gt;sig-&gt;source !=3D SIG_SOURCE_HARD</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                 &amp;&amp; ((c-&gt;c1.link_socket_addr.=
current_remote</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
               &amp;&amp; c-&gt;c1.link_socket_addr.current_remote-&gt;ai_n=
ext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  &amp;&amp; ((c-&gt;c1.link_socket_addrs[0].current_remote</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                      &amp;&amp; c-=
&gt;c1.link_socket_addrs[0].current_remote-&gt;ai_next)</span><br><span>   =
                   || c-&gt;options.no_advance))</span><br><span>          =
      )))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        clear_remote_addrlist(&amp;c-&gt;c1.link_socket_addr, !c=
-&gt;options.resolve_in_advance);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        clear_remote_addrlist(&amp;c-&gt;c1.link_socket_addrs=
[0],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
               !c-&gt;options.resolve_in_advance);</span><br><span>     }</=
span><br><span> </span><br><span>     /* Clear the remote actual address wh=
en persist_remote_ip is not in use */</span><br><span>     if (!(c-&gt;sig-=
&gt;signal_received =3D=3D SIGUSR1 &amp;&amp; c-&gt;options.persist_remote_=
ip))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        CLEAR(c-&gt;c1.link_socket_addr.actual);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        CLEAR(c-&gt;c1.link_socket_addrs=
[0].actual);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!(c-&gt;sig-&gt;signal_received =3D=
=3D SIGUSR1 &amp;&amp; c-&gt;options.persist_local_ip))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; c-&gt;c1.l=
ink_sockets_num; i++)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (c-&gt;c1.link_socket_addr.bind_local &am=
p;&amp; !c-&gt;options.resolve_in_advance)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!(c-&gt;sig-&gt;signal_received =3D=3D S=
IGUSR1 &amp;&amp; c-&gt;options.persist_local_ip))</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            freeadd=
rinfo(c-&gt;c1.link_socket_addr.bind_local);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (c-&gt;c1.link_socket_addrs[i].bind_local</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp=
; !c-&gt;options.resolve_in_advance)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                freeaddrinfo(c-&gt;c1.link_socket_addrs[i].bind_=
local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      c-&gt;c1.link_socket_addr.bind_local =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c1.link_socket_addrs[i]=
.bind_local =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span>@@ -4430,7 +4552,6 @@</span><br><span> {</span><br><span>     =
const struct options *options =3D &amp;c-&gt;options;</span><br><span>     =
const bool child =3D (c-&gt;mode =3D=3D CM_CHILD_TCP || c-&gt;mode =3D=3D C=
M_CHILD_UDP);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
link_socket_mode =3D LS_MODE_DEFAULT;</span><br><span> </span><br><span>   =
  /* init garbage collection level */</span><br><span>     gc_init(&amp;c-&=
gt;c2.gc);</span><br><span>@@ -4471,21 +4592,6 @@</span><br><span>     /* m=
ap in current connection entry */</span><br><span>     next_connection_entr=
y(c);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    /* link_socket_mode allows CM_CHILD_TCP</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     * instances to inherit acceptable fds</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     * from a top-level parent=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;opti=
ons.ce.proto =3D=3D PROTO_TCP_SERVER)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (c-&gt;mode =3D=3D CM_TOP)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            link_socket_mode =3D LS_MODE_TCP_LISTEN;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        else if (c-&gt;mode =3D=3D CM_CHILD_TCP)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            link_socket_mode =3D LS_M=
ODE_TCP_ACCEPT_FROM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* shou=
ld we disable paging? */</span><br><span>     if (c-&gt;first_time &amp;&am=
p; options-&gt;mlock)</span><br><span>     {</span><br><span>@@ -4628,7 +47=
34,7 @@</span><br><span>     /* bind the TCP/UDP socket */</span><br><span>=
     if (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP || c-&gt;mode=
 =3D=3D CM_CHILD_TCP)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        link_socket_init_phase1(c, link_socket_mode)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        do_init_so=
cket_1(c);</span><br><span>     }</span><br><span> </span><br><span>     /*=
 initialize tun/tap device object,</span><br><span>@@ -4671,7 +4777,7 @@</s=
pan><br><span>     /* finalize the TCP/UDP socket */</span><br><span>     i=
f (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP || c-&gt;mode =3D=
=3D CM_CHILD_TCP)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        link_socket_init_phase2(c);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        do_init_socket_2(c);</span><br><=
span> </span><br><span> </span><br><span>         /* Update dynamic frame c=
alculation as exact transport socket information</span><br><span>@@ -4807,7=
 +4913,8 @@</span><br><span> </span><br><span> void</span><br><span> inheri=
t_context_child(struct context *dest,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                      const struct context *src)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                      const st=
ruct context *src,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                     struct link_socket *ls)</span><br><span> {</span><br><=
span>     CLEAR(*dest);</span><br><span> </span><br><span>@@ -4820,6 +4927,=
8 @@</span><br><span> </span><br><span>     /* c1 init */</span><br><span> =
    packet_id_persist_init(&amp;dest-&gt;c1.pid_persist);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;c1.link_sockets_num =3D =
1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do_link_socke=
t_addr_new(dest);</span><br><span> </span><br><span>     dest-&gt;c1.ks.key=
_type =3D src-&gt;c1.ks.key_type;</span><br><span>     /* inherit SSL conte=
xt */</span><br><span>@@ -4844,7 +4953,7 @@</span><br><span>          * The=
 CM_TOP context does the socket listen(),</span><br><span>          * and t=
he CM_CHILD_TCP context does the accept().</span><br><span>          */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        dest-&gt;c2.accep=
t_from =3D src-&gt;c2.link_socket;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        dest-&gt;c2.accept_from =3D ls;</span><br><span>    =
 }</span><br><span> </span><br><span> #ifdef ENABLE_PLUGIN</span><br><span>=
@@ -4868,18 +4977,26 @@</span><br><span>     /* UDP inherits some extra thi=
ngs which TCP does not */</span><br><span>     if (dest-&gt;mode =3D=3D CM_=
CHILD_UDP)</span><br><span>     {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        ASSERT(!dest-&gt;c2.link_sockets);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         /* inherit b=
uffers */</span><br><span>         dest-&gt;c2.buffers =3D src-&gt;c2.buffe=
rs;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /* inherit parent link_socket and tuntap */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        dest-&gt;c2.link_socket =3D src-&gt=
;c2.link_socket;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ALLOC_ARRAY_GC(dest-&gt;c2.link_sockets, struct link_socket *, 1,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                       &=
amp;dest-&gt;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        ALLOC_OBJ_GC(dest-&gt;c2.link_socket_info, struct lin=
k_socket_info, &amp;dest-&gt;gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        *dest-&gt;c2.link_socket_info =3D src-&gt;c2.link_socke=
t-&gt;info;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* inherit parent link_socket and tuntap */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        dest-&gt;c2.link_sockets[0] =3D ls;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        ALLOC_ARRAY_GC(dest-&gt;c2.link_socket=
_infos, struct link_socket_info *, 1,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                       &amp;dest-&gt;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_GC(dest-&gt;c2.li=
nk_socket_infos[0], struct link_socket_info,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     &amp;dest-&gt;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        *dest-&gt;c2.link_sock=
et_infos[0] =3D ls-&gt;info;</span><br><span> </span><br><span>         /* =
locally override some link_socket_info fields */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        dest-&gt;c2.link_socket_info-&gt;lsa =3D=
 &amp;dest-&gt;c1.link_socket_addr;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        dest-&gt;c2.link_socket_info-&gt;connection_establish=
ed =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  dest-&gt;c2.link_socket_infos[0]-&gt;lsa =3D &amp;dest-&gt;c1.link_socket=
_addrs[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
est-&gt;c2.link_socket_infos[0]-&gt;connection_established =3D false;</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/init.h b/src/openvpn/init.h</span><br><span>index 7731=
f5a..85de096 100644</span><br><span>--- a/src/openvpn/init.h</span><br><spa=
n>+++ b/src/openvpn/init.h</span><br><span>@@ -95,7 +95,8 @@</span><br><spa=
n> bool do_deferred_options(struct context *c, const unsigned int found);</=
span><br><span> </span><br><span> void inherit_context_child(struct context=
 *dest,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
             const struct context *src);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                           const struct context *src,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
       struct link_socket *ls);</span><br><span> </span><br><span> void inh=
erit_context_top(struct context *dest,</span><br><span>                    =
      const struct context *src);</span><br><span>diff --git a/src/openvpn/=
mss.c b/src/openvpn/mss.c</span><br><span>index 1566c64..9b6360f 100644</sp=
an><br><span>--- a/src/openvpn/mss.c</span><br><span>+++ b/src/openvpn/mss.=
c</span><br><span>@@ -357,7 +357,7 @@</span><br><span>     struct link_sock=
et_info *lsi =3D get_link_socket_info(c);</span><br><span>     struct optio=
ns *o =3D &amp;c-&gt;options;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int pmtu =3D c-&gt;c2.link_socket-&gt;mtu;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int pmtu =3D c-&gt=
;c2.link_sockets[0]-&gt;mtu;</span><br><span>     sa_family_t af =3D lsi-&g=
t;lsa-&gt;actual.dest.addr.sa.sa_family;</span><br><span>     int proto =3D=
 lsi-&gt;proto;</span><br><span> </span><br><span>diff --git a/src/openvpn/=
mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 3772acf..06073cd 100644</=
span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/m=
tcp.c</span><br><span>@@ -115,13 +115,13 @@</span><br><span> #endif /* ENAB=
LE_DEBUG */</span><br><span> </span><br><span> static struct multi_instance=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_create_instan=
ce_tcp(struct multi_context *m)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+multi_create_instance_tcp(struct multi_context *m, struct link_=
socket *ls)</span><br><span> {</span><br><span>     struct gc_arena gc =3D =
gc_new();</span><br><span>     struct multi_instance *mi =3D NULL;</span><b=
r><span>     struct hash *hash =3D m-&gt;hash;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    mi =3D multi_create_instance=
(m, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi =
=3D multi_create_instance(m, NULL, ls);</span><br><span>     if (mi)</span>=
<br><span>     {</span><br><span>         struct hash_element *he;</span><b=
r><span>@@ -171,13 +171,16 @@</span><br><span>     /* buffer for queued TCP=
 socket output packets */</span><br><span>     mi-&gt;tcp_link_out_deferred=
 =3D mbuf_init(m-&gt;top.options.n_bcast_buf);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;context.c2.lin=
k_socket);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(=
mi-&gt;context.c2.link_socket-&gt;info.lsa);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;context.c2.link_socket-&gt;mode =
=3D=3D LS_MODE_TCP_ACCEPT_FROM);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ASSERT(mi-&gt;context.c2.link_socket-&gt;info.lsa-&gt;actual=
.dest.addr.sa.sa_family =3D=3D AF_INET</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-           || mi-&gt;context.c2.link_socket-&gt;info.lsa-&=
gt;actual.dest.addr.sa.sa_family =3D=3D AF_INET6</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context.c2.link_sockets);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;cont=
ext.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ASSERT(mi-&gt;context.c2.link_sockets[0]-&gt;info.lsa);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context.c2.l=
ink_sockets[0]-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context.c2.link_sock=
ets[0]-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =3D=3D AF_INET</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           || mi-&gt;conte=
xt.c2.link_sockets[0]-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =3D=3D=
 AF_INET6</span><br><span>            );</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!mroute_extract_openvpn_sockaddr(&amp;mi-&gt;rea=
l, &amp;mi-&gt;context.c2.link_socket-&gt;info.lsa-&gt;actual.dest, true))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mroute_extr=
act_openvpn_sockaddr(&amp;mi-&gt;real,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                         &amp;mi-&gt;con=
text.c2.link_sockets[0]-&gt;info.lsa-&gt;actual.dest,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
true))</span><br><span>     {</span><br><span>         msg(D_MULTI_ERRORS, =
&quot;MULTI TCP: TCP client address is undefined&quot;);</span><br><span>  =
       return false;</span><br><span>@@ -233,7 +236,7 @@</span><br><span> v=
oid</span><br><span> multi_tcp_dereference_instance(struct multi_tcp *mtcp,=
 struct multi_instance *mi)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct link_socket *ls =3D mi-&gt;context.c2.l=
ink_socket;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct link_socket *ls =3D mi-&gt;context.c2.link_sockets[0];</span><br><span> =
    if (ls &amp;&amp; mi-&gt;socket_set_called)</span><br><span>     {</spa=
n><br><span>         event_del(mtcp-&gt;es, socket_event_handle(ls));</span=
><br><span>@@ -248,7 +251,7 @@</span><br><span>     if (mi)</span><br><span=
>     {</span><br><span>         mi-&gt;socket_set_called =3D true;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        socket_set(mi-&gt;con=
text.c2.link_socket,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        socket_set(mi-&gt;context.c2.link_sockets[0],</span><br><span>    =
                m-&gt;mtcp-&gt;es,</span><br><span>                    mbuf=
_defined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</span><b=
r><span>                    &amp;mi-&gt;ev_arg,</span><br><span>@@ -260,10 =
+263,14 @@</span><br><span> multi_tcp_wait(const struct context *c,</span><=
br><span>                struct multi_tcp *mtcp)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int status;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int i, status;</span><br><spa=
n>     unsigned int *persistent =3D &amp;mtcp-&gt;tun_rwflags;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    socket_set_listen_persistent(c=
-&gt;c2.link_socket, mtcp-&gt;es,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                 &amp;c-&gt;c2.link_socket-&gt;=
ev_arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; c-&gt=
;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 socket_set_listen_persistent(c-&gt;c2.link_sockets[i], mtcp-&gt;es,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
           &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span> =
#ifdef _WIN32</span><br><span>     if (tuntap_is_wintun(c-&gt;c1.tuntap))</=
span><br><span>@@ -481,16 +488,18 @@</span><br><span>         case TA_SOCKE=
T_READ:</span><br><span>         case TA_SOCKET_READ_RESIDUAL:</span><br><s=
pan>             ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            ASSERT(mi-&gt;context.c2.link_socket);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            ASSERT(mi-&gt;context.c2.=
link_sockets);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ASSERT(mi-&gt;context.c2.link_sockets[0]);</span><br><span>         =
    set_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          read_incoming_link(&amp;mi-&gt;context, mi-&gt;context.c2.link_so=
cket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
ead_incoming_link(&amp;mi-&gt;context, mi-&gt;context.c2.link_sockets[0]);<=
/span><br><span>             clear_prefix();</span><br><span>             i=
f (!IS_SIG(&amp;mi-&gt;context))</span><br><span>             {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                multi_process_inc=
oming_link(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                multi_process_incoming_link(m, mi, mpp_flags,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                     mi-&gt;context.c2.link_sockets[0]);</span><br><span>  =
               if (!IS_SIG(&amp;mi-&gt;context))</span><br><span>          =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       stream_buf_read_setup(mi-&gt;context.c2.link_socket);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    stream_buf_rea=
d_setup(mi-&gt;context.c2.link_sockets[0]);</span><br><span>               =
  }</span><br><span>             }</span><br><span>             break;</spa=
n><br><span>@@ -566,7 +575,7 @@</span><br><span>             break;</span><=
br><span> </span><br><span>         case MTP_NONE:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            if (mi &amp;&amp; socket_read_resi=
dual(c-&gt;c2.link_socket))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (mi &amp;&amp; sockets_read_residual(c))</span><br><=
span>             {</span><br><span>                 newaction =3D TA_SOCKE=
T_READ_RESIDUAL;</span><br><span>             }</span><br><span>@@ -721,9 +=
730,14 @@</span><br><span> </span><br><span>                 /* new incomin=
g TCP client attempting to connect? */</span><br><span>                 cas=
e EVENT_ARG_LINK_SOCKET:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    ASSERT(m-&gt;top.c2.link_socket);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    socket_reset_listen_=
persistent(m-&gt;top.c2.link_socket);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    mi =3D multi_create_instance_tcp(m);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    if=
 (!ev_arg-&gt;u.ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        msg(D_MULTI_ERRORS, &quot;MULTI: mtcp_proc_io: nu=
ll socket&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      break;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            socket_reset_listen_persistent(ev_arg-&gt;u.ls);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    mi =3D multi_c=
reate_instance_tcp(m, ev_arg-&gt;u.ls);</span><br><span>                   =
  if (mi)</span><br><span>                     {</span><br><span>          =
               multi_tcp_action(m, mi, TA_INITIAL, false);</span><br><span>=
@@ -757,9 +771,9 @@</span><br><span>             else if (e-&gt;arg =3D=3D =
MTCP_SOCKET)</span><br><span>             {</span><br><span>               =
  struct multi_instance *mi;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                ASSERT(m-&gt;top.c2.link_socket);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                socket_reset_listen_pers=
istent(m-&gt;top.c2.link_socket);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                mi =3D multi_create_instance_tcp(m);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                ASSERT(m-&gt;t=
op.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                socket_reset_listen_persistent(m-&gt;top.c2.link_socket=
s[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   mi =3D multi_create_instance_tcp(m, m-&gt;top.c2.link_sockets[0]);</span=
><br><span>                 if (mi)</span><br><span>                 {</spa=
n><br><span>                     multi_tcp_action(m, mi, TA_INITIAL, false)=
;</span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</spa=
n><br><span>index 5bd7354..dd45720 100644</span><br><span>--- a/src/openvpn=
/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -185,7 =
+185,8 @@</span><br><span>  */</span><br><span> </span><br><span> struct mu=
lti_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_g=
et_create_instance_udp(struct multi_context *m, bool *floated)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+multi_get_create_instance_udp(st=
ruct multi_context *m, bool *floated,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                              struct link_socket *ls)</sp=
an><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span=
><br><span>     struct mroute_addr real;</span><br><span>@@ -256,7 +257,7 @=
@</span><br><span>                      * connect-freq but not against conn=
ect-freq-initial */</span><br><span>                     reflect_filter_rat=
e_limit_decrease(m-&gt;initial_rate_limiter);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    mi =3D multi_=
create_instance(m, &amp;real);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    mi =3D multi_create_instance(m, &amp;real, l=
s);</span><br><span>                     if (mi)</span><br><span>          =
           {</span><br><span>                         hash_add_fast(hash, b=
ucket, &amp;mi-&gt;real, hv, mi);</span><br><span>@@ -317,7 +318,7 @@</span=
><br><span>         msg_set_prefix(&quot;Connection Attempt&quot;);</span><=
br><span>         m-&gt;top.c2.to_link =3D m-&gt;hmac_reply;</span><br><spa=
n>         m-&gt;top.c2.to_link_addr =3D m-&gt;hmac_reply_dest;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        process_outgoing_link(&am=
p;m-&gt;top, &amp;m-&gt;top.c2.link_socket[0]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        process_outgoing_link(&amp;m-&gt;top, m=
-&gt;top.c2.link_sockets[0]);</span><br><span>         m-&gt;hmac_reply_des=
t =3D NULL;</span><br><span>     }</span><br><span> }</span><br><span>@@ -3=
80,10 +381,20 @@</span><br><span>     /* Incoming data on UDP port */</span=
><br><span>     else if (status &amp; SOCKET_READ)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        read_incoming_l=
ink(&amp;m-&gt;top, m-&gt;top.c2.link_socket);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (!IS_SIG(&amp;m-&gt;top))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        int i;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt; m-&gt;top=
.c1.link_sockets_num; i++)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            multi_process_incoming_link(m, =
NULL, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (!m-&gt;top.c2.link_sockets[i]-&gt;ev_arg.pending)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                continue;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            read_incoming_link(&amp;m-&gt;top, m-&gt;top=
.c2.link_sockets[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (!IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                multi_process_incoming_link(m, NULL, mpp_f=
lags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                              m-&gt;top.c2.link_sockets[i]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>    =
     }</span><br><span>     }</span><br><span>     /* Incoming data on TUN =
device */</span><br><span>diff --git a/src/openvpn/mudp.h b/src/openvpn/mud=
p.h</span><br><span>index 8383c64..1088246 100644</span><br><span>--- a/src=
/openvpn/mudp.h</span><br><span>+++ b/src/openvpn/mudp.h</span><br><span>@@=
 -55,12 +55,14 @@</span><br><span>  * it.  If no entry exists, this functio=
n handles its creation, and if</span><br><span>  * successful, returns the =
newly created instance.</span><br><span>  *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @param m            - The single multi_context str=
ucture.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m =
          - The single multi_context structure.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param ls          - Listening socket where =
this instance is connecting to</span><br><span>  *</span><br><span>  * @ret=
urn A pointer to a multi_instance if one already existed for the</span><br>=
<span>  *     packet&#39;s source address or if one was a newly created suc=
cessfully.</span><br><span>  *      NULL if one did not yet exist and a new=
 one was not created.</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-struct multi_instance *multi_get_create_instance_udp(s=
truct multi_context *m, bool *floated);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+struct multi_instance *multi_get_create_instance_udp(st=
ruct multi_context *m, bool *floated,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                                     stru=
ct link_socket *ls);</span><br><span> </span><br><span> #endif /* ifndef MU=
DP_H */</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/mult=
i.c</span><br><span>index af04dc8..e9a3945 100644</span><br><span>--- a/src=
/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>=
@@ -682,7 +682,10 @@</span><br><span>         multi_client_disconnect_scrip=
t(m, mi);</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    close_context(&amp;mi-&gt;context, SIGTERM=
, CC_GC_FREE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (mi-&gt;did_open_context)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  close_context(&amp;mi-&gt;context, SIGTERM, CC_GC_FREE);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><s=
pan>     multi_tcp_instance_specific_free(mi);</span><br><span> </span><br>=
<span>@@ -750,7 +753,8 @@</span><br><span>  * Create a client instance obje=
ct for a newly connected client.</span><br><span>  */</span><br><span> stru=
ct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mu=
lti_create_instance(struct multi_context *m, const struct mroute_addr *real=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_create_insta=
nce(struct multi_context *m, const struct mroute_addr *real,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                      struct link_=
socket *ls)</span><br><span> {</span><br><span>     struct gc_arena gc =3D =
gc_new();</span><br><span>     struct multi_instance *mi;</span><br><span>@=
@ -773,7 +777,8 @@</span><br><span>         generate_prefix(mi);</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    inherit_context_child(&amp;mi-&gt;context, &amp;m-&gt;top);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;did_open_co=
ntext =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
inherit_context_child(&amp;mi-&gt;context, &amp;m-&gt;top, ls);</span><br><=
span>     if (IS_SIG(&amp;mi-&gt;context))</span><br><span>     {</span><br=
><span>         goto err;</span><br><span>@@ -3128,7 +3133,8 @@</span><br><=
span> }</span><br><span> </span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-multi_process_float(struct multi_context *m, stru=
ct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+multi_process_float(struct multi_context *m, struct multi_instance *mi,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
struct link_socket *ls)</span><br><span> {</span><br><span>     struct mrou=
te_addr real;</span><br><span>     struct hash *hash =3D m-&gt;hash;</span>=
<br><span>@@ -3184,8 +3190,8 @@</span><br><span>     mi-&gt;context.c2.to_l=
ink_addr =3D &amp;mi-&gt;context.c2.from;</span><br><span> </span><br><span=
>     /* inherit parent link_socket and link_socket_info */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.link_socket =3D=
 m-&gt;top.c2.link_socket;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    mi-&gt;context.c2.link_socket_info-&gt;lsa-&gt;actual =3D m-&gt;to=
p.c2.from;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&g=
t;context.c2.link_sockets[0] =3D ls;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    mi-&gt;context.c2.link_socket_infos[0]-&gt;lsa-&gt;act=
ual =3D m-&gt;top.c2.from;</span><br><span> </span><br><span>     tls_updat=
e_remote_addr(mi-&gt;context.c2.tls_multi, &amp;mi-&gt;context.c2.from);</s=
pan><br><span> </span><br><span>@@ -3333,7 +3339,8 @@</span><br><span>  * i=
.e. client -&gt; server direction.</span><br><span>  */</span><br><span> bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_incom=
ing_link(struct multi_context *m, struct multi_instance *instance, const un=
signed int mpp_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+multi_process_incoming_link(struct multi_context *m, struct multi_instanc=
e *instance, const unsigned int mpp_flags,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                            struct link_socket *ls)<=
/span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</s=
pan><br><span> </span><br><span>@@ -3354,7 +3361,7 @@</span><br><span> #ifd=
ef MULTI_DEBUG_EVENT_LOOP</span><br><span>         printf(&quot;TCP/UDP -&g=
t; TUN [%d]\n&quot;, BLEN(&amp;m-&gt;top.c2.buf));</span><br><span> #endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_set_pend=
ing(m, multi_get_create_instance_udp(m, &amp;floated));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        multi_set_pending(m, multi_get_=
create_instance_udp(m, &amp;floated, ls));</span><br><span>     }</span><br=
><span>     else</span><br><span>     {</span><br><span>@@ -3395,7 +3402,7 =
@@</span><br><span>                 /* nonzero length means that we have a =
valid, decrypted packed */</span><br><span>                 if (floated &am=
p;&amp; c-&gt;c2.buf.len &gt; 0)</span><br><span>                 {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    multi_pro=
cess_float(m, m-&gt;pending);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    multi_process_float(m, m-&gt;pending, ls);</s=
pan><br><span>                 }</span><br><span> </span><br><span>        =
         process_incoming_link_part2(c, lsi, orig_buf);</span><br><span>@@ =
-3614,7 +3621,7 @@</span><br><span>                     }</span><br><span> =
</span><br><span>                     /* encrypt in instance context */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    proce=
ss_incoming_tun(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    process_incoming_tun(c, c-&gt;c2.link_sockets[0]);</spa=
n><br><span> </span><br><span>                     /* postprocess and set w=
akeup */</span><br><span>                     ret =3D multi_process_post(m,=
 m-&gt;pending, mpp_flags);</span><br><span>@@ -3646,7 +3653,8 @@</span><br=
><span>         {</span><br><span>             pip_flags |=3D PIP_MSSFIX;</=
span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        process_ip_header(&amp;item.instance-&gt;context, pip_flags, &a=
mp;item.instance-&gt;context.c2.buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        process_ip_header(&amp;item.instance-&gt;context,=
 pip_flags, &amp;item.instance-&gt;context.c2.buf,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                          item.instance-&gt;=
context.c2.link_sockets[0]);</span><br><span>         encrypt_sign(&amp;ite=
m.instance-&gt;context, true);</span><br><span>         mbuf_free_buf(item.=
buffer);</span><br><span> </span><br><span>diff --git a/src/openvpn/multi.h=
 b/src/openvpn/multi.h</span><br><span>index a736809..0d4ec63 100644</span>=
<br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi=
.h</span><br><span>@@ -125,6 +125,7 @@</span><br><span>     in_addr_t repor=
ting_addr;     /* IP address shown in status listing */</span><br><span>   =
  struct in6_addr reporting_addr_ipv6; /* IPv6 address in status listing */=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool did_open_context;</span><br><span>     bool did_real_hash;</span><b=
r><span>     bool did_iter;</span><br><span> #ifdef ENABLE_MANAGEMENT</span=
><br><span>@@ -269,7 +270,8 @@</span><br><span> </span><br><span> void mult=
i_top_free(struct multi_context *m);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-struct multi_instance *multi_create_instan=
ce(struct multi_context *m, const struct mroute_addr *real);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *multi_creat=
e_instance(struct multi_context *m, const struct mroute_addr *real,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
                  struct link_socket *ls);</span><br><span> </span><br><spa=
n> void multi_close_instance(struct multi_context *m, struct multi_instance=
 *mi, bool shutdown);</span><br><span> </span><br><span>@@ -283,7 +285,8 @@=
</span><br><span>  * existing peer. Updates multi_instance with new address=
,</span><br><span>  * updates hashtables in multi_context.</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_proces=
s_float(struct multi_context *m, struct multi_instance *mi);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void multi_process_float(struct mu=
lti_context *m, struct multi_instance *mi,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                         struct link_socket *ls);</s=
pan><br><span> </span><br><span> #define MPP_PRE_SELECT             (1&lt;&=
lt;0)</span><br><span> #define MPP_CONDITIONAL_PRE_SELECT (1&lt;&lt;1)</spa=
n><br><span>@@ -348,8 +351,10 @@</span><br><span>  *                       =
when using TCP transport. Otherwise NULL, as is</span><br><span>  *        =
               the case when using UDP transport.</span><br><span>  * @para=
m mpp_flags    - Fast I/O optimization flags.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param ls           - Socket where the packet =
was received.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-bool multi_process_incoming_link(struct multi_context *m, stru=
ct multi_instance *instance, const unsigned int mpp_flags);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool multi_process_incoming_link(st=
ruct multi_context *m, struct multi_instance *instance, const unsigned int =
mpp_flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                        struct link_socket *ls);</span><br><span> </span><b=
r><span> </span><br><span> /**</span><br><span>@@ -663,7 +668,7 @@</span><b=
r><span> #endif</span><br><span>     set_prefix(mi);</span><br><span>     v=
lan_process_outgoing_tun(m, mi);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    process_outgoing_tun(&amp;mi-&gt;context);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_tun(&amp;mi-&gt;=
context, mi-&gt;context.c2.link_sockets[0]);</span><br><span>     ret =3D m=
ulti_process_post(m, mi, mpp_flags);</span><br><span>     clear_prefix();</=
span><br><span>     return ret;</span><br><span>@@ -678,7 +683,7 @@</span><=
br><span> {</span><br><span>     bool ret =3D true;</span><br><span>     se=
t_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    proc=
ess_outgoing_link(&amp;mi-&gt;context, mi-&gt;context.c2.link_socket);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_lin=
k(&amp;mi-&gt;context, mi-&gt;context.c2.link_sockets[0]);</span><br><span>=
     ret =3D multi_process_post(m, mi, mpp_flags);</span><br><span>     cle=
ar_prefix();</span><br><span>     return ret;</span><br><span>diff --git a/=
src/openvpn/openvpn.c b/src/openvpn/openvpn.c</span><br><span>index 060f192=
..22eecf9 100644</span><br><span>--- a/src/openvpn/openvpn.c</span><br><spa=
n>+++ b/src/openvpn/openvpn.c</span><br><span>@@ -89,7 +89,7 @@</span><br><=
span>         }</span><br><span> </span><br><span>         /* process the I=
/O which triggered select */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        process_io(c, c-&gt;c2.link_socket);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        process_io(c, c-&gt;c2.link_socke=
ts[0]);</span><br><span>         P2P_CHECK_SIG();</span><br><span> </span><=
br><span>         perf_pop();</span><br><span>diff --git a/src/openvpn/open=
vpn.h b/src/openvpn/openvpn.h</span><br><span>index 5b2be63..0ed9286 100644=
</span><br><span>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/open=
vpn/openvpn.h</span><br><span>@@ -154,7 +154,8 @@</span><br><span>  */</spa=
n><br><span> struct context_1</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct link_socket_addr link_socket_addr;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int link_sockets_n=
um;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_=
socket_addr *link_socket_addrs;</span><br><span>     /**&lt; Local and remo=
te addresses on the</span><br><span>      *   external network. */</span><b=
r><span> </span><br><span>@@ -237,11 +238,11 @@</span><br><span>     /* bit=
mask for event status. Check event.h for possible values */</span><br><span=
>     unsigned int event_set_status;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct link_socket *link_socket;     /=
* socket used for TCP/UDP connection to remote */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct link_socket **link_sockets;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_inf=
o **link_socket_infos;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     bool link_socket_owned;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /** This variable is used =
instead link_socket-&gt;info for P2MP UDP childs */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct link_socket_info *link_socket_in=
fo;</span><br><span>     const struct link_socket *accept_from; /* possibly=
 do accept() on a parent link_socket */</span><br><span> </span><br><span> =
    struct link_socket_actual *to_link_addr;    /* IP address of remote */<=
/span><br><span>diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_=
dco_win.h</span><br><span>index e8bd074..787ba2a 100644</span><br><span>---=
 a/src/openvpn/ovpn_dco_win.h</span><br><span>+++ b/src/openvpn/ovpn_dco_wi=
n.h</span><br><span>@@ -104,7 +104,7 @@</span><br><span>     LONG Major;</s=
pan><br><span>     LONG Minor;</span><br><span>     LONG Patch;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-} OVPN_VERSION, * POVPN_VERSION;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_VERSION, *POV=
PN_VERSION;</span><br><span> </span><br><span> #define OVPN_IOCTL_NEW_PEER =
    CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)</spa=
n><br><span> #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, =
2, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span>diff --git a/src/openv=
pn/ping.h b/src/openvpn/ping.h</span><br><span>index 6243cf6..9501f39 10064=
4</span><br><span>--- a/src/openvpn/ping.h</span><br><span>+++ b/src/openvp=
n/ping.h</span><br><span>@@ -63,7 +63,7 @@</span><br><span>         &amp;&a=
mp; event_timeout_trigger(&amp;c-&gt;c2.ping_rec_interval,</span><br><span>=
                                  &amp;c-&gt;c2.timeval,</span><br><span>  =
                                (!c-&gt;options.ping_timer_remote</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
   || link_socket_actual_defined(&amp;c-&gt;c1.link_socket_addr.actual))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
            || link_socket_actual_defined(&amp;c-&gt;c1.link_socket_addrs[0=
].actual))</span><br><span>                                  ? ETT_DEFAULT =
: 15))</span><br><span>     {</span><br><span>         trigger_ping_timeout=
_signal(c);</span><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn=
/socket.c</span><br><span>index 0ccddbe..f2bd624 100644</span><br><span>---=
 a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><b=
r><span>@@ -42,6 +42,21 @@</span><br><span> </span><br><span> #include &quo=
t;memdbg.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
sockets_read_residual(const struct context *c)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i=
 &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (c-&gt;c2.link_sockets[i]-&gt;stream_buf.residual_fully_form=
ed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /*</span><br><span>  * Convert sockflags/getadd=
r_flags into getaddr_flags</span><br><span>  */</span><br><span>@@ -999,7 +=
1014,6 @@</span><br><span> create_socket_tcp(struct addrinfo *addrinfo)</sp=
an><br><span> {</span><br><span>     socket_descriptor_t sd;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(addrinf=
o);</span><br><span>     ASSERT(addrinfo-&gt;ai_socktype =3D=3D SOCK_STREAM=
);</span><br><span> </span><br><span>@@ -1031,7 +1045,6 @@</span><br><span>=
 create_socket_udp(struct addrinfo *addrinfo, const unsigned int flags)</sp=
an><br><span> {</span><br><span>     socket_descriptor_t sd;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(addrinf=
o);</span><br><span>     ASSERT(addrinfo-&gt;ai_socktype =3D=3D SOCK_DGRAM)=
;</span><br><span> </span><br><span>@@ -1441,7 +1454,6 @@</span><br><span> =
#ifdef TARGET_ANDROID</span><br><span>     protect_fd_nonlocal(sd, remote);=
</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>     set_nonblock(sd);</span><br><span>     status =3D =
connect(sd, remote, af_addr_size(remote-&gt;sa_family));</span><br><span>  =
   if (status)</span><br><span>@@ -1834,60 +1846,75 @@</span><br><span> }</=
span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-link_socket_init_phase1(struct context *c, int mode)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_init_phase1(s=
truct link_socket *sock,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        const char *local_host,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        const char *local=
_port,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           const char *remote_host,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        const char *remote_port,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        struct=
 cached_dns_entry *dns_cache,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        int proto,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        sa_family_t af,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        bool b=
ind_ipv6_only,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   int mode,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        const struct link_socket *accept_from,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 struct http_proxy_info *http_proxy,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        struct socks_proxy_info *socks_pro=
xy,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DE=
BUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        int gremlin,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            bool bind_local,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        bool remote_float,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        struct link_socke=
t_addr *lsa,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 const char *ipchange_command,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        const struct plugin_list=
 *plugins,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               int resolve_retry_seconds,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        int mtu_discover_type,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        in=
t rcvbuf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              int sndbuf,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        int mark,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        struct event_timeout *server_po=
ll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                unsigned int sockflags)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct link_socket *sock =3D c-&gt=
;c2.link_socket;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct options *o =3D &amp;c-&gt;options;</span><br><span>     ASSERT(sock);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 const char *remote_host =3D o-&gt;ce.remote;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const char *remote_port =3D o-&gt;ce.remote_por=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;local_host =3D o-&gt;ce.loc=
al;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;local=
_port =3D o-&gt;ce.local_port;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    sock-&gt;local_host =3D local_host;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    sock-&gt;local_port =3D local_port;</spa=
n><br><span>     sock-&gt;remote_host =3D remote_host;</span><br><span>    =
 sock-&gt;remote_port =3D remote_port;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    sock-&gt;dns_cache =3D c-&gt;c1.dns_cache;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;http_proxy =3D c-&gt=
;c1.http_proxy;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    so=
ck-&gt;socks_proxy =3D c-&gt;c1.socks_proxy;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    sock-&gt;bind_local =3D o-&gt;ce.bind_local;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;resolve_retr=
y_seconds =3D o-&gt;resolve_retry_seconds;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    sock-&gt;mtu_discover_type =3D o-&gt;ce.mtu_discov=
er_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&g=
t;dns_cache =3D dns_cache;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    sock-&gt;http_proxy =3D http_proxy;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    sock-&gt;socks_proxy =3D socks_proxy;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;bind_local =
=3D bind_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
sock-&gt;resolve_retry_seconds =3D resolve_retry_seconds;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;mtu_discover_type =3D mt=
u_discover_type;</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;gremlin =3D =
o-&gt;gremlin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
ock-&gt;gremlin =3D gremlin;</span><br><span> #endif</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;socket_buffer=
_sizes.rcvbuf =3D o-&gt;rcvbuf;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    sock-&gt;socket_buffer_sizes.sndbuf =3D o-&gt;sndbuf;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;socket_buffer_=
sizes.rcvbuf =3D rcvbuf;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    sock-&gt;socket_buffer_sizes.sndbuf =3D sndbuf;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;sockflags=
 =3D o-&gt;sockflags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if PORT_SHARE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(o-&gt;port_share_host &amp;&amp; o-&gt;port_share_port)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        sock-&gt;sockflags |=3D SF_PORT_SHARE;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    sock-&gt;mark =3D o-&gt;mark;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    sock-&gt;bind_dev =3D o-&gt;bind_dev;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;sockflags =3D s=
ockflags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&=
gt;mark =3D mark;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    sock-&gt;info.proto =3D o-&gt;ce.proto;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.af =3D o-&gt;ce.af;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.remot=
e_float =3D o-&gt;ce.remote_float;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    sock-&gt;info.lsa =3D &amp;c-&gt;c1.link_socket_addr;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.bind_ipv=
6_only =3D o-&gt;ce.bind_ipv6_only;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    sock-&gt;info.ipchange_command =3D o-&gt;ipchange;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info.plugins =
=3D c-&gt;plugins;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 sock-&gt;server_poll_timeout =3D &amp;c-&gt;c2.server_poll_interval;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info.proto =
=3D proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-=
&gt;info.af =3D af;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    sock-&gt;info.remote_float =3D remote_float;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    sock-&gt;info.lsa =3D lsa;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info.bind_ipv6_only =
=3D bind_ipv6_only;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    sock-&gt;info.ipchange_command =3D ipchange_command;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info.plugins =3D plugins;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;server=
_poll_timeout =3D server_poll_timeout;</span><br><span> </span><br><span>  =
   sock-&gt;mode =3D mode;</span><br><span>     if (mode =3D=3D LS_MODE_TCP=
_ACCEPT_FROM)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        ASSERT(c-&gt;c2.accept_from);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ASSERT(accept_from);</span><br><s=
pan>         ASSERT(sock-&gt;info.proto =3D=3D PROTO_TCP_SERVER);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;sd =3D c-&gt;c=
2.accept_from-&gt;sd;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        sock-&gt;sd =3D accept_from-&gt;sd;</span><br><span>         /* i=
nherit (possibly guessed) info AF from parent context */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;info.af =3D c-&gt;c2.ac=
cept_from-&gt;info.af;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        sock-&gt;info.af =3D accept_from-&gt;info.af;</span><br><span>  =
   }</span><br><span> </span><br><span>     /* are we running in HTTP proxy=
 mode? */</span><br><span>@@ -1896,8 +1923,8 @@</span><br><span>         AS=
SERT(sock-&gt;info.proto =3D=3D PROTO_TCP_CLIENT);</span><br><span> </span>=
<br><span>         /* the proxy server */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        sock-&gt;remote_host =3D c-&gt;c1.http_proxy-&g=
t;options.server;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    sock-&gt;remote_port =3D c-&gt;c1.http_proxy-&gt;options.port;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;remote_host=
 =3D http_proxy-&gt;options.server;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        sock-&gt;remote_port =3D http_proxy-&gt;options.por=
t;</span><br><span> </span><br><span>         /* the OpenVPN server we will=
 use the proxy to connect to */</span><br><span>         sock-&gt;proxy_des=
t_host =3D remote_host;</span><br><span>@@ -1906,9 +1933,10 @@</span><br><s=
pan>     /* or in Socks proxy mode? */</span><br><span>     else if (sock-&=
gt;socks_proxy)</span><br><span>     {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>         /* the proxy server */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;remote_host =
=3D c-&gt;c1.socks_proxy-&gt;server;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        sock-&gt;remote_port =3D c-&gt;c1.socks_proxy-&gt;po=
rt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt=
;remote_host =3D socks_proxy-&gt;server;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        sock-&gt;remote_port =3D socks_proxy-&gt;port;=
</span><br><span> </span><br><span>         /* the OpenVPN server we will u=
se the proxy to connect to */</span><br><span>         sock-&gt;proxy_dest_=
host =3D remote_host;</span><br><span>@@ -2166,22 +2194,21 @@</span><br><sp=
an> </span><br><span> /* finalize socket initialization */</span><br><span>=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_init=
_phase2(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+link_socket_init_phase2(struct context *c,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        struct link_socket *s=
ock)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct link_socket *sock =3D c-&gt;c2.link_socket;</span><br><span>  =
   const struct frame *frame =3D &amp;c-&gt;c2.frame;</span><br><span>     =
struct signal_info *sig_info =3D c-&gt;sig;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span>     const char *remote_dynamic =3D =
NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct signa=
l_info sig_save =3D {0};</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int sig_save =3D 0;</span><br><span> </span><br><span>     ASSERT(=
sock);</span><br><span>     ASSERT(sig_info);</span><br><span> </span><br><=
span>     if (sig_info-&gt;signal_received)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        sig_save =3D *sig_info=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sig_save.sig=
nal_received =3D signal_reset(sig_info, 0);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        sig_save =3D sig_info-&gt;signal_received;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sig_info-&gt=
;signal_received =3D 0;</span><br><span>     }</span><br><span> </span><br>=
<span>     /* initialize buffers */</span><br><span>@@ -2203,7 +2230,7 @@</=
span><br><span>     /* If a valid remote has been found, create the socket =
with its addrinfo */</span><br><span>     if (sock-&gt;info.lsa-&gt;current=
_remote)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined (_WIN32)</span><br><span>         if (dco_enabled(&am=
p;c-&gt;options))</span><br><span>         {</span><br><span>             c=
reate_socket_dco_win(c, sock, sig_info);</span><br><span>@@ -2214,7 +2241,6=
 @@</span><br><span>         {</span><br><span>             create_socket(s=
ock, sock-&gt;info.lsa-&gt;current_remote);</span><br><span>         }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     }</s=
pan><br><span> </span><br><span>     /* If socket has not already been crea=
ted create it now */</span><br><span>@@ -2233,7 +2259,6 @@</span><br><span>=
                     addr_family_name(sock-&gt;info.lsa-&gt;bind_local-&gt;=
ai_family));</span><br><span>                 sock-&gt;info.af =3D sock-&gt=
;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span>             }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         =
    create_socket(sock, sock-&gt;info.lsa-&gt;bind_local);</span><br><span>=
         }</span><br><span>     }</span><br><span>@@ -2242,7 +2267,7 @@</sp=
an><br><span>     if (sock-&gt;sd =3D=3D SOCKET_UNDEFINED)</span><br><span>=
     {</span><br><span>         msg(M_WARN, &quot;Could not determine IPv4/=
IPv6 protocol&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        register_signal(sig_info, SIGUSR1, &quot;Could not determine IPv4/I=
Pv6 protocol&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        sig_info-&gt;signal_received =3D SIGUSR1;</span><br><span>        =
 goto done;</span><br><span>     }</span><br><span> </span><br><span>@@ -22=
53,7 +2278,8 @@</span><br><span> </span><br><span>     if (sock-&gt;info.pr=
oto =3D=3D PROTO_TCP_SERVER)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        phase2_tcp_server(sock, remote_dyna=
mic, sig_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    phase2_tcp_server(sock, remote_dynamic,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                          sig_info);</span><br><spa=
n>     }</span><br><span>     else if (sock-&gt;info.proto =3D=3D PROTO_TCP=
_CLIENT)</span><br><span>     {</span><br><span>@@ -2279,16 +2305,11 @@</sp=
an><br><span>     linksock_print_addr(sock);</span><br><span> </span><br><s=
pan> done:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sig=
_save.signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (sig_save)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        /* Always restore the saved signal -- registe=
r/throw_signal will handle priority */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (sig_save.source =3D=3D SIG_SOURCE_HARD &amp;&a=
mp; sig_info =3D=3D &amp;siginfo_static)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (!sig_info-&gt;signal_received)</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      throw_signal(sig_save.signal_received);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   register_signal(sig_info, sig_save.signal_received, sig_save.signal_text=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sig_i=
nfo-&gt;signal_received =3D sig_save;</span><br><span>         }</span><br>=
<span>     }</span><br><span> }</span><br><span>diff --git a/src/openvpn/so=
cket.h b/src/openvpn/socket.h</span><br><span>index 39e30b8..2098333 100644=
</span><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openv=
pn/socket.h</span><br><span>@@ -329,9 +329,38 @@</span><br><span> /*</span>=
<br><span>  * Initialize link_socket object.</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void link_socket_init_phase1(st=
ruct context *c, int mode);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_so=
cket_init_phase1(struct link_socket *sock,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        const char *local_host,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
const char *local_port,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        const char *remote_host,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        const char *remot=
e_port,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            struct cached_dns_entry *dns_cache,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        int proto,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        sa_famil=
y_t af,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            bool bind_ipv6_only,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        int mode,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        const struct link_socket=
 *accept_from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   struct http_proxy_info *http_proxy,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        struct socks_pro=
xy_info *socks_proxy,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        int gremlin,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        bool bind_local,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        bool remote_float,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                        s=
truct link_socket_addr *lsa,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        const char *ipchange_command,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        const st=
ruct plugin_list *plugins,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        int resolve_retry_seconds,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        int mtu_disco=
ver_type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              int rcvbuf,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        int sndbuf,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        int mark,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        struct event_ti=
meout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        unsigned int sockflags);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-void link_socket_init_=
phase2(struct context *c);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void link_socket_init_phase2(struct context *c,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                             struct link=
_socket *sock);</span><br><span> </span><br><span> void do_preresolve(struc=
t context *c);</span><br><span> </span><br><span>@@ -1239,11 +1268,7 @@</sp=
an><br><span>  * Socket I/O wait functions</span><br><span>  */</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_read_residu=
al(const struct link_socket *s)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 s &amp;&amp; s-&gt;stream_buf.residual_fully_formed;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool sockets_read_residual(const struct context *c);</span><b=
r><span> </span><br><span> static inline event_t</span><br><span> socket_ev=
ent_handle(const struct link_socket *s)</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3D=
email">change 434</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/434?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia0a889e800f0b36aed770ee36e3=
1afeec5df6084 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 434 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
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


--GqDOsDN9DE8=--

