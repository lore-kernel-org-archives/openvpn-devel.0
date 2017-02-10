References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
	<CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
Date: Fri, 10 Feb 2017 22:20:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Olivier W <olivierw.ml@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 09-02-17 21:04, Olivier W wrote:
> Hello,
> Please find the new version of the patch.
> 
> So, I added back the comment I had removed and new versions of OpenSSL
> will use SSL_CTX_get0_privatekey() instead of SSL_new() +
> SSL_get_privatekey() + SSL_free().
> 
> It successfully compile with LibreSSL 2.4.5, 2.5.1 and OpenSSL 1.0.2k.
> I've also pushed it to Github and Travis-CI is currently running:
> https://github.com/OpenVPN/openvpn/pull/82
> 
> Best Regards,
> Olivier
> 
> ---
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 8266595..abf69c9 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -508,10 +508,18 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx
> *ctx, const char *curve_name
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

The code change looks good to me, so ACK to that.

The commit does need a better commit message though, and somewhere in
the process the newlines got mangled.  I think the commit message of
your initial patch is okay, it just missed the Signed-off-by line.  To
smoothen the patch application process, could you create a commit with
the above change, and send it to the list using git send-email?  The
command line would be something like:

git send-email --to=openvpn-devel@lists.sourceforge.net HEAD~1

Otherwise, Gert or David will have to wrestle a commit together from you
various messages, and that will likely take more time before it gets
applied.

Thanks,
-Steffan

