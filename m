References: <20200328040858.16505-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4f3b6d5e-5354-558d-2e58-c8f588fbd18f@...2181...>
Date: Wed, 15 Apr 2020 11:50:57 +0200
MIME-Version: 1.0
In-Reply-To: <20200328040858.16505-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix OpenSSL 1.1.1 not using auto
 ecliptic curve selection
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 28/03/2020 05:08, Arne Schwabe wrote:
> Commit 8a01147ff attempted to avoid calling the deprecated/noop
> operation SSL_CTX_set_ecdh_auto by surrounding it with #ifdef.
> Unfortunately, that change also made the return; that would exit
> the function no longer being compiled when using OpenSSL 1.1.0+.
> As consequence OpenVPN with OpenSSL 1.1.0+ would always set
> secp384r1 as ecdh curve unless otherwise specified by ecdh
> 
> This patch restores the correct/previous behaviour.
> ---
>  src/openvpn/ssl_openssl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 3f0031ff..4b5ca214 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -678,8 +678,11 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
>          /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter
>           * loading */
>          SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
> -        return;
> +
> +        /* OpenSSL 1.1.0 and newer have always ecdh auto loading enabled,
> +         * so do nothing */
>  #endif
> +        return;

my eyes want to fall when seeing this ifdef jungle...but that's another
topic.

The change makes sense, because for ossl >= 1.1.0 we only want to omit
the call to SSL_CTX_set_ecdh_auto() [no-op since 1.1.0], but the
codeflow should remain the same.

>  #else
>          /* For older OpenSSL we have to extract the curve from key on our own */
>          EC_KEY *eckey = NULL;
> 


Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

