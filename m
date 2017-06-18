References: <CAA1AbxLbVut1Z8pWF78kD=vy3rx5mxDf8MyDSR4BpxfbXoQZiQ@...278...>
	<20170612134330.20971-1-logout@...260...>
	<20170612134330.20971-5-logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2e046f91-9254-fc43-2e40-f8fbbbd7cc2f@...1856...>
Date: Sun, 18 Jun 2017 10:40:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170612134330.20971-5-logout@...260...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 4/8] OpenSSL: don't use direct access to
 the internal of DSA
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


On 12-06-17 15:43, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
> 
> OpenSSL 1.1 does not allow us to directly access the internal of
> any data type, including DSA. We have to use the defined
> functions to do so.
> 
> Compatibility with OpenSSL 1.0 is kept by defining the corresponding
> functions when they are not found in the library.
> 
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  configure.ac                 |  2 ++
>  src/openvpn/openssl_compat.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  src/openvpn/ssl_openssl.c    |  6 +++---
>  3 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 4c5f28ed..6eded4e6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -933,6 +933,8 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
>  			RSA_bits \
>  			RSA_get0_key \
>  			RSA_set0_key \
> +			DSA_get0_pqg \
> +			DSA_bits \
>  			RSA_meth_new \
>  			RSA_meth_free \
>  			RSA_meth_set_pub_enc \
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 44e3e167..24efa0fd 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -276,6 +276,50 @@ RSA_bits(const RSA *rsa)
>  }
>  #endif
>  
> +#if !defined(HAVE_DSA_GET0_PQG)
> +/**
> + * Get the DSA parameters
> + *
> + * @param dsa                 The DSA object
> + * @param p                   The @c p parameter
> + * @param q                   The @c q parameter
> + * @param g                   The @c g parameter
> + */
> +static inline void
> +DSA_get0_pqg(const DSA *dsa, const BIGNUM **p,
> +             const BIGNUM **q, const BIGNUM **g)
> +{
> +    if (p != NULL)
> +    {
> +        *p = dsa ? dsa->p : NULL;
> +    }
> +    if (q != NULL)
> +    {
> +        *q = dsa ? dsa->q : NULL;
> +    }
> +    if (g != NULL)
> +    {
> +        *g = dsa ? dsa->g : NULL;
> +    }
> +}
> +#endif
> +
> +#if !defined(HAVE_DSA_BITS)
> +/**
> + * Number of significant DSA bits
> + *
> + * @param rsa                The DSA object ; shall not be NULL
> + * @return                   The number of DSA bits or 0 on error
> + */
> +static inline int
> +DSA_bits(const DSA *dsa)
> +{
> +    const BIGNUM *p = NULL;
> +    DSA_get0_pqg(dsa, &p, NULL, NULL);
> +    return p ? BN_num_bits(p) : 0;
> +}
> +#endif
> +
>  #if !defined(HAVE_RSA_METH_NEW)
>  /**
>   * Allocate a new RSA method object
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 2a42d3c6..5faeafcc 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1689,11 +1689,11 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
>                  openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
>                                   RSA_bits(rsa));
>              }
> -            else if (EVP_PKEY_id(pkey) == EVP_PKEY_DSA && EVP_PKEY_get0_DSA(pkey) != NULL
> -                     && pkey->pkey.dsa->p != NULL)
> +            else if (EVP_PKEY_id(pkey) == EVP_PKEY_DSA && EVP_PKEY_get0_DSA(pkey) != NULL)
>              {
> +                DSA *dsa = EVP_PKEY_get0_DSA(pkey);
>                  openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
> -                                 BN_num_bits(pkey->pkey.dsa->p));
> +                                 DSA_bits(dsa));
>              }
>              EVP_PKEY_free(pkey);
>          }
> 

Looks good too now, ACK.

-Steffan

