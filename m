References: <20200206132103.15977-1-davids@...515...>
 <20200206132103.15977-5-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <69788449-6c1f-911e-af79-1287b450cd52@...1227...>
Date: Wed, 12 Feb 2020 13:45:11 +0100
MIME-Version: 1.0
In-Reply-To: <20200206132103.15977-5-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JqJlCDHVaLgZVaktyxZ7Kdmz4FqYPLzZC"
Subject: Re: [Openvpn-devel] [PATCH 4/4] Documented all the argv related
 code with minor refactoring
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JqJlCDHVaLgZVaktyxZ7Kdmz4FqYPLzZC
Content-Type: multipart/mixed; boundary="6QBMJiyR1ZZMULBZgHQ2pQfuffst3Fly3"

--6QBMJiyR1ZZMULBZgHQ2pQfuffst3Fly3
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 06.02.20 um 14:21 schrieb David Sommerseth:
> Added doxygen comments for all the functions in argv.c.
>=20
> There are some slight refactoring, renaming a few variables to make
> their use case more obvious and ensure lines do not break our 80-chars
> per line coding style limit.
>=20
> Signed-off-by: David Sommerseth <davids@...515...>

Acked-By: Arne Schwabe <arne@...1227...>
more doxygen is always good!


--6QBMJiyR1ZZMULBZgHQ2pQfuffst3Fly3--

--JqJlCDHVaLgZVaktyxZ7Kdmz4FqYPLzZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5D81cACgkQFRhsZwKx
RFQGEw/9EMDcRKcwNzF6iwlIUqwZX5W1WiX1ZP1Hq1KmdulWGCupwjqDWlvSNsUY
MXS18yBFPtbRrMmYBxy1MtzFO1Mna5YYQzA4q0BOE3RBW+5bpAF3TgTKFcSL7Dw3
cAzsJkAz1sRgVroUldat7+ufXDiwP0BY0Mx5pWVPxRxCZWXaDDbtgICnyNutiqaJ
E8qTeak4gRH2kowubXH1LaaDXusrkcdPZKrIz3wJZIDqXRWxoNEjmQ1gfl/j7tFq
c8wxaZRdS3wlUoFbGLBYjrVmqncc5rfgNQ0y5BIdN68sed1bySjSf3GCfK31dmnL
PrU0qS0hRyVGmP1dZ4ZK1OqqhG01XeqA6tUJB6U26sTzMcqfmq7q94+Wz4jD3BV2
LeHwBc7GXKSGeZP0AkDYXLcN1bHKi6YR+uQYbROBJzJJbJ4zsjG50ArU2M4eoNnx
9S1MMtM8xLmFXD+5+v/bqLkH2hcjuMtWCGw5jgUNt4Kiypbd3OqkprRHTxjPZ1A9
NHm+gSpvXkf1VNxospJIQkRQi4/MD8T5zM7Ks4X+53kgv0XF4fh6GIyRi/9EGyNH
TOzqErh9JLzU2yBpva0QoMQZ2ENtH8RyMy9TH82CKxw1TrW9aLevhrek4bXxkZrU
zjcVLToRXzcekWV85kaAPvwfMeVyNA8tmztZLSJvvbQeOjLa8UU=
=PxYq
-----END PGP SIGNATURE-----

--JqJlCDHVaLgZVaktyxZ7Kdmz4FqYPLzZC--

