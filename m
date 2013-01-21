Date: Mon, 21 Jan 2013 11:23:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130121102317.GV22465@...1296...>
References: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
	<1358411009-2350-4-git-send-email-steffan.karger@...1435...>
	<50FBEC82.2050503@...68...>
	<1CED409804E2164C8104F9E623B08B90133FB458E5@...1436...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ss/DXkSMw0UR6JNy"
Content-Disposition: inline
In-Reply-To: <1CED409804E2164C8104F9E623B08B90133FB458E5@...1436...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: Matthias Andree <matthias.andree@...68...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--ss/DXkSMw0UR6JNy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 21, 2013 at 10:54:26AM +0100, Adriaan de Jong wrote:
> > Barring that, I'd suggest to add stuff to fail the build with older
> > PolarSSL versions and kill the PolarSSL < 1.2.3 code.  It would seem
> > from the changelogs that PolarSSL 1.2.N (with N highest available) does
> > away with certain design issues in earlier versions, so there is a
> > compelling reason to upgrade.
>=20
> I agree that it's annoying, but I wouldn't remove support for an
> existing, still secure version of PolarSSL in a dot-release. We
> could mark 1.1 as deprecated, and remove it in 2.4? For the moment,
> recent versions Debian (sid/wheezy) and Ubuntu (precise+) still
> contain 1.1, meaning that it's a nice service for them to keep
> support for a while.

I don't particularily care about distributions that ship old stuff - they
can always compile with OpenSSL if they do not want to upgrade Polar to
1.2 (not that Debian contains OpenVPN 2.3.x anyway).

I'm more concernced about maintainability of the OpenVPN code base, and
having more #ifdef in there is not the way forward.

> Unfortunately getting PolarSSL to work wasn't trivial due to some
> (necessary) PolarSSL changes. We're still working on getting support
> patches for a number of the new features ready. Adding these patches
> to 2.3 during the RC phase would have caused to large a disruption
> for an RC.

Understood, and appreciated.  OTOH, the changes are not *that* large,
if you get rid of the #ifdefs...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ss/DXkSMw0UR6JNy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUP0XFakuBuNlUUl1AQIwNQP/TCvfwfP5RsCTGlmaRs0rTqQaKjKyUAuQ
cGNUh4WA5lEop6uVpiVdi8zaVY/nacz7AzqO5oTsV1qiqc4QzfUN2lnkjSDQZzhB
3jl/e7gIdFk64OuKvyIycN632hkzDGTVc++OwNNt2xR5nRINtNLyQQK2mCJPH5fa
TfWtrxatwI4=
=NJPh
-----END PGP SIGNATURE-----

--ss/DXkSMw0UR6JNy--

