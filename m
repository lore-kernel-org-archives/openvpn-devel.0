From: selva.nair@...277...
Date: Wed,  1 Feb 2023 12:07:35 -0500
Message-Id: <20230201170735.2266851-1-selva.nair@...277...>
In-Reply-To: <20230201041831.2259419-1-selva.nair@...277...>
References: <20230201041831.2259419-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] block-dns using iservice: fix a
 potential double free
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

- An item added to undo-list was not removed on error, causing
  attempt to free again in Undo().
  Also fix a memory leak possibility in the same context.

Github: fixes OpenVPN/openvpn#232

v2: Split add and delete functions and reuse the delete
function for cleanup.

Signed-off-by: Selva Nair <selva.nair@...277...>
---

Same as PR #235 except for DeleteBlockDNS moved up and
the its forward declaration removed.

 src/openvpnserv/interactive.c | 132 ++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 54 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 03361d66..a3d43752 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -777,87 +777,111 @@ CmpAny(LPVOID item, LPVOID any)
 }
 
 static DWORD
-HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
+DeleteBlockDNS(const block_dns_message_t *msg, undo_lists_t *lists)
 {
     DWORD err = 0;
-    block_dns_data_t *interface_data;
+    block_dns_data_t *interface_data = RemoveListItem(&(*lists)[block_dns], CmpAny, NULL);
+
+    if (interface_data)
+    {
+        err = delete_block_dns_filters(interface_data->engine);
+        if (interface_data->metric_v4 >= 0)
+        {
+            set_interface_metric(msg->iface.index, AF_INET,
+                                 interface_data->metric_v4);
+        }
+        if (interface_data->metric_v6 >= 0)
+        {
+            set_interface_metric(msg->iface.index, AF_INET6,
+                                 interface_data->metric_v6);
+        }
+        free(interface_data);
+    }
+    else
+    {
+        MsgToEventLog(M_ERR, TEXT("No previous block DNS filters to delete"));
+    }
+
+    return err;
+}
+
+static DWORD
+AddBlockDNS(const block_dns_message_t *msg, undo_lists_t *lists)
+{
+    DWORD err = 0;
+    block_dns_data_t *interface_data = NULL;
     HANDLE engine = NULL;
     LPCWSTR exe_path;
 
     exe_path = settings.exe_path;
 
-    if (msg->header.type == msg_add_block_dns)
+    err = add_block_dns_filters(&engine, msg->iface.index, exe_path, BlockDNSErrHandler);
+    if (!err)
     {
-        err = add_block_dns_filters(&engine, msg->iface.index, exe_path, BlockDNSErrHandler);
+        interface_data = malloc(sizeof(block_dns_data_t));
+        if (!interface_data)
+        {
+            err = ERROR_OUTOFMEMORY;
+            goto out;
+        }
+        interface_data->engine = engine;
+        interface_data->index = msg->iface.index;
+        int is_auto = 0;
+        interface_data->metric_v4 = get_interface_metric(msg->iface.index,
+                                                         AF_INET, &is_auto);
+        if (is_auto)
+        {
+            interface_data->metric_v4 = 0;
+        }
+        interface_data->metric_v6 = get_interface_metric(msg->iface.index,
+                                                         AF_INET6, &is_auto);
+        if (is_auto)
+        {
+            interface_data->metric_v6 = 0;
+        }
+
+        err = AddListItem(&(*lists)[block_dns], interface_data);
         if (!err)
         {
-            interface_data = malloc(sizeof(block_dns_data_t));
-            if (!interface_data)
-            {
-                return ERROR_OUTOFMEMORY;
-            }
-            interface_data->engine = engine;
-            interface_data->index = msg->iface.index;
-            int is_auto = 0;
-            interface_data->metric_v4 = get_interface_metric(msg->iface.index,
-                                                             AF_INET, &is_auto);
-            if (is_auto)
-            {
-                interface_data->metric_v4 = 0;
-            }
-            interface_data->metric_v6 = get_interface_metric(msg->iface.index,
-                                                             AF_INET6, &is_auto);
-            if (is_auto)
-            {
-                interface_data->metric_v6 = 0;
-            }
-            err = AddListItem(&(*lists)[block_dns], interface_data);
+            err = set_interface_metric(msg->iface.index, AF_INET,
+                                       BLOCK_DNS_IFACE_METRIC);
             if (!err)
             {
-                err = set_interface_metric(msg->iface.index, AF_INET,
+                err = set_interface_metric(msg->iface.index, AF_INET6,
                                            BLOCK_DNS_IFACE_METRIC);
-                if (!err)
-                {
-                    set_interface_metric(msg->iface.index, AF_INET6,
-                                         BLOCK_DNS_IFACE_METRIC);
-                }
-            }
-        }
-    }
-    else
-    {
-        interface_data = RemoveListItem(&(*lists)[block_dns], CmpAny, NULL);
-        if (interface_data)
-        {
-            engine = interface_data->engine;
-            err = delete_block_dns_filters(engine);
-            engine = NULL;
-            if (interface_data->metric_v4 >= 0)
-            {
-                set_interface_metric(msg->iface.index, AF_INET,
-                                     interface_data->metric_v4);
             }
-            if (interface_data->metric_v6 >= 0)
+            if (err)
             {
-                set_interface_metric(msg->iface.index, AF_INET6,
-                                     interface_data->metric_v6);
+                /* delete the filters, remove undo item and free interface data */
+                DeleteBlockDNS(msg, lists);
+                engine = NULL;
             }
-            free(interface_data);
-        }
-        else
-        {
-            MsgToEventLog(M_ERR, TEXT("No previous block DNS filters to delete"));
         }
     }
 
+out:
     if (err && engine)
     {
         delete_block_dns_filters(engine);
+        free(interface_data);
     }
 
     return err;
 }
 
+static DWORD
+HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
+{
+    if (msg->header.type == msg_add_block_dns)
+    {
+        return AddBlockDNS(msg, lists);
+    }
+    else
+    {
+        return DeleteBlockDNS(msg, lists);
+    }
+}
+
 /*
  * Execute a command and return its exit code. If timeout > 0, terminate
  * the process if still running after timeout milliseconds. In that case
-- 
2.34.1


