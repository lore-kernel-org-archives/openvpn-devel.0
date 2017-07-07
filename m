References: <20170707102238.8781-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <ee98edb4-79df-26e0-ed2b-9b04eefacb70@...1856...>
Date: Fri, 7 Jul 2017 23:01:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170707102238.8781-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt: avoid warnings when
 --disable-crypto is used
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 07-07-17 12:22, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
> 
> Avoid including the content of tls_crypt.h when --disable-crypto
> is used, as it will trigger some warnings due to missing
> structures declarations.
> 
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
> 
> - also checked via travis-ci.org
> 
>  src/openvpn/tls_crypt.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
> index e8080df9..4071ac94 100644
> --- a/src/openvpn/tls_crypt.h
> +++ b/src/openvpn/tls_crypt.h
> @@ -74,6 +74,8 @@
>  #ifndef TLSCRYPT_H
>  #define TLSCRYPT_H
>  
> +#ifdef ENABLE_CRYPTO
> +
>  #include "buffer.h"
>  #include "crypto.h"
>  #include "session_id.h"
> @@ -140,4 +142,6 @@ bool tls_crypt_unwrap(const struct buffer *src, struct buffer *dst,
>  
>  /** @} */
>  
> +#endif /* ENABLE_CRYPTO */
> +
>  #endif /* TLSCRYPT_H */
> 

ACK

(This is quite similar to the fix I have in my tls-crypt-v2 tree:
https://github.com/syzzer/openvpn/commit/ba30a88e, so can't agree more ;-) )

-Steffan

