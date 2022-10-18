From: Heiko Hund <heiko@...2662...>
Date: Tue, 18 Oct 2022 03:36:01 +0200
Message-ID: <1919509.yKVeVyVuyW@...2664...>
In-Reply-To: <20220909195902.2011798-3-arne@...1227...>
References: <20220909195902.2011798-1-arne@...1227...>
 <20220909195902.2011798-3-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 3/3] Introduce dynamic tls-crypt for
 secure soft_reset/session renegotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Freitag, 9. September 2022 21:59:02 CEST Arne Schwabe wrote:
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1803,6 +1803,10 @@ multi_client_set_protocol_options(struct context *c)
>      {
>          o->imported_protocol_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
>      }
> +    if (proto & IV_PROTO_SECURE_RENOG)

I think any occurrence of "renog" (i.e. short for renegotiation[s]) should be 
changed to "reneg" throughout this patch. See --reneg-x options. Could be just 
me, so a more opinions would be welcome.

> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -8553,6 +8553,10 @@ add_option(struct options *options,
>              {
>                  options->imported_protocol_flags |=
> CO_USE_TLS_KEY_MATERIAL_EXPORT; }
> +            else if (streq(p[j], "secure-renog"))

Should be rewritten to use --protocol-flags instead.

> @@ -71,9 +71,77 @@ tls_crypt_init_key(struct key_ctx_bi *key, const char
> *key_file, msg(M_FATAL, "ERROR: --tls-crypt not supported");
>      }
>      crypto_read_openvpn_key(&kt, key, key_file, key_inline, key_direction,
> -                            "Control Channel Encryption", "tls-crypt");
> +                            "Control Channel Encryption", "tls-crypt",
> keydata); }
> 
> +/**
> + * Will produce dest = dest XOR data
> + */
> +static void
> +xor_key2_key(struct key2 *dest, const struct key2 *data)

I wonder if this would be more readable as
xor_key(struct key2 *key, const struct key2 *mask)

> +bool
> +tls_session_generate_secure_renegotition_key(struct tls_multi *multi,
> +                                             struct tls_session *session)

typo renegotiation_key

> +    struct key2 rengokeys;

typo renogkeys (renegkeys, IMHO)

> @@ -285,7 +354,7 @@ tls_crypt_v2_init_client_key(struct key_ctx_bi *key,
> struct buffer *wkc_buf, }
> 
>      tls_crypt_v2_load_client_key(key, &key2, false);
> -    secure_memzero(&key2, sizeof(key2));
> +    *original_key = key2;

We should do the zeroing in tls_session_generate_secure_renegotiation_key() 
shortly after we used it to XOR then. And maybe only delay it if we need to 
XOR anyways, could use original_key == NULL as indication.

> @@ -587,8 +655,8 @@ tls_crypt_v2_extract_client_key(struct buffer *buf,
>      ctx->cleanup_key_ctx = true;
>      ctx->opt.flags |= CO_PACKET_ID_LONG_FORM;
>      memset(&ctx->opt.key_ctx_bi, 0, sizeof(ctx->opt.key_ctx_bi));
> -    tls_crypt_v2_load_client_key(&ctx->opt.key_ctx_bi, &client_key, true);
> -    secure_memzero(&client_key, sizeof(client_key));
> +    tls_crypt_v2_load_client_key(&ctx->opt.key_ctx_bi,
> +                                 &ctx->original_tlscrypt_keydata, true);

Same as above for the server side. Could zero here immediately if 
original_tlscrypt_keydata == NULL





