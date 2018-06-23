From: Antonio Quartulli <a@...2181...>
Date: Sun, 24 Jun 2018 02:31:08 +0800
Message-Id: <20180623183108.18684-1-a@...2181...>
In-Reply-To: <20180613141213.5962-1-a@...2181...>
References: <20180613141213.5962-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v4 2/8] windows: properly configure TAP
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

This patch ensures that the TAP driver on a windows host is still
configured, even though no IPv4 has been provided.

In this case the TAP driver ioctl will be invoked with a fake
0.0.0.0/0.0.0.0 IPv4 which will simply start the interface and
get it to a working state.

Trac: #208
Signed-off-by: Antonio Quartulli <antonio@...515...>
---

Changes from v2:
- rebased on top ov v4 1/8
- extended commit message
- moved did_ifconfig_setup check into test_routes()
- added longer comment into test_routes() to explain check condition

Changes from v3:
- fixed typ0 in condition in test_routes(): from 'c->c1.tuntap' to 'tt'
- tested on Win10 against ipv6-only and ipv6+ipv4 server (on same LAN)


 src/openvpn/route.c |  6 +++++-
 src/openvpn/tun.c   | 24 +++++++++++++++++-------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8990a986..f6962848 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2642,7 +2642,11 @@ test_routes(const struct route_list *rl, const struct tuntap *tt)
         ret = true;
         adapter_up = true;
 
-        if (rl)
+        /* we do this test only if we have IPv4 routes to install, and if
+         * the tun/tap interface has seen IPv4 ifconfig - because if we
+         * have no IPv4, the check will always fail, failing tun init
+         */
+        if (rl && tt->did_ifconfig_setup)
         {
             struct route_ipv4 *r;
             for (r = rl->routes, len = 0; r; r = r->next, ++len)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 2e1c96e6..f9b9c716 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5703,7 +5703,10 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
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
@@ -5716,12 +5719,19 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
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


