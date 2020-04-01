Date: Wed, 1 Apr 2020 21:32:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200401193258.GY1431@...1296...>
References: <20191111115025.1121-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="p0VvXOh+Vh0d4WRz"
Content-Disposition: inline
In-Reply-To: <20191111115025.1121-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] msvc: fix various level2 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--p0VvXOh+Vh0d4WRz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 11, 2019 at 01:50:25PM +0200, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> This also sets warnings level to level2, which
> makes them manageable.

Speaking about lingering patches... much has changed in the windows
drivering and bulding world, and I'm not sure the patch is applicable
to the "windows build" files.  It also does not apply to tun.c anymore.

Can you rebase and resend (... or just resend those parts that are still
needed...)?

Will do more timely review next round.

thanks,

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--p0VvXOh+Vh0d4WRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJehOxqAAoJEB2Cnv7KVigSKzML/0ImjRpKX0RFquEzjRMxZ+75
aBhXm8UKoBdnnqNhMh6Yjc9fXY18QNFGDeuGhFxCRF+ZmGf5UH/EmKtfhLDKLw4Z
Bd334m2O/A1ZhpRsSrbIVdQ+Jqoy3QSEu/KELSpkLnNdsvFra0Bkih2+kBTBgX6R
C9ix2HD2C5zbRWx6wzY8l57ftntJoHk4IN8GvYJuZ/Zw6s1spoBkzSxDl/bsMHjF
j4BfgB9n2CVDG4m/TulS6LqL55ylFExMFAzC3tuQ6wR6EyP3W3i+m1BokXN0Sno8
HXLkvRyguP0y4GWXvFtfgzqdE35cTLRegNRYVKtfxu6i5P2lGI4mfMMnCpAW/kpM
r7qbCBtHg3zdAfBAGM7141IrpK1psJfN/dFdUK1LJGs98mxoPtRUqB3MgC/xAaJ9
tpDVE7a7oBeQjSEwE5nWhVlobsYTlsGshQG8M50yKi0aLHRCe58ZZqT8Y5X14JHN
iYG26FzYOMJ5RoS5cw9M+uGwWZ9YLd2aeIVuMUEEMQ==
=dSiD
-----END PGP SIGNATURE-----

--p0VvXOh+Vh0d4WRz--

