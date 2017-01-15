Date: Sun, 15 Jan 2017 19:19:25 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170115111925.GD3690@...2182...>
References: <20170114163058.20106-1-a@...2181...>
	<d476bda5-1403-ad9d-1eb6-a1ecd5761f3c@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Content-Disposition: inline
In-Reply-To: <d476bda5-1403-ad9d-1eb6-a1ecd5761f3c@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v3] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, Jan 15, 2017 at 10:36:24AM +0100, Steffan Karger wrote:
> > diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> > index 944f4c5..9a7745f 100644
> > --- a/src/openvpn/crypto.c
> > +++ b/src/openvpn/crypto.c
> > @@ -36,6 +36,7 @@
> >  #include "crypto.h"
> >  #include "error.h"
> >  #include "integer.h"
> > +#include "misc.h"
>=20
> Adding a dependency to misc.o breaks the unit tests.  Just try to run
> 'make check' now (after initializing the cmocka submodule).
>=20
> I see that this added dependency is because you added
> 'print_if_inline()' in misc.c.  It seems to be used only to print key
> filenames though.  What about renaming it to print_key_filename() and
> moving it to crypto.c?

Yeah, makes sense. I'll move it to crypto.c

>=20
> > +/*
> > + * A wrapper for check_file_access_chroot() that returns false immedia=
tely if
> > + * the file is inline (and therefore there is no access to check)
> > + */
> > +static bool
> > +check_file_access_chroot_inline(bool is_inline, const char *chroot,
> > +                                const int type, const char *file,
> > +                                const int mode, const char *opt)
> > +{
> > +    if (is_inline)
> > +    {
> > +        return false;
> > +    }
> > +
> > +    return check_file_access_chroot(chroot, type, file, mode, opt);
> > +}
> > +
> > +/*
> > + * A wrapper for check_file_access() that returns false immediately if=
 the file
> > + * is inline (and therefore there is no access to check)
> > + */
> > +static bool
> > +check_file_access_inline(bool is_inline, const int type, const char *f=
ile,
> > +                         const int mode, const char *opt)
> > +{
> > +    if (is_inline)
> > +    {
> > +        return false;
> > +    }
> > +
> > +    return check_file_access(type, file, mode, opt);
> > +}
>=20
> If you start these with /**, rather than /*, they will end up nicely in
> the doxygen.

Yeah .. I usually do it, but this time I forgot :) will fix that.

>=20
> >  static bool
> > -check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
> > +check_inline_file(struct in_src *is, char *p[], bool *is_inline,
> > +                  struct gc_arena *gc)
> >  {
> >      bool ret =3D false;
> > +
> > +    *is_inline =3D false;
> >      if (p[0] && !p[1])
> >      {
> >          char *arg =3D p[0];
> >          if (arg[0] =3D=3D '<' && arg[strlen(arg)-1] =3D=3D '>')
> >          {
> >              struct buffer close_tag;
> > +            *is_inline =3D true;
> >              arg[strlen(arg)-1] =3D '\0';
> >              p[0] =3D string_alloc(arg+1, gc);
> > -            p[1] =3D string_alloc(INLINE_FILE_TAG, gc);
> >              close_tag =3D alloc_buf(strlen(p[0]) + 4);
> >              buf_printf(&close_tag, "</%s>", p[0]);
> > -            p[2] =3D read_inline_file(is, BSTR(&close_tag), gc);
> > -            p[3] =3D NULL;
> > +            p[1] =3D read_inline_file(is, BSTR(&close_tag), gc);
> > +            p[2] =3D NULL;
> >              free_buf(&close_tag);
> >              ret =3D true;
> >          }
>=20
> This function now returns the same value as is set to *is_line.  I think
> we should just use the return value.  (For some reason the return value
> wasn't used anywhere previously, but let's just do so now.)

eheh nice catch. I will remove the parameter and re-use the return value.

>=20
> >  static void
> >  add_option(struct options *options,
> >             char *p[],
> > +           bool is_inline,
> >             const char *file,
> >             int line,
> >             const int level,
> > @@ -4506,6 +4561,7 @@ read_config_file(struct options *options,
> >                   struct env_set *es)
> >  {
> >      const int max_recursive_levels =3D 10;
> > +    bool is_inline;
>=20
> is_inline is only used below, in the if(parse_line()) scope.  I think it
> should be declared in that scope.


oh ok. I am not used to that, so I completely missed it. will do!

>=20
> >      FILE *fp;
> >      int line_num;
> >      char line[OPTION_LINE_SIZE+1];
> > @@ -4544,8 +4600,10 @@ read_config_file(struct options *options,
> >                  if (parse_line(line + offset, p, SIZE(p), file, line_n=
um, msglevel, &options->gc))
> >                  {
> >                      bypass_doubledash(&p[0]);
> > -                    check_inline_file_via_fp(fp, p, &options->gc);
> > -                    add_option(options, p, file, line_num, level, msgl=
evel, permission_mask, option_types_found, es);
> > +                    check_inline_file_via_fp(fp, p, &is_inline, &optio=
ns->gc);
> > +                    add_option(options, p, is_inline, file, line_num, =
level,
> > +                               msglevel, permission_mask, option_types=
_found,
> > +                               es);
> >                  }
> >              }
> >              if (fp !=3D stdin)
> > @@ -4578,6 +4636,7 @@ read_config_string(const char *prefix,
> >      char line[OPTION_LINE_SIZE];
> >      struct buffer multiline;
> >      int line_num =3D 0;
> > +    bool is_inline;
> >      buf_set_read(&multiline, (uint8_t *)config, strlen(config));
> >=20=20
> > @@ -4589,8 +4648,9 @@ read_config_string(const char *prefix,
> >          if (parse_line(line, p, SIZE(p), prefix, line_num, msglevel, &=
options->gc))
> >          {
> >              bypass_doubledash(&p[0]);
> > -            check_inline_file_via_buf(&multiline, p, &options->gc);
> > -            add_option(options, p, prefix, line_num, 0, msglevel, perm=
ission_mask, option_types_found, es);
> > +            check_inline_file_via_buf(&multiline, p, &is_inline, &opti=
ons->gc);
> > +            add_option(options, p, is_inline, prefix, line_num, 0, msg=
level,
> > +                       permission_mask, option_types_found, es);
> >          }
> >          CLEAR(p);
> >      }
>=20
> Same as above, move is_inline to the scope where it's used.

copy that!

>=20
> > --- a/src/openvpn/plugin.c
> > +++ b/src/openvpn/plugin.c
> > @@ -160,13 +160,13 @@ plugin_option_list_new(struct gc_arena *gc)
> >      return ret;
> >  }
> >=20=20
> > -bool
> > -plugin_option_list_add(struct plugin_option_list *list, char **p, stru=
ct gc_arena *gc)
> > +bool plugin_option_list_add(struct plugin_option_list *list, char **p,
> > +                            struct gc_arena *gc)
>=20
> The return type should stay on it's own line.
>=20

argh, my bad again!


Will fix these minor glitches and send v4!

Thank you for the feedback!

Cheers,

--=20
Antonio Quartulli

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYe1q7AAoJEJ6F1zG2JyOs3DAP/0aLeJ2pVOmkiDflWe98D8nJ
G+bPf8Fqr3b7pAJ6cmfD3yN/PIDwpqtUc0K8U7zwXSNe+0s4wnXL8Cf0E8rHEtx/
RaLDXelLGu68SltqUp2FlhrSVC81c18uykf++klvGBUFDUF1LL4UeXJ4iKOPhchF
mX4ycXCAEG45HfECxYvBeJOOEpWuPLOWgwzzf8PMdpSOTWnCa9h+EBqAL6hGCASy
8QWJPRRfjWCWQUViCp+IsncU92S7Pj53gzxTgf+oTkVSzuSNhk4PQVXOzdouPzNd
Vh63wrupJoK2nLrLAn3Ogg6v1a8lt4sd97rGEkCSHki8Wh/N4Kiw0IHHPI5KLwcq
92714GDV1hImfl7wHo76U2m0KJqigTXLp0JGBvVo8+N1qRv4TDzvCmbJkc9zQ5rF
OzzMgqmrq4WoB+xCpDrAPM8bhxO/vprZb6WpwwC4ZAG95SLx+ds++wstmWpeTTY2
1XpO6p2U3EQHdgXKPQxybByxA1IRmUI0PBbP4NCwm7o2aTseYh/pRI4Ch0EVZlBE
6DPfsds+zwpfnnfyQU3nk2iUnbtsCcIVOSw8kZhkkbY4zw7fjOioPdc+YuPIspD/
Wxz9sv/gjsFwE4CAyM3gvsw5Q0Td8cn3cGClR1B17GtRysf2l8wgIA2EkP3zT5eF
LHhXGVs2vghLA3KRxJ8d
=v9Oo
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--

