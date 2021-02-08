References: <20210201174310.22153-1-arne@...1227...>
 <20210201174310.22153-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <38fb2928-d5ee-e940-32e7-15b2534565c2@...2181...>
Date: Mon, 8 Feb 2021 14:32:21 +0100
MIME-Version: 1.0
In-Reply-To: <20210201174310.22153-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 2/3] Prefer TLS libraries TLS PRF
 function, fix OpenVPN in FIPS mode
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

there are some indendation issues still open in this patch. Please see below

On 01/02/2021 18:43, Arne Schwabe wrote:
> This moves from using our own copy of the TLS1 PRF function to using
> TLS library provided function where possible. This includes currently
> OpenSSL 1.1.0+ and mbed TLS 2.18+.
> 
> For the libraries where it is not possible to use the library's own
> function, we still use our own implementation. mbed TLS will continue
> to use our own old PRF function while for OpenSSL we will use a
> adapted version from OpenSSL 1.0.2t code. The version allows to be
> used in a FIPS enabled environment.
> 
> The old OpenSSL and mbed TLS implementation could have shared some
> more code but as we will eventually drop support for older TLS
> libraries, the separation makes it easier it remove that code
> invdidually.
> 
> In FIPS mode MD5 is normally forbidden, the TLS1 PRF1 function we
> use, makes uses of MD5, which in the past has caused OpenVPN to segfault.
> The new implementation for OpenSSL version of our custom implementation
> has added the special flags that tell OpenSSL that this specific use
> of MD5 is allowed in FIPS mode.
> 
> No FIPS conformitiy testing etc has been done, this is only about
> allowing OpenVPN on a system where FIPS mode has been enabled system
> wide (e.g. on RHEL derivates).
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                            |  10 +-
>  src/openvpn/crypto_backend.h           |  14 +++
>  src/openvpn/crypto_mbedtls.c           | 134 ++++++++++++++++++++
>  src/openvpn/crypto_openssl.c           | 165 +++++++++++++++++++++++++
>  src/openvpn/ssl.c                      | 130 +------------------
>  tests/unit_tests/openvpn/test_crypto.c |  32 +++++
>  6 files changed, 351 insertions(+), 134 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 2a847564..0c66fe2a 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -9,11 +9,11 @@ Keying Material Exporters (RFC 5705) based key generation
>      the RFC5705 based key material generation to the current custom
>      OpenVPN PRF. This feature requires OpenSSL or mbed TLS 2.18+.
>  
> -Deprecated features
> --------------------
> -``inetd`` has been removed
> -    This was a very limited and not-well-tested way to run OpenVPN, on TCP
> -    and TAP mode only.
> +Compatibility with OpenSSL in FIPS mode
> +    OpenVPN will now work with OpenSSL in FIPS mode. Note, no effort
> +    has been made to check or implement all the
> +    requirements/recommendation of FIPS 140-2. This just allows OpenVPN
> +    to be run on a system that be configured OpenSSL in FIPS mode.
>  
>  
>  Overview of changes in 2.5
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index 85cb084a..d86d9a34 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -699,4 +699,18 @@ const char *translate_cipher_name_from_openvpn(const char *cipher_name);
>   */
>  const char *translate_cipher_name_to_openvpn(const char *cipher_name);
>  
> +
> +/**
> + * Calculates the TLS 1.0-1.1 PRF function. For the exact specification of the
> + * function definition see the TLS RFCs like RFC 4346.
> + *
> + * @param seed          seed to use
> + * @param seed_len      length of the seed
> + * @param secret        secret to use
> + * @param secret_len    length of the secret
> + * @param output        output destination
> + * @param output_len    length of output/number of bytes to generate
> + */
> +void ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
> +                  int secret_len, uint8_t *output, int output_len);
>  #endif /* CRYPTO_BACKEND_H_ */
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index fbb1f120..5ed88d6d 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -54,6 +54,7 @@
>  #include <mbedtls/pem.h>
>  
>  #include <mbedtls/entropy.h>
> +#include <mbedtls/ssl.h>
>  
>  
>  /*
> @@ -984,4 +985,137 @@ memcmp_constant_time(const void *a, const void *b, size_t size)
>  
>      return diff;
>  }
> +/* mbedtls-2.18.0 or newer */
> +#ifdef HAVE_MBEDTLS_SSL_TLS_PRF
> +void ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
> +                  int secret_len, uint8_t *output, int output_len)
> +{
> +    mbedtls_ssl_tls_prf(MBEDTLS_SSL_TLS_PRF_TLS1, secret, secret_len, "", seed,
> +                        seed_len, output, output_len);
> +}
> +#else
> +/*
> + * Generate the hash required by for the \c tls1_PRF function.
> + *
> + * @param md_kt         Message digest to use
> + * @param sec           Secret to base the hash on
> + * @param sec_len       Length of the secret
> + * @param seed          Seed to hash
> + * @param seed_len      Length of the seed
> + * @param out           Output buffer
> + * @param olen          Length of the output buffer
> + */
> +static void
> +tls1_P_hash(const md_kt_t *md_kt,
> +            const uint8_t *sec,
> +            int sec_len,
> +            const uint8_t *seed,
> +            int seed_len,
> +            uint8_t *out,
> +            int olen)

