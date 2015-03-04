From: Arne Schwabe <arne@...1227...>
Date: Wed,  4 Mar 2015 15:23:44 +0100
Message-Id: <1425479025-7573-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/2] Remove unused function sock_addr_set
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

---
 src/openvpn/ps.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 6807aac..fe18a9d 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -372,17 +372,6 @@ proxy_list_close (struct proxy_connection **list)
     }
 }
 
-static void
-sock_addr_set (struct openvpn_sockaddr *osaddr,
-	       const in_addr_t addr,
-	       const int port)
-{
-  CLEAR (*osaddr);
-  osaddr->addr.in4.sin_family = AF_INET;
-  osaddr->addr.in4.sin_addr.s_addr = htonl (addr);
-  osaddr->addr.in4.sin_port = htons (port);
-}
-
 static inline void
 proxy_connection_io_requeue (struct proxy_connection *pc, const int rwflags_new, struct event_set *es)
 {
-- 
1.9.3 (Apple Git-50)


