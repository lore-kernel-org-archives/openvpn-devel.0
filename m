From: Gert Doering <gert@...1296...>
Date: Fri,  3 May 2013 21:13:24 +0200
Message-Id: <1367608404-2257-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix NULL-pointer crash in
	route_list_add_vpn_gateway().
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

Add ASSERT() check to route_list_add_vpn_gateway() to ensure that *rl
is valid (and if not, crash with a somewhat more meaningful message than
"segmentation violation").  For the actual bugfix, change init code to
always allocate a "struct route_list" for IPv4, even if no --route options
have been seen in the config.

Fix trac#281 and trac#258.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c  | 7 ++++---
 src/openvpn/route.c | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 98f5489..694d086 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1145,13 +1145,14 @@ do_init_traffic_shaper (struct context *c)
 }
 
 /*
- * Allocate a route list structure if at least one
- * --route option was specified.
+ * Allocate route list structures for IPv4 and IPv6
+ * (we do this for IPv4 even if no --route option has been seen, as other
+ * parts of OpenVPN might want to fill the route-list with info, e.g. DHCP)
  */
 static void
 do_alloc_route_list (struct context *c)
 {
-  if (c->options.routes && !c->c1.route_list)
+  if (!c->c1.route_list)
     c->c1.route_list = new_route_list (c->options.max_routes, &c->gc);
   if (c->options.routes_ipv6 && !c->c1.route_ipv6_list)
     c->c1.route_ipv6_list = new_route_ipv6_list (c->options.max_routes, &c->gc);
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index f5b5efa..72ecbaf 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -503,6 +503,7 @@ route_list_add_vpn_gateway (struct route_list *rl,
 			    struct env_set *es,
 			    const in_addr_t addr)
 {
+  ASSERT(rl);
   rl->spec.remote_endpoint = addr;
   rl->spec.flags |= RTSA_REMOTE_ENDPOINT;
   setenv_route_addr (es, "vpn_gateway", rl->spec.remote_endpoint, -1);
-- 
1.8.1.5


