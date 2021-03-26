References: <20210325174449.26948-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a45c035e-5c86-0df8-afdb-cc42d2e1ca45@...2181...>
Date: Fri, 26 Mar 2021 15:20:59 +0100
MIME-Version: 1.0
In-Reply-To: <20210325174449.26948-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Always disable SSL renegotiations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 25/03/2021 18:44, Arne Schwabe wrote:
> These have been troublesome in the past and also today's CVE-2021-3449
> DOS is only exploitable if renegotiation is enabled.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl_mbedtls.c | 3 +++
>  src/openvpn/ssl_openssl.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 4626e9838..1628a02e3 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -1086,6 +1086,9 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
>      {
>          mbedtls_ssl_conf_curves(ks_ssl->ssl_config, ssl_ctx->groups);
>      }
> +    /* Disable renegotiations. OpenVPN has its own mechanism to create whole
> +     * new SSL session. And these have been problematic in the past */

I would rephrase a bit the last sentence because "these" is a bit ambiguous:

And these have been problematic in the past => Also, renegotiations
initiated by the SSL library have already proven to be problematic.

> +    mbedtls_ssl_conf_renegotiation(ks_ssl->ssl_config, MBEDTLS_SSL_RENEGOTIATION_DISABLED);
>  
>      /* Disable record splitting (for now).  OpenVPN assumes records are sent
>       * unfragmented, and changing that will require thorough review and
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index d161f48b8..a11ca5b97 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -320,6 +320,9 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
>      sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
>  #endif
>      sslopt |= SSL_OP_NO_COMPRESSION;
> +    /* Disable renegotiations. OpenVPN has its own mechanism to create whole
> +     * new SSL session. And these have been probelmatic in the past */

same as above.

> +    sslopt |= SSL_OP_NO_RENEGOTIATION;
>  
>      SSL_CTX_set_options(ctx->ctx, sslopt);
>  
> 

The rest looks good to me!
I tested running an OpenVPN connection with multiple renegotiations
(triggered by OpenVPN) and nothing broke.

I am not sure there is a specific test for testing when the "SSL
renegotiation should have happened".

Cheers,

-- 
Antonio Quartulli

