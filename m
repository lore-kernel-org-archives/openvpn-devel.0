References: <20180228135240.22945-1-joost@...2383...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <ed37713b-f538-f74a-a4c1-00990e465dea@...1856...>
Date: Sun, 4 Mar 2018 10:38:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180228135240.22945-1-joost@...2383...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Make return code external tls key match
 docs
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 28-02-18 14:52, Joost Rijneveld wrote:
> In tls_ctx_use_external_private_key, the return codes were inverted
> compared to what is documented in ssl_backend.h (and what can
> reasonably be expected). Internally the return code is never checked,
> so this did not directly result in any change of behavior.
> ---
>  src/openvpn/ssl_mbedtls.c | 6 +++---
>  src/openvpn/ssl_openssl.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 3906cd55..8e31980a 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -630,7 +630,7 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
>  
>      if (ctx->crt_chain == NULL)
>      {
> -        return 0;
> +        return 1;
>      }
>  
>      ALLOC_OBJ_CLEAR(ctx->external_key, struct external_context);
> @@ -640,10 +640,10 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
>      if (!mbed_ok(mbedtls_pk_setup_rsa_alt(ctx->priv_key, ctx->external_key,
>                                            NULL, external_pkcs1_sign, external_key_len)))
>      {
> -        return 0;
> +        return 1;
>      }
>  
> -    return 1;
> +    return 0;
>  }
>  #endif /* ifdef MANAGMENT_EXTERNAL_KEY */
>  
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index d91458b0..8ef68ebd 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1327,11 +1327,11 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
>          goto err;
>      }
>  #endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev */
> -    return 1;
> +    return 0;
>  
>  err:
>      crypto_msg(M_FATAL, "Cannot enable SSL external private key capability");
> -    return 0;
> +    return 1;
>  }
>  
>  #endif /* ifdef MANAGMENT_EXTERNAL_KEY */
> 

Thanks for the patch, and pointing out this inconsistency.  Changes make
sense and make this function follow what seems to be the default pattern
in the surrounding code.

Acked-by: Steffan Karger <steffan@...1856...>

(What bothers me more is that we don't actually check the return values,
but I'll send a follow-up patch to fix that.)

-Steffan

