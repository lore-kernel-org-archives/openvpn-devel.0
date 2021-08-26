From: Antonio Quartulli <a@...2181...>
Date: Thu, 26 Aug 2021 08:17:25 +0200
Message-Id: <20210826061725.22169-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] route.c: pass the right parameter to
 IN6_IS_ADDR_UNSPECIFIED
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

IN6_IS_ADDR_UNSPECIFIED on most systems is defined as a macro that
expects a struct in6_addr* argument.

In one instance we are passing the right address but using a wrong type.
Fix this invocation by properly passing the right pointer.

This issue might become more critical on systems implementing
IN6_IS_ADDR_UNSPECIFIED as a function rather than a macro.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2905e432..fd1125ef 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3360,7 +3360,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
     if (net_route_v6_best_gw(ctx, dest, &rgi6->gateway.addr_ipv6,
                              rgi6->iface) == 0)
     {
-        if (!IN6_IS_ADDR_UNSPECIFIED(rgi6->gateway.addr_ipv6.s6_addr))
+        if (!IN6_IS_ADDR_UNSPECIFIED(&rgi6->gateway.addr_ipv6))
         {
             rgi6->flags |= RGI_ADDR_DEFINED;
         }
-- 
2.31.1


