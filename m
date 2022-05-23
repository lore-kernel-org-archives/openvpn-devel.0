Message-ID: <45f8ad99-c113-570e-4f82-4888fe2cc5ad@...2181...>
Date: Mon, 23 May 2022 13:35:54 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220523103546.3425388-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220523103546.3425388-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] [OpenVPN 2.5] Translate OpenSSL 3.0
 digest names to OpenSSL 1.1 digest names
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 23/05/2022 12:35, Arne Schwabe wrote:
> Since we used the OpenSSL <=1.1 names as part of our OCC message, they
> are now unfortunately part of our wire protocol.
> 
> OpenSSL 3.0 will still accept the "old" names so we do not need to use
> this translation table for lookup only for returning the name with

Same as for the patch for master:

something is missing here ^

...table for lookup", but" only for returning...

Same change should be applied to the in-code comment.

> md_kt_name
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   src/openvpn/crypto_openssl.c | 39 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 74685b386..8c28d2b5e 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -379,7 +379,7 @@ show_available_ciphers(void)
>   void
>   print_digest(EVP_MD *digest, void *unused)
>   {
> -    printf("%s %d bit digest size\n", EVP_MD_name(digest),
> +    printf("%s %d bit digest size\n", md_kt_name(digest),
>              EVP_MD_size(digest) * 8);
>   }
>   
> @@ -982,6 +982,28 @@ md_kt_get(const char *digest)
>       return md;
>   }
>   
> +/* Since we used the OpenSSL <=1.1 names as part of our OCC message, they
> + * are now unfortunately part of our wire protocol.
> + *
> + * OpenSSL 3.0 will still accept the "old" names so we do not need to use
> + * this translation table for lookup only for returning the name with
> + * md_kt_name */
> +const cipher_name_pair digest_name_translation_table[] = {
> +    { "BLAKE2s256", "BLAKE2S-256"},
> +    { "BLAKE2b512", "BLAKE2B-512"},
> +    { "RIPEMD160", "RIPEMD-160" },
> +    { "SHA224", "SHA2-224"},
> +    { "SHA256", "SHA2-256"},
> +    { "SHA384", "SHA2-384"},
> +    { "SHA512", "SHA2-512"},
> +    { "SHA512-224", "SHA2-512/224"},
> +    { "SHA512-256", "SHA2-512/256"},
> +    { "SHAKE128", "SHAKE-128"},
> +    { "SHAKE256", "SHAKE-256"},
> +};
> +const size_t digest_name_translation_table_count =
> +    sizeof(digest_name_translation_table) / sizeof(*digest_name_translation_table);
> +
>   const char *
>   md_kt_name(const EVP_MD *kt)
>   {
> @@ -989,7 +1011,20 @@ md_kt_name(const EVP_MD *kt)
>       {
>           return "[null-digest]";
>       }
> -    return EVP_MD_name(kt);
> +
> +    const char *name = EVP_MD_name(kt);
> +
> +    /* Search for a digest name translation */
> +    for (size_t i = 0; i < digest_name_translation_table_count; i++)
> +    {
> +        const cipher_name_pair *pair = &digest_name_translation_table[i];
> +        if (!strcmp(name, pair->lib_name))
> +        {
> +            name = pair->openvpn_name;
> +        }
> +    }
> +
> +    return name;
>   }
>   
>   unsigned char

-- 
Antonio Quartulli

