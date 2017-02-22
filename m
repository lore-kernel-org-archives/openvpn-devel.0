References: <cover.1487368114.git.logout@...260...>
	<3bc12a31bc806b3e4e7467d6c218a71755c4d11a.1487368114.git.logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <eb940d93-62e8-ef48-300b-89c53320ec86@...1856...>
Date: Wed, 22 Feb 2017 23:13:59 +0100
MIME-Version: 1.0
In-Reply-To: <3bc12a31bc806b3e4e7467d6c218a71755c4d11a.1487368114.git.logout@...260...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 04/15] OpenSSL: don't use direct
 access to the internal of RSA_METHOD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 17-02-17 23:00, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
> 
> OpenSSL 1.1 does not allow us to directly access the internal of
> any data type, including RSA_METHOD. We have to use the defined
> functions to do so.
> 
> Compatibility with OpenSSL 1.0 is kept by defining the corresponding
> functions when they are not found in the library.
> 
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  configure.ac                 |   9 +++
>  src/openvpn/openssl_compat.h | 186 +++++++++++++++++++++++++++++++++++++++++++
>  src/openvpn/ssl_openssl.c    |  22 ++---
>  3 files changed, 206 insertions(+), 11 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 789ad08fbaa3b3fc4c95d2b7a22332c0a93aeab4..6f31609d0aeedd2c7841d271ecadd1aa6f3b11da 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -905,6 +905,15 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
>  			X509_STORE_get0_objects \
>  			X509_OBJECT_free \
>  			X509_OBJECT_get_type \
> +			RSA_meth_new \
> +			RSA_meth_free \
> +			RSA_meth_set_pub_enc \
> +			RSA_meth_set_pub_dec \
> +			RSA_meth_set_priv_enc \
> +			RSA_meth_set_priv_dec \
> +			RSA_meth_set_init \
> +			RSA_meth_set_finish \
> +			RSA_meth_set0_app_data \
>  		],
>  		,
>  		[]
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 458a6adbe2b3fcd5ea63dcea6596cc24315d463c..b1748754f821f472cf9ed7083ade918336c9b075 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -41,6 +41,8 @@
>  #include "config-msvc.h"
>  #endif
>  
> +#include "buffer.h"
> +
>  #include <openssl/ssl.h>
>  #include <openssl/x509.h>
>  
> @@ -117,4 +119,188 @@ X509_OBJECT_get_type(const X509_OBJECT *obj)
>  }
>  #endif
>  
> +#if !defined(HAVE_RSA_METH_NEW)
> +/**
> + * Allocate a new RSA method object
> + *
> + * @param name               The object name
> + * @param flags              Configuration flags
> + * @return                   A new RSA method object
> + */
> +static inline RSA_METHOD *
> +RSA_meth_new(const char *name, int flags)
> +{
> +    RSA_METHOD *rsa_meth = NULL;
> +    ALLOC_OBJ_CLEAR(rsa_meth, RSA_METHOD);
> +    rsa_meth->name = name;
> +    rsa_meth->flags = flags;
> +    return rsa_meth;
> +}
> +#endif
> +
> +#if !defined(HAVE_RSA_METH_FREE)
> +/**
> + * Free an existing RSA_METHOD object
> + *
> + * @param meth               The RSA_METHOD object
> + */
> +static inline void
> +RSA_meth_free(RSA_METHOD *meth)
> +{
> +    free(meth);
> +}
> +#endif

I think it would be nicer to more closely mimic the 1.1 behaviour in
RSA_meth_{new,free}(), and copy the name string in new() and free it
again in free().  That could prevent a future use-after-free that would
occur for pre-1.1.0, but not 1.1.0+:

  char *mystring = calloc(50, 1);
  RSA_METHOD *meth = RSA_meth_new(mystring, 0);
  free(mystring);

  meth.smoke();
       ^^ might cause problems

(Hint: use string_alloc(x, NULL).)

