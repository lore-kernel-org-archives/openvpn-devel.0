References: <1452433475-16779-1-git-send-email-niels_ole@...2112...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4a50bbce-f8a1-f295-4c93-8817be8612c8@...1227...>
Date: Sun, 10 Jan 2016 15:15:49 +0100
MIME-Version: 1.0
In-Reply-To: <1452433475-16779-1-git-send-email-niels_ole@...2112...>
Subject: Re: [Openvpn-devel] [PATCH] Fix build with libressl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Niels Ole Salscheider <niels_ole@...2112...>, openvpn-devel@lists.sourceforge.net

On 10.01.2016 14:44, Niels Ole Salscheider wrote:
> Signed-off-by: Niels Ole Salscheider <niels_ole@...2112...>
> ---
>  src/openvpn/ssl_openssl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index d2f40e7..e390f4d 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -358,7 +358,7 @@ tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
>  
>    ASSERT (ctx);
>  
> -#if OPENSSL_VERSION_NUMBER >= 0x10002000L
> +#if OPENSSL_VERSION_NUMBER >= 0x10002000L && !defined(LIBRESSL_VERSION_NUMBER)
>    /* OpenSSL 1.0.2 and up */
>    cert = SSL_CTX_get0_certificate (ctx->ctx);
>  #else
> @@ -393,7 +393,7 @@ tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
>      }
>  
>  cleanup:
> -#if OPENSSL_VERSION_NUMBER < 0x10002000L
> +#if OPENSSL_VERSION_NUMBER < 0x10002000L || defined(LIBRESSL_VERSION_NUMBER)
>    SSL_free (ssl);
>  #endif
>    return;

LibreSSL is like: We are OpenSSL 1.0.2 but have a different API?! That
sounds like a LibreSSL bug.


Arne


