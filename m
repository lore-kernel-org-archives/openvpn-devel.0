Date: Thu, 1 Apr 2021 09:38:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210401073828.GH976@...1296...>
References: <20210322084331.94770-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="S6ZsHKYz287jOV7o"
Content-Disposition: inline
In-Reply-To: <20210322084331.94770-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add LZ4 prerequisite building.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--S6ZsHKYz287jOV7o
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 22, 2021 at 09:43:31AM +0100, Gert Doering wrote:
> commit 24596b258aa3a removed the bundled compat-lz4 from OpenVPN, thus
> breaking windows/nsis builds with default config ("--enable-lz4").
>=20
> Add download URLs and build invocation.  Since LZ4 has no "configure"
> script, we pass the appropriate CC=3D/LD=3D/WINDRES=3D statement to "make=
".
>=20
> Only static library is installed, since static linking is easier here
> than to extend NSIS to bundle lz4.dll (+ whatever else is needed).

Just for the record.  Samuli has turned this into a PR for openvpn-build,
  https://github.com/OpenVPN/openvpn-build/pull/210=20
which got tested & ACKed by Lev and just merged by me.

So closing this on patchwork as "Accepted".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--S6ZsHKYz287jOV7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgZXhzAAoJEB2Cnv7KVigS9M0MAJHgDADLEdRHSnvUAx6/brSl
B+aiOA9oXfL7g6nwgr4nWtb9kUtJ95ujG0JZ/a1hMYqm7svLCu6bx+olECMccMst
f1MtGwkGJFd/fwpYE30YWK1IHoHDZqPE1nU/KcJ6VORxYM3siyieL8V3HRrgvLHW
5NxY/tk55gLbm2swalDghJLpKHEJy/uCL2Wh5+VpfZXjaCoYDu5T14wJSliPAox5
L4qPCFU3gmTejdNrzN/WRDLXBoz+jgf4Wr3DwQm13zx5TnVcDCLKqBTAvfZl+I5B
Jn/wqQgy40BN6ggdPkZ/DIUSVUrJPRpzDjeu0lhafZ8rNRib6cMsc3IeB9PUkdkI
3brevgXC/MpwXrfomeGVZt8FYGmqpcNEWmpTo/Ykcs1tvOqvZgAna3nxqMITNqzQ
/q7Xe5Z821x0YmJu8LI3v0gh+rD4yLe+JnYqOVuuybZM8F3T6ZDBNmbiF4PRTB1J
8Bhsad8ej9/Equ45EMdPvKNoX8IYRI2usqhc9sthsA==
=0z7W
-----END PGP SIGNATURE-----

--S6ZsHKYz287jOV7o--

