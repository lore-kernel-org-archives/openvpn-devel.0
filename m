From: Antonio Quartulli <a@...2181...>
Date: Thu, 26 Apr 2018 03:57:16 +0800
Message-Id: <20180425195722.20744-3-a@...2181...>
In-Reply-To: <20180425195722.20744-1-a@...2181...>
References: <20180425195722.20744-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 2/8] pass link_socket object to i/o functions
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

In order to prepare the code to work with distinct sockets,
it is essential that i/o functions do not operate on any
hard-coded socket object (i.e. c->c2.link_socket).

This patch changes all the low-level i/o functionis to work
with a socket specified as argument rather than a fixed one.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/event.h   |  1 +
 src/openvpn/forward.c | 49 ++++++++++++++++++++++---------------------
 src/openvpn/forward.h | 17 ++++++++-------
 src/openvpn/mtcp.c    |  2 +-
 src/openvpn/mudp.c    |  2 +-
 src/openvpn/multi.h   |  2 +-
 src/openvpn/openvpn.c |  2 +-
 src/openvpn/socket.c  |  1 +
 8 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 33ff8890..be199ad9 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -96,6 +96,7 @@ struct event_arg
     event_arg_t type;
     union {
         struct multi_instance *mi; /* if type = EVENT_ARG_MULTI_INSTANCE */
+        struct link_socket *ls; /* if type = EVENT_ARG_LINK_SOCKET */
     } u;
 };
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 7d9a338d..c5ddf385 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -663,9 +663,9 @@ check_timeout_random_component(struct context *c)
  */
 
 static inline void
-socks_postprocess_incoming_link(struct context *c)
+socks_postprocess_incoming_link(struct context *c, struct link_socket *ls)
 {
-    if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto == PROTO_UDP)
+    if (ls->socks_proxy && ls->info.proto == PROTO_UDP)
     {
         socks_process_incoming_udp(&c->c2.buf, &c->c2.from);
     }
@@ -673,13 +673,14 @@ socks_postprocess_incoming_link(struct context *c)
 
 static inline void
 socks_preprocess_outgoing_link(struct context *c,
+                               struct link_socket *ls,
                                struct link_socket_actual **to_addr,
                                int *size_delta)
 {
-    if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto == PROTO_UDP)
+    if (ls->socks_proxy && ls->info.proto == PROTO_UDP)
     {
         *size_delta += socks_process_outgoing_udp(&c->c2.to_link, c->c2.to_link_addr);
-        *to_addr = &c->c2.link_socket->socks_relay;
+        *to_addr = &ls->socks_relay;
     }
 }
 