This should be reindented

> +{
> +    struct gc_arena gc = gc_new();
> +    uint8_t A1[MAX_HMAC_KEY_LENGTH];
> +
> +#ifdef ENABLE_DEBUG
> +    const int olen_orig = olen;
> +    const uint8_t *out_orig = out;
> +#endif
> +
> +    hmac_ctx_t *ctx = hmac_ctx_new();
> +    hmac_ctx_t *ctx_tmp = hmac_ctx_new();
> +
> +    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len, 0, &gc));
> +    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_len, 0, &gc));
> +
> +    int chunk = md_kt_size(md_kt);
> +    unsigned int A1_len = md_kt_size(md_kt);
> +
> +    hmac_ctx_init(ctx, sec, sec_len, md_kt);
> +    hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt);
> +
> +    hmac_ctx_update(ctx,seed,seed_len);
> +    hmac_ctx_final(ctx, A1);
> +
> +    for (;;)
> +    {
> +        hmac_ctx_reset(ctx);
> +        hmac_ctx_reset(ctx_tmp);
> +        hmac_ctx_update(ctx, A1, A1_len);
> +        hmac_ctx_update(ctx_tmp, A1, A1_len);
> +        hmac_ctx_update(ctx, seed, seed_len);
> +
> +        if (olen > chunk)
> +        {
> +            hmac_ctx_final(ctx, out);
> +            out += chunk;
> +            olen -= chunk;
> +            hmac_ctx_final(ctx_tmp, A1); /* calc the next A1 value */
> +        }
> +        else    /* last one */
> +        {
> +            hmac_ctx_final(ctx, A1);
> +            memcpy(out, A1, olen);
> +            break;
> +        }
> +    }
> +    hmac_ctx_cleanup(ctx);
> +    hmac_ctx_free(ctx);
> +    hmac_ctx_cleanup(ctx_tmp);
> +    hmac_ctx_free(ctx_tmp);
> +    secure_memzero(A1, sizeof(A1));
> +
> +    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash out: %s", format_hex(out_orig, olen_orig, 0, &gc));
> +    gc_free(&gc);
> +}
> +
> +/*
> + * Use the TLS PRF function for generating data channel keys.
> + * This code is based on the OpenSSL library.
> + *
> + * TLS generates keys as such:
> + *
> + * master_secret[48] = PRF(pre_master_secret[48], "master secret",
> + *                         ClientHello.random[32] + ServerHello.random[32])
> + *
> + * key_block[] = PRF(SecurityParameters.master_secret[48],
> + *                 "key expansion",
> + *                 SecurityParameters.server_random[32] +
> + *                 SecurityParameters.client_random[32]);
> + *
> + * Notes:
> + *
> + * (1) key_block contains a full set of 4 keys.
> + * (2) The pre-master secret is generated by the client.
> + */
> +void
> +ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec, int slen,
> +         uint8_t *out1, int olen)

