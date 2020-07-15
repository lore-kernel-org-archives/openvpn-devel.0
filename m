References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-9-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <7a980edd-3602-3a56-36b2-bb4f8d8c17ad@...2181...>
Date: Wed, 15 Jul 2020 10:21:42 +0200
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-9-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 09/14] client-connect: Add deferred
 support to the client-connect script handler
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
> This patch introduces the concept of a return value file for the client-connect
> handlers. (This is very similar to the auth value file used during deferred
> authentication.)  The file name is stored in the client_connect_state struct.
> 
> In addition, the patch also allows the storage of the client config file name
> in struct client_connect_state.
> 
> Both changes are used by the client-connect script handler to support deferred
> client-connection handling.  The deferred return value file (deferred_ret_file)
> is passed to the actual script via the environment.  If the script succeeds and
> writes the value for deferral into the deferred_ret_file, the handler knows to
> indicate deferral.  Later on, the deferred handler checks whether the value of
> the deferred_ret_file has been updated to success or failure.
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c | 230 +++++++++++++++++++++++++++++++++++++++++---
>  src/openvpn/multi.h |  12 +++
>  2 files changed, 227 insertions(+), 15 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index ce73f8a1..271d09d8 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1843,6 +1843,168 @@ multi_client_set_protocol_options(struct context *c)
>      }
>  }
>  
> +/**
> + * Delete the temporary file for the return value of client connect
> + * It also removes it from it from client_connect_defer_state and
> + * environment
> + */
> +static void
> +ccs_delete_deferred_ret_file(struct multi_instance *mi)
> +{
> +    struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);

parenthesis are not needed

> +    if (ccs->deferred_ret_file)
> +    {
> +        setenv_del(mi->context.c2.es, "client_connect_deferred_file");
> +        if (!platform_unlink(ccs->deferred_ret_file))
> +        {
> +            msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
> +                ccs->deferred_ret_file);
> +        }
> +        free(ccs->deferred_ret_file);
> +        ccs->deferred_ret_file = NULL;
> +    }
> +}
> +
> +/**
> + * Create a temporary file for the return value of client connect
> + * and puts it into the client_connect_defer_state and environment
> + * as "client_connect_deferred_file"
> + *
> + * @return boolean value if creation was successfull
> + */
> +static bool
> +ccs_gen_deferred_ret_file(struct multi_instance *mi)
> +{
> +    struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);

parenthesis are not needed

> +    struct gc_arena gc = gc_new();
> +    const char *fn;
> +
> +    if (ccs->deferred_ret_file)
> +    {
> +        ccs_delete_deferred_ret_file(mi);
> +    }
> +
> +    fn = platform_create_temp_file(mi->context.options.tmp_dir, "ccr", &gc);
> +    if (!fn)
> +    {
> +        gc_free(&gc);
> +        return false;
> +    }
> +    ccs->deferred_ret_file = string_alloc(fn, NULL);
> +
> +    setenv_str(mi->context.c2.es, "client_connect_deferred_file",
> +               ccs->deferred_ret_file);
> +
> +    gc_free(&gc);
> +    return true;
> +}
> +
> +/**
> + * Tests whether the deferred return value file exists and returns the
> + * contained return value.
> + *
> + * @return CC_RET_SKIPPED if the file does not exist or is empty.
> + *         CC_RET_DEFERRED, CC_RET_SUCCEEDED or CC_RET_FAILED depending on
> + *         the value stored in the file.
> + */
> +static enum client_connect_return
> +ccs_test_deferred_ret_file(struct multi_instance *mi)
> +{
> +    struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);

parenthesis are not needed

> +    enum client_connect_return ret = CC_RET_SKIPPED;
> +    FILE *fp = fopen(ccs->deferred_ret_file, "r");

I think we should always add an empty line between the first batch of
variable declarations in a block and any code below.

> +    if (fp)
> +    {
> +        const int c = fgetc(fp);
> +        switch (c)
> +        {
> +            case '0':
> +                ret = CC_RET_FAILED;
> +                break;
> +
> +            case '1':
> +                ret = CC_RET_SUCCEEDED;
> +                break;
> +
> +            case '2':
> +                ret = CC_RET_DEFERRED;
> +                break;
> +
> +            case EOF:
> +                if (feof(fp))
> +                {
> +                    ret = CC_RET_SKIPPED;
> +                    break;
> +                }
> +
> +            /* Not EOF, but other error fall through to error state */
> +            default:
> +                /* We received an unknown/unexpected value.  Assume failure. */
> +                msg(M_WARN, "WARNING: Unknown/unexcepted value in deferred"
> +                    "client-connect resultfile");
> +                ret = CC_RET_FAILED;
> +        }
> +        fclose(fp);
> +    }
> +    return ret;
> +}
> +
> +/**
> + * Deletes the temporary file for the config directives of the  client connect
> + * script and removes it into the client_connect_defer_state and environment
> + *
> + */
> +static void
> +ccs_delete_config_file(struct multi_instance *mi)
> +{
> +    struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);

parenthesis are not needed

> +    if (ccs->config_file)
> +    {
> +        setenv_del(mi->context.c2.es, "client_connect_config_file");
> +        if (!platform_unlink(ccs->config_file))
> +        {
> +            msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
> +                ccs->config_file);
> +        }
> +        free(ccs->config_file);
> +        ccs->config_file = NULL;
> +    }
> +}
> +
> +/**
> + * Create a temporary file for the config directives of the  client connect
> + * script and puts it into the client_connect_defer_state and environment
> + * as "client_connect_config_file"
> + *
> + * @return boolean value if creation was successfull
> + */
> +static bool
> +ccs_gen_config_file(struct multi_instance *mi)
> +{
> +    struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);

parenthesis are not needed

