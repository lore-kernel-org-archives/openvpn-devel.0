References: <20180401131615.12567-1-a@...2181...>
 <e3d48a12-7f25-1ec0-ad7a-52c1330f43c0@...2181...>
 <20180411091542.39c8c01d@...1799...>
 <5299586c-24cb-d2ff-c12d-404b4a139377@...2181...>
 <e3d20075-a97e-d968-ab1b-5915e8e85e53@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a1346928-bbd6-1019-a48d-2c91ed41766c@...2181...>
Date: Wed, 11 Apr 2018 20:06:50 +0800
MIME-Version: 1.0
In-Reply-To: <e3d20075-a97e-d968-ab1b-5915e8e85e53@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TAV4kYQBu4sfgwtoOlVcy0iNIfuyxEyiE"
Subject: Re: [Openvpn-devel] [RFC 0/4] add netlink support for Linux: update
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Christian Hesse <list@...1798...>
Cc: David Sommerseth <davids@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TAV4kYQBu4sfgwtoOlVcy0iNIfuyxEyiE
Content-Type: multipart/mixed; boundary="jtVwUaOLRS3eW4GhKvOeIORPM61oQxBpg";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net, Christian Hesse <list@...1798...>
Cc: David Sommerseth <davids@...515...>
Message-ID: <a1346928-bbd6-1019-a48d-2c91ed41766c@...2181...>
Subject: Re: [Openvpn-devel] [RFC 0/4] add netlink support for Linux: update
References: <20180401131615.12567-1-a@...2181...>
 <e3d48a12-7f25-1ec0-ad7a-52c1330f43c0@...2181...>
 <20180411091542.39c8c01d@...1799...>
 <5299586c-24cb-d2ff-c12d-404b4a139377@...2181...>
 <e3d20075-a97e-d968-ab1b-5915e8e85e53@...2080...>
In-Reply-To: <e3d20075-a97e-d968-ab1b-5915e8e85e53@...2080...>

--jtVwUaOLRS3eW4GhKvOeIORPM61oQxBpg
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 11/04/18 19:50, David Sommerseth wrote:
> But in the end, I believe that currently it is probably better to have a
> simple shell script doing the generation.
>=20

+1

Unless we have to create something quite complex (not the case here)
that needs further extensions in the future (probably not the case too)
we should keep this simple and use a plain bash script.

my 2 cents.

Cheers,


--=20
Antonio Quartulli


--jtVwUaOLRS3eW4GhKvOeIORPM61oQxBpg--

--TAV4kYQBu4sfgwtoOlVcy0iNIfuyxEyiE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlrN+loACgkQB6U8WA7y
zXTURQ//Qdx5HD10Tor5lTzngbC5A5q03nicHB5a1vGD6YuZUw+XOEHfdQjX6nm5
T7rh02Ban9t13vRS7XKcpc/8ExcL/owT9+a0YuqyBl1zs6HA0yLU47XoiTdfIFNc
7WMXM+tjOxdKRck3orFQ8PevqS7Fw/++ntn/uABLAuaqXcqKLoZWYzNue1HsrHUX
HH6hD5hIs2xpeMUQKzIu1eEuFmsnf66na0w65dZ1OynG4BtRaVigqKUXLi2sbywD
sakUmxpw+qDZ/is7UqlYZNY1l4tFBEkG9U2FULw+eKGdr+wSxKCze7mK60/w9+eA
aordQUg1Jb4149WJwtB4aPxWPLTAQskfGv0ewVLeScq6GMnaCtg/6iX57+AdUzsh
z4lwdbF3R64wiIMSsbBv3mGc5Dr7bWyew8yMBkEcAgDxiMXdfTZ345ZTOZBktLfe
srD2zdeIkoHsvH7jy/YxMXIiEiRILVV2WuFTWaxr9jlI7iqtFjGS7Wd9JRcG7QBF
Su9XhVOGS3jutx4O2+0YsPOLElpRwfQPms1HLUwA3mPWsvMfEO2duMw4x9Oh+Jh3
xwLImikbE6GuQIt12o2fi2OVlklDyHYsnMnDK3m6hwcHTigwHJMQjDUrjuDA30U/
Y9oqzvGIlqHsmbc5eDDo70dLb2DGab/HRiJOdGW96sQCb9zy70c=
=gfvd
-----END PGP SIGNATURE-----

--TAV4kYQBu4sfgwtoOlVcy0iNIfuyxEyiE--