> +
> +#if !defined(HAVE_RSA_METH_SET_PUB_ENC)
> +/**
> + * Set the public encoding function of an RSA_METHOD object
> + *
> + * @param meth               The RSA_METHOD object
> + * @param pub_enc            the public encoding function
> + * @return                   1 on success, 0 on error
> + */
> +static inline int
> +RSA_meth_set_pub_enc(RSA_METHOD *meth,
> +                     int (*pub_enc) (int flen, const unsigned char *from,
> +                                     unsigned char *to, RSA *rsa,
> +                                     int padding))
> +{
> +    if (meth)
> +    {
> +        meth->rsa_pub_enc = pub_enc;
> +        return 1;
> +    }
> +    return 0;
> +}
> +#endif
> +
> +#if !defined(HAVE_RSA_METH_SET_PUB_DEC)
> +/**
> + * Set the public decoding function of an RSA_METHOD object
> + *
> + * @param meth               The RSA_METHOD object
> + * @param pub_dec            the public decoding function
> + * @return                   1 on success, 0 on error
> + */
> +static inline int
> +RSA_meth_set_pub_dec(RSA_METHOD *meth,
> +                     int (*pub_dec) (int flen, const unsigned char *from,
> +                                     unsigned char *to, RSA *rsa,
> +                                     int padding))
> +{
> +    if (meth)
> +    {
> +        meth->rsa_pub_dec = pub_dec;
> +        return 1;
> +    }
> +    return 0;
> +}
> +#endif
> +
> +#if !defined(HAVE_RSA_METH_SET_PRIV_ENC)
> +/**
> + * Set the private encoding function of an RSA_METHOD object
> + *
> + * @param meth               The RSA_METHOD object
> + * @param priv_enc           the private encoding function
> + * @return                   1 on success, 0 on error
> + */
> +static inline int
> +RSA_meth_set_priv_enc(RSA_METHOD *meth,
> +                      int (*priv_enc) (int flen, const unsigned char *from,
> +                                       unsigned char *to, RSA *rsa,
> +                                       int padding))
> +{
> +    if (meth)
> +    {
> +        meth->rsa_priv_enc = priv_enc;
> +        return 1;
> +    }
> +    return 0;
> +}
> +#endif
> +
> +#if !defined(HAVE_RSA_METH_SET_PRIV_DEC)
> +/**
> + * Set the private decoding function of an RSA_METHOD object
> + *
> + * @param meth               The RSA_METHOD object
> + * @param priv_dec           the private decoding function
> + * @return                   1 on success, 0 on error
> + */
> +static inline int
> +RSA_meth_set_priv_dec(RSA_METHOD *meth,
> +                      int (*priv_dec) (int flen, const unsigned char *from,
> +                                       unsigned char *to, RSA *rsa,
> +                                       int padding))
> +{
> +    if (meth)
> +    {
> +        meth->rsa_priv_dec = priv_dec;
> +        return 1;
> +    }
> +    return 0;
> +}
> +#endif
> +
> +#if !defined(HAVE_RSA_METH_SET_INIT)
> +/**
> + * Set the init function of an RSA_METHOD object
> + *
> + * @param meth               The RSA_METHOD object
> + * @param init               the init function
> + * @return                   1 on success, 0 on error
> + */
> +static inline int
> +RSA_meth_set_init(RSA_METHOD *meth, int (*init) (RSA *rsa))
> +{
> +    if (meth)
> +    {
> +        meth->init = init;
> +        return 1;
> +    }
> +    return 0;
> +}
> +#endif
> +
> +#if !defined(HAVE_RSA_METH_SET_FINISH)
> +/**
> + * Set the finish function of an RSA_METHOD object
> + *
> + * @param meth               The RSA_METHOD object
> + * @param finish             the finish function
> + * @return                   1 on success, 0 on error
> + */
> +static inline int
> +RSA_meth_set_finish(RSA_METHOD *meth, int (*finish) (RSA *rsa))
> +{
> +    if (meth)
> +    {
> +        meth->finish = finish;
> +        return 1;
> +    }
> +    return 0;
> +}
> +#endif
> +
> +#if !defined(HAVE_RSA_METH_SET0_APP_DATA)
> +/**
> + * Set the application data of an RSA_METHOD object
> + *
> + * @param meth               The RSA_METHOD object
> + * @param app_data           Application data
> + * @return                   1 on success, 0 on error
> + */
> +static inline int
> +RSA_meth_set0_app_data(RSA_METHOD *meth, void *app_data)
> +{
> +    if (meth)
> +    {
> +        meth->app_data = app_data;
> +        return 1;
> +    }
> +    return 0;
> +}
> +#endif
> +
>  #endif /* OPENSSL_COMPAT_H_ */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index bf0f643f25439f71cbfe71bf5a7e8eb834b0f012..f011e06702529ff34e91f6d0169d1adf8cc9d767 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -978,7 +978,7 @@ rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
>  static int
>  rsa_finish(RSA *rsa)
>  {
> -    free((void *)rsa->meth);
> +    RSA_meth_free(rsa->meth);
>      rsa->meth = NULL;
>      return 1;
>  }

