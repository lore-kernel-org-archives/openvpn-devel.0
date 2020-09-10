References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
Date: Thu, 10 Sep 2020 12:18:55 +0200
MIME-Version: 1.0
In-Reply-To: <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mrc5Pgdall0srWqjQNlobSAf4n4BSGx0y"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mrc5Pgdall0srWqjQNlobSAf4n4BSGx0y
Content-Type: multipart/mixed; boundary="XR2VBE9ePAxOxOcIfJatoXBtL8n7aWKdB"

--XR2VBE9ePAxOxOcIfJatoXBtL8n7aWKdB
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.07.20 um 16:02 schrieb Juliusz Sosinowicz:
> Hi Arne,
>=20
> thank you for your feedback. I tested the patch on the latest master
> version at the time of writing and it looks like these requirements were
> added in the last week which is why I wasn't able to address them
> before.I will look into the new issues and get back to you when they are
> fixed.
>=20
> I agree that most of these functions only require exposing existing
> functionality on our side.

We already progressed to OpenVPN 2.5-beta4 now. I think it is fair to
say that WolfSSL missed the window to be included in 2.5.0. And seeing
that these rather simple fixes take now over 1,5months does not exactly
inspire confidence that WolfSSL is committed to maintaining OpenVPN support.

Arne



--XR2VBE9ePAxOxOcIfJatoXBtL8n7aWKdB--

--mrc5Pgdall0srWqjQNlobSAf4n4BSGx0y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9Z/Y8ACgkQFRhsZwKx
RFS6RQ//WEb0oL2Xkb6bMRP5O44D1W0rozt8yuUkbZuIqY7pmhwBgaQERgIejHqx
Aq/cInUYL/wcOweORl5ALdt98keI+V3NiJrNhjuhcpacLL3kkxzlTxIIvpMFg/0T
L4EZgztnbkJpBCJ/KI4n8l32431SU9f9P0C4YaxOVqYyuiYay8AvoBCQQLAYzuTa
ck4qbgtZ1CsLkrSI5PK/mjDzc9h6gNbNHckBBqjCIQ2CSfdNbiggsYSjlTY7gXjv
rqJXlbiIhWw2XpRBFbeTCUj485Pnp6PmEb8FX/R9H2I0Nmsb/qroAf1l/RD8bfjL
oAoZdnuJ+j35B2fSDc+VsY0mFtBej9fm0l5fvGOSI98hQUuOpY2FSkhVUlWUNoif
nSOq+zK23DmRm9OWvSy42Iucy76DjPIX6LvlmFYzPttE4EKcGwThrEenQ+UfZsaE
g9gBv/F5nzlok8wbKOYATZJ2OVY11s3WSZJpDnBiqNtmrOuz0SQjBoRFG7OoEYsW
H1aiC+x/zrGckpKIg+6uiLN/JcHY+uiTGySons6w05bw0DRtz3umbnyOJ5BBYH6P
N3u9NuTUmMFrEdYf2I/x2AHaqGm3cABifZEyYeEQ7jNuaN+LDDO5wYAyjbpg8+no
HbG04KtLFOZo3myMC+P4QHj4pXTqx3jT374+3oYjmzXJVtL0UXk=
=Eq2S
-----END PGP SIGNATURE-----

--mrc5Pgdall0srWqjQNlobSAf4n4BSGx0y--

