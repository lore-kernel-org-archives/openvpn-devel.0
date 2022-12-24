From: Arne Schwabe <arne@...1227...>
Date: Sat, 24 Dec 2022 20:42:47 +0100
Message-Id: <20221224194253.3202231-4-arne@...1227...>
In-Reply-To: <20221224194253.3202231-1-arne@...1227...>
References: <20221224194253.3202231-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/9] Move dco_installed back to link_socket
 from link_socket.info.actual
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

this change was done in order to be able to differentiate when needing to
use dco and when to use normal socket sendto. Since we want to eventually
completely use the userspace sockets for sending/receiving, we just switch
to always use UDP sendto even if the socket is already installed in the
kernel.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco.c     | 23 ++---------------------
 src/openvpn/forward.c | 13 +++++++------
 src/openvpn/init.c    |  2 +-
 src/openvpn/mtcp.c    |  6 +++---
 src/openvpn/socket.c  |  8 ++++----
 src/openvpn/socket.h  | 11 +++++------
 6 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 993265188..2f4d0f779 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -456,22 +456,6 @@ dco_check_pull_options(int msglevel, const struct options *o)
     return true;
 }
 
-static void
-addr_set_dco_installed(struct context *c)
-{
-    /* We ensure that all addresses we currently hold have the dco_installed
-     * bit set */
-    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
-    {
-        struct key_state *ks = get_key_scan(c->c2.tls_multi, i);
-        if (ks)
-        {
-            ks->remote_addr.dco_installed = true;
-        }
-    }
-    get_link_socket_info(c)->lsa->actual.dco_installed = true;
-}
-
 int
 dco_p2p_add_new_peer(struct context *c)
 {
@@ -484,8 +468,6 @@ dco_p2p_add_new_peer(struct context *c)
 
     ASSERT(ls->info.connection_established);
 
-    addr_set_dco_installed(c);
-
     struct sockaddr *remoteaddr = &ls->info.lsa->actual.dest.addr.sa;
     struct tls_multi *multi = c->c2.tls_multi;
 #ifdef TARGET_FREEBSD
@@ -505,7 +487,7 @@ dco_p2p_add_new_peer(struct context *c)
     }
 
     c->c2.tls_multi->dco_peer_id = multi->peer_id;
-    c->c2.link_socket->info.lsa->actual.dco_installed = true;
+    c->c2.link_socket->dco_installed = true;
 
     return 0;
 }
@@ -595,7 +577,6 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
         ASSERT(c->c2.link_socket_info->connection_established);
         remoteaddr = &c->c2.link_socket_info->lsa->actual.dest.addr.sa;
     }
-    addr_set_dco_installed(c);
 
     /* In server mode we need to fetch the remote addresses from the push config */
     struct in_addr vpn_ip4 = { 0 };
@@ -633,7 +614,7 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
         {
             msg(D_DCO|M_ERRNO, "error closing TCP socket after DCO handover");
         }
-        c->c2.link_socket->info.lsa->actual.dco_installed = true;
+        c->c2.link_socket->dco_installed = true;
         c->c2.link_socket->sd = SOCKET_UNDEFINED;
     }
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index c04511ee1..64c8ee6a0 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1674,9 +1674,10 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
     }
 }
 
-/* Linux DCO implementations pass the socket to the kernel and
- * disallow usage of it from userland, so (control) packets sent and
- * received by OpenVPN need to go through the DCO interface.
+/*
+ * Linux DCO implementations pass the socket to the kernel and
+ * disallow usage of it from userland for TCP, so (control) packets
+ * sent and received by OpenVPN need to go through the DCO interface.
  *
  * Windows DCO needs control packets to be sent via the normal
  * standard Overlapped I/O.
@@ -1688,10 +1689,10 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
  * in the future...) in a small inline function.
  */
 static inline bool
