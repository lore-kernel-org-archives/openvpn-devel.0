Message-ID: <2ec56ba7-4628-eafc-1ccd-bc8b5c2a164d@...1227...>
Date: Thu, 18 Aug 2022 22:16:21 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220811171120.59361-1-maximilian.fillinger@...2507...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220811171120.59361-1-maximilian.fillinger@...2507...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Update openssl_compat.h for
 newer LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

Am 11.08.22 um 19:11 schrieb Max Fillinger:
> LibreSSL has added some of the functions that are defined here. However,
> we still need RSA_F_RSA_OSSL_PRIVATE_ENCRYPT.
> 
> v2: Change ifdef condition for RSA_F_RSA_OSSL_PRIVATE_ENCRYPT.
> 
> Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
> ---
>   src/openvpn/openssl_compat.h | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index b3ee94f1..c78d2229 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -51,8 +51,8 @@
>   #define SSL_CTX_set1_groups SSL_CTX_set1_curves
>   #endif
>   
> -/* Functionality missing in LibreSSL and OpenSSL 1.0.2 */
> -#if (OPENSSL_VERSION_NUMBER < 0x10100000L || defined(LIBRESSL_VERSION_NUMBER)) && !defined(ENABLE_CRYPTO_WOLFSSL)
> +/* Functionality missing in LibreSSL before 3.5 and OpenSSL 1.0.2 */
> +#if (OPENSSL_VERSION_NUMBER < 0x10100000L || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050000fL)) && !defined(ENABLE_CRYPTO_WOLFSSL)
>   /**
>    * Destroy a X509 object
>    *
> @@ -68,11 +68,13 @@ X509_OBJECT_free(X509_OBJECT *obj)
>       }
>   }
>   
> -#define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
>   #define EVP_CTRL_AEAD_SET_TAG                EVP_CTRL_GCM_SET_TAG
>   #define EVP_CTRL_AEAD_GET_TAG                EVP_CTRL_GCM_GET_TAG
>   #endif
>   
> +#if OPENSSL_VERSION_NUMBER < 0x10100000L || defined(LIBRESSL_VERSION_NUMBER)
> +#define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
> +#endif
>   

The patch basically removes the !defined(ENABLE_CRYPTO_WOLFSSL) from 
this part of the ifdef and that breaks wolfSSL. While I don't think we 
should much effort into wolfSSL, we should also not break it on purpose.

Arne

