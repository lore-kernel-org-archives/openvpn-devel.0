From: Antonio Quartulli <a@...2181...>
Date: Sat,  9 Nov 2019 17:37:14 +0100
Message-Id: <20191109163714.25506-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] socks: use the right function when printing
 struct openvpn_sockaddr
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>

57623b4e introduced a print_sockaddr() call in socks.c to print an
openvpn_sockaddr object.

However, this is not correct because print_sockaddr() expects a sockaddr
object as argument instead of openvpn_sockaddr.

This error did not lead to any issue because the two objects are very
similar in regards to the data accessed by print_sockaddr().

Fix this by replacing print_sockaddr() with print_openvpn_sockaddr().

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/socks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index ad3a70b2..57f0cee2 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -416,7 +416,7 @@ recv_socks_reply(socket_descriptor_t sd,
         memcpy(&addr->addr.in4.sin_port, buf + 8, sizeof(addr->addr.in4.sin_port));
         struct gc_arena gc = gc_new();
         msg(M_INFO, "SOCKS proxy wants us to send UDP to %s",
-            print_sockaddr(addr, &gc));
+            print_openvpn_sockaddr(addr, &gc));
         gc_free(&gc);
     }
 
-- 
2.24.0


