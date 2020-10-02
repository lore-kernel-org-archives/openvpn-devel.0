References: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b4686963-bb89-8777-94f2-caf3ceca8328@...1227...>
Date: Fri, 2 Oct 2020 17:12:07 +0200
MIME-Version: 1.0
In-Reply-To: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YFpmSusxkFTEQCxcL4WlnddxLtOBQOPC7"
Subject: Re: [Openvpn-devel] with IPv6 VPN connection,
 IPv4 traffic does not get router over VPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YFpmSusxkFTEQCxcL4WlnddxLtOBQOPC7
Content-Type: multipart/mixed; boundary="wYD9z9E4cSY5ZevbRBNiqUr6KlHEsRy7c"

--wYD9z9E4cSY5ZevbRBNiqUr6KlHEsRy7c
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 02.10.20 um 15:26 schrieb Fran=C3=A7ois Kooman:
> Hi all,
>=20
> After testing connecting over native IPv6 to the VPN server, it turns
> out the IPv4 traffic is not routed over the VPN. This worked in older
> versions of OpenVPN (2.4.x) but no longer in OpenVPN 2.5rc2. I am
> testing with Windows 8.1, but the same was reported on Windows 10.
>=20
> This is pushed to the client regarding default gateway: redirect-gateway
> def1 ipv6
>=20
> The log shows this "NOTE": 2020-10-02 06:20:07 NOTE: unable to redirect
> IPv4 default gateway -- Cannot obtain current remote host address

Is that a host that does not have a ipv4 default gw at all? Like IPv6
only connectivity?

Arne


--wYD9z9E4cSY5ZevbRBNiqUr6KlHEsRy7c--

--YFpmSusxkFTEQCxcL4WlnddxLtOBQOPC7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl93Q0cACgkQFRhsZwKx
RFRMCw//QvPiBCCki+MpZ2e7CGZaX50FbIKzFVVVw5nHElTVeHH/VCnuDjA64HqI
hV8u5D+aMu8TkPyPaMjLQL05pczJGME0DuuXubCjy1+r8RSmZoF0yFhKdvpV9Vbk
sTzI/rzSdaHDAw/x9zj/ifdcIeO3QJNYBKObYMdy7Q+4UKsFq6srXzZ2k1K4Ddp0
DZiBBsHfFEzVY4l4/hFtQO8i9Rvr0JBuyxLldKDdxtPqTaKmcdBQSe0scCprZ+xb
jv0yK+apAqVk52IQvQVCHj3gOS+PnSnYVuJX8WVBsCodvAJ/3tgYy/DkIMKmqNf2
zKDvHfi1x/IU/o1CzFnmuC4DIFEryeOq9kjTYTe+q6VjSnKPZYAvJVJTLsxQpn+l
z8+llaEW+8I2lRIjtRNzPGuzXEsQJWbrS83RVOWNsrqREAsiPH9K5DrlZTIxk8fR
F2k0Um4MkQP28iS3moSCWUg5C475RizH4niIb8tcgxtUQBF+/XSfafR5lZHseJX4
2nJH/O9ekBO87qO5Jqfj56sbYoCKZZEgo54RUw6LSUPPAixne98xmIdWv1U2nT38
DdYWbdoK9u43AacVaeV+qyWZ/lPALlJgeOIUFnwSPAifkxlg6UulGF1ymk8NwBE8
3E/oVItIba3kGPpnN0tjElz2aD15dCyEy2tQiM5wYwAePiIywKY=
=hyw1
-----END PGP SIGNATURE-----

--YFpmSusxkFTEQCxcL4WlnddxLtOBQOPC7--

