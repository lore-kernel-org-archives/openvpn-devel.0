Date: Sat, 26 Dec 2015 10:35:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151226093550.GW24952@...1296...>
References: <CAGyAFMXoH2aXQwn84AiV0c=OP2Rhv6i1-D_E+RXMXu8ZQFTvVA@...278...>
	<20151220134642.GY24952@...1296...>
	<CAGyAFMW_qSWu=Y1DfYai=ENLP-nk1hebMaYykAa5HJXVfQy3qA@...278...>
	<20151220181920.GZ24952@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ocM1+gwOPYoc7a3K"
Content-Disposition: inline
In-Reply-To: <20151220181920.GZ24952@...1296...>
Subject: Re: [Openvpn-devel] XP broken  (wrt IPv6 in 2.3.9)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, ValdikSS ValdikSS <iam@...2070...>

--ocM1+gwOPYoc7a3K
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 20, 2015 at 07:19:20PM +0100, Gert Doering wrote:
> > Moving to openvpn-devel.
> >=20
> > We could probably detect XP only (or technically "less then Vista") by
> > checking that IsWindowsVistaOrGreater() =3D=3D false which seems to be
> > simpler. It should fix the problem.
>=20
> That would help with "part 2", right...  (XP has a function=20
> "IsWindowsVistaOrGreater"?  wtf!?)

JFTR, Microsoft documentation says that this is available in=20
<VersionHelpers.h> starting with Windows2000 (!) - but, unfortunately,
it is not available in MinGW.  Not a *real* problem as this seems to be
just a wrapper around windowsVersion() anyway...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ocM1+gwOPYoc7a3K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVn5fdakuBuNlUUl1AQJsvwP+PyC5OjzalBzf4dJGGQrgzF3pFubs0Kbd
FiKBzTrXrouGLhHOdm5WZAQI0ln4gK7777SXK7Titr2zyzOj/HvzbtUn78ZMaIAV
Fn1Mvdaa0d9gU8Jcb4tSsVki25y30iDjGiQseOemqT0lJfaa3ONHlKvc38eq8mWi
xs4jfWkQEQk=
=Gurl
-----END PGP SIGNATURE-----

--ocM1+gwOPYoc7a3K--

