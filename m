References: <20200328040858.16505-1-arne@...1227...>
 <20200401102159.29157-1-arne@...1227...>
 <20200401102159.29157-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <57775d47-ddd4-0581-aeaa-294c148a77fc@...2181...>
Date: Thu, 16 Apr 2020 00:31:47 +0200
MIME-Version: 1.0
In-Reply-To: <20200401102159.29157-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/3] Implement tls-groups option to
 specify eliptic curves/groups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

this patch looks pretty simple and easy to digest.

However, there are several style things which are odd. See below:

On 01/04/2020 12:21, Arne Schwabe wrote:
> OpenSSL 1.1+ by default only allows signatures and key exchange from the
> default list of X25519:secp256r1:X448:secp521r1:secp384r1. Since in
> TLS1.3 key exchange is independent from the signature/key of the
> certificates, allowing all groups per default is not a sensible choice
> anymore and the shorter lister is reasonable.
> 
> However, when using certificates with exotic curves the signatures of
> this certificates will no longer be accepted. This option allows to
> modify the list for these corner cases.

there are some errors in the commit message, but they can probably be
fixed at merge time.


> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  README.ec                    |   7 +--
>  doc/openvpn.8                |  37 +++++++++++--
>  src/openvpn/openssl_compat.h |   4 ++
>  src/openvpn/options.c        |  10 +++-
>  src/openvpn/options.h        |   1 +
>  src/openvpn/ssl.c            |   6 +++
>  src/openvpn/ssl_backend.h    |  10 ++++
>  src/openvpn/ssl_mbedtls.c    |  47 ++++++++++++++++
>  src/openvpn/ssl_mbedtls.h    |   1 +
>  src/openvpn/ssl_openssl.c    | 101 +++++++++++++++++++++++++++--------
>  10 files changed, 194 insertions(+), 30 deletions(-)
> 
> diff --git a/README.ec b/README.ec
> index 32938017..2f830972 100644
> --- a/README.ec
> +++ b/README.ec
> @@ -12,14 +12,15 @@ OpenVPN 2.4.0 and newer automatically initialize ECDH parameters. When ECDSA is
>  used for authentication, the curve used for the server certificate will be used
>  for ECDH too. When autodetection fails (e.g. when using RSA certificates)
>  OpenVPN lets the crypto library decide if possible, or falls back to the
> -secp384r1 curve.
> +secp384r1 curve. The list of groups/curves that the crypto library will choose
> +from can be set with the --tls-groups <grouplist> configuration.
>  
>  An administrator can force an OpenVPN/OpenSSL server to use a specific curve
>  using the --ecdh-curve <curvename> option with one of the curves listed as
> -available by the --show-curves option. Clients will use the same curve as
> +available by the --show-groups option. Clients will use the same curve as
>  selected by the server.
>  
> -Note that not all curves listed by --show-curves are available for use with TLS;
> +Note that not all curves listed by --show-groups are available for use with TLS;
>  in that case connecting will fail with a 'no shared cipher' TLS error.
>  
>  Authentication (ECDSA)
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index c5b16981..4897fbdb 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5084,11 +5084,11 @@ simply supplied to the crypto library.  Please see the OpenSSL and/or mbed TLS
>  documentation for details on the cipher list interpretation.
>  
>  For OpenSSL, the
> -.B \-\-tls-cipher
> +.B \-\-tls\-cipher

Why not fixing these issues in a separate patch? (my opinion)

>  is used for TLS 1.2 and below. For TLS 1.3 and up, the
>  .B \-\-tls\-ciphersuites
>  setting is used. mbed TLS has no TLS 1.3 support yet and only the
> -.B \-\-tls-cipher
> +.B \-\-tls\-cipher

same

>  setting is used.
>  
>  Use
> @@ -5096,6 +5096,8 @@ Use
>  to see a list of TLS ciphers supported by your crypto library.
>  
>  Warning!
> +.B \-\-tls\-groups
> +,
>  .B \-\-tls\-cipher
>  and
>  .B \-\-tls\-ciphersuites
> @@ -5111,6 +5113,33 @@ OpenSSL.
>  The default for \-\-tls\-ciphersuites is to use the crypto library's default.
>  .\"*********************************************************
>  .TP
> +.B \-\-tls\-groups l
> +A list
> +.B l
> +of allowable groups/curves in order of preference.
> +
> +Set the allowed elictipic curves/groups for the TLS session.

                       ^^ typ0

