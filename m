From: Tom Yan <tom.ty89@...277...>
Date: Wed, 13 Nov 2019 18:06:59 +0800
Message-Id: <20191113100702.6863-1-tom.ty89@...277...>
In-Reply-To: <61c1b837-3f81-6783-5934-8128bb81881b@...2181...>
References: <61c1b837-3f81-6783-5934-8128bb81881b@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/4] Avoid repeating code for tap and
 tun+subnet in server directive
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

It also avoids limitation (i.e. netbits <= 29) that does not apply to the subnet topology.
---
 src/openvpn/helper.c | 74 ++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 47 deletions(-)

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index ff9df506..470b9120 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -286,13 +286,13 @@ helper_client_server(struct options *o)
                 print_netmask(IFCONFIG_POOL_MIN_NETBITS, &gc));
         }
 
-        if (dev == DEV_TYPE_TUN)
+        if (dev == DEV_TYPE_TUN && (topology == TOP_NET30 || topology == TOP_P2P))
         {
             int pool_end_reserve = 4;
 
             if (netbits > 29)
             {
-                msg(M_USAGE, "--server directive when used with --dev tun must define a subnet of %s or lower",
+                msg(M_USAGE, "subnet must be %s or lower",
                     print_netmask(29, &gc));
             }
 
@@ -304,66 +304,39 @@ helper_client_server(struct options *o)
             o->mode = MODE_SERVER;
             o->tls_server = true;
 
-            if (topology == TOP_NET30 || topology == TOP_P2P)
+            o->ifconfig_local = print_in_addr_t(o->server_network + 1, 0, &o->gc);
+            o->ifconfig_remote_netmask = print_in_addr_t(o->server_network + 2, 0, &o->gc);
+
+            if (!(o->server_flags & SF_NOPOOL))
             {
-                o->ifconfig_local = print_in_addr_t(o->server_network + 1, 0, &o->gc);
-                o->ifconfig_remote_netmask = print_in_addr_t(o->server_network + 2, 0, &o->gc);
-
-                if (!(o->server_flags & SF_NOPOOL))
-                {
-                    o->ifconfig_pool_defined = true;
-                    o->ifconfig_pool_start = o->server_network + 4;
-                    o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - pool_end_reserve;
-                    ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
-                }
-
-                helper_add_route(o->server_network, o->server_netmask, o);
-                if (o->enable_c2c)
-                {
-                    push_option(o, print_opt_route(o->server_network, o->server_netmask, &o->gc), M_USAGE);
-                }
-                else if (topology == TOP_NET30)
-                {
-                    push_option(o, print_opt_route(o->server_network + 1, 0, &o->gc), M_USAGE);
-                }
+                o->ifconfig_pool_defined = true;
+                o->ifconfig_pool_start = o->server_network + 4;
+                o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - pool_end_reserve;
+                ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
             }
-            else if (topology == TOP_SUBNET)
+
+            helper_add_route(o->server_network, o->server_netmask, o);
+            if (o->enable_c2c)
             {
-                o->ifconfig_local = print_in_addr_t(o->server_network + 1, 0, &o->gc);
-                o->ifconfig_remote_netmask = print_in_addr_t(o->server_netmask, 0, &o->gc);
-
-                if (!(o->server_flags & SF_NOPOOL))
-                {
-                    o->ifconfig_pool_defined = true;
-                    o->ifconfig_pool_start = o->server_network + 2;
-                    o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - 2;
-                    ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
-                }
-                o->ifconfig_pool_netmask = o->server_netmask;
-
-                push_option(o, print_opt_route_gateway(o->server_network + 1, &o->gc), M_USAGE);
-                if (!o->route_default_gateway)
-                {
-                    o->route_default_gateway = print_in_addr_t(o->server_network + 2, 0, &o->gc);
-                }
+                push_option(o, print_opt_route(o->server_network, o->server_netmask, &o->gc), M_USAGE);
             }
-            else
+            else if (topology == TOP_NET30)
             {
-                ASSERT(0);
+                push_option(o, print_opt_route(o->server_network + 1, 0, &o->gc), M_USAGE);
             }
 
-            push_option(o, print_opt_topology(topology, &o->gc), M_USAGE);
         }
-        else if (dev == DEV_TYPE_TAP)
+        else if (dev == DEV_TYPE_TAP || (dev == DEV_TYPE_TUN && topology == TOP_SUBNET))
         {
             if (netbits > 30)
             {
-                msg(M_USAGE, "--server directive when used with --dev tap must define a subnet of %s or lower",
+                msg(M_USAGE, "subnet must be %s or lower",
                     print_netmask(30, &gc));
             }
 
             o->mode = MODE_SERVER;
             o->tls_server = true;
+
             o->ifconfig_local = print_in_addr_t(o->server_network + 1, 0, &o->gc);
             o->ifconfig_remote_netmask = print_in_addr_t(o->server_netmask, 0, &o->gc);
 
@@ -371,18 +344,25 @@ helper_client_server(struct options *o)
             {
                 o->ifconfig_pool_defined = true;
                 o->ifconfig_pool_start = o->server_network + 2;
-                o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - 1;
+                o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - 2;
                 ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
             }
             o->ifconfig_pool_netmask = o->server_netmask;
 
             push_option(o, print_opt_route_gateway(o->server_network + 1, &o->gc), M_USAGE);
+            if (dev == DEV_TYPE_TUN && !o->route_default_gateway)
+            {
+                o->route_default_gateway = print_in_addr_t(o->server_network + 2, 0, &o->gc);
+            }
         }
         else
         {
             ASSERT(0);
         }
 
+        if (dev == DEV_TYPE_TUN)
+            push_option(o, print_opt_topology(topology, &o->gc), M_USAGE);
+
         /* set push-ifconfig-constraint directive */
         if ((dev == DEV_TYPE_TAP || topology == TOP_SUBNET))
         {
-- 
2.24.0


