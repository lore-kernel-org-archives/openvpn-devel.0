From: Tom Yan <tom.ty89@...277...>
Date: Wed, 13 Nov 2019 18:07:00 +0800
Message-Id: <20191113100702.6863-2-tom.ty89@...277...>
In-Reply-To: <61c1b837-3f81-6783-5934-8128bb81881b@...2181...>
References: <61c1b837-3f81-6783-5934-8128bb81881b@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/4] Fix server directive for /31 subnet
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

As /31 subnet now works (as we stop setting broadcast address), the server directives can be fixed for it as well.
---
 src/openvpn/helper.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 470b9120..5b2ca0cc 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -328,31 +328,36 @@ helper_client_server(struct options *o)
         }
         else if (dev == DEV_TYPE_TAP || (dev == DEV_TYPE_TUN && topology == TOP_SUBNET))
         {
-            if (netbits > 30)
+            int ptp = 1;
+
+            if (netbits > 31)
             {
                 msg(M_USAGE, "subnet must be %s or lower",
-                    print_netmask(30, &gc));
+                    print_netmask(31, &gc));
             }
 
+            if (netbits == 31)
+                ptp = 0;
+
             o->mode = MODE_SERVER;
             o->tls_server = true;
 
-            o->ifconfig_local = print_in_addr_t(o->server_network + 1, 0, &o->gc);
+            o->ifconfig_local = print_in_addr_t(o->server_network + ptp, 0, &o->gc);
             o->ifconfig_remote_netmask = print_in_addr_t(o->server_netmask, 0, &o->gc);
 
             if (!(o->server_flags & SF_NOPOOL))
             {
                 o->ifconfig_pool_defined = true;
-                o->ifconfig_pool_start = o->server_network + 2;
-                o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - 2;
+                o->ifconfig_pool_start = o->server_network + ptp + 1;
+                o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - ptp * 2;
                 ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
             }
             o->ifconfig_pool_netmask = o->server_netmask;
 
-            push_option(o, print_opt_route_gateway(o->server_network + 1, &o->gc), M_USAGE);
+            push_option(o, print_opt_route_gateway(o->server_network + ptp, &o->gc), M_USAGE);
             if (dev == DEV_TYPE_TUN && !o->route_default_gateway)
             {
-                o->route_default_gateway = print_in_addr_t(o->server_network + 2, 0, &o->gc);
+                o->route_default_gateway = print_in_addr_t(o->server_network + ptp + 1, 0, &o->gc);
             }
         }
         else
-- 
2.24.0


