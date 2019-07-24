MIME-Version: 1.0
References: <20190403225657.8003-1-rosenp@...277...>
 <20190724152934.9884-1-arne@...1227...>
In-Reply-To: <20190724152934.9884-1-arne@...1227...>
From: Rosen Penev <rosenp@...277...>
Date: Wed, 24 Jul 2019 11:21:34 -0700
Message-ID: <CAKxU2N9R8MCnz0CBjYtEd3NkxG8e9n=m1GvS3f9wQY6255xNKg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] openssl: Fix compilation without
 deprecated OpenSSL 1.1 APIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Jul 24, 2019 at 8:29 AM Arne Schwabe <arne@...1227...> wrote:
>
> From: Rosen Penev <rosenp@...277...>
>
> EVP_CIPHER_CTX_init and _cleanup were deprecated in 1.1 and both were
> replaced with _reset.
>
> EVP_CIPHER_CTX_free in OpenSSL 1.1 replaces the cleanup/free combo of
> earlier OpenSSL version. And OpenSSL 1.0.2 already calls cleanup as part
> of _free.
>
> Therefore we can remove the _cleanup calls and use the OpenSSL 1.1. API
> everywhere.
>
> Also removed initialisation with OpenSSL 1.1 as it is no longer
> needed and causes compilation errors when disabling deprecated APIs.
>
> Same with SSL_CTX_set_ecdh_auto as it got removed.
>
> Patch V3: Use EVP_CIPHER_CTX_reset instead of init/cleanup
>
> Signed-off-by: Rosen Penev <rosenp@...277...>
> Signed-off-by: Arne Schwabe <arne@...1227...>
ACK
> ---
>  configure.ac                 |  3 +++
>  src/openvpn/crypto.c         |  1 -
>  src/openvpn/crypto_backend.h |  9 +--------
>  src/openvpn/crypto_mbedtls.c |  7 +------
>  src/openvpn/crypto_openssl.c |  8 +-------
>  src/openvpn/openssl_compat.h | 12 ++++++++++++
>  src/openvpn/ssl_openssl.c    | 18 ++++++++++++------
>  7 files changed, 30 insertions(+), 28 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 59673e04..b8e2476f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -918,10 +918,13 @@ if test "${with_crypto_library}" = "openssl"; then
>                         EVP_MD_CTX_new \
>                         EVP_MD_CTX_free \
>                         EVP_MD_CTX_reset \
> +                       EVP_CIPHER_CTX_reset \
>                         OpenSSL_version \
>                         SSL_CTX_get_default_passwd_cb \
>                         SSL_CTX_get_default_passwd_cb_userdata \
>                         SSL_CTX_set_security_level \
> +                       X509_get0_notBefore \
> +                       X509_get0_notAfter \
>                         X509_get0_pubkey \
>                         X509_STORE_get0_objects \
>                         X509_OBJECT_free \
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 8a92a8c1..585bfbc6 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -906,7 +906,6 @@ free_key_ctx(struct key_ctx *ctx)
>  {
>      if (ctx->cipher)
>      {
> -        cipher_ctx_cleanup(ctx->cipher);
>          cipher_ctx_free(ctx->cipher);
>          ctx->cipher = NULL;
>      }
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index 7e9a4bd2..d119442f 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -341,7 +341,7 @@ bool cipher_kt_mode_aead(const cipher_kt_t *cipher);
>  cipher_ctx_t *cipher_ctx_new(void);
>
>  /**
> - * Free a cipher context
> + * Cleanup and free a cipher context
>   *
>   * @param ctx           Cipher context.
>   */
> @@ -360,13 +360,6 @@ void cipher_ctx_free(cipher_ctx_t *ctx);
>  void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key, int key_len,
>                       const cipher_kt_t *kt, int enc);
>
> -/**
> - * Cleanup the specified context.
> - *
> - * @param ctx   Cipher context to cleanup.
> - */
> -void cipher_ctx_cleanup(cipher_ctx_t *ctx);
> -
>  /**
>   * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV is
>   * used.
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index 2e931440..f924323d 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -616,12 +616,6 @@ cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, int key_len,
>      ASSERT(ctx->key_bitlen <= key_len*8);
>  }
>
> -void
> -cipher_ctx_cleanup(mbedtls_cipher_context_t *ctx)
> -{
> -    mbedtls_cipher_free(ctx);
> -}
> -
>  int
>  cipher_ctx_iv_length(const mbedtls_cipher_context_t *ctx)
>  {
> @@ -861,6 +855,7 @@ md_ctx_new(void)
>  void
>  md_ctx_free(mbedtls_md_context_t *ctx)
>  {
> +    mbedtls_cipher_free(ctx);
>      free(ctx);
>  }
>
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index c049e52d..520e40ee 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -772,7 +772,7 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key, int key_len,
>  {
>      ASSERT(NULL != kt && NULL != ctx);
>
> -    EVP_CIPHER_CTX_init(ctx);
> +    EVP_CIPHER_CTX_reset(ctx);
>      if (!EVP_CipherInit(ctx, kt, NULL, NULL, enc))
>      {
>          crypto_msg(M_FATAL, "EVP cipher init #1");
> @@ -792,12 +792,6 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key, int key_len,
>      ASSERT(EVP_CIPHER_CTX_key_length(ctx) <= key_len);
>  }
>
> -void
> -cipher_ctx_cleanup(EVP_CIPHER_CTX *ctx)
> -{
> -    EVP_CIPHER_CTX_cleanup(ctx);
> -}
> -
>  int
>  cipher_ctx_iv_length(const EVP_CIPHER_CTX *ctx)
>  {
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index a4072b9a..4ac8f24d 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -89,6 +89,18 @@ EVP_MD_CTX_new(void)
>  }
>  #endif
>
> +#if !defined(HAVE_EVP_CIPHER_CTX_RESET)
> +#define EVP_CIPHER_CTX_reset EVP_CIPHER_CTX_init
> +#endif
> +
> +#if !defined(HAVE_X509_GET0_NOTBEFORE)
> +#define X509_get0_notBefore X509_get_notBefore
> +#endif
> +
> +#if !defined(HAVE_X509_GET0_NOTAFTER)
> +#define X509_get0_notAfter X509_get_notAfter
> +#endif
> +
>  #if !defined(HAVE_HMAC_CTX_RESET)
>  /**
>   * Reset a HMAC context
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 05ca4113..c029d0f2 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -76,12 +76,13 @@ int mydata_index; /* GLOBAL */
>  void
>  tls_init_lib(void)
>  {
> +#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER))
>      SSL_library_init();
> -#ifndef ENABLE_SMALL
> +# ifndef ENABLE_SMALL
>      SSL_load_error_strings();
> -#endif
> +# endif
>      OpenSSL_add_all_algorithms();
> -
> +#endif
>      mydata_index = SSL_get_ex_new_index(0, "struct session *", NULL, NULL, NULL);
>      ASSERT(mydata_index >= 0);
>  }
> @@ -89,9 +90,11 @@ tls_init_lib(void)
>  void
>  tls_free_lib(void)
>  {
> +#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER))
>      EVP_cleanup();
> -#ifndef ENABLE_SMALL
> +# ifndef ENABLE_SMALL
>      ERR_free_strings();
> +# endif
>  #endif
>  }
>
> @@ -567,7 +570,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
>          goto cleanup; /* Nothing to check if there is no certificate */
>      }
>
> -    ret = X509_cmp_time(X509_get_notBefore(cert), NULL);
> +    ret = X509_cmp_time(X509_get0_notBefore(cert), NULL);
>      if (ret == 0)
>      {
>          msg(D_TLS_DEBUG_MED, "Failed to read certificate notBefore field.");
> @@ -577,7 +580,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
>          msg(M_WARN, "WARNING: Your certificate is not yet valid!");
>      }
>
> -    ret = X509_cmp_time(X509_get_notAfter(cert), NULL);
> +    ret = X509_cmp_time(X509_get0_notAfter(cert), NULL);
>      if (ret == 0)
>      {
>          msg(D_TLS_DEBUG_MED, "Failed to read certificate notAfter field.");
> @@ -660,10 +663,13 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
>      else
>      {
>  #if OPENSSL_VERSION_NUMBER >= 0x10002000L
> +#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER))
> +
>          /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter
>           * loading */
>          SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
>          return;
> +#endif
>  #else
>          /* For older OpenSSL we have to extract the curve from key on our own */
>          EC_KEY *eckey = NULL;
> --
> 2.22.0
>

