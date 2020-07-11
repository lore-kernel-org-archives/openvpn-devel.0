From: Arne Schwabe <arne@...1227...>
Date: Sat, 11 Jul 2020 11:36:45 +0200
Message-Id: <20200711093655.23686-4-arne@...1227...>
In-Reply-To: <20200711093655.23686-1-arne@...1227...>
References: <20200711093655.23686-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v5 04/14] client-connect: Move
 multi_client_connect_setenv into early_setup
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

From: Fabian Knittel <fabian.knittel@...1547...>

This patch moves multi_client_connect_setenv into
multi_client_connect_early_setup and makes sure that every client-connect
handling function updates the virtual address selection.

Background: This unifies how the client-connect handling functions work.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
Signed-off-by: Arne Schwabe <arne@...1227...>

Patch V5: Rebase on master

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 35e0bd10..539ebfc0 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2150,6 +2150,12 @@ multi_client_connect_early_setup(struct multi_context *m,
 
     /* reset pool handle to null */
     mi->vaddr_handle = -1;
+
+    /* do --client-connect setenvs */
+    multi_select_virtual_addr(m, mi);
+
+    multi_client_connect_setenv(m, mi);
+
 }
 
 /**
@@ -2195,6 +2201,13 @@ multi_client_connect_source_ccd(struct multi_context *m,
                                   CLIENT_CONNECT_OPT_MASK,
                                   option_types_found,
                                   mi->context.c2.es);
+            /*
+             * Select a virtual address from either --ifconfig-push in
+             * --client-config-dir file or --ifconfig-pool.
+             */
+            multi_select_virtual_addr(m, mi);
+
+            multi_client_connect_setenv(m, mi);
         }
         gc_free(&gc);
     }
@@ -2236,15 +2249,6 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 
     multi_client_connect_source_ccd(m, mi, &option_types_found);
 
-    /*
-     * Select a virtual address from either --ifconfig-push in
-     * --client-config-dir file or --ifconfig-pool.
-     */
-    multi_select_virtual_addr(m, mi);
-
-    /* do --client-connect setenvs */
-    multi_client_connect_setenv(m, mi);
-
     multi_client_connect_call_plugin_v1(m, mi, &option_types_found,
                                         &cc_succeeded,
                                         &cc_succeeded_count);
-- 
2.26.2


