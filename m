References: <20210811095853.27870-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a5405877-04a5-8778-22fb-ea59b06773ee@...1227...>
Date: Fri, 27 Aug 2021 13:58:07 +0200
MIME-Version: 1.0
In-Reply-To: <20210811095853.27870-1-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Remove support for PF (Packet Filter)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net


> -}
> -
>  OPENVPN_EXPORT int
>  openvpn_plugin_func_v3(const int v3structver,
>                         struct openvpn_plugin_args_func_in const *args,
> @@ -496,21 +362,7 @@ openvpn_plugin_func_v3(const int v3structver,
>  
>          case OPENVPN_PLUGIN_TLS_FINAL:
>              plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_TLS_FINAL");
> -            return tls_final(context, pcc, argv, envp);
> -
> -        case OPENVPN_PLUGIN_ENABLE_PF:
> -            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_ENABLE_PF");
> -
> -            /* OpenVPN pre-creates the file, which gets in the way of
> -             * deferred pf setup - so remove it here, and re-create
> -             * it in the background handler (in tls_final()) when ready
> -             */
> -            const char *pff = get_env("pf_file", envp);
> -            if (pff)
> -            {
> -                (void) unlink(pff);
> -            }
> -            return OPENVPN_PLUGIN_FUNC_SUCCESS;           /* must succeed */
> +            return OPENVPN_PLUGIN_FUNC_SUCCESS;

This part looks incorrect as it changes the return of TLS_FINAL.




>  
> -#ifdef PLUGIN_PF
> -    if (c->c2.pf.enabled
> -        && event_timeout_trigger(&c->c2.pf.reload, &c->c2.timeval, ETT_DEFAULT))
> -    {
> -        pf_check_reload(c);
> -    }
> -#endif
>  

Removal here leaves 2 blank lines and should only leave one (remove one
more line)

>      /* process --route options */
>      if (event_timeout_trigger(&c->c2.route_wakeup, &c->c2.timeval, ETT_DEFAULT))
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 386aee23..0edb9391 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -4347,12 +4347,6 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
>      }
>  #endif
>  
> -#ifdef ENABLE_PF
> -    if (child)
> -    {
> -        pf_init_context(c);
> -    }
> -#endif

Same with the extra blank line.

>      /* Check for signals */
>      if (IS_SIG(c))
> @@ -4415,9 +4409,6 @@ close_instance(struct context *c)
>          }
>  #endif
>  
> -#ifdef ENABLE_PF
> -        pf_destroy_context(&c->c2.pf);
> -#endif

Here too.

> -        in_extra_reset(mc, IER_NEW);
> -    }
> -}
> -
> -#endif /* MANAGEMENT_PF */

Blank line again


>  static void
>  man_pk_sig(struct management *man, const char *cmd_name)
> @@ -1567,15 +1523,6 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
>              man_client_pending_auth(man, p[1], p[2], p[3]);
>          }
>      }
> -#ifdef MANAGEMENT_PF
> -    else if (streq(p[0], "client-pf"))
> -    {
> -        if (man_need(man, p, 1, 0))
> -        {
> -            man_client_pf(man, p[1]);
> -        }
> -    }
> -#endif
>      else if (streq(p[0], "rsa-sig"))
>      {
>          man_pk_sig(man, "rsa-sig");
> diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
> index 6d6f2fb1..82cad632 100644
> --- a/src/openvpn/manage.h
> +++ b/src/openvpn/manage.h
> @@ -176,11 +176,6 @@ struct management_callback
>                                   const char *extra,
>                                   unsigned int timeout);
>      char *(*get_peer_info) (void *arg, const unsigned long cid);
> -#ifdef MANAGEMENT_PF
> -    bool (*client_pf)(void *arg,
> -                      const unsigned long cid,
> -                      struct buffer_list *pf_config);  /* ownership transferred */
> -#endif
>      bool (*proxy_cmd)(void *arg, const char **p);
>      bool (*remote_cmd) (void *arg, const char **p);
>  #ifdef TARGET_ANDROID
> @@ -278,7 +273,7 @@ struct man_connection {
>  
>  #define IEC_UNDEF       0
>  #define IEC_CLIENT_AUTH 1
> -#define IEC_CLIENT_PF   2
> +//#define IEC_CLIENT_PF   2 *NOT IMPLEMENTED*

Use /* */ in OpenVPN 2.x. I think there are two instances that need
changing. I would also chagne *NOT IMPLEMENTED* to something like
(removed feature)

Otherwise the patch looks good.

Arne

