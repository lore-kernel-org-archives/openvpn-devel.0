References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-8-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <c0192fdc-6aa8-5ac6-27ac-6729dbe22991@...1856...>
Date: Fri, 24 Jul 2020 10:14:33 +0200
MIME-Version: 1.0
In-Reply-To: <20200717134739.21168-8-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 8/9] Rename ncp-ciphers to data-ciphers
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 17-07-2020 15:47, Arne Schwabe wrote:
> The change in name signals that data-ciphers is the preferred way to
> configure data channel (and not --cipher). The data prefix is chosen
> to avoid ambiguity and make it distinct from tls-cipher for the TLS
> ciphers.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                            | 13 ++++++++++---
>  doc/man-sections/protocol-options.rst  | 11 +++++++----
>  doc/man-sections/server-options.rst    |  4 ++--
>  sample/sample-config-files/client.conf |  2 +-
>  src/openvpn/multi.c                    |  4 ++--
>  src/openvpn/options.c                  |  5 +++--
>  src/openvpn/ssl_ncp.c                  |  4 ++--
>  7 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 6e283270..2158c8e7 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -14,12 +14,19 @@ ChaCha20-Poly1305 cipher support
>      channel.
>  
>  Improved Data channel cipher negotiation
> +    The option ``ncp-ciphers`` has been renamed to ``data-ciphers``.
> +    The old name is still accepted. The change in name signals that
> +    ``data-ciphers`` is the preferred way to configure data channel
> +    ciphers and the data prefix is chosen to avoid the ambiguity that
> +    exists with ``--cipher`` for the data cipher and ``tls-cipher``
> +    for the TLS ciphers.
> +
>      OpenVPN clients will now signal all supported ciphers from the
> -    ``ncp-ciphers`` option to the server via ``IV_CIPHERS``. OpenVPN
> -    servers will select the first common cipher from the ``ncp-ciphers``
> +    ``data-ciphers`` option to the server via ``IV_CIPHERS``. OpenVPN
> +    servers will select the first common cipher from the ``data-ciphers``
>      list instead of blindly pushing the first cipher of the list. This
>      allows to use a configuration like
> -    ``ncp-ciphers ChaCha20-Poly1305:AES-256-GCM`` on the server that
> +    ``data-ciphers ChaCha20-Poly1305:AES-256-GCM`` on the server that
>      prefers ChaCha20-Poly1305 but uses it only if the client supports it.
>  
>  Asynchronous (deferred) authentication support for auth-pam plugin.
> diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
> index 923d2da0..051f1d32 100644
> --- a/doc/man-sections/protocol-options.rst
> +++ b/doc/man-sections/protocol-options.rst
> @@ -62,7 +62,7 @@ configured in a compatible way between both the local and remote side.
>    The default is :code:`BF-CBC`, an abbreviation for Blowfish in Cipher
>    Block Chaining mode. When cipher negotiation (NCP) is allowed,
>    OpenVPN 2.4 and newer on both client and server side will automatically
> -  upgrade to :code:`AES-256-GCM`.  See ``--ncp-ciphers`` and
> +  upgrade to :code:`AES-256-GCM`.  See ``--data-ciphers`` and
>    ``--ncp-disable`` for more details on NCP.
>  
>    Using :code:`BF-CBC` is no longer recommended, because of its 64-bit
> @@ -169,7 +169,7 @@ configured in a compatible way between both the local and remote side.
>    non-standard key lengths, and a larger key may offer no real guarantee
>    of greater security, or may even reduce security.
>  
> ---ncp-ciphers cipher-list
> +--data-ciphers cipher-list
>    Restrict the allowed ciphers to be negotiated to the ciphers in
>    ``cipher-list``. ``cipher-list`` is a colon-separated list of ciphers,
>    and defaults to :code:`AES-256-GCM:AES-128-GCM`.
> @@ -189,9 +189,9 @@ configured in a compatible way between both the local and remote side.
>    Additionally, to allow for more smooth transition, if NCP is enabled,
>    OpenVPN will inherit the cipher of the peer if that cipher is different
>    from the local ``--cipher`` setting, but the peer cipher is one of the
> -  ciphers specified in ``--ncp-ciphers``. E.g. a non-NCP client (<=v2.3,
> +  ciphers specified in ``--data-ciphers``. E.g. a non-NCP client (<=v2.3,
>    or with --ncp-disabled set) connecting to a NCP server (v2.4+) with
> -  ``--cipher BF-CBC`` and ``--ncp-ciphers AES-256-GCM:AES-256-CBC`` set can
> +  ``--cipher BF-CBC`` and ``--data-ciphers AES-256-GCM:AES-256-CBC`` set can
>    either specify ``--cipher BF-CBC`` or ``--cipher AES-256-CBC`` and both
>    will work.
>  
> @@ -201,6 +201,9 @@ configured in a compatible way between both the local and remote side.
>    This list is restricted to be 127 chars long after conversion to OpenVPN
>    ciphers.
>  
> +  This option was called ``ncp-ciphers`` in OpenVPN 2.4 but has been renamed
> +  to ``data-ciphers`` in OpenVPN 2.5 to more accurately reflect its meaning.
> +
>  --ncp-disable
>    Disable "Negotiable Crypto Parameters". This completely disables cipher
>    negotiation.
> diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
> index c24aec0b..74ad5e18 100644
> --- a/doc/man-sections/server-options.rst
> +++ b/doc/man-sections/server-options.rst
> @@ -473,8 +473,8 @@ fast hardware. SSL/TLS authentication must be used in this mode.
>          *AES-GCM-128* and *AES-GCM-256*.
>  
>    :code:`IV_CIPHERS=<ncp-ciphers>`
> -        The client pushes the list of configured ciphers with the
> -        ``--ciphers`` option to the server.
> +        The client announces the list of supported ciphers configured with the
> +        ``--data-ciphers`` option to the server.
>  
>    :code:`IV_GUI_VER=<gui_id> <version>`
>          The UI version of a UI if one is running, for example
> diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-files/client.conf
> index 7f2f30a3..47ca4099 100644
> --- a/sample/sample-config-files/client.conf
> +++ b/sample/sample-config-files/client.conf
> @@ -112,7 +112,7 @@ tls-auth ta.key 1
>  # then you must also specify it here.
>  # Note that v2.4 client/server will automatically
>  # negotiate AES-256-GCM in TLS mode.
> -# See also the ncp-cipher option in the manpage
> +# See also the data-ciphers option in the manpage
>  cipher AES-256-CBC
>  
>  # Enable compression on the VPN link.
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 88ba9db2..d2549bca 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1827,7 +1827,7 @@ multi_client_set_protocol_options(struct context *c)
>          else
>          {
>              /*
> -             * Push the first cipher from --ncp-ciphers to the client that
> +             * Push the first cipher from --data-ciphers to the client that
>               * the client announces to be supporting.
>               */
>              char *push_cipher = ncp_get_best_cipher(o->ncp_ciphers, o->ciphername,
> @@ -1847,7 +1847,7 @@ multi_client_set_protocol_options(struct context *c)
>                  {
>                      msg(M_INFO, "PUSH: No common cipher between server and "
>                          "client. Expect this connection not to work. Server "
> -                        "ncp-ciphers: '%s', client supported ciphers '%s'",
> +                        "data-ciphers: '%s', client supported ciphers '%s'",
>                          o->ncp_ciphers, peer_ciphers);
>                  }
>                  else
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 31e33ae3..896abcde 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -536,7 +536,7 @@ static const char usage_message[] =
>      "--cipher alg    : Encrypt packets with cipher algorithm alg\n"
>      "                  (default=%s).\n"
>      "                  Set alg=none to disable encryption.\n"
> -    "--ncp-ciphers list : List of ciphers that are allowed to be negotiated.\n"
> +    "--data-ciphers list : List of ciphers that are allowed to be negotiated.\n"
>      "--ncp-disable   : (DEPRECATED) Disable cipher negotiation.\n"
>      "--prng alg [nsl] : For PRNG, use digest algorithm alg, and\n"
>      "                   nonce_secret_len=nsl.  Set alg=none to disable PRNG.\n"
> @@ -7866,7 +7866,8 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
>          options->ciphername = p[1];
>      }
> -    else if (streq(p[0], "ncp-ciphers") && p[1] && !p[2])
> +    else if ((streq(p[0], "data-ciphers") || streq(p[0], "ncp-ciphers"))
> +            && p[1] && !p[2])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
>          options->ncp_ciphers = p[1];
> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
> index e057a40b..6760884e 100644
> --- a/src/openvpn/ssl_ncp.c
> +++ b/src/openvpn/ssl_ncp.c
> @@ -111,7 +111,7 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
>          const cipher_kt_t *ktc = cipher_kt_get(token);
>          if (!ktc)
>          {
> -            msg(M_WARN, "Unsupported cipher in --ncp-ciphers: %s", token);
> +            msg(M_WARN, "Unsupported cipher in --data-ciphers: %s", token);
>              error_found = true;
>          }
>          else
> @@ -130,7 +130,7 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
>              if (!(buf_forward_capacity(&new_list) >
>                    strlen(ovpn_cipher_name) + 2))
>              {
> -                msg(M_WARN, "Length of --ncp-ciphers is over the "
> +                msg(M_WARN, "Length of --data-ciphers is over the "
>                      "limit of 127 chars");
>                  error_found = true;
>              }
> 

Thanks. Patch looks good, and passes manual tests.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

