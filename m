From: Arne Schwabe <arne@...1227...>
Date: Sun, 19 Jul 2020 19:34:35 +0200
Message-Id: <20200719173436.16431-4-arne@...1227...>
In-Reply-To: <20200719173436.16431-1-arne@...1227...>
References: <20200719173436.16431-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v8 4/5] client-connect: Add deferred support
 to the client-connect plugin v1 handler
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

Uses the infrastructure provided and used in the previous patch to provide
deferral support to the v1 client-connect plugin handler as well.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>

PATCH V3: Modify the API to also (optionally) call the plugin on a deferred
call. This allows the plugin authors to be more flexible and make the V1 API
more similar to the V2 API.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 include/openvpn-plugin.h.in | 29 +++++++-------
 src/openvpn/multi.c         | 78 ++++++++++++++++++++++++++-----------
 src/openvpn/plugin.c        |  3 ++
 3 files changed, 73 insertions(+), 37 deletions(-)

diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 103844f7..99aa1678 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -116,20 +116,21 @@ extern "C" {
  * FUNC: openvpn_plugin_client_destructor_v1 (top-level "generic" client)
  * FUNC: openvpn_plugin_close_v1
  */
-#define OPENVPN_PLUGIN_UP                    0
-#define OPENVPN_PLUGIN_DOWN                  1
-#define OPENVPN_PLUGIN_ROUTE_UP              2
-#define OPENVPN_PLUGIN_IPCHANGE              3
-#define OPENVPN_PLUGIN_TLS_VERIFY            4
-#define OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY 5
-#define OPENVPN_PLUGIN_CLIENT_CONNECT        6
-#define OPENVPN_PLUGIN_CLIENT_DISCONNECT     7
-#define OPENVPN_PLUGIN_LEARN_ADDRESS         8
-#define OPENVPN_PLUGIN_CLIENT_CONNECT_V2     9
-#define OPENVPN_PLUGIN_TLS_FINAL             10
-#define OPENVPN_PLUGIN_ENABLE_PF             11
-#define OPENVPN_PLUGIN_ROUTE_PREDOWN         12
-#define OPENVPN_PLUGIN_N                     13
+#define OPENVPN_PLUGIN_UP                        0
+#define OPENVPN_PLUGIN_DOWN                      1
+#define OPENVPN_PLUGIN_ROUTE_UP                  2
+#define OPENVPN_PLUGIN_IPCHANGE                  3
+#define OPENVPN_PLUGIN_TLS_VERIFY                4
+#define OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY     5
+#define OPENVPN_PLUGIN_CLIENT_CONNECT            6
+#define OPENVPN_PLUGIN_CLIENT_DISCONNECT         7
+#define OPENVPN_PLUGIN_LEARN_ADDRESS             8
+#define OPENVPN_PLUGIN_CLIENT_CONNECT_V2         9
+#define OPENVPN_PLUGIN_TLS_FINAL                10
+#define OPENVPN_PLUGIN_ENABLE_PF                11
+#define OPENVPN_PLUGIN_ROUTE_PREDOWN            12
+#define OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER     13
+#define OPENVPN_PLUGIN_N                        14
 
 /*
  * Build a mask out of a set of plug-in types.
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3b73ffde..c66a4cea 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2022,53 +2022,85 @@ multi_client_connect_call_plugin_v1(struct multi_context *m,
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
+    struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);
 
     /* deprecated callback, use a file for passing back return info */
     if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
     {
         struct argv argv = argv_new();
-        struct gc_arena gc = gc_new();
-        const char *dc_file =
-            platform_create_temp_file(mi->context.options.tmp_dir, "cc", &gc);
+        int call;
 
-        if (!dc_file)
+        if (!deferred)
         {
-            ret = CC_RET_FAILED;
-            goto cleanup;
+            call = OPENVPN_PLUGIN_CLIENT_CONNECT;
+            if (!ccs_gen_config_file(mi)
+                || !ccs_gen_deferred_ret_file(mi))
+            {
+                ret = CC_RET_FAILED;
+                goto cleanup;
+            }
+        }
+        else
+        {
+            call = OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER;
+            /* the initial call should have created these files */
+            ASSERT(ccs->config_file);
+            ASSERT(ccs->deferred_ret_file);
         }
 
-        argv_printf(&argv, "%s", dc_file);
-        if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT,
-                        &argv, NULL, mi->context.c2.es)
-            != OPENVPN_PLUGIN_FUNC_SUCCESS)
+        argv_printf(&argv, "%s", ccs->config_file);
+        int plug_ret = plugin_call(mi->context.plugins, call,
+                                   &argv, NULL, mi->context.c2.es);
+        if (plug_ret == OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
-            msg(M_WARN, "WARNING: client-connect plugin call failed");
-            ret = CC_RET_FAILED;
+            multi_client_connect_post(m, mi, ccs->config_file,
+                                      option_types_found);
+            ret = CC_RET_SUCCEEDED;
+        }
+        else if (plug_ret == OPENVPN_PLUGIN_FUNC_DEFERRED)
+        {
+            ret = CC_RET_DEFERRED;
+            /**
+             * Contrary to the plugin v2 API, we do not demand a working
+             * deferred plugin as all return can be handled by the files
+             * and plugin_call return success if a plugin is not defined
+             */
         }
         else
         {
-            multi_client_connect_post(m, mi, dc_file, option_types_found);
-            ret = CC_RET_SUCCEEDED;
+            msg(M_WARN, "WARNING: client-connect plugin call failed");
+            ret = CC_RET_FAILED;
         }
 
-        if (!platform_unlink(dc_file))
+
+        /**
+         * plugin api v1 client connect async feature has both plugin and
+         * file return status, so in case that the file has a code that
+         * demands override, we override our return code
+         */
+        int file_ret = ccs_test_deferred_ret_file(mi);
+
+        if (file_ret == CC_RET_FAILED)
         {
-            msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
-                dc_file);
+            ret = CC_RET_FAILED;
+        }
+        else if (ret == CC_RET_SUCCEEDED && file_ret == CC_RET_DEFERRED)
+        {
+            ret = CC_RET_DEFERRED;
         }
-
 cleanup:
         argv_free(&argv);
-        gc_free(&gc);
+
+        if (ret != CC_RET_DEFERRED)
+        {
+            ccs_delete_config_file(mi);
+            ccs_delete_deferred_ret_file(mi);
+        }
     }
 #endif /* ifdef ENABLE_PLUGIN */
     return ret;
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 4de1d6b7..9a6fa3cb 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -104,6 +104,9 @@ plugin_type_name(const int type)
         case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
             return "PLUGIN_CLIENT_CONNECT";
 
+        case OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER:
+            return "PLUGIN_CLIENT_CONNECT_DEFER";
+
         case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
             return "PLUGIN_CLIENT_DISCONNECT";
 
-- 
2.26.2


