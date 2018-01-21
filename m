References: <1512422193-8184-1-git-send-email-jim@...2322...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <7228a583-01f9-7150-ebb4-42a975a5af47@...1856...>
Date: Sun, 21 Jan 2018 13:10:55 +0100
MIME-Version: 1.0
In-Reply-To: <1512422193-8184-1-git-send-email-jim@...2322...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Added support for OpenSSL FIPS
 Object Module v2.0 validated encryption
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

Sorry for taking so long to review.  At least some early review comments:

On 04-12-17 22:16, jim@...2322... wrote:
> From: Jim Carroll <jim@...2322...>
> 
> Signed-off-by: Jim Carroll <jim@...2322...>
> ---
>  INSTALL                      | 78 ++++++++++++++++++++++++++++++++++++++++++++
>  Makefile.am                  |  5 +++
>  configure.ac                 | 41 +++++++++++++++++++++++
>  src/openvpn/crypto.c         |  2 +-
>  src/openvpn/crypto_backend.h |  3 +-
>  src/openvpn/crypto_openssl.c | 16 ++++++++-
>  src/openvpn/crypto_openssl.h |  8 +++++
>  src/openvpn/ntlm.c           |  2 +-
>  src/openvpn/openvpn.c        |  9 +++++
>  src/openvpn/options.c        | 18 ++++++++++
>  src/openvpn/options.h        |  3 ++
>  src/openvpn/ssl.c            | 12 +++++--
>  src/openvpn/ssl.h            |  4 +++
>  13 files changed, 195 insertions(+), 6 deletions(-)
> 
> diff --git a/INSTALL b/INSTALL
> index 3a31e6f..b001cb1 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -305,6 +305,84 @@ TUN/TAP Driver Configuration:
>  
>  *************************************************************************
>  
> +OpenSSL FIPS Object Module v2.0 Configuration:
> +
> +These instructions were adapted from
> +
> +    https://www.openssl.org/docs/fipsnotes.html
> +
> +Requirements:
> +
> +    * OpenSSL 1.0.2m
> +    * openssl-fips-2.0.2
> +
> +WARNING
> +
> +To install FIPS Validated encryption, you must follow the instructions in the
> +FIPS 2.0 User's Guide precisely. You are not permitted to modify any of the FIPS
> +build artifacts, makefiles or scripts. The FIPS 2.0 module is only compatible with
> +OpenSSL 1.0.1 and 1.0.2.
> +
> +These instructions describe the use of OpenSSL 1.0.2m.
> +
> +PRE-INSTALLATION CHECKUP:
> +
> +    The INSTALLATION procecure describes how to install an OpenSSL library that
> +    is built with FIPS support. If your platform already provides a FIPS
> +    enabled library you can skip to step 6 (build OpenVPN).
> +
> +INSTALLATION:
> +
> +    1. Surf to https://www.openssl.org/source/
> +    2. Download source AND validate the download was correct (preferably using PGP)
> +    3. Untar and uncompress tarball
> +    4. You must build using this precise command (do NOT choose any other options):
> +
> +            # ./config && make install
> +
> +            (you may optionslly pass 'no-asm' to config)
> +
> +       If the above procedure does not build on your system -- STOP. You are not
> +       building on a FIPS supported platform, and therefore will not have a
> +       FIPS validated encryption environment. See chapter 3 of the FIPS 2.0
> +       User's Guide for the complete list of supported platforms:
> +
> +            https://openssl.org/docs/fips/UserGuide-2.0.pdf
> +
> +    5. Download, build & install openssl 1.0.2m (you are permitted to
> +       modify this step to suite your preferences):
> +
> +            # git clone https://github.com/openssl/openssl.git
> +            # (cd openssl && \
> +                    git checkout OpenSSL_1_0_2m && \
> +                    ./config fips && \
> +                    make depend && \
> +                    make install)
> +
> +    6. Now build openvpn and tell it where to find you recently installed OpenSSL
> +
> +            # ./configure --enable-fips-mode \
> +                    OPENSSL_CFLAGS=-I/usr/local/ssl/include \
> +                    OPENSSL_LIBS="-ldl -L/usr/local/ssl/lib -lssl -lcrypto"
> +
> +            # make install
> +
> +    7. You can confirm FIPS mode is available with the command
> +
> +            # ./openvpn --version | grep 'library version'
> +            library versions: OpenSSL 1.0.2m-fips  2 Nov 2017, LZO 2.08
> +
> +USAGE:
> +
> +The above adds a new '--enable-fips-mode' command line option to OpenVPN. Add this to your
> +invocation statement. If you've successfully configured OpenVPN for FIPS mode, check your
> +OpenVPN logs for the statement:
> +
> +    *** FIPS MODE ENABLE ***
> +
> +
> +*************************************************************************
> +
>  CAVEATS & BUGS:
>  
>  * I have noticed cases where TCP sessions tunneled over the Linux
> diff --git a/Makefile.am b/Makefile.am
> index 773b786..6d571ec 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -83,6 +83,11 @@ rootdir=$(prefix)
>  root_DATA = version.sh
>  endif
>  
> +if FIPSMODE
> +export CC
> +export FIPSLD_CC
> +endif
> +
>  config-version.h:
>  	@CONFIGURE_GIT_CHFILES="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) diff-files --name-status -r --ignore-submodules --quiet -- || echo \"+\"`"; \
>  	CONFIGURE_GIT_UNCOMMITTED="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) diff-index --cached  --quiet --ignore-submodules HEAD || echo \"*\"`"; \
> diff --git a/configure.ac b/configure.ac
> index b4fd1b3..dc74230 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -286,6 +286,17 @@ AC_ARG_WITH(
>  	[with_crypto_library="openssl"]
>  )
>  
> +AC_ARG_ENABLE(
> +    [fips-mode],
> +    [AS_HELP_STRING([--enable-fips-mode], [OpenSSL FIPS Object Module 2.0 @<:@default=no@:>@])],
> +    [
> +        if test "${with_crypto_library}" != "openssl"; then
> +            AC_MSG_ERROR([enable_fips_mode requires --with_crypto_library=openssl])
> +        fi
> +    ],
> +    [enable_fips_mode="no"]
> +)
> +
>  AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory @<:@default=LIBDIR/openvpn/plugins@:>@])
>  if test -n "${PLUGINDIR}"; then
>  	plugindir="${PLUGINDIR}"
> @@ -948,6 +959,35 @@ if test "${with_crypto_library}" = "openssl"; then
>  		]
>  	)
>  
> +    if test "${enable_fips_mode}" = "yes"; then
> +        AC_CHECK_FUNCS(
> +            [ \
> +                FIPS_mode \
> +                FIPS_mode_set \
> +                SSLeay_version
> +            ],
> +            [],
> +            [AC_MSG_ERROR([Incorrect version of OpenSSL, require 1.0.2])]

This isn't really the version check that fails, right?  Something like
"Couldn't find functions required for FIPS" sounds more accurate.

> +            )
> +        AC_RUN_IFELSE(
> +            [AC_LANG_PROGRAM(
> +                [[#include <openssl/crypto.h>]],
> +                [[printf("%s\n", SSLeay_version(SSLEAY_DIR));]])
> +            ],
> +            [AC_SUBST(OPENSSLDIR,
> +                [[`./conftest$EXEEXT | $SED -n 's/.*"\(.*\)".*/\1/p'`]])
> +            ]
> +        )

Instead of calling SSLeay_version(), consider using the OPENSSL_VERSION
define, like we already do elsewhere in configure.ac.  That will not
break as soon as there is a FIPS-compliant 1.1 release (which the
openssl devs say there will be "soon").

> +        if ! test -x "${OPENSSLDIR}/fips-2.0/bin/fipsld"; then
> +            AC_MSG_ERROR([Incomplete OpenSSL FIPS installation; missing fipsld])
> +        fi
> +        AC_SUBST([FIPSLD_CC], ["${CC}"])
> +        AC_SUBST([CC], ["${OPENSSLDIR}/fips-2.0/bin/fipsld"])
> +        export CC
> +        export FIPSLD_CC
> +        AC_DEFINE([ENABLE_FIPS], [1], [Enable OpenSSL FIPS 2.0 Options])
> +    fi
> +
>  	CFLAGS="${saved_CFLAGS}"
>  	LIBS="${saved_LIBS}"
>  
> @@ -1359,6 +1399,7 @@ AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
>  AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
>  AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "yes"])
>  AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" = "yes"])
> +AM_CONDITIONAL([FIPSMODE], [test "${enable_fips_mode}" = "yes"])
>  
>  sampledir="\$(docdir)/sample"
>  AC_SUBST([plugindir])
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 3096f3b..97d117b 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -852,7 +852,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
>      if (kt->digest && kt->hmac_length > 0)
>      {
>          ctx->hmac = hmac_ctx_new();
> -        hmac_ctx_init(ctx->hmac, key->hmac, kt->hmac_length, kt->digest);
> +        hmac_ctx_init(ctx->hmac, key->hmac, kt->hmac_length, kt->digest, false);
>  
>          msg(D_HANDSHAKE,
>              "%s: Using %d bit message hash '%s' for HMAC authentication",
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index 567fd9b..8790ca5 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -604,10 +604,11 @@ void hmac_ctx_free(hmac_ctx_t *ctx);
>   * @param key           The key to use for the HMAC
>   * @param key_len       The key length to use
>   * @param kt            Static message digest parameters
> + * @param prf_use       Intended use for PRF in TLS protocol
>   *
>   */
>  void hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, int key_length,
> -                   const md_kt_t *kt);
> +                   const md_kt_t *kt, bool prf_use);

