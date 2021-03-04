References: <20210125125628.30364-12-arne@...1227...>
 <20210304114018.8442-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6ed4f42f-957e-c8e4-e9b2-e877c6a2d758@...2080...>
Date: Thu, 4 Mar 2021 16:03:13 +0100
MIME-Version: 1.0
In-Reply-To: <20210304114018.8442-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1MMSxYy2PF1a53irXLeYoWFaUvgGKOBN7"
Subject: Re: [Openvpn-devel] [PATCH v3] Add example script demonstrating
 TOTP via auth-pending
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1MMSxYy2PF1a53irXLeYoWFaUvgGKOBN7
Content-Type: multipart/mixed; boundary="vnx5dLCQVGkH1LzOVn2XsZWsVoSGLPmuu";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <6ed4f42f-957e-c8e4-e9b2-e877c6a2d758@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3] Add example script demonstrating TOTP
 via auth-pending
References: <20210125125628.30364-12-arne@...1227...>
 <20210304114018.8442-1-arne@...1227...>
In-Reply-To: <20210304114018.8442-1-arne@...1227...>

--vnx5dLCQVGkH1LzOVn2XsZWsVoSGLPmuu
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 04/03/2021 12:40, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
>=20
> Patch v3: Some minor cleanups in the script (rename CNs, add more comment=
s)
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   doc/man-sections/script-options.rst |   3 +
>   sample/sample-scripts/totpauth.py   | 111 ++++++++++++++++++++++++++++
>   2 files changed, 114 insertions(+)
>   create mode 100755 sample/sample-scripts/totpauth.py
>=20
> diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/scrip=
t-options.rst
> index f48e5818..6517f847 100644

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--vnx5dLCQVGkH1LzOVn2XsZWsVoSGLPmuu--

--1MMSxYy2PF1a53irXLeYoWFaUvgGKOBN7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBA9rEACgkQhs+UTJZx
/fIWWw/9EKN/MNQeKkkuGOezs8d1S+K5DWc4VjIauQhEhllMPvlBkuf2WYB4WmYi
z046lkeDv0MYFrjcI0XDQhDLuNRH56SlkHkDo9fKEdwF/F85mr8ROiLdBJ6KYkd1
VNuhq2kQzsuq3/ZxeOqwnZn97ZTgPHagtVhu5zMNo0RcippyQ2SSxgmh5ed1yCMK
4pZN7MbKjuU54blQfzbX5c4/8OWKlv/cQLFSbCH+oW48WuioLEYP+ADjZ+sO6Yzj
fBmvzfxkGsB9LIu/RHjuH5i0tDs3Kzeo+q951bUgmPNDbVcDgOt2+TDrBoDsdXx2
a9Mn5Lj6hMD5VJLz2NngzM9X0oMWOXfkc5HiYmZGwrq+HhhaMiugaE77WzXlLwfX
2Dr07YYNxO4Sz8CzyN1FVkFLZ4Dsl4Bix/NVfOiTB4aazYzuo+X1Qpm5LJhYVJ8y
ElhEAiFc147kZzBUE2j+5vup0gwcQ0JrcTxM92ZSqQk5gCZtR59N1LMIudzmqQlI
9OGvKDp1+dXwOeK7vl+d7Y/TbFvPhdOwwua/Le7+0HbgoZRVc0OQym70+ZHVXt3G
/vkXNme6eYSDVJJX2e4LDvQt305xG7RFX2D54ygHgvJzA4blpEHm3O/asUbSutz+
vSWIW4TpVYa0Pal4A0DgdHjqvmiPa9WjyhCuhc5NN8LBFijEA1Y=
=+y9b
-----END PGP SIGNATURE-----

--1MMSxYy2PF1a53irXLeYoWFaUvgGKOBN7--