> +These groups are  allowed to be used in signatures and key exchange.
> +
> +mbed TLS currently allows all known curves per default.
> +
> +OpenSSL 1.1+ restricts the list per default to
> +"X25519:secp256r1:X448:secp521r1:secp384r1".
> +
> +If you use certificates that use non-standard curves, you
> +might need to add them here. If you do not force the ecdh curve
> +by using
> +.B \-\-ecdh\-curve
> +, the groups for ecdh will also be picked from this list.
> +
> +OpenVPN maps the curve name secp256r1 to prime256v1 to allow
> +specifying the tls-groups option for mbed TLS and OpenSSL.
> +
> +Warning: this option not only affects eliptic curve certificates
> +but also the key exchange in TLS 1.3 and using this option improperly
> +will disable TLS 1.3.
> +.\"*********************************************************
> +.TP
>  .B \-\-tls\-cert\-profile profile
>  Set the allowed cryptographic algorithms for certificates according to
>  .B profile\fN.
> @@ -5876,8 +5905,10 @@ engines supported by the OpenSSL library.
>  .TP
>  .B \-\-show\-curves
>  (Standalone)
> -Show all available elliptic curves to use with the
> +Show all available elliptic groups/curves to use with the
>  .B \-\-ecdh\-curve
> +and
> +.B \-\-tls\-groups
>  option.
>  .\"*********************************************************
>  .SS Generating key material:
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 4ac8f24d..352e79f9 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -807,4 +807,8 @@ SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
>  }
>  #endif /* SSL_CTX_set_max_proto_version */
>  
> +#ifndef SSL_CTX_set1_groups
> +#define SSL_CTX_set1_groups SSL_CTX_set1_curves
> +#endif
> +
>  #endif /* OPENSSL_COMPAT_H_ */
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 5127f653..88f4051e 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -7894,7 +7894,7 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_GENERAL);
>          options->show_tls_ciphers = true;
>      }
> -    else if (streq(p[0], "show-curves") && !p[1])
> +    else if ((streq(p[0], "show-curves") || streq(p[0], "show-groups")) && !p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
>          options->show_curves = true;
> @@ -7902,6 +7902,9 @@ add_option(struct options *options,
>      else if (streq(p[0], "ecdh-curve") && p[1] && !p[2])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> +        msg(M_WARN, "Consider setting groups/curves in preference with "
                                                       ^ I'd remove 'in'
> +            "tls-groups instead of forcing a specific curve with "
> +            "ecdh-curve.");
>          options->ecdh_curve = p[1];
>      }
>      else if (streq(p[0], "tls-server") && !p[1])
> @@ -8090,6 +8093,11 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_GENERAL);
>          options->cipher_list_tls13 = p[1];
>      }
> +    else if (streq(p[0], "tls-groups") && p[1] && !p[2])
> +    {
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +        options->tls_groups = p[1];
> +    }
>      else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
>                                                     || (p[2] && streq(p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
>      {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 2f1f6faf..3732a3a5 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -537,6 +537,7 @@ struct options
>      const char *pkcs12_file;
>      const char *cipher_list;
>      const char *cipher_list_tls13;
> +    const char *tls_groups;
>      const char *tls_cert_profile;
>      const char *ecdh_curve;
>      const char *tls_verify;
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index e21279f1..8bd1c86a 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -630,6 +630,12 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
>      tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
>      tls_ctx_restrict_ciphers_tls13(new_ctx, options->cipher_list_tls13);
>  
> +    /* Set the allow groups/curves for TLS if we want to override them */
> +    if (options->tls_groups)
> +    {
> +        tls_ctx_set_tls_groups(new_ctx, options->tls_groups);
> +    }
> +
>      if (!tls_ctx_set_options(new_ctx, options->ssl_flags))
>      {
>          goto err;
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index 1c244ece..d95e8320 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -198,6 +198,16 @@ void tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *cipher
>   */
>  void tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile);
>  
> +/**
> + * Set the allowed (eliptic curve) group allowed for signatures and
> + * key exchange.
> + *
> + * @param ctx       TLS context to restrict, must be valid.
> + * @param groups    List of groups that will be allowed, in priority,
> + *                  separated by :
> + */
> +void tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups);
> +
>  /**
>   * Check our certificate notBefore and notAfter fields, and warn if the cert is
>   * either not yet valid or has expired.  Note that this is a non-fatal error,
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 0e17e734..9ce68275 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -176,6 +176,11 @@ tls_ctx_free(struct tls_root_ctx *ctx)
>              free(ctx->allowed_ciphers);
>          }
>  
> +        if (ctx->groups)
> +        {
> +            free(ctx->groups);
> +        }
> +
>          CLEAR(*ctx);
>  
>          ctx->initialised = false;
> @@ -342,6 +347,43 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
>      }
>  }
>  
> +void
> +tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
> +{
> +    ASSERT(NULL != ctx);

elsewhere (i.e. later in this patch) you use the style ASSERT(cts) - I
suggest to do the same here.

> +
> +    /* Get number of groups */
> +    int groups_count = get_num_elements(groups, ':');
> +
> +    /* Allocate an array for them */
> +    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_ecp_group_id, groups_count + 1)
> +
> +    /* Parse allowed ciphers, getting IDs */
> +    int i = 0;
> +    char *tmp_groups_orig = string_alloc(groups, NULL);

is it really important to clone "groups" ? why just not chopping it ?
It shouldn't be re-used any more I think.


If we really really need to alloc this memory, can't we get a gc from
outside? maybe from the option parser? We normally avoid explicit
alloc/free in the code.

> +    char *tmp_groups = tmp_groups_orig;
> +
> +    const char *token = strsep(&tmp_groups, ":");
> +    while (token)
> +    {
> +        const mbedtls_ecp_curve_info *ci =
> +            mbedtls_ecp_curve_info_from_name(token);
> +        if (ci == NULL)

we normally just use the style "if (a)" - I suggest to do the same here

> +        {
> +            msg(M_WARN, "Warning unknown curve/group specified: %s", token);
> +        }
> +        else
> +        {
> +            ctx->groups[i] = ci->grp_id;
> +            i++;
> +        }
> +        token = strsep(&tmp_groups, ":");
> +    }
> +    ctx->groups[i] = MBEDTLS_ECP_DP_NONE;
> +    free(tmp_groups_orig);
> +}
> +
> +
>  void
>  tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
>  {
> @@ -1042,6 +1084,11 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
>          mbedtls_ssl_conf_ciphersuites(&ks_ssl->ssl_config, ssl_ctx->allowed_ciphers);
>      }
>  
> +    if (ssl_ctx->groups)
> +    {
> +        mbedtls_ssl_conf_curves(&ks_ssl->ssl_config, ssl_ctx->groups);
> +    }
> +
>      /* Disable record splitting (for now).  OpenVPN assumes records are sent
>       * unfragmented, and changing that will require thorough review and
>       * testing.  Since OpenVPN is not susceptible to BEAST, we can just
> diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
> index c1c676dc..d8c366e7 100644
> --- a/src/openvpn/ssl_mbedtls.h
> +++ b/src/openvpn/ssl_mbedtls.h
> @@ -105,6 +105,7 @@ struct tls_root_ctx {
>  #endif
>      struct external_context external_key; /**< External key context */
>      int *allowed_ciphers;       /**< List of allowed ciphers for this connection */
> +    mbedtls_ecp_group_id *groups;                /**< List of allowed groups for this connection */
>      mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate types */
>  };
>  
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 4b5ca214..8c04986c 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -557,6 +557,59 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
>  #endif /* ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
>  }
>  
> +void
> +tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
> +{
> +    ASSERT(ctx);
> +    /* This method could be as easy as
> +     *  SSL_CTX_set1_groups_list(ctx->ctx, groups)
> +     * but OpenSSL does not like the name secp256r1 for prime256v1
> +     * and as this is one of the more important curve to have
                                    ^^^ most
> +     * the same name for OpenSSL and mbedTLS, we do this dance

maybe this last sentence could re-arranged a bit ?

> +     */
> +
> +    int groups_count = get_num_elements(groups, ':');
> +
> +    int *glist;
> +    /* Allocate an array for them */

this comment is a bit useless, no ? :D

> +    ALLOC_ARRAY_CLEAR(glist, int, groups_count);
> +
> +    /* Parse allowed ciphers, getting IDs */
> +    int glistlen = 0;
> +    char *tmp_groups_orig = string_alloc(groups, NULL);
> +    char *tmp_groups = tmp_groups_orig;
> +
> +    const char *token = strsep(&tmp_groups, ":");
> +    while (token)
> +    {
> +        if (streq(token, "secp256r1"))
> +        {
> +            token = "prime256v1";
> +        }
> +        int nid = OBJ_sn2nid(token);
> +
> +        if (nid == 0)
> +        {
> +            msg(M_WARN, "Warning unknown curve/group specified: %s", token);
> +        }
> +        else
> +        {
> +            glist[glistlen] = nid;
> +            glistlen++;
> +        }
> +        token = strsep(&tmp_groups, ":");
> +    }
> +    free(tmp_groups_orig);
> +
> +    if (!SSL_CTX_set1_groups(ctx->ctx, glist, glistlen))
> +    {
> +        crypto_msg(M_FATAL, "Failed to set allowed TLS group list: %s",
> +                   groups);
> +    }
> +
> +    free(glist);
> +}
> +
>  void
>  tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
>  {
> @@ -577,7 +630,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
>  
>      if (cert == NULL)
>      {
> -        goto cleanup; /* Nothing to check if there is no certificate */
> +        goto cleanup;     /* Nothing to check if there is no certificate */

how is this related to this patch?

>      }
>  
>      ret = X509_cmp_time(X509_get0_notBefore(cert), NULL);
> @@ -890,7 +943,7 @@ tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio)
>      for (;; )
>      {
>          cert = NULL;
> -        if (!PEM_read_bio_X509(bio, &cert, NULL, NULL)) /* takes ownership of cert */
> +        if (!PEM_read_bio_X509(bio, &cert, NULL, NULL))     /* takes ownership of cert */

how is this related to this patch?

>          {
>              break;
>          }
> @@ -1144,7 +1197,7 @@ openvpn_extkey_rsa_finish(RSA *rsa)
>   * interface query
>   */
>  const char *
> -get_rsa_padding_name (const int padding)
> +get_rsa_padding_name(const int padding)

how is this related to this patch?

>  {
>      switch (padding)
>      {
> @@ -1161,14 +1214,14 @@ get_rsa_padding_name (const int padding)
>  
>  /**
>   * Pass the input hash in 'dgst' to management and get the signature back.
> -  *
> - * @param dgst		hash to be signed
> - * @param dgstlen	len of data in dgst
> - * @param sig 		On successful return signature is in sig.
> - * @param siglen	length of buffer sig
> - * @param algorithm	padding/hashing algorithm for the signature
>   *
> - * @return 		signature length or -1 on error.
> + * @param dgst          hash to be signed
> + * @param dgstlen       len of data in dgst
> + * @param sig           On successful return signature is in sig.
> + * @param siglen        length of buffer sig
> + * @param algorithm     padding/hashing algorithm for the signature
> + *
> + * @return              signature length or -1 on error.

how is this related to this patch?

>   */
>  static int
>  get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,
> @@ -1210,7 +1263,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa,
>          return -1;
>      }
>  
> -    ret = get_sig_from_man(from, flen, to, len, get_rsa_padding_name (padding));
> +    ret = get_sig_from_man(from, flen, to, len, get_rsa_padding_name(padding));

how is this related to this patch?

>  
>      return (ret == len) ? ret : -1;
>  }
> @@ -1266,7 +1319,7 @@ tls_ctx_use_external_rsa_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
>          goto err;
>      }
>  
> -    RSA_free(rsa); /* doesn't necessarily free, just decrements refcount */
> +    RSA_free(rsa);     /* doesn't necessarily free, just decrements refcount */

