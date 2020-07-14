References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-5-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9c3c580e-4e8d-db38-9281-da3301bb1ce8@...2181...>
Date: Tue, 14 Jul 2020 11:46:33 +0200
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-5-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 05/14] client-connect: Refactor to
 use return values instead of modifying a passed-in flag
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

On 11/07/2020 11:36, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
> 
> This patch changes the way the client-connect helper functions communicate with
> the main function.  Instead of updating cc_succeeded and cc_succeeded_count,
> they now return either CC_RET_SUCCEEDED, CC_RET_FAILED or CC_RET_SKIPPED.
> 
> In addition, the client-connect helpers are now called in completely identical
> ways.  This is in preparation of handling the helpers as simple call-backs.
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> 
> Patch V5: Minor style fixes
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c | 135 ++++++++++++++++++++++++++------------------
>  src/openvpn/multi.h |  10 ++++
>  2 files changed, 91 insertions(+), 54 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 539ebfc0..9bb52ef7 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1706,20 +1706,21 @@ multi_client_connect_post_plugin(struct multi_context *m,
>  
>  #endif /* ifdef ENABLE_PLUGIN */
>  
> -#ifdef MANAGEMENT_DEF_AUTH
> +

I would not add this empty line - but nothing critical.

>  
>  /*
>   * Called to load management-derived client-connect config
>   */
> -static void
> +enum client_connect_return
>  multi_client_connect_mda(struct multi_context *m,
>                           struct multi_instance *mi,
>                           unsigned int *option_types_found)
>  {
> +    enum client_connect_return ret = CC_RET_SKIPPED;
> +#ifdef MANAGEMENT_DEF_AUTH
>      if (mi->cc_config)
>      {
>          struct buffer_entry *be;
> -
>          for (be = mi->cc_config->head; be != NULL; be = be->next)
>          {
>              const char *opt = BSTR(&be->buf);
> @@ -1739,10 +1740,12 @@ multi_client_connect_mda(struct multi_context *m,
>           */
>          multi_select_virtual_addr(m, mi);
>          multi_set_virtual_addr_env(mi);
> -    }
> -}
>  
> +        ret = CC_RET_SUCCEEDED;
> +    }
>  #endif /* ifdef MANAGEMENT_DEF_AUTH */
> +    return ret;
> +}
>  
>  static void
>  multi_client_connect_setenv(struct multi_context *m,
> @@ -1840,19 +1843,16 @@ multi_client_set_protocol_options(struct context *c)
>      }
>  }
>  
> -static void
> +static enum client_connect_return
>  multi_client_connect_call_plugin_v1(struct multi_context *m,
>                                      struct multi_instance *mi,
> -                                    unsigned int *option_types_found,
> -                                    int *cc_succeeded,
> -                                    int *cc_succeeded_count)
> +                                    unsigned int *option_types_found)
>  {
> +    enum client_connect_return ret = CC_RET_SKIPPED;
>  #ifdef ENABLE_PLUGIN
>      ASSERT(m);
>      ASSERT(mi);
>      ASSERT(option_types_found);
> -    ASSERT(cc_succeeded);
> -    ASSERT(cc_succeeded_count);
>  
>      /* deprecated callback, use a file for passing back return info */
>      if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
> @@ -1864,7 +1864,7 @@ multi_client_connect_call_plugin_v1(struct multi_context *m,
>  
>          if (!dc_file)
>          {
> -            cc_succeeded = false;
> +            ret = CC_RET_FAILED;
>              goto cleanup;
>          }
>  
> @@ -1874,12 +1874,12 @@ multi_client_connect_call_plugin_v1(struct multi_context *m,
>              != OPENVPN_PLUGIN_FUNC_SUCCESS)
>          {
>              msg(M_WARN, "WARNING: client-connect plugin call failed");
> -            *cc_succeeded = false;
> +            ret = CC_RET_FAILED;
>          }
>          else
>          {
>              multi_client_connect_post(m, mi, dc_file, option_types_found);
> -            (*cc_succeeded_count)++;
> +            ret = CC_RET_SUCCEEDED;
>          }
>  
>          if (!platform_unlink(dc_file))
> @@ -1893,21 +1893,19 @@ cleanup:
>          gc_free(&gc);
>      }
>  #endif /* ifdef ENABLE_PLUGIN */
> +    return ret;
>  }
>  
> -static void
> +static enum client_connect_return
>  multi_client_connect_call_plugin_v2(struct multi_context *m,
>                                      struct multi_instance *mi,
> -                                    unsigned int *option_types_found,
> -                                    int *cc_succeeded,
> -                                    int *cc_succeeded_count)
> +                                    unsigned int *option_types_found)
>  {
> +    enum client_connect_return ret = CC_RET_SKIPPED;
>  #ifdef ENABLE_PLUGIN
>      ASSERT(m);
>      ASSERT(mi);
>      ASSERT(option_types_found);
> -    ASSERT(cc_succeeded);
> -    ASSERT(cc_succeeded_count);
>  
>      /* V2 callback, use a plugin_return struct for passing back return info */
>      if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2))
> @@ -1921,17 +1919,18 @@ multi_client_connect_call_plugin_v2(struct multi_context *m,
>              != OPENVPN_PLUGIN_FUNC_SUCCESS)
>          {
>              msg(M_WARN, "WARNING: client-connect-v2 plugin call failed");
> -            *cc_succeeded = false;
> +            ret = CC_RET_FAILED;
>          }
>          else
>          {
>              multi_client_connect_post_plugin(m, mi, &pr, option_types_found);
> -            (*cc_succeeded_count)++;
> +            ret = CC_RET_SUCCEEDED;
>          }
>  
>          plugin_return_free(&pr);
>      }
>  #endif /* ifdef ENABLE_PLUGIN */
> +    return ret;
>  }
>  
>  
> @@ -1939,15 +1938,17 @@ multi_client_connect_call_plugin_v2(struct multi_context *m,
>  /**
>   * Runs the --client-connect script if one is defined.
>   */
> -static void
> +static enum client_connect_return
>  multi_client_connect_call_script(struct multi_context *m,
>                                   struct multi_instance *mi,
> -                                 unsigned int *option_types_found,
> -                                 int *cc_succeeded,
> -                                 int *cc_succeeded_count)
> +                                 unsigned int *option_types_found)
>  {
> +

random empty line?

>      ASSERT(m);
>      ASSERT(mi);
> +
> +    enum client_connect_return ret = CC_RET_SKIPPED;
> +
>      if (mi->context.options.client_connect_script)
>      {
>          struct argv argv = argv_new();
> @@ -1960,7 +1961,7 @@ multi_client_connect_call_script(struct multi_context *m,
>                                              "cc", &gc);
>          if (!dc_file)
>          {
> -            *cc_succeeded = false;
> +            ret = CC_RET_FAILED;
>              goto cleanup;
>          }
>  
> @@ -1970,11 +1971,11 @@ multi_client_connect_call_script(struct multi_context *m,
>          if (openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-connect"))
>          {
>              multi_client_connect_post(m, mi, dc_file, option_types_found);
> -            (*cc_succeeded_count)++;
> +            ret = CC_RET_SUCCEEDED;
>          }
>          else
>          {
> -            *cc_succeeded = false;
> +            ret = CC_RET_FAILED;
>          }
>  
>          if (!platform_unlink(dc_file))
> @@ -1986,6 +1987,7 @@ cleanup:
>          argv_free(&argv);
>          gc_free(&gc);
>      }
> +    return ret;
>  }
>  
>  /**
> @@ -2155,18 +2157,18 @@ multi_client_connect_early_setup(struct multi_context *m,
>      multi_select_virtual_addr(m, mi);
>  
>      multi_client_connect_setenv(m, mi);
> -
>  }
>  
>  /**
>   * Try to source a dynamic config file from the
>   * --client-config-dir directory.
>   */
> -static void
> +enum client_connect_return
>  multi_client_connect_source_ccd(struct multi_context *m,
>                                  struct multi_instance *mi,
>                                  unsigned int *option_types_found)
>  {
> +    enum client_connect_return ret = CC_RET_SKIPPED;
>      if (mi->context.options.client_config_dir)
>      {
>          struct gc_arena gc = gc_new();
> @@ -2208,9 +2210,35 @@ multi_client_connect_source_ccd(struct multi_context *m,
>              multi_select_virtual_addr(m, mi);
>  
>              multi_client_connect_setenv(m, mi);
> +
> +            ret = CC_RET_SUCCEEDED;
>          }
>          gc_free(&gc);
>      }
> +    return ret;
> +}
> +
> +static inline bool
> +cc_check_return(int *cc_succeeded_count,
> +                enum client_connect_return ret)
> +{
> +    if (ret == CC_RET_SUCCEEDED)
> +    {
> +        (*cc_succeeded_count)++;
> +        return true;
> +    }
> +    else if (ret == CC_RET_FAILED)
> +    {
> +        return false;
> +    }
> +    else if (ret == CC_RET_SKIPPED)
> +    {
> +        return true;
> +    }
> +    else
> +    {
> +        ASSERT(0);
> +    }
>  }
>  
>  /*
> @@ -2242,38 +2270,40 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>      }
>      unsigned int option_types_found = 0;
>  
> -    int cc_succeeded = true;     /* client connect script status */
> +    int cc_succeeded = true; /* client connect script status */

hmm..whatever

>      int cc_succeeded_count = 0;
> +    enum client_connect_return ret;
>  
>      multi_client_connect_early_setup(m, mi);
>  
> -    multi_client_connect_source_ccd(m, mi, &option_types_found);
> +    ret = multi_client_connect_source_ccd(m, mi, &option_types_found);
> +    cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
>  
> -    multi_client_connect_call_plugin_v1(m, mi, &option_types_found,
> -                                        &cc_succeeded,
> -                                        &cc_succeeded_count);
> +    if (cc_succeeded)
> +    {
> +        ret = multi_client_connect_call_plugin_v1(m, mi, &option_types_found);
> +        cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
> +    }
> +
> +    if (cc_succeeded)
> +    {
> +        ret = multi_client_connect_call_plugin_v2(m, mi, &option_types_found);
> +        cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
> +    }
>  
> -    multi_client_connect_call_plugin_v2(m, mi, &option_types_found,
> -                                        &cc_succeeded,
> -                                        &cc_succeeded_count);
>  
> -    /*
> -     * Check for client-connect script left by management interface client
> -     */
>      if (cc_succeeded)
>      {
> -        multi_client_connect_call_script(m, mi, &option_types_found,
> -                                         &cc_succeeded,
> -                                         &cc_succeeded_count);
> +        ret = multi_client_connect_call_script(m, mi, &option_types_found);
> +        cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
>      }
>  
> -#ifdef MANAGEMENT_DEF_AUTH
> -    if (cc_succeeded && mi->cc_config)
> +    if (cc_succeeded)
>      {
> -        multi_client_connect_mda(m, mi, &option_types_found);
> -        ++cc_succeeded_count;
> +

remove this empty line above

> +        ret = multi_client_connect_mda(m, mi, &option_types_found);
> +        cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
>      }
> -#endif
>  
>      /*
>       * Check for "disable" directive in client-config-dir file
> @@ -2282,13 +2312,11 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>      if (mi->context.options.disable)
>      {
>          msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to "
> -            " 'disable' directive");
> +            "'disable' directive");
>          cc_succeeded = false;
>          cc_succeeded_count = 0;
>      }
>  
> -
> -
>      if (cc_succeeded)
>      {
>          multi_client_connect_late_setup(m, mi, option_types_found);
> @@ -2300,7 +2328,6 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>              cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
>      }
>  
> -
>      /* increment number of current authenticated clients */
>      ++m->n_clients;
>      update_mstat_n_clients(m->n_clients);
> diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
> index c51107f4..4fb4d0b6 100644
> --- a/src/openvpn/multi.h
> +++ b/src/openvpn/multi.h
> @@ -187,6 +187,16 @@ struct multi_context {
>      struct deferred_signal_schedule_entry deferred_shutdown_signal;
>  };
>  
> +/**
> + * Return values used by the client connect call-back functions.
> + */
> +enum client_connect_return
> +{
> +    CC_RET_FAILED,
> +    CC_RET_SUCCEEDED,
> +    CC_RET_SKIPPED
> +};
> +
>  /*
>   * Host route
>   */
> 


Apart from the few style comments I posted above, this patch looks good.

Using the return value instead of modifying arguments passed via pointer
looks much saner and easier to read, imho, so more reasons to go this way.


Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

