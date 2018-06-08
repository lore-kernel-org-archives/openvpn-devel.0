From: Antonio Quartulli <a@...2181...>
Date: Fri,  8 Jun 2018 13:20:11 +0800
Message-Id: <20180608052017.6696-3-a@...2181...>
In-Reply-To: <20180608052017.6696-1-a@...2181...>
References: <20180608052017.6696-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/forward.c |  4 +++-
 src/openvpn/tun.c     | 24 +++++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 7d9a338d..51e43c28 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -292,7 +292,9 @@ check_add_routes_action(struct context *c, const bool errors)
 void
 check_add_routes_dowork(struct context *c)
 {
-    if (test_routes(c->c1.route_list, c->c1.tuntap))
+    /* skip route check if no IPv4 was configured */
+    if (!c->c1.tuntap->did_ifconfig_setup
+        || test_routes(c->c1.route_list, c->c1.tuntap))
     {
         check_add_routes_action(c, false);
     }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8509d489..d183aea7 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5718,7 +5718,10 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             msg(M_FATAL, "ERROR: --dev tun also requires --ifconfig");
         }
 
-        if (tt->topology == TOP_SUBNET)
+        /* send 0/0/0 to the TAP driver even if we have no IPv4 configured to
+         * ensure it is somehow initialized.
+         */
+        if (!tt->did_ifconfig_setup || tt->topology == TOP_SUBNET)
         {
             in_addr_t ep[3];
             BOOL status;
@@ -5731,12 +5734,19 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
                                      ep, sizeof(ep),
                                      ep, sizeof(ep), &len, NULL);
 
-            msg(status ? M_INFO : M_FATAL, "Set TAP-Windows TUN subnet mode network/local/netmask = %s/%s/%s [%s]",
-                print_in_addr_t(ep[1], IA_NET_ORDER, &gc),
-                print_in_addr_t(ep[0], IA_NET_ORDER, &gc),
-                print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
-                status ? "SUCCEEDED" : "FAILED");
-
+            if (tt->did_ifconfig_setup)
+            {
+                msg(status ? M_INFO : M_FATAL, "Set TAP-Windows TUN subnet mode network/local/netmask = %s/%s/%s [%s]",
+                    print_in_addr_t(ep[1], IA_NET_ORDER, &gc),
+                    print_in_addr_t(ep[0], IA_NET_ORDER, &gc),
+                    print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
+                    status ? "SUCCEEDED" : "FAILED");
+            }
+            else
+            {
+                msg(status ? M_INFO : M_FATAL, "Set TAP-Windows TUN with fake IPv4 [%s]",
+                    status ? "SUCCEEDED" : "FAILED");
+            }
         }
         else
         {
-- 
2.17.1


