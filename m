Date: Tue, 7 Jun 2016 09:56:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160607075659.GM53051@...1296...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DaWC4NIm3/be2laj"
Content-Disposition: inline
In-Reply-To: <c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
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
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--DaWC4NIm3/be2laj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 07, 2016 at 10:30:57AM +0300, Samuli Sepp=E4nen wrote:
> This is probably correct: the codebase is complex enough to cause=20
> breakage on many types of changes, no matter how carefully the code is=20
> reviewed. This is often because of the sheer number of options and their=
=20
> invisible interplay. A recent example is the recent persist-tun / WFP=20
> filtering issue, which slipped through all testing and review.
>=20
> Regression testing using unit tests could possibly help us prevent this=20
> type of breakages.

In particular for *that* example: no way unit testing would have found
that - "full connection testing with multiple remotes and tunnel connection
issues on the first tunnel" would have been needed.

Unit testing might have found the issue that on closing of the WFP in
master, the handle wasn't NULLed, so a second close call would have=20
caused a crash - if someone had thought of adding a test case for
"call close twice!" *and* ran this on windows.

Unit testing is good, but has no chance to find "full program test"
failures in certain combinations of options and remotes - which is=20
what t_client is there for, but even that one wouldn't have caught the
WFP thing as it's fairly hard to test for that.

> > We already have discussed solutions to this:
> >
> > 1) Enable developers to run the ?authoritative? buildslave tests before
> > submitting patches
>=20
> The buildmaster can trigger manual builds from a different branch (e.g.=20
> "staging/somebody"). Access to the buildmaster can be granted=20
> selectively to trusted core developers. Non-trivial patches from other=20
> people should probably be tested by one of these core developers before=20
> pushing them to "master". Or we can just accept the fact that "master"=20
> might be broken occasionally and fix the problems promptly.

Haven't we been here before?

 - add testing branches to the github repo for (semi-)trusted developers
 - teach buildbot to use the github repo
 - enable (semi-)trusted developers to push their "I want this tested!"
   code to github/openvpn/testing-<user>/ and have buildbot test it

we can't open this to the world, as the t_client tests need sudo=20
privileges, so anyone who can push a patch to a testing tree can run
arbitrary commands on the buildslaves ("just build whatever you want
into something called 'openvpn' and run that with sudo from t_client") -
so, (semi-)trusted developers only.

(This *should* have been discussed last monday, but it slipped off the
agenda)


> > 2) Provide developers tooling to quickly (preferred: locally) run
> > iterations while developing
>=20
> The Vagrant approach is nice because it will eventually allow developers=
=20
> to run a fairly extensive smoketests on several various operating=20
> systems with minimal effort:
>=20
> <https://github.com/OpenVPN/openvpn/pull/45>
>=20
> Right now the OS coverage is fairly minimal, but more variants can be=20
> added easily, and we're not limited to Linux/Ubuntu like with Travis.

I'm not seeing who is going to maintain all these VMs so every developer
can run the full suite across all OSes...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DaWC4NIm3/be2laj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1Z+S6kuBuNlUUl1AQIa+gQAt/Ikg6Q8C7nbz7zp309FbBM6QTS+t5R0
ey9zWpNzEFRRG+xdCRqswwr/jsmAUD3D+KfrVpN17ZrGQ6+NWucNkr6+QsW/qzRP
+IW2PMU4uDG+e/Wd9cBlk2+OZTEp4lie/qEpGpAADCdVbddy51jYtyTxOn1ey3EM
XEbZv0r8URM=
=Jwlv
-----END PGP SIGNATURE-----

--DaWC4NIm3/be2laj--

