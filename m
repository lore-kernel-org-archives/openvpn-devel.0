From: Antonio Quartulli <a@...2181...>
Date: Tue, 31 Jan 2017 19:21:31 +0800
Message-Id: <20170131112131.13570-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] attempt to add IPv6 route even when no IPv6
	address was configured
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
Cc: Antonio Quartulli <a@...2181...>

Even if no IPv6 address is configured, OpenVPN still supports
transporting IPv6 segments, therefore adding an IPv6 route
should always be allowed.

However, the route might fail to be installed or may just not work
as expected, therefore, a proper warning should be printed to inform
the user of the possible pitfall.

Always allow adding an IPv6 route and print a WARNING when
no IPv6 address is configured for the interface.

Trac: #832
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/route.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 223cb5f4..0145db3c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1196,6 +1196,15 @@ add_routes(struct route_list *rl, struct route_ipv6_list *rl6, const struct tunt
     if (rl6 && !(rl6->iflags & RL_ROUTES_ADDED) )
     {
         struct route_ipv6 *r;
+
+        if (!tt->did_ifconfig_ipv6_setup)
+        {
+            msg(M_INFO, "WARNING: OpenVPN was configured to add an IPv6 "
+                "route over %s. However, no IPv6 has been configured for "
+                "this interface, therefore the route installation may "
+                "fail or may not work as expected.", tt->actual_name);
+        }
+
         for (r = rl6->routes_ipv6; r; r = r->next)
         {
             if (flags & ROUTE_DELETE_FIRST)
@@ -1882,14 +1891,6 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     }
 #endif
 
-    if (!tt->did_ifconfig_ipv6_setup)
-    {
-        msg( M_INFO, "add_route_ipv6(): not adding %s/%d: "
-             "no IPv6 address been configured on interface %s",
-             network, r6->netbits, device);
-        return;
-    }
-
     msg( M_INFO, "add_route_ipv6(%s/%d -> %s metric %d) dev %s",
          network, r6->netbits, gateway, r6->metric, device );
 
-- 
2.11.0


