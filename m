References: <1511554982-875-1-git-send-email-jim@...2322...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <14a28e53-a002-8c03-69e1-44af1529f080@...2181...>
Date: Sun, 3 Dec 2017 12:57:28 +0800
MIME-Version: 1.0
In-Reply-To: <1511554982-875-1-git-send-email-jim@...2322...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JmqJU2Cr6uO6QHNIss7kaRnv7VBxOwAHS"
Subject: Re: [Openvpn-devel] [PATCH] Added OpenSSL FIPS 2.0 support to
 OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: jim@...2322..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JmqJU2Cr6uO6QHNIss7kaRnv7VBxOwAHS
Content-Type: multipart/mixed; boundary="iseDXukojDDB0tSn9JFFiDTjVVfuPnA7j";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: jim@...2322..., openvpn-devel@lists.sourceforge.net
Message-ID: <14a28e53-a002-8c03-69e1-44af1529f080@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Added OpenSSL FIPS 2.0 support to OpenVPN
References: <1511554982-875-1-git-send-email-jim@...2322...>
In-Reply-To: <1511554982-875-1-git-send-email-jim@...2322...>

--iseDXukojDDB0tSn9JFFiDTjVVfuPnA7j
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 25/11/17 04:23, jim@...2322... wrote:
> From: JimC <jim@...2322...>
>=20
> Modified the autoconf, automake and code to support building OpenVPN with
> OpenSSL FIPS Object Module v2.0 validated encryption.
>=20
>         * Adds: --enable-fips-mode switch to configure.ac
>         * Adds: --enable-fips-mode command line switch to openvpn

Please make sure your patch includes the Signed-off-by line (I think
Gert mentioned that already? sorry for repeating).
You should actually add that to your commit message when creating it.

Git can help you with that by just adding the '-s' argument to the 'git
commit' command. Make sure you have configured your name and email in
the git config so that it can pick them up.

Speaking about the name: it should be your full name (nicknames like
JimC are not really legally accepted).

> ---
>  INSTALL                      | 72 ++++++++++++++++++++++++++++++++++++++=
++++++
>  Makefile.am                  |  5 +++
>  configure.ac                 | 42 ++++++++++++++++++++++++++
>  src/openvpn/crypto.c         |  2 +-
>  src/openvpn/crypto_backend.h |  3 +-
>  src/openvpn/crypto_openssl.c | 15 ++++++++-
>  src/openvpn/crypto_openssl.h |  8 +++++
>  src/openvpn/ntlm.c           |  2 +-
>  src/openvpn/openvpn.c        |  7 +++++
>  src/openvpn/options.c        | 16 ++++++++++
>  src/openvpn/options.h        |  1 +
>  src/openvpn/ssl.c            | 12 ++++++--
>  src/openvpn/ssl.h            |  4 +++
>  13 files changed, 183 insertions(+), 6 deletions(-)
>=20
> diff --git a/INSTALL b/INSTALL
> index 3a31e6f..adb3df8 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -305,6 +305,78 @@ TUN/TAP Driver Configuration:
>=20=20
>  *************************************************************************
>=20=20
> +OpenSSL FIPS Object Module v2.0 Configuration:
> +
> +These instructions were adapted from=20
> +
> +    https://www.openssl.org/docs/fipsnotes.html
> +
> +Requirements:
> +
> +    * OpenSSL 1.0.2m
> +    * openssl-fips-2.0.2

I think the points above are expected to be ">=3D"?
Or are these versions strictly required?

> +
> +WARNING
> +
> +To install FIPS validated encryption, you must follow the instructions i=
n the
> +FIPS 2.0 User's Guide precisely. You are not permitted to modify any of =
the FIPS
> +build artifacts, makefiles or scripts. The FIPS 2.0 module is only compa=
tible with
> +OpenSSL 1.0.1 and 1.0.2.=20
> +
> +These instructions describe the use of OpenSSL 1.0.2m.
> +

This is more a general thought: do you think it is reasonable to have
the instructions about how to compile OpenSSL into the OpenVPN package?
Things may change on the OpenSSL side and we'd need to keep our
instructions up to date, even though we are not modifying the OpenVPN code.

