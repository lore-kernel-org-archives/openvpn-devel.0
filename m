Sender: Fabian Knittel <fabian@...1547...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sat, 11 Oct 2014 00:09:26 +0200
Message-Id: <1412978966-15392-10-git-send-email-fabian.knittel@...1547...>
In-Reply-To: <1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
References: <5437B156.1020408@...1114...>
	<1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
Subject: [Openvpn-devel] [PATCH 9/9] client-connect: Add deferred support to
	the client-connect plugin v1 handler
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

Uses the infrastructure provided and used in the previous patch to provide
deferral support to the v1 client-connect plugin handler as well.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/multi.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a3d94fa..c888e39 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1799,6 +1799,7 @@ multi_client_connect_call_plugin_v1 (struct multi_context *m,
 {
   enum client_connect_return ret = CC_RET_SKIPPED;
 #ifdef ENABLE_PLUGIN
+  struct client_connect_state *ccs = mi->client_connect_state;
   ASSERT (m);
   ASSERT (mi);
   ASSERT (option_types_found);
@@ -1806,34 +1807,41 @@ multi_client_connect_call_plugin_v1 (struct multi_context *m,
   if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
     {
       int plug_ret;
-      struct gc_arena gc = gc_new ();
       struct argv argv = argv_new ();
-      const char *dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
 
-      if (!dc_file)
+      if (!ccs_gen_config_file (mi) ||
+	  !ccs_gen_deferred_ret_file (mi))
 	{
 	  ret = CC_RET_FAILED;
 	  goto script_depr_failed;
 	}
 
-      argv_printf (&argv, "%s", dc_file);
+      argv_printf (&argv, "%s", ccs->config_file);
 
       plug_ret = plugin_call (mi->context.plugins,
 			      OPENVPN_PLUGIN_CLIENT_CONNECT,
 			      &argv, NULL, mi->context.c2.es);
       argv_reset (&argv);
-      if (plug_ret != OPENVPN_PLUGIN_FUNC_SUCCESS)
+      if (plug_ret == OPENVPN_PLUGIN_FUNC_SUCCESS)
 	{
-	  msg (M_WARN, "WARNING: client-connect plugin call failed");
-	  ret = CC_RET_FAILED;
+	  multi_client_connect_post (m, mi, ccs->config_file,
+				     option_types_found);
+	  ret = CC_RET_SUCCEEDED;
 	}
+      else if (plug_ret == OPENVPN_PLUGIN_FUNC_DEFERRED)
+	ret = CC_RET_DEFERRED;
       else
 	{
-	  multi_client_connect_post (m, mi, dc_file, option_types_found);
-	  ret = CC_RET_SUCCEEDED;
+	  msg (M_WARN, "WARNING: client-connect plugin call failed");
+	  ret = CC_RET_FAILED;
 	}
+
 script_depr_failed:
-      gc_free (&gc);
+      if (ret != CC_RET_DEFERRED)
+	{
+	  ccs_delete_config_file (mi);
+	  ccs_delete_deferred_ret_file (mi);
+	}
     }
 #endif
   return ret;
@@ -2126,7 +2134,7 @@ static const struct client_connect_handlers client_connect_handlers[] = {
   },
   {
     main: multi_client_connect_call_plugin_v1,
-    deferred: multi_client_connect_fail
+    deferred: multi_client_handle_deferred
   },
   {
     main: multi_client_connect_call_plugin_v2,
-- 
2.1.1


