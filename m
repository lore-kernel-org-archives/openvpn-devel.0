From: Arne Schwabe <arne@...1227...>
Date: Wed, 21 Nov 2018 11:10:11 +0100
Message-Id: <20181121101019.1801-6-arne@...1227...>
In-Reply-To: <20181121101019.1801-1-arne@...1227...>
References: <20181121101019.1801-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v4 05/13] client-connect: Refactor
 client-connect handling to calling a bunch of hooks in a loop
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

This patch changes the calling of the client-connect functions into an array
of hooks and a block of code that calls them in a loop.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4182b553..18a1313e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2144,6 +2144,20 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
     if (tls_authentication_status(mi->context.c2.tls_multi, 0)
         == TLS_AUTHENTICATION_SUCCEEDED)
     {
+        typedef enum client_connect_return
+        (*multi_client_connect_handler)
+            (struct multi_context *m, struct multi_instance *mi,
+            unsigned int *option_types_found);
+
+        multi_client_connect_handler handlers[] = {
+            multi_client_connect_source_ccd,
+            multi_client_connect_call_plugin_v1,
+            multi_client_connect_call_plugin_v2,
+            multi_client_connect_call_script,
+            multi_client_connect_mda,
+            NULL
+        };
+
         unsigned int option_types_found = 0;
 
         int cc_succeeded = true; /* client connect script status */
@@ -2152,35 +2166,9 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 
         multi_client_connect_early_setup(m, mi);
 
-        ret = multi_client_connect_source_ccd(m, mi, &option_types_found);
-        cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
-
-        if (cc_succeeded)
-        {
-            ret = multi_client_connect_call_plugin_v1(m, mi,
-                                                      &option_types_found);
-            cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
-        }
-
-        if (cc_succeeded)
-        {
-            ret = multi_client_connect_call_plugin_v2(m, mi,
-                                                      &option_types_found);
-            cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
-        }
-
-        /*
-         * Check for client-connect script left by management interface client
-         */
-        if (cc_succeeded)
-        {
-            ret = multi_client_connect_call_script(m, mi, &option_types_found);
-            cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
-        }
-
-        if (cc_succeeded)
+        for (int i = 0; cc_succeeded && handlers[i]; i++)
         {
-            ret = multi_client_connect_mda(m, mi, &option_types_found);
+            ret = handlers[i](m, mi, &option_types_found);
             cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
         }
 
-- 
2.19.1


