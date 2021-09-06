References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-7-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3b7fbb4c-ea23-6829-7daf-278f72832133@...1227...>
Date: Mon, 6 Sep 2021 15:24:49 +0200
MIME-Version: 1.0
In-Reply-To: <20210904095629.6273-7-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 6/7] set TLS 1.2 as minimum by default
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 04.09.21 um 11:56 schrieb Antonio Quartulli:
> Do not accept handshakes with peers trying to negotiate TLS lower than 1.2.
> TLS 1.1 and 1.0 are not recommended and therefore will, by default,
> allow TLS 1.2 as minimum version.
> 
> The minimum allowed version can still be controlled via
> '--tls-version-min'.
> 
> At the same time automatically set '--tls-version-min' to 1.0 if the
> user requires compatibility with versions onlder than 2.3.7, as that was
> the only version supported back then.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  Changes.rst                          |  5 +++++
>  doc/man-sections/generic-options.rst |  2 ++
>  src/openvpn/options.c                | 16 ++++++++++++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/Changes.rst b/Changes.rst
> index f803b760..472421c8 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -71,6 +71,11 @@ Deprecated features
>      This option mainly served a role as debug option when NCP was first
>      introduced. It should now no longer be necessary.
>  
> +TLS 1.0 and 1.1 are deprecated
> +    ``tls-version-min`` is set to 1.2 by default.  OpenVPN 2.6.0 defaults
> +    to a minimum TLS version of 1.2 as TLS 1.0 and 1.1 should be generally
> +    avoided. Note that OpenVPN versions older than 2.3.7 use TLS 1.0 only.
> +
>  ``--cipher`` argument is no longer included in ``--data-ciphers`` by default
>      Data cipher negotiation has been introduced in 2.4.0 and been significantly
>      improved in 2.5.0. The implicit fallback to the cipher specified in
> diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
> index 3e099e12..e6c1fe45 100644
> --- a/doc/man-sections/generic-options.rst
> +++ b/doc/man-sections/generic-options.rst
> @@ -70,6 +70,8 @@ which mode OpenVPN is configured as.
>      ``--data-ciphers``
>    - 2.3.x or lower: ``--data-cipher-fallback`` is automatically added with
>      the same cipher as ``--cipher``
> +  - 2.3.6 or lower: ``--tls-version-min 1.0`` is added to the configuration
> +    when ``--tls-version-min`` is not explicitly set.
>  
>  --config file
>    Load additional config options from ``file`` where each line corresponds
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index f2fb6d64..6f6eb73d 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -850,6 +850,7 @@ init_options(struct options *o, const bool init_gc)
>      o->use_prediction_resistance = false;
>  #endif
>      o->tls_timeout = 2;
> +    o->ssl_flags = (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIFT);
>      o->renegotiate_bytes = -1;
>      o->renegotiate_seconds = 3600;
>      o->renegotiate_seconds_min = -1;
> @@ -3140,6 +3141,21 @@ need_compatibility_before(const struct options *o, int version)
>  static void
>  options_set_backwards_compatible_options(struct options *o)
>  {
> +    /* TLS min version is not set */
> +    if ((o->ssl_flags & SSLF_TLS_VERSION_MIN_MASK) == 0)
> +    {
> +        if (need_compatibility_before(o, 20307))
> +        {
> +            /* 2.3.6 and earlier have TLS 1.0 only, set minimum to TLS 1.0 */
> +            o->ssl_flags = (TLS_VER_1_0 << SSLF_TLS_VERSION_MIN_SHIFT);
> +        }
> +        else
> +        {
> +            /* Use TLS 1.2 as proper default */
> +            o->ssl_flags = (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIFT);
> +        }
> +    }
> +
>      /* Versions < 2.5.0 do need --cipher in the list of accepted ciphers.
>       * Version 2.4 might probably does not need it but NCP was not so
>       * good with 2.4 and ncp-disable might be more common on 2.4 peers.
> 

Acked-By: Arne Schwabe <arne@...1227...>

Note that on newer Ubuntu versions, which their strangely patched
OpenSSL, you are already getting this behaviour by default.

Arne

