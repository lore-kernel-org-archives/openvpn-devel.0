From: Arne Schwabe <arne@...1227...>
References: <20200722093050.20474-1-arne@...1227...>
 <20200722093050.20474-2-arne@...1227...>
Message-ID: <e2ca42cd-429c-8384-4a77-162bf57d7f8b@...1227...>
Date: Sat, 25 Jul 2020 13:45:12 +0200
MIME-Version: 1.0
In-Reply-To: <20200722093050.20474-2-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eWQkjfr4OU44rFQrjpz7tOua5qFXi6IzG"
Subject: Re: [Openvpn-devel] [PATCH 2/3] Cleanup tls_pre_decrypt_lite and
 tls_pre_encrypt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eWQkjfr4OU44rFQrjpz7tOua5qFXi6IzG
Content-Type: multipart/mixed; boundary="jUB0n4M2iCBkVfKN1y2Pxr84i6xFjdEuw"

--jUB0n4M2iCBkVfKN1y2Pxr84i6xFjdEuw
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.07.20 um 11:30 schrieb Arne Schwabe:
> Mostly C90 -> C99 cleanups and again immediately instead
> wrapping function body into if.
>=20
> (Review with ignore whitespace)


I made a mistake in this. Ignore it and wait for V2



--jUB0n4M2iCBkVfKN1y2Pxr84i6xFjdEuw--

--eWQkjfr4OU44rFQrjpz7tOua5qFXi6IzG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8cG0gACgkQFRhsZwKx
RFS3dA//TB81wVYKevU0OigvLr0O+BY3HHzEA+gAF8Ur7QKqX5N1p6KKNZtYXFdF
1hVENH7C06FTbOQB019sWb/u+uMlQ8ELuAzF6lR2Y+77rKN4veKjHMKZfPqoHsJJ
eFLXEwJmetsq5tjwhaBdUyDSmP9skAtI2/Uq5a0JQNVF98S5fDoLZFEj/Yj1c7Hg
3jjK9hewL3bda5hEjLiPwWeuN11CvfIiNta3Z2izYhQTB7eeJjmaiiDWj+pj8T/F
I5lUT5seP2Vo3p1YMlRpPV5ODQlA3wM2URZjdee1169YcHHOPORBmk2N4aF92GoK
FtixzZnbEzwn4VgzxAbakvXkoXz6g3E6B7qqPqC2lZGhKluB9AeaDJlReONzWBm5
U7uzzm5soTO0PfsOjIwj46lk1ACqu1RBXM93cFfucUax2DL96tUKhEUZdvgscbCG
PC3PLvFqQUyZitauZk6DYESejjdddM1+03KDDWrxYAcLbvQM0pa2TpJT5Wrp3Yef
hBkxk+xtqXdXpH8mRs0YAEKrmdkISnUHy1Or9H+e0istbJKY83x2CSEm6nzeNElG
Tc9x4zgXRUZ8UO2J6TYrWKPiqDhuw039yVkIi+uYyfDj5uTbS/55Xo6C9lzGxJ3k
B4oM3HOTIPYBDfYxd2nmSc0xM4GOU1yfDfW8quxnpuc7gIn1YM4=
=RuOV
-----END PGP SIGNATURE-----

--eWQkjfr4OU44rFQrjpz7tOua5qFXi6IzG--