> +    struct gc_arena gc = gc_new();
> +    const char *fn;
> +
> +    if (ccs->config_file)
> +    {
> +        ccs_delete_config_file(mi);
> +    }
> +
> +    fn = platform_create_temp_file(mi->context.options.tmp_dir, "cc", &gc);
> +    if (!fn)
> +    {
> +        gc_free(&gc);
> +        return false;
> +    }
> +    ccs->config_file = string_alloc(fn, NULL);
> +
> +    setenv_str(mi->context.c2.es, "client_connect_config_file",
> +               ccs->config_file);
> +
> +    gc_free(&gc);
> +    return true;
> +}
> +
>  static enum client_connect_return
>  multi_client_connect_call_plugin_v1(struct multi_context *m,
>                                      struct multi_instance *mi,
> @@ -1933,8 +2095,6 @@ multi_client_connect_call_plugin_v2(struct multi_context *m,
>      return ret;
>  }
>  
> -
> -
>  /**
>   * Runs the --client-connect script if one is defined.
>   */
> @@ -1948,48 +2108,88 @@ multi_client_connect_call_script(struct multi_context *m,
>      ASSERT(mi);
>  
>      enum client_connect_return ret = CC_RET_SKIPPED;
> +    struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);

parenthesis are not needed

>  
>      if (mi->context.options.client_connect_script)
>      {
>          struct argv argv = argv_new();
>          struct gc_arena gc = gc_new();
> -        const char *dc_file = NULL;
>  
>          setenv_str(mi->context.c2.es, "script_type", "client-connect");
>  
> -        dc_file = platform_create_temp_file(mi->context.options.tmp_dir,
> -                                            "cc", &gc);
> -        if (!dc_file)
> +        if (!ccs_gen_config_file(mi)
> +            || !ccs_gen_deferred_ret_file(mi))
>          {
>              ret = CC_RET_FAILED;
>              goto cleanup;
>          }
>  
>          argv_parse_cmd(&argv, mi->context.options.client_connect_script);
> -        argv_printf_cat(&argv, "%s", dc_file);
> +        argv_printf_cat(&argv, "%s", ccs->config_file);
>  
>          if (openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-connect"))
>          {
> -            multi_client_connect_post(m, mi, dc_file, option_types_found);
> -            ret = CC_RET_SUCCEEDED;
> +            if (ccs_test_deferred_ret_file(mi) == CC_RET_DEFERRED)
> +            {
> +                ret = CC_RET_DEFERRED;
> +            }
> +            else
> +            {
> +                multi_client_connect_post(m, mi, ccs->config_file,
> +                                          option_types_found);
> +                ret = CC_RET_SUCCEEDED;
> +            }
>          }
>          else
>          {
>              ret = CC_RET_FAILED;
>          }
> -
> -        if (!platform_unlink(dc_file))
> +cleanup:
> +        if (ret != CC_RET_DEFERRED)
>          {
> -            msg(D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
> -                dc_file);
> +            ccs_delete_config_file(mi);
> +            ccs_delete_deferred_ret_file(mi);
>          }
> -cleanup:
>          argv_free(&argv);
>          gc_free(&gc);
>      }
>      return ret;
>  }
>  
> +static enum client_connect_return
> +multi_client_connect_script_deferred(struct multi_context *m,
> +                                     struct multi_instance *mi,
> +                                     unsigned int *option_types_found)
> +{
> +    ASSERT(mi);
> +    ASSERT(option_types_found);
> +    struct client_connect_defer_state *ccs = &(mi->client_connect_defer_state);

parenthesis are not needed

> +    enum client_connect_return ret = CC_RET_SKIPPED;
> +
> +    ret = ccs_test_deferred_ret_file(mi);
> +
> +    if (ret == CC_RET_SKIPPED)
> +    {
> +        /*
> +         * Skipped and deferred are equivalent in this context.
> +         * skipped means that the called program has not yet
> +         * written a return status implicitly needing more time
> +         * while deferred is the explicit notifcation that it

typ0: notification

> +         * needs more time
> +         */
> +        ret = CC_RET_DEFERRED;

The comment above made me wonder..What happens if he client-connect
script will never write to file due to a bug or a crash or anything?



> +    }
> +
> +    if (ret != CC_RET_DEFERRED)
> +    {
> +        ccs_delete_deferred_ret_file(mi);
> +        multi_client_connect_post(m, mi, ccs->config_file,
> +                                  option_types_found);
> +        ccs_delete_config_file(mi);
> +    }
> +    return ret;
> +}
> +
>  /**
>   * Generates the data channel keys
>   */
> @@ -2251,7 +2451,7 @@ static const struct client_connect_handlers client_connect_handlers[] = {
>      },
>      {
>          .main = multi_client_connect_call_script,
> -        .deferred = multi_client_connect_fail
> +        .deferred = multi_client_connect_script_deferred
>      },
>      {
>          .main = multi_client_connect_mda,
> diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
> index 11da0209..3ebf6b9f 100644
> --- a/src/openvpn/multi.h
> +++ b/src/openvpn/multi.h
> @@ -73,6 +73,18 @@ struct client_connect_defer_state
>      /* Remember which option classes where processed for delayed option
>       * handling. */
>      unsigned int option_types_found;
> +
> +    /**
> +     * The temporrary file name that contains the return status of the

typ0: temporary

> +     * client-connect script if it exits with defer as status
> +     */
> +    char *deferred_ret_file;
> +
> +    /**
> +     * The temporary file name that contains the config directives
> +     * returned by the client-connect script
> +     */
> +    char *config_file;
>  };
>  
>  /**
> 


The patch looks good. My only concern is reported above and is not
really about this patch, but about the way the deferred handler is designed.

-- 
Antonio Quartulli

