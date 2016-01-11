Date: Mon, 11 Jan 2016 16:22:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160111152253.GX24952@...1296...>
References: <56936C78.3020505@...515...>
	<5693BE57.2020505@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0gFD7xD8qWl5Ra4"
Content-Disposition: inline
In-Reply-To: <5693BE57.2020505@...2080...>
Subject: Re: [Openvpn-devel] Disabling auth_pam plugin by default in
 openvpn-build?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--y0gFD7xD8qWl5Ra4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 11, 2016 at 03:38:15PM +0100, David Sommerseth wrote:
> You'll most likely upset quite some Linux distro maintainers.
> Especially if such a change is not properly communicated.
>=20
> I know at least RPM packaging will start failing when it detects that
> files expected to be installed by 'make install' is missing.  Other
> packaging systems may behave differently.

I would be very surprised to see "standard" distro maintainers use the=20
openvpn-build script set - as it's totally unneeded unless you do
cross-building...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--y0gFD7xD8qWl5Ra4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVpPIzKkuBuNlUUl1AQIs2QP9HI9K4m9wPVcHoKr4Cw+dUy6VdRsYKbbL
htHj8eE+v7pVgxJYJ/s/1gcTrCSevsMsOQNYku2MkxuKtorY+9Z54F3MKQIqgl3w
YZ5MFn22RLGQ8JxwVaUcJgCm6akMU1DKUQcXCdstFuc4cj2Uip5t9sULN1SiIAXu
Lpi/4Uvjngc=
=V5nG
-----END PGP SIGNATURE-----

--y0gFD7xD8qWl5Ra4--

