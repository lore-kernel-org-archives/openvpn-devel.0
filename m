References: <20181008214123.10819-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d64a79e4-192d-5262-0845-e5adfbb342a9@...1856...>
Date: Tue, 9 Oct 2018 22:48:03 +0200
MIME-Version: 1.0
In-Reply-To: <20181008214123.10819-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Refuse mbed TLS external key with non
 RSA certificates
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

On 08-10-18 23:41, Arne Schwabe wrote:
> The current API that we use (mbedtls_pk_setup_rsa_alt) only allows
> using RSA keys with the external API. Using an EC, mbed TLS and external
> key in OpenVPN will fail very late with a rather obscure error message.
> 
> Instead fail early and provide a clear message that only RSA keys are
> supported.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl_mbedtls.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 3e97a329..95061d6d 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -604,6 +604,13 @@ tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx,
>          return 1;
>      }
>  
> +    if (mbedtls_pk_get_type(&ctx->crt_chain->pk) != MBEDTLS_PK_RSA)
> +    {
> +        msg (M_WARN, "ERROR: external key with mbed TLS requires a "
> +                     "certificate with an RSA key.");
> +        return 1;
> +    }
> +
>      ctx->external_key.signature_length = mbedtls_pk_get_len(&ctx->crt_chain->pk);
>      ctx->external_key.sign = sign_func;
>      ctx->external_key.sign_ctx = sign_ctx;
> 

There should be no space in "msg(", but other than that this makes sense
and looks good.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

