References: <CAA1AbxLbVut1Z8pWF78kD=vy3rx5mxDf8MyDSR4BpxfbXoQZiQ@...278...>
	<20170612134330.20971-1-logout@...260...>
	<20170612134330.20971-4-logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <36e43c28-3b6c-309b-083a-6bcfc2d6e72b@...1856...>
Date: Sun, 18 Jun 2017 10:38:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170612134330.20971-4-logout@...260...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/8] OpenSSL: don't use direct access to
 the internal of RSA
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

On 12-06-17 15:43, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
> 
> OpenSSL 1.1 does not allow us to directly access the internal of
> any data type, including RSA. We have to use the defined
> functions to do so.
> 
> Compatibility with OpenSSL 1.0 is kept by defining the corresponding
> functions when they are not found in the library.
> 
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  configure.ac                 |   4 ++
>  src/openvpn/openssl_compat.h | 100 +++++++++++++++++++++++++++++++++++++++++++
>  src/openvpn/ssl_openssl.c    |  24 +++++++----
>  3 files changed, 119 insertions(+), 9 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index a92e8142..4c5f28ed 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -929,6 +929,10 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
>  			EVP_PKEY_id \
>  			EVP_PKEY_get0_RSA \
>  			EVP_PKEY_get0_DSA \
> +			RSA_set_flags \
> +			RSA_bits \
> +			RSA_get0_key \
> +			RSA_set0_key \
>  			RSA_meth_new \
>  			RSA_meth_free \
>  			RSA_meth_set_pub_enc \
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 0d82cf25..44e3e167 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -176,6 +176,106 @@ EVP_PKEY_get0_DSA(EVP_PKEY *pkey)
>  }
>  #endif
>  
> +#if !defined(HAVE_RSA_SET_FLAGS)
> +/**
> + * Set the RSA flags
> + *
> + * @param rsa                 The RSA object
> + * @param flags               New flags value
> + */
> +static inline void
> +RSA_set_flags(RSA *rsa, int flags)
> +{
> +    if (rsa)
> +    {
> +        rsa->flags = flags;
> +    }
> +}
> +#endif
> +
> +#if !defined(HAVE_RSA_GET0_KEY)
> +/**
> + * Get the RSA parameters
> + *
> + * @param rsa                 The RSA object
> + * @param n                   The @c n parameter
> + * @param e                   The @c e parameter
> + * @param d                   The @c d parameter
> + */
> +static inline void
> +RSA_get0_key(const RSA *rsa, const BIGNUM **n,
> +             const BIGNUM **e, const BIGNUM **d)
> +{
> +    if (n != NULL)
> +    {
> +        *n = rsa ? rsa->n : NULL;
> +    }
> +    if (e != NULL)
> +    {
> +        *e = rsa ? rsa->e : NULL;
> +    }
> +    if (d != NULL)
> +    {
> +        *d = rsa ? rsa->d : NULL;
> +    }
> +}
> +#endif
> +
> +#if !defined(HAVE_RSA_SET0_KEY)
> +/**
> + * Set the RSA parameters
> + *
> + * @param rsa                 The RSA object
> + * @param n                   The @c n parameter
> + * @param e                   The @c e parameter
> + * @param d                   The @c d parameter
> + * @return                    1 on success, 0 on error
> + */
> +static inline int
> +RSA_set0_key(RSA *rsa, BIGNUM *n, BIGNUM *e, BIGNUM *d)
> +{
> +    if ((rsa->n == NULL && n == NULL)
> +        || (rsa->e == NULL && e == NULL))
> +    {
> +        return 0;
> +    }
> +
> +    if (n != NULL)
> +    {
> +        BN_free(rsa->n);
> +        rsa->n = n;
> +    }
> +    if (e != NULL)
> +    {
> +        BN_free(rsa->e);
> +        rsa->e = e;
> +    }
> +    if (d != NULL)
> +    {
> +        BN_free(rsa->d);
> +        rsa->d = d;
> +    }
> +
> +    return 1;
> +}
> +#endif
> +
> +#if !defined(HAVE_RSA_BITS)
> +/**
> + * Number of significant RSA bits
> + *
> + * @param rsa                The RSA object ; shall not be NULL
> + * @return                   The number of RSA bits or 0 on error
> + */
> +static inline int
> +RSA_bits(const RSA *rsa)
> +{
> +    const BIGNUM *n = NULL;
> +    RSA_get0_key(rsa, &n, NULL, NULL);
> +    return n ? BN_num_bits(n) : 0;
> +}
> +#endif
> +
>  #if !defined(HAVE_RSA_METH_NEW)
>  /**
>   * Allocate a new RSA method object
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 1c73641c..2a42d3c6 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -973,10 +973,13 @@ rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
>  
>  /* called at RSA_free */
>  static int
> -rsa_finish(RSA *rsa)
> +openvpn_extkey_rsa_finish(RSA *rsa)
>  {
> -    RSA_meth_free(rsa->meth);
> -    rsa->meth = NULL;
> +    /* meth was allocated in tls_ctx_use_external_private_key() ; since
> +     * this function is called when the parent RSA object is destroyed,
> +     * it is no longer used after this point so kill it. */
> +    const RSA_METHOD *meth = RSA_get_method(rsa);
> +    RSA_meth_free((RSA_METHOD *)meth);
>      return 1;
>  }
>  
> @@ -1058,7 +1061,7 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
>      RSA_meth_set_priv_enc(rsa_meth, rsa_priv_enc);
>      RSA_meth_set_priv_dec(rsa_meth, rsa_priv_dec);
>      RSA_meth_set_init(rsa_meth, NULL);
> -    RSA_meth_set_finish(rsa_meth, rsa_finish);
> +    RSA_meth_set_finish(rsa_meth, openvpn_extkey_rsa_finish);
>      RSA_meth_set0_app_data(rsa_meth, NULL);
>  
>      /* allocate RSA object */
> @@ -1075,8 +1078,11 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
>      pub_rsa = EVP_PKEY_get0_RSA(pkey);
>  
>      /* initialize RSA object */
> -    rsa->n = BN_dup(pub_rsa->n);
> -    rsa->flags |= RSA_FLAG_EXT_PKEY;
> +    const BIGNUM *n = NULL;
> +    const BIGNUM *e = NULL;
> +    RSA_get0_key(pub_rsa, &n, &e, NULL);
> +    RSA_set0_key(rsa, BN_dup(n), BN_dup(e), NULL);
> +    RSA_set_flags(rsa, RSA_flags(rsa) | RSA_FLAG_EXT_PKEY);
>      if (!RSA_set_method(rsa, rsa_meth))
>      {
>          goto err;
> @@ -1677,11 +1683,11 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
>          EVP_PKEY *pkey = X509_get_pubkey(cert);
>          if (pkey != NULL)
>          {
> -            if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA && EVP_PKEY_get0_RSA(pkey) != NULL
> -                && pkey->pkey.rsa->n != NULL)
> +            if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA && EVP_PKEY_get0_RSA(pkey) != NULL)
>              {
> +                RSA *rsa = EVP_PKEY_get0_RSA(pkey);
>                  openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
> -                                 BN_num_bits(pkey->pkey.rsa->n));
> +                                 RSA_bits(rsa));
>              }
>              else if (EVP_PKEY_id(pkey) == EVP_PKEY_DSA && EVP_PKEY_get0_DSA(pkey) != NULL
>                       && pkey->pkey.dsa->p != NULL)
> 

Code looks good, and works as advertised.  ACK.

-Steffan

