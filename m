Date: Sun, 22 May 2016 14:45:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160522124546.GA53051@...1296...>
References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
	<1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
	<20160521095424.GQ53051@...1296...>
	<BF0BE230-3DDA-4CF6-A8DB-CABBE0825CF4@...2127...>
	<20160521111016.GS53051@...1296...>
	<9715E28C-0B26-4EAE-907A-B8A326BF98A7@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VZoQXr/frJt+kLeJ"
Content-Disposition: inline
In-Reply-To: <9715E28C-0B26-4EAE-907A-B8A326BF98A7@...2127...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Refactor t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel@lists.sourceforge.net

--VZoQXr/frJt+kLeJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 22, 2016 at 02:38:05PM +0200, Jens Neuhalfen wrote:
> [???]
>=20
> > My buildbots test on "all the BSDs" (Free, Net, Open, and they have a
> > /bin/sh which is "It only supports features designated by POSIX plus a =
few=20
> > Berkeley extensions") and OpenSolaris 11 (ksh93).  Samuli's buildbot
> > test on various Linux variants, so "dash" should work.
>=20
> Are these buildbots available vor the general public? Being able to easil=
y test
> lowers the bar for new contributors considerable.

Right now, not for "general public".  They auto-build (+test) every release
that gets commited to "master" - which, of course, means "it is too late
if it breaks platform <x>".

We have discussed building from test branches (on-demand), and widening the
access to these branches - but nothing specific has been decided yet.  Maybe
we should put that on the agenda for the monday meeting on May 30...

 - addition of new branches (at github), with more liberal commit rights
 - having the buildbots pull from github (right now they use sf, AFAIR)
 - opening the buildbot "build revision <x> on platform <y>" API for
   a wider circle (right now, I think only Samuli, David and I have access
   to that host, it's on private addresses in Samuli's VPN)

I'm a bit reluctant giving "full user account" access rights to developers
I have not met in person yet - but with the approach outlined above, at
least sanity checking "I think the patch is good, will it break one of the
more esoteric platforms?" will be possible.

Samuli, are you listening? ;-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--VZoQXr/frJt+kLeJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV0Gp+akuBuNlUUl1AQIRtwQAq/rD4GQLQ16jX9jf9wXaGBzgY06bB9BX
YdQr/KzQszw37yM+L9J/SvR/IWNk/fDFsI40kMWihEh925IQwrahi1YBrdy0gjpG
Lmml8OJx9eqGk3Nfz6Skf+UVm3hCCx7pNUuSrO0+JGwfIxT12H2xrtO1Gc+RYYN7
4NzWCf5HvaA=
=OPaC
-----END PGP SIGNATURE-----

--VZoQXr/frJt+kLeJ--

