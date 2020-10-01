References: <20200806190140.9637-1-tincanteksup@...277...>
 <CAKuzo_h_VRDBt4C76KXcrX0STyf0iP4sjq5DbZvOnXaFpkOp2A@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4a706bd4-b058-e5c2-9773-1cc563f7a188@...1227...>
Date: Thu, 1 Oct 2020 15:44:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_h_VRDBt4C76KXcrX0STyf0iP4sjq5DbZvOnXaFpkOp2A@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1Lp7MGRzIMpoMaG8tKPDxMlNmV3XCRcoF"
Subject: Re: [Openvpn-devel] [PATCH] Improve error msg when all TAP adapters
 are in use "or disabled"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Richard Bonhomme <tincanteksup@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Lp7MGRzIMpoMaG8tKPDxMlNmV3XCRcoF
Content-Type: multipart/mixed; boundary="wY4uIsWPXv1K0QrvCts1znPP2CbABlqMj"

--wY4uIsWPXv1K0QrvCts1znPP2CbABlqMj
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 06.08.20 um 21:27 schrieb Selva Nair:
> Hi,
>=20
> This looks good but can we do better? We don't check the error
> (GetLastError()) after the CreateFile() failure -- can we determine
> whether the error was due to permissions, busy file (in use) or
> disabled device and print out a more specific error message? I'm not
> sure what errors are triggered by CreateFile, so just wondering..

Since we didn't do better I would suggest we merge the original patch as
it is not adding any extra complexity and improves things.

Acked-By: Arne Schwabe <arne@...1227...>



--wY4uIsWPXv1K0QrvCts1znPP2CbABlqMj--

--1Lp7MGRzIMpoMaG8tKPDxMlNmV3XCRcoF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl913UkACgkQFRhsZwKx
RFTfIw/9FbbXK7Uva1kan+4DV6QtDc7GJLpYHlyHnojvi7XKKXewf/XmZN1S2/sQ
UBTRvz8A/C28sxEKQkT2LKdHVjqEsSw2D99WS4lsEN8C2imA31obWH4/4XjaRnq/
lVxBB59SIBZYdvkuGVGZ1UTP1osHIoT0YO4AiK3Vvd5b0Acryzfh4MNj22mYOj/a
L6spFCX4bD/HFYwtNou67G0HRNnzGpVQm7g5Q8XjIgM/PisEOIEjvePEIYXg4y3T
OZQ6wNQyxCAbZ3FC9xfX9rjPL6IxrcgfBmWF0JtKcCyDYSD2wUQm3kB/pOWx1SxC
/j41aSZt0gAvHIXEiDV1TE1Y56OB0wvXLAoQQoR08B/BrcpPQCiDRhq9U7gehLsf
HBHqi5awgrwycPZahm3J/VZ9T2cyNJyASZwusPkkeCskRZYzrh8xY4tuOt3m2GVn
VjU+qT7GI0Z4jj8kiUaTwPOeJ0J8kKoHS/+FJDZ/G+NEQcGG6sV+Yl3jmtq8+8UV
/79mT0MvdL7bFzY+wocQGVyN8cB1Uu4fngjeQHtbUheMGnIYBcC1FoE+WBwVk4Cf
wHZvQxD3Yb4SRUmoMKnhWCtyXSdrqClsnZFMMLxEPNLcku2rEw8ZED5eRBIcsv85
8nEYTqGLO176MSaqS36X5oT6geXyKveIc3j6ABwiPo57/DAWJII=
=z324
-----END PGP SIGNATURE-----

--1Lp7MGRzIMpoMaG8tKPDxMlNmV3XCRcoF--

