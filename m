References: <20191110195622.28177-1-a@...2181...>
 <20191110201718.31032-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <875f1a04-1456-ef9f-9261-00aebcf80d7e@...1227...>
Date: Sun, 17 Nov 2019 20:04:00 +0100
MIME-Version: 1.0
In-Reply-To: <20191110201718.31032-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="te1hMLSCXs7RpsPYEtK4kO0tYu1oNslHQ"
Subject: Re: [Openvpn-devel] [PATCH v2] travis: fix CFLAGS assignment error
 and add -Werror only when compiling on Linux for Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--te1hMLSCXs7RpsPYEtK4kO0tYu1oNslHQ
Content-Type: multipart/mixed; boundary="W1Ve18MWu4ksvwuPg1ozFDSrL8837xDMN"

--W1Ve18MWu4ksvwuPg1ozFDSrL8837xDMN
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 10.11.19 um 21:17 schrieb Antonio Quartulli:
> CFLAGS may not resolve to anything and the build-check.sh script would
> just fail.
>=20
> Switch to EXTRA_FLAGS and use proper substitution so that the script won't
> error out when EXTRA_FLAGS is uninitialized.
>=20
> At the same time ensure that such flag is set only when compiling *for*
> linux (we use linux to also compile *for* windows)
>=20

Tested it and verified that --enable-werror is used.

Acked-By: Arne Schwabe <arne@...1227...>

Arne


--W1Ve18MWu4ksvwuPg1ozFDSrL8837xDMN--

--te1hMLSCXs7RpsPYEtK4kO0tYu1oNslHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3RmaEACgkQFRhsZwKx
RFQdGg/+MhEkCGKv+xwcRdGbTgMeI3DVwv0Zwe/44qGHSYkiCHuIWpYKaOIorcyo
kD3hbXk6YwS/aRZ82Zv4M5ZcrDo7X8yMzimghwLHgIzlGxHi2Z8Kg6lfWJSFyqpp
BPNjv++WfIU0u0PKjkGvSUplxTrusuWmzU0kTLS3fchC8zMNkPd22T4mTkvCJcU8
zYD4moQECVZ7bAk/Gsk57lSqJSCxnW1IwOCqAWHJCEuCH2Bc7siuje5tM14gChRv
OB6AALzVvHfVjCTAMh0s5AqrLYzIfl8KcMzZ/FFi2+T/S32cqOv+0vjAxvFg9G4P
ic6MjJLjm12ilf/fjC7RCS9meWzV8X/r9ja6qfx+ognUpwhyjVRmrUXsBPX5pEGd
nl3juLW2M2jQi4smE8GOK8PjS1obh+76FpyUvY4LFxdQKYJ4qEZS+YmLU8G/BEZ9
HBLsBS3Qy9TnXBt3IzD/krSN3/ErsQTiAIxyARLCkIBgoyyo0sPpepkA58yJXq8h
JjFFDYderuU2oBerMKNwaNBjeb2dm8q1QqrOLbi52YDLCGbXF+Cj+LSfRYm1W2EI
6oUkqt5ZvZ5pCOSyfH1T7jkpNaPe+B+W4Hb1d3IYG041fl2Q8ugbnRbPlGObniW2
9t+5W3T3fgZ+mwrUGhd1+j/8q27FcRqJb6mY1urrf/y2l3AA/9Q=
=jDRh
-----END PGP SIGNATURE-----

--te1hMLSCXs7RpsPYEtK4kO0tYu1oNslHQ--

