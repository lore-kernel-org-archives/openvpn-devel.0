Message-ID: <53566C9B.6040704@...1227...>
Date: Tue, 22 Apr 2014 15:20:27 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <mailman.123335.1398139175.2178.openvpn-devel@lists.sourceforge.net>
	<53565DCE.2000608@...1901...>
In-Reply-To: <53565DCE.2000608@...1901...>
Subject: Re: [Openvpn-devel] tls-version-min in Openvpn-devel Digest, Vol 95,
 Issue 27
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Timothe Litt <litt@...1901...>, openvpn-devel@lists.sourceforge.net


>
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 0b63e26..0785ce4 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -98,10 +98,10 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
>  {
>    ASSERT(NULL != ctx);
>
> -  ctx->ctx = SSL_CTX_new (SSLv23_server_method ());
> +  ctx->ctx = SSL_CTX_new (TLSv1_server_method ());
>
>    if (ctx->ctx == NULL)
> -    msg (M_SSLERR, "SSL_CTX_new SSLv23_server_method");
> +    msg (M_SSLERR, "SSL_CTX_new TLSv1_server_method");
>  }
>
>  void
> @@ -109,10 +109,10 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
>  {
>    ASSERT(NULL != ctx);
>
> -  ctx->ctx = SSL_CTX_new (SSLv23_client_method ());
> +  ctx->ctx = SSL_CTX_new (TLSv1_client_method ());
>
>    if (ctx->ctx == NULL)
> -    msg (M_SSLERR, "SSL_CTX_new SSLv23_client_method");
> +    msg (M_SSLERR, "SSL_CTX_new TLSv1_client_method");
>  }
>
Your patch has the same effect. I effectively disables all TLS 1.1+. The
OpenSSL API names are terribly confusing.

SLv23_client_method will negoiate the highest protocol available and TLSv1_client_method
 will only negoiate TLS 1.0

Arne


