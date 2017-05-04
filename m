From: ValdikSS <valdikss@...277...>
Date: Thu,  4 May 2017 20:36:05 +0300
Message-Id: <20170504173605.8269-1-valdikss@...277...>
Subject: [Openvpn-devel] [PATCH] Set a low interface metric for tap adapter
	when block-outside-dns is in use
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
Cc: ValdikSS <iam@...2070...>

From: ValdikSS <iam@...2070...>

Windows 10 before Creators Update used to resolve DNS using all available adapters and IP addresses in parallel.
Now it still resolves addresses using all available adapters but in a round-robin way, beginning with random adapter.
This behaviour introduces significant delay when block-outside-dns is in use.
Fortunately, setting low metric for the TAP interface solves this issue, making Windows always pick with TAP adapter first.
---
 src/openvpn/block_dns.c       | 75 +++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/block_dns.h       | 30 +++++++++++++++++
 src/openvpn/init.c            |  4 +--
 src/openvpn/win32.c           | 29 +++++++++++++++--
 src/openvpn/win32.h           |  2 +-
 src/openvpnserv/interactive.c | 61 ++++++++++++++++++++++++++++++++---
 6 files changed, 191 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index e31765e..9d49355 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -341,4 +341,79 @@ delete_block_dns_filters(HANDLE engine_handle)
     return err;
 }
 
+/* 
+ * Returns interface metric value for specified interface index.
+ * 
+ * Arguments:
+ *   index         : The index of TAP adapter.
+ *   family        : Address family (AF_INET for IPv4 and AF_INET6 for IPv6).
+ * Returns positive metric value or zero for automatic metric on success,
+ * a less then zero error code on failure.
+ */
+
+int
+get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family)
+{
+    DWORD err = 0;
+    MIB_IPINTERFACE_ROW ipiface;
+    InitializeIpInterfaceEntry(&ipiface);
+    ipiface.Family = family;
+    ipiface.InterfaceIndex = index;
+    err = GetIpInterfaceEntry(&ipiface);
+    if (err == NO_ERROR)
+    {
+        if (ipiface.UseAutomaticMetric)
+        {
+            return 0;
+        }
+        return ipiface.Metric;
+    }
+    return -err;
+}
+
+/* 
+ * Sets interface metric value for specified interface index.
+ * 
+ * Arguments:
+ *   index         : The index of TAP adapter.
+ *   family        : Address family (AF_INET for IPv4 and AF_INET6 for IPv6).
+ *   metric        : Metric value. 0 for automatic metric.
+ * Returns 0 on success, a non-zero status code of the last failed action on failure.
+ */
+
+DWORD
+set_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family,
+                     const ULONG metric)
+{
+    DWORD err = 0;
+    MIB_IPINTERFACE_ROW ipiface;
+    InitializeIpInterfaceEntry(&ipiface);
+    ipiface.Family = family;
+    ipiface.InterfaceIndex = index;
+    err = GetIpInterfaceEntry(&ipiface);
+    if (err == NO_ERROR)
+    {
+        if (family == AF_INET)
+        {
+            /* required for IPv4 as per MSDN */
+            ipiface.SitePrefixLength = 0;
+        }
+        ipiface.Metric = metric;
+        if (metric == 0)
+        {
+            ipiface.UseAutomaticMetric = TRUE;
+        }
+        else
+        {
+            ipiface.UseAutomaticMetric = FALSE;
+        }
+        err = SetIpInterfaceEntry(&ipiface);
+        if (err == NO_ERROR)
+        {
+            return 0;
+        }
+    }
+    return err;
+}
+
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
index a7dadc4..e7b1cca 100644
--- a/src/openvpn/block_dns.h
+++ b/src/openvpn/block_dns.h
@@ -27,6 +27,9 @@
 #ifndef OPENVPN_BLOCK_DNS_H
 #define OPENVPN_BLOCK_DNS_H
 
+/* Any value less than 5 should work fine. 3 is choosen without any real reason. */
+#define BLOCK_DNS_IFACE_METRIC 3
+
 typedef void (*block_dns_msg_handler_t) (DWORD err, const char *msg);
 
 DWORD
@@ -36,5 +39,32 @@ DWORD
 add_block_dns_filters(HANDLE *engine, int iface_index, const WCHAR *exe_path,
                       block_dns_msg_handler_t msg_handler_callback);
 
+/**
+ * Sets interface metric value for specified interface index
+ *
+ * @param index The index of TAP adapter
+ * @param family Address family (AF_INET for IPv4 and AF_INET6 for IPv6)
+ * 
+ * @return positive metric value or zero for automatic metric on success,
+ * a less then zero error code on failure.
+ */
+
+int
+get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family);
+
+/**
+ * Sets interface metric value for specified interface index
+ *
+ * @param index The index of TAP adapter
+ * @param family Address family (AF_INET for IPv4 and AF_INET6 for IPv6)
+ * @param metric Metric value. 0 for automatic metric
+ * 
+ * @return 0 on success, a non-zero status code of the last failed action on failure.
+ */
+
+DWORD
+set_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family,
+                     const ULONG metric);
+
 #endif
 #endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ee14f67..2a2e7b0 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1837,7 +1837,7 @@ do_close_tun(struct context *c, bool force)
 #if defined(_WIN32)
             if (c->options.block_outside_dns)
             {
-                if (!win_wfp_uninit(c->options.msg_channel))
+                if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
                 {
                     msg(M_FATAL, "Uninitialising WFP failed!");
                 }
@@ -1877,7 +1877,7 @@ do_close_tun(struct context *c, bool force)
 #if defined(_WIN32)
             if (c->options.block_outside_dns)
             {
-                if (!win_wfp_uninit(c->options.msg_channel))
+                if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
                 {
                     msg(M_FATAL, "Uninitialising WFP failed!");
                 }
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 18e7aee..dc411fc 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -61,6 +61,11 @@
 static HANDLE m_hEngineHandle = NULL; /* GLOBAL */
 
 /*
+ * TAP adapter original metric value
+ */
+static int tap_metric = -1; /* GLOBAL */
+
+/*
  * Windows internal socket API state (opaque).
  */
 static struct WSAData wsa_state; /* GLOBAL */
@@ -1337,6 +1342,21 @@ win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel)
 
     status = add_block_dns_filters(&m_hEngineHandle, index, openvpnpath,
                                    block_dns_msg_handler);
+    if (status == 0)
+    {
+        tap_metric = get_interface_metric(index, AF_INET);
+        if (tap_metric < 0)
+        {
+            /* error, should not restore metric */
+            tap_metric = -1;
+        }
+        status = set_interface_metric(index, AF_INET, BLOCK_DNS_IFACE_METRIC);
+        if (!status)
+        {
+            set_interface_metric(index, AF_INET6, BLOCK_DNS_IFACE_METRIC);
+        }
+    }
+
     ret = (status == 0);
 
 out:
@@ -1345,19 +1365,24 @@ out:
 }
 
 bool
