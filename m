References: <20210406162518.4075-1-arne@...1227...>
 <20210406162518.4075-5-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <59fa6949-300a-d13d-efb8-e3ba128ce6c2@...2181...>
Date: Tue, 6 Apr 2021 23:01:19 +0200
MIME-Version: 1.0
In-Reply-To: <20210406162518.4075-5-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 5/5] Remove OpenSSL configure checks
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

On 06/04/2021 18:25, Arne Schwabe wrote:
> These checks for the functions take a lot of time in configure call and
> also having these checks make it more blurry for which of the supported
> OpenSSL versions (and libraries claiming to be OpenSSL) are actually
> needed.
> 
> Tested with OpenSSL 1.1.1(Ubuntu 20, macOS), 1.0.2 (CentOS7),
> 1.1.0 (Debian stretch), LibreSSL (OpenBSD 6.8) and wolfSSL
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  configure.ac                 |  84 --------------------
>  src/openvpn/openssl_compat.h | 144 +++++++----------------------------
>  2 files changed, 29 insertions(+), 199 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 81700abcb..747325164 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -846,50 +846,6 @@ if test "${with_crypto_library}" = "openssl"; then
>  	# have this feature
>  	have_export_keying_material="yes"
>  
> -	AC_CHECK_FUNCS(
> -		[ \
> -			HMAC_CTX_new \
> -			HMAC_CTX_free \
> -			HMAC_CTX_reset \
> -			EVP_MD_CTX_new \
> -			EVP_MD_CTX_free \
> -			EVP_MD_CTX_reset \
> -			EVP_CIPHER_CTX_reset \
> -			OpenSSL_version \
> -			SSL_CTX_get_default_passwd_cb \
> -			SSL_CTX_get_default_passwd_cb_userdata \
> -			SSL_CTX_set1_groups \
> -			SSL_CTX_set_security_level \
> -			X509_get0_notBefore \
> -			X509_get0_notAfter \
> -			X509_get0_pubkey \
> -			X509_STORE_get0_objects \
> -			X509_OBJECT_free \
> -			X509_OBJECT_get_type \
> -			EVP_PKEY_get0_RSA \
> -			EVP_PKEY_get0_DSA \
> -			EVP_PKEY_get0_EC_KEY \
> -			RSA_set_flags \
> -			RSA_bits \
> -			RSA_get0_key \
> -			RSA_set0_key \
> -			DSA_get0_pqg \
> -			DSA_bits \
> -			RSA_meth_new \
> -			RSA_meth_free \
> -			RSA_meth_set_pub_enc \
> -			RSA_meth_set_pub_dec \
> -			RSA_meth_set_priv_enc \
> -			RSA_meth_set_priv_dec \
> -			RSA_meth_set_init \
> -			RSA_meth_set_sign \
> -			RSA_meth_set_finish \
> -			RSA_meth_set0_app_data \
> -			RSA_meth_get0_app_data \
> -			EC_GROUP_order_bits
> -		]
> -	)
> -
>  	CFLAGS="${saved_CFLAGS}"
>  	LIBS="${saved_LIBS}"
>  
> @@ -999,46 +955,6 @@ elif test "${with_crypto_library}" = "wolfssl"; then
>  	# wolfSSL signal EKM support
>  	have_export_keying_material="yes"
>  
> -	AC_DEFINE([HAVE_HMAC_CTX_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_HMAC_CTX_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_HMAC_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_EVP_MD_CTX_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_EVP_MD_CTX_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_EVP_MD_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_EVP_CIPHER_CTX_RESET], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_OPENSSL_VERSION], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_SSL_CTX_SET_SECURITY_LEVEL], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_X509_GET0_NOTBEFORE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_X509_GET0_NOTAFTER], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_X509_GET0_PUBKEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_X509_STORE_GET0_OBJECTS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_X509_OBJECT_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_X509_OBJECT_GET_TYPE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_EVP_PKEY_ID], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_EVP_PKEY_GET0_RSA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_EVP_PKEY_GET0_DSA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_EVP_PKEY_GET0_EC_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_SET_FLAGS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_GET0_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_SET0_KEY], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_DSA_GET0_PQG], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_DSA_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_METH_NEW], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_METH_FREE], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_METH_SET_PUB_ENC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_METH_SET_PUB_DEC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_METH_SET_PRIV_ENC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_METH_SET_PRIV_DEC], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_METH_SET_INIT], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_METH_SET_SIGN], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_METH_SET_FINISH], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_METH_SET0_APP_DATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_RSA_METH_GET0_APP_DATA], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -	AC_DEFINE([HAVE_EC_GROUP_ORDER_BITS], [1], [Emulate AC_CHECK_FUNCS since these are defined as macros])
> -
>  	if test "${enable_wolfssl_options_h}" = "yes"; then
>  		AC_DEFINE([EXTERNAL_OPTS_OPENVPN], [1], [Include options.h from wolfSSL library])
>  	else
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index ff024feff..9fc4f2600 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -46,12 +46,36 @@
>  #include <openssl/ssl.h>
>  #include <openssl/x509.h>
>  
> +/* Functionality missing in 1.1.0 */
> +#if OPENSSL_VERSION_NUMBER < 0x10101000L && !defined(ENABLE_CRYPTO_WOLFSSL)
> +#define SSL_CTX_set1_groups SSL_CTX_set1_curves
> +#endif
> +
> +/* Functionality missing in LibreSSL and OpenSSL 1.0.2 */
>  #if (OPENSSL_VERSION_NUMBER < 0x10100000L || defined(LIBRESSL_VERSION_NUMBER)) && !defined(ENABLE_CRYPTO_WOLFSSL)
> -#define EVP_CTRL_AEAD_SET_TAG EVP_CTRL_GCM_SET_TAG
> -#define EVP_CTRL_AEAD_GET_TAG EVP_CTRL_GCM_GET_TAG
> +/**
> + * Destroy a X509 object
> + *
> + * @param obj                X509 object
> + */
> +static inline void
> +X509_OBJECT_free(X509_OBJECT *obj)
> +{
> +    if (obj)
> +    {
> +        X509_OBJECT_free_contents(obj);
> +        OPENSSL_free(obj);
> +    }
> +}
> +
> +#define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
> +#define EVP_CTRL_AEAD_SET_TAG                EVP_CTRL_GCM_SET_TAG
> +#define EVP_CTRL_AEAD_GET_TAG                EVP_CTRL_GCM_GET_TAG
>  #endif
>  
> -#if !defined(HAVE_EVP_MD_CTX_RESET)
> +
> +/* Functionality missing in 1.0.2 */
> +#if OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSSL)
>  /**
>   * Reset a message digest context
>   *
> @@ -64,9 +88,7 @@ EVP_MD_CTX_reset(EVP_MD_CTX *ctx)
>      EVP_MD_CTX_cleanup(ctx);
>      return 1;
>  }
> -#endif
>  
> -#if !defined(HAVE_EVP_MD_CTX_FREE)
>  /**
>   * Free an existing message digest context
>   *
> @@ -77,9 +99,7 @@ EVP_MD_CTX_free(EVP_MD_CTX *ctx)
>  {
>      free(ctx);
>  }
> -#endif
>  
> -#if !defined(HAVE_EVP_MD_CTX_NEW)
>  /**
>   * Allocate a new message digest object
>   *
> @@ -92,21 +112,11 @@ EVP_MD_CTX_new(void)
>      ALLOC_OBJ_CLEAR(ctx, EVP_MD_CTX);
>      return ctx;
>  }
> -#endif
>  
> -#if !defined(HAVE_EVP_CIPHER_CTX_RESET)
>  #define EVP_CIPHER_CTX_reset EVP_CIPHER_CTX_init
> -#endif
> -
> -#if !defined(HAVE_X509_GET0_NOTBEFORE)
>  #define X509_get0_notBefore X509_get_notBefore
> -#endif
> -
> -#if !defined(HAVE_X509_GET0_NOTAFTER)
>  #define X509_get0_notAfter X509_get_notAfter
> -#endif
>  
> -#if !defined(HAVE_HMAC_CTX_RESET)
>  /**
>   * Reset a HMAC context
>   *
> @@ -129,9 +139,7 @@ HMAC_CTX_reset(HMAC_CTX *ctx)
>      HMAC_CTX_init(ctx);
>      return 1;
>  }
> -#endif
>  
> -#if !defined(HAVE_HMAC_CTX_FREE)
>  /**
>   * Cleanup and free an existing HMAC context
>   *
> @@ -143,9 +151,7 @@ HMAC_CTX_free(HMAC_CTX *ctx)
>      HMAC_CTX_cleanup(ctx);
>      free(ctx);
>  }
> -#endif
>  
> -#if !defined(HAVE_HMAC_CTX_NEW)
>  /**
>   * Allocate a new HMAC context object
>   *
> @@ -158,9 +164,7 @@ HMAC_CTX_new(void)
>      ALLOC_OBJ_CLEAR(ctx, HMAC_CTX);
>      return ctx;
>  }
> -#endif
>  
> -#if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA)
>  /**
>   * Fetch the default password callback user data from the SSL context
>   *
> @@ -172,9 +176,7 @@ SSL_CTX_get_default_passwd_cb_userdata(SSL_CTX *ctx)
>  {
>      return ctx ? ctx->default_passwd_callback_userdata : NULL;
>  }
> -#endif
>  
> -#if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB)
>  /**
>   * Fetch the default password callback from the SSL context
>   *
> @@ -186,15 +188,7 @@ SSL_CTX_get_default_passwd_cb(SSL_CTX *ctx)
>  {
>      return ctx ? ctx->default_passwd_callback : NULL;
>  }
> -#endif
>  
> -/* This function is implemented as macro, so the configure check for the
> - * function may fail, so we check for both variants here */
> -#if !defined(HAVE_SSL_CTX_SET1_GROUPS) && !defined(SSL_CTX_set1_groups)
> -#define SSL_CTX_set1_groups SSL_CTX_set1_curves
> -#endif
> -
> -#if !defined(HAVE_X509_GET0_PUBKEY)
>  /**
>   * Get the public key from a X509 certificate
>   *
> @@ -207,9 +201,7 @@ X509_get0_pubkey(const X509 *x)
>      return (x && x->cert_info && x->cert_info->key) ?
>             x->cert_info->key->pkey : NULL;
>  }
> -#endif
>  
> -#if !defined(HAVE_X509_STORE_GET0_OBJECTS)
>  /**
>   * Fetch the X509 object stack from the X509 store
>   *
> @@ -221,26 +213,7 @@ static inline STACK_OF(X509_OBJECT)
>  {
>      return store ? store->objs : NULL;
>  }
> -#endif
> -
> -#if !defined(HAVE_X509_OBJECT_FREE)
> -/**
> - * Destroy a X509 object
> - *
> - * @param obj                X509 object
> - */
> -static inline void
> -X509_OBJECT_free(X509_OBJECT *obj)
> -{
> -    if (obj)
> -    {
> -        X509_OBJECT_free_contents(obj);
> -        OPENSSL_free(obj);
> -    }
> -}
> -#endif
>  
> -#if !defined(HAVE_X509_OBJECT_GET_TYPE)
>  /**
>   * Get the type of an X509 object
>   *
> @@ -252,9 +225,7 @@ X509_OBJECT_get_type(const X509_OBJECT *obj)
>  {
>      return obj ? obj->type : X509_LU_FAIL;
>  }
> -#endif
>  
> -#if !defined(HAVE_EVP_PKEY_GET0_RSA)
>  /**
>   * Get the RSA object of a public key
>   *
> @@ -266,9 +237,7 @@ EVP_PKEY_get0_RSA(EVP_PKEY *pkey)
>  {
>      return (pkey && pkey->type == EVP_PKEY_RSA) ? pkey->pkey.rsa : NULL;
>  }
> -#endif
>  
> -#if !defined(HAVE_EVP_PKEY_GET0_EC_KEY) && !defined(OPENSSL_NO_EC)
>  /**
>   * Get the EC_KEY object of a public key
>   *
> @@ -280,9 +249,8 @@ EVP_PKEY_get0_EC_KEY(EVP_PKEY *pkey)
>  {
>      return (pkey && pkey->type == EVP_PKEY_EC) ? pkey->pkey.ec : NULL;
>  }
> -#endif
>  
> -#if !defined(HAVE_EVP_PKEY_GET0_DSA)
> +
>  /**
>   * Get the DSA object of a public key
>   *
> @@ -294,9 +262,7 @@ EVP_PKEY_get0_DSA(EVP_PKEY *pkey)
>  {
>      return (pkey && pkey->type == EVP_PKEY_DSA) ? pkey->pkey.dsa : NULL;
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_SET_FLAGS)
>  /**
>   * Set the RSA flags
>   *
> @@ -311,9 +277,7 @@ RSA_set_flags(RSA *rsa, int flags)
>          rsa->flags = flags;
>      }
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_GET0_KEY)
>  /**
>   * Get the RSA parameters
>   *
> @@ -339,9 +303,7 @@ RSA_get0_key(const RSA *rsa, const BIGNUM **n,
>          *d = rsa ? rsa->d : NULL;
>      }
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_SET0_KEY)
>  /**
>   * Set the RSA parameters
>   *
> @@ -378,9 +340,7 @@ RSA_set0_key(RSA *rsa, BIGNUM *n, BIGNUM *e, BIGNUM *d)
>  
>      return 1;
>  }
> -#endif /* if !defined(HAVE_RSA_SET0_KEY) */
>  
> -#if !defined(HAVE_RSA_BITS)
>  /**
>   * Number of significant RSA bits
>   *
> @@ -394,9 +354,7 @@ RSA_bits(const RSA *rsa)
>      RSA_get0_key(rsa, &n, NULL, NULL);
>      return n ? BN_num_bits(n) : 0;
>  }
> -#endif
>  
> -#if !defined(HAVE_DSA_GET0_PQG)
>  /**
>   * Get the DSA parameters
>   *
> @@ -422,9 +380,7 @@ DSA_get0_pqg(const DSA *dsa, const BIGNUM **p,
>          *g = dsa ? dsa->g : NULL;
>      }
>  }
> -#endif
>  
> -#if !defined(HAVE_DSA_BITS)
>  /**
>   * Number of significant DSA bits
>   *
> @@ -438,9 +394,7 @@ DSA_bits(const DSA *dsa)
>      DSA_get0_pqg(dsa, &p, NULL, NULL);
>      return p ? BN_num_bits(p) : 0;
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_METH_NEW)
>  /**
>   * Allocate a new RSA method object
>   *
> @@ -457,9 +411,7 @@ RSA_meth_new(const char *name, int flags)
>      rsa_meth->flags = flags;
>      return rsa_meth;
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_METH_FREE)
>  /**
>   * Free an existing RSA_METHOD object
>   *
> @@ -480,9 +432,7 @@ RSA_meth_free(RSA_METHOD *meth)
>          free(meth);
>      }
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_METH_SET_PUB_ENC)
>  /**
>   * Set the public encoding function of an RSA_METHOD object
>   *
> @@ -503,9 +453,7 @@ RSA_meth_set_pub_enc(RSA_METHOD *meth,
>      }
>      return 0;
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_METH_SET_PUB_DEC)
>  /**
>   * Set the public decoding function of an RSA_METHOD object
>   *
> @@ -526,9 +474,7 @@ RSA_meth_set_pub_dec(RSA_METHOD *meth,
>      }
>      return 0;
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_METH_SET_PRIV_ENC)
>  /**
>   * Set the private encoding function of an RSA_METHOD object
>   *
> @@ -549,9 +495,7 @@ RSA_meth_set_priv_enc(RSA_METHOD *meth,
>      }
>      return 0;
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_METH_SET_PRIV_DEC)
>  /**
>   * Set the private decoding function of an RSA_METHOD object
>   *
> @@ -572,9 +516,7 @@ RSA_meth_set_priv_dec(RSA_METHOD *meth,
>      }
>      return 0;
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_METH_SET_INIT)
>  /**
>   * Set the init function of an RSA_METHOD object
>   *
> @@ -592,9 +534,7 @@ RSA_meth_set_init(RSA_METHOD *meth, int (*init)(RSA *rsa))
>      }
>      return 0;
>  }
> -#endif
>  
> -#if !defined (HAVE_RSA_METH_SET_SIGN)
>  /**
>   * Set the sign function of an RSA_METHOD object
>   *
> @@ -613,9 +553,7 @@ RSA_meth_set_sign(RSA_METHOD *meth,
>      meth->rsa_sign = sign;
>      return 1;
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_METH_SET_FINISH)
>  /**
>   * Set the finish function of an RSA_METHOD object
>   *
> @@ -633,9 +571,7 @@ RSA_meth_set_finish(RSA_METHOD *meth, int (*finish)(RSA *rsa))
>      }
>      return 0;
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_METH_SET0_APP_DATA)
>  /**
>   * Set the application data of an RSA_METHOD object
>   *
> @@ -653,9 +589,7 @@ RSA_meth_set0_app_data(RSA_METHOD *meth, void *app_data)
>      }
>      return 0;
>  }
> -#endif
>  
> -#if !defined(HAVE_RSA_METH_GET0_APP_DATA)
>  /**
>   * Get the application data of an RSA_METHOD object
>   *
> @@ -667,9 +601,7 @@ RSA_meth_get0_app_data(const RSA_METHOD *meth)
>  {
>      return meth ? meth->app_data : NULL;
>  }
> -#endif
>  
> -#if !defined(HAVE_EC_GROUP_ORDER_BITS) && !defined(OPENSSL_NO_EC)
>  /**
>   * Gets the number of bits of the order of an EC_GROUP
>   *
> @@ -685,22 +617,11 @@ EC_GROUP_order_bits(const EC_GROUP *group)
>      BN_free(order);
>      return bits;
>  }
> -#endif
>  
>  /* SSLeay symbols have been renamed in OpenSSL 1.1 */
> -#ifndef OPENSSL_VERSION
>  #define OPENSSL_VERSION SSLEAY_VERSION
> -#endif
> -
> -#ifndef HAVE_OPENSSL_VERSION
>  #define OpenSSL_version SSLeay_version
> -#endif
>  
> -#if !defined(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT)
> -#define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
> -#endif
> -
> -#ifndef SSL_CTX_get_min_proto_version
>  /** Return the min SSL protocol version currently enabled in the context.
>   *  If no valid version >= TLS1.0 is found, return 0. */
>  static inline int
> @@ -721,9 +642,7 @@ SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
>      }
>      return 0;
>  }
> -#endif /* SSL_CTX_get_min_proto_version */
>  
> -#ifndef SSL_CTX_get_max_proto_version
>  /** Return the max SSL protocol version currently enabled in the context.
>   *  If no valid version >= TLS1.0 is found, return 0. */
>  static inline int
> @@ -744,9 +663,7 @@ SSL_CTX_get_max_proto_version(SSL_CTX *ctx)
>      }
>      return 0;
>  }
> -#endif /* SSL_CTX_get_max_proto_version */
>  
> -#ifndef SSL_CTX_set_min_proto_version
>  /** Mimics SSL_CTX_set_min_proto_version for OpenSSL < 1.1 */
>  static inline int
>  SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
> @@ -773,9 +690,7 @@ SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
>  
>      return 1;
>  }
> -#endif /* SSL_CTX_set_min_proto_version */
>  
> -#ifndef SSL_CTX_set_max_proto_version
>  /** Mimics SSL_CTX_set_max_proto_version for OpenSSL < 1.1 */
>  static inline int
>  SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
> @@ -802,6 +717,5 @@ SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
>  
>      return 1;
>  }
> -#endif /* SSL_CTX_set_max_proto_version */
> -
> +#endif
>  #endif /* OPENSSL_COMPAT_H_ */
> 

I like the new approach a lot.
It definitely helps keeping track of "what compat code do we need? and
for which version?"

Just one suggestion:
I think it would still be useful to add a comment on the #endif line to
explicitly say what if we are closing.

i.e:

#endif /* OPENSSL_VERSION_NUMBER < 0x10101000L &&
!defined(ENABLE_CRYPTO_WOLFSSL) */

That helps your brain when the corresponding #if is far away or you have
more than one nearby.

Other than that, it compiles on openssl-1.1.1, 1.1.0 and 1.0.2.
Test on Linux and Windows (openssl-1.1.1 only in this case).

Regards,

-- 
Antonio Quartulli

