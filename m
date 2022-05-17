Message-ID: <baa46ee9-7b4a-1a5c-d38f-4359e5d5f814@...2181...>
Date: Tue, 17 May 2022 15:28:56 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220516185621.6182-1-kprovost@...2661...>
 <20220516185621.6182-3-kprovost@...2661...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220516185621.6182-3-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] rework do_up() for correct order of
 DCO operations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 16/05/2022 20:56, Kristof Provost via Openvpn-devel wrote:
> From: Kristof Provost <kp@...1376...>
> 
> We must create the peer before we can dco_set_peer or dco_new_key.
> On the other hand, we must first process options, because those may
> change our peer id and we should create the peer with the correct id.
> 
> Split up do_deferred_options() in do_deferred_options() and
> finish_options(). Call any DCO configuration operations (i.e.
> dco_set_peer()/dco_new_key()) after we've created the peer (i.e.
> dco_new_peer()).
> 
> Signed-off-by: Kristof Provost <kprovost@...2661...>

I am including this patch in the dco branch as well.

Please note that this change has been reworked a little bit.

Regards,

> ---
>   src/openvpn/init.c  | 112 +++++++++++++++++++++++++-------------------
>   src/openvpn/init.h  |   2 +
>   src/openvpn/multi.c |   2 +
>   3 files changed, 68 insertions(+), 48 deletions(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index a6c93038..0d991ba4 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2093,26 +2093,26 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
>               }
>           }
>   
> -        if ((c->mode == MODE_POINT_TO_POINT) && c->c2.did_open_tun)
> +        if (pulled_options)
>           {
> -            /* ovpn-dco requires adding the peer now, before any option can be set */
> -            int ret = dco_p2p_add_new_peer(c);
> -            if (ret < 0)
> +            if (!do_deferred_options(c, option_types_found))
>               {
> -                msg(D_DCO, "Cannot add peer to DCO: %s", strerror(-ret));
> +                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options");
>                   return false;
>               }
>           }
> -
> -        if (pulled_options)
> +        if (c->mode == MODE_POINT_TO_POINT)
>           {
> -            if (!do_deferred_options(c, option_types_found))
> +            /* ovpn-dco requires adding the peer now, before any option can be set */
> +            int ret = dco_p2p_add_new_peer(c);
> +            if (ret < 0)
>               {
> -                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options");
> +                msg(D_DCO, "Cannot add peer to DCO: %s", strerror(-ret));
>                   return false;
>               }
>           }
> -        else if (c->mode == MODE_POINT_TO_POINT)
> +
> +        if (!pulled_options && c->mode == MODE_POINT_TO_POINT)
>           {
>               if (!do_deferred_p2p_ncp(c))
>               {
> @@ -2121,6 +2121,13 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
>               }
>           }
>   
> +
> +        if (!finish_options(c))
> +        {
> +            msg(D_TLS_ERRORS, "ERROR: Failed to finish option processing");
> +            return false;
> +        }
> +
>           if (c->c2.did_open_tun)
>           {
>               c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
> @@ -2337,49 +2344,58 @@ do_deferred_options(struct context *c, const unsigned int found)
>           {
>               return false;
>           }
> -        struct frame *frame_fragment = NULL;
> +    }
> +
> +    return true;
> +}
> +
> +bool
> +finish_options(struct context *c)
> +{
> +    if (!c->options.pull || !dco_enabled(&c->options))
> +    {
> +        return true;
> +    }
> +
> +    struct frame *frame_fragment = NULL;
>   #ifdef ENABLE_FRAGMENT
> -        if (c->options.ce.fragment)
> -        {
> -            frame_fragment = &c->c2.frame_fragment;
> -        }
> +    if (c->options.ce.fragment)
> +    {
> +        frame_fragment = &c->c2.frame_fragment;
> +    }
>   #endif
>   
> -        struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
> -        if (!tls_session_update_crypto_params(c->c2.tls_multi, session,
> -                                              &c->options, &c->c2.frame,
> -                                              frame_fragment,
> -                                              get_link_socket_info(c)))
> -        {
> -            msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
> -            return false;
> -        }
> +    struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
> +    if (!tls_session_update_crypto_params(c->c2.tls_multi, session,
> +                                          &c->options, &c->c2.frame,
> +                                          frame_fragment,
> +                                          get_link_socket_info(c)))
> +    {
> +        msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
> +        return false;
> +    }
>   
> -        if (dco_enabled(&c->options))
> -        {
> -            /* Check if the pushed options are compatible with DCO if we have
> -             * DCO enabled */
> -            if (!check_dco_pull_options(&c->options))
> -            {
> -                msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are incompatible with "
> -                    "data channel offload. Use --disable-dco to connect"
> -                    "to this server");
> -                return false;
> -            }
> +    /* Check if the pushed options are compatible with DCO if we have
> +     * DCO enabled */
> +    if (!check_dco_pull_options(&c->options))
> +    {
> +        msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are incompatible with "
> +            "data channel offload. Use --disable-dco to connect"
> +            "to this server");
> +        return false;
> +    }
>   
> -            if (c->options.ping_send_timeout || c->c2.frame.mss_fix)
> -            {
> -                int ret = dco_set_peer(&c->c1.tuntap->dco,
> -                                       c->c2.tls_multi->peer_id,
> -                                       c->options.ping_send_timeout,
> -                                       c->options.ping_rec_timeout,
> -                                       c->c2.frame.mss_fix);
> -                if (ret < 0)
> -                {
> -                    msg(D_DCO, "Cannot set DCO peer: %s", strerror(-ret));
> -                    return false;
> -                }
> -            }
> +    if (c->options.ping_send_timeout || c->c2.frame.mss_fix)
> +    {
> +        int ret = dco_set_peer(&c->c1.tuntap->dco,
> +                               c->c2.tls_multi->peer_id,
> +                               c->options.ping_send_timeout,
> +                               c->options.ping_rec_timeout,
> +                               c->c2.frame.mss_fix);
> +        if (ret < 0)
> +        {
> +            msg(D_DCO, "Cannot set DCO peer: %s", strerror(-ret));
> +            return false;
>           }
>       }
>       return true;
> diff --git a/src/openvpn/init.h b/src/openvpn/init.h
> index 1c341da3..5cc2a990 100644
> --- a/src/openvpn/init.h
> +++ b/src/openvpn/init.h
> @@ -97,6 +97,8 @@ void reset_coarse_timers(struct context *c);
>   
>   bool do_deferred_options(struct context *c, const unsigned int found);
>   
> +bool finish_options(struct context *c);
> +
>   void inherit_context_child(struct context *dest,
>                              const struct context *src);
>   
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 958712f1..47e1c6cc 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2452,6 +2452,8 @@ multi_client_connect_late_setup(struct multi_context *m,
>           mi->context.c2.tls_multi->multi_state = CAS_FAILED;
>       }
>   
> +    finish_options(&mi->context);
> +
>       /* send push reply if ready */
>       if (mi->context.c2.push_request_received)
>       {

-- 
Antonio Quartulli

