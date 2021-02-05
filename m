References: <20210201174310.22153-1-arne@...1227...>
 <20210201174310.22153-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <957b05b8-c499-4df5-e27a-d40239f50dd9@...2181...>
Date: Fri, 5 Feb 2021 14:12:51 +0100
MIME-Version: 1.0
In-Reply-To: <20210201174310.22153-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 1/3] Check return values in
 md_ctx_init and hmac_ctx_init
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

On 01/02/2021 18:43, Arne Schwabe wrote:
> Without this OpenVPN will later segfault on a FIPS enabled system due
> to the algorithm available but not allowed.
> 
> Patch V2: Use (!func) instead (func != 1)
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/crypto_openssl.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index c60d4a54..e124a7b6 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -954,7 +954,10 @@ md_ctx_init(EVP_MD_CTX *ctx, const EVP_MD *kt)
>      ASSERT(NULL != ctx && NULL != kt);
>  
>      EVP_MD_CTX_init(ctx);
> -    EVP_DigestInit(ctx, kt);
> +    if (!EVP_DigestInit(ctx, kt))
> +    {
> +        crypto_msg(M_FATAL, "EVP_DigestInit failed");
> +    }
>  }
>  
>  void
> @@ -1011,7 +1014,10 @@ hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, int key_len,
>      ASSERT(NULL != kt && NULL != ctx);
>  
>      HMAC_CTX_reset(ctx);
> -    HMAC_Init_ex(ctx, key, key_len, kt, NULL);
> +    if  (!HMAC_Init_ex(ctx, key, key_len, kt, NULL))

too many spaces after "if"

> +    {
> +        crypto_msg(M_FATAL, "HMAC_Init_ex failed");
> +    }
>  
>      /* make sure we used a big enough key */
>      ASSERT(HMAC_size(ctx) <= key_len);
> @@ -1032,7 +1038,10 @@ hmac_ctx_size(const HMAC_CTX *ctx)
>  void
>  hmac_ctx_reset(HMAC_CTX *ctx)
>  {
> -    HMAC_Init_ex(ctx, NULL, 0, NULL, NULL);
> +    if(!HMAC_Init_ex(ctx, NULL, 0, NULL, NULL))

missing space after "if" (it probably went in the above block :D)

> +    {
> +        crypto_msg(M_FATAL, "HMAC_Init_ex failed");
> +    }
>  }
>  
>  void
> 

Rest looks good!

Acked-by: Antonio Quartulli <antonio@...515...>

Maybe the spaces can be fixed on the fly while merging.

Regards,


-- 
Antonio Quartulli

