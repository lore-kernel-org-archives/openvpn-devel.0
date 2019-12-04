References: <20191122143315.8564-1-arne@...1227...>
 <20191122143315.8564-2-arne@...1227...>
 <CAKuzo_iqvxpOQ4Gdo6WpLxoXUTzR6tC3kW-2y0AP1hr35jo5tA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <68a07c90-4506-2472-09ae-89d5f2c4aca5@...1227...>
Date: Wed, 4 Dec 2019 12:08:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iqvxpOQ4Gdo6WpLxoXUTzR6tC3kW-2y0AP1hr35jo5tA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HGbI0FI4DaC9ukNQzO6JyD41EWm0gWR6j"
Subject: Re: [Openvpn-devel] [PATCH v7 2/2] Add support for OpenSSL TLS 1.3
 when using management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HGbI0FI4DaC9ukNQzO6JyD41EWm0gWR6j
Content-Type: multipart/mixed; boundary="TWPQ6dJ4L6fX6FNvIOuDZzW5qRHp5LgID"

--TWPQ6dJ4L6fX6FNvIOuDZzW5qRHp5LgID
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 23.11.19 um 03:07 schrieb Selva Nair:
> Hi,
>=20
> Thanks for the updates.
>=20
> In spite of several nits below, I'm ACKing this.
>=20
> All remarks are typos or grammar, important only for docs
> and some comments. I suggest to handle these as a minor follow
> up patch.=C2=A0
>=20
> I'm also ignoring most typos in commit message except a few that
> could be corrected during merge to add clarity.
>

Thanks again for all the patience with me. I added those corrections
to a v8 to make Gert's/David's job easier.

Arne


--TWPQ6dJ4L6fX6FNvIOuDZzW5qRHp5LgID--

--HGbI0FI4DaC9ukNQzO6JyD41EWm0gWR6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3nk5kACgkQFRhsZwKx
RFRKBw/7BOdCLVr0LiMYx09k6/IELApUI9LVkJ8vVm3vlgapdStlmB06CRdlK/5K
kV/GTbZ0M7sgbdTjJcMfUhKkjPhQii41OoJRXYUlQTkckTAK3i5W1v/ISteDVPNc
WkDrXgcaCdDXcfPz9pChWnE9yu0IG33EetqnXYruMmwziHiN6GbfBjIRRwsq/VpH
87BEWc19+WgZBJuuX2qAwoy0XczP0f78nugxbjcvj6elnZ00Ufc7NkLsqKQDeH4m
x1qyQtnp2/QCzcFHJ8Bwndv9dgYmmaykOaFKIfF77Mz420I8PKBr7x11UCw67njn
gFXPfX/SqTGR4sMhLk09lDl/eIdq2jsgxOHOC2wylxkYJ4WAllfn+S5s0xB7rkP2
Yql2UBTOuUSqcgRA7W+mm7Vfe4RWEBtT3wzaeQ+3onUhs4Yt0Ze2yRbbdVafNzs1
iF37/U2UZrIhIgLfjKBu2UlaQv2c3T7Nur+xMkSWHgw0bN8X28yDkGxNN84A34k6
XyF8KuFmFXeu7YTYjrrCpyaRXIbY8FwF0dvR+FtSaWDoZra8Pp90Lu37tnmV9tPn
2KL82DhsPtGqodxxuMECaa7qRXW/ZdKvussAY0xborGsNqi38WO7KukD8DSq7ODM
pHw928S0dseOtlKIBtIGIn8l8LMuxQz/A3jyr56ZdHDNjH2GMwk=
=PS7r
-----END PGP SIGNATURE-----

--HGbI0FI4DaC9ukNQzO6JyD41EWm0gWR6j--

