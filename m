From: Arne Schwabe <arne@...1227...>
References: <20200323171156.295122f1@...1661...>
 <CAFHpkQFbK8138bC8q0k8bC47yGWOJdhdE2OS2Obb8aqhiu9g=Q@...278...>
 <20200323181926.145d0bd0@...1661...>
Message-ID: <80470347-3b76-6c64-290c-b495d8ce7e25@...1227...>
Date: Tue, 24 Mar 2020 11:38:46 +0100
MIME-Version: 1.0
In-Reply-To: <20200323181926.145d0bd0@...1661...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xi64yXYL7hBnNK2J0RgJ2N13NU8z3We27"
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
--xi64yXYL7hBnNK2J0RgJ2N13NU8z3We27
Content-Type: multipart/mixed; boundary="ekFO6Ww3TGP8TEzi5oOlngbbrYbeePJnx"

--ekFO6Ww3TGP8TEzi5oOlngbbrYbeePJnx
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 23.03.20 um 18:19 schrieb Michael Kress:
> Hi,
>=20
> Unfortunatelly it seems, we are stuck to LZO for now, because it has
> been configured in the clients, which run 2.3. Most of these clients are
> offline most of the time, so reconfiguring or upgrading all of them
> before updating the server will become difficult.=20
>=20
> You are completely right: One reason for upgrading to OpenVPN 2.4 is
> indeed this feature. Another reason is, that Client and Server can
> negotiate to use AES instead of Blowfish :-)
>=20

You can use client-connect to disable compression for newer clients.
Example here: http://plai.de/android/peerid.py

I would suggest stub-v2 instead lz4 however since that effectively
disables compression completely (voracle).

AS also takes this approach. Maybe we should make that default in newer
versions.

Arne

P.S.: Sorry double copy, forgot to add CC to list in first email.


--ekFO6Ww3TGP8TEzi5oOlngbbrYbeePJnx--

--xi64yXYL7hBnNK2J0RgJ2N13NU8z3We27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl554zYACgkQFRhsZwKx
RFQGAhAAlrW1zK4X11M1LnnueqPlVxVLlEp86x2BMeardDRA44a7iFI7dLVZstxx
vkMcljRAa9hiuZ/ULg7QK3GI3BONxsiE5cFg3vdgj6HWaPWI0GtJt+9tOgoRizzP
akIv0rrkNSEysRLRG8hLJpDcJC0sccREquujaPG85lgpiUGB4MCsT1aj9THhw9NB
wjfM1xgCGuXct7W1qOiws1EqT7vhcFVeI8vjncrzo2oqkvOZ/9FqnQlNnHwh6mCG
N47USR/UgdFu3Sm0dvq43nWfW1+ztcNKRLaRrJCIDaPD+KzCEK+9gHJnUwVbiAfI
Ns9gQROGeqqDLHdYJVb67QxEjmFGeyB3o17EhhHgaJLfnbN9/r84h/Fd5OwxkMwg
WZbBbAE77pmZDtXjkRyf3drfv4+qphoRyrd5psvfROTjbtlHgjEBsw8tIvffk0Yx
Sc6yLr9d0XGXI05BCzvR8RRWcRKiOZRJYzVbAudhbXiCLe9OOV3RT5VmH1FTXp0x
CZ1nXGUapL+brZ6WLvHCYB55Y6jdLB3oXkkBP26KAAFrY2NOCIG99YLGAGM/oVl6
JmlgySMpLwsJvns528emdzfHgkIx6hmWQtyKp02XtjQdzsoDw/W2enscuoYy8rL8
2P/o5jtO5/t54ftPAgk9SrbvRC0cdY+wVboRiDzFXvzJDW/NZek=
=Tgps
-----END PGP SIGNATURE-----

--xi64yXYL7hBnNK2J0RgJ2N13NU8z3We27--

