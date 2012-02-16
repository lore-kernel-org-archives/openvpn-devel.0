Date: Thu, 16 Feb 2012 19:51:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120216185125.GP7024@...1296...>
References: <20120216182908.GM7024@...1296...>
	<1329418045-3218-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IoFIGPN1N3g1Ryqz"
Content-Disposition: inline
In-Reply-To: <1329418045-3218-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v2] use the underscore version of stat
	on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--IoFIGPN1N3g1Ryqz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 16, 2012 at 07:47:25PM +0100, David Sommerseth wrote:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> MSVC does not know wstat(). Instead _wstat() must be used here.
> Unfortunately _wstat() takes a 'struct _stat'. A type 'stat_t' is
> introduced to handle this situation in a portable way.
>=20
> [v2: Use openvpn_stat_t instead of stat_t (David Sommerseth)]
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> Signed-off-by: David Sommerseth <davids@...1347...>

ACK!

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IoFIGPN1N3g1Ryqz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTz1QLakuBuNlUUl1AQINxQQAnnKvJ/MgmcnjEY1XZNcOOSrmEsot6J4N
dXBzCxjuR+Dzw/zc6gXO3pP0lZ1IhkisDCSZ6YB4GZ/VJlOhG5YaJQO8p71XQTD5
x+q5EMJy2QqouJbW7QT+U9/g0na2GZbPYj7pf5X6urH0TVl6GavNKzqsxzyD4RIz
Ke8oSicfZg4=
=/1Nv
-----END PGP SIGNATURE-----

--IoFIGPN1N3g1Ryqz--

