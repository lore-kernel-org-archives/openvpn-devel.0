From: Arne Schwabe <arne@...1227...>
Date: Wed, 21 Nov 2018 11:10:18 +0100
Message-Id: <20181121101019.1801-13-arne@...1227...>
In-Reply-To: <20181121101019.1801-1-arne@...1227...>
References: <20181121101019.1801-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v4 12/13] client-connect: Implement deferred
 connect support for plugin API v2
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

The V2 API is simpler than the V1 API since there is no passing of
data via files. This also means that with the current API the V2 API
cannot support async notify via files. Adding a file just for async
notify seems very hacky and when needed we should implement a better
option when async is needed for the plugin V2 API

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c  | 58 +++++++++++++++++++++++++++++++++++---------
 src/openvpn/plugin.c |  3 +++
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c14a21e4..c94716ae 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2043,7 +2043,8 @@ multi_client_connect_call_plugin_v1_deferred(struct multi_context *m,
 static enum client_connect_return
 multi_client_connect_call_plugin_v2(struct multi_context *m,
                                     struct multi_instance *mi,
-                                    unsigned int *option_types_found)
+                                    unsigned int *option_types_found,
+                                    bool deferred)
 {
     enum client_connect_return ret = CC_RET_SKIPPED;
 #ifdef ENABLE_PLUGIN
@@ -2051,32 +2052,67 @@ multi_client_connect_call_plugin_v2(struct multi_context *m,
     ASSERT(mi);
     ASSERT(option_types_found);
 
+    int call = deferred ? OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2 :
+               OPENVPN_PLUGIN_CLIENT_CONNECT_V2;
     /* V2 callback, use a plugin_return struct for passing back return info */
-    if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
+    if (plugin_defined(mi->context.plugins, call))
     {
         struct plugin_return pr;
 
         plugin_return_init(&pr);
 
-        if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2,
-                        NULL, &pr, mi->context.c2.es)
-            != OPENVPN_PLUGIN_FUNC_SUCCESS)
+        int plug_ret = plugin_call(mi->context.plugins, call,
+                                   NULL, &pr, mi->context.c2.es);
+        if (plug_ret == OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
-            msg(M_WARN, "WARNING: client-connect-v2 plugin call failed");
-            ret = CC_RET_FAILED;
+            multi_client_connect_post_plugin(m, mi, &pr, option_types_found);
+            ret = CC_RET_SUCCEEDED;
+        }
+        else if (plug_ret == OPENVPN_PLUGIN_FUNC_DEFERRED)
+        {
+            ret = CC_RET_DEFERRED;
+            if (!(plugin_defined(mi->context.plugins,
+                                 OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2)))
+            {
+                msg(M_WARN, "A plugin that defers from the "
+                    "OPENVPN_PLUGIN_CLIENT_CONNECT_V2 call must also "
+                    "declare support for "
+                    "OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2");
+                ret = CC_RET_FAILED;
+            }
         }
         else
         {
-            multi_client_connect_post_plugin(m, mi, &pr, option_types_found);
-            ret = CC_RET_SUCCEEDED;
+            msg(M_WARN, "WARNING: client-connect-v2 plugin call failed");
+            ret = CC_RET_FAILED;
         }
 
+
         plugin_return_free(&pr);
     }
 #endif /* ifdef ENABLE_PLUGIN */
     return ret;
 }
 
+
+static enum client_connect_return
+multi_client_connect_call_plugin_v2_initial(struct multi_context *m,
+                                            struct multi_instance *mi,
+                                            unsigned int *option_types_found)
+{
+    return multi_client_connect_call_plugin_v2(m, mi, option_types_found,
+                                               false);
+}
+
+static enum client_connect_return
+multi_client_connect_call_plugin_v2_deferred(struct multi_context *m,
+                                             struct multi_instance *mi,
+                                             unsigned int *option_types_found)
+{
+    return multi_client_connect_call_plugin_v2(m, mi, option_types_found,
+                                               true);
+}
+
 /**
  * Runs the --client-connect script if one is defined.
  */
@@ -2390,8 +2426,8 @@ static const struct client_connect_handlers client_connect_handlers[] = {
         .deferred = multi_client_connect_call_plugin_v1_deferred,
     },
     {
-        .main = multi_client_connect_call_plugin_v2,
-        .deferred = multi_client_connect_fail
+        .main = multi_client_connect_call_plugin_v2_initial,
+        .deferred = multi_client_connect_call_plugin_v2_deferred,
     },
     {
         .main = multi_client_connect_call_script,
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 51c130c1..347acade 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -107,6 +107,9 @@ plugin_type_name(const int type)
         case OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER:
             return "PLUGIN_CLIENT_CONNECT";
 
+        case OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2:
+            return "PLUGIN_CLIENT_CONNECT";
+
         case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
             return "PLUGIN_CLIENT_DISCONNECT";
 
-- 
2.19.1


