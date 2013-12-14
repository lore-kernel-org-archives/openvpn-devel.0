Message-ID: <52AC8FBD.2010201@...1856...>
Date: Sat, 14 Dec 2013 18:05:01 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1384209366-26170-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1384209366-26170-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] pkcs11: use generic evp key instead of
 rsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

ACK. Code looks good, compiles and passes my local pkcs11-test.

-Steffan

On 11-11-13 23:36, Alon Bar-Lev wrote:
> Enables DSA, ECDSA key usages with newer pkcs11-helper.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> Tested-By: Sanaullah <sanaullah82@...277...>
> ---
>  configure.ac                 |  2 +-
>  src/openvpn/pkcs11_openssl.c | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 5fad0af..0635149 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -725,7 +725,7 @@ esac
>  
>  PKG_CHECK_MODULES(
>  	[PKCS11_HELPER],
> -	[libpkcs11-helper-1 >= 1.02],
> +	[libpkcs11-helper-1 >= 1.11],
>  	[have_pkcs11_helper="yes"],
>  	[]
>  )
> diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
> index af843b7..87eb166 100644
> --- a/src/openvpn/pkcs11_openssl.c
> +++ b/src/openvpn/pkcs11_openssl.c
> @@ -49,7 +49,7 @@ pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
>    int ret = 1;
>  
>    X509 *x509 = NULL;
> -  RSA *rsa = NULL;
> +  EVP_PKEY *evp = NULL;
>    pkcs11h_openssl_session_t openssl_session = NULL;
>  
>    if ((openssl_session = pkcs11h_openssl_createSession (certificate)) == NULL)
> @@ -63,9 +63,9 @@ pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
>     */
>    certificate = NULL;
>  
> -  if ((rsa = pkcs11h_openssl_session_getRSA (openssl_session)) == NULL)
> +  if ((evp = pkcs11h_openssl_session_getEVP (openssl_session)) == NULL)
>      {
> -      msg (M_WARN, "PKCS#11: Unable get rsa object");
> +      msg (M_WARN, "PKCS#11: Unable get evp object");
>        goto cleanup;
>      }
>  
> @@ -75,7 +75,7 @@ pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
>        goto cleanup;
>      }
>  
> -  if (!SSL_CTX_use_RSAPrivateKey (ssl_ctx->ctx, rsa))
> +  if (!SSL_CTX_use_PrivateKey (ssl_ctx->ctx, evp))
>      {
>        msg (M_WARN, "PKCS#11: Cannot set private key for openssl");
>        goto cleanup;
> @@ -108,10 +108,10 @@ cleanup:
>        x509 = NULL;
>      }
>  
> -  if (rsa != NULL)
> +  if (evp != NULL)
>      {
> -      RSA_free (rsa);
> -      rsa = NULL;
> +      EVP_PKEY_free (evp);
> +      evp = NULL;
>      }
>  
>    if (openssl_session != NULL)
> 

