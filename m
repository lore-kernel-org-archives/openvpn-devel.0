From: selva.nair@...277...
Date: Tue,  5 Dec 2017 23:28:41 -0500
Message-Id: <1512534521-14760-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Refactor get_interface_metric to return
 metric and auto flag separately
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

- Instead of returning metric = 0 when automatic metric is in use
  return the actual metric and flag automatic metric through a
  parameter. This makes the function reusable elsewhere.

- Ensure return value can be correctly cast to int and return -1 on
  error.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/block_dns.c       | 30 ++++++++++++++++++++----------
 src/openvpn/block_dns.h       | 14 +++++++-------
 src/openvpn/win32.c           | 15 +++++++--------
 src/openvpnserv/interactive.c | 13 +++++++------
 4 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index d43cbcf..8d5011d 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -344,33 +344,43 @@ delete_block_dns_filters(HANDLE engine_handle)
 }
 
 /*
- * Returns interface metric value for specified interface index.
+ * Return interface metric value for the specified interface index.
  *
  * Arguments:
  *   index         : The index of TAP adapter.
  *   family        : Address family (AF_INET for IPv4 and AF_INET6 for IPv6).
- * Returns positive metric value or zero for automatic metric on success,
- * a less then zero error code on failure.
+ *   is_auto       : On return set to true if automatic metric is in use.
+ *                   Unused if NULL.
+ *
+ * Returns positive metric value or -1 on error.
  */
-
 int
-get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family)
+get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family, int *is_auto)
 {
     DWORD err = 0;
     MIB_IPINTERFACE_ROW ipiface;
     InitializeIpInterfaceEntry(&ipiface);
     ipiface.Family = family;
     ipiface.InterfaceIndex = index;
+
+    if (is_auto)
+    {
+        *is_auto = 0;
+    }
     err = GetIpInterfaceEntry(&ipiface);
-    if (err == NO_ERROR)
+
+    /* On Windows metric is never > INT_MAX so return value of int is ok.
+     * But we check for overflow nevertheless.
+     */
+    if (err == NO_ERROR && ipiface.Metric <= INT_MAX)
     {
-        if (ipiface.UseAutomaticMetric)
+        if (is_auto)
         {
-            return 0;
+            *is_auto = ipiface.UseAutomaticMetric;
         }
-        return ipiface.Metric;
+        return (int)ipiface.Metric;
     }
-    return -err;
+    return -1;
 }
 
 /*
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
index c9a9d70..50b383f 100644
--- a/src/openvpn/block_dns.h
+++ b/src/openvpn/block_dns.h
@@ -39,17 +39,17 @@ add_block_dns_filters(HANDLE *engine, int iface_index, const WCHAR *exe_path,
                       block_dns_msg_handler_t msg_handler_callback);
 
 /**
- * Returns interface metric value for specified interface index.
+ * Return interface metric value for the specified interface index.
  *
- * @param index The index of TAP adapter
- * @param family Address family (AF_INET for IPv4 and AF_INET6 for IPv6)
+ * @param index         The index of TAP adapter.
+ * @param family        Address family (AF_INET for IPv4 and AF_INET6 for IPv6).
+ * @param is_auto       On return set to true if automatic metric is in use.
+ *                      Unused if NULL.
  *
- * @return positive metric value or zero for automatic metric on success,
- * a less then zero error code on failure.
+ * @return positive interface metric on success or -1 on error
  */
-
 int
-get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family);
+get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family, int *is_auto);
 
 /**
  * Sets interface metric value for specified interface index.
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 95fea5d..4b20298 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1344,17 +1344,16 @@ win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel)
                                    block_dns_msg_handler);
     if (status == 0)
     {
-        tap_metric_v4 = get_interface_metric(index, AF_INET);
-        tap_metric_v6 = get_interface_metric(index, AF_INET6);
-        if (tap_metric_v4 < 0)
+        int is_auto = 0;
+        tap_metric_v4 = get_interface_metric(index, AF_INET, &is_auto);
+        if (is_auto)
         {
-            /* error, should not restore metric */
-            tap_metric_v4 = -1;
+            tap_metric_v4 = 0;
         }
-        if (tap_metric_v6 < 0)
+        tap_metric_v6 = get_interface_metric(index, AF_INET6, &is_auto);
+        if (is_auto)
         {
-            /* error, should not restore metric */
-            tap_metric_v6 = -1;
+            tap_metric_v6 = 0;
         }
         status = set_interface_metric(index, AF_INET, BLOCK_DNS_IFACE_METRIC);
         if (!status)
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index aab784e..3907438 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -804,17 +804,18 @@ HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
             }
             interface_data->engine = engine;
             interface_data->index = msg->iface.index;
+            int is_auto = 0;
             interface_data->metric_v4 = get_interface_metric(msg->iface.index,
-                                                             AF_INET);
-            if (interface_data->metric_v4 < 0)
+                                                             AF_INET, &is_auto);
+            if (is_auto)
             {
-                interface_data->metric_v4 = -1;
+                interface_data->metric_v4 = 0;
             }
             interface_data->metric_v6 = get_interface_metric(msg->iface.index,
-                                                             AF_INET6);
-            if (interface_data->metric_v6 < 0)
+                                                             AF_INET6, &is_auto);
+            if (is_auto)
             {
-                interface_data->metric_v6 = -1;
+                interface_data->metric_v6 = 0;
             }
             err = AddListItem(&(*lists)[block_dns], interface_data);
             if (!err)
-- 
2.1.4


