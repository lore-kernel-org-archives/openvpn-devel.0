Date: Wed, 19 Oct 2022 11:26:50 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y0/C2j9KKhGywT1U@...2685...>
References: <20220921104930.3452270-1-arne@...1227...>
 <20220921104930.3452270-2-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20220921104930.3452270-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4 2/3] Allow setting control channel
 packet size with max-packet-size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Sep 21, 2022 at 12:49:29PM +0200, Arne Schwabe wrote:
> Currently control packet size is controlled by tun-mtu in a very
> non-obvious way since the control overhead is not taken into account
> and control channel packet will end up with a different size than
> data channel packet.
> 
> Instead we decouple this and introduce max-packet-size. Control packet size
> defaults to 1250 if max-packet-size is not set.
> 
> Patch v2: rebase on latest patch set
> Patch v3: Introduce TLS_CHANNEL_MTU_MIN define and give explaination
>           of its value.
> Patch v4: introduce max-packet-size instead of tls-mtu

In general I think this change really could use more documentation.

E.g. so we imply --mssfix, this should be documented under --mssfix.
Also we should look at all existing examples with --mssfix/--fragment/--tun-mtu
and check whether they should be changed to use different options.
E.g. how does --max-packet-size interact with the argument-less --mssfix? That
should be mentioned.

At the moment this patch adds an option but gives the user no indication
when and why to use it compared to all other MTU-related options.

Some other small suggestions below.

> diff --git a/Changes.rst b/Changes.rst
> index 275f8d647..25b0e9846 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -88,6 +88,12 @@ Data channel offloading with ovpn-dco
>      which brings DATA_V2 packet support.
>  
>  
> +Improved control channel packet size control (``max-packet-size``)
> +    The size of control channel is no longer tied to
> +    ``--link-mtu``/``--tun-mtu`` and can be set using ``--max-packet-size``.
> +    Setting the size to small sizes no longer breaks the OpenVPN protocol in
> +    certain situations.

This should mention the implied --mssfix. This way it sounds like it only
affects control channel.

>  Deprecated features
>  -------------------
>  ``inetd`` has been removed
> @@ -150,6 +156,9 @@ User-visible Changes
>  - Option ``--nobind`` is default when ``--client`` or ``--pull`` is used in the configuration
>  - :code:`link_mtu` parameter is removed from environment or replaced with 0 when scripts are
>    called with parameters. This parameter is unreliable and no longer internally calculated.
> +- control channel packet maximum size is no longer influenced by ``--link-mtu``/``--tun-mtu``
> +  and must be set by ``--max-packet-size`` now.
> +
>  
>  Overview of changes in 2.5
>  ==========================
> diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
> index 373193aa3..176c2b0db 100644
> --- a/doc/man-sections/link-options.rst
> +++ b/doc/man-sections/link-options.rst
> @@ -454,3 +454,19 @@ the local and the remote host.
>       if mode server:
>           socket-flags TCP_NODELAY
>           push "socket-flags TCP_NODELAY"
> +
> +--max-packet-size size
> +  This option will instruct OpenVPN to try to limit the maximum on-write packet
> +  size by restricting the control channel packet size and setting ``--mssfix``.
> +
> +  OpenVPN will try to keep its control channel messages below this size but
> +  due to some constraints in the protocol this is not always possible. If the
> +  option is not set, the control packet maximum size defaults to 1250.
> +  The control channel packet size will be restricted to values between
> +  512 and 2048. The maximum packet size includes encapsulation overhead like
> +  UDP and IP.
> +
> +  For ``--mssfix`` it will expand to:
> +  ::
> +
> +      mssfix size mtu
> \ No newline at end of file

Missing newline

> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> index b94680885..056c25438 100644
> --- a/src/openvpn/common.h
> +++ b/src/openvpn/common.h
> @@ -68,6 +68,16 @@ typedef unsigned long ptr_type;
>   */
>  #define TLS_CHANNEL_BUF_SIZE 2048
>  
> +/* TLS control buffer minimum size, this size is not actually inherent to
> + * the protocol but. Our current sending window is 6 and the receive window
> + * is 8 or 12 depending on the OpenVPN version. We need to be able to send
> + * a TLS record of size TLS_CHANNEL_BUF_SIZE. Splitting this into more than
> + * 6 packets (with overhead) would complicate our sending logic a lot more, so
> + * we settle here for a "round" number that allow with overhead of ~100 bytes
> + * to be larger than TLS_CHANNEL_BUF_SIZE. E.g. 6x ~400 > 2048.

That sentence is difficult to parse, specifically "so
we settle here for a "round" number that allow with overhead of ~100 bytes
to be larger than TLS_CHANNEL_BUF_SIZE". I'm not completely sure what you
want to say so I find it difficult to make recommendations.

> + * */
> +#define TLS_CHANNEL_MTU_MIN 512
> +
>  /*
>   * This parameter controls the maximum size of a bundle
>   * of pushed options.
[...]
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index e44993c03..a7385118e 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -825,6 +825,7 @@ init_options(struct options *o, const bool init_gc)
>      o->ce.bind_local = true;
>      o->ce.tun_mtu = TUN_MTU_DEFAULT;
>      o->ce.link_mtu = LINK_MTU_DEFAULT;
> +    o->ce.tls_mtu = TLS_MTU_DEFAULT;
>      o->ce.mtu_discover_type = -1;
>      o->ce.mssfix = 0;
>      o->ce.mssfix_default = true;
> @@ -1711,6 +1712,7 @@ show_connection_entry(const struct connection_entry *o)
>      SHOW_BOOL(link_mtu_defined);
>      SHOW_INT(tun_mtu_extra);
>      SHOW_BOOL(tun_mtu_extra_defined);
> +    SHOW_INT(tls_mtu);
>  
>      SHOW_INT(mtu_discover_type);
>  
> @@ -6442,6 +6444,25 @@ add_option(struct options *options,
>          options->ce.tun_mtu_extra = positive_atoi(p[1]);
>          options->ce.tun_mtu_extra_defined = true;
>      }
> +    else if (streq(p[0], "max-packet-size") && p[1] && !p[2])
> +    {
> +        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
> +        int maxmtu = positive_atoi(p[1]);
> +        options->ce.tls_mtu = constrain_int(maxmtu, TLS_CHANNEL_MTU_MIN, TLS_CHANNEL_BUF_SIZE);
> +
> +        if (maxmtu < TLS_CHANNEL_MTU_MIN || maxmtu > TLS_CHANNEL_BUF_SIZE)
> +        {
> +            msg(M_WARN, "max-packet-size value outside of allowed control "
> +                "channel packet size (%d to %d), will use %d "
> +                "instead", TLS_CHANNEL_MTU_MIN, TLS_CHANNEL_BUF_SIZE,
> +                options->ce.tls_mtu);

Would add '.' after instead. Also we might want to add "Note: " prefix to be more consistent
with other similar messages?

> +        }
> +
> +        /* also set mssfix maxmtu mtu */
> +        options->ce.mssfix = maxmtu;
> +        options->ce.mssfix_default = false;
> +        options->ce.mssfix_encap = true;
> +    }
>  #ifdef ENABLE_FRAGMENT
>      else if (streq(p[0], "mtu-dynamic"))
>      {
[...]

regards,
-- 
  Frank Lichtenheld

