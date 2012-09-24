Message-ID: <50609652.1060609@...1769...>
Date: Mon, 24 Sep 2012 19:20:18 +0200
From: Krzysztof Witek <netdev@...1769...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] fix sending udp datagrams from wrong ip
	address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

From: Krzysztof Witek <krzysztof@...1769...>

If multiple ip addresses of the same subnet are configured on an
interface, openvpn may not send udp datagrams to the peer
using the correct source ip address.

If a host sends the udp datagrams to the ip address A, then it
should receive the answer from A even if the its peer has multiple
ip addresses and the default routing selects a different one.

The issue can be reproduced with the following scenario:

Host A is connected to two gateways each on the same subnet:
gw1 with ip address 10.0.0.254
gw2 with ip address 10.0.0.253

Host A has two ip addresses: 10.0.0.1 and 10.0.0.2.
It receives DNAT-ed traffic from gw1 via 10.0.0.1
and DNAT-ed traffic from gw2 via 10.0.0.2.

Two ip rules are set up on the host A:
ip rule add from 10.0.0.1 table 1
ip rule add from 10.0.0.2 table 2

and three default routes:
ip route add default via 10.0.0.254 table 1
ip route add default via 10.0.0.253 table 2
ip route add default via 10.0.0.254

This way all traffic from 10.0.0.1 will go via 10.0.0.254
and all traffic from 10.0.0.2 will go via 10.0.0.253.

The current openvpn server doesn't work if it receives a connection
from the router gw2 because it will send its udp datagrams via gw1.

Saving the destination ip address on which the udp datagram arrived and then
using it as the source ip address solves this issue.

