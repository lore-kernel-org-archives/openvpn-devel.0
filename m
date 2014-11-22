From: Yegor Yefremov <yegorslists@...1030...>
Date: Sat, 22 Nov 2014 21:13:35 +0100
Message-Id: <1416687215-26904-1-git-send-email-yegorslists@...1030...>
Subject: [Openvpn-devel] [PATCH] socket: remove duplicate expression
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

Found via cppcheck and compile-tested.

Signed-off-by: Yegor Yefremov <yegorslists@...1030...>
---
 src/openvpn/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 29f9958..331a9d9 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2666,7 +2666,7 @@ proto_is_tcp(int proto)
 {
   if (proto < 0 || proto >= PROTO_N)
     ASSERT(0);
-  return proto == PROTO_TCP_CLIENT || proto == PROTO_TCP_SERVER || proto == PROTO_TCP_CLIENT;
+  return proto == PROTO_TCP_CLIENT || proto == PROTO_TCP_SERVER;
 }
 
 int
-- 
1.8.3.2


