References: <20200620180532.15738-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f229351a-bcfa-2eba-22db-2d5921ef72b7@...1227...>
Date: Sat, 20 Jun 2020 20:36:06 +0200
MIME-Version: 1.0
In-Reply-To: <20200620180532.15738-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AjUm2CJ2rI5jSh8g7Ich4c69UkhyShFLj"
Subject: Re: [Openvpn-devel] [PATCH] Depreciation warning for --topology
 net30 on servers with IPv4 pools.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AjUm2CJ2rI5jSh8g7Ich4c69UkhyShFLj
Content-Type: multipart/mixed; boundary="uf1e1ceaLN2ilsprOERWxnIeGpr3eTBsA"

--uf1e1ceaLN2ilsprOERWxnIeGpr3eTBsA
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 20.06.20 um 20:05 schrieb Gert Doering:
> IPv4 pool handling needs lots of extra code to deal with "topology net30",
> so we want to remove that combination in a future release.
>=20
> Warn people about this in 2.5 so nobody is hit by this as a surprise.
>=20
> Client- and ifconfig-support for net30 will stay, as "just net30" is not
> what brings maintenance effort here (totally removing all options except
> "topology subnet" would be beneficial but is a bit too radical today)

Acked-By: Arne Schwabe <arne@...1227...>


--uf1e1ceaLN2ilsprOERWxnIeGpr3eTBsA--

--AjUm2CJ2rI5jSh8g7Ich4c69UkhyShFLj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7uVxYACgkQFRhsZwKx
RFRIlRAAskyivHTnYR9/hFMmEsGmZF+EUi8BCQitDPgNwge5kdIiy5anki2XT0h+
aFWBMg2wpyMD0fgb5xfSyYJrQRPe/hQHaZuy7IhkhbHlsJznweSyeUUvTr//fwx/
pGqvzsK0eOGYP7Mzv/lYEo6f1qy5zH8BI6cdyWygVbww0DhbQD3cMIjMy/+gUD+z
LeC5jMfpYW4mxVq8Y64tpqFA/N2yUeLDCTUogR/NXL7w29nyzpkBUcYwITDsBF6N
Yc5tr2/dsO09uFxfQViWcUgaa8C7IlCmoD9irk2oyKmz9wsgVN/Ui7eBULh06jW9
fkSO91Tjq4Fw2jPpTd3W1MAxOCBBjxz/dFKrV22vJ3+2pVBnNRSr68A4M2ZvIIaS
WnRIytIbZwmfeLYlcDCBpwYNYIOU9Q+KeooyVtgugb9IHqHXxcHOl2efLrvv3WBl
krZVZ/+aZ5rxuyhBlkxEnkuPOnq1FqnT2pxXhXxIVpU/k8gRTV3JyHk7iRHFCwsb
ZtB/6j6M0taJbpn4PuX4OYQqjlbY20MpgaRSR87yO2GCYR+D8R6AtowY4vPq2MQh
Joujk0k13L/RhhJiQlGUfyBBfoYPH872lm+vhZqZEu+rOHnknazqUWz5bhThVMpy
bqyQ135urHKQ6wWk1SYPOatXC4IMfpFE8ysmW7FohBZrWYccLvw=
=pfRu
-----END PGP SIGNATURE-----

--AjUm2CJ2rI5jSh8g7Ich4c69UkhyShFLj--

