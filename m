References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-2-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <edfc8030-5fff-0d31-987c-e9ac21055e4b@...277...>
Date: Mon, 13 Jul 2020 13:48:05 +0100
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-2-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v5 02/14] client-connect: Split
 multi_connection_established into separate functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

spelling, 1x grammer:

On 11/07/2020 10:36, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
> 
> This patch splits up the multi_connection_established() function.  Each new
> helper function does a specific job.  Functions that do a similar job receive a
> similar calling interface.
> 
> The patch tries not to reindent code, so that the real changes are as clearly

Technically: reindent -> re-indent
(that is how I would spell it)


> visible as possible.  (A follow-up patch will only do indentation changes.)
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> 
> PATCH v3: Since the code has changed enough from the time the original patch
> to the current master, the splitting has been redone from the current code.

> Also some style and minor code changes have been added doing this patch.
> This elimininates and the big reformatting done before eliminates the follow

elimininates -> eliminates

The grammer:

This elimininates >and< the big reformatting ..

I don't know how to re-word this paragraph to make sense.


> up patch with indentation changes.
> 
> The original patch already replaces some instances of option_permission_mask
> with CLIENT_CONNECT_OPT_MASK. The V3 version does this more consistenly.

consistenly -> consistently


I found no further issues with the patch.

