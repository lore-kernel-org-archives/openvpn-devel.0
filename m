References: <20170707044704.7239-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <fd42bf13-3f4f-959c-71a2-2947acd067da@...1856...>
Date: Fri, 7 Jul 2017 23:19:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170707044704.7239-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] crypto: create function to initialize
 encrypt and decrypt key
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi,

On 07-07-17 06:47, Antonio Quartulli wrote:
> From: Steffan Karger <steffan@...1856...>
> 
> Instead of always initialize the encrypt and decrypt keys separately,
> implement an helper function init_key_ctx_bi() that takes care of
> both of them for us.
> 
> Reduces code duplication and improves readability.
> 
> Acked-by: Antonio Quartulli <antonio@...515...>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/crypto.c | 29 +++++++++++++++++++++--------
>  src/openvpn/crypto.h |  4 ++++
>  src/openvpn/ssl.c    | 17 ++---------------
>  3 files changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 78ca4197..4ea0af09 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -873,6 +873,26 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
>  }
>  
>  void
> +init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,
> +                int key_direction, const struct key_type *kt, const char *name)
> +{
> +    char log_prefix[128] = { 0 };
> +    struct key_direction_state kds;
> +
> +    key_direction_state_init(&kds, key_direction);
> +
> +    openvpn_snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
> +    init_key_ctx(&ctx->encrypt, &key2->keys[kds.out_key], kt,
> +                 OPENVPN_OP_ENCRYPT, log_prefix);
> +
> +    openvpn_snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
> +    init_key_ctx(&ctx->decrypt, &key2->keys[kds.in_key], kt,
> +                 OPENVPN_OP_DECRYPT, log_prefix);
> +
> +    ctx->initialized = true;
> +}
> +
> +void
>  free_key_ctx(struct key_ctx *ctx)
>  {
>      if (ctx->cipher)
> @@ -1161,7 +1181,6 @@ crypto_read_openvpn_key(const struct key_type *key_type,
>  {
>      struct key2 key2;
>      struct key_direction_state kds;
> -    char log_prefix[128] = { 0 };
>  
>      if (key_inline)
>      {
> @@ -1186,13 +1205,7 @@ crypto_read_openvpn_key(const struct key_type *key_type,
>      must_have_n_keys(key_file, opt_name, &key2, kds.need_keys);
>  
>      /* initialize key in both directions */
> -    openvpn_snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", key_name);
> -    init_key_ctx(&ctx->encrypt, &key2.keys[kds.out_key], key_type,
> -                 OPENVPN_OP_ENCRYPT, log_prefix);
> -    openvpn_snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", key_name);
> -    init_key_ctx(&ctx->decrypt, &key2.keys[kds.in_key], key_type,
> -                 OPENVPN_OP_DECRYPT, log_prefix);
> -
> +    init_key_ctx_bi(ctx, &key2, key_direction, key_type, key_name);
>      secure_memzero(&key2, sizeof(key2));
>  }
>  
> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index fec2eea7..86d2cfcc 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -318,6 +318,10 @@ void init_key_ctx(struct key_ctx *ctx, const struct key *key,
>  
>  void free_key_ctx(struct key_ctx *ctx);
>  
> +void init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,
> +                     int key_direction, const struct key_type *kt,
> +		     const char *name);
> +
>  void free_key_ctx_bi(struct key_ctx_bi *ctx);
>  
>  
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index df232894..56daec38 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1840,20 +1840,8 @@ generate_key_expansion(struct key_ctx_bi *key,
>      }
>  
>      /* Initialize OpenSSL key contexts */
> -
> -    ASSERT(server == true || server == false);
> -
> -    init_key_ctx(&key->encrypt,
> -                 &key2.keys[(int)server],
> -                 key_type,
> -                 OPENVPN_OP_ENCRYPT,
> -                 "Data Channel Encrypt");
> -
> -    init_key_ctx(&key->decrypt,
> -                 &key2.keys[1-(int)server],
> -                 key_type,
> -                 OPENVPN_OP_DECRYPT,
> -                 "Data Channel Decrypt");
> +    int key_direction = server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
> +    init_key_ctx_bi(key, &key2, key_direction, key_type, "Data Channel");
>  
>      /* Initialize implicit IVs */
>      key_ctx_update_implicit_iv(&key->encrypt, key2.keys[(int)server].hmac,
> @@ -1861,7 +1849,6 @@ generate_key_expansion(struct key_ctx_bi *key,
>      key_ctx_update_implicit_iv(&key->decrypt, key2.keys[1-(int)server].hmac,
>                                 MAX_HMAC_KEY_LENGTH);
>  
> -    key->initialized = true;
>      ret = true;
>  
>  exit:
> 

Apart from three extra newlines (which increase code readability) and a
slightly improved commit message, this is the same commit as in my
tls-crypt-v2-preview branch:
https://github.com/syzzer/openvpn/commit/9837b498

So I confirm that I agree to include this patch with me as the author.

-Steffan

