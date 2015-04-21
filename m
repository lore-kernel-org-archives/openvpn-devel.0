From: Gert Doering <gert@...1296...>
Date: Tue, 21 Apr 2015 22:49:12 +0200
Message-Id: <1429649352-21034-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix leftover 'if (false) ;' statements
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

Commit a4b8f653ee5be9c2292c removed the #ifdefs for ENABLE_HTTP_PROXY and
ENABLE_SOCKS, thus making this "if (false) ; else if (...)" construct
superfluous.  Spotted by David Sommerseth.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index f5c740d..afc1e60 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1575,10 +1575,8 @@ link_socket_init_phase1 (struct link_socket *sock,
       sock->sd = accept_from->sd;
     }
 
-  if (false)
-    ;
   /* are we running in HTTP proxy mode? */
-  else if (sock->http_proxy)
+  if (sock->http_proxy)
     {
       ASSERT (sock->info.proto == PROTO_TCP_CLIENT);
       ASSERT (!sock->inetd);
@@ -1793,9 +1791,7 @@ phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
     if (sig_info->signal_received)
       return;
 
-    if (false)
-      ;
-    else if (sock->http_proxy)
+    if (sock->http_proxy)
       {
 	proxy_retry = establish_http_proxy_passthru (sock->http_proxy,
 						     sock->sd,
-- 
2.0.5


