References: <20201009115453.4279-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <93f62e55-98d5-97de-4250-b8779599e0bc@...1856...>
Date: Fri, 9 Oct 2020 15:57:25 +0200
MIME-Version: 1.0
In-Reply-To: <20201009115453.4279-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5] Implement generating data channel
 keys via EKM/RFC 5705
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

On 09-10-2020 13:54, Arne Schwabe wrote:
> OpenVPN currently uses its own (based on TLS 1.0) key derivation
> mechanism to generate the 256 bytes key data in key2 struct that
> are then used used to generate encryption/hmac/iv vectors. While
> this mechanism is still secure, it is not state of the art.
> 
> Instead of modernising our own approach, this commit implements
> key derivation using the Keying Material Exporters API introduced
> by RFC 5705.
> 
> We also use an opportunistic approach of negotiating the use of
> EKM (exported key material) through an IV_PROTO flag and prefer
> EKM to our own PRF if both client and server support it. The
> use of EKM is pushed to the client as part of NCP as
> key-derivation tls-ekm.
> 
> We still exchange the random data (112 bytes from client to server
> and 64 byte from server to client) for the OpenVPN PRF but
> do not use it. Removing that exchange would break the handshake
> and make a key-method 3 or similar necessary.
> 
> As a side effect, this makes a little bit easier to have a FIPS compatible
> version of OpenVPN since we do not rely on calling MD5 anymore.
> 
> Side note: this commit breaks the (not yet merged) WolfSSL support as it
> claims to support EKM in the OpenSSL compat API but always returns an error
> if you try to use it.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Patch v2: rebase/change to V2 of EKM refactoring
> 
> Patch v3: add Changes.rst
> 
> Patch v4: Rebase on master.
> 
> Patch v5: Refuse internal label to be used with --keying-material-exporter,
>           polishing/fixes suggested by Steffan integrated
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Still the duplicate signed-off line. But that's easy enough to fix at
commit time I guess.

> ---
>  Changes.rst                      | 11 +++++++
>  doc/doxygen/doc_key_generation.h | 14 +++++++--
>  src/openvpn/crypto.h             |  4 +++
>  src/openvpn/init.c               |  1 +
>  src/openvpn/multi.c              |  4 +++
>  src/openvpn/options.c            | 19 +++++++++++
>  src/openvpn/options.h            |  3 ++
>  src/openvpn/push.c               |  5 ++-
>  src/openvpn/ssl.c                | 54 ++++++++++++++++++++++++++++----
>  src/openvpn/ssl.h                |  2 ++
>  src/openvpn/ssl_backend.h        |  1 +
>  src/openvpn/ssl_mbedtls.c        |  7 ++---
>  12 files changed, 111 insertions(+), 14 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index f67e1d76..2a2829e7 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -1,3 +1,14 @@
> +Overview of changes in 2.6
> +==========================
> +
> +
> +New features
> +------------
> +Keying Material Exporters (RFC 5705) based key generation
> +    As part of the cipher negotiation OpenVPN will automatically prefer
> +    the RFC5705 based key material generation to the current custom
> +    OpenVPN PRF. This feature requires OpenSSL or mbed TLS 2.18+.
> +
>  Overview of changes in 2.5
>  ==========================
>  
> diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
> index 4bb9c708..cef773a9 100644
> --- a/doc/doxygen/doc_key_generation.h
> +++ b/doc/doxygen/doc_key_generation.h
> @@ -58,6 +58,12 @@
>   *
>   * @subsection key_generation_method_2 Key method 2
>   *
> + * There are two methods for generating key data when using key method 2
> + * the first is OpenVPN's traditional approach that exchanges random
> + * data and uses a PRF and the other is using the RFC5705 keying material
> + * exporter to generate the key material. For both methods the random
> + * data is exchange but only used in the traditional method.
> + *
>   * -# The client generates random material in the following amounts:
>   *    - Pre-master secret: 48 bytes
>   *    - Client's PRF seed for master secret: 32 bytes
> @@ -73,8 +79,12 @@
>   *    server's random material.
>   *
>   * %Key method 2 %key expansion is performed by the \c
> - * generate_key_expansion() function.  Please refer to its source code for
> - * details of the %key expansion process.
> + * generate_key_expansion_oepnvpn_prf() function.  Please refer to its source

What is this oepnvpn your are talking about? :-p

(Interesting how you managed to re-introduce this typo from v4 to v5...)

