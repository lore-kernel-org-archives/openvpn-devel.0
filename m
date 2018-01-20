References: <CAKh=nwEOYB6Ab42xZUPkaHEWDwx-ECJVn79kh-rz0Y8HvG4Dbw@...278...>
 <20180117131046.32402-1-logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <1308db23-8bcc-83e9-ffb7-d6badff095e1@...1856...>
Date: Sat, 20 Jan 2018 12:30:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180117131046.32402-1-logout@...260...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] OpenSSL: remove some EVP_PKEY
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

On 17-01-18 14:10, Emmanuel Deloget wrote:
> Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as
> the same check is also performed in the later.
> 
> We also make the code a bit better by not calling the various
> EVP_PKEY_get0_*() functions twice (this needs a bit or reordering to
> avoid introducing yet another #ifndef OPENSSL_NO_EC in the code).
> 
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  src/openvpn/ssl_openssl.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 86318d4c..7061f536 100644
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
> +            RSA *rsa = EVP_PKEY_get0_RSA(pkey);
> +            DSA *dsa = EVP_PKEY_get0_DSA(pkey);
>  #ifndef OPENSSL_NO_EC
> -            else if ((EVP_PKEY_id(pkey) == EVP_PKEY_EC) && (EVP_PKEY_get0_EC_KEY(pkey) != NULL))
> +            EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
> +
> +            if (ec != NULL)
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
> +            if (rsa != NULL)
> +            {
> +                openvpn_snprintf(s2, sizeof(s2), ", %d bit RSA",
> +                                 RSA_bits(rsa));
> +            }
> +            else if (dsa != NULL)
> +            {
> +                openvpn_snprintf(s2, sizeof(s2), ", %d bit DSA",
> +                                 DSA_bits(dsa));
> +            }
> +
>              EVP_PKEY_free(pkey);
>          }
>          X509_free(cert);
> 

Unfortunately, OpenSSL 1.1.0 treats calling EVP_PKEY_get0_foo on a
non-foo key as an error.  Running 'make check' with this patch and
openssl 1.1.0 fails:

Sat Jan 20 12:23:41 2018 Control Channel: TLSv1.2, cipher TLSv1.2
ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Sat Jan 20 12:23:41 2018 OpenSSL: error:06078081:digital envelope
routines:EVP_PKEY_get0_DSA:expecting a dsa key
Sat Jan 20 12:23:41 2018 OpenSSL: error:0608308E:digital envelope
routines:EVP_PKEY_get0_EC_KEY:expecting a ec key
Sat Jan 20 12:23:41 2018 TLS_ERROR: BIO read tls_read_plaintext error

So, NAK.  (And Selva gets to keep EPV_PKEY_id() ;-) )

Sorry for not spotting this earlier, could have saved us quite a bit of
work...

-Steffan

