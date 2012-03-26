Date: Mon, 26 Mar 2012 20:50:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326185039.GB1359@...1296...>
References: <20120326093629.GN1359@...1296...>
	<20120326095049.GO1359@...1296...>
	<CAOazyz1S_As1M7RkKw7BFt3fNwM5VOz3f7qwBdDk+h+KDVM9-A@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/9WPmgm2v60RN0g"
Content-Disposition: inline
In-Reply-To: <CAOazyz1S_As1M7RkKw7BFt3fNwM5VOz3f7qwBdDk+h+KDVM9-A@...278...>
Subject: Re: [Openvpn-devel] build problems on FreeBSD of latest openvpn git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--9/9WPmgm2v60RN0g
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 26, 2012 at 08:38:38PM +0200, Alon Bar-Lev wrote:
> On Mon, Mar 26, 2012 at 11:50 AM, Gert Doering <gert@...1296...> wrote:
> > I have now installed libtool 2.2.10, and with that, "autoreconf -vi"
> > does not return an error anymore.
>=20
> Gentoo stable libtool is sys-devel/libtool-2.4, it contains some fixes
> for mingw which I use.
> Why did you chose 2.2.10?

"That's what the ports tree gives to me".

I take care to keep the buildslaves as close to a typical OS +=20
"os-specific package system" installation as I can - and FreeBSD 7.4=20
has libtool 2.2.10.  FreeBSD 9-current has libtool 2.4.

These are not use for cross-compiling, just for tests on this particular
operating system (buildslaves and my own functionality tests before=20
sending new patches).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9/9WPmgm2v60RN0g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3C6f6kuBuNlUUl1AQLzGwQAwUK0JFdQ7gaPxMXUEHEFAyEQk1a9Dv4f
5Ag7mwm1x9qZwHELOdFjgqqo0rX4P4OLIRy4rSn6UgLL3C1mImJUORUXSatZCErW
c7DhegOaHZEBQ99cHLWrssreAXpDZadiiUSUPPGFLYL+VjjkW94MGYQ5NsoTwh/r
zGnKFuwOse8=
=pOTT
-----END PGP SIGNATURE-----

--9/9WPmgm2v60RN0g--

