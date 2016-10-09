From: Gert Doering <gert@...1296...>
Date: Sun,  9 Oct 2016 12:09:29 +0200
Message-Id: <20161009100929.46472-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix --multihome for IPv6 on 64bit BSD
	systems.
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

The old code only worked if "struct openvpn*pktinfo" happened to use
the same structure packing as the CMSG_SPACE() / CMSG_LEN() macros
(which are part of the official API, see RFC 2292).

Get rid of "struct openvpn_*_pktinfo" definitions, replace them by
an opaque buffer sized large enough to fit IPv4 and IPv6 packet info
messages, as defined by CMSG_SPACE(sizeof(struct ...)).

On 32 bit platforms, the net result is the same.  On 64 bit platforms,
the new buffer is bigger than openvpn_pktinfo was, fixing an overflow
with ipi6_ifindex corruption on reception, and EINVAL on sendmsg().

The IPv4 related changes are only side effects of using the new buffer.

Fixes: FreeBSD 10.3/amd64, FreeBSD 9.3/sparc64, OpenBSD 6.0/amd64,
       NetBSD 7.0.1/i386.

Note: --multihome for IPv4 on NetBSD is still broken and non-fixable(!)
       as NetBSD lacks the necessary kernel code for the sendmsg() side.

Verified that "--multihome works as well as before" on FreeBSD 7.4/amd64,
       NetBSD 5.1/amd64, OpenBSD 4.9/i386, Linux/x86_64, Linux/i386,
       OpenSolaris 10 (--multihome needs -D_XPG4_2, see trac #750)

See also: ip(4), ip6(4), recv(2)

Trac #634, #327, #28

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 57 +++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index e096132..184c7ad 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2863,27 +2863,16 @@ link_socket_read_tcp (struct link_socket *sock,
 
 #if ENABLE_IP_PKTINFO
 
-#pragma pack(1) /* needed to keep structure size consistent for 32 vs. 64-bit architectures */
-struct openvpn_in4_pktinfo
-{
-  struct cmsghdr cmsghdr;
+/* make the buffer large enough to handle ancilliary socket data for
+ * both IPv4 and IPv6 destination addresses, plus padding (see RFC 2292)
+ */
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-  struct in_pktinfo pi4;
-#elif defined(IP_RECVDSTADDR)
-  struct in_addr pi4;
+#define PKTINFO_BUF_SIZE max_int( CMSG_SPACE(sizeof (struct in6_pktinfo)), \
+				  CMSG_SPACE(sizeof (struct in_pktinfo)) )
+#else
+#define PKTINFO_BUF_SIZE max_int( CMSG_SPACE(sizeof (struct in6_pktinfo)), \
+				  CMSG_SPACE(sizeof (struct in_addr)) )
 #endif
-};
-struct openvpn_in6_pktinfo
-{
-  struct cmsghdr cmsghdr;
-  struct in6_pktinfo pi6;
-};
-
-union openvpn_pktinfo {
-	struct openvpn_in4_pktinfo msgpi4;
-	struct openvpn_in6_pktinfo msgpi6;
-};
-#pragma pack()
 
 static socklen_t
 link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
@@ -2891,7 +2880,7 @@ link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
 				    struct link_socket_actual *from)
 {
   struct iovec iov;
-  union openvpn_pktinfo opi;
+  uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
   struct msghdr mesg;
   socklen_t fromlen = sizeof (from->dest.addr);
 
@@ -2901,8 +2890,8 @@ link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
   mesg.msg_iovlen = 1;
   mesg.msg_name = &from->dest.addr;
   mesg.msg_namelen = fromlen;
-  mesg.msg_control = &opi;
-  mesg.msg_controllen = sizeof opi;
+  mesg.msg_control = pktinfo_buf;
+  mesg.msg_controllen = sizeof pktinfo_buf;
   buf->len = recvmsg (sock->sd, &mesg, 0);
   if (buf->len >= 0)
     {
@@ -2914,13 +2903,14 @@ link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
 	  && cmsg->cmsg_level == SOL_IP 
 	  && cmsg->cmsg_type == IP_PKTINFO
+	  && cmsg->cmsg_len >= CMSG_LEN(sizeof(struct in_pktinfo)) )
 #elif defined(IP_RECVDSTADDR)
 	  && cmsg->cmsg_level == IPPROTO_IP
 	  && cmsg->cmsg_type == IP_RECVDSTADDR
+	  && cmsg->cmsg_len >= CMSG_LEN(sizeof(struct in_addr)) )
 #else
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)
 #endif
