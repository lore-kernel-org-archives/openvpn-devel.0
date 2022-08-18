From: Heiko Hund <heiko@...2662...>
Date: Thu, 18 Aug 2022 16:39:02 +0200
Message-ID: <1737786.5VJy9bbnOH@...2664...>
In-Reply-To: <20220520213250.3126372-2-arne@...1227...>
References: <20220520213250.3126372-1-arne@...1227...>
 <20220520213250.3126372-2-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 1/4] Implement exit notification via
 control channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Patch and thus series doesn't apply anymore, in addition to eventual changes 
also please rebase.

On Freitag, 20. Mai 2022 23:32:47 CEST Arne Schwabe wrote:
> +  If both server and client support sending this message using the control
> +  channel, the message will be sent as control-channel message. Otherwise
> +  the message is sent as data-channel message, which will be ignored by
> +  data-channel offloaded peers.
> +
>    The **n** parameter (default :code:`1` if not present) controls the
>    maximum number of attempts that the client will try to resend the exit
> -  notification message.
> +  notification message if messages are sent in data-channel mode.

You don't need the "n" for the control channel exit notification because of 
the reliability layer, right?!

> +    if (proto & IV_PROTO_CC_EXIT_NOTIFY)
> +    {
> +        o->data_channel_crypto_flags |= CO_USE_CC_EXIT_NOTIFY;
> +    }

The flags variable is named confusingly now. Is renaming an option?

>  static void
>  process_explicit_exit_notification_init(struct context *c)
>  {
>      msg(M_INFO, "SIGTERM received, sending exit notification to peer");
>      event_timeout_init(&c->c2.explicit_exit_notification_interval, 1, 0);
>      reset_coarse_timers(c);

Do we need to timer event if !cc_exit_notify_enabled(c)?






