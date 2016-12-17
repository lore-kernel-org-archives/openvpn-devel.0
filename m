Date: Sat, 17 Dec 2016 12:39:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161217113942.GT78624@...1296...>
References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
	<44d2e307-1954-de7f-9979-68728de900b3@...1926...>
	<20161217100520.GR78624@...1296...>
	<CAFHpkQGMJYrnhCZnvJZf+=c_rsYY6FxG98bO0LHqk_aNSmvsUQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wdXZ0KDsOFX3OpPb"
Content-Disposition: inline
In-Reply-To: <CAFHpkQGMJYrnhCZnvJZf+=c_rsYY6FxG98bO0LHqk_aNSmvsUQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
 compiler supports them
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--wdXZ0KDsOFX3OpPb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 17, 2016 at 04:26:46PM +0500, ???????? ?????????????? wrote:
> > The world is bigger than Linux.
>=20
> There should be high level autoconf magic, which will add option if chosen
> compiler supports it.

That wasn't my point.  Some systems are making it hard to get Linux-develop=
ed
sources to compile without throwing warnings, or adding quite a bit of extra
de-warnify-lines-of-code.

OpenVPN is not that bad in this regards, as we already take very much care=
=20
about our code - but see my other mail regarding AIX.

> I'm particurlarly afraid of cross compilers like mingw

Yeah, and that one.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wdXZ0KDsOFX3OpPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYVSGSAAoJEB2Cnv7KVigSPgQL/iZ9+kcAfwzNlg4T96VYdFGR
gATfdvnpRXqH/G4XpWInVtjavRHOa/V1/t1HHESeUAC8lqnqVIyHJP+sz87IqhGn
bwNSfIsK35qaHJQ6dQlthhpudWx2yFPuWpvHDEPfrsJRfUB0orULOGX7mQMdQBEi
NXr2oC2Y9I6R8zFbhEIInnC30wFkA5w/aA6yRCrAb1+CAmNeO6ZqGTd3dycq7Jx4
8TbUvZAzeUF0X6+9h8PPIyQv/IuuE4F+Tu+6sS2fpneSZrxeVbPgzsE3wyYOD8fw
kSEqKincSf8R/dwE/jYw2n433/gMQyKFl+cZkCatOjvVsIK/fZQHolbDge4g1iMZ
39ysjy6NcF2wkGKUaU4uqfl2Yf8jpWCYGEFHv3XuUNXK1Hkj3S0eMXBA/Ir2jSSf
xri9wZyr7e4N8vIVzpiLsGdTkhjWF5zKx6/LjE5N6p6Mn4jNMdRXsHNpX9Yxt7p4
6BuSvOIwkqxwDHDfWNEol8Jt8kXCF3rL8RrORN+XBA==
=cDW3
-----END PGP SIGNATURE-----

--wdXZ0KDsOFX3OpPb--

