Date: Sat, 28 Apr 2012 10:10:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120428081018.GH1359@...1296...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<4F9B1BBD.9010905@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qBOV/12gVmFoc0GF"
Content-Disposition: inline
In-Reply-To: <4F9B1BBD.9010905@...1114...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL 1.1
	RNG
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--qBOV/12gVmFoc0GF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 28, 2012 at 12:20:45AM +0200, David Sommerseth wrote:
> This is a summary of all the 6 applied patches.  All patches were applied=
 to
> the master branch and pushed out to -stable and -testing trees.

JFTR, the FreeBSD 9.0 buildslave now has PolarSSL 1.1.2 installed, and=20
building with it worked fine.  So thanks for that :-)

Right now I'm installing PolarSSL on the other *BSD buildslaves, and then
we should be back to "all green" regarding the buildbot setup \o/

Next thing: add client tests with both OpenSSL and PolarSSL...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qBOV/12gVmFoc0GF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT5ul6qkuBuNlUUl1AQKC2wP+OdpC7/nveGzTeZ6dKX/+O75rdFi89rN3
tGX6xWS5ga94v53l9q4kk5I3/woJXJ5a0jjbweuoMS1ljWIC59SEIK216XeCOnH2
7Xk3BGImgBFYGfr2Mz+H2is3gEgI2nl86hvhHB1UHkrYgtxr4QELvWaGhQTR3GtK
usGfyF8XFh4=
=gugW
-----END PGP SIGNATURE-----

--qBOV/12gVmFoc0GF--

