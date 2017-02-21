References: <cover.1487368114.git.logout@...260...>
	<11477a0a3cf636572c84e0110a6f1b726bc60c2c.1487368114.git.logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <1b42bd0d-ffbf-8c09-e313-13474b723a16@...1856...>
Date: Tue, 21 Feb 2017 22:30:57 +0100
MIME-Version: 1.0
In-Reply-To: <11477a0a3cf636572c84e0110a6f1b726bc60c2c.1487368114.git.logout@...260...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 09/15] OpenSSL: don't use direct
 access to the internal of X509_STORE_CTX
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

On 17-02-17 23:00, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
> 
> OpenSSL 1.1 does not allow us to directly access the internal of
> any data type, including X509_STORE_CTX. We have to use the defined
> functions to do so.
> 
> Fortunately, these functions have existed since the dawn of time so
> we don't have any compatibility issue here.
> 
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  src/openvpn/ssl_verify_openssl.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
> index edc709b89eb05bca895639dde606b29f8e1f7024..5bdd1e3609c4a2693e16c0835a9e5c39babd5ff8 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -62,14 +62,15 @@ verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
>      session = (struct tls_session *) SSL_get_ex_data(ssl, mydata_index);
>      ASSERT(session);
>  
> -    struct buffer cert_hash = x509_get_sha256_fingerprint(ctx->current_cert, &gc);
> -    cert_hash_remember(session, ctx->error_depth, &cert_hash);
> +    X509 *current_cert = X509_STORE_CTX_get_current_cert(ctx);
> +    struct buffer cert_hash = x509_get_sha256_fingerprint(current_cert, &gc);
> +    cert_hash_remember(session, X509_STORE_CTX_get_error_depth(ctx), &cert_hash);
>  
>      /* did peer present cert which was signed by our root cert? */
>      if (!preverify_ok)
>      {
>          /* get the X509 name */
> -        char *subject = x509_get_subject(ctx->current_cert, &gc);
> +        char *subject = x509_get_subject(current_cert, &gc);
>  
>          if (!subject)
>          {
> @@ -77,11 +78,11 @@ verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
>          }
>  
>          /* Log and ignore missing CRL errors */
> -        if (ctx->error == X509_V_ERR_UNABLE_TO_GET_CRL)
> +        if (X509_STORE_CTX_get_error(ctx) == X509_V_ERR_UNABLE_TO_GET_CRL)
>          {
>              msg(D_TLS_DEBUG_LOW, "VERIFY WARNING: depth=%d, %s: %s",
> -                ctx->error_depth,
> -                X509_verify_cert_error_string(ctx->error),
> +                X509_STORE_CTX_get_error_depth(ctx),
> +                X509_verify_cert_error_string(X509_STORE_CTX_get_error(ctx)),
>                  subject);
>              ret = 1;
>              goto cleanup;
> @@ -89,8 +90,8 @@ verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
>  
>          /* Remote site specified a certificate, but it's not correct */
>          msg(D_TLS_ERRORS, "VERIFY ERROR: depth=%d, error=%s: %s",
> -            ctx->error_depth,
> -            X509_verify_cert_error_string(ctx->error),
> +            X509_STORE_CTX_get_error_depth(ctx),
> +            X509_verify_cert_error_string(X509_STORE_CTX_get_error(ctx)),
>              subject);
>  
>          ERR_clear_error();
> @@ -99,7 +100,7 @@ verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
>          goto cleanup;
>      }
>  
> -    if (SUCCESS != verify_cert(session, ctx->current_cert, ctx->error_depth))
> +    if (SUCCESS != verify_cert(session, current_cert, X509_STORE_CTX_get_error_depth(ctx)))
>      {
>          goto cleanup;
>      }
> 

ACK.  Changes look good and tested against OpenSSL 0.9.8, 1.0.0, 1.0.1
and 1.0.2.

-Steffan