-	  && cmsg->cmsg_len >= sizeof (struct openvpn_in4_pktinfo))
 	{
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
 	  struct in_pktinfo *pkti = (struct in_pktinfo *) CMSG_DATA (cmsg);
@@ -2936,7 +2926,7 @@ link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
 	  && CMSG_NXTHDR (&mesg, cmsg) == NULL
 	  && cmsg->cmsg_level == IPPROTO_IPV6 
 	  && cmsg->cmsg_type == IPV6_PKTINFO
-	  && cmsg->cmsg_len >= sizeof (struct openvpn_in6_pktinfo))
+	  && cmsg->cmsg_len >= CMSG_LEN(sizeof(struct in6_pktinfo)) )
 	{
 	  struct in6_pktinfo *pkti6 = (struct in6_pktinfo *) CMSG_DATA (cmsg);
 	  from->pi.in6.ipi6_ifindex = pkti6->ipi6_ifindex;
@@ -3007,7 +2997,7 @@ link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
   struct iovec iov;
   struct msghdr mesg;
   struct cmsghdr *cmsg;
-  union openvpn_pktinfo opi;
+  uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
 
   iov.iov_base = BPTR (buf);
   iov.iov_len = BLEN (buf);
@@ -3019,12 +3009,12 @@ link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
       {
         mesg.msg_name = &to->dest.addr.sa;
         mesg.msg_namelen = sizeof (struct sockaddr_in);
-        mesg.msg_control = &opi;
+        mesg.msg_control = pktinfo_buf;
         mesg.msg_flags = 0;
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-        mesg.msg_controllen = sizeof (struct openvpn_in4_pktinfo);
+        mesg.msg_controllen = CMSG_SPACE(sizeof (struct in_pktinfo));
         cmsg = CMSG_FIRSTHDR (&mesg);
-        cmsg->cmsg_len = sizeof (struct openvpn_in4_pktinfo);
+        cmsg->cmsg_len = CMSG_LEN(sizeof (struct in_pktinfo));
         cmsg->cmsg_level = SOL_IP;
         cmsg->cmsg_type = IP_PKTINFO;
 	{
@@ -3035,7 +3025,7 @@ link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
         pkti->ipi_addr.s_addr = 0;
 	}
 #elif defined(IP_RECVDSTADDR)
-	ASSERT( CMSG_SPACE(sizeof (struct in_addr)) <= sizeof(opi) );
+	ASSERT( CMSG_SPACE(sizeof (struct in_addr)) <= sizeof(pktinfo_buf) );
         mesg.msg_controllen = CMSG_SPACE(sizeof (struct in_addr));
         cmsg = CMSG_FIRSTHDR (&mesg);
         cmsg->cmsg_len = CMSG_LEN(sizeof(struct in_addr));
@@ -3052,13 +3042,16 @@ link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
         struct in6_pktinfo *pkti6;
         mesg.msg_name = &to->dest.addr.sa;
         mesg.msg_namelen = sizeof (struct sockaddr_in6);
-        mesg.msg_control = &opi;
-        mesg.msg_controllen = sizeof (struct openvpn_in6_pktinfo);
+
+        ASSERT( CMSG_SPACE(sizeof (struct in6_pktinfo)) <= sizeof(pktinfo_buf) );
+        mesg.msg_control = pktinfo_buf;
+        mesg.msg_controllen = CMSG_SPACE(sizeof (struct in6_pktinfo));
         mesg.msg_flags = 0;
         cmsg = CMSG_FIRSTHDR (&mesg);
-        cmsg->cmsg_len = sizeof (struct openvpn_in6_pktinfo);
+        cmsg->cmsg_len = CMSG_LEN(sizeof(struct in6_pktinfo));
         cmsg->cmsg_level = IPPROTO_IPV6;
         cmsg->cmsg_type = IPV6_PKTINFO;
+
         pkti6 = (struct in6_pktinfo *) CMSG_DATA (cmsg);
         pkti6->ipi6_ifindex = to->pi.in6.ipi6_ifindex;
         pkti6->ipi6_addr = to->pi.in6.ipi6_addr;
-- 
2.9.0


