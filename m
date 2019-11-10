References: <20191110133525.6069-1-a@...2181...>
 <20191110133525.6069-2-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <46a03430-b6ea-b39e-3824-fbd5a9e4b475@...1227...>
Date: Sun, 10 Nov 2019 15:39:44 +0100
MIME-Version: 1.0
In-Reply-To: <20191110133525.6069-2-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AMQ6sKpLQWyHBIkjic64si02e2vZoavou"
Subject: Re: [Openvpn-devel] [PATCH 2/3] auth.c: make cast explicit in the
 crypto API
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
--AMQ6sKpLQWyHBIkjic64si02e2vZoavou
Content-Type: multipart/mixed; boundary="mgPnv6NCk8FLKL9yNKkssP6kSVT9pAbax"

--mgPnv6NCk8FLKL9yNKkssP6kSVT9pAbax
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 10.11.19 um 14:35 schrieb Antonio Quartulli:
> mbedtls_md_get_size() returns unsigned char, while EVP_MD_size() returns
> int. Results coming from both functions are normally in a uint8_t member
> of the key_type struct, because it is known that 8bits are enough (also
> for EVP_MD_size()).
>=20
> This unexpected cast can, however, trigger unsolicited warnings.
> Make the cast explicit by changing the return value of our crypto API.
>=20

Not sure that this really needed but it also does not hurt, so

Acked-By: Arne Schwabe <arne@...1227...>

Arne


--mgPnv6NCk8FLKL9yNKkssP6kSVT9pAbax--

--AMQ6sKpLQWyHBIkjic64si02e2vZoavou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3IITAACgkQFRhsZwKx
RFSqBw//RQO96MzejoBqHF2Bm/2FnDgoxptoYKVCZ6jQt20uM6wxU9u0hhuh3sqA
yyp57V8HB9q3NAOV2y3GEmWsrRvbPyc/YNyTCCgSFi50tiF0ZIynrLLBbgS8WAhK
c4fMKYfte0RxT3ZjzBvC7uBHQyGte1U3ga2eN0kmba2za0BfAkjeI5mUb4p5I1bI
ZRcHgTQWgSIOyx5+NjYEclHaKZIQSKuVhqkm+8+DYBXntkcI0RUT185Q3b8m60hd
md4hidIN87GLQUff9zHN3kW2Ni44QXi3DbTDOynGPwQxeb7DoZ8Tgwo2tAvZ1sdN
UKAKcpLZdsaW0uxSGADimllkIcjNVFg2xU61nRDzqgLrdnxtQBJyOdIredgYDXqT
E82W7VQ9QVoVk9xp5qgrTSmGKlRzK4+CWfch5IfnDxImCkc5reNP+sYcuBHGDBmp
xmDgbpa53VasPj36jNdRxTJEq7jVNpU+qQSd/7mz/SCi5pImg9WLO5g2wKhWb56Y
DhvpNHpL5w+N5lNyw42a4GsikkNF+RvXQu+Eukp7jZUVFZgHarIqYDnELy0jz/+p
Fsr7REYSoos4vZvm5QSwwUzoOT1HPAPJ/mYSLEMqGprKH1v+MpoX8fgHyeYKU82v
XVv2JVntEkS91v6ccky9erQHVXsNlzb7mYf8Xxt/PcuGBQKhvCQ=
=B5SR
-----END PGP SIGNATURE-----

--AMQ6sKpLQWyHBIkjic64si02e2vZoavou--

