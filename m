Date: Wed, 11 Aug 2021 13:03:35 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <0Pd7Zsu7ebJs6u2vGi5Uni2lD1cc5oRlv8A4BMTwjS7NYKojnTJyVztq8NetmXXy12MjM5mcr6xLuz5B-gvfTeZFwLIJjQOijmnPbnjwcL8=@protonmail.com>
In-Reply-To: <ca592ce5-3123-35df-7533-f7dc79740cef@...2181...>
References: <20210805180950.838612-1-arne@...1227...>
 <ca592ce5-3123-35df-7533-f7dc79740cef@...2181...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_1UL1JxcDXuhhCsriL5addSwdTGiLcJjGwcL6xnM9TE"
Subject: Re: [Openvpn-devel] [PATCH v3] Modernise OpenVPN defaults and
 introduce '--compat-mode'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--b1_1UL1JxcDXuhhCsriL5addSwdTGiLcJjGwcL6xnM9TE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

a few more wrinkles to smooth out.


Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Wednesday, August 11th, 2021 at 08:29, Antonio Quartulli <a@...2181...> =
wrote:

> Hi,
>
> On 05/08/2021 20:09, Arne Schwabe wrote:
> > TLS 1.0 should not be allowed anymore in a sensible default configurati=
on.
> > Bump the default to TLS 1.2
> > Also modify --cipher not to be automatically appended and default
> > allow-compression to no. This also allows a default configuration to be
> > compatible with DCO.
> >
> > Also introduce --compat-mode version to allow an easy way for UI/users
> > to maximise compatibility to earlier versions at the cost of DCO and
> > security.
> >
> > --compat-mode is only intended as an easier way to set options that
> > are still present. It will not implement options that are removed
> > (e.g. --keysize), so it is meant a best effort option and not as
> > a mean to provide 100% compatibility.


mean -> means


> >
> > Patch v2: rebase
> > Patch v3: Fix version number off by a factor of 10
> >
> > Signed-off-by: Arne Schwabe <arne@...1227...>
> > ---
> >  Changes.rst                          | 23 +++++++
> >  doc/man-sections/generic-options.rst | 21 ++++++
> >  src/openvpn/comp.h                   |  1 +
> >  src/openvpn/options.c                | 97 +++++++++++++++++++++++-----
> >  src/openvpn/options.h                | 17 +++++
> >  src/openvpn/ssl_ncp.c                | 13 ++++
> >  src/openvpn/ssl_ncp.h                |  8 +++
> >  7 files changed, 165 insertions(+), 15 deletions(-)
> >
> > diff --git a/Changes.rst b/Changes.rst
> > index 0323a7f7a..56b4dd39c 100644
> > --- a/Changes.rst
> > +++ b/Changes.rst
> > @@ -45,6 +45,12 @@ Pending auth support for plugins and scripts
> >
> >      See ``sample/sample-scripts/totpauth.py`` for an example.
> >
> > +Compatibility mode (``--compat-mode``)
> > +    The modernisation of defaults can impact the compatibility of Open=
VPN 2.6.0
> > +    with older peers. The options ``--compat-mode`` allows UIs to prov=
ide users
> > +    with an easy way to still connect to older servers.
> > +
> > +
> >  Deprecated features
> >  -------------------
> >  ``inetd`` has been removed
> > @@ -65,6 +71,23 @@ Deprecated features
> >      This option mainly served a role as debug option when NCP was first
> >      introduced. It should now no longer be necessary.
> >
> > +TLS 1.0 and 1.1 are deprecated
> > +    ``tls-version-min`` is set to 1.2 by default.  OpenVPN 2.6.0 defau=
lts
> > +    to a minimum TLS version of 1.2 as TLS 1.0 and 1.1 should be gener=
ally
> > +    avoided. Note that OpenVPN versions older than 2.3.7 use TLS 1.0 o=
nly.
> > +
> > +``--cipher`` options is no longer included in ``--data-ciphers`` by de=
fault
>
> options -> argument ?
>
> > +    Data cipher negotiation has been introduced in 2.4.0 and been sign=
ificantly
> > +    improved in 2.5.0. The implicit fallback to the cipher specified in
> > +    ``--cipher`` has been removed.
> > +
> > +Compression no longer enabled by default
> > +    Unless an explicit compression option is specified in the configur=
ation,
> > +    ``--allow-compression`` defaults to ``no`` in OpeNVPN 2.6.0.
> > +    By default, OpenVPN 2.5 still allowed a server to enable compressi=
on by
> > +    pushing compression related options.
> > +
> > +
> >  Overview of changes in 2.5
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >
> > diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/ge=
neric-options.rst
> > index 203e35f57..739e845ac 100644
> > --- a/doc/man-sections/generic-options.rst
> > +++ b/doc/man-sections/generic-options.rst
> > @@ -52,6 +52,27 @@ which mode OpenVPN is configured as.
> >    BSDs implement a getrandom() or getentropy() syscall that removes the
> >    need for /dev/urandom to be available.
> >
> > +--compat-mode version
> > +  This option provides a way to alter the default of OpenVPN to be more
> > +  compatible with the version ``version`` specified. All of the changes
> > +  this option does can also be achieved using invdivdiual configuration
>
> invdivdiual -> individual

