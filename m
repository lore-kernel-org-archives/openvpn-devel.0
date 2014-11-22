Message-ID: <54710DC5.9070206@...1227...>
Date: Sat, 22 Nov 2014 23:27:17 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1416687215-26904-1-git-send-email-yegorslists@...1030...>
In-Reply-To: <1416687215-26904-1-git-send-email-yegorslists@...1030...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dhwojc9h6mSPxLeJSF1ECEA2rMXi10OnW"
Subject: Re: [Openvpn-devel] [PATCH] socket: remove duplicate expression
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Yegor Yefremov <yegorslists@...1030...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dhwojc9h6mSPxLeJSF1ECEA2rMXi10OnW
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 22.11.14 21:13, schrieb Yegor Yefremov:
> Found via cppcheck and compile-tested.
>
> Signed-off-by: Yegor Yefremov <yegorslists@...1030...>
> ---
>  src/openvpn/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 29f9958..331a9d9 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -2666,7 +2666,7 @@ proto_is_tcp(int proto)
>  {
>    if (proto < 0 || proto >=3D PROTO_N)
>      ASSERT(0);
> -  return proto =3D=3D PROTO_TCP_CLIENT || proto =3D=3D PROTO_TCP_SERVER =
|| proto =3D=3D PROTO_TCP_CLIENT;
> +  return proto =3D=3D PROTO_TCP_CLIENT || proto =3D=3D PROTO_TCP_SERVER;
>  }
>=20=20
>  int
ACK, probably my mistake.

Arne


--dhwojc9h6mSPxLeJSF1ECEA2rMXi10OnW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlRxDcYACgkQe8+cMNS4zRe4pQCg5z6isfRFqUgBSu6wt0huSiZe
8F0An25fzpIdQ6cPndSSP9/07t1px1BL
=087j
-----END PGP SIGNATURE-----

--dhwojc9h6mSPxLeJSF1ECEA2rMXi10OnW--

