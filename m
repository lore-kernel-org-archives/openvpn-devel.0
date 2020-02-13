References: <20200121080828.1310-1-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fc9ba1ee-19c8-e5ab-c903-37d8debcc8b5@...1227...>
Date: Thu, 13 Feb 2020 10:36:34 +0100
MIME-Version: 1.0
In-Reply-To: <20200121080828.1310-1-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TypkpSLA7iFnQUxvMrToHmotsL116Y3LR"
Subject: Re: [Openvpn-devel] [PATCH] configure.ac: simplify AC_CHECK_FUNCS
 statements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TypkpSLA7iFnQUxvMrToHmotsL116Y3LR
Content-Type: multipart/mixed; boundary="HflO9BVqhfjnR0cu9EjoOmwAPkKNEr4CW"

--HflO9BVqhfjnR0cu9EjoOmwAPkKNEr4CW
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 21.01.20 um 09:08 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
>=20
> AC_CHECK_FUNCS checks availability of each function
> in argument list and defines HAVE_function macro.
> AC_CHECK_FUNC takes single function as an argument and
> doesn't automatically define any macros.
>=20
> When we check for availability of a single function and
> define own macro, it is enough to use AC_CHECK_FUNC.

Looks good to me

Acked-by: Arne Schwabe <arne@...1227...>



--HflO9BVqhfjnR0cu9EjoOmwAPkKNEr4CW--

--TypkpSLA7iFnQUxvMrToHmotsL116Y3LR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5FGKIACgkQFRhsZwKx
RFQI3Q//QmIUsmBw4gPX+VjEjAV0gTELbcnJbCgdUnloI975TvCAjSq6xVmGbw/W
rXGynSiuLi8HTWxcALnv7vNxWMckxw28XPHIE8YjtiJ6QDLWS5ZrJNSYd3mJY6TT
iVbvjTu/Dzy5KOTVXaXdXWf1CN1S30d3GrxGROHDORi5uXz03MezxxG4wIcjgcgK
TyPEzkfSuBkWvphrS7ZUu2pHbeK7oNnqLFPbO3XHXnJfbzfmPsYTQFbh8SR/mVYT
bbHUSYpZDWKmQFgw97Y5w9nj9FsPMUcqK19exjWya1PXR3HPYr/nuJzi5BnWF5LQ
IKg/UbOibYgAhAX6i1DVuyt79ih52zKj/0b1UEvkfzE4H2rszXpaf4brzd3BL/BC
ZrFRwyp+gUo5eT/MmzZg7owK8hiAQtRARoIQ2IFv9xCowK6BXpf52O8kRfgIj/et
YG7PlngxtodxsRAACc+fm/8HwaON/F08DzhrMFSWdr6KR2XsOVz50DOvnV72/LwR
6Fsk8JOxlmjg8+bYQVzdSFQv+a4HnZH6aZ1WAe/gnRe03iYM69DkQZP7lAcO1d/k
uDU0zkdb1HBlqzo9f6EDkPiR8sWrQbuWdVwFUhhKlI4LqE9R9YpApjuCcznlyw6Q
z5D6KemBlGdWQA+M8vRUZjoFXPzDdkC/TrSKsQ/hZt4ruJ5lfv4=
=ldxS
-----END PGP SIGNATURE-----

--TypkpSLA7iFnQUxvMrToHmotsL116Y3LR--