Including a link to the openssl website may make sense, but imho we
should just tell the user to get a FIPS certified openssl module before
moving on.

After all, as you say below, it's the entire platform that needs to be
FIPS supported, thus I don't believe it's OpenVPN duty to instruct the
users about how building all the different components.

Some distro may even provide their own FIPS enabled packages.

Thoughts?

> +INSTALLATION:
> +
> +    1. Surf to https://www.openssl.org/source/
> +    2. Download source and validate the download (preferably using PGP)
> +    3. Untar and uncompress tarball
> +    4. You must build using this precise command (do NOT choose any othe=
r options):
> +
> +            # ./config && make install
> +
> +            (you may optionally pass 'no-asm' to config)
> +
> +       If the above procedure does not build on your system -- STOP. You=
 are not
> +       building on a FIPS supported platform, and therefore will not hav=
e a
> +       FIPS validated encryption environment. See chapter 3 of the FIPS =
2.0
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
> +    6. Now build openvpn and tell it where to find you recently installe=
d OpenSSL
> +
> +            # ./configure --enable-fips-mode \
> +                    OPENSSL_CFLAGS=3D-/usr/local/ss/include \
> +                    OPENSSL_LIBS=3D"-ldl -L/usr/local/ssl/lib -lssl -lcr=
ypto"
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
> +The above adds a new '--enable-fips-mode' command line option to OpenVPN=
. Add this to your
> +invocation statement. If you've successfully configured OpenVPN for FIPS=
 mode, check your
> +OpenVPN logs for the statement:
> +
> +    *** FIPS MODE ENABLE ***
> +
> +
> +*************************************************************************
> +
>  CAVEATS & BUGS:
>=20=20
>  * I have noticed cases where TCP sessions tunneled over the Linux
> diff --git a/Makefile.am b/Makefile.am
> index 773b786..6d571ec 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -83,6 +83,11 @@ rootdir=3D$(prefix)
>  root_DATA =3D version.sh
>  endif
>=20=20
> +if FIPSMODE
> +export CC
> +export FIPSLD_CC
> +endif
> +
>  config-version.h:
>  	@CONFIGURE_GIT_CHFILES=3D"`GIT_DIR=3D\"$(top_srcdir)/.git\" $(GIT) diff=
-files --name-status -r --ignore-submodules --quiet -- || echo \"+\"`"; \
>  	CONFIGURE_GIT_UNCOMMITTED=3D"`GIT_DIR=3D\"$(top_srcdir)/.git\" $(GIT) d=
iff-index --cached  --quiet --ignore-submodules HEAD || echo \"*\"`"; \
> diff --git a/configure.ac b/configure.ac
> index 7f2e34f..83ac18d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -293,6 +293,17 @@ AC_ARG_WITH(
>  	[with_crypto_library=3D"openssl"]
>  )
>=20=20
> +AC_ARG_ENABLE(
> +    [fips-mode],
> +    [AS_HELP_STRING([--enable-fips-mode], [OpenSSL FIPS Object Module 2.=
0 @<:@default=3Dno@:>@])],
> +    [
> +        if test "${with_crypto_library}" !=3D "openssl"; then
> +            AC_MSG_ERROR([enable_fips_mode requires --with_crypto_librar=
y=3Dopenssl])
> +        fi
> +    ],
> +    [enable_fips_mode=3D"no"]
> +)
> +
>  AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory @<:@default=3DLIBDIR/=
openvpn/plugins@:>@])
>  if test -n "${PLUGINDIR}"; then
>  	plugindir=3D"${PLUGINDIR}"
> @@ -954,6 +965,35 @@ if test "${enable_crypto}" =3D "yes" -a "${with_cryp=
to_library}" =3D "openssl"; then
>  		]
>  	)
>=20=20
> +    if test "${enable_fips_mode}" =3D "yes"; then
> +        AC_CHECK_FUNCS(
> +            [ \
> +                FIPS_mode \
> +                FIPS_mode_set \
> +                SSLeay_version
> +            ],
> +            [],
> +            [AC_MSG_ERROR([Incorrect version of OpenSSL, require 1.0.2])]
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
> +        if ! test -x "${OPENSSLDIR}/fips-2.0/bin/fipsld"; then
> +            AC_MSG_ERROR([Incomplete OpenSSL FIPS installation; missing =
fipsld])
> +        fi
> +        AC_SUBST([FIPSLD_CC], ["${CC}"])
> +        AC_SUBST([CC], ["${OPENSSLDIR}/fips-2.0/bin/fipsld"])
> +        export CC
> +        export FIPSLD_CC
> +        AC_DEFINE([ENABLE_FIPS], [1], [Enable OpenSSL FIPS 2.0 Options])
> +    fi
> +
>  	CFLAGS=3D"${saved_CFLAGS}"
>  	LIBS=3D"${saved_LIBS}"
>=20=20
> @@ -1373,6 +1413,7 @@ AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${e=
nable_plugin_auth_pam}" =3D "ye
>  AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_ro=
ot}" =3D "yes"])
>  AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" =3D "yes"])
>  AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" =
=3D "yes"])
> +AM_CONDITIONAL([FIPSMODE], [test "${enable_fips_mode}" =3D "yes"])
>=20=20
>  sampledir=3D"\$(docdir)/sample"
>  AC_SUBST([plugindir])
> @@ -1441,4 +1482,5 @@ AC_CONFIG_FILES([
>  	sample/Makefile
>  ])
>  AC_CONFIG_FILES([tests/t_client.sh], [chmod +x tests/t_client.sh])
> +