This change still works, but he follow up change in this method in 07/15
causes problems:

    static int
    rsa_finish(RSA *rsa)
    {
   -    RSA_meth_free(rsa->meth);
   -    rsa->meth = NULL;
   +    RSA_METHOD *meth = (RSA_METHOD *)RSA_get_method(rsa);
   +    RSA_meth_free(meth);
   +    RSA_set_method(rsa, NULL);
        return 1;
    }

Casting away const on the object returned by RSA_get_method() is a
smell, but it really fails because RSA_set_method(rsa, NULL) calls
rsa->meth->finish(), which is implemented by this very function.  That
means that RSA_meth_free() will perform a double free on meth->name.

I briefly looked into a fix, but didn't immediately see a nice solution
here.  At least the RSA_set_method(rsa, RSA_get_default_method())
doesn't work either, because you'll end up with rsa_finish() and
RSA_set_method() calling each other infinitely...

(Noting this here, because the fix for 07 might cause changes to this
patch too.)

> @@ -1053,16 +1053,16 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
>      ASSERT(NULL != cert);
>  
>      /* allocate custom RSA method object */
> -    ALLOC_OBJ_CLEAR(rsa_meth, RSA_METHOD);
> -    rsa_meth->name = "OpenVPN external private key RSA Method";
> -    rsa_meth->rsa_pub_enc = rsa_pub_enc;
> -    rsa_meth->rsa_pub_dec = rsa_pub_dec;
> -    rsa_meth->rsa_priv_enc = rsa_priv_enc;
> -    rsa_meth->rsa_priv_dec = rsa_priv_dec;
> -    rsa_meth->init = NULL;
> -    rsa_meth->finish = rsa_finish;
> -    rsa_meth->flags = RSA_METHOD_FLAG_NO_CHECK;
> -    rsa_meth->app_data = NULL;
> +    rsa_meth = RSA_meth_new("OpenVPN external private key RSA Method",
> +                            RSA_METHOD_FLAG_NO_CHECK);
> +    check_malloc_return(rsa_meth);
> +    RSA_meth_set_pub_enc(rsa_meth, rsa_pub_enc);
> +    RSA_meth_set_pub_dec(rsa_meth, rsa_pub_dec);
> +    RSA_meth_set_priv_enc(rsa_meth, rsa_priv_enc);
> +    RSA_meth_set_priv_dec(rsa_meth, rsa_priv_dec);
> +    RSA_meth_set_init(rsa_meth, NULL);
> +    RSA_meth_set_finish(rsa_meth, rsa_finish);
> +    RSA_meth_set0_app_data(rsa_meth, NULL);
>  
>      /* allocate RSA object */
>      rsa = RSA_new();
> 

-Steffan