how is this related to this patch?

>      return 1;
>  
>  err:
> @@ -1285,7 +1338,7 @@ err:
>  }
>  
>  #if ((OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER)) \
> -     || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
> +    || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \

how is this related to this patch?

>      && !defined(OPENSSL_NO_EC)
>  
>  /* called when EC_KEY is destroyed */
> @@ -1394,11 +1447,11 @@ tls_ctx_use_external_ec_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
>  
>      if (!SSL_CTX_use_PrivateKey(ctx->ctx, privkey))
>      {
> -        ec = NULL; /* avoid double freeing it below */
> +        ec = NULL;     /* avoid double freeing it below */

how is this related to this patch?

>          goto err;
>      }
>  
> -    EVP_PKEY_free(privkey); /* this will down ref privkey and ec */
> +    EVP_PKEY_free(privkey);     /* this will down ref privkey and ec */

how is this related to this patch?

>      return 1;
>  
>  err:
> @@ -1436,7 +1489,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
>  
>      /* get the public key */
>      EVP_PKEY *pkey = X509_get0_pubkey(cert);
> -    ASSERT(pkey); /* NULL before SSL_CTX_use_certificate() is called */
> +    ASSERT(pkey);     /* NULL before SSL_CTX_use_certificate() is called */

how is this related to this patch?

