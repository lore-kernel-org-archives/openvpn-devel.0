From: Gert Doering <gert@...1296...>
Date: Wed,  9 Oct 2019 11:52:00 +0200
Message-Id: <20191009095200.9337-2-gert@...1296...>
In-Reply-To: <20191009095200.9337-1-gert@...1296...>
References: <20191009095200.9337-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Fix IPv6 routes on tap interfaces on
 OpenSolaris/OpenIndiana
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

The "route add" code always used "metric 0" on OpenSolaris, because
(on tun interfaces) it was required to make the route work on
"non-ethernet" interfaces (connected, no NDP).

This breaks routes via tap interfaces on recent Solaris versions
(tested on OpenIndiana 2019) - there, routes only work if metric
is != 0 (or just not set).  Otherwise it tries to map the gateway
address to a local address and fails.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3183fb47..97e90e56 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2043,8 +2043,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
                 r6->netbits,
                 gateway );
 
-    /* on tun/tap, not "elsewhere"? -> metric 0 */
-    if (!r6->iface)
+    /* on tun (not tap), not "elsewhere"? -> metric 0 */
+    if (tt->type == DEV_TYPE_TUN && !r6->iface)
     {
         argv_printf_cat(&argv, "0");
     }
-- 
2.23.0


