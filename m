From: Antonio Quartulli <a@...2181...>
Date: Wed, 10 Jun 2020 10:45:49 +0200
Message-Id: <20200610084549.4028-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] multi: skip IPv4 logic in
 multi_select_virtual_addr() if no pool is configured
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
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>

When no IPv4 pool is configured (but we have an IPv6 pool
only), the multi_select_virtual_addr() function will spit
a warning when allocating an address for a new client.
This happens because the code will check for some IPv4
bits and will see that they are missing.

However, these bits are not really important, because in
this use case we don't want to configure any IPv4 address
at all.

For this reason it is safe to wrap this entire logic in
an if-block that just does not execute when no IPv4 pool
is configured.

This avoids the warning and will also avoid any other
hidden side effect.

Reported-by: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/multi.c | 50 ++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2fbbe9ec..99472f14 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1504,36 +1504,40 @@ multi_select_virtual_addr(struct multi_context *m, struct multi_instance *mi)
                   ? print_in6_addr( remote_ipv6, 0, &gc )
                   : "(Not enabled)") );
 
-            /* set push_ifconfig_remote_netmask from pool ifconfig address(es) */
-            mi->context.c2.push_ifconfig_local = remote;
-            if (tunnel_type == DEV_TYPE_TAP || (tunnel_type == DEV_TYPE_TUN && tunnel_topology == TOP_SUBNET))
+            if (mi->context.options.ifconfig_pool_defined)
             {
-                mi->context.c2.push_ifconfig_remote_netmask = mi->context.options.ifconfig_pool_netmask;
-                if (!mi->context.c2.push_ifconfig_remote_netmask)
+                /* set push_ifconfig_remote_netmask from pool ifconfig address(es) */
+                mi->context.c2.push_ifconfig_local = remote;
+                if (tunnel_type == DEV_TYPE_TAP || (tunnel_type == DEV_TYPE_TUN && tunnel_topology == TOP_SUBNET))
                 {
-                    mi->context.c2.push_ifconfig_remote_netmask = mi->context.c1.tuntap->remote_netmask;
+                    mi->context.c2.push_ifconfig_remote_netmask = mi->context.options.ifconfig_pool_netmask;
+                    if (!mi->context.c2.push_ifconfig_remote_netmask)
+                    {
+                        mi->context.c2.push_ifconfig_remote_netmask = mi->context.c1.tuntap->remote_netmask;
+                    }
                 }
-            }
-            else if (tunnel_type == DEV_TYPE_TUN)
-            {
-                if (tunnel_topology == TOP_P2P)
+                else if (tunnel_type == DEV_TYPE_TUN)
                 {
-                    mi->context.c2.push_ifconfig_remote_netmask = mi->context.c1.tuntap->local;
+                    if (tunnel_topology == TOP_P2P)
+                    {
+                        mi->context.c2.push_ifconfig_remote_netmask = mi->context.c1.tuntap->local;
+                    }
+                    else if (tunnel_topology == TOP_NET30)
+                    {
+                        mi->context.c2.push_ifconfig_remote_netmask = local;
+                    }
                 }
-                else if (tunnel_topology == TOP_NET30)
+
+                if (mi->context.c2.push_ifconfig_remote_netmask)
                 {
-                    mi->context.c2.push_ifconfig_remote_netmask = local;
+                    mi->context.c2.push_ifconfig_defined = true;
+                }
+                else
+                {
+                    msg(D_MULTI_ERRORS,
+                        "MULTI: no --ifconfig-pool netmask parameter is available to push to %s",
+                        multi_instance_string(mi, false, &gc));
                 }
-            }
-
-            if (mi->context.c2.push_ifconfig_remote_netmask)
-            {
-                mi->context.c2.push_ifconfig_defined = true;
-            }
-            else
-            {
-                msg(D_MULTI_ERRORS, "MULTI: no --ifconfig-pool netmask parameter is available to push to %s",
-                    multi_instance_string(mi, false, &gc));
             }
 
             if (mi->context.options.ifconfig_ipv6_pool_defined)
-- 
2.27.0