>  
>      if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA)
>      {
> @@ -1446,7 +1499,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
>          }
>      }
>  #if ((OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER)) \
> -     || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
> +    || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \

how is this related to this patch?

>      && !defined(OPENSSL_NO_EC)
>      else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
>      {
> @@ -1690,7 +1743,7 @@ tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
>  static FILE *biofp;                            /* GLOBAL */
>  static bool biofp_toggle;                      /* GLOBAL */
>  static time_t biofp_last_open;                 /* GLOBAL */
> -static const int biofp_reopen_interval = 600;  /* GLOBAL */
> +static const int biofp_reopen_interval = 600;     /* GLOBAL */

how is this related to this patch?

>  
>  static void
>  close_biofp(void)
> @@ -1806,9 +1859,9 @@ bio_write(BIO *bio, const uint8_t *data, int size, const char *desc)
>  static void
>  bio_write_post(const int status, struct buffer *buf)
>  {
> -    if (status == 1) /* success status return from bio_write? */
> +    if (status == 1)     /* success status return from bio_write? */

how is this related to this patch?

>      {
> -        memset(BPTR(buf), 0, BLEN(buf));  /* erase data just written */
> +        memset(BPTR(buf), 0, BLEN(buf));     /* erase data just written */

how is this related to this patch?

>          buf->len = 0;
>      }
>  }
> @@ -2106,8 +2159,8 @@ show_available_tls_ciphers_list(const char *cipher_list,
>          crypto_msg(M_FATAL, "Cannot create SSL object");
>      }
>  
> -#if (OPENSSL_VERSION_NUMBER < 0x1010000fL) || \
> -    (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER <= 0x2090000fL)
> +#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)    \
> +    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER <= 0x2090000fL)

how is this related to this patch?

>      STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
>  #else
>      STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);
> @@ -2159,7 +2212,9 @@ show_available_curves(void)
>      ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);
>      if (EC_get_builtin_curves(curves, crv_len))
>      {
> -        printf("Available Elliptic curves:\n");
> +        printf("Consider using openssl ecparam -list_curves as\n"
> +               "alternative to running this command to this command.");
                                                       ^^^^ typ0

> +        printf("\nAvailable Elliptic curves/groups:\n");
>          for (n = 0; n < crv_len; n++)
>          {
>              const char *sname;
> 


it seems like the second half of your patch is made up by changes
created by uncrustify that are unrelated to the actual patch.

how about creating a second patxing all these style things instead of
mixing everything up?


This said, the logic looks good and it does what it claims without
inroducing too much complexity, except for allocating memory that may be
avoided (as asked inline).

my 2 cents.


Regards,


-- 
Antonio Quartulli

