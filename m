From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Jul 2020 14:16:13 +0200
Message-Id: <20200707121615.15736-3-arne@...1227...>
In-Reply-To: <20200707121615.15736-1-arne@...1227...>
References: <20200707121615.15736-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/3] Simplify multi_connection_established.
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

Instead of having the whole function as

    if (x) { func }

do

   if (!x) func

Due to the whitespace changes in the function body this patch looks
very strange. Ignoring whitespace makes the diff look sane.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 476 ++++++++++++++++++++++----------------------
 1 file changed, 239 insertions(+), 237 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6923d2ce..f1ced9b7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1784,56 +1784,74 @@ multi_client_connect_setenv(struct multi_context *m,
 static void
 multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 {
-    if (tls_authentication_status(mi->context.c2.tls_multi, 0) == TLS_AUTHENTICATION_SUCCEEDED)
+    if (tls_authentication_status(mi->context.c2.tls_multi, 0) != TLS_AUTHENTICATION_SUCCEEDED)
     {
-        struct gc_arena gc = gc_new();
-        unsigned int option_types_found = 0;
+        return;
+    }
 
-        const unsigned int option_permissions_mask =
-            OPT_P_INSTANCE
-            | OPT_P_INHERIT
-            | OPT_P_PUSH
-            | OPT_P_TIMER
-            | OPT_P_CONFIG
-            | OPT_P_ECHO
-            | OPT_P_COMP
-            | OPT_P_SOCKFLAGS;
+    struct gc_arena gc = gc_new();
+    unsigned int option_types_found = 0;
 
-        int cc_succeeded = true; /* client connect script status */
-        int cc_succeeded_count = 0;
+    const unsigned int option_permissions_mask =
+        OPT_P_INSTANCE
+        | OPT_P_INHERIT
+        | OPT_P_PUSH
+        | OPT_P_TIMER
+        | OPT_P_CONFIG
+        | OPT_P_ECHO
+        | OPT_P_COMP
+        | OPT_P_SOCKFLAGS;
 
-        ASSERT(mi->context.c1.tuntap);
+    int cc_succeeded = true;     /* client connect script status */
+    int cc_succeeded_count = 0;
 
-        /* lock down the common name and cert hashes so they can't change during future TLS renegotiations */
-        tls_lock_common_name(mi->context.c2.tls_multi);
-        tls_lock_cert_hash_set(mi->context.c2.tls_multi);
+    ASSERT(mi->context.c1.tuntap);
 
-        /* generate a msg() prefix for this client instance */
-        generate_prefix(mi);
+    /* lock down the common name and cert hashes so they can't change during future TLS renegotiations */
+    tls_lock_common_name(mi->context.c2.tls_multi);
+    tls_lock_cert_hash_set(mi->context.c2.tls_multi);
 
-        /* delete instances of previous clients with same common-name */
-        if (!mi->context.options.duplicate_cn)
-        {
-            multi_delete_dup(m, mi);
-        }
+    /* generate a msg() prefix for this client instance */
+    generate_prefix(mi);
 
-        /* reset pool handle to null */
-        mi->vaddr_handle = -1;
+    /* delete instances of previous clients with same common-name */
+    if (!mi->context.options.duplicate_cn)
+    {
+        multi_delete_dup(m, mi);
+    }
 
-        /*
-         * Try to source a dynamic config file from the
-         * --client-config-dir directory.
-         */
-        if (mi->context.options.client_config_dir)
-        {
-            const char *ccd_file;
+    /* reset pool handle to null */
+    mi->vaddr_handle = -1;
+
+    /*
+     * Try to source a dynamic config file from the
+     * --client-config-dir directory.
+     */
+    if (mi->context.options.client_config_dir)
+    {
+        const char *ccd_file;
 
+        ccd_file = platform_gen_path(mi->context.options.client_config_dir,
+                                     tls_common_name(mi->context.c2.tls_multi,
+                                                     false),
+                                     &gc);
+
+        /* try common-name file */
+        if (platform_test_file(ccd_file))
+        {
+            options_server_import(&mi->context.options,
+                                  ccd_file,
+                                  D_IMPORT_ERRORS|M_OPTERR,
+                                  option_permissions_mask,
+                                  &option_types_found,
+                                  mi->context.c2.es);
+        }
+        else     /* try default file */
+        {
             ccd_file = platform_gen_path(mi->context.options.client_config_dir,
-                                         tls_common_name(mi->context.c2.tls_multi,
-                                                         false),
+                                         CCD_DEFAULT,
                                          &gc);
 
-            /* try common-name file */
             if (platform_test_file(ccd_file))
             {
                 options_server_import(&mi->context.options,
@@ -1843,262 +1861,246 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
                                       &option_types_found,
                                       mi->context.c2.es);
             }
-            else /* try default file */
-            {
-                ccd_file = platform_gen_path(mi->context.options.client_config_dir,
-                                             CCD_DEFAULT,
-                                             &gc);
-
-                if (platform_test_file(ccd_file))
-                {
-                    options_server_import(&mi->context.options,
-                                          ccd_file,
-                                          D_IMPORT_ERRORS|M_OPTERR,
-                                          option_permissions_mask,
-                                          &option_types_found,
-                                          mi->context.c2.es);
-                }
-            }
         }
+    }
 
-        /*
-         * Select a virtual address from either --ifconfig-push in --client-config-dir file
-         * or --ifconfig-pool.
-         */
-        multi_select_virtual_addr(m, mi);
+    /*
+     * Select a virtual address from either --ifconfig-push in --client-config-dir file
+     * or --ifconfig-pool.
+     */
+    multi_select_virtual_addr(m, mi);
 
-        /* do --client-connect setenvs */
-        multi_client_connect_setenv(m, mi);
+    /* do --client-connect setenvs */
+    multi_client_connect_setenv(m, mi);
 
 #ifdef ENABLE_PLUGIN
-        /*
-         * Call client-connect plug-in.
-         */
-
-        /* deprecated callback, use a file for passing back return info */
-        if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
-        {
-            struct argv argv = argv_new();
-            const char *dc_file = platform_create_temp_file(mi->context.options.tmp_dir,
-                                                            "cc", &gc);
-
-            if (!dc_file)
-            {
-                cc_succeeded = false;
-                goto script_depr_failed;
-            }
+    /*
+     * Call client-connect plug-in.
+     */
 
-            argv_printf(&argv, "%s", dc_file);
-            if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
-            {
-                msg(M_WARN, "WARNING: client-connect plugin call failed");
-                cc_succeeded = false;
-            }
-            else
-            {
-                multi_client_connect_post(m, mi, dc_file, option_permissions_mask, &option_types_found);
-                ++cc_succeeded_count;
-            }
+    /* deprecated callback, use a file for passing back return info */
+    if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
+    {
+        struct argv argv = argv_new();
+        const char *dc_file = platform_create_temp_file(mi->context.options.tmp_dir,
+                                                        "cc", &gc);
 
-            if (!platform_unlink(dc_file))
-            {
-                msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
-                    dc_file);
-            }
+        if (!dc_file)
+        {
+            cc_succeeded = false;
+            goto script_depr_failed;
+        }
 
-script_depr_failed:
-            argv_free(&argv);
+        argv_printf(&argv, "%s", dc_file);
+        if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+        {
+            msg(M_WARN, "WARNING: client-connect plugin call failed");
+            cc_succeeded = false;
+        }
+        else
+        {
+            multi_client_connect_post(m, mi, dc_file, option_permissions_mask, &option_types_found);
+            ++cc_succeeded_count;
         }
 
-        /* V2 callback, use a plugin_return struct for passing back return info */
-        if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
+        if (!platform_unlink(dc_file))
         {
-            struct plugin_return pr;
+            msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
+                dc_file);
+        }
 
-            plugin_return_init(&pr);
+script_depr_failed:
+        argv_free(&argv);
+    }
 
-            if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2, NULL, &pr, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
-            {
-                msg(M_WARN, "WARNING: client-connect-v2 plugin call failed");
-                cc_succeeded = false;
-            }
-            else
-            {
-                multi_client_connect_post_plugin(m, mi, &pr, option_permissions_mask, &option_types_found);
-                ++cc_succeeded_count;
-            }
+    /* V2 callback, use a plugin_return struct for passing back return info */
+    if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
+    {
+        struct plugin_return pr;
+
+        plugin_return_init(&pr);
 
-            plugin_return_free(&pr);
+        if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2, NULL, &pr, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+        {
+            msg(M_WARN, "WARNING: client-connect-v2 plugin call failed");
+            cc_succeeded = false;
+        }
+        else
+        {
+            multi_client_connect_post_plugin(m, mi, &pr, option_permissions_mask, &option_types_found);
+            ++cc_succeeded_count;
         }
+
+        plugin_return_free(&pr);
+    }
 #endif /* ifdef ENABLE_PLUGIN */
 
-        /*
-         * Run --client-connect script.
-         */
-        if (mi->context.options.client_connect_script && cc_succeeded)
-        {
-            struct argv argv = argv_new();
-            const char *dc_file = NULL;
+    /*
+     * Run --client-connect script.
+     */
+    if (mi->context.options.client_connect_script && cc_succeeded)
+    {
+        struct argv argv = argv_new();
+        const char *dc_file = NULL;
 
-            setenv_str(mi->context.c2.es, "script_type", "client-connect");
+        setenv_str(mi->context.c2.es, "script_type", "client-connect");
 
-            dc_file = platform_create_temp_file(mi->context.options.tmp_dir,
-                                                "cc", &gc);
-            if (!dc_file)
-            {
-                cc_succeeded = false;
-                goto script_failed;
-            }
+        dc_file = platform_create_temp_file(mi->context.options.tmp_dir,
+                                            "cc", &gc);
+        if (!dc_file)
+        {
+            cc_succeeded = false;
+            goto script_failed;
+        }
 
-            argv_parse_cmd(&argv, mi->context.options.client_connect_script);
-            argv_printf_cat(&argv, "%s", dc_file);
+        argv_parse_cmd(&argv, mi->context.options.client_connect_script);
+        argv_printf_cat(&argv, "%s", dc_file);
 
-            if (openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-connect"))
-            {
-                multi_client_connect_post(m, mi, dc_file, option_permissions_mask, &option_types_found);
-                ++cc_succeeded_count;
-            }
-            else
-            {
-                cc_succeeded = false;
-            }
+        if (openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-connect"))
+        {
+            multi_client_connect_post(m, mi, dc_file, option_permissions_mask, &option_types_found);
+            ++cc_succeeded_count;
+        }
+        else
+        {
+            cc_succeeded = false;
+        }
 
-            if (!platform_unlink(dc_file))
-            {
-                msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
-                    dc_file);
-            }
+        if (!platform_unlink(dc_file))
+        {
+            msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
+                dc_file);
+        }
 
 script_failed:
-            argv_free(&argv);
-        }
+        argv_free(&argv);
+    }
 
+    /*
+     * Check for client-connect script left by management interface client
+     */
+#ifdef MANAGEMENT_DEF_AUTH
+    if (cc_succeeded && mi->cc_config)
+    {
+        multi_client_connect_mda(m, mi, option_permissions_mask, &option_types_found);
+        ++cc_succeeded_count;
+    }
+#endif
+
+    /*
+     * Check for "disable" directive in client-config-dir file
+     * or config file generated by --client-connect script.
+     */
+    if (mi->context.options.disable)
+    {
+        msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to 'disable' directive");
+        cc_succeeded = false;
+        cc_succeeded_count = 0;
+    }
+
+    if (cc_succeeded)
+    {
         /*
-         * Check for client-connect script left by management interface client
+         * Process sourced options.
          */
-#ifdef MANAGEMENT_DEF_AUTH
-        if (cc_succeeded && mi->cc_config)
+        do_deferred_options(&mi->context, option_types_found);
+
+        /*
+         * make sure we got ifconfig settings from somewhere
+         */
+        if (!mi->context.c2.push_ifconfig_defined)
         {
-            multi_client_connect_mda(m, mi, option_permissions_mask, &option_types_found);
-            ++cc_succeeded_count;
+            msg(D_MULTI_ERRORS, "MULTI: no dynamic or static remote --ifconfig address is available for %s",
+                multi_instance_string(mi, false, &gc));
         }
-#endif
 
         /*
-         * Check for "disable" directive in client-config-dir file
-         * or config file generated by --client-connect script.
+         * make sure that ifconfig settings comply with constraints
          */
-        if (mi->context.options.disable)
+        if (!ifconfig_push_constraint_satisfied(&mi->context))
         {
-            msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to 'disable' directive");
-            cc_succeeded = false;
-            cc_succeeded_count = 0;
+            /* JYFIXME -- this should cause the connection to fail */
+            msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s) violates tunnel network/netmask constraint (%s/%s)",
+                multi_instance_string(mi, false, &gc),
+                print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc),
+                print_in_addr_t(mi->context.options.push_ifconfig_constraint_network, 0, &gc),
+                print_in_addr_t(mi->context.options.push_ifconfig_constraint_netmask, 0, &gc));
         }
 