indentation seems off (?)

> +{
> +    struct gc_arena gc = gc_new();
> +    const md_kt_t *md5 = md_kt_get("MD5");
> +    const md_kt_t *sha1 = md_kt_get("SHA1");
> +
> +    uint8_t *out2 = (uint8_t *) gc_malloc(olen, false, &gc);

remove space after cast

> +
> +    int len = slen/2;
> +    const uint8_t *S1 = sec;
> +    const uint8_t *S2 = &(sec[len]);
> +    len += (slen&1); /* add for odd, make longer */
> +
> +    tls1_P_hash(md5,S1,len,label,label_len,out1,olen);
> +    tls1_P_hash(sha1,S2,len,label,label_len,out2,olen);
> +
> +    for (int i = 0; i<olen; i++)
> +    {
> +        out1[i] ^= out2[i];
> +    }
> +
> +    secure_memzero(out2, olen);
> +
> +    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%d]: %s", olen, format_hex(out1, olen, 0, &gc));
> +
> +    gc_free(&gc);
> +}
> +#endif
>  #endif /* ENABLE_CRYPTO_MBEDTLS */
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index e124a7b6..b42dc044 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -50,6 +50,9 @@
>  #include <openssl/objects.h>
>  #include <openssl/rand.h>
>  #include <openssl/ssl.h>
> +#if OPENSSL_VERSION_NUMBER >= 0x10100000L
> +#include <openssl/kdf.h>
> +#endif
>  
>  /*
>   * Check for key size creepage.
> @@ -1124,4 +1127,166 @@ engine_load_key(const char *file, SSL_CTX *ctx)
>  #endif /* if HAVE_OPENSSL_ENGINE */
>  }
>  
> +#if OPENSSL_VERSION_NUMBER >= 0x10100000L
> +void ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
> +                  int secret_len, uint8_t *output, int output_len)
> +{
> +    EVP_PKEY_CTX *pctx = EVP_PKEY_CTX_new_id(EVP_PKEY_TLS1_PRF, NULL);
> +    ASSERT(EVP_PKEY_derive_init(pctx) == 1);
> +
> +    ASSERT(EVP_PKEY_CTX_set_tls1_prf_md(pctx, EVP_md5_sha1()) == 1);
> +
> +    ASSERT(EVP_PKEY_CTX_set1_tls1_prf_secret(pctx, secret, secret_len) == 1);
> +
> +    ASSERT(EVP_PKEY_CTX_add1_tls1_prf_seed(pctx, seed, seed_len) == 1);
> +
> +    size_t out_len = output_len;
> +    ASSERT (EVP_PKEY_derive(pctx, output, &out_len) == 1);
> +    ASSERT (out_len == output_len);
> +}
> +#else
> +/*
> + * Generate the hash required by for the \c tls1_PRF function.
> + *
> + * We cannot use our normal hmac_* function as they do not work
> + * in a FIPS environment (no MD5 allowed, which we need). Instead
> + * we need to directly use the EVP_MD_* API with the special
> + * EVP_MD_CTX_FLAG_NON_FIPS_ALLOW flag.
> + *
> + *
> + * The function below is adapted from OpenSSL 1.0.2t
> + *
> + * @param md_kt         Message digest to use
> + * @param sec           Secret to base the hash on
> + * @param sec_len       Length of the secret
> + * @param seed          Seed to hash
> + * @param seed_len      Length of the seed
> + * @param out           Output buffer
> + * @param olen          Length of the output buffer
> + */
> +static
> +int tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
> +                int sec_len,
> +                const void *seed, int seed_len,
> +                unsigned char *out, int olen)

This should be reindented

