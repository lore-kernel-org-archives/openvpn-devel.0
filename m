References: <1564197141-30513-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d1e0aa17-129e-3c48-4858-e4d8c4e2051c@...1856...>
Date: Sun, 28 Jul 2019 17:44:21 +0200
MIME-Version: 1.0
In-Reply-To: <1564197141-30513-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH for 2.4] Correct the return value of
 cryptoapi RSA signature callbacks
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



On 27-07-19 05:12, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> Fixes the wrong check on siglen instead of *siglen for
> signing failures.
> 
> Bug reported by: lilulo <lilulo@...277...>
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/cryptoapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index 720fce09..35a9ebc4 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -393,7 +393,7 @@ rsa_sign_CNG(int type, const unsigned char *m, unsigned int m_len,
>      }
>  
>      *siglen = priv_enc_CNG(cd, alg, m, (int)m_len, sig, RSA_size(rsa), padding);
> -    return (siglen == 0) ? 0 : 1;
> +    return (*siglen == 0) ? 0 : 1;
>  }
>  
>  /* decrypt */
> 

Acked-by: Steffan Karger <Steffan@...1856...>

