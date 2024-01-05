From: Steffan Karger <steffan@...1856...>
Date: Fri,  5 Jan 2024 14:57:42 +0100
Message-Id: <20240105135742.21174-1-steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix IPv6 route add/delete message log level
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

We have D_ROUTE for route addition/deletion messages, which prints at
loglevel 3. Use that for IPv6, like we do for IPv4 to reduce terminal
spam for non-legacy-networking setups. Prvious code would print the
messages at --verb 1.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/route.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2f472a1f..e784782b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1940,10 +1940,10 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
 #endif
 
 #ifndef _WIN32
-    msg( M_INFO, "add_route_ipv6(%s/%d -> %s metric %d) dev %s",
+    msg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) dev %s",
          network, r6->netbits, gateway, r6->metric, device );
 #else
-    msg( M_INFO, "add_route_ipv6(%s/%d -> %s metric %d) IF %lu",
+    msg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) IF %lu",
          network, r6->netbits, gateway, r6->metric,
          r6->adapter_index ? r6->adapter_index : tt->adapter_index);
 #endif
@@ -2394,7 +2394,7 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
     }
 #endif
 
-    msg( M_INFO, "delete_route_ipv6(%s/%d)", network, r6->netbits );
+    msg(D_ROUTE, "delete_route_ipv6(%s/%d)", network, r6->netbits );
 
 #if defined(TARGET_LINUX)
     int metric = -1;
-- 
2.34.1


