From: selva.nair@...277...
Date: Tue, 31 Jan 2023 23:18:31 -0500
Message-Id: <20230201041831.2259419-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] block-dns using iservice: fix a potential
 double free
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

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 03361d66..636f32e9 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -780,7 +780,7 @@ static DWORD
 HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
 {
     DWORD err = 0;
-    block_dns_data_t *interface_data;
+    block_dns_data_t *interface_data = NULL;
     HANDLE engine = NULL;
     LPCWSTR exe_path;
 
@@ -794,6 +794,7 @@ HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
             interface_data = malloc(sizeof(block_dns_data_t));
             if (!interface_data)
             {
+                delete_block_dns_filters(engine);
                 return ERROR_OUTOFMEMORY;
             }
             interface_data->engine = engine;
@@ -818,8 +819,17 @@ HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
                                            BLOCK_DNS_IFACE_METRIC);
                 if (!err)
                 {
-                    set_interface_metric(msg->iface.index, AF_INET6,
-                                         BLOCK_DNS_IFACE_METRIC);
+                    err = set_interface_metric(msg->iface.index, AF_INET6,
+                                               BLOCK_DNS_IFACE_METRIC);
+                }
+                if (err)
+                {
+                    /* try to restore the interface metric values in case changed */
+                    set_interface_metric(msg->iface.index, AF_INET,
+                                         interface_data->metric_v4);
+                    set_interface_metric(msg->iface.index, AF_INET,
+                                         interface_data->metric_v4);
+                    RemoveListItem(&(*lists)[block_dns], CmpAny, NULL);
                 }
             }
         }
@@ -853,6 +863,7 @@ HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
     if (err && engine)
     {
         delete_block_dns_filters(engine);
+        free(interface_data);
     }
 
     return err;
-- 
2.34.1


