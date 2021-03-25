References: <20210325000121.10331-1-arne@...1227...>
 <20210325000121.10331-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b418f610-6e7e-ba3c-8c30-6e0ef0c50fa5@...2181...>
Date: Fri, 26 Mar 2021 00:12:40 +0100
MIME-Version: 1.0
In-Reply-To: <20210325000121.10331-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/2] Remove deprecated option '--keysize'
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 25/03/2021 01:01, Arne Schwabe wrote:
> This option has been deprecated in OpenVPN 2.4 and the ciphers that allow
> using this option fall all into the SWEET32 category of ciphers with
> 64 bit block size.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  config-msvc.h                |  1 -
>  configure.ac                 |  2 +-
>  src/openvpn/crypto.c         |  6 +-----
>  src/openvpn/crypto.h         |  4 +---
>  src/openvpn/crypto_openssl.c |  4 ++--
>  src/openvpn/init.c           |  5 ++---
>  src/openvpn/options.c        | 33 ++-------------------------------
>  src/openvpn/options.h        |  2 --
>  src/openvpn/ssl.c            |  7 +------
>  9 files changed, 10 insertions(+), 54 deletions(-)
> 
> diff --git a/config-msvc.h b/config-msvc.h
> index e430ca96..d0aa4438 100644
> --- a/config-msvc.h
> +++ b/config-msvc.h
> @@ -49,7 +49,6 @@
>  #define HAVE_CHSIZE 1
>  #define HAVE_CPP_VARARG_MACRO_ISO 1
>  #define HAVE_CTIME 1
> -#define HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH 1
>  #define HAVE_IN_PKTINFO 1
>  #define HAVE_MEMSET 1
>  #define HAVE_PUTENV 1
> diff --git a/configure.ac b/configure.ac
> index 428bebed..bd592b3f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -881,7 +881,7 @@ if test "${with_crypto_library}" = "openssl"; then
>  		)
>  	fi
>  
> -	AC_CHECK_FUNCS([SSL_CTX_new EVP_CIPHER_CTX_set_key_length],
> +	AC_CHECK_FUNCS([SSL_CTX_new],
>  				   ,
>  				   [AC_MSG_ERROR([openssl check failed])]
>  	)
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 3a0bfbec..b042514b 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -739,7 +739,7 @@ warn_insecure_key_type(const char *ciphername, const cipher_kt_t *cipher)
>   */
>  void
>  init_key_type(struct key_type *kt, const char *ciphername,
> -              const char *authname, int keysize, bool tls_mode, bool warn)
> +              const char *authname, bool tls_mode, bool warn)
>  {
>      bool aead_cipher = false;
>  
> @@ -756,10 +756,6 @@ init_key_type(struct key_type *kt, const char *ciphername,
>          }
>  
>          kt->cipher_length = cipher_kt_key_size(kt->cipher);
> -        if (keysize > 0 && keysize <= MAX_CIPHER_KEY_LENGTH)
> -        {
> -            kt->cipher_length = keysize;
> -        }
>  
>          /* check legal cipher mode */
>          aead_cipher = cipher_kt_mode_aead(kt->cipher);
> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index 1ad669ce..b8128c7f 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -301,14 +301,12 @@ int read_key(struct key *key, const struct key_type *kt, struct buffer *buf);
>   * @param kt          The struct key_type to initialize
>   * @param ciphername  The name of the cipher to use
>   * @param authname    The name of the HMAC digest to use
> - * @param keysize     The length of the cipher key to use, in bytes.  Only valid
> - *                    for ciphers that support variable length keys.
>   * @param tls_mode    Specifies whether we are running in TLS mode, which allows
>   *                    more ciphers than static key mode.
>   * @param warn        Print warnings when null cipher / auth is used.
>   */
>  void init_key_type(struct key_type *kt, const char *ciphername,
> -                   const char *authname, int keysize, bool tls_mode, bool warn);
> +                   const char *authname, bool tls_mode, bool warn);
>  
>  /*
>   * Key context functions
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 573beaed..34decbb0 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -776,12 +776,12 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key, int key_len,
>      {
>          crypto_msg(M_FATAL, "EVP cipher init #1");
>      }
> -#ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
> +    /* This serves as a check that the keylen is the correct as this fails
> +     * when key_len and the fixed size of cipher disagree */
>      if (!EVP_CIPHER_CTX_set_key_length(ctx, key_len))

