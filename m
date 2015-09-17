From: Arne Schwabe <arne@...1227...>
Date: Thu, 17 Sep 2015 12:23:58 +0200
Message-Id: <1442485438-15704-1-git-send-email-arne@...1227...>
In-Reply-To: <1442483700-8716-1-git-send-email-arne@...1227...>
References: <1442483700-8716-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3] Do not install a host route for the VPN
	on Android
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
 src/openvpn/route.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3959abd..0142c58 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -768,6 +768,10 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
             r6->next = rl6->routes_ipv6;
             rl6->routes_ipv6 = r6;
 
+#ifndef TARGET_ANDROID
+	    /* On Android the VPNService protect function call will take of
+	       avoiding routing loops, so ignore this part and let
+	       remote_host_ipv6 always evaluate to false */
 	    if ( remote_host_ipv6 &&
 		  route_ipv6_match_host( r6, remote_host_ipv6 ) )
 	      {
@@ -776,7 +780,8 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
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


