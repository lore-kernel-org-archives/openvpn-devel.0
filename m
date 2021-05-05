References: <20210505051833.11271-1-selva.nair@...277...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <e3fedd37-6a74-50f5-f314-0ced6f1eba04@...1147...>
Date: Wed, 5 May 2021 10:00:42 +0200
MIME-Version: 1.0
In-Reply-To: <20210505051833.11271-1-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Allow PKCS#11 uri to be used as --cert
 and --key file names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Hi Selva,

On 05/05/21 07:18, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>
> If either --cert or --key is specified as a PKCS#11 uri, try to
> load the certificate and key from any accessible PKCS#11 device.
> This does not require linking with any pkcs11 library, but needs
> pkcs11 engine to be available on the target machine.
>
> In its simplest form, just have
>
> --cert pkcs11:token=...;serial=... etc..
>
> Either do not specify --key, or use the same uri for --key.
>
> That's all what is required if pkcs11 engine is installed in the
> right location and optionally set up to load any necessary provider
> libraries (e.g., via openssl.cnf or via PKCS11_MODULE_PATH).
>
> If both cert and key are specified, the last entry takes precedence
> and is used to locate both the certificate and key. Use of different
> uri's for the cert and key are not supported -- at least not in
> this version. Specifying --cert as a file and --key as a uri or
> vice versa is treated as a usage error.
>
> If the engine cannot be automatically loaded or a custom engine object
> has to be loaded, the engine name or shared libraryx may be embedded
> in the PKCS#11 uri. The module shared object path also may be so
> embedded. For example,
>
> pkcs11:token=..;serial=...;engine=pkcs11.so;provider=libsofthsm2.so
>
> will use engine with id=pkcs11 and load libsofthsm2.so.
>
> Full path to the libraries may be included as required. These extra,
> optional attributes in the URI are stripped before presented to the
> PKCS#11 subsystem. Do not include type=cert or type=private in the uri
> as the same uri is used for both certificate and private key.
>
> Requires building with OpenSSL engine support although the pkcs11 or
> a compatible engine and provider libraries are required only at
> run time.
Great patch, but I see one possible security issue upsream with the 
ability to specify the pkcs11 driver:

Right now, Linux tools like NetworkManager-openvpn allow a non-root user 
to specify certain parameters, like cert, key etc in either a GUI or a 
config file.
These tools will *all* need to be updated to take into account (or most 
likely : BLOCK) the use of
   cert pkcs11: ....
as otherwise a rogue user can specify a pkcs11 driver with a backdoor, 
which NetworkManager would then happily pass on to the openvpn which 
runs as root ....

cheers,

JJK

> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>   Changes.rst                      |   6 +
>   doc/man-sections/tls-options.rst |  26 ++++
>   src/openvpn/options.c            |  49 ++++++-
>   src/openvpn/options.h            |   3 +
>   src/openvpn/ssl.c                |  13 +-
>   src/openvpn/ssl_backend.h        |   3 +
>   src/openvpn/ssl_openssl.c        | 221 ++++++++++++++++++++++++++++++-
>   7 files changed, 317 insertions(+), 4 deletions(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index 9185b55f..19d311e3 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -4,6 +4,12 @@ Overview of changes in 2.6
>   
>   New features
>   ------------
> +Specification of private key and certificates as PKCS#11 URI
> +    ``--cert`` and ``--key`` options can take RFC7512 PKCS#11
> +    URI's pointing to certificate and key in a token. Both cert
> +    and key must use the same URI. Requires OpenSSL with engine
> +    support and pkcs11 (or compatible) engine installed.
> +
>   Keying Material Exporters (RFC 5705) based key generation
>       As part of the cipher negotiation OpenVPN will automatically prefer
>       the RFC5705 based key material generation to the current custom
> diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
> index 00ea063a..f41d12f3 100644
> --- a/doc/man-sections/tls-options.rst
> +++ b/doc/man-sections/tls-options.rst
> @@ -116,6 +116,29 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
>     authority functions, you must set up the files :code:`index.txt` (may be
>     empty) and :code:`serial` (initialize to :code:`01`).
>   
> +--cert pkcs11-uri
> +  The local peer's certificate in a PKCS#11 token specified as a RFC 7512
> +  uri with optional custom attributes described below. Cannot be used with
> +  ``--key file``. ``--key`` must be left unspecified or point to the same
> +  uri. All other requrements for the certificate described under
> +  ``--cert file`` applies.
> +
> +  Requires OpenSSL with pkcs11 engine installed and configured. Optionally,
> +  the engine and provider module may be included as custom attributes in the
> +  uri as in the example below:
> +
> +  ::
> +
> +    --cert 'pkcs11:token=foo;serial=bar;id=nnn;engine=pkcs11;provider=p11-kit-proxy.so'
> +
> +  Here the engine name :code:`pkcs11` could be a valid engine-id or path to a
> +  shared object. Shared objects in non-standard locations would need to be
> +  specified with full path.
> +
> +  As the same uri is used for certificate and private key, do not include type
> +  attribute (i.e., :code: `type=cert;` or :code: `type=private;` should not
> +  be included)
> +
>   --crl-verify args
>     Check peer certificate against a Certificate Revocation List.
>   
> @@ -208,6 +231,9 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
>     generated when you built your peer's certificate (see ``--cert file``
>     above).
>   
> +--key pkcs11-uri
> +  See ``--cert pkcs11-uri`` above.
> +
>   --pkcs12 file
>     Specify a PKCS #12 file containing local private key, local certificate,
>     and root CA certificate. This option can be used instead of ``--ca``,
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index db460796..21241846 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -915,6 +915,12 @@ struct pull_filter_list
>       struct pull_filter *tail;
>   };
>   
> +static bool
> +is_pkcs11_uri(const char *uri)
> +{
> +    return (!strncmp(uri, "pkcs11:", 7));
> +}
> +
>   static const char *
>   pull_filter_type_name(int type)
>   {
> @@ -2587,6 +2593,13 @@ options_postprocess_verify_ce(const struct options *options,
>   
>       if (options->tls_server || options->tls_client)
>       {
> +#ifdef HAVE_OPENSSL_ENGINE
> +        if (is_pkcs11_uri(options->cert_file) != is_pkcs11_uri(options->priv_key_file))
> +        {
> +            msg(M_USAGE, "Use of PKCS#11 uri for --cert or --key and file name for the other is not supported");
> +        }
> +        else
> +#endif
>   #ifdef ENABLE_PKCS11
>           if (options->pkcs11_providers[0])
>           {
> @@ -3455,8 +3468,11 @@ options_postprocess_filechecks(struct options *options)
>       errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
>                                        options->ca_path, R_OK, "--capath");
>   
> -    errs |= check_file_access_inline(options->cert_file_inline, CHKACC_FILE,
> +    if (!is_pkcs11_uri(options->cert_file))
> +    {
> +        errs |= check_file_access_inline(options->cert_file_inline, CHKACC_FILE,
>                                        options->cert_file, R_OK, "--cert");
> +    }
>   
>       errs |= check_file_access_inline(options->extra_certs_file, CHKACC_FILE,
>                                        options->extra_certs_file, R_OK,
> @@ -3466,9 +3482,12 @@ options_postprocess_filechecks(struct options *options)
>       if (!(options->management_flags & MF_EXTERNAL_KEY))
>   #endif
>       {
> -        errs |= check_file_access_inline(options->priv_key_file_inline,
> +        if (!is_pkcs11_uri(options->priv_key_file))
> +        {
> +            errs |= check_file_access_inline(options->priv_key_file_inline,
>                                            CHKACC_FILE|CHKACC_PRIVATE,
>                                            options->priv_key_file, R_OK, "--key");
> +        }
>       }
>   
>       errs |= check_file_access_inline(options->pkcs12_file_inline,
> @@ -8156,6 +8175,19 @@ add_option(struct options *options,
>           VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
>           options->cert_file = p[1];
>           options->cert_file_inline = is_inline;
> +        if (is_pkcs11_uri(p[1]))
> +        {
> +#ifndef HAVE_OPENSSL_ENGINE
> +            msg(msglevel, "USe of PKCS11 uri as cert and key file names requires OpenSSL "
> +                          "ENGINE support which is missing in this binary.")
> +#endif
> +            options->priv_key_file = p[1];
> +            options->cert_file_is_pkcs11_uri = true;
> +        }
> +        else
> +        {
> +            options->cert_file_is_pkcs11_uri = false;
> +        }
>       }
>       else if (streq(p[0], "extra-certs") && p[1] && !p[2])
>       {
> @@ -8238,6 +8270,19 @@ add_option(struct options *options,
>           VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
>           options->priv_key_file = p[1];
>           options->priv_key_file_inline = is_inline;
> +        if (is_pkcs11_uri(p[1]))
> +        {
> +#ifndef HAVE_OPENSSL_ENGINE
> +            msg(msglevel, "USe of PKCS11 uri as cert and key file names requires OpenSSL "
> +                          "ENGINE support which is missing in this binary.")
> +#endif
> +            options->cert_file = p[1];
> +            options->cert_file_is_pkcs11_uri = true;
> +        }
> +        else
> +        {
> +            options->cert_file_is_pkcs11_uri = false;
> +        }
>       }
>       else if (streq(p[0], "tls-version-min") && p[1] && !p[3])
>       {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 41e84f7e..ab7b2f62 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -659,6 +659,9 @@ struct options
>   
>       /* data channel crypto flags set by push/pull. Reuses the CO_* crypto_flags */
>       unsigned int data_channel_crypto_flags;
> +
> +    /* cert and key files are specified as pkcs11 uri */
> +    bool cert_file_is_pkcs11_uri;
>   };
>   
>   #define streq(x, y) (!strcmp((x), (y)))
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index b16f6bcc..93101e7c 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -641,6 +641,17 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx, bool in_ch
>               goto err;
>           }
>       }
> +#ifdef HAVE_OPENSSL_ENGINE
> +    else if (options->cert_file_is_pkcs11_uri)
> +    {
> +        if (!tls_ctx_use_pkcs11_engine(new_ctx, options->cert_file))
> +        {
> +            msg(M_WARN, "Cannot load certificate \"%s\" using PKCS#11 engine",
> +                options->cert_file);
> +            goto err;
> +        }
> +    }
> +#endif
>   #ifdef ENABLE_PKCS11
>       else if (options->pkcs11_providers[0])
>       {
> @@ -672,7 +683,7 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx, bool in_ch
>           tls_ctx_load_cert_file(new_ctx, options->cert_file, options->cert_file_inline);
>       }
>   
> -    if (options->priv_key_file)
> +    if (options->priv_key_file && !options->cert_file_is_pkcs11_uri)
>       {
>           if (0 != tls_ctx_load_priv_file(new_ctx, options->priv_key_file,
>                                           options->priv_key_file_inline))
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index c3d12e5b..96d6e64d 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -568,4 +568,7 @@ void get_highest_preference_tls_cipher(char *buf, int size);
>    */
>   const char *get_ssl_library_version(void);
>   
> +int tls_ctx_use_pkcs11_engine(struct tls_root_ctx *ssl_ctx,
> +                       const char *uri);
> +
>   #endif /* SSL_BACKEND_H_ */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 3120c51a..b8a91c59 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -2251,4 +2251,223 @@ get_ssl_library_version(void)
>       return OpenSSL_version(OPENSSL_VERSION);
>   }
>   
> -#endif /* defined(ENABLE_CRYPTO_OPENSSL) */
> +#if HAVE_OPENSSL_ENGINE
> +#include <openssl/ui.h>
> +#include <openssl/engine.h>
> +
> +/* call back method for user interface with pkcs11 engine */
> +static int
> +ui_reader(UI *ui, UI_STRING *uis)
> +{
> +    struct user_pass token_pass;
> +    int ret = 0;
> +
> +    const char *uri = UI_get0_user_data(ui);
> +    const char *prompt = UI_get0_output_string(uis);
> +
> +    printf("uri = %s\n", uri);
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
> +            if (get_user_pass(&token_pass, NULL, UI_get0_output_string(uis),
> +                GET_USER_PASS_MANAGEMENT|GET_USER_PASS_NEED_OK
> +                |GET_USER_PASS_NOFATAL))
> +            {
> +                ret = (strcmp(token_pass.password, "ok") == 0);
> +                UI_set_result(ui, uis, token_pass.password);
> +            }
> +       case UIT_INFO:
> +            msg(M_INFO, "Unknown INFO prompt from token: <%s>", UI_get0_output_string(uis));
> +            break;
> +       case UIT_ERROR:
> +            msg(M_INFO, "Unknown ERROR prompt from token: <%s>", UI_get0_output_string(uis));
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
> +/*
> + * POP an attribute from a pkcs11_uri and return its value.
> + * The URI is of the form:
> + * pkcs11:attr1=value1;attr2=value2;...."
> + * On return the speciifed attribute is removed from the uri.
> + */
> +static const char *
> +pkcs11_uri_pop(char *uri, const char *attr, struct gc_arena *gc)
> +{
> +    ASSERT(attr);
> +
> +    char *start = strstr(uri, attr);
> +    char *val;
> +    int skip = strlen(attr) + 1; /* attribute name and folloiwng = sign */
> +
> +    if (!start || start[strlen(attr)] != '=')
> +    {
> +        return NULL;
> +    }
> +    const char *end = strchr(start, ';');
> +    if (!end)
> +    {
> +        val = string_alloc(start + skip , gc);
> +        *start = '\0';
> +        return val;
> +    }
> +
> +    int len = end - (start + skip) + 1;
> +    val = gc_malloc(len, false, gc);
> +
> +    strncpynt(val, start + skip, len);
> +
> +    /* remove the matched attr=value; part */
> +    memmove(start, end + 1, strlen(end+1)+1);
> +
> +    return val;
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
> +    /* try dynamic engine with engine-id as path to the engine shared object */
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
> +setup_pkcs11_engine(const char *engine_id, const char *module_path, UI_METHOD *ui)
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
> +    if ( e && module_path)
> +    {
> +        ENGINE_ctrl_cmd_string(e, "MODULE_PATH", module_path, 0);
> +    }
> +
> +    if (e)
> +    {
> +        ENGINE_ctrl_cmd(e, "SET_USER_INTERFACE", 0, ui, NULL, 0);
> +    }
> +
> +    return e;
> +}
> +
> +int
> +tls_ctx_use_pkcs11_engine(struct tls_root_ctx *tls_ctx, const char *uri)
> +{
> +    char *tmp_uri;
> +    const char *engine_id, *module_path, *cert_id;
> +    struct gc_arena gc = gc_new();
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
> +    tmp_uri = string_alloc(uri, &gc);
> +    engine_id = pkcs11_uri_pop(tmp_uri, "engine", &gc);
> +    module_path = pkcs11_uri_pop(tmp_uri, "provider", &gc);
> +    cert_id = tmp_uri;
> +
> +    struct
> +    {
> +        const char *cert_id;
> +        X509* cert;
> +    } params = {cert_id, NULL};
> +
> +    ENGINE *e = setup_pkcs11_engine(engine_id, module_path, ui);
> +    if (!e || !ENGINE_init(e))
> +    {
> +        goto cleanup;
> +    }
> +    ENGINE_ctrl_cmd(e, "SET_CALLBACK_DATA", 0, (void *)uri, NULL, 0);
> +
> +    msg (D_SHOW_PKCS11, "Loading certificate <%s> using engine", cert_id);
> +
> +    if (!ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &params, NULL, 0)
> +        || !params.cert || !SSL_CTX_use_certificate(tls_ctx->ctx, params.cert))
> +    {
> +        msg (M_WARN, "Failed to load certificate <%s>", cert_id);
> +        goto finish;
> +    }
> +
> +    msg (D_SHOW_PKCS11, "Loading private key <%s> using engine", cert_id);
> +
> +    pkey = ENGINE_load_private_key(e, cert_id, ui, (void *)uri);
> +    if (!pkey || !SSL_CTX_use_PrivateKey(tls_ctx->ctx, pkey))
> +    {
> +        msg (M_WARN, "Failed to set private key <%s> using engine", cert_id);
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
> +    gc_free(&gc);
> +    UI_destroy_method(ui);
> +
> +    return ret;
> +}
> +
> +#endif /* HAVE_OPENSSL_ENGINE */
> +
> +#endif /* ENABLE_CRYPTO_OPENSSL */


