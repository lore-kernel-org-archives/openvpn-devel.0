MIME-Version: 1.0
References: <20210505051833.11271-1-selva.nair@...277...>
 <20210510013239.18087-1-selva.nair@...277...>
In-Reply-To: <20210510013239.18087-1-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 27 Jul 2021 10:56:11 -0400
Message-ID: <CAKuzo_jD=5R3KU5E-PgCaiN-osgZDre+q=MkZ_U+bmCTKGZjSQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000f71da705c81c1964"
Subject: Re: [Openvpn-devel] [PATCH v2] Allow PKCS#11 uri to be used as
 --cert and --key file names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000f71da705c81c1964
Content-Type: text/plain; charset="UTF-8"

It seems no one is interested in this to elicit a review.. I thought this
would be a nifty feature ;)

On Sun, May 9, 2021 at 9:32 PM <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> v2 changes
>   - do not allow so-path embedded in cert and key uri
>   - add --pkcs11-engine option to optionally specify the
>         engine and provider module to use
>
> If either --cert or --key is specified as a PKCS#11 uri, try to
> load the certificate and key from any accessible PKCS#11 device.
> This does not require linking with any pkcs11 library, but needs
> pkcs11 engine to be available on the target machine.
>
> In its simplest form, just have
>
> --cert 'pkcs11:id=%01'
>
> Either do not specify --key, or use the same uri for --key.
> Do not include type=cert or type=private in the uri
> as the same uri is used for both certificate and private key.
>
> That's all what is required if pkcs11 engine is installed in the
> right location and optionally set up to load any necessary provider
> libraries (e.g., via openssl.cnf or via PKCS11_MODULE_PATH).
>
> If both cert and key are specified, the last entry takes precedence
> and is used to locate both the certificate and key. Use of different
> uri's for the cert and key are not supported. Specifying --cert as
> a file and --key as a uri or vice versa is treated as a usage error.
>
> If the engine cannot be automatically loaded, or a custom engine object
> has to be loaded, the engine name or shared library may be specified
> using the newly added option
>
>    --pkcs11-engine engine [module_path]
>
> Here engine may the the engine-id that OpenSSL is configured to locate,
> or the path to a shared object. The optional 'module_path' specifies
> any provider module that must be loaded. It must be given as a path.
> Use full path or relative path for these shared objects based on the
> target system setup.
>
> Requires building with OpenSSL engine support although the pkcs11 or
> a compatible engine, and provider libraries are required only at
> run time.
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  Changes.rst                      |   6 +
>  doc/man-sections/tls-options.rst |  31 ++++++
>  src/openvpn/options.c            |  68 +++++++++++-
>  src/openvpn/options.h            |   7 ++
>  src/openvpn/ssl.c                |  15 ++-
>  src/openvpn/ssl_backend.h        |  10 ++
>  src/openvpn/ssl_openssl.c        | 183 ++++++++++++++++++++++++++++++-
>  7 files changed, 316 insertions(+), 4 deletions(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index 9185b55f..19d311e3 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -4,6 +4,12 @@ Overview of changes in 2.6
>
>  New features
>  ------------
> +Specification of private key and certificates as PKCS#11 URI
> +    ``--cert`` and ``--key`` options can take RFC7512 PKCS#11
> +    URI's pointing to certificate and key in a token. Both cert
> +    and key must use the same URI. Requires OpenSSL with engine
> +    support and pkcs11 (or compatible) engine installed.
> +
>  Keying Material Exporters (RFC 5705) based key generation
>      As part of the cipher negotiation OpenVPN will automatically prefer
>      the RFC5705 based key material generation to the current custom
> diff --git a/doc/man-sections/tls-options.rst
> b/doc/man-sections/tls-options.rst
> index 00ea063a..7acfbdae 100644
> --- a/doc/man-sections/tls-options.rst
> +++ b/doc/man-sections/tls-options.rst
> @@ -116,6 +116,20 @@ certificates and keys:
> https://github.com/OpenVPN/easy-rsa
>    authority functions, you must set up the files :code:`index.txt` (may be
>    empty) and :code:`serial` (initialize to :code:`01`).
>
> +--cert pkcs11-uri
> +  The local peer's certificate in a PKCS#11 token specified as a RFC 7512
> +  uri with optional custom attributes described below. Cannot be used with
> +  ``--key file``. ``--key`` must be left unspecified or point to the same
> +  uri. All other requrements for the certificate described under
> +  ``--cert file`` applies.
> +
> +  Requires OpenSSL with pkcs11 engine installed and configured. Also see
> +  the option ``--pkcs11-engine``.
> +
> +  As the same uri is used for certificate and private key, do not include
> type
> +  attribute (i.e., :code: `type=cert;` or :code: `type=private;` should
> not
> +  be included)
> +
>  --crl-verify args
>    Check peer certificate against a Certificate Revocation List.
>
> @@ -208,11 +222,28 @@ certificates and keys:
> https://github.com/OpenVPN/easy-rsa
>    generated when you built your peer's certificate (see ``--cert file``
>    above).
>
> +--key pkcs11-uri
> +  See ``--cert pkcs11-uri`` above.
> +
>  --pkcs12 file
>    Specify a PKCS #12 file containing local private key, local certificate,
>    and root CA certificate. This option can be used instead of ``--ca``,
>    ``--cert``, and ``--key``.  Not available with mbed TLS.
>
> +--pkcs11-engine engine-name [module-path]
> +  Specifiy the pkcs11-engine and the provider module to load when
> +  certificate and private key are given as a pkcs11 URI.
> +
> +  If the option is unspecified, and a pkcs11 URI is used for cert/key,
> +  :code:`pkcs11` engine is loaded, if it can be automatically found by
> +  OpenSSL.
> +
> +  If specified, the cert/key must be given as a pkcs11 URI.
> +
> +  The engine name could be a valid engine-id or path to a shared object.
> +  The module-path should be the path to a shared object. Objects in
> +  non-standard locations would need to be specified as full paths.
> +
>  --remote-cert-eku oid
>    Require that peer certificate was signed with an explicit *extended key
>    usage*.
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index db460796..559782ec 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -531,6 +531,11 @@ static const char usage_message[] =
>      "                   nonce_secret_len=nsl.  Set alg=none to disable
> PRNG.\n"
>  #ifndef ENABLE_CRYPTO_MBEDTLS
>      "--engine [name] : Enable OpenSSL hardware crypto engine
> functionality.\n"
> +#endif
> +#ifdef HAVE_OPENSSL_ENGINE
> +    "--pkcs11-engine name [module-path] : PKCS11 engine and provider
> module to use\n"
> +    "                                     for cert and key specified as a
> pkcs11 URI.\n"
> +    "                                     name could be an engine-id or a
> path.\n"
>  #endif
>      "--no-replay     : (DEPRECATED) Disable replay protection.\n"
>      "--mute-replay-warnings : Silence the output of replay warnings to
> log file.\n"
> @@ -915,6 +920,12 @@ struct pull_filter_list
>      struct pull_filter *tail;
>  };
>
> +static bool
> +is_pkcs11_uri(const char *uri)
> +{
> +    return (uri && !strncmp(uri, "pkcs11:", 7));
> +}
> +
>  static const char *
>  pull_filter_type_name(int type)
>  {
> @@ -2587,6 +2598,17 @@ options_postprocess_verify_ce(const struct options
> *options,
>
>      if (options->tls_server || options->tls_client)
>      {
> +#ifdef HAVE_OPENSSL_ENGINE
> +        if (is_pkcs11_uri(options->cert_file) !=
> is_pkcs11_uri(options->priv_key_file))
> +        {
> +            msg(M_USAGE, "Use of PKCS#11 uri for --cert or --key and file
> name for the other is not supported");
> +        }
> +        else
> +        if (options->pkcs11_engine && !is_pkcs11_uri(options->cert_file))
> +        {
> +            msg(M_USAGE, "Use of --pkcs11-engine expects --cert to be
> specified as a pkcs11: URI");
> +        }
> +#endif
>  #ifdef ENABLE_PKCS11
>          if (options->pkcs11_providers[0])
>          {
> @@ -3455,8 +3477,11 @@ options_postprocess_filechecks(struct options
> *options)
>      errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
>                                       options->ca_path, R_OK, "--capath");
>
> -    errs |= check_file_access_inline(options->cert_file_inline,
> CHKACC_FILE,
> +    if (!is_pkcs11_uri(options->cert_file))
> +    {
> +        errs |= check_file_access_inline(options->cert_file_inline,
> CHKACC_FILE,
>                                       options->cert_file, R_OK, "--cert");
> +    }
>
>      errs |= check_file_access_inline(options->extra_certs_file,
> CHKACC_FILE,
>                                       options->extra_certs_file, R_OK,
> @@ -3466,9 +3491,12 @@ options_postprocess_filechecks(struct options
> *options)
>      if (!(options->management_flags & MF_EXTERNAL_KEY))
>  #endif
>      {
> -        errs |= check_file_access_inline(options->priv_key_file_inline,
> +        if (!is_pkcs11_uri(options->priv_key_file))
> +        {
> +            errs |=
> check_file_access_inline(options->priv_key_file_inline,
>                                           CHKACC_FILE|CHKACC_PRIVATE,
>                                           options->priv_key_file, R_OK,
> "--key");
> +        }
>      }
>
>      errs |= check_file_access_inline(options->pkcs12_file_inline,
> @@ -8097,6 +8125,14 @@ add_option(struct options *options,
>          }
>      }
>  #endif /* ENABLE_CRYPTO_MBEDTLS */
> +#ifdef HAVE_OPENSSL_ENGINE
> +    else if (streq(p[0], "pkcs11-engine") && p[1] && !p[3])
> +    {
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +        options->pkcs11_engine = p[1];
> +        options->pkcs11_engine_module = p[2]; /* may be NULL */
> +    }
> +#endif /* HAVE_OPENSSL_ENGINE */
>  #ifdef ENABLE_PREDICTION_RESISTANCE
>      else if (streq(p[0], "use-prediction-resistance") && !p[1])
>      {
> @@ -8156,6 +8192,20 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
>          options->cert_file = p[1];
>          options->cert_file_inline = is_inline;
> +        if (is_pkcs11_uri(p[1]))
> +        {
> +#ifndef HAVE_OPENSSL_ENGINE
> +            msg(msglevel, "Use of PKCS11 uri as cert and key file names
> requires OpenSSL "
> +                          "ENGINE support which is missing in this
> binary.")
> +#else
> +            options->priv_key_file = p[1];
> +            options->cert_file_is_pkcs11_uri = true;
> +        }
> +        else
> +        {
> +            options->cert_file_is_pkcs11_uri = false;
> +#endif /* HAVE_OPENSSL_ENGINE */
> +        }
>      }
>      else if (streq(p[0], "extra-certs") && p[1] && !p[2])
>      {
> @@ -8238,6 +8288,20 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
>          options->priv_key_file = p[1];
>          options->priv_key_file_inline = is_inline;
> +        if (is_pkcs11_uri(p[1]))
> +        {
> +#ifndef HAVE_OPENSSL_ENGINE
> +            msg(msglevel, "Use of PKCS11 uri as cert and key file names
> requires OpenSSL "
> +                          "ENGINE support which is missing in this
> binary.")
> +#else
> +            options->cert_file = p[1];
> +            options->cert_file_is_pkcs11_uri = true;
> +        }
> +        else
> +        {
> +            options->cert_file_is_pkcs11_uri = false;
> +#endif /* HAVE_OPENSSL_ENGINE */
> +        }
>      }
>      else if (streq(p[0], "tls-version-min") && p[1] && !p[3])
>      {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 41e84f7e..15567980 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -659,6 +659,13 @@ struct options
>
>      /* data channel crypto flags set by push/pull. Reuses the CO_*
> crypto_flags */
>      unsigned int data_channel_crypto_flags;
> +
> +#ifdef HAVE_OPENSSL_ENGINE
> +    const char *pkcs11_engine;
> +    const char *pkcs11_engine_module;
> +    /* flag to indicate cert and key files are specified as pkcs11 uri */
> +    bool cert_file_is_pkcs11_uri;
> +#endif
>  };
>
>  #define streq(x, y) (!strcmp((x), (y)))
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index b16f6bcc..dedfe8ad 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -641,6 +641,19 @@ init_ssl(const struct options *options, struct
> tls_root_ctx *new_ctx, bool in_ch
>              goto err;
>          }
>      }
> +#ifdef HAVE_OPENSSL_ENGINE
> +    else if (options->cert_file_is_pkcs11_uri)
> +    {
> +        if (!tls_ctx_use_pkcs11_engine(new_ctx, options->cert_file,
> +                                       options->pkcs11_engine,
> +                                       options->pkcs11_engine_module))
> +        {
> +            msg(M_WARN, "Cannot load certificate \"%s\" using PKCS#11
> engine",
> +                options->cert_file);
> +            goto err;
> +        }
> +    }
> +#endif
>  #ifdef ENABLE_PKCS11
>      else if (options->pkcs11_providers[0])
>      {
> @@ -672,7 +685,7 @@ init_ssl(const struct options *options, struct
> tls_root_ctx *new_ctx, bool in_ch
>          tls_ctx_load_cert_file(new_ctx, options->cert_file,
> options->cert_file_inline);
>      }
>
> -    if (options->priv_key_file)
> +    if (options->priv_key_file && !options->cert_file_is_pkcs11_uri)
>      {
>          if (0 != tls_ctx_load_priv_file(new_ctx, options->priv_key_file,
>                                          options->priv_key_file_inline))
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index c3d12e5b..556fc2c8 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -568,4 +568,14 @@ void get_highest_preference_tls_cipher(char *buf, int
> size);
>   */
>  const char *get_ssl_library_version(void);
>
> +/**
> + * Load certificate and key into TLS context using pkcs11 engine
> + * @param ctx       TLS context
> + * @param cert_id   ceritificate and proivate key spec as pkcs11 URI
> + * @param engine    id or path of OpenSSL pkcs11 engine object (default:
> pkcs11)
> + * @param module    path of optional provider module to load with the
> engine
> + */
> +int tls_ctx_use_pkcs11_engine(struct tls_root_ctx *tls_ctx, const char
> *cert_id,
> +                          const char *engine, const char *module);
> +
>  #endif /* SSL_BACKEND_H_ */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 3120c51a..58fbde93 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -2251,4 +2251,185 @@ get_ssl_library_version(void)
>      return OpenSSL_version(OPENSSL_VERSION);
>  }
>
> -#endif /* defined(ENABLE_CRYPTO_OPENSSL) */
> +#if HAVE_OPENSSL_ENGINE
> +#include <openssl/ui.h>
> +#include <openssl/engine.h>
> +
> +/* Call back method for user interface with pkcs11 engine
> + * used for PIN prompt and possibly token insertion request.
> + */
> +static int
> +ui_reader(UI *ui, UI_STRING *uis)
> +{
> +    struct user_pass token_pass;
> +    int ret = 0;
> +
> +    const char *uri = UI_get0_user_data(ui);
> +    const char *prompt = UI_get0_output_string(uis);
> +
> +    token_pass.defined = false;
> +    token_pass.nocache = true;
> +
> +    switch(UI_get_string_type(uis))
> +    {
> +        case UIT_PROMPT:
> +        case UIT_VERIFY:
> +            if (get_user_pass(&token_pass, NULL, prompt,
> +                GET_USER_PASS_MANAGEMENT|GET_USER_PASS_PASSWORD_ONLY
> +                |GET_USER_PASS_NOFATAL))
> +            {
> +                ret = 1;
> +                UI_set_result(ui, uis, token_pass.password);
> +            }
> +            break;
> +       case UIT_BOOLEAN:
> +            if (get_user_pass(&token_pass, NULL,
> UI_get0_output_string(uis),
> +                GET_USER_PASS_MANAGEMENT|GET_USER_PASS_NEED_OK
> +                |GET_USER_PASS_NOFATAL))
> +            {
> +                ret = (strcmp(token_pass.password, "ok") == 0);
> +                UI_set_result(ui, uis, token_pass.password);
> +            }
> +       case UIT_INFO:
> +            msg(M_INFO, "INFO prompt from token: <%s>", prompt);
> +            break;
> +       case UIT_ERROR:
> +            msg(M_INFO, "ERROR prompt from token: <%s>", prompt);
> +            break;
> +       default:
> +            break;
> +    }
> +
> +    return ret;
> +}
> +
> +static char *
> +ui_prompt_constructor(UI *ui, const char *desc, const char *name)
> +{
> +    int len =  strlen(desc) + strlen(name) + 6;
> +    char *s = malloc(len);
> +    openvpn_snprintf(s, len, "%s for %s", desc, name);
> +    return s;
> +}
> +
> +static ENGINE *
> +load_pkcs11_engine(const char *engine_id)
> +{
> +    ENGINE *e = ENGINE_by_id(engine_id);
> +
> +    if (e) {
> +        return e;
> +    }
> +
> +    /* try dynamic engine with engine-id as path to the engine shared
> object */
> +    e = ENGINE_by_id("dynamic");
> +    if (e)
> +    {
> +        if (!ENGINE_ctrl_cmd_string(e, "SO_PATH", engine_id, 0)
> +            || !ENGINE_ctrl_cmd_string(e, "LOAD", NULL, 0))
> +        {
> +            ENGINE_free(e);
> +            e = NULL;
> +        }
> +    }
> +    if (!e)
> +    {
> +        msg(M_WARN, "PKCS11 engine <%s> not available", engine_id);
> +    }
> +    return e;
> +}
> +
> +static ENGINE *
> +setup_pkcs11_engine(const char *engine_id, const char *module_path,
> UI_METHOD *ui)
> +{
> +    if (!engine_id)
> +    {
> +        engine_id = "pkcs11";
> +    }
> +
> +    msg(D_SHOW_PKCS11, "Loading pkcs11 engine <%s> with module <%s>",
> +        engine_id, (module_path ? module_path : "unspecified"));
> +
> +    ENGINE *e = load_pkcs11_engine(engine_id);
> +
> +    if (e)
> +    {
> +       if (module_path)
> +        {
> +            ENGINE_ctrl_cmd_string(e, "MODULE_PATH", module_path, 0);
> +        }
> +        ENGINE_ctrl_cmd(e, "SET_USER_INTERFACE", 0, ui, NULL, 0);
> +    }
> +
> +    return e;
> +}
> +
> +/**
> + * Load certificate and key into TLS context using pkcs11 engine
> + * @param ctx       TLS context
> + * @param cert_id   ceritificate and proivate key spec as pkcs11 URI
> + * @param engine    id or path of OpenSSL pkcs11 engine object (default:
> pkcs11)
> + * @param module    path of optional provider module to load with the
> engine
> + */
> +int
> +tls_ctx_use_pkcs11_engine(struct tls_root_ctx *tls_ctx, const char
> *cert_id,
> +                          const char *engine, const char *module)
> +{
> +    int ret = 0;
> +    EVP_PKEY *pkey = NULL;
> +
> +    UI_METHOD *ui = UI_create_method("openvpn");
> +    if (!ui)
> +    {
> +        msg(M_WARN, "Failed to setup UI callback for engine");
> +        return ret;
> +    }
> +    UI_method_set_reader(ui, ui_reader);
> +    UI_method_set_prompt_constructor(ui, ui_prompt_constructor);
> +
> +    struct
> +    {
> +        const char *cert_id;
> +        X509* cert;
> +    } params = {cert_id, NULL};
> +
> +    ENGINE *e = setup_pkcs11_engine(engine, module, ui);
> +    if (!e || !ENGINE_init(e))
> +    {
> +        goto cleanup;
> +    }
> +    ENGINE_ctrl_cmd(e, "SET_CALLBACK_DATA", 0, (void *)cert_id, NULL, 0);
> +
> +    msg (D_SHOW_PKCS11, "Loading certificate <%s> using engine",
> params.cert_id);
> +
> +    if (!ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &params, NULL, 0)
> +        || !params.cert || !SSL_CTX_use_certificate(tls_ctx->ctx,
> params.cert))
> +    {
> +        msg (M_WARN, "Failed to load certificate <%s>", cert_id);
> +        goto finish;
> +    }
> +
> +    msg (D_SHOW_PKCS11, "Loading private key <%s> using engine",
> params.cert_id);
> +
> +    pkey = ENGINE_load_private_key(e, cert_id, ui, (void *)cert_id);
> +    if (!pkey || !SSL_CTX_use_PrivateKey(tls_ctx->ctx, pkey))
> +    {
> +        msg (M_WARN, "Failed to set private key <%s> using engine",
> cert_id);
> +        goto finish;
> +    }
> +    ret = 1;
> +
> +finish:
> +    ENGINE_finish(e);
> +
> +cleanup:
> +    ENGINE_free(e);
> +    X509_free(params.cert);
> +    UI_destroy_method(ui);
> +
> +    return ret;
> +}
> +
> +#endif /* HAVE_OPENSSL_ENGINE */
> +
> +#endif /* ENABLE_CRYPTO_OPENSSL */
> --
> 2.20.1
>
>

--000000000000f71da705c81c1964
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div>It seems no one is interested in this to el=
icit a review.. I thought this would be a nifty feature ;)</div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, May 9, 20=
21 at 9:32 PM &lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...1482...=
...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_=
blank">selva.nair@...277...</a>&gt;<br>
<br>
v2 changes<br>
=C2=A0 - do not allow so-path embedded in cert and key uri<br>
=C2=A0 - add --pkcs11-engine option to optionally specify the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 engine and provider module to use<br>
<br>
If either --cert or --key is specified as a PKCS#11 uri, try to<br>
load the certificate and key from any accessible PKCS#11 device.<br>
This does not require linking with any pkcs11 library, but needs<br>
pkcs11 engine to be available on the target machine.<br>
<br>
In its simplest form, just have<br>
<br>
--cert &#39;pkcs11:id=3D%01&#39;<br>
<br>
Either do not specify --key, or use the same uri for --key.<br>
Do not include type=3Dcert or type=3Dprivate in the uri<br>
as the same uri is used for both certificate and private key.<br>
<br>
That&#39;s all what is required if pkcs11 engine is installed in the<br>
right location and optionally set up to load any necessary provider<br>
libraries (e.g., via openssl.cnf or via PKCS11_MODULE_PATH).<br>
<br>
If both cert and key are specified, the last entry takes precedence<br>
and is used to locate both the certificate and key. Use of different<br>
uri&#39;s for the cert and key are not supported. Specifying --cert as<br>
a file and --key as a uri or vice versa is treated as a usage error.<br>
<br>
If the engine cannot be automatically loaded, or a custom engine object<br>
has to be loaded, the engine name or shared library may be specified<br>
using the newly added option<br>
<br>
=C2=A0 =C2=A0--pkcs11-engine engine [module_path]<br>
<br>
Here engine may the the engine-id that OpenSSL is configured to locate,<br>
or the path to a shared object. The optional &#39;module_path&#39; specifie=
s<br>
any provider module that must be loaded. It must be given as a path.<br>
Use full path or relative path for these shared objects based on the<br>
target system setup.<br>
<br>
Requires building with OpenSSL engine support although the pkcs11 or<br>
a compatible engine, and provider libraries are required only at<br>
run time.<br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." targe=
t=3D"_blank">selva.nair@...277...</a>&gt;<br>
---<br>
=C2=A0Changes.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
=C2=A0doc/man-sections/tls-options.rst |=C2=A0 31 ++++++<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 68 +++++++++++-<br>
=C2=A0src/openvpn/options.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A07 ++<br>
=C2=A0src/openvpn/ssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 15 ++-<br>
=C2=A0src/openvpn/ssl_backend.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 ++<br>
=C2=A0src/openvpn/ssl_openssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 183 ++++++++++=
++++++++++++++++++++-<br>
=C2=A07 files changed, 316 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/Changes.rst b/Changes.rst<br>
index 9185b55f..19d311e3 100644<br>
--- a/Changes.rst<br>
+++ b/Changes.rst<br>
@@ -4,6 +4,12 @@ Overview of changes in 2.6<br>
<br>
=C2=A0New features<br>
=C2=A0------------<br>
+Specification of private key and certificates as PKCS#11 URI<br>
+=C2=A0 =C2=A0 ``--cert`` and ``--key`` options can take RFC7512 PKCS#11<br>
+=C2=A0 =C2=A0 URI&#39;s pointing to certificate and key in a token. Both c=
ert<br>
+=C2=A0 =C2=A0 and key must use the same URI. Requires OpenSSL with engine<=
br>
+=C2=A0 =C2=A0 support and pkcs11 (or compatible) engine installed.<br>
+<br>
=C2=A0Keying Material Exporters (RFC 5705) based key generation<br>
=C2=A0 =C2=A0 =C2=A0As part of the cipher negotiation OpenVPN will automati=
cally prefer<br>
=C2=A0 =C2=A0 =C2=A0the RFC5705 based key material generation to the curren=
t custom<br>
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst<br>
index 00ea063a..7acfbdae 100644<br>
--- a/doc/man-sections/tls-options.rst<br>
+++ b/doc/man-sections/tls-options.rst<br>
@@ -116,6 +116,20 @@ certificates and keys: <a href=3D"https://github.com/O=
penVPN/easy-rsa" rel=3D"noreferrer" target=3D"_blank">https://github.com/Op=
enVPN/easy-rsa</a><br>
=C2=A0 =C2=A0authority functions, you must set up the files :code:`index.tx=
t` (may be<br>
=C2=A0 =C2=A0empty) and :code:`serial` (initialize to :code:`01`).<br>
<br>
+--cert pkcs11-uri<br>
+=C2=A0 The local peer&#39;s certificate in a PKCS#11 token specified as a =
RFC 7512<br>
+=C2=A0 uri with optional custom attributes described below. Cannot be used=
 with<br>
+=C2=A0 ``--key file``. ``--key`` must be left unspecified or point to the =
same<br>
+=C2=A0 uri. All other requrements for the certificate described under<br>
+=C2=A0 ``--cert file`` applies.<br>
+<br>
+=C2=A0 Requires OpenSSL with pkcs11 engine installed and configured. Also =
see<br>
+=C2=A0 the option ``--pkcs11-engine``.<br>
+<br>
+=C2=A0 As the same uri is used for certificate and private key, do not inc=
lude type<br>
+=C2=A0 attribute (i.e., :code: `type=3Dcert;` or :code: `type=3Dprivate;` =
should not<br>
+=C2=A0 be included)<br>
+<br>
=C2=A0--crl-verify args<br>
=C2=A0 =C2=A0Check peer certificate against a Certificate Revocation List.<=
br>
<br>
@@ -208,11 +222,28 @@ certificates and keys: <a href=3D"https://github.com/=
OpenVPN/easy-rsa" rel=3D"noreferrer" target=3D"_blank">https://github.com/O=
penVPN/easy-rsa</a><br>
=C2=A0 =C2=A0generated when you built your peer&#39;s certificate (see ``--=
cert file``<br>
=C2=A0 =C2=A0above).<br>
<br>
+--key pkcs11-uri<br>
+=C2=A0 See ``--cert pkcs11-uri`` above.<br>
+<br>
=C2=A0--pkcs12 file<br>
=C2=A0 =C2=A0Specify a PKCS #12 file containing local private key, local ce=
rtificate,<br>
=C2=A0 =C2=A0and root CA certificate. This option can be used instead of ``=
--ca``,<br>
=C2=A0 =C2=A0``--cert``, and ``--key``.=C2=A0 Not available with mbed TLS.<=
br>
<br>
+--pkcs11-engine engine-name [module-path]<br>
+=C2=A0 Specifiy the pkcs11-engine and the provider module to load when<br>
+=C2=A0 certificate and private key are given as a pkcs11 URI.<br>
+<br>
+=C2=A0 If the option is unspecified, and a pkcs11 URI is used for cert/key=
,<br>
+=C2=A0 :code:`pkcs11` engine is loaded, if it can be automatically found b=
y<br>
+=C2=A0 OpenSSL.<br>
+<br>
+=C2=A0 If specified, the cert/key must be given as a pkcs11 URI.<br>
+<br>
+=C2=A0 The engine name could be a valid engine-id or path to a shared obje=
ct.<br>
+=C2=A0 The module-path should be the path to a shared object. Objects in<b=
r>
+=C2=A0 non-standard locations would need to be specified as full paths.<br>
+<br>
=C2=A0--remote-cert-eku oid<br>
=C2=A0 =C2=A0Require that peer certificate was signed with an explicit *ext=
ended key<br>
=C2=A0 =C2=A0usage*.<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index db460796..559782ec 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -531,6 +531,11 @@ static const char usage_message[] =3D<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0nonce_secret_len=3Dnsl.=C2=A0 Set alg=3Dnone to disable=
 PRNG.\n&quot;<br>
=C2=A0#ifndef ENABLE_CRYPTO_MBEDTLS<br>
=C2=A0 =C2=A0 =C2=A0&quot;--engine [name] : Enable OpenSSL hardware crypto =
engine functionality.\n&quot;<br>
+#endif<br>
+#ifdef HAVE_OPENSSL_ENGINE<br>
+=C2=A0 =C2=A0 &quot;--pkcs11-engine name [module-path] : PKCS11 engine and=
 provider module to use\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0for cert and key specified as a pkcs11 URI.\n&quot;<br>
+=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0name could be an engine-id or a path.\n&quot;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0&quot;--no-replay=C2=A0 =C2=A0 =C2=A0: (DEPRECATED) Dis=
able replay protection.\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;--mute-replay-warnings : Silence the output of re=
play warnings to log file.\n&quot;<br>
@@ -915,6 +920,12 @@ struct pull_filter_list<br>
=C2=A0 =C2=A0 =C2=A0struct pull_filter *tail;<br>
=C2=A0};<br>
<br>
+static bool<br>
+is_pkcs11_uri(const char *uri)<br>
+{<br>
+=C2=A0 =C2=A0 return (uri &amp;&amp; !strncmp(uri, &quot;pkcs11:&quot;, 7)=
);<br>
+}<br>
+<br>
=C2=A0static const char *<br>
=C2=A0pull_filter_type_name(int type)<br>
=C2=A0{<br>
@@ -2587,6 +2598,17 @@ options_postprocess_verify_ce(const struct options *=
options,<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (options-&gt;tls_server || options-&gt;tls_client)<b=
r>
=C2=A0 =C2=A0 =C2=A0{<br>
+#ifdef HAVE_OPENSSL_ENGINE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_pkcs11_uri(options-&gt;cert_file) !=3D =
is_pkcs11_uri(options-&gt;priv_key_file))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_USAGE, &quot;Use of PKCS#1=
1 uri for --cert or --key and file name for the other is not supported&quot=
;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (options-&gt;pkcs11_engine &amp;&amp; !is_p=
kcs11_uri(options-&gt;cert_file))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_USAGE, &quot;Use of --pkcs=
11-engine expects --cert to be specified as a pkcs11: URI&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+#endif<br>
=C2=A0#ifdef ENABLE_PKCS11<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (options-&gt;pkcs11_providers[0])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
@@ -3455,8 +3477,11 @@ options_postprocess_filechecks(struct options *optio=
ns)<br>
=C2=A0 =C2=A0 =C2=A0errs |=3D check_file_access_chroot(options-&gt;chroot_d=
ir, CHKACC_FILE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;ca_=
path, R_OK, &quot;--capath&quot;);<br>
<br>
-=C2=A0 =C2=A0 errs |=3D check_file_access_inline(options-&gt;cert_file_inl=
ine, CHKACC_FILE,<br>
+=C2=A0 =C2=A0 if (!is_pkcs11_uri(options-&gt;cert_file))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D check_file_access_inline(options-&gt=
;cert_file_inline, CHKACC_FILE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;cer=
t_file, R_OK, &quot;--cert&quot;);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0errs |=3D check_file_access_inline(options-&gt;extra_ce=
rts_file, CHKACC_FILE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;ext=
ra_certs_file, R_OK,<br>
@@ -3466,9 +3491,12 @@ options_postprocess_filechecks(struct options *optio=
ns)<br>
=C2=A0 =C2=A0 =C2=A0if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KE=
Y))<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D check_file_access_inline(options-&gt=
;priv_key_file_inline,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_pkcs11_uri(options-&gt;priv_key_file))=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D check_file_access_inli=
ne(options-&gt;priv_key_file_inline,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 C=
HKACC_FILE|CHKACC_PRIVATE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 o=
ptions-&gt;priv_key_file, R_OK, &quot;--key&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0errs |=3D check_file_access_inline(options-&gt;pkcs12_f=
ile_inline,<br>
@@ -8097,6 +8125,14 @@ add_option(struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif /* ENABLE_CRYPTO_MBEDTLS */<br>
+#ifdef HAVE_OPENSSL_ENGINE<br>
+=C2=A0 =C2=A0 else if (streq(p[0], &quot;pkcs11-engine&quot;) &amp;&amp; p=
[1] &amp;&amp; !p[3])<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION(OPT_P_GENERAL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;pkcs11_engine =3D p[1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;pkcs11_engine_module =3D p[2]; /* =
may be NULL */<br>
+=C2=A0 =C2=A0 }<br>
+#endif /* HAVE_OPENSSL_ENGINE */<br>
=C2=A0#ifdef ENABLE_PREDICTION_RESISTANCE<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;use-prediction-resistance&qu=
ot;) &amp;&amp; !p[1])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -8156,6 +8192,20 @@ add_option(struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INL=
INE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;cert_file =3D p[1];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;cert_file_inline =3D is_inlin=
e;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_pkcs11_uri(p[1]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+#ifndef HAVE_OPENSSL_ENGINE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;Use of PKCS1=
1 uri as cert and key file names requires OpenSSL &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;ENGINE support which is missing in this binary.&quo=
t;)<br>
+#else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;priv_key_file =3D p[=
1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;cert_file_is_pkcs11_=
uri =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;cert_file_is_pkcs11_=
uri =3D false;<br>
+#endif /* HAVE_OPENSSL_ENGINE */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;extra-certs&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[2])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -8238,6 +8288,20 @@ add_option(struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INL=
INE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;priv_key_file =3D p[1];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;priv_key_file_inline =3D is_i=
nline;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_pkcs11_uri(p[1]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+#ifndef HAVE_OPENSSL_ENGINE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;Use of PKCS1=
1 uri as cert and key file names requires OpenSSL &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;ENGINE support which is missing in this binary.&quo=
t;)<br>
+#else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;cert_file =3D p[1];<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;cert_file_is_pkcs11_=
uri =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;cert_file_is_pkcs11_=
uri =3D false;<br>
+#endif /* HAVE_OPENSSL_ENGINE */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;tls-version-min&quot;) &amp;=
&amp; p[1] &amp;&amp; !p[3])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
diff --git a/src/openvpn/options.h b/src/openvpn/options.h<br>
index 41e84f7e..15567980 100644<br>
--- a/src/openvpn/options.h<br>
+++ b/src/openvpn/options.h<br>
@@ -659,6 +659,13 @@ struct options<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* data channel crypto flags set by push/pull. Reuses t=
he CO_* crypto_flags */<br>
=C2=A0 =C2=A0 =C2=A0unsigned int data_channel_crypto_flags;<br>
+<br>
+#ifdef HAVE_OPENSSL_ENGINE<br>
+=C2=A0 =C2=A0 const char *pkcs11_engine;<br>
+=C2=A0 =C2=A0 const char *pkcs11_engine_module;<br>
+=C2=A0 =C2=A0 /* flag to indicate cert and key files are specified as pkcs=
11 uri */<br>
+=C2=A0 =C2=A0 bool cert_file_is_pkcs11_uri;<br>
+#endif<br>
=C2=A0};<br>
<br>
=C2=A0#define streq(x, y) (!strcmp((x), (y)))<br>
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c<br>
index b16f6bcc..dedfe8ad 100644<br>
--- a/src/openvpn/ssl.c<br>
+++ b/src/openvpn/ssl.c<br>
@@ -641,6 +641,19 @@ init_ssl(const struct options *options, struct tls_roo=
t_ctx *new_ctx, bool in_ch<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#ifdef HAVE_OPENSSL_ENGINE<br>
+=C2=A0 =C2=A0 else if (options-&gt;cert_file_is_pkcs11_uri)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tls_ctx_use_pkcs11_engine(new_ctx, option=
s-&gt;cert_file,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&=
gt;pkcs11_engine,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&=
gt;pkcs11_engine_module))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Cannot load ce=
rtificate \&quot;%s\&quot; using PKCS#11 engine&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;cert_f=
ile);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
=C2=A0#ifdef ENABLE_PKCS11<br>
=C2=A0 =C2=A0 =C2=A0else if (options-&gt;pkcs11_providers[0])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -672,7 +685,7 @@ init_ssl(const struct options *options, struct tls_root=
_ctx *new_ctx, bool in_ch<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tls_ctx_load_cert_file(new_ctx, options-&=
gt;cert_file, options-&gt;cert_file_inline);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (options-&gt;priv_key_file)<br>
+=C2=A0 =C2=A0 if (options-&gt;priv_key_file &amp;&amp; !options-&gt;cert_f=
ile_is_pkcs11_uri)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (0 !=3D tls_ctx_load_priv_file(new_ctx=
, options-&gt;priv_key_file,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0op=
tions-&gt;priv_key_file_inline))<br>
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h<br>
index c3d12e5b..556fc2c8 100644<br>
--- a/src/openvpn/ssl_backend.h<br>
+++ b/src/openvpn/ssl_backend.h<br>
@@ -568,4 +568,14 @@ void get_highest_preference_tls_cipher(char *buf, int =
size);<br>
=C2=A0 */<br>
=C2=A0const char *get_ssl_library_version(void);<br>
<br>
+/**<br>
+ * Load certificate and key into TLS context using pkcs11 engine<br>
+ * @param ctx=C2=A0 =C2=A0 =C2=A0 =C2=A0TLS context<br>
+ * @param cert_id=C2=A0 =C2=A0ceritificate and proivate key spec as pkcs11=
 URI<br>
+ * @param engine=C2=A0 =C2=A0 id or path of OpenSSL pkcs11 engine object (=
default: pkcs11)<br>
+ * @param module=C2=A0 =C2=A0 path of optional provider module to load wit=
h the engine<br>
+ */<br>
+int tls_ctx_use_pkcs11_engine(struct tls_root_ctx *tls_ctx, const char *ce=
rt_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const char *engine, const char *module);<br>
+<br>
=C2=A0#endif /* SSL_BACKEND_H_ */<br>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
index 3120c51a..58fbde93 100644<br>
--- a/src/openvpn/ssl_openssl.c<br>
+++ b/src/openvpn/ssl_openssl.c<br>
@@ -2251,4 +2251,185 @@ get_ssl_library_version(void)<br>
=C2=A0 =C2=A0 =C2=A0return OpenSSL_version(OPENSSL_VERSION);<br>
=C2=A0}<br>
<br>
-#endif /* defined(ENABLE_CRYPTO_OPENSSL) */<br>
+#if HAVE_OPENSSL_ENGINE<br>
+#include &lt;openssl/ui.h&gt;<br>
+#include &lt;openssl/engine.h&gt;<br>
+<br>
+/* Call back method for user interface with pkcs11 engine<br>
+ * used for PIN prompt and possibly token insertion request.<br>
+ */<br>
+static int<br>
+ui_reader(UI *ui, UI_STRING *uis)<br>
+{<br>
+=C2=A0 =C2=A0 struct user_pass token_pass;<br>
+=C2=A0 =C2=A0 int ret =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 const char *uri =3D UI_get0_user_data(ui);<br>
+=C2=A0 =C2=A0 const char *prompt =3D UI_get0_output_string(uis);<br>
+<br>
+=C2=A0 =C2=A0 token_pass.defined =3D false;<br>
+=C2=A0 =C2=A0 token_pass.nocache =3D true;<br>
+<br>
+=C2=A0 =C2=A0 switch(UI_get_string_type(uis))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case UIT_PROMPT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case UIT_VERIFY:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_pass(&amp;token_pas=
s, NULL, prompt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GET_USER_PASS_MANA=
GEMENT|GET_USER_PASS_PASSWORD_ONLY<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |GET_USER_PASS_NOF=
ATAL))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 UI_set_result(ui, =
uis, token_pass.password);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case UIT_BOOLEAN:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_pass(&amp;token_pas=
s, NULL, UI_get0_output_string(uis),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GET_USER_PASS_MANA=
GEMENT|GET_USER_PASS_NEED_OK<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |GET_USER_PASS_NOF=
ATAL))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (strcmp(to=
ken_pass.password, &quot;ok&quot;) =3D=3D 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 UI_set_result(ui, =
uis, token_pass.password);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case UIT_INFO:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;INFO prompt fr=
om token: &lt;%s&gt;&quot;, prompt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case UIT_ERROR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;ERROR prompt f=
rom token: &lt;%s&gt;&quot;, prompt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+static char *<br>
+ui_prompt_constructor(UI *ui, const char *desc, const char *name)<br>
+{<br>
+=C2=A0 =C2=A0 int len =3D=C2=A0 strlen(desc) + strlen(name) + 6;<br>
+=C2=A0 =C2=A0 char *s =3D malloc(len);<br>
+=C2=A0 =C2=A0 openvpn_snprintf(s, len, &quot;%s for %s&quot;, desc, name);=
<br>
+=C2=A0 =C2=A0 return s;<br>
+}<br>
+<br>
+static ENGINE *<br>
+load_pkcs11_engine(const char *engine_id)<br>
+{<br>
+=C2=A0 =C2=A0 ENGINE *e =3D ENGINE_by_id(engine_id);<br>
+<br>
+=C2=A0 =C2=A0 if (e) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return e;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* try dynamic engine with engine-id as path to the engine s=
hared object */<br>
+=C2=A0 =C2=A0 e =3D ENGINE_by_id(&quot;dynamic&quot;);<br>
+=C2=A0 =C2=A0 if (e)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ENGINE_ctrl_cmd_string(e, &quot;SO_PATH&q=
uot;, engine_id, 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || !ENGINE_ctrl_cmd_string(e, &q=
uot;LOAD&quot;, NULL, 0))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ENGINE_free(e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!e)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;PKCS11 engine &lt;%s&gt; not=
 available&quot;, engine_id);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return e;<br>
+}<br>
+<br>
+static ENGINE *<br>
+setup_pkcs11_engine(const char *engine_id, const char *module_path, UI_MET=
HOD *ui)<br>
+{<br>
+=C2=A0 =C2=A0 if (!engine_id)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 engine_id =3D &quot;pkcs11&quot;;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 msg(D_SHOW_PKCS11, &quot;Loading pkcs11 engine &lt;%s&gt; wi=
th module &lt;%s&gt;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 engine_id, (module_path ? module_path : &quot;=
unspecified&quot;));<br>
+<br>
+=C2=A0 =C2=A0 ENGINE *e =3D load_pkcs11_engine(engine_id);<br>
+<br>
+=C2=A0 =C2=A0 if (e)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (module_path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ENGINE_ctrl_cmd_string(e, &quot;=
MODULE_PATH&quot;, module_path, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ENGINE_ctrl_cmd(e, &quot;SET_USER_INTERFACE&qu=
ot;, 0, ui, NULL, 0);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return e;<br>
+}<br>
+<br>
+/**<br>
+ * Load certificate and key into TLS context using pkcs11 engine<br>
+ * @param ctx=C2=A0 =C2=A0 =C2=A0 =C2=A0TLS context<br>
+ * @param cert_id=C2=A0 =C2=A0ceritificate and proivate key spec as pkcs11=
 URI<br>
+ * @param engine=C2=A0 =C2=A0 id or path of OpenSSL pkcs11 engine object (=
default: pkcs11)<br>
+ * @param module=C2=A0 =C2=A0 path of optional provider module to load wit=
h the engine<br>
+ */<br>
+int<br>
+tls_ctx_use_pkcs11_engine(struct tls_root_ctx *tls_ctx, const char *cert_i=
d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const char *engine, const char *module)<br>
+{<br>
+=C2=A0 =C2=A0 int ret =3D 0;<br>
+=C2=A0 =C2=A0 EVP_PKEY *pkey =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 UI_METHOD *ui =3D UI_create_method(&quot;openvpn&quot;);<br>
+=C2=A0 =C2=A0 if (!ui)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Failed to setup UI callback =
for engine&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 UI_method_set_reader(ui, ui_reader);<br>
+=C2=A0 =C2=A0 UI_method_set_prompt_constructor(ui, ui_prompt_constructor);=
<br>
+<br>
+=C2=A0 =C2=A0 struct<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *cert_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 X509* cert;<br>
+=C2=A0 =C2=A0 } params =3D {cert_id, NULL};<br>
+<br>
+=C2=A0 =C2=A0 ENGINE *e =3D setup_pkcs11_engine(engine, module, ui);<br>
+=C2=A0 =C2=A0 if (!e || !ENGINE_init(e))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ENGINE_ctrl_cmd(e, &quot;SET_CALLBACK_DATA&quot;, 0, (void *=
)cert_id, NULL, 0);<br>
+<br>
+=C2=A0 =C2=A0 msg (D_SHOW_PKCS11, &quot;Loading certificate &lt;%s&gt; usi=
ng engine&quot;, params.cert_id);<br>
+<br>
+=C2=A0 =C2=A0 if (!ENGINE_ctrl_cmd(e, &quot;LOAD_CERT_CTRL&quot;, 0, &amp;=
params, NULL, 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !params.cert || !SSL_CTX_use_certificate(tl=
s_ctx-&gt;ctx, params.cert))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_WARN, &quot;Failed to load certificate =
&lt;%s&gt;&quot;, cert_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto finish;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 msg (D_SHOW_PKCS11, &quot;Loading private key &lt;%s&gt; usi=
ng engine&quot;, params.cert_id);<br>
+<br>
+=C2=A0 =C2=A0 pkey =3D ENGINE_load_private_key(e, cert_id, ui, (void *)cer=
t_id);<br>
+=C2=A0 =C2=A0 if (!pkey || !SSL_CTX_use_PrivateKey(tls_ctx-&gt;ctx, pkey))=
<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_WARN, &quot;Failed to set private key &=
lt;%s&gt; using engine&quot;, cert_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto finish;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D 1;<br>
+<br>
+finish:<br>
+=C2=A0 =C2=A0 ENGINE_finish(e);<br>
+<br>
+cleanup:<br>
+=C2=A0 =C2=A0 ENGINE_free(e);<br>
+=C2=A0 =C2=A0 X509_free(params.cert);<br>
+=C2=A0 =C2=A0 UI_destroy_method(ui);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+#endif /* HAVE_OPENSSL_ENGINE */<br>
+<br>
+#endif /* ENABLE_CRYPTO_OPENSSL */<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div>

--000000000000f71da705c81c1964--

