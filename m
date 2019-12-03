References: <20181121101019.1801-1-arne@...1227...>
 <20181121101019.1801-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0d26a044-711f-ed55-0755-cbea2ab9da54@...2181...>
Date: Tue, 3 Dec 2019 14:34:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181121101019.1801-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4 01/13] client-connect: Split
 multi_connection_established into separate functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 21/11/2018 11:10, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
> 
> This patch splits up the multi_connection_established() function.  Each new
> helper function does a specific job.  Functions that do a similar job receive a
> similar calling interface.
> 
> The patch tries not to reindent code, so that the real changes are as clearly
> visible as possible.  (A follow-up patch will only do indentation changes.)
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> 
> PATCH v3: Since the code has changed enough from the time the original patch
> to the current master, the splitting has been redone from the current code.
> Also some style and minor code changes have been added doing this patch.
> This elimininates and the big reformatting done before eliminates the follow
> up patch with indentation changes.
> 
> The original patch already replaces some instances of option_permission_mask
> with CLIENT_CONNECT_OPT_MASK. The V3 version does this more consequently.
> 

Did you mean "more consistently" ?

> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---

I have some comments below


>  src/openvpn/multi.c | 597 +++++++++++++++++++++++++-------------------
>  src/openvpn/multi.h |   4 +-
>  2 files changed, 346 insertions(+), 255 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 8440f311..a4b62151 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1638,7 +1638,6 @@ static void
>  multi_client_connect_post(struct multi_context *m,
>                            struct multi_instance *mi,
>                            const char *dc_file,
> -                          unsigned int option_permissions_mask,
>                            unsigned int *option_types_found)
>  {
>      /* Did script generate a dynamic config file? */
> @@ -1647,7 +1646,7 @@ multi_client_connect_post(struct multi_context *m,
>          options_server_import(&mi->context.options,
>                                dc_file,
>                                D_IMPORT_ERRORS|M_OPTERR,
> -                              option_permissions_mask,
> +                              CLIENT_CONNECT_OPT_MASK,

every invocation of options_server_import() gets CLIENT_CONNECT_OPT_MASK
as parameter. Do we really need it to be a parameter?

I am also thinking whether a change like this may be worth its own
commit (it's unrelated to the commit except that it touches similar code
and could be easier to review/merge).

>                                option_types_found,
>                                mi->context.c2.es);
>  
> @@ -1671,7 +1670,6 @@ static void
>  multi_client_connect_post_plugin(struct multi_context *m,
>                                   struct multi_instance *mi,
>                                   const struct plugin_return *pr,
> -                                 unsigned int option_permissions_mask,
>                                   unsigned int *option_types_found)
>  {
>      struct plugin_return config;
> @@ -1689,7 +1687,7 @@ multi_client_connect_post_plugin(struct multi_context *m,
>                  options_string_import(&mi->context.options,
>                                        config.list[i]->value,
>                                        D_IMPORT_ERRORS|M_OPTERR,
> -                                      option_permissions_mask,
> +                                      CLIENT_CONNECT_OPT_MASK,
>                                        option_types_found,
>                                        mi->context.c2.es);
>              }
> @@ -1716,21 +1714,19 @@ multi_client_connect_post_plugin(struct multi_context *m,
>  static void
>  multi_client_connect_mda(struct multi_context *m,
>                           struct multi_instance *mi,
> -                         const struct buffer_list *config,
> -                         unsigned int option_permissions_mask,
>                           unsigned int *option_types_found)
>  {
> -    if (config)
> +    if (mi->cc_config)

Also getting rid of config and using mi->cc_config looks like something
that could go in its own patch, as it is quite unrelated.

>      {
>          struct buffer_entry *be;
>  
> -        for (be = config->head; be != NULL; be = be->next)
> +        for (be = mi->cc_config->head; be != NULL; be = be->next)
>          {
>              const char *opt = BSTR(&be->buf);
>              options_string_import(&mi->context.options,
>                                    opt,
>                                    D_IMPORT_ERRORS|M_OPTERR,
> -                                  option_permissions_mask,
> +                                  CLIENT_CONNECT_OPT_MASK,
>                                    option_types_found,
>                                    mi->context.c2.es);
>          }
> @@ -1773,215 +1769,386 @@ multi_client_connect_setenv(struct multi_context *m,
>      gc_free(&gc);
>  }
>  
> -/*
> - * Called as soon as the SSL/TLS connection authenticates.
> - *
> - * Instance-specific directives to be processed:
> - *
> - *   iroute start-ip end-ip
> - *   ifconfig-push local remote-netmask
> - *   push
> - */
>  static void
> -multi_connection_established(struct multi_context *m, struct multi_instance *mi)
> +multi_client_connect_call_plugin_v1(struct multi_context *m,
> +                                    struct multi_instance *mi,
> +                                    unsigned int *option_types_found,
> +                                    int *cc_succeeded,
> +                                    int *cc_succeeded_count)
>  {
> -    if (tls_authentication_status(mi->context.c2.tls_multi, 0) == TLS_AUTHENTICATION_SUCCEEDED)
> +#ifdef ENABLE_PLUGIN
> +    ASSERT(m);
> +    ASSERT(mi);
> +    ASSERT(option_types_found);
> +    ASSERT(cc_succeeded);
> +    ASSERT(cc_succeeded_count);
> +
> +    /* deprecated callback, use a file for passing back return info */
> +    if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
>      {
> +        struct argv argv = argv_new();
>          struct gc_arena gc = gc_new();
> -        unsigned int option_types_found = 0;
> +        const char *dc_file =
> +            platform_create_temp_file(mi->context.options.tmp_dir, "cc", &gc);
>  
> -        const unsigned int option_permissions_mask =
> -            OPT_P_INSTANCE
> -            | OPT_P_INHERIT
> -            | OPT_P_PUSH
> -            | OPT_P_TIMER
> -            | OPT_P_CONFIG
> -            | OPT_P_ECHO
> -            | OPT_P_COMP
> -            | OPT_P_SOCKFLAGS;
> +        if (!dc_file)
> +        {
> +            cc_succeeded = false;
> +            goto cleanup;
> +        }
>  
> -        int cc_succeeded = true; /* client connect script status */
> -        int cc_succeeded_count = 0;
> +        argv_printf(&argv, "%s", dc_file);
> +        if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT,
> +                        &argv, NULL, mi->context.c2.es)
> +            != OPENVPN_PLUGIN_FUNC_SUCCESS)
> +        {
> +            msg(M_WARN, "WARNING: client-connect plugin call failed");
> +            *cc_succeeded = false;
> +        }
> +        else
> +        {
> +            multi_client_connect_post(m, mi, dc_file, option_types_found);
> +            (*cc_succeeded_count)++;
> +        }
> +
> +        {
> +            msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
> +                dc_file);
> +        }
> +
> +cleanup:
> +        argv_reset(&argv);
> +        gc_free(&gc);
> +    }
> +#endif /* ifdef ENABLE_PLUGIN */
> +}
>  
> -        ASSERT(mi->context.c1.tuntap);
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
> -        /* lock down the common name and cert hashes so they can't change during future TLS renegotiations */
> -        tls_lock_common_name(mi->context.c2.tls_multi);
> -        tls_lock_cert_hash_set(mi->context.c2.tls_multi);
> +    /* V2 callback, use a plugin_return struct for passing back return info */
> +    if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
> +    {
> +        struct plugin_return pr;
>  
> -        /* generate a msg() prefix for this client instance */
> -        generate_prefix(mi);
> +        plugin_return_init(&pr);
>  
> -        /* delete instances of previous clients with same common-name */
> -        if (!mi->context.options.duplicate_cn)
> +        if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2,
> +                        NULL, &pr, mi->context.c2.es)
> +            != OPENVPN_PLUGIN_FUNC_SUCCESS)
>          {
> -            multi_delete_dup(m, mi);
> +            msg(M_WARN, "WARNING: client-connect-v2 plugin call failed");
> +            *cc_succeeded = false;
> +        }
> +        else
> +        {
> +            multi_client_connect_post_plugin(m, mi, &pr, option_types_found);
> +            (*cc_succeeded_count)++;
>          }
>  
> -        /* reset pool handle to null */
> -        mi->vaddr_handle = -1;
> +        plugin_return_free(&pr);
> +    }
> +#endif /* ifdef ENABLE_PLUGIN */
> +}
>  
> -        /*
> -         * Try to source a dynamic config file from the
> -         * --client-config-dir directory.
> -         */
> -        if (mi->context.options.client_config_dir)
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
> +    if (mi->context.options.client_connect_script)
> +    {
> +        struct argv argv = argv_new();
> +        struct gc_arena gc = gc_new();
> +        const char *dc_file = NULL;
> +
> +        setenv_str(mi->context.c2.es, "script_type", "client-connect");
> +
> +        dc_file = platform_create_temp_file(mi->context.options.tmp_dir,
> +                                            "cc", &gc);
> +        if (!dc_file)
>          {
> -            const char *ccd_file;
> +            *cc_succeeded = false;
> +            goto cleanup;
> +        }
>  
> -            ccd_file = platform_gen_path(mi->context.options.client_config_dir,
> -                                         tls_common_name(mi->context.c2.tls_multi,
> -                                                         false),
> -                                         &gc);
> +        argv_parse_cmd(&argv, mi->context.options.client_connect_script);
> +        argv_printf_cat(&argv, "%s", dc_file);
>  
> -            /* try common-name file */
> -            if (platform_test_file(ccd_file))
> -            {
> -                options_server_import(&mi->context.options,
> -                                      ccd_file,
> -                                      D_IMPORT_ERRORS|M_OPTERR,
> -                                      option_permissions_mask,
> -                                      &option_types_found,
> -                                      mi->context.c2.es);
> -            }
> -            else /* try default file */
> -            {
> -                ccd_file = platform_gen_path(mi->context.options.client_config_dir,
> -                                             CCD_DEFAULT,
> -                                             &gc);
> +        if (openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-connect"))
> +        {
> +            multi_client_connect_post(m, mi, dc_file, option_types_found);
> +            (*cc_succeeded_count)++;
> +        }
> +        else
> +        {
> +            *cc_succeeded = false;
> +        }
>  
> -                if (platform_test_file(ccd_file))
> -                {
> -                    options_server_import(&mi->context.options,
> -                                          ccd_file,
> -                                          D_IMPORT_ERRORS|M_OPTERR,
> -                                          option_permissions_mask,
> -                                          &option_types_found,
> -                                          mi->context.c2.es);
> -                }
> -            }
> +        if (!platform_unlink(dc_file))
> +        {
> +            msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
> +                dc_file);
>          }
> +cleanup:
> +        argv_reset(&argv);
> +        gc_free(&gc);
> +    }
> +}
>  
> -        /*
> -         * Select a virtual address from either --ifconfig-push in --client-config-dir file
> -         * or --ifconfig-pool.
> -         */
> -        multi_select_virtual_addr(m, mi);
> +static void
> +multi_client_connect_late_setup(struct multi_context *m,
> +                                struct multi_instance *mi,
> +                                const unsigned int option_types_found)
> +{
> +    struct gc_arena gc = gc_new();
> +    /*
> +     * Process sourced options.
> +     */
> +    do_deferred_options(&mi->context, option_types_found);
>  
> -        /* do --client-connect setenvs */
> -        multi_client_connect_setenv(m, mi);
> +    /*
> +     * make sure we got ifconfig settings from somewhere
> +     */
> +    if (!mi->context.c2.push_ifconfig_defined)
> +    {
> +        msg(D_MULTI_ERRORS, "MULTI: no dynamic or static remote"
> +            "--ifconfig address is available for %s",
> +            multi_instance_string(mi, false, &gc));
> +    }
> +
> +    /*
> +     * make sure that ifconfig settings comply with constraints
> +     */
> +    if (!ifconfig_push_constraint_satisfied(&mi->context))
> +    {
> +        const char *ifconfig_constraint_network =
> +            print_in_addr_t(mi->context.options.push_ifconfig_constraint_network, 0, &gc);
> +        const char *ifconfig_constraint_netmask =
> +            print_in_addr_t(mi->context.options.push_ifconfig_constraint_netmask, 0, &gc);
> +
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
> +        {
> +            multi_learn_in_addr_t(m, mi,
> +                                  mi->context.c2.push_ifconfig_local,
> +                                  -1, true);
> +            msg(D_MULTI_LOW, "MULTI: primary virtual IP for %s: %s",
> +                multi_instance_string(mi, false, &gc),
> +                print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc));
> +        }
> +
> +        if (mi->context.c2.push_ifconfig_ipv6_defined)
> +        {
> +            multi_learn_in6_addr(m, mi,
> +                                 mi->context.c2.push_ifconfig_ipv6_local,
> +                                 -1, true);
> +            /* TODO: find out where addresses are "unlearned"!! */
> +            const char *ifconfig_local_ipv6 =
> +                print_in6_addr(mi->context.c2.push_ifconfig_ipv6_local, 0, &gc);
> +            msg(D_MULTI_LOW, "MULTI: primary virtual IPv6 for %s: %s",
> +                multi_instance_string(mi, false, &gc),
> +                ifconfig_local_ipv6);
> +        }
> +
> +        /* add routes locally, pointing to new client, if
> +         * --iroute options have been specified */
> +        multi_add_iroutes(m, mi);
>  
> -#ifdef ENABLE_PLUGIN
>          /*
> -         * Call client-connect plug-in.
> +         * iroutes represent subnets which are "owned" by a particular
> +         * client.  Therefore, do not actually push a route to a client
> +         * if it matches one of the client's iroutes.
>           */
> +        remove_iroutes_from_push_route_list(&mi->context.options);
> +    }
> +    else if (mi->context.options.iroutes)
> +    {
> +        msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute"
> +            "only works with tun-style tunnels",
> +            multi_instance_string(mi, false, &gc));
> +    }
>  
> -        /* deprecated callback, use a file for passing back return info */
> -        if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
> -        {
> -            struct argv argv = argv_new();
> -            const char *dc_file = platform_create_temp_file(mi->context.options.tmp_dir,
> -                                                            "cc", &gc);
> +    /* set our client's VPN endpoint for status reporting purposes */
> +    mi->reporting_addr = mi->context.c2.push_ifconfig_local;
> +    mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
>  
> -            if (!dc_file)
> -            {
> -                cc_succeeded = false;
> -                goto script_depr_failed;
> -            }
> +    /* set context-level authentication flag */
> +    mi->context.c2.context_auth = CAS_SUCCEEDED;
>  
> -            argv_printf(&argv, "%s", dc_file);
> -            if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
> -            {
> -                msg(M_WARN, "WARNING: client-connect plugin call failed");
> -                cc_succeeded = false;
> -            }
> -            else
> -            {
> -                multi_client_connect_post(m, mi, dc_file, option_permissions_mask, &option_types_found);
> -                ++cc_succeeded_count;
> -            }
> +#ifdef ENABLE_ASYNC_PUSH
> +    /* authentication complete, send push reply */
> +    if (mi->context.c2.push_request_received)
> +    {
> +        process_incoming_push_request(&mi->context);
> +    }
> +#endif
> +    gc_free(&gc);
> +}
>  
> -            if (!platform_unlink(dc_file))
> -            {
> -                msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
> -                    dc_file);
> -            }
>  
> -script_depr_failed:
> -            argv_reset(&argv);
> -        }
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
>  
> -        /* V2 callback, use a plugin_return struct for passing back return info */
> -        if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
> -        {
> -            struct plugin_return pr;
> +    /* generate a msg() prefix for this client instance */
> +    generate_prefix(mi);
>  
> -            plugin_return_init(&pr);
> +    /* delete instances of previous clients with same common-name */
> +    if (!mi->context.options.duplicate_cn)
> +    {
> +        multi_delete_dup(m, mi);
> +    }
>  
> -            if (plugin_call(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2, NULL, &pr, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
> -            {
> -                msg(M_WARN, "WARNING: client-connect-v2 plugin call failed");
> -                cc_succeeded = false;
> -            }
> -            else
> -            {
> -                multi_client_connect_post_plugin(m, mi, &pr, option_permissions_mask, &option_types_found);
> -                ++cc_succeeded_count;
> -            }
> +    /* reset pool handle to null */
> +    mi->vaddr_handle = -1;
> +}
>  
> -            plugin_return_free(&pr);
> -        }
> -#endif /* ifdef ENABLE_PLUGIN */
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
> -        /*
> -         * Run --client-connect script.
> -         */
> -        if (mi->context.options.client_connect_script && cc_succeeded)
> -        {
> -            struct argv argv = argv_new();
> -            const char *dc_file = NULL;
> +        ccd_file = platform_gen_path(mi->context.options.client_config_dir,
> +                                     tls_common_name(mi->context.c2.tls_multi,
> +                                                     false),
> +                                     &gc);
>  
> -            setenv_str(mi->context.c2.es, "script_type", "client-connect");
> +        /* try common-name file */
> +        if (platform_test_file(ccd_file))
> +        {
> +            options_server_import(&mi->context.options,
> +                                  ccd_file,
> +                                  D_IMPORT_ERRORS|M_OPTERR,
> +                                  CLIENT_CONNECT_OPT_MASK,
> +                                  option_types_found,
> +                                  mi->context.c2.es);
> +        }
> +        else /* try default file */
> +        {
> +            ccd_file = platform_gen_path(mi->context.options.client_config_dir,
> +                                         CCD_DEFAULT,
> +                                         &gc);
>  
> -            dc_file = platform_create_temp_file(mi->context.options.tmp_dir,
> -                                                "cc", &gc);
> -            if (!dc_file)
> +            if (platform_test_file(ccd_file))
>              {
> -                cc_succeeded = false;
> -                goto script_failed;
> +                options_server_import(&mi->context.options,
> +                                      ccd_file,
> +                                      D_IMPORT_ERRORS|M_OPTERR,
> +                                      CLIENT_CONNECT_OPT_MASK,
> +                                      option_types_found,
> +                                      mi->context.c2.es);
>              }
> +        }
> +        gc_free(&gc);
> +    }
> +}
> +
> +/*
> + * Called as soon as the SSL/TLS connection authenticates.
> + *
> + * Instance-specific directives to be processed:
> + *
> + *   iroute start-ip end-ip
> + *   ifconfig-push local remote-netmask
> + *   push
> + */
> +static void
> +multi_connection_established(struct multi_context *m, struct multi_instance *mi)
> +{
> +    if (tls_authentication_status(mi->context.c2.tls_multi, 0)
> +        == TLS_AUTHENTICATION_SUCCEEDED)
> +    {
> +        unsigned int option_types_found = 0;
>  
> -            argv_parse_cmd(&argv, mi->context.options.client_connect_script);
> -            argv_printf_cat(&argv, "%s", dc_file);
> +        int cc_succeeded = true; /* client connect script status */
> +        int cc_succeeded_count = 0;
>  
> -            if (openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-connect"))
> -            {
> -                multi_client_connect_post(m, mi, dc_file, option_permissions_mask, &option_types_found);
> -                ++cc_succeeded_count;
> -            }
> -            else
> -            {
> -                cc_succeeded = false;
> -            }
> +        multi_client_connect_early_setup(m, mi);
>  
> -            if (!platform_unlink(dc_file))
> -            {
> -                msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
> -                    dc_file);
> -            }
> +        multi_client_connect_source_ccd(m, mi, &option_types_found);
>  
> -script_failed:
> -            argv_reset(&argv);
> -        }
> +        /*
> +         * Select a virtual address from either --ifconfig-push in
> +         * --client-config-dir file or --ifconfig-pool.
> +         */
> +        multi_select_virtual_addr(m, mi);
> +
> +        /* do --client-connect setenvs */
> +        multi_client_connect_setenv(m, mi);
> +
> +        multi_client_connect_call_plugin_v1(m, mi, &option_types_found,
> +                                            &cc_succeeded,
> +                                            &cc_succeeded_count);
> +
> +        multi_client_connect_call_plugin_v2(m, mi, &option_types_found,
> +                                            &cc_succeeded,
> +                                            &cc_succeeded_count);
>  
>          /*
>           * Check for client-connect script left by management interface client
>           */
> +
> +        if (cc_succeeded)
> +        {
> +            multi_client_connect_call_script(m, mi, &option_types_found,
> +                                             &cc_succeeded,
> +                                             &cc_succeeded_count);
> +
> +        }
>  #ifdef MANAGEMENT_DEF_AUTH
>          if (cc_succeeded && mi->cc_config)
>          {
> -            multi_client_connect_mda(m, mi, mi->cc_config, option_permissions_mask, &option_types_found);
> -            ++cc_succeeded_count;
> +            multi_client_connect_mda(m, mi, &option_types_found);
> +            cc_succeeded_count++;
>          }
>  #endif
>  
> @@ -1991,99 +2158,21 @@ script_failed:
>           */
>          if (mi->context.options.disable)
>          {
> -            msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to 'disable' directive");
> +            msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to"
> +                "'disable' directive");
>              cc_succeeded = false;
>              cc_succeeded_count = 0;
>          }
>  
>          if (cc_succeeded)
>          {
> -            /*
> -             * Process sourced options.
> -             */
> -            do_deferred_options(&mi->context, option_types_found);
> -
> -            /*
> -             * make sure we got ifconfig settings from somewhere
> -             */
> -            if (!mi->context.c2.push_ifconfig_defined)
> -            {
> -                msg(D_MULTI_ERRORS, "MULTI: no dynamic or static remote --ifconfig address is available for %s",
> -                    multi_instance_string(mi, false, &gc));
> -            }
> -
> -            /*
> -             * make sure that ifconfig settings comply with constraints
> -             */
> -            if (!ifconfig_push_constraint_satisfied(&mi->context))
> -            {
> -                /* JYFIXME -- this should cause the connection to fail */
> -                msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s) violates tunnel network/netmask constraint (%s/%s)",
> -                    multi_instance_string(mi, false, &gc),
> -                    print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc),
> -                    print_in_addr_t(mi->context.options.push_ifconfig_constraint_network, 0, &gc),
> -                    print_in_addr_t(mi->context.options.push_ifconfig_constraint_netmask, 0, &gc));
> -            }
> -
> -            /*
> -             * For routed tunnels, set up internal route to endpoint
> -             * plus add all iroute routes.
> -             */
> -            if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
> -            {
> -                if (mi->context.c2.push_ifconfig_defined)
> -                {
> -                    multi_learn_in_addr_t(m, mi, mi->context.c2.push_ifconfig_local, -1, true);
> -                    msg(D_MULTI_LOW, "MULTI: primary virtual IP for %s: %s",
> -                        multi_instance_string(mi, false, &gc),
> -                        print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc));
> -                }
> -
> -                if (mi->context.c2.push_ifconfig_ipv6_defined)
> -                {
> -                    multi_learn_in6_addr(m, mi, mi->context.c2.push_ifconfig_ipv6_local, -1, true);
> -                    /* TODO: find out where addresses are "unlearned"!! */
> -                    msg(D_MULTI_LOW, "MULTI: primary virtual IPv6 for %s: %s",
> -                        multi_instance_string(mi, false, &gc),
> -                        print_in6_addr(mi->context.c2.push_ifconfig_ipv6_local, 0, &gc));
> -                }
> -
> -                /* add routes locally, pointing to new client, if
> -                 * --iroute options have been specified */
> -                multi_add_iroutes(m, mi);
> -
> -                /*
> -                 * iroutes represent subnets which are "owned" by a particular
> -                 * client.  Therefore, do not actually push a route to a client
> -                 * if it matches one of the client's iroutes.
> -                 */
> -                remove_iroutes_from_push_route_list(&mi->context.options);
> -            }
> -            else if (mi->context.options.iroutes)
> -            {
> -                msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute only works with tun-style tunnels",
> -                    multi_instance_string(mi, false, &gc));
> -            }
> -
> -            /* set our client's VPN endpoint for status reporting purposes */
> -            mi->reporting_addr = mi->context.c2.push_ifconfig_local;
> -            mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
> -
> -            /* set context-level authentication flag */
> -            mi->context.c2.context_auth = CAS_SUCCEEDED;
> -
> -#ifdef ENABLE_ASYNC_PUSH
> -            /* authentication complete, send push reply */
> -            if (mi->context.c2.push_request_received)
> -            {
> -                process_incoming_push_request(&mi->context);
> -            }
> -#endif
> +            multi_client_connect_late_setup(m, mi, option_types_found);
>          }
>          else
>          {
>              /* set context-level authentication flag */
> -            mi->context.c2.context_auth = cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
> +            mi->context.c2.context_auth =
> +                cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
>          }
>  
>          /* set flag so we don't get called again */
> @@ -2097,11 +2186,11 @@ script_failed:
>  #ifdef MANAGEMENT_DEF_AUTH
>          if (management)
>          {
> -            management_connection_established(management, &mi->context.c2.mda_context, mi->context.c2.es);
> +            management_connection_established
> +                (management, &mi->context.c2.mda_context, mi->context.c2.es);

I don't get the change above. I don't think the new style reflects our
coding style, no? Normally you'd go to the new line with the first
argument exceeding the max line length.


>          }
>  #endif
>  
> -        gc_free(&gc);
>      }
>  
>      /*
> diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
> index 3d3d6875..489c073a 100644
> --- a/src/openvpn/multi.h
> +++ b/src/openvpn/multi.h
> @@ -628,7 +628,9 @@ multi_process_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags
>      return ret;
>  }
>  
> -
> +#define CLIENT_CONNECT_OPT_MASK (OPT_P_INSTANCE | OPT_P_INHERIT   \
> +                                 |OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG   \
> +                                 |OPT_P_ECHO | OPT_P_COMP | OPT_P_SOCKFLAGS)
>  
>  static inline bool
>  multi_process_outgoing_link_dowork(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
> 


other than those few comments the change "looks" reasonable. However, do
we have a way to test the code being changed? I mean all the code being
changed (not just the part used by the deferred connect logic)

Because even though it all looks sane, we might be breaking something else.


Regards,



-- 
Antonio Quartulli

