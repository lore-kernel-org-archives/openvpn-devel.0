References: <1564173557-11776-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <cb0b914a-15be-7bbe-3d5c-0a3494875863@...1856...>
Date: Sun, 28 Jul 2019 17:44:06 +0200
MIME-Version: 1.0
In-Reply-To: <1564173557-11776-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Correct the return value of cryptoapi
 RSA signature callbacks
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



On 26-07-19 22:39, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> Fixes the wrong check on siglen instead of *siglen for
> signing failures.
> 
> Bug reported by: lilulo <lilulo@...277...>
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> 
> 2.4 will need a separate patch
> 
>  src/openvpn/cryptoapi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index 0c11712e..2f2eee77 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -499,7 +499,7 @@ rsa_sign_CNG(int type, const unsigned char *m, unsigned int m_len,
>      *siglen = priv_enc_CNG(cd, alg, m, (int)m_len, sig, RSA_size(rsa),
>                             cng_padding_type(padding), 0);
>  
> -    return (siglen == 0) ? 0 : 1;
> +    return (*siglen == 0) ? 0 : 1;
>  }
>  
>  /* decrypt */
> @@ -973,7 +973,7 @@ pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
>      *siglen = priv_enc_CNG(cd, alg, tbs, (int)tbslen, sig, *siglen,
>                             cng_padding_type(padding), (DWORD)saltlen);
>  
> -    return (siglen == 0) ? 0 : 1;
> +    return (*siglen == 0) ? 0 : 1;
>  }
>  
>  #endif /* OPENSSL_VERSION >= 1.1.0 */
> 

Acked-by: Steffan Karger <Steffan@...1856...>

