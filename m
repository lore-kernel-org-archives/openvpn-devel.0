References: <20200812140120.21287-1-arne@...1227...>
 <20200812140120.21287-2-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <ed058045-8f27-631a-2caf-ae03601c64e4@...1856...>
Date: Fri, 21 Aug 2020 22:00:02 +0200
MIME-Version: 1.0
In-Reply-To: <20200812140120.21287-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Move openvpn specific key
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

On 12-08-2020 16:01, Arne Schwabe wrote:
> This moves the OpenVPN specific PRF into its own function also
> simplifies the code a bit by passing tls_session directly instead of
> 5 of its fields.

Moves in the right direction. Some comments though:

> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Patch V2: Rebase
> ---
>  src/openvpn/ssl.c | 109 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 69 insertions(+), 40 deletions(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 3fcaa25f..06cc4c0b 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1765,27 +1765,38 @@ openvpn_PRF(const uint8_t *secret,
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
> +    /* Initialize OpenSSL key contexts */

Since you're touching this, can you remove "OpenSSL" from this comment.
It's a lie! Sometimes.

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
> +static struct key2
> +generate_key_expansion_oepnvpn_prf(const struct tls_session *session)

What is this oepnvpn you're talking about?

>  {
> +

Unneeded newline.

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
> @@ -1803,6 +1814,7 @@ generate_key_expansion(struct key_ctx_bi *key,
>                  master,
>                  sizeof(master));
>  
> +    struct key2 key2;
>      /* compute key expansion */
>      openvpn_PRF(master,
>                  sizeof(master),
> @@ -1815,41 +1827,62 @@ generate_key_expansion(struct key_ctx_bi *key,
>                  server_sid,
>                  (uint8_t *)key2.keys,
>                  sizeof(key2.keys));
> +    secure_memzero(&master, sizeof(master));
>  
> +    /* We use the DES fixup here so we can drop it once we
> +     * drop DES support and non RFC5705 key derivation */
> +    for (int i = 0; i < 2; ++i)
> +    {
> +        fixup_key(&key2.keys[i], &session->opt->key_type);
> +    }

Very nice that we can finally get rid of this. But I'm wondering now:
should we forbid DES (or maybe even any small block cipher) when using EKM?

Even if we remove small block cipher support completely from 2.6, I'd
still really like to backport EKM to 2.5 ("long-term compat"). At that
will still allow persistent users to force it to use DES.

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
> +    struct key2 key2 = generate_key_expansion_oepnvpn_prf(session);

Possible use-before-initialization/declaration here (undefined behavior).

key2 is used in the exit: label, so it should not be declared after the
"goto exit" above. This is type of mistake is the reason I don't like
late-declaration of any variable in functions that use a goto-error
flow. Next to not-too-smart static analyzers complaining about this
construct even if not used behind the label.

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
>  static void
>  key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)
>  {
> @@ -1879,10 +1912,7 @@ tls_session_generate_data_channel_keys(struct tls_session *session)
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
> @@ -1891,9 +1921,8 @@ tls_session_generate_data_channel_keys(struct tls_session *session)
>      }
>  
>      ks->crypto_options.flags = session->opt->crypto_flags;
> -    if (!generate_key_expansion(&ks->crypto_options.key_ctx_bi,
> -                                &session->opt->key_type, ks->key_src, client_sid, server_sid,
> -                                session->opt->server))
> +
> +    if (!generate_key_expansion(&ks->crypto_options.key_ctx_bi, session))
>      {
>          msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
>          goto cleanup;
> 

-Steffan

