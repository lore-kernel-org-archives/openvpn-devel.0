Sender: Fabian Knittel <fabian@...1547...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sat, 17 Jan 2015 12:30:23 +0000
Message-Id: <1421497831-3424-2-git-send-email-fabian.knittel@...1547...>
In-Reply-To: <1421497831-3424-1-git-send-email-fabian.knittel@...1547...>
References: <1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
	<1421497831-3424-1-git-send-email-fabian.knittel@...1547...>
Subject: [Openvpn-devel] [PATCH v2 1/9] client-connect: Split
	multi_connection_established into separate functions
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

This patch splits up the multi_connection_established() function.  Each new
helper function does a specific job.  Functions that do a similar job receive a
similar calling interface.

The patch tries not to reindent code, so that the real changes are as clearly
visible as possible.  (A follow-up patch will only do indentation changes.)

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/multi.c   | 322 ++++++++++++++++++++++++++++++++++----------------
 src/openvpn/options.h |   6 +
 2 files changed, 224 insertions(+), 104 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6ddfbb5..c24b203 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1461,7 +1461,6 @@ static void
 multi_client_connect_post (struct multi_context *m,
 			   struct multi_instance *mi,
 			   const char *dc_file,
-			   unsigned int option_permissions_mask,
 			   unsigned int *option_types_found)
 {
   /* Did script generate a dynamic config file? */
@@ -1470,7 +1469,7 @@ multi_client_connect_post (struct multi_context *m,
       options_server_import (&mi->context.options,
 			     dc_file,
 			     D_IMPORT_ERRORS|M_OPTERR,
-			     option_permissions_mask,
+			     CLIENT_CONNECT_OPT_MASK,
 			     option_types_found,
 			     mi->context.c2.es);
 
@@ -1494,7 +1493,6 @@ static void
 multi_client_connect_post_plugin (struct multi_context *m,
 				  struct multi_instance *mi,
 				  const struct plugin_return *pr,
-				  unsigned int option_permissions_mask,
 				  unsigned int *option_types_found)
 {
   struct plugin_return config;
@@ -1511,7 +1509,7 @@ multi_client_connect_post_plugin (struct multi_context *m,
 	    options_string_import (&mi->context.options,
 				   config.list[i]->value,
 				   D_IMPORT_ERRORS|M_OPTERR,
-				   option_permissions_mask,
+				   CLIENT_CONNECT_OPT_MASK,
 				   option_types_found,
 				   mi->context.c2.es);
 	}
@@ -1529,29 +1527,28 @@ multi_client_connect_post_plugin (struct multi_context *m,
 
 #endif
 
-#ifdef MANAGEMENT_DEF_AUTH
-
 /*
  * Called to load management-derived client-connect config
  */
 static void
 multi_client_connect_mda (struct multi_context *m,
 			  struct multi_instance *mi,
-			  const struct buffer_list *config,
-			  unsigned int option_permissions_mask,
-			  unsigned int *option_types_found)
+			  unsigned int *option_types_found,
+			  int *cc_succeeded,
+			  int *cc_succeeded_count)
 {
-  if (config)
+#ifdef MANAGEMENT_DEF_AUTH
+  if (mi->cc_config)
     {
       struct buffer_entry *be;
   
-      for (be = config->head; be != NULL; be = be->next)
+      for (be = mi->cc_config->head; be != NULL; be = be->next)
 	{
 	  const char *opt = BSTR(&be->buf);
 	  options_string_import (&mi->context.options,
 				 opt,
 				 D_IMPORT_ERRORS|M_OPTERR,
-				 option_permissions_mask,
+				 CLIENT_CONNECT_OPT_MASK,
 				 option_types_found,
 				 mi->context.c2.es);
 	}
@@ -1564,10 +1561,11 @@ multi_client_connect_mda (struct multi_context *m,
        */
       multi_select_virtual_addr (m, mi);
       multi_set_virtual_addr_env (m, mi);
-    }
-}
 
+      ++*cc_succeeded_count;
+    }
 #endif
+}
 
 static void
 multi_client_connect_setenv (struct multi_context *m,
@@ -1594,6 +1592,38 @@ multi_client_connect_setenv (struct multi_context *m,
   gc_free (&gc);
 }
 
+static void
+multi_client_connect_early_setup (struct multi_context *m,
+				  struct multi_instance *mi);
+static void
+multi_client_connect_source_ccd (struct multi_context *m,
+				 struct multi_instance *mi,
+				 unsigned int *option_types_found);
+static void
+multi_client_connect_call_plugin_v1 (struct multi_context *m,
+				     struct multi_instance *mi,
+				     unsigned int *option_types_found,
+				     int *cc_succeeded,
+				     int *cc_succeeded_count);
+static void
+multi_client_connect_call_plugin_v2 (struct multi_context *m,
+				     struct multi_instance *mi,
+				     unsigned int *option_types_found,
+				     int *cc_succeeded,
+				     int *cc_succeeded_count);
+static void
+multi_client_connect_call_script (struct multi_context *m,
+				  struct multi_instance *mi,
+				  unsigned int *option_types_found,
+				  int *cc_succeeded,
+				  int *cc_succeeded_count);
+static void
+multi_client_connect_late_setup (struct multi_context *m,
+				 struct multi_instance *mi,
+				 const unsigned int option_types_found,
+				 int cc_succeeded,
+				 const int cc_succeeded_count);
+
 /*
  * Called as soon as the SSL/TLS connection authenticates.
  *
@@ -1608,25 +1638,67 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 {
   if (tls_authentication_status (mi->context.c2.tls_multi, 0) == TLS_AUTHENTICATION_SUCCEEDED)
     {
-      struct gc_arena gc = gc_new ();
       unsigned int option_types_found = 0;
-
-      const unsigned int option_permissions_mask =
-	  OPT_P_INSTANCE
-	| OPT_P_INHERIT
-	| OPT_P_PUSH
-	| OPT_P_TIMER
-	| OPT_P_CONFIG
-	| OPT_P_ECHO
-	| OPT_P_COMP
-	| OPT_P_SOCKFLAGS;
-
       int cc_succeeded = true; /* client connect script status */
       int cc_succeeded_count = 0;
 
-      ASSERT (mi->context.c1.tuntap);
+      multi_client_connect_early_setup (m, mi);
+
+      multi_client_connect_source_ccd (m, mi, &option_types_found);
+
+      /*
+       * Select a virtual address from either --ifconfig-push in
+       * --client-config-dir file or --ifconfig-pool.
+       */
+      multi_select_virtual_addr (m, mi);
+
+      /* do --client-connect setenvs */
+      multi_client_connect_setenv (m, mi);
+
+      multi_client_connect_call_plugin_v1 (m, mi, &option_types_found,
+					   &cc_succeeded, &cc_succeeded_count);
+
+      multi_client_connect_call_plugin_v2 (m, mi, &option_types_found,
+					   &cc_succeeded, &cc_succeeded_count);
+
+      /*
+       * Run --client-connect script.
+       */
+      if (cc_succeeded)
+	{
+	  multi_client_connect_call_script (m, mi, &option_types_found,
+					    &cc_succeeded,
+					    &cc_succeeded_count);
+	}
+
+      /*
+       * Check for client-connect script left by management interface client
+       */
+      if (cc_succeeded)
+	{
+	  multi_client_connect_mda (m, mi, &option_types_found,
+				    &cc_succeeded, &cc_succeeded_count);
+	}
+
+      multi_client_connect_late_setup (m, mi, option_types_found,
+				       cc_succeeded, cc_succeeded_count);
+
+      /* set flag so we don't get called again */
+      mi->connection_established_flag = true;
+    }
+
+  /*
+   * Reply now to client's PUSH_REQUEST query
+   */
+  mi->context.c2.push_reply_deferred = false;
+}
 
-      /* lock down the common name and cert hashes so they can't change during future TLS renegotiations */
+static void
+multi_client_connect_early_setup (struct multi_context *m,
+				  struct multi_instance *mi)
+{
+      /* lock down the common name and cert hashes so they can't change during
+	 future TLS renegotiations */
       tls_lock_common_name (mi->context.c2.tls_multi);
       tls_lock_cert_hash_set (mi->context.c2.tls_multi);
 
@@ -1639,13 +1711,20 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 
       /* reset pool handle to null */
       mi->vaddr_handle = -1;
+}
 
-      /*
-       * Try to source a dynamic config file from the
-       * --client-config-dir directory.
-       */
+/*
+ * Try to source a dynamic config file from the
+ * --client-config-dir directory.
+ */
+static void
+multi_client_connect_source_ccd (struct multi_context *m,
+				 struct multi_instance *mi,
+				 unsigned int *option_types_found)
+{
       if (mi->context.options.client_config_dir)
 	{
+	  struct gc_arena gc = gc_new ();
 	  const char *ccd_file;
 	  
 	  ccd_file = gen_path (mi->context.options.client_config_dir,
@@ -1658,8 +1737,8 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	      options_server_import (&mi->context.options,
 				     ccd_file,
 				     D_IMPORT_ERRORS|M_OPTERR,
-				     option_permissions_mask,
-				     &option_types_found,
+				     CLIENT_CONNECT_OPT_MASK,
+				     option_types_found,
 				     mi->context.c2.es);
 	    }
 	  else /* try default file */
@@ -1673,95 +1752,142 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 		  options_server_import (&mi->context.options,
 					 ccd_file,
 					 D_IMPORT_ERRORS|M_OPTERR,
-					 option_permissions_mask,
-					 &option_types_found,
+					 CLIENT_CONNECT_OPT_MASK,
+					 option_types_found,
 					 mi->context.c2.es);
 		}
 	    }
-	}
 
