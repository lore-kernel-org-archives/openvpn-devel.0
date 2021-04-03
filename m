References: <E1lSJph-0004I0-FL@...2479...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8b081dd5-2c1d-c71b-8af0-d4c886e4260e@...1227...>
Date: Sat, 3 Apr 2021 14:11:43 +0200
MIME-Version: 1.0
In-Reply-To: <E1lSJph-0004I0-FL@...2479...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Change CTR DRBG update function call to
 new mbedtls 2.16.0 API
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
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

Am 02.04.21 um 15:26 schrieb Max Fillinger:
> From: Uipko Berghuis <uipko.berghuis@...1435...>
> 
> In mbedtls 2.16.0 mbedtls_ctr_drbg_update() changed to
> mbedtls_ctr_drbg_update_ret(). Change the function name and handle
> the new return value error code.
> ---
>  src/openvpn/ssl_mbedtls.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 5d7af351..56e9f045 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -950,7 +950,10 @@ tls_ctx_personalise_random(struct tls_root_ctx *ctx)
>  
>          if (0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
>          {
> -            mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32);
> +            if (!mbed_ok(mbedtls_ctr_drbg_update_ret(cd_ctx, sha256_hash, 32)))
> +            {
> +                msg(M_WARN, "WARNING: failed to personalise random, could not update CTR_DRBG");
> +            }
>              memcpy(old_sha256_hash, sha256_hash, sizeof(old_sha256_hash));
>          }
>      }
> 

This change will break compilation with anything that is < 2.16.0.

Arne

