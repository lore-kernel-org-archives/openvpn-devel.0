From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 14 Nov 2013 20:11:13 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90151EABFFA3@...1436...>
References: <5284F32D.3000206@...1085...>
In-Reply-To: <5284F32D.3000206@...1085...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Require a 1.2.x PolarSSL version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Josh Cepek <josh.cepek@...1085...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Ack, the polarssl API policy requires us to be this strict.

-Steffan

> -----Original Message-----
> From: Josh Cepek [mailto:josh.cepek@...1085...]
> Sent: donderdag 14 november 2013 16:59
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] [PATCH] Require a 1.2.x PolarSSL version
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> When used with PolarSSL, OpenVPN requires a library version 1.2.x (and
> not later.)
>=20
> The attached patch fixes bug#343.
>=20
> - --
> Josh Cepek
>=20
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.20 (GNU/Linux)
>=20
> iQGcBAEBAgAGBQJShPMtAAoJENcx2Xpgb9RjfvkL/0R/n9dbIE59ox8M7TH6dsIZ
> yG8Sd0syIjZANwqti1WSwYjKI3cTnngTQH0piFaxPm37p+fj2ZudkggXnlzRvdBN
> GXdE3c1PDo13rGVKLopTUZ1pmX4zVHvCRkhhQaI6d6MFDqWauBUawIIEEmyen/xx
> jhgYJIzLYYaMN5Aent/yxScPleuze1d9b3cxoKsLNHLqcpj7WaN08YHW5It8KYWG
> 2AFFfrfvnpqSxO2ksP4AK/N2BRsAHOhmj1VCr5nQm59RrNB7PV5+aMBai3Rk8aMH
> xfkjSML6Y/vJ9vn/NZ2ohFKoobK7MpLnmHbp5VMfzUSiu3ew46euXyRorJRS4FQW
> xq3i73DbDiRJziJNvKsbT9qSEfqTcQY/7XhLwVdFPuZmL7bcTICeClz4TCqV9BrB
> 8kIIrGE9Q6cuM553/mWy/7SmnFDmaYSi3Tpeg18gXUB9TvH9eTpbgwr0cNwNAl/P
> S/N/pgU5owhhi59saD7Ao6tMD+nHTtiS2QMgnZF10A=3D=3D
> =3DwH4G
> -----END PGP SIGNATURE-----

