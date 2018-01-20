References: <CAKuzo_gPWm6rdBYt+tcaxz+zSQ4M-A4UDu8ZEgWjtvrLZ54ipw@...278...>
 <20180119212721.25177-1-steffan@...1856...>
 <CAKuzo_h0NVc8K_G-8CYd0iSc35nFEPjGpLSXQg3Lmk+fthMJLw@...278...>
From: fragmentux <fragmentux@...277...>
Message-ID: <c29a8342-abb5-688e-e2e1-3a3aedb4a855@...277...>
Date: Sat, 20 Jan 2018 02:22:37 +0000
MIME-Version: 1.0
In-Reply-To: <CAKuzo_h0NVc8K_G-8CYd0iSc35nFEPjGpLSXQg3Lmk+fthMJLw@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/3 v4] Fix --tls-version-min and
 --tls-version-max for OpenSSL 1.1+
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

hello

On 19/01/18 21:58, Selva Nair wrote:
> Hi,
> 
> Thanks for last and final v4 :)
> 
> On Fri, Jan 19, 2018 at 4:27 PM, Steffan Karger <steffan@...1856...> wrote:
> 
>> As described in <80e6b449-c536-dc87-7215-3693872bce5a@...376...> on
>> the openvpn-devel mailing list, --tls-version-min no longer works with
>> OpenSSL 1.1.  Kurt Roeckx posted in a debian bug report:
>>
>> "This is marked as important because if you switch to openssl 1.1.0
>> the defaults minimum version in Debian is currently TLS 1.2 and
>> you can't override it with the options that you're currently using
>> (and are deprecated)."
>>
>> This patch is loosely based on the original patch by Kurt, but solves the
>> issue by adding functions to openssl-compat.h, like we also did for all
>> other openssl 1.1. breakage.  This results in not having to add more ifdefs
>> in ssl_openssl.c and thus cleaner code.
>>
>> Signed-off-by: Steffan Karger <steffan@...1856...>
>> ---
>> v2: fix define name, obey system lib default minimum version
>> v3: add error handling, fix bug in setting default minimum
>> v4: also update compat layer for v3 changes
>>
>>   src/openvpn/openssl_compat.h |  67 +++++++++++++++++++++++++++++
>>   src/openvpn/ssl.c            |   5 ++-
>>   src/openvpn/ssl_backend.h    |   4 +-
>>   src/openvpn/ssl_mbedtls.c    |   3 +-
>>   src/openvpn/ssl_openssl.c    | 100 +++++++++++++++++++++++++++---
>> -------------
>>   5 files changed, 140 insertions(+), 39 deletions(-)
>>
>> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
>> index 05ec4e95..9f1e92a1 100644
>> --- a/src/openvpn/openssl_compat.h
>> +++ b/src/openvpn/openssl_compat.h
>> @@ -661,4 +661,71 @@ EC_GROUP_order_bits(const EC_GROUP *group)
>>   #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT
>>   RSA_F_RSA_EAY_PRIVATE_ENCRYPT
>>   #endif
>>
>> +#ifndef SSL_CTX_get_min_proto_version
>> +/** Dummy SSL_CTX_get_min_proto_version for OpenSSL < 1.1 (not really
>> needed) */
>> +static inline int
>> +SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
>> +{
>> +    return 0;
>> +}
>> +#endif /* SSL_CTX_get_min_proto_version */
>> +
>> +#ifndef SSL_CTX_set_min_proto_version
>> +/** Mimics SSL_CTX_set_min_proto_version for OpenSSL < 1.1 */
>> +static inline int
>> +SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
>> +{
>> +    long sslopt = SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3; /* Never do < TLS
>> 1.0 */
>> +
>> +    if (tls_ver_min > TLS1_VERSION)
>> +    {
>> +        sslopt |= SSL_OP_NO_TLSv1;
>> +    }
>> +#ifdef SSL_OP_NO_TLSv1_1
>> +    if (tls_ver_min > TLS1_1_VERSION)
>> +    {
>> +        sslopt |= SSL_OP_NO_TLSv1_1;
>> +    }
>> +#endif
>> +#ifdef SSL_OP_NO_TLSv1_2
>> +    if (tls_ver_min > TLS1_2_VERSION)
>> +    {
>> +        sslopt |= SSL_OP_NO_TLSv1_2;
>> +    }
>> +#endif
>> +    SSL_CTX_set_options(ctx, sslopt);
>> +
>> +    return 1;
>> +}
>> +#endif /* SSL_CTX_set_min_proto_version */
>> +
>> +#ifndef SSL_CTX_set_max_proto_version
>> +/** Mimics SSL_CTX_set_max_proto_version for OpenSSL < 1.1 */
>> +static inline int
>> +SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
>> +{
>> +    long sslopt = 0;
>> +
>> +    if (tls_ver_max < TLS1_VERSION)
>> +    {
>> +        sslopt |= SSL_OP_NO_TLSv1;
>> +    }
>> +#ifdef SSL_OP_NO_TLSv1_1
>> +    if (tls_ver_max < TLS1_1_VERSION)
>> +    {
>> +        sslopt |= SSL_OP_NO_TLSv1_1;
>> +    }
>> +#endif
>> +#ifdef SSL_OP_NO_TLSv1_2
>> +    if (tls_ver_max < TLS1_2_VERSION)
>> +    {
>> +        sslopt |= SSL_OP_NO_TLSv1_2;
>> +    }
>> +#endif
>> +    SSL_CTX_set_options(ctx, sslopt);
>> +
>> +    return 1;
>> +}
>> +#endif /* SSL_CTX_set_max_proto_version */
>> +
>>   #endif /* OPENSSL_COMPAT_H_ */
>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>> index 7b428455..6c27050f 100644
>> --- a/src/openvpn/ssl.c
>> +++ b/src/openvpn/ssl.c
>> @@ -622,7 +622,10 @@ init_ssl(const struct options *options, struct
>> tls_root_ctx *new_ctx)
>>        * cipher restrictions before loading certificates */
>>       tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
>>
>> -    tls_ctx_set_options(new_ctx, options->ssl_flags);
>> +    if (!tls_ctx_set_options(new_ctx, options->ssl_flags))
>> +    {
>> +        goto err;
>> +    }
>>
>>       if (options->pkcs12_file)
>>       {
>> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
>> index 7cf5d830..444fb2f9 100644
>> --- a/src/openvpn/ssl_backend.h
>> +++ b/src/openvpn/ssl_backend.h
>> @@ -162,8 +162,10 @@ bool tls_ctx_initialised(struct tls_root_ctx *ctx);
>>    *
>>    * @param ctx           TLS context to set options on
>>    * @param ssl_flags     SSL flags to set
>> + *
>> + * @return true on success, false otherwise.
>>    */
>> -void tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int
>> ssl_flags);
>> +bool tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int
>> ssl_flags);
>>
>>   /**
>>    * Restrict the list of ciphers that can be used within the TLS context.
>> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
>> index 8ac52d55..d503162a 100644
>> --- a/src/openvpn/ssl_mbedtls.c
>> +++ b/src/openvpn/ssl_mbedtls.c
>> @@ -206,9 +206,10 @@ key_state_export_keying_material(struct
>> key_state_ssl *ssl,
>>   {
>>   }
>>
>> -void
>> +bool
>>   tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
>>   {
>> +    return true;
>>   }
>>
>>   static const char *
>> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
>> index 86318d4c..50d68280 100644
>> --- a/src/openvpn/ssl_openssl.c
>> +++ b/src/openvpn/ssl_openssl.c
>> @@ -206,16 +206,65 @@ info_callback(INFO_CALLBACK_SSL_CONST SSL *s, int
>> where, int ret)
>>   int
>>   tls_version_max(void)
>>   {
>> -#if defined(SSL_OP_NO_TLSv1_2)
>> +#if defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
>>       return TLS_VER_1_2;
>> -#elif defined(SSL_OP_NO_TLSv1_1)
>> +#elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
>>       return TLS_VER_1_1;
>>   #else
>>       return TLS_VER_1_0;
>>   #endif
>>   }
>>
>> -void
>> +/** Convert internal version number to openssl version number */
>> +static int
>> +openssl_tls_version(int ver)
>> +{
>> +    if (ver == TLS_VER_1_0)
>> +    {
>> +        return TLS1_VERSION;
>> +    }
>> +    else if (ver == TLS_VER_1_1)
>> +    {
>> +        return TLS1_1_VERSION;
>> +    }
>> +    else if (ver == TLS_VER_1_2)
>> +    {
>> +        return TLS1_2_VERSION;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static bool
>> +tls_ctx_set_tls_versions(struct tls_root_ctx *ctx, unsigned int
>> ssl_flags)
>> +{
>> +    int tls_ver_min = openssl_tls_version(
>> +        (ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) &
>> SSLF_TLS_VERSION_MIN_MASK);
>> +    int tls_ver_max = openssl_tls_version(
>> +        (ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
>> SSLF_TLS_VERSION_MAX_MASK);
>> +
>> +    if (!tls_ver_min)
>> +    {
>> +        /* Enforce at least TLS 1.0 */
>> +        int cur_min = SSL_CTX_get_min_proto_version(ctx->ctx);
>> +        tls_ver_min = cur_min < TLS1_VERSION ? TLS1_VERSION : cur_min;
>> +    }
>> +
>> +    if (!SSL_CTX_set_min_proto_version(ctx->ctx, tls_ver_min))
>> +    {
>> +        msg(D_TLS_ERRORS, "%s: failed to set minimum TLS version",
>> __func__);
>> +        return false;
>> +    }
>> +
>> +    if (tls_ver_max && !SSL_CTX_set_max_proto_version(ctx->ctx,
>> tls_ver_max))
>> +    {
>> +        msg(D_TLS_ERRORS, "%s: failed to set maximum TLS version",
>> __func__);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +bool
>>   tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
>>   {
>>       ASSERT(NULL != ctx);
>> @@ -223,41 +272,18 @@ tls_ctx_set_options(struct tls_root_ctx *ctx,
>> unsigned int ssl_flags)
>>       /* default certificate verification flags */
>>       int flags = SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT;
>>
>> -    /* process SSL options including minimum TLS version we will accept
>> from peer */
>> -    {
>> -        long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET |
>> SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3;
>> -        int tls_ver_max = TLS_VER_UNSPEC;
>> -        const int tls_ver_min =
>> -            (ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) &
>> SSLF_TLS_VERSION_MIN_MASK;
>> -
>> -        tls_ver_max =
>> -            (ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
>> SSLF_TLS_VERSION_MAX_MASK;
>> -        if (tls_ver_max <= TLS_VER_UNSPEC)
>> -        {
>> -            tls_ver_max = tls_version_max();
>> -        }
>> -
>> -        if (tls_ver_min > TLS_VER_1_0 || tls_ver_max < TLS_VER_1_0)
>> -        {
>> -            sslopt |= SSL_OP_NO_TLSv1;
>> -        }
>> -#ifdef SSL_OP_NO_TLSv1_1
>> -        if (tls_ver_min > TLS_VER_1_1 || tls_ver_max < TLS_VER_1_1)
>> -        {
>> -            sslopt |= SSL_OP_NO_TLSv1_1;
>> -        }
>> -#endif
>> -#ifdef SSL_OP_NO_TLSv1_2
>> -        if (tls_ver_min > TLS_VER_1_2 || tls_ver_max < TLS_VER_1_2)
>> -        {
>> -            sslopt |= SSL_OP_NO_TLSv1_2;
>> -        }
>> -#endif
>> +    /* process SSL options */
>> +    long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
>>   #ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
>> -        sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
>> +    sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
>>   #endif
>> -        sslopt |= SSL_OP_NO_COMPRESSION;
>> -        SSL_CTX_set_options(ctx->ctx, sslopt);
>> +    sslopt |= SSL_OP_NO_COMPRESSION;
>> +
>> +    SSL_CTX_set_options(ctx->ctx, sslopt);
>> +
>> +    if (!tls_ctx_set_tls_versions(ctx, ssl_flags))
>> +    {
>> +        return false;
>>       }
>>
>>   #ifdef SSL_MODE_RELEASE_BUFFERS
>> @@ -280,6 +306,8 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned
>> int ssl_flags)
>>       SSL_CTX_set_verify(ctx->ctx, flags, verify_callback);
>>
>>       SSL_CTX_set_info_callback(ctx->ctx, info_callback);
>> +
>> +    return true;
>>   }
>>
> 
> Now I can tease patchwork by
> 
> Acked-by: Selva Nair <selva.nair@...277...>
> Reviewed-by: Selva Nair <selva.nair@...277...>
> Tested-by: Selva Nair <selva.nair@...277...>
> 

Purely to see what patchworks makes of this (i did what i could)

Also

Tested-by: Richard Bonhomme <fragmentux@...2200...,mail.com>