> 
> Patch v4: Move config -> mi->cc_config into its own commit
> 
> Patch v5: Clean up some minor issues, add one missing check on
> temporary file deletion, rebase on latest master.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/multi.c | 588 ++++++++++++++++++++++++++------------------
>   src/openvpn/multi.h |   4 +-
>   2 files changed, 350 insertions(+), 242 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index a2af071a..3c4ceeb5 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1638,7 +1638,6 @@ static void
>   multi_client_connect_post(struct multi_context *m,
>                             struct multi_instance *mi,
>                             const char *dc_file,
> -                          unsigned int option_permissions_mask,
>                             unsigned int *option_types_found)
>   {
>       /* Did script generate a dynamic config file? */
> @@ -1647,7 +1646,7 @@ multi_client_connect_post(struct multi_context *m,
>           options_server_import(&mi->context.options,
>                                 dc_file,
>                                 D_IMPORT_ERRORS|M_OPTERR,
> -                              option_permissions_mask,
> +                              CLIENT_CONNECT_OPT_MASK,
>                                 option_types_found,
>                                 mi->context.c2.es);
>   
> @@ -1671,7 +1670,6 @@ static void
>   multi_client_connect_post_plugin(struct multi_context *m,
>                                    struct multi_instance *mi,
>                                    const struct plugin_return *pr,
> -                                 unsigned int option_permissions_mask,
>                                    unsigned int *option_types_found)
>   {
>       struct plugin_return config;
> @@ -1689,7 +1687,7 @@ multi_client_connect_post_plugin(struct multi_context *m,
>                   options_string_import(&mi->context.options,
>                                         config.list[i]->value,
>                                         D_IMPORT_ERRORS|M_OPTERR,
> -                                      option_permissions_mask,
> +                                      CLIENT_CONNECT_OPT_MASK,
>                                         option_types_found,
>                                         mi->context.c2.es);
>               }
> @@ -1716,7 +1714,6 @@ multi_client_connect_post_plugin(struct multi_context *m,
>   static void
>   multi_client_connect_mda(struct multi_context *m,
>                            struct multi_instance *mi,
> -                         unsigned int option_permissions_mask,
>                            unsigned int *option_types_found)
>   {
>       if (mi->cc_config)
> @@ -1729,7 +1726,7 @@ multi_client_connect_mda(struct multi_context *m,
>               options_string_import(&mi->context.options,
>                                     opt,
>                                     D_IMPORT_ERRORS|M_OPTERR,
> -                                  option_permissions_mask,
> +                                  CLIENT_CONNECT_OPT_MASK,
>                                     option_types_found,
>                                     mi->context.c2.es);
>           }
> @@ -1843,160 +1840,46 @@ multi_client_set_protocol_options(struct context *c)
>       }
>   }
>   
> -/**
> - * Generates the data channel keys
> - */
> -static bool
> -multi_client_generate_tls_keys(struct context *c)
> -{
> -    struct frame *frame_fragment = NULL;
> -#ifdef ENABLE_FRAGMENT
> -    if (c->options.ce.fragment)
> -    {
> -        frame_fragment = &c->c2.frame_fragment;
> -    }
> -#endif
> -    struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
> -    if (!tls_session_update_crypto_params(session, &c->options,
> -                                          &c->c2.frame, frame_fragment))
> -    {
> -        msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
> -        register_signal(c, SIGUSR1, "process-push-msg-failed");
> -        return false;
> -    }
> -
> -    return true;
> -}
> -
> -/*
> - * Called as soon as the SSL/TLS connection authenticates.
> - *
> - * Instance-specific directives to be processed:
> - *
> - *   iroute start-ip end-ip
> - *   ifconfig-push local remote-netmask
> - *   push
> - */
>   static void
> -multi_connection_established(struct multi_context *m, struct multi_instance *mi)
> +multi_client_connect_call_plugin_v1(struct multi_context *m,
> +                                    struct multi_instance *mi,
> +                                    unsigned int *option_types_found,
> +                                    int *cc_succeeded,
> +                                    int *cc_succeeded_count)
>   {
> -    if (tls_authentication_status(mi->context.c2.tls_multi, 0) != TLS_AUTHENTICATION_SUCCEEDED)
> -    {
> -        return;
> -    }
> -
> -    struct gc_arena gc = gc_new();
> -    unsigned int option_types_found = 0;
> -
> -    const unsigned int option_permissions_mask =
> -        OPT_P_INSTANCE
> -        | OPT_P_INHERIT
> -        | OPT_P_PUSH
> -        | OPT_P_TIMER
> -        | OPT_P_CONFIG
> -        | OPT_P_ECHO
> -        | OPT_P_COMP
> -        | OPT_P_SOCKFLAGS;
> -
> -    int cc_succeeded = true;     /* client connect script status */
> -    int cc_succeeded_count = 0;
> -
> -    ASSERT(mi->context.c1.tuntap);
> -
> -    /* lock down the common name and cert hashes so they can't change during future TLS renegotiations */
> -    tls_lock_common_name(mi->context.c2.tls_multi);
> -    tls_lock_cert_hash_set(mi->context.c2.tls_multi);
> -
> -    /* generate a msg() prefix for this client instance */
> -    generate_prefix(mi);
> -
> -    /* delete instances of previous clients with same common-name */
> -    if (!mi->context.options.duplicate_cn)
> -    {
> -        multi_delete_dup(m, mi);
> -    }
> -
> -    /* reset pool handle to null */
> -    mi->vaddr_handle = -1;
> -
> -    /*
> -     * Try to source a dynamic config file from the
> -     * --client-config-dir directory.
> -     */
> -    if (mi->context.options.client_config_dir)
> -    {
> -        const char *ccd_file;
> -
> -        ccd_file = platform_gen_path(mi->context.options.client_config_dir,
> -                                     tls_common_name(mi->context.c2.tls_multi,
> -                                                     false),
> -                                     &gc);
> -
> -        /* try common-name file */
> -        if (platform_test_file(ccd_file))
> -        {
> -            options_server_import(&mi->context.options,
> -                                  ccd_file,
> -                                  D_IMPORT_ERRORS|M_OPTERR,
> -                                  option_permissions_mask,
> -                                  &option_types_found,
> -                                  mi->context.c2.es);
> -        }
> -        else     /* try default file */
> -        {
> -            ccd_file = platform_gen_path(mi->context.options.client_config_dir,
> -                                         CCD_DEFAULT,
> -                                         &gc);
> -
> -            if (platform_test_file(ccd_file))
> -            {
> -                options_server_import(&mi->context.options,
> -                                      ccd_file,
> -                                      D_IMPORT_ERRORS|M_OPTERR,
> -                                      option_permissions_mask,
> -                                      &option_types_found,
> -                                      mi->context.c2.es);
> -            }
> -        }
> -    }
> -
> -    /*
> -     * Select a virtual address from either --ifconfig-push in --client-config-dir file
> -     * or --ifconfig-pool.
> -     */
> -    multi_select_virtual_addr(m, mi);
> -
> -    /* do --client-connect setenvs */
> -    multi_client_connect_setenv(m, mi);
> -
>   #ifdef ENABLE_PLUGIN
> -    /*
> -     * Call client-connect plug-in.
> -     */
> +    ASSERT(m);
> +    ASSERT(mi);
> +    ASSERT(option_types_found);
> +    ASSERT(cc_succeeded);
> +    ASSERT(cc_succeeded_count);
>   
>       /* deprecated callback, use a file for passing back return info */
>       if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
>       {
>           struct argv argv = argv_new();
> -        const char *dc_file = platform_create_temp_file(mi->context.options.tmp_dir,
> -                                                        "cc", &gc);
> +        struct gc_arena gc = gc_new();
> +        const char *dc_file =
> +            platform_create_temp_file(mi->context.options.tmp_dir, "cc", &gc);
>   
>           if (!dc_file)
>           {
>               cc_succeeded = false;
> -            goto script_depr_failed;
> +            goto cleanup;
>           }
>   
>           argv_printf(&argv, "%s", dc_file);
> -        if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
> +        if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT,
> +                        &argv, NULL, mi->context.c2.es)
> +            != OPENVPN_PLUGIN_FUNC_SUCCESS)
>           {
>               msg(M_WARN, "WARNING: client-connect plugin call failed");
> -            cc_succeeded = false;
> +            *cc_succeeded = false;
>           }
>           else
>           {
> -            multi_client_connect_post(m, mi, dc_file, option_permissions_mask, &option_types_found);
> -            ++cc_succeeded_count;
> +            multi_client_connect_post(m, mi, dc_file, option_types_found);
> +            (*cc_succeeded_count)++;
>           }
>   
>           if (!platform_unlink(dc_file))
> @@ -2005,9 +1888,26 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>                   dc_file);
>           }
>   
> -script_depr_failed:
> +cleanup:
>           argv_free(&argv);
> +        gc_free(&gc);
>       }
> +#endif /* ifdef ENABLE_PLUGIN */
> +}
> +
> +static void
> +multi_client_connect_call_plugin_v2(struct multi_context *m,
> +                                    struct multi_instance *mi,
> +                                    unsigned int *option_types_found,
> +                                    int *cc_succeeded,
> +                                    int *cc_succeeded_count)
> +{
> +#ifdef ENABLE_PLUGIN
> +    ASSERT(m);
> +    ASSERT(mi);
> +    ASSERT(option_types_found);
> +    ASSERT(cc_succeeded);
> +    ASSERT(cc_succeeded_count);
>   
>       /* V2 callback, use a plugin_return struct for passing back return info */
>       if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
> @@ -2016,27 +1916,42 @@ script_depr_failed:
>   
>           plugin_return_init(&pr);
>   
> -        if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2, NULL, &pr, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
> +        if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2,
> +                        NULL, &pr, mi->context.c2.es)
> +            != OPENVPN_PLUGIN_FUNC_SUCCESS)
>           {
>               msg(M_WARN, "WARNING: client-connect-v2 plugin call failed");
> -            cc_succeeded = false;
> +            *cc_succeeded = false;
>           }
>           else
>           {
> -            multi_client_connect_post_plugin(m, mi, &pr, option_permissions_mask, &option_types_found);
> -            ++cc_succeeded_count;
> +            multi_client_connect_post_plugin(m, mi, &pr, option_types_found);
> +            (*cc_succeeded_count)++;
>           }
>   
>           plugin_return_free(&pr);
>       }
>   #endif /* ifdef ENABLE_PLUGIN */
> +}
>   
> -    /*
> -     * Run --client-connect script.
> -     */
> -    if (mi->context.options.client_connect_script && cc_succeeded)
> +
> +
> +/**
> + * Runs the --client-connect script if one is defined.
> + */
> +static void
> +multi_client_connect_call_script(struct multi_context *m,
> +                                 struct multi_instance *mi,
> +                                 unsigned int *option_types_found,
> +                                 int *cc_succeeded,
> +                                 int *cc_succeeded_count)
> +{
> +    ASSERT(m);
> +    ASSERT(mi);
> +    if (mi->context.options.client_connect_script)
>       {
>           struct argv argv = argv_new();
> +        struct gc_arena gc = gc_new();
>           const char *dc_file = NULL;
>   
>           setenv_str(mi->context.c2.es, "script_type", "client-connect");
> @@ -2045,8 +1960,8 @@ script_depr_failed:
>                                               "cc", &gc);
>           if (!dc_file)
>           {
> -            cc_succeeded = false;
> -            goto script_failed;
> +            *cc_succeeded = false;
> +            goto cleanup;
>           }
>   
>           argv_parse_cmd(&argv, mi->context.options.client_connect_script);
> @@ -2054,12 +1969,12 @@ script_depr_failed:
>   
>           if (openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-connect"))
>           {
> -            multi_client_connect_post(m, mi, dc_file, option_permissions_mask, &option_types_found);
> -            ++cc_succeeded_count;
> +            multi_client_connect_post(m, mi, dc_file, option_types_found);
> +            (*cc_succeeded_count)++;
>           }
>           else
>           {
> -            cc_succeeded = false;
> +            *cc_succeeded = false;
>           }
>   
>           if (!platform_unlink(dc_file))
> @@ -2067,130 +1982,322 @@ script_depr_failed:
>               msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
>                   dc_file);
>           }
> -
> -script_failed:
> +cleanup:
>           argv_free(&argv);
> +        gc_free(&gc);
>       }
> +}
>   
> -    /*
> -     * Check for client-connect script left by management interface client
> -     */
> -#ifdef MANAGEMENT_DEF_AUTH
> -    if (cc_succeeded && mi->cc_config)
> +/**
> + * Generates the data channel keys
> + */
> +static bool
> +multi_client_generate_tls_keys(struct context *c)
> +{
> +  struct frame *frame_fragment = NULL;
> +#ifdef ENABLE_FRAGMENT
> +  if (c->options.ce.fragment)
>       {
> -        multi_client_connect_mda(m, mi, option_permissions_mask, &option_types_found);
> -        ++cc_succeeded_count;
> +      frame_fragment = &c->c2.frame_fragment;
>       }
>   #endif
> +  struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
> +  if (!tls_session_update_crypto_params(session, &c->options,
> +                                        &c->c2.frame, frame_fragment))
> +    {
> +      msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
> +      register_signal(c, SIGUSR1, "process-push-msg-failed");
> +      return false;
> +    }
>   
> +  return true;
> +}
> +
> +static void
> +multi_client_connect_late_setup(struct multi_context *m,
> +                                struct multi_instance *mi,
> +                                const unsigned int option_types_found)
> +{
> +    ASSERT(m);
> +    ASSERT(mi);
> +
> +    struct gc_arena gc = gc_new();
>       /*
> -     * Check for "disable" directive in client-config-dir file
> -     * or config file generated by --client-connect script.
> +     * Process sourced options.
>        */
> -    if (mi->context.options.disable)
> +    do_deferred_options(&mi->context, option_types_found);
> +
> +    /*
> +     * make sure we got ifconfig settings from somewhere
> +     */
> +    if (!mi->context.c2.push_ifconfig_defined)
>       {
> -        msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to 'disable' directive");
> -        cc_succeeded = false;
> -        cc_succeeded_count = 0;
> +        msg(D_MULTI_ERRORS, "MULTI: no dynamic or static remote"
> +            "--ifconfig address is available for %s",
> +            multi_instance_string(mi, false, &gc));
>       }
>   
> -    if (cc_succeeded)
> +    /*
> +     * make sure that ifconfig settings comply with constraints
> +     */
> +    if (!ifconfig_push_constraint_satisfied(&mi->context))
>       {
> -        /*
> -         * Process sourced options.
> -         */
> -        do_deferred_options(&mi->context, option_types_found);
> +        const char *ifconfig_constraint_network =
> +            print_in_addr_t(mi->context.options.push_ifconfig_constraint_network, 0, &gc);
> +        const char *ifconfig_constraint_netmask =
> +            print_in_addr_t(mi->context.options.push_ifconfig_constraint_netmask, 0, &gc);
>   
> -        /*
> -         * make sure we got ifconfig settings from somewhere
> -         */
> -        if (!mi->context.c2.push_ifconfig_defined)
> +        /* JYFIXME -- this should cause the connection to fail */
> +        msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s)"
> +            "violates tunnel network/netmask constraint (%s/%s)",
> +            multi_instance_string(mi, false, &gc),
> +            print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc),
> +            ifconfig_constraint_network, ifconfig_constraint_netmask);
> +    }
> +
> +    /*
> +     * For routed tunnels, set up internal route to endpoint
> +     * plus add all iroute routes.
> +     */
> +    if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
> +    {
> +        if (mi->context.c2.push_ifconfig_defined)
>           {
> -            msg(D_MULTI_ERRORS, "MULTI: no dynamic or static remote --ifconfig address is available for %s",
> -                multi_instance_string(mi, false, &gc));
> +            multi_learn_in_addr_t(m, mi,
> +                                  mi->context.c2.push_ifconfig_local,
> +                                  -1, true);
> +            msg(D_MULTI_LOW, "MULTI: primary virtual IP for %s: %s",
> +                multi_instance_string(mi, false, &gc),
> +                print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc));
>           }
>   
> -        /*
> -         * make sure that ifconfig settings comply with constraints
> -         */
> -        if (!ifconfig_push_constraint_satisfied(&mi->context))
> +        if (mi->context.c2.push_ifconfig_ipv6_defined)
>           {
> -            /* JYFIXME -- this should cause the connection to fail */
> -            msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s) violates tunnel network/netmask constraint (%s/%s)",
> +            multi_learn_in6_addr(m, mi,
> +                                 mi->context.c2.push_ifconfig_ipv6_local,
> +                                 -1, true);
> +            /* TODO: find out where addresses are "unlearned"!! */
> +            const char *ifconfig_local_ipv6 =
> +                print_in6_addr(mi->context.c2.push_ifconfig_ipv6_local, 0, &gc);
> +            msg(D_MULTI_LOW, "MULTI: primary virtual IPv6 for %s: %s",
>                   multi_instance_string(mi, false, &gc),
> -                print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc),
> -                print_in_addr_t(mi->context.options.push_ifconfig_constraint_network, 0, &gc),
> -                print_in_addr_t(mi->context.options.push_ifconfig_constraint_netmask, 0, &gc));
> +                ifconfig_local_ipv6);
>           }
>   
> +        /* add routes locally, pointing to new client, if
> +         * --iroute options have been specified */
> +        multi_add_iroutes(m, mi);
> +
>           /*
> -         * For routed tunnels, set up internal route to endpoint
> -         * plus add all iroute routes.
> +         * iroutes represent subnets which are "owned" by a particular
> +         * client.  Therefore, do not actually push a route to a client
> +         * if it matches one of the client's iroutes.
>            */
> -        if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
> -        {
> -            if (mi->context.c2.push_ifconfig_defined)
> -            {
> -                multi_learn_in_addr_t(m, mi, mi->context.c2.push_ifconfig_local, -1, true);
> -                msg(D_MULTI_LOW, "MULTI: primary virtual IP for %s: %s",
> -                    multi_instance_string(mi, false, &gc),
> -                    print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc));
> -            }
> +        remove_iroutes_from_push_route_list(&mi->context.options);
> +    }
> +    else if (mi->context.options.iroutes)
> +    {
> +        msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute"
> +            "only works with tun-style tunnels",
> +            multi_instance_string(mi, false, &gc));
> +    }
>   
> -            if (mi->context.c2.push_ifconfig_ipv6_defined)
> -            {
> -                multi_learn_in6_addr(m, mi, mi->context.c2.push_ifconfig_ipv6_local, -1, true);
> -                /* TODO: find out where addresses are "unlearned"!! */
> -                msg(D_MULTI_LOW, "MULTI: primary virtual IPv6 for %s: %s",
> -                    multi_instance_string(mi, false, &gc),
> -                    print_in6_addr(mi->context.c2.push_ifconfig_ipv6_local, 0, &gc));
> -            }
> +    /* set our client's VPN endpoint for status reporting purposes */
> +    mi->reporting_addr = mi->context.c2.push_ifconfig_local;
> +    mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
>   
> -            /* add routes locally, pointing to new client, if
> -             * --iroute options have been specified */
> -            multi_add_iroutes(m, mi);
> +    /* set context-level authentication flag */
> +    mi->context.c2.context_auth = CAS_SUCCEEDED;
>   
> -            /*
> -             * iroutes represent subnets which are "owned" by a particular
> -             * client.  Therefore, do not actually push a route to a client
> -             * if it matches one of the client's iroutes.
> -             */
> -            remove_iroutes_from_push_route_list(&mi->context.options);
> -        }
> -        else if (mi->context.options.iroutes)
> -        {
> -            msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute only works with tun-style tunnels",
> -                multi_instance_string(mi, false, &gc));
> -        }
> +    /* authentication complete, calculate dynamic client specific options */
> +    multi_client_set_protocol_options(&mi->context);
> +
> +    /* Generate data channel keys */
> +    if (!multi_client_generate_tls_keys(&mi->context))
> +    {
> +        mi->context.c2.context_auth = CAS_FAILED;
> +    }
>   
> -        /* set our client's VPN endpoint for status reporting purposes */
> -        mi->reporting_addr = mi->context.c2.push_ifconfig_local;
> -        mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
> +    /* send push reply if ready */
> +    if (mi->context.c2.push_request_received)
> +    {
> +        process_incoming_push_request(&mi->context);
> +    }
>   
> -        /* set context-level authentication flag */
> -        mi->context.c2.context_auth = CAS_SUCCEEDED;
> +    gc_free(&gc);
> +}
> +
> +static void
> +multi_client_connect_early_setup(struct multi_context *m,
> +                                 struct multi_instance *mi)
> +{
> +    ASSERT(mi->context.c1.tuntap);
> +    /*
> +     * lock down the common name and cert hashes so they can't change
> +     * during future TLS renegotiations
> +     */
> +    tls_lock_common_name(mi->context.c2.tls_multi);
> +    tls_lock_cert_hash_set(mi->context.c2.tls_multi);
> +
> +    /* generate a msg() prefix for this client instance */
> +    generate_prefix(mi);
> +
> +    /* delete instances of previous clients with same common-name */
> +    if (!mi->context.options.duplicate_cn)
> +    {
> +        multi_delete_dup(m, mi);
> +    }
> +
> +    /* reset pool handle to null */
> +    mi->vaddr_handle = -1;
> +}
> +
> +/**
> + * Try to source a dynamic config file from the
> + * --client-config-dir directory.
> + */
> +static void
> +multi_client_connect_source_ccd(struct multi_context *m,
> +                                struct multi_instance *mi,
> +                                unsigned int *option_types_found)
> +{
> +    if (mi->context.options.client_config_dir)
> +    {
> +        struct gc_arena gc = gc_new();
> +        const char *ccd_file;
>   
> -        /* authentication complete, calculate dynamic client specific options */
> -        multi_client_set_protocol_options(&mi->context);
> +        ccd_file = platform_gen_path(mi->context.options.client_config_dir,
> +                                     tls_common_name(mi->context.c2.tls_multi,
> +                                                     false),
> +                                     &gc);
>   
> -        /* Generate data channel keys */
> -        if (!multi_client_generate_tls_keys(&mi->context))
> +        /* try common-name file */
> +        if (platform_test_file(ccd_file))
>           {
> -            mi->context.c2.context_auth = CAS_FAILED;
> +            options_server_import(&mi->context.options,
> +                                  ccd_file,
> +                                  D_IMPORT_ERRORS|M_OPTERR,
> +                                  CLIENT_CONNECT_OPT_MASK,
> +                                  option_types_found,
> +                                  mi->context.c2.es);
>           }
> -
> -        /* send push reply if ready */
> -        if (mi->context.c2.push_request_received)
> +        else /* try default file */
>           {
> -            process_incoming_push_request(&mi->context);
> +            ccd_file = platform_gen_path(mi->context.options.client_config_dir,
> +                                         CCD_DEFAULT,
> +                                         &gc);
> +
> +            if (platform_test_file(ccd_file))
> +            {
> +                options_server_import(&mi->context.options,
> +                                      ccd_file,
> +                                      D_IMPORT_ERRORS|M_OPTERR,
> +                                      CLIENT_CONNECT_OPT_MASK,
> +                                      option_types_found,
> +                                      mi->context.c2.es);
> +            }
>           }
> +        gc_free(&gc);
> +    }
> +}
> +
> +/*
> + * Called as soon as the SSL/TLS connection is authenticated.
> + *
> + * Will collect the client specific configuration from the different
> + * sources like ccd files, connect plugins and management interface.
> + *
> + * This method starts with cas_context CAS_PENDING and will move the
> + * state machine to either CAS_SUCCEEDED on success or
> + * CAS_FAILED/CAS_PARTIAL on failure.
> + *
> + * Instance-specific directives to be processed (CLIENT_CONNECT_OPT_MASK)
> + * include:
> + *
> + *   iroute start-ip end-ip
> + *   ifconfig-push local remote-netmask
> + *   push
> + *
> + *
> + */
> +static void
> +multi_connection_established(struct multi_context *m, struct multi_instance *mi)
> +{
> +    if (tls_authentication_status(mi->context.c2.tls_multi, 0)
> +        != TLS_AUTHENTICATION_SUCCEEDED)
> +    {
> +        return;
> +    }
> +    unsigned int option_types_found = 0;
> +
> +    int cc_succeeded = true;     /* client connect script status */
> +    int cc_succeeded_count = 0;
> +
> +    multi_client_connect_early_setup(m, mi);
> +
> +    multi_client_connect_source_ccd(m, mi, &option_types_found);
> +
> +    /*
> +     * Select a virtual address from either --ifconfig-push in
> +     * --client-config-dir file or --ifconfig-pool.
> +     */
> +    multi_select_virtual_addr(m, mi);
> +
> +    /* do --client-connect setenvs */
> +    multi_client_connect_setenv(m, mi);
> +
> +    multi_client_connect_call_plugin_v1(m, mi, &option_types_found,
> +                                        &cc_succeeded,
> +                                        &cc_succeeded_count);
> +
> +    multi_client_connect_call_plugin_v2(m, mi, &option_types_found,
> +                                        &cc_succeeded,
> +                                        &cc_succeeded_count);
> +
> +    /*
> +     * Check for client-connect script left by management interface client
> +     */
> +    if (cc_succeeded)
> +    {
> +        multi_client_connect_call_script(m, mi, &option_types_found,
> +                                         &cc_succeeded,
> +                                         &cc_succeeded_count);
> +    }
> +
> +#ifdef MANAGEMENT_DEF_AUTH
> +    if (cc_succeeded && mi->cc_config)
> +    {
> +        multi_client_connect_mda(m, mi, &option_types_found);
> +        ++cc_succeeded_count;
> +    }
> +#endif
> +
> +    /*
> +     * Check for "disable" directive in client-config-dir file
> +     * or config file generated by --client-connect script.
> +     */
> +    if (mi->context.options.disable)
> +    {
> +        msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to "
> +            " 'disable' directive");
> +        cc_succeeded = false;
> +        cc_succeeded_count = 0;
> +    }
> +
> +
> +
> +    if (cc_succeeded)
> +    {
> +        multi_client_connect_late_setup(m, mi, option_types_found);
>       }
>       else
>       {
>           /* set context-level authentication flag */
> -        mi->context.c2.context_auth = cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
> +        mi->context.c2.context_auth =
> +            cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
>       }
>   
> +
>       /* increment number of current authenticated clients */
>       ++m->n_clients;
>       update_mstat_n_clients(m->n_clients);
> @@ -2199,11 +2306,10 @@ script_failed:
>   #ifdef MANAGEMENT_DEF_AUTH
>       if (management)
>       {
> -        management_connection_established(management, &mi->context.c2.mda_context, mi->context.c2.es);
> +        management_connection_established(management,
> +                                          &mi->context.c2.mda_context, mi->context.c2.es);
>       }
>   #endif
> -
> -    gc_free(&gc);
>   }
>   
>   #ifdef ENABLE_ASYNC_PUSH
> diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
> index 8c9c4609..c51107f4 100644
> --- a/src/openvpn/multi.h
> +++ b/src/openvpn/multi.h
> @@ -623,7 +623,9 @@ multi_process_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags
>       return ret;
>   }
>   
> -
> +#define CLIENT_CONNECT_OPT_MASK (OPT_P_INSTANCE | OPT_P_INHERIT   \
> +                                 |OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG   \
> +                                 |OPT_P_ECHO | OPT_P_COMP | OPT_P_SOCKFLAGS)
>   
>   static inline bool
>   multi_process_outgoing_link_dowork(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
> 