does -> makes

>
> > +  option.
> > +
> > +  Note: Using this options sets reverts defaults to no longer recommen=
ded
>
> options -> option
>
> sets reverts -> reverts
>
> > +  values and should be avoided if possible.
> > +
> > +  The following table details what defaults are changed depending on t=
he
> > +  version specified.
> > +
> > +  - 2.5.x or lower: ``--allow-compression asym`` is automatically added
> > +    to the configuration if no other compression options are present.
> > +  - 2.4.x or lower: The cipher in ``--cipher`` is appended to
> > +    ``--data-ciphers``
> > +  - 2.3.x or lower: ``--data-cipher-fallback`` is automatically added =
with
> > +    the same cipher as ``--cipher``
> > +  - 2.3.6 or lower: ``--tls-version-min 1.0`` is added to the configur=
ation
> > +    when ``--tls-version-min`` is not explicitly set.
> > +
> >  --config file
> >    Load additional config options from ``file`` where each line corresp=
onds
> >    to one command line option, but with the leading '--' removed.
> > diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
> > index cd4f0e1a2..619a574e5 100644
> > --- a/src/openvpn/comp.h
> > +++ b/src/openvpn/comp.h
> > @@ -59,6 +59,7 @@
> >  #define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compres=
sion, even with COMP_F_ADVERTISE_STUBS_ONLY
> >                                              * we still accept other co=
mpressions to be pushed */
> >  #define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo=
 no when we see a client with comp-lzo in occ */
> > +#define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicit=
ly set to allow assymetric compression */


assymetric -> asymetric


