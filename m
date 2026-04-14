Date: Tue, 14 Apr 2026 18:46:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ad5vfVV3vs7R6oEF@...1296...>
References: <20260414055721.16857-1-gert@...1296...>
 <202604141631.63EGV6ea032386@...2054...>
 <CAKuzo_hEqNHtmhqtUJPXpcuqjAc6vYQXsMB7k0BgrkA_xBu2Sw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kVRGIVkLUPfSfuPA"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hEqNHtmhqtUJPXpcuqjAc6vYQXsMB7k0BgrkA_xBu2Sw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Log when writing
 username/password to TLS buffer fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--kVRGIVkLUPfSfuPA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 14, 2026 at 12:43:58PM -0400, Selva Nair wrote:
> > I have not tested it - I guess one needs a GUI with "long password"
> support to trigger it :-)
>=20
> Not really.. long passwords work via the console even in pre-2.6 ! A
> password longer than about 1700 bytes will trigger it.

Amazing :-) - and indeed, being prodded to start thinking, this
USER_PASS_LEN being set to 4096 must have some sort of effect... - thanks.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kVRGIVkLUPfSfuPA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmneb3sACgkQHYKe/spW
KBIwlwwAsyGuBnV2dqb+guIyBe1kw1y7c9JRcmzb8VPCEEqzi58iDdCG9cyItOCA
ReoLxpP9xRcvgD+o1TSJFavUnL0tsBK6GBFv+szxXFhtgUH4p68kA4eU6RnX+wzL
QSVJZkZlI1uOeGrWmn+fbBo810eGZsPUHxWDk4vA3BTEnxHGPXVCtk3gND43c+QX
TuWmhf9CLGlQ7Tdqh39zNIi6WBWea9PjEF4OZvinCKzXXewFoSJn2f9czQxdr/p3
DGR9e8aQ/1xBqBfSx1V6qSWnnq2Gw5HW4KB2FhgXHPW65Xb181lqobW2n0J0PSZ7
QWXFrB+6rfn9xsol/CKru37cNngc3ymvoZrl3XfX8H8Zkw13yHd2PHLWbCeUePyT
Vh/i5TFGVM7uYDXYPXh/q5dQjBDFN5w01SgT/6SjhV4uboGqCHEq6+eklc4BqodT
H5QVSgX8Sb7Vp1vNd5nnbahLeHRLK0e7uYmeoECYu0wo4GaQCluJtDy9ECZF69XW
rjQBVyTo
=vtsV
-----END PGP SIGNATURE-----

--kVRGIVkLUPfSfuPA--

