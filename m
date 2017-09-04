References: <01ea7971-ae7a-573b-8845-30b04b0b8112@...1856...>
 <20170904081012.1975-1-coroner@...2290...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <2d289af9-669c-60f5-2e52-b3a42fa5da70@...1435...>
Date: Mon, 4 Sep 2017 14:52:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170904081012.1975-1-coroner@...2290...>
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
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On 04-09-17 10:10, coroner@...2290... wrote:
> From: Szil=C3=A1rd Pfeiffer <coroner@...2290...>
>=20
> * safe bet to say that server admins are better at updating their configs
>   than client users are and if client do want to restrict their ciphers,
>   they should simply evict the ciphers they don't want from their cipher
>   suite
> * mbed TLS and OpenSSL behave more similar with the
>   SSL_OP_CIPHER_SERVER_PREFERENCE flag
> ---
>  src/openvpn/ssl_openssl.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 597c62d8..92a662b5 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -252,6 +252,9 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigne=
d int ssl_flags)
>          {
>              sslopt |=3D SSL_OP_NO_TLSv1_2;
>          }
> +#endif
> +#ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
> +        sslopt |=3D SSL_OP_CIPHER_SERVER_PREFERENCE;
>  #endif
>          sslopt |=3D SSL_OP_NO_COMPRESSION;
>          SSL_CTX_set_options(ctx->ctx, sslopt);
>=20

ACK

-Steffan

