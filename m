From: James Yonan <james@...515...>
Date: Thu,  8 May 2014 16:50:32 -0600
Message-Id: <1399589436-8730-3-git-send-email-james@...515...>
In-Reply-To: <1399589436-8730-1-git-send-email-james@...515...>
References: <1399589436-8730-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 2/6] In socket.c,
	fixed issue where uninitialized value (err) is being passed to to
	gai_strerror.
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
Cc: James Yonan <james@...515...>

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/socket.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7ff14cc..6e68c18 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1150,7 +1150,6 @@ resolve_bind_local (struct link_socket *sock)
 	case AF_INET6:
 	    {
 	      int status;
-	      int err;
 	      CLEAR(sock->info.lsa->local.addr.in6);
 	      if (sock->local_host)
 		{
@@ -1173,7 +1172,7 @@ resolve_bind_local (struct link_socket *sock)
 		{
 		  msg (M_FATAL, "getaddr6() failed for local \"%s\": %s",
 		       sock->local_host,
-		       gai_strerror(err));
+		       gai_strerror(status));
 		}
 	      sock->info.lsa->local.addr.in6.sin6_port = htons (sock->local_port);
 	    }
-- 
1.8.5.5


