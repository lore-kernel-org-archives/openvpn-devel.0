References: <CAL3L06G=w44OuBMUbV1YJSZ9vKb5oJOkwDbCMjPH3ALFSP+cXw@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e5815667-664b-e1ba-670f-a5c2d5eedce2@...2181...>
Date: Wed, 24 Jul 2019 13:46:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAL3L06G=w44OuBMUbV1YJSZ9vKb5oJOkwDbCMjPH3ALFSP+cXw@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/1] Start TLS after connection
 established without waiting.
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
To: Daniel Kaldor <daniel@...2518...>, openvpn-devel@lists.sourceforge.net

Hi,

this patch has been mangled by your e-mail client.

Could you please re-send it using git send-email?

Thanks a lot

On 24/07/2019 13:41, Daniel Kaldor wrote:
> There is a ~1s delay between establishing connection with remote
> server and starting TLS handshake.
> This change removes delay and improves connection time.
> 
> ---
>  src/openvpn/forward.c | 61 +++++++++++++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 35df089..2deaf93 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -433,28 +433,6 @@ check_connection_established_dowork(struct context *c)
>      {
>          if (CONNECTION_ESTABLISHED(c))
>          {
> -#if P2MP
> -            /* if --pull was specified, send a push request to server */
> -            if (c->c2.tls_multi && c->options.pull)
> -            {
> -#ifdef ENABLE_MANAGEMENT
> -                if (management)
> -                {
> -                    management_set_state(management,
> -                                         OPENVPN_STATE_GET_CONFIG,
> -                                         NULL,
> -                                         NULL,
> -                                         NULL,
> -                                         NULL,
> -                                         NULL);
> -                }
> -#endif
> -                /* fire up push request right away (already 1s delayed) */
> -                event_timeout_init(&c->c2.push_request_interval, 0, now);
> -                reset_coarse_timers(c);
> -            }
> -            else
> -#endif /* if P2MP */
>              {
>                  do_up(c, false, 0);
>              }
> @@ -1943,17 +1921,34 @@ pre_select(struct context *c)
>          }
>      }
>  #endif
> -
> -    /* check coarse timers? */
> -    check_coarse_timers(c);
> -    if (c->sig->signal_received)
> -    {
> -        return;
> -    }
> +
> +    bool pre_connection_state = CONNECTION_ESTABLISHED(c);
> 
>      /* Does TLS need service? */
>      check_tls(c);
> 
> +    bool post_connection_state = CONNECTION_ESTABLISHED(c);
> +
> +    if(!pre_connection_state && post_connection_state){
> +
> +        if (c->c2.tls_multi && c->options.pull)
> +        {
> +#ifdef ENABLE_MANAGEMENT
> +            if (management)
> +            {
> +                    management_set_state(management,
> +                                         OPENVPN_STATE_GET_CONFIG,
> +                                         NULL,
> +                                         NULL,
> +                                         NULL,
> +                                         NULL,
> +                                         NULL);
> +            }
> +#endif
> +            check_push_request_dowork(c);
> +        }
> +    }
> +
>      /* In certain cases, TLS errors will require a restart */
>      check_tls_errors(c);
>      if (c->sig->signal_received)
> @@ -1961,6 +1956,14 @@ pre_select(struct context *c)
>          return;
>      }
> 
> +    /* check coarse timers */
> +    check_coarse_timers(c);
> +    if (c->sig->signal_received)
> +    {
> +        return;
> +    }
> +
> +
>      /* check for incoming configuration info on the control channel */
>      check_incoming_control_channel(c);
> 
> --
> 2.9.3 (Apple Git-75)
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

