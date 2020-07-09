References: <20200709101603.11941-1-arne@...1227...>
 <20200709101603.11941-4-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <6f7edd49-c45d-0d95-d955-7527e363c4f8@...277...>
Date: Thu, 9 Jul 2020 15:20:43 +0100
MIME-Version: 1.0
In-Reply-To: <20200709101603.11941-4-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 4/8] Move protocol option negotiation
 from push_prepare to new function
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

typo

On 09/07/2020 11:15, Arne Schwabe wrote:
> This clean ups the code and removes the surprising side effects
> of preparing a push reply to also select protocol options.
> 
> We also remember if we have seen a push request without async
> push. This improves reaction time if deferred auth is involved
> like managment interface deferred auth.  The other benefit is
> removing a number of ifdefs.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/forward.c |  4 +--
>   src/openvpn/multi.c   | 81 ++++++++++++++++++++++++++++++++++++++++---
>   src/openvpn/openvpn.h |  2 --
>   src/openvpn/push.c    | 66 +++++------------------------------
>   4 files changed, 88 insertions(+), 65 deletions(-)
> 
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 885cf126..5c4370a8 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1123,8 +1123,8 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
>           }
>   
>           /*
> -         * Drop non-TLS packet if client-connect script/plugin has not
> -         * yet succeeded.
> +         * Drop non-TLS packet if client-connect script/plugin and cipher selection
> +         * has not yet succeeded.
>            */
>           if (c->c2.context_auth != CAS_SUCCEEDED)
>           {
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index f1332c8d..f04c4c90 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -824,8 +824,8 @@ multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
>       mi->did_cid_hash = true;
>   #endif
>   
> -#ifdef ENABLE_ASYNC_PUSH
>       mi->context.c2.push_request_received = false;
> +#ifdef ENABLE_ASYNC_PUSH
>       mi->inotify_watch = -1;
>   #endif
>   
> @@ -1772,6 +1772,78 @@ multi_client_connect_setenv(struct multi_context *m,
>       gc_free(&gc);
>   }
>   
> +/**
> + * Calculates the options that depend on the client capabilities
> + * based on local options and available peer info
> + * - choosen cipher
> + * - peer id
> + */
> +static void
> +multi_client_set_protocol_options(struct context *c)
> +{
> +
> +    const char *optstr = NULL;
> +    struct tls_multi *tls_multi = c->c2.tls_multi;
> +    const char *const peer_info = tls_multi->peer_info;
> +    struct options *o = &c->options;
> +
> +    /* Send peer-id if client supports it */
> +    optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
> +    if (optstr)
> +    {
> +        int proto = 0;
> +        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
> +        if ((r == 1) && (proto >= 2))
> +        {
> +            tls_multi->use_peer_id = true;
> +        }
> +    }
> +
> +    /* Select cipher if client supports Negotiable Crypto Parameters */
> +    if (o->ncp_enabled)
> +    {
> +        /* if we have already created our key, we cannot *change* our own
> +         * cipher -> so log the fact and push the "what we have now" cipher
> +         * (so the client is always told what we expect it to use)
> +         */
> +        const struct tls_session *session = &tls_multi->session[TM_ACTIVE];
> +        if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
> +        {
> +            msg( M_INFO, "PUSH: client wants to negotiate cipher (NCP), but "
> +                 "server has already generated data channel keys, "
> +                 "re-sending previously negotiated cipher '%s'",
> +                 o->ciphername );
> +        }
> +        else
> +        {
> +            /*
> +             * Push the first cipher from --ncp-ciphers to the client that
> +             * the client announces to be supporting.
> +             */
> +            char *push_cipher = ncp_get_best_cipher(o->ncp_ciphers, o->ciphername,
> +                                                    peer_info,
> +                                                    tls_multi->remote_ciphername,
> +                                                    &o->gc);
> +
> +            if (push_cipher)
> +            {
> +                o->ciphername = push_cipher;
> +            }
> +            else
> +            {
> +                struct gc_arena gc = gc_new();
> +                const char *peer_ciphers = tls_peer_ncp_list(peer_info, &gc);
> +                msg(M_INFO, "PUSH: No common cipher between server and client."
> +                    "Expect this connection not to work. "
> +                    "Server ncp-ciphers: '%s', client supported ciphers '%s'",
> +                    o->ncp_ciphers, peer_ciphers);
> +                gc_free(&gc);
> +            }
> +        }
> +    }
> +}
> +
> +
>   /*
>    * Called as soon as the SSL/TLS connection authenticates.
>    *
> @@ -2074,13 +2146,14 @@ script_failed:
>           /* set context-level authentication flag */
>           mi->context.c2.context_auth = CAS_SUCCEEDED;
>   
> -#ifdef ENABLE_ASYNC_PUSH
> -        /* authentication complete, send push reply */
> +        /* authentication complete, calculate dynamic client specific options */
> +        multi_client_set_protocol_options(&mi->context);
> +
> +        /* send push reply if ready*/
>           if (mi->context.c2.push_request_received)
>           {
>               process_incoming_push_request(&mi->context);
>           }
> -#endif
>       }
>       else
>       {
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index 4609af3e..a1308852 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -432,9 +432,7 @@ struct context_2
>   #if P2MP
>   
>       /* --ifconfig endpoints to be pushed to client */
> -#ifdef ENABLE_ASYNC_PUSH
>       bool push_request_received;
> -#endif
>       bool push_ifconfig_defined;
>       time_t sent_push_reply_expiry;
>       in_addr_t push_ifconfig_local;
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index d74323db..92a28a14 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -437,7 +437,7 @@ prepare_auth_token_push_reply(struct tls_multi *tls_multi, struct gc_arena *gc,
>   }
>   
>   /**
> - * Prepare push options, based on local options and available peer info.
> + * Prepare push options, based on local options
>    *
>    * @param context       context structure storing data for VPN tunnel
>    * @param gc            gc arena for allocating push options
> @@ -449,9 +449,7 @@ bool
>   prepare_push_reply(struct context *c, struct gc_arena *gc,
>                      struct push_list *push_list)
>   {
> -    const char *optstr = NULL;
>       struct tls_multi *tls_multi = c->c2.tls_multi;
> -    const char *const peer_info = tls_multi->peer_info;
>       struct options *o = &c->options;
>   
>       /* ipv6 */
> @@ -480,18 +478,10 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
>                                           0, gc));
>       }
>   
> -    /* Send peer-id if client supports it */
> -    optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
> -    if (optstr)
> +    if (tls_multi->use_peer_id)
>       {
> -        int proto = 0;
> -        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
> -        if ((r == 1) && (proto >= 2))
> -        {
> -            push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
> -                            tls_multi->peer_id);
> -            tls_multi->use_peer_id = true;
> -        }
> +        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
> +                        tls_multi->peer_id);
>       }
>       /*
>        * If server uses --auth-gen-token and we have an auth token
> @@ -499,47 +489,11 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
>        */
>       prepare_auth_token_push_reply(tls_multi, gc, push_list);
>   
> -    /* Push cipher if client supports Negotiable Crypto Parameters */
> -    if (o->ncp_enabled)
> -    {
> -        /* if we have already created our key, we cannot *change* our own
> -         * cipher -> so log the fact and push the "what we have now" cipher
> -         * (so the client is always told what we expect it to use)
> -         */
> -        const struct tls_session *session = &tls_multi->session[TM_ACTIVE];
> -        if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
> -        {
> -            msg( M_INFO, "PUSH: client wants to negotiate cipher (NCP), but "
> -                 "server has already generated data channel keys, "
> -                 "re-sending previously negotiated cipher '%s'",
> -                 o->ciphername );
> -        }
> -        else
> -        {
> -            /*
> -             * Push the first cipher from --ncp-ciphers to the client that
> -             * the client announces to be supporting.
> -             */
> -            char *push_cipher = ncp_get_best_cipher(o->ncp_ciphers, o->ciphername,
> -                                                    peer_info,
> -                                                    tls_multi->remote_ciphername,
> -                                                    &o->gc);
> -
> -            if (push_cipher)
> -            {
> -                o->ciphername = push_cipher;
> -            }
> -            else
> -            {
> -                const char *peer_ciphers = tls_peer_ncp_list(peer_info, gc);
> -                msg(M_INFO, "PUSH: No common cipher between server and client."
> -                    "Expect this connection not to work. "
> -                    "Server ncp-ciphers: '%s', client supported ciphers '%s'",
> -                    o->ncp_ciphers, peer_ciphers);
> -            }
> -        }
> -        push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
> -    }
> +    /*
> +     * Push the selected cipher, at this point the cipher has been
> +     * already negioated and been fixed

another negioated



> +     */
> +    push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
>   
>       return true;
>   }
> @@ -794,9 +748,7 @@ process_incoming_push_request(struct context *c)
>   {
>       int ret = PUSH_MSG_ERROR;
>   
> -#ifdef ENABLE_ASYNC_PUSH
>       c->c2.push_request_received = true;
> -#endif
>       if (tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED || c->c2.context_auth == CAS_FAILED)
>       {
>           const char *client_reason = tls_client_reason(c->c2.tls_multi);
> 

