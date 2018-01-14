References: <CAKh=nwFOSOCugW1JWYfiQFZLTKRBc6qoi=U9ewzjOSpaGP1-Kg@...278...>
 <6a6ede658da2e35b718a9ccb733b132a955ffefe.1515792908.git.logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <183bd138-e733-042e-9cc3-c66bbf6ea9bd@...1856...>
Date: Sun, 14 Jan 2018 11:26:51 +0100
MIME-Version: 1.0
In-Reply-To: <6a6ede658da2e35b718a9ccb733b132a955ffefe.1515792908.git.logout@...260...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] OpenSSL: remove some EVP_PKEY
 type checks
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

On 12-01-18 22:37, Emmanuel Deloget wrote:
> Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as
> the same check is also performed in the later.
> 
> We also make the code a bit better by not calling the various
> EVP_PKEY_get0_*() functions twice (this needs a bit or reordering to
> avoid introducing yet another #ifndef OPENSSL_NO_EC in the code).

Checking double is a bit silly, but we can fix that by simply removing
the "EVP_PKEY_id() == ... && " occurrences. (That still allows us to
remove it from the compat wrapper.)

I'm not sure that moving the variables outside the if() scope actually
improves the code.  At least I think the original flow is easier to
read.  Mostly due to the #ifdef noise, but still.  In a path that's not
performance-critical, I prefer readability over performance.

> Signed-off-by: Emmanuel Deloget <logout@...260...>
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 711bba11..7943fb2c 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1699,22 +1699,13 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
>          EVP_PKEY *pkey = X509_get_pubkey(cert);
>          if (pkey != NULL)
>          {
> -            if ((EVP_PKEY_id(pkey) == EVP_PKEY_RSA) && (EVP_PKEY_get0_RSA(pkey) != NULL))
> -            {
> -                RSA *rsa = EVP_PKEY_get0_RSA(pkey);
> -                openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
> -                                 RSA_bits(rsa));
> -            }
> -            else if ((EVP_PKEY_id(pkey) == EVP_PKEY_DSA) && (EVP_PKEY_get0_DSA(pkey) != NULL))
> -            {
> -                DSA *dsa = EVP_PKEY_get0_DSA(pkey);
> -                openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
> -                                 DSA_bits(dsa));
> -            }
> +            RSA *rsa = NULL;
> +            DSA *dsa = NULL;
>  #ifndef OPENSSL_NO_EC
> -            else if ((EVP_PKEY_id(pkey) == EVP_PKEY_EC) && (EVP_PKEY_get0_EC_KEY(pkey) != NULL))
> +            EC_KEY *ec = NULL;
> +
> +            if ((ec = EVP_PKEY_get0_EC_KEY(pkey)) != NULL)
>              {
> -                EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
>                  const EC_GROUP *group = EC_KEY_get0_group(ec);
>                  const char* curve;
>  
> @@ -1726,9 +1717,19 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
>  
>                  openvpn_snprintf(s2, sizeof(s2), ", %d bit EC, curve: %s",
>                                   EC_GROUP_order_bits(group), curve);
> -
> -            }
> +            } else
>  #endif
> +            if ((rsa = EVP_PKEY_get0_RSA(pkey)) != NULL)
> +            {
> +                openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
> +                                 RSA_bits(rsa));
> +            }
> +            else if ((dsa = EVP_PKEY_get0_DSA(pkey)) != NULL)
> +            {
> +                openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
> +                                 DSA_bits(dsa));
> +            }
> +
>              EVP_PKEY_free(pkey);
>          }
>          X509_free(cert);
> 

-Steffan

