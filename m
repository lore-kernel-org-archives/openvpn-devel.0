References: <20171112163636.17434-1-steffan@...1856...>
 <201711192037.vAJKbuHH080370@...2054...>
 <20171119213837.GA80839@...1296...> <8760a6kjwc.fsf@...2274...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3ebf6e65-dc0b-7aaf-913b-01e4fa6ce2ef@...1856...>
Date: Wed, 22 Nov 2017 20:12:47 +0100
MIME-Version: 1.0
In-Reply-To: <8760a6kjwc.fsf@...2274...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add --tls-cert-profile
 option for mbedtls builds
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 19-11-17 23:01, Jeremie Courreges-Anglas wrote:
> Here's a diff, master builds and seems to run fine as a client on
> OpenBSD-current.
>
>
> From: Jeremie Courreges-Anglas <jca@...2272...>
> Date: Sun, 19 Nov 2017 22:57:56 +0100
> Subject: [PATCH] Fix build with LibreSSL
> 
> Detect the presence of SSL_CTX_set_security_level(), don't check
> OPENSSL_VERSION_NUMBER.
> 
> Signed-off-by: Jeremie Courreges-Anglas <jca@...2272...>
> ---
>  configure.ac              | 1 +
>  src/openvpn/ssl_openssl.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 7f2e34f2..acfddb22 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -927,6 +927,7 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
>  			EVP_MD_CTX_reset \
>  			SSL_CTX_get_default_passwd_cb \
>  			SSL_CTX_get_default_passwd_cb_userdata \
> +			SSL_CTX_set_security_level \
>  			X509_get0_pubkey \
>  			X509_STORE_get0_objects \
>  			X509_OBJECT_free \
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index de89cb13..b782946e 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -386,7 +386,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
>  void
>  tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
>  {
> -#if (OPENSSL_VERSION_NUMBER >= 0x10100000)
> +#ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL
>      /* OpenSSL does not have certificate profiles, but a complex set of
>       * callbacks that we could try to implement to achieve something similar.
>       * For now, use OpenSSL's security levels to achieve similar (but not equal)
> -- 
> 2.15.0

Patch looks good and clean enough to restore compatibilty with libressl.
 Tested that this doesn't break --tls-cert-profile with OpenSSL 1.1, and
doesn't break builds with OpenSSL 1.0.

Acked-by: Steffan Karger <steffan@...1856...>
Tested-by: Steffan Karger <steffan@...1856...>

-Steffan

