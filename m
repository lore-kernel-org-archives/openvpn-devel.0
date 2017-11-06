From: selva.nair@...277...
Date: Sun,  5 Nov 2017 20:14:36 -0500
Message-Id: <1509930876-30728-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1509903249-10979-1-git-send-email-selva.nair@...277...>
References: <1509903249-10979-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Use lowest metric interface when
 multiple interfaces match a route
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
to use the interface with lowest metric. Implemented by

(i)  Do not over-write the return value with TUN_ADAPTER_INDEX_INVALID in
     windows_route_find_if_index() if multiple interfaces match a route.
(ii) Select the interface with lowest metric in adapter_index_of_ip()
     instead of the first one found when multiple interfaces match.

Reported by Jan Just Keijser <janjust@...1147...>

v2: - A private get_interface_metric() method and better error reporting
    - Revert an unintented edit of route.c (a_index = ...)
    - Improve the commit message

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/route.c |  1 -
 src/openvpn/tun.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8c71e6e..66a8ae3 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2780,7 +2780,6 @@ windows_route_find_if_index(const struct route_ipv4 *r, const struct tuntap *tt)
         msg(M_WARN, "Warning: route gateway is ambiguous: %s (%d matches)",
             print_in_addr_t(r->gateway, 0, &gc),
             count);
-        ret = TUN_ADAPTER_INDEX_INVALID;
     }
 
     dmsg(D_ROUTE_DEBUG, "DEBUG: route find if: on_tun=%d count=%d index=%d",
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3639718..7603133 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4474,6 +4474,49 @@ is_ip_in_adapter_subnet(const IP_ADAPTER_INFO *ai, const in_addr_t ip, in_addr_t
     return ret;
 }
 
+/**
+ * Given an interface index return the interface metric.
+ *
+ * Arguments:
+ *   index         : The index of the interface
+ *   family        : AF_INET for IPv4 or AF_INET6 for IPv6
+ * On error returns -1
+ */
+
+/* function signature missing in mingw iphlpapi.h */
+VOID NETIOAPI_API_
+InitializeIpInterfaceEntry(PMIB_IPINTERFACE_ROW Row);
+
+static int
+get_interface_metric(NET_IFINDEX index, ADDRESS_FAMILY family)
+{
+    DWORD err;
+    int msglevel = D_ROUTE|M_WARN;
+    MIB_IPINTERFACE_ROW ipiface;
+
+    InitializeIpInterfaceEntry(&ipiface);
+    ipiface.Family = family;
+    ipiface.InterfaceIndex = index;
+
+    err = GetIpInterfaceEntry(&ipiface);
+    if (err == NO_ERROR)
+    {
+        return ipiface.Metric;
+    }
+    else if (err == ERROR_NOT_FOUND)
+    {
+        /*
+         *  This happens if the address family is not enabled for the
+         *  interface, which is benign -- display only at a debug level
+         */
+        msglevel = D_ROUTE_DEBUG;
+    }
+    msg(msglevel, "Note: failed to determine metric of interface "
+                  "<%lu> for %s : (error code = %lu)",
+                  index, (family == AF_INET)? "ipv4" : "ipv6", err);
+    return -1;
+}
+
 DWORD
 adapter_index_of_ip(const IP_ADAPTER_INFO *list,
                     const in_addr_t ip,
@@ -4483,6 +4526,7 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
     struct gc_arena gc = gc_new();
     DWORD ret = TUN_ADAPTER_INDEX_INVALID;
     in_addr_t highest_netmask = 0;
+    int lowest_metric = INT_MAX;
     bool first = true;
 
     if (count)
@@ -4496,9 +4540,14 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
 
         if (is_ip_in_adapter_subnet(list, ip, &hn))
         {
+            int metric = get_interface_metric(list->Index, AF_INET);
             if (first || hn > highest_netmask)
             {
                 highest_netmask = hn;
+                if (metric >= 0)
+                {
+                    lowest_metric = metric;
+                }
                 if (count)
                 {
                     *count = 1;
@@ -4512,16 +4561,22 @@ adapter_index_of_ip(const IP_ADAPTER_INFO *list,
                 {
                     ++*count;
                 }
+                if (metric >= 0 && metric < lowest_metric)
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
+         lowest_metric);
 
     if (ret == TUN_ADAPTER_INDEX_INVALID && count)
     {
-- 
2.1.4


