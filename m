References: <cover.1487600539.git.logout@...260...>
	<2faff7647151d7fe362c1c5db9f97e520444d09b.1487600539.git.logout@...260...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5a07fe90-5430-2c95-db18-f7a11af3fe56@...1856...>
Date: Thu, 2 Mar 2017 21:44:17 +0100
MIME-Version: 1.0
In-Reply-To: <2faff7647151d7fe362c1c5db9f97e520444d09b.1487600539.git.logout@...260...>
Subject: Re: [Openvpn-devel] [RFC PATCH v2 15/15] OpenSSL: use
 EVP_CipherInit_ex() instead of EVP_CipherInit()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 20-02-17 15:32, Emmanuel Deloget wrote:
> The behavior of EVP_CipherInit() changed in OpenSSL 1.1 -- instead
> of clearing the context when the cipher parameter was !NULL, it now
> clears the context unconditionnaly. As a result, subsequent calls
> to the function with additional information now fails.
> 
> The bulk work is done by EVP_CipherInit_ex() which has been part of the
> OpenSSL interface since the dawn of time (0.9.8 already has it). Thus,
> the change allows us to get the old behavior back instead of relying
> on dirty tricks.
> 
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  src/openvpn/crypto_openssl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 23de175..2bca88b 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -683,7 +683,7 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, uint8_t *key, int key_len,
>          crypto_msg(M_FATAL, "EVP set key size");
>      }
>  #endif
> -    if (!EVP_CipherInit(ctx, NULL, key, NULL, enc))
> +    if (!EVP_CipherInit_ex(ctx, NULL, NULL, key, NULL, enc))
>      {
>          crypto_msg(M_FATAL, "EVP cipher init #2");
>      }
> @@ -736,7 +736,7 @@ cipher_ctx_get_cipher_kt(const cipher_ctx_t *ctx)
>  int
>  cipher_ctx_reset(EVP_CIPHER_CTX *ctx, uint8_t *iv_buf)
>  {
> -    return EVP_CipherInit(ctx, NULL, NULL, iv_buf, -1);
> +    return EVP_CipherInit_ex(ctx, NULL, NULL, NULL, iv_buf, -1);
>  }
>  
>  int
> 

ACK

-Steffan

