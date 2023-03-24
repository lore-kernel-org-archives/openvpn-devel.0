Date: Fri, 24 Mar 2023 09:19:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZB1dAPJAOWFZyWBr@...1296...>
References: <20230323170601.1256132-1-arne@...1227...>
 <20230323170601.1256132-3-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kLW7QJWHVo8ANTO7"
Content-Disposition: inline
In-Reply-To: <20230323170601.1256132-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 3/4] Add 'allow-compression
 stub-only' internally for DCO
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

--kLW7QJWHVo8ANTO7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 23, 2023 at 06:06:00PM +0100, Arne Schwabe wrote:
> index 435e1ca9e..92f7456a4 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3644,10 +3644,16 @@ options_set_backwards_compatible_options(struct o=
ptions *o)
>       *
>       * Disable compression by default starting with 2.6.0 if no other
>       * compression related option has been explicitly set */
> -    if (!comp_non_stub_enabled(&o->comp) && !need_compatibility_before(o=
, 20600)
> -        && (o->comp.flags =3D=3D 0))
> +    if (!need_compatibility_before(o, 20600) && (o->comp.flags =3D=3D 0))
>      {
> -        o->comp.flags =3D COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_=
ONLY;
> +        if (o->comp.alg =3D=3D COMP_ALG_UNDEF)
> +        {
> +            o->comp.flags =3D COMP_F_ALLOW_NOCOMP_ONLY;
> +        }

This breaks the scenario in question ("no compress in config, server pushes
'comp-lzo no'") unconditionally.

I thought we agreed that we only want to break this for "if DCO",
because this is what we *have* to break.

> @@ -3749,6 +3755,12 @@ options_postprocess_mutate(struct options *o, stru=
ct env_set *es)
>          o->tuntap_options.disable_dco =3D !dco_check_option(D_DCO, o)
>                                          || !dco_check_startup_option(D_D=
CO, o);
>      }
> +#ifdef USE_COMP
> +    if (dco_enabled(o))
> +    {
> +        o->comp.flags |=3D COMP_F_ALLOW_NOCOMP_ONLY;
> +    }
> +#endif

... and that's the code for it.


So, NAK, some more hours wasted on testing.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kLW7QJWHVo8ANTO7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkHV0AAAoJEB2Cnv7KVigSa8cL/RLL3/sT/llN0aoT5BTOL9G0
4FE7d8mlzrirRPJZceFT9CkPzjR15WcJ2u/klUjel+4Tg4Y25ux2cDKh4yrlmec0
n0Ms48kNI1r8PwdhQVKggPgyZncmL5Nr0eR9SOo5d0h/7XVrOp87jcsvOHZ/ozJc
cdwhdzpZo4J11Mxq9rEIh4gkB8MdehPORfta0twxEUiX9Brwc7WnmCOh1iQcTKXT
hHQ6VyBPVGCQRTzquoNdDiectNjH6PjAcd5/97ElIioeXZXn4TFQhUlLGWWLYpzm
Ry4GyfKznyimvNqgWPGyRlrKgrQnj/I82ctek0pQVNhmibEamDO9wiNODzsuWQ1u
vFF05KHeKEmX2OA7Hw+oW7XVeb2rt1mh06mT3ZXNc68FgSxMBFI8wqGyUeSluXe9
KxNkzfGGO7ev7WS/LraLXFB4upGyvNQa2lDtiYX3Zndfq4tUAl5+bVwbwjluFac0
ra/P3bksMcZNjSJv4lyiDLwNIjqIjHNzfjXQ7vAIyg==
=Rted
-----END PGP SIGNATURE-----

--kLW7QJWHVo8ANTO7--

