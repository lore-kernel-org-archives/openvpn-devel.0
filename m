Date: Wed, 17 Jan 2024 22:23:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZahFU-bb4tYzpuRF@...1296...>
References: <gerrit.1700494503000.Icb4ae73741dc84ef0ff7ef72721cc12b999f4d03@...2715...>
 <23e0425453aae49e79eb5754cba15ab588dd1f72-HTML@...2715...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="p+Oor8mUVAH/owFN"
Content-Disposition: inline
In-Reply-To: <23e0425453aae49e79eb5754cba15ab588dd1f72-HTML@...2715...>
Subject: Re: [Openvpn-devel] [L] Change in openvpn[release/2.6]: Backport
 mbed TLS 3 support to OpenVPN 2.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: max@...2606..., arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

--p+Oor8mUVAH/owFN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 20, 2023 at 03:35:05PM +0000, MaxF (Code Review) wrote:
> Change subject: Backport mbed TLS 3 support to OpenVPN 2.6
> ......................................................................
>=20
> Backport mbed TLS 3 support to OpenVPN 2.6
>=20
> Based on commits
> - ace7a4f1c271550bb8ad276663e045ab97a46f16
> - f53f06316dbb804128fc5cbee1d8edb274ce81df
> - efad93d049c318a3bd9ea5956c6ac8237b8d6d70
> - b5faf1b2e90fd44c5137a2b8f3da98c7ae482fc1

So, after discussion with Arne how to proceed, we decided to not
apply this patch from gerrit "as is", but to do explicit cherry-picking
of these 4 commits - so git history directly tracks which bits came
from where.

This brings now 4 new commits in release/2.6:

commit 001950d14eefe60fd71b6a7091161b0546ff5a9e (HEAD -> release/2.6)
Author: Max Fillinger <maximilian.fillinger@...2507...>
Date:   Fri Nov 17 10:14:01 2023 +0100

    Enable key export with mbed TLS 3.x.y
    (cherry picked from commit b5faf1b2e90fd44c5137a2b8f3da98c7ae482fc1)

commit 7fa534dbb81c7e3d526a2e9110f35d11de26105c
Author: Max Fillinger <maximilian.fillinger@...2507...>
Date:   Wed Nov 15 16:17:40 2023 +0100

    Disable TLS 1.3 support with mbed TLS
    (cherry picked from commit efad93d049c318a3bd9ea5956c6ac8237b8d6d70)

commit 1aa2995ebc06a2b8d6df48eb63eb15482fd07865
Author: Max Fillinger <max@...2606...>
Date:   Wed Oct 25 14:19:28 2023 +0200

    Update README.mbedtls
    (cherry picked from commit f53f06316dbb804128fc5cbee1d8edb274ce81df)

commit 2942ef5d405413d990d1fc2fa06976bcdd24742e
Author: Max Fillinger <max@...2606...>
Date:   Wed Oct 25 14:18:30 2023 +0200

    Add support for mbedtls 3.X.Y
    (cherry picked from commit ace7a4f1c271550bb8ad276663e045ab97a46f16)


I have tested the resulting source tree with mbedTLS 2.28.6 (FreeBSD
package default) and 3.5.1 (latest 3.x, build from source) - t_client=20
only, but that should be sufficient - and the result is satisfactory

OpenVPN 2.6.8 [git:release/2.6/001950d14eefe60f] amd64-unknown-freebsd13.2 =
[SSL (mbed TLS)] [LZO] [LZ4] [MH/RECVDA] [AEAD] built on Jan 17 2024
library versions: mbed TLS 3.5.1, LZO 2.10

Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 2f 3 4 4a 4b 5 6 8 8=
a 9 9a 9b 9x.
./t_lpback.sh: tests passed: 21  failed: 0

(that is the test result with 2.28.6 - with 3.5.1, all tests involving
BF-CBC fail, as that is no longer a supported cipher, but everything else
passes just fine)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--p+Oor8mUVAH/owFN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlqEVTAAoJEB2Cnv7KVigSHO4L/R58ScjLGMvvUZGICCyTQGzc
ADAAK8CnbTyTpxTWtmi6eerR+zimO3dgXdR9xHfKTdvFjkBZE1uuGvSdG182AIpj
s8CS+JkM8mWQlbToE3+UM8OiOrUvWFwOcFxfwvhKLH2bQ3Yn8lcB1wMXyw0K6bna
WMg+YnvSdi8Ja6cx+vyjLX+nP1XqdfAWaAmDjlGP7+v9IPh97UXwt6zTq9J0OGZn
VYxxJbZF7lssoMubgj4xpDeyZh2AjnaIHMKDbgOWNssxI5BYGeBwlmDTonXVJQiL
Yw0YjHqjHwfqsm6qNGde+Zt+uG3dxAgu8ieFLYLAG4ncJUfkspXtKVgzPG2//rdH
Fa/ZlCURMA8QfZ881/awGvj/y4rRajW9YTKkoc2+lKEi//n2qnLF4oS0X7BwTSwL
I7fRa3vTbjXTdd+0PTUByK9PYuZhpZCYy7lqKwYi/YXyV6UIgFOpyxOd+bfE5k82
qCTF1QLONPGXLXdnpuUa7PsWkSjcwq/0OyqkMIWVYg==
=hmY2
-----END PGP SIGNATURE-----

--p+Oor8mUVAH/owFN--

