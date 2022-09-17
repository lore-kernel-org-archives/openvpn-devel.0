Date: Sat, 17 Sep 2022 16:40:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YyXcXbpO6wGR49KF@...1296...>
References: <20220917140518.2497-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2xy4QWE2qpLPz6XZ"
Content-Disposition: inline
In-Reply-To: <20220917140518.2497-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Changes open vpn exit code defines
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Alexandr Kutashov <kutashov.alexandr@...1411...>

--2xy4QWE2qpLPz6XZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 17, 2022 at 04:05:18PM +0200, Antonio Quartulli wrote:
> From: Alexandr Kutashov <kutashov.alexandr@...1411...>
>=20
> It's better to have distinct enums for more straightforward debug of exit=
 function.
>=20
> Signed-off-by: Alexandr Kutashov <kutashov.alexandr@...1411...>

Not sure this is important.  But if we do so, we should document which
exit code means what (outside error.h)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2xy4QWE2qpLPz6XZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjJdxdAAoJEB2Cnv7KVigS4c4MAIoU/6gpLBCwdkJre1d/DkPl
iE2nGLnw2RCT0hEy2V3+D1n11OYCxi2oKxrsAtWsUrX6+vElfLQTPJiTPiySg7rx
dEcYcuFXFHTRpHnHA0PzLMatfyNjomrAV5kvHpLq46KJN9X8YM+cvwZs6cGhwrhX
pwmoZrv0D/B+PSDpQecQDhtauiOgppMNADQZjVp0szynfxqdDtJuS3/n3BUHDXcc
j8SYWj/XmiJr1zju61QaHWaQRsNOunKysEZoWFp+Ub6M2BIVvmygBAPHyWlB6Omp
9bTVV1i/cRkqL7zor4a8CA+bySRwOlxkjONMNXiTM29/KQvMQ0pIDlB4mTFDOMZJ
VhSnTISVZNVUadT0qw5u/+aeNahi0dAt8CsEivjofrSo+M+3xHkAYeo/7ObJa0yX
eJYpiIGgqhhEesBHOPRg1gPQckKQhVqJyIOgbvSXf55QOFN1JdbumAzYgDz2RB7u
HMxMBvwaFJjMyZE6qJHdid66A/xRMAURBu1HHLLzRw==
=c38G
-----END PGP SIGNATURE-----

--2xy4QWE2qpLPz6XZ--

