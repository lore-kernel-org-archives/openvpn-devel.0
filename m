References: <20200709101603.11941-1-arne@...1227...>
 <20200709101603.11941-5-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <45ad2fe9-84b3-e1bc-fe9a-9f414a2f6eae@...277...>
Date: Thu, 9 Jul 2020 15:58:14 +0100
MIME-Version: 1.0
In-Reply-To: <20200709101603.11941-5-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 5/8] Generate data channel keys after
 connect options have been parsed
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

possible white-space error ?

On 09/07/2020 11:16, Arne Schwabe wrote:
> The simplify the control flow, it makes more sense to generate the
> data keys when all the prerequisites for generating the data channel
> keys (ncp cipher selection etc) are met instead of delaying it to the
> next incoming PUSH_REQUEST message.
> 
> This also eliminates the need for the hack introduced by commit
> 3b06b57d9 to generate the data channel keys on the async file close
> event.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/multi.c | 54 ++++++++++++++++++++++++++-------------------
>   src/openvpn/push.c  | 27 ++++-------------------
>   2 files changed, 35 insertions(+), 46 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index f04c4c90..810e489a 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1843,6 +1843,30 @@ multi_client_set_protocol_options(struct context *c)
>       }
>   }
>   
> +/**
> + * Generates the data channel keys
> + */
> +static bool
> +multi_client_generate_tls_keys(struct context *c)
> +{
> +    struct frame *frame_fragment = NULL;
> +#ifdef ENABLE_FRAGMENT
> +    if (c->options.ce.fragment)
> +    {
> +        frame_fragment = &c->c2.frame_fragment;
> +    }
> +#endif
> +    struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
> +    if (!tls_session_update_crypto_params(session, &c->options,
> +                                          &c->c2.frame, frame_fragment))
> +    {
> +        msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
> +        register_signal(c, SIGUSR1, "process-push-msg-failed");
> +        return false;
> +    }
> +
> +    return true;
> +}
>   
>   /*
>    * Called as soon as the SSL/TLS connection authenticates.
> @@ -2149,7 +2173,13 @@ script_failed:
>           /* authentication complete, calculate dynamic client specific options */
>           multi_client_set_protocol_options(&mi->context);
>   
> -        /* send push reply if ready*/
> +        /* Generate data channel keys */
> +        if (!multi_client_generate_tls_keys(&mi->context))
> +        {
> +            mi->context.c2.context_auth = CAS_FAILED;
> +        }
> +
> +        /* send push reply if ready */
>           if (mi->context.c2.push_request_received)
>           {
>               process_incoming_push_request(&mi->context);
> @@ -2205,28 +2235,6 @@ multi_process_file_closed(struct multi_context *m, const unsigned int mpp_flags)
>               {
>                   /* continue authentication, perform NCP negotiation and send push_reply */
>                   multi_process_post(m, mi, mpp_flags);
> -
> -                /* With NCP and deferred authentication, we perform cipher negotiation and
> -                 * data channel keys generation on incoming push request, assuming that auth
> -                 * succeeded. When auth succeeds in between push requests and async push is used,
> -                 * we send push reply immediately. Above multi_process_post() call performs
> -                 * NCP negotiation and here we do keys generation. */
> -
> -                struct context *c = &mi->context;
> -                struct frame *frame_fragment = NULL;
> -#ifdef ENABLE_FRAGMENT
> -                if (c->options.ce.fragment)
> -                {
> -                    frame_fragment = &c->c2.frame_fragment;
> -                }
> -#endif
> -                struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
> -                if (!tls_session_update_crypto_params(session, &c->options,
> -                                                      &c->c2.frame, frame_fragment))
> -                {
> -                    msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
> -                    register_signal(c, SIGUSR1, "init-data-channel-failed");
> -                }
>               }
>               else
>               {
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 92a28a14..5bc4328c 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -359,30 +359,11 @@ incoming_push_message(struct context *c, const struct buffer *buffer)
>           }
>           event_timeout_clear(&c->c2.push_request_interval);
>       }
> -    else if (status == PUSH_MSG_REQUEST)
> -    {
> -        if (c->options.mode == MODE_SERVER)
> -        {
> -            struct frame *frame_fragment = NULL;
> -#ifdef ENABLE_FRAGMENT
> -            if (c->options.ce.fragment)
> -            {
> -                frame_fragment = &c->c2.frame_fragment;
> -            }
> -#endif
> -            struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
> -            if (!tls_session_update_crypto_params(session, &c->options,
> -                                                  &c->c2.frame, frame_fragment))
> -            {
> -                msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
> -                goto error;
> -            }
> -        }
> -    }
>   
>       goto cleanup;
> +
>   error:
> -    register_signal(c, SIGUSR1, "process-push-msg-failed");
> +  register_signal(c, SIGUSR1, "process-push-msg-failed");

White-space ? just making a note of it


>   cleanup:
>       gc_free(&gc);
>   }
> @@ -748,7 +729,6 @@ process_incoming_push_request(struct context *c)
>   {
>       int ret = PUSH_MSG_ERROR;
>   
> -    c->c2.push_request_received = true;
>       if (tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED || c->c2.context_auth == CAS_FAILED)
>       {
>           const char *client_reason = tls_client_reason(c->c2.tls_multi);
> @@ -810,7 +790,7 @@ push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct options *opt)
>   static int
>   process_incoming_push_reply(struct context *c,
>                               unsigned int permission_mask,
> -                            const unsigned int *option_types_found,
> +                            unsigned int *option_types_found,
>                               struct buffer *buf)
>   {
>       int ret = PUSH_MSG_ERROR;
> @@ -875,6 +855,7 @@ process_incoming_push_msg(struct context *c,
>   
>       if (buf_string_compare_advance(&buf, "PUSH_REQUEST"))
>       {
> +        c->c2.push_request_received = true;
>           return process_incoming_push_request(c);
>       }
>       else if (honor_received_options
> 