-      /*
-       * Select a virtual address from either --ifconfig-push in --client-config-dir file
-       * or --ifconfig-pool.
-       */
-      multi_select_virtual_addr (m, mi);
-
-      /* do --client-connect setenvs */
-      multi_client_connect_setenv (m, mi);
+	  gc_free (&gc);
+	}
+}
 
+/*
+ * Call client-connect plug-in.
+ *
+ * deprecated callback, use a file for passing back return info
+ */
+static void
+multi_client_connect_call_plugin_v1 (struct multi_context *m,
+				     struct multi_instance *mi,
+				     unsigned int *option_types_found,
+				     int *cc_succeeded,
+				     int *cc_succeeded_count)
+{
 #ifdef ENABLE_PLUGIN
-      /*
-       * Call client-connect plug-in.
-       */
+      ASSERT (m);
+      ASSERT (mi);
+      ASSERT (option_types_found);
+      ASSERT (cc_succeeded);
+      ASSERT (cc_succeeded_count);
 
-      /* deprecated callback, use a file for passing back return info */
       if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
 	{
+	  int plug_ret;
+	  struct gc_arena gc = gc_new ();
 	  struct argv argv = argv_new ();
 	  const char *dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
 
-          if( !dc_file ) {
-            cc_succeeded = false;
-            goto script_depr_failed;
-          }
+          if (!dc_file)
+	    {
+	      *cc_succeeded = false;
+	      goto script_depr_failed;
+	    }
 
 	  argv_printf (&argv, "%s", dc_file);
-	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+
+	  plug_ret = plugin_call (mi->context.plugins,
+				  OPENVPN_PLUGIN_CLIENT_CONNECT,
+				  &argv, NULL, mi->context.c2.es);
+	  argv_reset (&argv);
+	  if (plug_ret != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	    {
 	      msg (M_WARN, "WARNING: client-connect plugin call failed");
-	      cc_succeeded = false;
+	      *cc_succeeded = false;
 	    }
 	  else
 	    {
-	      multi_client_connect_post (m, mi, dc_file, option_permissions_mask, &option_types_found);
-	      ++cc_succeeded_count;
+	      multi_client_connect_post (m, mi, dc_file, option_types_found);
+	      ++*cc_succeeded_count;
 	    }
-
-	  if (!platform_unlink (dc_file))
-	    msg (D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
-		 dc_file);
-
-        script_depr_failed:
-	  argv_reset (&argv);
+script_depr_failed:
+	  gc_free (&gc);
 	}
+#endif
+}
+
+/*
+ * Call client-connect plug-in.
+ *
+ * V2 callback, use a plugin_return struct for passing back return info
+ */
+static void
+multi_client_connect_call_plugin_v2 (struct multi_context *m,
+				     struct multi_instance *mi,
+				     unsigned int *option_types_found,
+				     int *cc_succeeded,
+				     int *cc_succeeded_count)
+{
+#ifdef ENABLE_PLUGIN
+      ASSERT (m);
+      ASSERT (mi);
+      ASSERT (option_types_found);
+      ASSERT (cc_succeeded);
+      ASSERT (cc_succeeded_count);
 
-      /* V2 callback, use a plugin_return struct for passing back return info */
       if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
 	{
+	  int plug_ret;
 	  struct plugin_return pr;
 
 	  plugin_return_init (&pr);
 
-	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2, NULL, &pr, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+	  plug_ret = plugin_call (mi->context.plugins,
+				  OPENVPN_PLUGIN_CLIENT_CONNECT_V2,
+				  NULL, &pr, mi->context.c2.es);
+	  if (plug_ret != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	    {
 	      msg (M_WARN, "WARNING: client-connect-v2 plugin call failed");
-	      cc_succeeded = false;
+	      *cc_succeeded = false;
 	    }
 	  else
 	    {
-	      multi_client_connect_post_plugin (m, mi, &pr, option_permissions_mask, &option_types_found);
-	      ++cc_succeeded_count;
+	      multi_client_connect_post_plugin (m, mi, &pr, option_types_found);
+	      ++*cc_succeeded_count;
 	    }
 
 	  plugin_return_free (&pr);
 	}
 #endif
+}
 
-      /*
-       * Run --client-connect script.
-       */
-      if (mi->context.options.client_connect_script && cc_succeeded)
+static void
+multi_client_connect_call_script (struct multi_context *m,
+				  struct multi_instance *mi,
+				  unsigned int *option_types_found,
+				  int *cc_succeeded,
+				  int *cc_succeeded_count)
+{
+      ASSERT (m);
+      ASSERT (mi);
+      ASSERT (option_types_found);
+      ASSERT (cc_succeeded);
+      ASSERT (cc_succeeded_count);
+
+      if (mi->context.options.client_connect_script)
 	{
+	  struct gc_arena gc = gc_new ();
 	  struct argv argv = argv_new ();
-	  const char *dc_file = NULL;
+	  const char *dc_file;
 
 	  setenv_str (mi->context.c2.es, "script_type", "client-connect");
 
 	  dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
-          if( !dc_file ) {
-            cc_succeeded = false;
-            goto script_failed;
-          }
+          if (!dc_file)
+	    {
+	      cc_succeeded = false;
+	      goto script_failed;
+	    }
 
 	  argv_printf (&argv, "%sc %s",
 		       mi->context.options.client_connect_script,
@@ -1769,30 +1895,26 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 
 	  if (openvpn_run_script (&argv, mi->context.c2.es, 0, "--client-connect"))
 	    {
-	      multi_client_connect_post (m, mi, dc_file, option_permissions_mask, &option_types_found);
+	      multi_client_connect_post (m, mi, dc_file, option_types_found);
 	      ++cc_succeeded_count;
 	    }
 	  else
 	    cc_succeeded = false;
-
-	  if (!platform_unlink (dc_file))
-	    msg (D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
-		 dc_file);
-
-        script_failed:
+script_failed:
 	  argv_reset (&argv);
+	  gc_free (&gc);
 	}
+}
 
-      /*
-       * Check for client-connect script left by management interface client
-       */
-#ifdef MANAGEMENT_DEF_AUTH
-      if (cc_succeeded && mi->cc_config)
-	{
-	  multi_client_connect_mda (m, mi, mi->cc_config, option_permissions_mask, &option_types_found);
-	  ++cc_succeeded_count;
-	}
-#endif
+static void
+multi_client_connect_late_setup (struct multi_context *m,
+				 struct multi_instance *mi,
+				 const unsigned int option_types_found,
+				 int cc_succeeded,
+				 const int cc_succeeded_count)
+{
+      struct gc_arena gc = gc_new ();
+      ASSERT (mi->context.c1.tuntap);
 
       /*
        * Check for "disable" directive in client-config-dir file
@@ -1886,9 +2008,6 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	  mi->context.c2.context_auth = cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
 	}
 
-      /* set flag so we don't get called again */
-      mi->connection_established_flag = true;
-
       /* increment number of current authenticated clients */
       ++m->n_clients;
       update_mstat_n_clients(m->n_clients);
@@ -1900,14 +2019,9 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 #endif
 
       gc_free (&gc);
-    }
-
-  /*
-   * Reply now to client's PUSH_REQUEST query
-   */
-  mi->context.c2.push_reply_deferred = false;
 }
 
+
 /*
  * Add a mbuf buffer to a particular
  * instance.
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 7a8b21e..73d1caa 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -636,6 +636,12 @@ struct options
 
 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))
 
+#if P2MP_SERVER
+#define CLIENT_CONNECT_OPT_MASK (OPT_P_INSTANCE | OPT_P_INHERIT	| OPT_P_PUSH | \
+				 OPT_P_TIMER | OPT_P_CONFIG | OPT_P_ECHO | \
+				 OPT_P_COMP | OPT_P_SOCKFLAGS)
+#endif
+
 #if P2MP
 #define PULL_DEFINED(opt) ((opt)->pull)
 #if P2MP_SERVER
-- 
2.1.4


