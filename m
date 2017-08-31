References: <3069bcad-548c-4f90-91ce-b8950095bfd9@...2080...>
 <20170821210933.11460-1-coroner@...2290...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <01ea7971-ae7a-573b-8845-30b04b0b8112@...1856...>
Date: Thu, 31 Aug 2017 23:02:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170821210933.11460-1-coroner@...2290...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] OpenSSL: Always set
 SSL_OP_CIPHER_SERVER_PREFERENCE flag
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 21-08-17 23:09, Szilárd Pfeiffer wrote:
> * safe bet to say that server admins are better at updating their configs
>   than client users are and if client do want to restrict their ciphers,
>   they should simply evict the ciphers they don't want from their cipher
>   suite
> * mbed TLS and OpenSSL behave more similar with the
>   SSL_OP_CIPHER_SERVER_PREFERENCE flag
> ---
>  src/openvpn/ssl_openssl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 597c62d8..bb8098cc 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -252,6 +252,9 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
>          {
>              sslopt |= SSL_OP_NO_TLSv1_2;
>          }
> +#endif
> +#ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
> +       sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
>  #endif
>          sslopt |= SSL_OP_NO_COMPRESSION;
>          SSL_CTX_set_options(ctx->ctx, sslopt);
> 

The indent is one space short, but that can be fixed when applying the
patch.

Other that that, this looks good.  ACK.

-Steffan