-win_wfp_uninit(const HANDLE msg_channel)
+win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel)
 {
     dmsg(D_LOW, "Uninitializing WFP");
 
     if (msg_channel)
     {
         msg(D_LOW, "Using service to delete block dns filters");
-        win_block_dns_service(false, -1, msg_channel);
+        win_block_dns_service(false, index, msg_channel);
     }
     else
     {
         delete_block_dns_filters(m_hEngineHandle);
         m_hEngineHandle = NULL;
+        if (tap_metric >= 0)
+        {
+            set_interface_metric(index, AF_INET, tap_metric);
+            set_interface_metric(index, AF_INET6, tap_metric);
+        }
     }
 
     return true;
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 4ee44fd..cd1f101 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -293,7 +293,7 @@ WCHAR *wide_string(const char *utf8, struct gc_arena *gc);
 
 bool win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel);
 
-bool win_wfp_uninit(const HANDLE msg_channel);
+bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);
 
 #define WIN_XP 0
 #define WIN_VISTA 1
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 2bce598..362b271 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -94,6 +94,12 @@ typedef enum {
 } undo_type_t;
 typedef list_item_t *undo_lists_t[_undo_type_max];
 
+typedef struct {
+    HANDLE engine;
+    int index;
+    int metric;
+} block_dns_data_t;
+
 
 static DWORD
 AddListItem(list_item_t **pfirst, LPVOID data)
@@ -885,6 +891,8 @@ static DWORD
 HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
 {
     DWORD err = 0;
+    int metric = 0;
+    block_dns_data_t *interface_data;
     HANDLE engine = NULL;
     LPCWSTR exe_path;
 
@@ -901,16 +909,51 @@ HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
         err = add_block_dns_filters(&engine, msg->iface.index, exe_path, BlockDNSErrHandler);
         if (!err)
         {
-            err = AddListItem(&(*lists)[block_dns], engine);
+            interface_data = malloc(sizeof(block_dns_data_t));
+            if (!interface_data)
+            {
+                return ERROR_OUTOFMEMORY;
+            }
+            interface_data->engine = engine;
+            interface_data->index = msg->iface.index;
+            metric = get_interface_metric(msg->iface.index, AF_INET);
+            if (metric >= 0)
+            {
+                interface_data->metric = metric;
+            }
+            else
+            {
+                interface_data->metric = -1;
+            }
+            err = AddListItem(&(*lists)[block_dns], interface_data);
+            if (!err)
+            {
+                err = set_interface_metric(msg->iface.index, AF_INET,
+                                           BLOCK_DNS_IFACE_METRIC);
+                if (!err)
+                {
+                    set_interface_metric(msg->iface.index, AF_INET6,
+                                         BLOCK_DNS_IFACE_METRIC);
+                }
+            }
         }
     }
     else
     {
-        engine = RemoveListItem(&(*lists)[block_dns], CmpEngine, NULL);
-        if (engine)
+        interface_data = RemoveListItem(&(*lists)[block_dns], CmpEngine, NULL);
+        if (interface_data)
         {
+            engine = interface_data->engine;
             err = delete_block_dns_filters(engine);
             engine = NULL;
+            if (interface_data->metric >= 0)
+            {
+                set_interface_metric(msg->iface.index, AF_INET,
+                                     interface_data->metric);
+                set_interface_metric(msg->iface.index, AF_INET6,
+                                     interface_data->metric);
+            }
+            free(interface_data);
         }
         else
         {
@@ -1325,6 +1368,7 @@ static VOID
 Undo(undo_lists_t *lists)
 {
     undo_type_t type;
+    block_dns_data_t *interface_data;
     for (type = 0; type < _undo_type_max; type++)
     {
         list_item_t **pnext = &(*lists)[type];
@@ -1350,8 +1394,15 @@ Undo(undo_lists_t *lists)
                     break;
 
                 case block_dns:
-                    delete_block_dns_filters(item->data);
-                    item->data = NULL;
+                    interface_data = (block_dns_data_t*)(item->data);
+                    delete_block_dns_filters(interface_data->engine);
+                    if (interface_data->metric > 0)
+                    {
+                        set_interface_metric(interface_data->index, AF_INET,
+                                             interface_data->metric);
+                        set_interface_metric(interface_data->index, AF_INET6,
+                                             interface_data->metric);
+                    }
                     break;
             }
 
-- 
2.9.3


