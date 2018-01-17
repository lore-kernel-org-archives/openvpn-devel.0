References: <1515378076-5774-1-git-send-email-selva.nair@...277...>
 <1515378076-5774-3-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <d35efc0b-43f2-ff57-3ba3-88531813b35c@...1435...>
Date: Wed, 17 Jan 2018 15:20:10 +0100
MIME-Version: 1.0
In-Reply-To: <1515378076-5774-3-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/2] TLS v1.2 support for cryptoapicert
 -- RSA only
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

Some preliminary comments:

On 08-01-18 03:21, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> - If an NCRYPT handle for the private key can be obtained, use
>   NCryptSignHash from the Cryptography NG API to sign the hash.
> 
>   This should work for all keys in the Windows certifiate stores
>   but may fail for keys in a legacy token, for example. In such
>   cases, we disable TLS v1.2 and fall back to the current
>   behaviour. A warning is logged unless TLS version is already
>   restricted to <= 1.1
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> Tested on Windows 10 with openssl 1.0.1r and 1.1.0g
> with certificate/key in Windows user store
> 
>  src/openvpn/Makefile.am |  2 +-
>  src/openvpn/cryptoapi.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++---
>  src/openvpn/options.c   | 18 -----------
>  3 files changed, 83 insertions(+), 23 deletions(-)
> 
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index fcc22d6..1a2f42e 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -132,5 +132,5 @@ openvpn_LDADD = \
>  	$(OPTIONAL_DL_LIBS)
>  if WIN32
>  openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h
> -openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4
> +openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt
>  endif
> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index 7052e4e..cd3f023 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -42,6 +42,7 @@
>  #include <openssl/err.h>
>  #include <windows.h>
>  #include <wincrypt.h>
> +#include <ncrypt.h>
>  #include <stdio.h>
>  #include <ctype.h>
>  #include <assert.h>
> @@ -68,6 +69,14 @@
>  #define CERT_STORE_OPEN_EXISTING_FLAG 0x00004000
>  #endif
>  
>  /* Size of an SSL signature: MD5+SHA1 */
>  #define SSL_SIG_LENGTH  36
>  
> @@ -83,6 +92,7 @@
>  #define CRYPTOAPI_F_CRYPT_SIGN_HASH                         106
>  #define CRYPTOAPI_F_LOAD_LIBRARY                            107
>  #define CRYPTOAPI_F_GET_PROC_ADDRESS                        108
> +#define CRYPTOAPI_F_NCRYPT_SIGN_HASH                        109
>  
>  static ERR_STRING_DATA CRYPTOAPI_str_functs[] = {
>      { ERR_PACK(ERR_LIB_CRYPTOAPI, 0, 0),                                    "microsoft cryptoapi"},
> @@ -95,12 +105,13 @@ static ERR_STRING_DATA CRYPTOAPI_str_functs[] = {
>      { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SIGN_HASH, 0),                          "CryptSignHash" },
>      { ERR_PACK(0, CRYPTOAPI_F_LOAD_LIBRARY, 0),                             "LoadLibrary" },
>      { ERR_PACK(0, CRYPTOAPI_F_GET_PROC_ADDRESS, 0),                         "GetProcAddress" },
> +    { ERR_PACK(0, CRYPTOAPI_F_NCRYPT_SIGN_HASH, 0),                         "NCryptSignHash" },
>      { 0, NULL }
>  };
>  
>  typedef struct _CAPI_DATA {
>      const CERT_CONTEXT *cert_context;
> -    HCRYPTPROV crypt_prov;
> +    HCRYPTPROV_OR_NCRYPT_KEY_HANDLE crypt_prov;
>      DWORD key_spec;
>      BOOL free_crypt_prov;
>  } CAPI_DATA;
> @@ -210,6 +221,41 @@ rsa_pub_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, in
>      return 0;
>  }
>  
> +/**
> + * Sign the hash in 'from' using NCryptSignHash(). This requires an NCRYPT
> + * key handle in cd->crypt_prov. On return the signature is in 'to'. Returns
> + * the length of the signature or 0 on error.
> + * For now we support only RSA and the padding is assumed to be PKCS1 v1.5
> + */
> +static int
> +priv_enc_CNG(const CAPI_DATA *cd, const unsigned char *from, int flen,
> +              unsigned char *to, int tlen, int padding)
> +{
> +    NCRYPT_KEY_HANDLE hkey = cd->crypt_prov;
> +    DWORD len;
> +    ASSERT(cd->key_spec == CERT_NCRYPT_KEY_SPEC);
> +
> +    msg(M_INFO, "Signing hash using CNG: data size = %d", flen);

M_INFO is probably a bit verbose here.

> +    /* The hash OID is already in 'from'.  So set the hash algorithm
> +     * in the padding info struct to NULL.
> +     */
> +    BCRYPT_PKCS1_PADDING_INFO padinfo = {NULL};
> +    DWORD status;
> +
> +    status = NCryptSignHash(hkey, padding? &padinfo : NULL, (BYTE*) from, flen,
> +                            to, tlen, &len, padding? BCRYPT_PAD_PKCS1 : 0);
> +    if (status != ERROR_SUCCESS)
> +    {
> +        SetLastError(status);
> +        CRYPTOAPIerr(CRYPTOAPI_F_NCRYPT_SIGN_HASH);
> +        len = 0;
> +    }
> +
> +    /* Unlike CAPI, CNG signature is in big endian order. No reversing needed. */
> +    return len;
> +}
> +
>  /* sign arbitrary data */
>  static int
>  rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
> @@ -230,6 +276,11 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
>          RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
>          return 0;
>      }
> +    if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
> +    {
> +        return priv_enc_CNG(cd, from, flen, to, RSA_size(rsa), padding);
> +    }
> +
>      /* Unfortunately, there is no "CryptSign()" function in CryptoAPI, that would
>       * be way to straightforward for M$, I guess... So we have to do it this
>       * tricky way instead, by creating a "Hash", and load the already-made hash
> @@ -322,7 +373,14 @@ finish(RSA *rsa)
>      }
>      if (cd->crypt_prov && cd->free_crypt_prov)
>      {
> -        CryptReleaseContext(cd->crypt_prov, 0);
> +        if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
> +        {
> +            NCryptFreeObject(cd->crypt_prov);
> +        }
> +        else
> +        {
> +            CryptReleaseContext(cd->crypt_prov, 0);
> +        }
>      }
>      if (cd->cert_context)
>      {
> @@ -458,7 +516,9 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
>      }
>  
>      /* set up stuff to use the private key */
> -    if (!CryptAcquireCertificatePrivateKey(cd->cert_context, CRYPT_ACQUIRE_COMPARE_KEY_FLAG,
> +    /* We prefer to get an NCRYPT key handle so that TLS1.2 can be supported */
> +    DWORD flags = CRYPT_ACQUIRE_COMPARE_KEY_FLAG|CRYPT_ACQUIRE_PREFER_NCRYPT_KEY_FLAG;
> +    if (!CryptAcquireCertificatePrivateKey(cd->cert_context, flags,
>                                             NULL, &cd->crypt_prov, &cd->key_spec, &cd->free_crypt_prov))

Some rewrapping of the arguments to no longer exceed 80 chars would be
nice if you touch this anyway.

>      {
>          /* if we don't have a smart card reader here, and we try to access a
> @@ -470,6 +530,17 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
>      /* here we don't need to do CryptGetUserKey() or anything; all necessary key
>       * info is in cd->cert_context, and then, in cd->crypt_prov.  */
>  
> +    /* If we do not have an NCRYPT key handle disable TLS v1.2 */
> +    if (cd->key_spec != CERT_NCRYPT_KEY_SPEC)
> +    {
> +        if (!(SSL_CTX_get_options(ssl_ctx) & SSL_OP_NO_TLSv1_2))
> +        {

This no longer works for OpenSSL 1.1, we'll need the patch from
https://patchwork.openvpn.net/patch/160/ (awaiting review), and then use
the SSL_CTX_{get,set}_max_proto_version functions instead.

> +            msg(M_WARN, "WARNING: cryptapicert: only legacy private key handle is available."
> +                        "Disabling TLS v1.2");
> +            SSL_CTX_set_options(ssl_ctx, SSL_OP_NO_TLSv1_2);
> +        }
> +    }
> +
>      my_rsa_method = RSA_meth_new("Microsoft Cryptography API RSA Method",
>                                    RSA_METHOD_FLAG_NO_CHECK);
>      check_malloc_return(my_rsa_method);
> @@ -551,7 +622,14 @@ err:
>          {
>              if (cd->free_crypt_prov && cd->crypt_prov)
>              {
> -                CryptReleaseContext(cd->crypt_prov, 0);
> +                if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
> +                {
> +                    NCryptFreeObject(cd->crypt_prov);
> +                }
> +                else
> +                {
> +                    CryptReleaseContext(cd->crypt_prov, 0);
> +                }
>              }
>              if (cd->cert_context)
>              {
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 7be5f38..e4fbade 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3018,24 +3018,6 @@ options_postprocess_mutate(struct options *o)
>      }
>  #endif
>  
> -#ifdef ENABLE_CRYPTOAPI
> -    if (o->cryptoapi_cert)
> -    {
> -        const int tls_version_max =
> -            (o->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
> -            &SSLF_TLS_VERSION_MAX_MASK;
> -
> -        if (tls_version_max == TLS_VER_UNSPEC || tls_version_max > TLS_VER_1_1)
> -        {
> -            msg(M_WARN, "Warning: cryptapicert used, setting maximum TLS "
> -                "version to 1.1.");
> -            o->ssl_flags &= ~(SSLF_TLS_VERSION_MAX_MASK
> -                              <<SSLF_TLS_VERSION_MAX_SHIFT);
> -            o->ssl_flags |= (TLS_VER_1_1 << SSLF_TLS_VERSION_MAX_SHIFT);
> -        }
> -    }
> -#endif /* ENABLE_CRYPTOAPI */
> -
>  #if P2MP
>      /*
>       * Save certain parms before modifying options via --pull
> 

Otherwise this looks good on first sight.  I'll try to do some building
and testing later.

-Steffan

