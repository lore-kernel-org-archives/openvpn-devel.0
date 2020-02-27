References: <20191021113506.30377-1-santtu.lakkala@...2530...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <9b825a8b-b40f-273c-a7fc-36086edbf22c@...1856...>
Date: Thu, 27 Feb 2020 16:03:24 +0100
MIME-Version: 1.0
In-Reply-To: <20191021113506.30377-1-santtu.lakkala@...2530...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix OpenSSL private key passphrase
 notices
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

On 21-10-2019 13:35, Santtu Lakkala wrote:
> Clear error stack on successful certificate loading in
> tls_ctx_load_cert_file_and_copy() and handle errors also for
> PEM_read_bio_PrivateKey() call in tls_ctx_load_priv_file().
> 
> Due to certificate loading possibly leaking non-fatal errors on OpenSSL
> error stack, and some slight oversights in error handling, the
> 
>> PASSWORD:Verification Failed: 'Private Key'
> 
> line was never produced on the management channel for PEM formatted keys.
> 
> Signed-off-by: Santtu Lakkala <santtu.lakkala@...2530...>
> ---
>  src/openvpn/ssl_openssl.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 07916c3c..74c8fa65 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -921,6 +921,10 @@ end:
>              crypto_msg(M_FATAL, "Cannot load certificate file %s", cert_file);
>          }
>      }
> +    else
> +    {
> +        crypto_print_openssl_errors(M_DEBUG);
> +    }
>  
>      if (in != NULL)
>      {
> @@ -963,12 +967,7 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
>      pkey = PEM_read_bio_PrivateKey(in, NULL,
>                                     SSL_CTX_get_default_passwd_cb(ctx->ctx),
>                                     SSL_CTX_get_default_passwd_cb_userdata(ctx->ctx));
> -    if (!pkey)
> -    {
> -        goto end;
> -    }
> -
> -    if (!SSL_CTX_use_PrivateKey(ssl_ctx, pkey))
> +    if (!pkey || !SSL_CTX_use_PrivateKey(ssl_ctx, pkey))
>      {
>  #ifdef ENABLE_MANAGEMENT
>          if (management && (ERR_GET_REASON(ERR_peek_error()) == EVP_R_BAD_DECRYPT))
> 

Thanks, and apologies for the late repsonse. This patch does was it
says, and looks good to me. I think this one should go into both master
and release/2.4.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

