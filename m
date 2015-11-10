From: Gert Doering <gert@...1296...>
Date: Tue, 10 Nov 2015 22:58:39 +0100
Message-Id: <1447192719-31381-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix possible heap overflow on read
	accessing getaddrinfo() result.
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

The code always tried to copy-out a "struct sockaddr_in6" even for IPv4
results, which reads more bytes than getaddrinfo() is guaranteed to
allocate.

Now, look at ai->ai_family and only copy "struct sockaddr" for IPv4.

Also, reformat this block of code to comply to coding style.

This is a specific 2.3 bug as the code in master (to be 2.4) has been
completely rewritten to properly handle dual-stack and multiple responses
from getaddrinfo() proper.

Bug found by Daniel Hirche using "gcc -fsanitize=address".  No possible
exploits are known.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index a143853..0f46bad 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1259,20 +1259,24 @@ resolve_remote (struct link_socket *sock,
 		  ASSERT (0);
 		}
 
-		  /* Temporary fix, this need to be changed for dual stack */
-		  status = openvpn_getaddrinfo(flags, sock->remote_host, retry,
-											  signal_received, af, &ai);
-		  if(status == 0) {
-			  sock->info.lsa->remote.addr.in6 = *((struct sockaddr_in6*)(ai->ai_addr));
-			  freeaddrinfo(ai);
+	      /* Temporary fix, this need to be changed for dual stack */
+	      status = openvpn_getaddrinfo(flags, sock->remote_host, retry,
+					    signal_received, af, &ai);
+	      if(status == 0)
+		{
+		  if ( ai->ai_family == AF_INET6 )
+		    sock->info.lsa->remote.addr.in6 = *((struct sockaddr_in6*)(ai->ai_addr));
+		  else
+		    sock->info.lsa->remote.addr.in4 = *((struct sockaddr_in*)(ai->ai_addr));
+		  freeaddrinfo(ai);
 
-			  dmsg (D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
+		  dmsg (D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
 					flags,
 					phase,
 					retry,
 					signal_received ? *signal_received : -1,
 					status);
-		  }
+		}
 	      if (signal_received)
 		{
 		  if (*signal_received)
-- 
2.4.9


