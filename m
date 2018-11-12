From: Arne Schwabe <arne@...1227...>
Date: Mon, 12 Nov 2018 12:56:18 +0100
Message-Id: <20181112115627.5096-5-arne@...1227...>
In-Reply-To: <20181112115627.5096-1-arne@...1227...>
References: <20181112115627.5096-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 04/13] client-connect: Refactor to use
 return values instead of modifying a passed-in flag
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

This patch changes the way the client-connect helper functions communicate with
the main function.  Instead of updating cc_succeeded and cc_succeeded_count,
they now return either CC_RET_SUCCEEDED, CC_RET_FAILED or CC_RET_SKIPPED.

In addition, the client-connect helpers are now called in completely identical
ways.  This is in preparation of handling the helpers as simple call-backs.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 138 +++++++++++++++++++++++++++-----------------
 src/openvpn/multi.h |  10 ++++
 2 files changed, 94 insertions(+), 54 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a9925160..1cd629c4 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1706,20 +1706,21 @@ multi_client_connect_post_plugin(struct multi_context *m,
 
 #endif /* ifdef ENABLE_PLUGIN */
 
-#ifdef MANAGEMENT_DEF_AUTH
+
 
 /*
  * Called to load management-derived client-connect config
  */
-static void
+enum client_connect_return
 multi_client_connect_mda(struct multi_context *m,
                          struct multi_instance *mi,
                          unsigned int *option_types_found)
 {
+    enum client_connect_return ret = CC_RET_SKIPPED;
+#ifdef MANAGEMENT_DEF_AUTH
     if (mi->cc_config)
     {
         struct buffer_entry *be;
-
         for (be = mi->cc_config->head; be != NULL; be = be->next)
         {
             const char *opt = BSTR(&be->buf);
@@ -1739,10 +1740,12 @@ multi_client_connect_mda(struct multi_context *m,
          */
         multi_select_virtual_addr(m, mi);
         multi_set_virtual_addr_env(m, mi);
-    }
-}
 
+        ret = CC_RET_SUCCEEDED;
+    }
 #endif /* ifdef MANAGEMENT_DEF_AUTH */
+    return ret;
+}
 
 static void
 multi_client_connect_setenv(struct multi_context *m,
@@ -1769,19 +1772,16 @@ multi_client_connect_setenv(struct multi_context *m,
     gc_free(&gc);
 }
 
-static void
+static enum client_connect_return
 multi_client_connect_call_plugin_v1(struct multi_context *m,
                                     struct multi_instance *mi,
-                                    unsigned int *option_types_found,
-                                    int *cc_succeeded,
-                                    int *cc_succeeded_count)
+                                    unsigned int *option_types_found)
 {
+    enum client_connect_return ret = CC_RET_SKIPPED;
 #ifdef ENABLE_PLUGIN
-    ASSERT(m);
-    ASSERT(mi);
-    ASSERT(option_types_found);
-    ASSERT(cc_succeeded);
-    ASSERT(cc_succeeded_count);
+    ASSERT (m);
+    ASSERT (mi);
+    ASSERT (option_types_found);
 
     /* deprecated callback, use a file for passing back return info */
     if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
@@ -1793,7 +1793,7 @@ multi_client_connect_call_plugin_v1(struct multi_context *m,
 
         if (!dc_file)
         {
-            cc_succeeded = false;
+            ret = CC_RET_FAILED;
             goto cleanup;
         }
 
@@ -1803,12 +1803,12 @@ multi_client_connect_call_plugin_v1(struct multi_context *m,
             != OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
             msg(M_WARN, "WARNING: client-connect plugin call failed");
-            *cc_succeeded = false;
+            ret=CC_RET_FAILED;
         }
         else
         {
             multi_client_connect_post(m, mi, dc_file, option_types_found);
-            (*cc_succeeded_count)++;
+            ret = CC_RET_SUCCEEDED;
         }
 
         if (!platform_unlink(dc_file))
@@ -1822,21 +1822,19 @@ multi_client_connect_call_plugin_v1(struct multi_context *m,
         gc_free(&gc);
     }
 #endif /* ifdef ENABLE_PLUGIN */
+    return ret;
 }
 
-static void
+static enum client_connect_return
 multi_client_connect_call_plugin_v2(struct multi_context *m,
                                     struct multi_instance *mi,
-                                    unsigned int *option_types_found,
-                                    int *cc_succeeded,
-                                    int *cc_succeeded_count)
+                                    unsigned int *option_types_found)
 {
+    enum client_connect_return ret = CC_RET_SKIPPED;
 #ifdef ENABLE_PLUGIN
-    ASSERT(m);
-    ASSERT(mi);
-    ASSERT(option_types_found);
-    ASSERT(cc_succeeded);
-    ASSERT(cc_succeeded_count);
+    ASSERT (m);
+    ASSERT (mi);
+    ASSERT (option_types_found);
 
     /* V2 callback, use a plugin_return struct for passing back return info */
     if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
@@ -1850,17 +1848,18 @@ multi_client_connect_call_plugin_v2(struct multi_context *m,
             != OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
             msg(M_WARN, "WARNING: client-connect-v2 plugin call failed");
-            *cc_succeeded = false;
+            ret = CC_RET_FAILED;
         }
         else
         {
             multi_client_connect_post_plugin(m, mi, &pr, option_types_found);
-            (*cc_succeeded_count)++;
+            ret = CC_RET_SUCCEEDED;
         }
 
         plugin_return_free(&pr);
     }
 #endif /* ifdef ENABLE_PLUGIN */
+    return ret;
 }
 
 
