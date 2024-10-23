From: Gert Doering <gert@...1296...>
Date: Wed, 23 Oct 2024 10:34:44 +0200
Message-ID: <20241023083444.27951-1-gert@...1296...>
In-Reply-To: <gerrit.1727098847000.I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d@...2715...>
References: <gerrit.1727098847000.I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] pass link_socket object to i/o functions
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

In order to prepare the code to work with distinct sockets,
it is essential that i/o functions do not operate on any
hard-coded socket object (i.e. c->c2.link_socket).

This patch changes all the low-level i/o functionis to work
with a socket specified as argument rather than a fixed one.

Change-Id: I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/758
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 844ea7b..b3ba183 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -137,6 +137,7 @@
     event_arg_t type;
     union {
         struct multi_instance *mi; /* if type = EVENT_ARG_MULTI_INSTANCE */
+        struct link_socket *sock; /* if type = EVENT_ARG_LINK_SOCKET */
     } u;
 };
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6df01d1..6f279ec 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -884,9 +884,9 @@
  */
 
 static inline void
-socks_postprocess_incoming_link(struct context *c)
+socks_postprocess_incoming_link(struct context *c, struct link_socket *sock)
 {
-    if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto == PROTO_UDP)
+    if (sock->socks_proxy && sock->info.proto == PROTO_UDP)
     {
         socks_process_incoming_udp(&c->c2.buf, &c->c2.from);
     }
@@ -894,13 +894,14 @@
 
 static inline void
 socks_preprocess_outgoing_link(struct context *c,
+                               struct link_socket *sock,
                                struct link_socket_actual **to_addr,
                                int *size_delta)
 {
-    if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto == PROTO_UDP)
+    if (sock->socks_proxy && sock->info.proto == PROTO_UDP)
     {
         *size_delta += socks_process_outgoing_udp(&c->c2.to_link, c->c2.to_link_addr);
-        *to_addr = &c->c2.link_socket->socks_relay;
+        *to_addr = &sock->socks_relay;
     }
 }
 
@@ -925,7 +926,7 @@
  */
 
 void
-read_incoming_link(struct context *c)
+read_incoming_link(struct context *c, struct link_socket *sock)
 {
     /*
      * Set up for recvfrom call to read datagram
@@ -940,17 +941,17 @@
     c->c2.buf = c->c2.buffers->read_link_buf;
     ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));
 
-    status = link_socket_read(c->c2.link_socket,
+    status = link_socket_read(sock,
                               &c->c2.buf,
                               &c->c2.from);
 
-    if (socket_connection_reset(c->c2.link_socket, status))
+    if (socket_connection_reset(sock, status))
     {
 #if PORT_SHARE
-        if (port_share && socket_foreign_protocol_detected(c->c2.link_socket))
+        if (port_share && socket_foreign_protocol_detected(sock))
         {
-            const struct buffer *fbuf = socket_foreign_protocol_head(c->c2.link_socket);
-            const int sd = socket_foreign_protocol_sd(c->c2.link_socket);
+            const struct buffer *fbuf = socket_foreign_protocol_head(sock);
+            const int sd = socket_foreign_protocol_sd(sock);
             port_share_redirect(port_share, fbuf, sd);
             register_signal(c->sig, SIGTERM, "port-share-redirect");
         }
@@ -977,7 +978,7 @@
     bool dco_win_timeout = tuntap_is_dco_win_timeout(c->c1.tuntap, status);
 
     /* check recvfrom status */
-    check_status(status, "read", c->c2.link_socket, NULL);
+    check_status(status, "read", sock, NULL);
 
     if (dco_win_timeout)
     {
@@ -985,7 +986,7 @@
     }
 
     /* Remove socks header if applicable */
-    socks_postprocess_incoming_link(c);
+    socks_postprocess_incoming_link(c, sock);
 
     perf_pop();
 }
@@ -1222,11 +1223,11 @@
 }
 
 static void
