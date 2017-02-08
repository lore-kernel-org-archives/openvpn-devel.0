References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
Date: Wed, 8 Feb 2017 23:39:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 06-02-17 20:18, Olivier W wrote:
> Should be compatible with all versions of OpenSSL and LibreSSL.
> Similar to what is done in curl:
> https://github.com/curl/curl/blob/028391df5d84d9fae3433afdee9261d565900355/lib/vtls/openssl.c#L603-L619
> 
> Error while compiling was:
> "ssl_openssl.c:512:30: error: no member named 'cert' in 'struct ssl_ctx_st'
> ssl.cert = ctx->ctx->cert;
> ~ ^
> 1 error generated.
> *** Error code 1"
> ---
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 8266595..a889332 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -508,10 +508,13 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx
> *ctx, const char *curve_name
>          const EC_GROUP *ecgrp = NULL;
>          EVP_PKEY *pkey = NULL;
> 
> -        /* Little hack to get private key ref from SSL_CTX, yay OpenSSL... */
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

The code change looks good, and passes my (manual) tests.  I'd like to
keep the comment though, because this still is a hack/workaround to get
the private key from the SSL_CTX object, it just does so a little nicer
at the cost of a number of malloc/free calls.

It might be even worth noting that the workaround is only needed for
OpenSSL <= 1.0.1, because later versions do have a function to get the
private key from a struct SSL_CTX directly.  By noting that explicitly,
we help ourselves remember to get rid of the hack as soon as we drop
support for these OpenSSL versions.

-Steffan

