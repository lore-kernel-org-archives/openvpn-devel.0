References: <20200825073643.15920-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2cdd89f6-e5ec-9a8c-840a-0169908bea71@...1856...>
Date: Sun, 4 Oct 2020 20:01:09 +0200
MIME-Version: 1.0
In-Reply-To: <20200825073643.15920-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4 1/2] Move openvpn specific key
 expansion into its own function
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

On 25-08-2020 09:36, Arne Schwabe wrote:
> This moves the OpenVPN specific PRF into its own function also
> simplifies the code a bit by passing tls_session directly instead of
> 5 of its fields.
> 
> Patch v2: Rebase
> 
> Patch v4: rewrite/fix comments,
>           fix potential not initialised before goto issue

Thanks. All my previous concerns were tackled accordingly.

> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl.c | 119 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 79 insertions(+), 40 deletions(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 3fcaa25f..b4d94b8a 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1765,27 +1765,37 @@ openvpn_PRF(const uint8_t *secret,
>      VALGRIND_MAKE_READABLE((void *)output, output_len);
>  }
>  
> -/*
> - * Using source entropy from local and remote hosts, mix into
> - * master key.
> - */
> -static bool
> -generate_key_expansion(struct key_ctx_bi *key,
> -                       const struct key_type *key_type,
> -                       const struct key_source2 *key_src,
> -                       const struct session_id *client_sid,
> -                       const struct session_id *server_sid,
> -                       bool server)
> +static void
> +init_key_contexts(struct key_ctx_bi *key,
> +                  const struct key_type *key_type,
> +                  bool server,
> +                  struct key2 *key2)
> +{
> +    /* Initialize key contexts */
> +    int key_direction = server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
> +    init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel");
> +
> +    /* Initialize implicit IVs */
> +    key_ctx_update_implicit_iv(&key->encrypt, (*key2).keys[(int)server].hmac,
> +                               MAX_HMAC_KEY_LENGTH);
> +    key_ctx_update_implicit_iv(&key->decrypt, (*key2).keys[1-(int)server].hmac,
> +                               MAX_HMAC_KEY_LENGTH);
> +
> +}
> +
> +

One newline too much.

> +static struct key2
> +generate_key_expansion_openvpn_prf(const struct tls_session *session)
>  {
>      uint8_t master[48] = { 0 };
> -    struct key2 key2 = { 0 };
> -    bool ret = false;
>  
> -    if (key->initialized)
> -    {
> -        msg(D_TLS_ERRORS, "TLS Error: key already initialized");
> -        goto exit;
> -    }
> +    const struct key_state *ks = &session->key[KS_PRIMARY];
> +    const struct key_source2 *key_src = ks->key_src;
> +
> +    const struct session_id *client_sid = session->opt->server ?
> +                                          &ks->session_id_remote : &session->session_id;
> +    const struct session_id *server_sid = !session->opt->server ?
> +                                          &ks->session_id_remote : &session->session_id;
>  
>      /* debugging print of source key material */
>      key_source2_print(key_src);
> @@ -1803,6 +1813,7 @@ generate_key_expansion(struct key_ctx_bi *key,
>                  master,
>                  sizeof(master));
>  
> +    struct key2 key2;
>      /* compute key expansion */
>      openvpn_PRF(master,
>                  sizeof(master),
> @@ -1815,41 +1826,73 @@ generate_key_expansion(struct key_ctx_bi *key,
>                  server_sid,
>                  (uint8_t *)key2.keys,
>                  sizeof(key2.keys));
> +    secure_memzero(&master, sizeof(master));
>  
> +    /*
> +     * fixup_key only correctly sets DES parity bits if the cipher is a
> +     * DES variant.
> +     *
> +     * The newer OpenSSL and mbed TLS libraries (those that support EKM)
> +     * ignore these bits.
> +     *
> +     * We keep the DES fixup here as compatibility.
> +     * OpenVPN3 never did this fixup anyway. So this code is *probably* not
> +     * required but we keep it for compatibility until we remove DES support
> +     * since it does not hurt either.
> +     */
> +    for (int i = 0; i < 2; ++i)
> +    {
> +        fixup_key(&key2.keys[i], &session->opt->key_type);
> +    }
>      key2.n = 2;
>  
> -    key2_print(&key2, key_type, "Master Encrypt", "Master Decrypt");
> +    return key2;
> +}
> +
> +/*
> + * Using source entropy from local and remote hosts, mix into
> + * master key.
> + */
> +static bool
> +generate_key_expansion(struct key_ctx_bi *key,
> +                       const struct tls_session *session)
> +{
> +    bool ret = false;
> +    struct key2 key2;
> +
> +    if (key->initialized)
> +    {
> +        msg(D_TLS_ERRORS, "TLS Error: key already initialized");
> +        goto exit;
> +    }
> +
> +
> +    bool server = session->opt->server;
> +
> +    key2 = generate_key_expansion_openvpn_prf(session);
> +
> +    key2_print(&key2, &session->opt->key_type,
> +               "Master Encrypt", "Master Decrypt");
>  
>      /* check for weak keys */
>      for (int i = 0; i < 2; ++i)
>      {
> -        fixup_key(&key2.keys[i], key_type);
> -        if (!check_key(&key2.keys[i], key_type))
> +        if (!check_key(&key2.keys[i], &session->opt->key_type))
>          {
>              msg(D_TLS_ERRORS, "TLS Error: Bad dynamic key generated");
>              goto exit;
>          }
>      }
> -
> -    /* Initialize OpenSSL key contexts */
> -    int key_direction = server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
> -    init_key_ctx_bi(key, &key2, key_direction, key_type, "Data Channel");
> -
> -    /* Initialize implicit IVs */
> -    key_ctx_update_implicit_iv(&key->encrypt, key2.keys[(int)server].hmac,
> -                               MAX_HMAC_KEY_LENGTH);
> -    key_ctx_update_implicit_iv(&key->decrypt, key2.keys[1-(int)server].hmac,
> -                               MAX_HMAC_KEY_LENGTH);
> -
> +    init_key_contexts(key, &session->opt->key_type, server, &key2);
>      ret = true;
>  
>  exit:
> -    secure_memzero(&master, sizeof(master));
>      secure_memzero(&key2, sizeof(key2));
>  
>      return ret;
>  }
>  
> +

Stray newline.

>  static void
>  key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)
>  {
> @@ -1879,10 +1922,7 @@ tls_session_generate_data_channel_keys(struct tls_session *session)
>  {
>      bool ret = false;
>      struct key_state *ks = &session->key[KS_PRIMARY];   /* primary key */
> -    const struct session_id *client_sid = session->opt->server ?
> -                                          &ks->session_id_remote : &session->session_id;
> -    const struct session_id *server_sid = !session->opt->server ?
> -                                          &ks->session_id_remote : &session->session_id;
> +
>  
>      if (ks->authenticated == KS_AUTH_FALSE)
>      {
> @@ -1891,9 +1931,8 @@ tls_session_generate_data_channel_keys(struct tls_session *session)
>      }
>  
>      ks->crypto_options.flags = session->opt->crypto_flags;
> -    if (!generate_key_expansion(&ks->crypto_options.key_ctx_bi,
> -                                &session->opt->key_type, ks->key_src, client_sid, server_sid,
> -                                session->opt->server))
> +
> +    if (!generate_key_expansion(&ks->crypto_options.key_ctx_bi, session))

Since you're passing session now, shouldn't you remove the key_ctx_bi
argument too? That's also part of session: (struct key_state) *ks =
&session->key[KS_PRIMARY].

>      {
>          msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
>          goto cleanup;
> 

Otherwise this looks good. I can also live with leaving key_ctx_bi in
for now. The current version of the patch is a clear improvement (and
paving the way for 2/2, ofc.)

So, as long as at least the whitespace is fixed:

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

