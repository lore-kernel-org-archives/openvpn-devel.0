From: Steffan Karger <steffan@...1856...>
Date: Mon, 29 Feb 2016 20:02:13 +0100
Message-Id: <1456772533-7654-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Don't limit max incoming message size based
	on c2->frame
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

"Be conservative in what you send, be liberal in what you accept"

When receiving packets, the real limitation of how much data we can accept
is the size of our internal buffers, not the maximum size we expect
incoming packets to have.

I ran into this while working on cipher negotiation, which will need
separate bookkeeping for the required internal buffer size, and the
link/tun MTU.  Basing this code on the buffer size instead of c2->frame
makes that easier.  A nice side-effect of this change is that it
simplifies the code.

This should also reduce the impact of using asymmetric tun/link MTU's,
such as in trac ticket #647.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/forward.c | 1 -
 src/openvpn/socket.c  | 9 +++------
 src/openvpn/socket.h  | 4 +---
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 4a91f92..2c9a082 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -669,7 +669,6 @@ read_incoming_link (struct context *c)
 
   status = link_socket_read (c->c2.link_socket,
 			     &c->c2.buf,
-			     MAX_RW_SIZE_LINK (&c->c2.frame),
 			     &c->c2.from);
 
   if (socket_connection_reset (c->c2.link_socket, status))
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 714a847..040b27d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2880,7 +2880,6 @@ union openvpn_pktinfo {
 static socklen_t
 link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
 				    struct buffer *buf,
-				    int maxsize,
 				    struct link_socket_actual *from)
 {
   struct iovec iov;
@@ -2889,7 +2888,7 @@ link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
   socklen_t fromlen = sizeof (from->dest.addr);
 
   iov.iov_base = BPTR (buf);
-  iov.iov_len = maxsize;
+  iov.iov_len = buf_forward_capacity_total (buf);
   mesg.msg_iov = &iov;
   mesg.msg_iovlen = 1;
   mesg.msg_name = &from->dest.addr;
@@ -2948,20 +2947,18 @@ link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
 int
 link_socket_read_udp_posix (struct link_socket *sock,
 			    struct buffer *buf,
-			    int maxsize,
 			    struct link_socket_actual *from)
 {
   socklen_t fromlen = sizeof (from->dest.addr);
   socklen_t expectedlen = af_addr_size(sock->info.af);
   addr_zero_host(&from->dest);
-  ASSERT (buf_safe (buf, maxsize));
 #if ENABLE_IP_PKTINFO
   /* Both PROTO_UDPv4 and PROTO_UDPv6 */
   if (sock->info.proto == PROTO_UDP && sock->sockflags & SF_USE_IP_PKTINFO)
-    fromlen = link_socket_read_udp_posix_recvmsg (sock, buf, maxsize, from);
+    fromlen = link_socket_read_udp_posix_recvmsg (sock, buf, from);
   else
 #endif
-    buf->len = recvfrom (sock->sd, BPTR (buf), maxsize, 0,
+    buf->len = recvfrom (sock->sd, BPTR (buf), buf_forward_capacity(buf), 0,
 			 &from->dest.addr.sa, &fromlen);
   /* FIXME: won't do anything when sock->info.af == AF_UNSPEC */
   if (buf->len >= 0 && expectedlen && fromlen != expectedlen)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index b154bc0..6f4d34f 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -961,7 +961,6 @@ link_socket_read_udp_win32 (struct link_socket *sock,
 
 int link_socket_read_udp_posix (struct link_socket *sock,
 				struct buffer *buf,
-				int maxsize,
 				struct link_socket_actual *from);
 
 #endif
@@ -970,7 +969,6 @@ int link_socket_read_udp_posix (struct link_socket *sock,
 static inline int
 link_socket_read (struct link_socket *sock,
 		  struct buffer *buf,
-		  int maxsize,
 		  struct link_socket_actual *from)
 {
   if (proto_is_udp(sock->info.proto)) /* unified UDPv4 and UDPv6 */
@@ -980,7 +978,7 @@ link_socket_read (struct link_socket *sock,
 #ifdef WIN32
       res = link_socket_read_udp_win32 (sock, buf, from);
 #else
-      res = link_socket_read_udp_posix (sock, buf, maxsize, from);
+      res = link_socket_read_udp_posix (sock, buf, from);
 #endif
       return res;
     }
-- 
2.5.0


