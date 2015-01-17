Sender: Fabian Knittel <fabian@...1547...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sat, 17 Jan 2015 12:30:24 +0000
Message-Id: <1421497831-3424-3-git-send-email-fabian.knittel@...1547...>
In-Reply-To: <1421497831-3424-1-git-send-email-fabian.knittel@...1547...>
References: <1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
	<1421497831-3424-1-git-send-email-fabian.knittel@...1547...>
Subject: [Openvpn-devel] [PATCH v2 2/9] client-connect: Properly indent all
	functions
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

This patch adds proper indentation to all new helper functions.  No functional
changes are performed.  Nothing is moved around.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/multi.c | 408 ++++++++++++++++++++++++++--------------------------
 1 file changed, 204 insertions(+), 204 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c24b203..80bd5a3 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1697,20 +1697,20 @@ static void
 multi_client_connect_early_setup (struct multi_context *m,
 				  struct multi_instance *mi)
 {
-      /* lock down the common name and cert hashes so they can't change during
-	 future TLS renegotiations */
-      tls_lock_common_name (mi->context.c2.tls_multi);
-      tls_lock_cert_hash_set (mi->context.c2.tls_multi);
+  /* lock down the common name and cert hashes so they can't change during
+     future TLS renegotiations */
+  tls_lock_common_name (mi->context.c2.tls_multi);
+  tls_lock_cert_hash_set (mi->context.c2.tls_multi);
 
-      /* generate a msg() prefix for this client instance */
-      generate_prefix (mi);
+  /* generate a msg() prefix for this client instance */
+  generate_prefix (mi);
 
-      /* delete instances of previous clients with same common-name */
-      if (!mi->context.options.duplicate_cn)
-	multi_delete_dup (m, mi);
+  /* delete instances of previous clients with same common-name */
+  if (!mi->context.options.duplicate_cn)
+    multi_delete_dup (m, mi);
 
-      /* reset pool handle to null */
-      mi->vaddr_handle = -1;
+  /* reset pool handle to null */
+  mi->vaddr_handle = -1;
 }
 
 /*
@@ -1722,16 +1722,31 @@ multi_client_connect_source_ccd (struct multi_context *m,
 				 struct multi_instance *mi,
 				 unsigned int *option_types_found)
 {
-      if (mi->context.options.client_config_dir)
+  if (mi->context.options.client_config_dir)
+    {
+      struct gc_arena gc = gc_new ();
+      const char *ccd_file;
+      
+      ccd_file = gen_path (mi->context.options.client_config_dir,
+			   tls_common_name (mi->context.c2.tls_multi, false),
+			   &gc);
+
+      /* try common-name file */
+      if (test_file (ccd_file))
+	{
+	  options_server_import (&mi->context.options,
+				 ccd_file,
+				 D_IMPORT_ERRORS|M_OPTERR,
+				 CLIENT_CONNECT_OPT_MASK,
+				 option_types_found,
+				 mi->context.c2.es);
+	}
+      else /* try default file */
 	{
-	  struct gc_arena gc = gc_new ();
-	  const char *ccd_file;
-	  
 	  ccd_file = gen_path (mi->context.options.client_config_dir,
-			       tls_common_name (mi->context.c2.tls_multi, false),
+			       CCD_DEFAULT,
 			       &gc);
 
-	  /* try common-name file */
 	  if (test_file (ccd_file))
 	    {
 	      options_server_import (&mi->context.options,
@@ -1741,25 +1756,10 @@ multi_client_connect_source_ccd (struct multi_context *m,
 				     option_types_found,
 				     mi->context.c2.es);
 	    }
-	  else /* try default file */
-	    {
-	      ccd_file = gen_path (mi->context.options.client_config_dir,
-				   CCD_DEFAULT,
-				   &gc);
-
-	      if (test_file (ccd_file))
-		{
-		  options_server_import (&mi->context.options,
-					 ccd_file,
-					 D_IMPORT_ERRORS|M_OPTERR,
-					 CLIENT_CONNECT_OPT_MASK,
-					 option_types_found,
-					 mi->context.c2.es);
-		}
-	    }
-
-	  gc_free (&gc);
 	}
+
+      gc_free (&gc);
+    }
 }
 
 /*
@@ -1775,44 +1775,44 @@ multi_client_connect_call_plugin_v1 (struct multi_context *m,
 				     int *cc_succeeded_count)
 {
 #ifdef ENABLE_PLUGIN
-      ASSERT (m);
-      ASSERT (mi);
-      ASSERT (option_types_found);
-      ASSERT (cc_succeeded);
-      ASSERT (cc_succeeded_count);
+  ASSERT (m);
+  ASSERT (mi);
+  ASSERT (option_types_found);
+  ASSERT (cc_succeeded);
+  ASSERT (cc_succeeded_count);
 
-      if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
-	{
-	  int plug_ret;
-	  struct gc_arena gc = gc_new ();
-	  struct argv argv = argv_new ();
-	  const char *dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
+  if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
+    {
+      int plug_ret;
+      struct gc_arena gc = gc_new ();
+      struct argv argv = argv_new ();
+      const char *dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
 
-          if (!dc_file)
-	    {
-	      *cc_succeeded = false;
-	      goto script_depr_failed;
-	    }
+      if (!dc_file)
+	{
+	  *cc_succeeded = false;
+	  goto script_depr_failed;
+	}
 
-	  argv_printf (&argv, "%s", dc_file);
+      argv_printf (&argv, "%s", dc_file);
 
-	  plug_ret = plugin_call (mi->context.plugins,
-				  OPENVPN_PLUGIN_CLIENT_CONNECT,
-				  &argv, NULL, mi->context.c2.es);
-	  argv_reset (&argv);
-	  if (plug_ret != OPENVPN_PLUGIN_FUNC_SUCCESS)
-	    {
-	      msg (M_WARN, "WARNING: client-connect plugin call failed");
-	      *cc_succeeded = false;
-	    }
-	  else
-	    {
-	      multi_client_connect_post (m, mi, dc_file, option_types_found);
-	      ++*cc_succeeded_count;
-	    }
-script_depr_failed:
-	  gc_free (&gc);
+      plug_ret = plugin_call (mi->context.plugins,
+			      OPENVPN_PLUGIN_CLIENT_CONNECT,
+			      &argv, NULL, mi->context.c2.es);
+      argv_reset (&argv);
+      if (plug_ret != OPENVPN_PLUGIN_FUNC_SUCCESS)
+	{
+	  msg (M_WARN, "WARNING: client-connect plugin call failed");
+	  *cc_succeeded = false;
 	}
+      else
+	{
+	  multi_client_connect_post (m, mi, dc_file, option_types_found);
+	  ++*cc_succeeded_count;
+	}
+script_depr_failed:
+      gc_free (&gc);
+    }
 #endif
 }
 
@@ -1829,35 +1829,35 @@ multi_client_connect_call_plugin_v2 (struct multi_context *m,
 				     int *cc_succeeded_count)
 {
 #ifdef ENABLE_PLUGIN
-      ASSERT (m);
-      ASSERT (mi);
-      ASSERT (option_types_found);
-      ASSERT (cc_succeeded);
-      ASSERT (cc_succeeded_count);
-
-      if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
-	{
-	  int plug_ret;
-	  struct plugin_return pr;
+  ASSERT (m);
+  ASSERT (mi);
+  ASSERT (option_types_found);
+  ASSERT (cc_succeeded);
+  ASSERT (cc_succeeded_count);
 
-	  plugin_return_init (&pr);
+  if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
+    {
+      int plug_ret;
+      struct plugin_return pr;
 
-	  plug_ret = plugin_call (mi->context.plugins,
-				  OPENVPN_PLUGIN_CLIENT_CONNECT_V2,
-				  NULL, &pr, mi->context.c2.es);
-	  if (plug_ret != OPENVPN_PLUGIN_FUNC_SUCCESS)
-	    {
-	      msg (M_WARN, "WARNING: client-connect-v2 plugin call failed");
-	      *cc_succeeded = false;
-	    }
-	  else
-	    {
-	      multi_client_connect_post_plugin (m, mi, &pr, option_types_found);
-	      ++*cc_succeeded_count;
-	    }
+      plugin_return_init (&pr);
 
-	  plugin_return_free (&pr);
+      plug_ret = plugin_call (mi->context.plugins,
+			      OPENVPN_PLUGIN_CLIENT_CONNECT_V2,
+			      NULL, &pr, mi->context.c2.es);
+      if (plug_ret != OPENVPN_PLUGIN_FUNC_SUCCESS)
+	{
+	  msg (M_WARN, "WARNING: client-connect-v2 plugin call failed");
+	  *cc_succeeded = false;
+	}
+      else
+	{
+	  multi_client_connect_post_plugin (m, mi, &pr, option_types_found);
+	  ++*cc_succeeded_count;
 	}
+
+      plugin_return_free (&pr);
+    }
 #endif
 }
 
@@ -1868,42 +1868,42 @@ multi_client_connect_call_script (struct multi_context *m,
 				  int *cc_succeeded,
 				  int *cc_succeeded_count)
 {
-      ASSERT (m);
-      ASSERT (mi);
-      ASSERT (option_types_found);
-      ASSERT (cc_succeeded);
-      ASSERT (cc_succeeded_count);
+  ASSERT (m);
+  ASSERT (mi);
+  ASSERT (option_types_found);
+  ASSERT (cc_succeeded);
+  ASSERT (cc_succeeded_count);
 
-      if (mi->context.options.client_connect_script)
-	{
-	  struct gc_arena gc = gc_new ();
-	  struct argv argv = argv_new ();
-	  const char *dc_file;
+  if (mi->context.options.client_connect_script)
+    {
+      struct gc_arena gc = gc_new ();
+      struct argv argv = argv_new ();
+      const char *dc_file;
 
-	  setenv_str (mi->context.c2.es, "script_type", "client-connect");
+      setenv_str (mi->context.c2.es, "script_type", "client-connect");
 
-	  dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
-          if (!dc_file)
-	    {
-	      cc_succeeded = false;
-	      goto script_failed;
-	    }
+      dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
+      if (!dc_file)
+	{
+	  cc_succeeded = false;
+	  goto script_failed;
+	}
 
-	  argv_printf (&argv, "%sc %s",
-		       mi->context.options.client_connect_script,
-		       dc_file);
+      argv_printf (&argv, "%sc %s",
+		   mi->context.options.client_connect_script,
+		   dc_file);
 
-	  if (openvpn_run_script (&argv, mi->context.c2.es, 0, "--client-connect"))
-	    {
-	      multi_client_connect_post (m, mi, dc_file, option_types_found);
-	      ++cc_succeeded_count;
-	    }
-	  else
-	    cc_succeeded = false;
-script_failed:
-	  argv_reset (&argv);
-	  gc_free (&gc);
+      if (openvpn_run_script (&argv, mi->context.c2.es, 0, "--client-connect"))
+	{
+	  multi_client_connect_post (m, mi, dc_file, option_types_found);
+	  ++cc_succeeded_count;
 	}
+      else
+	cc_succeeded = false;
+script_failed:
+      argv_reset (&argv);
+      gc_free (&gc);
+    }
 }
 
 static void
@@ -1913,112 +1913,112 @@ multi_client_connect_late_setup (struct multi_context *m,
 				 int cc_succeeded,
 				 const int cc_succeeded_count)
 {
-      struct gc_arena gc = gc_new ();
-      ASSERT (mi->context.c1.tuntap);
+  struct gc_arena gc = gc_new ();
+  ASSERT (mi->context.c1.tuntap);
 
+  /*
+   * Check for "disable" directive in client-config-dir file
+   * or config file generated by --client-connect script.
+   */
+  if (mi->context.options.disable)
+    {
+      msg (D_MULTI_ERRORS, "MULTI: client has been rejected due to 'disable' directive");
+      cc_succeeded = false;
+    }
+
+  if (cc_succeeded)
+    {
       /*
-       * Check for "disable" directive in client-config-dir file
-       * or config file generated by --client-connect script.
+       * Process sourced options.
        */
-      if (mi->context.options.disable)
+      do_deferred_options (&mi->context, option_types_found);
+
+      /*
+       * make sure we got ifconfig settings from somewhere
+       */
+      if (!mi->context.c2.push_ifconfig_defined)
 	{
-	  msg (D_MULTI_ERRORS, "MULTI: client has been rejected due to 'disable' directive");
-	  cc_succeeded = false;
+	  msg (D_MULTI_ERRORS, "MULTI: no dynamic or static remote --ifconfig address is available for %s",
+	       multi_instance_string (mi, false, &gc));
 	}
 
-      if (cc_succeeded)
+      /*
+       * make sure that ifconfig settings comply with constraints
+       */
+      if (!ifconfig_push_constraint_satisfied (&mi->context))
 	{
-	  /*
-	   * Process sourced options.
-	   */
-	  do_deferred_options (&mi->context, option_types_found);
+	  /* JYFIXME -- this should cause the connection to fail */
+	  msg (D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s) violates tunnel network/netmask constraint (%s/%s)",
+	       multi_instance_string (mi, false, &gc),
+	       print_in_addr_t (mi->context.c2.push_ifconfig_local, 0, &gc),
+	       print_in_addr_t (mi->context.options.push_ifconfig_constraint_network, 0, &gc),
+	       print_in_addr_t (mi->context.options.push_ifconfig_constraint_netmask, 0, &gc));
+	}
 
