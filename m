From: Arne Schwabe <arne@...1227...>
Date: Thu, 21 Nov 2013 21:08:07 +0100
Message-Id: <1385064495-25877-6-git-send-email-arne@...1227...>
In-Reply-To: <1385064495-25877-1-git-send-email-arne@...1227...>
References: <1385064495-25877-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 06/14] Fix two instances of asserting AF_INET
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

The http-proxy and socks-proxy work fine with IPv6 but assert having IPv4
---
 src/openvpn/socket.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 843bcc3..ef0a11f 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1438,7 +1438,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   /* are we running in HTTP proxy mode? */
   else if (sock->http_proxy)
     {
-      ASSERT (sock->info.proto == PROTO_TCP_CLIENT && sock->info.af == AF_INET);
+      ASSERT (sock->info.proto == PROTO_TCP_CLIENT);
       ASSERT (!sock->inetd);
 
       /* the proxy server */
@@ -1454,7 +1454,6 @@ link_socket_init_phase1 (struct link_socket *sock,
   /* or in Socks proxy mode? */
   else if (sock->socks_proxy)
     {
-      ASSERT (sock->info.af == AF_INET);
       ASSERT (!sock->inetd);
 
       /* the proxy server */
@@ -1473,7 +1472,7 @@ link_socket_init_phase1 (struct link_socket *sock,
     }
 
   /* bind behavior for TCP server vs. client */
-  if (sock->info.proto == PROTO_TCP_SERVER && sock->info.af==AF_INET)
+  if (sock->info.proto == PROTO_TCP_SERVER)
     {
       if (sock->mode == LS_MODE_TCP_ACCEPT_FROM)
 	sock->bind_local = false;
-- 
1.7.9.5


