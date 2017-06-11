References: <CAKh=nwFot6GZiv1cs2-X8kL0UNS6r8BGsNQ2RtC+0eyiJRMZtA@...278...>
	<20170519103816.19851-1-logout@...260...>
	<20170519103816.19851-4-logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d9976072-480f-5738-7016-51f82e4f8fef@...1856...>
Date: Sun, 11 Jun 2017 22:11:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170519103816.19851-4-logout@...260...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 4/7] OpenSSL: don't use direct access to
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

Hi,

On 19-05-17 12:38, Emmanuel Deloget wrote:
> OpenSSL 1.1 does not allow us to directly access the internal of
> any data type, including DSA. We have to use the defined
> functions to do so.
> 
> Compatibility with OpenSSL 1.0 is kept by defining the corresponding
> functions when they are not found in the library.
> 
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  configure.ac                 |  1 +
>  src/openvpn/openssl_compat.h | 28 ++++++++++++++++++++++++++++
>  src/openvpn/ssl_openssl.c    | 13 +++++++++----
>  3 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index e4c053c8..d2dc1ffd 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -932,6 +932,7 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
>  			RSA_set_flags \
>  			RSA_get0_key \
>  			RSA_set0_key \
> +			DSA_get0_pqg \
>  			RSA_meth_new \
>  			RSA_meth_free \
>  			RSA_meth_set_pub_enc \
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 29cd13a4..fdfc4a27 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -260,6 +260,34 @@ RSA_set0_key(RSA *rsa, BIGNUM *n, BIGNUM *e, BIGNUM *d)
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
>  #if !defined(HAVE_RSA_METH_NEW)
>  /**
>   * Allocate a new RSA method object
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 48479c0d..242ab397 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1691,11 +1691,16 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
>                                       BN_num_bits(n));
>                  }
>              }
> -            else if (EVP_PKEY_id(pkey) == EVP_PKEY_DSA && EVP_PKEY_get0_DSA(pkey) != NULL
> -                     && pkey->pkey.dsa->p != NULL)
> +            else if (EVP_PKEY_id(pkey) == EVP_PKEY_DSA && EVP_PKEY_get0_DSA(pkey) != NULL)
>              {
> -                openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
> -                                 BN_num_bits(pkey->pkey.dsa->p));
> +                DSA *dsa = EVP_PKEY_get0_DSA(pkey);
> +                const BIGNUM *p = NULL;
> +                DSA_get0_pqg(dsa, &p, NULL, NULL);
> +                if (p != NULL)
> +                {
> +                    openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
> +                                     BN_num_bits(p));
> +                }

Similar to 3/7: a DSA_bits() in openssl_compat.h is somewhat nicer.

-Steffan