Instead of adding this parameter, I'd prefer to add a
hmac_ctx_set_fips_prf() function.  That way all the non-prf hmac calls
don't have to change.

>  /*
>   * Free the given HMAC context.
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 20a519e..fe4cef3 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -159,6 +159,18 @@ crypto_init_lib(void)
>  #endif
>  }
>  
> +int
> +crypto_enable_fips_mode(int mode)
> +{
> +    if (!FIPS_mode_set(mode))
> +    {
> +        ERR_print_errors_fp(stderr);
> +        return 1;
> +    }
> +    msg(M_INFO, "*** FIPS MODE ENABLED ***");
> +    return 0;
> +}
> +
>  void
>  crypto_uninit_lib(void)
>  {
> @@ -926,11 +938,13 @@ hmac_ctx_free(HMAC_CTX *ctx)
>  
>  void
>  hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, int key_len,
> -              const EVP_MD *kt)
> +              const EVP_MD *kt, bool prf_use)
>  {
>      ASSERT(NULL != kt && NULL != ctx);
>  
>      HMAC_CTX_reset(ctx);
> +    if (kt == EVP_md5() && prf_use)
> +        HMAC_CTX_set_flags(ctx, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);

Please always use braces for a branch.

>      HMAC_Init_ex(ctx, key, key_len, kt, NULL);
>  
>      /* make sure we used a big enough key */
> diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
> index 60a2812..fbc8b2a 100644
> --- a/src/openvpn/crypto_openssl.h
> +++ b/src/openvpn/crypto_openssl.h
> @@ -102,4 +102,12 @@ void crypto_print_openssl_errors(const unsigned int flags);
>      } while (false)
>  
>  
> +/**
> + * Enable FIPS Mode. Returns non-zero to indicate an error.
> + *
> + * @param mode         Should be 1. Future versions of OpenSSL FIPS
> + *                     code are expected to accept extended modes.
> + */
> +int crypto_enable_fips_mode(int mode);
> +
>  #endif /* CRYPTO_OPENSSL_H_ */
> diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
> index 077fa3e..fe39ab1 100644
> --- a/src/openvpn/ntlm.c
> +++ b/src/openvpn/ntlm.c
> @@ -88,7 +88,7 @@ gen_hmac_md5(const uint8_t *data, int data_len, const uint8_t *key, int key_len,
>      const md_kt_t *md5_kt = md_kt_get("MD5");
>      hmac_ctx_t *hmac_ctx = hmac_ctx_new();
>  
> -    hmac_ctx_init(hmac_ctx, key, key_len, md5_kt);
> +    hmac_ctx_init(hmac_ctx, key, key_len, md5_kt, false);
>      hmac_ctx_update(hmac_ctx, data, data_len);
>      hmac_ctx_final(hmac_ctx, result);
>      hmac_ctx_cleanup(hmac_ctx);
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> index e237ee5..da8e852 100644
> --- a/src/openvpn/openvpn.c
> +++ b/src/openvpn/openvpn.c
> @@ -210,6 +210,15 @@ openvpn_main(int argc, char *argv[])
>              /* parse command line options, and read configuration file */
>              parse_argv(&c.options, argc, argv, M_USAGE, OPT_P_DEFAULT, NULL, c.es);
>  
> +#if ENABLE_FIPS
> +            if (c.options.fips_mode)
> +            {
> +                if (enable_fips_mode(c.options.fips_mode))
> +                {
> +                    break;
> +                }
> +            }
> +#endif
>  #ifdef ENABLE_PLUGIN
>              /* plugins may contribute options configuration */
>              init_verb_mute(&c, IVM_LEVEL_1);
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 7be5f38..99d3ccc 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -517,6 +517,11 @@ static const char usage_message[] =
>      "\n"
>      "Data Channel Encryption Options (must be compatible between peers):\n"
>      "(These options are meaningful for both Static Key & TLS-mode)\n"
> +#ifdef ENABLE_FIPS
> +	"--enable-fips-mode : Enable OpenSSL FIPS Object Module v2.0.\n"
> +	"                  Setting this on the server will enforce FIPS validated\n"
> +	"                  encryption on both client and server.\n"
> +#endif
>      "--secret f [d]  : Enable Static Key encryption mode (non-TLS).\n"
>      "                  Use shared secret file f, generate with --genkey.\n"
>      "                  The optional d parameter controls key directionality.\n"
> @@ -847,6 +852,9 @@ init_options(struct options *o, const bool init_gc)
>      o->scheduled_exit_interval = 5;
>  #endif
>      o->ciphername = "BF-CBC";
> +#ifdef ENABLE_FIPS
> +	o->fips_mode = 0;
> +#endif
>  #ifdef HAVE_AEAD_CIPHER_MODES /* IV_NCP=2 requires GCM support */
>      o->ncp_enabled = true;
>  #else
> @@ -1550,6 +1558,9 @@ show_settings(const struct options *o)
>      SHOW_INT(persist_mode);
>  #endif
>  
> +#ifdef ENABLE_FIPS
> +    SHOW_INT(fips_mode);
> +#endif
>      SHOW_BOOL(show_ciphers);
>      SHOW_BOOL(show_digests);
>      SHOW_BOOL(show_engines);
> @@ -7389,6 +7400,13 @@ add_option(struct options *options,
>          }
>      }
>  #endif /* USE_COMP */
> +#ifdef ENABLE_FIPS
> +    else if (streq(p[0], "enable-fips-mode") && !p[1])
> +    {
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +        options->fips_mode = 1;
> +    }
> +#endif
>      else if (streq(p[0], "show-ciphers") && !p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index f70760c..6ffe646 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -186,6 +186,9 @@ struct options
>      bool persist_config;
>      int persist_mode;
>  
> +#ifdef ENABLE_FIPS
> +	int fips_mode;
> +#endif

Use spaces for indentation.  Also, sounds like this should be bool,
rather than an int?

>      const char *key_pass_file;
>      bool show_ciphers;
>      bool show_digests;
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 7b42845..3992f4d 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -352,6 +352,14 @@ init_ssl_lib(void)
>      crypto_init_lib();
>  }
>  
> +#if ENABLE_FIPS
> +int
> +enable_fips_mode(int mode)
> +{
> +	return crypto_enable_fips_mode(mode);
> +}
> +#endif
> +
>  void
>  free_ssl_lib(void)
>  {
> @@ -1638,8 +1646,8 @@ tls1_P_hash(const md_kt_t *md_kt,
>      chunk = md_kt_size(md_kt);
>      A1_len = md_kt_size(md_kt);
>  
> -    hmac_ctx_init(ctx, sec, sec_len, md_kt);
> -    hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt);
> +    hmac_ctx_init(ctx, sec, sec_len, md_kt, true);
> +    hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt, true);
>  
>      hmac_ctx_update(ctx,seed,seed_len);
>      hmac_ctx_final(ctx, A1);
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index dd1ab0f..f251765 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -598,4 +598,8 @@ bool is_hard_reset(int op, int key_method);
>  
>  void delayed_auth_pass_purge(void);
>  
> +#if ENABLE_FIPS
> +int enable_fips_mode(int mode);
> +#endif
> +
>  #endif /* ifndef OPENVPN_SSL_H */
> 

I hope to look into this patch more, and run some test later.

Thanks so far,
-Steffan

