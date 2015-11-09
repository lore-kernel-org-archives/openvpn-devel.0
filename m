Message-ID: <5640A384.8080206@...1147...>
Date: Mon, 09 Nov 2015 14:45:40 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1444383559-15788-1-git-send-email-janjust@...1147...>	<1444948995-18720-1-git-send-email-steffan@...1856...>
	<1444948995-18720-3-git-send-email-steffan@...1856...>
In-Reply-To: <1444948995-18720-3-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] polarssl: add --verify-client-cert
 optional support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Ack to this patch (but remember to apply my patch first :))

JJK

Steffan Karger wrote:
> This adds support for the --verify-client-cert optional option in PolarSSL
> builds, as was earlier added for OpenSSL builds by Jan-Just Keijser.
>
> This patch also adds an additional sanity check that this option may only
> be used in combination with some other authentication method, and changes
> the warning message about this option to be displayed only once on startup,
> instead of for each connecting client.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/options.c      | 13 ++++++++++---
>  src/openvpn/ssl_openssl.c  |  8 +++-----
>  src/openvpn/ssl_polarssl.c | 10 ++++------
>  3 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index b2248b0..c88a180 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2053,8 +2053,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
>  			     || PLUGIN_OPTION_LIST (options)
>  			     || MAN_CLIENT_AUTH_ENABLED (options));
>  	  const char *postfix = "must be used with --management-client-auth, an --auth-user-pass-verify script, or plugin";
> -	  if ((options->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED) && !ccnr)
> -	    msg (M_USAGE, "--client-cert-not-required %s", postfix);
> +	  if ((options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL)) && !ccnr)
> +	    msg (M_USAGE, "--verify-client-cert none|optional %s", postfix);
>  	  if ((options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) && !ccnr)
>  	    msg (M_USAGE, "--username-as-common-name %s", postfix);
>  	  if ((options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) && !ccnr)
> @@ -2088,7 +2088,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
>  	msg (M_USAGE, "--duplicate-cn requires --mode server");
>        if (options->cf_max || options->cf_per)
>  	msg (M_USAGE, "--connect-freq requires --mode server");
> -      if (options->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED || options->ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
> +      if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL))
>  	msg (M_USAGE, "--client-cert-not-required and --verify-client-cert require --mode server");
>        if (options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
>  	msg (M_USAGE, "--username-as-common-name requires --mode server");
> @@ -2136,6 +2136,13 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
>        (options->shared_secret_file != NULL) > 1)
>      msg (M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
>  
> +  if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL))
> +    {
> +      msg (M_WARN, "WARNING: POTENTIALLY DANGEROUS OPTION "
> +	  "--verify-client-cert none|optional (or --client-cert-not-required) "
> +	  "may accept clients which do not present a certificate");
> +    }
> +
>    if (options->tls_server || options->tls_client)
>      {
>  #ifdef ENABLE_PKCS11
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 3528ed4..3462d34 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -256,14 +256,12 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
>  #if P2MP_SERVER
>    if (ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED)
>      {
> -      msg (M_WARN, "WARNING: POTENTIALLY DANGEROUS OPTION "
> -	  "--client-cert-not-required and --verify-client-cert none "
> -      "may accept clients which do not present a certificate");
> -
>        flags = 0;
>      }
>    else if (ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
> -    flags = SSL_VERIFY_PEER;
> +    {
> +      flags = SSL_VERIFY_PEER;
> +    }
>  #endif
>    SSL_CTX_set_verify (ctx->ctx, flags, verify_callback);
>  
> diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
> index 27cd735..cf38e69 100644
> --- a/src/openvpn/ssl_polarssl.c
> +++ b/src/openvpn/ssl_polarssl.c
> @@ -776,18 +776,16 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
>  
>        /* Initialise SSL verification */
>  #if P2MP_SERVER
> -      if (session->opt->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED)
> +      if (session->opt->ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
>  	{
> -	  msg (M_WARN, "WARNING: POTENTIALLY DANGEROUS OPTION "
> -	   "--client-cert-not-required may accept clients which do not present "
> -	   "a certificate");
> +	  ssl_set_authmode(ks_ssl->ctx, SSL_VERIFY_OPTIONAL);
>  	}
> -      else
> +      else if (!(session->opt->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED))
>  #endif
>        {
>  	ssl_set_authmode (ks_ssl->ctx, SSL_VERIFY_REQUIRED);
> -	ssl_set_verify (ks_ssl->ctx, verify_callback, session);
>        }
> +      ssl_set_verify (ks_ssl->ctx, verify_callback, session);
>  
>        /* TODO: PolarSSL does not currently support sending the CA chain to the client */
>        ssl_set_ca_chain (ks_ssl->ctx, ssl_ctx->ca_chain, NULL, NULL );
>   


