Date: Sun, 2 Apr 2017 11:17:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170402091717.GS93896@...1296...>
References: <323226c5-b097-9d1c-5d43-0790cfa1ccfb@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MWrNmmo+n+ez9Z40"
Content-Disposition: inline
In-Reply-To: <323226c5-b097-9d1c-5d43-0790cfa1ccfb@...277...>
Subject: Re: [Openvpn-devel] gentoo build inconsistency with openssl in
 openvpn using elliptic curve cert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--MWrNmmo+n+ez9Z40
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 02, 2017 at 12:57:41AM +0100, debbie10t wrote:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 1. BROKEN METHOD
>     *************
[..]
> me@...2259... ~/openvpn $ ldd -v 2.4/src/openvpn/openvpn
[..]
> 	libcrypto.so.1.0.0 =3D> /usr/lib64/libcrypto.so.1.0.0 (0x00007f44f2c3600=
0)
> 	libssl.so.1.0.0 =3D> /usr/lib64/libssl.so.1.0.0 (0x00007f44f29cc000)
[..]


> 2. WORKING METHOD
>     **************
[..]
> me@...2259... ~/openvpn/btest/generic $ ldd -v=20
> image-native/openvpn/sbin/openvpn
[..]
> 	libssl.so.1.0.0 =3D>=20
> /home/me/openvpn/btest/generic/image-native/openvpn/lib/libssl.so.1.0.0=20
> (0x00007f5832464000)
> 	libcrypto.so.1.0.0 =3D>=20
> /home/me/openvpn/btest/generic/image-native/openvpn/lib/libcrypto.so.1.0.=
0=20
> (0x00007f5832009000)


This translates to "if you use the openssl library that you built yourself,
EC works, if you use the system library, it doesn't".

Now *why* this is so, I can't say, but filing a bug with the gentoo openssl
port might be a reasonable starting point...

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MWrNmmo+n+ez9Z40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY4MGdAAoJEB2Cnv7KVigSMGcL/RnEj63UYq8mWBiScvp+FK98
WwckugFlNJVCiu1B99VWsu1IuOcHa3D0RBzH6wVnh0hjsTClPhWj3usaYEQPGj7B
oCMgB7Bj81dSOzkqQWqkhmimQ6XD3jSzmZX0Uyt0cPuUfwOEKOhA8QMQFXvSp2JH
P3jAh/PS/3pdjoN6WPerUjzxpAPefiQDnR77yLpOPTlY5smdDywfAMpWOBaZ1MXU
DyYqT8O78rrSCS2me7LXoTZxicDzyDT+1j5BxLfSrOgUMHf2FRX8qbW+LiQlzQ78
ORum4tZ3GU2lzrr02dh+eQrPl9Ieqs53B6OJcBulvHXvFMYB+JvDXwx7xhLNMm6b
NdtoptKc0H4fXmYI59PgIGKydgMcBqynrit0uxngmI25R2fyKtTk7t/0+Ne6STaM
p9tc0m7hWPn4UaO4m3pIzwC4EOwjKGsbrGIyTEARzJhMdSQMJ3v5fIZsfESVg7hk
8YnzmTZlfBkzhqWQRHrpwTY+8PErbvl7E82DsmHJpQ==
=tosh
-----END PGP SIGNATURE-----

--MWrNmmo+n+ez9Z40--

