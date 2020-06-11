References: <20200605112519.22714-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <b73d3b8b-0436-5cd6-6cb1-b3d8ce1d152f@...1856...>
Date: Thu, 11 Jun 2020 10:36:01 +0200
MIME-Version: 1.0
In-Reply-To: <20200605112519.22714-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/3] Make cipher_kt_name always return
 normalised cipher name
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

On 05-06-2020 13:25, Arne Schwabe wrote:
> The mbed TLS variant of the call already returned the normalised
> name while the OpenSSL variant did not. On top of that, all calls but
> one to cipher_kt_name were translate_cipher_name_to_openvpn. This commit
> moves the call of translate_cipher_name_to_openvpn into cipher_kt_name
> or avoids calling it twice in the case of mbed TLS.
> 
> The one case that did not translate_cipher_name_to_openvpn is an
> internal ssl_openssl.c method that should call EVP_CIPHER_name anyway.
> 
> Also simplify cipher_name_cmp function that is only used by
> openvpn --show-ciphers with the modified cipher_kt_name
> function.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/crypto.c         |  4 ++--
>  src/openvpn/crypto_backend.h |  2 ++
>  src/openvpn/crypto_openssl.c | 13 +++++--------
>  src/openvpn/options.c        |  3 +--
>  src/openvpn/ssl_ncp.c        |  3 +--
>  5 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 2388027c..ba1fc095 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -847,7 +847,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
>          cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher_length,
>                          kt->cipher, enc);
>  
> -        const char *ciphername = translate_cipher_name_to_openvpn(cipher_kt_name(kt->cipher));
> +        const char *ciphername = cipher_kt_name(kt->cipher);
>          msg(D_HANDSHAKE, "%s: Cipher '%s' initialized with %d bit key",
>              prefix,
>              ciphername,
> @@ -1810,7 +1810,7 @@ print_cipher(const cipher_kt_t *cipher)
>                                 " by default" : "";
>  
>      printf("%s  (%d bit key%s, ",
> -           translate_cipher_name_to_openvpn(cipher_kt_name(cipher)),
> +           cipher_kt_name(cipher),
>             cipher_kt_key_size(cipher) * 8, var_key_size);
>  
>      if (cipher_kt_block_size(cipher) == 1)
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index 1d206a8c..d46cb63f 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -237,6 +237,8 @@ const cipher_kt_t *cipher_kt_get(const char *ciphername);
>  
>  /**
>   * Retrieve a string describing the cipher (e.g. \c AES-128-CBC).
> + * The returned name is normalised to the OpenVPN config name in case the
> + * name differs from the name used by the crypto library.
>   *
>   * @param cipher_kt     Static cipher parameters
>   *
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index a5b2c45a..13ab4859 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -266,12 +266,7 @@ cipher_name_cmp(const void *a, const void *b)
>      const EVP_CIPHER *const *cipher_a = a;
>      const EVP_CIPHER *const *cipher_b = b;
>  
> -    const char *cipher_name_a =
> -        translate_cipher_name_to_openvpn(EVP_CIPHER_name(*cipher_a));
> -    const char *cipher_name_b =
> -        translate_cipher_name_to_openvpn(EVP_CIPHER_name(*cipher_b));
> -
> -    return strcmp(cipher_name_a, cipher_name_b);
> +    return strcmp(cipher_kt_name(*cipher_a), cipher_kt_name(*cipher_b));
>  }
>  
>  void
> @@ -613,7 +608,9 @@ cipher_kt_name(const EVP_CIPHER *cipher_kt)
>      {
>          return "[null-cipher]";
>      }
> -    return EVP_CIPHER_name(cipher_kt);
> +
> +    const char *name = EVP_CIPHER_name(cipher_kt);
> +    return translate_cipher_name_to_openvpn(name);
>  }
>  
>  int
> @@ -644,7 +641,7 @@ cipher_kt_block_size(const EVP_CIPHER *cipher)
>  
>      int block_size = EVP_CIPHER_block_size(cipher);
>  
> -    orig_name = cipher_kt_name(cipher);
> +    orig_name = EVP_CIPHER_name(cipher);
>      if (!orig_name)
>      {
>          goto cleanup;
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index d1e68a51..ec912d34 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3779,8 +3779,7 @@ options_string(const struct options *o,
>          init_key_type(&kt, o->ciphername, o->authname, o->keysize, true,
>                        false);
>  
> -        buf_printf(&out, ",cipher %s",
> -                   translate_cipher_name_to_openvpn(cipher_kt_name(kt.cipher)));
> +        buf_printf(&out, ",cipher %s", cipher_kt_name(kt.cipher));
>          buf_printf(&out, ",auth %s", md_kt_name(kt.digest));
>          buf_printf(&out, ",keysize %d", kt.cipher_length * 8);
>          if (o->shared_secret_file)
> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
> index 9ed6ff5f..042b0ce0 100644
> --- a/src/openvpn/ssl_ncp.c
> +++ b/src/openvpn/ssl_ncp.c
> @@ -116,8 +116,7 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
>          }
>          else
>          {
> -            const char *ovpn_cipher_name =
> -                translate_cipher_name_to_openvpn(cipher_kt_name(ktc));
> +            const char *ovpn_cipher_name = cipher_kt_name(ktc);
>  
>              if (buf_len(&new_list)> 0)
>              {
> 

Makes sense, changes look good and passes my tests.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

