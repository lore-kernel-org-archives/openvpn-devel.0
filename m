From: Heiko Hund <heiko.hund@...1489...>
Date: Sat, 15 Nov 2014 17:25:07 +0100
Message-Id: <1416068708-6871-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH 1/2] fix compilation on Windows
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

The local member in struct lick_socket_address went away a while ago.
Fixing the code to compile again under Windows. While there, also
fix the code to deal with struct link_socket_info.af == AF_UNSPEC

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/socket.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c649d62..9ed8a5a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2916,6 +2916,7 @@ link_socket_read_udp_posix (struct link_socket *sock,
 #endif
     buf->len = recvfrom (sock->sd, BPTR (buf), maxsize, 0,
 			 &from->dest.addr.sa, &fromlen);
+  /* FIXME: won't do anything when sock->info.af == AF_UNSPEC */
   if (buf->len >= 0 && expectedlen && fromlen != expectedlen)
     bad_address_length (fromlen, expectedlen);
   return buf->len;
@@ -3060,10 +3061,7 @@ socket_recv_queue (struct link_socket *sock, int maxsize)
       if (proto_is_udp(sock->info.proto))
 	{
 	  sock->reads.addr_defined = true;
-	  if (sock->info.af == AF_INET)
-	    sock->reads.addrlen = sizeof (sock->reads.addr);
-	  else
-	    sock->reads.addrlen = sizeof (sock->reads.addr6);
+	  sock->reads.addrlen = sizeof (sock->reads.addr6);
 	  status = WSARecvFrom(
 			       sock->sd,
 			       wsabuf,
@@ -3095,9 +3093,10 @@ socket_recv_queue (struct link_socket *sock, int maxsize)
 
       if (!status) /* operation completed immediately? */
 	{
-	  int addrlen = af_addr_size(sock->info.lsa->local.addr.sa.sa_family);
-	  if (sock->reads.addr_defined && sock->reads.addrlen != addrlen)
-	    bad_address_length (sock->reads.addrlen, addrlen);
+	  /* FIXME: won't do anything when sock->info.af == AF_UNSPEC */
+	  int af_len = af_addr_size (sock->info.af);
+	  if (sock->reads.addr_defined && af_len && sock->reads.addrlen != af_len)
+	    bad_address_length (sock->reads.addrlen, af_len);
 	  sock->reads.iostate = IOSTATE_IMMEDIATE_RETURN;
 
 	  /* since we got an immediate return, we must signal the event object ourselves */
@@ -3159,7 +3158,7 @@ socket_send_queue (struct link_socket *sock, struct buffer *buf, const struct li
 	{
 	  /* set destination address for UDP writes */
 	  sock->writes.addr_defined = true;
-	  if (sock->info.af == AF_INET6)
+	  if (to->dest.addr.sa.sa_family == AF_INET6)
 	    {
 	      sock->writes.addr6 = to->dest.addr.in6;
 	      sock->writes.addrlen = sizeof (sock->writes.addr6);
-- 
1.9.1


