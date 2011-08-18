From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 18 Aug 2011 10:16:21 +0000
Message-Id: <1313662581-30181-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH] remove function is_proto_tcp()
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

The implementation of is_proto_tcp() was invalid since the IPv6 stuff got
merged into master. There's proto_is_tcp() that does the same job right.

Remove is_proto_tcp() and make its only caller use proto_is_tcp() instead.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 options.c |    2 +-
 socket.h  |    6 ------
 2 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/options.c b/options.c
index 77e7c7f..902cc81 100644
--- a/options.c
+++ b/options.c
@@ -2409,7 +2409,7 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
     ce->local_port = 0;
 
   /* if protocol forcing is enabled, disable all protocols except for the forced one */
-  if (o->proto_force >= 0 && is_proto_tcp(o->proto_force) != is_proto_tcp(ce->proto))
+  if (o->proto_force >= 0 && proto_is_tcp(o->proto_force) != proto_is_tcp(ce->proto))
     ce->flags |= CE_DISABLED;
 }
 
diff --git a/socket.h b/socket.h
index 33da53c..6336f92 100644
--- a/socket.h
+++ b/socket.h
@@ -563,12 +563,6 @@ legal_ipv4_port (int port)
   return port > 0 && port < 65536;
 }
 
-static inline int
-is_proto_tcp(const int p)
-{
-  return p > 0; /* depends on the definition of PROTO_x */
-}
-
 static inline bool
 link_socket_proto_connection_oriented (int proto)
 {
-- 
1.7.5.4


