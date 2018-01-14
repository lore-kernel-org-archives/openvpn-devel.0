References: <bb21c180-2618-6d83-e7e1-dbc8479e8d6e@...1856...>
 <1515956662-30572-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <49ab9ed3-9d99-9b68-a681-b4fb6fb6998d@...1856...>
Date: Sun, 14 Jan 2018 20:28:03 +0100
MIME-Version: 1.0
In-Reply-To: <1515956662-30572-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Bring cryptoapi.c upto speed
 with openssl 1.1
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

On 14-01-18 20:04, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - Replace direct access to internals of openssl structs
>   by corresponding methods.
> 
> v2: Remove the call to EVP_PKEY_id() as its slated for removal
>     from the compat layer (see also review by Stefan)
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> Freeing rsa_method in this code path requires more fixup than
> just use of RSA_meth_free (not freed at in n some errors etc.),
> so will be addressed in a separate patch.
> 
>  configure.ac                 |  1 +
>  src/openvpn/cryptoapi.c      | 68 ++++++++++++++++++++++++++------------------
>  src/openvpn/openssl_compat.h | 14 +++++++++
>  3 files changed, 56 insertions(+), 27 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index b4fd1b3..2c1937e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -944,6 +944,7 @@ if test "${with_crypto_library}" = "openssl"; then
>  			RSA_meth_set_init \
>  			RSA_meth_set_finish \
>  			RSA_meth_set0_app_data \
> +			RSA_meth_get0_app_data \
>  			EC_GROUP_order_bits
>  		]
>  	)
> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index d90cc5d..4f2c636 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -47,6 +47,7 @@
>  #include <assert.h>
>  
>  #include "buffer.h"
> +#include "openssl_compat.h"
>  
>  /* MinGW w32api 3.17 is still incomplete when it comes to CryptoAPI while
>   * MinGW32-w64 defines all macros used. This is a hack around that problem.
> @@ -213,20 +214,20 @@ rsa_pub_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, in
>  static int
>  rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
>  {
> -    CAPI_DATA *cd = (CAPI_DATA *) rsa->meth->app_data;
> +    CAPI_DATA *cd = (CAPI_DATA *) RSA_meth_get0_app_data(RSA_get_method(rsa));
>      HCRYPTHASH hash;
>      DWORD hash_size, len, i;
>      unsigned char *buf;
>  
>      if (cd == NULL)
>      {
> -        RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, ERR_R_PASSED_NULL_PARAMETER);
> +        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, ERR_R_PASSED_NULL_PARAMETER);
>          return 0;
>      }
>      if (padding != RSA_PKCS1_PADDING)
>      {
>          /* AFAICS, CryptSignHash() *always* uses PKCS1 padding. */
> -        RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
> +        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
>          return 0;
>      }
>      /* Unfortunately, there is no "CryptSign()" function in CryptoAPI, that would
> @@ -236,7 +237,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
>      /* For now, we only support NID_md5_sha1 */
>      if (flen != SSL_SIG_LENGTH)
>      {
> -        RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, RSA_R_INVALID_MESSAGE_LENGTH);
> +        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_INVALID_MESSAGE_LENGTH);
>          return 0;
>      }
>      if (!CryptCreateHash(cd->crypt_prov, CALG_SSL3_SHAMD5, 0, 0, &hash))
> @@ -253,7 +254,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
>      }
>      if ((int) hash_size != flen)
>      {
> -        RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, RSA_R_INVALID_MESSAGE_LENGTH);
> +        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_INVALID_MESSAGE_LENGTH);
>          CryptDestroyHash(hash);
>          return 0;
>      }
> @@ -268,7 +269,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
>      buf = malloc(len);
>      if (buf == NULL)
>      {
> -        RSAerr(RSA_F_RSA_EAY_PRIVATE_ENCRYPT, ERR_R_MALLOC_FAILURE);
> +        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, ERR_R_MALLOC_FAILURE);
>          CryptDestroyHash(hash);
>          return 0;
>      }
> @@ -312,7 +313,8 @@ init(RSA *rsa)
>  static int
>  finish(RSA *rsa)
>  {
> -    CAPI_DATA *cd = (CAPI_DATA *) rsa->meth->app_data;
> +    const RSA_METHOD *rsa_meth = RSA_get_method(rsa);
> +    CAPI_DATA *cd = (CAPI_DATA *) RSA_meth_get0_app_data(rsa_meth);
>  
>      if (cd == NULL)
>      {
> @@ -326,9 +328,8 @@ finish(RSA *rsa)
>      {
>          CertFreeCertificateContext(cd->cert_context);
>      }
> -    free(rsa->meth->app_data);
> -    free((char *) rsa->meth);
> -    rsa->meth = NULL;
> +    free(cd);
> +    RSA_meth_free((RSA_METHOD*) rsa_meth);
>      return 1;
>  }
>  
> @@ -412,9 +413,9 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
>      X509 *cert = NULL;
>      RSA *rsa = NULL, *pub_rsa;
>      CAPI_DATA *cd = calloc(1, sizeof(*cd));
> -    RSA_METHOD *my_rsa_method = calloc(1, sizeof(*my_rsa_method));
> +    RSA_METHOD *my_rsa_method = NULL;
>  
> -    if (cd == NULL || my_rsa_method == NULL)
> +    if (cd == NULL)
>      {
>          SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
>          goto err;
> @@ -469,15 +470,16 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
>      /* here we don't need to do CryptGetUserKey() or anything; all necessary key
>       * info is in cd->cert_context, and then, in cd->crypt_prov.  */
>  
> -    my_rsa_method->name = "Microsoft CryptoAPI RSA Method";
> -    my_rsa_method->rsa_pub_enc = rsa_pub_enc;
> -    my_rsa_method->rsa_pub_dec = rsa_pub_dec;
> -    my_rsa_method->rsa_priv_enc = rsa_priv_enc;
> -    my_rsa_method->rsa_priv_dec = rsa_priv_dec;
> -    /* my_rsa_method->init = init; */
> -    my_rsa_method->finish = finish;
> -    my_rsa_method->flags = RSA_METHOD_FLAG_NO_CHECK;
> -    my_rsa_method->app_data = (char *) cd;
> +    my_rsa_method = RSA_meth_new("Microsoft Cryptography API RSA Method",
> +                                  RSA_METHOD_FLAG_NO_CHECK);
> +    check_malloc_return(my_rsa_method);
> +    RSA_meth_set_pub_enc(my_rsa_method, rsa_pub_enc);
> +    RSA_meth_set_pub_dec(my_rsa_method, rsa_pub_dec);
> +    RSA_meth_set_priv_enc(my_rsa_method, rsa_priv_enc);
> +    RSA_meth_set_priv_dec(my_rsa_method, rsa_priv_dec);
> +    RSA_meth_set_init(my_rsa_method, NULL);
> +    RSA_meth_set_finish(my_rsa_method, finish);
> +    RSA_meth_set0_app_data(my_rsa_method, cd);
>  
>      rsa = RSA_new();
>      if (rsa == NULL)
> @@ -486,23 +488,35 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
>          goto err;
>      }
>  
> -    /* cert->cert_info->key->pkey is NULL until we call SSL_CTX_use_certificate(),
> +    /* Public key in cert is NULL until we call SSL_CTX_use_certificate(),
>       * so we do it here then...  */
>      if (!SSL_CTX_use_certificate(ssl_ctx, cert))
>      {
>          goto err;
>      }
>      /* the public key */
> -    pub_rsa = cert->cert_info->key->pkey->pkey.rsa;
> +    EVP_PKEY *pkey = X509_get0_pubkey(cert);
> +
>      /* SSL_CTX_use_certificate() increased the reference count in 'cert', so
>       * we decrease it here with X509_free(), or it will never be cleaned up. */
>      X509_free(cert);
>      cert = NULL;
>  
> -    /* I'm not sure about what we have to fill in in the RSA, trying out stuff... */
> -    /* rsa->n indicates the key size */
> -    rsa->n = BN_dup(pub_rsa->n);
> -    rsa->flags |= RSA_FLAG_EXT_PKEY;
> +    if (!(pub_rsa = EVP_PKEY_get0_RSA(pkey)))
> +    {
> +        msg(M_WARN, "cryptoapicert requires an RSA certificate");
> +        goto err;
> +    }
> +
> +    /* Our private key is external, so we fill in only n and e from the public key */
> +    const BIGNUM *n = NULL;
> +    const BIGNUM *e = NULL;
> +    RSA_get0_key(pub_rsa, &n, &e, NULL);
> +    if (!RSA_set0_key(rsa, BN_dup(n), BN_dup(e), NULL))
> +    {
> +        goto err;
> +    }
> +    RSA_set_flags(rsa, RSA_flags(rsa) | RSA_FLAG_EXT_PKEY);
>      if (!RSA_set_method(rsa, my_rsa_method))
>      {
>          goto err;
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 70b19ae..bc7dbdd 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -624,6 +624,20 @@ RSA_meth_set0_app_data(RSA_METHOD *meth, void *app_data)
>  }
>  #endif
>  
> +#if !defined(HAVE_RSA_METH_GET0_APP_DATA)
> +/**
> + * Get the application data of an RSA_METHOD object
> + *
> + * @param meth               The RSA_METHOD object
> + * @return                   pointer to application data, may be NULL
> + */
> +static inline void *
> +RSA_meth_get0_app_data(const RSA_METHOD *meth)
> +{
> +    return meth ? meth->app_data : NULL;
> +}
> +#endif
> +
>  #if !defined(HAVE_EC_GROUP_ORDER_BITS) && !defined(OPENSSL_NO_EC)
>  /**
>   * Gets the number of bits of the order of an EC_GROUP
> 

Codewise no more comments.  Only "compile-tested" myself, but given the
strong resemblance to the management-external-key code I'm still
confident that this change is good.  So:

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