-        if (cc_succeeded)
+        /*
+         * For routed tunnels, set up internal route to endpoint
+         * plus add all iroute routes.
+         */
+        if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
         {
-            /*
-             * Process sourced options.
-             */
-            do_deferred_options(&mi->context, option_types_found);
-
-            /*
-             * make sure we got ifconfig settings from somewhere
-             */
-            if (!mi->context.c2.push_ifconfig_defined)
+            if (mi->context.c2.push_ifconfig_defined)
             {
-                msg(D_MULTI_ERRORS, "MULTI: no dynamic or static remote --ifconfig address is available for %s",
-                    multi_instance_string(mi, false, &gc));
+                multi_learn_in_addr_t(m, mi, mi->context.c2.push_ifconfig_local, -1, true);
+                msg(D_MULTI_LOW, "MULTI: primary virtual IP for %s: %s",
+                    multi_instance_string(mi, false, &gc),
+                    print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc));
             }
 
-            /*
-             * make sure that ifconfig settings comply with constraints
-             */
-            if (!ifconfig_push_constraint_satisfied(&mi->context))
+            if (mi->context.c2.push_ifconfig_ipv6_defined)
             {
-                /* JYFIXME -- this should cause the connection to fail */
-                msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s) violates tunnel network/netmask constraint (%s/%s)",
+                multi_learn_in6_addr(m, mi, mi->context.c2.push_ifconfig_ipv6_local, -1, true);
+                /* TODO: find out where addresses are "unlearned"!! */
+                msg(D_MULTI_LOW, "MULTI: primary virtual IPv6 for %s: %s",
                     multi_instance_string(mi, false, &gc),
-                    print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc),
-                    print_in_addr_t(mi->context.options.push_ifconfig_constraint_network, 0, &gc),
-                    print_in_addr_t(mi->context.options.push_ifconfig_constraint_netmask, 0, &gc));
+                    print_in6_addr(mi->context.c2.push_ifconfig_ipv6_local, 0, &gc));
             }
 
