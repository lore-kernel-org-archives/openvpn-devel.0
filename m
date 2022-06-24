Date: Fri, 24 Jun 2022 10:51:15 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YrV7AxHepE/xZqHq@...2678...>
References: <20220621161649.2872985-1-arne@...1227...>
 <20220621161649.2872985-6-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20220621161649.2872985-6-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 6/6] Allow tun-mtu to be pushed
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

Only skimmed this. A few small typo fixes and the like.

On Tue, Jun 21, 2022 at 06:16:49PM +0200, Arne Schwabe wrote:
> This allows tun-mtu to pushed but only up to the size of the preallocated
> buffers. This is not a perfect solution but should allow most of the use
> cases where the mtu is close enough to 1500.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                              |  8 ++++
>  doc/man-sections/client-options.rst      |  4 ++
>  doc/man-sections/vpn-network-options.rst |  5 +++
>  src/openvpn/init.c                       | 52 ++++++++++++++++++++----
>  src/openvpn/mtu.c                        |  1 +
>  src/openvpn/mtu.h                        |  3 ++
>  src/openvpn/options.c                    | 15 ++++++-
>  src/openvpn/options.h                    |  2 +
>  src/openvpn/ssl.c                        |  3 ++
>  9 files changed, 85 insertions(+), 8 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 79b79d608..e99671bcb 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -79,6 +79,14 @@ Cookie based handshake for UDP server
>      shake. The tls-crypt-v2 option allows controlling if older clients are
>      accepted.
>  
> +
> +Tun MTU can be pushed
> +    As part of changing the ``--tun-mtu`` default to 1420 (see below), the
> +    client can now also dynamically configure its MTU and the server will
> +    try to push the client MTU when the client supports it. The directive
> +    ``--tun-mtu-max`` has been introduced to specify the maximum pushable
> +    MTU size.
> +
>  Deprecated features
>  -------------------
>  ``inetd`` has been removed
> diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
> index 8e0e4f18a..230e51e8d 100644
> --- a/doc/man-sections/client-options.rst
> +++ b/doc/man-sections/client-options.rst
> @@ -358,6 +358,10 @@ configuration.
>          The client announces the list of supported ciphers configured with the
>          ``--data-ciphers`` option to the server.
>  
> +  :code:`IV_MTU=<max_mtu>`
> +        The client announces the support of pushable MTU and the maximum MTU
> +        the client is willing to accept.

"it" instead of repeating "the client"?

> +
>    :code:`IV_GUI_VER=<gui_id> <version>`
>          The UI version of a UI if one is running, for example
>          :code:`de.blinkt.openvpn 0.5.47` for the Android app.
> diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
> index 2e4fff5df..71aa3f4c7 100644
> --- a/doc/man-sections/vpn-network-options.rst
> +++ b/doc/man-sections/vpn-network-options.rst
> @@ -540,6 +540,11 @@ routing.
>    packets larger than ``tun-mtu`` (e.g. Linux and FreeBSD) but other platforms
>    (like macOS) limit received packets to the same size as the MTU.
>  
> +--tun-max-mtu maxmtu
> +  This configures the maximum MTU size that a server can push to ``maxmtu``.
> +  The default for ``maxmtu`` is 1600. This will increase internal buffers
> +  allocation for larger packet sizes.
> +
>  --tun-mtu-extra n
>    Assume that the TUN/TAP device might return as many as ``n`` bytes more
>    than the ``--tun-mtu`` size on read. This parameter defaults to 0, which
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 6cdcef628..e9f9778a3 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2126,7 +2126,8 @@ pull_permission_mask(const struct context *c)
>          | OPT_P_ECHO
>          | OPT_P_PULL_MODE
>          | OPT_P_PEER_ID
> -        | OPT_P_NCP;
> +        | OPT_P_NCP
> +        | OPT_P_PUSH_MTU;
>  
>      if (!c->options.route_nopull)
>      {
> @@ -2283,12 +2284,39 @@ do_deferred_options(struct context *c, const unsigned int found)
>  #endif
>  
>          struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
> +        if (!update_session_cipher(session, &c->options))
> +        {
> +            /* The update_session_cipher method wil already print an error */

"will"

> +            return false;
> +        }
> +
> +        /* Cipher is considered safe, so we can use it to calculate the max
> +         * MTU size */
> +        if (found & OPT_P_PUSH_MTU)
> +        {
> +            /* MTU has changed, check that the pushed MTU is small enough to
> +             * be able to change it */
> +            msg(D_PUSH, "OPTIONS IMPORT: tun-mtu set to %d", c->options.ce.tun_mtu);
> +
> +            struct frame *frame = &c->c2.frame;
> +
> +            if (c->options.ce.tun_mtu > frame->tun_max_mtu)
> +            {
> +                msg(D_PUSH_ERRORS, "Server pushed a large mtu, please add "
> +                    "tun-mtu-max %d in the client configuration",
> +                    c->options.ce.tun_mtu);
> +            }
> +            frame->tun_mtu = min_int(frame->tun_max_mtu, c->options.ce.tun_mtu);
> +        }
> +
>          if (!tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
>                                                frame_fragment, get_link_socket_info(c)))
>          {
>              msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
>              return false;
>          }
> +
> +

Spurious whitespace change.

>      }
>  
>      return true;
> @@ -2446,10 +2474,16 @@ frame_finalize_options(struct context *c, const struct options *o)
>      struct frame *frame = &c->c2.frame;
>  
>      frame->tun_mtu = get_frame_mtu(c, o);
> +    frame->tun_max_mtu = o->ce.tun_mtu_max;
> +
> +    /* max mtu needs to be at least as large as the tun mtu */
> +    frame->tun_max_mtu = max_int(frame->tun_mtu, frame->tun_max_mtu);
>  
> -    /* We always allow at least 1500 MTU packets to be received in our buffer
> -     * space */
> -    size_t payload_size = max_int(1500, frame->tun_mtu);
> +    /* We always allow at least 1600 MTU packets to be received in our buffer
> +     * space to allow server to push "baby giant MTU sizes */

Missing "

> +    frame->tun_max_mtu = max_int(1600, frame->tun_max_mtu);
> +
> +    size_t payload_size = frame->tun_max_mtu;
>  
>      /* The extra tun needs to be added to the payload size */
>      if (o->ce.tun_mtu_defined)
[...]