> +{
> +    int chunk;
> +    size_t j;
> +    EVP_MD_CTX ctx, ctx_tmp, ctx_init;
> +    EVP_PKEY *mac_key;
> +    unsigned char A1[EVP_MAX_MD_SIZE];
> +    size_t A1_len;
> +    int ret = 0;
> +
> +    chunk = EVP_MD_size(md);
> +    OPENSSL_assert(chunk >= 0);
> +
> +    EVP_MD_CTX_init(&ctx);
> +    EVP_MD_CTX_init(&ctx_tmp);
> +    EVP_MD_CTX_init(&ctx_init);
> +    EVP_MD_CTX_set_flags(&ctx_init, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);
> +    mac_key = EVP_PKEY_new_mac_key(EVP_PKEY_HMAC, NULL, sec, sec_len);
> +    if (!mac_key)
> +        goto err;
> +    if (!EVP_DigestSignInit(&ctx_init, NULL, md, NULL, mac_key))
> +        goto err;
> +    if (!EVP_MD_CTX_copy_ex(&ctx, &ctx_init))
> +        goto err;
> +    if (!EVP_DigestSignUpdate(&ctx, seed, seed_len))
> +        goto err;
> +    if (!EVP_DigestSignFinal(&ctx, A1, &A1_len))
> +        goto err;
> +
> +    for (;;) {
> +        /* Reinit mac contexts */
> +        if (!EVP_MD_CTX_copy_ex(&ctx, &ctx_init))
> +            goto err;
> +        if (!EVP_DigestSignUpdate(&ctx, A1, A1_len))
> +            goto err;
> +        if (olen > chunk && !EVP_MD_CTX_copy_ex(&ctx_tmp, &ctx))
> +            goto err;
> +        if (!EVP_DigestSignUpdate(&ctx, seed, seed_len))
> +            goto err;
> +
> +        if (olen > chunk)
> +        {
> +            if (!EVP_DigestSignFinal(&ctx, out, &j))
> +                goto err;
> +            out += j;
> +            olen -= j;
> +            /* calc the next A1 value */
> +            if (!EVP_DigestSignFinal(&ctx_tmp, A1, &A1_len))
> +                goto err;
> +        }
> +        else
> +        {
> +            /* last one */
> +
> +            if (!EVP_DigestSignFinal(&ctx, A1, &A1_len))
> +                goto err;
> +            memcpy(out, A1, olen);
> +            break;
> +        }
> +    }
> +    ret = 1;
> +err:
> +    EVP_PKEY_free(mac_key);
> +    EVP_MD_CTX_cleanup(&ctx);
> +    EVP_MD_CTX_cleanup(&ctx_tmp);
> +    EVP_MD_CTX_cleanup(&ctx_init);
> +    OPENSSL_cleanse(A1, sizeof(A1));
> +    return ret;
> +}
> +
> +
> +/*
> + * Use the TLS PRF function for generating data channel keys.
> + * This code is based on the OpenSSL library.
> + *
> + * TLS generates keys as such:
> + *
> + * master_secret[48] = PRF(pre_master_secret[48], "master secret",
> + *                         ClientHello.random[32] + ServerHello.random[32])
> + *
> + * key_block[] = PRF(SecurityParameters.master_secret[48],
> + *                 "key expansion",
> + *                 SecurityParameters.server_random[32] +
> + *                 SecurityParameters.client_random[32]);
> + *
> + * Notes:
> + *
> + * (1) key_block contains a full set of 4 keys.
> + * (2) The pre-master secret is generated by the client.
> + */
> +void ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec,
> +                  int slen, uint8_t *out1, int olen)
> +{
> +    struct gc_arena gc = gc_new();
> +    /* For some reason our md_kt_get("MD5") fails otherwise in the unit test */
> +    const md_kt_t *md5 = EVP_md5();
> +    const md_kt_t *sha1 = EVP_sha1();
> +
> +    uint8_t *out2 = (uint8_t *) gc_malloc(olen, false, &gc);
> +
> +    int len = slen/2;
> +    const uint8_t *S1 = sec;
> +    const uint8_t *S2 = &(sec[len]);
> +    len += (slen&1); /* add for odd, make longer */
> +
> +    if(!tls1_P_hash(md5,S1,len,label,label_len,out1,olen))
> +
> +    ASSERT(tls1_P_hash(sha1,S2,len,label,label_len,out2,olen));
> +
> +    for (int i = 0; i<olen; i++)
> +    {
> +        out1[i] ^= out2[i];
> +    }
> +
> +    secure_memzero(out2, olen);
> +
> +    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%d]: %s", olen, format_hex(out1, olen, 0, &gc));
> +
> +    gc_free(&gc);
> +}
> +#endif
>  #endif /* ENABLE_CRYPTO_OPENSSL */
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index efbf688f..c0de76b5 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1580,134 +1580,6 @@ key_source2_print(const struct key_source2 *k)
>      key_source_print(&k->server, "Server");
>  }
>  
> -/*
> - * Generate the hash required by for the \c tls1_PRF function.
> - *
> - * @param md_kt         Message digest to use
> - * @param sec           Secret to base the hash on
> - * @param sec_len       Length of the secret
> - * @param seed          Seed to hash
> - * @param seed_len      Length of the seed
> - * @param out           Output buffer
> - * @param olen          Length of the output buffer
> - */
> -static void
> -tls1_P_hash(const md_kt_t *md_kt,
> -            const uint8_t *sec,
> -            int sec_len,
> -            const uint8_t *seed,
> -            int seed_len,
> -            uint8_t *out,
> -            int olen)
> -{
> -    struct gc_arena gc = gc_new();
> -    uint8_t A1[MAX_HMAC_KEY_LENGTH];
> -
> -#ifdef ENABLE_DEBUG
> -    const int olen_orig = olen;
> -    const uint8_t *out_orig = out;
> -#endif
> -
> -    hmac_ctx_t *ctx = hmac_ctx_new();
> -    hmac_ctx_t *ctx_tmp = hmac_ctx_new();
> -
> -    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len, 0, &gc));
> -    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_len, 0, &gc));
> -
> -    int chunk = md_kt_size(md_kt);
> -    unsigned int A1_len = md_kt_size(md_kt);
> -
> -    hmac_ctx_init(ctx, sec, sec_len, md_kt);
> -    hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt);
> -
> -    hmac_ctx_update(ctx,seed,seed_len);
> -    hmac_ctx_final(ctx, A1);
> -
> -    for (;; )
> -    {
> -        hmac_ctx_reset(ctx);
> -        hmac_ctx_reset(ctx_tmp);
> -        hmac_ctx_update(ctx,A1,A1_len);
> -        hmac_ctx_update(ctx_tmp,A1,A1_len);
> -        hmac_ctx_update(ctx,seed,seed_len);
> -
> -        if (olen > chunk)
> -        {
> -            hmac_ctx_final(ctx, out);
> -            out += chunk;
> -            olen -= chunk;
> -            hmac_ctx_final(ctx_tmp, A1); /* calc the next A1 value */
> -        }
> -        else    /* last one */
> -        {
> -            hmac_ctx_final(ctx, A1);
> -            memcpy(out,A1,olen);
> -            break;
> -        }
> -    }
> -    hmac_ctx_cleanup(ctx);
> -    hmac_ctx_free(ctx);
> -    hmac_ctx_cleanup(ctx_tmp);
> -    hmac_ctx_free(ctx_tmp);
> -    secure_memzero(A1, sizeof(A1));
> -
> -    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash out: %s", format_hex(out_orig, olen_orig, 0, &gc));
> -    gc_free(&gc);
> -}
> -
> -/*
> - * Use the TLS PRF function for generating data channel keys.
> - * This code is based on the OpenSSL library.
> - *
> - * TLS generates keys as such:
> - *
> - * master_secret[48] = PRF(pre_master_secret[48], "master secret",
> - *                         ClientHello.random[32] + ServerHello.random[32])
> - *
> - * key_block[] = PRF(SecurityParameters.master_secret[48],
> - *                 "key expansion",
> - *                 SecurityParameters.server_random[32] +
> - *                 SecurityParameters.client_random[32]);
> - *
> - * Notes:
> - *
> - * (1) key_block contains a full set of 4 keys.
> - * (2) The pre-master secret is generated by the client.
> - */
> -static void
> -tls1_PRF(const uint8_t *label,
> -         int label_len,
> -         const uint8_t *sec,
> -         int slen,
> -         uint8_t *out1,
> -         int olen)
> -{
> -    struct gc_arena gc = gc_new();
> -    const md_kt_t *md5 = md_kt_get("MD5");
> -    const md_kt_t *sha1 = md_kt_get("SHA1");
> -
> -    uint8_t *out2 = (uint8_t *) gc_malloc(olen, false, &gc);
> -
> -    int len = slen/2;
> -    const uint8_t *S1 = sec;
> -    const uint8_t *S2 = &(sec[len]);
> -    len += (slen&1); /* add for odd, make longer */
> -
> -    tls1_P_hash(md5,S1,len,label,label_len,out1,olen);
> -    tls1_P_hash(sha1,S2,len,label,label_len,out2,olen);
> -
> -    for (int i = 0; i<olen; i++)
> -    {
> -        out1[i] ^= out2[i];
> -    }
> -
> -    secure_memzero(out2, olen);
> -
> -    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%d]: %s", olen, format_hex(out1, olen, 0, &gc));
> -
> -    gc_free(&gc);
> -}
> -
>  static void
>  openvpn_PRF(const uint8_t *secret,
>              int secret_len,
> @@ -1742,7 +1614,7 @@ openvpn_PRF(const uint8_t *secret,
>      }
>  
>      /* compute PRF */
> -    tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len, output, output_len);
> +    ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len, output, output_len);
>  
>      buf_clear(&seed);
>      free_buf(&seed);
> diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
> index ea9b99b2..6c68099e 100644
> --- a/tests/unit_tests/openvpn/test_crypto.c
> +++ b/tests/unit_tests/openvpn/test_crypto.c
> @@ -38,6 +38,7 @@
>  #include <cmocka.h>
>  
>  #include "crypto.h"
> +#include "ssl_backend.h"
>  
>  #include "mock_msg.h"
>  
> @@ -136,12 +137,43 @@ crypto_translate_cipher_names(void **state)
>      test_cipher_names("id-aes256-GCM", "AES-256-GCM");
>  }
>  
> +
> +static uint8_t good_prf[32] = {0xd9, 0x8c, 0x85, 0x18, 0xc8, 0x5e, 0x94, 0x69,
> +                               0x27, 0x91, 0x6a, 0xcf, 0xc2, 0xd5, 0x92, 0xfb,
> +                               0xb1, 0x56, 0x7e, 0x4b, 0x4b, 0x14, 0x59, 0xe6,
> +                               0xa9, 0x04, 0xac, 0x2d, 0xda, 0xb7, 0x2d, 0x67};
> +static void
> +crypto_test_tls_prf(void **state)
> +{
> +    const char *seedstr = "Quis aute iure reprehenderit in voluptate "
> +                          "velit esse cillum dolore";
> +    const unsigned char *seed = (const unsigned char *) seedstr;

no space after cast

> +    const size_t seed_len = strlen(seedstr);
> +
> +
> +
> +
> +    const char* ipsumlorem = "Lorem ipsum dolor sit amet, consectetur "
> +                             "adipisici elit, sed eiusmod tempor incidunt ut "
> +                             "labore et dolore magna aliqua.";
> +
> +    const unsigned char *secret = (const unsigned char *) ipsumlorem;
> +    size_t secret_len = strlen((const char *)secret);
> +
> +
> +    uint8_t out[32];
> +    ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, sizeof(out));
> +
> +    assert_memory_equal(good_prf, out, sizeof(out));
> +}
> +
>  int
>  main(void)
>  {
>      const struct CMUnitTest tests[] = {
>          cmocka_unit_test(crypto_pem_encode_decode_loopback),
>          cmocka_unit_test(crypto_translate_cipher_names),
> +        cmocka_unit_test(crypto_test_tls_prf)
>      };
>  
>  #if defined(ENABLE_CRYPTO_OPENSSL)
> 


Cheers,

-- 
Antonio Quartulli