@@ -1868,13 +1867,12 @@ multi_client_connect_call_plugin_v2(struct multi_context *m,
 /**
  * Runs the --client-connect script if one is defined.
  */
-static void
+static enum client_connect_return
 multi_client_connect_call_script(struct multi_context *m,
                                  struct multi_instance *mi,
-                                 unsigned int *option_types_found,
-                                 int *cc_succeeded,
-                                 int *cc_succeeded_count)
+                                 unsigned int *option_types_found)
 {
+    enum client_connect_return ret = CC_RET_SKIPPED;
     if (mi->context.options.client_connect_script)
     {
         struct argv argv = argv_new();
@@ -1887,7 +1885,7 @@ multi_client_connect_call_script(struct multi_context *m,
                                             "cc", &gc);
         if (!dc_file)
         {
-            *cc_succeeded = false;
+            ret = CC_RET_FAILED;
             goto cleanup;
         }
 
@@ -1897,11 +1895,11 @@ multi_client_connect_call_script(struct multi_context *m,
         if (openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-connect"))
         {
             multi_client_connect_post(m, mi, dc_file, option_types_found);
-            (*cc_succeeded_count)++;
+            ret = CC_RET_SUCCEEDED;
         }
         else
         {
-            *cc_succeeded = false;
+            ret = CC_RET_FAILED;
         }
 
         if (!platform_unlink(dc_file))
@@ -1913,6 +1911,7 @@ multi_client_connect_call_script(struct multi_context *m,
         argv_reset(&argv);
         gc_free(&gc);
     }
+    return ret;
 }
 
 static void
@@ -2047,18 +2046,18 @@ multi_client_connect_early_setup(struct multi_context *m,
     multi_select_virtual_addr(m, mi);
 
     multi_client_connect_setenv(m, mi);
-
 }
 
 /**
  * Try to source a dynamic config file from the
  * --client-config-dir directory.
  */
-static void
+enum client_connect_return
 multi_client_connect_source_ccd(struct multi_context *m,
                                 struct multi_instance *mi,
                                 unsigned int *option_types_found)
 {
+    enum client_connect_return ret = CC_RET_SKIPPED;
     if (mi->context.options.client_config_dir)
     {
         struct gc_arena gc = gc_new();
@@ -2100,9 +2099,35 @@ multi_client_connect_source_ccd(struct multi_context *m,
             multi_select_virtual_addr(m, mi);
 
             multi_client_connect_setenv(m, mi);
+
+            ret = CC_RET_SUCCEEDED;
         }
         gc_free(&gc);
     }
+    return ret;
+}
+
+static inline bool
+cc_check_return(int* cc_succeeded_count,
+                enum client_connect_return ret)
+{
+    if (ret == CC_RET_SUCCEEDED)
+    {
+        (*cc_succeeded_count)++;
+        return true;
+    }
+    else if (ret == CC_RET_FAILED)
+    {
+        return false;
+    }
+    else if (ret == CC_RET_SKIPPED)
+    {
+        return true;
+    }
+    else
+    {
+        ASSERT(0);
+    }
 }
 
 /*
@@ -2124,37 +2149,42 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 
         int cc_succeeded = true; /* client connect script status */
         int cc_succeeded_count = 0;
+        enum client_connect_return ret;
 
         multi_client_connect_early_setup (m, mi);
 
-        multi_client_connect_source_ccd (m, mi, &option_types_found);
+        ret = multi_client_connect_source_ccd (m, mi, &option_types_found);
+        cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
 
-        multi_client_connect_call_plugin_v1 (m, mi, &option_types_found,
-                                             &cc_succeeded,
-                                             &cc_succeeded_count);
+        if (cc_succeeded)
+        {
+            ret = multi_client_connect_call_plugin_v1(m, mi,
+                                                      &option_types_found);
+            cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
+        }
+
+        if (cc_succeeded)
+        {
+            ret = multi_client_connect_call_plugin_v2(m, mi,
+                                                      &option_types_found);
+            cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
+        }
 
-        multi_client_connect_call_plugin_v2 (m, mi, &option_types_found,
-                                             &cc_succeeded,
-                                             &cc_succeeded_count);
 
         /*
          * Check for client-connect script left by management interface client
          */
-
         if (cc_succeeded)
         {
-            multi_client_connect_call_script (m, mi, &option_types_found,
-                                              &cc_succeeded,
-                                              &cc_succeeded_count);
-
+            ret = multi_client_connect_call_script (m, mi, &option_types_found);
+            cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
         }
-#ifdef MANAGEMENT_DEF_AUTH
-        if (cc_succeeded && mi->cc_config)
+
+        if (cc_succeeded)
         {
-            multi_client_connect_mda(m, mi, &option_types_found);
-            cc_succeeded_count++;
+            ret = multi_client_connect_mda(m, mi, &option_types_found);
+            cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
         }
-#endif
 
         /*
          * Check for "disable" directive in client-config-dir file
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 2e20d152..7f8d4f99 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -191,6 +191,16 @@ struct multi_context {
     struct deferred_signal_schedule_entry deferred_shutdown_signal;
 };
 
+/**
+ * Return values used by the client connect call-back functions.
+ */
+enum client_connect_return
+{
+  CC_RET_FAILED,
+  CC_RET_SUCCEEDED,
+  CC_RET_SKIPPED
+};
+
 /*
  * Host route
  */
-- 
2.19.1


