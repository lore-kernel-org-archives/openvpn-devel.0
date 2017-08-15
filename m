From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 15 Aug 2017 17:39:46 +0200
Message-ID: <1502811586-19578-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Move run_up_down() to init.c
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

This function is only used in init.c, and is not easy to fit into a
specific category because it both runs scripts and plugin hooks.  Making
it static in init.c is probably the best place for this function.

(I think we should find a better place for everything currently in misc.c,
and get rid of it all together.  This patch is part of that effort.)

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/init.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/misc.c | 89 ------------------------------------------------------
 src/openvpn/misc.h | 17 -----------
 3 files changed, 88 insertions(+), 106 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f0fc241..5552f05 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -94,6 +94,94 @@ context_clear_all_except_first_time(struct context *c)
 }
 
 /*
+ * Pass tunnel endpoint and MTU parms to a user-supplied script.
+ * Used to execute the up/down script/plugins.
+ */
+static void
+run_up_down(const char *command,
+            const struct plugin_list *plugins,
+            int plugin_type,
+            const char *arg,
+#ifdef _WIN32
+            DWORD adapter_index,
+#endif
+            const char *dev_type,
+            int tun_mtu,
+            int link_mtu,
+            const char *ifconfig_local,
+            const char *ifconfig_remote,
+            const char *context,
+            const char *signal_text,
+            const char *script_type,
+            struct env_set *es)
+{
+    struct gc_arena gc = gc_new();
+
+    if (signal_text)
+    {
+        setenv_str(es, "signal", signal_text);
+    }
+    setenv_str(es, "script_context", context);
+    setenv_int(es, "tun_mtu", tun_mtu);
+    setenv_int(es, "link_mtu", link_mtu);
+    setenv_str(es, "dev", arg);
+    if (dev_type)
+    {
+        setenv_str(es, "dev_type", dev_type);
+    }
+#ifdef _WIN32
+    setenv_int(es, "dev_idx", adapter_index);
+#endif
+
+    if (!ifconfig_local)
+    {
+        ifconfig_local = "";
+    }
+    if (!ifconfig_remote)
+    {
+        ifconfig_remote = "";
+    }
+    if (!context)
+    {
+        context = "";
+    }
+
+    if (plugin_defined(plugins, plugin_type))
+    {
+        struct argv argv = argv_new();
+        ASSERT(arg);
+        argv_printf(&argv,
+                    "%s %d %d %s %s %s",
+                    arg,
+                    tun_mtu, link_mtu,
+                    ifconfig_local, ifconfig_remote,
+                    context);
+
+        if (plugin_call(plugins, plugin_type, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+        {
+            msg(M_FATAL, "ERROR: up/down plugin call failed");
+        }
+
+        argv_reset(&argv);
+    }
+
+    if (command)
+    {
+        struct argv argv = argv_new();
+        ASSERT(arg);
+        setenv_str(es, "script_type", script_type);
+        argv_parse_cmd(&argv, command);
+        argv_printf_cat(&argv, "%s %d %d %s %s %s", arg, tun_mtu, link_mtu,
+                        ifconfig_local, ifconfig_remote, context);
+        argv_msg(M_INFO, &argv);
+        openvpn_run_script(&argv, es, S_FATAL, "--up/--down");
+        argv_reset(&argv);
+    }
+
+    gc_free(&gc);
+}
+
+/*
  * Should be called after options->ce is modified at the top
  * of a SIGUSR1 restart.
  */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index cd12f91..8c7f611 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -55,95 +55,6 @@ const char *iproute_path = IPROUTE_PATH; /* GLOBAL */
 int script_security = SSEC_BUILT_IN; /* GLOBAL */
 
 /*
- * Pass tunnel endpoint and MTU parms to a user-supplied script.
- * Used to execute the up/down script/plugins.
- */
-void
-run_up_down(const char *command,
-            const struct plugin_list *plugins,
-            int plugin_type,
-            const char *arg,
-#ifdef _WIN32
-            DWORD adapter_index,
-#endif
-            const char *dev_type,
-            int tun_mtu,
-            int link_mtu,
-            const char *ifconfig_local,
-            const char *ifconfig_remote,
-            const char *context,
-            const char *signal_text,
-            const char *script_type,
-            struct env_set *es)
-{
-    struct gc_arena gc = gc_new();
-
-    if (signal_text)
-    {
-        setenv_str(es, "signal", signal_text);
-    }
-    setenv_str(es, "script_context", context);
-    setenv_int(es, "tun_mtu", tun_mtu);
-    setenv_int(es, "link_mtu", link_mtu);
-    setenv_str(es, "dev", arg);
-    if (dev_type)
-    {
-        setenv_str(es, "dev_type", dev_type);
-    }
-#ifdef _WIN32
-    setenv_int(es, "dev_idx", adapter_index);
-#endif
-
-    if (!ifconfig_local)
-    {
-        ifconfig_local = "";
-    }
-    if (!ifconfig_remote)
-    {
-        ifconfig_remote = "";
-    }
-    if (!context)
-    {
-        context = "";
-    }
-
-    if (plugin_defined(plugins, plugin_type))
-    {
-        struct argv argv = argv_new();
-        ASSERT(arg);
-        argv_printf(&argv,
-                    "%s %d %d %s %s %s",
-                    arg,
-                    tun_mtu, link_mtu,
-                    ifconfig_local, ifconfig_remote,
-                    context);
-
-        if (plugin_call(plugins, plugin_type, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
-        {
-            msg(M_FATAL, "ERROR: up/down plugin call failed");
-        }
-
-        argv_reset(&argv);
-    }
-
-    if (command)
-    {
-        struct argv argv = argv_new();
-        ASSERT(arg);
-        setenv_str(es, "script_type", script_type);
-        argv_parse_cmd(&argv, command);
-        argv_printf_cat(&argv, "%s %d %d %s %s %s", arg, tun_mtu, link_mtu,
-                        ifconfig_local, ifconfig_remote, context);
-        argv_msg(M_INFO, &argv);
-        openvpn_run_script(&argv, es, S_FATAL, "--up/--down");
-        argv_reset(&argv);
-    }
-
-    gc_free(&gc);
-}
-
-
-/*
  * Set standard file descriptors to /dev/null
  */
 void
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index a7aa762..eb39ce3 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -51,23 +51,6 @@ struct env_set {
     struct env_item *list;
 };
 
-void run_up_down(const char *command,
-                 const struct plugin_list *plugins,
-                 int plugin_type,
-                 const char *arg,
-#ifdef _WIN32
-                 DWORD adapter_index,
-#endif
-                 const char *dev_type,
-                 int tun_mtu,
-                 int link_mtu,
-                 const char *ifconfig_local,
-                 const char *ifconfig_remote,
-                 const char *context,
-                 const char *signal_text,
-                 const char *script_type,
-                 struct env_set *es);
-
 /* system flags */
 #define S_SCRIPT (1<<0)
 #define S_FATAL  (1<<1)
-- 
2.7.4


