References: <CACqfLrwUzFhaP9F-j3s=-5iKtUpz4y3_o+8jOmT5v2+70sP4Rg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ca556891-b8a0-0150-c086-36c376b591d3@...1227...>
Date: Thu, 8 Nov 2018 13:42:20 +0100
MIME-Version: 1.0
In-Reply-To: <CACqfLrwUzFhaP9F-j3s=-5iKtUpz4y3_o+8jOmT5v2+70sP4Rg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I4FqFrcuzO3J5ngKDKLOLoCW7xxr9fUjJ"
Subject: Re: [Openvpn-devel] developers documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: milovan bjelogrlic <mbjelo@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I4FqFrcuzO3J5ngKDKLOLoCW7xxr9fUjJ
Content-Type: multipart/mixed; boundary="cDSz85ZCvVzrYdOY44IuDFm7OFRqpNWzi";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: milovan bjelogrlic <mbjelo@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <ca556891-b8a0-0150-c086-36c376b591d3@...1227...>
Subject: Re: [Openvpn-devel] developers documentation
References: <CACqfLrwUzFhaP9F-j3s=-5iKtUpz4y3_o+8jOmT5v2+70sP4Rg@...278...>
In-Reply-To: <CACqfLrwUzFhaP9F-j3s=-5iKtUpz4y3_o+8jOmT5v2+70sP4Rg@...278...>

--cDSz85ZCvVzrYdOY44IuDFm7OFRqpNWzi
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 08.11.18 um 13:31 schrieb milovan bjelogrlic:
> hi OpenVPN developers,
>=20
> Could you please provide me with information if there is place with
> documentation which contains API reference, code implementation
> documentation and any othed kinf of(good :)) documentation. I am
> interested in openvpn3 library development. As I could see there is no
> such detailed documentation for developers in openvpn project.

First, it is nice to see that you are intersted in developing in
OpenVPN3 development. Yes, there are many places where to the
documentation can be improved. Almost all the existing documentation is
inside the code. But if you tell us what your focus is in OpenVPN3 so we
can give you some pointers.

If you "just" want to write a client, the ClientAPI should be very good
documented. Also the test/cli.ccpp, openvpn3-linux, and ics-openvpn
projects can be a used as examples how to implment this API.

Arne


--cDSz85ZCvVzrYdOY44IuDFm7OFRqpNWzi--

--I4FqFrcuzO3J5ngKDKLOLoCW7xxr9fUjJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlvkL0cACgkQFRhsZwKx
RFRXBw/+Or1Vz4iOI5Sin7uRPn2r9PPnObJjulvdcXqzLqmetOkyXV9yA6venHD6
6dhIeeXXTuKediF5RXBecsa2tutzbDaGXkL/7N5KOCNIaoe/R3DPKPBlNmnrKN4v
76lcMWjfV4MvOWlwBKnCsNnTpP7e8ZvDuXvtypKUxFNFjF+PuKG6CZk3XGjD01W0
o/Nxo1MWLNkzrfVTsbO36zKtKA7+nexx/SH1YOv4RKjYhwNmM784hwZ/i/TNCLtP
a4ydaFdFyaA4WctWQx/lPH2jAJEDktMh+7YS767W9XnzsqG3woZAjeE4wEN2vL9D
YF7t1Uk16JPdRD6I02ApuwGUSHHSXUD0AueN/jOX7XOA7IcKkfDG0BUkEXezd7GO
vz5iA/lwv1rF5AlfrBjP3/g0ckDojK50cBFlMFPyyKlxexqC35zzn0pfty922S+e
Vs4yD7YhG1J04BAYXjw9aIEI1rN/6L6mN/51z1+M/xNhB5/OEH4AikmARKiT40KJ
paN2RZk3SjvYsB43QtrEiQTGRVyJiZQC5sENcfbh0f3SiL16G9c8joDOrx4hBTq3
XqoaybL+XshWUR1Ec+c4ifqasISVRCY6tUeqIf2TqVFCTYdVZk96M1+BJ+Vkcy7t
Cqp6NE1GuVsrsWO7+SxClIazf2+6VcNtmGMY4k9gYxvUBPuypfg=
=MucC
-----END PGP SIGNATURE-----

--I4FqFrcuzO3J5ngKDKLOLoCW7xxr9fUjJ--

