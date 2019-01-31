References: <1548265738-11004-1-git-send-email-selva.nair@...277...>
 <1548863600-491-1-git-send-email-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3647fec6-72e5-a073-affa-aaff97011d5b@...1227...>
Date: Thu, 31 Jan 2019 13:06:42 +0100
MIME-Version: 1.0
In-Reply-To: <1548863600-491-1-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BL4TGqOdrvhUvjsdtFduQqK1kYelLbip2"
Subject: Re: [Openvpn-devel] [PATCH 2/2 v3] Handle PSS padding in
 cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BL4TGqOdrvhUvjsdtFduQqK1kYelLbip2
Content-Type: multipart/mixed; boundary="AgFoYuV5ZXzECSh05NYYoTWJELm0Ngs1o";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <3647fec6-72e5-a073-affa-aaff97011d5b@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/2 v3] Handle PSS padding in
 cryptoapicert
References: <1548265738-11004-1-git-send-email-selva.nair@...277...>
 <1548863600-491-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1548863600-491-1-git-send-email-selva.nair@...277...>

--AgFoYuV5ZXzECSh05NYYoTWJELm0Ngs1o
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 30.01.19 um 16:53 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
>=20
> For PSS padding, CNG requires the digest to be signed
> and the digest algorithm in use, which are not accessible
> via the rsa_sign and rsa_priv_enc callbacks of OpenSSL.
> This patch uses the EVP_KEY interface to hook to
> evp_pkey_sign callback if OpenSSL version is > 1.1.0.
>=20
> To test this code path, both the server and client should
> be built with OpenSSL 1.1.1 and use TLS version >=3D 1.2
>=20
> Tested on Windows 7 client against a Linux server.
>=20
>
ACK. I verified that the changes are almost exclusively white spaces
changes and apart from the MD_size change and therefore did not retest it.

So my ACK still stands:

Acked-By: Arne Schwabe <arne@...1227...>


--AgFoYuV5ZXzECSh05NYYoTWJELm0Ngs1o--

--BL4TGqOdrvhUvjsdtFduQqK1kYelLbip2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxS5NIACgkQFRhsZwKx
RFQYGQ//T6ox9P0QqHlIshrzrBLccXO6oHDrPAkBH2Y+IWKjLte87Xq1YX6dTZn6
qpYgVG3EBQcjYLzq639wJfEahvFscXGtyZ4uNGEJYLyDw8DaP1jr/AJ8CyctxENX
vj96QA8CBUFC7IJEmv0zKrfBqJD8nDUFQe1ks4+9zeACCmXJX45t11Xn7RA3/taN
t7x3qL/ZdIrYmNzAiRPkITG2F6eKc7uvlTg4bi5mbVEBKY+WeAlBw1npmZjHRVDm
X2vjyZE6Bz6q8WsLapx5S/ixva6sfm1bkIKbjM5Gk65nLzYBz0TEYJQfY4DI/En4
mLxjlXYIvdq2bN9jOcCVNzEP6Zqy0ISuUGM2mPo0dRgO3b55KA9wRkle+SAbpUb8
5KGHBbMgqDRj0F89Ug1cIWRdOn8O+YJxNp++K4DSR1qigt32gUfNRto26qR4Kkmv
MvXo8RPywNw2Dii8Zg3BlqPW9zcJ1RyPcqSXuHaf8g81f5J6MIKLD7hfQXg8L8JY
IEZFq1SZvpdVd7YKZzqMwIGmrhqKOvZIwFKGSqJ8EpoSjRR2lODWNn6qTnuiIidH
+qnAGKUWRSZRFpHq18Y9ayEt8agqBYH7GiXK2UhJ7GWpHmsrAlfGfL2LdXRokO8G
HY2RYwsJpeTHsu4KUv9l9KwwoncQxDtkyRriY3w5dV1/VY4hKAA=
=kOPd
-----END PGP SIGNATURE-----

--BL4TGqOdrvhUvjsdtFduQqK1kYelLbip2--

