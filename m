Date: Mon, 21 Nov 2011 13:06:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111121120622.GN8496@...1296...>
References: <1321876765-16500-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pW41o2QhbwBo4o/7"
Content-Disposition: inline
In-Reply-To: <1321876765-16500-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Fix FreeBSD/OpenBSD/NetBSD compiler
	warnings in get_default_gateway()
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

--pW41o2QhbwBo4o/7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 21, 2011 at 12:59:24PM +0100, David Sommerseth wrote:
> On these platforms (including DragonFly), get_default_gateway() would in =
some
> cases return false.  As get_default_gateway() is defined as a void functi=
on, and
> none of the callers expect a return value -> just return without any valu=
e.

ACK.  Fallout of the recent Linux / route refactoring, as far as I can=20
see - it's on my to-be-cleaned-up-List for FreeBSD, but having it out of
the way already means less patches to send in for me :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pW41o2QhbwBo4o/7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTso+vqkuBuNlUUl1AQI+MwP6Av4bSuzqhZ5Ml4jpnkZqomHuGOBynFFi
qe5sS/wlthuBQZVhLmu9wJn8rxYZaaOcNwjq6OKXrQsb+UO9y5W8jCFc1S8WIDX5
pjyysvsVQZD4TaNMICKkCDGnwrOnSHnB5kR8f3jZaZTr5aZIRFUX5XAP8BSL7hw6
Mgmei1cfPGA=
=IK4P
-----END PGP SIGNATURE-----

--pW41o2QhbwBo4o/7--

