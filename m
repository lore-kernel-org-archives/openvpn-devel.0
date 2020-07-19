From: Arne Schwabe <arne@...1227...>
Date: Sun, 19 Jul 2020 19:34:32 +0200
Message-Id: <20200719173436.16431-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v8 1/5] Remove CAS_PARTIAL state
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

This state is used to handle a corner case when multiple connect
handlers are active and one of them fails. Unfortunately, this state
complicates the state machine a bit without a good benefit.

Current behaviour:

First/all connect handler(s) fail:

  - client disconnect handler is not called at all

At least one connect handler succeeds but a subsequent handler fails:

  - client disconect is called when we actually
    disconnect the client (a few seconds later, max tls timeout)

All connect handlers suceed:

  - client disconect is called when we actually
    disconnect the client

This patches changes the behaviour in the second to immediately
call disconnect_handler in this case.

This simplifies the logic that already caused a bug and the
behaviour change is very little and affects only a pretty
exotic corner case.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst           |  7 +++++
 src/openvpn/multi.c   | 59 ++++++++++++++++++++-----------------------
 src/openvpn/openvpn.h |  5 ----
 3 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index e5228696..de831889 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -38,6 +38,13 @@ https://community.openvpn.net/openvpn/wiki/DeprecatedOptions
   This option was made into a NOOP option with OpenVPN 2.4.  This has now
   been completely removed.
 
+User-visible Changes
+--------------------
+- If multiple connect handlers are used (client-connect, ccd, connect
+  plugin) and one of the handler succeeds but a subsequent fails, the
+  client-disconnect-script is now called immediately. Previously it
+  was called, when the VPN session was terminated. 
+
 Overview of changes in 2.4
 ==========================
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0095c871..aab15cf7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -574,35 +574,30 @@ multi_client_disconnect_setenv(struct multi_instance *mi)
 static void
 multi_client_disconnect_script(struct multi_instance *mi)
 {
-    if (mi->context.c2.context_auth == CAS_SUCCEEDED
-        || mi->context.c2.context_auth == CAS_PARTIAL)
-    {
-        multi_client_disconnect_setenv(mi);
+    multi_client_disconnect_setenv(mi);
 
-        if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT))
+    if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT))
+    {
+        if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT, NULL, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
-            if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT, NULL, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
-            {
-                msg(M_WARN, "WARNING: client-disconnect plugin call failed");
-            }
+            msg(M_WARN, "WARNING: client-disconnect plugin call failed");
         }
+    }
 
-        if (mi->context.options.client_disconnect_script)
-        {
-            struct argv argv = argv_new();
-            setenv_str(mi->context.c2.es, "script_type", "client-disconnect");
-            argv_parse_cmd(&argv, mi->context.options.client_disconnect_script);
-            openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-disconnect");
-            argv_free(&argv);
-        }
+    if (mi->context.options.client_disconnect_script)
+    {
+        struct argv argv = argv_new();
+        setenv_str(mi->context.c2.es, "script_type", "client-disconnect");
+        argv_parse_cmd(&argv, mi->context.options.client_disconnect_script);
+        openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-disconnect");
+        argv_free(&argv);
+    }
 #ifdef MANAGEMENT_DEF_AUTH
-        if (management)
-        {
-            management_notify_client_close(management, &mi->context.c2.mda_context, mi->context.c2.es);
-        }
-#endif
-
+    if (management)
+    {
+        management_notify_client_close(management, &mi->context.c2.mda_context, mi->context.c2.es);
     }
+#endif
 }
 
 void
@@ -683,8 +678,10 @@ multi_close_instance(struct multi_context *m,
 #ifdef MANAGEMENT_DEF_AUTH
     set_cc_config(mi, NULL);
 #endif
-
-    multi_client_disconnect_script(mi);
+    if (mi->context.c2.context_auth == CAS_SUCCEEDED)
+    {
+        multi_client_disconnect_script(mi);
+    }
 
     close_context(&mi->context, SIGTERM, CC_GC_FREE);
 
@@ -2375,16 +2372,14 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
     }
     else
     {
-        /* set context-level authentication flag to failed but remember
-         * if had a handler succeed (for cleanup) */
+        /* run the disconnect script if we had a connect script that
+         * did not fail */
         if (mi->context.c2.context_auth == CAS_PENDING_DEFERRED_PARTIAL)
         {
-            mi->context.c2.context_auth = CAS_PARTIAL;
-        }
-        else
-        {
-            mi->context.c2.context_auth = CAS_FAILED;
+            multi_client_disconnect_script(mi);
         }
+
+        mi->context.c2.context_auth = CAS_FAILED;
     }
 
     /* increment number of current authenticated clients */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index ccc7f118..470d67dc 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -220,11 +220,6 @@ enum client_connect_status {
     CAS_PENDING_DEFERRED,
     CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded, no result yet*/
     CAS_FAILED,
-    CAS_PARTIAL,        /**< Variant of CAS_FAILED: at least one
-                         * client-connect script/plugin succeeded
-                         * while a later one in the chain failed
-                         * (we still need cleanup compared to FAILED)
-                         */
 };
 
 static inline bool
-- 
2.26.2


