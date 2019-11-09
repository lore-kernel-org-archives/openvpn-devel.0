References: <20191109163714.25506-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3a8d0a60-9047-dfe2-8874-bc19a86193e2@...1227...>
Date: Sat, 9 Nov 2019 18:02:28 +0100
MIME-Version: 1.0
In-Reply-To: <20191109163714.25506-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GIZoAqMGZG9xuFmu2tWSerOjERfSSPFb8"
Subject: Re: [Openvpn-devel] [PATCH] socks: use the right function when
 printing struct openvpn_sockaddr
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
--GIZoAqMGZG9xuFmu2tWSerOjERfSSPFb8
Content-Type: multipart/mixed; boundary="Cs1cGlVjZgnJqfzg0HhWHWLgwznYk9X9S"

--Cs1cGlVjZgnJqfzg0HhWHWLgwznYk9X9S
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 09.11.19 um 17:37 schrieb Antonio Quartulli:
> 57623b4e introduced a print_sockaddr() call in socks.c to print an
> openvpn_sockaddr object.
>=20
> However, this is not correct because print_sockaddr() expects a sockaddr
> object as argument instead of openvpn_sockaddr.
>=20
> This error did not lead to any issue because the two objects are very
> similar in regards to the data accessed by print_sockaddr().
>=20
> Fix this by replacing print_sockaddr() with print_openvpn_sockaddr().
>=20

Not compile tested but looks like the right fix to me.

Acked-By: Arne Schwabe <arne@...1227...>

Arne


--Cs1cGlVjZgnJqfzg0HhWHWLgwznYk9X9S--

--GIZoAqMGZG9xuFmu2tWSerOjERfSSPFb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3G8SQACgkQFRhsZwKx
RFTyVg/3bNyaMhcDOPnI9h16N+twC9PH46EA4F7n7qBm0Nvxu1xoMGVKzHjaNNrD
+XkCdZMXvOtFoiHa980I522nRM3gU0iM/pkLieL458D6PPhO8+9a0puG0e8n4tTZ
Eb71nNH0JxfqTGwNmeTQE3P3Js1fQ7zCPAIBXeU0wE7RClVnibH2FHE0wlQDLzx4
6Lbhbg1FploaA7BnN4AUqgXbE6TErqPMhS7QmBkY1Zj4KH3FqzvAQYWv5wXgtycX
a12dhqesqrg4vGtGaP55So8TyNrzYPKqdtTycrxWOJar1/FKc8uMC6DMTi6YTGxh
cYSC08dvo0h0u6MsC4olmdOoJ2h+1yzMK6FOpAoNsTPvrEN8lhr3vT4+5d8wX91s
X4eQrUp60mawt2qSOmUn98ZoQQNjrjZuPJs77bBLSFJqm3mwvbhTYtOWYqrmzENn
ri4Yy1C/V6e5GLWtdhMMCOm0oq//Vj+MHurBMmB/cPnOVGyt+YMfB+ngIUxaE0/K
1RYOBf73OeNGChxelmTaUS4xnyXJIegbTJ0j8jqQEk2TIh2Vn4CirX4k40q6XvYR
ZtLOW2+dybPKD4mRV2oXTk12Ot0mqX5aHIAwwWns3l/CfhLdxqFYwYmGJQ5WW/cN
9+1VDxU0Q0tpTPNURfkwklrSciiw6noJjOKtnS+s845zSWzYOQ==
=MEzO
-----END PGP SIGNATURE-----

--GIZoAqMGZG9xuFmu2tWSerOjERfSSPFb8--

