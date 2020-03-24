References: <20200323171156.295122f1@...1661...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <276a2e33-fa92-0b23-1572-27596052ab33@...1227...>
Date: Tue, 24 Mar 2020 11:21:56 +0100
MIME-Version: 1.0
In-Reply-To: <20200323171156.295122f1@...1661...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VsUwSQn3OK93VihFXTAHdXqRI4Ezdo8U3"
Subject: Re: [Openvpn-devel] Possible memory alignment Problem in 2.4 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michael Kress <lists@...1660...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VsUwSQn3OK93VihFXTAHdXqRI4Ezdo8U3
Content-Type: multipart/mixed; boundary="NJ3isGcik8X0cmnNFQqiOO6ucu2CCXsil"

--NJ3isGcik8X0cmnNFQqiOO6ucu2CCXsil
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 23.03.20 um 17:11 schrieb Michael Kress:
> Hello list,
>=20
> There seems to be some kind of alignment problem in OpenVPN 2.4
> versions on ARMv4 based machines (32 bit), especially when lzo=20
> compression kicks in.

LZO is known to miscompile with gcc 10 and requires -fno-strict-aliasing
to compile. and also in my OpenVPN for Android app I have to compile lzo
with -O1 instead -O2 since it otherwise segfaults on armv7a. Android
uses LLVM/clang to compile so the broken behaviour is present also on
other compilers. I never investigated which optimisation flag does break
in clang/llvm/armv7a.

But bottom line is that you probably are running in a similar and I
would advise to compile lzo with less optimisation.

Arne




--NJ3isGcik8X0cmnNFQqiOO6ucu2CCXsil--

--VsUwSQn3OK93VihFXTAHdXqRI4Ezdo8U3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5530UACgkQFRhsZwKx
RFTuig//dQSzvv+9IypVHuRQtbxQnDwYlr2/lQUL3Dj0XejbxEtUUrZmY3dHZn78
18RVEPvZxx8IAtYUuaFUJNBzUxLaUYGbXTZLOhV/cPY4FChVrYYn0X6E+8X+yRv6
YNCXO5nyEOEwDu7sbxYCoC3lr5Tv/V/bK1OC3jNDhHZ15p/1R+YZznRGJS1JTjS/
jx6IhZmkLd0OGfz6NHRdlEXmAsTyq0MH6xOm+dNOTVhYBpXLqqi73bvz1aEy+T2L
8qZNJZGE/Jn34ekkLg5YiTgQZrVTgWvU0bAAO8XJLIo9NtwYWf4SO1p9zH6AaE5z
fIhmpqEQSv8S874vpY+7nFZsgSAH63L6JIUmZncIHXrYulTJJQFQFbkJpQsCHAJZ
Ygamc/BmmJ/PWW58g5kVRWVIo8MoHCSNkUiMgCoMR7xZ0yciafqpHpN8e645tgsr
r7zPhyjmzG5zBtWOm0ML2Y2EucknjM/vtwG+hVnx+zqObuAHsq4XO4nUj98ijg+p
SIEGo1gXPMGEZGMhrYtaP3Tvu+GeEK2dLSfcdevUczqqWhNSNDWSVrbCoC5olSQL
Jyl745wKXXrbUKP6mLnKhiu0TgM0JyfYa3p1pokuyjIAMwCXRLirZZ6imoh7GDha
asOfTWCWTwrCtL+vSzGG/KHkchfpRvLFxDNZjTqGpoZJESNMgeY=
=QDAa
-----END PGP SIGNATURE-----

--VsUwSQn3OK93VihFXTAHdXqRI4Ezdo8U3--