Are you sure we need to keep this check?

key_len is basically kt->cipher_length, which (after his patch) is
assigned by the SSL library itself after having initialized the cipher.

At a first glance, the rest looks good to me.

Cheers,

>      {
>          crypto_msg(M_FATAL, "EVP set key size");
>      }
> -#endif
>      if (!EVP_CipherInit_ex(ctx, NULL, NULL, key, NULL, enc))
>      {
>          crypto_msg(M_FATAL, "EVP cipher init #2");
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 132d47e4..336da941 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2599,7 +2599,7 @@ do_init_crypto_static(struct context *c, const unsigned int flags)
>      {
>          /* Get cipher & hash algorithms */
>          init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
> -                      options->keysize, options->test_crypto, true);
> +                      options->test_crypto, true);
>  
>          /* Read cipher and hmac keys from shared secret file */
>          crypto_read_openvpn_key(&c->c1.ks.key_type, &c->c1.ks.static_key,
> @@ -2751,7 +2751,7 @@ do_init_crypto_tls_c1(struct context *c)
>               || options->enable_ncp_fallback;
>          /* Get cipher & hash algorithms */
>          init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
> -                      options->keysize, true, warn);
> +                      true, warn);
>  
>          /* Initialize PRNG with config-specified digest */
>          prng_init(options->prng_hash, options->prng_nonce_secret_len);
> @@ -4515,7 +4515,6 @@ inherit_context_child(struct context *dest,
>      /* inherit pre-NCP ciphers */
>      dest->options.ciphername = src->options.ciphername;
>      dest->options.authname = src->options.authname;
> -    dest->options.keysize = src->options.keysize;
>  
>      /* inherit auth-token */
>      dest->c1.ks.auth_token_key = src->c1.ks.auth_token_key;
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 5b559edf..7948f4a5 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -531,10 +531,6 @@ static const char usage_message[] =
>      "--ncp-disable   : (DEPRECATED) Disable cipher negotiation.\n"
>      "--prng alg [nsl] : For PRNG, use digest algorithm alg, and\n"
>      "                   nonce_secret_len=nsl.  Set alg=none to disable PRNG.\n"
> -#ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
> -    "--keysize n     : (DEPRECATED) Size of cipher key in bits (optional).\n"
> -    "                  If unspecified, defaults to cipher-specific default.\n"
> -#endif
>  #ifndef ENABLE_CRYPTO_MBEDTLS
>      "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
>  #endif
> @@ -1733,7 +1729,6 @@ show_settings(const struct options *o)
>      SHOW_STR(authname);
>      SHOW_STR(prng_hash);
>      SHOW_INT(prng_nonce_secret_len);
> -    SHOW_INT(keysize);
>  #ifndef ENABLE_CRYPTO_MBEDTLS
>      SHOW_BOOL(engine);
>  #endif /* ENABLE_CRYPTO_MBEDTLS */
> @@ -2540,11 +2535,6 @@ options_postprocess_verify_ce(const struct options *options,
>          }
>      }
>  
> -    if (options->keysize)
> -    {
> -        msg(M_WARN, "WARNING: --keysize is DEPRECATED and will be removed in OpenVPN 2.6");
> -    }
> -
>      /*
>       * Check consistency of replay options
>       */
> @@ -3619,7 +3609,6 @@ pre_pull_save(struct options *o)
>          /* NCP related options that can be overwritten by a push */
>          o->pre_pull->ciphername = o->ciphername;
>          o->pre_pull->authname = o->authname;
> -        o->pre_pull->keysize = o->keysize;
>  
>          /* Ping related options should be reset to the config values on reconnect */
>          o->pre_pull->ping_rec_timeout = o->ping_rec_timeout;
> @@ -3675,7 +3664,6 @@ pre_pull_restore(struct options *o, struct gc_arena *gc)
>  
>          o->ciphername = pp->ciphername;
>          o->authname = pp->authname;
> -        o->keysize = pp->keysize;
>  
>          o->ping_rec_timeout = pp->ping_rec_timeout;
>          o->ping_rec_timeout_action = pp->ping_rec_timeout_action;
> @@ -3704,8 +3692,7 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
>      {
>          struct frame fake_frame = *frame;
>          struct key_type fake_kt;
> -        init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
> -                      false);
> +        init_key_type(&fake_kt, o->ciphername, o->authname, true, false);
>          frame_remove_from_extra_frame(&fake_frame, crypto_max_overhead());
>          crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
>                                         cipher_kt_mode_ofb_cfb(fake_kt.cipher));
> @@ -3876,8 +3863,7 @@ options_string(const struct options *o,
>                 + (TLS_SERVER == true)
>                 <= 1);
>  
> -        init_key_type(&kt, o->ciphername, o->authname, o->keysize, true,
> -                      false);
> +        init_key_type(&kt, o->ciphername, o->authname, true, false);
>          /* Only announce the cipher to our peer if we are willing to
>           * support it */
>          const char *ciphername = cipher_kt_name(kt.cipher);
> @@ -8087,21 +8073,6 @@ add_option(struct options *options,
>          }
>      }
>  #endif /* ENABLE_CRYPTO_MBEDTLS */
> -#ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
> -    else if (streq(p[0], "keysize") && p[1] && !p[2])
> -    {
> -        int keysize;
> -
> -        VERIFY_PERMISSION(OPT_P_NCP);
> -        keysize = atoi(p[1]) / 8;
> -        if (keysize < 0 || keysize > MAX_CIPHER_KEY_LENGTH)
> -        {
> -            msg(msglevel, "Bad keysize: %s", p[1]);
> -            goto err;
> -        }
> -        options->keysize = keysize;
> -    }
> -#endif
>  #ifdef ENABLE_PREDICTION_RESISTANCE
>      else if (streq(p[0], "use-prediction-resistance") && !p[1])
>      {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index d8e91fbc..5e924e1b 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -77,7 +77,6 @@ struct options_pre_pull
>  
>      const char* ciphername;
>      const char* authname;
> -    int keysize;
>  
>      int ping_send_timeout;
>      int ping_rec_timeout;
> @@ -521,7 +520,6 @@ struct options
>      bool ncp_enabled;
>      const char *ncp_ciphers;
>      const char *authname;
> -    int keysize;
>      const char *prng_hash;
>      int prng_nonce_secret_len;
>      const char *engine;
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 0daf19ad..d288d207 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1874,11 +1874,6 @@ tls_session_update_crypto_params(struct tls_session *session,
>      {
>          msg(D_HANDSHAKE, "Data Channel: using negotiated cipher '%s'",
>              options->ciphername);
> -        if (options->keysize)
> -        {
> -            msg(D_HANDSHAKE, "NCP: overriding user-set keysize with default");
> -            options->keysize = 0;
> -        }
>      }
>      else
>      {
> @@ -1889,7 +1884,7 @@ tls_session_update_crypto_params(struct tls_session *session,
>      }
>  
>      init_key_type(&session->opt->key_type, options->ciphername,
> -                  options->authname, options->keysize, true, true);
> +                  options->authname, true, true);
>  
>      bool packet_id_long_form = cipher_kt_mode_ofb_cfb(session->opt->key_type.cipher);
>      session->opt->crypto_flags &= ~(CO_PACKET_ID_LONG_FORM);
> 

-- 
Antonio Quartulli

