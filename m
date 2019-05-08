References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-3-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4f284768-b0c6-a320-fa62-3d1462cf8c8d@...1227...>
Date: Wed, 8 May 2019 16:58:17 +0200
MIME-Version: 1.0
In-Reply-To: <20181219050118.6568-3-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fSfB4hIvgFMXxEmqJprkEICDgSSFv0giz"
Subject: Re: [Openvpn-devel] [PATCH v3 2/7] introduce sitnl: Simplified
 Interface To NetLink
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
--fSfB4hIvgFMXxEmqJprkEICDgSSFv0giz
Content-Type: multipart/mixed; boundary="1mUhtrPUThV3dwhRrcoIz1CkRyWWZoRne";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <4f284768-b0c6-a320-fa62-3d1462cf8c8d@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/7] introduce sitnl: Simplified
 Interface To NetLink
References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-3-a@...2181...>
In-Reply-To: <20181219050118.6568-3-a@...2181...>

--1mUhtrPUThV3dwhRrcoIz1CkRyWWZoRne
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 19.12.18 um 06:01 schrieb Antonio Quartulli:
> This patch introduces a tiny netlink interface, optimized
> for the openvpn use case.
>=20
> It basically exposes all those operations that are currently
> handled by directly calling the /sbin/ip command (or even
> ifconfig/route, if configured).
>=20
> By using netlink, openvpn won't need to spawn new processes
> when configuring the tun interface or routes.
> This new approach will also allow openvpn to be granted
> CAP_NET_ADMIN and be able to properly work even though it
> dropped the root privileges (currently handled via workarounds).
>=20
> By moving this logic into the sitnl module, tun.c and route.c
> also benefit from some code simplification
>=20

Acked-By: Arne Schwabe <arne@...1227...>


--1mUhtrPUThV3dwhRrcoIz1CkRyWWZoRne--

--fSfB4hIvgFMXxEmqJprkEICDgSSFv0giz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlzS7okACgkQFRhsZwKx
RFTifhAAqfbKi73Ert60xm5VCLtRGUyUODFI78r/l2Q/uv0sYL9O/Fo1tepezTxH
Sda4kR1vM4sj5mWTVd/zWIrOMW5Estmx9eKjF5Z4cRKutLxorIgJUHkPLEWy45os
Zle5wtXULgRnb5LgKXjo9dNi6d/l4GN6QR33sFeBQEfIsq720+NA4Y5IZVd7d/P7
2B3kAbFY8aZIn7Fi2V+XVzCLGGWhn0aPD64jZFMHX6WZj+gzZOzkbEk8P5uM9uRK
AQmW16P3cL94A1rFPGJwaDqr9fGV/+06n7M/RBOOTIWPj4+jkGYR62lRYxL+0u+b
hNO/NGVx5Aqsf4sy3eGAYjx9/01Li3Lvv3Qsxq4VvTffiLl+9ha0TRJObOCjP4Af
dGqm3bhA3aQqLbv2yjBCIY72id07pHCguX23jnTPzF417TimgIBiw1QXiEKGAt8V
8rykL+bm9XAcIcqFqK4D3Rtiq3El6HyAAhxaiqbg42ktxSWCR3Sbb90ZNPscu3Nw
rsie/wgjtgO2YJZhs0mK941jIqjrBx3T2oZpx4ZPzpHFThwgaGqpZ9Hi+4j1gvOq
uVhHUnCoYOKj6Lgec6Xriq6KkNyYqYophlJhWA0XZi8JwpTea2DQYGPlPVFtq2eM
DjlAmjr0/sDbaZ2RjV6lqDU5QrB3qGzOwr1Heahl1TCOsxlOAkE=
=snFJ
-----END PGP SIGNATURE-----

--fSfB4hIvgFMXxEmqJprkEICDgSSFv0giz--

