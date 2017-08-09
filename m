References: <20170809074237.31291-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <be3bbbfd-8c04-1883-63df-21da6046e4e8@...1856...>
Date: Wed, 9 Aug 2017 20:42:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170809074237.31291-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] OpenSSL: remove unreachable call to
 SSL_CTX_get0_privatekey()
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
Cc: Antonio Quartulli <antonio@...515...>

Hi,

On 09-08-17 09:42, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
> 
> In tls_ctx_load_ecdh_params() the SSL_CTX_get0_privatekey() function
> is invoked only when "OPENSSL_VERSION_NUMBER >= 0x10002000L" and
> curve_name is NULL.
> 
> However, under the very same conditions the code flow will
> lead to an earlier return, thus never reaching the invocation of
> SSL_CTX_get0_privatekey().
> 
> Restructure the surrounding code in order to make the if/else
> block a bit easier to read and get rid of the unreachable
> invocation.
> 
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
> 
> Note: I believe that code sections like this, trying to deal with
> different library versions, should be cleaned up by moving the
> various #ifs to header files, instead of having them in the code.
> However, this should be done in a later (and bigger) cleanup.

I'm not so sure that would improve things, but I'm happy to review a
patch to be convinced otherwise ;-)

>  src/openvpn/ssl_openssl.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index e18fffc1..7ad6414e 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -484,15 +484,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
>  
>      /* Generate a new ECDH key for each SSL session (for non-ephemeral ECDH) */
>      SSL_CTX_set_options(ctx->ctx, SSL_OP_SINGLE_ECDH_USE);
> -#if OPENSSL_VERSION_NUMBER >= 0x10002000L
> -    /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter loading */
> -    if (NULL == curve_name)
> -    {
> -        SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
> -        return;
> -    }
> -#endif
> -    /* For older OpenSSL, we'll have to do the parameter loading on our own */
> +
>      if (curve_name != NULL)
>      {
>          /* Use user supplied curve if given */
> @@ -501,14 +493,17 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
>      }
>      else
>      {
> -        /* Extract curve from key */
> +#if OPENSSL_VERSION_NUMBER >= 0x10002000L
> +        /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter
> +         * loading */
> +        SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
> +        return;
> +#else
> +        /* For older OpenSSL we have to extract the curve from key on our own */
>          EC_KEY *eckey = NULL;
>          const EC_GROUP *ecgrp = NULL;
>          EVP_PKEY *pkey = NULL;
>  
> -#if OPENSSL_VERSION_NUMBER >= 0x10002000L && !defined(LIBRESSL_VERSION_NUMBER)
> -        pkey = SSL_CTX_get0_privatekey(ctx->ctx);
> -#else
>          /* Little hack to get private key ref from SSL_CTX, yay OpenSSL... */
>          SSL *ssl = SSL_new(ctx->ctx);
>          if (!ssl)
> @@ -517,7 +512,6 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
>          }
>          pkey = SSL_get_privatekey(ssl);
>          SSL_free(ssl);
> -#endif
>  
>          msg(D_TLS_DEBUG, "Extracting ECDH curve from private key");
>  
> @@ -526,6 +520,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
>          {
>              nid = EC_GROUP_get_curve_name(ecgrp);
>          }
> +#endif
>      }
>  
>      /* Translate NID back to name , just for kicks */
> 

ACK.  Patch looks good, and this still works as expected with both
OpenSSL 1.0.1 and 1.0.2 (both #if branches).

-Steffan

