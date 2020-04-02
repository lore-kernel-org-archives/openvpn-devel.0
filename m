References: <20200402081829.28362-1-arne@...1227...>
 <20200402103821.10347-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <3e15acf9-30a4-1b1d-581a-7366e4b58c45@...2181...>
Date: Thu, 2 Apr 2020 15:15:16 +0200
MIME-Version: 1.0
In-Reply-To: <20200402103821.10347-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Fix OpenSSL error stack handling of
 tls_ctx_add_extra_certs
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

On 02/04/2020 12:38, Arne Schwabe wrote:
> Commit f67efa94 exposed that tls_ctx_add_extra_certs will always leave
> an error of PEM_R_NO_START_LINE on the stack that will printed the next
> time that the error is printed.
> 
> Fix this by discarding this error. Also clean up the logic to report
> real error on other errors and also the no start line error if no
> certificate can be found at all and it is required (--extra-certs
> config option)
> 
> Patch V2: fix optional flag was flipped betwen --cert and --extra-certs
> Patch V3: Make logic more easy to follow, no functional changes
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl_openssl.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 3f0031ff..1731474d 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -881,24 +881,36 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
>  #endif /* ENABLE_CRYPTOAPI */
>  
>  static void
> -tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio)
> +tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio, bool optional)
>  {
>      X509 *cert;
> -    for (;; )
> +    while (true)
>      {
>          cert = NULL;
> -        if (!PEM_read_bio_X509(bio, &cert, NULL, NULL)) /* takes ownership of cert */
> -        {
> -            break;
> -        }
> -        if (!cert)
> +        if (!PEM_read_bio_X509(bio, &cert, NULL, NULL))
>          {
> +            /*  Error indicates that no certificate is found in the buffer.

I would substitute "Error" with "PEM_R_NO_START_LINE" for clarity

> +             *  If loading more certificates is optional, break without
> +             *  raising an error */
> +

This empty line should be removed

> +            if (optional
> +                && ERR_GET_REASON(ERR_peek_error()) == PEM_R_NO_START_LINE)
> +            {
> +                /* remove that error from error stack */
> +                (void)ERR_get_error();
> +                break;
> +            }
> +
> +            /* Otherwise, bail out with error */
>              crypto_msg(M_FATAL, "Error reading extra certificate");
>          }
> +        /* takes ownership of cert like a set1 method */
>          if (SSL_CTX_add_extra_chain_cert(ctx->ctx, cert) != 1)
>          {
>              crypto_msg(M_FATAL, "Error adding extra certificate");
>          }
> +        /* We loaded at least one certificate, so loading more is optional */
> +        optional = true;
>      }
>  }
>  
> @@ -942,7 +954,7 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
>      ret = SSL_CTX_use_certificate(ctx->ctx, x);
>      if (ret)
>      {
> -        tls_ctx_add_extra_certs(ctx, in);
> +        tls_ctx_add_extra_certs(ctx, in, true);
>      }
>  
>  end:
> @@ -1663,7 +1675,7 @@ tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
>      }
>      else
>      {
> -        tls_ctx_add_extra_certs(ctx, in);
> +        tls_ctx_add_extra_certs(ctx, in, false);
>      }
>  
>      BIO_free(in);
> 


The rest looks good!

I reviewed the code and tested it with different combinations of files
provided to --cert and --extra-certs.

It all works as expected:
- an empty extra-certs file leads to a critical failure with an OpenSSL
error printed to screen;
- empty cert file leads to the same as above;
- proper cert and extra-certs files result to no error printed to screen
and everything works


Acked-by: Antonio Quartulli <a@...2181...>


Cheers,

-- 
Antonio Quartulli

