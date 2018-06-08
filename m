Date: Fri, 8 Jun 2018 16:01:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180608140137.GA57262@...1296...>
References: <1528229170-6175-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nQHD+3g9yI+EYXJy"
Content-Disposition: inline
In-Reply-To: <1528229170-6175-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Replace M_DEBUG with D_LOW as the
 former is too verbose
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--nQHD+3g9yI+EYXJy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 05, 2018 at 04:06:10PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> M_DEBUG only indicates the type of the message and will print even
> at verb 0.  Use D_LOW which is M_DEBUG combined with verb =3D 4 and
> a mute level.

This does not want to apply for me - the tun.c hunk says "apply at
line 1043", but the line in question is in line 893, and the
context is different.

I assume this was on top of Antonio's v6-only 1/5?

OTOH this is trivial enough... I think the patch makes sense, it will
inevitably create a conflict with Antonio's v2 1/8, so I'll just=20
mangle the patch by hand.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nQHD+3g9yI+EYXJy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbGoxBAAoJEB2Cnv7KVigScpMMAJSews4wF8wAg4ZYeOLLwocJ
1OmByXXmr21a8WYBaq2Dhq6dxHKhnjBQi5JBysPla2/JXZ6MqB53POc53omUlqBT
yxhEZbU5ipaf46b05VVv0FTxubqnLgOpLIHncXG6X7H03s5ehM2JQ8A+0GTp493u
9ADYrJQUdlUpzcKlR7t+m7qcWXOg9EjkKAVKZurdRjArlwA5YL3V1LIqnJUy9QGP
V81iO7Vnwb+kFQkjCDcpIrDnAXpcqtzqmxSjAfAb6OGdrZocgKs9bGiwI2M3KGrO
rWMQHjQfUvx9p3dtuRoh/aysJajr37g8SMr83i50jwa7Jv3M+t4g1hhedJTCmMnV
DS5O1LAh1rioMmrbCkTS1yFgHUgneA1kgQrBNc3SjMTN55papEu2NAG/D9RR40ky
+pK+m5LcGCgmLYMbFNqRnGawX26gwWWf/D537g+UAWKlmo6I5XQMxt3vL5HImwTF
sWd+3KBnu5XjYB5cGVc2mpUsf6xluS5Hb853w4L0OQ==
=i2EN
-----END PGP SIGNATURE-----

--nQHD+3g9yI+EYXJy--

