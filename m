References: <cover.1515775195.git.logout@...260...>
 <e8333f0b838670e558a9fe292cea8988484cd77f.1515775195.git.logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <09416d88-d456-4ba6-a889-6274b5775a25@...1856...>
Date: Sun, 14 Jan 2018 11:06:36 +0100
MIME-Version: 1.0
In-Reply-To: <e8333f0b838670e558a9fe292cea8988484cd77f.1515775195.git.logout@...260...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/3] OpenSSL: check EVP_PKEY key types
 before returning the pkey
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

On 12-01-18 17:48, Emmanuel Deloget wrote:
> The internal EVP_PKEY::pkey member is an union thus we need to check for
> the real key type before we can return the corresponding RSA, DSA or EC
> public key.
> 
> Reported-by: Selva Nair <selva.nair@...277...>
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> 
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 70b19aea..8b29cdaf 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -240,7 +240,7 @@ X509_OBJECT_get_type(const X509_OBJECT *obj)
>  static inline RSA *
>  EVP_PKEY_get0_RSA(EVP_PKEY *pkey)
>  {
> -    return pkey ? pkey->pkey.rsa : NULL;
> +    return (pkey && pkey->type == EVP_PKEY_RSA) ? pkey->pkey.rsa : NULL;
>  }
>  #endif
>  
> @@ -254,7 +254,7 @@ EVP_PKEY_get0_RSA(EVP_PKEY *pkey)
>  static inline EC_KEY *
>  EVP_PKEY_get0_EC_KEY(EVP_PKEY *pkey)
>  {
> -    return pkey ? pkey->pkey.ec : NULL;
> +    return (pkey && pkey->type == EVP_PKEY_EC) ? pkey->pkey.ec : NULL;
>  }
>  #endif
>  
> @@ -282,7 +282,7 @@ EVP_PKEY_id(const EVP_PKEY *pkey)
>  static inline DSA *
>  EVP_PKEY_get0_DSA(EVP_PKEY *pkey)
>  {
> -    return pkey ? pkey->pkey.dsa : NULL;
> +    return (pkey && pkey->type == EVP_PKEY_DSA) ? pkey->pkey.dsa : NULL;
>  }
>  #endif
>  
> 

Looks good and passes my tests.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

