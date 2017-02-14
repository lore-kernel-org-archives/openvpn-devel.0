References: <20170213183826.73008-1-O2Graphics@...2243...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2b6b9f32-ef12-ea5f-ec3b-298f49bba1ec@...1856...>
Date: Tue, 14 Feb 2017 23:00:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170213183826.73008-1-O2Graphics@...2243...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack. Similar to what is done in curl:
 https://github.com/curl/curl/blob/028391df5d84d9fae3433afdee9261d565900355/lib/vtls/openssl.c#L603-L619
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 13-02-17 19:38, O2 Graphics wrote:
> Use SSL_CTX_get0_privatekey() for OpenSSL >= 1.0.2
> 
> Signed-off-by: Olivier Wahrenberger <olivierw.ml@...277...>
> ---
>  src/openvpn/ssl_openssl.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 8266595..abf69c9 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -508,10 +508,18 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
>          const EC_GROUP *ecgrp = NULL;
>          EVP_PKEY *pkey = NULL;
>  
> +#if OPENSSL_VERSION_NUMBER >= 0x10002000L && !defined(LIBRESSL_VERSION_NUMBER)
> +        pkey = SSL_CTX_get0_privatekey(ctx->ctx);
> +#else
>          /* Little hack to get private key ref from SSL_CTX, yay OpenSSL... */
> -        SSL ssl;
> -        ssl.cert = ctx->ctx->cert;
> -        pkey = SSL_get_privatekey(&ssl);
> +        SSL *ssl = SSL_new(ctx->ctx);
> +        if (!ssl)
> +        {
> +            crypto_msg(M_FATAL, "SSL_new failed");
> +        }
> +        pkey = SSL_get_privatekey(ssl);
> +        SSL_free(ssl);
> +#endif
>  
>          msg(D_TLS_DEBUG, "Extracting ECDH curve from private key");
>  
> 

Code still looks good, patch looks a lot better (applies cleanly now),
but could use an extra newline in the subject.  But that doesn't warrant
an extra patch iteration, so ACK.

-Steffan

