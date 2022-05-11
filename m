Date: Wed, 11 May 2022 12:04:47 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <299108472.641365.1652263487971@...2642...>
In-Reply-To: <20220510170741.1856843-1-arne@...1227...>
References: <20220422142953.3805364-17-arne@...1227...>
 <20220510170741.1856843-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 26/28] Allow setting control channel
 packet size with tls-mtu
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

> Arne Schwabe <arne@...1227...> hat am 10.05.2022 19:07 geschrieben:
[...]
> diff --git a/Changes.rst b/Changes.rst
> index 67a23c792..f40fc09ae 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -79,6 +79,12 @@ Cookie based handshake for UDP server
>      shake. The tls-crypt-v2 option allows controlling if older clients are
>      accepted.
>  
> +Improved control channel packet size control (``--tls-mtu``)
> +    The size of control channel is no longer tied to
> +    ``--link-mtu``/``--tun-mtu`` and can be set using ``--tls-mtu``. Setting
> +    the size to small sizes no longer breaks the OpenVPN protocol in certain
> +    situation.

"situations"

> +
>  Deprecated features
>  -------------------
>  ``inetd`` has been removed
> @@ -141,6 +147,8 @@ User-visible Changes
>  - Option ``--nobind`` is default when ``--client`` or ``--pull`` is used in the configuration
>  - :code:`link_mtu` parameter is removed from environment or replaced with 0 when scripts are
>    called with parameters. This parameter is unreliable and no longer internally calculated.
> +- control channel packet maximum size is no longer influenced by ``--link-mtu``/``--tun-mtu``
> +  and must be set by ``--tls-mtu`` now.
>  
>  Overview of changes in 2.5
>  ==========================
> diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
> index 6473ad423..b084fe082 100644
> --- a/doc/man-sections/link-options.rst
> +++ b/doc/man-sections/link-options.rst
> @@ -454,3 +454,10 @@ the local and the remote host.
>       if mode server:
>           socket-flags TCP_NODELAY
>           push "socket-flags TCP_NODELAY"
> +
> +--tls-mtu size
> +  This option sets the maximum size for control channel packets. OpenVPN will
> +  try to keep its control channel messages below this size but due to some
> +  constraints in the protocol this is not always possible. If the option is
> +  not set, it default to 1250. Valid sizes are between 512 and 2048.
> +  The maximum packet size includes encapsalution overhead like UDP and IP.

"encapsulation"

> \ No newline at end of file
[...]
> @@ -6281,6 +6283,18 @@ add_option(struct options *options,
>          options->ce.tun_mtu_extra = positive_atoi(p[1]);
>          options->ce.tun_mtu_extra_defined = true;
>      }
> +    else if (streq(p[0], "tls-mtu") && p[1] && !p[2])
> +    {
> +        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
> +        int tls_mtu = atoi(p[1]);
> +        if (tls_mtu < 512 || tls_mtu > TLS_CHANNEL_BUF_SIZE)
> +        {
> +            msg(msglevel, "Bad tls-mtu value, must be between %d and %d",
> +                512, TLS_CHANNEL_BUF_SIZE);

Would it be useful to have a define for the 512 as well?

> +            goto err;
> +        }
> +        options->ce.tls_mtu = positive_atoi(p[1]);
> +    }
>  #ifdef ENABLE_FRAGMENT
>      else if (streq(p[0], "mtu-dynamic"))
>      {
[...]
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 1e3c500d8..d1708c19b 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -296,8 +296,7 @@ tls_limit_reneg_bytes(const char *ciphername, int *reneg_bytes)
>  }
>  
>  void
> -tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame,
> -                                          struct frame *frame)
> +tls_init_control_channel_frame_parameters(struct frame *frame, int tls_mtu)
>  {
>      /*
>       * frame->extra_frame is already initialized with tls_auth buffer requirements,
> @@ -322,18 +321,20 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
>  
>      /* Previous OpenVPN version calculated the maximum size and buffer of a
>       * control frame depending on the overhead of the data channel frame
> -     * overhead and limited its maximum size to 1250. We always allocate the
> -     * TLS_CHANNEL_BUF_SIZE buffer size since a lot of code blindly assumes
> -     * a large buffer (e.g. PUSH_BUNDLE_SIZE) and also our peer might have
> -     * a higher size configured and we still want to be able to receive the
> -     * packets. frame->mtu_mtu is set as suggestion for the maximum packet
> -     * size */
> -    frame->buf.payload_size = 1250 + overhead;
> +     * overhead and limited its maximum size to 1250. Since control frame
> +     * frames also need to fit into data channel buffer we have the same
> +     * default of 1500 + 100 as data channel buffers have. Increasing
> +     * tls-mtu beyond this limit also increases the data channel buffers */
> +    frame->buf.payload_size = max_int(1500, tls_mtu) + 100;
>  
>      frame->buf.headroom = overhead;
>      frame->buf.tailroom = overhead;
>  
> -    frame->tun_mtu = min_int(data_channel_frame->tun_mtu, 1250);
> +    frame->tun_mtu = tls_mtu;
> +
> +    /* Ensure the tun-mtu stays in a valid range */
> +    frame->tun_mtu = min_int(frame->tun_mtu, TLS_CHANNEL_BUF_SIZE);
> +    frame->tun_mtu = max_int(frame->tun_mtu, 512);

Is this 512 the same 512 as above? If yes, then I feel a define would definitely
be a good idea.

>  }
>  
>  /**
[...]

Regards,
--
Frank Lichtenheld

