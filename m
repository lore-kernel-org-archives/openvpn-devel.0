References: <59a5ef1d-3b5f-f06a-e0e7-0443f0e2313e@...2080...>
 <20200721100128.9850-1-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <35e7f9a2-68b6-e4ea-a0b1-982e4778611e@...277...>
Date: Tue, 21 Jul 2020 11:39:57 +0100
MIME-Version: 1.0
In-Reply-To: <20200721100128.9850-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3 5/9] Remove key-method 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

1x typo

On 21/07/2020 11:01, Arne Schwabe wrote:
> Key-method 1 is only needed to talk to pre OpenVPN 2.0 clients.
> 
> Patch V2: Fix style. Make V1 op codes illegal, remove all code handling
>            v1 op codes and give a good warning message if we encounter
>            them in the legal op codes pre-check.
> 
> Patch V3: Add a bit more comments in the existing methods.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   doc/doxygen/doc_control_processor.h |   6 +-
>   doc/doxygen/doc_key_generation.h    |   6 +-
>   doc/doxygen/doc_protocol_overview.h |   2 +-
>   src/openvpn/forward.c               |   2 +-
>   src/openvpn/helper.c                |   5 -
>   src/openvpn/init.c                  |   1 -
>   src/openvpn/options.c               |  35 +---
>   src/openvpn/options.h               |   4 -
>   src/openvpn/ssl.c                   | 240 +++++-----------------------
>   src/openvpn/ssl.h                   |  19 +--
>   src/openvpn/ssl_common.h            |   1 -
>   11 files changed, 53 insertions(+), 268 deletions(-)
> 
> diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/doc_control_processor.h
> index f87324cc..1bbf2d2d 100644
> --- a/doc/doxygen/doc_control_processor.h
> +++ b/doc/doxygen/doc_control_processor.h
> @@ -175,11 +175,7 @@
>    *    appropriate messages to be sent.
>    *
>    * @par Functions which control data channel key generation
> - *  - Key method 1 key exchange functions:
> - *     - \c key_method_1_write(), generates and processes key material to
> - *       be sent to the remote OpenVPN peer.
> - *     - \c key_method_1_read(), processes key material received from the
> - *       remote OpenVPN peer.
> + *  - Key method 1 key exchange functions were removed from OpenVPN 2.5
>    *  - Key method 2 key exchange functions:
>    *     - \c key_method_2_write(), generates and processes key material to
>    *       be sent to the remote OpenVPN peer.
> diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
> index efe61155..4bb9c708 100644
> --- a/doc/doxygen/doc_key_generation.h
> +++ b/doc/doxygen/doc_key_generation.h
> @@ -131,11 +131,7 @@ S_ACTIVE                                                            S_ACTIVE
>    * control_processor Control Channel Processor module's\endlink \c
>    * tls_process() function and control the %key generation and exchange
>    * process as follows:
> - * - %Key method 1:
> - *   - \c key_method_1_write(): generate random material locally, and load
> - *     as "sending" keys.
> - *   - \c key_method_1_read(): read random material received from remote
> - *     peer, and load as "receiving" keys.
> + * - %Key method 1 has been removed in OpenVPN 2.5
>    * - %Key method 2:
>    *   - \c key_method_2_write(): generate random material locally, and if
>    *     in server mode generate %key expansion.
> diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
> index 3f48b18a..08212223 100644
> --- a/doc/doxygen/doc_protocol_overview.h
> +++ b/doc/doxygen/doc_protocol_overview.h
> @@ -150,7 +150,7 @@
>    *
>    * @subsection network_protocol_control_plaintext Structure of plaintext control channel messages
>    *
> - *  - %Key method 1:
> + *  - %Key method 1 (support removed in OpenVPN 2.5):
>    *     - Cipher %key length in bytes (1 byte).
>    *     - Cipher %key (n bytes).
>    *     - HMAC %key length in bytes (1 byte).
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 5c4370a8..698451d1 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1100,7 +1100,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
>                                   floated, &ad_start))
>               {
>                   /* Restore pre-NCP frame parameters */
> -                if (is_hard_reset(opcode, c->options.key_method))
> +                if (is_hard_reset_method2(opcode))
>                   {
>                       c->c2.frame = c->c2.frame_initial;
>   #ifdef ENABLE_FRAGMENT
> diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
> index 6e9cc63c..a1d03070 100644
> --- a/src/openvpn/helper.c
> +++ b/src/openvpn/helper.c
> @@ -490,11 +490,6 @@ helper_client_server(struct options *o)
>        */
>       if (o->client)
>       {
> -        if (o->key_method != 2)
> -        {
> -            msg(M_USAGE, "--client requires --key-method 2");
> -        }
> -
>           o->pull = true;
>           o->tls_client = true;
>       }
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index e9c01629..b96d1471 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2852,7 +2852,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
>       to.ssl_ctx = c->c1.ks.ssl_ctx;
>       to.key_type = c->c1.ks.key_type;
>       to.server = options->tls_server;
> -    to.key_method = options->key_method;
>       to.replay = options->replay;
>       to.replay_window = options->replay_window;
>       to.replay_time = options->replay_time;
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 7da04b6f..14d4c911 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -881,7 +881,6 @@ init_options(struct options *o, const bool init_gc)
>   #ifdef ENABLE_PREDICTION_RESISTANCE
>       o->use_prediction_resistance = false;
>   #endif
> -    o->key_method = 2;
>       o->tls_timeout = 2;
>       o->renegotiate_bytes = -1;
>       o->renegotiate_seconds = 3600;
> @@ -1719,7 +1718,6 @@ show_settings(const struct options *o)
>   
>       SHOW_BOOL(tls_server);
>       SHOW_BOOL(tls_client);
> -    SHOW_INT(key_method);
>       SHOW_STR_INLINE(ca_file);
>       SHOW_STR(ca_path);
>       SHOW_STR(dh_file);
> @@ -2380,10 +2378,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>           {
>               msg(M_USAGE, "--ccd-exclusive must be used with --client-config-dir");
>           }
> -        if (options->key_method != 2)
> -        {
> -            msg(M_USAGE, "--mode server requires --key-method 2");
> -        }
>           if (options->auth_token_generate && !options->renegotiate_seconds)
>           {
>               msg(M_USAGE, "--auth-gen-token needs a non-infinite "
> @@ -2550,13 +2544,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>               "may accept clients which do not present a certificate");
>       }
>   
> -    if (options->key_method == 1)
> -    {
> -        msg(M_WARN, "WARNING: --key-method 1 is deprecated and will be removed "
> -            "in OpenVPN 2.5.  By default --key-method 2 will be used if not set "
> -            "in the configuration file, which is the recommended approach.");
> -    }
> -
>       const int tls_version_max =
>           (options->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
>           & SSLF_TLS_VERSION_MAX_MASK;
> @@ -2798,7 +2785,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>           MUST_BE_UNDEF(push_peer_info);
>           MUST_BE_UNDEF(tls_exit);
>           MUST_BE_UNDEF(crl_file);
> -        MUST_BE_UNDEF(key_method);
>           MUST_BE_UNDEF(ns_cert_type);
>           MUST_BE_UNDEF(remote_cert_ku[0]);
>           MUST_BE_UNDEF(remote_cert_eku);
> @@ -3827,10 +3813,7 @@ options_string(const struct options *o,
>                * tls-auth/tls-crypt does not match.  Removing tls-auth here would
>                * break stuff, so leaving that in place. */
>   
> -            if (o->key_method > 1)
> -            {
> -                buf_printf(&out, ",key-method %d", o->key_method);
> -            }
> +            buf_printf(&out, ",key-method %d", KEY_METHOD_2);
>           }
>   
>           if (remote)
> @@ -8476,22 +8459,6 @@ add_option(struct options *options,
>           VERIFY_PERMISSION(OPT_P_GENERAL);
>           options->tls_crypt_v2_verify_script = p[1];
>       }
> -    else if (streq(p[0], "key-method") && p[1] && !p[2])
> -    {
> -        int key_method;
> -
> -        VERIFY_PERMISSION(OPT_P_GENERAL);
> -        key_method = atoi(p[1]);
> -        if (key_method < KEY_METHOD_MIN || key_method > KEY_METHOD_MAX)
> -        {
> -            msg(msglevel, "key_method parameter (%d) must be >= %d and <= %d",
> -                key_method,
> -                KEY_METHOD_MIN,
> -                KEY_METHOD_MAX);
> -            goto err;
> -        }
> -        options->key_method = key_method;
> -    }
>       else if (streq(p[0], "x509-track") && p[1] && !p[2])
>       {
>           VERIFY_PERMISSION(OPT_P_GENERAL);
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 1b038c91..3546bab3 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -572,10 +572,6 @@ struct options
>   #ifdef ENABLE_CRYPTOAPI
>       const char *cryptoapi_cert;
>   #endif
> -
> -    /* data channel key exchange method */
> -    int key_method;
> -
>       /* Per-packet timeout on control channel */
>       int tls_timeout;
>   
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 00b97352..ed35f792 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -861,23 +861,12 @@ print_key_id(struct tls_multi *multi, struct gc_arena *gc)
>   }
>   
>   bool
> -is_hard_reset(int op, int key_method)
> +is_hard_reset_method2(int op)
>   {
> -    if (!key_method || key_method == 1)
> +    if (op == P_CONTROL_HARD_RESET_CLIENT_V2 || op == P_CONTROL_HARD_RESET_SERVER_V2
> +        || op == P_CONTROL_HARD_RESET_CLIENT_V3)
>       {
> -        if (op == P_CONTROL_HARD_RESET_CLIENT_V1 || op == P_CONTROL_HARD_RESET_SERVER_V1)
> -        {
> -            return true;
> -        }
> -    }
> -
> -    if (!key_method || key_method >= 2)
> -    {
> -        if (op == P_CONTROL_HARD_RESET_CLIENT_V2 || op == P_CONTROL_HARD_RESET_SERVER_V2
> -            || op == P_CONTROL_HARD_RESET_CLIENT_V3)
> -        {
> -            return true;
> -        }
> +        return true;
>       }
>   
>       return false;
> @@ -1097,23 +1086,14 @@ tls_session_init(struct tls_multi *multi, struct tls_session *session)
>       }
>   
>       /* Are we a TLS server or client? */
> -    ASSERT(session->opt->key_method >= 1);
> -    if (session->opt->key_method == 1)
> +    if (session->opt->server)
>       {
> -        session->initial_opcode = session->opt->server ?
> -                                  P_CONTROL_HARD_RESET_SERVER_V1 : P_CONTROL_HARD_RESET_CLIENT_V1;
> +        session->initial_opcode = P_CONTROL_HARD_RESET_SERVER_V2;
>       }
> -    else /* session->opt->key_method >= 2 */
> +    else
>       {
> -        if (session->opt->server)
> -        {
> -            session->initial_opcode = P_CONTROL_HARD_RESET_SERVER_V2;
> -        }
> -        else
> -        {
> -            session->initial_opcode = session->opt->tls_crypt_v2 ?
> -                                      P_CONTROL_HARD_RESET_CLIENT_V3 : P_CONTROL_HARD_RESET_CLIENT_V2;
> -        }
> +        session->initial_opcode = session->opt->tls_crypt_v2 ?
> +                                  P_CONTROL_HARD_RESET_CLIENT_V3 : P_CONTROL_HARD_RESET_CLIENT_V2;
>       }
>   
>       /* Initialize control channel authentication parameters */
> @@ -2225,52 +2205,6 @@ read_string_alloc(struct buffer *buf)
>       return str;
>   }
>   
> -/*
> - * Handle the reading and writing of key data to and from
> - * the TLS control channel (cleartext).
> - */
> -
> -static bool
> -key_method_1_write(struct buffer *buf, struct tls_session *session)
> -{
> -    struct key key;
> -    struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
> -
> -    ASSERT(session->opt->key_method == 1);
> -    ASSERT(buf_init(buf, 0));
> -
> -    generate_key_random(&key, &session->opt->key_type);
> -    if (!check_key(&key, &session->opt->key_type))
> -    {
> -        msg(D_TLS_ERRORS, "TLS Error: Bad encrypting key generated");
> -        return false;
> -    }
> -
> -    if (!write_key(&key, &session->opt->key_type, buf))
> -    {
> -        msg(D_TLS_ERRORS, "TLS Error: write_key failed");
> -        return false;
> -    }
> -
> -    init_key_ctx(&ks->crypto_options.key_ctx_bi.encrypt, &key,
> -                 &session->opt->key_type, OPENVPN_OP_ENCRYPT,
> -                 "Data Channel Encrypt");
> -    secure_memzero(&key, sizeof(key));
> -
> -    /* send local options string */
> -    {
> -        const char *local_options = local_options_string(session);
> -        const int optlen = strlen(local_options) + 1;
> -        if (!buf_write(buf, local_options, optlen))
> -        {
> -            msg(D_TLS_ERRORS, "TLS Error: KM1 write options failed");
> -            return false;
> -        }
> -    }
> -
> -    return true;
> -}
> -
>   static bool
>   push_peer_info(struct buffer *buf, struct tls_session *session)
>   {
> @@ -2312,7 +2246,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
>            * push request, also signal that the client wants
>            * to get push-reply messages without without requiring a round
>            * trip for a push request message*/
> -        if(session->opt->pull)
> +        if (session->opt->pull)
>           {
>               iv_proto |= IV_PROTO_REQUEST_PUSH;
>           }
> @@ -2389,12 +2323,15 @@ error:
>       return ret;
>   }
>   
> +/**
> + * Handle the writing of key data, peer-info, username/password, OCC
> + * to the TLS control channel (cleartext).
> + */
>   static bool
>   key_method_2_write(struct buffer *buf, struct tls_session *session)
>   {
>       struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
>   
> -    ASSERT(session->opt->key_method == 2);
>       ASSERT(buf_init(buf, 0));
>   
>       /* write a uint32 0 */
> @@ -2404,7 +2341,7 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
>       }
>   
>       /* write key_method + flags */
> -    if (!buf_write_u8(buf, (session->opt->key_method & KEY_METHOD_MASK)))
> +    if (!buf_write_u8(buf, KEY_METHOD_2))
>       {
>           goto error;
>       }
> @@ -2506,73 +2443,15 @@ error:
>       return false;
>   }
>   
> -static bool
> -key_method_1_read(struct buffer *buf, struct tls_session *session)
> -{
> -    int status;
> -    struct key key;
> -    struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
> -
> -    ASSERT(session->opt->key_method == 1);
> -
> -    if (!session->verified)
> -    {
> -        msg(D_TLS_ERRORS,
> -            "TLS Error: Certificate verification failed (key-method 1)");
> -        goto error;
> -    }
> -
> -    status = read_key(&key, &session->opt->key_type, buf);
> -    if (status != 1)
> -    {
> -        msg(D_TLS_ERRORS,
> -            "TLS Error: Error reading data channel key from plaintext buffer");
> -        goto error;
> -    }
> -
> -    if (!check_key(&key, &session->opt->key_type))
> -    {
> -        msg(D_TLS_ERRORS, "TLS Error: Bad decrypting key received from peer");
> -        goto error;
> -    }
> -
> -    if (buf->len < 1)
> -    {
> -        msg(D_TLS_ERRORS, "TLS Error: Missing options string");
> -        goto error;
> -    }
> -
> -#ifdef ENABLE_OCC
> -    /* compare received remote options string
> -     * with our locally computed options string */
> -    if (!session->opt->disable_occ
> -        && !options_cmp_equal_safe((char *) BPTR(buf), session->opt->remote_options, buf->len))
> -    {
> -        options_warning_safe((char *) BPTR(buf), session->opt->remote_options, buf->len);
> -    }
> -#endif
> -
> -    buf_clear(buf);
> -
> -    init_key_ctx(&ks->crypto_options.key_ctx_bi.decrypt, &key,
> -                 &session->opt->key_type, OPENVPN_OP_DECRYPT,
> -                 "Data Channel Decrypt");
> -    secure_memzero(&key, sizeof(key));
> -    ks->authenticated = KS_AUTH_TRUE;
> -    return true;
> -
> -error:
> -    buf_clear(buf);
> -    secure_memzero(&key, sizeof(key));
> -    return false;
> -}
> -
> +/**
> + * Handle reading key data, peer-info, username/password, OCC
> + * from the TLS control channel (cleartext).
> + */
>   static bool
>   key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_session *session)
>   {
>       struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
>   
> -    int key_method_flags;
>       bool username_status, password_status;
>   
>       struct gc_arena gc = gc_new();
> @@ -2582,8 +2461,6 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>       /* allocate temporary objects */
>       ALLOC_ARRAY_CLEAR_GC(options, char, TLS_OPTIONS_LEN, &gc);
>   
> -    ASSERT(session->opt->key_method == 2);
> -
>       /* discard leading uint32 */
>       if (!buf_advance(buf, 4))
>       {
> @@ -2593,7 +2470,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>       }
>   
>       /* get key method */
> -    key_method_flags = buf_read_u8(buf);
> +    int key_method_flags = buf_read_u8(buf);
>       if ((key_method_flags & KEY_METHOD_MASK) != 2)
>       {
>           msg(D_TLS_ERRORS,
> @@ -3003,23 +2880,9 @@ tls_process(struct tls_multi *multi,
>           if (!buf->len && ((ks->state == S_START && !session->opt->server)
>                             || (ks->state == S_GOT_KEY && session->opt->server)))
>           {
> -            if (session->opt->key_method == 1)
> -            {
> -                if (!key_method_1_write(buf, session))
> -                {
> -                    goto error;
> -                }
> -            }
> -            else if (session->opt->key_method == 2)
> -            {
> -                if (!key_method_2_write(buf, session))
> -                {
> -                    goto error;
> -                }
> -            }
> -            else
> +            if (!key_method_2_write(buf, session))
>               {
> -                ASSERT(0);
> +                goto error;
>               }
>   
>               state_change = true;
> @@ -3033,23 +2896,9 @@ tls_process(struct tls_multi *multi,
>               && ((ks->state == S_SENT_KEY && !session->opt->server)
>                   || (ks->state == S_START && session->opt->server)))
>           {
> -            if (session->opt->key_method == 1)
> -            {
> -                if (!key_method_1_read(buf, session))
> -                {
> -                    goto error;
> -                }
> -            }
> -            else if (session->opt->key_method == 2)
> -            {
> -                if (!key_method_2_read(buf, multi, session))
> -                {
> -                    goto error;
> -                }
> -            }
> -            else
> +            if (!key_method_2_read(buf, multi, session))
>               {
> -                ASSERT(0);
> +                goto error;
>               }
>   
>               state_change = true;
> @@ -3463,6 +3312,11 @@ tls_pre_decrypt(struct tls_multi *multi,
>               /* verify legal opcode */
>               if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
>               {
> +                if (op == P_CONTROL_HARD_RESET_CLIENT_V1
> +                    || op == P_CONTROL_HARD_RESET_SERVER_V1)
> +                {
> +                    msg(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
> +                }
>                   msg(D_TLS_ERRORS,
>                       "TLS Error: unknown opcode received from %s op=%d",
>                       print_link_socket_actual(from, &gc), op);
> @@ -3470,14 +3324,12 @@ tls_pre_decrypt(struct tls_multi *multi,
>               }
>   
>               /* hard reset ? */
> -            if (is_hard_reset(op, 0))
> +            if (is_hard_reset_method2(op))
>               {
>                   /* verify client -> server or server -> client connection */
> -                if (((op == P_CONTROL_HARD_RESET_CLIENT_V1
> -                      || op == P_CONTROL_HARD_RESET_CLIENT_V2
> +                if (((op == P_CONTROL_HARD_RESET_CLIENT_V2
>                         || op == P_CONTROL_HARD_RESET_CLIENT_V3) && !multi->opt.server)
> -                    || ((op == P_CONTROL_HARD_RESET_SERVER_V1
> -                         || op == P_CONTROL_HARD_RESET_SERVER_V2) && multi->opt.server))
> +                    || ((op == P_CONTROL_HARD_RESET_SERVER_V2) && multi->opt.server))
>                   {
>                       msg(D_TLS_ERRORS,
>                           "TLS Error: client->client or server->server connection attempted from %s",
> @@ -3539,22 +3391,14 @@ tls_pre_decrypt(struct tls_multi *multi,
>               }
>   
>               /*
> -             * Initial packet received.
> +             * Hard reset and session id does not match any session in
> +             * multi->session: Possible initial packet
>                */
> -
> -            if (i == TM_SIZE && is_hard_reset(op, 0))
> +            if (i == TM_SIZE && is_hard_reset_method2(op))
>               {
>                   struct tls_session *session = &multi->session[TM_ACTIVE];
>                   struct key_state *ks = &session->key[KS_PRIMARY];
>   
> -                if (!is_hard_reset(op, multi->opt.key_method))
> -                {
> -                    msg(D_TLS_ERRORS, "TLS ERROR: initial packet local/remote key_method mismatch, local key_method=%d, op=%s",
> -                        multi->opt.key_method,
> -                        packet_opcode_name(op));
> -                    goto error;
> -                }
> -
>                   /*
>                    * If we have no session currently in progress, the initial packet will
>                    * open a new session in TM_ACTIVE rather than TM_UNTRUSTED.
> @@ -3594,7 +3438,11 @@ tls_pre_decrypt(struct tls_multi *multi,
>                   }
>               }
>   
> -            if (i == TM_SIZE && is_hard_reset(op, 0))
> +            /*
> +             * If we detected new session in the last if block, i has

block, i has ->
block, it has


> +             * changed to TM_ACTIVE, so check the condition again.
> +             */
> +            if (i == TM_SIZE && is_hard_reset_method2(op))
>               {
>                   /*
>                    * No match with existing sessions,
> @@ -3614,14 +3462,6 @@ tls_pre_decrypt(struct tls_multi *multi,
>                       goto error;
>                   }
>   
> -                if (!is_hard_reset(op, multi->opt.key_method))
> -                {
> -                    msg(D_TLS_ERRORS, "TLS ERROR: new session local/remote key_method mismatch, local key_method=%d, op=%s",
> -                        multi->opt.key_method,
> -                        packet_opcode_name(op));
> -                    goto error;
> -                }
> -
>                   if (!read_control_auth(buf, &session->tls_wrap, from,
>                                          session->opt))
>                   {
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index 81f8810e..4f4f4bd5 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -66,8 +66,10 @@
>   /* indicates key_method >= 2 and client-specific tls-crypt key */
>   #define P_CONTROL_HARD_RESET_CLIENT_V3 10    /* initial key from client, forget previous state */
>   
> -/* define the range of legal opcodes */
> -#define P_FIRST_OPCODE                 1
> +/* define the range of legal opcodes
> + * Since we do no longer support key-method 1 we consider
> + * the v1 op codes invalid */
> +#define P_FIRST_OPCODE                 3
>   #define P_LAST_OPCODE                  10
>   
>   /*
> @@ -118,11 +120,7 @@
>   /* Default field in X509 to be username */
>   #define X509_USERNAME_FIELD_DEFAULT "CN"
>   
> -/*
> - * Range of key exchange methods
> - */
> -#define KEY_METHOD_MIN 1
> -#define KEY_METHOD_MAX 2
> +#define KEY_METHOD_2  2
>   
>   /* key method taken from lower 4 bits */
>   #define KEY_METHOD_MASK 0x0F
> @@ -594,12 +592,11 @@ void show_tls_performance_stats(void);
>   void extract_x509_field_test(void);
>   
>   /**
> - * Given a key_method, return true if opcode represents the required form of
> - * hard_reset.
> + * Given a key_method, return true if opcode represents the one of the
> + * hard_reset op codes for key-method 2
>    *
> - * If key_method == 0, return true if any form of hard reset is used.
>    */
> -bool is_hard_reset(int op, int key_method);
> +bool is_hard_reset_method2(int op);
>   
>   void delayed_auth_pass_purge(void);
>   
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index e0b3ee56..d904c31f 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -262,7 +262,6 @@ struct tls_options
>   #endif
>   
>       /* from command line */
> -    int key_method;
>       bool replay;
>       bool single_session;
>   #ifdef ENABLE_OCC
> 