-should_use_dco_socket(struct link_socket_actual *actual)
+should_use_dco_socket(struct link_socket *ls)
 {
 #if defined(TARGET_LINUX)
-    return actual->dco_installed;
+    return ls->dco_installed && proto_is_tcp(ls->info.proto);
 #else
     return false;
 #endif
@@ -1770,7 +1771,7 @@ process_outgoing_link(struct context *c)
                 socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
 
                 /* Send packet */
-                if (should_use_dco_socket(c->c2.to_link_addr))
+                if (should_use_dco_socket(c->c2.link_socket))
                 {
                     size = dco_do_write(&c->c1.tuntap->dco,
                                         c->c2.tls_multi->dco_peer_id,
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 409a8be2a..3380ed9e6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3696,7 +3696,7 @@ do_close_link_socket(struct context *c)
      * closed in do_close_tun(). Set it to UNDEFINED so
      * we won't use WinSock API to close it. */
     if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_socket
-        && c->c2.link_socket->info.lsa->actual.dco_installed)
+        && c->c2.link_socket->dco_installed)
     {
         c->c2.link_socket->sd = SOCKET_UNDEFINED;
     }
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 07da15a6d..ac06ddc64 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -402,7 +402,7 @@ multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, const in
 
     tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
 
-    if (mi && mi->context.c2.link_socket->info.lsa->actual.dco_installed)
+    if (mi && mi->context.c2.link_socket->dco_installed)
     {
         /* If we got a socket that has been handed over to the kernel
          * we must not call the normal socket function to figure out
@@ -537,7 +537,7 @@ multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int
 
         case TA_INITIAL:
             ASSERT(mi);
-            if (!mi->context.c2.link_socket->info.lsa->actual.dco_installed)
+            if (!mi->context.c2.link_socket->dco_installed)
             {
                 multi_tcp_set_global_rw_flags(m, mi);
             }
@@ -590,7 +590,7 @@ multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act
             }
             else
             {
-                if (!c->c2.link_socket->info.lsa->actual.dco_installed)
+                if (!c->c2.link_socket->dco_installed)
                 {
                     multi_tcp_set_global_rw_flags(m, mi);
                 }
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 82787f9f2..c7ec0e06d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2147,7 +2147,7 @@ create_socket_dco_win(struct context *c, struct link_socket *sock,
                       get_server_poll_remaining_time(sock->server_poll_timeout),
                       signal_received);
 
-    sock->info.lsa->actual.dco_installed = true;
+    sock->dco_installed = true;
 
     if (*signal_received)
     {
@@ -3480,7 +3480,7 @@ link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
 static int
 socket_get_last_error(const struct link_socket *sock)
 {
-    if (sock->info.lsa->actual.dco_installed)
+    if (sock->dco_installed)
     {
         return GetLastError();
     }
@@ -3521,7 +3521,7 @@ socket_recv_queue(struct link_socket *sock, int maxsize)
         ASSERT(ResetEvent(sock->reads.overlapped.hEvent));
         sock->reads.flags = 0;
 
-        if (sock->info.lsa->actual.dco_installed)
+        if (sock->dco_installed)
         {
             status = ReadFile((HANDLE)sock->sd, wsabuf[0].buf, wsabuf[0].len,
                               &sock->reads.size, &sock->reads.overlapped);
@@ -3626,7 +3626,7 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
         ASSERT(ResetEvent(sock->writes.overlapped.hEvent));
         sock->writes.flags = 0;
 
-        if (sock->info.lsa->actual.dco_installed)
+        if (sock->dco_installed)
         {
             status = WriteFile((HANDLE)sock->sd, wsabuf[0].buf, wsabuf[0].len,
                                &sock->writes.size, &sock->writes.overlapped);
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 929ef8187..05c31b104 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -88,7 +88,6 @@ struct link_socket_actual
     /*int dummy;*/ /* add offset to force a bug if dest not explicitly dereferenced */
 
     struct openvpn_sockaddr dest;
-    bool dco_installed;
 #if ENABLE_IP_PKTINFO
     union {
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
@@ -169,6 +168,7 @@ struct link_socket
 
     socket_descriptor_t sd;
     socket_descriptor_t ctrl_sd; /* only used for UDP over Socks */
+    bool dco_installed;
 
 #ifdef _WIN32
     struct overlapped_io reads;
@@ -1036,7 +1036,7 @@ link_socket_read_udp_win32(struct link_socket *sock,
                            struct link_socket_actual *from)
 {
     sockethandle_t sh = { .s = sock->sd };
-    if (sock->info.lsa->actual.dco_installed)
+    if (sock->dco_installed)
     {
         *from = sock->info.lsa->actual;
         sh.is_handle = true;
@@ -1058,8 +1058,7 @@ link_socket_read(struct link_socket *sock,
                  struct buffer *buf,
                  struct link_socket_actual *from)
 {
-    if (proto_is_udp(sock->info.proto)
-        || sock->info.lsa->actual.dco_installed)
+    if (proto_is_udp(sock->info.proto) || sock->dco_installed)
     /* unified UDPv4 and UDPv6, for DCO the kernel
      * will strip the length header */
     {
@@ -1102,7 +1101,7 @@ link_socket_write_win32(struct link_socket *sock,
 {
     int err = 0;
     int status = 0;
-    sockethandle_t sh = { .s = sock->sd, .is_handle = sock->info.lsa->actual.dco_installed };
+    sockethandle_t sh = { .s = sock->sd, .is_handle = sock->dco_installed };
     if (overlapped_io_active(&sock->writes))
     {
         status = sockethandle_finalize(sh, &sock->writes, NULL, NULL);
@@ -1176,7 +1175,7 @@ link_socket_write(struct link_socket *sock,
                   struct buffer *buf,
                   struct link_socket_actual *to)
 {
-    if (proto_is_udp(sock->info.proto) || to->dco_installed)
+    if (proto_is_udp(sock->info.proto) || sock->dco_installed)
     {
         /* unified UDPv4 and UDPv6 and DCO (kernel adds size header) */
         return link_socket_write_udp(sock, buf, to);
-- 
2.37.1 (Apple Git-137.1)


