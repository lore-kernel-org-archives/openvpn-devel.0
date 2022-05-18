Date: Wed, 18 May 2022 12:21:23 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1392233370.1135321.1652869283040@...2642...>
In-Reply-To: <20220518093212.2802495-2-arne@...1227...>
References: <20220518093212.2802495-1-arne@...1227...>
 <20220518093212.2802495-2-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/4] Implement exit notification via
 control channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> Arne Schwabe <arne@...1227...> hat am 18.05.2022 11:32 geschrieben:
> Current exit notification relies on data channel messages with specific
> prefix. Adding these to new data channel modules (DCO) adds uncessary

"unnecessary"

> complexity for the data for messages that from their idea belong to the
> control channel anyway.
> 
> This patch adds announcing support for control channel and sending/receving
> it. We use the simple EXIT message for this.
[...] 
> diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
> index 8e0e4f18a..5a906895b 100644
> --- a/doc/man-sections/client-options.rst
> +++ b/doc/man-sections/client-options.rst
> @@ -220,9 +220,14 @@ configuration.
>    immediately close its client instance object rather than waiting for a
>    timeout.
>  
> +  If both server and client support sending this message using the control
> +  channel, the message will be sent as control-channel message. Otherwise
> +  the message is sent as data-channel message, which will be ignored by
> +  data-channel offloaded peers.
> +
>    The **n** parameter (default :code:`1` if not present) controls the
>    maximum number of attempts that the client will try to resend the exit
> -  notification message.
> +  notification message if messages are sent in data-channel mode.
>  
>    In UDP server mode, send :code:`RESTART` control channel command to
>    connected clients. The ``n`` parameter (default :code:`1` if not present)
> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index 98e2c7664..8219d2b76 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -264,6 +264,11 @@ struct crypto_options
>      /**< Bit-flag indicating that we do not allow clients that do
>       * not support resending the wrapped client key (WKc) with the
>       * third packet of the three-way handshake */
> +#define CO_USE_CC_EXIT_NOTIFY       (1<<6)
> +    /**< Bit-flag indicating that explicit exit notifies should be
> +     * send via the control channel instead of using an OCC message

"sent"

> +     */
> +
>      unsigned int flags;         /**< Bit-flags determining behavior of
>                                   *   security operation functions. */
>  };
[...]
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 9ff384d09..7913661c7 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -8338,6 +8338,20 @@ add_option(struct options *options,
>              msg(msglevel, "Unknown key-derivation method %s", p[1]);
>          }
>      }
> +    else if (streq(p[0], "protocol-flags") && p[1])

I find it a bit irritating that this patch doesn't add any documentation for
this new option. But we have other undocumented options, so I assume this
is considered fine for options the user is not supposed to set manually?

> +    {
> +        for (size_t j = 1; j < MAX_PARMS && p[j] != NULL; j++)
> +        {
> +            if (streq(p[j], "cc-exit"))
> +            {
> +                options->data_channel_crypto_flags |= CO_USE_CC_EXIT_NOTIFY;
> +            }
> +            else
> +            {
> +                msg(msglevel, "Unknown protocol-flags flag: %s", p[j]);
> +            }
> +        }
> +    }
>      else if (streq(p[0], "prng") && p[1] && !p[3])
>      {
>          msg(M_WARN, "NOTICE: --prng option ignored (SSL library PRNG is used)");
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 70fd1c3ce..51b8bd521 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -176,6 +176,21 @@ server_pushed_signal(struct context *c, const struct buffer *buffer, const bool
>      }
>  }
>  
> +void
> +receive_exit_message(struct context *c, const struct buffer *buffer)

buffer is not used, so we can probably remove it?

> +{
> +    dmsg(D_STREAM_ERRORS, "Exit message received by peer");
> +    c->sig->signal_received = SIGTERM;
> +    c->sig->signal_text = "remote-exit";
> +#ifdef ENABLE_MANAGEMENT
> +    if (management)
> +    {
> +        management_notify(management, "info", c->sig->signal_text, "EXIT");
> +    }
> +#endif
> +}
> +
> +
>  void
>  server_pushed_info(struct context *c, const struct buffer *buffer,
>                     const int adv)
[...]
> diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
> index e06edd216..1fc9c6dca 100644
> --- a/src/openvpn/sig.c
> +++ b/src/openvpn/sig.c
> @@ -321,20 +321,43 @@ print_status(const struct context *c, struct status_output *so)
>      gc_free(&gc);
>  }
>  
> +
> +/* Small helper function to determine if we should be sending exit notifcation

"should send" (not an error, just a simplification), "notification"

> + * via control channel */
> +static inline bool
> +cc_exit_notify_enabled(struct context *c)
> +{
> +    /* Check if we have TLS active at all */
> +    if (!c->c2.tls_multi)
> +    {
> +        return false;
> +    }
> +
> +    const struct key_state *ks = get_primary_key(c->c2.tls_multi);
> +    return (ks->crypto_options.flags & CO_USE_CC_EXIT_NOTIFY);
> +}
> +
>  /*
>   * Handle the triggering and time-wait of explicit
>   * exit notification.
>   */
> -
>  static void
>  process_explicit_exit_notification_init(struct context *c)
>  {
>      msg(M_INFO, "SIGTERM received, sending exit notification to peer");
>      event_timeout_init(&c->c2.explicit_exit_notification_interval, 1, 0);
>      reset_coarse_timers(c);
> +
>      signal_reset(c->sig);
>      halt_non_edge_triggered_signals();
>      c->c2.explicit_exit_notification_time_wait = now;
> +
> +    /* Check if we are in TLS mode and should sent the notify via data

"should send", "control"

> +     * channel */
> +    if (cc_exit_notify_enabled(c))
> +    {
> +        send_control_channel_string(c, "EXIT", D_PUSH);
> +    }
>  }
>  
>  void
[...]

Regards,
--
Frank Lichtenheld