+            /* add routes locally, pointing to new client, if
+             * --iroute options have been specified */
+            multi_add_iroutes(m, mi);
+
             /*
-             * For routed tunnels, set up internal route to endpoint
-             * plus add all iroute routes.
+             * iroutes represent subnets which are "owned" by a particular
+             * client.  Therefore, do not actually push a route to a client
+             * if it matches one of the client's iroutes.
              */
-            if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
-            {
-                if (mi->context.c2.push_ifconfig_defined)
-                {
-                    multi_learn_in_addr_t(m, mi, mi->context.c2.push_ifconfig_local, -1, true);
-                    msg(D_MULTI_LOW, "MULTI: primary virtual IP for %s: %s",
-                        multi_instance_string(mi, false, &gc),
-                        print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc));
-                }
-
-                if (mi->context.c2.push_ifconfig_ipv6_defined)
-                {
-                    multi_learn_in6_addr(m, mi, mi->context.c2.push_ifconfig_ipv6_local, -1, true);
-                    /* TODO: find out where addresses are "unlearned"!! */
-                    msg(D_MULTI_LOW, "MULTI: primary virtual IPv6 for %s: %s",
-                        multi_instance_string(mi, false, &gc),
-                        print_in6_addr(mi->context.c2.push_ifconfig_ipv6_local, 0, &gc));
-                }
-
-                /* add routes locally, pointing to new client, if
-                 * --iroute options have been specified */
-                multi_add_iroutes(m, mi);
-
-                /*
-                 * iroutes represent subnets which are "owned" by a particular
-                 * client.  Therefore, do not actually push a route to a client
-                 * if it matches one of the client's iroutes.
-                 */
-                remove_iroutes_from_push_route_list(&mi->context.options);
-            }
-            else if (mi->context.options.iroutes)
-            {
-                msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute only works with tun-style tunnels",
-                    multi_instance_string(mi, false, &gc));
-            }
+            remove_iroutes_from_push_route_list(&mi->context.options);
+        }
+        else if (mi->context.options.iroutes)
+        {
+            msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute only works with tun-style tunnels",
+                multi_instance_string(mi, false, &gc));
+        }
 
