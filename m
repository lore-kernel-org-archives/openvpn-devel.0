Date: Tue, 7 Jun 2016 10:14:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160607081413.GP53051@...1296...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<5755C95E.9080401@...2080...>
	<CAKuzo_jivce2XsfJeJaY2n+NqRqUWSPkWejyHZMNuqHxGZUCcg@...278...>
	<5755DF70.8050406@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sVkLdCFbEixzdwcn"
Content-Disposition: inline
In-Reply-To: <5755DF70.8050406@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--sVkLdCFbEixzdwcn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 06, 2016 at 10:39:12PM +0200, David Sommerseth wrote:
> > On top of that, adding unit tests into an existing code like openvpn
> > will involve a lot of refactoring. The ROI on backporting any such tests
> > to 2.3 does not look worth the effort.=20
>=20
> Yes, lots of the code may need to be refactored.  But I am not currently
> convinced everything will need refactoring.
>=20
> I am especially having the SSL abstraction layer in my mind.  That did
> already go through a massive amount of refactoring to make it possible
> to swap between OpenSSL and mbedTLS/PolarSSL.  Those code paths I see
> great value of having tested with unit tests, also in 2.3.=20=20

This all sounds nice on paper, but please look more closely at what
we are supposed to *do* in the release/2.3 branch

 - add bug fixes
 - add security relevant changes, if they are small and localized
 - aim for maximum stability

there is no "refactoring" here (the SSL refactoring happened in git
master before 2.3 was forked).

Unit tests in git master are good and welcome, and if we discover bugs
there, we will backport the bug fixes to 2.3 (or at least look carefully
if 2.3 is affected by the same bugs at all).

Given that we do not have plenty of developer time around, we should focus
*development* time on git master / 2.4 - and that includes adding testing
frameworks.

Ceterum censo: please reconsider whether having that stuff in 2.3 is
beneficial, or just eats up highly valuable developer time without=20
bringing enough benefits to compensate.


[..]
> Without
> having dug too much into the buffer.[ch] code lately - so my memory may
> be corrupted, but I think that is also code which can be adopted without
> too much refactoring - and these code paths are also quite crucial.  But
> yes, the unit test coverage will not be as massive as it hopefully will
> develop to in master and 2.4.

"without too much refactoring" is already "way too much refactoring" - the
last times we thought we'd "clean up some stuff" we introduced memory
leaks and crashes that took us months to find and fix - look at=20
ad49fb5a74b2ac16298ee8383d514a950ece1097, for example.

Since I'm usually the one who gets to debug such fallout, I'm absolutely
opposed to doing any sort of "this should not change anything" or "just
a bit of cleanup" changes in release/2.3.  Bug-fixes, and long-term=20
compatibility changes (if localized).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--sVkLdCFbEixzdwcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1aCVakuBuNlUUl1AQJu1gQAkcqFUdg1hSp6H75mcHeTgavzF0cKAlGo
7ibjNf7QRpgvAqQiYLGZRcjWQZpiQbrmkZbHbZEiGBOOM2yQV2OykdmnNBnV4GTC
32uOS0F9DT9Arx5oT+oMvgI0HekNJozD7EJtRaEk8fQta3LGRjUmQWlJDtsZ6+Na
XQjxchYxlfA=
=K1ck
-----END PGP SIGNATURE-----

--sVkLdCFbEixzdwcn--

