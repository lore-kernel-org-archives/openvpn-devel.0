References: <20180707090421.25953-1-a@...2181...>
 <20180707090421.25953-2-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5b749261-5acf-b559-0402-483cf4218692@...1856...>
Date: Sat, 7 Jul 2018 15:22:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180707090421.25953-2-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4 2/2] make tls-auth and tls-crypt
 per-connection-block options
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

On 07-07-18 11:04, Antonio Quartulli wrote:
> Different VPN servers may use different tls-auth/crypt keys.
> For this reason it is convenient to make tls-auth/crypt
> per-connection-block options so that the user is allowed to
> specify one key per remote.
> 
> If no tls-auth/crypt option is specified in a given connection
> block, the global settings, if any, are used.
> 
> Trac: #720
> Cc: Steffan Karger <steffan@...1856...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> v2:
> - convert tls-auth keyfile to inline key if persist-key was specified
> v3:
> - squash 2/3 and 3/3 in one patch to prevent temporary features
>   breakages
> - restyle code introduced in options_postprocess_mutate_ce()
> v4:
> - rebase on top of latest 1/2
> 
>  doc/openvpn.8         |   3 +
>  src/openvpn/init.c    |  18 ++---
>  src/openvpn/options.c | 173 +++++++++++++++++++++++++++++-------------
>  src/openvpn/options.h |   9 +++
>  4 files changed, 142 insertions(+), 61 deletions(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 46ea58b6..f01b48b6 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -361,6 +361,7 @@ block:
>  .B fragment,
>  .B http\-proxy,
>  .B http\-proxy\-option,
> +.B key\-direction,
>  .B link\-mtu,
>  .B local,
>  .B lport,
> @@ -372,6 +373,8 @@ block:
>  .B remote,
>  .B rport,
>  .B socks\-proxy,
> +.B tls\-auth,
> +.B tls\-crypt,
>  .B tun\-mtu and
>  .B tun\-mtu\-extra.
>  
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 1b46b364..14732e34 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2507,7 +2507,7 @@ do_init_tls_wrap_key(struct context *c)
>      const struct options *options = &c->options;
>  
>      /* TLS handshake authentication (--tls-auth) */
> -    if (options->tls_auth_file)
> +    if (options->ce.tls_auth_file)
>      {
>          /* Initialize key_type for tls-auth with auth only */
>          CLEAR(c->c1.ks.tls_auth_key_type);
> @@ -2525,18 +2525,18 @@ do_init_tls_wrap_key(struct context *c)
>  
>          crypto_read_openvpn_key(&c->c1.ks.tls_auth_key_type,
>                                  &c->c1.ks.tls_wrap_key,
> -                                options->tls_auth_file,
> -                                options->tls_auth_file_inline,
> -                                options->key_direction,
> +                                options->ce.tls_auth_file,
> +                                options->ce.tls_auth_file_inline,
> +                                options->ce.key_direction,
>                                  "Control Channel Authentication", "tls-auth");
>      }
>  
>      /* TLS handshake encryption+authentication (--tls-crypt) */
> -    if (options->tls_crypt_file)
> +    if (options->ce.tls_crypt_file)
>      {
>          tls_crypt_init_key(&c->c1.ks.tls_wrap_key,
> -                           options->tls_crypt_file,
> -                           options->tls_crypt_inline, options->tls_server);
> +                           options->ce.tls_crypt_file,
> +                           options->ce.tls_crypt_inline, options->tls_server);
>      }
>  }
>  
> @@ -2806,7 +2806,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
>  #endif
>  
>      /* TLS handshake authentication (--tls-auth) */
> -    if (options->tls_auth_file)
> +    if (options->ce.tls_auth_file)
>      {
>          to.tls_wrap.mode = TLS_WRAP_AUTH;
>          to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
> @@ -2817,7 +2817,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
>      }
>  
>      /* TLS handshake encryption (--tls-crypt) */
> -    if (options->tls_crypt_file)
> +    if (options->ce.tls_crypt_file)
>      {
>          to.tls_wrap.mode = TLS_WRAP_CRYPT;
>          to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index b2ca2738..6f1a5382 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1506,6 +1506,11 @@ show_connection_entry(const struct connection_entry *o)
>  #ifdef ENABLE_OCC
>      SHOW_INT(explicit_exit_notification);
>  #endif
> +
> +    SHOW_STR(tls_auth_file);
> +    SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true),
> +              "%s");
> +    SHOW_STR(tls_crypt_file);
>  }
>  
>  
> @@ -1786,9 +1791,6 @@ show_settings(const struct options *o)
>      SHOW_BOOL(push_peer_info);
>      SHOW_BOOL(tls_exit);
>  
> -    SHOW_STR(tls_auth_file);
> -    SHOW_STR(tls_crypt_file);
> -
>  #ifdef ENABLE_PKCS11
>      {
>          int i;
> @@ -2723,7 +2725,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>                  notnull(options->priv_key_file, "private key file (--key) or PKCS#12 file (--pkcs12)");
>              }
>          }
> -        if (options->tls_auth_file && options->tls_crypt_file)
> +        if (ce->tls_auth_file && ce->tls_crypt_file)
>          {
>              msg(M_USAGE, "--tls-auth and --tls-crypt are mutually exclusive");
>          }
> @@ -2869,6 +2871,49 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
>          }
>      }
>  
> +    /*
> +     * Set per-connection block tls-auth/crypt fields if undefined.
> +     *
> +     * At the end only one of the two will be really set because the parser
> +     * logic prevents configurations where both are set.
> +     */
> +    if (!ce->tls_auth_file && !ce->tls_crypt_file)
> +    {
> +        ce->tls_auth_file = o->tls_auth_file;
> +        ce->tls_auth_file_inline = o->tls_auth_file_inline;
> +        ce->key_direction = o->key_direction;
> +
> +        ce->tls_crypt_file = o->tls_crypt_file;
> +        ce->tls_crypt_inline = o->tls_crypt_inline;
> +    }
> +
> +    /* pre-cache tls-auth/crypt key file if persist-key was specified and keys
> +     * were not already embedded in the config file
> +     */
> +    if (o->persist_key)
> +    {
> +        if (ce->tls_auth_file && !ce->tls_auth_file_inline)
> +        {
> +            struct buffer in = buffer_read_from_file(o->tls_auth_file, &o->gc);
> +            if (!buf_valid(&in))
> +                msg(M_FATAL, "Cannot pre-load tls-auth keyfile (%s)",
> +                    o->tls_auth_file);
> +
> +            ce->tls_auth_file = INLINE_FILE_TAG;
> +            ce->tls_auth_file_inline = (char *)in.data;
> +        }
> +
> +        if (ce->tls_crypt_file && !ce->tls_crypt_inline)
> +        {
> +            struct buffer in = buffer_read_from_file(o->tls_crypt_file, &o->gc);
> +            if (!buf_valid(&in))
> +                msg(M_FATAL, "Cannot pre-load tls-crypt keyfile (%s)",
> +                    o->tls_auth_file);
> +
> +            ce->tls_crypt_file = INLINE_FILE_TAG;
> +            ce->tls_crypt_inline = (char *)in.data;
> +        }
> +    }
>  }
>  
>  #ifdef _WIN32
> @@ -3019,32 +3064,6 @@ options_postprocess_mutate(struct options *o)
>          options_postprocess_mutate_ce(o, o->connection_list->array[i]);
>      }
>  
> -    /* pre-cache tls-auth/crypt key file if persist-key was specified */
> -    if (o->persist_key)
> -    {
> -        if (o->tls_auth_file && !o->tls_auth_file_inline)
> -        {
> -            struct buffer in = buffer_read_from_file(o->tls_auth_file, &o->gc);
> -            if (!buf_valid(&in))
> -                msg(M_FATAL, "Cannot pre-load tls-auth keyfile (%s)",
> -                    o->tls_auth_file);
> -
> -            o->tls_auth_file = INLINE_FILE_TAG;
> -            o->tls_auth_file_inline = (char *)in.data;
> -        }
> -
> -        if (o->tls_crypt_file && !o->tls_crypt_inline)
> -        {
> -            struct buffer in = buffer_read_from_file(o->tls_crypt_file, &o->gc);
> -            if (!buf_valid(&in))
> -                msg(M_FATAL, "Cannot pre-load tls-crypt keyfile (%s)",
> -                    o->tls_auth_file);
> -
> -            o->tls_crypt_file = INLINE_FILE_TAG;
> -            o->tls_crypt_inline = (char *)in.data;
> -        }
> -    }
> -
>      if (o->tls_server)
>      {
>          /* Check that DH file is specified, or explicitly disabled */
> @@ -3311,12 +3330,22 @@ options_postprocess_filechecks(struct options *options)
>                                           options->crl_file, R_OK, "--crl-verify");
>      }
>  
> -    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
> -                              options->tls_auth_file, R_OK, "--tls-auth");
> -    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
> -                              options->tls_crypt_file, R_OK, "--tls-crypt");
> +    ASSERT(options->connection_list);
> +    for (int i = 0; i < options->connection_list->len; ++i)
> +    {
> +        struct connection_entry *ce = options->connection_list->array[i];
> +
> +        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
> +                                  ce->tls_auth_file, R_OK, "--tls-auth");
> +
> +        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
> +                                  ce->tls_crypt_file, R_OK, "--tls-crypt");
> +
> +    }
> +
>      errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
>                                options->shared_secret_file, R_OK, "--secret");
> +
>      errs |= check_file_access(CHKACC_DIRPATH|CHKACC_FILEXSTWR,
>                                options->packet_id_file, R_OK|W_OK, "--replay-persist");
>  
> @@ -3673,7 +3702,7 @@ options_string(const struct options *o,
>      {
>          if (TLS_CLIENT || TLS_SERVER)
>          {
> -            if (o->tls_auth_file)
> +            if (o->ce.tls_auth_file)
>              {
>                  buf_printf(&out, ",tls-auth");
>              }
> @@ -7446,10 +7475,19 @@ add_option(struct options *options,
>      {
>          int key_direction;
>  
> +        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
> +
>          key_direction = ascii2keydirection(msglevel, p[1]);
>          if (key_direction >= 0)
>          {
> -            options->key_direction = key_direction;
> +            if (permission_mask & OPT_P_GENERAL)
> +            {
> +                options->key_direction = key_direction;
> +            }
> +            else if (permission_mask & OPT_P_CONNECTION)
> +            {
> +                options->ce.key_direction = key_direction;
> +            }
>          }
>          else
>          {
> @@ -8018,35 +8056,66 @@ add_option(struct options *options,
>      }
>      else if (streq(p[0], "tls-auth") && p[1] && !p[3])
>      {
> -        VERIFY_PERMISSION(OPT_P_GENERAL);
> -        if (streq(p[1], INLINE_FILE_TAG) && p[2])
> +        int key_direction = -1;
> +
> +        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
> +
> +        if (permission_mask & OPT_P_GENERAL)
>          {
> -            options->tls_auth_file_inline = p[2];
> +            if (streq(p[1], INLINE_FILE_TAG) && p[2])
> +            {
> +                options->tls_auth_file_inline = p[2];
> +            }
> +            else if (p[2])
> +            {
> +                key_direction = ascii2keydirection(msglevel, p[2]);
> +                if (key_direction < 0)
> +                {
> +                    goto err;
> +                }
> +                options->key_direction = key_direction;
> +            }
> +            options->tls_auth_file = p[1];
>          }
> -        else if (p[2])
> +        else if (permission_mask & OPT_P_CONNECTION)
>          {
> -            int key_direction;
> -
> -            key_direction = ascii2keydirection(msglevel, p[2]);
> -            if (key_direction >= 0)
> +            options->ce.key_direction = KEY_DIRECTION_BIDIRECTIONAL;
> +            if (streq(p[1], INLINE_FILE_TAG) && p[2])
>              {
> -                options->key_direction = key_direction;
> +                options->ce.tls_auth_file_inline = p[2];
>              }
> -            else
> +            else if (p[2])
>              {
> -                goto err;
> +                key_direction = ascii2keydirection(msglevel, p[2]);
> +                if (key_direction < 0)
> +                {
> +                    goto err;
> +                }
> +                options->ce.key_direction = key_direction;
>              }
> +            options->ce.tls_auth_file = p[1];
>          }
> -        options->tls_auth_file = p[1];
>      }
>      else if (streq(p[0], "tls-crypt") && p[1] && !p[3])
>      {
> -        VERIFY_PERMISSION(OPT_P_GENERAL);
> -        if (streq(p[1], INLINE_FILE_TAG) && p[2])
> +        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
> +        if (permission_mask & OPT_P_GENERAL)
>          {
> -            options->tls_crypt_inline = p[2];
> +            if (streq(p[1], INLINE_FILE_TAG) && p[2])
> +            {
> +                options->tls_crypt_inline = p[2];
> +            }
> +            options->tls_crypt_file = p[1];
> +        }
> +        else if (permission_mask & OPT_P_CONNECTION)
> +        {
> +            if (streq(p[1], INLINE_FILE_TAG) && p[2])
> +            {
> +                options->ce.tls_crypt_inline = p[2];
> +            }
> +            options->ce.tls_crypt_file = p[1];
> +
>          }
> -        options->tls_crypt_file = p[1];
>      }
>      else if (streq(p[0], "key-method") && p[1] && !p[2])
>      {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 3a6c33f8..acbd1087 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -130,6 +130,15 @@ struct connection_entry
>  #define CE_MAN_QUERY_REMOTE_MASK   (0x07)
>  #define CE_MAN_QUERY_REMOTE_SHIFT  (2)
>      unsigned int flags;
> +
> +    /* Shared secret used for TLS control channel authentication */
> +    const char *tls_auth_file;
> +    const char *tls_auth_file_inline;
> +    int key_direction;
> +
> +    /* Shared secret used for TLS control channel authenticated encryption */
> +    const char *tls_crypt_file;
> +    const char *tls_crypt_inline;
>  };
>  
>  struct remote_entry
> 

Patch looks good, and I can no longer get this to fail on me, so:

Acked-by: Steffan Karger <steffan@...1856...>
Tested-by; Steffan Karger <steffan@...1856...>

-Steffan

