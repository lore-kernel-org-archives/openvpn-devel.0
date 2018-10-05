References: <1524752664-27946-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <abfcfcb4-60dd-9ba2-0ffc-c28c0cc1fd4c@...1856...>
Date: Fri, 5 Oct 2018 12:16:06 +0200
MIME-Version: 1.0
In-Reply-To: <1524752664-27946-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Pass the hash without the DigestInfo
 header to NCryptSignHash()
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

On 26-04-18 16:24, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> In case of TLS 1.2 signatures, the callback rsa_priv_enc() gets
> the hash with the DigestInfo prepended. Signing this using
> NCryptSignHash() with hash algorithm id set to NULL works in most cases.
> But when using some hardware tokens, the data gets interpreted as the pre
> TLS 1.2 MD5+SHA1 hash and is silently truncated to 36 bytes.
> Avoid this by passing the raw hash to NCryptSignHash() and let it
> add the DigestInfo.
> 
> To get the raw hash we set the RSA_sign() method in the rsa_method
> structure. This callback bypasses rsa_priv_enc() and gets called with
> the hash type and the hash.
> 
> Fixes Trac #1050
> ---
> 
> Tested by JJK and gizi as described in Trac #1050
> 
>  src/openvpn/cryptoapi.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 79 insertions(+), 5 deletions(-)
> 
> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index 89d253c..d765954 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -217,14 +217,16 @@ rsa_pub_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, in
>   * Sign the hash in 'from' using NCryptSignHash(). This requires an NCRYPT
>   * key handle in cd->crypt_prov. On return the signature is in 'to'. Returns
>   * the length of the signature or 0 on error.
> + * If the hash_algo is not NULL, PKCS #1 DigestInfo header gets added
> + * to 'from', else it is signed as is.
>   * For now we support only RSA and the padding is assumed to be PKCS1 v1.5
>   */
>  static int
> -priv_enc_CNG(const CAPI_DATA *cd, const unsigned char *from, int flen,
> -              unsigned char *to, int tlen, int padding)
> +priv_enc_CNG(const CAPI_DATA *cd, const wchar_t *hash_algo, const unsigned char *from,
> +             int flen, unsigned char *to, int tlen, int padding)
>  {
>      NCRYPT_KEY_HANDLE hkey = cd->crypt_prov;
> -    DWORD len;
> +    DWORD len = 0;
>      ASSERT(cd->key_spec == CERT_NCRYPT_KEY_SPEC);
>  
>      msg(D_LOW, "Signing hash using CNG: data size = %d", flen);
> @@ -232,7 +234,7 @@ priv_enc_CNG(const CAPI_DATA *cd, const unsigned char *from, int flen,
>      /* The hash OID is already in 'from'.  So set the hash algorithm
>       * in the padding info struct to NULL.
>       */
> -    BCRYPT_PKCS1_PADDING_INFO padinfo = {NULL};
> +    BCRYPT_PKCS1_PADDING_INFO padinfo = {hash_algo};
>      DWORD status;
>  
>      status = NCryptSignHash(hkey, padding? &padinfo : NULL, (BYTE*) from, flen,
> @@ -270,7 +272,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
>      }
>      if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
>      {
> -        return priv_enc_CNG(cd, from, flen, to, RSA_size(rsa), padding);
> +        return priv_enc_CNG(cd, NULL, from, flen, to, RSA_size(rsa), padding);
>      }
>  
>      /* Unfortunately, there is no "CryptSign()" function in CryptoAPI, that would
> @@ -334,6 +336,69 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
>      return len;
>  }
>  
> +/*
> + * Sign the hash in |m| and return the signature in |sig|.
> + * Returns 1 on success, 0 on error.
> + * NCryptSignHash() is used to sign and it is instructed to add the
> + * the PKCS #1 DigestInfo header to |m| unless the hash algorithm is
> + * the MD5/SHA1 combination used in TLS 1.1 and earlier versions.
> + */
> +static int
> +rsa_sign_CNG(int type, const unsigned char *m, unsigned int m_len,
> +              unsigned char *sig, unsigned int *siglen, const RSA *rsa)
> +{
> +    CAPI_DATA *cd = (CAPI_DATA *) RSA_meth_get0_app_data(RSA_get_method(rsa));
> +    const wchar_t *alg = NULL;
> +    int padding = RSA_PKCS1_PADDING;
> +
> +    *siglen = 0;
> +    if (cd == NULL)
> +    {
> +        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, ERR_R_PASSED_NULL_PARAMETER);
> +        return 0;
> +    }
> +
> +    switch (type)
> +    {
> +        case NID_md5:
> +            alg = BCRYPT_MD5_ALGORITHM;
> +            break;
> +
> +        case NID_sha1:
> +            alg = BCRYPT_SHA1_ALGORITHM;
> +            break;
> +
> +        case NID_sha256:
> +            alg = BCRYPT_SHA256_ALGORITHM;
> +            break;
> +
> +        case NID_sha384:
> +            alg = BCRYPT_SHA384_ALGORITHM;
> +            break;
> +
> +        case NID_sha512:
> +            alg = BCRYPT_SHA512_ALGORITHM;
> +            break;
> +
> +        case NID_md5_sha1:
> +            if (m_len != SSL_SIG_LENGTH)
> +            {
> +                RSAerr(RSA_F_RSA_SIGN, RSA_R_INVALID_MESSAGE_LENGTH);
> +                return 0;
> +            }
> +            /* No DigestInfo header is required -- set alg-name to NULL */
> +            alg = NULL;
> +            break;
> +        default:
> +            msg(M_WARN, "cryptoapicert: Unknown hash type NID=0x%x", type);
> +            RSAerr(RSA_F_RSA_SIGN, RSA_R_UNKNOWN_ALGORITHM_TYPE);
> +            return 0;
> +    }
> +
> +    *siglen = priv_enc_CNG(cd, alg, m, (int)m_len, sig, RSA_size(rsa), padding);
> +    return (siglen == 0) ? 0 : 1;
> +}
> +
>  /* decrypt */
>  static int
>  rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
> @@ -555,6 +620,15 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
>      RSA_meth_set_finish(my_rsa_method, finish);
>      RSA_meth_set0_app_data(my_rsa_method, cd);
>  
> +    /* For CNG, set the RSA_sign method which gets priority over priv_enc().
> +     * This method is called with the raw hash without the digestinfo
> +     * header and works better when using NCryptSignHash() with some tokens.
> +     */
> +    if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
> +    {
> +        RSA_meth_set_sign(my_rsa_method, rsa_sign_CNG);
> +    }
> +
>      rsa = RSA_new();
>      if (rsa == NULL)
>      {
> 

Change makes sense and code looks good.

Since this is already tested by Selva, JJK and gizi, I just did the
stare-at-code part of review.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

