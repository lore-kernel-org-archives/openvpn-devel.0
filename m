References: <20181006080617.18136-1-arne@...1227...>
 <20181006080617.18136-3-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <afc594d9-52af-86ab-b3b2-49810752e7e5@...1856...>
Date: Wed, 10 Oct 2018 11:11:34 +0200
MIME-Version: 1.0
In-Reply-To: <20181006080617.18136-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/3] Add better support for showing TLS
 1.3 ciphersuites in --show-tls
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

On 06-10-18 10:06, Arne Schwabe wrote:
> show-tls shows mixed TLS 1.3 and TLS 1.2 ciphers. The ciphersuites
> are only valid in tls-cipher or tls-ciphersuites. So this confusing and
> not really helpful.
> 
> This patch modifies show-tls to show separate lists for TLS 1.2 and
> TLS 1.3.

Feature-ACK.

> ---
>  src/openvpn/init.c        |  1 +
>  src/openvpn/ssl_backend.h |  1 +
>  src/openvpn/ssl_mbedtls.c |  2 +
>  src/openvpn/ssl_openssl.c | 79 ++++++++++++++++++++++++++++++---------
>  4 files changed, 65 insertions(+), 18 deletions(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index b2ab2a60..ff863cf8 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1040,6 +1040,7 @@ print_openssl_info(const struct options *options)
>          if (options->show_tls_ciphers)
>          {
>              show_available_tls_ciphers(options->cipher_list,
> +                                       options->cipher_list_tls13,
>                                         options->tls_cert_profile);
>          }
>          if (options->show_curves)
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index 0995bb4c..42934230 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -525,6 +525,7 @@ void print_details(struct key_state_ssl *ks_ssl, const char *prefix);
>   */
>  void
>  show_available_tls_ciphers(const char *cipher_list,
> +                           const char *cipher_list_tls13,
>                             const char *tls_cert_profile);

Please update to doxygen to include the extra parameter too.

>  
>  /*
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index f23cd30a..2c6e54b3 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -1341,8 +1341,10 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
>  
>  void
>  show_available_tls_ciphers(const char *cipher_list,
> +                           const char *cipher_list_tls13,
>                             const char *tls_cert_profile)
>  {
> +    (void) cipher_list_tls13; // Avoid unused warning
>      struct tls_root_ctx tls_ctx;
>      const int *ciphers = mbedtls_ssl_list_ciphersuites();
>  
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index e3f02d05..044070fe 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -60,6 +60,7 @@
>  #include <openssl/pkcs12.h>
>  #include <openssl/rsa.h>
>  #include <openssl/x509.h>
> +#include <openssl/ssl.h>
>  #ifndef OPENSSL_NO_EC
>  #include <openssl/ec.h>
>  #endif
> @@ -1978,15 +1979,12 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
>      msg(D_HANDSHAKE, "%s%s", s1, s2);
>  }
>  
> -void
> -show_available_tls_ciphers(const char *cipher_list,
> -                           const char *tls_cert_profile)
> +static void
> +show_available_tls_ciphers_list(const char *cipher_list,
> +                           const char *tls_cert_profile,
> +                           const bool tls13)

Argument alignment is now off due to function rename.

>  {
>      struct tls_root_ctx tls_ctx;
> -    SSL *ssl;
> -    const char *cipher_name;
> -    const tls_cipher_name_pair *pair;
> -    int priority = 0;
>  
>      tls_ctx.ctx = SSL_CTX_new(SSLv23_method());
>      if (!tls_ctx.ctx)
> @@ -1994,22 +1992,44 @@ show_available_tls_ciphers(const char *cipher_list,
>          crypto_msg(M_FATAL, "Cannot create SSL_CTX object");
>      }
>  
> -    ssl = SSL_new(tls_ctx.ctx);
> -    if (!ssl)
> +#if (OPENSSL_VERSION_NUMBER >= 0x1010100fL)
> +    if (tls13)
>      {
> -        crypto_msg(M_FATAL, "Cannot create SSL object");
> +        SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
> +    }
> +    else
> +#endif
> +    {
> +        SSL_CTX_set_max_proto_version(tls_ctx.ctx, TLS1_2_VERSION);
>      }
>  
>      tls_ctx_set_cert_profile(&tls_ctx, tls_cert_profile);
>      tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
>  
> -    printf("Available TLS Ciphers,\n");
> -    printf("listed in order of preference:\n\n");
> -    while ((cipher_name = SSL_get_cipher_list(ssl, priority++)))
> +    SSL *ssl = SSL_new(tls_ctx.ctx);
> +    if (!ssl)
>      {
> -        pair = tls_get_cipher_name_pair(cipher_name, strlen(cipher_name));
> +        crypto_msg(M_FATAL, "Cannot create SSL object");
> +    }
> +
> +#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)
> +    STACK_OF(SSL_CIPHER)* sk = SSL_get_ciphers(ssl);
> +#else
> +    STACK_OF(SSL_CIPHER)* sk = SSL_get1_supported_ciphers(ssl);
> +#endif
> +    for (int i=0;i < sk_SSL_CIPHER_num(sk);i++)
> +    {
> +        const SSL_CIPHER* c = sk_SSL_CIPHER_value(sk, i);
> +
> +        const char* cipher_name = SSL_CIPHER_get_name(c);
> +
> +        const tls_cipher_name_pair *pair = tls_get_cipher_name_pair(cipher_name, strlen(cipher_name));
>  
> -        if (NULL == pair)
> +        if (tls13)
> +        {
> +              printf("%s\n", cipher_name);
> +        }
> +        else if (NULL == pair)
>          {
>              /* No translation found, print warning */
>              printf("%s (No IANA name known to OpenVPN, use OpenSSL name.)\n", cipher_name);
> @@ -2018,14 +2038,37 @@ show_available_tls_ciphers(const char *cipher_list,
>          {
>              printf("%s\n", pair->iana_name);
>          }
> -
>      }
> -    printf("\n" SHOW_TLS_CIPHER_LIST_WARNING);
> -
> +#if (OPENSSL_VERSION_NUMBER >= 0x1010000fL)
> +    sk_SSL_CIPHER_free(sk);
> +#endif
>      SSL_free(ssl);
>      SSL_CTX_free(tls_ctx.ctx);
>  }
>  
> +
> +
> +void
> +show_available_tls_ciphers(const char *cipher_list,
> +                           const char *cipher_list_tls13,
> +                           const char *tls_cert_profile)
> +{
> +    printf("Available TLS Ciphers,\n");
> +    printf("listed in order of preference:\n");

Since you are changing the output format anyway, can you merge these
into a single printf and remove the unneeded extra newline halfway
through the sentence?

> +#if (OPENSSL_VERSION_NUMBER >= 0x1010100fL)
> +    printf("\nFor TLS 1.3 and newer (--tls-ciphersuite):\n\n");
> +    show_available_tls_ciphers_list(cipher_list_tls13, tls_cert_profile, true);
> +#else
> +    (void) cipher_list_tls13;  /* Avoid unused warning */
> +#endif
> +
> +    printf("\nFor TLS 1.2 and older (--tls-cipher):\n\n");
> +    show_available_tls_ciphers_list(cipher_list, tls_cert_profile, false);
> +
> +    printf("\n" SHOW_TLS_CIPHER_LIST_WARNING);
> +}
> +
>  /*
>   * Show the Elliptic curves that are available for us to use
>   * in the OpenSSL library.
> 

Otherwise the patch looks good.

-Steffan

