References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-8-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <e8b34428-f49f-5635-7645-e155a613f5fd@...277...>
Date: Mon, 13 Jul 2020 14:02:38 +0100
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-8-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v5 08/14] client-connect: Add
 CC_RET_DEFERRED and cope with deferred client-connect
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

1x typo + 1x gram (in comments)

On 11/07/2020 10:36, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
> 
> This patch moves the state, that was previously tracked within the
> multi_connection_established() function, into struct client_connect_state.  The
> multi_connection_established() function can now be exited and re-entered as
> many times as necessary - without losing the client-connect handling state.
> 
> The patch also adds the new return value CC_RET_DEFERRED which indicates that
> the handler couldn't complete immediately, and needs to be called later.  At
> that point multi_connection_established() will exit without indicating
> completion.
> 
> Each client-connect handler now has an (optional) additional call-back:  The
> call-back for handling the deferred case.  If the main call-back returns
> CC_RET_DEFERRED, the next call to the handler will be through the deferred
> call-back.
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> 
> Patch V3: Use a static struct in multi_instance instead of using
>            malloc/free and use two states (deffered with and without

deffered -> deferred


>            result) instead of one to eliminate the counter that was
>            only tested for > 0.
> 
> Patch V5: Use new states in context_auth instead of the extra state
>            that the patch series previously used.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/multi.c   | 171 +++++++++++++++++++++++++++++++-----------
>   src/openvpn/multi.h   |  15 +++-
>   src/openvpn/openvpn.h |   9 +++
>   3 files changed, 150 insertions(+), 45 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index f9b8af80..ce73f8a1 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2218,32 +2218,51 @@ multi_client_connect_source_ccd(struct multi_context *m,
>       return ret;
>   }
>   
> -static inline bool
> -cc_check_return(int *cc_succeeded_count,
> -                enum client_connect_return ret)
> +typedef enum client_connect_return (*multi_client_connect_handler)
> +    (struct multi_context *m, struct multi_instance *mi,
> +    unsigned int *option_types_found);
> +
> +struct client_connect_handlers
> +{
> +    multi_client_connect_handler main;
> +    multi_client_connect_handler deferred;
> +};
> +
> +static enum client_connect_return
> +multi_client_connect_fail(struct multi_context *m, struct multi_instance *mi,
> +                          unsigned int *option_types_found)
>   {
> -    if (ret == CC_RET_SUCCEEDED)
> +    /* Called null call-back.  This should never happen. */
> +    return CC_RET_FAILED;
> +}
> +
> +static const struct client_connect_handlers client_connect_handlers[] = {
>       {
> -        (*cc_succeeded_count)++;
> -        return true;
> -    }
> -    else if (ret == CC_RET_FAILED)
> +        .main = multi_client_connect_source_ccd,
> +        .deferred = multi_client_connect_fail
> +    },
>       {
> -        return false;
> -    }
> -    else if (ret == CC_RET_SKIPPED)
> +        .main = multi_client_connect_call_plugin_v1,
> +        .deferred = multi_client_connect_fail
> +    },
>       {
> -        return true;
> -    }
> -    else
> +        .main = multi_client_connect_call_plugin_v2,
> +        .deferred = multi_client_connect_fail
> +    },
> +    {
> +        .main = multi_client_connect_call_script,
> +        .deferred = multi_client_connect_fail
> +    },
>       {
> -        ASSERT(0);
> +        .main = multi_client_connect_mda,
> +        .deferred = multi_client_connect_fail
> +    },
> +    {
> +        .main = NULL,
> +        .deferred = NULL
> +                    /* End of list sentinel.  */
>       }
> -}
> -
> -typedef enum client_connect_return (*multi_client_connect_handler)
> -    (struct multi_context *m, struct multi_instance *mi,
> -     unsigned int *option_types_found);
> +};
>   
>   /*
>    * Called as soon as the SSL/TLS connection is authenticated.
> @@ -2273,27 +2292,83 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>           return;
>       }
>   
> -        multi_client_connect_handler handlers[] = {
> -            multi_client_connect_source_ccd,
> -            multi_client_connect_call_plugin_v1,
> -            multi_client_connect_call_plugin_v2,
> -            multi_client_connect_call_script,
> -            multi_client_connect_mda,
> -            NULL
> -        };
> -
> -        unsigned int option_types_found = 0;
> +    /* We are only called for the CAS_PENDING_x states, so we
> +     * can ignore other states here */
> +    bool from_deferred = (mi->context.c2.context_auth != CAS_PENDING);
>   
> -    int cc_succeeded = true; /* client connect script status */
> -    int cc_succeeded_count = 0;
>       enum client_connect_return ret;
>   
> -    multi_client_connect_early_setup(m, mi);
> +    struct client_connect_defer_state *defer_state =
> +        &(mi->client_connect_defer_state);
>   
> -    for (int i = 0; cc_succeeded && handlers[i]; i++)
> +    /* We are called for the first time */
> +    if (!from_deferred)
>       {
> -        ret = handlers[i](m, mi, &option_types_found);
> -        cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
> +        defer_state->cur_handler_index = 0;
> +        defer_state->option_types_found = 0;
> +        /* Initially we have no handler that has returned a result */
> +        mi->context.c2.context_auth = CAS_PENDING_DEFERRED;
> +
> +        multi_client_connect_early_setup(m, mi);
> +    }
> +
> +    bool cc_succeeded = true;
> +
> +    while (cc_succeeded
> +           && client_connect_handlers[defer_state->cur_handler_index]
> +           .main != NULL)
> +    {
> +        multi_client_connect_handler handler;
> +        if (from_deferred)
> +        {
> +            handler = client_connect_handlers
> +                      [defer_state->cur_handler_index].deferred;
> +            from_deferred = false;
> +        }
> +        else
> +        {
> +            handler = client_connect_handlers
> +                      [defer_state->cur_handler_index].main;
> +        }
> +
> +        ret = handler(m, mi, &(defer_state->option_types_found));
> +        if (ret == CC_RET_SUCCEEDED)
> +        {
> +            /*
> +             * Remember that we already had at least one handler
> +             * returning a result should go to into deferred state

Grammar:
returning a result, so we should go into a deferred state

(My guess)

> +             */
> +            mi->context.c2.context_auth = CAS_PENDING_DEFERRED_PARTIAL;
> +        }
> +        else if (ret == CC_RET_SKIPPED)
> +        {
> +            /*
> +             * Move on with the next handler without modifying any
> +             * other state
> +             */
> +        }
> +        else if (ret == CC_RET_DEFERRED)
> +        {
> +            /*
> +             * we already set client_connect_status to DEFERRED_RESULT or
> +             * DEFERRED_NO_RESULT and increased index. We just return
> +             * from the function as having client_connect_status
> +             */
> +            return;
> +        }
> +        else if (ret == CC_RET_FAILED)
> +        {
> +            /*
> +             * One handler failed. We abort the chain and set the final
> +             * result to failed
> +             */
> +            cc_succeeded = false;
> +        }
> +        else
> +        {
> +            ASSERT(0);
> +        }
> +        (defer_state->cur_handler_index)++;
>       }
>   
>       /*
> @@ -2305,18 +2380,26 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>           msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to "
>               "'disable' directive");
>           cc_succeeded = false;
> -        cc_succeeded_count = 0;
>       }
>   
>       if (cc_succeeded)
>       {
> -        multi_client_connect_late_setup(m, mi, option_types_found);
> +        multi_client_connect_late_setup(m, mi,
> +                                        defer_state->option_types_found);
>       }
>       else
>       {
> -        /* set context-level authentication flag */
> -        mi->context.c2.context_auth =
> -            cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
> +        /* set context-level authentication flag to failed but remember
> +         * if had a handler succeed (for cleanup) */
> +        if (mi->context.c2.context_auth == CAS_PENDING_DEFERRED_PARTIAL)
> +        {
> +            mi->context.c2.context_auth = CAS_PARTIAL;
> +        }
> +        else
> +        {
> +            mi->context.c2.context_auth = CAS_FAILED;
> +        }
> +
>       }
>   
>       /* increment number of current authenticated clients */
> @@ -2604,7 +2687,7 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
>           {
>               /* connection is "established" when SSL/TLS key negotiation succeeds
>                * and (if specified) auth user/pass succeeds */
> -            if (mi->context.c2.context_auth == CAS_PENDING
> +            if (is_cas_pending(mi->context.c2.context_auth)
>                   && CONNECTION_ESTABLISHED(&mi->context))
>               {
>                   multi_connection_established(m, mi);
> @@ -3559,7 +3642,7 @@ management_client_auth(void *arg,
>           {
>               if (auth)
>               {
> -                if (mi->context.c2.context_auth == CAS_PENDING)
> +                if (is_cas_pending(mi->context.c2.context_auth))
>                   {
>                       set_cc_config(mi, cc_config);
>                       cc_config_owned = false;
> @@ -3571,7 +3654,7 @@ management_client_auth(void *arg,
>                   {
>                       msg(D_MULTI_LOW, "MULTI: connection rejected: %s, CLI:%s", reason, np(client_reason));
>                   }
> -                if (mi->context.c2.context_auth != CAS_PENDING)
> +                if (!is_cas_pending(mi->context.c2.context_auth))
>                   {
>                       send_auth_failed(&mi->context, client_reason); /* mid-session reauth failed */
>                       multi_schedule_context_wakeup(m, mi);
> diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
> index 1d30dcc6..11da0209 100644
> --- a/src/openvpn/multi.h
> +++ b/src/openvpn/multi.h
> @@ -62,6 +62,18 @@ struct deferred_signal_schedule_entry
>       struct timeval wakeup;
>   };
>   
> +/**
> + * Detached client connection state.  This is the state that is tracked while
> + * the client connect hooks are executed.
> + */
> +struct client_connect_defer_state
> +{
> +    /* Index of currently executed handler.  */
> +    int cur_handler_index;
> +    /* Remember which option classes where processed for delayed option
> +     * handling. */
> +    unsigned int option_types_found;
> +};
>   
>   /**
>    * Server-mode state structure for one single VPN tunnel.
> @@ -108,7 +120,7 @@ struct multi_instance {
>   
>       struct context context;     /**< The context structure storing state
>                                    *   for this VPN tunnel. */
> -
> +    struct client_connect_defer_state client_connect_defer_state;
>   #ifdef ENABLE_ASYNC_PUSH
>       int inotify_watch; /* watch descriptor for acf */
>   #endif
> @@ -195,6 +207,7 @@ enum client_connect_return
>   {
>       CC_RET_FAILED,
>       CC_RET_SUCCEEDED,
> +    CC_RET_DEFERRED,
>       CC_RET_SKIPPED
>   };
>   
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index 7c469b01..ccc7f118 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -217,6 +217,8 @@ struct context_1
>   enum client_connect_status {
>       CAS_SUCCEEDED=0,
>       CAS_PENDING,
> +    CAS_PENDING_DEFERRED,
> +    CAS_PENDING_DEFERRED_PARTIAL,   /**< at least handler succeeded, no result yet*/
>       CAS_FAILED,
>       CAS_PARTIAL,        /**< Variant of CAS_FAILED: at least one
>                            * client-connect script/plugin succeeded
> @@ -225,6 +227,13 @@ enum client_connect_status {
>                            */
>   };
>   
> +static inline bool
> +is_cas_pending(enum client_connect_status cas)
> +{
> +    return cas == CAS_PENDING || cas == CAS_PENDING_DEFERRED
> +           || cas == CAS_PENDING_DEFERRED_PARTIAL;
> +}
> +
>   /**
>    * Level 2 %context containing state that is reset on both \c SIGHUP and
>    * \c SIGUSR1 restarts.
> 

