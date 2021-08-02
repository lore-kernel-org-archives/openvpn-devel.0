Date: Mon, 02 Aug 2021 15:20:54 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <TfelenTz3REGwsxaWQptNTjuDLkom1bK9ABp0Sn2y5oDLOkGK1e4WKFKeW1WtgyMzb8uh5Nh3N44XY-831oTtea3vXSzvyDjEUegl1Zh5jQ=@protonmail.com>
In-Reply-To: <20210802115521.699150-1-arne@...1227...>
References: <20210802115521.699150-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_sbSpAxV9p6aq619GzDfd5HxbbtHySEzXaTGdxjX4"
Subject: Re: [Openvpn-devel] [PATCH v2] Modernise OpenVPN defaults and
 introduce '--compat-mode'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--b1_sbSpAxV9p6aq619GzDfd5HxbbtHySEzXaTGdxjX4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

V2 - 13 minor correction ;-)

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Monday, August 2nd, 2021 at 12:55, Arne Schwabe <arne@...1227...> wrote:

> TLS 1.0 should be allowed anymore in a sensible default configuration. Bu=
mp


TLS 1.0 should *not* be allowed


> the default to TLS 1.2
> Also modify --cipher not to be automatically appended and default
> allow-compression to no. This also allows a default configuration to be
> compatible with DCO.
>
> Also introduce --compat-mode version to allow an easy way for UI/users
> to maximise compatibility to earlier versions at the cost of DCO and
> security.
>
> --compat-mode is only intended as an easier way to set options that
> are still present. It will not implement options that are removed
> (e.g. --keysize), so it is meant a best effort option and not as
> a mean to provide 100% compatibility.


mean -> means


