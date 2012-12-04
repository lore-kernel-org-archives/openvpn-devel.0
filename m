From: Arne Schwabe <arne@...1227...>
Date: Tue,  4 Dec 2012 20:42:54 +0100
Message-Id: <1354650174-25601-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix the proto is used inconsistently warning
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

Fix the "WARNING: 'proto' is used inconsistently, local='proto UDP', remote='proto UDPv6'." message.

Note that the on wire strings are now always TCPv4 and UDPv4 to be compatible to pre2.3

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/socket.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 505cf3b..2adfe8a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2560,6 +2560,10 @@ addr_family_name (int af)
  *
  * This is used for options compatibility
  * checking.
+ *
+ * IPv6 and IPv4 protocols are comptabile but OpenVPN
+ * has always sent UDPv4, TCPv4 over the wire. Keep these 
+ * strings for backward compatbility
  */
 int
 proto_remote (int proto, bool remote)
@@ -2569,10 +2573,20 @@ proto_remote (int proto, bool remote)
     {
       switch (proto)
       {
-	case PROTO_TCPv4_SERVER: return PROTO_TCPv4_CLIENT;
-	case PROTO_TCPv4_CLIENT: return PROTO_TCPv4_SERVER;
-	case PROTO_TCPv6_SERVER: return PROTO_TCPv6_CLIENT;
-	case PROTO_TCPv6_CLIENT: return PROTO_TCPv6_SERVER;
+      case PROTO_TCPv4_SERVER: return PROTO_TCPv4_CLIENT;
+      case PROTO_TCPv4_CLIENT: return PROTO_TCPv4_SERVER;
+      case PROTO_TCPv6_SERVER: return PROTO_TCPv4_CLIENT;
+      case PROTO_TCPv6_CLIENT: return PROTO_TCPv4_SERVER;
+      case PROTO_UDPv6: return PROTO_UDPv4;
+      }
+    }
+  else
+    {
+      switch (proto)
+      {
+      case PROTO_TCPv6_SERVER: return PROTO_TCPv4_SERVER;
+      case PROTO_TCPv6_CLIENT: return PROTO_TCPv4_CLIENT;
+      case PROTO_UDPv6: return PROTO_UDPv4;
       }
     }
   return proto;
-- 
1.7.9.5


