References: <20161128161625.11972-1-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <72330901-1b5a-db8f-7051-19b3ae2c2a74@...2080...>
Date: Tue, 29 Nov 2016 00:56:16 +0100
MIME-Version: 1.0
In-Reply-To: <20161128161625.11972-1-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="JP02SdUQLsbfhfHN75dTjFBjnNB4DrSvA"
Subject: Re: [Openvpn-devel] [PATCH 1/2] show correct default for plugin dir
 in configure help
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JP02SdUQLsbfhfHN75dTjFBjnNB4DrSvA
Content-Type: multipart/mixed; boundary="m0pXJ1RKTtXr9bW6Olr6kxQNFCmia6P2m";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>
Message-ID: <72330901-1b5a-db8f-7051-19b3ae2c2a74@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] show correct default for plugin dir
	in configure help
References: <20161128161625.11972-1-list@...1798...>
In-Reply-To: <20161128161625.11972-1-list@...1798...>

--m0pXJ1RKTtXr9bW6Olr6kxQNFCmia6P2m
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/11/16 17:16, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> Signed-off-by: Christian Hesse <mail@...1798...>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index f4073d0..d0fe889 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -303,7 +303,7 @@ AC_ARG_WITH(
>=20=20
>  AC_ARG_WITH(
>  	[plugindir],
> -	[AS_HELP_STRING([--with-plugindir], [plugin directory @<:@default=3DLIB=
DIR/openvpn@:>@])],
> +	[AS_HELP_STRING([--with-plugindir], [plugin directory @<:@default=3DLIB=
DIR/openvpn/plugins@:>@])],
>  	,
>  	[with_plugindir=3D"\$(libdir)/openvpn/plugins"]
>  )

I think all this --with-pluigndir should be kicked right out and use
PLUGINDIR environment variables instead, as setting this variable in
this way will preserve it better when ./configure is automatically
re-run by make.

This is more likely some left-over clean-up which never happened earlier
on when we had the last big autotools overhaul.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--m0pXJ1RKTtXr9bW6Olr6kxQNFCmia6P2m--

--JP02SdUQLsbfhfHN75dTjFBjnNB4DrSvA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYPMQgAAoJEIbPlEyWcf3yIM8P/iXSzPs8FCWcnvUuGtjsFCR4
gTqhxzytNq7gXx6ZRmDlZEl0zB5cVnWBoXtLy1jH8kHMEegEfapx4v908rSuTdhS
DJ7hQ5yZstaIAmlDizTXERIyVxvni8MsM+8H3S61Kqhv2Un7T+ilsCG99QD57zYH
x4gITAP1EWt0tdRt3umYZrGT21c65KvqPV3XhJpa4PNPK178VyVMg8z+/CjOtJO8
WJn7oFgM2aBSm53SQ5lJUEKvaCQqvTs6hA9eCsHqwQMC6O+Z0pW17I3lMsAOxRc8
jp97JxImSbfWW/F89vfbL4FENi6kGYhqmCEdRx+oPKnhTJYSkcRvWbbqXiIqGYUr
3QshuIjJB1IBg9tdYuSPkib0ffmdm2nJ+f9OL8+3NDuV3smbhrESQxLzZ2bDF4O6
Jj8vkvBqIiHENT0sHylut/rnleRIa9sgksPrUGyN1I6r/9hMjJrzVTR29dTE9cKK
q2NC2m3kcFktM0JSGMUBoWhWhW3kav3JlfeJHXsAmjACQoOIZWIRW77WpysJJf0P
fjScsejNYIWR/nVx5d2DCJL+EbL/9lgKWjLYW4ItmDGacVc/eD+omFBuNorPEVR2
I7NNcPRU2OrzfuqygEliklQgmV0GmZdvvP9RlVIBkdYeSKaxr3jcXrLIPNkTZJtj
UkOVVoORzPAY/l79j1xl
=SrT2
-----END PGP SIGNATURE-----

--JP02SdUQLsbfhfHN75dTjFBjnNB4DrSvA--

