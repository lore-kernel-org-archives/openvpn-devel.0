Date: Fri, 21 Jan 2022 15:29:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YerDMmuWZZWHLR22@...1296...>
References: <20220120101125.31234-1-a@...2181...>
 <20220121140941.13930-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xfCyUonnLDQ2dZ1C"
Content-Disposition: inline
In-Reply-To: <20220121140941.13930-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] unit-test: fix test_crypto when
 USE_COMP is not defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--xfCyUonnLDQ2dZ1C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 21, 2022 at 03:09:41PM +0100, Antonio Quartulli wrote:
> This unit-test did not consider the case when USE_COMP is not defined,
> thus generating a compiler error.
>=20
> Adapt the test to the case when no compression is available.
>=20
> Cc: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

NAK.  Github says it now fails at "make check" time.

[ RUN      ] test_occ_mtu_calculation
[  ERROR   ] --- 0x5a8 !=3D 0x5a9
[  FAILED  ] test_occ_mtu_calculation
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 6 test(s) run.
[   LINE   ] --- test_crypto.c:304: error: Failure!
[  PASSED  ] 5 test(s).
[  FAILED  ] 1 test(s), listed below:
[  FAILED  ] test_occ_mtu_calculation

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xfCyUonnLDQ2dZ1C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh6sMyAAoJEB2Cnv7KVigSKgYL/RL6pQnApLuIW7mEdNBv90Z4
AEbFT7nc8RkA25mBRH41UT0aL5U3vGcVW1JxU9io2utLE0AR3T+n71xDxYSEmdi4
OOotOGfbXqi3ErYTEaqFfkOnywADunxJIPVO7hXNUzhpL1nfPKGLigwuwme9nB52
OsPRBGOJRlvYGGC3U4LWT/Xpflt4WqCs2sctpY4Lo07rZF3veh4vguj93SNQf1o+
oCAbdUmKQmoJGD4qWq2oLsan2wPzlAGa4DcDPnZ39zz9iX+6Tyy3vHpkZ7UoHkge
DqHBQPN2ZoDjbDXFbqwJoQR+tHW71K3MjoTW4TJzskHtOT2hCLMEdtmPWnnr0wTF
vvXKN9ZP0S3B/rXxYM1neDyb2d1EDhUMfxpi5NMAkTVvcV4LHhCCFtMmQyW4Ertb
QZ3KCwNPdEKt78KL6K6FxVceuP4AeMb4TeFxrIpMh5B8k2s2IzVZzZQsbY53m94z
nsMc2lcG7vdID7UB88IQHoLvqbJpG6Pyt7Qw94uPOg==
=UccQ
-----END PGP SIGNATURE-----

--xfCyUonnLDQ2dZ1C--