-            /* set our client's VPN endpoint for status reporting purposes */
-            mi->reporting_addr = mi->context.c2.push_ifconfig_local;
-            mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
+        /* set our client's VPN endpoint for status reporting purposes */
+        mi->reporting_addr = mi->context.c2.push_ifconfig_local;
+        mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
 
-            /* set context-level authentication flag */
-            mi->context.c2.context_auth = CAS_SUCCEEDED;
+        /* set context-level authentication flag */
+        mi->context.c2.context_auth = CAS_SUCCEEDED;
 
 #ifdef ENABLE_ASYNC_PUSH
-            /* authentication complete, send push reply */
-            if (mi->context.c2.push_request_received)
-            {
-                process_incoming_push_request(&mi->context);
-            }
-#endif
-        }
-        else
+        /* authentication complete, send push reply */
+        if (mi->context.c2.push_request_received)
         {
-            /* set context-level authentication flag */
-            mi->context.c2.context_auth = cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
+            process_incoming_push_request(&mi->context);
         }
+#endif
+    }
+    else
+    {
+        /* set context-level authentication flag */
+        mi->context.c2.context_auth = cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
+    }
 
-        /* increment number of current authenticated clients */
-        ++m->n_clients;
-        update_mstat_n_clients(m->n_clients);
-        --mi->n_clients_delta;
+    /* increment number of current authenticated clients */
+    ++m->n_clients;
+    update_mstat_n_clients(m->n_clients);
+    --mi->n_clients_delta;
 
 #ifdef MANAGEMENT_DEF_AUTH
-        if (management)
-        {
-            management_connection_established(management, &mi->context.c2.mda_context, mi->context.c2.es);
-        }
+    if (management)
+    {
+        management_connection_established(management, &mi->context.c2.mda_context, mi->context.c2.es);
+    }
 #endif
 
-        gc_free(&gc);
-    }
+    gc_free(&gc);
 }
 
 #ifdef ENABLE_ASYNC_PUSH
-- 
2.26.2


