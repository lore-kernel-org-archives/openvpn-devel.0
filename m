From: Gert Doering <gert@...1296...>
Date: Sun, 19 Mar 2017 20:10:49 +0100
Message-Id: <20170319191049.23970-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix installation of IPv6 host route to VPN
	server when using iservice.
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

The "prepare IPv6 route message to interactive service" was properly
handing the correct interface index (r->adapter_index) for this case,
but then always overwrote the gateway address with our magic tun/tap
fe80::8 value.  Only do this for "on tap adapter" routes.

Pinpointed by Selva Nair.

Trac #850

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 7e536ef..08998d5 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3061,8 +3061,10 @@ do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct t
 
     /* In TUN mode we use a special link-local address as the next hop.
      * The tapdrvr knows about it and will answer neighbor discovery packets.
+     * (only do this for routes actually using the tun/tap device)
      */
-    if (tt->type == DEV_TYPE_TUN)
+    if (tt->type == DEV_TYPE_TUN
+	 && msg.iface.index == tt->adapter_index )
     {
         inet_pton(AF_INET6, "fe80::8", &msg.gateway.ipv6);
     }
-- 
2.10.2


