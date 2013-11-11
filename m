MIME-Version: 1.0
In-Reply-To: <1384208842-25700-1-git-send-email-alon.barlev@...277...>
References: <1384208842-25700-1-git-send-email-alon.barlev@...277...>
Date: Tue, 12 Nov 2013 00:30:01 +0200
Message-ID: <CAOazyz1kEYtJ8gkjGZjrB67gjKGXGzFLoegrbZc-KcJnv49LvA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] ssl: enable basic ecdsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>
Cc: "Sanaullah ." <sanaullah82@...277...>

Hi,

I re-send this patch as it proved to be somewhat helpful.

It will be great to reach to a level it can be actually used.

I guess configuration option should be added to make it optional and
remove the hard coded curve?

Regards,
Alon Bar-Lev.

On Tue, Nov 12, 2013 at 12:27 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> From: Jan Just Keijser <janjust@...1147...>
>
> Discussion: https://forums.openvpn.net/topic8404-30.html
> Tested-By: Sanaullah <sanaullah82@...277...>
> ---
>  src/openvpn/ssl_openssl.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index f64177a..665bb5c 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -309,6 +309,7 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
>  {
>    DH *dh;
>    BIO *bio;
> +  EC_KEY *ecdh=NULL;
>
>    ASSERT(NULL != ctx);
>
> @@ -336,6 +337,16 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
>         8 * DH_size (dh));
>
>    DH_free (dh);
> +
> +  ecdh = EC_KEY_new_by_curve_name(NID_secp224r1);
> +
> +  if (ecdh == NULL)
> +      msg (M_SSLERR, "Unable to create curve (NID_secp224r1)");
> +
> +  if (!SSL_CTX_set_tmp_ecdh(ctx->ctx, ecdh))
> +      msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh");
> +
> +  EC_KEY_free(ecdh);
>  }
>
>  int
> --
> 1.8.3.2
>

