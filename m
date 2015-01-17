Sender: Fabian Knittel <fabian@...1547...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sat, 17 Jan 2015 12:30:27 +0000
Message-Id: <1421497831-3424-6-git-send-email-fabian.knittel@...1547...>
In-Reply-To: <1421497831-3424-1-git-send-email-fabian.knittel@...1547...>
References: <1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
	<1421497831-3424-1-git-send-email-fabian.knittel@...1547...>
Subject: [Openvpn-devel] [PATCH v2 5/9] client-connect: Refactor to use
	return values instead of modifying a passed-in flag
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This patch changes the way the client-connect helper functions communicate with
the main function.  Instead of updating cc_succeeded and cc_succeeded_count,
they now return either CC_RET_SUCCEEDED, CC_RET_FAILED or CC_RET_SKIPPED.

In addition, the client-connect helpers are now called in completely identical
ways.  This is in preparation of handling the helpers as simple call-backs.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/multi.c | 122 +++++++++++++++++++++++++++++++---------------------
 src/openvpn/multi.h |  11 ++++-
 2 files changed, 82 insertions(+), 51 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e9fbdc6..072a5f6 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1530,13 +1530,12 @@ multi_client_connect_post_plugin (struct multi_context *m,
 /*
  * Called to load management-derived client-connect config
  */
-static void
+static enum client_connect_return
 multi_client_connect_mda (struct multi_context *m,
 			  struct multi_instance *mi,
-			  unsigned int *option_types_found,
-			  int *cc_succeeded,
-			  int *cc_succeeded_count)
+			  unsigned int *option_types_found)
 {
+  enum client_connect_return ret = CC_RET_SKIPPED;
 #ifdef MANAGEMENT_DEF_AUTH
   if (mi->cc_config)
     {
@@ -1562,9 +1561,10 @@ multi_client_connect_mda (struct multi_context *m,
       multi_select_virtual_addr (m, mi);
       multi_set_virtual_addr_env (m, mi);
 
-      ++*cc_succeeded_count;
+      ret = CC_RET_SUCCEEDED;
     }
 #endif
+  return ret;
 }
 
 static void
@@ -1641,38 +1641,59 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
       unsigned int option_types_found = 0;
       int cc_succeeded = true; /* client connect script status */
       int cc_succeeded_count = 0;
+      enum client_connect_return ret;
 
       multi_client_connect_early_setup (m, mi);
 
-      multi_client_connect_source_ccd (m, mi, &option_types_found);
+      if (cc_succeeded)
+	{
+	  ret = multi_client_connect_source_ccd (m, mi, &option_types_found);
+	  if (ret == CC_RET_SUCCEEDED)
+	    ++cc_succeeded_count;
+	  else if (ret == CC_RET_FAILED)
+	    cc_succeeded = false;
+	}
 
-      multi_client_connect_call_plugin_v1 (m, mi, &option_types_found,
-					   &cc_succeeded, &cc_succeeded_count);
+      if (cc_succeeded)
+	{
+	  ret = multi_client_connect_call_plugin_v1 (m, mi,
+						     &option_types_found);
+	  if (ret == CC_RET_SUCCEEDED)
+	    ++cc_succeeded_count;
+	  else if (ret == CC_RET_FAILED)
+	    cc_succeeded = false;
+	}
 
-      multi_client_connect_call_plugin_v2 (m, mi, &option_types_found,
-					   &cc_succeeded, &cc_succeeded_count);
+      if (cc_succeeded)
+	{
+	  ret = multi_client_connect_call_plugin_v2 (m, mi,
+						     &option_types_found);
+	  if (ret == CC_RET_SUCCEEDED)
+	    ++cc_succeeded_count;
+	  else if (ret == CC_RET_FAILED)
+	    cc_succeeded = false;
+	}
 
-      /*
-       * Run --client-connect script.
-       */
       if (cc_succeeded)
 	{
-	  multi_client_connect_call_script (m, mi, &option_types_found,
-					    &cc_succeeded,
-					    &cc_succeeded_count);
+	  ret = multi_client_connect_call_script (m, mi, &option_types_found);
+	  if (ret == CC_RET_SUCCEEDED)
+	    ++cc_succeeded_count;
+	  else if (ret == CC_RET_FAILED)
+	    cc_succeeded = false;
 	}
 
-      /*
-       * Check for client-connect script left by management interface client
-       */
       if (cc_succeeded)
 	{
-	  multi_client_connect_mda (m, mi, &option_types_found,
-				    &cc_succeeded, &cc_succeeded_count);
+	  ret = multi_client_connect_mda (m, mi, &option_types_found);
+	  if (ret == CC_RET_SUCCEEDED)
+	    ++cc_succeeded_count;
+	  else if (ret == CC_RET_FAILED)
+	    cc_succeeded = false;
 	}
 
-      multi_client_connect_late_setup (m, mi, option_types_found,
-				       cc_succeeded, cc_succeeded_count);
+      multi_client_connect_late_setup (m, mi, option_types_found, cc_succeeded,
+				       cc_succeeded_count);
 
       /* set flag so we don't get called again */
       mi->connection_established_flag = true;
@@ -1712,11 +1733,13 @@ multi_client_connect_early_setup (struct multi_context *m,
  * Try to source a dynamic config file from the
  * --client-config-dir directory.
  */
-static void
+static enum client_connect_return
 multi_client_connect_source_ccd (struct multi_context *m,
 				 struct multi_instance *mi,
 				 unsigned int *option_types_found)
 {
+  enum client_connect_return ret = CC_RET_SKIPPED;
+
   if (mi->context.options.client_config_dir)
     {
       struct gc_arena gc = gc_new ();
@@ -1754,10 +1777,14 @@ multi_client_connect_source_ccd (struct multi_context *m,
 	   */
 	  multi_select_virtual_addr (m, mi);
 	  multi_set_virtual_addr_env (m, mi);
+
+	  ret = CC_RET_SUCCEEDED;
 	}
 
       gc_free (&gc);
     }
+
+  return ret;
 }
 
 /*
@@ -1765,19 +1792,16 @@ multi_client_connect_source_ccd (struct multi_context *m,
  *
  * deprecated callback, use a file for passing back return info
  */
-static void
+static enum client_connect_return
 multi_client_connect_call_plugin_v1 (struct multi_context *m,
 				     struct multi_instance *mi,
-				     unsigned int *option_types_found,
-				     int *cc_succeeded,
-				     int *cc_succeeded_count)
+				     unsigned int *option_types_found)
 {
+  enum client_connect_return ret = CC_RET_SKIPPED;
 #ifdef ENABLE_PLUGIN
   ASSERT (m);
   ASSERT (mi);
   ASSERT (option_types_found);
-  ASSERT (cc_succeeded);
-  ASSERT (cc_succeeded_count);
 
   if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
     {
@@ -1788,7 +1812,7 @@ multi_client_connect_call_plugin_v1 (struct multi_context *m,
 
       if (!dc_file)
 	{
-	  *cc_succeeded = false;
+	  ret = CC_RET_FAILED;
 	  goto script_depr_failed;
 	}
 
@@ -1801,17 +1825,18 @@ multi_client_connect_call_plugin_v1 (struct multi_context *m,
       if (plug_ret != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	{
 	  msg (M_WARN, "WARNING: client-connect plugin call failed");
-	  *cc_succeeded = false;
+	  ret = CC_RET_FAILED;
 	}
       else
 	{
 	  multi_client_connect_post (m, mi, dc_file, option_types_found);
-	  ++*cc_succeeded_count;
+	  ret = CC_RET_SUCCEEDED;
 	}
 script_depr_failed:
       gc_free (&gc);
     }
 #endif
+  return ret;
 }
 
 /*
@@ -1819,19 +1844,16 @@ script_depr_failed:
  *
  * V2 callback, use a plugin_return struct for passing back return info
  */
-static void
+static enum client_connect_return
 multi_client_connect_call_plugin_v2 (struct multi_context *m,
 				     struct multi_instance *mi,
-				     unsigned int *option_types_found,
-				     int *cc_succeeded,
-				     int *cc_succeeded_count)
+				     unsigned int *option_types_found)
 {
+  enum client_connect_return ret = CC_RET_SKIPPED;
 #ifdef ENABLE_PLUGIN
   ASSERT (m);
   ASSERT (mi);
   ASSERT (option_types_found);
-  ASSERT (cc_succeeded);
-  ASSERT (cc_succeeded_count);
 
   if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
     {
@@ -1846,31 +1868,29 @@ multi_client_connect_call_plugin_v2 (struct multi_context *m,
       if (plug_ret != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	{
 	  msg (M_WARN, "WARNING: client-connect-v2 plugin call failed");
-	  *cc_succeeded = false;
+	  ret = CC_RET_FAILED;
 	}
       else
 	{
 	  multi_client_connect_post_plugin (m, mi, &pr, option_types_found);
-	  ++*cc_succeeded_count;
+	  ret = CC_RET_SUCCEEDED;
 	}
 
       plugin_return_free (&pr);
     }
 #endif
+  return ret;
 }
 
-static void
+static enum client_connect_return
 multi_client_connect_call_script (struct multi_context *m,
 				  struct multi_instance *mi,
-				  unsigned int *option_types_found,
-				  int *cc_succeeded,
-				  int *cc_succeeded_count)
+				  unsigned int *option_types_found)
 {
+  enum client_connect_return ret = CC_RET_SKIPPED;
   ASSERT (m);
   ASSERT (mi);
   ASSERT (option_types_found);
-  ASSERT (cc_succeeded);
-  ASSERT (cc_succeeded_count);
 
   if (mi->context.options.client_connect_script)
     {
@@ -1883,7 +1903,7 @@ multi_client_connect_call_script (struct multi_context *m,
       dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
       if (!dc_file)
 	{
-	  cc_succeeded = false;
+	  ret = CC_RET_FAILED;
 	  goto script_failed;
 	}
 
@@ -1894,14 +1914,16 @@ multi_client_connect_call_script (struct multi_context *m,
       if (openvpn_run_script (&argv, mi->context.c2.es, 0, "--client-connect"))
 	{
 	  multi_client_connect_post (m, mi, dc_file, option_types_found);
-	  ++cc_succeeded_count;
+	  ret = CC_RET_SUCCEEDED;
 	}
       else
-	cc_succeeded = false;
+	ret = CC_RET_FAILED;
+
 script_failed:
       argv_reset (&argv);
       gc_free (&gc);
     }
+  return ret;
 }
 
 static void
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 32b89d2..4d61085 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -107,7 +107,6 @@ struct multi_instance {
                                  *   for this VPN tunnel. */
 };
 
-
 /**
  * Main OpenVPN server state structure.
  *
@@ -174,6 +173,16 @@ struct multi_context {
   struct event_timeout stale_routes_check_et;
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
2.1.4


