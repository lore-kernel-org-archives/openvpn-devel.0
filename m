From: Gert Doering <gert@...1296...>
Date: Sun, 25 Dec 2022 00:08:07 +0100
Message-Id: <20221224230807.1827964-1-gert@...1296...>
In-Reply-To: <20221222095349.1662685-1-gert@...1296...>
References: <20221222095349.1662685-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] bandaid fix for TCP multipoint server
 crash with Linux-DCO
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

TCP multipoint servers with Linux-DCO can crash under yet-unknown
circumstances where a TCP socket gets handed to the kernel (= userland
shall not acceess it again) but the socket still lands in the event
polling mechanism, and is passed to link_socket_read() with
sock->fd being "-1" (SOCKET_UNDEFINED).

This is a bug, but it happens very unfrequently so not fixed yet.

When this happens, the server gets stuck in an endless loop of
"trying recvfrom(-1, ..), getting an error, looging that error,
continue" until the server's disk is full.

The situation is being made a bit more complex by the dco-win
approach of treating "all kernel sockets as UDP", so the Linux
implementation tries to access the -1 socket as UDP, confusing
the picture more.

As a bandaid to avoid the crash, this patch changes

 - socket.h: only do the "if dco_installed, treat as UDP" for WIN32
   (link_socket_read())

 - socket.c: add ASSERT(sock->fd >= 0); checks to all UDP socket paths
   (we should never even hit those as this is a TCP specific problem,
   but in the "sock->fd = -1" case, doing a clean server abort is
   preferred to "the disk is full with non-helpful logfiles, and then
   the server crashes anyway")

 - socket.c: in the TCP read function, link_socket_read_tcp(),
   check for sock->fd < 0 and trigger "sock->stream_reset = true"
   (+ write to the log what happened).

This change will kill this particular TCP client instance (SIGTERM),
but leave the rest of the server running fine - and given that
in our tests this issue seems to be triggered by inbound TCP RST
in just the wrong moment, it seems to be "a properly-sized bandaid".

v2: rebase on top of "move dco_installed back to link_socket"

Github: OpenVPN/openvpn#190

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 12 ++++++++++++
 src/openvpn/socket.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c7ec0e06..2e5f29bf 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3226,6 +3226,13 @@ link_socket_read_tcp(struct link_socket *sock,
 {
     int len = 0;
 
+    if (sock->sd == SOCKET_UNDEFINED)           /* DCO mishap */
+    {
+        msg(M_INFO, "BUG: link_socket_read_tcp(): sock->sd==-1, reset client instance" );
+        sock->stream_reset = true;              /* reset client instance */
+        return buf->len = 0;                    /* nothing to read */
+    }
+
     if (!sock->stream_buf.residual_fully_formed)
     {
 #ifdef _WIN32
@@ -3285,6 +3292,8 @@ link_socket_read_udp_posix_recvmsg(struct link_socket *sock,
     struct msghdr mesg;
     socklen_t fromlen = sizeof(from->dest.addr);
 
+    ASSERT(sock->sd >= 0);                      /* can't happen */
+
     iov.iov_base = BPTR(buf);
     iov.iov_len = buf_forward_capacity_total(buf);
     mesg.msg_iov = &iov;
@@ -3351,6 +3360,9 @@ link_socket_read_udp_posix(struct link_socket *sock,
     socklen_t fromlen = sizeof(from->dest.addr);
     socklen_t expectedlen = af_addr_size(sock->info.af);
     addr_zero_host(&from->dest);
+
+    ASSERT(sock->sd >= 0);                      /* can't happen */
+
 #if ENABLE_IP_PKTINFO
     /* Both PROTO_UDPv4 and PROTO_UDPv6 */
     if (sock->info.proto == PROTO_UDP && sock->sockflags & SF_USE_IP_PKTINFO)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 05c31b10..3b9c1ba3 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1058,7 +1058,11 @@ link_socket_read(struct link_socket *sock,
                  struct buffer *buf,
                  struct link_socket_actual *from)
 {
+#ifdef _WIN32
     if (proto_is_udp(sock->info.proto) || sock->dco_installed)
+#else
+    if (proto_is_udp(sock->info.proto))
+#endif
     /* unified UDPv4 and UDPv6, for DCO the kernel
      * will strip the length header */
     {
-- 
2.25.1