random empty line? shouldn't be part of this patch I think.

>  AC_OUTPUT
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 3f3caa1..0c05859 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -854,7 +854,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *k=
ey,
>      if (kt->digest && kt->hmac_length > 0)
>      {
>          ctx->hmac =3D hmac_ctx_new();
> -        hmac_ctx_init(ctx->hmac, key->hmac, kt->hmac_length, kt->digest);
> +        hmac_ctx_init(ctx->hmac, key->hmac, kt->hmac_length, kt->digest,=
 false);
>=20=20
>          msg(D_HANDSHAKE,
>              "%s: Using %d bit message hash '%s' for HMAC authentication",
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index 567fd9b..d92ab7c 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -604,10 +604,11 @@ void hmac_ctx_free(hmac_ctx_t *ctx);
>   * @param key           The key to use for the HMAC
>   * @param key_len       The key length to use
>   * @param kt            Static message digest parameters
> + * @param prf_use       Inteded use for PRF in TLS protocol

little typ0 above: 'Inteded' - > 'Intended'

>   *
>   */
>  void hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, int key_length,
> -                   const md_kt_t *kt);
> +                   const md_kt_t *kt, bool prf_use);
>=20=20
>  /*
>   * Free the given HMAC context.
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 0134e55..caef17b 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -159,6 +159,17 @@ crypto_init_lib(void)
>  #endif
>  }
>=20=20
> +int
> +crypto_enable_fips_mode(int mode)
> +{
> +	if (!FIPS_mode_set(mode)) {

opening '{' should be on a new line (like for functions)

> +		ERR_print_errors_fp(stderr);
> +		return 1;
> +		}

this '}' is not indented properly

> +	msg(M_INFO, "*** IN FIPS MODE ***\n");

do we really need another '\n' ? msg() will put one on its own already.

> +	return 0;
> +}
> +
>  void
>  crypto_uninit_lib(void)
>  {
> @@ -926,11 +937,13 @@ hmac_ctx_free(HMAC_CTX *ctx)
>=20=20
>  void
>  hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, int key_len,
> -              const EVP_MD *kt)
> +              const EVP_MD *kt, bool prf_use)
>  {
>      ASSERT(NULL !=3D kt && NULL !=3D ctx);
>=20=20
>      HMAC_CTX_reset(ctx);
> +	if (kt =3D=3D EVP_md5() && prf_use)

bad indentation? (we don't use tabs, but spaces only)

> +		HMAC_CTX_set_flags(ctx, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);
>      HMAC_Init_ex(ctx, key, key_len, kt, NULL);
>=20=20
>      /* make sure we used a big enough key */
> diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
> index 60a2812..11f3378 100644
> --- a/src/openvpn/crypto_openssl.h
> +++ b/src/openvpn/crypto_openssl.h
> @@ -102,4 +102,12 @@ void crypto_print_openssl_errors(const unsigned int =
flags);
>      } while (false)
>=20=20
>=20=20
> +/**
> + * Enable FIPS Mode. Returns non-zero to indicate an error.
> + *
> + * @param mode         Should be 1. Future versions of OpenSSL FIPS
> + * 					   code are expected to accept extended modes.

same here: don't use tabs

> + */
> +int crypto_enable_fips_mode(int mode);
> +
>  #endif /* CRYPTO_OPENSSL_H_ */
> diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
> index 077fa3e..fe39ab1 100644
> --- a/src/openvpn/ntlm.c
> +++ b/src/openvpn/ntlm.c
> @@ -88,7 +88,7 @@ gen_hmac_md5(const uint8_t *data, int data_len, const u=
int8_t *key, int key_len,
>      const md_kt_t *md5_kt =3D md_kt_get("MD5");
>      hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();
>=20=20
> -    hmac_ctx_init(hmac_ctx, key, key_len, md5_kt);
> +    hmac_ctx_init(hmac_ctx, key, key_len, md5_kt, false);
>      hmac_ctx_update(hmac_ctx, data, data_len);
>      hmac_ctx_final(hmac_ctx, result);
>      hmac_ctx_cleanup(hmac_ctx);
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> index e237ee5..beb1d2a 100644
> --- a/src/openvpn/openvpn.c
> +++ b/src/openvpn/openvpn.c
> @@ -210,6 +210,13 @@ openvpn_main(int argc, char *argv[])
>              /* parse command line options, and read configuration file */
>              parse_argv(&c.options, argc, argv, M_USAGE, OPT_P_DEFAULT, N=
ULL, c.es);
>=20=20
> +#if ENABLE_FIPS
> +			if (c.options.fips_mode) {
> +				if (enable_fips_mode(c.options.fips_mode)) {
> +					break;
> +					}
> +				}

more indentation.

Then, if openvpn has been compiled with FIPS support, is it "allowed" to
have this binary run with FIPS mode disabled? Shouldn't it be enabled
all the time?

And generally speaking: what would be a use case for not using FIPS on a
FIPS enabled platform?

> +#endif
>  #ifdef ENABLE_PLUGIN
>              /* plugins may contribute options configuration */
>              init_verb_mute(&c, IVM_LEVEL_1);
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 8e5cdf7..8a1501c 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -522,6 +522,11 @@ static const char usage_message[] =3D
>      "\n"
>      "Data Channel Encryption Options (must be compatible between peers):=
\n"
>      "(These options are meaningful for both Static Key & TLS-mode)\n"
> +#ifdef ENABLE_FIPS
> +	"--enable-fips-mode : Enable OpenSSL FIPS Object Module v2.0.\n"
> +	"                  Setting this on the server will enforce FIPS validat=
ed\n"
> +	"                  encryption on both client and server.\n"
> +#endif
>      "--secret f [d]  : Enable Static Key encryption mode (non-TLS).\n"
>      "                  Use shared secret file f, generate with --genkey.=
\n"
>      "                  The optional d parameter controls key directional=
ity.\n"
> @@ -854,6 +859,9 @@ init_options(struct options *o, const bool init_gc)
>  #endiffips
>  #ifdef ENABLE_CRYPTO
>      o->ciphername =3D "BF-CBC";
> +#ifdef ENABLE_FIPS
> +	o->fips_mode =3D 0;

why not bool?

> +#endif
>  #ifdef HAVE_AEAD_CIPHER_MODES /* IV_NCP=3D2 requires GCM support */
>      o->ncp_enabled =3D true;
>  #else
> @@ -1561,6 +1569,7 @@ show_settings(const struct options *o)
>  #endif
>=20=20
>  #ifdef ENABLE_CRYPTO
> +	SHOW_INT(fips_mode);
>      SHOW_BOOL(show_ciphers);
>      SHOW_BOOL(show_digests);
>      SHOW_BOOL(show_engines);
> @@ -7442,6 +7451,13 @@ add_option(struct options *options,
>      }
>  #endif /* USE_COMP */
>  #ifdef ENABLE_CRYPTO
> +#ifdef ENABLE_FIPS
> +	else if (streq(p[0], "enable-fips-mode") && !p[1])
> +	{
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +		options->fips_mode =3D 1;
> +	}
> +#endif
>      else if (streq(p[0], "show-ciphers") && !p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 035c6d1..55d2248 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -189,6 +189,7 @@ struct options
>      int persist_mode;
>=20=20
>  #ifdef ENABLE_CRYPTO
> +	int fips_mode;
>      const char *key_pass_file;
>      bool show_ciphers;
>      bool show_digests;
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 843bc39..6a212b8 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -354,6 +354,14 @@ init_ssl_lib(void)
>      crypto_init_lib();
>  }
>=20=20
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
> @@ -1640,8 +1648,8 @@ tls1_P_hash(const md_kt_t *md_kt,
>      chunk =3D md_kt_size(md_kt);
>      A1_len =3D md_kt_size(md_kt);
>=20=20
> -    hmac_ctx_init(ctx, sec, sec_len, md_kt);
> -    hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt);
> +    hmac_ctx_init(ctx, sec, sec_len, md_kt, true);
> +    hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt, true);
>=20=20
>      hmac_ctx_update(ctx,seed,seed_len);
>      hmac_ctx_final(ctx, A1);
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index 0e0f68f..ae23423 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -600,6 +600,10 @@ bool is_hard_reset(int op, int key_method);
>=20=20
>  void delayed_auth_pass_purge(void);
>=20=20
> +#if ENABLE_FIPS
> +int enable_fips_mode(int mode);
> +#endif
> +
>  #endif /* ENABLE_CRYPTO */
>=20=20
>  #endif /* ifndef OPENVPN_SSL_H */
>=20

