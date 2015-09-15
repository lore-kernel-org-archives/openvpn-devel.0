From: Arne Schwabe <arne@...1227...>
Date: Tue, 15 Sep 2015 13:15:41 +0200
Message-Id: <1442315741-1724-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Do not install a IPv6 host route for the
	VPN on Android
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

Routing loops are avoided using the VPNService API protect API
---
 src/openvpn/route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3959abd..7e4a766 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -768,6 +768,7 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
             r6->next = rl6->routes_ipv6;
             rl6->routes_ipv6 = r6;
 
+#ifndef TARGET_ANDROID
 	    if ( remote_host_ipv6 &&
 		  route_ipv6_match_host( r6, remote_host_ipv6 ) )
 	      {
@@ -776,7 +777,8 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
 			print_in6_addr (r6->network, 0, &gc), r6->netbits,
 			print_in6_addr (*remote_host_ipv6, 0, &gc));
 	      }
-          }
+#endif
+	  }
       }
   }
 
-- 
2.3.2 (Apple Git-55)