Signed-off-by: Krzysztof Witek <krzysztof@...1769...>
---
  src/openvpn/forward.c |    6 ++++--
  src/openvpn/openvpn.h |    1 +
  src/openvpn/socket.c  |   19 +++++++++++--------
  src/openvpn/socket.h  |   28 ++++++++++++++++++----------
  4 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 57c7846..6e629c2 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -674,7 +674,8 @@ read_incoming_link (struct context *c)
    status = link_socket_read (c->c2.link_socket,
                              &c->c2.buf,
                              MAX_RW_SIZE_LINK (&c->c2.frame),
-                            &c->c2.from);
+                            &c->c2.from,
+                            &c->c2.to);

    if (socket_connection_reset (c->c2.link_socket, status))
      {
@@ -1135,7 +1136,8 @@ process_outgoing_link (struct context *c)
             /* Send packet */
             size = link_socket_write (c->c2.link_socket,
                                       &c->c2.to_link,
-                                     to_addr);
+                                     to_addr,
+                                     &c->c2.to);

  #ifdef ENABLE_SOCKS
             /* Undo effect of prepend */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 7abfb08..53a3c00 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -258,6 +258,7 @@ struct context_2

    struct link_socket_actual *to_link_addr;     /* IP address of remote */
    struct link_socket_actual from;               /* address of incoming 
datagram */
+  struct link_socket_actual to;                 /* address of local 
datagram */

    /* MTU frame parameters */
    struct frame frame;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 505cf3b..0f57973 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -653,7 +653,7 @@ create_socket_udp (const unsigned int flags)
      {
        int pad = 1;
  #ifdef IP_PKTINFO
-      if (setsockopt (sd, SOL_IP, IP_PKTINFO,
+      if (setsockopt (sd, IPPROTO_IP, IP_PKTINFO,
                       (void*)&pad, sizeof(pad)) < 0)
          msg(M_ERR, "UDP: failed setsockopt for IP_PKTINFO");
  #elif defined(IP_RECVDSTADDR)
@@ -2657,7 +2657,8 @@ static socklen_t
  link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
                                     struct buffer *buf,
                                     int maxsize,
-                                   struct link_socket_actual *from)
+                                   struct link_socket_actual *from,
+                                   struct link_socket_actual *to)
  {
    struct iovec iov;
    union openvpn_pktinfo opi;
@@ -2680,11 +2681,10 @@ link_socket_read_udp_posix_recvmsg (struct 
link_socket *sock,
        cmsg = CMSG_FIRSTHDR (&mesg);
        if (cmsg != NULL
           && CMSG_NXTHDR (&mesg, cmsg) == NULL
+         && cmsg->cmsg_level == IPPROTO_IP
  #ifdef IP_PKTINFO
-         && cmsg->cmsg_level == SOL_IP
           && cmsg->cmsg_type == IP_PKTINFO
  #elif defined(IP_RECVDSTADDR)
-         && cmsg->cmsg_level == IPPROTO_IP
           && cmsg->cmsg_type == IP_RECVDSTADDR
  #else
  #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR 
(fix syshead.h)
@@ -2695,6 +2695,7 @@ link_socket_read_udp_posix_recvmsg (struct 
link_socket *sock,
           struct in_pktinfo *pkti = (struct in_pktinfo *) CMSG_DATA (cmsg);
           from->pi.in4.ipi_ifindex = pkti->ipi_ifindex;
           from->pi.in4.ipi_spec_dst = pkti->ipi_spec_dst;
+         to->pi.in4.ipi_addr = pkti->ipi_addr;
  #elif defined(IP_RECVDSTADDR)
           from->pi.in4 = *(struct in_addr*) CMSG_DATA (cmsg);
  #else
@@ -2720,7 +2721,8 @@ int
  link_socket_read_udp_posix (struct link_socket *sock,
                             struct buffer *buf,
                             int maxsize,
-                           struct link_socket_actual *from)
+                           struct link_socket_actual *from,
+                           struct link_socket_actual *to)
  {
    socklen_t fromlen = sizeof (from->dest.addr);
    socklen_t expectedlen = af_addr_size(proto_sa_family(sock->info.proto));
@@ -2729,7 +2731,7 @@ link_socket_read_udp_posix (struct link_socket *sock,
  #if ENABLE_IP_PKTINFO
    /* Both PROTO_UDPv4 and PROTO_UDPv6 */
    if (proto_is_udp(sock->info.proto) && sock->sockflags & 
SF_USE_IP_PKTINFO)
-    fromlen = link_socket_read_udp_posix_recvmsg (sock, buf, maxsize, 
from);
+    fromlen = link_socket_read_udp_posix_recvmsg (sock, buf, maxsize, 
from, to);
    else
  #endif
      buf->len = recvfrom (sock->sd, BPTR (buf), maxsize, 0,
@@ -2767,7 +2769,8 @@ link_socket_write_tcp (struct link_socket *sock,
  int
  link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
                                      struct buffer *buf,
-                                    struct link_socket_actual *to)
+                                    struct link_socket_actual *to,
+                                    struct link_socket_actual *from)
  {
    struct iovec iov;
    struct msghdr mesg;
@@ -2797,7 +2800,7 @@ link_socket_write_udp_posix_sendmsg (struct 
link_socket *sock,
          pkti = (struct in_pktinfo *) CMSG_DATA (cmsg);
          pkti->ipi_ifindex = to->pi.in4.ipi_ifindex;
          pkti->ipi_spec_dst = to->pi.in4.ipi_spec_dst;
-        pkti->ipi_addr.s_addr = 0;
+        pkti->ipi_addr = from->pi.in4.ipi_addr;
         }
  #elif defined(IP_RECVDSTADDR)
          cmsg->cmsg_level = IPPROTO_IP;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 44f1098..7aad95f 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -867,7 +867,8 @@ link_socket_read_udp_win32 (struct link_socket *sock,
  int link_socket_read_udp_posix (struct link_socket *sock,
                                 struct buffer *buf,
                                 int maxsize,
-                               struct link_socket_actual *from);
+                               struct link_socket_actual *from,
+                               struct link_socket_actual *to);

  #endif

@@ -876,16 +877,18 @@ static inline int
  link_socket_read (struct link_socket *sock,
                   struct buffer *buf,
                   int maxsize,
-                 struct link_socket_actual *from)
+                 struct link_socket_actual *from,
+                 struct link_socket_actual *to)
  {
    if (proto_is_udp(sock->info.proto)) /* unified UDPv4 and UDPv6 */
      {
        int res;

  #ifdef WIN32
+      (void) to;
        res = link_socket_read_udp_win32 (sock, buf, from);
  #else
-      res = link_socket_read_udp_posix (sock, buf, maxsize, from);
+      res = link_socket_read_udp_posix (sock, buf, maxsize, from, to);
  #endif
        return res;
      }
@@ -940,16 +943,18 @@ link_socket_write_win32 (struct link_socket *sock,
  static inline int
  link_socket_write_udp_posix (struct link_socket *sock,
                              struct buffer *buf,
-                            struct link_socket_actual *to)
+                            struct link_socket_actual *to,
+                            struct link_socket_actual *from)
  {
  #if ENABLE_IP_PKTINFO
    int link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
                                            struct buffer *buf,
-                                          struct link_socket_actual *to);
+                                          struct link_socket_actual *to,
+                                          struct link_socket_actual *from);

    if (proto_is_udp(sock->info.proto) && (sock->sockflags & 
SF_USE_IP_PKTINFO)
           && addr_defined_ipi(to))
-    return link_socket_write_udp_posix_sendmsg (sock, buf, to);
+         return link_socket_write_udp_posix_sendmsg (sock, buf, to, from);
    else
  #endif
      return sendto (sock->sd, BPTR (buf), BLEN (buf), 0,
@@ -970,12 +975,14 @@ link_socket_write_tcp_posix (struct link_socket *sock,
  static inline int
  link_socket_write_udp (struct link_socket *sock,
                        struct buffer *buf,
-                      struct link_socket_actual *to)
+                      struct link_socket_actual *to,
+                      struct link_socket_actual *from)
  {
  #ifdef WIN32
+  (void) from;
    return link_socket_write_win32 (sock, buf, to);
  #else
-  return link_socket_write_udp_posix (sock, buf, to);
+  return link_socket_write_udp_posix (sock, buf, to, from);
  #endif
  }

@@ -983,11 +990,12 @@ link_socket_write_udp (struct link_socket *sock,
  static inline int
  link_socket_write (struct link_socket *sock,
                    struct buffer *buf,
-                  struct link_socket_actual *to)
+                  struct link_socket_actual *to,
+                  struct link_socket_actual *from)
  {
    if (proto_is_udp(sock->info.proto)) /* unified UDPv4 and UDPv6 */
      {
-      return link_socket_write_udp (sock, buf, to);
+      return link_socket_write_udp (sock, buf, to, from);
      }
    else if (proto_is_tcp(sock->info.proto)) /* unified TCPv4 and TCPv6 */
      {
-- 
1.7.0.4


