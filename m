References: <20190923133224.13899-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0b6f5d1a-6d9a-baf9-bc11-45cd3d73de25@...2181...>
Date: Mon, 23 Sep 2019 15:44:05 +0200
MIME-Version: 1.0
In-Reply-To: <20190923133224.13899-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Only announce IV_NCP=2 when we are
 willing to support these ciphers
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 23/09/2019 15:32, Arne Schwabe wrote:
> We currently always announce IV_NCP=2 when we support these ciphers even
> when we do not accept them. This lead to a server pushing a AES-GCM-128
> cipher to clients and the client then rejecting it.
> ---
>  src/openvpn/init.c       | 1 +
>  src/openvpn/openvpn.h    | 1 +
>  src/openvpn/options.c    | 7 +++++++
>  src/openvpn/ssl.c        | 4 +++-
>  src/openvpn/ssl_common.h | 1 +
>  5 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index b5a034dc..32f7bc7a 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2795,6 +2795,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
>      to.tcp_mode = link_socket_proto_connection_oriented(options->ce.proto);
>      to.config_ciphername = c->c1.ciphername;
>      to.config_authname = c->c1.authname;
> +    to.config_ncp_ciphers = c->c1.ncp_ciphers;


I can't find where config_ncp_ciphers is used and I can't find where
ncp_ciphers is set...something is missing?


>      to.ncp_enabled = options->ncp_enabled;
>      to.transition_window = options->transition_window;
>      to.handshake_window = options->handshake_window;
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index 29d21f0a..1fdbfe3c 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -208,6 +208,7 @@ struct context_1
>  
>      const char *ciphername;     /**< Data channel cipher from config file */
>      const char *authname;       /**< Data channel auth from config file */
> +    const char *ncp_ciphers;    /**< NCP Ciphers */
>      int keysize;                /**< Data channel keysize from config file */
>  #endif
>  };
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index c84b9d5e..cb25db5b 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -7687,6 +7687,13 @@ add_option(struct options *options,
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
>          options->ncp_ciphers = p[1];
> +
> +        if (!(tls_item_in_cipher_list("AES-128-GCM", options->ncp_ciphers)
> +              && tls_item_in_cipher_list("AES-256-GCM", options->ncp_ciphers)))
> +        {
> +            msg(M_INFO, "Not including AES-128-GCM and AES-256-GCM in ncp-ciphers "
> +                "disables announcing NCP support with IV_NCP=2");
> +        }

The condition and the text message are not agreeing with each other.

How about making the if condition easier to read by applying De Morgan's
law:


if (!tls_item_in_cipher_list("AES-128-GCM", options->ncp_ciphers)
    || !tls_item_in_cipher_list("AES-256-GCM", options->ncp_ciphers)))


This reads to me as: "Not enabling AES-128 or AES-256 disables NCP"
(Which I think is what you wanted to express in the debug message?)

What do you think?

>      }
>      else if (streq(p[0], "ncp-disable") && !p[1])
>      {
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index d5833ac6..f1719303 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2327,7 +2327,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
>  
>          /* support for Negotiable Crypto Parameters */
>          if (session->opt->ncp_enabled
> -            && (session->opt->mode == MODE_SERVER || session->opt->pull))
> +            && (session->opt->mode == MODE_SERVER || session->opt->pull)
> +            && tls_item_in_cipher_list("AES-128-GCM", session->opt->config_ncp_ciphers)
> +            && tls_item_in_cipher_list("AES-256-GCM", session->opt->config_ncp_ciphers))
>          {
>              buf_printf(&out, "IV_NCP=2\n");
>          }
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 0312c1f8..133c3c22 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -290,6 +290,7 @@ struct tls_options
>  
>      const char *config_ciphername;
>      const char *config_authname;
> +    const char *config_ncp_ciphers;
>      bool ncp_enabled;
>  
>      bool tls_crypt_v2;
> 


Cheers,

-- 
Antonio Quartulli

