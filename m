References: <20200416113930.15192-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9d361508-20d3-26ff-fbc2-2393f447d8db@...2181...>
Date: Thu, 16 Apr 2020 16:10:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200416113930.15192-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Use crypto library functions for
 const time memcmp when possible
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

On 16/04/2020 13:39, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/crypto.h         | 16 +---------------
>  src/openvpn/crypto_mbedtls.c | 19 +++++++++++++++++++
>  src/openvpn/crypto_openssl.c |  5 +++++
>  3 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index 18a86ceb..dadf0a90 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -528,21 +528,7 @@ void crypto_read_openvpn_key(const struct key_type *key_type,
>   * As memcmp(), but constant-time.
>   * Returns 0 when data is equal, non-zero otherwise.
>   */
> -static inline int
> -memcmp_constant_time(const void *a, const void *b, size_t size)
> -{
> -    const uint8_t *a1 = a;
> -    const uint8_t *b1 = b;
> -    int ret = 0;
> -    size_t i;
> -
> -    for (i = 0; i < size; i++)
> -    {
> -        ret |= *a1++ ^ *b1++;
> -    }
> -
> -    return ret;
> -}
> +int memcmp_constant_time(const void *a, const void *b, size_t size);
>  
>  static inline bool
>  key_ctx_bi_defined(const struct key_ctx_bi *key)
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index 3e77fa9e..35072b73 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -972,4 +972,23 @@ hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
>      ASSERT(0 == mbedtls_md_hmac_finish(ctx, dst));
>  }
>  
> +int
> +memcmp_constant_time(const void *a, const void *b, size_t size)
> +{
> +    /* mbed TLS has a no const time memcmp function that it exposes
> +     * via its APIs like OpenSSL does with CRYPTO_memcmp

'.' missing at the end of the sentence.
Actually, I'd just chop the last part and stop after 'memcmp'.

> +     * Adapt the function that mbedtls itself uses in
> +     * mbedtls_safer_memcmp as it considers that to be safe */
> +    volatile const unsigned char *A = (volatile const unsigned char *) a;

                                                    no space after cast

> +    volatile const unsigned char *B = (volatile const unsigned char *) b;

                                                    same

> +    volatile unsigned char diff = 0;
> +
> +    for (size_t i = 0; i < size; i++)
> +    {
> +        unsigned char x = A[i], y = B[i];
> +        diff |= x ^ y;

After a discussion on IRC, it was noted that this conversion from
volatile to non-volatile was introduced by mbedTLS devs to avoid
warnings with the IAR compiler.

Since we don't want to change the function but use it as it is, we
should still add a comment to avoid somebody in the future from
"cleaning this up".

maybe something like:

/* this conversion was introduced by mbedTLS to suppress a IAR
 * compiler  warning. keep it as it is.
 */

> +    }
> +
> +    return diff;
> +}
>  #endif /* ENABLE_CRYPTO_MBEDTLS */
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index a81dcfd8..9e7ea0ff 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -1066,4 +1066,9 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)
>      HMAC_Final(ctx, dst, &in_hmac_len);
>  }
>  
> +int
> +memcmp_constant_time(const void *a, const void *b, size_t size)
> +{
> +    return CRYPTO_memcmp(a, b, size);
> +}
>  #endif /* ENABLE_CRYPTO_OPENSSL */
> 


Cheers,

-- 
Antonio Quartulli