In general, you can check if the code is compliant with the codestyle by
running uncrustify with the configuration stored in dev-tools/

Cheers,


--=20
Antonio Quartulli


--iseDXukojDDB0tSn9JFFiDTjVVfuPnA7j--

--JmqJU2Cr6uO6QHNIss7kaRnv7VBxOwAHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlojhDgACgkQB6U8WA7y
zXSGKg/+O/NpM8x7YezN5Q7kbQ5WTKcAd+vLPynQERpufDbxEJ/umeiU8rAxe3vP
qTAcrbcWoTWRoLwYuj/2f6A19LvqGoso7Yvz60P7B99TtW4iom8ZtnfPcazlK+B4
yepjw11lamz9fAuZUbG8z8cjyMEFNVRjkX9wkh2sPYBT2hBBnzHzc8O7BBO9Jm8E
6ruNJ8OpjexSuKgJSbER9tJplYRmBiHI7rpqtA/LcMRfbzyIjHiCO7pR3emli94J
Wixto5JapZy9bA1bsGPdbPCKncGpKMNZ312NUn9dH5sLNL8DzQrzWMKvcW3YOVNA
Ylr0PgmzGd5oCoxEW4+1KJQqmV3EWQ2Bv9JpMeZUz4aDAvRQ2anvcnEEsUakfRuO
jJIF2MetwwIBCFWFOLJYa86lYPY/oYUvUIUduiQ9nPe5yC+Ei4aB11QAdc5CsozP
TckBR81i3kYNJHhVgpUDRpPaQOpcvydgS4OFdE6kMcLs2y0Apn0Fe7xfCYCuPjGy
lwqowLUcAvGnkGb1um4z2EDfFccL+4wRdakCtB/VwVjy/DZCCXuv6ZcPecteMgq7
izJ41hTg76AtDY6dAJtiwj+RyNZ6SOl36aa128ixg4T2nolsge6jjkJLpzM4OrOU
ojGpmDqbl6jo0aHgCmhjIRmxBqnW+4udEzXMCSXGMOPk7r4jHgg=
=TrVi
-----END PGP SIGNATURE-----

--JmqJU2Cr6uO6QHNIss7kaRnv7VBxOwAHS--

