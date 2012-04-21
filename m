Date: Sat, 21 Apr 2012 22:34:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120421203402.GW1359@...1296...>
References: <4F909AC3.9090103@...1708...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xNzB6LhEaj9ZrCy/"
Content-Disposition: inline
In-Reply-To: <4F909AC3.9090103@...1708...>
Subject: Re: [Openvpn-devel] Windows: Route fails on certain configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Oliver <oliver@...1708...>
Cc: openvpn-devel@lists.sourceforge.net

--xNzB6LhEaj9ZrCy/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 20, 2012 at 01:07:47AM +0200, Oliver wrote:
> in the source code of win32.c, there is a static path.
>=20
>     fp =3D fopen ("c:\\windows\\system32\\route.exe", "rb");
>=20
> If the windows path is different, e. g. c:\WinNT or c:\WinXP this will
> fail. I'm no C programmer (and no windows user), but I think it is
> annoying enough to report. Maybe someone can fix this. :-)

Indeed, that code is "strange", but not for the reason you think it is.

(win32.c, configure_win_path() )

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xNzB6LhEaj9ZrCy/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT5MZuqkuBuNlUUl1AQK9xQQAumwtK04C6jo39fewvU0+4pVsHGPWpY85
htwFrwP/NkCbOzAK9YlaetAO7k72cFR4G34xCkHW0Z2fsUrqMB+lkb7WoIZoQHio
Steu3D+YfZ4JaVE1Vvb1MZy/egjoM0UMWfMOTiu+NBdK7cquYJcVj2wZJoevvaqk
TW1DS+c65Kc=
=h5tI
-----END PGP SIGNATURE-----

--xNzB6LhEaj9ZrCy/--

