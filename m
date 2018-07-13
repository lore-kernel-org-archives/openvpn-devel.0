References: <20180713081951.31174-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <61b9307a-5a3d-af2f-f115-873bedeafa24@...1227...>
Date: Fri, 13 Jul 2018 10:43:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180713081951.31174-1-gert@...1296...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] Print lzo_init() return code in case of
 errors
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 13.07.18 um 10:19 schrieb Gert Doering:
> This can help pinpointing what exactly went wrong in case of
> init failures (library version mismatch, memory issues, ...)
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/lzo.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
> index 8d9efea..e3be6ad 100644
> --- a/src/openvpn/lzo.c
> +++ b/src/openvpn/lzo.c
> @@ -103,9 +103,11 @@ lzo_compress_init(struct compress_context *compctx)
>      msg(D_INIT_MEDIUM, "LZO compression initializing");
>      ASSERT(!(compctx->flags & COMP_F_SWAP));
>      compctx->wu.lzo.wmem_size = LZO_WORKSPACE;
> -    if (lzo_init() != LZO_E_OK)
> +
> +    int lzo_status = lzo_init();
> +    if (lzo_status != LZO_E_OK)
>      {
> -        msg(M_FATAL, "Cannot initialize LZO compression library");
> +        msg(M_FATAL, "Cannot initialize LZO compression library (lzo_init() returns %d)", lzo_status);
>      }
>      compctx->wu.lzo.wmem = (lzo_voidp) lzo_malloc(compctx->wu.lzo.wmem_size);
>      check_malloc_return(compctx->wu.lzo.wmem);
> 

ACK.

(I have not compile tested it but it looks good enough to me that I skip
that on this one.

Ane

