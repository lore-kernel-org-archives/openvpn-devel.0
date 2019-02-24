References: <20190223180241.18374-1-stefan.strogin@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4b330b38-6408-c148-d1a7-d025021503df@...1227...>
Date: Sun, 24 Feb 2019 02:28:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190223180241.18374-1-stefan.strogin@...277...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] Fix compilation with LibreSSL
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
To: Stefan Strogin <stefan.strogin@...277...>, openvpn-devel@lists.sourceforge.net

Am 23.02.19 um 19:02 schrieb Stefan Strogin:
> TLS 1.3 is not ready yet in LibreSSL.
> Also SSL_get1_supported_ciphers() has been just added into master (not yet
> released).

So I written already a rant about LibreSSL in this trac ticket
(https://community.openvpn.net/openvpn/ticket/1159), I will just copy
the relevant part here:

Biggest problem is that we have no one who really tests or works with us
doing LibreSSL. There have been multiple people saying that will work
with us and maintain LibreSSL but that has not materialised yet. And I
am getting quite fed up with way that LibreSSL does API compatiblity. It
claims to support OpenSSL 2.0.0 API when it clearly doesn't. This also
means that every new feature needs an or !LIBRE_SSL. I would be okay to
add FEATURE macros for libressl if they actually support new featues
like TLS1.3 etc but the current way is just a pain to maintain.
Also the patch should be send to the mailing list for proper review.

The || !defined(LIBRESSL_VERSION_NUMBER) means that I have no idea of
knowing when it is safe to remove the code. The idea of having the
OPENSSL_VERSION macros is to remove the ifdefs when we drop support for
old version but the unversioned LIBRESSL sounds like we would have to
keep ancient OpenSSL APIs forever in the code to support LibreSSL.

Your comment that TLS 1.3 and SSL_get1_supported_ciphers will become
available with some later LibreSSL, means that the current patch is
wrong here and we will need to patch it again.

In summary I really do not like this stuff. But I also accept that
having these defines in there makes same sense to have at least
unofficial support.  If you can send a follow up patch that at least
uses some feature or libressl version in the ifdef, we have an easier
time identifying those parts in the future to be obsolete.

Arne

> Signed-off-by: Stefan Strogin <stefan.strogin@...277...>
> ---
>  src/openvpn/ssl_openssl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index ddb78da7..fcaac080 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -465,7 +465,7 @@ tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
>          return;
>      }
>  
> -#if (OPENSSL_VERSION_NUMBER < 0x1010100fL)
> +#if (OPENSSL_VERSION_NUMBER < 0x1010100fL) || defined(LIBRESSL_VERSION_NUMBER)
>      crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher. "
>                 "Ignoring TLS 1.3 only tls-ciphersuites '%s' setting.",
>                 ciphers);
> @@ -1998,7 +1998,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
>          crypto_msg(M_FATAL, "Cannot create SSL_CTX object");
>      }
>  
> -#if (OPENSSL_VERSION_NUMBER >= 0x1010100fL)
> +#if (OPENSSL_VERSION_NUMBER >= 0x1010100fL && !defined(LIBRESSL_VERSION_NUMBER))
>      if (tls13)
>      {
>          SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
> @@ -2019,7 +2019,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
>          crypto_msg(M_FATAL, "Cannot create SSL object");
>      }
>  
> -#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)
> +#if (OPENSSL_VERSION_NUMBER < 0x1010000fL) || defined(LIBRESSL_VERSION_NUMBER)
>      STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
>  #else
>      STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);
> 


