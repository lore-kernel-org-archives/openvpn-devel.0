From: selva.nair@...277...
Date: Sun,  5 Nov 2017 12:34:09 -0500
Message-Id: <1509903249-10979-1-git-send-email-selva.nair@...277...>
In-Reply-To: <20171105171135.GL958@...1296...>
References: <20171105171135.GL958@...1296...>
Subject: [Openvpn-devel] [PATCH] Use lowest metric interface when multiple
 interfaces match a route
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

From: Selva Nair <selva.nair@...277...>

Currently a route addition using IPAPI or service is skipped if the
route gateway is reachable by multiple interfaces. This changes that
to use the interface with lowest metric.

Reported by Jan Just Keijser <janjust@...1147...>

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/route.c |  3 +--
 src/openvpn/tun.c   | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8c71e6e..3937018 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2729,7 +2729,7 @@ get_default_gateway(struct route_gateway_info *rgi)
         if (rgi->gateway.addr)
         {
             rgi->flags |= RGI_ADDR_DEFINED;
-            a_index = adapter_index_of_ip(adapters, rgi->gateway.addr, NULL, &rgi->gateway.netmask);
+            a_index = dwForwardIfIndex;
             if (a_index != TUN_ADAPTER_INDEX_INVALID)
             {
                 rgi->adapter_index = a_index;
@@ -2780,7 +2780,6 @@ windows_route_find_if_index(const struct route_ipv4 *r, const struct tuntap *tt)
         msg(M_WARN, "Warning: route gateway is ambiguous: %s (%d matches)",
             print_in_addr_t(r->gateway, 0, &gc),
             count);
-        ret = TUN_ADAPTER_INDEX_INVALID;
     }
 
     dmsg(D_ROUTE_DEBUG, "DEBUG: route find if: on_tun=%d count=%d index=%d",
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3639718..d0461ef 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -45,6 +45,7 @@
 #include "manage.h"
 #include "route.h"
 #include "win32.h"
+#include "block_dns.h"
 
 #include "memdbg.h"
 
@@ -4483,6 +4484,7 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
     struct gc_arena gc = gc_new();
     DWORD ret = TUN_ADAPTER_INDEX_INVALID;
     in_addr_t highest_netmask = 0;
+    int lowest_metric = INT_MAX;
     bool first = true;
 
     if (count)
@@ -4496,9 +4498,11 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
 
         if (is_ip_in_adapter_subnet(list, ip, &hn))
         {
+            int metric = get_interface_metric(list->Index, AF_INET);
             if (first || hn > highest_netmask)
             {
                 highest_netmask = hn;
+                lowest_metric = metric;
                 if (count)
                 {
                     *count = 1;
@@ -4512,16 +4516,22 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
                 {
                     ++*count;
                 }
+                if (metric < lowest_metric)
+                {
+                    ret = list->Index;
+                    lowest_metric = metric;
+                }
             }
         }
         list = list->Next;
     }
 
-    dmsg(D_ROUTE_DEBUG, "DEBUG: IP Locate: ip=%s nm=%s index=%d count=%d",
+    dmsg(D_ROUTE_DEBUG, "DEBUG: IP Locate: ip=%s nm=%s index=%d count=%d metric=%d",
          print_in_addr_t(ip, 0, &gc),
          print_in_addr_t(highest_netmask, 0, &gc),
          (int)ret,
-         count ? *count : -1);
+         count ? *count : -1,
+         metric);
 
     if (ret == TUN_ADAPTER_INDEX_INVALID && count)
     {
-- 
2.1.4


