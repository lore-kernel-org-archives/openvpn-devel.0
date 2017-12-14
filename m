References: <20171112163636.17434-1-steffan@...1856...>
 <201711192037.vAJKbuHH080370@...2054...>
 <20171119213837.GA80839@...1296...> <8760a6kjwc.fsf@...2274...>
 <87vai5kj4z.fsf@...2274...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <551aeb2a-1ea1-9c3b-06dd-ead9fc809340@...1856...>
Date: Thu, 14 Dec 2017 09:21:26 +0100
MIME-Version: 1.0
In-Reply-To: <87vai5kj4z.fsf@...2274...>
Content-Language: en-GB
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

On 19-11-17 23:18, Jeremie Courreges-Anglas wrote:
> Here's another diff to detect SSL_CTX_get0_certificate().
> 
> Tested against LibreSSL only; adding
> 
>   #define HAVE_SSL_CTX_GET0_CERTIFICATE 1
> 
> to config.h lets ssl_openssl.c build (with a warning), the link fails as
> expected.
>
> From 1abd6089a45260e4ce7adfae3fa619f9055edcaf Mon Sep 17 00:00:00 2001
> From: Jeremie Courreges-Anglas <jca@...2272...>
> Date: Sun, 19 Nov 2017 23:12:30 +0100
> Subject: [PATCH] Detect if SSL_CTX_get0_certificate is available
> 
> Don't rely on #ifdef OPENSSL/LIBRESSL_VERSION_NUMBER checks.
> 
> Signed-off-by: Jeremie Courreges-Anglas <jca@...2272...>
> ---
>  configure.ac              | 1 +
>  src/openvpn/ssl_openssl.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index acfddb22..ac6e7a76 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -925,6 +925,7 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
>  			EVP_MD_CTX_new \
>  			EVP_MD_CTX_free \
>  			EVP_MD_CTX_reset \
> +			SSL_CTX_get0_certificate \
>  			SSL_CTX_get_default_passwd_cb \
>  			SSL_CTX_get_default_passwd_cb_userdata \
>  			SSL_CTX_set_security_level \
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index b782946e..3df70166 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -425,7 +425,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
>  
>      ASSERT(ctx);
>  
> -#if OPENSSL_VERSION_NUMBER >= 0x10002000L && !defined(LIBRESSL_VERSION_NUMBER)
> +#ifdef HAVE_SSL_CTX_GET0_CERTIFICATE
>      /* OpenSSL 1.0.2 and up */
>      cert = SSL_CTX_get0_certificate(ctx->ctx);
>  #else
> @@ -460,7 +460,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
>      }
>  
>  cleanup:
> -#if OPENSSL_VERSION_NUMBER < 0x10002000L || defined(LIBRESSL_VERSION_NUMBER)
> +#ifndef HAVE_SSL_CTX_GET0_CERTIFICATE
>      SSL_free(ssl);
>  #endif
>      return;
> -- 
> 2.15.0

NAK.

Looking at this patch again I realize I have misunderstood the
intentions when first looking at it.  I thought LibreSSL *did* have an
SSL_CTX_get0_certificate() and this patch would make us use it (instead
of the workaround in the #else).  But this is just about replacing the
version check with a configure check.  I oppose that change because it
hides information I want to have:  "what code can be purged when we drop
support for openssl 1.0 and libressl?".

-Steffan