-	  /*
-	   * make sure we got ifconfig settings from somewhere
-	   */
-	  if (!mi->context.c2.push_ifconfig_defined)
+      /*
+       * For routed tunnels, set up internal route to endpoint
+       * plus add all iroute routes.
+       */
+      if (TUNNEL_TYPE (mi->context.c1.tuntap) == DEV_TYPE_TUN)
+	{
+	  if (mi->context.c2.push_ifconfig_defined)
 	    {
-	      msg (D_MULTI_ERRORS, "MULTI: no dynamic or static remote --ifconfig address is available for %s",
-		   multi_instance_string (mi, false, &gc));
+	      multi_learn_in_addr_t (m, mi, mi->context.c2.push_ifconfig_local, -1, true);
+	      msg (D_MULTI_LOW, "MULTI: primary virtual IP for %s: %s",
+		   multi_instance_string (mi, false, &gc),
+		   print_in_addr_t (mi->context.c2.push_ifconfig_local, 0, &gc));
 	    }
 
-	  /*
-	   * make sure that ifconfig settings comply with constraints
-	   */
-	  if (!ifconfig_push_constraint_satisfied (&mi->context))
+	  if (mi->context.c2.push_ifconfig_ipv6_defined)
 	    {
-	      /* JYFIXME -- this should cause the connection to fail */
-	      msg (D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s) violates tunnel network/netmask constraint (%s/%s)",
+	      multi_learn_in6_addr (m, mi, mi->context.c2.push_ifconfig_ipv6_local, -1, true);
+	      /* TODO: find out where addresses are "unlearned"!! */
+	      msg (D_MULTI_LOW, "MULTI: primary virtual IPv6 for %s: %s",
 		   multi_instance_string (mi, false, &gc),
-		   print_in_addr_t (mi->context.c2.push_ifconfig_local, 0, &gc),
-		   print_in_addr_t (mi->context.options.push_ifconfig_constraint_network, 0, &gc),
-		   print_in_addr_t (mi->context.options.push_ifconfig_constraint_netmask, 0, &gc));
+		   print_in6_addr (mi->context.c2.push_ifconfig_ipv6_local, 0, &gc));
 	    }
 
