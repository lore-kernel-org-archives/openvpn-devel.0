From: Gert Doering <gert@...1296...>
Date: Sun, 19 Jan 2014 21:51:37 +0100
Message-Id: <1390164697-1590-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Repair --multihome on FreeBSD for IPv4
	sockets.
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

The code in link_socket_write_udp_posix_sendmsg() for the IP_RECVDESTADDR
case was sending a too-large control message (sizeof openvpn_pktinfo,
which is a union for IPv4+IPv6) instead of just openvpn_in4_pktinfo,
leading to sendmsg() refusing to send the packet.

Use RFC 2292 macros for alignment + size calculation.

Fix trac#327

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 100eedd..525b864 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2835,11 +2835,11 @@ link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
         mesg.msg_name = &to->dest.addr.sa;
         mesg.msg_namelen = sizeof (struct sockaddr_in);
         mesg.msg_control = &opi;
-        mesg.msg_controllen = sizeof (struct openvpn_in4_pktinfo);
         mesg.msg_flags = 0;
+#ifdef HAVE_IN_PKTINFO
+        mesg.msg_controllen = sizeof (struct openvpn_in4_pktinfo);
         cmsg = CMSG_FIRSTHDR (&mesg);
         cmsg->cmsg_len = sizeof (struct openvpn_in4_pktinfo);
-#ifdef HAVE_IN_PKTINFO
         cmsg->cmsg_level = SOL_IP;
         cmsg->cmsg_type = IP_PKTINFO;
 	{
@@ -2850,6 +2850,10 @@ link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
         pkti->ipi_addr.s_addr = 0;
 	}
 #elif defined(IP_RECVDSTADDR)
+	ASSERT( CMSG_SPACE(sizeof (struct in_addr)) <= sizeof(opi) );
+        mesg.msg_controllen = CMSG_SPACE(sizeof (struct in_addr));
+        cmsg = CMSG_FIRSTHDR (&mesg);
+        cmsg->cmsg_len = CMSG_LEN(sizeof(struct in_addr));
         cmsg->cmsg_level = IPPROTO_IP;
         cmsg->cmsg_type = IP_RECVDSTADDR;
         *(struct in_addr *) CMSG_DATA (cmsg) = to->pi.in4;
-- 
1.8.3.2