@@ -704,7 +705,7 @@ link_socket_write_post_size_adjust(int *size,
  */
 
 void
-read_incoming_link(struct context *c)
+read_incoming_link(struct context *c, struct link_socket *ls)
 {
     /*
      * Set up for recvfrom call to read datagram
@@ -719,17 +720,17 @@ read_incoming_link(struct context *c)
     c->c2.buf = c->c2.buffers->read_link_buf;
     ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM_ADJ(&c->c2.frame, FRAME_HEADROOM_MARKER_READ_LINK)));
 
-    status = link_socket_read(c->c2.link_socket,
+    status = link_socket_read(ls,
                               &c->c2.buf,
                               &c->c2.from);
 
-    if (socket_connection_reset(c->c2.link_socket, status))
+    if (socket_connection_reset(ls, status))
     {
 #if PORT_SHARE
-        if (port_share && socket_foreign_protocol_detected(c->c2.link_socket))
+        if (port_share && socket_foreign_protocol_detected(ls))
         {
-            const struct buffer *fbuf = socket_foreign_protocol_head(c->c2.link_socket);
-            const int sd = socket_foreign_protocol_sd(c->c2.link_socket);
+            const struct buffer *fbuf = socket_foreign_protocol_head(ls);
+            const int sd = socket_foreign_protocol_sd(ls);
             port_share_redirect(port_share, fbuf, sd);
             register_signal(c, SIGTERM, "port-share-redirect");
         }
@@ -763,10 +764,10 @@ read_incoming_link(struct context *c)
     }
 
     /* check recvfrom status */
-    check_status(status, "read", c->c2.link_socket, NULL);
+    check_status(status, "read", ls, NULL);
 
     /* Remove socks header if applicable */
-    socks_postprocess_incoming_link(c);
+    socks_postprocess_incoming_link(c, ls);
 
     perf_pop();
 }
@@ -996,11 +997,11 @@ process_incoming_link_part2(struct context *c, struct link_socket_info *lsi, con
 }
 
 static void
-process_incoming_link(struct context *c)
+process_incoming_link(struct context *c, struct link_socket *ls)
 {
     perf_push(PERF_PROC_IN_LINK);
 
-    struct link_socket_info *lsi = get_link_socket_info(c);
+    struct link_socket_info *lsi = &ls->info;
     const uint8_t *orig_buf = c->c2.buf.data;
 
     process_incoming_link_part1(c, lsi, false);
@@ -1293,7 +1294,7 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
  */
 
 void
-process_outgoing_link(struct context *c)
+process_outgoing_link(struct context *c, struct link_socket *ls)
 {
     struct gc_arena gc = gc_new();
     int error_code = 0;
@@ -1335,7 +1336,7 @@ process_outgoing_link(struct context *c)
 
 #if PASSTOS_CAPABILITY
             /* Set TOS */
-            link_socket_set_tos(c->c2.link_socket);
+            link_socket_set_tos(ls);
 #endif
 
             /* Log packet send */
@@ -1346,7 +1347,7 @@ process_outgoing_link(struct context *c)
             }
 #endif
             msg(D_LINK_RW, "%s WRITE [%d] to %s: %s",
-                proto2ascii(c->c2.link_socket->info.proto, c->c2.link_socket->info.af, true),
+                proto2ascii(ls->info.proto, ls->info.af, true),
                 BLEN(&c->c2.to_link),
                 print_link_socket_actual(c->c2.to_link_addr, &gc),
                 PROTO_DUMP(&c->c2.to_link, &gc));
@@ -1357,10 +1358,10 @@ process_outgoing_link(struct context *c)
                 int size_delta = 0;
 
                 /* If Socks5 over UDP, prepend header */
-                socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
+                socks_preprocess_outgoing_link(c, ls, &to_addr, &size_delta);
 
                 /* Send packet */
-                size = link_socket_write(c->c2.link_socket,
+                size = link_socket_write(ls,
                                          &c->c2.to_link,
                                          to_addr);
 
@@ -1393,7 +1394,7 @@ process_outgoing_link(struct context *c)
 
         /* Check return status */
         error_code = openvpn_errno();
-        check_status(size, "write", c->c2.link_socket, NULL);
+        check_status(size, "write", ls, NULL);
 
         if (size > 0)
         {
@@ -1797,7 +1798,7 @@ io_wait_dowork(struct context *c, const unsigned int flags)
 }
 
 void
-process_io(struct context *c)
+process_io(struct context *c, struct link_socket *ls)
 {
     const unsigned int status = c->c2.event_set_status;
 
@@ -1812,7 +1813,7 @@ process_io(struct context *c)
     /* TCP/UDP port ready to accept write */
     if (status & SOCKET_WRITE)
     {
-        process_outgoing_link(c);
+        process_outgoing_link(c, ls);
     }
     /* TUN device ready to accept write */
     else if (status & TUN_WRITE)
@@ -1822,10 +1823,10 @@ process_io(struct context *c)
     /* Incoming data on TCP/UDP port */
     else if (status & SOCKET_READ)
     {
-        read_incoming_link(c);
+        read_incoming_link(c, ls);
         if (!IS_SIG(c))
         {
-            process_incoming_link(c);
+            process_incoming_link(c, ls);
         }
     }
     /* Incoming data on TUN device */
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 924cc5e2..16639f75 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -63,7 +63,8 @@
 
 void pre_select(struct context *c);
 
-void process_io(struct context *c);
+void process_io(struct context *ci, struct link_socket *ls);
+
 
 const char *wait_status_string(struct context *c, struct gc_arena *gc);
 
@@ -124,10 +125,11 @@ int get_server_poll_remaining_time(struct event_timeout *server_poll_timeout);
  * context associated with the appropriate VPN tunnel for which data is
  * available to be read.
  *
- * @param c - The context structure which contains the external
- *     network socket from which to read incoming packets.
+ * @param c    The context structure which contains the external
+ *             network socket from which to read incoming packets.
+ * @param ls   The socket where the packet can be read from.
  */
-void read_incoming_link(struct context *c);
+void read_incoming_link(struct context *c, struct link_socket *ls);
 
 /**
  * Starts processing a packet read from the external network interface.
@@ -193,10 +195,11 @@ void process_incoming_link_part2(struct context *c, struct link_socket_info *lsi
  *
  * If an error occurs, it is logged and the packet is dropped.
  *
- * @param c - The context structure of the VPN tunnel associated with the
- *     packet.
+ * @param c   The context structure of the VPN tunnel associated with the
+ *            packet.
+ * @param ls  The socket to be used to send the packet.
  */
-void process_outgoing_link(struct context *c);
+void process_outgoing_link(struct context *c, struct link_socket *ls);
 
 
 /**************************************************************************/
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 234c077c..51f339d0 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -470,7 +470,7 @@ multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int
             ASSERT(mi);
             ASSERT(mi->context.c2.link_socket);
             set_prefix(mi);
-            read_incoming_link(&mi->context);
+            read_incoming_link(&mi->context, mi->context.c2.link_socket);
             clear_prefix();
             if (!IS_SIG(&mi->context))
             {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b3690ab7..80efefb3 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -227,7 +227,7 @@ multi_process_io_udp(struct multi_context *m)
     /* Incoming data on UDP port */
     else if (status & SOCKET_READ)
     {
-        read_incoming_link(&m->top);
+        read_incoming_link(&m->top, m->top.c2.link_socket);
         if (!IS_SIG(&m->top))
         {
             multi_process_incoming_link(m, NULL, mpp_flags);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index c52445ed..5fb8402f 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -637,7 +637,7 @@ multi_process_outgoing_link_dowork(struct multi_context *m, struct multi_instanc
 {
     bool ret = true;
     set_prefix(mi);
-    process_outgoing_link(&mi->context);
+    process_outgoing_link(&mi->context, mi->context.c2.link_socket);
     ret = multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index b9e914a8..b52063a2 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -115,7 +115,7 @@ tunnel_point_to_point(struct context *c)
         }
 
         /* process the I/O which triggered select */
-        process_io(c);
+        process_io(c, c->c2.link_socket);
         P2P_CHECK_SIG();
 
         perf_pop();
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index e0620f09..564948a2 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1713,6 +1713,7 @@ link_socket_new(void)
     sock->sd = SOCKET_UNDEFINED;
     sock->ctrl_sd = SOCKET_UNDEFINED;
     sock->ev_arg.type = EVENT_ARG_LINK_SOCKET;
+    sock->ev_arg.u.ls = sock;
 
     return sock;
 }
-- 
2.17.0


