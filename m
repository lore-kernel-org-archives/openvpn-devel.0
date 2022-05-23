Message-ID: <6bd5aa9e-483a-8e3f-b3d0-4654bf685f1d@...2181...>
Date: Mon, 23 May 2022 13:24:15 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220523103546.3425388-1-arne@...1227...>
 <20220523103546.3425388-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220523103546.3425388-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Translate OpenSSL 3.0 digest names to
 OpenSSL 1.1 digest names
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

something is missing here ^

...table for lookup", but" only for returning...

Same change should be applied to the in-code comment.


> md_kt_name
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Patch looks good and it's as small as it could be.

Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   src/openvpn/crypto_openssl.c | 36 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 3bedc03f7..02b5f3ce5 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -404,7 +404,7 @@ show_available_ciphers(void)
>   void
>   print_digest(EVP_MD *digest, void *unused)
>   {
> -    printf("%s %d bit digest size\n", EVP_MD_get0_name(digest),
> +    printf("%s %d bit digest size\n", md_kt_name(EVP_MD_get0_name(digest)),
>              EVP_MD_size(digest) * 8);
>   }
>   
> @@ -1055,6 +1055,29 @@ md_valid(const char *digest)
>       return valid;
>   }
>   
> +
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
>   md_kt_name(const char *mdname)
>   {
> @@ -1064,6 +1087,17 @@ md_kt_name(const char *mdname)
>       }
>       evp_md_type *kt = md_get(mdname);
>       const char *name = EVP_MD_get0_name(kt);
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
>       EVP_MD_free(kt);
>       return name;
>   }

-- 
Antonio Quartulli