>
> Patch v2: rebase
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                          | 23 +++++++
>  doc/man-sections/generic-options.rst | 21 ++++++
>  src/openvpn/comp.h                   |  1 +
>  src/openvpn/options.c                | 97 +++++++++++++++++++++++-----
>  src/openvpn/options.h                | 17 +++++
>  src/openvpn/ssl_ncp.c                | 13 ++++
>  src/openvpn/ssl_ncp.h                |  8 +++
>  7 files changed, 165 insertions(+), 15 deletions(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index 0323a7f7a..cf3329486 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -45,6 +45,12 @@ Pending auth support for plugins and scripts
>
>      See ``sample/sample-scripts/totpauth.py`` for an example.
>
> +Compatibility mode (``--compat-mode``)
> +    The modernisation of defaults can impact the compatibility of OpenVP=
N 2.6.0
> +    with older peers. The options ``--compat-mode`` allows UIs to provid=
e users
> +    an easy way to still connect to older servers.


*with* an easy way -- not important


> +
> +
>  Deprecated features
>  -------------------
>  ``inetd`` has been removed
> @@ -65,6 +71,23 @@ Deprecated features
>      This option mainly served a role as debug option when NCP was first
>      introduced. It should now no longer be necessary.
>
> +TLS 1.0 and 1.1 are deprecated
> +    ``tls-version-min`` is set to 1.2 by default.  OpenVPN 2.6.0 defaults
> +    to a minimum TLS version of 1.2 as TLS 1.0 and 1.1 should be general=
ly
> +    avoided. Note that OpenVPN versions older than 2.3.7 use TLS 1.0 onl=
y.
> +
> +``--cipher`` options is no longer included in ``--data-ciphers`` by defa=
ult
> +    Data cipher negotiation has been introduced in 2.4.0 and been signif=
icantly
> +    improved in 2.5.0. The implicit fallback to the cipher specified in
> +    ``--cipher`` has been removed.
> +
> +Compression no longer enabled by default
> +    Unless an explicit compression option is specified in the configurat=
ion,
> +    ``--allow-compression`` defaults to ``no`` in OpeNVPN 2.6.0.
> +    OpenVPN 2.5 still allowed by default a server to enable compression =
by


By default, OpenVPN 2.5 still allowed a server to enable compression


> +    pushing compression related options.
> +
> +
>  Overview of changes in 2.5
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/gene=
ric-options.rst
> index 203e35f57..739e845ac 100644
> --- a/doc/man-sections/generic-options.rst
> +++ b/doc/man-sections/generic-options.rst
> @@ -52,6 +52,27 @@ which mode OpenVPN is configured as.
>    BSDs implement a getrandom() or getentropy() syscall that removes the
>    need for /dev/urandom to be available.
>
> +--compat-mode version
> +  This option provides a way to alter the default of OpenVPN to be more
> +  compatible with the version ``version`` specified. All of the changes
> +  this option does can also be achieved using invdivdiual configuration


does -> makes

invdivdiual - invdividual


> +  option.
> +
> +  Note: Using this options sets reverts defaults to no longer recommended


'sets' is out of place and unnecessary


> +  values and should be avoided if possible.
> +
> +  The following table details what defaults are changed depending on the
> +  version specified.
> +
> +  - 2.5.x or lower: ``--allow-compression asym`` is automatically added
> +    to the configuration if no other compression options are present.
> +  - 2.4.x or lower: The cipher in ``--cipher`` is appended to
> +    ``--data-ciphers``
> +  - 2.3.x or lower: ``--data-cipher-fallback`` is automatically added wi=
th
> +    the same cipher as ``--cipher``
> +  - 2.3.6 or lower: ``--tls-version-min 1.0`` is added to the configurat=
ion
> +    when ``--tls-version-min`` is not explicitly set.
> +
>  --config file
>    Load additional config options from ``file`` where each line correspon=
ds
>    to one command line option, but with the leading '--' removed.
> diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
> index cd4f0e1a2..619a574e5 100644
> --- a/src/openvpn/comp.h
> +++ b/src/openvpn/comp.h
> @@ -59,6 +59,7 @@
>  #define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compressi=
on, even with COMP_F_ADVERTISE_STUBS_ONLY
>                                              * we still accept other comp=
ressions to be pushed */
>  #define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo n=
o when we see a client with comp-lzo in occ */
> +#define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly=
 set to allow assymetric compression */
>
>
>  /*
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 63cda1e86..cd6d464a3 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -854,6 +854,7 @@ init_options(struct options *o, const bool init_gc)
>      o->use_prediction_resistance =3D false;
>  #endif
>      o->tls_timeout =3D 2;
> +    o->ssl_flags =3D (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIFT);
>      o->renegotiate_bytes =3D -1;
>      o->renegotiate_seconds =3D 3600;
>      o->renegotiate_seconds_min =3D -1;
> @@ -3079,8 +3080,12 @@ options_postprocess_verify(const struct options *o)
>  static void
>  options_postprocess_cipher(struct options *o)
>  {
> -    if (!o->pull && !(o->mode =3D=3D MODE_SERVER))
> +    if (!o->tls_server && !o->tls_client)
>      {
> +        /* we are in the classic P2P mode */
> +        msg( M_WARN, "Cipher negotiation is disabled since TLS "
> +             "mode is not enabled");
> +
>          /* If the cipher is not set, use the old default of BF-CBC. We w=
ill
>           * warn that this is deprecated on cipher initialisation, no need
>           * to warn here as well */
> @@ -3101,26 +3106,68 @@ options_postprocess_cipher(struct options *o)
>          /* We still need to set the ciphername to BF-CBC since various o=
ther
>           * parts of OpenVPN assert that the ciphername is set */
>          o->ciphername =3D "BF-CBC";
> +
> +        msg(M_WARN, "Note: --cipher is not set. Previous OpenVPN version=
s "
> +                    "defaulted to BF-CBC as fallback when cipher negotia=
tion "
> +                    "failed in this case. If you need this fallback plea=
se add "
> +                    "'--data-ciphers-fallback 'BF-CBC' to your configura=
tion "
> +                    "and/or add BF-CBC to --data-ciphers.");
>      }
>      else if (!o->enable_ncp_fallback
>               && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
>      {
> -        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing=
 in"
> -            " --data-ciphers (%s). Future OpenVPN version will "
> -            "ignore --cipher for cipher negotiations. "
> -            "Add '%s' to --data-ciphers or change --cipher '%s' to "
> -            "--data-ciphers-fallback '%s' to silence this warning.",
> -            o->ciphername, o->ncp_ciphers, o->ciphername,
> -            o->ciphername, o->ciphername);
> -        o->enable_ncp_fallback =3D true;
> +        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing=
 in "
> +            "--data-ciphers (%s). OpenVPN ignores --cipher for cipher "
> +            "negotiations. ",
> +            o->ciphername, o->ncp_ciphers);
> +    }
> +}
> +
> +static void
> +options_set_backwards_compatible_options(struct options *o)
> +{
> +    /* TLS min version is not set */
> +    if ((o->ssl_flags & SSLF_TLS_VERSION_MIN_MASK) =3D=3D 0)
> +    {
> +        if (!need_compatibility(o, 203070))
> +        {
> +            /* 2.3.6 and earlier have TLS 1.0 only, set minimum to TLS 1=
.0 */
> +            o->ssl_flags =3D (TLS_VER_1_0 << SSLF_TLS_VERSION_MIN_SHIFT);
> +        }
> +        else
> +        {
> +            /* Use TLS 1.2 as proper default */
> +            o->ssl_flags =3D (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIFT);
> +        }
> +    }
>
> -        /* Append the --cipher to ncp_ciphers to allow it in NCP */
> -        size_t newlen =3D strlen(o->ncp_ciphers) + 1 + strlen(o->ciphern=
ame) + 1;
> -        char *ncp_ciphers =3D gc_malloc(newlen, false, &o->gc);
> +    /* Versions < 2.5.0 do need --cipher in the list of accepted ciphers.
> +     * Version 2.4 might probably does not need it but NCP was not so


'might' is out of place and unnecessary


> +     * good with 2.4 and ncp-disable might be more common on 2.4 peers.
> +     * Only do this iif --cipher is not explicitly (BF-CBC). This is not


iif -> if

Brackets around (BFCBC) ?


> +     * 100% correct backwards compatible behaviour but 2.5 already behav=
ed like
> +     * this */
> +    if (o->ciphername && need_compatibility(o, 205000)
> +        && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
> +    {
> +        append_cipher_to_ncp_list(o, o->ciphername);
> +    }
> +
> +    /* Versions <=3D 2.3.0 additionally might be compiled with --enable-=
small and
> +     * not have OCC strings required for "poor man's NCP" */
> +    if (o->ciphername &&  need_compatibility(o, 204000))
> +    {
> +        o->enable_ncp_fallback =3D true;
> +    }
>
> -        ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_cip=
hers,
> -                                o->ciphername));
> -        o->ncp_ciphers =3D ncp_ciphers;
> +    /* Compression is deprecated and we do not want to announce support =
for it
> +     * by default anymore, additionally DCO breaks with with compression.
> +     * Disable compression by default starting with 2.6.0 if no other
> +     * compression related options have been explicitly set */
> +    if (!comp_non_stub_enabled(&o->comp) && !need_compatibility(o, 20600=
0)
> +        && (o->comp.flags =3D=3D 0))
> +    {
> +        o->comp.flags =3D COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_=
ONLY;
>      }
>  }
>
> @@ -3136,6 +3183,8 @@ options_postprocess_mutate(struct options *o)
>      helper_keepalive(o);
>      helper_tcp_nodelay(o);
>
> +    options_set_backwards_compatible_options(o);
> +
>      options_postprocess_cipher(o);
>      options_postprocess_mutate_invariant(o);
>
> @@ -3213,6 +3262,12 @@ options_postprocess_mutate(struct options *o)
>       * when using --pull
>       */
>      pre_connect_save(o);
> +
> +    /* Give a general warning at the end of initialisation that defaults
> +     * have changed */
> +    msg(M_WARN, "Note that modernistation of defaults in OpenVPN 2.6 lim=
its "


modernistation -> modernisation


> +                "compatibility with old versions. See Changes.rst and "
> +                "--compat-mode in the manual for details.");
>  }
>
>  /*
> @@ -6704,6 +6759,17 @@ add_option(struct options *options,
>              setenv_str(es, p[1], p[2] ? p[2] : "");
>          }
>      }
> +    else if (streq(p[0], "compat-mode") && p[1] && !p[3])
> +    {
> +        unsigned int major, minor, patch;
> +        if (!(sscanf(p[1], "%u.%u.%u", &major, &minor, &patch) =3D=3D 3))
> +        {
> +            msg(msglevel, "cannot parse version number for -compat-mode:=
 %s", p[1]);
> +            goto err;
> +        }
> +
> +        options->backwards_compatible =3D major * 10000 + minor * 100 + =
patch;
> +    }
>      else if (streq(p[0], "setenv-safe") && p[1] && !p[3])
>      {
>          VERIFY_PERMISSION(OPT_P_SETENV);
> @@ -7701,6 +7767,7 @@ add_option(struct options *options,
>          else if (streq(p[1], "asym"))
>          {
>              options->comp.flags &=3D ~COMP_F_ALLOW_COMPRESS;
> +            options->comp.flags |=3D COMP_F_ALLOW_ASYM;
>          }
>          else if (streq(p[1], "yes"))
>          {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index b0e40cb7f..925083865 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -225,6 +225,10 @@ struct options
>
>      /* enable forward compatibility for post-2.1 features */
>      bool forward_compatible;
> +    /** What version we should try to be compatible with as major * 1000=
0 +
> +      * minor * 100 + patch, e.g. 2.4.7 =3D> 204070 */
> +    unsigned int backwards_compatible;
> +
>      /* list of options that should be ignored even if unknown */
>      const char **ignore_unknown_option;
>
> @@ -660,6 +664,19 @@ struct options
>      unsigned int data_channel_crypto_flags;
>  };
>
> +/**
> + * Returns if we want 'backwards-compatible' to a certain version
> + * @param version   the first version does that *NOT* need the compatibi=
lity
> + *                  e.g. 204000 for all versions <=3D 2.4.0
> + * @return          compatibility should be enabled.
> + */
> +static inline bool
> +need_compatibility(const struct options *o, int version)
> +{
> +    return o->backwards_compatible !=3D 0 && o->backwards_compatible < v=
ersion;
> +}
> +
> +
>  #define streq(x, y) (!strcmp((x), (y)))
>
>  /*
> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
> index 6967e2bba..022a9dc3b 100644
> --- a/src/openvpn/ssl_ncp.c
> +++ b/src/openvpn/ssl_ncp.c
> @@ -172,6 +172,19 @@ mutate_ncp_cipher_list(const char *list, struct gc_a=
rena *gc)
>      return ret;
>  }
>
> +
> +void
> +append_cipher_to_ncp_list(struct options *o, const char *ciphername)
> +{
> +    /* Append the --cipher to ncp_ciphers to allow it in NCP */
> +    size_t newlen =3D strlen(o->ncp_ciphers) + 1 + strlen(ciphername) + =
1;
> +    char *ncp_ciphers =3D gc_malloc(newlen, false, &o->gc);
> +
> +    ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers,
> +                            ciphername));
> +    o->ncp_ciphers =3D ncp_ciphers;
> +}
> +
>  bool
>  tls_item_in_cipher_list(const char *item, const char *list)
>  {
> diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
> index 4a2601a2e..09ddeb28e 100644
> --- a/src/openvpn/ssl_ncp.h
> +++ b/src/openvpn/ssl_ncp.h
> @@ -102,6 +102,14 @@ tls_peer_ncp_list(const char *peer_info, struct gc_a=
rena *gc);
>  char *
>  mutate_ncp_cipher_list(const char *list, struct gc_arena *gc);
>
> +/**
> + * Appends the cipher specified by the ciphernamer parameter to to


ciphernamer -> ciphername, drop the 'r'


> + * the o->ncp_ciphers list.
> + * @param o             options struct to modify. Its gc is also used
> + * @param ciphername    the ciphername to add
> + */
> +void append_cipher_to_ncp_list(struct options *o, const char *ciphername=
);
> +
>  /**
>   * Return true iff item is present in the colon-separated zero-terminated


iff -> if


>   * cipher list.
> --
> 2.32.0
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJhCA1CACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ2EKAgAlgY56kyo6+hVDb9zB1t2aOB4xsaJ4TFV9USMdY+ooSL0+QTi
hAdFKXxG7hqgmEicVsFirQ7ydLpfpmJNtK6rkh1O4eEvzqg1lwvxuZQ6Iv9g
uOopYj5DZR0oIXPS62sFXTWX0kHeJMn7uihCOeVe2DvTC6jpsCHMZf3iIKqU
ITgl7PEpeBWiatiWiDozIJMyMxy1xdJ/uy/DTZLH03DOUtrGzBnUnOzWD+0A
Qw8+qey+BB/5duA+vhe0vocOq+9b/Qw5rI241QzCCNSPxBdOwa28YHy3cdgA
BDZzhNlab8suog1FLtyTwQ3hGREjVbPlKw/ek/d49CK5PlE0pU+kOw=3D=3D
=3DUDQ/
-----END PGP SIGNATURE-----

--b1_sbSpAxV9p6aq619GzDfd5HxbbtHySEzXaTGdxjX4
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNCTkJGdndTY2NC
Q0FET21IRW5RbExtT2pKUnRKTDJsNTNNTHd3RlR5N1huRXBzM2IxUTBVd1dZRkN2DQpMMm9OcDBu
cmRHbEtLREpxNTBZMDlTUitVUllCUW1LbVkzRW16cHlVSUtNL3JnbzFSeXViSHBNUkhiRHANCjdK
cDhMeGtmZkZCVkpqL3Q1Vk1wRDZlTVI2YVVjaVFqZ1JMOE5aZTYrVDd4ZlhYWHdWNWhvUmVaM2pP
Kw0KekhpNlNSN3hUdkdYbGErTVF6NkVFcFdubGJMdmcyb3J0OUtzZXVWallycXZSTXhjZFAwbzlj
WldKNWVwDQpKTm1nZUI2TTcrT1cwOFUxU3NYdEtycExSY0k2eUttVjM4amh6UHIyWmdQOXJtcmxF
clIvMWlxUVFIWFkNCm84LzBEZlB5RjBtSDl5blFJaUxFL2wrRll1NHJzRzhWaUtseGhYY3plUHpB
dExDamlCMGEwbVJWQUJFQg0KQUFITk55SjBhVzVqWVc1MFpXTm9RSEJ5YjNSdmJtMWhhV3d1WTI5
dElpQThkR2x1WTJGdWRHVmphRUJ3DQpjbTkwYjI1dFlXbHNMbU52YlQ3Q3dIOEVFQUVJQUNrRkFs
dndTY2NHQ3drSENBTUNDUkJQbDV6MmE1QzQNCm5RUVZDQW9DQXhZQ0FRSVpBUUliQXdJZUFRQUtD
UkJQbDV6MmE1QzRuUUJEQi85WlVvOUJPWEpSNjFObQ0KMDJvWi84YVJYTzlOblVTRnQ2R0xPV2NE
TnZBczRJSldNRFZFUWZZYW5iKzQyMVFOZC81ZDZIMWlYRitpDQo0TERLME02YWdDK2dzTkZKbmpQ
R0l0dlB0ajdXeWp5blpSeDhENDBQUFhpZ2ZIWXV3Mm9SdTBscitQMXANCjFxZVVlNE5iY3FJdjhJ
SXZMejJ6Q2xZWk9OZ0FzUVZjTkFIaTdaNG9ydFEyaW8yQkFWai84MTlKUFlNdA0KdEhnWTgxd1Mx
Vjd2OEdEVFpnOG9hUGhYR2ZhQzRUWkZHdFpyL2J5YmNxcnNvMzVqYVFtQzU0eE1iWHBGDQpBVXJj
M3VHVk9IK09kRy9CVzJnY1lxcHZVRkJ1a1h4Q1VCWUhQMk5mWGhOZnpHdDluQzF1bE5LWWVQMTkN
ClRHbE9vckJNWUlBRUhvR3h2cGJVWGZiYU5XQ1V6c0JOQkZ2d1NjY0JDQUM5S3lWWlJTNWFNYUc1
UGkwbg0KZng4YU5vczNiWXAyNDZNdGZhb0tCZlRRQXJkK0daVytXbkZ5SkVpU3lMZHowclV1dHlD
QWRmNWxnVkgrDQpXdkx2SW1pR3JTcnpWcE1UMm5DUzA5THFMNTBRano4QTdncDVIL2hRenRaOGlO
eXNHRDlOTzQ2T25JNzUNCjkwZEhmQ3JYalFQU0Z0RkdzVHpnRHhRSWlNdXp6OURSN0Jla0tQbXVP
RkloQmU5ZUVacWJ4YzhSV2VRdA0KaGE3aS9EckpUUk5LMWFPQURRRlZ1VjEvQW01VGhHUFdGTS9Z
SlV5VFloTVcweWVQaDQ1T2JXdVJRWmtzDQpsK2FPbTRMMEtHRERZbG0vRlF4L0VNQ3Vidmx6eS96
eERkQjZucUZpaDJxWnJmeW1uaVNPS2FqRzBqb1QNCnBab3ovRXorNGZBdGc2eTBQc3BOUjZpZEFC
RUJBQUhDd0drRUdBRUlBQk1GQWx2d1NjY0pFRStYblBacg0Ka0xpZEFoc01BQW9KRUUrWG5QWnJr
TGlkUmUwSC9qNUNJRklBdWN1YWlFTWtMa05LRUFPNXM3eDQ3ZU55DQpHUGZac2x5WStIanpHVTBk
MDdNa2tHbVZrUFRWendxVnpOWmJueTdaQXYxemxXMFV5MHlIcDFBUHB5WXQNCjhidVVwcFRCcTdk
NDdvZ3hFUll6dC9MYzJMNWEvVktGTlJiaE4xL1hRbVBpejJFbGU0dHlpcGJUYXBjeQ0KK3pieWZ6
QU1EMTNjSWRaMTNoVHNOUDBvbGdCaEFxVUFVVVlweFJsa0FIZUorRHQzTmJ6SFM0S1FLNTM4DQpO
Si9sN2JYU0tzR3FvWXFKZVo4Vk5CeHdXV1VidUc0ampyaDQzTUlSZ1VaNVdzUFVZVjZIeDA1NmtN
amINCi9iWUJqSTBURU12SDgxNjB1cXpGWGVIdll5VWxxMFNpbkQvWjlpb0llOFFkc0hHQkRVSVJZ
WXViMXBPOA0KcXJDelJaeDBvTkE9DQo9L0RlYQ0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxP
Q0stLS0tLQ0K

--b1_sbSpAxV9p6aq619GzDfd5HxbbtHySEzXaTGdxjX4
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJhCA1CACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ2UdAgAuVT7
poDoB/D9cdQt+if81Bujawbak9vcNzWJ84e4jINeUdnJQ1ap90GlBCi0wJUA+NLc39XclhL/JNvC
enI791EaPsqtEvqWPZghK5Nvr5GTx9RsUt/s/IBN8JsuYIHcXIBDwAiAIm7v0aXdwfsxuUCBr7i8
UzXbbx1JIJnn96xjaQZxCUmLeKZq1iRuxzFrDrUvBUXP0NATVETmKzDA80/sk68sye5uBQOJT/il
mnmqiRzlxTxj2He2Pm1njn7Q5KKWkjFEKeq+5eCdCJFWcY7G5zU7YtcQ5zbF3sO1shB1E13JvzNb
yZdd6rrGpEm2hJ0df0hZq+D1v9qpnfWesQ==

--b1_sbSpAxV9p6aq619GzDfd5HxbbtHySEzXaTGdxjX4--


