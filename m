From: Steffan Karger <steffan.karger@...1435...>
References: <1516770381-29466-1-git-send-email-selva.nair@...277...>
 <1516770381-29466-2-git-send-email-selva.nair@...277...>
Message-ID: <e8846dfb-4d69-3e70-2602-0ed516f7a760@...1435...>
Date: Fri, 26 Jan 2018 11:26:42 +0100
MIME-Version: 1.0
In-Reply-To: <1516770381-29466-2-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/3] Move code to free cd to a function
 CAPI_DATA_free()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 24-01-18 06:06, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - Avoids code-repetition especially so when support
>   for more key types are added.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/cryptoapi.c | 63 ++++++++++++++++++++++---------------------------
>  1 file changed, 28 insertions(+), 35 deletions(-)
> 
> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index f155123..00e78b6 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -108,6 +108,32 @@ typedef struct _CAPI_DATA {
>      BOOL free_crypt_prov;
>  } CAPI_DATA;
>  
> +static void
> +CAPI_DATA_free(CAPI_DATA *cd)
> +{
> +    if (!cd)
> +    {
> +        return;
> +    }
> +    if (cd->free_crypt_prov && cd->crypt_prov)
> +    {
> +        if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
> +        {
> +            NCryptFreeObject(cd->crypt_prov);
> +        }
> +        else
> +        {
> +            CryptReleaseContext(cd->crypt_prov, 0);
> +        }
> +    }
> +    if (cd->cert_context)
> +    {
> +        CertFreeCertificateContext(cd->cert_context);
> +    }
> +    free(cd);
> +}
> +
> +

This could have been a single newline.

>  static char *
>  ms_error_text(DWORD ms_err)
>  {
> @@ -363,22 +389,7 @@ finish(RSA *rsa)
>      {
>          return 0;
>      }
> -    if (cd->crypt_prov && cd->free_crypt_prov)
> -    {
> -        if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
> -        {
> -            NCryptFreeObject(cd->crypt_prov);
> -        }
> -        else
> -        {
> -            CryptReleaseContext(cd->crypt_prov, 0);
> -        }
> -    }
> -    if (cd->cert_context)
> -    {
> -        CertFreeCertificateContext(cd->cert_context);
> -    }
> -    free(cd);
> +    CAPI_DATA_free(cd);
>      RSA_meth_free((RSA_METHOD*) rsa_meth);
>      return 1;
>  }
> @@ -614,25 +625,7 @@ err:
>          {
>              free(my_rsa_method);
>          }
> -        if (cd)
> -        {
> -            if (cd->free_crypt_prov && cd->crypt_prov)
> -            {
> -                if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
> -                {
> -                    NCryptFreeObject(cd->crypt_prov);
> -                }
> -                else
> -                {
> -                    CryptReleaseContext(cd->crypt_prov, 0);
> -                }
> -            }
> -            if (cd->cert_context)
> -            {
> -                CertFreeCertificateContext(cd->cert_context);
> -            }
> -            free(cd);
> -        }
> +        CAPI_DATA_free(cd);
>      }
>      return 0;
>  }
> 

Other than that, looks good and works as expected.  So:

Acked-by: Steffan Karger <steffan.karger@...1435...>

-Steffan

