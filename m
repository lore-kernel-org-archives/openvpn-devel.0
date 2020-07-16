From: Arne Schwabe <arne@...1227...>
Date: Thu, 16 Jul 2020 15:43:14 +0200
Message-Id: <20200716134315.17742-5-arne@...1227...>
In-Reply-To: <20200716134315.17742-1-arne@...1227...>
References: <20200716134315.17742-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v7 5/6] client-connect: Implement deferred
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
option when async is needed for the plugin V2 API.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 include/openvpn-plugin.h.in |  3 ++-
 src/openvpn/multi.c         | 36 ++++++++++++++++++++++++------------
 src/openvpn/plugin.c        |  3 +++
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 99aa1678..38fbe097 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -130,7 +130,8 @@ extern "C" {
 #define OPENVPN_PLUGIN_ENABLE_PF                11
 #define OPENVPN_PLUGIN_ROUTE_PREDOWN            12
 #define OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER     13
-#define OPENVPN_PLUGIN_N                        14
+#define OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2  14
+#define OPENVPN_PLUGIN_N                        15
 
 /*
  * Build a mask out of a set of plug-in types.
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a15e37a4..39878e90 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2112,36 +2112,48 @@ multi_client_connect_call_plugin_v2(struct multi_context *m,
                                     bool deferred,
                                     unsigned int *option_types_found)
 {
-    if (deferred)
-    {
-        return CC_RET_FAILED;
-    }
     enum client_connect_return ret = CC_RET_SKIPPED;
 #ifdef ENABLE_PLUGIN
     ASSERT(m);
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
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index ea18592f..80abb730 100644
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
2.26.2


