References: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
	<CAKuzo_isWet5tKn3y6Wr4igEFL01UT-xAZTn3K_uka2M1c6JyQ@...278...>
	<531e4123-aa78-6b00-1e10-9ff91cd445ca@...2150...>
	<CAKuzo_jrNwhGHSFkXW4MiaoZyNFV8Jne1tU8eHyqUTECbzm74g@...278...>
From: Noel Kuntze <noel@...2150...>
Message-ID: <34caff62-dcb8-235f-7875-20e58197e1a0@...2150...>
Date: Sun, 10 Jul 2016 20:01:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jrNwhGHSFkXW4MiaoZyNFV8Jne1tU8eHyqUTECbzm74g@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HlEkEKqt3nwMucQ7Jqml2fjqJ8kQKaUVO"
Subject: Re: [Openvpn-devel] [PATCH: tap-windows6] Implement option to
 disable source IP check of ARP requests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HlEkEKqt3nwMucQ7Jqml2fjqJ8kQKaUVO
Content-Type: multipart/mixed; boundary="PKn0ujtuaPi6e2HSLDia0TivtvvNR3WGN"
From: Noel Kuntze <noel@...2150...>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <34caff62-dcb8-235f-7875-20e58197e1a0@...2150...>
Subject: Re: [Openvpn-devel] [PATCH: tap-windows6] Implement option to disable
	source IP check of ARP requests
References: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
	<CAKuzo_isWet5tKn3y6Wr4igEFL01UT-xAZTn3K_uka2M1c6JyQ@...278...>
	<531e4123-aa78-6b00-1e10-9ff91cd445ca@...2150...>
	<CAKuzo_jrNwhGHSFkXW4MiaoZyNFV8Jne1tU8eHyqUTECbzm74g@...278...>
In-Reply-To: <CAKuzo_jrNwhGHSFkXW4MiaoZyNFV8Jne1tU8eHyqUTECbzm74g@...278...>

--PKn0ujtuaPi6e2HSLDia0TivtvvNR3WGN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 10.07.2016 19:58, Selva Nair wrote:
> Hi,
>=20
>     The instructions in Selva's link weren't enough to convince windows t=
o trust the driver. I had to also enable debug mode and I signed it with on=
e of my own certificates.
>=20
>=20
> You have to sign the driver even in test-signing mode -- only the require=
ment for verified signature is not imposed so that the developer can use a =
self-signed certificate. This is explained in the test-signing docs on MSDN.
>=20
> Selva
Hello Selva,

That's what I did, but Windows did not accept the signed driver and display=
ed an error in the device manager. My application could not open a handle o=
n the TAP device. Therefore it did not work correctly.

--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards,
Noel Kuntze

GPG Key ID: 0x63EC6658
Fingerprint: 23CA BB60 2146 05E7 7278 6592 3839 298F 63EC 6658



--PKn0ujtuaPi6e2HSLDia0TivtvvNR3WGN--

--HlEkEKqt3nwMucQ7Jqml2fjqJ8kQKaUVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQI0BAEBCAAeBQJXgo2CFxxub2VsQGZhbWlsaWUta3VudHplLmRlAAoJEDg5KY9j
7GZYdRoP/38EXQs6FHu7Ye837LO6uI5J3uQKP2A8KLRYpO/R4KdnkG7ImwaD9Yxb
qGNf+H+n8mmyr30SVgRpH/OUZ/qvYy/l66qWNaJYiwBcLpf21/tlqj3LTaS2XT8e
l51KbqZGkssDWfGNqbaTslOHluLvrJe2/ed/LVnPv8uObvfMxIpCHVJBcxafUZpW
h+JeQPlp881sv4FjfGjIPfHgWcQmx7Fvj1fShdiwmyBvcMjazFF56W+nJx1oROEu
8AtF9a5tHAPULn25umrkECVB+zPQbpqpKdtBOmRr6+9h0W/DxYqr1lTEqn84zkyI
8Xm+c+ydp+LIdfqgMeUlR5rmf1CGLiIVHNjc0qy9k4JFfiOGdmFvPfPgU2zHZ+Ae
UixwJbxRqTD+/geoeeM3tkMRFgs2WShXgPqmvRUx68H6IylYCKufutT4LSzIjEkk
lVvmKovh35h6IWVKjYv8vanrJQABwTy2VntgC0gk5QYt/79MxoEahNlqDlVici3x
DUsQKX6dCyEOgf14flgSVPE5327pgJFojn2Dm8A2SAkObv9tlPyobnzT1bqs1V60
zEaQO+Y+r3KPAxHyJe23VSMnajCJKIUbrmN+xo/86RC6n3S//ynOjq3bH4CNUnnb
zIzsyz5fylax5Ne69ry03vNOoxAoCHWgxywpBoawj6PnuAsSWYhP
=UB/1
-----END PGP SIGNATURE-----

--HlEkEKqt3nwMucQ7Jqml2fjqJ8kQKaUVO--

