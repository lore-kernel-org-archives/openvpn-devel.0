From: Gert Doering <gert@...1296...>
Date: Wed, 12 Nov 2025 22:51:00 +0100
Message-ID: <20251112215106.14182-1-gert@...1296...>
In-Reply-To: <gerrit.1762823521000.Ia74a931c703d594bdf8ccada9b783b94608de278@...2715...>
References: <gerrit.1762823521000.Ia74a931c703d594bdf8ccada9b783b94608de278@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] iservice: use saved iface index to
 restore metric
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

From: Heiko Hund <heiko@...2662...>

When adding block rules, the interface metric of the VPN adapter is
temporarily modified so that an old version of Windows 10 would pick
it up first when looking up stuff via DNS. These metrics are reverted to
the old value when the block is removed.

When reverting them, instead of using the stored interface index where
the original values were read from, we were using the interface index
passed to the service with the wfp block message. That index could
theoretically be different from the one stored, which would result in
the metric being set to the wrong interface.

Reported-by: stephan@...2953...
Change-Id: Ia74a931c703d594bdf8ccada9b783b94608de278
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1363
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1363
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0712986..33282c63 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -752,7 +752,7 @@
 }
 
 static DWORD
-DeleteWfpBlock(const wfp_block_message_t *msg, undo_lists_t *lists)
+DeleteWfpBlock(undo_lists_t *lists)
 {
     DWORD err = 0;
     wfp_block_data_t *block_data = RemoveListItem(&(*lists)[wfp_block], CmpAny, NULL);
@@ -762,11 +762,11 @@
         err = delete_wfp_block_filters(block_data->engine);
         if (block_data->metric_v4 >= 0)
         {
-            set_interface_metric(msg->iface.index, AF_INET, block_data->metric_v4);
+            set_interface_metric(block_data->index, AF_INET, block_data->metric_v4);
         }
         if (block_data->metric_v6 >= 0)
         {
-            set_interface_metric(msg->iface.index, AF_INET6, block_data->metric_v6);
+            set_interface_metric(block_data->index, AF_INET6, block_data->metric_v6);
         }
         free(block_data);
     }
@@ -829,7 +829,7 @@
             if (err)
             {
                 /* delete the filters, remove undo item and free interface data */
-                DeleteWfpBlock(msg, lists);
+                DeleteWfpBlock(lists);
                 engine = NULL;
             }
         }
@@ -854,7 +854,7 @@
     }
     else
     {
-        return DeleteWfpBlock(msg, lists);
+        return DeleteWfpBlock(lists);
     }
 }
 

