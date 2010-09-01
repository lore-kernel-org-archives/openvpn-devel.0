Date: Wed, 1 Sep 2010 16:39:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100901143932.GX10703@...1296...>
References: <AANLkTinjxHX-3baqYZARRT3SpYae8a-44CXNPkTXBXtC@...278...>
	<20100901135851.GW10703@...1296...>
	<AANLkTi=uKEMyK0eKZR8UKShAxm2Dy6oRJqtsPvBDqJ3W@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CSNFvL6ilyiKL/Hs"
Content-Disposition: inline
In-Reply-To: <AANLkTi=uKEMyK0eKZR8UKShAxm2Dy6oRJqtsPvBDqJ3W@...278...>
Subject: Re: [Openvpn-devel] Compiling OpenVPN for Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Allan Swanepoel <allanice001@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--CSNFvL6ilyiKL/Hs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 01, 2010 at 04:21:53PM +0200, Allan Swanepoel wrote:
> > If you use the pre-compiled tun/tap driver from the 2.1.3 windows
> > bundle, you don't need the MS DDK/WDK, just msys+mingw and the NSIS
> > installer-builder.
>=20
> Won't msys & mingw then become dependencies for running openvpn?

no.  This is not cygwin :-) - msys is just the run-time for being able
to run "bash" things on windows.  mingw builds native windows binaries
using native windows libraries (as opposed to gcc inside cygwin, which
creates binaries that need the cygwin dll).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CSNFvL6ilyiKL/Hs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTH5lpKkuBuNlUUl1AQLtvAQAi0Q6Kbdyu4Dh3I8KN5odcejYPq2zYjHA
v+JjnG7vrwINMjM6RDN0kbnEqqWpNB+1O7xaf/I6xk55OUO2ZXrmNjGcyrvfcRQo
x73H2YjnWGTqMbW1GOceieDsJ4ubLLz8FctyR0bwBqlD4HsK+gE4X67VIuwAKqSP
29d/tPmX0KY=
=JnuA
-----END PGP SIGNATURE-----

--CSNFvL6ilyiKL/Hs--