-process_incoming_link(struct context *c)
+process_incoming_link(struct context *c, struct link_socket *sock)
 {
     perf_push(PERF_PROC_IN_LINK);
 
-    struct link_socket_info *lsi = get_link_socket_info(c);
+    struct link_socket_info *lsi = &sock->info;
     const uint8_t *orig_buf = c->c2.buf.data;
 
     process_incoming_link_part1(c, lsi, false);
@@ -1732,7 +1733,7 @@
  */
 
 void
-process_outgoing_link(struct context *c)
+process_outgoing_link(struct context *c, struct link_socket *sock)
 {
     struct gc_arena gc = gc_new();
     int error_code = 0;
@@ -1775,7 +1776,7 @@
 
 #if PASSTOS_CAPABILITY
             /* Set TOS */
-            link_socket_set_tos(c->c2.link_socket);
+            link_socket_set_tos(sock);
 #endif
 
             /* Log packet send */
@@ -1786,7 +1787,7 @@
             }
 #endif
             msg(D_LINK_RW, "%s WRITE [%d] to %s: %s",
-                proto2ascii(c->c2.link_socket->info.proto, c->c2.link_socket->info.af, true),
+                proto2ascii(sock->info.proto, sock->info.af, true),
                 BLEN(&c->c2.to_link),
                 print_link_socket_actual(c->c2.to_link_addr, &gc),
                 PROTO_DUMP(&c->c2.to_link, &gc));
@@ -1797,10 +1798,12 @@
                 int size_delta = 0;
 
                 /* If Socks5 over UDP, prepend header */
-                socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
+                socks_preprocess_outgoing_link(c, sock, &to_addr, &size_delta);
 
                 /* Send packet */
-                size = (int)link_socket_write(c->c2.link_socket, &c->c2.to_link, to_addr);
+                size = (int)link_socket_write(sock,
+                                              &c->c2.to_link,
+                                              to_addr);
 
                 /* Undo effect of prepend */
                 link_socket_write_post_size_adjust(&size, size_delta, &c->c2.to_link);
@@ -1829,7 +1832,7 @@
 
         /* Check return status */
         error_code = openvpn_errno();
-        check_status(size, "write", c->c2.link_socket, NULL);
+        check_status(size, "write", sock, NULL);
 
         if (size > 0)
         {
@@ -2272,7 +2275,7 @@
 }
 
 void
-process_io(struct context *c)
+process_io(struct context *c, struct link_socket *sock)
 {
     const unsigned int status = c->c2.event_set_status;
 
@@ -2287,7 +2290,7 @@
     /* TCP/UDP port ready to accept write */
     if (status & SOCKET_WRITE)
     {
-        process_outgoing_link(c);
+        process_outgoing_link(c, sock);
     }
     /* TUN device ready to accept write */
     else if (status & TUN_WRITE)
@@ -2297,10 +2300,10 @@
     /* Incoming data on TCP/UDP port */
     else if (status & SOCKET_READ)
     {
-        read_incoming_link(c);
+        read_incoming_link(c, sock);
         if (!IS_SIG(c))
         {
-            process_incoming_link(c);
+            process_incoming_link(c, sock);
         }
     }
     /* Incoming data on TUN device */
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 422c591..8ef19b4 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -72,7 +72,8 @@
 
 void pre_select(struct context *c);
 
-void process_io(struct context *c);
+void process_io(struct context *c, struct link_socket *sock);
+
 
 /**********************************************************************/
 /**
@@ -128,10 +129,11 @@
  * context associated with the appropriate VPN tunnel for which data is
  * available to be read.
  *
- * @param c - The context structure which contains the external
- *     network socket from which to read incoming packets.
+ * @param c    The context structure which contains the external
+ *             network socket from which to read incoming packets.
+ * @param sock   The socket where the packet can be read from.
  */
-void read_incoming_link(struct context *c);
+void read_incoming_link(struct context *c, struct link_socket *sock);
 
 /**
  * Starts processing a packet read from the external network interface.
@@ -197,10 +199,11 @@
  *
  * If an error occurs, it is logged and the packet is dropped.
  *
- * @param c - The context structure of the VPN tunnel associated with the
- *     packet.
+ * @param c   The context structure of the VPN tunnel associated with the
+ *            packet.
+ * @param sock  The socket to be used to send the packet.
  */
-void process_outgoing_link(struct context *c);
+void process_outgoing_link(struct context *c, struct link_socket *sock);
 
 
 /**************************************************************************/
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index c002a38..1b956f4 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -483,7 +483,7 @@
             ASSERT(mi);
             ASSERT(mi->context.c2.link_socket);
             set_prefix(mi);
-            read_incoming_link(&mi->context);
+            read_incoming_link(&mi->context, mi->context.c2.link_socket);
             clear_prefix();
             if (!IS_SIG(&mi->context))
             {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 268b430..5fbd7b0 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -317,7 +317,7 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link = m->hmac_reply;
         m->top.c2.to_link_addr = m->hmac_reply_dest;
-        process_outgoing_link(&m->top);
+        process_outgoing_link(&m->top, m->top.c2.link_socket);
         m->hmac_reply_dest = NULL;
     }
 }
@@ -380,7 +380,7 @@
     /* Incoming data on UDP port */
     else if (status & SOCKET_READ)
     {
-        read_incoming_link(&m->top);
+        read_incoming_link(&m->top, m->top.c2.link_socket);
         if (!IS_SIG(&m->top))
         {
             multi_process_incoming_link(m, NULL, mpp_flags);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 1b99ef7..f386a3b 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -683,7 +683,7 @@
 {
     bool ret = true;
     set_prefix(mi);
-    process_outgoing_link(&mi->context);
+    process_outgoing_link(&mi->context, mi->context.c2.link_socket);
     ret = multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 16147b7..1db5422 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -91,7 +91,7 @@
         }
 
         /* process the I/O which triggered select */
-        process_io(c);
+        process_io(c, c->c2.link_socket);
         P2P_CHECK_SIG();
 
         perf_pop();
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index cf04090..efd742c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -969,12 +969,12 @@
 }
 
 bool
-link_socket_update_flags(struct link_socket *ls, unsigned int sockflags)
+link_socket_update_flags(struct link_socket *sock, unsigned int sockflags)
 {
-    if (ls && socket_defined(ls->sd))
+    if (sock && socket_defined(sock->sd))
     {
-        ls->sockflags |= sockflags;
-        return socket_set_flags(ls->sd, ls->sockflags);
+        sock->sockflags |= sockflags;
+        return socket_set_flags(sock->sd, sock->sockflags);
     }
     else
     {
@@ -983,13 +983,13 @@
 }
 
 void
-link_socket_update_buffer_sizes(struct link_socket *ls, int rcvbuf, int sndbuf)
+link_socket_update_buffer_sizes(struct link_socket *sock, int rcvbuf, int sndbuf)
 {
-    if (ls && socket_defined(ls->sd))
+    if (sock && socket_defined(sock->sd))
     {
-        ls->socket_buffer_sizes.sndbuf = sndbuf;
-        ls->socket_buffer_sizes.rcvbuf = rcvbuf;
-        socket_set_buffers(ls->sd, &ls->socket_buffer_sizes, true);
+        sock->socket_buffer_sizes.sndbuf = sndbuf;
+        sock->socket_buffer_sizes.rcvbuf = rcvbuf;
+        socket_set_buffers(sock->sd, &sock->socket_buffer_sizes, true);
     }
 }
 
@@ -1831,6 +1831,7 @@
     sock->sd = SOCKET_UNDEFINED;
     sock->ctrl_sd = SOCKET_UNDEFINED;
     sock->ev_arg.type = EVENT_ARG_LINK_SOCKET;
+    sock->ev_arg.u.sock = sock;
 
     return sock;
 }
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index c152ab0..566efee 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -461,9 +461,9 @@
 
 void setenv_trusted(struct env_set *es, const struct link_socket_info *info);
 
-bool link_socket_update_flags(struct link_socket *ls, unsigned int sockflags);
+bool link_socket_update_flags(struct link_socket *sock, unsigned int sockflags);
 
-void link_socket_update_buffer_sizes(struct link_socket *ls, int rcvbuf, int sndbuf);
+void link_socket_update_buffer_sizes(struct link_socket *sock, int rcvbuf, int sndbuf);
 
 /*
  * Low-level functions
@@ -1225,13 +1225,13 @@
  * Extract TOS bits.  Assumes that ipbuf is a valid IPv4 packet.
  */
 static inline void
-link_socket_extract_tos(struct link_socket *ls, const struct buffer *ipbuf)
+link_socket_extract_tos(struct link_socket *sock, const struct buffer *ipbuf)
 {
-    if (ls && ipbuf)
+    if (sock && ipbuf)
     {
         struct openvpn_iphdr *iph = (struct openvpn_iphdr *) BPTR(ipbuf);
-        ls->ptos = iph->tos;
-        ls->ptos_defined = true;
+        sock->ptos = iph->tos;
+        sock->ptos_defined = true;
     }
 }
 
@@ -1240,11 +1240,11 @@
  * from tunnel packet.
  */
 static inline void
-link_socket_set_tos(struct link_socket *ls)
+link_socket_set_tos(struct link_socket *sock)
 {
-    if (ls && ls->ptos_defined)
+    if (sock && sock->ptos_defined)
     {
-        setsockopt(ls->sd, IPPROTO_IP, IP_TOS, (const void *)&ls->ptos, sizeof(ls->ptos));
+        setsockopt(sock->sd, IPPROTO_IP, IP_TOS, (const void *)&sock->ptos, sizeof(sock->ptos));
     }
 }
 
@@ -1255,50 +1255,50 @@
  */
 
 static inline bool
-socket_read_residual(const struct link_socket *s)
+socket_read_residual(const struct link_socket *sock)
 {
-    return s && s->stream_buf.residual_fully_formed;
+    return sock && sock->stream_buf.residual_fully_formed;
 }
 
 static inline event_t
-socket_event_handle(const struct link_socket *s)
+socket_event_handle(const struct link_socket *sock)
 {
 #ifdef _WIN32
-    return &s->rw_handle;
+    return &sock->rw_handle;
 #else
-    return s->sd;
+    return sock->sd;
 #endif
 }
 
-event_t socket_listen_event_handle(struct link_socket *s);
+event_t socket_listen_event_handle(struct link_socket *sock);
 
 unsigned int
-socket_set(struct link_socket *s,
+socket_set(struct link_socket *sock,
            struct event_set *es,
            unsigned int rwflags,
            void *arg,
            unsigned int *persistent);
 
 static inline void
-socket_set_listen_persistent(struct link_socket *s,
+socket_set_listen_persistent(struct link_socket *sock,
                              struct event_set *es,
                              void *arg)
 {
-    if (s && !s->listen_persistent_queued)
+    if (sock && !sock->listen_persistent_queued)
     {
-        event_ctl(es, socket_listen_event_handle(s), EVENT_READ, arg);
-        s->listen_persistent_queued = true;
+        event_ctl(es, socket_listen_event_handle(sock), EVENT_READ, arg);
+        sock->listen_persistent_queued = true;
     }
 }
 
 static inline void
-socket_reset_listen_persistent(struct link_socket *s)
+socket_reset_listen_persistent(struct link_socket *sock)
 {
 #ifdef _WIN32
-    reset_net_event_win32(&s->listen_handle, s->sd);
+    reset_net_event_win32(&sock->listen_handle, sock->sd);
 #endif
 }
 
-const char *socket_stat(const struct link_socket *s, unsigned int rwflags, struct gc_arena *gc);
+const char *socket_stat(const struct link_socket *sock, unsigned int rwflags, struct gc_arena *gc);
 
 #endif /* SOCKET_H */

