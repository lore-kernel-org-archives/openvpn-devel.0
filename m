References: <20191109120335.1552-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <f1f2963d-7e21-b8e1-6607-65dbee09020b@...1856...>
Date: Sat, 9 Nov 2019 17:07:51 +0100
MIME-Version: 1.0
In-Reply-To: <20191109120335.1552-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v6 1/2] Make tls_version_max return the
 actual maximum version
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

On 09-11-2019 13:03, Arne Schwabe wrote:
> Before OpenSSL 1.1.1 there could be no mismatch between
> compiled and actual OpenSSL version. With OpenSSL 1.1.1 we need
> runtime detection to detect the actual best TLS version supported.
> 
> Allowing this runtime detection also allows removing some of the
> TLS 1.3/OpenSSL 1.1.1 #ifdefs
> 
> Without this patch tls-min-version 1.3 or-highest will actually
> downgrade to TLS 1.3 in the "compiled with 1.1.0 and linked against
> 1.1.1" scenario.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl.c         | 11 +++++------
>  src/openvpn/ssl_openssl.c | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 4455ebb8..e708fc93 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -4194,12 +4194,11 @@ show_available_tls_ciphers(const char *cipher_list,
>  {
>      printf("Available TLS Ciphers, listed in order of preference:\n");
>  
> -#if (ENABLE_CRYPTO_OPENSSL && OPENSSL_VERSION_NUMBER >= 0x1010100fL)
> -    printf("\nFor TLS 1.3 and newer (--tls-ciphersuites):\n\n");
> -    show_available_tls_ciphers_list(cipher_list_tls13, tls_cert_profile, true);
> -#else
> -    (void) cipher_list_tls13;  /* Avoid unused warning */
> -#endif
> +    if (tls_version_max() >= TLS_VER_1_3)
> +    {
> +        printf("\nFor TLS 1.3 and newer (--tls-ciphersuites):\n\n");
> +        show_available_tls_ciphers_list(cipher_list_tls13, tls_cert_profile, true);
> +    }
>  
>      printf("\nFor TLS 1.2 and older (--tls-cipher):\n\n");
>      show_available_tls_ciphers_list(cipher_list, tls_cert_profile, false);
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 07916c3c..e07d6e74 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -215,7 +215,23 @@ int
>  tls_version_max(void)
>  {
>  #if defined(TLS1_3_VERSION)
> +    /* If this is defined we can safely assume TLS 1.3 support */
>      return TLS_VER_1_3;

This clause is no longer needed, right?

> +#elif OPENSSL_VERSION_NUMBER >= 0x10100000L
> +    /*
> +     * The library we are *linked* against is OpenSSL 1.1.1

s/is/might be/ ?

> +     * and therefore supports TLS 1.3. This needs to be checked at runtime
> +     * since we can be compiled against 1.1.0 and then the library can be
> +     * upgraded to 1.1.1
> +     */
> +    if (OpenSSL_version_num() >= 0x1010100fL)
> +    {
> +        return TLS_VER_1_3;
> +    }
> +    else
> +    {
> +        return TLS_VER_1_2;
> +    }
>  #elif defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
>      return TLS_VER_1_2;
>  #elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
> @@ -241,12 +257,20 @@ openssl_tls_version(int ver)
>      {
>          return TLS1_2_VERSION;
>      }
> -#if defined(TLS1_3_VERSION)
>      else if (ver == TLS_VER_1_3)
>      {
> +        /*
> +         * Supporting the library upgraded to TLS1.3 without recompile
> +         * is enough to support here with a simple constant that the same
> +         * as in the TLS 1.3, so spec it is very unlikely that OpenSSL
> +         * will change this constant
> +         */
> +#ifndef TLS1_3_VERSION
> +        return 0x0304;
> +#else

Why not do this outside the function as

  #ifndef TLS1_3_VERSION
  #define TLS1_3_VERSION 0x0304
  #endif

>          return TLS1_3_VERSION;
> -    }
>  #endif
> +    }
>      return 0;
>  }
>  
> @@ -2015,7 +2039,8 @@ show_available_tls_ciphers_list(const char *cipher_list,
>  #if defined(TLS1_3_VERSION)
>      if (tls13)
>      {
> -        SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
> +        SSL_CTX_set_min_proto_version(tls_ctx.ctx,
> +                                      openssl_tls_version(TLS_VER_1_3));
>          tls_ctx_restrict_ciphers_tls13(&tls_ctx, cipher_list);
>      }
>      else
> 

Otherwise looks good.

-Steffan

