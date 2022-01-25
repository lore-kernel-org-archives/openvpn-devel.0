Message-ID: <32d77e73-e300-7046-db2b-8bca196f3995@...2181...>
Date: Tue, 25 Jan 2022 17:47:11 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220120162645.13881-1-selva.nair@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220120162645.13881-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix a potential memory leak in
 tls_ctx_use_management_external_key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Hi,

On 20/01/2022 17:26, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> As pointed out by Gert Doering <gert@...1296...>

This can be "gitified" as:

Reported-by: Gert Doering <gert@...1296...>

> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> To be applied after 06/18 of xkey patchset
> 
>   src/openvpn/ssl_openssl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index b48845eb..3f8c3091 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1493,6 +1493,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
>       if (!privkey
>           || !SSL_CTX_use_PrivateKey(ctx->ctx, privkey))
>       {
> +        EVP_PKEY_free(privkey);
>           goto cleanup;
>       }
>       EVP_PKEY_free(privkey);

This is non-crucial because we goto cleanup and then do a M_FATAL.

Nonetheless, we should strive to have cleaner error paths that take care 
of releasing allocated resources when possible.

Acked-by: Antonio Quartulli <a@...2181...>

-- 
Antonio Quartulli

