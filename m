From: Gert Doering <gert@...1296...>
Date: Mon, 27 Jul 2020 20:34:35 +0200
Message-Id: <20200727183436.6625-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Fix sequence of events for async plugin
 v1 handler.
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

If multi_client_connect_call_plugin_v1() goes to "deferred mode",
*and* there is no OPENVPN_CLIENT_CONNECT_DEFER handler, we
would read the "client specific options" file after every
(succeeded-because-not-present) call to plugin_call().

Move this to "after we have checked the deferred-cc file, and we
know for sure that we have CC_RET_SUCCEEDED".

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/multi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9bda38b0..cfb34720 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2065,8 +2065,6 @@ multi_client_connect_call_plugin_v1(struct multi_context *m,
                                    &argv, NULL, mi->context.c2.es);
         if (plug_ret == OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
-            multi_client_connect_post(m, mi, ccs->config_file,
-                                      option_types_found);
             ret = CC_RET_SUCCEEDED;
         }
         else if (plug_ret == OPENVPN_PLUGIN_FUNC_DEFERRED)
@@ -2100,6 +2098,13 @@ multi_client_connect_call_plugin_v1(struct multi_context *m,
         {
             ret = CC_RET_DEFERRED;
         }
+
+        /* if we still think we have succeeded, do postprocessing */
+        if (ret == CC_RET_SUCCEEDED)
+        {
+            multi_client_connect_post(m, mi, ccs->config_file,
+                                      option_types_found);
+        }
 cleanup:
         argv_free(&argv);
 
-- 
2.26.2


