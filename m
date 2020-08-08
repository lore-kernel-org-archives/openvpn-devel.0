References: <20200729113835.2415-1-arne@...1227...>
 <20200804202010.GV75094@...1296...>
 <b8c90764-96e4-6e6d-2060-ee3d84cb446d@...1227...>
 <20200805064318.GY75094@...1296...>
 <20200805114523.GA75094@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f382976e-4125-ff7c-6d2c-84de886db5af@...1227...>
Date: Sat, 8 Aug 2020 20:11:13 +0200
MIME-Version: 1.0
In-Reply-To: <20200805114523.GA75094@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H9aFzM7rBBQVJoGdladxjJpZIN3gKYK7k"
Subject: Re: [Openvpn-devel] [PATCH v2] Rework NCP compability logic and
 drop BF-CBC support by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H9aFzM7rBBQVJoGdladxjJpZIN3gKYK7k
Content-Type: multipart/mixed; boundary="zCSgpRPvI1DAJpt5c5amFav5B8p8F9Oon"

--zCSgpRPvI1DAJpt5c5amFav5B8p8F9Oon
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


>=20
>=20
> Not sure how to tackle the "ccd/ push cipher is broken now with 2.4-NCP
> clients" part.  I think this is useful functionality, but the current
> patch does not allow this "unless the client is already using the to-be-
> pushed cipher, or it's one of the two NCP=3D2 AEAD ciphers".  Which makes
> it slightly less than useful...


I am not sure we can fix this in a good way. The behaviour is bascially
blindly push a cipher no matter what the client announces.

What we would need to still support this behaviour is a


--data-cipher-force-cipher-if-only-iv_ncp2-present cipher

that picks that cipher if the client has only IV_NCP=3D2. That sounds like
a very ugly and obscure option. Or an option that is

--iv-ncp-2-is-data-ciphers "foo:AES-128-CBC:MySpecial-Cipher"

and then the server would translate IV_NCP=3D2 to that list instead of
"AES-256-GCM:AES-128-GCM"

All other options that I can come up break proper negotiation support.
The option names are of course silly and would need to be replaced by
better sounding alternatives. *If* we want to support this corner case I
would suggest the second alternative and implement it in a follow up
patch. The question is if this corner case is important enough to
support it.

Arne


--zCSgpRPvI1DAJpt5c5amFav5B8p8F9Oon--

--H9aFzM7rBBQVJoGdladxjJpZIN3gKYK7k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8u6sEACgkQFRhsZwKx
RFR9XQ/9EGXewVEjAc+27yRoqU1aoT4esQxTY7PBM+gK3o5Zv1hkJLCnukPFlfpE
boj9AEgnnvl+0rBZO2vAGL3x12qONYVT4EDnELzDC7QpHtm578PneeGmHlE7Q7Qb
XokGLBasuGNKeg66/u4e4W5V++0Ibvft5J5nvf+ifgwmiN6lgBq5quz7kHL+cDrX
fW7dJSBJ5XavU/XaJeAu20S31n6vj98o53IlSMV6ecXxHfDxFEbId6OPytLFgTbl
P6jOcDzqEDVlhmxA10pmohGrPTwifnUYysSZ8+bHa2Gtpyicu0mKKw9poNjcNrS2
LIAl85rU9GYj+0DVFQYB7FfHoErLYsdYPgm7yxnZxuI594QejHNefdkz62atS6YW
B8YTuI9EltD/70Fj7DDISO9hmT2rGE+HqKRaL1kdBwfYUrCA9KCoRL9pETHwDC/E
Iabe2WRx3VukEfi34pZU2cwndbO/Cm71wKXQSbqnNFcu7wWzROUUh5ko8n6BRZYC
geEkQmpb/jeRmPBwMCoVbnBh/BY+hSJxv29aWTqm/eyMARE0qOEswTHgy6f+IcSj
FODG6I3zi8Qh/GW4dfbMTsmSAKG1kas74euus8+kP7HSDpDc/VAxQdj9Sz2GbAu2
v5mQLKUFmkXWOoHXLNTuQbiinbMCgyuTEP/2bdIuOay3FJxZRIc=
=IrJB
-----END PGP SIGNATURE-----

--H9aFzM7rBBQVJoGdladxjJpZIN3gKYK7k--