> >
> >
> >  /*
> > diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> > index 63cda1e86..20c273063 100644
> > --- a/src/openvpn/options.c
> > +++ b/src/openvpn/options.c
> > @@ -854,6 +854,7 @@ init_options(struct options *o, const bool init_gc)
> >      o->use_prediction_resistance =3D false;
> >  #endif
> >      o->tls_timeout =3D 2;
> > +    o->ssl_flags =3D (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIFT);
> >      o->renegotiate_bytes =3D -1;
> >      o->renegotiate_seconds =3D 3600;
> >      o->renegotiate_seconds_min =3D -1;
> > @@ -3079,8 +3080,12 @@ options_postprocess_verify(const struct options =
*o)
> >  static void
> >  options_postprocess_cipher(struct options *o)
> >  {
> > -    if (!o->pull && !(o->mode =3D=3D MODE_SERVER))
> > +    if (!o->tls_server && !o->tls_client)
> >      {
> > +        /* we are in the classic P2P mode */
> > +        msg( M_WARN, "Cipher negotiation is disabled since TLS "
>
> no space after '('
>
> > +             "mode is not enabled");
> > +
> >          /* If the cipher is not set, use the old default of BF-CBC. We=
 will
> >           * warn that this is deprecated on cipher initialisation, no n=
eed
> >           * to warn here as well */
> > @@ -3101,26 +3106,68 @@ options_postprocess_cipher(struct options *o)
> >          /* We still need to set the ciphername to BF-CBC since various=
 other
> >           * parts of OpenVPN assert that the ciphername is set */
> >          o->ciphername =3D "BF-CBC";
> > +
> > +        msg(M_WARN, "Note: --cipher is not set. Previous OpenVPN versi=
ons "
> > +                    "defaulted to BF-CBC as fallback when cipher negot=
iation "
> > +                    "failed in this case. If you need this fallback pl=
ease add "
> > +                    "'--data-ciphers-fallback 'BF-CBC' to your configu=
ration "
> > +                    "and/or add BF-CBC to --data-ciphers.");
>
> I wonder if we really need this message. Am I wrong or this message will
> simply appear by default once people understand that --cipher is not
> useful anymore?
>
> If you think it is important for people that may get fooled by the new
> behaviour, then I'd suggest to use M_INFO.
>
> >      }
> >      else if (!o->enable_ncp_fallback
> >               && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers=
))
> >      {
> > -        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missi=
ng in"
> > -            " --data-ciphers (%s). Future OpenVPN version will "
> > -            "ignore --cipher for cipher negotiations. "
> > -            "Add '%s' to --data-ciphers or change --cipher '%s' to "
> > -            "--data-ciphers-fallback '%s' to silence this warning.",
> > -            o->ciphername, o->ncp_ciphers, o->ciphername,
> > -            o->ciphername, o->ciphername);
> > -        o->enable_ncp_fallback =3D true;
> > +        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missi=
ng in "
> > +            "--data-ciphers (%s). OpenVPN ignores --cipher for cipher "
> > +            "negotiations. ",
> > +            o->ciphername, o->ncp_ciphers);
> > +    }
> > +}
> > +
> > +static void
> > +options_set_backwards_compatible_options(struct options *o)
> > +{
> > +    /* TLS min version is not set */
> > +    if ((o->ssl_flags & SSLF_TLS_VERSION_MIN_MASK) =3D=3D 0)
> > +    {
> > +        if (!need_compatibility(o, 20307))
> > +        {
> > +            /* 2.3.6 and earlier have TLS 1.0 only, set minimum to TLS=
 1.0 */
> > +            o->ssl_flags =3D (TLS_VER_1_0 << SSLF_TLS_VERSION_MIN_SHIF=
T);
> > +        }
> > +        else
> > +        {
> > +            /* Use TLS 1.2 as proper default */
> > +            o->ssl_flags =3D (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIF=
T);
> > +        }
> > +    }
> >
> > -        /* Append the --cipher to ncp_ciphers to allow it in NCP */
> > -        size_t newlen =3D strlen(o->ncp_ciphers) + 1 + strlen(o->ciphe=
rname) + 1;
> > -        char *ncp_ciphers =3D gc_malloc(newlen, false, &o->gc);
> > +    /* Versions < 2.5.0 do need --cipher in the list of accepted ciphe=
rs.
> > +     * Version 2.4 might probably does not need it but NCP was not so


might is not required here


> > +     * good with 2.4 and ncp-disable might be more common on 2.4 peers.
> > +     * Only do this iif --cipher is not explicitly (BF-CBC). This is n=
ot

iif -> if

> > +     * 100% correct backwards compatible behaviour but 2.5 already beh=
aved like
> > +     * this */
> > +    if (o->ciphername && need_compatibility(o, 20500)
> > +        && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
> > +    {
> > +        append_cipher_to_ncp_list(o, o->ciphername);
> > +    }
> > +
> > +    /* Versions <=3D 2.3.0 additionally might be compiled with --enabl=
e-small and
> > +     * not have OCC strings required for "poor man's NCP" */
> > +    if (o->ciphername &&  need_compatibility(o, 20400))
> > +    {
> > +        o->enable_ncp_fallback =3D true;
> > +    }
> >
> > -        ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_c=
iphers,
> > -                                o->ciphername));
> > -        o->ncp_ciphers =3D ncp_ciphers;
> > +    /* Compression is deprecated and we do not want to announce suppor=
t for it
> > +     * by default anymore, additionally DCO breaks with with compressi=
on.
> > +     * Disable compression by default starting with 2.6.0 if no other
> > +     * compression related options have been explicitly set */
> > +    if (!comp_non_stub_enabled(&o->comp) && !need_compatibility(o, 206=
00)
> > +        && (o->comp.flags =3D=3D 0))
> > +    {
> > +        o->comp.flags =3D COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUB=
S_ONLY;
> >      }
> >  }
> >
> > @@ -3136,6 +3183,8 @@ options_postprocess_mutate(struct options *o)
> >      helper_keepalive(o);
> >      helper_tcp_nodelay(o);
> >
> > +    options_set_backwards_compatible_options(o);
> > +
> >      options_postprocess_cipher(o);
> >      options_postprocess_mutate_invariant(o);
> >
> > @@ -3213,6 +3262,12 @@ options_postprocess_mutate(struct options *o)
> >       * when using --pull
> >       */
> >      pre_connect_save(o);
> > +
> > +    /* Give a general warning at the end of initialisation that defaul=
ts
> > +     * have changed */
> > +    msg(M_WARN, "Note that modernistation of defaults in OpenVPN 2.6 l=
imits "
>
> modernistation -> modernisation
>
> > +                "compatibility with old versions. See Changes.rst and "
> > +                "--compat-mode in the manual for details.");
> >  }
> >
> >  /*
> > @@ -6704,6 +6759,17 @@ add_option(struct options *options,
> >              setenv_str(es, p[1], p[2] ? p[2] : "");
> >          }
> >      }
> > +    else if (streq(p[0], "compat-mode") && p[1] && !p[3])
> > +    {
> > +        unsigned int major, minor, patch;
> > +        if (!(sscanf(p[1], "%u.%u.%u", &major, &minor, &patch) =3D=3D =
3))
> > +        {
> > +            msg(msglevel, "cannot parse version number for -compat-mod=
e: %s", p[1]);
> > +            goto err;
> > +        }
> > +
> > +        options->backwards_compatible =3D major * 10000 + minor * 100 =
+ patch;
> > +    }
> >      else if (streq(p[0], "setenv-safe") && p[1] && !p[3])
> >      {
> >          VERIFY_PERMISSION(OPT_P_SETENV);
> > @@ -7701,6 +7767,7 @@ add_option(struct options *options,
> >          else if (streq(p[1], "asym"))
> >          {
> >              options->comp.flags &=3D ~COMP_F_ALLOW_COMPRESS;
> > +            options->comp.flags |=3D COMP_F_ALLOW_ASYM;
> >          }
> >          else if (streq(p[1], "yes"))
> >          {
> > diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> > index b0e40cb7f..eb4e39f11 100644
> > --- a/src/openvpn/options.h
> > +++ b/src/openvpn/options.h
> > @@ -225,6 +225,10 @@ struct options
> >
> >      /* enable forward compatibility for post-2.1 features */
> >      bool forward_compatible;
> > +    /** What version we should try to be compatible with as major * 10=
000 +
> > +      * minor * 100 + patch, e.g. 2.4.7 =3D> 20407 */
> > +    unsigned int backwards_compatible;
> > +
> >      /* list of options that should be ignored even if unknown */
> >      const char **ignore_unknown_option;
> >
> > @@ -660,6 +664,19 @@ struct options
> >      unsigned int data_channel_crypto_flags;
> >  };
> >
> > +/**
> > + * Returns if we want 'backwards-compatible' to a certain version
>
> Maybe better rephrased:
>
> Returns if
>
> > + * @param version   the first version does that *NOT* need the compati=
bility
> > + *                  e.g. 204000 for all versions <=3D 2.4.0


does that *NOT* need ???

that does not need ??? guessing ..


>
> is there a 0 too many in the example (should be 20400?)? How about
> making the format more explicit?
> At the moment the example is the only thing trying to document the
> version format.
>
>
> On top of that, isn't the example wrong? The definition says "first
> version that *NOT* need.." but the example says <=3D 2.4.0 ?
> It probably should say "<2.4.0"
>
> This said I think this is a bit confusing. See below:
>
> > + * @return          compatibility should be enabled.
> > + */
> > +static inline bool
> > +need_compatibility(const struct options *o, int version)
> > +{
> > +    return o->backwards_compatible !=3D 0 && o->backwards_compatible <=
 version;
>
> How about changing this check to "backwards_compatible <=3D version" ?
>
> This way the function meaning becomes "do we want to be compatible with
> the version specified and older?"
>
>
> > +}
> > +
> > +
> >  #define streq(x, y) (!strcmp((x), (y)))
> >
> >  /*
> > diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
> > index 6967e2bba..022a9dc3b 100644
> > --- a/src/openvpn/ssl_ncp.c
> > +++ b/src/openvpn/ssl_ncp.c
> > @@ -172,6 +172,19 @@ mutate_ncp_cipher_list(const char *list, struct gc=
_arena *gc)
> >      return ret;
> >  }
> >
> > +
> > +void
> > +append_cipher_to_ncp_list(struct options *o, const char *ciphername)
> > +{
> > +    /* Append the --cipher to ncp_ciphers to allow it in NCP */
> > +    size_t newlen =3D strlen(o->ncp_ciphers) + 1 + strlen(ciphername) =
+ 1;
> > +    char *ncp_ciphers =3D gc_malloc(newlen, false, &o->gc);
> > +
> > +    ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphe=
rs,
> > +                            ciphername));
> > +    o->ncp_ciphers =3D ncp_ciphers;
> > +}
> > +
> >  bool
> >  tls_item_in_cipher_list(const char *item, const char *list)
> >  {
> > diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
> > index 4a2601a2e..09ddeb28e 100644
> > --- a/src/openvpn/ssl_ncp.h
> > +++ b/src/openvpn/ssl_ncp.h
> > @@ -102,6 +102,14 @@ tls_peer_ncp_list(const char *peer_info, struct gc=
_arena *gc);
> >  char *
> >  mutate_ncp_cipher_list(const char *list, struct gc_arena *gc);
> >
> > +/**
> > + * Appends the cipher specified by the ciphernamer parameter to to


ciphernamer -> ciphername


> > + * the o->ncp_ciphers list.
> > + * @param o             options struct to modify. Its gc is also used
> > + * @param ciphername    the ciphername to add
> > + */
> > +void append_cipher_to_ncp_list(struct options *o, const char *cipherna=
me);
> > +
> >  /**
> >   * Return true iff item is present in the colon-separated zero-termina=
ted
> >   * cipher list.
> >
>
> I think this patch, although not too big, may be better if split in piece=
s.
>
> IMHO the change to the default should be atomic and clearly motivated.
> In a few months from now we will see this patch changing defaults and we
> will have to remember why we wanted to do that.
>
> The commit message explains what is happening, but not why.
>
> Wouldn't it be better to have one patch of reach default behaviour being
> charged with a concise but focused explanation as to why that default is
> being changed?
>
> After those patches, then another patch could come in implementing
> compat-mode.
>
> IMHO this would give the change history a very good cut. Anybody willing
> to understand what happened can go back and check.
>
> Thoughts?
>
>
> Regards,
>
> p.s. the code per se looks good at first glance.
>
> --
> Antonio Quartulli
>
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJhE8qOACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ2veAgAtOlgEGJ5zKH0YPIwck4s36FcJ1a68VlJQZGpBNGw/gdsm23w
YtiLckbzCQ/d4EuIFx1CX5DOW1oSY+PUYVLVehYkDtHKfCqrBDjbr7r5Rap9
B64mrZgTctr/Vfd9INDPR86Wn90/cDBfMsXNiHMAN25ZvHTlPSZEszmhBnkR
eMDDF6OeWpVhLDIr940FDO2XllJMFZaHjguT+PGLMnImEkXBWkrxCi9Ob5Wk
r5IVS6dPEV5i32g/Msh2O1+TEvuTmReNB7G0IGuuZiN4w795aEi+kTRW3j/g
Ie3niYsZo/dMfavCSLexZ/cQ2FEUfUVdDWXNmR+fu7kfDGEJv49V2Q=3D=3D
=3DdjIW
-----END PGP SIGNATURE-----

--b1_1UL1JxcDXuhhCsriL5addSwdTGiLcJjGwcL6xnM9TE
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

--b1_1UL1JxcDXuhhCsriL5addSwdTGiLcJjGwcL6xnM9TE
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJhE8qOACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ31UAf+L9oz
8rWucYRSwRewpPA9gfUHU4nggQo7ClGHtjRklt33IsE4Lr0LJxnAZILbWGrdmlIzF4Dqfq3EohmF
9VOR4iVOX8fUyzQYAcLs1UVYkBsyFepbbYMrn39ur/tEroBwY8TgSa2/K58yTTJ87cjlUOBkenj3
hi4dWo/9no06lr6KESXfJaVMiNpMy19UvSnaIULvLDSh0JbXiOcwBQdw4jmGlTzkKj4xKzXevrr2
vYG1kQNxTrLPZ24i1nQb1a7+EhsG1QTULGhiz2yhOXFef72uv/VeC3DrCqOVwxgfXUNstBmxHvEs
DkjiGfamwbE0L+5nbq0b0HAiu5b3V5/5sQ==

--b1_1UL1JxcDXuhhCsriL5addSwdTGiLcJjGwcL6xnM9TE--


