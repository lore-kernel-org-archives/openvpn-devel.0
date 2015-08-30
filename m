Date: Sun, 30 Aug 2015 13:54:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150830115444.GU34798@...1296...>
References: <20150830002336.32791c7b.movrax-dev@...2061...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CRrRoVXEpX/Dc4YP"
Content-Disposition: inline
In-Reply-To: <20150830002336.32791c7b.movrax-dev@...2061...>
Subject: Re: [Openvpn-devel] [PATCH] Privileges not being dropped if the
 first connection is not successful
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Lukasz K." <movrax-dev@...2061...>
Cc: openvpn-devel@lists.sourceforge.net

--CRrRoVXEpX/Dc4YP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Aug 30, 2015 at 12:23:36AM +0200, Lukasz K. wrote:
> Author: Lukasz Kutyla <movrax-dev@...2061...>
>=20
> Interruption in first connection will prevent further privilege dropping

Which OpenVPN version is this about?  2.3.x up to 2.3.5, or 2.3.6/.7/.8,
or git master?

(Init sequence and connection attempts have changed quite a bit, and
this might be yet another daemon() fallout)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CRrRoVXEpX/Dc4YP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVeLvA6kuBuNlUUl1AQIJNAP+K14M0i6nqmolO/2iVarJO+32zwCdpiTP
QuOlZodj0NWd3HkFxEUKy1rn0cGfiR02F0KaglAg3mho/PDvTR/phJNcOLLqTvh0
U+FjzMeOarZvtsJPXOBeXbri4JzApjjU4+r5d904VGLF1ukE3bK3sd6kefXLLhLO
rlZl4E0mWF0=
=2LW4
-----END PGP SIGNATURE-----

--CRrRoVXEpX/Dc4YP--