+	  /* add routes locally, pointing to new client, if
+	     --iroute options have been specified */
+	  multi_add_iroutes (m, mi);
+
 	  /*
-	   * For routed tunnels, set up internal route to endpoint
-	   * plus add all iroute routes.
+	   * iroutes represent subnets which are "owned" by a particular
+	   * client.  Therefore, do not actually push a route to a client
+	   * if it matches one of the client's iroutes.
 	   */
-	  if (TUNNEL_TYPE (mi->context.c1.tuntap) == DEV_TYPE_TUN)
-	    {
-	      if (mi->context.c2.push_ifconfig_defined)
-		{
-		  multi_learn_in_addr_t (m, mi, mi->context.c2.push_ifconfig_local, -1, true);
-		  msg (D_MULTI_LOW, "MULTI: primary virtual IP for %s: %s",
-		       multi_instance_string (mi, false, &gc),
-		       print_in_addr_t (mi->context.c2.push_ifconfig_local, 0, &gc));
-		}
-
-	      if (mi->context.c2.push_ifconfig_ipv6_defined)
-		{
-		  multi_learn_in6_addr (m, mi, mi->context.c2.push_ifconfig_ipv6_local, -1, true);
-		  /* TODO: find out where addresses are "unlearned"!! */
-		  msg (D_MULTI_LOW, "MULTI: primary virtual IPv6 for %s: %s",
-		       multi_instance_string (mi, false, &gc),
-		       print_in6_addr (mi->context.c2.push_ifconfig_ipv6_local, 0, &gc));
-		}
-
-	      /* add routes locally, pointing to new client, if
-		 --iroute options have been specified */
-	      multi_add_iroutes (m, mi);
-
-	      /*
-	       * iroutes represent subnets which are "owned" by a particular
-	       * client.  Therefore, do not actually push a route to a client
-	       * if it matches one of the client's iroutes.
-	       */
-	      remove_iroutes_from_push_route_list (&mi->context.options);
-	    }
-	  else if (mi->context.options.iroutes)
-	    {
-	      msg (D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute only works with tun-style tunnels",
-		   multi_instance_string (mi, false, &gc));
-	    }
-
-	  /* set our client's VPN endpoint for status reporting purposes */
-	  mi->reporting_addr = mi->context.c2.push_ifconfig_local;
-	  mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
-
-	  /* set context-level authentication flag */
-	  mi->context.c2.context_auth = CAS_SUCCEEDED;
+	  remove_iroutes_from_push_route_list (&mi->context.options);
 	}
