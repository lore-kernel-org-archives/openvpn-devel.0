Date: Wed, 9 Feb 2022 08:24:03 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YgNsE+a/M3V1TY2U@...1296...>
References: <20220208114905.100-1-lstipakov@...277...>
 <202202082110.218LA9Qq023411@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kIQyb0ewD8lw6ot8"
Content-Disposition: inline
In-Reply-To: <202202082110.218LA9Qq023411@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: msvc: cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--kIQyb0ewD8lw6ot8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 08, 2022 at 10:10:09PM +0100, Gert Doering wrote:
> Have not tested anything, but it shouldn't break anything but MSVC
> building, and that's your field of expertise anyway :) - Makefile.am
> change to avoid breaking "make dist", thanks.
>=20
> Your patch has been applied to the master branch.
>=20
> commit ff5723c4ddfee28564500d28a1bd78766171ea3e
> Author: Lev Stipakov
> Date:   Tue Feb 8 13:49:05 2022 +0200

... and to release/2.5 as well.

commit ff335a9043807bf760213b6dfd4d47fcda5a775f (HEAD -> release/2.5)
Author: Lev Stipakov <lev@...515...>
Date:   Tue Feb 8 13:49:05 2022 +0200

    msvc: cleanup

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kIQyb0ewD8lw6ot8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiA2wTAAoJEB2Cnv7KVigSGE8MAJj5e2bLfkmKTmpnpzkXqc7K
M3J7N+C2xWB45pGAHavIXOjO3RptKub2MNqC82TnYXASz098iANKmO9h+Ih6BjSV
GnM2vQ7K7y85lYPR90pMVnEwZ2IdrXcBNT0KKFG64nH/g8tovX6jzO8HV7d2bknH
pY5QGHQ3TfxGpSLxvFA7ic5yTnp4RqnaSHC0Zxoiwr0wT076EM4K8tRVi3TQbYgE
k/Wyv7rpoXZt1bbsEitP/tFNip+9g4CM1a1GC7pvH3Yd9tz9BJUllq1rCAsrSTzN
te/AK6wJAbdRmskPygNQyfXYBdUxZxgWQKKxBq/YIAWMBPsYFh/gws+etpiO6bKC
zX9iZc6PXYDVgi+NdPD4MQs1MEyQShbTlb+lqCT06GKXDX8/aajuoSTfCNY0UVrZ
CYevaaHSmjql4Cjk58p84f+BluXkUWoFRE23iqfSdeI8d0gFBKhMksMmLmbut91M
5bBe/3hQPO1nd3P3S/T9KBpK4Hns9w3irSk7ZQJZ8w==
=sGja
-----END PGP SIGNATURE-----

--kIQyb0ewD8lw6ot8--