> + * code for details of the %key expansion process.
> + *
> + * When the client sends the IV_PROTO_TLS_KEY_EXPORT flag and the server replies
> + * with `key-derivation tls-ekm` the RFC5705 key material exporter with the
> + * label EXPORTER-OpenVPN-datakeys is used for the key data.
>   *
>   * @subsection key_generation_random Source of random material
>   *
> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index 999f643e..1ad669ce 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -254,6 +254,10 @@ struct crypto_options
>  #define CO_MUTE_REPLAY_WARNINGS (1<<2)
>      /**< Bit-flag indicating not to display
>       *   replay warnings. */
> +#define CO_USE_TLS_KEY_MATERIAL_EXPORT  (1<<3)
> +    /**< Bit-flag indicating that data channel key derivation
> +     * is done using TLS keying material export [RFC5705]
> +     */
>      unsigned int flags;         /**< Bit-flags determining behavior of
>                                   *   security operation functions. */
>  };
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index f87c11e7..580a8550 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -687,6 +687,7 @@ restore_ncp_options(struct context *c)
>      c->options.ciphername = c->c1.ciphername;
>      c->options.authname = c->c1.authname;
>      c->options.keysize = c->c1.keysize;
> +    c->options.data_channel_use_ekm = false;
>  }
>  
>  void
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 13738180..a5862020 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1817,6 +1817,10 @@ multi_client_set_protocol_options(struct context *c)
>          c->c2.push_request_received = true;
>      }
>  
> +#ifdef HAVE_EXPORT_KEYING_MATERIAL
> +    o->data_channel_use_ekm = (proto & IV_PROTO_TLS_KEY_EXPORT);
> +#endif
> +
>      /* Select cipher if client supports Negotiable Crypto Parameters */
>      if (!o->ncp_enabled)
>      {
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 772323df..4e19d7cb 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -7979,6 +7979,20 @@ add_option(struct options *options,
>          }
>          options->ncp_ciphers = p[1];
>      }
> +    else if (streq(p[0], "key-derivation") && p[1])
> +    {
> +        VERIFY_PERMISSION(OPT_P_NCP)
> +#ifdef HAVE_EXPORT_KEYING_MATERIAL
> +        if (streq(p[1], "tls-ekm"))
> +        {
> +            options->data_channel_use_ekm = true;
> +        }
> +        else
> +#endif
> +        {
> +            msg(msglevel, "Unknown key-derivation method %s", p[1]);
> +        }
> +    }
>      else if (streq(p[0], "ncp-disable") && !p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
> @@ -8707,6 +8721,11 @@ add_option(struct options *options,
>                  "\"EXPORTER\"");
>              goto err;
>          }
> +        if (streq(p[1], EXPORT_KEY_DATA_LABEL))
> +        {
> +            msg(msglevel, "Keying material exporter label must not be '"
> +                EXPORT_KEY_DATA_LABEL "'.");
> +        }
>          if (ekm_length < 16 || ekm_length > 4095)
>          {
>              msg(msglevel, "Invalid keying material exporter length");
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index e527d70e..5d977793 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -648,6 +648,9 @@ struct options
>      /* Useful when packets sent by openvpn itself are not subject
>       * to the routing tables that would move packets into the tunnel. */
>      bool allow_recursive_routing;
> +
> +    /* Use RFC5705 key export to generate data channel keys */
> +    bool data_channel_use_ekm;
>  };
>  
>  #define streq(x, y) (!strcmp((x), (y)))
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index e0d2eeaf..17bba948 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -479,7 +479,10 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
>      {
>          push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
>      }
> -
> +    if (o->data_channel_use_ekm)
> +    {
> +        push_option_fmt(gc, push_list, M_USAGE, "key-derivation tls-ekm");
> +    }
>      return true;
>  }
>  
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index f90c6a85..b572b7b8 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1783,6 +1783,29 @@ init_key_contexts(struct key_ctx_bi *key,
>  
>  }
>  
> +static bool
> +generate_key_expansion_tls_export(struct tls_session *session, struct key2 *key2)
> +{
> +    struct gc_arena gc = gc_new();
> +    unsigned char *key2data;
> +
> +    key2data = key_state_export_keying_material(session,
> +                                                EXPORT_KEY_DATA_LABEL,
> +                                                strlen(EXPORT_KEY_DATA_LABEL),
> +                                                sizeof(key2->keys),
> +                                                &gc);
> +    if (!key2data)
> +    {
> +        return false;
> +    }
> +    memcpy(key2->keys, key2data, sizeof(key2->keys));
> +    secure_memzero(key2data, sizeof(key2->keys));
> +    key2->n = 2;
> +
> +    gc_free(&gc);
> +    return true;
> +}
> +
>  static struct key2
>  generate_key_expansion_openvpn_prf(const struct tls_session *session)
>  {
> @@ -1854,7 +1877,7 @@ generate_key_expansion_openvpn_prf(const struct tls_session *session)
>   */
>  static bool
>  generate_key_expansion(struct key_ctx_bi *key,
> -                       const struct tls_session *session)
> +                       struct tls_session *session)
>  {
>      bool ret = false;
>      struct key2 key2;
> @@ -1865,10 +1888,20 @@ generate_key_expansion(struct key_ctx_bi *key,
>          goto exit;
>      }
>  
> -
>      bool server = session->opt->server;
>  
> -    key2 = generate_key_expansion_openvpn_prf(session);
> +    if (session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT)
> +    {
> +        if (!generate_key_expansion_tls_export(session, &key2))
> +        {
> +            msg(D_TLS_ERRORS, "TLS Error: Keying material export failed");
> +            goto exit;
> +        }
> +    }
> +    else
> +    {
> +        key2 = generate_key_expansion_openvpn_prf(session);
> +    }
>  
>      key2_print(&key2, &session->opt->key_type,
>                 "Master Encrypt", "Master Decrypt");
> @@ -1967,6 +2000,11 @@ tls_session_update_crypto_params(struct tls_session *session,
>          return false;
>      }
>  
> +    if (options->data_channel_use_ekm)
> +    {
> +        session->opt->crypto_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
> +    }
> +
>      if (strcmp(options->ciphername, session->opt->config_ciphername))
>      {
>          msg(D_HANDSHAKE, "Data Channel: using negotiated cipher '%s'",
> @@ -2251,13 +2289,11 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
>           * push request, also signal that the client wants
>           * to get push-reply messages without without requiring a round
>           * trip for a push request message*/
> -        if(session->opt->pull)
> +        if (session->opt->pull)
>          {
>              iv_proto |= IV_PROTO_REQUEST_PUSH;
>          }
>  
> -        buf_printf(&out, "IV_PROTO=%d\n", iv_proto);
> -
>          /* support for Negotiable Crypto Parameters */
>          if (session->opt->ncp_enabled
>              && (session->opt->mode == MODE_SERVER || session->opt->pull))
> @@ -2269,8 +2305,14 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
>                  buf_printf(&out, "IV_NCP=2\n");
>              }
>              buf_printf(&out, "IV_CIPHERS=%s\n", session->opt->config_ncp_ciphers);
> +
> +#ifdef HAVE_EXPORT_KEYING_MATERIAL
> +            iv_proto |= IV_PROTO_TLS_KEY_EXPORT;
> +#endif
>          }
>  
> +        buf_printf(&out, "IV_PROTO=%d\n", iv_proto);
> +
>          /* push compression status */
>  #ifdef USE_COMP
>          comp_generate_peer_info_string(&session->opt->comp_options, &out);
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index 005628f6..f00f8abd 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -116,6 +116,8 @@
>   * to wait for a push-request to send a push-reply */
>  #define IV_PROTO_REQUEST_PUSH   (1<<2)
>  
> +/** Supports key derivation via TLS key material exporter [RFC5705] */
> +#define IV_PROTO_TLS_KEY_EXPORT (1<<3)
>  
>  /* Default field in X509 to be username */
>  #define X509_USERNAME_FIELD_DEFAULT "CN"
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index cf9fba25..4bcb3181 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -389,6 +389,7 @@ void key_state_ssl_free(struct key_state_ssl *ks_ssl);
>  void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
>                                  const char *crl_file, bool crl_inline);
>  
> +#define EXPORT_KEY_DATA_LABEL       "EXPORTER-OpenVPN-datakeys"
>  /**
>   * Keying Material Exporters [RFC 5705] allows additional keying material to be
>   * derived from existing TLS channel. This exported keying material can then be
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 4ec355a9..f375e957 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -1168,11 +1168,8 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
>  
>  #ifdef HAVE_EXPORT_KEYING_MATERIAL
>      /* Initialize keying material exporter */
> -    if (session->opt->ekm_size)
> -    {
> -        mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
> -                                            mbedtls_ssl_export_keys_cb, session);
> -    }
> +    mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
> +                                        mbedtls_ssl_export_keys_cb, session);
>  #endif
>  
>      /* Initialise SSL context */
> 

If the above is fixed:

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