-      else
+      else if (mi->context.options.iroutes)
 	{
-	  /* set context-level authentication flag */
-	  mi->context.c2.context_auth = cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
+	  msg (D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute only works with tun-style tunnels",
+	       multi_instance_string (mi, false, &gc));
 	}
 
-      /* increment number of current authenticated clients */
-      ++m->n_clients;
-      update_mstat_n_clients(m->n_clients);
-      --mi->n_clients_delta;
+      /* set our client's VPN endpoint for status reporting purposes */
+      mi->reporting_addr = mi->context.c2.push_ifconfig_local;
+      mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
+
+      /* set context-level authentication flag */
+      mi->context.c2.context_auth = CAS_SUCCEEDED;
+    }
+  else
+    {
+      /* set context-level authentication flag */
+      mi->context.c2.context_auth = cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
+    }
+
+  /* increment number of current authenticated clients */
+  ++m->n_clients;
+  update_mstat_n_clients(m->n_clients);
+  --mi->n_clients_delta;
 
 #ifdef MANAGEMENT_DEF_AUTH
-      if (management)
-	management_connection_established (management, &mi->context.c2.mda_context, mi->context.c2.es);
+  if (management)
+    management_connection_established (management, &mi->context.c2.mda_context, mi->context.c2.es);
 #endif
 
-      gc_free (&gc);
+  gc_free (&gc);
 }
 
 
-- 
2.1.4


